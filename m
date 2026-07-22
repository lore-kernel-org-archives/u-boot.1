Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA844C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 09:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EA0B40762;
	Wed, 22 Jul 2026 09:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2HPtuawhY7y; Wed, 22 Jul 2026 09:29:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9204B407C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784712543;
	bh=G5szRJd6pdgNIBayU5UvfFbish6xeqfTNLeZaxS3ah4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ZN7KzaxVmAZu5cmwveF2AYZJeSeBf9KOgA3sfkIn06BFAOlU8wXKnbwvsieEB2xC9
	 VDkCxAaXNd0O4CTbpc3pPbOZn9u+1zCn0lp71b3SCfuQ8FLJq+xlfwCukiePYzmpUs
	 DEzYUgmutlFxPsZwRMfEHUvDqxlpghBWjyW9OTr62xROIPlmxlid49DA3f9iSt5SD2
	 LiNKmmvjGzw8utP7U2oQZu4ZvI2kLc/YgPKQ30SdAyxG8AYQN6HBnVk9PC7MkmTpsW
	 hlViWCGjaZo+QJtW8Mof9L0yph4G7aJ25+Ta1N1Z4ZAJHKqLSVQe6DgIgIPqEfyFeJ
	 gPXy4H+x14bkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9204B407C1;
	Wed, 22 Jul 2026 09:29:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F5E9224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84EBD407C1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O2AJTkZR57fC for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 09:29:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 04B2D40762
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04B2D40762
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04B2D40762
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:28:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C6E848BA; Wed, 22 Jul 2026 11:28:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372A8803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:28:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtklHP1bE1AvU9ZthxfEycBQPHVh+I7HkhN6e5Tk3zNmjEuQ3Po5hZvJe6q04/oSjFYaSFaxeN3jCwyEZvwynCJgs6PMep/uFZLsUq6wr1TpDwtoiwCfjHJbRu21144IXbHhprPebHhwRn5orgdtBurdBvcf/UFzvAPzmRikEA9f8RchxluLOHG1sCpwME0Djdjxo6Na78QNR8Wkjv6HgPKXvLD6yqgchmN7LG9XjXBD1CPUGa6v5Kl/fCRGoHMxitCXYyzJnEO5dHgZSL/UqcW+lEy/zGCGeqbF+bwIgyRiuto2bNNuwXS3cMlrW3rHR63JHSm2m/04Ol5pUY7l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5szRJd6pdgNIBayU5UvfFbish6xeqfTNLeZaxS3ah4=;
 b=fbEMH7PASpGp0PFnzryDyJY9vznpcItSon2PcEtgGlmt+ktw/y4raHZYfXSqTuBVMoEy231244/AoJxSXWWMV/rHvgQ/360nXg5xnGYHE8QBV6LqmBYtOG0jYL036QbW+7IZldj7Wfx0qjVMvYh5ssINMWeLQg8UhGuX4I+5c6pVsWr/7EHrTbFlfv3DId7wsMPqG1ZCoV5VZgcczHQPHZphOCyIdnYZ/y25b+GAmwSUdkqRUYuv6eSKaRZDPgLPRhOdZPY5Qd6HJBG1+FE4rOQ9kryB3zysnP3cS2LcvsdlOYlPYcDjwEOO1y+OfcYfUdTXpI9xd3e43+bD4ZZGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 09:28:50 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 09:28:50 +0000
Message-ID: <e9100f97-91a0-4166-b62e-d639d41f6ac2@cherry.de>
Date: Wed, 22 Jul 2026 11:28:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: Boogie <boogiepop@gmx.com>, u-boot@lists.denx.de,
 Johan Jonker <jbx6244@gmail.com>
References: <e108fe69-533a-4734-8728-b17b172c4be9 () cherry ! de>
 <68f9f2bc-485e-4cbe-9ed7-8f34efdd8440@gmx.com>
