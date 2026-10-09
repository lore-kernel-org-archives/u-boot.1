Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67425CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 14:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F37F040942;
	Fri,  9 Oct 2026 14:58:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AkhadcLH0p4; Fri,  9 Oct 2026 14:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB15640920
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791557930;
	b=hgMGVmKbDbw+UDZi1nzwxYoy7FY6uA2SHZYSSMMWocxQdFvo7iI3rw9ghlwKi+k5tPkK
	 +nZJ+SRyHLbfGm1QDtV6qzw0HtJOZYEUw/Dg+GIo/bzfIFJlPe+7uYms7f+S2MM71fmg/
	 /aa3av9I7Igjt4F3O2Sp5Vkg6DB376oNRyoFy7f579etVLMDaSrqMCs6AVH5zFQPg/po8
	 TPw3WSvBt2sDQ2CkvulLXq70oxoAAO2avVpvrVEsG3ptJDWLvIfOGRqkPl10U8pgYupw1
	 LrzBSH/OJq9pBPMmclbjz87ksR27BD++ejpE7qpQ6aCi3sttHJVZcRVfsjgudpEFATw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791557930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ikIqBbwcqhFOZshyXUnU14GPVMi9mTOrLoeYUtxpCqE=;
	b=kxj+tbfTr5u3jovaTCWEd0dKI6cY2kpD8mkJ+d3AeanCsnumUjiQVoEcDj8uG/7chmTZ
	 QorBHm90QSSvgH84Aeo7RzUTuMOaKgOIspl9EvS3+9oZkNHWN3zTHKplpGMj2eaBw+GOY
	 YIGHxXmKFYOVDY1XWl/zO1pKqQ6FK6RrG2v020KHtTM1jpQbEQnFLO7pwdYeRg/TUDxp5
	 gvcKffCaNdM7DH8Af6+1fJuB2UxgQLlRBH58GDly8PykJ+QKIVwoghRnKOtGb1cEOSQ5s
	 k4Zgl9Biw9vZMuv/ZS12F14y1h39Ib4ccmcl/KHQxAcVunYDMVCKfo1q+RZzc+1FJ5A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791557930;
	bh=ikIqBbwcqhFOZshyXUnU14GPVMi9mTOrLoeYUtxpCqE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dRzwzOFGrd2xOuvP19UIjvSAyUthxOFwpUK6fm/WeERfTnQ0WWNxSQSdd5XVHxxRk
	 CXpPCmHwirPH2lZxV0p2uyEpxfImg+H3HoSGm3SJaKQpUFAI7QluYzaDQbQaKczokx
	 qKGVrwnig2r9hTk8AApHwcKmTdZ8RZyKCpjoVq28bizu6uI1YOe63uzvMeqRC4HQIq
	 Tq3TPo082VYpPBOfreX+jJp2e7984t2Vtu1FCiA7dyF7k/k/rV6I2aS/7C/+yJJpVn
	 2slx6ZzfEQUSiVDIb4WrFAto5d9P2yOTXLHu15q/6u8zspNwj+xKhr90y2L8982Wut
	 p5WhA/vhX7qPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB15640920;
	Fri,  9 Oct 2026 14:58:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DEE4317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13475400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiCW2jjyuIt7 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 14:58:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8B24B40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791557927;
 b=QXCz2hOhf18XG6PiMjxXIXknuPNWQjBnSdj06Lhamq5jqr7ova18qgxy/lbzV78asY10
 hwTP53iiF6esPy7YeFEDwuS675/rjmVy0yutlAR88gaejLwAA8XTb+WltLTDrf4qdPztP
 6mBbjd23bBvaTnB5GxAdO1LoMZGeOwZck7hGpdAAI4TtzvEkyi9BFh/wuqbPFIJeOvTr1
 Id0/7yNVfMvY34vJL9C6kCPIPnAx2LI6e75f2lI3r8gwsgve8emglYCHX29f0QfDvXxPh
 a+Tm8cXPE96NhIRJ8Y/URkkkycq1N50DVqPyKj1+YIGR0WaUilHQU8VWzGpaP5OYqWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791557927;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=ikIqBbwcqhFOZshyXUnU14GPVMi9mTOrLoeYUtxpCqE=;
 b=jUsV6Lb/6SLI5vdU9UyYO4oaRu2Yu6WS7mx97+s5GPXpUwSxy6l5hCIjfOkfgWA8yCHM
 QhJheE+vNlcIeUH5jq6Hijyn4FCtKwRJnuBjxa14oMwboIq1BSaNv1Bp4NtVdAdT1uHI6
 Z6FVqEPdKxMvycdbZjxkEun/gwa8HHP0Nq9xSJ2JvgOPqiB6fmbZVqjG2eteOqr7mcaOs
 uMuwimq6CzYd0V2Hfk4rpPJEQKFyhxJ8YUHMkqVa8t/NuFBmYPRG8/PMLyX991tUbLn8w
 HNfoyHk+Ku3OXdHmh/AcfSWNyHsg3i1LrocHAfmaohRDhlMeqBOpLSS2g1E/dLKXkjw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VdX4As2h; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VdX4As2h
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B24B40061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:45 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-30b6dad2382so9670012eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791557925; x=1792162725;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ikIqBbwcqhFOZshyXUnU14GPVMi9mTOrLoeYUtxpCqE=;
 b=VdX4As2hotHmKDxyLO/Dl6K8yizLFQXBNNwLjc8zWA5ZdlTynA4fUNaldR9ZVodocj
 K7YUi4p/8w5QulxJqBSd0O6FjEYuFcsf/EUau3JtwGWVMTSlV2v8REuKXM3+UULMF/Yg
 rPY78tYvCJ8TfEeqCNt439weIfs9QG5q6bnro4aspD68Ok/g/E+uGe0JN+QRYPI1YbPN
 p3F1I2Pt7T39LeWIPvkNGVoHhQ76WfHLDieNUjIjnyCjYHJmqalFpeyD2Q5jbhVE4Mht
 dbqA7qCeH5Df9c/XkBlNbnyickXaPlre8Oejy/MwjH71qtuDso+WYYvmJS5kjr8tZKDj
 XEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791557925; x=1792162725;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ikIqBbwcqhFOZshyXUnU14GPVMi9mTOrLoeYUtxpCqE=;
 b=hElIXvck2GadCYnenrDM2suduWkKZc2D33LJQbpgpA9HD/TNTx1XrOmoCCnFBYANBH
 CNu6L09p8J+iinmTXdnEVK26+JAD7q0shO+nHzkFnLaG4XcZHDM2yEMd9XFgte0Ns1pM
 EpSlKM1dGZNHpLuJyClOl5RE+OFaZUrSjlIS8zVrbRxnKAS+PVVE2cLsuFUebTM1vLYq
 GMX3RuSdNJDEfR6I9ekCWArzuy/G2U+0oSbalv4s6rB/EiXM4x7yS1UdWSZ5o51KUTzX
 cjoa9/CTxdL5t7SZY06ygj1leRkR7G1garLWKNUpfjNGKHgfHP6dehvkx5DRQqZF9Tze
 5Wwg==
