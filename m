Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E59C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 19:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843D988954;
	Thu, 13 Jun 2024 21:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G3LsGKZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C2A88951; Thu, 13 Jun 2024 21:04:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9B8888BF
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 21:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DJ46Ai046576;
 Thu, 13 Jun 2024 14:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718305446;
 bh=0b0FnhopbhTTfBGMkR4Q3L8t1sLdl6BmZo431eNDKWE=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=G3LsGKZu8C/UOdjW9Ku+JeY6Z11pmmlDjYlkHfrlC31SiHr6TUsjMGY5OZctamYPm
 eReC1v9h4Mipx0Fp8fl8j7htjWb11OGQ9TAH+8D3VMZYjtDzymHDPTKF7AvqAiAUBj
 7/mUQM8Dd9+YDw3Q7RmZFI7kl8VngCg/5+zgz9pM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DJ46I5055842
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Jun 2024 14:04:06 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 14:04:06 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 13 Jun
 2024 14:04:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 14:04:01 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DJ41fo101604;
 Thu, 13 Jun 2024 14:04:01 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Michal Simek <michal.simek@amd.com>,
 "Wei Ming Chen" <jj251510319013@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Tom Rini
 <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] efi: capsule: Improve capsule update porting to new boards
In-Reply-To: <CAC_iWj+xOh2=xq23Jy1XudiNB_ruj1j9EqgtGdq4VGmLi9+mpQ@mail.gmail.com>
References: <20240607234358.1991568-1-j-humphreys@ti.com>
 <CAC_iWj+xOh2=xq23Jy1XudiNB_ruj1j9EqgtGdq4VGmLi9+mpQ@mail.gmail.com>
Date: Thu, 13 Jun 2024 14:04:01 -0500
Message-ID: <86o784is0u.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