Content-Language: en-US
In-Reply-To: <68f9f2bc-485e-4cbe-9ed7-8f34efdd8440@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 34da0f43-6e94-4f21-cbbb-08dee7d3a39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: rooKukxpj7oqppKvrjMAExR8RQSMllqOS64QEDilhd7p6JZO4PrsQra1IUtBr0BSHmq0nfV9saBmtuyPBfh8NNjF9aIp+I2ArxcNy7B1Lcs2bIqP4hQo0ZAfBveEwlTKQcf8+F6X9fYnD9EjZX3FHBmxLpZNmmofPuAVOph9/XT1zLSq/oNj0GuBOkM89TIKxrs5f3hUzQMr5ZAreHMGFUHfsakFRrleS2B34xnq21vvLRe6ymVMdMz7GelCLej2dT9zP2Be4PVErEEqYoYvNX5u5x6xmi2HgEWmE7TPLkqd/8vRI535MEJtlzkg/SHjolJgERyINjHue5Wz6tmvnknD/s7oL/8nsFjS6tg5Mr303f6F0TsDVr4ZaRpwlWLDi9NW6NuxfDcEoUnZK3+UHkG1q6yndpBJxBee+6EIcg5OioOtfZBCjtxY88sTnVUS3v68b5dY+gqyFePjy2/XwgC+nXYfAvgGoDItHVafgYpH651dgi7vgU/NEN9JEpGGCTHjtMluLwQki25rK7iiLIRbq9gNPNX9QZi47dJBVHW0LezsqghpE5bMMjOTVFkJANaa371maah+pPQneO7fkNuHamd/hOclPY0bFK/9dJtnHAKOgWf6OkOfyxFflqqLp7vDVrhWkxjjWBQBZ/Z9Le4NDu6v8Ed7d+5VCIdkuJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJqZm5mcFhidFRESzRKN0FtT0JnZGhtYndTY3NPREQyZTZjVEVxa3FqVFNx?=
 =?utf-8?B?Q1FHZE1JY0YreUpiLzBVVU9qYU41T0ZlQU1JZVdvb2UvK0x5SkRPaGdXWXdh?=
 =?utf-8?B?ZUlhTm45dDAxL09na3ROZEhUSkRGVDlnQ1lSR2hmbEoxV1QrRDRuakRONmkr?=
 =?utf-8?B?bUVVZUlEUkxLRkJMQTlrb1NkVzJVYVpuYW9qTlZocG9ITlEydnRIcE05eisx?=
 =?utf-8?B?dTJMSUNHanpMZ0Fnb25DTW9IeVRGY0xhMjBJY3VxTjZiNlVMMThMekpKLzlr?=
 =?utf-8?B?dlltQkx1QUpXeWFrVXc5c1VmRis2S3B3YXpLMnhob2k2Ukx4TDZnNHhqVHQ4?=
 =?utf-8?B?K1NpTXc1WlZoNDhXajkxenVtZmZnVmo5WG5uQUZUYkNNL2JEMWxxSVUzcVNL?=
 =?utf-8?B?bGhuZUpFcENFUUtWejF6S3ZMMVQxMldlMUZ5Qk9PaHhLZW80TG1IVmxZMTRL?=
 =?utf-8?B?eVJXeU5LdlpaUWxoODBET3pmMThtSmpZUCttYzhYenlBS3RWSXFKQUFXaUhI?=
 =?utf-8?B?dGtRdVN2ekFnSWtzcG5SRC8xbVZQNWYrVDJZS3k1RkJRNHdpNURXWjg4NUlh?=
 =?utf-8?B?VllZS0xwN1dVY29oaHFYNWZXSTltZjl2Szh4alJ6Um5EMDJnNzVVOTVoYmRa?=
 =?utf-8?B?RVYzSnFISU1TRVBLU2xGOVVHYnJMSnFuZmoxdWNHQ3Y0RmtzZzJ2S1Z3cUtr?=
 =?utf-8?B?OHVZejhHa3NnUXdZNld2Ulh0VnBQaFhMT1Y0bWZWOXp5UmVJdlBJbGE1bTZJ?=
 =?utf-8?B?RU9sTmJkWjZzNFZ3cjM4U0p4bXp4V3g5VjF1cWhmeE5ZL1o2andmSkUvZ0Z0?=
 =?utf-8?B?SmlIK0ZQMTZUOUlBN25DS3ZnRVhFdDh3dm5yZ29LZlJMMWRWY0ZETXJnbi85?=
 =?utf-8?B?TE9kVG43ajh2NXZQMTFTclMvblphOTAyc2FFRWZkakdLVTNTSjd0YmVDSzkr?=
 =?utf-8?B?aVRCTHRHNWVaajcyd24rWXB6LzV5dnVaVCtSalBLck0weGZoUzFmOFFFcGh2?=
 =?utf-8?B?NjVydW05OTVuQ2tod2VZbXV2Nk1iSFNYOStBa2srajlsUFQwaE5mbHcvbElt?=
 =?utf-8?B?V01PL1RZbEdRU2t1clRUSEdPdGludDN4MUxNZjhZSXR1bUNCSmxOQk9RcFVY?=
 =?utf-8?B?bkQ1dmoyT2lVUG5iWTlYSndzVUxhZ1hqSWgreUszVktwdXRmbjdmTFFKNFpM?=
 =?utf-8?B?WFl5S2RuM0ZNSTJNZ1EwVEJhZFo4citZR20zeVlaUHI2UjhvOTM0UGpmOEdj?=
 =?utf-8?B?eEVRN29pMjdYTkpnNTcxaXA5SWo0UHNmZzdTZ05BcFBSR25xRi9uRUNwTEhH?=
 =?utf-8?B?c0JxMncydjAwbXhZRDI4VkQ5RlVqdk5UZG9ReVBTRldQVFpOdCtGU0hlWmxI?=
 =?utf-8?B?QWVST0Uxb1JpWC9HQ3NnT25uRjljQkx5VUdDL3p0ajdNY1M1VVg4V01vQ05w?=
 =?utf-8?B?R3A5aHFyVEpISVFJVmh1T0o0OTAzakw4TkdDL09FVCs2ZFU3Rit1Nk5GOHV0?=
 =?utf-8?B?RGJnaHpyc0N6cFpob21Db2ZvZko5djk0cDJHQXF0SmJmT0FZUktrOFp3RVlK?=
 =?utf-8?B?c1pDQUNYK2NML09oL3VGOGJqUGpVQk85SVlpeVNsVWdZN1IxNm12TlNjb1lC?=
 =?utf-8?B?U1Y2QUpkekxlekxLb2YvcmdaUzZGY2RaOUhaN2cyeGpza2NBNjFxakZuNm9a?=
 =?utf-8?B?dEtHRTRBRWpTMDM1T0t6S1VFYlZmVkU4NWlURnlkaWtBb2FMZFdCT013bXJi?=
 =?utf-8?B?a3hzckgrMWNqYUVHaEdac3VId0VScFVLK0puSTZSQVNxbVVkNFFqTW41bmVT?=
 =?utf-8?B?SDBVWkpxNi9YbEtqVkVXRGV5YTA2bXJMVVpPZnpuZmZZZFI3Z2pkVDRTYkNF?=
 =?utf-8?B?a3NiZ1pTV1VCVkRZY3VEckpnNkVBK2pwMUwwMVNuWjJYeWl2cDNKeFdFNysw?=
 =?utf-8?B?bzhVbHJOSGNPTzFoNFpsNlp1bFpQNHd0U1FXdlkxOVY3RzUrTC9sc3BjRTds?=
 =?utf-8?B?RTFzZlRFa1dKd01GQzRDVUdhOC94WU1FdnRaOXNHU01BTjlJT3hRYXdwdTEw?=
 =?utf-8?B?UFBKSVFSVHYrOU1DN0FXdzhVZWdKWlRraEZlWUo5R285b2FaTEk3TGhWTEZE?=
 =?utf-8?B?bk12TUtHTmpBQmh4d3MyVm9lL2FvWjNEeGRrdlk5U3c3cThadndxT28rTDBx?=
 =?utf-8?B?ZjRvWFg1dGE3YlAvM3prT1ZmYzVQMGNsUXFUQk53TE1Rc2cwYU03aWQvVTN2?=
 =?utf-8?B?dm9UYkxFRW5seGNpb3NDN25maXBGOE5GQUVuWCtFR0JjVmhqRFBncGxmVHoy?=
 =?utf-8?B?SWJRdVZiVXZsREM0M1RPRml6UjhidWp5Z1NMTTF4Znl4UEJPU2lRdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 34da0f43-6e94-4f21-cbbb-08dee7d3a39c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 09:28:50.4704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhyBhrljnlXNGaMp/502IUjvt1LQF4Em7DRELH+n9ltgPuVdRF0yL5LrR4XcPvNwUqy8E9l6YRgyCeG2jGboCpOqIS+1cuFQuEFHcHaM/6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5szRJd6pdgNIBayU5UvfFbish6xeqfTNLeZaxS3ah4=;
 b=ncBFBPOIAAqN5Dxo7ED6XpX+dYv7cmEvatknTnLxZ75yTfHHe6rCf9u9SrM3yWbSRcdDF/j3AxHuAMfykaa2hWlC3ns/DrQAZ+urDB8dDCPxGBoAjIQNVg1ADTS2U2PWN68avZXqwsGp5sb+x7eIxtCJWXWdLP/QbGD9LTOHkus=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ncBFBPOI
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="ncBFBPOI"; 
 dkim-atps=neutral
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

