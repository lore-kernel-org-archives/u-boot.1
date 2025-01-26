Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90293C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 21:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0D280F98;
	Sun, 26 Jan 2025 22:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Bbfk7cwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4375280FAA; Sun, 26 Jan 2025 22:50:03 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0CE80F85
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 22:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrNQp1iZmp2oHfatUUD6Zgtf1Uhsw2WdVY+21N4Cf7GIRx4atRjW+5KZNzIgUJGsUu27ZE/C/KbVrzHtzYL9dbCHATkubrcyNqoafIt49AS1uqAie3apWET7xMmLwsQ7JMIjJj+Rb2gE5iZ06vHsE1d0FUXXge0Rbx57z18pkfANiKmCi64AZxRDriT2dzi5TMiTt6/PRaUY43bJgEDF8tExk1TnF5apK46nZiWkaHzCWF6rbPanrT1mKpjjUU77Mp2jUMrOdFJNwA3oAe1oX3lNPAVAGySGxLaXdWHCG24p78pAtbuiYxz0VkJpfQ3lhUXjWXVtrGKJdoQGsBxqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFGbNHaCgMDeG/lplTC52E7CdKopZOJSNA1MU6Z0AXo=;
 b=D2JWS5LuX8/sn6rZ8b3DNQp09aD+DNwERAgWCrbgWiXYbVS/xGapWdiYZhc9q2TjeqLZnT9welXg1b5VXEHpUP0BUB8DCaLbNOS9zwk1kXEThmn/NuuHb3zNO4gU/Ex/MAZ1cWOskdIIRpqb7X6+ZUgt/LN6qoylX2qElzDB2YREdK62pok5w9sdkkyKjKngZe/nHhJsTE8rWRqWSNc8z+c0mAncpHEztQkSAP+eCAe8Ss1w/bZEQp5l934yZSOkKOcBCPEJgMlQKUpaZHmFeXamBsTtSw1RYwS9SIWu9fdkQDYUHb/5ABNUHLFUmgiSg2bLMdkG59KAuXXQeqHXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFGbNHaCgMDeG/lplTC52E7CdKopZOJSNA1MU6Z0AXo=;
 b=Bbfk7cwNAPkxFaewoASbzVT/XodkQSn+cfFbffU+QoY3eKMGeSmzZi5oxgjhL/ZTzYT565Qpfe1FuGBBoDfKsfpEk+3k7wLvHd9CehLWDlRJvVK/EJ5j1onaTyNczYBgNnapuzwalq1yj1ph18ZS8RnhjCfaQZ/acYsktsfwDc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by GV1PR10MB5889.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Sun, 26 Jan
 2025 21:49:54 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%4]) with mapi id 15.20.8398.005; Sun, 26 Jan 2025
 21:49:54 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,  u-boot@lists.denx.de,
 Aaron Williams <awilliams@marvell.com>,  Anatolij Gustschin
 <agust@denx.de>,  Angelo Dureghello <angelo@kernel-space.org>,  Christian
 Marangi <ansuelsmth@gmail.com>,  Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,  Jaehoon Chung
 <jh80.chung@samsung.com>,  Michael Polyntsov
 <michael.polyntsov@iopsys.eu>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Nikhil M Jain <n-jain1@ti.com>,  Peng Fan
 <peng.fan@nxp.com>,  Peter Robinson <pbrobinson@gmail.com>,  Ronald Wahl
 <ronald.wahl@legrand.com>,  Simon Glass <sjg@chromium.org>,  Stefan Roese
 <sr@denx.de>,  Tim Harvey <tharvey@gateworks.com>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 1/8] cyclic: Prevent corruption of cyclic list on
 reassignment
In-Reply-To: <f2192348-1c8b-4858-b138-e1a894dff92f@mailbox.org> (Marek Vasut's
 message of "Sat, 25 Jan 2025 14:22:59 +0100")
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
 <87cyghx2ru.fsf@prevas.dk>
 <f2192348-1c8b-4858-b138-e1a894dff92f@mailbox.org>
