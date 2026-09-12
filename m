Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA353C79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6990860669;
	Sat, 12 Sep 2026 12:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pko0eYvlSYL; Sat, 12 Sep 2026 12:37:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8A3416064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216668;
	b=Nfidwls7FpQZx83u8cPvs32SA/mxxYUQ5/ziNcNuWAVfMTDTqaCpPJLt/n0xETv4K6A9
	 z84votDpOcwRWU+7TzjFMbB2ZOFlehPgZbQsbQxG/J7rxvYqaGke+MyuDz6D0eTwQyEUF
	 GsgGHQsoZPyo9rernVAUnFkBqFcAdjtKd3BAjt0BQZy7OgXr3zvESBB65YusHzhaviz1C
	 QtgsnUQ4vpDJfZ+FFn9UmFn3rX7W4NlKRTHIEzhb9H1XvZaP3RIJ18Mr4uECzZom9EwPp
	 nVKfxPhPpW2ruNMPn+PliawwzaVXWr6xaGq/WpJY4rRCMPi1kIBs5GAlddd26EHSkmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
	b=XooMF9H2Tm2AyT8cAyyGCT+s0uNp1S+aLknDITy/OxbhOPDESQC/o787TXC2Dq6cod7J
	 ixqVMo1B4VeiffYkQMdlLEtTNRHzgoMzrXxHtA7EWq1lZIEFbNn6M0jkZOfjRQdzb/AZj
	 yKyV5oRJ9CWTczvCJOpiJ0Ud4tzwfCgk4uDu9oJFqKTgU981fH5zFS8wGuQM17R83f52+
	 DW0g28lRbnA2+t4IkxuDkDG+CwA9OoR2EJUSLwyLTpH5ollukrYow2yr5BTpskbPO931R
	 9FUqkfys8paxobqPKFDzjMGDRggxVLV2ICGaqtO1zKCFBMuvfapR9mB6cMCIhr8eugw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BPH6KgNP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216668;
	bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XgfcDOJDuf8uqgWOLlQ1GcgxioIkb570Cq2cI4HDNdva3JstMBTBdmvMzysscHJ80
	 vBONfQIQNpm5eLtFqM79TUUgEp1+RbsKiwBsDV+MTw9WMx968F0wEuLZAqZG80e8Yx
	 EnijitcmEyUi5G1WNe3qAX/nUjP9ZinBoGR3d/HJplua09stgnx026rPuS8x/6sJ/O
	 ENdHaYxWLv/iJaws7/Y4a+FoduEGzdS55+l12ROi5ytWqwoHV6w7FKs2e6WAutDQXP
	 eljDtVmFmqz5IUQkbDCQW/rl9bQm2g6EmkN6/+xelaoKr590bCU4J9+qHkWQEe/uy+
	 V8U2ISfwhbnxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A3416064F;
	Sat, 12 Sep 2026 12:37:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94D752D0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8690960678
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDaXsohLnI4y for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8153A6066B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216665;
 b=VkX/+NWSCrfG+v4GoiFL1VRnpv+qabO1soKrkLvYC1usgmL95e1fdFDg4bodgWiDklXk
 w8Q44tAjFpxMBwrooj3ol4dSCRQZ0LPvs12LADdJ6rVLIXDuVXhqXlEHBBl4LaeKdCg9u
 yzg72gKwLwRB2cv9l1FYlHE0vOJLEKvASlOBtl3l4R3GBK+0Vs/+eZR9NpSIB+dQmYJps
 TStQAsK4KMhiRDtvtCGXPYqKwYWCqSTrHDDf3gOeQy+Isa/iYfc3wcqRa5VbnHAwnHTvF
 WgAKinCSomjjH5AQiXxFn9Yibp6oYBLOJpT3tL70NK7lSJ/AhPNkHegCP2RH03fqRnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=byeU/34+a80UZO1evbuijaSesSZT39Oi5+kPTqn/YsyzrDGsbo69mykIn1jS00piWDUg
 S3zKgD78LVlcDKt7pHVgCKmZlbwC7LHXloqYrHC7GmtFUEWiI00A+G74DWnuHp8dGGxhP
 kr1lW7NgNhqgq9IXtdnkD03UaC/IBPJX4ZOUDGky6KQNW6JhhjIF6FdlBl+CJ9bJGuJwC
 5Ax096BCNJ79lLRFb0SGsqzkCe7XQPojzhMKcUluZSVUINPmVKUq3VmHnqfMa86pTP0jC
 EkdHAvznuvbCSbrzc2K/RAQP63pcfu6eWQPBNh4IMtN6ozaQkm6hpJyIT5Oo4ivsAeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=BPH6KgNP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=BPH6KgNP
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8153A6066B
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:45 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so491140a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216665; x=1789821465;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=BPH6KgNPyVqdgMof0fxeOHGgOyMJcn6zglJoLAxQyV+5Yag9k/DFrq91fUAQja+g+9
 wwCNMteAX36X4bt+PW79yz2OyxOVhCgkRVWERndNCaENs5PUpqbvBlVuSidWsUlt7Rlr
 j3IMZ21EVL6l9GxwVBF9X9O1ufClnltQaBsWAoPXMBKdP01dnyCmBLvOrZwXGkoD/uop
 z1GJ60Ssq6hXBSCBcQIuG+9MBmMLKo/bXOJ3N7sJIMW78TRkK1YkkbMyEemqXjTO763T
 L0qXw0bX5ht+jRmf30dJaz8hnkDj50C2L6aAi7V9vTSOewkPqginm43gAzuctjIQteBI
 tWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216665; x=1789821465;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=Sg8DxkzDFSvLIAg2r+KVXemU1nd/9ubbwVyx9dWtk6w/0aRGJBw8emnBEeCAzSgmyf
 0glKh0KYKxnnEjva3knuHhXNzoPyiwoEE9KnIIK/21BsNWJhOewPlQMPsco9aK8PlScm
 vcLYhgwtf3o/IOvbxVnsfK7mm5XZBrAVxv6FMTxYf2fSNPbn6rP1Xwa0FnHkbw7PBijg
 kQ3EbmukIbhPwPhQXmAbKKmbpFyw/NBYqdhnimbI+hVQ9WCmnbhL+Cc7Ff7iwyYHADx9
 q5BNo63L/CP0UaxFcp3M5Y3FgCMvzDnFe++3znWHKIsVVmDqZJIBlvnCqSyDnFpFgqe+
 M7CQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwmJaK1VcpyUZvdjjIkrNxPYG4GJQcXvMOJKoxrilfGWx+UDl124jxnR52W5xZk6ppP3qHMNA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nDCDnS73UOtCnrKG2xCDg8oDWqCdLW/thtj0FpAh63mQ5mSXg5
 QxuzAh8JJUEBmdSwZDqqJEs87v7ZkE4xqUckZTIf/E3MkY3WmY5kzLzvcUqmH4Oz0SE=
