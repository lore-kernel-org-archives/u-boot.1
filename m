Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E92ECDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39A484894;
	Thu, 25 Jun 2026 10:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mQ8A1Ah5";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jkl/R1mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE00F848F0; Thu, 25 Jun 2026 10:22:36 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1889284704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65P3dt9S305402;
 Thu, 25 Jun 2026 03:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XhNBUFK+LdWl9eCxB1LByrpQM49UDx4S2TRsYxezj
 TI=; b=mQ8A1Ah5RwAZFrABe2BpMk58VFiDCTFz7nQkrlsjV1oLK4B4vjE6NQfBP
 /WIF6NdKMNKKzWsuxpV5kNVWjU7O1NAxfQhYXot2/ZFiUjcER8i/yN4Y+GKZm83I
 dkDM4pfMtewL2w8BdY0EQ2HRTxZzxEGz1I/6kow35YKV55sbUb6ssSuZ+Hwt3DPS
 JpvzEiTDVEYXomdwjzhNfKUXlplnPG0rzMvb/kZ5sUYORH67e7tnvXEtA06rhY9D
 mFvd8ZtIGQdLCqta/FpoEn44l8j1ABn/DAti8ybE/1EJtt9KmXWhqv3d7ov3+oRd
 snJoOnZwvKxKVZwUXx0H+xt/7ol1A==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f0ecrxp6y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 03:22:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGqb0DUr6OMTLoivlSwP2+WDhJ6BCpaAOD9wlMiXHSPbQOnlpW17EvojVPYnSPMd3cb2XGU+Jf3fxtcFIqigO4unbtu8VKwYQDF4cT598a8QsPA7J3gBSFbN8nz0HOeaIsDe02grGJFPvqfWW9+OnkImW2ci3bHfzYrGGO3QRb/nn311ENLqs7arUqYmaP+IgyPfa3SzPo3CYaABNxCeFNxriaCClvGWg5u4tKqH6JQymc2BhIDLcfr8wR+PTYK5RoJW2i+dsksf2Ujjp07471/gsWiCpUiOfmCKdo59ZzLFWKvZdwbadP1AcWzKUI+26sSbhe4brPxW1jHaOqwqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhNBUFK+LdWl9eCxB1LByrpQM49UDx4S2TRsYxezjTI=;
 b=k9WOsq/5flGULQu803OKFOw/5KaRxmZiQdckqHVGON46fIv9WF4hXwf1nVi1pwxrUQ8buWYGqnILYKNsdbzSJvEv1cg26GN3El7iuoAgTagdeCTuo/PDmnQpbNamb7KkxcNKeNVMkE4mRCP1x16VtyLO6vEohFwDlQGqlPFZpFPcLR63ZjwN6ybo/iZqhrsTlNTyb0wkbFisyq3rQKAfCw/KLwHD/h6nEELy67Tx3Knc23UFjKrUw7GTcWzq6JSvwD4Y+IrTS2aNMBsbigIte0wJw5gpPxMP6pZo1iGFsdMRzEgQigjH0eBBxn+kcrlfLWkYKRo5p9W+cb5vb5JiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhNBUFK+LdWl9eCxB1LByrpQM49UDx4S2TRsYxezjTI=;
 b=Jkl/R1mxSIANskTxtK6OyibuVT6UOeHJAqjcenS1N5dwGmzfdmu5VZ7gD1COvHXB5vO3Qpsd/L+Fq/Jp0WDhZgap+N1HkTSAsgn/+0hv6QAYimEWYN4V2lejqN7gaZOUxAOt0wXYibVLWh5VzIJOLFXEnerhyusm+ImxXnsSa1A=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by DSVPR10MB244415.namprd10.prod.outlook.com (2603:10b6:8:37a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:22:20 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::2a) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Thu,
 25 Jun 2026 08:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:22:18 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 03:21:42 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 03:21:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 25 Jun 2026 03:21:42 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65P8LeRv2311240;
 Thu, 25 Jun 2026 03:21:41 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Jun 2026 13:51:40 +0530
