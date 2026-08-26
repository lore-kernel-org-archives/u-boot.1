Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B416C61DC4
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 10:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 305CC80B79;
	Wed, 26 Aug 2026 10:10:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPnG7XM7BPpB; Wed, 26 Aug 2026 10:10:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787739043;
	bh=SX2pSCvhUGMbbWSRJUid/qMgCyKbO4kYktzrmBL8dhA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LyaId45I2OL/tCbWL1xWqR6FbRcJIPCsWLKd4EuGovYtVScEss01VtI6mB0iJXxiv
	 k351cVTwA7F1L4bBXxhGnbYiWb4+af1BOVBLHYgD2FpKQgQu2crZkd/N084gOR+cUz
	 2nlOIIFY6nCZkHFKdkZ029XykXf5YSTaHxChxW73MOu2/67ZMvodzsFw45RfQhtfVR
	 j1GZrW43iN21wk8VjFr4cattO4RjzmKE1zU0fwHYfmdTr1bwIxOZqbgVfn84GtujnF
	 YS1fvm5Lz1A5Cs7POZK/+SyJLM9KbGL1YjfNjuoRQtdZKuecb9GLlF0VR1kGS60rqo
	 wi3WPwYRQ3D6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86F3F80B88;
	Wed, 26 Aug 2026 10:10:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C217B39E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3BEC40555
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xpfjwgsqhw5d for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 10:10:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ondOIiok
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50EE540330
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyCWktI41VrGylDfiPi5GueS020lzTtU33F/CPIrhCcVbuXi8mBeVu+hdDuzBATsthlSOmqfY3RiMMBAHSVPUmkv9ETLv8hxNyeE6sy1j/nLy8M4CEVOc677h8yBlw3WMykDV12Krg6F5BL6z2unLPnsA+75DEilPs8sHn6vzwJGR9PkvhrEsCuWtkSTWEGfL4xFLoRxJbdWHLjl3NxSRT+Myrdv6aFYbtdE9JIyJpF3dcIkKN16Hm0RKANnT1hYESh8yA5bbeVaAAzAvxZfd/mfXk1BPuG5o3E4ADQnqK43HYjMRO6wA/ftm3LWGDdGCmQFTm6lI1Eai9vL0kZ3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX2pSCvhUGMbbWSRJUid/qMgCyKbO4kYktzrmBL8dhA=;
 b=rkPNo3acpj/az+eK8J6fnzFPCln7pvkDe3sTONs9ZskQ/a7V8l+xE1JBKiGu1i+VeT8Zd4DWOKHukr6jOIgrRW04SKpWzTmLb5wBFfo20yb6deNKZWLMwjP4fP835DyUPqfcWEdMF17G/wDw+UCymiaSL8rAzV4rm36QRr9aRW1uPs68/VeXmvyhW/7f+OjVZTz0+vssFtd8vONVaKf2SLvQ9V+p22/iD0kZzNiAnI1DPL2I+uc0WuGYIB23+G9gwEJw2vjWIoBcAY4BiuiZI6ZMKVMfvbw1rSB9f35UVqCCSOL0mb0DcPENcNF7DR2OqekRDHmlQE6fZwPR3MV4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX2pSCvhUGMbbWSRJUid/qMgCyKbO4kYktzrmBL8dhA=;
 b=ondOIioklMntvjmE7+1PleFgxD0EDz7vGuUpCkxKrf/ODVEM/ATmc7/O7hRGimsB26GjqjHvUzYk4NNirRFoXJgnqcZd09uW8QTzgYPIjsJvFUe/RYTSrioBxzNSR/73s4jbwYFAgivfqsoQH4IYfV9LoZwKLAazeqPEAIkdk17e0iFVa47q+DrqKQEUIEGDsWHGKR6iq4yOv2ZiPqTzcf+kAW5tVH6+KwfU4BM3+uBN4VHbeb4z2NFLVM88k06AI1ZGn7eDKszaMNtL98nLOz7CGOj4qFN5PJZ9sNuycOoGV65EZGlDNfMiR+ouvtzqUct7EXN7XGJje5sz180CGw==
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB989172.namprd03.prod.outlook.com (2603:10b6:510:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 10:10:34 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 10:10:34 +0000
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
To: Peng Fan <peng.fan@oss.nxp.com>, Jan Kiszka <jan.kiszka@siemens.com>
CC: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, Jens Wiklander
 <jens.wiklander@oss.qualcomm.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 5/5] mmc: Make "MMC Device not found" a debug output
