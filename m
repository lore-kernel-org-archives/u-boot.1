Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BA606A331
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pbGX6udT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XkL4GJcG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3EFF606E7;
	Tue,  3 Nov 2026 16:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7qzOtzMy9pYj; Tue,  3 Nov 2026 16:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBBC4606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722372;
	b=O8yPPFpHS8+IQS5Ne5+zhcbvedGhFaW/1wLUu3WD5id00AjKJ2dSbwtueaeh4NT+xFnd
	 Cmmgjc1fp2cmHKCD6uP0GQHqHTO0ZHIqau94EaCgvsdKyDRFPBSXuM9c5S0XVgV9LHhsP
	 v/NUkD8kSxf94mxZq8V2lUM3pn08ViI2fnKwgop8fH/rV9DMFUby7p+IqJ6eTna33++qj
	 YHPBVczJ5a1sJkBR+oO5HtFeJ+W8mSVXKX2Zd3gmFo8gfH1yHQn7kVjzA6xAmAoR11P1/
	 K6Y7yP8i2dbAfq9XQzo/VPvpUabz9nTmZAeIFTSReEAla7+jGJAN2ms++Jo4v0QUWzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RCD5e2wbY+WhR5e7MHABjD+JJg0Z6MyaMD95UBcHesk=;
	b=ZmfKj2Se9fmznLNvBRhI9h8c4z1AZDm8E76r7Q108+3uMF1cFLi6LWbG8sFTqkUD+9VX
	 OQ9oNN7oKxemUeMNzsjf2WFbp1D18uImX9TUHdzD8R5QGwzAbjwjxsgnWJEU8JxI6BA+R
	 ptR3k3jrO8JA1clmX7PRg8ROY9eW4YS3fnW8oWlVyTKcsJyeCMQJNWTTubm/xVkVv7qia
	 Qa7qDyX/UXp5j2JHNx5+DZcVCH7NLFvczBMVXfLjNZ7g8aXbxtEnboBu9HqF/Mj6APrlK
	 ApWwbo/VKbLTRFyyQ1858T4+lGixfz25+rWqKpGaGnfTtg1HiVf6F6Gf4hGvAQNrG+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722372;
	bh=RCD5e2wbY+WhR5e7MHABjD+JJg0Z6MyaMD95UBcHesk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pbGX6udTjoRxjELRMGK2MzY7BpmEJ0A1lQii9W5XP9osYJp2qsEMJqdi5DQE8+T2t
	 x22Sl6Q4jK6OJZ59l6gKj4ddi1foxqn3CghDBAzwNlB4AjaOtz910dMDTMKf6DE3kE
	 I4FI6PvmOteHl3eZS2kiyq2OT2tCaMzS5VAoYpBe0pc8FdrwJS1hbFFTB3lI9gu4qJ
	 5WetxAmUAetPUcPNNtZrYgw9FWR8NsqDdFmR4ri2+P1IdPr+ugf0tSm10Whh4CG4pg
	 kZxBqhxXHuv5MC2s2gYaARocgnMB+wDiKjYOoio409tH3uyNdI6ujrY3mRJXtp+818
	 +a6LxjQf9yXJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBBC4606C2;
	Tue,  3 Nov 2026 16:12:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C86AA5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0273E400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lBFBYtidbFkf for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:12:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B4A0E40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722370;
 b=J2xe8jFTFctGp3IqXVMCXj5vBOpYRM1wf9lOkwwDsXwJ4djG3K4fH9RlpSvL+Z7EAO4C
 X7MkA4Nkezp4D2Njl3IF434yDHL6O/CU1AECMAnPCfYiUb7eQ2ylD8ICDnAuAyzTRaNNq
 6VStC2MUImETLQJRtjcf+iPqCrdrOgbc0OGN20iD+vdYDIH/Oe7sylvN5jHv8A0raZTS/
 9wQB17bBCTquCB8k+3xiVXsdI9URtMHqeKxuTUEifz0AnSaJQZvOrBds5kN0HlTv+49Ni
 OeKKf8u73+FHuz4mhs11ghpH0TaxlZrmW3tTqtiQG8YFxrN3WhEZKjrg19kPePKtBtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722370;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=RCD5e2wbY+WhR5e7MHABjD+JJg0Z6MyaMD95UBcHesk=;
 b=XsovXrMvGrgUnRUixX3xY0ybxDTXowDK+QYCyerm9KgWh0evXab4rVvFokxMAk0fPvk+
 E3xGpm0ZDvsatmGI2htm+qv+KKi0CFxjRqJ0b5CIgGKzeRxPKn4m2BS2Qf+PPLWsgEqmI
 G8LWh7uD0gPRDdYaqRcVmVkZoi3zVYXGXn+JXT2MSSq9oYZV/7UCdFQy7dETA0gnSbO/8
 1fBnpi5BZ6yx0SBAebSeVhIRVIVtVP5ayAXYhcQDJe57w69uBLVpZCXdLr4JflfJq0vYV
 R4KTozK1m2efkQjHuNM055orBOVkFoqY0BMtvoReypJMV67rUv1UUMes2th0tWLrdBQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XkL4GJcG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XkL4GJcG
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4A0E40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:48 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso34910385e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722367; x=1794327167;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RCD5e2wbY+WhR5e7MHABjD+JJg0Z6MyaMD95UBcHesk=;
 b=XkL4GJcGMaYbrK1UdAze7d5n8khiLStHDC4jj2dF61YvMh+Ku4v9wmqeu0BPqNl2vy
 AjWLa85hwc3aFmRrAhqLb5DXPr1Y9DkX+i+yMt21FMmkxygYPx8umlISICddjsM+v/pd
 QwFGTW6uBdVfe7XQgCVghMXM2jgLT4zOCtB460gnSelOU41rNuFdGhrNBNOWoKGZqKzw
 O0vntRm7h8aHT2CCjR/rnaTN7kA29S85+VRNop5cgAuOT6DeuD9MEuzwGoUfeP+UcwZz
 roqTQmfsLDsQDdtrpt/7U6e2+W1TZQdLyDWjw51yhEcxlbZhFtvXTyrOF1eNXhYgYaMg
 RI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722367; x=1794327167;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RCD5e2wbY+WhR5e7MHABjD+JJg0Z6MyaMD95UBcHesk=;
 b=WYLgLOzjFmCT3WLdQR8N7SXuzCPPGygzQ7t8rLnItB7N5fJ2YKGUVoyQuNXGrpGQYu
 hmToOCEW3RoaPN5pBjVCBGB0WIH0FBlcuExh1UTNVFk5YfoX4/m1bBYAyePxB4JhhY5V
 t5bcdhZ1E4+nytEmOt/8/2R4GkxN0X+V1YU7LpgYvjKDWgG3E/LlE7JB7EMK/mYML37L
 AsbebcP9NhWHGTurZhHLQHpa+keo2zwY6bWu6MpSZcJ/GE2vdIZWz8FgSClhLlzkoGwE
 lsRXQ7YxWd/8fsvxqyClP8+gmfyvxAN/5LwaeOlsn8miDBji7uTXlVwII1bFOJj38OXo
 JObg==
