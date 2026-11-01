Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E431606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ewl+maDg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eQy21Ycn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FDB56065A;
	Sun,  1 Nov 2026 21:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAQPKD-IR4J1; Sun,  1 Nov 2026 21:05:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 722A560684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567158;
	b=HO0yOqawrqOOcBaEwCYJ3Eq3Msn4CAPDBL55joBkhKt81ZWUPesq6xVpGuTD1NnNh1so
	 ugAJYdDk8nouvuKi6QAVSE/6V+rBG9PaeojEQcuDJEuai1fGwJUN779RYHwdmHSS8edLr
	 3Nj+6h3S9tins3eI63jcmsaG2PA+TM0O4wT5pOJXw7IfvffBZqJYb1chxWJDCrwbN/gdj
	 iaN6ALObw+aF22DplUJj25DXBbrRpQIu1w1Z6rImyRKZ6XFEHwT6iXqLg3blSU3mDn1CI
	 O5DRk3gyG8PIS0kYNx7cXLrsFQxZ9ufUHaWZQd9aMeEndGk4rba6ZZQ6H/ns1AYmVnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Bc/F91lcZ+23kqnAwEnMQLKkO+3db1/+4JNV5KEL98s=;
	b=LeVgfI5RdR+Ns+YSBRkr0DzCbyI5Rh2Xy2U1g7wrHpqD861VWbM+oN2n+/v63LcxmcgW
	 n2fu7D0Uc1fs4zrdE3dzbqW/K0dAPt93VrcOM1MBgDmPawcQsEZ2DojHlFj8aLurvBw6Q
	 yr/pY5DyGfMsSHdi/TrcVga6UVTBGXoH+mUzoSPi3jXBXVg9dmx+OIGDqi6BXWeTbUmaw
	 PDbz7uA2jAsUSr5P0Oz9/pae1vaq4QycStuDFiSnitjI/eW3fTGSSPkFbf13BlRwhcUaI
	 0h+OQX4uvO5QYvqku+AC8Eo3hkOiTiVNd+zERUWGlaG9Neqh3Z6lEe6gnqb3tAzfJLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567158;
	bh=Bc/F91lcZ+23kqnAwEnMQLKkO+3db1/+4JNV5KEL98s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ewl+maDgRHUDXji5n3OXSB4dBlcjiATkH4F0SGqwIGeuvNggyVOgDkuuC7O9wpGcg
	 ctLHyk+q33F81dIfp8BTh27jn3x0WLovJvygH4YKUqGJ6GbpI0JzS5tVWKHgC3h8Qy
	 AMP+Z5PLCe7tj7fkYQ+al1nb3QtihTd+BSgxC8vAkMGlHNmoRbxzXnTU4lGQOAdp44
	 Al6S1ENzhEK15FNrxw/xXJRxsK3EuFjlv/7DGokeJtKN4sbMluCCXFrBf7tN0l7IQC
	 TXxjKeT13CzCqTp8Rz7wZMvLkcaAvdeQDuD0txAczeCx1fk0k805s18q1f5V3IRnfH
	 zymPO0Wir1dUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 722A560684;
	Sun,  1 Nov 2026 21:05:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ADDE34D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80C03405BA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TP338FcLqYMy for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 821D8405BD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567156;
 b=AVXAmDTIVwkM1wt4xqhFTUBbaingAevlwwO4sIpAz9S2UYWRgyKtZqOgSf0/qG8Wiwgx
 dWgnFFTr9KeBJ0pz/3EAhtqfW5BhQqNQlKWS9ZDAwa5hDohTdc/4qVPZrm83QYja5SE41
 GW801PM3vTUAihysV1+t9jo1PXgwDSeeGaUWnW84F60Kl0upOWMnrGdjDX9Ke44dRPETj
 J3JIynqZpLb9l+Nft1Yu5ZXZm4oTs6sbEVUhf0FM8r6azxoQO1P2qfNQ7Gmd/ZWLab8oS
 j5OJIQH9bn4zybnpU93h7NC7+O8qPsVKzqpTeAoGcavBxoae3Ps5QsdPyqNN2GWBqLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567156;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Bc/F91lcZ+23kqnAwEnMQLKkO+3db1/+4JNV5KEL98s=;
 b=IN3fZCtqPqaS7RGG4Ljav+IT2AKDwFrn9HaMj17EfASb9yj+4IXReOv37NVs3A8I8P2d
 HFlFK2EPPwdhAihMG8W9CluL23CT9lONh3o4oMz6zAiBOsyZDYm2U6i5oOw8Rlb3zyins
 qXUdTn3saMtEL4lP+X6nV9MHbRaI8Spm/KgqK6vkLHkTFYGOBqs2SfGKwYxvPT8uXK27M
 GjPBwo6iMfr+70NajJOzm6tlN99wkoVP5WnhImMCjIESr4b86Crcrp06IlQs8oWQf2apT
 0azMGnsK4dUzThYwZZe5M19s26Vs1in+2yIeUuwa8g476v5aL0yPZEwoAtl1zidV1RA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=eQy21Ycn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=eQy21Ycn
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 821D8405BD
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:56 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3ab3b29a210so26521821fa.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567154; x=1794171954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bc/F91lcZ+23kqnAwEnMQLKkO+3db1/+4JNV5KEL98s=;
 b=eQy21YcnLIoYFwRhR7G+VY37ztgvCg/ctwCDdqjv35zwfWGFxau8krYMCfwlcYfGTv
 TYWQVaVCo2ONF7WtzU7rFbSLzkmAsyTk5e9VnpUbBbrTmAf2/hcruIEdtZYfxanznbr4
 DvNsDjtCZ6QLfqOSUAU5n8o5NVJqidu+/h+RAi+9InWkqfjXxulYs4g+rDaSTM8WEpP8
 TGOh7msheK+dSWO5jFqN4by68BYDZWbJUUn5dXD560iypiA/XSompg0y4+tM8TwU6AS3
 pkfJxK6TArofW8biJKtKXR/8AzqShJXfWV7nov258ZbNff2zjv/dapsK/MfdJYb9/n/F
 5hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567154; x=1794171954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bc/F91lcZ+23kqnAwEnMQLKkO+3db1/+4JNV5KEL98s=;
 b=HmREi5heX0qZ1rwvt9W42nSF3c35SF4jSsfZ02ROLG8BvmYsWU2oj8YVFMVsu37/YA
 cIpbBHqmktZ39j3jGU2QqGUbnx3xIePmWkGMOacJ6ovB3be+l1GC+cKg8265ryOEtq3N
 c3uHIsXlRErPel78ywHA1qPXflXlqOmLrP41AR3ridWFec3/Ni+kc87aAoW0fWbJnSs+
 gVwXhCgSDXHyw1QoN9ctVoftogq78g5xrhwPWFglqDVbBYx2ZrTQLco7Ufj2OlmxW1Gh
 jL4xskv8ynupA/mvc+4BqHO36dG92+zBL/aP9Bg5IYgpqi97KUPYBcfrB4I9zKcylJr7
 2NJg==
