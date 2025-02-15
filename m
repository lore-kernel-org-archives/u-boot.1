Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4272CC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 23:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651938056A;
	Sun, 16 Feb 2025 00:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=extrowerk.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=extrowerk.com header.i=@extrowerk.com header.b="aISVkbPz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZkCJS2mF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7A780C83; Sat, 15 Feb 2025 20:45:23 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5973809A4
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 20:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=extrowerk.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zmizsei@extrowerk.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 942701140108;
 Sat, 15 Feb 2025 14:45:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 15 Feb 2025 14:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=extrowerk.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1739648719; x=1739735119; bh=jFhl15r2t6R0WfZIsfmj7scvz58ttQeQ
 Q/GLqv+W/s0=; b=aISVkbPzdq+k4X9H8IHr5538uHaSoWLlY1tFsAkUhgUsJiwB
 gfdmeJYLXv+QDF/yr96MZ51H0hH6o48XVEIYv/y+w3SUr+7vaYTATZYVuHT2dI56
 EXRK/4NrVs58FPFNbGSthq46X/GT/5wX7S/ycfb1Do72P3SGaf4oefRHyRkuAuON
 6QsGr9WbnBtnSMzzoeIbeNx2jOG+snBXNFkz5UaWyfLJA1txaz/3K4j2Qhl0ehh6
 psDgnMHKLarbmcRNiGcGwJ9gN7/GrNAeDJgxKQn3M/Ptvlz3i5UTA3MAKQQbu39V
 /DmT9x6dygYM2O+tGMWXs064KVbR4ulkTE/wUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739648719; x=
 1739735119; bh=jFhl15r2t6R0WfZIsfmj7scvz58ttQeQQ/GLqv+W/s0=; b=Z
 kCJS2mF8KDskgWbZ/AmISJVUQKeWcy8Wp4XbPpBTV2nqcJalPL6HioRXvZUFyqnB
 i2JUu2hTsK8jyGOBg3PToDZ4xIBrxi2cwRrRKHiARpaXMsMyloe07DFM9W6RjUXg
 q+w4+Av27c+yCujgbEmScxScNoiVOS6N4ZyO3KPCvkE0gQIM5RlgyJKFs+4cEeKY
 +04oGoFwtRH11KGFuZGKocR+laP8nlLoH+dlktwRxkkh9KRYCE67j3PWF+UxaQvi
 ivSlDcF0Via7cqd6O4TAxya7tIWeqA72j+n6GuDaOMoeOhrQnDcYxJSoLESBaQgO
 z7m0yVHHT0JA0jlMd3m3g==
X-ME-Sender: <xms:zu6wZ6OfPa4rMl2ifwZp9ClUo64nRlL8ggJOQPhMkkgQBqrPj9F8wg>
 <xme:zu6wZ4-G41m0EXPIHVLY2HtiWfYLc23p2FWZjROc-FOw-vTrM9nqbdrE0WBgWp8lP
 -6BQWT2EKuMx6v2ZHE>
X-ME-Received: <xmr:zu6wZxQd-bWDtyCN5BZh9Gk8yLgN6KkSgRFMGFRaL1-DYJyVKr8VBEmPtsL5GI-Mc-L6YbFqt82T7fBgnlCcTFPaQFaN7kBRLeOhNVEY6fI5Wp9yrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehfeegfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfesthekredtjfdt
 jeenucfhrhhomhepoffkkgfugffkucgkohhlthojnhcuoeiimhhiiihsvghisegvgihtrh
 hofigvrhhkrdgtohhmqeenucggtffrrghtthgvrhhnpeffjeetteeivdeigefggfejjeeg
 udejvdehtdffieehleegueeludehkefhhfevfeenucffohhmrghinhepghgvnhhirghtvg
 gthhdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepiihmihiishgvihesvgigthhrohifvghrkhdrtghomh
 dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhho
 nhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdrug
 gvnhigrdguvg
X-ME-Proxy: <xmx:zu6wZ6vFhLbmAb-mKrjiscqH-tc7ntyzkqWLV6vn_mqLiaore-Hkrw>
 <xmx:zu6wZyeQB8BMtJPZd7IKVgu6gnpvWSc1T3pnD7UtEnkWI8TVg1E41Q>
 <xmx:zu6wZ-0GlsXVNzp5GivTuwSY0wV7uMKTon3ljJjskN9I_ijmeNspLg>
 <xmx:zu6wZ29yM0aQIy-Z6mEzRnwPYG_wPUlSlW49SQQEZKkhCAV4_vnBeQ>
 <xmx:z-6wZzrb7z7Y55_BDkatFWc7K4ZYaCr6nK77PeMoIfmohALO8tpPTZ18>
