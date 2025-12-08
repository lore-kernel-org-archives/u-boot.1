Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513FED3B7E7
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 13:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8383D83B27;
	Mon,  8 Dec 2025 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Glg7n0Mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7658883B4F; Mon,  8 Dec 2025 14:51:45 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7547083B27
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 14:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4437f1ca7b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B8DN9vM1435136; Mon, 8 Dec 2025 14:51:36 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com
 (mail-swedencentralazon11013064.outbound.protection.outlook.com
 [52.101.83.64])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avc8h65d7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 14:51:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgT50AGoJgILcnE8ogNRJM4IB7RPmYQyLObxCQXfQrrFB+sOP4oHEY6sV09bKUDPBFTjqHvw34OO9lbbjd2N6EodzufnJwVDkuUrE2I5m0mkwAu/DDinEDLwHjtVyZ0pnadA8BB5TkPDxNygqNPjynEqomirkuD+rpQ0/dfRIH6uSYSfCy8Zu1C5BbjUuVjE8qDDUzFptWSn4pqGWbx5LnbvnZnxIE/UYL7rX6Ab21HoZ0njA/SolI+nDZ3hyuwnpE377FksBgP/mI6NPYALfHBGU5wrJt5y7N79yrDdg5cAOcx9fwBbyGaZIwzQnOgSZ2l27axgd8jt18Qt63OSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QegpniXiCC1Mngb+urB8rdnc5flpMxs9zNVT+71WOs=;
 b=Xl6YqKLHw37zKICD7F52UTUfaHlC3FhieVwd+jb0ZXhgwL6X9ED4JyjYQ7pKI+nIghr5cj7VlnoGo/mgqkeCrKPwJtd9Lq8PaygYsgtwxBEJWoIEMIgZHKme+AYgJtCIlediCy7FMnWh30qkmcNt1AW7ckqkUTq7t2T3YcKjKwPCfuSvUOaFf5/QoAFywvGlwGC4IuQKrYdlep3v/cCuaGXOeUtvhHgByF98PM1hMQ6nhGahWalZyyYcYUjA9ZIMk98fXtaoXXKV1SjY2y9CjWqjQaeRpqV5HZB6YHbDluWcKf5OJaKjVbb9CDOEy/SmDumQQpPhk5CmjnHIUmyHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=nxp.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QegpniXiCC1Mngb+urB8rdnc5flpMxs9zNVT+71WOs=;
 b=Glg7n0MuOde8dy/bwkBbIVhWIP5E4tTyvPFuXEB4o6sokheo5bTjLvD+zlNBxJptXY7ffVGh/g6IxGqKkXVAfnEo8upOe9/873aSPujp6k/WAtkPfin9lfCo4XTjQ5S8+6btY6YrrIjZS+Q9bxlQA+18ZHd72YZY2WWVVm71Y8LjNoLQHxTijxcFoXlSXA2/STrUcGawuCdl88U0MwsZclyOvAQxgZ+ZBigGjWwn63TMbOUnPLtBWkNIh/Fz+fj8v5vlAyUVwneSF4RKL0B6RwLCcZOyizzWqTFtJDWrGFkAF68GDQ89Pd5cwDQ7ap4bJyNe4xBJl5YSvMlWRafYxA==
Received: from AS4P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::7)
 by AS2PR10MB6445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:558::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:51:31 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::69) by AS4P190CA0001.outlook.office365.com
 (2603:10a6:20b:5de::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 13:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 13:51:31 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:52:13 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:51:30 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] clk: scmi: various fixes
