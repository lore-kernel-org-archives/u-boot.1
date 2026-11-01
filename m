Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F085606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WYDrzYDt;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qbd2mCru
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C1BD405F6;
	Sun,  1 Nov 2026 21:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8fuXbyAsa0Cy; Sun,  1 Nov 2026 21:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE51C405D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567148;
	b=WoFLZwEhcQb/4Klxd+weL48Erv7T9dWzameZbtwLZKbNvjuBZgU++x5OUHhPBjOvqdhh
	 cCwZbLGf3szyrJFeIcgYax+K5B/1pP5ZLYuj8KbNHKApkB/lchXOOPXAZGTjs5v0fwd/D
	 +YFuX7aQkw4ma5Kv1Ya6cTqiA7benMjXf5xJKZMKepzyE4rSR/wippkgSHKoh+AtumAey
	 y/FRYIHKbHmckENHE4yS+zqJIqBC2gP+zqNe8+ZhoqyUtIKQ5MNkY/EdQRy8YhnYsjfC0
	 jKMdW8BBuYoculkLLMFR5WBswARMORkzwBTPwMIR479Fk/ohkWONava4C9NrTSaDR0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UW58K88SV/CJSJFEXTfFhcFaYbIqCU38M67x/8wKoes=;
	b=BOTzsvljvOjfp44UcShxb67Fz6sTxsGSRn+sAh4q+yib6fX/XvHQkRplm0xA9q30UYqo
	 1wsGlGL802jK4yZvARJuAM5o48WeYbr8auvuwKeyssw4PsNDgEzQK1ZIk76527KDg8Hh3
	 0nFYywDA6l1I5YVYhxrkN2WI5DRQuHTDuWPs9wa6tvmueuNXKk3DuQLIg56LidlSiY9Tt
	 zBO/fcvtvxiDjuBRj9fN6htfeY49FfM+fUU+8QPSMcDQ6NoTVhWX1I8djArvJgSLfir2W
	 sMwC1h59MPUf/qYD16w4yRX5hxbh71Ib1ljEGEaf+nupqkrx1PxOzAOjYI0JJsTmmOA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qbd2mCru;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567148;
	bh=UW58K88SV/CJSJFEXTfFhcFaYbIqCU38M67x/8wKoes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WYDrzYDtRRwJIYS6TfUfqlbphoKBr2ssbjPLdlOxwUj9hOMDz6YG1ij4pvB00mCII
	 1sDoL+rWmGyRra6JajIBJdqWU8uYythBMzBHFviiFUZj8alpbvY4eJfGVksIbOgCbJ
	 9++G5dR4Q7qim5vHNzvWLsLAGDAB86vDS8FGoKh7dLjNxawmWHxH/t7hrz/Q7JIUU8
	 TY5e8AZSYUVdcvgztqHk7/A8tR5Eq4Exrn4QSZLzNxvaAiaJL67hRYUpCRkQf5zbi3
	 RsBHGg6CzST4Hp+Q5a0/2750QB21hcRoYXcozFso9LYybtrRasYFemiVzA+FkLiwIK
	 5qHB1eFD1Q/Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE51C405D2;
	Sun,  1 Nov 2026 21:05:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A52034D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B8C04060E
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qaONBDxAZjY for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79E82405D2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567147;
 b=YKdHfIPdGeJ1GEux/85x9awrIUjckmNx6lFQ0AetuxcjRCj8y+IAxucAPJnzUpcYBaM/
 7MQIMz4mX6DnRLao9oLQ+YQE0rTDdOqAXI8T/nxQ2hlP8FoImb3A8uyWo/gppiBwMJ4bG
 Ms4+Ul17ec2zFbabU+UO5Se7cQCw295BUVV2cts1utFGoJMxXzlLzgRudglnFn9DTva1E
 D8/ScuQyQk0ySdkTBSl/lNdQHyLb056Q0iezCF4tigb48+e4SeP+qAxCfn+xLq8trKPeg
 nP5n1DtsrTiYd2o4yAAUxbGImFap0mXGYWY0Km9CTudHmO0fWZf9bmFSIpzggVGhg/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567147;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=UW58K88SV/CJSJFEXTfFhcFaYbIqCU38M67x/8wKoes=;
 b=m81fXhndpCpqkroDFoekqDRV0yCPDQbg/w90P1TcdVsBPpIiZh86GxeQIqeLSXEO2W5M
 vpCOYAq+sbqF0gB440HvmwVmGFeJIdC/bwRiH+2l30hI4rNS0ecczfiE9wAAiZysitnhg
 Rr/1f8WxkneOpEt2H0nMCi32ntWJLhL4GL720f8v7pLZ1whEvvRAgUdTIno4lesqf+ibJ
 gSpiGhx3r904BL7SyaqDrT51KIbDNrsg2tLfMpmnB1rkyxICjuAhAmG4A4yaMFACYQxyU
 0X8yGHwOJdB51n8npvKF/zdrzaniJmdWnxWZYZCSm/JbqYowzkwEssNMVqgVbGRsm0A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Qbd2mCru; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Qbd2mCru
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79E82405D2
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:46 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3ab3dd966e1so21434591fa.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567144; x=1794171944;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UW58K88SV/CJSJFEXTfFhcFaYbIqCU38M67x/8wKoes=;
 b=Qbd2mCruOU82R+qH6X9BC3URv4Eg5Z5+IMcDn6Dn3xVil7dq/m7euuVqeLwO5+YB66
 +jsBKotcX+cwPVlXvpp82xUXEtZexR543U4UKkOWIvcVvXZ3Hj22slHsP9hg87Vv0JxS
 Q+OQGto1ZJ8SFBsooDZlPE1LkYNHWh6gDLBvvmpsp1iZFkubm9RYXw9LOqa20/Izedrc
 hP1k8itotYiy+zECysHB4GPghw1f/z+OAk3wYjYQRmgQMtnVqq9zg+2Y/VEbwsYRbuu+
 RaGrQ0X2geEWk3IqVqzwjjs7PNKJX97YYUmaeKMqdp9EUfXQuoHIEbt2El6KgcoXs5UP
 Njow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567144; x=1794171944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UW58K88SV/CJSJFEXTfFhcFaYbIqCU38M67x/8wKoes=;
 b=Fny0Tn7VZYQNiA9gOF6GOUgLbJ7qbJek2XbtrpneHIICMaGIlvCfeynybiDylx4ycV
 nObJM+mbLHFQ0mAg7FLnzzZ1Cpz9RTP5Y2BVey1qopqRKfTs4izej+9o/R5BupAZWsaI
 sEpufqSKuWSCIqA56XG01NWntiyW3VzXgVWY12DSBwchgCO+Uw4/aab6jWyVzX0df5w5
 v7Gk3zwcsImt8gqpO/KbJTXyPPsJ2LRFHTbbba8PoOjliXylMpsqsFcnOfVyJUe4Nz52
 UFg/dxM3iWiERos9aofBGlRcc5mAbbI2wfUQ7DLJcZ+nrkg+je3vh4iwxY1eqtrlBmui
 iMyA==
