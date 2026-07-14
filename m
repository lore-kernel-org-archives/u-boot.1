Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADB4C44501
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 05:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E14A84AC7;
	Tue, 14 Jul 2026 07:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kPsV+UtQ";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a/45lLcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D3F84CC9; Tue, 14 Jul 2026 07:30:04 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E0B84A5D
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 07:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E38mWu1087188; Tue, 14 Jul 2026 00:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=B/+T7P7IUkaqKIDMZuOw3o0GNb24P2muUbXDCgLZx
 yg=; b=kPsV+UtQN0uyur4nWO4K1R3k4v3oK/hvh7xT9m4LG7pD+a2wk8gTFGbvk
 nRQBd7Ba0aBcwJey72DJGIt3vm28FaFjHaWpNY0w/vo/DuLGUtXWPW9XrEwiUMN3
 2AVuZEGPuBG+6sIXnkLsTblWQcwpqr98cM1t5Qj6SXaVfhjkRZrJYdczMeFZaJ7Y
 U1XJt37p9bsQBkjMGYYesq8aqzcaWl67UQoo7F5DITjUqTfjEIG0/j6b5j0thbto
 EtqkNkHy6f2kef2ZSfjH0HQ4J7e2LivjdZ8VMZAhUeiRoCM5avjj/IG2QY0q8tQO
 j/BSA5zABJQBm5mbLT7BA4sqSEL5g==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdcwu0h6p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 00:29:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rtm8bhh+FCw5ylZ2omcX2axFOFhDyQJoOz9EUZsEecckFR4rqG+coIix0iBSUQ8lrMY7hPzKQsykJKbJDwmhV8BJD+fh8xoOgmLgCdCFRCCneJtXruGAQx0sVk5FmOC1jCNIreRgBG50P64PdTjEuFv1qw4lk+hM/KHUx7mzTr1qbJw/bBhtdfbQIqZr2uV+JktlCp6auZ6cfc0g1vBS3pxdW1zeATXHn2irrsQ0EDHdLSggOVBkgfy1s8eiLc26FJioH1hAFdToX3rpeemV9W661rlfZyahjQWa5SQ7DcCQTq2s+X3FrEgfDP1Eo0TU+fcLHV54KYbLoZsIKd5VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/+T7P7IUkaqKIDMZuOw3o0GNb24P2muUbXDCgLZxyg=;
 b=SjxgE4rf0RGLc3nKVvm57PGknbs4cnGr4zLxgTumyHWQhSwxClubY3N7lIlk9y70Nu+ayuLRyie8PkwzaCQv97o1IkoIT1G9yxNrGk902rrC0L9UBYIKbs3hGAf83PKKqH0HlS15VsTl3DFWC7VBdE+72rpF78Bvbsz2MUO5vMNYNvenW1+aUy5cSmTtyFpz9NtW9QOmj4cQ28mC0XJPL/aXVrSVJM1hpAofjqlnEi8bhb5DIqPX7dEwuxlrE4uqbiAJSJAU/P3PbMU0F/YFhqmAoX02OQj55Yeic/SwQ+XwKkOhiF+MchMHv1+srzPxNhdBBOHcFHSsOYVRB4iZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=prevas.dk smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/+T7P7IUkaqKIDMZuOw3o0GNb24P2muUbXDCgLZxyg=;
 b=a/45lLcWuSdmtv6c96T2LvUalbMpVKmu9JAHTwKZ7OO4bv9xB/qFNLfjKeNYX6608XQ27wwDh5lABcKwNPAcCEQwEkbQpin1f6VqmYKOKSwODgxrW+K4B0g/Hdd7uuNOIJKaoCPmfOTHkaC2XMFB1Vu5VPQ/G7JkE8lTbI81tWY=
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 05:29:55 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::9c) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 05:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 05:29:55 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 00:29:54 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 00:29:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 00:29:54 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66E5TpI63945363;
 Tue, 14 Jul 2026 00:29:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] binman: openssl: refactor creation of
 Distinguished Name section from dict
