Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D46CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 14:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE8983BE6;
	Mon,  6 Oct 2025 16:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bajUpbns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527ED83BE6; Mon,  6 Oct 2025 16:22:37 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E5083A45
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 16:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjL+6Y9suTvcItDRLUxNybrA0TeKRviBvI4KmfoMQPiVOnhcBlJIqF4CGHRx3x9XGVfGHN0+ZaVkAfzr66+zZVbI+AFFdZt7VUuiUQScnTHWPNE6J0/Z4bA490TQKLML0/H/kXKhdj6L08Sefjo2ObqQW455hDmhxfW9AG6VSB43v6pCY9ycbY3zjJ8x0bK+Pae7j/5AoPbqeqHNB4nZzaeaBn8ih06YWHkuvkE24xey5N2tSqUORrltsVnor1BIpmW7Dv0euI0oW7dFGliJdFig0Y0qI8CT8h5kBEPx7L05dX0MR45GXjEe+w7tUBJzqd61+1ZdLEpatAhgTy24Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYTUKg7186P66PifT2aBJX4Ui6SoE22vpD9TOTvh6jE=;
 b=eS6iIlAYsu6jlFTSB/k910MFeRkAag9ZFkQVV6HMg2y843pSf+G2Vbd7kWG6ugmGiTFtZofkwReIQxwWPgBeGe7UfmBUsISx1dgO9R9F/nXzRlXTVnFfsg0jUEm04laqyJ6gZReHhew7FW54dm+JtGWEjgmAxFcacnb2p8aMf9IImejplC60eorI8Gnc1CvQIaHGEMYaMEKwbFWQe65V6p9jvM6SP3P8jhAkmTzUff1obVrCrkgZsgDXi28pPwfonHrq67LlgpLvH2mdrcQXsqo41+hQa11xEQQZbtd7uBviYrVySPxmptZgeF8ftrxvuNz/TXU4KtkPtErKNRLuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYTUKg7186P66PifT2aBJX4Ui6SoE22vpD9TOTvh6jE=;
 b=bajUpbnssuVOJqZjanolpw383FGy1b2m9NG6c6fbYIob+6RRfEVJg5PZet7f8MtFhB6sgNAJue1+w0wIC6vKIopco90BFzPyF/brAuTNWBSvP/iiyi/E1CnKiXn1JX8sA6+/CU4bddrGPhvxmjdB43pr0cQawx8yediQZ6niCQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:22:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:22:28 +0000
