Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679EAC79F9E
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24FE5605E5;
	Sun,  6 Sep 2026 09:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f80TgncnmHZV; Sun,  6 Sep 2026 09:11:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5518760601
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788685885;
	b=qwaAH8YnJ0/6pZLyV81SFbA5DcvcDYoOfnVhVpHodkKkeYcoXNpfijTGosmQiSwAT+Ew
	 3N7POcRTt6dphLZMI0vFU//XguEsZEO7CLXIwU/ymq76nK82sKA4Eg/Q9cErBy23euI43
	 cx0ltQcNCM9EAl6uq2OWPs0x0+HrCSDa8nhR++LgQAGi4GdgSrJjZSYrKUat5uxgBw3Zw
	 oiakZSq20HIm2/hTSw1YBNGgGsOyHVP1UluUHDSLoCb3wnWor3WTgairdG1AbPg565AyO
	 I3IPXJFFY867QTpOizt7+Y42W0RpIpTYP1ZDAccpgk6vyGP2nU1Taa53y3QdwxOAbpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788685885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
	b=bxJpfqHixke9GfEBO3lNiyXbh3ZeVRqQjWKv/G5Q7I+l8nZ/z+Pe8LY1vUexu1PScyX8
	 iulXzlNASSbfLGJqTaDI7MBuA7e2kxA+N4AefDIxHZCF5OFqKylIMptNdcp5433qlZyRJ
	 8JsRk+bXE9XihAuQ5opgQxluvnS7MMz3wu7Bt4AREwQXWaihDTxylI70K7WWBWK7U7NX1
	 464/oGgx8vJFsyTrTY8LaaWimBLGhzcQsdtFa6B6BBJH5CYl5HYE4Lgj/ynY3qX2Hmo08
	 q3D1DeCx+SAmRz0gR5jOQ6GRoUc+mLn2yD2dOMCdhLNx9yUz72xf0KHFegrc+Kk/AvQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Kw+RucVp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788685885;
	bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WBxJgU9KHxJ0xWqpoYOCOrVd5R5llKGhR3J4i+35kQK0HXaHDNqChW6XU0Brr3o8+
	 oMluEsQ00qyZq5Qx6WcyKjhaSQ8jql/LIeDZBvZaAK7M/atxEYdKI6ZTeS08xlgzeB
	 /s7jttfL3ue+Ds4BGwcMNYMhAAowKAz4C4rzUDLcUFtKxq152/r3YVDVsd8XjSKuR6
	 jtP6GfekOiK6BvijogUt0B41pLxrMGkY22Tcgaiq3is5Mbzby4+8+fcAmZprHuwIZf
	 HWCc4U5mYsVjm/Ht71JjSAQicYtD6UflNomDAgAalre6V4ybO6fqeth8wyNq99su7P
	 Sj0NyLefkyEBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5518760601;
	Sun,  6 Sep 2026 09:11:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81484118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72BF060601
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RWkS7Y73Hdyr for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:11:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F227D605E5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788685883;
 b=aB7FTKU37/rSnK3FJU3tzM+PpZ5yhGTfeVaOZ6HoZ8iQ7dg0lfJ4Xw5yR13U8BlxX4Qc
 4Vd52dkiSTbeP6m1mHZRB6wkG+32D+e182Jh81mp6f1x/TTMsZ5ApQA5USW65rrF2znxm
 Zz0OQPwe9X7Zm9NGT5JUgFSvTYr0ExBN1otagH3OTHbGjuRXzxTUQK9ZUltnOFpptQL9q
 ZAJbIp6YkaYvRjqUAX8D4rP3iBzBeyJ5I1h1L0pgMJzvR6SGoIt861ZUcYXWTnYejSer/
 p5SPrxeFy+QEVswpRyZD/RrnpwFrDGSMy64kS9h4AYQ8BIPmxF+jVdenSF54aiQJKAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788685883;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=Ud4BQg/nRfOjWn0TYrCUhYfOuAwZQ/d2IJPOzQxMm2Xatq9DrimopY498NCUdm++Kwmh
 p+nhfjfXsYEtt8pQz5wIKuSlGIYkZ1R/79hAnixN3Mgxk1ohUDlbK+d6prB5A/a1ynaHk
 n4WC8nm0SmdjIWpKy0Nilz6K5M6BZqqDmxvGO7NMeo7rFykG++ixxZAWcGXZhPcpSRbUK
 wfsEHWPW3ZznzpMWZcxWFBBs1HD5k4WHAOnXmANMShESTDsAsNepHz6O+AI8E4KtRb4hC
 s8HGry4zanQkDOtLG80PfO7vAW3vf+Gby/cog6kQNjRJv+H0XDWv2yWHPzDYENVbjPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Kw+RucVp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Kw+RucVp
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F227D605E5
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:22 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso2710155a91.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788685882; x=1789290682;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=Kw+RucVpIKgKIVDLKAMD1Cm3/jhDG2FSnYdzBl8eyUK8F2gBB+o6jttP5ytjIwp0fJ
 4J5MyuUwDzB4uEo4Ae8QfsZjrJ5lfqNNfB3Fqb6Sgv3xJTxeec/mnP+sofH1lbsl1ECo
 qvN4Nc+z4yTeAL3F7t1GAX5nwLBIq24sNluutLF6SCfXiKpfFREJ3j9FueyE/AiRxLEG
 o88EUYktnxFp+BQp16AhGcrT62DxWhJwAzuvR3sJ8dQJC0R6X36wZZKH9CGOswWzA1td
 /8BD+/DCqbCJGBRlTZLhIiHyJnrMwJcDDYKgpmxndhJQPjkEbonoNUrHeHI3Ze5ZjX2I
 fnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788685882; x=1789290682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=nl60cIujhjnyaMqix1T5eACp6eU3/FshOD3s+LotN6m2ezpJyMyjlAbFvoPO+LyaD1
 602U/jxs79vKCmDmSKcu3RmGXLyV0qQnGjLHZlUshK9r0TCtNllrvgJqte+VQ619tjUY
 M/NZD3q5NgpHKx9H1Y8H0ceyPXpjy2GZeNqPoYileFwhEMa6rwE3XqKyNH6iOOzMHGy1
 32iJ4VeRK54zVdZPtVn/dJ9xj6eoBiqDK0XP28yV3GEJdw63hh+ynDDPoj7PLAcZxJ8M
 iabhAF3umP4uknPCPMAIMGaUIpZr0XW3mbfA91DOrQuC/E5k9mJFR4PL5KjrQixzO/e0
 ZYog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyhIzmRwA+qxsS8AFD4/xpZwaJSBsptroRWA2R7Q/1Yf5QXdWzbgDaBR+bbhH7vR33gQnUbIU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k+4gVSX+9FDXIzqDxsDHGEQ2XXtUrU0QcR2B3+NfckGt1Dw/Tc
 IFAxl0FnGEZhVWMIJNgFoq5U2ELzNDuzW7N+OxVV0Rtnh7CdTiTvG5aVC6jftR8+GFU=
