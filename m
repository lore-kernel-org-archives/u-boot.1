Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494E5C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8753084AA2;
	Mon, 29 Jun 2026 20:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZsLxWFKN";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BVCFyBTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57C984A93; Mon, 29 Jun 2026 20:37:53 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1653849FB
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TGUYrH2586196; Mon, 29 Jun 2026 13:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=N/GNTu+U0JYIz21ybCtCKz04R5M6QKXn7u5ANUxin
 tE=; b=ZsLxWFKNveLoFfHmdIugP5XJVFAsNJI4oIDTqoT3lA2FAUc6+9vnfrTzv
 qRk/NfjgA6zDr1FzkDeGOQnDL0rayB83U17IROB0Bo91A4yVpMJ5/ijLTx5fJ+2x
 V16sJKnArH8DCwofWjwO5Z+KW2zt6MRCYvW7g6d1IU8e5WKMSDkW/f5EtqGBi5xE
 7KXpVW/5PfQRL94Zek+2/GmTIt/5uvMmyzX1q0q8nGK9rC9j82ti6aKHeUcsfD/x
 KDmpi1OfzagC3PYApXieEb+/MtNV1VvOWJNjZdKNNDu/WULS17NUpH09004eR+f8
 k+MWivZdrEnA2LFa+JXO+Ob9reIQw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f3qnguk9a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 13:37:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaSP137WaqPKHcCjADL9CKDKFsWxzrvgWqejfsKzYLu8VZ6qMLEmKptizldvPLuhDwCe37hYfAdPxwMmWRJKhby0VS44iYapwUbBe5irwMcv4s5D1PAbL0xP4neMprD/KJ76ptQeujHnpUSA+m1zNTaxz+e3HWHZs0UW/PDye5kLMn3aWrSKIFcUiaf1tEo6n4FbATfE5PUpl72SK59h5b7X/x7Tj2PrTo1L1UsTf1cmhqL8Gyu1QZrOdbaVArhkUIDze8HbOaNNhlMXxryHOFHCaOoXTXw/9+VZV/LoF8JCUnYk9WMQR0GMNH+vn+RxYZjHsJRqVgAJRIqVRcMfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/GNTu+U0JYIz21ybCtCKz04R5M6QKXn7u5ANUxintE=;
 b=uUUVqbweTaTC9T5rKGdxNtUSPDl7ue8gS0HJ20PhpFZKX8dPPXM8lgdzINkryvX4LkgK72JPzTxhXdIYSAwNGxJqwGtkJpaMEzJf4vkMYMbPHIacb2CJOTYIf59J+kljWPBBYNITIBy/LdM/o8iyCuwCXGEAFWBHR6ViFPY3S9vc9PkiMaTn1UOnweg/KiuCoq+PekxM6om82CZCD45jp9J5h2uCB7CL1Z23ATtSy0hUlDCr3NpndXnFg7VyuAq2f4d1vdsyJLnJvS83QLuCd/THaQ53zDcn+166pUwm+qMni+OKP7IJZ3voidnX1o7Emu5K/kV4fU3eUsZHnQdRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/GNTu+U0JYIz21ybCtCKz04R5M6QKXn7u5ANUxintE=;
 b=BVCFyBTKAYmGh/1b6tYG+zGZc5z1vB8IpZggRybhpr0NnYt0lxIolff42p6odyGrS9dva45y13wlBcNOCxdvozXLEnVil0SzJuRxFHmvBGLT2ysWRGS9XaOqZMQ348u55GnwqTHEqhZ2QAbWLE504gCmlJ3JMdiUkdC1G32e6as=
Received: from IA4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::10)
 by PH7PR10MB6177.namprd10.prod.outlook.com (2603:10b6:510:1f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:37:36 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::17) by IA4P221CA0005.outlook.office365.com
 (2603:10b6:208:559::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 18:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 18:37:33 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 13:37:10 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 13:37:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 13:37:10 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65TIbAcq1203139;
 Mon, 29 Jun 2026 13:37:10 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Jun 2026 13:37:10 -0500
Message-ID: <DJLR1SYPDTS4.2ZVE5UPMD7COE@ti.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] boot: image-fdt: Restore suppression of irrelevant
 ERROR message
From: Randolph Sapp <rs@ti.com>
To: Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260627204851.1151419-1-jonas@kwiboo.se>
 <DJLPP0RNHT5S.2K7TOQJSA7VLV@ti.com>
 <1080aff7-c678-424e-9b33-a56f7b0d7be4@kwiboo.se>
