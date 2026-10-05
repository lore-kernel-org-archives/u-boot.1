Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEE8CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A723A4065B;
	Mon,  5 Oct 2026 21:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Hs3EQkVaNs8; Mon,  5 Oct 2026 21:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0655F403FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791234274;
	b=ewJc3/2Dcxq1h73WSmHScwtd1i1pe7n6P2+SUz3G1a8bZ9ujXuMZDS93AazxOTuGBlMP
	 lph2EqvKlxtMfff6u7gXUcgQ44jkZEAnM49uMGPtq282aGIhtg3eqglfwhXOUykTm/Lto
	 caVQd7bgsP4+NkjMCz9FWN+oNarC6daVvznG5x7VHepJBA59LnH58Gxv6RWjsvBhAm5sj
	 QR2h/4xIVKGaCcTw7vlMntAzRM4ysRLtMxVzxvIvRjmapNI+1Y3mj+f/yGFdW9IW+4wmU
	 LT/g4A7av5iIYPydM4EK/rUQkNgc4HvdkrxAQMYk/C991PvHzcVnQwyYBasZzpouHRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791234274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ryg+J0QMyo9G99PxxCQmqJKg+CUiw0O4deDxTWuEtmc=;
	b=pf8mS0Q9UOr1TlpQoAWAUOXUULYGaD5t2GfLNpayw4D4QQWSLofyhScumZ1FzSOyIMQe
	 t6egu+cIpWdj0bG5ahxuv5n7JD6GLM0DXQcPFQXR8bgZCRAIkLGWtTu6lAm7i7PQ6zH6W
	 X0faIa/7Y8wV7edHPhiCH/FpsqTkbH0KGjnKFIYqE3EAZjXDC75iCVmxYS/9031E1jAE4
	 ftJgRlJVwoMavQL8qy18tG3Ty+TwaFlwdOxRUdfoyilDfx5vcy7nPasrkjC+GtPTiVP5S
	 hXl3S2ybQPi72UrY9TTKkjJTxxkPO8DggGcQvgAaVqTEB1QYU+4Fre66tPQ10LQ0qig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791234274;
	bh=ryg+J0QMyo9G99PxxCQmqJKg+CUiw0O4deDxTWuEtmc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R5yHp7ecNN63cTpxOeZQ4SmMvwNF2eelD1iRCL9Pn7n6XfEhWfjHsmJa4AUSmV0FL
	 zILTtQaM1w7LvtvIIKc0b1peAYjnivkhKWKrWU7hzVu0/L+uSdV4wYb26RNGMCM0Cf
	 PXHYejDJBVWGCSQXTuoXTdwADrCuXcoK+2nTsly/CFzEdhvrP+b4bNbC995F58QYwB
	 21CI8IxK7wnCtuT/UTmvFAPcw4YCsNHKZZkeOTfeeeiRuBcRlhrCM2f6Foxn8zfwFu
	 CIQxpgfe3+b+aJLL7caN68Rs82lSo//Xn2YpYhhoTTbCoK5gvFjGqDMp0NHzcXl4sE
	 9ucyuXusIEa/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0655F403FF;
	Mon,  5 Oct 2026 21:04:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ECC0F317
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 20:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2A464008E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 20:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bv51DRX8zpF4 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 20:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9576B40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791233478;
 b=S0Bq/3XlBslSJWS9ljCyFLQbp8oOc+rfCCaO0Bhng0GO/VaKgmHSc751++tksCOGbOC7
 SQov0E33CE3z+aUDH9AmrmZ49Y3EfJo6vZDAnne2NAV1VcrsLf0r9OnXqjtgAPS55lfWC
 +zjgTEUnunYauRlT1xISwTojwXb71x44Uth1aThS2c9DGqdBkeoU2U3GiAbt1s2ydi5zB
 NCczG26rDMgOCSi8MRSFobxFvFCUXEZGVGWQngjg500edp/d9rmYlctrIqM5DYajTiM/R
 vFlmC9OzseI5gA3gK0i+cKkA6EAT0dSIgaPJoel+R7q6fHY9wUExpP0CkwCV8TKGWWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791233478;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=ryg+J0QMyo9G99PxxCQmqJKg+CUiw0O4deDxTWuEtmc=;
 b=awbt/ljBheilr6SnMrzlZjL8/T3VI29IZ+nbgsC3LN1tNS6Sm7ait7OVgEOIM+fik+Jt
 Z3lhAZsmDH6pOgqhxMJEEtgBDmQZuEN4f0579r8H10gha3oz4wNBQ5Wdr6DYhClP+XvGj
 xn/7O+AA5xSUyl+dyCepeso7lqSa4qq+er7EBiJ1OtHHpaewd3rD77lfo1YuwDbb9T6ir
 9kzro653Jh5RAxwinxNB9K9OUuoT2fg2Hh7GvM6lmP/MX5l2TS4KBXCRFOEnq39ZGnhrs
 eXI/XnN1WxPiNQH7ku1hvscYpd+nksuTD9jfIf1njz7yfTNckdT7ncjAWTdBP6qds4A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=alCvaAmv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=alCvaAmv
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9576B40042
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 20:51:16 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6defc0a3724so589440eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791233476; x=1791838276;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ryg+J0QMyo9G99PxxCQmqJKg+CUiw0O4deDxTWuEtmc=;
 b=alCvaAmveSxBvcSEaBveOy1UTY30iARs6oFXtPjKDgrimkphBIyRyJDh9FVLgCkMXY
 81ky1QrGhKV0s9Dfjk/PFoLP8/OtQ8X5DTlAZeMn8jEcmXyDmSXZrhWn4tUDZ4ePKrOE
 +RqJM9r06+Gs30CNLKYv+j8KtaPzP7P69waRa3NmU8q2rLwtHyJLaeY/uZLZhx1HoxGv
 h/5uw52ZZqbUXHdPbL/jQCORJWy6ws3JnPCKFf0RQqP6fBnT2cvgV43Qq0v2hauDaAoJ
 Hn8lNkVXQ2tCoyZDVUg6/xRSx9bKS6Oe+nMsdsvOLZQWPb0Wr4omwY2g632T+jz82Kb9
 VQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791233476; x=1791838276;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ryg+J0QMyo9G99PxxCQmqJKg+CUiw0O4deDxTWuEtmc=;
 b=CqHhVJtWaxfBD4BQlCS7KcHxERc+gOdQncEi+NRFewV5khmvPd3aKjzmVKf8QynExz
 DYMnpDnrf97V9r0wAqgLpVQZwqn2oFoWWzWCNo0jVWD7fwb98oomkHRfFpI4LlPnnJiq
 AfDF1x6cvz3x3X711S9t3J9WAWrPYOXVD8Z7c8/Yy5dmyGNi8ggBCeqtilT/ahyMloA5
 I4RujQ+LlshtBeQmA/MvOZmn2Dvb2/Gpp5/Zkw543xuycVQmjJa8W7Oo5MGm7cLo1Fpt
 GRWOieGLJZkSLoKR9ub9VZJ+nZiqqBuyYonIYtLgkp26aq2ZIKuwZJAHNe3o3yuKPt2c
 wjYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUyNeCCNjoU+JC9aKG4N5DNhMqRyTIEgQSCa2XNmS6zdBVapJ51CDkZL3S56PrLfcNixIo+qY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n8YM4TdU1soAIhRxvqtk9Icl68dm+w2cr9YMR5LEU/5xmbV5dG
 3YBg2rdVn1JsIlHCUzqOHoKCbZur+HWQKqtWtATPbOkG3mCPhGTs3aJw+dvQdz3AYd4=
