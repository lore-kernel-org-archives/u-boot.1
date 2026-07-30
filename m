Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09873C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E73440BB9;
	Thu, 30 Jul 2026 15:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uG1LTadQh5yQ; Thu, 30 Jul 2026 15:19:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEBE840AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785424752;
	bh=8uvB14JUJalgFoNT/liY6UkpxdnO0xsIZ+JZRzQP/8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2kcrT3bt4KCUD+6/+f8Lkg6ZhmmfJZ+JS2CAvsgC22hFGKy0/3L1e9H5TEV2oYRG
	 ZDENGMPDrsa2BLvNaOkpnZbOFAyozbv/0fajhL3w3huKb493/+9UZ/XMhNtCE7nGpY
	 hBWCc6OI4Ue/KuDO26rq68+yiH+oz06LU1EhRp/MEopOKiqo6i0ZJO29h50x0Cq+yN
	 qejSD0tkP9qlZB7vrb5YZ3TZS0mI/H5OJPE/cKVpUWA0Nox+c1Gsv+nX1wblzY5Y8O
	 LXB9h7xt/5RRLJOikqtNvIMsiy3Xd44K9/10AXAFY8FmhfQq7siMptf2OKmIJETRIn
	 OIXQuG6I8AG4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEBE840AED;
	Thu, 30 Jul 2026 15:19:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 237432CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14F3A80FF5
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66b7cFppXd4P for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:19:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D890380FB2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D890380FB2
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D890380FB2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Incb9OaX13YmS5Mr4bs9W7O38YxPvXNvYxLFIXxqQRatCSgBKpt/D0HQjDGwrO7zL4aYS6x6/HylEHJGsTXM5wlkYs9WABZKON9MXCFr/rhzEs1Rq1eR1ymY/xevaoXofiNE3Z846G40+wfCsZhmJ1No1WZQEVClyHJT55O+SeHw52A1zfmAJLx3JNCjX5BslevgE64Xnb3ICkEHyM9ch1tW9qirzokEHQshE3WYVThsaAS82JQlvrpjHhMCnH7nkSyu6b4Ei3tWbDbOW6KFjmJ/0h41a++mSBSsSVpTpIcsqgWWdKFkL7Iw2w9AGnDw1alvmta1NOoDYAPAhlWuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uvB14JUJalgFoNT/liY6UkpxdnO0xsIZ+JZRzQP/8I=;
 b=WG//9p2POykC/Hbi/AtakjvS+01dBiR+4QlhyRnE/f8cwwJRfwzgQnrT6Os49EZwL/9WthAOCyDAOiMC/BSYu5yqqMPp1NBPY0XmFqoJDD5Eg7juojZHcWmarEdnDvBzzVBPQmcXTojWctBSboD/D/O9FHFio10vfU39WO+wx+3rfnquoKTX57iDYpEriyygVPuNOdK1HiwCXRuN2KVHuPRXOkH1gA3p5yrIoLZx0mM355rDM5snaTym4PbKqy/5zomNqPWn8yPn78HFGxzCuYgD2zosnlExzjh0+vc5CW5aZdjSqoO6VMX1TYl0aBUfEYhnCxGe8Aspb5+r6R+lRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GV2PR04MB11562.eurprd04.prod.outlook.com (2603:10a6:150:2c8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 15:19:02 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:19:02 +0000
