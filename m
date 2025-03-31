Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB702C36014
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 21:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E297B8129B;
	Mon, 31 Mar 2025 23:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="lsN1twqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F61E81703; Mon, 31 Mar 2025 23:28:41 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE62E801FB
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 23:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=jak6+f6laK0cAqaF7oD+bolLeL0kMcikHKlthpdiQAc=; b=lsN1twqAQTO/nnYiP6BWISEaCn
 74km0EWc0r8tgMo0odN5toGs2rdWrHhQFOtlx3Hng/UKJlBXHmvpo3MQkdDqhcNx39r8F6aUTaHrW
 zWB9+E4n8RT4uh0L0v9JLLzdmuXCk6E12DCll5UEyu1ajQmTwqEsriH8SIeMzC0YGnDzIfracBzgu
 gjTSmd68LHsb7Joe0hWSnIokvvf7IkegGzN3Bc4bCW/KxHdcl8Ri+o77+FmUYh2Jolr8x1LGWDEdp
 JNskfAqFYmu6ArIoxwPK3xRal85DKbwN3RT6DVWzqxNpwPjN4n1JMjSHn+uKviBvZ+WFD2il7vttx
 Sa2AN2Yg==;
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tzMgN-0006y3-L7; Mon, 31 Mar 2025 23:28:35 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: Pull request efi-next-20250104
Date: Mon, 31 Mar 2025 23:28:34 +0200
Message-ID: <8510745.T7Z3S40VBb@diego>
In-Reply-To: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
References: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Am Samstag, 4. Januar 2025, 04:19:40 MESZ schrieb Heinrich Schuchardt:
> Dear Tom,
> 
> The following changes since commit ec9263b4f15c4cf82eb6a211c67baa6385065b8e:
> 
>    Fix neighbor discovery ethernet address saving (2025-01-01 14:40:04
> -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20250104
> 
> for you to fetch changes up to ce190e1b33b8c0e1228f4123759dfa1981c202de:
> 
>    efi: Correct ECPT table GUID (2025-01-04 02:17:06 +0100)
> 
> Gitlab CI reported no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24075
> 
> ----------------------------------------------------------------
> Pull request efi-next-20250104
> 
> Documentation:
> 
> * doc: develop: Fix typos and wording in binman/binman.rst
> * doc: develop: Fix typos and wording in gdb.rst
> * doc: sandbox: Fix the "sb" command name
> * doc/develop/distro.rst: Better document upstream definition of
> extlinux.conf
> 
> UEFI:
> 
> With this pull request the UEFI sub-system detects all boot devices even
> if they have not been probed before. If this adds to much boot delay
> individual bootmeths and bootdevs can be disabled via the customizing.
> 
> * efi_loader: avoid writing message in Exit() boot service
> * efi_loader: run bootdev_hunt() to find ESP
> * efi_loader: update EFI specification version
> * cmd: efidebug: update output of memory attributes
> * efi_loader: Don't warn if the TCG2 FinalEvents table is not installed
> * cmd: bootmenu: add parameter -e for UEFI boot options
> * efi_loader: Update startimage_exit self-test to check error
> * efi: Correct ECPT table GUID
> 
> Others:
> 
> Building the API demo application for riscv64 is supported.
> 
> * API: unify platform_sys_info() implementations
> * examples: implement _start and syscall for RISC-V
> * examples: use architecture specific memset() on RISC-V
> * examples: use QEMU compatible LOAD_ADDR on RISC-V
> * test: fix test_extension.py
> * configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
> * CI: xilinx_versal_virt: disable USB_DWC3
> * net: eth_bootdev_hunt() should not run DHCP
> 
> ----------------------------------------------------------------
> Adriano Cordova (1):
>        efi_loader: Expose efi_reinstall_protocol_interface in efi_loader.h
> 
> Aleksandar Gerasimovski (1):
>        efi_loader: fix pe reloc pointer overrun
> 
> Heinrich Schuchardt (13):
>        API: unify platform_sys_info() implementations
>        examples: implement _start and syscall for RISC-V
>        examples: use architecture specific memset() on RISC-V
>        examples: use QEMU compatible LOAD_ADDR on RISC-V
>        efi_loader: avoid writing message in Exit() boot service
>        test: fix test_extension.py
>        configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
>        CI: xilinx_versal_virt: disable USB_DWC3


>        net: eth_bootdev_hunt() should not run DHCP

this change seems to break the "normal" pxe boot from distroboot on
(at least one, but probably all) Rockchip board(s).

Up to u-boot 2025.01 distro-boot on Rockchip boards just worked
normally, the network came up, dhcp ran (and provided the tftp-server
address in my setup) and then "pxe" could retrieve the pxelinux.cfg/foo...
file.

Trying the same setup on 2025.04-rc5 does not work anymore, because
that dhcp is never run, before pxe tries to get its file.

Of course running the dhcp manually before handing over to distro-boot
works, but that needs human interaction. Similarly reverting that patch
also makes things works again ;-) .


So while EFI might be faster now, pxe from distroboot is broken and I'm
wondering, who is supposed to do the dhcp call now?


Heiko



