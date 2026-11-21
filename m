Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B5606A332
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RtsUsDWz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMoR3wEG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4590781679;
	Sat, 21 Nov 2026 03:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8QTz1iqZzxu; Sat, 21 Nov 2026 03:30:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8847B8167A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795231815;
	b=Ff9EWi5Qqfoqv6AnE8t4cBJOPUg5lUBzKATKu5wocSuRMQKLgzAPB4yomZOW3ijW/PuL
	 vxt2vttR2qDQNum21HG82lgYvHrIUtLuLfUUbUI8PlpCxl5xm3y7KFknFj3Wvca8aLGzq
	 X8ALvM54roqxUO68gAjTVX09nmIdQvvmoZmBk+5dXxFRjD5352J4zE/+OzVU5jQY7ZGSr
	 mCojkDXwMwHolozAvxTfMwaBrFW6vlIhBFbbEf69QskUO7bBTot72dR5d1A0Z7Ih7O2RG
	 pDneh3hwe1+P/9KdejHLlRry5ST9rh23eoA7mphx13hrF3iLAtaXb5urcp0BepeZ8rQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795231815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uu++gRxNSHJ6G59Tv+XWSGRuHL2AQAogQmPHHa79Vi0=;
	b=SzMj9//XqFp5C79UUWt9FW8bZTmymzTjaJva3CL5IfHefdbMqMqvxluyrRmkK7nuEvod
	 rHjcnj7DNBRG8iSIuGDiqEPUfz+ebGzK2bp5BCmTSfrtV7KhrfNI04OIT4fYVdg2aC+W9
	 l/vGYhmiEma2c/yHgzZbTalx5Xn1fM7F6gP+rR/ORUrnlC6WMh4ZMHs71mUAN7c5+so6L
	 6o979atX2QAAl3Wdq3G9aVMfiklh305B6q94Cdb0KmBteOKs74LYtShLBeQn9mF/YkWbv
	 aHpX8PDi3+FYIwNvvMXi8YUirH1MRrLAzh/iS61MvhNhOS5rKqQ4tvEiGhqZfoAfyoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMoR3wEG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795231815;
	bh=Uu++gRxNSHJ6G59Tv+XWSGRuHL2AQAogQmPHHa79Vi0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RtsUsDWzIDDWxRlEUwjyBV2Le+SpaYvZIScLnQLrfHHy2746pqw7000BSzjcmCsyP
	 OpWb2aj+3aOCYL3k7u//vOsSpWlb3w+xbGuCuu+6ER2Ge7u6SvXc4NjHilCRXxrRU2
	 ZWubWJAGKiSQkJFg/U+dxix3rI9wGEVODp8+kPTeiIMapaHneYlzhg/wCPhCUWnh/q
	 kAvm4w0WXUYCw01Y57hqbaoUgPFsA2C5Z1PZpY0HZij2ctv2/REyckX7tmTyisJEV7
	 e6JW22VYwRYhv+cEETgN+2Tx13ew1293o550yFOMQBC1ZEd+8sDyO9cDum2WCTb0iL
	 7cfpEOR4n1rGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8847B8167A;
	Sat, 21 Nov 2026 03:30:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DBBD971
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F9C48167A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDmq3boYPPOh for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 03:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA6EB81679
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KMoR3wEG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA6EB81679
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:30:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0056460E06;
 Sat, 21 Nov 2026 03:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAF61F000C0;
 Sat, 21 Nov 2026 03:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795231809;
 bh=Uu++gRxNSHJ6G59Tv+XWSGRuHL2AQAogQmPHHa79Vi0=;
 h=From:Date:Subject:To:Cc;
 b=KMoR3wEGqhmuMc94kQLCAoAJqr7y4lmv8HuJag5wolMHOkPBIQFWiic4sm9GAiW4E
 h/LmQXrm0y2xiD+16G+cfzG5+lhRFWIgh5VwxHZxAprwaal3RUMcX0EZ53AGC6XNgS
 uo8hdS2c9ybJ/53hUAK/rJ6VuMQZPdmanQNJXk8CrgWk0jUsQ0t4RpEZVuIyBCArlP
 myyjqEPFvG/FBBL+qx1cdv+/IrG/czWvzIY3hoAds7Y49XJB/rHB9RL+Fi9pUb8VNj
 zZTDhPi9zng5qf3LMGUACiBHEOMCuKrBZBvdS0FPGVk/hLgbG+MtQ4sy//sEBMneBr
 xYl/fmV+5SZlQ==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 21 Nov 2026 03:29:57 +0000
Subject: [PATCH] clk: spacemit: k3: use dummy clock to solve parent lookup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-05-spacemit-k3-clk-dummy-v1-1-966f095638a9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTsJrQWNVzEs6nTAEYukA0ZDu
 LsVlm/x/wLKSVjhUiyQ+C0qryHDHAqgux86RgnZYEtbG2MNlhXq6ImjTNgfkZ49hjnGL7pzXRE
 77wKfIOdj4lY+2/ra7Nb59mCa/j9Y1x/qDUlcfAAAAA==
