Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199ECCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBC883B1A;
	Sat, 11 Oct 2025 20:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DbsQN5Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158B783E11; Sat, 11 Oct 2025 11:14:33 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F1E83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLcAHfzbTBu6nrTlAD2zabm9xFcI75GVyJgkw/cHZYKygWbd2xrqyK+rz54nMsYu0+XV6jdbBbJIfIH0YwO3PyHRvD93lwrh821cuMo9fTkz0/kM5MQIONxwCzzUoHUKZiJHtIKDovLGqwzKx+XToKVQnzkV1vumZtqRU7HxvQHE5+tOTFn3J/zNl8d55o3cZD/AYQJAhLqVAMcxn3jhyRvq8r4YFGJgEuFL2LwErHWfHwc7FAwCjD+lG4UIfHHOiA0rG+3EVW+cMzRg9gPw4YcXPhEHIp3JBWpcPTP9v9Jkrm5Z6kJ1/4A4Y2xR/IFFKHQyznZ6Tx6vHLg26cac8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=Y10tp71DzEaqBWmsQ2hHbemQ4W+7sS7BByiuXFdI88j5n7d3i3wYClcbgHeHvtDqAvi7by+Gn1EP3yKZn23cUazejuV6kZxSpv8oYPRv53nyUT/SF/tIU9RCe6YRfNUTNWSrDDjQNDKkzZcBNAicWcUL+RMPRAuif2duGBGqsfm7DoIWBDxLlhiiyLuiL8012jf9LxQmOqjrr7/AOSRW8V+bgJKeWFt1SioS9Jmvl4K3b8+LPQREcoQXGETVvHuu9YjMPjSkdTkoko7ZxGwBvrl+U+eoYmy8VooBWk4Kw+f0aq8b08tV1PDhMKdCftmVaEfFe1yzLY2F2oLjkM9mRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=DbsQN5NhAR/gj68sF+WzaRCveRET1lRNhvaWV97yKNoETj8DZBopBMHP30CUdJx2HVMHcwaxwBqthtcfrXuxaTjqlKr+1c7hV74/4zj39bjblb4BU9iaC4O+Yr+5PYZYOdc6r3CTFzB1cfbojsowTGd7ZVOiD/z7VE3TZAyCqrxSuMjNtPN4SrieTlPwZ7dUzNdzQH62UMhZesjH+tT85IuyoMLca8416su/pPY4Kiemz0L1M/LINqv3Jpiv7i+oaYnfTahNUaZtVmisHO5ATDl+9Eee7KY9W143EriMMkj5/U6VmBBbtsVNyCQHbGrczM17rZr2kpUIQjWS9jqk0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:14:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:14:29 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:55 +0800