Message-ID: <fbe74df2-e608-4781-800c-c415409f6e26@cherry.de>
Date: Mon, 6 Oct 2025 16:22:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tftp: make TFTP ports unconditionally configurable
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, u-boot@lists.denx.de
References: <20251002-tftp-port-v1-1-96d04556b35c@pqrs.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251002-tftp-port-v1-1-96d04556b35c@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 25724d03-7581-45f3-11ee-08de04e3c746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUQ4NHV4OTdTVEZnaXdVWHViREVlNXB2a1lKZWxxMUt3OVlHQ1dTdjVlRHJn?=
 =?utf-8?B?YkUrSTdHZkcwK3dBM2NOVTZvSHJMUU85SE1qVjNhVXY5VjRmN2RsSmlMV2Zv?=
 =?utf-8?B?aE5VeDgvcEdWU1c2TmNWTDZ0Tm9yTVRCdlhxMTVxVDB1bG1rNDVQM3pKUFRL?=
 =?utf-8?B?cTlEY1JUbFZ0dm9XQS8rWmNSalZaZk9xK0FRL2RtM3VRU2pqRTA2TG5MdWN6?=
 =?utf-8?B?SXhGdDJKL3lsdytxNHd0b2dPTU1HT1hLdnlTMWRjajFkaGZTTjBiUENZdWV2?=
 =?utf-8?B?eS84aFVXRFp4Mmd0MFVKdldkUHh0Vnp5Zkh3S292N3E5ZU9PRjNHOFZyL25i?=
 =?utf-8?B?TVBmdTF6WlFtbEpYVE9TcC93Y08yUWhPbGt0RWZkcGNnYlNrMDVqK1orMEZz?=
 =?utf-8?B?MGFIelFoRkV5YjJFZnVTT3hpRDYrQjd4NThMcEtXNVJkRjZ5TkkzcktRWlZ2?=
 =?utf-8?B?dlFtNDNCZFh1eEhIelFmWVpYUUIrUy9QV2ZtSG5zNXBVbVNmTG9SOWJTZGhv?=
 =?utf-8?B?ZFk0d0dzN2xDT0x6L3pFRWM1NXRaUENsZEIxbkxQc3pGMmZ0N1BsVXVpZXZF?=
 =?utf-8?B?dnluVkxGM2plRzI3Y1lLK3cydERaZ0d4ZDJOTlRSbXVSYnNyek1DdG5uM1dL?=
 =?utf-8?B?d1o5M0c0bzdKRzBJWHhiUEVYZ08yUXdwM1VQc0RoZDM3SXR5V0FiT3RSNUhR?=
 =?utf-8?B?UVc3blZXUFJEQ2gvYzFNQjBIUnFPcHhjQWp4cEJEZFFyOXpINlFRWVZXMjVJ?=
 =?utf-8?B?OXR5NzlVUnFONm5CNzg0YkdzNVBUeVp0em9YeTdsN24xS0RITTQ4SGUwbGN3?=
 =?utf-8?B?UEUxeCtGT2RZSVhaZStmNHBYWkMrOFp0R2ZwMi9zV2tsQkp4NFFJdnlZN1Rt?=
 =?utf-8?B?MzkrK25Oc0Mycis3T3NBNHRjV2xMOU1BRkhKZFJnN3VYNFBOYXFCdXFkK1I3?=
 =?utf-8?B?dnk0dFFnNjV5RGxMMk5pTWZqVVNFYjRDRFh4c21FYk01TWxidWlucVV1azA2?=
 =?utf-8?B?Q0R4UkFWUFF4UmlBelc0MS91V0ZjbmVmT25PTDJ0S2tRU0RDYkFDb3dqczFh?=
 =?utf-8?B?bk56RHRTQXNhRTZkZmRuaEZxMDd6WUFhSVlHdkl2ODBZTkw3czFFRElqcXdJ?=
 =?utf-8?B?QWE5KzdlT1NINzRVV0ZoQ3VwWVpTbWd2eU5leEpxeUFaM3lKTlZWK1d5Ympo?=
 =?utf-8?B?aFNuKzVlRTBZU2dvdHdnZzdQUm9ibkd3WndsS3g0YmpZb05UdnJ0VG85anB2?=
 =?utf-8?B?SG9ENUsvZUxvaFp0RjA5SWhHODUrbkZQNU5mV2FSRDZEWU5aTTlxWnFSLzFB?=
 =?utf-8?B?bWlwVXBrWk9OQ21yUWhaeUlFLzdaZUM5cUxST2kvSVpyVzNFb01lejhtZGVO?=
 =?utf-8?B?RGlyNWZTMjJaUjZRQXAxd3QzYlNrNkEyQU9rRThqTGJRK0NXbkF5Z3haYXhz?=
 =?utf-8?B?TGVPZTlTMy9WWHVqTmNmUmZUaVBPNGdxeDkzY3REMGh3UnVKbDY1a1NYRmc1?=
 =?utf-8?B?NWlQTDJWM2tFbmdOOHhRWWx2eUt6VHBuYkVodWMvOENIc0Y2LzB1bllrWkV6?=
 =?utf-8?B?c0NJbUFEL1ZFUHZ2U3k1MDRYNzNzVXFkeU5FY0F3UmlXcFplOUxuUTUwY0Z5?=
 =?utf-8?B?OFZZZ1VxWXI1czNOYVlva01FaGdabzBNQ0cyNnZLa3ZWRytKWFYxK1J3WURn?=
 =?utf-8?B?SlZqYjg3bmJSQlM5ZTBtUlVTMHRmUHp0eTdEL0U1ZXBmNWJxdTVvOUIxUm1X?=
 =?utf-8?B?VDl4aVdsNDg1QnNYYVk2MlpNb2I5R29SMjdVTkV6YjAvcFZXdmhyZ3l1cnZY?=
 =?utf-8?B?SVJ0bEZLY09lQjJxU2tnb0htQlc2RjN6ZUZJZ25WRWF5UkFuOG52SGxlWXRp?=
 =?utf-8?B?bjVZa0tacjE1a20yeEdURVhvN21VU0hRUmZYNnRsUXlXZDBFbDFXVGF2VExw?=
 =?utf-8?Q?i82e+xLf9e/YJ2bVuKlFvfOm+jO76Nig?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VweFhEdDNtYklqYklDN2ZabTd3NWZObU5MN25TZ0dzbEgzMnpZdk1NcW1k?=
 =?utf-8?B?T21pNHJqdkpUTHdTQWJmMG9ET2Q2VUszVE9YbDFUQzVZWlRsZW05VnNpanlU?=
 =?utf-8?B?TWZzN0srdU9EUkRMWE5rTloxY1V3QStmUjMwb24yTkJ2YjRTYXdQTHc0VUZs?=
 =?utf-8?B?ZjhCYmZrTXpTSklIUWM1K3VWaDBNY2xhSVkwVk9ITmVTVDlEdHFjakZ4anNR?=
 =?utf-8?B?cUtJVGVsaFl2Ym1YOW9iY2lWeVMrZ01vcHN2MjhmV1hJNHhpcStWVFFkSFE3?=
 =?utf-8?B?Y3Myb2ZrcmQ3blFtRW8ydU9JRFl0M0VyRkRKRXU0eFp6MEpBMXNwdmJHbUQy?=
 =?utf-8?B?TndzR0R6MUM3djZqeVRhZjAzSXNrRzNqN0tFSzZYWHpOVFRrbVcya1owSkRD?=
 =?utf-8?B?Z2VuRlUyOWVWNWNObUphM2owSjFLektHM1pTN3J3Y092dTVOTFZINllTS3Jm?=
 =?utf-8?B?ZFZNUldDTVFCNTNoUjhSM1ZjTGFEWmFkU091MG81UlFLVWVXV1c0UmxpRGRE?=
 =?utf-8?B?cVFIUnJ5eWs0VnRhTGZUcTROOEYyNlBPdW1EZFJSYVNaYmxxbWswUFZ6NHJO?=
 =?utf-8?B?TFZjZGR1NDZEL2VXSm56MVI3QXZ3M2s2eEViL1ZPb1NWUHBmN1lYSEZleDZV?=
 =?utf-8?B?Wnp6U1NZT0wrVUpvSWd0V2xHdGljQys3MmRQNVlYUDNFSkpxWlo1Rnl6ZGpV?=
 =?utf-8?B?Q2NncStkQ1F4MnVqMkR6VFUreEJEdzhCbXRnVlV4aStESWJZWDVCQjEzbXl4?=
 =?utf-8?B?YWxkTUZkNmwxUHZHS0JENmpDUWVGdGh0amNLUWlkSnZjNVdTT1RhMFFxSGNz?=
 =?utf-8?B?U2xmc09FWlZyV3o2N2JRQjFGNjJKb3lQbmlzSzVzSU1VTjJPbUpBTUtVVXpn?=
 =?utf-8?B?QU8wWk5sWG9RRk13dDZKeHpycFpKU0hEUDFTVnZNOTVKNzQ5aFllQUo0d04r?=
 =?utf-8?B?YTNnR3RuUXFHRkE1eThUVzk0U29ncnNrTlZIMVhrSksvbnkxRllvQldQaEZz?=
 =?utf-8?B?bnF3SjhHdDNBTW1GTlpScytZZFFCYzNlaTl0UEdGRWNjODlTYXh3RDJlZWd2?=
 =?utf-8?B?RXdmMm1jcUoyeGd3Z0krT0dvdFZrNU5RU0xVZ2F5eExEeHlwcS9HcS91L2Jp?=
 =?utf-8?B?RUdkY0I3cEc2bjZwYWVURVNXOFpxRVY4YXM2TkVqZjFvWmlxSkhwQm8ya1BS?=
 =?utf-8?B?ampwNjhnYVIweVh2MjhGK1dBQk5HS1VuOUZwVjE3UjZGdEdGT0J4aDBma1Bi?=
 =?utf-8?B?QllKQ05oekRpUSt6aExmNFV0bFVPV0trbG9uenZxUUlFbmd0WUc4TEpSTHBl?=
 =?utf-8?B?WkkxL3NnbGY4V0kyeWxGOHVtb2g0Vk8zWU4ySEZKR0NVVDAxVm1rYXR6WGFG?=
 =?utf-8?B?VVJJUDdkMFJVS2NNazc3RFN2dTRIRXVwWWNuMjNvUzRRK2k1N1ozSEVUUVp5?=
 =?utf-8?B?M3E5OHhMUDVENmVTU2FJWnloTXgvT3ZvYVI3VXhiZ3M4clBiejExS0tQVE5O?=
 =?utf-8?B?SVpnaWxQWHlFRWZVOWJkL1lhZUZhSWIwL2NmdTdhdi9nTkE2TDJKc0kvbzNR?=
 =?utf-8?B?OXRMdFl2R3RsY0lOOGw0aU5vY3Zaa2ptemVYVEJVdXhma0NwTEY0bTBtMDBa?=
 =?utf-8?B?SXloNDFBV1h1LzZsZG12V0JrVmJCMWFweTZoV1Nmd0xaaC9qWlJZVWtNMnR6?=
 =?utf-8?B?eHFUWlBlVjZkWTRzMDRkb05JZzVFSXNPZ1JSTy9mYmdrT0JmS3pZTGdHUEh6?=
 =?utf-8?B?cVdwSkIxR2RGY1NBbnNhbWhpd0w5QU9sTFVTb1ZkYUErVnpZajVTTlI4Mkta?=
 =?utf-8?B?OWVYekZtVHJ1cHJlWmJmZzVvc1dwTnJ5OWZWQkhLbk9vWHF0MitrazluQXVD?=
 =?utf-8?B?ZFA2TEEvaGJ1MTJiM0ZGeVhqVGxBeHJ0UG4vcGVUZVF1TDVzOTRvTHNxNlcv?=
 =?utf-8?B?L09mOWVnUkgxenlueGdhY3FuV3A3blpIODJBSW5EZzZZMWY1VmRtNVhYVlcz?=
 =?utf-8?B?NSszWkJaRUhObWtlVHp4QVlZVXJJbmVEVHZRZEpOSWYrR0pQN3dHT2trSzN6?=
 =?utf-8?B?VVZjRUMyRitmSzJiUytHRllPcE9xbEtPZEJubTg5M2F1MlplNzRaQjAxT21z?=
 =?utf-8?B?MU1mK0xKTi9adzBTVGRiT0p4ZlZtajFidWp5Qi9pL1JZNlhmQzdISGNBd3Jy?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 25724d03-7581-45f3-11ee-08de04e3c746
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:22:28.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuDAAzgYEQR3/f4x+YPaUOnvnQeM958MI4t2rggd2S/G3aqRdjSLrQAibwj6akgVbm9mlqOVTJ15DBw5ngRBHj1+dETM0ziAedyubVvJ3Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981
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

