Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB42D58D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3722C89A53;
	Mon, 25 Nov 2024 18:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JarHgLtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9068997F; Mon, 25 Nov 2024 18:23:32 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47839895DD
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlrzZvpHNUKJn9ZdqgjJ64pG+uPeKeW1vuVzQ3M7Edot6LPI/MQMX1NpzpM+Bpzo+HxPzkbRbB5lDy50xeO+dz0bQnsGgBNef0lPkDzjmB++i8b93S185qMoBKKh8AUPey+fBBXNtcBpcRgC4RihH+dlb/rx21fkaV8GE+W6wkmUhL28d1x+bcp3CAUIedX6Tk+Jn7S2Y3K6fcZaEfX2IIOD39W9zmhX3CPH5DuzuNgQSZzLqq/WIaky2wtJD9fAMTinnAodXtaCIgYuQBdoiUgoY1y3+3my6YPsW61A+Zmjg8Wy884GpWtVe+wbKuXirdQn9w3gB8n4QiWbsZlsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWIwHrtqNCBQvFwujibOvIJGFZn/Ty/rmlm4blK+6CE=;
 b=y27wDrRo3py9Qtg0vf3/rh1GYP3yoTeVDLkuP2rab/yyI0NtprjCfuyTmlDkme+BKRUFnWKko0oUC2ejK/v1zibjyFE3mYfir9OQEAFbW0OAQ0LsfXhVOGhJ5Htk1GMgBU8nUfWrz7BIgrjUnizaCcKLtGYuH5pz2uzi7pXZswB8fMqbo2lg970mmbi2o5TNLxp0kHnXvELDpO1a4zXO0S/Tc7M5s2C7LESF8kb3INHGzkbMApTedjnHasyn59E7Q2/80/JAqc7ou6fEuDFxZnFFTy4gZ05gEwf0PZGfguigwozDlh00yPjjvPrsuQRDgqnWrHk7hLCQfIaoA6GgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWIwHrtqNCBQvFwujibOvIJGFZn/Ty/rmlm4blK+6CE=;
 b=JarHgLtFTGUhpiB8VzsO1kpdffXE0XMt5gdK8dQJbLcyMgxCTkRSkwAMml0du9kDG6gb4eIXZyI36rPnndUblrltYkTPsdsAX4d/Reqo2qw+UFhH1CwWysrxiXXsIJ9/GmkUiSZpAR3nUOVCBa+oP0++eWV/fxYIbbeyY8BUjHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB11035.eurprd04.prod.outlook.com (2603:10a6:102:493::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 17:23:27 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:23:27 +0000
Message-ID: <3cc475db-8546-4855-991c-5e678bef0fef@cherry.de>
Date: Mon, 25 Nov 2024 18:23:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] net: phy: ksz90x1: Handle ksz9131 LED errata
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
 <20241120094903.94-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241120094903.94-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0011.eurprd02.prod.outlook.com
 (2603:10a6:803:14::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB11035:EE_
X-MS-Office365-Filtering-Correlation-Id: b9814936-7397-44aa-241d-08dd0d75df7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmQwNjFkNGduaUlsSE1keFpMMVF3UFVwTmU2VTFFa1FWdjZhWVI5OFdweE5C?=
 =?utf-8?B?RlJqUjliRHVvNHBuRWtIL2ZSdVlBYk1tbG0xTFRKVXc5ZzdCZGU1NHpNZ3NC?=
 =?utf-8?B?YW1FcDF1SjllS0JXRlFQaWNvOXF0UTJJM2IrRGwwOE4vdkRQdWFtc2hmdm5h?=
 =?utf-8?B?UWZiR3pFc09rejVHNzBzWGZxdFRaVFFMVG9OeHJtdlA2b3FURkpjL25lOWNV?=
 =?utf-8?B?bzNiV25lOWtLWENoNkZZeFpFdXNoUUdhdklmQ1FlLzcwNnJ5SC9aeGcyVG5h?=
 =?utf-8?B?L1U3a0JtUmhxL2VPbjRWUUcwVGd5dE1VZzN2UUFDZG1PN0ZjeVBWSThzM05Q?=
 =?utf-8?B?VEJiYkdZQTRWZWs4WkVwd1h2L0VjVVd5SmpBN0Z6VTRWMlY4RHdtM1k3WEZq?=
 =?utf-8?B?WXRJZlA4aVFlWDdSYlIwNXJPSXBBaGZBbFI4MDM0SENqTy9ucnRkVVFQK2gy?=
 =?utf-8?B?WDJUOEdWVm5vbnNWZmUxVE1aSEFVUGowTEJtSGhYdGRDelpyMktJQ3RhWXJT?=
 =?utf-8?B?MDN4ai9zT3hRbzZLVWRhaURPbk5RUVVGbUZDQTAxVCtoc2x4NW12YjQwT3lN?=
 =?utf-8?B?TStJb2t0WHlJWEdTbVlQTlBVUzRpdXFnVHI2SHJlMHMzZVRlZmFML0Jlc0lX?=
 =?utf-8?B?RUdvZTZULzR0QkpJOXZHTmZUWW9EMVpnb0YyUVlYckVGWUFOLzg5emExbEVC?=
 =?utf-8?B?dlpjK01QNVczZzhSVlhmK1FoYkd0SlVyazIxeVBzZDRpbU15WTlTVVdKM1Ev?=
 =?utf-8?B?eS8zSkRpUFh3dis3RGRCeGd1eHVKOHpTYjBSQUJnQ2ZScXkxTUgrRzdOc3ZF?=
 =?utf-8?B?YWRTT2tJYU9FWTcwcVYxNDVmV3JKY0JodEhhejNOSERUdE1VWldLZlcrUG44?=
 =?utf-8?B?Uzc0VDdVNitsbGRuMEdEK3BVWjU2Y1g5bXZZa0NLb0pWWS9YZC9ndnJpc0hl?=
 =?utf-8?B?cEdKK1FRRVVwdWRvQS9URC9SYkdZT3BwWjZ2SHROZDVNWlFnbFdJS21Qa1JF?=
 =?utf-8?B?T1NiLzg1a1M0MkozZ0tUbkJsaEE3V1NtbzRMQjFHcnM1YTI2UWwwOTAxMmJY?=
 =?utf-8?B?SXZRWS85cWgxQTBOMWRwbnd2NTlCZTVvcXFPWjc0VzE1MTJ1blpPVHFZQXh2?=
 =?utf-8?B?cDRFcGRkenIrdVN4VkFWN3dndE1XV0JTMEtNQXhWbUpqTkFoVFZFQ2ZQWjd3?=
 =?utf-8?B?aWJzdFVVSm1DQysxaTlRVVR5UGtsNXlqSktmK2lYbkpmb2ZiL0tUWm50bkpv?=
 =?utf-8?B?akN0QUU4S0hsMU1tcDVNUDdkTjlhY3BRUE1WeVFNZFFtZlBsOUFTVDdXcllY?=
 =?utf-8?B?aEVtWW9qT3dkbUdKMHFKTnY3K0JpUDQ2SnlaZTBqbFhzMGYraVR6N0hGRE9Q?=
 =?utf-8?B?WStPbFdWSjdHbnVqVjluWTlRaFhPQU42clczSGRSNzNMcjdVZGpURkNibDBp?=
 =?utf-8?B?dnF0R29pczYzelVUN0pKR0dId0c5OElIaGNheGhZSnNFYktRejVtd0pqZGdD?=
 =?utf-8?B?cFF5YWgwSnVHK3luYVVQOTNUMTFyd0VhWWtBdS9GOFZjUVUycXBjeUJhNlpN?=
 =?utf-8?B?NC9VNWw0TmRuamovYTZRN01tNzFTVEY0eGRWbFFRVUp1NDNCZVRNNTJ3V2xv?=
 =?utf-8?B?WVpBRnpjTEF3WEFVV2xReStYaU1mN2ptUUJQRE5STUErZmpHUVNPRVU0emlk?=
 =?utf-8?B?V2hhSDBLNm1Fd0kraE4wcmFsY1UwMEhDQ09WNk1Pb0F5Q05wdEVCYXN3SmZZ?=
 =?utf-8?B?eXVJdVpJV2pORzhTVjBjSzk2T1phdENMQ3BkM25BUzhqbHJWNWgyV3JGaXY2?=
 =?utf-8?B?cjlFUThaazlVKzVsUTlRZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0oyRTFsb01veUdjQVNrbVB1SFJNeS92cUU1NUFtOTZ0NTR4ZUkvMFhZYmhH?=
 =?utf-8?B?VW5vS2pPb1daR0trRnJwTnNhYXY3ZTk1T1F4bk5NNjBhRkxLRzIyTXczSERX?=
 =?utf-8?B?UDQzeS9KN3ZiaWFaSXorWUFNOHU0bm9WK2dyQW1wbHJwVFRTNWNBMTVJSXJP?=
 =?utf-8?B?eXQ0K3pGUjJWMkh2dFN0Mkk3SnZiTGpuNzFMSlI3SFhiSkVrb1Vla0pxYUNU?=
 =?utf-8?B?WFNaQXFldmRacXh3Y1Z5dmd2M1ZsK0dId1VhY2NCVUh0djFUYmVhK1V2UmxF?=
 =?utf-8?B?ZEZFQ1hTZEJEODdjbGp5TUpEVXlDUzk4Yk1hRERybHlDT25Qd1RnWUxTODls?=
 =?utf-8?B?MzdqZzF4MTQrMzljMCtYVEpBQWZpTjVmWlg2V0VvekNxZkhjeUlpbndRME1z?=
 =?utf-8?B?WGJXenVuVmFOR1FDUHlTc25YRjc2cC8xTmt2SFNZQ3VzL2ZZY1A4VytuTUg2?=
 =?utf-8?B?SEY1K2xveTl2WHU0SXRrZGlBdlhRblo4bVFLa1JiblZFZW1VVVhFSWpHMjhX?=
 =?utf-8?B?cmxZT0pqZHFkVUV0TGNmem5zZ2hwcUVrWTRsM0hpME5IWGY4bUFWVjdCZGNr?=
 =?utf-8?B?ckJDVUpxNkJjQm9GcEU0ZEUxMzU1T3lnSjdhSkhBM3VxSzJWV0lrUTFJbHlm?=
 =?utf-8?B?QXRISGRQYkhFT1hXVW02emI3aDZzOXpBQTFHVWVxWkJlajBHc0FZL3dhOFBC?=
 =?utf-8?B?bW9kT01sdlJYK2hlS3ZwMFJEdnFabndDbjA1dWdzRkJWRVB2Qm1QUldRdU1Y?=
 =?utf-8?B?QkVWcElzRmttaCthalN5Ly9jTHV5c3lXcUo2WGFaYzhOdFJwNmhETm1HODJt?=
 =?utf-8?B?QzJyK2l0aittRXZOK2dtbzJuYXJvb0RDcGhsUDJ3bTRPMGpjN2VGcVlOZU5z?=
 =?utf-8?B?RVBWT1Zka1hqN1I3ajBkeUh4emhNL083bTBPZ01xZWJrZHVGN25xUG1DNFNV?=
 =?utf-8?B?aDRuRnFmQzZ2RHFGWFpEQWMvRnhjTW9yaml2TXRsZi82bnNhOFFadEQ0OEhw?=
 =?utf-8?B?UDhpUGI2M2RjNHE4YkxLMUZzQ09ZeG1VR0RvdTZoeUhmYS92WXY0TDl1TExq?=
 =?utf-8?B?aExWSGRIRGtDS3E4MTNrVDhzQWxPbGpXTmw5cGllR2J2SUNvcXBwd25wTmJi?=
 =?utf-8?B?MStqbGd4YUxsSnhRVmx4dDYraDBURXFYQzZwWlNiRVlvRVRhS3hFZmp0dG56?=
 =?utf-8?B?QlpJdldCL1NqVncvTVZRNithaXpFN3hGNVNhbjZ0aVhFRkJnaGdLRlhFK0Z4?=
 =?utf-8?B?MWFkbFFaUU1lS3ZZSjNLaFpqb0RDUEhOdXhON013MnVxUDBOZXJzVzVnT0tn?=
 =?utf-8?B?NFRBYlpxWkRqMjFoUDlWbHZHOUtnV2ZZWVhYMTJNY2x5Tmt0OFhvK2U3VmY4?=
 =?utf-8?B?ZVFDRjlLak5UeERHdU1Ic0pVQk5sNHJqK2NkWU5VSHJEeHFtQjZWKzJoK2VV?=
 =?utf-8?B?aVBUMVMyR2ZVQnVJZHRMTmcyaXZFbE9MTGRsV1U3WCt6ZFREaEplUTlDUW42?=
 =?utf-8?B?dFRyWUM2SlZWazF2NUF6eCtIMFUrK2pOemFuOW1sS2VDc25oNXN0MGlPeER2?=
 =?utf-8?B?cEt3RnNjVHRselVmUGZvRGhHNGdSNzJtZEVJSDlCWmNLZk1EL2x6Nk44bkZL?=
 =?utf-8?B?LzlnK1NrQmptV1d5ZUlMZTVBZ21WdjJjdzdCaERLNUlweDU2eVBNMGZncTBP?=
 =?utf-8?B?TVozY0duMW1tSzlhS2o5YXhTWmxNYWxJOE13L3lSaVRQN1BVTTJsN0pDTEw5?=
 =?utf-8?B?UGFjUUNGWC9pWFlKeExBT0YycVdxb2FtcHMwVWpoajB1SUpQUTRVZytmZUZQ?=
 =?utf-8?B?dktIeWNUbnJVN0dzVGpibTBGeVJXVkd2enI4RE5UT2lPVmJoTVRiUG4zRkFm?=
 =?utf-8?B?eUZuTEhrQ2llMThmbUxsY3ByUWwxK3plRVBNcnFKZ1dURG1Bc2tuV2dOSE83?=
 =?utf-8?B?ZjVXeU1rcXVXbHo1Y2x3TThQYUNpZTFNRWdBaUZwclZUelpRQk5pRjZyVGNj?=
 =?utf-8?B?YXBMMnlsTERacUkzSERDTHdJRDk1R1hrQ3lqZVV2cUtkMXNGczZ1Tk5ONDE4?=
 =?utf-8?B?ZTVkMHZ6aTdJSVNlQ2swQmtnUDBPZGsra1pDZi9BQk53dG53MDBnYnlvQ21Y?=
 =?utf-8?B?anZybU9YNUNmMUFXc2VnZXdRQ0dnWVYvTmR1Q2xUdWdJcEh4cWY2VERId2dY?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9814936-7397-44aa-241d-08dd0d75df7b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:23:27.1074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnepIv7kVnAo17dknCxYqrmbKJlSCB1692+QfmJTTbZP4XpmDPwfs4atUEyC5r8eul7tZD3Ty8SdZeQdzkGyrAEyVWqLrv/eScaKyFpHBjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11035
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

Hi Paul,

On 11/20/24 10:49 AM, Paul Barker wrote:
> Micrel KSZ9131 PHY LED behavior is not correct when configured in
> Individual Mode, LED1 (Activity LED) is in the ON state when there is
> no-link.
> 
> Workaround this by setting bit 9 of register 0x1e after verifying that
> the LED configuration is Individual Mode.
> 
> This issue is described in KSZ9131RNX Silicon Errata DS80000693B [*]
> and according to that it will not be corrected in a future silicon
> revision.
> 
> [*] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9131RNX-Silicon-Errata-and-Data-Sheet-Clarification-80000863B.pdf
> 
> Based on commit 0316c7e66bbd in the Linux kernel.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> Changes v1->v2:
>    - Split out of series adding RZ/G2L Ethernet support [1]
>    - Add symbols KSZ9131RN_COMMON_CTRL, KSZ9131RN_COMMON_CTRL_LED_MODE,
>      KSZ9131RN_LED_ERRATA_REG, KSZ9131RN_LED_ERRATA_BITS
> 
> [1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/
> 
>   drivers/net/phy/micrel_ksz90x1.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
> index c48ae6e88f30..b33457910795 100644
> --- a/drivers/net/phy/micrel_ksz90x1.c
> +++ b/drivers/net/phy/micrel_ksz90x1.c
> @@ -389,6 +389,12 @@ U_BOOT_PHY_DRIVER(ksz9031) = {
>   #define KSZ9131RN_DLL_ENABLE_DELAY	0
>   #define KSZ9131RN_DLL_DISABLE_DELAY	BIT(12)
>   
> +#define KSZ9131RN_COMMON_CTRL		0
> +#define KSZ9131RN_COMMON_CTRL_LED_MODE	BIT(4)
> +

Can you rename or add a new symbol to explain what is what? This implies 
a mask basically but not what the mask being set means.

Can suggest something like:

KSZ9131RN_COMMON_CTRL_INDIVIDUAL_LED_MODE
....

> +#define KSZ9131RN_LED_ERRATA_REG	0x1e
> +#define KSZ9131RN_LED_ERRATA_BITS	BIT(9)

Yet we only set one bit, remove BITS or rename to BIT?

> +
>   static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>   {
>   	struct phy_driver *drv = phydev->drv;
> @@ -436,6 +442,28 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>   	return ret;
>   }
>   
> +/* Silicon Errata DS80000693B
> + *
> + * When LEDs are configured in Individual Mode, LED1 is ON in a no-link
> + * condition. Workaround is to set register 0x1e, bit 9, this way LED1 behaves
> + * according to the datasheet (off if there is no link).
> + */
> +static int ksz9131_led_errata(struct phy_device *phydev)
> +{
> +	int reg;
> +
> +	reg = phy_read_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
> +			   KSZ9131RN_COMMON_CTRL);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (!(reg & KSZ9131RN_COMMON_CTRL_LED_MODE))

.... or at the very least add a clear comment here what we're after :) 
(yes it's commented at the top of the function but right before the 
check is nice too I believe).

> +		return 0;
> +
> +	return phy_set_bits(phydev, MDIO_DEVAD_NONE, KSZ9131RN_LED_ERRATA_REG,
> +			    KSZ9131RN_LED_ERRATA_BITS);
> +}
> +
>   static int ksz9131_config(struct phy_device *phydev)
>   {
>   	int ret;
> @@ -446,6 +474,10 @@ static int ksz9131_config(struct phy_device *phydev)
>   			return ret;
>   	}
>   
> +	ret = ksz9131_led_errata(phydev);
> +	if (ret < 0)
> +		return ret;
> +

This seems to work but is happening a bit late.

Indeed, I need something to call the network stack for this to be 
happening. Meaning until I e.g. run `dhcp` in the CLI, the LED is still 
following the bad behavior.

I assume we cannot use the probe() callback for writing to registers?

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger

Thanks!
Quentin
