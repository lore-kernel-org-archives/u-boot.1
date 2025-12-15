Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A3FD41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 07:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF91801CF;
	Mon, 15 Dec 2025 08:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ys1s1Dwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B760A80077; Mon, 15 Dec 2025 08:38:51 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EFB8003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 08:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=44443983bf=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BF7QnMm1793315; Mon, 15 Dec 2025 08:38:30 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b1kyq2p7j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 08:38:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlmL4meLt/fhZO37VUdcKdLrzuyNSOqWRPCt5t8DmeEfwb4oLbL5Uoea5QpXZQ06dRZnrPZAmQf3PVqNayEBZJuClGNvqjM/hBQqnLkCpEdK5P7gCGRS1L5zV1Rz19TuowOlQoxGQnRrj3CZhRZfGDemKEzyIlM6qEYTeekb3EdXU0lsWfP22ck70fY4N7ejQY0y+0qA82Uy6OwhNnJcZTjicC7atuvH+NTb8a2zEPFkGrzT3EGUfIqcjhoLQAGo5HIDxypPzxFyjdcLlfQgwJ0Fu0Vf2DjzBidW299TvNwuW62aTEA6bDqfIYEq4L7KU+IfL4X1E4PFX4xf1ot7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdKmai6hVqCc7OWR4msS2LyieWWcg6TvPHqKb4AKdu4=;
 b=gj+XAfFdqZIJQFgRjmJa0gc8M5UghwMFn1FDYWNduxlYVldNZ8naRZey4szOZiug2N6bWBgJn/rQjq39hyYSBsYEJH6jv0eS2gV+O1hEgUO33N9AnGuL3MZ4z6cp3m/tpmGWvaslTO/q3g6ivKsWgZ8v7pFvslw0Fjq04ID/zdMT/gmdDYcbH01lyGCSE6lLZ0aOxSoJIx8LzvgBOuMjpLQeITE65qTxQGm6F8yYjj3HH5RwC/X0fxMJLlSrWAt4Fgt2vLr9GBnXYmRnqDNYBNpxzwQxVmu9mkGJ8KZhuPTOvjh/drZI2aMamuajXZvXFhAdAD+n0mqpsIZGizulJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdKmai6hVqCc7OWR4msS2LyieWWcg6TvPHqKb4AKdu4=;
 b=Ys1s1Dwo4tteV7IOw3gTvBqnZfe4BnL3WWxezU7V7JxxU+XSRxizex32Y0oxgyBY49s0WPTTnDe3KOTJKH2qon6PeTO35FYD31jHxtOqVmf9lyye8cj9AUapuvDldn/WPcne0RGibBDhDM5OgvCXLmpK/NgnDTOqh9VP7M/+ID+WYxtgjGYH8esLdGrDpqQHW2+EFZUL/nQ8zwrkfNriAo0Cmn8TQsdVBjf3BBI/3IPyUMraCD3B1LuW9QeD0rUeXVjKBLlZDA5GfQpTzQyoZYDlEApWVkOvUBUe79gAJOM+WchdUmryvdf9xPh/GMczRubPOBc8cH0fldC3RcHeWQ==
