Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10298C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 19:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7C880C83;
	Fri, 27 Jun 2025 21:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TCSJ9Akb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA87781D5D; Fri, 27 Jun 2025 21:09:14 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550CA806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 21:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55RJ92rx2491894;
 Fri, 27 Jun 2025 14:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751051342;
 bh=h6Asx36/vJBHoQy+BDMn/bl05WVTZlA3MBHJJrUR7OE=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=TCSJ9AkbwUb/LYrdkiU1a7yqGu9sI0q9kDZvq7wURaPxUQfAo5Ecp29cypR7X6wal
 /jhRtiudghi2Ude00ubRPO1ZGln5OXZKueqqMw5pjsln+D7vwCP+A+tJldcy//Ajw2
 3rtBGGp3ZaNs0JGVeXoidrB+iA351nf9H30AU9IQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55RJ92hk650322
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 14:09:02 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 14:09:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 14:09:01 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55RJ90pJ3305110;
 Fri, 27 Jun 2025 14:09:01 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 28 Jun 2025 00:38:19 +0530
Message-ID: <DAXJVPUUZAW1.P62BXQ73VB7L@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 1/2] mach-k3: add runtime memory carveouts for MMU table
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250618124210.1936140-1-anshuld@ti.com>
 <85f6fdb7-73ea-4617-b82a-fb14369315d1@ti.com>
 <20250627180912.GG4003484@bill-the-cat>
 <623b8617-09c1-4006-9a76-907182ff4387@ti.com>
In-Reply-To: <623b8617-09c1-4006-9a76-907182ff4387@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Sat Jun 28, 2025 at 12:12 AM IST, Andrew Davis wrote:
> On 6/27/25 1:09 PM, Tom Rini wrote:
>> On Fri, Jun 27, 2025 at 01:06:50PM -0500, Andrew Davis wrote:
>>> On 6/18/25 7:42 AM, Anshul Dalal wrote:
>>>> In u-boot we only provide a single MMU table for all k3 platforms,
>>>> this does not scale for devices with reserved memory outside the range
>>>> 0x9e780000 - 0xa0000000 or for devices with < 2GiB of memory (eg
>>>> am62-SIP with 512MiB of RAM).
>>>>
>>>> To properly configure the MMU on various k3 platforms, the
>>>> reserved-memory regions need to be queried at runtime from the
>>>> device-tree and the MMU table should be updated accordingly.
>>>>
>>>> This patch adds the required fixups to the MMU table (during proper
>>>> U-boot stage) by marking the reserved regions as non cacheable and
>>>> keeping the remaining area as cacheable.
>>>>
>>>> For the A-core SPL, the 128MiB region starting from SPL_TEXT_BASE
>>>> is marked as cacheable i.e 0x80080000 to 0x88080000.
>>>>
>>>> The 128MiB size is chosen to allow for future use cases such as falcon
>>>> boot from the A-Core SPL which would require loading kernel image from
>>>> the SPL stage. This change also ensures the reserved memory regions th=
at
>>>> all exist past 0x88080000 are non cacheable preventing speculative
>>>> accesses to those addresses.
>>>>
>>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>>> ---
>>>> Changes for v4:
>>>>    - Add call to k3_mem_map_init for beagleplay
>>>>    - Mark reserved regions as non-cacheable
>>>
>>> In v2 I said you cannot mark any regions as non-caching. How did this
>>> sneak back in? If the reserved memory region is marked in DT as "no-map=
"
>>> it must not be mapped at all. So NAK.
>>=20
>> Presumably at the top of your mailbox now that I just pushed it to
>> -next.=20
>
> Yes, this bubbled up to my attention thanks to your applied to -next mess=
age.
>
>> Should I revert, or expect a prompt follow-up to clean things up?
>
> If we get a quick cleanup patch that maps the reserved regions as caching=
 to
> match previous behavior that would remove much of the reason for this pat=
ch
> in the first place. Removing mapping the reserved memory then we will bre=
ak
> remoteproc loading. Both have issues so reverting will probably be needed
>

The idea of the patch was to carveout the optee and atf's reserved
memory out of u-boot proper but I blindly mapped every reserved node as
non-cacheable which was not the right approach. I can send a quick
follow up fix but it would likely remove everything this patch added to
begin with. So, I feel it's better to drop this altogether and I'll post
a v5 later with the required changes.

Aplogies for any inconvenience.

- Anshul
