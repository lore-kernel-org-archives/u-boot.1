Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D5EC9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5597A80DC5;
	Mon, 28 Sep 2026 10:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZnzb62IUtpd; Mon, 28 Sep 2026 10:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A103680D97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590522;
	b=GzZfmPLXhhzw0GTNdnzG1SWm8/0GeQQ0lv1w7gMZYQzZhBEjPUa/L1HPanIotitflxlV
	 IRjiMqenNRxtAvahFZvZXafW4q07VlIwQj+p5bg+qrDfSA5CC5Y9Y9tQsQlWpx0gnRE1G
	 HsLvA/Hmu5XjIDSw5nO2MZqgC6F0ggzvKlLb1lIS0nJPQJFh9i4s768hchGjFrq6E6Wn5
	 nj6xUejFdYAKElR97Ze93uFu6/V/iVtIxQfA6cQ4Jx20JEdqFVH5wN43FKe8J99uU3sdB
	 OHDK+BvsVKxG3aVJhrW8AJoRx5eeqgGjb9l3YobkcXncZ0wGym04iE3DLiBzUyv8YYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EZrrWQmX/5c4x3YJasJqTh56KiA+DYVRTw+Ag9AbD2M=;
	b=XNM98K+EHbmQfvt02cjD6jWaRfbkkDuIUM8966jrDkLwL3lSUsV754Dkh4KHaq87DFhO
	 Tb+56mEak4dLNjK9SjqrZKOg2pUSXP6ELMqYfTyrCC1ibeQWh2GBah5SJGsifIVyYn6EI
	 nPeGF2FRLdtRpPirSSq4FqvBbgMwdAbhjtPtFr1xQOPYuDzHTF5UiMV3FKT9X+9vwR3EV
	 ATZ1e/ao3eP54EPHzk8cacEh2+oG9K9SMlbfBpyDIySfI3Eh1q4qDX1B5IrDWVDRGrlZ4
	 12XxG2Qkbwsjo3fRm85wp2Ripgc8+wzFir9cZ5Ap4TYIP311qieA27AxDvwXIC/pyog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590522;
	bh=EZrrWQmX/5c4x3YJasJqTh56KiA+DYVRTw+Ag9AbD2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zzOf99tDpOfDSDuzk8Gq1KPz51AV88soIsjMTpXGtJP8/Dv8FONPxlf1DtQ69/r6c
	 MB2/fNQK1r3iwDRMH87KQd8BSrnshiN+aJhvlAgTNr/kT9cPHwl06CVYOUwPuX3eSn
	 gvGkJaZijO6yPBwpzIVnfuBZ3Vck3e4/si7GpUKuMFPavkOBbYRT6YXwSpjqZik/qO
	 4WbI4abdtrqiBW3I0qOw7Iib7o+Fs8JDCWtOgyHUYpPWfG6NDn61p4adJcm5JytDnj
	 rCLn7uZki5exGiq/cOIXBYreSoeu6zYX3njM9GQLIH8fDqNFSQItJxFag0ZT3yV3R8
	 WM1C72MR2kkbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A103680D97;
	Mon, 28 Sep 2026 10:15:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85CC524E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7774340674
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UaHBvGc1mWvp for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:15:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4E280402D3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590520;
 b=rX8l9DB8cCrssYx5LrJABQ0o8i9tzck7hCdcct9abNBaMviD3jZdIi9iZBtdM/Cn6lP9
 Tjp9QCuz83WTZJQBLQoJKJwE8A9pzzeKnO+1F70BzJVNTK4FDqEJlhDUnxX6EHn1HIS9V
 ZfOiKi2mo7PUAuDx4d4k3dKBdu5uL/oYzP3QYVMWyw1bB7vZnE+ZyblPCGNqMdAsc6Fni
 ib8hhQILBdgnoxbB/1KL3uaSJEP4EL+OnIAnj+8sepXPVQafT6NlW1N2uoUs9KqrKVTlv
 mDL6rKcv/7YNHlZ9WJhM1VhwaXl2AwqTojKwtBB5QRPPAX5sdDZIozBIZryaefw7YxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590520;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EZrrWQmX/5c4x3YJasJqTh56KiA+DYVRTw+Ag9AbD2M=;
 b=DOvTfKLvIJY1gk5dOXtJwfjsonAuMSM6w4HkKI20Y6KfUGxc4lxqlQLgBnTpQ20apvbd
 zv316W6P8SJxmsI/FcG2HBntZHQnL5aVXFTfPPBDDO6cShFj03EittEyFNOlLu40/MdN4
 J7MdMY8EahlJ6/eHi+49F8hM85wWrB4+a4yM3IDhMvEmN1hIU49+ZkYeCnQCP5Ra1/jnH
 U0GwcuwmBHMnC1qUlN7iDZKG8Vv5eaZfCDyGV5O7qu1NucQUX4O9j5S3kkKEpD2BM21xv
 9+fd1Xja0Z3uBFDfK2s6bhLm5XYoMYEI8kthsA0IF7VFv97WqfA5CTkc0H/2iM2midg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=fgWQbv36; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=fgWQbv36
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E280402D3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 0C4C4B0056A;
 Mon, 28 Sep 2026 12:15:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590518;
 bh=Fs95Qk1gPz21MbsLzcvw5tx3gdlKzjxr0D79dP/s2BI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fgWQbv36lSloQIEsTcOvVgCCtVhtyj6EYAoi6Vm4UHKHRnrtw70/g4KJ7qHfN/zHv
 8gWGDOPqRsq/p4rR6M+GURIbOyiiW1Z4yU4YFZzb4h2eO+a/jNBI0t6mHR1AJdvkNP
 0bSrw5lT2cVr9DdVEuJTMJYPO5pVfR8oHhw3gfzZgF5pJa0o76loCDler8GK4LlZxM
 5pRFA7M1vepdOc8elbOuBqGv21Kr+IgurqG7CsHvyAeBRA+QdR41FykOK8DPHEcbNR
 IOERxgYdGHOJLVbJU7m0gwcHS3ZVHBdseiMXLvJZVaVyf7qPX2i81QegnJnETGxt7V
 XAGhvJV5tUOxw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 04/10] board: lx2160a: serdes: report unknown SD1 cases
