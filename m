Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F183AC46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 11:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C5E871C3;
	Sat,  6 Jan 2024 12:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="U5D6AKsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4497587227; Sat,  6 Jan 2024 12:58:03 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD118718F
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 12:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NijXAngOrn0M/5/MR63BDg0gJD5BgAae/YYm8Yq/fPYv40278BGMnSZTPwJTvtrdesSz3rFraxfHN0R5K7U3zZ5QlruLVU3LWZQUhuz5WfTRDWsl6kbcu3FiwoAI6DeDjWO1WJwgP2mFZ+m+FJOUmsyryogz/DnghXiUy2CUYZ8dAS+6hIDCWuWvceHyIUVCsXmFqvk/0FWoBDnCgHWmcL2ylWSuzvyUbNvx9WiDFhvai4bRYI+pmUqxnGVzYhPJeyjI2DciSPkkVrlyqfKqWWy6uNE557S6rWL9Pm2bhRzsTwRRCG++s/+/ZcOjizDAQOe0uwQ6ncITaAWyT2t30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txHGwyqRzZWBGQSlQAaEH2xlRYJg/pP513rhjgX7TtE=;
 b=PvOaJHqQeTFYnOgT8aTHWV7WQeo6GxxHsNzlDEtAYnpNQlXgp0ZwhZrVOYC05NRh+WDlasT2yL4TVhEuYokQS7t/uOq/4jXAlcdCrwLICpYmxb08d4DAmkTHZpszNKjdV3c1mcCG9luip0G0tPCKlIjSlSpCoL9bsYFrdqVlFQDECNRjNoTZA3k2AXtBa0sBhTf1uwvgcDtO/n05ZYv5tl4puMPCfb/re1hbDpTUqj81aIdLBjzv3yoD1HZzKNAwTd+oeK9s3c8VvwhUoZIHah7VTzFN036iiVawheam/PR4otTsk7Me5v90lYdXFhrI/xgkddaegecUp+dyJHl7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txHGwyqRzZWBGQSlQAaEH2xlRYJg/pP513rhjgX7TtE=;
 b=U5D6AKsJGV3g2xRjP3ob1mo4LjOLRf7kdOUe4kU1yw2Ajt5cY4OKVdpg5Kjieq3xatbogc+CV0x1gEMT1e5StNII2pKG8dsKZkue8vI8a2MM/I6zZkq/fJVkAfr0hKAUw5qyGq4XjxzoP9eJOfYJkTstlx3ClZdCkMNW7cyI5URFOO/7GXINTqwU2+Ni5vLzBpDLwB37A5vBiGCja105zmMnULcSV3YRRpI/Exza4Nv3+bitk8+OcWF6pV1ui47eq/PmMxxCoQtQPguWq1IMplUCG0FRs6sLSFOJvK3oNAViKQ6e3t4V8HdZimsgQl1GLHhgfp/Dp9yA8MwfC7SJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 11:57:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 11:57:56 +0000
