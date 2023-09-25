Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75383CE7A95
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78E386BFF;
	Mon, 25 Sep 2023 15:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ZV4cbkr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE34886BE8; Mon, 25 Sep 2023 15:25:40 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DD986C28
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrDw494DDBWfW/SdB/M204+8ssin19w0Pz7KEN0X0b2YHkpkqNEGtx4Su7S9/v549zwQB7RHwgXpNu9hcf47ET3l3Wm+kI2r0um/REf0PZlZX2v4Umf4Usi4kyoHq/doKVvr0GZbLRMNKaSALb6Wgok3Gm2QupdY3S1BW/G3XHXJVsR0QZCjPCwjLIkuJlHhMe8ZZGX2urGUu5RyU11bzrrFlJSlFtwjg5FUedmN6Q3VBUVlMwZx+IMa5jcv0PSPQ6MAY0ComGLsvWdqafeMCZK+y3GkElw+Ul1/rc9i6ZlrK4WCYju49q5SadQ0DDfgjDDJ0w3PdyMeUxW+HdU0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtk7DKOhS6PEnoLA+KunacHiaYnoTskN1Tnsu+DcXKc=;
 b=eUlG+CGXXNh4ali5xXRyuyI6QmjKKKAlUolbY41jRGXYUWbyQ96PLUN0kUSav04gAvsBtsGcBnlgWFQGN0Ll6HNKXN4xTwRMmC8uxfvIz9KCIg8xMn+g2T/dbWk+QORElTjZCzEPy1Q9DVhZO16GDTRJuLNkaD7oBngL33CVUKs4dpXL4u1oajYDeYGcrDVR/tQ5yOQlSJaQ7uEpA2aLxWVl76XFJcGaO6Vqsb0yBKgEXYyVmBIc4fzEP1gc5pHNzkk0gjDZctWXtoMBIrpB1zXWxTrMtGD8IiwQMASAj+EwZpidMiirp7hACWejcrA1eelgrMLcYVmHq+CKREj1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtk7DKOhS6PEnoLA+KunacHiaYnoTskN1Tnsu+DcXKc=;
 b=ZV4cbkr0hltr5A6k/VUNr8XYHL/1YA7VMwUG9bSXxdS7AhKYoX/jak8eeZdCsAX4OlvREZJVRTK+r+iy4xnAf6ko8gTk7+8mntRbve25LVqv9Q8pwMW541D6kZUFzxz5dnE04DzSIwRyT1TaCuaxEyj9u/+w8Pt6T2ewGTmJPH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB6317.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 13:25:36 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 13:25:36 +0000
