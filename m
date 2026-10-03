Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DD3CA5FE3
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 09:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DA04812D6;
	Sat,  3 Oct 2026 09:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtrxcLHik8rs; Sat,  3 Oct 2026 09:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 70F5581296
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791018584;
	b=hlgODwVbUu3DqxeCrTl1C4vEuQwyTM+JhnDZZwqTcbKC4QRcNDLjjmqVaxcJZjKiZmcq
	 XU9wTpYk4sZF/bShbL9gxzcsbNebTSkYKUX4XqJItED7aataJbs/i0rFQy3yw8XwprXl4
	 BnZQvYX9UOdFCH7fpDMJDQ/6onAK/feCNxs3vqpcv/kDRzN4v8Q0pfXBFXguJDVBWCpZQ
	 mUoT4/ApYSO5sOaquO87tnUD4Cdd5ZwEdwgDkv6MOkbqBFRLwwd2dLQWUOr3O3WWuInA/
	 oHWZW236KcqcBs37Lcs8203e70mHL2DYV4jgYS/2mU5OEGmsgBM+AdDxaIDm7b9Pv4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791018584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DFiZeadIibIs/iaJM8JKkJEoD4dMwz7Xx8wA3EBkFIw=;
	b=FqljXBUk8COY+EXe5OvWpKNE3wQNcUE4bSJwNscR5fNgZBdgovvc9efx/UHsAVPUPXGF
	 WaSFvodLC76jqt8xxxdDOOZyAOuYd2cqXD8MtVgqvBax0EcDAvt6pfe6/8X/enrWOyD09
	 OH5Q+645mcUBWakE0PSsAwXbQ1/D0NL8pnsP8n5+8zG+Nf+1hxQFo8mKtJOusTLFR/14u
	 CKpa4VJLKhQfi45AxTJU3/PNcTEUUb7NuiLrEkKKeBZSzhqKKVvGRQ4wUKLEbvYThic+w
	 sqSYxyBeCBQAXN1GUGLHS4oYtEPA8AEZP0bjsCc0UFL9DUENZGolUsDCNlOeJVx1Srg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791018584;
	bh=DFiZeadIibIs/iaJM8JKkJEoD4dMwz7Xx8wA3EBkFIw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eSs5HeLPJlUs+xaAlnebeC5bH6Pw9dYka+CrOm8xGp4Iqzi3sjn6NJA5Q/QQ/2UwG
	 HGv2ZCAoU8CiCIxdz5zOQNl7wcj1IUcYzGAiC+9n+/xgHXnNEDu0TnSFibho9KYUDH
	 ZcU85+f5/ElJY0fZTrkZzWblzO6FRgxQFKx78qspGxWZxIVupAUI6Dp4/m76+3dB9+
	 YtWd8BULB9HaNQIQ4fhU2iVi954sXY68QNP1Be6ZV11SUH95xap+mSKWovbA7wcWvY
	 xrBO32eqXrEpQKHbv/hs9EdfvhnDBvqeuEAY8//0oADXiZQodGVAcyTgnWIvSlMuR8
	 uttM3UjN5Pivg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70F5581296;
	Sat,  3 Oct 2026 09:09:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D35732E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 09:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1330400F6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 09:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZfwacSpVp3S for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 09:09:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C983140059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791018583;
 b=cdv4gH+oQuBTnGycwKz0Cz+gUYNudRYAlVxwH7qIgU+r9Y66sRq/bgJqRjVLyw6rnX+i
 0Sljq6sqYUsMBA4awlk5HUQ2LtdwCvmxJGEkV0jqehzbmnzjcxE9Ok35Zz+ZmZ/W8Vx5v
 BEwp4LdOUY+RSdGx/7C9crWOD5qWZjk2rGrgwaxKTNdkHGHrWsV/szKaPcGmeAdt8TJez
 W3us5NhgufISAEq8iCIviIWwGcqqtXGvkzkbzmqbOfFAPzXAxNMdTzvtl+E3RcjQOgJak
 jq4VAYXBVVmvuGlA+ln3R/Q9qmWcack1QBWmCLWzpkfetT5scNtJYFYpEhsOs5cNwNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791018583;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=DFiZeadIibIs/iaJM8JKkJEoD4dMwz7Xx8wA3EBkFIw=;
 b=aldzdBwnSEE5NUA73Ap51jaddZ4uwYJwLh3HR34z+MIdnJCEnQJbd67TzoKspvZtRFIo
 k5+GUdIAD+aNUWUTUJjXRsVnUMypgWZKL2e/pwWKdOeg7nzeD124v2SBGWoZcSVeUkGRk
 qKhA2ZvByY0xBg0sDz03apjTEEKphTdIfIJbus6I2PEXKXLT5gPAlS8AqGOsLk7cJUo/H
 llQ/3NiYvGqEPAwVAhgGANtzNBXLxdsET8W+FUjYhrxIeiRSFDQtSOIVxPK8lJj5Q3OnH
 iDCcldZ5foos7l96PU4vucfnB3YeEcde96nu5YqME3CwZHc6Lw44Is1JZ682AVnlBdQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GBeuywiz; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GBeuywiz
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C983140059
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 09:09:42 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso4124185e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791018580; x=1791623380;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DFiZeadIibIs/iaJM8JKkJEoD4dMwz7Xx8wA3EBkFIw=;
 b=GBeuywizSi2Bpl8jSDFHojmkPaM5LOx2VewMk0r50P0fGrHhtqC9QeDU166rpBamfn
 QxdYCGU+2oPT2LAfTvK28TajlRLJ8oYk/eAqZo0QYFBogyrRVQDn1lruU4pDdJ10S0bx
 WjxdRzy+DzMo8q/5HXeYOgM9xi01UV2+t1UgDUwvPnz/aihY1MzJWhF0tsCT9nH3XusC
 yhFd6BFJti8jUFqAXMVS/59Wl2DKIcaAaMTZUZ6V0KvWH1MqX23Zk/hRZGZ3ZTK7ZzSx
 3K+zcAohM4AMIamwQayDpG0QLy3DPNRRgsXOisH2CFGOklYQuQY4xc6oJmjJf2rNkz/z
 YxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791018580; x=1791623380;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:sender:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DFiZeadIibIs/iaJM8JKkJEoD4dMwz7Xx8wA3EBkFIw=;
 b=YoE1xeV3YGMXmOXX52rC6ZODDU+taTpfR+6NRkBxCAaUPPgfoDtLdE7+SEgTEI6PQ4
 vHUaBQLfHLDrCtF3MQJUT2ob2DR4ZslT1cet8UkEZY0khRIQ/BvxQgCdIzctwqzmr57D
 RbPP3qpUoY3Y+jf387FXRpQnsRj7JDfcNCy6HqzpZkLX3u7SSkX8d7nMvYRU2MNnLcpC
 MALl6U3w/Ctzn2IR9j8gdj77nH1/8ADH7QSW6I3YGQpQOGvRkDitoFMwqku0pK0BnnZb
 T6hq4fQdIp4iB6BVQpko3NibBzitdogkYFmPXJuD8BWAJrsJcPBMII8qOQF9ewCAYNWn
 FUHQ==
