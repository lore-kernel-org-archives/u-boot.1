Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E04C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAF9B405EF;
	Tue,  1 Sep 2026 14:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9pYumw38wwIi; Tue,  1 Sep 2026 14:59:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788274763;
	bh=ltRCcw+FGex3yBgoDGHVnXyGYQdc5Yj0NlNjNzm1pVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQIhPeE22LCs6tldC8bs5EuHcLlLSLoI3noe6kDIcZPTutgXIvID0Djh6Tx9U6Lvt
	 zUDkI1vwwUB9l6PFpntKGBsu3Bqx7ibYGwLLePbIOIHbI0/0rqO08g3d+zKt+K+4Ej
	 GzhHAnPiNMmKbj9R4+DFQRqhQOpHKX5L0BWnp+FA/VYVC8XnMCXcZDnPobEopEhSJ4
	 AlcILlgEAJk10STmr0Cm6M18Yu4H93LK02CDOzQm+4gJOzXJiurwm2OWlRt/2Aatq8
	 O5MuX6U0lgYKeVzJC8fb8JKPZKehMzKaGh2xYVKGsH2b+NxGx541l//oqb5YC1914r
	 bzA/8ekiXH55Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 589B2406C3;
	Tue,  1 Sep 2026 14:59:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CF5D279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F123401CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLs39na4V8Ib for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:59:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=IzIibK8E; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=IzIibK8E
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85312401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:59:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bnP7V6QMcphtbWecc3Bm1frXs29vedjdnY9Cu/jJRDEC/22me5ko0O46IA6yy1PM0Dg4ItU+/jvDCOZS7jfwnwOdJP64FBZMFr0kcTDLC0CIm01y8qrFo2NQpYb4rOjQqpJscwokCNOVwJUvB6J1oS+yEl82W7arW25BNcgAHXGpZdFnvDBx0RRk7GoA3IJEtTUP655B1vxtEbboI9cTwVdE7xxQsLLLs6lTooeuAqnKKJIOOZMLgaeN+JtGrPfwV3lZbGOD/W9Bpe8rin3oTSPM1CmSGUKSiQmOeEKOmTsu4Uw3aimBwPVAdMnaLwgqCl1i3zdfK0OuzvRbk8E70A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltRCcw+FGex3yBgoDGHVnXyGYQdc5Yj0NlNjNzm1pVo=;
 b=bae20trAlXad1FMGen1VW7PtbY+6E7KdvqC8ogniS8UmZ381M0RisKy95EuVp2dffK/f70i0+4HrlQkm0wkWQ9X4u3K2picL7x6Cu9oyG9xoTgcACSbosa6+UlZKkK+f5Ob/qpLBVr+vUs9kYrJ+1KfX8+BLXGfhPc9sfulnt9DgCV03x8Tb/DiLwx33t/vS3ahqJP3T+A88EWYlawaJ/n04AHuBYlLr46LcOaoWe8Wd/GG2O13bVoY9p2lH0BbIt5kOFHJZ9PzablxGNH7AGp3XcKoI7bDwWUQLr8MPPMH7CNnj9marDh/TUmwchAyPFG09x98iUrhWmfYLCfjEig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltRCcw+FGex3yBgoDGHVnXyGYQdc5Yj0NlNjNzm1pVo=;
 b=IzIibK8ExyBKHRWUBLLu3Iy6t44M1iDa4b1S9uZ+4woIlp6TYVq/gWy+vZd0AMNYDa6gQUyev+CSo3IPvPfKhN6EPA8o10xSH8HXkJsPUgL6JCf34LKxG2g2idhPFC2ti+wrKej6RtSZuO7xx3EE2EiBOr3HP3+4jnrnzyIcpBo=
