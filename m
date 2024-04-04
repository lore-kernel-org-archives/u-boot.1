Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62560CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAEB588459;
	Thu,  4 Apr 2024 14:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="WtKIlL1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E28D88436; Thu,  4 Apr 2024 13:58:46 +0200 (CEST)
Received: from outbound-ip8b.ess.barracuda.com
 (outbound-ip8b.ess.barracuda.com [209.222.82.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6131287D74
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101]) by
 mx-outbound16-156.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 04 Apr 2024 11:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4N9U+zkh2jkOqNm6XssMJDB8szpUqaiJKM9VYPnRyCcoIsG3yZZFYyVPzfgexS3lWBMwvlkBhAKrIXBJZQgkJMxBEeQ7BTqOvQWObVUZFr85HJRmQI0ZDTt7xckkLwnPtizdTbg9scasFziyy6i1fwNKzaY1rppA0RNcbvilm9UyzjFen/OKt/Qr0o+i3opPhj6vWR4Wb/hFOiArfco2D6x45iVPOpe6rZbVxHPV2lM+lu54eTnOCEMQIQ/rp49u7GH7nVMQckaMPtgChv/Da8Bos4KQB6U4dB3Hv4sn9tyw95HVI98lPAsHjfyBOUegOwhEDYBNZDQQ0ZMdDAv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=557jK0+dEyX301EZXPF5hlzYvjCN8pBxQPtyyfG235o=;
 b=Xo5txIUy3pPYtToahNO1GNgP19cQFI+zgfh5r9td/lReLPoAO2nGD11NxNpDKHLeYLfvLLC7nx44hcdTVr1h8q/VD/VYnXvToeFmzG4ymrVfSn92liMER/fzYfaYeOCP7DoeteltmSQ04XsqCvCPLfkqyw+XoUITqUM7P9yhEo8MEEqX7q35U1ximCBZj7mr4QWgoGcBjp2WGR41KCx+U8QEPFT1jzs1wgesUbrQIlzFnsauaum8nmFVtSYVxSS+o+6ZTQ1ZqVQsSGxLm7JLYE88y0uUzUQRg7WGGcv8+LRWG+WvKyKmj6OCc9az2ngd9y7jRP9QEndGSTYos5WZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=557jK0+dEyX301EZXPF5hlzYvjCN8pBxQPtyyfG235o=;
 b=WtKIlL1JtsD7n/maYCWoBYC4KzGRfUKj3gbvMHyPJeZUJCjmryYBjhaIFIaihFXKPwoG44BqX24+EnMCOba4g4uy3dB8DfZnRR7i7bWtYD8TEpcvgT3Y88KRdEkIyItihCZxw+MI6UDl9NHPTARCSpKQkomSisMXPCohPbhOxcXxvTQ9IYRbP5PRuPV4j9aF8G+oM+kmCSM/GYYpgFrToY3mPQbH/KMQxhGf8Y8T3rIdh605AYIblX89XKmTWWL1jtDsXlaGeRxs2XNIdOdpfCujdmkhzm/rx7+e9+JE85PIbf2JCos6/qqWCv0PvJUJyCWWcI46R+fbyebJHIIowQ==
