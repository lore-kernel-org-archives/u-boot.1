Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757FAC54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 141BE80E9A;
	Thu, 30 Jul 2026 09:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vaDn_aLlft5U; Thu, 30 Jul 2026 09:31:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2912480E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785403916;
	bh=ZsH+x+aiWqAiCaZaE4e/exfnIQuGeWev3OOYI9+CkCk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIEnTOLhBCH6mSxS+xb7LJgF8B2sytCqa8jT3J6VXV4AMZYlaq7ay5bT293TjlSS0
	 z+LTnHaICEC1IAVZbym+LR8pWF4a/QwQtxVZwl6Vb7kV73UpbwwW8/WXG2EjFi/ljy
	 ki9qi0kHDe4jj9QJq9oHeQo72SXHwQ/VmH1b6ffYzfjwViOP8FgonlzVxImubQO14f
	 E8dHfS9w3omBNS0VnZIP1UNCUPNt/d9nwx8RgZeDvxHGVUge6InHZoO9JEG00w9iRX
	 Mfj17TFy33D1+qEQyeeeZuWlvnDdVcUubJ4jUNmvkv2zQoBozyA3eea6ZoglyYq575
	 JjN/xOejD9XRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2912480E73;
	Thu, 30 Jul 2026 09:31:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A64A36E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FB60405DC
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REevyFOQqOP1 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:31:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=y.moog@phytec.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 240CC405D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 240CC405D2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 240CC405D2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:31:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269278498B; Thu, 30 Jul 2026 11:31:48 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E451C8063E
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 11:31:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLkkpdJw9ezAWCF2SO/8X0D7M3/eOVAtDMttGqToKVlGYvFKjYclZKRY3C427l7gpQb5pyrvKOF2cSUIqChJfNOxDnRqlbNCWgmgZKIN5qaIolIVP490BZEZbeZQ/0z8fKtB+/QhTr7H/WSSM1OgtBV9yEGIX/w4C5T17HbHxmZdQCv26d0QNgKXZZSoXVvpYK4nGyP/CN5V68BdsZ9Prc5CxuVH9NXXG26r+xM2NJV6tJ4k3x28VjagZjnd8eXcjFLIrqWYW12TCCkiO4Z1UDk1mT1ibPgvh9BZx10ybUWSW+YkzGPv8l2Mz5qarJIB6lJPyRUh7iBuSvJDwaXYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsH+x+aiWqAiCaZaE4e/exfnIQuGeWev3OOYI9+CkCk=;
 b=JpyoIDoRBuyBM5RJ3xHnT+5V9dK+k+lPF6P0lQqfKN8kBCLP1VtrDTcirV0T0fPMIzjUS1RdFZ2LsEuxl4d+CLA/F5hh6WFEWavEJ/DPeMeJKtrUHFyusJejVnxRcbbEGjxNiwhrbIkUVLHH2Wi+6TZfV4JQF//q+mtYF074oVaHZuoYK9JrphsojyDlFgqQs+IKcW5062NIktv+NarQQYsln/pnfnROnc255pm57/oAYPfzMPSGqpMOqFivuKqI/L7diUkTSkrwDSujl61eJWpvGHrDIJjm5Y3IYvF/RD5R+ngBDzG776W9I1SyfbYwJwAtGHo/5gnSKWqvJUMISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PRAP195MB1435.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:29f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 09:31:41 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 09:31:41 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: INgo Rah <ingo.rah@linutronix.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, Peng Fan
 <peng.fan@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Gregor
 Herburger <gregor.herburger@linutronix.de>, Benedikt Spranger
 <b.spranger@linutronix.de>
Subject: Re: [PATCH v2 1/2] board: phycore_imx8mm: update RAM timings
Thread-Topic: [PATCH v2 1/2] board: phycore_imx8mm: update RAM timings
Thread-Index: AQHdD7Alhb5dIHG8uE6I1rdS+wzgkLZv79AAgBX9RIA=
Date: Thu, 30 Jul 2026 09:31:41 +0000
Message-ID: <b0377ab823234f8db095d51a30a4f439ae97b6cb.camel@phytec.de>
References: <20260709-ram_phygate-v2-0-36f8a2f44de2@linutronix.de>
 <20260709-ram_phygate-v2-1-36f8a2f44de2@linutronix.de>
 <0dbc2fd7b850eda92b59e6a1251937ee7e81a955.camel@phytec.de>
