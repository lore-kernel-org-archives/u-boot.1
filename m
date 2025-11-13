Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B2BCD98E7
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 21:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A57384064;
	Thu, 13 Nov 2025 22:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xouYPaMn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fWk3PsEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7B984062; Thu, 13 Nov 2025 22:57:50 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AFC83FFC
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d6vJr1ptLz9t6D;
 Thu, 13 Nov 2025 22:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4FQwjl49NwNgqUUcyzrcZZWzyvUioyTy2j6pS9357w=;
 b=xouYPaMnYa79RKaXoNxgC6hF3Y+7UmLRWOtJTtd/QWNT4vNlidYukBMfBGL7SxaEHJvsnF
 mlTmmvuXfKj/CbSGAtXp1FLynmmR2LA+cb1Wb1h573IKCdSO4ure9vLBK89+xoKPLAS6jZ
 kBf3Ydsl4s0Cq2VrrRr8hrllPzET0CckcD8SRIkxjE1xqr3qwA1bwm7wx3di6j7dZJFrst
 YrtyDSu+Sv8pMlVbtgDM2F57FGax/oC5xH1Vdylz6zZpiGk3OQMod0ZOK4ExAAdNF2la5I
 YzhXl1H3qorua38v2ai1lLhsUeI0EjxziuM0wF82OOXTrq9FyzHG4bbxYEnB1g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fWk3PsEv;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <8a4ba995-840a-41ed-b496-6c32965d4ce5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4FQwjl49NwNgqUUcyzrcZZWzyvUioyTy2j6pS9357w=;
 b=fWk3PsEvN4l+NNJKikDSxI1h8AtDWksZPpvAmHH4xsLY6cqTN2Z5OjjpIBnix1lAWr37Ra
 H3yFTKhxXmd97FdPUnmyBUJsoTJl2FEAjSO8mt4BIHkdRjlnv2Ab4zINT6aK/Pkrg6lYAs
 cvtVRLHw4bdcwPMifc2HRvhDnvLoD9I5CR06MgnWtu4ExOs6gSI2j2bBR3pcs3dH5qseX0
 zjbOnXB5jG63EM57c7QjuFr8tRm1YmeyoLkgNDL/gQv5jD9ad808KXAMv7P2slP9BFMheR
 SjfgtL6vj0mI6fR4Z5q6BFd/A6OfNWmGAf/9mA6WriEiEfrwix+dYB10UBEUww==
Date: Thu, 13 Nov 2025 22:48:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value
 unconditionally
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-4-marek.vasut+renesas@mailbox.org>
 <CAFLszTgRxLTWjCCbxxme9XtG2E80CrYOesry_86YuagL8uPJ-w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTgRxLTWjCCbxxme9XtG2E80CrYOesry_86YuagL8uPJ-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: eae9cf6e3e1597605cd
X-MBO-RS-META: if9j18x5ib6ca7ya8osz3umrim4qguxa
X-Rspamd-Queue-Id: 4d6vJr1ptLz9t6D
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

On 11/13/25 8:33 PM, Simon Glass wrote:

Hello Simon,

>> The fdt_offset_ptr() may return NULL pointer, check the return
>> value from fdt_offset_ptr() for NULL unconditionally to prevent
>> sandbox crashes.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Adriano Cordova <adrianox@gmail.com>
>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Sam Edwards <cfsworks@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   scripts/dtc/libfdt/fdt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
>> index 95f644c31f9..d16cc3d4730 100644
>> --- a/scripts/dtc/libfdt/fdt.c
>> +++ b/scripts/dtc/libfdt/fdt.c
>> @@ -168,7 +168,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
>>
>>          *nextoffset = -FDT_ERR_TRUNCATED;
>>          tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
>> -       if (!can_assume(VALID_DTB) && !tagp)
>> +       if (!tagp)
>>                  return FDT_END; /* premature end */
>>          tag = fdt32_to_cpu(*tagp);
>>          offset += FDT_TAGSIZE;
>> @@ -186,7 +186,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
>>
>>          case FDT_PROP:
>>                  lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
>> -               if (!can_assume(VALID_DTB) && !lenp)
>> +               if (!lenp)
>>                          return FDT_END; /* premature end */
>>
>>                  len = fdt32_to_cpu(*lenp);
>> --
>> 2.51.0
>>
> 
> The can_assume() is there to be respected and helps to reduce code
> size. What problem are you actually seeing?
fdt_offset_ptr() can return NULL, and it does in test_spl on sandbox if 
I recall it right, because the U-Boot code passes in offsets which can 
not be resolved properly and that makes fdt_offset_ptr() return NULL and 
trigger SIGSEGV when it is dereferenced here.