Date: Mon, 28 Sep 2026 12:13:23 +0200
Message-ID: <20260928101330.881662-5-vjardin@free.fr>
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

Check and if unknown display:
  lx2160a serdes: unknown hwconfig serdes1:split, ignored

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 11bec35fd22..a8fbb278b3a 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -443,17 +443,23 @@ static const struct sd1_mode sd1_modes[] = {
 	},
 };
 
-static const struct sd1_mode *sd1_mode_find(const char *name)
+static const struct sd1_mode *sd1_mode_findn(const char *name, size_t n)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++)
-		if (!strcmp(sd1_modes[i].name, name))
+		if (strlen(sd1_modes[i].name) == n &&
+		    !strncmp(sd1_modes[i].name, name, n))
 			return &sd1_modes[i];
 
 	return NULL;
 }
 
+static const struct sd1_mode *sd1_mode_find(const char *name)
+{
+	return sd1_mode_findn(name, strlen(name));
+}
+
 static void sd1_print_pcc(unsigned long base)
 {
 	printf("PCCC=%08x PCCD=%08x PCCE=%08x",
@@ -503,6 +509,26 @@ static int sd1_enter(const struct sd1_mode *mode,
 	return 0;
 }
 
+static void sd1_report_unknown(void)
+{
+	const char *arg, *comma, *eq;
+	size_t len, n;
+
+	arg = hwconfig_arg("serdes1", &len);
+	while (arg && len) {
+		comma = memchr(arg, ',', len);
+		n = comma ? comma - arg : len;
+		eq = memchr(arg, '=', n);
+		if (n && !sd1_mode_findn(arg, eq ? eq - arg : n))
+			printf("lx2160a serdes: unknown hwconfig serdes1:%.*s, ignored\n",
+			       (int)n, arg);
+		if (!comma)
+			break;
+		len -= n + 1;
+		arg = comma + 1;
+	}
+}
+
 /*
  *   setenv hwconfig serdes1:<mode>
  *
@@ -517,6 +543,8 @@ void lx2160a_serdes_apply_hwconfig(void)
 	const struct sd1_mode *mode = NULL;
 	int i;
 
+	sd1_report_unknown();
+
 	for (i = 0; i < ARRAY_SIZE(sd1_modes); i++) {
 		if (!hwconfig_sub("serdes1", sd1_modes[i].name))
 			continue;
-- 
2.43.0

