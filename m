Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6FEC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09FCB80824;
	Tue, 11 Feb 2025 14:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UkVZagG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED21C809D0; Tue, 11 Feb 2025 14:50:27 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EFF4803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFl7DmfReIDnMlbsI5pGxnQwosRoGcCSSZw7EzKLRX0D7GVMz8Uds0x50Ts2WCEZ8u15o6zqE/F7ank9YAHSqKAa9vN1pJsc6lEv5Cd2fKOnQOMERgRahXr8NNf5z/NJlxKO7WV08evss3+VPTyfxgTvR/5bA5GelIImUM+vZ7kPTwRxutSPkfId5W6fLc1UHEJIAF7CMI/IG4jUtXd/yyJPKlVfl66OMXDDHq0OQbyL1QE25YMOukcXHlQYhbdtTcQ3qeWXhMDffNuEljLIdfYCFpnjbQhDmQETDZt6hg0h/bz+9MwpEcHBbmWndjaLf7MHgObsBY1rzMgtPk05Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38QznMSuHW2a+1jUrlXoUCNRHDwSosgxTIHW8TyrzeI=;
 b=LUKfMjqrsaB43elOcJDtvrhLaycG7tPIeVhtH3QQogNuZErGHnIjn6NWKVk4dQ5c+Mckw9SW8d5WnxLeMFNvacYupMS6d7xjFLbHbjf/lgVMRuKXCJWAEMVhceqsLTx4R5iQeGAzusdZXDudss4yK3gLZkeWih+slYWgOEcNRNGjDNGUBw68yuxeMC4VxU44OQz859kv4nUEFSYgnwZ85g+6qv68ezB0JZRQCBxoF+36j5SsbpYMioGrK6z9YTb0dlV/dlFYvtSqFrcEU6AAdkBZXvIfCHL5tP0hGn+Veh2YNrjCgRdDP7f8koINGVvYu9b8PW4OD2jOvYGhjWUTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38QznMSuHW2a+1jUrlXoUCNRHDwSosgxTIHW8TyrzeI=;
 b=UkVZagG6rvea/iqJsi1+zoVWl8d1dC+neS0CRv/33b0dl2jzZyVlh3klodW0kxw6/D7j90BA7NMaOBPmmgx+jmtYpVP6k3iRF41KhRGa0kKxl8whFCHwBkrprbP8nAbGT0GC8LMdPDHKPXJRWg54DErYEHI4K7AE0o8LhkTB4vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10683.eurprd04.prod.outlook.com (2603:10a6:150:21f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 11 Feb
 2025 13:50:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 13:50:21 +0000
Message-ID: <efa4de89-4f91-41a2-ae67-380608979f7f@cherry.de>
Date: Tue, 11 Feb 2025 14:50:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drivers/Makefile: Fix TPL build with dwc3 generic
To: Arnaud Patard <arnaud.patard@collabora.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
 <01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2ebaafe-000000@eu-west-1.amazonses.com>
 <20250210155158.GH1233568@bill-the-cat>
 <307b64aaf037c16efde86ceb0b43d7a3d6db14c4.camel@collabora.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <307b64aaf037c16efde86ceb0b43d7a3d6db14c4.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::46) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10683:EE_
