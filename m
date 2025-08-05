Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B67C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE16831E0;
	Tue,  5 Aug 2025 16:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="r72pd3ZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48FE83560; Tue,  5 Aug 2025 16:31:54 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73CF383045
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3ky1NhJR1OJJeh1xfvq5L9WFcUrKtsPcmssLbkjEFufqmCRoBPUNtb8Q5n1cQMpKeUXsT62Uof7m36l2btzrcPdWPYAZYGTiwjAg6UECmI/l5lmRFHuD4VEB4Sk5SNEH5xz4m7ylxMntfi/sQ2xeePc6lZyOGEjgSpnxe2Jf0vlK/xUJrTyMW8SaGBTcY/sr2AKo+oxgA2Q+dVf6FU+8hsNEMO7mMR/rLaJNd5Ti4L4LmhhmPm6JZ1ab+Luqm9KDjrxMjIqKdqBrh85NZUUTsziyUV6zO7CFQ9YG7xiUBgLvn6YnuObU6NZJ3E+4kEQbmbbtCYNVeZt15TLQVqBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsLXsXT5dbhVxEpO9Qg58QJfgO0rxrNYLenqVvLa8mQ=;
 b=RjqIG7F1y/CiCDpdKFvOkGnZPRSuhY3+yAgOkmbEZ251sKDmWT/sKSXdwy58J2KCyu1Auh64b9Ackxy1syJyUEDKpZ5YIkmlSUeJYRV3ixWavY3nSeTJfQ47ZCNy1optiiyVc4EuNsViCvBW5MflYgDeMYYN5xutr3JSPi2GvWPfLXSDv8+bugt+Lf6jZALJmImXtB+n+dzpJJ+Y03HL8yTUPi6Uj3XsexGwjbSnS+++7bXWnujJBx0lbYBchrmzMWcm+oi1knyNJmRXel+sFLfkdAaZgpYb5uU029FO3fJfeax1xU7RUSoltkKh/pFhuSaWU7VWw3u6AwBFRYFLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsLXsXT5dbhVxEpO9Qg58QJfgO0rxrNYLenqVvLa8mQ=;
 b=r72pd3ZCNCGNIXjfV8zzrCRDRhLcFo5xmtWoHsRgJAvNibs5hdwZz1g9B8Hb4e/89mfLPMBh/BxCzeEImKJwQW1dFKHuj/H4C5b9N5ToigcY2bkPh4EbJL6qtWu2n53i+siGoUOu6EjaBnnLoL41i3jQ2JlDsRvXueWqLvThqpHPuxZlD0n/JrAKnb/dUC0AsYXba20bULv+6Gk6j0ZzU2Eplj6E6KZyOM3LAbyU8PImOB0EvP4+hcuEBeuCeG5iDrBgrdNeybdB1VrI9ZoZtOrvuv71EDySF50KqnaCTUpTbN8diTB8rRoaV5adbCIUxDd/+VlicKXPDNmLJXEWlg==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by PAXPR06MB7456.eurprd06.prod.outlook.com (2603:10a6:102:151::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Tue, 5 Aug
 2025 12:58:42 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d%6]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 12:58:42 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Topic: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Index: AQHcBe0S3kynZXd3OkScXc3RsybZB7RT4fIAgAADLRCAAAP5gIAAAjowgAAL0ACAAANjcIAACDgAgAAAdIA=
Date: Tue, 5 Aug 2025 12:58:42 +0000
Message-ID: <DB9PR06MB7849C9363027FCAA3A35085FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
 <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p97w3vAkvOPp2=OCXrZ5qS8iDDtT0EJ-0iNO-k3LEXMrCQ@mail.gmail.com>
 <DB9PR06MB78490807DEBB894CC3EDE4ACC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p94jcSeOPP9dmPLM=-=Mdd8wd6NRFBvTi2Wn60O=38unMA@mail.gmail.com>
