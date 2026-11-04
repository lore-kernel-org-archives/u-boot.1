Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E7606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nwxCSXu8;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SPOX9r3V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBE5607C4;
	Wed,  4 Nov 2026 09:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_bf1zGPcVjd; Wed,  4 Nov 2026 09:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A8C960759
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785722;
	b=q0gDXiOLnIA7pX8kjvtJaeUR5E0Ud2xVQ1fujgOgJ6W4XdCeeLbnIvtyys7+BlbO70E4
	 t+HAgx/zhQ5nMBzD+XG/wlZbX99thFad3xVt/J1BCWltM90bJvTTUu/jSuXxuYFYKMdzG
	 xFNJnPCMSREHu7avDjHuwfoPWe2P040Dne6BpEesQx14HxlxRMrYi32dL83uhGAJkMJbv
	 MidwJF2XJl2iyXI+bXAsiHzjz9msM9aMZ3wYIP5jxyPpv+MZuZ2I6oqEHa+ks4U19Z6SO
	 7imTCSZrDa2tv5jC1aMu6mgJSeKfhQnrUuvCdpChVSguE44tO06J2967ITc5Q010S8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VojimDzgWZddxl76ZNJOl5CClpRm5hX3uHa7lUiUnXc=;
	b=WYmmsz88qF+j0d4YsV/O6FYR6+Qlj96HapiBsqsAkJ3xRmE+/OnRr3my0c16If70YIZD
	 aa/E3/ZJ1JVrw/OwYJKLNa/gHi0Uilg8YcMmKglR6JCy4XywUwp+rak9xdpmhxzuSg0i1
	 4M1KJh73R6hpM0EGYOpgnmc/XvfHkCI1Ktf+XV8SFYVfq8qaFOny9H0lduxXr5tqyfFcS
	 SNhl9CGlKG2W97Ojs+fZ3GPDhDa/TbpoTfIGwcN95tAs2TQLMUX3cZDEzqy50TXZM7Wgs
	 3eGWv/04q326ivkKLRgzsaQ97cavB6xF3vyvBlY9gBsGuPffAOEbxDR951mwtB6BEPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SPOX9r3V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785722;
	bh=VojimDzgWZddxl76ZNJOl5CClpRm5hX3uHa7lUiUnXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nwxCSXu84PPulwUT7+vS1PF/Kj5n010EauI+XCNI9RlmrSrJL8BW/WsY/vGUACprs
	 Ml63VNfr/CT7p8tRjbHdWVup9r/YCPQw1M+GWNKj67qDH+felF4Lf8y9Tug6amlaOW
	 eCjnYx7FTX9yxIJB7ypL0rglMf3SrG7poD6d4a0vqN0R5mEY7FnbCr2rJYCXD6PFPS
	 DkfnVhMM9HJRBApJEoZ/AQ4M/Rd3kSqJwSpAVuWtXUqugkNA1G0souYW1acSOG0sD3
	 E6Iso9LIs3CtERtILD3luxzYJgfEEWF+IYRhhO6fsA2QNkhhgg5pMy6ZAmPNjzmkUq
	 FDhRRQrOt7YoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A8C960759;
	Wed,  4 Nov 2026 09:48:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BEBEA10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D526606FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYs3jCCsfQ7X for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA8AD60759
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785717;
 b=iqX6jUJ+w4QVYDBgvqbyskTCIac/VMTDJBYF4++wNWNGzJP+1AZTIMzkbuMfEF9xWRdQ
 vdtssH4ZrKL34NQPEQkZgopmoDFmL0kQeEQIwLBMUAQx1YhHZ+IWllxDwIL5vjC7/pM3S
 rl8UgqoIsAxGfpb0uOOIEM9oR5NMcI2rZFwzA906lnYSOAdz2jJxOaV15ezLtflh149wE
 VG6HyYI0lWFJcXz5/Hu/4EdRvpYtlg1XcK5sSgyxKOrcqXut1UcjVMR4Gy4JsSnNBoK9W
 n0k1/anNybAZ9V9GxJ56SPzwNFoVRsrkfjRpzlbiQwLeodZeKZFK2joUijmbF4xuAQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785717;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=VojimDzgWZddxl76ZNJOl5CClpRm5hX3uHa7lUiUnXc=;
 b=J+t8nfn46CqGNZ55T8YQWriKAHT2853HUS0UdpwvrINxhnjsyYCy8MEXvPtmftGBP1Dp
 2w26rKo8g4fXL77trlPgZhcLjqOr9VUAgcEWZtjHmLuZvcrlsR9i2UruawTqTyS+8/BSB
 xIng61imWflLj3aB0xByvpu2SDbdPyfKok/drjuFQK8AQS5AMgk/qMgXsbERPP2npg+/q
 JsgaicxsFITvr2l79kjMiktyGNALhraK94hrrOQPdpcQ5W8pF8YsGZxCAEV5IZjLaQgXx
 knQ0ZPSjH6VQOglXEGxJR04YR2MMcHjPI6LKwwETkD+QwKW0XY4QRusRI/2nbhbWtiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SPOX9r3V; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SPOX9r3V
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA8AD60759
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:36 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so433192f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785714; x=1794390514;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VojimDzgWZddxl76ZNJOl5CClpRm5hX3uHa7lUiUnXc=;
 b=SPOX9r3V5mgNHzH4HMaHGGTlVJDOvehwoqO2bDCbDp2MnOYdYMUCagEoB1HuaBlqf2
 zicZ5z1Ittm6zx4ACZd3rLLPh7Lbdg61MA2s4YiYsf8yDVv+usPQPn831FWG0u1ejB8L
 JTQsmDIOA2wYyHa03/pKknsEvUomYcuM3cOMM/LhVbu44JWcerPwNGGZuTBJn7D0kqDc
 IkgD0GVwm383AH/cQa2oH0Ff2xHKVkmR/3HkiT9kBp+wR1TGiUYjb3rzI2wyHUtxX4X5
 G5EnRQ0qhK2M0PVAU08SkhtTQDV6+zvQjtvSkJ8jkhkeNOwgPbCou90T7vLadxu1ut4Q
 P/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785714; x=1794390514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VojimDzgWZddxl76ZNJOl5CClpRm5hX3uHa7lUiUnXc=;
 b=mldX/8+niWgQNYo0fpPZr+Aw9lNdn/lF3JkcAoSXaWyoBEA27Pzws6QWOSCqZX2Xa4
 vjEFSkmbS7M+9hz0xYz5TUn81XfhBJj1MhJOmcdTb+pepEa1p1Y/n0rYRN62o1kuqS1j
 ALyIkpAan/yKgwYBx8vcEsyVoBe1xvhRqNBo0wn5IzNJnUMAyNVx9MHYKqC3LHxOU044
 nWAtTBHAPdRYu4YVjKN8RFkFMsHnuZrmLk+cy2g5qjKZXXiiQFj79wFe1JGeo7x6yp3B
 46ISE14y0Y1NvHeyQWdnIfZjQBlkWCHaQR5yLWDb+W5gV/eN2CSuXi07ImHTMunvWO7G
 khWg==
