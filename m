Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE95C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62F834091B;
	Tue, 21 Jul 2026 14:52:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7fO-F4rx2I0b; Tue, 21 Jul 2026 14:52:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 717DA40869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784645546;
	bh=VM7NLDBE7r9YlDCeRwimgWFCjA+YSgsYuiHxS7uASCg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=w5EUnpZW91EpveCAGQ2YRlk/f7w8Kx+mHeBt/BLJG7nrU7UAb1vLCcm80/AMvu+WB
	 pnXq1JG2byr+Ztl8dlrc7GFC0kDPXKvg5MaAcneJCcL7XNkg+zFAZeQEKeoEAgRoBM
	 zC0b3yBDYPZU6ORXrzxlVwL0oiuwfsoIYLiXrxHo3cBdHORr2XrIvCEtuFfAt7flTV
	 MFZR81sJ+jlfRYciN4Q2u3rP62Ak12ttE7usTPLFvc+ORh4fCHDGDEDduq92LqzY6c
	 d5wiG3GyVY6O4dsiBV7iYk4XcJVWmgRVic1Em0w9vhzfnpuBP7ARZCgA2/bJB3o0SW
	 GceprTabo3gQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 717DA40869;
	Tue, 21 Jul 2026 14:52:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50141109B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 419C340071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2H3fcaOaY1MF for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:52:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 33CE240055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33CE240055
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33CE240055
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irKg2hTCC4eHjybFUzhll9b3D0kFPe3nJ8pdDYYyaOk+/Y1fQ/Ma1k9MQK+Q1Tk+toZX5I+JY62QXiiC1f5jp7YJGynwzK4oi31rp0tzHJEdzXNxvXt8vMVRbikEvJdOCQ9TVVHKkzhfmbQ0nbvbwZc65ckaUTuIe6nkt8V6loEkWPtfY3Z4M+Yj9yWJ1dDHnW3a0hg9GjoqDXthm+JbaYiC+wAoTPLFXfkk8W6Vdb0s+W0j0HVUYkYxTHW/3oB6CU06ic7zX8NmRRPGc0ATTWkdA187DdNsWPJFwgiXTgYoWBOCJ8HdgpiAF6VcamKJsdWStSz4ClfI4UjGeqwUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM7NLDBE7r9YlDCeRwimgWFCjA+YSgsYuiHxS7uASCg=;
 b=UwliAE1de7KA8F6Cw/CBk7LDTCox3XvvdHswflq5GDr5pZM6J4J12vuCU/jKAlBUy6zm0nUmLXgp64mXsm4oszQhkqn9/f4zV7W7oDE+RgLKOOdLDtqukPhq8A4HqUMhRPmx2sQKJKH0rVMI1ybzrsQVKWer7JJ+oj8tmUAicaQdWnz8/HBb904bSRJyUXa553QVQd+de0TS15QzWlyCho6sFBIMnU8iFwt+ff1v3opiF+33dKAsf26/8GjtHtansKt/pElX803nvUf6BFWSFLXZR7REMggZbZc5nRNT7covoL159IQ9i4gO+09bdie/X5nfaoCavES0NQdUqZBymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB12066.eurprd04.prod.outlook.com (2603:10a6:150:304::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 14:52:18 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Tue, 21 Jul 2026
 14:52:18 +0000
Message-ID: <868f95a2-269b-4879-ad65-b7dbaf2b1b14@cherry.de>
Date: Tue, 21 Jul 2026 16:52:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] Mailing list migration to lists.u-boot-project.org
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot@lists.u-boot-project.org
References: <20260715173119.GL749385@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20260715173119.GL749385@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0057.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::46) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB12066:EE_
X-MS-Office365-Filtering-Correlation-Id: 86da6891-37f9-47b4-b1ed-08dee737a97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: Fp0N73i/iyZCSTvYI6/UXBggXh/Nhmmm297ag9+uGN4WGRVtcyTEwCwbSddgVUYFMTJFd975lfagfs5/2PKk4Rvf5380rEGO6+TYrv43J2HbbkSmlnKNAitIRJEY/gu85PkSFBCwKtVdREd4rKS/Cjkd93CIJg/l5uN1DLshSaaDuwk3KAP6JikT3+KDLKF6/9vEkmCLR6yg9nvE+jY66kYGy/I/ZXmIA2kkWBG2A+xx7+2aTFrKsPMrI7G03sAnS12JAyb61sLBAGDg5Ii9V0p1oo7gJclivzkBX14Ef0VjPYmtJw47ohw7qf4dbVqkMww1KRCBMYQNhiks7kc/J6TIOt2y8+czqO0a+9dN/zuYRN2G0TorMstVyPdCzmiRiPye8+B/xHJsizlYIiaijyNpWzEG4QTMu6Utt1nkz6/vscLaqRclMMVy73Qk+vWMkd1Gj0i8WvhvOvWmqlb3AeqKBBGKzdZDFGkJoqdStqcl6l/Ao4dmHbbr5cQzN20i0OXBSlhKX9ozDmbds09MbRUhF6tXscU6xN5OeuMpJnBtmBkh8UFzBwpLFuutlDJUwK7GriAaWjXhy3Vq5WLaGxmATi/IU/uV3Atrh8kLsVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VZTXA0MHIzeXZWaVl1NFA1ay9IRjI3WEdPeUFXRW1FaTJzTzlkTkJ3eVIz?=
 =?utf-8?B?Yk8wZ1QvZkJneGFYeVFWVGcraGd4WFB2bWxxYmVSQ050akN3U1BXMWpoMTF1?=
 =?utf-8?B?Mm5XT01Kcmk5Z2hNZTJVV1E3VkV5RVkzMDdlYmtMYzl6SWRHdTV2aVUwQU1R?=
 =?utf-8?B?Q0ZJVmZuOTF0aWV1YWpKcStacXVjbnQ2MDRKSWluZi9sMEhqenVhZlpnV3ZP?=
 =?utf-8?B?a3ZiQWJhWjcyWGg4MFZDclRrbUN0SjBlZzRHOTlRYXZyeDc5c2lXV1hScXNU?=
 =?utf-8?B?Ly90K1pRejBkbWtOdjg0Y0lzRGw1MUtHWDRQdUpoQzV1dWdpVzd1MTR3SG5T?=
 =?utf-8?B?OEdDb3M5dzhsZEdBZWExc290ZkpVNGU5dkJvczRMUXZaNnBCaTFmWHlwQkl6?=
 =?utf-8?B?ditlb3VEdC91c3RlbXdhNm9rcmhaMFFDSWVGUkN5ZlAyUnZ2SGcrOU5BVTZE?=
 =?utf-8?B?NG53anF0V0lTVDlEYUZwc0JCTzdjNVZCQy9PYXNpWm9YV1V5L2dLbVRya0wz?=
 =?utf-8?B?cExabHNYR25ra1hsalIrREtzcXh0K2FKL09jVDRwS3pIYzExczlkWWVvSitY?=
 =?utf-8?B?MTdSTENUdlJpQVkwOW1ZdUdUQ3JjSHBqNlFOK0dOQTRpYUJ1d0lZaWRrR2VV?=
 =?utf-8?B?eFVtK0thVTRRVjRKcm5uZTlWUXJEbkVHU2ZuMy9vajkxTmtZQ2U2OHJocUJG?=
 =?utf-8?B?cDBvb1BPV2t0cEJrRFlCNjZYTXRIYU00dzVscmlKMWFTTWFpQ3c2dCs0SmFT?=
 =?utf-8?B?RWdrZ0Y3QVBuS05RRzQxcmZwU3g4eVNmL0czcDhWR3FISUdxRGdkaFdRZHkv?=
 =?utf-8?B?ekd6dnV4OERQbm9QSXkrV1hDUm41VDQ4Q1BFMVpNZ1RQRjBLL1FWa09iQ2hu?=
 =?utf-8?B?OXJDWFRwV2tjZUs4NlprWGxzK1AzTWNRU3dETGE2bFN3d2lFZkkyNFdPeTE5?=
 =?utf-8?B?VEpMUWJYU08vam9oSS8yVG5uU2ttNmc5cStWdFV1UWxOSDJJT3ZVMkFnY2I4?=
 =?utf-8?B?dnhwNFQxcVhweFBOUGdWY3Y0QUNjbEZoekp0eGJKRHlKNzQrbTlkcThCUVAx?=
 =?utf-8?B?S1AzaDZRd2hiUGFjWDRXdWJQUnJvaEJyK3M3VW5Gb1NtRU5HUWg1UU55U01G?=
 =?utf-8?B?Z0hmNVpUZTlhSGwwanZJRjBPM1plTW43ZE1DWnFFcE1uRlpuVXZMREtZbytw?=
 =?utf-8?B?WmNZWXJTVjgzUkJERUh5RDVRa3R0cjVLeStCclFzd2h6b2RYc3lwWjJlK01V?=
 =?utf-8?B?UTZuR3VpUDBHdjVSRUFpbzZPWTVGUE90c3VPV0U0VXFXUGdCYlk1a1VocnFx?=
 =?utf-8?B?UVVTTkprc21vMjhpWUxncG0xRWpDNXRZYUdrNlh5VWs1MDBFc2JnclhFa1FR?=
 =?utf-8?B?allhZThNUHhhc2NteithbXZuZ3d0bHI5bTBJTTZDc3pPL2EzYkJnLzQ3N0U3?=
 =?utf-8?B?VnhVYUFIazhUY2N1ZVI2YUQ0OVZ6dGhwYjBwNEJjajE0QndRZ3VpL3pzMzMz?=
 =?utf-8?B?ZmlCekdySzYyUEhjUFJ4Rkw3NHdsbGEwNnlGSVdaM3U4Znh2Y1NST3lYSFB3?=
 =?utf-8?B?MFRGU1U4UEZVOTRuYWdpaHY5QVBHZnZBeDZCZnVtZVI0d0hqN2F3SkMzTExH?=
 =?utf-8?B?RGZDNnVQaHdVYWM5MGk4TzFqY21ycTREa2VnZTZXRjUrSXA5eTVoZ3BmdmEw?=
 =?utf-8?B?UFVPTzcyOGFHY1lMQ1BUYjJSL29KTWZYcXRFeEpJUnhXQ1N0TmZHa1VaMVI2?=
 =?utf-8?B?TXN6c2F4OUI0SHRpQ3NqSHZ1YmpOQ1hpM00zZDF1MWtUTkFFSVhZVEg5eHdr?=
 =?utf-8?B?S2Z3SzNpUG1hWWZmL3RXTkg3Z0dsOHV1cDRoL3BaVWlqamR3c2U1Rk5VODh0?=
 =?utf-8?B?RjNNekxRQ1ZhYnYxR1M4dU9iYm9XNi9kRmNzV05RN3cyOVUrQVpVUDZUYmNn?=
 =?utf-8?B?Vmlhdk8xTTRCOG13WjIyWnU3ckxjTk5XdUVhRWtOaGtUdVVrRS8yQThvR2o5?=
 =?utf-8?B?NEpYQ05YdDRPaDBsWU5Va2FBSWRiUlM0M2E3NHlkMU9WQklvVHdZdDh0R3lE?=
 =?utf-8?B?N3RNN3BsWTdCcG9SSmJoSWVVZTFOWFZyVGVZWGNJU3oxVVBrc0pxRXliTmps?=
 =?utf-8?B?S2dYR044M0ZRdUV6NEt0cFoxY0dQTlNCUm9DdFNhSjZESU8rUWVkazd2VXFE?=
 =?utf-8?B?b2lPbEhKMEdMVjY4Qm1jemFra2FHRFZkVHNPaWtPY3RVeEV6UXNJZldOd2hP?=
 =?utf-8?B?R0RiOUNnVGFjZlZoUW9oNEZZQWhXSzlnNWozVE9EOE1ySjYveFUrYkZQR0Ex?=
 =?utf-8?B?M1drUkVyMnhzYVVNUFdxUUdsR0tmLzM0am5Nc0tEdUgwYU5kWDR1QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 86da6891-37f9-47b4-b1ed-08dee737a97b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:52:18.6866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZC9TijiBRQCMFXImU9X87H3zGRCimDDPjsHWYfORnPSpZat4LqDDxylQ3N0MipiZEMjFqtyFULp3wrPMGhaCto6cCdTVSBlCg91HZ3YAEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12066
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM7NLDBE7r9YlDCeRwimgWFCjA+YSgsYuiHxS7uASCg=;
 b=PnOaPq8njAHKVoyRzXMzHzaDZT0brndnLl3zEFOv6Nn86WoK1YiqDWq4G+YsHXav64TUkm0pQhGrSAZ8ZDrBgmRFOGzDYDHSroozskCftSuaeGqyebLdg8WEHw+GWBeF/DBXRD1MNUc0CtBMnxeLXmkKz+HcGdKE65vCMmoNGxc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=PnOaPq8n
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

