Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E92C561E6
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 09:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7820660763;
	Thu,  6 Aug 2026 09:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-_hcrRALDMB; Thu,  6 Aug 2026 09:27:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00583606E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786008440;
	bh=x+WTJ5Cun1s9ytueasFrlyJ85RlSey4OOEyTetsag3E=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xy/PAv6qHc5wKzSF9SWSBQSzeek4pjMcT5Qoa/EzTX/1pejzK9Ofd2zpAzz282KSA
	 dNjS90Rx8gQV5PdN7o0Qwt/1Bnb2LjvlSpozrdyuEE8tI12BopnV2STjml90CHc+xT
	 s+iGHy1LmNW7Q6b98lbLBIMNg/VEzGidtkscnKaLcDVoN9qjD/B00yMoT/mctRlOt4
	 pkXrIBYdpV8nopAdMJYw0ZuC1YYEkH4uqPs78AH79DXqv2fGrVxrwNMjJDywjyydHU
	 JDninUzyzKp8a7ZZuCCWRhEFB4omhdEmCAvmgnLzgGaFWaKoo8fGG/o9S25rx/k7ZV
	 Fk6sPxNJmtOdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00583606E1;
	Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00670194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D55A9606E3
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ciz1M2G2qV42 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:27:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A9380606E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9380606E1
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9380606E1
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:15 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1275288f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008433; x=1786613233;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x+WTJ5Cun1s9ytueasFrlyJ85RlSey4OOEyTetsag3E=;
 b=ANmPlGUH9XiOsnZNB9p0wL0WfkWjDdzNGaU3WLTqOIygcLX1aadwfjWngYPUSn/Eae
 pyNGuQGWIc5R3Cecdtpk3zXSLHj+fRcU9Cqb5DkN5mEQJbPXJthUXXdSH3yJ17LmGknf
 Kxkd4JznWcK/uENWQPrP8kwSh3qX+Q7TcP4UZF4PgAXBsgeUqAFyreZRXpfFd3ZdHO6c
 oW7UUMDwJqeOv4BpItqqatHYaFFz0uRKkVCN9fPzNl48JBLQLDOk5xtM27VKQZbrX+v+
 z2BszpIEUYQD2VIErEAGtMyR5OaYlLT87z6Y0PqDGHw/7ntvhY0qOLbKGWYn6J0D43mS
 Iv1A==
X-Gm-Message-State: AOJu0YwEWuPtETwH+YCYkmnqYDBkW81xY+b4cFctxWPgty/NGryy2r4Q
 W1TzqzWQVHIPmkYC4N6cmVGTO8Fty41k7uKTQWMXl13wvLu2LEFzHQfqqfvvfuNlGOQ=
X-Gm-Gg: AR+sD100wXB+pYjSHdx3e9Jnd2WJV+yax5Qz0RJTKEYV5XaZLafKz9zoMAFe3eB9ILG
 4vn+txfdTeCAXfYGBettmwKlqwz+/2Jp04LVMtxEFV2J/bBPmdwsNKM89bp4mhSsjPB2k7KYIco
 F6d19WNJDaZ/f9wQDHCZqssnCe8z3DUZlvCoW4MRKmIbmriCSUrVHGqMNvc167/704xQRjojU/e
 fmjCq8mbR0BHK5nFvyTM9cDOJdEo0H6B+HvOY+PjApdJB5wlIE++WqusCspsHl2t2EJH8n/2S4a
 gv5fmcPJKhtqpaITTrCFMvnxlkxzHxG13h3bPH9BSV1TZuWHXTrZkYO8xhViHUTRDOjZ1qD9M8Z
 jqqBg2O+9isBbvsk24KB2N+mLh0q2c0ivx2j6T1+VE41Q9mcTkjD7g0F0K3j4SAe5ePTHw5KApZ
 eebxrGHznsx7VawZ/VEqGlzrncQ/s5BS92FD3rC3nfoGfRIYkycyMaOf3oeOV57bxxJ1jnVQTFW
 dnNflJagIn8gb7dx7Hoebnh5R6pUA/EqdhqOOAyha8XwhZrHkpIYCgXEu0OZYJWsJ8/HYHcYDpL
 SrOOiSru3NB/xs6jdgoBgKd2Q7wzwgw93OtbVkRV5esKTA==