X-Gm-Message-State: APuU4Z+qy8x0blDJkCn7qjPILqV6dwxUoPDWbCfgzafnMqnPtHr+DH/y
 7eRnN0/gKZ3Osy+PmoY/A8eQrwu4hPjPcNL9H5xYd4ATwF+WtErHYrUvkXUK0vgD
X-Gm-Gg: AYBFou1GHOU212sukPEiwIsOz6UbpmINQ4DVnswblErfX2X4JZr1Xt/KJpYqItL0nWt
 WoPeivenw+8yxRC/5AEkoEEpWKe5YzBalUmHUoPMzU/ty+OxNfh5uxP3Txdm40leqUuCA1q0g9O
 ui06I0/BIrrGi/6F7vjz9wxs6nNAJhZuSLSU5/KFijIXQSR5m87saRnuqdlzd3kz61E3vDUGFRP
 gQKZtgKQUkKiPf+vJmXXZdG6WxmpXHMpohLkqP5Ftgk/JI9BPJtY5eJqrnZMpMdx52EoHZCGQp+
 i7SaJqLYP4vQoScHdHWTL/SzDP7hIqZFlmLyaj7A5v0zkVARcW9CmBXKPSFaccWG7vxyWYXL2rW
 aq42sEQD5S8Lr186ifpUtOb2H7zxcIpdHg3gAxPeT+xdFcqKi6kHs+3Ob/zhaZrs+q2PejELoTR
 l25EDRtSYKgQsIIWbrcotS0NgEM+pts8HIYNIjNG6JVLojQWLyRSL5uypXOkFMMGjHYOTGNxADW
 de7kv3G4gzT/moKF6xdy1cWCDWUTzwPUk2/0iMKkQfXoPD1eW2z3wk+NynH2SpnAFjjuFl77xPb
 +G/q3LYxzH0umUzl20tJ5CbGvEgQIf941s+BRFxwEDq86dGdofQvXO7BfH0IrHfeQgY=
X-Received: by 2002:a05:651c:1544:b0:3a9:9b67:25fb with SMTP id
 38308e7fff4ca-3acb7a34d21mr16740801fa.5.1793567153783; 
 Sun, 01 Nov 2026 13:05:53 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:51 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 07/10] sunxi: dram: let the board set the MR1 mode register
Date: Sun,  1 Nov 2026 23:04:46 +0200
Message-ID: <20261101210449.1235102-8-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
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

The DRAM mode register 1 value belongs to the DRAM part, and the parts in
use differ: 0x02 for the DDR2 die co-packaged with the D1s and F133-A,
against the 0x42 that the boards with external DDR3 have booted with so
far.

Expose it next to the other vendor DRAM settings, keeping 0x42 as the
default so nothing changes for the existing users.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 drivers/ram/sunxi/Kconfig          | 6 ++++++
 drivers/ram/sunxi/dram_sun20i_d1.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ram/sunxi/Kconfig b/drivers/ram/sunxi/Kconfig
index 9f2dc4a6e66..9b0cbca8083 100644
--- a/drivers/ram/sunxi/Kconfig
+++ b/drivers/ram/sunxi/Kconfig
@@ -12,6 +12,12 @@ config DRAM_SUNXI_ODT_EN
 	help
 	  ODT EN value from vendor DRAM settings.
 
+config DRAM_SUNXI_MR1
+	hex "DRAM MR1 parameter"
+	default 0x42
+	help
+	  DRAM mode register 1 value from vendor DRAM settings.
+
 config DRAM_SUNXI_TPR0
 	hex "DRAM TPR0 parameter"
 	help
diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index 2d81e58071c..b8aef9707cc 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -1420,7 +1420,7 @@ static const dram_para_t para = {
 	.dram_zq	= CONFIG_DRAM_ZQ,
 	.dram_odt_en	= CONFIG_DRAM_SUNXI_ODT_EN,
 	.dram_mr0	= 0x1c70,
-	.dram_mr1	= 0x42,
+	.dram_mr1	= CONFIG_DRAM_SUNXI_MR1,
 	.dram_mr2	= 0x18,
 	.dram_mr3	= 0,
 	.dram_tpr0	= 0x004a2195,
-- 
2.43.0

