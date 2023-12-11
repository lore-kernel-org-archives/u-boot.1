Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89B4C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 11:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1966B87738;
	Mon, 11 Dec 2023 12:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="k+LAuMbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5E687736; Mon, 11 Dec 2023 12:55:45 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 749A1876DD
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 12:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw9+Fs81oyFH+iAs3Vy9LHnE4TyKTAmkwh9YXpxfcS5Q24wc499lU09yZmAWL0cKvbqzqfiKcZcM+igR5pgaX96eiLW8S1e77kSAWtzOW1OIOWu9h/kpKCQhvWnJI4vgFn/9IgMFGjn4sss2lovMMZAr2IuJLqx9EMnhwpSFX56+fhdF9gBNBgRQyQhqDujrmx9oP6PMKScd/juHprHinoQFXJ2c+Y+Dz4KrmA3cyBW+EA+pfu5bBwmh1pVePq6aet1e65Fe21HPL8hsVmB+qYOpo0PUPMqElFe9B6+XbpypRRVhYMj7iB2nqKzW7R0JVIvvc/21ZAAJ936tM86efQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLyrjgVX6B2Lv3cnOR8FTIA+00iWDML2BdFQ6sBqzUg=;
 b=A5lPpZhIdnYDwywEI4DyBQ2kVWqwAmZtkSu5PpMjKuwIM8Zli8+VTWZ2S/vzK8/KIYJ7LicbmvOqc1Eai613UYwzMmYomIhXcO31oEnR2khiePcQfkSZ+hKi3hh6RH5lWvxV0JjswG7TUHKc1kz2G4UxCObM+PGWAzfXcWPR8AeKv8Hfxt8PFD1jgbHun9KPfJuHxQbPpGvE4iosM7gqLYIaaBEGUjttxwervQVGvO2MPO9Nk0/kOnwFvHCHy0nEJBgxFWkn/YoE9ynx5ZhZXRMr0Zrr2JBXUef5wduybIRS7CZCv1o2+ceJt2XqNa4sQQFPU1hP1BNvtpFpWhKi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLyrjgVX6B2Lv3cnOR8FTIA+00iWDML2BdFQ6sBqzUg=;
 b=k+LAuMbMUlKCcVRXrHmO1WTPV3FRfrfruIbOgFLRgpC/TiDuP48jZicqfLbDAtd/LusA2PgKPJzssL2Avt/+MrW//yNzx5GGfcZCBOF99S4MKHeL3KpjGT0Uidae7qM6R9nxXWHJpxVf0JdAM6df/ZfzJWXJkECJDhGVB6cdFxmFQccc6WHTT4B1pxHE1MeHmVl/n9VLe5XCp/I0Qz4ptxh5Y3d1Ek/kD5eh3ZEw5hZDa0gsV0OzgZtWd3yvVjM6pEjUUdex+xyEHRBAu3+HVV456S6QS0icoOTFfwhCuMezL6rtujM5iO97ENm/iG0HVF9qsimySSHv9iUA2aVmnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Mon, 11 Dec 2023 11:55:37 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 11:55:37 +0000
Date: Mon, 11 Dec 2023 12:55:32 +0100
From: Thierry Reding <treding@nvidia.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <ZXb4tN6CI6ZpPNX0@orome.fritz.box>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
 <ZVTo7BKHmwzns_G-@orome.fritz.box>
 <20231115191149.GI6601@bill-the-cat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ylxSk4FT8MObJZiL"
