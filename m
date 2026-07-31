Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD18AC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 03:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F63B40EF4;
	Fri, 31 Jul 2026 03:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_TzwyObqsUN; Fri, 31 Jul 2026 03:44:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AA0540EE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785469442;
	bh=UJEtdMZLkpA3r9I9tjrRWfGemfxod4Ecm80SrX7FQxo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kFrUG0zTkXGDbDvXUm63raYv6+q7ZMKE2i9Rv/fIYI0ej8O8jRh5wjw4sGTgvMSpz
	 pfKkisXtlE3VqUW7eEsav9G819GKQg21jqE/TbH+fnNgJYTQ+raRyIsHi9CuPALSzV
	 TOcMv8/N3XZ/gWc7NoP4Wdw5AvIxzdbdRaiLrrckHop9vkoZttWM0NMMT2x09OE7Xk
	 0QZn4VqyApmQbXKOSYorP1/gZTQut0aP5il+ngEEOAsvL1ZhjGJNYwuCs/HEJMjPiZ
	 v+xqkn5rvAMtcM5y/v++bM7fM7RMCD9WKyhZKcfHWNCCWxD9ulPt4lXmZ7UrtXTUue
	 c7SPJxH9K6Aig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AA0540EE5;
	Fri, 31 Jul 2026 03:44:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 752E626C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66DB180EE3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:44:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJCkjqMmvFDF for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 03:44:00 +0000 (UTC)
X-Greylist: delayed 902 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 31 Jul 2026 03:43:57 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ABCCF80EE1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABCCF80EE1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=macpaul.lin@mediatek.com;
 receiver=<UNKNOWN> 
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABCCF80EE1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:43:57 +0000 (UTC)
X-UUID: f126c55e8c8f11f18dc8c9802ae25ab1-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:0d7a3d85-8514-4389-8b8d-7a53e3d41e76, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:c760371e-e887-4fb4-80f2-e39fcd01b387,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f126c55e8c8f11f18dc8c9802ae25ab1-20260731
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1833421673; Fri, 31 Jul 2026 11:28:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 11:28:46 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 11:28:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/jWfnjtE+5zlaL/b1kLUGGDNbS1nR7578fFU+wlbVy0sg44/AJZNYozqjuohyJdkNfPFkmvFf9gkdPy+xwG/1eZCcjyzRVUFuUf7tqHkRF6Hmv59pmQo5dqH6AlWpVzwj1e23Jz89IwD9MQdiu4nsmnCZvTFPGYCictb7Ubtp9y1y1INRg+vZqaQJkgqHsCuKMuKqIdzbUPSmTGGH6mC8A007kc4IOx6pUk5SE+BbRAeSJHxHGpWT5TtH6yfL2Q0sv/6T3iX2Yw+ua0RjAds1IjXVTZPgfd6cN8y68eKioqRTOFpnxIKYKAB5yGpaFJHYH29448a1rjjkn7N8fqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJEtdMZLkpA3r9I9tjrRWfGemfxod4Ecm80SrX7FQxo=;
 b=uLIbnGhWgF7o7RDWk5N0HpcB87kXYpBuRis5K8e5KdTlf1AN0WNKRDCDsPqtuM2klfJ+lluCrA4Am4A0hnlZc+DI3VbV2ENhRKxBRSjeqVOo/p9LTa7/+rJJFeumohxE3jKoqAWrD6GJDXP7kRAapyYMA9lU8bm/Sx39wS7y258O0rJYuKbI7EGa5ijbfBewxX8XxG92+n42EKsp4k9YngbwZXR92EkvDxmgkEzOLXJ0yk/4xAd5iQQ+Sn1uPUJScwxgqjRKxkpZa4FcOQ03c4gDWf2ITNMGvZaaLTcEAoSWdmNluAZ06ecHscOvhkUdiLsToULF/LUQtLRHHKq3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB7722.apcprd03.prod.outlook.com (2603:1096:400:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Fri, 31 Jul
 2026 03:28:40 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 03:28:39 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>,
 =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?= <TommyYL.Chen@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>
CC: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Julien Masson
 <jmasson@baylibre.com>, "ravi@prevas.dk" <ravi@prevas.dk>, "lukma@denx.de"
 <lukma@denx.de>, "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, Carlo Caione <ccaione@baylibre.com>,
 David Lechner <dlechner@baylibre.com>, "ag.dev.uboot@gmail.com"
 <ag.dev.uboot@gmail.com>, "jbx6244@gmail.com" <jbx6244@gmail.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "patrice.chotard@foss.st.com"
 <patrice.chotard@foss.st.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>, Ryder
 Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 01/13] video: mediatek: add display pipeline component
 helpers
Thread-Topic: [PATCH 01/13] video: mediatek: add display pipeline component
 helpers
