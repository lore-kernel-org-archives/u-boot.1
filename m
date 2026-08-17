Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C62C5B572
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 00:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DB54810DE;
	Tue, 18 Aug 2026 00:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61orAzL3YcHm; Tue, 18 Aug 2026 00:36:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27CC181091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787013368;
	bh=mbTnE2tLNkRZwNyw+2gF2vmNtXM+Fd715UEIk6O9plU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a7Y+waHvuMrxQy7WLFuJF8UgTccOrkGgrqtM/m36dqWLrNtGTAQfssKF+PYHNoWOe
	 Prmcu35NemSy9/0JxNxErXqh06YlsNE/51tghWMTleEKBGOG7y7+e7BxLXKg45boDb
	 OTWB0tE1Kg7N/ElgX+n1l/9/AhL5m0VUmFzLkXPrbc1dE9hI5FwGfj5MPgt3YuNHTy
	 bl6q926K39685KbhxUN4QsOvGjoQyNmtpwAGFj8c2OdhM7ds7MvSGPy06FF1h0IT9H
	 hDYOe5rMFH2t3zdIKoqtAvSAq2dzP4ONQilBQJSdoLNi/ALDapH02ian7TPt52bSlj
	 DK4fbGkdl4xKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27CC181091;
	Tue, 18 Aug 2026 00:36:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57EDD23F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46CFA4008B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTE-FDhjAOIT for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 23:10:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:d100::1;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=macromorgan@hotmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 54C744005E
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54C744005E
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=RaN1NVZM
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d100::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54C744005E
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9R/oLgU20XSxwD4rOarCVj2xAvdhrUheRT3gNj6pjXNj43tintDEbrpETLeBnv0Agy+ItIWaW1us/NXkH7qVuSaKppXQj0QapxxessVAE9XIYQg0pu3o09dDPIHn4X0xsKrn+l7+Cync0F6UOTBcl635uFVdAalF577sjCV2A5M+KxvMBY/0oesnK6H5cSFyKRX9PKIc8hzFQT7wariykx+0vwbDd9c/TyLDyfK7kL7LdUKx6z+TA5aKScM7jFfVz+c9a8HBAs4aVgKvQOwP5oQ6/vwDNO6kMAvx8AJfh/B6jWDXB4FnQuj8J5zE+ZeDn5piyzVve39/8PPSt0Bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbTnE2tLNkRZwNyw+2gF2vmNtXM+Fd715UEIk6O9plU=;
 b=lL80RiRQNZeA7dWEXmLTB/fpg7y28yJ50SoAX3ZjnlfUCNPRMO3+y1pbYY1qFhjlx7AjTih6d5p9rnaW5RhaJxVU1xx4iu4IyT6V9nX2gn9Hqhrfju9fr3Y6n/LWts0fs/gN+iIfX/Js0lSx8XX8faNNt89r7FtwcCilpKDrhuG6Fu3e3vJqPhmFY2QT8HI4L7/ueowV+JUMpYFGBZa1vN6uKLIBoW3S9MIrRNMU+U1aAGWx8a0qTWI3zfBXe7gbj8VU8HWNAI5UBM7+q3nPVnT3cpsmtmwTlR9Jp8yIYK5A3+hX9Ukt/t/t+4QFER3BN45h8iPxO7wmJnUg26hP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbTnE2tLNkRZwNyw+2gF2vmNtXM+Fd715UEIk6O9plU=;
 b=RaN1NVZM9gHF36nUn8DgvOa12YjNrqScItLALgTI+2PGSHHHNa4NrZ2tGxV0G5ddU1J5zt4DBWwak1eTnDyNvZfLYOAgI8jpMn6sIpopb2sjbvtlr2XsusCzm1Z6YTwxg5G3L4rDosXqoYljXOm0VcMypqukhOLbhgcXqlaqx0TWtn2ehHuYLqmj0Wbznlu9yd34WxJv70/S5CZQpl8SXYIOplq7/xu1TIfZD1uMkwE5xZFK3Arx4nc/RCzigm4UHDY1LiIJrBsQfd2xoelYwtWN4P8JhNX+SskOT0FMSKCUGZft7N4ZHYwdzjrktafWXIIYKeI4zvmfxIO8DiwkGA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA1PR19MB8845.namprd19.prod.outlook.com
 (2603:10b6:806:45c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 23:10:04 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 23:10:04 +0000
Date: Mon, 17 Aug 2026 18:10:01 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Daniel Martin <dmanlfc@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
Message-ID: <PH0PR19MB9973381877D494D491EBAC9161A5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
 <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
 <an_Wqkp09sxijfxv@wintermute.localhost.fail>
 <PH0PR19MB9973381C3D06EF7593AE50C56DA5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd0QrejH5tR013FDOpMJu27UXf2BE1t87f9Skxm9uyLC8Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOyTmd0QrejH5tR013FDOpMJu27UXf2BE1t87f9Skxm9uyLC8Q@mail.gmail.com>
X-ClientProxiedBy: SA1PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::14) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aoOUydRP7FS6-KI5@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA1PR19MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fc4cf2-b92c-41c2-50af-08defcb4ab9f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|25031999004|37011999003|12121999013|5072599009|6090799003|25010399006|23021999003|51005399006|24021099003|55001999006|15080799012|8060799015|19110799012|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QxVJ3fpduam2HgfSbJ1xGBv1kf7FyBVbX6acYNMJH+J6uhLnXPUTHdDJKfFZ?=
 =?us-ascii?Q?PsP7MHdMj+IrxNziHYjcQk0IJIw7hFqCu1Tnxe5URlntg8yRkhB0mtflEkoA?=
 =?us-ascii?Q?beUc/t6h/0mM1RfaLFMtnQ5unI7tuQe5/AzkhXcCpG23dMJtk3jRKfdMPmBB?=
 =?us-ascii?Q?rx/jrbYT8QwZiaEh/utLq8Q9meZFhsc9+U4NabS1OaZPpAXw9hrsjA+lQUzD?=
 =?us-ascii?Q?HmDXO1HOUsZPW5mPj/KNs9Dc+ohC1ne1vObUdH6eQiOB5utf1hzOP8ryr77A?=
 =?us-ascii?Q?2iMg9hV5BlLft3v8dSqMF6/Ir958kpJqr3bX+Q5HJOEgOmzxiOqEhBoB/HlI?=
 =?us-ascii?Q?3ekW6FwHQ8bm3dUck6ucr0xa6jMDlRoT/ChScL2gfLLS22lqNzFgOICIyA8P?=
 =?us-ascii?Q?BzX41+pJ3h3YhG+qG38s7dG8Bismj3ChcFA/ptRYT9FCg3AsY1Lib27ghz73?=
 =?us-ascii?Q?T360H+wHUt5l0u5C6KXjL5J+jZYWo6DH7CKeSWBInxPmvMh/dpD/INo4pAJh?=
 =?us-ascii?Q?/RYGaMb/eV74D5APWH8+Xipkalc4rRA/BM7EZQKaSeNmsLyL3rV+M43cnc30?=
 =?us-ascii?Q?lbl0rfwvJ536kNc6mk4P3XQ0SUmy+G/PRF4oUQmTbjndyDMc/x7Y0ddjIf8x?=
 =?us-ascii?Q?gCRbqn+zmkJ62YiPaB3/jvqFdKQ8C93jAq9I944I+eWREyRJMPDLijsjofMS?=
 =?us-ascii?Q?lv7Lag18Qsf5y9sNAmvp1kdimMloZfFV2OBJ5Q65Llx4+d18+R3Xja7N47rQ?=
 =?us-ascii?Q?BEvEZe43+aW0Mf5XsdNhSVVkHhtPTqHw0e6kIGvnR8MrDfJB6fjwpSo5vLU4?=
 =?us-ascii?Q?ZEy7HmuiblChkwOqVASZItP+cmM3JB2d+GbRo3ykN/ZSHJ7FamkABDTEGof+?=
 =?us-ascii?Q?aU7diAokZrU+r+anLdxcduaglJ8NJiS0NOjszYSqqY0qd8K3M/FAObintQwV?=
 =?us-ascii?Q?DLDs6W1wwLgigC3sByDNoIeHjt3qocN1vsgpmoHe4oRPpWqCpGDvieT/aJXU?=
 =?us-ascii?Q?QRBQ0/QM4LnyxrFMr3oEk1DJzuQYfcj/NDr1Kg730Kq+0u2tPoGjm4izvFyG?=
 =?us-ascii?Q?TygxuJNKp0p/4PkEPQ39Txm+D9tU5Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+OQJk0NHMNFo2tbqIc76vNduOQ6B3/fZ7UqRhq0z1kFf62esMFA2psjpPcO?=
 =?us-ascii?Q?RJ5dSF2abrWuQVoK34p5lN/IHeTJq8HZbvKMoCczxn6dHgb0V4Z9fW706tiD?=
 =?us-ascii?Q?R8d6t9gTHuGBbbNF0odXFWul9rWXLRioZh4CghtyPcwkOsMTbZiT6MdJF3K7?=
 =?us-ascii?Q?BifeS+4KO4Zucr0RjY/X2JSeV40pXTuLKdssGjevU8d4mJIEifqAKCK/xEGd?=
 =?us-ascii?Q?bvXtDqMuuVjq2gnwCWLdSdSMJbdx/0R+Vvno5UFFybOUltw5JaswGh+JxmIN?=
 =?us-ascii?Q?MpnFY4fJxtXnOD8hJNI+P0FJXREOVid8Oqq1TgSrpXCIOUb6JVTz9cIBx8T3?=
 =?us-ascii?Q?I/04HCSwB4+ywBAaRwBAsbOkdoGuuXDRMzerFbssHP6gNNw/fQPuduQGk6Yx?=
 =?us-ascii?Q?8vqX3guoZhdOsKjfngvuI68kXG0BOoTdbQt8rrW2K594In2mJGvg2dQv6ca7?=
 =?us-ascii?Q?BXe9QCZHesDn5O/phBnxpJb2VQ5wWGtlsRhulfiQjK2wctdJkXAf43GmiNgg?=
 =?us-ascii?Q?svFIDFAVa15r6mv7HACe0xsS89RYFaeTFm+qST13gBeNpL9zRe7dmi5kFsxK?=
 =?us-ascii?Q?WXBouTVKcwCwwzXUDLhOZTpK3PdgJMTfa4CYyFBcbxOFtCxjdUGRDTlZ1ZML?=
 =?us-ascii?Q?pM/I++sQBp1HYy7HhpZe6M2xPuMSQuFSa+sDieyVPct/g754DKJWM0PohJrA?=
 =?us-ascii?Q?k4oo8rCzBveuTBifhfBI/wDlo/ksW3LfsGNhyX8HoSI01Yag38vEQ54dIj28?=
 =?us-ascii?Q?thj0tA4JidJB2dI7pZ0kpkYek1XL/RD6NLFyh+g6oM73vej1/WGpWCbGYiNW?=
 =?us-ascii?Q?ro1ZSYgKY2qPQlm+n19jPlFpUdt3sYMAEGanmZja5OWHFSDMqGmR9B7Gj0cV?=
 =?us-ascii?Q?hPh8Dq0RQjK/HcqhgpIr4450aToPL481fc9A0xf/yK4R7afQDdWNy20VRozp?=
 =?us-ascii?Q?rhMpOi2nWP1yJ9Hsk1paryBl1hdh5prRgbjOuOevhtznOGX2zFSeZiLYaPF1?=
 =?us-ascii?Q?IZNMFVdYREhc4aCsoLCTQLlaM4eyXS0WpkXyJ9hEntMa1Giye4sZxWa9Eh74?=
 =?us-ascii?Q?7W2ORSIvJSxGpXby7Z9nxRVTzjq4k/2OeD1meZ2WFuexwwhdWUZjh/ZGm9t5?=
 =?us-ascii?Q?TJOYHirJRTXvU7m0jlb8S3mzILwWoTcvrEMasCSiiDYpzylNhUf2jC7vGlfz?=
 =?us-ascii?Q?RifCvImxDjxBpKV6VKZpmEskFh5lVAaFHMx/q2/e1De1CJr8HHxTwEH/Q91Z?=
 =?us-ascii?Q?we5WHHwAkDISDGwU8AuDLL73JFZdwspct0Xr5AW3mnh6VDSDiWowcnlHg+Uk?=
 =?us-ascii?Q?h/PIYHruj/IUH/kQ5JC0DDHHJnOeDXPB3x4+5yEYqie3Jk/wWOEDxZCY0a61?=
 =?us-ascii?Q?jetWY0d1De4D07JeqnisTIxHDXcbMenXaiEG2zR73TctKPv+Qw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fc4cf2-b92c-41c2-50af-08defcb4ab9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 23:10:03.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8845
