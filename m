Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52772CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 17:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8319B846A4;
	Sun, 14 Jun 2026 19:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Yeomea2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0ADD84105; Sun, 14 Jun 2026 16:32:43 +0200 (CEST)
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC55E83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 16:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=tye3xablyzaf3ov3pmjq3doq4y.protonmail; t=1781447559; x=1781706759;
 bh=/n8okIEVaOSvNN/W03bWeCAm5Z4HErSFb5Wk7PFPKDU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Yeomea2qOZwjPg2u0ZmhXb0eQm5+NJ7qiby1rxSdTFoHhm+UUcsq8t5okpEdCctoV
 UeLBxIGEeGH3e8UYCp2Y4uJkj6iJgBI/hPXvwQ104Cni5wX2dwgx4TdOdnEScBqDqD
 gIhYJ+iRnymguQPNrk8ndIXDtt30N18nPZt3qCYdAQCGrYlRASRgm5PTuoV4NLhiKB
 MuJqVQI6qg4rBFCMlYujvtKZkDyceIh5fIuxp9LLVHCuT+TvUXkzT7YUWJDgRaJO0z
 JZjT7j1kHgPasHHQ/EoWJO0Lo8UDz8SlWMI1NoiZXcdUUGqKmxIB1t+Y4VR4xCmqR5
 yKngyWkQTWbeA==
Date: Sun, 14 Jun 2026 14:32:36 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <krotti83@proton.me>
Subject: cmd: bootelf: executing ELF files requires variable autostart
Message-ID: <3b2cd566-a043-4e8e-96e8-914d50b70133@proton.me>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: 35f06b2f77319b96d8bd93d85460ed7165ec1bee
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 14 Jun 2026 19:50:36 +0200
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

Hello U-Boot list members!

I have a question about the 'bootelf' command. Use U-Boot
as loader for my bare-metal projects, but noticed maybe an
issue when trying to execute an ELF binary.

I'm not really sure whether this is intentional or this is
an issue. Wasted a lot of time for trying to run a simple
'Hello World" program on RISC-V (both QEMU and real
hardware). Then I looked into the source code from
the command and noticed that currently the environment
variable 'autostart' must be set, if not the command
simple returns without any error or warning message:

Source: lib/elf.c:bootelf():

---
if (!flags.autostart)
     return 0;
---

Please can somebody clarify why 'autostart' must
be set to successful use the command 'bootelf'?

Thanks in advance!

--=20
Kind regards,

Johannes K.