X-Gm-Gg: AYBFou1gllxF5L/VugEp3S4uUPVKMmW+pE7Tt+xAvBJCUmn5uo9oPqzhyV3cd+Rhybs
 yBYn0ZP1Xo1bDn/T7VOFjsjff7gVHcFqVqAuXgb8l79jQ8MqaKuN/tCTUzQsSWsF5GVtXiVghIZ
 TRG8TxhpP2LeSwic6My6TADNR3plJiRSKy23iVp2v44D/U4Ah9mJEOIiT+o+uUmkP+hGyjEs6+u
 oWs4Czm01adOGrcSPzOU65RjFxnUSBAYxG+AbLQd8s7JXH7+tRHR3FNYaBgMmnb1P9gexmLSujo
 0AOQV+WhVZYUOOcVBp3rFSt9fMLtX/YKga6vozVn+PvdcziNXwJZGqzW87P5ALr16Nh8NYRjXPb
 sjAHN5hl9xhpA3HWETHKCYtC4TzfwkK2erxcTkmBm4TVp9abL2SCDGcmkb8fPhuw9mcGLsrDW+B
 4g53FHPs/Qhpjq+SBbLhLHjmvH3+4z17+ukSBLMRzcXe66sj3M6EkE0eV8W2s7f9wTdIWr2nfIA
 aLYB5d+wiavM/OfO70PZslIMFb/wLBKKR0RAJW53Oz6NI8y9MjRBmfNKtoIVanzzA7ONte0/hYY
 tdr0VhC51q0k4+3js/qMQvH7ZQ==
X-Received: by 2002:a17:90b:5804:b0:398:9beb:a2b6 with SMTP id
 98e67ed59e1d1-39b087e4c2fmr25284844a91.24.1788685882137; 
 Sun, 06 Sep 2026 02:11:22 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm18845384eec.22.2026.09.06.02.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:11:21 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:11:03 +0800