X-Gm-Message-State: APuU4Z+wymc1tWvVtZvS2EbFb8FfawG1IKC2esquRGOa1dwQFpm/I2uw
 vW3eyd+ZdPy17jBJvc4dEncjpNdtJg3pMsxiI6BAaZ/zDXGh2SV8FGVHioIWbU3Q
X-Gm-Gg: AYBFou2VdURAOaWMz06xxBRc1oah8Sl68ryGqU+fNGorPgo2LmEUEKvXGhk6ioFdaeu
 O8pgTF484erIowlp1djEEXSWJapMScxaaPWh63wThDMJVdqno3UQglUwFJtKfg9BaeF2KdVU84N
 7WNKEgoJ3xV+GFqvaBHSniHrhtbq7MoqTmmt51QHucfzCTLyzfZLHyvFLBm7mXJ4pv0JSHSacn7
 IqcuxzYU9YHrtGA9XKXzlui3hHESm5Gi9krsj4JRkdsVUUYLBLB36iy6BWOYmj0+SrOPip2vqjI
 QE/gr/9/Ar8qCMT1h9pr1JSZneNUUh4RSvtrf6pI5KVIYoauIGoWKVx4EjBagAv+fUOpgjid4uR
 8bOqhqQHKSKnbZ4MZq/9Prvs0MCu1XzYSaA7IKlJt6rABRQ+dXj5GkgnXiTsEfxI98eyf+ojUME
 mdmLR7MtWUtyihzidH8FRKK43EYGvAl/2bYB/HGGZfrwfmnn0D1uteJsWk08rG8aNTgCSVS9o3j
 Bg7lBHmnKtHMSd3BkZnQwnlfuHvMzlEHye3rF4Jqc3sDRKE7DA5UAbbmmuUelN2/uwfPB6rg7cc
 LSxOL664bodTC+LV1Qrwc3zl8nf2Ji86u9BD53YAz7O24YC0QD3NlJzY6hYIPJFhC5c=
