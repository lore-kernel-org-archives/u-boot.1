Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8B6CA5FB3
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD5A06081D;
	Tue, 29 Sep 2026 22:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fMZSR70jdrUw; Tue, 29 Sep 2026 22:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1F769607EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790721939;
	b=C2FivdtAffNFohxgSceKqoIHwuUyDlLSHl0pngPKycP6yjyjjENyY/Rw43bkLCMdVNrO
	 /M3nUkB9yph8eubXaMimICdJEK895r+a7ygpJSCp7dooW7zom7aiukkNhlMITNgz/Y1MR
	 aqAE0qNtjT1Wi4JawSpI4u+ermNDcKUB4xOCXOJgEKAIeKWfISx6KvhuUIonGeVfyzjob
	 zaH6OmZ3Od2i10E8JSMnCTLfsUxuzILXk3aCrjSHqdTCYytkuI36wP9cad+66PuM4/1C4
	 LiPmlNBIrNmjeZOgSp+aFEzyQ3VbyK3In2C7Usn0/F5fZkvThm8KUNYDs2CJhO/ox9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790721939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QNR+/Bf4U54ABJW3LKah0jBgnbyYWAtyjtCqqNj3s/k=;
	b=MajJAngiEam8wu+eWnx2xABq071ckDMCu2hqqNMbKxAymLX4roUg0T3HCJSA+lglf8fO
	 xWfs3SDBjMtL1YJ20YZ0gG2yON7UQ5c5whY5bMXSh8J1X86VyLCLt4eRHogB78PDYPzAT
	 2ddr2v/1Pj5lsG9FbFnynxfLSyhPp9uHGO8W79LZIs9hSiaaWvloDkhN/hVh6ClkVnrOY
	 pfDvcf3+PiRw+DhXwnSOyMpwmDTl2sa27+S6TMH0g90cKJrjYa0mk50QXKBn+YUYHNH8u
	 ZEsXX2Nw/XnC1Dt7JiUUjTeaelfSgXd0pzS/iwM9iKid9dDUSABcS+h6ofsNmKw+YVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790721939;
	bh=QNR+/Bf4U54ABJW3LKah0jBgnbyYWAtyjtCqqNj3s/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEIfPUDUrsmO4Ck7Rah8qKLd6WQzwEE3zytQK/NZ9PKgsYa7gCDWog8SF6Yddw6g+
	 8GLmi4+OPUmAjTeOSy3zglP5B8788temC/BhMAzUW32mB5/xr8G8+B6Ed+KbHTi/fD
	 z1Ec2pLwVUSNgNPb1Ki3Dy9MJXdWPfsjQTrj8xj/8zvs/rGBd88CVQB1DYYlx3bo2b
	 ieNt2xUSHxya3lgLX33kaLCNAGwdH/bmcIAVybesodbfZXUolLHgFqfqDhJZqMrIrs
	 u99YqM4AcOOeeNbJXj9aYdz/1G0fVBob+dkgklGPmKtZSTREZueuDVf9gkSfjf2HK7
	 biLi9aiiQLJcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F769607EC;
	Tue, 29 Sep 2026 22:45:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3BFB3D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9878407FD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66DkHO2SW64E for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2E5DC407F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790721937;
 b=EDvBrg5qlP18X1pphVznfKfN5BCtfbiuXGdJ8amwalZborcK3YTUKfGIiQwEFSkiReD3
 qtlSJaJaeuPyu3pOK/tJv9N1i1zh/CZiowygRXs70T5P5PCszy7g48zGQlfVNHbtDIUrw
 sU12u7cL3lAnboLpISKnONaDyfVqUN7d2nH/ZLVdNd9RwR3b42NH+AOLvzoLjcLnqd1aV
 hbO0z6cMij1XIr2rSkAIsL83eOrYtg5Wy3cQSqkwv8tPEMsjI1hoJ+/1zp8/LIe+4aVrv
 ufmTtHp5e764hAWUO5+kbSXK75fbm6qq4ZOOXUezlh9Mrxm64WWxhqWDWCKOR8pLQjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790721937;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=QNR+/Bf4U54ABJW3LKah0jBgnbyYWAtyjtCqqNj3s/k=;
 b=VrvIJFsA4ojZz+AEvmdZo6aCGaP8WgslugWcxICWCgC/pj94sfvIbFSFrsgdXbOhZjuI
 xdUQoUi/vuq98fv6NHBoav9oXTB6GIcvMrcIoWuPMsonTfEiVCadeepzjJo84uO12aRPJ
 JH/CxhHX6Wvk5IH72h4KlyYf0DXGfkprSXj0yGfN7f5qRJSIWwWTYJV7NSDfh6aTI98C4
 NqZKTTGvGk9B7oraFKa/rxrdTwL1JImD6cfHo6xumryzD7ADVIz5/jVSRbgOy7/4wfb5x
 8M+P9QXWdI1APxYPvbg6enNFdRcSA5KEiyG6McwWCOfwT/kHiH0M7rrpK70N95G1I4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HScmQCqE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HScmQCqE
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E5DC407F9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:36 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 006d021491bc7-6dca9e64f68so44837eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790721936; x=1791326736;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QNR+/Bf4U54ABJW3LKah0jBgnbyYWAtyjtCqqNj3s/k=;
 b=HScmQCqElhbDhAe1Un41Ihd13ZRRZfBdw14NuLelFWRLxsl6N9eWq/uAscJZqsDUrE
 v9zsfh4XbOyaHVyE00aMpwzDf3wa4eMjY4T33vwnCTwgfxpbiM49ArfutziMz/jDkW/D
 vNS1sK5yNTahXDnTPDD9Dpv5QNGBAomz2ecUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790721936; x=1791326736;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QNR+/Bf4U54ABJW3LKah0jBgnbyYWAtyjtCqqNj3s/k=;
 b=L/UCoyhuFFeegVkZZ9jcmI5uMkFtF1mP+zxLAjaPwpxVl/bD0ydtjVIcIz3N7aWIWc
 foeyr9JMF2tPPE84ecSkdfm1UtKDOcDxOO5DmFoWqbyo85xW22zFxXYXFkDFEH4DyVHF
 z2LnoSANt6yQYd0lfHJqtu4QOtezePZC1Kqe4r63K3tHkCm0isXIqe3JPet0sg0WMxjy
 KRM2PJKjAkEDcKcoqkIgTat1ODmqaFTsMz9/32eMkS7mxAxr8dL07Ni8uwlMg7KwR1Dz
 TrvsiLMMeP/NbBlIeBDXNYWNzVxOqTJoKBSk85pIoOIjPXGTCXyjObhVG/YQgVCAGllR
 GsQA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBszVOdp71qjiPY2hLQFf8NBYpDbmmTfiNH+wjJ0/vCEAEoW5YEUdLdpi6bIVxTfojdcsGOkM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++na1/GTSRRYF34PiDrDFsQtmj+M1r4GRucM3XJYeqPizwR9SfQ7
 MFBxYrlJX2Mgk8zDOlPsPnpCfibvpSoKV0oGm7ZvErr7NirqPSBfod+OauUirQSOFnmgccPdABt
 XAS4o8ojRfnHs
