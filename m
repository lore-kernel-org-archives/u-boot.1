Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAF7D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1E6845D6;
	Fri, 28 Nov 2025 15:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gWUROWbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973E683B8C; Fri, 28 Nov 2025 11:34:37 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A319283B43
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so11252185e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764326075; x=1764930875;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/NILuO45aEsshrxRq9v8s2x+46z4Qa7OtP4HrKPToE0=;
 b=gWUROWbNSoEZBICqfmNDsoXdh/d8nCxdNezjXVJA22WGTFZr03g/MiDwbDfMt3yp1b
 01t/I8n6Tat1JkiY4aDiyFPz6Pom1B9h5ZF/+Gwt0DKEGA93OwH0AOyOlMOXSwyxNYkH
 UY1Ej9gDYn5zKTmhnF0TK+MmyhIdAH4MHoWN1o+s0ygy/HR2TzKmCtn48sh4c7A91D3j
 5+BGtN4DK1jFACSXsxcH9oSMCj9OnBTzM37KQj+kBEzIJvuyESonLvvQrd26DmQm8gzj
 9eQ7Lf7Sf6/6+Ri80yO77663C32o7ZHHzkm6D7Y3FVnBqbeZQE8UArruP2ET4RIwzxV/
 UvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764326075; x=1764930875;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NILuO45aEsshrxRq9v8s2x+46z4Qa7OtP4HrKPToE0=;
 b=IAq377jX4RsDAbpVtkPxoLcHisD0inhCCi8qxuAqLWZNcVD5ddEpSSorP/P8yC8IlT
 zY0PqMWWHB/dbNi/6fnOn6v7WXo9BAbNATKUC1kzQQ2o5zeZ4IYZIaPa16Dx1LyBmsy8
 v80T1LwLPILoloGgrOG4NWvWiGdKMqWgTPUv0Lh0x4Oaxeu2lWO2wRfUFKWiNGe3DYP8
 Dqu/ulou4RR1kz286VKpd2MD3gfULyNjyrdTATJHAXaUGiz5uc7bgSUJ/I3lpKwIAvKA
 CSw55i/WsyBoCnqJAPHHeKAYIzOg4uArdWxL4EtXW1dfNMk547eDTyjl7uAGFXY2pB+Q
 RhTA==
X-Gm-Message-State: AOJu0Ywm6H6WLhCsgV52yAb3qzpV9By89NLwP4CcQeKUAKHg39rtk+ED
 NGD9pEqfw053qeGfGknjjdKB35FtsKYqlsrC4KIUIZd6DDZ2b7gBD38Yy/RP3CPQuoA=
X-Gm-Gg: ASbGncuIuJF3Ht5jRtn2Ff18TU+B19zo8IHNC9dlat7tYqaMuBZPPRqzQJCqbNOejKG
 VB5YkWByjhUjgpHd+RDob7YPzxT+fibC8s1haH4RkVNwdQRG6nDNXS2Dy+5I2N792mUIp9X2C2f
 rijqIs7Am0Pjjx6Fo66yUbVOR7bNF4plBFi+DtE29M+ubSwa/OpB4/wXAwPymHTpnF9C0ifyRLK
 dBnLJFoK2wSmuFwxBE3D5bcGV2TQ9szW0OwvfVtoIQGSySxQfYVbmRXIQwUi8Q/JdYnZy0Vn2S7
 Kp2LsW2iOQ+/xP/+PIb4JsHIBMOxmujE7b1E09VEbwk/6H7g3OHZs8Gx+bZLqHm6uwKXZ9rUCQl
 RL/rpU7Iy2AHcnxDTyx1EbGNc9u2uE8gAL8F2FWxJnZstfQhgFB0S9y9AbMyz1xGRj7TQa7F788
 Dc/qe3lRY=
X-Google-Smtp-Source: AGHT+IFscApmiaTOqXIREFb0Hs2OenjFNHjY8ajXlj2gA+55cxfIPo/9Tw4/3nBDhe7AP/FrkA4EAA==
X-Received: by 2002:a05:6000:1ace:b0:42b:4069:428a with SMTP id
 ffacd0b85a97d-42e0f1d589bmr16505253f8f.12.1764326075029; 
 Fri, 28 Nov 2025 02:34:35 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1c5c3c81sm8971042f8f.3.2025.11.28.02.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 02:34:34 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH 0/2] video: simple_panel support for am335x evm panel
Date: Fri, 28 Nov 2025 11:34:17 +0100
Message-Id: <20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKl6KWkC/x3MSQqAMAxA0atI1gY6OOFVxEWJqQacaKUI4t0tL
 h8f/gORg3CEvnggcJIox56hywJocfvMKFM2GGVqrU2H13EKodusRU4brjRhyrFBpVGpyreVM0S
 eIB/OwF7u/z6M7/sByl6OKG0AAAA=
X-Change-ID: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=msp@baylibre.com;
 h=from:subject:message-id; bh=tBVMdffR89dSf6Nl7b5lkm1hAXZ4XMOB6lrIbFjHdhk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzNqjU1DzZV/58tx1Iy3/LrNc0PJxfY/rin0NvVdUoye
 uIsLibujlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZiInQ4jw/NXhfcun1zklvRv
 waUy+//mSx1k47p8tfhvvZpTvuu8sxkjwyantxPcSidz/I7YdbtE78zWxqOa5rN8BKpl7A4HX+Q
 /wAwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

Hi,

this series adds the capability to define hardcoded panel settings to
the simple_panel driver similar to the Linux Kernel and adds the panel
used on am335x evm. In a second step the tilcdc is extended to support
OF graph to be able to connect to the simple panel devicetree node.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (2):
      video: simple_panel: Add tfc_s9700rtwv43tr_01b
      video: ti: am335x: Support OF graph

 drivers/video/simple_panel.c | 48 ++++++++++++++++++++++++++++++++++++++------
 drivers/video/ti/tilcdc.c    | 46 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 80 insertions(+), 14 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