In-Reply-To: <CADg8p94jcSeOPP9dmPLM=-=Mdd8wd6NRFBvTi2Wn60O=38unMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.22.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|PAXPR06MB7456:EE_
x-ms-office365-filtering-correlation-id: 5c477072-0b21-4c8c-5407-08ddd41fce06
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?elVYMll6SmxBN2E1S0dJUy9EMEhUdThpTG9BdG1Wb25aeHV1ODA2YnBuNGgv?=
 =?utf-8?B?WjRhbjNFMVJPazFNSm5ocVpBV3kvR0lQa3pkTll0UVlhbWtKQld2WjB0VE5M?=
 =?utf-8?B?UTZuRTRMODdKMUIrdnl6elFpcWQ4cStXcWhRek0ra0JoMTF6bm5SSDdXVVFq?=
 =?utf-8?B?QlFzQ1lpZER6OWx5UXB5MEU2ZldVQXRDeEMrT2R1NlFYeEdRTWVDQlNseGZH?=
 =?utf-8?B?cG40Q2dLVHRnZnd1Mk5PZ0YydkxpRjh1aVN3R1lKZXE2OEMxVjRkUjROTnJH?=
 =?utf-8?B?WTRPT29KUkx2ZjFtUnkvVE9BL2NEbTZsbkhYdmRCZzVQbCt3clhibGNDR3pa?=
 =?utf-8?B?ZWltRG9MQ09vUlJwejFzL3Vacjh5UGNMbmpXZUtyajI3U2dYeXczSWxqNUpJ?=
 =?utf-8?B?VWJhQVgwNlROeCtMQVJoeHJZdUJENXNycG1FaGJRUHozT3pVNlVIditFY1N3?=
 =?utf-8?B?SktzVlRaUFA3enJQVlV2ek1mL3Rmc2VHK3BDV1dHUkFpOWRtVUx1UFA5azdX?=
 =?utf-8?B?djE3UUlIVjl0NzcyRGQybXNYV0YxNlJnSFJ6a2pmUjY3MjBNaUMxOWE1UE8z?=
 =?utf-8?B?dFNMU1pMSU8wbjBtQ2NMYm1NMUtRUXptT0VvRXFTQjR1dk1KNjAzYVBCSjlM?=
 =?utf-8?B?TDZoQW9rRzZNSDNzdjZzSkhMamE2VDNDMkJjMGcydWxMU0U1Vk5heTVFY3JY?=
 =?utf-8?B?UVhCVko0VkxlUFhWN28za2krSDhVbHdLbmc1ejF2eXBud0VPb3BiQmt6NDNC?=
 =?utf-8?B?NEJkZUhXNSt3dHFGdnE3SmZMaHFaQzVqLy9tTS9taXU4NHl5S1lmbm1yTHVX?=
 =?utf-8?B?enRvMG5RVWg5TW5JWXlISjFuQTkxRWdxRGhjL3BiU0Q2eXhYc2JCVC9xSnY0?=
 =?utf-8?B?Kzk5NmFBcGMxcUNrYVR1ZWcyTld0YnVNcFJrUWc5TjJPcVV5Qkk3MVVkUGFV?=
 =?utf-8?B?NUxIY01KbUtxaW43QWZ6dUpLZWwwVFdjTFF2bEw1WTFpQkY0OUhuYkl5S1JO?=
 =?utf-8?B?eW8zczhvMkI0UTRjVXpVc2tSWFhaQU9ZayswNExBZzdjem5FR1B6d0g1VldO?=
 =?utf-8?B?RDdLbmRyczBSS2FHbytXbnBMaFY0elhrNHYxUG9pSGlRd2pqU2UwZWxlVUtx?=
 =?utf-8?B?WExJdlNLWGx2Y2V4UGM2K3pPSFd3bDZ2Y3Y3M0VwaGRIOEF0ZXpOcWdXdEN5?=
 =?utf-8?B?cy9KbmpHOFhuMGw5SHF3TnFNYU5EQm9Md3k5OGRzaGdSOVI3ZEJWYlpKajlO?=
 =?utf-8?B?bHNsZnRPd0Vpd2JZdlhEZnNwQ0lEL2ZEckxsazk5dStwV2RGM0tZelVoeGZO?=
 =?utf-8?B?QlY4Ny8rOEhtQXF5dytjOE8xeElYRW5XSGVCV2JrQWpxaTA3WG00YVRxVVQw?=
 =?utf-8?B?L0w1NzExdDNyWHk2djdUN0FVWXNDT2RXY0pMMlVjYWFaS0VpS1QyZ25tczJy?=
 =?utf-8?B?VlhRSGM5S2RmOUZMeG1LS3ZrSU9yTlRvTWE2OEZ2dDdRU3BaUzJmZDhlWXRw?=
 =?utf-8?B?Z2hoaFQzV2tKY2M0K0RZNG4vZElaWWlUZWoyNzFpRUZNc0NtUlpUaHlpNFBr?=
 =?utf-8?B?aVY4KzVxdm0zU2dhcWc0TVVjMjFGNjg4enM2bC8xODlIVDZ1WHdJazZZQXNX?=
 =?utf-8?B?cXhjNzZZUlJVcklUNlNKOXpiUnFsK2ExQnVCMDFFeUtqZ21sVkFVbnZ6bXFX?=
 =?utf-8?B?N0E5TEdSekNhRlltQTlKaHF6Q2J3NHJnc3dlVVJqUTQxcCtUUThQZzByUjl2?=
 =?utf-8?B?TTcyZGoxREM5dHpSeFlwaFJSOC9zY3c3QzZIMWJYSFJ3MHNIcTdhMVBqVm01?=
 =?utf-8?B?V1lrTDBkYVRtcGh6NWNLUWtBTEhXK00zWVBkWEFRNHhNcDZrV2w0OVd3OVNu?=
 =?utf-8?B?ZVBYKyt5VnM5TGVpdEtZTzdFZDdkR3J4ODlUd1FqUlpmRE1ldy84enJ5THBa?=
 =?utf-8?B?RFlhbGdMN2J3YUQ0VjhjVGtZcGdMZm8ybFpmRVFmdEVKeTNQdXkvRjN6eDNl?=
 =?utf-8?Q?f0HZ0vCeymhaf8l9ZMUyI7r+xxLpuA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE9qTUpYbHlPUU5uQTNISlZQYkRIYXJLNnJPdlY2WkNuelROY1I0TkdXSnZ5?=
 =?utf-8?B?NUY5TEhDL01UbG9sVUxnYU5Fc1JqRStTWlNUTjFBZlkxMHBURHBUUlNUa3NS?=
 =?utf-8?B?LzJibmNlU3BqWW1FR2ZCcnhsNjlPM2oxd2VTaW9lcDViOVY1ZCtxNGNkVnEx?=
 =?utf-8?B?MlREQTRUTVVleU9tTHg0SUpCQmFYREg0UFEvbzQ3MkxBbS8xMW93RGt3QURy?=
 =?utf-8?B?UFZPK0NIRGVwUXBFSG9rd2ZlTlVxcFVseHl5ZXhzczI5Ymp6RWhsY3BYck5P?=
 =?utf-8?B?Q2hESGtrUGdaVzUwb2p4SFhhRkNISDJFTXVYUDBmMWQxQXRWWlVhSVMrcnNR?=
 =?utf-8?B?SjNSa1J5OEhaYTRBczQ5eHRReE8ya3NQQ3d4cFlLNDNSY3VGbndHQWdyRzZW?=
 =?utf-8?B?TzY3UnZvWXBGSG9uZzhCMDRxTFU2cEpBN0dOR2lVbmxFNE04ZXQ3dDR6Mjh1?=
 =?utf-8?B?VGNzTnpzUFErSDNtY0gwU3pNT3pkL0E5RXBtZmFFdXFsMlNmbTYvRG12Smh3?=
 =?utf-8?B?cm1DRXZYNlprQWY4MytTb29Rd1dSSnlTVkxEUlRsb1FPL1dVNHpNOWpEVG0y?=
 =?utf-8?B?d1BOUGc5TEZxdElOdDlzd21TOVN3NnJNOFR6YUxhRnZKV3ZsMGxNbVduUEtO?=
 =?utf-8?B?SUZOcmdYUGtBTmRKRWlMRnUrWW45SVc2dGh3b212bnl2OWpEN2RRUHZqZzZq?=
 =?utf-8?B?TXBod0w5NGUzSC9mRSt2QW9PN25WbmVqNG4xdVFZU0tROEdFK1Rta2NVdXdl?=
 =?utf-8?B?aTdieTk4c3NteGpIQTdid2ZRa0NQTU5BMUNFYk1zOVBzR0tBOFdvRkROYjRo?=
 =?utf-8?B?ODZpUkV5K0dZa0dRMzJzc3dtQmtVZERxekVQTS9RMSs1cnVlbmZjV0hCQmJo?=
 =?utf-8?B?OW44dGRzUzdZMzNLRHZUM0srb1IvMmtzcFF5Qnl0b0tWa2pIRVNXUjhkRXJ5?=
 =?utf-8?B?K3FoYnNlNVB5RWUrUTFDeGh4OVQxRldwVWlra1RRWlNrNjZLb2Z6a2d4ZnVK?=
 =?utf-8?B?aDBjdDNZWWFnM09WNFNOTTJXTzE2K1lUSFMvVlJ3dEpxR1BVWk5NTnlITFZn?=
 =?utf-8?B?SE15VXFQZWs3YlFxdVEydUg5TFhkL010M0pmWUNtL0RQTlRSTFRVSXJ3dCti?=
 =?utf-8?B?akxHUkdsK1RLNXNLUmswUjhad01VancrdDJNL2VVdDFTdXJvbS9sVEdHRDds?=
 =?utf-8?B?NUNDZzZWQzM1c2pUNmV4QTVnc0JoNmI3bHZST2tKNTdZSUhtcm15R09WYm9J?=
 =?utf-8?B?MUFEbzc2YTFsRmZjYzVJWnZxN05HaXY3blp1Rlh0WDVwU2sxcXl2TkRnVjJU?=
 =?utf-8?B?bldDOHAyb0UyOUpITGhQT0p3eGU5a0pLVVF3ZER2b00vV2hZUzIxTGtvVk1m?=
 =?utf-8?B?VFh5Ujl4ZDJPdjZ0YjVlZm9zeUFpMG8zSkd5Q2piSG94VnB6S3BLTzhvS2lK?=
 =?utf-8?B?L3ZocmxuQUZnTnpROWJDbUFQR0IrZm01ZHhGVU1oYkRzOTh2REhaV3V1MGUw?=
 =?utf-8?B?aDJuZVF6OVRGdHcvVFZ4YVFYMlBpL3BDNmRrcHM2M29DcEpGaGVHZTVqY2Vt?=
 =?utf-8?B?Ynp0U2E2cFpjalB1c0o2WVlPMTlLWVgvUTlCVUhXL3NDV3hGUnNXRDVJcExU?=
 =?utf-8?B?czczTWNzenIxR3ZGNmhJd1hXSVAxRDlYOFdVaEFMazdBblM4WGFJUHE5TUoz?=
 =?utf-8?B?QkZXeFMzdzRIWkRTSFV5OXpFWFVLRDVIU01SeXZYbTBhdG0yL2I1M0Z3d3NU?=
 =?utf-8?B?Zk1sNGs3dkI2akJZV2hqVVR6VFFxSWpIa0JkOHo1dWd1ZVVhckpKVDNFRS9K?=
 =?utf-8?B?OXU4WFc2TUZTWEVyMWJ3aUliQlRaSGVXVjZtZHBPclpnN1BFanQ3TnJOd2wv?=
 =?utf-8?B?Ykp1aGJlZjlCQk16L2RiUkQ0ZFlMSkxLSFJrOHMwYWZEeUc4dVJtY1lRcHN5?=
 =?utf-8?B?UkpmdjRYNzZ6VzExNDlKWDZXSm1DQ1lzTjRySzEyNGZkUFFUK0xFRlo2dEVl?=
 =?utf-8?B?cUpncnRnQ1g0Q1J2QXVJUjlrUy83bjJuUmRyaTI4bFFReVNEWGdiREhFdVhK?=
 =?utf-8?B?Rm1saUloMUF5YU8yVERpcXA1MjZoQytvMGVrOE15OWJ1dFlzUEJoM2JSOXY5?=
 =?utf-8?B?bWtCTGpjNktiNlNybG5ORUpPQVdjbXBpWU1zdmx2V0xJbGx4c28zM2xWTE9O?=
 =?utf-8?Q?lLyQs+WBy8StTcTNJBq6qTY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c477072-0b21-4c8c-5407-08ddd41fce06
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 12:58:42.1930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GayfVNWxshF30abl+iCb2pR9HE4JGKd+7TrkIyCKcTVLS3snCxiicdUHSKN45jCXVLxbmRgIamJ+4FKDELaooPo38THUV/1I9iTRmpHQe9aQbD6UkFO9f9h/UA8sdC5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7456
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

