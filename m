Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DF1E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 06:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA09980608;
	Tue,  7 Jan 2025 07:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c2xp/g/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159DB80609; Tue,  7 Jan 2025 07:39:26 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C17805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws3UKJuggQh7fGcNkzvqkxKbmz8szSxIJfZ6WJabUcyD/Fr4IBFRHG9XqJKo98EvzSB4Pz10a6LEW01zPIua/ZxRKq/TtexgCrh0mBp9zOXazlUrb3zxuxFAx1Mmn6tKW/WohEfTUbWjhttmMKQvB794k2uOltDZzoI1LVBVIm+Quh8hts3DCnxaS029D7Tf1pKWQtTTMqA3VefYHzm0UuqS3AfOtVoG2t22xgtX8gTOIOngSpK1i2/ZBA1O6t8pDTOeYDI2hWifoOXdR3QLficwuyutnc66ha4S8DnTxKeLnn9ztU5+tlWCK4AhVrqrAo4bLA6mPViPBn29+31xQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oR1+/9a+7iQUUHYuyDtBNTu9I9Li9wR8hD/r0cElKQ=;
 b=Kqqcxdt1+YnCpUKzc7thr/f4p8LHVWKuq6CutXP5cAJK09bnjixbb9E4fIrMwBnHPsUnmXYRnRVo+LIdMVqOBEMtMyBaAzhXZvraI8/txI+63n5Mq33Beec3CIqSXK9/d8AGzZtvDwkJfFA1a/L5zq5B12vltr8mMqdy3Qz4XFkp0m4U/PNa+UtgQcwIsQlaVvuXQDrufdR9Jn0pLCTiWSvDh5TaplR3MVBa4qR8XBb0COk3Fom9vmq3TmLs0l8LUSE9hsPY/r9q2sdYZVG2eXd6zwYbq095gML8pP4bYFK00JsPqhdMU8iv0Sj2e2uSZ98I6kKuYI2w34KNnVGLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oR1+/9a+7iQUUHYuyDtBNTu9I9Li9wR8hD/r0cElKQ=;
 b=c2xp/g/nl6V1Cp5GFtvVk8DCGxZ7rkjImKIW0oMEcBLTxjgNSo25QjMUTEFjXMwTqgrRtBVIAUYMqCpXR2Jjq8qN4XxN8aEnZkwxrmvk6tBeEwDXJqZ0aXka/oSxcEZuEsDBp9lophkVp/2G98ml7YW1AcX7DomiabPMlWsEw0jTMvAR8g+VQeFWGg9ClQBUufeM/ZTEA6W0GMJb+j5fElfmyCHkrQtoF0AgG1qZNStj9LdcQWcvvJmuY5rY+mwvTW3B9UepNtQlZbnvMjDhVf3O29E95r4wcRB/HDcJ8S0RYyCz+teE9ib6oEl10D5MERPMNcaiL4/hhBm6sSr1Hg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 06:39:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 06:39:19 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMDMvMTddIHBp?=
 =?utf-8?B?bmN0cmw6IG54cDogYWRkIFNDTUkgcGluIGNvbnRyb2wgcHJvdG9jb2wgZHJp?=
 =?utf-8?Q?ver?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAzLzE3XSBwaW5jdHJsOiBu?=
 =?utf-8?Q?xp:_add_SCMI_pin_control_protocol_driver?=
Thread-Index: AQHbXasmvOyVXe174EyU/5+4gPoS6LMIr8EAgADXYwCAALWJAIAAmeIg
Date: Tue, 7 Jan 2025 06:39:19 +0000
Message-ID: <PAXPR04MB964470D51ACF7CCD08EE87F0E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
 <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
 <PAXPR04MB96440F6976C336998424F176E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <016aa4e5-c33d-4f77-9a12-c218c4123403@denx.de>
