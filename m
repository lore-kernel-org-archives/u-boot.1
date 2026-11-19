Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC3606A32A
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x6sojKmW;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=MxSKYC8p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D45578145D;
	Thu, 19 Nov 2026 15:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gtTpMxj0B3C4; Thu, 19 Nov 2026 15:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 958088144E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103675;
	b=SPSfFOylIIewuutrEarpVySbSoV7e7fohCKdKZAXlVrhF9+HYoWisbgtvz1RaQpt1ugK
	 zd/JgdIRylUlsH7mMC9sOUYJdGhRLWWS8EZgGFFd1WN5qM+XHn9v3WAIjbsIdKkHErt9C
	 sCVphUokRR9xd4Lf+yMWyK5+N0NvednadzJWUqgAayF/Sju9FKYQQrriybgT/dvipM0T6
	 +0jwIBbC4N9cSkfJlVivaGNgx4IfGIrqPURLpO5idgcllxMYtch2FgnI8pkc+Jf5UVx+j
	 lKtSZj1cKTMwDFbkES35DJBT2pDLBNIe1ZELJbCglTT4O5kWb8jGs5BNGqGBBtTUNrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3NXwllEuKHrtz4ByQjafnpISnqHqgc6TlGO6ReizwmM=;
	b=jOJzxFeo3KOWnETq+Cr5xVjhRXZpQXFwWpJrrFcdbSsLneWA69cUQqFCm91TQAATvDG6
	 zY0Oul2C9dUz9i6DoBDy2FMwLMI6x3MnxjsQwhd1AlYMgOZOGhNpdM+n6zEhPxmJiYciC
	 vCDGVL47967udBh0k1EvHRv2BLv/gE7ELFIopj1C5m92AyhVhi7p45fCX2OfjYEPXNiyp
	 IdAjBKtyTOXRxOoJRAoXKsjNAlWVbFJtOYuzDfXu8HmvA72iikbLxXJqK5leNkXGLcL9C
	 pY+M4GmV/MX80rRYVEMPwQ4ENRyenLOfacnksn9zR3cg5LooxjMLVmQY/NuuiuKhJkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103675;
	bh=3NXwllEuKHrtz4ByQjafnpISnqHqgc6TlGO6ReizwmM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x6sojKmWZmt6jVuuwIWWcAJmdqlsI1m1qnuSWx2ZMZV5a8F8KWtwGxGscpALZeGJ0
	 lmCHu4EUPntW039FTIfo2kEZ02yzJEiIoOa00aivMyT8QWXjRC8ZxP4VjB15Cm/SjM
	 5RzSuun8Y5ARnqB/QqnNxRaO7uqbjjM3uhilPB1Eh3Us0RnPq1qfq1ZnAD5ics8SG2
	 Onjh0LH8ZqnkyiQJDP6euc7NsIEg8mBaiLIBquLNCIteSnS0J39f8dV6PyBo/ip+BZ
	 BmJHWwYYl7UOT4AQkREmwTWrW6V4HwNmcxy4fVOh3Ps7zNQ66m3U7zXGO2WwzMk749
	 76Iwe9gTgP8+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 958088144E;
	Thu, 19 Nov 2026 15:54:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A7182F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40C9860D7B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLctsN9YuQZk for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 532CA606A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=t.schmelzer@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=MxSKYC8p
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 532CA606A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NXwllEuKHrtz4ByQjafnpISnqHqgc6TlGO6ReizwmM=;
 b=MxSKYC8pM0V7YR+uEhvgEpdpg3P/qI67eSkkdT8CwGaGWySA9ldDMtx8tjpHRngbrtMD7JQ1SgiG5tdWgP5AX3olOnhPvLUTM5F+bv5wkfktuuWeWHAB3W9olUhWwM2zlCIi94xJ5SNIpyywoEVLgk0Abeorct7APb6kebylNyeux5PAUgPXR4LZOJ0t6uHEfcflembhmRUyGHXR2xnfIUt3z9Zb7xCncX9QND/uh4mJLiQLtuOHL29NrmSHMkm0cc7irGmSaRzUW7PQFy+9pMzu2If9u3QMROrKONx/ZZzEmvG96Eh/4xDaaDcOQQx7mwlH4kl+xvY99xnRWMMouQ==
Received: from PAYP264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::23)
 by AS8P195MB1238.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 14:12:34 +0000
