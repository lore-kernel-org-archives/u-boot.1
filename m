Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58C7C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E77060609;
	Sun,  6 Sep 2026 09:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DcAjTQ2B7HpV; Sun,  6 Sep 2026 09:12:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E2E8E605FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788685925;
	b=M3TB57aF8600yVfaBSjAkTl/EvGHGVrHcB6INh4lQhHgg6itNeEM8xfJhgabYymfPXpP
	 3bw4FMxlIvLawkIxYEzc4b9QDUBtO6+3THwDXlZCV1vw3MK7W5MSh+DyNE7HokJ+IR28M
	 nrZb7TkSnvOrEkrStna0rC7Mi2aibkGVVSf6tzRc0QEVOwFc+z78gn1B50IIxekULe0gj
	 +1LY+x/l5k4dD7+//eBQNXCRGc3YU40KVuC6JHlu99qVm/aYYWChJfmczHceWpt/CifvK
	 PWKnor/0r92G7ihXn2C+AKhvTI9ieSAHfY2qeGlKyH+cOoBpLFzKm2aHvMR6Uluv+zA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788685925;
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
	b=BMX8H/8irDoX8LWLUSOzpgbLUdXSzs1vAWkvO+Q0nPUboP1TRTfVc8HcMH7ZjOr5W9Co
	 2dRTCP4V4JGBKKBrDCZIO6GvA3pAm6fJn2r4Ct/gc+x09eUbm8KqKS8TBuXcEn0+xAllh
	 Y7XkYNZLUGZvQoCTu3gKH4PG0cjuLAe4e7INcSk1BDPLTLAjOjQPWLrdbNJQQbGHRm0sW
	 nP/amszJF8EHqeAjAW1fGsldI8RZasPHArunaFCGwndCJlSbhng/3ogAnWUuK9ROGaxdX
	 aHyh2QMKGnyOMZYAgHMbaHItbCoMEoMyUg+IpQWpDk7PZpmHQUzF4YHTMSwC5FmDA3A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788685925;
	bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UkiLA8li7ZmnObPE+DQ2Ca7Re9vSSW26/wWMRd1L2qWYlyWioSqlgyA6DVrnpAdBq
	 8+ysUtNux/PfpSmqwh8RNV373ClXmMWFthTd1QEF72en0UgIXh3KmA5Uu3b/YbfHnu
	 0fA4b52qJv9GVpE4v5u3KYp9h6AlRms8yubwEiaLhesN3oDtfv8yrCWDM+sOYIPTz3
	 y2TwG/857tIUdNTdIdKpZJJHv4ZhkytLzRVCjD8eYXbMgoG36+0XD7q4FJXh6kFS7k
	 5grOWxxQmVa3D3bq1Vcjafzr9m18tBVs9X+3GNX0iCHY5mAZyBeJBjDZ021scbTyQt
	 SnO184K+xJyqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2E8E605FF;
	Sun,  6 Sep 2026 09:12:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F09DD72C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6CDD4008B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rut5L8xaqmdA for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0C0174007B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788685922;
 b=Mvxl1GS+xjBKm8xUkkDYq+BQGzBOQYyI3KgXbYLMGWhppIIyOkzot16PeV6TIIQmVDYC
 0YdKMJ05ZukPYR2w4YcJCZKLbX5brVprHsDqJL6vS5rO21s93D6vITLPu9nPzCG9TIOug
 0Q62mIR5cxX7ABTBdGNSqImzBG1iU+yuLoM0cQBWX085/xVsE1FS+QCdqR9eatZUM4wiS
 eOcvIqNVHteXYMmBbbCzeckDIwhvPwZR4lSDuJwBMoADN0CrJ3bPIDwqFttEZDpZt+Ank
 wSY0IxHsVY3oWQDS1BAAQOFoghfq/xRwa9PHuoCvDG/XfxeLxnnFIOnPAzhWXUtajog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788685922;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=VIGbOJay6F0YN5GVnqGsJlTqGTDH59+rth9uLqRc9sGSNoPP5zJqm/Di1Nc/M+ZKgxK5
 vDw0mjxAJVwLhxy5B+qSPD3l4CS9IEJm/2e2MMFIBOic2neXi8S13TS//072Rt37Hqpt9
 yfBuaUlTqU24rskL7b+jS4J/iVon9VrGD2qbfS8xaeDlEv7dQaSwc+NhEwWyFzefQb4sD
 U5UmkhI5cFcjrfRJlRm6AcSY87H9WmSfSZHceUBNkgNWr9oFYgRYHN8ykF4ptFtfLwqd6
 CaPs2lsB6pkPr+2HevnVACSRnkNAwxR+6zQuNt8YEDIw7bH8EGl2JYmQkTuBYaM97rA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=XCRfyrLm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=XCRfyrLm
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C0174007B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:12:01 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso2309900a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788685921; x=1789290721;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=XCRfyrLmw3gVMgQsVQRY1fnR9zR9nZcdkMONcuBrvtqn68pg2uyJnNvJuRrLnA0C7z
 h0A0V6wj4CMa0KUdfEtjEaaB8F8kDEr0A0i7KbCT74Oy3CzC/C2IESnWnf103fcvIIyk
 c5d0u6k4uGv7lRX3IBiNxGjpY9wBIB8buu/kwsm2F76TbkwzXyeTPZke0vd1wSYia2nw
 Ns9eRqwd9cKIXE3QbD2E9jB83JpKfgVGUu+WgSxFsE2748RCwz/Bi08yqIaD8udluwZt
 Z/JAtiZpFRvJ+zp3SycnfxVToyrAxy1ssdHIJyjCp7CznDqdx/qbcMWnvCGNPhZN65eP
 oSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788685921; x=1789290721;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PNK+iiuBf7xGlRNVb+ZGF2hjZmMQuJFF+XnAXgDcwWA=;
 b=f2tJd11ROr3Mqp/qrBSPGYoAiK7O1tB9o2mVbovAbBn+aSoPXDOOniwSGol3jWOwHV
 Qj6P3VbF+KQpr2ehc+RlWIur6brsxNks+gwJe9/n4qHLRojxLvsqoyNuvdTaIG3SMh28
 RMCx5NrqymkmO1kGkQiIk6m/nKmLDTDu9Kl6hSK41Ku0tFzo//2de2u7Z5g7hSG6M/Ms
 D061KAv1c/uDkWoDu4o2P8ETGLyCf4GlQCDk+IIlk7ZCus0riJ25HFdKqi6yWKF0Rc/a
 qaRqC4Ucgb17maRL+IJP7VAdt8Qwr+dcDwFRxCOlkPiIMvdRC97uI8jTKm+UYeooIdnM
 r7fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2prJWoqZAWiIpd9e4r4t2NOtqiOCzIQsis4bCDiQSWYAg7YPB4RKTFUBgM6bYZdk/Ks38r88=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nEZ3tJR0c8gVZcZEd4eiGpJV6zOOTnu89WFLETR4XzXRPQsGm8
 MlcHl29c2nuSD6PFaCKH67HySwUexySiC6ubFgs34Bf6Fk4IGJ5lcq0rkY1hdOEJlQw=
