Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E47BE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BEE80107;
	Thu,  9 Jan 2025 16:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fzxiEWOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F95F80601; Thu,  9 Jan 2025 16:08:13 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 887968005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so1830452a91.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736435289; x=1737040089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5rTO4nendVka1Gm0lA4o/R65fB68qlSp5Z2PfRymXHY=;
 b=fzxiEWOWIEx4DZQ0GQ8mCXIlOiPQxtmQC7NItJxREgkCo0oXUDFHaie7B3b5fb5dnb
 CiGDI3fmo0QBIZi/DCeFA1U8w2Eane2BXl6e658m3Mn58OyTx7inMgOJI0GImsuFDSPP
 eyIFgJpLzRBXrM2jZd+43npipJ2R1yvPGQwb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435289; x=1737040089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rTO4nendVka1Gm0lA4o/R65fB68qlSp5Z2PfRymXHY=;
 b=pJyck3gx8AOYT5yhD9d5XKbppUI/sc1f1IsJH4JT9/a3Y6/86e5+3eZJug87Rw+jmV
 ioabRR/e4KhWzvrhA4lMxYveL8FJICjEeQ84+2/15ZjNmDNotvzJe4lfFxaMk95Hbgmi
 iUshU3OBQhtK9Ro36c/4soZ5c2I5zlm19JpIj43PRfFITFCwcDBwQUVDYVq0xA7puwHg
 JaQIgtICXS4+/Ox0BBtUukyrhF/SvhcsyYGa02xjNI2IDB02YMB0vSPbUDR3GW1KZw1J
 FNUmK98rJnvb7m6Ub8cfwvUj4Da/xLIxlHwoQCq2ABl1NX5omqo6cwT+X6hjfy/IuICS
 kLWw==
X-Gm-Message-State: AOJu0YxhYEf+XBTx1JIVqOi2p6tjFZ+WFNF81pJNhTnkEeUZeGx1N86Q
 BgopPe9yfrN3+JVI2P+4QozM+MRv+3C+4nkJ973er4I5WgJbktUdt+OEwUGAEv/g9Y06xilwyNY
 Z6A0RU46sA/bZQlPo295TOfZhud5VyjdqXyli
X-Gm-Gg: ASbGncu3OO2DuNDCpUbSNUyxSORQ9v6F1lSUnPjXq+0o6zd0E3IUUJA8e+q8hFtYENv
 M0HE/Z8QiIRrkoKJljFQIOiKpoDyEGwqEaGVmCpY=
X-Google-Smtp-Source: AGHT+IEWhwsH2raVzxtECq3X65SvzE9t7Z4jopY8LlRefsAHTK+nxWaDE3YGV6zVIEvnI7zq7Qwvgp7us5ZqYkvL474=
X-Received: by 2002:a17:90b:2d88:b0:2ea:8aac:6aa9 with SMTP id
 98e67ed59e1d1-2f548f69ff3mr9317345a91.21.1736435289111; Thu, 09 Jan 2025
 07:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-6-sjg@chromium.org>
 <CALeDE9M_Bgaxom1Ac3Uomu=Mnd+mvKeGNAsHxn63kve8qfwzUg@mail.gmail.com>
 <CAFLszTitLSCc71TUV8fB0dzWFQwRxO8mVwhwao6ornPGc3AamQ@mail.gmail.com>
 <CALeDE9Mya5U1LfcUuNU9SQtpqpKUG9vXOkYmjo=9H39nz=YvQg@mail.gmail.com>
In-Reply-To: <CALeDE9Mya5U1LfcUuNU9SQtpqpKUG9vXOkYmjo=9H39nz=YvQg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 08:07:55 -0700
X-Gm-Features: AbW1kva-cIPBPz68OTi5kHDuunMT0asl5CZyWe21J2ArH4LBOQ3fxN0kOXL_msU
Message-ID: <CAFLszTjj7Y9X==P=XXZZ=_KwrcMhF7NMKoAJCONeeD=0Cd2pWw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] rpi: Use the U-Boot control FDT for fdt_addr
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>, Francois Berder <fberder@outlook.fr>, 
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Hi Peter,

On Wed, 18 Dec 2024 at 09:26, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon.
>
> On Mon, 16 Dec 2024 at 00:27, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Peter,
>>
>> On Wed, 11 Dec 2024 at 09:36, Peter Robinson <pbrobinson@gmail.com> wrote:
>> >
>> >
>> >
>> > On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> The fdt_addr variable is used in extlinux as a fallback devicetree if
>> >> none is provided by the boot command.
>> >
>> >
>> > And what about where extlinux isn't used?
>> >
>> >>
>> >> The existing mechanism uses the devicetree provided to U-Boot, but in
>> >> its original, unrelocated position. For the rpi_4 I am using, this is
>> >> at 2b35ef00 which is not a convenient place in memory, if the ramdisk
>> >> is large.
>> >>
>> >> U-Boot already deals with this sort of problem by relocating the FDT
>> >> to a safe address.
>> >>
>> >> So use the control-FDT address instead.
>> >
>> >
>> > Please re-word the above, it doesn't make sense to me, "the rpi_4 I am using" .... what about the other millions of RPis out there?
>> >
>> >>
>> >> Remove the existing comment, which is confusing, since the FDT is not
>> >> actually passed unmodified to the kernel: U-Boot adds various things
>> >> using its FDT-fixup mechanism.
>> >
>> >
>> > Don't remove it, re-word it so it's up to date.
>> >
>> >>
>> >> Note that board_get_usable_ram_top() reduces the RAM top for boards with
>> >> less RAM. This behaviour is left unchanged as there is no other
>> >> mechanism for U-Boot to handle this.
>> >
>> >
>> > The below looks irrelevant to the patch at hand, it looks like it should be in the cover letter.
>>
>> Do you have any comments on the code in this series?
>
>
> I did already comment on it, please go back through your emails ;-)

The only thing I got was some comments about the commit message and
the comment for set_fdt_addr(). I sent a new v4 here:

https://patchwork.ozlabs.org/project/uboot/patch/20241220003447.2913443-6-sjg@chromium.org/

My question was really about whether you are happy with the code itself.