Hi Alvin,

On 10/2/25 11:43 AM, Alvin Šipraga wrote:
> [You don't often get email from alvin@pqrs.dk. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> A few lines of code being guarded by the CONFIG_TFTP_PORT option seems
> an unnecessary restriction on the TFTP support provided by a vanilla
> U-Boot image. In cases where the TFTP server cannot run as superuser -
> and hence cannot run on the well-known port 69 - this quirk incurs a
> full reconfiguration and rebuild of the bootloader only in order to
> select the appropriate destination port.
> 
> Remove the CONFIG_TFTP_PORT option entirely and make the tftpdstp and
> tftpsrcp variables always have an effect. Their being unset will mean
> that U-Boot behaves the same as if CONFIG_TFTP_PORT was unset. Update
> the documentation accordingly. And fix up the single board which was
> originally enabling this option.
> 
> Signed-off-by: Alvin Šipraga <alvin@pqrs.dk>
> ---
> ---
>   configs/gurnard_defconfig |  1 -
>   doc/usage/cmd/tftpput.rst |  8 ++------
>   net/Kconfig               | 18 ------------------
>   net/tftp.c                |  3 +--
>   4 files changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/configs/gurnard_defconfig b/configs/gurnard_defconfig
> index bde531a6003a2d7167767b3f509876137c7da1a8..85643f249aed65071005a157658c3dc11f44c619 100644
> --- a/configs/gurnard_defconfig
> +++ b/configs/gurnard_defconfig
> @@ -42,7 +42,6 @@ CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_NAND=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_RETRY_COUNT=20
> -CONFIG_TFTP_PORT=y
>   CONFIG_TFTP_TSIZE=y
>   CONFIG_AT91_GPIO=y
>   CONFIG_GENERIC_ATMEL_MCI=y
> diff --git a/doc/usage/cmd/tftpput.rst b/doc/usage/cmd/tftpput.rst
> index 351c9faa38b9d8357c0e200d8cebd1f90344e0a6..2bcb3032cb2444926da28454eefdb2b128a7389f 100644
> --- a/doc/usage/cmd/tftpput.rst
> +++ b/doc/usage/cmd/tftpput.rst
> @@ -19,9 +19,8 @@ Description
>   The tftpput command is used to transfer a file to a TFTP server.
> 
>   By default the destination port is 69 and the source port is pseudo-random.
> -If CONFIG_TFTP_PORT=y, the environment variable *tftpsrcp* can be used to set
> -the source port and the environment variable *tftpdstp* can be used to set
> -the destination port.
> +The environment variable *tftpsrcp* can be used to set the source port and the
> +environment variable *tftpdstp* can be used to set the destination port.
> 
>   address
>       memory address where the data starts
> @@ -75,9 +74,6 @@ The command is only available if CONFIG_CMD_TFTPPUT=y.
>   CONFIG_TFTP_BLOCKSIZE defines the size of the TFTP blocks sent. It defaults
>   to 1468 matching an ethernet MTU of 1500.
> 
> -If CONFIG_TFTP_PORT=y, the environment variables *tftpsrcp* and *tftpdstp* can
> -be used to set the source and the destination ports.
> -
>   CONFIG_TFTP_WINDOWSIZE can be used to set the TFTP window size of transmits
>   after which an ACK response is required. The window size defaults to 1.
> 
> diff --git a/net/Kconfig b/net/Kconfig
> index 40ec6bbce7614afde5a2a9f90d431f19a3654a41..7ba64d43b398415825921e7b61dc4c81e986618a 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -60,24 +60,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
>            this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
>            be configured.
> 
> -config TFTP_PORT
> -       bool "Set TFTP UDP source/destination ports via the environment"
> -       help
> -         If this is defined, the environment variable tftpsrcp is used to
> -         supply the TFTP UDP source port value.  If tftpsrcp isn't defined,
> -         the normal pseudo-random port number generator is used.
> -
> -         Also, the environment variable tftpdstp is used to supply the TFTP
> -         UDP destination port value.  If tftpdstp isn't defined, the normal
> -         port 69 is used.
> -
> -         The purpose for tftpsrcp is to allow a TFTP server to blindly start
> -         the TFTP transfer using the pre-configured target IP address and UDP
> -         port. This has the effect of "punching through" the (Windows XP)
> -         firewall, allowing the remainder of the TFTP transfer to proceed
> -         normally.  A better solution is to properly configure the firewall,
> -         but sometimes that is not allowed.
> -
>   config TFTP_WINDOWSIZE
>          int "TFTP window size"
>          default 1
> diff --git a/net/tftp.c b/net/tftp.c
> index 1ca9a5ea7cf6bac562006e2506ebcb17996a8c36..1760877107faef57107cb04c484157750ff63602 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -926,14 +926,13 @@ void tftp_start(enum proto_t protocol)
>          /* Use a pseudo-random port unless a specific port is set */
>          tftp_our_port = 1024 + (get_timer(0) % 3072);
> 
> -#ifdef CONFIG_TFTP_PORT
>          ep = env_get("tftpdstp");
>          if (ep != NULL)
>                  tftp_remote_port = simple_strtol(ep, NULL, 10);
>          ep = env_get("tftpsrcp");
>          if (ep != NULL)
>                  tftp_our_port = simple_strtol(ep, NULL, 10);
> -#endif
> +

The only worry I have with this patch is the security implications of 
that. Indeed, if I manage to get access to the host (root not required) 
where the TFTP server is running on port 69 AND the environment of the 
board, I could set tftpdstp to point to the TFTP server I (an attacker) 
just started on a non-privileged port.

On another unrelated note, I'm wondering if we shouldn't make the ports 
(tftp_remote_port and tftp_our_port) u16 as that's the max allowed on 
Unix as far as I know.

This would allow to use env_get_ulong() here, e.g.

tftp_remote_port = env_get_ulong("tftpdstp", 10, WELL_KNOWN_PORT);
tftp_our_port = env_get_ulong("tftpsrcp", 10, 1024 + (get_timer(0) % 3072));

But that would only make sense in a separate patch.

Cheers,
Quentin