Date: Sun, 26 Jan 2025 22:49:52 +0100
Message-ID: <87r04putxb.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|GV1PR10MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ea6bdb-472a-4758-3d18-08dd3e535e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BSu0Sp5u3pRcF20JVAhbW3/dT6B3EsNZIvH589lXhXM0VnW8QY7AJ3xmIDCT?=
 =?us-ascii?Q?fiLIzw2+FM/oZ0qQ5FRniaUB29DOzMfKIEYYIuAr2NGathNCsp4WiFqZtVbC?=
 =?us-ascii?Q?GB3GfRlzfQoTdd+j/FLSWemWuomueQXqH5uFCma/QnfDPE/jEx07wjYnd9k3?=
 =?us-ascii?Q?rKSerIVHvHERdXQhaF81ZwXagYMzjZSVBpZqr1FmHmNFY/TWvFvqz5tqeXrS?=
 =?us-ascii?Q?KjmRs8Dhf5isLhUL4kk/iLB4soPWTI+PpcvJXwq9/xTaMddxmlmRnNX88Y5Z?=
 =?us-ascii?Q?ITUpj6KYlcPaiHrlM7e9Stm+V6XY6muRtetQxxnhx/LpOgqOBRHZaENsFmuI?=
 =?us-ascii?Q?9DUBW422q7Iid5YWnnZQjIuN3YgOm7V6awZpwkof6mKemBVWJCQDPq3aYtSp?=
 =?us-ascii?Q?HuEEAQPVPYP0b0tWJM/q/PQ0uvCSKfFsz8/97DmAjUNCabujb/jNddDa1P2W?=
 =?us-ascii?Q?8Bfzq9qCrY1gRayMN5J2BiLYWUNflAN4+ELzHNywAGGvJeaORFh0eoGYpQ7v?=
 =?us-ascii?Q?0NfOGI1kYwuN05PUCheDZR1xufGSlQJB4NQOf+XRNpx218hhYEY3UxrgKTA6?=
 =?us-ascii?Q?3Ffh24VIP3/3r/nPyuFj3TPlUkXKaOnP+L5XSXYHJ6TRJmQ7dS/o44o4K1pj?=
 =?us-ascii?Q?Tq2lRLrrsVKUc3R+yr+m+2Xf2MzBiuMhAa+gQpYgmBa44R5/MSgWjRr62L/T?=
 =?us-ascii?Q?R4P6drlXBA9NymHnuP/AVcNgDMfSs4MftFHQK6tUb9mR7dcUkpqNg+Cpf3hX?=
 =?us-ascii?Q?pZwzxsy2iFZUCWbqtu4yRVSo59/p9MYzjwqu4ekE5UQweHDWhHvATkbIRqhp?=
 =?us-ascii?Q?VJeiJV129aLSZAI1QDxVN7GW36JpTL7m17OQmqb1UBEwJGOGqxXMOlvAROvt?=
 =?us-ascii?Q?jZVXcaq5Z2WXxPpNdyljqHt1jLy46Fqf6MPBsWwRB5k2r2whRxjhhaFxyRyX?=
 =?us-ascii?Q?/3Rxmz27l06sVwp41QvLwQwBGCH8mlJXkDf4N7EF5PmTq2tVbOiMdN4NP5lv?=
 =?us-ascii?Q?BxXtdJH6LQrzS+wAwJdQSpLAdXe9/WOB6vL6OS7rRIOAuu9m9uX/LO+aPqsJ?=
 =?us-ascii?Q?UqiPgFhyTCIfoW33tUOrLZa7nnMcOdJuP4Zsh/AgyMdxCd/+M1RerORA8ami?=
 =?us-ascii?Q?QNX9+L7t5e8TuSTWlMCA07ERqbyT7SQtQVVwZpbVCbwQ6g1AYqY1gMz3NXGf?=
 =?us-ascii?Q?Ph+hfyOhS/VY/344a2cvgRw2YNV4Si0sObNqtkDYACzBzm/KT002DLuRGyd/?=
 =?us-ascii?Q?T6bNw5vpjK6eCpn2PLo37hffj6eoLLYdY/KVA/x3R7wFSAwR8lcLlI8cU6rg?=
 =?us-ascii?Q?PYLsUc7rT2l7x4pRcJ8r3/7RJCnIxzhK23hHJWdOC+kT1TUPh1aC7hK7UL9W?=
 =?us-ascii?Q?xu4XWRpDIGPU1CtcMBb8/gTpAXvhbHRQmtPjIOv2gTHbgSr+5I08FN6kMeCU?=
 =?us-ascii?Q?ylJjxf5jA5LhR5uvQasoP0OTQlNcZ4N9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/8FOJFoR1jj57lz+EdGr7WZSfCUFa63mW4OPZWqXg1/PMmc0iBd0DUKWQNP?=
 =?us-ascii?Q?e+PIbbjHA/wU2Wpx4dsSwt7cS8fK3yLAMe02qefwXFzNpDFuVsQ+dhKNg+RB?=
 =?us-ascii?Q?7uHCouu6zVxgO9lf9Htok6drQkzt4c/1K/2a/4KK5b0Rst0vSGyaOKfY4md+?=
 =?us-ascii?Q?A+PbgDV6efvne2AjES3zqMECg1oVZkCof3TTFQsEFqMF+/PJNd6S9Ivbn2AM?=
 =?us-ascii?Q?WySIOpVykuhwDpOA8l3T/IknWf5ILUuGSxLLYTY2M5JClnDdJ8COpwA8ovNJ?=
 =?us-ascii?Q?wxbg9ZK9ppNYpcWSNKL+IjBnNTpY5eaYR3qMQMf1jXqedGDP3qekRarhsWTH?=
 =?us-ascii?Q?z9QJroXxO7e33Jr8ILcvAN2Zxy6RGI3HQ6c2Eh638wNHUhyo5Pc4w/L8l4H9?=
 =?us-ascii?Q?E7uIg/GJ88FveLFNwprKxTfGJKU1o6F6htax6bbO3TGoaqw4718HiILMmXNb?=
 =?us-ascii?Q?yobKx3Ydg4q2e8oS+7avAgwlz0z6B/eLWcaBzOD3CXeAolLC6eoDyfMFoLle?=
 =?us-ascii?Q?+Tou30E1YeVNrzZHTfyK9iQki4Z3nsKYsycGau9xhawfbTxNM6golep/O8LH?=
 =?us-ascii?Q?g5XAXJoZ0gKv43cN6pczTjTx987NbnBUz/zfjl68YDImVrKzmHF6cYP4+e7O?=
 =?us-ascii?Q?oaKbzZw3gKPBRqeKi42N0hiG4cX5wWBi5d0jl3BySN1fENttqVMZqCJsZ2kY?=
 =?us-ascii?Q?eZErP3G7ZVEvrUfOMMXIDH13xkiRkUXJ+YD/2jVRakv21ntkR7smXPFWK8Mn?=
 =?us-ascii?Q?mpioagj0Q1CmmvVCfHiQ83Ar63GJmFQ8puPbA06NaquNdX+7aZxiyOrNGhOU?=
 =?us-ascii?Q?b0PJZ3aIcXd8p6fa/R5CZfwyQA3zKD5xeLrO5LZcDrgzaj/a2+cFYSy/RYWX?=
 =?us-ascii?Q?4jh8IYYziHCJWbObCqOH57Rkejfr/vjiLn3T0CPgpxTlwEROFS2QR7dn4MQ9?=
 =?us-ascii?Q?8ZnvCRQyN7iOI7dqWLi4lsPB74ToY8jjUzfw4nnDV/VfxLnFO5lgU62tlMet?=
 =?us-ascii?Q?/U0qGjKzjva0YEeMDvEBJ6kMValEP9ajFvfkXlgMVtmwfQKmbAFsr+25WzyO?=
 =?us-ascii?Q?mVDO1nzg9Ih2jXvdnQl4gN1iTThGTp2KlDZi6O52UMmsRWawxzGHUBBX+h5E?=
 =?us-ascii?Q?NvwEFncpMU86QH7T9/Dg6WgqOUWex4xF1IwZ3Y9uHJWe+gWIoWVKnS4iU5Ch?=
 =?us-ascii?Q?axfqtndGLB+rFglXsvNOa2wOHfLHXBCGce2xXZKN/qdyWAxZezbtujMjCX6o?=
 =?us-ascii?Q?gDuvooV5sdEGe73XhF0IFidzXKg7ska8Ar3Tn0DShjGoWwM7LJW3/dbcrzvr?=
 =?us-ascii?Q?iZd2HjRpPuvfBcJH4bsANLC0t7Pk+0zqckWfXvNXcQ1kzYHUsflOA0WO3nn7?=
 =?us-ascii?Q?nnxkfkiM34EWBmgPLxqxhhuffEmZIpte8RKBx93gWP57Eh6CFQKupKUCul/3?=
 =?us-ascii?Q?it0/ZbQD+diajWft5CtYVZ5ZbmgN8yuSkVmbMFj3N1XOayZ9/27nkh3A3ZLu?=
 =?us-ascii?Q?HepCyTswPTcb4ugzBeZMjm9Jx0RtXwqoc4BwKlNF0yUIY6oAljM4CKdwSg3X?=
 =?us-ascii?Q?nUOAH5EWlTxPMDQzpJYq9mhMM5dxo0ml6fjxM4gUYGlX8evD6pDHprYbi1k0?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ea6bdb-472a-4758-3d18-08dd3e535e1d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 21:49:54.0911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh3q9l4MNQ72/ioGCUQDsand/CL341JXdqRX9KWhwXki4Ny5fZItWHJnpvvQ9TJDuowdTGkj+5ypQiSsdgzv5HGFccOceFJ+uhMhFcueUvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5889
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