On 7/15/26 7:31 PM, Tom Rini wrote:
> Hey all,
> 
> As I've mentioned in previous release emails, we'll be migrating our
> lists over to lists.u-boot-project.org. The news now is that we have a
> date. This coming Monday the 20th of July, we'll be turning off the
> receiving side of lists.denx.de and then importing everything over to
> lists.u-boot-project.org.
> 
> What do you need to do? Nothing much. All active subscribers and their
> preferences will be moved. This includes how lore and patchwork are
> linked, so all of that will work. We are going to try and ensure no new
> emails get lost in the migration.
> 

OK but does that mean that whatever mail sent to the old mailing list 
won't make it to the new one once that cut off date is met (that is, 
yesterday... yes I'm really asking at the perfect time :) ). Essentially 
my question is: will we lose mails if they are *now* sent to the old 
mailing list. I'm assuming at some point in the future they will be? Is 
there a cut-off date for that?

> Based on feedback from the test migration, we believe we know what was
> missing to ensure that the archive links are stable, and so that should
> be the case when we go live again.
> 

I think we're missing an update to lore.kernel.org to monitor the new 
mailing list now? b4 shazam doesn't pick the trailers reviewers provide 
on the mailing list since that date unfortunately (due to the mails not 
appearing on lore.kernel.org I'm assuming).

I **think** there may be an issue with patchwork as well since I don't 
see my answers in there either, see 
https://patchwork.ozlabs.org/project/uboot/patch/af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makrotopia.org/, 
https://lore.kernel.org/u-boot/af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makrotopia.org/T/#u 
and 
https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625465.html 
for an example.

Cheers,
Quentin
