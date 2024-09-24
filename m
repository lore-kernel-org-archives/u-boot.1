Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28DBCF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 07:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBFA882BE;
	Tue, 24 Sep 2024 09:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840C787BF4; Tue, 24 Sep 2024 09:46:41 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CDE88363
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 09:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 48O7kPr3022933
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 24 Sep 2024 15:46:25 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 15:46:25 +0800
Date: Tue, 24 Sep 2024 15:46:22 +0800
From: Leo Liang <ycliang@andestech.com>
To: <lekkit@at.encryp.ch>
CC: <u-boot@lists.denx.de>, <nyandarknessgirl@gmail.com>
Subject: Re: [PATCH 2/3] riscv: qemu: Enable EFI framebuffer
Message-ID: <ZvJuTlH47HhrEH8W@swlinux02>
References: <20240922101102.7010-1-lekkit@at.encryp.ch>
 <20240922101102.7010-2-lekkit@cheems.de.box.skhron.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240922101102.7010-2-lekkit@cheems.de.box.skhron.com.ua>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 48O7kPr3022933
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

Hi Lekkit,

On Sun, Sep 22, 2024 at 01:11:01PM +0300, lekkit@at.encryp.ch wrote:
> [EXTERNAL MAIL]
> 
> From: LekKit <50500857+LekKit@users.noreply.github.com>
> 
> Enable framebuffer for better virtual machine integration.
> Some guests need EFI FB to work properly.
> ---
>  board/emulation/qemu-riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
> index 9538c66e..012ac14a 100644
> --- a/board/emulation/qemu-riscv/Kconfig
> +++ b/board/emulation/qemu-riscv/Kconfig
> @@ -58,6 +58,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>         imply E1000
>         imply PCI
>         imply NVME_PCI
> +       imply VIDEO
> +       imply VIDEO_SIMPLE

Enabling simplefb driver generates the following compile warning for 32 bit environment.
Could you take a look and fix that?

drivers/video/simplefb.c: In function 'simple_video_probe':
drivers/video/simplefb.c:30:15: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'fdt_addr_t' {aka 'unsigned int'} [-Wformat=]
   30 |         debug("%s: base=%llx, size=%llu\n", __func__, base, size);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


drivers/video/simplefb.c:30:28: note: format string is defined here
   30 |         debug("%s: base=%llx, size=%llu\n", __func__, base, size);
      |                         ~~~^
      |                            |
      |                            long long unsigned int


Best regards,
Leo

>         imply PCIE_ECAM_GENERIC
>         imply DM_RNG
>         imply DM_RTC
> --
> 2.46.0
> 
