Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3A606A320
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xWqCtC5L;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FQoL2Icm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80F6360841;
	Tue, 20 Oct 2026 07:56:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A4e7NqcruKZZ; Tue, 20 Oct 2026 07:56:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6E8C607FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482961;
	b=eJJivfs4x9Azi3KXVjoPi9X+20PlpOiohOHPoVBWWk6bK5F7RZl4Wn/W1xw9m+Mg+7m6
	 pTb0qg8U1xlZvN6W4N+PWXPa37bW4XFsYP2sAacwCfPJ6cgs3ZJB8LrUjeBlwsdgqnMBe
	 CiHkeudQtFnmhgVzI6PdoLM0wkEd93kwN9D+lQqtLCOprUIzrEs5OfUiaDnZUmThPiXNg
	 x6FiVF6TTUxc80jEFhrxifIF7Djj1v2gAhQz0bNbkhXVGkEKWPUKofwwBGWykhCgIzH2i
	 JVxO9PbzqFowZRyE94thtfXd7zUkGVsayUUFCrr5H45a4mTqKgUJWo/qmebX3ls1DQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BID6gOfDklSOnAGssHrkxYf2mXDitEG12q+FQcbHK34=;
	b=rPdGic7efzqrFoUzRXz0SFyhrAb1h0q9meNKX1zIsYBV3XB8S2Hd2oQxRCy8DenlEael
	 XPAbrn5tpe8OHyjFsvAX+TCsNRTxSj1dD7AHu4rVDSNXjplGSY9HSQHoPdP1rfJVSCFZm
	 3fglXncUVok7g9XgMkhvQf+4YqozwYINb4hoSEVpkcQaDrQmDOtfbU/yKoxJsK1q33d11
	 Iyssg0HUhHmFw/CksAddrJKahPn8bk8UXmJZeWFWTrJ1Y9RjPrj+lvFQMR9Mp0j6J72QN
	 cZpLNsftvyydpcRe75rD5TdkKP37HVYdCiQv9N4C8MBf5pv28EsLxFh91zigWR1BHug==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482961;
	bh=BID6gOfDklSOnAGssHrkxYf2mXDitEG12q+FQcbHK34=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xWqCtC5LlJkXB8RA8AXIQq+k5XbHItuEIUZGDMq/VbkZSGrJqx6VpwnyMDqDnZidv
	 lrSwCqog+ntQQ0T1HQY6OHkz9ePTj3QboUYipdJHpIdM9p1k286nr3+AMzBFLzUHWr
	 INhYlUAJylZyMjYgtEa4niXM3+M8T+V9FKu5GkP804Ot5SvdnGwGO+yaknNcY+Xn6o
	 b2tQemqYs8B1bmSHi/Cs7qlMDRacJiHd0Q1Yi1Uu/NyUIxYUfr91fZdhU8nLXLeQuo
	 ktawX4BEhkOE3L9N/ImpdGim18E9hut0sABB5nTcxPJRWn5CGhy8wpaYJWcuSgEFEP
	 7Ly3WdUEXLQaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6E8C607FA;
	Tue, 20 Oct 2026 07:56:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAF2C23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA49C81006
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:55:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3ySfHCcgF_b for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF5A080FE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482959;
 b=eaSEK1BHPyQ3UTuUmw0qV/a/PtCZmXXyArFIWrQRIkHPb0J72Cy/URSOivg03DTCcVYx
 //615ismHgBJde57Vr7UoJR5gJhwhBgiz22d8fE6NSKmiPeLJqkFweBSgEDmSBrVMZ24x
 jPLVrNaiwiEc/ShfWRtrXyPOt6j6aNJ2wjIp5Vq+RZGd4rYeN/rKZG4/eVPEuZZ/dRNBF
 jAitWHy2LT95+01td8D2G7SFF8aGWFKRc8ylzR7GPzDbRK54beCSPyLeWI5ktHemidUoQ
 6xmrlz1OyF+4+k93xodH3Hvhql7jVFuJlz/z0SMUdoEBYjYftbjcKpz7kHiPIdeCXRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482959;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=BID6gOfDklSOnAGssHrkxYf2mXDitEG12q+FQcbHK34=;
 b=ct6m2aVHiOTiX+8sXaKjBzWHI7hb2cDLn1VhFjJ1P0/25B+OarbpRYxN5D6BZXgRJmdQ
 uiGSn1HMZmYC+aOjzUl2BMyMZ7ln4GCyX9+/GqiC0Z7Wb71oNGAFId+bthyx7ZZRzvzRA
 ZA72XiWpB7Qx9Co6HTHNYKUC/qLJiDnWvBaBh4U8iS3TxXmBP/6h5zwMh+4NPzwtduST8
 F3PoCyoUuH/grzMh9jWkl3oxLxYzB/hPiKdqO97T1JzplTCsm4YoiCcXjvZc271x83auV
 nq+HIdvlVuDrrVjmavdtHChJE8j2J92fkAem5z13MDn24csXsDgBJ5uAXOg8ljrDm5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FQoL2Icm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FQoL2Icm
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF5A080FE8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:55:58 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so3337288a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792482956; cv=none;
 d=google.com; s=arc-20260327;
 b=f/GzwjY4Zxfc5fc/ZV7/Jl6iHvyUCqBrqOOweWaTxvdoffLYIrIrYv1DWVF1plKvAr
 DnnvWB+lddtvmXHFRc+allNEVTEcbqIJ0U9HCPpBAbWadXH1yTutXvHg8umaA4h21UBS
 h6KKJhwLzLGtGACxSqQhmb22P9TPpF8P/cSBKSuRjNMzybA0PcIgIBTldopXYxZNADw9
 R7w42q/veF6CUH2Kl+vyNHial5sLXxikaeo4L8TUMSjuhboCav3+E/0hrdX56nmHDsrC
 Db/4N7Kl+JMtJgoWogr5JGRbdfuDHHC53VLUodCgrF1PiBSZ1JqHhb9oCakhabgDiKbO
 NCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=BID6gOfDklSOnAGssHrkxYf2mXDitEG12q+FQcbHK34=;
 fh=G46pliI49Jsr/o8/3RO7DHWDlrrqQA2sKMF7rOPwJ7Y=;
 b=GqEsNRSKu/7Ns/2n0R17YmiNXmDCtLxqUZV4K2GwujZfHHpMghgQSIM9Y7UdQ3ovtM
 XunkI5XJipoF2ZyMs6IoW+YazG6ar/Bm4lXXnNIJu10sIE3GK9D9zxOuirkI+3+MXOXB
 WAZyfNmDXBk83y0GNL/JwCfGjOcUlEpQ8dJBC1aI9QwgS4DrYSApjE6ckWXp4F7kDNXR
 65/K2JiKsfuNy5/uRJq/ObhL242+s3eFTyBTR71EIETbBqchoRcpSHZvDSq/A/tGs0M1
 SomYqAKb7c0ym7Tfwx6x7jPD054aE93BAA386lWPNdN1HYT1U4wHD4vc0Ocxza48EC20
 agFw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792482956; x=1793087756;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BID6gOfDklSOnAGssHrkxYf2mXDitEG12q+FQcbHK34=;
 b=FQoL2IcmRlv3ndV+puAOGUSCl/6Julj9PvR55BWCzZxL60+LrJMoYyo079+6zZLYlk
 WLV8YFw5pXL+Neil9Pb7+KS9l/U3Vb8XIDqD1ri73JylfxszWQKxpZ6EuoLPwDPZa1Wp
 sHpV5YePkqyRS4+oQo+e9/kw+mZQJE11XDf4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482956; x=1793087756;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BID6gOfDklSOnAGssHrkxYf2mXDitEG12q+FQcbHK34=;
 b=pazCd7kYoSajdb6eshxGmmpr3XyDtezYpbSlgb6xKHQM7o55flQXGL81BCr1+lTQLL
 xWJjiM8+Wn2yOO8sSvwjwo1+lz/lrENMu8m7lnbmFwDbk0DII4SazdZs8V7IjBH2HC5p
 uvp1yQPKoDsnaGi7plNG5NjRKxzjssOgyZjiGcnnGyZuVqVNDQICR9wbYSYzAaA5cf46
 O2W0L4PIRaHbGICqF/rvOsZPofcAQ+KXU4asUssKAmd5cUjz1bPbG+sxlYNazAo8Nae4
 14tmzhHt0DL90eoMuRxDLhOni8IYHLvhC4yt5M4p1UmKlgj7eTg6Jz2HkL9NGMRY1PKE
 Kj/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByZ/CmpdaqlpMpVmSs73D6cRn85gYVsrNvhgq5WS/xFQhpp6TfTpZ8VG2RqGA7Oo3ilGa63VkY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIL9sC+waP7NfWVwqUt/dF6lbaYE/LeWlqhhQ6ZWpTcEHgpyG9v
 f8kApImRjieorBrtsm2fxlNllNI9/u4QcY/J72yt/j3PXPO+Fv1oq138jLB42AN3bSEq6XG9rXY
 zySrdX0ly4EK3o+w6cjtGPSYhkaYFwtaef5hdKOHf