In-Reply-To: <0dbc2fd7b850eda92b59e6a1251937ee7e81a955.camel@phytec.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PRAP195MB1435:EE_
x-ms-office365-filtering-correlation-id: 23a1ef80-41e8-4b99-4e77-08deee1d5d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: WBhMO1416nF2D+vpeiZ7kTuH2DQfU3O2aV8kg2k8ZZ97e0nVB2OpysUM5F+asvkRd9naspv8BTgEDVSaajvOiYVjkJcn7Z6Tk3k5r69LmL7WEmExsF2b+rjgGbwGUzVoo/a4Kd4Dj79NIrXUkHLZduP6U/SCfB3lCacATivaa3I08QJMndJolBrvorD3SdrS3HuNv1eG846X7M7LLgA838D1uI5beTM8nVMMo5f9pH7orzmH1V7t1yctIX0fnbDXEefsMgoAVJa0g7LKhbe9ovuMCr2CgGevzU0Cnte1w85MGj62htjBEpXIfnXpAg4OiESRZl+y7uPBlEowVopDFHzSPl8/GaBpE8em78t7oi0vehi4nSCQ6NLvj1FQKgUOxfnMGlVIEmRUc9Md/g5BcwaefhBGiKEmDU0hG8sIzh5487M4HdrBrkJr/J5njWaE0+Tm63Ma2/zbaC3XRlbq+B9pi1aYV+GYsiIBurZqGpjiNUJEj9SeJj7rqrj8dC/pDbu8wnrMfaJOxe/TYN7Tkncne+brMcUXPzWjpAZehyBsb2O9KdNSsg5fQHdl8WSgoDoBFKa6tLLHH9hoZZjjLa6+U+J3MR54mSsQr2AHTmiT7Z/lg+HGXl9r4LbacE1D2c51ySNDc8t4ia47/KQKfeUUC4wPugcnSe9a0WHuJpfnxNQmQIQNUQ1SCIONaONtSLf2ABRXIYkxnFm9EvOWcT7SescS0Jw0sEUVxe5e8A4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGhFdVh4T1FoMUFWd1NkM1hoR25jU1pOM3ZXdDVnMHVpWHgzbG8zclZhMXZH?=
 =?utf-8?B?VjRiNWdTeDNJYUlDZTJRTis4MFlqdU81VW9uV3E3ZGFOVGc1M1p6eFhtR29W?=
 =?utf-8?B?ZCtFRXNWeVQ3d2pXVHJFQ3V5R2JEVW9uWkdkdDU1a21RNUw4dlZjM1RQd1Za?=
 =?utf-8?B?bUh2WUt0ZHFjdDBxTXd1V3BVd2llQ1VYN3dnSG5pK0UveUMvUWJMMUc0NzFt?=
 =?utf-8?B?WDJnQmVnQlpVQ1dXZFhJcGs3bTZlWFNIN2o1WW1HYlRoTERlTlVLVGRWKzNS?=
 =?utf-8?B?ekVCS3J3Nms5VzE0QThXclBoM0Q2T1pHTFlvYUlHUnIxeVdjTzhQRVE3bVEx?=
 =?utf-8?B?SVFkQWN1b0RxRUJ0cEJzSnB5UVVDUHR6dkQ1V0RYNlRFQm5TcmFCRk84enM2?=
 =?utf-8?B?NHZFOFdqVXZVcExjdjE0ZUUxNVMvVVRWK2dibEFSRm9sYVpJdWNVN0Jmdncz?=
 =?utf-8?B?bHZZS0tuelNaa25RZ3JvTTk5S0pxOWVldVhZSTV6aS9wZlErQS9IeHBpN3lE?=
 =?utf-8?B?eDF4NmF4UlRuNjA5VDhTOTg5OTFQd1VMNW92dFVmZE1VeHhKUlJ0eE1IQ0pU?=
 =?utf-8?B?Z2g3aGxWVHRrK29jZjF3Y3psRytvVCtENEhvclAxM1VPM2FJRnAzdkFheVFq?=
 =?utf-8?B?NG1ydTlVZytoeGpqcHBUM1VEVHowNEV4RlpHcHZYMDhWa2hpT0phWlA3Mmgy?=
 =?utf-8?B?QjNxeHVqY3Y5bXh2ekZZVENhTlEybGFXMnIwZ21ESGVJakxRQmtXUVRBbnVv?=
 =?utf-8?B?L2NpcExWeFlCMmZ2YnZNMkE3Q1lEYWpwVVJJRjZoL01sNzRHdEZaa2pNQjV3?=
 =?utf-8?B?RWUzSnZoMVluTEdZUDFjWHR6TlpPZEpOcUF3Y2FUTFp2cUMvNlR0bXRMZS9i?=
 =?utf-8?B?MzZzdWdCWlBZQ29yeVhvdG5aZjdsT0FYMTk3bWJDZ2YvVFZUbjNrR0x6bGR5?=
 =?utf-8?B?TXJTaWRoSDFHa1VGbmYvSTF2Z01jalNTVU1WYVlLMjJPQXZMVXQzRjNEMkt2?=
 =?utf-8?B?VDZPNkIyWVV4bEV4eGNZLzlkdTc5VDlpcEIza01ycUxMRnNuWG9ZTDlGTWxr?=
 =?utf-8?B?d1FGZExjT2tVSW5hQXp0WEJ3cUtYUm14ZDlONlQ4WDluQ2JleFNIREFKa0hH?=
 =?utf-8?B?OTRhODBzMWdqdVA4RDlheXhGMVp3Qk9EbVAxa1NEeU1aNWtMQWNBSWo5UmRD?=
 =?utf-8?B?MzI3VExWaUVRM0JVZUR4NXIxdmx4U0RWdVNmbnBGbkF4VVIzYVF4YURxOTFP?=
 =?utf-8?B?R1NQWXpOWTluREVwWmJxWW80QlhRME5IcXdudEVIanp2Y0VOcDd4dUlTamF2?=
 =?utf-8?B?STZXSUx1ZlY4U1NDMlVLcGluT2h1a3NKK1NBUVdOdGo4Sk9NTmZ2SWpQQ21x?=
 =?utf-8?B?TWp6bXFDb29vSlhEWFZUbW00UWZYeEZHaWhuYkc3am9XanZKU21qeHVLVDRk?=
 =?utf-8?B?Z2VJdnFwU1BidHZCYVBhSGVnakVTVm1Ta20xU2tIVDRyR21KR1FzRmoxNEFH?=
 =?utf-8?B?bURSQTNDdkF2cjl0WGprOVcxM3R2UnA1M1ViTHlBWVVFbnViZFNYeHpQVlND?=
 =?utf-8?B?LzNGbVR3czQvZEFpQjZUNzlIc3RKUGZhR1lWMnlvTFlGWFhjWjhjRVozck03?=
 =?utf-8?B?eXNPV25xZ2luTlRkOHlBTk82N3YyS2h3VUdLUjQ1d0hFMFBtYVBHekxQaFdq?=
 =?utf-8?B?aVdsSzZjZThoV0grSktoa200Y3lBMmM5Zlp4WStsMVJ6RXQwYVpjaS9yRUhN?=
 =?utf-8?B?YUVzTE8va0xwd3pVZWx5RzYvWUZoRTkxTUVaaVZMYWNrS0RWTEI2d1NFY1k0?=
 =?utf-8?B?MG1laEYvUTg5K0JZYmFzNU5RN24zaDlEMVFWOHloSDJjR0VhTEZ3S20vc0p5?=
 =?utf-8?B?RHhNNWZmWk5KSndnaUJaLy95VTNpbXdmT1FCQkh5THFrdmJHUGJndEwzdXVO?=
 =?utf-8?B?enJMbEp4ZnBaMFoycTR1LzNzSlNRK29UMVAzYXhFMzBON0ZGL0F1bDRjNytF?=
 =?utf-8?B?bjVKYnkwalh5blB0WWN6WjV6V2xOMThhTzNLOFgrQUdtd2tuWGxnY1NnN0Vu?=
 =?utf-8?B?R0NGcHlEUnFlMExxVUd4UnNRelFPdVFjK0lVbGJXc0RSM09vSjVlN3V3QkRs?=
 =?utf-8?B?cUpEZXFWazZJdGdML3A4cGlCd0RNVTN5b3U5YkpNMjFQdWdqbkxxdG1VVVVJ?=
 =?utf-8?B?cmd2TDRTU3dmS1lvdHNRRUFTRjRTRm9SZkdQaUsvYXNGaWJNaEw0OGkyelVS?=
 =?utf-8?B?V3pNandRN1kzRHV3Y0ZDTEhGaG9jT2piK3R4SWJHQmRqQU0vQS92bG9IRmZu?=
 =?utf-8?Q?yqAk3pHLQ1q6WgbCK8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD324E53B43D934FBCFC472DE6B49DA9@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a1ef80-41e8-4b99-4e77-08deee1d5d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 09:31:41.5580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MgZbDeBV2JRhaZqe43Tj64JWyTcS+G2uEnkxAGUxifCnPkID50aFSgmmNQF25f+fdrfLnqTbI27RoMbMiDXBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1435
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsH+x+aiWqAiCaZaE4e/exfnIQuGeWev3OOYI9+CkCk=;
 b=V9LaIyhJIr8Qq8wGk9CND8h1fyKwkNFcuoKiPjkAYUB5F7099RGetTggHMLNNIv5CN5u4LcAbCbhK3EpYib2LLBiXCjOJ7TPx76CHJ5jVgiuXCp3gWHqk/Dw3lyAqT6kz8ys0ifhmul98qSLXMBL2PZd+J0RLxNUq+KQ7Hu2ddCzakG1razyAWnJmjtnT6Of/Vofmn8ZBYutpMaefYLIoBwzJ7ua0yFI9JGB0DGlnq1b8iaUic8/Nix83E4FocPxBVCZ0/ZBtirvCXDwcd4fDTWEjveeM0NyW3pfAMDoK5uBI9udc4EHMh1RcVP+ftmmGgk2uPQMhVlMqhigtX1CkQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=phytec.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=V9LaIyhJ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Y.Moog@phytec.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=phytec.de header.i=@phytec.de header.b="V9LaIyhJ"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

