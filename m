Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A07C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 11:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727F284AD0;
	Mon, 13 Jul 2026 13:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YhocUVGF";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oOmTpADH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE6384AD3; Mon, 13 Jul 2026 13:34:37 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EAE484ACE
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 13:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66DBBvxe3407720;
 Mon, 13 Jul 2026 06:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=jxcvoGChQTX9oWcz0HV7gi0/I7ttQXvbDYgqjcgQN
 co=; b=YhocUVGFg6uYcqc8+fcKJaMb1C91i0Rzq/frscwEesRKwJE71N98gJXE4
 E4CUe5M9/mUPgpsiF8UvPc+tOol1re6wlzvPvm7sIht/J6n7EEOHDV6LuB2Ni6dV
 tJ05cH0SBFAyY/586U15B4GszNz7P0n3LrI9VMtFE+oP479tjaquY15uF90qEa3I
 YutR1dgBjPeyig2gAcGQrm5YLEFfgFyt8U7i+axpZYGrsrEsRi7ZDy2mHzXMIHAj
 ljnCSUMms37AVSzg9ZSM5jjvILH5O75Lm1yMn4j2Oh5e1BXwOz8INMk0cZFk6nI5
 80ffX5k5OWRUi7v7SO98ukUsmqmHA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fcxxeg36c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 06:34:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgA9bOB0dRmwBjXlKYEhiLtfriY6riqTgHJHyNBXyOw29r/w3ImMh7w47PV1lkVp3u2Nutt+wUGO4B6rMuY6f0+wBDu62ypjk37BSgLCxYq0Q2qAyrYp51LCMu4tQi5iLXlOSOPckhfK5ajO++GF+cNBVom0aL/3tqCRthHROO+Uolm2DQ+6H/gxmH0qxrpP6UVivTmWmaseVZ/QvIwy0/EBbSzClgT4SmId/rL4Qa03wd6lkBjjZZAKLqsMMFKWmvAL2ct7A+Bo+Lub4ZACpWloTbD1fwI2kDJ8RqkJH/X5Cr4H1YTnqVbQfgtadLdKYs3mEmSudUSp1Sofi+3TuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxcvoGChQTX9oWcz0HV7gi0/I7ttQXvbDYgqjcgQNco=;
 b=R1rhUCw9ka4YIC4mydxnnvLktcBJHNC4sSywlC9Ft3x5N2BdKpdoi+bOxZCtx4cEaptzH8hApjY5y6MNZy22bvfZz8lhDNJazKav1UisE32pHsxQG0sFiFW32cFlcEs/Y4fETI66wdEAsxnUV9G1Uf5/kz4+q1lzt1qeZYNbsphym4g6Izo+4kwkvJzXENoagq0OPhybc+XZ5N4GhEVWAHBQW1EzG6xpxf6B98B7KUMU0CdZHV2iYvaqpkE7A/KgpcDcYWEMG6CAMO5OKDjfo64/1YeCsQxHYF+6kBX7eUn6W2DKI14vKGNoitZZ57gmCtWXwfDWfsagQnRQei0S+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxcvoGChQTX9oWcz0HV7gi0/I7ttQXvbDYgqjcgQNco=;
 b=oOmTpADHGJCW6a+ZcY1NOtbntpLsX6m834NvT+Ps2P5qWUrZjZGENFNLI2W9kptDqCnO9DHYMSXL48S6uHIJTpykhuIuKBqTohp8QDRUh82Y1u/uOJS8dUKCmTOH840HW6ap9OawuIbTPp86CuWY1ItZAtdOrjULs67QHeybyw0=
Received: from CY8PR12CA0038.namprd12.prod.outlook.com (2603:10b6:930:49::26)
 by IA1PR10MB6266.namprd10.prod.outlook.com (2603:10b6:208:3a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 11:34:29 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::1c) by CY8PR12CA0038.outlook.office365.com
 (2603:10b6:930:49::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 11:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 11:34:27 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 06:34:26 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 06:34:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 06:34:26 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66DBYP6J2054739;
 Mon, 13 Jul 2026 06:34:25 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Jul 2026 17:04:24 +0530
Message-ID: <DJXETQLM9PQP.C2LCLMD6LMI@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] tools: binman: fix changes not being written to source.dtb
From: Anshul Dalal <anshuld@ti.com>
To: Simon Glass <sjg@chromium.org>, <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
 <CAFLszTg5Qu3stt8AkeBpWibTyYxp1tXAern3aLE6MEHkHmVRyQ@mail.gmail.com>
