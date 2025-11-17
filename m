Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F43CEBF97
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 02:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AF383C16;
	Tue, 18 Nov 2025 03:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UrUFm3ZS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t88iGM+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBEF83C32; Tue, 18 Nov 2025 03:26:03 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6803E83B8B
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 03:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d9T4N0cVtz9tDY;
 Tue, 18 Nov 2025 03:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763432756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi6aFMHYPbP81SFw2QPVEyF9EoLAkWryc2qL+izQx+8=;
 b=UrUFm3ZSCRcedEfKeZTR+a4hk4pyXbaGSb58xoWsP0n+egk0udV9daA9D9HHaDho9ewF98
 IO8Swk3cvBKVJ9JmfZ9E8lSyg6a5ZYAYZkxlXWbSXIdvruSenLG8Ags0yrWspklrj73cVb
 GsbqFaSt5jQYcsldemmP7j8/Fa2zfzZkQu82mgNiV2eturee+hVbDnrx4h7R0A3u1hBIAq
 GSWiQvWD5I4bkiBTNXzWrftOIVvpUZFMZja3U6kmQqqYGEjLwhiDh+zoYEm9d2eU8Ef9HW
 GcmTBMYPGpjM7pXVepBYFFiH6yrE7PoIwrhTDKfZ9i63Rlw9VcZrQg2WkOdBZA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=t88iGM+Q;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <706283a7-2ba9-4b8c-8cb4-3db42759acc9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763432754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi6aFMHYPbP81SFw2QPVEyF9EoLAkWryc2qL+izQx+8=;
 b=t88iGM+Qe4p0MA65vTGR0rRIxaZuz0SkJLb/p2j3XGz7bBJYd80MXc++RaiWpdeGro7rB0
 /gJGKZwCIKJSufocVTSsQjnUerIrD/Xks2XQQjH/PXeJNJZRAYUaLKvT/ecPfyhE10/cLy
 knD4Piti99EeRjLEM4jKEi40d0rlBN/g+ebK976o+R/VbojMxUIHYw5E/WyStzQ57VXaCk
 x2a5RgVncujsOBw2s7m3GBU3CiyqYFGzD+jpf5snXLojyWoMwh+C3uIDVPm2QOjgreR7ms
 ElyaGiFa7DSiKUjV8kWWuSi1Z/ImxEUQkDFHP9+vy+kvomtjoLHzg1AiB5GWiQ==
Date: Mon, 17 Nov 2025 18:10:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
 <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
 <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
 <c5300029-9bab-4a06-b426-ccc443d0928c@mailbox.org>
 <CAFLszTiV2jTWcWU+27QxX82Ap9YnhZNTK1sXrFvF_e53ydc5_g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTiV2jTWcWU+27QxX82Ap9YnhZNTK1sXrFvF_e53ydc5_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: aa5b1780c37f2dc88ce
X-MBO-RS-META: qnkwwq4sc4ry8doa55dj63tppei8dxr7
X-Rspamd-Queue-Id: 4d9T4N0cVtz9tDY
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

On 11/17/25 6:04 PM, Simon Glass wrote:

Hello Simon,

>>>>> The problem should be fixed higher up, in its callers, etc. For one
>>>>> thing, the caller knows whether it is a DT or not, so putting this
>>>>> logic here is messy. See boot_get_fdt_fit()
>>>>
>>>> This is triggered by a fitImage with DT embedded in that fitImage as
>>>> non-external-data. That DT is at 4-byte aligned address, so how can the
>>>> caller deal with it ? The caller gets a fitImage, which itself is at
>>>> 8-byte aligned address, but the DT in it is not at 8-byte aligned
>>>> address, so that DT has to be relocated somehow and that happens here.
>>>
>>> OK, but don't put the code in here...see boot_get_fdt_fit(). But even
>>> then, why does it matter where the FDT is?
>>
>> The FDT has to be at 8-byte aligned offset.
>>
>>> We are going to use
>>> fdt_openinto() at some point and put it elsewhere, right, so we can do
>>> pre-boot fixups?
>>
>> Look at the fit load code, cca. 10 lines below, it checks the FDT for
>> validity using fdt_check_header() . At that point, the FDT must be at
>> 8-byte aligned address already:
>>
>> 2294         } else if (load_op != FIT_LOAD_IGNORED && image_type ==
>> IH_TYPE_FLATDT &&
>> 2295                    ((uintptr_t)buf & 7)) {
>> 2296                 loadbuf = memalign(8, len);
>> 2297                 load = map_to_sysmem(loadbuf);
>> 2298                 memcpy(loadbuf, buf, len);
>>
>> ...
>>
>> 2309         /* verify that image data is a proper FDT blob */
>> 2310         if (load_op != FIT_LOAD_IGNORED && image_type ==
>> IH_TYPE_FLATDT &&
>> 2311             fdt_check_header(loadbuf)) { <----------------- this
>> 2312                 puts("Subimage data is not a FDT\n");
>> 2313                 return -ENOEXEC;
>> 2314         }
>>
>>> Perhaps we should deprecate FITs with internal data, too?
>> We cannot break compatibility and stop supporting old fitImage, so this
>> is irrelevant here.
> 
> OK, so please create a function which can detect an FDT header without
> it being aligned, like the other code you wrote. Then it will be safe
> to call that here, even if unaligned.
But we actually do want to detect unaligned broken FDT header and either 
fix it up or stop processing, we don't want to perpetuate handling of 
broken FDTs and pretend that is OK, it shouldn't be I think. Hence this 
fixup.