X-Gm-Gg: AYBFou2hVB5hpuc06FlnRh+h1RS0Hsj9q40ZRDUbGrAyrZrkClH3NnwiJdrGmDes+A7
 oktWi3oNyPahVEZ7XBL+rEOywL+ktuUbpyzybJKpJs3Y7SSJRPq1FRf3SSLgB7BccNsAneMhau1
 zlSYPAKCmIJljmYOwCp4Y8oure3D9dMr6OzMbdv6675jkxYsGPKjdZXspfSh/qYdI+pz8twsPWZ
 fFC5da2KNO5AT9F9co+QSJ5KDDz6ju2N4TKRCDL1733+CqUJY9aGzScnsHLn8/LAIf7sRH9gMia
 zKnTHJ8+ULpQ7ow1gqM3Dhy3qSFNtzwpYaYU6wH5Ly8PLEsjyGpn9X+BWzx3z6ELO4LM70NZRbT
 EiBaA0a2/ZxM1Py7Heoyl1PqZVx9uuQW1lqaEDfz9tgl0ILCT1XWN3eTGsr9mu0QMmGMp4ZDJzL
 +6gSVdCLOKmUM/nBfEhtKIUlWUeOpJPAMJ+RwXsyQUPN3wTXG2T2cxBCcZG0bFwMNkGtci9qZJn
 A0=
