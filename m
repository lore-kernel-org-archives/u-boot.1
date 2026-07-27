Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FDBC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 065DC606F2;
	Mon, 27 Jul 2026 12:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5_5hHE7Sfq5; Mon, 27 Jul 2026 12:34:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AA94606D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785155699;
	bh=ENXcE+4GPhJjhSEMgGbfcW0uTibHYycoZfc8KWEreOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZC7ghRxd5KTsY1c5YXIn3Fsi/IY3jjjCbB3mcmqxmdM6jrDycF/7fpcHULTwNTNDj
	 7UOPngBv6FoeOnszUSpDXvi54Obuq4rctlc6ikPlbv5X/V8GTjrC8dqBAiMclTscpw
	 mj4Jn3y71dDGcmZqjBL+wwkhSSIu6HMytVxbET5HivqXE681/w/LrsvKOyJyBtbzxZ
	 fB7sPrvx+uJZNe1wcqmYCi7K3Jzgz/jzkATtJJLeA+YTx9+PjoE9Svm4YTFC0L/p7p
	 Z1CDEEygtWeHusga+22T0f+KlIahyFHKnbTCw+6OCny/QTqPgouu+KxwuqWeOWfDmv
	 9i+4oe4lBUxuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AA94606D9;
	Mon, 27 Jul 2026 12:34:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7245194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A86AB80CB8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krGfhwOOsm12 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:34:56 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 58DDE80C46
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58DDE80C46
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58DDE80C46
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:34:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AAF84671; Mon, 27 Jul 2026 14:34:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773B582991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 14:34:50 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1wiIw411DK-000t5L; Mon, 27
 Jul 2026 14:34:22 +0200
Message-ID: <18bd711a-90aa-4157-9bf0-bd2ded45a8de@gmx.de>
Date: Mon, 27 Jul 2026 14:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] efi: Implement EFI Security Architecture protocols
To: Ian Mullins <imullins@redhat.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Enric Balletbo Serra <eballetb@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Michal Simek <michal.simek@amd.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Udit Kumar <u-kumar1@ti.com>,
 Ard Biesheuvel <ardb@kernel.org>, u-boot@lists.denx.de,
 Lennart Poettering <lennart@poettering.net>
References: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rD4SMVlBmDUvZoxEXSptrctzJZe7Gc+DoN7xKakpBpLfAeeGEEv
 95+f15CMYsbMJvfnkRIFL7AMmXfnPwERGkliruQ0EkfdhHStW6PjVC5naARZGlUtj9RdXCB
 vaq+iZJ14b9HHznUj/tIQlxqhpQT6GpFbuG4wKlUjtQ20jnixmgv1MwinmX6X8pzvUaVdJa
 5FhkcUNReW4kWRL8r8L8Q==
UI-OutboundReport: notjunk:1;M01:P0:MboOtW9ajYk=;WcOTneoV9L8U0HCNWhbuR0mn7Du
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1785155662; x=1785760462; i=xypron.glpk@gmx.de;
 bh=ENXcE+4GPhJjhSEMgGbfcW0uTibHYycoZfc8KWEreOI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VNa2mkg9Zqg477InSsAJM1l2LpumJx8J9x7bhoHtAeZShwyzYR44NzNMeS3UgcYX
 wL/y0fkEn5y5frtPm2jz0oTqq8mRKC0zHFyQKihFqYniu5+FsF2e7lnPvsyhw+wRt
 zxlpUjTB4ro2s3wSHdTV4F6EKz9mQ0G3VIvvdCCQDab4OLU0NkvlKno7vSbXM2FVy
 Q2vcfFmswriGLjt/AfYzASiaOAPe+26tuzT9VoveNYNZFDB2jjDQhoW1mkRLclF3C
 sphbH6Sg0K1Xxc67ExJJzd1A59wUMSNQKqsH6pfNk69nbaUPtF5bGBquuBzGR6D9b
 UVvXqG3VbwdlvWGSlA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=VNa2mkg9
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=xypron.glpk@gmx.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VNa2mkg9"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/10/26 15:23, Ian Mullins wrote:
> This series implements the EFI_SECURITY_ARCH_PROTOCOL and
> EFI_SECURITY2_ARCH_PROTOCOL. The primary motivation is to support EFI
> applications like systemd-stub in Unified Kernel Images (UKI) so they
> can temporarily override authentication for embedded payloads.
>=20
> Note: This work was originally authored by Enric Balletbo i Serra.
> I am submitting it upstream on his behalf with additional testing.

