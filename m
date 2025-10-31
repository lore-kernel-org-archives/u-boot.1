Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3ACCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 23:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3475883B47;
	Sat,  1 Nov 2025 00:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QN4Y3J6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8E583B4E; Sat,  1 Nov 2025 00:15:35 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4ADF836D1
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 00:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C87E54013D
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 23:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761952531;
 bh=oeTg+HjlZHeIYvagZ+G0Bf5YhAFMqys22xR161NbwcI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=QN4Y3J6bR6KaeT/8IeTHOOSOXajONNLKgLdnBLyy1HGaJW5XR8DHrhT/iKir3xAg9
 TsX+CycGkEJ19/tZT7+lpEcjTGn+LWKTZoyMvVgUz2RwkeeLVHgbGEEy0ZayTgMRf2
 LCoB59xd8mGfSN1Iy0mKD/CCo0/0Q+JVFJ4GSHZCGzUH9FZBdUh64TBETUlNWPAjg/
 Ii7bEC6SWu3ek/6KlUcKD4UIJUM1H9klW74Sy4QExY/UHIV28NBvDWeSnIQ+dLpvLy
 XhUBJSuv8qToIhZL1iJ8fEb4M4aF8JvEE62HJCIZUq+qsO72948dh8UR/ty3eo3V9T
 AOnFzqdBZzp2fQVRbvHU5/LncBwv2ZnClaB1AXlGJjPJV9YytWI7OVUTVSVS+l+u0X
 BNqWHZnivMGLczsn64GavC+9T/Nbb1K6aR2hqACmx7kqXtlTJhvyoIyTrIUArEAudb
 L0kkeq3AQ04Bs+o7shLQFVCWiT/cwWrbeHcfeleEpkkh0A9VkhYsuU7VmJEeRFtsp9
 xsJc8hqsQdR8VE7jx7/Y/HtFqr78aoSIgrTSuAuIILRFDEE21iusHe56fn+pAqXZoM
 TIIhinn6WGyac12L9kvQmX6IYhGqpKQ3i0u4JwkSG/FSHQkEJKBusdhVeQaC8EUzeq
 pXyywuOCwgjG4q5OZB+2UGP4=
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-375ecf5e30eso20962991fa.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761952530; x=1762557330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeTg+HjlZHeIYvagZ+G0Bf5YhAFMqys22xR161NbwcI=;
 b=irLRdVCuI2FiCXnLB3jT2TjqvQjBLjiXF4qP7gib8lJR5uzEiKjxp4c8xSLg1jIDoi
 GRanTCB1bSfukROBmsXtfizTe67tJHxc5DknwIse/Nh2iiTnDOrHtowMIOk6faHJDWpq
 kblBZSGJNqDm8Ptjy4/1ZT0mlE5Qu85jpHKteysLEZA3QbZczCfE6MUgebBzOVXBqDdO
 eIZfhFSWxMBxZFTifGRWHKZN7fkglD0DGD74p6QlybCSCPoo3eX7Nj54eDc+4D5N3PEC
 fZqcMVBUoLYVjZ4Oh2fPnlAnQArU6OHYoWJpy5dd2xV1ytVBCkb9Qm5Waa3/o1BSZied
 7mrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK+QewU2t7cSzQ0T5sfQcSFLnaDFJIkmHWT3XBfo6UXam+k5no0bKjYrOlx2zJcH3veHkvV70=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4TNcqVP2IN1wu2ykKCaj4A217v1k1meuR/+HFNn9xKgyhmjlP
 RYMdKEl250R+48ydIwmsmGW1JLv3niH/K/9PtezsyUhZgIxZxVPmjdJNITPKi8sBVEIbR9aYcKe
 VxAGoE9nt46Xmap26ZQIGSw1qq/yjGJJHm4wpB1id0SvSSM08Vb6IpsigeI2fb/vuZjMcabY=
X-Gm-Gg: ASbGncsG+adyP59luPk6AY9LCBJwKqWUxofS1401ODgmBovBd28sB0ca1kTEAszgmE4
 qDNiRRi7QWsbfxr23/unYz7WERp0++ykSqJ+/p1O2icqRokBNG7dsVUBLiLFSvPhL2aK0sIpEme
 ctBUD84McR4T9KWLgmaWMOTetgdQP+YtPTqoz3DdM23xYUDRpOtnAnW1KAEx1bgD5O/FeQfoMHm
 lsTbCrrvCgH1PPVtkIKeMwRUjvdd/mHMy+UQjp3SylU8Vk4iGjlNUY0VKHympQWpZgMEtUsVvHp
 afplf1KesH2ldoOLBYfWVag5YGNGiap9YaDWI+J3hoIMw8LD0Hy6ryGLMHGxV8QnjcA53CH8Z4g
 QxIdChK/sAmE8iKwwl+FU5opTB0ZPNHfJ1m2i5Ab4coQZCg==
