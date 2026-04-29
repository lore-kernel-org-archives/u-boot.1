Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8870FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D17848A5;
	Wed, 29 Apr 2026 14:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Unw9b0yG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF141847C4; Wed, 29 Apr 2026 13:22:09 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F67184715
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 13:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeYGa9+NWCDZxdTxzHf2pXAkX8mcUhImJx+yfmm1a0+RVpVNRGyJSzhx6zDs2OV85lcvrOsc/eFG4Xmu1+9nsCsh0ONc7GS7MWoa4344uTL5H5KCuutIa0jzXtsQBlq+MmX6z2jkfefVuiB5DuvJTtnhFK/5sz+/VOX2/SsZxGM060TI0EoNjqSXnK4xi+n92cspdi5nKB7nfSyIUfn407ky+97UoHuK5xcBZZ5bWY4DmR+DWcZ4JIwoI+D5r8XOiti6A8G3BavFytfTUYVGpYDf5N5gXzcY2Kw1FRPqtUZLL/eXKYjWatmpex57kv4r53+TucM+qdVwSMeKU4BzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbjyQXQakbbwmQPXzBzyunPV/bMobSszFXjDOA1E4es=;
 b=m20TuQ8DwgK7p14cCPUtWtWCwWzzw+d2t29SO+9yBdrjHVEpYyh5fHdkC3wazxtkmj7qr0aogErJV2qfdhKE7/tcL9aOPxFPaPksxVquea6EJuAab2YOcDK0AnVAo2WumZOpqAmXu/jd61hYJzbF6dwhGrF+9KmiQtzW9q7Vbr/Zl8DbFgSg/M1Iu04JzLudgLcwhq++kdbIiG8QhcDIMnMsdBrPoDkt3opkHRbO1QONLXao3eIt3bdmuJyloRLCBIHiXAAqhfcARyyNQDSzFloEf9HKo4e1cS3AhwonmFGK+BAaBgjV09kMlCsHzxudQ3hosTGRZQ76Nawv4Wz5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbjyQXQakbbwmQPXzBzyunPV/bMobSszFXjDOA1E4es=;
 b=Unw9b0yGEN8n0bCGm6lqymJy9XrUvllWTyyhsFic+257oQvF/Hhn/coeYvXMK1bkdZkXIg6herPunxaPumU5OYZSyDa8UnscLasuWwlsUco8XjdxsEAAyem0GFK07vDViB90Oiddyt0phCsZKXshYhYezkYhRkm6pCd5C/1ZuPLsWk9o0CR5lMDZqRbfoJjHJki2l9Dm3+OQRG7U0EZBw6Aex5aEYOMpCRZr2XfTg7SHIUtj0OczQUvl2mnd84F5gKzRC/yEu4/ZFW0HT7DsBuxvOSxPBuTb/yR7WmL9vrbGQCsrI+7ToELRFA7d5nMO3oph+7z2rRtrExLPaxkmdA==
