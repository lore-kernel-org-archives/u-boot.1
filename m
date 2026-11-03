Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D80606D809
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fsKUaJ3X;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qyhp9UDj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF596606D5;
	Tue,  3 Nov 2026 15:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vFicgkgndiBj; Tue,  3 Nov 2026 15:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE1B36069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720015;
	b=WZlp+rwNm71Eiye5lStkw+lRXvi+35ja83NmDL6psvUJQJJJc0GlS5+ZA1qOeeDYyncp
	 q4Jp3jypmwVpd/J6XrZ32gnZEkdTpvvDTuZ6ivyyqHu+JVX2Vb8Tm2i+MF2AOrAp1ri0g
	 cbZnMLZezSrZ69Bk0feJ1TlM8YxAYzwddVqioDdMi5hFv7b8tPehmyCWc6FQ8bpkORU9v
	 /7wCP5RQP7Zz3S+TdtZy+lBGWO8kY5/osQ4NJol5nQH4Y89JhxXAlV6sgV3KrzdqUCpYS
	 fBJbb6d/A1+x2d3dIhXniDKuWj3dvEUnGz1LoGGyShD+dwBR7qz2AHz8W1fwhrFjbUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z500w/xuSDR0jxGN4i1mhDco9PLWZFVbJ7h2bkVV4yc=;
	b=c7/oD2SnfrD849GElPLGxYEozQPZmgQNAjhAz/NbVKDeW0u4AorUxqxkmg1Y8lXaC/k4
	 5cNkuBST+P/Qi/YMFP+bWJZP+zxEL68NyUhB463me1+G8xI0n2+k0yoaK+wS+Tx1MiIhe
	 I1f49H7USur0WwAWCTbLrG08qqHhjOqEOF0vZeVGgdsWE/HRQ+TvjPRE9C6GadVTdGui2
	 RvEl+OSMKf+OSt0fSZyoUnAvutAxs7Pd+iOAuz0QnAOUmWiKm1UTRSL2+qJgA5kbqNPED
	 QDdkxsdSGQnH+ZvbL4o/CcWTihZGIz0dAFc9mvgH5wGDKR2KWKVasX91iyOrtyxWRtg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qyhp9UDj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720015;
	bh=Z500w/xuSDR0jxGN4i1mhDco9PLWZFVbJ7h2bkVV4yc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fsKUaJ3XbMtGmFYZm9U9N5gnJJ1Ft58bof2CluIA+b3G01E0ASYp1jyj6M9ezWVlq
	 Nu+uMgyHBQhpN+Up7N/ccOmUWQaZmLPWO6kr4brZejX8Pyhw0pqjt8ch24/nsQLdoW
	 4aw21Ge2PWTRHWomqUuYw+AmPyFLzRYe2J+Tyn41/Ljtc4vMwVDG4NAJtp0Kw3p5o2
	 PVq1XnYKPX+okxXh275G+YQC281PLlIASbXcLlSwaQwfIiiwVb15zn69EVzjBcRXpQ
	 mfcBmMLo3n3MSFnV1ybHOTPYigDJw4Kz3srDJp59H+uGKVMGYQeDOloPpPLnDvCm6p
	 jyKYTMO1TApdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE1B36069A;
	Tue,  3 Nov 2026 15:33:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B281B356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98C6D6069A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kIGV6Dd4tPnK for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86AD260686
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720012;
 b=Q7ALPpmvrFdnUhEgae3gvtDuEv9LkaKEKa/p2jvmWCTF1mEgP8/vlbi6HmyPDEiqYS9x
 GlMdOgAI17PfHyPgmQJarOiGM//LjJ4YT5+oIpKxF64qRJFcKRccrEmAB1yPGZtjpSHom
 llMn1AiA9Dj28W34aE8Gq79uy4w+CCUAsapWNIv9bASIhsE4m1KpCEk3xV/Qt66YNwi8r
 ObZg1FdB2WPss1NSYKU6TX7J8IVTBH9XBVWNOdnKMirQUZDUFddztEGzmEGzszvaXrGcF
 DpG5LmiY4BElgsLXHcXnMyS8zqiYBza4HAl536WSSnFoGqZOAivMgNXrDhsWUiCiELg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=Z500w/xuSDR0jxGN4i1mhDco9PLWZFVbJ7h2bkVV4yc=;
 b=CXltxFTgSJdd+Ag+hnQHtj1xooxe644Z+bIv65Ko6AizPvKxoAo3pmZMMe9h34RUgUVK
 gIVIZUBEJiNnqTywvX0F7M315kZRCqGnJ0Iy28VSsR95A5s+VrtFKBTdZK5zzDqlOLI10
 wyv0ehsvx0AnObUrzXEd+8ehBM4WzoVHicrUpJ/5vZkjERfFH7SJV6MPayAaqRifMaLFA
 lQibSghLohmaTnnApy5U8dGzLFsVJ0vX9yzel58CQ38kzhobyCRTvvyqtHLP7HR0Kpu2n
 rB75ySwDocpEXMFVOkK3KFSfkwX2txcyb7vxi3Sf1HazyUUNUsfChBWLLmnYHbrpGrA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Qyhp9UDj; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Qyhp9UDj
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86AD260686
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:31 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so2154098f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793720010; x=1794324810;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z500w/xuSDR0jxGN4i1mhDco9PLWZFVbJ7h2bkVV4yc=;
 b=Qyhp9UDjCHpRyXc2azrGJxGOApGeqRPzuzAJm0fSLkAf7bH45QQtvQ3M6B/LtDLrq9
 AgdeG1tkLpV6S7siayMrltH55j6KFGWOu3SJp/xAGUcsKew2v4KYiYsFoVkMZzoElybU
 oRZfG0ld/mW6ojVxfwSgniBPSN563h+Lk4s3sLDmfjukPHSVArMxBcQ/R+00ibPlQjll
 08u9FF4zucJ1s0ewTDZQ+fZv6eUemCMvISCvcxydU5TN7fsDpB/Hz1/R9KLTgngqEyzW
 R/1+0g0ns7lWHMiSk7qYrktYEX0+doOhCRNKW+D4V6GfqvKj+5LqDAkGSVszfhYudizI
 1InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720010; x=1794324810;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z500w/xuSDR0jxGN4i1mhDco9PLWZFVbJ7h2bkVV4yc=;
 b=j7H0f5FhKX3YMB6//SFoEM5slkGz9fxFnWKhNd3ffNNsFU+7FitsRgXsFytqVDvtg3
 paunbK/iyH59BFF7EBq58dqghbdfah/HLO/p7FFNzqPiWGT4joffMS0j3zK6oNk8k5sd
 0mU6BLN6+4JGn6PHSp/erBCLkSAkenMRPxsSl2wYh/RO3KkQJOkVNjypf3FfkRBUZ8gt
 Nk1Nn9bmF2ILuVQjxlbqQDyEy3gnF7/pLNpP8//maSep+cilMftu+5kHyD+83Ven752t
 TLeInUFS7oocemvi6hCsXXiGZWIJzduhl3ZQWSzlAK5I/XUhSv4raYuqmc5EineDoGoH
 ZFcg==
