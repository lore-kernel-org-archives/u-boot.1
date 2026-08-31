Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A777C624A5
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0576760612;
	Mon, 31 Aug 2026 07:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XojCpBluzx49; Mon, 31 Aug 2026 07:38:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788161906;
	bh=DWDKV6zYNNCSOZ0GW9DNZ3y9rj8PpCSg+cEoba6KdY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S5b0XWYubJ+p+724Y6TmE5COid1e0PuvgSHkM1N6mPT5aKW15+yGjXEaa1UjTPGRh
	 9w5dRkYnec0cF/V5SQPByFv8rR5bROVoB1Z7S71mDCfQDWBriUMB1w+GUI4/6ROv2l
	 kLCPOkJ/YjjgenOpQlxnbthxtb0OQEujNlmyWlRlV3YHNn+ZvTL6NdICHNPFPvdH0K
	 gg9JTJ3JHOLY8kyjjoxc6rpu2dOAbZSYxQO8O5tl4i+c1j/ggpZEuE/1jRCVwcGAmU
	 OqPWxwgiOZlDeCElS9yGRQbx1xyGbOOkDHXm7wnUG+GutDYRoci4vmLrtReMH1GYsd
	 kHjjwKWLahbEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A35F605EF;
	Mon, 31 Aug 2026 07:38:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F245B355
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE31840471
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:38:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2a-5ct2wOYYT for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:38:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.109.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=jDdQmzPg
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 by smtp4.osuosl.org (Postfix) with ESMTP id 015BE4047C
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1788161901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWDKV6zYNNCSOZ0GW9DNZ3y9rj8PpCSg+cEoba6KdY8=;
 b=jDdQmzPgvcTENGghmgxzqVc+6U/3+CVtg3YMQ/o1GMB9FUYbtAYVXgCp37uu+HWZzZ98s0
 JaX7V89Ua+YmsYUxsXRQal6VrtrOLsC+wOi+AIxh9ijQp0UzhDiu9Dh21ntZqgXZQDwT0a
 JqU2bcKI/iBZFH/4mRVFNmOqVADZlSQ=
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11022118.outbound.protection.outlook.com
 [40.107.168.118]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-69-MwpOu2uWMMCXp6-Ku2M_bw-2; Mon, 31 Aug 2026 09:38:18 +0200
X-MC-Unique: MwpOu2uWMMCXp6-Ku2M_bw-2
X-Mimecast-MFC-AGG-ID: MwpOu2uWMMCXp6-Ku2M_bw_1788161897
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0834.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:55::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 07:38:15 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:38:15 +0000
Date: Mon, 31 Aug 2026 09:38:11 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH] doc: board: toradex: colibri_vf: flash u-boot-nand.imx,
 not the plain image
