Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA53CFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 18:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA09583A41;
	Fri, 21 Nov 2025 19:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rJJGJOmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0181783A9F; Fri, 21 Nov 2025 19:02:02 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBF183A2B
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 19:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCjj1388bz9sqQ;
 Fri, 21 Nov 2025 19:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763748117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gzm6XXJ9f6K8Dt6mlK/yWHQrzff6Rrn/qhsceMpf4Lo=;
 b=rJJGJOmHem77lLWSrhRAbg/zgOnYWDoyA3gIM7OvuTwGSGA60QcbUWUAgEHqR3b2Qu1S08
 hSHRNW980fv+2T7z0FH4wLFqR0JQWgR8E4fvRX7mAaUa8DE1aYhVjykdEz+mUuZ6ti9WuJ
 McRwQOLtU9A+ClOAkxeQ67GK2c3nuQHkggmllBW2IJhcSSp0f6Nfe7vfVtbMrIFE0+X4rD
 H/UwqmmvGIHHwKNAYSsXJ5zuth/w8ZtXWKhjfwm4lv1Fmw9RVgqXjEWFLDs0AhMJOOJeyT
 dWv4b3WJxrRf3oCf8mTZOlXa9FuhMMYqRH1FvTjBWoRlID4P4LH07iy2QopLLQ==
Message-ID: <c75bacd5-532a-4783-9f1f-02884eee7918@mailbox.org>
Date: Fri, 21 Nov 2025 19:01:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
 <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
 <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
 <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2c21f132df17e4dff5a
X-MBO-RS-META: pxwjoqfi3qqpbn1ia6rpq9g74faew68e
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

On 11/21/25 6:40 PM, Simon Glass wrote:

Hello Simon,

>>>>> - create a new VALID_OFFSET assumption (split out from VALID_DTB)
>>>>> which checks offsets in fdt_next_tag()
>>>>>
>>>>> The latter might be best. It would likely be very cheap in terms of
>>>>> code size. In fact, I should have thought of this at the time.
>>>> Wouldn't it be better to not misuse libfdt ?
>>>
>>> It actually isn't a misuse. It is perfectly OK to pass an invalid
>>> offset and libfdt has defined behaviour in that case, absent any
>>> 'assumptions' we force.
>>
>> It actually isn't OK to pass in invalid offset if we compile FDT with
>> disabled tree validity checks.
> 
> We are saying exactly the same thing, if you read both of the above :-)

What I wrote is, that it is NOT OK to pass invalid offset to libfdt IFF 
the DT validity checks are disabled. This is yes a misuse.

>>> Remember, in Linux these checks are enabled. We added the 'assume'
>>> thing to reduce code size. Here you have found a situation where it
>>> breaks stuff, so we should back off the assumption a bit.
>> U-Boot also has those checks enabled, SPL does not, and things break
>> when OF_PLATDATA is enabled and there is no valid node associated with
>> the udevice.
> 
> Right, so add SPL_OF_LIBFDT_ASSUME_MASK for SPL and check the code
> size. If it is too much, add a new level FDT_ASSUME_EXISTS before
> FDT_ASSUME_SANE and use that for the necessary checks (there will only
> be a few, from my reading of the code).
The SPL assumes the FDT is valid, and disables FDT validation in libfdt, 
to keep the code size low.

U-Boot does enable that validation in libfdt, and grows its size a bit 
because of that (and also because the DT might come from outside), but 
SPL can not do that (and control DT does not generally come from outside 
in SPL).

That is why these few fixes actually repair the misuse, instead of 
re-enabling the validation in libfdt.
