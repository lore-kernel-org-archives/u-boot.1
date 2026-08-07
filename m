Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A68C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 403BE60A9C;
	Fri,  7 Aug 2026 16:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCLPkAsLdg2n; Fri,  7 Aug 2026 16:20:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B021608F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119605;
	bh=BX2Ei23huLIJzorg9zh4yRIls2EAjWhRPKoKHGi2Y0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXvCdpP5R+kaYlP3m3F+t4taqVGrDDtylu3KIqAoR1FYw7mEYwQHXinUOovRcyGJ/
	 ralT3nisTIglncXdoDTorX3De3COGXi6p03+6MOc19QPIPYSTedBa8BFXi46w9JoGo
	 E81i8d0lBBD7mWfijANUzXgv/2zlCvG9SWSOkiuR+OYMAQ9SD2AYHgKvlsiTc8yTb0
	 ZyWFElASn/r3LTAVq/M8LHZJqt7jxZaombu7uenHQczK4tNPFHMjr93xHNGowqfFcU
	 9N1ddDDGOz++mFsfhvl/RaJ2KFyJkU/OZIharyPO/9kN6LeuhP3rtUIvEjfflFAl9o
	 0cEbNsxDq8Neg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B021608F0;
	Fri,  7 Aug 2026 16:20:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83D352F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69C50409FA
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKo0X9pKn8QV for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:20:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 928C040A37
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 928C040A37
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 928C040A37
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M95g/32rO2KjBBayVSxc6E9wJ/2OY5KxFXoZTeyROQOQDLmbtHAO+OfiPRs7lxC2yfajzFhHMfTCEcvlrBfUBL8d/KOKT05buezA6z4twNQPJEtIvJXDmJwD5qE5T2806Q884+Q+3vrUhKuDF5cqdLrLga1/L1+j6JyfZ9z+x2srdDnVtjqfnrPnpK4W0er8kShkoJJj7+IjinhN1BZps+0oVFC7e+Cc5OpFXPQC7P/dMLbuRgN7XhH2eJ4D+HukpGLPFWavJWeNHdM1ruyIAkhExyUvWdkaV0gNfd7yBciANvEvQucBW328m2T1m6nqesaKwWKL7iMuybMlWFA7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX2Ei23huLIJzorg9zh4yRIls2EAjWhRPKoKHGi2Y0I=;
 b=FXw/lqKDjKotR2qXSVeOYCXP0K/7Tf8hnQd8zGJbVYMrGmMuNnU8vZMeiTDO75bvh3wa61n2enCR7wFu/enUGOhmVBmvYDGpSkJpUsI+49CzmB+MMreY9jIaBghkcmWXF9y7PyQ/FntChzxh1ngkDOEQ/3DLLJVGGeFqI/kLAKuMlSMT5bHfmB55FopMWjLUkNqLoX5B1MnBD49DaCZJGHF8OWi+rIjRvXcH8arjYLAQuvREEiqmQ1PsBKvFOUCtUWPq/dl3hpmPpIEk1usFax22gyS3CWUt1zyyX6D/TeCIVDJK2DMOXAkUiJ2VhwlAdhabnhT/+GWYvIkc5ntZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM9PR04MB8146.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 16:19:56 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 16:19:56 +0000
