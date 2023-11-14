Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCD5C4332F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 00:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8496887225;
	Wed, 15 Nov 2023 01:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seegrid.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=seegrid.com header.i=@seegrid.com header.b="qPsSw8Dt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CF586F81; Tue, 14 Nov 2023 19:54:58 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA9386F0D
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 19:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seegrid.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dburns@seegrid.com
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-45d85d42eefso228785137.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=seegrid.com; s=google; t=1699988095; x=1700592895; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G849yC+Z1a+92au+NzL6Y937ySQqXwDm4YQ3RCXNsRg=;
 b=qPsSw8DtYDQRb+lYX+/iClx9T69mVe8yUXy9u5vlXKYlf0TuROcYv/Q4x8rkDQU5og
 ZblXcmv1me73Ufy990YWPOPc5JqsTaHqOf/e0HvzRwhu2A72gyC8jvSBhYjR2VIjQ2ga
 FPywSY7dsfj2RW+DNYitmjKbeYyR/U8JCXBfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699988095; x=1700592895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G849yC+Z1a+92au+NzL6Y937ySQqXwDm4YQ3RCXNsRg=;
 b=eOOSe6feHchRg8aMpcy8DjfxJldIC3bNW8XeCdHlB0KZXyUD/RJFFoKMyQHrRWKSpd
 sUkyX1Om0BQGOPGJdnwOixekeTmCm/zYNJZJ5yCA6FnRiAn21YBGJWUDpUEE7DF85QH6
 MGUvBmXcdjzbcr0s76DJINNaheDm1U6DUDjVqSiKW+9ggbeeEv7Xg3JVMwuUdCIg1VA5
 uaTo/m7qVeV7MsFPzlruPwVl47YZHM7q0uKw//aZPnRLH3wU5+qCMkE4+JJ1qjKhCv11
 hrlv3KWpE3ZuTiV3xUosVSyqvjOw3ut+hiE/u2fpTKJmR0qsmBy4Mk56K/Of3KPzQRWv
 DsZg==
X-Gm-Message-State: AOJu0YzFVPmsPp+aB4pbjz3qiZxaE36QLybc4qEEve8J2GzTRRdl55HI
 YaM/wpTEhYCBYe0pxHHo+7n3ROlT9zu7x3PkoGQHT4Dmb1wHwQihdD4=
X-Google-Smtp-Source: AGHT+IGGXuesxVDnxfgFkYSRcF+w6rSNnLxra/OTAqYVktcGHCFhhMy1yveVmiwottggaMSPjPXtEheqRjc1isnLITA=
X-Received: by 2002:a05:6102:3d81:b0:45d:9b7e:e0ea with SMTP id
 h1-20020a0561023d8100b0045d9b7ee0eamr3273167vsv.3.1699988095079; Tue, 14 Nov
 2023 10:54:55 -0800 (PST)
MIME-Version: 1.0
From: Desone Burns <dburns@seegrid.com>
Date: Tue, 14 Nov 2023 13:54:44 -0500
Message-ID: <CAJZje+vf9Wj_C_OnWTVtjHxfdmoq6j+=01qn-8WojZ9HVsxuTg@mail.gmail.com>
Subject: Booting an x86-64 BIOS Machine
To: u-boot@lists.denx.de
Cc: Joseph Chafin <jchafin@seegrid.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 15 Nov 2023 01:43:17 +0100
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

I have an application in which I need to boot an x86-64 machine with a
legacy BIOS. I've read about the U-Boot executable, the SPL, and the
TPL. I'm just having a bit of trouble figuring out which pieces are
supposed to go where. Looking to Grub, I see there exists a minimal
"boot.img" file, which gets installed into the MBR of the drive and
subsequently bootstraps the rest of the sequence. My impression was
that either the TPL or the SPL would play that same role, but even
removing basically all options, the binary produced is still too large
to fit in this 512 Byte area. Syslinux also works on my device, and
the "mbr.bin" and "gptmbr.bin" files play the same role for that
bootloader. How can I make optimizations to generate an image small
enough to fit into the MBR of my device to allow BIOS to load the rest
of the bootloader?

--=20
Desone Burns II
Software Engineer III
seegrid.com  =E2=80=A2  412-379-4500
m: 623-258-7361
