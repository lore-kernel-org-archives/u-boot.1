Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC23AC54FCD
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E795C80C84;
	Wed, 29 Jul 2026 21:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K4uMMmFk8EE4; Wed, 29 Jul 2026 21:52:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BA7380B6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361933;
	bh=sBDohcH9MTbJT85mTQEnRHuJjHDp4RPairqQo1vJ6xs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mM3kS7/MqSlHihMbWhMK2nkBgaTP/UOHrHIht1uY606+rK4OB8uRdE/tYDPkkyN9e
	 kacQF2Sj0UQO2OO2ADdJsUoG5rXExdFpfEGXeRVcDtWca0H443TI87y8L8HDO07nim
	 enk+D28h0NrZUHclVIKaWo/4oCdx+q8F9/UWTCXfDSWmkIZBDhr7HKwejwp8HMj7B1
	 wKeZWy87StEdM1HkAq28CF4j5/x0JclLqIxz7Ovd3lre1VuHx3rWkeG4RFD0lvkZjn
	 2Gau/QICIh68GteUAmkGStS+oIAXchHy4e8LPcQc/LKMK3eQr4JhP1+C9ojh47u7Z8
	 TcdsE7nmc/0GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BA7380B6A;
	Wed, 29 Jul 2026 21:52:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F2153B1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42A966066B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 12WiYwcDBGI9 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 16:47:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C00606065A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C00606065A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C00606065A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:47:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10496849BC; Wed, 29 Jul 2026 18:47:45 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E26B803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 18:47:43 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69ffbd2a277so1884161a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 09:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785343662; x=1785948462;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sBDohcH9MTbJT85mTQEnRHuJjHDp4RPairqQo1vJ6xs=;
 b=lXftm4RF0Mvoq+dvbE4h6bc7OdcEzSm/765StlLFiLwmMrASmXt3sbN7KRcWtEOArG
 VAyaPJry0VyDmilsdFjmSnjDs42zemOqMF227WP1YjLv5vu/KDGNjxqLHib96+KQPxq5
 fj0VUg2SGn99U161gtNCuC+1V+72YOFY1HkliCs9b92OfN+BfxMGEroo3O+rxfuuPPnq
 UtWNj91MVM4OQPKu8AB1yUncckXh3uf19h1ASam6Q6QjrPcxFEsgZlgB28D/ztuqCKi2
 e8+MPUJs/XqpH2bpydQACtbot+iJaI0GySENTVQj3sqq3cqaEnAdQgLN+VYJpZTgh6W7
 Tbmw==
X-Gm-Message-State: AOJu0YzNLvbriZB5zlt/ne7QJ9+R5g+ZsYBEkim8OJFfXSmZRaEYIj7M
 Huqqjfl7FYrcNY0KWekdh7iacgOZfCkDO4nfLBwd34GcHtretxV6sg3UkakLxtcu5lk=
X-Gm-Gg: AR+sD11DXMSRzgscYJmvS7WbnIzM4KJfI7cDZ4fB23+gO9uOPE0JY92+1tCt3/fWcPA
 PTiZdqO+W04TmFbKA3HpWrtsUnohoIKmY8d15tbxJbVcQVPpIFA0HsTP5Txexmsh/5ZBeHaNCLu
 RXyDmIKig9IcN6+Pst6k2FWz+l4X2nVPHJW1XTqLq5TpCcOCMcqSamCugnLTU4KdMNAXSrFX5f0
 rO/GMSXXc49ZfH9t7enc4XzwRq5oLPhjf+2inU7RHg31yM/Y4wOwrLKIpvJV2nYuq4MaOJsDw2M
 3wVy89G2dtSMQdhi0opO+3oLeMHiFC1WG2UMg5H7vR9G26L2pzVa8aK0nbuzg/MbAU9meMvRw1c
 Hb9f6TpqJEd0Rwmof5tvG3Q323rbOoxZS+lIgmZlNG46WyGfNHmqYHZhTMNlqLiM3QGQouAte6E
 x1Ti8410eAg6nmOfnPYb/+K4nsYrFw6qo6W7TkvdUShgiSPhFtfW+wF/UF944WK9In1Gf5meY2F
 MqLveTE4/LUQoPnQJw7C3D0z52LF3HmiiX+ENqfFWGdKX29iZKA2w==