Message-ID: <efa0739a-eeee-4e30-97cb-a54c034e7744@cherry.de>
Date: Thu, 30 Jul 2026 17:19:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Disable force_jtag by default
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260730123001.1211166-1-jonas@kwiboo.se>
 <dd4b848e-6007-4299-8889-56f020c7eb80@cherry.de>
 <62593683-5bb0-4e14-80eb-08239867ee88@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <62593683-5bb0-4e14-80eb-08239867ee88@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P309CA0005.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::26) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GV2PR04MB11562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6029b0-3a1c-4907-0e3c-08deee4de2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: IOyoDAqAF0PDw1prFTdKDn+HIRB88E7vSzGboS8dcRZvMa8jNShcqQCyuHB83KygYgoEsZQm4UJ6ad7ofcPz/+UxH0LFX2v8vMloM9s2RSU5tAFYvPrDS3fYLFLhvkUAuYDnCaGr5oiYsxfmif7tlqfPXaeOQ6TxLFJ87X/F00HLkHSQaWrh3bkM3aMHKDktMwtRqAGfWhFDa9yl6eqlFhFOdxwMEke6pJ8wFIvRh7JoX2+JkjVnuPYvm7n833SC9dyUkEUMpTsdAszWe6HMkK1zCAwwW8QQ+DvRKfqsGJ+ZqEOoWttCjGqtg+9sYKO/Xux2utmR/CFQOTH63SYkKu/52d/a4ZZ9dJKX2p0kwlc1ryZ0ngMtIlFj6cTDEOUdvpfyFSddqJyXljpK4yNno/X6/xl/NnmGaUOh8jAru7DlHCWQjBlKm3LgJOmJjDf/SK5YQ8Ew9a8acVjkHIH5LF+2uQhi8t5gtUtjpxhfGlSSOJh8MPilULIPIWTIxpxXAW6vOwOjzhjnJhTWWZi38S4TRY7pKesvfgy/TGRp2bVxHHPT7oHHZo9H0H47poCd1yf/SCIC6idCu/+1knWKbBv3AeGU0oIdY+6V6YcbQ5Sq/rXYHgrT9n5inrddfJVA61BEK9/tJQF01H8A4sWfow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RVUW5TbnIreWIzOVN0cFRXTk9ZYUErOU1XMnhZclR0TzdwY1lXRmVlYW1I?=
 =?utf-8?B?b2dsb3QxQ0JKNm5ndGlQV2I3SVNwL0U2YWxSTEw1Z3gxL2YxVDJMaFVPa2NK?=
 =?utf-8?B?bHhEUlZzNStvSm5ub3B1ejJ2bGU2aHVOOEhiZlpKaHFIbk9EVGRCeUNvS21X?=
 =?utf-8?B?VVZzZXZlR1pkd3BSazdKUnhKdHBJSDQ4YzV0QnlILzZWK1o3VytVWHBBbHI0?=
 =?utf-8?B?YWhnZ3ErUlp3Vm1uU1hnQmhFYXduL2ltMVZvVmtYSFNoSjUyWTVkcUlCNHlR?=
 =?utf-8?B?RjJLRHFlU2ZzU0lyeTZTM3hrNWZaZHFFaXJuNmxtNXlhODhINzFFZnc2My9y?=
 =?utf-8?B?SDZSKzdvOUg4TEZscHNJWThrcDgrRDQvcTNiM0ptNDZTcFFzbFFxZldMR3NC?=
 =?utf-8?B?bkJFODY0YUxLUXpYcEV1akhMcmxSZTJMdWFZVVp1TkxDRnJqYklOVmtXcXV5?=
 =?utf-8?B?WUFicXM1MEV4QlFManJmcHNpVFdESEhpZVRaSi84QTJBcFZBazNPMC9PRWZK?=
 =?utf-8?B?Y1Y3dzdHRXJWWWJIc05NZEVROXQzcTdHam5IR1Nzcjk0QXhOYVozYUFWYXBn?=
 =?utf-8?B?OWpyVVdSMnRadTdodXcxQmRNK1hxNGVFNFZaUkZCN3BCa24xUjJsTzJZb05L?=
 =?utf-8?B?ay9DQkEzeTQrL290Q3U3aEF6T3ArbGd0bnJMQ1d4TFd1SzZ5ME04eitkRlJI?=
 =?utf-8?B?ZW55V1Q1bTdWcksvMHJpdHpaL24zMWNrN2NaSVdRU2taUXVTMmtmYjRNZGFN?=
 =?utf-8?B?bUJ4Wm9NdGhSZ2lyRGt0eHR5eml2bnJOVWFVN1RocFZySUNOYkpGQnFmOWdV?=
 =?utf-8?B?ZTZucUNpa2ltMWUrNXE1ckN3MGlXSXBnTEJiQXhoTVpYZXFjY0hKTHFYWU1J?=
 =?utf-8?B?ZE1vVWkxZ202Q01yOTJ3U2s3TGhic3JOQ2ZGbyszQjlHMmwraWViSVpuN05s?=
 =?utf-8?B?NFZmU3JJZVpHK1I1UncvaUdpTjlVdTNYUlhiY0FCR2FrYkkzYW1tanB4QWh1?=
 =?utf-8?B?NmhHT3luc004cGE3RDN1RnZVN1hhcFdZU0dGcTJjSlBJUkZiK1UvMW5VN0dN?=
 =?utf-8?B?dWgwemVlYlFXaWt1Z1o2ZnF1NHZYdkpUZ1RnNUh6WHpaOWIvMEk4STR3Q1gw?=
 =?utf-8?B?TmQ0cVFnWDF6U0NGakxBNTRnQmJadndwcmZjTDB0cGt6NU1zbUJaQ3VFd0wr?=
 =?utf-8?B?clk2RFRmRThzVGxNQ2RUNXZJQzJsWkVXS3haKzFqYWRCTEdmZTdRbFI1TkZh?=
 =?utf-8?B?Ujd6N2FwRklXYlNrSXlkS2k0YVNjWVZ2bGdzUGgzRFNTdHgvYXNyb2l4T3o3?=
 =?utf-8?B?Q2FnM1pIckZZaVR5TmhiVU14bXR1b2pSajdHTkNvb2NsNWI0cERUR3U3Z2NN?=
 =?utf-8?B?VnMrT0luQVVtNTFWMkp6a1lWbTlTTnd1T29tVkZjT3AyNDBnQWZCaHZmWVNJ?=
 =?utf-8?B?anFWZUNzSjNKM2lhemR3V05Gcnlia2lhdjVkLysyR1FwTzZ2eWRlR1JBeUU4?=
 =?utf-8?B?Z1ZKUXNyNm15SlZyUVBueWtXZGFGdkNRY0hqYy9vUURsRTRxd1lVL1JKODcw?=
 =?utf-8?B?amFnOWxVS1BFRTFoYkdUYnAwb3QydDN1dmtEY1BYMGZvaXVvSytDRURyZ1Q5?=
 =?utf-8?B?WkEyRm5wV1JoY1NyZ0M0U0oyK2VYNTdlQUNFNHRQdmxrYjkxcjZmOUpTNjJH?=
 =?utf-8?B?Ym94dTRwN1pIdFR6a2h6ZENXYjQ0WnBncEJSZzVVb3N6Nk1ZK29NMkFPQ0lN?=
 =?utf-8?B?TzNwTHIweHpZaG5MWUUxWVU4TFhhNnlSUStYOVFYUjNoSFYrN0N3MXpQLzNF?=
 =?utf-8?B?RjdFNUJVRkFhNitWN1U3K0dWM2JkSTJnc1pUc2JJNnpXSjFIN1dmNllFNTdR?=
 =?utf-8?B?THZNdGVtTm1pRGpQaUNha3VUUXJCeS9ZOFB1ejgrdzdDNm54VllySDlYY3lP?=
 =?utf-8?B?NWtuUkg1dDB3cURPdDBDK3dmT3d0ajFEb2Q4MGFwZi9nWjdibzAxUjZ0N0Ex?=
 =?utf-8?B?bkVXZ3lXcHlUcmMvZDloWlhFVkovOHR4ejFHYVFFOHdzRXFyc285YXVtZlN5?=
 =?utf-8?B?NndZeEsvZnNEOW5zbjFzcXh1SElaOGE1b05jTVR3RERycXFNV3NyOVY3cVox?=
 =?utf-8?B?Z0xYeEpDS3VwL1RrMHljWGgydXpUUFB3d1dzbjJzTVJpSUhwcFpvZXFlbVpj?=
 =?utf-8?B?Ym5PUjNIK09BTHd1VXJoOU1UbTBaV3pnZzhScHliQ2ZaNmtWbzFMVjZrUGpH?=
 =?utf-8?B?VlNsSW42N3NFOFJqcFN3Y2J3TkJXc1R5R0EwckdHaXdHbGpPUUwvQ1lkUUxz?=
 =?utf-8?B?YklCTnVlZU1zNDVQOStsM0U4SXVjMU5IY0RlcVlwd0RBakYxSG10Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6029b0-3a1c-4907-0e3c-08deee4de2e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:19:02.1065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPjFE8+c4Euhl8gh0i0yV6/ihMQVQrH06LrCMyDYfrSG7FUXcPQ8QhmvEivVtC4zKJ/m6mfbIMhSd6RnHqUAr7XID3RVVoTUrofa600ErBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11562
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uvB14JUJalgFoNT/liY6UkpxdnO0xsIZ+JZRzQP/8I=;
 b=nrMSpyugN0m6Em0Gyx9ZIdX6Snobo+jUf4o5Wa4MrrcZx0BwybyV7WhmL95diOi9xYugRkyUOsO+TqaZBplPzEEfWW6sqJzT+1U9oF/sWSXtrWLwXHjiayf+/9Q5g5i0i9nwqgb/pXhLqxmspMc5NLsmN2jyp5vwbVqavhcCU7A=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=nrMSpyug
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

