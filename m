Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5532DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2F084AE2;
	Mon, 13 Jul 2026 14:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p7qWde41";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p9vN5B9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 666DC84AE2; Mon, 13 Jul 2026 14:20:01 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60AF58467B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DCDZaI3500509; Mon, 13 Jul 2026 07:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=uZnHoz7yAw/MWbr9TdZdr7FeaXar5BwxgBvOA8Omr
 P8=; b=p7qWde41OJvHlRcWfHdilzM5wHfZ6rgvx+bGRwjwL8YVjzjDOxXz3YeZj
 wWqshJZUtozaFbR2GszyFJ7qyx7zh6YSuijtSmoSz1l/wtrpja7w9r8BlZVvZscF
 Li8R1GzKB3pgT0hnCxvgw8osqYNAHT8RvPwN5ZTDAW76wj4SWs+sw9qYFJQTdjnj
 MdJJ4FSAOwKMqAMrAjKW8ndnseB5rOULptBDUOuLFQ9nh+PRUNpdo8B3vcTwwzbS
 IydXr5+J4abJPS76KI2j/8ts5gRdnOUpueP0R1SrrBeT+kiFrHbON+xN/9ZKW5Xq
 BkioPImfTq6gvjQYkt2Nn5DP7yPmg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fcwb60r8q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 07:19:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwLkkabeXMcF0HCnU0o6LXXRmz/p6axhUnvhdk65u34oFJs1ANW3Xt9hE41Dy5lfagoM/PAAVk2daMrQoBzD3W5GEnj0AQwMEGL9CQ8WVOw4eAWBpfkhQp5Oufkk6Gvf6kIYQ4XgDcDAoSOj5/7PIABgjGOUoByPU3qW7hX67iOjGZrPKNfsBz/lxlaKl46GkUy/kvjtxUtj90D9CzMo2FB0873+uPWhBWH12/ZVSbyxk8vVSKxaSFC6x5coDFLqE/fxOFqEdgiUFzNyO9x2ov+6/EbSK/JBsY8EN3a5zNLqZWKTwLNSaWR+DG2zI7S7RRy6hIB7iWEo9uabj/tkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZnHoz7yAw/MWbr9TdZdr7FeaXar5BwxgBvOA8OmrP8=;
 b=nuOiRxPxvQM2Wh/p6Mx1AoxutNvmjHQOYgk6FQXxFbQ6y0/EOG/LpeM7YKK464e7fjn1Dyy8ABpeT2UZPamGEFoV7pGDNx+mBb9RhmSswkGZbI4ppIARoSa9a1iXfJZh3MPpHR+oPmCXbRwmhNyiMvzu/MtmFzIqIwFuTPgPkRnCe8DJTFHpvMPHWWzS1ZcVYyDYBQ11iMEZojk/cWkYUbNvg7yZ2TnPBjVe6iGSSQuAZS7YmLyNsCuYx1Sa9f9JvygdlN05S9bwxlsy4PuWU+RFFcmZ9UbPa/oz0A6fbOOastMV0wbJxDDzqcP5mmSQGNrdwdnwMQCZJ6YG4WqD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZnHoz7yAw/MWbr9TdZdr7FeaXar5BwxgBvOA8OmrP8=;
 b=p9vN5B9NGL25BDD79dIbDaoNpBiJ1P8Qe1YhF1v9lA5crAnmIXLxuDiXRr/4hfo2XkMxBZC4LIx6Y52Jjdot5J3gcQaq1siL/kjZj/ItPhCOMySjyjd/eEjH/fNB55qNNXRuNlpUl6GQGQAtVyTIvz+/DJcrUVZvxD+xAYrFnR0=
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by PH7PR10MB6968.namprd10.prod.outlook.com (2603:10b6:510:279::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 12:19:51 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:a03:33f:cafe::9a) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 13
 Jul 2026 12:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Mon, 13 Jul 2026 12:19:50 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 07:19:50 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 07:19:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 07:19:50 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66DCJmld2140094;
 Mon, 13 Jul 2026 07:19:49 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Jul 2026 17:49:48 +0530
