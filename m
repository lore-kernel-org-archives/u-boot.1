Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C06EFF492B
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 00:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC138394E;
	Mon, 30 Mar 2026 02:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HCF7/pne";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Pt6VHXu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1921383C14; Mon, 30 Mar 2026 02:30:54 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325EE8063E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 02:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fkXGg6v9Xz9tHG;
 Mon, 30 Mar 2026 02:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774830652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbVgbWtnfgoFi7Ut0IhyQNbHjUzU9eVuwSybEWvsMPI=;
 b=HCF7/pne746qN57GfSEKLXiUCpz6x8sVc/lxe3GO+sL8hgawI47X39ry6d3Jj9503e6g23
 kX7p3jazX72Z9qCUX9LYaJW5dwOS3p8nqDZrCiwx9IgLo5LLt8fRAe1mYs19YgzKtnsnsA
 YvogtGgjqSTYAfXRcvhknIS4ZpkQg21v0tkTopMItq6xMKrBEgjiStmGDLlMk+28ryYM8X
 bwPX7MGkcf2zubqPh+mG96quZx6xlV4VatzmXqr5SQUasiR0YV5v2JGemMI5Aio4mEocf1
 P2d6CoYUIq1qMv2u36caNUrYZ1KmVSNZs0O05IHtXg1xmBNg4L5J5ZJI8gdJJA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Pt6VHXu/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <d387da83-7c5b-4816-ba58-7939dfa7a28e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774830650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbVgbWtnfgoFi7Ut0IhyQNbHjUzU9eVuwSybEWvsMPI=;
 b=Pt6VHXu/ZYBzLdpb42UDaep1H29GUA7/qLCe9uRp/i3geBs07SrBcVyBg/t1NlU2cuWXPz
 7vGZJcBviBHPXRSpbHSZPrNkYbwOfVn8chgjD/ZBllyFLxML0Iu5hVOFY1tsZWIQ2i34o1
 tB9fAIDzetBwazixv5uYpgpHp1c1ENFKpAAd/pBaRqnnBZyQhijeyI9/N0Ck7VqPrHlUdx
 L+2J9fgvFrubXmsD+8h76tP2csOJrGZoxguSQq3pwTofMazRUIEkLi0L5J11IvT7ito/6z
 7aAXmRE4jILSZFzMGrIOOn9/G5IzV6pf9TqO2xJGucmn+3oHARdmmwATydKG0Q==
Date: Sun, 29 Mar 2026 16:42:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/3] common: Allow relocations on the top of the last
 bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-4-ilias.apalodimas@linaro.org>
 <6f6f1fc8-56c5-405b-915f-269d789b43e3@mailbox.org>
 <CAC_iWjK5-5Nn8+-OOQWuPSDwd6ckHyPY2Na-7eGO2tc_1XsLxg@mail.gmail.com>
 <edbe864b-2c76-4ac2-8a1e-69f527f1316e@mailbox.org>
 <CAC_iWjKGzbbf1du3K9QuGYjkDrscAUKxMsOTcLvC1A4L7UTvxQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjKGzbbf1du3K9QuGYjkDrscAUKxMsOTcLvC1A4L7UTvxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e4f3dcc41fe9e2febb9
X-MBO-RS-META: r6fhdrpfw5n43ega6qa817dmtofcua1o
X-Rspamd-Queue-Id: 4fkXGg6v9Xz9tHG
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

On 3/28/26 8:11 AM, Ilias Apalodimas wrote:
> On Sat, 28 Mar 2026 at 08:44, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 3/27/26 1:23 PM, Ilias Apalodimas wrote:
>>
>> Hello Ilias,
>>
>>>>> Add a Kconfig option and allow the common code to relocate U-Boot
>>>>> to the top of the last discovered bank.
>>>>
>>>> The commit message should really clarify the current pitfalls of
>>>> enabling this symbol, including the part where ethernet transfers above
>>>> 4 GiB used to work because of the packet buffer built into U-Boot, and
>>>> they will break because the buffer is now relocated above 4 GiB too.
>>>
>>> Shall I just add your note from the RFC with a few adjustments? I.e
>>>
>>> NOTE: This currently might break platforms. If the ethernet
>>>         controller cannot DMA above 4 GiB, and once U-Boot does
>>>         get relocated above 4 GiB, the packet buffer which is built
>>>         into the U-Boot binary is also relocated above 4 GiB.
>>
>> This patch should not be applied in the first place, this DOES break
>> things. I think when this patch is safe to be applied, the note will not
>> be needed.
> 
> The patch obviously will not get applied. I was referring to the note
> in the commit message only.
> I'll just add it with slight changes in the commit

OK . Maybe keep sending the patches as RFC , so they won't accidentally 
be picked ?

>> [...]
>>>>> +++ b/common/board_f.c
>>>>> @@ -321,6 +321,8 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>>>>                  */
>>>>>                 return 0;
>>>>>     #endif
>>>>> +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK))
>>>>> +             fdtdec_setup_mem_ram_top();
>>>> Return value may need checking ?
>>>
>>> sure, but should we panic ? Or print a message and silently keep the
>>> old reloc address?
>> Print a message and relocate below 4 GiB , for maximum compatibility maybe ?
> 
> Yea that's what I currently have on my local branch
OK
