Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC0606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ff7ZEWG+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKMGFpFR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 568FD60A9D;
	Fri, 30 Oct 2026 06:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5lcRBP7Bcuu; Fri, 30 Oct 2026 06:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E22F60A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340822;
	b=ESxST67hsAikU6vhmHJV7joVHbFvTK6IabAe+KQpnRkvPYaB6qRGgxS33ruSgplK8wJo
	 l7Gxyg1yqFaQvPI2dJnnnH0pepAOF9A15KrLNOACXFZPz+p8i69tM6CbQLnlGAHi3MfnU
	 0SDZ+XX1c+jWw2PSw45Pv8VlXhxisHKniETrK4Tnpm/xAS8/TX0yfnDQw1UyXEC5Imp9A
	 hL1QDkW1QRcn7SujKHh8wGMUWCGf+LLVn9sbVF4GyINDYarjoaH9ANfa/Nu139jvjjw8V
	 AJ/swUEVDc93wocRmffKI9SsqsaZd1PuDzPJ9kVGNaL5UEQuDtcbn9LqUsXD4+fc0/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d6A8Yje0EI2WkXcgibN2CZdtD+nT4D9AgV+9BTSJKHA=;
	b=fQeRP8WMjgvvQZuehN/G+RwlRjfM0h2+sUXttMoMhdm/WsbWNDFtixAvMOGXsBapJCDD
	 3qIote8Hu3q62blwz7U1fmRYpnkxkOpUwgmOztjsWXInp8yIwlOuO4mVpOPVgq+taQqlI
	 glF2IUO1QYpwTtK/ULoK7bz9L0ORE0B6q7XGKy5YCugvsMe7iDAzEsurYXsjgvxRwwfjf
	 3XofOMF+XHs5RlVgEmb8Mk73oQMhyTX4WvXTa2W5kO9rTv9ImxpHuNrGYS2z3Y6+nRGpc
	 KpTXnf0EKxqVpQJ+v+rCWLhiv8ADDd6jeYP1toNoxa/Dnu3oChRnJi/dilY4ntV4KeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340822;
	bh=d6A8Yje0EI2WkXcgibN2CZdtD+nT4D9AgV+9BTSJKHA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ff7ZEWG+a/vT32qX9CDUsPYsH9oNU+v0G2pk8MiQEsEtcyqqNmqzy+8+jAvztk4F4
	 F9+xSN+YzKeIn7uN1tgStWweRu8dKGGPauZZtb1SwAVgqkxNlxskxnJGxIM69eo26W
	 WZ/51Z8jApCZHIMOFKNnoTC9Xp1eY22ITKBbGkqL5P7DpJj/VADisDO0uIOwsjNEDc
	 k3JUw5GD/kRbr+wbeyqg5jcW08AGkF7x6/8BM+DpRW0q9vvrH7dr/TLX7dgkOtpKhf
	 g6YX9lnCnaT3VEUgB2a8Cm5tgbaJ4rpogijYwE7iTVwJl1mUBx838QVw9SJYWZMO8/
	 CyXzPVcRy8hMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E22F60A70;
	Fri, 30 Oct 2026 06:13:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8237712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9DDD4051A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CaJnPFYDH4zX for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:13:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7484A402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340819;
 b=r9oEzwvQ6rvMB6NGn2PLs1tcdorzik4abiQkZFigBzv6CfO3sX1XZnwEisSpKjaM8pMl
 YKY/QKx0StXbgAC/YLFSJOnBqu0cSoJVjQG6hQxtefuMA763OKnELE6mCXtao0FpazBbr
 XvomrhGHRSkB8DjMWWqDCW+zU+FVN+XPrnPpMG3J/HV/rZQCc1qq+ryj5ap7qZ9WPeT5p
 mfPek4yvPO4HUhE/Kho/IAY3DQkeBuT7loyESl8S85j2lpPA3NtPFSL9jbGkz+Kzbu5Gt
 Au4M0ZC/qphuaJOwrKkDAnNKrZreMw5KgrP6e6QHApQuk+g1DlxguOq1s/4kSDeuchQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340819;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=d6A8Yje0EI2WkXcgibN2CZdtD+nT4D9AgV+9BTSJKHA=;
 b=gTZ9lIiBOsCdPHoF4hjSyPcW3sirzOwOobt/EtJt6RNOzLUvVf9MMhPTRc4K4BcWlW6I
 G3vfucXJU0meXGmdtBEkqD/VHXLws8oX4xKQQNzfemyPW7ujQhwuXlVJ3G/iDk1Jk/SYg
 4GS8qav8T9e/zS2n9GvbpUmT+YV2FP8VcXFhG98SwyG8WUwo9xnfxEtHjpJFSW6iIga4T
 tjWOpKxyLKk7eHEMufy6UkQ0UsXG/gVeTww+6j7pZcldlq5UE0jHNh4xNIotbqRvWw3TQ
 WS8HrX4SF+zvEfBni5z+O/rZSpPuryq0K5TsCe1XTVdhHj4DHunw09xqO1uVeDf1WNg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qKMGFpFR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qKMGFpFR
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7484A402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:38 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso936005e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340817; x=1793945617;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d6A8Yje0EI2WkXcgibN2CZdtD+nT4D9AgV+9BTSJKHA=;
 b=qKMGFpFR7EGCHqwfr7S8Xi26V3r5UkvT6IjyagesnfcjdIteGSn1LCFBLZZObMFIyy
 9JVsKguJnxXmC7KFjtJLadqL7Gm7R0Vp4sytE/WsM8+jM0SlgPjqFIfv1nea6griipwF
 1NXzrvIwhPl8XoWrO2xZKR2NGxW0eEm2gZZgOfa7XHM2dwGe0HmYqE+pluk93QEhVR9G
 L1pSqIpS3hbPhY7sBeAU8TPa2bhUwJLank12WIvqsFz5AKrSx3KKbBo7ET4ucLG4a/f7
 b2q5U5slpELNxBs1QvjY7yLA8/ihiZQtbnl/3pL3Aa0OPaqY6R0YuZJiLX7Xne1A8Rz+
 iVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340817; x=1793945617;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d6A8Yje0EI2WkXcgibN2CZdtD+nT4D9AgV+9BTSJKHA=;
 b=JMovJhxyVM8aBdzuZqcEJjpbwysYyND8ApsQvDL2kf8QCLmrHxBwtc00DjDY3N5/jh
 1WMCu+C8paeeHbHaFbdQpLFmp4sQ8vr71kXWYjQalw9iP5IgAEi29sGq8lsoumnjj2l1
 QA9bzzJ6xFf1DPOMEzdf8UYviJyZKqn+3w/ZxbKvqar3fHG7BGvMMmTzKjEi4lGfcm37
 Tq1ac2uPs5GJH3tlNAeU8EZaZLdRfW3a0Etaj0LnskOPHqyAEiAsxkGiE6R6iWFQae8Q
 Clp5aYI+HuiDwJ0Nbr80UKfiUnwB6462fQfGo3GUBksfmQPBgH7f56bHCGVkYkgw2h5g
 A2mg==
