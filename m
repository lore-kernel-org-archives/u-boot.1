Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E2606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FrlaIjy0;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=V6lyZZZz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1AE460A74;
	Thu, 26 Nov 2026 13:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCQDCl2KA62A; Thu, 26 Nov 2026 13:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BEAA60A6D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698601;
	b=PNDWUxK3F9aeYLvvtqa/B9eXYnSmIaSaznyhGEeecDms0S7Gn3SkdCdBbR3blo+biUZL
	 3dFLfQXin1zt4s58Mq/AdETuyOrXbO9o2LKG3X0WcLY1KQPaJn+Q1uOYdrjPgZWMltNKW
	 WIAwvOZxrEqo2H1w9tMuw/0/eba496xyeOgRz8Szavrk0AZY2u6gtEgH9Z47fsh3ozm2L
	 VL54uF4XQeL2JPHgA5iPkZMGCZj9Mj16CU4WNVerTVVFY4N/IRHjE9YzOM4e66mpaBwaQ
	 jd3LXkr37FQo4T90gcgflICCSGRMEmmwdvt4g2kZrqLFjy9k0/9wJi58YIgTfHXcjKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TS+cHP9d6hcJwEy+Hgw6qOOL/X5Nbd9F9H4Dxc/rdpo=;
	b=G+5lhGmgTpkxxQ7UiV0n9pAlcdPW6rP1qo5vFBmGriQB5EWAvuwf0JfqPlP1UnC7mawe
	 Dok3qzEZkfAFI4kXgAtKg4c156l1fi0g4qt6T2FETzd5qTmsRbZZNiJ02zdw0jt3wSzzF
	 0nB7QOvs3RlOlPTcQBvWqQwXDAnWJ8E1qKq2Z5/7L7lHePM2+h1jmEtH5mCBtJwzjNt3m
	 TRj6kNqXB8PIHYPLh32EJihHaHnDLfq0RtyNL1nXqEXzby0x0DcPXhnN3JA0sC0bL/THO
	 fsRX4o2azF69MOemNcG7VnHbYOzWeIXNt/lMBN9LGMpcxO1shyK0oCGyeXTn+jR8B6Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698601;
	bh=TS+cHP9d6hcJwEy+Hgw6qOOL/X5Nbd9F9H4Dxc/rdpo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FrlaIjy0v2EC+m4rXpc8TEciFZ0VOuRyGgh/ze+Pa+JGqpxbJf3lmVbJE9oRU5Zy1
	 AneQRdTP8XldSula5wDM1d2KS6SCWaNdUqk2sInMv+zewKYF5PHGm2nUim9HsbKoav
	 NKgFfmv6kqRtc2HixbZXwsHMLMp+xjpizNUDTSIlLoLFGuCcRxK35mx/5dLBkV/c2q
	 fDkuuwHAFmwqiu6gPu630Rl8Gi+euU6P1eOc0MyGBuMk99CyjwQFJ+QTMXk0M/k4Cy
	 eLGDSXyxRHMdEPf7mW9B1fWOFz5Hy7O1dqnFx+REo+39TylgyganDVaZKSIddPbNwv
	 SUpWaKrCOng4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BEAA60A6D;
	Thu, 26 Nov 2026 13:10:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E9952DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04493404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6TXYBA7gsRe for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:09:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CFF5B404DC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=V6lyZZZz
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFF5B404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS+cHP9d6hcJwEy+Hgw6qOOL/X5Nbd9F9H4Dxc/rdpo=;
 b=V6lyZZZzJK/aYEhrlN99mBirKfbr95kcrcDV+fYroyK6mRcToof6Mu3hKA3pwxy63bHu+F/5OBcDe9Z2+R9Lx0/sPZkP32CMRfVJagF6D7yyb9GnXPf/6PfHWeIEWhjCVdlGrwK6ZOG4IsZC4bHCxqok6SjWRGFuT68mdrj1QtH2jUtkGB0tQ5FS724VKl06T94R1xEcclZsSIA0JMoiMbjic7ijPrud/RGQwa/YzkIblKvXzkCh6AxapzujS4uAWpS+mYfEjAXgvkFJLGK7GXOaIv9EbeV3Jq2gw8Z5qFEfWyUAW73v4L16dDCQ+B3/tPia6FtzlH/f/W4ZBKl7rg==