Hi Hüseyin, Johan,

On 7/22/26 12:56 AM, Boogie wrote:
> [You don't often get email from boogiepop@gmx.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello Quentin
> 
> I had reported this bug to Johan so i can give detailed explanation.
> 
> The bug was really the lock of "&& nfc->selected_bank == 0" not existing
> for write_page_* variants.
> 
> When rockchip nfc was reading, it required bootblks to be a part of the
> first nand chip only with the condition "nfc->selected_bank == 0". But
> when writing it interpreted 'all' nand chips first boot_blks as boot 
> blocks.
> 

OK ECC strength mismatch between what's written and read.

> The practical problem. I had mentioned this in V1 and give more explicit
> details here.
> 
> I have 2 nand chips, and a partition (linux below) starts in nand chip 1
> (CS=0 in below) and ends in chip2 (CS=2 below). And i am using UBI on
> top of that mtd.
> 
> nand@0 {
>      reg = <0>, <2>;
>      label = "rk-nand-0";
>      nand-bus-width = <8>;
>      nand-ecc-mode = "hw";
>      nand-ecc-step-size = <1024>;
>      nand-ecc-strength = <40>;
>      nand-is-boot-medium;
>      rockchip,boot-blks = <8>;
>      rockchip,boot-ecc-strength = <24>;
> 
>      // block 14 - end
>      linux@1C00000 {
>          label = "linux";
>          reg = <0x0 0x1C00000 0x3 0xFE400000>;
>      };
> };
> 
> When i create the UBI volume the middle of this partition where the
> blocks are at 2nd chip block0-7, will be written in boot block strength
> [ECC:1024/24] but will be read with normal strength [ECC:1024/40].
> 
> This causes first UBI creation to be successful, and next scan to fail
> due to written strength is different that read.
> 
> You dont actually need to use UBI at all, any time you write those
> sectors, you wont be able to read them. A workaround it to mark them
> bad, but this is not nice, since the blocks are completely fine.
> 
> Rockchip NFC technically as minimum needs to know rockchip,boot-blks, &
> rockchip,boot-ecc-strength props only. Currently the checking condition
> is rockchip,boot-blks & applied affect is rockchip,boot-ecc-strength.
> 
> The bug is this is only applicable to first chip not all chips.
> 

"is only applied" I think you meant here instead? Or are you implying 
that you want chip 0 to have rockchip,boot-blks and 
rockchip,boot-ecc-strength applied to it, but NOT chip 2 even though 
they are listed in the same node?

> NAND_IS_BOOT_MEDIUM is actually coming from mainline linux. Similar
> bootrom tricks are also available in other socs. And detection of boot
> rom blocks is not always straight forward as rockchip's
> rockchip,boot-blks, they have to do some "if" case acrobatics to detect
> those. For simplicity reasons mainline linux introduced a global flag
> NAND_IS_BOOT_MEDIUM and it is applied to other socs as well.
> 

rockchip,boot-blks and rockchip,boot-ecc-strength properties explicitly 
require nand-is-boot-medium property to be set in order to be used 
(though they don't enforce it via YAML/JSON schema; although it is 
enforced by the kernel driver). So a device tree that doesn't follow 
those restrictions is deemed invalid and we are not aiming at supporting 
them. This means that the last sentence in Johan's commit log:

It is now the users responsibility to apply the device tree
property "nand-is-boot-medium" to only NAND chip 0.

is redundant, as we already expect the users to set it for the 
appropriate NAND chip(s). (just adding this piece of information here, 
not disputing anything either of you said)

> Since this "&& nfc->selected_bank == 0" fix is exactly at the same line
> with mainline changes of NAND_IS_BOOT_MEDIUM check, i think Johan also
> integrated both at the same line.
> 

@Johan, can you please reorder the condition in rk_nfc_write_page_hwecc 
and rk_nfc_read_page_hwecc to match the order in the Linux kernel 
driver? (the NAND_IS_BOOT_MEDIUM is last).

> In u-boot only mk808 is using nfc with boot blocks and it is already
> marking the nand device as boot medium, so the code change should not
> break existing devices.
> 

Correct.

> Additional note: Linux mainline also is lacking the "nfc->selected_bank
> == 0" check, so i think similar patch should got to linux as well.
> 

Not sure what you mean here as Johan removed both checks in the patch.

[...]

As far as I could tell, Johan's patch makes U-Boot behave the same as 
the Linux kernel for a multi-chip node, so with the reorder I asked 
above and a much more precise commit log providing the usecase and 
misbehavior, and also pointing at the Linux kernel doing the exact same 
thing as this patch, I think we're going in the right direction.

Cheers,
Quentin
