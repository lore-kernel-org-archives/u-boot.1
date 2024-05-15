Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D3C25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 11:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179AD881AC;
	Wed, 15 May 2024 13:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=skidata.com header.i=@skidata.com header.b="aXC2JDsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BA568824C; Wed, 15 May 2024 13:51:30 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B8588180
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 13:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=skidata.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Johannes.Kirchmair@skidata.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWtKnqnLSquZe9gz6vYSouNvlUlLOL7IdTBjRsn7qetD8M3yuR1P3a+Tvz3+KY/5DgHNwIVUEiwkAsLHz8SrzN8LXv7k2kDYJ3OKZNhZRxH6ZcGMDMKPoJOwQF/LCchjnfdEP2u58Qxx9roaa7lB5xtIjk9D1TaoZr8/nOuLQlqqpvZhPqgvKav9ptoulyzYGdp2HfIZgT/JF0ANvv9znBAW//UKiMxUWFWe0LiRXWFnY3oKbEpiEIWKWP9Vxv12RK4jtHcFzSsBXv0DHscH9aStmSW2sYL5joWf8/Hgi9zU8qnwHTBbI+SdV+uwSuzof4IAKXZ4h7h7VBDa2YG6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBMFQzxIeHUCk2FvFJzl3Qng6ieha9e2OLmx04nSnE4=;
 b=YQ9dmDIFZkv2yvKDP7NSI60i+3fOijYzRu9ihvaY1wRB/h+uCnfvliUc8QHRp3EpdGiYoioOJmwk2bMUJ2Llbfggg2vojLHRXZGcXaWss+awbLQOHdMafzFEvD3Msp4XJA2O28rw3eenSO9Peyqb0SLpI3b47ddK63IWsDk0l6eGJABv5MBUA2OzS4mZqVLGGf4C4ZLISJM6JlrsxlkkarUJIlH8XZCR28qgdLe01Phgp+UZOyw6LyHlXn0S6b3y57Pvl8YvXj/zhdhQJnhzudX2ggIWnIdl6YZxIVuMb0z+XDZBx2fXIUUH3hDl4w7d48YsHROtSPChXwkPOM0RNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skidata.com; dmarc=pass action=none header.from=skidata.com;
 dkim=pass header.d=skidata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skidata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBMFQzxIeHUCk2FvFJzl3Qng6ieha9e2OLmx04nSnE4=;
 b=aXC2JDsLwO1Vbq8XJ56Yrk43qroE7o7hrhBCUGBF/MYr5R+5RLtBBOtIKiQkcDnG58IrmRjfkQtblSK48oGTIyBDGNb2ymCFHWOsfHfTkOm0D56UaXxTTdDQ/M+UNl+vrReXoOvCIW90hBRjua4SeKnNeW76TqVr2aiePB/INmutIw/NDZ3ePpfp55F6Vp83tvFWmKJmS/l4hQ2lHcrnTv2ICVvOl5qQLVIFMqChGVh0Yr9bT0iM57MXnNGnqO4U7zQiW/Fre+7xzS4gx6urcVLidi/7+/PPdoZz1NObD2/rAU6mckTrT8YWo+/V3fNAo0dNKkomSm2jx+gxKSBiPg==
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:39::5) by
 ZR0P278MB1529.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:92::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.31; Wed, 15 May 2024 11:51:26 +0000
Received: from GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c]) by GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f5f4:4769:5e87:a09c%6]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 11:51:25 +0000
From: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>
To: Lukas Funke <lukas.funke-oss@weidmueller.com>, Fabio Estevam
 <festevam@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: AW: Use header file from external library in u-boot
Thread-Topic: Use header file from external library in u-boot
Thread-Index: AdqcXMbl8x5Zl2WnTWOSMsLTSOB/SQAOGkWAAoo4U0A=
Date: Wed, 15 May 2024 11:51:25 +0000
Message-ID: <GVAP278MB0456C0D6E4C0948651EEA2418CEC2@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
References: <GVAP278MB0456BCDA64C66C434932AF388C182@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
 <59be86ee-1523-41e1-af79-5495f077f796@weidmueller.com>