Message-ID: <DJXFSHTRFW0L.O5673KW71NI8@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 "Tom Rini" <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 <francesco.dolcini@toradex.com>, <w.egorov@phytec.de>
Subject: Re: [PATCH 0/6] k3-binman ergonomics
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260710123618.2036728-1-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|PH7PR10MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: d95d0ca9-7796-4351-0cdf-08dee0d909c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: VlBfJjoPiTMK6oo6aYz5+goS0k6/hgBS1orx7aW3B+nmRAU9of+9S8YAJWjmpYP8IEyspzhn0tnOMSTLDpdM8rNGBwFYvF18PP73C73oJ8ZijF46jGj/CheY47C8nhR1e8rl7vLxC3zTncZqHaVTFuMPfy7v5cvJ37Cu6wqNvbQw5d0uUsU6qa92BokknPPg/cfObMvQkiHGZ2wmeGQ0IXlN9NStxe482Kzy2tthbHwbZHWVCGMit9+LA3Lt/ri8cLgfRPWpzfdB6NwqPtmbBWpLZPEuX27wXgADDNnW99G0u2n+XLrms7SUZuuoKmqFtQE0KddPiJziG0nO5mdyNpzXMvdWk2B40DlmJI4nXnu1jZ0KIiUwSCnWvh0U5BaTwuPxhJVpDZHuFk3WtyFv3M8VPty5aDkiJV4E/u2F1OW9Yp3u5qkOtFmiMJ6B5VsgN5Q4/QybcBGpolRYYz4iXVJmUxYtTv60kL3pFXpvSGcPCYMR7txDvLssQTRP2jxF4//mRvjadw611h4QXVibcQuvkAq+rqHBSZ9JjwAFiRdiC7bozh6zaF0XUiduO3cL5A7PKIoNqk3A85cx6ziMuqquXHrUt6Q2JmO92V2YUvTnmp3e/ve4+2YrVsyXRWlRwQuOKHcfoveD7Plut0z6nItssWCEyT/w9L2MuubJ0CrO9k9UKq9wYtd2voC57Li8Mkgfhsfw5AQhLPk+de42Bg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EPIGHdWVyEZwAMQqTkbv5a3rAcJkn86d+1+atibAT4Et0KwuD4mwHqSPTouXJq+O+kEWRenRnFQ65XvtD0FXZIhBYlgsWfAosufTE7KgqwHuO8A0+3kRHy5N0zI1vOA63l4G4qmatghvFqbKHf49KlUvoITl6ISYJ503p4/gTn0OusblliuPHjnprWPq2zYYbwNYFPbtujMGOeAxEE3FFM7m9eP47kmlxItlqFuP0WL2xC9u9SBIRoKXeKfridhir1fUlRnjSGWLYeODmuYn9b1KGYUb8oNgMC9qwqhbugPr96e+zq9ZADCM2uaiYNJDnyMThQZqFOt18USu0yZUXKG8fS5aSrq8fHyLBNQ8U/s3dCt/GSpkxz+pPpr4lnZdlkf5Lu/TLvMN+70ZxCDebKn0c7MKxkQYtpEToMmGhTIucNSkZ5M7gffviRqWNoff
X-Exchange-RoutingPolicyChecked: f6Ij4hi74Fhl/c5SRirn5JQG30Yllc9zTeUoN6suqWSuDYPmja7Fyy8KeXDmLKY4OtN9gY6xeRdr9wSo/w/ehTmnLvJezGkYyK70HrGkfPtX0QerTJU/0d8OJUTZps4D4Af25dmLWpmKIx2UCVs4RJas17niCmV6WYdDZsIpIuNGmp8QdbKR6Fl4X7uvYDVW3xmaA34s1MwZgAp4wLOuDiy1XomazQvxFszAsumiIH2BvK2SAXFC9+F/59rbxDUqPaRmHpXVpvNXDmVx7OOfS+qhr58JRpnfvqQaiD7za1BEPKeKSFb+lY35G/NO1CWHm1QIQSeDlzpoqxo1MEiVBQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:19:50.8124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95d0ca9-7796-4351-0cdf-08dee0d909c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6968
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX2/QC2Mho4ON4
 15jTaPVFbiMPdvJISqZwACOOTqbmz013OYKS/Hx8tPk/j2d9nbQBxmQ2FNbaPBNoO4jgkND71lm
 1dT3Z175TJVKgmcUxgrr0YA2fUjiaI4=
