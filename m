Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC1606A33F
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dxZ5eU9z;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyVLYiIm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 644F360E83;
	Fri, 20 Nov 2026 13:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KLVeVHlXctDZ; Fri, 20 Nov 2026 13:21:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B278660D8E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180900;
	b=lc7illISOeP1ouETW/p6J+E/xLQERmIar4LZ9/wJyDAjOxf1mf9lWDdGuoMYRhJOHZiM
	 w5ZkKV/F7CM1lp47JE63oBUCOEay6AYvz3UpXNcsbhKwM4q0eFqP91mukTo1001cLGbPs
	 7HM+dI/bnZ1E2g67moGJpJS5PteThMhqUkjZIQ1D9Gz2wmx6dbB0iW38yGKoTmEh8O8i8
	 xAVLZdnFyuVWjAUiSBk4oNSh44fqlzMjSkPO5q6Vjzm2z5ykPfQ1n6TFhj46hPg7WTRvK
	 LJaR7Wv+sGTPvQJP+XnHz+ObYjDKIOWU50s1ZdXZ6A331P6uOrYDfURBzsr7ztAljHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GlivdA7Nss8AiJBE/x82UbRM09pqZNn/iZoI16Qt2oE=;
	b=dqQJ/wn9CIJwBkw5W39V9RQjMUAGvvohMuBnejbAmZ3VG/cR62vocovK7hHzsUX/yWca
	 4W+Y5UycfaC+7h4m4XYVaUIhyHJMFeZ3CiF1cqTbcMiNvdMYqYNb0B889vuQVe/0uofK1
	 pWqmP7JnwcsB02jdwcxC8TppmxKxcMqGFztWAu95o+F4aJFJmZijJNKLg9fdGhI5uCYsu
	 Dw3eY+UgxrGJiCmytA+ZtEMaOM86894OcMgbPiiHgprITpO0hLSbeli0wt+ovd8mzdtCT
	 aI8yZpGggh1sJv+iBgrqGEr0CEpcdcRdmn9F9TUBnbrZkN7aaRZ3tOqT5T7GFwLtF5w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180900;
	bh=GlivdA7Nss8AiJBE/x82UbRM09pqZNn/iZoI16Qt2oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dxZ5eU9zGXDgU+dedaW6icrMRnaLuYyAn/oNhzYWTgkQO+/86v5f6Kp+BDkV78UWX
	 uT4ZTTIpPCQdNTOUeImxLo0zX7n10H2ra//38pjzi4p+oqyKH1NokDvxt01dtDgFDL
	 e/eplN954NxX0ZAKMWEjO0Grsv7y8K2Pl3UEEiBHf3owRgT3pk3JAnw3eyLFbNrYBC
	 CPnipZTDha8UAJLz8UwjvBxwiCArzSxo4ygrwwkkxPe2q1K0rg2Hn3c5n/5KKwyZvj
	 Z93EODe3JSqLfqOvGhDTq7t1V0GeZPzRNiwJmOJ+qfiTniIP7bd6BQK8WUwYj+aiHg
	 cPs9QlBOibjYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B278660D8E;
	Fri, 20 Nov 2026 13:21:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0539CE5E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBBA381678
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KjACCStKd0yt for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0963F814A0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=EyVLYiIm
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0963F814A0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:51 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so5539255e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173050; x=1795777850;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GlivdA7Nss8AiJBE/x82UbRM09pqZNn/iZoI16Qt2oE=;
 b=EyVLYiImR7diLTU6IXrZ5Dtyr0yxC3D1dOf9IYF9itK3LzPXLMLWa/e2dcu/E+jwF7
 Jf4EtKkekfmmmow7t6YSdCIz59evXIdPaEXIq+It0DVtG9Jz/REPZN6Z+akYIGNn1DaQ
 sslAOqXIIqpZGd1gqDhV9bGZYZgKFeOaRInV5OZ6GTPYPBI4CjObNgDUf98BiUoZw1g7
 iIzUL7cTTavupL8imTk8Vu5Qj7hO4yeylgxP1A/Q/SeWlXeao12jLK5d/Qc90TSiJy/i
 FtMDLwZH85HtWdQyxlDedwn0Aq9Djv5Z7lgTZ65ReyQGgo+b7mXfDxB5Dm1AOObsnlYd
 7aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173050; x=1795777850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GlivdA7Nss8AiJBE/x82UbRM09pqZNn/iZoI16Qt2oE=;
 b=LmFBVjZHYSFj39ApULbnyIyaxn00LuyTudcBPR4ymydXe0WBTXLUgudGUXC/BPwj1X
 dZbYCqztPDAPrdZHWkBai1wWPhQYRBI0+7hJn5nFaRtET9VCTsksKgsJRewlcaj4iTCZ
 g9F+ayFk1fPIjGj0yexjfsoXK6g7N870gi3wzvJLqg7m43kzsqo0Q61v/CluvKrCxAjr
 EvkDs2dlPg1kwprPu99rLmSv6RDOdwNDjWWTwfoOiF+Lx/25Yfx8lwU6q8XWYc5sXF1n
 fKhoUdu4hQFsVoLsLeOLDN6tZan17af4mKodO8pgjnf1lJPdE9/1OUXxTpAacWJ1QgWL
 +zpA==
