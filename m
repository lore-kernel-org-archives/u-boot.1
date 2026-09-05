Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE7C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E779740BD6;
	Sat,  5 Sep 2026 09:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qnS7OXG6liB9; Sat,  5 Sep 2026 09:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BEA9A40BA7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599731;
	b=ZdneXYYJmBKFw+vVF4Q2DbM4qDm7okDEcLtvdK5KHfa+HF1VwS9fkHOPraAfUowKqMiB
	 1WQ82UtiIGozUho9zBATCS/WtLegEGXCRF/5cgqZjIwCvY+xBt00C4GFtvYvvbSm5v/xq
	 RYlXrS9wLJoHu1/3CUQKWfOVP/k97jxKgbxpmC7hiQNRYpDCKm6/l24taqGgtCW20qnJr
	 9uoTaidkIUfseUqQ4KPm+YzssjC937OgmxKChQqz1IPclYkpit3YgbQAhnEIYS82g7nug
	 F0vWpw40Iib+VvkE5xJ+KXPtsf8+GfVJ90YShL08QvrcK6+1tV7yyugls78GfKdX/EQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599731;
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
	b=JgBS6RHZyA34WJpC5Bv/jaUWuHXl46Ez8bDq0rQdM8PeaoV56kmckgbR6AibLbyQ2bB5
	 TzkZH+Xons92Bh5g/a69QEpKupnqfzQjX4cYqhOx9mivzGcYeuJhQml1UrNtB8F2TIBxx
	 ZqHYxLnoPY70KwzYcpx5w3elaNxFyXDBxrNLNZ2HMc3+7xeJptbWF98ZKoaAlJoQz4Kt/
	 s4JISnzRr2TNaFa1J4u4SfYeHryVCccEZQqfywpglFfYDOvBweb3TisHgQAm22nJ4opAS
	 TljXzAWyx4VOvvE7XQCkvzXQk97k/OP5dWa4/iIWPWmrFb9trQ8l5JuMKuPSAe8TwZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599731;
	bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L39LyEB43BdcdZkV1kbGXuT5lTvyhZp4Veae0ybswrTfNuF/rm+ul6IEgBJdv5dPo
	 o7BrdYbBNi8hSHXQUBWfWNmu+dNFIa+pLDevY3DLncEdK27akQ/H7E/44ifVxmGgWJ
	 6So6DQb69c4l6mecrbIe+1wkX1fUTVHjdBmckQ5ATTHgOmfrIcvG2qK/qS83VF2NyA
	 YBvyBD+p7uqJXeddhPV5gX4BiULtNv/P4ra4WS0TL2B7uJDyefoz3zHmH2SBBRG06n
	 4HOQVWwHFslamEom16n4vLTEZPI16Q+V/6FuHPtQt9u39ahzWd/zw0w5dEETs5eAjP
	 JBbjXVmzl9hZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEA9A40BA7;
	Sat,  5 Sep 2026 09:15:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 85053105
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A59D60626
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sWGpkPCOSIic for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 24E8460BC1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599728;
 b=EYcloWkCdCFJU7PZQkCYoYOcioHksflKXRAFkiCTLarEod1Ts9AbxTmBTf2t15T8Q73y
 3gcFGP2YR7zryiNzKn/KzGthNSzQD+jZdbbQSWrpKIS5NaDCb6g8hv8f8dq8mf93KbT8k
 ehjjo6D/EPqrhJEAD/2aCT1+tOYVbiGEtQPti7gBWNAUFm5eTLiryrGh+bHGLuE/iCbZC
 8a2/cHN2dJGpfm1auUsWiszgju10ZvGV/vfT5qHGf8pN8yR3z/96kcQKAOLXRf6ibUM1j
 +lQpg/KmT2UcZCYe9lv7fN2hPoxwsHRAn4gSEvmBqQEKPZGQl1ujodwLcZea899Sm5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599728;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=kPvSAB4nM5H9KQruc1PpR7n3Fp7aKhDGfS9P0XRcdPbmxSoxgRad9VZ0xNrjPxlPw2A4
 0mz2WzsUrkrSPE08ligSh2FTbmDYv2+y/l9Q278mWCvf4Tf6i6aIt0VCOgcGp72Eb+gd/
 jGupqaHX8ZVwriOANArRuxhXaOdSOlqML4ETPMIdYQQV2XERO7mTAZCsusnRoq7Ko44bp
 FUz2tfCwYpJhzrLTXtR+8mtfADrm6acYbAnIsOg52pThFAVUJfT+gooi5A9TBe2dtTi2A
 KRgbLQulmdJ94poa1ttnpQ/LyKq2lWvGOWO3c7M6fROyaqiOk/QJPgKBGcg9S7AfpNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=b9WvnPzX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=b9WvnPzX
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24E8460BC1
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:27 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cbedf433a99so1793881a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599727; x=1789204527;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=b9WvnPzXiAAXgvFX03XTPFux5CRJp3z8/Im2cVI4jgwZDCQE7AOPlGy6NQSp81z4Xh
 ioW4yCDsB4CoY2KZ4ZGct4C9wg0Ih43i7cLcjWb3BftkvnA5fvAI3IKj86xCd03njH6s
 E1blEgSM55/5q6ToK6ET6rXYezNKgtlSi9j2e2Knef4MXtPqrrKcUqTnXth0sznkRAyE
 zfKMRoqasGL2OdVmyV1yDGlhbsel60D+QxpsC6K+MI47mQ5opETm6UAVXiyfz+K12N7W
 5D0kF9EFn/hIYcUb+5BXZVzVHRrbqKGsMWin+qEqN3kUtyXLMNFhZFeQLuWDCy30zPaH
 +VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599727; x=1789204527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=MZhbFU7jtnWg5m0iJeIIHOOXV/uczHbaxzzPFL9RIdnaK8AvZCSXyjjnNBkdkNH6SS
 GNn3ccONCXCKQnX9UmO24R7x9f4gzd1i2I0D6KN43E70m1VHkTKh45Xp40apd2MWcyd4
 nx0seMX+keoDQcwo5NkRblhTOZpwHIEi6sIFDRsY8WxlHJX9imTLDVozw0GAtnw9V7ee
 1bgWrBAAAYJNjBP9jaGB/tj0VuGc3geRvR7BABzVjgZnACeKlU1G1oeoo9jtgMJv0+XY
 BlC9EtTsQ57pbxNTN7EIU+q/o3Q0eKhleMyecpPrtMQS2D0XG/MVP5dFMP+QKhAGVny8
 A99g==
