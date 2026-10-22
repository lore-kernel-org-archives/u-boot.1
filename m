Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC20606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k136t3WT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ErrFg2mW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E230D81283;
	Thu, 22 Oct 2026 19:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klyieTfp7FS8; Thu, 22 Oct 2026 19:02:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06193811E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695769;
	b=lTldeJb1k0SA6irlXKf3zsXxvIoSd+4xMoU/o8PFN95qtp9u/2WnNovu7ARAcDNEdPTi
	 O5C4pmmiNkGwj4jNAPTzxv8iPSHS1tAzVAXwLt47SUsjpdq/HsjzHBmMVQU61abVg1VU+
	 BLP6vs5gFVa/+Z/QoX64lp2T/kCbu7Da+itFppoqvRnRSM3Chlt5LTmOuRcqLd1yqJkGy
	 9x5soV6XoEfdvAc+//sn/XDxQqSIVuB/lHKOTl/EEjHokGczn+tTAmN/BwhhWev4Yj6Gr
	 j+plyMi5QqYEKWWQ1I2rnZFJnkG+zZhck56WGs2b60LYUnm6VO8YkE76phlRgUzLiFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mAG5oSbhxYcp8ZMJjjiG1Q8fyIUrOl0aixFty6RhmnY=;
	b=INCOlU8LCX7CB8iQuEBpyRsUwTIDdvNrxQdlUGVEMVWzBiH24AW2VhsZY3/jWmf0umnm
	 m70AcQuWL8bTs6PSm1wnwiNAGsdkvU8dTDqQ8z6JONM+QH1SdvSxLxY/pj+jvvnoLFPrV
	 AIQ3B931ROc4eVlQg+JH1wfSPIto3FNcvxMSOeLjcvMKwmNL2LRJxbYYI/Gg2AeOl9YZZ
	 4YxO/Bl6/UDxa3yxGjbf/ZDy9y1/iz3DSl7ip9j14BTkIXQLRgHq19FewQolDT3m5m/j+
	 J66Iixn5r9hCJWwW8vv3ewP9dMcCDTXzNHLywGMa3WY6HMfVDCM50/vLXWxpy3hshMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ErrFg2mW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695769;
	bh=mAG5oSbhxYcp8ZMJjjiG1Q8fyIUrOl0aixFty6RhmnY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k136t3WT5W5PeTYR7T9yINP9Dm+Qpv9hyr0s9d3uGvK8Ie+IeYLKO2qfc9FewN1Zo
	 0YKrS73hsBLn/tAFIYqt9HL0pD0IkTGlEUfOJQ8GaksA8ZGa2kRF81UlDx770NDOLN
	 NXprv8D/wH1RXM7r3r0MH6JiMIgjJnHswow6Rh0mGifGw93NyvYWiPgpbfttNodPRu
	 xoaC6t6eSBJ1s4NDv3klDXpXYnkgaw2m10X/eTRnoRkXv0z99g6dBWf0AkifBPBK4u
	 KiffRlpQ+I/c5iJJdd0qviDiEk80baaDFkCrT21JQVwieq6zyd4Selx8GRJzdMqGWJ
	 Xcfuzwt+o9o6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06193811E6;
	Thu, 22 Oct 2026 19:02:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B732C91C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A534E81250
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3X33CLYvKzYq for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB4D58127A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695761;
 b=ikTuOMmgCXuMaLnTYMvdmpphqffxVIDxOfqGYhPfkFXBLmJiqbqCneEaKvxzyB+EzJWf
 U4suKQ9ph9wsPGwORtfUWZ94ZXKNtG2l1/pXglnc9CQ8mzc9hC1azRhHcMNrQ27+IlUrx
 7hmDr4slogW+Wg1lc7zEo0zavMxDKqcIt46uxkrsQtqlmNHBhypyYt4cqq1PzEPveG3+c
 /eLQFHr3XtcSqavZgjKaix3jWS+zxAC4PjG7Z2fE9AgAjmfqJgCLdSLsS3grLesmxJbFV
 pgxnWZXlSE6wTbJ3KHzz9NWygAG6Zr9PWqfj9YnW3eLp2uYFvhDLOkpczxYwH9j7bvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=mAG5oSbhxYcp8ZMJjjiG1Q8fyIUrOl0aixFty6RhmnY=;
 b=pZjYO+hYyEzH0QNhuodgx504Hekk0xI0DNtvpi+rV7na/weO10aYYGgrUd0NanysCQ4y
 zx78SPxashCUtik387OLrKQbF5UCfirJoA9GFVEuYQmJRMFnm42Zz3NLnhsDb1A3bdDN8
 kbEcrJVUjvdIJ5wKTP9q+ZprQd0fs+uA5wzmlJk3kB87Wlpr162y1ytnf+pbZu8vNa6LQ
 YJmndtdZ/v6VOIM9iRYcEJnNvu71tgo3HkRzIRCHBzzdZCqHdl7cBEGTdepfPOHpSxRR/
 frCcEH624GI3QM/lPiW4WD/TZdTe2cbXj9IrUjCUItH87T/UPVz+q0cm9exVrJNGcSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ErrFg2mW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ErrFg2mW
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB4D58127A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:40 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so1126135e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695758; x=1793300558;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mAG5oSbhxYcp8ZMJjjiG1Q8fyIUrOl0aixFty6RhmnY=;
 b=ErrFg2mWEpBf2lv0zRKwnqWQhGUH6ocy8jyyLZl65+LdVjGzg2ES969NAqq+ogqQwX
 RjMhIKLEU+yFcv/x9+4WUphJJTbT8EhZtDNzmU0GL4ywJ0620m7C7T4rCyt9T7S+uiOd
 zcZUhVZCMAAONxMpoty05yilPEIl9VAbkRy2ekrM5KRfgkvyf6uyRsAjvJHhAJyc7b9+
 iPoNdkZQOM1p5SxKUTaOiR/6hVO8EAFP/CBJz1BXXH3PZx1tgfcrIng4Nab2ojIoSF4E
 PFqvrxwxNWWjm0F5lYFWTqOYqiwdEM6GDXvBadtyX+LRcQzCwHLO4zlcF+aT+zl86hU0
 zC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695758; x=1793300558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mAG5oSbhxYcp8ZMJjjiG1Q8fyIUrOl0aixFty6RhmnY=;
 b=wH0xOsgmjdQHfvn5VRcAb+/7XUpTa8hHE/VFtV6RIAyxDqn4baRMdrp3rHg87s6ov4
 BVuukdrfSLVc3mLyqqGro6Sy/7ZzkWpcn2SpS496SqzWtYMUChPGYXRkrdxxtGGM0X8L
 lkLr/8cBr/VgRCd5dPd6/YnZjNA9QneYGV5ehrwB4JYJsXF4hQiyA2Ao0+347XKVibQx
 Xelc5gi1GNCUXaYdK644BDilGOR1RSPW/qufJW4Fk4VnqaH8cObr2/9yEH2wHEtdQ1Mn
 Ui9KFz7FZyQz/TqdubO39DFx2W9g3oQW8m6rHrrtITW+i+wTbf/Gb+EnstCe34e9ELUa
 gIZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxogGdKYG4ILh/sD/FRpwY40TtvACr33mkN6EbwqpQzHiMJY6vAJ6vBSKFds/m7lMiPo7tx3To=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJTwYUjj/PuOI2kw95tcUlBx/zRonTJb6FKrku0crJx9furpOgm
 OVeKi3hUnXPqGXUGc9OAoExop4a+/SFRW8zqxHn+/bNFoIwPqI/Dk/jG
