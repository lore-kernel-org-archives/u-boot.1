Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD032C27C6E
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 08:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBDEB88113;
	Sun, 16 Jun 2024 10:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="at0DOrUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA28880C5; Sun, 16 Jun 2024 10:35:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A871B880F8
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 10:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718526938; x=1719131738; i=xypron.glpk@gmx.de;
 bh=2mYjKy0lfN3Sg0bLmw2sIAiokk/ljUy3LyFErS2q4gQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=at0DOrUCEeN1kfWUg3jE5R+dasUzI8883qHb8UInJi83C3Yf/kIUZOeim7c7cHp9
 ioB2XrGramSCQvE7z5/qZnbEIB6nUiSG3P87WvAFL/k57mnXMux6ahAbOtB8bNNh1
 EF68Tq+9ee1LPXHGo+LVuJwzsF9Fyi8hkXxiRIzE9PaUuuyDOuY1UuOfsqMyCLNot
 LXIdwaPPEc/HQBg7jRkeROwOPw7BpzXc1Jqo6xGZq0/QoMlV7kCm4aog9Yol8pvO2
 lqJkBL5rF6CPu/08I9GcvgtM526S3yTVBgbJPmkAVWT6BONZ0nMzmFKDfHZvDQJ2q
 97dUCGLu+QWbHjIl0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq6M-1sY6Jm2BuS-014mp2; Sun, 16
 Jun 2024 10:35:38 +0200
Message-ID: <df8b87cf-a7bf-4bc3-8c17-e3f655504f90@gmx.de>
Date: Sun, 16 Jun 2024 10:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: capsule: Improve capsule update porting to new boards
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Michal Simek <michal.simek@amd.com>, Wei Ming Chen
 <jj251510319013@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240607234358.1991568-1-j-humphreys@ti.com>
 <CAC_iWj+xOh2=xq23Jy1XudiNB_ruj1j9EqgtGdq4VGmLi9+mpQ@mail.gmail.com>
 <86o784is0u.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <86o784is0u.fsf@udb0321960.dhcp.ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cBB5nmjH9yIVbCtLHEU6DjQ6H9i0ETXOV/tLLtmtAlFzBis91PJ
 qFcu+8lGeUaG7bEtLED66AJhyECwvGO0xGEox+NWGlBtU7f/fuiE/wFkF2sAjNUQHofMqM4
 FFlQzM8ws4O86XXybq1LHNeVr8aiqvtlwkBkhIigeb2iMmzQuEwiYwMtKMXrnmX+KuTLPPw
 49kX1AbqHbPdBzUCX0QZA==
UI-OutboundReport: notjunk:1;M01:P0:/33eLUFtqbc=;oGWlXg+vAAyUH/s4hAOjrEmMhqd
 u0Tjqk56KyScr21yvFfCN5mYfgLE04rGyUltyt78oxd39tZ4ya8aJQ069LuLZV0MEHue5P3Xr
 DfeuGUxSIFkDVsP0EFIGWfjRV46X/3eTUWW56KvmkPds7ife9gW8BHEdHWH/UW96cFsYwGqB+
 eu9U3to4lgD6NfeGry4Mzrk2H0VCL5rr3Rpl60vLhnKVOR9Nw+bWWA4j4Zu4GOyvi4z6jZb7B
 6nLA3etean+4HhpmczUZFIhuti0scsrRSxY+dwTw2Wky1vsNkWFQEP5N8y20MRGNM8zXEEF6U
 kZaS//DG7WZ92oZAlg/4q9bYz89xeFvTxGT7ar2No//86DfDr86bDix4T+nwPvYYF6rfDCPy9
 2No4mOjfo0PAuaPX9hAWbAefoz/cCIM4KC3sS3/CfNUjHhypWWlMxQSFZ0XiFOwrQcOYHEdZG
 nKiZ/zhlnZs4sfxPbBFq8Xb47e8bmLwW4t23uONE0BEgc8Bd4iDaNgOZ3CFKdTuXLoWYjRr/V
 mshVmvCOtCXx0JG9NqsGYredlYN8aWshPYNqHeTejk7VvNsJZoB+pVjKQV+yDnB3UaOjdaaya
 sVXfE7205Z/LF+iaUvPEEahIVC+jCgo15l+7O4WVYAIx8YgHuUxFJzZWtXBjKLxO4NXODfZzT
 p5oWuICjKUFHcMtaiBcgS5JByUVKB2ECZRhbU43ImALfuTwInqNrk9FnzZOoCcZJwrbOtd2jJ
 KvZ3a5QMmUf7Age6nablW2QQpaVt0KXUas6vvkffV65rf4uvkC/e9Q4q+4n782ZdzstK+oif7
 STSRnE/XTwWUBvtIL4jn+7AvJcYu5F4P0rodSuX9NZ3EQ=
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