Date: Mon, 8 Dec 2025 14:51:24 +0100
Message-ID: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANzXNmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwML3eLCwmJdcwsLk5SktBSTtERzJaDSgqLUtMwKsDHRsbW1AAjujKl
 WAAAA
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|AS2PR10MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4547e1-c10f-4946-536f-08de3660e4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2pZQmNIMHdPS1pSYzkzYU5LZEhrSVAvY3ZXa21reGI4b3BSUHI1c28xaGRp?=
 =?utf-8?B?ZEsrZ0o2c3IzUlYyanpjM01BVS8vZCtkNGllV2xvY2VyZGdUSFJUZFd2Wjk5?=
 =?utf-8?B?YW5lOXdmbDRrSWdxc20zdElNWnpSaHAxek1aR0Z6Q0JrYVBFWFY1WHdURUZW?=
 =?utf-8?B?UmNxTUd6cFFEYjNmYkpVRnd1b1ZqMFQwRnJSaS93VGFaNnhoaWFjTkxyTk9F?=
 =?utf-8?B?WUlTQVNyWldnN204NDBEVzg1UzdTRnJ6L2t5eUQ4N0RhVW8zMmk2MkM4R2xI?=
 =?utf-8?B?dDBGd25Sd0YxZVZnSFRvQXYxcHVkcUh2OStFOFhMZzRGYVdXb3oyb0J6M0hh?=
 =?utf-8?B?Z2twZWo1TDhMY1lYclhZRytLL3R3WGtuUGhKd2VkRHBNTjQva0lqaU83MDQ3?=
 =?utf-8?B?RHBVWkI0Q3ZYTzE1bjdPWWhGZ3h6aGFxSWh4cG81SHlMbGNIUGRZY3JEQkNP?=
 =?utf-8?B?eVczdWVTeW9rOStPRWdCV3pLbWFpUHk2b0RUa3JGRG8yMnBSZ0dUWWVrQ0JF?=
 =?utf-8?B?MG9DNnkra1B3Z0FxQy9wam1HMk13UjVucU1SM21LVGlnZ0wrc2pjbTA2WDlJ?=
 =?utf-8?B?TmQwMFpIT2VCSFJpRVE2eGxZYWNqNUprTjJ3MFRHeFFZWHpGOVRtdUFXekZT?=
 =?utf-8?B?bWwwdkxIVzRZTVh3Z1ZzQW0wL2NDWFltSWZpUjZNRGhWSGVKUHVEWFRtNkxM?=
 =?utf-8?B?Uk9PNWZ6VENIMm5FYzcyK2VpQVFYRm4rR1E2Zm9CQmhWV01tVEJId2pjd2hz?=
 =?utf-8?B?T1Z3azNsK2xNZWRVeGlnYTlEcnlYMUxFZ0V4bkVqUWo5MTdZbU9QbDhUSm0w?=
 =?utf-8?B?SEFEdnFWWmJQbGswSW1ucXM0bCtPZkpRT3pzMFRKZ3EvMlNMTkNjN0FuNDg2?=
 =?utf-8?B?RzdNTVUzaHVpaGJTYXNRVjRJSnJkd3NuRU50Q3JSd3ljOUlQdklSVHNwb1F4?=
 =?utf-8?B?WS9lbXJnTlJZRnBCUDM1b2dQUVhyVzJrVGh6Z3dnRnNQN0VWeDNKUERjam5x?=
 =?utf-8?B?MUxPT3NxMnFQY3RUMGQ1aEJkNGVPbm0xSEEzUHhJUEVYRkEzV0pxR2lCazln?=
 =?utf-8?B?SWRabUc4WEVTSzllUGY4R0I4QkxMNG1jdlF3YjNiNU40LzZ4eGNsOWtYazE3?=
 =?utf-8?B?RnJOYmNLa1llUjdkNzZuc0pBNU9CLzF0Qi96a093Y3dVT3lpbldodWJEMTRz?=
 =?utf-8?B?VmM0V0xEc0Q0cU1VMHVVbXZwWnJtc1JvQmR1d3lnVmtMNmtsNTA5d2xCZGdJ?=
 =?utf-8?B?SmREUy9qaFBnbXhNaXlMa3o3T3NoTVhDUEMrbXhQTnFRM2d4RW1QUHdZZ2ha?=
 =?utf-8?B?UFpmVmc3QjBydnlDZmx1eVhpcWZBbldLSndENWQ5SUwyOFNJTWV1Z0ovanUz?=
 =?utf-8?B?ZkMwTmVuazdwTzJBbjZjYjRDd043dndkOFFMVUs4bHA3WkRjemRMbUhyRlRT?=
 =?utf-8?B?Sk41ZGdyRkxWdFE0SXJvVmZwTDVjQWhwcjBtK1Btd0dZU3c5VXcwaHNDK3Vr?=
 =?utf-8?B?UGFBQnRIdGJXQ1dVVytENFROc3JNZkdTUXdtQm5iZUYxZExFMlRnY1lVTDZi?=
 =?utf-8?B?OFBOditRQzBDWVhZWjBFMmZmVG9ERFhMODAwOVpoc1o1OVFIUGR3eTJtaEFu?=
 =?utf-8?B?QktwZjluNFNmRXVrMEtSREdabk55N0xLYmQ2dnJ1R3l1b29Cak9GT295WUd1?=
 =?utf-8?B?SG9KWTFSMGhINys2bXFENWttQ3k2MURNaWJsc1RqVUdjUENyVUZERU4xWkJB?=
 =?utf-8?B?WmNGMUJEUHFoazZXaWxSNlE4UkhOeXN0VnJkYTRkNXFQVTY3SE42VjYyWVpV?=
 =?utf-8?B?elFvWmY3d1BtcU1pRHErdkY3SHhGaGg0d00wVkVYTlE2RDZrNStRai83Z3Rk?=
 =?utf-8?B?WFZZN25UcGZLN0xOdmRjaWdhVm12MlV2aldLRTk3WXZYa3lZM0VuaEdUK250?=
 =?utf-8?B?Q2x3dGxnWGk1c1B0cUZ2cW9zQWtUeXFJQ1NNQnlwamJjaGlGeXRQUkpRd0Zj?=
 =?utf-8?B?QUhhZ3VXTkwraEE1ODBpdXRxQU41MnpzaGRYNHdRTU1PYzk3VkRVcHc5MGZO?=
 =?utf-8?B?SGZZTW1HS2s4WFovT2prR1VQVDB6NEJUR2d2YWNrVFZvTDVLbTd4M1YvVXEr?=
 =?utf-8?Q?fOvw=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:51:31.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4547e1-c10f-4946-536f-08de3660e4b0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6445
