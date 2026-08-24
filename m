Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE4FC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3BF840649;
	Mon, 24 Aug 2026 08:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUQ_NaGN42Pp; Mon, 24 Aug 2026 08:52:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561561;
	bh=YrzvRp4xOxKY7DYrKuD6rIRUGDbxHz/i0wcYuPuS8g4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=znFil+wqc5TNWOOFbbqLCKoLPO50lVGv7IGJsrB2cRE5IiGVmitwL5NkWUzI2r/AR
	 Sba2gyx7yG7xQ5Nop+u5XdeTlTal70qqM5fYqbmKW2mr7Pus8c2+UNnrKaFA6LCOKR
	 UB8KzMG5Mqx7BRz/HOo48PMPug+r9LvFuQ0inO3P2mOXKhBL1MXHYsWKrHxRh018Y1
	 Mq3dtgm0OZzkiTNvHKQMg3HjtVcqybkqu+N2Ct+K4gQaKYW54g2cg7Ss7wGT3GAxSO
	 lBdCoyEUmRlkoaq0C+vOW+1tMu5abGoK0qNS18Wzd57b6VPr64Cja3ru8ZoW2SGr+n
	 GLYuLG8qyde6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3193D4072E;
	Mon, 24 Aug 2026 08:52:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE42F3AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D083A4072E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6MLNkvPd9au for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:52:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=BwPNk9C0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2572340649
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:38 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3437508a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561558; x=1788166358;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YrzvRp4xOxKY7DYrKuD6rIRUGDbxHz/i0wcYuPuS8g4=;
 b=BwPNk9C0ZlLiV1x1FUrUF2VPqCcYPkiO+LXKvvq5iEd3exxRvkhapSTXxTUzB0EPOI
 AZCDhgyu64jUqe3NrpjebLFRezsbXKjFRl4GLxuZMoBzYNrz/rOx9lTTB7iDPzFSULtc
 3LiBrazYnGX8YpR/XEHc9S5gIBbvtuc2i0LIosSoNDI7to89SyOXZXQ02+P+7UHnE/A9
 KzBJf4eWC5GSZSOy+GzcgMuxF9J4+Lh57tSscOv+rk+EJXZoj1B5o84GntNOEqNPcP03
 NMRBN9pEJWoDEUo9zsObdThKw+lWg2Cq8f8yDhr9U4MuYsa3+aJpIKSl7Q3ToTnXN7+X
 UvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561558; x=1788166358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YrzvRp4xOxKY7DYrKuD6rIRUGDbxHz/i0wcYuPuS8g4=;
 b=I2V7gO1i0zT7GUkwsI9xuBhaXIuKx3Him+M58WUXUkUlZ7z3nM9w9mgEVYwic6chKE
 BdVF7rREhWZw3fLWPgUXQWJMxQiycF9u8LTJnzXjf9rOA3qifFuxI3rYXtI3s9UO0Ca2
 k472JmIhuqmYB/SI9ygmXxBXStMt72rKyuwVj7S+18OKz86zYlxdoToCfqBDkKaanfDx
 PgJeaqteT7NUqTUwNgI48IQG6pD8RGSpTsuUbjGp8VHSvLdr2AWtx1C33SCjdjjYS8cR
 svp6NLr79UcpnRtAAQRGQXCioR5RdXInBcV4eAjalORwBFxe7pCln2Jc1gwYXQBpGbuD
 c7GQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpyj6nwGHWerfScTH8y7I+lfsX8CoEbNEUt8srEzfIql/qteYxz8IJPHL66ewMERMKGnU/ye1o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l/7bbFeFsbIAD40sEeNFMVPc2PN6uyxlFlxzohcq0Y7E7F2dtK
 LOpRcHoVgDmQYtOBXa4CoimMWm4XBIjeqY6xWGhgS19ZnQ8mWBZhimnRiXjkFoOLJfE=