Feedback-ID: i46594767:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Feb 2025 14:45:17 -0500 (EST)
Date: Sat, 15 Feb 2025 20:45:13 +0100
From: MIZSEI =?UTF-8?B?Wm9sdMOhbg==?= <zmizsei@extrowerk.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: Can't get U-Boot working on Geniatech XPI-3566-ZERO
Message-Id: <20250215204513.b5e880f3b0b6f33b527ee6e1@extrowerk.com>
In-Reply-To: <7db1cc51-3a9c-44c3-ac16-369566f2ef20@kwiboo.se>
References: <cf475658-6c25-474b-934b-15da1363a39f@app.fastmail.com>
 <7db1cc51-3a9c-44c3-ac16-369566f2ef20@kwiboo.se>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-openbsd7.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Feb 2025 00:26:59 +0100
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

I have managed to get output from the board using UART7 GPIO pins!
My USB-UART adapter is not reliable at 1.5M baud, therefore I had to reduce the baudrate.
However while I get output from the board, my inputs are silently ignored, eg. I can't type anything in the U-boot console. I suspect the &uart7m0_xfer is the issue but I can be wrong.

I have selected UART7, because UART1 is used by bluetooth, UART2 is not available on the GPIO pins (i found some RX/TX/GND marked testpads on the board, that might be that) and all other UARTs are muxed except UART7, so it seems to be a good alternative. My soldering skills are non-existent.

