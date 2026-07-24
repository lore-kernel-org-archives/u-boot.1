Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701FDC531FC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 08:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3268F81191;
	Fri, 24 Jul 2026 08:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lRBN9iNwXkn; Fri, 24 Jul 2026 08:45:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CCBE80C8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784882736;
	bh=DfXcqqTPVAkNVk7wZ/iozE87jwQvaOMCfsXdQ81S17I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGIYncEoIK0C4DMzXMTNM3GzoFqSqFSoJBlatxa1dMiDoS/CSYVsmUwpG22kCI57x
	 YDWjb8CdOiibNcmFTkfTkumJKUrPT7fN4m6hv/ZBw8BOvpXhRU78PXqzTnxylqZJ2Q
	 jr3LYd2mq0hGKPyi7v2zkpXtE5585JLiJw8O8t4RoajbmKmmthPYVn13UYuKuHSS23
	 BcGEmJLc2yYNdW/lxGo8vZyNnOMvwIFL1e40DVLE9+xMjF+sWNSEPQkpnbk8eZi6jG
	 Gj1gXDCuKCpu53rN2jYrw3aJUCOk0gk5wgGShF/koUPn6YxaFz5TuEZrPZqewyiwiu
	 qFtroLY7QDQdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CCBE80C8B;
	Fri, 24 Jul 2026 08:45:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0163B707
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB36380D21
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7X06nuTYHKT for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 08:45:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CE7FA80C8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE7FA80C8B
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE7FA80C8B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISsiNVB/Vt//uOwav8FKOmN3zjJk581bPbgedNNN6w5Y9Xhn+5Wn8iaKt4OxA/KjI/hwxumq8hArxMtwAiN6XviI3XoZeEeb+axSpHViwEFVgIhuU1oyE54PH25xsP9QGo+sqP5pINOXB0LzSqvdRKAVoT64xdadlnDJyO4gBufmCeBp0zGRB+U9pxcKruzXErv6C+IZ1sthkezQNoIHI4Tb5PFgnFBu4BOh5jaNgkrjzWMaJ6eGpApnQJrXieP5fyLQFKoTc5hiFqoyCDgYRjHq3we+aJnFBhUGVWLkI7Ih27Vs24FMvhb/Gp/iifB2G+14qOcaXdzPdhvoJdV1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfXcqqTPVAkNVk7wZ/iozE87jwQvaOMCfsXdQ81S17I=;
 b=nO58HTSrwtakS+k/GzwpRhP/OBNdlf0X5PXLfq0DQfprw7zGNqiHuJK8g1F5z6idm5aBnysDHzS51jAoStx7Yrdj8C4W0+9Kl1prARDYl3OqgvTkYkXracDbLCezdrZcbL0eBDsAxSwlVmg88U2RgobJjojbBcFSIu5YHLlVsyTiBeALi9lFjd3XS7OYbdGmVJjZsGpglBdScGjEcPCY/RSzMUgIian3zER2dw58dDjmcuFYLJ1dipbyDKAtPF/cLIlWgeYdyPK5kJVFn3FmccJ1A4yZG1r7tH6bQhk4NxGxyMLmix8eMAd9yCy8qvNMg2X9Nzjiphic9u4IX23raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA6PR04MB11805.eurprd04.prod.outlook.com (2603:10a6:102:525::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 08:45:27 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Fri, 24 Jul 2026
 08:45:27 +0000
Message-ID: <c6530788-e823-4cb4-905a-5473d9c00914@cherry.de>
Date: Fri, 24 Jul 2026 10:45:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: spl: replace ifdef by IS_ENABLED for
 timer_init() call condition
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
References: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::28) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA6PR04MB11805:EE_
X-MS-Office365-Filtering-Correlation-Id: d5161040-cc3b-4ec7-afcb-08dee95fe8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: s/eZlDO087Lnymg9pzPndWvmrhmU+MwVxdG36UMvEF0EhgQYPp4kUDXTtlIxDe0N5uLpgSK9glLoVB03Ht71sW90PkIwU2chlvNH678klEXI8oqGEXrR+V5II7yQsrPlT1DR6g4c3914I2XKSE2CchYNF8SaXG9M7Z44J5uhZYxNS28Zk2eLnLBxBXrMyGKoMkjb2FCd7HtGRz5laZhvyKp/Qa37AM9NRjH2VTFdAPoA5KzdOhv9uohAaFLQte9jhqSopHsM+9qG5dmyyI7YnSnDAbxKelEofcBNBZ9orhdYACrnxBSCGgP+RUnNAEO/CNcQQJ92+llnSSkR7/ohjnF0XT4ElwH842bXBGy75eoVBgDhPP6QQ/1FGnAZHV7w8IYOMwBI9zVNDR2XXIqRNLFIc+SzJ+w4cpr/RVRyvnkpWR+qH7jgn32pEJiHa1anih3zvV0VCMX68FTMugSLFupAjN3fSmlHYawTALrhSLOdEUVO3d1Lgnh6GZnNF3RkEBX686FLkseJ0jKIJ7b16ZCKrKNnj++RQ7SQVagRMHyDsIpS7FAcT01o2rV7o1vHcRINyMUbLV/f1F993mTzUSxA5XAyPgehFkz0ttSJgrh1uXxMY9EWwpmlMtjz1Fx3U0W5dqUvypmIsKs8ykk3PwNxDEdAWI9VFB1DpohNqRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmhwNVNGK09LUmVMSzYxTG9vU1BBU28xaEVBR3VwSXAxVExnV3NVdVBoV1hU?=
 =?utf-8?B?cC8xc2hyYy81QWVYR0ZYNzRyMThKZGgrczQvS0VOaGppZU5IRVFkeTdYVHBy?=
 =?utf-8?B?dFRPYTRIakEvbVd0VnJ1N1U4QWJhSmZERW5pMEdEOS8ySXl3aTdQMmVVUFMy?=
 =?utf-8?B?R2t4dkNUaTJSZU04b1YyelRXNUZNY29JVEtCN0VtVFBrVk1yRmYvWjlEYThv?=
 =?utf-8?B?ZFVxaTcwbERHUHhYMzB1UW1VeEZzN3BuVnFEQVNQZ3hVTW1nQXpkTzZ0VnFm?=
 =?utf-8?B?NU9LTGhkbUNJS1JCQVZ1MHVRSThZOGRDNXBGRWowRlFGMHpvVlozeWdLUUFH?=
 =?utf-8?B?WEtnMXIyVHZzemNWTTVWUTFEbEdEREZLeUhpemQ4bXRhT2tSc3dZZnVITnVC?=
 =?utf-8?B?UHZvemhDZWJ5VEo1OFBKNUUrdVM4QTEyRmV1cE1DZ2wxQjAvMGZWNE9pQVJs?=
 =?utf-8?B?T1NncHJwSEREdExKTnRRTDB4d0NOQjlJcU1yNDVvQVRMbXZGa3BLb1Uvai83?=
 =?utf-8?B?dGFWa2t1YzNmdno4bVAwN05uSy9zOERxcmQxU0NzSmtqYTVKeThmZlgwKzZ6?=
 =?utf-8?B?MlExNjRvV2lxNkFuZEtEM0ErODY3UzFLTjVieUJmS1V3dTA0dVBxSUxpZG02?=
 =?utf-8?B?VVp0eE1kMHdIQU15RkRnd1hmb1BJOTZIS3k3bFRYYlAxaW0rY0R3S3ZBYkJy?=
 =?utf-8?B?ejI0QjYzM3Z3bC9EZGxMVE9tb2hKbld1VHBXR3NqbmdhZldMSFNId2NOODFx?=
 =?utf-8?B?T1JkUzFodU5uemU4YXp1Q3VWMTlVSW44RFQ4bFIvb2hhMGdJZFk5V2NFb1M5?=
 =?utf-8?B?YzFYS0Z5L0xXdmxqbjVRQVpQV21Xb1NGbUF4NEZqT1FUWkM4QnBYSkhuZlQy?=
 =?utf-8?B?SGxMUEF2RW9SOTEyOGJobW1lYkVKVkpWUVlYL2hiN004aDVqdmJKanVWSFN6?=
 =?utf-8?B?NyszVmR4QTJMNXNzVm80WXR3S3VGNXZXRlpGZmtqMWFHNUY4aStqTWNsS1Nh?=
 =?utf-8?B?bTUyMzc0OWwvaTlvWFdmbUkrYkZFWFZEbUFhWlVtMlJDNlNYeCtEZXF1ajZ1?=
 =?utf-8?B?MWF4QTUyUU9CRVBCN3VUUjVSbVJKZzhLZUFRZ09YNHZGRG9JSHNNbnFYSEhQ?=
 =?utf-8?B?RmFEVVRTK2hNNFFWNkJ3UUlzTWs0aHgvNFVGSi9ENDhMZm04TXFjRTlJMEZ3?=
 =?utf-8?B?Zlc0WDRxODZ5R3liRzltY2gxbUEzNUwveXU2Mm1WOG5GZi9kZk91QWx1ak95?=
 =?utf-8?B?NlRNeGEzWXNmeHE3aWlPS3JVV0lSMytKaHZlcVNWQjM2M2h0RE0zM1lyMXpD?=
 =?utf-8?B?YjI1am9DN3B2TjlSNUk4WlB6SURFT0NaZ1NlQUpnVjZkM3NqOWNERU5Od25C?=
 =?utf-8?B?MzZ0aGlTZHIyaTlWYU1MeEllZzl6eUJ1b3phYzdYL0Z2a3B4bytmTUJCZm9K?=
 =?utf-8?B?ak9LcTZ1cmtxdUZiOTZpT3NZRVhsL0htR2p6enNrTnpySnVIQXNwaVhFalda?=
 =?utf-8?B?eTRaZHo5VGtlV3NSU2dramZnNi9tVG5qMms1RXdrZ0thOEVqSFplbkNPS3Bm?=
 =?utf-8?B?b1M2YStpN2VFTld1VCs2ODFPTXc1UVVLVERxVGozSnNQTFBxOWpOYXFuZzNR?=
 =?utf-8?B?VHVza3MwdHZ0NkZKZ1l6eFNiTEpOSlhtZmhUSXpnWFlac2Z2ZmNYVDVwakpP?=
 =?utf-8?B?OFVXRHBabWxJeG5oTXNNSHYybUlkMnVpV2cyTHR5M3ZqbkwxcTI0V3lGOTBC?=
 =?utf-8?B?cUsvalhoZkZ5YS82UGlXK0pXWVRHRzI0aUsxdWU2WXNJV0JkM1VKUG84M0px?=
 =?utf-8?B?QTYraDVDVVppc282cTJVSE5OZVR0RHJ4ajJ3WWszc3dZY2FhR3o5N2dGOGFQ?=
 =?utf-8?B?OXl1dWx6ODNPbW1qY1k1OXMwNkUxUDdiRWI2K1Nac2JTNVBiK1pyd0NmTHMr?=
 =?utf-8?B?VGt3R2kxVVdWb2RhS05nb0dFSW15ZUI0NzMrcjIzY2ozYm1ia0VOV2FsZUZn?=
 =?utf-8?B?d0M3bUZad3A4ZW8veGhpMEdCblFUcmNhUDNaNzUvVWMrcjlVTUg0UzEray9Y?=
 =?utf-8?B?UFc5d1pvdGpNc1I2V2RCRjVNVlpIODMxQXZVdDQyc1Z1UTh3bStLbkVnSG9H?=
 =?utf-8?B?UW5HdnB2WGJ6WXRYNTVTRzJrSFBuS3Y5NUFBY3p4eDlaVTZPVHVxQXdqODIx?=
 =?utf-8?B?b205WnZBK3V1NzNNRDdOVWUrUmo3Z1NDbFJBc1E4V2ZORFZ6WUtjNFdaODVM?=
 =?utf-8?B?bUZNQ3gwYTNPU1RzaktKWGp0SVVzSUVHajI5ZGtjMjFidDhQWC9QQ29NZWpV?=
 =?utf-8?B?NXBndVRaRExORVFjcVNxcWhpWHljQmJ6NS9CbGZvNCtwa2RYOXpoZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d5161040-cc3b-4ec7-afcb-08dee95fe8e3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 08:45:27.3836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+MmbqZ6vgjiTlM9cVQNipdyW7WgjGJWXirotLUixXH1FB+IUMIugbFI1LCiZZcA1TZdlB9yIX57ILOuR7BcoR+WuJUQivTYhUt+OPd6Xo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11805
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfXcqqTPVAkNVk7wZ/iozE87jwQvaOMCfsXdQ81S17I=;
 b=L5l0i0cBpGN431qTPjNXnsjWpyWftakMeI7AYNmb+M3moVd+9A24horVN5HrazXp9b3DsfeOYTJLyS9obXVhHfzAUGXUst/zNnE7VZVcq+G3ytLBrPEvqOGwekgteW86hpEEwVDAnceeEzWl1DmkUvubTZV30Z8lprbDmtfoZYI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=L5l0i0cB
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/24/26 12:17 AM, Johan Jonker wrote:
> Not all Rockchip SoC models use the ARM arch timer.
> Call the function timer_init() only when
> CONFIG_SYS_ARCH_TIMER is available.
> Replace the ifdef call condition by IS_ENABLED
> to increase build coverage and make the code easier to read.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Previous version not needed for serie, so resend separate.
> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-5-jbx6244@gmail.com/
> 

You didn't answer Kever's question in the linked patch and I have the 
same question.

This is essentially the same code, so what's the benefit, are you trying 
to fix a specific issue? How does this improve the situation?

How does doing that increase code coverage... etc :)

Cheers,
Quentin
