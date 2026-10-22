Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC1606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OsyRFTHu;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHRcUHtk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CAD78127E;
	Thu, 22 Oct 2026 10:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Itg4Ynt3ar4; Thu, 22 Oct 2026 10:52:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB9168126B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792666346;
	b=tH1/khmHuBrhsDfgGS1i7hFQrL6q37h9GePBnKSQVAkBtGEK5g/M2gin12XwQCoM+qRF
	 hHlZwxUNhEo1ZVC9+yzF/auhEOk16Yp/+eELw44zNHMUuqjM+e0VcJQJqqYMCqJokT3Ec
	 HNH2B/0L+w7EBbjRE+viGRYgZNyGfTQWvuxhZ4O9ahQusYfl/fLx6nlJ05cjTB7EAyF06
	 ee6tJ3pYpfULohc5P2Cn8qQmXIPosDoEQy/cnvHX9n1Io1o5oyhl9PTBuQoZ+rvjIVIWD
	 BW5V4IEodDR2RDO+JfQ3J5NWWvOYZomM2+dwDXhq3wg+Rn2+7l5fZCDgzb7e+4KirRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792666346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6MuPUwyArM86JMwg9ZlZ4yIHD/cWJruNd9S0f01IiQs=;
	b=nF9x+RDOv6ogc7rHcQpM0BpGszKvYC4nYklKCQTBoSXQiRyjyXfZcmS1yrkGxysJlpo6
	 OHRldxAHXqM6McSNgNu2kCmY4iKsPDKdO6G1snOQXM7Chw3NXYX7p+Fb4lg7CQHmrhNR3
	 XQWrzooxrx/Ke5L4R1ztvswLE2Y8bQ4U0Wfq6MTvNMqero3+hx1GVb69g1Zs0bAAXwcxT
	 Ptf6/ntlAthSYnKWdPXgEynPXpeXkc2/+brUQ6EFsE67ffHJSRgxPksMwfhH+hp4ZbctA
	 ky3ZFA21jkWmDc+qXQIBCO0hka025uRF7WxdF1BEWvCFyBS5wToJne8DHMHXDnGBsuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHRcUHtk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792666346;
	bh=6MuPUwyArM86JMwg9ZlZ4yIHD/cWJruNd9S0f01IiQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OsyRFTHuxfcWkV/fiquldOH5IGdJNJitOMnq59AJBfSLz1dDq1EwMR0+EEWGhOMaU
	 dSciPNkRVK1izv+9oCKcaJ48vyY4zi72XfZt1Vm3eCmCaZhBkvcaC278sWIPDykR+Q
	 gGKdXYCIxqKZXPvL6fCbTCzsYgD+rZVOTF1OCl1U8opgtKumslMidsomakFh0PSOmj
	 eZQG59TqIO07hHJWnTooJj8kCrePH3ZrxPsMIRRMdqWTB9uYha1+CVHdPJEgJQekl3
	 qlv5WIcEFIGZsOxlQKCY8f0hVFHq6EbvxSrsC7N6w6hpcftNxzCJUsqVZ+SFvKaqRK
	 7iAjJ55JoFhqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB9168126B;
	Thu, 22 Oct 2026 10:52:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FD5295C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E97128126B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fdY68ERkzFc for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 572BD8126A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792666343;
 b=ZJR/AKX5z8k0XSLUA83O+NVyFvuiV830s/C3MnWfzaMArnezJzCQKnGI/2D2cAqUKGtO
 gnCBbPLxzqiJpg+l+RkT7XBmFM6D97M/ugoef6tHwCjtDbjvy5oFDdYsFw2m+EIDsFo0x
 d2i7oJ8DM4PzTJvG6zq1gh4pKt8QMAKkp4xSYDGdTicos4mf6LRbesDKg3zA//HNdOdkE
 H6QRcCCpp3rgWktwjnsiulorbc9CPwvJRsttU+fMgdmdlOVx0DXCpCOH4Evl/PmQjJv0w
 vJbrLkEKKDt0a8CERK/U3qGykaMJVIMTAMDkCwOfqG61+P6jcTHzsHvB6EWeFehSaqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792666343;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Autocrypt:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=6MuPUwyArM86JMwg9ZlZ4yIHD/cWJruNd9S0f01IiQs=;
 b=a1qAD8nmmRz4npy0i0pKbfvIl6AE2dvZzq70WG7bIG4+XnYP4X2AVr6Puc1CVwS+Kht3
 RwnuQT0aq0uUGiEA0/BjO1uZmZgdI4MDy5m6s5fIgiY+COoHV2l+yg7DFqnHZjhan/xzg
 TRwkBvF0FzMFiXnDUPGjKtUPiSquNINzJrrOgRfZVzq75vRwDGGif01wjD7jM94wmZVCf
 OF8F6pJsL9P9pRQLZTBgk25x6JTTvCgGHGX3Idzn6a+bBuH16F0j50n94uU7A0hMvzo9m
 +2O9sdve6ulzVYMcvJ07YaNfZkWq8UoU+ZnwZFkv8sWMp8De4uCDLl7ZNlyr3FDjjrw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AHRcUHtk; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AHRcUHtk
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 572BD8126A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:52:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE00940885;
 Thu, 22 Oct 2026 10:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9B41F000C2;
 Thu, 22 Oct 2026 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792666341;
 bh=6MuPUwyArM86JMwg9ZlZ4yIHD/cWJruNd9S0f01IiQs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AHRcUHtkkLQRuo1bfhgO4LHeWLaVQgwkVgzMR2kIUyuIv4gyT1xsSXEFc/wHnibiO
 LxZhXDYedPW4EI1XbmhwO0cTqmglmUV4KOIl0fh0Pq+8gFI2winTjGLLZ+HWIudZ0Y
 HgduiBch79/mxNifEew5QQt6XrezGOAk3bN+nlvQ/f/NOLKe4KRPhd5xxkm753JwUU
 R6vt4hqUQKcUHO5pIFiTt3Hdi4n8sRsd1gj2CTqlN3FBy7PF18ABFf3WOeTwOP6ef6
 oREuFukf8TdNYDvNTP6ojDI4rXlFmmy2lphP5Mv5K/BQ/ymPnEonS/TYJxKAvSiPEp
 YnWXEAxjlYX7A==
Message-ID: <1410119b-e8b2-43a8-bf57-7db53be44eac@kernel.org>
Date: Thu, 22 Oct 2026 12:52:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] usb: ehci-vf: take the register bases from the
 device tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
 <20261022070900.616265-9-mehmet.fide@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261022070900.616265-9-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 09:08, Mehmet Fide wrote:
>  
> -	phy_addr = ofnode_get_addr(phy_node);
> -	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
> -		if (phy_addr == phy_bases[i])
> -			break;
> -	}
> -	if (i == ARRAY_SIZE(phy_bases))
> +	ret = ofnode_get_alias_seq(phy.node, "usbphy", &seq);

Just for the record, this looks like undocumented ABI which would not be
accepted in Linux kernel, so you won't be able to use OF_UPSTREAM.

Best regards,
Krzysztof