Received: from DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) by AM9PR08MB6307.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 14:59:07 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::ad) by DUZPR01CA0058.outlook.office365.com
 (2603:10a6:10:469::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Tue, 1 Sep 2026 14:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2VyKJk4hLWRY2o4/ems8Es1rLnJ/ZTg7GIAeUFxaulPoO1/R8GjFze+CwBtXJ5ySO4zu61gBqTJcr6eDPHAiZvRLo8LBccBj0OCCIA0q5Fg53nLRUajTUEqYsAjSMhj47fdURINTwLFIdurgoKebWuxOitW+3F1gAjH1uzqtt2WUigPgSHGgugU0P+vllDTz1dpwWmmHo1/MpWIvCxFPDv+kJSLSD7WAnBE1YLKV1m2VVPWjsWEe60kDvWWKQT027Sda2rjq+wjW4fBU+HIAGBo+4/uKUjm24g/L1Evh8aatbZWKO3lV470bTay007pA6fQ7EZeo2AMddy94sJofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltRCcw+FGex3yBgoDGHVnXyGYQdc5Yj0NlNjNzm1pVo=;
 b=uZX24qkM449+4aA6Dsl5Fz6XpkN8JTLG1un7Mt+BtUig9BFBGlasPCTEMnYkBwZZV0Mq5CYHbfzp2pVOyl+HSZtSSzhzskN2/DQUrXLT9vY22VuY6xC/ZrVjfZ5pfce8UhXXw9P6TGxS2OqEf3SEIbIfXCBMwZpD99UURqZvi5pMrYCppYydLFYbMA8mGMTQ4bs3yP5DhSYsBdbRBDrKnprv0lDnx77qyQIH5yL7KU2qOh9DhfXULl9A2KAMQ7s0jDAe9qwDzo96xji+x1vFPuD8DK7PhT3dy8Q9N9R3jhERuLbzw/KZsEWNr+9rlCFlHm13vTKEX2IJ6ciyEujAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltRCcw+FGex3yBgoDGHVnXyGYQdc5Yj0NlNjNzm1pVo=;
 b=IzIibK8ExyBKHRWUBLLu3Iy6t44M1iDa4b1S9uZ+4woIlp6TYVq/gWy+vZd0AMNYDa6gQUyev+CSo3IPvPfKhN6EPA8o10xSH8HXkJsPUgL6JCf34LKxG2g2idhPFC2ti+wrKej6RtSZuO7xx3EE2EiBOr3HP3+4jnrnzyIcpBo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8781.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Tue, 1 Sep 2026
 14:58:31 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 14:58:31 +0000
Message-ID: <3d6cb415-0629-44d4-889d-d81bb52adc70@arm.com>
Date: Tue, 1 Sep 2026 16:58:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] net: lwip: share one network runtime between clients
To: James Hilliard <james.hilliard1@gmail.com>,
 u-boot@lists.u-boot-project.org, Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>,
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, nd <nd@arm.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
 <20260825-submit-lwip-runtime-netconsole-v1-v1-8-0892966aa758@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-8-0892966aa758@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0206.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8781:EE_|DU2PEPF00028D02:EE_|AM9PR08MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bdf480-c5dd-4c4f-7799-08df08399227
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|5023799004|18002099003|22082099003|11063799006|3023799007|56012099006|4143699003|6133799003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info-Original: Gvbgo84axkevJ+ovPicnqXqsmkrKC858L5b6dnuSB9DR4VIfUZGQogRDv+0FsZ6i9tH3aX8wRGV2Gnrk/co3mG68//A/wHYMdB2dW0B1+HldGvoL+cEWcERFggrbK6eiUgp1LvPVRhgotgb9rOde9IFLPragZ3C/YvdOLRNwNZHK7L81kCQEvCv+P8uaywrr6Bc7XuLMB0qDwGSOKy6OZUNVdE4GzPWssVH0FJ5N/NwZ0pnDTGnEURv2QkgnEvonMHC9ufust67uyOEYdsFTcNLk8j4TleBHNqVwA1uwzl5uwst8MC2ufgEzHZr/TjSjo5y/qdp5380/x3q0h5jARWJoPo25Yibv/PkM9HeOTLSwyhzYAhzNrJ+KUJopuPv/fpti05uIT3H8Bpy6pNEA3WyP05cRt1jfjkx2JF0TY2uPfuk/BKTITeXftg1pkX2vcH62wHIl53OCqC04MXk5xUTZ2MCZpqdXEzHy2VuZK77zRxHBiCZMg40ltXaA2awfbrMzRlJSovpQ+YGHyCNzryVILGn8S7QOI1Qrt3RqYsF/aLrh+5GbcoB4FVzkiaXerMdd4ehnbAsQWuIaFMZNyUy8x0UUTwp0r+07DKi123xmEa73KUi2g2dVuNdastkYgDWizdgzrd8Q1hGRKUFS7c1Gqap9sYTGSv6NYWbQbg+xscvozt+HXH94ZET1Ho9WAWCLUM4E3gQKis/59PnXEohPyNWLrMmX+9MCKc1UtMc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(5023799004)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006)(4143699003)(6133799003)(10067099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: XR+i+nQSDGxCt19QcajQZ603j3hMuy+JMp506Tml/McuzwJyJ1KEPIElCfJ2YoSdPJcsMZXERXZmUZN1TnpXPjyTwljttSxid1V9+tZr2ilUZGBYnyluGrvHh/4+p0tb63FlpvoXqfq6EN1CwieYfh33Kdlnz5Z80jFZvGWxMb3s4pdix9OhLw8k93MxifV1rYhq/gO730kFG5rIB31Fdn6wNa3OfBG2GTFpSmD7t+bK+D9DWn+uwboPWVHg44pfuNDAmXXul1vH3pgDq+xlJ+mzowZfrFKi6kPUM/5RoGdbMjf8Ap6horNTTpyEEhV3HGahrcVFx2+40twmBkX7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8781
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 05bf74c6-3c3e-42ed-98b2-08df08397d15
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|14060799003|7416014|376014|23010399003|36860700016|35042699022|6133799003|3023799007|10067099003|56012099006|5023799004|4143699003|11063799006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: 1kPJ2V4I8Yo9iA0WU3lQ1QXU4VLlDq168Z/NuRYVOYzW1gXBCRVPcikUK/OlBzNGR2QiVycEIbAN7GsW/jUxo0Im26FXAknv10DJJejsri4+J5v0ZZCrMC2rSo+tDW5TI55JA+H3/Q4qvWzyPdqA/x5AGWuj0R9gsSGFYHuu4OANAgurziGJo6TQLJ3KkXkkQbASCKTqM2p0T3tilB0daFqAlysbLh5i7q4gsWeWWU7VR+/NxVSBNzT73p0JkmIX8+OL0+coYaWLFyPeVIVFaqJdcmuPlWpyobSAGBcL5ixj+rQrcbT7XFv/5+7NNcn1YBsAOCaLubyra4moawlGKStApjRe0q+cseGAcDidWLQFRMZWfh7NkAAdhmalYIPM5lr/Cc373oZ4dvVbxFTPrWtpJQkIbAeY+XOIBSlasrCmHqIOWx/CL/5DdIhHzonPV8GwrEYSpw+Rut4FWXzAq+zlLN02V5TMfH1Vr6AxuardzNqiEp+K0TNubshdOf0VDMQ0FAwChfZrzt1RtG1bvqS43E8AzadwoEsPsRHwF/Pa8c/5GHLhinHrJlpFTKzuHivqhEn/Mooi+IEJ9k1kQq8yCUsuidXzi8PVinKTLba6wR+WgDyaM9gxa3jK6GITsrisOcPazpMgbo9aDRCNQqqVU2z3KEdPlz6yGvtl790UMWkaxuhiD+tOcWB85E701riM26bvhiNg2v2EAKiyXHwWHow6krlOvMhMkGVhRZ62UiJGv5Je++6eLnLBuDN+
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(14060799003)(7416014)(376014)(23010399003)(36860700016)(35042699022)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kCeQI4ik/aPi3LHa98y9JezjaQxrlxZfdXp3qINW7HoPghrW1Nvkj6OaPF+fGmJ7l70ON6Obhiq8CYG5D/1+EqpztFFKEc4sMBoWbgNat0PnVV0lOcJHX+ZsVX7pC0mWEfrWG45ypMorB4GYviPcJp/t+wNAPiPEZfPcO5dGH0Rr7+LnnNMU1s3X2K6CTIXN3ApWsd4PoBPMMBbueLgoHbVTrjLG9mtrSOZ9aOvWAN6mihR7ZpSC7DFg1F1DOzsRFRiOp37Va3+3pVQ+7k725Fo8vSxAO59ekDIvnpWbTAQidJmgMgkToylPGf/TDmrUik431yMDGXG4nX3c9gcMEcw5sqQMpdO2LsTT2PYe9dbnlCNeRwvFxdHI0m845AKfs7MzST88S+Gf7oNtt7JdBJUDvCXrsG6oHrmWiuAzDxw84lLs2Bspc1wfHruUVz4W
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:59:06.6787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bdf480-c5dd-4c4f-7799-08df08399227
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6307
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

Hi James,

