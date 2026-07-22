Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF126C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93D71409BC;
	Wed, 22 Jul 2026 15:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSR6a44VQmNp; Wed, 22 Jul 2026 15:08:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7B8D4099E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732901;
	bh=YsAxogmfQYfmHWvlQGzgDTHKJxrqbJicdpC5y6QVQgs=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uZdiCLXKBZEXHbNGPM8yVRE70nNYZppbF3jmyEkCpNOkSQCMOPfW7gn4MHyNdd6lO
	 t8HfZAUswxTRQyo9t8UZGXNtOMaY3PTiOo6pl+Le6oaKxfnss6ZQPqEJleXjBOBYNY
	 4SCAIaiRPsNh+waLi2sWH/ivkBzHJNrrvVdtcEu4RJJHIKXB1dpFHVNUznZZhvUgkQ
	 ehkTURjAmjm2KRetQqAUFbw0MtuL2ZAcXsqTCOaI0Ek9Pa4cZicvLF5pcx+ZviaJS3
	 xReR4gZKAmmx+/rTCYwCbexbM0nKmeXUGEnUZQcUl1vqI3p9G4LipaVz6qFMN6HAoi
	 3/wGq1FU6aFEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7B8D4099E;
	Wed, 22 Jul 2026 15:08:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 150C41093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06B9A4099B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRGImiPAHXIb for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:08:19 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=eric.chung@riscstar.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B4F0E409A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4F0E409A1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4F0E409A1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E09C8494B; Wed, 22 Jul 2026 17:08:17 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE40848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:08:14 +0200 (CEST)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso8277666a12.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732893; x=1785337693;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YsAxogmfQYfmHWvlQGzgDTHKJxrqbJicdpC5y6QVQgs=;
 b=LC0T91kJjGjWPlY124/jxfMofZScrc9tsts9qvcxeMVp7UtxsaETAARzy45pV9ZYcM
 5O0kcpo2NF+fzNQl/59rAMfihuBznCjfsW1cwjO9RrEHnrN5rucNX8Yp1EGtPJBjWhSA
 fjf27y5tajTdhNVfCBGOjW7WuVAo/968kN0TLlpwmlnwrWzGRMgsnm/oeVvwB8D7WMFg
 GyjyHrz4nduMLp1O5BhJvljDdY3SaQu/ckz/+HXe6T7ZhuhsvGVtfRloWmVA6RpWPIsT
 cXSUbs5omwiyrgFqH1Ehv6UePuhq5VwELkmDTI5xhDPcMoDbua1c7by0W2OxZK9K5Pkw
 iZKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjyIBpCOaYp0eHNjfPK60yzZYxTUodvIun7dDqF0a2arEHOrK3rOEmzXBk4xkNln0Yn6RZyqo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywucx+D2Fj11eugSyswryk5JEpSGG/pBCMIJ6dX6kf1gUy8cbEf
 et4LVP8LW58Z0dvM/DZYa7XvXHvosuM67PvqXPEwtdfOYzTVeH5ZydwKDdiU8rOwPHA=
X-Gm-Gg: AR+sD11u/4IONaDA+WO+V2wsIe2JR7CXliZguY800SZ8snWiUkPrp6sZZ7O2f8pF+sx
 gQBb588sh5VjM62EmUZ1tdM74zuRXVY8s3HdOmjh5OBr/gGclUb7EwRvITLFsWuI4k6kesK0N9l
 fEbKmQWROHxp/nxLLG0GFXzqcKthwLhqmBU/EkhZ/cYBiJlwljOQXd12diMBugBfWYJexRuvvak
 hJe+ftVxy/A2vPeAzyU7ngI7sk4maXGPhea5cIUbfM44OPpFYSpcrvhxi2wE3mbwHAm2jCQyyl9
 s0ijPU2Xpivh3FpGDjNay5n/q1K8Uh6VUq1bmqeA5lABImc5wehpKRAoQgKXcTeYlPzceX/83Vx
 aq2VBx/43cEmaQgJ4qJGAu29l+rz51+W82YsoOZY7gwDlL2eJ9R7WmtEuoRW/TXAfXL8VYq05RT
 W4cLMYEPYqQm1FtEJW8chSJMPw3YN7eCNZ3I0orICBXXi/fQGrwHUebTVfMo3Ah9RjaARKxe50f
 r4gjLJKC4fgKF7HoGtw2MNEVnb3LR7A/sOPTRPRZRo=
