Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A09EE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE498036B;
	Sat, 11 Jan 2025 01:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aiLimcgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEFDA805E9; Sat, 11 Jan 2025 01:06:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C525A800D0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736554012; x=1737158812; i=xypron.glpk@gmx.de;
 bh=hPJ2eVtOgK99tOuUou8TrUE6qBPiGXjcmfmRqeHPKIs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aiLimcgKVsnx18YtRC+9KDJfH3nYXacOwfBKVYhriNSig++ybwX7v2zjW4pWoHK0
 xf56T6TEkznlERL2TtQDXYe7VwhNCnB1ewU5vFoBalkPTLuqvyVZFH/oG31/Wxdb7
 UH4Je8nyGQh3YPWbVk06sqc29DwAN+WnZ2uBDGWiicHzV5jjcXpe4YnsKuiG9O33k
 rw5nTDQ8bDBbc+jf5o0p/DhUzvpgcjshZSUOvb1wXd499uymKIm3KF4PXcF3SkrZa
 6fpwjtp1o8McuSi0Ml9XXtQsAxf9qkDjZjTw3Qs1tdWSSBph/Mm+klIcWL/duWN+L
 O3h1tZI7lHQZdr16CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1treGh2WK7-00YaWL; Sat, 11
 Jan 2025 01:06:52 +0100
Date: Sat, 11 Jan 2025 01:06:50 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: Re: [PATCH v4 2/3] tcg2: decouple eventlog size from efi
User-Agent: Thunderbird for Android
In-Reply-To: <20250110215640.892539-2-raymond.mao@linaro.org>
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <20250110215640.892539-2-raymond.mao@linaro.org>
Message-ID: <E578B5D7-5692-4989-B222-D11ABBFD8478@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RMy6Au34uuZ0VHQsXvu0DH5fbfyTQ1G3dcs/k4Q3FtwLsw0SFnf
 kG3ZOza0docvPA6XADUAK9rDwLLd1nwMg6DhHrBiPjekrQgNrzWXSadSeY2k47pvdr484uF
 KHzti5lUephpy7YK7kVeSvsVGn3ooMH+jHXsUwn45Z/rSfR11oYLViqLKafd/NmdAfdlc4+
 RHHGg5MDjMuX2e3QclfCw==
UI-OutboundReport: notjunk:1;M01:P0:nJEv2Awx41k=;0bn6doHtqpM3wfRlrbsBDh2iasn
 qn8Owzey4H6mzZU2g2fTcs3umuBUsO7s/X/NL9PbAsxHLYcCzplwXbPMciaPuQpLxdhaX+W7o
 CtNKt201kelEmmmMTF4uB0MjOMcdyynQgdZOE8AOkrlvdJMwA6AV4606dKSvBYM3HKeWdEqag
 1AKmqEWJyjrN9NI8CkNjLWOvfqcnoKD/8Y14fAyZyEtx6tlkO8S0lcHKMKXPnuPvmGWn8YEya
 fteqhtqkvklGSc9+4ahn2ga1D7fN0nEyQ2ssyyPEy69Z+5Oh4Jch1orOal53gNN3xbEsVMt6j
 /KDrgKLjLa5pzMnKPHMGJOr2Xcs4IrxaKvCj4+PSYxalseUHKWj1+c36zCTGmI6AbD87VQ0Hx
 jVdValUb08q23Y558z4C6JpZnjd2EvPpc1pACqjrPBEG6K2eCyc6MVaZKSIAxblz/OrJzCKaO
 SKo3qEMYjTsRpi49Kx+R1jDnOm9whDOpbFm//vxzg9dm3/TujBSswiSReFS5uTGWtpzh3tD/k
 BoK4uTdFPmNiwFAHmXawJp4gsvZ8VLGYWq8Zosq32P4eP1GV1lPVJJlszqIzBcItFAMdRYfEe
 OJFE7eD7Zgew51mUR/VU2E8PiTsZptuU8//oxoCrYppJuTQ6GksSjSQ/5lnDHhMoz5ChGgFQk
 uwtOtqL1FTltrGkp5e2+3aDeW7UWVXFxRj0xmW3hkIe6CnaXR82EwSaqMlEuHGkIdsTvI+3cr
 O45QwmeZQcWJk5vb0as1a4VhyBfHqIKaKVQGvEIEVHEnLwN4yPCQxnhuSvBXSNLYPHou/G4cJ
 O7C/5MKbPis2MsDZJwOT+bNCofgK5BOzEGnQwuiwasX1YyBcX5il5wWhVyxrP3JIb4o9yW3vu
 k0HZBg5QPcO0Yxh5jt6r3ZGtmIQ+zJAOMEUahN5sJAWuJf1xGPjzogipDRXgATFf9fb2vy/cO
 ApzHe5vk7g8DLqIW/X+LOlnhEDeR/n9b/ETlSnd7+jXmC3HbcJca0VGnBYYJG5BBY8Q2A00oZ
 BVf/+dKV/AsXtVIA8hq51uJWSNwQ7nwUHxgwQVsKmmQVhDYsudQ2a1XNMqEHE3SePKiDz/TOd
 26vLvv3lW032uc+DCMnqDS5C5vzuT+
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

Am 10=2E Januar 2025 22:56:34 MEZ schrieb Raymond Mao <raymond=2Emao@linaro=
=2Eorg>:
>Move default eventlog size from efi to tpm for using in both
>modules=2E
>
>Signed-off-by: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>---
>Changes in v4
>- Initial patch=2E
>
> include/efi_tcg2=2Eh | 2 --
> include/tpm_tcg2=2Eh | 2 ++
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/include/efi_tcg2=2Eh b/include/efi_tcg2=2Eh
>index 8dfb1bc952=2E=2E7ed8880991 100644
>--- a/include/efi_tcg2=2Eh
>+++ b/include/efi_tcg2=2Eh
>@@ -28,8 +28,6 @@
> #define EFI_TCG2_MAX_PCR_INDEX 23
> #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
>=20
>-#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE
>-
> typedef u32 efi_tcg_event_log_bitmap;
> typedef u32 efi_tcg_event_log_format;
> typedef u32 efi_tcg_event_algorithm_bitmap;
>diff --git a/include/tpm_tcg2=2Eh b/include/tpm_tcg2=2Eh
>index 6519004cc4=2E=2E25a31daf65 100644
>--- a/include/tpm_tcg2=2Eh
>+++ b/include/tpm_tcg2=2Eh
>@@ -65,6 +65,8 @@
> #define EFI_DTB_EVENT_STRING \
> 	"DTB DATA"
>=20

Please, provide Sphinx style documentation for defines=2E

>+#define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE

Why would we need such a define at all? Can't we directly use the CONFIG v=
alue?

Why should the CONFIG value remain in lib/efi_loader/Kconfig? I would not =
expect the log size in the non-EFI case to depend on the UEFI subsystem=2E

Best regards

Heinrich

>+
> /**
>  *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm informati=
on
>  *

