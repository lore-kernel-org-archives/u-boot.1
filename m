Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE3AD3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 13:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9115683B9D;
	Mon,  8 Dec 2025 14:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZhXNHqB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9111D83B21; Mon,  8 Dec 2025 14:51:48 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F70483B4F
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4437f1ca7b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B8DNC2C1236021; Mon, 8 Dec 2025 14:51:37 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com
 (mail-francesouthazon11011064.outbound.protection.outlook.com
 [40.107.130.64])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avxx64dre-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 14:51:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r29LpAIYqH6kqnkAYWy0dtOZ3xvq2HzScg3Ftxm7ertJylczWytsvHGKybt3urV1NYVQwOFnzC9UfYEk49WWkOQlbXyLU0BYmVpPVpl2jdRok4qYtzmNJ0Jrm75dPDAO1aWR19vl+2VINFPZXO1qOjBfGZ91a+rVvXuXZIHphNIGEaCnQir9nNivQlwRx7SS0IE3U7/rE5IyYuAPJQx5Dv/V4KYPLgu0D221sabaBByMqI3BCYo6pi+VGHduLbN3XS6D15zI37w/E8uW4XFIPwzv+e8ZJltlRXeDMZCykD0XnVeM53xwQ8TLhOP0rgtyFRxIEo0q54QfdO3Tl2rQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48zzgzsybPt74xXCfT8wdC++YGgAKXTbsdjPftSHo9s=;
 b=yF/annpcHgU3SH3Cq+i6toWjvP0KLy34hec2fpN75SIQiglK0ulTKdHS++nMc7HKPHIUkI0oJJHekKOMkN1qTvGVBMJoCB5drIpsXyFbXrHVFN2ninYvFHIQKxoCgk5psaP2dlJh0P3b/g33QUefUtbSbcHs92gDOpoYp/BRsHM5q92tCdA5+eHuG5EhGjCT9AhOdYD4GUmjp6yX97uw5tLnGiN5ZDLmCX1DPI4I5BtibwxLAPUGClRy6OcYdoFEiwKgqQbf2yiMJULOwgTcqc5ENE5JL1mwLbUHoulsS6F48gZ+rCcey5mN5gWc7d5T/htKYBA6BKC6FeZphrFjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=nxp.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48zzgzsybPt74xXCfT8wdC++YGgAKXTbsdjPftSHo9s=;
 b=ZhXNHqB8s2Q0vhH2McZx1g6DnD5tpzxbBNt8aiWebyl3aapcoEVQhdP6MDqUaG7P7gGahDeZiaMsXOEFUKqNdTChJRx5wg7Wg8/CIV1H6nhMtexBt+E/sK1SGUcgwHnTt+b3+H0JKaTOek3DwNl9QrR/bKyNvktXGibPgV2NPhZsL3qXi/1b969Qz1PMr8GgxShhItFEvrUOKbK9gnPpxB1jo31I7LfNaJi21PCuFa4q/xkDAZRa4GATtAh8PfIXtna51KV6+HPMVwLAKgRz1uPb2YZMvHKRw5tPVpOJUL3QKPtwFUNsalF1WeF2YWk2g37Zl+/6RaAfnu3ViAZJrQ==
