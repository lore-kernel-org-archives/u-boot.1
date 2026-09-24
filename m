Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4962BC98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 11:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5140A81C0A;
	Thu, 24 Sep 2026 11:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bc-vprv3NbfV; Thu, 24 Sep 2026 11:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4CD5781456
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790249183;
	b=Y84uCd9Va76/+3fR9KkwDTTtrnKVFwbbhxr8OPuRl+CsNjqlssIfQftq8zvmU5g2ZyFY
	 LTPlIUKHqUkemoiZFUxTY706NIt6IWwFJl/nQ5PVFRueMvkSPywusQZeLj42BB3PO9lQO
	 cyk4Ds7rrP7SvdeqWXuNZspXmN4ZIRdz+jxDSTLyfxDw2ru+qsSP5xQULJYnmt8pGuUbx
	 qaiN+6zhnqln5RvETgLOMLmSo5p7Lbp2RUDnMt0eFMPEm1fQcSNp32qDp6v/y0H5xz7VX
	 zxFgMbZmXvexZL9JSDsTirDKrBNiqBywObN/isszHQm/mjFTcgr9pAIxkjF5C5b3b5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790249183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=WJOqopJNbE/8UmbxRbnujrvfLmUuK+Cv1fOK1MwmeAc=;
	b=P21PmPS4PY+Ghi3HDpmRzvQPf16IKrMCGb8ZQykkXGmqhEzTY5qW1bAqho6/caoTVx/h
	 83CI1+C9wVQJUC7nWr20pUYEBiBJ1gijulBc9FK36msc4tfxJAVAcZxnVRqhyIx8ODvUG
	 6Skz+3OaFowPZHTXlIJDvC1wY7bM+NPd20RHEABCem+IT3gPCG8A1oBPZQhiO3AF3XoqG
	 u82zSigCQ0kAXcsd2OgKfvoITnHCyNBOU27vW3OM0sWViPNPAa8LOYwcT93jYKfWxTAq4
	 NqHfmsn6ZgFUvWm52rejKPzB3PJln7rbw18EWakaqIX3ghXVUSJUoC9VhEUhGxGhXAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790249183;
	bh=WJOqopJNbE/8UmbxRbnujrvfLmUuK+Cv1fOK1MwmeAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ulWdtWXC27lm4Xhyadx36+NhfDE49t4CBMuYrkJy6NJXWd8OwGsJBmgw4xP+UGJQV
	 hgwbvoF5IlcK1C4kBuOUIliKJ6VA/DG0z/b8EQfL9hlcIaMMo7bPD64wVzY5SP2tZi
	 pe4X5rr0YXd5sNGRgAdv9aAA6RGn4gxNbzM8idhrv61OMSkkAuflXieJ8uNtF+AOyE
	 OiRbbdQfEUqlx4MHziFWrrHg9jebiJcD7tPOHXjS/CeNH3uWqOuOi/qC299Y4rTi6e
	 XPIbiGbblQRS8+WTCIXHczqeFCTTh4kJzrsEeR+IkilrBq0CWiwSQRhLTdPPDZuYPS
	 GqmFYICM4JkTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CD5781456;
	Thu, 24 Sep 2026 11:26:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2278392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 981DC4043C
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:10:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MWX4qTjTT1U for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 09:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B1A124043A
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790241015;
 b=fPIpDO/5qDmvx+VKVdG3InDpz1F/QqR5X/onuU8r0s6R9VtZu9GBsGOeGHfCFa4xxHx1
 eZgaRevVVxulmIiRg98QGoaKpBKOpt7HAfcKMrS8h9iiludNv3LUnSAxeuYqXKmU4ZlbF
 FatwjsPymnuQFampJgmDtjOpcN6+iPmjqSXpnoH1xQpDHNDKFO/Ht/OHmvOFp/kkFvRWr
 MCuqDwjeIwQlBmBJv25XZdnMnxlkvxICm8rVuHbU+daQbKqEJ3kZEWME7argkhTb2bIwJ
 MIdrx9rVMnu/2WKloAYzQS/Wa1HkEdhHGrNQdU0V2VO/p7Z1oPz48SFHjKyh/C9r6Nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790241015;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=WJOqopJNbE/8UmbxRbnujrvfLmUuK+Cv1fOK1MwmeAc=;
 b=YgBRZWoTqB0JSnWFYG3p6UvMCjqfZpOCtG5K98BLPFh+BfxjlueXpbs0N7AezlDAPj1p
 x+LY5WnRltciWppu0Jd7YBbCp9Il40aY3LPJ0R11FpG9QeIgULF9Me26zjJBBYVGS5D/E
 1utucfR0Fr2SD9vKRav8VFAcPJCSAdiTk7Y6Vneg9yX3cUgFHzO9Cl6lPKEADK6SN9teU
 eRyTZEijOciSvR7rzz2BT0NUOgSg/NyKK1qEzz9ayK6p62lyYR10I7y7VvReMrRa5zi15
 toUvVJOWCkWCExy1GGwkgIBFg/e58XD46yeuKWOWH+eFQ8T8XAqr0blrUb/qa8c25tA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=n6XgJOHh; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+takahiro.kuwano.infineon.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=n6XgJOHh
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1A124043A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:10:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA9236020F;
 Thu, 24 Sep 2026 09:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71F1BC2BCFA;
 Thu, 24 Sep 2026 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790241012;
 bh=lLWVKt6a0Mnz/94cuOpVqC3zNflCJhrjLd1MVWv6C7Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=n6XgJOHh7hjkBNQVJt+lljs8pNyptKeitkgH8K/iP9ssyr7qnKrH4eAlCkIWz6Kw9
 aGKsGb2q+eFO2ELP8bxi5118WhRENr/A1QbLP3RKo1QToWCSRAoUgTv4r31yAtIYwH
 gssUdN0/wpQlA8QlhUd042l4zowEqiVNA5kFXkYzFtSuLi8vKPRkBljRcmtxvSbqdL
 Cg8EgFRZ8oacXwPHnRgz1JMRYtl0Scr4i5iOrUoniONr9vJJNklH9YuRROMHk3D3Xw
 6zMtKgm16Xo+eNAs+1hqxnpM/3u8BpFGH++cgJe/yF9d8LVhfncrGS7fA4z7VknEPW
 xeA7ZPqW75POA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5416AC9830E;
 Thu, 24 Sep 2026 09:10:12 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Date: Thu, 24 Sep 2026 18:10:06 +0900
