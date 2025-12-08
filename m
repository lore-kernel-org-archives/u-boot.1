Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFDCD3B7E7
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 13:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D6E383B4F;
	Mon,  8 Dec 2025 14:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WVd7gHBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A8C83BDD; Mon,  8 Dec 2025 14:51:48 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717C483B21
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 14:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4437f1ca7b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B8DpUe12015778; Mon, 8 Dec 2025 14:51:37 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com
 (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avasnpthc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 14:51:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx2vJvMOijyx+K83C+IijTTvn9540UdZhQybunBEsLQkDHnn/wGaAKrFFnpOpCqbfXVxz8CjDQcJwi7dsCrw5R3BQ2IqMcrrWRZkLZ1Ptsv9itSKS2G9jH/LF1eGRy2zabzr7+OjrZa/i839/Tohsr0KZMS25FwQPSFeZEM0EAJ5nUvu3v1U889+/8OiS9PiSiveDBFPNQc9aRxLXfmfSAk0stIT+UjYzezgXDRu6g9Q6zagraHwc3xwyshgpSULDBlWLoON9HK28bD7dN5cFgi7FwOl7bDITdUuDAYb6wE15vm9cqci0TLSfnWE1ObesRlsVoF8+1Cg3VbIVd0ReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6eEYiwNvO50rsMbvPzR+PG+GZzzJoK2+xpPCoYv9+s=;
 b=ulLG5HVbTfPxNGiiOouZkPQV+abPUcN0XURs8dObrNOpMjYbHJgQxD0gSxK9ydYUCLtLW+vqZpnjI3Q2Z6HrbbbqFR1UDKuiS2eXhJncQUOiasyESIZFs6heDDuNQBU/b2G3Kdv1uIULqWGgu7nDJzCZQ524tTWlK5zhSc+ONnUZiHgd0BuSgalMMQt3o3yKIBm8jlitAI+0dLvF97SIXN/bRTbFp6jrMlQRs7PV537zG40vI05YafPMxiNYYVpn1TB5KUjNf6rgam0b1N5br/lOONF2iYxPvNHwrQamKPnXvWZeECNfrIMusbbB0PPfEYGxTRwRt2xEkqvCLmlQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=nxp.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6eEYiwNvO50rsMbvPzR+PG+GZzzJoK2+xpPCoYv9+s=;
 b=WVd7gHBgIxWMsvqVX0a71scjs9kOKXt+v9CPhpt4HG3jQ1hCIqPCRZZbympX9rjOeqiwyaVxqd+fR/UGcmbMx5yFmOJXu7YbT4HHkirjEkQJY5X3akoVUAQ6MQb1Z4TWC2O1zg1KRikMm3TeFL56v96avhBJrf53woqFV5JOAJLp+3CUBUyt4UaV6jaurmXsolsYOFgl95qjbgpJKJClxwLg1BllHp53JgK1pm+CxtuRVwi1Es5sFqQY6gCcLoDW8/v5ZRSyrthDEopvWuI4T+ecxqm0E+Kv0cNazSDrSXsMbw4MJtKY1tTX/yH4o4JhJPgCselthjT37XqbDTvVKw==
Received: from AM9P193CA0002.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::7)
 by GVXPR10MB8508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:51:34 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::51) by AM9P193CA0002.outlook.office365.com
 (2603:10a6:20b:21e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 13:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 13:51:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:52:14 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 14:51:32 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 14:51:26 +0100
Subject: [PATCH 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-sqqs-v1-2-290f0594e30b@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|GVXPR10MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6686f0-cacd-4136-3152-08de3660e61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnU4RFlQQ3dxMWoxSjJTUjVzRUxiVXBQcjc4cDRzVUsrMlBDYUZXeEgzUGd5?=
 =?utf-8?B?MWVpK0N5Q0tlSUEzbmlETXhsOHZhT0NkM01YMWlhQ2tJYWhYdFJDODJDb010?=
 =?utf-8?B?R1pTRFhqZzJuaGdtdjliTFdJbS9vZ0MwdVg4Tm1POGIzOTBxT0Exb01DU0Zi?=
 =?utf-8?B?bmFTVzhnK20wUjRTTmsyS1pvc0lzSGVJZGxRYTJ5RndoTXVrNWhVVUIremJl?=
 =?utf-8?B?LzlNbWg2Tk04bWMydllpN3ZzZi8xd09GQVhuc0ZwSS9BT1RqT0J4cnhlYVNQ?=
 =?utf-8?B?c3ZrODVMZGdnUUpoYi82aEtBVmJ0eEI5dFVRRkp1KzRCQWFKUlVYNkIyTTlI?=
 =?utf-8?B?S1QreStlSUdST2hpK0lLVW1WQW50eEdINDZCNkZGZTZoTEFNcmhDa1ZrUVB3?=
 =?utf-8?B?RlR5WCtWRHJ0dGtsSmNvdEhWM1JaMFdZcHBzRFpoZUo2ZnBVbW5rN3dLZG5S?=
 =?utf-8?B?WjY0aHJ3VDF1QWpWa1NEQncvL0tOcWc1dzdoMXUwQW1iUmRPRzVBSmNTaHdV?=
 =?utf-8?B?WWNWanZTSkpoaThjZ0R5NU5qU1NVRWZzYXIvb1JoNTY3K0VlbWd4UlQxVUVw?=
 =?utf-8?B?OHJjOHhUQnNlcWNJbzdVdGtuMFQxaTA3M01pQ1VFRkhFRlpkRzVibDJoSXJN?=
 =?utf-8?B?S3RvK0JablUrTjNBNEQvZTQzY1BBd21ZWVo4TFhKa0k1SUwxMDU0Z1M5SmNO?=
 =?utf-8?B?UW5hYmF1VFpmTXQ5dDBwT3RqZHRScHFFaVlRMkNua3ZaY2ljYjR0cnMyLzNj?=
 =?utf-8?B?SWZMRDdQZEMwV3dQdzVud2VVVDN4VkF2Q2EyZkF2LzJZdTBSQUNaUXhYOGwv?=
 =?utf-8?B?RnBpZW5yaGxMMzVhUkJEMDBoYTFVUkZhQ1ZlaGZtZmRFZk1Zam53dXFveTVK?=
 =?utf-8?B?SlRxalI0cFNIR3R1RGJhTkdVRGQrMFRTd05rbHNjSVhKTXJoYm92bHdoQUtO?=
 =?utf-8?B?VTFKSW5DRFRram0xQUpJQ1hmK0NLSzZYQitUdVBkbGhkcE1oWmM3ZUw5Ym8v?=
 =?utf-8?B?VU11T3NoeG0vS3FIbjRIMXpUTHd5MHNEQzBvSHBYRHdJc3hXemFkTVd1K1lu?=
 =?utf-8?B?TnRJaGl6UGVobGNjZE1vR2hZNXBHQ2RySmpLek5TUmE4QlVQRE1HTTVnQW80?=
 =?utf-8?B?OTBRY3lhUHJrcklvRmFXU0Iwd0ZOUURtcVl4U3dpdlVtbU03S3dIbzJCVHlh?=
 =?utf-8?B?VHRTbFZxSWFzdDRjSVMzTW1kbHlXUkdpMnZNTlV4UFpQSXByTno3NmJHV0pZ?=
 =?utf-8?B?WE5pSy9TbmFVMnFMMU0zSEhxQTBqNjUzV251Mlk4NHhtY3dFajJwbERLUWpx?=
 =?utf-8?B?ZHlYSzhhU09lcEplU1NSSEJ0aEphMUNZclVLNXVPZktXVUhnVXFoT25sS0E3?=
 =?utf-8?B?R1c4TG9iWjZlcStUTWVua2VKQWRMNklPMXdUZ0h6cjhEbjFEblgvcWtqeVg2?=
 =?utf-8?B?Sys0VnpoRHBXb01MdnFtTzJyWDJ6S2g3ZkZXZjhrbjBMenlGblhnckozSnVo?=
 =?utf-8?B?VDFXR2VJNU45S2pteXhNRkpTMzBCYXZZWU51a1AzZGZieFJiQlB4MkFuYzdp?=
 =?utf-8?B?eFFhVUZRNitoOEgyR3BrY3FQUkNGdEpuYjA4U0lzajFsZE5nN3dUaUxTdnhJ?=
 =?utf-8?B?UldKbzJFMVV1OGxFblRkRmkzQTFkSWlyeExKS2t4S0svMURoNjRzSjczenJk?=
 =?utf-8?B?N1hRMEplYWg2RTU3Z0t6a2R3bFdMWHNwa2VUWVBuTUlsLys1V3M4YksyQ3gx?=
 =?utf-8?B?eCtmUnk1K2krZjRaOFh0dVVKMXVQYUFKTTF1VHJ2UFdsN1IrbEdqV21NMExM?=
 =?utf-8?B?ZzZSekdaS2g2OWZkYnVkRWYvWlJ4YTlBUlZYSmQwOFB0NUJYbmc1eTNZK2dE?=
 =?utf-8?B?MXVKaXduYW1Ra0J6YXZObjQ4SlZaS3U3c3VhblVKTnk4ZTZtRThPUXFoRDZV?=
 =?utf-8?B?TTJzODZpT3J3cTYvTDVyV3RNRlFmVU5FSEFBd1JBeTdQdnlvSngrcFlRRzd3?=
 =?utf-8?B?UU0xUDNLUDIrcTdNd0w5Q3I3aDEzdGp2NjJLMjhVbDZ6UHNhZ2dNeGVEQStR?=
 =?utf-8?B?Z1F5QWc0SEJTVlMwMjlnM1dHQS9yTUR1U2dJVGZodFU5VXRSSmkwZnpaMm1Y?=
 =?utf-8?Q?kLTE=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:51:33.7725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6686f0-cacd-4136-3152-08de3660e61c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8508
X-Proofpoint-GUID: 6xOPK_ZMutyEKD4pY8Zy2K3enf4t-lnU
X-Authority-Analysis: v=2.4 cv=J/anLQnS c=1 sm=1 tr=0 ts=6936d7e9 cx=c_pps
 a=oaznYbMuJcic/zmkEEuL4A==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8AirrxEcAAAA:8 a=b3CbU_ItAAAA:8
 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=7tj_g4KkOEL44L1CZDIA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: 6xOPK_ZMutyEKD4pY8Zy2K3enf4t-lnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDExNyBTYWx0ZWRfX7R+rVY6G2+by
 C4uSXlP2QzR7TmfXS/wi8DJc4UwMA5pIrikPyp0Mg0XI/PoPvYPB0Q8d3gmzy3X9+dCjP6GELu7
 kz5po8fCOXwXpORiZletLmRHr0rQbiB1wBJ8JsgvQtMKr/mjQr8NTwjc1/Mv7g5tYzlQJh9logi
 qhZzRaSdDHs3gqTXRIu18E+gbIv4h+zhirXTQBeTFN6j2yUk5R+Y6q8Z13kKAb67OG6t7F5pLl0
 HhNTYuQMX1gOlF0oSn5HWOC7TjlEYFIc8F4aFHFlbiPPVF2S6X2m8Q9M9XefZt+MQgFrhgQ2BJb
 NZq3mmRDP7uehLtlgCVb6tANzYk4udbDGWyR0IoplFjMhJx+bQHlBPvkyvopXyBz8Ttj5ChYnZN
 z7o9rNf7t8QDcCrlHP7oK8G0b2OYsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
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
---
 drivers/clk/clk_scmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index f6132178205..e1c20f2c47c 100644
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
@@ -156,6 +156,11 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 					     in_v2, out);
 	int ret;
 
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

