Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B20C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 05:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0BAC88CE6;
	Thu,  2 May 2024 07:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="FODdcZWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D2D188CE9; Thu,  2 May 2024 07:56:45 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9F888CE3
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 07:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdKjEabeLTiCLpQieeoaqabLsHCGmsQ2gVwb2iBsinlV2DgJDubcNqHeMgbSoW55Hgyzi1yz3zc6AONvySpGbclxPCtc+Jsxh2ftffSqeKyU5GW9s/K9FB/rNmcPGw7Kdp1UW+nCPbnXm7JCHmIohJJvcdMO3MOYxDfwjrlEtCb2MOow5fowKyMaao7Ac0hvgpCIICxIITebVfPYbo9IuahKAimUjWNh8kn8KYy+RLe+JvUx8Dfe9RBj4qHgCFTex/THaWIpboAeFN5HJMV6Q4YDMjAOFGnEjm+XXvLQHjf0Qw20IALz72/h7DtJM5Lo2dpPtAUMTuQe0HJImthILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49DIWq73jjs3O9eE18LUZ+eqSA/2q34jBOJ40aFBqYs=;
 b=BEd6gj+eqDzcs+pi+isgqucueloYpc2M4X/9o2NTsPFPOvLguuMtxk4+HOINwf4z2QrSTmPjRTMBCP3OKoesul/tDiG0qjNXv98AdQcf8RcJBa6WtTj0J/fAhy3P3nqvGwKyqAWOUew7aTWv9yp+7Mc4WyEaOk+58pQw/NYJPGpl/x/O8tAiBe1cHVEmZ14ziNkErgWjtW4VgrugJoy0waBeNm2wLz42l1lNMUiUTD42LcO1o/LhvpGFfDLbIbmFdCq2erNAGj5nUzf58lo1l1ioxs4nxUBxjUj4NLnPWgHYZXLy6+BWzGdZoo1ojIN3w5vgo90G3emqgJAcpnH5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49DIWq73jjs3O9eE18LUZ+eqSA/2q34jBOJ40aFBqYs=;
 b=FODdcZWtfTfHri9KSHFvV2EEYR1YvVoxvdxeVBW6du0CcOoU6+KZMfH/jlx+E5nl/ewAy4R0VVPTsBQafpIntlxCBEsZxvvphXjR+6+1cvpbGvaowlpDNmV0BCOWTglMujLi8q/ISscF0eNI8AqxoMTswZ/bcOrU4SSe8eZkRdBLmDXBLM154efNI73upi9GSOqRZn8tHGEhKiZrS/y9P+rjuUHOqym3WUT2bu7VdE3Yn+0RxaFeWBRP269v3nhEzmuhyU+FG6QAL07AzkV21ZJkekDuv40/l5vdG2pyr4rQ3C0EWqccWo1qkoLXZtELVt09F5/8dOgJST64Ey8iDQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB8320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 05:56:41 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 05:56:41 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "j-humphreys@ti.com" <j-humphreys@ti.com>, "greg.malysa@timesys.com"
 <greg.malysa@timesys.com>
CC: "ian.roberts@timesys.com" <ian.roberts@timesys.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] mmc: sdhci: Correct ADMA_DESC_LEN to 12
Thread-Topic: [PATCH] mmc: sdhci: Correct ADMA_DESC_LEN to 12
Thread-Index: AQHam/js4UJorbWlBU6ZtMwdvnwza7GCzkGAgABteQCAADdUAA==
Date: Thu, 2 May 2024 05:56:41 +0000
Message-ID: <f8acbd38c223fa16613e7560d5ccef1e3b544edd.camel@siemens.com>
References: <20240501185331.1189647-1-alexander.sverdlin@siemens.com>
 <86wmode1pi.fsf@udb0321960.dhcp.ti.com>
 <CAAjXUar_8wmFiUmo_nGhquwb4iiUmRXWASkg1W9Vga4hrQW-Nw@mail.gmail.com>
