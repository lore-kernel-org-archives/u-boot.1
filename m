Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C09D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 07:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E6080107;
	Mon, 15 Dec 2025 08:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="I334xVC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413598003E; Mon, 15 Dec 2025 08:38:58 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2E8807B1
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 08:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=44443983bf=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BF7RDLG1900222; Mon, 15 Dec 2025 08:38:28 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com
 (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b11gacrs3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 08:38:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTyHBA1+JsBz6KyOEAvH/qFKkNQYOawTcff6h9qy3eOetDeQpQftPlDERStnk6/Eeu6oa3bjPPVmz41+kcf2WY+B7F4wk97OaJm0wcjosjPmqaUDiEOf2owrtIQ6BktEVUgzR2z6NCwpLZfUhgjrd1WdOhv8HIKDCU/BxJjno5tDMpz9fEP1ximG1TJdu62pweJllFXpxEP6/1qej1Tqe24q0F8ezK4vi6BJhwmWpuAod8UAF7cMLHbwFHrhv2rMXu6ca7to5VFzfp/cXIYsBBkq2mEQ86ulVCrzcnpDj6LVWER1CtT43zfsQ0i+z6VExKRi583JVjJ4LgLUJi+/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzvHfoPuIC71GlFy0HBLxFchSRhwEbrdMxuTPmj/57g=;
 b=uZJbQ+BI1x0VY6lk86IM58ClVgRfTF4Wk2MIJsyS7UnQMNkIrk5yimEvuOxF4Qzq+IWu1d9ipY9rbacQBfIolljGG1AHV6Df+8gkiVEHoV8B0QQv7/DK5c7v80DhHzXfwnozx3WAO5kBnDTA/7eVRcKx1Ts7jPDsVQWw/0slEltkvGwcDx91NeDwbUn/5AhqWyBTkF0LzLJ+2PStuOh7Bh3u3ssX2otfCefAebbRAsT1n0lg7Ds9zbgMosn0OOby+OttyK4xTX6OfHQ7DIf08QWzfKGOKHazZX/A1tjGAPEci4iN4p8vm5nNgCXB1trO9qIscP9qmJrgyrU6hhZs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzvHfoPuIC71GlFy0HBLxFchSRhwEbrdMxuTPmj/57g=;
 b=I334xVC71rB3wu7qVMz1ylGgmSW4B0c2TOvpferhSBPlBMDCNEGp2FjB0++NFSjR9WJsz11pAvHphnVbev42bYBzA/YHk9OesWW3CnILpczIK55sGd9NtYgzrsVo1Ml4WqR1C+LAVJDeT5zb/YmKW1W+ZFjI/sQRt6nXiyCPeUqinHpzc5txLpDYIsiW22V5352uxlse8guOzUMSXK6vKxhfYdrf+zBySm/zNr03qv2QEimAGcpt9+oXc57FztxUQqhptBZfPslnnA2F92mpBAzodFCBZDkhqkPjDKu0fPXauc6GEzz8/N5t3RlY44+1LsthWqY+2sZPcy4Rr5xaww==
Received: from AS4P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::20)
 by PAVPR10MB6838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:329::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:38:25 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::94) by AS4P191CA0028.outlook.office365.com
 (2603:10a6:20b:5d9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 07:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 07:38:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:39:10 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:38:23 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 0/3] clk: scmi: various fixes
