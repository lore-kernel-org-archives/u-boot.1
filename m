Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF76EA4FD7
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 09:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31B283642;
	Tue, 24 Feb 2026 10:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="q8Qabwzx";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ff5fCOdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9CD383DAE; Tue, 24 Feb 2026 10:23:59 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D7282BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 10:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 857a4360116211f1b7fc4fdb8733b2bc-20260224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=LbX2wj3ubs0s3uU7VfMSEIL7XKpbFoTnFofPhOM3v7g=; 
 b=q8Qabwzx/sHWDU4a7P/GVcAMstH1xFYeB8jMpE6iVHEx5/YrmJ7w/8dc1h95DGqm3mFtIskuUlxU5yn6UIk/ijV+bfCllNleEjv4g6kV0inLSAfYLvYEvy6/OKQh0E4GQl0zQ379ZMj8aR5FhNU6LiVkfc8B3Gnr8b4NXWY7/CM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:d1d8b61b-8255-4688-bc00-d0ab7841f3a8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:630c8d5b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
 ,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 857a4360116211f1b7fc4fdb8733b2bc-20260224
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1151217851; Tue, 24 Feb 2026 17:23:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Feb 2026 17:23:45 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 24 Feb 2026 17:23:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj02BTC1IKSZYoxZINN4WX1EQu/pyfFkdP9KlRTlADgFhN6HC3oZT+rS0FadRdp50pUDGCZKtAv+IY3fCxKoMvE6CPClXo4qJqqX7ojAHXsvnb4C7LzozERw0rUeYpStgnxk1cewIeJfMWmfpHSYZUSY+z9aTXsQ4FzpePh2jG2wfGoVcMGZsKQyVlZ6eex8IXm7WHJsXJOCUW7YA2PjHoL+BPg7ak5nmZWeiUQgLsyFsyn53O+siQm1FoX1VDwzJF8Hpl7x/mfXL13vvSzzz4IspbR5lLkCT/1EhN6eJP2XliY21KctRr2oFhUqM20XrjB0sd8eNtjaCKzt+ATqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbX2wj3ubs0s3uU7VfMSEIL7XKpbFoTnFofPhOM3v7g=;
 b=BnkusH1wQWis3cgs7hwdHHn9AD6cFBcVWaT1wLapdiVH5EB+gdUFK/rpQoyBB7JOaO4opJXfAdkPXMjFL2ebu/2vW7Qat52hMZD2/GcPWu3SIyECOlnyQg1cDQxkTC8sktt+1ITc+bXAsw6prGbwtoRSExwvpyJvHjHSsl+eafBJlIQOurRsx+ztuuniVd2bJz38cCHAX9zfCqFkg9krANDs60CwQOPAzgR/HhJt5V3t0j9S7Wp5xFAdL5s1/+KMtbZWmKv28Nv22NiFYJbFGjmBjNGFdAVc51xVSjJrcN3IHX9eSE6oRZt80z1ink75kG1ZwkyppKNJfsgTU1Cfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbX2wj3ubs0s3uU7VfMSEIL7XKpbFoTnFofPhOM3v7g=;
 b=Ff5fCOdb+CynzFPG02MJWT48RXFWmpdfsn8vDJwRu0ViT4Y9NXaOaXuXz+QFBWMpNip0LXsgq11UT2R5Ta8lxPcGHAXsqb4A23lDV91ShMdYRS4k5jjHPGNlG7mB2KyCq8MPCqqa+lpq3sS8M+OAAagIoqB773aAn6n22fKAeBU=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB9683.apcprd03.prod.outlook.com (2603:1096:101:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Tue, 24 Feb
 2026 09:23:40 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 09:23:40 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 "aouledameur@baylibre.com" <aouledameur@baylibre.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "andrew.goodbody@linaro.org" <andrew.goodbody@linaro.org>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "quic_varada@quicinc.com" <quic_varada@quicinc.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>, "macpaul@gmail.com"
 <macpaul@gmail.com>, =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "marex@denx.de" <marex@denx.de>, "sjg@chromium.org" <sjg@chromium.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "balaji.selvanathan@oss.qualcomm.com" <balaji.selvanathan@oss.qualcomm.com>,
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>,
 =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>
Subject: Re: [PATCH] scsi: Adjust SCSI inquiry command data length
Thread-Topic: [PATCH] scsi: Adjust SCSI inquiry command data length
Thread-Index: AQHcm0MNZ/Puxtjb1kSwtCbOGje54rV9VoQAgAFkBYCAAGCqgIASjMuA
Date: Tue, 24 Feb 2026 09:23:40 +0000
Message-ID: <4143b51709b6a5b80b47409c2fa449c2b30b8cbd.camel@mediatek.com>
References: <20260211104043.2445588-1-macpaul.lin@mediatek.com>
 <52bb5837-ed36-4749-824b-e1215bedfce4@mailbox.org>
 <cc89f88aa46ee7f260b8182484701f0ce02f60bc.camel@mediatek.com>
 <65efde85-3e0e-46f4-acc9-8384a08a8e54@mailbox.org>
In-Reply-To: <65efde85-3e0e-46f4-acc9-8384a08a8e54@mailbox.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB9683:EE_
x-ms-office365-filtering-correlation-id: 663c13fc-1a16-4a7c-21bb-08de738665b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|3613699012; 
x-microsoft-antispam-message-info: =?utf-8?B?K3FYS2EyVTFxM3cxSUN6WWpIaGRMSmkwa1dYclRrRS9ZWlJGU3oyQ1oyT1k4?=
 =?utf-8?B?dGxaZ0I3UTFVOFpOSnUzdU1LR3BNUHJaRVc0RkNxZ0NOQWxlOVZncmdYaXcv?=
 =?utf-8?B?NXNKT3cySkpvNXpuQVJWZExjRjVPTW5oajcwQTlhQmllWGtHZTFXMDAyeFZ1?=
 =?utf-8?B?cEdNbFJUQWVaM2RMUHZUNGFHVlpGb3NhS2VhR05wTXJyNGxWaE5NWkZPLzA0?=
 =?utf-8?B?NGRxa1dFS1FtSVk1QW5kQTRQUVVVeWZVcnBHOXJUNko0RnFYMEVLLy93T05B?=
 =?utf-8?B?ZnJCMC9pSS8zVFJodGdEZDlGbEg2RmJjUXQzVTRJRDBuT3JPQVU0UGpDcHhY?=
 =?utf-8?B?bHFvU1dXTHRwNnBmdWdTRWM0dWRLc3VZWXdGbDVBSWRmMElZTEwvM0Z6cGVX?=
 =?utf-8?B?YmFLQWR4RnRzbU5rZnF4M25zRjYwSWg2WjRrYktNd0ZHOHV3bTJoMjdUejZt?=
 =?utf-8?B?d3JZSTlKUEZ4RWJiZHdQQmpzZENPaU5tTi9oRjNvOFh6Z2IxWW4ydWE1WFlY?=
 =?utf-8?B?b0ZJVkFMS2RkVWRQblA2UGF0N0cyQVIxbnh2SG5WYnE1YTY4MVpVVTN1dGtN?=
 =?utf-8?B?cFVsMFNsS2tVd0hwbkhHWE9rMWNITitiTVBoVm5lZDcrZVVjTmtPOFZIYUZO?=
 =?utf-8?B?bWNKWGd3a29VUGtMWEtqeGtvaUlyRDhFUWlZU1FJS2ZFUGd1eUphd0J3ZFVq?=
 =?utf-8?B?L3FGelFhTXV0QWVRNnlKNnFrUisxYWIwanZXYy9vSyt6czQveGF4bTlFcUFI?=
 =?utf-8?B?SENqSDRMRFhhd1UycTA4TkxWa29qWit0M3RUbURUS01XRWh0djltSENBZGw0?=
 =?utf-8?B?L09VS0NhRGJpL2JyRXZMcVVLVTNHV0dJTEVXZ3h0VDJQcVlYTUFYM2grSU5s?=
 =?utf-8?B?S1pQT21HWGRESWlaYWVhNzQ5ejE3Y2VUMmNxZ3Ura1N0WFR2eDJuLzVjb1pH?=
 =?utf-8?B?MzdQWnBiNHFFZUJlZzRUL0czZjZLUmNEWWdMNktseDFVcFJPZDV2TlJqSG5a?=
 =?utf-8?B?QXNHSDFBTk0xTHc1RlFIeDUza0J1WjV1bUx3cFpMWWNYU0lGNStocTV6aE9L?=
 =?utf-8?B?c1FiMEZWWkFvaXdsR2M3SEdTZDY5cGs3NjZGUUhHS2xvSVNuWlJxVS9TbjVY?=
 =?utf-8?B?MWpMckdKQVU2R1RQTGZkY0ZVMlRsZlBvckhESE56UG5EeXUwZkJ5bEllR3dR?=
 =?utf-8?B?TFM3ckJyVHcrMW8vTEtjWG83bUsrendNMGJwQVJad2JnbkE1NFNGRE9ZczlF?=
 =?utf-8?B?ampkQ0Uwa2NHS3FrVlZHNW1nMWdXZ3BZUUFkenVxRkxmTzlUVnh0bEdMY1FB?=
 =?utf-8?B?Y0RKVVBENHhUMEZ1bUN0RWtrYnVNWGU4Vjl4SGFXdXUyNm8zMTdYQjZ3MUtJ?=
 =?utf-8?B?OFVMdlZ5THBQb1BFSEpFV21aRlhJNVR2ZThHUGdaUXpmenFzakpYQ3QxY1h6?=
 =?utf-8?B?aGJ3L0Q5S3orSlZndzIzalJ2Z3g2cDVWVjRUaVNTdm1jcStCajhmZVliWlFm?=
 =?utf-8?B?dlFGb09EVkxWdjNRZDVIQTRhVGlZRlFIS3o2ZjVhZENjSHF5dExyQ1JGc0Nn?=
 =?utf-8?B?akhrdXVBOHlWd3hVdnpweVpTalpOR0RpM25Qbm9XbWtoY1JKb0YwZXFVYkow?=
 =?utf-8?B?c1ZJSlQvZnZDNHFpTFRpU1VQV2NBSUg4UFhGQkZyKzRzMWR6Wjc4dDNBTnJk?=
 =?utf-8?B?WVZ6cnJaRlNyVzBiVWg0c1ZqNzFabCs5ZW9uVHZFU1ZCVVBTMkU4RnBTeE1D?=
 =?utf-8?B?Q00zNEV1R3BhUEQwY052YkJJaENaS3UxdDdKY1g1YTRnTGlRSmtySWhUK1Rv?=
 =?utf-8?B?ZnVpV09wd1hkWTA4WFA0eHBwREk0SnpxcHVXVmI5YlJlU25iZ1l0RzA5K0dt?=
 =?utf-8?B?WFB6RU5qbnJFTzJyYnhWaGJxNE5zd3VLV0tHcEE0WFVQS0w5MGxMZ3h6ZGVh?=
 =?utf-8?B?bUlMYXRTWVEreG9Pek5udVpXeWJ5SG5sdzFJeXJkTHZLUUk3aWRKMUxUN2Rt?=
 =?utf-8?B?ejdNYWdHRVhNRW5jSHNub01wUzU5Z3ZhZU4zTGkxaGtDUG9acitwN1RsUWdI?=
 =?utf-8?B?WC9wV2c1OEJHTkNUTEFnNW9FbGxuR1A0dkc0eVhkQUkyRUI1NHZXdFRzek9w?=
 =?utf-8?B?N3YxZW8wVVJ4M0xaRVQxNWtlN3JORWQ4eEFDZnlwaFc3NE5PWEQydW84TVVZ?=
 =?utf-8?B?ZEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(3613699012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3ZIbTdYaHRaWG12WVdpV1ArYXBCRTBqaXovbUtTNkkvY1hhTlRUb2Q5amNB?=
 =?utf-8?B?RlluWmkwWnVkb1ZDbjZKd2cxNjk2aXZ4Q05WRmlKalM1blkrV2t1SHhvczJZ?=
 =?utf-8?B?U3RMOGZENUNNNS9wdFZIeHhqMXBxY3VNSnJVbVFHQWdwVFB1K04zL2RlTis1?=
 =?utf-8?B?VXZNeHdKL3ZtTGJydnRBanhTaFBTZTV0b1FYeE94eDdQTWJmNVI4ckdnaS9y?=
 =?utf-8?B?Q2dmQjNhQ3JuL2xaL043VFo5ZW96Y2pNSElyTGtWdnVWYUZoWUR3QnZWeXd4?=
 =?utf-8?B?OFlPSjkzNlNsUEtTWW5wc3JQQnJRMFhkK29UMGlXZmhGOFhLSUNPZ2FkcDZj?=
 =?utf-8?B?OUZBYzJCbU5GVGVNQ3A2cW1lRHJZTk5nVnpiSEpCZUhDdERzYngyYzRTUXc4?=
 =?utf-8?B?VzdPakRNNkNTWjRSRFBnVmwzcDVENUFac1drTnVFeDlPNytJSkRoem1jVEsv?=
 =?utf-8?B?R3pLc1FTMmlVY0dIcWo0blI3V3NLQ3lQZStLa2FkYk1VWXJuYk5tOUNYZHdk?=
 =?utf-8?B?Z3QzZkNaSjNyTkg3ZmpLWU9RSENqQ1dyemNtemlKUHMwblJBWGw2M0x2MDgv?=
 =?utf-8?B?SzR3Z1JiZnRFa1JDZTdBRjRFNGZoR21nMHFCU09SSzlwNlNBOFBqSXhlSmZ4?=
 =?utf-8?B?NFZRTE5OTnpXZUFQbTJGc20za3lzY2RxVEw4bGlHRytEc213clhvcElYazlH?=
 =?utf-8?B?TitWNG5jbDVmYi84cUZ6NUdwK2gwTEN5aFBtL2JJNEJQMXg5UFhscEJwSkJV?=
 =?utf-8?B?UjU3bkdLd1JGNWFCZzRjelYzdmF4T0FRMzdVWlhkWTgzb0FZT0NabTFsVmo4?=
 =?utf-8?B?RU9neExqTDlsYkdGZDh2Wllzc2NlLzRKZlA5NExFcSs3cFV3TUxBTWMxZHFz?=
 =?utf-8?B?VnUxTXQyQW9sR096eG45YU9na09HSXhwOGlQMkZ2VEJKKzRodWg2Ykp4di83?=
 =?utf-8?B?NTZuK09vWGJCRlh2ajdiTDZJZXlQSjJ0RmVJSUJDcnpjUVNac2tjdjBoWUZz?=
 =?utf-8?B?SUkzellDOXZJUXFWczZ5aCtpdjlyNkttTGQzYnpwWXFWaUVDLzdON0oxNnNi?=
 =?utf-8?B?amZiTXU5ck1YaHF0Y2RaMU96SUhnMWMzWDIvWkNoOXRrR0xDbW50Y3Rtbmla?=
 =?utf-8?B?Uy9mTFpISTlDbzFuanNQb280OE8yTnloRVozOTMvdFVxSlJURDg2b1JCYVA5?=
 =?utf-8?B?NytJZmZjbFNSMCthQ3ZhNno4MTkyakhWZGJTZFY2TjZMbVRyUWxxWnBEZm9o?=
 =?utf-8?B?a2ZjeTlLeHYrQTdKUXc1NE5VSFZYUTh2aWR4YkhOY1hmSDFZekxuUWhDTXhn?=
 =?utf-8?B?ZWg2M3ZjZW9NQnFMRjNvS1RwSGRUcXdSWndSSzNSMTFpTFRsd080U0FXNko3?=
 =?utf-8?B?SGw1SlR4eXpwUXRpRWY5YWpQVWN1Q3dUS1BsWG5nVUdVcWQxSjl4NEhzUGFj?=
 =?utf-8?B?M2NjZ1dBSWJNQjNjTUcwSkF2a0lpa3h0ZGhjSXhFV25HR1JFeUlOUFhNeVJo?=
 =?utf-8?B?VW5UaDlHcWF0WnhibWFKUFVJNVhBbVRPSXIwMHZUcWJzTGowVXl1bjhvRnhU?=
 =?utf-8?B?RGpNUTQyN1RSaThXWGpRYUIwelpyeHRxVEdrZjUzWU02cGhDSDQ0WFEraDZV?=
 =?utf-8?B?aE9uTjVmbm9PTFAxelpFMWd6a3VnVDVNV0REdy9MMU55UnlEa2htaU5McnFE?=
 =?utf-8?B?OGlGNHdXYk5vNVlPc0xsK1FNaUpkczY0VFBoNldXeGd0N1I0SDM4QVdlSTg0?=
 =?utf-8?B?RkpBb2U0SVR2OXh4Wkt3R0Q2ZlY0OXFxZ25nNUwwb2dHL1NyYWN2NzNSTElt?=
 =?utf-8?B?NEhSMzNLekhIWU5JS3hrVWdMeHRydGQzTVFRWm90ZWQxNUFJOEFhMUNPZkky?=
 =?utf-8?B?RlVCZHF6Qm04enlWVThlYTJhVXJaMklpR1N0VDVxVFFEVmJPVWUrQmpvNThm?=
 =?utf-8?B?dS9aWEJtS2FyaHBwaEpsenVqZUp1TFZSVlZ6eTBGc0RJV2RWM3NVdWQ3SjZR?=
 =?utf-8?B?d0RGZ0E4UUd1QmE3cE1xbkZZMVdkdWhUMThBNVRHOXU2Tm53d0tPb1VWN042?=
 =?utf-8?B?dlBjSUhFUkJZcUN6anliQlZaYUlHZXA1SWkyTm9VK21nYUE4TW5ZQXZ4YVRi?=
 =?utf-8?B?dTIrUG13MWRHWjRkMUJhU2RBbHQ3ajdIZ1pUajdxdnM4eEhZRXliQzQybDdl?=
 =?utf-8?B?dDFwZE5GdGdWcUphUHBNWkFRaFY0VnoxNmZGcXJPdy96SUNOY2kxaFZJTmll?=
 =?utf-8?B?azZHdERsbGxFcHFqbk1vV2RGVlZ4Q0NERGRJRTRPdllBSlpvMkVPWWdYYXFw?=
 =?utf-8?B?eXFvVGFjb0NSc21GV0ZiTW1TQjkraUk4ZndPZ1JXK3BEUjdHcC93dFB3MmYv?=
 =?utf-8?Q?yxKwBEG+VUfc3UZg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E95D2CC1D621C642B3D16A5B611849FF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gqXPLeQ7qRBV/pOIdAl86Rxyrq/7bNAq2YEdggRDnloiEXMXqUtuGis/S2OsSu3GwIx8bSqOguEFxrywgeoMo2EptvYZH+Dr6mnSTm0bym81wbaT+IEyROpEwv9DNCJEv9C33unxKkV8cE4RhpY0VfdamMKQXkyYzbNe/vZ8/HLKhCgwV/UM6zqoG/k+My9czSZnqF+TNwBhUtEdyZRRKk5CxY16UIHr6tlAVogZi8/s4gHyw4zG5XaUJ7pdQRppxdQh7hpCtPK2KVnX3LIVZENP0A+mvYqU2atSmWqI8KUlLy+9QHhPaD1/WVgzN1SwRm33epIwlyOuMbU6NK9XJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663c13fc-1a16-4a7c-21bb-08de738665b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 09:23:40.2173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMq3OHJ4MqPsjF9ATlRBgnWDkAr7tnWigNJAYd/P/zoxUVD6PYbKmcum2/ptOZC14VJWpCWWn3PWALAUO3VHLXLPAea8IzkCRVPaSq16onQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9683
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

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDE1OjA3ICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gT24gMi8xMi8yNiA5OjIxIEFNLCBNYWNwYXVsIExpbiAo5p6X5pm6
5paMKSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjYtMDItMTEgYXQgMTI6MDYgKzAxMDAsIE1hcmVr
IFZhc3V0IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlv
dSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+
IA0KPiA+ID4gT24gMi8xMS8yNiAxMTo0MCBBTSwgTWFjcGF1bCBMaW4gd3JvdGU6DQo+ID4gPiA+
IEFkanVzdCB0aGUgZGF0YSBsZW5ndGggb2YgdGhlIFNDU0kgaW5xdWlyeSBjb21tYW5kIHRvDQo+
ID4gPiA+IGFjY29tbW9kYXRlDQo+ID4gPiA+IHZhcmlvdXMNCj4gPiA+ID4gVUZTIGRldmljZSB2
ZW5kb3JzLiBUaGlzIHByZXZlbnRzIFNDU0kgZGV0ZWN0aW9uIGZhaWx1cmVzIG9uDQo+ID4gPiA+
IExvbmdzeXMgVUZTDQo+ID4gPiA+IGRldmljZXMuIFZlcmlmaWVkIHdpdGggSHluaXgsIFNELCBh
bmQgTG9uZ3N5cyBVRlMgZGV2aWNlcy4NCj4gPiA+IENhbiB0aGlzIGJlIHF1aXJrZWQgdXNpbmcg
c29tZSB2ZW5kb3IvZGV2aWNlIElEIG1hdGNoICwgc28gb25seQ0KPiA+ID4gdGhlDQo+ID4gPiBw
cm9ibGVtYXRpYyBkZXZpY2VzIHN1ZmZlciB0aGUgY29uc2VxdWVuY2VzID8gVGhhbmsgeW91DQo+
ID4gDQo+ID4gRHVyaW5nIHRoZSBwYXRjaCByZXZpZXdpbmcgbGFzdCB0aW1lLCBFcmljIChIVCBM
aW4pIGNvbW1lbnRlZA0KPiA+IHRoZSBsZW5ndGggb2YgNTEyIGJ5dGVzIGlzIG5vdCBmb2xsb3cg
dGhlIHNwZWNpZmljYXRpb24gb2YgVUZTDQo+ID4gc3RvcmFnZTsNCj4gPiBpdCBzaG91bGQgYmUg
MzYgYnl0ZXMuIFNvIHRoZXNlIGFyZSBub3QgcHJvYmxlbWF0aWMgZGV2aWNlcw0KPiA+IGFjdHVh
bGx5Lg0KPiA+IEhvd2V2ZXIsIEknbSB3b25kZXJpbmcgaG93IHRoZSBwYXJhbWV0ZXIgc2hvdWxk
IGFwcGx5IHRvIHRoZQ0KPiA+IHRyYWRpdGlvbmFsIFNDU0kgZGV2aWNlcyBsaWtlIGhhcmRkcml2
ZcKgIG9yIFVTQiBkaXNrLg0KPiA+IA0KPiA+IEknbGwgZG91YmxlIGNoZWNrIGl0IHdpdGggRXJp
YyB0aGVuIHVwZGF0ZSBuZXcgcGF0Y2ggYXJvdW5kIHRoZSBlbmQNCj4gPiBvZg0KPiA+IEZlYnJ1
YXJ5Lg0KPiBUaGFuayB5b3UsIGFuZCB5ZXMsIEkgd2FzIGFib3V0IHRvIHBvaW50IG91dCB0aGF0
IHRoaXMgaXMgYSBzY3NpIGNvcmUNCj4gY29kZSwgdGhpcyBhcHBsaWVzIHRvIFNDU0ksIFVTQiBh
bmQgc3VjaCBkZXZpY2VzLg0KDQpBZnRlciByZS12aXNpdCB0aGUgc3BlY2lmaWNhdGlvbiBvZiBT
Q1NJIFNQQy00LCB3ZSBoYXZlIGNvbmZpcm1lZCB0aGXCoA0Kc3RhbmRhcmQgaW5xdWlyeSAoYW5k
IHRoZSAxc3QpIHNob3VsZCBub3QgImxlc3MgdGhhbiIgMzYgYnl0ZXMuDQoNCmh0dHBzOi8vd3d3
LnQxMC5vcmcvbWVtYmVycy93X3NwYzQuaHRtDQooQSBzdW1tYXJ5IG9mIFNDU0ktMSBjb3VsZCBi
ZSBmb3VuZCBoZXJlIGluIGh0bWwgZm9ybWF0DQpodHRwczovL3d3dy5zdGFmZi51bmktbWFpbnou
ZGUvdGFja2Uvc2NzaS9TQ1NJMi0wOC5odG1sIzguMi41ICkNCg0KQ29tcGFyZSB0aGUgbG9naWMg
d2l0aCB0aGUgTGludXgncyBpbXBsZW1lbnRhdGlvbiBpbiB0aGVzZSBzZWN0aW9uczoNCmh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5LjMvc291cmNlL2RyaXZlcnMvc2NzaS9z
Y3NpX3NjYW4uYyNMNjkwDQoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE5
LjMvc291cmNlL2RyaXZlcnMvc2NzaS9zY3NpX3NjYW4uYyNMODAxDQpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ni4xOS4zL3NvdXJjZS9kcml2ZXJzL3Njc2kvc2NzaV9zY2FuLmMj
TDc1Nw0KDQpVbmxlc3MgdGhlIGlucXVpcnkgbGVuZ3RoIGhhcyBiZWVuIGFzc2lnbmVkIGJ5IHRo
ZSBkZXZpY2UsIExpbnV4IHVzZSAzNg0KYnl0ZXMgYXMgdGhlIGRlZmF1bHQgc3RhbmRhcmQgaW5x
dWlyeSBsZW5ndGguDQoNCklzIGl0IHBvc3NpYmxlIHRvIHVwZGF0ZSB0aGUgaW1wbGVtZW50YXRp
b24gaW4gdS1ib290IHRvIHVzZSAzNiBieXRlcw0KYXMgZGVmYXVsdCBzdGFuZGFyZCBpbnF1aXJ5
IGxlbmdodCBhbGlnbmVkIHdpdGggTGludXgsIG90aGVyIGRldmljZXMNCnNob3VsZCBhcHBseSB2
ZW5kb3Igc3BlY2lmaWMgaW5xdWlyeSBsZW5ndGggd2l0aCBxdWlyayBzZXR0aW5ncy4gV291bGQN
Cml0IGJlIG9rYXk/IExvb2tpbmcgZm9yd2FyZCBmb3IgdGhlIGZ1cnRoZXIgc3VnZ2VzdGlvbnMu
IA0KDQpUaGFua3MNCk1hY3BhdWwgTGluDQo=