Thread-Topic: [PATCH v2 5/5] mmc: Make "MMC Device not found" a debug output
Thread-Index: AQHdMzg+Srbw+BkVLEKkd4MsdSYav7awB+CAgAAX2qY=
Date: Wed, 26 Aug 2026 10:10:34 +0000
Message-ID: <DM4PR03MB620820E75F4664652B34E262F9AE2@DM4PR03MB6208.namprd03.prod.outlook.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <57a99d87a25d42f68f26697b81fafefcae29abad.1787514446.git.jan.kiszka@siemens.com>
 <ao6ng6CGIYy9aEK0@nxa18884-linux-1.ap.freescale.net>
In-Reply-To: <ao6ng6CGIYy9aEK0@nxa18884-linux-1.ap.freescale.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-08-26T10:10:13.2760565Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR03MB6208:EE_|PH0PR03MB989172:EE_
x-ms-office365-filtering-correlation-id: e9ef7bf0-cd6c-451b-0f32-08df035a44e6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|3023799007|22082099003|8096899003|55112099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: gVKkfnhtEFuCl/qQwi2AZAuld1STSQdKIMQdtfYS47KWbGLgeFLcaz6t80tL3XP8XXdOH1sLf9QtxUCH8+f8IbQbC/zms25pdECpvMayy/nZNmlDWSJLm9VcwuMR73rfEcy2nu6uKXofLfcPVo8YQsqlyAL/yeHKIwtb53m1cgVHPoHX+tpRfHkilBqPJMgoGjbCT8+ScVhVDiMXvHRWqlKTxch7X62OCBtbcPtUH1mIs4foIKenfh5Ds2ohM1G8TUwkix9Ht2Q8EyEQPGhK2Gi0p5Ka1j5RT4pkPWK0AeoOYE7Vnyts+fR5mWKXNfwcjTVHPTjb68dtSWpW9n/1F/OFqjgDWxpwMzH/Kmrbw7vHEEshIa4NIF4SlFQO8TbyWojVTipEUS14he+ZNEMiN8b1XErkXMtbtejdNkwzHJDcLShqByoMVbwwpuDRWdU1kqxcm6LZ5r/1F8kxCgQh9nWiL7f9gD6Xazr9FEXoaoIiQpGmpjCiM7pLg9086ScpFpmkOSgJunLYD0Y24lvp6vsHzpMKPAWPc/XyGU6m3fMwExDUDqxqfwwExGc0OXRH4TDeCHqmzbU9yWZ2hzLkOvdtAciALNXdxC0hKsGXzwoqlAX4+TX7RLSar3bTuJindgq9LkBJ1s5G6YtIrdy0t1b5AfqCJllbr7H/Grngo6+guW7c7JMmeSzKuhOwdnJVRfy4RNgkJkFL6k070bB/ZO4WqzCoIddrx1TGoqox8gg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(3023799007)(22082099003)(8096899003)(55112099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dLWAHM4bdplWr+9Uvti9sSU5vxPBupcX8l0Smm0ap7SPbBpGWXWpSy/f/svb?=
 =?us-ascii?Q?ryBYfNQYs+2sLd+VOIOv+ClOQFs4EBuakSC56PmXcKcUxEEjJZkN2xc4ifZ3?=
 =?us-ascii?Q?YrHlxUlmsjoU3BtXFYbnUlaMuZW1dHCYvYeIphu2QNVDgARFZD2hr6cX5SZ8?=
 =?us-ascii?Q?wcqysFZSeze+uoGvFPCrvp2GuK6KbXZEnGz65yofW1Y35Ged8XQnvodfihR7?=
 =?us-ascii?Q?lngLH3JzjKhjMiahfy0VKXbY/1cck8gpEboNSOxMUXb2gBMmU0JmcJr/bGDL?=
 =?us-ascii?Q?XTICFcnHZTMJYYgnAq33gSjgojfL1ygLxDE6Ebr06UgNl3OBV2W55/pVCFE1?=
 =?us-ascii?Q?eOQz1NiX7olevkRX6HAHpAKA3YoouSo7E7gEmgNj/VxMgYDI0YoRKp4gaYBG?=
 =?us-ascii?Q?zDj4bDCYxKcpgYmNqoY+lttvBGleEkZ30eHRLyIWe7Ecsy2aJcNwDc1jPYq/?=
 =?us-ascii?Q?YptkBymxVwMiF/5vZJw5CKPXDW9cAKQay6BG0RAJpiHp74Cz9UBSAWmNAbcz?=
 =?us-ascii?Q?aVG41nz2lUmEqZ47ElnMrXIu/0ZRnrr/hxmgu0L0W3hcYo4M7e/sWlx/l45E?=
 =?us-ascii?Q?9nkoClAliPYFzSFtTUIyYLnZBXEt3XHccXmPg1btQh3c4yjNWjd0LwIAZTiT?=
 =?us-ascii?Q?tXIGYaKhTknXEX3O9wnXNJdwE2VuwtdumBtarJrqchspQkk5NsEOqd3A7LoZ?=
 =?us-ascii?Q?4hK0ILg1xRax7ksZCy93xsPGL/XT12Um+djJkWwx4cz8dHSNLFVM+PXlqq8o?=
 =?us-ascii?Q?XOJVX+tDM7Xs5ehXSgqfyq+7arWiuCT8d9ii6iNgcwnc+R5eFHwbMNITVCLc?=
 =?us-ascii?Q?2MPTnIWRnbOsFG4lx05517BAgTLYsb6nFHplT5A32TTo9me5FBSRS0NmFyC4?=
 =?us-ascii?Q?2SFnCaSeQC9IkzhBf7knJIUSRiDyzoOK+dX3xBLC5BDsQwMJHA3GK/2JsyuP?=
 =?us-ascii?Q?BZQqgwHNsinSrXUJK9RD3ic5XwNQXaVGO57KyEi35DTShxXHeFuSsoZ1smvy?=
 =?us-ascii?Q?UiGqJW8OCQKjwEQqc4P0Gt+DqtVdqYheKTK7qM/KKN4acunvEzTL1ozu2YYZ?=
 =?us-ascii?Q?1usP5DZo8ookQxrz1/7twIS3+ZhdWPhnPdD+uHJtv29pYUcG6jU4o33eCnWT?=
 =?us-ascii?Q?JTrhLoaXuXc6xtHpu1yeIqPsWSqMyQXnYy6O4HEc+yvnqI+9H3Iu3fenGgm8?=
 =?us-ascii?Q?f3c6XdoAXOZNTvinYtWDhsleQazuqqLJYHSZAVnwwNMahajaKh4aCjXJ/qLY?=
 =?us-ascii?Q?mVUWIZwsJFZVVbGhj9myWwnSwnpPFCtg89s3hGAEJKQClM/NiQCMFrvhTp8H?=
 =?us-ascii?Q?yHQj+esyh7qMPSNFj0yWvBq4C58tFSpU+Bu6fOYnC8zPOh4cdo3ETW6b+Ck3?=
 =?us-ascii?Q?EQQmzj9sD0EgpRSW+SrU4x9CnP4rTfvYd9RefZuywHyOOhHG+FI8xhcliVLQ?=
 =?us-ascii?Q?82pb9W3vL5IVdfBxrYdhnrX9otuRrR4TMVz5RXzdDwPrwessd5R5wGy2wPZN?=
 =?us-ascii?Q?S2y7gl32qt4DwfZzMuEk1tFB9+tp9a4/ICAOPqvX6AupGUHd6OefjymZ9FGs?=
 =?us-ascii?Q?tWZIwm4ZCDvlBTK4H3SLTn3l4/GvZg3RjuAO6g/Qeyq0iCcHC02EFg9EsDUd?=
 =?us-ascii?Q?v4AAvMjwFR9eOf2Nnr0dvvAu11QwLaZQVoyfzUvEr8aDxifgngIaFmz8eAqK?=
 =?us-ascii?Q?vI0QM7xOBjEMwoFW/k4nbAU1+5FUwP/M/klNoLGsoZSO2Y+4MoqJY50sqV5C?=
 =?us-ascii?Q?7vuMO5cf15PQGb1r7K30ABCvhzRJdOk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR03MB620820E75F4664652B34E262F9AE2DM4PR03MB6208namp_"
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ef7bf0-cd6c-451b-0f32-08df035a44e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 10:10:34.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtWM0Q5ZVL8aA0I1gDPlvoz3gvKMZR4SK4Oma3Ag4ILExe6LJ2RdpRmkubfm0+a79+Ay2tZ9duFjFkuLV6GcnOVz+yzSCbdRIMmTNMkZoMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989172
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

--_000_DM4PR03MB620820E75F4664652B34E262F9AE2DM4PR03MB6208namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com<mailto:tanmay.ka=
thpalia@altera.com>>




Altera Confidential

________________________________
From: Peng Fan <peng.fan@oss.nxp.com>
Sent: Wednesday, August 26, 2026 2:17:24 pm
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>; Jens Wiklander <=
jens.wiklander@oss.qualcomm.com>; Ilias Apalodimas <ilias.apalodimas@linaro=
.org>; Sai Sree Kartheek Adivi <s-adivi@ti.com>; Alexander Heinisch <alexan=
der.heinisch@siemens.com>; Kathpalia, Tanmay <tanmay.kathpalia@altera.com>;=
 Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 5/5] mmc: Make "MMC Device not found" a debug output

