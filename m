Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55053D73E87
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 23:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033D984120;
	Fri, 30 Jan 2026 00:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=keytechinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=keytechinc.com header.i=@keytechinc.com header.b="ELzhO8fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190FF84101; Thu, 29 Jan 2026 23:18:09 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE62D840BE
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 23:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=keytechinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonny.green@keytechinc.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQGAvAghI9ZF0DOVDOE5PwdM/0b/dmYff3fXL4nulYvSkLoRenGs3U6u+0Rcem52vjKMrBlCRol7/MdnYOMcySAFCfXCS7eLWDEMM8QKh6xX0S9trzy9kjlJHmsu+CMe/tDEtG1gSbyh2blEK94ecbpotl/pk8M3EFK0zxbJCo9X8+vyjnFokFiinGALQrU3bB0xtzLNpCmufTukSHXZ6vQTM1KDQhGQ7mLy1Me3dSpkQSgHZNAQRvpe75xR3bWKQD/XI5TGzq8OUpf1m+E21bFU+DBJrnZurji6qzyYRqzDL/He0w85EkL8x7tu/7EvjOTPw5BHLr2rlcToeSLXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyzpH9cSrEnpmPsuzPQfbG3X4xPm8j4b/w+bkgytM9Y=;
 b=kUim3/ZX9EFLGpM2olDd+Wqiyvabkx0UwpqwrEZIk5vHRPz48yREAYM3E8DQfeu3C3mxSM97AAxWvfZZejeAdHtB/X0QsAK12L8LUXNvLH52GvA3EnYvgPr/YX+DbHe9zhYFQ7Xu1Kh8tYV7pZv1ajgFTSxCi4VTtazDdNo+Ho5PH3XUvZLne5+9YVlWT4zyZhaEl2JKyfEYutOBurzlSanvZC3C96bkEztJrX2l4Q1zUu3zqSstqTEbROpKWCfL5AahjYSGttuje1bxEMRE6EjnkOAF7oElFyGaCqr3tOQKio2AiYyyyb/aY7e+XWgUf1NHtIgKZMO7CD4QfKe9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keytechinc.com; dmarc=pass action=none
 header.from=keytechinc.com; dkim=pass header.d=keytechinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keytechinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyzpH9cSrEnpmPsuzPQfbG3X4xPm8j4b/w+bkgytM9Y=;
 b=ELzhO8fsqMbfjn7+imKFHbLPmCj5RQEH9PczL8DgqWKxxvln4OvSFNiL2YygM+slcI4SudJ9QGr3MRpl1NBfNv5cwBQBtsTYixNkpDPtIsFGmT+uN1TYKzuAz1W1ASsKI1k7ufl4LkWuJ/+U5LSaJfsR2t1edii4v4qHNiLZFKs=
