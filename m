Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD76FC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93B794065F;
	Sun,  6 Sep 2026 09:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NDHDdrnZVBx; Sun,  6 Sep 2026 09:32:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AFD4F40633
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788687139;
	b=l62UWf9CC99q7el96YtcCZUd94cLyZplMm/Auq2uBtcnT5FqJqP9TBQ56kxOagCjUm1e
	 vbGKwNViZJ4Pgrh4bj+ioyoDjatZLtKL0PgR4z2WrwueOm1TRacIqjoimtZ5R41kGL4FP
	 PSUVM0te783Zi9hq7HRN2iARbe2HhEBEi/ScIdi7G0Cdz5R6ZMaSrutQ5LFXwjRRAF74y
	 eZ9U5w+ah/g47JrujAYrCt9CeI2OC9GRWbi5ZGSnkhiFTLxrn9/1bB+KiVaYeywXcfwsZ
	 Qta4xPKmA6rJRHqGFcDHa8Vhdc5tjki4rnBcsWrcW2/lE9/vht40RGefpEL9gMcEmWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788687139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uBCiymqb3VuX0Ndc8ykOHMzyokTRoKVLMPKKZ13ir3Y=;
	b=O3TxA+n2zNIPpktt2Up0nHz5ATmbQwKZ4FRxiapXQLricXW8nr+BWeTFQqtD7NQk7E34
	 6f/2oDNkqO2LgbfLNc/AtcZyxVCYGqe2psg8vEM+b+5XcB9aLbePhfCbMs8gHOTMdFik7
	 WzPLsfo38Tnh6qVjmwLCdwRZ7YRYg7ddiw6NwwoTJ8n/owtWOEMV/7SEyle7owcAanjV9
	 frBlNCUHHLhPXwDui7tRj+KltVFCFAqKVG+LIQfprB5GHqKP2twpQDkFCXK1jVVoqO/3W
	 6p8c0yyzEvnCFxO3XgKYV8RZE6M9APkHbaYtHAVWYdigTE7v9DpBlowOqjoOf0D9Q/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=gtEJ7nOI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788687139;
	bh=uBCiymqb3VuX0Ndc8ykOHMzyokTRoKVLMPKKZ13ir3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JoVos731QHLt4wRIo/Sf0jgudNKCdAOwmer6fR1k0PxzKVqv51Cnr6/h0lRnMj+Td
	 U/2DqHhg/TCRT7OLCRSC+p7pJWTeSd61VtTM/frkXyoR8PA/EBpwfwIyP9ls0QFWQr
	 rMdiPo3vwGabRvlKGLFkYZO+QImD4tFneMXm/YByN59IPMUwuhdOlXANN/E+ATtJEf
	 nw9HlWURuJlxlGsJ8npr/4NM5XbSWVQ/m3dJFv6Livb1mTWOsVVYfOxBt8cfnL/kEc
	 fi/RkZjjFWEv0ttC/npnuzbQHf6reIjJAhxGswseXTiXirQC2wIKgVe+SOy1s/dPWE
	 hgatZGmyZHycw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFD4F40633;
	Sun,  6 Sep 2026 09:32:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B9B4B72C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CB3F40632
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCfklHhUXGEh for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:32:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DFBBE40580
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788687137;
 b=nQE8S+q3nerWsrVrmCu7d/+oUKNpXVUM71j76ARZ20f34ZHiORBnCxdcGNTwqXJwoRul
 0lcAdMwnuuSvZTa1az/wgc1jxnklHa7l+55Y6WFWq+TTidrKQGbw+FvCWS0UW8p2UUc+q
 899icD471l1H0NV/8nOl5LOZdlNoeSa26A3pK1XfRRk3b7JWPG+4CfgO0IvrUDXQHkzVJ
 0XWF5IBsfrhkX2CPiAimiEY0npTkpqCmE2O+MCRwii1nnmcDe8ea2+igqkbQjfT/SIWy6
 poSWQnx7Bx+rqSErCeIR8yLAkhJkDb5+6p6ZeJuzDNRrbxeJTmRKEeqjRaEpn1NAvNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788687137;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=uBCiymqb3VuX0Ndc8ykOHMzyokTRoKVLMPKKZ13ir3Y=;
 b=oyUjvmnQR28kZugF1sPDhWCijjpnRhukvuh5whjmhWRPU2jaoUaPe5I16BuM5c/R2D8z
 ZQ5S86yCfgE2NhuaRJuw7Q/zbCclONfxVK61N1bk9TXAdC2al1r1OiybdbIfnx8XD5GQI
 ymGutbFZeD8oCPXRx7mjZztXLTvEubsvcsugPfrcO4FnfcJ2msu5/nkLdcIQqM2KHFMIX
 QmtfgKcU6NgndPWqKrZM7E8N27wcN4pBhOfWI/LHbhz/IhR3PKXnNaQS4HysAouzaI0pG
 2NKYS/so7lDbJpcL+MXswEgV9ksbqrjrkIJtzTYOYMX3FUWvfWVYC6QY5G+UoArYcFA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gtEJ7nOI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gtEJ7nOI
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DFBBE40580
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:16 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cc1b838f9b6so2816905a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788687136; x=1789291936;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uBCiymqb3VuX0Ndc8ykOHMzyokTRoKVLMPKKZ13ir3Y=;
 b=gtEJ7nOI/JHmKmXwCOjDz/nZXrkggn/t6Eb0vB2jhgbIprcLDn0vkFEXsKDWPKs1Z+
 lbkjt/mcyzSdUGHO3M46IIAtQzBiLZIRJGOFWsGSesD5ezQX8JA1qLNrCZpIwpbt3HZo
 JuWEDtH4txdRYqyC3hWxNwXvs9ezVZ8nM+tADPFfxL1rhdo1MT7FMeScwKhCPJDnILk8
 5SJFgQ7XTbuvmWA08cFKeGC1oCKAPfOAYZ/MnJlfkuNwR6RiQm4cVub6q71YBXR+sx7T
 6sL5U5A8LO12R0dlBHzdZjjuEHpbFVJT/RkusphRHKaXhM2MLZHYFQh4PM8E+SQlYS+V
 yenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788687136; x=1789291936;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uBCiymqb3VuX0Ndc8ykOHMzyokTRoKVLMPKKZ13ir3Y=;
 b=YVoFALUhS6mCXhYKJ7TghoII4QoYrzUhn7kvOlnRVnhekZqAXcLnS5B8XFte9GMU4m
 ZNTAttygWTbwmUEjX9G2z+YOISV2oLGezUGmXtk/qQDIGK2M01c5x/ISoBtJtMKtq7mY
 d23ETSH0EdHVISSE1h7j7tpVE452s78tjtbyE1H5qed7IENoXtKP8bcO0by2qpRrk7PM
 fFRE5lXF2kEpLi1jwHZlx0/j3B6yWWWDlSJeEnKdGCM1z0uP+fopSQMaDPjpR1mURZYW
 S7jqWxUmSWiwLA2WRp1t5dCqtLSKG8V/Z84WhTSJsXkLRnrahRkg50pBbX990mPF80Oh
 m83Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwu2UZaYFCzVyBMFR19LgZCglEvyMMzz3mbk1nyr9vkr9K8kJQK5o48l8aTNOlPgQcURG/zVUg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++loPR3O/w5n3nJzIN/MnQ+Rm0sTZ0wtZnRX+mbQ100AGeDZjRUP
 3+1fU2E+N2DB6jFy+EkMne4iYs+IjuaiYWfPPQXEzQup3v2PliJWAEgEZsAS+tiEvws=
