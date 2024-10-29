Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1B2D5B166
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 08:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F44D8910C;
	Tue, 29 Oct 2024 09:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="DfNDzlDG";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YSTG3VlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81258912B; Tue, 29 Oct 2024 09:26:41 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036258911E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 7e60a0a295cf11efb88477ffae1fc7a5-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Xg3Z/sqQy9Yi3eyAS88RpVeK0REA2oxaWpyze1WU3bA=; 
 b=DfNDzlDGYzctCjXOZNcqfAYZK4Y0RA52GfN57hyfWuxkpnO1K3ScpBslehU6MQzkQK3N2a89JcBMJYHFTi07nCPIGR+3tQRSJ8KBeVSa5bPfcytR9kXMwsQn29MphnfR0uPywf+/c/F1fE7K9678AhY0PuM/DoCvydEZMHaMDS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:ae7b03c8-329f-41ca-a62b-7d5d99698020, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:7c8439e7-cb6b-4a59-bfa3-98f245b4912e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7e60a0a295cf11efb88477ffae1fc7a5-20241029
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1534133961; Tue, 29 Oct 2024 16:26:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Oct 2024 16:26:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP
 Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 16:26:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj0URX70b0faI+kLdHqtdt36nMcjHAiUa6hUZeIPCJ5Mm47ZedDA6NHZwtGkD6C5GhXXcyc3+3pchyu7nFJXwqdY57NHinGFXs/Ch8dYXkTit1Rkpo8DMdLjkfhxcf8c9qyAqRs2GbbhFmxdAsePOuD9YjAuA9TZTpz+TFhydaBCF1AYeY0l6TPqbFVObaTgabUWfLpI/UZO6mpNkHaG4QcZgUoVNnph/EGN9ymEZ5zDkh8Cv/N7Q8Sq4AOxl/oUp4zc0ZheDZn1Ns3JNsGDgcughwT1ksB3Ky86SV2i4PmLmjspGEZCDtr43FqCbMM7FWnUo78W4JGeBhSBrWs4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcHSpFxCUsWxAuK+pBDvsZQsFwN2JeQm4Sz8+2XsWVY=;
 b=InxyXjrQvNzWUiVizNQ/lByQngeJ3w+1p7wByvFO7sONI/lnt9lxHsOVzzszJycFebMNEoYEBndyZKWEud0/+oUCGWeUJ3Sp1aBoaez928n6ut9gh+ERNuPnNdFik4YqooVddOpQhVY29M5uS2JMiliYvgkfZVYZPx5SSI+mt/+JFFQjg3XqTOw+1QrP17VowKcqyxkPSRxpL/kS3ngk130t4iEpAlY/J0sClf24DJ78pslVeHkot7ginQNNixbqnTVaSZYElmgZ7/yCVtADsJld8egf8QECpZgo7aicvwwUxeDnl8cJiwooSWyL/fNwdbsPamAwllx8K44bpu1ezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcHSpFxCUsWxAuK+pBDvsZQsFwN2JeQm4Sz8+2XsWVY=;
 b=YSTG3VlCEBKJCMqCPLkrl+I9ywne1HY7XBzvoCGx6jsStpCMTfnaA6nlAs5gS2BOfDadQghOXxlkjb4XmeHr4Bj4/9NhSeZJvBU2JAipfH+WCSYi4DlHKCSd/d/QI6KEpP9H/fvlNuZwaFSan4ShBf6cmtKSGad4p6lyET3A91s=
