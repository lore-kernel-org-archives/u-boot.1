Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3E4C48BEB
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 10:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F6987BBA;
	Thu, 15 Feb 2024 11:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="BrmyDOB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA7C87DC1; Thu, 15 Feb 2024 11:40:36 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A46E877D3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 11:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehFA3ZFz7iSkEADlux1KFWn9Yi+CkF7/ddR3oqlznGHpwjchUofTQz27ZTPXcrM4dkNyvYPY1aQ/Knibcuw/CnI6ZOIf7BDq8jo8N8qdE4o6inAmff8GeNhboUpiuFiicC2KXpvOGPCa6iiJpTy2zWOff+aiCrZ+v2wXGvCZD1CK1Ldl1ZWN3mV9mrsnFwwD3qauAf7GU1Bch480mjv7X1M1GjM9DK8QF23rh0n+J1E+GzoSq3j3hA1R94utXt9iQ51EhoLMWMa+7JUoYLZR6ZGNflNfwZh3/ibWY6R6YMlVzwq2J3e9PTZAlcSjyjbkmA858uHTpn8OkDo7VFNuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3hDvpnXvZP0xwuHcsDaKmtC11/3aZTeiooZpox1XUQ=;
 b=A97R0nopRbfSDAXFmumVJWVJWOHeAzCYS2CX9nhebaGny2KFdqdYLxL1OQ2Z196l4ADMEph/xTEzYBxdR/2LhnnJiSQifhqJEElOLsOu87QpIWhccSr/fQjfa9FpzsH2gxcE7zlMyVozGLshBRRLYvZzAcSFi/ddXBQIcYns0jBbBBXfkmrUNnD8cYO9EkGb6Jd3CagKqZ/gzVbWDcx7ExyQcoiLIoTDkOcZc2v213/rc77oqbj1BRqm7tmPYfF50mq0i4ChfZjD7BtxaLTT9YdHdWH0mmPrd47WV19xCcTFIzoUh99yBtOttFXfjlP5gH6Ae+tf66QFBOW6yLL/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3hDvpnXvZP0xwuHcsDaKmtC11/3aZTeiooZpox1XUQ=;
 b=BrmyDOB8TzC5bxVdC9ifLrjl6HLyK5r4i2R4uYAtUXO9jfLsL5w43aMKz5Fi/qIwIJghRk7q7u9njwQyBnLd1itctaZ4tAg/t5AGJinUyiJIPPazS8Y6TXVhFUYprZdfrl4kK+nnf5Jk8CkTC1MwoqUSZN6qeUCG+9BsvdCpM3G6CgJ4gUU4ZFN47sh1Xi25HxhEhhgK3myCQzmJcsS3KaCjlDx70SXUWw8Qu/V0BN3+WIHxaXlG1TZ3/v6HQp5Y1JZUeYsV2Kgmyrqb5LrN0WsUcJRgfZLmYyaBtk/fuebwaNoyB/tkShsL9V/V5JI5ZLltOfsuR9xgbW5PYGBchA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 10:40:28 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 10:40:28 +0000
Message-ID: <cdda29dd-3d9f-4eef-83a5-a5f80ca79dcb@theobroma-systems.com>
Date: Thu, 15 Feb 2024 11:40:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] board: rockchip: Add support for rk3588s based
 Cool Pi 4B
Content-Language: en-US
To: Andy Yan <andyshrk@163.com>
Cc: kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de
References: <20240214093126.329717-1-andyshrk@163.com>
 <918dfa17-3c32-44d4-8d16-87bab10cc138@theobroma-systems.com>
 <261ba9aa.2fa.18dac558cf4.Coremail.andyshrk@163.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <261ba9aa.2fa.18dac558cf4.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e55043-c523-488c-6c11-08dc2e1286e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /usbE398Q/gsImtNeYJuDmOvazf/L+QAB52jh5gaeyJc2D3et91voKZpcmSh4F6OUIgPAu7WBGpQCuYT2uTkv6E1VfKGQYcZgRwvbzLTjR19CVpCcmd9f9wFTjFzJ/gsKoTjQs6mXVI2R5UIByEMBrHxBA0hCHv+vld3wxiPW41gsIob3xse49sadQUcJGKkECZbWABxtCp+Fs3lbh7rZ4R+G8yPuHPLQ75CzM4jyF0CMG3pKdnYRAOxh0g3o+ZnwMq4xckaOPRtHsf8n05gnaIs5bdquDnBbrnQPU154BT0ix+1xIW6ajy8qsjzklb68uPXSAvcKWTSfqr6rMNNcs8C3mHhgTQMCGN/u456EEI1T0yvD3O81glelE+dqYK4WR1//gm41W3BFwtdo7Eve+RgiLHhQzx/orkhRPOgcka7hjrMn+Oy2XDz/r4uBIFqCO5cUEMJk6lll2W2596tYkd2L45FkOpCzuYt1aiZgIBmCtzrfEC1W9xjWSxA/ttKfjU3b2etvRILFk6XDdexy4wTDXAs4flr2JDa9ZY06POjPk0Y0OUc4tbq0Bi06CT0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39840400004)(366004)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4326008)(6916009)(5660300002)(8676002)(8936002)(66556008)(66476007)(66946007)(2906002)(44832011)(83380400001)(31696002)(38100700002)(6666004)(36756003)(86362001)(316002)(41300700001)(2616005)(478600001)(6512007)(6486002)(53546011)(6506007)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxqdXZBcHByRGdFb0dHVjBrN0ZHRkZuRkc0OEtPZDZDWktXeC9QWHhCa0Er?=
 =?utf-8?B?SnRWeWpxVndHdUJiN216OUYrQUFGUnNQN2JUdmNkd2hZMU41MVkxYzhNYzRi?=
 =?utf-8?B?akpJSGw1NnhyLzhvREhoR2o1VEFQN2xJc0dEREZvTEd6ZWdLd2VFNlFZTk9B?=
 =?utf-8?B?eFZ6a3ZrOXFWZE0xK2ovWlFrcGwxNm1EMVhvKy9YNEgzWGJlREE1SnNUeXZ4?=
 =?utf-8?B?b2dHbWsxVldxeEZmVnBxQkR5ZFA4RDdYVGlmV0tlNU9hSkc2SE5NbWtDMDMw?=
 =?utf-8?B?OHR4d2dFNmMwL05namd5NVlWeDByQXF0ZHJTTlJSZkszTEsrMWcxRzYvcDBZ?=
 =?utf-8?B?WDBIVUpPcVo4MlAxaE1HWHVROEViUVRubEVCLy9VaGQzMlp1QWpLWURZMThr?=
 =?utf-8?B?N1ByM2pDT2trU1FyZmFRb1pJd2dtVGUxeXllVzBHNmEwTHEyWTY5NXJqb0N2?=
 =?utf-8?B?R2RKWTc4cnAzeDY0dU5lSEZvL0F3TmZFQjNQZ3NRWi8rdlVjRzBYTjBiNW85?=
 =?utf-8?B?dExmSGpBNEtKWXZ4NDdkSXVSZEhyOUp4UHFXUkd2TnVxajlSOUU3SDVJeW85?=
 =?utf-8?B?UVhIVk1zM082RzRSdDYwdStrQVdZMWc3Ujl5Y3I4c0lndjdlNzYwaUt6REJV?=
 =?utf-8?B?bWVtd25JZlpCT2lpRTcwNEt6YjNsK0s4M0JLSG14Q3o5K3prTGlvUnljdEdm?=
 =?utf-8?B?WHQwUnNRZEIzN0l2cXQ4M0hmVlM4OHNqK3k3eWRtNm5lODEzdUhKdzVIMkZr?=
 =?utf-8?B?NExCa3kvWUs5VXJMakRmbGR1QmlnbmtrRGlEZzJGRUY2N0VzL1FZZ0RSdWJt?=
 =?utf-8?B?bkpocDFwa1A1TUNHOVBZN2ljb1cyZ1BzQnYwYzczUjkyUk5Ucis1QlRTdEhq?=
 =?utf-8?B?RkdEblNoQkx3M3BMTnVwVW53MW1oMGdWSW5FUzVUMURkaUE5MFZkR2YzcDEx?=
 =?utf-8?B?WHhFU3AxemdXU3hUQ1lGSFJJOG1ncDc3SE1MNnVwNnpkZVRIdnhhYTVFWGZS?=
 =?utf-8?B?NmR3a3kzSVNrS0E1OHBJWHE5T2R1S285ZVM5WkVGcXFPcUNjaWIrK2liQ0VZ?=
 =?utf-8?B?QkptUEU2TXhMbnJNL2NDN3Y1SGhYaUVVUld2Sm8rUDI4TjdtQmZKTUJqSnhk?=
 =?utf-8?B?bzdOY0dQaWlMbWYvWW9VbEppWmNzNUlicERPUXMwY1hTR2RrOWlIWFRLN2FB?=
 =?utf-8?B?eUl6QitDWmJyVVluTGtaZGJ0OVpNM3hiKzdCSXUyV3lRbUdiTVloTWtTcFBp?=
 =?utf-8?B?dWpOTnVielNVb05jWEFMZFFhSms4QjhxcGhnTjIrNFhtVWJ0L0l5eHZ0UUor?=
 =?utf-8?B?RnNwRC82WlcxT3ViSkFlY0ZrRElDVWtjYi9rdnA3cXlxZUlFN284aTFOWFlE?=
 =?utf-8?B?bjU2a0VTZ2ZScHBMTGZ3MWNrUUI0RTF2aGp5S3V4SDVWRVMwdXdTYXVLNzhn?=
 =?utf-8?B?TEFPTkhoZkhzZXA2UnhCcmltTlJWU3ZaL2hjWERINFVJeENHK1R5OXV2QjJY?=
 =?utf-8?B?eUZoQ0gvLzlHT3E1aGQ1QmhhRGxZMTFSZW8wMmpwczlUQVhVTUZ2SnlHaTBY?=
 =?utf-8?B?NzZTUnl0SnZJWHBxZmJhM3JhT1hDSHpHN3lKcnBxSHJrb0luUXJxR1d0WEdP?=
 =?utf-8?B?SC9MdlJnekFGeVBiRnhMNjhJeWtMbWk2eVd2VitLZzlyTGg0eDN3YXRjbFdu?=
 =?utf-8?B?SXJOVjlkRU51c0lVN2lXRklkQURPa2ZFV2s5dStUcWxqYk9YRkRFc3I5TnNx?=
 =?utf-8?B?QThoTVYxOHB2ZjNvd0VYcE1EVS9NeU1aTjM2ZEhVQjZUTkpaVUFyMmo1cXdK?=
 =?utf-8?B?Vk93MVVMeTlJd29xZklsTUFxY05RbTlNK0plOFNsQ0hoTHJGSllTMGhCK1Np?=
 =?utf-8?B?SFVCZXlQNkdFTURBZlRFZVNqQjFWL1FCZ3hXdGF0cXpFVWwwbGQvclE5WFho?=
 =?utf-8?B?QlloQmREWjA3dHB1SjlvQVdSZ0FMWEE1N2c1V1kxajZ4bzVXeXY0a2dUT2RZ?=
 =?utf-8?B?cUdCanh4UlA4dTFlRVgxa3ZDYXVESlhmMUh0UExpVUFTcnpJa1h6M0dmVlZF?=
 =?utf-8?B?NXkxa0RCOFlQVGtGTDdCR1ZmRCt5OGpMZmhHM0duajFWaFVCbW1zUjlzL2tZ?=
 =?utf-8?B?SStLMUhyd1h3cGI5dVVFek03clhURjgzTmZrUmdKTEY5SEtoa3FVblE3VGRV?=
 =?utf-8?B?ZnhhVjNWV0pDSUJ5QmhCbmRZNHJCdk1nck1DZHNNOU5tb2dnWjdTOEhRVW1E?=
 =?utf-8?B?eEN0MGN0WEtBNnhjYUxyeHNueXN3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e55043-c523-488c-6c11-08dc2e1286e7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 10:40:28.8590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RangBjs5yx7RHzcDREoDBJ+bswwS8KPZL9MHjsM44uIwZLeaDHBJgHw2REK9XpymEvhRGRQaSU7QPnW/BW28sF9bnwLrS4LfnMwcjwL4IAiQn3owu1xhb4HFIpDQCdH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8461
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

