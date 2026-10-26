Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140B606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a+s5FHVR;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=upkCo8Nt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A2F24078F;
	Mon, 26 Oct 2026 18:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsoWKgk_Y6Ls; Mon, 26 Oct 2026 18:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D38D4407BA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793039147;
	b=koCQWoamY6EPwNzgH9Uoq+ETru3f09pdUE7iXBG1QVer8f2B640edX2LgJVBjNJ3iCdv
	 nDTtLlkTPdHlAX072wlgB75cIZipgrJ/B9g/KkeGf7YVOoyc9YucK8nAf3WWp8/QMW9mi
	 0wKmaDSCEBkT211uVOmVv+xbhiCW/JpS6ScpUVcSx4rkg0NVg6jMbVAUfSn9y9A7cSsZk
	 KKvTnJ/cBfFV6k9MRMnQmjZmcf2iTeTVo/fG+GgSf56g2BY5cuHtXFuW/7JsbVTKX+Zqc
	 k/Vxuw25kBbCOVbeBzJw5vw4TbzhR/0Fmp9PwqjAFhmmwOyrV4jqI8J50bV9bng5H+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793039147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OLzMLdn/TpW5HoGJPeEn/kn+WLb3QulsiWW2FD9iShQ=;
	b=ooYGs5+o+aMWYlNZ+iVMH9e4a7z0I0hg4Zj0scID6uLcYiIynWtgM36xb2zY4rEwyiF9
	 u3sobI2Ei66sQvK6gCyJufF9J0UTjUUWzuHajL2fyiQandDUAhMwYzvvZF8nWH+gpwxZq
	 CUjebpvuzgkcIXUiSASS6S892h6tCIoQfZFnaLCrCtppU/TQWc+QhnvmbY7wAiZ9xoK/6
	 GBelWCjxjPAmdrVIav73WwGljkuh57ca/nafFNNYtnoeHf5KUV7cYpd46vVze32AtqNJG
	 kDy0yEhmD986Xv3GiI0Op1D8x4oJwwOCkYYqZHio7qbmF6DjcC+129QS7a89hJpnT5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=upkCo8Nt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793039147;
	bh=OLzMLdn/TpW5HoGJPeEn/kn+WLb3QulsiWW2FD9iShQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a+s5FHVRiF35fL6vxABTuNR9d1t2589sEe/x4K13/w/VaONYM6SUWykB1/JnBgPkN
	 yuErYJPXs3cwsmlI2vw6yxbJ8LRnfri0Ns3ZZ76gyJOuc2oKTQ7fV0wLCfuq8pZjNG
	 /96qbJWM4XVUCZyq1rP/1MkcLLjuxsOa5tDw0FeV92WZAVOEIvdf3nMmBiS265Z8ZZ
	 NesaXkeJFM9Phbk2YSTjz50z2v1Bcmqw+Vi/GXn8h95wd5EdqnYhFdUr/gvMVz1Cac
	 2duMG/i2vBip5AwdWLYzzQauNscWPnw5Ip4qpE7arCGA3F55N67WzmRS66RzTqz2Y/
	 IddaVsE5IaLJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D38D4407BA;
	Mon, 26 Oct 2026 18:25:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 230D72F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14B74407BA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSImf2qqKiwH for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:25:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A526A4078F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793039144;
 b=eaKN2OdI+MyMtx/dw7M7FgmmHF3zLOtxgH5cbdyJWYqF/4iJc2q4iqR11xoXe2bZqQcn
 RLvz/XLTkQ56pLokaOkxgyRHVcnYWS4TOozpkl7TSERblUqlAxg6k/VyKry1wCf2V4Hnw
 3cjoKEa+H6VhtgzrgbyyfIk+YLXg2v06MccCuSo5OyWUiphKGtJjObHuzmfjyPQETVIvn
 lAkX84vrqwi7q/zutkI4FrBEFv3ZOCFRzlwN6MmV3oOmRzaCpfRZmT3UThS8yp2D7WV8S
 sIDKyHQSX8c3Yf5TgIiAKa1WqHCRoVm4Fsdp7/uzRD8O8NfVq80zE/t9KfZznjyFW/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793039144;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=OLzMLdn/TpW5HoGJPeEn/kn+WLb3QulsiWW2FD9iShQ=;
 b=AE6huAPe/+FtJoORh/EKhBzNzX+pk0lNt/0ri4ZJEKegnDVDmwgwCbhzx53+KlW+IudZ
 j+QR0SvrcKGUfeJ9RXW75Hr6WOeOOpabVBLKHmf7Q5QxAkCy6BHdj8A9ILO+6BGqAtGOH
 WBu/9lZoni2oQ9VZaXb0CtfHHBU2xMFJAUo96hCqOiSJtnkODjeve7D/Yi0FrZG7NtMdJ
 0MuS7lVsLWEBLDt4t0OXkkBg73p4Uk9htqi5bRi87qDe4eqveQoQj+mBwnvF+YFHLE342
 9wMgRB63Xfa0eSFtIWF4wAwRyjM5KSemPl6fFbXiVG9Z7NYsZ2IPoEv6sU9UsGG8y5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=upkCo8Nt; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=upkCo8Nt
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A526A4078F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:25:43 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jD29v5lsFzKnBr;
 Mon, 26 Oct 2026 19:25:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793039139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLzMLdn/TpW5HoGJPeEn/kn+WLb3QulsiWW2FD9iShQ=;
 b=upkCo8NtZ9hP2QxlzgzBmXn7FQer41Qh+jlMJoSR0MGzERy1QD2TAjX9UXrYpjzbm6azuc
 az5glFkIkWXLzvOiWB2aT+sB6hniPZC3pHovQuKIY5fQAyUSSAEBDAnwAjOS3goerozh37
 wMQovA5lRqvYLyHupR3nw6k8R7ugI8E7NZ6cvQdB6SZ0PQeYUw1dg9CfF8dmdpDg219W93
 lSe2RVzlrJNuDz6kLsWGk4ews04b8xjJTKUQd9IEDGod4P/CFGfQjA8YI1KSFTDNnqY0Tl
 3HG3e1fhgXyTo6t408f5xE7QXfcByj3nDFxxWczq7Jcv5YzKURClawWHuA4GkQ==
