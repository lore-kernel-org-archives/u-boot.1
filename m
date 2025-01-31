Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746CFC0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 06:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC469805E2;
	Fri, 31 Jan 2025 07:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Oe6jyzVR";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pju9RI15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617AC805E2; Fri, 31 Jan 2025 07:50:47 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD7680F42
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 07:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ad7cba32df9f11efbd192953cf12861f-20250131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:To:From;
 bh=qEeOPnvaN8DE++3xW9fhPlJ+ZbWOeuwzJj94tHtK43g=; 
 b=Oe6jyzVRDNHPIPiazjIYF3QToe5aDN/279ac3xVofrLioYaOhp7NpZXiSDTxPAdYeMUrBXZmyrpzQ/IfrMhtZVIOtT2CKooVfvJzDkOjpuov6O689bq1ssaXXFMNcZLjlE+gkYY/OVVd/OIzi6E273657vzua1QJ/9olNrhgrdo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:bea3ef77-f561-476e-ab53-91af633b0534, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:931be17e-427a-4311-9df4-bfaeeacd8532,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ad7cba32df9f11efbd192953cf12861f-20250131
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 381665172; Fri, 31 Jan 2025 14:50:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 Jan 2025 14:50:36 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 31 Jan 2025 14:50:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIEZW024WmzFSSDC3KIDCo0J2bl2CCCg67pOvIvNaNNeNLMe5jwSRQj65Vci8tkUF0m00Qe6JsAGFeW6VNy458tF9KPtblxNltGP7gpmVF4FLQiQxh4hjQekRNZHxIxUn+yK5/5toe9QT1s2bSmPDBl3mNr3hA5cgxVCGAj3wAlfAMmUY5Z03NyDBRhMHjGCnZ3EYScFjSYY47508QM4uyJxFWS/iQvki1E1+u1iZL0AyVO9vKPjy/3hYzRhiQRJrO8wPxKxNlSaMKkQTo658B645tUpWUalYM+MHl1r8Jnt0xkHZT5y+MhxZSY3vyRXf5dwNepOT58HtcIvct5jXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMZHrxbm9R+IkmOC0/ekrWpb+JUNyXfgZ9H1wEGaMZ4=;
 b=v1/m17AX+pxWrNoOn1gLlhWrdaW4I0pXntjVZiYJiWbn1Ttb/t7sWZlMeln6MnZtNPTYBOAfff4bxW0TF6HTX2QORC6ITXqRIS30IJKEbeoRbFMT8QhL+hifC63xFnkDa46ukXEzytufqqSqbfaa7bOi0rmkQA9mBP7PuctlgtmvlcnzqSAHC4yGFxvXeuCt/2n5ZXA1cU3ejcxmaY02jtWKVsPMbCdBFgC174HYiIOGKy14jon+96fwfoTl8MiSUINol88sC2y+7xAgJgu9p9hC1ysV+CktnseEpVSYwnxSp+jU70c24GBcCRZ/D7xSZRSpaaWpPw6QPSGFLo2jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMZHrxbm9R+IkmOC0/ekrWpb+JUNyXfgZ9H1wEGaMZ4=;
 b=pju9RI15Y0YfvAeHLBZqGH1idl4LVzyssk0MOrFUib3V1fUVYXgkoxPArVpK8BvDB7qVD8Pq+zt44awwCpKDk2GtRuwlrWsKeTLYI0u/8Rfs/R8CW2v1HO9x40qlt9HgiM0T5uH51Qv4Nbyrez1GmoEvr5I6SiM53d7qQldZq4Q=
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com (2603:1096:4:23d::10)
 by KL1PR03MB8774.apcprd03.prod.outlook.com (2603:1096:820:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 06:50:34 +0000
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183]) by SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183%5]) with mapi id 15.20.8398.014; Fri, 31 Jan 2025
 06:50:33 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "john@phrozen.org" <john@phrozen.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, =?utf-8?B?RG9uZyBIdWFuZyAo6buE5qCLKQ==?=
 <Dong.Huang@mediatek.com>, "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 5/8] mediatek: mt7988: move gpio-controller up and rename
 pinctrl to pio
