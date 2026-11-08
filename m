Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B0606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EzVP81JO;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=K82IP75x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D60F180E8C;
	Sun,  8 Nov 2026 20:50:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bH3jjxYDg1V8; Sun,  8 Nov 2026 20:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 325BF80E95
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794171045;
	b=Yh42e9UgE20JjpAMrp69TZ/33A4XSYdls/Ixyjn1L516knf3arMy8Gltg5RH9Wthpl3K
	 S3iGo13YbjoPARW21g4FoTturMOX428oTbH1lihT8wV1iDnNggmCD3dvzkjDoHhr7SkmM
	 HCsb4Vu9wHdTDvj6RwdidQprAz5XltYoA2M0O7iW+Dm+rVJs5am4WS3oX1mpOz2M+AfpX
	 9QuOsX7/iQwHMjp4lPcUjLl0h4zOlZmnRs2jFJHXESG6MEbGelyPN+kgWArwEuZOfqQeM
	 qKNFcx84WhR5x9+BTB744kooMvd11WBXUry0YW77DUiUfQF5WtDO4Ub0HrnUhByj+Uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794171045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9p912ZvGBp/rPNZBKigt1IN9C/cIO21r4ix53l0xbhA=;
	b=q6ffqgQ7mnfTDjsoLYIFrYaqv5+vgL2wFDm+36xIrO5SKHFt6IzoTjzF0YqaU1LVhAyl
	 PFTpSk/w1fwr8HeLZ1isb/4tYb3wp8jLbnmuF13J08u91LbKv1CWLCOk8wtpAvWpOtFqj
	 TGHteiwC+WKut8kwoLXWOJUM4rbqMgQsI/5tIdsLFTclDwkCIhebrXGSHP6zm1E1/9EYV
	 35QuYYmJWQ0DvzvU0FgAfVELU2lq1OZ8rYgC7Q/GNbH3G7CLRci8/PX1H4heTOxP1f4TM
	 KZhBXKmwAmnfA1nY0fSVc/XCPUN+VWIhRGINMGmuBr4yri/6i5nRgAtItzWyJYECEdQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=K82IP75x;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794171045;
	bh=9p912ZvGBp/rPNZBKigt1IN9C/cIO21r4ix53l0xbhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EzVP81JOVeyFg8uw707E+6H8lczz5qcuphZJHL4no60u8Tlfsz3L7m9Hm6pwBqUM5
	 z0tyMOxKn6mcFZCteWWQ33VKslGC+9+JOwAWR7EDIHktUZ+Qaapq6ZJiQtzIc0IWte
	 lXKPkCv2nau5S7uFqGErft6GhUEB/sWN0I4MDd0r+3qFh9JbohBpSO8uW0OWVG0lfk
	 YyFBDXxAe+3uPh/rK+3X3ANoN1NuPHPq/tbF9/wh8mzkiFViOY1tsRHTCjmObJ+TUB
	 Awqk8bilf0HWBu6vVJXxBnOKVEhmEzxrGWTObPyvZnuUMnKAfyc4YM5crbdGgwoPRp
	 VhUI1IihsUpBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 325BF80E95;
	Sun,  8 Nov 2026 20:50:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 639A831F
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4937F80E95
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZ4UiPMRQF5j for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 20:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C68380E8C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=K82IP75x
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C68380E8C
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 20:50:41 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:41ba:50da:6236:7eea])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D6439B0055E;
 Sun,  8 Nov 2026 21:50:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794171040;
 bh=Y4tRGBQp5qzAWOzFqyqi384m7xss9IAiPZznSPUmLO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K82IP75xHXDmOURSsbu3k8Vzf7fgwvcYokV9cJTL2v4kP97bW6UxYDzs0UMVYm8vS
 8x13XaObb/KI142KvAfbG3ycxe97cInLou0X2CDD3d6OFy/sqR1ajwTRWcGJPwdn+q
 jpess4B90od0/R3OTbI6Mgxil0f7khuUgehCTvXBN+ZBHD/MlJG5M9xf9ISPu1eNiA
 n4flyYdgNaWS/+kZZ49ISvXb9Dh6jVxYTr8YWOQ/8dyiAVIbt+2uk0RZ7CqNL4ohhN
 ClGPWxO7fR3SsgmmSUeSbZjn/5HRw+KZ+mOCz7jD3Hpch0mwiNmMuU5W9tPVPskJ+s
 P8vyXvH4QHzhg==
Date: Sun, 8 Nov 2026 21:50:30 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
Message-ID: <avDgloDmuQcYP7ec@L30177.local>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
 <avC2OzAeGxqVsJ2v@L30177.local>
 <fdee1975-8f27-45a7-85a8-2405c29e1dfe@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdee1975-8f27-45a7-85a8-2405c29e1dfe@mailbox.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> > > Upstream your hardware support and you won't need external DTs.
> > 
> > Even upstream, how does it solve the Yocto's and Buildroot's related
> > issues ? Both did try to workaround despite they are all upstream.
> Could you apply a patch which contains the custom DT instead ?
> (using SRC_URI:append = " file://0001-your-dt.patch" or similar)

the patch has to be redone, again and again. That is what Buildroot went
through: see [1] or [3]

For Yocto see [4][5][6]

Both do hand copy ! config/git management is not convenient neither.

> 
> What is the use case of custom DT injection like this ?

For example,

 - Bring-up. The board needs U-Boot to boot before its device tree is
   anywhere near upstream, and the .dts changes several times a day.
   Pointing the build at the directory beats a patch per iteration !

 - Linux sync. A DT that is upstream in Linux but not yet in U-Boot.
   dts/upstream follows a kernel release, so a board whose .dts landed
   in the kernel waits for the next sync.

 - Board variants. A carrier or a memory variant of a supported board,
   like the VisionFive 2 8GiB report [7], needs its own DTB but is not
   something U-Boot wants a defconfig for. The variant .dts lives with
   the product and builds against the SoC .dtsi of the U-Boot release.

How to handle those cases + Buildroot and Yocto without such proposal
for uboot ?

best regards,
  Vincent
