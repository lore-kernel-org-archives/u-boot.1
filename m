Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC2606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NikNxyeW;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=GVt2U73U
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEE4060686;
	Thu, 19 Nov 2026 15:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y3R8ZPX0lQF2; Thu, 19 Nov 2026 15:54:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3A6060699
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103671;
	b=gtiw4SD/Cecs+bz0IG9sJKxUrTTIKDXuUsX74oNqBDJ+0/x/lZf1b8ojvFNb7TrKiQyp
	 sEPjEzUtXzZUNri6du2vwbjk3SVEmzjtegx0Z41yFA7+iIIiqK2sRcESD2YTHfaKtk+92
	 rSLFXF4dVbGywcX8xF5N0IpZbPp8xWEWDwxVRZ+Cv39oK0uSOPNVFTuwORyoDX3EMMhoX
	 Cu7OY/b9Sl9VlGSKZYK5n9juo+fq7x2J4JnQJmfgsTtPrm8tdkgtV2TQGtOUZPX6CaVFD
	 ruo3SAMDNFcmyzqlvFiyW0kLCC9ZZfEf410WNsTViUSObT4iG6kZQwmiOwMvmm+QS+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
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
	bh=/dW68xqQGYeIiF/AHMEMVvvys5vM6F0YLRVbXytAJ44=;
	b=efDTL8K4Hy5FJZOyl/QefRT0wpGJ3cgzx7P9vx3BV6SJZyR8h098A58lDSvEB5xy99pn
	 1uGn42ARzVv5e9DZZZwOEtobRBpWcXHS1Q7/U7mjcUeHO9OHTfsi3cN6OWpzFb36CU5Es
	 0O5FOPjILzyNKtzLliIHDZ06PJdmWMlfe0HcL3Ut+Be2zW/1NdktGAMFAk2HdUj4hUqkG
	 4FvRQShVtsM1hl/MYOZRUrWIj8EZYeg0AhZ3Fb+V9HoLvb+XcJtQtfdwTYxg9GMfbGKxD
	 MTInsYl/RhEZIvOyLEXfM3aDstuoTi60XQNS8DphDipZ1NwQI0cogwea4AQb2a9KcyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103671;
	bh=/dW68xqQGYeIiF/AHMEMVvvys5vM6F0YLRVbXytAJ44=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NikNxyeW4MaJ66O11EFioqjI+ivgJSoOcwa8CXDtXa2dR6zc/N3DWP6/L3Xjus0Cr
	 afzLlOkWacHMAmDkqvPyKWKUss892MFqTWyuOiFFzM3rthNiwwzb0geC3OyPbB5E46
	 Fbq3i/Afr/WIc3BmzcozB8GYZUXRbzxoR6Aw8EFVazwhgzr/w5Da7Mvil6tt7q5+lY
	 8PUgOHqGT3mnSCXXtSRCUqgM8NWyBq2m6+DzlrWCK+TEqZ36SKT/tccq0RR0YiffMz
	 jyivC/ZgeiDnmwlCO4Q6DCWG61NEntCjrYmj2ZEOfzJsHqnY2yDBLoeRi9BRT8UKVu
	 q5s1WQKJM9QeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3A6060699;
	Thu, 19 Nov 2026 15:54:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CCF969F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2ED940B12
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oi2o_0HgOJUP for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2EEF40B14
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=t.schmelzer@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=GVt2U73U
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2EEF40B14
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dW68xqQGYeIiF/AHMEMVvvys5vM6F0YLRVbXytAJ44=;
 b=GVt2U73U7U/IgoFbAVh4ucLyXGmZxzpf6rDI66XhlTQJ6m+LX1uhH0tIuTw6gVfDHcg+wO3VsuFr6BB8OIfKOi+WaAjZuAccLtlegJA01S2N2jq+VmU2GfNWdMZSbcxEdaXxDxexlsGZ3t6H2AkBa3sb6N+AC0JCS5cNz6fG9w+fqCwA9QnXG+ZzXr0N5u1hbRyQysHmiQ5x6aa5W/Dbl8tZUI6ZlHQX96H0P5h/nhiA7c3hxfIel2XDTQhi5KEWrlZqNm3he/LcfIa1znqzNT1H4YGirXIPYMungyFm0szFOXle6xUeNvIVrxr/8WpAknV0W8aKKAXLmFUbsFijqA==
Received: from PAYP264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::8)
 by AS4P195MB1624.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:507::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:12:32 +0000