The pinout ( https://file.geniatech.com/download/xpi/XPI-3566-ZERO_Specification_V1.4_EN.pdf )shows the following:

PIN 36: UART7_RX_M2/ GPIO4_A3_d
PIN 37: UART7_TX_M2/ GPIO4_A2_d

Therefore I have tried to add 

&uart7m2_xfer {
        bootph-all;
};

to rk356x-u-boot.dtsi but it didn't made any difference. I probably miss some tiny details somewhere, but I can't seem to find it.

I would greatly appreciate any help.

Thank You!

My current patchset:

--- a/arch/arm/dts/rk3568-generic.dts
+++ b/arch/arm/dts/rk3568-generic.dts
-               stdout-path = "serial2:1500000n8";
+               stdout-path = "serial7:112500n8";

(....)

-&uart2 {
+&uart7 {
        status = "okay";

--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -161,12 +161,12 @@
        u-boot,spl-sfc-no-dma;
 };
 
-&uart2 {
+&uart7 {
        bootph-all;
        clock-frequency = <24000000>;
 };
 
-&uart2m0_xfer {
+&uart7m2_xfer {
        bootph-all;
 };

--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -9,7 +9,8 @@ CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_BASE=0xfe6b0000
-CONFIG_BAUDRATE=1500000
+CONFIG_BAUDRATE=112500

I get the following output:

U-Boot SPL 2025.04-rc2-g9b35357b95e3-dirty (Feb 15 2025 - 18:46:05 +0000)               
Trying to boot from MMC1                                                                
## Checking hash(es) for config config-1 ... OK                                         
## Checking hash(es) for Image atf-1 ... sha256+ OK                                     
## Checking hash(es) for Image u-boot ... sha256+ OK                                    
## Checking hash(es) for Image fdt-1 ... sha256+ OK                                     
## Checking hash(es) for Image atf-2 ... sha256+ OK                                     
## Checking hash(es) for Image atf-3 ... sha256+ OK                                     
## Checking hash(es) for Image atf-4 ... sha256+ OK                                     
## Checking hash(es) for Image atf-5 ... sha256+ OK                                     
## Checking hash(es) for Image atf-6 ... sha256+ OK                                     
INFO:    Preloader serial: 7                                                            
NOTICE:  BL31: v2.3():v2.3-645-g8cea6ab0b:cl, fwver: v1.44                              
NOTICE:  BL31: Built : 16:36:43, Sep 19 2023                                            
INFO:    GICv3 without legacy support detected.                                         
INFO:    ARM GICv3 driver initialized in EL3                                            
INFO:    pmu v1 is valid 220114                                                         
INFO:    l3 cache partition cfg-0                                                       
INFO:    dfs DDR fsp_param[0].freq_mhz= 920MHz                                          
INFO:    dfs DDR fsp_param[1].freq_mhz= 324MHz                                          
INFO:    dfs DDR fsp_param[2].freq_mhz= 528MHz                                          
INFO:    dfs DDR fsp_param[3].freq_mhz= 780MHz                                          
INFO:    Using opteed sec cpu_context!                                                  
INFO:    boot cpu mask: 0                                                               
INFO:    BL31: Initializing runtime services                                            
WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
ERROR:   Error initializing runtime service opteed_fast
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0xa00000
INFO:    SPSR = 0x3c9

U-Boot 2025.04-rc2-g9b35357b95e3-dirty (Feb 15 2025 - 18:46:05 +0000)

Model: Generic RK3566/RK3568
SoC:   RK3566
DRAM:  2 GiB
Core:  249 devices, 23 uclasses, devicetree: separate
MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
Loading Environment from nowhere... OK
In:    serial@fe6b0000
Out:   serial@fe6b0000
Err:   serial@fe6b0000
Hit any key to stop autoboot:  0 
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
Scanning global bootmeth 'efi_mgr':
Card did not respond to voltage select! : -110
Cannot persist EFI variables without system partition
Missing RNG device for EFI_RNG_PROTOCOL
  0  efi_mgr      ready   (none)       0  <NULL>                    
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=-14)
Scanning bootdev 'mmc@fe2b0000.bootdev':
Card did not respond to voltage select! : -110
Scanning bootdev 'mmc@fe310000.bootdev':
Unknown uclass 'nvme' in label
Unknown uclass 'scsi' in label
Unknown uclass 'pxe' in label
Unknown uclass 'dhcp' in label
No more bootdevs
---  -----------  ------  --------  ----  ------------------------  ----------------
(1 bootflow, 1 valid)
=> 


On Mon, 8 Apr 2024 21:31:28 +0200
Jonas Karlman <jonas@kwiboo.se> wrote:

> Hi Z,
> 
> On 2024-04-08 09:40, Mizsei Zoltán wrote:
> > Hi,
> > 
> > I'm trying to get a mainline U-Boot running on the Geniatech XPI-3566-ZERO RK3566 based SBC [1], but all my attempts have failed so far.
> > 
> > The SBC doesn't have any SD-Card slot, please keep this in mind!
> > 
> > I can build U-Boot, but when I write the resulting binary to the eMMC using rkdeveloptool, the boot stops and I see no output on the UART pins using 1500000 baud transfer rate.
> > 
> > My steps were the following:
> > 
> > - git clone https://github.com/u-boot/u-boot
> > - cd u-boot
> > - CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make rk3568_defconfig
> 
> There is no rk3568_defconfig target but generic-rk3568_defconfig may work better.
> 
> > - ROCKCHIP_TPL='rkbin/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin'  BL31='rkbin/bin/rk35/rk3568_bl31_v1.44.elf' CROSS_COMPILE=aarch64-linux-gnu- make
> > - rkdeveloptool db MiniLoaderAll.bin
> > - rkdeveloptool wl 64 u-boot-rockchip.bin
> > 
> > After that I can no longer communicate with the board via UART and it no longer boots.
> 
> After looking at the specification for this board it looks like GPIO pin 8 and 10 is connected to uart1 and not uart2 that is typically used for debug uart on rockchip devices.
> 
> > 
> > I've built uboot countless times, I've followed all sorts of guides, I've tried modifying FDT and transplanting the DTS from the official SDK, I have tried vanilla defconfigs and tried to modify them aswell, I think I've tried everything, but no matter what I do I just can't get it working.
> > The vendored U-Boot works ok, but I plant to run OpenBSD, for which an upstream U-Boot would be better situated (according to the OBSD mailing list).
> > 
> > Please give me some hints because I'm running out of ideas. I've spent countless hours trying to get this to work but haven't succeeded.
> 
> You can try changing stdout-path to "serial1:1500000n8" and enable the uart1 node in generic-rk3568.dts.
> Also change to CONFIG_DEBUG_UART_BASE=0xFE650000, and also use rkbin tools/ddrbin_tool and change to use uart1 on ddr bin.
> 
> After that you should probably start seeing something on uart and that may help you get a little bit further.
> 
> Regards,
> Jonas
> 
> > 
> > Thank You very much!
> > 
> > Best Regards,
> > 
> > --Z--
> > 
> > [1] https://www.geniatech.com/product/xpi-3566-zero/
> 


-- 
MIZSEI Zoltán <zmizsei@extrowerk.com>