Received: from PAZP264CA0066.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::23)
 by GV1PR10MB9057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Thu, 26 Nov
 2026 13:09:47 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:1fd:cafe::52) by PAZP264CA0066.outlook.office365.com
 (2603:10a6:102:1fd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 13:09:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 13:09:46 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 14:10:43 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 26 Nov
 2026 14:09:36 +0100
Message-ID: <29750bb3-18a8-45bb-958b-ecd6873b2977@foss.st.com>
Date: Thu, 26 Nov 2026 14:09:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32mp: Fix qspi nodes for
 stm32mp157c-ev1-scmi-u-boot
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, Marek Vasut
 <marex@nabladev.com>
References: <20261113-ostub-1905-v1-1-7a8b799e260f@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261113-ostub-1905-v1-1-7a8b799e260f@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000849B:EE_|GV1PR10MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fee9a8e-b544-4597-b950-08df4bbe8bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|261022075727099003|261021121427099003|261026140227099003|261021123027099003|261028144727099003|261102123227099003|261022115727099003|261022105027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XJ1N0FtJ7htOftUyLEGSvfntDaOI6T+AtSHUve59RFOURUQ/nXOZh+j+RMWygWi90AebHyou4oEZmAZui7EmkH70QMZjmmN9MZ4Nb/t4ee1sF93nqMFH6CliF5OtoTJ0MfPFLmzTWWjNui6MUI70oN7B2Z0fVpL12Ra2kjQGaaYqtp8L8MK8i6Oy6CWcSR+xEjI7EHw5U8m8Yyzmz5N5c/yqnN7cLq7de+CqRhFPRjCcYF6zWqeCJj+uPLuAgxQZ7/TYIMOsbYqbnHTONyaBvUICeSUfuZS1GvNSZmD1lOKZYzOo/TWrdEvw4vkB9VGjn34vRrX+pBIu9MclALiN9qWWUrWw9Tl+BxKt/NCAk3tSJdRwcWpd1r5EI7STgObV8c+NPL/pfqOg7Lrg/zqsyJi0m1eWtBy2HZl2rN/xwfxVrou2r2uoZHFUzaTvtP+ZR6Fb5e93cj3p65QEVwtygzR0Wx0a85AAMHhklKR6rIvX4IxUuzxVesxp/OzSFRSHx4dLdfoEhEQstIXMeucY5F65USg/0Jb/DeU0nqSQKZMTxDrOBUPIKFJn03ki52oHOyk/q0KMq+AG145BhzlpaU7OM42FjlBMBZfega7R8Fbr8YKyiObJbjpBgQaOiUOdUlulcVeoEOwNwzhWtEkNUlS5fTeTZ9x368Ko04O1eWzxxjcx6iDM8ATGAB5odmV/S7HTePm3YZDgfFRRYS0S6A==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(261022075727099003)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003)(261102123227099003)(261022115727099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qNHKhQU2uAZRmj/r1TDpH5CHU2uo00K4H/Vq6FmWZ6l80SNeIP3A149FmteEKV9LT1ORBKVJaVrnhzeuiBBn+Da0P1fiwyOr48TbS1RvJk0tnUaviYWivdsw8ftnXEOIoo4hReAn182zNkCocd3ZwCKhPXkLj3kIVHRFDxeZAr44qXLX3QVNXLkhTm7Kt9sUoAklstZzD9DF6DVVRa530Ezjc0Okd413K+g0nLjFXpEbk/ry+Bgi6vXf4ovgd43swuoHYV6VBrIulKLiSwz4TmH9n3Otamz2UtLRPsC3fePS6sbzvh8ZZUf91De3HKSWMEt+3tdS6p9bOXP1LafAO/JLAwJ84FL1ozJeLqiKmEYkJfRbd7O9s1Ai0pFvUW4KUHR4oDceXJeV8sVEPZ+OsSoeXyL2c0rqcJIpKFhmMfOuOn1fCsVcQtcHg9iwqMfa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:09:46.8964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fee9a8e-b544-4597-b950-08df4bbe8bb3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9057
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/13/26 14:54, Patrice Chotard wrote:
> Fix NOR boot for stm32mp157c-ev1-scmi board due to qspi pinctrl
> mismatch after kernel v6.3 device tree alignment.
> Patch similar to commit 5846ef86f89b ("ARM: dts: stm32mp: Repair
> damage from alignment with v6.3").
>
> Fixes: 08002ffd083d ("ARM: dts: stm32mp: alignment with v6.3")
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
[...]

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com> Thanks Patrick