X-Gm-Message-State: AFq9FYKJNcMB5xW4r0b/tA7a4W2UqFlsKxtPCRUWc72kmBTJiTjh5I24
 GesmFajBkjlvdvUq2iS0IwBDYPvjg12cNysXr9om9Fs+7kwFDsMhANnByGHAkC6uCMU=
X-Gm-Gg: AYBFou2yyTOURS0DQD+qpAk1VBWTMcVt/qYh4F/2F48CDTlTC+l/Vdp86T+0VrLWUdI
 bWDWps1bs3vq66kzRYgrOJDf2MOeRifVKdx2q5CIZDMKJIBCZpMsgi+qAGtUlcq7VjVmP120E8v
 M+VSlGXrYP+dWSpbaoSWecstay0wVtjXbNe3xpgsXYPgtyP/WE6+YZhj5hZGro1ulSZwJowsLWX
 8GzCe+dWXr/BlLe7NOBz+z8aw3FczxqkQP0PjroeSLGH30LejzW/P92jJXyqHWJ60RlVQoA/shm
 roN5wzV+hqsp/pGOIRmOmS0MyGh7TdHt2Ye28AaVu0H90xk4Kk09JBdRDInv/qdIiSrlFzkxz6g
 yyaa81sCvvxNT6t5Vjd3PNmkq6vx0wW5gGkF5+7Pb28tue4jjPkWISqDOofjku81d5Ba+LCZwcq
 dtN5+Kh1BKsCh//Fe9XelbseallsrnOThHOKUGVBZneGcGQXKNLAF+B78ruf0wDwlmp+hkNM442
 JEhMN4wxGUXnM2wfIubI03HucSng7/cqwxztvU1LqhQb2upMuXZNL5Bgofy78pcHOWDd6II1c1o
 9Y4Q74OXjIijFwu5Ppd02gbsQASlHZ4=
