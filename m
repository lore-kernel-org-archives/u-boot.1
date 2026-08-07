Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7114C5AC82
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A89A960AB1;
	Fri,  7 Aug 2026 16:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9cCVxUTA0L6; Fri,  7 Aug 2026 16:16:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52E0060AA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119405;
	bh=uCGAUNEHsfX9Ydlbs4+KVIgqaCI+ICZFxSn1TVYzwgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G45Vnvm8cgWPNDxN/dcwlxayNHyCiuDQCizS4/bK7Z2vecVxNZ5xvVf0lUICTaQxe
	 UtDOB9uIdO8iaRd9WScjHtE/vKwps9vFXADWSCYVK87pP5TEx3hgBhTKpCb5cgRxak
	 KdMSsh+V7Hh2IflmZrjSMIFhDuJjAIxpgfuOxMF/mecXy88IWP4KdRIhY6Pr9rp8iM
	 3cWlOFBtB6mSTiXWAnESw+Rf657b0RjZBMXyafP+Ic4dTjAUnbCByh113sR1ioKFA9
	 GnS+qv/ytX9IWjKsX61hjDPvGd+SxkMgGAjBrBHbvOWMwc90aNgARz6b2xsflmiWdk
	 BhUUtOAER8s4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52E0060AA8;
	Fri,  7 Aug 2026 16:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98BB9218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 940E380F84
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGd7zGNl417R for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2D79A810D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D79A810D4
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D79A810D4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:37 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6b01b862525so1070526eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119396; x=1786724196;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uCGAUNEHsfX9Ydlbs4+KVIgqaCI+ICZFxSn1TVYzwgI=;
 b=qrMalcrPsaWnDqoQmecF2fGmpaDUQyrKIhXaioqAnUGDha9VEqUgCt0LyDcFer5BLa
 OzJZDyHmrybF6VIbgXH/szr8Z88FTCts71zu0S2zxn+PiGK089GzMfd7O5WbnkUdc+cj
 0GeqgqFEuIdIJiTj19bjGychn2Phx4geYGhw0hp12jTI9OaY0mS57RGTQ+/6isZ+nc8Q
 gufsY7Jcf/0mx9YOdpvVmpdOCAY9dZQpiWHdAq+gKS/dqkg45gD7AVf1j2wo04c5XjrJ
 pE48lugxuOk3CTa1EOrrEzpVfK4DfTNdIby+QBIGgo43e1IBvOV11Lh8oasSrgVq36pH
 z6gw==
X-Gm-Message-State: AOJu0Yx37oI4nSvqM39jJEAvxtw2ldZFLRbLYt7XB0PTnc8a8EIztPYH
 DRYYg0prT1RFM78gpLfMyY/cwF8Jh+5MqZtdsBZ1c4ANAXDjAVnCbkEjmW210uWrkAA=
X-Gm-Gg: AR+sD133KRpQUuWDyCSVDaKMJGqvKM8dAncrMXwAhttHSaq5IVT4pqy7p7uZR92d4fi
 7bJox4+5ZUSxdHY37Sq/ZZCjA8N/fru5lZUku3/1Ma5m8lL4mFBkmFTUOIMmUKzt+aa4zxVeekp
 dCehxG+56orMYu1EhLBXndrBS6FAvBvbneAuue1bfzX7PHRUcbbCIErgwZhAP7vv9uQBLjvq5GL
 2TcYsihabPNTMpTHYNFojJzYev3nb2ab9+wDYi0I39J2nZx286yADngpS9yDKAw42Z5tWUBH2i4
 jpzJuxEqF5bGIxSoCI0ztGPycjnp1Q7pycesFNbbO2ILlwP2tcst1iaRaiUsaeoAs+hcazNIxXu
 Wqc/x4xUb0Tju/S8Y4QWvD5boazhZpqNoZ5bRuZTjkvIw1CQyQhd9HIcUZpUje2naXf5I0Fub3g
 umkQKupOdXd3xx1Q0NVD61aASR2MNEcEIiDwj7Azx6yJaDO/JODF8Y6myT4/WA7Cnpnj/uozBmo
 gNoeXeOYoRwyVo3zMMziyOCgQYNFKe/6SjP7qGG0OrlsSozqpiGSVkFHl2hA/hA05PrYUKPB3n1
 hVBvIjtQ
X-Received: by 2002:a4a:e90b:0:b0:6aa:de29:651 with SMTP id
 006d021491bc7-6b03517bb0dmr2423754eaf.16.1786119396228; 
 Fri, 07 Aug 2026 09:16:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2712445eaf.5.2026.08.07.09.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:16:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260805201244.2615610-1-dlechner@baylibre.com>
References: <20260805201244.2615610-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL v2] Please pull mediatek-for-main-2026-08-05 into main
Message-Id: <178611939552.381449.9960800585673817366.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 10:16:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119396; x=1786724196;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uCGAUNEHsfX9Ydlbs4+KVIgqaCI+ICZFxSn1TVYzwgI=;
 b=Y0ypWs8CAcGL6eEF3JNIXr74oydWU3mEkrH53xkvFdMOr//A/YcyekvdBdAYrcmhUD
 tWxgE8bNvHAKthtU0+hMG8scTrvvH1RQTZhhRj/DYFO1jON9VdSo9CqgmEL39rcWBsiZ
 pzinN6G3DxIC4BV6xhiAeLTnBKelEfjkvXeYI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Y0ypWs8C
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 5 Aug 2026 15:10:33 -0500, David Lechner wrote:

> v2 changes:
> * v1 was missing most of these patches.
> 
> The following changes since commit 616c3d79f01cf9204e38738857c4647a730dcb3b:
> 
>   ram: k3-ddrss: fix ecc range checking bug (2026-07-28 12:30:55 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