X-Gm-Gg: AR+sD11J7K2yZuqjizs2HlRMb1Meepk94VDYkLsX07rZWQwY/Btwjx0wN2A8ft/IDqi
 1fX0qpxMJzhK6tN1T/gwOj4NcfNF9IWcFuQmbggRsOVlL4udBjS6p0P40LJS6ixoH+6WR3P48+W
 q8B4hk6zR/146ziFK49OAinn2sq5PV324peALVyKHtu7kaUwKQxTRbC81LBxGTCa2l3BndX2511
 CH/vgGMCb9Z1o9Yz+ALHgCJ3zm54LWoPmjdgbkgeC/8nFgQsuyfvDma09RPDELr7yvRZQIBpoX0
 93QDERnXEFI5S4reWU7M6iRSU/OHVu9zbn79tQ0lqZw6Dog/Y5hHtoc4NL5xMoS2Of0OP8RRPOE
 BWMwFf8L/edqFcyw0j6FvcNy5vjKebj+jA1OfnE2+cF2giO68VvccSJZydSuyD2XGEoll+4FcIq
 GMs8mh70p5w5lCmU+mmR7b/zhzvOL036OOh5a1J2Gi1v6OcZd85+F0NUb4nYrjd8sJk0QKMly91
 cf17+cZ1eoeoLzJ7GbK6rZ5avF5H0Ra3RVE6nL/ZpmzbcekFySvPDVXNy8/SyShCuWVJJS1NAa6
 dWJJoU5St4g3GoE6D1hZeYYSOg==
X-Received: by 2002:a17:90b:3c50:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-395dec98ad3mr28036287a91.0.1787561558306; 
 Mon, 24 Aug 2026 01:52:38 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:52:37 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:52 +0800
Subject: [PATCH v10 17/17] spacemit: k1: fix product name detection and DTB
 matching in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-17-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
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

Use a table to handle DTB matching.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Abandon to load product name from ENV.
v6:
- Rebased onto latest upstream. Cleaned up board_fit_config_name_match()
  to maintain consistentcy with v5.
---
 board/spacemit/k1/spl.c | 50 +++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index b70eed14e6ed..93b0b6518c93 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -163,6 +163,15 @@ static void i2c_early_init(void)
 	}
 }
 
+static const struct {
+	const char *eeprom_name;
+	const char *fit_name;
+} k1_board_map[] = {
+	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
+	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
+	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
+};
+
 int read_product_name(char *name, int size)
 {
 	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
@@ -196,6 +205,27 @@ int read_product_name(char *name, int size)
 	return -ENOENT;
 }
 
+static void fixup_product_name(void)
+{
+	char fdt_name[I2C_BUF_SIZE];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
+		memset(fdt_name, 0, I2C_BUF_SIZE);
+		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
+			     strlen(k1_board_map[i].eeprom_name))) {
+			snprintf(fdt_name, I2C_BUF_SIZE, "%s",
+				 k1_board_map[i].fit_name);
+			break;
+		}
+	}
+	if (fdt_name[0] == '\0') {
+		/* set default board name */
+		sprintf(fdt_name, CONFIG_DEFAULT_DEVICE_TREE);
+	}
+	memcpy(product_name, fdt_name, I2C_BUF_SIZE);
+}
+
 static void clk_early_init(void)
 {
 	struct udevice *dev;
@@ -439,6 +469,7 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", product_name);
+	fixup_product_name();
 	pmic_init();
 
 	ddr_early_init();
@@ -456,24 +487,7 @@ void spl_board_init(void)
 
 int board_fit_config_name_match(const char *name)
 {
-	char fdt_name[I2C_BUF_SIZE];
-	int i;
-
-	memset(fdt_name, 0, I2C_BUF_SIZE);
-	if (!strncmp(product_name, "k1-x_", 5)) {
-		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
-			 &product_name[5]);
-	}
-	if (fdt_name[0] == '\0') {
-		/* set default board name */
-		sprintf(fdt_name, "k1-musepi-pro");
-	}
-	for (i = 0; i < I2C_BUF_SIZE; i++) {
-		if (fdt_name[i] == '\0')
-			break;
-		fdt_name[i] = tolower(fdt_name[i]);
-	}
-	if (!strcmp(name, fdt_name))
+	if (!strcmp(name, product_name))
 		return 0;
 	return -ENOENT;
 }

-- 
2.51.0

