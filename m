Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FCED5E15A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66B388FE8;
	Fri,  8 Nov 2024 12:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="htsTwqiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D88890C1; Fri,  8 Nov 2024 12:47:36 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D8488FE8
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWsma34N46IdJYF6xtLl3MvoET7c5UgTO81DdreC+BtdmkAtK2VCEubD2uxxRnUUYE0Be5bDD7/7v08rGvhQi4Ao7Qe8EedQRDFq8/6rTriTOdgQPXSuxk7X2qUztVtmzvuxW03kZotyaBW8Gk35zg97ZsIkug2BXOVJH6CVRIvZuxuDVmZWghpy1J54l5IF9la0qtKEZJzQb6GoADl95kdKr37ERqKT78dkw6ujREIMBmrlSKlSDEXRiymNPr6l3WqGPBFluzi2kvDjEPlS6URQmpD9gVLB6o4aVmDD6o0uASnj+cfbOunDYLJFL4cb2atX9iDeQo2AaGf0N30fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQo1BHfP5WQ1RUr1xJV4p7hFPXANKa1lNEQC10M9zg8=;
 b=gdVgzVOIrOzuuA9a87hQ+IaYDIWRibrCuxGKDIC6jk/YNUJEltjhoVYb6eL7IaUEWY+7YEfUN00ud4IJTxWXONp8BULvSIfnTU3cdnmUFitsf86L+AVxT6HQ/P5Iz7kEQrIS50QqDhIhbfagA1H81k7gQmiHlre5CiUZ2v1atOjtdwSYH8lqtYWcT23oWNQZOmWPhNpdKblHLRngOwGe7lsPVD1RLOXjAlYKmitQFrn9lv5+Qu0Skfm1/mx0pck4+1TSwO/6+V1Q/QB6v5vxAyCrDjKaGwkpYzUD+dv1sVXEngxJpNfmqeFVH+LkxBGh8zaWGdUL1fz/PkK1bFIuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQo1BHfP5WQ1RUr1xJV4p7hFPXANKa1lNEQC10M9zg8=;
 b=htsTwqiO153ryROv0uh12G0t0H07XnKk8v4H5DRCFNEzBGPdB1l5Yb8WKsUUFU3Y0724zeXC6z0/auhPp4JjGc0Z0QC53QCaKL3jEXuH8DJkcFLLe0Re8KkSsR7FTcK95jA5JZD8wuH9sHupzP5SqfmYBo0XFbb+yLXaDu5jo9k3XEUURvCW53Kfw93SYihczw5kn8PuLcqf5kX2Ai4Br81EAQQMYdcOGtc9dBpfTfexfY6qTRd+nA1w/t5sHCSi5FtS7YQeCFol2rh7hjRBSyYo603WqqhAGY70q+JsY0cJDpCT03hw/qqddGJtUMQEzGXIQbnn4GsgEG3XPe+VrA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11; Fri, 8 Nov
 2024 11:47:32 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8114.015; Fri, 8 Nov 2024
 11:47:32 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "sr@denx.de" <sr@denx.de>
CC: "ravi@prevas.dk" <ravi@prevas.dk>, "randolph@andestech.com"
 <randolph@andestech.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "Freihofer, Adrian"
 <adrian.freihofer@siemens.com>, "chanho61.park@samsung.com"
 <chanho61.park@samsung.com>, "Leto, Enrico" <enrico.leto@siemens.com>,
 "devarsht@ti.com" <devarsht@ti.com>, "igor.opaniuk@foundries.io"
 <igor.opaniuk@foundries.io>, "andrej.valek@siemens.com"
 <andrej.valek@siemens.com>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "ycliang@andestech.com"
 <ycliang@andestech.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "bastien.curutchet@bootlin.com"
 <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH v1 01/22] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
Thread-Topic: [PATCH v1 01/22] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
Thread-Index: AQHbMZ4fLuIWVDVPfEeD4Q8ioeTSUrKs+cEAgABK/4A=
Date: Fri, 8 Nov 2024 11:47:32 +0000
Message-ID: <d49617fafa6b8fe1c790f9d8d6bd862d6578276e.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-2-hs@denx.de>
 <ee022055-6bec-4326-b9bf-3823211d94b6@denx.de>