Received: from MI3PEPF0000855A.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::36) by PAYP264CA0021.outlook.office365.com
 (2603:10a6:102:11f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 14:12:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 MI3PEPF0000855A.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:12:31 +0000
Received: from [127.0.1.1] (172.25.32.137) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 19 Nov
 2026 15:12:31 +0100
From: Thorsten Schmelzer <t.schmelzer@phytec.de>
Subject: [PATCH 0/4] board: phycore-imx8mm: Add support for flashing
 through UUU
Date: Thu, 19 Nov 2026 15:12:12 +0100
Message-ID: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBA0auQWTsJrULQqxgWpYx2jIWm0ypKu
 LtVl2/z/wpCkUngVK0Q6cHC81SgdhVYZ6YrIY/FoGvdKqWO+OSACcU6T/c3RQzulcjiSJhlwJw
 zSg5hjgnZL5332Oy71hhzsI2uoWRDpAsvv+W5/1vycCObvh/Ytg+JjWIKlAAAAA==
X-Change-ID: 20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-5386aaa4c520
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855A:EE_|AS4P195MB1624:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9ecc09-3884-4e58-fc1d-08df464726f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|42112799006|10067099003|11063799006|56012099006|261022115727099003|261022075727099003|261021121427099003|261102123227099003|261009221727099003|261009221227099003|261009223027099003|261009220027099003|261009223327099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vbovkr4YzB3tIRt1g6fjkP5fLKZm3IRHATnPgrZqTrgMPp79km1s3Yc6uCyA/gdYXGLyw532ukQ1vOZixUIJRpcCwpBknsu1E7XXeDIPeb/IZvbSby20ittjbXxJlhpSGBkR9htAQMXCREtqbYp+34ndl56SFpZuCbmJNFNMwfDSPSRft8p0ma++oKW+sB3fAgtSeMi/nrxy0+PLQDsJ1LXeqy2zIowZ4j6Jld6zVFKIGnECYReagygIFnzyUdD0TitIBBTRa5ltPUkAawpWmydq9JwjNTkUeVfefRtx9KWRmLWf8nozqRbXt641PPB5Pt795jWhlQ5Bcmfr2wuAEMNrWxe0cv6Vca9MPam7VxWeAX6p4ZUYkkrjYoDpQwQq/atZXdZz+MPWoeeZ7k8m6PM200O3bTisnvaqK1gkC15SYLjowhbpf57aTiWn2nugqgvcHP1e7ytm7fAZAM8Vq94eTxheW7k3Abei95/rO6bZ3B5gnH6+B223GXFnlgRsA77gymK9ug02jLNgjP+IxRdW7BZN9zCBZzFgIPu+cahFtv6daJuggb3LqESSkoW7rojWw6lkM7PaPAKeX7/xNyr3cCgYCHq/iphE9TX05bEQNYpQspxnUEspQNWHi/8n59L/MpBqFSO2MNv3HX31Dau5/y1nyaciQza1JoUQBu+HzNf5rZoXQq4Ua3RJrrmKXmCWpBkmZUa7WiWYlQEKLg==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(42112799006)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009220027099003)(261009223327099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yxmNzfUnKGQvVYA++YWDYL+/s/p5i/g5zj+hVedQCjpF/CrEovDbJPwm9KowL7r6A/EWIr/RQJ6Al8gp4HGO9Fro3uevOFe9RqDiC7YXpZr73OwPvCeJNvqlwA5txE2qjAhDpuzbRBqMwVhFCpVbSPMteNZH9sLmKUP2BtkB5s5+BDHQ8fVVaZSGO2bFdoyEW0MvXc278pVRW/mtvUNTtNINwcaEvSivI8IBsshak6uQyOyCCQdExc8i3XOKADkfDlkcaqq7wBAhaUVXJAbxoD91qC+0mPkhJDBGCrKLktZnr0OALmd4FBw3PuNE0Lpf2jvw9O9X/sdcG0yMbwStUo1owvSPykqMRR46iKFnHtDZVuobl3HYBHg9wLwlA0xGaJHLJ5+uX/PhJugKAxQ2S/356T96sLN2B6CUhe8lA+e73ojv9SARSIaCpqS9tpFF
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:12:31.9328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9ecc09-3884-4e58-fc1d-08df464726f1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1624
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds everything needed to flash bootloader and image to the
emmc using the NXP UUU tool on phycore_imx8mm. The OTG USB port is used
for flashing.

Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
---
Thorsten Schmelzer (4):
      arm: dts: imx8mm-phyboard-polis-rdk-u-boot: Add usb entries for SPL
      configs: phycore-imx8mm: Add support for loading via UUU tool
      board: phycore-imx8mm: Start fastboot when booted through USB
      board: phycore_imx8mm: env: Add fastboot raw partitions for UUU

 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi |  8 +++++++
 board/phytec/phycore_imx8mm/phycore-imx8mm.c       |  5 ++++
 board/phytec/phycore_imx8mm/phycore_imx8mm.env     |  2 ++
 configs/phycore-imx8mm_defconfig                   | 28 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)
---
base-commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d
change-id: 20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-5386aaa4c520

Best regards,
--  
Thorsten Schmelzer <t.schmelzer@phytec.de>

