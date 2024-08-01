Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568F3C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 02:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2DD1881EA;
	Thu,  1 Aug 2024 04:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VAs9UKDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 636AD88ACE; Thu,  1 Aug 2024 04:19:45 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D11881EA
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 04:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi2PaLFcJMgCc16b00f9gXIq6V6LKWVpl2tr0iF3rsVMuNSkiWVuLKj/OmOWsDnAe56Wyx8+z4/wd/yn197shkEWw+MY8mayPF6oElVIhXzIxwIGg3iJ8aiRj+hBeKP+1MGMvh/1DpyO2/CrU9CmoZD7HU6qS2AH9dJXX35vFKrRZZYSV9cuZiExHfQ8jCHCjHr67ePGViaeOnSt+iwGWXJJATi0DWYKiGTSGHzpXrjhxDUYETU2zyAZ5XDnwxnRTM4rICRhNx82eC+k89hBZ++0uJZxDGgbF50anK/ySsHSoswswTWde7mIpo54ozQhmcvqpJlGAGhUcGdweHc1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdBjh9d9hrwTwmyZ+29wVxBy4zdDKgj6NzjSDEI5SqY=;
 b=o3B7ZfD9+wOpg1rKlx/dm113a7tTMhqCRNx6i23HAcqezNvVKjwROnGZS6MxTwUIoO7A/9kEfxP1n3JAFOVttIyZBLvZs3bUrKR5yDrukQlVNHl2B+RxcP36LklB746+w9GkuBi6h6aUUCXq0GJ+bSD4KTwj0AazQANtYTuXpJoKamhnZsYi+K1XY//9qPunntBImWlUugnSCG3gZlcIIR0/fG3ktXiRu5cL4X5aXj+y0VpUM1lQhLuxETQKc1SfQRhhYkcA74GhfFfxAmw5c+eJDfwSbUlWXt1bbaH4mvmT0k0nhdSXQab0Gzow5DMcRYKRlI3jpwOJcZR0sbz9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdBjh9d9hrwTwmyZ+29wVxBy4zdDKgj6NzjSDEI5SqY=;
 b=VAs9UKDsyopuuXKpizEIbNTRA8JXAy14d//FU4xAc4Lm8SjS+Go6hzDPGtkVwpljGpFE1f6KQ5EE/qnNCjjVrZyTb+daj3UWllH1aciUOHkfCCI3t0ildOZekAZSs+VwP9p2CKzVgObT8dl7rTnriZ9wZKRVI2SAdaRkRD64mtViqyXNLnHKbt7ZtUmQHTeikEI9RCOkbPUUK5DijVGEZgmuhbY+U104L5l3m628oJRol+8+pPUXSoeOYLJ3RXgcG0cjUayJLCHnhqATjeCAR0zyJc1N/dr+0ufoSGHFT/5ZDzKq1l5JEyPfE75YIPRwo+RXfM1GvsCO78KLqGtXpg==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PA4PR04MB7776.eurprd04.prod.outlook.com (2603:10a6:102:c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 02:19:42 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 02:19:42 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>, "lukma@denx.de"
 <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: RE: [PATCHv4 11/14] doc: cmd: add documentation for cpu command
Thread-Topic: [PATCHv4 11/14] doc: cmd: add documentation for cpu command
Thread-Index: AQHa4k97s9yzc7hH0UO37OZ8go0zHbIQ6koAgADDOWA=
Date: Thu, 1 Aug 2024 02:19:41 +0000
Message-ID: <DB9PR04MB92360126C2EFEFD5C6DA54F384B22@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-12-Zhiqiang.Hou@nxp.com>
 <CAFLszTi3OzbcsLd1_E6m_oeeFrjCgoTKjye+P0WrUmnAPbccyw@mail.gmail.com>
