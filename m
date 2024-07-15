Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CD7C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 318C688765;
	Mon, 15 Jul 2024 16:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZimvOSyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA0088889; Mon, 15 Jul 2024 16:14:13 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08856888F6
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/kfvsAi4C1FwiUtyc91QY4Bh95VzWLIkKUjU2AEAtKU+R10YOtJdYaPWN5hPi1mXgi9TTwTiNLfgIg17ZUInXzC8Xj7dvaaANHuOYiSAHq+hHRH8tLD8o/bg3l8xBcjU5U2C25H94WANmt9xqKnEUAXn90ts+EsjH4efyyIHJ/fk+e2xodVVypeNnZj0gsSaWT/uMbJKcYP2onGBGWYuy35TXogvQpS+0yYlQ7VSUcf6qAsySHknSBiSjVQvA4bV69roYhba514brhnyzk27TF31WwB+gsadKVjhS3/ZIxu5RFA06ySDsbKYBHcbQn+1aJmgd3vcaevMotxvC2brQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqMExwFPKeDthXcvbBF7Tascvo84FJit9xF9qUKJ94E=;
 b=SSLEfGZPc0yew22+6cM9Rt/yvfIIxFwHAPZgC89P6g6j4BKu2WC/195Qg6bV/dAD1+xpNsNlpZww/q5ugehA72+pQsrQsSQu/aLLDPr82rKstQYmh/+JkqtqndSKIO4EicJ900Hfn4mr5Tz0rSzpMeNDi5I+6UpbffMqsFStrNXRC4SM/ZmlUlo3HzMTXb+QE69kQdvQNyBo/630Gu749esInlWbLX2Hyd4R9XUpsCOeWR14RWiLYQcN007SyeRTHnLNsd0lgxaBlXH3fQMM63vZCHd+PhTD+wJjpGO6/zMuTr6Jtm8SqO1OMDZ4QEYUe45h/St8rgeU3FcRf99Tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqMExwFPKeDthXcvbBF7Tascvo84FJit9xF9qUKJ94E=;
 b=ZimvOSyKob0UbCyC+XFn+HSczw4t8xzf3nIVBtHZqAGfdm98p6+kIkvHnKe5iwWJnlkTj9+JXzbHqxB8RCbezcF/Q1J/VXUVPFrumAyu3R4nMbtXv3BDNhf6BID97rQgRN3UaobjyLUOg9EOcdVS97HeljGCqsXO37PAwuBDHMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:14:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:14:10 +0000
