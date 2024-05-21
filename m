Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96840C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF736881AA;
	Tue, 21 May 2024 11:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QHggpTQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22780881BF; Tue, 21 May 2024 11:53:14 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB749881AA;
 Tue, 21 May 2024 11:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX7GMtZUAWx9Qvsi6UFwUV8phnM95LsXxAvCT9C3vwk142vYTlYDj6AFyB3QhrF+DoL6EK8TZw0efWeVAG+C6S+6HXK5HhFWZlzu3fI7nraMpR6fm37a21i5SV03dLNsh36dkPP3iuEfz9YkIOrIzr+qfpkhL3+U2IvMB6WvkEWM3Qy6mC+rBiT86VTgiO/ZCiELog8IQ1Gxzb1mutcvG9LKQvDCqlBR1DQk1v0i+b6xjTLhE4Jk+UI2BsUo+rVArEcDgD/RLUKZjkjpZZt/++9/Lq4LT0G72X5pNbPpZztzf6Yxyli+Fn5h1rgZbtA8h/nI1davcod51xF1+Ssl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzeg7oUzpxdfGzkvM14t5kGcY0PXQHEpYGH75uSnbo4=;
 b=MD3sqIf/vEMYNBfG93+C+gbNEE2gGCsxrBzcMy4QlNuriGe/duvroQVDuxCjz4SMeouMyxP4kKuln+nP5U03Gfr5X+KIwQ20f3EmwfC6wMZMWrBH4y1axLM0VYqrI8Cqrr42pW1HeUQpxneIudSZAoQf3fHDeyIV99DjXX6OlHmC/15ftiKR3FqeP9JUSN6LGhaJUmPeyKgQDFqF1zTynmFbFA05ZFGZrOTpDhbG9EpQJmbEfCl5i3nWoCbh/xCvtb5Wi/zur7AOx2p6JhYA2fzc6LZofWLPpMYiMc/PJmDB45N53IJR7r6xeYpqflfxTbLus2jLHSRVW/4tiRfsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzeg7oUzpxdfGzkvM14t5kGcY0PXQHEpYGH75uSnbo4=;
 b=QHggpTQHrgAdxAIYyYuVW9dK5w4Q6m/4fDcuZ9rxcjO+ALaPveZqbhPQ4Otx3dHyXqTAhDwnIepFoqN9pb/q5s4fprrkARdvWntxLo2KV1BHFHDylmtNJAbcbPd9YRjKeqy2ez3HEBx+Q7Qo1kw4TKjAg8HJDpb1nniXrtQl4M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 09:53:07 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:53:07 +0000
