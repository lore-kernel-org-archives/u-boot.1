Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3B5C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 08:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0262B846B4;
	Tue,  7 Jul 2026 10:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dar9uBsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A9E84844; Tue,  7 Jul 2026 10:53:54 +0200 (CEST)
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF28801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 10:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783414431; x=1783673631;
 bh=BQXdYKSxwLkVTwELCrcc5lfEblFhqRI/5UK9guFvR8A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dar9uBsc5TL9QksoWXXcvTGDwe6OOBjBdxLGBbSFWEGgBlqALStoc4cpEBT78Gxis
 iJl4PTk7TOg7YohzmCql3ODFBBPAAUtx4huzrgEm/+/1sm2a1bNG/Kup7NqniaAVI5
 J6ceqchiBDt/AIlwL0jtlPNjOb9iwvftTe3o0Qf6i0iOT+UmGPf+Rj1AFewk7OiAYK
 347N8llglcLo7WFTIKB1sFuyxFFidb5e7wJxBGla7hUR3VEEsFnOO2t48HHhN543lN
 JUKuDIKZT6Ifpz39Eh2Cbn0ajpLhrtHjXPIv5dcQDoj8jUotS2MIGNbHCmqz76k2WO
 ZL/KoyakfsiEQ==
X-Pm-Submission-Id: 4gvZlL0gk1z1DFT1
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Patrice CHOTARD" <patrice.chotard@foss.st.com>
Cc: "Marek Vasut" <marek.vasut@mailbox.org>,  <u-boot@lists.denx.de>,
 "Stefan Roese" <stefan.roese@mailbox.org>,  "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
In-Reply-To: <62451a3d-6fe2-49fd-a724-197774305286@foss.st.com> (Patrice
 CHOTARD's message of "Tue, 07 Jul 2026 08:03:52 +0200")
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
 <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
 <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
 <5ce8de52-2fec-4d08-a9e6-cfc69edbaa0a@mailbox.org>
 <13f510d9-6b08-499f-a6c0-f76484488899@foss.st.com>
 <ec6ed9f4-b302-4336-af02-1645aff668d1@mailbox.org>
 <tdaxlZF2d_Uu_E3EBGWqa6RvibE8eLsMtvc4ekpUPHvJSli9Tah-PpLHs7xG5VSIlo75XUDaauwgSb3kep-Dyw==@protonmail.internalid>
 <62451a3d-6fe2-49fd-a724-197774305286@foss.st.com>
Date: Tue, 07 Jul 2026 10:53:49 +0200
Message-ID: <871pdfw57m.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 07 2026, "Patrice CHOTARD" <patrice.chotard@foss.st.com> wrote:

> On 7/6/26 18:00, Marek Vasut wrote:
>> On 7/6/26 5:16 PM, Patrice CHOTARD wrote:
>>
>> Hello Patrice,
>>
>>>>> I did a test, it doesn't bring any noticeable improvements, but never=
theless i will submit a v3 with this update.
>>>>
>>>> Does the list iteration exit when it finds the first entry that is not=
 going to be executed at this time ? If it does not, then there will be no =
improvement. But for this to work, the list would have to be surely fully o=
rdered in incrementing timestamp order, is it ?
>>>
>>> No, the list iteration parse all entries.
>>>
>>> I see your point, on original implementation, entries are not sort by i=
ncrementing timestamp order.
>>> I did some implementation test, by sorting cyclic entries in cyclic_lis=
t when :
>>> =C2=A0=C2=A0 _ registering a new cyclic callback, put it directly in th=
e right position in cyclic_list.
>>> =C2=A0=C2=A0 _ in cyclic_run(), after running a cyclic, compute its nex=
t call and insrt it in the right position in cyclic_list.
>>>
>>> There is no noticeable gain.
>>
>> Did you also break from the iteration when you reached the first entry w=
ith future timestamp ? That might actually help.
>>
>
> In cyclic_run(), as now entries was sorted by increasing timestamp, only =
the first cyclic in cyclic_list is parsed,
> we don't need to parse all cyclic_list element.
>

The point is kind of moot as v3 seems to work just as well, but I do
want to point out that no, ensuring that the first expiring timer is at the=
 front
does not _sort_ the list, and breaking once we hit the first non-expired
timer would be wrong. It would of course work for a list with at most
two elements, but not in general.

Rasmus