Message-ID: <403becad-7558-4bef-83f9-331e8dd42db4@cherry.de>
Date: Fri, 7 Aug 2026 18:19:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] clk: rockchip: rk3588: Drop unused GRF syscon lookup
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-16-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-16-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::7) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM9PR04MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: dbeeb07c-70cb-4fed-8ff0-08def49fb866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|366016|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Baw/bvj08tA2G1ES1WlQ9M/IJFgbwjyqiZJTz3dA/chlk4+HmtYZ5KZonIVq/bn+H0q60oBY65dEXigp+iXN0gnOfZbpoIggLtFqkaNdc9CQo1NWqcvHhI/ftav2Aoj/OpLVKkwzrbLElxQ3EWpJxRJwRZZ4l634TiotzJPRF31STofhnGCIbDyb7yqGl6COy/NSHwUthnNyXle50aqENQ8P6UyLMxdoN4WqN0rMHheHNoN+rX3H8NZvriZiPPcuyHetcvpt9C/gm2FdNEbl5NJGXRDXv+a8oO7NS5PG6NoeiogAalVgrhuY1wzKeTNjklZ7RbjFN5cOjbwZ6i7f3dvMJisTPxbg3Bv5nzowDup6yM66VSrofXiTxuMGOP+Z6sdLztq2xL7jQ2XPfBxfUbA3Yk9HIVUY6aJKgkouFgIPU6518gUCwPRCvD/2fF7dNmcD/3FA0MuQW49Ww/yQQS1F1w/Kp2f9FUAcxLh9q7RevtfExtqdEuYmIrLVNBYoAn0h1cmyI07rIllAUAhwlpl5P+mBXXUwBP7FB8Ycq3d1Dg2iavGp8YSg5JtKia7lvRIflDrvac5dyZLosMyyELJ5Jf+sq6CQiZc/JPF1xOHwM7A9pPwYbVh4D6yHxT/x+4vWOqtg74f2lKzIOXRfKt5ulUqYRgpJ/eBoHgznnXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVU1MVRiQ2c4MGNWa0U2cFd5cUlSNExyOGxENG9NbEh1eVJoRThqdC9XOVR6?=
 =?utf-8?B?NUlsOWhVeXA5Q2VHUVZCc2VCTjY0TGt3MU1jS3MzV3R6TUsvN0N4MWRIbUxl?=
 =?utf-8?B?TFVjaEpxYWtuSU1SSEU4K1F2aStjd0U1T243UnVFc2MrbmZUdEJRN29IaWlw?=
 =?utf-8?B?V1F5dklrNkF6alpnMG1wZWRyWEdhMk13YnhQeDlhS2M0YUI4UC9JSzE2WFYv?=
 =?utf-8?B?WGZIc2lJeXRDNFZQbGROVnpaSk9CM2tsVkdoS25WSUVwdHVOeTdkM1IxWDNN?=
 =?utf-8?B?Z01PWjF0ZStsQVE4djIwS04xaTBPTTEzaXpJeTZ2QlJrSS94Y2ZwK1lpT3pw?=
 =?utf-8?B?OHVDOS81OWpweUcwNUN3Nmd3UjdLc05tZEdDcnBlaWNIcytaWG1ZejBmZmw5?=
 =?utf-8?B?NUVxZytwS2JldDMzU0RHcEFRcWVFTXpLZHhZS2pZYnhYZXVtY0MvTFY2S295?=
 =?utf-8?B?akpnWmpkeVhua2ZwM2tNMmtjcnltNm1hbVBEM1ZaWmRPWXc4Q3VXSlRoemts?=
 =?utf-8?B?R2JpUEZjT1Bya0R1b1p2enBoQ0Q5TnNwVFRyY1ZPQ0NtVitXanQxS1NacndI?=
 =?utf-8?B?NldaNHQwdEdZN0ZGWE1DTDI5N2pkMFRUM0dmKzdKdmRXQkxpNlFrLzJMTHZr?=
 =?utf-8?B?aVhwRE94b2xxZUxOUHpQakR2aTVsaCtidjJ0UE9GQmk2UjVpeVFGV1pVeno2?=
 =?utf-8?B?Q1V1UHpPd1VTNWFIVGw2LzZ2NFFuV3RaY0IwL1pvd2ZlYTdzb1RWdWkzcS9E?=
 =?utf-8?B?emhVMUxsbkxYRHBvTU5tdmhxa29wRTZibzRGKzhYZVplMktzdUdxd1dKcXND?=
 =?utf-8?B?VGpqSFpFbHFSNzNhN3h0V2dXL2lNNkpEM2Q1OVBzR29CaXB2UWtocHY4aGJt?=
 =?utf-8?B?VjU5V1NOMjBodXFYWi96UVI1ZnlxZlhBNXZYbWJBWUkwSnJJL1F1WUdNNzdP?=
 =?utf-8?B?UHFiSkJRdzQ2WHVQMmd2cmhYRHJLbXFwcHFHM09lK0Irdk5wSnl4SmdVUVBX?=
 =?utf-8?B?aXRsQVdZNVp0U3JhT2l3TEtIOG16aUUya3VScmVTYXRYR2Y1TUFaYWdKU3BO?=
 =?utf-8?B?dGlRdXNCbExIVGlvTWp2TmRNWFFXL082S0JSZzArVTJKeCtwU21FM1hKNGt5?=
 =?utf-8?B?b2NWMVRUb3Jac0s3Wjk5dHlEQXVXb1RJVkhIU0RQd0VKa3hHL0FJSklFVzli?=
 =?utf-8?B?ZFJUT0laVGFUVVIwdjJYWmZ6eHZMeXFGa0RTbjNkUDBsd3d3NU5hcXdCdnJM?=
 =?utf-8?B?Q0ZFaWNyRlhLNEphMVo2UjNRaDdLSkxrY3hKbUptM1hJSXBZZ1BJdWM1aHlm?=
 =?utf-8?B?c0dvbytKL0o2UkJtY2xhQnRzd1U4TE9OVDhmKyt0ZTB2N0dtK0JEc3lwVVNO?=
 =?utf-8?B?dzQ4Zm1RbDBNODFtdmM1T1VRUkRDNTV1Rkk1UVlicm1pOTNwbDUyRkpJSnlC?=
 =?utf-8?B?dWRmOFdaSkpRYlIrZ0FvR1hlMnUvMXJQTkJleTZDUEhrYmRTVGZNREpUUGZC?=
 =?utf-8?B?UmEwOXZiL3F3WitPbmQ4OGJ3emFpby9OcElqZW9GNnkrOGF2c05BMlYySGNi?=
 =?utf-8?B?b20rNjNTN051bytJZ1B3V0VGL3N6OTdGUFBlVGZkR1RrdjYyT0NNL2sxUklm?=
 =?utf-8?B?dEgrMktuNGk3Tm4zMTkwekMvUHJkQlkxZEFMV0N6NUdlNDNzam1MbEkzaEVN?=
 =?utf-8?B?U21BMVlLQnpOUkhrb2plOEVXY09mK011QXJoN2ZmOWNRYnpZdEZIS011ekdl?=
 =?utf-8?B?eDFHbGJkWjcwWkZNdldpa1RGd0NLMS9QMTQ0TFhad0VJUjB3TzF2L2dYSFhN?=
 =?utf-8?B?TExXbno1c0ZDS3FmYnBxZC9YRXhwY2VyWkt1eEVSR21rckRiVjRTbEcwU21I?=
 =?utf-8?B?UEpHemxiT1JiT01tZDJjdC9BREhuaDhkTmthcXRqWStSanRxazRZenlFOUkr?=
 =?utf-8?B?L1hCNHhHUGtmUkpjcDlEYVVxdXRhSDl6REg4RWdLdm9ha2dJa0ZYdU9tQldB?=
 =?utf-8?B?T0R0cUlaRmV6U0RXSWs3MWdFRHg3SThCVlk2b3J6RTF2dWJuRzF4VFJPUzQ2?=
 =?utf-8?B?eHdTbHFnNkdLN0x2dWRPNEZ0QW0yV2tPOVdoNDN4ZmQ0TEIyVHhhL0lVT2cw?=
 =?utf-8?B?T3owRDNJcHQ1ZS9uMVhRWVlUTndEKzhJTUZ6ekJvd2VPUGN2bTBMYSswNGtU?=
 =?utf-8?B?R0ZSQ2Y1Y21DYXc2cS9tTGVyREpleEdzYUpta2NyU3AwZVlTY2dObkNYcXhl?=
 =?utf-8?B?M1V1YUpqbEJYaTZoRVNpV2E2cDNhT2lFQjJianRMdUFsekMwc0NXK0tSNWp2?=
 =?utf-8?B?a2pYZnl5bGFJRFd5Z3Q4blZIaVVSTmsrSWFtQk8xY2Y0TFJQNE1KeGlNN0ZT?=
 =?utf-8?Q?Cz0wcqFcPy3iOQ7qlBB28r5k+cjxZbanTMUBUBFhTRTqq?=