Message-ID: <958e6db9-32a8-4525-a833-f13d77ab2c55@cherry.de>
Date: Mon, 15 Jul 2024 16:14:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] bootstd: Tidy up comments on the boothmeth drivers
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria
 <ion@agorria.com>, John Clark <inindev@gmail.com>,
 Shantur Rathore <i@shantur.com>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tony Dinh <mibodhi@gmail.com>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-9-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 535e874d-969f-40a0-22fb-08dca4d8653a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dElBUUhaU1pmNkw4NytEV3h4cFV3Y2h1WlFSbm9uZnM1a3VORnF6cGRaeEhE?=
 =?utf-8?B?bUYzTEQxRG5SaUhCOVJ1NDJhOGtnMzRnck9BNEt6MmJqR3J2TGhqK05iVVF1?=
 =?utf-8?B?VE1VQU5FVU5MdDBVM2toYUZWRUlFZ1BEMHhObmwyK0gyK2xveVEyK1ZGU3dX?=
 =?utf-8?B?bVZqdHcxRWxrUHNiTnY3dmNSNGoxSVJSL0tVSW9HYUwzYmhmVVd2V3AveEE1?=
 =?utf-8?B?TFJzSmNTWFRTSjZwWWs3TjgycGhUU3ljQ2dSKzBVejFiRkYzSk5JYjUwUlNj?=
 =?utf-8?B?eEg3OVd4Z09PNzFROVErKzM1K01QVEdnTWRNcDRUb0YxZFp6Q2Q5WVVaZnp1?=
 =?utf-8?B?OU10bEhKbVdYaGlkdEhlbzA0VGlpYStsZkx4bk5RS2tkajcvSVUyTU1UUnlG?=
 =?utf-8?B?aExvaDJmbmwydVU1Qk9YNUlESlNhVWViS1EyNXFFT3YrcTRkdDBJbU9EMjJU?=
 =?utf-8?B?RjlLVDk4bXlURUJCajR6ZEtZdldiN3lCekpHSWdqbCswL2FCVExHbFpTLzNB?=
 =?utf-8?B?ak9aZTNhNjlTUXIvR1V0RHZHZHdJSnA3djloUkxoMllTQ1dIWHh6Wi9iSDJn?=
 =?utf-8?B?NkFlelRhZENVZGNSRFZMRXI3Wng4MUhzd2Y1RXVZVGk0clMrMXBZa3V0VUhm?=
 =?utf-8?B?VDhUczYxOXJycUE0KzNzN0J6dnB4cEkwUS81Tmt3M1hXeHhteU8vU25MU0xK?=
 =?utf-8?B?TUlyaTcxM0FJQi9mYWlrc0NjKzM4YXBlWFBSNGhtRm50aHJnN3hnQndyMjNk?=
 =?utf-8?B?S2FnMmdpMHltc2ZaeFl0bnVjYmZidkdVSEs1UkprOFZJb1UrY1BuUUtXU0dj?=
 =?utf-8?B?aHdBdzBsM0wyOHZzV3BxQWZHTHFUWVVSd0lnMUR5SlNxcHpDakYxV0ZOYUsw?=
 =?utf-8?B?NnUzZC9VdnpJS1lYREZNWGNrZUdEVDRjbmwvWStlVWpGOG95UVROelhmbllN?=
 =?utf-8?B?SlJ5VjI5a3MwZ05PYmNzRXh3aWY3OS9ReW5BNnF6WnI0dkE3WWtuQjVib3pj?=
 =?utf-8?B?anBSblFpMHdQSVRZdUYyZitNaFBUQXZTaStKelFwQVFvVXpRTklkYnVxcVJG?=
 =?utf-8?B?UHlyUWJ6TlVpdnVPa21VNlI5UXNHQ3E1RUdTamsvZzNqcFV4SFRYTXFhTXlF?=
 =?utf-8?B?MXErRG8vM2JGMkt5b3gwbVRUQmJFUzFEOVFzWSsrUmJCZFNQSU5Ddm1PQVF6?=
 =?utf-8?B?OGpqMVUreTV0QTVBS21jemU3eUVGbWJPUjgrL2ZBbzZubWdUcnFZNkQwZzB5?=
 =?utf-8?B?OFI4NWIwekFrNEFPQ05JQnJJdjhYdjA1bEF5RGdlbjdaS2ZBTWRTSnBPcVhi?=
 =?utf-8?B?WXNoWjZUT280cGZjOG14V0t1Y3dzTnAxc3ZaOFhKYkhsYTV1cUZlbGZ4SmJJ?=
 =?utf-8?B?SVBNSzRZTWE1a21tZEJoZ1dWMEdaT1hENEpHMWp1T09uRTQzRVhaZjh3cVhZ?=
 =?utf-8?B?YlF2dmhXVGsrWDRKZ1NLRkVBOVBZOGcvMVhHc1dBV3dZamRDL0pKVWxWb1lD?=
 =?utf-8?B?OERzUWdkbHREL2hWVlNjd0d4MkNCQytYN1JhN2pGYTNOVCs1bnZ6eWFrLzc2?=
 =?utf-8?B?NE1kWHpiSEdWRXZmS1VSSHhpZWZ5dnVPMWRpcEhsSGV5eksxN05od1ZjU3JJ?=
 =?utf-8?B?aGlWc2pybWV3NGY2dkwxcUkyZlFKbUlFS3ZWeDVMUVc3U0x2dGJRM2pIOVlM?=
 =?utf-8?B?eVhRV3lYU0VzeDlybWZxTUpOK0JrTEpGZER0ak41QzR1eG1KQW1uWWZEVEJT?=
 =?utf-8?B?RldERFlDa3FLMlpnYlV5NEtJNm54ZmdWdE1ZQjN5M1R0cmhnL0pwMUg3dmRB?=
 =?utf-8?B?SEh4T0V1SWQ3RGhRMFp5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0QxMGdzK3JEamRKUS9uM1VhQW5BV3JROUVPd0Nmd05ZQVA3SmNJQzEwSkdK?=
 =?utf-8?B?a1EzVjlyNHA3bFprNU1iRitNczFVTWxRMWhHbG1ZekxSeVdqcVpNK2t2UXJ3?=
 =?utf-8?B?UTZTdHZ0WGwrVFRhZzVzcW00bjUwRGtnb1BQdkRMQ2g0SG9TYjdHZ2krV3RH?=
 =?utf-8?B?TnMvOE5VWkNHL3BWeHk0TWRwOW9QMXd0MC81Nm1GcllxTFc5a2NpbFFqRnhl?=
 =?utf-8?B?WjRLeEx5K3dhVWRHaGxPK3JYdEdab2k1OFlRY1N2V2o2d3JyMmVWNXRtdjM2?=
 =?utf-8?B?YVRBeGU1YUhMSWNERG9tRFZyM3RHUWlhd2Q4SjRJclhPRXFyT1ozaG1Rblls?=
 =?utf-8?B?MWt5bVR6RHlhVDh0a1lkMllXUjVlZ0JsVHk1WGhPZkd4RXZyb216ZkRyLzY2?=
 =?utf-8?B?Z1I4ak9xSUpwamR6VzdKaW9pd0g1bTEwc0tEd3JsM1hkcmN1b1JtK3B5OXY3?=
 =?utf-8?B?SjJraHVPUmtlVjN0UlJFRitIN1A5ZUJoaklkNGhqQXZKVmpnaEJPdk5RM2lz?=
 =?utf-8?B?TVFyS054TUxBUC9rSDZIYUtJelNhWkRHSzg3ci9hbDZoQTNmYTVmbFRNMHNL?=
 =?utf-8?B?TW45cFhweHU5dG5qMjBvU2YxR3dlSSs0bWgyQmU0OU5Id21aa3FsL1RQR2l1?=
 =?utf-8?B?cUtWTnJwbFVJMDM4UUh4QWsyV3lmMTlqL0duRzY3NDdEbU5oT0VBYkQ3L0g0?=
 =?utf-8?B?c2dvb3BIRUFPOURqM3kyQzlabUh0OVZ2WkhvVlVpaEdxM0FmYjlQeWRuZW04?=
 =?utf-8?B?MjdDa3IwQ240ckYxNGM3Nmhqbmtqdjdsd1J2enpWYS9jWnRGOFB5dC9FNVQ2?=
 =?utf-8?B?WEg3UmFWaFhWSWNNbzlqN2hOSVcvMFpWUFYxMHdnT0VFNjdvN2lQOU9CUGpF?=
 =?utf-8?B?c3oxUi9vZXZEUkFudkhLaWpnRVovVU9WYnRabXZSVFdDNVlkZ21uR3U2a09C?=
 =?utf-8?B?VFEwb1BHbmFEREN3M3U3VXdoa0hvQ2o0TlpqZ1B5d0s1VXBRODRzdWtKdTBy?=
 =?utf-8?B?SjVWMUdJaVUvVGIwdndnL3U5NFQwN1JqWUhoNmM0WkN4eGxzWEVzcWluMko2?=
 =?utf-8?B?VmRDTzVkWUxvYWZIZG5qcmN1Y2paQW8vdnEyM3Zmd096OGhGdDBsUVYvZk1Q?=
 =?utf-8?B?ekU5VjQ3d2p3T0xiaWZzb0k2UzJQWTYxYW5lbFl2cTNFSEZjSTg0Ny9ERzFy?=
 =?utf-8?B?NDd4R0tWOUxYK0xrbXpWL2NkazlmM3lIbEpTY0U1QUJESC8wWjdndjFJeDhq?=
 =?utf-8?B?Z25QZlI5eGMrWXArSmNVbmg0QmUvWmJwTWxKQThJdnRSaWdCZGZISktHMVV6?=
 =?utf-8?B?aVBzd25sUnloRUU1NVdjQmIyanVJYVVkOXFnR1VSSTlCa0tGY3J1ZGRRWUsw?=
 =?utf-8?B?dWdvTFF0VjNWNVFHTmxybGtleG9mUTB0MmRDcURhdjRuWjk2TUlvcmdVNXVq?=
 =?utf-8?B?SkEybGJIZ2NSUFdKajMwUkg3cldaaFUrUExsWVcvR2ZKUlYzTHlmcWQ4b282?=
 =?utf-8?B?VitXb1BOcGUra2hlZm1HTktnZnVTUGtMVXNaUjFoay9SRmRUcCtuSG5KVmQr?=
 =?utf-8?B?UW1hN0l1Ym4yR3A3N2FNbW96cWFYREo3dmlDOUJvWGhleTZzU2JvaWZqVWU1?=
 =?utf-8?B?SGNkdk1qMHlFV1dJTGZVQ1R1QVlCb0h2S3B6ODZJZWcrMThaVFVCZitmaVRh?=
 =?utf-8?B?R2ZrWWt5WTMyRVBYYS9BN1BqU2RHMjFtYXJMRm05V0ZkU1lEanoySWRsWGdk?=
 =?utf-8?B?V2Y1TnlwbDdocGdUVG9CMVRGZEhMK1o5azU3SEVKRnpJeFh6WDVBNUwzZjI0?=
 =?utf-8?B?TEc4aXFaYjdBblE5bkwwa0h2Z0pqaTlZdjZkR25yZ0x1YmJ2dmV3UDAzbS9M?=
 =?utf-8?B?dWxNODdoeUtLNWt4MVc4amhZeWFxbGgwNjBFM0lHWGZDekJyYzZEL3JDU0lV?=
 =?utf-8?B?QTc1RE5qeE9heURzY3c5UGlodm5nM0c1UTlwRG93b0x3VVNNY21KVlpvbXVk?=
 =?utf-8?B?dk5JOVZTQVZaZzh6dlFlVXhFS1dvUlM5ZFdnMVM2VTlvbFp1Nm4wRGpUYzda?=
 =?utf-8?B?Wi9YaUdkMVhiVkRUZDBLVjJXeFh5bzN5ejBwSG9DeHc2RVl6MEI0RGY2cTJs?=
 =?utf-8?B?UjFFUmI3NjAySkZvbUxNVVpraEZnV0NuSWJ1V2lGaktuN1dsOERWaURQdzF0?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 535e874d-969f-40a0-22fb-08dca4d8653a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:14:09.9368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig54DBQsQqsCDoIuylpCnHaI2YqE0L7ne1fPjr1TgaaQyVvJDAtisqw7cG0WEOZVpb0ICim1UBui8o0r11lCOXHsYdDSGFMeIyjgCu9KRRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

Hi Simon,

On 7/15/24 12:13 PM, Simon Glass wrote:
> Fix a typo in the comment and add one to the EFI driver too.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
