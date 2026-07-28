Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CAFC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8FF960A9A;
	Wed, 29 Jul 2026 04:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xy8AyJ2m68ij; Wed, 29 Jul 2026 04:55:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE95660A8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300936;
	bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1JMd+yp9n119DRc/xYoBRngtNZvTlGuHbHb1nnTD9sqT14SEBCjlhxk4t2lEmHN1W
	 LDNop/YBKOjBFcBlbEcp68oOXV1wT0zL1n1+0yq8zVl/mqKfoxi2lWHW1XV/BIAFnW
	 bQWfqfTr+RkLiR1frXRRvIsnPf/Ni3sEulZ4zCZSe203CpDU4r9xSP4x8cs/Dvfa55
	 IKxJJYsZ+TGZgCRKOr1ek91fLcOQY+o5gm+KcLYUt7MCrNqueepFjcCaqSIqRpsU2X
	 a6QJFMBnQSbzXw8Sq+sDBa3fVy/gypk64fSJZH9MECLvmRw+R/j6qCEzcSVaA3KlIx
	 JT/seu3CbkyuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE95660A8E;
	Wed, 29 Jul 2026 04:55:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FD34788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3695D40364
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsMQhILXxGJJ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:44:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4EB7540029
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EB7540029
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EB7540029
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:44:00 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso70248a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260639; x=1785865439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=CpcFd8xwM5Ymn9Z+rBt8vCRKsBk5es0PRrSth6o4f8FKAnowbMrKSpZKWg83B4+t0M
 4ECQSObGOU9rmFTm53HGZ7V8iy93R0VMkMROlwJDyO0t0IEZa5Ti8+7a2xRqucWkFvff
 Qr5/QZjKso1d1pvvdQq1up1NUNUVILazA2ahUAVr/O6MWC5VdBUSjVQQLPMcb0IqrnLC
 ZdYdelS9OCR9vRs3XqDjFWFogMgRsrGclKTV/xyFEXwp3nUc5LEpfsdDp58ikCWnwEx5
 95acl/iDDlaee3IZ6zhTfnq+rJQUI/SVksUV72ymKt9OXnYJ+kT33rCPRdbrbRoy2YhD
 EA1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoW7MelSY/9FJtMcQqaY1MPcJnOmbc3IXQw3CBnlxHEzpg76V3Uy4sxAvCvGBJRac+Ei8efjk0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxXyrM41ANASHzFi9MdPuJAD/1fVK3lirv7Bb4CQwJSB5jmVA+W
 shnvfLvgIYjypnHWkFEE2GpU26dECXe6mnpWbXNqVXlj4OLl2U/pUC4o
X-Gm-Gg: AR+sD11ggouZum1LiS80eOKm+s8HzXHN+x9WutTEQTDG1MYtH8pNdJQRyedAyevoJyH
 nEeisVcaxpU7MoXUsMTuYPVfu1LMBpYl7U4fLDvIkbwRMwjA+Bopl0rpJFpSfYeULb1rg8OXGYG
 WxyQ+f8tCkaZhYNjae2FjGBffFIbFsCfpFffe3IvBewBzU23CwI3K3ayoUYRgEyKrJCg1ZolhdO
 Y+TGPpslhHeUPjsYHvNRUE6LvsmLs17KHx/Y+it82/TaNbGLNDnzq9+sE8Ww8knRSOX3jvOB09P
 aVfn2y8xsDBi77uIv/z+UlBBBJP06Iw0eG3FYezbD+WrE6X/MhqcwB85htylljczgiPvOLF5J1l
 W4PK+GOvSPBrSAnem8N/jAgAwrKNhBuU33Plgqy+Sxi6LNSIFhdjJ8nWz9Ty+3KKi19R2JxpCoO
 WycoGzYeYAfJPgA3+2BDUJQawFIrUqayKsH53/yB6eAK2/AVlWKg1/1JQc8+uL5quNbDH4angln
 0yPRccapIpG5F41iwahLiTUEPG/2u5OpeIVw5C+BNE0tkyUS49o7BVE
X-Received: by 2002:a05:6830:67fd:b0:7ec:6512:ee12 with SMTP id
 46e09a7af769-7effeeeb672mr2850797a34.12.1785260639040; 
 Tue, 28 Jul 2026 10:43:59 -0700 (PDT)
Received: from [127.0.1.1] (71-218-31-69.hlrn.qwest.net. [71.218.31.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94389dsm271103a34.21.2026.07.28.10.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:43:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 11:41:45 -0600
Subject: [PATCH v6 02/13] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-submit-ce-series-v2-v6-2-80c1f7daffa5@gmail.com>
References: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
In-Reply-To: <20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260639; x=1785865439;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nqlHniaNzSC/qOv4KBGMd+0w8dZ2olMhTr1RXlmQ48c=;
 b=JJOH8ZheXNNOc9DMP73jvyeh0rmK5VYoHjIS7ii7wnq+rnR0mjlrr9NjQg7OwegnIt
 iaaUn0HEGLPFpCChS6K5Vl63S+loJWt5a1L82fPFJfgfdB+GUyDLDWTp9lJxTCh2kS00
 MlrJmBVNbPNKieAqMGEeeggsORS85CweYpleW8KBsLhFA68k6I7/r/PAV8241L6l+6VL
 Zhnx7LGRBgqyHkb3ORj4DTktDcsukHQ6lX4rfkuKa9vvXohegRnZ37QVKZYeAcxgpY86
 K+9v2hNbJFaBWezuGpg3hoEt2RVy1ZnIMoyqoxN1zLZ7e6gguJgNug9tazZDzqbacv3O
 cziw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JJOH8Zhe
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

The AES uclass Makefile is already keyed by CONFIG_$(PHASE_)DM_AES,
but there is no SPL_DM_AES symbol to build it for SPL.

Add the SPL variant so SPL code can use UCLASS_AES providers, for
example when decrypting FIT images before loading U-Boot proper. Select
SPL_CRYPTO from SPL_DM_AES as well, since drivers/Makefile only descends
into drivers/crypto/ for SPL when SPL_CRYPTO is enabled.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Select SPL_CRYPTO from SPL_DM_AES  (suggested by Simon Glass)
---
 drivers/crypto/aes/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
index 7e1b1b2875d..254cb598568 100644
--- a/drivers/crypto/aes/Kconfig
+++ b/drivers/crypto/aes/Kconfig
@@ -4,6 +4,14 @@ config DM_AES
 	help
 	  If you want to use driver model for AES crypto operations, say Y.
 
+config SPL_DM_AES
+	bool "Enable Driver Model for AES crypto operations in SPL"
+	depends on SPL_DM
+	select SPL_CRYPTO
+	help
+	  If you want to use driver model for AES crypto operations in SPL,
+	  say Y.
+
 config AES_SOFTWARE
 	bool "Enable driver for AES in software"
 	depends on DM_AES && AES

-- 
2.53.0

