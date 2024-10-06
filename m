Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C13CFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736AC88965;
	Sun,  6 Oct 2024 11:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PR1ZBET9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E9587C69; Sun,  6 Oct 2024 11:51:20 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B9288D08
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWAiaFMfW4/UjJdPFYGS6TcHk5arrwtqoCxcf4PpCUsa8bEqEfyKFM2rhm/02Xg3PXISdBLhyMmPkLzhVDhIgFDE+uWYDV1rG/1jWHFsihemM3vrvU1ibEHqnMii5mYSGbEaReQXnFPEFy9rsmXLPlmOJIJiNJ0VDWGH8AFPndj0roqnpdFsU223zvYZz/c1kPWPbDmkDXwYYGHzDNiUl62HHgvHCPSFJPDg5jTzOeUY9ieyF68/R31TgNPIR/fk0lTk/t2kvB3mPI7X/VKK13PYEQj9tq+yrSIiMw6ivfhLjFiRJLZfrX5EeBVDhIlnI+v1Wc6EuSzYFQQiCHHvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5MfaP0PajLRqcTMtgPoGyWpl7qV7dwMoaoAGA0EFeU=;
 b=aYdw2C9gwVFtBP9Cr0xdR1hv8fut7kySox1DxD47seQlAbKzNKdSGTiW4yI5bi76c4m5qMwApIOt+shmz2658lgWfEdBobkA5SXDyrzi7l9eboNra/mqqnhZ05OGYxkyctDcbUGtyolcxAwGt52Rn8YkimFHIHqYj1AJyUCbmzfuEqBl+bUexmpTHWiMjGaszIvl0CWn6ZtnTL9Ho0gdLvDZtnFZp4WlS6xDInYG6vkojlfP/uJxKcWU8hIP2EyuSmtK8HhL/7je8Omq+1gnUje2uDOKGBJAoMLOjHibxYSEBj8V0Wkvd5UDrSnCDJS7GA69wXsKNGPt3gPorTSGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5MfaP0PajLRqcTMtgPoGyWpl7qV7dwMoaoAGA0EFeU=;
 b=PR1ZBET9XFv/AKYOXSOso7xPVuZ/p50+PbP+oYQLLS/bO/6qFxmO8Nrf/y9IX53oUtVe5Z4C2ZwlQhjUbcdmdlmX2ZNWaAQRVZmrW0qvzakotO4tf54M+AhLZt3qo5bwgL0YQeDXmp6xhNFTn0dFR9ZIAjOYhu39OLXa8rWGv6Go5vWwSfK3Pn5z/Nt8XDs02NjlzEtHMKdvuGUhHuzegGIqlXRc5flfNtUDcpDaXiXpW1OLD7YxdXRaNv/sdtf4YfSAMpLazBogLmzISyZ1mPSJyaMR7NZKl5kIUO4l9HARcmxv4GoYxV6tjRTBR7wtkOS/XudQD5bz/6rLj5E/nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 09:51:17 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:51:17 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, alice.guo@nxp.com, ye.li@nxp.com, peng.fan@nxp.com,
 akashi.tkhro@gmail.com, sjg@chromium.org, festevam@gmail.com, marex@denx.de