Message-ID: <b95ee217-05d5-32dc-94bb-aaa0e85bb5d7@prevas.dk>
Date: Mon, 25 Sep 2023 15:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2=Yx=rqWwi9_N+dzKQq0EViGohYd0QrJYxrUERpZwXyA@mail.gmail.com>
 <e52f81a9-1006-ca4f-8501-7c6c1f6087e5@prevas.dk>
 <CAPnjgZ09St0710SRLzubphauTYMtE1PyxAFWEKsupA2dAhXRbw@mail.gmail.com>
 <b655aee9-ebc6-044a-cc7f-9e28d850b671@prevas.dk>
 <CAPnjgZ2CMYOpchV0Q3qkdRinaMp8atpW+QE0FJ_VOJfV8YRKJg@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ2CMYOpchV0Q3qkdRinaMp8atpW+QE0FJ_VOJfV8YRKJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0097.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa4a029-f650-4f14-f83f-08dbbdcae702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/MIE0p8TcLbIH+bhiIfRIHO2wS5nnsGb4+FhEu9JzlWti3iqRNhL5URF+H60LnvYpCezzDgu+BDmbmv1hOLDqLqLjxyo6V28uOl1GYQhJ08ZUzUF4up+bVRaABz9O2PP9rRpuRQfOIv/JE3yTXPS/7TXeYI/q52V5LR+LA8o4eN9gJK/msmZjGHVhB/JVKqKtGjzZHrjiLn0e/2A9L4eeYt8tHH4COdNHXcha+8pEwd2iRdDxmI6PsvuOxsHle8l06kIJcKo3P1Gse3CUJcajGBZ+MkOdptHepUR9VkT0SD5qZLGxwpFT1RuLz1a6qFTsxd/VvjF1dgccRThx0kqcwDijkuHvmFil/rxI3JHKE+/x1B0ngOtON7R4OyDCCaEoMjt34L5dMBZBG70VrSSLparPTPosMS+G4XOcW9esXJNZz9NfFod7kbOlj5uoBSE9tDkOokS65j58mp3rDSbKZzFej1zr7HG7HdHNPDpqpmWA0/aQ6Q2xpQxU2XguEDfFgni1kzylOh6D2Nnp3c8aIyS442L3fIHho39LWs8h4JVtZ7a8QrbuZJ77mAManq+Xrrf88PuHSoLmkfi6U770QJHn/TJv3G4rOXWMq1DuXUvjJWOZb3OjMzzLQFr0uxo35XmsJsU932sZBAORJ3UCvTEAVG27o1w2Dx2UoDNHSVPUHiCQODjS8zR0n0pFV1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(39850400004)(366004)(230922051799003)(1800799009)(186009)(451199024)(38350700002)(2906002)(4744005)(38100700002)(6512007)(66946007)(66556008)(66476007)(54906003)(52116002)(6486002)(6506007)(5660300002)(26005)(44832011)(316002)(41300700001)(6916009)(478600001)(8976002)(8936002)(8676002)(4326008)(2616005)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRTMG0vRHNEV0plRVBBSTN3RW9CNWhKamhXRHoyam9wdDkrUVp5SWtzN3FT?=
 =?utf-8?B?YzBHZHVabkNKR09SN29DYU0rZEJ2Tjl4UlVoZzZ1YVFnRStWM0VVeDJUbDFP?=
 =?utf-8?B?TDdHcjlpMmFTYjNPZlF3SmlzcVhITmllbUh4WmpMUVI0ZE5ZaHk4cnNJdGVm?=
 =?utf-8?B?ajlTK1BRS1BQZzRRVUl0ZC9MTk5jenRyd3RVMDBZYmNyRld3UkZSd05rdlg1?=
 =?utf-8?B?TzdMMGxsRkNZQXUyOFZHTk9qajN2UmEvVDQ0ZHNPbnhMOUFzWXIzTkVqQ2JB?=
 =?utf-8?B?bFBZNWdMWGVkM1RXZHpsWHRma2ZqQm9JbEJORVAwYmJjMG1lTXFvazJtbmxJ?=
 =?utf-8?B?TW95bnUxRjZEYzJ6b2hUYWR1NVhlL0psZlIvZnN5Q1lGWUdWN0xNQkIrUGxw?=
 =?utf-8?B?eUlJVWxGaWhiZjJXN29IejRWdDFDR0lZc1dGVVB4UTlheWI5MCtuT0JCbjBD?=
 =?utf-8?B?T0pjNEkxMUkzMTl5Ni9nTnI0ZFQzM1l3NWlqQVNCZ3lvNDU5ZC91Skk2MFB6?=
 =?utf-8?B?QVhsTXN5TTE4Qzlkd3huVmo3K2Q0L3ZPbXVUZmRKWUdtV3hyd0lFUkxXK29W?=
 =?utf-8?B?V2pKK0laSEdidkNjQ09zSDFycXJLRTVscUkvazFXK3ZKNHM1dENDc2psY0U0?=
 =?utf-8?B?RUduWHExVHVnYU52cDBKeFZKMUhJUFhnUHFBa1BTRHFIL3EvQVp1L3VXOG1G?=
 =?utf-8?B?Rk5vdnkrWllsUTh5ZlhSdGNsYk1vZVZ5eE5HLzZWN1FYeTBobUl1YnRCSHJv?=
 =?utf-8?B?d1pJVFBvQnZ1V0tITUdwMXBaL0FybTBLR1lpQS9zSWxnSnNiVzdiZnRaWklB?=
 =?utf-8?B?L2Ixc2pxajBnUmtoYktpdzhHM2ZxK1BQZ3dwTjg3Z0JBdEJ0VGtWbXNBa0ZE?=
 =?utf-8?B?VGI4SmxTWkZZK04xc3gvQjJqaDBKc2syK3Z1WFhVSWo3Y3ZNNU4xTnArTEh6?=
 =?utf-8?B?c2lOTmRtNmtIM3JNTjJXTmxxVE0vZFV6Q0VHdnBDcWlvTjBJU1J4dmNUUDYw?=
 =?utf-8?B?d1dBb2w0eWJyUndCVlg5Z21qOEZjd08va1dQR3QrelpBb0RreWJOVWNTblAw?=
 =?utf-8?B?dFpGVmVXWjRpRnp2YWg3aktyWGx4cW9yY0lXbnludmlIRlVxYm9jTmJ4Tk9l?=
 =?utf-8?B?anR4cVhjcWk0TDI1WUxFSktRSE9pUnBSZ1ROREFxSm5GK1RKMTQvWGozZG5R?=
 =?utf-8?B?bzVwaGViOU9McFkvZ1B1T25IR0NBc3pvcEVkYXdJWi9wTXFnMWE2SlRWQS9I?=
 =?utf-8?B?azI2T1JOS1Q4SUdtODBqWVJKSEdSQmZmR0RyVnZwaXliLzl4YUp5SnQyZlFw?=
 =?utf-8?B?Sk1Pc0RoRVFzSkpVanJYRkZFQ1Q3TXIwMkZDTTJxSVVzWUtZaURwcStISkZY?=
 =?utf-8?B?YWJoSmlaYnAyL2tNRHFtVVRiMXFGWVY3RS9yR0dya21YbWY2YUsxb3JmbW9Y?=
 =?utf-8?B?MFJOenRhVklRc3lrQVBMK3dma21sSUcrYVd4YVlTT2hseHJLdUdPaHB3cEwx?=
 =?utf-8?B?TDNOOURCdk92UDVBK25waDljMUNTeXlPZUJqQ2NTbU5aTFhEMjNkSnNvM0dz?=
 =?utf-8?B?M2ZPb1ZkMCs0SDUxcFB3OXByUVVuVFl2LzVqNHF5dCtobWlqdmlHTTBSWFlx?=
 =?utf-8?B?bWRYYkxFanNxWmcrTVFzVTI1amF3SUVZUzY2S3gzUlJIS1pwQXdycE5GVkxI?=
 =?utf-8?B?eUNHN1JUaTRkL0JsQ0xNK1pLRWMyMlVOTmVHZDZESXJScjgrdGRLSDRsY3RE?=
 =?utf-8?B?dGFGS0JTUkM5YUkxaThKL0VNT3Zad0tYUHl3MUltMFc2T2ZpdEJ4RkdvL2xT?=
 =?utf-8?B?QnUzTjhTc3VRalBWSURNSkp6azhZYVBsUjFXcGpiRUs3MkdQWVBPd2c2aHlG?=
 =?utf-8?B?M1dXYWp3SmZrWEdaWHNmbEE4RDdqeWNTRkZRVzc5UmtRazJRbjBUTDZFZENu?=
 =?utf-8?B?SkVLaHZQUVNQZDhXeElPMHI1VTJ5Vy84dmJrVmJGcE5DcHNmQlh1WThEQlR2?=
 =?utf-8?B?aUlDVjBxNXIxYlM3bTZ0bEdLeFNMelNhZ3lPK09Zbnltam05M251NHNTRFB4?=
 =?utf-8?B?OTVYMi95cEx6TmpFbmFTb0FkSXRWV2xkNzRtWHVYY0x5ZjgxZW9CWlJ1dDRs?=
 =?utf-8?B?b0UyWUg3Z1I1Q2VKWmw1bkRpeldQakkwbWR0VkhFdjRtdVNtWit0Q0RPODRv?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa4a029-f650-4f14-f83f-08dbbdcae702
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:25:36.2896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRkLvpCDuAfRaL9ObxC4zN0HT4Q2CCR4MyQYEhlghnUYV/adg3BQyVoFf8ICceSrk8C04dhKfXtDCXjudVgTm0TKGM5LDKHR3fhE0ds6eos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6317
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

On 25/09/2023 15.10, Simon Glass wrote:
> Hi Rasmus,
> 
> On Mon, 25 Sept 2023 at 02:47, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:

>> Since patches 2,3,4 touch binman code, could you take all four?
> 
> Yes, will do. I didn't pick them up in the most recent PR as I try to
> have things sit for a week before applying.

Oh, absolutely, no rush :)

Rasmus

