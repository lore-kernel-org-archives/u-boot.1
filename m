Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22301048926
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 00:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E109183EC6;
	Sat, 28 Feb 2026 01:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gatech.edu header.i=@gatech.edu header.b="lYFrdQUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB7083E81; Fri, 27 Feb 2026 22:28:51 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1258E83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 22:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=slee3846@gatech.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDOXymCwOjfTfbBSz9ISJl83KacdU8T9Yw8J8OUK6swF3CrK0/YJlhlQc1LPQCRSKOPH1/5swa9uGwVNKmRzItkP85k2W21cJRYrzeNOJBlOEp5uYI40Ttvs1GCd+s1+LXCwLjD9BbTyErFNHPdzB3+X9Pe5m0k/ijs6DPf5GkqPGzdpxD6bqlzCs4pdODjA+bX8miaxtcd9dKYHaZtoID8FHxz+MbTpBPA4qT+ITy7+w/jnbkRMgkPMwNhkUlo14JLrKPd6nBv40AQW7Jxp0ifE2vDfQCwqrM51Dh7Xw9w7ml69ZiUINgaPJoKIW6mEK9bMFWeBZUd/IEHVw/YS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHsAkXnt9RO0AsFAyBypJGRft7SpLSnZk+6FoZ00SjI=;
 b=EZAZQmUZE7v8WOuvhJPqZoGHUw56UcK4NqeoDk0siefifLjzINFF0eat1d361TApsJ17cdBHyFASFm0GibjC4mM0b4bmth56RPamNT62rOHWrvcXrFmGQ3/2rw2AzJxNpKNeuWWsvTsgToREIZHB1w37XrRLGKIgVryIXg91ti6ZmIY8VqpQjcOvdNJRXoc8SdhXo+jloAnCH8YBUvUlGiDjLl9NdR5OUbBdYpW66JvFkoqSM6yNNM8zLU0U2ZcM2GIverGcpPJM3MWEH1qk9kl3/lF/h2hYKe2ZPn7U8npv6NA/K04MM3td24wJhA1j3iwK1tej1cz45iomlMX/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHsAkXnt9RO0AsFAyBypJGRft7SpLSnZk+6FoZ00SjI=;
 b=lYFrdQUo9JA8Y0P28gUJrgPJdWKy759Eph8QtEbF20DjhQFNtzIOZRJrY0HRXI49WDbqZaF+bYSkA4d+PJzIiXEo/45cQ7nfJMVecia9bT31hsubTI4Jqj+Y2PlrqMpJ43l0CuUFwbQKM2iDF4Fq76FO3ii6V+XTuJdWz0dnB8nxveeUP1ZbH3sSndEjgH4XkGhiLZwuANkHxMifBUVClbUoLORK6Vv6REZ0gdwyTJ673oL6k+M+BiXY99gwtoNGLbkOnxAQWvXIOPq7AAwfGwSMibEiDypaWg3WtUx4K3OidL5e7uQ9nLaRhrQZyPdDsfZtJG4twUbQoLBVit3tFQ==