Message-ID: <apUvY1wvxcGf2OnY@francesco-nb>
References: <20260828112335.40695-1-mehmet.fide@gmail.com>
In-Reply-To: <20260828112335.40695-1-mehmet.fide@gmail.com>
X-ClientProxiedBy: ZR1PEPF000077E9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::45a) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GVAP278MB0834:EE_
X-MS-Office365-Filtering-Correlation-Id: 84248059-b257-4a91-056e-08df0732d081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|22082099003|18002099003
X-Microsoft-Antispam-Message-Info: IHpz7MJ0vNzHvfEZ1mVm9jWauXk/hAjoPgtY17HxgzBhbMLNkL6gUdgbjupqiJj078bBvGpZ+hLuXMqyah8WLy7pMPEgf6JJSuK5e0S+vtRzyBbUiHTkUGMv+GlnjXMi9+h7ScU9Uhm4TQTyQOfWBia+nopzRlG8YTKwpmsQfylMqS1FTUTdfCwAmQZ2PA9GLVFthWaYdXn4N0fRDY6gKbUu1CleeXH0pbB0vlO5zKrp4eTYXcsvT6ieftcrHw4Djvtdr/omDwzkn8b9CNXHhv4DmSMwoKGWLCFjqXEs1ABf2B4boobgqhL4D9pr7GH9zmXum5SS1tID+mXc5jsKPaxGa3xGeF/Zd7aCwOTZotNIilqPhmAcVnCxG3UwUfkzyaMOcX5SYbFDAGgBsVciuzfEfrMtdSjfWG0K3jd4+Y4Vtyk7dY1wWwreeJ/Ik3Lor8kZmGRh+NUVDvQqO4ZhBTb3ZtQWP2FBs0PRJhe4K/Bvxvjrw1Q2uOTjHVSfGgiquZgYfJqWf7oQHV8SBlB0vf5R+DtcmvjDXCld91Kc1HNqKK5/43rBV9RfwtgGJI6ynO2emaudoqQcBfidppqWLbSGuA+DyHuAwE2Eg8vD+y43JigAzz2hH89BcTLIae+ckIeLyLLNULlyWO0lcgauT5hZs/wPA/c1+96ofD4wvXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PWT98ewRvlryNZ+lVKxIGtGBkTz+nHR1UahgrGG9QeEjfbbywbZUUiVbpIPm?=
 =?us-ascii?Q?w4eezLUjWGO3Py2YTyJAKqGVNeTvc89pnFmNU2wm4WI93xuaBiHASaCxbCG/?=
 =?us-ascii?Q?3P99DwwB76qrJILh7xkJ4dAzL5wFAsqGMPvGh5qYx07WCqHGhwuYvw254qhK?=
 =?us-ascii?Q?bvLi849ryQl83QYmaAngpySBfCNDZwUt5PVdMdkcC1QJsDGnEAgqdfx8n/l8?=
 =?us-ascii?Q?pX1myykS32C3W6IS0QJYhIkR/uJNNG5TzSpsagYaOottWKrgY1eEI9TfPYS1?=
 =?us-ascii?Q?nYg50Cw6dazd81P1jMDSkmVI4/sd1toUL+1/rleXc83VZDHF1eNBY25NMJOE?=
 =?us-ascii?Q?h4vfHhdJzwQ6J7aUXtUnOhITaeKIr56zGQx/TdWihlWC5rJr3IvSjTO0x/sX?=
 =?us-ascii?Q?ln9rt7EFk3hWtY6bcayzwbYqepE9vS72sVA0sHnNPyvdVRyhsRcoUbwVS/9j?=
 =?us-ascii?Q?zooU2f65VC9/b790wmJdjryT0mjZVxFPZDCGolfi5NxqMsJia64nLmhvoeGt?=
 =?us-ascii?Q?JZRQeeDKWaDYhKDE1tNccasYEOk+/0HZLC9rGB85WffDz5OCiXNhBW3wGlgd?=
 =?us-ascii?Q?oCeiDASjSuE1CJRFbMEBYc2AGozVNzqxzFyRRsY/erWSCvb0uEXeQx60XCgV?=
 =?us-ascii?Q?Zf9b8FLPhJYuLNx5u+Ebdofh9vjT9R1sLGokcbPvO7E2tnZ+UmJ2BkSbnNf7?=
 =?us-ascii?Q?pIZtpIwNuGVlY9O/MW/6j638vvLiLaGY5GARt5bg1cBC7qWqJl0qW2MaH5Ak?=
 =?us-ascii?Q?zXfAI688Mrt2XnJYRF/uSoeiPrNsWwf72GSFZgb6ghHHklKdFgoZjlolnKAR?=
 =?us-ascii?Q?7OgtT6EbincB5xM7HuLjc4Va+5IvDP/evoxihQ2ldy9ernIYFeQR9XL+T/xR?=
 =?us-ascii?Q?yK7AgNZoAmCUtpfJMJdm1zwyrgos2l8Ma+B82GARe7n8YciSZoSYISi9cEfp?=
 =?us-ascii?Q?+wIauQzqi2G6SXDBJ0B6wFs+Ykr54ZMTG/NmApkYxFshIY/suPUOeoCh64Yq?=
 =?us-ascii?Q?p1ZnSCjmEWVpxU+SiN3k8c0xVpIKW8WJWugJrkb3vJR2p/TE7/+gnM7vXWrn?=
 =?us-ascii?Q?vfRi9r8BhSMW046JyacIafoajf8/xuYD67L8V2827r97Pvxk58cJ7KZEUJrD?=
 =?us-ascii?Q?roQejHiqePFx+XN8IHlMOdBM6cBSNXTPyjYNjKsS+kA2XwSbnbHlfT7Cf2ie?=
 =?us-ascii?Q?x4sOYfCTbDLxdPyIa0GEKEP7oVkWQt30IPrvWJ/+ZCdzKjggJidRwwToLVk3?=
 =?us-ascii?Q?NA/CGkUkzCxmE3CyFPvF/w8LcTjZ9R4kv0kYMm8eKAvOeDq8v1Qb5hY23Mcs?=
 =?us-ascii?Q?cYx3IYxQYUGIRCz1LWlFG1AbICUzfxoY9O36AlpZ9YU05TZnfID/QDDMSMMc?=
 =?us-ascii?Q?kWUPR8xC9h5xuskdT4rnxY2xcb4YKcvhlHoBrTz7q/waYTyX/Ythb5ouFPRj?=
 =?us-ascii?Q?XGO7JkVwU6qzluBrI5GLQhI/SClVxMQ95B8pMER2janIOw5m4YtlKhydSLzm?=
 =?us-ascii?Q?DdnDk/mDZmT70V/F0gsFjFlO6twv0uLL8A3SrxeaqfRxFwA2Xr1yVEvLHhSW?=
 =?us-ascii?Q?gBxv2t0YRkd4m15XNzdKgiKeRaxU218agJi701IRGbdb4K6M2EvXygZEh1zk?=
 =?us-ascii?Q?uj5e7g6hqwfIndA+IAJ5FxPF+7L8KR6Og6m5GPqyz30KaIi6ARgc2MHwuLAo?=
 =?us-ascii?Q?7I8r+pwaN7pyRQ1DfYaLIDwJtffg3oV+BuRJulOXfUrYvhgVyiYf6TSc1kBt?=
 =?us-ascii?Q?dMZLmhvaKbWJXftGxm8y0f7TvF/ezig=3D?=
