Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95557C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 15:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C1E81F0D;
	Fri,  6 Jun 2025 17:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Qx77XDeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930F481FEE; Fri,  6 Jun 2025 17:08:44 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15BF7800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 17:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwOH40dXjkqP+fQa+WbBeiQcrE2GDlGugc0lO1r3rphBDIfn7b/gtcz4AXlSGvaT9IA2J2wgWKFteEjEukcK3f++OBBrOG/eQ966NOB/iMXUSM3J8j2ABuCQjfcZchHEikFcA+D1owujt5Xq4CFCOaidjpv3UDqU2mBGbSOlSTiYZhfESgUotwyyTm4pwR17ZfEbSYLcbTYc1TpC7gYntnmlrtiF3+LFvF+ifhwvW2FPPNWGb6Mr7qSqOIquJslj8AmNRWrreCALVcGCrJB+OKYGpazw3fK6Wvxcnvm0RSswMUfSVu3u6dGmJTtOHXu7uqD57GK7f93EoCCXv1K7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtiM5J4475RlJkizW8DKPC9/aNhJenEnLEWKU7l+uI8=;
 b=Ztem2VnuZFlLpLOE/y3KB/ktzCoqJoo4zvdB8FoHGVAspPFtXQSOhzdUuvP6dVHmeYL4ON+S8I6/EsMuj8z4Lyo3hhVCfu6WCNSpOr7kgl6NeJ9CTXYCtA5mwTuwX/+qj5/P5suuJgg/BJwGrVLCWsGcszX74WBggOwHt+KQp7Za4luPXDjtqIxm3UlLMuiWiyxDpn5qL8xm4rJur+dIzMbkE6kO8ldfqBxumaSvehJPj48mfl56h5uNHFNUyUe5Xg3Tok8kHnu2jJrC55mHRe6Zx9EPNKeU9sZbvoeoTtHsonfn+wLqPVDbErUgzCSj/g7SLl00GMZ34hyi1vGLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtiM5J4475RlJkizW8DKPC9/aNhJenEnLEWKU7l+uI8=;
 b=Qx77XDeMcqPN/Uz0f5skGH1BmFGvneGsF1ZOfdXPjdqfRB2+Kct7BHDRbdI8q9qmjLcjPy0CGbR0wzeFAbeJ7dUDvImHmGg9X2vJOeHJsqhmQO3SmmegxiQJQDqGo0igJsf6Ps9kkMHAUfF8zktBP/pxIJbzayQYBTppWWKAxDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 15:08:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 15:08:40 +0000
Message-ID: <7633d939-172a-4854-b200-0b7b4418d820@cherry.de>
Date: Fri, 6 Jun 2025 17:08:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] linux/bitfield.h: sync <linux/bitfield.h> from
 Linux 6.15 + winbond