Received: from IA0PR17MB6613.namprd17.prod.outlook.com (2603:10b6:208:406::20)
 by IA1PR17MB6719.namprd17.prod.outlook.com (2603:10b6:208:3db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 22:18:03 +0000
Received: from IA0PR17MB6613.namprd17.prod.outlook.com
 ([fe80::50fd:4b7c:7b2d:dfc3]) by IA0PR17MB6613.namprd17.prod.outlook.com
 ([fe80::50fd:4b7c:7b2d:dfc3%4]) with mapi id 15.20.9564.007; Thu, 29 Jan 2026
 22:18:03 +0000
From: Jonny Green <jonny.green@keytechinc.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>
Subject: lib: ecdsa: Verifying signature on target
Thread-Topic: lib: ecdsa: Verifying signature on target
Thread-Index: AdyRaOUaNUEOVuZmRo6fHGjoi7UlkQ==
Date: Thu, 29 Jan 2026 22:18:03 +0000
Message-ID: <IA0PR17MB66130E9A26543D795DB5C98C959EA@IA0PR17MB6613.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=keytechinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR17MB6613:EE_|IA1PR17MB6719:EE_
x-ms-office365-filtering-correlation-id: 5137b451-690a-46a1-417c-08de5f844526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?XpqdQCCaVF2IVv4TX0FMi//+biaGr91F7ge5DfHss4esuMdLWv3jh7z/IiC4?=
 =?us-ascii?Q?8lc4hDmrrwCipPdBrt6Sex8Rbiwj6QsW9AOMQDkPJOM0E/ju2wSsRbhYOL5O?=
 =?us-ascii?Q?kS6/zYg+5AOSO2pcARYO1ByiS1HVwHEuVRXEyHWfdpZLHmLFxR4n2MFwshOd?=
 =?us-ascii?Q?Xkzqjlb1xtTSRrpkF20K3UhUDID4h2yNV6AVczn4ctbUKJ1Le3GCewrNhiAV?=
 =?us-ascii?Q?3hKeZYq7K6kRP2gudvQb8j4f1WB+GOwZUIWYJkg/yMrBhDZc9l9X0BwSmX5F?=
 =?us-ascii?Q?uaQ1Uqg0N3CQ5kUxVKrgXcTYnQ7fXENX8uGd4noUoZ6Y7HEyxc7VTvz/I/G/?=
 =?us-ascii?Q?6qZKJ8npQO7601IKEqquDwyV2Sd4/rx/F3ZaOTf254HdyZBBzpLBFSuSL+D6?=
 =?us-ascii?Q?8dJ6o031Miw1rnND2bQG9HQ/r11R/HUtgGaWWeBJFv1sAiXGuzSzKQyCAzUD?=
 =?us-ascii?Q?ARdEhsmHx+/bvNmfdJehc2M60c0egk6q8Bx0jqHOkimxM5WTWnLMaWtUmE7m?=
 =?us-ascii?Q?jeq2eUH5n2MMlT7moQS5tPqUMkRFwWRMsdEqPK0slj/OXg+GZi/xy/b8V4Y6?=
 =?us-ascii?Q?EjRufyEmvj5YlnbeBg0A9uTd4w3j9/XEw0BslTn48CVquwo4/jsHgzMbNGsh?=
 =?us-ascii?Q?zBDOnESTs0vVCka3lNu3MZ/z0ZtltCiitHC9P7+dc09PIFitipGTfUlPqbaf?=
 =?us-ascii?Q?WJaFnoO4FDcZsjx8JUIsOdS84X1iQp7RVS2uQIyRn3/KtDuSlrpdrOnT3KfT?=
 =?us-ascii?Q?LrN+AllWewyVZhqhYqgP2y4wmsz8GuSz7IYkGiNyMKq0Y3DnQV7nzTsTgXcl?=
 =?us-ascii?Q?NaWXlDboyais5Q36x2grgA8r2eICIeq1tFPRzUXKfZKbY5HriSpWqyup+RhP?=
 =?us-ascii?Q?+KWEQYoZ93s2+p2WMuxASqtMqtf7J4w4JmJf9HzjiXvEmMNnV7PXm+qufiB7?=
 =?us-ascii?Q?PZnc+RXnADpBnspiSHsjTf3NQqcjhS3HmkDH3XVng1M0veDISGDBgvifJx3P?=
 =?us-ascii?Q?tMR7BkLFH5SMw0mGgE/frCNnGps1dz3NAbmL0178YXCE+om5kdVW5z3dUfO7?=
 =?us-ascii?Q?JIiubD2yvnnoaYpd2+srtfzcqN81ukbzp8HSB2RKcXvIEjCj+CIdcu9lmqiE?=
 =?us-ascii?Q?NY9Pdo+PvpLb1xohsfvdBo+yo7tMnqPob1znAHutZEZtFVZhW29lj8w1nwM/?=
 =?us-ascii?Q?uJ0XHsBRvqfEOpdjC/3E0qHT27ispv4BGoiVQUsIvGHI7FvcB/lcnBERqnIm?=
 =?us-ascii?Q?a3sslqTYZRWaI2ZyX8GOmLfIEYqEankdVGFs0QuBA+Yjtm4b1E0MlmplNDYb?=
 =?us-ascii?Q?IEw45wBX7mt0I1DtaVgFXmYtEgetnaE6TJZfhVAqR2Oy8k0IzfxFHPX9FybD?=
 =?us-ascii?Q?ttHnxZpNb3Rid9oI+KeuuOfKx+PBLZACQnwsVwTvxgytLenfpTNgeQix0ZO9?=
 =?us-ascii?Q?hW2n3F/QSIUy7Gmz+SEzS0KVW1iSyg4DW/lKNKF7X6sZAW9yBrD6upFUwmVb?=
 =?us-ascii?Q?MRRyZKkAjgNY9+OR2Mz/pu8qfhwjlIA7S5/eVdPtlE75IAaLXEkTXXgR97C4?=
 =?us-ascii?Q?bxRlQ5yPV1n3YCpbTr+HbxmeKLDD0NJbbJz0Jy0loT6mUwh7rCgP6jxsPP3R?=
 =?us-ascii?Q?ewp9g7bLX72xM3vuodkRYrs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR17MB6613.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?duo0lqSqFVBkui0FhzO5ACYnGVA82nR8L64romlSuNj3lCsjmbQp7o/2knUl?=
 =?us-ascii?Q?b8ScYBKq0Vr2FrlJL5+urcop9LGse28mSsB8lxUc4bfGw3sEIiXRxpwBICQP?=
 =?us-ascii?Q?9OGnE4LH6aN6EcUPTS3E3len5cgq0zdS9XObCSTXAE1+kPqcwsVrENgddZyD?=
 =?us-ascii?Q?xgUeM8xZ1Od8vlVAp+t2kK60jcDidX7TqTJzPfhJkPC9H9dY1NxcWL4BaGk6?=
 =?us-ascii?Q?TWVV7zhEPaFZmdquBMXhXNoD/spc6kYyKiTq3zvRx1bQN1AHhr+NtcaoppwM?=
 =?us-ascii?Q?2psklqHX90pLqN4gt5t/6+oslt+a6lw3AIX/cpVjok0dgl9hORKfSpTrNA6x?=
 =?us-ascii?Q?Gcw0gatLeWi5dEN2yW9uc2rPs/FvB9KMYdZxnFOKA4nLjh2AC7Z4P5RKcgpw?=
 =?us-ascii?Q?vcGENougbpe6aPsauPzS6F5HxWOv04uRk6vas/TBvkqUAe3iyKhL3qYx0ZcA?=
 =?us-ascii?Q?f1BY4/yAn2FMLn3U5hflPFJtA/Jw3Qt55QvqLzZsf5GoeD4olGhiCfb9/6Tb?=
 =?us-ascii?Q?5HA1lOzqAgBad6CDuNBdvjMK8urdfEXmASXfw7fGIqZqWrbx0hNtg54neAUz?=
 =?us-ascii?Q?o47Y41tPYf4N98EH02/pzRJOIndhaFriEcHHyUEOTPde/xWf7T32zueGlxi7?=
 =?us-ascii?Q?bqHM33ULY1vghzeInCYH08ioqjyxv9fFV71ufKx2swT0pgqp3od12SytAJXT?=
 =?us-ascii?Q?xI0g1Am+BsSBNuZSU8393QimqOrWgPuU8+N4FXEs5rh7V7K/U9MF72a9+Gp3?=
 =?us-ascii?Q?NHJ3tiwjq4WONSjG7XcnqczLpgJOoEA/Xq/I8fUvoYOsqea3Wt1syKi88giA?=
 =?us-ascii?Q?N1gAoHzlgCI17DHBBcAsj8thbSdCnXS929PI2pK9jqRHFx96/Mv6a1bp/c1z?=
 =?us-ascii?Q?KwpqoAFHFMSg/0XV7V07aFlWRgxVn9k9HgUd+AaOsmaM1unvDrKASPo8YFvl?=
 =?us-ascii?Q?CjkZEBOCfbC8WKGwZm6v9jFaF27/Ngxq2hTAOibadkoB6Ii9KBVUyWpO/OYG?=
 =?us-ascii?Q?35GIZWQOILPjBMrX//LrlmJQSl2q81etPQZ0F4cJ6R+4CDrZy7C9ewF6Dh1K?=
 =?us-ascii?Q?2Y1+iPeXIoiHxk/yuUzrnqmJSnDVF44B2J2jROHFMAK7kBCDDm9hd/ZRaaJN?=
 =?us-ascii?Q?kvWCxr2CwuxhpdYZeeJzYg/Wrz3N90iI/Kc68+Y2vxQLsqcp8Y86bt4Xi5Gt?=
 =?us-ascii?Q?RxatwOfSQWunfGqOv3SeONpc0aDCL4vxmOBK8Q4QW7Gh6wBpxj4a87iMBGhz?=
 =?us-ascii?Q?faSn7Lu3JaM+MA7erHCLlVfnHsg5gD0b72AdZ6U8V2sGVPrLDeNRA6C+TDSp?=
 =?us-ascii?Q?4y7JStkE4X/WaZze4s+Bzk2UUuYIax335K/rNaPPhtaNjri0g7q9s5Mv++qz?=
 =?us-ascii?Q?U5+uCNmycCerJ0lhmK0qE7cjoDwUW0QHRd92KKZtcvfXOynCFP7c/s1+0X3f?=
 =?us-ascii?Q?VKZhu8190aj9Kv/4nKDFclRCBHQ4U8O3iMsbd5g0CmsGrNLhXMVwNYndg3Tf?=
 =?us-ascii?Q?S5o8kA5WPWw+q5tqka5HOpgGRAqmU2Y+G7aWZOlu0e1NTE5ZxyeGHfnhGFz0?=
 =?us-ascii?Q?+PXyiyTzwBbKW1xefPiEYwFY2E88kA0kYpz5bbzlbZFPDD8sLVeqkcpw7KuE?=
 =?us-ascii?Q?TwY/5J+FaaMwIUrUPyUOKitTVDzEDKFGA1dpXmFzjqMAb3NBT2HJEAQVOtzc?=
 =?us-ascii?Q?LZ7EGOZ/i9l2PTWHXq+QCDqt03accMU9COg/CDpmLhTVkubMzJjyvuSmPzzG?=
 =?us-ascii?Q?0ezdjoz/EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: keytechinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6613.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5137b451-690a-46a1-417c-08de5f844526
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 22:18:03.3018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ef165998-c9cf-4862-a6d0-c9644af98e43
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YI2xq9jrFyNhPjow1cVK861s2LmGXOJXekGjpJpL50W17wGrmUKr35iHe20n1xJa10SMTWXL3YQ59Gg9kofv1vZOe22184ZhWW95PQxr+/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6719
X-Mailman-Approved-At: Fri, 30 Jan 2026 00:47:02 +0100
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

Hello,

I am implementing FIT booting with an ECDSA signature. I am building from a=
 TI fork of U-Boot that is based off of v2025.01 from the mainline repo.=20

I am currently able to generate the signed fit image, and run tools/fit_che=
ck_sign and confirm the "sha256,ecdsa256:<key name>+" output indicates succ=
essful verification of the signature on the build machine (note: I had to c=
herry-pick commit 8d3a9ab3 in order to get fit_check_sign to work properly =
for verifying ECDSA, since this fix is not present on my current branch).

However, attempts to boot on the target with the signed u-boot.img and gene=
rated .itb are failing. Debug printouts show that the call to ecdsa_verify =
in ecdsa-verify.c is failing after calling uclass_first_device_err: "ECDSA:=
 Could not find ECDSA implementation: -19".

The uclass driver declaration at the bottom of ecdsa-verify notes "We don't=
 implement any wrappers around ecdsa_ops->verify() because it's trivial to =
call ops->verify()." - not sure if that is applicable here.

Other debugging steps I've taken:
* Ensured public key is present in the booted image via inspection with fdt
* Ensured relevant config values are set: ECDSA, ECDSA_VERIFY, FIT_SIGNATUR=
E
* Attempted to get trace information from the boot attempt, but it appears =
my board does not support the required clock

I'm not sure where to check next in debugging the implementation. From the =
commit details in ecdsa-verify.c ("lib: ecdsa: Implement UCLASS_ECDSA verif=
ication on target"), it seems that it is intended to be able to perform ver=
ification during booting on the target. Is there anyone who is familiar wit=
h this functionality that can help out?

Apologies if I've made any formatting mistakes, this is my first time using=
 the mailing list.

Thanks,
Jonny Green