X-Exchange-RoutingPolicyChecked: MjAfPv8H+V6GrYhK9vrBFYztlX4t832jy3f2Sh1ObORjOFi2PUxzjYag3li0XN9kR6uD8x4TPWZhU7K0exNNeH7p/FuuZa+Jja0nZ6aKgSJLCLlIlFgerwCDTAV85XSL7Ww2n0fztF+sLytHrIGvVfsoAaJPiKnTXhrGelIxjxvVxjLoX3yfVLRn8XiBZ3KUhLpb11v0lxb7UzPlfds+Xz8VywsQmU5jY/Wrb2lLUUc9B28tOedeY6cocmBjccOXUfUW34hvX+6t7ZbuBsy1CMdJAPFPeGM+sV4T0JOWvrYen3LToW5m9ebyyphajpuDS6U71bDHhqajIAgnEbXCfw==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84248059-b257-4a91-056e-08df0732d081
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:38:15.3773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfMou1vGy7M4dZUSvR+eMoCRdvRSp/3oe3H7+k1nFH18oUpdr4ahmGfYgUjv6F2KwKMsLKqmCMGWGz4Qi/Ym0+cxQPMn3p8or18KItRRWII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0834
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d1aTd8_NMkW8Xt4ukej8G-s-53Qf9pOTL6cQCqaxRzs_1788161897
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

On Fri, Aug 28, 2026 at 01:23:35PM +0200, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>=20
> The BootROM reads the IVT at offset 0x400 of the NAND boot device
> (VFxxx Reference Manual rev. 8, table 7-51), but the page tells the
> reader to write the plain u-boot.imx, which carries the IVT at offset
> 0. The BootROM refuses such an image and silently falls back to the
> serial downloader, verified on a Colibri VF50 V1.2A. Point the NAND
> flashing section and the eBoot flashloader section at the
> u-boot-nand.imx make target, which prefixes the image with the 1 KiB
> of padding the BootROM expects; that is the file the eBoot flow was
> verified with on a Colibri VF61 V1.2B.
>=20
> Fixes: 26e89c626827 ("doc: board: toradex: add the Colibri VF50/VF61 page=
")
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

