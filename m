Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F88C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 11:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F79806D8;
	Fri,  9 May 2025 13:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iwi/rDyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078998210D; Fri,  9 May 2025 13:23:18 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F888059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsH81A1I8eI7CichQoIzu8lqD7iCK7XEqSQkCXWiNIMDQdGiBrW/wbefYXR+gDiyDGc5uWa3HalIGwq8C6GRw3DwrC3KSkCbv4fV9RpTQcOZ612ZeUn6iB9sF1k0+YeLj7QyB/zYHhT5A7bwGSctDhYj1EjQr+620e49x2s+j4qjmDcBCNDivOqS94D+BqT0vVK11XiDhde/+urS+3zbPjMkP9ark9kn5iVf5jETazQA8pa8Pmi0N4XGoTFtuliHWSXfm7/GuM3OEVBex+PBNeSOA92qLDUSix+7lK5pD7acM0JHZAO1FVPSR8zcDAqr7HR/8+YjJrCuRtN4qHIj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hkby4r3QAhzyILkY9rgJBguMwxeA9f2E/E8CQejOVA=;
 b=fK9A47JvE+7pqcnl0eLAVOpBejSkhbg4h2cuX4YB5NcZH+eJWTIQYz/Wrt7D+12/xDnOaxkUtf7lj+87G8oBkXkRbQUhRECwfBAAe0jLje9U0xeWAjycJIXE2A+kTvy1xW7RtGhA1E6syJsuEPaUsnV4yMrvObq3O7WhVXZhIkfD1OCYuJgKnj7h8uDHURAz3DwA8GPpTaoR0928Ye4y2crb/74OtY8BZCistgv+c/GzsSBSQYGqs2KXpfTR2kzio6yLmuHwWcyyTtuW/cK8/7OlIXL3ipO3hr7JPxgjZ8TzcW9z2I6cG4Yhnw0GY2OA9l7kGxiY8I/lKjZk7mgbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hkby4r3QAhzyILkY9rgJBguMwxeA9f2E/E8CQejOVA=;
 b=iwi/rDytIef4dR0FkJ4memPs9v15uRzvk0AgtJPYgha47RBkrDynd8FBEsyZRpPFTQ9jBmuSkANRPRPCxPrWXGWm4i8yvKDzg7/Y5XgDxwinib2oVoyLyQTNAto7Ji0qgK3fm9N2721+WBVQoozvmZWSv+DSlemATkUPacKbBSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10342.eurprd04.prod.outlook.com (2603:10a6:800:219::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 9 May
 2025 11:23:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 11:23:13 +0000
Message-ID: <8cb35090-e326-499f-9e4b-5d909b19a4d1@cherry.de>
Date: Fri, 9 May 2025 13:23:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] dts: upstream: arm: st: add STM32H747 discovery
 board
