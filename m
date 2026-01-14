Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E94D37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4948352B;
	Wed, 14 Jan 2026 15:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P01P1XsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC6A830E4; Wed, 14 Jan 2026 15:13:16 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426208063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so65730075e9.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768399994; x=1769004794; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kYcEpA28WbB6B+OXD5aUbeLXRAmbo+cMpLv8jvs5f1s=;
 b=P01P1XsE3IXwNKy17FOsOgcBUpdkEGVEkC+Agz1/NlhDeoCQv0nL0Gs1YuwLVu5hxk
 vGCEmgwIa/HG1iP9EM8HqOx/BcS/1vtFl8oVzqNudBIahQReeMwNbr/Qs8vFGBo/V+WP
 PJznOvtMgikHnk5fRwhJHiGnDqaw7gMp62b6fWfRpcVpbObaybNnNUY19GybZNeFSXAX
 iusYPxPy9oHWfefOWgrFh7U2ivV/YsiLYCaBa01HHuIYQMmZBYZsVlM3ofepJ8BkB/9r
 59kWSwqUd3nPsTLWjRbaoIQlDKepZWMqbaAPrXkgrzk8GYRkrf/B33KCLnB59buudsmJ
 Nn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768399994; x=1769004794;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYcEpA28WbB6B+OXD5aUbeLXRAmbo+cMpLv8jvs5f1s=;
 b=M2ukCrdQPDYAff4ZJxWBUyg6+u8nWQBNaRgBBvjtzueSsmx7xJK/W/EbOyUf3pjBKa
 l2lIW76yhE8f473sS183/d6Rwp3/JdKR3bnwRrd4m9yy3Pph1KC/tq0yH+oGSqn1TZym
 cDUo/NoBJ2iSBsuWcewTxWLwNHWNkIO/r7HEVXbg8+7rSrKp/4TLuVfV3XXYiechG2yl
 88Pjs+EZVL8L/AMbsfNIRc+r1y52sJbKHEuIWco8J2fxk8J6fYPm+zQFbTRqfW5D/ZVg
 aqn7Qhg7pIQ+jF98R1jVtRzCb8hplGKa7dFa8QkF1HX/EAtA+PfJEf1QlEZtBr4vLU5c
 /BsA==
X-Gm-Message-State: AOJu0YyGce5IaWWgoZq9kRYC5lxbosWqoab6G6+s03XbplQKYNpsDS/1
 rrEHT61lhPa6WnlKE0eI38aHo0NwT3eS4+50SqxocR0i9QKHdJXXUqgrptypMruBolM=
X-Gm-Gg: AY/fxX5qeLPedKvN3KWsJpobw+OurmEAjl7lDLiCxNLOPqgZcdiTXtyLX9BpA1UP9aY
 E9ULhCBhemmINSSfUYrGz/m+8LzEvBOjz9f2hiT8LHnx5YdE4vX6pMvYocOJ+laxp2Hnyk1kN2S
 IUNuHlxv96/btqgwlXtf2J92O2psfSJs1uqICep0EvQDds29uc34STQkW6XhiJiBp6t/SbaBTKC
 3BwMXU0e5rpeXupgTNA7zOHKOMxNQOd5XFX6MXq2Qz8SyrQwgz4YIMvWnhuniZdbrITrv0I+YLH
 6totCNQLdll4/ReLvkUCsngDZtPR7GSWEgkuMlB/H9Ow/0M7ntd4TYlmaZRIYVXXpFHA9avcSWf
 ZB+HdoA4ALpDqUMUvTvWPsaVZAh8b2WYxIcmuXPyIHtyhtEjeCfojWVVsTkc5jZmm/zOUcqqp9s
 K9EBOY437lZFZSjJwd2DcNblU1v27syTntgs2AfQOUxp+L+s/GNV76puKkHL0NWGYj
X-Received: by 2002:a05:600c:4f0b:b0:477:9392:8557 with SMTP id
 5b1f17b1804b1-47ee4819824mr25383035e9.18.1768399993561; 
 Wed, 14 Jan 2026 06:13:13 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee5910fc2sm29279755e9.13.2026.01.14.06.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:13:12 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 0/3] usb: dwc3-generic: improve DT parsing and support qcom
 flat DT
Date: Wed, 14 Jan 2026 15:13:10 +0100
Message-Id: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHakZ2kC/yXMQQ6CMBBG4auQWTtJi0SCVzEu2uEXhhgwHVAJ4
 e5WXX6L9zYyJIXRudgo4amm05jhDwVJH8YOrG02la48Oe8rlmBYebHIabqD7aWz9BwawbF2QVo
 XKbePhJu+f9/L9W9b4gCZvzPa9w8iEmMReQAAAA==
X-Change-ID: 20260114-casey-usb-role-switch-a9ce370acd0b
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=dCGC093nf90qayy68vE1C43anzqxCANNzlxJXcw3EHg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsz0JRXnHx1ZfnMRM+vcT1u6giOu671YwCA4j+fBlRnyK
 Vpfrgo86yhlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATiUxi+KfXoaC4/GhkhACP
 3oyDQQUL1q19xn91W9TlmJ9rd5WpHotk+CufKFXOoMwm1yT6NJxlV9nml+wumQ8PpVdJfMr5yeA
 hdAIA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add support for the new flat DT format being adopted by Qualcomm boards,
this merges the dwc3 and glue nodes together.

Correctly default dr_mode to OTG when it isn't set explicitly, and
support the usb-role-switch and role-switch-default-mode properties so
that boards can express a preference when OTG is supported.

---
Casey Connolly (3):
      usb: common: default dr_mode to OTG when not set
      usb: dwc3-generic: support Qualcomm flattened DT
      usb: dwc3-generic: respect role-switch-default-mode

 drivers/usb/common/common.c     |  3 ++-
 drivers/usb/dwc3/dwc3-generic.c | 26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)
---
base-commit: 03c01c69806d4265070f14e7a7cbf617fcbb8f6a

// Casey (she/they)

