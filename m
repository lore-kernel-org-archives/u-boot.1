Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E067FEEF41
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9852840AB;
	Tue,  7 Apr 2026 15:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="SfpDIReZ";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dqFBFOHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A33F84105; Tue,  7 Apr 2026 15:18:05 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB44B83F98
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 3111f064328411f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=a3oZnLDRMF53HdmsY5+Z9VpAg9DKYn9IH5GlGVeUnoU=; 
 b=SfpDIReZ2SrROK/A3GJ8WrFOwyw4fbBHQknPLNDWmWDLWJFP0xdnhV5jzJ9UV7rOS8EOGqr+PhBhGcqkrMBzE8VkoTQcYO4pbYbs30uKzWu+RRZVb3DXP9XZW7wbq3WmZk7dm5Wm6GKpghNc3eiYwPdo1T1rLUA+oOStLy0CL6A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:8221bf11-2768-4a17-b089-b5eb61517a93, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:c436a894-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3111f064328411f19a16598d5ca7f8ec-20260407
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1794099682; Tue, 07 Apr 2026 21:17:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 21:17:55 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 21:17:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhu4AS8ft3MTPI+dXrmklLXDZwphXT+SsJKb2y/vWCxU7crW50lPDGdCWHd+6t+VQLvch0ntRnsv/qqvDX4f0atMiEcIU/PBHIdwIW5UHYvlCoC+/osrUm1wpdB7RCIipsXhLaCZffRlvkYG0MCQHIk8htLiRIUhcJBpvctXzVDRJ4rUt07tUeh7uplUzd5KUKkvXEgnPK+S+lOZYo4vxe4HiCb43zBZcSayPNiqe7PDCtar9y6C/k3IMPc7vXMxTr8MyMSpn3nhwe1nB5pKIXo7kHB0DOj9qwnZL7Gbb8qojLc2z7aUhHxyzG3qFqPedyZ6ieI0SwXEhfQbmgJxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3oZnLDRMF53HdmsY5+Z9VpAg9DKYn9IH5GlGVeUnoU=;
 b=i55MSnrMkYXu3KZXqfbsiCeooqRM5fH1HN38cUgdrWq05avElbiHuNxkiInThwOZhTvjXE+1TE/dhZI7iICXlOl3ALpGwExsFFcPJi77IfhWCuJ0vxOzb5f2j3ExDrw6OiO29WWbwpqmB8e90D5NICJIh8SIq9BIuyx3X9a/Yi69A0Mnd6YW0CWA8/nX7x2u8TIaQ0j3EfmbvjkFPlW2Uu6lQ77I7FfSJYGe7MK4hRZLDEs3f8mRpimYX+cdx/F3NM1MDqZHGe0dYFfUcrWmCCQV0kkS14nQeMZ36Gy1Ddwutsf/Meeb94t9NI7uPDGZcOE4SMZ/moZ5AM6nhA0OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3oZnLDRMF53HdmsY5+Z9VpAg9DKYn9IH5GlGVeUnoU=;
 b=dqFBFOHo2mbuRtvagkQ5VuVxMngs9I0wW2HFHXSzdmSZAVDKS0/FfqcU8vkEFBOe+BywJl2vaa35Yonnd608i33oL4eHqGXESKKh/LNfzCYnJmWZ0UUAnIs7YWsKwtddasWs9aLJQHq3ldRQP9MzhKIwr6ATLoPjx/naXr7kzus=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB7150.apcprd03.prod.outlook.com (2603:1096:820:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 13:17:51 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 13:17:51 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "trini@konsulko.com"
 <trini@konsulko.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "bhupesh.linux@gmail.com"
 <bhupesh.linux@gmail.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "lukma@denx.de" <lukma@denx.de>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?=
 <Ht.Lin@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>
Subject: Re: [PATCH 6/6] config: mediatek: add UFS defconfigs for Genio
 520/720 EVKs
Thread-Topic: [PATCH 6/6] config: mediatek: add UFS defconfigs for Genio
 520/720 EVKs
Thread-Index: AQHcwIX8T5S1DFOz30mUFOblEeI5DbXToNCA
Date: Tue, 7 Apr 2026 13:17:50 +0000
Message-ID: <bf15e828259485961a3d2210b00216fb0e7a02d1.camel@mediatek.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
 <20260330-mtk-genio-720-ufs-v1-6-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-6-3bad8362ed70@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB7150:EE_
x-ms-office365-filtering-correlation-id: 82a622bd-a1a5-45a1-5118-08de94a811e8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: z4S70mU8jhg7vIolRy5ytd/lto0wouGYaqkZBXyIMlB4GQDHpkUEVdEqa4c4431sbL/1XdHcDbJmq7nn6s/yp+icCTQLQE+nvEyLw7DWw+h+buJGZ5Xul79MnwOjlVJ2YhYswfRbx1FbkKMtI6IUSdtokfDjmgT+AZ9YJWF9sS9o1VP0T+dpkKRvXqPMxE491WkF3DNaueU3GozmWON/IlCkDnfnrjF/WU1ly4xFVWZMRC5NVjs0QMp9IqIQElvMzfnS5hYvp4Ge/ObF3j0rXJj5yrpnPtr9wSNIIOzdUDKjRTDRl5wfeDSNjfuTlCjBxhGcjpOjXLvNCrAa8bmtxIH9zR3QFw94u4iCcmCllS9Pt5HxXLiO/0EcQO8jASEaWGLd6s5kJAKoIrl0qRGOR/mBTI5dds4S2gjyA7pADEPh45oFWdVmt/JJrA6cWgX/PluIJ04tr+Ec5cu5O/L/RRkCpL6D8HfWRcukk6cYUv/+eA+njpAMwxnQOrZbJhOkBQ9/g2b1Z9gfe2OUmCaeEszGXntqWWsiuEN36g9dK6GxV4T3gU75+sxnsSPCpXvt3SEkJuNeKe5bW10NVh0Ya6RF1TDtEw58/smaFAw70e8OqFW9upKQMEw7SIKUGcT9uuSMamqzAiwJ1ovlYvt0yH7PiKMMma4zBsxdP+GWM2+HChjwyokn1q7TyhwNXawKBS7k7HOrI9aOr67qn3YuZY0bdUbAmCl1voIEsGOwejXkA55vMLwF7N4F3XsT6AU21MB44MKjAbMqn3WYwfI28Vzc0XcudRuxu2PmyO87UJRfzbNsVOnIC2FsQDNBwgR0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzVYWXRpZmtVSW1tbXZYUi95QXM1N3Rka29sT1ZDV1FyTmE1SWtUVXhCTnEv?=
 =?utf-8?B?eUFwc0xHdzIvWk5DLy9jbUhWaUdrVWQ0QnJUYmJNVTYwVTJvTW94bFp5Y21P?=
 =?utf-8?B?RnZ4VU8xNjNLSTNDQmttZXFRdGthdEdhRmVjbWJRcXQ1aStVeGorYlB6V0dx?=
 =?utf-8?B?NzN1bUE1bCtrMWhUbFNqV3c5ekVJc3diMDdFQjVYWWlFU01tWUx2WlhGZTl0?=
 =?utf-8?B?VUdEV01MM2UvNVBYZzJyL2J2YkFjQTVMRVYrK0ZsU2I4TWRQQTlBbzFNMGpN?=
 =?utf-8?B?a1dDRTBHZUExanRLbGpPN2N1YzZONjV2ZlA3MTZoTnQvK2doVVNJbldBUUJD?=
 =?utf-8?B?SnhJUXo0RWlETmxHOEJvbzlRT1N5N20rYkRwNFA1ZWZuUEZVQkFkNlJrRE9Q?=
 =?utf-8?B?V24vQ0MxYTdmWnViQUN1cDdlWXJXaWNVYVYwMUJNRFFabTVpK2dHS0JmaWU0?=
 =?utf-8?B?aS9wTitPaUlxeDlYWllLcTk1SERtb0FRMmtKUE0wMDg3QWhDajhqV0dJRU92?=
 =?utf-8?B?RlAwK0UyK2ZUV2pZN0ZxMTRxYUtKWUY4cW43S3FLTkZHWmV6K0NNMHg1YitT?=
 =?utf-8?B?WDBEVUVyRWxhbEcrajNpNVZ2THkrVkx5cnE1RzVYUi9DWnZzYXp4MTdVdjhM?=
 =?utf-8?B?ZC9pRGROdFRtTmwrdFJpeks3NlJJMm8vcGJtLzErYlhKL0xoMWJEaU5seW9u?=
 =?utf-8?B?MUE4elhtVEFOK3VYZm1QUkNpMXZiV2c3UDJxRG1oLzEvODVudHUwZGdYN2hm?=
 =?utf-8?B?WCt3dXpTS0srSFk3cDFpYUVQVWlEYVBUdytldFc5aERKWUtMWDFkUkpUUnRM?=
 =?utf-8?B?MEJPc0pYbXdiUUhpR3B4WVU3Q1hJTldiVk5kQXFtMXduejZETk96dXR6RUJJ?=
 =?utf-8?B?RmVVY0c4SDZhUFUxT3pjYUlWbVRJUmNBMExGeUROcEVsaEZWVTg5SXgrNS9L?=
 =?utf-8?B?STZWZGRDVTlhK25TTm82Q0dVU1U3VGRCY3UvS3hES2JTa0JGSm9CNG1mYVBm?=
 =?utf-8?B?dENsQkFRMEdQUExQNXNab1FGc050Ylc2bm8vWExXc3ZyTThsVWowdGxDTVhn?=
 =?utf-8?B?RHpiRW9wUGxpbTMxUTkvdGg3T0E5MzYxR2c2VWZ2bGowU0lFdkFoQ3FmbFNw?=
 =?utf-8?B?bGFmMlhhUkEyTFpCM3d0QWZXRGtYNnN4bGhlWXVhQnRvUERkMllaTldJS0k1?=
 =?utf-8?B?eG9xLzlTRnY3NW5xU2hIYU1MQSs5M1JBQ29qcGlTTWs4V1p4SFZqeGk5QkhO?=
 =?utf-8?B?SSt1dDl1SzZER3ZjTEp6UGg4Zm5lcEVQSXcycW5UdG9pYmpEMkh4NS8yMTF4?=
 =?utf-8?B?Sjc3eDVzM1lCcVNDYXo2VUlBTk1RamhlbHlaZ2kraTNQbVJiUDFhU0VsMEZJ?=
 =?utf-8?B?TG13dXBMLzUvVHMrL0hzTUQ5QzB5aDhmSGdOdk1SZ28zK0RkVHZNWHpKTCtC?=
 =?utf-8?B?S1RXbWl0a0h6YmZwR2JlS0kyYWtDckJEYm9abFc2WndiNVBhSkFBd1dNVDdF?=
 =?utf-8?B?Q3UyQ2phTG0vSDhRWHlpYVEzdlZXaWpBTjN0WllmQklwV2RzZGRzUHlQbU82?=
 =?utf-8?B?ZTNQY2YxbC9NeDZIQUZoeEgxdjFXeS9OM3laRzg2REc3K1RnbklBYTlXK0RL?=
 =?utf-8?B?WjhpNG9JRllUSlJWQ3ozT28zaithRjRsUXFYbHpaWXFtZUVZUFB6MVdzZEdF?=
 =?utf-8?B?ejhWWC9EaWlYUFY2TExmSitya2g4NE85a3JoQi9DaHJ1SStpWG9IOU5WZlBl?=
 =?utf-8?B?c1p0c04rN1FPZVZRT2FRTGJURTlNYXd0YUN0bFZFQ2hodEpvbkxET3QvR2Ur?=
 =?utf-8?B?ZlM3YW5ibGdMc0hJTUNqTEljdFNQTkRJREE1SWVjR0NSd2ZGSGs3N08zSnc2?=
 =?utf-8?B?dkwvNUJibHUxRkN4MFUzaE55bjdOV0xiTkV2TGFCSmZzTmpjWTIyRTFCb0Vl?=
 =?utf-8?B?ejlRaTBWNyttUFhDdDZZWFUwWnRPaWlET255a01Bd2xNdjg4aDZQVU9BSXdW?=
 =?utf-8?B?Tkk4UURrNU4vVXNnRXlZa1BGVmNlVFlic0UvcHNmOXhBbGoxak5CekQ1SGNC?=
 =?utf-8?B?MkprUkVZaEFlZlQ4K0pxb3RGWVB0UGZQZENxa1pGUndSdWdsd0dFQ0NnZFR2?=
 =?utf-8?B?SEtDUHBzdFozYmJPQkFHZk1oczYvSll0NzNjckhMdnhMTlJ4WUxUY25NR3I3?=
 =?utf-8?B?a280TWY1T1puL2Z6YkpzZVJsN0E4MUdSNFNRenZZN3ZDYWtTWTRmei96L2xX?=
 =?utf-8?B?SU0rODdyU0FiYmNrdUQ2VUVxZHRmL0x2NXlPVU9SSHNlWUU2ZHFJSnVBWDRO?=
 =?utf-8?B?d3IvRjBnKzdlM29PVUZzcjh4cDRDQWIzNkFCeEFaMDVCbW1RaEhLZUpSWlVF?=
 =?utf-8?Q?YtwJ+DDBx+7R0+4c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <700C99A3104CA94BA6EFA5C4B2379EC4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: flL1iCe0WDqlmz2+dC+GeJ+1Ofz+faaYNuwzB9/1dOAW9Krk6c3KNSaOurZGJbp8swCs/jhLH7PvRWNkZeuDQ4MVyTHo+tF60sYSokimHQBIk2R+h/PTpfyO6AM3+j/IcV7+69oPcYF+fq5bYn+pWKlPHwAk0kQqiYnJ9fD09HjXEtUxjVzn2gvKu+33fPNB483713DCpDobz4IuOplDbIYdh+9ihwja/yLSvO52gp69WzxwGjsFrq2SJ7yQWj001ObKNDWK8o2yriK51t6Ku93DK0uYPqFF2ALSlubftTOYdjNasSSUYHTjzzTbGrsNmFJ6wVYIudjSaebjjMvUtw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a622bd-a1a5-45a1-5118-08de94a811e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:17:50.8533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCm/nPAFa5/x8jJOKUmkIpugctx6qVNoZuym2zakol86ppnDMUKQ4604jImW7KfZXHEbLpDk1+wqL2kfqzdxv9fAGgPNVOEnVwEmSejKKzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7150
X-MTK: N
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE1OjQyIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgdmFyaWFudHMgb2YgdGhlIEdlbmlvIDUyMC83MjAgRVZLIGRlZmNvbmZpZ3MgZm9yIFVG
UyBib290LiBUaGVzZQ0KPiBoYXZlIGEgZGlmZmVyZW50IGRldmljZXRyZWUgd2hlbiB0aGUgYm9v
dCBESVAgc3dpdGNoZXMvanVtcGVycyBvbiB0aGUNCj4gRVZLIGFyZSBzZXQgZm9yIFVGUyBpbnN0
ZWFkIG9mIGVNTUMuIFRoZXNlIGFsc28gZW5hYmxlIFVGUyBhbmQNCj4gcmVsYXRlZA0KPiBkcml2
ZXJzIHRoYXQgYXJlbid0IGVuYWJsZWQgaW4gdGhlIGVNTUMgZGVmY29uZmlncyBzaW5jZSBVRlMg
aXMNCj4gZGlzY29ubmVjdGVkIGluIHRoYXQgY2FzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERh
dmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgYm9hcmQvbWVk
aWF0ZWsvTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMgKysr
DQo+IMKgY29uZmlncy9tdDgxODktdWZzLmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCA4ICsrKysrKysrDQo+IMKgY29uZmlncy9tdDgzNzFfZ2VuaW9fNTIwX2V2a191
ZnNfZGVmY29uZmlnIHwgNCArKysrDQo+IMKgY29uZmlncy9tdDgzOTFfZ2VuaW9fNzIwX2V2a191
ZnNfZGVmY29uZmlnIHwgNCArKysrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMgYi9ib2Fy
ZC9tZWRpYXRlay9NQUlOVEFJTkVSUw0KPiBpbmRleCBiMGZiZmZkMjZlYS4uMzdjYTM1YjRkZDQg
MTAwNjQ0DQo+IC0tLSBhL2JvYXJkL21lZGlhdGVrL01BSU5UQUlORVJTDQo+ICsrKyBiL2JvYXJk
L21lZGlhdGVrL01BSU5UQUlORVJTDQo+IEBAIC01LDkgKzUsMTIgQEAgRjoJYXJjaC9hcm0vZHRz
L210ODM3MS1nZW5pby01MjAtZXZrLXUtDQo+IGJvb3QuZHRzaQ0KPiDCoEY6CWFyY2gvYXJtL2R0
cy9tdDgzNzEtZ2VuaW8tY29tbW9uLXUtYm9vdC5kdHNpDQo+IMKgRjoJYXJjaC9hcm0vZHRzL210
ODM3MS1nZW5pby1jb21tb24tdWZzLmR0c28NCj4gwqBGOglhcmNoL2FybS9kdHMvbXQ4MzkxLWdl
bmlvLTcyMC1ldmstdS1ib290LmR0c2kNCj4gK0Y6CWNvbmZpZ3MvbXQ4MTg5LXVmcy5jb25maWcN
Cj4gwqBGOgljb25maWdzL210ODE4OS5jb25maWcNCj4gwqBGOgljb25maWdzL210ODM3MV9nZW5p
b181MjBfZXZrX2RlZmNvbmZpZw0KPiArRjoJY29uZmlncy9tdDgzNzFfZ2VuaW9fNTIwX2V2a191
ZnNfZGVmY29uZmlnDQo+IMKgRjoJY29uZmlncy9tdDgzOTFfZ2VuaW9fNzIwX2V2a19kZWZjb25m
aWcNCj4gK0Y6CWNvbmZpZ3MvbXQ4MzkxX2dlbmlvXzcyMF9ldmtfdWZzX2RlZmNvbmZpZw0KPiDC
oA0KPiDCoE1UODM2NSBFVksNCj4gwqBNOglKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJl
LmNvbT4NCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvbXQ4MTg5LXVmcy5jb25maWcgYi9jb25maWdz
L210ODE4OS11ZnMuY29uZmlnDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAwLi44YTdhZmI5NWIxYg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2NvbmZpZ3MvbXQ4
MTg5LXVmcy5jb25maWcNCj4gQEAgLTAsMCArMSw4IEBADQo+ICsjaW5jbHVkZSA8Y29uZmlncy9t
dDgxODkuY29uZmlnPg0KPiArDQo+ICtDT05GSUdfUEhZPXkNCj4gK0NPTkZJR19QSFlfTVRLX1VG
Uz15DQo+ICtDT05GSUdfU0NTST15DQo+ICtDT05GSUdfVUZTPXkNCj4gK0NPTkZJR19VRlNfTUVE
SUFURUs9eQ0KPiArQ09ORklHX0NNRF9VRlM9eQ0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9tdDgz
NzFfZ2VuaW9fNTIwX2V2a191ZnNfZGVmY29uZmlnDQo+IGIvY29uZmlncy9tdDgzNzFfZ2VuaW9f
NTIwX2V2a191ZnNfZGVmY29uZmlnDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAwMDAwLi5hMGIzNjVhODZhMg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2NvbmZpZ3Mv
bXQ4MzcxX2dlbmlvXzUyMF9ldmtfdWZzX2RlZmNvbmZpZw0KPiBAQCAtMCwwICsxLDQgQEANCj4g
KyNpbmNsdWRlIDxjb25maWdzL210ODE4OS11ZnMuY29uZmlnPg0KPiArDQo+ICtDT05GSUdfREVG
QVVMVF9ERVZJQ0VfVFJFRT0ibXQ4MzcxLWdlbmlvLTUyMC1ldmstdWZzIg0KPiArQ09ORklHX0RF
RkFVTFRfRkRUX0ZJTEU9Im10ODM3MS1nZW5pby01MjAtZXZrLXVmcyINCj4gZGlmZiAtLWdpdCBh
L2NvbmZpZ3MvbXQ4MzkxX2dlbmlvXzcyMF9ldmtfdWZzX2RlZmNvbmZpZw0KPiBiL2NvbmZpZ3Mv
bXQ4MzkxX2dlbmlvXzcyMF9ldmtfdWZzX2RlZmNvbmZpZw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwMC4uZjFkZTlkNWZhMWUNCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9jb25maWdzL210ODM5MV9nZW5pb183MjBfZXZrX3Vmc19kZWZjb25maWcNCj4gQEAgLTAs
MCArMSw0IEBADQo+ICsjaW5jbHVkZSA8Y29uZmlncy9tdDgxODktdWZzLmNvbmZpZz4NCj4gKw0K
PiArQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9Im10ODM5MS1nZW5pby03MjAtZXZrLXVmcyIN
Cj4gK0NPTkZJR19ERUZBVUxUX0ZEVF9GSUxFPSJtdDgzOTEtZ2VuaW8tNzIwLWV2ay11ZnMiDQo+
IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4N
Cg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