On 6/13/24 21:04, Jon Humphreys wrote:
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>
>> Hi Jon,
>>
>> On Sat, 8 Jun 2024 at 02:44, Jonathan Humphreys <j-humphreys@ti.com> wr=
ote:
>>>
>>> Add to the capsule update porting documentation that when capsule
>>> authentication is enabled (via EFI_CAPSULE_AUTHENTICATE), a public key
>>> certificate corresponding to the capsule signing key must be specified=
.
>>>
>>> Also add a config (EFI_CAPSULE_BOARD_INSECURE) that is set by default =
and
>>> causes a warning (info level) alerting a developer to consult this por=
ting
>>> section to ensure the capsule update capability is secure for the plat=
form.
>>> Once this section has been reviewed and confidence is established in t=
he
>>> security of the capsule update implementation for this board, deselect=
ing
>>> the EFI_CAPSULE_BOARD_INSECURE config will remove the warning.
>>>
>>> This config is to balance the desire to provide a reference implementa=
tion
>>> in upstream for capsule authentication but also provide some safeguard=
s
>>> to prevent developers from overlooking the need to properly secure the=
ir
>>> implementation.
>>>
>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>> ---
>>>   doc/develop/uefi/uefi.rst    | 30 +++++++++++++++++++++++-------
>>>   lib/efi_loader/Kconfig       | 13 +++++++++++++
>>>   lib/efi_loader/efi_capsule.c |  5 +++++
>>>   3 files changed, 41 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>>> index 985956ab85c..1c98c6e4ab4 100644
>>> --- a/doc/develop/uefi/uefi.rst
>>> +++ b/doc/develop/uefi/uefi.rst
>>> @@ -526,6 +526,7 @@ following command can be issued
>>>         --guid c1b629f1-ce0e-4894-82bf-f0a38387e630 \
>>>         optee.bin optee.capsule
>>>
>>> +.. _Enabling Capsule Authentication:
>>>
>>>   Enabling Capsule Authentication
>>>   *******************************
>>> @@ -631,17 +632,32 @@ where version.dtso looks like::
>>>   The properties of image-type-id and image-index must match the value
>>>   defined in the efi_fw_image array as image_type_id and image_index.
>>>
>>> -Porting Capsule Updates to new boards
>>> -*************************************
>>> +Porting Capsule Update to new boards
>>> +************************************
>>>
>>>   It is important, when using a reference board as a starting point fo=
r a custom
>>>   board, that certain steps are taken to properly support Capsule Upda=
tes.
>>>
>>> -Capsule GUIDs need to be unique for each firmware and board. That is,=
 if two
>>> -firmwares are built from the same source but result in different bina=
ries
>>> -because they are built for different boards, they should have differe=
nt GUIDs.
>>> -Therefore it is important when creating support for a new board, new =
GUIDs are
>>> -defined in the board's header file.  *DO NOT* reuse capsule GUIDs.
>>> +Capsule GUIDs need to be unique for each firmware and board. That is,=
 even
>>> +if two firmwares are built from the same source but result in differe=
nt
>>> +binaries because they are built for different boards, they should hav=
e
>>> +different GUIDs. Therefore it is important when creating support for =
a new
>>> +board, new GUIDs are defined in the board's header file. *DO NOT* reu=
se
>>> +capsule GUIDs.
>>> +
>>> +When capsule authentication is enabled (via EFI_CAPSULE_AUTHENTICATE)=
, it
>>> +is also very important to set the public key certificate correspondin=
g to
>>> +the capsule signing key. See :ref:`Enabling Capsule Authentication` f=
or
>>> +more information on signing capsules. *DO NOT* reuse the certificate =
file
>>> +from the reference board, which usually would be based on the develop=
ment
>>> +board keys.
>>> +
>>> +By default, the EFI_CAPSULE_BOARD_INSECURE config is set to true and =
causes
>>> +a warning (info level) alerting a developer to consult this section t=
o
>>> +ensure the capsule update capability is secure for the platform. Once=
 this
