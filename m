Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB87CD5BD1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 09:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D32844CF;
	Tue, 26 May 2026 11:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d/D0uljF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890E28404D; Tue, 26 May 2026 11:09:19 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0CF5846AA
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 11:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nacJ65Hnccm5qWpJ9Ke+rYfkLx/L5Zk+u2ylppGHgEg1URDG2WgxGU7dZ+byVYQoJ3tt9o7oh6iA1ydsq+fdQCMn+r/xJGBNDovXijgx/Ipl3EJfxgA1iRRNrHKAIIFiSvh5MPRV8zM5He6zeJOzqf9CKx3vDfCqkoPaWRvd0ux5RUnP63XfqV9QXwcG2R0odCffM2Goy2Gk74GP6Y51shyFKWUqVkaDuVT3ueJpPcV9JHYfWb9lqo3QY/bTzXWEdzQ9FpJeg9Ra/4SpBcezcuk+aP+/yrI0PXKkkeUgdYIYzubqXTlEy+PqYIXaulfHFxMIEHgh1G7aZUtrf2oybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80nYvQlZ3Mr4XcsJsGN2E07SPXzB4V/Hjg+GRmULXlA=;
 b=RTqTe+I5HFpSOX9d95fdh/5KNEQxjILcUTlfIuGd8avaRNwd/kMlqYbxiSudzYDli3DpgVXN2U6gJ0ecX0quVLaGP93TzPWn1npR7sv6X4EfBHp562KBxDVIlFvdsEYftSStCprfJIw6rk9UC1k4OW4NF/5cni2HMQHz8MYxrW6mA/SR+1qLjHwPa+hGA19866f5OBrhpj4bjuw+n/81uGhoP+CKY4dztTNW+/nfV9XegXhgz4tOUWjZLuiWogM1cZpiTGaG7jmWjvf5kFlOK7sz+FqxbRHKcqcN/VNnYoMKEc9XN2o5mcQg2y4twkmLtn0YheTHQCqAAh1LjMRyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80nYvQlZ3Mr4XcsJsGN2E07SPXzB4V/Hjg+GRmULXlA=;
 b=d/D0uljFVO+DbXD2lCCUH1dAHzf2j/QPR7176GSRsyItiuuHXfGthJffXagz6zWF5lp9xhaQXn6ep3olBJn6hSaHSM2aAbXtk5nIJ02EumJ5t7GDfy1g58Qh3iBXD+8Ez9q/G4r39W2IDPviKCAhySUOflp5u02pgjPbRK4BBtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7347.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:09:14 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 09:09:14 +0000