X-Gm-Message-State: AFq9FYItWspiDNETyj3+HlvPt/Pzinkr0uZKKhmYRHN1w755TpyPIXsz
 a7u08Wrnz3sikHGJ68Vwnf6lemdNuf65qLchFCw3kJuTfvnu5BjReJBZPzJDWcMBZ1Q=
X-Gm-Gg: AYBFou3KwsNliboTiY0Es02ahV0lDHyciVyDpZDbnE4rN2yADQgArrqDcIvfAA8aFC2
 pka1akoGq6hSjCFIFxClGBN4QsA4XT/dFpApdKTNkJVVEVvW2OHX4uv4P0wXhm6joSbBa1LGk1b
 2utr+4FaW2JHp4XSRKlbRnC1nUfqq4mzlX+V800QSax1mGYjbHkBAa5RF2eyhpsihAgZkKHZA3n
 Ymv0FKTssemUkyXYMfZw/2sR/cDeEdtLjYreoSadVl2XNJe7YWbQGLni4aA/g0RiLnmfHeYgRpS
 pOlc2gWmNSm9U26rv42vCc5C1muh4rdV9zm/uLMyCUJxlk1hJpurGCsrkJY5f9+c/dGbJAZ6Z3r
 hKxKfm40rjvGigtp8ZE20maxt8DHOePoqgmKmfhdJZRZI6taEyzC5xyLbpypLQgHdl0jwrZQFC0
 QfnRkQ5U+tdHQduJAbq2zKjDFue3c2+epgR2ar1VV1x2p+vOp+5JCUyNzbtZ7zVmm10Qdql2pcz
 I6OKSqdAgvel2S67XhXX8zBYADTYtfbiHGRewhSMZLg7Zou