X-MS-Office365-Filtering-Correlation-Id: ac852e2a-7b7a-430a-45c6-08dd4aa306f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHlqVUIxcFV5ZGRwT2xBNTFGSFZUcnZiNkUvdnJKUkZWSVVwMmQxcHZZMEtR?=
 =?utf-8?B?ZFRFNzFJbkF5TWhNdGhyRENEc0t2cnBQOHRNUmFlM3VJVUVMeHBSbTFneS9F?=
 =?utf-8?B?RVA0U2J1Ui9sUXBDYVR3UUIrTU52WFRvSlJqcGhWYzdvK3FGOTMrcGJhL2Ja?=
 =?utf-8?B?b2tGNFZtZzJDeWI3aTFyN1NqdnZwNzMzS2c3bUZPbFlQdE01U09sT0F1TXI1?=
 =?utf-8?B?ZHppaUVCdVJEbFB2b0RobW9JemkvdUJBaWFCc2c2QmFldmVKamJlS3FqRktx?=
 =?utf-8?B?L1psck9iQ1ZKY0hiTE5UWlRnWVlEWitsMFhXczFnWWIzczNiSlkvRkt2VE84?=
 =?utf-8?B?SXdHV3J2cjI4bkl0OWxjVDIyVlV2bG5wK09PRyszclZuOWs4RktMTnJNb09k?=
 =?utf-8?B?OVhEZFk3azdwMnNMUFZvc2s0MlB4UFZRaDFzcFdqdzVucGhucTJmK0EzcFNP?=
 =?utf-8?B?bkFrNTR6cU5KVHc2U3Rlam1tY0hKUjNoQnVzejlOOUhUbXhFMm9tOFVpd1VH?=
 =?utf-8?B?Z3FIbWJCb0oyRDNwOXl5Nmg3T3FJZlcyVXdsaGl4OW4zUmdtL21ZVXlsQW9I?=
 =?utf-8?B?VlJGT1d0VDVOWWdISVo3cFFwMCtLSVJYUFZsenBUUWJzZVJ2bUNOUkRhVXhV?=
 =?utf-8?B?TkhKQXoxY3FzYUk5d3oxRi8zd1F5bkp6YU9IN2lDUGtZdG5hZlRxSmZWY2Fi?=
 =?utf-8?B?eE13TzhNK2pRcno5S1FvbmJoUnNFdlBCbld2SDJ3UG9ScXIvUkMzY01xTWRn?=
 =?utf-8?B?MmFZYm0zTEZXcmFqdkFabVFOZVJMM0VDdXF5Y2xydWNpME43N0F4RitEN0xm?=
 =?utf-8?B?WmEvU0ZtUytwWEJNdE1UWndRMWJMeWFZb2NhNjgwcFBUQ2RtN2p0NXJERjdR?=
 =?utf-8?B?ZFlDT1ZnRmZLa0NmRnpqYUwrTnIyUjQ1MDNJRkRJUGZPcTEyMitlZXZpMFJH?=
 =?utf-8?B?bkJvRXpLd0c3RXE4UnpiU0RHYVhOTjdjRFdYdWJPUGJNUjk4NW85YTlkM3dX?=
 =?utf-8?B?M3lrZXlzN1prVDdHSXpQVDAxd0MwYk5SbzNZUXYraEJ5SkZpS2ZaTWJTQWlQ?=
 =?utf-8?B?T29zUW1GWll3SFl2N3MvRmw0Rm5YNUYyTEFvVFNlZTEwQ0hFeFRqcDM5MXhI?=
 =?utf-8?B?N3hHM1RlSFlKYThRRzNFTWN6d1F5ZzhORUQxZ1lMM1Zvb25CQkVBV2J5WDds?=
 =?utf-8?B?TTJIT0pscU5uODBJemFyNWg3S0ZLK20wdllLWVdqVXZneHhKZ3pGTUZLZmxi?=
 =?utf-8?B?bDZNNndma0FSZjl0TDhuc2RTUy95MjNnNlBWTVdqVkdHS293R1B1N3laYXFF?=
 =?utf-8?B?bU9IS3hyeUZ1Y0xEb0REek0xbDVSdDQ2eFBTbzg1TjRFeXRFdnFESFZRL1Q4?=
 =?utf-8?B?eVR5NlRQUnhwVVdGcy9qdUFNZXo4ZVZUUXUvMklWVkhVWlhSbDU0eVlYa3Zo?=
 =?utf-8?B?emRCYlVROGNVNkJpK29zQlNudFlMYlNXdkRnU1ZEeWlGcXhBcGl3OW4yMEJv?=
 =?utf-8?B?UGZWMGJiMUlZTVNWMjhEYjJiVitIbEVYMk9Pa3VnOGNuZEFTUEZnV2Jla1h4?=
 =?utf-8?B?R0hHdDBPYlVjUjhPL24zamhzdjY0K0ZHS3pJUGVXN3c0V0p3dUF2MnR6Uzht?=
 =?utf-8?B?RkJxbnh6VEJXdEZWMmJ3SlNMYUdBd1JHZTRBWXBzNGsyelJRVm50Z09QT0Fn?=
 =?utf-8?B?WW50bERXTEVuSUsyMk9USEttVHg1eXhFQUEyaE1pZ3dISHFxdDh1V3Z5UmFB?=
 =?utf-8?B?TzNkZWFBR3NVY1ptTFpUMUNvQ1V6a0xkbERqREhLK0JGdGtnUVFqc1RDTVlD?=
 =?utf-8?B?MDZhNTBtK1dpOTVqMjQrQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZNUXBKcFM4dE5xdkoyb2tzelIwc2ZiQjg0VG1vVHdrUTZheUI1QzRkR1gz?=
 =?utf-8?B?N3ZxOGdDdVUzN2JWYmN6Zm1HVHczOUlPb3R2d1EwSExETXN4bm5UL1FHVnhm?=
 =?utf-8?B?WlNJY3hSOTAyaSt5SUQxd0Z0cW5LWmswL21aQ0Q3TnVPSWhmR0ZrZHV4Ymth?=
 =?utf-8?B?L0ljMDFLRDloenVmVFhhZ3c2ZkdnU3VMRDE5eTM4aGd4OHdBczdMUWhvQUh6?=
 =?utf-8?B?djVYWjE3U0x6MG56WXFNazJxcmM3STJ3L1M4SmF4MGdMU2lCRktTd3pBYXJi?=
 =?utf-8?B?QU5hM2RBSm9qVm5GN1FqY0RRZlJucWYrT0Z5dllSOUw1LzR5MTY2TXQvSnl3?=
 =?utf-8?B?NmRQQUh1QTBUNDFUVWN1eEFiNWNMWjhHdkF1Y2xyU2hFdTRWeGQyZ3dIdTFo?=
 =?utf-8?B?dzNPYzc0NUduaXlHMzdFRE1tZ2xzeEJtTmNoR3dwWkI1UFFZMzIveW9hWFV2?=
 =?utf-8?B?V1B1dEZQdGs1TTF5YXlwejA2ekJxMUVaR0VYb0R4RnBpaGFlMzRHM3JBa2p6?=
 =?utf-8?B?U2lwallMWDAxRnVjVVQ2d2Nrb3hmUk00eFNMSmhrem1sVWJENVdIWEVWTm5W?=
 =?utf-8?B?dURVeCszdTFyY2l5WG5iRnh6Ty9uakZMcVJJZXVYTHplcEczc09tVEF6RFpy?=
 =?utf-8?B?R0didTUvdEZPZDRlaGdxVmdSU0FVa2IzbWQ5UU1FWUR3dXF6YmJyU0NBeVMr?=
 =?utf-8?B?akhqanVzNUd6a1g0ZVBPQjFQeEZHY2Q1dENCQm5tRFV4ckxHL0xhdDU0Ylk3?=
 =?utf-8?B?UGdpcGJkdGZZZVNTblpsYkRodW5XVlREMlNBazJKWkpONHY0dU9VTzUvbmt6?=
 =?utf-8?B?SE9qVHNZRDRBdTQ5dWZXelpTcWdxblRTVnNwQ3EzdGtseUNjUk1oS0hsWDlV?=
 =?utf-8?B?LzJySWd1VWNVb3pmOVNQOHpWTFcyYTkvRVZxUkIxQmwxd1pnZ2ZsN0xydFdp?=
 =?utf-8?B?aUhWaUNoaW1iOUxzSWQ3ZEpvcTZnK0RrZURhdnZQVXJ3YnpmMjE1Q0ovdTdD?=
 =?utf-8?B?dkE5SXMvMDlaT0o2djFjVXZBa3l4VGZFMzFDeHo3RGFVUWFUV29vWnJYbVJU?=
 =?utf-8?B?SEtqRFpGcmRVa1EraFJMZjV0elVqZHhmbXU2Z3FLMWZkSkY1UjZlOWpveThu?=
 =?utf-8?B?SUJYRW1iblQ5ZnZTRjVNQnRjaWhpVUtoVGF5QUEwRE5nUlVTbVpZZE1OWXlv?=
 =?utf-8?B?T1NYR29vNnRKU1d3cytmZEVBVlJBS1BOVENEZkp5ODhnUFZOdzJqNTAvandk?=
 =?utf-8?B?MGF6QXEvWGw0OUNiTFZ5Z1Y0RitONXQ4RFdZRWVmRlpIMVY1cFRoeWFyNkRI?=
 =?utf-8?B?eHNqcXFyM3FaVlJjMzBMN05ib001SzE4U1loVFFVL0tsNEF2ZE0xMml5SFgz?=
 =?utf-8?B?LzRKRS9jNFU3U3RrbTZNdUl6NEVOc0liTXM5UTBrR0liVEhxT29MbFF4QnFq?=
 =?utf-8?B?RGsyeFdiVXl5SmI2RTRhU0IvbUVEQXBzTmJsWklrT21TTEc1ZTIzODNBQmxK?=
 =?utf-8?B?WElhVzUxWWU5cE1tdEVxVHkwT2dpcEVVamJDQzNIeTB5MmhyYi96TXJaVm5n?=
 =?utf-8?B?S3J6VUJ1YXZlN29WSHBmK3F5MnRGdncyQ1NraGxBZmhiaWlrU1ZLb21PTGVx?=
 =?utf-8?B?dTMvTXFSQnZIYTd4VUVLQTI2ek1pdS9sUTdTZkdzS0xod01WTHJwNWlqNU01?=
 =?utf-8?B?cTZjSkVSalZBekNJVFRab3RqY2xBOGtmWitpa3pnTkt1aEEvQXJ4OFd2ekJr?=
 =?utf-8?B?eEZwbVVKSHRlclB5NkZBSFhQT2lyaU9UUUNDQjNhOFN0V1J3QVlEeGZIbGJ6?=
 =?utf-8?B?MW1RVlBxRnVGRDJzaFFBRDZvM3F0aHljTWZ0TXhZTzlHTC9RRzlPZHVEbjRY?=
 =?utf-8?B?N01hd2xhQ2EyTGxBYnRKaTd3d2pobXNDaDFCbURrYmozQTFuMHl2akZDODNl?=
 =?utf-8?B?azArWTJMeXN4NkI5aHBIQlQxcEdHclF2KzMvV3VrQTlhT1luTjB6dGFYRnVD?=
 =?utf-8?B?MHhlRG1Ka3FsTER6TXlLeWlDYU5LS01Xc0ZaWGZlN3ZuSnhqck84c0lndTFh?=
 =?utf-8?B?ZWNpRzdYZlVrSHN4THQzZG1aTUVFeE1SQitoOGRFYzdqVFZMNXB3djhzQkRI?=
 =?utf-8?B?ZHk4VDRxeWdjdlowOE5OcTg3SnpJRHRMTEJHZ283VUpaNTIvaHhGNUZybmxj?=
 =?utf-8?Q?6Lg1ONK12ma24/4xad+yr08=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac852e2a-7b7a-430a-45c6-08dd4aa306f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:50:21.4982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbJBfPeXryulW9eSw7co5gdyz9Z3kdmatnBOQwmmhVh88/mD2+c5wJCDVb8FGA5y5v3EspIX7LjYw0cVmjUKy+QZfP2gmSCukbZMWB5Jj4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10683
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