Received: from MW4PR07MB8636.namprd07.prod.outlook.com (2603:10b6:303:105::10)
 by LV3PR07MB10427.namprd07.prod.outlook.com (2603:10b6:408:237::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 21:28:45 +0000
Received: from MW4PR07MB8636.namprd07.prod.outlook.com
 ([fe80::29b8:15a9:4cba:aacc]) by MW4PR07MB8636.namprd07.prod.outlook.com
 ([fe80::29b8:15a9:4cba:aacc%6]) with mapi id 15.20.9632.010; Fri, 27 Feb 2026
 21:28:45 +0000
From: "Lee, Sin Liang" <slee3846@gatech.edu>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Kim, Taesoo"
 <taesoo@gatech.edu>, "Zhang, Cen" <czhang887@gatech.edu>, "anshuld@ti.com"
 <anshuld@ti.com>, "bb@ti.com" <bb@ti.com>
Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabilities in
 NFS client
Thread-Topic: Security Disclosure: Multiple buffer overflow vulnerabilities in
 NFS client
Thread-Index: AQHcp8KHO9No1PLzuUO1ZFAlOSOgc7WW4gEAgAAtnn8=
Date: Fri, 27 Feb 2026 21:28:44 +0000
Message-ID: <MW4PR07MB86365FC9B8024035576E2C7DAA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
References: <MW4PR07MB86367A3DBC308E10144FE6A6AA73A@MW4PR07MB8636.namprd07.prod.outlook.com>
 <20260227184202.GZ1593142@bill-the-cat>
In-Reply-To: <20260227184202.GZ1593142@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR07MB8636:EE_|LV3PR07MB10427:EE_
x-ms-office365-filtering-correlation-id: 5524062a-eace-4aee-979d-08de76472fcc
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|786006|1800799024|366016|38070700021|8096899003|13003099007;
x-microsoft-antispam-message-info: 0Qk2Pn5LPunxfqiyVccG0+oTPUXbuBs5fpvwQIDrH/nNh8CvVOJt5QwClsbzwQz672NUO/9SAJRLHyORpZADjTk4rCUZd7aTEQHLplA+hapaZeUitC0HmJKzwgwt50oubFiYIT9cZ5NL9UFj3ULuWQLGEd2GMWRWYY70VrPoFQYv+ontUMQoQj/FNAx6ZfxSh3cIjW4jclUDxt7DBBD75JFfHuvbyb47NBzPQ3W4drdYNZ02LVqGvoHcrnMPNZzMXSFdm9iisSnNYjKfdmqaGa1L4uFrEXx7xKlvs2lBjjocBo2sfzsKSm1V95xPZUW/pFilHjop2TBG5i+wfjEnACYjkb+WV+cD3oAnDibJDPN25+DsK9bsZnfG6DhkXUkbrKU7z94pfu5MGfz3Y/N173O7VJqzcsrB/JeQGwUAveGalKtBBgUDOZvG7Q+vxIaC1e4OHazMuwqFC/C/qWlbtYUE3JUn15sg1bbWm0+lzm94twgJDTEM8FOgypMKb9+75DaLdiw9yFp4ruD54rrR2sZ1N+K2WNCa3jOefWllAsNZSoAN93XRE8u0N4T08DygQqxFIdRwguFlbo1++Qw2LtGsIBqUWg99Ai2fk3ER4crBTD2YEyM1+tKNGqIINA6spzMGQZBsZQUI0HQYs45xh0FSpgTAx8afqlP7jdomVF0P9s0DgzQ8sEZI0q0hK3ObPlTUDc7JW7mU/npJnCiwRA1nQmGZkuIN4O4f4Mf/jNs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR07MB8636.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(1800799024)(366016)(38070700021)(8096899003)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZktAJGA/g4MNcO0HIvSqneMTQgghawAx/EnCvMEM7LZ5aQJZt6nV2QXFUi?=
 =?iso-8859-1?Q?2HVFz0RhBtxDGFxCcMBk97kpZXoeI92AkxKPFanN0GyS0c/8RjXxAkx7lL?=
 =?iso-8859-1?Q?t6HOXp/lbSs7MFEXGS183KWrYVDJ2TBIh08obXzbO/qdpe8OQS9lKIwN7h?=
 =?iso-8859-1?Q?kbft9f/PNupKS3HYapAD7h1orAIpsQ0acCyTCoec7hsR8J94+OXMUv5Jae?=
 =?iso-8859-1?Q?TdKFmwabkTOA1o0c4rn7xmtGrb4WvbKxhda5NFXt0I+RgSYXy8dsTHowZ2?=
 =?iso-8859-1?Q?Of+sMqpvqWppcmSuTCAzm0b3z1pGEXKrBwrUGlO20zyi6F0PnqktyhF3fl?=
 =?iso-8859-1?Q?Y2Py1vztlGqZai78bKJjg+sxvDmoZl7g6TRgLDjaVivt7yIu4vJ+cKel2F?=
 =?iso-8859-1?Q?eFDCccrBrxvb0R1F3zYeSYuoCIaa6Vi6YBS+LU+bKbACeIfUvbi6fowaZG?=
 =?iso-8859-1?Q?kkQEpa+sW6phA98gU1O9P83WlG3CTPW0wEbaaD9vda4ShXAImAEMrH2Q7M?=
 =?iso-8859-1?Q?YNPyDr5weWvJqpONnNtMnPxiWNcw2cdPfP0/ShO8zJV9ra1SgwxMQ6dUH/?=
 =?iso-8859-1?Q?m2tY6CTEO31y9T8/1/F8+afvrWABEGv5CJnmVcnAEEBrSIsasAtxjOVCv/?=
 =?iso-8859-1?Q?FeREFmVK6hVRaAFtOB14Jhjg4Az/IsfPcOuMPQJncN6r8GIvfgzCD3rl0b?=
 =?iso-8859-1?Q?CUb/EA9yjKd0u4tIiKZmerNhiEP/oM3ryWzAy0Nn3pP2hW6oDkSgvyr+Dn?=
 =?iso-8859-1?Q?DKdMNbWzYqCrHiGdabS7QfwEIsxM/cNRPTsONTyA2LOZFxyO1McnT3Haoc?=
 =?iso-8859-1?Q?41xscz0WYb0hjWfWtyDWfeevJvBMzI2dD3KIcsRMr13lhKGTA3DtxgYGES?=
 =?iso-8859-1?Q?cQZHmc2pxRtTEMdZFdWwQhDWmsryZEEWNww4DX9t45f/ZJtyCmOBB2vW7y?=
 =?iso-8859-1?Q?Vpcm2G5kJ+ksHyXf+kp8PeUa4MpCY4aPoc6fkX6Qrc0myVaJhl+ur0oq3n?=
 =?iso-8859-1?Q?93bKLPF0yE1oRiNYD+jhv3iOYwG3JVnYe5yvlUHt7fhxK78Qj5U667xEG7?=
 =?iso-8859-1?Q?KG2Shs5RxdQYB3qF7v4VBdFD3N9s/VniV6pZ1/I+jUDN0OroVK5nfRiTNi?=
 =?iso-8859-1?Q?OLWcJukxQznFlip7dVks19HJKqEJWd0c8OQxS/G5k3PCFQuIV2+5IEOsAN?=
 =?iso-8859-1?Q?n4NE9DJxm70CYi+g4EgGuDbZG9KqKo+iW8MMh+nWkOT0fIuZju16vohT1T?=
 =?iso-8859-1?Q?b2wurbqfgZduns736oWuYsDWsThhh7x/RqR91nzmxtcnGq+uqeRy5mExqn?=
 =?iso-8859-1?Q?tn40w51+AarEaMrsPn0/fB6Csde7XcjbOXcNzlmqdP9pQgPx7vGu95PtTT?=
 =?iso-8859-1?Q?d0/1lNkxCQrxI/PyG5G2Qk5oYxziloiQLTcwMZ/7Z6aptj0Oee9HwtEO7l?=
 =?iso-8859-1?Q?uduhGDczirg/Pd8EK9/Y2r7boyHApy6bSwCTjaoxXz7gB79YWiSNOvZyxN?=
 =?iso-8859-1?Q?UqyHepxHZz2UdTQlX6q8Z5T994i8pC3OKePBu3Gl/dkvT8RJ+ZclfBZgzm?=
 =?iso-8859-1?Q?sBfiuDrvXiRoWGQbMf/hsyjs/WbStuTP5EbokkzMChHcTXyU/T54Sd52I3?=
 =?iso-8859-1?Q?WomubAuJ3OufJLxW2S6gRNO7lbNNqs20i8YnDE0rbKRZhH1s0cxJj/0/3v?=
 =?iso-8859-1?Q?DXusD4AxiCcW55D5aSIKGp0m83pMbTfswDrWXQBAhxK7gLKUKwfk2RBJ/H?=
 =?iso-8859-1?Q?EXGx3LlwUmrWquNMLXFZAMWx9hQxIbcN1luyYaeXR9lUoI?=
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR07MB8636.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5524062a-eace-4aee-979d-08de76472fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 21:28:44.9844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpPKL+7WwP9aokiV+UHktqTYVlNKVw4HT5raK/AaCiRp0Fpp5RH2JPRnzBNumPMFFtVT//6nVZNCaPOOHmIrQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR07MB10427
X-Mailman-Approved-At: Sat, 28 Feb 2026 01:12:08 +0100
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

Thank you for the quick response. We will follow the  submission guidelines=
 for our fixes and attribution.
In the meantime, would you be able to confirm the reported vulnerabilities =
on your side? That would help us make sure we are aligned on impact and sco=
pe as we finalize the fixes.
Regards,
Sin Liang


________________________________
From: Tom Rini
Sent: Friday, February 27, 2026 1:42 PM
To: Lee, Sin Liang
Cc: u-boot@lists.denx.de; Kim, Taesoo; Zhang, Cen; anshuld@ti.com; bb@ti.co=
m
Subject: Re: Security Disclosure: Multiple buffer overflow vulnerabilities =
in NFS client

On Fri, Feb 27, 2026 at 06:25:14PM +0000, Lee, Sin Liang wrote:

> Dear U-Boot Maintainers,
>
> I'm Sin Liang Lee, a member of Team Atlanta<https://team-atlanta.github.i=
o/> from Georgia Institute of Technology, winners of DARPA's AI Cyber Chall=
enge (AIxCC)<https://aicyberchallenge.com/>. We're reaching out to submit a=
 vulnerability report that we identified using our system, ATLANTIS, in you=
r project. This effort is part of DARPA's initiative to apply competition t=
echnologies to real-world open source projects.
>
> We have built an AI-enhanced CRS (Cyber Reasoning System) for automatic v=
ulnerability detection and repair. Using a combination of targeted fuzzing =
(via OSS-Fuzz infrastructure) and AI-assisted static analysis, we identifie=
d four buffer overflow vulnerabilities in the U-Boot NFS client reply parse=
rs (net/nfs-common.c). These affect the current upstream codebase and inclu=
de a signedness bypass of the mitigation introduced for CVE-2019-14193.

Ah, so that explains the squashfs report last week. I am glad to see
that part of the challenge now is fixing and not just reporting the
issues. Please see
https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
to correctly submit patches to the project. And while we do not
currently have formal guidelines around AI-assisted contributions,
please see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/coding-assistants.rst
for how the Linux Kernel expects things to be attributed and note that
we also are requesting that the commit message be human and not
AI-written/assisted. Thanks!

--
Tom
