Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF14D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBE984459;
	Thu, 27 Nov 2025 18:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="CsdIuPp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A6D8445D; Thu, 27 Nov 2025 18:42:46 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791048432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLW9vItct81unETJFVv8sh3fVqnslhrbyT7mRbE33SdeMgQiBqxtBemJSgZKEoAfcZyA1tz6fmnem3C4hiZCvOvs+Ag9N34IchPYV1/3qU87ZXdfkbRuXreIae9owzSFWVkpvSfyvjAw33aMomiENJIvyeblc8lOaFkNCcFZpHvPV4BTZHL3xUZRVvzmnBsNqiCfyFLS5bZlDCFY2CFEpWnkJTnW+IGjUs27OkvMduQUgQgOffEeUTpsjgR2HwTAleQzIKb2UFqHkjbPhhBRhB0nZ5oe/DRXvwRLYn+atauWGGlI28oSgwRaygq8apGhq1wwigZmmUsGD2jgrrK3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jjzBPwo9mstXPqO+SwFNM/itdzdFGO18OsvWWsihHM=;
 b=Y9nocMlka2uAulOcLTsEe9s2gV0zbY6ODdgXgnsHY9qwooGUHeD7XWxNRTMTUrBVWQH5DzxgbeYAHOhhuKE+xcqxNiFYkvQMabEzbuhamYE6ryrv7ipYfq5GQ4oyQRThmlRW+3LGcSWfQeGR1US9AbJrXBgioihNKW74vOOl62PauJsStlvZ2igrs+m2VIo5rT/TK80ivR62wcLhOVuil+d2VQtvKPuusv+RU4dsQwzJZ7unsqOmHsHhjoLw2sgTya7nAnqki+X1f8h+4S05fAbBbf3yAz3V1aklvgmpogiOPxaVx+LHSoz6z3hW9RKoobZRYUiPgs9RR1NNa8JUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jjzBPwo9mstXPqO+SwFNM/itdzdFGO18OsvWWsihHM=;
 b=CsdIuPp7Dz/OvuUKfhjXj1etoExp7toH0GZCJU+1oSQEwETIEXeZHDLS+T7u/Op0P0rmxSZTHtywPcW6heUpaM5iCz9i+QQzVpJLiHhjZ9yI6nlaDffH1aRi8+5JllGtabdmf/mQvT6oD90yhexYpt+BPabdFDUWSXMlfr4pnCty6q7TEOj/jzlTQYWXDNDtIoTFJzt3qNGvdHda7OVgd/g0iCyhRQ1uuRCLI3cAgbdPEHTWBAz2pDzpvApKL9OsepKnbT+0OHa4dYoZCxCBKbmk+ha4wFHwaHYlmtgdMBwPckHkRypCq4piWOLylz74HhyKVxsd9U6OrdX8pUBlTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM4PR10MB9402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 17:42:42 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 17:42:42 +0000