Hi Arnaud,

On 2/11/25 9:51 AM, Arnaud Patard wrote:
> On Mon, 2025-02-10 at 09:51 -0600, Tom Rini wrote:
>> On Mon, Feb 10, 2025 at 03:29:58PM +0000, Arnaud Patard wrote:
>>> When building TPL with DWC3 generic enabled, the following error is
>>> occuring:
>>> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in
>>> function `dwc3_glue_bind_common':
>>> .../drivers/usb/dwc3/dwc3-generic.c:527: undefined reference to
>>> `usb_get_dr_mode'
>>> .../drivers/usb/dwc3/dwc3-
>>> generic.c:527:(.text.dwc3_glue_bind_common+0x20): relocation
>>> truncated to fit: R_AARCH64_CALL26 against undefined symbol
>>> `usb_get_dr_mode'
>>> aarch64-linux-gnu-ld.bfd: .../drivers/usb/dwc3/dwc3-generic.c:529:
>>> undefined reference to `usb_get_dr_mode'
>>> .../drivers/usb/dwc3/dwc3-
>>> generic.c:529:(.text.dwc3_glue_bind_common+0x2c): relocation
>>> truncated to fit: R_AARCH64_CALL26 against undefined symbol
>>> `usb_get_dr_mode'
>>> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in
>>> function `dwc3_glue_probe':
>>> .../drivers/usb/dwc3/dwc3-generic.c:683: undefined reference to
>>> `usb_get_dr_mode'
>>> .../drivers/usb/dwc3/dwc3-
>>> generic.c:683:(.text.dwc3_glue_probe+0xb0): relocation truncated to
>>> fit: R_AARCH64_CALL26 against undefined symbol `usb_get_dr_mode'
>>> make[1]: *** [scripts/Makefile.xpl:544: tpl/u-boot-tpl] Error 1
>>> make: *** [Makefile:2137: tpl/u-boot-tpl] Error 2
>>>
>>> Enable building drivers/usb/common.c in TPL.
>>>
>>> Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
>>> ---
>>>   drivers/Makefile | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/Makefile b/drivers/Makefile
>>> index 0e1f58c515b..7cee5750396 100644
>>> --- a/drivers/Makefile
>>> +++ b/drivers/Makefile
>>> @@ -78,6 +78,7 @@ endif
>>>   ifdef CONFIG_TPL_BUILD
>>>   
>>>   obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
>>> +obj-$(CONFIG_USB_GADGET) += usb/common/
>>>   
>>>   endif
>>
>> Do we really need DWC3 in TPL?
>>
> 
> No, not really but I failed at finding a way to not get DWC3 built for
> TPL. I tried to modify the Kconfig files with no success. So, I took a
> different approach.
> For DFU over SPL, it's obviously only needed in SPL for DFU and in u-
> boot proper.
> 

Would 
https://lore.kernel.org/u-boot/20250211043335.92538-1-naoki@radxa.com/T/#m15a3058ef1ec8afb76528e1ed3edf864c8a77ef0 
help?

Cheers,
Quentin
