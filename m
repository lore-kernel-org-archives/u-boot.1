Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258EFC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9114D8209F;
	Fri, 25 Apr 2025 12:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="M4mr4Dsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D122E82064; Fri, 25 Apr 2025 12:56:39 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F76807B1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso460173466b.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1745578596; x=1746183396;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rpy8nXPXKCHq85Hxp//9tJuu5mXl5JUmsUK/xy810So=;
 b=M4mr4DspIofqyRLBdJSV0dKRyR1ASk8BKG73ENC0MdRIRrKPUx0babMw6mG2nHKVAi
 7YxwOiBMwf0uYrOcoowe8inxHB+SXkrYvhRWvdqiLfRUBNbBKhJzMnfhzLokYWl4xrR6
 wxaAzInRjKJyA2CPMETVKq9Qu6IeRYQXaNy5ZIsSgY1hbWGpvlIGJlkT3H3lJ+BW+vjm
 gQ3J+sXE9tlLhHt84jpUAdHJEjySt7iOi2xuEJaSfsT6SCzfDWcIteORxXqFOEgSVD9+
 noUHzQN7jlBNRBO+RaFpzVb5pzMUhp5RIZMnIPHDLPEpK2gW/GP/Bitea7/9/yzELveM
 jtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578596; x=1746183396;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rpy8nXPXKCHq85Hxp//9tJuu5mXl5JUmsUK/xy810So=;
 b=D8e0MIRwz3B/ri9gyUxJ/3Zu8fuAjD4kFm+7VU34YGLU5qu7mYQzeP3hdycdveKr6l
 UFgnLBIauu5BZ8qyqheJoG7zIBrlbVGW/v0IKgjsNuT03EYOMxrMe9TIGUDRXtBALCni
 DZRBt/WRVtJ80+iv6fYlsZz0iCkV4UeIbeHtJFhLoncMUQEC/yj36BEv419RbeqDfkm5
 xtn9uZehARYfh7JiJsB0qrQpmH0MzemQmzEAd3f/PNzH39rXmGZlZdVWZ3M54qKNWeHC
 UaOzRuFRlvFCUNW6FoMxMxpf6uAKcOBEFSelDXeTZ/fCVUII2sPzxxiySc3vMHY0zs6b
 bTrw==
X-Gm-Message-State: AOJu0YygmrE4UDxXvKEoQnTgv//EheaZGw4h5rmj1NWsVpxSum81QBB4
 bsNjT7MojHJSmd7zlasuHouA5tCHT1wPOmb/N+jynyhlsXuC2KAKZR4KoQlrNM51Z6mpwZ8rOaY
 1
X-Gm-Gg: ASbGnctO26bY31QjTxf2r0Z0yytYxDm4LdNJeGJoMZPQ3cqLxDN399+WmOQ/6bhhr8a
 7F9BZkOZih+EUyIlwjmjIMSInpabKeLUlIEGsoAOPumNROrARqs74Ni0yzU9aAo9p2x0tnahHhB
 2AQ8LGsqticLgP/BM1OxJFow+FXrmdevZJ1sDOFpL/Da1TlbPHYUEz3fs2Fwp1YL+/qLf+7hAsN
 ljI//mBw/gwGxYoinYkqvw05Hv60T757hDWAvJMQt7D1LxQj4XPfq0hrketPa4WNfprWIRt7AY4
 qczV3eYrbie574zLyCC8pUfj2UPP1xsbJFlBciZbfZ6BDaQ5MAY7CKWiaf4936VShQ20
X-Google-Smtp-Source: AGHT+IGAmHI/zvc7TGgM7S0OP2T2TTuJFBMWVRVCsH7lCy078pnkOvtfUV0pzT9NwRCgV5kqfdTtJw==
X-Received: by 2002:a17:907:7fa1:b0:ac2:842c:8d04 with SMTP id
 a640c23a62f3a-ace710b1105mr163844466b.17.1745578596557; 
 Fri, 25 Apr 2025 03:56:36 -0700 (PDT)
Received: from [127.0.1.1] ([185.164.142.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf8978sm116839566b.98.2025.04.25.03.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 03:56:36 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 0/4] Extend usb_onboard_hub driver to support Cypress HX3
 hub family
Date: Fri, 25 Apr 2025 12:56:31 +0200
Message-Id: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9qC2gC/x3MQQqAIBBA0avErBNSC6qrREjmlLPRcCiM6O5Jy
 8eH/wBjImQYqwcSXsQUQ4GsK1j9EnYU5IpBNaprWtWJk62JwcYlOeNPa9b7SMhsfNZC9VoOvd4
 kOoRyKGWj/N+n+X0/AW2pVW0AAAA=
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

This patch series extends the usb_onboard_hub driver to allow for
support of more types of onboard hub devices, and adds the Cypress
HX3 hub family.

First patch in the series updates the bind function, so that it no
longer uses hardcoded compatible strings.
Second patch updates the remove function, which allows the prevent
issues with usb devices reenumeration, in case of calling
"usb reset". Although the issue could still occur in case of invalid
initial state of reset gpio, it is minimized with no impact on main
usb_hub driver.
Third patch extends the driver with support for multiple power
supplies, tha same way it is done in kernel driver.
Finally, last patch provides hub data and of_match table entries
for Cypress HX3

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
Lukasz Czechowski (4):
      usb: onboard-hub: Use the ofnode to check if the peer-hub was probed
      usb: onboard-hub: Set the reset gpio pin before freeing
      usb: onboard-hub: Add support for multiple power supplies
      usb: onboard-hub: Add support for Cypress HX3 family

 common/usb_onboard_hub.c | 80 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 19 deletions(-)
---
base-commit: 10f48365112b164bee6564033ab682747efcb483
change-id: 20250425-usb_onboard_hub_cypress_hx3-2831983f1ede

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

