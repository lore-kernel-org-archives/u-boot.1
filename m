Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34ADC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 18:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BBED607B0;
	Wed,  2 Sep 2026 18:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tzdVcmwmCgZx; Wed,  2 Sep 2026 18:52:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 22EB8607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788375141;
	b=N5lDlW0oJo4I6lKZmAX94gBjw3m4Uxjfp5v3rtlWCmKKJotr1C4h1mpev/b3LTR89IDQ
	 pJYq+Y9kUVmTzZH1LkfaB52hxOZ5C540Rz5CnBr0Ta0pSwcRPJUCD0ovRbz8MUL7z7b7k
	 2/QR2MTl0GalgepTH+Whs6CxIDC+mEEXtjH9Vy0kr950aErYXcpf0KZW6/jNzaK2w4IIJ
	 GKGbkyr5p0lL9bUXqDGRxd+wv/soO6/ChYykkP+yG4vtbPwaLnElwhZ4U+fdoU74FfKKS
	 W2wa+G4vjsH85u5c3kQZrJoDOtoowiHooC3FUHrPQoJSrEvFfrJJuRpeUSFawQntg4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788375141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dt7hrEewNfxt21S/TmK+K7eKa6M14wvwXjdfYZoy8TQ=;
	b=ERDUWNTtu1hPN42SxN9ofTKy0TPklScW9lDRM/z0dM6TwGSwJIaQOIqVbijaKrUAkSVJ
	 iNupUefpGEyJReM+FP7ocGF+cx+kT4TkA3H2QY/cEaLT6mzia3fjzyq92Ud+lsrGmEUrm
	 SuecRhN81wc2GNkeCqBYZACClBuyY8WwJggmplJATlDDubIBacOBY7ArzQ5q0lROMF0i7
	 t7CV+cXsDtRxZB86XKPNE/qtab61EIzoBUztfETZna42C8h3hXCrr1rRmSSyEJeskhYzT
	 avuL3+7pdXHw7hQNZTejFiZQJdivk7wTAFDE2tZNd0OD+y2eH8GJshf6TTvBiqrU2HQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788375141;
	bh=Dt7hrEewNfxt21S/TmK+K7eKa6M14wvwXjdfYZoy8TQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JlZzceLessjkTOtGtMv+LYqY9inxqJW17dLsiBaLlqbv0nt7O8VAP96Wr38quUlyB
	 6rnOu94NCFTqqM2g3EaggWe+oHmETiQkAXQMGEQHPQNkDMDaZzh1hQJSDDz+vBjCzU
	 pIMD1TJ1mOcIjiMUsrvpnUg6eqnWFGIUaTCBSN1Q5wIsdD9rl3AapL7YhlJohQoK5N
	 p9dGr+GUrXHZo412Yu96ykbu/CyGqkDnnq/SgI7sA6J0yXesCJpgEQCpUUHTYBE1a3
	 fmdbyVGzU0Eh0TSVC3QDVrr8LFY0hSZrAXt8/NzYW6hA/rxH68wUforX+81Fbx+Wsz
	 1dynBo5J+88iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22EB8607FF;
	Wed,  2 Sep 2026 18:52:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB6C1D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEFB540177
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TgVAzI52LHvn for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 18:52:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 00A0540158
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788375139;
 b=OtMVKmSSAAPkVTlXvvAXGEr1tHgQG/ZttpJtSbg60lPiXPZ6AgLWruarJHsESija9ae4
 q1H8pu2zp6uKGm2Cjr0Qbrj83tJ9pB72YfioJDLdXM4RMVsXMZcAuQ6RIFYuJLK2lo73u
 BtSrwDiocIMQLp2grlN36F8BWdW9oQmqjqhFBVKZ224/CI+2tq2HDtK9bD03/mjHCWWkT
 ZoL7GPa6q22p1TgEgNAW8hRtrd+jy1tyIFeQA+ExZrM7bsA0RAJbt3PjGMkSsFs/vlW9d
 Qm4snKKXvfCELv4zNNbvJwy/Xc5ufDk0pEDvqN7RIr7CIggjvgmPTdeGQ4FZFtmHDFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788375139;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Dt7hrEewNfxt21S/TmK+K7eKa6M14wvwXjdfYZoy8TQ=;
 b=Kd04vZf7g8us8b+fgyDgFjyi4ySoC3H4InITB/tZQ6GL/Ri1oh8CYUPV2AI9XQ+Enbh2
 UUDJjyAyybEOUHiRXoprkKSxIouGF+4PCpuQO7NjKgwajhlrt8eEfFOqoyuEY9gpgmOcq
 5I7bOOx5vhKiVJH47HSJwQNXCXXzq+1d2Gzak3mY5EzGWXa1U5ZVO3xTIOSU/EOBrntOi
 MOo2to/aKRhgocsYH1qK/9U2tyeBaVRMkPE11HDw3J/aELryZoDJlyILvbSd/2O8Ytoa9
 vuouD1lYFiRq/6FcesVRrA3YeXmYZJQGdyxE/jIB8AbNngG+AdrtH2Wv5pBwLW5iyZw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Yz3Lz2CO; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Yz3Lz2CO
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00A0540158
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:52:18 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-467a6834028so918988fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788375138; x=1788979938;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dt7hrEewNfxt21S/TmK+K7eKa6M14wvwXjdfYZoy8TQ=;
 b=Yz3Lz2CORKXAn7kgRJAA8hLma4qdD6p45sT16vSXOpN+efnYcLV2TOJC2XVtCXb7K2
 6zGzRVIPxQIXzMOQ8YZ0OfjfISN/+0CLIhA3LJPuJ4IT1NjLPrpr82vh2fjiJMOAPCvp
 UQwhAYqKhUpalA0y8uMMQHok0mFi2FYwPFH+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788375138; x=1788979938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dt7hrEewNfxt21S/TmK+K7eKa6M14wvwXjdfYZoy8TQ=;
 b=jeRL7Xhj2btR0O+c8IyVb3vdxvXlZABsdddXF70gWJrlqelMgbZxTboYovPxA2zP3t
 XcwAva9PG3cISW1nk4iDATgeq9uWeq14vqCvqVXWgdF/O7wU5pQR5hFXP2srRDnC/+hh
 ujLVcAHNldkS5l8E1ZbMDRsZGpXzMwDI94UlCnt2dfY9bPGoeuD6dWPPZ+qxT9GJXVUZ
 2M4rp8w8oYxGkq+5kox/uIGFmBZwuawgj6Iv+KM6wcMtPUFEUhaSaGuzF5zAXLI8iM8J
 YE3Aw0y8WxCfir0V6XC7fh9rd2gP52g4Cji3655tVHEFhlPMKE19/5t5bQTJXdTIJ/yZ
 O42A==