X-Gm-Message-State: APuU4Z8q6tbdTj5Ae2Ma/76+pJwuckf1EVqGHVxOD58U8UDiLFnAEadF
 Lb73urcP5wTXMuXuiBC8IjyoebURd/2Kcw/HeociXjmY4myfNz4K9mT2TuH/2Sl4uwckjDW2
X-Gm-Gg: AYBFou0zwg39Z5hXzzz0dK0huIYuL9tuXPIXwPsUnsPeGzz1qzNAv7631ctter/TalZ
 uvMRb0k27GCp6R9NK8FdtaQ2Ij+UU3eLs6KrdTSz7RpCd9Z1ecm07eZ4QOfcKN2vfmQhNRKjj5B
 yfMDV+qlGBK1I377HaITLrK8cpo8BvOeTMdzh40mSAUZHMUY0tYES0WXB65p9bfmeQg7Ek+BGpS
 HkV0zpbWqeNBQyHZ2g1OfSLzaUHFuWGPiNvlfwbkE1USyqjQ9QHPw3oE1wnwAbiAp9fgWtZpx64
 0ZxxcqP9H6yTxws9PZnyJbIs76DnKQdXanV4ej9GIRdQAqgbUDbB4t46p5Yiouj6t+RSM2WRuE/
 NDDqYqlp6zS7ibst+MEq1MB4AWmjdFaAcxH6FkgZw4SyVVUj8wzF2NPkqeIvDAOupcsNMyYKPus
 CfVeHsj3R4XbX2HhTDZYY1Pnt2EuppEnxb5LIhg7FFt/7rzw1/R8BrD/uDr13OSypwdyJ386lLY
 CMVILhcwjxsUkPImEpyMb4+iTEHarYwc0V+laYD0lApo58Pys1V+HTUN8ICHDkf8/Bm8n5NABCl
 wOXrL8W0aIf5PAeJ9ORzGUU1E7jEc9M=
X-Received: by 2002:a05:600c:811a:b0:4a6:b49f:9ae5 with SMTP id
 5b1f17b1804b1-4ac18e5dac8mr282433755e9.34.1793722366935; 
 Tue, 03 Nov 2026 08:12:46 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abebe33e79sm258473505e9.2.2026.11.03.08.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:12:45 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 00/11] efi_loader: check PE images before using them