X-Forwarded-Encrypted: i=1;
 AKwUvByPeOKRA+/04bDfAW0IEVX6HjzG6Jij6Seswy7Oq7noY4p7k6lh5Embzf00SZjGb9qm9ASj/mo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nNY9nBo2b/vumkTNYH0ekp27IskWb5uJeRohMzyWh/M8Les4xA
 rKtb0AdF+7IqgCfXIdaFfIVi78p2VQaCTrgR485VqPgCUbdp67vs+ISMmy7PEm/12uU=
X-Gm-Gg: AYBFou14aJEvvL5xJzJWvsIV9aBsqGMXLu4ifhDs1VwefUOvs4Iw/9e1N2XLURfXi+C
 jJA+l/hrAk48mMTxcj7kNZZ58fG/dqhvI348octGcdHiBZDgiY1EP6H9TQwLjgxjbqfgVtdu1IR
 gTRk/VFwsi6olDvZcZIKz+hKtMvbqhw7pvp7IkrPEoy0lIAOyEhSv0J+5zmgYmnNIu6AJZrab8b
 GjmGzub1sNynusFG47WVnWA555LJrThuW5P1J6GoOXwuNfXWWgQmK9nzJb9cWU/nv+o0BSiwi1W
 MxGpsKm/iNtEvTk6HcHmOpP+fRy7KvlTPXA3DlJeIbz+lIgb5MmOqcKWuW3/bJK+8WKCf1v2MTL
 W14XEeXdjmQgP6VSJN0UcMFLCKX/Mj48AqogdKQNZzLnDsWQXFeSFe4J00MEqOvywCybVgbHAIl
 glUChhoYPfxZFnSChSqEKtBHS2cBLGdeQzwhvw9IcaHxUEm5wm2VviAshEBjgeVUCKaXpDB2Qex
 OISgaTPsG9fUHjqlZZIViYcW1MiV1dzD4U+FErQn0RosXHQ/aaSsQI4HUhg5RV2z4RrCku0NCqL
 Jo/JIELbX2PmaKDK9pEz8ThEIA==
X-Received: by 2002:a17:90b:268d:b0:398:bdb0:adb7 with SMTP id
 98e67ed59e1d1-39b261e1beemr18599762a91.16.1788599726615; 
 Sat, 05 Sep 2026 02:15:26 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:15:25 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:30 +0800
Subject: [PATCH v11 17/17] spacemit: k1: fix product name detection and DTB
 matching in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-17-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
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

