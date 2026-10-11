Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB06CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 17:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BC7440651;
	Sun, 11 Oct 2026 17:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBJl_7UYNHjj; Sun, 11 Oct 2026 17:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C931405FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791739385;
	b=pFti0AWv5LrckgD3cYdyvCGOyrHAj4D1AVkzzhYXLUawXf/OwnzAA38tTUhAdtv2415q
	 5Qbz9akpFnEFf4wZL8DTyxcf7hCQFM96HbUXM/NfwGxXiiNsLWzTuFboXVOWorCVbARdt
	 Rr5ag+BvwimyMoeCzsBR+qO9SFXSTNPu+HssIxEKoFdWyv4iHdoll3W5nXJl+PULcXIGR
	 WXI9luX+Vq3b49MqQq7Zm2pGftnZ19V6jD3UWkPcfqmRixAjACeRmPjUo3mz72wwnC9LL
	 CzgFjHzngtCAD993LT5Tf1BVoEdfP3KDX1Uwxu5oit6m90GC28L6j4vTPKnhomyR3jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791739385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=37DX2c2NFj+ZDTusF11oP5KAf2yjbH91zXyoGrZiGYk=;
	b=Tk5Cmz0C3Ip871700J7ZeDkEtlmizazNbfVmz7N6O1COSTclPHLDVMcu7HJ7XKH1IDJX
	 Qgkrxox5kMTJPJFoygyayyKr/TaAyalIhmoJm0jPYm2ezUKSmrwjmKotj/F6ylk+FbF5j
	 UlCUbvwUKpxqyp3Z1V/8E1+9LkY1FtNAxPQiOk5cvqXkfqSHYPeGu6ZD4j0kIE+Y3B7k9
	 6syfsCMbmM4qvV37TG5EV3ny1wwXGVRXa4WF2N77gAitSiGbxjQ8pfj+2DwdEQcBAwNrI
	 tRt40Nf8g5DlkH85FHAFNBW/3wDU3F/JcDHyShqMghLnXbreCm7FXSYBmbLDMxRcSew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791739385;
	bh=37DX2c2NFj+ZDTusF11oP5KAf2yjbH91zXyoGrZiGYk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D3j5ux9Jiijvz98LchfUVwxuqQvjHXPJR2+wCRG/mCufTudAlx1viIl49qmDZkHpA
	 ad0fArDWPtESV211ITUiim15fbbvOZm1NJ2gWnrxJIdOrlGCHhz1MP4RpZ5rnLaXeY
	 FgLN0P3oAaVtUVjIInHZRGazyULWYyo/EzLlbNNXPk8vXNtFlNGr4GOpuKZdv3Ncer
	 vRFVQppQRk4TwyuYbhor5flFOL7m322Zxq3S8Clv/HkQ921l3AnjKNdC6cmql+glcl
	 pIt680x6nqGSiJAkRRHWR0dhUm+Vlt+owfEy8NMqi8wmwyNm0HjlL7HZq1aOYNX5Gn
	 qWUql7t0/quLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C931405FB;
	Sun, 11 Oct 2026 17:23:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5ED9111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C6BB4002B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vck45LnXR51O for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 15:23:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB9C440061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791732180;
 b=TROkwETKdp8SAUbHfkGKfiZkyvsUM0i2a+q7bIAlEPCyn/CkkMpe9MLJdJg2pjzGsJm6
 f+OfW5PvHDKPae3obKf4DnBLoWZ/CJItfhyxThT3n7GFlFal5lrGP7c22dCqfi1aRIKUj
 R/howJLd2gb8IBgxLX/xJ7pWZHrDEtqaiHg3+IHyjj1w1Hj9V70d/d23R6LB/erb+jNo8
 3YkojvQAydHw7nhtNuBlMlpsakV0Ac+CDp+Pz2WHt9ZsLFJLOYNWOQBUWQrE5K0jy3GNx
 Uxvt/a6FheqkAz9bnpPRukNzSQatIi5m/c3AC8ATnbQYzvPiDY5m+RuQNBshco+197g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791732180;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=37DX2c2NFj+ZDTusF11oP5KAf2yjbH91zXyoGrZiGYk=;
 b=a6aSTh2efvX+7NWzK5yHIqlM1CI7sqG0IUsDZLZ8YQssdBwWADaacTx44yZFUyA9sC7w
 rYlDSBg1ya6eNXnb1fQiBJySy1j90FDXqUQ2YmQchpR8Yjcdd8MP2QGQMZ/am5GQJPfOz
 XY8qQh2cVYCJwqvRTuqMTGwf77mT6yxi2gPMIg/uODmFpfkk3znU+iLA9FTkOe1iNFukm
 fS2hlqcx8havq5oZ0oWFLyCbiVH2nvAoj92PFdwBRh0eKuOgKR0cASVM4W4CdJvgfhuFS
 1Sha9Xdp04B1DQHg8CGqdS/DPyF3qzk8edvGb4lVa5dwzFqfMjvBLQB8qWzJoRZ1JsQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=ElccN6Q5; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ElccN6Q5
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB9C440061
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:22:58 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0ADBE3F197
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791732176;
 bh=37DX2c2NFj+ZDTusF11oP5KAf2yjbH91zXyoGrZiGYk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ElccN6Q5/WcE/DJSQ6vqBPihf6alqO/S4K2YJZ3bgFn3tX1/VqVSkuJqsMSuTD5qX
 YtJmxguY2OJTl2lxbT7Zsdz+t/+Ol3Irt8gZhJZWyHUlo2xsi6MvgemkejMYxMg4Ot
 lIMPAT0svCGcB1E3amrSkPX/anHu1cBLUQS4wa6KN38sR9EygSX2d6aoWNi59GitsC
 HO4qzTja2plt/mNxe8gYv/dsQw+45m9Gr8rzOUUrY/I/eZNgZ6HfVbJqcpaKKPb9+8
 dlxb1z0fpHyKE0ANj8SKc6JGGihj5036Jh+d3zKHB26QN0sZ2AWZqXKzF3g6KoU+e3
 U5ecLhJyyq6oTMQKmcWdbySNXm2FlggXocnAoI4MH25hxbnQiYWUZjkUovEoj2gSaU
 lE0Y7AcodOOvQl7DrIJphfyZEe9Fw4y81NehLS8udaBp0ZqBTgCrLPV1ph7IF3Qygn
 jSk7dCY9j+IXNBca91RNjoOm39K+/PznAJSoZTVH5gqZIHkEsIoPxpA3rmCq+TYXUk
 6OvxbBa6gK3VBMTSyN5NteebAZFl5GXpyqwBErTAl0ANfLS/1N1Wjx4vE1kEWa/CNv
 6ZPSsLyWsde+x+XT8EdqqKLJKLxCLWrqKqZdDM44vWOwaMPZfxwlNI7bOe4AMH0Lw1
 26LYFgJhIFERw1A3zI2k/RBI=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e767948f7cso17064225ad.3
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791732174; x=1792336974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=37DX2c2NFj+ZDTusF11oP5KAf2yjbH91zXyoGrZiGYk=;
 b=nRPnc73P1Nkqa44+wKJ0uHSCtRTt3w5M2tl4w662suMUeYwHSIp/x+Hx0KKiWyCDUQ
 dw/r2YSEidnLvOTFLBjzqIZhP3c5cc2iVaa/iegZXQnZMxHnd2OdJy6LGZj/Z3/tL91m
 SHuk5HMgiLtVuYwEQIN4ZzC/Ix6Qw1v2wvkUUDSkcN0LusCG0y1t23NOyJhm6AHlJPD8
 iqNQJVDKbhypvGvPquBZ+dMv1v9fTpj6ZuTcRtEFpvDLk7tSGZb7Oh0l+In6tQ6jQ+Yz
 HYVIE9xe+xz5UPIxFH73op/GDn+ZX/0xelvc1fSf/dydXWKapTe/7PnuwNjgJBldTKFt
 0gWw==
