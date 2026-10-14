Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00AFCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DBE360802;
	Wed, 14 Oct 2026 14:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2LfKH6WMfJT; Wed, 14 Oct 2026 14:17:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15AD1606C7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987445;
	b=fGsyAc4nAGImK4cJcIEosgNTBqv03zQBmhUlNF4MTcboj8+ImduRzI07CMfCqe55ohUH
	 BwakuS778RbkSYd57vGpscrbUmC5UJMkSzAc5s4PRfGENAdLN3cWAtQcTdiTWxzy1jrGW
	 l1ca0nRQ8opfD8m5hUCCVXkIJWTJK+GgohGL1c3RVyy0QqybSAJSmuQwEbwoAQQgpHPQR
	 casQ1SAMjVQfSha7rZDX72sVF9x++HpvmYptEwDiCq0w/nXvzWQzDkd3rd51TBWtcxsMC
	 I/uNKrLS5FoDu0Alb61dkkMZwmETJV4qxmresBH4AATOGjWJUIDghOntjI7LESKTjuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IV+YTLP72r/inBlBUEcKSHjMeCm3aCLj3+lWi6Xb39Q=;
	b=WKtLTJngON79gGd+v9g7VpqgNkwT6VnBtAKFDaJy4HFakyei4HkPNWOjHC8Zg2u7s+r6
	 SL3b4JhsrbeH3I7pGhc7nEPjbwjmcAmPky0EwlWTFL1XBNfswdak9PK8ctK5KNGThDzx7
	 Eb9cimGb1RhlSMxcj6gYLwdPWxy9NPXDVYi1zF9q/viRI4uhWlTnsc4LpF2rQhKr25UNm
	 W81EbPfh57s4p0xsUhrt1ysuvWhUJ397OIFbRyseVOI+Fr1FE8iUea6Ggf99zGwMU3lox
	 EEH6TWQFK23g/ghETbhD8oQ0UukWIG3mjcaf4+VSAGAcgxJRBVEGC0XK8wVzPGdPDZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987445;
	bh=IV+YTLP72r/inBlBUEcKSHjMeCm3aCLj3+lWi6Xb39Q=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cDXbiJF8QqJLJHnCK1eD1CXxOlfseCSn9jTftH66e3NdGU/S3tSd0tLLbfjZi+SuP
	 P9caIk3dTd0wqY5bwG0qF86aFgNrVqzqRbFfukSjsx4MtvLml2EeizooStmVXYdaAv
	 gQo9kQ84iaeq47f0bY0WUrlZKPvGJ/gmydU5A8aqZ8i/6PLDaZw4ZTaGjL2tMOkBWe
	 j+KEYOIoqv3l3usvLSjl/6gZnBdPMZ/xytlXbXQ+2HGYt3dqhHhOgIc0ISLtq8Nfcv
	 1+kZNziul3NazYfv0jb87rTgoV3iSFLOyXWaYHtmNd9wcOUXWPgVcZN4HneRzcSZEK
	 vbeK6ilO9+W2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15AD1606C7;
	Wed, 14 Oct 2026 14:17:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 587991518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A17D400B4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bSVwZlEG-7G for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0B68C40063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987442;
 b=Wn9/gKEzf+8N+zCbkvyKL+FYSNor/5EPEdFhgBauf8rbUWhRUTRYLbnrG32r0eAh2onZ
 FuQlhdi9eAkB3CHdpor/IBbZkZP2jNZnpguNkNyqs4vbyTsibTdmR+WdJpnuEmg2+AHRR
 wsxET/9DTp9et/aGZD0DlU9bjISjk7ib4HvkLZXWH9qBfF2kd8EvabqFdcYpZcyQr8RFk
 ARV48J4kvl+51SeOws1teI69ya6IZFyjyABk09SiGNpRprlma5t1PTgaks0phFWSxm3EG
 9JUF2AUHh8P3tQojHZ3xC4AnszKet492w6V+sGzEHSgEqTtC0/4+GU6cYf6XPDWYmCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987442;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Subject:
 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
 bh=IV+YTLP72r/inBlBUEcKSHjMeCm3aCLj3+lWi6Xb39Q=;
 b=fzx0u+jn+fntbpDobDfV7QQnfUGnHxL/Sa7YMIBiaZG5tQgQsOPdpj33wghkcoShi0XU
 VZ5MKTxkN8TudkYlAAoJzWASp9xcZkGcaj8SXjRAyhhbs1U7DsO/MzIAfFijgMSgLWjh6
 nPJHUq0+FFPeVMxudye4/WJBcvlgolWfcZwih+JQSxTF6NN9No8jAtGjuYLERyaDp0M30
 dtklbYolZbJJco00C2PwcwpusmFyc5cOjC8eT3iErXhVERrJ7eF8TLgBv+JW5vHsV7xCx
 qWvaDOz1aLy7SRy/8desdr2wda5fNuQ1lCxATajo86ItpPzP5PIqE4lU+xY7L4uOIgg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=kPKOPWeS; 
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=kPKOPWeS
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B68C40063
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987442; x=1823523442;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=pfl8SU4KatwcXShKkoVzuLf60PURjcYgcRu0gT+lK34=;
 b=kPKOPWeSvZKrDb6CcNWcNNE31iduWPflBAufJ88gIyXfsTArDAfYiK4D
 c2d64GMrpklJTN1zZTco3MKWlh/C9C8TDYnXQtM8fS5Qs014fN1ZCuQAT
 b86YLdaRFG4bM+Xz0uF6bDG0hVaIgODtmnepGzc0KGlsmeKcI4W0RYQn5
 +JbE6v+nCNOkizEcUhr2w9NyssVfQTVlxBtbgQLE5i2QelRZ4oUKWERej
 5eZYE8fmfhMav10hEWNQ0vWoJ8OUhOVp+XTX8pFErJiJd1Xn3zH4Eip5w
 zTls9j2jJbAcCZ82Hls58utUjem6Oqh3QYE1rrkOZXIR0vEanDj2kAxeq Q==;
