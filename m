Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F24E6748F
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 23:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E93F88E6F;
	Fri,  1 Nov 2024 00:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="nS3FmUX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E80288E41; Thu, 31 Oct 2024 21:23:41 +0100 (CET)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6223388B4B
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 21:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1730406219;
 bh=swDgc/Gp+ZYn+ivrGb0moOPuGhFvWJbNBIAFXkhPzQM=;
 h=Date:From:To:Subject:Message-ID:Content-Type:From;
 b=nS3FmUX/IXxeUljlsDzOcZNi+HcpMOz9bw6pQo3+5/4MBtbMXSUcVNSCfFaHJjXqK
 nmnX05JBWH0DR3UHLTVm0F2ijOkVxhlAWgDFn6HajzcT2prPoudi0INRsy4BdE7COP
 NfsZ/F+hpdpp6MMib5GHAWhmTMrq344NbfmQ+geA=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4Xfb6g0zmbz1xt8;
 Thu, 31 Oct 2024 20:23:39 +0000 (UTC)
Received: from qrv-systems.net (ip-095-222-025-162.um34.pools.vodafone-ip.de
 [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4Xfb6W505jz92kY;
 Thu, 31 Oct 2024 20:23:28 +0000 (UTC)
Date: Thu, 31 Oct 2024 21:23:27 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: bios_emulator: how LOG_inpb() is supposed to work on non-x86 systems?
Message-ID: <ZyPnP6IWFAOKm9Eh@qrv-systems.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 2603
X-purgate-ID: 155817::1730406214-1D7F9462-AE5E04C2/0/0
X-Spam: Yes
X-Mailman-Approved-At: Fri, 01 Nov 2024 00:20:50 +0100
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

Hi all,

When trying to compile drivers/bios_emulator for RISC-V, I get a
bunch of the following warnings:

================

In file included from drivers/bios_emulator/besys.c:51:
drivers/bios_emulator/besys.c: In function ‘BE_inb’:
./arch/riscv/include/asm/io.h:18:43: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   18 | #define __arch_getb(a)                  (*(volatile unsigned char *)(a))
      |                                           ^
./arch/riscv/include/asm/io.h:33:41: note: in expansion of macro ‘__arch_getb’
   33 | #define __raw_readb(a)                  __arch_getb(a)
      |                                         ^~~~~~~~~~~
./arch/riscv/include/asm/io.h:209:39: note: in expansion of macro ‘__raw_readb’
  209 | #define inb(p)  ({ unsigned int __v = __raw_readb(__io(p)); __v; })
      |                                       ^~~~~~~~~~~
drivers/bios_emulator/biosemui.h:131:25: note: in expansion of macro ‘inb’
  131 | #define PM_inpb(port)   inb(port)
      |                         ^~~
drivers/bios_emulator/biosemui.h:138:25: note: in expansion of macro ‘PM_inpb’
  138 | #define LOG_inpb(port)  PM_inpb(port)
      |                         ^~~~~~~
drivers/bios_emulator/besys.c:572:31: note: in expansion of macro ‘LOG_inpb’
  572 |                         val = LOG_inpb(port);

================

My question is: how _in principle_ is this supposed to work? On non-x86 systems,
the PCI I/O space must always be accessed using some base address (for example,
for my PCIe video card it's 0x60080000). In the sequence above
(inb -> __raw_readb -> __arch_getb) I do not see such base address at all.
Previously, there was a constant VIDEO_IO_OFFSET added to the port
(see 70f2030f02696ee1820d8df690e878de078b01b3), but it was removed completely.

In arch/riscv/include/asm/io.h, the I/O primitives are defined as:

#define inb(p)  ({ unsigned int __v = __raw_readb(__io(p)); __v; })

where the __io() macro seems to be an excellent thing to account for the
I/O base address. I would expect that the driver that uses PCI I/O
defines something like:

#define __io(port) (base_addr + port)

where base_addr is a runtime variable. But instead both bios.c and besys.c
have just "#define __io", without any parameters.

I am totally puzzled. I would be grateful for any clarification how this code
was supposed to work in the first place.

P.S. Simon, adding you to CC: since you were working on this code in the past.

Thanks in advance.

-- 
Regards,
Yuri
