Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024FAC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6264180711;
	Thu, 23 Jan 2025 14:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hilti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hilti.com header.i=@hilti.com header.b="lJwgL3fI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D66280275; Thu, 23 Jan 2025 10:01:01 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E852C80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 10:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hilti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Klaus.Rosenschild@hilti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Alyg7Fuy2EYj1T6EB5lDlLHu/IywURi/LyAf+GqbxyAbPn4hrexLn4owFnB74mXHIXlbVxe4rNGkphopzWTJTkuswSqammIb7ifzYYp7xjP/YwaGbGzX8POk1HfdhxR63+N8zY4KXC5u3HKKCk58gwyGYNK1LQj1RAU64IyxzpAB88fVX0sSkrAc1q0Cn+xnPeaDmVJQj3ZyDkk0T9evb781RiajY+977bZZG2hePHlPLVu6wB6F+9GznB8BDLxBqlUxAGFjhDJg3eE4b1yyI7SlB5E0LOKkk9OgJyb9Nqu7uczpLMqBvlYSTPlWGYBnBop2cXvyBNll0WJPGZyn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PObMzqWJcBfA6SsOjAft1FksI3BXh/sivsur0z0greI=;
 b=xlCySc7NELj7knhgkBk/eNTUCHJj9sxrIlkfQRISrSHS+9+Ens6a4jjswkAegNuoWQJJwCPzETLj+xPl0d7GHIXfjyAFTPLI50DiHCuLs1qIIwSzQffXIYGmLGvaIQJPNaAzJrUi5QQvZWlKL3AN7SoronOiUQ/2cUz4gNVDjXxAzjTss6IupHJaFAuR996K8nYo+GU26HCrglKrOLKyr9Q06evUjg6h06Uc259zVOuprRNgovQwD8/v/JRP8Q6ZwT4VgGD8G5g6MpGmuFMQPkHB7Mnc0b8AVJjyvbPjDgkRMUNMczuDKy8calVPyA6oM4a2tEDBWrDXMfJuGT6nwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hilti.com; dmarc=pass action=none header.from=hilti.com;
 dkim=pass header.d=hilti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hilti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PObMzqWJcBfA6SsOjAft1FksI3BXh/sivsur0z0greI=;
 b=lJwgL3fI+cAcLh1UFhuEbhtHTfpT5gOA7R9+3CUJjUEO+5b17lO3WFXaFYPDqTmRQ93nrzgA0bKBdpEXep1624aiTuJkekyAhbRWFfg2UCpueyZYu9EDkqTTgBKVR5zbQueVVVD8VaWcZJNd1mX/fG0jZm4e7Sgqx2FSxRqFww8bb0F3h2jIOXzS1hmTu20VPL7yfmxpWI+WBFB7Y+qTkM+3sV30xa70qzaD712gsMAJ1BDuMoe3SeAsKfY56MdDWKuJmAO1LvHOUQZCuaTbTjeoHbfWkDN+GbFYE4p5WXHC3AFfNG82e24l5jVDm8+SixboHwFEtyF0I4NYoJBvhw==
