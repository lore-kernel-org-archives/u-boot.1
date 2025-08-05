Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD90BC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C7A837B9;
	Tue,  5 Aug 2025 16:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="HCJgbILn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BE9831E0; Tue,  5 Aug 2025 16:21:32 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D871380C59
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT02G18EEQRo3i8QPCZpCb3nfqTn4K843FVzvo9IwCvMOlSYNgwn03QpPXMAq5k42DWmr17hfCYClEPIaxwArxu5JdXyWyuqhK6SjIMfvKAEJ52xTTH39a6MV+Q+57JwdcrtrJeMApByqCcI1uE2CmIQGkrxWUfU9nvZ2ULavU0wpN5pG5/I55IN3T7CJeCtXdRxlvDxBACnAveUftYk2QkEZ9uomLQzitIAjlpPYSkOjQHuMKd02wRP/Hvc3m8OWk3xYPQWJZhsriFcy4w5LgNWYYq/2roB0jTT+GYwYceRiZJHNUQEK1Pd392qIwiPc19flrnh3to+l/zOWRkF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2NEEPZMn83N6FmSlF/PNZvyfRGB/t6ZHKuo0G4/ETA=;
 b=BTpiSGew3cR7jfWorO/uDzyv9UVt+/xHUd2ibK2nYv4CNNVh/ksRIvLNNgcktI3OeyCuGdj11W0m2RU7UhYAS1d/l2FcfjZJ55RR/r8Mbwd0djTwavshdq6OB3A7j+Vy00XeXrHCNjlgOD0LelBt2z09ZQpSoHiDcRktsXc/xZS1x+a9RbhSqueBQXmJzT9Dd65kGmSvJbt7jtS36HP1FmFrWulHI60C47RVWf+DYVDe5qnFy/5qmWC01HluMJ9ZPWnydUpViozjvTxQrWT2EXsAwUmAGZUQJM5ClZujdyqlUv1Y1EkEWLoPqH4Ea1s3xjN1UvSi6cW2VrL9naoOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2NEEPZMn83N6FmSlF/PNZvyfRGB/t6ZHKuo0G4/ETA=;
 b=HCJgbILnv1jWKGWxwzh7iyBzqdlMZVgD4+Gw7aEmEZZVWFA0UTetRe8jpS9XKAcY95E0K1Yg1mtBZYTNigWAVxhozbEFrM811/TGFUBGjON5YGpit2E+5WYHdf1LWTgurUpCY6SnkvhZKCjpW7y7cFTXaZMr6tfA1gW081CvtRuvgBF1LgaRerLO9TYmwZQGCEv0eIqFA0FXi82yNAvs4ZrToqqbJ9UNnM+JsKKbQaHE+CT4HETzuX+YlQt8kP4ZWWu1PYchg3SiZBiS62GfCsWbgoCltP81LSKdUMN++P4pPxbRIxwPB9PS0gfDEb+usIBnxJC7vDvoSSvd0rr/BA==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by PAWPR06MB9011.eurprd06.prod.outlook.com (2603:10a6:102:38f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 12:27:22 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d%6]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 12:27:22 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Topic: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Index: AQHcBe0S3kynZXd3OkScXc3RsybZB7RT4fIAgAADLRCAAAP5gIAAAjowgAAL0ACAAANjcA==
Date: Tue, 5 Aug 2025 12:27:22 +0000
Message-ID: <DB9PR06MB78490807DEBB894CC3EDE4ACC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
 <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p97w3vAkvOPp2=OCXrZ5qS8iDDtT0EJ-0iNO-k3LEXMrCQ@mail.gmail.com>