Subject: [PATCH v2 2/4] mtd: spi-nor: import manufacturer driver concept
 from Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-split-sfdp-id-v2-2-aafc70e0b657@infineon.com>
References: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
In-Reply-To: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Ssunk <ssunkkan@gmail.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, Jeffrey Yu <jeyu@issi.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790241010; l=6563;
 i=takahiro.kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=aGIzttHX2odzMQ8KzcnJ3OUDEYwoKBXc0/ESgWJt06A=;
 b=XERD6VmYhA/q6Tf9oJ3NQsjwkZteNJA8pa9t+FTlTGC8i9o2iIhESLY3O/FJBFcraDd2Y4Mte
 Y3ijBF4JrfnDpHQjvdDLLaSVLd+ru8m/9vyY7DTUyO2PmcT6LjcIgDY
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for takahiro.kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailman-Approved-At: Thu, 24 Sep 2026 11:26:20 +0000
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
Reply-To: takahiro.kuwano@infineon.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Port spi_nor_manufacturer struct from Linux but ommit 'name' as we don't
print manufacturer name in u-boot, and add 'set_fixups' function pointer
to assign chip specific fixups in manufacturer drivers.Since the u-boot
has size constraint, we should keep having chip-specific fixups in
struct spi_nor instead of flash_info. The 'fixups' and 'set_fixups' are
excluded for tiny.

The manufacturers array and match_id helper are placed in spi-nor-ids.c
as those need to be referred from both core and tiny.

Signed-off-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
 drivers/mtd/spi/sf_internal.h  | 18 ++++++++++++++++++
 drivers/mtd/spi/sfdp.c         |  9 +++++++++
 drivers/mtd/spi/spi-nor-core.c | 13 +++++++++++++
 drivers/mtd/spi/spi-nor-ids.c  | 21 +++++++++++++++++++++
 drivers/mtd/spi/spi-nor-tiny.c |  4 ++++
 include/linux/mtd/spi-nor.h    |  2 ++
 6 files changed, 67 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 576617beb70..3b6b51cb11c 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -97,6 +97,22 @@ struct flash_info {
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
 };
 