From: Neha Malcom Francis <n-francis@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
In-Reply-To: <20260710123618.2036728-2-ravi@prevas.dk>
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-2-ravi@prevas.dk>
Date: Tue, 14 Jul 2026 10:59:50 +0530
Message-ID: <178400699002.2406821.14193476014351515293.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784006992; l=772;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=DRcVkUfmtbMIoNQcmSWEP8hegOxtvbO0ae/fc+4ajVo=;
 b=PwcxH+jBbHV+lovqwVQZu9Zntoj2dIqmzoNJhWN8u2zXK5x+e71mOB7aqyn/y2OM6fLcWIjtO
 xBSWY303yZCCShW2LLaCyka4tZQWVIIm4SjIJp+rsdP8CDr1OFTDInk
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CY5PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4935d4fe-35ee-4f61-01f2-08dee168f004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|6133799003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qf7RF3JbCJcV8WYmEWju0PAu4hktlli3nUl2EioCPMJmtYq4XbIwbve3o9j9W76XyPy8qurzjLtZactG5mYhusU+9uHx5zYXyNZiVWPLM9LiV5UCkhw28xg/P9vAwcaNKPKH2NGGfF4/aED+7h2Mzf/JSY93F3lW6vqs4+8mhX7t615xxTC92+HoYKPw294xQ60/Lb3R2EmO7ko6235HabX7vqe50UjylOmVSzT11kwuhkRYAS1/4T31ou6+0tbQ2KZd4tR10pux+wPt5MKjA/cC5jzvdAPumYpnxEcNEKVbUyeS2qUagoUJ+IwKIWvM3OmhknKVvSWrJGk5wL7qqjKvIryLdrrwUI05MEZAl1zjbOFkIGzeMa6OhQ6jly5HqON+R8w+Tq+WkL3u2wHgdWBE0ucNT6x0GRlIMBj1nJRKvTWnOBfxykx1Hm9qswQ2FY/Hr1+wZx6KeQrHY5nXslwC218MCZL6CnoprZWXIjdbts+1r5IKGtUv+PIz6ukijPfqdoONgG9lQjRFSHG73dIyqVVqkH92Shvpc/wG8TcpzSIpKnwlBwjIrzuP9m1CV3YRUyqu4Qdc3g+D0hOE12bZvNewkk5JKoGMvbWcIpkfY6LKc97iVCiYUbzfro7bpjlYFgsHhgpsvn80m9tYt1Bgz3owO54TnFIuW23Cieil3kFA1XQTT6W041Bu2R3/Y2XPLk59kWXMPNUJxXgLFg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZRa7O0gWF3LmtL+rWaD+ATJ9dkqSWju5TEURMv83MzItWbSO/B2u9RtezHEQbibhu+ErMGopP+jRPw1KBwvwbbD0dYwtF3THEGC6ejg11viA3QchN5gjv+BBjtZB5/vWn+dF+hHq6JLlcGb48Ofc3hCa9JZmGB8jy+a6rPgWkZn9psC8cJ9x1yXWsVdnhpltwcy2xpCjRL1fTxMvvLTbcFUSa+tvhqS1lDV8XjMnm8teE1rj4ScLZF7447bj21IBC7OhCFJJgUxr0oMsx8oE5v5zl/x0Lgd2O05svrK1RWCaibe9+uU/HSIMiOzjDA2ATsFufAI0iscAs6HxhqWuwgSrtoyQM6CaxOZ91UkK/XOwnqsghgVe0dg8gCYjg5xsm4xtKF24Q90Hyf+u8TsI3RTwYHqsh+g5tiFaKr14zfrdno1YsdcjApQwgR0vX6K9
X-Exchange-RoutingPolicyChecked: YD5otFO/kOz85NCsBz2Ay3LGdNq0jvf+1EgsWmkgAgseIHQedJrbNH1kS8/Z81m2fJR89TKmLXPu2eTVmuAzp4hhbWK1VbCoKkVYe5nZAjM1aksyfexI6wQHBlbPLh47JYWak75LcrHKTCgDRIy8HKNeAS4nqNIT+E1yGLKryP6mCsnLBacDMoPLo8Iw8N2HuKu6xn2TZE/0tspeI9lWhfKTiPxhdRdQ0T8CbG/yekCca6IEbPqeZdCTHK5Pgr8MTft52nqZ2e90ZWkB1aHa7wcjQT5pEiFi9EKNlzjRFB/wdS0ic7QYtj+i7b4ORRQ3CEQj+E4hp9mzJoLSeBnWqA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 05:29:55.1714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4935d4fe-35ee-4f61-01f2-08dee168f004
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfX4/BsFWTGDPbw
 rAYZ2TLVEz3OMUm0V16ubCxKalsqmdQdtwjCFus8y08cIRFCGkF7aw58/u2gk0xo8tL6eEYO02s
 Kv14FN+0HcUGHHmh665HYzBT62P5iOw=
X-Proofpoint-GUID: GyCxR__SsJ2Ugta_VY6e0t4ktbMHS4cn
X-Proofpoint-ORIG-GUID: GyCxR__SsJ2Ugta_VY6e0t4ktbMHS4cn
X-Authority-Analysis: v=2.4 cv=LvWiDHdc c=1 sm=1 tr=0 ts=6a55c957 cx=c_pps
 a=F7bn8UBrlesmBZzvaxvKyw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=mv2VjrsHlGKUbScakdQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfXyitphBpPl9sq
 1AEtt5V1dSjgwSweRCdbH2+lYQtRo8jvjpH3+VV9Tz6u3J0CKHSp8m/mnk62cDiKh/JEwd51sJl
 B+eijYk8ZrVSuPBobckAPB9F0sdn+fZY273ur6tf1fbKZg1CJN+QgTcGZbsH1gbsy9p2E6kJHhf
 bfRMIG7VFneEv9Q743b+i9ntz/ziaEwxGF+uqkhMEVBzQXVIyFrDSq7xzZpRqbKlZseTJDn37t3
 kDIF7SsDc0U1hWpI6+xbsw2xjUnLTYQlnGxFiwUXGsqo3I1o9UavQwXLsdMQuKPkRZFUnZFg3IY
 kawnlIyy+VyjUxKBifCGalhu0SJ2RF8iG7XX5d6JfwxivaVZYioATMVMCPAtn8m/n92UiH95Yr1
 TDtpfFAbo8GFUqDEy0EPv4Ky84tZTfOwiRFed4ABsCuc3igLsDCelvMkM8XXMwKtwA2vpCqi7uM
 Gj8/tP79Aii7LGlnXUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140055
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

On Fri, 10 Jul 2026 14:36:13 +0200, Rasmus Villemoes <ravi@prevas.dk> wrote:
> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> index b26f087c447..370760ccaa5 100644
> --- a/tools/binman/btool/openssl.py
> +++ b/tools/binman/btool/openssl.py
> @@ -36,6 +36,14 @@ class Bintoolopenssl(bintool.Bintool):
>              name, 'openssl cryptography toolkit',
>              version_regex=r'OpenSSL (.*) \(', version_args='version')
>  
> +    def dict_to_config_section(self, section_name, d):
> +        if not d:
> +            return ''

Either remove this dead code or perhaps return a bare section header instead
of an empty string so that config is at least structurally correct.

-- 
Neha Malcom Francis <n-francis@ti.com>