Received: from KL1PR03MB8218.apcprd03.prod.outlook.com (2603:1096:820:105::8)
 by JH0PR03MB8841.apcprd03.prod.outlook.com (2603:1096:990:a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:26:24 +0000
Received: from KL1PR03MB8218.apcprd03.prod.outlook.com
 ([fe80::a65e:15c9:c41b:4a31]) by KL1PR03MB8218.apcprd03.prod.outlook.com
 ([fe80::a65e:15c9:c41b:4a31%4]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 08:26:24 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "trini@konsulko.com" <trini@konsulko.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "john@phrozen.org" <john@phrozen.org>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
Thread-Topic: [PATCH] menu: fix the logic checking whether ESC key is pressed
Thread-Index: AQHbI1Qc/7cmqcO2FESOgLR8N0abpbKZclyAgAHm3wCAACPAgIAABsYAgADriwCAAQKEAA==
Date: Tue, 29 Oct 2024 08:26:24 +0000
Message-ID: <e3ddc242448e434e9561f9fff6a021e6d03733b3.camel@mediatek.com>
References: <20241021005642.153511-1-weijie.gao@mediatek.com>
 <Zx1Bpb7_9TEqBeyB@pidgin.makrotopia.org>
 <37e445c29de0c1ef020d56a7d4da2916d692545b.camel@mediatek.com>
 <d00691ed-815e-4db9-b5d7-b09c32ead593@mailbox.org>
 <6db33dd28da63dabc198788f28bfa00425d7f62e.camel@mediatek.com>
 <CAFLszTgb2KZfX1GnbMee9fVani9aOt8ex_AqoszHTjiq_96Yvw@mail.gmail.com>
In-Reply-To: <CAFLszTgb2KZfX1GnbMee9fVani9aOt8ex_AqoszHTjiq_96Yvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8218:EE_|JH0PR03MB8841:EE_
x-ms-office365-filtering-correlation-id: 77c34ab3-a0cd-455e-c9df-08dcf7f36010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MUU3TzltbmVvU2RIOHZFMTVxK25XQmxmdXFNY1BwSFBnT3M0dE5PWCtsZWV5?=
 =?utf-8?B?cHhkeTdhK1ZDd1Y3N3VodmFwb09RblBHZHV1RUZObDNpL0NhaDFMcXUxZUFK?=
 =?utf-8?B?N0lOM1REMG9IM3NZRHFzdmE4WkxrRERnOGdPWStWWVZFV1k4bVFmcFljWG9C?=
 =?utf-8?B?NlFubEh5b0NHdUgwNkI4V29LRC9CMDN0OWxwdzRXSHRXMnVTM1c5M296ZEND?=
 =?utf-8?B?NXpjNUdFMzB5bDh5TWErWk5YUW1MNTd5dVg3RFNTTnVTRHl5MkpNVzdHL3ZB?=
 =?utf-8?B?NnlrYzB5blhhd25odS8zWk8zditrQWJuNkpyS1hWVld1a0lLalFqZnJPNFQv?=
 =?utf-8?B?eWt3dlJHd0ZvQW5PQzRyTU5iWFlOazRoZnF1SElsWDd2cHF1c3dMR05xRGFo?=
 =?utf-8?B?M3F4eFdNZ3VHaVFqeXVGQ3F0bDlKVXVOZzRPZCs3YnhLc3FKbURpMmhxTVRT?=
 =?utf-8?B?T2lXb3FSbWlLb2EzSTgrOVBQQVV5WTV1by92QlFzZ3FoSzdsclFRQlhRemJI?=
 =?utf-8?B?ZFp2ZTBXb1FsbXNWME9ZWXQ5dTUwOTVWUEUwb1oyNkdpdVFkTVdYWENJV0l1?=
 =?utf-8?B?MXlSSVFwY0ZWaUJ0amZNbWltVmNTclp0M0pGNGRqRUQrUXJ6MGpwWStSMlZU?=
 =?utf-8?B?aUcxMzNKVG8vZVdUcEx3bTgzRjVrVDRMY09JZmUxNE1RYklyTTIrbmtkRjNM?=
 =?utf-8?B?UFBXUlk3aFZnT2VBVUxla1hod2FNd2M1dDlya2NwNWRSZ0M3QXROTkEwcWR6?=
 =?utf-8?B?eTUvZFJoMjcrTnhVZ3RSR0MwMmEyYjRUR0hHenZsaTlvZE1BRVpJV0ZSMkRP?=
 =?utf-8?B?WnMzUGp2cE1uc3paT2xjU3FEQnJJanZjL3VtTGhFa01YMDhFM1g0VmVHRngr?=
 =?utf-8?B?R1FGTGw5aXhkckpwc2RCMDJlblFsQ0xScEhuWHpXSDZUTVRLSkxxR2haL1FZ?=
 =?utf-8?B?UlFSS1hsT3l2THkwWjdsQVVBM2E2c29TYVNSZzNJR3NscWpJZGl0VU5SSzJa?=
 =?utf-8?B?Zjc3WnZoam1FRGxGeHUyWSt0R3JYUm9SMWx1ZHEzTmRaZEdtcFdRa0poQ2N6?=
 =?utf-8?B?V0tKckhEQ0tmVi9TL3BjOFN2M2ZhcWhmRXFNVFFXdGpoSUtVcGxnNHZXODVn?=
 =?utf-8?B?b3c3MnR3Q2tmbmJHa2Y2djZBZEVKalJpN1lHWkgzM2dOTXo2bGZ2am9aZ2Fl?=
 =?utf-8?B?aWVPMFVGOWlzZWUzV2lvWGtEbDZpUGcweVU4NG94R0JleC9Pb2lzOEl1N0Z4?=
 =?utf-8?B?czlzajhWYWNTbFErbXFRdFp1YWJSRkdkNGZxY3FIS3VodVVWb3JCei9kTEJ5?=
 =?utf-8?B?WGh1SEdyelRvODFiTDl0ckwwSEtJandtMFZmL3R4b004UmVXdHNRY05SQ3Ni?=
 =?utf-8?B?WmhUR1N5bGozZzgzWXRCVk82aFN5UlhUajBod0ZXQU04OHJmSHBjM0NWQ0px?=
 =?utf-8?B?MklDT1NwTzFkWHk1U3B5QTI3WlJHTjdOa3Boejh4MXl2Qlo1a1lXWHV6YkJa?=
 =?utf-8?B?Y3E3Sk1JRVFGNTJvOFdiS3lzamwvVVcwd2FjaWQwTWVZVkJ0MWQ1dUlsbHNo?=
 =?utf-8?B?MSthbmVSa1pHVlhIQjZON1ZCakNncEtnMm1Vc0Q4dFRFNjUrY3dOeFJvaVdT?=
 =?utf-8?B?aXZEOHE0YWhIQVVjekdhbzN3c0I4Wjc2TmlzbTFGc2JnOTBIay93OFVVbWxE?=
 =?utf-8?B?Z1VnL0FzTmF0L0NXK3ZFdlJueTBNNlU5S20ra3VDS2M2SGtBQXZWVG4rRi9j?=
 =?utf-8?B?TVlIUFg0NVBmR3NOdmloZktlTEpWSGdPZGV1NzNPMG1mYVRoYTA2dWhxT1Zp?=
 =?utf-8?Q?+W/uR15+a2+4uvoNbM1yQrJO2vdhNIu8WVKgI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB8218.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2kwRFlsWjNZUXpIdExjbjBQSzFlR3YxK3BjSktjUkFhV0hSZDMyVUF6R055?=
 =?utf-8?B?L2RueVdmQzk5TVBWbWV4VmRxSGE3UUtSZUQ2RmNjN0M2MUFlc3B2eXU4dHM2?=
 =?utf-8?B?Zm5YUVB6YzFGWkY2MlJSMDZLdThjb3psZ2ZrU29DR1I5dUY0ZXh1MkNFMWk4?=
 =?utf-8?B?TFBiY0ZVS1hFVGdFdVhUSXpHZlNrRy9ycTk0NnhFcHE5U1NlcGRETnU4VUtY?=
 =?utf-8?B?N1BPVCsvWjJXMlhQK2xTMEFzb09nNlYrTnJjZkVDb2FYbU15M0FPUGx2NEJH?=
 =?utf-8?B?ZmVlVXcrdlRubFhmdWptVDZWaWZETzNpUGk1UHdDeDFOQlZITnpub0NJcG5F?=
 =?utf-8?B?QXF2dlhlMjBiUDJYZ2JuNlhhbDRRd3U5c1dHOFhRQ0V4cmRUN2xRZHZmOVl4?=
 =?utf-8?B?d01IWi90Yzl1elZWSVZSOXdYS0hTNWJ6UVZnQ2xuWkRyakVPNWVZZGJqSVVu?=
 =?utf-8?B?SDdiVTV4aFBhQjQyQ0RPM0ZzbnBWYXRYR1V5aGVGR3RaVi9YMlpkMG44U0Z2?=
 =?utf-8?B?d042M2xYakNWcGkrNDA4a1hOKzF4Q3pFWEZPTmlnVHRkV2NuOTNCWGwzT04w?=
 =?utf-8?B?MDV5NFhmUnkwczV4TlduZ2lHbVdxZzRGenJlR001T3hZa1BMZER5TFBLUG5D?=
 =?utf-8?B?WjQyQ1U2dGREUlJ0VTRMZ3orZFZxSm1ycElOUFhsOVFZcjZYdW9Qc2ZVSFdz?=
 =?utf-8?B?SU9EZmRPMndZYnlFVlRRb3ZKMUtWOXRIcThKcmdKK0s4V0RudzdyemhQbDR6?=
 =?utf-8?B?UW1xbitLT2dqNUxOV1lNUlUzMWJVWldYL0NoMXNhSUJZOVlNUiswVjg0ZzIr?=
 =?utf-8?B?d0JXY2dabVpsU0VoaE5XVCtTMkE3czRuTVJ0OFVUakEvR2h5WnNaZ1JuYzlq?=
 =?utf-8?B?dG9HNUtiay9jK2J1dkh2Mm1YV2c0NWhTWmI5d1lWU1hGeXJnaGdNT2x3WGxx?=
 =?utf-8?B?MHNwUFkxUXN2YnJEc2VXQlYwcW5PcnQvcEE1V2h3ZWgwbXpkY2lJZ1RQVENR?=
 =?utf-8?B?cjk4dVI4bWJWbGE5a1dWb0JmMVA2S0F1SWFhNHg3VCtVRHpwTzV0eGk1S08z?=
 =?utf-8?B?VW50c0FJT0QzRkZoazZSc3M5L0Vabjl6eWhrRnV0V2NJOG5sem1wOHhSeVE1?=
 =?utf-8?B?WjJubGpZbFBpMHpNRzNBQU14R1o3Vy9pNU9EcStYSVI2c3VVUjBMR1M2TXlx?=
 =?utf-8?B?b1hJYnFXWHJ6Zk50dUdqQ0RoRUVUSTArc0pzQ2UrZjdrSTZabktFT0pqYzVy?=
 =?utf-8?B?Y05qb1c3RzZwM2poQjQ0OTdRKzlPd3poRzdyY1NnQkd6ZFhHU295aVlDUk1v?=
 =?utf-8?B?NWJ1bWJ6MHZIMXJIVGFPU0NOd2Vvc3VVWlZFOUxGTUVIbEg3L2pHK0NmejJm?=
 =?utf-8?B?S0NDLzkraVRwMVdtNmFPUGk0WDZkRk9RZmw3U2YvUHRZaXY1VzNpbzRXMmZ4?=
 =?utf-8?B?bEdtZDhwWW5ybGZ4RUQzelJrZjZpZVU1andmM01rdXFRR2YxdFlBb2RUa0Mw?=
 =?utf-8?B?R05RYkZ5d1hHWERSaXVuTmE4R29BbDdRamlHSzFVdGo4SHcza3I0TGYyclFz?=
 =?utf-8?B?ZE5kWGtkcjlXd21pYUwydDV5NUx5RW5wTlRDcjB6RXBmUlBJUU1CZEhubUtW?=
 =?utf-8?B?cFRPSFFNdlpoQVdzRmhDWWhqT3JDaDNaS1dqQVovNHVGb3lUbHpMUUQza2oy?=
 =?utf-8?B?SkdyRXFMUGpvbXZSNGFMRXdKWnpyQTU1VFd4Nyt5N2kwRXZzM0RVRkRHbnF3?=
 =?utf-8?B?NDBIMVRTT2FLUlZ6SVVwNWo0Ly9iVkk2YmpSUjFkNlI4WlBaRUU1SHA5d3Rs?=
 =?utf-8?B?NHp0bVhJTHVCb1FBOWdwczF6RnNoOGFUKzFWem1XT2p0S0lsbHNuRDJ6amRP?=
 =?utf-8?B?WGZBL25ZU1RLWlY5UW4xM1l2b2xaZmgwcTRqNzFxN0FnQUZDcUluam9KYW1s?=
 =?utf-8?B?M3pwM2t6aCtGMXBaMll6SVM4emtNd3dUNFRjZXc5b2ozVmsrSGZhdloyNlJQ?=
 =?utf-8?B?Q2MxaXJ5dFB3ZG90eDNlMDRTRUdPMVdEREhkb2V2dW1hUnV3dmNNWUVLckxu?=
 =?utf-8?B?UTYrVG4reVNNUG9GVU9OZFN6RWwrZkQva2FpdUhnOFBOZUJHaWxUZmZCY2gy?=
 =?utf-8?B?dmNEdmVQWEdLbkp1WlU3YXBQMXlGWWVuZ0trZFlWVDhIUFpadGpBOWxMdnNy?=
 =?utf-8?B?MXc9PQ==?=
Content-ID: <059FE4927475994E993A455984395138@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8218.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c34ab3-a0cd-455e-c9df-08dcf7f36010
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:26:24.0344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8p43PMUk61Y2HrKKhSre8AET0mdy7jq7d5DMgrW2V9PT930jNih4TWLm/94zc0dZqZQaK3oha0koezBKTyQK5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8841
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.842500-8.000000
X-TMASE-MatchedRID: H6qdQuiXxKDUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
 WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2dnC5uaS6tb9+Mk6ACsw4JuTcZ41tGho2nL8
 JR8MCnhLbmEaUtQp9EifcoS5xQH/muqsgUgnAn2KzLD5kmcW6ZDNrbNX6yPHqAOrNpiFyN5Dh6G
 rcyygpTkODM471uy7qWfNBkb3T5obrbEGb+5Q/ecpQKjU7fBXVd0/IMHz0evm0rcU5V/oSe4Fof
 8aeC04NoTe4jUH267mIgcHkI0jC25G468S7yeiwQpxiLlDD9FVOHr6ExN5jueuW0oQOq5PRO/+s
 JvtVqBmtPt9XOJHN934cqmkDD+zhYWmIaSiXIWhHpZCc205uwq8L2QBUOjnD90btya4ycShDvm8
 qZB53wgpziWOou199QHW+lj71CDgZ7Eu9TqPx8FVN8laWo90MD/zRrejaXNKbKItl61J/yfmS+a
 Pr0Ve8oTCA5Efyn8CNo+PRbWqfRJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.842500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 22304C6FB5795A77620E9203EA0627F487011F690A7CE8CFD8032CECFE8E65D92000:8
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

T24gTW9uLCAyMDI0LTEwLTI4IGF0IDE4OjAxICswMTAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IEhpIFdlaWppZSwNCj4gDQo+IE9uIE1vbiwgMjggT2N0IDIwMjQgYXQgMDM6
NTgsIFdlaWppZSBHYW8gPHdlaWppZS5nYW9AbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IE9uIE1vbiwgMjAyNC0xMC0yOCBhdCAwMzozMyArMDEwMCwgTWFyZWsgVmFzdXQgd3JvdGU6
DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gMTAvMjgvMjQgMToyNSBB
TSwgV2VpamllIEdhbyB3cm90ZToNCj4gPiA+ID4gSGkgRGFuaWVsLA0KPiA+ID4gPg0KPiA+ID4g
PiBPbiBTYXQsIDIwMjQtMTAtMjYgYXQgMjA6MjMgKzAxMDAsIERhbmllbCBHb2xsZSB3cm90ZToN
Cj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3Blbg0KPiBhdHRhY2htZW50cw0KPiA+ID4gPiA+IHVudGlsDQo+ID4gPiA+ID4geW91IGhhdmUg
dmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSGkhDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBNb24sIE9jdCAyMSwgMjAy
NCBhdCAwODo1Njo0MkFNICswODAwLCBXZWlqaWUgR2FvIHdyb3RlOg0KPiA+ID4gPiA+ID4gSXQn
cyBvYnNlcnZlZCB0aGF0IHRoZSBib290bWVudSBvbiBhIHNlcmlhbCBjb25zb2xlDQo+IHNvbWV0
aW1lcw0KPiA+ID4gPiA+ID4gaW5jb3JyZWN0bHkgcXVpdHRlZCB3aXRoIHN1cGVyZmx1b3VzIGNo
YXJhY3RlcnMgZmlsbGVkIHRvDQo+ID4gPiA+ID4gPiBjb21tYW5kDQo+ID4gPiA+ID4gPiBsaW5l
IGlucHV0Og0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gICAqKiogVS1Cb290IEJvb3QgTWVu
dSAqKioNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gICAgICAgMS4gU3RhcnR1cCBzeXN0
ZW0gKERlZmF1bHQpDQo+ID4gPiA+ID4gPiA+ICAgICAgIDIuIFVwZ3JhZGUgZmlybXdhcmUNCj4g
PiA+ID4gPiA+ID4gICAgICAgMy4gVXBncmFkZSBBVEYgQkwyDQo+ID4gPiA+ID4gPiA+ICAgICAg
IDQuIFVwZ3JhZGUgQVRGIEZJUA0KPiA+ID4gPiA+ID4gPiAgICAgICA1LiBMb2FkIGltYWdlDQo+
ID4gPiA+ID4gPiA+ICAgICAgIDAuIFUtQm9vdCBjb25zb2xlDQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICAgUHJlc3MgVVAvRE9XTiB0byBtb3ZlLCBFTlRFUiB0
byBzZWxlY3QsIEVTQyB0byBxdWl0DQo+ID4gPiA+ID4gPiA+IE1UNzk4OD4gW0INCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBBbmFseXNpcyBzaG93cyBpdCB3YXMgY2F1c2VkIGJ5IHRoZSB3cm9u
ZyBsb2dpYyBvZg0KPiA+ID4gPiA+ID4gYm9vdG1lbnVfbG9vcDoNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBBdCBmaXJzdCB0aGUgYm9vdG1lbnVfbG9vcCByZWNlaXZlZCB0aGUgZmlyc3QgRVND
IGNoYXINCj4gPiA+ID4gPiA+IGNvcnJlY3RseS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBI
b3dldmVyLCBkdXJpbmcgdGhlIHNlY29uZCBjYWxsIHRvIGJvb3RtZW51X2xvb3AsIHRoZXJlJ3MN
Cj4gbm8NCj4gPiA+ID4gPiA+IGRhdGENCj4gPiA+ID4gPiA+IGluIHRoZSBVQVJUIFJ4IEZJRk8u
IER1ZSB0byB0aGUgbG93IGJhdWRyYXRlLCB0aGUgc2Vjb25kDQo+IGNoYXINCj4gPiA+ID4gPiA+
IG9mDQo+ID4gPiA+ID4gPiB0aGUgZG93biBhcnJheSBrZXkgc2VxdWVuY2UgaGFzbid0IGJlIGZ1
bGx5IHJlY2VpdmVkLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEJ1dCBib290bWVudV9sb29w
IGp1c3QgZGlkIGEgbWRlbGF5KDEwKSwgYW5kIHRoZW4gdHJlYXRlZA0KPiBpdCBhcw0KPiA+ID4g
PiA+ID4gYQ0KPiA+ID4gPiA+ID4gc2luZ2xlIEVTQyBrZXkgcHJlc3MgZXZlbnQuIEl0IGRpZG4n
dCBldmVuIHRyeSB0c3RjKCkgYWdhaW4NCj4gPiA+ID4gPiA+IGFmdGVyDQo+ID4gPiA+ID4gPiB0
aGUgMTBtcyB0aW1lb3V0Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggZml4
ZXMgdGhpcyBpc3N1ZSBieSBsZXR0aW5nIGJvb3RtZW51X2xvb3AgY2hlY2sNCj4gPiA+ID4gPiA+
IHRzdGMoKQ0KPiA+ID4gPiA+ID4gdHdpY2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgcGF0
Y2ggaGVscHMgdG8gZml4IHRoZSBwcm9ibGVtIHdoZW4gZGVhbGluZyB3aXRoIHNpbmdsZQ0KPiBr
ZXkNCj4gPiA+ID4gPiBwcmVzc2VzLiBIb3dldmVyLCBhcHBhcmVudGx5IHRoaXMgaXMgbm90IGVu
b3VnaCB0byBmaXggdGhlDQo+IGlzc3VlDQo+ID4gPiA+ID4gaW4NCj4gPiA+ID4gPiBhbGwgc2l0
dWF0aW9ucy4gSSBzdGlsbCBtYW5hZ2UgdG8gZHJvcCBpbnRvIFUtQm9vdCBjb25zb2xlDQo+IHdp
dGgNCj4gPiA+ID4gPiBhbg0KPiA+ID4gPiA+IGV4dHJhICdbQScgd2hlbiBzaW1wbHkgaG9sZGlu
ZyBkb3duIHRoZSBhcnJvdy11cCBrZXkgZm9yIGENCj4gd2hpbGUuDQo+ID4gPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4gSG9sZGluZyBkb3duIHRoZSBhcnJvdy11cCBrZXkgZm9yIGEgd2hpbGUgY2Fu
IGNhdXNlIHRoZSBQQyB0bw0KPiBzZW5kDQo+ID4gPiA+IGxhcmdlIGFtb3VudHMgb2YgZGF0YSB0
byB0aGUgVUFSVCBSeCBGSUZPLiBTaW5jZSBmaWxvZ2ljIFVBUlRzDQo+ID4gPiA+IHVzdWFsbHkN
Cj4gPiA+ID4gaGF2ZSBvbmx5IDMyIGJ5dGVzIEZJRk8sIGl0J3MgdmVyeSBlYXN5IHRvIGNhdXNl
IFJ4IEZJRk8NCj4gb3ZlcmZsb3csDQo+ID4gPiA+IGFuZCB0aGVuIHlvdSdsbCBzdGlsbCBiZSBk
cm9wcGVkIGludG8gVS1Cb290IGNvbnNvbGUgZHVlIHRvDQo+IGRhdGENCj4gPiA+ID4gbG9zcy4N
Cj4gPiA+ID4gSSd2ZSBhbHJlYWR5IGNvbmZpcm1lZCB0aGlzIGR1cmluZyBzb2x2aW5nIHRoaXMg
aXNzdWUgYW5kIHRoaXMNCj4gY2FuDQo+ID4gPiA+IG9ubHkNCj4gPiA+ID4gYmUgc29sdmVkIGJ5
IGluY3JlYXNpbmcgdGhlIGJhdWRyYXRlLg0KPiA+ID4NCj4gPiA+IERvZXMgQ09ORklHX1NFUklB
TF9SWF9CVUZGRVIgaGVscCB3aXRoIHRob3NlIG92ZXJmbG93cyA/DQo+ID4NCj4gPiBDT05GSUdf
U0VSSUFMX1JYX0JVRkZFUiBjYW4ndCBmdWxseSBlbGltYXRlIHRoZSBvdmVyZmxvdy4gSSBjYW4N
Cj4gc3RpbGwNCj4gPiByZXByb2R1Y2UgdGhpcyBpc3N1ZSBieSBob2xkaW5nIGRvd24gdGhlIGFy
cm93LXVwIGtleSBmb3IgbW9yZSB0aGFuDQo+ID4gMTUgc2Vjb25kcy4NCj4gDQo+IElzIHRoaXMg
ZHVlIHRvIHNlcmlhbCwgb3IgdGhlIGRlbGF5cyBjYXVzZWQgYnkgZHJhd2luZyB0byB0aGUNCj4g
ZGlzcGxheT8NCj4gDQo+IElmIHRoZSBzZXJpYWwgYnVmZmVyIGlzIGFsd2F5cyBmdWxsLCBvbmUg
b3B0aW9uIG1pZ2h0IGJlIHRvIGRldGVjdA0KPiB0aGlzICh0c3RjKCkgcmV0dXJuaW5nIG5vbi16
ZXJvIDEwIHRpbWVzIGluIGEgcm93KSBhbmQgZGlzY2FyZCBhbGwNCj4gb3V0cHV0IHVudGlsIGEg
a2V5IGlzIG5vdCBwcmVzc2VkIGZvciAyMDBtcyBvciBzby4NCj4gDQoNCkkgY2FuIGNvbmZpcm0g
dGhhdCB0aGUgaW5wdXQgZGF0YSBncm93cyBmYXN0ZXIgdGhhdCB0aGUgY29uc3VtcHRpb24NCmZy
b20gYm9vdG1lbnUgKG1haW5seSBkdWUgdG8gdGhlIG1lbnUgYmVpbmcgcmVwYWludGVkIHRvbyBm
cmVxdWVudGx5KS4NClNvIG5vIG1hdHRlciBob3cgbGFyZ2UgdGhlIGJ1ZmZlciBpcywgRklGTyBv
dmVycnVuIHdpbGwgZXZlbnR1YWxseQ0KaGFwcGVuLg0KDQpBIGxvbmcgdGltZSBrZXkgKHVwL2Rv
d24pIHByZXNzIHdpbGwgY2hhbmdlIHRoZSBhY3RpdmUgbWVudSBpdGVtIHRvDQplaXRoZXIgdGhl
IGZpcnN0IG9yIHRoZSBsYXN0IG9uZSwgYW5kIHRoZW4gdGhlIG1lbnUgZG9lcyBub3QgbmVlZCBh
DQpyZXByaW50Lg0KDQpTbyBJIGRlY2lkZSB0byBhZGQgYW4gZXh0cmEgZnVuY3Rpb24gZm9yIHRo
ZSBjb21tb24gbWVudSBwYXJ0IHRvIGNoZWNraWYgdGhlIG1lbnUgbmVlZHMgcmVwcmludC4NCj4g
UmVnYXJkcywNCj4gU2ltb24NCg==