X-Gm-Message-State: AFq9FYJ9Xec8yq2+GSXzb+0G96m5R6uYiKBu11Xk7+jk98l8nqq51SFk
 AKJ604xhBNHIYtcaZ8Bl4i0+4tHiZ3e85Lo/Pnl9A6/h4IQy8syJXoObM5cq738iRM/ir5F+bZ2
 bdkDWI5R44WDpb+faHxoSDZCS/ZghjfVsK/uxY9Y4AW7ad6gLpj/jemfGDRLbJQydUk8KvtfiVX
 Jxt9lBZT6N40xqvv4iKw==
X-Gm-Gg: AYBFou3cNRUluCD/5sy9UYEfZr6ABiTveyjGSHeCE6Gjwt8Crm3RUh02gbhIjS4DgVv
 l3J/+OvHjcgz2DekL4VmmQ6MMTw6SRfQ7HwLVsz2Baov7bL2KFA94zpEWu7zKdCNUH14+f+TlQw
 A2QujyftN35t7l5C8H0O1NGopufRRzGlXl3TRTz0lYr+yJLyHduf5p6AVkIO7KqOHX+RAhOEUXj
 CefBrQziZH2UIrIBTFwIuE4bJ5Chs9oE5KfUu+caImQwRARyo0rb7PpOHCSh/1o2lMuTkQT15ou
 TFE/6gEERtRUmrHP8liMrhRgvg7EA7IJ2bgVPIq5iSBgFvVIq3U/Xv3QaIKMYZDbvf8q7kTGGKO
 SNWtpqjY1r7IbVQYuYmFNmgtu2yfPoszd9vyRzMi59Jvf/BcybDvjpvL0QA4u9dSVwHr0hg==
