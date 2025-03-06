Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697CDC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F3281253;
	Thu,  6 Mar 2025 15:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="CtVC3pDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF288129B; Thu,  6 Mar 2025 15:21:31 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CEFB80FE1
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYEvdBvuLU+wA37a6J2hnMGhRCIRjRrc8Ou9gEbU+EBkVDcCqrqrx2yzyY1cRvudrkS97lijuX2ldiPaJ/RJS0yhM9LhMI4IBqXLZQGNHXdSBLZFhCRl2y0ZWBE8aPMOckGyi4qOYh9dQ96lGNnjPPLshYdb3Bq8ppYRtJ52qbgowGRX6FPCsSAaGwvydruimvFbKSaXm+Q/MxVYwf4GAETwunwDNFx6TUVfpeOC55K+lHILfOObGSbrG9wI+/uMg27Wu64WRDFPxY2SeiaR+CtRpMCOqKgWerPZNAJ5viV90Ttp32m8YCWSScg0lzjKMF8m4qI1vlAwE+Ur1USIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV7gz1jShN2zPfgBW6kICAUEG/23Yqmfn6ia0xpGigQ=;
 b=NgXKTco7vUmOix1uF7goz4hATkwJdCklSPx051BYMSMIJmZEVHgxJOHzNH5r8WIILzKJIkcNgCRI+biYPLnh4PKLrs66PF8XgOiTj15DLn8vn23RZI/ICNy4JMkTKw7FGwQAx2FejpKBG9Tn0bt7UBuXOfLf/k9LGRSXErcWf/jziBCmDRIYrqIf3zPszLUvnLrNyTtSnLV3bQA4pj8IFs9bvDTtIZSR9xPCrffe7dq/Y1IMUoVjFx3AKqyvcC4AVkKUJCAAouQMK1/UIJkQ3R4f2tEMJn0icDRjDqcZ1qPVd8K5df6NEmL8uOeBqORHS35l8c87TcUwdaGLfk8Vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV7gz1jShN2zPfgBW6kICAUEG/23Yqmfn6ia0xpGigQ=;
 b=CtVC3pDpoquW1xZyy4zoOQ8OuFRZkxJ48nw3Ny4qE8fKnovjdNlSAeBhzmVzc+/n2AMjBK1dFsz0tz6ew+NFvawp/nizPzF7nytfzCWmVllsTqv9oCVT2foCsXIrEATmUurWFbUxEcdgvzMFKSnqqyequ+mVhxoLuMoGiMmqPLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAVPR10MB6790.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:21:22 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:21:22 +0000
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
In-Reply-To: <CAFLszTjyJW05xpjg23B2KHMi9-tZVZhRd0Zpr3A7yfcQJc+4MQ@mail.gmail.com>
 (Simon Glass's message of "Wed, 5 Mar 2025 06:53:04 -0700")
References: <20241018030027.842749-1-sjg@chromium.org>
 <87jze5ao26.fsf@prevas.dk>
 <CAFLszThFNXxM2cWdMHWFP8NsH5x6-X9u7aWNpPokgLWRAA55=g@mail.gmail.com>
 <CAFLszThznjs9Ama40sMtnrdMhThB0TfS4usVSH+yAZw-2Tj0tQ@mail.gmail.com>
 <87pliw62xn.fsf@prevas.dk>
 <CAFLszTjyJW05xpjg23B2KHMi9-tZVZhRd0Zpr3A7yfcQJc+4MQ@mail.gmail.com>
Date: Thu, 06 Mar 2025 15:21:20 +0100
Message-ID: <87zfhy44v3.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAVPR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 169e81fe-22d1-4b7a-39bf-08dd5cba2bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pgyOUYGo32hZP+nH5KjhKhEa65MHkpGHsnFCTx8QJ+Fj5fLodRnTE+IKtkIk?=
 =?us-ascii?Q?S+MPx/Zg3h64NTJpu8YEcUXq+GtLkSmFKnObiX4nNNe0r5xb1Zhk+t1UluWs?=
 =?us-ascii?Q?6kiInb4XcW5O8hGoxS2MyeV74aJko112VuMGQAauJ8ENdDGrFAVLhB2mYhSl?=
 =?us-ascii?Q?NdH+TdkfKHea8OsTfGuxFPVPNEsIW1sXs3tD8OlcFRmWq4P2L1OeunFOvZ4K?=
 =?us-ascii?Q?AcxxzqkCYJbQZakR0dzeL2Pmf/4jalfad33hHJmcL9krCcoDEBgGJ8fJsZyC?=
 =?us-ascii?Q?SlDFUxM511qxGqNJ71mHnVYWURf/IvzKJ4bCqR5PlAzGMpJUj4wFWCUnbnyp?=
 =?us-ascii?Q?pMwTuEWKrlSz2zxlM0CEGaI6osKvafDHuUwff7K4lVWsYt9vtj2hAueHsYLx?=
 =?us-ascii?Q?IvN6+QmaW+sb+gwGMbH8p7aX6AFF3QJinUBmdz4bMFbGbpx4L0wrQRKSgifn?=
 =?us-ascii?Q?OrvIQ5jCwHA3cXVf7nhxWU/g5qrNjOUfi5CdYbws0EEibzqcsqC/Iy4SSXkf?=
 =?us-ascii?Q?Ov6CG2LSv//XJ2cTCXg8OTAbtQOs80MeAGoDKG1mUjVUxb/dW2UU+vmmln7H?=
 =?us-ascii?Q?yC6Khkau3R7l7Cek+AtfzEBvHfxfaLOJGqHUXuRpmNjvx19wQe606IrHZ9nY?=
 =?us-ascii?Q?RzQZKArY2WQQaxPQ2a0SMFb1pcxP2AWNh2DlYGfRlW6ObXZuBMieE2fVQg8W?=
 =?us-ascii?Q?Bjr0NIi66HRWmK8sNAG97bud72WzMECXpjsm01/WxA86QilQ5KocVyCSW1WO?=
 =?us-ascii?Q?xzSiXEnp61EgAlD0I1wcOHWTR/Dkno/kItL1tBRYawyh09Gz5ZeRYWtIlekv?=
 =?us-ascii?Q?Bk7cqbC5sFvGk8rgtr7ca+EJfurDGtuE8SvGt4ICB3Vfk0S161bx2Ed8gnW2?=
 =?us-ascii?Q?DSOkJzDhkRrkdCMDPKQXhwJ8IU84Y0KJq5RUNh3048/aWtKiublOKly5bgz9?=
 =?us-ascii?Q?oJD0kiZdTXxZDeWRIp4+UjpD9ed5D/VZkRIYf4dWT6F/wNn5bzX2HFkauXiL?=
 =?us-ascii?Q?B4opmU0c2IlD21WC9Y400k2wjtOz+hj+haJ1XF+zHaGyGauV/lib4/X+LiEg?=
 =?us-ascii?Q?al4k5Lzl9FsPL/i/HBLkZcKPxIw+LUc6XBNLcHeAl7fD14WU4fhRuhnltL+M?=
 =?us-ascii?Q?toecChP3mUq9Hdme+icOT/peEsvtQwn4N33ORvdeYR87r2FR4BotP9f0Rmdy?=
 =?us-ascii?Q?drM60OE0dzLCl/4eqroKblRWCSOh6uNEPDhlp09I4ONOaFqWDs9BHXJkgz0Q?=
 =?us-ascii?Q?UBvQaaJkGL67ydlcBvOFDfLLtzijJI9zWAmWszmycf4TWDpj3F+z2tFMBBAH?=
 =?us-ascii?Q?EXcGImnb4WKKd9UHUFuQzDmd3LD+dKzHaB+ZqyZj9Cpsqflko/ppx4nbNVJp?=
 =?us-ascii?Q?dSQU4GIIioxYksCxb+0mgQNnSyZwssblEM+SlvIEovM7k49TyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rjs4ZuW9I7u9lcfKv3iqPpI1j6zn53y9zAVFORPWOxhOaLBu2yOV+hoSy8Vk?=
 =?us-ascii?Q?reQa6V5E39NlADw+9NyYsAw0DB4ufpqG32JhalLFNjg2mnKl0CjvdwklWoJj?=
 =?us-ascii?Q?A3rbcR2FeQIMm+5i698gooVy4NbK5aG8bRzSTZGlAANr7T/xDvuBJlgbBFq6?=
 =?us-ascii?Q?lDtX1/Zxm4VHXNWfxjQr+qSm7nOLUBxU8Tfu27GwwheyMkzRVo7gYxAzYRQF?=
 =?us-ascii?Q?f3DsH+Up8RQB+2JaZTM917/w03zfLPCaPGoszvh4QIkPpZLcnIHyVTgcje3J?=
 =?us-ascii?Q?TkJ1H/O12egI9E+TRVDeAa4OF9zQ6+yXSeIq2ciDksvxG3tNifjfQKzQTz1q?=
 =?us-ascii?Q?ujP8EDq/oVulDYRJIM5b84+w8VKan5nZf0k22MxMC25DQU4eKZko/Ipp/4IM?=
 =?us-ascii?Q?r++vdq2xstGYgKVdiGELhbghI7R0PBH5rjX6x/jlRimrdVgrA8RE5KEMuFHs?=
 =?us-ascii?Q?dLdI4JvTTydPvk+WQOJ12im7tKeGyfeYQWD4Wtl3I8H+DIGkdi+4NsT68L+j?=
 =?us-ascii?Q?383mvRTrWs0RX4x7KMZuIY/6+saH8G/0PfWJXrP+QtRD6jUempAJ9h0znlJ1?=
 =?us-ascii?Q?4Y0qubYQgXluxOuFLZ/e4yd4eWiaByNZVUPtvT7pMvDu5s0/DOqPx94qnQ29?=
 =?us-ascii?Q?8DqwYzVotOTD3HFn/Gmnh+jN7Y2e9ZJeIaO2HIw9HrYSYg37r3Seb7/N50Bn?=
 =?us-ascii?Q?BMIjtXnx/2BZhjl/p2rVExnFpiKH3cvWiT3SlpLP0/jxmnGVj9dqDYI3NVAP?=
 =?us-ascii?Q?x8FmdKL5KAoJsx5N0yDba2AruCMUkucQ3hTp4DCd9TFo6NhS35C/SYhSvr07?=
 =?us-ascii?Q?lYYB/cx+13XSC6K5Gk0bTvB0wk0JH0jzVpqatV84k+7X2djHloUtokYA/CR4?=
 =?us-ascii?Q?3L5cKdm6x6erOnEIYmD04eoSMe1lfBX34n+/y5Nmra7+9VuZqboowDe68D+x?=
 =?us-ascii?Q?kPvipQ2u3NcCC8tfxir4JiLUSYRngSXz8A3nczMBW9lDlKOE+tqbNqFZQLo7?=
 =?us-ascii?Q?1R7crzoBg+N1nWuxugdkZmxFw096IRH7FbKzi4KwpWuRc2QzXu0uGBFNF6R7?=
 =?us-ascii?Q?inWJHEL2JlfHXalqoPuYwCYYuSaoVKwDc5VsMBq5sz7OvaMPrzFjAxmCZwtK?=
 =?us-ascii?Q?Xw91+OfXShK9NWCKPSCmVnxbl9efPDe99tfiv5ti+wCxWVNdBjvIWZqY6bCA?=
 =?us-ascii?Q?uPwb8rmTur0+eRvKskvbegiIMm2N7oe3+Rz6VJ3ApSEw2JXmHNr4YnZTLj6J?=
 =?us-ascii?Q?w078m/reEnJOED8rFAGZtRafP0T9ShPfn7NFFLkWPSpaqciSdiJKRQ5+a9uc?=
 =?us-ascii?Q?/gCb6sRJdZgN6U9yPdYUHejoO4COTPDKygXjIZwhOtlts7lWTTzHyw7PdwBf?=
 =?us-ascii?Q?ejtaE0uvmXI3iDrBqst27Q9TMLyWRRPpZrapAbE9DUUBxaPoKRptGdrEG/iv?=
 =?us-ascii?Q?pX5jGYVFpl44GNnRLH7+8SpqyXKz0+q0uRW2BzzRRwIqW8g5KbP75p9DwH1C?=
 =?us-ascii?Q?LShaD+BS/ZLLCt6A/tdoQZrZ5XvTutZTJiRNNcY7pai2OQhpdagoiP6ohnVQ?=
 =?us-ascii?Q?NGk5eEDd5qpmOuA8gglnmnd4YEa5jrqmSiSeLah4ObrSeK7d9GQg+ilLJPt7?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 169e81fe-22d1-4b7a-39bf-08dd5cba2bae
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:21:22.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nly8Fnbi4SJkgsduiuZPaRsqjSvbE93S/KFf/FgXPjk6QfHalI/zYR/7U3bRlwBs06JUFfwri1V1UOugJh2Rt1DO5lyguqoa60DXFBX0qnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6790
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

On Wed, Mar 05 2025, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On Tue, 4 Mar 2025 at 11:55, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> On Tue, Mar 04 2025, Simon Glass <sjg@chromium.org> wrote:
>>
>> > Hi Rasmus,
>> >
>> > On Fri, 18 Oct 2024 at 08:55, Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> Hi Rasmus,
>> >>
>> >> On Fri, 18 Oct 2024 at 01:05, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> >> >
>> >> >
>> >> > If you want to do the churn of renaming anyway, I suggest doing it by
>> >> > adding an implementation using the proper scheme under the new name,
>> >> > switch users over, and dropping the old. IMO, this series as-is brings
>> >> > no value (except for the tests, of course).
>> >>
>> >> OK. Do you think this series gets us closer to that, or further away?
>> >
>> > I didn't get a response to this (which is not a problem, I miss things
>> > all the time). Anyway I don't like the power-of-two restriction and
>> > you can see my other responses above. I've applied this to my tree as
>> > I want to have the tests in place.
>>
>> I stand by my earlier comments that this is the wrong way to implement a
>> circular buffer. I hope Tom doesn't pull this.
>
> OK. Are you saying that you think it should only support power-of-two
> sizes,