Subject: [PATCH v12 1/7] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-m4-v12-1-89eb5a8f879d@riscstar.com>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
In-Reply-To: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Add logic to determine the current boot device by reading the
SoC's configuration registers, rather than using a hardcoded
default.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
---
v11:
- Fix read_boot_mode() on returning both boot mode and boot device.
v9:
- Enhance detection on booting from SD card.
v5:
- Add blank lines around the switch statement.
v2:
- Use FIELD_GET() to parse boot strap mode.
- Remove comments on hacking. Since the sequence between eMMC
  and SD device is exchanged in the upstream DTS. So it isn't
  a hacking any more.
---
 board/spacemit/k1/spl.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index d749e21a2d57..374922573c98 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
@@ -22,6 +23,20 @@
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
 
+/* boot mode configs */
+#define BOOT_DEV_FLAG_REG	0xd4282d10
+#define BOOT_PIN_SEL_REG	0xd4282c20
+
+#define BOOT_STRAP_MODE_OFFSET	9
+#define BOOT_STRAP_MODE_MASK	3
+#define BOOT_STRAP_MODE_EMMC	0
+#define BOOT_STRAP_MODE_SPI	1
+#define BOOT_STRAP_MODE_NAND	2
+#define BOOT_STRAP_MODE_SD	3
+
+#define STORAGE_API_P_ADDR	0xc0838498
+#define SDCARD_API_ENTRY	0xffe0a548
+
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
 #define PULL_UP			(6 << 13)       /* bit[15:13] 110 */
@@ -46,6 +61,17 @@ typedef void (*puts_func_t)(const char *s);
 typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
 			       puts_func_t puts);
 
+enum board_boot_mode {
+	BOOT_MODE_NONE = 0,
+	BOOT_MODE_USB = 0x55a,
+	BOOT_MODE_EMMC,
+	BOOT_MODE_NAND,
+	BOOT_MODE_SPI,
+	BOOT_MODE_SD,
+	BOOT_MODE_SHELL = 0x55f,
+	BOOT_MODE_BOOTSTRAP,
+};
+
 struct ddr_cfg {
 	u32     data_rate;
 	u32     cs_num;
@@ -58,6 +84,47 @@ binman_sym_declare(ulong, ddr_fw, size);
 
 char product_name[I2C_BUF_SIZE] = "k1";
 
+static u32 read_boot_mode(void)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
+	void __iomem *storage_api = (void __iomem *)STORAGE_API_P_ADDR;
+	u32 mode, sel;
+
+	mode = readl(storage_api);
+	if (mode == SDCARD_API_ENTRY)
+		return BOOT_MODE_SD;
+
+	mode = readl(boot_dev);
+	if (mode == BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
+		sel = FIELD_GET(BOOT_STRAP_MODE_MASK << BOOT_STRAP_MODE_OFFSET,
+				readl(boot_strap));
+		switch (sel) {
+		case BOOT_STRAP_MODE_EMMC:
+			mode = BOOT_MODE_EMMC;
+			break;
+		case BOOT_STRAP_MODE_NAND:
+			mode = BOOT_MODE_NAND;
+			break;
+		case BOOT_STRAP_MODE_SPI:
+			mode = BOOT_MODE_SPI;
+			break;
+		case BOOT_STRAP_MODE_SD:
+		default:
+			mode = BOOT_MODE_SD;
+			break;
+		}
+	}
+	return mode;
+}
+
+static void write_boot_mode(u32 mode)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+
+	writel(mode, boot_dev);
+}
+
 static void i2c_early_init(void)
 {
 	struct udevice *bus;
@@ -327,8 +394,12 @@ void nor_early_init(void)
 
 void board_init_f(ulong dummy)
 {
+	u32 mode;
 	int ret;
 
+	mode = read_boot_mode();
+	write_boot_mode(mode);
+
 	ret = spl_early_init();
 	if (ret)
 		panic("spl_early_init() failed:%d\n", ret);
@@ -354,7 +425,32 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_SPI;
+	u32 mode;
+	int ret;
+
+	mode = read_boot_mode();
+	switch (mode) {
+	case BOOT_MODE_EMMC:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	case BOOT_MODE_NAND:
+		ret = BOOT_DEVICE_NAND;
+		break;
+	case BOOT_MODE_SPI:
+		ret = BOOT_DEVICE_SPI;
+		break;
+	case BOOT_MODE_USB:
+		ret = BOOT_DEVICE_USB;
+		break;
+	case BOOT_MODE_SD:
+		ret = BOOT_DEVICE_MMC2;
+		break;
+	default:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	}
+
+	return ret;
 }
 
 void spl_board_init(void)

-- 
2.51.0