Thread-Index: AQHdHoziDf7b+rvqgkKIPY2exwV+abaG/D6A
Date: Fri, 31 Jul 2026 03:28:39 +0000
Message-ID: <d798d75248f3c6be92231d7cd45cc2af4b556469.camel@mediatek.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
 <20260728-add-genio-510-and-genio-700-hdmi-v1-1-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-1-ac54bd75f960@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB7722:EE_
x-ms-office365-filtering-correlation-id: 41adfece-709e-4112-c63a-08deeeb3d067
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: aK1OviNhYOa9ga3B8gHVmFzH0Dadz4alw5mKgAeskfoGGM6eJOlxDG+2zeTsw/OE8Cjpdqgjn0JoA0DboVBbpuqZo9W8a+DcNqpsuyY8GUyWo5olmQPJmuqXsFjdXHjNIOl659AlHUNjk/fNx/tTwP6OXMVxLl8yVu0LDSr8FT/pEv5nXRdFCnCkO1eIZ3Yg8QDfIF8cZ8uk/BsURSwMxCQvYfUA1TqI5bajow8lgVCT0xS4uERQMaXK7VAJa/2GJ5RsFOZOQ7WvIaP2Jsg5S3VCQJ5mMK3v27MYuSy7+5p5ru1fdb8m+6m8YNXX1dAFs3wAAIZBZk81s/Pme4AIyCjvnD3s2sVBd7ekzBolMAULW3zmotVuHSlCbvG3fcMJlln+WnsULcYLn+jxxEw90f3dF6ksaBGPVnyfcMbUZAWgJhDSilAHy2duJ3TlU0EK7GcGqUKsrIkTsZvCQObzVEpO9LbJuCmn8x4nO8HvD58kcg3HHgZ/2rKwK5dDzzQip0A1P/4vP9TxYYNJRoHrPyOmvsSJGY3rXW/ylD6hbb9+lMN6yYMBDN2n/pqVESXWxH2/RVH7aC0FdwjL/RYjZ9t0O3YBL47ghfevWHj4ooT+DJKHlomADGEqDTFIZnvEhYGKVyvJHDuXaVeCkqlIva9BaNP06K3Prs5eizmso3RqeUcygH+ciHb71IAlH4Ez61SSKaJInCNRkU9g7KXWUAoRgadJFa9SaJh01tTRZTw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2FvK055U0J0WGxQdk1FclJtdTRYZHFnNVY0UURzamd3S3M4R2pnbld2Nk9M?=
 =?utf-8?B?L2xaSlE4TVdPb2pYMVkzaU84L2RkVFA2V1Q0c1NVSEVGUGtod0QyU042bENn?=
 =?utf-8?B?cy9kdG96R3JiQWp0akJKWForZk9NKzNUVGUxZ3JwZWRxVzIrdllQY3hIekE2?=
 =?utf-8?B?Mm9Rd2hHS2U5SUdnT0ViRGk2VUdVdUtWN0RLU3Y0TC9hS3F1a0NVV0taeTJT?=
 =?utf-8?B?RlFEV29iQTlTV2Fnc2ZRVEliREFScndVbTMvRHhVenpOa09Mb0NsQ3hLUDlJ?=
 =?utf-8?B?U0NtZzA3WlZxZEIyeHBtYm5tTE00TXI3cjUxQmpzUml6QUFlZHhhdWJhUVBa?=
 =?utf-8?B?akFSS3Z4anc0bHRmTVd1aUhOSG5pV29Ca3JlMFpXSEV0bGNjaHQzT1gxWFcz?=
 =?utf-8?B?bkg5ekVRbElMTllaYTJ6Z0gxMkJEQWFQN2VGcW1lTWR3bC9pRklIZzBLYmhh?=
 =?utf-8?B?Y2FUSVhWVjJUOTBsOVhORk94QTc2V0NieUw1SXNxOUNBaklHanZsdGlIemNI?=
 =?utf-8?B?eHNZN1ZjcWRobkdabDI1MmNaeEorRmdRbWJqWkxDM2xLZVdPZXUwcUZSRkMv?=
 =?utf-8?B?THY1ak8vK25SbzQya3hxc3Y1Sis2TE5kM2V1b0pWcjFGVjhUcDVEZ1RZR0Nn?=
 =?utf-8?B?K3BQWDRiekNrL2d4WkJmN2ExSERtdWNWeVZpdkY4Vy9WSzhpS0Nuc3hyL0xX?=
 =?utf-8?B?UlJWYW4vbk92bHYvMWtrL2UwNkg1bEkvdHl5MDJxMWZLSm9mNGZjaTNGeGJE?=
 =?utf-8?B?ZEJrTmUzZUZnME5KWnJpUS9UV3RTRmN3Z1g1Si9Bdmh0aENpMG44QXN3c1Jo?=
 =?utf-8?B?WWkzc2gzMXNGeW5ONWNZZkhRQXdpQXJHNEt3RHJLUVVRRXV1cjBTa2h6VDlu?=
 =?utf-8?B?clRlL1lrd0l5NWZQMThFZHllYWNpaXl0WWMyWmVxVHBUWWlGRmRiQXBtVEdV?=
 =?utf-8?B?NkhDQWhWTC94VU1IMnRXR0RRVDhxVkJ5RExaa1VxQ1I5aTJna1B5Z3VIRWZ3?=
 =?utf-8?B?TzNHSFh0blZjVnZkMnhxclkxWVN6OWtzOWFRNzFwQnBVZ1ZJQ3h5b1hKQXhX?=
 =?utf-8?B?Q1hMdUZlWHVMZVZDTnhPOXViUTNHaVdPQUdkOFkrdFhUdEFRTVVlcXlQR0Fj?=
 =?utf-8?B?UXZJZjBldVBvMHl2WDh5OHpabkd3RHBKQ1NaYzZpbU1pRXcvdlZ0Y0x0amw4?=
 =?utf-8?B?bnFmeTdLYkNwQUI1MG5kRWYyZkJNYktqWVlLR2syVlE0aXlSbTFoWTJTaUNY?=
 =?utf-8?B?Z2xwTG5BWTVDUmRyVmp2SnZWODQ2TWk4RGlMZXFBa0dlczB2Z3pHelBGS0ZM?=
 =?utf-8?B?VzcwRHJlcmdKbSt1OW1JSU10VzByTG9LOFJCVmdSTXk3dno5bTJXMy8yaEhD?=
 =?utf-8?B?eUM4OWpRc1lDVmRVbm53dmc4N0d1eEh4U2NCNTRpelI0QnFzcXJSZm1sK282?=
 =?utf-8?B?NzQyQlpDaUxjSFJneEF2eSsvVDBrMzRYZWRDQkUyeHlvRk0xMHpxY1JoOEFm?=
 =?utf-8?B?c3I0SWZIY2lRcExQT3BkS3BlZC9Jdk1YQ1dldWlVdHlocndRVDZSRmh1aDFY?=
 =?utf-8?B?cC9uK00zZWNOcHVma1pKMW9mSHY0YVNoSnZKcFgyZit5TmZuSDVHR2c5ZnUz?=
 =?utf-8?B?NUJTR2NEbzR1SXNqZ3FGRGNRZUU1eWxFMURIaldoZ0lCMkVCTGtMNVFQSGxw?=
 =?utf-8?B?cnZETjVFNjMrQnhVRkpiYThOWi9LZWVWdFZQN3A2d2FsdHc3anFvTXIwTmtv?=
 =?utf-8?B?Zlg2ZWFFbG5LZDF5K3FuR1hidW96ZDBmTGE5UEI2UFgrb0lHRXduWXc2L29Y?=
 =?utf-8?B?bXRTV2cwTzFyemRNVHBVby82SUEzTG1jaVNTUDNKeTdjUGV3NzBkWi9Pcm13?=
 =?utf-8?B?R0xJUGNZRWpuS3lWUXBGc3o1NHp6VjRCN0ZwbTVtdFdvRWttZVNUT0NnTXVE?=
 =?utf-8?B?YTVkSlEwL3JFUjQ0K3dpTVlvQ1BoMnJlQnphbVBlQVpUbmNDV3M0MmNVUlho?=
 =?utf-8?B?bzBOSE5ua0s1TXBWbmpMSVI3V2p1eVZQanlFcHRMdEdVa0ZFYzlGblhXKzBr?=
 =?utf-8?B?Z0pRaGRWWDBnRHdDTUpEeWQ2aTczeTNuZUxKREFBYW5HQVFUcG5MRHVNWDVE?=
 =?utf-8?B?WVdXc08wYlVlei9uR3c1ZzdmcGZ0UGwyRVFxWXZXWC9hRjJIV29GRW1jckJ5?=
 =?utf-8?B?MXVIOGU3NUMwSkpNVjVSd3hvam9PVTh1eEIxbnltRXlyT2YzbmJoU0k5TVFq?=
 =?utf-8?B?bCtvNll5ZFZwbFJtSXNPSi9CekVzNzB4WE1JUHVYKzYwaFphT3BMbmxxYWhn?=
 =?utf-8?B?OTdMckE1SmZVaXYxUTVoY3hxWmtOMmF4elVXQkRxTTZGNVNHcVg2ejY5Vk42?=
 =?utf-8?Q?RqjQYHlV/6guDYFM=3D?=