X-MS-Exchange-AntiSpam-MessageData-1: JcvfWYlssI16WyAhZ0PPEyJNmbQuFHWE7WA=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeeb07c-70cb-4fed-8ff0-08def49fb866
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:19:56.5408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10nBXTDX5svskn2bdleviJ6E+da1XxD0M7jyqS57gMQOd1essVvjjDH7HkSNMU4SzTliLhVIiVUhtNJoj2Smz6cZWj8djOcH9AFSFraCAUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8146
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX2Ei23huLIJzorg9zh4yRIls2EAjWhRPKoKHGi2Y0I=;
 b=Y/oGQXtsCAQrO4/LMAEiMpfWRW3WY9A8XxvssQ1fntNr/KxPHHJldwl/J2a8+8sv1sDflhH52ntlLofU5RJIzoxokyvU+xAjUUoX8aRVPSZMTlzFWEuhDRQsV+fN2a07kezYvWqatvmVMf2KEGuJs+k+2Ui07JzDfGx8KWkQ5Co=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Y/oGQXts
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

Hi Jonas,

On 7/30/26 4:13 PM, Jonas Karlman wrote:
> The RK3588 clock driver lookup and stores a reference to the GRF regs.
> However, the grf field is never dereferenced and struct rk3588_grf is
> not defined in any header, let's drop it.
> 

In the Linux kernel, they seem to be referencing the GRF for I2S*, 
PCLK_VO[01]GRF. We may eventually need the latter for video output in 
U-Boot but it can always be added again once we actually make use of it, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
