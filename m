Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC9CC79FA1
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 05:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F49F8117B;
	Fri, 11 Sep 2026 05:09:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BkxzrtcA_aqX; Fri, 11 Sep 2026 05:09:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 51D4980F6A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789103362;
	b=r/X3JCflSJQgCJpEmgSp4IEVKOuOzIN4Zxs/mt7ivYahRLkDl0ETgvonG/vk7N9k6eKE
	 iw2G2kkmDpRvtSxnRJJZODILqnWKiywzZM34jwEdqehAElBjgvgdKGNOhVyqLPkEA5AoH
	 BOOB0ds03n2gZIlnBtEzT5HsKIwkQMKbxbuLtRDfsEgwfGDKK0jL3PZdwaNuuXxZaydam
	 L0cEXXy5tgjrwcEV8DKqolgkt1srIFV9cTYX5GLVzt+Rn/r+NIRYkQhXSStva9tdzJWLE
	 UWTaj+JD+5msEzPns1qhdGrOMG3TpUzeNi3YUFYkZhcPu49+wM9U9M4Wqriv3dvHvug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789103362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sbZ2yw0R+9fnoqALZmiFEFpcbf1cI14L4Elih9P+QAI=;
	b=CVs+S2UvAQQo7M0oRTCDskDm97AIPDjv4G7R3oh/0/Q2To5QRcf7XKYC13rdgpsZlgpb
	 gnH6qRMAV8X8YgCFZVYNfQ7CNvu0d6RGAUodqqxYO/JdVaU0xEoKQvHLuy2sjTPeDeW5Y
	 CT1wGGPP+uJGuqrMhwYrUEJlBZZLLew1Tl6BzJYNXw+55qEdrsg2vHHqoHSHu5ybn7Pc0
	 2kWj1Eq7BnmCRgRg4OwZvuc+R0j+HqjXd/NkzLyrEY0EuJCDWuhII2EldfnMdSA7CWxQ3
	 B+CaybKq01aZEw32qlBgwyCm/j63GKFlnMWQXKh6K0WKC7qbnJBoj8BHDBiX/EeYmeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789103362;
	bh=sbZ2yw0R+9fnoqALZmiFEFpcbf1cI14L4Elih9P+QAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IOqC5zfDuKosnanYp4C2Cd3866xenOBU0IkW4UXJagHChfhQyfE9CfkSsEZRwKmQI
	 zXo548q5wNGAIoCdDxemEVbdlQayxJuNeoSIgCQ74bGkvQnBwEkwbZglZ3plTKiA2K
	 UATpiCGCa5iqlJh98MvAl6j3zY7ojb2ZYYRzs/RZ/6QxNBJSwa9LoOkpeH01hyF2QK
	 NHYQrQPWsKkvfHiMMv829hL0at6GMr1OKtqBwSBi1sH9pWegyhT724LyIetFngFrgk
	 +6PiOMJGUbGAOupmAEClxXSZSXHQPF8JnqQbBRHko4KdUcl1Lek0nitamsFC1hITjY
	 X5ieppuqIIHEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51D4980F6A;
	Fri, 11 Sep 2026 05:09:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C18149D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31E9D400AD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:09:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCcG6Fn2DRIX for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 05:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4080940073
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=194.104.109.113
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789103360;
 b=sWH7wp1f9Vz3LNykBHMnxhoB3LEcqOqH7sqMIMiC01kgjJMnp8aOL0RWRLIM1EYeVi2W
 XXop9XGGma1GlgUwNXWJPSJFcVWeyKRnYPgHbQedKSpPcCu7E0N7kPOV9PewzsMOEfvVb
 RZiTMDSn2YFBviNlM3wvz2InQAwcdMK0VjRcgySyZRUVp26umJ8cZB89oHHp0xuOrN22+
 2anSZ5p3HWJomdE8+wPCPYTG9aK7s9pMEJwrSkwEsSfXj7wnkLl6e/xG4Vd9S0AfGAr6Y
 QNHcg08blRtY9329LovBENoLnb6dzUnaNlUu+k5N1w1Cx2EIpOaoJmjmI3Y3vKK6xaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789103360;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
 Message-ID:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Type:Content-Disposition:Content-Transfer-Encoding;
 bh=sbZ2yw0R+9fnoqALZmiFEFpcbf1cI14L4Elih9P+QAI=;
 b=fzlGrqZj2toluG+Jejrd+qVcZtOuPKaU0yPrjUuoLeXhnrydLhFjO67M90YixeMDwmlf
 0XyP80qWPccwiYmF0o90119vSdKpBKk7XagWTrFUYyYkijZvEy8CdVSX9BX93u8FxSgrz
 XrzcnoPjoAa+KXQkwZqeOTojX9GdoKiN2ZFGjMwaOeDgHXmrlokljqvcKRjKYLjA7KIh/
 DbmaRVrQvL9F9msIJvDacGEc7MEN7CmTMZmH2LYVU5/bYYErMMA10IUz6iRQqSmn+6uEy
 RBSoY646+z5v6bTvp3ZR4OMTrC7dp1gYAbAcrUesjlStoXbG6NgdogpJgoIF3s0TBUw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=toradex.com; 
 dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=Ukcah+nG; 
 arc=none smtp.remote-ip=194.104.109.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=Ukcah+nG
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4080940073
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1789103357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbZ2yw0R+9fnoqALZmiFEFpcbf1cI14L4Elih9P+QAI=;
 b=Ukcah+nGwxDQLk7dL/dPjtOr9JNcQ8oQ04jbiIDPmNjhFOzIW6EgW/c7yIvhCFNP6ZVHA5
 M+Jv0Y2LoQhVzc/LextmsL2xT4V/LPeSXzpSYiwD4VtBQ1GPqvaqA5kcmh3aRPiS9k1Otf
 yQq2oTe/Lql29hTyWPkv3cNdgPwmYkE=
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11022106.outbound.protection.outlook.com
 [40.107.168.106]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-93-brSBL5v5Pc6oVTQbMaQWGQ-1; Fri, 11 Sep 2026 07:09:15 +0200