X-CSE-ConnectionGUID: Zp5xnNXjT0SSu3xnjvEqJQ==
X-CSE-MsgGUID: hNijcksHTNavmHb6egtsbA==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; d="scan'208";a="65036161"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:17:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 07:17:19 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:16 -0700
From: Charles Perry <charles.perry@microchip.com>
Subject: [PATCH v4 0/8] Add support for RPMI to U-Boot
Date: Wed, 14 Oct 2026 10:17:04 -0400
Message-ID: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mj3aKC3Mz4MhNdC0PDNNMUMwuL5KRkJaDqgqLUtMwKsEnRsbW1AM/
 rh0pZAAAA
X-Change-ID: 20261012-rpmi_v4-811f5d688cbc
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello,

This series adds support for RISC-V Platform Management Interface (RPMI) to
U-Boot. RPMI is an OS-agnostic protocol for communication between an
Application Processor (AP) and a Platform Microcontroller (PuC) [1]. There
are some similarities between RPMI and SCMI.

This patchset first adds an abstraction layer for the transport
(UCLASS_RPMI), then adds two transport layer (SBI MPXY and shared memory)
and finally adds one client (or service group in RPMI jargon): the clock
service group.

This series also includes a sandbox mode for which the RPMI transport
doesn't attach to a firmware but contains a simulation of a firmware. This
reuses code from librpmi [2] to create the message responses.

From V3, this series also includes the "mpxy" command line tool created
by Rahul [6].

Apart from the spec [1], this series reuses code from the Linux SBI MPXY
driver [3], OpenSBI shared memory transport [4] and Linux RPMI clock driver
[5].

This was tested on a PIC64-HPSC SoC which features an application cluster and a
system controller with isolated address spaces, hence the need for RPMI. This
series can also be tested with QEMU using the steps detailed in the following
section.

# Testing

## Build qemu

Build QEMU using Subrahmanya Lingappa v11 patches [7] that adds support for
librpmi along with another patch (by me) that adds some phony clocks for
testing. This is available at [8] for your convenience. You will also need to
download and build librpmi since it is a dependency of qemu, any recent version
should do. The following commands do all of this:

````
git clone https://github.com/riscv-software-src/librpmi.git
cd librpmi
make
make install I=install
sed -i "s|\${prefix}|$(pwd)/install|g" ./install/lib/pkgconfig/librpmi.pc
export PKG_CONFIG_PATH="$(pwd)/install/lib/pkgconfig:$PKG_CONFIG_PATH"
cd ..
git clone https://github.com/ch-perry/qemu.git -b rpmi_patches_with_clocks
cd qemu
./configure --enable-librpmi
make -j8 qemu-system-riscv32 qemu-system-riscv64
export PATH="$(pwd)/build:$PATH"
````