X-Gm-Gg: AYBFou184jSxbMZH4zYUIy8cDaUxa5zUddxqZ0JS3xJVUmZKDa6izqI/9euieMW8i59
 GTxr0vtNsYjmzRfaflaLUUNcwPjRb07tX9z2Cl6+NMQk3Y/NML4mq6bhOfQqPTPBTvNMriPjDGY
 olPPDpOvupWEwQubX7p3FNSVg5p7ZZUwx0Hc9S/JX3J+YOeI7DVa4+myhs7rVGs3p9QTGdpFNnq
 k+DjJTUPJYRm4tAwPLW78IIIV1DwVMHQ94dheIC24HZ9sf/+gHwO3NlGJRHF2SV7aXkK/HDS1VQ
 8dWJzGO6Ov2DUR9PV15WQ+XpcPy5ZkpV351tl+dNxibm1PQickKB/DkGdVShWusHyTC4OONGhHh
 XsUK8JT36c6GqL/TZ9XxDNlW+lSWtn3A4jufdvRIk8uO1b9rT6WIdGDw99QJV+RzOzCsH9YGrMv
 P02ysHoRYJppbc7CSeeS4s47z5XhXcFMg3d0m2YgURS+lCbn5L5f2o1vbEpvNWK7/P57GKcoEQ4
 CDCYAaZf03bNWEHbPB3WBegMPJP4Jh5Ns+ieKk1XfXnWb/8eaoy+OJPWg1A+AOCvEiy7+KCoRxr
 xdO6pP/nxeZNLgmck9dwUVeUTQ==