>>> +section has been reviewed and confidence is established in the securi=
ty of
>>> +the capsule update implementation for this board, deselecting
>>> +EFI_CAPSULE_BOARD_INSECURE config will remove the warning.
>>>
>>>   Executing the boot manager
>>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 23079a5709d..f4b1a20ee40 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -236,6 +236,19 @@ config EFI_CAPSULE_ON_DISK_EARLY
>>>            executed as part of U-Boot initialisation so that they will
>>>            surely take place whatever is set to distro_bootcmd.
>>>
>>> +config EFI_CAPSULE_BOARD_INSECURE
>>> +       bool "Permit insecure capsule-on-disk support"
>>> +       depends on EFI_HAVE_CAPSULE_SUPPORT
>>> +       default y
>>> +       help
>>> +         Permit insecure capsule update support and emit a warning (i=
nfo level)
>>> +         when applying capsule updates, indicating that the configura=
tion is
>>> +         insecure and including a link to the capsule update porting =
guide in
>>> +         U-Boot docs. Disabling this option removes the warning. A de=
veloper
>>> +         configuration doesn't need to be secure, but before making a=
 product
>>> +         from the configuration, the intent is to developers alert of=
 steps that
>>> +         must be taken.
>>> +
>>>   config EFI_CAPSULE_FIRMWARE
>>>          bool
>>>
>>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule=
.c
>>> index 0937800e588..76ade2809d9 100644
>>> --- a/lib/efi_loader/efi_capsule.c
>>> +++ b/lib/efi_loader/efi_capsule.c
>>> @@ -1329,6 +1329,11 @@ efi_status_t efi_launch_capsules(void)
>>>          if (!nfiles)
>>>                  return EFI_SUCCESS;
>>>
>>> +       if (IS_ENABLED(CONFIG_EFI_CAPSULE_BOARD_INSECURE)) {
>>> +               log_info("WARNING: EFI Capsules might be insecure!\n")=
;

For warnings we use log_warning().

A warning might be adequate if capsules signatures were not checked
(EFI_CAPSULE_AUTHENTICATE=3Dn). We don't need a new Kconfig symbol here.
Most users will not remark this message as it scrolls away when rebooting.

In some cases it might make sense to require a manual confirmation
before applying an unsigned capsule.

Please, consider that capsule authentication only provides extra
security if the same changes could not be done directly from the OS.

Why would you show the new messages on all existing boards supporting
capsule updates?

corstone1000_defconfig
imx8mm-cl-iot-gate-optee_defconfig
imx8mm-cl-iot-gate_defconfig
imx8mp_rsb3720a1_4G_defconfig
imx8mp_rsb3720a1_6G_defconfig
kontron-sl-mx8mm_defconfig
rock-4c-plus-rk3399_defconfig
rock-4se-rk3399_defconfig
rock-pi-4-rk3399_defconfig
rock-pi-4c-rk3399_defconfig
sandbox_defconfig
sandbox_flattree_defconfig
synquacer_developerbox_defconfig
xilinx_zynqmp_kria_defconfig
xilinx_zynqmp_virt_defconfig

>>> +               log_info("WARNING: Please check https://docs.u-boot.or=
g/en/latest/develop/uefi/uefi.html#porting-capsule-update-to-new-boards\n"=
);

We can expect a developer to know where to find documentation.

Best regards

Heinrich


>>> +       }
>>
>> I am fine with adding a warning on this, but why do we have to control
>> it via a Kconfig option? We can detect the capsule-key is missing from
>> the DT and print the same warning.
>
> Hi Ilias.
>
> The Kconfig option is not there to ensure a capsule key exists, but rath=
er
> to make sure a developer, that is porting uboot to their board and is
> starting from a reference board in upstream, doesn't continue using the
> development board dummy key and instead creates their own (private one).
>
> The Kconfig option is used to force a board developer to acknowledge the=
y
> have followed the board porting steps (which talks about creating your o=
wn
> key) with an explict action of disabling the config to remove the warnin=
g
> message.
>
> Hope that helps.
>
> Jon
>
>>
>> Regards
>> /Ilias
>>> +
>>>          /* Launch capsules */
>>>          for (i =3D 0, ++index; i < nfiles; i++, index++) {
>>>                  log_debug("Applying %ls\n", files[i]);
>>> --
>>> 2.34.1
>>>