X-Gm-Message-State: AFuF++mti4BKD8lEGrCeavMhT4pwR6olWIKEzNho3CFk1ogpvKJ5iHuQ
 6XmcEsQAqQD8+mA0gsX3vKe4lTe3zTxhSczZYWkBgHjZUv6bwDZQ59s5ljobeQ==
X-Gm-Gg: AYBFou1SI8KgktOvVKI98vYvgLgNyOEP19XRB34mZRYO+PXz0RlxHrIvJdjloOFC7E5
 h3Y5SGloYt6YBXN2N69LxEjQ3giIzVep+2KijDs3CmNlbo45qtoGMtmdL8EYSZbyVtU3IQH0j0N
 q9JabUnLg8MgYOs36vYuyF0bHu1wp/9DmNZYIH49pqQX1tuJDDntxWOiHI5IGj+7eyUDW11BnKi
 BK0F5MEBjNHVZWoMQ6glQQF5gtZjoN0y8W/McOufpejIHrvLqVTLl0HuDFD8NiBDkw8tz47YTj3
 xlUzLkP8TQaO6h+zS8l4bUFUk3/7GLtFcUJ7rb/WlrWxpgAlX4a+Ourj0V9dLlicFw3LYqwhqMB
 9wmXgOen9FrUTp9vYp2byrt1zqAzLBP0n7SetXWBhI74ZS7PT+k8Dh2D2PJ4PXOGJbnZ74BrgqI
 ogsoieSW/V7kM97VeKkMT/pd7x1D7asx+GqMpnBGcVncs1nJmIMPZJJxj5xknj2Gudk2Rlc+ZBl
 r7z36ACfiTj19XQJhU=