X-Gm-Message-State: APuU4Z+s2IqFNpllhvqwb+9lF49fZi7Aq1TZbwbGSwzVPol6vj2YhGNR
 GjJksQdFleQ6g103XNNcwvW3wVzCvLztwWGQ3uavPp6LLX5CZ9RYBAzNq3WzLz+rvUw=
X-Gm-Gg: AYBFou2IMAe1jV6ooqG4T3LGjTmQsaqeYl/Rkms/C0xj7CMmvRIR3BLN0TU9CshDLns
 nghVr8hpMzsIUzkgBmjnecMwYXdIjXfYt1owyjrJDmCGzLI96OJ+NqpA5yQSiWRUthLYxi/K9q/
 8ZXZje5KPjW5HqLmklfdBDLZaikK8X7dY7pYnlBY3rmknOA+LV751zymNjYpDWKdtBRBqcg2gYs
 UStcGCqrX5s+gLISeA2jYENJ+pi9MUBbsoI7eSIgaKZFPt2lTm0MDdW2XQY7ZISAy0hF3EpnF2y
 mGWzh8HSRJw1cXQ+pgsjXLoQDX/bAaluy6qEPmju0Gxnivh+IsEMXhxfEYELyh7kySKlXRuUH7K
 INhvUGhR7tYP7/QGS5icWAMlERm9ekcxLPw5DY1O/vjdhAYrQTAJBpyDTqouzQ4entP2x08d2yS
 hDydRwpjy+TUmoxHAiE5LM6kjvGs8IY5fAshIcqYT2idfJPWkFtOaCj28k0RAIMe+bod2ygypmQ
 zEHvPOunBnn57yQ9y63jcgwwtw+QGauVOlG15V2sKZ8oAtOAJLc/rS4uad+tcAuKK1rA89fluqE
 hDIIh3lWXu8sSJwukluLoFth7A==