Subject: [PATCH v2 07/10] imx943_evk: Add support for booting from USB SDP
 on USB3.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-7-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 6505a878-c238-4593-1628-08de08a69519
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTc0YnJ3UWlCRFhTZU1pNXh4dkFhQzIzZ1h5a2o2ZnZHZGRtY1ZzQU1ZUUM2?=
 =?utf-8?B?a2tEdVRIWmdINVZLN0xkczNIdENkZDRBMmlrV2FmTVZIbVJNOFhzREVoT1Bq?=
 =?utf-8?B?V0NxbU1TL2hQUm8rTFZLU1lpZ2xtMjduZzlUVjRveDRDOFFWZXhWamhBOHZ3?=
 =?utf-8?B?Q1VDbHQ0bC9mVHN0MmVtR1VoMGY0S3lQN0MxdnRaemk4MC8yRHc4WFdqL1Bl?=
 =?utf-8?B?cWx5VlRlUktnUk9IcG5oT2lSRUxXYUxlVkRldVZJMkdONStWUnhWandrR082?=
 =?utf-8?B?VUpGVTF4L3FBUkplTG9tODNSR29JZnBEZWdlSmJIU1g3RDdEd3prbHBtTlhL?=
 =?utf-8?B?TTdzSUdoeGxKYjFqb0k0M2VjOHNveGZGTlJOOUEvY0pBcFVmcUx0ZFNEUFNZ?=
 =?utf-8?B?SmpBSjkrTnhtZWM4ZXp6RTMvTmV0RTNQaHhXb0JtSW1oREM0c1hxWHVTcTNI?=
 =?utf-8?B?SWpjWUkzTmFDOFRYS3orbkM2bmVLOTdoeDJTay9rUjFhbnNhM0pUUzQxYlhB?=
 =?utf-8?B?Qnl0Zm1ZemhMcFlpYXBOM20xSWt2emZBa05jN0Mxc0xlQ3hyVWdkbldhVE5p?=
 =?utf-8?B?cHpXdEFZTjdaczBURzNJZVd0MXpWUU5DRmdIMG5WcHZ6WDJPVXp4dFFIc3Vv?=
 =?utf-8?B?UTlWTFB1OU5xbEFBdkNLWWhBZXRJRmxzQmJER3VhUkc0TkVpSHlSWUV6RlBY?=
 =?utf-8?B?dVZkQU1WR0tESStPRGJiVDRTaEs1S2RiTGhuTkF6R3BncXZXSnFaOTlsVmJX?=
 =?utf-8?B?Ry9TTmdZMjlRSFdBRm9LTG1JUUNBaHBjdGtKeEdRNElndUNWMVhPZ0xMcE5O?=
 =?utf-8?B?V2lyWlp4eCtJR1JWYmljck10QTVhSEdZenJWQmFCV01EM0MzVGVGd0RZNm9Q?=
 =?utf-8?B?cTJQOWh0V2N3RkFGdWtlOHB3ODNKWXo5VHdGV09mVUlPcW9paSt6MUFhdGgz?=
 =?utf-8?B?Q2c0cjNGSFV4c2pQT09pMDAzZUlHeHBCWWdTZUMyWm4vTWEvREVLd1dEaU5X?=
 =?utf-8?B?Ykp2U3p0cXl6K1BrQjZUWVI0bVdCRXlsV2hwVlV5eFp3L1pNK2hBOFpuL0px?=
 =?utf-8?B?WkZPcUVtbDhoK1NYS3o2UTNkMGM2aWVTTDhmSHQ0TVhjbUs5V2d5Nlh1Zk85?=
 =?utf-8?B?WEpIcE4xdml1UU0yU2VKT0tvSVpWOURyR25rVDN2eVAxc0ptMzdsOXVvWGUv?=
 =?utf-8?B?V1BvcXlzRHl4U252UTRRUVhQOVlmRHZZYTJBYTlBanY2dlY4Q2s3Ty9qYmtM?=
 =?utf-8?B?d01FTU5xREluT2ZBTGEyeUVQcDNUbHdLaDlxSlM5SW9ZTkxOeFZaS1Q1Vnly?=
 =?utf-8?B?SEFtejN3SGpBRmhSb28ybnNBTk1mT01xV0dHbkluYmd2MzQzMURzVFR0U2Jj?=
 =?utf-8?B?ZElrUWNGMEF4aFV0a2Y3SjVXTmhQK0FUWnNRTUNCRGp0aUgwSHI1cU5nNnFU?=
 =?utf-8?B?aEthbGsvKzJUQ1hsYXN4ZWNyZnkxU3pJQ2w0WHZPQlpCNTB3OW5yajJ5cUg4?=
 =?utf-8?B?NTJVbkZ2ZDloazRBbytVcStpMXdVNXdUUzhLQ3BDYkxEY0xLMHVhNkVPa3JC?=
 =?utf-8?B?WkhSUi9QRWV6VEpHdWRHbUNaWW4rTmtnNGlJVmROMEd3bWtUS3Y0S3JXSWp3?=
 =?utf-8?B?dDI3SlBrREZzZXRCcDVONGdlanV0UnJ6RUhNSUFNN2tUT1ErMXEveDFpbTRm?=
 =?utf-8?B?RXo3LzVtR3BmenR0R291aHQ3S0ZXeTZkUlkyRG0xK2xzOUlzbzQ0K3ByQUJP?=
 =?utf-8?B?Slk3UmRVSm5rTTVleFZ6S3A0TlVyNklyV3Y1WEFuYjhkNHU0eFN3WWl4RFU3?=
 =?utf-8?B?WktUNVljTEliWDZ2ZG8rb1BoZ1ZUVTZIUksxZURMZkczNHRnWitPZll4dkxy?=
 =?utf-8?B?NTFFUTNCQXFlUmliejNIYzBHUXJZM1dhanowemhvcmd1aUk3elU2bkVzbHVM?=
 =?utf-8?B?VnZNeGdRRHRkMmZvUFJYelo0a25VMUNoTWJyNHlCTUo1aUtWOW1NUnM0MjJx?=
 =?utf-8?B?VHhFTkIrbTRYdnRGQUl0c1lDdlBDT2FwZ3pOVVFTR3k3eUcrNnNLcXM3WjNw?=
 =?utf-8?Q?grw1V4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFB5QlgwNWYvZVlaczJDU2N4T3NaWjl3SnVYZEUyV2ZWM1FORjMyTThkQi9l?=
 =?utf-8?B?NWFhSDJkQXRYUFFILzBtbXF1UmY0em9qaWlLcWtBaDlOZjI4ZVQ0M0JBaDZV?=
 =?utf-8?B?WjVZRWhaam5hK2dQVmgxc1VpVUpOV2J2eUJNSVVraGNPcXpNVmZaR09zRS9I?=
 =?utf-8?B?VUwweWhrQklLdXd6QlB2d2ExMHJkRzNlbE5waTF5R2pGdUdlQUpHNDlEeSts?=
 =?utf-8?B?VDEyNVBnQzBjN0tCSmFJbmdZWUdrR1FaYWxpR2lBZHord1NkaTErNGNiVVlD?=
 =?utf-8?B?ZGNGZXRWVGdFbEZJbXZoSFIvM21weXMrNjJ0SjlKM2JmSmNzdWtEYlZ5ZlNu?=
 =?utf-8?B?U25JVFF4d0tzdGErbm1aVnlOcnpwd3BRQk9aaHRUaXFnblYxWjI2bTljNXov?=
 =?utf-8?B?d0NsTUhFVGpEYy90a3hKOUJLMmE5amx3RU1wY1pKNUJ0SDY3Y1R5RGJFQldR?=
 =?utf-8?B?TTB0b25lQ1pSS3NoRzFKMkFSczNzQjRBaUEwdStFZmtsdUUvUzE1NjZ0YWtu?=
 =?utf-8?B?ajA2ejNwaFFZKzlSRGp1RTFiOTJwRVBSclgvOERqZCs4ajFwQ0h6WHVnYWRo?=
 =?utf-8?B?bzZOdFc2Vk5zU0lRZHd0UXlvRFJ3ZmhHcERBZE84T1hFZlN3cnBNR0VBSnBD?=
 =?utf-8?B?cXRPclU2ODJWSHREc3dWMlhzb3Ava3pIN1lJdGlOMG8vejV2LytJSGd1Z0tS?=
 =?utf-8?B?a01YaVVkL2dJZndUVm54NWRDb0IwNlRySExEdkl3em5BWEFwMzhMczhTMm1C?=
 =?utf-8?B?MkVLNGd0QmxrWnVVN3k4T1N3WW1aNStTdmVHbGV6bzFUSFpXWTk2MGt4THRx?=
 =?utf-8?B?ZzFRdDNiSFpCbDRXWTFtMkFlMXN6WGZaMVJZc3l3bVVKOE5rblR5MVhjK0Qv?=
 =?utf-8?B?V0VuUmp6MStsSzdhUlh5bVBpSkNjNUNQdzgySkNTMS9FNDJWZ1BvWnBMY1Ft?=
 =?utf-8?B?YXBKZGlwbm1KK2JqNFBXU3dyaDhlbFoveXA0S0QwaTVlUFc0UGRuK3JlaGYz?=
 =?utf-8?B?YXd3NjFoUzRHY05mVG56WjJRVVFjTGVRWlgzQ2pKQmVESkRxbnVZNGJOamxu?=
 =?utf-8?B?dVJycVdFV2VDQ3BVaTlXVEhmbzV1cnZZVVA1dm9CS3g4Q0RUM0dYT1FYVlli?=
 =?utf-8?B?R0Fkb2xHaEtCZnVyeC9Ca3hUcm4xbG51ZHlLbHpyQXNUWVIvMGlHOUFoUWoz?=
 =?utf-8?B?NWxkcjdJL0ZvczlIRGZBQUNvMHFGTTV2VG1CT01XNHZNQmVUY0p0Y3BOcXBv?=
 =?utf-8?B?MktTSm0vdjJMRjJXNlV3VHlXcU9lTFMwZkZqZlZzemFnVjBMUlJmMkdqemtt?=
 =?utf-8?B?SkY3V2dQckpZUnhhRE9pSUluOXF1L0wreU50Qmw1L0ZYbUJVTjBkZExuSUxJ?=
 =?utf-8?B?My82ZXVaNEVDM2QvZjlHM1hrUkNjaGIxTDVqaWZqY2hSRVdRbGJLcUg5TTZK?=
 =?utf-8?B?eFp6bXkyNmZZUG1zSzQySHhINXpuTnBQT1ZaM0xjc2xZeE4xWWV5cDllTmRn?=
 =?utf-8?B?WVlIWkxUa3RMYWlBeS9uUEhEb0FGM2lOSlJzSzFoekVCQWgvS3dqeUZOWmxh?=
 =?utf-8?B?cFd6eDhoK2lOZWlvenM0MXZ2by9hRDJhekpHblFJQi9NZHlnTmV5UVhDZWdH?=
 =?utf-8?B?Ui90djhNa2pDcFZZaUplYUtrQjFXUFRDR2JOelkrTmJvR08rSmdKUHZFWUdl?=
 =?utf-8?B?N0V4cjRsSWFLK1YwYmRLNG16VjhXMzl1dFN3UG9lUTBCK3dROWlVOWNoUlo0?=
 =?utf-8?B?disvWEMvZUNUdGxxNWFXSnNlL01kRXBnZlJ1eHg5Qm5zUFdPS0IzdngyUTlp?=
 =?utf-8?B?NWduQnV4bHA4OFVIaUFweGcwUXBOei8zYzNVSDNvRzUrZDVGWkw0TU9pdk1u?=
 =?utf-8?B?NjlMTCtGNkdha01zTHVvOVRMc0lkZTlYTUxOWnhKQVRhb3dadE04cE50L3Vv?=
 =?utf-8?B?a09pcHV6bTJIbVJaUUcvL1BGTTAxK0NqeEZNL3poMmsvNGlCR3lyYlV2MHZZ?=
 =?utf-8?B?bkpLZXI0eG43ODN0SGdzRzhDYStuaFcvU3RhSXg1bU9VQ2pJc0g3UWViL21H?=
 =?utf-8?B?Zk4yK042SGkrK1Z3djU3WnczU1NsQzdQWElsNDU4bVp1K2xGdFVQYk92djc2?=
 =?utf-8?Q?QEMso8RphGc/gyi1JffZEyKXo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6505a878-c238-4593-1628-08de08a69519
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:14:29.3334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9L+d6uApOho2bPAllQgvpPF5x/XnydrWkniQ8rW86Bq0HVak2m2NC+xwYk9jXOfvJeWcvIy/q60yrp+p+cTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to enable USB Gadget in SPL to make i.MX943 evk board
can use SDP on USB3.0 interface.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 24 ++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 40 +++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        | 14 +++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index e6abe7ed2e0..3995176f090 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -22,6 +22,30 @@
 	status = "okay";
 };
 
