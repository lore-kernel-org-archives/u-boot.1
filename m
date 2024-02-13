Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D1BC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 07:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8A087D02;
	Tue, 13 Feb 2024 08:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="DvOJdbcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC1587D02; Tue, 13 Feb 2024 08:36:48 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003F786DBD
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 08:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d10d2da73dso1650001fa.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 23:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707809801; x=1708414601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wr5niysp9Y8ARlPsMS8qvWMOLUThZvTaOTP5MDxEhCw=;
 b=DvOJdbcnTEmQVrrkUdLAJcAqTg+Ma5PlDc5VevLc/l3jK2EhV6RGdrseluTsZhmJEH
 uAXa1A7QJissn1h8aQ3n5os1Bo1OpQW4GsRGaqwcbUzsR8WQJ2bmWOQ6HHqypt6TGR8s
 6qf2+//iP+etiH8jjmbSHZr6NUG/tYrnvaLZirQ7wfzj05Hl/X3NNw+VaGbwAYszAnH6
 PKRES8cofNZq1l3jwDyyRl+1hv7wtuVyk3TGEA4T3b6lrtmynMSDsU43B/1yq1G2F/Ey
 cEKRaQq1D2BucOO30QnsILm+ilHjLhhRWxX23Zh11IU8D7wk4udX9JrbJ+/1R9bbxSqK
 1sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707809801; x=1708414601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wr5niysp9Y8ARlPsMS8qvWMOLUThZvTaOTP5MDxEhCw=;
 b=v5ZL2ij8WEMiY8QCEqfGI9NtrwfKVnylCXIKn2hLbAzDBZYys58v+mv1Z++b4IBAIJ
 cXJ8YnPDiBPiUdjdhlcyr9a7+/0q9kR5/8GzkFKzVU868v1bsdoOft5KcsfmDWWP80Vz
 A6IoNnkS68xiBWbKTIpmFtf5k99OuyYOxBfOd87AWExb8ynAEh+JWit2TAWWxp3/r1hG
 I2gfQLOoLHQPmrmohrO3n1Mzi4eF7yxlcQSJJxSP4grIC5g8I4oCK05z53Q5GLCaSLn0
 pqpo8hy1VWUxvZNiJfD0s1GmrjlgXRXEwmen20a61/BpIJtOKSbjXzaROFBB3BB47rXS
 WwJA==
X-Gm-Message-State: AOJu0YzFqRe5lNVKRVERRQtfnvZbJhEEkInzut8FQaZguwGgany6/78I
 C2GPOyllfJRec5wfgY3TWUHJgbTkYoRC4+6sLNePwzYFs35FSkVRZWtUkFihgOheiJvDzyWDFnF
 py2Y=
X-Google-Smtp-Source: AGHT+IGIjT0RA4aljdTRRcDTsAZSc8il/IwoGKkhwbnvVeLp2/W4LnbgrQUckHD3TvU3hm9QM3M6hw==
X-Received: by 2002:a05:651c:1546:b0:2d0:ed54:178e with SMTP id
 y6-20020a05651c154600b002d0ed54178emr6754286ljp.6.1707809801291; 
 Mon, 12 Feb 2024 23:36:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVtz4ce1bleaqHcr2ydsb/TBLTJUN7H4DPYNIRRQ6Bc/TcRnQYY+4jQNnio0z10jFWJNEQo1ajr7CzjZFNLyKOr8L5++TB2EDJLP1jStmPTInhfQrvU5yrihyF3xVmwSSNoPR1A0ZmhzGWTdCiLnmPfXKoswLxA/ZJxyQOw8PCH4p6N5pBGsAT8ZuYiJPzV2qHvBSluouKKjPstxzsSb7Yhaqj5KxiF8x+FOR+70K1v5U0grdmDd+jLB9mpT9eqiIgKCYWGGMEi1KPOeuCndyDSbCC0HMrH8dzF4jJMtvMSDjfDksUpDh0Scx4S2Z31R7vcPFlk5QoCo/5VB3YULAqciWVOmwPh1ZcT
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 z7-20020a2e8e87000000b002d0f98bcd81sm374790ljk.107.2024.02.12.23.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 23:36:40 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH v1] MAINTAINERS: add custodian tree info for AVB/AB
Date: Tue, 13 Feb 2024 08:36:38 +0100
Message-Id: <20240213073638.1125429-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Add information about a custodian tree [1] for AVB/AB, which is
maintained by Mattijs Korpershoek.

[1] https://source.denx.de/u-boot/custodians/u-boot-dfu
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46ba17647f3..32f3ee30710 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -62,6 +62,7 @@ M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	boot/android_ab.c
 F:	cmd/ab_select.c
 F:	doc/android/ab.rst
@@ -72,6 +73,7 @@ ANDROID AVB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/avb.c
 F:	common/avb_verify.c
 F:	doc/android/avb2.rst
-- 
2.34.1

