Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA83C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 09:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97ED78318E;
	Tue,  8 Jul 2025 11:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G/Bv1UFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0CE783238; Tue,  8 Jul 2025 11:55:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBF783145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 11:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751968510; x=1752573310; i=xypron.glpk@gmx.de;
 bh=6SNf4qtGXMksyL1qawtnnu2nfe+61Kx97ZmM5UNkxfs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=G/Bv1UFPR4QITF0QGwl5b44CSW+Xelw+OM4hkwK9v+eHk3c2InKa8EQmF6LhaNEJ
 XJjBu8oJ0K04pwvEZplIOd7wzX/M4ivLC7QnvydMEsDN0vKxhomzpGIARyXaJTj85
 +NiVDOeK15b2E7HBjC/VS8ubzehnYQQpL/8JfwurTxcSfHL9CmLycPz571IZ3S7U9
 WVmC1jzvRtArgoUlku95jOM9yGWTP9K07ZOZFt7MUw+T1qqXTHMy3JQdeJ0WJ4sdA
 iyU2z7X3cbB0WFPZcZbMEXEVlgyOxDmUXaQTsVXVslSQ57/AhE7eDdhWHSYfaRze8
 zotGYKEk8lfRlOxPhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1v5voj3cOu-00lL2r; Tue, 08
 Jul 2025 11:55:09 +0200
Message-ID: <7649c35e-255b-4e9f-b859-a84d55d0b30c@gmx.de>
Date: Tue, 8 Jul 2025 11:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi: turn on EFI_DEBUG_SUPPORT for qemu arm and arm64
 target
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250707095322.30222-1-paulliu@debian.org>
 <20250707095322.30222-2-paulliu@debian.org>
 <8AF80705-BB09-4AAD-8604-3D967295AB30@gmx.de>
 <CAC_iWjLL2jZ6m6FWFSyiWdr+BExuj7rEJ7CMLQ5CDbDgpJKYew@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLL2jZ6m6FWFSyiWdr+BExuj7rEJ7CMLQ5CDbDgpJKYew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:knA9g4q3YbCRCZihRZtjbs/ksxxH9MiKBAY06MQ6RoXeaKEBhlc
 WF/KHn+HIz/eReG+HJkychPHc+h2l2wv40xsh/PKhIKIuS2GtornUGTCRoV23J4zXKECt9h
 OXnK4HYAUsnkwS5BlznjSsvw4aW4Xu/pZ+mmt2tCflRDbSppjvdPHs+p+HtcK1MWsvcPDob
 ukVyrBIjw7niNijloIopg==
UI-OutboundReport: notjunk:1;M01:P0:jFHdYAYi6rE=;8uS6Kng49lmzzuNRq58HRK+Blqo
 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
 n4SzD+QBu1bYtz1ii6QwHZU=
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

On 08.07.25 09:36, Ilias Apalodimas wrote:
> Hi Heinrich
>=20
> On Tue, 8 Jul 2025 at 06:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> Am 7. Juli 2025 11:53:22 MESZ schrieb "Ying-Chun Liu (PaulLiu)" <paulli=
u@debian.org>:
>>> Previously, EFI_DEBUG_SUPPORT was enabled across all platforms for
>>> CI build testing. With this commit, we are limiting its activation
>>> to qemu_arm64_defconfig and qemu_arm_defconfig only, which is
>>> sufficient for our current needs.
>>
>> Was there a request to turn it off on other platforms?
>=20
> I asked Paul to send this, because it grows the binary size a bit.
> Since it a debug protocol, I thought we could only enable it for QEMU
> to test it.
> If you want that on for risc-v we can turn it on for QEMU as well?

The protocol is typically needed when things fail on real hardware.=20
Having to reflash U-Boot may not be desired especially if the U-Boot=20
binary is signed. Isn't !HAS_BOARD_SIZE_LIMIT is enough of a safeguard=20
for now?

Best regards

Heinrich

>=20
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich
>>
>>
>>>
>>> Signed-off-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> ---
>>> configs/qemu_arm64_defconfig | 1 +
>>> configs/qemu_arm_defconfig   | 1 +
>>> lib/efi_loader/Kconfig       | 1 -
>>> 3 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconf=
ig
>>> index 39afb837e41..54bf4646382 100644
>>> --- a/configs/qemu_arm64_defconfig
>>> +++ b/configs/qemu_arm64_defconfig
>>> @@ -15,6 +15,7 @@ CONFIG_ENV_ADDR=3D0x4000000
>>> CONFIG_PCI=3Dy
>>> CONFIG_DEBUG_UART=3Dy
>>> CONFIG_AHCI=3Dy
>>> +CONFIG_EFI_DEBUG_SUPPORT=3Dy
>>> CONFIG_EFI_HTTP_BOOT=3Dy
>>> CONFIG_FIT=3Dy
>>> CONFIG_FIT_SIGNATURE=3Dy
>>> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
>>> index 92ba48f6af9..b1c277a86c0 100644
>>> --- a/configs/qemu_arm_defconfig
>>> +++ b/configs/qemu_arm_defconfig
>>> @@ -18,6 +18,7 @@ CONFIG_ENV_ADDR=3D0x4000000
>>> CONFIG_PCI=3Dy
>>> CONFIG_DEBUG_UART=3Dy
>>> CONFIG_AHCI=3Dy
>>> +CONFIG_EFI_DEBUG_SUPPORT=3Dy
>>> CONFIG_FIT=3Dy
>>> CONFIG_FIT_SIGNATURE=3Dy
>>> CONFIG_FIT_VERBOSE=3Dy
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 077466f01f0..fdabe9cc278 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -73,7 +73,6 @@ config EFI_SIGNATURE_SUPPORT
>>>
>>> config EFI_DEBUG_SUPPORT
>>>        bool "EFI Debug Support"
>>> -      default y if !HAS_BOARD_SIZE_LIMIT
>>>        help
>>>          Select this option if you want to setup the EFI Debug Support
>>>          Table and the EFI_SYSTEM_TABLE_POINTER which is used by the d=
ebug
>>

