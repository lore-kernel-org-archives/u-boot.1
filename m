Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46A7FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265E1848BB;
	Tue,  5 May 2026 14:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qzdIzWVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A99084687; Tue,  5 May 2026 08:39:06 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84EE98467F
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 08:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoUQtBZKYY6ik7v0B4sJ731hEA0LVGyp8oh5/kbftZmgTHs8MEA6VkqqYPsqap0+h7Ot/Dtr1BSMx9sazzNbamJlxT21DDPqIPejs9v0qg9wdy7fGyHmnNtUrbeUa/93JoUeCClPZXAsONJ8FSyXSVEuTl3inkEMdFAi/+10LoxaWb5M9DY1BGnpuecJ4rJOges1n/tDcu/MC6wPYjUotgMe3Pq1jf8sKeGlYRAt2LRLKcL3zONWH+7gV/zQtjEv9I5v9IKFO/dgwgBAM7G9OYgmBJEN2qSIxwdLS49n4PS0x9RoBCBZ7BY0jEIeMER3Oq+8zRQiKuv45aSuxka68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rK153xEW/fVXKUTBsY40U5haAWn0wc4y/JJ2D1JsFk=;
 b=ruqBuVcxPCotDGOiiAAtNPjmPvDbvlBuQA9zZjnziUx5U/Lg/wV01pA7ng+dpL/NHLrVre6mkpoGOcdtv8dF1K7EBfzc32wxCNl1hPtDtL7vRZDzoMEjH9OQ5P5qqt4EhUG4cgTUDryqdFYQMVpyWCVnna6hWZA3GowlPkLT/aharPccvXfMW6Qujf40y6FvBhVgX7DNhZ1pO/yr0Purn2RTaJBjcQs7oQ/W1pzqXt8g93+vGjbCGqGKHP25Zg9doYF7Zf73cuihHYtP527VHVj9+gBxluthdlIQUx1B/ZPfQK3ufYrbmxzMb3nBjtqCJcXg2G2eifdKW7+xl/0A9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rK153xEW/fVXKUTBsY40U5haAWn0wc4y/JJ2D1JsFk=;
 b=qzdIzWVRHRFUgnO9U8ulbJqxPjqJupWpt3HnRQD77B/ZXe93o1+MJWnRj8QnxSjW23aWPV/UlpOxiR17rhK1ODcTxX6KSBYO2hwCMR/ZBhzt6e7qV9VDVI1KoMxQPwGrRihbXm2Z8MvzghtE64ZJ5hZRWkbfKgqJ90cCOsMLNnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 5 May
 2026 06:38:56 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 06:38:55 +0000
