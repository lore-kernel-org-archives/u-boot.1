Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716A6C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3814087799;
	Fri, 10 Nov 2023 12:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PU7FqZaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E0D8754B; Thu,  9 Nov 2023 23:44:33 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4602087717
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 23:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilbsgilbert@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53db2f8d193so462342a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699569871; x=1700174671; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=spy/plUq6zXzMfi0W3XyVtS+1JuhuRWEjYbp7dqQrbA=;
 b=PU7FqZafdmCfodAiu0ik/CosyLZtS86MY97qQmndvS1T358JNAV4CeeqKHNo7jP+it
 pgWQYOZHHlIaAqX9LttDRLaU8hMK9ZMYToU+TRTS82xEK1vIkM4f89wWytotZTmbVajR
 8GJnExGc3MBxXC2ABH7jHhehBMleXmSUS2ha2ZfdLRUmhaHuT4uR0mz+h7SYhk2J7AGJ
 lwdmnJ3QZLWq7862RmIyMOLltWM0+yckYyay6HsDzrgWDfuEcZzuRLoYbT4xcXDn3wx6
 9/D8EbVLTAIS4bqrs/QjubUUTFGc5/dvMTnEpy7zwZ8Jkb/+3ivSyBJMM9J//D0eKtc8
 S4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699569871; x=1700174671;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=spy/plUq6zXzMfi0W3XyVtS+1JuhuRWEjYbp7dqQrbA=;
 b=j+uflHh3S5q82N8Rrkzo1onTO222WvDmv6azjlwGK9Pmd6HURp9tKS35jHzY2rWh5R
 z6essLDCPXIpgw+7a4jjGUGlbFkyyhVe83Vz3gXTKkmVSI5KWW9FCqI+b2TdcNN9rpDD
 ypqkTD2qikXf+bOnUv2ulIuslX84GcFYGxZcosDQ2Vz6aKTWCACLci9zayil/Kw4uQED
 Ho1aJ3gxv/HTLWdnJJglGrnKsobZaJFj/7/zRiGctymlrCMJOFnBai4ayFRuJmbLGVE8
 1OOn0ncztzBNYj9P1LYVOybwcYkyEoDz0KyETEfrdrv2zufi1v1kawZQVk/cqLv2bIsX
 t3dw==
X-Gm-Message-State: AOJu0YwFhbkRY+4106l5HOdYr5o0r5Q7AtJhxXkRXZZ1Guboj99W3oo9
 HHjww4mtUiH1vQU/6y6SFgzIjMb1HM7I+68kE+41ccm8u03/jw==
X-Google-Smtp-Source: AGHT+IFydFMC2avLbAALplXvcbWQptpyEhJp+CKffN7KpPQ1JO98Y1li6x3VNsFgdMEBGzUnwZ4QhwMuuEEcn8HG7gg=
X-Received: by 2002:a05:6402:2708:b0:545:e498:38e7 with SMTP id
 y8-20020a056402270800b00545e49838e7mr1907341edd.3.1699569870615; Thu, 09 Nov
 2023 14:44:30 -0800 (PST)
MIME-Version: 1.0
From: Gilbert Gilbs <gilbsgilbert@gmail.com>
Date: Thu, 9 Nov 2023 23:44:19 +0100
Message-ID: <CABD+r68kEzASZ3M3xqcZ0WV3jG5bq4GnGYGVnZkOEV5N4QSTgg@mail.gmail.com>
Subject: Lichee Pi 4A GMAC driver
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 10 Nov 2023 12:51:04 +0100
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

Hi,

I'm the happy owner of a Lichee Pi 4A by Sipeed, a RISC-V SBC based on the
TH1520 SoC by Alibaba. Very basic support for this board was added in 5f3a7fdb.
For now it's just able to chainload mainline U-Boot from vendor's fork of
U-Boot.

As an experiment, I started porting the glue layer for the GMAC into U-Boot,
taking inspiration from the implementation that got merged into the net branch
of Linux recently[1]. I eventually got the driver in a working state, but I had
to rely on two suspicious workarounds that I'm unsure how to address. I'd like
to discuss them here first before submitting a patch (if you're interested):

1. The designware driver can only read/write RX/TX DMA buffers from/to the 4GB
   address space, and I guess this is a hardware limitation. After chainloading
   U-Boot, these buffers are consistently allocated beyond the 4GB space making
   the driver inoperative. Is there a generic way of "forcing" U-Boot to
   allocate these DMA buffers in the 4GB address space? I believe it should be
   possible by dynamically allocating the buffers and using something like
   LMBs, but that sounds like a big and risky undertaking. For the time being,
   I've arbitrarily reduced the amount of RAM in the FDT to circumvent the
   issue, but it is completely not acceptable.

2. Some RX packets are corrupted because U-Boot occasionally modifies packets
   in-place, and those changes are flushed from the CPU data cache later, when
   the same RX buffer gets recycled. My current fix consists in invalidating
   the dcache of the whole buffer when freeing the packet in the designware
   driver. While this works fine, I was wondering if this is a common thing to
   do in drivers relying on DMA, and if there is a more efficient/common way to
   tackle this problem. I'm not aware of non-cached memory on this device that
   we could use.

Thank you in advance,
Nils

[1] https://github.com/torvalds/linux/commit/f3c05bcddd5db130300e5ebaf27d355dd441d7e6
