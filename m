Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14357CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 18:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8932B86EA3;
	Fri, 13 Oct 2023 20:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Sj/bwbDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFD386EA8; Fri, 13 Oct 2023 20:30:35 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A2D86EE4
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 20:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOSXpkDJHt6keAj+Q61G/6tJL3h8kUeGoEbXLbfhoDdjeSURjEsUlN4rThkeg56S4t9R9TnVeE72gjO3DWwO56JjhXJIvccfnPFFWpJGNfZ2Hj6xzUoOSTnRq97sWMSUQ/QejheD/8sve7zBKI8Z/lZCKTieG391gUTNiUkgJdxNalin+/V2SJldjeK5uF2hsRr7bgfRUR1xLfwfdcPaiH6HwvC2vokRua18czUYRiQEAZYXW4Oz8/Azfi/PVnL4iv7cvL3DxB+Rcj6bNHtvdzz2LmmOvmhA9LaNKekw9+hy13XL4IkIU5eAk1pdHr5KxnFyqlux0UobvVQjfuWXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuRn7J8P3R217iM43OWS8XcQHr3ZKF+jVcXX57b6KX4=;
 b=HXNX5+fkQG7h4sG8sizLNjkhaNCpAbecsFKE/kaWODbOuHMnA+ym7rs4nhKmjJ+LSQ+ZbG9ItZ9M8ISWWScXuJ2q7Z/v9i6G4S4W1nzbqODhwgoLgnhuD3qg+hhvElqfhR2gHuEX5NXIpsMR5afkHjuRU/HkJm5FgVnEJXugBI/eqmL6pA8yX4YVjX8G/Ic5lXxf8+oASATFF5KCDrxPSijj+iUI/snCbmHLDMifr/JRp5EC8jjLjCXVUKaFIOgAFBI4rnuzotTdMfaogofN95bIGjBZiMsRHczZuPfS1HYeS5ldfyjtDU3q2vLwcjxZ3Osf52TQKovXGxxOBRZxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuRn7J8P3R217iM43OWS8XcQHr3ZKF+jVcXX57b6KX4=;
 b=Sj/bwbDFX6frtWOX3t2MEiZk+S7P0qd6qcneOe2mEyY8fLkEwqnNnv4NDebcL5pFBG/dwAMIE7TTEz5OdQqu7PYPBMjU/Nr9eiZ5THTQHzcjzgcKCmfnYbddIJRzaSM3CTHjo6Io9n4ZeZSF66EPqBKlwur8NcbKpa8L+7n9K4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB6701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 18:30:08 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 18:30:07 +0000