X-Authority-Analysis: v=2.4 cv=HObz0Itv c=1 sm=1 tr=0 ts=6a54d7eb cx=c_pps
 a=3Rvb9JmgCdrss5EpqVD9LA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=apCtcj2qairtmBj-m_UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YsbjdsSQCviIhTkp8M3BkA9J7HOIkGUl
X-Proofpoint-GUID: YsbjdsSQCviIhTkp8M3BkA9J7HOIkGUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX2T2excPLrY0U
 Y1vK+xeL+f9ynP9hKK40OLjp4TYcYKQUp46xODAUTJjYer6qiGayWXeHv08BhDdAXNwUDcqPPlh
 TK11GT+5/WJixQCmMLHMleskB3CDGaCG6DnWV8fjw4JltlSbDBvZmPI+vgxLOOXIW0ekl+iMQfH
 nZ8lGxQ7vXVBECd5FTGVAmhcBG97fbGaOtycEDe5r2eqX8ufyl+a6a/XoO1darmEOksU6i8zsBY
 dATN2Q88BT3BR87RXwwzQ1kHsnT34ncOa6hwaUr4ficWmWTErHfQ2sifvPabm9RC4vYc6/ZBI2H
 2bXc8ibIlHwZv311qsgx64hCePY7ceq5RTkcLSAKXWSWpugQNyckpWD7Oq7JNH4e7o3AbJ8llGI
 6BB1MkBD2uYDXCXWlJOiGrkN+3f2zKqmcm/XfBtDV43KVCoWLiPrXYPowugqEw95tWQ5c65A/hV
 f6YnUdnwMcGUTQotZzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130127
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

On Fri Jul 10, 2026 at 6:06 PM IST, Rasmus Villemoes wrote:
> When trying to hook up use of a customer's own signing infrastructure
> for some am62x devices, I found it was more difficult than it should
> be to point at the right key(s). One has to patch in the keyfile=3D
> property in way too many places, and if you miss just one, the build
> succeeds using the generic custMpk.pem for the one you missed, but of
> course the resulting artifacts are unbootable.
>

The default value for keyfile i.e custMpk.pem is generated via binman
from the custMpk node in binman (defined in k3-binman.dtsi), modifying
the filepath to your custom key should work as a single line change as
is.

Perhaps this could be made more clear by the use of a macro instead of
hardcoding the string "custMpk.pem" in all the places to make it more
obvious.

Other than that, the addition of configurable distinguished-name could
be valuable addition, do you have any specific use case asides from
downstream boards? I wonder if it could be valuable for existing
upstream platforms from Toradex/Phytec.

CC+: Francesco, Wadim

> Use the template mechanism that binman already has to allow one to
> only set the keyfile=3D in a single place. I cannot really imagine any
> case where one would not want to use the same key for signing all
> artifacts across the r5/a53 cores, but that is of course still
> possible, just as any downstreams that have explicit
>
> &{/binman/tiboot3-am62x-hs-evm.bin/ti-secure-rom} {
>     keyfile =3D "foobar.pem";
> };
>
> &{/binman/tiboot3-am62x-hs-fs-evm.bin/ti-secure-rom} {
>     keyfile =3D "foobar.pem";
> };
>
> will continue to work.
>
> Rasmus Villemoes (6):
>   binman: openssl: refactor creation of Distinguished Name section from
>     dict
>   binman: x509_cert: allow and parse distinguished-name subnode
>   binman: x509: fix CN emitted for basic x509 certificates
>   k3-binman.dtsi: add keyfile_template node
>   k3-binman.dtsi: add empty distinguished_name_template
>   k3-binman.dtsi: insert keyfile and distinguished name templates in all
>     ti-secure(-rom) nodes
>
>  arch/arm/dts/k3-binman.dtsi              | 34 +++++++++++-----
>  tools/binman/btool/openssl.py            | 51 ++++++++----------------
>  tools/binman/etype/ti_secure.py          |  3 +-
>  tools/binman/etype/ti_secure_rom.py      |  3 +-
>  tools/binman/etype/x509_cert.py          |  8 +++-
>  tools/binman/test/security/x509_cert.dts |  5 ++-
>  6 files changed, 55 insertions(+), 49 deletions(-)