Message-ID: <4f44bb43-3b8e-4cc0-956b-af6f1e6e65c4@siemens.com>
Date: Thu, 27 Nov 2025 18:42:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
 <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
 <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
 <b977adfc-f16e-4436-91eb-8824932379af@siemens.com>
 <CAN7C2SCiTqJDK2ZVjJ_859NEDg6tD3KWQqzVHqqmbyM8+aBvLQ@mail.gmail.com>
 <d4b1acef-fd8e-44d2-b583-450d4c61190f@siemens.com>
 <CAN7C2SCQkBfbq1f7b6W2sm9Q-rtB3+5a5NUMOrXWCite7BTLNw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAN7C2SCQkBfbq1f7b6W2sm9Q-rtB3+5a5NUMOrXWCite7BTLNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM4PR10MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: eec8be9e-72e1-422d-1c77-08de2ddc5d59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEx2OFUzU2Z0QUVSOERtdWhqL1VNekIzQWl3NnMwdFJBd24rU1ZOVnYvYVV5?=
 =?utf-8?B?L2txZGxSWXAwYmgxeWxsZHV0VW9neStlSWIrT1p0ek1TK2lkeWM0TElNNnJY?=
 =?utf-8?B?OGRkZUptMmg4clpPNGhDTjFTN0RYV3hUc21hMkxTekI1OHgveXdEWmlnZnRN?=
 =?utf-8?B?Q0pleXJpY0JZNCtNbVpxZ1o4dlRtSk9EVlZrVVRFaGxJNENHOWhMZ1VybjUr?=
 =?utf-8?B?MlNWSVluenIzaVFvcThHbEJXQVhEaFRSVHhVTnhLbkV1cU1LRmNuV0pvbHlj?=
 =?utf-8?B?YURqNzlONWlmSmJpR0U0dTBtRVFjMDNKUUZjdk5ETWJsLzF2RGdiWlB2RlJs?=
 =?utf-8?B?MWVPZlpaelh6Q1BoQU92Y1JTdEZJMFpwUVZxWlhTTnpVMVFrNDBReHZLNUND?=
 =?utf-8?B?c21rdG0wVzBTQ1hqTFpkT2ExeGswYWtEc2w3V0xvd2pHRk8xVjdQemxUNjVJ?=
 =?utf-8?B?RG1pL01CZzVFektqSk9ZNXk1eVE5Q0QrcXRkcnhKUHFtRi9lRkxqUzltMU9s?=
 =?utf-8?B?b0JkbFRjRFN0N2JKakxNdHVxWHl5YXllT2lZQmlIVFFrenE0Mjd4RUMvaHdL?=
 =?utf-8?B?dDFSRW1XbkUvemd4UkdoQjRVUW5qU1lMUjFnYXNQY0F0cnF4WFpqbExUQldp?=
 =?utf-8?B?QWh5TnBaQThhZnUyem1KcklmTThmK1VjWmJoQjh4TktoTFBVMXppWVJRWkMv?=
 =?utf-8?B?REJvT25TOCt5dnI5enJaWGptOExLVnEwMElyQVJYaFFpUUt3TGM5dVVUZmhW?=
 =?utf-8?B?ek9VZ0d5a0k5dmJuOGd0SUdxVHR4UkFFWUVJd0NDZWFHRmRZa1ZlOE8wWkRW?=
 =?utf-8?B?c2JFb3FtcHE4czVzdGQxNW9qeHhjNEVyRzU0Z2daWWMwWFpLbW8xQmJSUy9m?=
 =?utf-8?B?Y3U2WHNOYXFCcGlZMFFUSmRJZjEvM3VQck9XQ09pU2tjMnBFT3dtNzhVazBR?=
 =?utf-8?B?UmhiK1Z4bllPTXgzVC9HZDVWYmcvZ2tpODkrZmp3ZEkvcm04OFowVDJmT2dl?=
 =?utf-8?B?M0MycnY3MzJRelpTeEx6cTZSZWx4MkFKRWNobWM2eWdHNVE4bUVlVTNKTGxF?=
 =?utf-8?B?VHdybFhaRDJjem5OT1huNDA1ckNSV2NuS3hWVXVwR0N0R2E5WFRoOHdSbE0w?=
 =?utf-8?B?VWFJelFlMlpaTm8vNHN4QVBaOGdOWXJHdzJKeG9OWUJnWmZUejFXSTgwM2Fo?=
 =?utf-8?B?TFlCbHRuY09EZVpwd0ttbEZFSEE2b0VzOXNZUzJSS3hqWVhrTUxWZ1V5d3Vv?=
 =?utf-8?B?c2Z1NXArNjRuN0V3MkVndVpkVWI0ZmsySVA5N08vYTFqTmJKVGp0dUR1V3NJ?=
 =?utf-8?B?Z011TEZMSmwzbVJubTVmOHF4bTc0cE5iblJKZzRFRmRRMlpxSmxOTFNISVdT?=
 =?utf-8?B?RWUxeFJoVW9LZkFteDQvZS95bmthNVhzSndHcFZqY3g4cGhCN1pmbUQwSkFX?=
 =?utf-8?B?aDVaTTR6dnlGNmlsMm1FejJzclBzWVJpSVIxTFpDdXZ1VjBybStldW9xMytW?=
 =?utf-8?B?Y1d5RS84VkZvVU1RMUFwVHZCN1h0dFlvVzNmV3BjUkVDdE5GVmcvdHVLWklC?=
 =?utf-8?B?RFNnQmJ1bUVlUS9BbHdPT0l2L1hvb2g1K01GVlBVeGNYRlJ3NjhDVmtFTnRK?=
 =?utf-8?B?NVJaTTczOGhhRkVJcC8vTHVmcjZYSVFRU3NBaXFwWFY0MjcrdERpaUVFRWdK?=
 =?utf-8?B?dVpTWUVwN3ExMVo2NTB5UHMyKzZZN1VRejFZQ2g5ZlZYUkl1ZGp0a3FTbnBu?=
 =?utf-8?B?bjlQVmY5S0pBMzdyenNQdStucEQvcHJVemhPZFlsS21zSXM4enhUTDdBV0Yr?=
 =?utf-8?B?RXhUTmhPY05zU2g5b1VWZlJpeVNWSTV1OWZhVE5ocUJoRjBpNlgrY1NZaXFx?=
 =?utf-8?B?NmNyNEFJUmFwa3NDckVZWVBLb0haa2hzUVFpbHd1RzBIYWQ4TXk5M0p1cE83?=
 =?utf-8?B?cEpSdmJRejFkUjR6ekVhaE1iam00TU9tSFNGOVRjRjM5RzErMFlSYmduZnUr?=
 =?utf-8?B?U0dKck55L2h3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUFHYWtPV1hsSG5Pc09GNjZZZi9xSWovWkV4NVBuOFdGMzVVajM2aDZhL3RG?=
 =?utf-8?B?MHBWSzE0NEFoU1IveVZ2WUxBdUljMFY3dDBLNHZKZ1ZZdnU1eDdRTW5mL3dM?=
 =?utf-8?B?cGNCVjlvanNaQjdQejBjNHhPcTBvZzkrYk1RZWk5R0dIajliNGFoUVBRMlR1?=
 =?utf-8?B?MTIvUkhRcjcrYStTZ1FWTzc4U054NDZpcFZGYU9Jb1gyUE13MW95cG5nMWZo?=
 =?utf-8?B?cFFLd295clJjUkFIY1J3SHJZOC9lMDdFSmFKYmd1bG1nb2ZvVVY4cnltaEk1?=
 =?utf-8?B?MzBSZUIxQmFaY2ZhdVJIZVBXd0JRaEcveU5HZk1WUTFhR1dYNk5vVnpWVUFG?=
 =?utf-8?B?S1NMSTczb3JiTUt6NDlYK3dwRXozTW5OMHBaaFgxaCtYUzMvdVV4Y2pZblJV?=
 =?utf-8?B?NXN5dEQ5allwaTlXci9HU2hkZXo5SW5VM1JMc0FYQ1EzaW5QT2RONk4wVlA0?=
 =?utf-8?B?SDdyeXU3WXlobG55d3FqOWNFbTEvZEFtRXg0Z2liMGFIU01yZmdyNGM4Q0R5?=
 =?utf-8?B?d0hkcFgraGxUUERiY0NkcVhNNTlmS0VGZ3kvMWRKa2tsVm9BSHVDcG9xRUNq?=
 =?utf-8?B?ckU2bmszcmtWM2FrYUZSMEFoN2p5MWR1SUFqM2pVcEpoOEMrQUxRT2RLRU8w?=
 =?utf-8?B?OWNBY2o4ZVNvYXdxNnBVVEJ5Rnk2cm1NbTIrM2pod0VQQjIvKy8wMVBMM2dY?=
 =?utf-8?B?Q1cwa1RtYmJnN0VFR0FFWHNYMG9mdEN2RVMrQUJtdThrRHVlalFpcUlOWVBy?=
 =?utf-8?B?OCtSK1E0akgxSzg3TXpLRmNkWWJBeDFVMm9NRW9yY256blE4TSszZDJaKzgr?=
 =?utf-8?B?UmYzMnJlOTk0WkJpa1RVb3ZCYWFiMVN5Ym9uYS94VDZnZTVkRElpc1MwdC9y?=
 =?utf-8?B?WU50Y3FPcUplODFhUWZDWExoTUJwZk1YbGRRcGZUT3h0djFnWlk0SXl4R1hR?=
 =?utf-8?B?SEpzV3hWUDA2V09TbTJheVJMTGp1NUI3OG5NSStVT3QydFdOQ1hPVzNkSHNz?=
 =?utf-8?B?eTZLRDg5OHArLzUvMTEwenNOT09Qaitzdis5aWtiajhQWTRZZ1Q3eU9tbDdn?=
 =?utf-8?B?eU8xSDRLcnFjVkNPZno4RXNMOEdtWjNRN09ra3ZlUjlFS3IvV3o2ZmFiNkgv?=
 =?utf-8?B?NktBblBTNmNndW15QmUwUWhwQWV0cmwvSlg5bmg2RjEzUWd5SDlyY1F0alZp?=
 =?utf-8?B?Q3dPMmFmNGlqa0RmWEorYUswNXFpZjNNTzhnaUpkNnl2NjFjejNnMURONXU3?=
 =?utf-8?B?MUF3d1JtcStRRkRwOSt5aGlLQ0lGam1KNnRKcjBZQXVjYkhKWS83U052N2VI?=
 =?utf-8?B?VXhJTzBUaHo5MXdVcmM4UDFETUd6b3lSVTZicnJoZStPS1p2bXVwa05CR1NH?=
 =?utf-8?B?Q0ZmQkRaOUpiME5WSGxWWFJScm5QOEVLc3JDQjFLQnNMQ3VGQVRVaGVtTXI1?=
 =?utf-8?B?Ty8yVUxaQlY2WU84NjRSV3ZudjhpVWdMc0pjaGpCNFd4alhwb3R1ajRLRmlL?=
 =?utf-8?B?SzBCZFVOYTVYZFAwQ0RtdDVpNU9LeU5kY21jaWNLZnpVSHpHV2cvbHErTGdN?=
 =?utf-8?B?cjlBdkpFWWVSWER4dFgrWDBUL0pxekh0R2NvUmMrOWk5eHZEWVpYVWxMNHNr?=
 =?utf-8?B?ZG1BRWRDTnVtR2UyNkNXRjVpL0VsWUpNMXpBYzByaE5PSDFUUTlHbm9kTGdP?=
 =?utf-8?B?ZUNxNkUyTFBnakxmSFJHY1hoU3pKd29XRGU2Zys5c3Q3N3p3TkxFWVBvZEdo?=
 =?utf-8?B?THFZbjNMWmIzQ1pPOE52ZXVXM0wrcnBEa1FHOHhSeW9udGtKdkVHMW1nZU0z?=
 =?utf-8?B?NG94Uk9yS3RJZ0FvNnY0b2RpV3FDUFV2TjBVdkgzMEE5UHFBNzZqTFRrRlc3?=
 =?utf-8?B?Vm01RWVwQUtjVHZLN3BSUXRQL2VxRi9QQjRNVUlvaGRDRUE3MktnRWx5UzI2?=
 =?utf-8?B?QnNKdzFoYnc5WldQRDgwOXZxMHY2QW1OaWdOWmNraWgrdFdIdU02SmdrU1U1?=
 =?utf-8?B?Nmk1dk9DeVhqMFVWaEN3cE5oRUJzM0pZQml3T3VsSGpDS3N0ellMckdlTmw0?=
 =?utf-8?B?dFNXRUU2UEJzNE9lc29xajRmRW43RHRWN3BPZWNINUQwOVhjMHZnMHBTamZn?=
 =?utf-8?B?WDVwNE5sczU2eGUxK2E3M1d2bm9GcnBhQzh5cGkzTUY4Q25JL2pVWUloU2pC?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec8be9e-72e1-422d-1c77-08de2ddc5d59
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 17:42:42.6449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU96bmHR4+NG9BpyDjaGXePNEpXYHasSHbfByWZ2EB6zxJnxs+9jD24fwu6EAt5xbxAh93wQvoIgWBoX/DUlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9402
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