Received: from VI1PR07MB9972.eurprd07.prod.outlook.com (2603:10a6:800:1e2::5)
 by DUZPR07MB9742.eurprd07.prod.outlook.com (2603:10a6:10:4ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 09:00:56 +0000
Received: from VI1PR07MB9972.eurprd07.prod.outlook.com
 ([fe80::46ff:ad29:1ba0:a265]) by VI1PR07MB9972.eurprd07.prod.outlook.com
 ([fe80::46ff:ad29:1ba0:a265%3]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 09:00:56 +0000
From: "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com>
To: Rasmus Villemoes <ravi@prevas.dk>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: AW: AW: secure boot, mkimage with external signing server
Thread-Topic: AW: secure boot, mkimage with external signing server
Thread-Index: AQHba2LLLJFSbeH4Sk+XJjDH8Ca4K7Mg9wgmgAJMDsOAADCRxIAAn6Wl
Date: Thu, 23 Jan 2025 09:00:55 +0000
Message-ID: <VI1PR07MB9972DBE504457CE207FD3AFAF7E02@VI1PR07MB9972.eurprd07.prod.outlook.com>
References: <VI1PR07MB9972394B8A364AC9A18495F6F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972E22550B1514AD604D399F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972D12CDEDF3ADFF7D81B2AF7E72@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <878qr4wm5o.fsf@prevas.dk>
 <VI1PR07MB997209D177C705DD5371F0D6F7E12@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <87v7u6v38k.fsf@prevas.dk>
In-Reply-To: <87v7u6v38k.fsf@prevas.dk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hilti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB9972:EE_|DUZPR07MB9742:EE_
x-ms-office365-filtering-correlation-id: c8529847-1377-4fb6-ddc9-08dd3b8c7290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pv+tT5rxBKu4csWSDkLnQJlh4+ZRx/U0PdVzln2BcIysrxcrKrtz10wDMJ?=
 =?iso-8859-1?Q?TylsZ/QLdvCMTR1nqrJzWjrud7LGWbqJFOPBS3JIYmgsX958notNHkcw/H?=
 =?iso-8859-1?Q?ycO+4e9uDHHlaz3zOBYv9l1obOREAjgH4vkq55cLqDZxHqehmsJCCQMCAe?=
 =?iso-8859-1?Q?cpz7Dmc0ZiVwvF7cM7+DCWBWc6lvLwOiAS4LgV7nPANxVxNuSsNvuw6G1Q?=
 =?iso-8859-1?Q?rwOv+v3ikbNsVuRg9RBNAYPub3imDbDuga/S2gY1UEZy9MnGVibznjEOSO?=
 =?iso-8859-1?Q?Bp0jJ0E03M2sX+mfpuZK2a6x5tZSgxUj3NXdQJDEunAzT6iI9Ovs3t/hjP?=
 =?iso-8859-1?Q?yEG69O5L7pJjQPDhVrPU8+kIYBZgQ2SwaQoQqMClOp06B4kJTsUR/eRlEo?=
 =?iso-8859-1?Q?KAf8TtVMxrPtk/2PX4Lga0Y2UIFcT481x29XU28hIzcT5YLrolxx5sU7g3?=
 =?iso-8859-1?Q?nR9sTlXamBijsRP9xD6Z/1/6t41bjI+WMAlZEi2rLPWIYc4VCl0g1pt1GX?=
 =?iso-8859-1?Q?bZsMK7OdlSm3P9DucyG0RF1VFsXHyx7TPsaLD6j0yBmUrIsNcrCrbx/rbE?=
 =?iso-8859-1?Q?ldVa5N2IiujxUp3SwP65ju7aAr8K5iab3uedzyN/tw8wqHNpOotGXKbWsl?=
 =?iso-8859-1?Q?QiX5d//Nn/94/OT/5tgvE4aHCz5WQbTjwYj+X3l+qGNDChV98ZUJe4HwsC?=
 =?iso-8859-1?Q?hAsSk9r0owYGj/hLY5oV19TjtiYZMLwjyKjdc7JSEhEm1bX7oXABa0Mvsx?=
 =?iso-8859-1?Q?+wegdgDawIbNI6+29jLnej90uffq/KLig9Kt752h8nfKEmorfmq0II1jC0?=
 =?iso-8859-1?Q?gGk72KmyJmIvp/CRz6Ft/ZaDKQVXkH19K9y/DRLPrQ7yI1ECv384OevTuE?=
 =?iso-8859-1?Q?Zu/9cpLQXq+Vpq8RFqawFCED/Z5GqHeElYuuvmTsyHuKrBrYJJM95JqFEk?=
 =?iso-8859-1?Q?8T8OwFwxZi2M0M8yhJWk70K+kX3ciHUeaYZdffLjoQ/y1xr1IRLu26hcx2?=
 =?iso-8859-1?Q?qr0sO7umlBG8mQwcik/jNM82KzZCdkilV3UtG42K0X1lnrxlh/yui554u3?=
 =?iso-8859-1?Q?VQ5DpHOtdDBE+cYhm5A5un5saUHkQ8Wc27lvCMiCnbfDsn2hMXQ0OkINTt?=
 =?iso-8859-1?Q?MBhUsjexFsKY7xySYkX3ySwXzmEAtEgXSKLytMAUr/xhbDHR3jy058pQKa?=
 =?iso-8859-1?Q?O4oan3aGXY9m9BYEf8oUgDT3wyrjMMwA272k2OXpWc5EHfJe70ByjPBnT8?=
 =?iso-8859-1?Q?fYQp++k5p/zbGIqy/YlwuGQo9H1G6GgKGfDnMeLAnmZbc8OLeXKduac0h1?=
 =?iso-8859-1?Q?rinRNbqC8nuUq0WaXUHRPFCrochnqPmG+Zp+ZkMTmZYehQB88bVT4XOtJ4?=
 =?iso-8859-1?Q?fF/qrXZmZ8qsScFn/bxAihrAQS00vR9W/X3bqAagUcBbKssbh+ISFnM8Wm?=
 =?iso-8859-1?Q?2WL1gI4KzL2NK8DU44ZdHX8bD8LozvdRrWpk4YJ0xtSEzKoV0HPieEHhUV?=
 =?iso-8859-1?Q?nTLgl5TJOfqdJXSXqQWEHJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9972.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4eun5Fq2CL3kJFCVbbDd5fYJkHzswwctUH/VSxcH1m5BioohUpS69mLcGB?=
 =?iso-8859-1?Q?hU5phLMNzaBse8MbWGajdBk9kciZedOSmSkZJEP6LYSAUL0MFATzD0bt8Q?=
 =?iso-8859-1?Q?IY4mFeA+/EKLPuHpNWg/NPae/Ecc6OehGowFO9qVblK6pQpFNYMYL8m7qh?=
 =?iso-8859-1?Q?nahzXgcGME4Fqf6OCAChLFYNm8nI5cK5H9TkFqy/Ab5TOzmThexpiAjKd/?=
 =?iso-8859-1?Q?/lEX4TR3/q9tnTFtAtWZiLZaFf6qN8SiWYHAqaU7Kgw2L3nKGflhrL/S68?=
 =?iso-8859-1?Q?8K9lyEKpDBa4fmp3K2U4rFGV7TuL8aV0w/JVt8f0FuFPCxRiu2iAD1tmQJ?=
 =?iso-8859-1?Q?p6sd1wCCfpQLbuFvcdDQ6Ps+19POr3HjO511RYnbkC1IHfrJlTlO5Ysqvn?=
 =?iso-8859-1?Q?213ZkrEcd2QBkahC6Nv16L2b+5w6bR2VBFwTQZMA7wGod9dUAYm6k8hBzB?=
 =?iso-8859-1?Q?FmcRcESultRAhh/VMnj1d9qAf+OjX7coxewKLq8P2AEwi3juzaBioB59p/?=
 =?iso-8859-1?Q?D4MwXCKLLivoGtZ+4/Aisvcf/xP6FTpYozp4DOrwAzaWjCs/M36qqViRIO?=
 =?iso-8859-1?Q?NDPGcq9cMDMae0D2oCjCpp1iL9T55p3mQ8v3x0qfJ+qAxqjk28xeY16LDc?=
 =?iso-8859-1?Q?r9MoJ7rVf9LAEFIhi/moEkBdaHmUCos2IytFyFowx82L5CDmRXt3A4aMz6?=
 =?iso-8859-1?Q?EKNb16Q/9SrVIncWFftNm1jdJBilgKCi7BQb39n5NJMz0u/MefXt8s6aGn?=
 =?iso-8859-1?Q?+VwAf63KJo8/PMJts0FHHejuDeV0+M59VKPYKMbRdt1gYrU6RuGFW31GwB?=
 =?iso-8859-1?Q?+QZz7B3SCXZAqvNnxxIuim5/VHflxYBkfraeJIY8fq0+wxkvpgZoYfTUhx?=
 =?iso-8859-1?Q?HD4Z1aL55C4xfIh2wrQH8zxgLJGYMDk1mkGOntT2UvpghBNgRddQeG3J/J?=
 =?iso-8859-1?Q?4dmToyeoHnpE2Mi1Y2tWT/3Ag68MES6z+Azz40SMD9k4LSnruwcDtIDxNL?=
 =?iso-8859-1?Q?Ti6aToB1GHARuwHbvffSump+e3o94OAruT59/wuAu6mv01rGUqbGlWvO8z?=
 =?iso-8859-1?Q?48j7OhMfd2V6b59KSa3RTJjcrsSXABtJBgEZbzGl6pUm//gK3TaYJTOMEq?=
 =?iso-8859-1?Q?y2cdW7orV+BZcQqxBvyGbNgYJj9DKFSAqWNuAYOwk00nz4z+gHdBe28y4Y?=
 =?iso-8859-1?Q?UKzuzKyNP51HaMtJGISb3jniszKvD6GMg9GcwN1am0BzUoPtfyq9wJsfDY?=
 =?iso-8859-1?Q?jpFfMpc6NpLruRDuzR11YBR2zyPiA9RrAXpc2IR03uzWSObhCaJYoMBlBv?=
 =?iso-8859-1?Q?bA0qhyff+gi5hhwu+kkSDbgddUG8F1uuCh4avWXu2NH0WbiqUuYIlY/mwZ?=
 =?iso-8859-1?Q?QXo9mMTTrTj7sbKXai6kNgIKv03X3HT7E1ll7R/IH9cqf9wTQ8O8Ou2UGd?=
 =?iso-8859-1?Q?oMHoPqrk0EPqajIFWQd126hICfb3IAT5SYh0kQPh4mhY0zUcb+zC2CpedQ?=
 =?iso-8859-1?Q?VyfSjP3tj5sx9A90bNXheOIpLLfMnrAcBcKb1qIfM+xNy0KMeFF8AzkPrg?=
 =?iso-8859-1?Q?lNVfxNcKv3fq7INJBg9Ro1KzOVHfrlscSHqnOFwaszcI0qHPwSzCUCuvdC?=
 =?iso-8859-1?Q?s8M2CZegsaP6s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hilti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9972.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8529847-1377-4fb6-ddc9-08dd3b8c7290
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 09:00:55.9879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f039b656-fc02-4e54-88ba-82626f29b5a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A19TWpgQLH9cQMWb6OP9V/XLamfiTnC7puYW+u4avc5Us/4FAEuS5ICvvc1EvzYK06bkYHrR3n488nKKerxt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9742
X-Mailman-Approved-At: Thu, 23 Jan 2025 14:01:27 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Wow, the hint to use "tools/key2dtsi.py" saves my day.
Now, I think I have all I need to create a FIT image to test the approach.

Thanks a lot
Klaus


________________________________
Von: Rasmus Villemoes
Gesendet: Donnerstag, 23. Januar 2025 00:27
Bis: Rosenschild, Klaus
Cc: u-boot@lists.denx.de
Betreff: Re: AW: secure boot, mkimage with external signing server

CAUTION: This email originated from outside of Hilti. Do not click links or=
 open attachments unless you can confirm the sender and know the content is=
 safe.


On Wed, Jan 22 2025, "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com> wro=
te:

> Hi Rasmus,
> thank you for pointing to this solution.
> I think this is the best way to do this.
>
> However, our signing server is very well protected and making changes the=
re is a long and complex process.
> Right now, it only provides the following two functions:
>
>   1.
> generation of a signature of a sha256 hash using the private key
>   2.
> providing the public key, the pure key, not the certificate
>
> I found a workaround to determine the hash that mkimage uses to create th=
e signature of the configuration without re-implementing the internal algor=
ithm that mkimage uses:
>
>   1.
> create a temporary rsa private and public key
>   2.
> run mkimage to create a FIT image with signature: mkimage -k keys-f fitIm=
age-sign-orig.its -r fitImage-sign
>   3.
> extract the signature from the FIT image
>   4.
> re-generate the hash from the signature and the public key: openssl pkeyu=
tl -verifyrecover -in signFile.hash.sign.bin -pubin -inkey ../keys/build.pu=
b -asn1parse
>   5.
> now, I can send the hash to the signing server, get the correct signature=
 back and re-enter it into the FIT image (e.g. via python libfdt)
>

Urgh, it shouldn't be that complicated, and I would consider it quite
reasonable if mkimage could be instructed to emit the hash it actually
signs along with the signature.

But, I do think you should be able to create a pkcs#11 module which
simply takes that sha256 as input from the higher layers and does
whatever it needs to do to talk to the server, getting the signature
back.

> However, there is now another problem. I also need to put the public key =
into the device tree file. So, I have to run a slightly different mkimage c=
ommand (with  -K option):
> mkimage -k keys -f fitImage-sign-orig.its -r -K bcm2711-rpi-4-b.dtb fitIm=
age-sign
>
> However, the -K options requires a certificate and not just the
> public.

Yeah, that is a fundamental design flaw of mkimage; one shouldn't need
to sign any image in order to get the public key data embedded in
u-boot's control dtb.

Fortunately, you can ignore what most tutorials tell you about that -K
option. There is a simple script in the u-boot repo, tools/key2dtsi.py,
which you can apply to just the public key, and you get a .dtsi fragment
that you can include when you build u-boot's control dtb. Either you can
use the CONFIG_DEVICE_TREE_INCLUDES mechanism for making sure that .dtsi
gets picked up during build, or you can simply copy-paste the contents
into your board's .dts file.

Rasmus
