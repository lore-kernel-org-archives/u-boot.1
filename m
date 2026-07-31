Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C808C55174
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 18:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35DD580BA9;
	Fri, 31 Jul 2026 18:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z0d4s1hwwnY5; Fri, 31 Jul 2026 18:13:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10FA380D2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785521631;
	bh=VDJlSv3AdXKDGlHcVJnckyjebvsKV0IlOM+LNbKHXd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdT5ZorndLtIHiai35K/iLR3YDXuuams8RjCZsYpbt2NliP0kPlNso3UKAmt8UtlG
	 z7jkJJLhSgjnnyN2petcxUmxzFe549wKpFAs86UKVGay+pT5QdFGkp863ITjYcxpqz
	 Y2WthViMeZLjxykynr6dQUGk2m8dSNwNsW71PwGIhLMQ4qq+kowY+W+SyrrS8whZ0Y
	 ymMbVoKfDyYqwYHVJ0Dn1ivHZ1RZHTQpYfL0Qzp76QH2GFshILZdrZ9eFZl7WeukBx
	 5bnC6vXQRynnxNcatBlR2UdhDkiP4tTY+pdlVi04Y1uVq1fV3ZRuL8zq0FHXxj04tu
	 HVFvgV3iMOu5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10FA380D2C;
	Fri, 31 Jul 2026 18:13:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EBE3227C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD96B80BCF
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crkSIjhqFdyc for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:11:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=smtong@axiado.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B777E80BA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B777E80BA9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B777E80BA9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA7D805D7; Fri, 31 Jul 2026 20:11:06 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F83484A1A
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 20:11:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkhuU4Gyzb5FuiWWplIQ8JCsuHX5/Xts4KaaxcCG/ajpbRVMYl0kpmODb8KP3FHBL6G0+ypNwRC1Z5HMwFqyqPBvgMVS2UOlJ6f5eEO64Fyyq9D4zvTnUm4hH9PwjVseLzf0UVuU/+GVb06TB48M8dtP9K/zPt52NTQUsYOXhFjmiYgFOzUmZZ7eMrbRjqgQS1gCIqpZcUYZM+5EuvLSKVjOog+3RGVK6jKwxRGYO9vjzzXeT3jdBHyNzZ8ROlQHymYXbiPrn91tmiLdwjQAK1jQDHh80mqV+5KKHlAiVte0EUbBZSw+qeZ8i8aDbrhvgMbFd1otkrFrpgeZedt9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDJlSv3AdXKDGlHcVJnckyjebvsKV0IlOM+LNbKHXd8=;
 b=BM9Z0qYGHS7p5l3WShpw2tUMyNB2IBUj54y5RdTcDV1S7pPv91v1KX5vusz2uES1qdDtgHiAngAbbaJVEQo0VwhJWaCgwWRLn1esmyQRkRzvdYjRiF/XA/aJI+K+hMgK58cOJ1m6pBlZSAEgwGI61xy98W4Psv0P4BoBQlGieFMZtlogm1ocoPFaM+dciIms9E7ENtYAKtLVOioZm5U5bWSzCAh+Pw97n0OPME8YCb9o/QnUtTUVeNfoHkVmVBu4+Cz4ZY1/cHioX19cvmfdR/0TqQ6eZsjQ8gKOJcAWPgFddWPnEcJqfODc3afGmC8ml6agcf5OD58h4FBl2Dq4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
