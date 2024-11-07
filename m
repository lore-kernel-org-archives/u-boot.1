Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B66D5AE5A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 04:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC1C88FE5;
	Thu,  7 Nov 2024 05:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQ1CB77z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0085C89032; Thu,  7 Nov 2024 05:21:55 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFDE881FD
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 05:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkL7PL4FoIk7fT0ggwe3cVSsroekECL07sp+0WpuiRxDgECZ4fzQsfvQZyoqCpGLIr/i77a+Gbng/8aWs45AOkq754mnvVNeTjkc6nvRslfEkpO21wjmTk2j50jXtKzRZqWBUYsKg2Ym8OtARSinx+gn8SWALYJKunJiTxskDaBuc5WvHtn8CzvlExwbIdymB/1qa9U+kcvk794I1LLPugXep7r+sfr2xDaZZ39V4djYo+zgJdWOGbVvO7VdOsbcjnpZBkU1H4scxVlfWR7lOWraYLUG5SVFLUpoN+qvN5oNimDhu2BiNwdRv0kaH0cDWWJEgCpzJlazolLCl4r6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PuWmDx/ZfSEACOQlupEJcYqFVQKLHfBPM/HjubuKGQ=;
 b=QOtO+Ur0IQi3tYih7w/wl72eFmYfiGuccLzdTyVoak4hCPObeShM10Vvqcg8yoXl3PTVa52IZH8QdF58KMi+xjFPLYqXjcPb/fQpDEAltpc9+TmDeHg1rQquOSk2+utGl3vm9y7WJROgpWhqNfDo+Akp/ShUCT0KgPgT16K2AjVqg8nZMSkWvsxntwks2CGKFyjpNqLCcTWBaD+fSBHElS3Et/4/Az/1vjiuSZ0XikjXwe6xUE1fF5SAWuiZ2Q7g1E3hAnDgUOoa3q8jDa8zQevvLwF+lPUJsHl2GFNs0/n81Wta0weOafMhgUyMki+dW35Dj41w9O+GwnaW9GSblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PuWmDx/ZfSEACOQlupEJcYqFVQKLHfBPM/HjubuKGQ=;
 b=jQ1CB77zqSa+IdNRZFBLSMn5mhVgabrn6/+bBYNmXI39yIGNfhj2JvqBgM1DZ1hrv7p29zI4uxvywun/gWigpbvA+SJRKqr9kPvFBcjh7hMkEZImLujWVKLjdoa8MxiznZKrbavLD9t0on9G+/I0VmDtcT9+lkafkM4YZyrWjzU=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 04:21:50 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 04:21:50 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@xilinx.com" <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/2] xilinx: mbv: Align smode_defconfig with upstream QEMU
Thread-Topic: [PATCH 2/2] xilinx: mbv: Align smode_defconfig with upstream QEMU
Thread-Index: AQHbLEN3wd0E7yEUlkaSmsrPNMNzSrKrQGyg
Date: Thu, 7 Nov 2024 04:21:50 +0000
Message-ID: <CH0PR12MB526661F992C53EDEE47B7273EC5C2@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <e0109cec6a81163f213684758a5b2d67d927ea26.1730454591.git.michal.simek@amd.com>
 <f7da41aa5222bda46ff6cf869cd45f3088e677ed.1730454591.git.michal.simek@amd.com>
