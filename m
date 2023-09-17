Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC9ECD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE0D86A38;
	Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lvdjLwSa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HOa4ii9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF9786A2F; Sun, 17 Sep 2023 16:12:03 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EC386996
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVH46cK1z9sTr
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u6fJGr9n9tBzuMVXBPj4n5Z3HN5yMXLRximbj0r/48U=;
 b=lvdjLwSaHVmnB8fqsr/Tw6CMbWqj9DZnuq1IetusG+OKHv097sJxahmwVvypvrOoA52Jhe
 h3VWK24UA/tpWhNfSAP8FfgtaPtKGIqsoMmTMgLiBa0f88u9itnsPfkhsXZCiSf0M/6Q7V
 gcL1e6aAheRdo92d+LFiYaAyy+PZGc2oTBXmMQ7FSmMaJrrCHR08T8RKEVxd2s9qC0Lslv
 cImXgRRE5aGOuTejMwXvm0JU/RACB+JpQfd6sNyu/KQGW2rsq9qJrl6qxM62AgeZdUDYLk
 u3f0xX4QtKSN1qa+8KPkZ3MQmX7C+b0zm1znRDJKvgrCYE7zO3Wxto0K2zb+Fg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u6fJGr9n9tBzuMVXBPj4n5Z3HN5yMXLRximbj0r/48U=;
 b=HOa4ii9BqDrSt67BNo+r+gjDBBcahGDK5iLJw2UOJP185NrGnXy9yVvNdE2L4DPRfQQDH0
 V6YWf2bEce8t67y5799Wt+pplqkT+kSDlTJQCU0x8hd1acZbyVyGvMwbEL7UX8/izK9QKm
 6NdL9ul4AC7kn3YPVosuqa4WRx+YVl7xo5d6ZWZKWbaKZF/go2rzrmFN8DysHw6BhojJZ9
 jloFoDWufdC6+3YPsxz7thB9LlPIIG+PmExJShpTg/qAo4wiZ0Z97rInIjQGq1CEHA4wj2
 HUdNR6hABX7VUgQD+DBry+RI1NVQfEzt0SnsQ5YBMxr1td90raAhzNbl0n6jgQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/20] clk: renesas: Synchronize R8A77951 H3 DT headers with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:22 +0200
Message-Id: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b0bee2a07758ea398ed
X-MBO-RS-META: jyeoksaxb6maj5d78s7xnnf45amz343f
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Synchronize R-Car R8A77951 H3 DT headers with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/dt-bindings/power/r8a7795-sysc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/power/r8a7795-sysc.h b/include/dt-bindings/power/r8a7795-sysc.h
index eea6ad69f0b..ff532385857 100644
--- a/include/dt-bindings/power/r8a7795-sysc.h
+++ b/include/dt-bindings/power/r8a7795-sysc.h
@@ -30,7 +30,6 @@
 #define R8A7795_PD_CA53_SCU		21
 #define R8A7795_PD_3DG_E		22
 #define R8A7795_PD_A3IR			24
-#define R8A7795_PD_A2VC0		25	/* ES1.x only */
 #define R8A7795_PD_A2VC1		26
 
 /* Always-on power area */
-- 
2.40.1