In-Reply-To: <CAAjXUar_8wmFiUmo_nGhquwb4iiUmRXWASkg1W9Vga4hrQW-Nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB8320:EE_
x-ms-office365-filtering-correlation-id: f454ced6-05ab-442c-e581-08dc6a6ca39b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z0U3V3pCb05uOVBiN0xxWHJkdUpMaWdtL3dmMzc2bElQL0JBRmdzY1RTRkdT?=
 =?utf-8?B?S0V2emVCY1ltN09zVG9FZklLNVQ1a2s2T2lCKzZ6SVNBeVJSNkFoZjFvRGhR?=
 =?utf-8?B?VHFFM3ByWm5mYmhYR0s0VDBjSy9EWVVWNmlmQkY5YzFyVXFBN1lKUXlZRm8y?=
 =?utf-8?B?ZWVvMUd4d2F4a004VURYNE5ZVUN0cTlDc3RCQkFXb0haa3VoRnYzQTRwb3lP?=
 =?utf-8?B?Y3JkRytCVlp0TUtENFZFWUtPSDFuMWZDekh0UUdLNTYrNGJ1K3k4ckJnSVhX?=
 =?utf-8?B?QmM4OUVwc0NtTlR4ZkVVSlR3U1J2S0oxQlNPSVVzUUpHcjAyZnlkTXhZYWFL?=
 =?utf-8?B?a3FjQVREWDBsSnhxd3M3QTIyNVBHM2g0NkpUTkZNOVRld3krRE14UUdKOTFH?=
 =?utf-8?B?QzUxUjlCWXpLUWFvaGt2UVEzRWNVOVlsblEydXV6WVI4ZHhCTHJnbjhKWHV6?=
 =?utf-8?B?Rm5BTXorWnhuWVFTZk9CYVdOSGRNQUM2RWI5eGZWWFp6OG9LMXhCNXNmVUsw?=
 =?utf-8?B?ZGdCWEQ5bnNlQStMUDJISjNRMWU0VFV1anpwZ0VOQmd4S1hSWXByRlN1R3Rn?=
 =?utf-8?B?TkdMVko3Q1dZUGk0RzZJQ3cxRlRmaVZ6RnpRbFdDU0hTVmt5dXA2elRkazVu?=
 =?utf-8?B?RzMwYW96MXFOTDFkajdUcTRMMGQ1SzFIUG1waVlPRXdpZEJvcmF2K1JBa041?=
 =?utf-8?B?b3JMTDBrNXUyeDlaM05KVWgrRTZ4UGM2UkhGdEkrQ2lRUkhHbzJPZXZiRm9v?=
 =?utf-8?B?bm1DQ29VcGd0UVhxQ3BmNzNvejVEOEtpT1hQSWhaOVBVMCtjVnJteXc5WUo5?=
 =?utf-8?B?d3I0QkM1K3FPVkkxcUl5MFNXdDJxV1VvdzJHYWJ2YlhnUHo0T0ZRalp4RDVy?=
 =?utf-8?B?MERydElFUFRCWGpmejBjeHF2aCtkOW1vcDNGR09Fd1MwMG1MZUtUR3I2NXIw?=
 =?utf-8?B?VGZCRVNVUklGWENHWnplclZwd3NjRTc2ck1Hekc1MTdnV0FNbGdjWUwrMWdE?=
 =?utf-8?B?bTdpSEQxY3hyd0ZuOEc3RldJcEJpWTNVWjNIcDVLTWxTWVZORS9TQ3Y4Z3JR?=
 =?utf-8?B?eW9sU3UrdWNSV1JOSjVkS2hYTjdRQjQydGovQ0xLTUZiT1FLVmRkcWwwWFhs?=
 =?utf-8?B?N1lzSi9NeFZhRmhLL29QY0drQzExZTRqZ3lxcW5FeXZtY3EwNUl3OUd5Y2lN?=
 =?utf-8?B?NU9LemVXRWpOUWs0Q2xGRmpzbXNkTG5Ca091RU43RkVmak1IZzdhQUZNa3ZV?=
 =?utf-8?B?UFR4S1pwQUZMMHgwdGkzY0o0NEJNQlB5ekdIUzdGamNGTk13eXRKR0pyZVFI?=
 =?utf-8?B?ekNIdmlJelhkSTl5UDNkanNSRHFBeVF6YUpzM0U2TlVBV1hHa0hYOHJFek52?=
 =?utf-8?B?K3FyMlBabnZFQUhTRGdHNTU0L3U0Y1B5Q1BDZEo4RVdrQzFzamlocWpNMTBG?=
 =?utf-8?B?WHZySjh1QnV3S25YTU9KNjI0bzJpQUFMZ2NCeVJvdExCWmdpNUhWSytXNmgw?=
 =?utf-8?B?WEo4Uk1lM0E3TFpGSWwrUFkyK2o5QVdCTE96YVVBWTlBbm5YbWdoam1peENB?=
 =?utf-8?B?UTZmNlEreEdBZzJiZDNveVYvRXlpdVNNS2ltV1ByLzhyT2tDVzRra3c2OGFO?=
 =?utf-8?B?NWZ6eWFDd0JsYzczSjh1RWZYLzYrTVdyWlVRWURmN3JDYkxmRVV4R0pFNis5?=
 =?utf-8?B?SGlQU1JUWG1hVnJLaHlaVVY0K2pad0RoeHZQTE9rV0NiM2c0WFN3YWhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGRHWXlaT2lkNkdQU1BhWkZZdGlyd1RVMkZPNldPaWNwbExtWm01SmV5Zkkx?=
 =?utf-8?B?eWFjdWFSeG1YWnAzOE5YaThJd2lyaStXZnpCaUxMeEQzVXptMTlrRy9mejBG?=
 =?utf-8?B?UW8wU1ViNi9Vc1dVV0I0SkR5UDFTSW5MLzkzVDJKR0xRWlIyKzZTaHppcUNH?=
 =?utf-8?B?MzVHNlIvMXQzY1prd21PcW8weWlIZGpLZ21mbS9CWHgyd3NMMzMxTnJNK25h?=
 =?utf-8?B?UEluL0hCa0MveUJkM2tycWNzeUpJRVdtWitTSlpPdlRRaHd3d0NGeE9yQjJO?=
 =?utf-8?B?SmxWMUNmZ3ZkVFE1N0xoa1hYeTJBM1pLWDdsU2dnaU92YWx2TWU3b1dlUmZJ?=
 =?utf-8?B?MW8xMGg1SDliNGkyd1pQc240YkRyZVBDK0EvMHo4MXFTL2RHNG1yelNUcFly?=
 =?utf-8?B?Z0J4RXhReVI1MThGNUhZL2ZqeklidGpLQVFqWDRmTDhlSG41YXFsbURYYmln?=
 =?utf-8?B?Yklyd0lRTE9rc3hrYUVUSU93TFVueVlEZHlzSVFJMjYwWllhb0xtV1RQTEJk?=
 =?utf-8?B?RzRGQ1huclBqYWlYeWVFY2c2RFh4UzBBSzI1Z2RjVWlBdDg3UjVDVFNmMit3?=
 =?utf-8?B?SThUdTJXZXVKWTZaZGNaeWdBQlRYSTA1ZXJabDE1ZS9oKzZtT2RyOW1yRVhr?=
 =?utf-8?B?K0ZCclJwaEJzeWpySlo4YXk4NU1iMnBZTHdwaXBKMWc1Y1ZBcTJOY1AvblJX?=
 =?utf-8?B?eStveGtZeGVnU0VrR2JRM29weW1paEZGcjZadm5KSlFlejA0MTlZNEc5aVF5?=
 =?utf-8?B?b3N6REc0Nm9WenpFU0E3Q2dmQ0JEZUl5M2xBTXgxUlA3eWJrbGc2eDZCVUFl?=
 =?utf-8?B?b1E2TzhoOGpMdE9sRktJMWxLQ00vbUtyTnlEZnEra2FDM3gwQUxKWVl5RTU0?=
 =?utf-8?B?anorUzRWLzlQVkxQZVFyeUpKYjBZNWh4TmxPakc5SnljczgrS0gxTVRremRm?=
 =?utf-8?B?ZnZMQks3Uk9scjcrMnRzUzJncHg4YU9WUmJRTVREK282dnhDNDRCVFUvV3Fy?=
 =?utf-8?B?d2hRZWs1bXFyc1E5ek43amY5NytSRnZCTFQ5OVhhVzU0b25ucE1CSUNNbWJt?=
 =?utf-8?B?TUt5c1QrZU1WcFVsZmVoT0lwRXM1ZXFBOEFnbDU3bE81dE9kUWpUQ1pTS1hL?=
 =?utf-8?B?elMzRkVWY3gvZ0liNWdXUU5yaTk4R2thTGRmVUoyYTVyUWRSV2VYNmRsQVVj?=
 =?utf-8?B?S3ZFdk1WSjcyVWdMWHREckhDOXJYSXdnK09yQklmVmdXall0WGZBM3VFbzMr?=
 =?utf-8?B?ZmlKY1lUTnE2YTlFK1hvRUdRUjJPZUR2R3IxTlZtVGJsZ0lielNVUlJ2Z3Nl?=
 =?utf-8?B?UnVyMm9vK2thT3VBYjNDbCtCQnFkRC9kWDVCRUZteHdwdWdNZlZlakd0Mmxt?=
 =?utf-8?B?UTdPbHVlNVFWdE9ySHV6RnNzR2pLZ1o4SUVXd0ZWVE5UTG8zdkRkK3NxOTJJ?=
 =?utf-8?B?aXZPSVpCbHpndlczcVdwakNiRXAwbHk4ZnlGNjBCakJQNDRkOER4d1FvMmF2?=
 =?utf-8?B?SVRkaFZLTWc5WDkwL0RKY0xLZ2cxandHQlpCODJiZFlWb1FpNktYS0l6bHZO?=
 =?utf-8?B?a2lSV1czU244SVV6Ty9yNHFXZXNFcVhCYTdrODR4dUs2cEt5aUNibUZ1ci81?=
 =?utf-8?B?Ry9MYlJQb1lnRzJ5b29RcXdsWlJXcmZJOVkvYzlyK2xvUk9oN1dLVXo3M3Fn?=
 =?utf-8?B?NERFU0QrZWpSdmhCSGFRa0Q5YzgxZlRuY1RzaFlhM0VTU2xEb1o1ZVZIakp0?=
 =?utf-8?B?Zjd3aGJKQWhTaGk5ZzNYZUl0aEtlVlBadG9hRXVXSlNjZmQ4ZmxMS0ppcjRB?=
 =?utf-8?B?Y3h4NU5MODBhMFVjNHNobzdKdngybXhsOFdncS9FYk5sMVhXM1VnWnpYVy9n?=
 =?utf-8?B?dk5HSW00UUo5MDZiclNSanc3OEZmT2NrbU5jbmRoS3ZQTjVyeHVaV0ZNUTVp?=
 =?utf-8?B?SXcxODgvN1FqZUgyK3hnbDRSNW9NY0VPVkpnSnB2OVJvZFoxNUE2akR0OVlm?=
 =?utf-8?B?WE43ZnRIR1djVmRmTTRJUjVtWHNmWmwwMXdSZE5lZkh3ZlRadEFuMFM4ZUJM?=
 =?utf-8?B?a3lndXZKTTBaSE1pTWJZWEVNR3hHRlZtdlB5TVlaK2g4R2pHVlUxOVloanNu?=
 =?utf-8?B?dEFXbkV2SGpmMmlUV0NnSnBadHVqTUpkeGxwVnlMWVdwY2RFZW1NeklKenhy?=
 =?utf-8?Q?e8u0P8a0UAnzJMmvCMYHuBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28627043FD0E064D84F756C6F8276068@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f454ced6-05ab-442c-e581-08dc6a6ca39b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 05:56:41.3192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5bEfeHo2b+//DQrT0XPFsvlz4/3CD5wzl8VGNLvfpfPgQwWCTX+Mc853x984pN1midQZdySxzDovdJh4SFUGhaHmCrZHcNw0yjAJQJBdtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8320
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

