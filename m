Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11554D68BEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64EA383C2B;
	Thu, 18 Dec 2025 09:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oG3/8e2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659A883CEE; Thu, 18 Dec 2025 09:26:08 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDBB083C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJz7ECH7oKV8HEWyyNklnQS8en2wjeq7Gx5jetAorT7X3bktFrjIwDrRIJzJRSC+79pFWwC9MXi/+xtMqVObwJ9wINdxtWx8tmRCJ6jl9WsWlD4z+Zyd/+G/e7RLEEBjs6Z1/SxHyYkEOtlbj6hb09pSZ9bSdZXjSRhDkjmSGVPlnfVSKAbV5dzasqoxzS9NEmGrZyVAkLGhLn2+dbPqk6B2US5W50ES5akzafAK9pQ3MjvfzfZAy+JIEbKQveOt6viGOD+jcje++eux6e8Na+UgsFB0lM4qtWMSG0yahzObNgitnotuX76esj7IPOE3oDCTrkUoOa0Hd1DSUXmubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G600uXhKvKDTdrUhoKDNClsHoWozWr6HV6hKWuTma4E=;
 b=ZrOuBvJYj1e7zasP3V5ePRHlYUFMwNo/6gJTHfepmtkMc74plrWb+y7apLKAVXe0vFZ1aJ0mfFnbIBKyl+SckMOwNFLFShe+CW9nJ1kWUA9Vl/803RNXuXa1IHulPGMxhPlcKiNInWzjoM0RG2HNQeQ5Jp6Yw0ISKSE3RN07ZzeMPfsQ8VbAMns+yhEnc01nePthcztDwTMms8CeUcCOmc5L8pukhX2ZzXO7RJvb4ZuNa5E8873Srp9dvANo6pZaCVOLCLXzXT0hRMH6WyUtDJN8BffF+7f+CGehbqrXBPgG9/wmmVklxpPa5T1n9DlvzrsdkvrYp5O8xJZ9+n+Mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G600uXhKvKDTdrUhoKDNClsHoWozWr6HV6hKWuTma4E=;
 b=oG3/8e2/BKpz+KKA/LwPvThnII0hK5y2eNJigZI9TxaMSCcjx7T9QVSinf+MEEPItys/GRD0kmJwapbNEiulcHLZBo+nBcy8Zug6pS1lCsmaEiBSrO0FL47xLguOtAZctcU8ttusCvnOcquP5azBsU9LC7JCgwxMWWA0BV7LPjl7mdQ5pJ8/Sll9VKW/+dzCv/dYroT/pxfN68shAuke+QvO4QCxQ+wetaqhCXvPqOYtQ29J2b2zgbraKfVvu2TMGg+uMns/VAEcffIbLuDKxpqrrpAr6i7RKIUGPbBbkPJQgMhsfL5kthgAGBLP6bSZJqWtccqXhfRbicjLeL3GJw==
Received: from DBBPR09CA0031.eurprd09.prod.outlook.com (2603:10a6:10:d4::19)
 by DB5PR10MB7704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:26:03 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::2) by DBBPR09CA0031.outlook.office365.com
 (2603:10a6:10:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 08:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:26:03 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:51 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:02 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v4 0/3] clk: scmi: various fixes
Date: Thu, 18 Dec 2025 09:25:58 +0100
Message-ID: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJa6Q2kC/2XMQQ6DIBCF4asY1sXACEG76j2aLkCgsqhUx5A2x
 rsXjQvbLt9kvn8m6MbgkJyLmYwuBQyxz0OcCtJ2ur87GmzeBBhIDqymOAxIVV0La7wVXiuSX5+
 j8+G1Za63vLuAUxzfWzXx9foTSJwyCg3zTDbCVcxcfEQscSrb+CBrIsGBcbkzyKzRXGoApsCof
 1YdmdpZlZmvBJPegLbcf7NlWT5qyqv2CAEAAA==