In-Reply-To: <ee022055-6bec-4326-b9bf-3823211d94b6@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3140:EE_
x-ms-office365-filtering-correlation-id: a66f7763-2a48-469b-7822-08dcffeb21bd
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MkNJcmhxVHBRc2tqN040RnpyZ0FQZE1xVHV4NHpTOSsvZ0pDdDFhM3gzNDhx?=
 =?utf-8?B?MXoybEhOOTRWT2hYbGpudyt6RWZPWktHbXVNNHo5Rld3RVJaWTlqdGlRV2Yx?=
 =?utf-8?B?Zk5ieFJMK2RlZmlVekZzYitBTEE1enhmYmRVbHVmRjJTZ1BjR0ZWbndycEU4?=
 =?utf-8?B?SXR6ckcxQ1ZBNmhtZmtQZWhFbXhZbHdrdmcxUHZ4S0RiVnN5SXl4K0xOZGlB?=
 =?utf-8?B?OG9hWEZDL1hqTGIxTkM4c2cycTdGWTNyY3g2QmFQOHBYRXNsU2pJaWdxRnNT?=
 =?utf-8?B?ZG84ZjMzUEcxbEkwNW04ek9MWjFKeVBEd0JBMEpZdGRCdWFFSFhscXU0dTdl?=
 =?utf-8?B?TlVBT0hoZS9NTVdBSjMvVHFrSU1XeUR2cjlMUzdST3hZS1V4L2RodFlzdEdi?=
 =?utf-8?B?WVJBU1ZoSFN6cll5S1ZqWkRST3oxL0x1RFdxbVh2OXNsS29hejVIQ0Q3dHFS?=
 =?utf-8?B?OU9ieGxoMlBZTXhVNzVnaHoxaFUxR2ZhNUhHWTZJNVRpN243Z0lYSWE4NTla?=
 =?utf-8?B?bE5BSjZlUXNFbGtDVExBeVE1d2wweTBJN205eXp1ZkZMZm1hNGlZR3dsTG14?=
 =?utf-8?B?dUIycE5JWGJvMEtsVmcxc04rNU5sRUlFWlI5YmkyeE80OHlReTJQTkQyNFZm?=
 =?utf-8?B?SzF3VVdTZ1R3aE5kMWlMUTAwaEEwSXBXc0FldGxVOC9CMnNVRmpVcXNaaURv?=
 =?utf-8?B?aFk3bnJKdnYrMG53SExHUm05SkJMbmZieDU3N0RLQkNaMkhia3dXaFNCRTAr?=
 =?utf-8?B?Y3hXNGVFdytCbUJ3cmNTcXU5dXJGSDA5bWFMcmFYOEVUcERUNU9pSGJqYW9P?=
 =?utf-8?B?OHM0dklqaFNINzdyMVEwRDA4M09sMjdaL2NSQmlRelZKOFBRem1xYVh5K2tY?=
 =?utf-8?B?Q2h1aWRKVnVTWlA5bEcyQjUrWk9CTHJvMGhhRGNhOVcxY0hIQXl1bDU1Qlp6?=
 =?utf-8?B?OS93dHBGdmt1aVUvYXN6U0M2NHJTWTVhOXg0OU92aFgwQUFoN1N5MElqR1JR?=
 =?utf-8?B?d2d0RFBIOHd5dkZWbTRxdU9wOGtlanpraUFEYndGWHBhUTVrM0FLMVp4bDEv?=
 =?utf-8?B?VXBNenV4Rm1NRXVVSVN6UmZBMWJ3TjN6M1U2eFZzdjFXQUR0enRhd0FwZDNr?=
 =?utf-8?B?eDAzSytjeXljYm5NU29kdW9Tc2NCa1RMTFFBM0lvM21zRnZuSGE1TVdnNjdC?=
 =?utf-8?B?QTF2cm80bzJIeG14VnE1M1R1T0paN1JCc21wNm5DRTRGLzh3V3lJUHNJcjJX?=
 =?utf-8?B?UzZoODI5L2lHSG5UWnVLR3o3NWphZm90V2tPMzFDZi9ZRytwY2tLaUxHWjBa?=
 =?utf-8?B?ckRBQ2Q3UDI4Mnc4ZndRMm5ZWmJjaFh6dzkwNWMvai9EQXZCWnUrUkRVSXlE?=
 =?utf-8?B?czVQV2UyM0lhV05uZ1lQNXRndms0V21CSmQxTytxTUJjb096Q21mZkZKS0xJ?=
 =?utf-8?B?bG1SSEo3RDQ3RmR5V2JiYnhBdWllMkhFVExob2RZRjdKVzdROXZJaEt4VlNy?=
 =?utf-8?B?UytpSCs3S3JwOWV2MmNyWlovQmhIb2wvNHd6c3JBTlRCcFNtajNSMldmQUMr?=
 =?utf-8?B?clN0NVltVTJUMDlPQ1VmTzA2VHFYQ1JQcFVJZ2Ztb0c4MzVlaUtPdGZxNG1L?=
 =?utf-8?B?Yy9YanE2NTZLRmlXUW9uQjlJZ0hTNEIzS1k2SnludTBEQThtZFVNTk5LeW1S?=
 =?utf-8?B?WFVSdnlUdzVObEZ1b2w4UU9SamRDaGJkQ2FGZ2x0bE1wWGhBRXJaUWZlcXJW?=
 =?utf-8?Q?1zTaIRnNBL89qQAEPvNC/lcz6cj7AaA7+Ci9ncl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2Z3RngwSHJ5TnlrNDY0aG56d1B1NEw1dHF1RDNoRTNSTjlJSVB6d3MzTWw5?=
 =?utf-8?B?Z05rZTBqejlLdnBUYWx4Y1I3cDZoUTNQVGtock90cTF3WWNVcjFwVG5HWjFl?=
 =?utf-8?B?N2ZYR2FodFh3V3pLNXVpRFBTclNKZGpPZFhEcWx2UWI4cmJYUGZlNjg0YWF5?=
 =?utf-8?B?bUp3YWNkSkxpQjlFQW5SS0JCRVJhdmRaVnNYNWpFd0Z1RFlRNmxuMkVBK2VN?=
 =?utf-8?B?S0g1S09tRnl4TUFrRTBxdktUTVZwM3hHVXRPQzRiVGo4amYwa0JPcThsQTBh?=
 =?utf-8?B?VFhJY1VBdXNLYmZveldCV0VRdG40bWhDNDRoNGJ3cmFzbWpkd3F3akpCM3pR?=
 =?utf-8?B?ZDRoQWZUd0k1cGtYRnIzOHhnVnR4eHU2ZnB6UzM2cDJwYUxoRzVLZzl1ZGky?=
 =?utf-8?B?d0RudnNodlV0UGNBQWdWTHVHVU9xa1FveEJ3ZmJvUmFxeHp5cDFWUHNIVzZJ?=
 =?utf-8?B?ZHdlSTdsZ25wT2hwSDdGOER5bHc0dUhDYVpwcWJoN09EQTVVaCsrcEpXYVcv?=
 =?utf-8?B?VjBYRnRtNEtkVzl2QlpMODluNEpqNjEydWNydXFYZGllaEJHSC9jMUFvaC80?=
 =?utf-8?B?aDZkRlNMbk0wM1RFRmo0L09lSkhDZEtpeUtmVDArV2JGb0ZoOWx1eHZ3aXY3?=
 =?utf-8?B?c2d4aXZZcHN2eVgyRXVCUDJ0UUJRZFFWd1NUK2YvU1gyK0hRQ1pWTkRHeE9G?=
 =?utf-8?B?OURGdFZvaVl5N0F3TitPU1BuZldkZnZUZ0t0Vit5UE82OCtvMlhUeC9VZmNW?=
 =?utf-8?B?OEZDTkRrY1hXMytkYzFZY1cxSzF1bGM0T3MyMk8rMG5tR2pjQXhpMHVIVGov?=
 =?utf-8?B?OHRFb0JNdWY1bnNhQVlEZDVQZlZQdy93a0tYUlNXYnQ5NWxFUlc3WlJtaU0x?=
 =?utf-8?B?WE1sU2Vja1N3MkZvSXEwSGFJZXlzQkhLN3hEQ2MzeG5CWWJyMlhYUHJ4UjhT?=
 =?utf-8?B?bkllMUtXdzhQQUpsV1M4M3ZyZWNtTEpxcVdTTXNKODlMTDJzVEtwNWowTUda?=
 =?utf-8?B?WGdSYzVuck16UThYZjdkcGREMHZOU2xrajZuMmlmNTBGRHNXbEZKNm95dCt3?=
 =?utf-8?B?RFFQaXE0eDBRZHBQb1dKMkE0LzkzWVhSTmEyOTd3bFowaTE3NkNjZElheFpm?=
 =?utf-8?B?WWdJd281TUFSUXpGWnpudjcvQnlDNng4d21qWG1OSjFybkNwQ0pRN3p2RWFL?=
 =?utf-8?B?UHNHUVJaeXBhWnNBQXQ5ZWZVOEY2d216NVZkUVZ4N1l1T2FmMjdxbFAza2ZB?=
 =?utf-8?B?cWxYRGdaci92M3NKNkFHSklCOC9lUVMzWGJaSnhEVzVEbElkQjF4UEpacnZJ?=
 =?utf-8?B?U204M21UU09EVEVWcmM2ZXA3Nk9kbGVKaVR6NldiM0VWSXNKMVZzcnhJSis1?=
 =?utf-8?B?QmNER1BueDlaZDZBUHk4ZnpYUVlrYVpVVXV3eUF0VmV1QnRPMWJoeFg1NGxo?=
 =?utf-8?B?ZWlXaSt5a2ZQSUtjNklYcGJNQW04QlArSjB5UTlrM3FRWlZXNW4zeXdBOTJu?=
 =?utf-8?B?WlQ0SlRlQWFIQ1l2Rjc1VEs2OEkxb1NwdFdlK1hiUkpsM0hCa2FQYjQ0SWpM?=
 =?utf-8?B?VlJLNUJjUUNWS3BoSG9NR0hLakFydU8zaEQ2MWwrRG53OEJMY2dTaTQrdXdq?=
 =?utf-8?B?VVpOaTlPV0IwcWtxcHdnelQrM2J0dUlsNmJwSXNoandHNUNMbjM4TG1COGxi?=
 =?utf-8?B?S1N3SXM0R3Jac1pTTFJIQjlWRDgyWSt3aFNsd1pHak1jMUpoa3czSm10OVVS?=
 =?utf-8?B?RXUyMmhDNFJiV1ZEOFhFd1lwNVR0b21DVXd1VEdBbDV2VnJJTzV3U0hzZG02?=
 =?utf-8?B?dXNwbVN2dW1hbllnbjlISkViZ3lYZW5DSnZPRDFYQ20yMjNWYTJ0bDFvS0xk?=
 =?utf-8?B?RDNOVEYyZkRsL29CcWVvdUxWTk5PdFczVEVYOHlHQUVUYkRLNkM3Mm1DOVpt?=
 =?utf-8?B?U01GY0Y0aEpMdkpLVzdoQU5lL3QybkFuTlhrdmxMb3BCTnRzQVI4T2hoOG1O?=
 =?utf-8?B?cnBReXJRZ1p0anN0TnNnc1VrVStxajd4NDBRMWdDYkFLcjRjN0Z4MHFpMkZF?=
 =?utf-8?B?b05qSmw3RTQyRVMzakU4MkExQ085MmExa3RqRWEyby92S3VKSU5FQVRNV0gz?=
 =?utf-8?B?bTU0aHRxQVhCLy9CTVFXaFVUdW9vV0JvWFA0M0JjM2hIMWdvdUR2TGxUU1VW?=
 =?utf-8?Q?SRnf16jatq07f4HOGLShC3c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C22FD5034B63747B216CAFC714F3EC7@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a66f7763-2a48-469b-7822-08dcffeb21bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 11:47:32.7585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjC1v6JufeAQUOhrQILCBLLnN2KrTYGtCKtR/dS6BLwFFnTGEFA1K6Qba6lelQWQb0+YEuqFr2x8Tl+1AwnXU1c7df/SyEr22zkyvAjMNlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3140
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

