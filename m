Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688D60A2614
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bggsNE1v;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Y/1ZLlj/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B25D660884;
	Wed, 21 Oct 2026 15:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwmIzk3q1xXl; Wed, 21 Oct 2026 15:43:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 58A7460848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792597394;
	b=YkaNg0qi9CiMhaowWkmpVIofv/avWPcVdFgSUkvoSsW1vt2Zbur0VN/AyCwM42wLfqH3
	 KxubSOyufr4Grgb6lg3jFKj9pPgbczcDU0dWproA92xefnMgzEKICvUnBTt1Xp/8hqCG+
	 WOH6tF2UdXr8KDe65kkVhe+edxpaXk+POSHarohwKs0F34S+ELHs+7XOze3AKGedodz9n
	 5OPSNY0VoHdI8uggHYciYLViiTsh75/8DbuaGqz8/XLqguMLW4KBYYUalzp+SwDqBYSoG
	 VQI60ZeQmkYaeF7+4SdE838KAuulcmyI1MuiwJ34drLRn5Hku272UTL+4XiFfdVqMRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792597394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=46ugy3YoFDpGBXMtszosU0/It5nNj1i2AsWzgabsvTE=;
	b=R8croQD0gPiHpm7FEsWqN4fSq5D1NlkBw4Ntv5GxZaC8gW1GqN9p/yEUsMuksI1MirWz
	 snlrI9Frx4hUhq99B2nYXg1+hSbs7s9LeAW6OJQs6KiDUecmMG05o7tKia4xTSR6fLseX
	 5eqzUI6K+4Pp0KjbhbHt01g2yOJaKlIHeTLcQzBTWLN4+bh13wY82/WDzSRaewlKAjzb6
	 A8AkmLaGXfstJmewLm9TY2SMxDRVamRx9yYz/KZ2cyz/mg491W6QZGvCyBfMQO8E0UiLj
	 xcTlDldcb7VPMAM+LgougXieruhoLkgCKbSQlw8jREFqY4xZi3vvtom+vSI3HiiwL+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792597394;
	bh=46ugy3YoFDpGBXMtszosU0/It5nNj1i2AsWzgabsvTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bggsNE1vsLSvnKyzegu6ZqoAWLSr7NOQ2QwZYRF/Q5XwAVyzBEsl0GrWkjYM/alrJ
	 kQhpQBDuxKQO/sPJbPQAaN2hmkkFOeDhpaTrprBXmKOWYZlsuKT/sCeIHK9GbnEN1n
	 eiAAdfLs/56QXoP57A7l+f1yYChWh8EiO4wRNml13SzHiVivbpjw1JvsFbJMjXbkPo
	 l2JPSYmrh+beGqzw7b+2ZqqPaVkpoPj3s5x1ViBs21JA4XO1xepCpIVj3xvVWo/dbb
	 yf1Xz7OIK4n0X9rHGXF77GIZmQ3VCSrzvwTPm8WqxDWMNpfdtrlc8hCzVTOsyK9RU7
	 Em6XtKwifgC0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58A7460848;
	Wed, 21 Oct 2026 15:43:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6398930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7E2B4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id keevfDpCcxsT for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:43:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1634540077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792597392;
 b=cvHHj1NTmW6v/GGEdu+VM1N8pjFWhkQsqxF3+9ZbVws4D0C1NRXG3jU1kx3N/HHxBxxg
 k0Ct0dkijycZJEPLJ4ymOQ0byOqVtun2jFxks31FKjp8WQAWIQHYH8eTYQkv6y6gDMUuG
 UDaPYdi5HXaY6zhdvoJJZl2kcbgB0Iwda2JRjCMKW1FjyxmuOeQGOPdgEZuD6HcczgFz6
 DLsNKBlkQr+NELafSD+SwlrJT5Dvipd8OH+Fyf5Ka8DJ8WA83mw0Ts/9DdHGgKHp8INu4
 Y/LtA9+4hOQUDOOS6Ti0PJd7toihQu0qgYOmuZ+0Czu9WnSUqxpKhb40I1mbfDKmQrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792597392;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=46ugy3YoFDpGBXMtszosU0/It5nNj1i2AsWzgabsvTE=;
 b=XzrqGpE3xEL6YnzThxCv3rdXmm11R87FHLTE6KTB6P9hQYyacWCgAuPhuZQqrWPp6BRM
 gOxAJUV1Y0CQStEgwHhoDAOpAt61jXxJmRhqB2OaYHl1rba0diUmwlCZupCv5HUTafT6O
 mIzzYS39ueuCBkGlWvIHwMdNsx4Sk/0DrAkwPFm12qdvtDownMlTkz6xmZohtKJ+z5j+S
 GuswEYBBon/NF9ebG4ccnJp5I8/ge4wqzHiPonQiNnKk7/jZMcyhP2lyzukwRP/wSUgC1
 XjkAcrUvxiHZiqlRVE9YjAB79Mp6VQzar3LwWp4G1XxaX4pUEjxIiWAvafobQk3RHPQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="Y/1ZLlj/"; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=Y/1ZLlj/
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1634540077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792597377;
 bh=46ugy3YoFDpGBXMtszosU0/It5nNj1i2AsWzgabsvTE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y/1ZLlj/1lXcDoevFHX3TH7/qO1KTAa8kIaYhrVEn9KdnH5/pt8sLeARq1FLLjtJu
 QSJk3gMeqixJGhkbJOAnkX5YBBdV+2WY0drfeEfW83VF9Ugv+7x9euKC+vdPDI1sni
 tksnoyU9IKyurM0jTBrNysgDCD9UA/ukK/XpEGOoos+/OLIxKkjEY7eYKxo3Et1x/+
 UMPezRE3RguVZYkXXmWp2nkaEcTJiKlbXcUPatYQrvGvCVJZNh32zMueXtNw1QRrDf
 T7M1nwrd6x7q7wDM4BN/hzNNcymq17yJjzc3H0N8xOe/yhZBlnnDGbmK5ts0tsK8Bk
 NnxZRO1uDoRsw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5EDDEB220328;
 Wed, 21 Oct 2026 17:42:56 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v2 1/1] configs: spacemit: k3: enable eeprom tlv command in
 main app
Date: Wed, 21 Oct 2026 08:42:15 -0700
Message-ID: <20261021154226.1391944-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021154226.1391944-1-e@freeshell.de>
References: <20261021154226.1391944-1-e@freeshell.de>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable "tlv" command. SPL is not yet upstream so this is only in the main
app.

Signed-off-by: E Shattow <e@freeshell.de>
Tested-by: E Shattow <e@freeshell.de>
Reviewed-by: Yixun Lan <dlan@kernel.org>
---
 configs/spacemit_k3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 586305c62322..66d1a36c79c3 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -22,6 +22,7 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_TLV_EEPROM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_DHCP=y
@@ -44,6 +45,7 @@ CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
-- 
2.53.0