On 7/30/26 4:35 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 7/30/2026 4:17 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 7/30/26 2:30 PM, Jonas Karlman wrote:
>>> Rockchip SoCs can automatically switch between jtag and sdmmc based on
>>> the following rules:
>>> - all the SDMMC pins including SDMMC_DET set as SDMMC function in GRF,
>>> - force_jtag bit in GRF is 1,
>>> - SDMMC_DET is low (no card detected),
>>>
>>> Note that the BootROM may mux all SDMMC pins in their SDMMC function or
>>> not, depending on the boot medium that were tried.
>>>
>>> Because SDMMC_DET pin is not guaranteed to be used as an SD card card
>>> detect pin, it could be low at boot or even switch at runtime, which
>>> would enable the jtag function and render the SD card unusable.
>>>
>>> Or boards using cd-gpios may switch the SDMMC_DET pin to GPIO function,
>>> which would enable the jtag function and render the SD card unusable.
>>>
>>> With commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1]
>>> into dts/upstream") there are now RK3576 boards that have changed to use
>>> cd-gpios for the SDMMC_DET pin, e.g. NanoPi R76S, that may have issues
>>> detecting SD card unless force_jtag is disabled.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/mach-rockchip/rk3576/rk3576.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
>>> index e3e93f663959..0f41f210a9a5 100644
>>> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
>>> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
>>> @@ -26,6 +26,9 @@
>>>    #define SYS_SGRF_SOC_CON15	0x005C
>>>    #define SYS_SGRF_SOC_CON20	0x0070
>>>    
>>> +#define TOP_IOC_BASE		0x26044000
>>> +#define IOC_MISC_CON		0x00F0
>>> +
>>>    #define FW_PMU1SGRF_BASE	0x26003000
>>>    #define PMU1SGRF_SLV_LOOKUP0	0x80
>>>    
>>> @@ -190,6 +193,10 @@ int arch_cpu_init(void)
>>>    	 */
>>>    	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
>>>    
>>> +	/* Disable JTAG exposed on SDMMC pins (GPIO2A2 and GPIO2A3) */
>>> +	if (IS_ENABLED(CONFIG_ROCKCHIP_DISABLE_FORCE_JTAG))
>>> +		writel(0x00020000, TOP_IOC_BASE + IOC_MISC_CON);
>>> +
>>
>> Please:
>> - use a constant (e.g. #define TOP_IOC_FORCE_JTAG BIT(1))
>> - use rk_clrreg(TOP_IOC_BASE + IOC_MISC_CON, TOP_IOC_FORCE_JTAG)
>>
>> It'd be nice to be consistent here and do the same for other writel all
>> over arch/arm/mach-rockchip/ but that's a different kind of task :)
> 
> I know we are inconsistent across multiple SoCs, however in rk3576 we
> are exclusivity using writel() so I decided to continue to use writel()
> for this change for consistency with surrounding code, and therefore
> disagree with your suggested changes :-)
> 
> In my opinion mixed used of both writel() and rk_reg() funcs are worse
> than a consistent use of writel() within same file and function.
> 

I understand but this here is quite misleading as it could be understood 
as "you need to write bit 16 to disable JTAG" which is technically 
correct, but only because bit 1 is 0 and that is the one that actually 
matters.

Can we maybe compromise on using
writel(RK_CLRBITS(TOP_IOC_FORCE_JTAG), TOP_IOC_BASE + IOC_MISC_CON)
?

Cheers,
Quentin
