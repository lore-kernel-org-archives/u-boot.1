Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A37EE57F0
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 15:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E41F83F6D;
	Wed, 31 Dec 2025 16:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GG+3zuCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B3E84097; Wed, 31 Dec 2025 16:23:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A73839A5
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 16:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9A4723F452
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767194602;
 bh=Kw/ELyAaZcUWTw8BzVy/TcDkvRqMvuTbOM9F26mZsEk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GG+3zuCU354t3ynUBKac5l1Z35Z4X/BrtsElZmcGWktftV2gpiwyEs1IXj5ruV2yK
 J57RUNZ7zrOXmFYhwkYy/6MZTgVCw4Idh6nBI7YMDxYMixFs+A7GFFPx6Nm07vZptu
 xxtUMwmdXgnRUAE8lZstmmtBZSkKgbOoRNwekCNzbKZBW5r/LDYF0fuHBlm7r963WT
 x8flP/plk+7Ykb9cqkcMRnHC7rMdnEbQHGR0ZM4C3hVyGVSoUXkyPoqZ0trfa1Y/7v
 2IXACWR+iuzawIbdK9XL5P7VpjSJUovvcw3O0nB6qp4OB3iKecbZKG8K77sm5zXEIq
 2ERA2UYvJqYSxKEWrzHCkrsfzd6neqJtsn99KwvBAzr8MlmK5AqSudlOBYGujAp5nT
 EhERsiSr9TdVNGWc9AjlnfQqrgyqBo5fkNW+TPrwWSHqpgjvLAOAFMv9L/aFsv1iTX
 fSdwrbv5ZPtJDeTFnfoZGKPz2IHcsB/JtOlnyi5jeH40t2JPdIunbiIU4qzeUS0jO4
 cSwemWgjpFJudX33Tsw5mcf8m9xEYBx0tCmegGIzub+X41vlEyFjSteMxWns8qnV/p
 3Nwu2tMZcd0tdQl9c7SlGzWatfWxU7NBSyK72wD93n3mDwkxujGbLEIrky7D5kWMk6
 0V/F78nIF/Hqi598HFbIE230=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47775585257so76023815e9.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 07:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767194602; x=1767799402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kw/ELyAaZcUWTw8BzVy/TcDkvRqMvuTbOM9F26mZsEk=;
 b=LSSf2kImtoKtm/MSiZeO4GE+Ls+rCyJZBtrjXrEX3f9XusEI1QTd22pRgCR58MZChq
 K8xr/RZ09i8xnJLx8xhne20HMSOftTaYxkXlSyKbY0w/IBxd4ZeuukS6ZliXB8gswtmB
 cHRZA2yi1rscT10a1eEyG3A97DjlDGhzUT4JppRz2XVnvRufdMJDswxbOZyfvQoZ6UKk
 gDJ9stXtCpEZ8EUAws5N00OERT8fsDa2rwYPcHBkErs3K7iGkVR2H3/SmoqgGd/7KEB0
 VJn/awN2e4NA4AgX197eVIzqxmFitZGvYdBZJocbo4i2Sf0gt53meLrWdgG0Z3pQxFUL
 xrnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrU1exHUAveddtfz93jHYfcCeNgMHuUQ06XXK7DDVhHmvzVqZx98c+YB9dxTvgT7MBp2CCPOQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2njCfiXLOgYOksgtVIVxTHr6CO7CNWET61KXrAsO+M20rWu3L
 sL0zm7sP2NEmLr5FKEnlEjl+bllutCZEBIGsQ7nJytfIJKcUvLICI+0VKLj4+6XH3oCYkSbAyLk
 gdhFP9aEpTasPJVjbUSzXpoQpey+fOCXtmoGIbgoEAlWDP7joc8GfzFhWrxOEzXI6DSzRsIg=
X-Gm-Gg: AY/fxX6vH8zt+w/nX/9JXWL93f3xGsVeAeKA/Y2Z0HmcUvFb2Oxjz/7qoIG2mV2D9Yg
 CZOL0fcEIeUo+RXZw3TqEoadggf98NjcI7DEvH9iOCL9bJ/U4U25wl9ty+k1X5gBNbLQw95a03y
 RkVylL7mDcVs868jVtoAAMfXGttWX4AQXZmTBGX0IdqiLO4Q4VR1c7KkrkiUqdx1HsK88urz2sq
 UlxX/ZYeP+XSjUCME8EuE11uM6ebiF3rdtB9xJzSwVmCLn91RVnFcHH2Bqq9+30YsFcpftSN/59
 /r8l1yz7iOeIfObfS9++0leolVWjIbwH+XXFqUFJTuUXuUvD8CV4yxE0vH2nF9TK0u742janFKJ
 6uFnCbERNQITW50Q/uS11W8BLDcDgQ8naX/D1TzEpoUq8yigKLXgSEL9jW0nA61BKxYTr+fmymp
 UaoMWO7i8=
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d19546487mr434959605e9.12.1767194602046; 
 Wed, 31 Dec 2025 07:23:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6We5G7FdZ3sCbA75Vk/luRGuSEG7zQpZppEbqtDFxgKcBawevHuPktpCpjUkpolxPIuvR/w==
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d19546487mr434959295e9.12.1767194601591; 
 Wed, 31 Dec 2025 07:23:21 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723d19sm761862225e9.2.2025.12.31.07.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 07:23:21 -0800 (PST)
