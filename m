Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C501F36BA9
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 05:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796A384105;
	Fri, 10 Apr 2026 07:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A9pvJfcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999F884105; Fri, 10 Apr 2026 07:13:44 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84D083D8A
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6505ef94043so1691667d50.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 22:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775798020; cv=none;
 d=google.com; s=arc-20240605;
 b=BioMjDESLO58b007iDj+poyddnE7XvObOeXegurY2YZ1yjI33292arfLrzmhucmPMb
 90Gj5GHNmg0OMjl4oOjCc3Ex020Y7q+w1ejTi8hUKRAPooPPpMffLEw9805Euf7Oc6oQ
 gZj/+tCF+ehY0u2q1tV+Lv1ZDwbCzsa52alTWj2wQdPkkmadxAPz3u3dbdbjrAxU6zF1
 1YiOVJ5wjRAlTFWQViG9CJ9nowSPAxJT5Fb+1KY2epaeS3gfUViU2mK3yEPO4p7z6tVm
 Zj9jT5oT3t4CVDDlRODC1r4d731ga17NNelWJVz5T6AqUkWhuGpM9mYCqcYduP0UeCHp
 geyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vH7J3QwozM/VjHc2ID4tsJTcxkRyxVWWFgiH5s8nVTo=;
 fh=cQykP3aQj2paMjG6xR0nftR2rw/eVsa7v00Iwnjjxyk=;
 b=PHx1VDBNEkkNf3PuYGgHwdeaOR/0asMlqgx+M3gpReKgv0RkQRVZeohoOLaXIDaMEg
 7s5oyQVhdk/FfAffhyp8wmdeiZonmu1YrRmJwiYBJIX9dxUj50YZl9Ji23z9CzNMp3zK
 Hm1Q/bL8RI/l7nVW+laql5Q3gRUG5AeythwlOnlu0xZgS+plJ5uuNN9yBRljdHqZE5Br
 GZFOQSk3EEahq8ultXUlmzOS+NW/THrEkwQXRpIRi0Z/IymT+vy1/o0jrmB+tD7yeE4g
 2Y0FSFmTEmScIVTf7zbKILJ+f1ySQBeSbeINEOACyuoJuTXlF3luL1CkzaGcmPmA3djC
 QESw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775798020; x=1776402820; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vH7J3QwozM/VjHc2ID4tsJTcxkRyxVWWFgiH5s8nVTo=;
 b=A9pvJfcGJT/7uHKSo8XRYsgvypbkCd6HHqEGbX5V8G497830ulfuPWVGA/sw9KwVk2
 edYcK1siRtOkhoSBpcD+92d/8eCu5bUFu1o5QOE77GJ/Iu5dAkRhn82f9rzwiwI4Rjxy
 nB5KsEiM5csVoCSMgBuUszlJ+KP3+hP4cx0PVwpTbkJnNa7rgLXFGMcSb4xT8LDH7Ea6
 OJv4CVgB0KXY5ePdOGdgPKnC4Qw1OsbIF4u3nmtN8mWVZROz9cWEPuB1qB4SKx4QFSEk
 QzsLZTOQ0P7zCZzx5GYx0WDY2asTO/BYjSNwVhHtp3z7NoPOr2bebI4jBd4cn4GcSvoh
 QQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775798020; x=1776402820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vH7J3QwozM/VjHc2ID4tsJTcxkRyxVWWFgiH5s8nVTo=;
 b=XeCQ8wcFu60AHuvTKAoh1A69i9yhhxhi3HUihGxGbNg+fjbIdRcBhXhKGvuaTdzDtv
 qAz74VXw4zGYvYjGWnGbcWaIae6KdXbhQRsGfecdIn8Nuggiy7Sv5IRz9IbyBtGA9/8K
 aFXlM8jFUq4BaIMwq/gl44j6/Hx0txg9KLWKR2QwksVHEagZ15ADhZZTseiYrPLWFXOs
 IFcYMhNZDhCmmNcnjKDY0/OTyx8zxkW8aVdhc0tn3xeSKQOzyA5Wu3xUTa2XMseJehdT
 RJYYucm71N+jT543haajm1aJkrR2qvF4Cu8U2JHaoehulDT1f/ZDmWSvsYZS+/XJLYzS
 CKYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD2fByPFZTwADfRQ5plRbAHYXOIe4cnku+slReHqJ40Kshun+suZupSSGIRt3Nfs2QWqzn9ps=@lists.denx.de
