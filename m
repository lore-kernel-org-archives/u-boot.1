Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C18C19F32
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 02:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AEE980F70;
	Mon,  3 Mar 2025 03:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sTQd9+b3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A7E9810ED; Mon,  3 Mar 2025 03:56:10 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A68E807B1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 03:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2jkVG1NQeNex4ELl1/k9RDbS5jgd5fPTb4MJXPz0TJi3esOxMobG9V0XwlFn/9k9dowP4wHuFHKNVG3JWY6kSFpVz6BlgQrmZ3K9+I3KReBR+eM2IreVhYpuuVlqOS2erMiaAzKXnRJcuvItS/ftCmpTiHkSafQM5HgypPUfJWrr9ahYsQ/1vspXt8+YEfajgf+N33pzCnuHW6gaFGVhN8hXzZ75garrykDRcOTdQdRpJxPVUHP6P89uRfxqU18eSX6RFmM+XkqoPDhYC9nua9Rir5jDYwXeoBdW8y7mArEH2RxUZeIjVADvBAVetD7DSwPL5Lv45sgXg52c/+D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASndd7SXfNnXwZt68/IXtbUwhRo1iGfGFulQVbc/D5M=;
 b=V/ieWOGb/fefY9EfjWYsjEHMdk3x+mwDLrYOkAuS0I/sVTHOdJvB9YDB04m+zjf3WXTp0KuFs1EavHN4qDklNABQVndnu8BsZOA4FLWe7rBD1TbtuA7mRKvcNPPzHien90PIeCs1dt2Vt7m2nK2UejXnD/SWPEsCxThB7epebSVughjzHTIShJOgQ1/GjlOqBdDsURaOrJueBLh29VsmIURpYvqCzW3q66eFCdLMKaXF8Jv5z5qqP5BiN8dySvpaOiFEvTRbfYGKqUacajCOoQEQqIz9zuNPc5zxmTZ0egJllRaDvVKzrkept4P047TuogjPjL47J3Bw4AvSj03AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASndd7SXfNnXwZt68/IXtbUwhRo1iGfGFulQVbc/D5M=;
 b=sTQd9+b3EVBSbkP7gcIDOb1iIcJ1C9631T3vk/V/nr28vZc1JWAoBRX7wCsQJaRr9eE8OTVjW8eg+rCm5bSO4kWRLniuTeAJBjFxLM0Cs4eXwmjvSeBrMusfFY8IuAGjn/kxPXiZ2LKa9OsCzOiyephIVGB3gEh8HB+Vl/a/uS4rENkKBweFkR3Csm77MRLkSpIfbU3I47W/YAdlrjbjHxvzmvgm657hFE1JvNec0Somw/dHhzkjzejtHevwS4zpk30kLuBnxmw+xaPbxQuuRVMs3QjpIlrS0mnCI/x3g1XMiqypmE7uT+EJ7zUF/hIzqlEdwmvCc7xaJY72jTSliQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:56:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:56:06 +0000
Date: Mon, 3 Mar 2025 12:03:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Benjamin Lemouzy <blemouzy.ml@gmail.com>
Cc: u-boot@lists.denx.de, gaurav.jain@nxp.com, trini@konsulko.com,
 Benjamin Lemouzy <blemouzy@centralp.fr>
Subject: Re: [PATCH] crypto: fsl_hash: fix flush dcache alignment in
 caam_hash()
