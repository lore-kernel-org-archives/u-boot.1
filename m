Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DB2C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 09:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C042F88977;
	Tue, 16 Jul 2024 11:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="r5nbIW4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAF488980; Tue, 16 Jul 2024 11:16:34 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823D78876D
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 11:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266ed6c691so33316755e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1721121392; x=1721726192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GZ2jPlNAm2ONX+mr472sZWwnWPOhO4fI1/oRrzh91pE=;
 b=r5nbIW4igYk4B171M6N6nkC4U4vQ5MUehf0FxUjSNxrVuJHFPJuL8bZNbs9IXuOYic
 vLXql0F95q6l9ikhzrBuXMeEPJJqCbixI9PbyKWvLMXDGTiZdQnR2IXUUYCookBmbYy6
 fX7Wh5NxOLNPtzBBGM9CpmpKybAPKH1E94GjSB/ilUEbMpYDvUzP8Ua5Vx51WVtongNJ
 vFW+JxRuRHdY1wr05YRUuLlUDr3XW6pAp4GnVZeEv7X5YGn7Q3fARI6gTvJM5/fw76lY
 TGTlrh6EEYPoAC5Zq+wYWI9ojp4Kk7tlBy2+AhghnIqpEu8V+k3U5fArfPVUnstbKiwZ
 zFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721121392; x=1721726192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZ2jPlNAm2ONX+mr472sZWwnWPOhO4fI1/oRrzh91pE=;
 b=wM5qABncZTiiWkxX04UKt3hpqZ/FTiI7V/pnhJi5nxijhR33/A+somzMXra1Fl1kIf
 Ms29/3T74rva/dEXLastbri/tScpZlcEOuEHPw9G6LeBXpzYNJ4LZ+OZs1LHnCQhThAR
 TYty+KGdlAkCy9WnQmOFhfkGk20rzt/w8Sq26MzM28DKgr7Uda3M7nH1mV7LeR+pnuxp
 yvNnRHRnS2g/nRk/W4Rggs6qMDero+Yi3m/zMgH5C0WIjNruNEcgN/3pJl3Q4wZNghOR
 V4g3EIarMkzB4HwyriT9tGE/axUJpoKBTrWmBcJID1WcNcVhCv7U6o1QeKxtPydQduiC
 5GdA==
X-Gm-Message-State: AOJu0YxSFE2+l6G5vgktIIX4laLHwhcy4DP44aB7K/I7HzGrIl/y6gMA
 Om4QwYPmN3viiBi90osWhKTTOrO3WgN49LxKnxt5e+wSb3l4DyycGUMWR90DT22yn2wEiivfpMU
 V
X-Google-Smtp-Source: AGHT+IGHRJv3athRiei8PV950ta6PNvBvRJRqfgdVPxHa5hveXXcuQYO68NRjfUTW9facCgmaSIU5g==
X-Received: by 2002:a05:600c:1383:b0:426:67ad:38e3 with SMTP id
 5b1f17b1804b1-427ba654c0cmr10932495e9.3.1721121391758; 
 Tue, 16 Jul 2024 02:16:31 -0700 (PDT)
Received: from blindfold.localnet ([82.150.214.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23cc5bsm149625925e9.2.2024.07.16.02.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 02:16:30 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, barebox@lists.infradead.org, s.hauer@pengutronix.de
Subject: Various Integer Overflows in dlmalloc
Date: Tue, 16 Jul 2024 11:16:27 +0200
Message-ID: <2561107.TLnPLrj5Ze@somecomputer>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Hi!

While inspecting various security aspects of U-Boot I noticed some
issues around dlmalloc and asking for your feedback, especially for the
first issue.
I'm CC'ing Barebox folks since Barebox seems to be based on the same
dlmalloc-implementation as U-Boot does.

1. Integer Overflow While Computing Allocation Size

malloc/realloc/memalign take an arbitrary request size and apply
padding.

=46irst, the length is (imperfectly) checked and the the conversion happens:

  if ((long)bytes < 0) return NULL;

  nb =3D request2size(bytes);  /* padded request size; */

The problem is that the request2size() macro is casting the requested
size to an signed long and adds SIZE_SZ + MALLOC_ALIGN_MASK:

#define request2size(req) \
 (((long)((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) < \
  (long)(MINSIZE + MALLOC_ALIGN_MASK)) ? MINSIZE : \
   (((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) & ~(MALLOC_ALIGN_MASK)))

So, any allocation request between LONG_MAX - (SIZE_SZ + MALLOC_ALIGN_MASK)=
 - 1 and LONG_MAX
will cause an overflow and as a consequence the caller will get
less memory than requested.

e.g. on an 32bits system malloc(2147483647) will succeed but allocates
only 16 bytes (MINSIZE). I've tested this with U-Boot on i386 and ARM.

This is a beefy vulnerability for exploit writers since unbound allocations
do happen. Like in the ext4 and squashfs symlink code, I'm sure there are m=
ore.
If you don't care about verified boot, it's less of an issue, though.

I'm not so sure what the best fix is.
Mostly because I'm not sure why request2size() is anyway casting to long.
The original dlmalloc.c implementation doesn't do so. It has also a more
sophisticated overflow check, which is also missing in both U-Boot and Bare=
box.
See https://research.cs.wisc.edu/sonar/projects/mnemosyne/resources/doc/htm=
l/malloc-original_2src_2dlmalloc_8c-source.html
Lines 01938 to 01962.

I tracked down the bug to ppcboot, it's there since day 0.
So I don't know what's the intention behind casting.

On the other hand, since over commit is not supported, we could also just f=
ail
if the requested size is larger then the total amount of system memory.
I'm a little in fear that more overflows are lurking in the code.

2. Integer overflow in sbrk() (U-Boot only)

sbrk() does:
        ulong new =3D old + increment;

        /*
         * if we are giving memory back make sure we clear it out since
         * we set MORECORE_CLEARS to 1
         */
        if (increment < 0)
                memset((void *)new, 0, -increment);

        if ((new < mem_malloc_start) || (new > mem_malloc_end))
                return (void *)MORECORE_FAILURE;


If old + increment overflows (increment is a ptrdiff_t) then
sbrk() wrongly thinks we're shrinking the heap and memsets an invalid
range.

I propose as solution, applying memset() after the range check.

3. Wrong ptrdiff_t type (U-Boot only)

U-Boot defines __kernel_ptrdiff_t to int for both i386 and x86_64.
As a consequence, large allocations on x86_64 will overflow the increment
parameter of sbrk() and less than requested is allocated.
I suggest defining __kernel_ptrdiff_t on x86_64 to long.

Thanks,
//richard
=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


