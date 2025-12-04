Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DD3D1F9DC
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3547F84067;
	Thu,  4 Dec 2025 13:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FEDRJPGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7789483F5D; Thu,  4 Dec 2025 09:31:50 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343C183CD2
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 09:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b7277324054so94265166b.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 00:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764837103; x=1765441903;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sn23d0tb+U4fvPuy/HzukAM0HwcavNEYy95jJzVnZS8=;
 b=FEDRJPGzED57KNq1ziil5S+eBQNFbCo7IgXJdnRnsTrhD730fXvfG+WKplsg6gU27K
 MpxywJp2bEdZ5zxCM3ScPPh1YDzHerYbrUXgG/T/72mGee+Xffy/f7UjgrHpOAvx4unQ
 Ca3n0W0qm/IbeeW3PbIZal6ndjj3CwWjrmbCEIMJoXckE1mN+XefNiF1QYncr6iTRI5v
 TncumiO47u5fXU0HULRVowA/2wHYhBGCi8UWfbjaRnhQ5smhp4VczIVUZNvj352EZ04r
 HzGQJwldiyJN8Oap6e7x3NlyO0HclVTZX1sQYuWfcFSOhzpazaxxMRKQqd9WEHy7kPIU
 VBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837103; x=1765441903;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sn23d0tb+U4fvPuy/HzukAM0HwcavNEYy95jJzVnZS8=;
 b=gmYR+LkfcZRDo5/Pc5UXZf7bMwhM8l9dDnEj/FvrEblslzlPkIRW0LULvO16Cv8DMk
 nEMr/iIZUS2zB8/FU9LmNjji4jnp8MYb5JaacO1bhQ3zrvoVOYGLk9/X6F5jHADjO339
 ibK0c9HSXgxe3ojNeF5FSHuTh9+WhjnJl9Q47qyRKoupsI6v41Ns3VkwtxE9oPDzUf7q
 bNkeSpLihpaFiOppFQCuIz2hI4iab62/IMNpA+egsXPb38VGS5eI19tHDZmRPE1QNaSI
 /5wHJaMyNNQUMhfOhWoSCAl9d4ueVzvQb8SdGHVw78lopN6KlgejLdLj6zTLD0inIVTb
 aH2A==
X-Gm-Message-State: AOJu0YxjK/miTSQflE3I40/xYjYRfpYari8El4BNOaC6UemiCtIhR25T
 fDtFJR8srjmJVN9qC/nvkTsy0CL940govgE8bQ2R3LICg/xfokrBmn6cO497MM7bias=
X-Gm-Gg: ASbGncs4W7U8QcPGGe42eQmz/0EkqmHLng971BAXcZKb5NFMNrKRUpihApnmDS/5qQL
 lEF1113OhmIeU3n71QjJUlTDfqzeMWz3bi+QIQe7VEjhMCzmwLdxmZMb0ZZN601NtO9QQVzLOLG
 84PmUyAg0rjLOF8OALG5ku8kff4h2REHVE87n9/k0SBkF3O/zNNuA18OCvA+I5LYE3Qtdtkc4zH
 GrHdSd3GIkFcY3pyM9g4EthOaEIkycNlb5Dgnhvt0FcRFVOxNuuoIsZK5mp9Nm4mj8/H9HHSVrw
 JGRBUBlA2VcAFPuz9fv6ei3v3L3kV92y2BP+gP7uGl3Nj6YZDl+OKhC6t0D3mUYM9m8WZMt3C+D
 CK/l0LQFSyOnkHAO4reBk6tW1QXxHSyUi6S+lNt2TbRrsuveWmTdPGM7k8nM2pVBzOscElChPNx
 Oi4irwTxw=
X-Google-Smtp-Source: AGHT+IEd9EBqnWbFvNCE+cPX3efkaJU2/Y/aYE5wTYx9knpylaqjBRxpoKQK4IjQoXIW23LhIelIoQ==
X-Received: by 2002:a17:906:dc8d:b0:b65:b9fb:e4a7 with SMTP id
 a640c23a62f3a-b79dbe5b366mr467987466b.9.1764837102491; 
 Thu, 04 Dec 2025 00:31:42 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4498d2fsm73404866b.21.2025.12.04.00.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 00:31:42 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v3 0/4] video: simple_panel support for am335x evm panel
Date: Thu, 04 Dec 2025 09:31:13 +0100
Message-Id: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFGMWkC/43NTQrCMBCG4auUrB1JJmkrrryHuEiTiQ30j6QES
 +ndTbsRXIjL9xt4ZmWRgqfIrsXKAiUf/TjkkKeCmVYPTwJvczPkWAqBF5jHyRvQvZRAqYfOWEj
 5WAEXwLlytdJojDMsC1Mg51+Hfn/kbn2cx7Acz5LY1//clGkgV5dWScmttLdGL51vAp3N2LOdT
 vjhkMvfHGYOKzROOamoKb+4bdvehRKVxBgBAAA=
X-Change-ID: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=msp@baylibre.com;
 h=from:subject:message-id; bh=fy7iCorLPZeCOceHR+PL6U1ltu1vc1bfqZi2qUqKM5k=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxDtysHlbckPFW8sDYkY9unW09dp384wfYjwE2RwSJ+5
 /rQNbJ/O0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAirxMYGW49UplauD5mEqtl
 TXiv9zKR2D/rlzZ9+O5h7MW2qMqnRpKRYXvtuoSUzbGubOG1IrKaX7s7lq0zFPn9Ozy6h8PyT7Y
 ABwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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
Changes in v3:
- Fix typo in first patch timining -> timing
- Link to v2: https://lore.kernel.org/r/20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com

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

