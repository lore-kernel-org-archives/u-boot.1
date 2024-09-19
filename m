Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990CFCDD56A
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D2788CC3;
	Thu, 19 Sep 2024 04:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CR+1uGk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9A188E41; Thu, 19 Sep 2024 04:38:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B55588CC3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwlsS+168gja5c0WE+XkmtY1rIQQ/U1e12FX7MJ4FFrCtRphPZgVsKGXzFDSkBJF/6eZnMVT1yZJijNtqIAanIc/xZaJJ5wSsz+V5n1HPmg6HNzbvdX9P74Q+2qaqC/MwEv1vzgn2xw0F3jaKOeEZCSKhSSFhunExK1SS9hx7nl/tHU+vE6HyzTL4jhU5740QFx9Byy0yEjas/C7FYcwb+AOFtz6F5kcLDQhILXN41qRoial/eRmMcyey/8Ve456w0t03yw7UoRaDTzhz8nfsO69ioTsjgp2H7JXvHH3x8FYl2n0mHkTvp9l10/z0rtakBRvqbDepTCZUaLhNStfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm21/UofwGok/Zg3IJdt8IPlXseMg0G1BWsBKa9lv5k=;
 b=cYpFg84DaNyuEOjBAkV+3KtD5BM/wJWM5QkwoYvQD7gTLr9AyosZU2Om0WchLVwknKeeiZcy1a7f0rzHia45U9DvccAxpzNTYz+8qmOh23+CgvSqC0oCFgU5J9lKAIkbDIRJ0HbLDC0guVTYNIo3ZsNPpueW/eEFAGJ3NPSDpftqKUFkczc58N1s3TXuwP1UYp7U4vcZGRoVViS+n2G4mSLzdjpdDj9NXvRd+rsjDmlCU/RlHsEXSH2YXe1Gll5/sRlQgQnj9j/EW7mboyLkr8DE4CzbjrL21m3HVBpmuXtkX5xTtcq6V/i6PKz30rfi40Y8UVajRq+JafMcUTAvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm21/UofwGok/Zg3IJdt8IPlXseMg0G1BWsBKa9lv5k=;
 b=CR+1uGk851VYCWefoRzduUvcWNlKNhNCCGMxR/OLmLCi+VPU2kzSw353ZODstb93+81A1K4KdRKkfb0V1N5Nf8ssDRf2TsGyy6N6dQpFFiBMlZCxGep/SddK9n858cNm8QwO8WXv0Qi7PXVufpT7paBU/nocFbBn4Y0Mm0fcipY9xx0DFTOYOuSpwHCS29xDi4aCrcwmh/5p0OeUOsCzVgEu2NMFnG7p2kdGTeUy1VCDJanG9Pfff0c7kpPku1ERKUXIeXolaAfqoinm+m6PMlFurzUoXRNcVR9gcpoi+VjFvk1MbJj1FCLFt7V0CP0+6E8qIGjWGRhgaFcUnDNv5A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7610.eurprd04.prod.outlook.com (2603:10a6:10:1f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:38:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:38:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, Frank
 Li <frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: RE: [PATCH v2 00/21] imx9: various update
Thread-Topic: [PATCH v2 00/21] imx9: various update
Thread-Index: AQHbCijqWv6UK8jlhUKqibn6lTsCB7JeZN+AgAAAnlA=
Date: Thu, 19 Sep 2024 02:38:42 +0000
Message-ID: <PAXPR04MB8459282AEEA486C87029C26188632@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
 <CAOMZO5DEH2DMvz-mw-4PSXY8yZ+-yHq=iRntZze5c_a8CEmkCg@mail.gmail.com>
In-Reply-To: <CAOMZO5DEH2DMvz-mw-4PSXY8yZ+-yHq=iRntZze5c_a8CEmkCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7610:EE_
x-ms-office365-filtering-correlation-id: da89b699-c6b8-47e8-c1c5-08dcd8542d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WlRjRndpSyt1YlYxYnRQL3lCTHBwZTZMZnVhNUUxaVIwUVBwUWp5YTQxZ1F2?=
 =?utf-8?B?RzNELzNCZWFSYVdaeXRRYjNHZ1IyTStMZlBVbjJnQzVUaFgxcE92Wk81aWRI?=
 =?utf-8?B?QjJGNXhxTmg3TUQxZXAzVHRma0xVOUJCbFZrUXYvK3lNYThiOHdyWlNXT1Ny?=
 =?utf-8?B?SCt4SWtFbjBWREhKVjZUdDM3NHIwdEdRK0tNMi9seGFQbGljMm00SThmVjFz?=
 =?utf-8?B?Nmp4MzhFei9kdk5xbnNQQXg1Z1haWmRwMUR4Wi91Vm4wd1Y5Myt6enZTai9K?=
 =?utf-8?B?SkJ1REJVMW1YMHRJanRRV21SYWxXZ2lSeitodUNWWkZCTHU2NGdIS1p3SWd6?=
 =?utf-8?B?bE0zVkZjVUU4LzBidnlrYVExelE5L21ITTNQVVJXVDZYOVpvL1NaT1dkSDN3?=
 =?utf-8?B?QVNQeVpkVGw3VXFDNElmQjUzVHI5YmpxUnJxQVNYdTZmODVHU1Q5TWlNYWRu?=
 =?utf-8?B?RWhtU283a3RiQUVBSGc2cEcvMnR0Smt6SGphZTVMWnBuL0VjVmJMRm1iMlVh?=
 =?utf-8?B?UVU5Z2ZsdXBNb0ljSlZ1bXNHdFJnOFV5VVROZ0g0YWIyQ1RJblZhWHpZU1d3?=
 =?utf-8?B?VUFsNkNSbDVZQWM5c1Y3Yml3MG9lckdxcTZjTkZPeno1K3paSzFXcm9lZnZJ?=
 =?utf-8?B?b0tvalg5QlJVRWZhbmhDYzFUSmU3RWVRU1ZXUjI4ZmFEemZkMU1DSk9MbTFt?=
 =?utf-8?B?NmJjaUxhanIvNTU1dy91eGhEbmppZUp6NVBFT2trMGlsZTQ0NDZkSmV3YnFW?=
 =?utf-8?B?eThwcm9hNGoreFBwdW5vbGtqOE5Cd284enBBcDQ2Tm1QWEdTL3FaRlpqbm00?=
 =?utf-8?B?a2w3VkFEdStNOFhxRmxqSk0weHJ6SG1BYjdxb2tNajV0YUcrdW1zc0R0dCtU?=
 =?utf-8?B?bEozMVJSNW8zQUYrMmNqTGxvZWxoSWhQNTBBZHMvVThZOEt4U096T2VWWDdC?=
 =?utf-8?B?Yk1kV242UkZYQ005ZkJ2WEFmUkZCNzJCSkl0Y1N0VTJybldTc1FWcHA4OFQ3?=
 =?utf-8?B?WjJOejNZNUo1SndDZGxQSnF6TWp3UHh6dVVlRm9xNWtMYUxTakgvKzVLTGhW?=
 =?utf-8?B?TjlaQmNsWnJzNDg3aUMvY1NvZTB1L1Nza3JQSnlnVmEyVFV1SloyT1pyRmVR?=
 =?utf-8?B?c0lNVzBrNVJyNDlTWWFGYU1EQWhaQ3hWbHQxSWFjZmhkS2ViaTMyUUxsbmU3?=
 =?utf-8?B?a1VkNnhlNzNHanJZa2VBR2Jvc2ZYNFVSR2VyamxTLzhxZUlrb3VDeG54Sms2?=
 =?utf-8?B?eHR2NDVCeFRudnFib1RlOTdKMFdvUUxKaHhWYldaZVV1V2UraDBWOEFOYmRM?=
 =?utf-8?B?WVBtbksvUVNxVWpMMmlaeS9raUxtT3dFYi9zVW9pZVRvOE42ZStEMUdxc2VU?=
 =?utf-8?B?b2hpNEhZK1BkQ2hjZ1hSRHlHRVhJZFNzK3BjZmFFQjJWU1VKTGJlZ1hwNFNR?=
 =?utf-8?B?SDY4blhRN2xudWIwc0VRMXUvNzlBRjhOM0lIaFd0NVcybmUvb1FtclA0b2lJ?=
 =?utf-8?B?VFRNaEx3VXlIdmsybG1ubkoxU2NYMW5KVW5MczFvMEFUSHlEZHFqeFdDcFR2?=
 =?utf-8?B?a3FkYVJEcVZXcXdWd25JRm9xZnVFQUVIbFBOUUhQdSsrWGRPTk4rZFhseWx3?=
 =?utf-8?B?ZFo1S3R3SlBQSkFvZ201U2lXaXZlVWtrL0FsQnpuL2thRzNOaDV1SmtkOU0y?=
 =?utf-8?B?RlRhOXdBUXFNamFFd01uT3k2UEp4UkduRDluYWNNWndnbTh3M09KSkhwUjU3?=
 =?utf-8?B?UUZOU0NCTXB1TXFHc2JPcjNPK0FRcVFLamE0T29YeCtwT21Ib1h5T2V6R0Rw?=
 =?utf-8?B?WHJvdnMzaWtzQUhQRUh1cTNzSVIybjVMSUJUdlpYVEVqZDJmQlZCVTlRSXdr?=
 =?utf-8?B?RExoZVZobEJtMHJ1djlMclFhYVl0MGhNS2U2alRTdmZ6aGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NERMOW5vczcyMnNSVkRQem1nTTNMQk1VdzVqOUdGMGVQaGY3YmQ2U1kvSmNV?=
 =?utf-8?B?bTFDT05hMXFiRGhRcDhwS3dnYVI3a2RHaXBUcUZGME9DMHkzTXRGMk1tTk8y?=
 =?utf-8?B?cUZoNEtGRmdrZWVGNFZPSzF1ZEJsUDFWVzNwNkUvYm5MN241dlk4OVlVMTkv?=
 =?utf-8?B?SGZlRS9oeDU1aXY5d2wwRDJjdEtuc3FDenZuSWNWZFhOU1Rad2VMcmVPLzNS?=
 =?utf-8?B?cFh4MXFqUXQ3a2xjUm9YcS9IcnZoRjE5Qkpvell0TVI3cGVXejlkcmFUY1gr?=
 =?utf-8?B?N2FnbmZIMWRVYkIyc1gveGdPQTVmWG9HY2RrODlaTWUvT1E4Mzdnc3lnOEU3?=
 =?utf-8?B?UnNTQWVxc0pjV2NWNHlacytvNGxZY0d1NE9OMjJFOTVMZ2NpdTFZMnZ5a2ww?=
 =?utf-8?B?YUhRNVd3ZkdKbStWVU1vWlAzcjViT05FU1loSWliZGFldnRDeW5ybXpCR3k3?=
 =?utf-8?B?MTU0UVhTTDJlZyt4WUhjQjZWcjROR2YyMjM3cW1Md25FWDA1ZUJZWVVLcmlF?=
 =?utf-8?B?Y0NIK25OdGh1S3c5U1hZbXhUK1o1eDZHS1YxRkNiQ3Y0YTRwSHVad1gvVW9P?=
 =?utf-8?B?eHYzczlTUWErWkM2aGRoQ04vNHA4NUN4RGhldFIzTWdTcFRFbzNWbkk3Zkh6?=
 =?utf-8?B?bnh4b1BhempPTDUvQXZJL1RsT3BBZVpXbStwbWFxaVdPaXVOMHA5cUNNTFZK?=
 =?utf-8?B?K294Q2V4aW1BbUNWci9iRDlmOXJZVFh3ekVyMy84a0UyK3krbDR3RFoxWjBT?=
 =?utf-8?B?cFZOT2ZpTzJaYkRXRHpjTkYweG9ZZ2N2Zms3S3ltR2hkTkZjUFJ3T0pJOTVq?=
 =?utf-8?B?dkc0a1cwTzNEcE9JaDNET0RIeEdIanlNS2hRQ2VZbHllYWozWEVTSjlpMHNs?=
 =?utf-8?B?ZFdKTEI5Qm40WnpNZ1VSTGFlNWVzYkgvN1BOY2tkQndkUWFtaG9sd3hpUUFw?=
 =?utf-8?B?ekVoUm1WRjJSTjdBTVAvYnhOdjBhZWYxL0Rzb2RoMzVBY2k0SS81MWc4bno1?=
 =?utf-8?B?elhGc2k4OFBhQ3ZpeG1jbnFZNXZSQ0lNclZVVEhjQndnTTVJcXdJM0RJR0Uw?=
 =?utf-8?B?TXJQSGsrMEhEK0VMRjNlNnRNS3BSajRubzZjdU1XZVF4TTYzSlRKWGFPTnh0?=
 =?utf-8?B?VnI3bHZiT05waThDanIyTG5GREI0NDZWelJRQzIvSnFJTzROR3A0M21tV1hY?=
 =?utf-8?B?THpSZVdjaVRaRGJYSmM1R3dtZnJ4b1IrRHI5RVc0NDNKcS91Y0dqUWRFanBu?=
 =?utf-8?B?VklpMnVDZWpick1GOU9BdnlnWTk5eGltZnlnZUR5bE1DL1Vac3Ric3JjbXdX?=
 =?utf-8?B?bjIzU1RIT2M2T3lnbm1Db2t1RmlZTnVoR2pRZ1lUOHBRZEcxMkFzWTJPQWRC?=
 =?utf-8?B?ZXAwMDJQaVcxMHB1WnFxU3BkQzFzaTd6THdKcXA3ODFiM0lJYTVaaHZlREEy?=
 =?utf-8?B?S3VJaFFaSEtNUUY2UGdhQjhHbkYyUG1kQzNzWElscUxNQ2V2dTk5ZEZvWUZW?=
 =?utf-8?B?aG1pamJ5RWxJazVBNWJYSEZLRGlHZGNWUVpzMDQxZ1VocC9hS0ZRRVBLdzB0?=
 =?utf-8?B?R2NKSWo3YW54U2xoVlM3Q3FnL3JYWjdWUURDK00xRGhkcVlHNEpNWW1vMWo5?=
 =?utf-8?B?cUxQVTJNTmNrSkZrakVKQXQwR1IvWXdOdWRsVjFKZ01vNDYrZWtOU0JWZURN?=
 =?utf-8?B?QVFKZkFxWWVUOHkyejNEUU82eHVnSlg3TU5INGRpQS9HRmk4ME41dDVIdHk2?=
 =?utf-8?B?Ny9aaFl0TW9JblBRZkVsMnpLK3gzT3MwOHJPYlIvWmx6TmpYYXhSVXNUSFlh?=
 =?utf-8?B?S3JaTEhRNlhHbHcyV25FSmlLaVA1RURJN2N6a0QzQlRzUkFqTlVxNFpudzAy?=
 =?utf-8?B?TlVVQThZRnpZWUtMeXVXNnlRa0N6RTl5aXFVNkw4L0htSklVK2xFTndrb3hN?=
 =?utf-8?B?MnNOQ0oxd3hGVmNacUlVK0ZTblFHNnBrZG9oM3lNdlFQakNFdHZBL3BvMm5L?=
 =?utf-8?B?M2ZQQ2dsSnJ2Tms1K0RQazg4NmtkZkFhdWlaaHNkUFQ0WG1nQ0h4eFZXR1J3?=
 =?utf-8?B?QXdWeCtnaEF0MWZ0N1FYYXpma1drL3hWV0srSmFwK0pTMXl3SDRhcEc2ejJU?=
 =?utf-8?Q?cPU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da89b699-c6b8-47e8-c1c5-08dcd8542d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 02:38:42.7019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tzYhrCb0zq2gX/61l6WWUb2x7WB8+UlYnOsrjroCre7aD0G0LlRsvFabiPF29wcZBr/NHivG3uSIW1Bwfy/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7610
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

SGkgRmFiaW8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDE5LCAyMDI0IDEwOjM2IEFNDQo+IFRvOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54
cC5jb20+DQo+IENjOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IGRsLXVib290LWlt
eCA8dWJvb3QtDQo+IGlteEBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPjsNCj4gWWUgTGkgPHllLmxpQG54cC5jb20+OyBGcmFuayBMaSA8
ZnJhbmsubGlAbnhwLmNvbT47IEphY2t5IEJhaQ0KPiA8cGluZy5iYWlAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAwMC8yMV0gaW14OTogdmFyaW91cyB1cGRhdGUNCj4gDQo+IEhp
IFBlbmcsDQo+IA0KPiBPbiBXZWQsIFNlcCAxOCwgMjAyNCBhdCA5OjE04oCvUE0gUGVuZyBGYW4g
KE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gUGVuZyBGYW4g
KDEyKToNCj4gPiAgICAgICBpbXg5OiBzb2M6IHdhaXQgc3NhciB3aGVuIHBvd2VyIG9uIHBvd2Vy
IGRvbWFpbg0KPiA+ICAgICAgIGlteDk6IHNvYzogQ2hhbmdlIEZTQiBkaXJlY3RseSBhY2Nlc3Mg
dG8gZnVzZSBBUEkNCj4gPiAgICAgICBpbXg5OiBzb2M6IFByaW50IEVMRSBpbmZvcm1hdGlvbg0K
PiA+ICAgICAgIGlteDhtOiBzb2M6IERyb3AgZGlzYWJsZV9wbXVfY3B1X25vZGVzDQo+ID4gICAg
ICAgaW14OiBHZW5lcmFsaXplIGRpc2FibGVfY3B1X25vZGVzDQo+ID4gICAgICAgaW14OTogc29j
OiBEaXNhYmxlIGNwdTEgZm9yIHZhcmlhbnRzIHRoYXQgb25seSBoYXMgb25lIEE1NSBjb3JlDQo+
ID4gICAgICAgaW14OiBHZW5lcmFsaXplIGZpeHVwX3RoZXJtYWxfdHJpcHMNCj4gDQo+IFRoaXMg
b25lIGZhaWxzIHRvIGFwcGx5IHRvIHRoZSBuZXh0IGJyYW5jaC4NCj4gDQo+IFBsZWFzZSByZWJh
c2UgYW5kIHJlc2VuZC4NCg0KQmFzZWQgb24gVG9tJ3MgbmV4dCBicmFuY2gsIHJpZ2h0Pw0KDQpU
aGFua3MsDQpQZW5nLg0K
