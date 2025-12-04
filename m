Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E8D1F9C5
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 11:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD7C83F9A;
	Thu,  4 Dec 2025 12:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mJud4Svr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7E983FDC; Thu,  4 Dec 2025 12:50:31 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9520C83A84
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 12:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbjR2yqp9HP2WtefQfjYk2ppjnHcYIqjwACcInxUx1b3f3H/qmOGJiVOn1wh9YZmd/S9xWXZ98rXmLHcD/njkDyTM6Rjx+Gme52pb85vBVU76986+3tDZB98kL/FHnT1xZRv2Oev2bykPdeG7GHde5Ae5ko4iMj7bBKym/GrU6V0EUVQn4XWW+YmkuvErYFATZveYIVT/+tG8ccP3v5N3mvKBmA0zJ3X2P2O+Yk1rrHxxeiHFELghlAOLCv7G5G9AJWS/YRkggIffAzdMdiIqT6O6YMhmP1nqtq+n11IO5WcDaaffqukPB516DqWe/6b60FVSlX8QMprCgiEByXkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCTbrUQ5Mj1WhuMNU6Vq+HL+EEi7TAfz2vmhCIRD32g=;
 b=RyxazsHBWzN61vGr7BVrYTWUAqRAaPyxF6Q7b2/ps6ERI1Ezsg4u+zJmtKHSGpKV+DqvxQhWNVQvkSET3k+lBddwcERhD+miL0pcbo9MARxvJVq1YnBfd1DNivCMceNuUO1L523E/TvOgKPusFtsplevHdjF/YwNHuom98k/IFt9k3v7FtBI038Bu1uLvdcI+rmsTuaO+Yq3OARJCkm8lQGEjZkJmc/UyjCFzje0YOsWZRG1wcqaU6xpPpWt9jbvGEHhRO25CaxwT+xHyqDCHD1JtfQCQNGMItHA8JUc5glixbRjpkhVbxkx6xT6RC7cFA1V4ZrgLhL0Yge6yYuSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCTbrUQ5Mj1WhuMNU6Vq+HL+EEi7TAfz2vmhCIRD32g=;
 b=mJud4Svrw8if27HUvLm+g2BacR7SFbaXmbyZKsirPNNoS7izafxc9nhrbBjYmsSW7UYQ6jcYL/8mCUfEki2MiA6tyfnfMqwlumqhzpKfSi9y++jYE/s3RnxEklHFaxfslte2nDChDe8NDZ6n/RTAH/Yzi/pjSgSqU7xZ4DF344w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS5PR04MB9896.eurprd04.prod.outlook.com (2603:10a6:20b:67d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 11:50:20 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 11:50:20 +0000
Message-ID: <fea1b8fb-2512-41f9-af23-a716c70cce39@cherry.de>
Date: Thu, 4 Dec 2025 12:50:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
 <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS5PR04MB9896:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc010c7-7cd3-4c39-1d1b-08de332b4d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS8vVmsxVS9rQ0dFRHJWNUpWeEtzNE1rZ240MEFiNzhVdVVCTDFZYVVuNklZ?=
 =?utf-8?B?NCtRZFVKZlFBWTZMcDVjSnRCeHlNdm1IK3RyQ0dLcGlrbnI2NHlCZVVMd2Uv?=
 =?utf-8?B?MVpld0I3QUgxV005c0U4aEU0TDgrWlNaOGt4U0c1ODZ6dXZFaVc0SVpCMzNF?=
 =?utf-8?B?N1lnVmhBb3ZQeHp2UFVIaU5teVlOTlBlMExqMnZtcndYTk50UXZmQzNJQ3hq?=
 =?utf-8?B?Ynd5MUIzOWFyNWtMN0tLd1UwYnU4NThEYTZNdjFhajdFdUdyN0VKYUFTME5u?=
 =?utf-8?B?SXJLNE1tRjZHSCt0R0tCUVl5bjJ1VVlwRHAwa0I3cnUwaWVzVnhDOTlrS3Yz?=
 =?utf-8?B?OU53TnpManVPcUpXbXlNaDYvWGwwU2tsYU8vNjBEZ1dNS00waWJQVXk1a3Rm?=
 =?utf-8?B?Z3NINnlvZUV3RFZ4U0Z2dkVnSDhGdkw0NW9nZXJORFd0NHBRNk1LT3BwMUEr?=
 =?utf-8?B?eXE1d3A2OEFTUkJYZFRUQnN4MlpsQUtXUnZyNTJqNnhIZTF6T05xWFlSc0Ix?=
 =?utf-8?B?REJqdEJxckN6aC9pWE1DSW91T0NmblRPRG1DdGZRWk1hekI1OGgrL3hsMlBh?=
 =?utf-8?B?Z1Y3VHBkYlJ5NFFZRkU0WlpLZ1dVb1lRNnRoZjlXRnpPLzdFdHY0WXlTQ3VJ?=
 =?utf-8?B?b01WakgzM2RRSFEwQmNBTnZ5VG5FcXIvTWRFS3EzWmVHYWZ3MFY2ek1SSXBh?=
 =?utf-8?B?eStBSUNXUFJqdFZGWUd5c1Q5aC81aUpyQk81bVk1d3VMWHdXSEZXS2NwNzB5?=
 =?utf-8?B?OGFvT2J6dDNJYjZqWHY2UTVDeThXVjhtcGtONEN3cVlzNHVrSGpvalllc3BZ?=
 =?utf-8?B?b2hNbHg1bUw0dmcvajlWb3BNdS9PTm1LaHJwNGpmZWFRSDFjUi9nci9qRWRU?=
 =?utf-8?B?cTF6TG9XYmd2ektOMVE2anV2RFRabm9FTzBFWEx2NEMxYk9EY1plS210b2Nu?=
 =?utf-8?B?WXp1M3lZZzdLYS9LRit1TnNhTmlwa3JqckRmZ3BOZmhBazFZaEpYSVNPNkZZ?=
 =?utf-8?B?ZTJiR2d1NlVjY0dlT0o4bkRDUnd0QUdxR0tPSWhmVlFEN1gxL0FPQlVCNnVo?=
 =?utf-8?B?KzRLaUlZQzhTc2ZGaFRnZU1GV1pVZ3FLNUZ3dUN3S0krQkdrcjJ1U3hTTFEy?=
 =?utf-8?B?dytMTkdVRmN5c3hZQXpzSHk0WVh5cnRnQVRzRmxTZGVmckpUWFJQN3BnYjk5?=
 =?utf-8?B?akx1RnRsd3JPTGZUSFJlTzlCL1Y4K00wajlXbHN6dzZic1VocktVUnRWR2o1?=
 =?utf-8?B?RXZkMy8xOXFBd1FkTm01YTVjRzQwNXF0Vnl1dTJ1UGlLb0xrZUxvWDNPK1BX?=
 =?utf-8?B?NFNEVkZta0VuaytzQVZIVktpZzVxUDFaM0FOdk9mbllreTAzOWIzOFdJMHUx?=
 =?utf-8?B?S3B2R1ByTVRjM3plTHhqSHhSUFlsRXdOMzFWcUVvMURyVFNNc0NyMmZ3ejFn?=
 =?utf-8?B?UDhIK09Zc0xHR2h6OTFVdCtLWkdkTWZyekpXVG9kZ1l2OGYyRmJNMHMxRm9o?=
 =?utf-8?B?aG9FZ3FqdE1maEhvcWF3QTNOcUVSYi9vU3N3TlQvY21xRlRSa2VRd2NhSC9W?=
 =?utf-8?B?TWFvWDh1T1ZxTFBMVTB6NVlybjg0N3Rna3lGaXRtV3NkMU5UaHdhejdoVW9p?=
 =?utf-8?B?Z1owZy9YVTFGRTNJeEgvRXE2YUxHMCsrNU9Kd3B6WkFNRFVGUU8xa0tBZFZE?=
 =?utf-8?B?MG5Ub3pWdStRZDhreXZTaWRCZ2dlQm5jbTBzSXRVL1hLWHBzbUVvUHdmTEN2?=
 =?utf-8?B?a0M1VTBnM0xua1ROYkpRYWVvQ0pPVWZwOU41RkVHOW5mSFFZOG5WV0lNS3Vu?=
 =?utf-8?B?dHRYR1E4Zm5mTHNaRlp3OXJ4TmxXdG9JMVJGOHZYUmRnV09lcUpHZ3BxZ1VD?=
 =?utf-8?B?VjZYYWxQTmZGUzM5OFdTcFEwYjYrbEhkWURqWS8yVDR0RlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2RrWE90MVNhZUVIZ1VBYUJxVzlROWdBUlBxUVhuc1h3Q2xPdENma1lOSFd0?=
 =?utf-8?B?ZVJCWUtFQmhwdmY4RDN4VTZVN0pGdzlJd0wxRTFRVjRicENHNFk5ZDJXZkwx?=
 =?utf-8?B?dTZuZnJEYmRCUVpVdFJtSktXblZwYU5CMDJzUEJMWGZ1dk9wZzU5VmlZRVRz?=
 =?utf-8?B?Um13KzdyN3FIS2hmREFQZmlSWE9JMDhXeEh3N2NFSWROMEpRcmE5dzhxdnF6?=
 =?utf-8?B?Rm5jTlY0d2ltU2dhSzlxTU5DWnh1MEg4OFNRbC9JSmJZeElUQTlaanBWWWlu?=
 =?utf-8?B?SjNGZnRzYmUvTWEwRzl2aTdaMlVSWVloREc4VFJaTWxqL3J3V25jWVJOOTRY?=
 =?utf-8?B?N1Y0SmFUSzU5azZJUzkyVWl0MWtUMDE3YUxWZFU1QkwvaFVuL3UweklNUm92?=
 =?utf-8?B?R1ZLd2hjUjgzVW5mRDkzTWFQTkU5SncrdTRyY3QwSEhVL3RnWlZxRXRITjdz?=
 =?utf-8?B?Y0dGcFVTQU41SjN1Y3pzNGtLN1NRUXltbUZBTGNRSHJkSStFM2gxU1ZhTDVF?=
 =?utf-8?B?cGV5SW5XVmpoY1VWM3hrelYraG1WY3AranNZK245N1h4Mm93NmVwTEc4MEZ1?=
 =?utf-8?B?dnVaVmJLVnBWK1NCYlNDUkxvNTJVY3kxUmZsTlNQRXBLN2ZUNE5RUGRXNFpo?=
 =?utf-8?B?bFhvMmNlVU15MmhNc3h0bWwvTlNDcWlKL1l5WkFaUTI4S1hJYVZBT1A2TGlJ?=
 =?utf-8?B?Y0JhOFNnNW5DblN2eEdXYjlMNWpYTFZHMGFlRTNhT0JyRXZOb1cwV3ZlSkNa?=
 =?utf-8?B?RDE4b0dxalhwZFhkaFVhMHQ2QWI4bU9LbnFVeEh3WFRYeEZqSm0vZWo0UFZj?=
 =?utf-8?B?UDEwS2o5Wm4zR05IRUkwbXFwaHNxZkpaWk1ONld5ZmtaR0RrU0FCdEthV1Jt?=
 =?utf-8?B?TVpzSVgwZjZ4WDZ2bzQvOU1JdjNuUnZyT2xjQnFmbmRCNnVJV28xZ2cvUk9p?=
 =?utf-8?B?cHBvam1sM01FOHQ1VHFpcDByV3FJdndXUE1MOHp6L21LeDgyamdsT0xnWXBC?=
 =?utf-8?B?NWdVNnVmUFBkNlZTUHpIblNkbExSQlVxRFN0SGovVENjMXhIVWZJdU1mcHkx?=
 =?utf-8?B?TktnNkpyZlRpNTZzQXozSGhndG83UmU3aEREeStpaStQR21FNTZTZFlnOGE4?=
 =?utf-8?B?R2dpRDVpZmpSTVFYdHl3eUxQRit0VjFpSlppZFJ1WUtYdUs5dEphOVBjWG9L?=
 =?utf-8?B?Q3N0VkJPbCt5MjU2NVBrVXNGVUUzUEk1N0kvWDlMaDFpdXhQNkFKT21jOUk5?=
 =?utf-8?B?ZkNYY2YzVnlzWjVKZGtBRXB6eEtjUE03dGgrMGlVTmdVcmkvdEJENm9LYW1L?=
 =?utf-8?B?VFVPZENUcmZDQzduREdsQlNjYzRHcVhWMTIvbHRwU0xHZm1MR0F6OTByQTYz?=
 =?utf-8?B?K1JiendwTUpWWXh3cmJMbU9LZnFXY3Uyd1hEanZIbFVyL2h3NnBEMkdHdU0v?=
 =?utf-8?B?YVNVYzlBcUw2UnVTTm1lc29UYkNhZmE3Y01JYnZRN1dyVkNZN3FMUXY0ZnBT?=
 =?utf-8?B?REd1NzczZ0JZM0MyUG5obDNCRmV6Zy8zRFkyR3g3REtPYnBIbnpJeUVyNkp5?=
 =?utf-8?B?R3QvK3ZCL3NnUXJLMzFOd252TkQzQ3BnVlFtejlTa0VsSHFwdFM5eVFZVUNp?=
 =?utf-8?B?KzlFTzh5U0ExRk0zbnVyU1d4UGs4NjQ3ZGpyTW56ckZtVlZXZ3lxZHhmamxo?=
 =?utf-8?B?a1F3dExpMy9pOGVvbW1PcmtGWU9iQ1RneXVqWFk5UU82eDIvMVNzS2I5bFI3?=
 =?utf-8?B?ZkFhVHFBLzVWQ0tMMi8rdVpoc2ZNMXhFMlRxNkJXTTV1RUZ5RWhWeFFOejl0?=
 =?utf-8?B?UEJZZHVVTzcvTTZnZEJxWmErNjA0MWEwTUFodks4ZTBNZzdrK1ZLNEc5a0FD?=
 =?utf-8?B?cHlHQ1VibXlVeDRvc0dxVnNrTmVQWXN4M3Y3MWxtQm9VVXYvN01HeGJFcTFi?=
 =?utf-8?B?TjVRRWtXazFvcm9BUXZLbVBrSTNNYlVoS2VPQnFrMis5UzNtOWJzb09PakFy?=
 =?utf-8?B?WFdqVnFkb0pDaWNUOTZFcjNLalZaSGdUUjUwZUxyVEZyVkVvU0YzWnpCbXhM?=
 =?utf-8?B?SVUzZU96Y08rT0dKOXJWVHN2bG5MYSs3c1pqMFIvd3Uza3VGSTB5ZGRVWVRE?=
 =?utf-8?B?YWpCa01vMGJjVVhsb1JkVkFzLzhMNk9nT2JNNnVMU3dRY1A2dEo0SWhKTElt?=
 =?utf-8?Q?cqmNQbZy3bMDG1C54XRCT8k=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc010c7-7cd3-4c39-1d1b-08de332b4d1d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 11:50:20.4255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFvuHbDpKcFpMb5aYE7QoRTi1JYlO9kmCBbzEKeFjnbiMi42wveoRY3JcZ8a948pxdqtp6vB9Gs87lGhEm0OwbwGkLDP8iswLap+wQHK/Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9896
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

Hi Simon

On 12/2/25 9:06 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 11/25/25 11:15 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> This adds a test that signs a FIT and verifies the signature with
>>>> fit_check_sign.
>>>>
>>>> OpenSSL engines are typically for signing with external HW so it's not
>>>> that straight-forward to simulate.
>>>>
>>>> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
>>>> 4096 private key is made available. It can be selected by setting the
>>>> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
>>>> the engine is detected by OpenSSL, which works by setting the
>>>> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
>>>> is properly implementing what is expected from an RSA engine, but it
>>>> seems to be enough for testing.
>>>>
>>>> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
>>>> without specific hardware. The keypairs and tokens are generated on the
>>>> fly. The "prod" token is generated with a different PIN (1234 instead of
>>>> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
>>>>
>>>> Binman will not mess with the local SoftHSMv2 setup as it will only use
>>>> tokens from a per-test temporary directory enforced via the temporary
>>>> configuration file set via SOFTHSM2_CONF env variable in the tests. The
>>>> files created in the input dir should NOT be named the same as it is
>>>> shared between all tests in the same process (which is all tests when
>>>> running binman with -P 1 or with -T).
>>>>
>>>> Once signed, it's checked with fit_check_sign with the associated
>>>> certificate.
>>>>
>>>> Finally, a new softhsm2_util bintool is added so that we can initialize
>>>> the token and import keypairs. On Debian, the package also brings
>>>> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
>>>> is not the only package required though, as it also needs p11-kit and
>>>> libengine-pkcs11-openssl (the latter bringing the former). We can detect
>>>> if it's properly installed by running openssl engine dynamic -c pkcs11.
>>>> If that fails, we simply skip the test.
>>>> The package is installed in the CI container by default.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>    tools/binman/btool/softhsm2_util.py                |  21 ++
>>>>    tools/binman/ftest.py                              | 223 +++++++++++++++++++++
>>>>    tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
>>>>    tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
>>>>    .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
>>>>    .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
>>>>    .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
>>>>    tools/binman/test/340_openssl.conf                 |  10 +
>>>>    tools/binman/test/340_softhsm2.conf                |  16 ++
>>>>    tools/binman/test/Makefile                         |   6 +-
>>>>    tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
>>>>    11 files changed, 853 insertions(+), 1 deletion(-)
>>>
>>> Not sure of the changes from last time, but I assume the test coverage
>>> is finished.
>>>
>>
>> They are listed in the cover letter in the Changes section.
>>
>> $ b4 diff -v 2 3 --
>> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T//#t
>>
>> will show you the git-range-diff between both versions for a given commit.
> 
> I normally review just in email (often on a Chromebook) so I don't
> have that. It is also an extra step and I don't know where your log
> argument comes from. It would be better to put the change log in the

What do you mean by "your log argument"?

> patch as well.
> 

We already had that discussion 7 months ago. See 
https://lore.kernel.org/u-boot/CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com/ 
and the exchange afterwards. b4 expects you to put the changes made in 
the series in the cover letter. It doesn't forbid you from adding some 
to individual commits underneath "---" but I also don't think it syncs 
them with the cover letter (which is a feature Tom told you you could 
bring up to the b4 maintainer).

Cheers,
Quentin
