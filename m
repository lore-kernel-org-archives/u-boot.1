Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AD0C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026428744F;
	Wed, 15 Nov 2023 16:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="q1Ovr2uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5309487206; Wed, 15 Nov 2023 16:51:20 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204A887206
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grS4NI+x0LT7TFSKDtG298u8qZhmvk1FYWo69hOO5JNzG1YNFDxm/Npgb/uFgSY/kOvAgX9JH8NRUHkoEePE4RQZgrO4O8Zr6sDfU1LZxbg+c0CFGNzNrccSZ9cVk6cVSisdoj8V35WdvjS+anBCXnGgn32ZJcdA//i7IQ+LzTku8SkKBkyU6rcpH3qRYSne/sMi7DGkxYM+1NJzcbtM13Pm8X/sE4TwlRQe9noj+sNBq0ljDYzK3sz+li5NVvLmARPnUIxf5qkUrmC6Kh+gSuo7P5pocasOFAFrX+gq4sLDlpCm2FRQ7SLRbobhvshj2SUOgCo992iLxpgBgMWLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx3ZEZ8WpuQU1hdeChe0Sxs+hNqqnyH7+yvEW4ntfWQ=;
 b=OPpP0AA2AhNMw4mqqOkBsylpko0vhp7Got2nQPH7pnf9jy0SU6CbCMBS50LrPdlfwoTN3ZXslvvk4IrEA7CjmjawPJcq5NHefgf2/kzoy3m17YlxX+sTmcFqhesG/V699kRMV2I4xIP09LRmb4yfvGJlP08pNNnXTA9dyCwr2n2eM2/TzMR1pa/EmPgycswoPLHDo3+8DHmu/D7n8xQe7pGq0W2qVej8f3R6PnnZ4Yuv34Evn/gRUZtn+b2KWGwJNIhcqIXK9Ggyu/DxHF31KO4T1yByftN5hiTDIk2OX1SkQBAPHKvcON9bAL5WpXcJYwRzZvrj6ux5UJeGVLiACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx3ZEZ8WpuQU1hdeChe0Sxs+hNqqnyH7+yvEW4ntfWQ=;
 b=q1Ovr2uuHdwKUsV5lhZvTTENWQoxSz3uDoPKw5WeQk9LZS08TyQj6UnnFjgNmP73BYPt60tLiNIOidoGH5QuVG6+yXiM4UfO5g1dIN6SZQL0xkMZBu3+T+stZz695txcNIT0PNMl3XfR2Ogz+d94xwYn+XuvQfDZrCa8dxrx9d/pjBbHFgGuHXKf+sBvtHHFK1W4nZCFcUTjfT8MIVWUl3kXbpt4D47vaLCJx0qnfiVn7mxViFkWKiJJwGig94RNVtUpHCLf2Gx+Rp7nTN3tymxS2CqxoNgWWQZYGY7qPnE4U5cUi7qVM481CgrB5XzUSg3Qan+v1Luo68g5cIsw8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.18; Wed, 15 Nov 2023 15:51:13 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 15:51:13 +0000