X-Mailman-Approved-At: Tue, 18 Aug 2026 00:36:05 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 18, 2026 at 09:04:31AM +1000, Daniel Martin wrote:
> That's great, thanks for the update Chris.
> So maybe I'm missing something...
> I didn't try `Arm Trusted Firmware` but I used rk3588_bl31_v1.54.elf
> without Optee.
> Does it need Optee? I assumed not as other RK3588 devices don't.

No, it doesn't, though I boot with it anyway.

Note that in digging through the code again I *did* find a bug and a
possible issue, though neither would stop the device from booting
successfully. I'm going to push a bugfix soon to fix the following
issues:

1) CONFIG_TARGET_GAMEFORCE_ACE_RK3588S=y is not set in
gameforce-ace-rk3588s_defconfig, but it should be.

2) Since recovery from the internal eMMC isn't simple, we really should
set the default u-boot,spl-boot-order for this device to *always* favor
the external sdmmc.

I'll push a fix upstream soon to handle these two issues, but neither
of them would cause a boot failure like you have experienced.

Thank you,
Chris

> 
> Let me try again on the weekend with ATF & LInux 7.2.
> 
> Dan
> 
> On Tue, 18 Aug 2026 at 03:34, Chris Morgan <macromorgan@hotmail.com> wrote:
> >
> > On Fri, Aug 14, 2026 at 10:02:05PM -0500, Chris Morgan wrote:
> > > On Sat, Aug 15, 2026 at 10:06:23AM +1000, Daniel Martin wrote:
> > > > Thanks for the further details Chris,
> > > >
> > > > It would indeed be great if we could move this device to mainline end-to-end.
> > > > Let me know how you get on with v2026.07 and if possible, test your
> > > > DTS with the stable kernel (7.1.8 or similar).
> > > > When I reverted uboot, I encountered inconsistent I/O issues with the
> > > > latest stable kernel, therefore I ended up going back to the BSP.
> > > >
> > > > Thanks for all your work, we appreciate the effort.
> > > >
> > > > Dan
> > >
> > > I've just tested booting the device with a completely unmodified
> > > version of Arm Trusted Firmware (checked out at tag v2.15.0), U-Boot
> > > (checked out at tag v2026.07 and changing nothing from the
> > > gameforce-ace-rk3588s_defconfig), loading Linux 7.2 (tag v7.2-rc7) via
> > > extlinux boot method and it seems to be working. I do note that it
> > > seems to be slower to boot since I upgraded A-TF and U-Boot to the most
> > > recent releases, so I'll troubleshoot that some more next week as I try
> > > to install a fully up to date Ubuntu 26.04 on it.
> > >
> > > I know you said it's hard to get a serial port on it, but if you
> > > continue to have problems booting it that might be required to
> > > troubleshoot it further. Otherwise I can send you my binaries if
> > > need be.
> > >
> > > Thank you,
> > > Chris
> >
> > I'm afraid I cannot seem to recreate the problem, and I'm going to need
> > a serial dump of the kernel logs. I'm sorry to ask that of you, but it
> > will help further debug what the issue may be on your end. So far I've
> > tested using a mainline kernel (v7.2 checked out this morning), U-Boot
> > v2026.07, Arm Trusted Firmware (mainline master, checked out this
> > morning OR the rkbin version, rk3588_bl31_v1.54.elf), optionally with
> > Optee (master, checked out this morning). In each case the device boots
> > successfully for me running Debian 13 (Forky) with my own mainline
> > kernel.
> >
> > I'm going to test installing Ubuntu 26.04 and fusing some OTP keys
> > later today, I'll let you know if I encounter further issues.
> >
> > Thank you,
> > Chris
> >
> > >
> > > >
> > > >
> > > > On Sat, 15 Aug 2026 at 07:40, Christopher Morgan
> > > > <macromorgan@hotmail.com> wrote:
> > > > >
> > > > > I'm having trouble with my usual email client, so I'm sorry if this message is formatted weird.
> > > > >
> > > > > I have tested the device most recently with 2026.04 with the default defconfig options. I am using mainline Arm Trusted Firmware though, not the Rockchip versions. Using Rockchip's A-TF should work, but again it's not something I've tested. I can note that if you're using mainline A-TF along with mainline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PARAM=N, otherwise the device will fail to boot because it won't protect the Optee regions. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is optional unless you use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_PLATFORM_PARAM=Y).
> > > > >
> > > > > I'm going to test the device next week and see if I encounter any issues with it. I'll report back if I find out anything weird.
> > > > >
> > > > > Thank you,
> > > > > Chris
> > > > > ________________________________
> > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > Sent: Wednesday, August 12, 2026 10:22 AM
> > > > > To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.org>; dmanlfc@gmail.com <dmanlfc@gmail.com>
> > > > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > > > Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
> > > > >
> > > > > +Cc Chris who maintains this board and may be able to help.
> > > > >
> > > > > I somehow didn't receive this mail in my inbox, here's my attempt at
> > > > > quoting text from a mail I didn't receive (and it's also not available
> > > > > on lore.kernel.org...).
> > > > >
> > > > >  > Hello,
> > > > >  >
> > > > >  > I am experiencing a total boot failure on the GameForce Ace handheld
> > > > >  > console (Rockchip RK3588S) when trying to run mainline U-Boot
> > > > >  > v2026.07.
> > > > >  > The device fails to initialize or display any output during the
> > > > >  > initial handshake.
> > > > >  > Unfortunately, due to the tightly integrated form factor of this
> > > > >  > handheld device, it is exceptionally difficult to break open the
> > > > >  > casing and wire up a UART serial console to capture early boot logs.
> > > > >  > The target operating system (Batocera Linux) environment is running
> > > > >  > the mainline Linux 7.1.5 kernel.
> > > > >  > Given the complete lack of visible console output, I wanted to check:
> > > > >  >
> > > > >  > 1. Has the GameForce Ace board target been actively tested with the
> > > > >  > v2026.07 release?
> > > > >  > 2. Are there any specific or updated build instructions, BL31/TPL/SPL
> > > > >  > combinations, or proprietary Rockchip firmware binary requirements
> > > > >  > (rkbin) needed for this release that may differ from previous
> > > > >  > versions?
> > > > >  >
> > > > >  > For reference, the build configuration used was: gameforce-ace->
> > > > > rk3588s_defconfig
> > > > >  > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.21.bin /
> > > > >  > rk3588_bl31_v1.54.elf
> > > > >  > Compiler: GCC 14.3
> > > > >  > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
> > > > >  >
> > > > >  > Any guidance on known regressions regarding this target, or
> > > > >  > recommendations on how to isolate the stage where it hangs without a
> > > > >  > hardware UART, would be greatly appreciated.
> > > > >  >
> > > > >
> > > > > If you have a known working version of U-Boot, maybe start a bisect with
> > > > > that commit as good and 2026.07 as bad to isolate a commit that broke
> > > > > the board.
> > > > >
> > > > > Cheers,
> > > > > Quentin
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Kind Regards,
> > > >
> > > > Daniel
> 
> 
> 
> -- 
> 
> Kind Regards,
> 
> Daniel