X-Gm-Message-State: AFuF++kEErT9lk9CunRj5SAjYSIHhgfQk2Hbsg1+S84gt2K98n4DS0dL
 HWWV9oR5hf9D9DVqqciVYHOwOxM8LgduU1Ipnex+eXX8AaOESvURCRSjWFCgdC5vUkCIvLz3NBX
 HPddhL3QWTg0r
X-Gm-Gg: AR+sD13CMV43DfFLyzPperK9S5OuSjPhv/I67c6OUdCT2ma5jftmIcoezCe70Rkv/CP
 fwXJ6Yp2HmD9nJnh6zdivo8LxDwk+JoI2Gn6xhpcYl7VxC736B6JAU6ND0WLkCMEsdS4CdnQFTr
 JHurSMogPpu1MAUt+wUCs/NU6b9mAtQMAVEHA4t4dNM49fte1CoDO+sz9NDn7IwzncyoC5yRN+/
 kTfadcdgXM/A4tGLL4cdBO23OSJblKHHxYiiPqZpigi/kOdfijGKQRqAs4j1n0spH5QWoWGUy8S
 GRc59NCqWAcJlHnH/YytxwfSHlwwrAX1ndVTJwIqnn/l8xfbaN7lwrOhHKDpyP1xmkz9LfP0ADT
 T0CSpNbjtFMESBzFphvfXPUB0QqUhowTxt/I6TaJ1RH3tDXXnF/xrWnIq9CLcUM2Y1jU+ZAFRm+
 SrdgUwpfATkWTEPrVA6md5l0xDnkhlnZWoMmxKeWiCcpwktn6rMu6HabUoSDm+WMTIpk8YWjcEJ
 fCDfvJkeMzsDhoR5YpLQtTzczOdWGglu67eWtKjcBUWKsx9ZBxDaRprKlygwGB4KOvEbcLzSEvM
 2W85kba01JqDH3p81VkabqGkQA9niBFOtA==
