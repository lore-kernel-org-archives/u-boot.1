Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2516606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ztEXP4tB;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NVbwoMVM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFDCB608D6;
	Thu, 22 Oct 2026 12:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPBft5I5vReX; Thu, 22 Oct 2026 12:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 249B0608AB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673746;
	b=o4XFuFlrRA0+OHLIaVhD07R+88oS3rEys6KlrTpTR1aA+Ea2adRKi1y4XBBUMEZvPK9e
	 Z9WssazGVgR3sZyFhGZytQ+JXQQtvGTJjDVt4ZNQon2p7Ky903nGNhM7ZnumIAv7uZQCv
	 yxozLLjEl/ypZILsOGZgBYmgJNKyr1qpTzYtuj2zKo/4IKUvqI9TjvZJtSRzpIQZXlehA
	 Nl93lX7oIz2XrHlFcRo3zoz3druHHDDO21otXIqZ8Jn+fiRLRC54aRsflap/kyh+OFvRy
	 iRGPHFpbBMQvl3pEsEaqw3iGrtEjYFu8VYUtxRZ5DiL4UqRZisp93gdlaqpxg8J93PA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792673746;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KCIKOmNpSom8TVH6MYav7PEqjyMb1H8eTh22Zct+7qc=;
	b=sSmvN/ggdz+nCsGxLzZAhV+yYMBx6+ukM9mnyu73AOlYsV4GLhh9HhlmYi12Uv4xyV04
	 3roWwouqTRbOJCFklwE4f9fIrZV3XN8UHxGO/6t2Avrj26jt1b2I2ejC56An4ULdNoyt+
	 afqO9Ps3vKCcTIgBgcrJ5BvfmhEAh9EyT8xGhie//KI3xjxFSK/d5jt0zBx9sSCZ8W0F7
	 kj2jGgjgTppt1Vj8UPS/aazmUzuty2wpehrliSUIlDMWZ5OXHn+1WUYfWEaKIDvCEyM1L
	 wBmP5hEqsB7C2uhvByohFFrPjxNDFM2Nf7yhZK0Vg1OJSH7hbRQK+nFeyHVmMb0NrUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NVbwoMVM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792673746;
	bh=KCIKOmNpSom8TVH6MYav7PEqjyMb1H8eTh22Zct+7qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ztEXP4tBSFaLXLw443Tr6HH8gMHXPX0ere/JDugdFgfjw9SzT0tH0CsjX35626Tgs
	 bb5MVyQy3LDOXcIxwNj5VE8IPEij1xZbD28aLRvranw5Wdtx0e4Mts7YMg4/pEDEfk
	 RYciUL1ZOmoWamuvaxapL1HuMFcK65c6XvwS6MGdBRI/x075hL1Cx7q5roPWMlh0yW
	 wRa+l+yNCgLrG8Tx7b1VyU35cvK2h+7FcxRUsD4B7J5cY9rD/Aa4ZLVMUkgYq4Uk+Y
	 AhP8Yuo2kJRvR70DRlQv+T41j6zWNGAq0fo7HpNyo7RFopzP5TNGaf/JrcggOlaoBj
	 yVcxpCu4bReBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 249B0608AB;
	Thu, 22 Oct 2026 12:55:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B7595C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A8316069C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xq2aHmCyYCR7 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B0D50608AB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792673742;
 b=d/daQWK6Zb0XFqZ37I7r/u0Tyj2HkkbydOpPFLjxwGxxZlc030T9BV0oWtRTcgh0RPZe
 RCq8lg76Ff6hSbmAULZAgiPtXUy9bqlVjqm+xxAsR2HG+D8pSbsIOQy7tSvk55I/XZLzg
 5y5t3uIMmj+JixT6Uy7J0LioxFg2wUNxD42N6iEtQYlnsy8F0fGLdqgQRg0Tu/qZ/r9ml
 SNq7Cljhb5IvWJvXycarEG6RqSvq6gCrvt9cZBVMrAzXUFDCeydgGR9cDCYTTjd/YMpcO
 uT8QFFrTDfnhju5LeFoCFxN6KBXH6bEblfRetbE46W4OQEh5t63ppnClY5j3HxJOfBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792673742;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=KCIKOmNpSom8TVH6MYav7PEqjyMb1H8eTh22Zct+7qc=;
 b=FqBALh0SSuUifu0NgNKUNhW4SHT/HzH0HP5NIoBX1A4Baub+j6n3ullit9pvVhOnl8sk
 TJSRa1SFCcPzD+eE7XD5b11o8ZUQJWkVcSYjvo3Ls3eekX6kkZnWJal1g4hXqHq5siYO3
 cIjNZNPjYfLQlpev1msLKtmKZDbUIwCcMERYX7HWJI+8NOJzJgvXRRaY6xrKzaWAvdsD+
 uuwS7jJRSCb3z3i+LwHuxbS/XrDCVmO9C9HX/BmpnmLqBIAVpTCXU9COEzIJwPED2IwPh
 g6R16wht4xK3W7cQNiCXqlJiaucX/nH/yQ0Tu8oc1QDg+ewPZwupKYhTKpGFNAGscdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NVbwoMVM; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NVbwoMVM
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0D50608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:42 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j9R2y73xgzKnDD;
 Thu, 22 Oct 2026 14:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792673739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCIKOmNpSom8TVH6MYav7PEqjyMb1H8eTh22Zct+7qc=;
 b=NVbwoMVMoZaxMK7uPSBamlti1Q0Ne8icMJHo3aq4FZyBBP/ERKgmsQ99ZHhpuSfDnb0M3C
 27WJJjVhS0TmCU0uVk14uaFdAWUavrfF63erTVJ3yeecDFfBEW0ewTKEdciTZGpUsHOAd7
 3TkGnEa33JLGaXNuUqvnywpx9LYgUJBo6WlJkq4VEPHOobuX+lSPRVBoyjh4r8qboY1VJY
 jJl0T58gX7mNE1m65qlinK5LT6gkLxlKTnNZ4o03mgsPedHwszId67UY4prnqUVU2wUZHM
 zHNnkX/wKhkbYpLOzwdVbpiVf9QqB8vpmqqnP6Wo2q6TD/EGb0HUbcRDUdhJ4w==
Message-ID: <e1629f68-5003-4549-aee9-cc22c1e51f7d@mailbox.org>
Date: Thu, 22 Oct 2026 10:39:55 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] usb: ehci-vf: enable the vbus supply of the port
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
 <20261022070900.616265-11-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261022070900.616265-11-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: sahusdfedknbse4mbie86nyadhm4eszf
X-MBO-RS-ID: 56aa534c6d43f23f93d
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

On 10/22/26 9:09 AM, Mehmet Fide wrote:

[...]

> @@ -42,6 +44,8 @@ struct ehci_vf_priv_data {
>   	struct anadig_reg __iomem *anatop_addr;
>   	void __iomem *phy_addr;
>   	void __iomem *misc_addr;
> +	struct udevice *vbus_supply;
> +	struct udevice *dev;
dev goes before vbus_supply (sort)

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thanks !
