Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC7FC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF6084A30;
	Mon, 29 Jun 2026 19:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZPZo+olq";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qgW1ZPvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C3B84A3A; Mon, 29 Jun 2026 19:33:49 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3CB284A29
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TGUOTJ2579627; Mon, 29 Jun 2026 12:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=hPZ7MqgmQ8bLSv99E+vy64FaQI0UrBp4GB7ddIGGv
 6E=; b=ZPZo+olqE4YU/6b7cNj0r4fDNKge6coKvNC4YCBR9LsEqolyvlKD0lqub
 mk3Q6RFkpmXfYIoaxKEO91JcsMaFvkV2PoWRlbQbxMl3LFdkG1nl2/SHCS/VnTKZ
 yvKW33AppuOIiGNlRynIJsEUYsLUX6TqD8QRFYDoedLNOR6fAocEKndW5Temu2Km
 VpnH5q0K/dOSfVlBFVPUlDyonG+81irQq0cI1PA6fF2IGpKBLD4bsAKAu/DNj+44
 opxbIr/wq50NttvTJOkmu8LMjajfBOHBGxtLDD+l0j3gUbjMDpGGATZO9w8dV7ZL
 gH5RkWFjWjFznNqRhLkIyXPDOoPKQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f3qp5b1n7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:33:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmmKliTdDIPhD05bnLt3PdQkSuI8WTNLyEoIvwZOyDjxB47ftIsK6unjWgHlfaU5NWRvhYG4mHcH+PlKv3gJhWNP5poJ67/bP506pio7mS5R1bX85+htKHY+/Kq2eWD8iFvx024HGW42LtTRN2dSEzB2SDElHUeEzLZRc1iGnUNBMKDnF9xBtSr0zCq6MpwE1CKoTV8/+9b69pUkT9UqIYQ4NznRy85HEibX2HYt0mA1rLS9Djv8zLpTSfwILy4SsDBbzwVFAlpiEoHS2zIV+t5+z/HQ1oUHysJTAZdbwU0pp33mqS7Ri3igsjYt0G4cbyMtSKjISTPSGbSSK869Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPZ7MqgmQ8bLSv99E+vy64FaQI0UrBp4GB7ddIGGv6E=;
 b=iuyJL53NMVsQ1W0ExsPFWyjVnE7SMEyUBl38gYYBL/n4WXW4c7qSBVvpsnTOCyIGD5aVrZfQAD29OmqdgjRqIGTueKawczhFTlQdUpnOEQ9CpUn6jShzRmL5aIilqfxYCXCQhpiYp0o6ygmviWrxwcVFxbOJ9dPa8Rk1t0Ky/LPRP7hnBT/mOcZWDAnXUbOxDXqgkw7+kIK0RD8DqQJcHBfNvIadNf+Z7ATu2PDu0bqyRKG+gvjGQO1TcZImJc3rSV8EsOj4+52bFhJ05noPexo5iDHCisAGg3gnnEuYZN/jJGjgglNrp+2q9IG5k4BTyW2aghtrHkFU7c4dplG09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPZ7MqgmQ8bLSv99E+vy64FaQI0UrBp4GB7ddIGGv6E=;
 b=qgW1ZPvq+aGMtCXwxPx3lS41Gj/JPBp6fRknK1XdOe6dKQJyhUl4BiXfd3OrbfNtbJT7ZUgotcAI19hOOkULNZqiss02PBFJZk7p9wnUgPqrmPTm7Kf0FXKDdRkeigqjP8tPIeMJvYg/WwZVV9G1z8hiLoXr5qKyvQN9Bn+bHZ0=