X-Gm-Gg: AYBFou13jOSBbeOfY3BHRhdHZI3c1FnBw5LXKe3hOjfuc+8fDXrmH3nFRVvRmydeclB
 KdwVE98FAB9DMNnVrxT+afLo8aiwhLqOCYrDs3cR0zPY9BPfCTx+kUInKoWGvMIF1qWzOY9v63t
 Tlul4A00DjmOYFX/wnx0e8thQ07nHIw0OlMJ8tFbsLT7DvO6TDU9fYwles5mb9FT4l9mW5eTjMj
 5t0JiQSGi7NW+9yRo8dxNtoU0PXiEAwZxxpkz3kXchtHCDSPWa8XynfuvN2Y6Iw/AjXrXlXTr9E
 FQ0WTtOAvE+xKeevY9bros/zCHcy4U6Olal6ddm185MzCYbN9WxGeEwhoGVXwn+t3PD9wJPhmcM
 7BHjJJ+sNxYKUGNv24FvK3+gECzhXL+YsFXtnaGX2snj5cqim2KAFZ6HTAX/kj/x7OwgdAUN5Gh
 +ZP9M0i1Kb4O9okp1zESgWlr7jyF4jmUnTej08+ZBoV+TcFJrDP0EQhixtX+juiNCIDLGc3bhIB
 vMxv1x2rWPeh0AJ3jeNqf48aHHXzBcAwJhiyG4RUfNYjY7J1bW5Vh//g0+k5R+MkTI1YCp/UHx9
 Y7iU3uKWYmiNoRZZ9w==
X-Received: by 2002:a05:6820:1c92:b0:6cd:3fdb:fa65 with SMTP id
 006d021491bc7-6dc77e269c0mr686854eaf.80.1790721935771; 
 Tue, 29 Sep 2026 15:45:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81faf7eea80sm1159921a34.16.2026.09.29.15.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:45:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
References: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
Subject: Re: [PATCH v2 0/2] video: fix build with VIDEO && !VIDEO_LOGO
Message-Id: <179072193411.236406.5038978250658799670.b4-ty@konsulko.com>
Date: Tue, 29 Sep 2026 16:45:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 03 Sep 2026 15:59:33 +0200, Julien Stephan wrote:

> While enabling a splash screen I enabled SPLASH_SCREEN which
> automatically disable CONFIG_VIDEO_LOGO (while keeping CONFIG_VIDEO))
> and hit a link failure:
> 
>   video-uclass.o: in function `video_get_u_boot_logo':
>   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] video: remove show_splash()
      commit: 4094466794df830b6921370bbf2911715b90e6a3
[2/2] video: fix build with CONFIG_VIDEO && !CONFIG_VIDEO_LOGO
      commit: b3d118f73fb0f68519e11c7aac8e33362957af27
-- 
Tom


