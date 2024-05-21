Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90ECC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 12:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE7888722;
	Tue, 21 May 2024 14:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nwSVSJ6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 482668874D; Tue, 21 May 2024 14:16:32 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0700.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA4B8871D;
 Tue, 21 May 2024 14:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lihkq8hJ52Es8w7hmhEOIuCPYaYWuLtWV3OXFpl87Ry144qi/Gzm/PdzhoS/zDkYPwm6bQvNLeEQbt8NVcxjNvdxCWv7IoVdQFtvNmRxrkHOMv62SZ8G2FD7nxZv7gmXeif8DR2YLG0zuNdM3kbidsHmCaMraewz6858rHFMF3+rxEQcw/Hu6IBrUa6uSPO1tG2Isf4JEfIr8puaQ32YtwNRaM8Yl5wfMu88avpG8Cli/3GiKJF6MpTIcZXfrxbZMWcef6VLA4qHM8Jy4+tw4rMexhCLsu6OuK8+pOY/rvn4+zUy7mJhE1VM3/AL88WibIJzMASK8Xtghc1eCBUR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LldQ64Sp3Hn0MRXEZmTAgQsA6zEp5oKJ8wwD95wFtjM=;
 b=HyccrmlIW6z2roc0RkEvV8veQTOYOPP8wVRg4Y6vAThntVP6oDpzT+EkmSbDxtUcTbV9fGVcZj8gxhq9HEyIR/HyWZRNmnS2OTng4V7H3M9q5jRH5Wm+Zjj+xNfasiWqcsKlI1AdInbHlZVaR/YBq0DDKfLvkFF2d8r1xmXfHtP0M7sAfYp3vnllMpM7zDO6GlMVf95S0kC8rzc4t+n3C/6CVYbVB/HkSqfBKdG86sD3jSfDt7ZMxsWC1sEVk70oVL75aW9d6+fosgc79tl8yGCOBDsO21RFOQUPyByd8wRymkr7sHA4n06ckEBce7L+3KGC1WU2j6j3DnHPjxrB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LldQ64Sp3Hn0MRXEZmTAgQsA6zEp5oKJ8wwD95wFtjM=;
 b=nwSVSJ6FTXGjNcaBwG8wj+93xU30qY1Ki8D7s+JBD/+ImvaMNMOHJlUdQMEmyQpv0XXEGeVQcUKwX45+7qwrdAEqaIBoPtZeVDxTyoKUucxoWK32LEEghM8k2hcErzOH+HBwOeRZK6OAbRLITN/pJJGLLL0elzWBkEgms9rgpV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 12:16:28 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 12:16:28 +0000
Message-ID: <770c99e9-a5f0-42a9-9904-25978268bcc4@cherry.de>
Date: Tue, 21 May 2024 14:16:25 +0200
User-Agent: Mozilla Thunderbird
From: quentin.schulz@cherry.de
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2024.07-rc3 released
References: <20240520160635.GQ2568172@bill-the-cat>
 <7fc715fc-eb51-45a5-b7f2-71668bfd3eba@cherry.de>
 <6e7ab24f-1c01-426b-a57f-85f836a13171@kwiboo.se>
In-Reply-To: <6e7ab24f-1c01-426b-a57f-85f836a13171@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB9PR04MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fb3bba-97ca-4129-eebf-08dc798fd6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDMvUko2YjdHdVdYcUZFdi9nK0NpOFdwbXY4d0M4b2JWWHN5STJXK05wMWtj?=
 =?utf-8?B?RVJlYWxhTStxOUZ4V0ZNWTROR28weThXRjQzVG5JeEt4N09TQ1ZPdHdCNXE3?=
 =?utf-8?B?V2FLcjV6ZkJJYUxrZFVlSzBUNmZ5TGRXeUlHVVJYZGxvckhIN0MyT09PUU5u?=
 =?utf-8?B?a2doQWM3YWZYY3pJa3o3eWpJTFdhVUFXNWVXVW1qbmpGTTYyRVN1L3hDSkV1?=
 =?utf-8?B?Q1Z3VytGWnd5am9RSCtFOEdrbTd4TVJxZGJGNjFzMW9nSitncHJjajFPR1c0?=
 =?utf-8?B?L2o2a2lpT2Nhdm5OejdCaHNHSkYrekpVWEp4VHppS1NuWkVKMWVPclNlSVRF?=
 =?utf-8?B?OEhaN01TZ1ptWHErU3hvRlZ4ZkxPbnpzQXNEdnZDSWYwN2UrU3BPN25TU1JS?=
 =?utf-8?B?Y3gzaStqSXluaTlEZjJKbjVUR0lJa1dMZFpxMVRaRVA2UUZTcGw1VW9raWlH?=
 =?utf-8?B?azZlbDV3YU40WlV5NjZYK2RYUzJXMTJIdjhtSWVaOHJHNkxTR1F2MXc2TlZC?=
 =?utf-8?B?cFlnTlp1K1hmdVBVNElsT1JzbFkrc0ZkcDM5cjhSMHhXOHJjcHl1cTdNcDFs?=
 =?utf-8?B?V0doWUdPUjVpaVUvV2JwdVUrWFhTSVhCZWZwZGVyYVZpNnVRQ0xLWDZ1L3hu?=
 =?utf-8?B?N0VjR2pjTVlvd2hPTmpWQThXRitxMThoUXY1T3N2d1FmVlVkOUxNcEdKOXdy?=
 =?utf-8?B?YWwzYWw0QW1KWWt3eGNFVWVtU0o5QmRvbDJGQzI5Yi9LbXdaQmpQNlJycXcy?=
 =?utf-8?B?NTAvM1gwaG1UeHZTZnhuTVhNbys0V0NIb1NpSmF3YTNvSEJPdHFzOXlNRDJS?=
 =?utf-8?B?NVFtalVwTnUxSUZycjVoQjAwdDRHelF4bStlTlBTbnVpRDU0Ykc0SUZ1U1NP?=
 =?utf-8?B?WXdCTGJQS2lPNWNtdXpOWW95S0Y3YjFhM3VkZG13L2NIeGZnQ2JpUG16VDM3?=
 =?utf-8?B?Tk9qblpzZ3VDU2xBVUlOeDEzM3JLOWFJVXYxVVNmc2ViUWlaMEZMZE5pcFJz?=
 =?utf-8?B?bUkvNisvWlkveUxHRXpFZm92aE15WCtXYXplTmZGNEJTTHZWbmRUbW0xQ01j?=
 =?utf-8?B?YzhhaGZIYWozQ2xqTkFGODV6SG5QaS90U1kvTURlcit5NnJiUlRoOUFObGNy?=
 =?utf-8?B?dWwwT1FWQWtQMkhlRDMvSnVtRkRlTEFTSGJTVlhUL0l2K2FJM2cvMFFycG0v?=
 =?utf-8?B?LzlPSURwdEdUVzhGeUNPK1NwM2pxZWNBbndLRDAwcmJlN2xSTklCbEdtc3Ru?=
 =?utf-8?B?cFcwWVNYeFY1VU5hTTN4akZ3c2h6cGxaR1FiYnZCNTVCVzQ5akcrYklYRmx0?=
 =?utf-8?B?bXVsNVlVNnFIUU1SVnBDbXR1cE1VSkFjaFdjMTlyMHJra0I4YUZsRzI3aW52?=
 =?utf-8?B?ZVRnclA2NjJtUDl3a2NlYnVLWURXenRsYm9Zcm5pV3Bod0VjbkNUSUU4Y1Uy?=
 =?utf-8?B?Y05qTGRNMVI3c2pWM0FDMTd5OTRHSitVUVF6c2lhdlM0ZjdseERaWjdpWjNu?=
 =?utf-8?B?dytPemV0azJPanBpcSt0eW9Vd0Vrb1E0blNZNWdONEZtaVgxRUNZYVJORzYy?=
 =?utf-8?B?WlhtVDRZeEVMUStuZUt4ZVBaWXRjQlRBN0xrZXpURjI5RmJUUC9SaExpNjl1?=
 =?utf-8?B?U29nWEZPOVB2ZXB1ZjNCdzdqZ1NQOEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVgxNTZRTCtLdDJMVmN2bnMvUCtiODg3cGoyVXNEZFFzZmJKelBRNDF5ajRx?=
 =?utf-8?B?RVdHa1BtMmVFdW9kTlJJSWRlRTBUN3FWeEZuN0t3bTRDUFdvc2hjZzhJbGQ4?=
 =?utf-8?B?RUVCMHpBQWtoSXFKcjExaWo0bFA1ZGltRzBaSEgrOVFiK2Z6NTBiTGlNaE9R?=
 =?utf-8?B?NU9uaTYvQ2s3OTY0Wi9OS2ZpVTFwWkRnNnNNam1uTU5yK0J4NkI3alhZSG80?=
 =?utf-8?B?dDFXaXJWU1B5UlhGaVJpTi9FbmRoaUJpWDgvR0RQT2Jvc1R2RzNTN1ltVjZH?=
 =?utf-8?B?VDNBOFk3Vk90WnJpQmxwZ1d3YmhidW1udEduaEs3MHpiZ3FIQkhDa0ZGb1J4?=
 =?utf-8?B?eXc4VXFiS0J3NWFDOXNmV3dGSkdaZlpkYlV5WlFPbjIwdklpVDdOWXgwK1hH?=
 =?utf-8?B?WnpmVnJPejh1cVU4MVhRYzRTbTVNQXhwaTlTQUJ4QmRsaHR2QzNZRk5QanZl?=
 =?utf-8?B?K21JdU12ay9reEZRWEZTZ1JQQUlIdEJHcy85YVZwVVVuUEhzRFZpNDRoQTJU?=
 =?utf-8?B?LzNuSkFlK2QwbkdqV2dtdkErMjZSU0d5N1oxcHA1YS9TeVQ5VmlaZUFGSXZl?=
 =?utf-8?B?SU1TWUpzdWV0QW9kK0FhWHM0ZDZTc0VaN2hoSFZPNXl5TzdIaGtCUlBvYTNV?=
 =?utf-8?B?bmJaWUxqNHdxVG1EUDI1czJxTFRac3lBYjhhdFFyak1sMXlKanM0Y2lldXYv?=
 =?utf-8?B?cWJ5bHhSS3pqbmNBa2NNUlk2STAzaTRTL1F6Z1hUaWd3UUgzWWwwQm9sanlq?=
 =?utf-8?B?TFljK09UQWJ0U1QxWWtDa3BKSXBNWmNORmJDeitwSlEvbUZ4aUNEa0lhWGZk?=
 =?utf-8?B?czFsZjRaM3lWWDhITFdNWTd0S2ErdDhtT2g1dmVBdUZjakNKbFdpZllHN2da?=
 =?utf-8?B?UjlLd21BRXFQS1pUV0RtUElZL2pJWTFsNFNMNUdldlFMYlhPOFVBK1ZWL1dX?=
 =?utf-8?B?TXhpY1ZnM3NLbzY3S2ErcmpKWFZrNmZubXcxSThML2RXbFhhaWR5QTA4SnNo?=
 =?utf-8?B?UU1RaFRkZUZNVFJoaElSTEh0YW9BbHM1YTRyWFFmdlF1MTh2TUxIbFBWd2hG?=
 =?utf-8?B?RnlMaHp4TllKRGowWDM0a241RlVGTGxUNGVpSEtaV0RTSnZNd1hsKzdvWjNl?=
 =?utf-8?B?Zk1EUGtnbXFEaXFXMmE3OFlRWnR4VlIvUFFuVXZNUjRUazV0WXF6OG9LNmV4?=
 =?utf-8?B?OENtWkJ3bDFmVU9jYWd4VXNRWVB1YW1sLy9RMTRWZnV6QlloUUJlakE4R0VJ?=
 =?utf-8?B?dU9yTEdEZWUwS2doQ0VnQWU2djlmQ2hGTmNwaVZkcmFKakUwYzhuS0QxVXpG?=
 =?utf-8?B?UWllMUdoRVRYWjgya2hTSkRqKzhlM1QyTVQwak02aUFPZnZYdFJDS0JWZ1B4?=
 =?utf-8?B?VXRlY0xDbi9TNjNtRVQzSzY4Yy9pakJ6TkorYzMzRmtUYmtrbTRiNy9nbDNI?=
 =?utf-8?B?UWkwRy9qQ2RGd2JnOWltUklVRXk5bTZ1ckRFeXR3WVdFVUNvR3dRdHNlYktX?=
 =?utf-8?B?V0d6QU9ScXhINkFNYlVjZ0lhUFd5bXV3NDRTUzlRV1FTNUpPZG11MDMwcnh5?=
 =?utf-8?B?S3Mrc2FjMGg4V2ZuclV0dFNWVVl1QTRiaWVVUlRVVGxsWVJnTVFHWmttM2Q0?=
 =?utf-8?B?KzBEWkZNM0JkNXVnY0F2MWYvaTRtTm1wUTZDbFVvZ0h4NFNkckNQYzd5dTVO?=
 =?utf-8?B?OUYyUmlHNzU1cFY3MkZBbHZsY2h5b2dGd3hFOTdOazJtd01YeUNqT1hRVUJK?=
 =?utf-8?B?dDdpV3RWOE9oWmtiV05qb1pRS1V3cDc2K2RzU0doZHlvL0RoYXBzN2FEUXVh?=
 =?utf-8?B?ZlNkenY0ZXJWN09CV01wUk9IWk43eDRPWGlUTG80S3c4NzZrWjBseWhGUGll?=
 =?utf-8?B?RXlrYXBReCs3cUFKc1pNR1BiMVBDNklnbFNmTFR1SUwzMVpxM2JRZ2ZleVZO?=
 =?utf-8?B?LzhaK1RDMGNBdFRRMTFKc0g3VllENlEvMFJOdHRtenNvNm5ER1RlNjc1VVho?=
 =?utf-8?B?VE80aTRRSzZ5eGNTNFZjcFdRV3RuVmloNHcwako1a1NMMFlaUzhhTnVOb2dI?=
 =?utf-8?B?Mm5qUCtSVzNpbVdRNzhkaWg4VGwrYjUwRDZNV3h1bldOb2hiKzRMTXIyQ3VK?=
 =?utf-8?B?SVpOaG5TakRpRzVwVGpTTDZjamxOMGMweTNuTndkMDdtc2ZnQW1BZ055M1RR?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fb3bba-97ca-4129-eebf-08dc798fd6a1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:16:27.9741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJWr+9BAu3NZXGkDY18zN29XG/AiHjLUmo3pTtuCzCn/nvgeesWv7HpqGoB2Mh2Kiir1gI7midKAC+B0L71Vub9mlq8JIpEZR87WcutnrT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364
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