Received: from CY5P221CA0140.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::7) by
 SA1PR10MB997655.namprd10.prod.outlook.com (2603:10b6:806:4b4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 17:33:30 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:930:6a:cafe::6e) by CY5P221CA0140.outlook.office365.com
 (2603:10b6:930:6a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 17:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 17:33:28 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 12:33:28 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 12:33:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 12:33:27 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65THXRRl523445;
 Mon, 29 Jun 2026 12:33:27 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Jun 2026 12:33:27 -0500
Message-ID: <DJLPP0RNHT5S.2K7TOQJSA7VLV@ti.com>
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, "Randolph
 Sapp" <rs@ti.com>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: Quentin Schulz <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] boot: image-fdt: Restore suppression of irrelevant
 ERROR message
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260627204851.1151419-1-jonas@kwiboo.se>
In-Reply-To: <20260627204851.1151419-1-jonas@kwiboo.se>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR10MB997655:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e1fadb-296a-4293-800b-08ded6048832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: eDZr1+ERX0fKpb6B6qAM0SS83PB2Gi/x/Jkln98cy8AzhU8tFMvQ7YoyhWx43p2XbyXtHdptPQFadKZvdoVnMf9H2WZjYnZ7YaPLDUQ/iymgjZj0UeDyh52WNCWnbGTM6d3EnzwtfzxXlmc5Jy+yOPKB7Ya6DnKJz/z/C+f/KiTA8jF52co9VPENqKAorOxvKwLbP8kctxmLGsDsevlcRKfpu24OYz5yCwmiOID3kQCToMc2yGdwYBHNFwqIXZVZL7bn2201OLPdPbb9oetwOvL0irYfKGV7FZ02FA3nqNyrjnUvNRk8H/hhCncjiElEUNoB960WlMOpGj1oPk9IzoK6/auGjHPMrdzat1GTj/uYJOSAAaIRyKFdFCGzOugv1ezR+UTA72YWVYg3TGS8lYRquNDn+AC9wIU2EYgcpVoxOPQlrbocYQWmYpy4RcyOThhFOcxUx6GSf6JPyVdLp4pjodAZuDpCx5f2m5nZjHOGASx9Yg04ysHJp8W8vJxcq9Lujw8B7Yb31qcVDulH+4F7JEIyVNwkhgh82aCJMs0IYHEAo6z3tZgxj0LvfmRFWTHUJ3zq6z5DCRAhlomFNICZm1/4WAdfTxZ+fotNwZjYfLegCyecVWOPREvqVlPBhdTM65UuNuEWBhx7WxFSYSxaNWzBXamE0FjYra1esJAX3/UxAAqlZbmReeVHJnaLpRzx82umeBf/oQPvtz87vQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DYD7lFDWJ9AQc9h+8PBC2F7aNlvtwf77+1DGZcrz2pw0ioniOljkimx0Rj3OPCg49q4vSxWRepzOSwOU7NtAycdVzgutUkDtkvzSV2KDq8FVW80E8MQdAb/VxuKYt8Nr9RLkT0Jekxv9X4EF+v4djby9poXJ9JPr729vPiQGseP28qfSRRgoGfhtxAMLPaGFWMqpxcaeFsuKIrUtcICtbMhXYeNK0vXErPVr4tVeJJ1cPWOHCsoA6Z0+rQAMRfyOvsBdny3VmHK8OquqhAt3cgyqEecU9b60h0Yfa3t6IpfQoIVTb8pS+RtCozD4b2bIeHRhK/5D22yaJOuDJMo6W1JlT5ecvDGQSHg5UurfgoGAXpDiXqOC+rRqHVesUQAbfOPQRVBS8rLfn0hwhVHf9l5rrNS7CV/Gh9rVPggHQ72DjIMbEO+QDi5VJSK+ylnH
X-Exchange-RoutingPolicyChecked: MhixIC+v0IYC32gs8R+bPF+AbYNYhx/M/uYwPlkSXNHleeJpttGHlpzoHdywgyxVG6GPKgc2i/+pQFDJKvj7hp/EuWsap8AaDlWdkkrIWZWeKv+MhdAXQ4Y+66Ifyx3owe+boHDfNWGiJZmdNUH5l3lodb+RdBgKh5Ql5biXwyBMpu9ADAmdQdnZO1msWD/RGF8HFZzdAlMNtE0rktYLR+8IhTIxxT9nYNp5YymPIJVNkRmXqaXpbr3yooxmx6jw0fBzB6gO71f2K67PS1ig+JZtIOgcxCONZSQxP8sQMtg8nyoQYmeq9qjtrDERvJVnb/3vh15K0EZf72WRXi8CiA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 17:33:28.5400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e1fadb-296a-4293-800b-08ded6048832
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997655
X-Proofpoint-GUID: 3S0bysaLJUwi_Q_XjcEGLrWOcY0qUd0T
X-Authority-Analysis: v=2.4 cv=ObOoyBTY c=1 sm=1 tr=0 ts=6a42ac6d cx=c_pps
 a=fm8IUWXzr0h7QqFIpCBYEQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=nHEdXnD1PeFRCYcisZkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3S0bysaLJUwi_Q_XjcEGLrWOcY0qUd0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE0NiBTYWx0ZWRfXzqKdWFDqmjMV
 v/DRAB6WRixk6TfWS+YdhjFH6r+bZ2pRz7U0UvwpaRDzbuTwpi3u3n5Ak9yccqJobpay0mhzQyB
 LfF7jtGo4ywX7l1dB0hnt4bF69gc/JvId7DFacwd3eww5Zv9YE3mtqVAB5P9BE4SKUBSi/Af39o
 BU2Edy3otcHgDqWRiVSSHo+9tY/wtFCB6O3+634o7nonmSb6Q1til9BbNHwQ71k3ZM+4F66Nt5Y
 uVJdBjGra5BlLH97XJI2kkTHkLhMfA4bStR3Is/QNEHOPBw5vDczYNP1E0QWo4013Q87vSIM0BZ
 H1F6WIpbhE6PeHqMX/jos3kWhetsu9/FsOp0A+mWMrwrNxr56bQOZPxPxk43IVwc6fiirwKLMxk
 Rbzj8t7Ae7kBkDfXB6T0dzu/y6ijodV8fN6rwwK9HWEIWGbolpzYTZNcAiivMCla5jZrPuoCAnd
 acmYYgCmRTix0QhjXxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE0NiBTYWx0ZWRfXza8aZY5M3ETu
 96GV+26w+4kDUEo3giDpumELYDaEpv6p6PxdWOILnG3KySALteE47NNVwxIa8xbuCAEp1QbO+2i
 4ICIGarcjr3EyKGvPansiNS+SfCtjQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290146
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

Hey, glad people are testing this.=20

On Sat Jun 27, 2026 at 3:48 PM CDT, Jonas Karlman wrote:
> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> removed the suppression of ERROR messages when -EINVAL is returned due
> to the memory region not being part of the LMB memory map.
>
> This causes an irrelevant ERROR message during boot, e.g.:
>
>   Model: Radxa ROCK 3B
>   [...]
>   ERROR: reserving fdt memory region failed (addr=3D10f000 size=3D100 fla=
gs=3D2): -22
>
> or
>
>   Model: Rockchip RK3288 Asus Tinker Board S
>   [...]
>   ERROR: reserving fdt memory region failed (addr=3Dfe000000 size=3D10000=
00 flags=3D4): -22
>
> FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boot
> correctly does not make these regions available in the LMB memory map:
>
>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: non=
e
>
> or
>
>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>
> Ignore -EINVAL errors to restore suppression of this irrelevant ERROR
> message when memory region is not part of the LMB memory map.
>
> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  boot/image-fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 9e0e0f93edd3..603294215b89 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 size, =
u32 flags, bool free)
>  		debug("   %s fdt memory region: addr=3D%llx size=3D%llx flags=3D%x\n",
>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>  		      (unsigned long long)size, flags);
> -	} else {
> +	} else if (free || ret !=3D -EINVAL) {

Seems like you messed up the free error reporting here.

>  		printf("ERROR: %s fdt memory region failed (addr=3D%llx size=3D%llx fl=
ags=3D%x): %ld\n",
>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>  		       (unsigned long long)size, flags, ret);

Got a few questions about this particular case though if you don't mind:

Why do you have reserved regions defined in areas that don't overlap with D=
DR?
Shouldn't those areas be unused anyway? Why don't we just explicitly ignore
those reservations instead of forwarding them to an allocator that doesn't =
care?
Why mask a bunch of potentially valid error cases for this explicit case?

Why do none of the examples listed above have a memory node in dts? I've se=
en
platforms that expect memory length to be defined by the bootloader, but th=
ey
normally still place a dummy node in the tree at the correct starting addre=
ss.
