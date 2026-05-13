Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C56CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD2A845E3;
	Wed, 13 May 2026 16:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Pa1dH4wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835F084676; Wed, 13 May 2026 16:31:41 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DE28341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6d23/Iz4QCRTLLKJylZp0fvzldxGPxwppBjmA+04nUH//HfvmItYO70ZH/f2ZX6df8lOGr4Om2BAEyTbWydUi1xeJebHwmCKVYRvzxooLSMmyK99MBLbVuSxssyuK470EVOFzDmlXSBPYgDvcQVb6IWtZQ0mgpsUZ+RqQqYvr9wUr6LynjyGYTCzGgnjxrusN685fX8yb08APt8yMW6giTQOeFrlaCU85P+prYqswOE38yudu5zubWyYFI8D/uGtZFmh1QcN29DLfSajHV6EyTAXuQ0S5Viuku0Wq+V3wwcT5rU3nQA/egMinoSIrG/4NMSrH+0KKrW5TnKUK618A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eE+fljf4xoExgf9KiJ0PBrUMx6+rusGEY2C+rRe58w=;
 b=ijkyD/zvY0dKZffrArXwETEo7KNYbbRHm/ea/AEqHdLpeEYczyXoo/hEUAycEeiCipT05bW7q4L54xMRTxa7wdwdvfPFUY0o0n1d/vhszsOhhwyxWCjFLFZWQxD+99P3yqUtFe5u1w+uj0/SMCu7dkNDURt7llSPrrtiD2BY+10T9o+wC6M1YOi2VUhv6GLJNOOTqEFwSOrKelIkj0bvNue6J22MJu74jL2rHpzMrCEn9EhWuzbFBySgTwIvOrNphIzVHcHokbIMQWeobSTOHOD5mZu1k9KlfN4+KfhtHVlrm+oiFeCSwR7xz5UObPUY++/jHPystrxqlXSIzDqtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eE+fljf4xoExgf9KiJ0PBrUMx6+rusGEY2C+rRe58w=;
 b=Pa1dH4wrcRBZP8Dr9W6CqoqZMDD+LsLIVx1F7MtiPVfJMQICwCEStVYeOKoBnjI4gm/zsQJ8DM8ujihopLU7HdrOaPrzijxjQhfHS5nqccsI8ToOUDi4yX5sPjoNC/mwzJovOi/Gk8dY01K3NE+mXUSU6U44lqGKGpkYHV7917M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB10150.eurprd04.prod.outlook.com (2603:10a6:150:1c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:31:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:31:34 +0000
Message-ID: <3f588517-43bc-4b11-8ccf-d51cfa8489fd@cherry.de>
Date: Wed, 13 May 2026 16:31:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: Kconfig: use bool instead of tristate
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB10150:EE_
X-MS-Office365-Filtering-Correlation-Id: cd38462a-adf6-49d9-5bae-08deb0fc557f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003|3023799003|11063799003|921020;
X-Microsoft-Antispam-Message-Info: Evh/mtrOEDwVUd0mBwzdK6wVMz4O4DQLypxo502SE7w+/2b8YYSeVC8eEvtd3xLnCZatGb1CSoI3407gQB236CZbMUlLD0As9tLohCg0WHMGI1BD6lYWmQt8qCd6CeQ0xcihBUBbha3dfPpY4iKFXO5eJY3raSgu6JWv+VLHX1NeWZc8pxrlEh4GTtjdmU3PavZ9f7DeJ/WyHrv4PbtgDPH3b2c1Pwhb8Vogciweq/kPHZU8PSTTlWGd2bh47MiYR+ec9BXpOOrPCvs+Bo5dBmsWBkIoJ9TFaAuvujxoQbtBm5usvqshvei8Gda9CzNj+rbXKVB70mdbbTmtw74CYINwGRF5QcdCMhE/Sv0ESHg86OmCh6SOwve44fY7725DgNi7MBY+Ltqk9oD4PCel1zbTTl9QlafjKvkrzd/Wb7UPoWq9wvzfZMS/WpSe3GuHal8FxczdT3YF2lWtjdRONYLjb5/NGFetTsC1m/0QGxW359otcOFzbv7bcCRRoyWb42CSw0lJs34CYyioGtb8rWAwMLUhxZzK3ddwoOgkn2Pm+GDxArXYwhKY8tvS+PFdnnbxq2bBtwh2prOeUmBS9X3Q25S8j2pGmDddZA5gb8re/btnCFD/pZjJeMiDqZhBHJdxpng1WNbbYf+ofxJ/CwCEz8d0LTUCfblmZVNEG6a8tmwqqsMXzSTXrX9dCoNmmvYYdBvxDGlxFrBKMk0CJEFhiftmDgN+QJ1CFq8LEcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JHd3MrTWx3ZW9tdWZGOWNIRUIzYWZpajRYRkR4a1BsWmhxUGpuTWZhWnNG?=
 =?utf-8?B?Nm1iWldUa2UzZnpEMVRnMzJkSXpTZzdlRXE1OVhXVGw5b09oUzlVSjhCQ1NN?=
 =?utf-8?B?YXUxMXB3Y3VkbWppMVBFcm5jZW5xTXROQy9xYXY4amZid21pSGxhR2RYbi85?=
 =?utf-8?B?RlZ5RlUxRk41K1Y1NTlLWnN5azBKMGdkdnArcUlyYUR0WW9Xd01OdWNRVU1m?=
 =?utf-8?B?RTQ3aXoyRnFmUmdramVrS1hudTJTaCtqemhQdVFtSzRwYjRRTlFPUWhyRmE3?=
 =?utf-8?B?bHRRWGhpemxidmVQVDVCU1lISkd4NzF3aWcrSXI2UzNrUDZxQzlmYVlraEZv?=
 =?utf-8?B?REZSVTR1S0RWcGRJYjdWQWk4WXdxY1M3Y3BoVE1jRzRkZUQ2WUdUTzJ1QXhU?=
 =?utf-8?B?MmNrOTBBSVV4aXNHNmJyVDVaNUU3bkVBNW1UZ0dybmFqNy94bzI3U0hWb2FL?=
 =?utf-8?B?S2dTWGc5dFJMRVZmcFFWWkZmbnNwT1VCMDUxMkQ4aE5NQTloYnRNYWxTNzFC?=
 =?utf-8?B?TUMwdjFTWDI1RFhidWdKUVEwUzFuaC9QQ240VGpOZG5VUERqdUxjS2phMk5V?=
 =?utf-8?B?dk5sOXhkSnR0OFhoU3NjSWU3SmswOTFiR1B1ZTROV2pSUlM4eXk4VGlwR3Fp?=
 =?utf-8?B?OUY3RkxubzFGeEw0WjhnSkpLNWs1emw4TzNCYTB4TytUcDlRNkthaE4wbkhx?=
 =?utf-8?B?MDkwVVFWdHRpaWpvK0ZtbXpQVjVRK1Jwd0w2OE9nOEpmaDdvZmN1ZlNpK21z?=
 =?utf-8?B?NkdnaWwzU2ZXL2RHN24xV2dNUXVJVjRISEJqUE1TZko3eXZkQkNXdW1RQ2t6?=
 =?utf-8?B?ZUd0R3Rud295ZW96Y0VIV29welVFNkpsQlNMTUhvWUxZUFY5YmZhOXNsYVZE?=
 =?utf-8?B?cWNPMytjaEk1OFFsY2NucTBzVWh2bnJGMk1hN3Q4dHUyZHo4RWNyTG41Ky92?=
 =?utf-8?B?OW5CWGNDbUdKeTFWOUh5Uk1KZnp3UmJHNlZSNUh1b3hqQ3Q3RlhFaHV1VmdP?=
 =?utf-8?B?SXIzb2QwaVlRd0FYL255dyttcGkzQkdnUStJTEc5QzZLYUJHalRlNUsxRGh1?=
 =?utf-8?B?TzdkanVCOXN1T0pTWVVtTklCamJRc1A3SzZtaXlCZFhCK0lNUzZZOTJoZmha?=
 =?utf-8?B?N3Zqc3ZPQmFyZ3BxOGNYQUJkVXBPRTdqcGgwQkdjdE1DWk45R0x3clNyU2FL?=
 =?utf-8?B?R1Q3MlhLbDJuRTVxTUdvWW9NajVIN1g2KzNoemhBWmVjUGdJWVBjY1Rxb21X?=
 =?utf-8?B?Mnp1QjYvaTZweHVZZFkrdlMwNmdoRXd4aHJ6QjZrL2ZLb2VXRjZQQnRBblBh?=
 =?utf-8?B?eng2Tzk3b0tkWkx6aVlldXJzdE1UcCtpWkZYM3RhZFpDWG8rVktpdy9Yc1kr?=
 =?utf-8?B?ZWFuaEdPYnc4REJEdkNxSkFEQ1hFdUs4Qlhpd2VhWHJmRktGZXBNbTFrbkgx?=
 =?utf-8?B?NDNoSTU2R3pWTlcwUU5PcXJvU3h1djlxL25DQW1oay93QjRTejdaRGRGU1ls?=
 =?utf-8?B?ZXhTSG9URHByaDA2UDcvck4zcE1TUWJDWHJjZ0xGMTZrWWNKZVVWbmdVb0Ru?=
 =?utf-8?B?QXVDdndvNmVXRk15azQ2L1ZsNzlybW9oUFZWRGtJbGh2anB6OEhhUjJCVFVD?=
 =?utf-8?B?b0ljZWhNWC9ucVRmSmExUzZJdHBIYjBONGx1cVN1eTVuSnN6QnhZT2ZSVndz?=
 =?utf-8?B?UnloMHdmQW9JV1pzYWw2NDVKWHpPaFFwdkxOVDJrNE9qc25FYVY4WlpsNGYv?=
 =?utf-8?B?RDY1YWJhcDR4Z2loTGIzc1V2VVpyN1FxeTg4M21JSlp5RzNmZVJrc1Z3MkZT?=
 =?utf-8?B?NmJIdmdtSjBZQjRZOVMwY1JsdEs2YjYwbElkSjkvSFk2QlJpWXFiOTNkRDYx?=
 =?utf-8?B?SDQ4N29BUE8zQTJKUTNhTGlpK3kvcjZ4Q3dYbXl1N3J3TlFTZzF4UUVIekEx?=
 =?utf-8?B?Ynk3STJvOEFWNG1aSVBJR2IrS0loNlpoNzZNcFBWWThhU3huSUhCMEV5R21M?=
 =?utf-8?B?YXhFb3UyTndFalhpZ2c4Y0xhZWVMVWpyYUpPMXV4RkRxUjArNFhJSFBUQmYz?=
 =?utf-8?B?L3VqUmFyWWZnNXUxdmltQU81NXNRQmlDUGp6ZnpNKytTOG9OelRIRVpsaVJx?=
 =?utf-8?B?RnpGVktYejUrQTFCM01GaFFFZVBZdDl6dm40Z2lkR0JLdlVjdC9VbjZqcnVj?=
 =?utf-8?B?d1QvSWROVHFBZFdIZUxsVkhidTJoMElGY3FSTFVva0hYR0FYL1N5L1JMY3p6?=
 =?utf-8?B?VVgvTm8wZlNrMUhFTDNDR25UT0lUR0tzakVyQjhYb0lpT1NLSEthRXRJdWlH?=
 =?utf-8?B?QjUzY09WY1pJYnJLekNuUkNqaVBmWFNZZFBxN1FYaWs1VndhRVVWUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cd38462a-adf6-49d9-5bae-08deb0fc557f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:31:34.7161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ME9rQqf0LrP6caw/HbgV0Bn0XkFypKtVpV6Z7Acs8UJ+5RsXW/Vgh51bTXgrdOAmmjUbhdmi/wEsoOHH3+MDpTiFmQIrLGO565s8u9N437E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10150
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

Hi David,

On 5/13/26 4:11 PM, David Lechner wrote:
> Change all uses of tristate in the PHY Kconfigs to bool. U-Boot does
> not support modules, so tristate does not make sense here.
> 

Fixes: 25f142543196 ("phy: Add MediaTek UFS PHY Driver")
Fixes: 3d50dba3a3cc ("phy: renesas: Add Multi-Protocol PHY driver for 
R-Car X5H")
Fixes: 152ff5696bcc ("phy: renesas: Add PCS driver for Renesas R-Car X5H 
R8A78000")
Fixes: d22fe8f2aaf9 ("phy: qcom: add QMP PCIe PHY driver")
Fixes: 62130bc0cb7f ("phy: qcom: Add QMP UFS PHY driver")
Fixes: 6947939b629c ("phy: qcom: add Synopsys eUSB2 PHY driver")
Fixes: 968f512e6c9f ("phy: qcom: Add SNPS femto v2 USB HS phy")
Fixes: 8b133fc19c6e ("phy: qcom: add Qualcomm QUSB2 USB PHY driver")
Fixes: 7b57ca18f8a3 ("phy: rockchip: add usbdp combo phy driver")
Fixes: 08c561447673 ("phy: renesas: Add Renesas Ethernet SERDES driver 
for R-Car S4-8")
Fixes: 0b746d287c6c ("phy: Add support for drivers to enable USB on 
QCS404 SoC")
Fixes: 1d78d6834962 ("phy: zynqmp: Add serdes/psgtr driver")
Fixes: 1a83f9931e05 ("phy: ti: j721e-wiz: Add support for WIZ module 
present in TI J721E SoC")
Fixes: 193c7351624c ("phy: cadence: Add driver for Torrent SERDES")
Fixes: 39b823381d9d ("phy: cadence: Add driver for Sierra PHY")
Fixes: dec042028e8a ("phy: add driver for Qualcomm IPQ40xx USB PHY")
Fixes: 888e1caeaec2 ("phy: add support for AM654x SERDES")
Fixes: fc58263d2e41 ("phy: Add support for phy-da8xx-usb")
Fixes: 6cfc3d664ed6 ("phy: rcar: Add R-Car Gen3 PHY driver")
Fixes: 664258887ded ("phy: rcar: Add R-Car Gen2 PHY driver")
Fixes: 3b2912167824 ("phy: add support for STM32 usb phy controller")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