Hi Andy,

On 2/15/24 11:35, Andy Yan wrote:
[...]
>>> diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
>>> new file mode 100644
>>> index 0000000000..3e3e5abc86
>>> --- /dev/null
>>> +++ b/configs/coolpi-4b-rk3588s_defconfig
>>> @@ -0,0 +1,105 @@
>>> +CONFIG_ARM=y
>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>>> +CONFIG_COUNTER_FREQUENCY=24000000
>>> +CONFIG_ARCH_ROCKCHIP=y
>>> +CONFIG_TEXT_BASE=0x00a00000
>>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>> +CONFIG_NR_DRAM_BANKS=2
>>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>>> +CONFIG_SF_DEFAULT_SPEED=24000000
>>> +CONFIG_SF_DEFAULT_MODE=0x2000
>>> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-coolpi-4b"
>>> +CONFIG_ROCKCHIP_RK3588=y
>>> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>> +CONFIG_SPL_SERIAL=y
>>> +CONFIG_SPL_STACK_R_ADDR=0x600000
>>> +CONFIG_TARGET_EVB_RK3588=y
>>> +CONFIG_SPL_STACK=0x400000
>>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>>> +CONFIG_DEBUG_UART_CLOCK=24000000
>>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>> +CONFIG_SPL_SPI=y
>>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>>> +CONFIG_PCI=y
>>> +CONFIG_DEBUG_UART=y
>>> +CONFIG_AHCI=y
>>> +CONFIG_FIT=y
>>> +CONFIG_FIT_VERBOSE=y
>>> +CONFIG_SPL_FIT_SIGNATURE=y
>>> +CONFIG_SPL_LOAD_FIT=y
>>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>>> +CONFIG_OF_BOARD_SETUP=y
>>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-coolpi-4b.dtb"
>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> +CONFIG_SPL_MAX_SIZE=0x40000
>>> +CONFIG_SPL_PAD_TO=0x7f8000
>>> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>> +CONFIG_SPL_BSS_START_ADDR=0x4000000
>>> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
>>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>> +CONFIG_SPL_STACK_R=y
>>> +CONFIG_SPL_SPI_LOAD=y
>>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>> +CONFIG_SPL_ATF=y
>>> +CONFIG_CMD_GPIO=y
>>> +CONFIG_CMD_GPT=y
>>> +CONFIG_CMD_I2C=y
>>> +CONFIG_CMD_MMC=y
>>> +CONFIG_CMD_PCI=y
>>> +CONFIG_CMD_USB=y
>>> +# CONFIG_CMD_SETEXPR is not set
>>> +CONFIG_CMD_REGULATOR=y
>>> +# CONFIG_SPL_DOS_PARTITION is not set
>>> +CONFIG_SPL_OF_CONTROL=y
>>> +CONFIG_OF_LIVE=y
>>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>> +CONFIG_SPL_REGMAP=y
>>> +CONFIG_SPL_SYSCON=y
>>> +CONFIG_AHCI_PCI=y
>>> +CONFIG_DWC_AHCI=y
>>> +CONFIG_SPL_CLK=y
>>> +CONFIG_ROCKCHIP_GPIO=y
>>> +CONFIG_SYS_I2C_ROCKCHIP=y
>>> +CONFIG_MISC=y
>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>> +CONFIG_MMC_DW=y
>>> +CONFIG_MMC_DW_ROCKCHIP=y
>>> +CONFIG_MMC_SDHCI=y
>>> +CONFIG_MMC_SDHCI_SDMA=y
>>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>>> +CONFIG_SF_DEFAULT_BUS=5
>>> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>> +CONFIG_SPI_FLASH_XMC=y
>>> +CONFIG_SPI_FLASH_XTX=y
>>> +CONFIG_PHY_MOTORCOMM=y
>>> +CONFIG_DWC_ETH_QOS=y
>>> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>>> +CONFIG_NVME_PCI=y
>>> +CONFIG_PCIE_DW_ROCKCHIP=y
>>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>>> +CONFIG_PHY_ROCKCHIP_USBDP=y
>>> +CONFIG_SPL_PINCTRL=y
>>> +CONFIG_PWM_ROCKCHIP=y
>>> +CONFIG_SPL_RAM=y
>>> +CONFIG_SCSI=y
>>> +CONFIG_BAUDRATE=1500000
>>> +CONFIG_DEBUG_UART_SHIFT=2
>>> +CONFIG_SYS_NS16550_MEM32=y
>>> +CONFIG_ROCKCHIP_SFC=y
>>> +CONFIG_SYSRESET=y
>>> +CONFIG_USB=y
>>> +CONFIG_USB_XHCI_HCD=y
>>> +CONFIG_USB_EHCI_HCD=y
>>> +CONFIG_USB_EHCI_GENERIC=y
>>> +CONFIG_USB_OHCI_HCD=y
>>> +CONFIG_USB_OHCI_GENERIC=y
>>> +CONFIG_USB_DWC3=y
>>> +CONFIG_USB_DWC3_GENERIC=y
>>> +CONFIG_ERRNO_STR=y
>>
>> Is there any reason for NOT enabling MMC_HS400_ES?
> 
> No, I just follow the config of other rk3588/s based boards.

Fortunately enough, a patch was recently merged to have at least HS200 
on RK3588, which is the first mode that actually works, anything below 
that is broken right now.

> It seems that there are no rk3588/s based boards enable MMC_HS400_ES in the current u-boot mainline ?
> 

Jaguar is hopefully coming soon-ish, maybe not in this release but the 
next one (patches are sent already), and we make us of it in U-Boot 
proper and the SPL. Up to you, can always be enabled later on.

FWIW, both comments on this patch also apply to the second patch in this 
series :)

Cheers,
Quentin
