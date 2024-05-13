Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA6C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 10:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14A987F39;
	Mon, 13 May 2024 12:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eNJx9Ynp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE88B88228; Mon, 13 May 2024 12:40:07 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A3E87D4F
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 12:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXTIVtM0im0BWCib+/fvSRNAxJ4kcKdthweRWSTYHH5RJMj9DvwUXKaTCqS4hVEtBUkfeysJUcZPaOxS2Q0ziRjH5XVDZW9d6UasF0iIHgXH3QqQN1tKb6y91mgmhkKN66wvaIXzRkNZvndRf+UzS3Isvv9dm7M1z7e7hESs8xH10FI5Y2G6IU+OZ+xeEXKbtWwKajLD30IstTqYS5K3VLbn0mr/2phljsYm3O8n4g9qLzJRCGqaco6qW6tzULR7/Ey/mKv2swp2toA5Kl/ZXeYR9+nhFbUaEIAJUM4kxhlpfgOpkyc3fSdjvDPNDbqyuTcyvHJregWksZZdA9mUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mEq7wGosnQCxw5Akk9ouYU0sbqkeX+APMfLUXuoelk=;
 b=Q24csT/iXz9Pf1yJ11E+9QiJ2jGOHoJAi8XPygoivjbilP0rYsWe3fkhrCxFdvgt7S/FOsb+j/Tzvk/Yjs5zmlgslkY8cF32MO+6xeuIV9GGv76khNQtYVVnRgVeVxbdIwuFS1O9M3rrO5yAtAkF3alFf9lQ/6ZvlpuTTsecIsoDQ+HJnKXRPnkWVoyab1vp18H/CCRvlDFwOsbeN/cmcatorhSYTlp/SDzk2KMq90wL2wKxdwffk+/Kp4l3XqChrzIlEhl+PV21Q8AKvPYZ4wXAr0G40HGf3UMG/eSSmto+9TQMF78pjkK7flG4zh0QYPCMeSW850Lv4pLlfQIGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mEq7wGosnQCxw5Akk9ouYU0sbqkeX+APMfLUXuoelk=;
 b=eNJx9YnpsxQKxE09Un5iYgU2/H9SJlxTViNEBPZiOFjQOgdTp2JuCafAOCzxrcedtUKgdYwE4X8oHM5R4MbG5McheIDUoGEEzb/Iy0MkTf0GJ6M8MIq5FTc4Bdvjaq49d4CZnXgzmTr6rrdR5EEoo5vrKXyE8iSzalksRbZXtPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by GV1PR04MB9214.eurprd04.prod.outlook.com (2603:10a6:150:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:40:00 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:40:00 +0000
Message-ID: <6857bc47-895d-45bc-9b7d-d00ac7b0ec1a@cherry.de>
Date: Mon, 13 May 2024 12:39:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: rv1126: Migrate to OF_UPSTREAM
To: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Tim Lunn <tim@feathertop.org>
Cc: u-boot@lists.denx.de
References: <20240511161224.1176-1-anand@edgeble.ai>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240511161224.1176-1-anand@edgeble.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|GV1PR04MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 60407522-40dd-4889-12f2-08dc73390961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGF4dDdMQ1ExbzUrVXppYmNLZU9CVWF6V3RUMVFCclhpUHZuTlhVaFlscUFU?=
 =?utf-8?B?UlUxNTJ3SmZzVzRCcWFyaUpBWEhuU0lXTDM3bFRIQkhnUmlRcWFpTWlvOHdV?=
 =?utf-8?B?SlQvUWJUZEI0dm5qdnJGRDM2dTN6MVhFazJoc1plOFU3MEVRdDFXZ2lYQlcv?=
 =?utf-8?B?R2p2eGxkdUUxVURvMFlDYS9GK0lKVDFINVVjWmRVU000YktaUW5lZWV2NVZ3?=
 =?utf-8?B?Y2x1aDdpMEJlRU1EazJmSmhyekRRcDRsOHBuV3h0Zy9mVmpiK1BCOTNKY3R6?=
 =?utf-8?B?T3dld2l4U0RtUGdqSkdZeGl1SzNZRit1SCs2Q3JEL2tzVExrTWFIOER4bXh1?=
 =?utf-8?B?WCtIWE1rTHBSUlQyQkRMTGc1RVRxdGh0aEM2bUFmTGhNQWYzMXBrZlFiTWZ5?=
 =?utf-8?B?K2lIeGRKV3diWWJvMTBWTXp3WFc3WWtLSDZIOGg4QitPT1hqYzh0a0EvU3JB?=
 =?utf-8?B?WktUdEN1YmpvRUlKOWFBUkV3U1hzNkRHMzZBY0lRYXhWSG9HNm1TVm1SYTRC?=
 =?utf-8?B?ZVA4b2RVS2pQYjNXMjZ5YTBNTzFrZk0wVlJmemh0bjVwTGQvY2FjNS9TZVBz?=
 =?utf-8?B?RlN2NllGYW0yZUV5b1JIejdTRHpMOHM1em52NjJIUllKRXFLcnEvWnkrYkVD?=
 =?utf-8?B?VDFDZm8wbHd1QVM0UFVsSHJKb1lXMFNDSFJySzJzZUEwcDFlMjlsSEdkdysz?=
 =?utf-8?B?TXUzQWcyOVBkVnpLaEthRklEUzJHWm85R1V5L3ZvUksrUTZsNS9iTTlyRURm?=
 =?utf-8?B?QmZsR3RVUXpFUnhuRXFSejB2bTJkZ2dsQ0puaGY0T3lja2lLRVVYUE5LMUdJ?=
 =?utf-8?B?eTFuWjJydFloKyt3LzJXMWsxdWx4M3RVMVkweW13aElXWHdrMEhwdUYrd0Iw?=
 =?utf-8?B?RFVvam1qZ1M3TFFIa1NodHYxZGdCOG9MMlpVclV4VnJsNFY0bTkrNWprWWxs?=
 =?utf-8?B?WklUSk55V3ZQWWtDV1RGTHlOUkppeTJoamhqSzFUWGUxa0V1VU5mZG5obk9Q?=
 =?utf-8?B?bUlTamlhMGpIZks5T1E4UTQvajlVSC82S28yQ3lJZ1dsOEp5WU9HeVE4c2pi?=
 =?utf-8?B?aEUwUzVSTDZKeUFRcHV4WkJlRHlqY2VQUXFhei9Mb2lLa0RlTWpvRFZqbExO?=
 =?utf-8?B?Mi9DbVNIVTBNbDZWYmZqeFVaQzFxbk9GYmZreGg2OERqd2t0V1craXhQT3Jt?=
 =?utf-8?B?MzJQYVMwQW1MaDd0bGh3S1labG9jdW93bzc2Y25FWDJtaHFSeXBGRVA5a1cy?=
 =?utf-8?B?YUZxRkgxL0J6UStqa1J0amxySnJ5cWwzbDRLVkw0UnZ5aUFzb2FrT0NialRq?=
 =?utf-8?B?NktTSkM1TmNwUTlQNEp2THFVeEppWnVCMms5bDZ1U2hzZFk0bVMzclpmWHFl?=
 =?utf-8?B?bWdGd1ZKQW9GZkhuN2YrcjJPZlJCUlBwVXdCUG11eDEydXIxSUpuUm9MWHNB?=
 =?utf-8?B?SDgrSmE4U2tYM1V2WVEvT1ZsVWpuZkU4bXZlNVd6SW93dVErck5XRG04VXJl?=
 =?utf-8?B?N1NZTjBEWmNoc0V3MjNSbHd5N2YvNEREcUtkQVdzUmY1czhKdkZvdXpMOWFK?=
 =?utf-8?B?ZEcrMnpDdWpwa2RqSm9OQ1ArMit5KzdZUHF3anh2YVVNQUxXNWFIOWlwUFVk?=
 =?utf-8?B?eVZRMlVvZFkwS000cHFScmxvdU1wWWc0NWhCKzYyTm5qUXlWU3hlZjFqWDhT?=
 =?utf-8?B?ajljZGExUVJqVTYwODdSVGVZVW1pQ3l4S2J3UmtnVjVpK21md0VIM0l3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pqSzYzV1pGQzZvL0xUalRQMkNlajQ5enZmbWpnWnRaVjJMMHZBR0NaV0R3?=
 =?utf-8?B?ekgySm9SaERqc3pldEl3N1JyT0dYMW1ndVo4eVg4TUtYSHAyMkI2VURaNEZl?=
 =?utf-8?B?TVhPd01JNDN0VTVicURrMTMvNTN6dHlTMmJQVnhuKy93a1IrOCtwellEb3Jk?=
 =?utf-8?B?TkNJamxTWmV2UzE4SGRmS2dlL2RBU3hjTmRWSisyQVlNMlF1TmdZTk9UL0Z3?=
 =?utf-8?B?M0RQamQrRGZBd29kN0hiYy9wQnF0QnNTRVo4cG1ZaE5vbGhvV2JNV0YzYTk5?=
 =?utf-8?B?bnhLci9PUzdnSkNMcGtxRXBNRW1oRjJUMHNKV3NUYXplckFEeFpGc1F3WVE2?=
 =?utf-8?B?WllUZWlwL1ZyNDltU1FBbFZ0akZyVW8ydkhFdjhKaWQ3bUFzbWVseUN6cTYv?=
 =?utf-8?B?dG5vSEVIRjk5cVdXaU8zMHlDNHpYUC9hWllzSDV6Q2QrRVFqUkd1aTd3TTlR?=
 =?utf-8?B?enVVcEhTWkdqb3lpcmZoYXliNG1wbDFCZnJpZERGT3d3VzFjZld3Q3dwT0U3?=
 =?utf-8?B?MHM0eG5IS2tsTUJMdDRseXVEUENVTHFkMlJMZ3NWWmxkalNVZ0VuQzU5eWtP?=
 =?utf-8?B?MHFJRitYaEhTWjJVTkVTRTZEUGwxSHlLcTg0QWFIcCtDUjluSVg5YkhlVlBF?=
 =?utf-8?B?QnhpdG5ZSTlwSFBRU2hMbU5RbDNyV3JUbHM4eUc5a1EvZC91b3h6cjFXZk9h?=
 =?utf-8?B?aXpGK0JCb1dCNEZZVURVTGxoQisrTkNEUFdwY2kyWUI0U3FYMExPcTViZ0cr?=
 =?utf-8?B?ditMRGlJaDFGclRuSzRFSXJCenRjMVl4Zk1DTUgzeTJ3VC9LQlJ6eE5xaUlo?=
 =?utf-8?B?aHJzcEpjbXN1QkpwMVRqSW9jMHh2RndvNThZZTF5d2RRNlRpbnVrcGRRTlNZ?=
 =?utf-8?B?RTNXVjFZQ2VCTk94eXNDVVB3V0JaaEZtcEdiZG16SmJtUXhmU1JvR0dVOHE0?=
 =?utf-8?B?alZORlYwR2oxWHl1c0MxWlNjM0pWZHRnTHZhbTRsU0FPV2VmSXYwZ1dJZ09q?=
 =?utf-8?B?OHNkQ1F6ZUR6TEg3Vm5iQmxER3o3NFFvZndUazJYRVoxd1VMajRIcXZsaFFy?=
 =?utf-8?B?T3JiOE5VcHV2TmcwbGlYVzA5WEdEYUhMdFNLNXorMWZIOXBwZHNlTkExbUlP?=
 =?utf-8?B?ck5Sc2FCRlhoVkFKK0FROFl2ckh6aHB0cTFkSXNrVXVRNzhZTDBXWmtMYkRa?=
 =?utf-8?B?bUlKeFpMYTV5dDRxOEhUNVVHbE03a3lPTjNXS2NkdU13QXgzZnpHYnlQOVhS?=
 =?utf-8?B?emNsa3JVV05WQ0dDc1NqZGVZNXZxNE1XNThiWG5XK2ZYVDloTFFLQ01jZEFS?=
 =?utf-8?B?R0NxTTJhQ0kyTFh3SGZzSEUwOFFRQnlwQmZ2TTUvUVZhL2JaZ2FqOGpUODNK?=
 =?utf-8?B?b3liSzNpWDNSdk8xR29uMTI2djRLclFLckwzNC9YbFVEL1M1cnRDTHM4QkU1?=
 =?utf-8?B?SWdpYTE0bmNHZWVxbm1JMThoKzRBZy96WXBPTjRzSWV3RVRHZDNQRnlzL0ww?=
 =?utf-8?B?YTIzTXRYS1Y5akVvd2ptQWtsNDRCUlhRMGVXUEdhc1ovUzZReGZPQ28xZVVG?=
 =?utf-8?B?YU1nbVFlMWZzamZyV1FHdzBTOXdzRnVzdUREalg2UmIzc3FyV3QxZ1NuRHZu?=
 =?utf-8?B?a2hvQk5UMEE2eWVkazBjcTUzWUFXd1ZzYkpxOFZkL0NSMlRrVFFqQXlSdTNB?=
 =?utf-8?B?bGJKSWhnWmRUbVp4ZEFMOVcxOGQ1VEdSNCtaZ1dQMElsSGt2L3huUk1OQWpR?=
 =?utf-8?B?cnJxc2hMNElCTGFiRVpKaWh0ZWNOUXlRVjNHRHkvdmVaNVdQYWRQK0c4Vzcz?=
 =?utf-8?B?b1Z2eERQNEpBNE1uKzZjSkVUQnVPTmN5cFJPRmpVN1IwSEdaUjhWTDlkZUk0?=
 =?utf-8?B?Vm5IcmZIVjZUdktZbmd4RlhXa1I0N1RGN01OYmR1U2JvMmIxK3QrWkpxa2kv?=
 =?utf-8?B?WW4xclNvMFp1VG9BUjJuYVNCUENNbzA0NTR6ZXYwOWpvTktHcTd6TzJtTnNF?=
 =?utf-8?B?UGo5UVNmR05teWxsdk1WTzVEZkc0OTdZZmJwUVlqaGY3US9zeWZsZWwzMDdr?=
 =?utf-8?B?OHNFaHZudzJ1VmMvdGpHNmRYVXp5bmo4OGcvN0lFdVQrdldvZHVhQnkzUFFF?=
 =?utf-8?B?Q3p3dzhZYS85VEpnd013Q0ZrbDdPZWpabHdwSkF1VFZNYU9RQm94Sy83c1dv?=
 =?utf-8?Q?mTQOWZjysv5MkH13str77sc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60407522-40dd-4889-12f2-08dc73390961
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 10:39:59.8857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikCndp9q1JFbWjRVaWRYBFdH/V3yT/nJekr5EbR2r4+RL6c2EZMzlW5h1Y0dIeXXw45DG53d/R8otV8vpWBHB/2qZjzcqjLpHWWxsKhzhUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214
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

Hi Anand,

On 5/11/24 6:12 PM, Anand Moon wrote:
> [You don't often get email from anand@edgeble.ai. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Migrate RV1126 boards that exists in Linux v6.8 to use OF_UPSTREAM.
> 
> Following targets is migrated to use OF_UPSTREAM:
> 
> - rv1126-edgeble-neu2 : Board is an industrial form factor
>                          IO board.
> - sonoff-ihost-rv1126 : Gateway device designed to provide a
>                          Smart Home Hub.
> 
> Cc: Tim Lunn <tim@feathertop.org>
> Cc: Jagan Teki <jagan@edgeble.ai>
> Reviewed-By: Tim Lunn <tim@feathertop.org>
> Tested-By: Tim Lunn <tim@feathertop.org>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Anand Moon <anand@edgable.ai>

Doesn't match the mail address sending this patch :)

Cheers,
Quentin