Message-ID: <c31964fd-67ea-43fc-a6c2-7ee04ed1c1dd@canonical.com>
Date: Wed, 31 Dec 2025 16:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: emulation: Add network testing documentation
To: Manjae Cho <manjae.cho@samsung.com>
Cc: trini@konsulko.com, sujin.u@mobis.com, u-boot@lists.denx.de
References: <20251227142036.10661-1-manjae.cho@samsung.com>
 <20251230154529.29724-1-manjae.cho@samsung.com>
 <CGME20251230154543epcas1p1fccdde722bb4c0c3de6e64ef12d4a334@epcas1p1.samsung.com>
 <20251230154529.29724-3-manjae.cho@samsung.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251230154529.29724-3-manjae.cho@samsung.com>
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

On 12/30/25 16:45, Manjae Cho wrote:
> Add network testing documentation for QEMU emulation based on actual
> runtime testing with qemu-system-riscv64 and U-Boot.
> 
> Tested and verified:
> - VirtIO network device detection (virtio-net-device)
> - DHCP client functionality
> - TFTP file loading from QEMU's built-in TFTP server
> 
> The documentation covers VirtIO devices for both MMIO-based (RISC-V)
> and PCI-based (x86) machines, with practical examples of U-Boot commands
> and expected output.

In the meantime I sent

[PATCH 1/1] doc: describe QEMU networking
https://lore.kernel.org/u-boot/20251229163448.182538-1-heinrich.schuchardt@canonical.com/

Did you have a chance to look at it?

> 
> Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> ---
>   doc/board/emulation/index.rst   |  1 +
>   doc/board/emulation/network.rst | 58 +++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>   create mode 100644 doc/board/emulation/network.rst
> 
> diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> index f8908166276..507c38825c1 100644
> --- a/doc/board/emulation/index.rst
> +++ b/doc/board/emulation/index.rst
> @@ -8,6 +8,7 @@ Emulation
>   
>      acpi
>      blkdev
> +   index
>      qemu-arm
>      qemu-mips
>      qemu-ppce500
> diff --git a/doc/board/emulation/network.rst b/doc/board/emulation/network.rst
> new file mode 100644
> index 00000000000..6a08a6611b4
> --- /dev/null
> +++ b/doc/board/emulation/network.rst
> @@ -0,0 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0+

.. SPDX-License-Identifier: GPL-2.0-or-later

see https://spdx.org/licenses/GPL-2.0-or-later.html

> +
> +Emulation of network devices
> +-----------------------------
> +
> +QEMU can emulate network devices for testing U-Boot networking functionality.
> +The device type depends on the machine architecture:
> +
> +* VirtIO (for RISC-V and other virtio-bus machines)

RISC-V also supports PCI. For productive use the important message is 
that virtio-net provides the fastest emulation by hardware emulation.

> +
> +  .. code-block:: bash
> +
> +      qemu-system-riscv64 -nographic -machine virt -bios opensbi.bin \
> +      -kernel u-boot.bin -m 256M \
> +      -netdev user,id=net0 -device virtio-net-device,netdev=net0
> +
> +* VirtIO PCI (for x86 and other PCI-based machines)
> +
> +  .. code-block:: bash
> +
> +      qemu-system-x86_64 -nographic -bios u-boot.bin \
> +      -netdev user,id=net0 -device virtio-net-pci,netdev=net0
> +
> +The 'user' networking backend provides a simple way to test DHCP and basic
> +networking without host configuration. In U-Boot, you can verify the network
> +device is detected:
> +
> +.. code-block:: none
> +
> +    => net list
> +    eth0 : virtio-net#0 52:54:00:12:34:56 active



> +
> +TFTP boot
> +^^^^^^^^^

TFTP boot is disabled via `setenv autoload no`. The heading seems not to 
match the content of the section.

The dhcp, net, and tftpboot commands should be documented in 
doc/usage/cmd/. But mentioning them here looks ok to me.

Best regards

Heinrich


> +
> +QEMU's user networking includes a built-in TFTP server. To enable it, specify
> +a host directory to serve files from:
> +
> +.. code-block:: bash
> +
> +    -netdev user,id=net0,tftp=/path/to/tftp/root
> +
> +From U-Boot, you can load files using DHCP and TFTP:
> +
> +.. code-block:: none
> +
> +    => setenv autoload no
> +    => dhcp
> +    DHCP client bound to address 10.0.2.15 (1 ms)
> +    => tftp ${loadaddr} test.txt
> +    Using virtio-net#0 device
> +    TFTP from server 10.0.2.2; our IP address is 10.0.2.15
> +    Filename 'test.txt'.
> +    Load address: 0x80200000
> +    Loading: *
> +             15.6 KiB/s
> +    done
> +    Bytes transferred = 16 (10 hex)