Yes, because that's the natural way to implement such a simple data
structure on real hardware, and I don't agree that it limits its
usefulness in any way. See how the linux kernel implements unix pipes,
and their kfifo helper.

> or something else? What specifically do you want?

I don't "want" anything in particular. I'm merely voicing my opinion
that I consider this approach to implementing a circular buffer
inferior.

> This series:
> - adds tests

Yes, always a good thing.

> - renames to membuf

While we can agree that is better than with two f's, I don't see it as a
huge virtue.

> - shows how we could switch to using an empty/full flag instead of
> leaving an empty slot, so we can see the code-size image

As I've said previously, I believe that actually makes the whole thing
even worse. Not using the natural wrapping/masking is already
error-prone enough, but needing to have two parallel implementations
living in the same source files with #ifdeffery; please, no. Do one or
the other, unconditionally.

> - does all this without requiring the size to be a power of two (which
> limits its usefulness IMO)

On that, we'll just have to agree to disagree.

Rasmus

PS: Something like
https://gist.github.com/Villemoes/332ac7a5dfc983c58ad40773c7bc6385 is
what I consider a simple and readable implementation (it may be buggy,
of course).

Frankly, the triple-pointer use in membuff.c frightens me, and that the
implementation of something as simple as membuff_avail() involves a
struct copy and calling membuff_getraw() in a loop makes it really hard
to reason about and verify.
