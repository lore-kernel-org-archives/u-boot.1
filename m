Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA7AFEC0F2
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 18:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5B680517;
	Tue, 24 Mar 2026 19:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WnDQ5bN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBCD8352B; Tue, 24 Mar 2026 19:22:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D59180087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 19:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774376576; x=1774981376; i=xypron.glpk@gmx.de;
 bh=tBBAmzkP0XnoAK7ubXpd3fmTsEY++H7IouSqGDdLExI=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WnDQ5bN1DOUkBf3LcpvkLc7ND7EdySMvpSP1ns+/dvLYIfqBbbsUTpubK+ZEjKD7
 0O8fRXK7udBgYWmlrrjjJATMep+jN6qgyC27ebKCbhLNwlf5h+XoMPSRbYyXWiBsg
 07pc2dFjMMulModQ/D16yP5YgDLriZxFGvFVuLJlSCqcNUbeY0uFeUjSetodnDQ2j
 XA7Xe9AMjPOvun9A4xNqv2keliLexDLQxVXNuzvITZEVJgerjCbAxzI7a5E01zwFp
 BNG6kCPuxGsT8m5Kq9jDs0razVlMoItEHNVaBemAnY/D+NYtCUPFVcq2rWyWWh09p
 dXjBuMTDhTBLBsMBYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1vEdwH3m4c-015h72; Tue, 24
 Mar 2026 19:22:56 +0100
Date: Tue, 24 Mar 2026 19:22:52 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, sjg@chromium.org,
 mkorpershoek@kernel.org, jan.kiszka@siemens.com, paul.liu@linaro.org,
 j-humphreys@ti.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_2/2=5D_qcom=5Fdefconfig=3A_Disabl?=
 =?US-ASCII?Q?e_EFI=5FHAVE=5FRUNTIME=5FRESET_in_qcom=5Fdefconfig?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260324175913.92858-3-aswinm@qti.qualcomm.com>
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
 <20260324175913.92858-3-aswinm@qti.qualcomm.com>
Message-ID: <3C912C2E-EAFC-4F15-81B0-2DBB60C607C4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1j7+juIF9+fYBsXUTIhvc56fOsFALbk8/3frHpvEUeWNLVY/EfC
 Q9CDmYF54n/fHxk05vchfAoNGVQ2WYmOdiDMQRJ7CmEQRAusw3RyTNNB6i2aoFTItvkVltQ
 AJnUQD5A8vaMhhBM+UrQcw6pJt86YD0t6+uoShL5Ev5I2G2SLnE9GMwixVLLV4r/+9CI8iL
 9hPaWjaIuJK2wbHeEYz2g==
UI-OutboundReport: notjunk:1;M01:P0:a2/+kqp9Ar0=;RObub9/0Dobv5KV14qGofMErpGc
 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
 OndAufyOKenMlHpmZ1c/PkT88X8Sn1KlFsos=
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

Am 24=2E M=C3=A4rz 2026 18:59:13 MEZ schrieb Aswin Murugan <aswin=2Emurugan=
@oss=2Equalcomm=2Ecom>:
>From: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>
>
>Qualcomm platforms rely on the kernel to manage specialized reboot modes
>such as EDL, bootloader entry, and other vendor-specific reset flows=2E
>Allowing U-Boot to override these via EFI runtime reset services leads to
>incorrect behavior when the kernel issues advanced reboot requests=2E
>
>Now that EFI_HAVE_RUNTIME_RESET is exposed as a user-configurable Kconfig
>option, disable it for qcom_defconfig so that the kernel retains full
>control over reboot handling on Qualcomm SoCs=2E
>
>This ensures that EFI runtime reboot callbacks are not registered on
>these platforms, preventing conflicts with kernel-managed PSCI reset
>paths=2E
>
>Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
> configs/qcom_defconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>index 314fc0c4903=2E=2E8042855bae1 100644
>--- a/configs/qcom_defconfig
>+++ b/configs/qcom_defconfig
>@@ -6,6 +6,7 @@ CONFIG_ARCH_SNAPDRAGON=3Dy
> CONFIG_NR_DRAM_BANKS=3D24
> CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sdm845-db845c"
> CONFIG_SYS_LOAD_ADDR=3D0xA0000000
>+# CONFIG_EFI_HAVE_RUNTIME_RESET is not set
> CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=3Dy
> CONFIG_EFI_CAPSULE_ON_DISK=3Dy
> CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy

