Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDD91061B1C
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 19:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD6783DBF;
	Mon, 30 Mar 2026 21:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HUsHEwjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695E383F5B; Mon, 30 Mar 2026 21:14:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1348352B
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 21:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774898061; x=1775502861; i=xypron.glpk@gmx.de;
 bh=WjbQG/xQ8BRt2+528hgS8JBiI4uaxpPDrg5Tj1M7Apg=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HUsHEwjzwCViWF7SrTb+4mNhKu/L9bMfmJCAiyTGPp7ndmdJnTmSidYTdVElE/Kj
 TzAbtYB1Y29zXgsFHWh8oHd1a5dhN4tMVNHvNaixcA5spgw+ZhOTMUNxs4ATQOc3E
 jygP679AYrXjkhMwhXj6cOJ3aNg0CC29E/nRHAIjNd0ePaTe2MmLkbIjA3nt5wfcX
 aWMubgSDMfOBb8FBy6U4aLqXb4ZX6yDigg8B/VgJ4524PwozYJHvc3HagWzueMMjT
 5XgK/1XIKaEsJhTHkaE2qPab6Cdmhg5FSSSoEsssj4e2tscOZYlXIZ6Gx9h9tyUNO
 BqsDncmiMvPV+m4bQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1vU5es3c62-013ZeF; Mon, 30
 Mar 2026 21:14:21 +0200
Date: Mon, 30 Mar 2026 21:14:17 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 seanga2@gmail.com, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org,
 gchan9527@gmail.com, mkorpershoek@kernel.org, hs@nabladev.com,
 marek.vasut+renesas@mailbox.org, msp@baylibre.com, dinesh.maniyam@altera.com, 
 peng.fan@nxp.com, quentin.schulz@cherry.de, kever.yang@rock-chips.com,
 jamie.gibbons@microchip.com, justin@tidylabs.net, n-francis@ti.com,
 h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_0/7=5D_qcom=3A_Add_NVMEM_bitf?=
 =?UTF-8?Q?ield_support_and_reboot=E2=80=91mode_integration?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
Message-ID: <D0D68612-F412-46C8-90DF-D33A6C655401@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nq/S4Er+kdfzLBjdxi7Nfh3ERe1ZGmVu7mFLqJ/i3VL/ZI5wbU3
 VLHjcHfGyWohe8mNfFDxAGeC1Fm2vja7+Zqn/OQ48n1RNL4siP2olHji1X7u3RMQ+IjTzyR
 2rH/Q0gnEe8TS1GpgGL8K24GUTWSc7FxYAIgNChx2FRPibOnWYuw/21KfhP/qGOMuPhcqvC
 KsiIsnwwViBpHeasECJ0g==
UI-OutboundReport: notjunk:1;M01:P0:Ke5acvp7DWI=;IMtQJqokhe/FlWr844yaNHPMPwG
 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
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

Am 30=2E M=C3=A4rz 2026 19:14:12 MESZ schrieb Aswin Murugan <aswin=2Emuruga=
n@oss=2Equalcomm=2Ecom>:
>This patch series introduces bit-level granularity to NVMEM cells and
>adds complete reboot-mode support for Qualcomm platforms that store
>reboot reasons in PMIC registers=2E
>
>Qualcomm SoCs rely on PMIC-backed reboot reason storage to implement
>features like "reboot bootloader" for entering fastboot mode=2E However,
>these PMIC registers often pack multiple fields into a single byte,
>requiring fine-grained bit access that the current NVMEM subsystem does
>not support=2E
>
>In addition, PMIC generations differ in how reboot-related data is
>stored: older PMICs use PON (Power On) registers, while newer ones
>provide SDAM regions=2E This series introduces a unified, NVMEM-based
>approach that works seamlessly across both architectures=2E
>
>This version also integrates reboot-mode handling into Qualcomm board
>initialization, enabling automatic fastboot entry when the reboot reason
>indicates bootloader mode=2E
>
>Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>

It is unclear to me how endianness is handled in bitfields=2E Do you assum=
e low-endianness or do you consider the system endianness? Please, ensure t=
hat the tests are executed on both low- and big-endian systems=2E

Best regards

Heinrich


>
>---
>Changes in v3:
>1=2E Simplified bit field handling to maximum u32 size (32 bits)=2E
>2=2E Enforced strict size matching (size =3D=3D cell->size) when nbits =
=3D=3D 0=2E
>3=2E Enhanced test function for NVMEM read & write
>4=2E Updated NVMEM API documentation
>
>Link to V2:
>https://lore=2Ekernel=2Eorg/all/20260213112717=2E1256823-1-aswin=2Emuruga=
n@oss=2Equalcomm=2Ecom/
>
>Changes in v2:
>1=2E Replaced custom reboot reason handling with the standard U-Boot
>   reboot-mode subsystem, per review feedback=2E
>2=2E Added bit-field support to the NVMEM core using the new "bits"
>   property=2E
>3=2E Introduced the Qualcomm SPMI SDAM driver for unified PMIC storage
>   access=2E
>4=2E Updated the reboot-mode driver to support variable-sized NVMEM cells=
=2E
>5=2E Added device tree configuration for the QCS615 RIDE board=2E
>6=2E Enabled reboot-mode in qcom_defconfig=2E
>7=2E Integrated reboot-mode detection into Snapdragon board
>   initialization:
>   - Added qcom_handle_reboot_mode() in board_late_init() to enable
>     automatic fastboot entry on "reboot bootloader"=2E
>
>Link to v1:
>https://lore=2Ekernel=2Eorg/all/20260108065533=2E1143179-1-aswin=2Emuruga=
n@oss=2Equalcomm=2Ecom/
>---
>
>
>Aswin Murugan (7):
>  misc: Add support for bit fields in NVMEM cells
>  misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
>  mach-snapdragon: Integrate reboot-mode handling
>  dts: qcs615-ride-u-boot=2Edtsi: Add reboot-mode support
>  qcom_defconfig: Enable reboot-mode support in qcom_defconfig
>  test: dm: add comprehensive tests for NVMEM bit field operations
>  misc: update API documentation for bit field support in NVMEM
>
> arch/arm/dts/qcs615-ride-u-boot=2Edtsi |  26 ++++
> arch/arm/mach-snapdragon/board=2Ec     |  56 ++++++--
> arch/sandbox/dts/test=2Edts            |  12 ++
> configs/qcom_defconfig               |   3 +
> drivers/misc/Kconfig                 |   8 ++
> drivers/misc/Makefile                |   1 +
> drivers/misc/nvmem=2Ec                 | 159 ++++++++++++++++++---
> drivers/misc/qcom-spmi-sdam=2Ec        | 200 +++++++++++++++++++++++++++
> include/nvmem=2Eh                      |  28 +++-
> test/dm/reboot-mode=2Ec                | 137 ++++++++++++++++++
> 10 files changed, 595 insertions(+), 35 deletions(-)
> create mode 100644 drivers/misc/qcom-spmi-sdam=2Ec
>