SGkgR3JlZywNCg0KT24gV2VkLCAyMDI0LTA1LTAxIGF0IDIyOjM4IC0wNDAwLCBHcmVnIE1hbHlz
YSB3cm90ZToNCj4gVGhhbmtzIGZvciBmaXhpbmcgdGhpcyBmb3IgbWUuDQo+IA0KPiA+IENvbmZ1
c2lvbiBwcm9iYWJseSBvcmlnaW5hdGVzIGZyb20gTGludXggY29tbWl0IDY4NWU0NDRiYmFhMA0K
PiA+ICgibW1jOiBzZGhjaTogQWRkIEFETUEyIDY0LWJpdCBhZGRyZXNzaW5nIHN1cHBvcnQgZm9y
IFY0IG1vZGUiKSwgYnV0DQo+ID4gdGhlIGxhdHRlciAiVjQgbW9kZSIgd2FzIG5ldmVyIHBvcnRl
ZCB0byBVLUJvb3QuDQo+IA0KPiBJIGhhdmUgb25lIG9mIHRoZSByYXJlIHBsYXRmb3JtcyB0aGF0
IGRvZXMgbm90IHN1cHBvcnQgNjQtYml0IEFETUEyIFYzDQo+IHNvIHdlIGFsc28gc3VibWl0dGVk
IDUzNTljZDExMzUgKCJtbWM6IFN1cHBvcnQgMzItYml0IG9ubHkgQURNQSBvbg0KPiA2NC1iaXQg
cGxhdGZvcm1zIikgdG8gc3VwcG9ydCB0aGF0LCBidXQgaWYgd2Ugc2F3IGhhcmR3YXJlIHRoYXQN
Cj4gcmVxdWlyZWQgdjQgZGVzY3JpcHRvcnMgb3Igc29tZW9uZSBpbnNpc3RlZCBvbiBpdCwgd2Un
ZCBuZWVkIHRvIGFkZA0KPiBhbm90aGVyIEtjb25maWcgZm9yIGl0LiBEbyB5b3UgdGhpbmsgd2Ug
c2hvdWxkIHBvcnQgdGhlIHJlc3Qgb2YgdGhlIHY0DQo+IHN1cHBvcnQ/IFdoYXQgYWJvdXQgbWly
cm9yaW5nIHRoZSBrZXJuZWwncyBkeW5hbWljIGJlaGF2aW9yIGJ5DQo+IGNoZWNraW5nIHRoZSBj
b21iaW5hdGlvbiBvZiBjYXBhYmlsaXRpZXMgYW5kIGNvbnRyb2wgcmVnaXN0ZXJzIHRvDQo+IGZp
Z3VyZSBvdXQgd2hpY2ggbW9kZSB0byB1c2UgcmF0aGVyIHRoYW4gaGFyZGNvZGluZyBpdD8NCg0K
Y3VycmVudCB1LWJvb3QgbWFzdGVyIGNvbnRhaW5zIEFETUFfREVTQ19MRU4gdmFsdWUgZnJvbSA2
ODVlNDQ0YmJhYTANCndpdGhvdXQgYWxsIHRoZSBwcmUtcmVxdWlzaXRlcy4gTXkgcGF0Y2ggY2hh
bmdlcyBpdCB0byA2ODVlNDQ0YmJhYTBeIHN0YXRlLg0KDQpNeSBwYXRjaCB3aWxsIGhlbHAgdG8g
YXBwbHkgNjg1ZTQ0NGJiYWEwXl5eLi4uNjg1ZTQ0NGJiYWEwLA0KYnV0IEknZCBwcmVmZXIgc29t
ZW9uZSB3aXRoIHNvbWUgZXhwZXJpZW5jZSBpbiB0aGlzDQphcmVhIHdvdWxkIGRvIGl0LCBJJ20g
cGVyc29uYWxseSBub3Qgc28gc291bmQgaW4gU0QvTU1DIGNvbnRyb2xsZXIgc3BlYy4NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