Content-Disposition: inline
In-Reply-To: <20231115191149.GI6601@bill-the-cat>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d30b2de-0fb0-4d38-f746-08dbfa4016b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87CHFN3htnliduFQ8jOvuQc/h3XxjJakq1hMP+P8gxRZCYV61xWmghzAVhJ4zoJaGV/QTwPXIlCsf5WrwgPc4n9FotYt3Jv7RQHOtHUdo0KnqNrnNRmeKo417Y2HJg9PXmocfOe3E0AuDt9PI/9evRJscA9BD4RkYLccXjXoWaV8Rr3uQ0tvhJDvOswTzewKWCinsB5ZYNE3Kr6vfO6wJ8nWfAsvCuvUe47KbaWpEJGdzaC+gHfxykH91Dqr921rrnrF7+YBtZoU7unnHJCIAG4SJFzvn2N1fL+A6tLqHiCO7n2Yb2aO1yvlarNe+nBYKQgi6cPj+gvj9f2JmVVFNNrbwFk8ZADjos59ftcSjSRz6qPVC1JLzsOoxOm8inRgqtzOlOxqwATsYGaXnUs9yW9AuVOPhB1QVUvl2VQGws/XcFnwTooh/Hx6U79L+uWpTfxDUg0T5uQ0+sgqCRFKPIg3nxIRiK6A/HyuxJzFvvnAy/WIPw12biO8bTF2PBLs8B73GTqFpA8tRSlAfnpOxsqaczX4X1i5FrnW86wt04YOKJX682mex0/qoPzpib7hDAdQfQQD7aDgett9VLjyGOv3PivbcwzGPvYVJIg3UxvAlljZsxHtIpiPXBPuBecdbxtLX30Zo0tHYabg1f1kamS0g4pjVFcy71dpbJWAG4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(396003)(366004)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(41300700001)(38100700002)(86362001)(9686003)(6512007)(6666004)(478600001)(53546011)(33964004)(44144004)(6506007)(21480400003)(6486002)(83380400001)(4326008)(5660300002)(316002)(6916009)(66556008)(66476007)(54906003)(66946007)(8936002)(8676002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0UzUFB5OWtVZ0h3QjNjM2JLVXBkRG5qVE04MU9ha0VkWWNDZkFmWDhJSG9E?=
 =?utf-8?B?QWJKKzhOanJ3OENnOEJDOGgyQmc5QVZaRHgrTTBHTVBtN0phVnZJQU4xeHgr?=
 =?utf-8?B?TlU5cUJVUHh0NmRIdlVPa3pUNjc1VXZSajE5cVhvTzJldEwzeC9ibE9IeVlu?=
 =?utf-8?B?N1h0OVlpUTJBRkppaWdUdUpvNzBNZWRuUFZOOFQxUVk4cWpJaUp6QmhLT3Bl?=
 =?utf-8?B?WE94Q1hKYTR5WEpXY1doRWVheGcreGlUVk8rRDl1NmtVK2t1aFp2dFNRVmFa?=
 =?utf-8?B?alZ5OVo1OXFjRi83SUVudk9kcG9jSWJYbnd0Skp6emlZSTFhd1JTbXhETEtz?=
 =?utf-8?B?ellHemZibE9zQ2FSVTl6OUNDU3NLSFVSa1NodEUrRzdBWGN3RnRDZmtpSjlx?=
 =?utf-8?B?NE5FaHpxNlZ6UERFbk1xMThrRnVVdHUyTnRyNzdWQnRxaitXUDcvS0ltaHVL?=
 =?utf-8?B?V3E3QTM3T1V1bzFtRXdUYzBBUC9Yc05SbWpPcjkvZ1VVRi9DWC9jYWdDbW5P?=
 =?utf-8?B?MU5kTGlsdEdjdEwveUw0YjdkWnNRYU44VWpaYVkvZ3U0VDNQTHhnR0hObTk4?=
 =?utf-8?B?b0lXZUxOQXlVRHdSb0F4K2tzZW4rTWw4alVlV24xSDBNbm1nb1lwWXhTY3Nm?=
 =?utf-8?B?SnFKLzBuT0pQVWlySTVubzZKWW16OTJjUk00NHVid09waS9sdG1YT3ZiRURQ?=
 =?utf-8?B?VGIwQ093aC9WeWp6VUtjWS8zQm10YXVvaE5RTzM1L1RFc2RhTVRpeFVJTjcv?=
 =?utf-8?B?S3J4Uzd5czFjOTl6SjlEMm1uWUgxM3pqS0VEREQ5U1FUd3JNVm1SMC9hSEdS?=
 =?utf-8?B?L3pTSzlET0hNRDA1eUJCbVh2RkQxUW9iZFY0USt2N1FmNGpLUU9pMTZKK2J6?=
 =?utf-8?B?aVNmUTM4MzZYTTg0bzF2RWNJaDFBNEpzbENNTEtuTTkwZDZlQjVieFF4UTNp?=
 =?utf-8?B?UlkxOW85cFJvQ2x3c0lTdXFFbnJlWmRwc291dTVGMWhKSHJBNXRjUmM5bnZx?=
 =?utf-8?B?dEhBS2tsYk9jeXlxK2czWnphc3pUZ0xaSDZ0YUl5WWZDZUZCVUJGYVBuY0ZS?=
 =?utf-8?B?cEVwTE9sekdZdCtQbHJZeHNtN3U5SHRBaEppN05kKzdhZkRIWkxCcHJIVG1J?=
 =?utf-8?B?c0U0SEVPZFNEanZVY3lnN1MvY3crYzJXZG4xRUVMM1VrdUw0ZlFFOXdPN3ZU?=
 =?utf-8?B?bng3NlpsRkZxZUYxTi9tbnp5VUZGc2dnRmdjbUF1YkZXdmJMcjY4OWNqU3N3?=
 =?utf-8?B?aEYrek1XTzZwZDV5VzlYd3E1N3lOU1FYTHRqeUd5MXluUDJ5VXpoMmEyZ3RF?=
 =?utf-8?B?ODJFMWU5cWwyK3hYOXd1Q0F4Q1U0Q0ZHVXVvRVV5ME9jajIrYWJNVitZZXVX?=
 =?utf-8?B?STVYNndDbitsRXBVOE56aFMyT25Wei9ZcXNxYmZNNlhIcWtBd3YwSUZReWhB?=
 =?utf-8?B?ajlrUm0wU1RFaS9ZZW9vUVRTZWl0NU13S2hLNDBFNTRoOXc5dHpSZENjOXFj?=
 =?utf-8?B?WUowNzBhN0RjT3lyWFdaY0pjN24yRmpvYWY3VC85c2lzUElidE8weVE4YUE1?=
 =?utf-8?B?RU5EaVlCU1E2QXNKN3NkTnZLZy9UTHFsU3BVek4zVlVwWmJiWGVuZ0pyTDZp?=
 =?utf-8?B?MmJqN1lIYmwrYkRmdHZzTXF3WEJsN0JVOGpWVFZ4YThCOU9NQ2dacVJkY1dj?=
 =?utf-8?B?U2h4aEFvSUtHUTF3aWJHSkdncXQzZU1YZlQyUkNvWGtkeEYwQy9mY0xzMCtT?=
 =?utf-8?B?cWJRM2xwZHBIV0FzS2lqVStQbjlxYVRLRDNuUWd6VHNtQ0pCTTBuaEthN1RC?=
 =?utf-8?B?cEtobVpka2xXZndnbHVocE1rMFRMLzJtc0JhdmE3N0hUdGxxNlpSUFhrcm5t?=
 =?utf-8?B?VFhNb3RqcytabjVSOW81aHJwV1drSTZUbnBBdWZPa3d6RHZTaEUyWjRaVDN5?=
 =?utf-8?B?TU1wTFM0azlsR3UxanU5MzNHTlpGQUtVcURTYXZ4Y0pUWk50UFZQR3djYTBK?=
 =?utf-8?B?SEFicDNpN3ZhMTZXTHFiRUxUUHNvdGYyUmtXRXBKRGZjcGhNelhvMVVsSEts?=
 =?utf-8?B?L2RUQnIySnRGWFhTalNhM0JUbzRkS1JoMG8rUHVWQkhVc243RlcvREs3SUY4?=
 =?utf-8?B?Rkk5aWlrbjNRRmxkekRYK3Z3ZzA0ZFlack5lQUg0V3lUS1J5azk2UmF6a0Jt?=
 =?utf-8?Q?cm1wxUI7jCNKOsMydyg3BNwV6RiboLJZUHX1Wpf828GI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d30b2de-0fb0-4d38-f746-08dbfa4016b9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 11:55:37.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peATDWglvqDlmUfZhLESnrJFE3zB+nxbW2trZ3tn/t8xyyL+tBKtOmmfxtzVqPNHDbxdddUhSWD1QZj0/aUSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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

--ylxSk4FT8MObJZiL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 02:11:49PM -0500, Tom Rini wrote:
> On Wed, Nov 15, 2023 at 04:51:08PM +0100, Thierry Reding wrote:
> > On Mon, Nov 06, 2023 at 04:04:07PM -0500, Tom Rini wrote:
> > > On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
> > > > On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95@g=
mail.com> wrote:
> > > > >
> > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =
=D0=BE 15:13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > >
> > > > > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamo=
r95@gmail.com> wrote:
> > > > > > >
> > > > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80=
=2E =D0=BE 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > > > > >
> > > > > > > > Hi Svyatoslav,
> > > > > > > >
> > > > > > > > > Since the proposed PMIC patches have been accepted, I see=
 the need
> > > > > > > > > to convert boards which I maintain to use DM drivers inst=
ead of board hacks.
> > > > > > > > >
> > > > > > > > > Svyatoslav Ryhel (5):
> > > > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PM=
IC
> > > > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > > > > > >
> > > > > > > > Is there a reason why the two above devices don't appear to=
 have their
> > > > > > > > .dts files in the upstream kernel?
> > > > > > > >
> > > > > > >
> > > > > > > Yes, there is a reason. Linux maintainers treat submitters as
> > > > > > > existential enemies or as dirt at least. I was trying to work=
 with
> > > > > > > linux but I have no desire to spend any time to upstream ende=
avoru or
> > > > > > > lg_x3.
> > > > > >
> > > > > > The usual policy for acceptance into U-Boot is to have upstream=
 review
> > > > > > in the kernel first.
> > > > > >
> > > > >
> > > > > May you point to a policy which clearly and explicitly states thi=
s as
> > > > > a mandatory condition?
> > > >=20
> > > > There have been a number of devices rejected in the past until their
> > > > DT are upstream but I'll leave Tom, who I've explicitly added on cc=
:,
> > > > to clarify the exact policy.
> > >=20
> > > Well, here is where it's tricky. I brought this up for one of the
> > > Broadcom MIPS platforms a week or two back, and Linus Walleij's point
> > > (and I'm paraphrasing) is there's not really an upstream for it to go.
> > >=20
> > > What we cannot have is device tree bindings[1] that aren't upstream or
> > > worse yet conflict with the official bindings.
> > >=20
> > > So the general way to resolve that is have device tree file be drop-in
> > > from the linux kernel, and what additions we must have be done via
> > > -u-boot.dtsi files. And in turn, some SoCs are better about keeping in
> > > sync with the kernel than other SoCs are.
> > >=20
> > > Now, upstream being actively hostile to dts files, especially for old=
er
> > > platforms? That's unfortunate. So long as we aren't violating the rul=
es
> > > about bindings, the intention is that we don't have device trees that
> > > are either (a) massively out of sync with the kernel[2] or (b) kept
> > > intentionally mismatched from the kernel.
> > >=20
> > > --=20
> > > Tom
> > >=20
> > > [1]: There are both examples like binman that Simon is working on at
> > > least but this is more exception than intentional rule.
> > > [2]: Per our other conversions, I know the tegra ones are in this
> > > unfortunate state in general
> >=20
> > On the Tegra side we've been fairly lax about the device trees in
> > U-Boot, I suppose. The assumption had always been that U-Boot would load
> > an external DTB and pass it to the kernel on boot, so keeping them both
> > in sync was never a high priority.
> >=20
> > U-Boot does only a very tiny amount of what Linux does, so dropping in
> > the kernel DTB always seemed a bit overkill.
> >=20
> > In either case, if this is problematic, it's something that I could take
> > a look at. Again, it's expected that the device trees are different, for
> > historical reasons, but I'd be surprised if they actually conflict with
> > one another. U-Boot's DTB was always supposed to be a subset of the
> > Linux DTB.
>=20
> So, the issue with U-Boot and kernel device trees being out of sync is
> that we then can't support the model of "just pass the current DT to the
> OS". This in general is good to support because it means that even if a
> given platform isn't formally SystemReady IR certified it's still likely
> to be functional.

This is certainly not something that we ever strived for with Tegra. It
was always very clear that we needed to get the DTB from the same source
as the kernel. The vast majority of what's in the DTB is completely
useless for U-Boot because it simply doesn't support (and doesn't have
to support) a lot of the hardware that Linux supports.

One concern that I have with this policy is that for certain devices we
may just not be able to do this. Especially with some early OEM devices
I recall that they had limited storage for the bootloader. Since the DTB
needs to be embedded, a full-blown DTB from Linux might inflate the size
significantly. Comparing to what we have today, the Linux DTB can be
anywhere from 2 to 3 times as big as the U-Boot DTB.

> The most strict rule is that you can't have bindings in U-Boot that
> conflict with the kernel, or should be in the kernel but aren't, and so
> on.

I think this makes sense.

Thierry

--ylxSk4FT8MObJZiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV2+LEACgkQ3SOs138+
s6FHmQ/8C+Fya3XesNABpYysWUhNANH+jTi305M8zNHWeIZ4biPzx3cABpMgR1ph
WAIPnRWxpvlQJQmNkQ3EVgSaPhy14LqCdvukSDIQbmZ4NLjmd85MFZlzm3dOnDjN
Dnykxy8P4upo0Q+n9/LbMflHtMxXZP+QWfFqDcqVtfycDdOZ/er4xFjK2pTLoBrL
M90Ss4Ri7dTTov7hM+Uw4+InP2KvXY32nv/mjpwKgn0HxXn1RTci8SHT3/Cr3cu9
TODaDJZccv/4FsYrMoSS2oXFHj89+YAdZsBqOsXS8b7x+KXmTdD9C8v3B2ak1aKs
ispnSbvnaeL3ZHFFXIjREI3h3CaPE84cO+FT95cygHKN8lJZRoobDqVLcMBZS+bi
WLTitVwzB5zawDoci9zfUvufG87FEqbIUnQdaTtqgS1ZIvVLFkqBbgaggn0/bSlV
Gk3CrMsWlsHNvWIw3BiqH+9oo14x+SG+dofIsgilWPRsPFF4zzT6F+O7uQtubPc6
zGclZjoW87iZDvLz/7xpMe9aFbccirEW/NP8X491xNg6ATOS68/ncRUX0T/GjrXn
84IVjBr0uGC/EBVndWFbyVx5kd32fSnb2Fw5+Vk+NDm7hX8LKmCXCwOrqTKiLtLV
Py9ef38GtGt26jSOT8z9KVFB3Y/HO0jUv9s9TbNkL0eNvXyJA3o=
=rYq+
-----END PGP SIGNATURE-----

--ylxSk4FT8MObJZiL--