+&usb3 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	bootph-pre-ram;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+	status = "okay";
+};
+
+&usb3_phy {
+	bootph-pre-ram;
+	orientation-switch;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9b2c1072366..8c89b8be04b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -199,6 +199,46 @@
 &{/soc} {
 	bootph-all;
 
+	usb3: usb@4c010010 {
+		compatible = "fsl,imx95-dwc3", "fsl,imx8mp-dwc3";
+		reg = <0x0 0x4c010010 0x0 0x04>,
+		      <0x0 0x4c1f0000 0x0 0x20>;
+		ranges;
+		interrupts = <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "hsio", "suspend";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+
+		usb3_dwc3: usb@4c100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x4c100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_24M>,
+				 <&scmi_clk IMX94_CLK_32K>;
+			clock-names = "bus_early", "ref", "suspend";
+			phys = <&usb3_phy>, <&usb3_phy>;
+			phy-names = "usb2-phy", "usb3-phy";
+			snps,gfladj-refclk-lpm-sel-quirk;
+			snps,parkmode-disable-ss-quirk;
+		};
+	};
+
+	usb3_phy: phy@4c1f0040 {
+		compatible = "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
+		reg = <0x0 0x4c1f0040 0x0 0x40>,
+		      <0x0 0x4c1fc000 0x0 0x100>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "phy";
+		#phy-cells = <0>;
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+	};
+
 	usb2: usb@4c200000 {
 		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 		reg = <0x0 0x4c200000 0x0 0x200>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index d308d29a1a5..e4fcf2eb576 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -100,6 +100,8 @@ CONFIG_IMX_RGPIO2P=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
@@ -114,5 +116,17 @@ CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