X-Received: by 2002:a05:600c:a48:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4b22ec58f9emr136722525e9.10.1793785714210; 
 Wed, 04 Nov 2026 01:48:34 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm64797315e9.5.2026.11.04.01.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:48:33 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 04 Nov 2026 10:47:48 +0100
Subject: [PATCH v2 1/7] board: ti: am43xx: Remove am4372-generic devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-1-6091edbb51fa@baylibre.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4547; i=msp@baylibre.com;
 h=from:subject:message-id; bh=YAXe8PgxYOhdL/z6VnARqlKLwq8Jib+tu+DmcSUjhHk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxX/31Uu47uM0mNaeNvyjNntXkrszUtXLmX7cMNUb/J+
 w6WrGjsKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInEyzIy7EnoNUj9FNqVx3V8
 /t29Ux1eFHDcXqOwZFbxh0617j2sMxh+s7I+8w0/d6bwhLUy971F5jpzNmk6+OksN1hzzY2do2E
 mJwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The generic board is a helper devicetree if board EEPROM reading failed
or the board is booting without SPL, e.g. QSPI boot. In these cases the
generic board was used. However there is no equivalent upstream so it
doesn't work with OF_UPSTREAM.

To support EEPROM reading before relocation, we are adding
bootph-some-ram to i2c0.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/Makefile                   |  1 -
 arch/arm/dts/am4372-generic-u-boot.dtsi | 16 ----------------
 arch/arm/dts/am4372-generic.dts         | 23 -----------------------
 arch/arm/dts/am4372-u-boot.dtsi         |  8 ++++++++
 board/ti/am43xx/board.c                 |  6 +-----
 configs/am43xx_evm_qspiboot_defconfig   |  2 +-
 configs/am43xx_hs_evm_qspi_defconfig    |  2 +-
 7 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b63..76f36b992ed1 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -411,7 +411,6 @@ dtb-$(CONFIG_AM33XX) += \
 dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 	am43x-epos-evm.dtb \
 	am437x-idk-evm.dtb \
-	am4372-generic.dtb \
 	am437x-cm-t43.dtb
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
diff --git a/arch/arm/dts/am4372-generic-u-boot.dtsi b/arch/arm/dts/am4372-generic-u-boot.dtsi
deleted file mode 100644
index 40f3756eb3fe..000000000000
--- a/arch/arm/dts/am4372-generic-u-boot.dtsi
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include "am4372-u-boot.dtsi"
-
-/{
-	ocp {
-		bootph-all;
-	};
-};
-
-&i2c0 {
-	bootph-all;
-};
diff --git a/arch/arm/dts/am4372-generic.dts b/arch/arm/dts/am4372-generic.dts
deleted file mode 100644
index 2524e0405cd5..000000000000
--- a/arch/arm/dts/am4372-generic.dts
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree Source for Generic AM4372 EVM
- *
- * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/dts-v1/;
-
-#include "am4372.dtsi"
-
-/ {
-	compatible = "ti,am4372", "ti,am43";
-	model = "Texas Instruments AM4372 Generic";
-
-	chosen {
-		stdout-path = &uart0;
-	};
-};
-
-&i2c0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 0c498bcf085c..06e7380adf64 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -65,3 +65,11 @@
 &ocp2scp1 {
 	bootph-pre-ram;
 };
+
+/*
+ * Some boards boot directly to U-Boot without SPL. In this case we need
+ * support for reading the EEPROM before relocation.
+ */
+&i2c0 {
+	bootph-some-ram;
+};
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 431372954b2a..42e2bef8151f 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -826,11 +826,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #if defined(CONFIG_SPL_LOAD_FIT) || defined(CONFIG_DTB_RESELECT)
 int board_fit_config_name_match(const char *name)
 {
-	bool eeprom_read = board_ti_was_eeprom_read();
-
-	if (!strcmp(name, "am4372-generic") && !eeprom_read)
-		return 0;
-	else if (board_is_evm() && !strcmp(name, "am437x-gp-evm"))
+	if (board_is_evm() && !strcmp(name, "am437x-gp-evm"))
 		return 0;
 	else if (board_is_sk() && !strcmp(name, "am437x-sk-evm"))
 		return 0;
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 86d8389951be..817b97b4b277 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am4372-generic am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 6b754cdc0ec9..715e2ac4be21 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am4372-generic am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y

-- 
2.55.0