X-Gm-Message-State: APuU4Z+KUWYY8KgKh5Y8fKDmYIxI31yTXnuBEDSWLp188Q6jA7pYWQ8Y
 BWx6CDcn4J39QwGQL4lwoJ1JUWYPRr3SJvCGEgl/d3vjFkhsWFFt1R4y97QLQB4WI+m+ZwrD
X-Gm-Gg: AYBFou2kiT+SvoCmUjzqKavaNSxortK894mF4n6juA4lqQs8SZoQyEEDxE1cOKJ2Df7
 3SJSRfgjwz5nAYUx+C5+F5yns8HEdM1ZuzNoJ+ooiWP930Yv1NGSqBwsT8VRX1yhhS/gIajLezk
 QYV1nXILHFysgPjE3OowqkgOOWSP+APXvWmRiGu4Dm3KgztycpTR5kboi9N6Gg4ELQSzfuX3U1a
 HU9hZPa3q8vG2btdxshtjKIVi0Uk/rL0MyI583BWp1yYTAGGBiIpPUUI/eHNf99PP9n7lgpdAYY
 qkAgenZ254pl+lsUIlHQArUSofOdITI+014YisvuJtd5MZJo6oQZQFknpO0Bjid55nZEjuj0Xg5
 2YYBlUGXRjnM1BLsl9f1Gr9Urb3Mxfaa1BrqffjExh83CQ+uu2l2WLGfT72cd2jT8ZAeeSnRsTG
 vv8e96MbAoch1wWkCpKUC4igXri42Ch8tJk/mXUsQrNBN+BPO92Dv5xj3AxMHhgW2EUVg7r0121
 Ev0P8hErvqCW3VCtcVtPdFDqsgvqI+nk12LIZ/7sCBcMl8QfwdFjv6n8yQzhU+iBKgeCuMmm22j
 0+Ur6Pnp6QucolVL2adFfZaFAQXuS74=
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ac14ec7947mr313662955e9.2.1793720009549; 
 Tue, 03 Nov 2026 07:33:29 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a98e8f9fsm72682595e9.13.2026.11.03.07.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:33:29 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 0/4] bootstd: Bound file loads from boot media