Received: from MN2PR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:236::11)
 by IA0PR22MB4307.namprd22.prod.outlook.com (2603:10b6:208:48a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 11:22:04 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::64) by MN2PR05CA0042.outlook.office365.com
 (2603:10b6:208:236::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.20 via Frontend Transport; Wed,
 29 Apr 2026 11:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 11:22:04 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 3B8FB131E4;
 Wed, 29 Apr 2026 14:22:01 +0300 (EEST)
Date: Wed, 29 Apr 2026 14:22:00 +0300
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: festevam@gmail.com, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>, lukma@denx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/7] imx6: clock: allow different clock sources for ldb
Message-ID: <afHp2CQGgxVM0aJI@zoo11.fihel.lab.ge-healthcare.net>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260428085117.402523-3-brian.ruley@gehealthcare.com>
 <afFrA4Dst5lvEVc2@shlinux89>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afFrA4Dst5lvEVc2@shlinux89>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|IA0PR22MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a9facf-e82e-42c3-ecf3-08dea5e18a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: kbqxQOLbcnfRKpNKyaZMcGsIHSjfaTcvfTle7vuK1Dk86X8Z7Am5F2HUEpziRAKhHIo6RNTjNFk+uTSxLHk/rOGzkxm36kEY59lIyvEB7M8En+nPoEsDiAloENK2V8zIEPbL3adz4ikQyFp98e/DH5GAHlBYMcVuKjLHWdJX1Z8sqHILkRgXZlJgTAybNZR+2ZYOy9mgxcN/V/k/UUB55UBVVMjemJJuXzthfJ9OMCxnUWIY07Q8WsY93x9YGVuD59p6QWRjQhWRqEsXv7ePcW2DOWZN12z0xxf6SboQ3jeXwboSGrdaLO/g5wd/P7t1QI1xjkrWuxcPGi6sFBzN1kZPI2P4QRLkBDou9fAQe3HT/z44bEwBIMhe4SzJztWZqvwRR/cDdFK2QhR+LskCH0UE/iPk8h6lCTmyHa8ipH9AyzWX7WcywSMNPdQbEFd3YVOHj+6I48O8wA3FOw9itDT4LjxvpSN8cLXX5yubhnmnDZT29HqmhYuL/Cmt1Ur+XPqLffMClzOMtfrpOirP2uXho01syNE9kGE6AAeMGy0muqgX9IwbIkvOLd/jBOV1fuHRnTYGDrM+lVfqnfyCECs6NzdAtMMXkJueE9wmEZiwXdRiOquuiGbwWp6+YuCqBkilFmlfYGk9cggtMlyeNb1VPJfyo8TQiQ/vYEWE2PA9JEjKv2sx+MUSQsbPlIgLiNzv86NGzJBSCUuOJkm9l7Gjk5Vq63dDIvPN/1CLZuw=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bqVH3xJ6+7h0YpIRO1UJWQZHzCWH7BmzWLuBDQf1xGCrbHdJwv6Ci3VbbUCSa2qVaYdJk3C5UaBG5apDOD2iFaCQgATUmsLHj3gxS6nL2+HY2U2aC+dfdleHOfjJevRUsuCkcz7m+Bl74VfzgMsZYDkp1n5N3Xsz2KsmY3k+ZH1wHcPNB0VCVUrn2VOx/th6QKRcZChtD/cCEBCTCCAUPTVyyX29w4d/jQ2N1CYipIareFeSXRi/qNBkRVZWYhtVdLqC1pKlrStzmAhyRRgbGQrdnExC9RmmbSd1AhMihh1xSKDT/5/e/GclBGbJJJokPWfIL3dQ+mt+6ZZ+4kKlaROWQPxsekqc7e8D08qWYr+UWPH519LJ4e6RekJA+bdonpVTNL2Pbo8gwEvECN9SI1lkH8fjXFCbweYfctQh9L6ngXBiXPwP4wV/b/3y/NJy
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 11:22:04.1060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a9facf-e82e-42c3-ecf3-08dea5e18a79
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4307
X-Mailman-Approved-At: Wed, 29 Apr 2026 14:40:47 +0200
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

On Apr 29, Peng Fan wrote:
> CAUTION: This email originated from outside of GE HealthCare. Only open links or attachments if you trust the sender. Report suspicious emails using Outlook’s “Report” button.
> 
> On Tue, Apr 28, 2026 at 11:51:08AM +0300, Brian Ruley wrote:
> >The LDB clock sources don't have to be the same, so allow DI1 clock to
> >be configured separately.
> >
> >Unlikely to be significant, but the reason will become apparent in the
> >following commit.
> >
> >Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> 
> I not see other patches in this thread. Have they been sent out to list?
> 
> Regards
> Peng

Hi Peng,

Did you find it on the list?

If not:
https://lore.kernel.org/u-boot/20260428085117.402523-1-brian.ruley@gehealthcare.com/T/#t

BR,
Brian