X-Gm-Message-State: APuU4Z9ucHd2ZdBLGBLGSGSLEefcKiehrmmJPjR3eEvqAi4//BgRHX5T
 3rW1SHkugeqgrZ6YdWT6qRLJNrQIUbT6XC+8TEhjSfDeHUkM+Z+s1PAM
X-Gm-Gg: AYBFou2HiIVUYiCUvMUjRB4FdyA5Rg8pG1mg6lr+sGrrAnZHVdRV2OuJG2d3MtqTpBG
 WOUAIKlYlkW1Dsn5BfP2UxiEcsQMEadOhO84O9+RE06wuJI2TbSBTBjHY2aoBXqgmWMjcyrSA+G
 kZ3aZLk7M6H/wZMRwr12N0fNnQ5vw8MSatK902scQNQQisVDXqph2JJf1JcQU/xZYpweGJ/LVxR
 JhgSYPWIjcvLY3/a9vDh6SEZY51jtnagl2IDGriI47MFDztvSaW/Y0Giw3HH1+IKm3Svvl8PATv
 e/+vcOxCUKVg/zSdLGPGEh/fDZv0gUwVmU32kbGL6wZ4A1a7l7GAPUyVl4r4rY76DXHaZfMTH/b
 1DS7lYhkNd2CWEP0SPOlMn82Fa5/z6RunZufF9v8b5eORYRRnWQg0uK/gKwdwDen9BMkynFRdsQ
 bphS6TFbI1nvx3VvxTpqECrds//oMZm0noX9/nOjM9+raiFCuq4nRXrqUasiiZj6Z11pil3NRX6
 oONcj7+H61VuRfEfnnxLCiNBloZuSWyzuQgaqHKM/3mER+hZUTFAnJZ7zUaUI0O3nbxkphw6nCV
 mr9jfvIvQUFWI1ErGNeBFzI=
X-Received: by 2002:a05:600c:c4a2:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4bb88807d87mr62319745e9.7.1795173049662; 
 Fri, 20 Nov 2026 03:10:49 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:49 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 5/7] board: toradex: colibri-imx6ull: drop the static
 serial device
Date: Fri, 20 Nov 2026 12:10:11 +0100
Message-ID: <20261120111037.110741-6-eichest@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120111037.110741-1-eichest@gmail.com>
References: <20261120111037.110741-1-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

uart1 is described in the device tree and enabled there, so the
platform-data device binds a second, duplicate serial_mxc instance.
It has no device tree node, so once the clock framework is enabled it
cannot resolve its clocks and fails to probe.

The device tree instance is still available before relocation: both
simple_bus and serial_mxc set DM_FLAG_PRE_RELOC, so the soc/aips/spba
buses and uart1 bind without bootph marks, and fsl,dte-mode replaces
the use_dte platform data.

Tested-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/colibri-imx6ull/colibri-imx6ull.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/board/toradex/colibri-imx6ull/colibri-imx6ull.c b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
index 7bfe200d6e4..01387e87294 100644
--- a/board/toradex/colibri-imx6ull/colibri-imx6ull.c
+++ b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
@@ -19,7 +19,6 @@
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/io.h>
 #include <dm.h>
-#include <dm/platform_data/serial_mxc.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <imx_thermal.h>
@@ -211,13 +210,3 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return ft_common_board_setup(blob, bd);
 }
 #endif
-
-static struct mxc_serial_plat mxc_serial_plat = {
-	.reg = (struct mxc_uart *)UART1_BASE,
-	.use_dte = 1,
-};
-
-U_BOOT_DRVINFO(mxc_serial) = {
-	.name = "serial_mxc",
-	.plat = &mxc_serial_plat,
-};
-- 
2.56.1

