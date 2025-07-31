Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478EBC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0E983824;
	Thu, 31 Jul 2025 13:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qsDBQD6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C1A83839; Thu, 31 Jul 2025 13:29:04 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FFE83816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjFJKFMm1IHNE1fY1l/Z6dicoUGE1wd4GtVAY11kqK9E4upafOPE6NGXYp0EGZDg7uxby7o6KL6goAxOVwbFUfqfpN5RXvN+xmvojsomm3buRLjqvCIpylUK8Pes7bUjANmfEhjcYs6IpN9RbiTQCfX1c6YKQB0Kk+5hOruChBf/19vWm9oF2JFMLKGsUlP4wZZV2f7D7h4WHLe/7UDvrKexahghcqfnyzxamxcq1G8nE87/AQ0qiG+/IfA02eF4jhDURIPajI80IfveoCboaWM12Epc8UygrYoaG9lUgE0ug7o5Z2r+cgUu8Df+t2hMlkZZPoUj7kCIjY/Ga3VWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx2RyKyL5wBTVPdOcuZ696icbCyfBcGuOrUgWrFqZhU=;
 b=hw/mBWMkseXN7wFNmI58UuVd3/2kE/9j45KFyQJYZ//+WFNSTDQZrioB0SwB291fyS1WGDQXr8GEhhgI6vqEYqtYnY67NxEQN5MD4HI7zImh4TUQMOjiQqn1bfKwKHKCnqoY9yTXjy8rpVrsXJa2K7yY3RxPf12W1tm/3ET2irEpyFZibkzfHuSiXAagqRLYvJXUT7z5uiYUrHrVCp9sndVORYzrGkoBCAzTz6U5I/wrDubkJXAmuwVM9T9zkwOOCJWWfcmKQqp9Jan8+AlaP709pt/spHQUF+kICT0BTYm7ROScj7DgwioXJOIZLyuJqajtU/CwRbiQvfPh9nNZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx2RyKyL5wBTVPdOcuZ696icbCyfBcGuOrUgWrFqZhU=;
 b=qsDBQD6y+AaaDWcyNphUOc4+A9WNl0+bDRe6E2NorBvEIff0sHJNpdGOGHsG17tbtoQV826wUdWVNskP3IiCBlii6DoJqCVj5byKx0kx1d4S+P1lsnUmH9ptgd7ogAf3W9JXf8cEOHjvTobWRlx3K4Cjibs3SGR8PMgH2CUMqynWOfIAN6+jaurUHkp/tYlferEkACU2rghQbFBmuwjwcVpwCu5YL+S5GCX+jSCQ9ff1IRoMZ2pAayJjbtW378e+j9on3a9ummtT9zl12rtt5HfLGfof5eSXUDB1zgYyd+rGrhlzWSDx6XpMk95EOamDV8tTg83mbiTbybSPpEMsIg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by VI0P195MB2601.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 11:28:58 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8964.029; Thu, 31 Jul 2025
 11:28:58 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Aristo Chen <jj251510319013@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "al.kochet@gmail.com" <al.kochet@gmail.com>, "paul.henrys_ext@softathome.com"
 <paul.henrys_ext@softathome.com>, "bb@ti.com" <bb@ti.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, Garrett Giordano <ggiordano@phytec.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>, Daniel
 Schultz <D.Schultz@phytec.de>, "d-gole@ti.com" <d-gole@ti.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, "carlos.lopezr4096@gmail.com"
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v1 1/5] binman: Fix FIT image overlap issues
Thread-Topic: [PATCH v1 1/5] binman: Fix FIT image overlap issues
Thread-Index: AQHcAIdyN2KSKUPwt0yLeIE+REr1S7RMG4yA
Date: Thu, 31 Jul 2025 11:28:58 +0000
Message-ID: <f96edc2e008336124d5fe20bc395fb56e7ed12c3.camel@phytec.de>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-2-aristo.chen@canonical.com>
In-Reply-To: <20250729125022.4220-2-aristo.chen@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|VI0P195MB2601:EE_
x-ms-office365-filtering-correlation-id: 4ac41ffc-5eff-43fb-22b2-08ddd02570d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VGYxRXlQVk5LbXdtMTY1WDdpZ05TZ2t0UmhZcHVBMHdsaFVGM0I2OXZRVkRz?=
 =?utf-8?B?TGRjZUR5bUZqaUtJU2o1ckJCVkN1M3FJNUduMGpiUWkyS25qSk9wcW1RbUlX?=
 =?utf-8?B?Y3hPZ2NhOE9nNXljbWl0OHdlTXNBTCtwa0F3bWJzWFRrVHo0a0tIRUpDdWpa?=
 =?utf-8?B?c3VtUTVlbVE3c1RxaVk5Q3RSUkh0bzd5WWtiRFYrdXErSXplYUZzOGtnK1BL?=
 =?utf-8?B?SHo2bVVpaXJydEszMUd5YlJWVzZsVWl3WU45ZnpIRFgyYWcrZWR0bEhWMmtD?=
 =?utf-8?B?cThLM2lSYm43ZXFWTGxieGIxN3hQVDl2bExvSE9OS0RYbVZ6NTJRRFBzWnds?=
 =?utf-8?B?MFM0R2daMTRJU1ZEc2NITmJoNnI2eXkwNEhVRUF6bThPamljbi9vQjl4YnBt?=
 =?utf-8?B?Wko2bEE2NEZ1aTNXYzAwQTczdGVka21xODZsb2hMdGp1NTFic0lqNWtkZFVq?=
 =?utf-8?B?NFNGNGliQk0xUVRrRnVxbVFDdkU4NnludWY4YzYwZEEyYjhjZWJ1Mm0yY3Rj?=
 =?utf-8?B?TGNuYUpxcE4zY0ZPZkZZNi9yalAwMUlpWjVGU1IzaWpFVGNnV0Y2TlMzWUJJ?=
 =?utf-8?B?UHpxcmZVVGcxQnZ6d1NUcGhWbEs4NThHcTlhZzEzS3VsVXRqR25LQUtXSGtI?=
 =?utf-8?B?QkJDN28zaUZxdWxHWGlGaXRVd28yS2JSRzdDenR1Q1AwdGRFY3gxVXY1ZUY3?=
 =?utf-8?B?eEJRSzAwKzBBTFFrWThLMEpYa0FDUDhaVUV4NlZ3Z1hLTkVrWS91TmhWMGo2?=
 =?utf-8?B?VnpTdDNYTlRRSXVDazA5MUhBOE9pdzZJZC8yOFhiQ3Nka2FoQnpJUHZtKzV3?=
 =?utf-8?B?QTFWRnFXMzlkdUkvSEVFV2V4N2xZMDBsUHdQaEVvRGl5ZGJQbWR4NzFpQlVN?=
 =?utf-8?B?QisyeWo4Umt0VTBlNlgwZ1lVOFNpQVhUTFIzVTd6b3luQmVGQjhiYWo2Vk5q?=
 =?utf-8?B?d1BaUk5MTHlBRzgyZlYzRytEVERoNWFlZllKZ2hHSTdCUDlyVyt6YVJSYXpB?=
 =?utf-8?B?Mmx4QnZPRFNvakovUjkvWlcxRnFhYUxHZUczYVZZcyt6R3FKL3hBdDAwWjJj?=
 =?utf-8?B?Y1k3ZnAzbDJlZEhwMnNES1NzS0w2WVdiMFNWb0RaOUFzMkt0T0Jma2svMldX?=
 =?utf-8?B?dEtXZ0ZyN1RuOUFUOVJha3ZuT05hVWJ2NnpDMUpBT3lVbk8zNkJGazVuQnNH?=
 =?utf-8?B?ZmJHOXFpWVZMTmczSlR1cG5XS3ljbnJVUTdlZmZzUFlFVlVwK2s5Z08xVnV3?=
 =?utf-8?B?dE1KVHhIVmJyTEFESkdkNmdUV3RHcVBvSWFDUTNVcXBOSkE3TUlqV3J5SHFD?=
 =?utf-8?B?NmllZXJnV0hoZmk0bnA5bzE0eXgva1krZFBBWUhLNmRrTUhhbVNzbmZqRzlE?=
 =?utf-8?B?THJMcHpLbjhvY2VML2ZUekV5Z0ZYMTdRaDJoZjRwODExekdrZTQ5Qit6cUkw?=
 =?utf-8?B?TTIrYld5WS9nczZOUGN0SDk5MVVxa0l1OW9DQVBZZkZOTG1XN3FKWHZUZ2M5?=
 =?utf-8?B?V3A3ZFE1VmtyVGM4TEg1eXFId1ljU2UycUpIQ2RkZzhRUzU4U09sMUpOVFRW?=
 =?utf-8?B?dlphMkJTMmd4UGZ6RkJUMVkyb0ZpRmIrRU1mb2J4V0IzaU1tc2l4OHpHbDlu?=
 =?utf-8?B?U1JOc0JGdWdIakZORmpLTGVwclNBUlpPRXpVWTFBdWxyMTVPUkpyRG5iTitN?=
 =?utf-8?B?SDBNWkxYTkRxMHovVVRKUDhlN2VwaUNHdlE4R3dKZExIUWpFYVlvNTJtcjVX?=
 =?utf-8?B?alpRVlR2SzhSNktMUDRFVFU2ZHNMY2U4UnVFKy8wRm5pMGhVNUFmZW1jbWVC?=
 =?utf-8?B?TXlCdS9MejBLdmRxYkYzdng2VUNKY1RHdkpKWjNocUNQTFdqN2FtNFhscTdw?=
 =?utf-8?B?aXBFYjNLeGxXUy9nNUdNU0Jkb3g4aVAzWEYzd1dNbm9DRmRLa0FDVjhGN29w?=
 =?utf-8?B?MFVvMFp0R2lBTjR6S2QxZGxYMll1MHo1RDFoRS9jTWkwMUhUaTdIYmhXVnlK?=
 =?utf-8?B?YXlMcWRkSTN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azFQc3JlRWxueDMvSWo0Rk5iQm5EbW52Q2tYUFNvbEsza1RNSlRkMjdEdkZW?=
 =?utf-8?B?Q3RRaXVOdC8xL0F4cngzaG9lYi83TmJ3em42RzBtRVFoQUhab1R4Rnlod1cx?=
 =?utf-8?B?K2FHNS9NanhzTk5taVIvR2dETjNwdnpIV1QwYnhVbXJFd2I3QmhMUzRpdzdS?=
 =?utf-8?B?RlY5ajkxbS85V1NkVHZHZEx2WVJ6UGt2V3RjVU51NVpaa0Jna0d0WVdCNTAv?=
 =?utf-8?B?MEpKRnFLYkJiRksvZ3kxNkNNVzJZZnNhRXQ5emp6YlMwYk1rQ2J5NUk5Rm9I?=
 =?utf-8?B?dkFsL2YyTmx6TFZvV0czK2tzOWthenNkNk1BMEFhQnNaQUs5UUo1OFVmSHpz?=
 =?utf-8?B?ZGdxc2lGWjFRMndLL01aaUdvN2crb3RSWjBxYm9oNEJpZ203aFNjTXhjeGIx?=
 =?utf-8?B?N21FbjRGN284dVZTS2FIZTIyOFlPOHJ5WGZhb0xPQjlxc2xCWStyd0FCT3ZE?=
 =?utf-8?B?UXlOTDB3MHpTbzFMU3lUWDVYZlJyWXJ6cStvc3Z6UGFpYUxSMXNyL1VkQlNa?=
 =?utf-8?B?VmZhZXpSK3hHNXdTTmk5aThXa1NsRExKWld0b21Ba0JiVks2TmFYTnowNGVZ?=
 =?utf-8?B?N3M4TGRjeXJLbTZRM251Q3FpT2tLTUZZQVlrTElNTEdQTWo5Q0FVeW9tL2dy?=
 =?utf-8?B?WXk5djVWZGJYQ0dpdXRlQzZzbkpwaVl3dXI1bHljNDBQZ1YvRlY4MDh1VXl2?=
 =?utf-8?B?UXRmamhSS1JCaGczRFYxQjZDN1lSUVNMSlV6dTJXak0xNG5qeitJWUhpY0Iw?=
 =?utf-8?B?cVI3Vko0eFJuWUREVmlodTFneUlqcHR4anNTR3BYR3Z4UXNJdGYwK0xIQ3VF?=
 =?utf-8?B?STczUlcxZzRmaEl1QXhMTHNEQit3S3pEanFwVVNLOFM0WWhuVEpxQ0JxaEVh?=
 =?utf-8?B?RFREVDNDcUpXTWQ2V242N2NYNzFyZlNMbGtjVnBuTXBza2VPbnFWN3pMTWVt?=
 =?utf-8?B?VVpyYzROS29pNDFoWGVqOGdrb05HcnU0L2VxRkN0RlBSbWZWWjA5aFZHT0t5?=
 =?utf-8?B?czk2d2QyTE5jbHBGblpOSWlCU0FoMmJuSG5GNURhSVh6ekFJNmdaM3BtZm4w?=
 =?utf-8?B?c0p4d0xLM1Z5eGczb1QrT3laS3pzZ0t5bUJaRFRVTDlpRkpHb1U2NHpocm04?=
 =?utf-8?B?OUN4RW05QXpIM3o3NHVnN1MwaDBNRlZFTVE0V0FnOUIxUkkvMVhudXovQkVV?=
 =?utf-8?B?cSs0Mm1LdEhIQUNJY0l2SmVyZElGN2dSb0lVY3I1cWsxYlRCclBjZHVQS3pR?=
 =?utf-8?B?MThVb1N2ZnFGMW1FVXNmVDYraXJndGR0VTFCQitRVmMxTkZHNVBjSEExOUhM?=
 =?utf-8?B?Z2plM0V4UHVJaXljdnZtbXc3VTRSdTVyQks2VXVQRjd3ZTRxWGJ3eEQzZG80?=
 =?utf-8?B?dEdhN3dUQzJkUzFVZWhZaVpKMVI4dkJSaEtWN0FQZDliTTB0Y1E1VG1FOHRD?=
 =?utf-8?B?Ym1XS1hlTGF5LzUvV3N5Z0JsK0FGWEg2OTZqTFh4Tjh0VnBodmQ5Ykt1MjF6?=
 =?utf-8?B?U1JaOWc4YjdRcDU5Skt0K0V5MHNtVURTY0EyK2J6WERsMnZKWHlONm9WY3dH?=
 =?utf-8?B?THE2eWRRK2s1UVlGb0tqU216OHVJZlJONEtrK0lmbzhsa2FkYmdPdG5WSmJE?=
 =?utf-8?B?cEt3ZHN5R3dQNWYxRnhldTFuWWJ4d25LaWtUaHBIRS9ITUFUT3JRc1d4SWww?=
 =?utf-8?B?YUxVd29hVkJMMk8vOGIrYVFKY2ZpU1NBN3UrNWtESTd1Z1VoNVFuM1R6dmYr?=
 =?utf-8?B?N3RxUkcra1MvZ3NieGJBVTFlS1BoMHo4WGtlU2VTYXhnU21UQ2dSdkFjVHNP?=
 =?utf-8?B?ajc1dTBUS1dxN29kQzJkaGoxWTB4SjhFYXQ0NmlxVWNyaTNyL05qcVprcHh5?=
 =?utf-8?B?bzB4YWV4ODloa2JCZEVnRXJNTUhOb0haZHRtRmlaWHA4M3hPYXRyYXd3RGlo?=
 =?utf-8?B?YUowY2R2SUxsaklMRjl0UUd3RTVGaVRGaERlT3BhbjNLaytKc0VpNndPWmhD?=
 =?utf-8?B?TTVMMThFbUdyTzM2Nm9tczlCSThsQTdDeGZUdGlyZTZiengzZmUxQWRBWWhZ?=
 =?utf-8?B?eGRyOVdLK1JGMVZaOWFaNzRMbEthTTAzZ3UzQ05sc2h6YVgyR2lOcjRBRDhs?=
 =?utf-8?Q?ZJXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C98FD1C8D115324CB80B2DC9660BB619@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac41ffc-5eff-43fb-22b2-08ddd02570d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 11:28:58.1321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMSIKT15AHxCmQEkQft1bwEtQlqoDiAZO6wWTWGDuX1qGx3fxWzcz4WPVkv8sfQVhTAtLS5jk/nrMfS8y02IOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2601
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