Message-ID: <f689d6a3-bd51-4fbc-a534-a89228b00ab9@amd.com>
Date: Tue, 5 May 2026 08:38:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: michael.srba@seznam.cz, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-1-11817415d664@seznam.cz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260505-qcom_spl-v5-1-11817415d664@seznam.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b9541f-5c7f-4884-c634-08deaa70faf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qgdlSeACA7fRnCOFo+KFew6GHue7OsvakVI6uorYMDKDXwDb1SuusjUYHmC9bx81ErFI/L5+HzViT/7ZuLPIG1SBodbORMfWd4l11fhxrsWeKGYeqFj09QUmMI4L+p+OhVQrOGdz+M5TBo2SLRuGHb24l9R+OWPCqQNDPtJ0PKQAWuXNViEWJWfj0Al86/E3KhR8vnPK9R76lulfQtYCxm77RyTlmN1vcBQEmgo8OzwzTES48NIIXg9GCKHwvUUWXK2CxKeLkC/cdlWx3nkOIqSbcYJS6maxPl3nV4wWNBFtUGyA3HV/QZ7mkZN5TRQyhyOfjebh7VbPq1TD0ILoQgcONTm6iiLHmCx9DkkkAYfYhIKfYZgyIpae8FDj60hho/ZDneqLu3GfsNm6Sm1ab0eOgQ07yGguuFHbAO8qnM0FMTCGn0777nRN0BRbfp8IfpKIl4rfMaCJNXJltfuVixzJUTYueI6v6CzoiDHbylufFmtHpAB19fzOnRdhMbP8PzAJkKUMeN/YgvH3tWm7DGnJ12O1JordHsm4T598zxcOKIaYRpU4ElCTmZADxgKfRvdd/rXWm8qrDvkEXwPy9MaE9so4cPa4KOcHRL29M+AMNQAoiKeXq1OgKqwjUyHdA/DOlC28pPA0q4+qa0Ln7Su9FZ67nICIYGwqm0LuIFeb4hp98Q1TEqFZfPiczz95
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpUcjJnais2M0JVaU9ZeGloZUJSR1ZnUXhycDk2S05LREZ5ZSs3NjRrc3dE?=
 =?utf-8?B?blF2Y1l3U1g2aEp3NE9RR3J3OUlFYUY3Tk8weElBWUdPMVo3OUJ1RGlxUy9P?=
 =?utf-8?B?ZnZ5cTVYY1VTU3hDSmM2Yk93alVSQmRoQmovdzkwbHRySTZHaUtONHJDaUR1?=
 =?utf-8?B?ZnNJU3VCVXZjR1llWlZCS2NqcUNTaURKQ1ZjMEdhOHBvdnpaSXVjcW11bWVl?=
 =?utf-8?B?QzVsZk1GM2k2RkFFR1JLcERwaEUrWHJyWFZrTTZRTWxQZDBReUo4ajQ1R0M5?=
 =?utf-8?B?c2hVVWtDWDRHaHhBZDhLMEhxY0tUNEszM1BsUVBSMFlJQWk4V1RBeWpjbEdU?=
 =?utf-8?B?aGkvTTlaL0lJbEJVdERUZStVUFk4dEsvaWpiNVo0VDZSZ2pyMTNicVNiVTE5?=
 =?utf-8?B?UDFTaE5SVHhCcWZuUGxuUnhNcCtxTUNTbmh1bC82WkQ5N2lycDF6RktHek5J?=
 =?utf-8?B?V3VNTFl6N2ZPL2k0WGVmeTZ4dWRVMVdSVHcxcmNxRWliSDF0YWhpdUN1emRD?=
 =?utf-8?B?Y0lLYW5tYnhDQ2ZzKzhjcW9TcU9DVkFiLzJaZVJRY0lxeDE3ejZ4VC9INjhh?=
 =?utf-8?B?Tlp6d3drRWdFdm11SlMxZ1JvR1RZSHhGWGZHTnh1blVvanE2WjI3Q1hqeml4?=
 =?utf-8?B?RTNkWnFHZ09qZXNHZG42bGcyRW0zbXhrM2llWHpGZUFpcDhGL3M4YTJienVB?=
 =?utf-8?B?TVU4bWJrVG9Yd3ZtUlBkalB1K0ZSM2FkS2dCQk9HMk9GVTk2bHc4blhJeFI3?=
 =?utf-8?B?Lzhnc3NNYjZaZjlYOTR2aUhOQ0RPYnRZaGVraEpHbGYyN1hvQXZyK0tkUkwy?=
 =?utf-8?B?WmxLZkh3dlRHR3R6QmtaMFFJM285QnlOQzh4ZGpXU29JRTZWMk9HczF4ZWgr?=
 =?utf-8?B?SnpQUUtyd2pZUW9IOTM1czREMlZLZ3VjcnB0dkxiTGdhaFFQWHpjeGZ3ZUxQ?=
 =?utf-8?B?a0lwRDFOblRObERPbUdlb014S1hKNlNWSlNFQmFJRDc5YmNrVDJQaFVEUVFh?=
 =?utf-8?B?d1VMbzdtaFc3VjROY0NlZVhLRHpSWGZITDhpWTFtdVh6SEszWERwUXBndm4y?=
 =?utf-8?B?R2trbHc4SzFUeTFTblE1WllIWDV0ZFo0dEhJM0NseGdLYW5rdm5FRjNXSzlG?=
 =?utf-8?B?dUt5RnhrdWRZS2lFd28wTmFJOTZDR2sxNFZTSjJxcEw5a3pMbTJSbEQzbFRG?=
 =?utf-8?B?T1d3eG5TbWh2cTRGc245N0lrT01EZ080VEZtUk5uSUhJKzQxYUViUFQ3Umpa?=
 =?utf-8?B?ak5VNGdxSkJ3aWhad0czbSt5MWROTytvZyttSDZHaFdZTE9wZHZXQ055RFcw?=
 =?utf-8?B?cDIrcjVva3MrTEJ5WUMwd2VEdndueUczQ2YzQXdDNFJKQU1oQ0NVQTNiTHNj?=
 =?utf-8?B?dlZ6YkNCbUF1NEk4TUkxNnFhU1JHRmF1bldCc0daV1J5K0ZaSWIwMDM2c08w?=
 =?utf-8?B?SHUxVHNDVXQ4WEJYSkxhQ2xjL1VCUDRmaTBSdjcyY0lLV0FxYnNoRzVEKzNz?=
 =?utf-8?B?R0JpMjNXTGV3aFN2Ty9CcHFVWEJza1ZwQVFyNU1DTk1XWGVWSjlFK05LYUpY?=
 =?utf-8?B?bExwYUVHazVXR0tDSUhNdEpKaXROcVgrOWMxSzFscGo4N2ZLYkRkek9xc1A2?=
 =?utf-8?B?cnYrdnkrdG1UeDR6dVhDWE1tYnhiTnp5dDZ0NkVVM0tEYUdlaDFMY1FtelZM?=
 =?utf-8?B?aU9QZi9oVWxnSjVsakUzSis5WSsrQ3ljeWlLdW5CZ09NWDNJQytwV1dkT05E?=
 =?utf-8?B?R0F6Q1pOeGorNzR2dXFydFhncU1QK0xqWmJhd1l4eEtoc1Z2bFcxSSs3YjdC?=
 =?utf-8?B?a2J6WkRwTEFmMmF0anNJUjZwRVRObWZZVjduOWdBaGF1dGFySkVzN3dKeGQx?=
 =?utf-8?B?dzczU3I1WWVCN3dqZ1NEV0tLSFRKcHFxdWtNOGM1dXkraVJFUVNWdDJKT2Mw?=
 =?utf-8?B?ejlEZDErdFhZRklnajZmenBQTG9ZZVQ2Yk53aTRrMjFiUXdCY05wSmFvWkZl?=
 =?utf-8?B?T3c2b2xFc1U3WEZzbHZHQmZnMjltOEFSVjZueTN6bTc3S2RqQXdhL1diYmU0?=
 =?utf-8?B?MXdqZ01raFJ1dTBVMjE1eFVibFl4NlhWblc1Y3VDV1R3YlpoV3lLSDJQQnFD?=
 =?utf-8?B?RTZJSG9Lei9qMW96VWxnTGh5cDVLQUJyaE1jKzRwTGR0TGRvYWsrbzl4ODlG?=
 =?utf-8?B?WHpzclJmaHowMHJMMk9nbHQ1MmdCckhwT2QrRmRMYm8rdkpZNHFvampTaEhq?=
 =?utf-8?B?VHY4b3lUc3d6MDhoOG9RL0JSdGVZUUhrV1JEV2JQWmUrcFZ2Y010WUpyQ0FY?=
 =?utf-8?B?Sk0zZjc5RituOG1qaHNyY0JZc2dvU0YvY3JVVGY0Zk9KbklwMTJVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b9541f-5c7f-4884-c634-08deaa70faf9
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 06:38:55.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miGKnkf9Q5/caz8AdYeCUiDH/4PbdJhf5bxk8FVn9w3KXWHTxsslhMc4GT7Cps+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
X-Mailman-Approved-At: Tue, 05 May 2026 14:19:35 +0200
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



