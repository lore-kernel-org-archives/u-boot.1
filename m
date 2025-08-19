Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F4BCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 314C9802C1;
	Tue, 19 Aug 2025 06:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UiS3Qat0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D312B80422; Tue, 19 Aug 2025 06:12:41 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFAB48006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCY2kHM2OdoPZxeN6+6KMb2TDLCcys+ZK1Ev8CxtW5lXHjGGabwvE8ceSqnNqn7EDStgx7wNLtm60Ux4WcVjvsl2EstCmOHbg8gPp5mftzLyRXpL6l4KM7XMwhZWyh0RsXjrrFO+uwgc3/LIMcFzo+KRADOz9nIA4dXPzve+HqbDj6lrmsqmk9+z2Y4juli7zxrn3gWZlrDfoaq8lqzjVdrmmoFmNg75u47jPVarzbf5BLN8DOrelx+B4dLIQbTbx/X01UvbwdAd1mxarqqqDa8Oz5R2Pw0ZYo2PzG2zGYl4yX9IDzAP9MqnrZg/W5mZ2ABCXI1uo0N2WaUKRtfWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp/HLv+Cc60ql2XQ3pqGJQFHoP8YmPYJ7I8htXHvyds=;
 b=bdaD8MDb0YMTE39cIB123cEQdoUS2ejOVP8b+hyS2XD7y5IB5/+GNXoc/MRhyTqCguHzd0LSCrOv6130+xKxGhp4ylwkoTd/3wbbwFp3L0aK0rir7P0P+wVaIqvA3oqCfj8/V/HCeTRWS/tKvQ+MRdvsfKHTzPjzmoFk2VMDsZXhZeoX8W+dorW8enW7u52qsOnRYDAlTtK3EAoabyiBLvNqvzZO2+IgDETuhLfjjSMMkM7Wi8Vn6uNgxt5sHaTW6NlbQWoQ5pyEAc35kdnRClHPSiJwT8QJcrsXgVMhRTur1nDqaLIugnsZ136xhxzFqHUos2dSy0Iy5kIOLxzSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp/HLv+Cc60ql2XQ3pqGJQFHoP8YmPYJ7I8htXHvyds=;
 b=UiS3Qat0Y3wuCgb3A+tIDYhaOnMCJRMf4bliz4WazJXp11yq73KwAru2ciHutZuK8RV9fB84Co14zXaZRv8wlsWG86e5nK6LSuHN43hrGz2cF+RpRFt8IVIp/wmzWwlOrzGGulr2NKDmZpHng0iNlRxbs6rGjQ6ZctEtKg+58CiVA8+s1WFJaAnXY2cfqyBJ/EYaYxLEdxVtLuQrNvTs+ywJzI1v5loWJSJuGPl9DI9hhjp7hJiFfLI6KLGhXufwcJ8j+RShvwYDdapIsu4T0ufPhDevo4jcVPtKCldmTrkLDR2KQBh2TxyI03PiR5kzU6xR8+bt12iyan/nalw2bw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB7243.namprd03.prod.outlook.com (2603:10b6:510:24a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:12:36 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:12:36 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Maniyam,
 Dinesh" <dinesh.maniyam@altera.com>
Subject: RE: [PATCH v1] configs: agilex5: Increase watchdog timeout
Thread-Topic: [PATCH v1] configs: agilex5: Increase watchdog timeout
Thread-Index: AQHcDZZgIqmsf741ZkWX5SlHeTyATLRpY8YA
Date: Tue, 19 Aug 2025 04:12:36 +0000
Message-ID: <LV8PR03MB81372ABCE6B15EEF1689D3D5A730A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250815034022.11243-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250815034022.11243-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH7PR03MB7243:EE_
x-ms-office365-filtering-correlation-id: 1c0e404d-d077-4972-9f1f-08ddded6a122
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HmIzI4O3JIxUCSajGhF4Bq9Ao6bcUQ4cL27tkj/oMvm/ST6F+nZl5pFzjWp2?=
 =?us-ascii?Q?nvyaYU7uybyGVOndXVSC40vtncf49I3Jid0U0e1aNyButfvKwsA6nmz1Mh+f?=
 =?us-ascii?Q?/mgdDuE8Gd1SIPBXSiEk4SaTaJe3r0g9R/ai5Typ/mi+N7T4HGntQs3EmdLy?=
 =?us-ascii?Q?LsXvBzJuRxUReCken+/7L1r1K89IuwagDrg1N52rzLsf8JQclAw8yNtrozHC?=
 =?us-ascii?Q?6A7sznpXDhmjeQUujfVvGXRifsrjPabOJYXgG+Uf1jfvDz7yM9lPHkF/Sj59?=
 =?us-ascii?Q?XKt6jVl96qsE5sDUNLHqTvHC3CYpDaRHbuTvwj/Xcafy9lPcIOd+ot8M78kI?=
 =?us-ascii?Q?trZaVmL6Bq68vVtIQtvVlNpz4vyu6KRHxx81rP5LPhl4jkwUWn2lc2D+gX3o?=
 =?us-ascii?Q?5IjwxJ65d/BnfUNoLmRZVfUvqdyGUyZBr2VxY467VTeXl97vEY19AXplQejR?=
 =?us-ascii?Q?Xc0Yn/LgmeDrjUBRZbvDloL+lhQzWQ3XUtiJlfSckq8XxKTRFjVSXU00dRIR?=
 =?us-ascii?Q?vhnVVKC6IFDJ2kDiun+yE7oBMSObLGKp6pELvOnbe3REzcsrJtbcmbs8FUpI?=
 =?us-ascii?Q?Cds//Fz4PvnMOic9FC1uZhI57oNZU6VE2VqkMgC9EDBW5biNdhBMTSQ1QuTR?=
 =?us-ascii?Q?Q0/noq3hmlqEXtCH5EgbSO6tsA2la0hczm6GV3+h7DlCJu+Ob/EqU1ND5CeI?=
 =?us-ascii?Q?QAz+9KskpHaERaFEcE8xg4LchBJ6vmV337//55hUmMk1CmqzVtaEtb7DoNQ0?=
 =?us-ascii?Q?7xdlcRjSSDJqNWaJpplm9bWnN2kUs4Mli1thZZ3+n9/8rNnjOvRxwLQa6+2e?=
 =?us-ascii?Q?SiMsAakvQUW4nG0CIl7CvjXeQvvc2shx1OYb6CyBC8B0s6r8bpZgKGMlcpQ5?=
 =?us-ascii?Q?3tlHb17gCyUDRw1ED0UNcKLvHeaEjL3phnFbfNrHP2ntqjEqopdquoEKLcmr?=
 =?us-ascii?Q?cY/VAyo/mU6E0G/u20awPhqFi7jyRD12UnAHKMKoDqo/O31HtPuB8EYms2JZ?=
 =?us-ascii?Q?O2LDCJXpJVKO3vE/vhPJmdqBuR6SYA/u7bVYf6gsDZUNcoLbWgktJn1ANyxM?=
 =?us-ascii?Q?Sbp9gd+9r9RlSQRiDQGi566/vOIQSSMbMJ+ggzvJ7PEKLsXD4/BfPIYJfPnk?=
 =?us-ascii?Q?FxNwwbka1FOAFRirHABvM8a+2dZ/vdTrpT5YGW41WvyJrvrD6n877cIw/dVK?=
 =?us-ascii?Q?9sLsmDkUrER49YUNKok3dKXaqAAub2ATkdSn3ZHMf6Nl12YXIB9Q22/VXQLu?=
 =?us-ascii?Q?utuDcalvueCYzgXfdd4VcorSW8ezcM75HK0A8D5PtZOrw/CnEKXylnf+nKxP?=
 =?us-ascii?Q?o71laoxLyU9Ij258zfKneSynMI33kbzYFdglaFnCxRnJeo7FE0QuZglM8Glj?=
 =?us-ascii?Q?8eLPPsmfIrbaKEfuSK+NFUHYr44FG0qb6hBLo9dzQIXVwKW3pSSYwFQMm8Ba?=
 =?us-ascii?Q?D1rOkkMBj5BmA7mcwF9IpJ217Gyqio7Ybvere0Kb/6Jr+HOjmG3RRfVZcCqe?=
 =?us-ascii?Q?Uufnxzf/cYBSVls=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LNI3kchJHJjvs5/xmaeDz4radFU61rYBVl6jM6C18PFuoCYFDeofgKQjj2zV?=
 =?us-ascii?Q?MEV1mck4ykr+nfhw9rQhWhgy9C6zqGVCyC8wwGJaxQ+LeBcMlPfdppaGFD2Y?=
 =?us-ascii?Q?okoohsW/L4N7VCZsoK+K8SISmsBvhhtFWR2x0IP4bwHT+CujndfPOV2t0H6Q?=
 =?us-ascii?Q?QpJIUP85Fs9PR1VZuMs+DEfJRGaeVgAg8njMyrP7wzohS+uiBRybrxmK+h78?=
 =?us-ascii?Q?SVtfP//vK9vWH5IgjOBbUuq130kl+oBMlk/Cl63sBdHzTCB1PMcCtPayOykD?=
 =?us-ascii?Q?B+qt9oVeRLAUTpz24cLkUfvF32NSaP6n8RwN5DJXYWIk0aqC/tL6LTAboUq/?=
 =?us-ascii?Q?af8ltE3hooHzXopm/myPCnfI/3tvtKNKKerBq3PQ4fWi0rhV0Q6fPEMLu/94?=
 =?us-ascii?Q?S63qw1nHUJbdIzykVJe/roPq1a7xg+dhIOPb8QDf7rQuxLAZsiGSEd9lTsM2?=
 =?us-ascii?Q?JgYcMbdqdMWHhN5/zP8ejdJNUdXlhWKNC2iZg1lZIcn9NE6QC3tNp6NDKyq2?=
 =?us-ascii?Q?rnzZwkNjXZXSFsSlY7tgJ2FuqD49CLPbQFKxG1rk0T55jahPp0BEMDnqx/+z?=
 =?us-ascii?Q?KLCfNvHFyDWqzMmrI7/I1AgRUY1FMmLejtDBCrZjlnwbgWE8g/o6xmqy+iAX?=
 =?us-ascii?Q?D4WDGdtG5VBp7apbdw/q9zkzAznKOgP2NHmufVcv97uJoFPlqdVowQNwduN1?=
 =?us-ascii?Q?SvFyUaBEmGidMa+cQMDjuvmgcVr2Sy+ipqzCKVsBpv1nfYHaH/Rx1o7kZ4+/?=
 =?us-ascii?Q?Ywe25vw+Z5VgDPW5VxvPSrQNIolcod7eu5GN0k3CcSJAwDiNJeXG7EV4lyo8?=
 =?us-ascii?Q?Ih0yjZTh37fLXr58gZyJrmm/cWCTKkPvMaHCHMuPlxkn4AH2Jvs5h+jdhGDZ?=
 =?us-ascii?Q?Kj7NFf8uN4ep7J8NPbnES3zOvZ/7sLJfL4XJVTmjdJ9RkLWJnjYOwhbz3b2A?=
 =?us-ascii?Q?H68JkVyCw59LRDt3lcHoHUOXEVFUlKMq+4uczbBB2pHP3Px0LNHlHpS0nBNX?=
 =?us-ascii?Q?/eaKOPL7NFt2m7cZOcbVLnVirFoULPLAYDEWMg4SAJiEPRNZjN7DFOzN7SVo?=
 =?us-ascii?Q?dSCgQlxudvvwZtHX4RDxGZernBgy7Ft49Z8Hjhgz1LkM1/7vwNv8SiXbfaBY?=
 =?us-ascii?Q?dHWAtmX3gD7gymCJMAGeMlpX117csQCbAHGaW2sZ92dNBtcqR+sBwj3orKts?=
 =?us-ascii?Q?6OcVlTZpD0nIurbG6iff/8QFnJDVIUxoFMLkigYFvHDgbtnlqGByLUe1FFYH?=
 =?us-ascii?Q?+az2Hh3wu08jxmGCVQAvJlBHgAoXlSXHkeyoJa5wseF4Mdn+OIzIiik9OxyA?=
 =?us-ascii?Q?dHhTo8JYoTrj2vSp3er1JS48n62Je3AkW13T5+gqJ6hM/ZRyrG+5QgIRO50x?=
 =?us-ascii?Q?K1RUqiXy6ZkYFG+sQll5DwYbwGR0NXW+8h/3mkDTU+SEPmRtSXTQRHeb9Z+T?=
 =?us-ascii?Q?iyH5xZWy43+RTnVk4RZqAhE83qOBGJA1UmlkaigGKlJT66K5kw4z01VkJJAS?=
 =?us-ascii?Q?d86eZ+hjFsu2AvrTsLD9d08lVTkZQ61RxWrJC51mK+kVX9q+DfaogsccItrZ?=
 =?us-ascii?Q?FG7V9G1fhE+WOnJqS9ByQqrexYPn1U+uPqWj4eey?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0e404d-d077-4972-9f1f-08ddded6a122
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 04:12:36.3965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmJ+JT4FZZYLirmzGBvHUT+jxlapkqtPqKTvHqZ3uCiZt1uNa13s+bImcepn6ruaGPvnBg2D+Vp0kdBPZ7lXLiYYpZMjgHCbJ7w0eHcaa+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7243
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Friday, August 15, 2025 11:40 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Maniyam,
> Dinesh <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1] configs: agilex5: Increase watchdog timeout
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Linux kernel will fail to boot due to exceeding timeout trying to probe I=
3C
> device.
>=20
> Increasing the watchdog timeout 30 seconds will give enough time for Linu=
x
> to probe the I3C device and will be able to boot up successfully.
>=20
> User is expected to fine tune the watchdog timeout for the complete boot =
in
> production.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  configs/socfpga_agilex5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index b373201dbaa..846c18eed27 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -15,6 +15,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>  CONFIG_SPL_BSS_START_ADDR=3D0x9ff00000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
>  CONFIG_SYS_LOAD_ADDR=3D0x82000000
> +CONFIG_WATCHDOG_TIMEOUT_MSECS=3D30000
>  CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=3Dy
>  CONFIG_IDENT_STRING=3D"socfpga_agilex5"
>  CONFIG_SPL_FS_FAT=3Dy
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

