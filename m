Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCA8C79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7AAC60643;
	Sat, 12 Sep 2026 12:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huTmIGHFG0CP; Sat, 12 Sep 2026 12:37:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E703C60617
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216635;
	b=ZtrhgkVz/ZUgwJaCfw1Eeaq6V5preztWIVeK4dGUYCbz5Ws7XfzJa4YtaR4HDeZjw8Kr
	 pJoeXpekoy71vR7sW1i2q4gWHCg2VGc2cr5777DZWS0QTL2+v8qSIpUH2TCUYZikgeeGb
	 Qf9nyfNtnW7K0q4sn6LNyZq3LouJ+h1FY2KLKq+5P7npV6yONhJBZN9q5nqCJya21mjuQ
	 zBCGQPlLLQAJhSP+fjLOcpyiIniq+K/DYglUCEeJsOcnwH+ag5mZhQFamJGColZH0qY45
	 kw3srPilV/ASHFx7sHiQCoh7B5gtPNecikAKiVav96qwG9nxMurptQxNH9f+FaJN9MQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216635;
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
	b=DInEsrt9L7oU2HsXJB2e5JA7OYuEpGIZpCPF8wnsmlwk4X7Ll89cZ5Cof10nfuhxV6A1
	 ptO8ACkuMT/FN8qRrfJYyr+BrzWiTU2Q6nfd+UibHHzsMV5/P3TFEHAt6pLNmKyEZzUSS
	 CJZmJSHLE7lAsIIoH470EJKuPMTFrdoZOVQDHd7KoJ/JZL+6gaLsAo6Roydd9+lY7YHh4
	 cCpcH4qwFv47Sek6GWyBqCgt/X8wyhCk/wY/mIFaTpyStsSpqfe6tLfAHWqwCvLpv9/TX
	 w0Y1LGZCw0ZjQKrP9k8mMCLpFpz92qoEz+qHCfblAmEoE22UA3mpwFAJ8XthNMaRImA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216635;
	bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bk9gZV7AhRTg8+0134Ngjzd4v3vOyAKnNUQfz5UH65K5erWXbdhhxI2JW6omEBbCN
	 cnUaOdkjjGlVwO7CQ2Pi7WEcrc6WIO/LpPT5Fgbg+zWjtMQhVLQdlJ+lQG9nAuZu5+
	 M0k1zs/XuFy+uwWRG/YuOkKwP4AiiyaqpeTC3SeY3a7aLp6uhDNQB1/U7FSkjUh75M
	 XVt/F+rjr2MMa0pWkP5mEjMRlEq4jpmSnOtlrx4pbGmz9w2alEG6tIurv7z8RQRJCu
	 Le0c3lxcGhQklZ8DFYb2HOP8olE1GVYuGSbBJOeHoD7t8NYonH2j8btIcYQl2fKxlt
	 CP2v0DAiBEsbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E703C60617;
	Sat, 12 Sep 2026 12:37:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A5FA769
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E115C40719
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5tC0Vn_nGzTU for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E3A3C40718
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216633;
 b=q5/Mx2dLmBg6LeOzG4aesRB49jQPjQv8ICWIf8ZZZEKiAnFxrL1v/xj5l58u/m/s375g
 1T9XXUNSIdujBozybATjl44WGZJoHd9pYWewBqTVjlF19kUtGsvAsENv9w4b2tTgwExnM
 JopMWyeDQcQL9J3u2haclyCaZoGhFbv6ppQHOqYUixLQqAGoHw8tNK+n84S7Ndj67y41T
 CRKBnXE0Yjwnc+LLc0Reg79FqwEToEk7WAh2MkWOhrNQiFyacB8h00dn9SWL6CfZwLbvz
 yHmE8qgkNSmpN1XlmzCkrmG/Q+z1NUN6uOihcDzBb71eeneC4QkQ9tBAnEwNhxa3YhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216633;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=LttQxQBzK+FseSuu9MiQRdU+MEw1kO7u9C5bZxupw2Mqys2RRdT9khWToeVmmtQS8krR
 nwQ2fVyuZ+XhgK+R9nse/dS13gm8dmiu+YFgMxgdr9pEXGeEjNo4SwVMSjFv2J888RikS
 zejZ8/0dHFSp7kJuxTOoIiYNTIklC+8vpm5mQgP97d1fIGehbUlY4EpMyD58WEYylGMqa
 ssNwcdL95cgVInnDMnEfrRApxi2Uf24kzHFIVjPlt+O2Z+4Hok+C8560uekHflyeS7M+b
 HYjLeq9yIbAVK2Q/N2Hu5pwzMXOzrEv7YibLed5VKEZt574EAIKiFtwJaECCjIwseNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gksTsGBP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gksTsGBP
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3A3C40718
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:12 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso1864870a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216632; x=1789821432;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=gksTsGBP8Qc7AWv+0KA7WspYtOkTXvN9dOTc6O/5cC6C8aK8etgS0B5Jaq0E3JNpxC
 FBKbwAa7aNJk6nEWXjtW/ZBo7YU2jiz9tPb3hLK6x7sRTnisbL/ERH0rnsVzgGRV4suu
 3mteB28gFEKQyEesCHVwwCLTCOYoW4IgbibWFd3vnralTwkuRWHnR5iOkXL114KnWIci
 klakQoWTYlhtJXmxhKJ9cuRtaE8QRye+bZ0JOOWTg29poyA/TfbIYqFfpKv+FnzuN9ZY
 of8/8p8L2qqLLaQnWaXp/u+Zl4V3YX1aU/Pb61G2PmnPKPAHcxFBiJK6YysIeuOyCS6d
 kozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216632; x=1789821432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=KEK0Lyp7SjR7ayOfhzEZt7xjGIB8X1gc4tJvAgk444gFfMUBqCW1XnDg4872VxXaKu
 4DMZ+74QATo1EhLsQKTx2HEiVNZXSRWbVXeu5hhK5K699KOQ0FCXIUV+TRe8iGYbroZ/
 BN5ivM62IOubmDMCKk5g007Up7BNHV/r7xFR5FM5YIDcqMcSYVOJgemYzxCZWPWCF1aG
 0xhWU7y1I3Yh6fO/YBLYL2hNAeUEeryVYxVX0EQsW1LSVAAVAyDDw8gbR/KnGOGhPR/g
 P/m6/Zs05xenAz7I/1/x0Gi3wACCIOt9Rr1xXua4a3tJqWOkYretEiMy8GMACJPVNRt7
 wLSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSGUqBR3mUezNl27Eh7+ZoceOrtytY0RWdhn3tUmF8IuffPrajq++FfwXjGE9ee91ho2vpLdQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kKFSEfdw/J+JDVhP53VtM1UAtLx1oGdE3GD0Tedon3xAeZoCL2
 5tM54NZYIkKQr0AXJGb63q/rjq2mdum9lAHzLT7GCSE0iu1rHHdbxGXGjd+xF3LrJqk=