On 5/5/26 02:47, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> Some platforms (e.g. at least Qualcomm) use the ELF format in creative
> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
> as the default).
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>

emails are lower case only.

> ---
>   Makefile           |  9 +++++++--
>   common/spl/Kconfig | 11 +++++++++++
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 49d9740327e..8fe722f6c0d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2008,12 +2008,17 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
>   quiet_cmd_u-boot-spl-elf ?= LD      $@
>   	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
>   	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> -	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
> +	-T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
>   	-Ttext=$(CONFIG_SPL_TEXT_BASE)
> -spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
> +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
>   	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
>   	$(call if_changed,u-boot-spl-elf)
>   
> +SPL_REMAKE_ELF_LDSCRIPT := $(addprefix $(srctree)/,$(CONFIG_SPL_REMAKE_ELF_LDSCRIPT:"%"=%))
> +
> +spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) prepare FORCE
> +	$(call if_changed_dep,cpp_lds)
> +
>   u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
>   	$(call if_changed_dep,cpp_lds)
>   
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 5fa94098e49..08a4d2a75e9 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -238,6 +238,17 @@ config SPL_HANDOFF
>   	  proper. Also SPL can receive information from TPL in the same place
>   	  if that is enabled.
>   
> +config SPL_REMAKE_ELF_LDSCRIPT
> +	string "Linker script for SPL ELF"
> +	depends on SPL_REMAKE_ELF
> +	default "arch/u-boot-spl-elf.lds"

When is this file defined?

I have CC'ed you on
https://lore.kernel.org/all/aa144c8002ba86154dcb62624a1d9d7cbe8c2cdf.1777962845.git.michal.simek@amd.com/

when 1/11 is applied I am getting.

[u-boot]$ make xilinx_mbv64_smode_defconfig
generated_defconfig:59:warning: override: reassigning to symbol DEFAULT_DEVICE_TREE
#
# configuration written to .config
#
[u-boot]$ make -j8
scripts/kconfig/conf  --syncconfig Kconfig
   CFG     u-boot.cfg
   GEN     include/autoconf.mk.dep
   CFG     spl/u-boot.cfg
   GEN     include/autoconf.mk
   GEN     spl/include/autoconf.mk
   UPD     include/generated/timestamp_autogenerated.h
   ENVC    include/generated/env.txt
make: *** No rule to make target 'arch/u-boot-spl-elf.lds', needed by 
'spl/u-boot-spl-elf.lds'.  Stop.
make: *** Waiting for unfinished jobs....


Thanks,
Michal