X-Received: by 2002:a05:651c:23d3:20b0:378:e055:315e with SMTP id
 38308e7fff4ca-37a18dc63d8mr13729371fa.24.1761952529774; 
 Fri, 31 Oct 2025 16:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELI0+TQP8Ab+fxPjj+g/ydfsF096RZ7oC0nbb/BhPm9pjSvtZqzjbJ2I6/5BWbdvfUjsIUig==
X-Received: by 2002:a05:651c:23d3:20b0:378:e055:315e with SMTP id
 38308e7fff4ca-37a18dc63d8mr13729281fa.24.1761952529349; 
 Fri, 31 Oct 2025 16:15:29 -0700 (PDT)
Received: from [172.26.193.244] ([93.94.208.154])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37a1c0add82sm6764021fa.25.2025.10.31.16.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 16:15:28 -0700 (PDT)
Message-ID: <ce99beac-49ca-4b18-83f0-0b42a54f6cd1@canonical.com>
Date: Sat, 1 Nov 2025 00:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] qfw/acpi: do not zero out XSDT address
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/31/25 20:59, Heinrich Schuchardt wrote:
> Since release 2025.01 the discovery of QEMU ACPI tables is broken.
> 
> * Remove the line erasing the pointer to the XSDT table
> * Add a test for the 'acpi list' command
> * Provide a configuration that can run this test
> 
> This series goes together with patch
> 
> [PATCH 1/1] CI: test qemu-riscv64_smode[_acpi]
> https://lore.kernel.org/u-boot/20251028131720.55212-1-heinrich.schuchardt@canonical.com/

With the series applied I can use

qemu-system-riscv64 \
   -M virt -m 8G -smp 4 -cpu rva23s64 \
   -kernel u-boot \
   -serial mon:stdio \
   -device qemu-xhci \
   -device usb-kbd \
   -device usb-tablet \
   -device VGA \
   -display sdl \
   -drive file=ubuntu25.10-riscv64.qcow2,format=qcow2,if=virtio \
   -netdev user,id=net0 \
   -device virtio-net-device,netdev=net0 \
   -audio pa,model=virtio \
   -device virtio-rng-pci

to boot a RISC-V virtual machine using ACPI (not device-tree) running 
Ubuntu 25.10, kernel 6.17.0-5-generic with an Xfce desktop. Here is the 
relevant kernel output:

[    0.000000] efi: RTPROP=0x27de43040 ACPI 2.0=0x27ee72000 SMBIOS 
3.0=0x27ee83000 INITRD=0x27de2f040 RNG=0x27de2e040 MEMRESERVE=0x27de2d040
...
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000027EE72000 000024 (v02 BOCHS )
[    0.000000] ACPI: XSDT 0x000000027EED340A 00004C (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000027EED2EF2 000114 (v06 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000027EED2040 000EB2 (v02 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x000000027EED3006 0000E0 (v07 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: RHCT 0x000000027EED30E6 00028E (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: SPCR 0x000000027EED3374 00005A (v04 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: MCFG 0x000000027EED33CE 00003C (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: SPCR: console: uart,mmio,0x10000000,115200

The QEMU device-tree passed to U-Boot is not used in this case:

$ dtc -I fs -O dts /proc/device-tree
/dts-v1/;

/ {
         #address-cells = <0x02>;
         #size-cells = <0x02>;

         chosen {
                 linux,uefi-mmap-size = <0x5f0>;
                 bootargs = "BOOT_IMAGE=/boot/vmlinuz-6.17.0-5-generic 
root=UUID=171edd56-ad1d-4ca9-8f9d-503b05bdc840 ro efi=debug earlycon=sbi";
                 linux,uefi-mmap-start = <0x02 0x7de2b068>;
                 kaslr-seed = <0x00 0x00>;
                 linux,uefi-mmap-desc-size = <0x28>;
                 linux,uefi-mmap-desc-ver = <0x01>;
                 linux,uefi-secure-boot = <0x02>;
                 linux,uefi-system-table = <0x02 0x7f6b4fb8>;
         };
};

$ ls /sys/firmware/acpi/tables/
APIC  DSDT  FACP  MCFG  RHCT  SPCR  data  dynamic

Best regards

Heinrich

> 
> which enables running CI tests on qemu-riscv64_smode_acpi_defconfig.
> 
> Heinrich Schuchardt (3):
>    qfw/acpi: do not zero out XSDT address
>    test: provide test for 'acpi list' command
>    configs: CONFIG_CONSOLE_RECORD=y on qemu-riscv64_smode_acpi
> 
>   configs/qemu-riscv64_smode_acpi_defconfig |  1 +
>   drivers/misc/qfw_acpi.c                   |  1 -
>   test/cmd/Makefile                         |  3 ++
>   test/cmd/acpi.c                           | 52 +++++++++++++++++++++++
>   4 files changed, 56 insertions(+), 1 deletion(-)
>   create mode 100644 test/cmd/acpi.c
> 

