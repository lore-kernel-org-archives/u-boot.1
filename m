Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7593C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 817F380DDF;
	Mon, 28 Sep 2026 10:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHaz8j52FCEK; Mon, 28 Sep 2026 10:16:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0B7C80DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590589;
	b=j143Py31MtDiX3LojtvjBWvBMZ70Z2NNHO/lnTHcr2fArSIWJiDbeZYPlAbVFpyS21gX
	 68BCSKDz68lUEBxH99p0FBKC9X8m7IVb4n00auTLPAt6gewd2LRwDJ0CINLBYQJvDud3x
	 aNEKTFc1rv5/6S24CQIiu7UUfL+4lI1Bx17lq7JFAxXg+4ap7+WQgADOZFlAsfu8uDAU3
	 jtbauM+jh0NqJ0+jPcV1wRSYnL2AIio5RX+kCExVIjh8uK+aMTb8m7pWVyiwuBsBA83zF
	 +oraNozOYrxJpU1GGqZ6UnKIBAUE9gGwbYbNM2mY4cxhBsb5yTLfnMqq8rqZbJAtFKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4iqOK0xwn7NSnNGr4Et+Z4hg0ocDWlq5M2Z3Cw4pl2k=;
	b=rppL3oYsVpkoY/DjHAFaIZfxn//QwlmmvY6BtpE0UMVUgHorrKT+It0z4cy9hVdQX4Qw
	 HlvyAPneAla/FzpqYzWuB8Gc4w6mM5d/+w6lPQN+cIOaGWw5YyrjiJPvgSAjh3c+aq5C8
	 rEX/8BuB2IlTFJ+nm1AbnXZA6dW3PnxSq+aa0S2bEnqQ2TaGm0zymEBuXYHgQAyG/cGOa
	 Ofx4RoNjM4KunvLiIQGqVgMJgkqQ/WJDwepqsqmbOP4Wo5xCW/GflNAdfq6Ijz8+HFW9Z
	 sbO//ekVXBj6VpH64kNHg9vvEdEJSOnVN9zb3yCiug0VJgGAXCG9RjFkhekFEJY7mSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590589;
	bh=4iqOK0xwn7NSnNGr4Et+Z4hg0ocDWlq5M2Z3Cw4pl2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CVLhzkSYLfy7JMjA3FaRgaqElB2rE3pjdsdbfxX9D5ZAGVrBJvhqCArHij3hKwyMT
	 RnH7t7ezkh6pHh6wz8CvEXvchTCgCfjXY5lkQXCIaVfOdw4UIR/NfzErIKpvWVTrWD
	 ACCzZXgG2hrwAXt7dyT60BIXaUJIXwrwF7UIkffKlhaRpp3lKGeOf7WsbavdDxvGks
	 IGT/CwnJAeA3jJmhantgKCAkipJmsvv0FteZ2td+TVZmd4J5AsUsEzsHG35VEaKl2Q
	 4qtuzKPxth1zRYpAjjXzFyKZhQ09zP4Xw5eUXjDLJ8RiP2h/3rd0Ct/6dnLy39aJ1a
	 a2oApDgBpDsYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0B7C80DC5;
	Mon, 28 Sep 2026 10:16:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80F102B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E50B401B1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3N4cc6rmpZ8 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C504B4019A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590588;
 b=WIdkEsu+JVve0AYDkx4KTduyN0hcsdjYerkTGxR8k/U3gfCuqhnhgRol1oA024LGPNEi
 gdgKxFevu2Rlel6J85y2NufGofFckGWqdTXrv8c/fBKzlTmEnhkxzxuB6GLsyKtlhzHrt
 lAifTyozDVZ1A5VpcbAVc6TJMDVzXyCeoWfdQPLyscGzYE3inOqKv7vL21zAC8Rq2bMFb
 jaOxoSsKdqpt8jcVO8jiayqFEKW6rI4aGb6i6Yjgd4+FtNeiuwffsoOGC6XZpvbpS1zBq
 C6mTwK6TueB+BZiLiaYKat3QNo7AbBA5Wd4fhxTF43v2f5T1EiwX7wcvm3OX3Y7qERQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590588;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4iqOK0xwn7NSnNGr4Et+Z4hg0ocDWlq5M2Z3Cw4pl2k=;
 b=qk7Kh8n9I25qn0X/nQG03nhh98MhR4j3/uyoQ3I2PJ79inMUjSn6R9Xez7jyUs6x7Oui
 m+o3hCMDdcINKgyKPavO4DVKexUi+JhlbC8OqoGlq/c2QEivJpWr0kGf/CCWem2aPOWze
 9ryxHYD1joDjVor6bJL3LALD2XPS30NLdrdqmaSh6ZfSv3KK2P8l53OuaY796mvFpTzke
 7xSnIRDO6bNCRYVy0MVZeEPqWtuNUEYUnnsVOjaRtwExnoWiNkNdxJDY5+tXWGAl0tKXR
 Q8tqQ3kRQtI23Sxuqr9HHtlKq027Nqwr6DibHGTMW2IBHZ2mxOJl+v7IKDsW52jEcBw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=NjHSNxFt; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=NjHSNxFt
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C504B4019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id ED222B0053D;
 Mon, 28 Sep 2026 12:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590585;
 bh=6bM7sXcp1vmuQgS56m4dGQ2MAe7T9l+njyZXkKe9WIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NjHSNxFtX+JeIjyV2GA2Hs3TXYg3BA+BP/KP87+2abqsEZzYrSpzxKdO4Gzp+0kcj
 sEX3Zxaleeixw/IW3QWpndGh+DDDi9CRM7+Jypj31AKJqo+RahenMXrM5ifkj0V/Qx
 YrMd/pTfEBBgtZi5TLk5sCUqw387SZ+hxkKj/ToaqRrVwxkMC4yL0IGoyMMRlwBdu2
 irL6MIaYevamC+zkhBRtDzugxWgLFs4EmtaVqmGt6YEXy8XYt+ykLOTOeM6DGDb8ZQ
 5xl3TdqFO8fE/ZEgAUGx7unk0XwspZ+laUQAcCCWkZUKIrOIWUupyxhxrXHCPqbVPp
 a9d6u8nmrJrWA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 07/10] board: lx2160a: serdes: add serdes1:40g4x10g