## Device tree

We also need to tweak a bit the device tree used by QEMU. This is done
externally because we need to append a different fragment depending on if we're
testing M mode U-Boot or S Mode U-Boot.

For M mode U-Boot, we use:

```
cat <<EOF > overlay-mmode.dts
/ {
	clock-controller {
		#clock-cells = <1>;
		mboxes = <&{/soc/mailbox@10200000} 0x08>;
		compatible = "riscv,rpmi-clock";
	};
};
EOF
```

While for S mode, we use:

```
cat <<EOF > overlay-smode.dts
/ {
	clock-controller {
		#clock-cells = <1>;
		mboxes = <&mbox 0x1000 0x00>;
		compatible = "riscv,rpmi-clock";
	};

	mbox: mailbox {
		#mbox-cells = <2>;
		compatible = "riscv,sbi-mpxy-mbox";
	};
};
EOF
```

## Test RV64 in M mode:

Source your RV64 compiler, build U-Boot's qemu-riscv64_defconfig and test with
QEMU:

```
make clean
make qemu-riscv64_defconfig && echo CONFIG_CMD_CLK=y >> .config
make -j8
qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=on,dumpdtb=qemu.dtb
dtc -O dts qemu.dtb | cat - ./overlay-mmode.dts | dtc -o qemu_mmode.dtb -I dts -
qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=on -dtb qemu_mmode.dtb -nographic -bios u-boot.bin
```

`clk dump` should report 2 clocks.

## Test RV64 in S mode:

Build any recent version of OpenSBI using the generic platform and the default
defconfig:

```
git clone https://github.com/riscv-software-src/opensbi.git
cd opensbi
make PLATFORM=generic
cp build/platform/generic/firmware/fw_dynamic.bin ../u-boot/fw_dynamic_rv64.bin
cd ../u-boot
```

Back in U-Boot, build qemu-riscv64_smode_defconfig and test with QEMU:

```
make clean
make qemu-riscv64_smode_defconfig && echo CONFIG_CMD_CLK=y >> .config
make -j8
qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=on,dumpdtb=qemu.dtb
dtc -O dts qemu.dtb | cat - ./overlay-smode.dts | dtc -o qemu_smode.dtb -I dts -
qemu-system-riscv64 -cpu rv64 -smp 4 -M virt,rpmi=on \
    -dtb qemu_smode.dtb -nographic \
    -bios fw_dynamic_rv64.bin \
    -kernel u-boot.bin
```

`clk dump` should report 2 clocks. You can also use the `mpxy` command.

## Test RV32 in M mode:

Source your RV32 compiler, build U-Boot's qemu-riscv32_defconfig and test with
QEMU:

```
make clean
make qemu-riscv32_defconfig && echo CONFIG_CMD_CLK=y >> .config
make -j8
qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=on,dumpdtb=qemu.dtb
dtc -O dts qemu.dtb | cat - ./overlay-mmode.dts | dtc -o qemu_mmode.dtb -I dts -
qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=on -dtb qemu_mmode.dtb -nographic -bios u-boot.bin
```

`clk dump` should report 2 clocks.

## Test RV32 in S mode:

Build OpenSBI for 32 bits, the instructions are the same as for 64 bits but with
an rv32 toolchain in CROSS_COMPILE. Build U-Boot's qemu-riscv32_smode_defconfig
and test with QEMU:

```
make clean
make qemu-riscv32_smode_defconfig && echo CONFIG_CMD_CLK=y >> .config
make -j8
qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=on,dumpdtb=qemu.dtb
dtc -O dts qemu.dtb | cat - ./overlay-smode.dts | dtc -o qemu_smode.dtb -I dts -
qemu-system-riscv32 -cpu rv32 -smp 4 -M virt,rpmi=on \
    -dtb qemu_smode.dtb -nographic \
    -bios fw_dynamic_rv32.bin \
    -kernel u-boot.bin
```

`clk dump` should report 2 clocks. You can also use the `mpxy` command.

# References

