Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F6606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yRVlr2R2;
	dkim=pass (2048-bit key, unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256 header.s=default header.b=RTvHWra6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF94D405CF;
	Mon,  2 Nov 2026 05:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWn8gJnEs65k; Mon,  2 Nov 2026 05:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 09B3740547
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793597551;
	b=cZYlGa7h1cZhcws+X/DPdvjuTVl3VeQSsiIGS1oPL54AS97mDOlucB6LRc5lpyvXN8Fz
	 GcIrrYRE9AUXeqttg2l7Pwwkomi3WWoKg5bqkxhTVLxCNf2nqjbUHpS3gdOJGBae2OXSg
	 //IUBtLxJ69x6f/zKdORRsOV4Ny8SSft8+xpVmmxi6Ia9bpU4EqmudUZ38s+w4FnrbF+D
	 tbBu02RZ171MNe7cwxVF5N2rZu3SI4EeVDQhFUlp9PoEdVK2+EhNMae+sE63wuji/AQ/J
	 qffUAu/bxpgidquBUanHTfEkc+SJGYgxCqlqyEz9U/3NOGj093taOpncHae8qtc/nvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793597551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Envelope-From:X-Virus-Scanned:
	 X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cEAWRsSBb12HUI3zHFfpJxVAGL1P0yFzkgy0CN6iaO0=;
	b=S3Op3fET6U0NUGeraBdfhd9vztSVTsDGTZPNIhsQK51sDN2UmZ7dV10PEVbcTygGR1dL
	 d59943V8WNRUiKvgudaGSqsYem/1DyxXvb8D9ciurjtDy3VBt6ly6+nxw4HkCt/nTsNTY
	 fUs8yJaBOEtB3sB7A6dbZhsJppdNn188U0BD7P+s2rwHIZcvZC1vlpuDsN7Kv07+uBqGr
	 Joluks1LdzWbfXizHGwjyJpb2gRjzIOEf2t+NmjCxRhd6NFenDTOf0KfJROqjmhUR4n4H
	 Uk8Mzh4VFvGvaJAY/MLIFi1yOrZH46p79zqPuULnkvR2QPZ7XtbOzn4ih/p4vkycDWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793597551;
	bh=cEAWRsSBb12HUI3zHFfpJxVAGL1P0yFzkgy0CN6iaO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yRVlr2R2WI4Rvc9YGBfubBW9SbBoSDPvGdCKLg2DaBgM7B9GZCxc8xDY9Y6HBycej
	 T31lrfMFGLW6mosPthasXbImWlIYQK3rcHsiapZIHE5rNqXEHyOO2DIaDGMRSRXCUY
	 NfvTcecrf+VDhGl+pBLGo9B6WR+V1+zyceKB8H8RJnFqBmpw9W+l8iBcPjLMQwCBF0
	 OJY7dlY8dmxFoiSqVeoMla/d3DpkQZ4wZs3mljr7sPXG5mB5DZbSBDxhBctx765Lfn
	 ZvXeGgkwectdPFSv7lkl1DY3sPpvpIsd1zAF44K+owd38uGje0McVqGP08Dr9uckso
	 ir7vMTuqSSvZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09B3740547;
	Mon,  2 Nov 2026 05:32:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EEC42323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 00:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E05116064A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 00:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhbFYf6PYXFr for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 00:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02B3860619
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793578725;
 b=D0mIwVWfFnapoLn02FyYz4prMcqCYBqyLvMh1Sn2JCRJBXB5DofHVPeEaUaSdNK4WcgR
 NLjPd1TpsO+jYLrimvKd6rh4V0ozu6G5j/9bXEFN6ghLLTqHXA89K28omqEJJZFQXhWeL
 HgHZxVfzwd1KpxX/ygVALZmdUa3Ne6KnHzmULBfgWTqL0IrqtFtn9jas/KHtEnae3uMMD
 JSnQVMRESwX5BYcUFiDXc+/GYjHPxV7IZE3OSYaq/CPk46xSMw8QIMPllyotcICl/q4oM
 R9vOlLCqDDTgIA9YPuft4iq9GWqzRf3GLElMOcFcm/zzfbw7+3GVbED5l4L1WZUndtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793578725;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Envelope-From:X-Virus-Scanned:
 X-Virus-Status;
 bh=cEAWRsSBb12HUI3zHFfpJxVAGL1P0yFzkgy0CN6iaO0=;
 b=HmOr5HBCab8NQOtN++7LC+VQJYhMrl6gQN6DPqaM6UdYhDTcFPAttd2DFhLM9LhLULo4
 iPUJHC4sVjggmeyCjOlq4JwgkIU5K+Yiel7nKOxv/ZR4JoJyUGCfmFg5s7YQUqI58JikN
 kD3fvwT/GpbrPG6GqtMdf+h0UWAwRHQkz74/8zXv8H3M0LOIrGjM61syeuvX3gBV64gsA
 CdVOouRdq2ked5p6x1TiFu/pBwPctU0oH+H2QRWXuBUIFkb+9VcJm72VBcrr8jdOBdpzW
 46135pORRrjhCgxMUCYZDX0ilsncKEkEcllJK3lzDx8CfPjGBKb7GVPiz4q9ZJsiRnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=elliotjb.com;
 spf=fail smtp.mailfrom=elliotjb.com;
 dkim=pass header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256
 header.s=default header.b=RTvHWra6; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=elliotjb@elliotjb.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=elliotjb.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=elliotjb.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256
 header.s=default header.b=RTvHWra6
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02B3860619
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 00:18:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1567F83E76; Mon,  2 Nov 2026 01:18:41 +0100 (CET)
Received: from out-93wp-a34.jellyfish.systems (out-93wp-a34.jellyfish.systems
 [104.207.68.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967A983108
 for <u-boot@lists.denx.de>; Mon,  2 Nov 2026 01:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=elliotjb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elliotjb@elliotjb.com
Received: from mail.privateemail.com (unknown [104.30.160.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.privateemail.com (Postfix) with ESMTPSA id 4jHsjs6wqlz2x9J;
 Mon, 02 Nov 2026 00:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elliotjb.com;
 s=default; t=1793578692;
 bh=cEAWRsSBb12HUI3zHFfpJxVAGL1P0yFzkgy0CN6iaO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RTvHWra65rYG6aKI7MnVuP2SSnb3cR2xAs2TKWCMTc7gbsSIiepFitgyEqm5fVGv5
 1kyWzoKMBPpNWNHi22B+W64g77442OM4xztQuWGpXXIDwF+PsKQptepYG1m1uMpAqa
 Ftu76/LJEewFmW8ToSU9N22Ujkn8ySYi+F2mD9BaI8OpWZaZrSdbhcEhRCk+QVkO2d
 mATUC4sOlJ53cppiJ/z9ahV6IW0kfkzlOzXxRio/+V2HG5y9HQtEWxiAW6UhtynLXu
 34w3RyWtbJHcwnHdS0JgjwSP6jx2nSx5nPZsddZYll6Rhsmp0I1nnHlY48fTbMqr5Q
 9yovUbkCktFMw==
Date: Sun, 1 Nov 2026 16:18:08 -0800
From: Elliot Berman <elliotjb@elliotjb.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Elliot Berman <elliotjb@elliotjb.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Alexander Graf <agraf@csgraf.de>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v3 4/5] docs: emulation: Add qemu-x86 documentation for
 running as flash binary
Message-ID: <aufWIbYhzVtFXpXF@eberman-5690-nixos.corp.anduril.com>
References: <20261016-qemu-x86-pflash-v3-0-068014a671f3@elliotjb.com>
 <20261016-qemu-x86-pflash-v3-4-068014a671f3@elliotjb.com>
 <CAEUhbmUVmnQB=osPuc1CfDPRU37WTEAYJiw5sTb5EgZkem-XrA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUhbmUVmnQB=osPuc1CfDPRU37WTEAYJiw5sTb5EgZkem-XrA@mail.gmail.com>
X-Envelope-From: elliotjb@elliotjb.com
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Nov 2026 05:32:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 08:55:26AM +0800, Bin Meng wrote:
> On Sat, Oct 17, 2026 at 5:19 AM Elliot Berman <elliotjb@elliotjb.com> wrote:
> >
> > Provide guidance for testing capsule updates on x86/x86_64.
> >
> > Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
> > ---
> >  doc/board/emulation/qemu-x86.rst | 39 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
> > index c604e42990e..d40cc500994 100644
> > --- a/doc/board/emulation/qemu-x86.rst
> > +++ b/doc/board/emulation/qemu-x86.rst
> > @@ -113,17 +113,52 @@ sure the specified CPU supports 64-bit like '-cpu core2duo'. Conversely
> >  '-cpu pentium' won't work for obvious reasons that the processor only
> >  supports 32-bit.
> >
> > +Running as flash binary
> > +-----------------------
> > +
> > +Running U-Boot from emulated flash lets QEMU write a new image back to the ROM.
> > +This allows EFI capsule updates to be tested. To create a U-Boot binary that can
> > +accept capsule updates, build qemu-x86_64_defconfig or qemu-x86_defconfig with::
> > +
> > +   CONFIG_EFI_CAPSULE_ON_DISK=y
> > +   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> 
> On x86, the linking of u-boot.rom failed due to address overlap (with
> gcc 15.2 on Ubuntu 26.04)
> 
>   LD      u-boot
> /usr/bin/x86_64-linux-gnu-ld.bfd: section .rel.dyn VMA wraps around
> address space
> /usr/bin/x86_64-linux-gnu-ld.bfd: section .start16 LMA
> [fffff800,fffff86f] overlaps section .rel.dyn LMA [fffdfd78,00000c37]
> make: *** [Makefile:2131: u-boot] Err
> 

I wasn't able to reproduce this on commit ee9fc27f2a2 ("cmd: mdio: check argc for extended mode") using gcc 15.2 from NixOS.

> > +
> > +See :ref:`uefi_capsule_update_ref` for the full set of capsule options and the
> > +general update procedure.
> > +
> > +Instead of the '-bios' option, attach u-boot.rom as writable pflash with
> > +readonly=false. For 64-bit U-Boot::
> > +
> > +   $ qemu-system-x86_64 -nographic \
> > +     -drive if=pflash,format=raw,file=path/to/u-boot.rom,readonly=off
> > +
> > +For 32-bit U-Boot::
> > +
> > +   $ qemu-system-i386 -nographic \
> > +     -drive if=pflash,format=raw,file=path/to/u-boot.rom,readonly=off
> > +
> > +Generate a capsule with mkeficapsule::
> > +
> > +   $ mkeficapsule --index 1 --guid 5bb9ce0d-a389-456f-83a8-2bdfb8ad01a1 \
> > +       u-boot.rom uboot.capsule    # qemu-x86_64
> 
> Please use u-boot.capsule as the file name.
> 
> With gcc 15.2 on Ubuntu 26.04, the generated x86_64 uboot.capsule is
> about 2.1MiB, which slightly exceeds the SYS_MALLOC_LEN.
> 
> as the malloc(file_size) in efi_capsule_read_file() reads the whole
> file at once by allocating the size of the capsule file.
> 

Ah, thanks! I've mostly been testing by applying capsules using
EFI_RUNTIME_UPDATE_CAPSULE support. I think the straightforward thing to
do is use `efi_alloc_pool()` instead of `malloc()`. With this, we'll be
able to allocate more than SYS_MALLOC_LEN and able to apply capsule
updates from disk. I'll send this out in the next version.

Thanks,
Elliot

