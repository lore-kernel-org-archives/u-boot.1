Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A893C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 12:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBE782C55;
	Wed, 18 Jun 2025 14:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="V3Bl8Vec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C4A82C84; Wed, 18 Jun 2025 14:16:18 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A31D82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 14:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iixFWQoLPwYc4FfOUrATP+FYmuCbeDDB6tVIYZMyIHD4Aj1J+NW5jFdMGub6evXg0mDDTSKj2IRWJRfYbPLXFgH/42ss1kFrDKbB7xhIxTmoAqgsioE8NmAu3LwnzUezRKCDk6zw9NsLXzTkrKEjxE6LXVaPzewQj7aM8UHADpa1W5gG8Iao4FYYJgfJ5x/fgJLHi89rkReBrdAb5XvIuXjgcrsxczlaVmMLqnhb72XnO40LXKKtdL7QVp9d2z5lbagY+LQBZqrH/XFIURC3ZLkgXgnxxeod0Q6Y3hWFzEJOsCNksSep/yz43gBlQALkiyWjAo1MVPrNX8+CqzXzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyhXKBPLAsx31+JDaTK7lEjDx7Lx9+rmKTFYpIRaztU=;
 b=AGNsZU3QvgG7tRZ+z9neLESnTH7Vc5bxawiyKlAgsK+kOdMl30NPXZ9dk6CbiU/lNrzlPwrBZCjjZLRset2dsZiKftYFmbsMHPnydcObY/NO0rfIM2KF6/j+coEeuc0cvAz0v0vhjfGkswIoeuE7ea2lhfNRC+7+76fB2HxYXxuJQL4DiIyyexQBJz37EVbH/KSemuXaRDK8qYNM3ImAwh5BMOO7q9YcS7DU9QrIITgxG3vrteX9nAsn28KRtizsIH/eIsvd62vO1GYiv+2yHOktAcbLythnvw4Z9cQVWptSM8fRVkOAfqTfvih1gKxeKIekzzytjUAykBE70GgoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyhXKBPLAsx31+JDaTK7lEjDx7Lx9+rmKTFYpIRaztU=;
 b=V3Bl8VeceA67Qx0hV22PHaMvSGx35qaKVbXAgURDo+EzoE/T0B7btTELeZsZMkzmNRSCfqLcLXRHH9G5fsgDLhwTeB00iQY8w+yXU0aimuaNUKk4S8mbxvFtafxGavua3xXjWmkz/npFJ7rfjqV5iHu+iVmuF/ez8Mgpqj2KyBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5629.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 18 Jun
 2025 12:16:10 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 12:16:10 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Mark Kettenis <mark.kettenis@xs4all.nl>,
 brunosampaioleite@gmail.com,  u-boot@lists.denx.de,  probinson@gmail.com,
 mbrugger@suse.com,  clast@prevas.dk,  brule@prevas.dk
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
In-Reply-To: <CALeDE9O9-L5hKjN7cK_-EY3Ptn77DX-PUtp4zapRQ3jcXVx4jg@mail.gmail.com>
 (Peter Robinson's message of "Sun, 15 Jun 2025 12:05:54 +0100")
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
 <20250505134843.GK1261075@bill-the-cat>
 <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
 <20250505212816.GP5430@bill-the-cat> <878qna5h8c.fsf@prevas.dk>
 <CALeDE9O9-L5hKjN7cK_-EY3Ptn77DX-PUtp4zapRQ3jcXVx4jg@mail.gmail.com>
Date: Wed, 18 Jun 2025 14:16:09 +0200
Message-ID: <875xgtz1me.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::22) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e8557b-eb81-46e9-d4ec-08ddae61e8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V49U+LuPlotpScQLeH1G0A1wMbLPbFc9HNJBDZbfke17lJlMmcUyx7SkPIor?=
 =?us-ascii?Q?BRFhRZuSHGpaIBmi1cRQj6kWO+hBYFhexEtiEtUqlO3bLKkHRouHw0+GPEF6?=
 =?us-ascii?Q?T2lRlHPKoxTHF1atXCuPLB6IssWf8fjqB+9/sJoAKsgAqEAXK3DDauK8n+bq?=
 =?us-ascii?Q?yR+7PFCI/ewzkvLYESqc969PQDGa/AJKhatvnZQgOLrlKVmahvOD60u7z23Z?=
 =?us-ascii?Q?mfQLIfK1vRVXiCif576L23mMSaSwRtzUYqJCDTSDy5zZWJgWog+xAzXL65SZ?=
 =?us-ascii?Q?TLrBU45CLde4wjcXTNxwK2McyiuMzkQ5sNaAVsK4wBOFIOPAYEx5jgRxy3cQ?=
 =?us-ascii?Q?Flpf+ZWPuYmTJdetOEyYU3V7IdYfrPSR/aJ5d9jVp/XlNeaP4LZNxK64LNQn?=
 =?us-ascii?Q?1/PclFtK0dustZzlVWo5u2Ilc/QW4w/4CTFRMJSkD77EvR4932e9YjW2Njcb?=
 =?us-ascii?Q?f3s5WVULhWqyADv9eLLFqSWp5aQtvaeTvJNiGEMGzCYUzZniXZ44lyru/CDo?=
 =?us-ascii?Q?e79rISbjsg7Gf3AA/CRO0DeXEK8bnuss0j3U+PYSPQvuUPJYuP4yXy/j36V1?=
 =?us-ascii?Q?f39QUGjycqyFBiOuAmZnPs35IAwrIs8bwA8ZlGuwQ1seYKqbDyEKQIFUQqqa?=
 =?us-ascii?Q?k96WpGpHJH7NJMbxlN43l8WuSk34Pg2z8Q9xiVv1YNAaedTSSLLuAdk+a5cQ?=
 =?us-ascii?Q?OrOpmDF8OKgZj4zlwYpack7keawZJ2x2JUaTwltUqLFZ8AOWop896P/E+gT4?=
 =?us-ascii?Q?d96xxfpSvbP8zpxDmxMZUP4zUjwHrb2W2gVvi2agsWYVWJF6q6TAZM1weS0e?=
 =?us-ascii?Q?GALV0JHb3cFR1Iwfsin19lVqddb1FF0o5RH2hSwZdQnuOvh8ffEG+k0hEw+f?=
 =?us-ascii?Q?qLEcxmjDojaCMx/Gun8fGPUvD4EJ0LIDvQyGiHxMeVO5cABz1nWpC+5Q6Qdl?=
 =?us-ascii?Q?rXcVznOtlKInOZ1RdW3e9EGa3YIpwkXpwCg6ujaNPNm/g/7+qqoiTF6HrOX5?=
 =?us-ascii?Q?s1aDpWuT15E1yeBtsU+OdhZf/CaIKQdMm0oUUdCyYaJogXrkEmr5PX1t3wrq?=
 =?us-ascii?Q?fVdpChFNhtxLvsSIsmvoBLSJ90TbqPHmFYjq/YDgff7fDpW2YCvNMwq9XnA4?=
 =?us-ascii?Q?UC/N5wyZIKd8ttUIvrjtWdhg699uR9FwLxEMH9JvhChWC6XZND2yg+cLesHW?=
 =?us-ascii?Q?t2RcxRxzVDlUtnIpay2r2sLD4vuKKPUfjP4WjnyHrRAcc29cV4kSJbSBVY53?=
 =?us-ascii?Q?eemY7CaSWWsoqkdRe5/2Du06wtWsEB0bEn4sPxiJDdQ6bgb5V3bUmyJlptae?=
 =?us-ascii?Q?X1hT0OkieC0QA9kq0Z+Wahf/RIN2VA4O+lVXqFMXfgi8jtKCIqXDJghb3SR9?=
 =?us-ascii?Q?L2XTbQRLSIvT1hKf6Y3e8P9wYDBMt36FeWl72Rty8oC+3YFpx/cBuUuVvh2Z?=
 =?us-ascii?Q?77zkZ0VUphhmsEb7qVxJrYHoqpHDl+Wu4hSiOvGNT+Y8G9lZbAA2aw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pYAiI8XV5r6ESbzmLgwUd4V4jlez5ZV5cdnFlHLF0UfQBbGmOktEWmz0fsX+?=
 =?us-ascii?Q?7rCwAzBG1vsjQi7kVDqiIOXZP1d5xl1SDM39Ta8YJd2P5ZMJPwZSX1wWgC/p?=
 =?us-ascii?Q?6qnHfTIznLE/BO6KADXGFQoSziyHBcv06fBa6VKqoJCM+pyJBZmxFso2HBBC?=
 =?us-ascii?Q?DrGpih7pdQJGqoOF2icW8LFl+NE+bcd82ODKSO1hguMm8vIUhIQBLp/dQBzy?=
 =?us-ascii?Q?poZiJUUaMyvvcX0jLHgjZlMnuFi98iMo3wGauq0awqb+MzYderoOCSZzcnk2?=
 =?us-ascii?Q?ROcFLoundHtiq7Ox8D7HUxtoJGyxB1lrLR5zYTiAtW6yYWaVsRKK4DkS6CYs?=
 =?us-ascii?Q?eaVhWJWE+CQZEZjZEXxwtsrIRrQ/vUzNwdS2MIEVV8gSScX/YFQfK1tX6N/H?=
 =?us-ascii?Q?4bDpH3Vx+l+AZAEJDx54yLUbFxpeBs49C/3SKIp4KPkOFRstBhmUFBk0E0ij?=
 =?us-ascii?Q?4SDwM3TaBHTklcJN0JdOaMMU+hHsrc2VuxfofCbbRqqb4IUqHJ0fjMNH/5U1?=
 =?us-ascii?Q?l84YkaVHp6RcMx7ZAAeFbC8NSDEzXESiX44TfbY6nzUDn3apjFaUYfH3Uh1C?=
 =?us-ascii?Q?N1Ergk12Hqeu9SQIZfFPdB1G54DtBrP2NBNRrSf97kW5CnojmT5p5rTWtXNp?=
 =?us-ascii?Q?Of1EYgJaguI6V9bqnwOgR/GywQfmBhuJHIqvE6+HKshuewu8LK23Gjc3F8/4?=
 =?us-ascii?Q?1uvBZy59bXFemx11PMR3NInS6dsSmUftiKQ8sM7F88lUicGnphqfUtL7r/5l?=
 =?us-ascii?Q?tuT5fUglFn6KLhKcIWjkc0sXHPn6/+f6K5QV19AhxCHeb57qZ82qROeXs/TZ?=
 =?us-ascii?Q?6SGt/cFtFUiAGlVZq2Baf0jqsffbAjupqVHpfC30qqsTO60xkJJjrPpQRhA2?=
 =?us-ascii?Q?kosG7CU0cZA5/DtSgkwGsVhfHOt0maDTeN/O86atH5HmefLDH1SDj+OOgf6j?=
 =?us-ascii?Q?EVHq4peAtpPPyVdAPToJlDLvO1BOZBKS86j3uwOPDCKt3tQ4NoQe6ZFj4Nro?=
 =?us-ascii?Q?ouR17mkQWRtd9diwQiRi6wDXweyuYXgHTB+gSNywYeal7LVlNpiuyNGShYDc?=
 =?us-ascii?Q?7DiHqB8taxeVU/KkTj77HSFhX3Fa9fEDR3jFDzPOI4fhC0ghFtCIxwwmpW4K?=
 =?us-ascii?Q?x5Ae2RN+hgJa/TRsnMfjqOK5DXzq7CJ0yzFpDJSElAcFegq0wjcoYWO3ImNt?=
 =?us-ascii?Q?+L3bNatusLJBz5l3Ww4JcT/fDGJ9QPZbSV3cRo+uPV/MnmlqblMwszHTXROO?=
 =?us-ascii?Q?8uUdg09Xd3+HNjKCzLqGyXvEt1+UGNXyDNGRyqemwpzBZqZhpQXUdK4yeGi6?=
 =?us-ascii?Q?gJk0C6KS9SRePIIV0/z2/6X4x+EA7/0y45qhvTLRBTE5PLjvCPqNAy/YayFu?=
 =?us-ascii?Q?GG2qSAQCPCusBPWPFEb/I4mxgCvpKINMNvk2ZHhBLUXNuzb1+BRk7PHAQu2e?=
 =?us-ascii?Q?61eUfgGoA7Zcbxy2A686CX2MNnvvWqQQtymF663ozOMZAEYqHLGc6MlFKXlO?=
 =?us-ascii?Q?lcqFId9L4eZUOVyKYWuH74Ca96nq1C52V1VHSPHcSJlbVAmbf80560B+2PkY?=
 =?us-ascii?Q?M53VuytMr0PNJaadG7VyvmCw9Rd2guxFUUnI1SFhsZmRg00r6trEJHEA/Otc?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e8557b-eb81-46e9-d4ec-08ddae61e8f7
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 12:16:10.3635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh0vA10FWP84owyM54NQsymj3TiZMerTw+DEAVydFvZovJuvpslZ9clGlzecFCT4FIfr47gGmTajHlmqWHxwfcQ4so9DxaGrmum9+laN6yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5629
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