In-Reply-To: <CADg8p97w3vAkvOPp2=OCXrZ5qS8iDDtT0EJ-0iNO-k3LEXMrCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.22.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|PAWPR06MB9011:EE_
x-ms-office365-filtering-correlation-id: 825861dd-c36f-4673-cf75-08ddd41b6db8
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFN1TFVFUDVSZHFrRUVUa1NmUWo4YndxeHZxK1BqVWltZ08rWE9RYWptZHRH?=
 =?utf-8?B?TDNYcW5tODkyT1FnZzBtTDlVZ2JQRHJuL2k4WUljYlBVeTF5TGxMQzdUOTIv?=
 =?utf-8?B?Rnp5WllUY3pvblVCUkJIVm9nWXF6NCt4L0ZEenUyUXYwME85c0kvZG9kZlhC?=
 =?utf-8?B?emhvY2o0ckNFSXlZdXloOVM4YkJQbHVZQ3BoRmcyWGdCbExBU24vOWJuVW1D?=
 =?utf-8?B?QjUvUzhVMTBXdVNGOHEwQmdBNjY5OU4reDhVOVdZMk1leWs3VmxKbXdiMW90?=
 =?utf-8?B?R0FDMlB1RHlxMHdRSm5abndZNllMVDFlS1NZSktybTBCbGJhaS9iRHhwSWph?=
 =?utf-8?B?MFpNYmszZGwvQk5rM0ZRQkR2QWpUdTVjUnhWTGxTNUl5WlR5OFdEZStCT0R6?=
 =?utf-8?B?aGhuQUZVMitUTDkrb2pNanNjekJHWE50UDkyOXFKaHBRdll3akRacDF1aFJF?=
 =?utf-8?B?aG43MjhrWmRKTCtDbWVxcXUvNSt2TVhSdWNyUW5hOUJlZ04yVDRBblptdUR1?=
 =?utf-8?B?aUU3UENnellFeHgySTllYllnNEhaVHVsTlZYMWo1TEczaTdOZ3dIOWdqaVhp?=
 =?utf-8?B?WWpNZDMraTJmZktsQ3dGTFhWNzl3OEU1dnF1emFabmxFckFXMDdiQlFTQkFr?=
 =?utf-8?B?dS9NWjMranl3ZDViVzBQME1JYWk4cVdyVFo3U1Fmb0htZVdjR0ZZU29OV29x?=
 =?utf-8?B?dEF4bzE3VGFsdktuTjNkblpFbGlVN290RFl4Z0RQTTN0Y1VtUklYZHIxQTNa?=
 =?utf-8?B?R0F3TUkzTEdQcWJMSEdtRHVzUGJPaWxXSjZEZFk3NkorbTIvelRiMFh5NVJO?=
 =?utf-8?B?QjVyaXBkbDgrM3ZlaUppeUFpUS91WTlZeEU2K3NwN2VnUzllcktVR2I2Mld5?=
 =?utf-8?B?QytldFNsczF1Y0JUQXFxYmpST01UaEh6M2k5UEU2TXFVeERVcnBHOWhKRUNB?=
 =?utf-8?B?MWt6YTZoYU5KNll1NXdjd0g4OTBmd3dmZVgxQkVOejhabFdtRjNScGdTcEhq?=
 =?utf-8?B?dVdPTlU1cHpiTXhiR0ZNYTdza0FGb1dMUmd5WjUzbisrYWdzTlMwV2NBOU1Z?=
 =?utf-8?B?Kzd0WFUrdE5vNzhhSkc4UUorUXA4b2pmZHVJUFpadjVVS3N5OVVEVjhkYnRW?=
 =?utf-8?B?UkRjWFBKZ3RtU0phaGgwSmFIMVF4QVVVazZWdlRWeVFjbFR0UXIxWFhGOFFH?=
 =?utf-8?B?a29iN05sY1YvbzJOQUdzUHMzOFEzcy9ZQzYwS2xVbU4xQ1AwaVgvQmFUQ1VY?=
 =?utf-8?B?ZVNGbCt4VHMzaEJtSng4WUdlcmx6bTZ6V3lrdU1JbFRCL3c4Yi9DcUw0aHJp?=
 =?utf-8?B?TjJOeTA2ODZQbjdqOG9UeGZUUHNaSTVpRWVtbTlzeHl1cHZ6SWdOZHJlTG1R?=
 =?utf-8?B?WDJCaE5yT3RLMk1JZGJmc25uUUpWNThyZkVabU43UFVRWUVFdktWWFQwUUdS?=
 =?utf-8?B?RTFSdFdNVTBqNENKUFpLb2tVY0N6ODhud0dGVVNWa3JmSUVZaE1rRzNjY2M3?=
 =?utf-8?B?cFpNUzVOeWpXZU9Qd0dLalZuNzB2czRmU1pmbFl1cDFFNkl5UmJybk9WT3RY?=
 =?utf-8?B?T1BrNXRuTUt4eTlaTStSRHBJWG0zSFdnNElyTkNHeit6SWNzcnAzTDc2NHNi?=
 =?utf-8?B?OTZ4QnIwRXY4Y2hSSU1XV2o4enN1VFhRZnk5TFVkWjhqcHM0ZzZlRHY5a04r?=
 =?utf-8?B?QkZWdHd5M0JiVTByWkVKVzBxWko5Z3MzSzRxVk5WdFkwZ1g2MnFhcHorZnhJ?=
 =?utf-8?B?RTl1dFFyKzdnWHJzTFdxNE90Rm1xaUE5T2hrYzIveEtGdlVlWGJ2Y3FpRDdV?=
 =?utf-8?B?T2pMWllrVlFpZDM0eDlkS1RmeXFqYVBUWGFXbkpUTmpLclBiZDB5SStQcCtW?=
 =?utf-8?B?bm5uZkU0NSsrKzUvY3N3NGtUL0pqbExtUlJyaDI4cHFndXpzTGtoSWphYXhL?=
 =?utf-8?B?cFZuL3Fkb0RYQzR0dW85RW9jU2V4SEVYQ295THprRFAxZy9SMFA3MytMN1F2?=
 =?utf-8?Q?bJrR34KuULdjwz9fXetJPyRL8j7JkQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmVWS3JLd3RmOTR2akZ6cktvUjdnK0FzWmZ3SzFCTW96cmJjMGs1LzFVdXE3?=
 =?utf-8?B?UWVzcmx0cXBndmsvcnR4RXFiRGpEZUZZS0JlczZJdnVUTnNlWkZOSncwQ2RM?=
 =?utf-8?B?OHlhNmVseFZIZFg4eUI0YVAwbG9hZFJwTnZFSU9KdDlOSURVU3I0cVZBVVEw?=
 =?utf-8?B?TG1nd280Rzl4N1hzSitFb21MTXFReWxveC83dEtsSlh0bEQvazZlL3JPUWQ1?=
 =?utf-8?B?RHRKMytxcXFVaWhkQVZiVUNYVisyYUp0Vzl1YlBVOVhtczlWN0FRZHVHQis1?=
 =?utf-8?B?cmxnMXEwUVlMR3ZKdExoRE9VcmR2OE9teFE5NTVKZFREdzlqVHNUMFdUcm9v?=
 =?utf-8?B?YW03bU9oMml2Sm5scnZFYXh5SFVIN0dVUEZJUGhBUXhHTVJGWHVHclBNZ1VP?=
 =?utf-8?B?U3h5L0xhNWp2NkNXbVhDN2s5bEVtazA0dnFjdzl6OUhRanhWVUE5bXdUSXZD?=
 =?utf-8?B?NFVNdHdMd0xzdTlwZDdQckNoa1Y3QkRTb2ZaUU9UWkM4aTVlWHlpN0Q2TUIr?=
 =?utf-8?B?N2w0aGJxOFZ5R0wyeSszR05EbFlXdVhUMlFrU2IyMkx4UXdnUlpRVjdlUHVE?=
 =?utf-8?B?eFhWUTFVT1VXQ1lLRUdMTGhKZ3F6REJ3cDNtRncwVmhBOVh0UldGOW5YOGFJ?=
 =?utf-8?B?V2g4QWFrSi9YNytoekdHNVlxcUNIaTk0eEJpZnlPQlpnWHJTbGp5NmRHT2RH?=
 =?utf-8?B?WW5yT1JJdmZuclRORXVsYmJ5LzFjZjJXeXpJQUtzN2J6MWNQWUxmU2ZIR0Rt?=
 =?utf-8?B?WXY4d2N5ODl0cTUwY3F1NTVtVmFxZDlzSFRmdzlpaUpzZFprTU4xUjlYNzFF?=
 =?utf-8?B?Q1k5bHkxU3BnOE85L0VLSEw0NTVPcjBLc0V1a29EbzNkZVJOeWV5R3lmT0FV?=
 =?utf-8?B?ODMzMjJaR29ScDJPL1dPcFJRN21kOFpGQjVlaElGUEwzeUxLVUlObHBQdGZj?=
 =?utf-8?B?akhvVGxWbWRvNmovdENFUC9aNnhJT2lMcmJ1QVk1MUtMaUNWckNYY2VIWXp5?=
 =?utf-8?B?ZWg0YTN6Z0NXUms2LzVMaUt4eWxvdDd0UE03aUVqZ0JtUnRsU2FSdU1SRnZy?=
 =?utf-8?B?VVRJRnF2TjFXbG5nRVdmb3ZaOHpYZDNkNjVrcC9IeFZCYmI3TGdZMHdBU29n?=
 =?utf-8?B?aWRSYnc1T004a1UyUDRESGJIMm44Rm9QLys1Wm1oM09ndjNtUEhKcUJDWTgr?=
 =?utf-8?B?QmRIZU51cTVOK3Rtc01kMms1WG1KRFQwczdQcWkvbTJSSEtWU2NlT24zSWxM?=
 =?utf-8?B?dkVzYXptSGtlaGtMdGViOUhONTZmb2k4RFUwVmdjNEYvQjNRcnJXeUc4ZTRx?=
 =?utf-8?B?QjVQdkhLNkVpS1VFdXU5MCtTTTNJbWdTb2VSdHVZT2hCdlBVc2dxb2QyV0Zn?=
 =?utf-8?B?NnVMVkpZZ2xvSHZEK1lUaXY3bU1xczB5U2RiSklZM3ZtaWFjT29BVjNSR1N6?=
 =?utf-8?B?SlgzcEZ1MHR1UnEzZWFTUE91Q002VEFoaWFjUE9pQy9xSis4aWRxY0hQcFBG?=
 =?utf-8?B?ZVlrVGNPM1lOZmVxaTljaWo2MkRjd2diL2VTblVZdm0yTlNQR3BjMTEvTWVU?=
 =?utf-8?B?WjlseXhKUE9qcCtsSjYyNmx6TGd1WitpamV4OGtKOFFqMnEwTkZXdEhzSy8r?=
 =?utf-8?B?ajZYWVZuRGlZYmRkVHZrTEE3NTJaeVMvV0xTSnBPUGtYb3FDTWU4Vml0MGhO?=
 =?utf-8?B?WFBCbTFsMnVTY0RvQUtJc3E0bkNWQ3pjcGxHRkJNNm42aXpMUE5HZWx3eUZB?=
 =?utf-8?B?ekhWZG40SkRmZ21HMm9wSkU5VFhUL21ua1lyZmJrYkFqL3I2aFpyRkdHVjRO?=
 =?utf-8?B?L0R4MVRMVTVjV0c3cmp2Zm9uVTFyYkRDMG0wWmFFQXFDNVNVMUNCOWNEQlI4?=
 =?utf-8?B?UUhtUTh4eHZwQmdKdUgwSVlHUzlsNkx0dFUrSEEzSEs4Tkd4TWxPRm9YZTVt?=
 =?utf-8?B?L0dxaHB3b2VURjYrUU1xVEF2dXBtUTg2Z0VKTi84MUJscnpDSWp0RDlLM3BY?=
 =?utf-8?B?L3JCanprYmFaZ1grTTBNTTA1UGVVS0VSdjVucUJvbHJNWkFZQi9QdlRVTHAx?=
 =?utf-8?B?cVNuWkd4ZlJUd2diS1YvUStKOTNwMGdlWDdDejdnQUExeXF1QVJHUHRvQ0dl?=
 =?utf-8?B?MVJMUzIydmxoa1pnbnpVRDNLdzgzRzhvRWFwcGZTSXNtdmIyTkNQWll1em1a?=
 =?utf-8?Q?xh3znB61PAXKly8OR0WQges=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825861dd-c36f-4673-cf75-08ddd41b6db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 12:27:22.6036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rcN4ffcqznyYhCexmmQp1s6opzvBGDuBk/T04rUB4gcUHdNdgOC0r0L8oLw49Pl+1vGmNGcQLBdNZgr2qA3eFIyIojx3NFTOi8lSEJKmt4arzyyjeKMDKd9jTUZHfpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB9011
