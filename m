Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BB3C44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A80B840855;
	Wed, 22 Jul 2026 08:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5py7-c9ShCz; Wed, 22 Jul 2026 08:15:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CACD40842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708145;
	bh=5KQoahtz4zJH4WM9crj7A2Uc3Uin2V+DTSdpNGUhbJA=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=hgyOYy6A+Kx94bTAaevgZ2QBgQIc8qgzxa+TmcSOXo2236mDASoz9dYcEasx3GADz
	 v10bukLHh0TZFai+zKLwChzXjxqlm5SWusSp2gkXzF7VgL5+R1kV3pRXHMt7P3Yqx1
	 5fdAm99G/0EfWSH1y7RCRJ2r4s5dQD3ztxjW2KRHxQ18LLXcpaZYEI7dFke3XtlG7y
	 JgesDQ22U8CWw/w/Onvp8kEVAlQXFtbgg/sZkxSBiW4I4J4pUhq79an0jUJGKBim3a
	 BQNhEj7WjmKAICtWyCGIVkkXK2IAgWHylC6EogvMcI1PpiYdUXKry4cf0Mfl4bNe7B
	 cBPWlY0dLB2jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CACD40842;
	Wed, 22 Jul 2026 08:15:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F9A310A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8603140738
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVSfSrWoNY8L for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:10:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E31F240396
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E31F240396
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E31F240396
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:10:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FF28494B; Wed, 22 Jul 2026 09:10:21 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803FE803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:10:19 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so14431341a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 00:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704219; x=1785309019;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5KQoahtz4zJH4WM9crj7A2Uc3Uin2V+DTSdpNGUhbJA=;
 b=sk2+tVPHxRqcVkyKJqE9moDEi+b6YVkW207I79ceXYAVPYEAoYf3lSGJidrpNipaej
 BoMZyt8FTxgCD02PrD54OnMQTRA7Iay7tD4F6pSfOz1SCbL9aJxgDbfg/uWVHZ6hHdH7
 +TmUO2SzPo9dRTjP0bT+JzTNH0WiromgyzlSaeLxTgj78mamjFCES6Qswn5DRefmZ6lo
 DTGrSvuoCAs3hBVsbiqMb0CVcXvyNxsxp5+PysGxBVwQhOZSAUxG68xM4zvhMpT2c42F
 HycBYgecN7D5AJdpojYK0khPhvtDn17yTHkqfs34qDuTD1oiO0JBbsQrNdK2dCl1Ed51
 yvAg==
X-Gm-Message-State: AOJu0Yy42eyrFMmc5Rz+2m648z697M1dyVzzyxGmlN/3HqGc8gkzt9jF
 v16DKMjdjjrbp9S2WdTxd4z9os32BAfJQmZLcSB912gWrJTuAA2ZbQhz59OR6aQl20PtzY436wl
 SQ0e748Y=
X-Gm-Gg: AR+sD12LgTd6CnffeAYAIBI8MG0+uhqPZjhDDRWGNQxil855lLVwFProXwKtwguV/3B
 EK5Q1S6yeYQSMziSW4ig/y+MkJh88fD16taI0hzup7QzX3AOrdO4oUJeEPhP08XGtI9w0hfoTjp
 E+73rtwSKOqFHWgYtm4xvG1B+waDwJNHJGs1jjFDDrl/4nb+Ry/mRrN5jrn9eZsXdu32sES4Mp9
 8eVu4MaJoCP331M6KriFMDmFfRJXaXZbekQVVYdIuh6CM+hztDe0/wbrC+Q0d1a5HWEopfrslJT
 b6nFFpfbZe+03lo1ncsTXYkflhfc0EfKSwJfXALjGfzVy9UCQNVJdQ2XgFZu7vdbVw/QJ7sPLg5
 AdKwBb8dw8gdRICo1PkE11sBDW/iJOX0yTFcIzd+2k/StZWWLg7gAp2M6roJaGtVO+YLcDdeZta
 TXzFjvP9AVTd2dEhOD9/lJPhkvQFHXeaPF6xKb5nA086oGnOdbjCa8D7bhqOteTYCx7w==
X-Received: by 2002:a17:907:7203:b0:bed:19af:f89a with SMTP id
 a640c23a62f3a-c16b46caa65mr1001113566b.7.1784704218995; 
 Wed, 22 Jul 2026 00:10:18 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed000709884cf8c8be3b.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:709:884c:f8c8:be3b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32a74811sm60780666b.5.2026.07.22.00.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:10:18 -0700 (PDT)
Subject: [PATCH 0/2] video: bmp: fix out-of-bounds write in the RLE8
 decoder
Date: Wed, 22 Jul 2026 09:10:09 +0200
Message-Id: <20260722-video-oob-fix-v1-0-d6943f687c50@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFsYGoC/yXMyw5AMBCF4VeRWZuEiVu9ilhQg7FQaRFJ490Vy
 +8k5/fg2Ao7qCMPlk9xYtaANI5Az906McoQDJRQkZREeMrABo3pcZQLC6WzriRV5amC8Nksh/n
 rNe1vd/QL6/2NwH0/7cGQ13EAAAA=
X-Change-ID: 20260722-video-oob-fix-69c4a7298519
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 22 Jul 2026 08:15:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784704219; x=1785309019;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5KQoahtz4zJH4WM9crj7A2Uc3Uin2V+DTSdpNGUhbJA=;
 b=gRZJjA/CNrY8yjn17ab8f8l3zpqwGCYf9l2UF6B5Qlzaire+NLmu8E7srHkdWnQV2b
 PIQEPpFa3aA2Cb603j+KCGa6Hn28whqUvLGbp+otggoVI8v+q+zT4gUxQulMYdmnF1Le
 v3x5dWgpBFuwIAMhPbQNqVPJlhwpn0guTdL8M5ncx1mh5tYK7mM5tyEBIRNhhMJnZn0a
 nqGG1tAmCumb3iQ9OiC9yptnQu4kzIUfrmx7Rh+0WXkRbfBgO8Y/XHGTGob6Hj/KzQe7
 Hus9uJL98mx43LsD1EY0ISgpfH5Aj4lSh1LWSVXbx7icyVxJMh9LWfYPvweP9HAWp8+Q
 C0UA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gRZJjA/C
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="gRZJjA/C"; 
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
From: shj via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: shj <shahriyar@byteray.co.uk>
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

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
shj (2):
      video: bmp: bound RLE8 decode writes to the framebuffer
      test: video: add regression test for RLE8 bmp overflow

 drivers/video/video_bmp.c | 26 +++++++++++++++++-------
 test/dm/video.c           | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 7 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260722-video-oob-fix-69c4a7298519

Best regards,
--  
shj <shahriyar@byteray.co.uk>