X-Received: by 2002:a05:6a21:7a45:b0:3b4:8bc6:138 with SMTP id
 adf61e73a8af0-3c3ad668332mr29446933637.23.1784732892908; 
 Wed, 22 Jul 2026 08:08:12 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm10622267eec.25.2026.07.22.08.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:08:12 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:07:05 +0800
Subject: [PATCH v5 9/9] spacemit: k1: load product name from environment
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-m4-v5-9-c41a951e5157@riscstar.com>
References: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
In-Reply-To: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784732893; x=1785337693;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YsAxogmfQYfmHWvlQGzgDTHKJxrqbJicdpC5y6QVQgs=;
 b=vD75R5j0TlX3HAm8T5dyIQ4Nf1rAXuhwGCN0nYH1Lsf/XHqc9tm4j3GBgbeM9equl9
 YMcKF0qC5r2CubBGY/vMGPTXxVVmgXvy10LcW2xC+eSORFM9iAZBtTMiCGobQTawROZk
 1BpLtc7hkAhAq/sN0o+jQQSpm5W+YAUkknZP+Rx2ZVqAhqwmAED/+IwXfr2xlTntj/nK
 UtmfUBxck5rYfVSYNxM4r9nzMjGL+jFqCNICO382+1L5XPoxRLXWM6lqhJoKXNVf/V1s
 mfft7qFTE5TA7D0DYBF+3M6RmmO3J4rV2Ee8ACWMuL1jZHrvpzutX469R+8UatEwYZ3S
 xWAQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=vD75R5j0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="vD75R5j0"; 
 dkim-atps=neutral
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
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Read the product name from the environment instead of EEPROM,
as the EEPROM may not be programmed and the environment always
contains this information.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 board/spacemit/k1/spl.c | 51 +++++++++++--------------------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index cac89bb6844..69c992ea57a 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -12,6 +12,7 @@
 #include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <env.h>
 #include <i2c.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
@@ -96,39 +97,6 @@ static void i2c_early_init(void)
 	}
 }
 
-int read_product_name(char *name, int size)
-{
-	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
-	struct tlvinfo_header *tlv_hdr;
-	struct tlvinfo_tlv *tlv_entry;
-	int ret, i = 0;
-	u32 entry_size;
-
-	if (!name || size <= 0)
-		return -EINVAL;
-	ret = read_tlvinfo_tlv_eeprom(eeprom_data, &tlv_hdr,
-				      &tlv_entry, i);
-	if (ret)
-		return ret;
-	p = (u8 *)tlv_entry;
-	for (i = 0; i < tlv_hdr->totallen; ) {
-		if (tlv_entry->type == TLV_CODE_PRODUCT_NAME) {
-			if (tlv_entry->length < size)
-				size = tlv_entry->length;
-			memset(name, 0, size);
-			memcpy(name, &tlv_entry->value[0], size);
-			return 0;
-		}
-		if (tlv_entry->type == TLV_CODE_CRC_32)
-			return -ENOENT;
-		entry_size = tlv_entry->length + sizeof(struct tlvinfo_tlv);
-		i += entry_size;
-		p += entry_size;
-		tlv_entry = (struct tlvinfo_tlv *)p;
-	}
-	return -ENOENT;
-}
-
 static const struct {
 	const char *eeprom_name;
 	const char *fit_name;
@@ -140,9 +108,15 @@ static const struct {
 
 static void fixup_product_name(void)
 {
-	char fdt_name[I2C_BUF_SIZE];
+	char fdt_name[I2C_BUF_SIZE], *name;
 	int i;
 
+	memset(product_name, 0, I2C_BUF_SIZE);
+	env_init();
+	env_load();
+	name = env_get("product_name");
+	if (name)
+		snprintf(product_name, I2C_BUF_SIZE, "%s", name);
 	memset(fdt_name, 0, I2C_BUF_SIZE);
 	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
 		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
@@ -453,13 +427,10 @@ u32 spl_boot_device(void)
 
 void spl_board_init(void)
 {
-	int ret;
+}
 
-	ret = read_product_name(product_name, I2C_BUF_SIZE);
-	if (ret)
-		log_info("Fail to detect board:%d\n", ret);
-	else
-		log_info("Get board name:%s\n", product_name);
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
+{
 	fixup_product_name();
 }
 

-- 
2.51.0

