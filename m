Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB680C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A17080C9F;
	Thu, 20 Aug 2026 15:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6lGkqjotKQH; Thu, 20 Aug 2026 15:57:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787241452;
	bh=IoVNW5l/JYbO+A1xe/meCuk9NHdFxAtcb/93FBcmBT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnFXOqZYYNz5wxnof9DXfH+1aLjsimhZjkEVK62Bu3EuJZdtaYZk/VCnxwj6gFj60
	 rZUz54TitYcLBe4u9RGaMi3Mfy7LHvXGw0iP79Khrx62ifKIU0KvbriScHY3p0xN5k
	 cQ3cpRXJuv08ZWST7v+0IdP6nkdFLBBRmKTurewCRz2j87/2LzaDWshdU0Ge0G0cwq
	 tZpl4i7kXyp8AUzgKKb09udwIjW8lAC9gck+1DNHpbsssb2M0rM7wOOvuhdOmUzQFq
	 Sk1eOr7IAsHmhhGeWNqhpcpfz/nXNKJozo3ix1tdaDfsmQdqdExP9Slb+0b/6Ru1Ft
	 VDpybuzYWb1Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCDCF80C23;
	Thu, 20 Aug 2026 15:57:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74A48323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72161607E7
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ho55nJli1qgF for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:57:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Bf6wamiU
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75376607E9
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScvjSNkiXpNL0a1LSJvz0JEtqrn48iiL4MuNfokhxunwk5WcVPDwEvBaijpPbFC1xmY7HMCUDjmhxkXRwWUiO6O1RsLXojNa+t8JpSfdQFBJzIG2VYs8kjP+CwN03jgHMsHksRPF0Pc1b8+3emPEvT9tPbmELB9hLVqZ3HXxVonDZEfsci2W8VRi0Swyvl8OnsLHj36J3vHY8ZmrNgQI+tJmb+acriDgH9IGb3SRmU1QzCsFgtwu1QT4k4F9r0ehBgFxQdTEfvC29nPEp9AtCEuk1mei2MkE7wl2kII2zhi3EEJ26qO+s5i7vQSHV6ojBtSLjNAcJ8D/zkOWQKLsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoVNW5l/JYbO+A1xe/meCuk9NHdFxAtcb/93FBcmBT0=;
 b=AvitimIuhowE/F4RSx65TBMaOKsLHShesR7pJPjdEkJAIlmuvH6Id0GSDo007Y0qq0Lfu89EWK6yDlfLvORh5eb/F9ZRPC2Mq/7HP8LIW2XSlqBu8oV+BroQjjdQT3xWPCWt2eMBUzkZAmDkRfCEgHIBecXvnePH1eWRwMPi4Nyil9BIx2wxexCsfjEmtJ1WeUILcxUNxFHfiiQoEVepoLWJp1SPnBHlgGZjJBUU/9xcKMuzRyyYHRAaCq1o8lxerW4wjznxOKgoGmoTz8UWEP8og0bK6y0e87UmvpXlYob65MoMRouwwcASt7JXZUi2ABIrbplbOxepDez5uVlvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoVNW5l/JYbO+A1xe/meCuk9NHdFxAtcb/93FBcmBT0=;
 b=Bf6wamiU53RP+wzGxofT0ae1ZcNInh4sRocTcCDWozNKG45GCGuW29wsH1UF5aSz0aEbSuY58R+E2V/qdeT67XsnaduAZEgs+avZDXW8+zhqnRcxkHhMDLU78u9BsUiMykWoH2qlQdjac7hrX+/uMkT6vUkvieDan6+V9Ey3YI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10489.eurprd04.prod.outlook.com (2603:10a6:150:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:57:23 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:57:23 +0000
Message-ID: <3a8bdd54-3ebc-4659-928b-ea2f88cc22c3@cherry.de>
Date: Thu, 20 Aug 2026 17:57:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
To: Cole Munz <Munzzyy1@proton.me>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
References: <cover.1787238071.git.Munzzyy1@proton.me>
 <9ddf5b446d236c42e39aef5c7dae9bc359dff694.1787238071.git.Munzzyy1@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9ddf5b446d236c42e39aef5c7dae9bc359dff694.1787238071.git.Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10489:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5c2461-d41b-4142-0b89-08defed3b937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 1Hbn6U4xqgpbGHUisWZTIoiFUIfQmVCiPDkR66qvPNPHUJdZi6O51gsjrqyJ7INys6fyA5Vu6L7xiJaOQMVxP6rXhOLAf0+rhNEfV1/M98E8ARhSaMmqg9xOo8stUJkT4bK0UaeU/YQLMne5T3/6AQZPKyqO2/8uWmNVyqh/lOUh58i7J+fG+7cS1nC/XYncSuBvWB+9cdB2KHgzC70H+n1Skubg8J7aU47DTFaSog9v/+bcY7R3szkNRv8ECdXpdrtZt0ZlNmB8mIFEvKBKkvuAzo3cFE3Lpflbqj8Il46VrB3ePiIiNq6jkGZU2aIn/VNWwmiRivSu5EtKa/2WwyYccaOOYY2SlLbfEayXX+lDVl9c5JvhovO/bNmkYPg8Ae1RQ9dfdoQEhIx5Kz5Sc7QREKf3Xjz0VziryJsCd9VLvBp8fwvVA00n0QJCO8J9HqXjlWs8NkGBNSHKcBP60gu7iAaOsJByx4NEjLCbjrUARRZtOkDKrp9Oq9SArd9QMjEsJYjWoZ+z77i7bQ8p569ffMCcmhNzua0s1yO1jQT9pWA0ebhrO+dhmRuAQ8CJTZS2/wIkOopr3cADIRd2kY+VRMqnwkhPdgekadYnZYyxRoH97Z7IFAUjKtob7izQy2+zruUMb5TxU5V9DALFI7AGuUSbhY5HbyaJ8531Z1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlBpWUx2V1dmenJaT2IwR25sNm92VjEwSktSSFBVcWtabUpVYlN3YkFhajVG?=
 =?utf-8?B?dzFlWC81RkFJQ3llOUxuek1nSWt2cEFCTC9HQ2hSaXBvVjM5Z2hya0kwQkZu?=
 =?utf-8?B?ZjYyWHFIbW0rZ25JcFdWd0hzaUNmWVlwWU55NmlPbS84ZXcwRUc4TDgvczdW?=
 =?utf-8?B?aWhIODYyRER2dXFWQWhBSk5mS1R2Z2xmOWRNSmxXT1lTdm0wdzhWc3E0VCtP?=
 =?utf-8?B?eU9Ic0lQN3M0MFdLSEoyUERBSndLNVNiYnhsQWpsb3RxYWNsNWQ1Umd0V0s0?=
 =?utf-8?B?T3NZRlNSbG5vRkh3L0JZWGU2VVpvNjRSV0xVTWZTZlREb0lNbmtVcDJjT1ZI?=
 =?utf-8?B?VzZPQ2pMNWFwbjhEREtrQWxIQzZYUWJ6UDNPOFdRZWl6QlhxTkdtWHRscURn?=
 =?utf-8?B?cmIyVlQ5S1d6ZllqY3VxcnZ0eUlrN0FMMFd2VDgzajUwWm43c3VROUlTZTJ4?=
 =?utf-8?B?ZXM1cmN6YlhLdEI1bmtsUGNKNG9PVnNFdzF2S3JVSm1pOVBDa01iUjFyc25o?=
 =?utf-8?B?R3ZIZktpRk1CaExRQkRDWCtMUmVWWnRrc3B2SFkxOHd1N3YydHJrR1AyRW5J?=
 =?utf-8?B?VGlWUngvc2ZzaTc2OFBoM3FMRnhXVkdSeks4ZjZWSTdVSHlhb2NDWkNVU25M?=
 =?utf-8?B?WkFPTnBGYVB4M2V3Qnl3OXVXQUxuQVE0dEZsbkd4NFIzM3pXd1ptNTFsbG53?=
 =?utf-8?B?cHR3cys4MmtXWFNPbEFONFBMUHpLSUhJb1gyT1BNTi9NdzFxWlBoRG51ektE?=
 =?utf-8?B?UnN5WGZIWWJMYkpkems1ZTRvL3FvREJjc3BjeVFZSnBhcCs4WVNrMG9USHYr?=
 =?utf-8?B?SlFMU2h0ekh6Z1ZGWnhkVU9Ud3QxZXd3WlJEdW83QnMzSGpwSm0yWDNNVXhL?=
 =?utf-8?B?dHl2UjlwcGxGWFJFVTEzL29EZlNhVHc5WU5lSjhVb2ZObkF5QXZiaUxqOEsz?=
 =?utf-8?B?dFpXNnRPZ0N5dEJodWRBUlFkbzcvcDlCWlVQamw2eVoxRnJKT1VGdUpRY2ov?=
 =?utf-8?B?cHhhbXNBSHgvSWVObUM2bFM4VVJsakJwajQ4N3ZueFFOK1lhdGYzMDUzRGI0?=
 =?utf-8?B?QU5jV0FKL3A0b3hEYmZLb29nZWFYcTY1WEdCV3FGUklmME5qUFNBSUZsM3Nr?=
 =?utf-8?B?OHFWSUFXc3lEeFNoT1RvN2dxaERFc1lJS2ZpeTd2MktYa0FmZEpsRUE0Q2hp?=
 =?utf-8?B?TVJFNkZiSUtJaXFsdmsxTlBFMHpKaFMrOVlTMjRPL0x0VHBvTTB5M1dTdDZx?=
 =?utf-8?B?b1IxajdwZEI4aENwZjEwbXk3R0IyOXA5amFtN3FXNEs0KzFQZVhjU1RURkhE?=
 =?utf-8?B?N1BPMU5YNk1qSlVyT2pib00wdlJmUm9aNmg1ZHpyVkl5N1FMcGxuSk1nTE04?=
 =?utf-8?B?TTB4cGI2WUhITzBnNWlOYW1jK1RTcUNKQnhzYkpLdDIwcEt6Um1FemgwbWV6?=
 =?utf-8?B?ZHpCNlI1NzlweDdjbUhRSENqRW9PbVNnOFlOV2JCbU5BQWhTbDdJeE9PaDVy?=
 =?utf-8?B?ZE9RZmxmaHNCemsybklTNWk4UlN4dTNpcEZ4WjZJZUtCeWM0KzI5T0V5Z05O?=
 =?utf-8?B?NGVSTE0yTHY5TjR6cHJlY252SXpDdkJOTUQ4SEo2dnFYQUwzOVQ0aTRYbWNt?=
 =?utf-8?B?M3RRSjhOQU1idzhBTUhZWXA2akRKM3l0b0MwZTlhS203RFcrTzdYTFlpelov?=
 =?utf-8?B?VnZIYUZHellmdTh3bEQ2MGtiT1crL284VGpqMVZRcVMvM0dsaHJVYTFINktn?=
 =?utf-8?B?MlFKVnQwaTlsTFRTZGFkblpNR2lRWnJ3MjAybDBtb3RjMDBNMkgwZm50WnpB?=
 =?utf-8?B?V1pDdU95YkFoNFJuWWJYc1RQUmN1SXdTcDhCUXQ5SnQrcExhMXRqMFhBckxJ?=
 =?utf-8?B?UDJGK3pJMGo0ZGtGTUhYbUVBZ01COTluRHpyOVFzOC9Ib3JCWnhNY29EUndH?=
 =?utf-8?B?Sy9EMEdNb29Mb3o0NHpMQVRyZmxiMnVpZ3JOY0hseUVnaU96UUZtUmQ1R3Vt?=
 =?utf-8?B?SUtnYzg0YllLRHB3aU9lNC9VcWFEMlhaQnFFTW81eGQzVmg4R1pHTExGdWl3?=
 =?utf-8?B?QVFwZndZUFZibDRweXUyNTdJc1Bka2ZoQ1ptUHptaVFBczJLR1ZuSzBQei9B?=
 =?utf-8?B?U2tsOWxBNXBuRWRiS000M25FQ0hmQ1lqY3lkSHJmVVRIQ1NxUmsxZnhjUW13?=
 =?utf-8?B?aHR5cUdiSGovVXlVcnVNVnVWUWNkVHB3RkYyS2tWbEk5TVE5ZnkrdmxGSG5s?=
 =?utf-8?B?OCtIcDZDV2ErN2dTMVJHNDR6dkMrTDAyTlVyVDE4dG44TmNyc3c5cVVUSkla?=
 =?utf-8?B?aEUrWDczQ0czYzcwYmhPYjVwNFpiWVhHVkg1dm4rSVI2d0ZONkRWWk10QnNT?=
 =?utf-8?Q?BIRGz2llG+6aKYgUk3RXCVP2ALzGu1EURWVAk17+jY9An?=
X-MS-Exchange-AntiSpam-MessageData-1: 1plcL7dit4DY0A==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5c2461-d41b-4142-0b89-08defed3b937
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:57:23.3294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5lqNMYlIjCAd9EOP5HF1FBVux4pIuD1DWFDdugo/zJEEFOIR++1Xh3coMnJBid+3mX/QSkYPW8auW55b88+vGPR2TCTOmunus9QWrN9djY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10489
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

Hi Cole,

On 8/20/26 5:26 PM, Cole Munz wrote:
> The controller has a transfer-mode field that can run transmit-only or
> receive-only instead of both, which leaves the unused FIFO out of the
> transfer entirely. The driver never used it for that: claim_bus always
> programmed TMOD_TR, and the only other mode came from an opportunistic
> switch to TMOD_RO for read-only transfers.
> 
> A device described with spi-{tx,rx}-bus-width = <0> has no wire in that
> direction at all, so now that the width reaches plat->mode as
> SPI_NO_TX/SPI_NO_RX, pick the transfer mode from it. A write-only
> display stops clocking receive bytes nobody reads.
> 
> The transmit-only case needs one more change. The 8-bit loop paces
> itself on the receive FIFO and sets toread unconditionally, so with no
> receive path it would wait on a FIFO that stays empty forever. Leave
> toread at zero there and let the existing wait_till_not_busy() at the
> end of the chunk handle completion, which is the same thing that
> already covers a transmit component today.
> 
> The restore at the end of a read-only transfer went back to a hardcoded
> TMOD_TR, which would undo the device's own mode. Restore what the mode
> asks for instead.
> 
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> Tested-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v2: reworded the transfer mode comment in claim_bus, picked
> up the Tested-by. No functional change since v1; compile check rerun:
> 
>    $ make jaguar-rk3588_defconfig
>    $ make CROSS_COMPILE=aarch64-linux-gnu- drivers/spi/rk_spi.o
>    CC      drivers/spi/rk_spi.o     (exit 0)
> 
>   drivers/spi/rk_spi.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
> index 2c3d70ba7159..81785b5e949f 100644
> --- a/drivers/spi/rk_spi.c
> +++ b/drivers/spi/rk_spi.c
> @@ -283,6 +283,20 @@ static int rockchip_spi_probe(struct udevice *bus)
>   	return 0;
>   }
>   
> +/*
> + * A device that declares spi-{tx,rx}-bus-width = <0> has no wire in that
> + * direction, so the controller can drop the matching FIFO entirely instead
> + * of clocking bytes nobody reads.
> + */
> +static u32 rkspi_base_tmod(struct rockchip_spi_priv *priv)
> +{
> +	if (priv->mode & SPI_NO_RX)
> +		return TMOD_TO;
> +	if (priv->mode & SPI_NO_TX)
> +		return TMOD_RO;
> +	return TMOD_TR;
> +}
> +
>   static int rockchip_spi_claim_bus(struct udevice *dev)
>   {
>   	struct udevice *bus = dev->parent;
> @@ -329,8 +343,8 @@ static int rockchip_spi_claim_bus(struct udevice *dev)
>   	/* Frame Format */
>   	ctrlr0 |= FRF_SPI << FRF_SHIFT;
>   
> -	/* Tx and Rx mode */
> -	ctrlr0 |= TMOD_TR << TMOD_SHIFT;
> +	/* Configure RX/TX mode */
> +	ctrlr0 |= rkspi_base_tmod(priv) << TMOD_SHIFT;
>   
>   	writel(ctrlr0, &regs->ctrlr0);
>   
> @@ -472,7 +486,12 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
>   		writel(todo - 1, &regs->ctrlr1);
>   		rkspi_enable_chip(regs, true);
>   
> -		toread = todo;
> +		/*
> +		 * In transmit-only mode the RX FIFO never fills, so waiting
> +		 * on it would hang. Completion is handled by the
> +		 * wait_till_not_busy() below instead.
> +		 */

I got confused by the wording here. Can I suggest:

/* When RX wire is not routed, the RX FIFO can never fill, so waiting on 
it would hang. */

I don't understand the context for the second sentence though, we are 
always waiting until not busy, if there's something to transmit, it 
doesn't have anything to do with the RX path does it? What am I missing 
here?

Cheers,
Quentin
