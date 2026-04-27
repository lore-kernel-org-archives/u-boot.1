Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821A7FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0E484255;
	Mon, 27 Apr 2026 14:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MWDL1e80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C65841DF; Mon, 27 Apr 2026 11:03:25 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00FB83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so10132410f8f.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280601; x=1777885401;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDYUu1aHVrYp0+wxOiCzVg/9i2lTGsLfGTX+3LGFjyo=;
 b=MWDL1e80Z18qkw5TbOJPaRm16mYgGbB9g3hQpnWNudrVYgguzqZ3dxnsNCQiBWZSUK
 BvjARbUJYe8JJCYQdwkcfM/DBNVM08YTRJfDmKFjTyCDyIUFfSbglCYP0wUJABfxfoSp
 SLlAsvP46u14VA9XhwoPxGOAge6ie38b477WGPTH+rmoMSlsF3kUArhsMfyjYQcEGDCv
 BpViy/O740P458hvgkYwfF1ikdKpsYex0vzh3uRS0BxgAm583Pgulb0Arhb7Sfm5Z871
 FUvi11gDE7GmALgWg/bYDUnjfA0LxDjNP3s8MqsGFWuh2ZnJUKn4qQaHEcJ13ZFk0hOk
 uv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280601; x=1777885401;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lDYUu1aHVrYp0+wxOiCzVg/9i2lTGsLfGTX+3LGFjyo=;
 b=JLiSiO1YwOiAbaHb96rCl9VdvXpLyau3Zi9dIeTRYd4DOp2rJVlaPxPSCyL7P8ffYB
 ucEQipldu5WS2c2SjD5beoKf9oenmDBb4Gds61HGseYJyWU+eKXbbB/Du3e0Pxxn39bC
 Pcplt7+wGTeLgs46NPwV/ZZRPv72FEuXLu5t0q6LnoQUFUcRqzXb9Th5OTAv9Q9apNgd
 pHHRM+28WB4bU/5ZrFzzsx493phvafq/eyXh9zuO9jeeRy5Y4MKWn9EbsFM4MYzGJZy8
 WPtQrgmzPHGU6mh4fQryuRJoyu6zkYdP3D7Icz3AOTi1AZP+b3sTqOhuPsMHMvrqtJfE
 FrOQ==
X-Gm-Message-State: AOJu0Yz+MIH0bYBcqdlp2T+gBjoVOMOvyqnUxQcSZ7AyfnFQZENVwVjt
 XmKs3dml8wusnQRtolqN9GQWV7LqaskCzC2qjw9KiO5Ka2YMqO1dwDjgEmghWjqaamc=
X-Gm-Gg: AeBDieufahRjgGgMt9HjvDYe5fOK4LR7w/hIUieSwVRwwQFhiNlK7L/7XCfQrt/V2Zz
 6DcRyIe+SZVvONW9ZnjdDT5p7stKNwhCmQzrPK/Py4jw/IaBNYZ6ot1idEe4f0wz9HR17uWjUD4
 9xLgrMdRF9ui2qn1u/R4yLicN3isaSldP+uVIm1LV9zEg+PswkgrYobh8f45kSJNJj46VT/y9sU
 tnuxi+FtyfH+4w8/J0K6gUArdydVLXSHMAmVOtvPzX9Mq9SgxQNaBC0XBGRYaCo8mdtnT2rK2gf
 Zn1G2Tn9ndn1fsyQ257QKqOyMLbN4z5GIQUbgjW26CMzvWD3RysBkKF69/fRsnlJXEVtZkAW42k
 9cmmamDcZgIRFxjGo3IiVP/yEGFeDalqFye7BUflDQqsaeC0tx1uSwvXJVJK2fOCcvZh1nweBPE
 Lv62+Xt7Yb6kG34L5IzQ0FGjsA34TZDMU=
X-Received: by 2002:a05:6000:24c3:b0:43d:dd:8ca4 with SMTP id
 ffacd0b85a97d-43fe3dd33d4mr66970626f8f.14.1777280600705; 
 Mon, 27 Apr 2026 02:03:20 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm78499909f8f.16.2026.04.27.02.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:20 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:20 +0200
Subject: [PATCH v7 04/14] configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-4-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=msp@baylibre.com;
 h=from:subject:message-id; bh=I3wCr584w4qrMpmEFlt3u8b1PmfLml6qkprQmPgETBk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3avIzalddjqz6ustlXpKH10YvTdazEm4leVHG0x41n
 y/ZoODcUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOZbMrwP+PL89AdAS3s77eV
 7VKaNV/b47X4qvPdf3vfiM7KaLm59BAjQ9/R5Vf5p/a5Ma6yaO2PvZY3/6ppI/eWlfwKqwTzlRR
 msQAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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

Enable SPL inline optimization to shrink the size. After enabling
OF_UPSTREAM the size is otherwise too big. Enable it before enabling
OF_UPSTREAM to maintain bisect ability.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index bd188c252780fb541afbbe61a243bddaab79be93..17c0f840d3ad3cb6f09fa914655b304e90d0066a 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_ETH=y
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"

-- 
2.53.0