X-Received: by 2002:a05:600c:1f84:b0:49d:17d4:d6ad with SMTP id
 5b1f17b1804b1-4a1680fdbc3mr25769975e9.23.1791018580144; 
 Sat, 03 Oct 2026 02:09:40 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.208.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380faaeesm10624254f8f.18.2026.10.03.02.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 02:09:39 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 03 Oct 2026 11:09:36 +0200
Subject: [PATCH] qconfig: Improve the documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-qconfigdoc-v1-1-9dac84b3ef75@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE/GwGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNj3cLk/Ly0zPSU/GTdtFQLE5NkkzQjE8M0JaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAEweeU1uAAAA
X-Change-ID: 20261003-qconfigdoc-fe844c4f241f
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

Specify where the database is created and under what name. Add text
value lookup examples, including quoting, escaping and regular
expression cases. Trivial fixes.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 doc/develop/qconfig.rst | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index a18f32470ca..e3b6d3cecc6 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -26,9 +26,10 @@ How does it work?
 
 When building a database (`-b`), this tool runs configuration and builds
 include/autoconf.mk for every defconfig.  The config options defined in Kconfig
-appear in the .config file (unless they are hidden because of unmet dependency.)
+appear in the .config file (unless they are hidden because of unmet dependency).
 On the other hand, the config options defined by board headers are seen
-in include/autoconf.mk.
+in include/autoconf.mk.  The tool must be run at the top of source directory
+where it stores the database file named qconfig.db.
 
 When resyncing defconfigs (`-s`) the .config is synced by "make savedefconfig"
 and the defconfig is updated with it.
@@ -81,7 +82,7 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
 for boards which match the CONFIG name, or do not match if tilde is used. For
 example, to find boards which enabled CONFIG_SCSI but not CONFIG_BLK::
 
-    tools/qconfig.py -f SCSI ~BLK
+    ./tools/qconfig.py -f SCSI ~BLK
     3 matches
     pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
 
@@ -95,10 +96,23 @@ boards with an empty string for `CONFIG_DEFAULT_FDT_FILE`::
 This finds boards which have a value for SYS_MAXARGS other than 64::
 
     ./tools/qconfig.py -f ~SYS_MAXARGS=64
-    cfg CONFIG_SYS_MAXARGS
     281 matches
     ...
 
+Text values can be looked for too, including regular expressions, but taking
+care of needed quoting and escaping. E.g.::
+
+    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/arm/cpu/u-boot-spl.lds"'
+    0 matches
+
+    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/.*/cpu/u-boot-spl.lds"'
+    22 matches
+    ...
+
+    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/\$\(ARCH\)/cpu/u-boot-spl.lds"'
+    22 matches
+    ...
+
 
 Finding implied CONFIGs
 -----------------------
@@ -245,4 +259,4 @@ Available options
 
 To see the complete list of supported options, run::
 
-  tools/qconfig.py -h
+    ./tools/qconfig.py -h

---
base-commit: bd2f5794b7e24c62042abb1921f9c2039b920e02
change-id: 20261003-qconfigdoc-fe844c4f241f

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