Message-ID: <ac90ab9b-35b8-45ec-a932-3f74ac26d78e@mailbox.org>
Date: Mon, 26 Oct 2026 14:19:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: onboard-hub: Add support for VIA Labs VL817
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
 <20261026092432.769146-2-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261026092432.769146-2-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8priajp7tbs9okjb1e8e96eq5o5oxmo4
X-MBO-RS-ID: 7c3933699cf355fd077
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 10:24 AM, Hung-Chun Tseng wrote:
> The VL817 is a USB 3.1 Gen 1 hub controller with one supply and a reset
> pin. Use the same reset time as Linux.
> 
> The Milk-V Jupiter and the Banana Pi BPI-F3 have one in front of all
> their USB ports. Without this, U-Boot leaves the hub unpowered and in
> reset, so no USB device is found.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
>   common/usb_onboard_hub.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 0684f7bfd..0ed70a6ba 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -289,9 +289,21 @@ static const struct onboard_hub_data usbhx3_data = {
>   	.supply_names = { "vdd-supply", "vdd2-supply" },
>   };
>   
> +static const struct onboard_hub_data vialab_vl817_data = {
> +	.reset_us = 10,
> +	.num_supplies = 1,
> +	.supply_names = { "vdd-supply" },
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
> -	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
> +	{	.compatible = "usb2109,2817",	/* VIA Labs VL817 USB 2.0 */
> +		.data = (ulong)&vialab_vl817_data,
> +	}, {
> +		.compatible = "usb2109,817",	/* VIA Labs VL817 USB 3.0 */

Please keep the list sorted.

[...]
