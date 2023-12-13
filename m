Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C5BC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 11:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D294387103;
	Wed, 13 Dec 2023 12:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PDjbFuaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236F787140; Wed, 13 Dec 2023 12:44:47 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2BA86FF7
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATqX1NrZl5BPlRnXsmvjq6KCQH/JwAu3vD9yXLx20WdfcBt5mnw+enPT0NMWknXpiJtp9lpsxmK8Z43kGYTfsnIo3DclRgCNyu5D9K4UqB2CNNZ6+7MlIpvi44ZKge9t+Tv0hxp7/9fVnCdXpEYqVWc7DXmUiknt8nmq8lCXnkBOlBKlG7nAawlXO7jsm3Dhr4IE3Z4o3RlIA6B/8/DtWPKCU8eJSXMl9ojzDXIxssj6FU6KWFZAssozlqzZC5tmBpViBV7WodEYPUvwxuO272xWDiuSvbdVCwCGTpzCcMi5isXvPtkrw09kAI2s5LKhnSF9HGNN6nVJdJDo/sGagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBgUS8MA+WCHcgmTIho1xkzpmKXiYiXSDtz6l78ijnU=;
 b=gxVOo+AGKNqlSmctCz8Mciq/pgZtN0dCSISrhr1eGickReMaLIWcOrd7Ex0HNKrIJp1uFf8d9C5mvSZxJUYBRsLdJ7+jkhlsB89o0AtQolPYwxUYxBU4wBjDB5guNM8V5IMp8jLZzmfnE2TSFLt606Fv60STCm+SeGrsHheJ57HAolVGPTuRR5Qo2e3VDFOOM03VIX8YKSCm3iv3xaaA1MMzRqxQM1r9id6TfJcziDicHKvP2K8aNuTrOmreI0uIo/dkQ+8Jhsv0ybilvbYtUQaJztYZ6Dg5zVkCDZyxeH0BAqC/LLJokLdDfOY5+n4St51GfQOhT4lgu3qo2qpa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBgUS8MA+WCHcgmTIho1xkzpmKXiYiXSDtz6l78ijnU=;
 b=PDjbFuaDV2BHAdLf+TyXXtH3jZs/HtLSHh/QeQmb1hUaQP7twtds9Q5tPUsqR2oXkkzG7FeoWdlozYxHanAe2Wu98JYXukmm71C0XhXDmbS1mp+9MXzfJ4GX45770Qzxb2KyNlpxLhzShyifh8HDpUkuPXXB7aQ+QHeyembJiuUY9mw1hoGPuBIaeN1d2bMBNGm/C5T7kvS138eD4mX/EoHaKC74XMo8BZiS6ih8ur4NR2/56i4eSOPUpZ5EF9/xBvU1UilrDXlYQULoNUPJuNN3lk3yzSSF2/8vycG7+b32y7KsNQozYhHYfAIUIsTMgzd1tliEvhPQeygRdn8DPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 11:44:39 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::929c:d330:53e2:c5d%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 11:44:39 +0000
Date: Wed, 13 Dec 2023 12:44:34 +0100
From: Thierry Reding <treding@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <ZXmZIjNKVzukVGVO@orome.fritz.box>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
 <ZVTo7BKHmwzns_G-@orome.fritz.box>
 <20231115191149.GI6601@bill-the-cat>
 <C9328ED4-05E7-4060-BF5A-9CB1BCEE5B00@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7ot5/l+b8IWRiupg"