X-Gm-Message-State: AOJu0Yxn8pKYqauj7fL3BkrIGMpU2669zFizlz70X3V5D2Kfx60hbjZS
 V0UgMuHXk1auBCswTE03fIJsG95Vm+179eT9R/RIo1u89DN4OJaj9O28miTxrrQg5qKQG0kUTln
 VAABKNHjwrCpR7Q4uWKKcMB/khNivK49FfRifUecIrQ==
X-Gm-Gg: AeBDievSt8i3TR7NwluyzlExh1yuMzYuT+R16iq7YYl0O9lo+ilTjraFwD9NFaJ25qJ
 vP8fGtekysai6o4QDmC7Dy9lNIfXgvY9IqOcCQZt74wWl6hmvMHenFp7Ax9FV16aexFz1gWzuDb
 zLCE9u22PfAx6HA6vCnXXkb9lEawyCBG22CkvuqZnc9ooNyGcmqrBQPU1+XfJmmihko18zie332
 nTD1ZxU3tqowLt85Tv3ynFFIpFzu/T/XJu8c0RHTZbt4vwfr6sfuOS1wN5YFfAD5T4WBn/th+Fh
 xaIDHTshSU+nkplD24dCZ8ILo794uPbpIhniMs8MTA29bIw+0FwMsLI6ClLnDOo7VEva6hU25ub
 5AiBqXaiNmxJorqjFA8zfLgO3DlaVjSdRLME17M/eWTPSccqgxINcF0pqSmhmC5a7w0TYYvRNAB
 Qu6vAxPEAKlfF863Qn6IcR2x2Bjqle9pzSbYakwzEYpidUlYhb5ntntGF+2WdBQfsCMNbJdbEAL
 ZRLL5ULbqv5jCq48TRmVFMhz+3AULUocLEloEpM2BRZkSOlhunDxF/uVN/b3Qf6XYc8UWRKVv3F
 Xnii6suT9Y2YXcyUHNEDfBvjyrv+xFVW5C7ZFvdi3v0=
X-Received: by 2002:a05:690e:d04:b0:650:dbd:6f83 with SMTP id
 956f58d0204a3-65198b7bb83mr1632472d50.48.1775798019687; Thu, 09 Apr 2026
 22:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <177547797994.70791.1169538213395415434.b4-review@b4>
In-Reply-To: <177547797994.70791.1169538213395415434.b4-review@b4>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Apr 2026 08:13:03 +0300
X-Gm-Features: AQROBzAoEzG8R5VnxY7yTgEvT8ZeLzKaGq3OJpi_noS-_1oa-AnbpH0C-TMJyNI
Message-ID: <CAC_iWj+3R3TZxTydPmG8gY_sY_=cFd6=7kBFgnZ3KYj7nkz8uQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Relocate U-Boot in the last bank
To: Anshul Dalal <anshuld@ti.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 6 Apr 2026 at 15:19, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Fri, 03 Apr 2026 12:01:02 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > [...]
> > Patch #1 - The boilerplate code that moves bi_dram from bd to gd
> > Patch #2 - Moves the ram_base calculation in its own initcall
> > Patch #3 - Cleans up and prepares setup_dest_addr()
> > Patch #4 - Adds the Kconfig option and code to allow us to relocate in top
> >            memory banks
> >
>
> Please rebase on next for next revision, for now I have tested on top of
> 075bd023c77f (master) on TI AM62p and AM62a EVM, below are the relocation
> addresses:

Will do

>
>          Memory Banks                      |  Before  | After
> AM62a 1: 0x80000000  - 0x100000000 (2GiB)  | fff14000 | 8fff14000
>       2: 0x880000000 - 0x900000000 (2GiB)
> AM62p 1: 0x80000000  - 0x100000000 (2GiB)  | ffe9c000 | 9ffe9c000
>       2: 0x880000000 - 0xa00000000 (6GiB)
>
> Tested-by: Anshul Dalal <anshuld@ti.com>

Thanks!

>
> --
> Anshul Dalal <anshuld@ti.com>
