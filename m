Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4A606A322
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BMKYUMaw;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=R9HokYHh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03428608DA;
	Wed, 21 Oct 2026 16:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvUc685h7_Bx; Wed, 21 Oct 2026 16:50:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A56D6608DC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792601451;
	b=DWR71P7QDQjuAeZ8uGPbmi6Mh4AF86i/e+z1AjLIXAbp6M5C7WWw0UU0w+bcQyzbRGW9
	 O5a75MJA2ngofflj1SZD4P4wUSOswM8VJTQYe1wpwUOyA3Ujj/4QgSO0L02c2M8tIKDLv
	 QWAJquKLosFkj9qEYUqzRZ2VN2kaNBGG1Kvc7Pm02ZawpRxDwrOtqxbsr3dFKWFUPO6Ed
	 s7PGn+EcHhEAHWAWoazCJCrLhsMj6sIJuPS7M5R0Mrcw88fsfueCTt3+V+v0X8srOFLEb
	 a/FYnYlB07dqBcckx7cGgzBK0jOWLS//8JnVX3+WN12sSdio+sgBj54ZmghnNO4YBoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792601451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U5/B2DvpdxghDptQPsaC38CboKQuyfrSSiodjYpr3Tg=;
	b=N8z/YYWw2ohHARScgFP821stYrl0ZEIyRo2asRBGthx4Lk4fFdn5H0K/gsb67ZYPQG/Y
	 FiMuuJiiT5cWX8jeCmHvmlKToN3hbJl5rRj2ezw6p+cBOmeDy9kWsKoV/HRbMZgki/1jJ
	 xW7uGAF6bpraJ7yhJo2AeyyEe8yLf4n7L6yn/n/W4K+Ztw7Y5Cotg3GS+2WUsRSgqnzGi
	 8a+5dXxlAoTHfbiX+NYNY0i9i3JY73/Hj5e6dzzBcr+QWsHe4H4DsvX6spo297K5lmIZa
	 h5beQkw5xEuc6xhm2UJA2j3enhLB2pBpp6ppFRWlYxrDY0teh0A3rRRoA5G6wWjTSJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792601451;
	bh=U5/B2DvpdxghDptQPsaC38CboKQuyfrSSiodjYpr3Tg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BMKYUMawu2toYnWOvesbI2wFSwqvSEMtLtGROD8lREYtyiktK2PB+IhbflOxzpmrQ
	 PQl77mCE0/bLpyOLmVYsIlF8c4vXWa+wFQMiI/Fwk6HsFTPidSSXiN2IVWk2CiM8wV
	 fVyguQbaIEcTQLeFAqgyx4WcA25Qhx4Vz+cXEcCnbEW5xKTZDOFsgm1EDALm/XO7iX
	 6M0xmZ281fqKAeksF/L4PcK0dquEJFDjLP9vYtzSbdedoc4Mji3GxUlG9PLr8W1y3E
	 OqY7uGu8UvQ6fhU4c4ufAmjxvZ58XtMu0fy9CUg3rA3+Ot6NHRrhcesRIn8RsTR2jc
	 if1ngxTxg27NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A56D6608DC;
	Wed, 21 Oct 2026 16:50:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE9AB1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FFA1811C9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:50:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lolk-fbFqR7v for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:50:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73EFA80F92
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792601448;
 b=K69e2xeJGqgIKd5FMlvvBUfC7Z7Y9AHmivFKcbvmhvv2f5JOd2wQVqPkrhk98VsrWidm
 OLRmDkg1Piz8/uLGimnsz0AladDlpLA810KZfui+j4Zghdh7f0u7jC2+vhE/QA/xCALeO
 fK2dOf+C2206yeojzcz2gb56b1Rz7PhmRT9OO9lfaAkwbC8fte6MQYRUzIyw/4HMpj7c9
 mws8SsAYN1zHm995xCXh9Oerkp0FryB6uIMhJG1qeMi7GexMVhRH5eqvxRyyD7zgPwPGg
 eWYhfGCK/fX1XXjrIGEnLpm6m0plG8xfm1kbM8zU2at/q3US/pL0cf3sAjFXFf5iX4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792601448;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=U5/B2DvpdxghDptQPsaC38CboKQuyfrSSiodjYpr3Tg=;
 b=kcC0/XoEt2EbavxVwuuDtq/0/IMiKNUu++lHnI2aYH0GRUlzeR6xvqKeApA429/8X+7j
 PYISbxqlyVzLwu9TaPCR1DRjEhsbDbdVhKasSFYL1dhmrg/FarICDsmM9EvogoHFufcfz
 Ysq8GvMAwm/I+d6X9ENz2FZR1VI8kyCVJyoB7DNk0PCVxNEkJtwdLgbjd6n+j1zzzKcyK
 cng31+qA01eKbCN/dhTa0duWzZHAKelUJuk3oENykGpFseQnSGJF+snClg1/YtMy03eVc
 rn8twcTmRtYsPstIRCizo7YmuC1/36HInXrt7ESGv3UPVBl1qwJ4RDk4BTrTkQVisgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=R9HokYHh; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=R9HokYHh
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73EFA80F92
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792601437;
 bh=U5/B2DvpdxghDptQPsaC38CboKQuyfrSSiodjYpr3Tg=;
 h=From:To:Cc:Subject:Date:From;
 b=R9HokYHh4jIjCIpssuNyPHRrLn+V0vT/dOm9tsDDUl+7tYC/4Y0rKx+vcaU/gnWSA
 B3MtEK+USXrbjg4tqM8pKsUQiph6+Np6A+1gvGwUrpAVhYW49k1z0VJicCQbIbhDCq
 pHGqIKKTLTe7EzECirDPJ4jUJkBM9AWR1uKRloOggJWOYz14NGsoQk4fT3S0eUExpk
 rLxfASEbCJlX2YXBdvR7PdQyPv/w6OQQIBKbHf4G8dtC2xgy9LaIy9ZhVIX/buzVtD
 GO5xC38LUWFq7ysGZmfGnwtKZAVmnEdWAu7a0Uf+r0w6Rapg/wEE10woPmqb8uDGrq
 31ySL/UrRfSDA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 26A91B22183A;
 Wed, 21 Oct 2026 18:50:35 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v2 0/2] Enable SPI NOR flash for SpacemiT K3 in main app
Date: Wed, 21 Oct 2026 09:50:00 -0700
Message-ID: <20261021165016.1395485-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable SPI Flash command, mtd part names and locations, and store U-Boot
environment in SPI NOR flash. Selected for Winbond and GigaDevice parts.

Changes since v1:
- relocate imply SPI in SoC base config to enabled in board config
- enable GigaDevice SPI NOR flash used by board variant K3 CoM260
- relax commit messages to describe more than specific K3 Pico-ITX board
- drop advice from commit message of dependency on vendor SPL
- keep simple "spi0.0" mtdparts layout name pending some way to automate

E Shattow (2):
  configs: spacemit: k3: enable spi nor flash in main app
  configs: spacemit: k3: enable mtdparts in main app

 configs/spacemit_k3_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)


base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
-- 
2.53.0