On Sun, Aug 23, 2026 at 09:47:26PM +0200, Jan Kiszka wrote:
>From: Jan Kiszka <jan.kiszka@siemens.com>
>
>Callers of find_mmc_device are generally processing and informing about
>errors already, e.g.
>
>=3D> mmc dev 2
>MMC Device 2 not found
>no mmc device at slot 2
>
>Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>


--_000_DM4PR03MB620820E75F4664652B34E262F9AE2DM4PR03MB6208namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px;"><span=
 style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">Revie=
wed-by: Tanmay Kathpalia &lt;</span><span style=3D"color: rgb(71, 158, 245)=
; background-color: rgb(255, 255, 255);"><a href=3D"mailto:tanmay.kathpalia=
@altera.com" class=3D"ms-outlook-linkify" style=3D"color: rgb(71, 158, 245)=
; background-color: rgb(255, 255, 255); text-align: left;">tanmay.kathpalia=
@altera.com</a></span><span style=3D"color: rgb(0, 0, 0); background-color:=
 rgb(255, 255, 255);">&gt;</span></div>
<div dir=3D"auto" style=3D"font-family: Aptos; font-size: 14.6667px; color:=
 rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
</div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container"><br>
<br>
<p style=3D"font-family:Calibri;font-size:10pt;color:#000000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
Altera Confidential<br>
</p>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;" dir=3D"auto"><b>From:<=
/b> Peng Fan &lt;peng.fan@oss.nxp.com&gt;<br>
<b>Sent:</b> Wednesday, August 26, 2026 2:17:24 pm<br>
<b>To:</b> Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
<b>Cc:</b> U-Boot Mailing List &lt;u-boot@lists.u-boot-project.org&gt;; Jen=
s Wiklander &lt;jens.wiklander@oss.qualcomm.com&gt;; Ilias Apalodimas &lt;i=
lias.apalodimas@linaro.org&gt;; Sai Sree Kartheek Adivi &lt;s-adivi@ti.com&=
gt;; Alexander Heinisch &lt;alexander.heinisch@siemens.com&gt;;
 Kathpalia, Tanmay &lt;tanmay.kathpalia@altera.com&gt;; Peng Fan &lt;peng.f=
an@nxp.com&gt;; Jaehoon Chung &lt;jh80.chung@samsung.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 5/5] mmc: Make &quot;MMC Device not found&quo=
t; a debug output<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div class=3D"PlainText" style=3D"font-size: 11pt;" dir=3D"auto">On Sun, Au=
g 23, 2026 at 09:47:26PM +0200, Jan Kiszka wrote:<br>
&gt;From: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
&gt;<br>
&gt;Callers of find_mmc_device are generally processing and informing about=
<br>
&gt;errors already, e.g.<br>
&gt;<br>
&gt;=3D&gt; mmc dev 2<br>
&gt;MMC Device 2 not found<br>
&gt;no mmc device at slot 2<br>
&gt;<br>
&gt;Signed-off-by: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
<br>
Reviewed-by: Peng Fan &lt;peng.fan@nxp.com&gt;<br>
</div>
<br>
</div>
</body>
</html>

--_000_DM4PR03MB620820E75F4664652B34E262F9AE2DM4PR03MB6208namp_--