Message-ID: <10cffb20-3157-43e2-acfe-e2b2fe207c23@siemens.com>
Date: Sat, 6 Jan 2024 12:57:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/26] sync am65x device tree with Linux v6.7-rc1
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>
Cc: UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
References: <20231229174656.634065-28-bb@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3860:EE_
X-MS-Office365-Filtering-Correlation-Id: 9441cb40-97b2-42c5-c12d-08dc0eaeb84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JWDDd322RzrushRq/E3Ev+V2EBab8sjSCr2lSrhb3Hgi+IAbn+U6vchgljCSRcTq/d314i4XiWMwwoTqU/M39S1DTQgyhrUfpA2NoD0jPCmtVpD1VBaN3Neqyixzm4pAwp/KgHzLgWNS85Qd68SE+XbrgPFcoL9djXQ/36uq6gXm8qYa54hXC1ShcSyUSJiEMChFAmlbeYtyYiieIn/+xJOqnUBuSupG/kWjabmZ5XcTGG1se9JyZs/PDztcibMZHRgfMq7GGKnVjNnkYANy9igTF1PAScCoBIi2Ell9/2QbJPrUG0o8PeBa/VNltn/7J29VxB3/qn5iZxvJt7DRinak1l0Mu4Mwuj2mgcZFSIoThq7GVz+/jsgzEWV0Wnyf4QeLlU2p3r2Q0ANx6LiYubbJlGAPwGZqJL7TzPnQdMMq5uqb39ZZIekR+PVoWcRuca4ETh5d9brjBb3M44X9+dpjrnmmF+/WKk3dP1p3pLP/YA9LZaglYGtarysM3k+/PXciumo8xGBxNBXsibBILt/o+bj2zcN0q/gH4fNEh8tsIeQweSzrK0cqSoXDwHwWpgCMDd2fTyZ2kl1Q7Lp0pDabrlB9bEE/Iwy7LFjcm5Q4/2ZVsa3PHwYYUVhTVw2j+QjRzvGU12Yq8KRm4z5EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(7416002)(5660300002)(82960400001)(86362001)(41300700001)(31696002)(31686004)(316002)(110136005)(54906003)(8676002)(36756003)(8936002)(6512007)(2616005)(6486002)(66946007)(66556008)(66476007)(26005)(478600001)(966005)(6506007)(83380400001)(6666004)(53546011)(4326008)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitaNzNnVkgxMG9KTHhxM1pmcWNKVDhDRkIxaDZoMWJ6aEZ2YXE0LzVPTnFi?=
 =?utf-8?B?SG15cHJKTHZ4dmFnRjM5clV4TGhkRUNISUVDd0JiVWZWVVkwdGFtQ3FRdU1k?=
 =?utf-8?B?K3FoUVFRcFJWWkNjMkJmRFkxTnZtOHBTR09mQ2MvSmNyZDJSaGJGMG02VWRn?=
 =?utf-8?B?L2c0STdBSkw5N293K1ZYN1JDTzh0M3l4ZHZDSVFLbE5GSWRDQzAwdU5BaWRX?=
 =?utf-8?B?SUFaUkVHeGtzcTBJeFZybmF0NlgvdEc3a3ZwYlh2VEJ3MjZDWFUyNldvV0VF?=
 =?utf-8?B?di9QWkk2eUtTQ21NN0dubGlMV0V2MGlzVHJBNmFaeFIxdHJ4ZXFqbms2L3lp?=
 =?utf-8?B?bkNwZzNaUTJ2RDdzc0YwRlBCTDBSczZZNVJMTWF3aHlyQmo3S3J4amVUNTV6?=
 =?utf-8?B?b1FBODVpb1RrSXh1dkQ0Q1pZaVkrZG00dm9idWFRUG93MkphdG51Q1B4QU1K?=
 =?utf-8?B?MTZZbG1ZS1FibDN3OVVScXpFak9nMUV6NlRKbHk2T0hTMGdPcXJVaGtKYU9S?=
 =?utf-8?B?cCtxdE5ocVFJbnkwOGdyQ015T3k4WXJNS01FYTZlNFFXeURMaTNHYjNKelRY?=
 =?utf-8?B?OW11YWducHBIUGNndkNmejlFTFMwQ2ptTUhHWTRENkpOYUJJWnBxandKVGlX?=
 =?utf-8?B?OU9EYk9EbG94aENScmhXTld2R2lienVRR3ZpM0pmcnJlb3luNFc0a09wUitI?=
 =?utf-8?B?WXdPYVRJOHZ0a21lOHRxYVpNMzhnV0FzZnBGTU9UODllT1lyZ3R6Y2dla3o5?=
 =?utf-8?B?MVQ5dkdsTElUemp3d0lIaDYwRHgzMWNxNXhUamttQ0FQN3M4NFJSN3BDUm85?=
 =?utf-8?B?MGJodnozUERQWUUyYzBoMnRyZTY4ZCtwcHpLa3hER082UXd4TjdkT1FnT2VL?=
 =?utf-8?B?ay82YXg1VTVwS0lCNHBzTkxrSnplUGpvR1lEQWR5cHFEWlRnUWZHWk1zdlZo?=
 =?utf-8?B?ZjhNdVNMTjFWRDNwdXVpOGtBditLYmRQRWFKS1EwL2lTRkVtWThjQXAyOWpU?=
 =?utf-8?B?cmxnaURkU21HYVptTWRDZkI4N3NyL2Fqa1dwb0dGWmp6RjZuZUlnTCs2MmxF?=
 =?utf-8?B?Q1dUczZzSFBVM1hPMGNNb0o1ek90aVIzSjBqaWs3TUxNUWVPeEp4SWYrK0pE?=
 =?utf-8?B?ZVVPS2VTdlF6d3hyS3VIRGV0VU1GYWdEaDlMeG5UTGFxOEpuZm92QnhiT2JQ?=
 =?utf-8?B?RHh1dW4vUUVMUjlUYUppTXhETGhUelpLbVkzenhuT2RiL1hZRU1GZlNDVTNW?=
 =?utf-8?B?a0s2VllBOUd2US9aRkhVemtqTHI0dlBINk9nSy9BOTZrV1dZcVJjUzdOWnlu?=
 =?utf-8?B?Y1ZWTHJtSHRaM3JxSnZ1cURDOFpGblcyV1JVeVJlY0xZK3NwT2FzTXVzN3c3?=
 =?utf-8?B?UEdyeXIzVC9WMTRQYi8xUks0UDZHSithQXEzOU01OG14dE1iY2R2WXBJYTFh?=
 =?utf-8?B?S2xKb0VRdzJheTVSTEZNRUlTay9sRWFwZndqNXJjSWtEYlFNRnIrL3J6U3c1?=
 =?utf-8?B?amF6MVFKOU4rOUJoeERNN0pKYm8vL0xzK29VbEhWOVNLblNYMUQxZzZXL3hW?=
 =?utf-8?B?RkJRU3MrTDFUUE1kZzhKTS90MTFhOWx3cStwa3M5d29GclFJM1JFVCs2YzFy?=
 =?utf-8?B?UEVoQjNpM2kxR2lKMjZBTHJWNXZNQjFVWFhPVmJ0Mm51ZVg4QkVObU1Oamdw?=
 =?utf-8?B?eW8rMEt6VGhGZ3JKM01STXFrc3N4ZzRvZ3NJQUxtQndKUDluOHAwSjBrdXhr?=
 =?utf-8?B?aXBoR1BFdVlaRU5LTGk0YnF6aXBjN0ZuZEdIbmsvY3pwNk01TW5Rby8wOVNa?=
 =?utf-8?B?bUxrMk5DNTlVL0hFdU5QSGU2ampldm9VM2RyRmg3Y0ZKSnROQVdwa1kwb2Iv?=
 =?utf-8?B?Wlc2aCtOYXc5T2FUdG83dXRwNWM1bXdCcVhFOCtxRElrVm92QTRnckt4dUFN?=
 =?utf-8?B?Wk9VOEFvenNHMnFEbWw2alZXWENCSVJPb1VIKzNEMjBXZURaTGZ6VGhsM3ps?=
 =?utf-8?B?bHFKYSt0NjNOSUpUalRKdHdSOE1sYUFhdVhha0x3MU1ydXBhL21IcUZiNnY0?=
 =?utf-8?B?Y2luYkJMYU1VZng0SERrcjdlaVUzdWluRjFVV3NRazBYRC96eFpIUVIrcTdy?=
 =?utf-8?Q?ARP/n339iPsqLwYaRqKHjaNBs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9441cb40-97b2-42c5-c12d-08dc0eaeb84b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 11:57:56.0161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNY6F8V6VovlY330WDoRck2v/ULyYH16zfc5w/211Cjvt58iBJvjXVU4+fS9vwzbt9GvrSeJFj6caTd1enytpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3860
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