X-Received: by 2002:a17:90b:4c8b:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-39b260f4180mr25739142a91.9.1788687135788; 
 Sun, 06 Sep 2026 02:32:15 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa33e96sm19210761eec.12.2026.09.06.02.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:32:15 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:32:00 +0800
Subject: [PATCH v2 2/2] pinctrl: k1: add IO power domain configuration support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-pinctrl-v2-2-729da680092c@riscstar.com>
References: <20260906-pinctrl-v2-0-729da680092c@riscstar.com>
In-Reply-To: <20260906-pinctrl-v2-0-729da680092c@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Huan Zhou <pericycle.cc@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>, 
 Yixun Lan <dlan@kernel.org>
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

Dual-voltage GPIO banks default to 3.3V, but when externally supplied
with 1.8V the internal logic must be explicitly reconfigured to match.

Add the ability to program IO power domain control registers through the
APBC block. These registers require unlocking the AIB Secure Access
Register (ASAR) before every read/write, since configuring a 1.8V domain
while 3.3V is externally supplied can cause back-powering and pin damage.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 95 +++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index d80878fc6e7e..7d801f08d209 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <regmap.h>
 
 /*
  * +---------+----------+-----------+--------+--------+----------+--------+
@@ -35,8 +36,23 @@
 #define PAD_PULLUP		BIT(14)
 #define PAD_PULL_EN		BIT(15)
 
-#define PIN_POWER_STATE_1V8		1800
-#define PIN_POWER_STATE_3V3		3300
+#define IO_PWR_DOMAIN_OFFSET	0x800
+
+#define IO_PWR_DOMAIN_GPIO2_Kx	0x0c
+#define IO_PWR_DOMAIN_GPIO3_K1	0x10
+#define IO_PWR_DOMAIN_MMC_Kx	0x1c
+#define IO_PWR_DOMAIN_QSPI_K1	0x20
+
+#define IO_PWR_DOMAIN_V18EN	BIT(2)
+
+#define APBC_ASFAR		0x50
+#define APBC_ASSAR		0x54
+
+#define APBC_ASFAR_AKEY		0xbaba
+#define APBC_ASSAR_AKEY		0xeb10
+
+#define PIN_POWER_STATE_1V8	1800
+#define PIN_POWER_STATE_3V3	3300
 
 enum spacemit_pin_io_type {
 	IO_TYPE_NONE = 0,
@@ -61,12 +77,14 @@ struct spacemit_pinctrl_data {
 	int (*get_pins)(struct udevice *dev);
 	int (*get_functions)(struct udevice *dev);
 	int (*get_io_type)(struct udevice *dev, unsigned int pin);
+	unsigned int (*pin_to_io_pd_offset)(unsigned int pin);
 };
 
 struct spacemit_pinctrl_priv {
 	void __iomem		*regs;
 	struct spacemit_pin_io	*io_pins;
 	int			nr_io_pins;
+	struct regmap		*regmap;
 };
 
 struct spacemit_pin_mux_config {
@@ -197,6 +215,28 @@ static int k1_get_io_type(struct udevice *dev, unsigned int selector)
 	return -EINVAL;
 }
 
+static unsigned int spacemit_k1_pin_to_io_pd_offset(unsigned int pin)
+{
+	unsigned int offset = 0;
+
+	switch (pin) {
+	case 47 ... 52:
+		offset = IO_PWR_DOMAIN_GPIO3_K1;
+		break;
+	case 75 ... 80:
+		offset = IO_PWR_DOMAIN_GPIO2_Kx;
+		break;
+	case 98 ... 103:
+		offset = IO_PWR_DOMAIN_QSPI_K1;
+		break;
+	case 104 ... 109:
+		offset = IO_PWR_DOMAIN_MMC_Kx;
+		break;
+	}
+
+	return offset;
+}
+
 /* use IO high level output current as the table */
 static struct spacemit_pin_drv_strength spacemit_ds_1v8_tbl[4] = {
 	{ 0, 11 },
@@ -405,6 +445,35 @@ static const struct pinconf_param spacemit_pinconf_params[] = {
 	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	U32_MAX },
 };
 