Thread-Topic: [PATCH 5/8] mediatek: mt7988: move gpio-controller up and rename
 pinctrl to pio
Thread-Index: AQHbcMEwVOAJL0w2n0+k8hI1DLOLI7Mwd1SA
Date: Fri, 31 Jan 2025 06:50:33 +0000
Message-ID: <65b3b7f3aae203433dc784fbe596f38ea2ddacc2.camel@mediatek.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
 <20250127134046.26345-6-ansuelsmth@gmail.com>
In-Reply-To: <20250127134046.26345-6-ansuelsmth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR03MB9045:EE_|KL1PR03MB8774:EE_
x-ms-office365-filtering-correlation-id: 6ee9cf3b-7473-4016-bd2a-08dd41c38f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?UGJ0cmlEUG8wN1ZreDB4NWZLeTZETzNCN3dyVVMxY1lyUFI0L1JvS3d2NWcv?=
 =?utf-8?B?bTkrbVE1ekU0ZDZXWjlOQ1lSM2NyN2MyMHQ0U2VXb1R2dzJva2NXZGVZRUk0?=
 =?utf-8?B?dXp0a2xUazI4bnVRVWJLNmpmUUVXWDRqRnRpQmJQV0tBQXpZdWx6R0FKMnN3?=
 =?utf-8?B?T1ZxNE8zbk8xbFFTWEl4dlk4TXlURmlWbmdUUGY4MjgySzk3MTdhMGY4MjFY?=
 =?utf-8?B?UDMwVjBwbTRMWmpLZ0JyRnRXMnJpaVh2WXpNenEzR1VsM0l2anVDSVcySm1m?=
 =?utf-8?B?QlpXejI0TUdhMFdVaUpHNDlhMStPeGhwbkVJTXgxWENyZkxPb1pqeVRiUTRV?=
 =?utf-8?B?VGNXbmVUSy8xZGJUelJsRGplUlZRUkZxcXdVdWFNRDk4QmJORkVieHJNNWVS?=
 =?utf-8?B?cWR4cjZqczNqSTJYUmtuUGRtNjVLUDZrNHc3TE53SnJEY3BGYnVzVTYyenNW?=
 =?utf-8?B?S05xcG1MMTVaQnc0c1huME1mODROLys0VW9nTVBxZTJSTDVlVk9KSXJ2NllG?=
 =?utf-8?B?Y2xucDZOQXMwdXpYbmxmZVYya20yRXpsR21NTlFRU2ZSekpXZDcrOXE0Ymhx?=
 =?utf-8?B?ak9scTY4R21NN2YwQWx3VmpsRmNUUUNWdkpVRkUvWGJYS0JpcWRsUmhZOWQw?=
 =?utf-8?B?WVJSb3J0VHRIZThOelJQa0VRN0IySlhWUzg1SE5ZVEwxZVZybVNKcXpudUwz?=
 =?utf-8?B?d3lsY1ZFY0FWZlcrRC9EMEpsVy9yd3BJYnp5RnAxcldvQ0h4WjBJN05pS2gx?=
 =?utf-8?B?VUorUGhQNExPRFJ0Yi9IN0JHRFNYOGltK3Q1KytoYXdBSnI1TTc3S01vc1RI?=
 =?utf-8?B?elZ3YUF2b1JVTUwxNHR3c2ZIbEd0cFJIT3d0MVJFdGNuenZvSSt1KzBMR3BE?=
 =?utf-8?B?NFdSRkhHalNjU3N2SUZyRTE1ZytqKytDd2Y3cXJ4dUlNUWZuYlJOdzlseUY4?=
 =?utf-8?B?SlcrbU94bXlTT1JMMk9BT0hPTUsvQlN1L0ViRlNGUGhrR3B4MjFSYVVtSGF0?=
 =?utf-8?B?dmV5UW1taThDTTVLaEhseERLL05WcUdIMy9EdGNrbk1ZZ1hqN2pPY3MzVlRX?=
 =?utf-8?B?YVBKMU9Fa0Q2QXBwd3lIT3dFTHRvQ2MzRVMxWmY0ZW5hTEdFN3FzNDY3SVds?=
 =?utf-8?B?OGg1MWxJd0JWYWx6QUU2Z2ZnRHF2ZjdiZGJWLzB6bTZaUWVHUVhQMmpWdFpY?=
 =?utf-8?B?SXU2QmRtL2YzcEFxUTBKVTBsalBoU1YxUkltUHdxdEpSYXZiQk8vZXNLTUxv?=
 =?utf-8?B?NEVWbzlUZ0YySGFpS0RSRGFGVTBNVHJFbGYydHQxU1I3dTdrdWdSVnlzdzRo?=
 =?utf-8?B?K2NKR010dXV0SStKZVE1NGhlaW1NYXRNTU1ORnpJWVJ0R2NoS3lxNXF1QXZC?=
 =?utf-8?B?eE5hL1pmWWhKOWNCQjI0a0lvdFoyYWN6SmtOZThXSlJ3VmZRWEpQc2dDa0Zo?=
 =?utf-8?B?WmJRM2l3ZHg0VnhQdSs5cUxwYXNjWDRnWHhXa3pFdjE5S2ZSdkE5ZkgvL2E1?=
 =?utf-8?B?dDJ6dXRwekNsSm1zb2hLUDZldDZCN3l6dUtQK1pVNWgyU1B6WC9RWlZXQUhO?=
 =?utf-8?B?cVJLamt2enYwN1FjQ21VSjdhNWVqVkx0eVcwNFJpK2ozNXFEbUJKbnQzSmZD?=
 =?utf-8?B?L0llRFBrUXVrT2Rzakc4SEVRRDJrT2lJTURpQlZwWlZMSlN4Wk1GMVdRbjZj?=
 =?utf-8?B?ZUt5bUljT2E3cnRVcFI0THZ3ZzFLNkpSc1pQQjVlVWgyS21pZzlLc0R2ZS9N?=
 =?utf-8?B?OTViQjBHbGhIOW5ocGZUVFY1VDFnc01TVHFrams1UDRpbEI1eEs2bXNSa21E?=
 =?utf-8?B?ZnRCMnNGZU4rSU9UUnJOL2pzeHR1bDlEYWdvWHRSSlFhcEk4L255b3FaVjZP?=
 =?utf-8?B?QWpYczJwY0NRTXI5MmlkbVd5Z0dRakJ3SXdycVlRQ2pLN3FVNG1xYlhJVEJP?=
 =?utf-8?B?RFhKaWpuNVVCaUo1QUllcmF3UG9GZ0pKR1Zzd1c2OFlhbWtFQUhYNFc2QUVE?=
 =?utf-8?B?L3hybERwVjBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR03MB9045.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVpTUmdoZjRqZmk1VGpZSGsxVll4T2t4SGxZNVNFaHIyQ3AyYUNWbzc2N0J5?=
 =?utf-8?B?ZHJEWEoxMjRXakpoQzR6eC9PTUpTT2Nia0RYYmJtY2JCMG5JTHdLRnBjMmxI?=
 =?utf-8?B?TWN0WTRqd1psOVc2Y0lsT3UzVHhLUTFGRWFkbjlCVmxUdVpWY0pHdHFsSUgr?=
 =?utf-8?B?d1hhSjZtN1MrYUpCeERyVnRuN0JpN2JmZGVueEJqS3hYU3J6ZUJXQW1iRDcw?=
 =?utf-8?B?UFExQjZVYXR3UlNTdUJsMGNiakdobzZVOEtNbkRrd3NMcGpKQU5rU08reXhF?=
 =?utf-8?B?ZHVxVjlkRG5lY2t5OXlDbis4S3VzTjhLT1BnazhWN3RJMUl1a0g3Q1dPQlBP?=
 =?utf-8?B?ZjZqSUc1ZlE2dE5zOHcxdDQzdHJ3YW5GN3YvUmNOZlJoRDRWdXhSZzZUdy9h?=
 =?utf-8?B?R3c4K24yOHNDWmVjY1VjVGZ5N0NyLzU1ZUlGZnBNQTdjd2F0RWJmUVpHd3By?=
 =?utf-8?B?V3g2SVJVTVZtaVBhNkxnNThoVVQ0dDZhV250WE9hbnN0QzRGQUx1N2xVY0JP?=
 =?utf-8?B?Rk8za1greDAwR1EwQkg3REJCbWNaUTZlTHhKSEEvNVNPaUtVR3BXa1dwRjZP?=
 =?utf-8?B?bllHMEdDb1d4VFoxMncyVndyMEtiT2JFelllc1EzVTVoRWFyTDM0OHNteTgr?=
 =?utf-8?B?cDhFdktsTnNvNGR1SGY2Z1NNeG5ML2NVUHBBbWsvd2JUMUJlTnpZRFZkditD?=
 =?utf-8?B?YmU0K3k0b0JJTEl1M3R6NFAzNmpJc1l3WG00OFEwM0xwVzNQdit6Qkx0LzEr?=
 =?utf-8?B?WVZKeURzL21HcVIrWGtsVzlCVWRoSXlESExkMklLczNiU3BIRk0rUU9LMUwx?=
 =?utf-8?B?dEcyQXE4dmwyNVBEalBkUWg5b2pYQnVDODhld1NreE5CUko3dEJ4aTRScWZ4?=
 =?utf-8?B?OStBQnV2Q2FDd0FrS09CVWd6cy93OElhQWxPUnFhTVh6Wi9aMDU3UzZyRDBQ?=
 =?utf-8?B?N0kzblZYOFI4Qmd5Z1Q3NE9xdTlGMFQrKzhyWHNZTkYrbk5QL1B3Wnd2clBG?=
 =?utf-8?B?ZUVla2lTS3VYUUNqUUM5cjYrb3VPRWVrc1J0NGpFcWxzUFZoS3VmaE1nSGI0?=
 =?utf-8?B?UkVZSzVEaHdXN3VtN0pLeEJNblY0WjJBTlRSUnQ5MDlQSDRWWERKbCt6RXVw?=
 =?utf-8?B?SkNNS2xLa3ZIckdOTC9SUnhCY0IrUUFRM2o1U0M2NlZRSlNubFlBVzdJNEdy?=
 =?utf-8?B?ZGxlVnBuaG4yRjNOalBYMThFeXBoRG5Tbno1ZlRaNjc2UkJTRzhVUTJrWWpQ?=
 =?utf-8?B?Wm53Njk3Q0ZoTWM1THVxWFE0eGNkU2pEYUJMcXRtejRjMUhHQ3BRYlNpOXl1?=
 =?utf-8?B?cjFlUVlGVGlDMm90TVd1RWJyYmpzSFh2MWNJZGV2TGNXcVlCMktIcVVnZFJl?=
 =?utf-8?B?anAzL2crVG02Skh2QzVoTzVkSDdndlFFQmw4dkFVeGN2K254YklVeU16SjBz?=
 =?utf-8?B?Q0ljNUxxUFlLNThHTmEzdnBBSnNQQW9sNWNGT2EvY3V6bndtckxzcm5vcjR3?=
 =?utf-8?B?RUlaQXZUOHkxWm8wdGgrY3JkcStZclJLZVQwcThxVlVTUXRiYXVMT283bW5p?=
 =?utf-8?B?Y2gycmNGbktpNm5HUHlsVkhHb1FxekRXRWg0SFhCVzZadzBzNENjQ0hJT0s2?=
 =?utf-8?B?U0I0Vk5QM3RWY1NKZGlKaW5iVXM4UExTdjhENisyQWxud2wrdERqL3RlOTVT?=
 =?utf-8?B?V0RXbUVJRlNCbHNqMDZweUtIT1lza09uK1JsZTVmYUdnY1pKWjhKVHFmZkJJ?=
 =?utf-8?B?WloyaHFMUjhiR2w2Wk42aDZKaThGaG1GelZveURDalRTUzZ4Uk9zWWNJME5s?=
 =?utf-8?B?MXEzSkUrZmtiZ3A1WEZMQzVEMmM5cUptZnJqOHhIdVgrU29seG1iblA5U040?=
 =?utf-8?B?V0ZFU1JmcHMwdGRzaFFLZzJUbkJINjJRZ0hiVWRoNkZtSjFzRU01R2pQekdV?=
 =?utf-8?B?WDY0Rk1XVXRaeWtDU2xPaUhUYkw2TU8yb2ljQkNzK1IxUWRBVlhaL0Q2dG1X?=
 =?utf-8?B?Q1kwd2N2Sk1PT0FqRGRzZlQraC9YY2M3akNXeUd4eSs2b2FSN0lINmpUeEF6?=
 =?utf-8?B?TVpvTlpuS2ovQlI3WVoxUzFnVFAzSHRwMUw2T255YkRqUVBnM1BKMzNzOU10?=
 =?utf-8?B?ekVYdklrbE1TL2lFVXJERDQyNkczWnJNWG9RdjdNdWRsM2w0T0RFUXhSblU4?=
 =?utf-8?B?aVE9PQ==?=
