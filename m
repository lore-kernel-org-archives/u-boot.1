Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C3606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NpANtBaI;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=MWoWd1rU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A07180E55;
	Mon,  9 Nov 2026 04:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 649GPLfe9O6U; Mon,  9 Nov 2026 04:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2C7380E5E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794199174;
	b=Y7Dv86Qpo+Tv8MIeYBlm6dgzpuntLcaGpdCo6l4yvI61yPlxT9vnPmFY3VhjWVJXF4ol
	 +12eESC0pfjHl909GUxilnXs2a8v7lBm4PBXsDquQ7Hu+i+chkjJ44wC7YE7FAmGUXg0D
	 iOEp7vumJ4NNqTswN5L4l2TH1QrLl9OQuhbQH+slYPfcm+5GwB4ycmLhRlpxHsYaY1Awq
	 ncZCuSzi5es6dUUddWWcVrSyFSoTRtqTTwTSkgt2cr2jlYdHdc6RVvv1DTdiKlqPQWLXW
	 Kzg1jJRMtl0BORPNz6POTHftIEgLwoa9MqeQ/UcdlAbvHoomEHRrlhEU+cya+WXoxXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794199174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2RzgycsgS2h04Ctp/vfBcgjAaeoJ9hCo2Lo2XrHl+xI=;
	b=TqazDlnFbcBZEuufItfKOniVRRsmjIBv5ENaE2jgcwXXwt2ZE50Io0n+93jQ2hEdUaYL
	 813PnLpKAINZsYtSKi7pAHrcmNVMeTzod0vKaTYXZX05UHfJl2yLRtPEZM2Bd+HCKxWlr
	 bu3ftgBDSqUsMISod4RIb7GF6bxkCztxYLsAqTRQkhGYJDubNxrLnzDLzxLF5MgjET7Na
	 DfobAqZHxZxxWKYcAnPDFw3KG6xQfaPJuc82RbD9P0bY1t4rPZRP0emagFWsZK0N6PP17
	 E320rGa9i+z/aM4cRITctPludnfs6m8Z11dLpnBPBu52Aw+VQL736IifKKqoBu9qdmw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794199174;
	bh=2RzgycsgS2h04Ctp/vfBcgjAaeoJ9hCo2Lo2XrHl+xI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NpANtBaIm3eg9y/FeJaSz3L7rXS6nqy74LqEFWE3Jn4/x29L/bsckxO89Sht2B8EG
	 KuUVqsLwGTC7Xuze6SrBZl5WU2CidgeQdzurVqLcq1kg7gAUZyFVj6ZumftX+bje6d
	 UFau+hsMQgBi8X6AQcbzEgRbDVeJ1vDPIRehjte9Mm7plNIXBwuLU25BycP5g3zSsX
	 b2+/hI61/g9LERA2fOGQ+BRFO1QoJRhFg7A4raRo8WKUMSSyMcn49Z0CR8Zz5W2dRI
	 3gVz+ryNMlMtFc5oP2lwZ1iW7i4iEuQYMVjYN+gVIQO3AY84a+br9IAH9aFNFSmK4g
	 UUfxCYoHi0uAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2C7380E5E;
	Mon,  9 Nov 2026 04:39:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A95AC111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A8E66067B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ci1Tpo8h9H5w for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACAFB605EC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=MWoWd1rU
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACAFB605EC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:31 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jNHB75mjJzKnCN;
 Mon, 09 Nov 2026 05:39:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794199167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RzgycsgS2h04Ctp/vfBcgjAaeoJ9hCo2Lo2XrHl+xI=;
 b=MWoWd1rUNtoxvch4os2+WF6WsVwuUv5/vZRpNPDB13zgZVBd4OPAjpkwsC3VWBy5sjlceR
 d/kQ7USvo5dI99pB/gy0FrFePy/+0HFI/cteV5NKaHTFaEQqrtEx84pcClC4/RVL6twk9C
 SaFQddNzSHccWHuoapVML7++fjMmVLFgy/lscdoAVMgO6v1zSJQi3+NA7yaI5iQ1JxNtlU
 2pvh0FjE4rfl94x2IbZn00g3Gzl2Zqd53ZV9L+gSXLhNms86sDEjTs8mRZU+YxIpR8hGGo
 E7tBJ5UDIKvtpBUoh1SK98GWi9RxuRxfD07Wh3aX8Tbu/gSQE2AQIv2mbK3qcw==
Message-ID: <371ad60c-9639-425f-9838-363b3c82f7be@mailbox.org>
Date: Sun, 8 Nov 2026 17:28:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/30] usb: dwc3: core: adapt to the U-Boot APIs
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <20261107072224.3492260-11-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261107072224.3492260-11-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4c033ca778c1c3bc741
X-MBO-RS-META: 5yzzgd4d85hm46yq19knpfmiqiam1gzb
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 8:22 AM, Anders Roxell wrote:

[...]

> +++ b/drivers/usb/dwc3/core.c

[...]

> @@ -274,7 +273,9 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>   static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>   		struct dwc3_event_buffer *evt)
>   {
> -	dma_free_coherent(dwc->sysdev, evt->length, evt->buf, evt->dma);
> +	dma_free_coherent(evt->buf);
> +	devm_kfree((struct udevice *)dwc->dev, evt->cache);
> +	devm_kfree((struct udevice *)dwc->dev, evt);
Can we get rid of those type casts ?