X-Mailman-Approved-At: Tue, 05 Aug 2025 16:22:08 +0200
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

Pk9rYXksIEkgc2VlLiBHaXZlbiB0aGF0IHdlIG5vdyBoYXZlIGEgZ2xvYmFsIG1lbW9yeSBtYXAg
Zm9yIGxtYiwgSSBkb24ndCB0aGluayB0aGF0IHVzaW5nIGxtYiBmdW5jdGlvbmFsaXR5IGlzIHRo
ZSBiZXN0IHdheSBvZiBjb21wdXRpbmcgdGhlIGFtb3VudCBvZiBtZW1vcnkgdGhhdCB3b3VsZCBi
ZSBhdmFpbGFibGUgZm9yIHRoZSBrZXJuZWwgdG8gdXNlLg0KPlBsZWFzZSBub3RlIHRoYXQgd2l0
aCBhIGdsb2JhbCBhbmQgcGVyc2lzdGVudCBtZW1vcnkgbWFwIG9mIGxtYiwgdGhlcmUgaXMgbm8g
Z3VhcmFudGVlIGFzIHRvIHdoZXJlIHRoZSBmaXJzdCBjaHVuayBvZiB1c2VkIG1lbW9yeSBsaWUg
YWJvdmUgeW91ciByb290ZnMgbWVtb3J5LiBFYXJsaWVyLCBJIHRoaW5rIHRoaXMgd2FzIGZpbmUg
YXMgdGhlIGxtYiBtZW1vcnkgbWFwIHdhcyBsb2NhbCwgc28geW91IGNvdWxkIGNvcHkgdGhlIHJh
bWZzIHRvIHNvbWUgbG93IG1lbW9yeSByZWdpb24sIGFuZCB0aGVuIHNob3cgdGhlIHJlc3Qgb2Yg
bWVtb3J5IGFzIGF2YWlsYWJsZSBpbiB0aGUgbG1iIG1lbW9yeSBtYXAuDQoNCkkgYW0gbm90IHN1
cmUgSSB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4gd2l0aCAidGhlcmUgaXMgbm8gZ3VhcmFudGVl
IGFzIHRvIHdoZXJlIHRoZSBmaXJzdCBjaHVuayBvZiB1c2VkIG1lbW9yeSBsaWUgYWJvdmUgeW91
ciByb290ZnMgbWVtb3J5Ii4NCkhvdyBpcyBpdCBkaWZmZXJlbnQgdG8gd2hlbiBpdCB3YXMgbG9j
YWw/DQoNCg0KPlRoYXQgbWlnaHQgbm8gbG9uZ2VyIGJlIHRoZSBjYXNlLiBTbyB0aGlzIGNvbXB1
dGF0aW9uIG9mIG1lbW9yeSBhdmFpbGFibGUgZm9yIHRoZSBrZXJuZWwgd2lsbCBoYXZlIHRvIGJl
IHJlLWRlc2lnbmVkLiBJIHRoaW5rIGluc3RlYWQgb2YgcmVseWluZyBvbiB0aGUgbG1iIG1lbW9y
eSBtYXAgZm9yIHlvdXIgY29tcHV0YXRpb25zLCB0aGVyZSBzaG91bGQgYmUgc29tZSBmaXhlZCBt
ZW1vcnkgcmVnaW9uIHdoZXJlIHRoZSByYW1mcyB3b3VsZCBoYXZlIHRvIGJlIGNvcGllZCwgYW5k
IHRoZW4gdGhlIHJlc3Qgb2YgdGhlIG1lbW9yeSBjYW4gYmUgY29uc2lkZXJlZCBhcyBzYWZlIGZv
ciB0aGUga2VybmVsIHRvIHVzZS4NCg0KPkJ0dywgSSB0cmllZCBsb29raW5nIGZvciB0aGUgZnVu
Y3Rpb24gdGhhdCB5b3UgYXJlIGNoYW5naW5nIGluIHlvdXIgYm9hcmQgZmlsZSBpbiB0aGUgcGF0
Y2gsIGJ1dCBJIGRvIG5vdCBzZWUgaXQgaW4gdGhlIHVwc3RyZWFtIFUtQm9vdC4NCg0KSXQncyBu
b3QgbWFpbmxpbmVkIHlldCwgaGVyZSdzIHRoZSBmdWxsIGZ1bmN0aW9uIHdpdGggdGhlIHBhdGNo
IGFwcGxpZWQ6DQoNCmBgYGMNCnN0YXRpYyBpbnQgZG9fY2FsY19yYW1mc19hZGRyKHN0cnVjdCBj
bWRfdGJsICpjbWR0cCwgaW50IGZsYWcsIGludCBhcmdjLA0KCWNoYXIgKmNvbnN0IGFyZ3ZbXSkg
ew0KCXVsb25nIHNpemUgPSAwOw0KCWlmKHN0cmljdF9zdHJ0b3VsKGFyZ3ZbMV0sIDE2LCAmc2l6
ZSkgIT0gMCkgew0KCQlwcmludGYoIiVzOiBmYWlsZWQgdG8gcGFyc2Ugc2l6ZSBhcmdcbiIsIF9f
ZnVuY19fKTsNCgkJcmV0dXJuIENNRF9SRVRfRkFJTFVSRTsNCgl9DQoNCglwaHlzX2FkZHJfdCBh
ZGRyID0gbG1iX2FsbG9jKHNpemUsIFNaXzE2Syk7DQoNCglpZiAoYWRkciA9PSAwKSB7DQoJCXBy
aW50ZigiJXM6IGZhaWxlZCB0byBmaW5kIHNwYWNlIGZvciByb290ZnMgaW4gcmFtXG4iLCBfX2Z1
bmNfXyk7DQoJCXJldHVybiBDTURfUkVUX0ZBSUxVUkU7DQoJfQ0KDQoJLy8gY2FsY3VsYXRlIGhv
dyBtdWNoIHJhbSB3ZSBjYW4gZ2l2ZSB0aGUga2VybmVsDQoJcGh5c19zaXplX3QgZnJlZSA9IGxt
Yl9nZXRfcmVzZXJ2YWJsZV9zaXplKENGR19TWVNfU0RSQU1fQkFTRSkgJiB+KFNaXzE2SyAtIDEp
Ow0KCWlmIChmcmVlIDw9IDApIHsNCgkJcHJpbnRmKCIlczogZmFpbGVkIHRvIGNhbGN1bGF0ZSBm
cmVlIG1lbW9yeSBmb3Iga2VybmVsXG4iLCBfX2Z1bmNfXyk7DQoJCXJldHVybiBDTURfUkVUX0ZB
SUxVUkU7DQoJfQ0KDQoJLyogV2UgZG9udCByZXNlcnZlIHRoZSBtZW1vcnkgZm9yIHRoZSByb290
ZnMsIGJlY2F1c2UgdGZ0cCBuZWVkcyB0byB3cml0ZSBpdC4NCgkgKiBiZWNhdXNlIG9mIHRoYXQs
IHdlIGNoZWNrIGhlcmUgaWYgdGhlIGtlcm5lbCBtZW1vcnkgb3ZlcmxhcHMgaXQgb3Igbm90Lg0K
CSAqLw0KCWlmIChDRkdfU1lTX1NEUkFNX0JBU0UgKyBmcmVlID4gYWRkcikgew0KCQlmcmVlID0g
KGFkZHIgLSBDRkdfU1lTX1NEUkFNX0JBU0UpICYgfihTWl8xNksgLSAxKTsNCgl9DQoNCgljaGFy
IGVudnZhbFsyMF07DQoJc3ByaW50ZihlbnZ2YWwsICIlcGEiLCAmYWRkcik7DQoJZW52X3NldCgi
cm9vdGZzYWRkciIsIGVudnZhbCk7DQoJc3ByaW50ZihlbnZ2YWwsICIlcGEiLCAmZnJlZSk7DQoJ
ZW52X3NldCgia2VybmVsbWVtIiwgZW52dmFsKTsNCg0KCXJldHVybiAwOw0KfQ0KYGBgDQo=