X-Received: by 2002:a05:6820:f012:b0:6d8:ac5f:88af with SMTP id
 006d021491bc7-6df3448c37fmr9373318eaf.33.1791233475889; 
 Mon, 05 Oct 2026 13:51:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c04d915bsm451021eaf.2.2026.10.05.13.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:51:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 15:51:02 -0500
Subject: [PATCH v4] video: panel-startek-kd070fhfid078: new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-mtk-video-panel-startek-078-v4-1-2b18dc72ddb4@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PTU7DMBAF4KtEXjMQ/8bpinsgFrYzoaZNUmzHa
 lXl7jgpEgihipX15NH3Zq4kYvAYya66koDZRz+NJYiHiri9Gd8QfFcyYTVTtaYChnSA7Duc4GR
 GPEJMJiQ8QN1ooKY1lmvUbd+QIpwC9v686S+vtxxn+44ureTXRMCPudSm2xixJiK4aRh82lVrm
 ZtjmjpvxqcBy7N29VOAEc+JrOjel/9w2S7IdDP+tWymQEH2WhjZMCGse7bmcvQ24GOp3+jMfnB
 M3edY4ZxUXDDbNJrLPzj+zbVU3+d44RSnRnGHTMrf2y3L8glhycNovAEAAA==
X-Change-ID: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7
To: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16346;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=6x9d2rRQJlDsQRqqTagS6d7gPFX9m/LUa9fZ4a2EbDo=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxA22vJNkwvlU2h4QV6lf3lI27/r90erO1b8eG
 NBRXGjKuruJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQNthYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAosIAJy3wi4r7qc58fzaiiJQEHSX8bT7GNRFD3553UD
 fJO0IyWjRXcz4MfNBmtMIEeTglRimF6kpnjX1EduzqgQEEQ7hulcy4kSn43cTe/LhNsSY59zwHn
 C5cn7jj6RKZNR5ASMny+B0RnVUh4eKlopfB8S37YFuhxL0H/73LDfCb5si/iaXh1OYg9t5Gftg4
 GucoVk1E6RZMZWiG/MrK1VdxoG0emBmTrqKYmNDGwGIv/I3swgSrlFdMY6Hfs1zkkzJKYXEgLQw
 +EKnFNWfFjl2sN8GZ3NTILHy2NUYKZ+DzU82vKQu22wCQn5+Bp484djczDJvcOd04eCHCfmq2Mi
 rx8E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
used on the MediaTek Genio 360 EVK board.

The display mode, DSI mode flags, init sequence and register names follow
the upstream Linux driver panel-himax-hx8279.c, which is what the
"himax,hx8279" fallback compatible in the device tree binds to.

The MAINTAINERS entry is merged with the existing KD070FHFID015 entry so
that one entry covers all Startek panel drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Note: no defconfig enables this driver yet, since there is no MediaTek DSI
host driver in U-Boot at this point. It will be enabled together with the
display pipeline support.
---
Changes in v4:
- Use the register names from the Linux hx8279 driver for the init
  sequence.
- Wait 130 ms after exit-sleep and drop the delay after display-on,
  matching the Linux driver.
- Dropped the unused errno.h include.
- Merged the MAINTAINERS entry with the KD070FHFID015 one.
- Link to v3: https://patch.msgid.link/20260918-mtk-video-panel-startek-078-v3-1-631a63ce255c@baylibre.com

Changes in v3:
- Undo mipi_dsi_attach() on the panel power-up error paths.
- Power the panel back down in the same order as the Linux driver.
- Dropped the dead IS_ERR() check on the optional enable-gpios.
- Simplified the return from probe() and reflowed the Kconfig help text.
- Link to v2: https://patch.msgid.link/20260826-mtk-video-panel-startek-078-v2-1-c56342b77835@baylibre.com

