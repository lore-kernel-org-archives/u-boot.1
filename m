Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D03CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2819849D9;
	Mon,  1 Jun 2026 14:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="W/mnaOc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B7784862; Mon,  1 Jun 2026 11:32:29 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934898484C
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso101006145e9.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306347; x=1780911147; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ijFV3OMjCLOcxvPAtyrfSqMRFBLbVk15KWsXaDdhdsI=;
 b=W/mnaOc8J3ji4QPZhTDtsVPcGuETkEg+9OKN1ab/BNfcF2Oqif6Z0gcQQUicPTNBBo
 HOkKVDAxCGWzzjzv1cIJVQF+EyuSEwH0vKszzIVt1RsqDrO8TrD//WbUjSUbyYWbjuml
 RMuN+SJU13JEsHObB8oO/CgNon2WA2p3FEB2nnO2slTOeQ0iansIKITUjk9iBimM+lDt
 jQ4CK9Bw/JweULdzgzMR0yQ59rzAXxSrXKz+5qqs0XpAQx7UjZFuS6ot5F6aWL7wkLYH
 Sz++U3pRG/ITh4tDeME6AaBpx3yoUqYjZKaEtb2iyKh1HWuH+2zXXFeqh7Oosx6T4K2K
 PiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306347; x=1780911147;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ijFV3OMjCLOcxvPAtyrfSqMRFBLbVk15KWsXaDdhdsI=;
 b=ZdnFtKQ9m5fqT0WLz11BsqgeQIFF64ktNhWdISl86GAviEvSh3UyGq1DO4K6myvfEl
 +Otoup87XWDvULa9tKF8VUe4VVqsydy46xCkQth8ifsSha1K0mPNj6Wb6olzY9wpDwE1
 eFTi6s/xSAfyoCHqoFubvJSnZ+PyGWbU+IZB4CukJxTDwPn5kF4apVhpcLvSpZvc4agT
 fdu96UetmP2Ra9w+oOsxuQkuuJY7v7lKyKAkpDX5/Y33l+IEoPtlM2Q9nniNNc9RFO+D
 WqrD2sUatt1ArOZTOGilaXkHzvZBIicLW/RlCT+VRY+5TG9lQYt1BlNTScCx6gzo/LyF
 kGSw==
X-Gm-Message-State: AOJu0Yz6RN7dKPp6MkVOaIVOjTxqhzzik3YW39nwZNMT7zsM1MHciQcX
 eZ7L++8vQP5BZ04m10A+v2fBuJyoLiovh75Vr6CzVb44nks0eqkPu/hTPWyP+yW/e8Q=
X-Gm-Gg: Acq92OE3/YwP50eyTh8VnFIaqSOr+hCF2uigAMsGMVL1QWGHvldCK2diy7p282j3L8I
 FVbpadNosbbRw1WjIdk9Tk3jVPd3K3I2YcidMsDAnj4v3m+wPSaMJT8qPsiZlIg0lZRtca7q734
 Oa76mGjyaj6Odzp4bNdjjSZMY33DPenWfNrs9Z72qAEUB8azRPv2t/xev0yJq22oIBQC6dXQbTa
 VA3NqUsYolZXNVP4m9aLQoxz4ZHwAQsVYYnhTS/j86mcaWKIKzxGa4ahKCL0nA2fqoVHPJJwrIL
 k1badrfSwOMM2mA5Wo5CZ4cA+P99X86JaJ83vZN2PE3/UXrx7zYUbmi6vLi6kNwPKsRsoGcj/Hy
 4ZHNcJPwJ41gBA+96QpGyPhWoTBQpYKEV1mxnFitmacLRAThhnVrcYzhR43DfA3sHdd1MUFGuSt
 sSGYU17EDZ9lwhKCa1eFYy6CMzEC0eIw0=
X-Received: by 2002:a05:600c:a315:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-490a2912132mr134881045e9.5.1780306346209; 
 Mon, 01 Jun 2026 02:32:26 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c09ab75sm72770185e9.6.2026.06.01.02.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:25 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:39 +0200
Subject: [PATCH v8 04/17] configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-4-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
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
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=msp@baylibre.com;
 h=from:subject:message-id; bh=E2TfUL0poVjf1vJGSwxapReYCVbFJInMmNBjzJN/aeM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwFDrWNHM0PXMlUW7VvW/ig/zv3g77anykRnLV1TPK
 d0sknWoo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACayt4uRYftEmYbfFXdb3kcL
 7PIpvMuWLn72wpJcf2uDMy8UC4PFrBn+59p1TNH+42MuNlV+1qOiia/e3PHwuDlhXWHkoeWvOlt
 S2QA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
index f12847b6bacf65ccf6445840e41229dea78edfab..173230e426873a5e7c64adaa47ca52651c151fa6 100644
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