+/**
+ * struct spi_nor_manufacturer - SPI NOR manufacturer object
+ * @parts: array of parts supported by this manufacturer
+ * @nparts: number of entries in the parts array
+ * @fixups: hooks called at various points in time during spi_nor_scan()
+ * @set_fixups: called to assign chip-specific fixups
+ */
+struct spi_nor_manufacturer {
+	const struct flash_info *parts;
+	unsigned int nparts;
+#if !CONFIG_IS_ENABLED(SPI_FLASH_TINY)
+	const struct spi_nor_fixups *fixups;
+	void (*set_fixups)(struct spi_nor *nor);
+#endif
+};
+
 extern const struct flash_info spi_nor_ids[];
 
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -143,4 +159,6 @@ int macronix_quad_enable(struct spi_nor *nor);
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
 int spansion_no_read_cr_quad_enable(struct spi_nor *nor);
 
+const struct flash_info *spi_nor_match_id(struct spi_nor *nor, const u8 *id);
+
 #endif /* _SF_INTERNAL_H_ */
diff --git a/drivers/mtd/spi/sfdp.c b/drivers/mtd/spi/sfdp.c
index fd545796d50..db9dda12e27 100644
--- a/drivers/mtd/spi/sfdp.c
+++ b/drivers/mtd/spi/sfdp.c
@@ -219,6 +219,15 @@ spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			 const struct sfdp_bfpt *bfpt,
 			 struct spi_nor_flash_parameter *params)
 {
+	int ret;
+
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->post_bfpt) {
+		ret = nor->manufacturer->fixups->post_bfpt(nor, bfpt_header,
+							   bfpt, params);
+		if (ret)
+			return ret;
+	}
+
 	if (nor->fixups && nor->fixups->post_bfpt)
 		return nor->fixups->post_bfpt(nor, bfpt_header, bfpt, params);
 
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index b99a1a45d8f..697e443bf5a 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1405,6 +1405,10 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}
 
+	info = spi_nor_match_id(nor, id);
+	if (info)
+		return info;
+
 	info = spi_nor_ids;
 	for (; info->name; info++) {
 		if (info->id_len) {
@@ -2190,6 +2194,9 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
 static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
 {
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->post_sfdp)
+		nor->manufacturer->fixups->post_sfdp(nor, params);
+
 	if (nor->fixups && nor->fixups->post_sfdp)
 		nor->fixups->post_sfdp(nor, params);
 }
@@ -2197,6 +2204,9 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 static void spi_nor_late_init_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
 {
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->late_init)
+		nor->manufacturer->fixups->late_init(nor, params);
+
 	if (nor->fixups && nor->fixups->late_init)
 		nor->fixups->late_init(nor, params);
 }
@@ -3640,6 +3650,9 @@ int spi_nor_remove(struct spi_nor *nor)
 
 void spi_nor_set_fixups(struct spi_nor *nor)
 {
+	if (nor->manufacturer->set_fixups)
+		nor->manufacturer->set_fixups(nor);
+
 #ifdef CONFIG_SPI_FLASH_SPANSION
 	if (JEDEC_MFR(nor->info) == SNOR_MFR_CYPRESS) {
 		switch (nor->info->id[1]) {
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 90aa1025176..e2a65b7fcf2 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -728,3 +728,24 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 	{ },
 };
+
+static const struct spi_nor_manufacturer *manufacturers[] = {
+};
+
+const struct flash_info *spi_nor_match_id(struct spi_nor *nor, const u8 *id)
+{
+	const struct flash_info *part;
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
+		for (j = 0; j < manufacturers[i]->nparts; j++) {
+			part = &manufacturers[i]->parts[j];
+			if (!memcmp(part->id, id, part->id_len)) {
+				nor->manufacturer = manufacturers[i];
+				return part;
+			}
+		}
+	}
+
+	return NULL;
+}
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index cf00473ee83..c7824285191 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -383,6 +383,10 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}
 
+	info = spi_nor_match_id(nor, id);
+	if (info)
+		return info;
+
 	info = spi_nor_ids;
 	for (; info->sector_size != 0; info++) {
 		if (info->id_len) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..08567a80472 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -508,6 +508,7 @@ struct spi_flash {
  * @lock:		the lock for the read/write/erase/lock/unlock operations
  * @dev:		point to a spi device, or a spi nor controller device.
  * @info:		spi-nor part JDEC MFR id and other info
+ * @manufacturer:	SPI NOR manufacturer
  * @manufacturer_sfdp:	manufacturer specific SFDP table
  * @page_size:		the page size of the SPI NOR
  * @addr_width:		number of address bytes
@@ -559,6 +560,7 @@ struct spi_nor {
 	struct udevice		*dev;
 	struct spi_slave	*spi;
 	const struct flash_info	*info;
+	const struct spi_nor_manufacturer *manufacturer;
 	u8			*manufacturer_sfdp;
 	u32			page_size;
 	u8			addr_width;

-- 
2.43.0