Content-ID: <E8004C3D2368F54B9A0DC37F14DF25AF@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MwW4BMrOAVJtp4v1FxNAQ8ldcE56FijRNw5Jv8Rju/ShiZvpFCs9fAbYv+iIOKWvAIfjUzz+TyHqnHUhiwDDkx5cSIG4zOW0Llbv/zV4AK0cepS8pVTomAMEFkgde2ki2tOyd4flfazhpPon9Q6Ap2saHRVw8CYFtJPCC2ckuNKYR9PvsFOcO+cNqQwhx2SwnILfiwecAKDarKtlGbNnhMb5EPPxlUAhrHXn82KhmkETWRs+3jTfGUA3O7PDr+PMrL9PrxkqtTNdGhABAkXBhqHpf3eN3Sfb772RUcXPEma5tcXRfug0XXZDMUiIdIHuhn93T/hCFm37tkdq7sULyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41adfece-709e-4112-c63a-08deeeb3d067
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 03:28:39.5889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tskS5awnRweFd4QtLA+t+Iynmkisf+vI+lrcCPiVyaYP/n3oV6t24o1g36DO/YNp05/AtGMgE9arIJuwrg3PrsMrFDf8HTvWiJXnfpyFvzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7722
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=jP4ngnZNhpGreeWXsS3k4mIFPrh+/T6vi1KqcbzqEnk=; 
 b=K6uJ3nRNLqlyLPcznA59x3A4syVAm+IQXivpieG9e2k97u0QxvMdbNG/uhfA/Ep3IyqCRLYtcMZXTm+fatz4659OLLSLnVXXvUhBrCQZFl2qJU0bBErfMrQ4KfLK+aMn9m3dA3FIveUpWZQFY3ZIKZ6VAl5eczq4vZkWUqnWybA=;
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJEtdMZLkpA3r9I9tjrRWfGemfxod4Ecm80SrX7FQxo=;
 b=JWrS0lsSVjjoyP/ci043IWsFI26myZwtMCxn3mSVi1aL70cXgiMrhSWkzASlf6q/G8bqhGrqhiDJC7lCuebc4fzDNqKIORlVYtn364DQqZ9Dmbz/fU9ttOHAt0Q4VOA9dj5Ah9eIX+k7/UTaiN2mqoyJgQiS7VbbdYmsP3PfHNk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=mediatek.com
 header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=K6uJ3nRN; 
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=mediateko365.onmicrosoft.com
 header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-mediateko365-onmicrosoft-com header.b=JWrS0lsS
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE0OjI5ICswMjAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gTW9zdCBvZiB0aGUgc2ltcGxlIGRpc3BsYXkgcGlwZWxpbmUgY29tcG9uZW50cyBzaGFyZSB0
aGUgc2FtZSBwcm9iZQ0KPiBzZXF1ZW5jZTogcmVtYXAgdGhlIHJlZ2lzdGVyIHdpbmRvdyBhbmQg
ZW5hYmxlIGEgYnVsayBvZiBjbG9ja3MuIEFkZA0KPiB0aGUgbXRrX2Rpc3BfY29tcCBoZWxwZXJz
IGhvbGRpbmcgdGhpcyBib2lsZXJwbGF0ZSBzbyBlYWNoIGNvbXBvbmVudA0KPiBkcml2ZXIgb25s
eSBoYXMgdG8gcHJvdmlkZSBpdHMgb3duIGNvbXBvbmVudC1zcGVjaWZpYyBwcm9ncmFtbWluZy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBiYXlsaWJyZS5j
b20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvdmlkZW8vbWVkaWF0ZWsvbXRrX2Rpc3BfY29tcC5jIHwg
NjgNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoGRyaXZlcnMvdmlk
ZW8vbWVkaWF0ZWsvbXRrX2Rpc3BfY29tcC5oIHwgMzAgKysrKysrKysrKysrKysrDQo+IMKgMiBm
aWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspDQo+IA0KPiBbc25pcF0NCg0KUmV2aWV3ZWQt
Ynk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNCkhvd2V2ZXIsIHRo
ZXJlIGlzIG9ubHkgYSBxdWVzdGlvbi4gQWx0aG91Z2ggdGhlc2UgcGF0Y2hlcyB3ZXJlDQpkZXZl
bG9wZWQgaW4gJzIwMjUnLiBTaG91bGRuJ3QgdGhlICdDb3B5cmlnaHQgKGMpIDIwMjUnIGRpc2Ns
YWltZXIgYmUNCnJlcGxhY2VkIGJ5ICcyMDI2JyBzaW5jZSBpdCBpcyB0aGUgZmlyc3QgdGltZSBn
b3NlIHRvIHVwc3RyZWFtIChtYWlsaW5nDQpsaXN0PykgDQoNClRoYW5rcy4NCk1hY3BhdWwgTGlu
DQo=