On Sun, Jun 15 2025, Peter Robinson <pbrobinson@gmail.com> wrote:

> On Tue, 6 May 2025 at 08:30, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> On Mon, May 05 2025, Tom Rini <trini@konsulko.com> wrote:
>>
>> > On Mon, May 05, 2025 at 10:19:24PM +0200, Mark Kettenis wrote:
>> >> > Date: Mon, 5 May 2025 07:48:43 -0600
>> >> > From: Tom Rini <trini@konsulko.com>
>> >> >
>> >> > On Mon, May 05, 2025 at 11:45:05AM +0200, Rasmus Villemoes wrote:
>> >> > > On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:
>> >> > >
>> >> > > > On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
>> >> > > >
>> >> > > >> From: Bruno Leite <brule@prevas.dk>
>> >> > > >>
>> >> > > >>
>> >> > > >> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
>> >> > > >> devicetree. Add a defconfig that is specific to the rpi5 building the
>> >> > > >> now available upstream dts for that board. The defconfig makes use of
>> >> > > >> defconfig including that is now available and only changes the DTS
>> >> > > >> related config.
>> >> > > >>
>> >> > > >> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
>> >> > > >> due to the ARCH_BCM283X config it will try to build the
>> >> > > >> bcm283x-u-boot.dtsi and break.
>> >> > > >
>> >> > > > My question is, can we not adjust rpi_arm64_defconfig to be generic
>> >> > > > enough and not have a problem on Pi 5 due to the default device tree?
>> >> > >
>> >> > > Not really.
>> >> > >
>> >> > > What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
>> >> > > rpi5's .dts file, because we really want to build that and not some
>> >> > > "random" dts file that doesn't have anything to do with the hardware. I
>> >> > > know that kinda works for the setups where the .dtb built in U-Boot is
>> >> > > not used for anything, but in our case, we really do want to use the
>> >> > > .dtb from the U-Boot build - we inject various U-Boot specific stuff via
>> >> > > the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
>> >> > >
>> >> > > And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
>> >> > > referencing nodes that simply don't exist when building
>> >> > > bcm2712-rpi-5-b.dts, the build breaks.
>> >> > >
>> >> > > Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
>> >> > > don't really know why rpi4 is both bcm2711 and bcm2835 and what the
>> >> > > difference is, but rpi5 only seems to include a bcm2712.dtsi which does
>> >> > > not include further dtsi files.
>> >> > >
>> >> > > If rpi5 has nothing to do with bcm283x, then perhaps a better approach
>> >> > > is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
>> >> > > rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
>> >> > > 'default "bcm2712" if TARGET_RPI_5' ?
>> >> >
>> >> > OK, so I guess my next question is, is rpi_arm64 useful enough in the
>> >> > end for Pi 3 and Pi 4? I would have expected that it doesn't matter what
>> >> > tree we build in to U-Boot as we would be using the one passed to us by
>> >> > the prior stage firmware, and then update that at run-time as needed.
>> >>
>> >> Works well enough for us on OpenBSD.  And it would be nice if
>> >> rpi_arm64 would work for the Pi 5 as well.
>> >
>> > But that gets back to my first question. Can we correct the code such
>> > that we do whatever is required at run time, as the previous stage will
>> > have assembled and passed a correct device tree already?
>>
>> I think this is sort-of asking the wrong question. The problem is not
>> about what dtb the prior stage hands us or what to do at run-time. [*]
>>
>> The problem is to have a defconfig that will compile
>> bcm2712-rpi-5-b.dts, as part of the U-Boot build. As I said, it's quite
>> likely that rpi5 isn't at all a part of the 'menu "Broadcom BCM283X
>> family"', and it's the CONFIG_SYS_SOC="bcm283x" that prevents
>> bcm2712-rpi-5-b.dts from being compiled (because the bcm283x-u-boot.dtsi
>> doesn't apply to that .dts). Bruno's patches achieve that by adding a
>> more-specific -u-boot.dtsi file (it doesn't seem that we need any of the
>> bootph-all settings from the bcm283x.dtsi file), and adding a defconfig
>> file that is based on arm64, but just changes the dt settings.
>
> Any reason why CONFIG_OF_LIST= wouldn't work for that?

Yes. The fact that when you try to do that currently,
CONFIG_SYS_SOC="bcm283x" means that the u-boot build system ends up
including bcm283x-u-boot.dtsi, and that has references to nodes that do
not exist in bcm2712-rpi-5-b.dts. Which is exactly what I wrote above.

So what we're suggesting is to add a more-specific *-u-boot.dtsi file
(namely, one named after the base .dts file), which can just be empty,
so that that empty file will instead be picked up when U-Boot builds
bcm2712-rpi-5-b.dtb.

That works just fine. And with that in place, one could add
bcm2712-rpi-5-b to CONFIG_OF_LIST in the rpi64_defconfig.

Rasmus
