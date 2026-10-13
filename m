Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D007CC6B10
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 07:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09D164065C;
	Tue, 13 Oct 2026 07:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xugSUoxxcx3x; Tue, 13 Oct 2026 07:43:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D64140663
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791877423;
	b=jTnfbejvrStWeDUG8dioSC445mB4B5H8T2UqgGXHqWcv6+k+MiqYFfOiGsv8FuEIYyd9
	 NhN7nUpUfTlZtGBVOcjr3ZgNKau/RSE6o8pnqOr3hKY5o1D9NqMjOvOzXZ/3pksv2dnm1
	 SBy5kf9ruJLsNGAG+8ChNTTujgeCyi6FvsmzojiJQALh+pfkGAAaEZkNaNkYpJWdxv4ie
	 ue3GT/x9n5aqZasOsbsvzvQO3eLyTwQtCXn/lAPrV3t+mOGBIRjJo4P20gwJSaa53bY2w
	 5wVoaVHkMRdvHcHuA/KIRv23OB998PcWSNWXXIQHdBsqE9r4x02XXXJ2ASRloo9UnfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791877423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qZ+8zqKPuaTy8gAOBFyX5DTQU4clvZ1Wrj/6lWawCCE=;
	b=jZELjT7Ws/n5Uo/ClYkPbApY73Sil16cx/E4R+uzyshjGNZnkh4wCL2h1FVb7iIiXAlC
	 YdVMgYFnjNX5x5ZkxZJ+n+kzs96NEPANPSXl/S3Uqebr9WLlDuDHLQ9xr4tGn9Cdj5LHH
	 1Neu7UGD2dXReVt5FxwGS7RJcVlt98lPQm5/94fyOaqHXQL4k3lzyMt6pznv5IpHFjXPl
	 sYLAEH+vGvzdTlgBGMMuBS8POjF9RPU8QD4IkRotqs5Dyl3HQXgU8bSHS+QV5uI1iTbuk
	 L8u1IJFK9XBAdybhlZYxLQcX6xe4z9b6XO3E/C9OehoUIS0bEuEebEnCN5YkMoRCcTw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ABDg5nlc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791877423;
	bh=qZ+8zqKPuaTy8gAOBFyX5DTQU4clvZ1Wrj/6lWawCCE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=StrEoFndnuczEPqFotT0wzOgI2+xKuF6us5HGzIouVZrgZGt8hzcYAcWN2r27EERx
	 Q1Xrg7XRWJ7djoW7sXqDXcQdtvmsGJ9TIWtVmATYDTiicAYdcqzApzmUJt594v+Mp2
	 B7m7EcNCQd9GRWjU7+4rWoxhndntg463BOMykdYnSce6HUptAcing3S/l7siMa+d6K
	 AP3gBfBxWNBBNzeBWG5t3AbHGfw0phgVKI1HwqcXBfLjfz6axkJxvO+D90Lt4yKS3e
	 wj/KhytCIfKw11lGbrrN94rbdqfbXqEXBsipkdPpcLugPrstE/HY0YULbr+kFS/K58
	 v2nBIoU3N3hQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D64140663;
	Tue, 13 Oct 2026 07:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49CD2362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C16B40656
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnwPWqb7gPwv for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 07:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F4FF4065C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791877421;
 b=Yf2r7M03BCk5Ue7egFQ0aWWqrI3/Zilma5nyYDJ0os/fQu/WlXFdwuz/UYoEkfb5HFzX
 VmS4tnroh6Mw/KHJ9mX9okhYug+1OkutMGlTT4A1axKY2a3l1I1XNcppzXG39qvqAf2G7
 P2ShG+t5xTbLRA7P8xjM0dtFgJZ9cZlBTZYmE7utVZMX4WpyMa/MnRUkSbspko0IPBnF4
 suuVXbUFRtCO5FWUijeLUeVMg9P/abj9tPSYYcX2yHyCUFd8TzouSmFbAhw4aC8JSdw16
 jZzvGk+lXcCI4a2wzAHLHWaIByzRpJRzKnT/c4WuI6vvR8+MrgDlUUuWQY1UJBQhwFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791877421;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=qZ+8zqKPuaTy8gAOBFyX5DTQU4clvZ1Wrj/6lWawCCE=;
 b=L18AIt/VaYH4vWyxHa24s7+iEawpbEsmkOG6JMMw2oALZOiotEBgqapjpadJAunVl2Z3
 26Axx6MbhbmAGgJkr//ZCYHIxwVNyOQWp3lIJlj2g0qHFsXgaa6heXV6r9pcCKqpNLPiV
 NAb2JqDZhppttyBssveLhj1DB6jL7NLpBhiRYCqT+mjaGjwqRbYIE1beA/agX36qHiw2X
 pb/U/U5tjgCFGojQxdWBlxQP0FlfosWbt8ajL4OXXPLY6zlHiVAdgt0a/b5xAS+icRmhW
 nlgwuOcDSv1THVabY+c+Pyf5W/e3+8dz6dxqiqhWaR4s66G7wv9hIg00T8E8T28yGkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ABDg5nlc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ABDg5nlc
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F4FF4065C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:40 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso33747345e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791877418; x=1792482218;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qZ+8zqKPuaTy8gAOBFyX5DTQU4clvZ1Wrj/6lWawCCE=;
 b=ABDg5nlcAoShUdn2gxUmkpn0aOaWHpl6Yvw+RbvtiTDKegM9Nl6z/5SiILkItxWWOP
 c2/MlPX6wLxUo7/OPYxRB98cIGe3KOratEloixUA7oRUcweh+PbgO9wPITfrJkLYbfEa
 0bR+Al7z+fEA0mId4uWswDZlQmgEuZzBV1HPtMnBEoEro5fokDiE62jFVXZfAtRm6Q3b
 TyAXjMvM3NC/6v2ur3zHjzRdFh1KM5feTCKf9IPGz0Kx8uxaGgRvza31SBsqyNkuv44k
 PbpuZh3cYBJAeOsYqUzQQVosUXKT3PEm53V4vVGVH7csY+xglkZbGyQvUMj+VS3Tz5re
 jGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791877418; x=1792482218;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qZ+8zqKPuaTy8gAOBFyX5DTQU4clvZ1Wrj/6lWawCCE=;
 b=zWOrkZOkfMpyxNQ33m60hYkVCGoOLxP66uxwrtJ//zCtYS2rEhh4uh8f5eENMPXD9O
 xbCGytqfOG98iryBiz7v0dAjC3FYvUj3UvU3qqaKdQI3ffDvjdTtRpGlwMIbaQNo+kkk
 4QL9PCRjgDxS6nSOFzVaxY4dAUSAzKAABKKT+mkKf7Xt/pJtUUoZJtvrnr4twuxSAdcq
 amHrHZ1C/LuI1A/+OomrLmBl+GCOui8brSsUuIkDKTEG2IN4HiBfetnQLvR6vxJ7ZIsp
 8FkrlWvR+y3vpeD4Ckc9kOu5dm257iQQv0R5ivFQD4XX+La09OgoAFQRaa8no5ylXx3u
 aDgw==