Message-ID: <20250303040329.GA13236@nxa18884-linux>
References: <20250221070501.19472-1-blemouzy@centralp.fr>
 <20250228041756.GB30605@nxa18884-linux>
 <20250228090028.6fd81ea9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228090028.6fd81ea9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: a58ac14e-790b-4af9-adca-08dd59fef16a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eAElk0Vk4gciywJmGGNGLeHPdRZ6EDGI7yp0v/vqXiY3E/Ce4syU7GBPvlG0?=
 =?us-ascii?Q?UJ7AupHHiYkXv8u7OIEckSwgqcrLnjJvH4yguex18jPvClkeyKrzkGQdqRG7?=
 =?us-ascii?Q?MMtIUD5eCwcq3Tbp5RIwTus1aJOYDXjuEMLEhzSlwleIGqw1N/3+Zht0Mw46?=
 =?us-ascii?Q?J91gzFnvv7uMHmkQGUy1fQcvtEXNSc0MRHYAbtfzqd6QL7RBgwML0xOfWO7U?=
 =?us-ascii?Q?aCetJKLcGoDnN3WTVkx9kGjeOVpBCsuk/p7+ZPy9s6/WifS3BNJgCJ3vDcPx?=
 =?us-ascii?Q?ZjCq4BSrqQV50aEQQ7Vyj5mjYl54rYZA9H9ayFEt1J384/s/MDJVX6tnav9A?=
 =?us-ascii?Q?L+cnd/gIEApw/tGVA9DXqJ+tqcIqCTxaLbkdOdyMAeXe8EDF0c2ZCDJ+bsdr?=
 =?us-ascii?Q?tBBdZjy8qEt54qvf15lsZCZIBVSxr+5Brw5Qa1c9QJagmy/5m8WnZkaEwRmw?=
 =?us-ascii?Q?6v3bFbS1DVomdIAVmnccfxcrUPdcLe3ej7i34LDUJkIgU62RxFHFe08I3Ztt?=
 =?us-ascii?Q?qaYyesQ6RdEX4PGkpOR86s5BAmcpWzpyZWMwslOj7XtU93uB1+TYFDvKkV5D?=
 =?us-ascii?Q?2lhmyHjrM4mrIMHCHf7x+Cu0qdN12kEgAUGopliCRxQkswTXwuBhPnJ5WmVE?=
 =?us-ascii?Q?4kXQR6439C3fLRXjsxUflm0yoNO1KWalLEghqEPpgwOsoS3IIjLdrJVcQ+Fy?=
 =?us-ascii?Q?qt8n4e0DPG2wsvRW4MphVRy/4LxgEiU0rKYQSuAvdyMgROYrbrbhsITxPr/l?=
 =?us-ascii?Q?hkctvIoDwN09BFgTBdFagbURjpYGZ+GiaXYzA/0pBwQteMI8EFBZcL3Jppjv?=
 =?us-ascii?Q?fs/HSKYE0WHye0G69fqoxLyeHOmswOukgQXDDkor94FkNlXMhMEnLkkxL6eF?=
 =?us-ascii?Q?Um1tAaY/Q2sSjIhT6eT5oEd7QKQyWaFyreOXDDvf5HPI5Xrk84meVkku1/7z?=
 =?us-ascii?Q?oaeYIhTg0AJsS5rw1KRI4xi8kOaGMoeVGAaCvpecEoR36W7PqZtNOly4b498?=
 =?us-ascii?Q?uzeOnKN23RdspJlLzhUoWWhBzvr0adjk3cY2ABEOoW9EmLaVytVhSD1AgSPU?=
 =?us-ascii?Q?jjWbmjbItX/hqVM35dQeibE8FudtZGVMLaHts/FuHu7dHEZU1SmKeYVrlsBd?=
 =?us-ascii?Q?8+8IhBH7H362+lN5ePsAuXKCO1+4LiyqqK4nQPuK8vKMi8+6zHVymTsajyOl?=
 =?us-ascii?Q?uACJP/Ds/gmIwc7O2nHoWYImAc8AvLVQQIZxg38p2GX6Bz4obbP1rfnW8zAx?=
 =?us-ascii?Q?RdQTcCFF4DnWbQ7pIij6kfgh6z/MMFOLEozrmcSlXUO8JuWeqNBDqDuq3icu?=
 =?us-ascii?Q?0npyXuvGPtnZ3JcPYJXMb0WZTI2d5xAwRFZ0qUmtDOncHpwcip14VWdtx2rH?=
 =?us-ascii?Q?E8oXjA7R3x1QajVj25BSpQxYmyhxBIFh7WeEBCRcMvmiVdVi5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TrszCbZzPwNgaWd72oPDFefGchvgN1JB/u5njohgGu4X/aE8OcNBq7cDqRoC?=
 =?us-ascii?Q?qSjSBVRqVUNoOPA4Q5D/IclQ3DJpdEYcr1PeaLm2eeGBeoollSNwn4Z9hLs9?=
 =?us-ascii?Q?vswJHfM1LXXpQnEnDyl0Jd2zm+GuDDsNZf23Zch4zyDAfcMVoU+LduXBlmcR?=
 =?us-ascii?Q?jR4Ij+viPy/u7d7Z6YP9GKd95hQPk6m/1YI6/35G7GsNrrcwj1x0WucMrinh?=
 =?us-ascii?Q?wrNHGbBNY7fqVgOtcMD4F7EdQsrNG8fKM6KsmLqt184Inwy7YfC4QuAN4lTE?=
 =?us-ascii?Q?5DlnY+6tanOtHchTjW2dsagZ3BcgTP4A2PiKV8ek6uNRc1UoYCDjOwlrXoIL?=
 =?us-ascii?Q?+4df8hvshkGhb5QhC1tm6I03nqsfVQedfd1IAMKgmTUdCGwUhPpB3jFc6PKi?=
 =?us-ascii?Q?WHwBh6fF5SdRww/cjEuJS7HRfAg84hxI/8BZwtdY7ZKrkKiDmPoLDs5Z0CT1?=
 =?us-ascii?Q?YJnc6DRqCjsg7anNvn7Wpf3Nu0oie710/Uu9qCzqfaBJuAVH31kYx+HKG1/1?=
 =?us-ascii?Q?yi6Sd+nu13HA6+7bWNs+NY/YI5dAhLtUrXi6zUOGqJO5z8RoZVd/N4C9Fuey?=
 =?us-ascii?Q?GAyjeNB8I4xhaEEeDELvyIWSWlkm/IimrxYlg92T0fJqGCk9JypQ9TX8pg5D?=
 =?us-ascii?Q?jDP+tR6j/VXUS6ODAWfdR+nSOGTxb6qtl6EMt9tlKZQrGMEPoEiQVI7zQqfd?=
 =?us-ascii?Q?Iw8uu7QLwYjv4Ez4O4iqOBUHHfZZPDTksyjb9FsE6nRSq10qZ6C+uiPtbrZ3?=
 =?us-ascii?Q?cCrJSSU8jqZwPgDR46LybP1H0MursTT8auPVCaK+PcHVjeoU2c4/5Z1ZF4qk?=
 =?us-ascii?Q?gxwoYYkcY+jzKb7lHbIuVqoGiyOklGfJcGM9i+M9MLqhs8DTQDoloOJ7ExzE?=
 =?us-ascii?Q?tRk7yWoNoiWgkGGfI2LLv+xX8XfYirL8Age4uklBdyeBFec9e0uz6w/l2kGC?=
 =?us-ascii?Q?02xMEFysb7My19lSLOYkXevaTFbvk+6BymJggqYeEyW/hv/R1W9zX8cr2rNw?=
 =?us-ascii?Q?+9alzzfCEeqbHPAJGfTrrRhcU2KXfnTkBifViXJJHCJ8Asi4sBoeF1ZmciVz?=
 =?us-ascii?Q?1kF6qBlL/g5mEVQ00gW554ivlBxt2z+8VKqCB1ffKgcv2eg9KeaMpdgXfZWK?=
 =?us-ascii?Q?SYYtATVukW90e7E4CnaEjiYDX56q3q8WYneC1UZQLs9TKCS8HEhZIZ0wc7Wu?=
 =?us-ascii?Q?bVrchv+ItjcIzfKEp86xhFaTAPhhgKbRKWxqJn+25h5eXjjk52hFRUq2Ni/d?=
 =?us-ascii?Q?c6dGHtixv7fNPQNwXQR4gWYbB9ZBVyvazcy62Gh7KazSY960ejMSRItPNCID?=
 =?us-ascii?Q?P4o5RL+Kc6KY3AvlI9icsqaG0kcO6PNeQb2Oq7HNaOYjXjEIczjx4ReNyYgg?=
 =?us-ascii?Q?OSSWOxbE4E8JpLB5DiKlrzLpKtEbcVF6q3s5k2kiPMlvMAtnXY8IDBS14FVT?=
 =?us-ascii?Q?7r5H+s7pEPdboyPfG6xvxwDgx/jAZchHKGqbRPqjmDiZfFpPuz+6shk5WRWM?=
 =?us-ascii?Q?9BBrfpulwaG/qVXsvkaDKQM/3hBXC0GSE6lGiTSVzRgxO/hwrz0k99FEmQu9?=
 =?us-ascii?Q?n0eQB61VJ9/uKdRPtNCXpxs4/cIc4uk1plIjCVLw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58ac14e-790b-4af9-adca-08dd59fef16a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:56:06.5033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D19lHY+G9X3wWNdQ5l3cQ+mjBn4BQ1zvQIcUMQWo+8HHVU8TtP2iGijwoUZCSJIZMlZeRbBnBcALZSDCu0TEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
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