Hi Jonas,

On 5/21/24 1:57 PM, Jonas Karlman <jonas@kwiboo.se> wrote:
> Hi Quentin,
> 
> On 2024-05-21 11:53, Quentin Schulz wrote:
> > Hi all,
> >
> > On 5/20/24 6:06 PM, Tom Rini wrote:
> >> Hey all,
> >>
> >> It's release day and here is -rc3. At this point, I think we're firmly
> >> on "bug fix and documentation" ground moving forward for changes to
> >> v2024.07 and the next branch is open and ready for use and pull
> >> requests.
> >>
> >> In terms of a changelog,
> >> git log --merges v2024.07-rc2..v2024.07-rc3
> >> contains what I've pulled but as always, better PR messages and tags
> >> will provide better results here.
> >>
> >> I hope to remain on schedule and that means the rest of the rcs every
> >> other Monday, and with final release on Monday, July 1st, 2024. Thanks
> >> all!
> >>
> >
> > Just to let you know that Rockchip PX30 support is broken since
> > https://source.denx.de/u-boot/u-boot/-/commit/1d01440b3f14f6648cd672da619489f635cb209c
> > (at the very least on Ringneck, haven't tested on PX30 Mini-EVB yet).
> >
> > U-Boot proper pre-reloc seems to be running out of memory and we cannot
> > reach U-Boot CLI anymore.
> >
> > I hope I'll have time to look into this before v2024.07 is released but
> > cannot promise anything.
> 
> On Rockchip platform all DRAM is available at U-Boot proper pre-reloc,
> so there is no need to limit SYS_MALLOC_F_LEN to a small amount.
> 
> Ringneck seem to use 8 KiB for pre-reloc malloc() pool, please try with
> a 64 KiB pool, same as rk3308/rk3328/rk3399/rk356x/rk3588 all now use.
> 
>    CONFIG_SYS_MALLOC_F_LEN=0x10000
> 

This made it work, thanks for the hint.

> malloc() pool size used by TPL/SPL should still work:
> 
>    CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>    CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
> 
> Also check the "Early malloc usage" from bdinfo cmd, should show how
> much memory was actually allocated at pre-reloc, from a rk3308 board:
> 
>    Early malloc usage: 2060 / 10000
> 

"""
=> bdinfo
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000000200000
-> size     = 0x000000007fe00000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 115200 bps
relocaddr   = 0x000000007ff53000
reloc off   = 0x000000007fd53000
Build       = 64-bit
current eth = ethernet@ff360000
ethaddr     = f6:3c:b5:0d:0a:13
IP addr     = <NULL>
fdt_blob    = 0x000000007df43bd0
new_fdt     = 0x000000007df43bd0
fdt_size    = 0x000000000000c1e0
lmb_dump_all:
 memory.cnt = 0x1 / max = 0x10
 memory[0]	[0x200000-0x7fffffff], 0x7fe00000 bytes flags: 0
 reserved.cnt = 0x1 / max = 0x10
 reserved[0]	[0x7df3f580-0x7fffffff], 0x020c0a80 bytes flags: 0
devicetree  = separate
serial addr = 0x00000000ff030000
 width      = 0x0000000000000004
 shift      = 0x0000000000000002
 offset     = 0x0000000000000000
 clock      = 0x00000000016e3600
arch_number = 0x0000000000000000
TLB addr    = 0x000000007fff0000
irq_sp      = 0x000000007df43bc0
sp start    = 0x000000007df43bc0
Early malloc usage: 2250 / 10000
"""

The default on PX30 for SYS_MALLOC_F_LEN is 0x400 (both from arch/arm/mach-rockchip/px30/Kconfig and Kconfig).

The default for SPL_SYS_MALLOC_F_LEN is SYS_MALLOC_F_LEN.

The default for TPL_SYS_MALLOC_F_LEN is SPL_SYS_MALLOC_F_LEN.

I suggest we change the default SYS_MALLOC_F_LEN to be 0x20000 then, on PX30.

Since we have forced TPL support on PX30, we can keep SPL_SYS_MALLOC_F_LEN is SYS_MALLOC_F_LEN, because we necessarily have DRAM support in SPL so we are much less limited in allocation.

Since all PX30 boards have 0x600 for TPL_SYS_MALLOC_F_LEN I suggest to make this the default as well?

Anything against this?

I'm also a bit confused as to why we need to specify the size of the allocation pool pre-relocation? Why is this important?

Thanks a lot for the hint, I can now work on migrating PX30 to OF_UPSTREAM :)

Cheers,
Quentin