[1]: https://github.com/riscv-non-isa/riscv-rpmi
[2]: https://github.com/riscv-software-src/librpmi
[3]: https://elixir.bootlin.com/linux/v7.0.10/source/drivers/mailbox/riscv-sbi-mpxy-mbox.c
[4]: https://elixir.bootlin.com/opensbi/v1.8.1/source/lib/utils/mailbox/fdt_mailbox_rpmi_shmem.c
[5]: https://elixir.bootlin.com/linux/v7.0.10/source/drivers/clk/clk-rpmi.c
[6]: https://lore.kernel.org/all/20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com/
[7]: https://lore.kernel.org/all/20260917052250.1041262-10-subrahmanya.lingappa@oss.qualcomm.com/
[8]: https://github.com/ch-perry/qemu/commits/rpmi_patches_with_clocks/

# Changelog

Changes in v4:
 - I forgot to send patch 1 in v3, add it back.
 - Add patches 7 and 8 that add the relevant RPMI defconfig to
   qemu-riscv[32|64]_smode_defconfig and qemu-riscv[32|64]_defconfig
 - Add instructions on how to test on QEMU in the cover letter
 - Fix the default value of the doorbell from 0 to 1 in the MPXY driver
 - Force a device_probe() of all UCLASS_RPMI devices if g_mpxy is NULL in the mpxy command
 - Remove the unnecessary edit to "cmd/riscv/Makefile" (mpxy command)

Changes in v3:
 - Added the "mpxy" command from Rahul. See [6].

Changes in v2:
 - Drop the device-power service group as the DT bindings for it are not
   mainlined (was patch 5 and 7).
 - Reorder headers in all .c files.
 - Don't null check pointers before free().
 - Improve error messages in rpmi_check_versions() (patch 1).
 - Remove struct sbi_mpxy_rpmi_channel_attrs and struct
   sbi_mpxy_channel_attrs for simpler u32 arrays (patch 2).
 - Remove transition_latency from struct rpmi_clk_def as it's unused (patch 4).
 - Simplify last return path of _rpmi_clk_enable_disable() (patch 4).
 - Move the call to _rpmi_clk_get_rate() from _rpmi_clk_set_rate() to
   rpmi_clk_set_rate() (patch 4).

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Charles Perry (7):
      firmware: add support for RPMI
      firmware: rpmi: add support for the SBI MPXY transport
      firmware: rpmi: add support for shared memory transport
      drivers: clk: add support for RPMI clocks
      firmware: rpmi: add a test and a sandbox driver
      configs: qemu-riscv[32|64]_smode_defconfig: add RPMI configs
      configs: qemu-riscv[32|64]_defconfig: add RPMI configs

Rahul Pathak (1):
      drivers: firmware: rpmi: Add the mpxy command

 MAINTAINERS                                |   8 +
 arch/riscv/include/asm/sbi.h               |  57 ++
 arch/sandbox/dts/test.dts                  |  12 +
 configs/qemu-riscv32_defconfig             |   3 +
 configs/qemu-riscv32_smode_defconfig       |   4 +
 configs/qemu-riscv64_defconfig             |   3 +
 configs/qemu-riscv64_smode_defconfig       |   4 +
 configs/sandbox_defconfig                  |   2 +
 drivers/clk/Kconfig                        |   7 +
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk_rpmi.c                     | 344 ++++++++++++
 drivers/firmware/Kconfig                   |   1 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/rpmi/Kconfig              |  34 ++
 drivers/firmware/rpmi/Makefile             |   4 +
 drivers/firmware/rpmi/rpmi-sandbox-clock.c | 446 ++++++++++++++++
 drivers/firmware/rpmi/rpmi-sandbox.c       | 156 ++++++
 drivers/firmware/rpmi/rpmi-sandbox.h       |  47 ++
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c      | 806 +++++++++++++++++++++++++++++
 drivers/firmware/rpmi/rpmi-shmem.c         | 473 +++++++++++++++++
 drivers/firmware/rpmi/rpmi-uclass.c        | 144 ++++++
 include/dm/uclass-id.h                     |   1 +
 include/rpmi-uclass.h                      |  79 +++
 include/rpmi.h                             | 159 ++++++
 include/rpmi_proto.h                       | 125 +++++
 test/dm/Makefile                           |   1 +
 test/dm/rpmi.c                             |  48 ++
 27 files changed, 2970 insertions(+)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261012-rpmi_v4-811f5d688cbc

Best regards,
-- 
Charles Perry <charles.perry@microchip.com>