Pj4gSSBhbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbiB3aXRoICJ0aGVyZSBp
cyBubyBndWFyYW50ZWUgYXMgdG8gd2hlcmUgdGhlIGZpcnN0IGNodW5rIG9mIHVzZWQgbWVtb3J5
IGxpZSBhYm92ZSB5b3VyIHJvb3RmcyBtZW1vcnkiLg0KPj4gSG93IGlzIGl0IGRpZmZlcmVudCB0
byB3aGVuIGl0IHdhcyBsb2NhbD8NCg0KPkVhcmxpZXIsIHdpdGggYSBsb2NhbCBsbWIgbWFwLCBv
bmUgY291bGQgZGVmaW5lIGEgbWFwIGluc2lkZSBhIGZ1bmN0aW9uLCB3aXRoIGF2YWlsYWJsZSBt
ZW1vcnkgYW5kIHVzZWQgbWVtb3J5IHdoaWNoIGNvdWxkIGJlIGNvbnRyb2xsZWQgaW5zaWRlIHNv
bWUgZnVuY3Rpb24uIFRoaXMgaXMgbm8gbG9uZ2VyIHBvc3NpYmxlLiBUaGVyZSBjb3VsZCBiZSBh
biBhbGxvY2F0aW9uIHRoYXQgY291bGQgaGF2ZSBoYXBwZW5lZCBhYm92ZSB0aGUgcm9vdGZzIG1l
bW9yeSwgd2hpY2ggd291bGQgbWVhbiB0aGF0IHRoZSBmcmVlIG1lbW9yeSBjb21wdXRhdGlvbiB3
b3VsZCBiZSBub24tZGV0ZXJtaW5pc3RpYy4gU28gd2l0aCBhIGdsb2JhbCBhbmQgcGVyc2lzdGVu
dCBsbWIgbWVtb3J5IG1hcCwgdGhpcyBpcyBubyBsb25nZXIgYSByb2J1c3Qgd2F5IHRvIGNvbXB1
dGUgbWVtb3J5IGF2YWlsYWJsZSBmb3IgdGhlIGtlcm5lbC4NCg0KVGhhbmtzLCBub3cgSSBnZXQg
aXQuIEkgdGhpbmsgZm9yIHRoZSBtb21lbnQgd2Ugd2lsbCBrZWVwIGl0IGxpa2UgdGhpcywgc2lu
Y2Ugd2UgYXJlIHJ1bm5pbmcgdGhpcyBjb2RlIGFzIG9uZSBvZiB0aGUgbGFzdCBzdGVwcyBpbiB0
aGUgYm9vdCBjb21tYW5kIChhZnRlciB0aGlzLCB3ZSBvbmx5IHRmdHAgdGhlIHJvb3RmcyBpdHNl
bGYgYW5kIHRoZW4gYm9vdCkgYW5kIGl0J3Mgbm90IGNyaXRpY2FsIGZ1bmN0aW9uYWxpdHkuDQoN
Cj5BcyBhbiBhc2lkZSwgSSBhbSBub3Qgc3VyZSBpZiB5b3UgaGF2ZSBjb25zaWRlcmVkIHVzaW5n
IHRoZSBVRUZJIGludGVyZmFjZXMgZm9yIGJvb3RpbmcgdGhlIGtlcm5lbC4gVGhlIEVGSSBmaXJt
d2FyZSAoVS1Cb290IGluIHRoaXMNCmNhc2UpIHBhc3NlcyBhIG1lbW9yeSBtYXAgdG8gdGhlIGtl
cm5lbCB3aGljaCBzcGVjaWZpZXMgd2hpY2ggbWVtb3J5IHRoZSBrZXJuZWwgY2FuIHVzZSwgYW5k
IHdoaWNoIGlzIHJlc2VydmVkLiBCb290aW5nIHRoZSBrZXJuZWwgd2l0aCBFRkkgaW50ZXJmYWNl
cywgdGhlIG1lbW9yeSBvY2N1cGllZCBieSB0aGUgcmFtZnMgY2FuIHRoZW4gYmUgbWFya2VkIGFz
IEVmaVJlc2VydmVkTWVtb3J5VHlwZSwgYW5kIHRoaXMgd291bGQgbm90IGJlIHVzZWQgYnkgdGhl
IGtlcm5lbC4gVGhpcyBkZWZpbml0ZWx5IGNhbiBiZSBkb25lIG9uIGFybXY4IHBsYXRmb3JtcyAt
LSBJIGhhdmUgbm90IGJvb3RlZCBhIGtlcm5lbCB3aXRoIEVGSSBpbnRlcmZhY2VzIG9uIGFybXY3
IGJvYXJkcyB0aG91Z2guIFNvbWV0aGluZyB0byBjb25zaWRlciBmb3IgeW91ciBzb2x1dGlvbi4N
Cg0KVGhpcyBzb3VuZHMgbGlrZSBhIGJldHRlciBzb2x1dGlvbiwgYWJzb2x1dGVseSwgSSdsbCBs
b29rIGludG8gaXQgZXZlbnR1YWxseS4NCg0KVGhhbmtzIGZvciB5b3VyIHRpbWUgYW5kIHBhdGll
bmNlLCB0aGlzIHdhcyBoZWxwZnVsLg0KDQpSZWdhcmRpbmcgdGhlIGluaXRpYWwgcXVlc3Rpb24s
IEkgdGhpbmsgdGhlbiB0aGF0IHRoZXJlIGlzbid0IGEgY2FzZSB3aGVyZSB5b3Ugd2FudCB0byBn
cmVlZGlseSBjaGVjayBob3cgbXVjaCBtZW1vcnkgeW91IGNhbiByZXNlcnZlIHN0YXJ0aW5nIGF0
IGEgcGFydGljdWxhciBhZGRyZXNzPw0KDQpUb21hcw0K