Changes in v2:
- Added missing BACKLIGHT and DM_REGULATOR Kconfig dependencies.
- Use the display mode and MIPI_DSI_CLOCK_NON_CONTINUOUS flag from the
  upstream Linux panel-himax-hx8279.c driver instead of the MediaTek
  downstream driver.
- enable-gpios is now optional, matching the binding.
- A missing backlight is now an error instead of a warning.
- Do not request reset/enable GPIOs as active, so they are not asserted
  before the regulators are enabled.
- Use mipi_dsi_dcs_exit_sleep_mode()/mipi_dsi_dcs_set_display_on() instead
  of raw DCS opcodes and check their return values.
- Dropped stale InforceComputing/Linaro copyright and author lines.
- Dropped the unused dev field and the unreachable mode check.
- Link to v1: https://patch.msgid.link/20260814-mtk-video-panel-startek-078-v1-1-5f84a57244bc@baylibre.com
---
 MAINTAINERS                                 |   5 +-
 drivers/video/Kconfig                       |  10 +
 drivers/video/Makefile                      |   1 +
 drivers/video/panel-startek-kd070fhfid078.c | 345 ++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6ca03741f5..a4c88223ec2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1668,11 +1668,12 @@ F:	common/stackprot.c
 F:	cmd/stackprot_test.c
 F:	test/py/tests/test_stackprotector.py
 
-STARTEK KD070FHFID015 PANEL
+STARTEK PANELS
+M:	David Lechner <dlechner@baylibre.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 S:	Maintained
-F:	drivers/video/panel-startek-kd070fhfid015.c
+F:	drivers/video/panel-startek-*
 
 TARGET_BCMNS3
 M:	Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3d8f4858721..de0197b21cd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -330,6 +330,16 @@ config PANEL_STARTEK_KD070FHFID015
 	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
 	  built-in LED backlight and touch controller.
 
+config PANEL_STARTEK_KD070FHFID078
+	bool "STARTEK KD070FHFID078 panel"
+	depends on PANEL && BACKLIGHT && DM_GPIO && DM_REGULATOR
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for STARTEK KD070FHFID078
+	  DSI panel. The panel is a 7-inch TFT LCD display with a resolution of
+	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
+	  built-in LED backlight and touch controller.
+
 config VIDEO_BOCHS
 	bool "Enable Bochs video emulation for QEMU"
 	help
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 7a54f1f290d..7a7b54e6b53 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
 obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
 obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_PANEL_STARTEK_KD070FHFID015) += panel-startek-kd070fhfid015.o