Date: Mon, 28 Sep 2026 12:13:26 +0200
Message-ID: <20260928101330.881662-8-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
References: <20260928101330.881662-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a SD1 mode that keeps dpmac.2 as 40GE on LNA-LND and that changes
the LNE-LNH 40GE port 4xXFI ports, dpmac.3-6.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- was on v3 3/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 63 ++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 104baa6b181..1c228dd5c06 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -560,6 +560,62 @@ static int sd1_enter_2x40g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 1x40GE + 4x10G: dpmac.2 stays 40GE on LNA-LND, LNE-LNH become
+ * 4xXFI ports, dpmac.3-6.
+ * An XFI lane is a 40GE lane that is its own port master:
+ * same PROTO_SEL and width, same PLLS and rate.
+ *
+ *   XFI   LNmGCR0 = 0x00000052   LNmTGCR0 = 0x10000000
+ *   40GE  LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000  (but its master)
+ *                        ^ PORT_LN0_B
+ */
+#define XFI_GCR0		0x00000052	/* as 40GE, but own port master */
+#define X10G_PCCE		0x01000000	/* E40Gb kept (lanes 0-3) */
+#define XFI_PCCC		0x88889999	/* XFI converters for lanes 4-7 */
+
+static bool sd1_is_40g4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E40GB_CFG(pcce) != 0 && PCCE_E40GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+static int sd1_reset_both(unsigned long base, int keep)
+{
+	sd1_reset_req(base, SD1_LNE_LNH, -1);
+	sd1_reset_req(base, SD1_LNA_LND, keep);
+	sd1_reset_req(base, BIT(keep), -1);
+
+	return sd1_reset_wait(base, SD1_LNA_LND | SD1_LNE_LNH);
+}
+
+static int sd1_enter_40g4x10g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, keep, ret, err;
+
+	keep = sd1_port_master(base, SD1_LNA_LND);
+	if (keep < 0)
+		return -EINVAL;
+
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES)
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
+
+	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
+	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
+
+	err = sd1_reset_both(base, keep);
+
+	return err ? err : ret;
+}
+
 static const struct sd1_mode sd1_modes[] = {
 	{
 		.name = "2x100g",
@@ -580,6 +636,13 @@ static const struct sd1_mode sd1_modes[] = {
 		.is_active = sd1_is_2x40g,
 		.enter = sd1_enter_2x40g,
 	},
+	{
+		.name = "40g4x10g",
+		.desc = "1x 40GE + 4x 10G",
+		.from = "2x40g",
+		.is_active = sd1_is_40g4x10g,
+		.enter = sd1_enter_40g4x10g,
+	},
 };
 
 static const struct sd1_mode *sd1_mode_findn(const char *name, size_t n)
-- 
2.43.0