In-Reply-To: <1080aff7-c678-424e-9b33-a56f7b0d7be4@kwiboo.se>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|PH7PR10MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a323850-78c5-45df-4201-08ded60d7c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 12ViopbZnWgPhLVJ9I7h76Xtoi0SNREv1CqCuod6ug1jurTXlq8mhaGTMDeY7zRCA4+O+nLAi302mEz84KT/L+7QwUTWEy2DmwalLRo9WkUjw4sbq16gFA7Sc36RHsVX6MJJV4D+egX7jCXr1dIpnDuk5HhHMi76cTjhqBVgb57CnrkXAaiqA3gkXoPiILxRJh9iiEKY8lH1LxyyanjrGZTYFWG9K4LL4sLoJvx6HvGTU/B3L5u90GvbJR0cQxdZEUmua5Py0Ya49VIhrLUq5RnT9k3MlHhkZBOVURMSJOJ/gdoJmgy9Wzpj4oRally0uMAL6tZR1S08+kBhjR99kL2GZkHK/BFl3k5UNYxnMyLlN8e66YRZsR3ejS0v7FcGQU8sBY0ihckfg4VG1UoxCvQ2gHHQX1S6usoGBeSRGax9Bf6kfRhvH3ESoRAXLLIxpG1Ge6IcTKGhENYBzOBrbzVb7C+TxLkkpXjzvAsJgw1R2cLnkfBWbxS7X/Rqslxa2voq4vLMw9irI+Nh7+BHawENe7H7AT/gbJIalLqqluqYLsgcK4ej6uDe4GtVXtFYINJNtTE71wGzhqsz9VI6XOgjA0aX804wIMza2F0HsokegkeY8tjc9fAZmQRdbRKLewMtluXgeTFtlg9gEwDH1q18lTzIBRTP+EPiUbLWOubn/vwiR8ocjI1sisZ5/vBeLXi4n3IdlmudeIZsX7ydWw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ky9ppDCFFjCZgIqo8H1Ypr+U3+YlHfWheJJQe+rTLsrm3XAQ0sBfJdVnlyKXYllV63504pfx/tFtB2FoT3xQ5VMWu/f9jvoUndAgn6wR1+4LCmWglQcj+VX/LsUNHnZ1fpBYvc4H5s1pcgxptNYQpUDCHfcMO9nUT4kZtmMLMe1Z313iTYlkhh9mVdwIdJ019sKl9h4QVy/xxJTP1t9qEswM/nFT9SmIP33EgLHVhJ+Q8KIm9kQBH+4T9+b3fld0h7Y7B/MU1a79c/q/9jLpvrFbQKGEsb9YKaF0jgFpqY+XCtpSaPCjwaS0+jkw2u7a0phHFA0ZhUFXzEjfayZcIGTOlGORLpsi+e5o62ORv10iAT+9mai67tScd/btsMGOQiUgfRcwktBUT6JK4Pwq9cWXElTBo5LVHEGgutCfZ48i6DpaC5rzelsvkcgjlgKy
X-Exchange-RoutingPolicyChecked: RbYAKDhnXmSfKPa6vBPi5eepYN8e7OT3ooOi2cO+OZC0dc4uWyHbdugneYFW9H8Nt7P5zhHXbWBz3Htrmadc7NisL5JmDsOpm6hw0BO6QomFIKzATAsz2zoms1MzfQ4e4trghCgIzM9EVOfJ3ocLQPPoUx59H9uWZGdfa/8fsLTrrPJiRnm1qdWCiiTsab68vQsXA3G/dY7eqSOeiNsG8MdkjP/wE/U5o37IaqBrH7uFQRYHHVchLmHjA5ufScBaqkquYb7tX7b4oLzyQ7KanEZUHRzMi8QZ9n4d+vMpznc/GXX55Jy6l/IQ/9Tg5Gh2DAJ6Vrj+P8fkGuvkj4FkmQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:37:33.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a323850-78c5-45df-4201-08ded60d7c3f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6177
X-Authority-Analysis: v=2.4 cv=Yow/gYYX c=1 sm=1 tr=0 ts=6a42bb74 cx=c_pps
 a=GeWWyO5P+zJVL7v3m8oIig==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=XOa-7KCDSkpJE81aA2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GYUoHQPjFfJ2YDRfVp4otIJpcGIe52TO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE1NiBTYWx0ZWRfX/0nmiMcEsnrn
 7PuoVPoGvCYS/hI3E9kLqz9xFU43PfRUQSSATT0umpWyXBv/CSs9LEs8TCSDTymQtaBRpUBTK2d
 cntv/WHsuocH83n/9YodxPjTwyF4Bc2uJeouaqbXwkxd1kFyroE4HNQRew4kuv6iCBBOSzTUiI4
 b6tEIpb8e0nBCbcBvmWoderM2s9vIo6VrbgVqsTbYnYpI/1Up+86QtSFmeUehabuJFROql2vfQm
 GmWG3WxUPfwlSUJF3ijACk6HF7X9gSMI8YOFh9pmHSneF2aUXt42632vNOiv6vUJGdtEy7/CBqc
 ua8H0OrgmwwbSLgDfWwNXDpDsacLTtvJ8KTxSEyswDCKgnekeQy4pEHwtOGrheyomEeCMbLZiAq
 QJJ9JeVbbflum1HbcSbSbBroBYSw83AXDbvOqsNikryhhrkn0AvQR0rndBBV/U+6G/wRZBa0tw0
 ywQd2zQZKZ3jR7nltYA==