In-Reply-To: <59be86ee-1523-41e1-af79-5495f077f796@weidmueller.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: c5e26533-5fbd-4877-af3c-4aecf90ba3a9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skidata.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0456:EE_|ZR0P278MB1529:EE_
x-ms-office365-filtering-correlation-id: cab1c934-7354-40af-df55-08dc74d5591c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aWhEcXVxR3ZqR25tWmhDWlprRitBdDVyV0hNNlkrSk85aHNFMmRSUEhCL1E5?=
 =?utf-8?B?RDA2Uk1mU0dZSVZYT04wMk8rRXVCSjZzWXhFd1JiaVBabS9kY1BONzJWRGYy?=
 =?utf-8?B?dGtLOGlVaW9KaTVnWHYyRFFhL2J1NkJ1cC8zMWxJdjFDVC9uTTNVY0ZGWklz?=
 =?utf-8?B?cThWR3ZtYURhdXFXelJkVDNTb3E4N0R4U0w0Q1BjZ3VPMnpHUlVUZXhBeVBt?=
 =?utf-8?B?aTdjZ3ZiaWxMM25iSHVqT0ZHOW9kTk9tK1pqU0MyOHg4eFk4Wi9ZUUp5WVBH?=
 =?utf-8?B?WHFMUWRDSXU1a1ZPekUwQzkxQVhXcDQ4WWFIeWl5cFlGdEFDZmFiZEtjMC9I?=
 =?utf-8?B?K3BTSVl1T0FsMCtIUS9tcEdjNCs5REpiQTI1OUVqYzhIcTBzMHhtd3JMaGhk?=
 =?utf-8?B?S2tuTDZXRkNKOTJlUGdsY2NvVmo4ZXZ4UGRtUjN1SVJLZHMvcFZBT1Z6WWp4?=
 =?utf-8?B?QWE2dFk3elhha2hUV0ZZRlc3QXhtYjJLeEwzbW1BR2xGSEFQU0hHSkJzdkxq?=
 =?utf-8?B?UkhrYnhRdnc1ZkNMRDgwdlVpbWhnYW96OHErUUNoOWlPSGYxanVuVk03UzNJ?=
 =?utf-8?B?U0FYZys5cXNqakNKb0lrcHBWUHZidEVrdHJkNTM2SlhkOWVUL213UThQQ2ll?=
 =?utf-8?B?aUkxOTlKREpCMGlMSmhKN3pMeThySDBIaUdNTzZoN1lDSlp3YkdRNzhwQ2dR?=
 =?utf-8?B?dXFUdGJ1aHpzS2dyT09VWXljbmFpN3J0L1ppUnc2VEFUelBFckRYQWZnM0Jr?=
 =?utf-8?B?c0EvQXhvRGlIMWZsNGU3RmR3eHNOS3Mwd0xZOHE1REZHdVpSK1ZVOUo3dmhC?=
 =?utf-8?B?b1k1Y0V4WGE0UnNETDZRNXZhL1FySjdhdUxDcEpGRk5Fdk1RaFBlSGZiV2dh?=
 =?utf-8?B?TWY2ekgwNkpIS0xjbVZWZVpiZkNhdkUwaU1wTGNVQU5qNlFCakZvNlJuQ01N?=
 =?utf-8?B?MGhrY0Q2eldVTjdDSTJkNUNWcW9ZWEk0U1VhejVIMVc0a3FZVWl6Vm96R2s4?=
 =?utf-8?B?Ym5IMEdlUW51MnNWckxOREVKQ05JT2QxbHVXWkloZ0xyTGs2YS9WaE91S1B0?=
 =?utf-8?B?WjNORUprWksxZkFvVEsyQU9RVEhkYU5TUXJnQUdCWTBRUUo0V0huU1dTaWVF?=
 =?utf-8?B?cjVjY2VYUDdFOVVmZXpubUwrUEhLeEloWWdVbUtRODY4OGZVMGRaTkIwWU56?=
 =?utf-8?B?b2lqZGt6eTlRNE9WTEdjRGJsUDh4UlZSN1FFd0NSb05yano3Q0xpQ1FiYy94?=
 =?utf-8?B?a1F5VFBOV2FYZE1qY0ZkZ1VsazM1RktqaDVCZTlJVU9ObkhYOUU2MHU0MGVG?=
 =?utf-8?B?Nnh2akgvNDdOMGRsSjZGQUJwaDBXbHBFZlFyY3gxT0NCdVpUZFVScEx3YjIx?=
 =?utf-8?B?UTFLUDczUnRRQ0ZqcTBubDFXTmlFUXA1TWh0RExOM1h5QW1VNG4xS2V3VHN4?=
 =?utf-8?B?bzZBdDlxdUZRUXNQM0tRbmJQdlB0MDdHdHpBVGpFQU1OazZlSjZQQkwxY3Q0?=
 =?utf-8?B?UEp2S3Axb1I1MDQ1VGNpZ3hJWHRYZVovdHNJNHBMbW42cG56SlZHKzFtc2Fx?=
 =?utf-8?B?VkYxdTcxRy9NeXZxWW14V01yMlIraWtuTCtDZ0d6VUdscHdtVm9yQU9QN2ZM?=
 =?utf-8?B?enNxUEVOdGpUNDdnVUYwQ0FFU1Q2VGJiWE5DZnQ2SGcvdWdXQkNkU2tPTEVN?=
 =?utf-8?B?TWVqclNoYzM4NWQzYUJIWXUvZFZOZXBSOVlNd3dXaU8ycEJCdVc0WmVVZVBX?=
 =?utf-8?B?UjlTSHE4bFFPWStkMnpUY0VpQTZUcThzVmFpRXh1U3dhWnJnSjZxeVN5WHRw?=
 =?utf-8?B?QmUrQ2E5MnBRRVMrWCtQdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZldPV2N1RDZaWXNreWtiODNWR2tMNTFKR3plcy80SGY4MWladFcyRDJDdGRX?=
 =?utf-8?B?RUhqMWl4U21FVlJQYU9PUWtZdVBydGplalg2clduRm9OeG9jd0RvdXNXMExk?=
 =?utf-8?B?b0dkOXlTL0VtcXpkNnI5YnFMZEJwcUlYOFEyS1lKdm9pN2NXT0dUYVIzcS9T?=
 =?utf-8?B?bEQzR1k5MXhERFptQlcxL0lRWkNPZXZNK21PUUVEUHZlNlBRSVNBU2Z3aXlN?=
 =?utf-8?B?Zkp0ZFVRUW95OExFOFlQYVJBV1R2QmZFV2g2WnBlZjY3QUk5bXBjSVUvc3BV?=
 =?utf-8?B?S0MwaFFvbDBuQmZ4NzhiUHh5YTdPRDdCQk1vRVBnV0p2dU5Ic2NOeVE0bFdQ?=
 =?utf-8?B?Mk5laDVvdU1peHNKei9Vb0taZXF2NWlJdmRuNFFSa1RhU3oxQm5LVXUvUEpR?=
 =?utf-8?B?VFVHV3U2VTU3YlVvYnNlcW9UOFo5L3BrVll5N0hPQlRTRHgxTmVRY0t5ek9p?=
 =?utf-8?B?MGliQ3BpOWV2blYyNjdMK3lmSGVTN0hEVUYvS0FvOEpYVXZiUTYwT0lacXIr?=
 =?utf-8?B?NzdzMFdhSEZjeDN6RFBuMEFhd0VtZ1NRdFV2eVV0V09ZM0oraVBWVnY0dkQ3?=
 =?utf-8?B?QWdNenUwN0srdzY4VGFBaS9zQ2pyN0ZYMDFUclRyS1JGWjExd2tHM295MjNS?=
 =?utf-8?B?MnkvNWtIcGlZdUwxQ292SjRRUWJyYXZQS0FsVzdsTDZ2c1NzR0V0RVhVUTZB?=
 =?utf-8?B?ekJnT3c2SncyTUFpSms2YTJPcWgyT1hBU3dZNENDVUJmS0IwWXpkZUZKbVhH?=
 =?utf-8?B?NFZGeUplTmNwanMwUXhkSVcyYldGanpJN2kzYVZaazdHbGhTd2d0ZXdBNGVz?=
 =?utf-8?B?VC9SRExOelpDSTZCdlJKS1JGbk16RWFCUTlzTDJTZzVKcnloVzJGdXF3YjFz?=
 =?utf-8?B?eG5ucHl6OFoyYVQyZFZERHpSUFhFT0FRMHBIUmxCY0p3MlpOd0xvTDcxbVln?=
 =?utf-8?B?ZEVxOGZVWWRXZktJQ01QVjUyVmV4b0k5QnBWQlFuUEFyWXZrTXBJcE9ab2Vk?=
 =?utf-8?B?WmFzQTgrWUdmQWhJY2o5ZmxuZEY0UDI3eFh2T1VkZURML0dhdEg4NEhVME1U?=
 =?utf-8?B?QUlRYkg4Sm0zUzNBaXBQR2U3RnNzRGU0YnBVamJqb3I0aWNwdE5TKzJ1d2Jy?=
 =?utf-8?B?eFZ2YzZETUs3Kzd0YlA3a3V6b3kyNVJnY1REdWp3eUVMWWdObzVlWWlWb29Z?=
 =?utf-8?B?WkR5RW5yWHVWZm5SZTlrczl2UXpWQmpKblZnK2RVdWxyWmY1b2RGaDBLV25x?=
 =?utf-8?B?dFBJdUYxVVhTSGlDdWNPRVVuWjJzQWhacWdkaTAzblA5OG1PdHJZaHBnN0Mw?=
 =?utf-8?B?VmZweE1RVTJBWVRINE9xLzdBUFRmbVJLVGhWVGN1WnR4QWxMbkRTZEpSS2RP?=
 =?utf-8?B?U0hGMWlrNEp2aml1T3N2NzNmUnc4VFlrbzRLRTF6ZGk0ZTJOVUswQTIzd0FB?=
 =?utf-8?B?dlpFSGFNL0FXNnJEOGtkSE1QN0RpU3hSWEdXcjRiTUx1WWR3NWhGbU42VzZH?=
 =?utf-8?B?aGxYMmN4S1Y4NWYwU0lWRjlHWlRJcllYVC9qSkpJNmhGQUxBMzczMnIvTStE?=
 =?utf-8?B?VVV0SlFVd2xiTDBwOEY2RzluL1oyeTR3b05BZkZpK0J0YjVYWDN4UnhrdDNS?=
 =?utf-8?B?SUhSaks0K1BIaHBjeEJjTjBzSnRqQ2t2eHl0aFZ1dEZwZ2o2bFVXdDJZTjhF?=
 =?utf-8?B?aE1senJvNEc2aXhiVGR3WjdhVFQ0bms2ODZPU2pLYVJWcVNsTk9Caml3RjZP?=
 =?utf-8?B?Sk8xNGpTMUl5M0d5cGZtdlBreG05VlZRem5YQmxoSk1FVGNZV2FtNGVOWjht?=
 =?utf-8?B?NnNuc1FyYmNzaVJDVG0yMG45WGFQcFVmT25qZUs5VmlqbzNQOVozRXlUaDds?=
 =?utf-8?B?TFU1RWRyT2Qxc1A4WVU0RDNiWFRucmZuSysxNTN0U0hjQ2grVWs2ZDBTbThk?=
 =?utf-8?B?ZXJYaTBCUXVKTFdUYXV2OVBTcDNPV1R2TFpRdnhleXJOL0pnRXhZL2RBdE82?=
 =?utf-8?B?K2I0bFllV1p0cnRlUXBDVE1IaE5xd2E4d0NiSUJOdXZTMFova2VrSE04SFpz?=
 =?utf-8?B?a1k1Ni8yZDFqRHN1aGdFU0UxbDJNYWVjTThxUjM5N212UFYza2hXTk9CbU9y?=
 =?utf-8?B?NStWcTZkeWsrb2xwQTgwd0FEOVM5QUh2UVRzbE5GQnRrcXRPQitjR3hza0xO?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: skidata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cab1c934-7354-40af-df55-08dc74d5591c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 11:51:25.1297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5733095-4425-4f08-b6ba-487b9a46a425
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svcpJpI92UD28KqR4Hptjmk+1hT0xbKrXsPvSVA2ir1tP6ekkDVFYNEdjzYSfu64omhnom1ZupWTzwKn31lpKcAX1gX7D2o2b4f6T4wXAFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1529
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