X-Gm-Gg: AYBFou2ciatBKrEFXId8cG7vw+/7cXtS4ZVdFj3ctdcN1ezUaV57fvNC2BryaBY87My
 ZoIwopMHWyZYR1Tg46Y1V1owr1F+Q0yzEdMSagg3GfKVawc7WTAQeRlJLPXNdRNkl4F8Ayk2Svs
 wJKn5FRN/siAADiKkkuwOz716IVs8RxbaujBhsNYQ9hcPiZr/FNz8fEnxoW3sdLy+UpZQxgAG+G
 IIaerDnyoTpj5RJmvcF+xGeahN82jPF6lvyOo7h6qHo2+VJLjy7RE8FW9i+o1AQi3FSLauLwG8c
 lrHh61ZRUYFlH1Zzbmfl+hIz9ASOVBI9rx4lmLmEykaqvqbIZtrqtaQ6iKX/x9TFjAttXaRNOQN
 LW8vgNwVL/TRsPHJr6bwBs/FIiv/YTkzxFCsGovKXcmtjevnTNlkqY1GlYUpKf9QZal365rWMcF
 A0Ll7nAw+JpC+agGBQnSdpy22inC/SrDDz24sVLpk9FcDzJiRUpLrF2sonSYN/DNKleYmxzgRqF
 mMSF9E2FRnWjQJhvpFx913oD1aM2tPOALzhHBy8/3W0E3CpyLrolJvg+u62Qt00J9ltyPasj4f4
 xX1la3jFa7A7Jbrepa14VRRch2fMAeALgMOCM+26TfR40X2lIEVYAYOMfNI3
X-Received: by 2002:a05:600c:1c0b:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a211cb1047mr44805e9.21.1792695758395; 
 Thu, 22 Oct 2026 12:02:38 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 07/16] net: airoha: add support for Airoha AN7583
Date: Thu, 22 Oct 2026 21:01:49 +0200
Message-ID: <20261022190206.666950-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for Ethernet controller present in Airoha AN7583. This
follow the same implementation of Airoha AN7581 with the only difference
of having a different reset number and a different logic to reach the
SCU node.