+static void spacemit_set_io_power_domain(struct udevice *dev,
+					 unsigned int pin,
+					 unsigned int io_type)
+{
+	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
+	struct spacemit_pinctrl_data *data;
+	unsigned int offset;
+	u32 val = 0;
+
+	if (!priv->regmap)
+		return;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->pin_to_io_pd_offset)
+		return;
+
+	offset = data->pin_to_io_pd_offset(pin);
+	if (!offset)
+		return;
+
+	if (io_type == IO_TYPE_1V8)
+		val = IO_PWR_DOMAIN_V18EN;
+
+	regmap_write(priv->regmap, APBC_ASFAR, APBC_ASFAR_AKEY);
+	regmap_write(priv->regmap, APBC_ASSAR, APBC_ASSAR_AKEY);
+
+	writel(val, priv->regs + IO_PWR_DOMAIN_OFFSET + offset);
+}
+
 static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 				unsigned int param, unsigned int argument)
 {
@@ -420,6 +489,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
 	if (!data || !data->pin_to_reg)
 		return -EINVAL;
+
 	addr = data->pin_to_reg(dev, pin_selector);
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -462,10 +532,14 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			}
 			break;
 		}
-		if (!found && argument != PIN_POWER_STATE_1V8) {
+		if (!found && argument != PIN_POWER_STATE_1V8 &&
+		    argument != PIN_POWER_STATE_3V3) {
 			dev_err(dev, "Invalid power source (%d)\n", argument);
 			return -EINVAL;
 		}
+		if (found)
+			spacemit_set_io_power_domain(dev, pin_selector,
+						     priv->io_pins[i].io_type);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -478,6 +552,7 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 	struct spacemit_pinctrl_data *data;
 	struct spacemit_pinctrl_priv *priv;
 	struct clk_bulk clks;
+	struct ofnode_phandle_args args;
 	size_t size;
 	int ret;
 
@@ -495,6 +570,19 @@ static int spacemit_pinctrl_probe(struct udevice *dev)
 		dev_err(dev, "Fail to allocate memory\n");
 		return -ENOMEM;
 	}
+	ret = dev_read_phandle_with_args(dev, "spacemit,apbc",
+					 NULL, 0, 0, &args);
+	if (ret) {
+		dev_warn(dev, "no APBC phandle found, disable IO power domain switching\n");
+		priv->regmap = NULL;
+	} else {
+		ret = regmap_init_mem(args.node, &priv->regmap);
+		if (ret) {
+			dev_warn(dev, "failed to get APBC regmap,"
+				 " disable IO power domain switching\n");
+			priv->regmap = NULL;
+		}
+	}
 
 	ret = clk_get_bulk(dev, &clks);
 	if (ret) {
@@ -522,6 +610,7 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_pins	= k1_get_pins,
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {

-- 
2.51.0