Message-ID: <7b7878a9-c0dd-4d3b-b888-2a6a190109f2@prevas.dk>
Date: Fri, 13 Oct 2023 20:30:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Content-Language: en-US, da
To: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
 <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1e1172-ca63-4737-0cb7-08dbcc1a6d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dErqXKLP4LKFs0/1NTG12UBWj3pv4n5n+yPxd1a8yIsYhl3Q10+wHoj6zK530m0v2QgQ79Imij8ZSi/Ru4SwY5o5VB8cxGf3itbjbrQhn01iU3K72mWXUA8ncMBZSIYQJcEgZi69GSaXVwPQemPULadsGvGL91w9SWj4s2EsvUWPrhVALkVNUGR9jjjR3xrYt2unG8b3fxPx1f0Trc6B63CkCrBZuTkeySOExnG0CRFBu2/KpWUN0ynfImfl69KE2anYzmwUGZ/fkRp2BO23CuK5w6/KOYPUUvij4MxLP2iCyumUwoVoCSOTBo3olCpZ1iGm8fWWt0ZDU42zR+IQd/j8dn6Y52XCiMljmFUQAupMTilUWPhgXtGmth3dMeZoJib5Lq7tMXRUkT7kpmGInz4xft/wVX+6eWYBnvHyz0LNcxVJf+lcI5vQ9rduX8ZpWPxaS1WFhYWXICabPJZ3Bd9uZVp2/VK1de9hXdIvEYbp3kp1wbMfRV6Bo6Ae3Hl/mm30WI0WaG1W/by81VU0sy3DTZpdfw+gZfQsrb2EIJxINqTJyl59+UIL/GvjY9tDb+XPq6KRG2ilnN7wISlDYfsMFZ4VFeU25QCDkSkl7LP8Pm3Q5YEUS9+B+pmjWmB6iQ28lNdR+b7y7jnWBc0IFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(6486002)(26005)(36756003)(6512007)(2906002)(38100700002)(86362001)(31696002)(2616005)(4744005)(6506007)(8936002)(4326008)(8976002)(8676002)(31686004)(316002)(66556008)(66946007)(66476007)(54906003)(44832011)(110136005)(41300700001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2t5UnlRMVdVU3RRQVhCd2hrdW9xTGZaV1VZYlhFTWxoaHVPMkhneUNJKzhX?=
 =?utf-8?B?dWNRNkdqVDBvVWpiQXZMck1LS2NJbVRFRm82Y28wNEttQVpFNFh6eUpvdVRV?=
 =?utf-8?B?YnVSWWlkUUtnbXAzVHlUZWZFMHE5Vm80Unh0QzdHUW9nS05NWEw4Qi9jMnZR?=
 =?utf-8?B?VHdTQjJRK1RXcHdIME1mWlU2OUc5b2U2aUM2ZDlpSXRud01CU1Jzbkwxc3Nj?=
 =?utf-8?B?VU1RUE05dGpYczN3ekpxVW92OUhNT21tSHcreHVLVGYrcnFjaVVsT3VBM0J5?=
 =?utf-8?B?akNFZEl2QUFOck1hWEtLSno0QW0zb2Zkd2EzdFRaL29uTE1FTEpUY0pqeE1k?=
 =?utf-8?B?Ty9YUnFmOU10Yk1XWHBjcFlyd1Z0am5IdDNJNnZ1bEo3eTRCaTgvYXF3bE1J?=
 =?utf-8?B?ampFRnlPelphS0tteCtoUG1wbnRERHFERG9ud1VVcWdhenpFTDV3b0Vxd2dM?=
 =?utf-8?B?Q2FsRXJpN1NKa2pKN2ROQ1BheTh6K0tNRVpSa3NKdloyVFJxUUZCMDFzR2RM?=
 =?utf-8?B?L04wY2R1Qk4rY0l5VFFBY2c5VUV6RHlLQVVEVFk2a2xTV0hGb3RORzRVT0p5?=
 =?utf-8?B?dVBnUnB5NDd0a1dHWThZaHBnTUgrbWQzTDh5Wmt2clBodVZrajRTVTF0SVZq?=
 =?utf-8?B?UEczMkh6bFdISGN3RDZYTUpTMU5rcWVJclBaZFRkdlZDNVhycC9qUXAwaXIx?=
 =?utf-8?B?TG4xcktSbVhpMWRQcXd0VUJhZWdJU0lVTWhaU2VnQTZ1Z3NtTzJwcE5IM1Y2?=
 =?utf-8?B?bWVVU0ZySnlkdnhKelVONTRWN3h6ZmVkWS96VENNWUtoWjkyUXlTNWRYQ1p1?=
 =?utf-8?B?bXZnNWZIa3hBTVFicUhTdVhFdnozdUtyY0szTWdNcTNydnRXSjRqR1JqUVVI?=
 =?utf-8?B?cVZkcFd3YlBBenU1bSt6T2ZBZEVENjAxSlllUjB0dlk1TC9UTHh3N3pqWjNi?=
 =?utf-8?B?MjdLbmdWbGRzVG1oZzBCelJwYkZ1RWRQWWw2clZlS2lkQnNoVGNwVXp1SnFi?=
 =?utf-8?B?K1htTXZibFl4aVFDTXFYeVo1eEE4ZU9uNm1KVXZMS2loUGRjbSsreUhtZVYx?=
 =?utf-8?B?MDZrQ0czVkhrOCtGRWZYU0drTTUvNWdnaUxoZmk5cmY0WW1GOURobEI0eTMv?=
 =?utf-8?B?VzMraGhadmhrN3NTRVBWQ29kLzF2K0lqUGpTbm01Wk9wZExuMG9NQzlBQTY0?=
 =?utf-8?B?WW5wdXZ1alhoMDhUbDFBeXA2YVFuOXFvY0F1VTVXTU5jbGlTbWdzTCtEVEtN?=
 =?utf-8?B?TDd4TUVtWkNPdUJ2ZXJ4TjFyQmdwQkhNbklNWVhrWmQ4ZUV3Q1U2R0ZIRmdr?=
 =?utf-8?B?bStYTWZLRUNvMnpOYVEyMFBQeHNjeTZpTGhIaXZhSmxHOTV2RlNIeTdka0lL?=
 =?utf-8?B?emhZZk1uS0VVOVlicVJSREwwQUdPM3Q3ZklCSGNaaWNkdzJDZUE3OWg4Q2JZ?=
 =?utf-8?B?Z2VxTStrTEdIbjg1M1Ntd1NBR2R0TFM3aUdzQVloMDloVDFrMi9ISzJXeGJD?=
 =?utf-8?B?UFNkVVpLUFczUjlRQUg3YmdwVWFkRGtXNCtha2ovS3NJSWN0czE3Rm82VWVN?=
 =?utf-8?B?UDBybTNXTDdycHJEU0JDSTcxaWVpbm9PcE9JZ0FtblFpWGZwNFdhZDdJTXFC?=
 =?utf-8?B?Tkx4NENjSlBhc2RlNDl5Vll0WFlSOUQ1MXVWRERCWVI1dXg5cUQwNzBPM0RG?=
 =?utf-8?B?aElKdDR3aDlVQW55b3VCQzRSeW1QNWsyd05zODFmZElUa3ZQcHczZlFFVkQ4?=
 =?utf-8?B?ajNTbUJsNk5OUWp6R05sZ3V4dnpqWUVOZGF1TmFSbXVLRE13K0dLVldxSGJ6?=
 =?utf-8?B?d3BMUDU4SHFEcUozUWRzbC93MkREQ3cwNGFYdzB3VXFtUFlRVHF0eVZ0SWJF?=
 =?utf-8?B?THN4Q0w5ZkN3M3R1YW1iUk9Xcitmd3k5STZ2STZBb0VPc1plNE5tZlVNeVlZ?=
 =?utf-8?B?VkFmRzJDNnZMbUhNMFFlU2tlOFNnWFI0b0NPcG5NYktxTm52bk5CajA3bU40?=
 =?utf-8?B?VW9OeXdVV1RtUlZLcm9ITVd0eVJVY1lFSnV4NEY0L3IvZWcyWVk4UVhkUysr?=
 =?utf-8?B?RW9kNkVkODJmcjZXa3dsSURkTStlYlMxUjlsd2cwUThZcVJOTVBOOENNeTU5?=
 =?utf-8?B?ejhTb1hVQjVDYjYrTEN3ZFk1bk9XQkdvUVpyc3dGODUveVBsMDJYRHlvaVVw?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1e1172-ca63-4737-0cb7-08dbcc1a6d23
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 18:30:07.6770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lvc9hoxJdvcm3EYI7vuZbl2MuUjh/7GsqU8nupdA28MvLbS8f1g1Vkq1gpIVY0VdxDiULz37FPNMQGbtiKjItl5H7XOw3mUV13zy6f8bCJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6701
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

On 12/10/2023 04.17, Sean Anderson wrote:

> I was hoping you would respond to my most-recent email regarding this
> series.
> In particular:
> 
> | Why does mkimage have to do this? Can't you just use truncate or, in a
> | binman context, align-size?

In both cases, that just affects the size of the file, but does not
affect the totalsize field in the fdt header.

Wrt. binman, just as I was somewhat misled by the short mkimage -h
output into thinking that this already worked as I expected, binman's
fit,align documentation can also be read that way - and the
_implementation_ certainly currently unconditionally translates a
fit,align property into a -B argument to mkimage. So if we don't want
mkimage to support a -B by itself, binman documentation and code would
probably need another patch to reject that as well.

Rasmus

