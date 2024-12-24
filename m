Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7453E7718D
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ADE8062B;
	Tue, 24 Dec 2024 21:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="K9SVjCg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FF4807A7; Tue, 24 Dec 2024 21:09:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8448056A
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 21:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735070972; x=1735675772; i=xypron.glpk@gmx.de;
 bh=1QhkX1PeIREFVvbvhUqcg0NcHQrX3J7OHmVVzNx20VY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=K9SVjCg3pPChZ8K1pwOuVu1n20GoSRm9MxbuW57KVlvIQtSyAd5SEK4AX4nrpGia
 RZL+Lpg9LJbYAeTZhmFCTGAoSRUEZ4Cqj7XNFgchN9nKavjPN90PVIdfAfwWYEM6R
 wIth/928TvMqdx98HoGJ3N8CMBzFJ3JH3CKmD/Pe1XQ7B0BDjMpmlBFSndi0cx+gB
 UwFeuU8ACiS8QNcDZqNlswzdYjSTrdIcyr9L2+HNc+U7GK2pbfYxR0EI6E3BO2+Dc
 KCY1jdVrb255DaBtAJUvtFsZRyBs9rOaauHAnpfVWUnL3oXCtMyYXwKq/N91i9O7R
 BaPHbX4G/2RPO0oA+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1twEAa1IUm-00oSzL; Tue, 24
 Dec 2024 21:09:32 +0100
Message-ID: <92a7b701-acc3-4ac2-a8e7-91c58f554510@gmx.de>
Date: Tue, 24 Dec 2024 21:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2025-01-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AUQ8QulPZk7jvBhpa9oSucv8hkkHyerGbHb3NK+DAkEfxhLGTCQ
 3cojacXjwT/gyBszhFdhBMp9HmUOo99tsL9gs1/pCTeAzTI8Efm/l9Znp4myU+j+yeESnig
 SRlmkwRIyG0irLHTpW7EMxOcYaCKVQv6/7rDpMuVu1okfRKaq8UA1ybb1HYUTGwP0PwNU8U
 2Kji6KDpxQB6LeVxx7B8A==
UI-OutboundReport: notjunk:1;M01:P0:I+pgMTTXzhY=;Hr8I7lLAY2/HJu0Jylr4/Sm+R5m
 wCycIcgl/ftJph6xykgrjGjD8S+hu60LJtih0/BVpMF5dmSB5ikuFO9lnL3KlQd/PIwVGTfS3
 sM9Hdgvu9bHvqwE/PkKCV4kvaFB4odnqM1yzHHvIiePGNkXdcSZ1E3JpgvIStQVEskNC2STaK
 GRqFZ0bJvb7TqaPcfb8l3NsRuAG+jb//j83Rt6shI5y+YWk8oegX4wFkPN8J+rpxzNt00xW0E
 JTTZsF32wsAFCfLg938O3V4k+DE+QhMXc78ZmT2MNMkjt7oNIeDJkKrhUpiHYpH88WTBmm4yP
 f0PVWLEbXt7+h/k1eiB7vnczJA2D2ji46eKi60QxVIHQuh+CloeFNYWM0zrFEYS0E/9NA4oKH
 dMfA9LIGeE9ZsLprA0KtllKg1w/jDQQBNkVlxaoB6THQlNikwGU6l527PNds1U6lmSlohqJdt
 hoi+6gRtKo157Wn0/FoGniCU5mneMEjQcZoVu+WcC+97d4COxEfmlWXhAb1AQtS9zgPEb7SOg
 a2w4kSJA7w39dPyfWy4dh/KikfX15u9XraRnWMckhoazM+w+oLa02BYK4OCOUMzBNoNlfh4TB
 qNNywSgfDeqg/m0ApqB5PCAxWWtGGlo4i+92oKgrA5oT21sjQRAL4d7UH8EGYNuzqrclV+Aq6
 2U5JOp8LxZK88Hx2VgurZ/rPS+VVEbqAw9Y839mCOjcSPoyXSQ2P3ydXvIO76pnPxh/mxYtlE
 oHCueqb+UbzfrpFN6Lnzff4w7SV2GbeSBYo/VxyFx7uqNvoQNkogYshEkDs0ma1680Rz+O3oZ
 nX2R2o+YJCw7eJ+DE551iki5fahsW1TXcrVr8UwJxkVrply04FTe/3iW58BxTlXQimSz11rWS
 /+KDb7PHnH610T4Og4Thbq6U9PPJB2N9wg+MZc+4bk/mq5QdekMFtVawwZcbl5p6nj5t0xJAB
 HHKfkE0u5SWUidaKExAmGvEyg7N9bVGICzUd6XE0XpMDmXrtkuLqJCr6+Jp3B1zIioow/gvFd
 m5srBxGbfA9iGLyIfC8PySzapohXCusRO0tiIYGynwjpj8hDCZnlzFSL3/Km8r6diYngYXYO/
 ycSi+Fk85+plKdFf/zVdcTYkjq1LxK
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

Dear Tom,

The following changes since commit 3391587e3fe22db6c71882f652e13543a450169=
4:

   Prepare v2025.01-rc5 (2024-12-23 20:40:49 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2025-01-rc6

for you to fetch changes up to 0be26928bfc4f2a34df3eb447fee718d3551217c:

   scripts: add volatge to spelling.txt (2024-12-24 18:09:46 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24005

=2D---------------------------------------------------------------
Pull request doc-2025-01-rc6

Fix a number of typos

* cmd: bootmenu typo 'read'
* cmd/rng: fix long help text
* crypto: typo volatge
* board: freescale: typo volatge
* scripts: add volatge to spelling.txt
* doc: fit: Format image tree source example

=2D---------------------------------------------------------------
Heinrich Schuchardt (5):
       cmd: bootmenu typo 'read'
       cmd/rng: fix long help text
       crypto: typo volatge
       board: freescale: typo volatge
       scripts: add volatge to spelling.txt

J. Neusch=C3=A4fer (1):
       doc: fit: Format image tree source example

  board/freescale/ls1088a/ls1088a.c |  8 ++--
  cmd/bootmenu.c                    |  2 +-
  cmd/rng.c                         |  4 +-
  doc/usage/cmd/rng.rst             |  4 +-
  doc/usage/fit/kernel_fdt.rst      | 88
+++++++++++++++++++--------------------
  drivers/crypto/fsl/jr.c           |  2 +-
  scripts/spelling.txt              |  1 +
  7 files changed, 55 insertions(+), 54 deletions(-)