Date: Wed, 15 Nov 2023 16:51:08 +0100
From: Thierry Reding <treding@nvidia.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <ZVTo7BKHmwzns_G-@orome.fritz.box>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TCEjbNp2QmS6+UrH"
Content-Disposition: inline
In-Reply-To: <20231106210407.GK496310@bill-the-cat>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: FR4P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::18) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: bb11ed3f-bf9a-4a99-236c-08dbe5f2b206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vx+Bvsoc7TApNlif6yq9c7xLMc3/bCel257KMJZlbW2L8kqESq7IyzCwyO7uClEm5MTtFgrmoABFDF0Co+HUsnQcmu70JDHCCUnB3ROfiJl22Y+p4W00lzUH4pXDu8smkCBxkw2qIm4kjX9vPJeDC+sipArNJfmdkvrGbKh4JlMZ46ltNdLdQHRh8LthO4BaYlyNyFKbt0jwQwGFVEmk8DtvvrCQgBsBgw6K2t7GcTrqknsj6R2cmf3gx3I3wKYlOANk03bvGCZwZp0eAqL7XKL1x6PoWLVWrSJFtx8QFHsR4jjk4IkYiggKW91s0FzrezNwrkH5n7+xmFw70ViMh1K7AP/vLTRWp+p/tQRFbkAr1JrTljAooYfD0mchWWHd+Kg+4EPgfcCm2BISQZhNR00thu3xfJxU5ymrC/sp/BPDEAyDXejmpGl3jRe+MnFzkqUyvb7BHAppmrRxEgJ9KWa8RyLtb982JGfuGTVPlbGJr60cAqkGvEswzKO98RDF6VEgoaEQZexYJGMtm0AAzCzhkDyJUP0GmCj1cg7CThUws76WxpDMa6DNdWnsLeTcSTxs5EfkLeiAe76hK3UnFUzgI4OzK9ft+xzo59Ydx09Deh51gYXt+1nIs6nTiE+QOfKe6fReX1ayCvvPehrpZqIPcsGIhfcU7Xb7GowqmWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(44144004)(6506007)(33964004)(8936002)(4326008)(8676002)(53546011)(6486002)(316002)(66476007)(6916009)(66946007)(86362001)(66556008)(6666004)(478600001)(6512007)(9686003)(21480400003)(54906003)(2906002)(5660300002)(41300700001)(38100700002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9rVUdJRTh5VmtwWlBFb0tMWFhmM29oWHhrUVIxTXpHVEd6SjRxL0NCZU1x?=
 =?utf-8?B?cUo3RkRubUl0RlZNTDRTck03d2YyckdrdG9LYUtNcWMvaTBZU0dmMXNSWmtS?=
 =?utf-8?B?Z0cvbWhtVnNrNjBVckt6RUVRQXpwN0RxNTlCWHhleGhZVmNNa3luNENzVThw?=
 =?utf-8?B?bGwvZmVhOElYQ2Y0TEwxUVpERmhFN2wwQk81ekxvSU1UTlFheEFwVTZLNE1v?=
 =?utf-8?B?cWgzc3B5R2JON0hRRzVwZVowbmxzM2l4UkRpU20xUWVkWHhKK09jMHAvTVhT?=
 =?utf-8?B?Si9YajZCb0dCUFlTaVgvcy9yb2dyb0puczFsUGV1L2RmT056M09DSnZFNG5I?=
 =?utf-8?B?a3JoMmo5eHFtd1dtck1jTFJST3BiN1RyQkx1ZHd0dTJCSTR3STNjUkd3Rys1?=
 =?utf-8?B?WUtpZWptN1dhRnphRXdma3YwWDVmQ0VlK0hiSW5Scit6TXdmSTdqVWRKZ2tJ?=
 =?utf-8?B?cWhZUTVJTWxwcUVWYjdiNzc0L0xOa1NHbkt1aGZMRG5relJmWFRMUzFlc3Vl?=
 =?utf-8?B?MlJ3RC9hKzRhL3QwQTVObUpsZHRHMUdZcDVUV0N4S0JuU2xJTlZ5cXNKcW5N?=
 =?utf-8?B?bUF5ZWpXdXRTT0FSUUJnNldoL3JTYlJSMWFTajQyOGZjaDJJN2FEbklCc3FY?=
 =?utf-8?B?U0JCRWlWcDYwamVyTUlRdTAraWZGeHhjSE1jN0IwaWh6ZEdzOXIwNFFQaVdt?=
 =?utf-8?B?VnhQRHRkMHExdTYwL1ZJcW5SeDg2L3p1NGFYMWZGMjFnd0NvOWhkMVRKN3I3?=
 =?utf-8?B?UTFNSm1UTTY3cmd4MUZRR0lVazhsZG1lNTIyVXZzUHlHZit1WHordzJ1RGJB?=
 =?utf-8?B?MC9FaVRzN2J5TVNXWmw3QWdhTXZITE5CTFpackFVRERXRGRNQklWdVBEVUFm?=
 =?utf-8?B?RVM5WUl6ajFyejdJV1hCbUsva1NRWGx0Ny9CMWxsVmRjK2VHcFdKMHduUkE1?=
 =?utf-8?B?TlVwaDFHekdUMndmSmdUNlgzaUJRcGNqS0l4blUvY0JYTVh5VjBMeGtuSUFh?=
 =?utf-8?B?NkxNWVUrSG53Y3dnb1dQTkI0eERVWUk2Q3dCbmR2OU45bWs1ME13NFN2U3cx?=
 =?utf-8?B?QmNuNUxZbnZGelo5UkRkV0l6LzhEQlFRNnM1NXhiVW5oUngvNWlWTVpwaFR5?=
 =?utf-8?B?d0FGYWxLdVFpeEdlZFJmVVdkL3IwTjkvTGNJVDRoT0ExSm9HTTA0RVlzWG5r?=
 =?utf-8?B?eTRTdXhYSkdlQ3FXc2lzZldjd094c2RxeUZWZHA1amMvRCtCRSttaHJRbkg2?=
 =?utf-8?B?NDlTYm43QkRjamhvTm1vWjdRaUR4c1hTZVNOWU9LNkE2SnhkV1JMdWFTWkU1?=
 =?utf-8?B?RW5iYU13QVh5NXhNZmZkVXUwN3RhcWhWMXJqc1NnKzJoNTZUK0s0QXVuenhp?=
 =?utf-8?B?bmFWKzFzaldvYkdOVW1NVDVDYjNNSVJFRFdrNXgxVUhlRTNxSzVZaG42dFVQ?=
 =?utf-8?B?ZXNUQndvUGlDM0RGTFNJcGpVTmliL0Y3UmJDb0lBcklTZWtDYndXYWljc1ZC?=
 =?utf-8?B?bnhoTFFhRjNoSy9nR25OOWg1dkhyNUhjTXlWOXN4NFBaaVZ5Ty9yY1M0ME1r?=
 =?utf-8?B?NVNEakFUU3pQUkUwbjJiUDdKbjA1NTdkeVBOeHRUSkUxN0FnaXNPKzFjRVd6?=
 =?utf-8?B?K21SZVlhTHoxNDhXZWhPamk3U25VdEtGWXdiQ3ZROW5YRWFYWUhaNndSazVY?=
 =?utf-8?B?bGVlRnYvSU1ZRnVPTFNkVy9zRU5idlNnMU1EQyt2d2lVeU1ZZ3NTWFB2eHNX?=
 =?utf-8?B?VmFzSkpybzF2ZE41a1BKUjIvNDM3ZUNVM2VXUVVzbUg5S01BZ01oQ0NuWjA1?=
 =?utf-8?B?WHZ2VytVcmZYWDNoQXMweDc0RzltZkZTSXZyOGY0YVJ1SFRvTUNpMnY5bHlB?=
 =?utf-8?B?NjlNU3lJOHMwQXpGTDhKSFlQbHhzVzh5Zjh2U1JaRncvRXhkZTBTWk5kN29x?=
 =?utf-8?B?VjhLZWZwS20vN2lOMHFkMXdoSHVUYU1INmlzbCt2emNlUVRJdnU5ZlJPZUVl?=
 =?utf-8?B?TmNaeHpCcWdtWWxLQlo2WXRUSGZmcHQ4NUF4KzU2Y2thY0gwaFB5SEltc3U4?=
 =?utf-8?B?MjBiUEV1ZE5Uclh3c256dHhRRU1BUUpUS1VvS0NlRGdORStqNVFYaEM5NGRo?=
 =?utf-8?B?RjJCM2NUSWlnb1E5QWZEL0M1SVRJdDhsZGJNTlFHUTdmVmpiY3U3ck5GSytz?=
 =?utf-8?Q?wCgzdO0RRBSfDKS2LP479WTqLWfV6GjegfFjhcZykYi2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb11ed3f-bf9a-4a99-236c-08dbe5f2b206
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:51:13.7128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX9ZPGy2+LmVDiHUAi3DZB377jGAWIjJdToNd0YNSPsM4QSNhi/ftA1HOTzm1jkwcknOmdjnK2RcZNo0Nzxz0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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

--TCEjbNp2QmS6+UrH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 04:04:07PM -0500, Tom Rini wrote:
> On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
> > On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail=
=2Ecom> wrote:
> > >
> > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE=
 15:13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamor95@=
gmail.com> wrote:
> > > > >
> > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =
=D0=BE 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > >
> > > > > > Hi Svyatoslav,
> > > > > >
> > > > > > > Since the proposed PMIC patches have been accepted, I see the=
 need
> > > > > > > to convert boards which I maintain to use DM drivers instead =
of board hacks.
> > > > > > >
> > > > > > > Svyatoslav Ryhel (5):
> > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > > > >
> > > > > > Is there a reason why the two above devices don't appear to hav=
e their
> > > > > > .dts files in the upstream kernel?
> > > > > >
> > > > >
> > > > > Yes, there is a reason. Linux maintainers treat submitters as
> > > > > existential enemies or as dirt at least. I was trying to work with
> > > > > linux but I have no desire to spend any time to upstream endeavor=
u or
> > > > > lg_x3.
> > > >
> > > > The usual policy for acceptance into U-Boot is to have upstream rev=
iew
> > > > in the kernel first.
> > > >
> > >
> > > May you point to a policy which clearly and explicitly states this as
> > > a mandatory condition?
> >=20
> > There have been a number of devices rejected in the past until their
> > DT are upstream but I'll leave Tom, who I've explicitly added on cc:,
> > to clarify the exact policy.
>=20
> Well, here is where it's tricky. I brought this up for one of the
> Broadcom MIPS platforms a week or two back, and Linus Walleij's point
> (and I'm paraphrasing) is there's not really an upstream for it to go.
>=20
> What we cannot have is device tree bindings[1] that aren't upstream or
> worse yet conflict with the official bindings.
>=20
> So the general way to resolve that is have device tree file be drop-in
> from the linux kernel, and what additions we must have be done via
> -u-boot.dtsi files. And in turn, some SoCs are better about keeping in
> sync with the kernel than other SoCs are.
>=20
> Now, upstream being actively hostile to dts files, especially for older
> platforms? That's unfortunate. So long as we aren't violating the rules
> about bindings, the intention is that we don't have device trees that
> are either (a) massively out of sync with the kernel[2] or (b) kept
> intentionally mismatched from the kernel.
>=20
> --=20
> Tom
>=20
> [1]: There are both examples like binman that Simon is working on at
> least but this is more exception than intentional rule.
> [2]: Per our other conversions, I know the tegra ones are in this
> unfortunate state in general

On the Tegra side we've been fairly lax about the device trees in
U-Boot, I suppose. The assumption had always been that U-Boot would load
an external DTB and pass it to the kernel on boot, so keeping them both
in sync was never a high priority.

U-Boot does only a very tiny amount of what Linux does, so dropping in
the kernel DTB always seemed a bit overkill.

In either case, if this is problematic, it's something that I could take
a look at. Again, it's expected that the device trees are different, for
historical reasons, but I'd be surprised if they actually conflict with
one another. U-Boot's DTB was always supposed to be a subset of the
Linux DTB.

Thierry

--TCEjbNp2QmS6+UrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVU6OwACgkQ3SOs138+
s6ERhw//e+8dCKZDwa3rMVBlDu38Ht9JxjstqPTESZTYrIuUpz4tGUTpyQv0TWn8
qwH9103MjmLgsEW3QCai65OZ85+/78EK6t3fVgBQlQsYCBulwu6U6AJ22EzF2qQT
j6GZ3MXGpsV1JxDIM3ii5cKzpEQiqet/z3rQtsBhoGHf3WzubYC1yyBEFvsvzNvT
5/k3Lo/T1hOdMy1EXK3ESahSegM6ycEQGMqo9ipJDBYxfjL42TxGjFmwpKPEfHRk
wUDn3j090jEf1+U0mVzuq4xscu0ViazK0C6otesSAo05Ys5dZHSJrVIitj0zDHcs
DfqERHi3C1uDK0ID2dfyrmRT/6TLVxvumwX/TVYlni/x3ndjWE7raChyyN5JS7xI
lpZEmnblT3RfKmQaJ8Oh8KMONaIRtyY+LOQM8cN1UceUss8GlZA7D7vKfbk3cIlN
jmddde5c9Ta6pSLib/RlwGHFJqKSqEf2f0ZwrJij1Sh8MhP/7nziDkYwCRUc37Rm
fxTC3udEW9wS86mv999R2zDyF7LUQLcIjC9wDQSai6IqgMSVS9ySZyPeIrU4hz7z
86jJt7ZQqeZ+BjVHroFCF6dQFzPU0kLBAYFobO5O/mt/Ozk6DdW5oFed6CQ90JDP
v0EponNM3+dfNlIdbYFNTrkjvssCglM0B1XMc2t+SXZjSRoxuBM=
=090O
-----END PGP SIGNATURE-----

--TCEjbNp2QmS6+UrH--