X-Gm-Gg: AYBFou0qgyiAAenz1kUkKPdpuivqfAJxaeKAbT2YjfqCnzCktgWQ4Wryohv3ixUKBsA
 sTdsTdweoH5cg7huIu2tgJNHuifCDKPI8KdzAF+TqYsKTkNY4X0lYnJV0kgzk59cjmYDZUSrkyf
 clZPZ53aNaoWKMBanI9MBwX0owS8kUenERHCPdNmt9FMmQXR6HGJDnx7PtFnde/mu/FUr942sgQ
 tvrQeSy0RWwHOtE3zVe9wXdTVkM2dZ4OW6aG3hGbjPfXwnCmu41vtAn+G5s8ZBReDKkL0TZTRL9
 qTdjha2T8KenBIBsj//CzxAao8hBDx4AYnuKtgUtUV+RegO997qOKnhEksief6Xn/gDo1lHmpgR
 bGkcE83PwEhf4D/FDdwKSAAybYLHZufCeWuM=
X-Received: by 2002:a05:6402:a2c5:20b0:6b2:2348:7772 with SMTP id
 4fb4d7f45d1cf-6b3a8153ff6mr4667034a12.8.1792482956301; Tue, 20 Oct 2026
 00:55:56 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 03:55:54 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:47 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 03:55:54 -0400
X-Gm-Features: AclHuK9eoQpIXmrT8769uCL-gp-Rafya4Y07XOID-FOgiJP9f9d4zJDLkdxZkAw
Message-ID: <CAFLszTj95JcBwRzR0dVTzUBuUPGfnfP7QKQ3OJL2o_86FXJM=Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] imagemap: structural and cosmetic review follow-ups
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:

> Patches 1 to 4 are self-contained tidy-ups without any functional
> changes: the suite list and the sandbox defconfig put back in order,
> FIT_VERITY_NODENAME in place of a second spelling of the node name, a
> derived size for the header probe in place of a bare 64, a corrected
> rationale on the imagemap_lookup() guard, and test locals hoisted out of
> an anonymous block and a mid-block declaration.

The cover lists six items but only four patches land in that range. I
can't see a sandbox defconfig change or a FIT_VERITY_NODENAME rename
anywhere in the series - were those dropped between v1 and this
posting?

Regards,
Simon