On Fri, Feb 28, 2025 at 09:00:28AM +0100, Benjamin Lemouzy wrote:
>Hi Peng,
>
>On Fri, 28 Feb 2025 12:17:56 +0800
>Peng Fan <peng.fan@oss.nxp.com> wrote:
>
>> Hi Benjamin,
>> 
>> On Fri, Feb 21, 2025 at 08:05:01AM +0100, blemouzy.ml@gmail.com wrote:
>> >From: Benjamin Lemouzy <blemouzy@centralp.fr>
>> >
>> >Loading a FIT kernel image with hash hardware acceleration enabled
>> >(CONFIG_SHA_HW_ACCEL=y) displays the following CACHE warning:  
>> 
>> Sorry for my lazyness, the following patch should be able to solve
>> your issue. I will prepare a PR soon.
>> https://patchwork.ozlabs.org/project/uboot/patch/1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com/
>
>I just tested the suggested patch and it's not working:

Thanks for help testing.

Thanks,
Peng

>
>	## Loading kernel from FIT Image at 16000000 ...
>	   Using 'conf-imx6q-xxx.dtb' configuration
>	   Trying 'kernel-1' kernel subimage
>		 Description:  Linux kernel
>		 Type:         Kernel Image
>		 Compression:  uncompressed
>		 Data Start:   0x16000128
>		 Data Size:    7600544 Bytes = 7.2 MiB
>		 Architecture: ARM
>		 OS:           Linux
>		 Load Address: 0x10008000
>		 Entry Point:  0x10008000
>		 Hash algo:    sha256
>		 Hash value:   a664f6c4d4ac97e2d867b8ee4f38cf934a48f99c65f19f824162b7ca077cb0d9
>	   Verifying Hash Integrity ... sha256+ OK
>	## Loading ramdisk from FIT Image at 16000000 ...
>	   Using 'conf-imx6q-xxx.dtb' configuration
>	   Trying 'ramdisk-1' ramdisk subimage
>		 Description:  ctp-image-base-initramfs
>		 Type:         RAMDisk Image
>		 Compression:  uncompressed
>		 Data Start:   0x1676d6d4
>		 Data Size:    12635898 Bytes = 12.1 MiB
>		 Architecture: ARM
>		 OS:           Linux
>		 Load Address: 0x13000000
>		 Entry Point:  unavailable
>		 Hash algo:    sha256
>		 Hash value:   e1fe9087261f33679b95cd82b387317fa31b58f6365406fad1df1f27d46923e9
>	   Verifying Hash Integrity ... sha256CAAM was not setup properly or it is faulty
>	 error!
>	Bad hash value for 'hash-1' hash node in 'ramdisk-1' image node
>	Bad Data Hash
>	Ramdisk image is corrupt or invalid
>
>Benjamin
>
>> Thanks,
>> Peng
>> >
>> >    [...]
>> >    Trying 'kernel-1' kernel subimage
>> >    [...]
>> >    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
>> >range [16000128, 1673fae8]
>> >    [...]
>> >    Trying 'ramdisk-1' ramdisk subimage
>> >    [...]
>> >    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
>> >range [1676d6d4, 1737a5d4]
>> >    [...]
>> >    Trying 'fdt-imx6q-xxx.dtb' fdt subimage
>> >    [...]
>> >    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
>> >range [1673fbdc, 1674b0dc]
>> >    [...]
>> >
>> >This patch fixes it.
>> >
>> >Tested on:
>> >- i.MX 6 custom board
>> >- LS1021A custom board
>> >
>> >Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
>> >---
>> > drivers/crypto/fsl/fsl_hash.c | 6 ++++--
>> > 1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/crypto/fsl/fsl_hash.c
>> >b/drivers/crypto/fsl/fsl_hash.c index 79b32e2627..b721c86609 100644
>> >--- a/drivers/crypto/fsl/fsl_hash.c
>> >+++ b/drivers/crypto/fsl/fsl_hash.c
>> >@@ -183,6 +183,7 @@ int caam_hash(const unsigned char *pbuf,
>> >unsigned int buf_len,
>> > {
>> > 	int ret = 0;
>> > 	uint32_t *desc;
>> >+	unsigned long pbuf_aligned;
>> > 	unsigned int size;
>> > 
>> > 	desc = malloc_cache_aligned(sizeof(int) *
>> > MAX_CAAM_DESCSIZE);
>> >@@ -191,8 +192,9 @@ int caam_hash(const unsigned char *pbuf,
>> >unsigned int buf_len,
>> > 		return -ENOMEM;
>> > 	}
>> > 
>> >-	size = ALIGN(buf_len, ARCH_DMA_MINALIGN);
>> >-	flush_dcache_range((unsigned long)pbuf, (unsigned long)pbuf
>> >+ size);
>> >+	pbuf_aligned = ALIGN_DOWN((unsigned long)pbuf,
>> >ARCH_DMA_MINALIGN);
>> >+	size = ALIGN(buf_len + ((unsigned long)pbuf -
>> >pbuf_aligned), ARCH_DMA_MINALIGN);
>> >+	flush_dcache_range(pbuf_aligned, pbuf_aligned + size);
>> > 
>> > 	inline_cnstr_jobdesc_hash(desc, pbuf, buf_len, pout,
>> > 				  driver_hash[algo].alg_type,
>> >-- 
>> >2.43.0
>> >  
>