X-Gm-Message-State: AFq9FYICi5fkygwhSFTyrCmC+QRr8cBi98CfYJBeunj6EwlwtGHGS1O7
 A2/CMFyybjYYnhp+KAHwTzY0GBTtbDE23tXilNcnKZl9nMfakwd7ZiNE213S1Axz
X-Gm-Gg: AYBFou17iI4TljhjKUK5iLrcjAP3GcBDfKaLdIEDBB/6piWhjHst6dgrOEDgw5KvZeM
 LRq+qAAENotxCSfdAQINPKpoh+iuZFjAE25IrKsnKx6zW/GbaY+ekdLdWDn9GJMyE9La8Tek3gC
 PBdddVbGGnYYHXMQGYir/S3PpmxZzvgdlC76orLL+h5R2EOaQsKuSt6KMfuGz2uU6m0J8/uLCeV
 Nrhgcoi5mnklQyribRLKlCqwDP3jcDwW23/8jvAuN5w0KULUwWxWlvFuPVCKpjVStrv9oPRZq9L
 OrsdZcO0NuyPBChIxYRHp106UnIbAQ0SW2al2Grd1v5JSNO0xOACH5j42ZOOsVPPNmWNpyiDdHY
 i50O7MgnaWznBkj55BIzuapQrRzNuRXh7uodGcGgbRXCH22wlLODgpauLHP3qF8MW0ctmpH6aWs
 nA0Nw7m0X7cUutIO8A4U4CDXyHwEJwRdGXz3jZ1ziEdLk+JFqNoymSLUOsP647HC3LNRdLS+JNf
 g99ifBDrXZ5wUooj70WW18VtYT85sKWtG7go7QqdEQ9F37uCi2k6ADbYo3YnxVpgEEMPJC0UPkp
 xVMDphUmx/Budg520F50b2hEdlyZIsSQJIhl1hb7klvI3StNz599be/quWg+8ZEZBgu9UswU09t
 GEgnwqRgdLMM8KJFsOLmA7A==