Message-ID: <DJHZGCZ2O03A.5YOY5378VIKG@ti.com>
Subject: Re: [PATCHv3 3/4] k3-am62-pocketbeagle2: add support for 1GB variant
From: Anshul Dalal <anshuld@ti.com>
To: Randolph Sapp <rs@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <anshuld@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <afd@ti.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260624211949.327905-1-rs@ti.com>
 <20260624211949.327905-4-rs@ti.com> <DJHO54H0KY54.3SIYX4G0BFWCL@ti.com>
In-Reply-To: <DJHO54H0KY54.3SIYX4G0BFWCL@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DSVPR10MB244415:EE_
X-MS-Office365-Filtering-Correlation-Id: ea442cac-4267-471f-8cd9-08ded292df0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|13003099007|921020|4143699003|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 2q4koZE0dj/PKg+oSL5zbmil2dETV/HYZR26EWMyh/AmAao/RCSfbteCuYRHUyJsKz3gbvpoNGa6VPFV5Ijp0filskxI0QKy2UlZnF5GkBO2ChQeApewWEl30neKBRxFGCqS0ARUjMUeexH9R/JX+XeVRjpzFZ5xklm1KLfRBcutkheUYGjrbtCXSa/osI+bI4ndrmfcu+/ZU/9e5e6rVjv8l+CWpTMHMFvyx11DOatxLr/NBg9/wlJ5K0gvhAP4LQZaZJGLlCILPSrbeL1VtllS9ZaGPWrKWYRoq6nvLisVVTyp7JPCiYE73BsE+Jn4y3aIJlYZgTa8s+WO0HkrG2+3laiXyZ5DgX3yHd1Ix0Xj/jzEdD88du4kBXWv3+CHuokAWIz2rc149/m/m9sSHxVjR6wGc1kmCfs1UQOLzb9V+lJWpzflOYSh4LOncT59OT6sAHbkwfOqlP4T7ru4E9jrXiI6YR1EY9HmomgfUC2/Dk9edz1wspwNr43Rc2DAP0fa2kNXfrI+QSyNiIcQ2EMq1B8jTyOSK/XWxXKmeL04I0iQT3jgx0S1Hndgydj6p0WHTQCAI1VBCRI3KH3bAyYoreoLjiT5NzzArVtsD25V4vzxL32xl8U4p4HPk7X7kYWm1eMS6+jj7Pm0gIZjK1o1moaEjwbJ/HbMWP6sFxt09Md9Lv6ViXkfgvOnF1f+
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(13003099007)(921020)(4143699003)(22082099003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7yjAODiErx/sqZ/455yVGc4v/JWU37OrkMC1V7lIER6tLhKgBw9nmlfK4al2ABPG9W6Vq/sw69ZkKg5CbuTBfJUzrxwTV0ZdjAGmfvJlQYZfn+14NTAhuwYd2QWJ5RqEoCVstIz3bQE++pu0XggiNtKAmE5QRuteugOB5PkyrAJf6/vBls99q3qO3YLy9XIFeTU1ktdZn7WC2LWcwGr0ddEAC5Rhr/5wshhYXFI+Y/88kNMntcRlt1dU0XRyw/4y4yGQY9daFmHjabCxgqb5+fF8IxMRIvO0G+FzGw6lFrWt3Cep/WUEVo3JU8YUMH0xL847CtHP8NUZborghmroomdWGO69nklBGSeDACX+wk/LToVk+kFhjghp3w8m6vZyh0nPoSC8N2Qn4iqi0NEXtEMn0I1qPJEyPymKNl+5GX7kS3aFAhJHJpJNf236jvdb
X-Exchange-RoutingPolicyChecked: d99LbqGcfTlOInnsUd9/tWENnBaXsyw8fg59cxIHp6sq5cFONl1v75I/cfZdtMvN+omwHgvIk2n+EzOGLx+U4H9sIFksExzmP6Iu3qtQ9jG3vIFhQXu1UQh8WNjhDqH0+ZzTCvBcOYw+indhai14xOLhwcZJ1Csmccs441OtXXSgMhVxQFvDVrNCUjWWBX9o2v6tLV/dIjpdwQ3O14sPxcKZarc62yTmn/+psSQliSVhAsnqJcdD2aBklmGJnmHASM+8vu2FDHWyHDfLdL269Zj5475qkfz5AorLyosBdYuhJGBDlu7Gye1rHKmkuRYH0jFwsRZeXzsVzZUdlfFDFw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:22:18.1116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea442cac-4267-471f-8cd9-08ded292df0c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB244415
X-Proofpoint-GUID: AnI_hvr1idSxNmqPiOJErrMZMv8WDYx2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA3MSBTYWx0ZWRfX8n2E0sPJgQcy
 7sH8XtWESw6EWtfLWpcIsBZGr6aRU7KC8OVyW/DCBNsu1Am3U3GLIuZYXPFpaz4Qgjt+gQE35AL
 F30smIXov8hCVq2vqBAbKcHkZiOLMws=
X-Proofpoint-ORIG-GUID: AnI_hvr1idSxNmqPiOJErrMZMv8WDYx2
X-Authority-Analysis: v=2.4 cv=eekNubEH c=1 sm=1 tr=0 ts=6a3ce53f cx=c_pps
 a=duIt1iBHFgRvnGs5ekVepw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=lLZmtIKjAAAA:8 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8
 a=rC513R23JSmisHieA_QA:9 a=QEXdDO2ut3YA:10 a=q5Nj8NTjyn2D8kUwajRn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA3MSBTYWx0ZWRfX9Sy9MU/ULkgN
 vMrnC5Iy2ClxZRwFIC+WOFhYIk97gerafvigCGOvoszNfbmv8jNhGQ817Tdm0YfkWPqJ3EQXp22
 f7DL6QQHmmWqAUGSndouOX14jxlTChO4UAFa1j/1EFx0pClof6kAxS18EoF+02mFwsu13KTx/j4
 pHlBCAZwdhc/lNPsaZtJBomWZYzg3DFrS/djHWnNTvrS6oT7GB0asklB+PkAQpqrqgLIhmFvRLl
 jLL1jw7i4rj3XjmN1AWN6WC1hw5gjSwGEW2mShGufYXT5KkdEibIoz3LNx1m/ahUcBD3KoU/1Za
 hJeGLzdNcZQPWqWHpnkXCbj9CSrNupmBt+8wCJ7ItgYc53xmpqwUOh8Arphije8FJs+M7eWTCAx
 23GU1+t9qfIGBEL/UPQg8V+KW7bYx1qWx/eFdiEFuZJITSWViYdao+v6HhIsidmWD8dZDvRA0dI
 AXn9+QP/UfP9DZrPNHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250071
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

On Thu Jun 25, 2026 at 4:59 AM IST, Randolph Sapp wrote:
> On Wed Jun 24, 2026 at 4:19 PM CDT, rs wrote:
>> From: Randolph Sapp <rs@ti.com>
>>
>> Take Phytec's current DDR fixup functions and utilize them to
>> dynamically adjust for variants in the pocketbeagle2. There are
>> currently 3 skews, two of which are both 512MB with the same memory
>> configuration, and one which is 1GB using the same CWL and CL settings
>> but a modified density [1].
>>
>> Based off of Bryan Brattlof's patch [2].
>>
>> [1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8G=
%20Bits%20DDR4%20SDRAM.pdf
>> [2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e990=
d7a33fd001ffb571e13cfc3
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  board/beagle/pocketbeagle2/Kconfig            |  26 +++++
>>  board/beagle/pocketbeagle2/Makefile           |   2 +
>>  board/beagle/pocketbeagle2/pocketbeagle2.c    | 103 +++++++++++++++++-
>>  .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++++++++
>>  configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
>>  5 files changed, 184 insertions(+), 2 deletions(-)
>>  create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
>>
>> [snip]
>
> Just thinking out loud here, but maybe we shouldn't take this patch. The
> industrial version, on top of having more memory, also has eMMC. That alr=
eady
> mandates a new device tree and configuration if people are going to use i=
t as a
> boot method.
>
> Then again, maybe it's convenient for the users who don't care about eMMC=
? I
> dunno. Seems odd either way.

Since it's technically a different board altogether and not just PB2 w/
extra DDR. I think it might be better if it had a separate DT and we can
decide the correct one based on the EEPROM at runtime using
SPL_MULTI_DTB_FIT which would allow us to still have a single defconfig
in U-Boot.
