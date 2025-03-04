Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB071C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 18:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9EFE807D9;
	Tue,  4 Mar 2025 19:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="e/ezawxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600A1807EE; Tue,  4 Mar 2025 19:55:42 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF54805C3
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 19:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8/H4KGxk5zQsE5aUb4rcKT3Piky4wYOjRt/TRq0w8JKsErpN2wobWpOEFmKYjuQtHv+rOKIu+wdXJjcqwYNHOZzP0Lmm4Uge+XuqWkwGiQCTdCMnRnGz+j6SkNqHuYezAhzOlU4oA2S/VFqRqADskhu3P8zqArytKn0iqBHVIN+N8j/3WHQjKg9w+o3VPVfRVlHv2pXwd1CvryW2qQ/dY5ymBNhp/Anzgyj9Vd4btGg59Tig4OpjVBHeHTgt9reH9Ld8g2Gd6/emezVE53LCNDBxgCAq0bxGswQFTAoOdgR0jg5szlXQ2IcZjCXXEAfmqBEi4s4rbNTkPakCU81vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rq4JoJaswT+tKTGOEbcidKSo0sUvMvvh57KWDgfYkFE=;
 b=eTZswYoIxTr5y1WbvjZm1k2oEG7nTBoE774jzK9NWj5JYERRyEiOqJ2Ca1wYO+PFQFreUHyocUFoCbUSY1446qH+/DrY9t8n8+TrgwMJoSlE/YQ/pyRemMQTMxijl80YvLGezgTOt/isgHMHtPqkHAkGXl++caeEGfZ+6/wu5T5n/82zmNOmLMhqG4ceujBL79E7FG86BOT1XXGDnzB8pSZ2cTSltVby88wo3MmWRKR/G63N9nS3n7oi4VAgG1HazHDKNDwk7A5RGZSEiJzsgI5mZaRWxJXAuKEljJ8AMZRtT8XKHi41AO21YqKJWlikyU21ImLQOPvluSG/dPv5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq4JoJaswT+tKTGOEbcidKSo0sUvMvvh57KWDgfYkFE=;
 b=e/ezawxg89EJHcbQDFR37XWu3tpY0usRC52a0kNtDQEZiU/F8fEsV0MwTc2u+/atTxd37Xvp/9UQWiFuybQvuPwbbjOgb19vMsRnyA1mxDVNXylaCgOCHacuqGBVJaUsZ0vBmSZPqAbEWY1Elwf9n+jTvhNiNayd9LiNuxQbBDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAVPR10MB7305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 18:55:36 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 18:55:36 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,  Alexander Sverdlin
 <alexander.sverdlin@siemens.com>,  Caleb Connolly
 <caleb.connolly@linaro.org>,  Francis Laniel
 <francis.laniel@amarulasolutions.com>,  Heinrich Schuchardt
 <xypron.glpk@gmx.de>,  Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,  Jerome Forissier
 <jerome.forissier@linaro.org>,  Marek Vasut <marex@denx.de>,  Martyn Welch
 <martyn.welch@collabora.com>,  Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,  Peter Robinson
 <pbrobinson@gmail.com>,  Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,  Robert Marko
 <robert.marko@sartura.hr>,  Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,  Sumit Garg
 <sumit.garg@linaro.org>,  Svyatoslav Ryhel <clamor95@gmail.com>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 0/8] membuff: Add tests and update to support a flag for
 empty/full