Date: Tue, 03 Nov 2026 15:33:27 +0000
Message-ID: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Bootstd reads files from whatever boot media it finds, such as a USB
stick or SD card, or from a TFTP server, and some of the sizes and
offsets that decide where those files land in memory come from the
media itself. This series checks them in four places where they are
used as they are.

Patch 1: the pxe parser reads a file named by 'include' to the memory
just after the config file that includes it. The extlinux and pxe
bootmeths parse the config file from a heap buffer allocated to fit it,
so the included file, of up to 1GB, is written past the end of that
buffer. Refuse 'include' in a config file read by a bootmeth; the pxe
and sysboot commands, which read the config file to ${pxefile_addr_r},
keep it.

Patch 2: the load command refuses to read a file over reserved memory,
such as U-Boot itself, since the fix for CVE-2018-18440. The bootmeths
and sysboot read files with fs_read(), which does not check this, so a
large kernel, initrd or FDT can be written over U-Boot. sysboot had the
check until it stopped using the load commands. Use the load command's
checked read in both.

Patch 3: the ChromiumOS bootmeth takes the bootloader address and size
from the kernel preamble without checking them against the kernel body.
Check them, in the same way as the recent keyblock_size check. Its
private data is now allocated zeroed, since the error path frees a
buffer pointer in it which is only set once the read succeeds.

Patch 4: zimage_get_kernel_version() takes the offset of the version
string from the setup header and reads as far as the nul terminator,
without a limit on either. Give it the size of what it may read. This
one is for x86 and touches the ChromiumOS bootmeth only to pass the
size.

Patches 1-3 add sandbox tests (bootflow_extlinux_include,
bootmeth_read_reserved and two more partitions in the bootflow_cros
image) which fail without the fix and pass with it. All the bootstd
tests pass on sandbox with the series applied, and patch 4 builds for
qemu-x86_64.

The patches are independent of each other.

CI: v1, whose code v2 keeps as it was, passes all jobs of U-Boot's
Azure pipeline, in build 13713 of my CI-only pull request, merged with
main 3973f3c4d24. v2 changes only a comment.
PR:    https://github.com/u-boot/u-boot/pull/1064
Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13713

Changes in v2:
- Patch 1: document no_include in the form the other bools of struct
  pxe_context use (Tom)

Ana Bobillo (4):
  boot: pxe: Refuse 'include' in a config file read by a bootmeth
  fs: Check reserved memory when bootmeths and sysboot read files
  bootstd: cros: Check where the preamble puts the bootloader
  x86: zimage: Bound the kernel version string to the image

 arch/x86/lib/zimage.c    | 27 ++++++++++-----
 boot/bootmeth-uclass.c   |  2 +-
 boot/bootmeth_cros.c     | 31 +++++++++++++++--
 boot/bootmeth_extlinux.c |  3 ++
 boot/bootmeth_pxe.c      |  3 ++
 boot/pxe_utils.c         |  7 ++++
 cmd/sysboot.c            |  2 +-
 fs/fs.c                  | 12 +++++--
 include/bootm.h          |  6 ++--
 include/fs.h             | 19 ++++++++++
 include/pxe_utils.h      |  3 ++
 test/boot/bootflow.c     | 51 +++++++++++++++++++++++++--
 test/boot/bootmeth.c     | 75 ++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 22 +++++++++---
 14 files changed, 238 insertions(+), 25 deletions(-)


base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