In-Reply-To: <016aa4e5-c33d-4f77-9a12-c218c4123403@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PAXPR04MB8704:EE_
x-ms-office365-filtering-correlation-id: e81620a5-c42a-4078-b6e8-08dd2ee6037a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c2d4RFZkMW9CejJOZkU4ek02dGlJdytXSVQ5RWhwYURqcmZyQ2tmVzBKVm5q?=
 =?utf-8?B?QUlBWFNmaEdNL3BOQ3JhSjc0dVV0b21sbmdGUlExcFNhMVBtNGcvaEtxRGNI?=
 =?utf-8?B?TGNqOVVqZHlkSlJhN0pzZmYxMUp4T3U3K21udHgxWWdiRzFNRDRyb2hNZjdJ?=
 =?utf-8?B?TE9qcSt6SHpYRks4TlN0dTE5UmliWGxLd3VzT2xQTWJjMUo5d3BEcVhpaWRs?=
 =?utf-8?B?ZGdKYTJVYTdOWTFuU2drTFM2clFtS21sR2FDM0xEL1lTZXlEZ2dCUDduZ1F4?=
 =?utf-8?B?Z1cydDZYZUNrZjA1SmtCbVR0dnVvUTBsWnpwUmhEWXhKLzh2K3RsN2czc3VG?=
 =?utf-8?B?MnllNDcxTWZxUk9pWHVvS1ZBekRTRTJ6ZGYybDhNeGZ1ZWF3dUZIQkt3TkpX?=
 =?utf-8?B?Nzcwc3ErcGNveGpMWVI4UmFpOEhkeFRrQ3YyODMxekdRR1ljQnZSclZzQjhp?=
 =?utf-8?B?eUZBZ3JDc2lFRmVGZENMdEV4UW1vWjV6QTh1eFFjcU1NeGozVmZZaW1yTzE5?=
 =?utf-8?B?MG9Dc0dyZ1FKTHpaRHNXcmQ4OEFXWmRZODZzV3VLZE9ZcGR6YTNZMithd2dR?=
 =?utf-8?B?TG9yZDM0a0tpY0Q1aXJSWUg5NXl0MVMwa1M3YXpyc24waEg4QXBWTzhETEtw?=
 =?utf-8?B?Ky9UZnlCNFhyTFBVT1oxUlYwQXJFeWVNd0NyMzR5UFlIcGpjQ05Vb1Zsa0hU?=
 =?utf-8?B?K1RCWEpDRGYzQkN0d3V5S2duM0ZVcnlSWEs5cWtPK09uU0Y0TkJvVHg5WkZJ?=
 =?utf-8?B?Tk5iQlZtSHJwMXhqbDFLV2Z4djdnUFYrVXE4TnQ3ZVhyWXAzN29EQnUydlpS?=
 =?utf-8?B?UEkrVmlua1RIU1J3QzRrR01Zam1lTUI1djZTV2htckxrZG4xN3JoUVYwVFJn?=
 =?utf-8?B?MmdFcmxJUzRDT0E0VjRXUFE3SDJtNmQyYzNNUlNLOVRJb1ZyaE5CbDRyL2NG?=
 =?utf-8?B?aGhTOU9Cc2RUZWhkTXRaR2c5MXBwbm9rRHFnYlNaODdSWjVad2F4R1ZHbDRr?=
 =?utf-8?B?VEoxbk9BZWg2VCtUUWtoei9LY2lOZWEyWVljd3QyTWJiU1NNRVlVRTlPZk1N?=
 =?utf-8?B?N3BKK0d3SmFZbE84UUhEUkswWk5JcXVlZDRwa0J3dlZvY2YyZjNoRnFVTVpj?=
 =?utf-8?B?VW40WjYyMllXLzVjb0VjTW1MdG1IMllYNVc0blBSOVgwbXpqQWd2NDFOdVR4?=
 =?utf-8?B?ems3aE1Pa0dtWTZYSUIrYXI1R0FGZ29RUTlKYmdWdTBXcmJ3NGxyeUc4cHRr?=
 =?utf-8?B?OTBrOVM3WVBRRXovWDFvOUorU21neDRhUklZMHd4RE5QR1NnZW41ZjRWVTYw?=
 =?utf-8?B?eFh0aFhxWWJHRGFNa3gxUnZKRjMwQkZFb1NZcWVIcEZSVWV5QmRtS2diMERT?=
 =?utf-8?B?dzZsNVR4RmF3TmpyeGpwbzJPUm92U3Q5bnZTQ0pyVW8zUTVyTUxnUFNMa2RP?=
 =?utf-8?B?dStHYldEQkhlUjArVGRVMVNzYkdYUDBlaDZyTCtnQUhoRlpiNE5rUDhrMzNC?=
 =?utf-8?B?ZDk1T3gva0JhTFptS1p5elpaQXZ1djVRT0hOQ2I4a1NmYkw5K3o0ZUU4bXlJ?=
 =?utf-8?B?L0Zibm5ES1I5ZmJlL2Z1RWxnc1JyaFV4aktkV0dBeStBRFpoTGdHQk4rRmNx?=
 =?utf-8?B?b1NFR3hKQ2FJQ2xnZ0tadWEvLzlGejdCTnJOay9XTU9KQ3F4bmtCSGs3c2Rm?=
 =?utf-8?B?ejBXRE01NDZidDR6emdVSysxMm03ci9NN3ViRG5nbDZBL0N3ZzhYT1pONEFw?=
 =?utf-8?B?NnQzSmR3dDNsQjg4MngrOU9wS3ZRek1nNE0reFJVZTFYaHBHNW1MN1lhbnFK?=
 =?utf-8?B?YWF3aGQ5R1dsSGtseEZmZ1o5aS9CdXE5amIvMGdkTkZxY1l5anhLUDF6WU9a?=
 =?utf-8?B?c1hicyt1SHFSbERUOWRvRnRabzJtRTdhNDlFVDFnRDFrVlYwTUZsZWh5YmpC?=
 =?utf-8?B?S051ZE0rYS9saVU1VENOSVlRMEVQN3N3bjFJRVdIN0VCVk5TRWpicTJVZjNw?=
 =?utf-8?B?Wm1kR0YvYm9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3YxUjIvWktRYjBjRnJFLzZia1N2NmJIZEpOSHVVUUt5Z1dMV3BGZkV2bGxq?=
 =?utf-8?B?MEdpdmFubFhqa3dWYlNYK2tLZVBiUlpKenE5ZkxwV2Z4ZGxuZlZ6ZXRxYjNy?=
 =?utf-8?B?bUo1cUh5eXA4dTk5cXRPeEQ2dTBYcUxXMWFJWEU4ZWpoM3pVOUNRakJLdHla?=
 =?utf-8?B?bXhPYXltVXdXVHhLb2NvNUg4Mk93UnNhc3J4K3htSmp0UEYva3M5ZVljR3da?=
 =?utf-8?B?Ti9zdllZMlJnQjV4TjNVZXRybjRKNGd2Q2krZ0xoc0NWeHdCRjZVd1VTMWta?=
 =?utf-8?B?TWZpcVlCOTM3QVVkNG91R0xTeFJKQ2ZIY3NUenUxMjRsS2xYc1hIVERmT1hu?=
 =?utf-8?B?UFRWaDI5b3o3SHpLb2JSb2ZDdkpmbStWSVdKWUpSYWpBb0lFYnkrT2VXMUpw?=
 =?utf-8?B?YUR4MEpsWUg5RnAxNGl3QnZYbGw0RVdyeVRRQnFGMXg5RTFha2d0K0VSLzl3?=
 =?utf-8?B?RWZmWFd3VnhJTXRiYTNkcmdvSnFhNW5tUms1UzhxREZvYXRaVU5SKzByRXJ3?=
 =?utf-8?B?RnViZm1qK3c5VWhRSDRjaTZoZ2RmZ3RvMkNEbkJhTHpxSWhyNVJlNWlFTXM4?=
 =?utf-8?B?NlV1cHI1ViswYVhpbjFndGdvVFg1WElycnpxRzlXYlJ4amNtUzMzbU5JNDhO?=
 =?utf-8?B?MnhidkpUVlNFcnV5dXZXd1V0RVVxY3hXc0IzRGlHb0liU2RJNHQvNStVYlR3?=
 =?utf-8?B?Z0R1OVVUN09JenM5Qjd1cG01ZkkrckdaT2Z1ZTdaVEtXdjBZMUpQRFIxcmNX?=
 =?utf-8?B?OExmbWhFZ3p3UEhjSVprTnFEeFFkWHczb0F2dC9JRmd3aW92N29yd1laL0JF?=
 =?utf-8?B?SE9zeU90aXptYUpkV25nZ1lQVUxpZ3lpMlNXZ1VWZTh2WXlPTTVWR1U0NzdV?=
 =?utf-8?B?c2tKV2dFWi9FeEEzNmlCM2pDK2RjRXpUbTBVcFNPTmJ3cDFXZjNxYVUvcUs1?=
 =?utf-8?B?OC9qSENUVm9XTG1vZm1yNEo4K1E0S014L0o1VXltRVFTNTg2TU9keFc5Zllo?=
 =?utf-8?B?VWNqMEZCcFNXMHU1dDZsN3JJdmxoMzd2WlV5WWQ1QTB3TEQ0dGFKZHNGeUlz?=
 =?utf-8?B?WjRnOCs3RzNnNTVKaW5mc3A5ZVNueURZTjAyTTlCcEtSd3lYaDAveFZkZ0M3?=
 =?utf-8?B?N1o3algzaWl1VExDNkE4dmZNM1FoaXZiMktXQi9PaTQzUkswSjRhTkhSMU54?=
 =?utf-8?B?WFIzZEVBZGpHQUxka3pqbnFXZ2xhWHg2WVdMeW9SSmo3a09vVTRrUlVnaG1x?=
 =?utf-8?B?VFBreSs0UlpWOGN2TS9Dc0cxODd5OHZmbmtHUSt2cEtiVHVKRjVCcW96cGZp?=
 =?utf-8?B?UzdzZ0c4Q2NzWSswTFVFT0d4NEpQMnhOUjk3UU13RmVBaUlvdXozV2J1YXBu?=
 =?utf-8?B?ZHpOcjRES1BJS09JdFdZdU8va0tvNmpUWVdOdUQ2VFBxSlo5UXhNeXFhV0px?=
 =?utf-8?B?bkdManlsd2JHd3JadEZyUmE0OVB4WDRiTy9NbmY3QTcxSWs0TDgwQURibmJP?=
 =?utf-8?B?cHAwYmsvaDljdGRtKzF1dHZlRTVkNDRLeEFScEovclkzTHB1MFZpM3p3ZWV0?=
 =?utf-8?B?a2w2OHMyeEprLzFPdkxtRnlvQkhKUndPM05tOWc4U2RQc1k0Wm5xUmQzcUVy?=
 =?utf-8?B?aXZsaHM5bzB6bm9kekVEbVM3YS90RTkvMjRjWEJENWdveHVlMkx0WVVnY1Jl?=
 =?utf-8?B?c2NDSm1FakZzNXc4ZExJOTA0OFQvdnhad1owZE93R1FJc3NPcEpkMGcrcEQ1?=
 =?utf-8?B?dEhlcnZLdzlTYWpvWmloc2hqK25sR0haYUYvaUhpQ0lGUFF3V3paN0JJaDAx?=
 =?utf-8?B?OEZMRTY1K2dqdzFaVXY5VE4yL2IzRzVTbFNWTG5aalJpR21EYjZvYWpieTBU?=
 =?utf-8?B?Vy9KdTV0ZW5TMHNNVWIxWGxoaGZCMzZZL2J2dzZqUFA1QVQvNFExR2lDN1p1?=
 =?utf-8?B?Nm10K0FHRnZOT1lsaHJ0ZTN6cituR2JlM1JDRVRtbnltY3o3eGZQYmJKYytG?=
 =?utf-8?B?WlN2U3NKbXNZU1Z5NmoxTHMyVEMvSGxWclp2WDM2Z3ZTMXNvY2Q5K05tUW9m?=
 =?utf-8?B?Z1l3R3BmQjVEQUJjbWFkaWVHcjJqOGN5SFFPVEUyM2Z0N2pnNHMvWWhTVDhB?=
 =?utf-8?Q?fgnngWUIe399e+i3HcQh8+qhj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81620a5-c42a-4078-b6e8-08dd2ee6037a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 06:39:19.1609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muHEB6NRicV4MBZ2tTv4HcfMgDvV/HXob9WoOtEjXl8BQ4FZ8kdnI2vYZpHohexPFrxBNmoanSz64M4lIQ6eKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIg35pelIDQ6NDYNCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPg0KPiDmioTp