X-MC-Unique: brSBL5v5Pc6oVTQbMaQWGQ-1
X-Mimecast-MFC-AGG-ID: brSBL5v5Pc6oVTQbMaQWGQ_1789103355
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB1663.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:64::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 05:09:12 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:09:12 +0000
Date: Fri, 11 Sep 2026 07:09:08 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Rafael Beims <rafael@beims.me>
Cc: Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 u-boot@lists.u-boot-project.org, Rafael Beims <rafael.beims@toradex.com>
Subject: Re: [PATCH] arm: dts: imx95-aquila: migrate to OF_UPSTREAM
Message-ID: <aqOM9KTUEevySPFT@francesco-nb>
References: <20260910192216.518123-1-rafael@beims.me>
In-Reply-To: <20260910192216.518123-1-rafael@beims.me>
X-ClientProxiedBy: ZR2P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::9) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB1663:EE_
X-MS-Office365-Filtering-Correlation-Id: 45839671-b55f-4494-637b-08df0fc2d168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|22082099003|18002099003|56012099006
X-Microsoft-Antispam-Message-Info: 6u06jPGok7clolheSYhhpTrXS9aYyJU7yjDiPNg1eB+mYvDVe1rMWuwPXkJ+Pn6RjL0PvvO56VHstDp8quAdPRqYUzjH1yH+jUIYOoPkwm4QNXP6zVCEKCCE/d3bSBRpcbbaR6aEeVh0kslP2/RcZgTJMiwhpSK1rQQ3EjaZk6YIp+iA+zs3hlZHjsqTFbKz+EVsZ1WO1bT0YhOJXkbA4q6pTmP6apED+8xRCTFgv8gWmBK5pvNWsGm2k7YeaTMh24MhaWyZu+nO9xvqmCo7HeZiSdpdP26/ZoeaDXmRrFpH6cZOVBaAB2Xa+3cwVpc/WVQIxWD+Z8CRZBEfW3Id1bjpde6n9UkjOwt1JVxWsKl7M4fJJCOWvbbgva5Mr+5c3we4hSx+XW88TvNDYwMuKRZXZ/dOwaDdRCHNbt8iCVCd8O7htV12UChUKETgP4lso005fRDhu8vE7vB9DIIS3ea3T2nIuP1IeuOLJCjdBOooTkxoJQYltanEzu1CK5FSAsxj28DGqULoaxHRfb10hxcbmVxzU+RTkv4qbyo6ez5dgjI4FE5xzBjHFNBRZmZtal7xwpc9x0yBW7Li2F4bEl0EwE3dSl6xi/kC5K4GAye1Jihurf0JQPn5He58xH3YFBL+yZMLfIBEvzJoLjAkjXDV+UeUVN1ZBqiBJIh0mck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6cp5bKHD4dZU0VYYNQGGCtyiriO7FZ55UkaI+D6Vkc6SG6OZ33SwDFYW0jB?=
 =?us-ascii?Q?Z0R5KZ781ZZlYwDzN5JMFnLu/esQAIxN04849Mrio+3L8VVdl+aqk1l3K3zW?=
 =?us-ascii?Q?8IsbdtZAq41rlNAsJrMKflwFKtgAumYllMnWPN5cGt4zqDFXl+dGCFX3eIGz?=
 =?us-ascii?Q?i8SkaqI9g6WpVOGKiQWwm4t0sKksxKhSloh/1/w5gJRp8dF1D74mjta7XmTD?=
 =?us-ascii?Q?620UVOd42Cc7NUosKbcXoL3o26JllPSBXatdISgkXzk566nFqyo/+jQZPLND?=
 =?us-ascii?Q?LpsRUixVYFG2tYOavtS6saG+TQJoUv4XoVqcePuGGrvbtXB7fHt/SHwqWA+M?=
 =?us-ascii?Q?tFD+AvJv2x/t/mZ8R5b9MMvJ5HrlgMYArOmm4tjHFCeeY0WanABv2FmWCCpf?=
 =?us-ascii?Q?cWfc0dkNwBWPFESgBl4JNFh/ROyzx/PZtZT5e9kw8tHuylD05b1D7PSNO5Xz?=
 =?us-ascii?Q?g+X+W4+qJAS/l4GKSnKEI969yfZeN6gWFSLG+2HcTChP2dmiroJ+dlevjNxb?=
 =?us-ascii?Q?fO9aWebJY2wN7TIQ+B3yMQK7pE0j01D8qghEbswhFNm8iD+mngdMuKf3O7Cc?=
 =?us-ascii?Q?Rdfx5EyfwxqEHApYTIH5TFh0Kn4CfyILlYfTOdkMwFDHXE92Hi3VWacsF4hj?=
 =?us-ascii?Q?uZ5m/k0EdrPyY4iXohCKIjh90eNUltsOaVe8T625Gdkv0draKVKoLf9VeH6p?=
 =?us-ascii?Q?QFVJOan4H2qF9ALmFJdm0IzdjoBkcelEDipdL7keR2HRgvlQkySp3ZqArgnY?=
 =?us-ascii?Q?pJFx1hOOKy+Jq8jKNocxX6YH1z69BG2n40sVPx9/aZK2LTeZjlKjOCA6oL2Q?=
 =?us-ascii?Q?JEYUh6aTzHRFnWraA8ZiFuBsJRTlkmjttDi/TAHIffnMFbcoKmvwfYxIBILR?=
 =?us-ascii?Q?L1BdIznX9tZE0Q3y88uBqReIBXjW7/AM5xHg9VPddWlYMQgaH1xcT/kf0YZ+?=
 =?us-ascii?Q?lOxVGFkpiIPqQ3Hr0ZyGd9ae84W+pozbB0unADrQHYfUquMlwhV80ROX/Kii?=
 =?us-ascii?Q?agp2gTljyDdPZaTn2MqRulrhV1WVz/dQg25FsXAODAtn3yzb/cJ7KI6WKI5s?=
 =?us-ascii?Q?M7LknqqzeHdzuWmnmwLTfacxXv3vJTZgI3MSkBFJrtmx/NfZsJOzZC4RJboQ?=
 =?us-ascii?Q?4Hzv/k5il617raC/F0pIfyODRhf6ZTwNgDrRDC4xvxUgHhnEii4VBzSLP2tE?=
 =?us-ascii?Q?MC89KyZoSI1pxxP9+ifYhIeDKlogzjrpCMdtlWnP9HHuFRmO6NPOUEAFpptm?=
 =?us-ascii?Q?zrLreEAfrewH4yH0skgeccb6VORuhLImhw7S485K4ws35I6jK4RT8vpWu0TM?=
 =?us-ascii?Q?kIlO1wdoLfqO7c1n7aZhFDwA+QgD5XTvOkHLuX9+TxJ0tkxr9tyd4PR7dFK7?=
 =?us-ascii?Q?Yng42V4cFEedS0qkoPIA33Km+4rsiTPWJfo+vKX3je8WPIAi5Fk5ZF4K0I5A?=
 =?us-ascii?Q?eXH1OL+TpgS4Ls8zHsw60N+CBcet4KHBXLKKbZCqoOVnXSKn3HJu6YHZInM1?=
 =?us-ascii?Q?zGXVG4C6Tpng/eUiGfIr/AlR0o1WUmIbp+B4FOqBkiC2NG6CEUsSzD1H/JuK?=
 =?us-ascii?Q?vM4SJau8jGqDaJMt0ZKMN2J9/QvW4GMsPlJ7/MpE1ConXDzo6fWBflyYwxSs?=
 =?us-ascii?Q?LHMfhYO9iTRHZmfrRWWc/uAY0QTwTweqdm6RM99EJ6e6pmP64fxjQJPTDvFH?=
 =?us-ascii?Q?tSAjgd+GqtVKB+g5RsPe3vvJ8vdhHPJpWZ1XvJgeJi6pA0GI14PKvV7/BdqQ?=
 =?us-ascii?Q?iYxpz2b/nKpKeerhvCdiNEiXiTI2xWs=3D?=
