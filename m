Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198B1C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FE08404D;
	Fri, 26 Jun 2026 23:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="hVmAgcYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8767C84105; Fri, 26 Jun 2026 22:16:54 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52ADA83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6300e006a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782505010; x=1814041010;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ypNWLrydTf3fUYwWjygHKpGwncKI8CSauppKc4/Bd/o=;
 b=hVmAgcYgBylmz9oOMcaJY+t7iSjn9rcuDzP7gJsT7YI8PxC7zE2XQ/cG
 WEHXjHS3UbuEGbE7E2EFrFOMgfK58xGqsoN6alX/uaOu1rexblqKPx4oB
 Slv7oAqnIgX+TcXIW3uU96o1vlhc0fThS3r0+A8vYYoGJt0axp9kFKMAa
 zit3OXWqOywDnPOcRehpEBPXySSreMccJ2WcYh5bP936QfH23gfDikW7e
 B6LzCdkIGdunpwdWnqaRq5PIwzs94WjsbQLjxpTuUZRD+lFPtpqkmWTqX
 3TBNnFA+LfS9uTFJn62QwwhJRFGJVfn/ZpsOYqm7z9DvrPqPdavXbAcba w==;
X-CSE-ConnectionGUID: R+a0TYjTT5CKt6XDU80kdA==
X-CSE-MsgGUID: RkBfCw1xRW23sGl+KDPgHw==
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="59747531"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Jun 2026 13:16:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Jun 2026 13:16:47 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 13:16:46 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Charles Perry <charles.perry@microchip.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, "Heinrich
 Schuchardt" <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH 0/7] Add support for RPMI to U-Boot
Date: Fri, 26 Jun 2026 13:15:41 -0700
Message-ID: <20260626201613.1035208-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 26 Jun 2026 23:20:19 +0200
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

Hello,

This series adds support for RISC-V Platform Management Interface (RPMI) to
U-Boot. RPMI is an OS-agnostic protocol for communication between an
Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
goals and purpose of RPMI are similar to ARM's SCMI.

This patchset first adds an abstraction layer for the transport
(UCLASS_RPMI), then adds two transport layer (SBI MPXY and shared memory)
and finally adds two client, or service group in RPMI jargon: Clock and
device power service groups.

This series also include a sandbox mode for which the RPMI transport
doesn't attach to a firmware but contains a simulation of a firmware. This
reuses code from librpmi [2] to create the message responses.

Apart from the spec [1], this series reuses code from the Linux SBI MPXY
driver [3], OpenSBI shared memory transport [4] and Linux RPMI clock driver
[5].

This was tested on a PIC64-HPSC SoC which features an application cluster
and a system controller with isolated address spaces, hence the need for
RPMI.  I've tested the interoperability between RPMI clients and transports
with an S-Mode U-boot (using the MPXY transport) and M-Mode U-Boot (using
shared memory transport) and the following device tree fragment:

```
	firmware {
		rpmi: mailbox@7000000000 {
			compatible = "riscv,rpmi-shmem-mbox";
			reg = <0x70 0x00000000 0x0 0x3000>,
				<0x70 0x00003000 0x0 0x3000>,
				<0x70 0x00006000 0x0 0x1000>,
				<0x70 0x00007000 0x0 0x1000>;
			reg-names = "a2p-req", "p2a-ack", "p2a-req", "a2p-ack";
			riscv,slot-size = <64>;
			#mbox-cells = <1>;
		};

ifndef CONFIG_RISCV_MMODE
		clock-service {
			compatible = "riscv,rpmi-mpxy-clock";
			mboxes = <&rpmi 0x8>;
			riscv,sbi-mpxy-channel-id = <0x1000>;
		};

		device-power-service {
			compatible = "riscv,rpmi-mpxy-device-power";
			mboxes = <&rpmi 0x9>;
			riscv,sbi-mpxy-channel-id = <0x1001>;
		};

		mpxy_mbox: mailbox {
			compatible = "riscv,sbi-mpxy-mbox";
			#mbox-cells = <2>;
		};
endif

		sysc_clk: clock-controller {
			compatible = "riscv,rpmi-clock";
ifdef CONFIG_RISCV_MMODE
			mboxes = <&rpmi 0x8>;
else
			mboxes = <&mpxy_mbox 0x1000 0x0>;
endif
			#clock-cells = <1>;
		};

		sysc_dpwr: power-domain-controller {
			compatible = "riscv,rpmi-device-power";
ifdef CONFIG_RISCV_MMODE
			mboxes = <&rpmi 0x9>;
else
			mboxes = <&mpxy_mbox 0x1001 0x0>;
endif
			#power-domain-cells = <1>;
		};
	};
```