On Sat, Jan 25 2025, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 1/20/25 10:17 AM, Rasmus Villemoes wrote:
>> On Sat, Jan 18 2025, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>> 
>>> Make cyclic_register() return error code, 0 in case of success,
>>> -EALREADY in case the called attempts to re-register already
>>> registered struct cyclic_info. The re-registration would lead
>>> to corruption of gd->cyclic_list because the re-registration
>>> would memset() one of its nodes, prevent that. Unregister only
>>> initialized struct cyclic_info.
>> I had considered something like this, but I don't like it, because
>> it
>> relies on the cyclic structure (or more likely whatever structure it is
>> embedded in) being initially zero-initialized.
>
> True
>
>> And if the caller doesn't
>> know whether the cyclic_info is already registered or not, he can't do a
>> memset() of it.
>
> This is what can happen right now, which is dangerous and what this
> series attempts to address.
>
>> So my preference would be that we instead simply iterate the current
>> list to see if the struct cyclic_info is already registered that
>> way.
>
> That I can do, but it will be a bit slower.
>

Please. I tried to preempt those kinds of objections by pointing out
that we already traverse the list thousands of times per second, and I
highly doubt we'll ever have more than, say, 10 elements registered, so
we're adding at most that many extra traversals, of a ridiculously short
linked list.

