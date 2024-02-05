Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8EAC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 09:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4FA87730;
	Mon,  5 Feb 2024 10:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="e4AIxzli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 380B587760; Mon,  5 Feb 2024 10:41:07 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFE78770F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 10:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwDqNYHngR6Yvk1fwuMA6zXU9WGcMU1RLXutJO0naw4xOp0AUgnaLICiHkMxgbdqWp9TWCRwrO8xHKsd/2b0fe32XS7qHNkqDpa24BU9SuBh0ZjbXLwZs6CkZivxZjIwWG2b++YuU0hgAMtQwwB2pZycs3myk0WwaksWaDcVixXj4nPaOHXJ8a7D9z/bZ1rUR/pvHd7Vy86FsIA8OpKH5ibSuCygWSLfCj8qfrs6d16Cc5YbQ/DsNTw7PSNNygC2nkUbwyS+qWR4lmHeDps7MI5jqQTQUmhIYjxm3dN0+5anrwpRZMIEJ7bcpiVageQO6G4xUcJ2+Zm5tNFY7on5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt0FW2hq963PZVI2e9nq3naQujHeau7+rHtLhTBSZw4=;
 b=HAtQelrDQB3OlhPNFF3MMhYz04/CdttFehF9TYATUQ1ox8T4BY7jZti2ns3za9bDPOJ2gWfHUW/+nrQe8/FG5xUxaLqfMXDANhUVifAXAfqv81/Vq8+aYjS+AeZtbRLEmwuqxA5idYTJGiQbaNC/scSngv0HmRloUgfhBG28WvK3Tp0ZeVkBOFruAPqGIhXDekpV3ZGEo1rQhKKoa8s6gaPFrZJQIOCx1KNdev+8q5M2DdVG1KSkSlontmVJSnXFzSrxR8PvSpdu1XOncKcjFcIFYpsTTXIF6wUo2pBh3j39TbvxBp7rYiOKIP3xgQXddgOb2RfGmcrrB5oAeelDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt0FW2hq963PZVI2e9nq3naQujHeau7+rHtLhTBSZw4=;
 b=e4AIxzliNO1A4fERE2RciZPpdjaex3FCBozWYMG+HOc9z5Ws9inBHqK/25KxakQ4LkwewvxYvMlvlXLwRNjXH5opYuLOj8sdt0JqrTIsA8EEHrm7K1L6WOqfl03liHoL8PewKS8B57JyxSO3MJ4d2hsWjeHpbowZjek6vggWKripEhfD8nOHEpGsHuVzKOCDRmJl/FN6MRRziPrnA2nnVHLsJ4z8iI1+dLiYuVg0tzuHRfSp0SmG/in6XtyPZGWfBSevHpLqaZMSdWrBvwrJzTJwnrNWD7FqQ/3YtEWMGMDw2j+qkKIV01ieaPWqe3XQDYEBFABHI+LxgTxzqoZYZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:41:00 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 09:41:00 +0000
