Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C37D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 13:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C984183BB1;
	Mon,  8 Dec 2025 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="iJwTkKXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7904483B43; Mon,  8 Dec 2025 14:51:45 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743E083B21
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 14:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4437f1ca7b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B8Ddwbx1815432; Mon, 8 Dec 2025 14:51:37 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avagaxdsa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 14:51:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfkbXEtU+w3S7rO6+ay76NUNQC1d1wFoHsbYfCipYOp3AeiwEI4LiL4ScD2Ay91DvF7psNMCcLw1Cl60RP7HNl6Jt7iaR02zgXSQh1XVfq1Il2YFKriv8xyuwmvZ66Gw550L3qvR5t0bgr8TvSUu+qXEUPEXIvGbyVR4NIsylLJsgC1DgzaqIoOuxQkv3VycxiAfl2r7Sp/lIFghOsEzSPprRXl8n7nHiOnAqOfndsm079ZoPiYfvFaSY50ORUp0LyNG1IvToOPUOwt6AaGO0l+w0CGzhErGd2/TuHseM49FL7geuKAxX29tkEhcSddF0sPNtQQUhE/H0ZWHRtmj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivhne12Rr2FkX3trGMqQbVrxmjsaZm5YsYxB5echuSg=;
 b=auVihA4uiSA1WBfXa/qZNfIlqIC9A4hH4mQdWuHniUPB71TdmyN8r/4juJzx3l0ztjI1QDKTq5ZCPFcDaMtgkDcQc+EsAtpLryTeYBvN7sdM8ENCLXfdEe2pGDFNU2gfSMW0dV5xar1Xnc1LkpJJ8EpOMzourKK8rK9IvUAR27QHQIydu3dD2HMMu64sdgtmnLMxMrsiM2KMsj/l8BpB6zTH4Le2vTxDulQ+LUGOT+/SP4amPKs+LWiC+SW1atuJ/4SE0QswX4J81zNRAxrsH+x1Zyto7QJrgM4C5/RBLNW79dPXOPf3dyOxxTlKf0UnTf/MTqLAbRbB2wAb8QRBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=nxp.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivhne12Rr2FkX3trGMqQbVrxmjsaZm5YsYxB5echuSg=;
 b=iJwTkKXFu/HWFgq4jsU4uqszUwxhNQRYD87HmVXPxnp4q65cs79iD6m9BNuDRQfk/jHH33kzSVbHMAKz7R8Gzm6qVAuENnMB+bFGGeHmqdwgGfg5jdimsoLZPHT4SMC3w+JlpOrBXHngz8Q8RTHUdr5PFe80fspZgfF8r9zkxj3haEEUvcZTwaCGXmEtvrt8kSSrq6WkNIGvzGMRgnoqSFcx8dkjZmHrabLM/zB2PE1JU3QyE7wm7hLo/yyS8qvEn1+2FmxsOgg9CwDTUSjJa/Vi19lWoReq+dBANslIwT+9I8tIWtWB5t8tUHbUpYCaukFjoCWsN4AUoSG7zOgfsg==