To: Johannes Krottmayer <johannes@krotti42.com>, u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-10-johannes@krotti42.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250508212058.640483-10-johannes@krotti42.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10342:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a4724e-e0bf-4bca-b167-08dd8eebe2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NitFakNyRGZ2ZHNpUFJLUU5acGcvTU9sckFMYXpwMWJFZ2VUZjloQWhQWkdt?=
 =?utf-8?B?SVVTRC9mcnpmOWFESjNEZ0tNb3pqNGh1b0wwTk5PdEhETlpWYk40NmYxSzRI?=
 =?utf-8?B?MDdueWlYSGp4WnFyeGx5ZTFlYitzdlJOMXlzb2hNQkZuZE5ZZGxuRDJoRzN3?=
 =?utf-8?B?TXEyY1djSmZQdEgzdTRhSzhVaTVodGxYTlpGaXFyWkpnOU94MmxmdFdXU0JJ?=
 =?utf-8?B?YzUveTdkR1QyUVJRSGZsQUxabHJKTTc4UjZBdThVWisyZ3VOWnduOVNrTGVu?=
 =?utf-8?B?T3g1cTZUQkozWStQVUM4ZUgyb0I0bWVvcXB1L29MbWlzMG1uRkhwbDdQb00z?=
 =?utf-8?B?NzE4T3BzR0NJQ2l4RjZDeGs5cVNrcUYySGZmdVdDN09SZUIzSHZneHVoeW1L?=
 =?utf-8?B?YjdQc2xiTGR6NnZzcUoxblNlZXJtVWExc2MrUSt3aldOYTF6ZUlxb0RrMTV5?=
 =?utf-8?B?MDVBQ3BJdGFQeExxZVZFVDNteStuVFA5MGdqdWF4VVVSNTZXVHF0RURzM1pt?=
 =?utf-8?B?TWc0dGhueVdNU0FiaGVheG4zQXFENjk4Y3VmbmNTMWZacVFKaHBtTFN0cmRO?=
 =?utf-8?B?R3ptekkzUHJxaTFLWXJqT0IvdUFjNllPUWRQRFZkZmFhTm5nZUNERFpTNDZ1?=
 =?utf-8?B?dmYvUFlVd0dMTE5LR01na1djSjcvS3RhTXFXeU96R1ZQWEhhNDRUVVRiN01j?=
 =?utf-8?B?TDg5ZGllTm4xbDUrTGJnV2VMbW1RT1g4RnVteGRCVmY5NWFBYUxPcjI0YXRP?=
 =?utf-8?B?a0RmSXl4Y2ZMclUreE1EQ0J0TGNacjgvYngzN2dnckExK3JNWG9Ta3N1aVlK?=
 =?utf-8?B?ZFhTbGFwWGhnOUFTNldlSnpLQXRjSGpHODh5RU5HT3dWM0ZycVIxSGRCT3cr?=
 =?utf-8?B?RkhqNldlcmVaTjFUUlJ2amRqNGozVmk2Vy9NZjVJMUdQOWF2dm9vZ2hnTE9u?=
 =?utf-8?B?WHNZVU5XS0twREh2eVNaamlKaFRScG82RXdQT2pHbzRRWE9PSEFBTXRtRDNy?=
 =?utf-8?B?d0F3dFErOStrTERNSWNQSzlBQVhjOHl6UTZKSVZZcGxjNHZVMytIbWNJTTRn?=
 =?utf-8?B?VnlWQTN3SnQwakVnL3BOeVRWdEZWVUMzZHFXbWE4QnBkdWkrZDdIeDRNUlkx?=
 =?utf-8?B?NkgzekJhUnR2aW9rWmdmbTNveXpzNTBhWEk2OE1TaVBYSGZ3UUNZWHQyTUxt?=
 =?utf-8?B?KzhqejB1OFJQQWtXeE5McEptYzhNNEFGWFA4VHVvYXRNcUFwOWxyYjQ0aTMx?=
 =?utf-8?B?R1dzV0tYSVVqbXlPOGtDR2xGM2w1Y1U4ZDA5TzhDdWtrY2Y3cnczdUw5YlZW?=
 =?utf-8?B?UTVJLzJjNFhUb21DdG1IeXR3SlV2MmZkZUQzU1FWcXNIYmh3SllxUFdvWVBT?=
 =?utf-8?B?QkV0Ni9aRDNzR1ZObGhSRkJocjVhYjhuK0Ywc1FEN0lnYUFZMnoyYlEvNGUw?=
 =?utf-8?B?UFdEcElpNHROMjd6dFEvNEpnbEw3emYvTE42SUtvelZBdEFuYXRIRDBqZW1E?=
 =?utf-8?B?N2tCMmIvSGU4M1BRSVdvTi9FM3dvVGlMN2pvUU5zdTNkd1N5MCtZVGZYTExi?=
 =?utf-8?B?eVhmS1NVejE0U1VxclNWYzJ4ajdiRlhyb2xidTNNdlJuWVRqMjBMOFhqVFdQ?=
 =?utf-8?B?a3Q1RGtEazB1SzFHMFIxNGJyL0RtcHYwTWF6Wld4eU8zR28zUWZ0VlR2Nk9q?=
 =?utf-8?B?N3JQcXJleXROUGpGaSt0eGozcTl4ZlJ6TXVMUktJK1lMUmY3UUVLcjUxS3Vm?=
 =?utf-8?B?Rkh3Q0dtd0M3Q0RTNnBxc25HMDY4eStoUnUvZ2lGdGVRUmx5enJ4OWRkWHFm?=
 =?utf-8?B?dGM0eHRoUHhKTDdoNEh0OFozRmVLOHlxa3BuQ1F1blVDTHgwWGlnNnBRYzMy?=
 =?utf-8?B?Q0dRS21LVzVpMDltR083OUhPZ0VndEVQS3hlU1ZsS05pMERwZU4wQ1dXc05o?=
 =?utf-8?Q?APek9RT9YmQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZ5dFJTbHlFbmFuTWdHc0NGMFlOZmlJYmpTMG1xQWNobGVGSDR2OGV5MkRD?=
 =?utf-8?B?RFdUYVpsNnliVmpkaXBEMHVxSXRnNTNUUXBtMmlWbWlQd3VlYmFJbUhES09Z?=
 =?utf-8?B?U3h0VGMyNjd6cXN2UTlFRjJkbXZEaHgzKzBDdTlOczQ4RVZTZzBoYzN1c24v?=
 =?utf-8?B?bUlOeGdaMEIyRTdvZGo1c213cURuNlRzUDFML2pmSDNJZDNFc3pVNTRzZEZ5?=
 =?utf-8?B?NXdXdDJKV0R4bWhPUElWNkx5WStVVXl2SjdFaDFsMVFiMDRoS3NKQllIYmdr?=
 =?utf-8?B?ZzFZY0lMbzdibzBCZ24xSG5tYXl6cHVxZHFSSDJtSG8xVFlnR2diSnpCWU9v?=
 =?utf-8?B?NEZyU3FMUXRBUFdhL25lYmRXV3JBOXh0cFlZUDZreFZVV1RYNTdkNElRY1Bw?=
 =?utf-8?B?cUlpTmlHUGZlaFBuRUlORmM4b0FsNjJCc1hlcFhZQVVRQ1RrYkpHUis1TlRG?=
 =?utf-8?B?KytUL3hkNmw2dUNQUnZ4RGRwcDRLYXlFZC9CazYxVWVPOGNYakhOdXhzSjZI?=
 =?utf-8?B?T2N2OExqQ21Bbk5sREl3MXQyNWJpeWwraWRsdDNBWjRUNmUyZWJVcGZFNS9P?=
 =?utf-8?B?UldoVTlkKzdua05BTjdvMkQ0cUZmczQwajh4S2pXVWE4aWJURkFxMytCbkp2?=
 =?utf-8?B?RUsrUUVMNkpRMW1QbDBFQUlDM0tGaERVcTljWmVUcmoyYi8zd0hqRElJNXJJ?=
 =?utf-8?B?bS81RGN2UUhGT3lFWUY2ejhPQ2NIZUM0R0VtKzEvT3cyWkRtQ1FxREFmMEdJ?=
 =?utf-8?B?ZUh3L2JnZ3lRS0xjck5Jc1I0MThMdEs1VGZTSDczRDkvaEd3RWVOUm83VUNP?=
 =?utf-8?B?WkxsWENnYy9lckpwYkNOVWxKZzVnSEJYbnpubDZCVnk2Q0JDeTEzWlVrZnNi?=
 =?utf-8?B?QVI4cW4rWW8vT3EycldOUTFId3dnZnFnTHBOc0loMmxEQUVON0VPeUpKVitU?=
 =?utf-8?B?b2xMMGhGSU1OS1dCZXhudXNFbm12RWIyeTNXUFZCQWRyeFVxRG9vSUNQQ2Nz?=
 =?utf-8?B?dFVreXBPZmNqMUZTY0NEbTk0NTdTNEY5QmRhSVdGYWJ4bHZGRmR1bWF4UHMw?=
 =?utf-8?B?OTZ1bWlLZ1c2MzZLelhWajRTUEdBMXIzckQ4bFlEMitXdE9EMGd0NnlxdWdS?=
 =?utf-8?B?ankvZk1tbHNlMzJFMngrTDdCUzhkRjFyeFp3ZTJIdjhOaDV1TWRETTVvdlNy?=
 =?utf-8?B?YWF5Vm00ZitnWmpmUzZmRThzSHpCTTFkeCttYURLSExMMlNCaUZjVEZKQzhG?=
 =?utf-8?B?WEk5VEJwWkwzSnptekEvcjJvcWQ5WGpFOXU1Q2J1NFVzTGZ6bDVMRjQySEVR?=
 =?utf-8?B?RW5tSUNZOFBtcDJhWUxZc0tVK21lVDZLajR3ck5hZmxSWGxTNzFQOEI1SFAx?=
 =?utf-8?B?eWlTa0VXQ0hVUWNsenlNTzNVdEVCTzR4WHFQcThvamRCZktPM3NLei80eHlI?=
 =?utf-8?B?WlJQdkZlaG05L0kvSDk0enFxaGdCNjdlZysrV0FSSTNVNkR5NDVXSFZKK3pM?=
 =?utf-8?B?MXI1L3lHdm0wc2RVN2xNbllxL0ZUVmF1L0hjckowbVJSc2NQdmlHdEpmckVG?=
 =?utf-8?B?d3c0OS8ySTFPRHNuQVQ2ZDVKVEE4WEQrZzVEUFJua3lsVUxpRmc2RzdYd0Ri?=
 =?utf-8?B?SVl6ZWlCS2owQkR3TTlISFZQZjJLbExSSDhjM0RaaEgxdXJrSElmVmZXNjd6?=
 =?utf-8?B?d0VwT2Zici9ueC8zQkFLUUhLVTk3RXJzMEM3WmhiaENDbkJwR2FUQkpwTWt1?=
 =?utf-8?B?RkRXZW9GQVQ3YUhpMGZTN0dNMVFIN1FuZGN3dVk3Q2JSeCt2NUtkNG9lOHg5?=
 =?utf-8?B?aE1WdS82MGpSMnlTTzVaUWkyak5mNVg1YlhCR25ZUUU5ZTJLZm5BSGpSL2gy?=
 =?utf-8?B?Mzhoa0hIcTFZREw0Q25QN08xT04zNnRNL2RFR1dJSjBIWDk2ZU1YQVFzU0FH?=
 =?utf-8?B?NXlSRnlBMEZiQXFVemt0Rjl2TnQwbUpRdE1DUUxwcmI4SlZ1N0s4MDIwU0Z1?=
 =?utf-8?B?UXVsTEdOb2k5ZE45WGFPZFNLeHpWVm5OdXI1UVY1M2w1cHdocjZSWVNxWTl3?=
 =?utf-8?B?ZmcwQ0NHclBrM09hdHpvcjZLS2JncFUreVJDVExTUDlnU09mbzl3Y0k1amVK?=
 =?utf-8?B?UWxHemwxbDJpa1NvL1ZDeDRUcm8wdnVEWmZQNkZoemtUWHFaK1doMThSOXBV?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a4724e-e0bf-4bca-b167-08dd8eebe2c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:23:13.1579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Brxknpe1Bz9gLVsuxMbRaV3T7ivFcfJoNfwd7iSNNsU03g7ML1XubXvdV3lv+S4U+yA68pvoPYx7ohVwS2ek3QMMGHcRe942dSwKUjxbXu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10342
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

Hi Johannes,

On 5/8/25 11:24 PM, Johannes Krottmayer wrote:
> Add initial device tree for the STM32H747 discovery board.
> Copied from the STM32H743 discovery board and modified for
> the STM32H747 discovery board.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   dts/upstream/src/arm/st/stm32h747i-disco.dts | 115 +++++++++++++++++++

Manual modification of dts/upstream is forbidden.

Please use tools/update-subtree.sh pick to cherry-pick commits from 
devicetree-rebasing tree. If your device tree doesn't exist in 
devicetree-rebasing yet, you need to wait for it to appear there or put 
stuff in arch/arm/dts/ instead. I highly recommend to wait to lower 
maintenance burden.

The kernel seems to have merged that, c.f. 
https://lore.kernel.org/linux-arm-kernel/bf7eddfa-ca7f-49a6-a3f9-574f2c4fe972@foss.st.com/. 
You'll need to wait for it to reach a v6.X-rcY tag before it reaches 
devicetree-rebasing. You may need to cherry-pick more than those patches 
if there are conflicts (or simply if it doesn't work).

Same remark for patch 10/10.

Cheers,
Quentin