On 29.12.23 18:46, Bryan Brattlof wrote:
> Hello Again Everyone!
> 
> This series gets the am65x booting again along with syncing the device
> tree files with v6.7-rc1 Linux.
> 
> The bulk of these patches unify the WKUP SPL board file with the arm64
> files to make future syncs from Linux much easier. In the end the DTBs
> should look a lot like what the DTBs look like for the am64x which
> is fairly similar to the am65x.
> 
> For those interested in what UART boot looks like:
>    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc
> 
> Changes from v1: [0]
> - fixed multi-line comment format
> - moved wkup_uart0 and mcu_uart0 U-Boot overrides to the r5 board file
>   as they are not needed for a53/main domain U-Boot builds
> - corrected a bad wkup_i2c0_pins_default fixup in PATCH 6/26
> - spelling fix (s/Libux/Linux/) in commit body for PATCH 6/26
> - added trailers from Tom
> 
> Thanks for reviewing and happy holidays
> ~Bryan
> 
> [0] https://lore.kernel.org/u-boot/20231221174412.210807-1-bb@ti.com/
> 
> Bryan Brattlof (26):
>   configs: am65x_evm_r5: enable driver for fixed regulators
>   configs: am65x_evm_a53: disable CONSOLE_MUX
>   arm: dts: k3-am654-r5: Merge board file and U-Boot overlay
>   arm: dts: k3-am654: pull in dtb update from Linux
>   arm: dts: k3-am654: copy bootph properties to a53 dts
>   arm: dts: k3-am654: include a53 board dtb for r5 build
>   arm: dts: k3-am654: remove duplicate vtt_supply
>   arm: dts: k3-am654: remove duplicate wkup_uart0
>   arm: dts: k3-am654: remove duplicate timer
>   arm: dts: k3-am654: remove duplicate mcu_ringacc
>   arm: dts: k3-am654: remove duplicate mcu_udmap
>   arm: dts: k3-am654: add needed regs to udmap nodes
>   arm: dts: k3-am654: remove duplicate mcu_uart0 node
>   arm: dts: k3-am654: remove duplicate main_uart0
>   arm: dts: k3-am654: remove duplicate sdhci0 pinmux node
>   arm: dts: k3-am654: remove duplicate sdhci1 pinmux node
>   arm: dts: k3-am654: remove duplicate wkup_i2c0
>   arm: dts: k3-am654: remove duplicate ospi0 node
>   arm: dts: k3-am654: remove usb0
>   arm: dts: k3-am654: remove duplicate mdio
>   arm: dts: k3-am654: remove duplicate vtt pinmux
>   arm: dts: k3-am654: remove duplicate root properties
>   arm: dts: k3-am654: remove un-needed aliases
>   arm: dts: k3-am654: move dummy_clock to root node
>   arm: dts: k3-am654: remove duplicate mcu secure proxy node
>   arm: dts: k3-am654: convert bootph-pre-ram to bootph-all
> 
>  arch/arm/dts/k3-am65-main.dtsi                | 342 +++++++++++++++---
>  arch/arm/dts/k3-am65-mcu.dtsi                 | 156 +++++++-
>  arch/arm/dts/k3-am65-wakeup.dtsi              |  10 +-
>  arch/arm/dts/k3-am65.dtsi                     |  19 +-
>  arch/arm/dts/k3-am654-base-board-u-boot.dtsi  | 195 +++++++++-
>  arch/arm/dts/k3-am654-base-board.dts          | 301 +++++++++------
>  .../dts/k3-am654-r5-base-board-u-boot.dtsi    | 208 -----------
>  arch/arm/dts/k3-am654-r5-base-board.dts       | 303 ++++------------
>  arch/arm/dts/k3-am654.dtsi                    |   7 +
>  configs/am65x_evm_a53_defconfig               |   1 -
>  configs/am65x_evm_r5_defconfig                |   2 +
>  11 files changed, 886 insertions(+), 658 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi
> 
> 
> base-commit: 0a0ceea2269b983e736b80104f03cc800d1a5e2a

This breaks the IOT2050 boards, probably because it did in incomplete
sync, changing the core dtsi file without updating all affected boards.
But also [1] is missing in upstream already and seem to have an impact.
Bad timing for a sync.

And the series is not bisectable - already the 3rd patch breaks the build:

...
  DTC     arch/arm/dts/k3-am654-r5-base-board.dtb
Error: arch/arm/dts/.k3-am654-r5-base-board.dtb.pre.tmp:423.27-28 syntax
error
FATAL ERROR: Unable to parse input tree

Jan

[1]
https://lore.kernel.org/lkml/1edbc1b56ed4ff2256d7afb7db3cab4b3a423692.1699087938.git.jan.kiszka@siemens.com/

-- 
Siemens AG, Technology
Linux Expert Center