Received: from DU7P190CA0025.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::32)
 by DU0PR10MB5146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:51:32 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::e2) by DU7P190CA0025.outlook.office365.com
 (2603:10a6:10:550::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 13:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 13:51:32 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:52:11 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:51:31 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 14:51:25 +0100
Subject: [PATCH 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-sqqs-v1-1-290f0594e30b@foss.st.com>
References: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
In-Reply-To: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|DU0PR10MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: bffe9657-cef6-4879-f614-08de3660e52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDBzS2FPZ1haZXJzT3dPMDlPZnpRTFQ1NEVOdlViTkpWemFFVUtMbWtTRkJW?=
 =?utf-8?B?NEJ6N2w1VEtxTE80NExRRVczVUFwaStVa3RURnpuMU05eHl3Zm1VTUFnN2tN?=
 =?utf-8?B?a2MxaURKR2c1bHhMeEhLcko2OVk5OUZqd2c4S2NPKzRjV29yUFZ2dy95TVlQ?=
 =?utf-8?B?TjRDSmNtUzh1eDhobWttZG5JOHJNdEZMZ0hxZUhoUFRaaE9KZlZEekF2ZnBz?=
 =?utf-8?B?ZjRjbHp1Qk43VDZlaDBuTEJGNkF6aEVLMDdqWEpwNDJUQlhlZE9HRk5ZaCtL?=
 =?utf-8?B?OWxzL2RPYUpaNi9Nc3NxU3hYTzdjRUZpU3VzclhsejVsTDgrS1Jjdm0rQUMx?=
 =?utf-8?B?eWxiZkVza3lqeVhVQVcyRUhWQTJ3azVuL1Q4V3E3OFpJUElpZ2d1VTNnNGVh?=
 =?utf-8?B?TDdKR1FCZy9yQ09YL1hoNWZRMjR1MzNENjVCV2JZQUY5dHZta0RzNDgwdWxx?=
 =?utf-8?B?ekRsd1RkUHFLd3pqM3B3eHpRbzRJZjlXZU9SYlN3eElGZnd5dGowWXdCd0Zl?=
 =?utf-8?B?R0Q2dkVIaFVXczA0Rmh1UnZkTGpVMGdMQldnVFYyUHJYc2YxcXV3a3pLaExz?=
 =?utf-8?B?eDRtby9qZXRySXYzQ2N1RnRueUV5MjlodENEaUVEMjZYWTFmVTZta1ZVSHU3?=
 =?utf-8?B?OHdRMFVLU1YrV3Z3U1pmaUIrajM1bTRvSW5GYUl1cFNvbGdRQ2NTeUZPVW1M?=
 =?utf-8?B?aSt2ZlVqVk4ycjZvNzZaQWJuTE1oOHBlYmI1cHpveFFaTVFZRHdZRXVId1c0?=
 =?utf-8?B?NE9SNS9RVWVHRTU5ZzZ0V093WVdsM2pJbW9kV2ljbncxYmp6SkJML0xoczZ0?=
 =?utf-8?B?VjNaSzFDRWd2OHl2MmhHc0MzNWMyNVgyYUZkZnF2NzdiM1NqYk1zTWhKbjZi?=
 =?utf-8?B?TzJIL2xWejh2UUd0T0t3bmF0Y2MxM2p2YUJmMCtBc2NvMVFyWm9FRW9WQk54?=
 =?utf-8?B?eWlpbU04ekUyaEJ6a3YvOElhdSs5WFg1bENzbjlTaDhHNTU2TGN0eWdmRkgz?=
 =?utf-8?B?M3ZMWFE2OUZxVW9qaW81TlFZK2VmRmpxL1B6ajJmd2RjL1k1bDhlK0k4NFh3?=
 =?utf-8?B?S0RRUUNnOThEa3EzTmZGTEVYdjRzSzhuV0ZlRHBJellBQVpnM29pYkdIZzJZ?=
 =?utf-8?B?RSt3ODdTSDJyR2lEc1IxeDZqTHh0UnBtMUlhWXdPRVBzZXJsSzBvZ2ZmOWhq?=
 =?utf-8?B?RjNFOG9jNlhYQ1JmSUZjcU5SSlhnME5lbjVINGExaXFuZ0o2M1RnUkY5Tnlm?=
 =?utf-8?B?aElVSUdDbEZIRlN3ZTJ0OHVNUDFHQVVrdzRtdFBpK2lSNjZWVnNTMGdjNVZr?=
 =?utf-8?B?REhzaXpGclROMXJXQ0lMNUtWdDVYZHE0QlB1eXZTM3pWcEYzWThFRXVkUnBS?=
 =?utf-8?B?V21mbk1jSUk0UjlVMDlBbHoxcHluNlorWktPeE01cWxTQlFoVWxNSnpNWXVT?=
 =?utf-8?B?NWxBdmdxZkRhM2liaVF3RjIzRThENGhVWDZLblFnZHRlQXpXNDBjUGNEeHA0?=
 =?utf-8?B?MWFDdkoyaEo4Q3JBL0QrV29GVVcvdGxWMGlLZm9vVXVsMnZHdkZJNURQMTEz?=
 =?utf-8?B?Q1UvOFpYKzg1eTFBcVZGQkZHeUt6L1pybFlPNHpMbFdnemtvOGMyUzJWNzNN?=
 =?utf-8?B?Q01BWUNvZGlDUHpMNktKVWJHNlNZSDJrU1RpN0ZIUjJWK3lNSklNQlpDMUhO?=
 =?utf-8?B?aFhvRHdyLzYwUHZFTXlEVWt6Wk1Ublc3c1NHS0xmTkpHOS9xTCswaTRlV3l0?=
 =?utf-8?B?SjA5akdxdkVCNWpRVlpIUjc2dlRaU1RJZDNDaGJvQWhpOVdmSlpBZWlPOGRW?=
 =?utf-8?B?YUQxODg0WngyRnJqSmdsZ0dIYm5RZmdrcVB6TGNrblVtYWhUSXlEaHlWcHlX?=
 =?utf-8?B?dGExbWJNT2lHemJPQjVXV1RiWGE1VlhxR3lGd2ZMZGd6UFlySjhOeVk4L2J2?=
 =?utf-8?B?U2tJODhFeTZleHVIbk1BU0xEbFh0TWIrY3RnTW85WlNKTnNLcGRLbzV4ek9p?=
 =?utf-8?B?OXM1NnZjU0NtR2dlTE9PdlZneDkzK0QzUVhRVjZDTUVKYnRPUFZ2Y2lTVm82?=
 =?utf-8?B?a056UENuR2UzZmlzS0l2cUF6TXc4ZWRaNVNPbDJId0lMeW4wYkNKUVhkQ2xW?=
 =?utf-8?Q?5DLg=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:51:32.1672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bffe9657-cef6-4879-f614-08de3660e52a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5146
X-Proofpoint-GUID: W9bHpKoxf_tfcbtqQQVnzxmHZDCeOtCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDExNyBTYWx0ZWRfX8HCa12Zi0Ssf
 SizKHD6EhCaa0GMfuImTo3pLH3mXg7y28uD+X5h9nl0T9w4EXbUUks9doGmUYPF2r/TuK+GywbF
 L2Af7iF+Jpfar9VwyuY08/i6G1H5Jufi1BPUnWHwscChhI7rZdPIqhxgICfL04OXYxOtINu4EgQ
 /h44txUjvFP/UDl0Ykr3ata7zb55RqlSLMvv8Pmm5s+QaCuOEa1rnYXFX2RBG3TaiL4B9m5nfVd
 XrzDUf8P0uKlWQqVevY9U3PNC/HXO9iaGgGgYdIta1LgTfABHYXSbGnVJGANHU6gixixFpsiSu6
 PRu0BuL66cqPQNfUld7OxfBpkBUb9ekn+q2Xv/KxqHTdL5wDkBlGkd+H4OShVIqNA7vEb5ROzEN
 HK0tkQQ6JZb9zWrPb3Mtpw3v1lwz9w==
X-Authority-Analysis: v=2.4 cv=D4BK6/Rj c=1 sm=1 tr=0 ts=6936d7e9 cx=c_pps
 a=afzZXF13CKWydTy1s44jmg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8AirrxEcAAAA:8 a=b3CbU_ItAAAA:8
 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=PKYdX6cT0oTbK6WKNVIA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: W9bHpKoxf_tfcbtqQQVnzxmHZDCeOtCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080117
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

%s/scmi_clk_get_attibute/scmi_clk_get_attribute/

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/clk_scmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 683ac822a01..f6132178205 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -87,8 +87,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char *name,
-				 u32 *attr)
+static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
+				  u32 *attr)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
@@ -183,8 +183,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 
 	if (!clkscmi->attrs_resolved) {
 		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
-		ret = scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
-					    name, &attributes);
+		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
+					     name, &attributes);
 		if (ret)
 			return ret;
 

-- 
2.43.0

