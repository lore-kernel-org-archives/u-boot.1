Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0418C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 05:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA0588596;
	Tue, 23 Apr 2024 07:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FD388598; Tue, 23 Apr 2024 07:35:01 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E142C8858B
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 07:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 43N5Yn6n068001;
 Tue, 23 Apr 2024 13:34:49 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 23 Apr 2024 13:34:45 +0800
Date: Tue, 23 Apr 2024 13:34:42 +0800
From: Leo Liang <ycliang@andestech.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: <u-boot@lists.denx.de>, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: RISC-V u-boot unable to boot QEMU using '-cpu max'
Message-ID: <ZidIcgEPSb_vDQw7@swlinux02>
References: <bed7e137-4613-4153-babc-3b8b7c911151@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bed7e137-4613-4153-babc-3b8b7c911151@ventanamicro.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 43N5Yn6n068001
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

On Mon, Apr 22, 2024 at 04:43:59PM -0300, Daniel Henrique Barboza wrote:
> [EXTERNAL MAIL]
> 
> Hi,
> 
> In QEMU we have a 'max' type CPU that implements (almost) all extensions that QEMU
> is able to emulate. Recently, in QEMU commit 249e0905d05, we bumped the extensions
> for this CPU.
> 
> And after this commit this CPU is now unable to boot a guest using upstream
> u-boot. Here's the error being thrown:
> 
> qemu-system-riscv64 \
>         -machine virt -nographic -m 8G -smp 8 \
>         -cpu max -kernel uboot.elf (...)
> (...)
> 
> initcall sequence 000000008027c3e8 failed at call 000000008021259e (err=-28)
> ### ERROR ### Please RESET the board ###
> 
> 
> I can get the guest to boot if I disable the following extensions from the 'max' CPU:
> 
>  -cpu max,zfbfmin=false,zvfbfmin=false,zvfbfwma=false
> 
> Due to QEMU extension dependencies I'm not able to disable these individually. What I can
> say is that u-boot isn't playing ball to at least one of them.
> 
> Is this an u-boot bug? Up to this point I was assuming that u-boot would silently ignore
> hart extensions that it doesn't support.

Hi Daniel,

Which u-boot version are you using?

I think this issue is fixed by the following patch set sent by Conor.

	f39b1b77d8 riscv: support extension probing using riscv, isa-extensions
	b90edde701 riscv: don't read riscv, isa in the riscv cpu's get_desc()

I've tested and can reproduce the issue you mentioned if these two patches are reverted.

Could you try with the lastest u-boot master branch again?


For reference, my testing commands are as follows:
1. cd ${u-boot} && make qemu-riscv64_defconfig && make -j`nproc`
2. ./${qemu}/build/qemu-system-riscv64 -nographic -machine virt -cpu max -bios u-boot.bin -m 8G -smp 8

- u-boot branch (commit): master (38ea74d6d5c0 "Prepare v2024.07-rc1")
- qemu branch (commit): master (62dbe54c24db "Update version for v9.0.0-rc4 release")


Best regards,
Leo

> 
> 
> Thanks,
> 
> 
> Daniel