Received: from AS4P191CA0035.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::11)
 by VE1PR10MB3902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:38:26 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::a5) by AS4P191CA0035.outlook.office365.com
 (2603:10a6:20b:657::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 07:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 07:38:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:39:12 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:38:25 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 15 Dec 2025 08:38:20 +0100
Subject: [PATCH v2 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251215-sqqs-v2-3-9a15a22072b7@foss.st.com>
References: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
In-Reply-To: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|VE1PR10MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdaa80c-a89e-4011-4dc7-08de3bacef0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWhCTW5TSDNWYVZKbkUzeGp3NU9uNnlTeEVRUGFiM1FSYWVvVDQzaCtLN0xV?=
 =?utf-8?B?cU5NbEpUQXpzU3lBcW4xNGVCZDk0ZFpGN3ZGVmJkWFhRL1pyOWVuTDFYK1Vm?=
 =?utf-8?B?Z3MxakJlL1M1bHUyaCtzOHRzZGVUb0tSSVlXMUpMdTFPbDRkTkk5RE5lVDdn?=
 =?utf-8?B?dExDSEwxbmY3SmozMzFFcW1TM0lla2pRUEZTdjBlS0haUWxGNS9ja05KbTBw?=
 =?utf-8?B?UTM0cUFRMzV6M0N5SDZwcStyZFdUU2VSV0U3ZjdPdGJoMW8vZ3hwdGE0QTB4?=
 =?utf-8?B?N0J2dWdkbUNIV3ZkQnVPMHR1bzV4aVd2cUNaUjVYc3MySUIyc2hFUGcyWVZH?=
 =?utf-8?B?STRTc0UwK05kMTlSbjcvdUpwNUYvY1o1WitVc2dTMGkwazBIZ2lWbmhnZ2Y3?=
 =?utf-8?B?MHBnZ1d2YjIwblNCbFk2SHlTbGhJRFZTaHplS2VFK0ZRQjZjcTBXK3QvMjJ3?=
 =?utf-8?B?RjRvbTgwU3IwSTV0MWhQMU0vTUNreDZ5bEZCWEoxNkZTYmhybVVocXh1djNI?=
 =?utf-8?B?a1NjV3VuUHFLSERaNStoeVdCNUp6N2NDREZwakxwNDRjK3EwUk5Oa3lyUVZM?=
 =?utf-8?B?MUkwMEVhc3o2aFc3ZVhrTHN2Zk5ZdDVBc251bTk0blowanB6ejZXY1ExdjdD?=
 =?utf-8?B?RXJabEdWcnN0amkzUnRPaHdjdkhOMXRtN1lTT0luWU5CODFxcThSOUNPQmZZ?=
 =?utf-8?B?c1JSUk53VDhnbkpZK2VDR2VOLzlCRWlIQTl6OXlKN0pYWWMrcFloaXZNZ2lS?=
 =?utf-8?B?QnhLTmhDaXZXOGlKSkxZZFV4YnhYN3dSWitrQXE3K2wyanp1aWZOZXpWS2Rx?=
 =?utf-8?B?NnAxelhXOG52akRxc1JNYjE2THN1Y253TEhIaTBleDFGa1JTY250bFRrZHIy?=
 =?utf-8?B?b0xZa0hUKzFjZmFqRTNvNVgwTjlOM1BDY2x5TVNWVGJ2TU9lWDJnb3E2cUoy?=
 =?utf-8?B?V1ZyTm1XampkZ3RkVFczMmcvSE9EUzUwOE5oYjE5TkNkdmdEMFNjbVpFV05C?=
 =?utf-8?B?OVhzL0MwRllHQ0lNeTVaNGhubzdkbGxva1lMWEN6cndsbXg0MUNpWEF5MzJm?=
 =?utf-8?B?bDg4Q3dKYTQ3V2kxZkowQk9FUlpUL3I0VktJWE5CL1duKzdDMmUraDlNRlNM?=
 =?utf-8?B?VUEwK002ejgvQUpzTjlsaUQ1RjBjSUNyTUkxVjVEZVUwcFNaOXd0dkhvelBF?=
 =?utf-8?B?d1lFTlNpZDhtUVVlbHBQK2RXKzJFSFJqR0x6TWYzUm5QMU0ydUU4V2FVMTFD?=
 =?utf-8?B?RnFxMDhHSVoyckE0cDQ3VkpJMnhXYVBTaUJvcEtnWDhSU3BxRmphYm9CTHZD?=
 =?utf-8?B?TVhUZWJwbkhTanVHczBEQ0Yxb3dTVnF2SnNuU0doWWNwNW12ZXpXMFk2Vy9l?=
 =?utf-8?B?eUVEQkpPQzlPMm54YTNpNEVUSmlQTk1lS1hoOXIrWVgyRWxqRGlmdUliYnNp?=
 =?utf-8?B?K1UxaDZ3T0lkSUg1c3RsRi9EaG9pNUN0MHRBUkNmeHVUeFNCZjYzNHM2bEYw?=
 =?utf-8?B?NHVHb0xKaEtMQ2xzakNDb1JLcXJCNHl2eXdFL1RlNkxhdFc5YmxTZ242UlBr?=
 =?utf-8?B?dG5jM0ZUVnNhbHlEY1RNN3RlM3RScVZCT3kyMkg4SzVDTlJPbjJsRDQ0V1pz?=
 =?utf-8?B?ZzBqSmhkSG5IUTJDYlQ5OHoyMmVpdDUvWmUvWm01bEx5RGlyRnRBbk5jTzVT?=
 =?utf-8?B?c2RDRlhKTWNzNDV6b0FLZ1hVRERkV3MwQlVUcDJaVjA3aHN2c2xDL3krUThX?=
 =?utf-8?B?V0wzSnhGcURlSng2N2xuRmk3QnMxTHB5a0UyVDZhTlZzcFNWM2EybmR3bWtP?=
 =?utf-8?B?cUxLa2RmQmQxakdiV3YvNGh1NTFsb3hUcmJja29ycllQd1NiRTBNbXp4bFAz?=
 =?utf-8?B?ZlJtMWhRUm9iN2FGL0NVUDFRV0Mwc2p5UVVIVFovM3hxNFFNRGtyblhDZk9z?=
 =?utf-8?B?c1ZZUjFNemlqTTZDUjljM3lSZW5WL041NEFKWTFRRmxvNUYyRUEwY2VENmtJ?=
 =?utf-8?B?NDRlVjlqM0lKVkJUY1RNUnVJd1ZIUkhqV2pzanRvbVl6Y1lrOWl4QnZmU0xs?=
 =?utf-8?B?RDNxWEl2aXZUQVF1RUlPSVQ3RVpCUHljQTAwMXNhblRiUE1HWnBENGIvdWx6?=
 =?utf-8?Q?xrDY=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:38:26.3232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdaa80c-a89e-4011-4dc7-08de3bacef0a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3902
X-Authority-Analysis: v=2.4 cv=DtJbOW/+ c=1 sm=1 tr=0 ts=693fbaf6 cx=c_pps
 a=YWPBmyF2ww8/fKl6NjReww==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8AirrxEcAAAA:8 a=b3CbU_ItAAAA:8
 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=CfLOgkDlRiNpbL2KJroA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: OQU8dDi6Y5-IcCKfNkjXfCKc9sTY1h7e
X-Proofpoint-ORIG-GUID: OQU8dDi6Y5-IcCKfNkjXfCKc9sTY1h7e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA2NCBTYWx0ZWRfX8aE9hivHA00i
 Pm5JOD2Htm1uKn0CfFofVuQhIyIDjV6V4GSJfdKfXbFE3VB6tA1fFabKZlAlXORFqNKU4RWAbs5
 DOuGcK4VD3j+kB2wG8Ll6TVCvOdRyZvnHvBR6Y0+5bD6QbTWxm7eEl8rZbVsP08LShEuQ0vQaR6
 YCMTy+wrDo5c/ogFlRaf4B+ejoa7WJO2mHzbDUS73+6rnmzp1IdZOPOMi5YKhTjthWb80SEE0z4
 Y83gQRSHHlwhgvPzh5vY0JQxh3BsJQm6RM7z5N9vFNH2sryDsg790wbs+YMu+M4OFyfdH20loYt
 iraVPeLXhJaqbSlZH7SgpglYa1Xel93qzBIh+jpz3d4pv+YhhajfrhZ03Osbvx3BaTm4Xc7gxMm
 KWkfxRGwVhBrK6C9dUoqcnUj1r0i6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 5c99f3708c3..03e7f50a901 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -343,9 +343,6 @@ static int scmi_clk_probe(struct udevice *dev)
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

