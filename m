Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9933D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 07:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15CEB80433;
	Mon, 15 Dec 2025 08:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ym1g1pXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304008003E; Mon, 15 Dec 2025 08:38:54 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3196080050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 08:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=44443983bf=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BF7U4wf1475792; Mon, 15 Dec 2025 08:38:30 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com
 (mail-francesouthazon11011025.outbound.protection.outlook.com
 [40.107.130.25])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b1jk5b604-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 08:38:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZC8hnAu78ID47tVXpu2XyZKhA0MlSTw8GQK79FMDBPn75wmsfhf6iKYtF7e653fT67C9gLyxMbqH/Yw0+zruGhm6lHdPumLIaqB87hHCrAnfN7segRuqZUPoAI7Zb5IWnBvrR75//6+SUxw/G+lZvXkYYZL5r/fJYhQUc5Le9vfg9kfJxKomdvMSJpi9xDCwMXAAD3GOig33jkq6hrUoZfqRzrJbjel/odBYP+EnQ64teN6kx49ZUw2fpN7lsaoYCBhZXIHeWUbmqzOnd9R6QKItv6J04JmYaxOPHUYQ/oxskdjlJkF52KFQinPJrpAMPfc3QvmOO90y/zEjvOhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgGY7H3/hyvvLFpR0sj7KH29o1JX+iXCaAGF7+yb15I=;
 b=EEQfzQEWdBFl9TrnmwMxqtHM7YgcTqX+pJAOdhuyJSW/gHucqKnSlqaxydXKQAfDbr+UZQqhYi+A8Zi9+h5PT2Geiez8oRXi1Fq5Dcl9vvo9ucds3dWetGKApt+uapYM+Mbhi3/bCHKD4RiPUYkAK93UCdKpjInpP5VJWrgzf9PEqGdrjy4x97Php0vZfQQRenSh5vBcdEqlRdifrvWwNKn65AUv7AhBM74amELvXfnn87eqq+Y202GBvXpMm0GFrNvdI3BQgfMlsHLS4CD7eDYVAey6WcROhBeyH+Co9xc5r9rSElR3bVmwhfs8iLXPo5CSFf/uMkoMAVNKlyQBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgGY7H3/hyvvLFpR0sj7KH29o1JX+iXCaAGF7+yb15I=;
 b=Ym1g1pXCPo/cxkl7L1b8za8xkX5Iv0bQn9ln8K6WIi9t2S+HqMpEAzmUf5ZPBMnpT7sYFTGpqTKVvVw6HC2lNOF5SQJVCLeK1MD2tjPWIdH5F4kLsiot0aJbpY6QJTltifKMqNXZZzq5uY3PjbGePRulCrG/S4sg0N8CgpCApEX2HyfOykUz+uH5JrrZzRPtJY/kcT2RDHTMqp1v4FqqO0XlMkH2tk77WZDOr6A4Cmh/vOVjempemXlcA6oHaKP3Irmd4Pr39dx79BUFR9r9+BePJBbV39spsuEqXBAAFSAzgd4aPwQL76Hb/WTdveTfqHRetWSibUfbDccOn0BM6Q==