X-Received: by 2002:a05:600c:138c:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4ac1765d3e8mr23181195e9.19.1793340816497; 
 Thu, 29 Oct 2026 23:13:36 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1076sm39647695e9.6.2026.10.29.23.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:13:36 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/10] efi_loader: check PE images before using them
Date: Fri, 30 Oct 2026 06:13:34 +0000
Message-ID: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

U-Boot takes the offsets and sizes of a PE/COFF image from its headers
and uses them before it knows whether the image may run. With Secure
Boot on, efi_load_pe() authenticates the image first but goes on
copying and relocating it when authentication fails, and only then
returns EFI_SECURITY_VIOLATION; efi_image_parse(), which collects the
regions to hash, runs before the signature is checked, and so does the
walk of the certificate table. TCG2 measured boot parses every image as
well. So an image that will be refused, or one that is only measured,
can make U-Boot read or write outside its buffers, or hang.

This series checks those fields against the image where they are read,
along the lines of EDK2's PeCoffLoaderLib and DxeImageVerificationLib:

- patch 1 has efi_check_pe() check for a 64bit NT header again, as its
  comment says;
- patch 2 checks the headers, the sections and the certificate table in
  efi_image_parse(), and fails on errors of efi_image_region_add();
- patches 3-5 have efi_load_pe() reject, before allocating the image, a
  section whose end wraps around, section data past the end of the file
  and headers that do not fit into the image;
- patch 6 checks the relocation table against the image;
- patch 7 rejects a certificate table holding a certificate shorter than
  its header, which made the walk loop forever, or longer than the rest
  of the table;
- patch 8 refuses to load an image whose TCG2 measurement failed, as
  EDK2 does, instead of starting it unmeasured;
- patches 9 and 10 add unit tests and a Secure Boot test.

barebox, whose EFI loader is based on this file, made several of the
same changes this year; patches 2, 3 and 4 follow them and say so.

Valid images are unaffected: the unit tests check PE32 and PE32+ images
with 16, 6 or 5 data directories and an unpadded last section, the EFI
selftests and the Secure Boot tests pass, and each patch builds on its
own. Tested on sandbox.

CI: Azure build 13710 passed, all jobs, with this series on
https://github.com/u-boot/u-boot/pull/1064, a CI-only pull request,
merged with main 03e45557e1f:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13710

Ana Bobillo (10):
  efi_loader: check the NT header size in efi_check_pe()
  efi_loader: check the PE image ranges in efi_image_parse()
  efi_loader: reject a PE section whose end wraps around
  efi_loader: check PE section raw data against the image size
  efi_loader: check that the PE headers fit into the loaded image
  efi_loader: check the relocation table against the image size
  efi_loader: check certificate lengths in efi_image_authenticate()
  efi_loader: do not load an image that cannot be measured
  test: lib: add tests for the PE image checks
  test: py: test invalid certificate lengths in signed images

 lib/efi_loader/efi_image_loader.c             | 368 +++++++++++----
 test/lib/Makefile                             |   2 +-
 test/lib/efi_image_loader.c                   | 442 ++++++++++++++++++
 test/py/tests/test_efi_secboot/conftest.py    |  31 ++
 test/py/tests/test_efi_secboot/test_signed.py |  36 ++
 5 files changed, 781 insertions(+), 98 deletions(-)
 create mode 100644 test/lib/efi_image_loader.c


base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