X-Received: by 2002:a05:7300:d081:b0:351:6a0e:2397 with SMTP id
 5a478bee46e88-3537e04282cmr2636425eec.6.1791557924598; 
 Fri, 09 Oct 2026 07:58:44 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7126892eec.13.2026.10.09.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:58:44 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Subject: [PATCH v2 0/3] board: sophgo: milkv_duo: enable standard boot
Date: Fri, 09 Oct 2026 11:58:21 -0300
Message-Id: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PTW7DIBSEr2KxLhEPA8Ze9R5VFvw8N7RxSAFbj
 SLfPdip1K66HGlmvpk7yZgCZjI0d5JwCTnESxX8pSHuZC7vSIOvmnDGFet5T6dw/lyonyO1MZZ
 cPAXhUaJA1uJIau6acAzfe+fb8anzbD/Qla3ox5Hwa66w8rT9sip6I3WM/yHN11wSmon6kqmVw
 qAXMDoFwyK3PmsyUhenKZShGTXaVqgewUDnut4y0dl29K02qDlDrUEZAEm2baeQS0y3/f4C+5R
 /ni5AGQXbSdcbr4RuX625nYNNeKh0clzX9QGO6QKbUQEAAA==
X-Change-ID: 20260929-milkv-duo-bootstd-14de5e4e03ef
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
X-Mailer: b4 0.16.0
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

The Milk-V Duo (CV1800B, 64MB) does not enable CONFIG_BOOTSTD_DEFAULTS
and has no environment file, so U-Boot has no bootcmd and none of the
kernel_addr_r, fdt_addr_r, ramdisk_addr_r, ... variables required by
the extlinux bootmeth.

Enable CONFIG_BOOTSTD_DEFAULTS and add a milkv_duo.env with a memory
layout that fits into the 64MB of DRAM:

  0x80200000  kernel_addr_r       (16MB)
  0x81200000  kernel_comp_addr_r  (16MB, Image.gz decompression)
  0x82200000  fdt_addr_r
  0x82300000  scriptaddr
  0x82400000  pxefile_addr_r
  0x82500000  ramdisk_addr_r

Also reduce CONFIG_STACK_SIZE to 1MB. LMB reserves CONFIG_STACK_SIZE
below the relocated stack pointer, and the default 16MB left only about
1.4MB between ramdisk_addr_r and the reserved region. With 1MB, about
16MB are available for an initrd.

This series depends on Zhuxu Ran's "riscv: sophgo: Use upstream
devicetrees for CV18xx boards" (v5), which sets CONFIG_DEFAULT_DEVICE_TREE
to sophgo/<board>, so that fdtfile matches the Linux devicetree install
path (sophgo/cv1800b-milkv-duo.dtb and sophgo/sg2002-milkv-duo256m.dtb).

Link: https://lore.kernel.org/all/20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com/

Tested on Milk-V Duo, booting Linux through "bootflow scan" and an
extlinux.conf on the SD card.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Changes in v2:
- Set CONFIG_BOOTMETH_EFI_BOOTMGR to y, as the default value.
- Updated the commit description of patch 2.
- Collected Yao Zi reviewed-by tags. 
- Link to v1: https://patch.msgid.link/20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hiago De Franco <hfranco@baylibre.com>
Cc: Yao Zi <me@ziyao.cc>

---
Hiago De Franco (3):
      board: sophgo: milkv_duo: add environment for standard boot
      configs: milkv_duo: enable BOOTSTD_DEFAULTS
      configs: milkv_duo: reduce CONFIG_STACK_SIZE to 1MB

 board/sophgo/milkv_duo/milkv_duo.env |  8 ++++++++
 configs/milkv_duo_defconfig          | 12 +++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)
---
base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
change-id: 20260929-milkv-duo-bootstd-14de5e4e03ef
prerequisite-change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61:v5
prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae

Best regards,
--  
Hiago