Received: from DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) by PAWPR10MB6854.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:33a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:51:34 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::35) by DUZPR01CA0220.outlook.office365.com
 (2603:10a6:10:4b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 13:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 13:51:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:52:13 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:51:32 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 14:51:27 +0100
Subject: [PATCH 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-sqqs-v1-3-290f0594e30b@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|PAWPR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: e91f223e-ffb2-4b56-4d3d-08de3660e60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bS80TEN1K2FaVW9aKzh4ZWxNWFJGeEt2RDJRUW9MYThhM0lCb0RqN2VyLzU2?=
 =?utf-8?B?QlRpMDhsT2N5SWZCaWJBRlRDZlR2bkZUVTJYZnpJR0FOU3ljbG5RNlR2U3RG?=
 =?utf-8?B?aUtSSlZxQ3NlWGdWQXNXa1oyTWQwLzM2WHJ2VFNSVTNmcjhqdHB0TGxmUzFt?=
 =?utf-8?B?SDdMb3Y2NmgrSEl2d2FBdHY0MExEUTJzZWljWTc0VVkvaU1RdWJvSDR2endu?=
 =?utf-8?B?UG5md24yZXdtOHJzMi9hbHlXY3Z6N1crenl3aXQ1d3pQbmFhcWtjcnhnUTRX?=
 =?utf-8?B?UG5ubTlzcEVYck5RazlmcDAzNC9WNkdhOEdRaGVqd3EzRHpwclhraHVGc1BX?=
 =?utf-8?B?OGdBdXgwQTVrQklnMGV6SW5mUGhPQlVLYVBVMnd0Ti9SOUIzZGNydURnR0F4?=
 =?utf-8?B?NzdpWDczaVpHR2F2Yy9xRjR2eXlPOUtZVEY0TWthakhFWklOV1ZWOHh1V09o?=
 =?utf-8?B?RnNRQnNlWlBwRGxmcDRESThDZlY3YWJzSytuOEhrQWdBQXM4NEw0MlU0RVY3?=
 =?utf-8?B?TTJpQjhYQ0ZPUU5uV0FPK0F0N2RJeStyRTIwQk1kMitKTTRUbk51UUJqSkFo?=
 =?utf-8?B?QWJRYUlQREovM2RKWmVkVWp4WHVWYnNydThMTU9Eb0ljWndVUzdFa3Z6djdE?=
 =?utf-8?B?TmRNb05hTXpEdGkvSjhYQit3R0Z3RWlFUFFqT3JPM2JHTG9vNWRpMEFkS2tu?=
 =?utf-8?B?VndmK09KanBDSHdJUU43bkVMRWhBM1cxUzFQalZQcEp2TndWTVl5ajRXVmRQ?=
 =?utf-8?B?cmZra2w5UzNlL0tldlVJR3ZqaVp6N083bkFYcVFjL0swL0hvZUxxMWp5bDVE?=
 =?utf-8?B?bU56elBQNWE0ZjdGbGRJS0trdXBlUStNRWd5bGZkQ093dXo1ZmJiU2U3bXRN?=
 =?utf-8?B?ZXFRS3hDQ3JYS2JYUmFDVFFvdzh5WEJxWjhacWhKNjZYbHA5LzBVU0pUYnE1?=
 =?utf-8?B?L01QNHBtejN2Y1B5QU1WSzJlNzZVUHFtd3VMa0JUbm9vRzQ2V2FhWnRNRkFK?=
 =?utf-8?B?Q2g5U09Gb05oOXRGZnZDVWs5ZHplbWx1YmZGUG5JbmFrRW5JM0xGU3hYMFdp?=
 =?utf-8?B?ZHp6cHJOQ2l4R3IrNjJzMXc3THRVTUJVNnExc1BBejA5aXFibWV4VTBabXZv?=
 =?utf-8?B?cmdJMWFDMmtFUVZqYTNpME85Yk1QdEhONVFZTEhBYm1iaEpLcnBIVjk1cFRh?=
 =?utf-8?B?NzFoSThMZUlzS3F1cG4xdEVsMS9qMlNBczRIRzZMYVlzMWtoRU5tblRLaDd1?=
 =?utf-8?B?M2x3Z2J0ZDRKd0pWN2JXVG9FbG90L1duVWdYeTF6L2VqOHFkaUo4bGtIdHdF?=
 =?utf-8?B?cGp2bDBUMmZwZU1KUTRwd2NsSDlISW1CT1ZDNzBGRWhON3d2V3ZNVnBwTUhM?=
 =?utf-8?B?TWhvaGlWVThETERQQUZCMHVNUGxDbS9nalorT2VtQ0Z6ajdacGUxL3hTQ2d6?=
 =?utf-8?B?aG9NOEpYSDQ5bElqTTRYWHNjMWFXK0JQMFMrNEJYd0tRUlBEWG5aOFZVdzVa?=
 =?utf-8?B?Vk5pNjYrRDRnK21ZYnhtUHkwZVpKVit2NmlHMjRJbkFoUEhxS21aSGFhaC83?=
 =?utf-8?B?Z0I3UGRaeENDS213bnY1VVBRdmIwZVVKa1VjV1J2aUIySUQ0SFZYVUZqd212?=
 =?utf-8?B?K05qSkZPVFFZSUF1YklHNzZOcURZOW13TXhCTVJGOXRWZHFSUGpVVFJLNGQz?=
 =?utf-8?B?d1lZZERVYnQxbEd6Y3dyUTNPMnhsMnUvWFNZa25Mcm5DK212TnhoNDdIVTJy?=
 =?utf-8?B?dEx3Vm1lK2MyQWhyMGFuQzArdlB0Y3lJNzRyNmxLQ0YvVE1BTnlNTHczY2gr?=
 =?utf-8?B?Skh4MnBpL2NZcXErVWtrRWtISkpXSG9WZ1JrZFMxR2J4emdtSFNHNEJkWmpK?=
 =?utf-8?B?ZHRNenNHdnI0TGQyVUdlMHorRDJqM0U1ZnZuak5aMm1FUlQ1c29rT09vV2dz?=
 =?utf-8?B?czVheGhVaFY2L3FDaVFiTndDV0VRaWVlOGE0MERjK0lKRnhrbkhqcit6MDE2?=
 =?utf-8?B?ZkdtNGlkWG0zUXdKUktkcFE2ZVhaQ2FZZkh6cEFRc3NqaW5iTlRtTkdxN2dS?=
 =?utf-8?B?RG4zOXJjQWNlV21OREt4TkhYR1RtMHdGcmhzbktqVWx3UzVIMXJreDJEMGFL?=
 =?utf-8?Q?FXrw=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:51:33.6202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91f223e-ffb2-4b56-4d3d-08de3660e60a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6854
X-Proofpoint-GUID: ZcTsGGV6rimo0Ddl56WuYl9Ip5ZTXnRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDExNyBTYWx0ZWRfX0UM/AtevkFrl
 1GAtYbqs2ri5ske7hOgZq32RhWCvz5BVjqM/E5PusxFnAcUOlBCecCX48ZpWzNa7xi5GscJZ7MH
 SaWQD9pLWggjQ9w5GtxUXEeyJXDtBZ8Dqa9xqJg44N6UQuwg2EpUvPb3LlOQVY2//vxoeKTkAKQ
 4b88dCtBQm0MAqcJQfejH3WtPN+6eTnkdEfDdLw6YgA5B64ieL5EQ+zd3MSOFkS+J0qNnIfMWhy
 Zjbmp+i/7ZgncpQZatFEw/DJ7DBV2WLaJmPgnlzUWMAB/6Xhd3fmM/9Ozm/5P/d37KZqpNtfVGG
 iyXGM8Q36GEFRPoyWmxCL96M5pakosNMwVk/75NFaCe8DiauyluIbd9JbWl6i11spaI+nmKAg+f
 lxWDeSwNETr3NvDCHyYUeDH0k8//ng==
X-Authority-Analysis: v=2.4 cv=a8M9NESF c=1 sm=1 tr=0 ts=6936d7e9 cx=c_pps
 a=4djRDh0jqsdYr3kOieHabw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8AirrxEcAAAA:8 a=b3CbU_ItAAAA:8
 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=CfLOgkDlRiNpbL2KJroA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: ZcTsGGV6rimo0Ddl56WuYl9Ip5ZTXnRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
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

scmi_generic_protocol_version() request is done twice in scmi_clk_probe().
Remove first call which is useless.

Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")

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
 drivers/clk/clk_scmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e1c20f2c47c..cbd44f310b1 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -339,9 +339,6 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return 0;
 
-	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
-					    &priv->version);
-
 	/* register CCF children: CLK UCLASS, no probed again */
 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
 		return 0;

-- 
2.43.0