Message-ID: <7fc715fc-eb51-45a5-b7f2-71668bfd3eba@cherry.de>
Date: Tue, 21 May 2024 11:53:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2024.07-rc3 released
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20240520160635.GQ2568172@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240520160635.GQ2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|GVXPR04MB9949:EE_
X-MS-Office365-Filtering-Correlation-Id: 631674da-bfec-4861-af09-08dc797bcd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFU2alBKbEdJMGtlSzdLU3daZ0cxa0o3LzJGN1kvaVZKREJaY1BTRW1USlFF?=
 =?utf-8?B?S2NyTXpYT1YxdGpnZTJGZHBVL1UrUTMycll5VjdNRlJhdUliZzN6c3VwUHg5?=
 =?utf-8?B?Q0pwanJtUS8vRDRVRWJpaTdhRmVxUXN1Y1JQSytMSWRqSEVhY1ViSHVKUExa?=
 =?utf-8?B?QzFTVkZ3L28vdmpaL2JkVmlEWDE3eWhhcEdKUFpWOVVNVHZOcDA5SnQzRGQ0?=
 =?utf-8?B?TUttbzR1VzREcThpeStrOWZ5b3Y3c2RGQloyN3BPWXlERCtPWUNnZHJCREFy?=
 =?utf-8?B?c1VBSzE5c0swVGIwb0ovYjAyMUlmRVFLdWFueU9kMkR0akY1RENHbGkrK2Ry?=
 =?utf-8?B?RlNEbEw0aHRhdFBaVGpzbDh1NjZTRjFDMnZvRURWbkMzMFJLMkVkcFZ5eUdF?=
 =?utf-8?B?ZG92bUdjN2MzKzkxcnRjSUZBbHhnOG1kWUpCc214Y1FCa0ZxanNBQTdsRktk?=
 =?utf-8?B?TUZUSGZmc3BDNFo3Z090d0lFME1KeVIvV09OVG9CVldiYkQzaEc3TWM4eGlQ?=
 =?utf-8?B?blhJMDVqVE93T1FRUkJ0MmtRL3JkWWRKeUlrRmhXc1NuZWxzeXk1S0pVR0ZK?=
 =?utf-8?B?SHdORlFTU2dsWWVucUllZ0pucVA1bmFua3BwcTk0a2IzTll4QVBJZWRHNE8y?=
 =?utf-8?B?N1VEU245OTlFODN1RU9nQUZwQW55eHJuSWpwVDVJM210WXFOM0RuOXB1eENh?=
 =?utf-8?B?KzlHVHBlQzZkUXpydmY3WW4vdDA4L1VrTk1BV0FBdnJmSWhFamxmZmhSeDhP?=
 =?utf-8?B?UnRtMWJVZDRWcTVnazd2eE9kUGNZbTU1KzR1ZkdYMytUS25uaVdMYWVMZFFu?=
 =?utf-8?B?c0ZZblZBbzl1eS9TZFM4Wmd3bkxzclRpdXMrU3B0NnJGRWtleXVEL01hdHdr?=
 =?utf-8?B?R21walhsQ2N6SXcvTWJETktTY3h2QW8vWTBZQTdqeDNZUnZXSXJZUGphOS9t?=
 =?utf-8?B?T3pmblFSOGdsR2NMNGVyWVlJUVRPVk9zZTVRd0NacDg0SksxUWUvU1FqazVr?=
 =?utf-8?B?OFRpL0FFVXB1bGtlTG5KMkYxMnE3Y3dsVk45OTRYbVdwRUNJOG4zZDZaRUhm?=
 =?utf-8?B?KzhCN0NiOGRxVXQva0dGREY2L0lHVDIwWHJPNzhzbkNLS3g1YVB0Wmc5cnBS?=
 =?utf-8?B?UlVWUDRJUzlLMVEvS29WUXRDbGtka1JUMTBhek0xN0c3Nm1kdlQrQk0wWmZ3?=
 =?utf-8?B?aFJnNjM1UmVla3kwMStoR3k2VjMvTXAvdWhHaXhEcEgrVHRXd25UMTltOEl5?=
 =?utf-8?B?b0tUbWZPRStqKzd4VEV6Ti9TTWNBVTVkb3V3NUNCNlh6TTJEaXdNMTNmT2hF?=
 =?utf-8?B?aWtzV2t4LzRISTV1d3JBT1dYdDMyZjBhRDFYb0pBMVhMQ2VUeDQ1amU3NXVw?=
 =?utf-8?B?dnJPVGJDcmJGRzZJZUdPNVFCdGVUNGNhMTRZSUlRd1NtRWdYcUZ1Qm42d2FF?=
 =?utf-8?B?TjhWYm5nKytna25qWEZ0Y0x6UUxYUWRTbU4ybWtHckRCdE8vdmxKMkVqR1Za?=
 =?utf-8?B?QjU4NXJ6YnVsdmttQlMwWjhGbEVKM0xQVk96bTNYMHJaK3BLWU5sZFNVTDFp?=
 =?utf-8?B?dWU3b0YyWG1pb04yVUsyVTNFRVF4N3BFTUU0RXFWcEJndGs4Qys5WE91Qlhs?=
 =?utf-8?Q?Ee5EOT/yzPip6xiYawzghcntekw+PSEM0Dm1W1TFQ/pQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRVL0ZrNlFySzlHZzVERXVEV0p4ejhPZ1M2RnlqZ213ZlllL0RSR0dkeVla?=
 =?utf-8?B?Q0Z5WFdOdG1Ib3VSWDdoYThTYU9DTUdjTDNSditaVnVkZVMzTVM1L1p2V0pa?=
 =?utf-8?B?dTZaRnIrTVc2Nmk2M2JjUXFDUGV3R0lhWHRtQ3licUs3eTNkT0FHdElweUY0?=
 =?utf-8?B?MXRYczQxSWo0WE5HcTRtM0ZXQlJHSHJkWk4wSjhwcXY1dWR3SVM3TmNGcDFI?=
 =?utf-8?B?ZUJJTGllaitCTFVmQ2lCWk1nM0JCK283ZlVRbHFKZjFseFg0NFpBTFBLaFRN?=
 =?utf-8?B?QmlaKzJIaC8wYjVPTFFFTXU3OHNpZHdGVXdZYi8zc1NPRVZzbUV5eHA5MWVl?=
 =?utf-8?B?MmZhR0JjakNxWHFPOUIwMTVBUm9Mb0lrTURNbm5yZlNHeTFqdGxDTndwL25J?=
 =?utf-8?B?RU9lUFJWQXh4U2E1bnd5WG10bUxWTjBMS28yMU5VeWo4T3JZU3A0Z2lJTVlV?=
 =?utf-8?B?TUdHZkI3RURiNy80emxhSnRKVzF0QUNNQlVkOXVaZXR4elZSMDhoWUpXaytp?=
 =?utf-8?B?elRLT0ltRXJLemYxOCtWdXpsQi9WVmo0NUVkVmttbzVHbjRQbEVKREJaVTNl?=
 =?utf-8?B?OUhHN0dEeS9DcnNwVDNUdFVOTUxrdURSb0gxeW15ZTArREFYczdWYzcrQ1VG?=
 =?utf-8?B?bGt3aUZSa1pqQzlUa0NUSklEdmtIMUJuajVNYTc5S1lNMDNoN2ZRMmRLR3pz?=
 =?utf-8?B?U1hLQmZVYXpaM0pjeERZbVI3M3FXT0JlVzRQUjl1b1gxd251VmdYYWl1aWJi?=
 =?utf-8?B?bzA0amhqbmR4SWJHTUxHbHNmUk4ybnJOTmNQK0NRSUtEMnRocWc1SU1hS1ZI?=
 =?utf-8?B?MWZobnVIZXNYSFJycCtlTWd0emp1Wi9LclFxNUZjbmtuSk12aUI2UGJBK0s2?=
 =?utf-8?B?N1RZWm5KNkZGdHFaTGpxUXRhVFRvWFFiR1hTMFlBUi8xb29CZWRST1hyeTB3?=
 =?utf-8?B?aGxoZzBWQVlOaUYzdG1ObjhOaE1sbTdaU2hhb0kyeUx0MEtrckJGRzROcENu?=
 =?utf-8?B?UkdadmtJY1VFUUcxTmZXYjB5YnNUaWg5YUN5cHh4RUN1ck1CMVpxdGpxSWpH?=
 =?utf-8?B?QXZwMTluVW91MmNxcjVZUUdaU1V2cmIzL21KOGhTQkV6NTMvTE9Sb0N4bXl1?=
 =?utf-8?B?bzA1MXN4aTdxRnVwQmwwSHQ2OC9YU2VMT0tQQ3JyaEJpRy9GMHFLbm9rUzhu?=
 =?utf-8?B?NDVUd1JRQyt2a0ZvNk9oQjYyait1OVNKZ2p6b3BsaTJPYlF0MWViK01aWStm?=
 =?utf-8?B?c2pCeEp6K1Y4clBBQ1NsdFNNdVNsdkh4Rm1uRzJYQXhTcm1aNE1WcWdOYkNT?=
 =?utf-8?B?VnZjRjIyUWFzeEtFaWQzc3diWWNJWEtWZ1p1ZFdlNEhaelBtbTI2QzR0b0JJ?=
 =?utf-8?B?Mk9NOENRUnhJZ3kvZ0pUem4vR0RxcmJRbk1HVzFCbkkzVW55dHJDd1V2cDM2?=
 =?utf-8?B?OEkxcm56OGh5VFZDZWs0aVkzYUduVUlXOHhRRFNILy83clBsZ3FJU2J0cW9v?=
 =?utf-8?B?eTF6VjdncllmeUpkdHVEOENmTStmR1VLVXhuVUI0akVVbHY2NjZBZm9seDJ4?=
 =?utf-8?B?QnVUYnlKRnBDSEZTY2xGUXF0RXRMaGtrMURUYnlLcmpCV3QxalgxenVmOGR5?=
 =?utf-8?B?YURWd293K0pGOHMzbmdKUjVsMWxZMFBWSlRGSll6OCsyOVBRVzF1SlhTajl3?=
 =?utf-8?B?aUVQREJFV25VaWQzdjRKOCtOYVJmZ2JsRUV6S2hlaHZnSEcxUzFRWmc4dzdK?=
 =?utf-8?B?YjczSDB4eFk1bXdNYkQrUStkNUpheDNnYWJwd0lieWNSLzZJUkNvNFVmbUZN?=
 =?utf-8?B?MllYcjhTREI4MXByc0NQWU9rQXVjTEt2TXBLbGovanFZL1E5bG14RlZQeUt1?=
 =?utf-8?B?SFdpdEtjSStpRlAvMzdvYkwwalBCdXBMNGZ6N2EzU0d6VTE3VVk1U0dGVzN2?=
 =?utf-8?B?NC9mcGpGQzY1RHpaS2FnVnJtUTUzQ2o4YWwwM3NjVG9jQmRHdWt2TjlQOGc4?=
 =?utf-8?B?cVBETmpDN2FzZWJWK0JKUVIvTDV6ZDlSSGhwV0dBOHV1UnoyS2lSN2FjYUFH?=
 =?utf-8?B?dlhrRTJxVHg2T2FFQlgrcDY1NUtyUm4wQ0RjYVJnTkdtcHZ3YXFEQ0wwdmt4?=
 =?utf-8?B?Z3dKQzVMMlRYU1FVbXBzSGNLL2k1VWJxL21DR0xmM0R4cTlhLzBCbE1FM0ZC?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 631674da-bfec-4861-af09-08dc797bcd79
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:53:07.6704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbYlJERVqIgO9ukAnA3lQiaLRh3awlaJR2hvIGQ7GYX9CDjB4mtAEFW3qNsGbhgVaHimF2y7PzDDiN9oKHzM247CM2rq1kvITtgnKNXi5Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949
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

Hi all,

On 5/20/24 6:06 PM, Tom Rini wrote:
> Hey all,
> 
> It's release day and here is -rc3. At this point, I think we're firmly
> on "bug fix and documentation" ground moving forward for changes to
> v2024.07 and the next branch is open and ready for use and pull
> requests.
> 
> In terms of a changelog,
> git log --merges v2024.07-rc2..v2024.07-rc3
> contains what I've pulled but as always, better PR messages and tags
> will provide better results here.
> 
> I hope to remain on schedule and that means the rest of the rcs every
> other Monday, and with final release on Monday, July 1st, 2024. Thanks
> all!
> 

Just to let you know that Rockchip PX30 support is broken since 
https://source.denx.de/u-boot/u-boot/-/commit/1d01440b3f14f6648cd672da619489f635cb209c 
(at the very least on Ringneck, haven't tested on PX30 Mini-EVB yet).

U-Boot proper pre-reloc seems to be running out of memory and we cannot 
reach U-Boot CLI anymore.

I hope I'll have time to look into this before v2024.07 is released but 
cannot promise anything.

Cheers,
Quentin
