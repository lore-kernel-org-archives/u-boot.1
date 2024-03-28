Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0313CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398FA880E8;
	Thu, 28 Mar 2024 08:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65479880C0; Thu, 28 Mar 2024 08:09:14 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F8C880C5
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S78jEs054775;
 Thu, 28 Mar 2024 15:08:45 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 15:08:42 +0800
Date: Thu, 28 Mar 2024 15:08:39 +0800
From: Leo Liang <ycliang@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>, "Rick
 Chen" <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v1 1/2] riscv: don't read riscv, isa in the riscv cpu's
 get_desc()
Message-ID: <ZgUXd1yXH3s1OBIA@swlinux02>
References: <20240318151604.865025-2-conor@kernel.org>
 <20240318151604.865025-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318151604.865025-3-conor@kernel.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S78jEs054775
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

On Mon, Mar 18, 2024 at 03:16:02PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> cpu_get_desc() for the RISC-V CPU currently reads "riscv,isa" to get
> the description, but it is no longer a required property and cannot be
> assummed to always be present, as the new "riscv,isa-extensions" and
> "riscv,isa-base" properties may be present instead.
> 
> On RISC-V, cpu_get_desc() has two main uses - firstly providing an
> informational name for the CPU for smbios or at boot with
> DISPLAY_CPUINFO etc and secondly it forms the basis of ISA extension
> detection in supports_extension() as it returns (a portion of) an ISA
> string.
> 
> cpu_get_desc() returns a string, which aligned with "riscv,isa" but
> the new property is a list of strings. Rather than add support for
> the list of strings property, which would require creating an isa
> string from "riscv,isa-extensions", modify the RISC-V CPU's
> implementaion of cpu_get_desc() return the first compatible as the
> cpu description instead. This may be fine for the informational cases,
> but it would break extension dtection, given supports_extension()
> expects cpu_get_desc() to return an ISA string.
> 
> Call dev_read_string() directly in supports_extension() to get the
> contents of "riscv,isa" so that extension detection remains functional.
> As a knock-on affect of this change, extension detection is no longer
> broken for long ISA strings. Previously if the ISA string exceeded the
> 32 element array that supports_extension() passed to cpu_get_desc(),
> it would return ENOSPC and no extensions would be detected.
> This bug probably had no impact as U-Boot does not currently do anything
> meaningful with the results of supports_extension() and most SoCs
> supported by U-Boot don't have anywhere near that complex of an ISA
> string. The QEMU virt machine's CPUs do however, so extension detection
> doesn't work there.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I'm not really sure if I am happy with this patch - people could
> definitely have got use out of the cpu info printout of the ISA string
> before this patch - they'd have seen something like
> CPU:	rv64imafdc
> at boot, but now they will see
> CPU:	sifive,u74
> If it really is desired, cpu_get_desc() could be made to assemble
> an isa string out of "riscv,isa-extensions", but I think it's always
> gonna be a bit flawed, since that string can run to almost arbitrary
> length now - one I saw for a CPU last week was 320 characters long
> and these things are only going to grow.
> ---
>  arch/riscv/cpu/cpu.c    | 12 +++++++-----
>  drivers/cpu/riscv_cpu.c |  8 ++++----
>  2 files changed, 11 insertions(+), 9 deletions(-)

LGTM!

reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