Consumption of these protocols by EFI applications does not conform to=20
the UEFI specification.

Chapter 1.4 Goals has this sentence:

"On the other hand, firmware-internal interfaces, such as those defined=20
by the PI Specification, are produced and consumed by firmware only, and=
=20
are not considered interfaces that a UEFI aware OS can connect to,=20
interact with, or depend on."

Neither the PI nor the UEFI specification indicate that overwriting=20
pointers to the EFI_SECURITY_ARCH_PROTOCOL or=20
EFI_SECURITY2_ARCH_PROTOCOL at boot time shall influence which images=20
LoadImage() accepts. What systemd uses is undocumented behavior of EDK II.

The correct way forward is to fix systemd and Linux' EFI_ZBOOT stub to=20
make them comply with the UEFI specification.

See this mail by Lennart Poettering:
https://lists.freedesktop.org/archives/systemd-devel/2025-March/051313.htm=
l

Best regards

Heinrich

>=20
> ---
> Testing Performed
>=20
> I have validated these patches across various secure boot scenarios on
> both physical hardware and emulators to ensure the new overrides work
> without regressing standard secure boot enforcement.
>=20
> Hardware: Renesas R-Car S4 (EBBR UKI boot)
> - [PASS] Unsigned image, Secure Boot disabled, without patch
>    (Boots)
> - [PASS] Unsigned image, Secure Boot compiled (not enforcing),
>    without patch (Boots)
> - [PASS] Signed image, Secure Boot enforcing, without patch
>    (Fails to boot as expected)
> - [PASS] Signed image, Secure Boot enforcing, with patch
>    (Boots successfully)
> - [PASS] Signed image (wrong keys), Secure Boot enforcing, with patch
>    (Fails to boot as expected)
>=20
> Emulator: QEMU (qemu UKI boot)
> - [PASS] Unsigned image, Secure Boot disabled, without patch
>    (Boots)
> - [PASS] Unsigned image, Secure Boot enabled, without patch
>    (Boots)
> - [PASS] Signed image, Secure Boot enabled, without patch
>    (Fails to boot as expected)
> - [PASS] Signed image, Secure Boot enabled, with patch
>    (Boots successfully)
>=20
> Signed-off-by: Ian Mullins <imullins@redhat.com>
>=20
> ---
> Enric Balletbo i Serra (2):
>        efi_loader: implement EFI Security Architecture protocols
>        efi_selftest: add tests for security architecture protocols
>=20
>   include/efi_api.h                                  |  30 +++
>   include/efi_loader.h                               |  15 +-
>   lib/efi_loader/Kconfig                             |  11 ++
>   lib/efi_loader/Makefile                            |   1 +
>   lib/efi_loader/efi_boottime.c                      |   3 +-
>   lib/efi_loader/efi_image_loader.c                  |  31 ++-
>   lib/efi_loader/efi_security.c                      |  99 ++++++++++
>   lib/efi_loader/efi_setup.c                         |   7 +
>   lib/efi_selftest/Makefile                          |   1 +
>   lib/efi_selftest/efi_selftest_security_arch.c      | 110 +++++++++++
>   .../py/tests/test_efi_secboot/README.security_arch | 208 +++++++++++++=
++++++++
>   .../tests/test_efi_secboot/test_security_arch.py   |  73 ++++++++
>   12 files changed, 580 insertions(+), 9 deletions(-)
> ---
> base-commit: 913fedc816570c07bfc7f9c4046dc2a3a55e4099
> change-id: 20260710-efi_security_protocol-6b9fb0e8da41
>=20
> Best regards,

