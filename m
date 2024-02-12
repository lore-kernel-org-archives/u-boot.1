Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3F8C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 09:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7437876F3;
	Mon, 12 Feb 2024 10:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="aAb6y/U6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4FA87808; Mon, 12 Feb 2024 10:38:38 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894B187073
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVKVKHRTRmu1l2APZII7lxhaGPazl9Kr1lgPe/VTXRdu+y9ASmgZbEr+KfgKLUmNwusaQQkDx0T8kaTDnGYWvmfeybPG4WZw4FNVYpnpR/WC/6umzeBq0weIyzsxShqLqX6oZSIITJTZwGLeyJ8R7ryLyccnA2yk79sb5g/lzlVHTcjPkwJ7VTIClsTMV9DUPlZKchGuVDfDjBFICEQvDRyfMUY7iZfdPwnm0xkA7Z1LI7BGfJuYqt+GGYTDwJUgQx02K92wX4WtQ0ZxyJqHHfN+ENPtyAA8OB5KTn6PluRXGJGtK5RMTrWIjQm0Neo6qSW08T77yp0dDVeYvTjGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i68i6MO6FMM2F/mWoSJs8S0ga19mJ8GRUNfQlckN2c=;
 b=Bu3vsdpctLU+QfnK5q+pF+nUtTKTFPY6lAnjLmkQrLPtkR1pXvMZBDFo4sSFMk9mIIKdqmWiWBNIx4fBALP1nUnIAzRFT7RvvUO3CXExWvSnlF1+0ektgESTQ9LBfEaGPZClqN5hCVaomZpQ9NsQjCNO00WPvwS0DfijRi+xfT741IbMGwnXnyergS31T+uqJ9l1gC4maUF8zhDpZh4iD5V10bGGbZZrxYdvaQs1H3ecpqr6cCGeyY5Se6XDZ5dJJwjMAC+3fexHjojBZMUD0DYfeMFbO6uw98fRzkcaTq7uFosNofK7xrDtckTPEWIOtt8VM4KYtab0/U1Yc3bhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i68i6MO6FMM2F/mWoSJs8S0ga19mJ8GRUNfQlckN2c=;
 b=aAb6y/U6JdhzEwtQX4lEs1mNf5OowbzjbZ3yjKm/tI0VIWFv26+CB9ClbfqieQq7zidQIuo73clUonxu+9DykSpDBqrAiWj0o9Qe2usSsGjtDK55Q0BbODwagjvwtdi4+3w7NqAO6GgyLaCH4uq4qyNdCfktHi40+n/x5Q0KBIdSAEtDjGN+QkHXAvYYohfX3gbQ3f03MK3a1Uz/MH45E/H7r4StY+XNZpLFELuibASu0CAjsTFuKs/JrDP7kSLXzahElQ67Jq6GIvKu5EuVsPFZ9CozoVZm+8hsPYMaianFZ6X9iyEiIi4fL6P7As+cGwzPzirzgg6O/PldJQ+wpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU2PR04MB9052.eurprd04.prod.outlook.com (2603:10a6:10:2e7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 09:38:34 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 09:38:34 +0000
Message-ID: <b1e20f6a-9865-4c44-9e1d-177e7b953873@theobroma-systems.com>
Date: Mon, 12 Feb 2024 10:38:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: rk3399: regenerate defconfigs
Content-Language: en-US
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tianling Shen
 <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20240210063252.1065611-1-wens@kernel.org>
 <20240210063252.1065611-5-wens@kernel.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240210063252.1065611-5-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU2PR04MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 074fbaeb-ca40-413b-24a9-08dc2bae61d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MUqW9wJMuI6sc+aC/1x8o643kwvPbT+SbhMO2BZ1TfNkH8C1cmunTv7LMwBw6NazbsNYlZrSbfc/9DmGi2DxdIDL4Q2XVN7iLgHUZp5+cbGo6+WFyNSZGonFatKkVFw4vHderXxAJVpLKFrBwfF7ooOOqvQjoCnG7T8/IhiUFBf0k5SRammxVK5mkqeXYF/QPrt7s3hSNEmMWw8mfmCPDWhoc/O+iB7u4l+M74eRfDgu0uOcjhNdg8n4bLGYZXYvPdUanT6zYGtnzSXyFKrDP6m5/ztjvqZyVwjvyOc5WjCbSsa5jlxSa3ZBcB4O2sdY7Ri/a9EJKqdnCejmG6TufEv6O1ZqDgmwOGLQjFDL0KRUxOfz47SIPM8mXe3Mk6oubFWxgxoAicRkovdL12DNGTIA0Ba/OQt6mwi1vkBfPyBHdZ6hC6Mq19XvPERMxYBaob2K5eXigM6YJnPN4ojrmIza5EkvHeSKWbSDc8H3K/36JvgwxJzYBXYh9eUz3WQuAa5tqif7Gyy6vLMuCT3KWvfz+rSEOZVUCjAZiIODxgTPjkcHmBsCzYP9cFvPUCs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39840400004)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(4326008)(8936002)(4744005)(7416002)(8676002)(44832011)(5660300002)(2906002)(83380400001)(2616005)(38100700002)(36756003)(31696002)(86362001)(66476007)(54906003)(66556008)(66946007)(6506007)(53546011)(316002)(6666004)(966005)(6486002)(478600001)(6512007)(31686004)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1yRmdLdm0zRzliU2ZIcGlrSjg2TTYyd2tSOGx6cnF4ODA2UmhEcUU0R2J3?=
 =?utf-8?B?dXRhZTZPdndZSy9aYS9zOXNZNGVFVVFtVk1yQnJ5WnRHS05QdUg0NXV6Mmxt?=
 =?utf-8?B?SHVBUnJJRjhvSE1kY0w4aGFUQWp5QTVMQ1MzYitLeWhJV3B6MzNuZjVseGJT?=
 =?utf-8?B?K2JaaUp5VjF1SkpzK0JLUzVLeVlXZVB4UDllN0NYY2k0VnNGa2lteGlVUG1l?=
 =?utf-8?B?Z0c5VUxHbTNhbWV0S3lOekJVbUhqUFAzTVJDTXZteks2V2dTOHJyZ0JCc01w?=
 =?utf-8?B?VVBTVG54Nmk3aldiZHZLRURWc0U3TWg4K2lQR3JZcUE4YzVIbG85a0g5TVVh?=
 =?utf-8?B?bFNHYk93TFI5dUplN1h2aTRleXBVUzBEd3M0UVFTdHYrNzhtd1NSUTRIQldK?=
 =?utf-8?B?bXNRV3d2YVpIeWg2OThaTFlFUFg3b0dqM1pkT0dBZGpIUTB6QlpyRTZOYnlG?=
 =?utf-8?B?QXJrd0JWQ21QenA2VklZdkRsT002WTRJYXpXd2o3czk5NjkvbFdXckhhelZP?=
 =?utf-8?B?M2haZnNCdTN5K25EV1VTMVRMdkpBV25nckZhMjluT1ZkS0ErNFI2ajI2S3hn?=
 =?utf-8?B?RVJySWZBTVIvcTI2dTlOaklvK251V1dKSWx5Y2c1TllqbmdRd3l2YnB0b25E?=
 =?utf-8?B?c3c2NWpLNEtCbnFBdGxmM29LYnYyNmRkQVJXWnpuQW5HSE1uWVd4ZmFnS0tF?=
 =?utf-8?B?M1dCeHhVSm9MUkN2VlVjbHRGOGdjVEhSRGJ5dUxITmlqblN3VjNnVVFPUkRI?=
 =?utf-8?B?ZVBiNEl3WDQrOHc3d2FHL2UrM0VyYTFJamF3UFR6d1VxUzU4MnM0U2kxd3JM?=
 =?utf-8?B?eENQQndtTGNlbzF0ZVBKb0xxMHBRZVUzTEhIckJoc0hGU0tML1hESCtvZW1C?=
 =?utf-8?B?aktrV2p3Z1JVMzlQVC9GTFhPSG1EVWFoNXNiQitoV1JMNDIwRFZxNUt1YTFT?=
 =?utf-8?B?b0NmekRWcnRIUDExcCtodG9MTitnZUMvd1c5OWpCRVdBbngxUkhvaGxoelcy?=
 =?utf-8?B?S2FGeFFtVGMyczBiUldSMWtYdGxxZVh4UndDOS9uVmNISWJiRUYwMjBKOG5p?=
 =?utf-8?B?WS9hTE5pelovKzlpYXVpcnU2blhMaXRQSFhmWXdoOGRLTG1qelA0bEhScWtl?=
 =?utf-8?B?cVVpMTZEK0VpWHcwWGxqbWV2dkxKdVlBS1Z3b3lQV2E5M05XTDRBOXJhTHAr?=
 =?utf-8?B?a0VCMzluSURYUVB6Zjc2MUIzZlhOT2V5QzBWU3JWdUJGWGx6QmFVOWZaRVJs?=
 =?utf-8?B?aXdSckx1Uk56UHB4MnRremxtYnNGUUlMc2hwZTNVaXhtOXVIZmlEaU1RdlFy?=
 =?utf-8?B?enY5UmlzWFpwQmRKNC9JZGpIRWxSc2xHdjdGZDNoaEpwYmplZEFUWkRSeXIx?=
 =?utf-8?B?b3dZYVgwcmthQzV6bmc3TU94NG9qRmduZ3hQRjdxZ1FNSzhGV0VTcUQzMnpr?=
 =?utf-8?B?dFJDTC9WcnpmQkJiaXMzQmFGYUc4dFgzSjJEQXQwWi9UTzBJRTB5Syt0M1k1?=
 =?utf-8?B?a0RCRmFBalU2VU9Gdmt1cjI3RXYrN2J1SkthUjZwK0dkY1hKVFpkM1B2SVVX?=
 =?utf-8?B?am9uMkhCb2VCVDFmK1cvODBMWmY5VjNIUTVBY0VhQjVpQTJJMmx6RnQ3U0cv?=
 =?utf-8?B?N2YvYlEyRVIxWGxUUFc5VGt3dU9PdFlyd25ldEk2Y2JYT0pFa2svd1JWRnNt?=
 =?utf-8?B?Q1BlQ2xleXdvZ2svSTN0ZnBuTDR4cmtXYlZnMEV0TFNoczZGdGwxNzdBNWM5?=
 =?utf-8?B?Y29tYWxqSExQbjBrVmNpV2c0MWV2TS9OOGd4OFpXY3Q4WTdxemgxdU9xRExR?=
 =?utf-8?B?NGhGTVg4eHgyRXlGMTNYNko3VXdOUyt4cGtjYldQcTFRZUFpTTBQNXU3N3FS?=
 =?utf-8?B?eGJFQnVHRnZwSCtxdG9BYWVYMW9Zc3JwQkVTQkN6Tk13dDVaazk5K1VERGpX?=
 =?utf-8?B?dnUzbEVwNVZERm9VU2wvc1lKWHRlY0hMb2tveUJXM1lGMWdqaXM4UXBFWUF3?=
 =?utf-8?B?cWVjQUdKbHdSM0lKOTNtbkNXQ2ZpWkJ1d0NyZFFzSExuWmJXUE9YQnBPSStR?=
 =?utf-8?B?bTcwUEl1RTNJalhTbmZWQWRJaERQZzRBYmN5UERXMW8yenlOU3ZXZGFpWE4z?=
 =?utf-8?B?cjBqUlhiV05GbUN2MU9SM1dWdlcvektOcUNiMUZVUzNzTmEvcnR1aU91dDM0?=
 =?utf-8?B?YTh4UUdIM091cXVPWFhKNDNxeXJKM3BHQ0ZiZkhlZ1ltbXdoVGJoUTFHSm04?=
 =?utf-8?B?OWV2NTU3bGR5OFZENlRuVzY4bndBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074fbaeb-ca40-413b-24a9-08dc2bae61d9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 09:38:34.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htvFzzdHX3Wbeb+XbDVL640skGXO4CzJ9O94/+R5SuuxMr0mBUsIZNlmZyvj33V6/25s/uHPtsTiPlUO4LQLVxCbljAGFxrVFALxSWOZcZzSFNccTtNV37vowyfbu7rE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9052
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

Hi Chen-Yu,

On 2/10/24 07:32, Chen-Yu Tsai wrote:
> [Some people who received this message don't often get email from wens@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Regenerate RK3399 defconfigs after adding imply statements.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   configs/chromebook_bob_defconfig          | 2 --
>   configs/chromebook_kevin_defconfig        | 2 --
>   configs/firefly-rk3399_defconfig          | 2 --
>   configs/nanopi-r4s-rk3399_defconfig       | 2 --
>   configs/pinebook-pro-rk3399_defconfig     | 2 --
>   configs/pinephone-pro-rk3399_defconfig    | 2 --
>   configs/puma-rk3399_defconfig             | 2 --

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