X-Received: by 2002:adf:fe11:0:b0:47f:9441:51b5 with SMTP id
 ffacd0b85a97d-47fec4e73a8mr18764070f8f.5.1786008433495; 
 Thu, 06 Aug 2026 02:27:13 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b31975sm4147248f8f.33.2026.08.06.02.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:27:12 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/6] video: mipi_dsi: add common {generic,dcs}_write_seq
 helper macros
Date: Thu, 06 Aug 2026 11:27:06 +0200
Message-Id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNywrCMBBA0V8pszYQY6jir4gMeYx2xLbpTH1A6
 b8bdXk29y6gJEwKx2YBoScrj0PFdtNA6sJwJcO5Gpx1rT3Y1oScsefCmJXxJTwTKk3Y0b2QYB+
 SjGqij34X9zl4clBTRejC79/mdP5bH/FGaf62YV0/YXY+FogAAAA=
X-Change-ID: 20260806-add_mipi_dsi_write_seq_helper_macros-b4b43b7da4e2
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786008433; x=1786613233;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x+WTJ5Cun1s9ytueasFrlyJ85RlSey4OOEyTetsag3E=;
 b=ebhjkfk81dGBZbFzt5VU71xZSeNlwUlybVSJoucYd0iU6bMiGn6EVscTyHBQgu1GJ7
 94ql6wDPNnmmKJtNakdV3hC+Yjqd6KWL+UAxfV81+76aVExxbUjqkR4vBDHFuA0QDxSO
 satGdWTNUe8wI5ue9sSucN03iXg+yeoTLw9fYLMOau3m8ZJTPK/4ngAyUSE1gHwgZizO
 s+2c/KK32To/rKrDEX9Pf3coVWThRnldSPgG+QZ3+RyT+LEfHlvls44EcbjHeVZmekaQ
 lB1jd0nq/5KD1hxWISkQKD/vT3FD8KUjFmDLeTYdKu0QKdo+tV7fSCdwLVgF0jXTflgR
 k5bw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ebhjkfk8
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

Several panel drivers define their own private write-seq macro,
which is a private copy of the same wrapper around
mipi_dsi_dcs_write_buffer. The Kernel provides mipi_dsi_generic_write_seq
and mipi_dsi_dcs_write_seq for this exact purpose.

Add both macros to mipi_dsi.h so drivers ported from the Kernel can use
them directly, and convert the five drivers that define a local copy
(hitachi-tx10d07vm0baa, lg-lh400wv3-sd04, mot-panel, renesas-r69328 and
himax-hx8394) to the common one, removing the duplication.

The drivers keep using the dcs variant (mipi_dsi_dcs_write_seq) to match
their previous behaviour.

No functional changes intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (6):
      mipi_dsi: add mipi_dsi_{generic/dcs}_write_seq helper macros
      video: panel: hitachi-tx10d07vm0baa: use common mipi_dsi_dcs_write_seq macro
      video: panel: lg-lh400wv3-sd04: use common mipi_dsi_dcs_write_seq macro
      video: panel: mot-panel: use common mipi_dsi_dcs_write_seq macro
      video: panel: renesas-r69328: use common mipi_dsi_dcs_write_seq macro
      video: panel: himax-hx8394: use common mipi_dsi_dcs_write_seq macro

 drivers/video/himax-hx8394.c          |  86 ++++++++--------
 drivers/video/hitachi-tx10d07vm0baa.c | 180 ++++++++++++++++------------------
 drivers/video/lg-lh400wv3-sd04.c      |  58 +++++------
 drivers/video/mot-panel.c             | 140 +++++++++++++-------------
 drivers/video/renesas-r69328.c        |  69 ++++++-------
 include/mipi_dsi.h                    |  17 ++++
 6 files changed, 261 insertions(+), 289 deletions(-)
---
base-commit: f562ed02aa7ae4dc2775d90d2e6c40bab82e2715
change-id: 20260806-add_mipi_dsi_write_seq_helper_macros-b4b43b7da4e2

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