X-Proofpoint-ORIG-GUID: 1fejbl-lmwl2ItnUMRWSOu4zRxRgOBqY
X-Authority-Analysis: v=2.4 cv=JKk2csKb c=1 sm=1 tr=0 ts=6936d7e8 cx=c_pps
 a=RSP5wjQe9cmB1/5ZhXI0tA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=bdJKiZ1i3CYQeImyJS0A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDExNyBTYWx0ZWRfX5YYLZ3tI99qK
 sDOwn+gOBjCtuc90sdz0avFrbqyj+FSBdpdpHbLrNC/O6R3P1gmMfrJi9XmGd6ckQoyUez1Dyiy
 1EKopLBEi4Djoc98bzVpxJ/YWLsf3ufsWDUf6uZAFkw8gQUXS71qBpS+NS4XSEyzJSZ/A22M1YM
 eLd+49t0Lh4haW2QM8G9IsJnWGKYcHSYskQNVzvHd2SLSLSEKjsyS+ymZoTVtB1H9nH86fCFW6e
 5zhnk6JdS9mIAtpyAjJnG9Fju9PyNKnV/uHp8EHxKDSG/EHgw7paubA9JxVVfJYBBGARTo34MCM
 xVe8pnQboU4Jki2XMKCs7m/jLUbiVHL9A3p2P6EHd5DLbCTe+KwTvKSOD6VBwHSCoEB5Goqe2OI
 b6Hwc2XSAfboJXYhxjBVegdqVrWtQQ==
X-Proofpoint-GUID: 1fejbl-lmwl2ItnUMRWSOu4zRxRgOBqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
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

- Fix typo scmi_clk_get_attibute.
- Fix priv initialization in scmi_clk_gate() which leads to
  clock_enable() error when CONFIG_CLK_CCF is not set.
- Remove duplicated scmi_generic_protocol_version() call in 
  scmi_clk_probe().
 

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (3):
      clk: scmi: Fix typo scmi_clk_get_attibute
      clk: scmi: Fix priv initialization in scmi_clk_gate()
      clk: scmi: Remove duplicated scmi_generic_protocol_version() request

 drivers/clk/clk_scmi.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251208-sqqs-7884dbfd4fa7

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