Content-Disposition: inline
In-Reply-To: <C9328ED4-05E7-4060-BF5A-9CB1BCEE5B00@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 927142dd-6007-4bb0-e9e6-08dbfbd0e37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzBe6D1AQGJMapYB90YTuJqXayLC+374ig4PqA3SmRhxvSK1SDoZJKKIv7ShxMPRQSE6pM1r4G9UBhySztu70fUxW8CWI303+jT2639N3+KPd4OLNIKD4llDF4Oj0Qm8aOOEppVXQondxR9zw9oqqMf80VFvIOL4P4Ii3ZsTlkO0AGFv4bsCaZxWhzK+tGv6um87KKQCKywi6xa0YJYxmNbSU3V+SptPrcP8qOXRzv1IUpYvSH/EE4KeHxkOWiWRJwCBjxwPxftMRYoTtG+z1OOBmduuLeWeYEecfdAV2jne7Jc5vgK+77NdE4Nam2aAkbw9PLAUKO7fBB7on1eXJDC+5UtN+aOqeRj7a3IIa6DZG0uNgSHXJzIbi06u346Q1OutQlRExaw8H+ntM+BQHaPsmcgmejAKNzhyqQd3bWvuMl5wFuydmqFOQWLNuw9AsjFBnrGwwhG7rkk7NM9InkTjG9FTio532WXMTYixB1PVtUNCqrGop7fiKCsOV1eFyx3cSWOpADt1KBnyIQ8ipONYGg/NqNqDH6Q7gRLRMVVyErbHIMGRqVDMISsxdCwvZxUFwjcg9bcUARM54QLeUvKFk0J2fRvIl16WIJW/A/VHBE8wqqT2UbL+zX7kbyTnSxUkC/E9+YMCmmx5m1+u7ne9YjHwpnF6zV+5iGCNcXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66946007)(66556008)(54906003)(66476007)(6916009)(86362001)(38100700002)(21480400003)(9686003)(6512007)(33964004)(53546011)(44144004)(6506007)(4326008)(6486002)(2906002)(316002)(6666004)(478600001)(5660300002)(8936002)(41300700001)(8676002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGFsOTlHT0JvcFg2M2NoeTcwOUxpdGNCb3E3S2lUa0o1MDIzVmM2L2tWZEVn?=
 =?utf-8?B?cWxOUUZmdzNaQXdVVWFpL3pMSTJidWZHeEZjM0t4ZzRQM0xScTdUVWxMeE9J?=
 =?utf-8?B?WGh5Zk5Jamg1THU2N21BOFg4MDI2cno2QnBKQ28vSlJTendveXljbkVUSEJu?=
 =?utf-8?B?RVF3VncrUnR6NVh6L2FTYTYwVDdPV24zZ1lmZVBVdXBwSFpxcWVxNmpHRUl3?=
 =?utf-8?B?STBFS0ZJODhaL21hcGd0QlREQnRsNFJEN1pTbDdOUWxIcGhUN2E0YStPdGJo?=
 =?utf-8?B?ckhIUDUwS0pFYWdSVWFiWmJYTDBHWWgvbms2amx0SEp0RFpIKzJFNkpwdE04?=
 =?utf-8?B?WWd1OTZtd0hPZDNXWTlSWjNnTlIwQy9IWDJJVXVKVkJlNVVvcXZ6L1pJOGlD?=
 =?utf-8?B?RzA0V0tZVExQWFQ4SE1MOFZNbENHcVBuT3JnYWlEK3NyNGdwaFI1NGMvOGdw?=
 =?utf-8?B?SFVLdmxSMTRPb1dId0NMdmY4TUdLTzVzY2xNaVJwV3JQS2FUYlhWeEhMRzBy?=
 =?utf-8?B?c0x0UHJnQzR3bk5SekJUcEN5bnRyZVBRMEcwOGphTEd1Uko5eUs3amlHVUhN?=
 =?utf-8?B?SUlPdmg2Tk04bFpIUTFTL2RsSklKN2pHRUI5ZWVVYnFjeXNudDFKSUZjVmFq?=
 =?utf-8?B?aVR4RDBBVkxOL2diZTRad0I1YWlROGpnTUUva2hUdTJBdUl2cTlyS0RwTVRr?=
 =?utf-8?B?MHMzaE5Ia1B1TEdJc1ZDdXMrZVJWNnZ3dDIrSld1Vm11TERncHVsa0pXckJw?=
 =?utf-8?B?WjFqdFBzaEl4WjBjb21vRnllWGNaclA0Z2QzUGxnSHRaS28xSVl6OXlodW9o?=
 =?utf-8?B?Z29ucWZSS0hQL1VOeHR1UVJ5S1Zxd3BaZWdjaTNmeDZHVE9CR1R1cFVodzlT?=
 =?utf-8?B?U0F2QUtRWHVxUGY1N0syU3M0ZHZvYm1EOEZlZmdWY0dKMWZhc1k0VlRaUGZa?=
 =?utf-8?B?NzlxSEFSYXhxYUpEMm9kd1ZiVy84cThXb2lEWWpxdEIreXlHMk1COGdLNmhn?=
 =?utf-8?B?d0gxNm4rVnpFRFNWTUpIc1BGM3NKZ1YxM2M4bGpSOVl0TldaR2NSQ3dYaDV6?=
 =?utf-8?B?OEFidWJCbDdubXd6VDZueW5BdFA3ZzNtOHN0ZDdaamlWTGtHdzJPWXQxZ0V3?=
 =?utf-8?B?NHA0RWZkb01PZTdTZkpsYVJsbjFwNG5zZWZoMXdGTVI1WkxIejh3MEJobUd4?=
 =?utf-8?B?Y0lLR3NHVmZSd2JzYnlyMldDbWNTNVpuMjA4S2RDL2lrL2hSbFEvUGNVbjAy?=
 =?utf-8?B?THdrODBzZUpXY3BZT1o4ejR3NDlCdWs4TU9BVHoyUWQ0V1l0V2VFbVJHNFVn?=
 =?utf-8?B?UEpYQUFKejlyc2NVRTY1OXNaOEExNm83S2xmWmMvLzAxK1JYNGdNTXp5WDl2?=
 =?utf-8?B?NjE0eFpIVk1mQkhZdlgxSDZ2Z25HQ0FmNldrakZQQmtiNTdUMnMxcG14TWZr?=
 =?utf-8?B?WW4vMjNwRVNtZGR3UmFiQjdJc2pMeFRtWWY5Nm5pcHlKNkNKZ0xydkVJa3Nn?=
 =?utf-8?B?Q3M3T3VTZ0tYVk8xank2RDNOb1hWeTBjSWVjUXh5eXNLRUVITWYwTFg4WUFF?=
 =?utf-8?B?VnVieXp5VDM1NUErS3dXZmVrU3dzcVU4bmRBbEpRMUs4Um1ic1l2a1B5SEx2?=
 =?utf-8?B?Rm5WV1cyYTVrN0ViQjUyc2cvMDBMTzJRcGo4QjlWalU2V0ZxckkyWCtiWEFI?=
 =?utf-8?B?Q0c3Qm5mRDJUSVZHOVgyZmF3VXFSdCtSOUp4RnJXalhkRFlkUE1RclpvTmtX?=
 =?utf-8?B?Zm8rZGt2OHZtS1FRMEN2d25kYTh1Y1NVUVJiM3ZobVgxV3MzUDI0VkNsM0N3?=
 =?utf-8?B?ZzZ0RGJuclErdnJCbGVHYURsTk56N1NaNE9EYzZ2eUM1TjF2U2F2OXVVUEJN?=
 =?utf-8?B?aGVNZUZKMFFSajdkZVpZUGtUUkNJSThkdU5iNzFUWFZqdkdNM1ZQaFlPYysv?=
 =?utf-8?B?V290ZkMyTXVTTFl1YXdRTEU5UCtibUJKL2twN3V5Zm9wakk3Q2xLVmRTMUtu?=
 =?utf-8?B?RS8xYURXOXhxbWFxK0VCTHJEVDU1UjhnOVlETXJTdlpQSm85MG55ZERVdzNW?=
 =?utf-8?B?NDFUeXRJN3E1OXNBdFZUQnVIbGRJTnZGV3BuN1d0T3lIKys4Ry9CeUdudGJk?=
 =?utf-8?B?Y0FMTFJRMklUWEMvMHlUV2l3ZzNJM1kzYzZUc1ZuQXluRUNyWEFMMHREYVFT?=
 =?utf-8?Q?x1ICfHtJGTmo/0tQphmMRndc9BU6B1zxk5OvBpjn0FLR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927142dd-6007-4bb0-e9e6-08dbfbd0e37d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:44:39.2763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8qrYQxSsO2YdIFkdw8mWmBEQ7b+1gm/P7F1WefRg1cVLV8ZGDwi8QaFZPY10RoShsnxTl+GJGXb7L+7Xs3XPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

--7ot5/l+b8IWRiupg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:42:45AM +0200, Svyatoslav Ryhel wrote:
>=20
>=20
> 15 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80. 21=
:11:49 GMT+02:00, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >On Wed, Nov 15, 2023 at 04:51:08PM +0100, Thierry Reding wrote:
> >> On Mon, Nov 06, 2023 at 04:04:07PM -0500, Tom Rini wrote:
> >> > On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
> >> > > On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95@=
gmail.com> wrote:
> >> > > >
> >> > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =
=D0=BE 15:13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >> > > > >
> >> > > > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clam=
or95@gmail.com> wrote:
> >> > > > > >
> >> > > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=
=80. =D0=BE 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> >> > > > > > >
> >> > > > > > > Hi Svyatoslav,
> >> > > > > > >
> >> > > > > > > > Since the proposed PMIC patches have been accepted, I se=
e the need
> >> > > > > > > > to convert boards which I maintain to use DM drivers ins=
tead of board hacks.
> >> > > > > > > >
> >> > > > > > > > Svyatoslav Ryhel (5):
> >> > > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM P=
MIC
> >> > > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> >> > > > > > >
> >> > > > > > > Is there a reason why the two above devices don't appear t=
o have their
> >> > > > > > > .dts files in the upstream kernel?
> >> > > > > > >
> >> > > > > >
> >> > > > > > Yes, there is a reason. Linux maintainers treat submitters as
> >> > > > > > existential enemies or as dirt at least. I was trying to wor=
k with
> >> > > > > > linux but I have no desire to spend any time to upstream end=
eavoru or
> >> > > > > > lg_x3.
> >> > > > >
> >> > > > > The usual policy for acceptance into U-Boot is to have upstrea=
m review
> >> > > > > in the kernel first.
> >> > > > >
> >> > > >
> >> > > > May you point to a policy which clearly and explicitly states th=
is as
> >> > > > a mandatory condition?
> >> > >=20
> >> > > There have been a number of devices rejected in the past until the=
ir
> >> > > DT are upstream but I'll leave Tom, who I've explicitly added on c=
c:,
> >> > > to clarify the exact policy.
> >> >=20
> >> > Well, here is where it's tricky. I brought this up for one of the
> >> > Broadcom MIPS platforms a week or two back, and Linus Walleij's point
> >> > (and I'm paraphrasing) is there's not really an upstream for it to g=
o.
> >> >=20
> >> > What we cannot have is device tree bindings[1] that aren't upstream =
or
> >> > worse yet conflict with the official bindings.
> >> >=20
> >> > So the general way to resolve that is have device tree file be drop-=
in
> >> > from the linux kernel, and what additions we must have be done via
> >> > -u-boot.dtsi files. And in turn, some SoCs are better about keeping =
in
> >> > sync with the kernel than other SoCs are.
> >> >=20
> >> > Now, upstream being actively hostile to dts files, especially for ol=
der
> >> > platforms? That's unfortunate. So long as we aren't violating the ru=
les
> >> > about bindings, the intention is that we don't have device trees that
> >> > are either (a) massively out of sync with the kernel[2] or (b) kept
> >> > intentionally mismatched from the kernel.
> >> >=20
> >> > --=20
> >> > Tom
> >> >=20
> >> > [1]: There are both examples like binman that Simon is working on at
> >> > least but this is more exception than intentional rule.
> >> > [2]: Per our other conversions, I know the tegra ones are in this
> >> > unfortunate state in general
> >>=20
> >> On the Tegra side we've been fairly lax about the device trees in
> >> U-Boot, I suppose. The assumption had always been that U-Boot would lo=
ad
> >> an external DTB and pass it to the kernel on boot, so keeping them both
> >> in sync was never a high priority.
> >>=20
> >> U-Boot does only a very tiny amount of what Linux does, so dropping in
> >> the kernel DTB always seemed a bit overkill.
> >>=20
> >> In either case, if this is problematic, it's something that I could ta=
ke
> >> a look at. Again, it's expected that the device trees are different, f=
or
> >> historical reasons, but I'd be surprised if they actually conflict with
> >> one another. U-Boot's DTB was always supposed to be a subset of the
> >> Linux DTB.
> >
> >So, the issue with U-Boot and kernel device trees being out of sync is
> >that we then can't support the model of "just pass the current DT to the
> >OS". This in general is good to support because it means that even if a
> >given platform isn't formally SystemReady IR certified it's still likely
> >to be functional.
> >
> >The most strict rule is that you can't have bindings in U-Boot that
> >conflict with the kernel, or should be in the kernel but aren't, and so
> >on.
> >
>=20
> So you say that U-Boot should support only components which have linux
> driver? May you clarify?

I think Tom is referring specifically to the bindings only. While it's
certainly preferable to have drivers in Linux for all bindings, that's
never been a strict requirement.

Thierry

--7ot5/l+b8IWRiupg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV5mSIACgkQ3SOs138+
s6GNrA/7BtyIgf/Sh5eNrV+cuwP9BzuGoMB9N5B6CBO9crIj8GFNh8w2X4HKd85A
cwI1L1jcsWec5td7KDWCA7v3eGKe3U9xyGFnfSrtBGt9Crtlb8sSIt4XVRRNosXH
hpFKklpympXob9GmodmTh7nnmFDADwUHe6UBQB48dCPhzA+hJfKtASlpJetNkfmy
1okn9LA64dutOIytFZA2FJAqM8w085uDXKCUCn0HxjbDPdfRBn0lj3Ub0gEBU5rm
/rAHHksy/9zSjlUKy9kuk+U0R+1jWA1SQNdTnNkbdAetGvdc/r8unTH0Ou8wi7rd
x+hnjxohcooeuxSvRE/UPXtrkQrrhgIQNexJ9KGBGUcZkdpfdq4GdCUhKU808GBC
9v4lTdWlsZ9omIKA4hLy8n8LyjGKvfAWkWdeYpFCwRU8ycKiovjHuzNILCqiVWEJ
FFQAnqTxZg40G4+xlA7jaLIu3xbUan9C7L3u8zLJmXoj9dFOrt2No7KuM1uiCytH
T0efl3HJ+Kx1AGou6XC+kQ/wA9i6WA5l4e+UkrNsmRAw9WBJSgjrcOmhK81/Sjwf
pOlMClcoZ6eclKAk2YSidMt5NqclUg2KYIqVVOEtClcss/UwLB67eoPNgPiXBSXH
/CnfKBu/SmH9Z2WNPsoyzP3dtQRtmS5voLTryg2p4flnnLcjSwM=
=2t6R
-----END PGP SIGNATURE-----

--7ot5/l+b8IWRiupg--