X-Received: by 2002:a17:902:db0b:b0:2e4:b112:14d with SMTP id
 d9443c01a7336-2e842dfc25cmr65562275ad.54.1791732174341; 
 Sun, 11 Oct 2026 08:22:54 -0700 (PDT)
X-Received: by 2002:a17:902:db0b:b0:2e4:b112:14d with SMTP id
 d9443c01a7336-2e842dfc25cmr65562175ad.54.1791732173878; 
 Sun, 11 Oct 2026 08:22:53 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b5fd2sm33300445ad.50.2026.10.11.08.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:22:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/5] tools: mkimage: bound external data reads in
 fit_import_data()
Date: Sun, 11 Oct 2026 15:21:12 +0000
Message-ID: <20261011152235.8842-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Oct 2026 17:23:03 +0000
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

fit_import_data() reads each image's external data at the offset and
size the FIT declares, without checking them against the file. An
offset past the end of the file makes mkimage -F segfault, and a size
running past it silently imports whatever memory follows. U-Boot proper
and SPL already bound these properties since the series linked below;
this series adds the same check to mkimage.

Patch 2 makes the data-offset, data-position and data-size accessors
reject a property that is not exactly one cell, as was already done for
data-size-unciphered. This also affects U-Boot proper and SPL, and adds
60 bytes to the pine64_plus SPL. Patch 4 switches fit_import_data() to
these accessors and adds the bounds check. Patch 1 keeps an existing
test meaningful once the check is in place, and patches 3 and 5 add the
new tests.

Link: https://lore.kernel.org/u-boot/20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io/

Aristo Chen (5):
  test: py: keep the external payload when editing a FIT with fdtput
  image-fit: check the length of the external data properties
  test: boot: check the length of the external data properties
  tools: mkimage: bound external data reads in fit_import_data()
  test: py: cover invalid external data properties in fit_import_data()

 boot/image-fit.c                      |  21 ++++-
 test/boot/image.c                     |  44 ++++++++++
 test/py/tests/test_fit_import_data.py | 121 +++++++++++++++++++++++++-
 tools/fit_image.c                     |  41 ++++++---
 4 files changed, 209 insertions(+), 18 deletions(-)

-- 
2.43.0