On 27.11.25 10:42, Sune Brian wrote:
>> My patches address master (of two weeks ago at least). Please have a
>> look at
>> https://lore.kernel.org/u-boot/cover.1763140421.git.jan.kiszka@siemens.com/
>> (or https://patchwork.ozlabs.org/project/uboot/list/?series=482132), and
>> if you find something that is changing in the wrong direction, please
>> comment on it. There is at least one known build issue when you disable
>> CONFIG_SYS_MMCSD_RAW_MODE.
>>
>> Jan
> 
> Will take a look more a bit.
> Before that I want to confirm s.t.
> You want all three modes to support combined SPL+UBOOT
> aka u-boot-with-spl.sfp in A2 parition?
> So simply speaking you don't want u-boot.img in FAT?

I want something booting. If I had known earlier that FAT is working and
not generating too large SPLs (e.g. if the default board config had
changed...), I would have stopped using raw mode.

Now, let's assume someone still wants raw mode (and [1] suggests that
there might be cases), the raw sector mode is not so desirable because
it forces you to place the binary at a specific location on the disk,
requiring that to be synchronized with your image layout (such as a wks
file). Given that the romloader happily uses part-by-id, I would prefer
that for the SPL as well. Still, if someone configures another mode,
that should still work (when providing the right magic sector value).

Jan

[1]
https://lore.kernel.org/u-boot/85b3b8a8-fbaf-4e30-a38b-af4299820487@siemens.com/

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