T24gVGh1LCAyMDI2LTA3LTE2IGF0IDExOjQzICswMjAwLCBZYW5uaWMgTW9vZyB3cm90ZToKPiBI
aSBJTmdvLAo+IAo+IE9uIFRodSwgMjAyNi0wNy0wOSBhdCAxNjozNCArMDIwMCwgSU5nbyBSYWgg
d3JvdGU6Cj4gPiBVcGRhdGVkIFJBTSB0aW1pbmdzIHdpdGggbmV3IGdlbmVyYXRlZCBzZXR0aW5n
cyB1c2luZwo+ID4gRERSIFRvb2wgdjMuNi4wXzIyLWFhMDE4NTQzLgo+ID4gUHJvdmlkZSBmdW5j
dGlvbnMgZm9yIDFHQiwgNEdCIGFuZCByZXZpc2lvbiA3IHZhcmlhbnRzLgo+ID4gCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBJTmdvIFJhaCA8aW5nby5yYWhAbGludXRyb25peC5kZT4KPiA+IFJldmlld2Vk
LWJ5OiBHcmVnb3IgSGVyYnVyZ2VyIDxncmVnb3IuaGVyYnVyZ2VyQGxpbnV0cm9uaXguZGU+Cj4g
PiBSZXZpZXdlZC1ieTogQmVuZWRpa3QgU3ByYW5nZXIgPGIuc3ByYW5nZXJAbGludXRyb25peC5k
ZT4KPiA+IC0tLQo+ID4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vbHBkZHI0X3RpbWlu
Zy5jIHwgMTg2NyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0KPiA+IMKgYm9hcmQvcGh5dGVj
L3BoeWNvcmVfaW14OG1tL2xwZGRyNF90aW1pbmcuaCB8wqDCoCAxMyArCj4gPiDCoDIgZmlsZXMg
Y2hhbmdlZCwgOTIxIGluc2VydGlvbnMoKyksIDk1OSBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlm
ZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9scGRkcjRfdGltaW5nLmMKPiA+
IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL2xwZGRyNF90aW1pbmcuYwo+ID4gaW5kZXgg
ZjVhMmYzMjY4YjMuLjE2MmIwMjA5ZDkyIDEwMDY0NAo+ID4gLS0tIGEvYm9hcmQvcGh5dGVjL3Bo
eWNvcmVfaW14OG1tL2xwZGRyNF90aW1pbmcuYwo+ID4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNv
cmVfaW14OG1tL2xwZGRyNF90aW1pbmcuYwo+ID4gQEAgLTEsMTYgKzEsMTcgQEAKPiA+IMKgLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiA+IMKgLyoKPiA+IC0g
KiBDb3B5cmlnaHQgMjAxOSBOWFAKPiA+IC0gKiBDb3B5cmlnaHQgKEMpIDIwMjMgUEhZVEVDIE1l
c3N0ZWNobmlrIEdtYkgKPiA+ICsgKiBDb3B5cmlnaHQgMjAyNSBOWFAKPiA+ICsgKiBDb3B5cmln
aHQgMjAyNSBQSFlURUMgTWVzc3RlY2huaWsgR21iSAo+ID4gwqAgKgo+ID4gLSAqIEdlbmVyYXRl
ZCBjb2RlIGZyb20gTVg4TV9ERFJfdG9vbAo+ID4gKyAqIENvZGUgcGFydGlhbGx5IGdlbmVyYXRl
ZCB3aXRoIEREUiBUb29sIHYzLjYuMF8yMi1hYTAxODU0My4KPiA+ICsgKiBERFIgUEhZIEZXMjAx
Ny4wOQo+ID4gwqAgKi8KPiA+IMKgCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiA+
IMKgI2luY2x1ZGUgPGFzbS9hcmNoL2Rkci5oPgo+ID4gwqAKPiA+IAo+IAo+IFsuLi5dCj4gCj4g
PiArCj4gPiArdm9pZCBzZXRfZHJhbV90aW1pbmdzXzFnYih2b2lkKQo+ID4gK3sKPiA+ICsJZHJh
bV90aW1pbmcuZGRyY19jZmdbNV0udmFsID0gMHgyZDAwODc7Cj4gPiArCWRyYW1fdGltaW5nLmRk
cmNfY2ZnWzIxXS52YWwgPSAweDhkOwo+ID4gKwlkcmFtX3RpbWluZy5kZHJjX2NmZ1s0Ml0udmFs
ID0gMHhmMDcwNzA3Owo+ID4gK30KPiA+ICsKPiA+ICt2b2lkIHNldF9kcmFtX3RpbWluZ3NfNGdi
KHZvaWQpCj4gPiArewo+ID4gKwlkcmFtX3RpbWluZy5kZHJjX2NmZ1syXS52YWwgPSAweGEzMDgw
MDIwOwo+ID4gKwlkcmFtX3RpbWluZy5kZHJjX2NmZ1szN10udmFsID0gMHgxNzsKPiA+ICsJZHJh
bV90aW1pbmcuZnNwX21zZ1swXS5mc3BfY2ZnWzhdLnZhbCA9IDB4MzEwOwo+ID4gKwlkcmFtX3Rp
bWluZy5mc3BfbXNnWzBdLmZzcF9jZmdbMjBdLnZhbCA9IDB4MzsKPiA+ICsJZHJhbV90aW1pbmcu
ZnNwX21zZ1sxXS5mc3BfY2ZnWzExXS52YWwgPSAweDMxMDsKPiA+ICsJZHJhbV90aW1pbmcuZnNw
X21zZ1sxXS5mc3BfY2ZnWzIzXS52YWwgPSAweDM7Cj4gPiArfQo+IAo+IEkgdGhpbmsgdGhlcmUg
aXMgYW4gZXJyb3IgaW4gdGhlIDRnYiB0aW1pbmdzLiBBdCBsZWFzdCB3aGVuIEkgdXNlIHRoZSB0
aW1pbmcgdmFsdWVzIHlvdQo+IHJlZmVyZW5jZWQKPiBpbiB5b3VyIGNvdmVyIGxldHRlciAoY29t
bWl0IDAwYWM3NjVkNjAzMiksIDRHQiBSQU0gdmFyaWFudCBkb2VzIGJvb3QgY29ycmVjdGx5LiBX
aXRoIHRoZXNlCj4gdGltaW5nCj4gdmFsdWVzLCBpdCBkb2VzIG5vdC4KCkkgaGF2ZSB0byB0YWtl
IGJhY2sgbXkgc3RhdGVtZW50LiBUaGUgdGltaW5ncyBkbyB3b3JrLCBJIGhhZCBtYWRlIGVycm9y
cyBkdXJpbmcgbXkgdGVzdGluZyBlZmZvcnRzLgpBZnRlciBjbGVhbiB0ZXN0IHNldHVwLCA0R2lC
IGRvZXMgYm9vdCBub3JtYWxseS4KClNvIEkgY2FuIGdpdmUgeW91CgpUZXN0ZWQtYnk6IFlhbm5p
YyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgoKPiAKPiBBbHNvLCBmb3IgZWFzaWVyIHRyb3VibGVz
aG9vdGluZyAoaS5lLiBiaXNlY3QpLCBJIHN1Z2dlc3QgdG8gZmlyc3QgYWRkIDFHQiBhbmQgNEdC
IHN1cHBvcnQgYW5kCj4gYWZ0ZXIgdGhhdCBjcmVhdGUgYW5vdGhlciBjb21taXQgdGhhdCB1cGRh
dGVzIHRoZSB0aW1pbmdzLgo+IAo+IFlhbm5pYwo+IAo+ID4gKwo+ID4gK3ZvaWQgc2V0X2RyYW1f
dGltaW5nc19yZXY3KHZvaWQpCj4gPiArewo+ID4gKwlkcmFtX3RpbWluZy5kZHJjX2NmZ1sxMF0u
dmFsID0gMHg1NTAwNGQ7Cj4gPiArCWRyYW1fdGltaW5nLmRkcnBoeV9jZmdbNjRdLnZhbCA9IDB4
NjE4Owo+ID4gKwlkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzY1XS52YWwgPSAweDYxODsKPiA+ICsJ
ZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s2Nl0udmFsID0gMHg2MTg7Cj4gPiArCWRyYW1fdGltaW5n
LmRkcnBoeV9jZmdbNjddLnZhbCA9IDB4NjE4Owo+ID4gKwlkcmFtX3RpbWluZy5kZHJwaHlfY2Zn
WzY4XS52YWwgPSAweDYxODsKPiA+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s2OV0udmFsID0g
MHg2MTg7Cj4gPiArCWRyYW1fdGltaW5nLmRkcnBoeV9jZmdbNzBdLnZhbCA9IDB4NjE4Owo+ID4g
KwlkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzcxXS52YWwgPSAweDYxODsKPiA+ICsJZHJhbV90aW1p
bmcuZGRycGh5X2NmZ1s3Ml0udmFsID0gMHg2MzsKPiA+ICsJZHJhbV90aW1pbmcuZGRycGh5X2Nm
Z1s3M10udmFsID0gMHg2MzsKPiA+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s3NF0udmFsID0g
MHg2MzsKPiA+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s3NV0udmFsID0gMHg2MzsKPiA+ICsJ
ZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s3Nl0udmFsID0gMHg2MzsKPiA+ICsJZHJhbV90aW1pbmcu
ZGRycGh5X2NmZ1s3N10udmFsID0gMHg2MzsKPiA+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s3
OF0udmFsID0gMHg2MzsKPiA+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s3OV0udmFsID0gMHg2
MzsKPiA+ICsJZHJhbV90aW1pbmcuZGRycGh5X2NmZ1s4MF0udmFsID0gMHg2MzsKPiA+ICsJZHJh
bV90aW1pbmcuZGRycGh5X2NmZ1s4MV0udmFsID0gMHg2MzsKPiA+ICsJZHJhbV90aW1pbmcuZnNw
X21zZ1swXS5mc3BfY2ZnWzNdLnZhbCA9IDB4M2MzMDsKPiA+ICsJZHJhbV90aW1pbmcuZnNwX21z
Z1swXS5mc3BfY2ZnWzExXS52YWwgPSAweDRkNTU7Cj4gPiArCWRyYW1fdGltaW5nLmZzcF9tc2db
MF0uZnNwX2NmZ1sxNl0udmFsID0gMHg0ZDU1Owo+ID4gKwlkcmFtX3RpbWluZy5mc3BfbXNnWzBd
LmZzcF9jZmdbMjNdLnZhbCA9IDB4NTUwMDsKPiA+ICsJZHJhbV90aW1pbmcuZnNwX21zZ1swXS5m
c3BfY2ZnWzI5XS52YWwgPSAweDU1MDA7Cj4gPiArCWRyYW1fdGltaW5nLmZzcF9tc2dbMV0uZnNw
X2NmZ1szXS52YWwgPSAweDNjMzA7Cj4gPiArCWRyYW1fdGltaW5nLmZzcF9tc2dbMV0uZnNwX2Nm
Z1sxNF0udmFsID0gMHg0ZDU1Owo+ID4gKwlkcmFtX3RpbWluZy5mc3BfbXNnWzFdLmZzcF9jZmdb
MTldLnZhbCA9IDB4NGQ1NTsKPiA+ICsJZHJhbV90aW1pbmcuZnNwX21zZ1sxXS5mc3BfY2ZnWzI2
XS52YWwgPSAweDU1MDA7Cj4gPiArCWRyYW1fdGltaW5nLmZzcF9tc2dbMV0uZnNwX2NmZ1szMl0u
dmFsID0gMHg1NTAwOwo+ID4gK30KPiA+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29y
ZV9pbXg4bW0vbHBkZHI0X3RpbWluZy5oCj4gPiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDht
bS9scGRkcjRfdGltaW5nLmgKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAw
MDAwMDAwMC4uMzQwZmVmZTAxYzMKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL2JvYXJkL3Bo
eXRlYy9waHljb3JlX2lteDhtbS9scGRkcjRfdGltaW5nLmgKPiA+IEBAIC0wLDAgKzEsMTMgQEAK
PiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLwo+ID4g
Ky8qCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI1IFBIWVRFQyBNZXNzdGVjaG5payBHbWJICj4g
PiArICovCj4gPiArCj4gPiArI2lmbmRlZiBfX0xQRERSNF9USU1JTkdfSF9fCj4gPiArI2RlZmlu
ZSBfX0xQRERSNF9USU1JTkdfSF9fCj4gPiArCj4gPiArdm9pZCBzZXRfZHJhbV90aW1pbmdzXzFn
Yih2b2lkKTsKPiA+ICt2b2lkIHNldF9kcmFtX3RpbWluZ3NfNGdiKHZvaWQpOwo+ID4gK3ZvaWQg
c2V0X2RyYW1fdGltaW5nc19yZXY3KHZvaWQpOwo+ID4gKwo+ID4gKyNlbmRpZiAvKiBfX0xQRERS
NF9USU1JTkdfSF9fICovCg==