Subject: [PATCH v1] scmi_protocols: Update discover list protocol message
Date: Sun,  6 Oct 2024 17:50:22 +0800
Message-Id: <20241006095022.2800641-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaae7ec-1764-43dc-374f-08dce5ec6c05
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLaVz1Cso/5lwMl7Th0QYYk59OWlSoNxQlvzgpXIMI5kbae9vMyLJ+xGpJVa?=
 =?us-ascii?Q?+r/UN8cGP4a++FBgg8CejAistXOzLXoISHiSO7i/AcAucfqsIrYTeSPeH1PJ?=
 =?us-ascii?Q?RF9LJj8ERU+3feoipEoihnWDOmZWzQNgtprSp/tKwPoIqpnmJ59KZwlMzKu0?=
 =?us-ascii?Q?ydCgYMkZfHzeH+8mGbSjMXGefWWK/CMVQovbwp1CNGP9BPn3Dbb72BW5Qf/w?=
 =?us-ascii?Q?VELfvncPdnuCnq/7o/wKvF8U/dq0beuLVHmtKH7QlvBXLnNAokySmlgEGcSs?=
 =?us-ascii?Q?gLLUPBVESrJuc/tsWzGbePbh95oWoX3kGY8TdNYeKr17McJ53N4wckL4lQsr?=
 =?us-ascii?Q?w8XCsixiVY9T4ayQuWwIH0pYCKU7BZDdjPBDE9ec9HmdCoIvbihJ1n8KsK+5?=
 =?us-ascii?Q?MSqQQuny9El0iBaT/ZKItPES5lJVlcqqi4MN0WvmBIUJRsL3pOORINWOp3nh?=
 =?us-ascii?Q?qSYtxvDa7dQKJ1qGGZVlY+SdfQqJWWLM9kzL7V+EMHTmYhLkO6s9I+iBpC9i?=
 =?us-ascii?Q?6T6W+r42XSNYNBA0gp70WYdh8D9QTcV6NWC35oNwJgR4FDQewS3p5UWdHsZs?=
 =?us-ascii?Q?OGGK+a3eMy3hoIRMnhc4h/uQUcOxxo03vsEDqJeg5XzxWCjpoIXJKwGf+NOC?=
 =?us-ascii?Q?gW0PBRXWApL4Ed4V/07BZg4kC2JfMbCJry3CJWDYW2cySOOfq3DyPs6VI3Ow?=
 =?us-ascii?Q?BkUKcny2DUXIehXaMl7L9MEhvHttAA+w1VvE7btnKeFsTfQXqIbzQciVSWlg?=
 =?us-ascii?Q?vQ3q1UQOgb1/d1VA6jTGOoig8AReEAJi5WH6nQbcTy5LeeO7fpTyZNvc3WkL?=
 =?us-ascii?Q?q/mQPzlslbcJkUFKE21bZ31yIyX7ATq6PYthboFhadT1NAMCCgxxnitglnHN?=
 =?us-ascii?Q?t49mVxsO77EK1T9RVukm1QlGmmmSr7qeJEiBP9AGORNDv8jij5e2pzjHUF/+?=
 =?us-ascii?Q?qZ1bPc/SfBiO/uvTQyhjVtxN/GMKnWw0e41hCYw7Tgay+IVXjHTPe0+Sn4nA?=
 =?us-ascii?Q?Gi0DR1/KatHQU/YszU7R0kGEyJs6dDf8c7SkqoUBTq4ouPQq6A8OuYy88Fqs?=
 =?us-ascii?Q?MTU63pRx02IMbTWQHz1Upi2on1S3Klc9KVIcS3QvU5absKMA9rZ3gVWSm9Ll?=
 =?us-ascii?Q?LRJycRz0rJFAlh4MQo5Yx/tCZU5vmd9cVsIoshxspmvqdxEJSWAQWdMZCjTm?=
 =?us-ascii?Q?MF1O17aV5enGk4AA6RqEYwuhuPD2fszphJkvVXloVVtTAQGiPrbKsZQ2FvMV?=
 =?us-ascii?Q?y64Yok5uM7+crktwIuCO3ufqqUICpH8haEBhd/WzSaeegLlKvqiq/NN6CWsz?=
 =?us-ascii?Q?+ER2KxYdYn7T/lnvZbplJS5RVjucwlqPR2RMItETYNNhJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBGP+eCCnaXSZCiLtHMhCzRV+qdLSvJGQwI3wAKW/IG5H8aQm0hRPDgH5zVk?=
 =?us-ascii?Q?WuZVfe4C79etX+URW7W8aVmhTPCBlotRVXaTw6FH+MKvF6NcyDJZ/UplFRrm?=
 =?us-ascii?Q?zGyj3HjzxRsRvV6f+UmynFpvlk+m4YjF+HcsosWvCRQ9RIdikMYEN7l7CYVC?=
 =?us-ascii?Q?Ffj5TjmnlJFCvwbrHB229LvbEd0jcVm+QJU/9zDhYLmowzFwsl60XAPsOjbc?=
 =?us-ascii?Q?qvgudfzKgknDDobtXHxr8FXdJ4t4Faecq986+bjavnFGq4vEYcVWKvQRxnYb?=
 =?us-ascii?Q?6zP6/h8GMfqphk0H2QI9aKNyXH+kIhCtzJ+5cQFYdXYHK5CRjRW7f1YRNVCt?=
 =?us-ascii?Q?NO63TtY3jmCaH8sRMD43taG2n5CWON52MeFMJJ4FfLGEddE7cLrk18fnH1Xf?=
 =?us-ascii?Q?VtcCOrLxeO8PhNBFGpta1BJMJZ+ASpxW6PfSMKWSbYkNFx/Iv0HzmDmMnzNt?=
 =?us-ascii?Q?TcUSBpSVoGI4pfqpg9hrZ577kH9URWeFp/gWlc67ss8BYSoCktbgUDuMKrl+?=
 =?us-ascii?Q?vbIdGJHR1L8N3tXSd0JLbL8LhCuk2LL+XVkpfq1a5P5NRXa5aB8awMsCwMA4?=
 =?us-ascii?Q?njKUVBinlLAGzruAlENSlv5S+kCbEt+A70N3JIL692oiJvtgmPsNXvT5QiV2?=
 =?us-ascii?Q?pv0QsIOo6bY0TAdSM0neHyJIauEa1I042WPC/H5vLFjSH935A5T1Age/wETZ?=
 =?us-ascii?Q?A3Ivh+DubxbYLQkIT0kcuPVNOZGpqFqQvzd/wVV0v9eX7CKdqJIz9Rqz9sKF?=
 =?us-ascii?Q?YOTISD/59b6xhEQaMt0Hg5nWoc19kgd2NfCFV78mRzZQm2KY8Y/4dyFDnFcZ?=
 =?us-ascii?Q?ZLkxqBJvsuV4xI+QYDlNyrrz2qE5f+5RllTFUx6JZyU+8bLRPl040U/9LY/J?=
 =?us-ascii?Q?xbNnt3+HQffI3dh6u4DTLdlti6WVJCKpN3OpY8GGrV/rdoOzaJNivYJcKs6L?=
 =?us-ascii?Q?vDdO6hbEdy94+5TGy5UJ+UaUgcabvwCdMjH97vT1A/L7+yx3lJkG2gYO5JLN?=
 =?us-ascii?Q?pRQBsRRbd4Ko/zRNb3LN6Wf5IwIoD+V7WTwsAKM2tOB9lILckUSoJ4i51lkY?=
 =?us-ascii?Q?6bRr/DgPInvQNDbBFboAUXilkdKY1oSAVwFhIQEFnws6TYHcTzNPyrxjfWzB?=
 =?us-ascii?Q?5HcZvoAnjEZkuRi3Yw8si9zPzq4/J39C1RxZ87iYy9Evc8o2vHbXnycTXwEB?=
 =?us-ascii?Q?dpyhhutKyHUGXw4aHw6XsE3Fanlrtbz/e1c3j3LTvSuvF38FQn9tAUKn6B29?=
 =?us-ascii?Q?FhmncrUZGY0IeUvg7jxti53d+K1gEUl1Fa+6kfKLUMazp0F09Lfm4d/nSO2Z?=
 =?us-ascii?Q?yR8VdeJkBNVl6PDlmhasyTUusImWIveO55wYbFyr1EmLlaUa7NAESNf0HaN+?=
 =?us-ascii?Q?jBHAmo2wZJYoEI5gFimtV4dO7vqZvkvyt7XcvKQACMHykJNJTcudI/9G2QmK?=
 =?us-ascii?Q?IyG91HtbwnelqdLUpEqOAEEZLGFroO5HpkmKj3G+TQo2z7q0wG5SmiGJdZ3t?=
 =?us-ascii?Q?P5MD7L2xLjBpk1KKz9JWtrSOCbLKSEE99i4dNrVR9stZhDHsZWNtIYuWN+5p?=
 =?us-ascii?Q?97xClkaoxd6SS2Cj4WQxSnDCP3jIsR8myuLgnhbr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaae7ec-1764-43dc-374f-08dce5ec6c05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:51:17.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h39pVMfsoZeIt/hbNmy1zR+xyUgjV/RKOvd0G1BCU9hxjn5gBRKD05JQ/yOvCc5ZxdPovHMJTPBB7uyM795EvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769
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

From: Ye Li <ye.li@nxp.com>

When work with System Manager, System Manager provides vendor specific
protocol, so the protocol array size is not enough.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/scmi_protocols.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 43b66be00a..6204ce076e 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -146,7 +146,7 @@ struct scmi_base_discover_impl_version_out {
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[4];
 };
 
 /**
-- 
2.34.1

