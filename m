Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE08EC5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 13:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 695394070F;
	Sat, 22 Aug 2026 13:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FqG1z3Xc6_TD; Sat, 22 Aug 2026 13:26:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787405199;
	bh=c34qGxulFxEyLKfj+FjJlSV9WOrBBUFZ8c27Mrc2wdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfmiK9C+aC2l6MGMBrwbEgoclPMVjsvJQQdGBTvG5N/y8n8vyhxL+DgfsaPGcxI0F
	 qzi2ckAeFCbelK1HSzp6avdXo4KFue+UImkYJ4km+57Mrr5r1HG8raJ/EI6X5uOcZv
	 TKE08SzY95hy3lnQA3QJSP0GnMaqOAhi+FKx0mumMlXF38egLlRUIET0TKaN9Z4o9k
	 PB3GyDOmetIaI3TzxUWK7a9omlGZU9Y8AznFlvKrpm8PWnj1nbanx9QS8cXyTh5O8s
	 4TaMLGRUrh/pmgZhuWDIvXQdvU87mtIlxzSSkCfbH24YbV1kNs1NqPHk09nUnMmT+J
	 xWFHCRt5+4TvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1C3E4071D;
	Sat, 22 Aug 2026 13:26:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 54B52118
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 09:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 464CF606D4
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 09:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PR4XCUipApfI for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 09:15:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mgt8Hpu+
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EE2C606CF
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 09:15:14 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c20fb91ed0fso258575666b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787390112; x=1787994912;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c34qGxulFxEyLKfj+FjJlSV9WOrBBUFZ8c27Mrc2wdU=;
 b=mgt8Hpu+YpZ8JVyA04W/acOUimfZbB6pLCfTjdBGLVmzfrXb7F7+DvGjbK3FB4Ric8
 vhw6AnWzJDPxOYnAdI1Y7eScI8GPC7YfWcZirE6KYXcaE4SeniTRCIt9VM8HUQT4aJ/f
 Y+6OHGGrhofkF5n6oPUznJnjTn5NP/+MsMTmd0vsl9dQc8VMrTwm35Ztqo1p9PgxavPd
 Vh6scD4vAFX/gmxM/pR5MNogqZWeT0idUGc/CPE4uOSSiK4gPPaB/VQqKyNJqr/4pApf
 RAZDFJY9u1aOL3tehTGuZjHXV1ocl/RsWFy34XMldncAqRojNs2a+UZcDy9fYBQArWuJ
 uCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787390112; x=1787994912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c34qGxulFxEyLKfj+FjJlSV9WOrBBUFZ8c27Mrc2wdU=;
 b=C3SYcxsXhxptSGE9lD0VDxhFbPqgjZvqxQ2z+9vqhLZxmPUOihNkyzJZeC+KhqzfI7
 ZtfKN1MrHzr3oUmUhs1KfiDZOEHPHPDJtLmMqximiIPxx82rOYKyzaIAilgfSfy1zsX2
 7q/jSs0ztNLZ4HZgQ/7que/rewIuHwydljwL8bhGiZvKnr2mjIwhu7pumGzFhZ9nm68w
 8RpW4xqnsnPopvxeki8kNglzXDllQVxTLEDvZfVWklhVjPjLTwaXe5XR9s9nqSjjTIKK
 Pc3UymobsSgrvz9ePDghAQhrH6WLImTom0aZv1F+DPoZWB4O+h6psm2/ooRa9YuOCcCv
 hTrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqD3SbPamItaHGpGOlcdjEbSZl9Hb8sm67Qch3pOC9OysDSw9q4ynmMV/vH2XFBF3BugpHpdHY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lyLtlt2lPi3bFOploaAsgvSmGittcdlC30Q9YOU5zh7HXP9BbF
 SpaKuV1+8YjDFbTgZEabVZKMrIKjKHHgQD7DItarENoQBq6I2PYSjQ5cfL9HS5ks
X-Gm-Gg: AR+sD13SOMJr2Ix/IUPVM+9lUHVqdiXXX5b8kgupTKF754T9HHbUlUGyzFBWP8GLjx2
 D4m1bt4nNXPwZuk4QEcAaGdEIRrOC0HW+Yh8ZAlBH2T+Lcfhb876XLE+2t5LI1wLtrT8dIi9ZXF
 DRTOo/OgnXwzBCcQrGPrpYLS78BZuBFicZbUwedobLYqHl2LMNGaZoWEQ4hbos8o65ZY877vkkJ
 GtMP1Z6o/BWqSvIdGWYfe1Yryx5zKoG6mSkNkJuNGmF1zOwRpzmvAm0N7ekkjGQajA4n0axj7Ai
 t8a47dNIXkFCouOIvRXXTuSEnf0vwfrkCRxAARApKFY+1ut798iT0CqhWhwnfVL+kh/HhQtkAgQ
 7WAQGFdCaDXkbSNTUCP2vlOK6ku+oxdhwh5MgTbKPkflEpBkFgkrB0HauGVvkH6AHWoZOdV4lZe
 mH2LM1zS8RTF+wiPEFAhUilxfRp+6x1WPSrzTAjm9ZudR5dFgyY9D5cLdnNy1akenIvKnHnLjX8
 bb02PX2/6j6nlTorXzR95UStgUk342TpsI/O52gdrVL0a7tfYPrDOfhD/ZgeuLnerzObVozzIzN
 607z16LOBHd1rgFDwA==
X-Received: by 2002:a17:906:eec4:b0:c20:1bc5:6ff1 with SMTP id
 a640c23a62f3a-c246a2cf049mr1306364666b.5.1787390112185; 
 Sat, 22 Aug 2026 02:15:12 -0700 (PDT)
Received: from thinkpad-p52.telekom.ip
 (2a02-8388-e6ca-5780-e161-768d-5c97-84d0.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:e161:768d:5c97:84d0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685ab3csm217784266b.49.2026.08.22.02.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 02:15:11 -0700 (PDT)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: hfranco@baylibre.com
Cc: andrey.lalaev@gmail.com, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
Date: Sat, 22 Aug 2026 11:15:10 +0200
Message-ID: <20260822091510.3253162-1-andrey.lalaev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 22 Aug 2026 13:26:38 +0000
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

Hi Hiago,

Thank you for the patches.

From your cover letter I understood that SD card is supported.
However whatever I try, I always get the following error:

    U-Boot 2026.07-00002-gbd5e3de2ed6a (Aug 22 2026 - 10:27:48 +0200)milkv_duo_256m

    DRAM:  256 MiB
    Core:  20 devices, 13 uclasses, devicetree: separate
    MMC:   mmc@4310000: 0
    Loading Environment from nowhere... OK
    In:    serial@4140000
    Out:   serial@4140000
    Err:   serial@4140000
    Net:
    Warning: ethernet@4070000 (eth0) using random MAC address - 16:21:8c:10:cd:96
    eth0: ethernet@4070000
    Hit any key to stop autoboot: 0
    milkv_duo_256m# mmc info
    Card did not respond to voltage select! : -110
    milkv_duo_256m# mmc rescan
    Card did not respond to voltage select! : -110


I tried 2 different SD cards and got the same result.

Am I doing something wrong, or is there something else I need to configure?


Best regards,
Andrei Lalaev
