Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A63BFEC0F0
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 18:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF8B80517;
	Tue, 24 Mar 2026 19:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Q4/KtqEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C86EE807C0; Tue, 24 Mar 2026 19:22:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2DA80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 19:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774376508; x=1774981308; i=xypron.glpk@gmx.de;
 bh=A2sUXTLCGF3E/3GVj5GSjx1GKpNSYkF05BiQTJYTqYk=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Q4/KtqEoNC13vnH3w9aDYV8ib5R7/U+DyPm28E9hLHYWsEwpDdL/cNy6vtsoF5WO
 OdF934QSH1hnFPFQTKWPbAhwEY/LQSNbNIC1tw4AI6C1PfFWw33m1eJjWUYW+zWR5
 J/pPXb4EfFShNA0nA9Ov4dvBDemh5k3nXY8pw7Rkn0s0zCCAIOGraPTPFAAMIfAOd
 xIXVUydNCRWAzMeoxBX0vLV5uv2MkMSU8SnUSbyrfYJrOorN0XqkOPm2s0M1QzxKt
 SCAeD+2sJZi0VfCVCcDUk/3oB84hAD8MgylVBtOxfjqr9y+5MWHw6U6hPWMtRsVNP
 WYFfKvqMvWNxK5sRrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1vtTPi1aWI-00XVB7; Tue, 24
 Mar 2026 19:21:48 +0100
Date: Tue, 24 Mar 2026 19:21:44 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, sjg@chromium.org,
 mkorpershoek@kernel.org, jan.kiszka@siemens.com, paul.liu@linaro.org,
 j-humphreys@ti.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/2=5D_efi=5Floader=3A_make_EFI=5FH?=
 =?US-ASCII?Q?AVE=5FRUNTIME=5FRESET_a_user-selectable_option?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260324175913.92858-2-aswinm@qti.qualcomm.com>
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
 <20260324175913.92858-2-aswinm@qti.qualcomm.com>
Message-ID: <7C8B85DA-6439-41DF-A2CC-ED51BF42752D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OC9YFcasetvGXkcCZmdeUCUB61b5f8kBGopXmgQe+L1TVYksn6B
 G2z1eUalOCQEbvkLKy4E3Kmv1tZy/Ej5teJaOwtYbsYUQELOZtYEC/y0b7u2tHQxJwfhLYn
 n9GC+YEZlZVtQQWkN7iACaOWogIDiz+3BeeNwjLWkYdysDYdvp+xbdfxcrigse4qOwDoBp9
 l79bs8eV4xDLaA+71OdJA==
UI-OutboundReport: notjunk:1;M01:P0:VagwA4WtdyQ=;Af9gF/7R4ar6oEhLWzEKfUkw5Ij
 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
 kzzoJu9PySQcN4Q==
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

Am 24=2E M=C3=A4rz 2026 18:59:12 MEZ schrieb Aswin Murugan <aswin=2Emurugan=
@oss=2Equalcomm=2Ecom>:
>From: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>
>
>Expose EFI_HAVE_RUNTIME_RESET as a proper Kconfig boolean with a prompt
>so platforms can explicitly enable or disable advertising the EFI reset
>runtime service=2E
>
>The current PSCI-based EFI runtime reset implementation is always
>enabled whenever CONFIG_PSCI_RESET is selected, but it does not support
>passing the additional arguments required for specialized reset modes=2E
>As a result, reboot requests such as bootloader mode or EDL mode cannot
>be propagated correctly and instead fall back to a normal reboot=2E
>
>By making EFI_HAVE_RUNTIME_RESET user-configurable, platforms that
>depend on extended PSCI reset can now explicitly disable EFI runtime
>reset handling even when CONFIG_PSCI_RESET is enabled, ensuring
>that the kernel retains full control of advanced reboot paths=2E
>
>Default behavior for existing platforms remains unchanged=2E
>
>Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
> lib/efi_loader/Kconfig | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 13e44be1d06=2E=2E31d1c4fc257 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -100,8 +100,7 @@ config EFI_SET_TIME
> 	  can be used by an EFI application to adjust the real time clock=2E
>=20
> config EFI_HAVE_RUNTIME_RESET
>-	# bool "Reset runtime service is available"
>-	bool
>+	bool "Reset runtime service"
> 	default y
> 	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> 		   SANDBOX || SYSRESET_SBI || SYSRESET_X86

