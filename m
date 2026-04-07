Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2B6FEEF49
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14FC48404A;
	Tue,  7 Apr 2026 16:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="tJJmN1sD";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bJrIo1qJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03A6840AB; Tue,  7 Apr 2026 16:23:00 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2D883A41
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 3bdfed1c328d11f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=OFrtTVE6vXlhtSVD7RextIbOwq3vZMi0xZioQrdv2B4=; 
 b=tJJmN1sD1J/2JIM9drJirb8AJki9lRffU7lNlWphG7aV01cqbw8Bvz016WgyYHGR7wmhjZE/1Uno8lmwRhD7L/MeAgM54ZL8telS/a+9Xmatn3OWp4YtzT0MVJL1a2hSAo178ughV6s7hmFfVgoxb76XQ1pgInU9v+uqre975Rs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:7f712c10-96d4-41ee-9df5-64bfd1ca6da0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:0195a894-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3bdfed1c328d11f19a16598d5ca7f8ec-20260407
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1001376807; Tue, 07 Apr 2026 22:22:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:22:38 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:22:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlfNO76UpBV1X6jA8PInecvIog3f0sg1eaHFM//mdnmgMN59OyrbdwvvmUYXXuR2WnR/MDGw0Y2KEzx0ziimLOBiGfEs95n7jMEu+ZWsif3LXU2m2zWrWzy95q3syP6xqrAWD2qDIUMcW0Of3VykHjUkmPnAed560JpBYi7K0hFSYhL7eCH1XDgck6EJ9ViklV4jZjHvH1aU2wT9CyktA1nTBln0Ue7FzV7Hmf0CZxYPHxzvaXMU+XVVWBnTTvOppWD0K+j6jq+hMFPmWnTcDvYw9+/lvpnANaHs5bFBfJt7Z8apkzWn2VPpADj49l9gE6rDuyWLcqX2Kc0OKwZkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFrtTVE6vXlhtSVD7RextIbOwq3vZMi0xZioQrdv2B4=;
 b=WfQpuCs5yDQZ+khUU7kDnqX3Je5QwOfoN1oOwiSDLi/FyYb/Dqufccc90spc+8GnX8iOIElh0Mi9Vg/dQwUGLKXXSdaTLL+Nw1FGWV9aYyBeo8+wWPOtONBxyIQOKBminmAwea6djEzQXfKxPFjuqtB1yXmgmuOVfLOFKiumKHce9VB2+3Z1MBY+8jCzLJjrZuBg0+VMJLyNl4ah8lvTla7NgFnnAna8L7muA5/tCXMoCHix1GA6hEFj6+HJVVu+w0Ite/P55mcuilzil6ZFaQEY2M+DUOwtX3Vove1MLIlhAkAdfFo12RTs/GzkSzBs5h6vOlcQT+xQd3SYggbZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFrtTVE6vXlhtSVD7RextIbOwq3vZMi0xZioQrdv2B4=;
 b=bJrIo1qJ7zxUymb/47yUVTVfY8Gdez8ood/H0zQ1XqoMNfsRiVP2SQR0HOtZ4fk5FVzyoye6gHXMfm9T64Y/4OqSWEIi5o6U83MJzcSG3nxjH8oYNsCs8UulZiBM/LnOr7jbzWMMu96yRS/0WaDslPCyeDMVrCQpsBZ3vbWOcMk=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB8288.apcprd03.prod.outlook.com (2603:1096:820:114::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 14:22:36 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:22:35 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?=
 <Ht.Lin@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
Subject: Re: [PATCH 2/2] configs: mediatek: add required config for SNOR on
 Genio 520/720 EVK
Thread-Topic: [PATCH 2/2] configs: mediatek: add required config for SNOR on
 Genio 520/720 EVK
Thread-Index: AQHcxgVLS85VyNdSrUSetLg4g7xvzLXTp+kA
Date: Tue, 7 Apr 2026 14:22:35 +0000
Message-ID: <bc9ca8686e5355fb5af97e6cc762f798eb475968.camel@mediatek.com>
References: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
 <20260406-mtk-genio-720-snor-v1-2-cbfd5fc4e59a@baylibre.com>
In-Reply-To: <20260406-mtk-genio-720-snor-v1-2-cbfd5fc4e59a@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB8288:EE_
x-ms-office365-filtering-correlation-id: 09fe4358-96b9-49fb-b788-08de94b11d77
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: sNq3Wb6E/5LAoLi7m67aWwP7h1X3Ocyg0N86YY6G9jHuh1vsQ52cOJBJipxNA43kvbeWN5rNSUtdHYWfAVJJ1BSlKtgsOtOABRPO7HFZ7t5fiZwZ+/pC+tYVdkDtECDWudG+fQ3qtzoNhUj7ARpcMcyW55txOHQsv7hKzg9NnJnY6aKqTckNXnkT8/eqLACjb37oM5Wxunq8T0O8Alo6i74+Z6JSY55j5lNpPmnIgCuCDefQ4sVl860GSUvd8xcY0HGghXbIFjHJIaN6ElSSGxZXVmo6ySD/UASc7ltks256z+7FVdUo2VJjnWemeN1bHr3AInGj0GdrZ88Xbsk8Vrzdx/TXw9PAjWGZh+YRTDG3z7mKW7uVMJzO9bU2mxIHoVh9QLXzQYQvAD7EWmM1cakFirDXtiikjaRvNsqt9Kggtf4UBeADeoSnhg8bOagyp2+6b1cfRM/ivwCscgr0H6YvED9eERsc3OpuepkJtc6TBaKO1il/cW9bpvLIXvTpGUXil9heAdKKMOKNv/r3EcklDFRxuZJZxoLx0odGqYHESgHAhNXPA69TlkcX2b1/qP2mjT+TlKeFuNENMqviNwnbCVlcQ7lx0VQKqkSzu8RUOEIlkbtNk4nwqciWsTNXyNRRJfPNwzW756Fbe4ifgYjou3qvledLgkP7Chl1uAJ5l5eWteJR1b711dclOhwkLhlA7GYCbYv2AWcAgA0KMwFfL/WmiQkgD1eYgu6oABVxc0VqI4x/I05+mKR5t32JomfH8CXFMhZRLAj+EU7TmxobkFZw18KlSYU7hTECT2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm8yR0tXMFZ4eWdSQzI4c0NDVFZmRU5YMURrdWlGZFpHK3lrQ1JiM2hFZEIz?=
 =?utf-8?B?ZVkvYm4rWUw5V3RHa0JyNTdsNExKUldMNzY1U2xWRGNmYlZ6a29yN2JITGxs?=
 =?utf-8?B?RDAzaFZlYkxuOG95Z3pwS2xQMmVMWFVGMmhsV0ZkcjJVK0FRc3NmUUhiZ2ta?=
 =?utf-8?B?K1dzT2J4S1hMUjRBdWluN25iUklKbFdiWHBoVG9IMmk4cXYrbWlDOGJLcUJw?=
 =?utf-8?B?dDE4QUdWZFZ1Ym8xQmo3Z20vcGZxdERKajRWS3R5N3owZnNLUElrSFRjOTVw?=
 =?utf-8?B?QUlyTEhqcVRiU1lVUGhUMVVzdlFqMzBJd1dOZEY2d3pzdGRIMy82bVphekNU?=
 =?utf-8?B?UVY5SENUTi8xTmhHYUpDUmhxRnVKUlNUOTR5SzYyL1c0UDFUWSs0bU8wVDV2?=
 =?utf-8?B?ZURWMytDaVFwSFJSajQzZVU1Tkh4YTJpV0NXcVdkTnRHYkVRaHpSOGhPNjFh?=
 =?utf-8?B?N0VzNnhzbUZBbU42NGlHak02cUp1QVVIazhGL04rSkx5WUlKZkMwRHZpclN0?=
 =?utf-8?B?TkVsQ21ldVdNTU51cnIrYTFsSWFPbjQvc1VhWVdDbjVDTXFydmMyd2RpS3Q1?=
 =?utf-8?B?bHM1MXkxRUpkMUNQZTFrVUlGd2tVMDhxZkdDTVY5dlRhVzdFaUF6UndtaGVa?=
 =?utf-8?B?ZTlJMkV5ZStMcU9SY2t0SUI3ZnBWQ2MzS21Bdld0ZmNpVHhCQUV4WG82SXl4?=
 =?utf-8?B?M25sZW1WMXhzZUlTNG1HWEF5Zjk4RVllcE9zcUJOazV3aTN1amt0TDloUk1R?=
 =?utf-8?B?a3luODZ3OThLMGMrRXN5SUJtY0dvVVJ2ZHAvaG1qcEZTc01yRXVaSjdZbDd0?=
 =?utf-8?B?cnBacHp3azl5RUxLZTlFa0dGZjRpdVFSUWNrMmVLQkRCRlJWc3BRWXNadmpQ?=
 =?utf-8?B?VVJWaVBCRFkrWFlYU1ZzYy8xbkpNdWplMmRYdVFac2d1OXpsTGpML2VXKzhu?=
 =?utf-8?B?RUlML09JZGVpcDN4bUZDakZxNlBvaVdVS0llRzFmNTQ1bFloRnJaSHBrVUlJ?=
 =?utf-8?B?NGM0bzRnMVpQRDdHUlg0ZTRRZGtDbEQ0TlhmUFhNUG1lT0o3N2F2NG0xSnpq?=
 =?utf-8?B?NGZvU2pteFVNR0JCamJKenlMTFYvTnNkbEJBSENZYU0yZitOWVVSRE4zbUF0?=
 =?utf-8?B?NHh3OHh5bS9tZzM5b1Mrck1JdWx0ZlpLRXA3UEJBMkJUV0JPRjUvVUl3ZXNE?=
 =?utf-8?B?ZDh0TU1tZE1oV2d0VDIwWkJtOVZvb09KS1E3MWl1bm5XOTMwUTBtcnQ2aGs4?=
 =?utf-8?B?VUNWM1NjUW0vYU9wTDZGbTlhclpqVVFORU9yNm9uVGdHYVFRY2xGY3EzTDI0?=
 =?utf-8?B?T1UwemM4emFMTzRKY3pOMm1qd3BvUzhsU28yUmttK2FPb1FpWUxUUkUrUE1r?=
 =?utf-8?B?ZlYyVjJocnUzcmVUbUFVcGZrMkYrWW5FM0VSYjY1MjRIbSt4SW1qQlBEUkE4?=
 =?utf-8?B?WHhQMzMvN0I5NDhsbVlYRTZwNFYxUmZ6bmw4d3VXRURGazlUZkZtWStrOEV6?=
 =?utf-8?B?MklYN3BpMDdTbGtDNmZtN1c3UmRpTXhYQkhBNkFkQmVYN3dCQ0RwSU9QMjVr?=
 =?utf-8?B?OGVvRTRYSjNvOGJQZ1YwTGtuL2xPak5tQkFIM244TzMxYWZmS29pOXdiZmJp?=
 =?utf-8?B?VWxwSzlMRHFJb2ViSDFYSnJKTi9oSWQwRFdLR2JYNHVod2NHRHpEa2VwQ04y?=
 =?utf-8?B?clpSdVBrdU5OaGtySG1BYjl4ZHVnKzBRdk5FOUdVcVg3bW1KbHVQYzZHelNq?=
 =?utf-8?B?N2l5bTlkZjIzbHpVNjF6bUMwazh5Y1hFODcyQ2xOT0xjcmZPZUZVc1Z6RFZx?=
 =?utf-8?B?RkFJVkVWdWlXNHA1YlB4VTVzUjA1NmdlWm1RS1BBTlpuYTR2VCtWL3F3SUxi?=
 =?utf-8?B?ZnFHWkk0cmtsSjVWWWYrRzBudm9vd1pod294WTI1emxQR291OVNXRUZ2ZU9U?=
 =?utf-8?B?Y0loU3llNXFzWWxvcEhMT244YXZtQis5UlFHeXZZeDYva2t2blE0eXJEVWVT?=
 =?utf-8?B?K0p5NVp3YXUvb2s4Nml5NlhMUGtLSTFXbzh3UjhUdVQ1Sy9UUENibERnWktp?=
 =?utf-8?B?Ym1vbWZXeENnby96RlJUbU9MWmEwbVc1T1JyS042Zk55aVFQbUpOV2dtem1T?=
 =?utf-8?B?THpDZWU3TmdPZWxVZUtTZW9PeVFxZGR4QlRubGtoYzZSQmo0TFpFUHFrMnEv?=
 =?utf-8?B?L3JxT2lhSVFONG9MUTliQ2VIWDJIWVkxOVRhU01lMFZsTFl1a0hONHhOM0JK?=
 =?utf-8?B?U0tGeFd1Y3RwSzlqU0VwOEl1Vmhla0toZlgxRExFbktVZTNmL1VieDUyQi94?=
 =?utf-8?B?QnowUkMwQUZpeDJZTUhZcHJ4RGNQVTNvV3NLVlFMMHJ3NnQ4SlN3dGdoUTVu?=
 =?utf-8?Q?SIHinu4NxmmF4wv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00787F185F742A4B8D35A9EFC395112E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rohxkFwPSA2y3wdARNH9XWMwniRfVJ5ucZlyf0cTJZD3qbQ5Hp3t08qbPqwvngVgaJ0AnWrPlGFtAX7hrnraUbX+PjU0BIkmfnoNlMfre+ZuKkH/c+XqkTO5Uv7ebtyH2dvtfWBDRQnQT6o0qb87wEg6l43QYrMxBpP5aKkT9CGs7TpG/XKvpVKOG4kUIZHBKEcMPnvIbd+498XuG+9gv9XWcQm/aw+ZIKuoQfEpxvZBRBZambd5Hq5AL0s2HoSMpLrie9RN+3vE4uA9zeNofCbnpxjhkV8vC416wZMUKA10KaAMcMxR58Gd97pW+3TQG1Uc6L3DOK2n+GE4vMiFqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fe4358-96b9-49fb-b788-08de94b11d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:22:35.7095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3z0eujoWcIjPuvVrtpK+KfptQnrmtBDSB/1MUzpaOg8FoZk+TG3mLHJlKPQywmFqXrbrmGJrKFPIOlYpRln3Sd4Symfzr6ziCUUpPYme0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8288
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

T24gTW9uLCAyMDI2LTA0LTA2IGF0IDE1OjM3IC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBFbmFibGUgb3B0aW9ucyB0byBiZSBhYmxlIHRvIGFjY2VzcyB0aGUgU05PUiBmbGFzaCBvbiBH
ZW5pbyA1MjAvNzIwDQo+IEVWSw0KPiBib2FyZHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGNvbmZpZ3MvbXQ4
MTg5LmNvbmZpZyB8IDYgKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvbXQ4MTg5LmNvbmZpZyBiL2NvbmZpZ3MvbXQ4
MTg5LmNvbmZpZw0KPiBpbmRleCA3NGVkZDAxNjllYS4uZTBhNmIwMjJmYzAgMTAwNjQ0DQo+IC0t
LSBhL2NvbmZpZ3MvbXQ4MTg5LmNvbmZpZw0KPiArKysgYi9jb25maWdzL210ODE4OS5jb25maWcN
Cj4gQEAgLTIzLDYgKzIzLDkgQEAgQ09ORklHX0NMSz15DQo+IMKgIyBDT05GSUdfTU1DX1FVSVJL
UyBpcyBub3Qgc2V0DQo+IMKgQ09ORklHX01NQ19IUzIwMF9TVVBQT1JUPXkNCj4gwqBDT05GSUdf
TU1DX01USz15DQo+ICtDT05GSUdfTVREPXkNCj4gK0NPTkZJR19ETV9TUElfRkxBU0g9eQ0KPiAr
Q09ORklHX1NQSV9GTEFTSF9NQUNST05JWD15DQo+IMKgQ09ORklHX1BIWT15DQo+IMKgQ09ORklH
X1BIWV9NVEtfVFBIWT15DQo+IMKgQ09ORklHX1BIWV9NVEtfWFNQSFk9eQ0KPiBAQCAtMzcsNiAr
NDAsOSBAQCBDT05GSUdfRE1fUkVHVUxBVE9SX01UNjM1OT15DQo+IMKgQ09ORklHX0JBVURSQVRF
PTkyMTYwMA0KPiDCoENPTkZJR19ETV9TRVJJQUw9eQ0KPiDCoENPTkZJR19NVEtfU0VSSUFMPXkN
Cj4gK0NPTkZJR19TUEk9eQ0KPiArQ09ORklHX0RNX1NQST15DQo+ICtDT05GSUdfTVRLX1NOT1I9
eQ0KPiDCoENPTkZJR19VU0I9eQ0KPiDCoENPTkZJR19VU0JfWEhDSV9IQ0Q9eQ0KPiDCoENPTkZJ
R19VU0JfWEhDSV9NVEs9eQ0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVs
LmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