In-Reply-To: <CAFLszThznjs9Ama40sMtnrdMhThB0TfS4usVSH+yAZw-2Tj0tQ@mail.gmail.com>
 (Simon Glass's message of "Tue, 4 Mar 2025 08:35:10 -0700")
References: <20241018030027.842749-1-sjg@chromium.org>
 <87jze5ao26.fsf@prevas.dk>
 <CAFLszThFNXxM2cWdMHWFP8NsH5x6-X9u7aWNpPokgLWRAA55=g@mail.gmail.com>
 <CAFLszThznjs9Ama40sMtnrdMhThB0TfS4usVSH+yAZw-2Tj0tQ@mail.gmail.com>
Date: Tue, 04 Mar 2025 19:55:32 +0100
Message-ID: <87pliw62xn.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAVPR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d86431d-976e-4a15-734d-08dd5b4e264e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jcaBfJGPsAKOjeXOx5Bj6r4vd9YSOQKwnvhVg5TR31kncuJIOJxYfCdPEd02?=
 =?us-ascii?Q?q+Q/TvanmHFXSWIUoWwNsjrgUqSWBPqbnzLuuXZxgbYXfyBsyKJxUEcoqu1y?=
 =?us-ascii?Q?Psphj1GGPTv58SAGRkMXaRaefmF7AqlWa+emZF9QLoliDpFLzENoyE/wfMFF?=
 =?us-ascii?Q?9E+YhHbM+8+tVdNJw4PHNmVlVYUEcFJAdG8ngT7nG7tmvCqZRrqR8se3//8c?=
 =?us-ascii?Q?4OKNPAZ9SVCHerhgMgKMxxwd20HkWrKGODgSyFrUxNDnc5NgiIgWiFtw54zE?=
 =?us-ascii?Q?MUM6yuVMfuHggDFhjjSl6wWCBs6z7hXN7MKqJSo77tQFKG1jKyIiESwPWm7j?=
 =?us-ascii?Q?f6BaAjdiTHdL1PgiIDtHq6ke2O3JbjiFUk8Nddg9twAFcf+6cuITNTVYHEKr?=
 =?us-ascii?Q?E74Aldvi01ND2KB9SBonCLFa5swFm9dsSrDhDYp2ZSamo0qwdhmXUoS0QMbL?=
 =?us-ascii?Q?IsrJlXPcx7HeCI/YJmhZ6l7D+UYXPBbyM7+QHjDptmqRYgy7aKUUdMbLNm8G?=
 =?us-ascii?Q?mLJG3CsQSbXoL/ZdPkYaj6flX7UNVlmz20qFIUHHm3SNbhs5q8pNuMBdV6Pr?=
 =?us-ascii?Q?ABxCkVYBStZ4HTyqtuCAwTMRkRUk2sAif5GFkR34F3vOtKFytAxAnix5WEz/?=
 =?us-ascii?Q?3gkBZd2B+/KyfMElOdNwKzOV67RSE7+DRLo9kfcEIKiXmKuSZW9FVCM+bykT?=
 =?us-ascii?Q?/zC06aP7vuQ/FgX7IHVMVWgFJNLsHaJI+2DNSw207HbrW90Qf2Z24tMz5EgO?=
 =?us-ascii?Q?7QNMjkdARgzH0hijILD/18MOjaKZfNRYeEbhDASmcUPTRzCpHC06aegaJU4c?=
 =?us-ascii?Q?8B9kee8vPZIf/CMC6tgbzvgULEMKr9aAFlp781nSrlRyjouRasPJ8JfbzxSb?=
 =?us-ascii?Q?PfPFJwiRPq1Jtau8QR1sdVdZZMSSWsWO/7nSHZ9CtDMFWlWHn62cgdg0r/v0?=
 =?us-ascii?Q?HY8QIXbPE4r2QgoAbWCER4qN5hMjZhpA7pYr7r1PyseFMhQCmAq3/B88lyH/?=
 =?us-ascii?Q?m4vTmrd9jHSkM5QMrlwRWgV/NdarMB1FzNZBTUK9NlwSFgzonq8DTHgLJHLx?=
 =?us-ascii?Q?p95QuzpUfVDZnzrMrk9tYF2tSnA6Ofo4a1mKkK7MkvTEikuYk3ORh/Y4EvSv?=
 =?us-ascii?Q?Gu3f6XnrNoEvYIh3nf8/M3fEKX54oNScU0vs55whIBG8hBecSXmbvx5bSF8X?=
 =?us-ascii?Q?MmCxGjdvkrSB/kG3qzP/kKx887OuBWWOhQPCXfFjjmFy0wucYcHIDZKoANPS?=
 =?us-ascii?Q?shuDDr3RIOayUv98bwqTLrnN/90F21Y6+GE13lFAZs1ApRadJ1Sz8h2C6elo?=
 =?us-ascii?Q?SwMHU3iclARr8cGtQPVC1bxAOs6T464RWpwfoyxhuuTr1lRvHDqlIjeCkIHz?=
 =?us-ascii?Q?nRYn1yS4f15/c5dQ1Eb99To3HZvC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmYCK5ZHIPc+5MrBB+2FYF1S8SgKyt7uKpOHWi7yrduKnzXONIZcaaHDsF7m?=
 =?us-ascii?Q?dgJoV9b4LITBjB4+RStStec6wUs4CI/JdXKWSdbFRKtToUYqka39Tc1f1MrT?=
 =?us-ascii?Q?EQ+Z1qxspUxgE+Fp234c5kbmydKf+K/ARgXYFBMOI7E3FFIGLvhtngdiO+uG?=
 =?us-ascii?Q?aHyBXLhCMP4EvyIQ6DPII/yXXaP471RtjO0i4+7eTh94lwGRAV/63s5yMsBB?=
 =?us-ascii?Q?/58OIFtXIztUPF13iOPFrfD5gPmrd11mJKP3TqeoqdlkCUUFw6R0gRWLHxrr?=
 =?us-ascii?Q?TS33uxjxwvba79y8NkUpE6wwE7BHq0JGD8PTWeN6Q3hUVfCbwSB8BsytNaCz?=
 =?us-ascii?Q?Qo0qJy26/0coDwQGZTYmjDY6Nw1jWbV782MxZxLp9OtxnKxaPU7pqZMCf8ME?=
 =?us-ascii?Q?yiY6OnFBm6ge1tqzlHD7UI5S2iFRJjiH6iaV+1w4VgzbXl1RNBcyp7qsXali?=
 =?us-ascii?Q?yteSdXBoXPRuuFinyPdIWQi6PiSahTN733G16WzHahujDpLq/dDYkhOkUMBa?=
 =?us-ascii?Q?urUGBK7/dojMFshmkdjbhM+XcchgSyVXGvnzi4vicJaSEdyGyiq6iCmURA4Z?=
 =?us-ascii?Q?Wi81ZAvB63n0vV9DQYo4q8ijHN41EYrAPHcPGEy6oyHbfxhNHwYj9IK37d/B?=
 =?us-ascii?Q?+VORRLZCMPLA7LNgz0TiIxYROZJuE4vv2w7jnYJDkCAy6+UuXUnWTVwRXU1I?=
 =?us-ascii?Q?5gA/GtuqEpVAqOq0Jj+bWYX01NK1sq74huKS17XnxXFNklETr5aO6icKdo6q?=
 =?us-ascii?Q?iMu6eIH7eIvnDYXmpPIebiLDMo2BkDDgMX+g1yfkIXhHWqheRtJrPPLMvSKl?=
 =?us-ascii?Q?U+o/Wm5Mco/Ad1ZTjMgXcnNlm1Zpuuq1m/tscViEHDRN+KP6Qzwxhot3xgs8?=
 =?us-ascii?Q?cNsFxa/Y5/nINmdv3iSglroYOrf2qcivj5fMmfe0v/k7S+QLP4Bnmd/MtoeR?=
 =?us-ascii?Q?1VEx+iyJlnx/akQxwp6glQF89Mjex/7KJCL1gasmE7L6OEmqM7F5mrjfcJLJ?=
 =?us-ascii?Q?TWKrzszHS3lMWJKRBxhRI2zXBQ9W+Am/92tx+ZmSXfipAF4plWSrNMToNvcE?=
 =?us-ascii?Q?dt0+MPl43o5E8H5NsCZKGLZghbI1FJBH0Ma0N4xVbR5BeJULu5LYiqH0pXt8?=
 =?us-ascii?Q?YHZNYXqzeXOuPm2Wu6ALSD4ESBiNnFKhuEbC3Cp+P28l7la5ferA1o+S+C/A?=
 =?us-ascii?Q?mOQODci32EUrQDglF6bUhBKOnZq75BLePG3FYVu8+h8X+/1giz5R26bRP9qa?=
 =?us-ascii?Q?NEtpYUnCRyvGO273zww08SyPCBRYmE3fAiQ0CR1pjtqoMX0lbPvxNhvKVsh2?=
 =?us-ascii?Q?QDpQV507bgsHt/m3Iz27KvUr4NfWRfyUCSJ6rR0pVR4iPkuFAh7Za9GiOPqM?=
 =?us-ascii?Q?G3Kct0SBXZk4P9sBHCAP/tdavpsCUqtvP4Z2wWWtX+Leliexuo5pi6G7XsM6?=
 =?us-ascii?Q?LwIf30MyzcQ9htYUqgSFlID+wcyMbX7l9QHfpIotX8JPlMFWw8w/GMVhUUvX?=
 =?us-ascii?Q?Y8rJD+wkgmijqwjMJQG6tD3QUnpGTFldYesaAXtecsZphVmVVKnM5Z2COtTl?=
 =?us-ascii?Q?PXR4uIjl1SGprMeLK9vEhV29QuFZnBEZLHLIhwENZcVA/fAo3g9K9AWI6NuJ?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d86431d-976e-4a15-734d-08dd5b4e264e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 18:55:36.6547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfVdinOHd7HhUWA4d7Elfub+dFsRz4HWAr5oKbwZ9Blzbp/MGIn98yI6Hj/JhfLTVxdqzEs7sN82OfUGoxLumYT9KoCNBg1w8+Mm5/NDQxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7305
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

On Tue, Mar 04 2025, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Fri, 18 Oct 2024 at 08:55, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Rasmus,
>>
>> On Fri, 18 Oct 2024 at 01:05, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> >
>> > On tor, okt 17 2024, Simon Glass <sjg@chromium.org> wrote:
>> >
>> > >
>> > >   membuf: Support a flag for being full
>> > >
>> >
>> > No, that is the worst of all worlds, especially with it being a
>> > build-time flag. The right implementation is the one where the head and
>> > tail indices are free-running, where you get such a "flag" for
>> > free, because you're not wasting the top bits of the indices.
>> >
>> > https://www.snellman.net/blog/archive/2016-12-13-ring-buffers/
>>
>> >
>> > If you want to do the churn of renaming anyway, I suggest doing it by
>> > adding an implementation using the proper scheme under the new name,
>> > switch users over, and dropping the old. IMO, this series as-is brings
>> > no value (except for the tests, of course).
>>
>> OK. Do you think this series gets us closer to that, or further away?
>
> I didn't get a response to this (which is not a problem, I miss things
> all the time). Anyway I don't like the power-of-two restriction and
> you can see my other responses above. I've applied this to my tree as
> I want to have the tests in place.

I stand by my earlier comments that this is the wrong way to implement a
circular buffer. I hope Tom doesn't pull this.

Rasmus