X-Exchange-RoutingPolicyChecked: W371XclC7hQBkCU4OR7h5uSs5BcWrEKysjcOGBs/SAvxo57HKFW1jXmpcww4eqKegj3XrifiXV8rdrj8ywexgah74F/xj+JGiNKf20PFEuaAd1XGdwRslC8q44uGWAmzPGHjRGe+ymge+lWazqd9LR04zdqJtbpQcO2FnPK05CKHGGrDLg8f16V47rgP6yJ4/TTuXON0gRqyy3i/wLjKa5owwG5EsDlzdeun/QhqZILItZT38ToTVeOK2YOnlcn/4AqFpmY0emOou2Usly+SHvonBi20qRZ+Rvd61ljNqMe05jTaXHp51MUsZrB3AZiQlIu57v3DU/ujh4jwFBRxKA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45839671-b55f-4494-637b-08df0fc2d168
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:09:12.3774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EBLPHVxPwABpdXjTKbTusub7DYICLs+Bgm/GBl6g2jigG0zEfMCJTSPoG/tT/ST+1cPM6DxYwUQESz9eIWxHHMg8bN7jAa7ptGTeMzHm3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1663
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7KdzMgllWs4V7prExSAx-ap1nI7-MOKCkDDEncucdeE_1789103355
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Sep 10, 2026 at 04:22:16PM -0300, Rafael Beims wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
>=20
> Allow CONFIG_OF_UPSTREAM to receive automatic device tree updates for
> the Toradex Aquila iMX95.
>=20
> Remove the now obsolete device tree files:
> - imx95-aquila.dtsi
> - imx95-aquila-dev.dts
>=20
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