Content-ID: <81C2BEB66CAFAC438805327BC4CB28C5@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB9045.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee9cf3b-7473-4016-bd2a-08dd41c38f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 06:50:33.4798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqnoxBZN3SNRY15CSWNt1/sxQy4bpS1VNOnIR6PxU/1hHH8DTM+Sd8Q8er7B2CqIskxxYe9Q/BU0hB7XNLO0iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8774
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gTW9uLCAyMDI1LTAxLTI3IGF0IDE0OjQwICswMTAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBNb3ZlIGdwaW8tY29udHJvbGxlciB1cCB0byBwaW5jdHJsIG5v
ZGUgYW5kIHJlbmFtZSBsYWJlbCB0byAicGlvIiB0bw0KPiBtYXRjaCB0aGUgbGFiZWwgdXNlZCBp
biB1cHN0cmVhbSBrZXJuZWwgbGludXguDQo+IA0KPiBVcGRhdGUgYW55IERUUyB0aGF0IHJlZmVy
ZW5jZSB0aGUgcGluY3RybCB0byBmb2xsb3cgdGhlIG5ldyBuYW1pbmcNCj4gYW5kDQo+IHN0cnVj
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBNYXJhbmdpIDxhbnN1ZWxzbXRo
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9kdHMvbXQ3OTg4LXJmYi5kdHMgICAgfCAy
ICstDQo+ICBhcmNoL2FybS9kdHMvbXQ3OTg4LXNkLXJmYi5kdHMgfCAyICstDQo+ICBhcmNoL2Fy
bS9kdHMvbXQ3OTg4LmR0c2kgICAgICAgfCA4ICsrKy0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9kdHMvbXQ3OTg4LXJmYi5kdHMgYi9hcmNoL2FybS9kdHMvbXQ3OTg4LQ0KPiByZmIuZHRz
DQo+IGluZGV4IDI1NzlkNzA5OWZiLi4xNjk0ZWY4ZDljMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vZHRzL210Nzk4OC1yZmIuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9tdDc5ODgtcmZiLmR0
cw0KPiBAQCAtODAsNyArODAsNyBAQA0KPiAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICB9Ow0KPiANCj4gLSZwaW5jdHJsIHsNCj4gKyZwaW8gew0KPiAgICAgICAgIGkyYzFfcGluczog
aTJjMS1waW5zIHsNCj4gICAgICAgICAgICAgICAgIG11eCB7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGZ1bmN0aW9uID0gImkyYyI7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvbXQ3
OTg4LXNkLXJmYi5kdHMgYi9hcmNoL2FybS9kdHMvbXQ3OTg4LXNkLQ0KPiByZmIuZHRzDQo+IGlu
ZGV4IDM4NzI3YTI3MWIyLi42M2U5MjMxMzdjMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vZHRz
L210Nzk4OC1zZC1yZmIuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9tdDc5ODgtc2QtcmZiLmR0
cw0KPiBAQCAtNTMsNyArNTMsNyBAQA0KPiAgICAgICAgIH07DQo+ICB9Ow0KPiANCj4gLSZwaW5j
dHJsIHsNCj4gKyZwaW8gew0KPiAgICAgICAgIGkyYzFfcGluczogaTJjMS1waW5zIHsNCj4gICAg
ICAgICAgICAgICAgIG11eCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uID0g
ImkyYyI7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvbXQ3OTg4LmR0c2kgYi9hcmNoL2Fy
bS9kdHMvbXQ3OTg4LmR0c2kNCj4gaW5kZXggZWUyYWQyZGJlNmUuLjJkNTdjNmY1NzA5IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvbXQ3OTg4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vZHRz
L210Nzk4OC5kdHNpDQo+IEBAIC0xMTAsNyArMTEwLDcgQEANCj4gICAgICAgICAgICAgICAgICNj
bG9jay1jZWxscyA9IDwxPjsNCj4gICAgICAgICB9Ow0KPiANCj4gLSAgICAgICBwaW5jdHJsOiBw
aW5jdHJsQDEwMDFmMDAwIHsNCj4gKyAgICAgICBwaW86IHBpbmN0cmxAMTAwMWYwMDAgew0KPiAg
ICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc5ODgtcGluY3RybCI7DQo+
ICAgICAgICAgICAgICAgICByZWcgPSA8MCAweDEwMDFmMDAwIDAgMHgxMDAwPiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgIDwwIDB4MTFjMTAwMDAgMCAweDEwMDA+LA0KPiBAQCAtMTIyLDEwICsx
MjIsOCBAQA0KPiAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gImdwaW8iLCAiaW9jZmdfdHIi
LCAiaW9jZmdfYnIiLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImlvY2ZnX3JiIiwg
ImlvY2ZnX2xiIiwgImlvY2ZnX3RsIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICJl
aW50IjsNCj4gLSAgICAgICAgICAgICAgIGdwaW86IGdwaW8tY29udHJvbGxlciB7DQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgI2dwaW8tY2VsbHMgPSA8Mj47DQo+IC0gICAgICAgICAgICAgICB9Ow0KPiArICAgICAg
ICAgICAgICAgZ3Bpby1jb250cm9sbGVyOw0KPiArICAgICAgICAgICAgICAgI2dwaW8tY2VsbHMg
PSA8Mj47DQo+ICAgICAgICAgfTsNCj4gDQo+ICAgICAgICAgc2dtaWlzeXMwOiBzeXNjb25AMTAw
NjAwMDAgew0KPiAtLQ0KPiAyLjQ3LjENCj4gDQoNClRoYW5rcyENCg0KUmV2aWV3ZWQtYnk6IFdl
aWppZSBHYW8gPHdlaWppZS5nYW9AbWVkaWF0ZWsuY29tPg0KVGVzdGVkLWJ5OiBXZWlqaWUgR2Fv
IDx3ZWlqaWUuZ2FvQG1lZGlhdGVrLmNvbT4NCg==