In-Reply-To: <f7da41aa5222bda46ff6cf869cd45f3088e677ed.1730454591.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|DM4PR12MB6424:EE_
x-ms-office365-filtering-correlation-id: 9dc4d70c-5c00-45dc-eab8-08dcfee3b375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lIPSe8CH7tqgcgG+AWvalFXoahqXfEYRM7OiRblu7rqLx7E4cD1Ctoj+jKQS?=
 =?us-ascii?Q?GxXKOvygO7gmDXGGPYiVViTtLlep3U6B6eFVFXj35NRwRSktxhnQpwgb4MR6?=
 =?us-ascii?Q?6+K6aYx8e76rVXVN6FPK8RjzHOq0A+iqZBkOofiYASTqqYArLuvh08dIfpC6?=
 =?us-ascii?Q?1MUpgWYVh5smVyxkk0sbeW91aBSgWnHenKWpaQ/IhnFErLNQnPsGbuguXPPN?=
 =?us-ascii?Q?xl6yldQgDHHWkLMLcI1aA7v8TewVaDyOiVYU8pKXip26HO1xGcKcMmdyesdE?=
 =?us-ascii?Q?G4+DwkEbCw3qWABlobwBjEUn7qfvJy2uqwsVD13solh4P7Av0NdXcNk6DqeM?=
 =?us-ascii?Q?LUkPR12z2LEFuTvIbKhbs+LFkuEcRZtcxWswzGP6VRuxjpqCLwQUaS/WFrD/?=
 =?us-ascii?Q?BvnnQKaDzE56ACFmduQ8t46YRdnonxmFsS2FKWgksFmnslSpCXt/WAK26lLN?=
 =?us-ascii?Q?d1WUl/zHU1L+QQ+3nd64WW9GNYLzV+VFnSot1O6zJybHSYhb1ify3Oqc/Dkh?=
 =?us-ascii?Q?eLt/6yz3KAtrIYVmSDWy7pWNfEO10l1vUu6WxbKkrdXuDZD2Ypd0Y/2tldtG?=
 =?us-ascii?Q?cDzKknrICi6am7PTU8BMXbRfXEqmddDJxNdcS7TcbdoRjkLz+wmF/5ZcPpLV?=
 =?us-ascii?Q?R3SE5SgkbeefkJT3WNrXvGOF9oTe6M0U4j/5XOdkXalq6AiXE9CY1iqdnZgh?=
 =?us-ascii?Q?pmK5zzQGqGK2St83RGrdj1xfWFav6NDD9avoomnG6c1B6jMcdWCnWUCKDWJq?=
 =?us-ascii?Q?WCESj0ArX/HtOgj5Uc/07RgYEs4QV8CyTw1YBgBTSUSMRtgqWUum2YFjbD9U?=
 =?us-ascii?Q?hnE8jFKGM/ITR1lafONU3afzTgzE8fbdTKD8otctfvTA1jHvedFee80Rcnzo?=
 =?us-ascii?Q?1w9Rxu6t7LEGWDYKR0JNj7rOuka+Z5vnLVNlblMb3TuNjSs4Se65cT9KBm4d?=
 =?us-ascii?Q?zyeJOaFZWDUTQTsSVY+iSFwUiTYRXawuIzMJ3W946fmvTz2wPanUr8BM3JdC?=
 =?us-ascii?Q?4VZHyHMZ9hJPOVfMtESMfumRPG5HSqX+iAlZ/B4M9OKADvTWgDXhodzJvM1+?=
 =?us-ascii?Q?lELepHvGt8AyPEqotjJkY0vu7e1ACA3256WbKD81OBfHJJ+gTiHM34GDczkS?=
 =?us-ascii?Q?Ih7yXmY67D5ISqnjDN0Bp1Hu0qxZFQBP5Wzp+OlBdrU32rM4E7k+PsqiZvnE?=
 =?us-ascii?Q?7fMhwD7cYP3vRCtLNpUI5krjaaRtAHS8QIax6emyrSUyGYw7ORN8+KrdEjP7?=
 =?us-ascii?Q?PXkg8rd7KxlvbnbMbUFWsSQx06Faijyo5diprLbDzkJwk0wpYGeoyc1ioXUO?=
 =?us-ascii?Q?yKmB+iaMyedloRXr5hY3hIf61EaKRXvnk+28JBK88it4152w86Yi+w6uaAyn?=
 =?us-ascii?Q?sZoIt34=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vhSEfQGNx2RS/kpfy4jJSwZ7Th08gXZw7519gTS6BLaxRmDuxd4qsXU1LD/B?=
 =?us-ascii?Q?gFc6RVRstNgPQcyS0S9hxpSIupUe90PM/HskiO/xlroJCPuBqVxCW9tI92bB?=
 =?us-ascii?Q?uQsBauwL7oylxeXOZMOm06/5oqYhnNNigtBymOvliNZLSvxtbg2GP5fMGZfy?=
 =?us-ascii?Q?BWgTxy1vsiTSM+O3dZYVQmigt1oTJTlm7CvFDLPNqwgGXMKqtNnn6C9ifUG1?=
 =?us-ascii?Q?JEa3Pk72RkAIVbK9XjEWO4KvrKSRhxb3QDp0h48TxifsAqXFrQjzibPzC0Bg?=
 =?us-ascii?Q?+6Ym5glXjtp0LTUzhIQQQoqf88pPPkT6aDKAwV5FDb1DxE/0b7Tmlk9qkgWs?=
 =?us-ascii?Q?XJrcshHm1l1VxZp5aIKD6BpEew+7Nl3sPH7dliVNw29/jEq6yHbVHFS5j5eN?=
 =?us-ascii?Q?wjK4qq4e7i1/MWOhj2ktI61Rm3xQ0q23RGxRY2aagCryf3KAfbti8Utq3KuA?=
 =?us-ascii?Q?yvAeG1TN88lVsOcsyh4sUZtT4PxR16xY5+QSrhQwYX3E04jJu/Fo6tH2tBLL?=
 =?us-ascii?Q?g0GkX6K2hdRIm4hthoPuUsVyb7PQbGMyxlmkyIQkP6Evmnb9gClXk3Pq25TE?=
 =?us-ascii?Q?ZTO8RRtqUfnT+xKbl+1QpXK/SAgq75jYF/IURlLtdDWGnqEX7lq33tmkF+/n?=
 =?us-ascii?Q?6ZyqU9ZifjeG1Ka9v+UHDVwLtJBilYloqFYQblvhuVRo9B6BxloHuVyiwXuf?=
 =?us-ascii?Q?U0d5arNQnjs6CxtFtW/MTw/V7BEObFfmgEd6pemfT5F+awdDWDFgzqnxbzKX?=
 =?us-ascii?Q?naUMe5AQ6NVjbp5G26FrqqrV1I2QbwNhj+hUiH+4xYM7ulDR3VNq/mwuo3Qu?=
 =?us-ascii?Q?7s9d/Y4RY9FXnHlH3+/nKuQk361GvaFFazdmrUp2ElHcR5FGoo7dRb7XghD+?=
 =?us-ascii?Q?MTPvKFur0Y7HjA2UE4FdtUbuxCtbl8ziSUhbxrlh3dBfmMZIu7PmeBKCK3N/?=
 =?us-ascii?Q?2FbGuVVGzt+TtDDsJckMJ645qxCa/ZMiUg6lV6j3vFQ9dC/NmYYvoma1w8Ai?=
 =?us-ascii?Q?lvYxtH95CwIzhOc0wwqmds8TtL1oSHi8OY8tPC4EYz5l9yn8V6X4sCr8fPA5?=
 =?us-ascii?Q?pjroBUOyD5p6Wax+/BNG6G8uhVfVClCE3FfsByviYwJ08jfHqeFMlYxFHF+g?=
 =?us-ascii?Q?jMWYX3VYWCVeu087SV1cDNt5wQunJNonnrOuc2hKm590MAUCc1zswVULJ/pq?=
 =?us-ascii?Q?U0Nent0wQqzWJLiZN95BFGVG4yMpfvdiA6pRlYa5JpCb5KuSrdN1l3dl+Hzk?=
 =?us-ascii?Q?5LlKCDs4HY9dwZk0GLAdSbBgg1iGHtPEVUrB9qy0916TqXE2EYRxGfIATpHF?=
 =?us-ascii?Q?Sv7P3Py6zLZABwZGe1duMc3p/ievRkKhXAk/QaFyV2d9A98pyViG5JN+Ihtg?=
 =?us-ascii?Q?GyJWU7HSEMVBPAlIGk/0eZvWJCERvrfl0dHZqHQqn+T0OG67ogRDhgvqT5ar?=
 =?us-ascii?Q?LAysMXIaL9y4DGbV8jaPPwLdaiGW8TQ6AXtX7PyeKsc4Kf5PDG/FB5cAnE0O?=
 =?us-ascii?Q?34L1kyAWrm9aaDLgo8CCm8pXFc32TpYEohnzjijc2WN6aWalJMT82FXHLupW?=
 =?us-ascii?Q?lyCAfc8o4r5c3ZjxGug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc4d70c-5c00-45dc-eab8-08dcfee3b375
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 04:21:50.1593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExvCOn312vCJY9e2EcUy204VKGAvyAmjtbG59Wh4SO78Q7VkolzFPwf3AUb8v8Dko6NmiQgHPM52wAY20LaSkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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