> Hi Jon,
>
> On Sat, 8 Jun 2024 at 02:44, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>>
>> Add to the capsule update porting documentation that when capsule
>> authentication is enabled (via EFI_CAPSULE_AUTHENTICATE), a public key
>> certificate corresponding to the capsule signing key must be specified.
>>
>> Also add a config (EFI_CAPSULE_BOARD_INSECURE) that is set by default and
>> causes a warning (info level) alerting a developer to consult this porting
>> section to ensure the capsule update capability is secure for the platform.
>> Once this section has been reviewed and confidence is established in the
>> security of the capsule update implementation for this board, deselecting
>> the EFI_CAPSULE_BOARD_INSECURE config will remove the warning.
>>
>> This config is to balance the desire to provide a reference implementation
>> in upstream for capsule authentication but also provide some safeguards
>> to prevent developers from overlooking the need to properly secure their
>> implementation.
>>
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>  doc/develop/uefi/uefi.rst    | 30 +++++++++++++++++++++++-------
>>  lib/efi_loader/Kconfig       | 13 +++++++++++++
>>  lib/efi_loader/efi_capsule.c |  5 +++++
>>  3 files changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>> index 985956ab85c..1c98c6e4ab4 100644
>> --- a/doc/develop/uefi/uefi.rst
>> +++ b/doc/develop/uefi/uefi.rst
>> @@ -526,6 +526,7 @@ following command can be issued
>>        --guid c1b629f1-ce0e-4894-82bf-f0a38387e630 \
>>        optee.bin optee.capsule
>>
>> +.. _Enabling Capsule Authentication:
>>
>>  Enabling Capsule Authentication
>>  *******************************
>> @@ -631,17 +632,32 @@ where version.dtso looks like::
>>  The properties of image-type-id and image-index must match the value
>>  defined in the efi_fw_image array as image_type_id and image_index.
>>
>> -Porting Capsule Updates to new boards
>> -*************************************
>> +Porting Capsule Update to new boards
>> +************************************
>>
>>  It is important, when using a reference board as a starting point for a custom
>>  board, that certain steps are taken to properly support Capsule Updates.
>>
>> -Capsule GUIDs need to be unique for each firmware and board. That is, if two
>> -firmwares are built from the same source but result in different binaries
>> -because they are built for different boards, they should have different GUIDs.
>> -Therefore it is important when creating support for a new board, new GUIDs are
>> -defined in the board's header file.  *DO NOT* reuse capsule GUIDs.
>> +Capsule GUIDs need to be unique for each firmware and board. That is, even
>> +if two firmwares are built from the same source but result in different
>> +binaries because they are built for different boards, they should have
>> +different GUIDs. Therefore it is important when creating support for a new
>> +board, new GUIDs are defined in the board's header file. *DO NOT* reuse
>> +capsule GUIDs.
>> +
>> +When capsule authentication is enabled (via EFI_CAPSULE_AUTHENTICATE), it
>> +is also very important to set the public key certificate corresponding to
>> +the capsule signing key. See :ref:`Enabling Capsule Authentication` for
>> +more information on signing capsules. *DO NOT* reuse the certificate file
>> +from the reference board, which usually would be based on the development
>> +board keys.
>> +
>> +By default, the EFI_CAPSULE_BOARD_INSECURE config is set to true and causes
>> +a warning (info level) alerting a developer to consult this section to
>> +ensure the capsule update capability is secure for the platform. Once this
>> +section has been reviewed and confidence is established in the security of
>> +the capsule update implementation for this board, deselecting
>> +EFI_CAPSULE_BOARD_INSECURE config will remove the warning.
>>
>>  Executing the boot manager
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 23079a5709d..f4b1a20ee40 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -236,6 +236,19 @@ config EFI_CAPSULE_ON_DISK_EARLY
>>           executed as part of U-Boot initialisation so that they will
>>           surely take place whatever is set to distro_bootcmd.
>>
>> +config EFI_CAPSULE_BOARD_INSECURE
>> +       bool "Permit insecure capsule-on-disk support"
>> +       depends on EFI_HAVE_CAPSULE_SUPPORT
>> +       default y
>> +       help
>> +         Permit insecure capsule update support and emit a warning (info level)
>> +         when applying capsule updates, indicating that the configuration is
>> +         insecure and including a link to the capsule update porting guide in
>> +         U-Boot docs. Disabling this option removes the warning. A developer
>> +         configuration doesn't need to be secure, but before making a product
>> +         from the configuration, the intent is to developers alert of steps that
>> +         must be taken.
>> +
>>  config EFI_CAPSULE_FIRMWARE
>>         bool
>>
>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
>> index 0937800e588..76ade2809d9 100644
>> --- a/lib/efi_loader/efi_capsule.c
>> +++ b/lib/efi_loader/efi_capsule.c
>> @@ -1329,6 +1329,11 @@ efi_status_t efi_launch_capsules(void)
>>         if (!nfiles)
>>                 return EFI_SUCCESS;
>>
>> +       if (IS_ENABLED(CONFIG_EFI_CAPSULE_BOARD_INSECURE)) {
>> +               log_info("WARNING: EFI Capsules might be insecure!\n");
>> +               log_info("WARNING: Please check https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#porting-capsule-update-to-new-boards\n");
>> +       }
>
> I am fine with adding a warning on this, but why do we have to control
> it via a Kconfig option? We can detect the capsule-key is missing from
> the DT and print the same warning.

Hi Ilias.

The Kconfig option is not there to ensure a capsule key exists, but rather
to make sure a developer, that is porting uboot to their board and is
starting from a reference board in upstream, doesn't continue using the
development board dummy key and instead creates their own (private one).

The Kconfig option is used to force a board developer to acknowledge they
have followed the board porting steps (which talks about creating your own
key) with an explict action of disabling the config to remove the warning
message.

Hope that helps.

Jon

>
> Regards
> /Ilias
>> +
>>         /* Launch capsules */
>>         for (i = 0, ++index; i < nfiles; i++, index++) {
>>                 log_debug("Applying %ls\n", files[i]);
>> --
>> 2.34.1
>>