Received: from DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) by
 CY8PR10MB6586.namprd10.prod.outlook.com (2603:10b6:930:59::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 11:58:31 +0000
Received: from DS7PR10MB5167.namprd10.prod.outlook.com
 ([fe80::2991:3274:498f:f9d5]) by DS7PR10MB5167.namprd10.prod.outlook.com
 ([fe80::2991:3274:498f:f9d5%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 11:58:31 +0000
From: "Viguera, Javier" <Javier.Viguera@digi.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>
Subject: RE: [PATCH] arm: imx: fix signature_block_hdr struct fields order
Thread-Topic: [PATCH] arm: imx: fix signature_block_hdr struct fields order
Thread-Index: AQHaf22/RfrnbTg5R02ET1+fmPH64bFKymcAgA1BnjA=
Date: Thu, 4 Apr 2024 11:58:31 +0000
Message-ID: <DS7PR10MB51676292B8A1A964C453AEF2E03C2@DS7PR10MB5167.namprd10.prod.outlook.com>
References: <20240326110656.21110-1-javier.viguera@digi.com>
 <CAOMZO5DYmkp6Wm79bBFv3fFuVWu+LghiKqPkC5kcLnW21Umy3A@mail.gmail.com>
In-Reply-To: <CAOMZO5DYmkp6Wm79bBFv3fFuVWu+LghiKqPkC5kcLnW21Umy3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5167:EE_|CY8PR10MB6586:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OND1CZiydVTtMfE+qZgHIDPW/k/GRfU3khh9uVgvJwwwncoEvA7gCNjTQAXgk+nNSlvuMB2dfKbZbiGezybDgZuNOmZT5Vp9RKJGCflPaJkVvoaZUwNmPd20I289Y6TUnVGeykpGnN08TA9r3c/vkjIadSQ8zS4eax00xe115Zp4OCp5qOfvKHhiNi103rYR76rACFaNnqCl4jRQ3F9j/4f3mmZzALJAueZSGP1CM2FFtw0sq5aViT5ziNjuTlRVV7wNt85fU9pLVdAzVAtvqzBoCcpS/+q+hAaCrWniqwJUa6a4Piv5W6Z95QocdbSRHkLt7bAvZJ6PnTW3kITPw1e/JEEDJRwuFOy9XYt+cZZoyN68BE2UMjvr/UOlCWd1TIkeTLC0nK9+7LAcbmu9r7fR/q2rEAcqJZpFa792B7EEYcgd9zCsCvjH8wv/PX5VStbvgGLDcWJgFr6S+uHSXB6kpyH0duaGlyNHUP0drq6mR5B93XkPmLv2ujiPM/KqYZNYQVzZH4Zuq8RhLA6uGmvS5HfnPdpdYGENL4AM7Y1ZzNIpDCs3s3565nxTITwmct/aJDdUFq18OR6XVCryF6bSOowoWy4dhFkH2b4lK2fomHkW5bfBKhF2GL1GH+U2dQ7UZTjVjO7aNiRzB7MeRKgWfNS5FaDKcJndTb+R0rI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5167.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjE5TzhrZkRXKzhvY3hFdjZ2eUxINURna0tRMHBYai9TV1hBejBrQlJpNXc5?=
 =?utf-8?B?aGU0QytrRDUzZ1Foc08yRGpNZzhnY3UrdklkZG1yaVArWW9MejU3aHZTanBi?=
 =?utf-8?B?UjJBT0ZCdlMxSStBWjJrMnFZSGNEY2UzaHVka2cxaDJDaE1kTFdDc2xiTUVo?=
 =?utf-8?B?SnNLYkV6NHlVdVhrejhqQVhwL2hHSk5mY2U4aURkV3oydmJNQkFERklPaGpo?=
 =?utf-8?B?S2JIU2wzVEtMSS9EcGt6blRlS3o4My80dXZsSE53QTJYa2VJUGJXR0luU0dO?=
 =?utf-8?B?UmpjV2xNd0JRa25LYURRcDU3YnpyRS82VzdTNDlwQUJhand6eUtNbTJOTXhv?=
 =?utf-8?B?WUsxQ3lFeDFhT2xzblQ5SVFhZnVlQ2FiVXp3YkJUb0FSRFNaZ1BwUGtFODlI?=
 =?utf-8?B?ek5nbUkxMDVUMS93N2w3OXl1VURxaGMraDFIM1dsK29UQzFncGxMdGlDY1cv?=
 =?utf-8?B?d0RLZEMrdDQrRWRqcGRDblZ0bEg0V09sb3JPVWJBd0g4cTg3SDNBV1l6dC8x?=
 =?utf-8?B?QXBleWU4Q1NkUjdXUkx6R1E5eWNMbzgxdTJQWmlzeUpobDlxZ3ZKVFhkLzQy?=
 =?utf-8?B?S0NBNEZDTnpDQkRaaFRWdlUzdWZXbExjdkVFVGpiY0hVZ1NKTHZYcVFJUVgr?=
 =?utf-8?B?cm5YWXR2Nk5tQnJMTDhsRC9JanIyQkozM1R3VkllS0pEV1k5dENRZGdvVmZJ?=
 =?utf-8?B?em5RSnBSSE55NTN5RXJkM0k3QVNLNU1PenphMGxCcFhxTWVwZTdwejlSQjFG?=
 =?utf-8?B?TE9NcEEwODVxZWdoTGlZNjB0eWFrVlM2UUVkWGxOcHdXWVlIakE0WGpBSTA5?=
 =?utf-8?B?bUxlOXBWLzZBL3BMbGUxRHptOUpUeCtuUHIraWhCMjhVUmtrUVVEMWJWNkJN?=
 =?utf-8?B?QU1SYlpzVzdVTkllVCszZjB0azYwaUk5OUxudUdxcUlnVGRRNEZJY3JKT1h1?=
 =?utf-8?B?T2J3amxFQldhMHMyRks2M01iSmw1QTJmLzYyNW9xRDBmbEx6c09uVHl2cmNM?=
 =?utf-8?B?aDRRUEoySXROVVl3Ukp3UW5XWkQ5Z3ZpVnBjWi84ZmFvUHo5UGlFQTd0S1Vi?=
 =?utf-8?B?VkJPSGY4Zlo2L2dNcVQ3d29ZdXQ4SDMzb01EdzlqdmwyTXVSM003YTVnai9C?=
 =?utf-8?B?UHArWVhBSmZybHREZ3ZKcmhEWmdZOURUR2hYZnlESkRwbko2VkE2OExJNEdV?=
 =?utf-8?B?NVJGcDA4WTdPUTV2OWRvU3NzbHJySFZJMEtMMjJ0Mm5tcUpYRGVGNlprRjQ4?=
 =?utf-8?B?dno3YWlWT0dmUzVXcDBuNEZjc0ZkSnNEV1hhYXpacnJlZ2R1ZDY0M3dqL3RI?=
 =?utf-8?B?dmhSd09tQWFSRjdmYjk4MHFoT2JCWS8yekdRTTArTHlsZnBaR1B4Y0l4RE1h?=
 =?utf-8?B?bDU0ZnN0TU1jT1RCVkM5ODJ2bmh3MVMxcnQraEZWcnJGcGxNa3ZTMjZnWUNT?=
 =?utf-8?B?cUY0TFZXbEtncERYOWd0SkEzWUJoaURWR0VGQkNtbWJoeFF1dWtvSFkycGFq?=
 =?utf-8?B?ZzRZYmxyZ1prcHZhRUdYU0o1b3hkVEEwRDFxbi81Q2RJK2psK0E5T24rTWNK?=
 =?utf-8?B?bjFDbVFDeDY1aWUxdk5aUGt4Uis4M3IvdVZQWXNUc1V6c2h1VkpNdWloVFN1?=
 =?utf-8?B?aGVLalMyQnZGenZucWc1bGVHQ3pyek5RNWJnMnI2Y0l3dmFrYnVZL0FYMkFz?=
 =?utf-8?B?eDhNeisrdHdnSDduVjdDbkRZM1I3UkdZVkQvbDhDQlZ4N0dJcFA1ZUZ6eHZO?=
 =?utf-8?B?U01NM0hkeWNIUjFaNjJJSmwrcWxzTEwwOVVRQWw2eVhJd1dvMURuTGM4aHND?=
 =?utf-8?B?SUxoWUdzcXJ6QldmNEZqcWFTZTM4VWRhTjdrRW1GNVVadzRpZnlBZG9HNmIx?=
 =?utf-8?B?dmE0TjZLcFlienZkemxrS2Z0YlNhbEh6cDIyWWo0MjB0dDVBcUh5ZWNlMkd5?=
 =?utf-8?B?ZGFXQ2RlZWdRN2F5TjVWUFRaUUg2Rm02TlJXaElhZVNPN0ZNbmtQWWY5Tm1R?=
 =?utf-8?B?bHdCdkRBaHMycXR3bTJKZ0tUaXJkWTBnK0hRb2hsQ04vVFJmWnZITFZxQkFZ?=
 =?utf-8?B?VkZoUDR2dEYvQzBlQkErcEtwd0RkUUsrMlI1VlV1SmEzVWptalZiTXpYcmp2?=
 =?utf-8?Q?svwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5167.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf2bbb4-9527-4a17-382f-08dc549e8c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 11:58:31.1890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILnCY9givNetAIoGAd2YTPnBkvx9RvucRGK9C+PYbP6n7iRkMh08WMWcxcsEp7SmGJ+mhGmaZJvXWrA6nmvs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6586
X-BESS-ID: 1712231913-104252-12695-4127-1
X-BESS-VER: 2019.1_20240403.2023
X-BESS-Apparent-Source-IP: 104.47.55.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaG5uZAVgZQMC3JNNUgJc3cMD
 HV2MLMONk01TjNIDUpJSXJLMnIPClVqTYWAJtHlydBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.255330 [from 
 cloudscan18-215.us-east-2b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Thu, 04 Apr 2024 14:22:35 +0200
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

SGkgRmFiaW8sDQoNCkZpcnN0LCBzb3JyeSBmb3IgdGhlIGRlbGF5LiBJIHdhcyBvdXQgb2YgdGhl
IG9mZmljZSAoRWFzdGVyKS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEZh
YmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4gDQpDb3VsZCB5b3UgZWxhYm9yYXRlIG1v
cmUgYWJvdXQgdGhpcyBhbmQgc2hhcmUgbW9yZSBkZXRhaWxzPw0KSGF2ZSB5b3Ugc2VlbiBhIHJ1
bi10aW1lIGVycm9yIG9yIGRpZCB5b3UgY2F0Y2ggaXQgYnkgY29kZSBpbnNwZWN0aW9uPw0KDQpU
aGUgc3RydWN0IGhhcyB0aGUgZmllbGRzIGluIHRoZSB3cm9uZyBvcmRlciBhY2NvcmRpbmcgdG8g
b3RoZXIgZG9jdW1lbnRhdGlvbiBmcm9tIE5YUCAoc2VlIGZvciBleGFtcGxlIHRoZSBBTjEzOTk0
IC0gRW5jcnlwdGVkIEJvb3Qgb24gQUhBQi1lbmFibGVkIGRldmljZXMpLg0KDQpJbiB0aGUgY3Vy
cmVudCB1cHN0cmVhbSB1LWJvb3QgY29kZSB0aGVyZSBpcyBOTyBydW50aW1lIGVycm9yLCBhcyB0
aG9zZSBmaWVsZHMgYXJlIG5vdCBiZWluZyB1c2VkLiBPbmx5ICcgZ2V0X2NvbnRhaW5lcl9zaXpl
YG9uICBgYXJjaC9hcm0vbWFjaC1pbXgvaW1hZ2UtY29udGFpbmVyLmNgICBkZWZpbmVzIGEgdmFy
aWFibGUgb2YgdGhhdCB0eXBlLiBCdXQgdGhlbiBpdCBvbmx5IHVzZXMgdGhlICJsZW5ndGhfbHNi
IiBhbmQgImxlbmd0aF9tc2IiIGZpZWxzLCB3aGljaCBhcmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0
aGUgc3RydWN0IGFuZCB0aHVzIGluIHRoZSBjb3JyZWN0IHBvc2l0aW9uLg0KDQpPbiB0aGUgb3Ro
ZXIgaGFuZCwgd2Ugd2VyZSBoaXQgYnkgdGhpcyBwcm9ibGVtIGluIHNvbWUgYm9vdGxvYWRlciBl
bmNyeXB0aW9uIHJlbGF0ZWQgY29kZSB3ZSBkbyBpbiBvdXIgKGFzIG9mIERpZ2kpIEJTUC4gV2Ug
Z2V0IHRoZSBibG9iIG9mZnNldCBmcm9tIHRoZSBzaWduYXR1cmUgYmxvY2sgaGVhZGVyIHRvIHJl
YWQgdGhlIGRhdGEgZW5jcnlwdGlvbiBrZXkgYmxvYiBhbmQgZHVlIHRvIHRoZSB3cm9uZyBvcmRl
ciB0aGlzIHBhdGNoIGZpeGVzLCB3ZSB3ZXJlIGdldHRpbmcgYSB3cm9uZyBwb3NpdGlvbiBvZiB0
aGUgREVLIGJsb2IuDQoNCkhvcGUgdGhpcyBjbGVhcnMgaXQgdXAgYSBiaXQuDQoNCi0tDQpKYXZp
ZXIgVmlndWVyYQ0KU29mdHdhcmUgRW5naW5lZXIgYXQgRGlnaSBJbnRlcm5hdGlvbmFsLg0KDQoN
Cg0K