> From: Simek, Michal <michal.simek@amd.com>
> Sent: Friday, November 1, 2024 3:20 PM
> To: u-boot@lists.denx.de; git@xilinx.com
> Cc: Leo Yu-Chi Liang <ycliang@andestech.com>; Begari, Padmarao
> <Padmarao.Begari@amd.com>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH 2/2] xilinx: mbv: Align smode_defconfig with upstream QEM=
U
>=20
> Align smode defconfig with upstream QEMU. It could be the part of commit
> 9d688e6da5c9 ("riscv: mbv: Align DT with QEMU").
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Padmarao Begari <padmarao.begari@amd.com>

> ---
>=20
>  configs/xilinx_mbv32_smode_defconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/configs/xilinx_mbv32_smode_defconfig
> b/configs/xilinx_mbv32_smode_defconfig
> index 741724f3bdae..820681d505b7 100644
> --- a/configs/xilinx_mbv32_smode_defconfig
> +++ b/configs/xilinx_mbv32_smode_defconfig
> @@ -2,13 +2,13 @@ CONFIG_RISCV=3Dy
>  CONFIG_SYS_MALLOC_LEN=3D0xe00000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x21200000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x81200000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"xilinx-mbv32"
> -CONFIG_SPL_STACK=3D0x20200000
> -CONFIG_SPL_BSS_START_ADDR=3D0x24000000
> +CONFIG_SPL_STACK=3D0x80200000
> +CONFIG_SPL_BSS_START_ADDR=3D0x84000000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x80000
> -CONFIG_SYS_LOAD_ADDR=3D0x20200000
> +CONFIG_SYS_LOAD_ADDR=3D0x80200000
>  CONFIG_SPL_SIZE_LIMIT=3D0x40000
>  CONFIG_SPL=3Dy
>  CONFIG_DEBUG_UART_BASE=3D0x40600000
> @@ -16,12 +16,12 @@ CONFIG_DEBUG_UART_CLOCK=3D1000000
>  CONFIG_SYS_CLK_FREQ=3D100000000
>  CONFIG_BOOT_SCRIPT_OFFSET=3D0x0
>  CONFIG_TARGET_XILINX_MBV=3Dy
> -CONFIG_SPL_OPENSBI_LOAD_ADDR=3D0x20100000
> +CONFIG_SPL_OPENSBI_LOAD_ADDR=3D0x80100000
>  CONFIG_RISCV_SMODE=3Dy
>  # CONFIG_SPL_SMP is not set
>  CONFIG_REMAKE_ELF=3Dy
>  CONFIG_FIT=3Dy
> -CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x20200000
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x80200000
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_DISPLAY_CPUINFO=3Dy
>  CONFIG_DISPLAY_BOARDINFO=3Dy
> --
> 2.43.0