X-Proofpoint-GUID: GYUoHQPjFfJ2YDRfVp4otIJpcGIe52TO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE1NiBTYWx0ZWRfX7LJof94d018K
 AvYFGqjbX787KrI1DP21shGJHsiSHF+LlkQa4ppREJmrxJn1w8W/mTwVymPJ71E7OxK10HXcKcb
 SVVuQ8IZBR8hTxblqAIdMjY3rT1fDPY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290156
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

On Mon Jun 29, 2026 at 1:14 PM CDT, Jonas Karlman wrote:
> Hi Randolph,
>
> On 6/29/2026 7:33 PM, Randolph Sapp wrote:
>> Hey, glad people are testing this.=20
>>=20
>> On Sat Jun 27, 2026 at 3:48 PM CDT, Jonas Karlman wrote:
>>> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>> removed the suppression of ERROR messages when -EINVAL is returned due
>>> to the memory region not being part of the LMB memory map.
>>>
>>> This causes an irrelevant ERROR message during boot, e.g.:
>>>
>>>   Model: Radxa ROCK 3B
>>>   [...]
>>>   ERROR: reserving fdt memory region failed (addr=3D10f000 size=3D100 f=
lags=3D2): -22
>>>
>>> or
>>>
>>>   Model: Rockchip RK3288 Asus Tinker Board S
>>>   [...]
>>>   ERROR: reserving fdt memory region failed (addr=3Dfe000000 size=3D100=
0000 flags=3D4): -22
>>>
>>> FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boo=
t
>>> correctly does not make these regions available in the LMB memory map:
>>>
>>>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
>>>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: n=
one
>>>
>>> or
>>>
>>>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>>>
>>> Ignore -EINVAL errors to restore suppression of this irrelevant ERROR
>>> message when memory region is not part of the LMB memory map.
>>>
>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>  boot/image-fdt.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>> index 9e0e0f93edd3..603294215b89 100644
>>> --- a/boot/image-fdt.c
>>> +++ b/boot/image-fdt.c
>>> @@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 size=
, u32 flags, bool free)
>>>  		debug("   %s fdt memory region: addr=3D%llx size=3D%llx flags=3D%x\n=
",
>>>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>>>  		      (unsigned long long)size, flags);
>>> -	} else {
>>> +	} else if (free || ret !=3D -EINVAL) {
>>=20
>> Seems like you messed up the free error reporting here.
>
> Not sure what you mean, it is only lmb_alloc_mem() that documents:
>
>   -EINVAL if the requested memory region is not part of the LMB memory ma=
p
>
> and seems to now help print an verbose ERROR message during normal boot.
>
> But maybe we should also ignore free errors?
>
>>=20
>>>  		printf("ERROR: %s fdt memory region failed (addr=3D%llx size=3D%llx =
flags=3D%x): %ld\n",
>>>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>>>  		       (unsigned long long)size, flags, ret);
>>=20
>> Got a few questions about this particular case though if you don't mind:
>>=20
>> Why do you have reserved regions defined in areas that don't overlap wit=
h DDR?
>
> E.g. fe000000-ffffffff or similar region is reserved for hw regs, on
> boards with e.g. 4 GiB DRAM this area is typically unreachable, on a
> 2 GiB DRAM board there is no overlap.
>
> The 10f000 is shmem used for SCMI, so should be defined in DT.
>
>> Shouldn't those areas be unused anyway? Why don't we just explicitly ign=
ore
>> those reservations instead of forwarding them to an allocator that doesn=
't care?
>
> That is what the net effect was prior to the changes in 623f6c5b6ab7
> ("boot: image-fdt: free old dtb reservations"). Rockchip platform
> dynamically declare DRAM banks excluding the unusable ranges, and the
> LMB allocator ignores ranges outside the declared DRAM banks.

Not quite. I mean, we should ignore the region explicitly. As in, we should
never even request to reserve regions outside of LMB.

>> Why mask a bunch of potentially valid error cases for this explicit case=
?
>
> That is what the code have been doing up until now, a different option
> could be to change the error message to a debug message? Here I just
> tried to do a limited revert to the old behavior.
>
> Why should we print verbose ERROR messages for something that is not
> always considered an error?

Because under normal circumstances it should always be an error. Occasional=
ly
asking for a reservation you know is going to fail and assuming all failure=
s of
that type are OK is a little odd.

>>=20
>> Why do none of the examples listed above have a memory node in dts? I've=
 seen
>> platforms that expect memory length to be defined by the bootloader, but=
 they
>> normally still place a dummy node in the tree at the correct starting ad=
dress.
>
> Rockchip platform dynamically check size of DRAM at runtime and declare
> DRAM banks for the usable areas. Possible a fixup adds a memory node as
> part of boot into OS.
>
> Regards,
> Jonas

Ah, thanks for the information.