X-Gm-Gg: AYBFou1h6E/Ia6K9IK/wtbvPx9YB7XP5+GdgMWg7HpfTcQy9/hyHeH70EeGAp7QWKcB
 3VaO1swIC4rAdY91DxAEWzRrnVNMBOtwmljS4FeOO+qCyWoEb9OHtqvU07jxsStWGLTkyprRI+n
 Do64ef67UErCyXBvehDmqyaRTdQtPxQkE3rIn64HUIZyVh9zAjA76PyljmG0uGqn3k+DAdKymJf
 Fyft4TDg+7rR0t2KdJ+zsFVmmaDAtLHowMM9XbLjlhLBC8wVx0AIC32AAKJFlF6DRCYlzICtg6q
 30yGUW+BYaAUYiTG3fTHB3Om8jTZjhWaG0snTcefaQjLB/8ztaA9KttxUE6sQYfVfGEAAeHGu3V
 JadXpjGj+2cIJYGMdYkdAWtWIgdXRtslo7ngHm4jlhjWi3fa8IUA6jRX3Hzbvwc+ICflxcmBW7c
 8024JlT88vVBUgwis9zsb26AAkDRdrA2PcaTsHDK61d5G/UgYfLdRHKUhpJJf7rN0JlkUVW2cZv
 p0ffpr2Rf/JvW5AcJ/dE0KE2OWh9muEmYRzVelu3gHwmcutvtB47y+Dnryc0Bea900HJjyp8gdx
 xvxyleZSpmqD2LCLX+59DAzHAXWvxqkwxmXh
X-Received: by 2002:a17:90b:5291:b0:396:7c01:553f with SMTP id
 98e67ed59e1d1-39d77b1d014mr16144992a91.21.1789216631717; 
 Sat, 12 Sep 2026 05:37:11 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:10 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 12 Sep 2026 20:36:54 +0800
Subject: [PATCH v13 1/7] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m4-v13-1-71043b29630f@riscstar.com>
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

