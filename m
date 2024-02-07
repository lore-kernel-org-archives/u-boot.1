Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A182FC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 13:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F402187CBC;
	Wed,  7 Feb 2024 14:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLp6mBot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D6A87CE8; Wed,  7 Feb 2024 14:00:31 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83DAF87C58
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 14:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33b4bca2418so141506f8f.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707310828; x=1707915628; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=owNPOET7ZpNPENIDmk+t8xTYilZSvzgvR7a9rH3/IAQ=;
 b=LLp6mBot0eLOF0N5shcag1mQfFYi1htG6uaFzYX4CV4DftCI340i+l5nLKOVmnqMRZ
 76woGEbUnNgZmkBVlo88vHWiBU8QO2KE7xWyzZe6+xZu70hhztww4o8G9EESvkkx44HA
 KBznaVhAFj7ZmRQzQdZVRyJiMGcXBViSazdKzRorGx8GuvlO4yMkCXJWH5QjO70lXC6r
 MS63Az9zlH20bso42up6M/vEjtq5IONPOMtfYH9cBcteJdr7PQKdf8A6Qb6sabFnyPZu
 GH/zSD2bJVu2Y3AuiVl8h9sNiV0iI2uXSv8thdwaoaA7vytmB08N2cDSA1J8eHmvh0Id
 YCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707310828; x=1707915628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=owNPOET7ZpNPENIDmk+t8xTYilZSvzgvR7a9rH3/IAQ=;
 b=tXpCs32IP++xl8wyB5ShDYFFBOz4jpJbqVQL05ri30bT0RKZSc51LVrjdcY4D0Ezrf
 1awgaIW9QJvRkxrw4eHopNEzPUezpNdnevUgYRNA8EdTI/g5100twksicz8e3Djkn5wk
 e7FMXaLNMgh3PNCnzwiiOvBZOMBDH74BOiKZvFQgiR6yOqPkhyQamVcgbGoGCi72EtRI
 glyx3fuvZdqruyHHBcPxABvxJKkXB2pNUYdy/dBETyKhHRFbIgWr/R5FHf4zAJuNO4BQ
 f9Mff/mzedVvxzTsTO5do226wvgTBEqcluoj0a2pHipeYFM8M1alkBcF3McNzw5XQS61
 x3bg==
X-Gm-Message-State: AOJu0Yx7c1vjPzcut6zjhXXozrArtTWZS6tnyim4dUYM0MkWK0AbFSS7
 svj9IZ3W9RFPuOkNr0dXicHctsYTavz0qTqFiWS7TGL5Rwy2KCk7pzP89zu7CClS80oX75mmKjs
 w8PXMTC16tKFSFrKEVyF7KXYENJuz7KS/sHxp1A95
X-Google-Smtp-Source: AGHT+IFc71lCUo3u00QZhu0cN8bnq1RIAIYEtPJ7oHLsn/N+CQuQDElGztljwLC/l2QcrOVnlUmLPKxT2X5SHv+mP2U=
X-Received: by 2002:adf:ff87:0:b0:33b:278a:15f5 with SMTP id
 j7-20020adfff87000000b0033b278a15f5mr3719419wrr.6.1707310828230; Wed, 07 Feb
 2024 05:00:28 -0800 (PST)
MIME-Version: 1.0
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 7 Feb 2024 14:00:16 +0100
Message-ID: <CAByghJZqOnV8w4nJKDOjiPVUGkq2KqYS=qxps09744==oXwtZQ@mail.gmail.com>
Subject: [RFC] Drop md5sum, crc32 and sha1 cmds in favor of hash cmd
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

I was playing a bit with different hash functions recently, and
it turned out that md5sum, crc32, sha1 cmds just duplicate
what is already covered by generic `hash` cmd.

=3D> sha1 0x60000000 0x200
sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2483d0e=
1437
=3D> hash sha1 0x60000000 0x200
sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e2483d0e=
1437

=3D> crc32 0x60000000 0x200
crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
=3D> hash crc32 0x60000000 0x200
crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8

=3D> md5sum 0x60000000 0x200
md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
=3D> hash md5 0x60000000 0x200
md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050

Considering that most of them (besides md5sum) are using the same
int hash_command() function under the hood, but have a lot of duplicated
code for handling params, does it make sense to do some cleanup and
drop all them in favour  `hash`?

I also plan to extend usage info for `hash` by adding a list
compiled-in algos based on hash related compiled flags
(CONFIG_SHA1, CONFIG_CRC32 etc), so it's clear what algos
are available for hash calculation.

Comments/objections are welcome!

Regards,
Igor

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+48 666 108 041
http://ua.linkedin.com/in/iopaniuk