On 26/08/2026 07:29, James Hilliard wrote:
> Each lwIP command currently creates the only netif and removes it when
> the command exits. A second client therefore replaces the first client's
> interface, and the first exit can stop Ethernet while the second is active.
> 
> Add a reference-counted runtime attachment which owns one Ethernet
> device and netif. All attached clients use the global poll function, so
> lwIP dispatches packets to every registered PCB. A DHCP attachment may
> temporarily own interface addressing; the environment configuration is
> restored when it leaves.
> 
> Migrate the existing commands and clean up their PCBs, callbacks and
> timeouts before detaching. Wget now aborts an interrupted request and
> releases its TLS configuration, while DHCP leaves its acquired address
> configured.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  cmd/lwip/ping.c     |  41 ++++-----
>  cmd/lwip/sntp.c     |  19 ++--
>  include/net-lwip.h  |  42 +++++++--
>  net/lwip/dhcp.c     |  57 ++++--------
>  net/lwip/dns.c      |  24 ++---
>  net/lwip/net-lwip.c | 248 ++++++++++++++++++++++++++++++++++++++++++++--------
>  net/lwip/nfs.c      |  25 ++----
>  net/lwip/tftp.c     |  54 +++++-------
>  net/lwip/wget.c     |  70 ++++++++-------
>  9 files changed, 372 insertions(+), 208 deletions(-)
> 
> diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
> index 98fa8e22bce..9e159106f62 100644
> --- a/cmd/lwip/ping.c
> +++ b/cmd/lwip/ping.c
> @@ -116,30 +116,23 @@ static void ping_send(void *arg)
>  	}
>  }
>  
> -static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
> +static int ping_loop(struct net_lwip_ctx *net, const ip_addr_t *addr)
>  {
>  	struct ping_ctx ctx = {};
> -	struct netif *netif;
>  	int ret;
>  
> -	netif = net_lwip_new_netif(udev);
> -	if (!netif)
> -		return -ENODEV;
> -
> -	printf("Using %s device\n", udev->name);
> +	printf("Using %s device\n", net->dev->name);
>  
>  	ret = ping_raw_init(&ctx);
> -	if (ret < 0) {
> -		net_lwip_remove_netif(netif);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	ctx.target = *addr;
>  
>  	ping_send(&ctx);
>  
>  	do {
> -		net_lwip_rx(udev, netif);
> +		net_lwip_poll();
>  		if (ctx.alive)
>  			break;
>  		if (ctrlc()) {
> @@ -151,8 +144,6 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
>  	sys_untimeout(ping_send, &ctx);
>  	ping_raw_stop(&ctx);
>  
> -	net_lwip_remove_netif(netif);
> -
>  	if (ctx.alive)
>  		return 0;
>  
> @@ -162,6 +153,7 @@ static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
>  
>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	struct net_lwip_ctx net = {};
>  	ip_addr_t addr;
>  	int ret;
>  
> @@ -174,13 +166,22 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	net_try_count = 1;
>  
>  	do {
> -		if (net_lwip_eth_start() == 0) {
> -			ret = ping_loop(eth_get_dev(), &addr);
> -			net_lwip_eth_stop();
> -			if (ret == 0)
> -				return CMD_RET_SUCCESS;
> -		}
> -	} while (net_start_again() == 0);
> +		ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV);
> +		if (!ret)
> +			break;
> +	} while (!net_start_again());
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	do {
> +		ret = ping_loop(&net, &addr);
> +		if (!ret)
> +			break;
> +	} while (!net_lwip_restart(&net));
> +
> +	net_lwip_stop(&net);
> +	if (!ret)
> +		return CMD_RET_SUCCESS;
>  
>  	return CMD_RET_FAILURE;
>  }
> diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
> index 584151ba7d1..2801f66866a 100644
> --- a/cmd/lwip/sntp.c
> +++ b/cmd/lwip/sntp.c
> @@ -54,14 +54,8 @@ static bool ntp_server_known(void)
>  	return false;
>  }
>  
> -static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
> +static int sntp_loop(struct net_lwip_ctx *net, ip_addr_t *srvip)
>  {
> -	struct netif *netif;
> -
> -	netif = net_lwip_new_netif(udev);
> -	if (!netif)
> -		return -1;
> -
>  	sntp_state = NOT_DONE;
>  
>  	sntp_setoperatingmode(SNTP_OPMODE_POLL);
> @@ -71,7 +65,6 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>  	} else {
>  		if (!ntp_server_known()) {
>  			log_err("error: ntpserverip not set\n");
> -			net_lwip_remove_netif(netif);
>  			return -1;
>  		}
>  	}
> @@ -79,7 +72,7 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>  
>  	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
>  	while (sntp_state == NOT_DONE) {
> -		net_lwip_rx(udev, netif);
> +		net_lwip_poll();
>  		if (ctrlc()) {
>  			printf("\nAbort\n");
>  			sntp_state = ABORTED;
> @@ -89,7 +82,6 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>  	sys_untimeout(no_response, NULL);
>  
>  	sntp_stop();
> -	net_lwip_remove_netif(netif);
>  
>  	if (sntp_state == SUCCESS)
>  		return 0;
> @@ -99,6 +91,7 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>  
>  int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	struct net_lwip_ctx net = {};
>  	ip_addr_t *srvip;
>  	char *server;
>  	ip_addr_t ipaddr;
> @@ -125,16 +118,16 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		return CMD_RET_USAGE;
>  	}
>  
> -	if (net_lwip_eth_start() < 0)
> +	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV))
>  		return CMD_RET_FAILURE;
>  
> -	if (sntp_loop(eth_get_dev(), srvip) < 0)
> +	if (sntp_loop(&net, srvip) < 0)
>  		goto out;
>  
>  	ret = CMD_RET_SUCCESS;
>  
>  out:
> -	net_lwip_eth_stop();
> +	net_lwip_stop(&net);
>  
>  	return ret;
>  }
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 8e59a2299e0..0d0394fce14 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -6,6 +6,35 @@
>  #include <lwip/ip4.h>
>  #include <lwip/netif.h>
>  
> +struct udevice;
> +
> +/**
> + * enum net_lwip_addr_mode - Initial address configuration for a client
> + * @NET_LWIP_ADDR_ENV: Configure the interface from the environment
> + * @NET_LWIP_ADDR_NONE: Start with an unconfigured IPv4 interface
> + */
> +enum net_lwip_addr_mode {
> +	NET_LWIP_ADDR_ENV,
> +	NET_LWIP_ADDR_NONE,
> +};

I do see a problem with this: attaching a NET_LWIP_ADDR_NONE client
(typically, DHCP) while a NET_LWIP_ADDR_ENV client is active can change
the network configuration underneath that client. If the other client is
netconsole/UDP bound to IP_ADDR_ANY this may be tolerable, but for TCP
clients it can break an established connection. The failure mode is not
a clean disconnect but a connection which can stall or eventually time
out.

I think NET_LWIP_ADDR_NONE therefore needs to have explicit address
ownership semantics and should not be allowed to coexist with arbitrary
NET_LWIP_ADDR_ENV clients. How about introducing three modes like so:

/**
 * enum net_lwip_addr_mode - IPv4 requirements of a runtime client
 * @NET_LWIP_ADDR_ENV_STRICT:
 *	Use environment addressing and require it to remain stable while the
 *	client is attached.
 * @NET_LWIP_ADDR_ENV_FLEXIBLE:
 *	Use environment addressing, but permit another client to temporarily
 *	change or clear the shared netif's IPv4 configuration. The client's
 *	protocol state must remain valid across such changes; communication
 *	may be temporarily unavailable. Intended for clients such as
 *	netconsole which use connectionless UDP bound to IP_ADDR_ANY.
 * @NET_LWIP_ADDR_NONE:
 *	Temporarily own the shared netif's IPv4 configuration and start with
 *	no IPv4 address. Intended for DHCP. This mode may coexist only with
 *	NET_LWIP_ADDR_ENV_FLEXIBLE clients.
 */