X-Gm-Gg: AYBFou3kwSLCBvisUoDKYfZ8jaAvDWkJoRE08P+Kr0TlW0DQLm7Q1n49puRaONnk9Qq
 ZCMl12RR84H4iDHDa6rlUY8yNwLysn5K6Ow3Lzknq4NNdaZ+QUN1J8E/vXhV/wkgj7RHw5eubRz
 0FGEByYBdlgPscdo3vT96k1Gqe2owB9t3nkLcslRe48hiE8wcbiV3OMfY97t44Yjqn+S8AcK7HI
 wf8yuPokhCsLjepaONev5YiA67mssLBRZgo+pMN9mGdrt3GsvyoRsGJ+D5EdoC2S1M8WqE1WyBi
 NIb+09Mgk541+/vwlAVq/nalLWEYjNKADF5RjzBkOmCVV7EvYslqJFc43egvH15oTrlnlDS0cwp
 0Mr59XNWdnPd1aHk78013h50yUbYER/Gu0jzO/BcWZSgTh0HnOiZZ8aN6awPf3swlak9jzR6DxP
 u4AhXGmVYrlvbNT4Wr+QAu3Ve8V4mUBdJZ2/hhvsezLVHAHMmrP5IpOcUW85ZamEOKrVTBBSDB3
 8u7yNYN39jmBOzr2PfPIlh3Ixj7fe2jUYXmsu4eGaLvqlK3mwIUuC7YxHSBNqFOk84GdFDIWgSS
 /zxFxF9QKe7dj42OOnD4+UqdehX6AOy87HL8
X-Received: by 2002:a17:90b:4ad2:b0:398:9be6:f996 with SMTP id
 98e67ed59e1d1-39d9c34a241mr13975908a91.21.1789216664631; 
 Sat, 12 Sep 2026 05:37:44 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:43 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 12 Sep 2026 20:37:00 +0800
Subject: [PATCH v13 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m4-v13-7-71043b29630f@riscstar.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>
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
index 374922573c98..ef23db62d6cc 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -141,6 +141,15 @@ static void i2c_early_init(void)
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
@@ -174,6 +183,27 @@ int read_product_name(char *name, int size)
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
@@ -417,6 +447,7 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", product_name);
+	fixup_product_name();
 	pmic_init();
 
 	ddr_early_init();
@@ -459,24 +490,7 @@ void spl_board_init(void)
 
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