SGkgU3RlZmFuLA0KDQpPbiBGcmksIDIwMjQtMTEtMDggYXQgMDg6MTkgKzAxMDAsIFN0ZWZhbiBS
b2VzZSB3cm90ZToNCj4gPiBjb250cm9sIHRoZSB3YXRjaGRvZyBpbiB0aGUgUE1JQyB0aHJvdWdo
IFNDVS4NCj4gDQo+IEEgZmV3IG1vcmUgZGV0YWlscyB3b3VsZCBiZSBnb29kIGhlcmUgKHBsZWFz
ZSBzZWUgYmVsb3cpLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWogVmFsZWsgPGFuZHJl
ai52YWxla0BzaWVtZW5zLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIZWlrbyBTY2hvY2hlciA8
aHNAZGVueC5kZT4NCj4gPiAtLS0NCj4gPiANCj4gPiDCoMKgIGRyaXZlcnMvbWlzYy9pbXg4L3Nj
dV9hcGkuY8KgwqDCoCB8IDIxICsrKysrKysrKysrKysrDQo+ID4gwqDCoCBkcml2ZXJzL3dhdGNo
ZG9nL0tjb25maWfCoMKgwqDCoMKgwqAgfMKgIDcgKysrKysNCj4gPiDCoMKgIGRyaXZlcnMvd2F0
Y2hkb2cvTWFrZWZpbGXCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoMKgIGRyaXZlcnMvd2F0Y2hk
b2cvc2N1X3dkdC5jwqDCoMKgwqAgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gwqDCoCBpbmNsdWRlL2Zpcm13YXJlL2lteC9zY2kvcnBjLmggfMKgIDEgKw0KPiA+
IMKgwqAgaW5jbHVkZS9maXJtd2FyZS9pbXgvc2NpL3NjaS5oIHzCoCAxICsNCj4gPiDCoMKgIDYg
ZmlsZXMgY2hhbmdlZCwgODMgaW5zZXJ0aW9ucygrKQ0KPiA+IMKgwqAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvd2F0Y2hkb2cvc2N1X3dkdC5jDQoNCltdDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvd2F0Y2hkb2cvS2NvbmZpZyBiL2RyaXZlcnMvd2F0Y2hkb2cvS2NvbmZpZw0KPiA+IGlu
ZGV4IDBlNDVmMGEwOTIyLi5lYjllNzVhYmU0OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3dh
dGNoZG9nL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL0tjb25maWcNCj4gPiBA
QCAtNDI4LDYgKzQyOCwxMyBAQCBjb25maWcgV0RUX0FSTV9TTUMNCj4gPiDCoMKgwqAJwqAgU2Vs
ZWN0IHRoaXMgdG8gZW5hYmxlIEFybSBTTUMgd2F0Y2hkb2cgdGltZXIuIFRoaXMgd2F0Y2hkb2cg
d2lsbCBtYW5hZ2UNCj4gPiDCoMKgwqAJwqAgYSB3YXRjaGRvZyBiYXNlZCBvbiBBUk0gU01DQ0Mg
Y29tbXVuaWNhdGlvbi4NCj4gPiDCoMKgIA0KPiA+ICtjb25maWcgV0RUX0lNWF9TQ1UNCj4gPiAr
CWJvb2wgIkVuYWJsZSBleHRlcm5hbCBXYXRjaGRvZyBUaW1lciBzdXBwb3J0IGZvciBJTVgiDQo+
ID4gKwlkZXBlbmRzIG9uIElNWDggJiYgV0RUDQo+ID4gKwloZWxwDQo+ID4gKwnCoCBTZWxlY3Qg
dGhpcyB0byBlbmFibGUgdGhlIGV4dGVybmFsIElNWCB3YXRjaGRvZyBkcml2ZXINCj4gPiArCcKg
IGNvbnRyb2xsZWQgdmlhIElNWDggU0NVLg0KPiANCj4gSSBkb24ndCBrbm93IHRoZSBkZXRhaWxz
IGhlcmUsIGJ1dCB3aGF0IGV4YWN0bHkgaXMgImV4dGVybmFsIiBoZXJlPw0KPiBJZiBpdCdzIHN0
aWxsIGluc2lkZSB0aGUgaS5NWCB0aGVuIGV4dGVybmFsIHNvdW5kcyBhIGJpdCBtaXNsZWFkaW5n
Lg0KDQpJbiB0aGlzIGNhc2UgdGhlIFdEVCB1c2VkIGluIGluIFBNSUMgY2hpcCwgZXh0ZXJuYWwg
dG8gaS5NWDggU29DLCB3aGlsZQ0KaW14IFNDVSBmaXJtd2FyZSBvbmx5IGFjdHMgYXMgYSBwcm94
eS4gTWF5YmUgc29tZXRoaW5nIGxpa2Ugcy9leHRlcm5hbC9QTUlDLw0Kd291bGQgbWFrZSBtb3Jl
IHNlbnNlLi4uDQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy9NYWtlZmlsZSBi
L2RyaXZlcnMvd2F0Y2hkb2cvTWFrZWZpbGUNCj4gPiBpbmRleCAwYjEwN2MwMDhmNy4uZTk0M2I5
MDRiYWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9NYWtlZmlsZQ0KPiA+ICsr
KyBiL2RyaXZlcnMvd2F0Y2hkb2cvTWFrZWZpbGUNCj4gPiBAQCAtMzMsNiArMzMsNyBAQCBvYmot
JChDT05GSUdfV0RUX0RBOTA2MykgKz0gZGE5MDYzLXdkdC5vDQo+ID4gwqDCoCBvYmotJChDT05G
SUdfV0RUX0RBVklOQ0kpICs9IGRhdmluY2lfd2R0Lm8NCj4gPiDCoMKgIG9iai0kKENPTkZJR19X
RFRfRlRXRFQwMTApICs9IGZ0d2R0MDEwX3dkdC5vDQo+ID4gwqDCoCBvYmotJChDT05GSUdfJChT
UExfVFBMXylXRFRfR1BJTykgKz0gZ3Bpb193ZHQubw0KPiA+ICtvYmotJChDT05GSUdfV0RUX0lN
WF9TQ1UpICs9IHNjdV93ZHQubw0KPiANCj4gUGVyaGFwcyBiZXR0ZXIgdG8gYWRkIHNvbWUgImlt
eCIgdG8gdGhlIHNvdXJjZSBmaWxlIG5hbWU/DQo+IA0KDQpPciBtYXliZSBldmVuICJzaWVtZW5z
IiwgYXMgd2Ugd2lsbCBzZWUgYmVsb3cuLi4NCg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3dh
dGNoZG9nL3NjdV93ZHQuYyBiL2RyaXZlcnMvd2F0Y2hkb2cvc2N1X3dkdC5jDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMC4uYWQ4NzY2ZGMxMzINCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy93YXRjaGRvZy9zY3Vfd2R0LmMNCj4gPiBA
QCAtMCwwICsxLDUyIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8ZG0uaD4NCj4gPiArI2luY2x1ZGUgPHdk
dC5oPg0KPiA+ICsjaW5jbHVkZSA8ZmlybXdhcmUvaW14L3NjaS9zY2kuaD4NCj4gPiArDQo+ID4g
Ky8qIHdhdGNoZG9nIGNvbW1hbmRzICovDQo+ID4gKyNkZWZpbmUgQ01EX1NUQVJUX1dEVCAweDU1
DQo+ID4gKyNkZWZpbmUgQ01EX1NUT1BfV0RUwqAgMHg0NQ0KPiA+ICsjZGVmaW5lIENNRF9QSU5H
X1dEVMKgIDB4MzUNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc2N1X3dkdF9zdGFydChzdHJ1Y3Qg
dWRldmljZSAqZGV2LCB1NjQgdGltZW91dF9tcywgdWxvbmcgZmxhZ3MpDQo+ID4gK3sNCj4gPiAr
CS8qIHN0YXJ0IGV4dGVybmFsIHdhdGNoZG9nIHZpYSBUaW1lciBBUEkgKi8NCj4gPiArCXJldHVy
biBzY190aW1lcl9jb250cm9sX3BtaWNfd2RvZygtMSwgQ01EX1NUQVJUX1dEVCk7DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc2N1X3dkdF9zdG9wKHN0cnVjdCB1ZGV2aWNlICpkZXYp
DQo+ID4gK3sNCj4gPiArCS8qIHN0b3AgZXh0ZXJuYWwgd2F0Y2hkb2cgdmlhIFRpbWVyIEFQSSAq
Lw0KPiA+ICsJcmV0dXJuIHNjX3RpbWVyX2NvbnRyb2xfcG1pY193ZG9nKC0xLCBDTURfU1RPUF9X
RFQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHNjdV93ZHRfcmVzZXQoc3RydWN0
IHVkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJcmV0dXJuIHNjX3RpbWVyX2NvbnRyb2xfcG1p
Y193ZG9nKC0xLCBDTURfUElOR19XRFQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50
IHNjdV93ZHRfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJZGVidWco
IiVzKGRldj0lcClcbiIsIF9fZnVuY19fLCBkZXYpOw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgd2R0X29wcyBzY3Vfd2R0X29wcyA9IHsN
Cj4gPiArCS5yZXNldAkJPSBzY3Vfd2R0X3Jlc2V0LA0KPiA+ICsJLnN0YXJ0CQk9IHNjdV93ZHRf
c3RhcnQsDQo+ID4gKwkuc3RvcAkJPSBzY3Vfd2R0X3N0b3AsDQo+ID4gK307DQo+ID4gKw0KPiA+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IHVkZXZpY2VfaWQgc2N1X3dkdF9pZHNbXSA9IHsNCj4gPiAr
CXsgLmNvbXBhdGlibGUgPSAic2llbWVucyxzY3Utd2R0IiB9LA0KPiANCj4gUmVhbGx5IHNpZW1l
bnMgc3BlY2lmaWM/IElzIHRoaXMgYWxzbyBhdmFpbGFibGUgaW4gTGludXggYnR3Pw0KPiBMb29r
aW5nIGludG8gdGhlIExpbnV4IHNvdXJjZSwgaXMgdGhpcyBkcml2ZXIgc29tZWhvdyByZWxhdGVk
IHRvDQo+IHRoaXMgb25lOg0KPiANCj4gZHJpdmVycy93YXRjaGRvZy9pbXhfc2Nfd2R0LmMgPw0K
DQpbXQ0KDQpJbiB0aGUgcnBjLmggYmVsb3cgbmV3IFJQQyBmdW5jIGlzIGJlaW5nIGFkZGVkIChU
SU1FUl9GVU5DX0NUUkxfUE1JQ19XRE9HKSwNCnRoaXMgb25lIGlzIGV4Y2x1c2l2ZSB0byB0aGUg
U0NVIEZXIHdlIGJ1aWxkIGludGVybmFsbHkgYmFzZWQgb24gTlhQDQpwcm92aWRlZCBtYXRlcmlh
bC4gV2UgbmVpdGhlciBoYXZlIHRoZSBmdWxsIHNvdXJjZSBjb2RlLCBub3Igd2lsbCB3ZSBiZQ0K
YWJsZSB0byByZS1kaXN0cmlidXRlIHRoZSBzb3VyY2UgY29kZSBmb3IgdGhlIGZpcm13YXJlLiBT
bywgeWVzLCB0aGlzDQp0dXJucyB0byBiZSBTaWVtZW5zLXNwZWNpZmljIGRyaXZlci4gSXQgZG9l
cyBsb29rIHNpbWlsYXIgdG8gdGhlIGlteF9zY193ZHQuYw0KZnJvbSBMaW51eCBvbmx5IGJlY2F1
c2UgaXQgaW5kZWVkIHVzZXMgdGhlIHNhbWUgUlBDIEFQSSwgYnV0IGFjdHVhbGx5DQphIG5ldyBm
dW5jdGlvbiBhZGRlZCBvbiB0b3AuIFRoZSBMaW51eCBkcml2ZXIgdXNlcyB0aGUgZmlybXdhcmUg
V0RULA0KaW1wbGVtZW50ZWQgaW4gU0NVIEZXLiBTbyBvdXIgYnVpbGQgb2YgU0NVIEZXIGhhcyBh
Y3R1YWxseSBzdXBwb3J0IGZvcg0KdHdvIFdEVCB2YXJpYW50cyBhbmQgdGhlIG5ldyBVLUJvb3Qg
ZHJpdmVyIHByb3ZpZGVzIHRoZSBzdXBwb3J0IGZvcg0Kb3VyIHByb3ByaWV0YXJ5IG9uZS4gDQoN
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9maXJtd2FyZS9pbXgvc2NpL3JwYy5oIGIvaW5jbHVk
ZS9maXJtd2FyZS9pbXgvc2NpL3JwYy5oDQo+ID4gaW5kZXggMjhhZGVjMmE4ZTEuLjk0NzBmOWU3
MTc4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvZmlybXdhcmUvaW14L3NjaS9ycGMuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvZmlybXdhcmUvaW14L3NjaS9ycGMuaA0KPiA+IEBAIC0yMzAsNSArMjMw
LDYgQEAgc3RydWN0IHNjX3JwY19tc2dfcyB7DQo+ID4gwqDCoCAjZGVmaW5lIFRJTUVSX0ZVTkNf
U0VUX1NZU0NUUl9BTEFSTSAxNlUgLyogSW5kZXggZm9yIHNjX3RpbWVyX3NldF9zeXNjdHJfYWxh
cm0oKSBSUEMgY2FsbCAqLw0KPiA+IMKgwqAgI2RlZmluZSBUSU1FUl9GVU5DX1NFVF9TWVNDVFJf
UEVSSU9ESUNfQUxBUk0gMTdVIC8qIEluZGV4IGZvciBzY190aW1lcl9zZXRfc3lzY3RyX3Blcmlv
ZGljX2FsYXJtKCkgUlBDIGNhbGwgKi8NCj4gPiDCoMKgICNkZWZpbmUgVElNRVJfRlVOQ19DQU5D
RUxfU1lTQ1RSX0FMQVJNIDE4VSAvKiBJbmRleCBmb3Igc2NfdGltZXJfY2FuY2VsX3N5c2N0cl9h
bGFybSgpIFJQQyBjYWxsICovDQo+ID4gKyNkZWZpbmUgVElNRVJfRlVOQ19DVFJMX1BNSUNfV0RP
RyAyMFXCoCAvKiE8IEluZGV4IGZvciBzY190aW1lcl9jdHJsX3BtaWNfd2RvZygpIFJQQyBjYWxs
ICovDQo+ID4gwqDCoCANCj4gPiDCoMKgICNlbmRpZiAvKiBTQ19SUENfSCAqLw0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2Zpcm13YXJlL2lteC9zY2kvc2NpLmggYi9pbmNsdWRlL2Zpcm13YXJl
L2lteC9zY2kvc2NpLmgNCj4gPiBpbmRleCA3ZDg0OTlmMDcwYS4uYjk3MWI2MjgzNmQgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9maXJtd2FyZS9pbXgvc2NpL3NjaS5oDQo+ID4gKysrIGIvaW5j
bHVkZS9maXJtd2FyZS9pbXgvc2NpL3NjaS5oDQo+ID4gQEAgLTEyMyw2ICsxMjMsNyBAQCBpbnQg
c2Nfcm1fc2V0X21hc3Rlcl9zaWQoc2NfaXBjX3QgaXBjLCBzY19yc3JjX3QgcmVzb3VyY2UsIHNj
X3JtX3NpZF90IHNpZCk7DQo+ID4gwqDCoCANCj4gPiDCoMKgIC8qIFRpbWVyIEFQSSAqLw0KPiA+
IMKgwqAgaW50IHNjX3RpbWVyX3NldF93ZG9nX3dpbmRvdyhzY19pcGNfdCBpcGMsIHNjX3RpbWVy
X3dkb2dfdGltZV90IHdpbmRvdyk7DQo+ID4gK2ludCBzY190aW1lcl9jb250cm9sX3BtaWNfd2Rv
ZyhzY19pcGNfdCBpcGMsIHU4IGNtZCk7DQo+ID4gwqDCoCANCj4gPiDCoMKgIC8qIFNFQ08gQVBJ
ICovDQo+ID4gwqDCoCBpbnQgc2Nfc2Vjb19hdXRoZW50aWNhdGUoc2NfaXBjX3QgaXBjLCBzY19z
ZWNvX2F1dGhfY21kX3QgY21kLA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBB
Rw0Kd3d3LnNpZW1lbnMuY29tDQo=