Generalize the driver for these 2 part to account for these minor
difference.

The switch init part also required some care as the Switch Internal PHY
enable BMCR_PDOWN by default and tweak to GEPHY_CONN_CFG is also needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/airoha_eth.c | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index ac72df5b6608..f530521692fc 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -24,6 +24,7 @@
 #include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mii.h>
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
@@ -34,6 +35,11 @@
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		4
 
+#define AIROHA_MAX_NUM_SWITCH_PORT	4
+#define AIROHA_MAX_PBUS_TRY		10
+#define AIROHA_PBUS_SLEEP		100
+#define AIROHA_PBUS_C22_MASK		0x800000
+
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_TX_RING		1
 #define AIROHA_NUM_RX_RING		1
@@ -86,6 +92,19 @@
 #define   SWITCH_PHY_PRE_EN		BIT(15)
 #define   SWITCH_PHY_END_ADDR		GENMASK(12, 8)
 #define   SWITCH_PHY_ST_ADDR		GENMASK(4, 0)
+#define SWITCH_GEPHY_CONN_CFG		0x7c14
+#define   SWITCH_DPHY_CKIN_SEL		BIT(31)
+#define   SWITCH_PHY_CORE_REG_CLK_SEL	BIT(30)
+#define   SWITCH_ETHER_AFE_PWD		GENMASK(28, 24)
+#define SWITCH_PBUS_PHY_IAC		0x7c20
+#define   SWITCH_PBUS_PHY_START		BIT(31)
+#define   SWITCH_PBUS_PHY_CMD		BIT(30)
+#define   SWITCH_PBUS_PHY_CMD_READ	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x0)
+#define   SWITCH_PBUS_PHY_CMD_WRITE	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x1)
+#define   SWITCH_PBUS_PHY_PORTADDR	GENMASK(28, 24)
+#define   SWITCH_PBUS_PHY_REGADDR	GENMASK(23, 0)
+#define SWITCH_PBUS_PHY_IAWD		0x7c24
+#define SWITCH_PBUS_PHY_IARD		0x7c28
 
 /* FE */
 #define PSE_BASE			0x0100
@@ -365,6 +384,12 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
+static const char * const an7583_xsi_rsts_names[] = {
+	"hsi0-mac",
+	"hsi1-mac",
+	"xfp-mac",
+};
+
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
@@ -405,8 +430,12 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+#define airoha_switch_rr(eth, offset)				\
+	airoha_rr((eth)->switch_regs, (offset))
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
+#define airoha_switch_rmw(eth, offset, mask, val)		\
+	airoha_rmw((eth)->switch_regs, (offset), (mask), (val))
 
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
@@ -438,6 +467,8 @@ static int airoha_get_fe_port(struct airoha_gdm_port *port)
 	case 0x7523:
 		/* FIXME: GDM1 is the only supported port */
 		return FE_PSE_PORT_GDM1;
+	case 0x7583:
+		return port->id == 3 ? FE_PSE_PORT_GDM3 : port->id;
 	case 0x7581:
 	default:
 		return port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
@@ -809,6 +840,59 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 			 FIELD_PREP(SWITCH_PHY_END_ADDR, 0xc) |
 			 FIELD_PREP(SWITCH_PHY_ST_ADDR, 0x8));
 
+	/* AN7583 require tweak to GEPHY_CONN_CFG and clear PHY BMCR_PDOWN */
+	if (!strcmp(data->switch_compatible, "airoha,an7583-switch")) {
+		int i;
+
+		airoha_switch_rmw(eth, SWITCH_GEPHY_CONN_CFG,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  SWITCH_ETHER_AFE_PWD,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  FIELD_PREP(SWITCH_ETHER_AFE_PWD, 0));
+
+		/* Disable BMCR_PDOWN for every PHY */
+		for (i = 0; i < AIROHA_MAX_NUM_SWITCH_PORT; i++) {
+			int try;
+			u32 val;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_READ |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+
+			val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IARD);
+			val &= ~BMCR_PDOWN;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAWD, val);
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_WRITE |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -1269,6 +1353,13 @@ static const struct airoha_eth_soc_data en7581_data = {
 	.switch_compatible = "airoha,en7581-switch",
 };
 
+static const struct airoha_eth_soc_data an7583_data = {
+	.version = 0x7583,
+	.xsi_rsts_names = an7583_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(an7583_xsi_rsts_names),
+	.switch_compatible = "airoha,an7583-switch",
+};
+
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7523-eth",
 	  .data = (ulong)&en7523_data,
@@ -1276,6 +1367,9 @@ static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth",
 	  .data = (ulong)&en7581_data,
 	},
+	{ .compatible = "airoha,an7583-eth",
+	  .data = (ulong)&an7583_data,
+	},
 	{ }
 };
 
-- 
2.55.0