X-Change-ID: 20251208-sqqs-7884dbfd4fa7
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|DB5PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa793ab-e83c-46fd-8229-08de3e0f1555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDBTUm5JcEJHTWpJZzZXNTZVdjBucUI5NkMyWHJHOWpxVmVJdVdDSVNBQlB1?=
 =?utf-8?B?WEpwSER0M1NlWTZsamxhZFNWclUvUGpsS3lKVndyb1dXM0FzNnA5ZkZOMUd4?=
 =?utf-8?B?QU4xeWpyMnZNcmdjZHZrazZVZHo1Y3RwVk9ZUnR1M3NxVVhIU0hYYVF5ZXUw?=
 =?utf-8?B?cWNmL1g4dWxiaXdiRDlXYUxDYlNoS1VZUi9oTlI0aFRzU1RWY2IyZmd5OWVo?=
 =?utf-8?B?ZkthWjd5ZExGVGI2em9uT05MR0Q5WFZmMmxZNWxqYTJsejBwbndtK2NLWXVB?=
 =?utf-8?B?S1BKMnhXL3lFUTRDUit1VUs4UnJXeTNVZWpGV2xsWEtPVnV2NWlBZktCT3da?=
 =?utf-8?B?eTFKUnM0NzhlTGlqWHRpYkFXMjFpeWhiNXJIdU85TVB6OERrekhnM2dodmcz?=
 =?utf-8?B?VUMrYWlySTkrTXAwcHI2dC9WMDZ1TXBWZ0M4SlF5c3FOb0JYMFpEZWRMWEN2?=
 =?utf-8?B?bXJhTHZIWjZGM0NudjBidVo1SUkvQXBmRVQxSlg1cnlTcldEbk4zWkFwUDFB?=
 =?utf-8?B?cFhuSlZxekI0M09WNUpBeUczMW5WeFlacjREOHA5OVV1VGJoWmdMLzk0WnpH?=
 =?utf-8?B?YjN0WDFoU2s4WFk1M3QrSzdCYmd2emd0MDRqMzFTV3JJaVhtVkZZeDhSOXJy?=
 =?utf-8?B?VGQ1SEtuSlcwYlVoenMzSVluRkIvZEpFbGthY3A3V29VeFhqWXgwVXdGOGFw?=
 =?utf-8?B?YVY5NHhMbGtVeWlEd3FIOGt5VVlWK0FEWWd1RXJmUHMzZnEzKzg0SGRBMGxF?=
 =?utf-8?B?cE91SkNmRU9hOEV0RVVlRFp1MlRaWDJSN2drSkljR2t6U2tDTkJBYU91dGJp?=
 =?utf-8?B?YlVLUWtkQlJZdWwzek1XdlBIaW1LYW5sZUhJd0ZBMC9zS2JQMXdHTUMvMDJB?=
 =?utf-8?B?OFBwbDByMGR2bUVhNjBORTJpYzFTMUhjREp4ejNHeWxDaVhwQWxaWFQweEtO?=
 =?utf-8?B?NWUvcHdEeVVIcFpRRVZTMnRTZDlnZXI2WkRUaGNJcXV4VGowWUJaMXVtUDNB?=
 =?utf-8?B?VUtuaHAzU3RONWtPYlNTSDM1L0pXa1gwS01jdWYxMUJvamhrQ1dsM0xMS3ph?=
 =?utf-8?B?bWxWMXRyd1phQ1NGbUZYeWpjbnMzR0JyNStwK1BKSTBYWm0zSFMrek5sdTFU?=
 =?utf-8?B?Ui9FNHNORkc4MDNkQkNRQXZWTlE1RWI1U3lGdHVxd0duaGhvMXc3SGQ4Q2VU?=
 =?utf-8?B?RnZFclg1SnJXRHRVNnVveVpxWjcvcndxQWlVQUErOWNlTkxlQ2FtQ1I3eFZi?=
 =?utf-8?B?a3NqRWc1R0NXT1VBSGRKQlEwMmN3UVdzc2F1YS9YMlFhNTE0TCtOZzd5MExw?=
 =?utf-8?B?QW01ZllWWDZWV3FKTElNUUVtVFFYT21NOEhhQlYrenFxQytDNWdpNGlhZ3Va?=
 =?utf-8?B?YUtVMHZuVWZSRnE3UkJ0L1BoQ05IdXYxV2dRckljS2Jlc2dwb1lsSHo2THFL?=
 =?utf-8?B?L1BCa3dBeG92QU9GVTg4d1krTk1SanIxcTFPZmNoV21Ec2RKeC9CK0xWUHl0?=
 =?utf-8?B?UkpMeENpZjlzTTdZSWhCY1Qva3BRblM3YlNJSnFCY29wUTAzVy9iNzlzMzBr?=
 =?utf-8?B?MXQvY2kxREUwb21nZndGQTZDUGpTT1dtcmhkcWtYOXlkVUJyR1M3ZXRqRENO?=
 =?utf-8?B?cC85aHFRWlE3VnE2Q1lEbUtubmMrZjBGbDRDWlZBdHB0UUJnZ2hZMUQxTW5h?=
 =?utf-8?B?amx3OGVkc1VJZG82cXdiZjltK0R3TWRUUTRCSTRKdU5NZW5sUW1GZS82Q2VW?=
 =?utf-8?B?VE9pblVwOEtsa0FTMCtGRWNhb1g1R1Q4U21xRUlIUGJLczlkRHJpVkRWVzgz?=
 =?utf-8?B?N3BYK2d5cmxKQ0IrOG9ocWdsS2w5b04yNVc5Wks0ODZJSW5qUVA3V29XRzZj?=
 =?utf-8?B?ZGlkYkVhOGhQNjlhZGZJRHBWUGFqTXZ5VmRNemdtZ0tmU2lyQ094cVZxUHR5?=
 =?utf-8?B?Qjdta3V6dTZoZ0ZtVUEwa0wwNTNFSldjV3VYS0xrWXJHNmliWFM1Qmp0Zndj?=
 =?utf-8?B?cWZSSW9XS2JiaERsVjF2bGVOWTI3RjZhZHJhU1pTc0F5Qi95UGlGS1dLV3VJ?=
 =?utf-8?B?NDI1bUxuTzZmMjMzRmxkZ2JYcEN2TDJnRUFwSWxBcXVtRzVpRVlmWEkraW51?=
 =?utf-8?Q?VVZngxDIRRZ2DBPE1fLkbb45M?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rFkE52QCorV+J4MZ+FG3tV8zg0NorIcnrfu/3erN5ikC8z3o2v9fe9CmfQwX4qGS3LFYyrIEXljP/lvvrAziUUcnvDRSMHIRIXSKvHjs5yheCd857V7w1P/8d2RRJ6m0wOF3paf1IYlb9ytNLW0/eBeuhbhXztw6uXRvGnQZC5r8Uq/9rhl2L+On/LP/eNsvUqnCVUoDBO96cO6iLNnWJpN19q3YXc0zQgOipSfKKwS/VFuiPnqi9uJqPQJ+YVBmvxcH9YzzXOXBlLqVGeI+1F+nfH5p3I0b1WFJTCG311pFDYnfgSitIKdjyCbgKRosVAoSoHtbP8uEzcfPXRu0hgUvH3NlMJ0WkPvpeL0+w/rn4BQ71+mCnGjZO+wB7myi+U5x5ixVjubi2+3+9db505kqhlI+8Sn1wAw2xPctKnExCvhGoE9BjLC7QTJ0GGcEWbb/8W706XGuqT6kpvz+bgNGtdeWephP9+SuU0yv9SkWekn274n+aWW6wKiqrvPA8vNeooW2ahhEeMsngCpzEb2+OkFN2qlQZ2NYSee2vmx+nDBXQrpWASORvIKjwejcQk0LlG4UaHNu4BMMSYuUMD53r04LoryXM5Dr43Se6ilPBmkVXf724zVYRkW5yTzeecI/lfOBQHZopGip6s9eVz/o8sy/c6oE/y21MtFNnrvET2PZk2C0Ohp9+S9Bqffvu+FILsAdbQyPozSPVgIuAg==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:26:03.5435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa793ab-e83c-46fd-8229-08de3e0f1555
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7704
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

- Fix typo scmi_clk_get_attibute.
- Fix priv initialization in scmi_clk_gate() which leads to
  clock_enable() error when CONFIG_CLK_CCF is not set.
- Remove duplicated scmi_generic_protocol_version() call in 
  scmi_clk_probe().
 

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v4:
- Update commit message of patch 1.
- Expand comment of patch 2.
- Fix CC, AB/RB/TB tags.
- Link to v3: https://lore.kernel.org/r/20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com

Changes in v3:
- invert CLK_CCF conditional in scmi_clk_gate().
- Link to v2: https://lore.kernel.org/r/20251215-sqqs-v2-0-9a15a22072b7@foss.st.com

Changes in v2:
- Add Peng Fan's Reviewed-by.
- Add comment in scmi_clk_gate()
- Link to v1: https://lore.kernel.org/r/20251208-sqqs-v1-0-290f0594e30b@foss.st.com

---
Patrice Chotard (3):
      clk: scmi: Fix typo scmi_clk_get_attibute
      clk: scmi: Fix priv initialization in scmi_clk_gate()
      clk: scmi: Remove duplicated scmi_generic_protocol_version() request

 drivers/clk/clk_scmi.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251208-sqqs-7884dbfd4fa7

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