QW0gRGllbnN0YWcsIGRlbSAyOS4wNy4yMDI1IHVtIDEyOjQ4ICswMDAwIHNjaHJpZWIgQXJpc3Rv
IENoZW46Cj4gRml4IHRocmVlIGJpbm1hbiB0ZXN0cyB0aGF0IGhhcyBtZW1vcnkgcmVnaW9uIG92
ZXJsYXAgaXNzdWUsIHRoZSB0ZXN0Cj4gY2FzZXMgbmVlZGVkIHRvIGJlIHVwZGF0ZWQgdG8gdXNl
IG5vbi1vdmVybGFwcGluZyBtZW1vcnkgbGF5b3V0cy4KPiAKPiAqIFRlc3RzIGZpeGVkOgo+IMKg
IC0gdGVzdEZpdEZpcm13YXJlTG9hZGFibGVzCj4gwqAgLSB0ZXN0Rml0U2lnblNpbXBsZQo+IMKg
IC0gdGVzdEZpdFNpZ25Ob1NpbmdhdHVyZU5vZGVzCj4gCj4gKiBDaGFuZ2VzIG1hZGU6Cj4gwqAg
VXBkYXRlZCBEVEIgdGVzdCBmaWxlcyB0byBjaGFuZ2UgVS1Cb290IGxvYWQgYWRkcmVzc2VzIGZy
b20gMHgwIHRvCj4gwqAgMHgyMDAwIHRvIGF2b2lkIG92ZXJsYXBwaW5nIHdpdGggQVRGIGluIHRo
ZSAweDEwLTB4ZmMgcmFuZ2U6Cj4gwqAgLSAyNzZfZml0X2Zpcm13YXJlX2xvYWRhYmxlcy5kdHMK
PiDCoCAtIDM0MF9maXRfc2lnbmF0dXJlLmR0cwo+IMKgIC0gMzQyX2ZpdF9zaWduYXR1cmUuZHRz
CgpDYW4geW91IGFkZCB0aGUgaW5mbyB0aGF0IGVsZl9zZWN0aW9ucy5sZHMgc2V0cyB0aGUgbG9h
ZCBhZGRyIG9mIHRoZSBhdGYgKGluCnRoaXMgY2FzZSkgdG8gdGhlIGNvbW1pdCBkZXNjcmlwdGlv
bi4KQWxzbywgZm9yIGFueW9uZSBub3QgZmFtaWxpYXIgd2l0aCBlbGYgZmlsZXMsIGNhbiB5b3Ug
YWRkIHRvIHRoZSBkb2MKKHRvb2xzL2Jpbm1hbi9lbnRyaWVzLnJzdCwgZml0LGxvYWQpIGluZm8g
b24gaG93IHRvIGZpbmQgb3V0IHdoZXJlIHRoZSBlbGYgaXMKbG9hZGVkPyBJdCBpcyBub3QgaW1t
ZWRpYXRlbHkgb2J2aW91cyBpbiBiaW5tYW4gc2VjdGlvbiBvZiBVLUJvb3QgZHRzIGZpbGVzIGFu
ZAp0aGlzIG1heSBoZWxwIHVzZXJzIGRlYnVnIHF1aWNrZXIgd2hlbiB0aGV5IGhhdmUgYSBjb25m
bGljdCBhcyBoaWdobGlnaGVkIHdpdGgKdGhpcyBwYXRjaCBzZXJpZXMuCgpZYW5uaWMKCj4gCj4g
QW4gdXBjb21pbmcgY29tbWl0IHdpbGwgdmFsaWRhdGUgaWYgdGhlIG1lbW9yeSByZWdpb24gaXMg
b3ZlcmxhcHBlZAo+IAo+IFNpZ25lZC1vZmYtYnk6IEFyaXN0byBDaGVuIDxhcmlzdG8uY2hlbkBj
YW5vbmljYWwuY29tPgo+IC0tLQo+IMKgdG9vbHMvYmlubWFuL3Rlc3QvMjc2X2ZpdF9maXJtd2Fy
ZV9sb2FkYWJsZXMuZHRzIHwgNCArKy0tCj4gwqB0b29scy9iaW5tYW4vdGVzdC8zNDBfZml0X3Np
Z25hdHVyZS5kdHPCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICsrLS0KPiDCoHRvb2xzL2Jpbm1hbi90
ZXN0LzM0Ml9maXRfc2lnbmF0dXJlLmR0c8KgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+IMKg
MyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL2Jpbm1hbi90ZXN0LzI3Nl9maXRfZmlybXdhcmVfbG9hZGFibGVzLmR0
cwo+IGIvdG9vbHMvYmlubWFuL3Rlc3QvMjc2X2ZpdF9maXJtd2FyZV9sb2FkYWJsZXMuZHRzCj4g
aW5kZXggMmY3OWNkYzliYjguLmQzNDQwMzZhMTFhIDEwMDY0NAo+IC0tLSBhL3Rvb2xzL2Jpbm1h
bi90ZXN0LzI3Nl9maXRfZmlybXdhcmVfbG9hZGFibGVzLmR0cwo+ICsrKyBiL3Rvb2xzL2Jpbm1h
bi90ZXN0LzI3Nl9maXRfZmlybXdhcmVfbG9hZGFibGVzLmR0cwo+IEBAIC0xOSw4ICsxOSw4IEBA
Cj4gwqAJCQkJCWFyY2ggPSAiYXJtNjQiOwo+IMKgCQkJCQlvcyA9ICJ1LWJvb3QiOwo+IMKgCQkJ
CQljb21wcmVzc2lvbiA9ICJub25lIjsKPiAtCQkJCQlsb2FkID0gPDB4MDAwMDAwMDA+Owo+IC0J
CQkJCWVudHJ5ID0gPDB4MDAwMDAwMDA+Owo+ICsJCQkJCWxvYWQgPSA8MHgwMDAwMjAwMD47Cj4g
KwkJCQkJZW50cnkgPSA8MHgwMDAwMjAwMD47Cj4gwqAKPiDCoAkJCQkJdS1ib290LW5vZHRiIHsK
PiDCoAkJCQkJfTsKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYmlubWFuL3Rlc3QvMzQwX2ZpdF9zaWdu
YXR1cmUuZHRzCj4gYi90b29scy9iaW5tYW4vdGVzdC8zNDBfZml0X3NpZ25hdHVyZS5kdHMKPiBp
bmRleCA5ZGNlNjJlNTJkZS4uMWMyNWQ1MmNiYTQgMTAwNjQ0Cj4gLS0tIGEvdG9vbHMvYmlubWFu
L3Rlc3QvMzQwX2ZpdF9zaWduYXR1cmUuZHRzCj4gKysrIGIvdG9vbHMvYmlubWFuL3Rlc3QvMzQw
X2ZpdF9zaWduYXR1cmUuZHRzCj4gQEAgLTIwLDggKzIwLDggQEAKPiDCoAkJCQkJYXJjaCA9ICJh
cm02NCI7Cj4gwqAJCQkJCW9zID0gInUtYm9vdCI7Cj4gwqAJCQkJCWNvbXByZXNzaW9uID0gIm5v
bmUiOwo+IC0JCQkJCWxvYWQgPSA8MHgwMDAwMDAwMD47Cj4gLQkJCQkJZW50cnkgPSA8MHgwMDAw
MDAwMD47Cj4gKwkJCQkJbG9hZCA9IDwweDAwMDAyMDAwPjsKPiArCQkJCQllbnRyeSA9IDwweDAw
MDAyMDAwPjsKPiDCoAo+IMKgCQkJCQl1LWJvb3Qtbm9kdGIgewo+IMKgCQkJCQl9Owo+IGRpZmYg
LS1naXQgYS90b29scy9iaW5tYW4vdGVzdC8zNDJfZml0X3NpZ25hdHVyZS5kdHMKPiBiL3Rvb2xz
L2Jpbm1hbi90ZXN0LzM0Ml9maXRfc2lnbmF0dXJlLmR0cwo+IGluZGV4IDI2NzEwNWQwZjY4Li4y
YWM2MDBiMWM3MCAxMDA2NDQKPiAtLS0gYS90b29scy9iaW5tYW4vdGVzdC8zNDJfZml0X3NpZ25h
dHVyZS5kdHMKPiArKysgYi90b29scy9iaW5tYW4vdGVzdC8zNDJfZml0X3NpZ25hdHVyZS5kdHMK
PiBAQCAtMjAsOCArMjAsOCBAQAo+IMKgCQkJCQlhcmNoID0gImFybTY0IjsKPiDCoAkJCQkJb3Mg
PSAidS1ib290IjsKPiDCoAkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7Cj4gLQkJCQkJbG9hZCA9
IDwweDAwMDAwMDAwPjsKPiAtCQkJCQllbnRyeSA9IDwweDAwMDAwMDAwPjsKPiArCQkJCQlsb2Fk
ID0gPDB4MDAwMDIwMDA+Owo+ICsJCQkJCWVudHJ5ID0gPDB4MDAwMDIwMDA+Owo+IMKgCj4gwqAJ
CQkJCXUtYm9vdC1ub2R0YiB7Cj4gwqAJCQkJCX07Cg==