Date: Tue, 03 Nov 2026 16:12:44 +0000
Message-ID: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
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
- patches 3 and 4 have efi_load_pe() reject, before allocating the
  image, a section whose end wraps around and section data past the end
  of the file; patch 5 makes room in the loaded image for all of the
  headers;
- patch 6 checks the relocation table against the image;
- patch 7 rejects a certificate table holding a certificate shorter than
  its header, which made the walk loop forever, or longer than the rest
  of the table;
- patch 8 refuses to load an image whose subsystem is not one of the
  UEFI image types, as EDK2 does;
- patch 9 marks an image whose TCG2 measurement failed as not
  authenticated, so that it is not started unmeasured;
- patches 10 and 11 add unit tests and a Secure Boot test.

Patch 9 applies on top of Heinrich's "efi_loader: handling of missing
TPM in efi_load_pe()" [1], which does the same for a missing TPM. The
other patches apply to main without it.

barebox, whose EFI loader is based on this file, made several of the
same changes this year; patches 2, 3 and 4 follow them and say so.

Valid images are unaffected: the unit tests check PE32 and PE32+ images
with 16, 6 or 5 data directories, an unpadded last section and a file
alignment of 0, the EFI selftests and the Secure Boot tests pass, and
each patch builds on its own. Tested on sandbox.

CI: Azure build 13728 passed, all jobs, with this series and [1] on
https://github.com/u-boot/u-boot/pull/1064, a CI-only pull request,
merged with main ab4dc5aacf9:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13728

[1] https://patchwork.ozlabs.org/patch/2335140/

Changes in v2:
- rebase on current main
- patch 1: declare the NT header pointer in efi_check_pe() as
  IMAGE_NT_HEADERS64 *, the type its size is checked against (Heinrich)
- patch 2: require SizeOfOptionalHeader to hold exactly
  NumberOfRvaAndSizes data directories, at most 16, as EDK2 and shim do;
  check FileAlignment once, taking 0 as the PECOFF default of 512; drop
  pe_align_size() for ALIGN() on a u64; start num_regions at 4; say why
  sorted is freed on the error path; drop the wrong remark on barebox
  (Heinrich)
- patch 3: say in the comment why the sum wraps on 64bit systems too
  (Heinrich)
- patch 4: check all of a section's raw data against the image, also
  when VirtualSize is smaller (Heinrich)
- patch 5: allocate room for the headers instead of refusing an image
  whose headers are longer than its sections (Heinrich); retitled from
  "check that the PE headers fit into the loaded image"
- new patch 8: refuse an image of an unknown subsystem in efi_load_pe()
  (suggested by Ilias)
- patch 9 (was 8): mark an image whose measurement failed as not
  authenticated, as [1] does for a missing TPM, so that LoadImage()
  returns EFI_SECURITY_VIOLATION and StartImage() refuses it, instead
  of refusing to load it; say why an image that is not measured goes
  unnoticed; retitled from "do not load an image that cannot be
  measured"
- patch 10 (was 9): test the subsystem check, a file alignment of 0,
  more than 16 data directories and raw data past the image beyond a
  smaller VirtualSize; the headers test checks that the loaded image
  holds all of the headers; the measurement test expects
  EFI_SECURITY_VIOLATION
- add Ilias's Reviewed-by to patches 1 and 3, Heinrich's to patch 1

Ana Bobillo (11):
  efi_loader: check the NT header size in efi_check_pe()
  efi_loader: check the PE image ranges in efi_image_parse()
  efi_loader: reject a PE section whose end wraps around
  efi_loader: check PE section raw data against the image size
  efi_loader: make room for the PE headers in the loaded image
  efi_loader: check the relocation table against the image size
  efi_loader: check certificate lengths in efi_image_authenticate()
  efi_loader: refuse a PE image of an unknown subsystem
  efi_loader: do not start an image that cannot be measured
  test: lib: add tests for the PE image checks
  test: py: test invalid certificate lengths in signed images

 lib/efi_loader/efi_image_loader.c             | 364 +++++++++----
 test/lib/Makefile                             |   2 +-
 test/lib/efi_image_loader.c                   | 501 ++++++++++++++++++
 test/py/tests/test_efi_secboot/conftest.py    |  31 ++
 test/py/tests/test_efi_secboot/test_signed.py |  36 ++
 5 files changed, 832 insertions(+), 102 deletions(-)
 create mode 100644 test/lib/efi_image_loader.c


base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
prerequisite-patch-id: 1a9ac95eb73ee7e45e338735a4b05df5dc7060ac