gIE6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IFBlbmcgRmFu
DQo+IDxwZW5nLmZhbkBueHAuY29tPjsgUmFuamFuaSBWYWlkeWFuYXRoYW4NCj4gPHJhbmphbmku
dmFpZHlhbmF0aGFuQG54cC5jb20+OyBZZSBMaSA8eWUubGlAbnhwLmNvbT4NCj4g5Li76aKYOiBS
ZTog5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYzIDAzLzE3XSBwaW5jdHJsOiBueHA6IGFkZCBT
Q01JIHBpbiBjb250cm9sDQo+IHByb3RvY29sIGRyaXZlcg0KPiANCj4gT24gMS82LzI1IDEwOjU2
IEFNLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4+PiBUaGlzIHBhdGNoIHByb3ZpZGVzIGEg
ZHJpdmVyIGZvciB0aGUgU0NNSSBwaW4gY29udHJvbCBwcm90b2NvbCB3aGljaA0KPiA+Pj4gaXMg
YmFzZWQgb24gQVJNJ3MgU3lzdGVtIENvbnRyb2wgYW5kIE1hbmFnZW1lbnQgSW50ZXJmYWNlIChT
Q01JKSAzLjIuDQo+ID4+PiBDdXJyZW50bHksIG9ubHkgdGhlIFBJTkNUUkxfQ09ORklHX1NFVCBj
b21tYW5kIGlzIGltcGxlbWVudGVkLg0KPiA+Pg0KPiA+PiBXaGF0IGlzIHRoZSBTQ01JIHByb3Zp
ZGVyIGZvciB0aGlzIHBsYXRmb3JtID8NCj4gPg0KPiA+IEhpIE1hcmVrLA0KPiA+DQo+ID4gU3lz
dGVtIE1hbmFnZXIgd2hpY2ggcnVucyBvbiBNIGNvcmUgc2V0cyBwaW4gb3IgZ3JvdXAgY29uZmln
dXJhdGlvbnMuDQo+IFUtQm9vdCBzZW5kcyBhIFNDTUkgbWVzc2FnZSB0byBTeXN0ZW0gTWFuYWdl
ciB0byBwZXJmb3JtIGhhcmR3YXJlDQo+IG9wZXJhdGlvbnMuIFlvdSBjYW4gcmVmZXIgdG8gdGhl
IHNvdXJjZSBjb2RlIGZvciBkZXRhaWxzOg0KPiBodHRwczovL2dpdGh1Yi5jb20vbnhwLWlteC9p
bXgtc20uDQo+IA0KPiBDYW4gSSB1c2Ugb3B0ZWUtb3MgYXMgYSBTQ01JIHByb3ZpZGVyIGluc3Rl
YWQgPw0KDQpZb3UgY2Fubm90IHJlcGxhY2UgU3lzdGVtIE1hbmFnZXIgd2l0aCBvcHRlZS1vcy4N
Cg==