In-Reply-To: <CAFLszTi3OzbcsLd1_E6m_oeeFrjCgoTKjye+P0WrUmnAPbccyw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PA4PR04MB7776:EE_
x-ms-office365-filtering-correlation-id: 3525e1f1-01b5-4ac6-914e-08dcb1d0670e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q0JwT3FPb0RucWtuS3BTY3lyMzJMQ0FKYUgwd216SUFPaTVlWkd2aHorTERm?=
 =?utf-8?B?Y0VPQStnNjBtVkdONU9UN2p1dkt5Yk5FMUtFTEJCNTBQOVhQVXEzakhpTmkr?=
 =?utf-8?B?SERoam8zejhaSVNSaFZhV3U5UEV2MyszbGNWM1pGcEFjTGVnN1R6cnBCRG41?=
 =?utf-8?B?ZEtFVzh4Tmh2b2V3OTQ1emU2VGczT2JwdWZiN0dTYTBzanZrUjhNRWdEcTJI?=
 =?utf-8?B?YjkwR3VhR3FHR3hRMmc1bnczVEYvZTRQSlhlMXdqMjNNd2pkbkM3S1JHRlZx?=
 =?utf-8?B?cmNVV2hlamZUR3NCUDlHUjlFb05zdnBjM241T2xGLzUzZWRKUTdUUnA1ejVR?=
 =?utf-8?B?Q1YzemhTenc3K25QUjFMbHdYbFBudTRDOUpsQzRGN2llZldRRDR6WEFWczF4?=
 =?utf-8?B?RmIwTi9XYW1obXRFSVhhVER1d054SzNVa2JOSGtsL1Y0a2FpYm54ZWVqS2dh?=
 =?utf-8?B?K1FTaEZZblJGdUlPT0VpZTN5UFlOOGJwL0tBMDRubWtBcUtKaWtRNlpoU0Rk?=
 =?utf-8?B?dXY5dFlSRmRmamh5UEEwVCtkb3VaUVZHVGk4MHhOQk0xbXQ4S09OL0h0WDdI?=
 =?utf-8?B?Zy9OT3dlZnlXWkRxL2tUS21QaEVNK3ROMVRaT2RwWHEvMTdFenVQcWRoR2Vp?=
 =?utf-8?B?ZHRHeWZjWURMQUNaSTYyQlI0U1NmQ2c3VmtjZkhhNWtuWStNbHJOOWhZKzlo?=
 =?utf-8?B?VnJ1dWdYVElYcjNCL0l5bDhucnR0T0QyendFQUdFRmJqdmVxMTZCeERyb3RL?=
 =?utf-8?B?Zk13VnU0cmhQdUJOZXBDaTJqc2FtNE50WGFKeG1hVk02WnhyR0dweXVDSFpO?=
 =?utf-8?B?NHJSanVSOUZqN2JMbllWSFR4THZyWEZHTzdDdm5UaG5MdDNwQXl1ZFpzK0pi?=
 =?utf-8?B?bERGcFd3OEdFODlyTmMzd1p5bnJTdFd0WUlwYUkrOWF5MllwY2Q5N1Z3b3Ez?=
 =?utf-8?B?aUJlcmRhU0d2YS9sOEtxOUNwblJ0WkNnVGFwT1RudmJTQmNTY25CcDNSaGVz?=
 =?utf-8?B?M0JXVGFuVXE1T0hwSTJrbUxsMG56ZjZzc3hjNER1RjllRlh6M2xsQjZXYTZK?=
 =?utf-8?B?aFYwcDdaRDVveERhb3poMWZmMzVFK1pNQU1ZWHhXVUZ1U1hKaG9yUDg0Ty9X?=
 =?utf-8?B?b0VyR1hoTDRJVWdWY1FVWkw1czZkcVdqdW9OclFGWHhxaWhPMkJCZWtSd1V0?=
 =?utf-8?B?SXQ0Tm1uenZIem5SYVA3dTh4a1Q0U1FKU2FNT0NDaU1reUhlOVg1LzlySmxM?=
 =?utf-8?B?bVR5eGxRZnpjRmovNEltVExQcUlWMHNkNjFmMUh4U1ZnKytHRzRYM2ExbGFQ?=
 =?utf-8?B?UEtLaElDV1VmS3JYUTlBSldHUis1NDM4QWVUenlQenZrUW1QMjZ1Y3piUXdn?=
 =?utf-8?B?eDNZUVFhQWJHeGRyV0Q1eTdnVENBaG1KbHVwTEZGYXJ6VzJtclN0ZndUNnZx?=
 =?utf-8?B?OUNaRFJOTy9aTXdIT3BjQSt1NmhESUdnb1pGSUFGWkdiMDl5TUNFUTh4L0JY?=
 =?utf-8?B?TkNHNEU4bkFpa2s4TjdjMkdUNUNBZzVYVnBWdzlmYkwwK3lZQWZqZjg4SDQ4?=
 =?utf-8?B?UFoxU3lFbWxyVmVCdG9aRWZVUWNhdmp2SnVzMjRJSHlNdFRyUUY1eTNaakwv?=
 =?utf-8?B?THJ4RXVaQmZDcWtZNERqQzVoSld0dHM5c0laRmd6MHQza2ZDSERwTTJPRldL?=
 =?utf-8?B?TkRJOXFZR2RXS1FEMUlPUkMrS1F0alVjblF0bEhTZUhsYW1IeWRXRmNTc2Jj?=
 =?utf-8?B?bG1BRiszYzVMSjdBUUpsU1p3c01CMEtJdjd6NXVnbUU2TnJleWt5ZzYxM2N1?=
 =?utf-8?B?MXJoZ1A0T1VKMVdJdmwxSklWdFhnaDBuS09ObjlGbW84SDRaRzFVVUdJU2la?=
 =?utf-8?B?WlkvT1BaQlNsOHNuQ3orVjZ3UzhPUjVYVW45UG85MW9GUFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHprZ29McmV1QlJqWjBCUzNiWXIvVnJrSjEwNC9mZFJpVGxJa2lORXJ2TndV?=
 =?utf-8?B?VTFaOGNtRjhneG1JVW1QQTVnUUZ2ajFvWDNoOEY5dU56UkRST2VNWmtDb3d3?=
 =?utf-8?B?Vk9LSVoxT1owb3IxaGllWjBBRThhalQ0TFZUTmdxZ1lSNmlDdE9WZUJNbnI1?=
 =?utf-8?B?OXRHTmthRVBabGlzZkhoWndzSHhWRm1HNEI5WVdrZGpoMlFHZ0tKTXdXSEV3?=
 =?utf-8?B?VkNmS21GWmQ5bjJmd3FqWGFZT2xoVm15M2Z1ekRxWitYektkcklPYWpHN3Jt?=
 =?utf-8?B?a0UvNndESHFxdGZ5R21GalI1WG85QkQ0OTUvTk1udXpKdVRuN0VpZUhkZ0NQ?=
 =?utf-8?B?VG1XSFFvcDRVbFNZTFZVb2JPV0xHSzVNb3U0dHdLQm1EQk5ibEtoLzhxZG9H?=
 =?utf-8?B?NEI0Y2NtUkFlQ3V1UGppUmxZUGJSYWgxcUZoeHBpd2FFMmhkR2hSR3VOYVZl?=
 =?utf-8?B?L1RZVm1pVWVCSGVlUithblVFK3NXQTcxSU5uSkVQYWlzZUNyWjFWKzdzTXBx?=
 =?utf-8?B?TjMxYWRBdzRlc0lDMExIWHNzWkFxSGJ0UVhpNkxESDF0QXB4VVlQQTBXRDJJ?=
 =?utf-8?B?QlVVYXZTT3dEOFNLVVQ3RjcvTGlMN05CWHVLK0VTRi96dFVzUXlQVitkd3F4?=
 =?utf-8?B?Z3pQTWN1cURGSHYvUFVjRmkzd2pwRGtveXlqVkJGVTZtbm9VMHZ3VlpRN3dq?=
 =?utf-8?B?MDNwekdYY21nTHlibWx2aDV4ME9VTXpBeFUvcUIwNUlQWUJZM2lQNEk5dzZR?=
 =?utf-8?B?NWtHSkZOU1hCSkt4WVpNK3JQaXFGY1ZOOXFmTUQ3K294SDBEdGVxdXR0ek41?=
 =?utf-8?B?NncxN3I1U1NkTmpUWTc4ZENRNmozcjFUR2NEYXlLbHVVZ2JydjJzK0xGUGVk?=
 =?utf-8?B?c1lWVmdsbDA0bXpTV3FZSjAwV1hTVldzNjlCWWkvOWtxUDZMeTRtMWRuZDlH?=
 =?utf-8?B?aVhOQnBabGJjR25PL05adC8vU1hrNVp2U1BldzhvMzZ6N28xQ1E2VVFvTFgr?=
 =?utf-8?B?TkpUUmttUjRobmN2bG5EY0JxWEU3TGUyeTh6ckhnK1FqR3VTUnlZVmRtNVQ5?=
 =?utf-8?B?ZDVEcURxYVh3SkNNVGdIem9HWmhTV3BGaGdGMEEyQ29KWUlhOWV3blR6R2Ev?=
 =?utf-8?B?a21CRWQ0cHJ3SDN5ODgydWNEQnMreTd4TWVFTkgzeERaOFRRS2JXVEU4dlIv?=
 =?utf-8?B?RTQxTWxzbFY4VC9OdVpuc0dzVWE4dFFBcUV1RmJnSjQ4RUlNUHVneExScGNZ?=
 =?utf-8?B?Snd2RHpQd2xpaHlNWjlROEZxZjJ0dk1acFdGZHJ5SFpoSU1wYlMva0tKNkJJ?=
 =?utf-8?B?aEJYWmV1T0ovZE1uc25UWmRqRlgzZnRvdGR4aDJGc3FyWFIvUVRaUXE1RGVG?=
 =?utf-8?B?L3dBZU1MeUhVRlZKSStkVitVU2wvd214UnN2MEpLQ2JrZlpnbVFROS90VHFV?=
 =?utf-8?B?dGpreHBjR0Fvc3NIYnR6VTVvTkRSVTlSYUpWa3hiMDRvMURiMVFISUN4Z3Fo?=
 =?utf-8?B?alE4ejJLMHVZSVh1R0dGUnJ6UnhxamdVdHBrZ0xQOVZmbkFSSjVpQS9QSWZr?=
 =?utf-8?B?NDQwdFpNTllLd1lXaVVkcUxNZUNEL1VJcGh3TWdyRTN5NUx5ZGR2cVAweS9s?=
 =?utf-8?B?NjFqTXZaWFZIRWp5WGh2NC92dDRyQ3dBdHJmSnczQU9mNll3NFExcXBTQzA0?=
 =?utf-8?B?TldWbkJGM3IraEZTYWFxK1BDem9qbDMvb1ErUmczMy8wcG5YUzljRFVRc3NK?=
 =?utf-8?B?N2tnSStJWDZDOXpSNXB0dzZQcDJSclZXNjNrai9KRjhNSk4yMlJkbEJ6YVNk?=
 =?utf-8?B?NFpBSE12TW5FUmtOU3g0RDlMWXdaZm9aNkNqV00vd0R2alFRS3ZKenBZV1FR?=
 =?utf-8?B?UWIzUnJlL1dQaklNUHFGWWtuRmJQNVdMM3pINnhSeWo3SUswVFZ5cWVPc0RN?=
 =?utf-8?B?VktieTl6anJ1Nys1bXJlT3BTbnFyUVAxTUlxK1EwN2FJeVdVZUxqTW9rbUtk?=
 =?utf-8?B?WTQ5di9vc2dhb2RaZGlHVlNBZkZJdmZ6b0NTZ2hrd2c0MVJJcFlwQ0xxdUd2?=
 =?utf-8?B?Ymd1L3hMamVGbkZJOUtwU2x1bm5LOG9RU2ZsUmtmcm4zRnZiZzAwQXZMLzBr?=
 =?utf-8?Q?G5FgKBLGNJMPkT2FS9t9YTYca?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3525e1f1-01b5-4ac6-914e-08dcb1d0670e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:19:41.9521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHkuldi0IqR2uH3e3pCPL+i/WEn/Qp97FXDoXGNNRFRag9JrIXHy2tXp/0oGx6X5e7UosX13KE73/0Bho7VifA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7776
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAzMSwgMjAy
NCAxMDo0MCBQTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzog
dS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNvbTsgUGVuZyBGYW4NCj4gPHBl
bmcuZmFuQG54cC5jb20+OyBmZXN0ZXZhbUBnbWFpbC5jb207IG1hcmV4QGRlbnguZGU7DQo+IGx1
a21hQGRlbnguZGU7IHNlYW5nYTJAZ21haWwuY29tOyB4eXByb24uZ2xwa0BnbXguZGUNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSHY0IDExLzE0XSBkb2M6IGNtZDogYWRkIGRvY3VtZW50YXRpb24gZm9y
IGNwdSBjb21tYW5kDQo+IA0KPiBPbiBUdWUsIDMwIEp1bCAyMDI0IGF0IDAxOjA5LCBaaGlxaWFu
ZyBIb3UgPFpoaXFpYW5nLkhvdUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEhvdSBa
aGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBBZGQgZG9jdW1lbnRhdGlv
biBmb3IgdGhlICdjcHUnIGNvbW1hbmQsIHRha2luZyBOWFAgaS5NWCA4TSBQbHVzIGFzIGENCj4g
PiBleGFtcGxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFu
Zy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBWNDoNCj4gPiAgLSBBZGRlZCBicmllZiBkZXNj
cmlwdGlvbnMgZm9yIGVhY2ggc3ViY29tbWFuZC4uDQo+ID4NCj4gPiAgZG9jL3VzYWdlL2NtZC9j
cHUucnN0IHwgMTAxDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZG9jL3VzYWdlL2NtZC9jcHUucnN0DQo+IA0KPiBSZXZpZXdlZC1ieTogU2lt
b24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IA0KPiAocGxlYXNlIGFkZCB0byBpbmRleC5y
c3Qgc28gaXQgYXBwZWFycyBjb3JyZWN0bHkpDQoNCldpbGwgYWRkIGl0IHRvIGluZGV4LnJzdC4g
VGhhbmtzIQ0KDQpCLlIsDQpaaGlxaWFuZw0K
