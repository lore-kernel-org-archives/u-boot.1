Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCC606A334
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Go8sFXt1;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=bTU2TYkC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2CD08177A;
	Fri, 13 Nov 2026 19:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEBNtvCHzOb2; Fri, 13 Nov 2026 19:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37C1381771
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599001;
	b=moGxVKIktItiwe0u/j/5vfoHBqL1dTQB+mSYyuZ7GtsgpGuZN7ACoWX68dEOEy1zUxnT
	 71KwiPRESTEDIYL/tOmRigi6b2fAsaOyBC2ddcoJnAeRSP9NhnSS44zd8zo9LP8sQRLaa
	 zVwEIKbZ1vmHCE52A8SXAbLSyl6+JJlUe7I29KiZGSJ4L7H++g6ig4pJdDVHbOgLRW+XQ
	 TPhiPCuNe3UYmLxpiGElOSRmx4WzHKrQYNf8zOAkm/G/rkhEpx4i8QvUWl4Qp+nzcrs+d
	 LqDaKnCSXk35h6HWNl4spj7h2a6D8mcUOT/DlnLUmkIw50Y9PxJ6i9wBFUMIAu5v1kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xoOoxaDy9IB4Hn427JbAGgM77j7OM9LSk1JZr2k9V0M=;
	b=JxU5pJK9XKR+dtg+iI74iUn0XqW/IxDeY6hAwotBOYQHTc0lOjGg8p/vf2enOiTGXkSN
	 ukbsAUh6CrIgbYnvs9C2JNo3rUpD5AIcI0DjZWgLOkZqA+XN+iTYYwzQVpoyukdcyQPh/
	 BUYIdoqlOwl9TpXcgDSNSueMJtbFwRab2768gADEo3Lw0DXszqICAjAP+P9WAckLvmiBc
	 K2aytJTM3cPAHggz0iXpPPrD7H3kUs6+VonhXCxvV7JFqSMPUHLkjZvnJcc5BLWbt691w
	 OzxA70dXw7bYeeiVwZ3zE2IWI8wbZo3jYKEQISiLlPuz5Xdy6Ua+t+jou8WrQGbaySg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599001;
	bh=xoOoxaDy9IB4Hn427JbAGgM77j7OM9LSk1JZr2k9V0M=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Go8sFXt1d5HBa1wUZATLzHjO+2+MaRRSb1gbBqDY7C81dCWpJ5CPZKLMx1Bqy2eWM
	 5ya5VrL3i2hWzA3/OyGZD8GcFmpUhrJFtu6LR4ylbkEWak8U/DZoPf6bjyUH2Pc5wx
	 0C11530WfN8uFHM4+SwnDmb14B9nfzA/nKxwlMFOx6ZH5RRoDm9m+erjJ0S88HLnNh
	 e8cpxjwaYc5Hbdizi4cYl6TpS60z7IJfIcINpoGeQT9nky2J80bHKYn40oZ3rLoIIc
	 m0C/YVUsj8/z/kgg3IEMpv56T7Y7jqycYUMLJl5+6jTy+h+4jhdsGgcHdIAs9T/I+5
	 ea7QsnikOPkjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37C1381771;
	Fri, 13 Nov 2026 19:43:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3D5E2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E579B6068F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzBr7E2MdqPs for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 232D160687
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=bTU2TYkC
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 232D160687
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794599007; x=1826135007;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=t/6Yj0XVf+mdsad+/v2eOgDzOahhHbwWR9tFUnXODDc=;
 b=bTU2TYkCPlshTjay2ZfUyoT3t5eQW0ViWJ89WzA5eKO4Rp9EMxwJdAsB
 a3BInu73hT+W/vhfu2yILldVFXzXHl2bTEINhllWObZU+YIDbxGYBKX3T
 Au8BReS6xibtM/QEJ19HOavy89PAvaFzYg00yTX5ELf/dkA4g/5l8D6mr
 Bb32Kwvu+N7rev02fhE40oMM5zZiKG3d+4QU5izEKC3DbOWBaVxbaPW/n
 MtBblq8dpo5JLdGXtxXsfsDuZpKeTNcgsuJAXdg1kYANwzM82j/qhG7s1
 Lh8PJiYqnOjcpEmh2DVROPSIpm2ti4dScoHETaB/SBOlk4DP8CmBUb5U6 w==;
X-CSE-ConnectionGUID: RDA0KOKATRWk8FaNZNAJXw==
X-CSE-MsgGUID: xZu+KMmiRqCbAkN6PKz4MQ==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="66484151"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2026 12:43:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 12:43:15 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:43:13 -0700
From: Charles Perry <charles.perry@microchip.com>
Subject: [PATCH v5 0/8] Add support for RPMI to U-Boot
Date: Fri, 13 Nov 2026 14:42:54 -0500
Message-ID: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z3M0QrCIBTG8VcZ5zpDnS7bVe8RI5a6PBdO0ZBi+
 O7ZoODc/A8fvw2yTWgzjN0GyRbMGNYW8tCBdvP6sARNa+CUD4wyTlL0eCuCKMYWaQal9F1DW8d
 kF3zt0nVq7TA/Q3rvcBHf788Qf6MdJUb2phezOJ8UvXjUKWiH8aiDh6nW+gGw1NqqogAAAA==
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
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

## Test using the sandbox mode

Use your native compiler.

```
make sandbox_defconfig
make -j8
./u-boot -T -c "ut dm rpmi_clock"

...

Test: rpmi_clock: rpmi.c
Test: rpmi_clock: rpmi.c (flat tree)
Tests run: 1, 4 ms, average: 4 ms, failures: 0
```

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

Changes in v5: 
from Subrahmanya review:
 - Add some defensive programming against a faulty PuC:
   - The MPXY driver checks the returned length against max_xfer_len
   - The shmem driver checks is the returned size exceeds the slot size
 - MPXY:
   - Access the head and tail via readl/writel and data slots with
     memcpy_[to/from]io
   - Match the service_id and servicegroup_id in addition to the token
   - Make sure the slot-size is a power of two
   - fix a bad indexing into mpxy->channel_descs[]
 - remove rpmi_clock_sg_get_supp_rates() since it's unused by the clock
   driver
from Leo review:
 - Compile MPXY only if CONFIG_RISCV_SMODE is true
from LLM review:
   - Remove the "g_mpxy" global variable and use 
     uclass_get_device_by_driver() instead.
   - fix the case where sbi_get_spec_version() returns an error code
 - Link to v4: https://lore.kernel.org/r/20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com

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
 drivers/firmware/rpmi/Makefile             |   6 +
 drivers/firmware/rpmi/rpmi-sandbox-clock.c | 357 +++++++++++++
 drivers/firmware/rpmi/rpmi-sandbox.c       | 156 ++++++
 drivers/firmware/rpmi/rpmi-sandbox.h       |  47 ++
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c      | 820 +++++++++++++++++++++++++++++
 drivers/firmware/rpmi/rpmi-shmem.c         | 496 +++++++++++++++++
 drivers/firmware/rpmi/rpmi-uclass.c        | 144 +++++
 include/dm/uclass-id.h                     |   1 +
 include/rpmi-uclass.h                      |  79 +++
 include/rpmi.h                             | 159 ++++++
 include/rpmi_proto.h                       | 125 +++++
 test/dm/Makefile                           |   1 +
 test/dm/rpmi.c                             |  48 ++
 27 files changed, 2920 insertions(+)
---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261012-rpmi_v4-811f5d688cbc

Best regards,
-- 
Thanks,
Charles