X-Received: by 2002:a05:651c:41c7:b0:3ab:17c9:3d26 with SMTP id
 38308e7fff4ca-3acb7aa471amr18478111fa.7.1793567143573; 
 Sun, 01 Nov 2026 13:05:43 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:41 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 05/10] sunxi: dram: count the banks on address bit 11, not A22
Date: Sun,  1 Nov 2026 23:04:44 +0200
Message-ID: <20261101210449.1235102-6-indrek.kruusa@gmail.com>
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

The bank test looks for the BA2 alias at address bit 22, but in the mode
the probe programs BA2 is bit 11. A four bank part therefore always
reports eight banks, turning 64MB into 128MB.

On a MangoPi MQ with F133-A the probe now reports 4 banks, 13 rows and 2KB
pages - the vendor's dram_para1 = 0xd2. Boot tested on a Lichee RV Dock
too, where a D1 with external 512MB DDR3 is detected correctly.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 drivers/ram/sunxi/dram_sun20i_d1.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index 68697fb2fa9..f098329e891 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -1085,7 +1085,7 @@ static uint32_t get_payload(bool odd, unsigned long int ptr)
 
 static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 {
-	unsigned int rval, i, j, rank, maxrank, offs;
+	unsigned int rval, i, j, banks, rank, maxrank, offs;
 	unsigned int shft;
 	unsigned long ptr, chk;
 	u8 __iomem *mc_work_mode;
@@ -1139,25 +1139,32 @@ static int auto_scan_dram_size(const dram_para_t *para, dram_config_t *config)
 		clrsetbits_le32(mc_work_mode, 0xffc, 0x6a4);
 		udelay(1);
 
-		// Test if bit A23 is BA2 or mirror XXX A22?
-		chk = CFG_SYS_SDRAM_BASE + (1U << 22);
+		/*
+		 * Probe for a third bank address line. The bank mode above
+		 * leaves a nine bit column field, so the bank lines sit at
+		 * A9-A11 and BA2 is address bit 11: a part with only four
+		 * banks does not decode it, and mirrors the pattern written
+		 * at the start of the rank. Testing a row line instead (as
+		 * this used to, at A22) always misses the mirror on a four
+		 * bank part and reports eight banks.
+		 */
+		chk = CFG_SYS_SDRAM_BASE + (1U << 11);
 		ptr = CFG_SYS_SDRAM_BASE;
-		for (i = 0, j = 0; i < 64; i++) {
-			if (readl((void __iomem *)chk) != get_payload(i & 1, ptr)) {
-				j = 1;
+		for (j = 0; j < 64; j++) {
+			if (readl((void __iomem *)chk) != get_payload(j & 0x1, ptr))
 				break;
-			}
 			ptr += 4;
 			chk += 4;
 		}
+		banks = (j == 64) ? 0 : 1;
 
-		debug("rank %d bank = %d\n", rank, (j + 1) << 2); /* 4 or 8 */
+		debug("rank %d bank = %d\n", rank, (banks + 1) << 2); /* 4 or 8 */
 
 		/* Store banks in para 1 */
 		shft = 12 + offs;
 		rval = config->dram_para1;
 		rval &= ~(0xf << shft);
-		rval |= j << shft;
+		rval |= banks << shft;
 		config->dram_para1 = rval;
 
 		if (rank == 1)		/* Set page mode for rank0 */
-- 
2.43.0