Received: from AS9PR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::19) by DB9PR10MB6620.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:38:27 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:20b:542:cafe::e1) by AS9PR01CA0033.outlook.office365.com
 (2603:10a6:20b:542::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 07:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Mon, 15 Dec 2025 07:38:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:39:09 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 08:38:25 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 15 Dec 2025 08:38:19 +0100
Subject: [PATCH v2 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251215-sqqs-v2-2-9a15a22072b7@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|DB9PR10MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e97dd0-ed42-4664-ba68-08de3baceeeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0dZSFMwT1dFcEFRZ1d0SVd1bWp0ZGxXT1k2bEdTaDRNQXBYUy8yODJkYnRW?=
 =?utf-8?B?YUdDTlNiZkdacEVMVzl4cFJVZWRrZlZVT01Wa3h1cmgvNVNpVmxTdUJZKzNU?=
 =?utf-8?B?SjcxekFLU3FmZWVYQXIwci9Qakw3dTlxVlI3S2NXdGw0WlArNzBkVURuZC9l?=
 =?utf-8?B?TXJzbi9aN1hEc0ZuUHQ5TWJDR0ZlZG10WGY4VURLZCtnQnZ1VEZ6S2NwL2Yx?=
 =?utf-8?B?bjBsZzYwOFJNMmVDdWk3NHJ0N1VOTEUzUzBZdWh6cmtVRWVnYXMydWoyeU9I?=
 =?utf-8?B?NTAvZk9RS1MzT09GOUxZSmNFbm94dWxGTEk3ODJ4b0NZd2NLZy9KNmUzWVVE?=
 =?utf-8?B?VjZtbmtzTlFkMU42WjFhZE9nUXVsdjBBMXlTd0ZRZ3NkMllvMjBOR3RYVklH?=
 =?utf-8?B?NThFQ0VWZlNZdGJxYnQ5cW4wdHlrdGhFZ2dkTWh4ZnVvS0FKTlpja3BlMWx2?=
 =?utf-8?B?cCtzaVlPeDdTSVJJcGt1ZXdyUGlYUjhhbHVDY3ZTYlVzMUFTeVhVTnJoQVRN?=
 =?utf-8?B?anNYQjkrcVBmQ0dBZlZla3gva05OSnJkbUtwNG4wUDBneStTaGVWa09CSmRK?=
 =?utf-8?B?NFFxNnF4MDk0ZldzMXBUbytFZ0hSLzVVellPcFl6aGcyUFgvSG13ZE9hQnQx?=
 =?utf-8?B?OVdKYkEraW80TWJBUmJGaDh6R2lQZTRuOVZDYjE2UFdDak1pUm1LdUU2RmYr?=
 =?utf-8?B?WndJU2hDekZ4SXdnYkFMb1NjbjJCNmtRbk1TVUZxZ2c3RzlGZnk5QXB0dXJZ?=
 =?utf-8?B?RytHUGEvTWNKVERSUEpSMzdkemJBKzRDcksxZ24ybFZnSzVsdTFna3BBZW9p?=
 =?utf-8?B?K01qa2V2NlpZUXV5WmFyblV4WHFPTmVlS2J4WGxpWVNIMDEzcERiN3BFUVV0?=
 =?utf-8?B?bnpYM2RWMUpMeVprK1BzVStublVaWWZ5bDhsWjdrNE1WcWZpbUpzQ1NnbkQw?=
 =?utf-8?B?d0hVbG1pQUFDcUlLYld3VXd6WC9VVUloaE1TODJhRERObDFlNnVTdU9OR1VK?=
 =?utf-8?B?N3JIMWhWb1ViVzlZRTNuZDlkQ3ZpZUNKTE04VTVUc0QwNU15T3hvODEwbEkw?=
 =?utf-8?B?QkxMOGE3eXZ3MWxhMnFEczd0SU80VWRvTjVKWG1YK3p2RjZkK0ZNeW1GSjFX?=
 =?utf-8?B?NnRVcjRPNmIrdU1LSy9QYnhqWmREWjRNMFBralRZK3dLaE9nVjk3eDN4K0gr?=
 =?utf-8?B?Umo4bFVZVStLRDc1YjVGL1g0VERuRjduMklHUnBPQzdGUEJCdk5FNTh0WGRw?=
 =?utf-8?B?WFhDUmE3REZGQlZzNk5FWkNUdWh0QlFvbFBVbDZiN25LMUlIbytGR2dNaThF?=
 =?utf-8?B?WlUrZVN0d3NzSjh0VmZjQWNxcThHTkZyWG9rV2VHWjR2dDJzTmRPMzgwUVRF?=
 =?utf-8?B?MUxBM1E1aE9LRU5aR013YkkvL2s2aGtUbmZsaWZqd0ZZTjFTRGhhclVSNVY0?=
 =?utf-8?B?dUUzSW4rY2lIOXF6SHJIaUtXZTBBUGxQOEVKWDZzNnNPbEJGMkcrSVlhZ1RU?=
 =?utf-8?B?M3d0cENHK3d5b0pFTVdFWnE1NG9TNjVYNmF4ekZjd2lydjZseFhreFFoRHhk?=
 =?utf-8?B?em5VN1NCM1I2SkdmZ2k3VDd3Uk9CS3dYY1pMdlc0R0Vzb2p1UTZqMk5wWFpH?=
 =?utf-8?B?dHhuQUo2anpOSC9ZMk1jRjRYZ2ZGVzZqK0lSSGNCUHlUMHBIYzZMOVFEWVl1?=
 =?utf-8?B?SGlvYWMydjN3R1dQN1k2ZmR1RmVld3lxZk9hYnNnMjBJZFlZUHZxbUlzb3Nt?=
 =?utf-8?B?K3MxcXZrT0JpNHMxT1g0NGVhZGxWZGhGTkdhcXE1YjVabXp4Q3pMaXJCN3J5?=
 =?utf-8?B?RU00a0tCV1dGMDdBdFRHM1NJVCs3ZTd2Wk11ZnpSUzFFQTdoSHR6Nk1kWnc5?=
 =?utf-8?B?YTV6L1JlWkhWZDBnU3J0SjFZKzNEUklrQlBxaEtEUEtRMXRNWmJtaWYvOSsv?=
 =?utf-8?B?SlQ2bGxFY3lPNU9hZ3JzZGtyeXhpLzRKTnhXSUphUloyWVFXUW1EQ3VSUS8r?=
 =?utf-8?B?K2xTUitzMC9Xd1A1TzlnL3RRVGFoZk10M2tTZE5TR1FkZElxVnVpbG13TDdS?=
 =?utf-8?B?Y0dMU1dhb1RFaGJEazJ0Z254Wk5GQnQxOTdPY1k5TyszTWJMcjJ5aVdYUGUy?=
 =?utf-8?Q?E5Dg=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:38:26.1181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e97dd0-ed42-4664-ba68-08de3baceeeb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6620
X-Proofpoint-GUID: nAXXPlo1cPUDB2Wj24jkajPhZXyq2mw9
X-Authority-Analysis: v=2.4 cv=NKvYOk6g c=1 sm=1 tr=0 ts=693fbaf6 cx=c_pps
 a=k5WsYE8Ox4pil86Zu4gvjQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8AirrxEcAAAA:8 a=b3CbU_ItAAAA:8
 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=V33MDRWTvYdzp_Uqp28A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA2NCBTYWx0ZWRfX9ltDsKOyQ8WH
 B1U6iIM/kxLE/aZL7rJqIBfaPcVl6H+oubzzPS7gtl9MuhAXjEPlfs7C9XzIiaXyYF5zdgw9kJt
 Pp1WGbszMgBpbQhWD+XZ27YBy3Dyosr2zBfEJWOezvA22mDggCu7RQ2pw7EZBs8ejbq9qZhtRYo
 gUG/kVrXP7Oj0rrmhp5EO/TBaV3BqbkUcs6jp8Ad8RBGj5/yU3hdKBFFCQTRhNJ9L0mduNY3X1n
 cdwWKL478nBg8TnfWtIB9AHWtuUkm5MOVA1+u3azOU25IWRqZ9xYa5+D2lQ0FkjOcGg3HmsaZQu
 he5ofD/uxhsoKYB3W5VIHrdTYK2gjjm3yPBkyCD3ErXfgDDQ+OdgRzVIz9IA7t+5LeZXDGDofFc
 MB8Y5IGca++Mbuk+4zyG761psi/jzA==
X-Proofpoint-ORIG-GUID: nAXXPlo1cPUDB2Wj24jkajPhZXyq2mw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
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

In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
retrieved.

SCMI request is performed either using scmi_clk_state_in_v1 or
scmi_clk_state_in_v2 struct depending of the unpredictable value of
priv->version which leads to error during SCMI clock enable.

Issue detected on STM32MP157C-DK2 board using the SCMI device tree
stm32mp157c-dk2-scmi.dts.

Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")

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
 drivers/clk/clk_scmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index f6132178205..5c99f3708c3 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
+	struct scmi_clock_priv *priv;
 	struct scmi_clk_state_in_v1 in_v1 = {
 		.clock_id = clk_get_id(clk),
 		.attributes = enable,
@@ -156,6 +156,15 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 					     in_v2, out);
 	int ret;
 
+	/*
+	 * retrieve the correct priv which was set in scmi_clk_probe().
+	 * in case CLK_CCF is set, priv was set in parent_priv
+	 */
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		priv = dev_get_priv(clk->dev);
+	else
+		priv = dev_get_parent_priv(clk->dev);
+
 	ret = devm_scmi_process_msg(clk->dev,
 				    (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
 				    &msg_v1 : &msg_v2);

-- 
2.43.0