[1]: https://github.com/riscv-non-isa/riscv-rpmi
[2]: https://github.com/riscv-software-src/librpmi
[3]: https://elixir.bootlin.com/linux/v7.0.10/source/drivers/mailbox/riscv-sbi-mpxy-mbox.c
[4]: https://elixir.bootlin.com/opensbi/v1.8.1/source/lib/utils/mailbox/fdt_mailbox_rpmi_shmem.c
[5]: https://elixir.bootlin.com/linux/v7.0.10/source/drivers/clk/clk-rpmi.c

Cc: Rahul Pathak <rahul@summations.net>
Cc: Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Romain Caritey <romain.caritey@microchip.com>
Cc: Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>

Charles Perry (7):
  firmware: add support for RPMI
  firmware: rpmi: add support for the SBI MPXY transport
  firmware: rpmi: add support for shared memory transport
  drivers: clk: add support for RPMI clocks
  drivers: power: add support for RPMI power domains
  firmware: rpmi: add a test and a sandbox driver
  firmware: rpmi: add a test and sandbox for device power

 MAINTAINERS                                |   9 +
 arch/riscv/include/asm/sbi.h               |  57 +++
 arch/sandbox/dts/test.dts                  |  23 +
 configs/sandbox_defconfig                  |   3 +
 drivers/clk/Kconfig                        |   7 +
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk_rpmi.c                     | 346 +++++++++++++++
 drivers/firmware/Kconfig                   |   1 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/rpmi/Kconfig              |  27 ++
 drivers/firmware/rpmi/Makefile             |   4 +
 drivers/firmware/rpmi/rpmi-sandbox-clock.c | 446 +++++++++++++++++++
 drivers/firmware/rpmi/rpmi-sandbox-power.c | 174 ++++++++
 drivers/firmware/rpmi/rpmi-sandbox.c       | 158 +++++++
 drivers/firmware/rpmi/rpmi-sandbox.h       |  48 +++
 drivers/firmware/rpmi/rpmi-sbi-mpxy.c      | 449 +++++++++++++++++++
 drivers/firmware/rpmi/rpmi-shmem.c         | 474 +++++++++++++++++++++
 drivers/firmware/rpmi/rpmi-uclass.c        | 138 ++++++
 drivers/power/domain/Kconfig               |   7 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/rpmi-power-domain.c   | 229 ++++++++++
 include/dm/uclass-id.h                     |   1 +
 include/rpmi-uclass.h                      |  79 ++++
 include/rpmi.h                             | 159 +++++++
 include/rpmi_proto.h                       | 143 +++++++
 test/dm/Makefile                           |   1 +
 test/dm/rpmi.c                             |  69 +++
 27 files changed, 3055 insertions(+)
 create mode 100644 drivers/clk/clk_rpmi.c
 create mode 100644 drivers/firmware/rpmi/Kconfig
 create mode 100644 drivers/firmware/rpmi/Makefile
 create mode 100644 drivers/firmware/rpmi/rpmi-sandbox-clock.c
 create mode 100644 drivers/firmware/rpmi/rpmi-sandbox-power.c
 create mode 100644 drivers/firmware/rpmi/rpmi-sandbox.c
 create mode 100644 drivers/firmware/rpmi/rpmi-sandbox.h
 create mode 100644 drivers/firmware/rpmi/rpmi-sbi-mpxy.c
 create mode 100644 drivers/firmware/rpmi/rpmi-shmem.c
 create mode 100644 drivers/firmware/rpmi/rpmi-uclass.c
 create mode 100644 drivers/power/domain/rpmi-power-domain.c
 create mode 100644 include/rpmi-uclass.h
 create mode 100644 include/rpmi.h
 create mode 100644 include/rpmi_proto.h
 create mode 100644 test/dm/rpmi.c

-- 
2.47.3