Received: from BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12)
 by DS3PR18MB927666.namprd18.prod.outlook.com (2603:10b6:8:347::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:10:57 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::98) by BLAP220CA0007.outlook.office365.com
 (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 18:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.0
 via Frontend Transport; Fri, 31 Jul 2026 18:10:56 +0000
Received: from [127.0.1.1] (unknown [10.4.1.117])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D63874186B5A;
 Fri, 31 Jul 2026 11:10:55 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Date: Fri, 31 Jul 2026 11:10:51 -0700
Subject: [PATCH 3/4] arm: dts: ax3005: Add SDHCI, eMMC PHY and clock node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dev-scm3005-v1-3-30bea90ac5f7@axiado.com>
References: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
In-Reply-To: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Siu Ming Tong <smtong@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=smtong@axiado.com;
 h=from:subject:message-id; bh=JgDuXLnZtnEGEgqiJp/f1fgU+rroPzOosdmDM6KFL8E=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqbOUvQr+J/00mtgEpxCNMlma8iXpr4ylWGKbqh
 P1ScdvPKSCJAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCamzlLwAKCRB8HKhyFELz
 jrWfC/wM2I6FTAJshWDPzXHBAyvOWny1oY/oJXv8pfpLmZQ5pTi3SpZCZliXPiuhYPaJvEoTagX
 R15ixyH5O6PUanYwFhV5S6BFPIpDeMqXE+l3nywz4bvmE7oRrBTozYATTMuFRCFbvx6bFDzHIM0
 BiIe7r/j4pXVCEw80T1gITFBeohtC4bcCbdE9xsZllBS4l2qiNceM3s3mleWJxXyNKtsxXJ2C9I
 ffgXTP5I9o160c6tqNMbQhS7VBB7G2vz/pRmMvTIAuN3PJF1mMGtQ8ywifWSWzCxVoQy+ZIE2hu
 fkWbSv3fxGJhEOJvHDPxh72F0d0MsvuYYiTWZjBchoRXbU5bWU3h5NUS0swo8Osrdbg5CxSD4dB
 +FfVVSkwkzqWUZi8JuIzcmkH3Swvi62NXkRnZnq2eNNgUjGEDME0R9lS7EPKe8QXLsKMIbICQH0
 RU9I2nSbTwTUwoNISTCTMxd4Z1Lbc4kdQYwQ8gbk8EK1ne2tdwf3kEN/ZGkvd45unZdGQ=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS3PR18MB927666:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e187e4-1f35-425a-fb65-08deef2f116c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0nEt46UcCgt8AaQRqJqJfDJrzR9n7ZM2iQCyNdHSqJsBCe3BUVb5aaNMqA6yj0fGNtS9oee0hZ1C1dsaG2vgVn4ydUi+dLDAuj67bvIl7OvENWKw/jJIEmg4lTBBK+XcS0o7u0ywLclRD0Z4ZdmxghY6bzgagXsbNI0R8m+eBPSyRRM5+eEt7n1kB7haSGM9P+syOVdM4CVc/u+1fXLbBBnaEchNEVcwvyrmJg3FESnuke76bdcUwlBUJ2NnnI52JT79jr5QcUZ9CAq0JixKO/cFReN5JdlrwekVBlDxkYV+ZJ5ZYSdMbkRb7NgcIZLhz5+XqUb4wGMuxTXrq6WYdNBIAnNli/y1Li3gZRktUxXnNk74BxIfPebE9bTcKlblsrLOowSQfM/UVctTUTp0EJX7ImdctlrNhpuO6kVb51lFr2snLFEqdD1XsAPOSB7fVe/EkeCJdXddVytZHEO7u73hJqDJUJn6NORrRbWzrw0OCWlsnWDcoIyPZr8fYFD2Xsm1cbfQOqK0VsU1zn8YJwaz/bI5q4g8jHBadgZsIWw5/43Yk29Lc/7Ac1BVqA4GDQ0T5l6R23lP0atqR1iJy3rc9Ha5Vp3swzeoCjbI6DrKl5Pfc5NsfK5l4R/oKQeTv6soRfI3srl60Gnlyzbbs/HIMjVleXQ8gFODUFMIFEE=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IVkp+qD4/X1p2NIXMXcTYr1iYkBYAX/hmABUGZE1KyQpVuJyz/NhiSon5IrdyMiV1fcGwQ+FE6XzlIlVvLiX3EtNoSpsqHiBncnfcyUdCN7+JMAt9Xgk1vNn1+KlP8RvcqsZz6XWvMxnlwyqRftxPLyiZ6djgpDgbPifraeHqOAe+8paRUK8meQyBmnFsatZrD1OmP1LuqnwKDhNOGR2YP3y0CU0ytLutDQ8uWqJvJnBrsflfgwMl3V26RhsMuPAJQPVQ1AfiKVJGOFS0XPtgNfbsb7MaMQKwQJTIg76liGuxwS0y2PEUUf4Eaaf6RgrMMHwhfewtM+LGy1N3+qplCanlRRjEnZB/u7jEigIC61ND1uXPceSX9XVcIVCoQg/ULt7o6KECG8ksF+m+iOjEIxpTaANfH7m7dauATpoPd8+lPhcXrxH1n4GxIPA0yxQ
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:10:56.6298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e187e4-1f35-425a-fb65-08deef2f116c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR18MB927666
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 18:13:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axiado.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDJlSv3AdXKDGlHcVJnckyjebvsKV0IlOM+LNbKHXd8=;
 b=UOd//ainyyBGe//TGV2rKINSyMu1Ae5nLj8nSHb8hK4TU0E4vzBPs/rYHniFd0R/phceZRzcb9fHysskNMVjnPzCeOMWQ6m8DIURipTYQH4SojC652uPy0NalLeDGAgFonHsJn57Zu33solbsYbs8Uzxcubizc3N/3St5sRPIOj8t2BWNjo3eQQcbLIOYA+TF2BE8r/GX1dt+8QWXXM/58k/u3qJa32BV9QftXnVpbamLuB3PuH05d6ZRtDoIpS+o7beSNpAJaXyDIUuIaWffyT5KPlt2oLjPjRnEnbTFAGJ67lHTvyqXvOvCOl8odshzlBwZ26B/Y4gPEpJNhoa+Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256
 header.s=selector1 header.b=UOd//ain
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=smtong@axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=axiado.com header.i=@axiado.com header.b="UOd//ain"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add device tree nodes for the Arasan SDHCI controller and the eMMC PHY
on the AX3005 SoC, together with the supporting fixed clock (clk_xin),
in ax3005.dtsi. Enable the SDHCI node in ax3005-scm3005.dts for the
SCM3005 board.

Signed-off-by: Siu Ming Tong <smtong@axiado.com>
---
 arch/arm/dts/ax3005-scm3005.dts |  4 ++++
 arch/arm/dts/ax3005.dtsi        | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/dts/ax3005-scm3005.dts b/arch/arm/dts/ax3005-scm3005.dts
index b684602176c..3ef60b0b36c 100644
--- a/arch/arm/dts/ax3005-scm3005.dts
+++ b/arch/arm/dts/ax3005-scm3005.dts
@@ -26,3 +26,7 @@
 &uart3 {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/ax3005.dtsi b/arch/arm/dts/ax3005.dtsi
index 6df2e4a821c..7c84675169e 100644
--- a/arch/arm/dts/ax3005.dtsi
+++ b/arch/arm/dts/ax3005.dtsi
@@ -64,6 +64,12 @@
 			clock-frequency = <125000000>;
 			bootph-pre-reloc;
 		};
+
+		clk_xin: clk_xin {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
 	};
 
 	soc: soc {
@@ -96,5 +102,24 @@
 			bootph-pre-reloc;
 			status = "disabled";
 		};
+
+		emmc_phy: emmc-phy@33301c00 {
+			compatible = "axiado,ax3005-emmc-phy";
+			reg = <0x00 0x33301c00 0x00 0x100>;
+			#phy-cells = <0>;
+		};
+
+		sdhci0: mmc0@46000000 {
+			compatible = "axiado,ax3005-sdhci";
+			reg = <0x0 0x46000000 0x00 0x1000>;
+			clock-names = "clk_xin";
+			clocks = <&clk_xin>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			bus-width = <8>;
+			phys = <&emmc_phy>;
+			phy-names = "phy_arasan";
+			status = "disabled";
+		};
 	};
 };

-- 
2.34.1

