Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4351C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7761440660;
	Mon, 24 Aug 2026 13:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lXMPtz2qEpNz; Mon, 24 Aug 2026 13:30:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787578219;
	bh=Xuw/PixYXIbcRmF47P4kfd9JChoM94/sOiR9v3P6S/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CwotXDcRSIekZ4+bAoE7iXPVRQlfCwwwiPNrxsl54rXQIfSgr+L4zBqOZoQM1cHe/
	 j3cU9MFMiUqATVQDO2iWL6R0Y5cNpMb1i55v6WEk0bKNQPePQxl6GSQvz1RmEx6mRs
	 97/gk81K4HH8RSF36pCQtC+wGnwMsrJ17eLYHitvfESiwPSd8APeHnWOWOD/rEsc6f
	 B+0z0qYMgtXFXFBNXWNX1s7M/11fkK5bFrfqxFgQISW+W07semv2bYlV1Kl/11D1Ax
	 qN+ap5n4Isij+fVGHmskYGjCMoAAsWGr1XIissut65Nfwmufde1kNmQsrQ+HtTjhdO
	 DGtr+yFxLlBrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4A35405AE;
	Mon, 24 Aug 2026 13:30:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AFD52FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 717326060A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HdU1nF6P-_NC for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:30:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oSSy9HdC
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CA4060606
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:30:15 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so393252466b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787578214; x=1788183014;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xuw/PixYXIbcRmF47P4kfd9JChoM94/sOiR9v3P6S/s=;
 b=oSSy9HdCtobg/2ffICrLXa76ICMgtz73V6omer84ZjpxlCigCjzPcgFnHwHbB0wpEK
 7Zki2fKynFOO7dEB+PWVxJgPbWxwEpfpDEr+haOfttzxU/fzjGxqaoI9+vCVmYeBy7ik
 0REib8/eCfSDrkFD8PO8hFOloH1HUa1mkeWq6Usz9DYWfdZkafEnm7Ewo/p/4Ybd09Tr
 RKnQ6V3g2QOIChszTGJQKjUL9iPKFXVMC6B6YrcELq50fkWCXAupeCXts7EgAAwdlTn6
 4Qxs+rSYyhRJuPOS+ksvsM69aIEocj2XpfhAbIwLVKk/rYFrBoZBfxKHt7hpmug7dbRS
 230A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578214; x=1788183014;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xuw/PixYXIbcRmF47P4kfd9JChoM94/sOiR9v3P6S/s=;
 b=QvIpS7yg0tsusnR3JtmcTrLZhUmzRDQJGtPSXhJnYFL7UeAuDDD4QXUXmxo5i4fOFM
 eZMTdcWcdJ1Anph5lhQggpjgIB7TuiVw+2OsGoBCqrPfEMOidZ4QfvFNDHCEKyLIhdEw
 7A61pJ4IOqJdA+qgYNEVSZKWMjvSnYMcL81M9blh6bRd3wu1nyJlOSJWZr11PNFGefLn
 a4kDUTKHw704xwYVhRSKTm3d0TgMW+JADcmCAzVOR3P1jZoAkXj7ykQieQ9yBdE1ZV2m
 mqP30OxC9Gd0xxHIN4t5pX4c/AVDJhDODnN9y8gAfkGlQJZkw3hhV4ix+IReqE+XS5w0
 1R+A==
X-Gm-Message-State: AFuF++nUxZRW+4Q8HVDHA2K657FGgegyTCykyfE99v6RA1EOLORvIgOM
 WQOqEGsFWKxb6Kb0BJbO6MQ0hcrDDRUSciQ7rNcdvtnaBrGVQ84TgpAadfq5sxLkeyA=
X-Gm-Gg: AR+sD10FL96rv4G4nUf/pK/UyVMsRz/zzOXveC22cr3JEcldB4R0XyTW5+YrRechhjE
 ztVb2gYh6uSh0ZSwD02Fu04q36B0RKyn7AZ2bXmHqEltYyRSSgPHXJ2nqGmzmg6DQ/sEFfQmnzt
 YMsl5xMSrFHNy5/jfZMQ4HoPvuiyc7/9G+Q+xQUOkFmwkSFf2bYRuvwbFYB8hC/Kj1KGuUtznzH
 018jOd8LR/Zsf5itjnoMPEaOQ6397zC3fsDEpijeJcvgPD1tjMuXPQI4Sc6DQnorZ2+9+CdgoA+
 /Zatcgg1JvyNQ8pCt7ozYByFu/PVz+NHIoaTL2G2LlfPuLm9ciYqRoUlZb/hHkkXEaYYCdFTTiK
 /yBbdZYgmR0mQyxmhPJN2IaVybQcQKcg15hBg4ISJZsBTCt73Ru3gWAvCUTTPMt+Sf7YC/OJhQ6
 IWs82nz40GrA3/rQbsixgZWbFUlgZIBMObLoo4rgQfWC83xESECQkEQMpGJo3uyETQyrmOXnc=
X-Received: by 2002:a17:907:d501:b0:c21:9cf4:e1b0 with SMTP id
 a640c23a62f3a-c246a30a9f5mr3158574566b.3.1787578213598; 
 Mon, 24 Aug 2026 06:30:13 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f8f2asm1311988366b.36.2026.08.24.06.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:30:12 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:30:11 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
Message-ID: <aoxHY_tS5pVSl1_I@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-6-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-ux500-external-sdcard-v5-6-07ca794e2b94@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Aug 23, 2026 at 10:39:25PM +0200, Linus Walleij wrote:
> PL180 card supplies remain enabled after probing and while U-Boot is
> running. They are no longer needed once control is handed to the operating
> system.
> 
> Mark the driver for removal during OS preparation and disable its VMMC and
> VQMMC supplies from the remove callback.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Is it worth briefly toggling the regulator off before Linux turns it on
again? Linux will typically need to turn them on again later during
boot, and even if not Linux should be able to deal with unused
regulators. I'm not sure it's worth adding such cleanup to U-Boot.

Thanks,
Stephan