RGVhciBGYWJpbyBhbmQgTHVrYXMsIA0KDQp3aWxsIGhhdmUgYSB0aGFua3MgZm9yIHlvdXIgc3Vn
Z2VzdGlvbnMuIEkgd2lsbCBoYXZlIGEgbG9vayBhdCBpdC4gDQoNCkJlc3QgcmVnYXJkcyANCkpv
aGFubmVzDQoNCi0tLS0tVXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NClZvbjogTHVrYXMg
RnVua2UgPGx1a2FzLmZ1bmtlLW9zc0B3ZWlkbXVlbGxlci5jb20+IA0KR2VzZW5kZXQ6IERvbm5l
cnN0YWcsIDIuIE1haSAyMDI0IDE1OjMzDQpBbjogdS1ib290QGxpc3RzLmRlbnguZGU7IEpvaGFu
bmVzIEtpcmNobWFpciAtIFNLSURBVEEgPEpvaGFubmVzLktpcmNobWFpckBza2lkYXRhLmNvbT4N
CkJldHJlZmY6IFJlOiBVc2UgaGVhZGVyIGZpbGUgZnJvbSBleHRlcm5hbCBsaWJyYXJ5IGluIHUt
Ym9vdA0KDQpFWFRFUk5BTCBFTUFJTA0KDQoNCk9uIDAyLjA1LjIwMjQgMDg6NTcsIEpvaGFubmVz
IEtpcmNobWFpciAtIFNLSURBVEEgd3JvdGU6DQo+IERlYXIgdS1ib290IGZvbGtzLA0KPg0KPiB3
ZSBhcmUgdHJ5aW5nIHRvIHNoYXJlIHNvbWUgaW5mb3JtYXRpb24gYmV0d2VlbiB1LWJvb3QgYW5k
IGEgTGludXggdXNlciBzcGFjZSB0b29sLiBGb3IgdGhpcyB3ZSBwbGFjZSBzb21lIGluZm9ybWF0
aW9uIGluIGEgRlJBTS4gVGhpcyBpbmZvcm1hdGlvbiBpcyBqdXN0IHNvbWUgbnVtZXJpYyB2YWx1
ZXMsIGluZGljYXRpbmcgc29tZSB3YW50ZWQgYmVoYXZpb3VyLiBJIHRob3VnaHQgb2YgdXNpbmcg
YSBoZWFkZXIgZmlsZSB0byBrZWVwIHRoZXNlIHZhbHVlcyBhbGlnbmVkIGJldHdlZW4gdGhlIHVz
ZXIgc3BhY2UgdG9vbCBhbmQgdS1ib290LiBUaGlzIGhlYWRlciBpcyBwcm92aWRlZCBieSBhIGxp
YnJhcnkuICBJbmNsdWRpbmcgaXQgaW50byB0aGUgdXNlciBzcGFjZSB0b29sIGlzIHN0cmFpZ2h0
IGZvcndhcmQsIGJ1dCBpbnRvIHUtYm9vdCBkb2VzIHNlZW0gY29tcGxpY2F0ZWQsIGFzIHRoZSBi
dWlsZCBzeXN0ZW0gaXMgbm90IG1lYW50IHRvIGluY2x1ZGUgZXh0ZXJuYWwgbGlicmFyaWVzLiBJ
cyB0aGVyZSBhIHByZWZlcnJlZCB3YXkgdG8gZG8gdGhpcyBraW5kIG9mIGFsaWdubWVudCBvciBh
IHN1Z2dlc3Rpb24gb24gaG93IHRvIGhhbmRsZSB0aGlzPw0KPg0KPiBCZXN0IHJlZ2FyZHMNCj4g
Sm9oYW5uZXMNCg0KSG93IGFib3V0IHdyaXRpbmcgaXQgaW50byB0aGUgbGludXggZGV2aWNlLXRy
ZWUuICdib290c3RhZ2UnIGRvZXMgdGhpcyBpbiB0aGUgc2FtZSB3YXkgaWYgSSByZW1lbWJlciBj
b3JyZWN0bHkuDQoNCg==