X-Received: by 2002:a05:600d:4443:10b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4a19c71a176mr84406095e9.9.1791877418253; 
 Tue, 13 Oct 2026 00:43:38 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-303e-2074-f3ca-cf21.ipv6.o2.cz.
 [2a00:1028:c000:ddf:303e:2074:f3ca:cf21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm635821355e9.9.2026.10.13.00.43.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 00:43:37 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2] Makefile: Pass -static to the LTO link
Date: Tue, 13 Oct 2026 09:43:36 +0200
Message-ID: <20261013074336.85242-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The LTO link runs through the compiler driver. On a toolchain configured
with --enable-default-pie, such as Debian's GCC, the driver adds -pie,
and links that are not PIE without LTO, such as the SPLs, then get
dynamic sections. With Debian's GCC 14.2, imx6dl_mamoj and
phycore-rk3288 then exceed their SPL size limits, and turris_omnia its
u-boot-with-spl.kwb limit.

Pass -static to the U-Boot and the xPL LTO link, which keeps the driver
from adding -pie. ARM passes -pie for U-Boot proper explicitly, so
U-Boot proper of the ARM LTO boards does not change. With this patch,
all three boards build.

Fixes: c1094987d1dc ("build: support building with Link Time Optimizations")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v2:
- send it on its own, outside the mpc85xx LTO series
- rebase on main, with -static next to -nostdlib -nostartfiles
- give the ARM boards that fail on main as the reason

The failures on main, with Debian's GCC 14.2:

  imx6dl_mamoj:   ld: region `.sram' overflowed by 1016 bytes
  phycore-rk3288: Error: SPL image is too large (size 0x8800 than 0x8000)
  turris_omnia:   u-boot-with-spl.kwb exceeds file size limit:
                    limit:  0xf0000 bytes
                    actual: 0xf1200 bytes

With this patch, the SPLs of 16 ARM LTO defconfigs shrink and sandbox
does not change. The mpc85xx LTO series needs it as well: without it,
turris_1x_nor with LTO does not link with Debian's GCC.

v1: https://lore.kernel.org/u-boot/20260928110434.70686-4-pepe.schlehofer@gmail.com/
---
 Makefile             | 2 +-
 scripts/Makefile.xpl | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6303a0cca6a..4b7fbe28be7 100644
--- a/Makefile
+++ b/Makefile
@@ -2096,7 +2096,7 @@ ifeq ($(LTO_ENABLE),y)
 quiet_cmd_u-boot__ ?= LTO     $@
       cmd_u-boot__ ?=								\
 		touch $(u-boot-main) ;						\
-		$(CC) -nostdlib -nostartfiles					\
+		$(CC) -nostdlib -nostartfiles -static				\
 		$(LTO_FINAL_LDFLAGS) $(c_flags)					\
 		$(KBUILD_LDFLAGS:%=-Wl,%) $(LDFLAGS_u-boot:%=-Wl,%) -o $@	\
 		-T u-boot.lds $(u-boot-init)					\
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index a3fd3e1375f..dfd76b51a61 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -513,7 +513,8 @@ quiet_cmd_u-boot-spl ?= LTO     $@
 	(									\
 		cd $(obj) &&							\
 		touch $(patsubst $(obj)/%,%,$(u-boot-spl-main)) &&		\
-		$(CC) -nostdlib -nostartfiles $(LTO_FINAL_LDFLAGS) $(c_flags)	\
+		$(CC) -nostdlib -nostartfiles -static				\
+		$(LTO_FINAL_LDFLAGS) $(c_flags)					\
 		$(KBUILD_LDFLAGS:%=-Wl,%) $(LDFLAGS_$(@F):%=-Wl,%)		\
 		$(patsubst $(obj)/%,%,$(u-boot-spl-init))			\
 		-Wl,--whole-archive						\

base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
-- 
2.54.0 (Apple Git-157)