Received: from MI3PEPF0000855A.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::90) by PAYP264CA0036.outlook.office365.com
 (2603:10a6:102:11f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 14:12:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 MI3PEPF0000855A.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:12:33 +0000
Received: from [127.0.1.1] (172.25.32.137) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 19 Nov
 2026 15:12:31 +0100
From: Thorsten Schmelzer <t.schmelzer@phytec.de>
Date: Thu, 19 Nov 2026 15:12:15 +0100
Subject: [PATCH 3/4] board: phycore-imx8mm: Start fastboot when booted
 through USB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-3-dd6db9e5edfd@phytec.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <upstream@lists.phytec.de>,
 <u-boot@lists.u-boot-project.org>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Peng Fan <peng.fan@nxp.com>, Yannic Moog
 <y.moog@phytec.de>, Benedikt Spranger <b.spranger@linutronix.de>, INgo Rah
 <ingo.rah@linutronix.de>, Thorsten Schmelzer <t.schmelzer@phytec.de>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855A:EE_|AS8P195MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd7056e-90ce-4efa-dd40-08df46472826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|42112799006|23010399003|261009223027099003|18002099003|22082099003|261102123227099003|261021121427099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: cqk0TER2mK/l3IA9fiaYmgHVJkis5MZFo53n60f28qBGJRPtpIFJKLddBl/tpyT4F/fXV3CXIX03GKMt8wCdruXZIj+shyeRbjjuOvl6zuceSaP56vzhPD1JB+R69ht/q9jZfygsQxW1nE5gLUowT2l/jvqyZrdGbH0+tPeXAsFYV6Sza2JMQt3KfZCPywI029ECH2kZYx9dontk7ddRrtpkORdEarqfGuV0dpfWb4W4IuMz2Gbt/QNN/ZC0oEk3Ca3a9VPza2s/xYEd/XNwnXDuX/xMmSBM8KJDvlwy5NsQpMKhHT5uck0cWLX2HDp1PmVhx0cBj9WGZYzvpEKdld0nbxgWfR7kFrYdeivHXd93JwXmVO5xmDUHBEOKIqH9uOuvywDBGDdTFkV78Y1wwqlN2on7Qr4zA+xIqaNZHJ1i0uajhRzPPwFiLlR9LSYxRNUuT93dzv3FF3CxoC/287qlMvpKBztkQGjBrXZpKHBWEIf7MRDe/3hruWWuL21Hrp2B2QF9ixxcNE60bFEONINXO7XYswEUSP5FgaG88YlPugrf1ugDjSbB8ec1/xlpFlhNgRzXPsIzU8PzDvE8dJQMpsLWzMxn+3QQ0g06i8uBYWzzHOT5F2gOLzUHJ0cqlOvypgl7IXXNfuCCdxzRbOhZWlVQ61icjMta8RocnmdeYAXVb8CdX2Y9W0V0jFIstecqsYLTgA7hMFyIRDyfAg==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(42112799006)(23010399003)(261009223027099003)(18002099003)(22082099003)(261102123227099003)(261021121427099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +JQpgxhBHutY3bALu6Xa66CjKaepl7GTILjBUOn7Va9TMzFfmR8aVGtVHmgqRvEy8mLRQ8vbMSUKwlNG4q4zA+FWc8rvCLa0M8rZSq2Valfpk+XLInuI3EvjpmX3H/BXuz46GnbnQSZN3TpfwPFypYVDr00gYYDg+Ma2D3CSaGZTCGhVmWgSEyMBRodCxKKRvwapY7XO2mMSopMGiOCjxA267b5jxC7ieHvlnn1Wz970p2FLH7k378qDsqrU9SZgu1XY88T5li762Qz1iEa6NGH+USblrMEdSAq54pV0E4jPTp9dphXQq24eQPFT/wI4LuVcgl8sfVyABGFJG04SooVkoeW6/+o4ORJd4u/tH8kDbgUzSkwab3WuI/TLMT3wL82X8A/berlIiRdaioXi7fvCBf0xI7HAiyhoKa01ofaVUYdbnl2U2MlvJdHIH2/l
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:12:33.9642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd7056e-90ce-4efa-dd40-08df46472826
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1238
X-Mailman-Approved-At: Thu, 19 Nov 2026 15:54:27 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In order to support the complete flow for flashing with the UUU tool,
fastboot has to be enabled, when booting through USB has been detected.

Modify the bootcmd in board_late_init if USB_BOOT is detected as boot
device.

Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
---
 board/phytec/phycore_imx8mm/phycore-imx8mm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
index 25e51dce7396..6e1e88a0a47e 100644
--- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
+++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
@@ -45,6 +45,11 @@ int board_late_init(void)
 	case MMC3_BOOT:
 		env_set_ulong("mmcdev", 2);
 		break;
+	case USB_BOOT:
+		printf("Detect USB boot. Will enter fastboot mode!\n");
+		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
+			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
+		break;
 	default:
 		break;
 	}

-- 
2.53.0