>> Also, I think I'd prefer if double cyclic_register() is allowed and
>> always succeeds; this could be used to change the period of an already
>> registered instance, for example.
>
> This would be terribly overloaded interface, no, let's not do that.

I disagree.

> Better introduce a dedicated function for that kind of period adjustment.
>
>> Also, that avoids making the
>> interfaces fallible.

And I believe that _this_ is an important property to get/preserve. 

>> And cyclic_unregister() could similarly just check
>> whether the passed pointer is already on the list, and be a no-op in
>> case it's not. Those extra list traversals are not expensive (we're
>> traversing them thousands of times per second anyway in cyclic_run), and
>> I doubt one would ever has more than about 10 items on the list.
>> IOW, I'd suggest adding an internal
>> bool cyclic_is_registered(struct cyclic_info *info)
>> {
>>    struct cyclic_info *c;
>>    hlist_for_each(...) if (c == info) return true;
>
> I don't think this works, because that struct cyclic_info contains
> .next_call member, which is updated over time, so this exact match
> would not work as-is.

Huh? Of course it will. I'm not looking at that next_call member at all
(that's not a pointer, that's just some future time stamp), I'm
merely comparing the passed-in pointer to the elements already on the
list.

Yeah, my pseudo-code should probably have used hlist_for_each_entry()
rather than hlist_for_each(), but that should be obvious from the type I
used for the iterator variable.


I have something like this now:
>
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 807a3d73f67..d721a21a575 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -27,11 +27,29 @@ struct hlist_head *cyclic_get_list(void)
>  	return (struct hlist_head *)&gd->cyclic_list;
>  }
>
> +static int cyclic_already_registered(struct cyclic_info *cyclic)
> +{
> +	struct cyclic_info *cycliclst;
> +	struct hlist_node *tmp;
> +
> +	/* Reassignment of function would corrupt cyclic list, exit */
> +	hlist_for_each_entry_safe(cycliclst, tmp, cyclic_get_list(), list) {
> +		if (cycliclst->func == cyclic->func &&
> +		    cycliclst->name == cyclic->name && // or strcmp() ?
> +		    cycliclst->delay_us == cyclic->delay_us &&
> +		    cycliclst->start_time_us == cyclic->start_time_us)
> +			return -EALREADY;	/* Match found */
> +	}
> +

Please no. Just compare the pointers; if they're the same, it's
literally the same struct cyclic_info; if not, it's not. Why would you
dereference the maybe-to-be-registered struct cyclic_info when you don't
expect that to be in any kind of properly initialized state?

> +	/* Match not found */
> +	return 0;
> +}
> +
>  int cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>  		    uint64_t delay_us, const char *name)
>  {
>  	/* Reassignment of function would corrupt cyclic list, exit */
> -	if (cyclic->func)
> +	if (!cyclic_already_registered(cyclic))
>  		return -EALREADY;
>
>  	memset(cyclic, 0, sizeof(*cyclic));
> @@ -49,7 +67,7 @@ int cyclic_register(struct cyclic_info *cyclic,
> cyclic_func_t func,
>  void cyclic_unregister(struct cyclic_info *cyclic)
>  {
>  	/* Unregister only initialized struct cyclic_info */
> -	if (cyclic->func)
> +	if (cyclic_already_registered(cyclic))
>  		hlist_del(&cyclic->list);
>  }
>
> [...]
>
>>>   void cyclic_unregister(struct cyclic_info *cyclic)
>>>   {
>>> -	hlist_del(&cyclic->list);
>>> +	/* Unregister only initialized struct cyclic_info */
>>> +	if (cyclic->func)
>>> +		hlist_del(&cyclic->list);
>>>   }
>> So this already shows how error prone this approach is. You are not
>> clearing cyclic->func, so if the caller subsequently tries to register
>> that struct again, he would get -EALREADY, while a subsequent unregister
>> could would lead to exactly the list corruption you want to avoid.
>
> I would expect the caller should clear the structure before attempting
> to register it again. Shall we actually memset() the structure in
> cyclic_unregister() too ?
>

This is what I tried to point out here:

>> And unless the caller immediately himself clears ->func, other code in
>> the client cannot rely on ->func being NULL or not as a proxy for
>> whether the struct is already registered (and the caller shouldn't do
>> either of those things, as the struct cyclic_info should be considered
>> opaque).

So, let's look at the mmc example. In mmc_deinit(), we do
unregister. OK. Later, we might do mmc_init(). Now mmc_init() tries to
figure out if its cyclic_info instance is already registered or
not. There, mmc_init cannot possibly just zero-init the cyclic_info
before the register, because it might be registered, and it can't not do
the zeroing, because then the new registration might spuriously fail.

So for that to work, the code that calls unregister and thus knows that
it has been unregistered would have to immediately do the zero'ing. At
which point it would much better if cyclic_unregister() did that
zero'ing, instead of all callers having to remember that memset().

Rasmus