X-Gm-Gg: AYBFou2b6Xi4yhwt3SHpSzbTQkxACrrJ3h7hTeL/IxssdSTQtKAEm5fkA0JnGWZTCrL
 aDP/p7UB2i3Jm9x1R7qBxYgzuRL6Y/ybRrFcAmVNCZ+MWy4HDJIcER4Z+fLnlb+rCrBrUmT+GIB
 paY5w31r+2Oa4olf1x3vtiw1/zpJZf+1q8Cc8skfBBrVqTENRahRNuMb0rMY92fzjePMgkZqmhw
 nxKwCEhL3oYs/XGTGhPRYoLBhLMpC0TdbjEKsU6fj0fUsEgRm9JQ2idUANlbgr8ODqPyICc4HXv
 OpsZRDE03YmtK3S7hxFZ8ao2PSkAbEedUM+F+rpdtz6PfW6YQKHSnJ4Zoac8BNBeWSST8/ELh/5
 2oDSbu/YMJ1cUcTz9aqpf0/Z2uoQOdV0NsjSErQiCtDKqsmeNbv7NgMPRmmu456UixChm15F5CP
 6WbuJwDgvhWPNoYsQcW9h+Q3EeSG3OaM+mIqMe9ngWNysaitG6XYJD2hLDoUI86p8v/orrWltVZ
 Jsaf0utTH93qQtVNTJgCy323x8CWK+naxUkdcqzzDC9QDJnx07SNDAjSoTlwXWr6AZ1f83dgLy2
 wh/LpLfTb7NEIJWqFBSm3tAO+Q==
X-Received: by 2002:a05:6300:6186:b0:3cc:2552:ddd7 with SMTP id
 adf61e73a8af0-3da39bb4700mr28331666637.5.1788685921222; 
 Sun, 06 Sep 2026 02:12:01 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm18845384eec.22.2026.09.06.02.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:12:00 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:11:09 +0800
Subject: [PATCH v12 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-m4-v12-7-89eb5a8f879d@riscstar.com>
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