X-Received: by 2002:a05:6402:3899:b0:698:c1d9:8134 with SMTP id
 4fb4d7f45d1cf-6a0349e9a0fmr3882574a12.9.1785343662210; 
 Wed, 29 Jul 2026 09:47:42 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0047bee160d2cc76b5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:47be:e160:d2cc:76b5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c6c9casm1058292a12.26.2026.07.29.09.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:47:41 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v3 0/2] video: bmp: fix out-of-bounds write in the RLE8 decoder
Date: Wed, 29 Jul 2026 18:47:00 +0200
Message-Id: <20260729-video-oob-fix-v3-0-21d3412212cf@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQuamoC/3XNQQ6CMBAF0KuQri2hA7TUlfcwLkoZpJpQ00IjI
 dzdFjdG4/JP/n+zEo/OoCfHbCUOg/HGjjGUh4zoQY1XpKaLmUABvBAANJgOLbW2pb15Ui51pQT
 IpmaSxM3DYTzv3vnyzn5ub6inhKTGYPxk3bI/DCz1/tmB0YJ2XFZlzxuh6+LULhM6teTa5vOdJ
 D/Ap9B8CxAFKRgH1Qtesx9h27YXCEgRLgIBAAA=
X-Change-ID: 20260722-video-oob-fix-69c4a7298519
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785343662; x=1785948462;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sBDohcH9MTbJT85mTQEnRHuJjHDp4RPairqQo1vJ6xs=;
 b=JUuXuTUIOuX2UeKZcsEGsBdZIChdILLt1aoarwwlDaNAXMSrM6u/s0GnUyXpo8HFiI
 duIK+29cb/9ixDtaIXti4A1JZ+NKhOV+AbTmlWJqTqlH8GZ9MFdhOIlLiHbGBY1T9Fde
 BtPPbeKT8Q7xIx0Ev3cmBBPYOgZkin+bOnOTax2id/QGv+ubd36ldk/rrNMZkT1u6HBN
 NeHGSdl5YcBiM4BA1PHpj83TWiMa0vYnKeXhZDI2CbUTNmNVHB4EGB9c7EGvnqsqipB+
 agvj70toSb6u8QkLskdGqtTEh04s5sZEcs840qA2jec/tcSMTdb6gM6s0rQLTBMS9UY0
 otKA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=JUuXuTUI
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="JUuXuTUI"; 
 dkim-atps=neutral
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

This fixes an out-of-bounds write in the RLE8 BMP decoder and adds a
regression test.

video_display_rle8_bitmap() lets the framebuffer cursor drift below the
start of the framebuffer via repeated End-Of-Line escapes, so a crafted
image displayed from the splash-screen or PXE-menu path (loaded from
removable media or over TFTP) writes before the framebuffer. Patch 1
bounds each run and rejects such an image with -EINVAL; patch 2 adds a DM
test for it.

Based on v2026.07 (fdfe2ec48d5c).

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v3:
- Propagate the return code from video_display_rle8_bitmap() instead of
  flattening it to -EINVAL (Simon Glass)

Changes in v2:
- Use my real name in the From and Signed-off-by

---
Shahriyar Jalayeri (2):
      video: bmp: bound RLE8 decode writes to the framebuffer
      test: video: add regression test for RLE8 bmp overflow

 drivers/video/video_bmp.c | 28 +++++++++++++++++++-------
 test/dm/video.c           | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 7 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260722-video-oob-fix-69c4a7298519

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