Message-ID: <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
Date: Mon, 5 Feb 2024 10:40:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andy Yan <andyshrk@163.com>, Tianling Shen <cnsztl@gmail.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240204205312.2342868-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b1dc61-8a56-4756-cacc-08dc262e8fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAiSYkQW5SMq+b90XpvNBFmS/ifpm0yGbhiQX7KD4+LWgQ6n28+PqkXIbQg7N2Naf2g8gk4Dp+ZHXdmykZyLP7XsQDW33UgylrjzcifRUh2ppbSRCM2Rn96t4S7JROw6jISX8BB9ymBnpllc0g47A/OcFzFDN4HTSfq8ycdi2FWNG0xUH2Cu3sSCjmDmU77gxKaZoFc/rRLwSH56z+XU7sjTH2p6fX0IND47Gl7VGVbbIjxWDSm2YDXzgaOJp2C/oKnpTxOAHnEjLopzAKPBPkftR5O81NeZ+UjhVaLuQuonZPMldz5BmM4cPpmI6/OUNpcG3CF22iEWRAYWCBQgqaMIpsppSPxNPK24ijcPDxqHv4Prl2fwt7LsJBacBDsnQR53TqjUEvnAL2iVJfvC+fHOxLHZuDzRQ4b3IFsQlAYXOz1DoJl4dCm2JxGcEsaRuxlnjl13JNdRx20cSvYO4Ny9Y9a2EbB4ZmBnU8HLUV+8k0Jexd0r+vC9xW20x7gX2LuGc7gXtTfWxNHcx1z+Od3OXPbF0wi87PP1RJ97kS9sPJ4IPBOuC6+GqGJNDmCV0wIx1xhEQnLoJnd3Qe84+Wvpb6mIlv6mXc47e2FfgTadqbgZ5HsQt2+TWyKdyhJZcJ1lz9ATgNjhKdJPmys8bxP76GMI2igXbjuEZtQPEvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(396003)(346002)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(921011)(36756003)(2906002)(66476007)(2616005)(110136005)(66946007)(6666004)(66556008)(478600001)(31696002)(53546011)(6512007)(6506007)(966005)(6486002)(86362001)(44832011)(83380400001)(7416002)(5660300002)(316002)(26005)(4326008)(8676002)(8936002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlxYThQZGU0Y0lna1Q2ZmczeHo2RHd3WE92bmwvanl5anI2V0UrVU14aXJM?=
 =?utf-8?B?Ryt2SXRZcTNHdkxYRGkzRHJoRTNaUzlkUVk3OFhHN3VTS2JPbnA5T1lub1pt?=
 =?utf-8?B?ZjN6Y2grWDRJWHBSbVJJQ21XUW5SWjRtSG5vWVdsdWhrZzhrWlZGUytQdlow?=
 =?utf-8?B?TmpXTEJ0RmtxSE4rTWFxSTEyWk5VWVl0czhVUldOTkVQWlYwVEMxV3JhbWVM?=
 =?utf-8?B?MjROVnZFWWVoaklhK3h0UmZGLzZLdHNLeXk2WXVJcmZtZzlRYkp6b1VhUFpO?=
 =?utf-8?B?QnQyNXptcC9iUDFrZ3oxNjU4Nk1vQ2QxcFFNVi9GZlFqREkvWXoxWU5QT25M?=
 =?utf-8?B?MEx6SHFPaDQ4NjJMRmpURm1pMVdYM3dkZStEVHJYT0ZQOUs0eER1S21idVlP?=
 =?utf-8?B?eGJTdE0wcVVTM1JocnJnamQrUXN1Tko1MXY4YThwamxhMWVvWTVkYmRobUdn?=
 =?utf-8?B?TDh6SVlxNW1ROWVjV2NETDVIWHJDNW5DRHBERHNZYjVZandINTVJb0dhZG5s?=
 =?utf-8?B?UFFqbzVUK3haWkpveTF5aU94YUphMEtyYlZQcjhvSkRLK2RzQktXbncrQlVt?=
 =?utf-8?B?NWd3M0ZtNm1ZR0lYcVpkNXU0WmZHc0RYTXEzQ3lzL2VJMFA3V1IvVCtOdlpP?=
 =?utf-8?B?WmlQelNSSnpGRnlpWHZNOTdhOGROMzV0c28vNTZsQ1BKdjl1R2prZXdYeWhD?=
 =?utf-8?B?VnpZUFNoVVk2eDRPeGN6WmZhd1BrNEtQQUw0WWVQRDBlWmVOMWRLbjZFeWt6?=
 =?utf-8?B?eWY0cmNjN3ZneWhvNWxvRENtZWtmZVQ4ZnAxd0FpN0UwQllvbnpRRGVSekx3?=
 =?utf-8?B?dzFTMWl5K2JJSFdLSGx5M3RSa0laRldDa3ZmWXlPTFFVRUowQlY0TTBqQlVM?=
 =?utf-8?B?Q1ExV0RDT0ROQTBBWXc0cXVtSDBNVmRIek1oMU5ndjN1bmxyVkFXeUIzM3lv?=
 =?utf-8?B?MjY1Tjk3N084VEsrOHFXQ01kS1Z0SURyYXFYYm1HN1lqbzdlclJPNWxPaUpM?=
 =?utf-8?B?ejhJU3p0a3J3d2t1bklWc1IwSSt2SHVjVjladjJjLzVSK3Fob3JxS0pnMGtr?=
 =?utf-8?B?MzEwWFdrTFhqbTNYQ0FyWDBQU1NhMjhlSVZHbVhMdWh2b1oxRkNjUUQzVitG?=
 =?utf-8?B?YktibXhrRW5XM0pJZFNZaWNRMkxibWJZcHRDaEpDR2EwNG9nMFNpL21ncTdX?=
 =?utf-8?B?M3hhVWRNZFp3Ulh4V2hHaDdKUGJRZkIvR2l1VVdmMjh5c0ZncmJSNlZMQTdv?=
 =?utf-8?B?RVc3L0g0cmlaeFRRMDNwM25HZHFtam5rcDgzYitrdmszSXZERmF4VTRIL2gx?=
 =?utf-8?B?VmpYUEUvd2xpd0VScTNSZkNlK2pkSisxMnRjT2F4RCtQa0gxbkErTUZxcWdX?=
 =?utf-8?B?WHJpaTEwK0NPSzl4STAwbnU3WEdleTVscXQxS1UxUGFnOFk4c0pjQ0loNlQ3?=
 =?utf-8?B?cmlDeDkvSVFWdUhsSlVYdWhzU2VqVXZvSWY4SVN0YXJtMVFhcWl4TUIrZU83?=
 =?utf-8?B?em5yaHJFVlhXVHZoekUrQXh1Zyt6QU95Zmw1aDYzY3RoWm4xTzBqUVFtc3Rl?=
 =?utf-8?B?RXhZRnBSUitBWTJCVFJCc1FxY25HTHJYa0VKL0xReDJpRElpNWtwdlNVOXBU?=
 =?utf-8?B?b3BvT3p4ZURaayt3alpiSjBhTnhuQUFGNzcxQ0k2V2c5YU81Y2V1VmdJTHNP?=
 =?utf-8?B?TGNjN08vc0lqSE9xbXhLZHlwK3d6L216bWRMbmVNM1YyaklVVWU0SjhsRHE1?=
 =?utf-8?B?aTdMUDVOTmlnOHlOU29lcnUwTGVudGF5VlNLLzhFeHhwRlMwYXhtSmNhb3ds?=
 =?utf-8?B?czE0TSt1ZVJFZ0VQN0JSM05uVXNDQXBWVFlGN21JR0pFMnNyWW03TmRWM2tG?=
 =?utf-8?B?ZWNxLzZIMW9BejVMNnQwd1hwdjU4OUl1S0lnLytOdkhHTGNaS3EvUjNyNHNL?=
 =?utf-8?B?Q3pxVDR3WmJ0VzRzVjVEeTlLT3Q0NWJpMitvM2EzN0lvZG54eUNURVdoZ2lN?=
 =?utf-8?B?UzJ5ZUtab0xQUExwbDBva0M5OFNiNG1sazQxN2wvRHFndmtjU2R1Szh6dkRH?=
 =?utf-8?B?Qlg4TGNYdlo2bW1vTVJrOGpCT04wdW5Va2hWUktMSzFEZk5OUU5LZlJiajFY?=
 =?utf-8?B?UEhUS2NuSmJXQ1laQzdBaHA0ZnRVaHlIZWNHRzZXWTBReVRSUHlIY2FBSkFt?=
 =?utf-8?Q?++jSDgQ8QysLa1fd4ONWlVg=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b1dc61-8a56-4756-cacc-08dc262e8fbb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:41:00.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkLm7kdEbqTwoPlr70Xl/yzI/fuGcDAlVCNvfLHLT/NCae28/kgMtp9a3uiKgQLp7H/1c6Vcphmu7bz0oq3hlmfqqrQzWOi7RRVLSEymbprvEdzEFDg+sHA/J+Rh8CwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576
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

Hi Jonas,

On 2/4/24 21:53, Jonas Karlman wrote:
> Testing has shown that writing to eMMC using DDR52 mode does not seem to
> work on RK356x and RK3588 boards.
> 
> A simple test of writing a single block to e.g. sector 0x4000 fails:
> 
>    # Rescan using DDR52 mode
>    => mmc rescan 4
> 
>    # Write a single block to sector 0x4000 fails with ERROR
>    => mmc write 20000000 4000 1
> 
> With the MMC_SPEED_MODE_SET Kconfig option enabled.
> 
> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes in affected
> board u-boot.dtsi files.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Update commit message
> 
> Link to v1: https://patchwork.ozlabs.org/patch/1891695/
> ---
>   arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>   arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>   arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>   12 files changed, 12 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> index 11976fd3a6e0..930d660868bb 100644
> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> @@ -8,7 +8,6 @@
>   
>   &sdhci {
>   	cap-mmc-highspeed;

Shouldn't we also remove cap-mmc-highspeed?

I assume this is for MMC_HS? Which we discovered doesn't work reliably?

Since it could be in a different patch if you wanted to, for the changes 
in this patch:

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