Date: Mon, 15 Dec 2025 08:38:17 +0100
Message-ID: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOm6P2kC/13MQQ6DIBCF4auYWRczUIzYlfdoXKhAnUWlMoa0M
 dy91GWX/8vLdwC7SI7hVh0QXSKmsJZQlwrmZVwfTpAtDQpVIxUawdvGojVG28lb7ccWyvUVnaf
 3ydyH0gvxHuLnVJP8rX9AkgKF6tBj02l3xan3gbnmvZ7DE4ac8xd3yZ6imgAAAA==
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|PAVPR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0143efe4-7f69-4ffc-2340-08de3bacedf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ui9FVnl3QkhPeFlzVEZiKy9GNWtMQ2liYTIxS0twZ3Z3K2ZwRVhEMVFyM2cz?=
 =?utf-8?B?Z1FDRUhsZWZlSy85VzkzNjkyeGZTbkhZRUk4SlBrUDB2em5paUFPVWNMdVc0?=
 =?utf-8?B?bkpqdHJlaXAxNWJSdnRkd1Y2QUE5QkZ3dU45TjFKRi9BU0RGNE9BcEJMK3Q1?=
 =?utf-8?B?WFRIZ1F4ZkdaR0tZN2FpbzIwdEh4ZUp1bllRY3ZwWnRNOE14b09JUzloTUxH?=
 =?utf-8?B?M0ZBenlUa05Lc3QxS0UxRkxrTnRCM012SnYxV3lVQXJyMHU0eEJFdVE5SjVH?=
 =?utf-8?B?bmUvOVlEZ2d3QzBqcFZ6OWYzTElXYTFzV1REa1poMWhlYkZYbXdCRmdHREJ4?=
 =?utf-8?B?WnlTeVExMitnODU1ZmR0MERMMXlDV1gzMExZMGtPK1JjcWNzUUNNWXpwZ21v?=
 =?utf-8?B?dGd2dGo1bTN2Tk9UcWhnV2tpSEM3blZ3dmpWMFFpMmJBT1hwWXF6Z0JnMFVa?=
 =?utf-8?B?am14d2ZGTFNVVkhrN2pjOEtEYUtLSEJHa1lSbzVPbGhNRHR6aTJsdEFwLzVN?=
 =?utf-8?B?UkhSYzBUSG0xRjhCK0ZScE5JOU02VS9GanRwZlRvZHF0bkdOMWc4UklkR2Q0?=
 =?utf-8?B?SHl5TWMvZU92Mlc2VnVqYWJkQUZxa1FISVN1YUJDUTNTU25XVFRmQzU5QjJi?=
 =?utf-8?B?TGVJeXVDajFNem9sRi9UQnRnNXQ5TzBzdlNBUFZHdnlsVkg4d1pZdHV3YkRI?=
 =?utf-8?B?bmhtRkVJN1pzRkl4S1dwcjRWU0xqRDVCdncvMUN3MG90RmtJLy8rU24wTVBP?=
 =?utf-8?B?bm0xMDhFTE1mTk5nV2VPc0h6SUlzRGVnRmFDazlBWjd1T090TlJURkxlZGVR?=
 =?utf-8?B?QVcwQVJNWUxBVUpJN0hITDJCeTJSbjFxQXlOSEtwUGQwSFAyODhYVlI3dkta?=
 =?utf-8?B?ZlIxUDU0YmlUWmVBUFhITkdBSzJyUFlLZndxRXY4eENiTlVUM0o0VkJrZGs5?=
 =?utf-8?B?dWlmMmNjNEJqazFLb2tyRmY5WDlQZzZ3QXVmdjdIT3BqNVYwSkpDTk1PYVZz?=
 =?utf-8?B?bVRmQjdWdDlLWVFJZG9WdTRlbWpWSEhHQXFHODY1V2hFT0VGb1VGUitxK2xI?=
 =?utf-8?B?OFJ1MnlTZGNyMVVMakVUVGNXSWk2eG1IbC9GY1dVVWNDRi84SzVtMWV2MlJz?=
 =?utf-8?B?dmZyZkgvTk5OOTVzNlZBbjhRdnYydzNyaHNGMng5STUxTGp3YWltQmdCNXVG?=
 =?utf-8?B?Nk1rb2pDSTlTQUtYekFNay9tSjY5QW8zSWZxaDNMQXlLMmhCZHFjdjdINUpl?=
 =?utf-8?B?alU5M2dMelJsdzhtbXFtSEhCalN2dm9kcVJDb2NnMitNcGFQc3p4SmRId0RJ?=
 =?utf-8?B?QWR5Qi9VVmZpempyVkRXMC9OV3BhYnNnKzRPdy9sRmY5SkVrWUNJQnBvTXpt?=
 =?utf-8?B?REpMUFRXeWxUSS8wejRrNGZSZ01NK0Z4WXA5YURjMlV6ZTJsbkIwcWZuc2dm?=
 =?utf-8?B?NnpFRzcxc214YmUwV1VlUDY1emw1SHVFeEhhMnU4MnhESzBSdWxBbVFSc2cy?=
 =?utf-8?B?ZUF0L205S0VRdTl6OERuVVRWUmZTaW5DM01MTXlWNnNMTTJ3YzFqSTZZenN4?=
 =?utf-8?B?elRsanlPcHN1SjJnNFFDWU5kL1dLR2ZOTEZKZVpNTWpWU1dhRURTYVo0ZjZi?=
 =?utf-8?B?NVByWjVXWnZiVXFBOUhYQkZWUXVmYWMvdndMK1o0Q1FXdDA0K3ltWXZKWGxl?=
 =?utf-8?B?VmlrRDZUVjZlRlFvdVJjTTNEcEFKUmx2WmlCTXRMeWtKaHkrWEJISGZsY1lH?=
 =?utf-8?B?eDBJbHpiSld3SXgwNW9oSnNUYVR3bkxmZEs3aFZiT0xETFVUZ0NqOUlCL0s1?=
 =?utf-8?B?dmxQMTZDNVE4VGtXY1FQSFhMSXBWT0hjak4yMkpSNDVFQ1RjMnh0S25UNDFP?=
 =?utf-8?B?aXlLYndTdDlSNWRKRk1IQnp1czk5dEFmV3VNVDBtYXF0Ti9xQWpyS2U3bmV1?=
 =?utf-8?B?L3A0TURqM1VyOHhxMmc1R0k3b2lFWGZWZ093ZUxqSjFVZEpKM1k3R20zbTFY?=
 =?utf-8?B?S3dPRTRPMlNVcEw0cWQ3T1M1c09zQ3lad1B2Y2NueVVUaXp4SFJPZlF6bGFK?=
 =?utf-8?B?YU1oRjlNMlJDMmdqN25FeXMzZ0c5RmNHZ2wyNSttSG9qRTlVUFFhcDQ0V2xm?=
 =?utf-8?Q?1wgo=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:38:24.4981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0143efe4-7f69-4ffc-2340-08de3bacedf4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6838
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA2NCBTYWx0ZWRfX2Yg6KdN7oB1r
 j8v1KvGSOjcP6x/ULLINHg46Tk/sRiLrowfqZQjUrq8mEHq8JLe8K2yRT+dqv5CepvbEJp+zL2O
 Q4ZBlLG7/OP1HHJNB2+W8haKDj7A+NnEpjU23mRFwWhRjZnELqIk+qew2GrPZB7WKVVTxagJ82K
 8WkLwB8rWPMjcTqCkUfG53hrALqN6Xx5r/PqWjyq6GP7k5sD2kdDpxdVrR1W0zXjv4H6PUzI7wp
 7jVPYkuoOrr3Jq5aBx37NBakjHfuEEip+IkmWijaqRPkvSRMl/FyXpVx+pPlMc5F29dcQqCYI/P
 Jcv/gwp/QL5XlGgl1qXR7koQEv47UNLjJWfJWfsTL11r0fyiao4DNi7eGedpE4+71jURDG5pn4w
 MTBhJL1HKUMHxSaBeEI7LOlJRjreCw==
X-Authority-Analysis: v=2.4 cv=AtvjHe9P c=1 sm=1 tr=0 ts=693fbaf4 cx=c_pps
 a=BHc/kpNhEc903heYfFpeZg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=7sOpJmzboqp15REbK6kA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: FTuNALx1X_TQawJbwOUM7rJW87fyIHer
X-Proofpoint-GUID: FTuNALx1X_TQawJbwOUM7rJW87fyIHer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150064
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
Changes in v2:
- Add Peng Fan's Reviewed-by.
- Add comment in scmi_clk_gate()
- Link to v1: https://lore.kernel.org/r/20251208-sqqs-v1-0-290f0594e30b@foss.st.com

---
Patrice Chotard (3):
      clk: scmi: Fix typo scmi_clk_get_attibute
      clk: scmi: Fix priv initialization in scmi_clk_gate()
      clk: scmi: Remove duplicated scmi_generic_protocol_version() request

 drivers/clk/clk_scmi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251208-sqqs-7884dbfd4fa7

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