To: Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250606072140.18824-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a643ae-1d98-4066-c105-08dda50c04f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUZKWkNEYjlpKzhlUlVOempXRjVoNkw1eUhvODlGVENxYmJuQ1V3UGtWREVx?=
 =?utf-8?B?YmZ6ekV2azN2c1RMcTR2dnBUc2IyWVpjd09RWGRhdURuTW1abnF3enB1Y29p?=
 =?utf-8?B?QWlHMWV5LzU4VmsxMitqNkhKRzNCNFNnVVRvTXlyUmY1UVZmYVkybDVCR0lC?=
 =?utf-8?B?T09Ua1hORlNFem5VNUNpN2Z6Y3Z6VWlUSHFrWFZOdndNc0Y2T1FaQk9sb1hv?=
 =?utf-8?B?UnV5NnFlWXFzM2NwaEFYazhacUc0cjFCclNMVE1mTXpxckVQc3lZVEU1M1hx?=
 =?utf-8?B?RS9oTm9oa3N1S2xqMnFNaGp5L21Xbk5iK21rdU42dmtRVWdMUm1mNEMyc2Z4?=
 =?utf-8?B?R2hvQ09ndm9LckxZTU40cEFKb3I5SlNHQ0t5c3FQRlpVdTNlMVhIbTBrNzlp?=
 =?utf-8?B?akVSNERkM3IyUzIyazRCK0lySk5TVktjQ0pLektaS3RMSEJwWE1hS2hnZWZS?=
 =?utf-8?B?SFNDMjhSTFlXMi9KZEpzUVkrQ1g0cHFzeDdiZnA4ZUtkWGVncmFOVDlMa3ZJ?=
 =?utf-8?B?aGFTTjNQVWNxSUcrUG5KMmRpYWRVMDR4cXIwcUZ6TGZYVkN1azcvS2NKeXJy?=
 =?utf-8?B?enZzeGtVbjh2NE9zTFQzN3pEcHdjYWR4czBib0liNVNJUmNSalpDcDNBaFBI?=
 =?utf-8?B?QzM2OCtJVkFwaTl4VU91MnpwMnphRUxMMG5VTHZZSEFCb2Q3RGhMZzljVzRH?=
 =?utf-8?B?blhXUkRndko0QmUwRjAzSTBHWDhhRXlsTHNCVEFhMDlvSTNwNnpQMWJGdTM1?=
 =?utf-8?B?djVzTDVud0Z5cDhrOXdTZ1l5d21tVFlPcXVXVlNrRjRPVENxT0QrUVA3Rmta?=
 =?utf-8?B?dmZoSGRJcTFXUzNKWHZyMFQ0OUpnVjdFaXJ4Y2pKVkQ2NmdNdzV3VXU2aSsx?=
 =?utf-8?B?d2gvblF5NnE5MkhPeHVNUlRkMjYzbHNud0prMFpZVjVTSWZZT1BoSkRoUU5F?=
 =?utf-8?B?ZlB0TjBSVWRzdzY0WXJDeXJmK2x2NjdaRVJEL1M1ZHVlZmZJOG80RnkvQS9v?=
 =?utf-8?B?VEcvT1hDSXI2RE5iVFp2aEcwUnhad2NhQ0IzQ1p4dmY0VXBaQXk3UFJoT3Av?=
 =?utf-8?B?V1F6NTZlb1BGczZ5VzJVTGZ0aGc4czBaaXk2MHJSd0lubGpRV3VJcVh5djkz?=
 =?utf-8?B?SUlkOG1RVkRsZ2t0dDhic2owOHhnWllwRW5XYUhIbDh5ZEJKTGlYdUxsUnVv?=
 =?utf-8?B?bXIyVnBpRlM2MUg3STJNcXREZ1JzdVg2R3dXdk40MXYvdkc1THRyUmZpL3lU?=
 =?utf-8?B?YldXMmtKbjlTWWcyZ0NyNEFpVERmNGFGUGZpVHRkTHQrbnZmQTBCT2RJRlNJ?=
 =?utf-8?B?MmRYQWZpZzdBYldLRk1oejJSODZaaTZJRWlrZlZQVlJyOWw4RkdHaDVXb1hs?=
 =?utf-8?B?Y0dRdnd2N0x5ZXlSWmVlTUUvdG5MN1pQMHFSbnVyYVYwYlpacTE2SVJtcHNP?=
 =?utf-8?B?bXVrQW1zdGhST0Q1N0NQQWNMQjlJWGsrcEJSWUFybjlGYTlvYmZsdnA5RVNC?=
 =?utf-8?B?dC9OaWtDeFRYMytzUHhtRTl2cEdUcVNpVHBSLzRFU1RzblNURzE0MzNGc3Fp?=
 =?utf-8?B?OStoZk5ObFhnNWpCM1ZyWFFudExhSi80U1d1SjU0ZTcxQit4ZEQzejlTeWsz?=
 =?utf-8?B?SFdWTk1nTWNsZ082Sk5NaUdlOVJqNFZOZkZoQVcyQkhLTlhPTmRVVy9oWjVK?=
 =?utf-8?B?N2szejRuakZXeFlORTVDZWw5Z0VrZ0cxTkVTRXErbmszSUhmWURnUHhPWEJs?=
 =?utf-8?B?SldtWW5KOE5pTjhDaDFrYlBBYlF3V0VDeDNUT0x6MENqTlBHRmQwYlV5SjVy?=
 =?utf-8?B?WVdQMVBlTlBWWjN2M1Zzb1VHY1FpR3FNcHhvYnNIc2pUN3cwQzd1VlFNcW56?=
 =?utf-8?B?YkpWTkcyZndiRXpVTnRxeFBGdUQzcnRCSlhGa3BZanUvTC9VdDJaSTgyQlBr?=
 =?utf-8?B?aWVxVFBpR1JMa2tNd1RoWkhHdmJ3citvN2s4Wmg3NXR0Y24ybXRoUTJySGlC?=
 =?utf-8?B?YkJFc24yYWlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDc5bkxKNEZvYmRaUDZ6ek03bHpPMERhYmc3RVRXYjhNOWJUYmlJeUhtbmxL?=
 =?utf-8?B?NWhYbkRXQTVwdVEzS0ZLdHNCc1FFUytiRXpQMEJ4eGtVT3NxM29JdFhRZWFE?=
 =?utf-8?B?aFJRUFFvb1FWSTBUMG5EVGVDNUMxc2cxajl5bjJMazdoYzZrMi9xaGFkbzFG?=
 =?utf-8?B?K0JWdVRRMjY5dUFDS1hRNVB2Qnc2QU1RK1VLOHdnMENVQWpEdjBRVlhOUVFs?=
 =?utf-8?B?Qkh4M2hVWE0rUmFUUHVkL2t0M09qZnBOOFVSV2FDb0JkRDZRalAwSVlhN1p2?=
 =?utf-8?B?NXp2Z3BwcnhPRGo2L0NUWldYMVpuQVAzcTNDVTNhaVo4Zk44TFY1MWIvWHBp?=
 =?utf-8?B?ckY0RTgvdjBuaWFOYkl4WTB5MDFubVRoNC9BUW80Nk1UdndYb1BhWnF6S29K?=
 =?utf-8?B?Mjd0UFJjaVFuM2xMRjhCTTZ1N2xSSyt0RmxLS0VnM0hHanZlU1Rod3RuNVJU?=
 =?utf-8?B?RC9LVm5VR1lUL0UwMGRsdkZBc0hUM0F1RURZcUlzdWlNL2k4QXZrZnN0eVlO?=
 =?utf-8?B?ZkFjU1ltenp4SVJTdVlzandVRnorMmFhdlYzajZwelhFZmdmd0dXNlhpRFlx?=
 =?utf-8?B?V0NQUTZjaG5OUXVaYnRzeWM3UndMU1E4ZWNpNkxiT0x3WnA0QThSRTBYcm1C?=
 =?utf-8?B?RU44TGdib2p4SWZpRWZlWGM0ZFEvL09MSFkrQ2h5aW5kUUJvVkQyaTFCcVZO?=
 =?utf-8?B?d09LS21lRWJCRkhSR2xBTUsvVEE4czFhMEt0UjFsdTJFZFgzTW44TGtieW0r?=
 =?utf-8?B?dXRQL3dnaXR1aC9YL2Jyd1pFQWEzbkVEVDJQTGQzV09IVFRWTndSVDZNdE1K?=
 =?utf-8?B?dGowTk1KQzdPSDdtMjZqWFRidWFjWlMwdXBudGwrcU1HWm1Vb1BzOUhxQ3VK?=
 =?utf-8?B?aWhaaXNoNkYvbmpMdnZ1Ylp6V3BkR1BPWHo0OCtKYWxSSkhybUM0elZ0M09q?=
 =?utf-8?B?MFRqNUV4K0tjd090bVV0dlZVT01SdVJLOWtjdklZYXlaeUFUMkFpVjNYMm5K?=
 =?utf-8?B?ODEzUUdYZm91MUFBYUZQZjh4ekgxcGxoRGR5MXp0ZUhMUlQ2VW1XREpxUVJT?=
 =?utf-8?B?UUVDQnNTN0hJK01UWGVudGFkU0sxbzAwS0hna25aUnptbStEU0tPRlZ1QXpx?=
 =?utf-8?B?OEJMdG15ZmFieDNjdSt5MThZeHAzaFpabXNNcnhQelh0NzJ5bmlGWUNXeVhQ?=
 =?utf-8?B?d0dSSEVtZjUyWTJxMDdFc0xBMnhHWWh6aGVkRmU3TnhzMGZ3YmIxZHZqTStD?=
 =?utf-8?B?RlJURExCdVViUGIrZEhOR1hDRUUvMVJMS1F5aTRrM2g5RGJnM1ZWd1ZsQ3RW?=
 =?utf-8?B?YmRsMWdqQUU4WDRkTGU1eE1WQldVVGpTWC9ZbU9BRkMzOTNQWkFxR3cvQ3BQ?=
 =?utf-8?B?SnJVc3R0aGVHOHVXOERSaFA5b0d6K1hnRzZKWVV4dzVtem1DRUY4K2xkeExX?=
 =?utf-8?B?a0ptcGdlRDVmclVkVSsrRFV3UDVkRFNBaGRxRVRsRSs3eFg4SjNMSGhEWEp5?=
 =?utf-8?B?bnpRRC9jMVlEdExLV2FLOEhQRkxLNnFzT05oRjB5RnZ2bDFLVUtUM2FKaTd5?=
 =?utf-8?B?OEhWenlBWWJ5Smx2bllVQlBUd2dHSEgvczk0cHBveFA3Vy9hVkczbDNCS2NR?=
 =?utf-8?B?SWg2N0FjU2MzeGQvVE80YnhvVWRpVG9NdmJxMXQ3WU04MEFpS1J2aFN3TWkx?=
 =?utf-8?B?UVJzTDRPU2ZUQ2dxdWZBSTlpMXVUTWVuTmJmY09pS0QvZHlacldnanA0Vktq?=
 =?utf-8?B?aWdQdkdSd1c5RnQ3K1EwVTdwL3dXUXR4eXJudmVJaGk0eTVnOEE3cStBREk1?=
 =?utf-8?B?Znl4QlVqRjNpbG54U2N2Q0FvUHlnRlJZY0dONWZNSXBlUm1HSGp4QVQ3YkpY?=
 =?utf-8?B?Rk9iUnBKMTBCS21HdzhaUExpbmhnT1orZEdkcG9naFprYWVuYmJTeU5vV25W?=
 =?utf-8?B?aTNmWXFteUp5N1NWaXQ0NXArVVNPaXVnTy9FZWZVOW1wL01ORHp2VCtPcU52?=
 =?utf-8?B?NEZPU0p6WTR1bnUzaTRObGpUUGpjd1hQcW1rMVpTblp6YmxBSXZoU2xZNVdi?=
 =?utf-8?B?L0FBZUVrc1hBaFlVUDVVK3BWVDJRTHVnak1qcjQzcmk4N3VRWmU0Z0N5Smdn?=
 =?utf-8?B?bWN5bXZMWDduMEVyeEhtMmZKVmJJTXFoaEZNZmFhaWdqemRmWlMyMzZEdkpO?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a643ae-1d98-4066-c105-08dda50c04f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:08:39.9598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfUCyEJaAZhSemnEShcM53WRA+aXoj2u73CzgDtToSaP9Mu2gDlvqTRm4lCiAkN6oiJYNYdYmjdCYyfgCQ2hfEb2Wcqv22Kkh5xrPd0/GQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
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

Hi Christian,

On 6/6/25 9:21 AM, Christian Marangi wrote:
> This small series sync linux/bitfield.h from Linux 6.15 and fix all
> the compilation error due to a change in the header include.
> 
> The sync is needed to make it easier to support the winbond changes.
> 
> The changes are CI test with [1]
> 
> [1] https://github.com/u-boot/u-boot/pull/777
> 
> Changes v3:
> - Fix compilation error for remaining drivers
> Changes v2:
> - Copy the full file instead of cherry-pick Changes
> 
> Christian Marangi (5):
>    linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15
>    clk: imx: add missing linux/bug.h header for WARN
>    iommu: qcom-smmu: add missing linux/bug.h header for WARN_ON
>    arm: apple: rtkit: add missing header linux/bug.h and linux/bitops.h

We are generally aiming for bisectability, so we should avoid having 
commits that are broken. Therefore, patches 2 and 3 should be before the 
bitfield sync (patch 1). Because they will "fix" a "bug" that will never 
happen, their commit log should explain why we are doing this change: in 
anticipation of the sync commit that will remove the dependency on bug.h 
for build_bug.h.

Cheers,
Quentin