X-Change-ID: 20261121-05-spacemit-k3-clk-dummy-4865ce4a4de7
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=dlan@kernel.org;
 h=from:subject:message-id; bh=e+g90tXM2kJZJBho+DsznLk2C8l2rRk+lZywwiaR/SA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrARA8uApIZoPkGau8v4Nwk5mb98VvgkdoBpbkb
 nfxoJWBmkeJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawEQPBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3lKhAAnjucUnbjAKCzu6Hsl0JCgslq9ztEDIUmfGHfvuXRU9fjCNgRUFrc8
 vE++1RxrKpGnRAMbf+N8qacuIupyI2J5Ugjot53dZ+8IGGgeBoQ9//IIknb5Qv26vsqVqDl1qoy
 2cnQWVzXeauHho71Gf281L8wRsCFql7ZSO5j0UJnIudQoYXA90LiUZtCeBBAW1/EPR/t2KN5tQo
 2gtqFzjFAeBF6JuSZ94MWqyfDrexWfF9fZrBSPPOrFzV6kBboUVkAgohAXt9Uxb8gL78g45QZix
 bVt1602r093F85qC20SpDySWofeBP6CAJhA+s5GinGq5O3i7Nh5dkdNtnzR5ht5Cmyig+Dvpr82
 10AuPBlGTuEkPQxkLw1OGrwc0vRQFS2zvYDDBY/D+ifEtXdA/cfyOuTlIx/KuGkbqcAc8/HOT/m
 vaguNF1WcdK26pTsjkddN+TVbo5pF9mQEO7l6105m8YlWdZkiefvy4uusHclxFbWTqodQ0XD00A
 /83zY6gjjJqwCN/ju0ZEiwbup6//5/E8vynkOjWCHhWd5OOcWhRIUh6jMoX1ChZQsaDkKc3wxEK
 GBG1L95jTUJb+8Tpgr41xQFjLfhgmqn3KDv4qUkOVV29iH8txZHEu7jz+wzuQDFPL7sMFbHMUe0
 sY1axaf577cCBN9NgUW6bYvDIWTBno=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clock named "external_clk" is defined outside the clock subset tree
which is not registered yet, fallback to use "clock-dummy" instead,
so the framework can resolve the parent clock lookup successfully.

As the result, it fixes following clock warning:
 clk_register: failed to get external_clk device (parent of espi_sclk)

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk-k3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/spacemit/clk-k3.c b/drivers/clk/spacemit/clk-k3.c
index f4f1bb7bf04..5136b4dad74 100644
--- a/drivers/clk/spacemit/clk-k3.c
+++ b/drivers/clk/spacemit/clk-k3.c
@@ -1122,13 +1122,13 @@ CCU_MUX_DIV_GATE_FC_DEFINE(CLK_APMU_UFS_ACLK, ufs_aclk, ufs_aclk, ufs_aclk_paren
 			   2, 3, BIT(1), 0);
 
 static const char * const edp0_pclk_parents[] = {
-	"lcd_pxclk", "external_clk",
+	"lcd_pxclk", "clock-dummy",
 };
 CCU_MUX_GATE_DEFINE(CLK_APMU_EDP0_PXCLK, edp0_pxclk, edp0_pxclk, edp0_pclk_parents, ARRAY_SIZE(edp0_pclk_parents),
 		    APMU_LCD_EDP_CTRL, 2, 1, BIT(1), 0);
 
 static const char * const edp1_pclk_parents[] = {
-	"dsi4ln2_lcd_pxclk", "external_clk",
+	"dsi4ln2_lcd_pxclk", "clock-dummy",
 };
 CCU_MUX_GATE_DEFINE(CLK_APMU_EDP1_PXCLK, edp1_pxclk, edp1_pxclk, edp1_pclk_parents, ARRAY_SIZE(edp1_pclk_parents),
 		    APMU_LCD_EDP_CTRL, 18, 1, BIT(17), 0);
@@ -1189,7 +1189,7 @@ CCU_MUX_DEFINE(CLK_APMU_ESPI_SCLK_SRC, espi_sclk_src, espi_sclk_src, espi_sclk_s
 		APMU_ESPI_CLK_RES_CTRL, 4, 3, 0);
 
 static const char * const espi_sclk_parents[] = {
-	"external_clk", "espi_sclk_src",
+	"clock-dummy", "espi_sclk_src",
 };
 CCU_MUX_GATE_DEFINE(CLK_APMU_ESPI_SCLK, espi_sclk, espi_sclk, espi_sclk_parents, ARRAY_SIZE(espi_sclk_parents),
 		    APMU_ESPI_CLK_RES_CTRL, 7, 1, BIT(3), 0);

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
change-id: 20261121-05-spacemit-k3-clk-dummy-4865ce4a4de7

Best regards,
--  
Yixun Lan <dlan@kernel.org>