In-Reply-To: <CAFLszTg5Qu3stt8AkeBpWibTyYxp1tXAern3aLE6MEHkHmVRyQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA1PR10MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: e24bf42a-ee80-4fa5-b04b-08dee0d2b268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|4143699003|6133799003|17002099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xXeAtxCudjvzPafKOXENmCmWnamTFn1BsG7zoE+eFUnSw2Ry+jVnPCdGqbZihtPHA3GscPyiZf2TirE7riIntP1OSqDbA8hxzFCWbwJnH8oyqFY5QN/Pdu9PVH8s4lFSx1KAy1p90SBzaB8mB9+/oAl3n42gq4+6mP6VMYdEmBmtVW7W8kG2zmW+DC5BO/Vtn2trgf4N2U+vRU3br7sGO60lHnBDMdqeAClvKW4Y0hGyoRyGKOpI/ffrFGq5xfeDgMbST+ATVgVvHonSQOZterF5IfQCPG1r/m2zBkZENUk7uaEWeGX9q7FpQ7+jT5667ePYzX0AA4o2lqs065NYwZPUaKIU5ia3wAFa/9/ZJRNIjLuQpS9aEliWP39u8Rv/fjzKvyeSoZr6b2M6lhPVZxDgD5y3OFSBlb9TBYdbZ5r61tyJYKyJsqNW3bs980E6oe1L6gDSbzitpWZlbUshtw4K4fd2QC40bk9hObnVvgwVNAIF67WM/TlVxmnHJ6HIEKTjzEr5DZ+IMQ+zhVEoVnNNsF5YxZfUSAO/U598+eJ9WOH57Z6qTkUCLk+bAmIH6Mv8xqeDjw1jDaVRjQ4dNZJpH5pRdX4UmAYVOw/Xys0pfsGykZy8F/OB+t0JW2Y1s2mAeogG5IpIzZYoxRGFiQKaJP+uMO6l0b7KngwnvozsZm3gqP+GCO2pvjjK5VNW+zPODpkzZ/rPQm3NvBGong==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(6133799003)(17002099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zfKsnBJqJyfOKUAT0pYQOZMbG0nWkkp0uAq8T7ALcQjnuEvDY+kHXyO22lNGLuA45a1rLvWurkl33h02WQYtIvRoWi+2OFO20DgC0MK3mV0MJE45BN2379w9RFEum2/2xSO/ZWuzqa0yvkEAb11Nrd/Y9J8KwyyZUWRBSaf6YVAteXbaAkSY07e4bVq9/QEaOLk2avIAJw9ifv+EaurWpKV0T3+A2ovKGMqmFKn2XNPKRGmEdP880fuawOPglzK60YRcwA3ppcX1ELoxfpSf/ABfyjbmCYwYnVkCpoZfFIXYCj33WRqZ8F/F5qO2RfUSCMPRtFdkGDziEwVIRkDnq9pqLpPa+tlWKzpCuqsRStOlU3bgqdjMY4P2uVV8D4smEWEv+wRYbAfTlG3cRiwq7DxjPvXfSRN9cyHSloIoCOIwMve7OkcIhf8iY8gMyEWJ
X-Exchange-RoutingPolicyChecked: Tt7Qw90StL7aJzJ9yiEE15lU/ILAvcrEZfDGBARXaNCTjsBk+I51ycrx2ZqC/jhDo0TxlmchecZ19M5S8LC362x3K9Z1vDWSj9FVU3QMhBdYrDEPXaIgfl4XaaaQjKNgj7oYOPx9vdvpHhn4PviXGPN8TklTekAWFpaQdlAqAwudyA6WD39rzOFO36SDYCrVar2PTivtn65uUX7OWopHyGrZjDbNTsqD3Pl1hUBYy79xjFmVIlAKbjV+Vkb5q92UDuuaaMkU4VwGy64Hy2/s4f+6yjg00Xgn3k6W9OZQDG7rOh1HJ2kYTorh4xN4Sr58s0aqQR0J11zJYRHe/bAoWg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:34:27.3339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e24bf42a-ee80-4fa5-b04b-08dee0d2b268
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6266
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMCBTYWx0ZWRfX3P/ovdQEUVra
 rDrPRCKd13PJ7x32dExc/I9IXwy+I5bIKvIDysxY7Yd5/5BVIbo6pEtUt05cTdt5rtBVMzhrN2T
 Y1V0bH2MqhGqm/LG6rHXES2nfKsUIcmOFsHt5aNu1+cwsHUm0rohqDUGHklGUR8CkPSHmdA3fWI
 MvP7NU0gFiJ2y6CPJ3dIxQt+bgDBXa4mHd5A5lIXmBPn15QEhEbPCfqmVuuOlnSSF73CVMWSj5J
 +J9oAPwPBSUtD3uBNMUeSCFgfG12A3t9xpNXue8rrhCXDo6nTZGbkqmpjrT+EvtKRueHnhnGkz9
 ckydpdx2TxvReZIbJ0T/829Bg0fB90o0mQ5O7f+9nRxwjMyDc9Zk/9or2chFJosA4CaZfdDY3kV
 OsUrh1dm/Fw/2/nNh8rCPOkIRXGT9YKG4A9/kkM6EO1l3DolNdZitPBhGewMjRYM6k+Ld17r6Em
 WS2asjNGZmLvZv4PmsQ==
X-Proofpoint-GUID: 0nTyY-2mzGxpcR_oKB_Gk0Z9QcVKA98d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMCBTYWx0ZWRfX3dIv9IAeHS8U
 C9dUc1WSMB8uIPBGEChQlmy1/kSrBqZVrVIhJLYkzkUqQA8NVF62R/TMDtcHbcgKlm4MwxciS2y
 /gcVf9e0GuK5zzQonBeXHeJiHVC/Gwg=
X-Proofpoint-ORIG-GUID: 0nTyY-2mzGxpcR_oKB_Gk0Z9QcVKA98d
X-Authority-Analysis: v=2.4 cv=Frk1OWrq c=1 sm=1 tr=0 ts=6a54cd47 cx=c_pps
 a=jlQ7B5VXLElZiQQO4hIw4A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=RsopJnYuEEColuVQ03kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130120
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

On Fri Jul 10, 2026 at 12:44 AM IST, Simon Glass wrote:
> Hi Anshul,
>
> On 2026-07-07T10:44:09, Anshul Dalal <anshuld@ti.com> wrote:
>> tools: binman: fix changes not being written to source.dtb
>>
>> In the current setup the changes done to the dtb by binman such as
>> bootph propagation are only made to the intermediary *.dtb.out but not
>> the final dtb.
>>
>> This means the final dtb that's in *-binman.dtsi never gets the required
>> changes applied. Therefore this patch fixes the behaviour by writing to
>> the supplied dtb before exiting with a modified test to catch any future
>> regressions.
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>
>> tools/binman/control.py |  3 +++
>>  tools/binman/ftest.py   | 41 ++++++++++++++++++++++-------------------
>>  2 files changed, 25 insertions(+), 19 deletions(-)
>
> Please can you spell out the concrete symptom? What breaks in a real
> build when u-boot.dtb doesn't carry the bootph propagation - which
> stage reads it, what does it expect to find, and what goes wrong when
> it isn't there? The *-binman.dtsi reference is confusing since a .dtsi
> is a source file, not something written to.

The actual issue was observed while we were adding support for our a new
platform 'AM62l EVM' to U-Boot where the missing bootph properties meant
that the parent drivers were not being probed leading to boot failure.

>
> Also please rewrite in imperative present tense: 'Write the modified
> dtb back to dtb_fname so that ...' rather than 'this patch fixes the
> behaviour by ...'

Yeah, the former is more clear. Will fix in the next revision.

>
>> diff --git a/tools/binman/control.py b/tools/binman/control.py
>> @@ -677,6 +677,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, u=
pdate_fdt, use_expanded, ind
>>          dtb_item.Sync(auto_resize=3DTrue)
>>          dtb_item.Pack()
>>          dtb_item.Flush()
>> +
>> +    # Copy the intermediary dtb ('u-boot.dtb.out') to the dtb supplied =
to binman
>> +    tools.write_file(dtb_fname, dtb.GetContents())
>
> This is updating an input file...really not keen on that! The updated
> dtb should already be written into the final image created by Binman.

Perhaps it's an issue with how we're using 'u-boot.dtb'. As I see now, a
lot of platforms (including TI's) are using 'u-boot.dtb' as the fdt for
U-Boot FIT. Do we not expect the final U-Boot FIT produced in those
builds to have this propagation logic applied?

To test things out, I built the am62x_evm_a53 platform and the fdt
extracted out of the built u-boot.img lacks proper bootph propagation
without this patch applied:

	fdtget -t r build/u-boot.img_unsigned /images/fdt-0/ data > extracted.dtb

It makes sense to not modify the input files so then should we change
the DTB we use in the u-boot's FIT to 'u-boot.dtb.out' instead of
'u-boot.dtb'?

>
> Regards,
> Simon