+obj-$(CONFIG_PANEL_STARTEK_KD070FHFID078) += panel-startek-kd070fhfid078.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
diff --git a/drivers/video/panel-startek-kd070fhfid078.c b/drivers/video/panel-startek-kd070fhfid078.c
new file mode 100644
index 00000000000..12bf04e9912
--- /dev/null
+++ b/drivers/video/panel-startek-kd070fhfid078.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Copyright (C) 2025 Collabora Ltd.
+ * Copyright (C) 2026 BayLibre, SAS
+ *
+ * Authors:
+ * - Guillaume La Roque <glaroque@baylibre.com>
+ * - Jitao Shi <jitao.shi@mediatek.com>
+ * - David Lechner <dlechner@baylibre.com>
+ */
+
+#include <asm-generic/gpio.h>
+#include <backlight.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <power/regulator.h>
+
+/* Register definitions from the Linux panel-himax-hx8279.c driver */
+#define HX8279_REG_PAGE			0xb0
+
+/* Page 0 - Driver/Module Configuration */
+#define HX8279_P0_VGHS			0xbf
+#define HX8279_P0_VGLS			0xc0
+#define HX8279_P0_VGPHS			0xc2
+#define HX8279_P0_VGNHS			0xc4
+#define HX8279_VGH_MIN_MV		8700
+#define HX8279_VGH_STEP_MV		300
+#define HX8279_VGL_MIN_MV		6700
+#define HX8279_VGL_STEP_MV		300
+#define HX8279_VGPNH_MIN_MV		4000
+#define HX8279_VGPNX_STEP_MV		50
+#define HX8279_VGH_VOLT_SEL(x)		(((x) - HX8279_VGH_MIN_MV) / HX8279_VGH_STEP_MV)
+#define HX8279_VGL_VOLT_SEL(x)		(((x) - HX8279_VGL_MIN_MV) / HX8279_VGL_STEP_MV)
+#define HX8279_VGPN_VOLT_SEL(x)		(((x) - HX8279_VGPNH_MIN_MV) / HX8279_VGPNX_STEP_MV)
+
+/* Page 1 - Gate driver On Array (GOA) Mux Config */
+#define HX8279_P1_REG_GOA_L		0xc0
+#define HX8279_P1_REG_GOUTL(x)		(HX8279_P1_REG_GOA_L + (x))
+#define HX8279_P1_REG_GOA_R		0xd4
+#define HX8279_P1_REG_GOUTR(x)		(HX8279_P1_REG_GOA_R + (x))
+
+/* Page 3 - Gate driver On Array (GOA) Configuration */
+#define HX8279_P3_REG_UNKNOWN_BA	0xba
+#define HX8279_P3_REG_GOA_STVL		0xc8
+#define HX8279_P3_GOA_STV_LEAD		GENMASK(4, 0)
+#define HX8279_P3_REG_GOA_CKVL		0xc9
+#define HX8279_P3_GOA_CKV_LEAD		GENMASK(4, 0)
+#define HX8279_P3_REG_GOA_CKVD		0xca
+#define HX8279_P3_GOA_CKV_RESERVED	BIT(6)
+#define HX8279_P3_GOA_CKV_DUMMY		GENMASK(5, 0)
+#define HX8279_P3_REG_GOA_CLR1_W_ADJ	0xd2
+#define HX8279_P3_REG_GOA_CLR234_W_ADJ	0xd3
+#define HX8279_P3_REG_GOA_CLR1_CFG	0xd4
+#define HX8279_P3_REG_GOA_CLR_CFG(x)	(HX8279_P3_REG_GOA_CLR1_CFG + (x))
+#define HX8279_P3_GOA_CLR_CFG_POLARITY	BIT(7)
+#define HX8279_P3_GOA_CLR_CFG_STARTPOS	GENMASK(6, 0)
+#define HX8279_P3_REG_UNKNOWN_E4	0xe4
+#define HX8279_P3_REG_UNKNOWN_E5	0xe5
+
+/* Page 5 - MIPI Configuration */
+#define HX8279_P5_REG_TIMING		0xb3
+#define HX8279_P5_TIMING_THS_SETTLE	GENMASK(7, 5)
+#define HX8279_P5_TIMING_LHS_SETTLE	BIT(4)
+#define HX8279_P5_TIMING_TLPX		GENMASK(3, 0)
+#define HX8279_P5_REG_UNKNOWN_B8	0xb8
+#define HX8279_P5_REG_UNKNOWN_BC	0xbc
+#define HX8279_P5_REG_UNKNOWN_D6	0xd6
+
+/* Page 6 - ENG/Gamma Configuration */
+#define HX8279_P6_REG_ENGINEER_PWD	0xb8
+#define HX8279_P6_REG_INHOUSE_FUNC	0xc0
+#define HX8279_P6_ENG_UNLOCK_WORD	0xa5
+#define HX8279_P6_REG_GAMMA_CHOPPER	0xbc
+#define HX8279_P6_GAMMA_POCGM_CTL	GENMASK(6, 4)
+#define HX8279_P6_GAMMA_POGCMD_CTL	GENMASK(2, 0)
+#define HX8279_P6_REG_DLY_TIME_ADJ	0xd5
+
+struct stk078_panel {
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+	struct mipi_dsi_device *dsi;
+	struct udevice *iovcc;
+	struct udevice *vdd;
+	struct udevice *backlight;
+};
+
+static const struct drm_display_mode default_mode = {
+	.clock = 156458,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 50,
+	.hsync_end = 1200 + 50 + 24,
+	.htotal = 1200 + 50 + 24 + 66,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 14,
+	.vsync_end = 1920 + 14 + 2,
+	.vtotal = 1920 + 14 + 2 + 10,
+};
+
+static const u8 stk078_gout_l[] = {
+	0x0d, 0x0d, 0x06, 0x06, 0x08, 0x08, 0x0a, 0x0a, 0x0c, 0x0c,
+	0x00, 0x00, 0x0e, 0x0e, 0x01, 0x01, 0x04, 0x04, 0x00, 0x00,
+};
+
+static const u8 stk078_gout_r[] = {
+	0x0d, 0x0d, 0x05, 0x05, 0x07, 0x07, 0x09, 0x09, 0x0b, 0x0b,
+	0x00, 0x00, 0x0e, 0x0e, 0x01, 0x01, 0x03, 0x03, 0x00, 0x00,
+};
+
+static int stk078_panel_init(struct stk078_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
+	int i, ret;
+
+	/* Page 5 - MIPI Configuration */
+	mipi_dsi_generic_write_seq(dsi, HX8279_REG_PAGE, 5);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P5_REG_TIMING,
+				   FIELD_PREP_CONST(HX8279_P5_TIMING_THS_SETTLE, 2) |
+				   HX8279_P5_TIMING_LHS_SETTLE |
+				   FIELD_PREP_CONST(HX8279_P5_TIMING_TLPX, 2));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P5_REG_UNKNOWN_B8, 0x7f);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P5_REG_UNKNOWN_BC, 0x20);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P5_REG_UNKNOWN_D6, 0x7f);
+
+	/* Page 1 - GOA Mux Config */
+	mipi_dsi_generic_write_seq(dsi, HX8279_REG_PAGE, 1);
+	for (i = 0; i < ARRAY_SIZE(stk078_gout_l); i++) {
+		const u8 buf[] = { HX8279_P1_REG_GOUTL(i), stk078_gout_l[i] };
+
+		ret = mipi_dsi_generic_write(dsi, buf, ARRAY_SIZE(buf));
+		if (ret < 0)
+			return ret;
+	}
+	for (i = 0; i < ARRAY_SIZE(stk078_gout_r); i++) {
+		const u8 buf[] = { HX8279_P1_REG_GOUTR(i), stk078_gout_r[i] };
+
+		ret = mipi_dsi_generic_write(dsi, buf, ARRAY_SIZE(buf));
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Page 3 - GOA Configuration */
+	mipi_dsi_generic_write_seq(dsi, HX8279_REG_PAGE, 3);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_UNKNOWN_BA, 0xf0);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_GOA_STVL,
+				   FIELD_PREP_CONST(HX8279_P3_GOA_STV_LEAD, 7));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_GOA_CKVL,
+				   FIELD_PREP_CONST(HX8279_P3_GOA_CKV_LEAD, 3));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_GOA_CKVD,
+				   HX8279_P3_GOA_CKV_RESERVED |
+				   FIELD_PREP_CONST(HX8279_P3_GOA_CKV_DUMMY, 1));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_GOA_CLR1_W_ADJ, 1);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_GOA_CLR234_W_ADJ, 5);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_GOA_CLR_CFG(0),
+				   FIELD_PREP_CONST(HX8279_P3_GOA_CLR_CFG_STARTPOS, 5));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_GOA_CLR_CFG(1),
+				   HX8279_P3_GOA_CLR_CFG_POLARITY |
+				   FIELD_PREP_CONST(HX8279_P3_GOA_CLR_CFG_STARTPOS, 10));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_UNKNOWN_E4, 0xc0);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P3_REG_UNKNOWN_E5, 0x00);
+
+	/* Page 0 - Driver/Module Configuration */
+	mipi_dsi_generic_write_seq(dsi, HX8279_REG_PAGE, 0);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P0_VGHS,
+				   HX8279_VGH_VOLT_SEL(18000));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P0_VGLS,
+				   HX8279_VGL_VOLT_SEL(12100));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P0_VGPHS,
+				   HX8279_VGPN_VOLT_SEL(5500));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P0_VGNHS,
+				   HX8279_VGPN_VOLT_SEL(5500));
+
+	/* Page 6 - ENG/Gamma Configuration */
+	mipi_dsi_generic_write_seq(dsi, HX8279_REG_PAGE, 6);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P6_REG_ENGINEER_PWD,
+				   HX8279_P6_ENG_UNLOCK_WORD);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P6_REG_INHOUSE_FUNC,
+				   HX8279_P6_ENG_UNLOCK_WORD);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P6_REG_GAMMA_CHOPPER,
+				   FIELD_PREP_CONST(HX8279_P6_GAMMA_POCGM_CTL, 1) |
+				   FIELD_PREP_CONST(HX8279_P6_GAMMA_POGCMD_CTL, 1));
+	mipi_dsi_generic_write_seq(dsi, HX8279_P6_REG_DLY_TIME_ADJ, 72);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P6_REG_ENGINEER_PWD, 0x00);
+	mipi_dsi_generic_write_seq(dsi, HX8279_P6_REG_INHOUSE_FUNC, 0x00);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0)
+		return ret;
+
+	mdelay(130);
+
+	return mipi_dsi_dcs_set_display_on(dsi);
+}
+
+static int stk078_panel_enable_backlight(struct udevice *dev)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	stk->dsi = dsi;
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
+		return ret;
+	}
+
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 0);
+	mdelay(10);
+
+	ret = regulator_enable(stk->vdd);
+	if (ret < 0) {
+		dev_err(dev, "enable vdd failed: %d\n", ret);
+		goto out_detach;
+	}
+
+	ret = regulator_enable(stk->iovcc);
+	if (ret < 0) {
+		dev_err(dev, "enable iovcc failed: %d\n", ret);
+		goto out_vdd;
+	}
+
+	mdelay(15);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 1);
+	mdelay(10);
+	dm_gpio_set_value(stk->reset_gpio, 1);
+	mdelay(140);
+
+	ret = stk078_panel_init(stk);
+	if (ret < 0) {
+		dev_err(dev, "panel init sequence failed: %d\n", ret);
+		goto out_iovcc;
+	}
+
+	ret = backlight_enable(stk->backlight);
+	if (ret < 0) {
+		dev_err(dev, "enable backlight failed: %d\n", ret);
+		goto out_iovcc;
+	}
+
+	return 0;
+
+out_iovcc:
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	udelay(100);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 0);
+	regulator_disable(stk->iovcc);
+out_vdd:
+	regulator_disable(stk->vdd);
+out_detach:
+	mipi_dsi_detach(dsi);
+
+	return ret;
+}
+
+static int stk078_panel_add(struct udevice *dev)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+	int ret;
+
+	ret = device_get_supply_regulator(dev, "iovcc-supply", &stk->iovcc);
+	if (ret) {
+		dev_err(dev, "Failed to get iovcc regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vdd-supply", &stk->vdd);
+	if (ret) {
+		dev_err(dev, "Failed to get vdd regulator: %d\n", ret);
+		return ret;
+	}
+
+	stk->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_IS_OUT);
+	if (IS_ERR(stk->reset_gpio)) {
+		ret = PTR_ERR(stk->reset_gpio);
+		dev_err(dev, "cannot get reset-gpios %d\n", ret);
+		return ret;
+	}
+
+	stk->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_IS_OUT);
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &stk->backlight);
+	if (ret) {
+		dev_err(dev, "failed to get backlight: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stk078_panel_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			   MIPI_DSI_MODE_LPM |
+			   MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+	return stk078_panel_add(dev);
+}
+
+static int stk078_panel_get_modes(struct udevice *dev,
+				  const struct drm_display_mode **modes)
+{
+	*modes = &default_mode;
+
+	return 1;
+}
+
+static const struct panel_ops stk078_panel_ops = {
+	.enable_backlight = stk078_panel_enable_backlight,
+	.get_modes = stk078_panel_get_modes,
+};
+
+static const struct udevice_id stk078_of_match[] = {
+	{ .compatible = "startek,kd070fhfid078" },
+	{ }
+};
+
+U_BOOT_DRIVER(stk078_panel_driver) = {
+	.name		= "panel-startek-kd070fhfid078",
+	.id		= UCLASS_PANEL,
+	.of_match	= stk078_of_match,
+	.ops		= &stk078_panel_ops,
+	.probe		= stk078_panel_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct stk078_panel),
+};

---
base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
change-id: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7

Best regards,
--  
David Lechner <dlechner@baylibre.com>