X-Received: by 2002:a05:6870:f213:b0:45e:4deb:92e7 with SMTP id
 586e51a60fabf-46f898ce576mr5373565fac.10.1788375137576; 
 Wed, 02 Sep 2026 11:52:17 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f3046b2absm4852827fac.1.2026.09.02.11.52.16
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:52:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] docs: u-boot-stats-v2026.07: Regenerate
Date: Wed,  2 Sep 2026 12:52:15 -0600
Message-ID: <20260902185215.1802856-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

There have been updates to the mapping of company names since the
statistics for v2026.07 were made. While these mapping changes would be
present going back a number of releases, just re-generate the most
recent release statistics for now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .../statistics/u-boot-stats-v2026.07.rst       | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/develop/statistics/u-boot-stats-v2026.07.rst b/doc/develop/statistics/u-boot-stats-v2026.07.rst
index 724419a444ad..9956b11adfa0 100644
--- a/doc/develop/statistics/u-boot-stats-v2026.07.rst
+++ b/doc/develop/statistics/u-boot-stats-v2026.07.rst
@@ -5,7 +5,7 @@ Release Statistics for U-Boot v2026.07
 
 * Processed 1328 changesets from 212 developers
 
-* 25 employers found
+* 27 employers found
 
 * A total of 255173 lines added, 91237 removed (delta 163936)
 
@@ -763,7 +763,7 @@ Release Statistics for U-Boot v2026.07
    ====================================  =====
    Name                                  Count
    ====================================  =====
-   (Unknown)                             506 (38.1%)
+   (Unknown)                             446 (33.6%)
    BayLibre SAS                          179 (13.5%)
    Canonical                             98 (7.4%)
    Konsulko Group                        96 (7.2%)
@@ -771,8 +771,10 @@ Release Statistics for U-Boot v2026.07
    Renesas Electronics                   64 (4.8%)
    Texas Instruments                     60 (4.5%)
    AMD                                   48 (3.6%)
+   Qualcomm                              34 (2.6%)
    Toradex                               32 (2.4%)
    Bootlin                               27 (2.0%)
+   MediaTek Inc.                         26 (2.0%)
    Linaro                                23 (1.7%)
    Amarula Solutions                     19 (1.4%)
    ARM                                   16 (1.2%)
@@ -798,14 +800,16 @@ Release Statistics for U-Boot v2026.07
    Name                                  Count
    ====================================  =====
    Konsulko Group                        147099 (48.3%)
-   (Unknown)                             52846 (17.4%)
+   (Unknown)                             41196 (13.5%)
    Texas Instruments                     23592 (7.8%)
    Renesas Electronics                   19393 (6.4%)
    Canonical                             18957 (6.2%)
    BayLibre SAS                          13246 (4.4%)
    NXP                                   10795 (3.5%)
+   MediaTek Inc.                         9467 (3.1%)
    Toradex                               6609 (2.2%)
    Rockchip                              2606 (0.9%)
+   Qualcomm                              2183 (0.7%)
    Bootlin                               2149 (0.7%)
    Linaro                                2037 (0.7%)
    SUSE                                  1589 (0.5%)
@@ -833,13 +837,15 @@ Release Statistics for U-Boot v2026.07
    ====================================  =====
    NXP                                   71 (22.1%)
    Linaro                                69 (21.5%)
-   (Unknown)                             62 (19.3%)
+   (Unknown)                             50 (15.6%)
    BayLibre SAS                          47 (14.6%)
    AMD                                   29 (9.0%)
    Texas Instruments                     20 (6.2%)
+   MediaTek Inc.                         9 (2.8%)
    Konsulko Group                        4 (1.2%)
    ARM                                   4 (1.2%)
    Renesas Electronics                   3 (0.9%)
+   Qualcomm                              3 (0.9%)
    Siemens                               3 (0.9%)
    Canonical                             2 (0.6%)
    Toradex                               2 (0.6%)
@@ -856,9 +862,11 @@ Release Statistics for U-Boot v2026.07
    ====================================  =====
    Name                                  Count
    ====================================  =====
-   (Unknown)                             134 (62.9%)
+   (Unknown)                             117 (54.9%)
    Texas Instruments                     15 (7.0%)
+   MediaTek Inc.                         10 (4.7%)
    NXP                                   7 (3.3%)
+   Qualcomm                              7 (3.3%)
    Linaro                                5 (2.3%)
    Siemens                               5 (2.3%)
    Toradex                               5 (2.3%)
-- 
2.43.0