Message-ID: <e86f95c0-c25e-4cd0-bd21-fec13025a557@cherry.de>
Date: Tue, 26 May 2026 11:09:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: v2026.04 crashing on Marvell Armada 3720
To: Ben Schneider <ben@bens.haus>, Stefan Roese <stefan.roese@mailbox.org>
Cc: Tony Dinh <mibodhi@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
 <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
 <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
 <CAJaLiFzGYZ89B7LD7z6Mese0iH3-KqM8TFbn5Vkx11Zjr-7MrQ@mail.gmail.com>
 <aU0JJd40MuUFOULadJri1Poqfq4wrvGMF7zrdOEucjI-loO3N7kZDYa32JIaXoDBcusnMxLPEuRcBTPvSkfnSf3p_0Pn0oZPXHTTZXSn48M=@bens.haus>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aU0JJd40MuUFOULadJri1Poqfq4wrvGMF7zrdOEucjI-loO3N7kZDYa32JIaXoDBcusnMxLPEuRcBTPvSkfnSf3p_0Pn0oZPXHTTZXSn48M=@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1731f41c-74db-45eb-ccd1-08debb06750c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Fc/MERKbnAOLHb+h6u/4OV9D4I6Gq7vKi/mnmDQeFXBALW2lnuEEKkNtYd/aH0EYMuIDENw3ve51Svql1lA2umkPzVqTOaqG9Q13oe1vVBDVL0NulzdiCHmzz7l5+uwqF9qadKijwrrL8+WaxJOq1Y7FljDoKbqUrn0f/+d8PWUldhgzyWrmyikjMt7awJX8iIqnboFy7rESbdF1tj7fe/O96j5DzE/Rp40e/5nPKJTJnxNThw8lDWqRh0qccVfyaudxPr0Zi4eXDZO49OSgu02cp08QiiPr3hSX7UBw8pxM8kc5G8pAVbE1eWQXRB1MunGUrSSRtENSm8R8j2a6z6n8MUFsVCmp+3bDcmfNt4bRUZZPpyZiCtYGSbXquT5s3WBwuEvn+teuCPR5l0Xkj012HDVB0JXT9gWyqj543EfR2OpWTGUHpHj1yfBcOGWA+Rl6PGRpKT8BlQX5Wd/cj1PpvjJlJwCv+fCAdLl87Juk9szQ/n9yIzLswh+tZE9Spgj5ByPQknQs+NBigxYxQmMH/rRZQiXauUx12a9jsQMoJGRFTCqa0sXA4KQ5dHp0+16m/fAukcMqxYNjZkuiZkO37auI3+uYHE2F/aDNwkpYYM4YDgiYIrXbWDyisd3pARPQVjidaGETh3WcaSKb4gqARO09lSdRTyDicx3UqGfv36ojULl5Ldk+iUsAwxio
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZlaUFKWGxmSm5tY2U1ZGZMYW13Y00wUlJnY09SK3ZEUmY3VmpJbXBpSTJH?=
 =?utf-8?B?cGkyekwxZTdFeFlZcTRMYjZQTDh6TTBJNXlzSHE5eXlreCtmMmtuSDFaYVVS?=
 =?utf-8?B?azYwTVpzb3AwK3VUNFVvNUpIOTk3emhYM04yMWgvMDg4TFJMOWQ4MkwzMGlL?=
 =?utf-8?B?Rk1KOGhjWkt6T1JmTDk1dWZnV1Z1OXJaYXVJOFIrckNUZWhRaWFpeE9SNE5m?=
 =?utf-8?B?UzRaa1hDbXIrdmZpaDhqL1NFMUNEdmVDZThNZ1JmWUZISy9QSFRwQjREZHBV?=
 =?utf-8?B?SWRrcFhPVjZCK1VzakZjdlljd0lzL29oN3pBcmplWmU4V1ZXc0JiN0ZFS1Yv?=
 =?utf-8?B?MzJnQUgrbXFyajhyOGlhVGFuME11amFIeE1xVnZmVUpLa3dUM2Y0VVlnQWhK?=
 =?utf-8?B?T0htWStSUmdzVVNDLzgxRzNZNUxCWlUyaHU4RlJrWHlrYytBM2tFVlV5T25h?=
 =?utf-8?B?OWRwTjlVY3hLQWhvNllSOVhaMk5lN1dZT0x3bVRBRFFndEkzVU50S2FUY2dr?=
 =?utf-8?B?dzVxaXhCTWZTRFhwRnNzeE11eGVtZm5jSXJSWnA5Z2x1R1N1bCtaMy80R2dw?=
 =?utf-8?B?Yjl1TFBGbEJJL0V5bXpZRGx6dzNWWWNQaitlbTlpRjFPNk9mckJ5N2kwWnc4?=
 =?utf-8?B?MnBpSC8vaEdTV2ZKMW9SRjJMUG81Ym1IdnI4OFErd0EycnA3QzNLeEpwWHRw?=
 =?utf-8?B?MENMdndqV1YzZWUvbGV2SFU3bnJvd3g1ZU03ZVpRRTYwa2s4WisvL2ZhVHdX?=
 =?utf-8?B?UVVlVGZEczlZUUxoNkZRbGJUTEkxL09YWDlFdjZlQTVMbDY1WC83d2ZqeHBV?=
 =?utf-8?B?SDBHd0FjdFdZWTBXVUZzaVgrYTJyeTlQVkhGdnhRdGp4OXVIME5FeXdyeGp4?=
 =?utf-8?B?Z0wzSFBEM0R5aGJ5bi9KZ3Fwb2c4SmdBZVg5dmNPcXdxMDlQWkN2R2t5WTZm?=
 =?utf-8?B?MzIrV0piZlNhZmpJT1p0U2k2UDhaNXJSaTNiOXJiaXBVVldESXRiS3dpKzdP?=
 =?utf-8?B?Vmg4NHBMYXlEeFlKM2lMZGJWZTJidWdZQkdFUCsrYzAzSHFERUxQd1JydTF2?=
 =?utf-8?B?SUVEM05aVytQeVMyWHRtRWJ2YU52SnF4YjNmQ0t4WndRQ1pkck1lSmtoL2l5?=
 =?utf-8?B?SlRXbUtFT2p2VmNVeXhNbkZlT1lVTVQwbHlZeXFRbmVabGx0Ym82NUI5RE1h?=
 =?utf-8?B?OC9IbngxL1JoNUZzR2hMZjdMUFVldE9xQWNLUVB5SW4yRitDaHRCczRRbEpj?=
 =?utf-8?B?SjFOcTQ1N2I5TnZQd2Rya2lucnZyVDZCK1RYUGJhVkN6RXNlZVRWc2dFOTFr?=
 =?utf-8?B?c0tKYWNFR0Jhd25rc3VZS2c2Wm4yVWtJL1BTdFpKdlp1T3ZWS2FRQkw4QjhQ?=
 =?utf-8?B?YkJKV01telIzOS92RE83NDhiR0Z3ZFpwUVZIZ2RFN25wVkhsWElBcmc0R05j?=
 =?utf-8?B?UUQwTmovVU1pcnd6MEtOL0xrcExwQ1RDbDBEb1dxdEltSDZ2eWxhLzRzRzZY?=
 =?utf-8?B?T3FUT2c0WWhaM0V2UHVndHRDbVZETDlkNW9GcWZUajhyRThYSzVlT0RCbEtE?=
 =?utf-8?B?ajhWc1NJV1lDWG1UUUZiRmhiQWxnQXlFZmtaaWlwbXc0MWtheGMwMFVJaW1P?=
 =?utf-8?B?d2xzWXFHU0dqeEx0eVU0N0hPSmpXbkkyUHlVVXVDZTFJOVhkTWEyeG1mdnpz?=
 =?utf-8?B?eXJKZGlVMURtQmluKy95RWZhN2NLNzV6aHF0c2VjVnVDcWg5aExuYmx1OHpL?=
 =?utf-8?B?eVlCRFloTS9YNFRVdngyWXpKNERndys3VTE3bTBNbFY5b0dDTlAxRzdnaktk?=
 =?utf-8?B?bFg3OXMwQWcyS3pWb2xZbDh0bjN0UTJLaldiR3l6dTByajFuRlM0ZlgycmpF?=
 =?utf-8?B?N1JYZ1phWFcybXVOMGdYTjR6ZVJIS3FwYkpLOWZOTUxRWkx4TlZaYU45V1pX?=
 =?utf-8?B?Yk9CM3NjcitUVGNwUkZtTUZiL25LSXd2Qk4yNk9iRERVQnhpZktZakFGOE9k?=
 =?utf-8?B?cmVyOTAreS8xbFcxazRiQzMvR0NRbGhxN1YvZDZkM3RWQkNhSnhXVFdrelE0?=
 =?utf-8?B?SHEvN3hlcCtSL3JiN2xtUWJCTDVzK25ZVlBNK1BXWHY4RDBqZkUzVWRlQjJj?=
 =?utf-8?B?TnBEaldjc3Z3TTZIMU12UEkxaE9Hc1AxSm04bVBDT2NkdDY2aHFsQXlaM0Zh?=
 =?utf-8?B?NCsyckRxbXVwTFEvUkpzSXI1amtCNzkxajdGdEZlaUowWk5DZlUyN0FnTWdm?=
 =?utf-8?B?MjNiMlM2RWNFZHhSOVpjUFppL3NiamJxQ0cvZW13N2tJQmIzU0p4M0ZkRVFH?=
 =?utf-8?B?bU1KUGJvMDFNcFdOeVFKYXc1TWlJbkw3UmxFaEVGK1hScG5UWnFIZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1731f41c-74db-45eb-ccd1-08debb06750c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:09:14.2723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOmaAyb9R7ds6/VCN6ckkeFBwH+BMWJ0cwHDU0tdRnFW0ivlb3D75lWTnsjcj+jrWRt6i25X7WcW0IqCziJ2YoMFYGrCSr1b10Xsto1+pPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7347
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

Hi Ben,

On 5/25/26 3:21 AM, Ben Schneider wrote:
> [You don't often get email from ben@bens.haus. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Stefan,
> 
> On Monday, May 11th, 2026 at 12:45 PM, Tony Dinh <mibodhi@gmail.com> wrote:
> 
>> Added Stefan (MVEBU SoC maintainer).
>>
>>> The first commit to cause problems is actually 217cf65 dm:
> core: Default to using DEVRES outside of xPL.
> 
> After a lot of testing, I think I've traced the issue to drivers/pinctrl/mvebu/pinctrl-armada-37xx.c. There are two calls
> to devm_kzalloc that, when I change to kzalloc and remove the dev
> argument, my device boots again.
> 

Can you check the value of info->dev? It's not explicitly set in the 
driver so I'm wondering if this is simply not initialized?

If that's the case, then I'm assuming

info->dev = dev;

in armada_37xx_pinctrl_probe before info->funcs = devm_kzalloc() would 
probably be the fix?

Cheers,
Quentin