enum net_lwip_addr_mode {
	NET_LWIP_ADDR_ENV_STRICT,
	NET_LWIP_ADDR_ENV_FLEXIBLE,
	NET_LWIP_ADDR_NONE,
};

The net_lwip_runtime struct would need a 'unsigned int strict_env_users;'
and a few tests would need to be adjusted, but the overall impact should be
small. What do you think?

> +
> +/**
> + * struct net_lwip_ctx - Attachment to the shared lwIP runtime
> + * @dev: Ethernet device used by the runtime
> + * @netif: Shared lwIP network interface
> + * @addr_mode: Address mode requested by this client
> + *
> + * Clients must zero-initialize this structure before passing it to
> + * net_lwip_start(). Multiple active clients share @dev and @netif. A client
> + * must remove its callbacks and protocol control blocks before calling
> + * net_lwip_stop().
> + */
> +struct net_lwip_ctx {
> +	struct udevice *dev;
> +	struct netif *netif;
> +	enum net_lwip_addr_mode addr_mode;
> +};
> +
>  /* HTTPS authentication mode */
>  enum auth_mode {
>  	AUTH_NONE,
> @@ -34,13 +63,12 @@ static inline int eth_is_on_demand_init(void)
>  int eth_init_state_only(void); /* Set active state */
>  
>  int net_lwip_dns_init(void);
> -int net_lwip_eth_start(void);
> -void net_lwip_eth_stop(void);
> -struct netif *net_lwip_new_netif(struct udevice *udev);
> -struct netif *net_lwip_new_netif_noip(struct udevice *udev);
> -void net_lwip_remove_netif(struct netif *netif);
> -struct netif *net_lwip_get_netif(void);
> -int net_lwip_rx(struct udevice *udev, struct netif *netif);
> +int net_lwip_start(struct net_lwip_ctx *ctx,
> +		   enum net_lwip_addr_mode addr_mode);
> +void net_lwip_stop(struct net_lwip_ctx *ctx);
> +int net_lwip_restart(struct net_lwip_ctx *ctx);
> +int net_lwip_refresh(struct net_lwip_ctx *ctx);
> +int net_lwip_poll(void);
>  int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
>  
>  /**
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index a5e2e7d4da0..0494e3981d5 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -11,7 +11,6 @@
>  #include <lwip/apps/sntp.h>
>  #include <lwip/dhcp.h>
>  #include <lwip/dns.h>
> -#include <lwip/timeouts.h>
>  #include <net.h>
>  #include <time.h>
>  
> @@ -22,34 +21,23 @@
>  static char boot_file_name[DHCP_BOOT_FILE_LEN];
>  #endif
>  
> -static void call_lwip_dhcp_fine_tmr(void *ctx)
> -{
> -	dhcp_fine_tmr();
> -	sys_timeout(DHCP_FINE_TIMER_MSECS, call_lwip_dhcp_fine_tmr, NULL);
> -}
> -
> -static int dhcp_loop(struct udevice *udev)
> +static int dhcp_loop(struct net_lwip_ctx *net)
>  {
>  	char ipstr[] = "ipaddr\0\0\0";
>  	char maskstr[] = "netmask\0\0\0";
>  	char gwstr[] = "gatewayip\0\0\0";
>  	const ip_addr_t *ntpserverip;
>  	unsigned long start;
> -	struct netif *netif;
>  	struct dhcp *dhcp;
> -	bool bound;
> +	bool bound = false;
>  	int idx;
>  
> -	idx = dev_seq(udev);
> +	idx = dev_seq(net->dev);
>  	if (idx < 0 || idx > 99) {
>  		log_err("unexpected idx %d\n", idx);
>  		return CMD_RET_FAILURE;
>  	}
>  
> -	netif = net_lwip_new_netif_noip(udev);
> -	if (!netif)
> -		return CMD_RET_FAILURE;
> -
>  	/*
>  	 * Request the DHCP stack to parse and store the NTP servers for
>  	 * eventual use by the SNTP command
> @@ -59,15 +47,13 @@ static int dhcp_loop(struct udevice *udev)
>  
>  	start = get_timer(0);
>  
> -	if (dhcp_start(netif))
> +	if (dhcp_start(net->netif))
>  		return CMD_RET_FAILURE;
>  
> -	call_lwip_dhcp_fine_tmr(NULL);
> -
>  	/* Wait for DHCP to complete */
>  	do {
> -		net_lwip_rx(udev, netif);
> -		bound = dhcp_supplied_address(netif);
> +		net_lwip_poll();
> +		bound = dhcp_supplied_address(net->netif);
>  		if (bound)
>  			break;
>  		if (ctrlc()) {
> @@ -77,14 +63,10 @@ static int dhcp_loop(struct udevice *udev)
>  		mdelay(1);
>  	} while (get_timer(start) < DHCP_TIMEOUT_MS);
>  
> -	sys_untimeout(call_lwip_dhcp_fine_tmr, NULL);
> -
> -	if (!bound) {
> -		net_lwip_remove_netif(netif);
> +	if (!bound)
>  		return CMD_RET_FAILURE;
> -	}
>  
> -	dhcp = netif_dhcp_data(netif);
> +	dhcp = netif_dhcp_data(net->netif);
>  
>  	env_set("bootfile", dhcp->boot_file_name);
>  
> @@ -123,26 +105,18 @@ static int dhcp_loop(struct udevice *udev)
>  	printf("DHCP client bound to address %pI4 (%lu ms)\n",
>  	       &dhcp->offered_ip_addr, get_timer(start));
>  
> -	net_lwip_remove_netif(netif);
>  	return CMD_RET_SUCCESS;
>  }
>  
>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	struct net_lwip_ctx net = {};
>  	int ret;
> -	struct udevice *dev;
>  
> -	if (net_lwip_eth_start() < 0)
> +	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE))
>  		return CMD_RET_FAILURE;
>  
> -	dev = eth_get_dev();
> -	if (!dev) {
> -		log_err("No network device\n");
> -		ret = CMD_RET_FAILURE;
> -		goto out;
> -	}
> -
> -	ret = dhcp_loop(dev);
> +	ret = dhcp_loop(&net);
>  	if (ret)
>  		goto out;
>  
> @@ -156,7 +130,14 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	ret = CMD_RET_SUCCESS;
>  
>  out:
> -	net_lwip_eth_stop();
> +	if (net.netif) {
> +		if (dhcp_supplied_address(net.netif))
> +			dhcp_stop_without_release(net.netif);
> +		else
> +			dhcp_release_and_stop(net.netif);
> +		dhcp_cleanup(net.netif);
> +	}
> +	net_lwip_stop(&net);
>  
>  	return ret;
>  }
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> index b620b0611d6..15bc06797c2 100644
> --- a/net/lwip/dns.c
> +++ b/net/lwip/dns.c
> @@ -34,24 +34,18 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
>  	ip_addr_set(&dns_cb_arg->host_ipaddr, ipaddr);
>  }
>  
> -static int dns_loop(struct udevice *udev, const char *name, const char *var)
> +static int dns_loop(struct net_lwip_ctx *net, const char *name,
> +		    const char *var)
>  {
>  	struct dns_cb_arg dns_cb_arg = { };
> -	struct netif *netif;
>  	const char *ipstr;
>  	ip_addr_t ipaddr;
>  	ulong start;
>  	int ret;
>  
> -	netif = net_lwip_new_netif(udev);
> -	if (!netif)
> +	if (net_lwip_dns_init())
>  		return CMD_RET_FAILURE;
>  
> -	if (net_lwip_dns_init()) {
> -		net_lwip_remove_netif(netif);
> -		return CMD_RET_FAILURE;
> -	}
> -
>  	dns_cb_arg.done = false;
>  
>  	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
> @@ -62,7 +56,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  		start = get_timer(0);
>  		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
>  		do {
> -			net_lwip_rx(udev, netif);
> +			net_lwip_poll();
>  			if (dns_cb_arg.done)
>  				break;
>  			if (ctrlc()) {
> @@ -71,10 +65,9 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  			}
>  		} while (get_timer(start) < DNS_TIMEOUT_MS);
>  		sys_untimeout(do_dns_tmr, NULL);
> +		dns_cancel(dns_cb, &dns_cb_arg);
>  	}
>  
> -	net_lwip_remove_netif(netif);
> -
>  	if (dns_cb_arg.done && !ip_addr_isany(&dns_cb_arg.host_ipaddr)) {
>  		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
>  		if (var)
> @@ -89,6 +82,7 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>  
>  int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	struct net_lwip_ctx net = {};
>  	char *name;
>  	char *var = NULL;
>  	int ret;
> @@ -101,12 +95,12 @@ int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	if (argc == 3)
>  		var = argv[2];
>  
> -	if (net_lwip_eth_start() < 0)
> +	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV))
>  		return CMD_RET_FAILURE;
>  
> -	ret = dns_loop(eth_get_dev(), name, var);
> +	ret = dns_loop(&net, name, var);
>  
> -	net_lwip_eth_stop();
> +	net_lwip_stop(&net);
>  
>  	return ret;
>  }
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 8f8f9d69020..4c012bfb1e3 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -31,7 +31,14 @@ void (*push_packet)(void *, int len) = 0;
>  int net_try_count;
>  static int net_restarted;
>  int net_restart_wrap;
> -static int net_lwip_eth_started;
> +static struct {
> +	struct udevice *dev;
> +	struct netif *netif;
> +	unsigned int users;
> +	unsigned int env_users;
> +	unsigned int no_addr_users;
> +	bool polling;
> +} net_lwip_runtime;
>  static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
>  	__aligned(PKTALIGN);
>  const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> @@ -107,19 +114,6 @@ static void eth_init_rings(void)
>  		net_rx_packets[i] = net_pkt_buf + i  * PKTSIZE_ALIGN;
>  }
>  
> -struct netif *net_lwip_get_netif(void)
> -{
> -	struct netif *netif, *found = NULL;
> -
> -	NETIF_FOREACH(netif) {
> -		if (!found)
> -			found = netif;
> -		else
> -			printf("Error: more than one netif in lwIP\n");
> -	}
> -	return found;
> -}
> -
>  static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>  			      ip4_addr_t *mask, ip4_addr_t *gw)
>  {
> @@ -196,19 +190,15 @@ int net_lwip_dns_init(void)
>  /*
>   * Initialize the network stack if needed and start the current device if valid
>   */
> -int net_lwip_eth_start(void)
> +static int net_lwip_eth_start(void)
>  {
>  	int ret;
>  
> -	if (net_lwip_eth_started++ > 0)
> -		return 0;
> -
>  	net_init();
>  	eth_halt();
>  	eth_set_current();
>  	ret = eth_init();
>  	if (ret < 0) {
> -		net_lwip_eth_started--;
>  		eth_halt();
>  		return ret;
>  	}
> @@ -216,14 +206,8 @@ int net_lwip_eth_start(void)
>  	return 0;
>  }
>  
> -void net_lwip_eth_stop(void)
> +static void net_lwip_eth_stop(void)
>  {
> -	if (!net_lwip_eth_started)
> -		return;
> -
> -	if (--net_lwip_eth_started)
> -		return;
> -
>  	eth_halt();
>  }
>  
> @@ -243,8 +227,6 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
>  		return NULL;
>  	}
>  
> -	netif_remove(net_lwip_get_netif());
> -
>  	ip4_addr_set_zero(&ip);
>  	ip4_addr_set_zero(&mask);
>  	ip4_addr_set_zero(&gw);
> @@ -287,20 +269,188 @@ static struct netif *new_netif(struct udevice *udev, bool with_ip)
>  	return netif;
>  }
>  
> -struct netif *net_lwip_new_netif(struct udevice *udev)
> +static void net_lwip_remove_netif(struct netif *netif)
>  {
> -	return new_netif(udev, true);
> +	netif_remove(netif);
> +	free(netif);
>  }
>  
> -struct netif *net_lwip_new_netif_noip(struct udevice *udev)
> +static int net_lwip_configure(enum net_lwip_addr_mode addr_mode)
>  {
> -	return new_netif(udev, false);
> +	ip4_addr_t ip, mask, gw;
> +
> +	if (addr_mode == NET_LWIP_ADDR_ENV) {
> +		if (get_udev_ipv4_info(net_lwip_runtime.dev, &ip, &mask, &gw))
> +			return -EINVAL;
> +	} else {
> +		ip4_addr_set_zero(&ip);
> +		ip4_addr_set_zero(&mask);
> +		ip4_addr_set_zero(&gw);
> +	}
> +
> +	if (!ip4_addr_cmp(netif_ip4_addr(net_lwip_runtime.netif), &ip) ||
> +	    !ip4_addr_cmp(netif_ip4_netmask(net_lwip_runtime.netif), &mask) ||
> +	    !ip4_addr_cmp(netif_ip4_gw(net_lwip_runtime.netif), &gw))
> +		netif_set_addr(net_lwip_runtime.netif, &ip, &mask, &gw);
> +
> +	return 0;
>  }
>  
> -void net_lwip_remove_netif(struct netif *netif)
> +/**
> + * net_lwip_start - Attach a client to the shared lwIP runtime
> + * @ctx: Zero-initialized client attachment
> + * @addr_mode: Initial IPv4 address configuration requested by the client
> + *
> + * The first client starts the selected Ethernet device and creates the lwIP
> + * network interface. Later clients share both resources. Address-less clients
> + * take priority while active so DHCP can configure the shared interface.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +int net_lwip_start(struct net_lwip_ctx *ctx,
> +		   enum net_lwip_addr_mode addr_mode)
>  {
> -	netif_remove(netif);
> -	free(netif);
> +	struct netif *netif;
> +	int ret;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +	if (ctx->netif || ctx->dev)
> +		return -EBUSY;
> +	if (addr_mode != NET_LWIP_ADDR_ENV &&
> +	    addr_mode != NET_LWIP_ADDR_NONE)
> +		return -EINVAL;
> +
> +	if (!net_lwip_runtime.users) {
> +		ret = net_lwip_eth_start();
> +		if (ret)
> +			return ret;
> +
> +		net_lwip_runtime.dev = eth_get_dev();
> +		netif = new_netif(net_lwip_runtime.dev,
> +				  addr_mode == NET_LWIP_ADDR_ENV);
> +		if (!netif) {
> +			net_lwip_runtime.dev = NULL;
> +			net_lwip_eth_stop();
> +			return -ENODEV;
> +		}
> +		net_lwip_runtime.netif = netif;
> +	} else if (addr_mode == NET_LWIP_ADDR_NONE &&
> +		   !net_lwip_runtime.no_addr_users) {
> +		ret = net_lwip_configure(NET_LWIP_ADDR_NONE);
> +		if (ret)
> +			return ret;
> +	} else if (addr_mode == NET_LWIP_ADDR_ENV &&
> +		   !net_lwip_runtime.no_addr_users) {
> +		ret = net_lwip_configure(NET_LWIP_ADDR_ENV);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	net_lwip_runtime.users++;
> +	if (addr_mode == NET_LWIP_ADDR_ENV)
> +		net_lwip_runtime.env_users++;
> +	else
> +		net_lwip_runtime.no_addr_users++;
> +
> +	ctx->dev = net_lwip_runtime.dev;
> +	ctx->netif = net_lwip_runtime.netif;
> +	ctx->addr_mode = addr_mode;
> +
> +	return 0;
> +}
> +
> +/**
> + * net_lwip_stop - Detach a client from the shared lwIP runtime
> + * @ctx: Active client attachment
> + *
> + * The final client removes the lwIP interface and stops Ethernet. When the
> + * last address-less client leaves, environment addressing is restored for
> + * any clients which remain attached. Callers must first remove every lwIP
> + * callback and protocol control block owned by @ctx. This function must not
> + * be called from a callback dispatched by net_lwip_poll().
> + */
> +void net_lwip_stop(struct net_lwip_ctx *ctx)
> +{
> +	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
> +	    ctx->dev != net_lwip_runtime.dev || !net_lwip_runtime.users)
> +		return;
> +
> +	if (ctx->addr_mode == NET_LWIP_ADDR_ENV)
> +		net_lwip_runtime.env_users--;
> +	else
> +		net_lwip_runtime.no_addr_users--;
> +	net_lwip_runtime.users--;
> +
> +	ctx->dev = NULL;
> +	ctx->netif = NULL;
> +
> +	if (!net_lwip_runtime.users) {
> +		net_lwip_remove_netif(net_lwip_runtime.netif);
> +		net_lwip_runtime.netif = NULL;
> +		net_lwip_runtime.dev = NULL;
> +		net_lwip_eth_stop();
> +		return;
> +	}
> +
> +	if (!net_lwip_runtime.no_addr_users &&
> +	    net_lwip_runtime.env_users &&
> +	    net_lwip_configure(NET_LWIP_ADDR_ENV))
> +		log_err("Failed to restore lwIP interface addressing\n");
> +}
> +
> +/**
> + * net_lwip_restart - Restart an exclusively held lwIP runtime
> + * @ctx: Active client attachment
> + *
> + * Stop the current interface, select the next interface according to the
> + * normal network retry policy and attach @ctx to the replacement interface.
> + * A shared runtime cannot be restarted without disrupting other clients.
> + *
> + * Return: 0 on success, -EBUSY if other clients are attached, or another
> + * negative error code.
> + */
> +int net_lwip_restart(struct net_lwip_ctx *ctx)
> +{
> +	enum net_lwip_addr_mode addr_mode;
> +	int ret;
> +
> +	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
> +	    ctx->dev != net_lwip_runtime.dev || !net_lwip_runtime.users)
> +		return -EINVAL;
> +	if (net_lwip_runtime.users != 1)
> +		return -EBUSY;
> +
> +	addr_mode = ctx->addr_mode;
> +	net_lwip_stop(ctx);
> +
> +	ret = net_start_again();
> +	if (ret)
> +		return ret;
> +
> +	return net_lwip_start(ctx, addr_mode);
> +}
> +
> +/**
> + * net_lwip_refresh - Refresh environment addressing for the shared interface
> + * @ctx: Active environment-addressed client attachment
> + *
> + * Address-less clients take priority, so refreshes are deferred until the
> + * last such client detaches.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +int net_lwip_refresh(struct net_lwip_ctx *ctx)
> +{
> +	if (!ctx || ctx->netif != net_lwip_runtime.netif ||
> +	    ctx->dev != net_lwip_runtime.dev ||
> +	    ctx->addr_mode != NET_LWIP_ADDR_ENV)
> +		return -EINVAL;
> +
> +	if (net_lwip_runtime.no_addr_users)
> +		return 0;
> +
> +	return net_lwip_configure(NET_LWIP_ADDR_ENV);
>  }
>  
>  /*
> @@ -343,7 +493,7 @@ static struct pbuf *alloc_pbuf_and_copy(uchar *data, int len)
>  	return p;
>  }
>  
> -int net_lwip_rx(struct udevice *udev, struct netif *netif)
> +static int net_lwip_rx(struct udevice *udev, struct netif *netif)
>  {
>  	struct pbuf *pbuf;
>  	uchar *packet;
> @@ -387,6 +537,32 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>  	return len;
>  }
>  
> +/**
> + * net_lwip_poll - Service the shared lwIP runtime
> + *
> + * Run lwIP timers, schedule other U-Boot work and dispatch received packets
> + * to all registered lwIP protocol control blocks. Reentrant calls are rejected
> + * so protocol callbacks may safely invoke code which attempts to poll.
> + *
> + * Return: Receive status, -ENODEV with no active clients, or -EBUSY when a
> + * poll is already in progress.
> + */
> +int net_lwip_poll(void)
> +{
> +	int ret;
> +
> +	if (!net_lwip_runtime.users)
> +		return -ENODEV;
> +	if (net_lwip_runtime.polling)
> +		return -EBUSY;
> +
> +	net_lwip_runtime.polling = true;
> +	ret = net_lwip_rx(net_lwip_runtime.dev, net_lwip_runtime.netif);
> +	net_lwip_runtime.polling = false;
> +
> +	return ret;
> +}
> +
>  /**
>   * net_lwip_dns_resolve() - find IP address from name or IP
>   *
> diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
> index 4cc36373fdd..2b7ee22ccc5 100644
> --- a/net/lwip/nfs.c
> +++ b/net/lwip/nfs.c
> @@ -98,10 +98,9 @@ static int nfs_timeout_check(void)
>  	return 1;
>  }
>  
> -static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
> +static int nfs_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
>  		    ip_addr_t srvip)
>  {
> -	struct netif *netif;
>  	int ret;
>  
>  	nfs_download_state = NETLOOP_FAIL;
> @@ -110,16 +109,12 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  	if (!fname || addr == 0)
>  		return -1;
>  
> -	netif = net_lwip_new_netif(udev);
> -	if (!netif)
> -		return -1;
> -
>  	strlcpy(nfs_path_buff, fname, sizeof(nfs_path_buff));
>  
>  	nfs_filename = nfs_basename(nfs_path_buff);
>  	nfs_path     = nfs_dirname(nfs_path_buff);
>  
> -	printf("Using %s device\n", udev->name);
> +	printf("Using %s device\n", net->dev->name);
>  
>  	printf("File transfer via NFS from server %s; our IP address is %s\n",
>  	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
> @@ -139,7 +134,6 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  
>  	ret = nfs_udp_init(&sess_ctx);
>  	if (ret < 0) {
> -		net_lwip_remove_netif(netif);
>  		debug("Failed to init network interface, aborting for error = %d\n", ret);
>  		return ret;
>  	}
> @@ -152,7 +146,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  
>  	timer_start = get_timer(0);
>  	do {
> -		net_lwip_rx(udev, netif);
> +		net_lwip_poll();
>  		if (net_state != NETLOOP_CONTINUE)
>  			break;
>  		if (ctrlc()) {
> @@ -165,7 +159,8 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  	} while (true);
>  	debug("%s: Loop exit at %lu\n", __func__, get_timer(0));
>  
> -	net_lwip_remove_netif(netif);
> +	udp_remove(sess_ctx.pcb);
> +	sess_ctx.pcb = NULL;
>  
>  	if (net_state == NETLOOP_SUCCESS) {
>  		ret = 0;
> @@ -186,8 +181,8 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  
>  int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	struct net_lwip_ctx net = {};
>  	int ret = CMD_RET_SUCCESS;
> -	bool started = false;
>  	char *arg = NULL;
>  	char *words[2] = { };
>  	char *fname = NULL;
> @@ -278,17 +273,15 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		goto out;
>  	}
>  
> -	if (net_lwip_eth_start() < 0) {
> +	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV)) {
>  		ret = CMD_RET_FAILURE;
>  		goto out;
>  	}
> -	started = true;
>  
> -	if (nfs_loop(eth_get_dev(), laddr, fname, srvip) < 0)
> +	if (nfs_loop(&net, laddr, fname, srvip) < 0)
>  		ret = CMD_RET_FAILURE;
>  out:
> -	if (started)
> -		net_lwip_eth_stop();
> +	net_lwip_stop(&net);
>  	if (arg != net_boot_file_name)
>  		free(arg);
>  	return ret;
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index d6a9f29a260..59bae93ab35 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -226,11 +226,10 @@ static void no_response(void *arg)
>  	ctx->done = FAILURE;
>  }
>  
> -static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
> +static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
>  		     ip_addr_t srvip, uint16_t srvport)
>  {
>  	int blksize = CONFIG_TFTP_BLOCKSIZE;
> -	struct netif *netif;
>  	struct tftp_ctx ctx;
>  	const char *ep;
>  	err_t err;
> @@ -241,10 +240,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	if (!srvport)
>  		srvport = TFTP_PORT;
>  
> -	netif = net_lwip_new_netif(udev);
> -	if (!netif)
> -		return -1;
> -
>  	ctx.done = NOT_DONE;
>  	ctx.size = 0;
>  	ctx.block_count = 0;
> @@ -254,7 +249,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	ctx.wrq_accepted = false;
>  	ctx.fname[0] = '\0';
>  
> -	printf("Using %s device\n", udev->name);
> +	printf("Using %s device\n", net->dev->name);
>  	printf("TFTP from server %s; our IP address is %s\n",
>  	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
>  	printf("Filename '%s'.\n", fname);
> @@ -262,8 +257,10 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	printf("Loading: ");
>  
>  	err = tftp_init_client(&tftp_context);
> -	if (!(err == ERR_OK || err == ERR_USE))
> +	if (err != ERR_OK) {
>  		log_err("tftp_init_client err: %d\n", err);
> +		return -1;
> +	}
>  
>  	ep = env_get("tftpblocksize");
>  	if (ep)
> @@ -275,13 +272,13 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	/* might return different errors, like routing problems */
>  	if (err != ERR_OK) {
>  		printf("tftp_get() error %d\n", err);
> -		net_lwip_remove_netif(netif);
> +		tftp_cleanup();
>  		return -1;
>  	}
>  
>  	sys_timeout(NO_RSP_TIMEOUT_MS, no_response, &ctx);
>  	while (!ctx.done) {
> -		net_lwip_rx(udev, netif);
> +		net_lwip_poll();
>  		if (ctrlc()) {
>  			printf("\nAbort\n");
>  			ctx.done = ABORTED;
> @@ -292,8 +289,6 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  
>  	tftp_cleanup();
>  
> -	net_lwip_remove_netif(netif);
> -
>  	if (ctx.done == SUCCESS) {
>  		if (env_set_hex("fileaddr", addr)) {
>  			log_err("fileaddr not updated\n");
> @@ -318,9 +313,8 @@ static void no_request(void *arg)
>  	ctx->done = FAILURE;
>  }
>  
> -static int tftpsrv_loop(struct udevice *udev, ulong addr)
> +static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
>  {
> -	struct netif *netif;
>  	struct tftp_ctx ctx;
>  	const char *ipaddr;
>  	int ret = -1;
> @@ -335,16 +329,12 @@ static int tftpsrv_loop(struct udevice *udev, ulong addr)
>  		return -1;
>  	}
>  
> -	netif = net_lwip_new_netif(udev);
> -	if (!netif)
> -		return -1;
> -
>  	memset(&ctx, 0, sizeof(ctx));
>  	ctx.done = NOT_DONE;
>  	ctx.daddr = addr;
>  	ctx.is_server = true;
>  
> -	printf("Using %s device\n", udev->name);
> +	printf("Using %s device\n", net->dev->name);
>  	printf("Listening for TFTP transfer on %s\n", ipaddr);
>  	printf("Load address: 0x%lx\n", ctx.daddr);
>  
> @@ -352,13 +342,13 @@ static int tftpsrv_loop(struct udevice *udev, ulong addr)
>  	err = tftp_init_server(&tftp_context);
>  	if (err != ERR_OK) {
>  		log_err("tftp_init_server err: %d\n", err);
> -		goto out_remove_netif;
> +		goto out;
>  	}
>  
>  	ctx.start_time = get_timer(0);
>  	sys_timeout(TFTPSRV_LISTEN_TIMEOUT_MS, no_request, &ctx);
>  	while (!ctx.done) {
> -		net_lwip_rx(udev, netif);
> +		net_lwip_poll();
>  		if (ctrlc()) {
>  			printf("\nAbort\n");
>  			ctx.done = ABORTED;
> @@ -373,22 +363,22 @@ static int tftpsrv_loop(struct udevice *udev, ulong addr)
>  	if (ctx.done == SUCCESS) {
>  		if (env_set_hex("fileaddr", addr)) {
>  			log_err("fileaddr not updated\n");
> -			goto out_remove_netif;
> +			goto out;
>  		}
>  		efi_set_bootdev("Net", "", ctx.fname, map_sysmem(addr, 0),
>  				ctx.size);
>  		ret = 0;
>  	}
>  
> -out_remove_netif:
> +out:
>  	tftpsrv_active_ctx = NULL;
> -	net_lwip_remove_netif(netif);
>  
>  	return ret;
>  }
>  
>  int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	struct net_lwip_ctx net = {};
>  	int ret = CMD_RET_SUCCESS;
>  	char *end;
>  	ulong laddr;
> @@ -421,25 +411,25 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		goto out;
>  	}
>  
> -	if (net_lwip_eth_start() < 0) {
> +	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV)) {
>  		ret = CMD_RET_FAILURE;
>  		goto out;
>  	}
>  
> -	if (tftpsrv_loop(eth_get_dev(), laddr) < 0)
> +	if (tftpsrv_loop(&net, laddr) < 0)
>  		ret = CMD_RET_FAILURE;
>  	else
>  		image_load_addr = laddr;
> -	net_lwip_eth_stop();
>  
>  out:
> +	net_lwip_stop(&net);
>  	return ret;
>  }
>  
>  int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +	struct net_lwip_ctx net = {};
>  	int ret = CMD_RET_SUCCESS;
> -	bool started = false;
>  	char *arg = NULL;
>  	char *words[3] = { };
>  	char *fname = NULL;
> @@ -540,19 +530,17 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  		goto out;
>  	}
>  
> -	if (net_lwip_eth_start() < 0) {
> +	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV)) {
>  		ret = CMD_RET_FAILURE;
>  		goto out;
>  	}
> -	started = true;
>  
> -	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
> +	if (tftp_loop(&net, laddr, fname, srvip, port) < 0)
>  		ret = CMD_RET_FAILURE;
>  	else
>  		image_load_addr = laddr;
>  out:
> -	if (started)
> -		net_lwip_eth_stop();
> +	net_lwip_stop(&net);
>  	if (arg != net_boot_file_name)
>  		free(arg);
>  	return ret;
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index e8930da410b..c9af3c7420f 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -39,6 +39,7 @@ struct wget_ctx {
>  	ulong content_len;
>  	ulong hash_count;
>  	enum done_state done;
> +	bool aborted;
>  };
>  
>  static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
> @@ -229,6 +230,10 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  		ctx->done = FAILURE;
>  		return;
>  	}
> +	if (httpc_result == HTTPC_RESULT_LOCAL_ABORT && ctx->aborted) {
> +		ctx->done = FAILURE;
> +		return;
> +	}
>  
>  	if (httpc_result != HTTPC_RESULT_OK) {
>  		log_err("\nHTTP client error %d\n", httpc_result);
> @@ -293,13 +298,15 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>  #endif
>  
>  static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
> -			       struct udevice *udev, struct netif *netif)
> +			       struct net_lwip_ctx *net)
>  {
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> +	struct altcp_tls_config *tls_config = NULL;
>  	altcp_allocator_t tls_allocator;
>  #endif
>  	httpc_connection_t conn;
>  	httpc_state_t *state;
> +	err_t err;
>  	int ret;
>  
>  	/* if URL with hostname init dns */
> @@ -348,11 +355,11 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  			printf("HTTPS connections not authenticated\n");
>  		}
>  		tls_allocator.alloc = &altcp_tls_alloc;
> -		tls_allocator.arg =
> -			altcp_tls_create_config_client(ca, ca_sz,
> -						       ctx->server_name);
> +		tls_config = altcp_tls_create_config_client(ca, ca_sz,
> +							    ctx->server_name);
> +		tls_allocator.arg = tls_config;
>  
> -		if (!tls_allocator.arg) {
> +		if (!tls_config) {
>  			log_err("error: Cannot create a TLS connection\n");
>  			return -ENODEV;
>  		}
> @@ -363,33 +370,44 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  
>  	conn.result_fn = httpc_result_cb;
>  	conn.headers_done_fn = httpc_headers_done_cb;
> -	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
> -			       httpc_recv_cb, ctx, &state)) {
> -		return -ENODEV;
> +	err = httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
> +				 httpc_recv_cb, ctx, &state);
> +	if (err) {
> +		ret = -ENODEV;
> +		goto out;
>  	}
>  
>  	errno = 0;
>  
>  	while (!ctx->done) {
> -		net_lwip_rx(udev, netif);
> -		if (ctrlc())
> +		net_lwip_poll();
> +		if (!ctx->done && ctrlc()) {
> +			ctx->aborted = true;
> +			httpc_abort(state);
>  			break;
> +		}
>  	}
>  
> -	if (ctx->done == SUCCESS)
> -		return 0;
> -
> -	if (errno == EPERM && !wget_info->silent)
> -		printf("Certificate verification failed\n");
> +	if (ctx->done == SUCCESS) {
> +		ret = 0;
> +	} else {
> +		if (errno == EPERM && !wget_info->silent)
> +			printf("Certificate verification failed\n");
> +		ret = -errno ?: -EIO;
> +	}
>  
> -	return -errno ?: -EIO;
> +out:
> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
> +	if (tls_config)
> +		altcp_tls_free_config(tls_config);
> +#endif
> +	return ret;
>  }
>  
>  int wget_do_request(ulong dst_addr, char *uri)
>  {
> -	struct udevice *udev;
> +	struct net_lwip_ctx net = {};
>  	struct wget_ctx ctx;
> -	struct netif *netif;
>  	bool is_https;
>  	int ret;
>  
> @@ -401,30 +419,22 @@ int wget_do_request(ulong dst_addr, char *uri)
>  	ctx.start_time = 0;
>  	ctx.content_len = 0;
>  	ctx.hash_count = 0;
> +	ctx.aborted = false;
>  
>  	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
>  	if (ret)
>  		return ret;
>  
> -	ret = net_lwip_eth_start();
> +	ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV);
>  	if (ret)
>  		return ret;
>  
>  	if (!wget_info)
>  		wget_info = &default_wget_info;
>  
> -	udev = eth_get_dev();
> -
> -	netif = net_lwip_new_netif(udev);
> -	if (!netif) {
> -		net_lwip_eth_stop();
> -		return -ENODEV;
> -	}
> -
> -	ret = wget_handle_request(&ctx, is_https, udev, netif);
> +	ret = wget_handle_request(&ctx, is_https, &net);
>  
> -	net_lwip_remove_netif(netif);
> -	net_lwip_eth_stop();
> +	net_lwip_stop(&net);
>  
>  	return ret;
>  }
> 

