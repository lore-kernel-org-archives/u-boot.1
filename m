Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F57C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 05:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA165884D1;
	Thu, 20 Jun 2024 07:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iM3bUPZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB0688516; Thu, 20 Jun 2024 07:16:25 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B537884F9
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dfef5980a69so462652276.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718860582; x=1719465382; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xRPJ7anGPOYltgNLhdzdBBvJxRTfxcijR2b6ldeSmLM=;
 b=iM3bUPZt5ldGsQMe5KJ8N/3M5HZFHt+szcxMN7PtJ7gxijc+1JvrjIVGYdfxBpOMbo
 5H6JobIRqTanhVEqMvLqyZ6RIO0GpUgG3C/+Mji1750+U+wfA1GzUYCwjEBgx4zD/B6o
 5GhAR44ySB9SFv2Wy7vRYTcUHRy4XStqp3PdAW5jueVsw9tDUL1+9WGVuaL8tT3PKD5g
 O0cjRzcUZBhfWjCNqgUxg8y2wVW4K+dPPaHDkXv7CPVif4tUqtxAwdNpLfx2Jsdx3WiF
 1yHyURI7llAMx95H1SVzN8s/Rlb4ian0gwK3dKBHdPIcXG/CMiGKNFi5sq1IAt9ugvpX
 fpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718860582; x=1719465382;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xRPJ7anGPOYltgNLhdzdBBvJxRTfxcijR2b6ldeSmLM=;
 b=eHW9XAUuLa4stW57xYB7HOk2axPgtxBT86iP9Pr+61t1qajDwR0fQFJMLst/9TKbmW
 3bxdqN+Z3gKh8GcUR8ILRZs5ju8iC4+3ehcihZHwfS8iMxGnKLayHTZ4O0rtW9U20Npc
 x6x7PcYTDLwjxXzlDul+dG6Isq5lAytAQVCJiQTHKStot2sZpEbgP5re5mQ6DhCiX/4f
 1vSqoJR/frqLc8LP3V062qrMtuqOPeryWnThSCui7vUuMcUUY5msfO4fQ7l7OIYDkFR2
 4lDG2MC7vgBG8AeSvVaDXorEU2zwBEwLnT6yX7pQjkqcuKVMqzLhh0Kz1IsdJ/lyPHWj
 66rA==
X-Gm-Message-State: AOJu0YwDhN4YlKPsrdj7AzG7mBQTHHLUX9fPOp2KfxtOKD7QBsB6j8E8
 ogHcnT+Z8WgE/uszhZPrNH3sWewTh5FAB/toCRhgJ0+WqSmN9cjZ3Ed63ngDkboTQrXIim2CiSJ
 Pg/iBo1AlXlTGCOv8wwbzPHf1JksfkeaU5JE=
X-Google-Smtp-Source: AGHT+IF3aN2TdQESdgNx2e9KNAM0Qw+1hMD8McC4PxMRvX+gjijj8qa4ZPOQusK3g82gxEndNQmMZk0z7R4cW9KCvFg=
X-Received: by 2002:a25:d381:0:b0:e01:a124:3fcc with SMTP id
 3f1490d57ef6-e02be0fe8cfmr4657477276.4.1718860581783; Wed, 19 Jun 2024
 22:16:21 -0700 (PDT)
MIME-Version: 1.0
From: Chris Packham <judge.packham@gmail.com>
Date: Thu, 20 Jun 2024 17:16:10 +1200
Message-ID: <CAFOYHZAzfyGHp3FEFLEiuGFS-XMrprEqANLSBqRkv2B_RHMpUA@mail.gmail.com>
Subject: mkimage alignment of initrd with -T multi
To: u-boot <u-boot@lists.denx.de>
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

Hi U-Boot,

I've been given a MIPS reference board with a fairly old vendor U-Boot
on it. It does seem to support the  Mutli-File Image format but I'm
running into an issue where the kernel expects the initrd on a page
boundary.

I'm using a command like the following to produce and image
  cat board.dtb >> vmlinux.bin
  gzip vmlinux.bin >vmlinux.gz
  mkimage -C gzip -A mips -O linux -T multi -a 0x80100000 -e
0x80100000 -d vmlinux.gz:initrd.sqsh myboard.img

I can mess about with padding vmlinux.gz after the gzip step but the
process is a bit fragile and involves me guessing at some magic
numbers that I think might be sizes of certain headers.

Is there any way to convince mkimage to make sure the initrd is on an
appropriately aligned boundary so I don't have to guess.

Thanks,
Chris
