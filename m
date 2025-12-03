Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E01D12D6D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E97883FFA;
	Wed,  3 Dec 2025 15:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z2ydH7ac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 350EF839E2; Wed,  3 Dec 2025 11:19:55 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCF080077
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 11:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b725ead5800so871733066b.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764757189; x=1765361989;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w7kscIIiMP0SAKkIqfIKnfGVimYARcA4EJ6WsYO5jrw=;
 b=z2ydH7ac9cZeSFtYOR+ShxyRl/le8BfH4Eb3VJCdas0X4r4Cj8XRmRqBSUqZazrRrL
 k//8l01D7RpSdsU/et2jth6HX54i6Yg7igFtgsLEjfuFInq4InmpC01gU9OHI4w5ECGY
 89+O9xAJvYmGgHMipFJwvNwhZSv3HW6liwj5/7YW/55fdlJ3aZd5XgCofJhwf8iU7eVz
 amerp9K9XGeyFcuzxiEKn8RTCiVVkkEyHsAyzikJSKzYSeTGCxna9djbt9xc9VEes6yT
 1uWKxEZ/+ZAN4949F+Djj0J4laU1Op3tZgp/8e7LRR2uSE/1O9or3H7IZ/L4cvkjS0e7
 clcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764757189; x=1765361989;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7kscIIiMP0SAKkIqfIKnfGVimYARcA4EJ6WsYO5jrw=;
 b=nTkM/MrKN0+S+MxfRx7QDHATRuczVxI6gV+SysCrz9AiW5eqrdusR3E+5GvaBEvvBK
 9bWFd5sK0TcpkToNN1R3HEj9bEIVvzZyUwx1p4+VCSVJllNgisZdpwuzl6SbUH3lydp7
 mdkNLhRHyry0VyM/TKUGwNJv+0eHa++Q5Vmfd0lEDhKESYeAfFxZI/O3hB+DGGgiDHhn
 AR5rUNy8RwtuNpkJR+0GurEL331x/mteXdUeF8H1IDgT3KEh3s3l17YuB4MYArR0nU5x
 fbE6sog2tiDGzHMyVjarnWtGf7h/dHafBD6LcJdOtYKSLBe26BEikaxW2UH8hFljcre1
 RE5Q==
X-Gm-Message-State: AOJu0Yzy4lGXljZXQGE1jgTTAxQnRwNg/q0J/jO+/82I0En5Vhk+QiyD
 Jf5W1ZvnDt6AVT86TSOlsd/rtHbImsu0QHsItnvQxcNr1hYb2UKfDGC4oG4khHod7zs=
X-Gm-Gg: ASbGnctAmqRxLuDpHLx+foCztWQRBWTxtIYtk0BfFH5svl9va6s+hpUWYaY/0jkBH8x
 45vwlhNfjc/WeaN0RcdVF5nUZrQUgjMdzjxXhpRYA5VTw7EYMSFBoI5fBRFvxMLApboPnKG7mUm
 H1H7QS7pnAsx/6v6qUYZ4ZlO62fWa3GFQ51nIeNfnoXeCO2lmOO1xlpcn2oHSyr7/4R3CnDyIKA
 Hm5gsLXoRmzkgk5mQwJ1pcYlec7HzsiTEfra5j0VLGRZT1rHgGuohGBukCtyktcBRpgRG8fR7eO
 7QmsItRxTXh339Mk6qazXNPRkuVmoAX70ryv5cECqgwA8qapUuAPIh3SVuSAJS4RXszpcdZt29a
 cDPdIXF+MXFrEj0poK5cxP1hLf7HIW5m7F7uE2TaNlE4qckoAZN2yRT8z9N1JIt4V06ZMlCRffu
 xsh4Yn9DY=
X-Google-Smtp-Source: AGHT+IHJD5Qa7Ea/txJX6Jh+Dg8Qkx69Crh9k3cByym4qjuBT2ou7HqbzkG1b7aOlssBmjYq8OKtSQ==
X-Received: by 2002:a17:907:7e9a:b0:b73:870f:fa37 with SMTP id
 a640c23a62f3a-b79dbe9c9c2mr167427266b.17.1764757188758; 
 Wed, 03 Dec 2025 02:19:48 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64750a6eca9sm17667322a12.1.2025.12.03.02.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 02:19:48 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v2 0/4] video: simple_panel support for am335x evm panel
Date: Wed, 03 Dec 2025 11:19:09 +0100
Message-Id: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0OMGkC/43NTQqDMBCG4atI1p2SH62lq96juIiTSR1QI4mEi
 nj3pp6gy/cbeGYXiSJTEo9qF5EyJw5zCX2pBA52fhOwKy201I1S+g5rWBjBTsYA5QlGdJDL8QZ
 SgZS1b2urET2KIiyRPH9O/dWVHjitIW7ns6x+639uLjSQbxtXGyOdcc/ebiP3ka4YJtEdx/EFi
 8y758kAAAA=
X-Change-ID: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5C3x7WIDYjj1v1haSsAS4Ov88D0d2m0MCBE3nSSnvGQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwDvpVn5V6cfDKJxfdvylZO/dhs7gM9iu3Nk9smJRmzL
 blsbx3UUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPJjmf472a6zP+IfQX7821S
 p0LO7b44s0fPUWH/svC5lxSWdUkv52H4yRjt7F570GrmmfQLHC9fn2JVMJdaZqld9GrTNVnvcqE
 OVgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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
used on am335x evm. panel-uclass.c is extended to support get_modes()
for panels and drm_display_mode conversion. In a second step the tilcdc
is extended to support OF graph to be able to connect to the simple
panel devicetree node.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v2:
- Add support for struct drm_display_mode in u-boot and in particular
  the simple panel driver to make copying definitions from Linux easier
  as suggested by Fabio
- Link to v1: https://lore.kernel.org/r/20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (4):
      panel: Add missing comment for the timing argument
      panel: Lightweight support of get_modes()
      video: simple_panel: Add tfc_s9700rtwv43tr_01b
      video: ti: am335x: Support OF graph

 drivers/video/panel-uclass.c | 38 +++++++++++++++++++++--
 drivers/video/simple_panel.c | 62 ++++++++++++++++++++++++++++++++++----
 drivers/video/ti/tilcdc.c    | 46 +++++++++++++++++++++++-----
 include/panel.h              | 72 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 200 insertions(+), 18 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

