Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85F4D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 18:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5468421C;
	Thu,  8 Jan 2026 19:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JXBEaB0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38D28422D; Thu,  8 Jan 2026 19:05:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5444184198
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767895502; x=1768500302; i=xypron.glpk@gmx.de;
 bh=pcgS1z5BZfhCrHo1EGlhoZeDX7s58D0adUmz/PiZnnU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JXBEaB0muVDFTOryM+ISOfN2qCKWbqZncYLWCcl4ZueFU3I98mODWY4cuaOrDaKw
 EDYn88XMcu1vTXdkR3hdEzI65DsJ3puutAaGGW4zLqwyM88eZgOHQDrWWt5e7bEV8
 eyu9vpnIhF9zmbfb9+Ywyyi2AOoE+I0zOFMTMCFgl8l4bKPNt2ApKU2pQF2SPEpTt
 tM/l+8QUpvPT9dKzTtlYdbI3Hga8YXMKhHUf2Xq0DcV9UkaJJ5QAt/us1Gk8dwBbE
 iyna33senUzGqhDkPjVPS+EXCzWk5PzIeinCJLaCamR1q0nVL2puxSEoN3Lc/983s
 6cakTqIc/xstpURRag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.126] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1wHJgE1Fxo-00k9kt; Thu, 08
 Jan 2026 19:05:02 +0100
Message-ID: <589c8faf-bcdc-45bc-9d29-cf85409c7680@gmx.de>
Date: Thu, 8 Jan 2026 19:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] bootm: Do bootstage processing in bootm_final()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-6-simon.glass@canonical.com>
 <B1959B8B-8D25-499B-B1E8-02178F67A191@gmx.de>
 <CAFLszTi-gRmj2YtHfG2F3u0feNMcC1+h5hwAvNTYJ+xC1JQnJA@mail.gmail.com>
 <7E049032-1F4E-464A-801C-468C8A9AC67B@gmx.de>
 <CAFLszThUvfSqP3oMP6HPB4zyWch7WfGVtZag7EuhFMA2ZpNXdQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszThUvfSqP3oMP6HPB4zyWch7WfGVtZag7EuhFMA2ZpNXdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Atfe7289hG9LsVOKv8jYDE76qq0+MpOqVcSzs7aJnl5poroVyZi
 FPZ0T0kkhfPdGYqGR9oytbd8To2uOBe6HApfrX/bhUENK3qpbQYt4nyOPAPRCLq01ENmbjx
 A3WRUaozAG5FQyB62ShOWTrf9gVM82SxcNUsP7DqFKJ/aCnjp5hIa8YLp2Gn82KZyUFfz56
 7l5rGAWNxxBQrEi92/Y5A==
UI-OutboundReport: notjunk:1;M01:P0:3QiC3M6d1qc=;vELDU1fojDYHkkiP9vRJDmA/HHx
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

On 1/8/26 18:41, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Wed, 7 Jan 2026 at 12:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> Am 7. Januar 2026 20:02:39 MEZ schrieb Simon Glass <sjg@chromium.org>:
>>> Hi Heinrich,
>>>
>>> On Tue, 6 Jan 2026 at 20:58, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
>>>>
>>>> Am 7. Januar 2026 01:31:22 MEZ schrieb Simon Glass <sjg@chromium.org>=
:
>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>
>>>>> Mark kernel start before booting. If enabled, show a bootstage repor=
t.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>>>>> ---
>>>>>
>>>>> boot/bootm_final.c   | 6 ++++++
>>>>> test/boot/bootflow.c | 2 +-
>>>>> 2 files changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/boot/bootm_final.c b/boot/bootm_final.c
>>>>> index 71661334e11..dd7cac55f1e 100644
>>>>> --- a/boot/bootm_final.c
>>>>> +++ b/boot/bootm_final.c
>>>>> @@ -6,11 +6,17 @@
>>>>>   */
>>>>>
>>>>> #include <bootm.h>
>>>>> +#include <bootstage.h>
>>>>> #include <dm/root.h>
>>>>>
>>>>> void bootm_final(enum bootm_final_t flags)
>>>>> {
>>>>>        printf("\nStarting kernel ...\n\n");
>>>>
>>>> This noisy message makes no sense for EFI booting. The kernel in not =
started in ExitBootServices().
>>>
>>> Can you explain that a bit more? I believe that's exactly when the
>>> kernel starts.
>>>
>>>>
>>>> Operating systems like Ubuntu tend to boot the kernel with argument "=
quiet" for aesthetic reasons. We should not disrupt this.
>>>
>>> When I boot (with this patch) I see these messages on the serial conso=
le:
>>>>>>
>>> Scanning for bootflows in all bootdevs
>>> Seq  Method       State   Uclass    Part  E  Name                     =
 Filename
>>> ---  -----------  ------  --------  ----  -  ------------------------
>>> ----------------
>>> Scanning global bootmeth 'efi_mgr':
>>>   0  efi_mgr      ready   (none)       0     <NULL>
>>> ** Booting bootflow '<NULL>' with efi_mgr
>>>       try_load_entry() Booting: Label: Ubuntu Device path:
>>> /HD(1,GPT,eccaac1c-b634-441b-a788-ab0f959111af,0x800,0x165800)/\EFI\ub=
untu\shimx64.efi
>>
>> Here GRUB is running. If you don't see output, then because purposefull=
y it has been quieted.
>=20
> OK, so there is no problem, right?

To make it clear:

Once the EFI application is started firmware like U-Boot or EDK II=20
should not write any message to the video buffer or to the serial console.

Best regards

Heinrich

>=20
>>
>>>
>>> Starting kernel ...
>>
>> ExitBootServices is called in the middle of the Linux kernel EFI stub a=
nd not when entering the kernel.
>=20
> Oh I see. To my mind the kernel EFI stub is a bit like a bootloader
> tacked onto the front of Linux. Linux doesn't properly start until it
> has control of the machine and actually starts its init.
>=20
> So we definitely want to get bootstage output (for example) covering
> that period, otherwise there is a significant uncounted time between
> the EFI app starting and Linux starting.
>=20
> Regards,
> Simon
>=20
>>
>> Best regards
>>
>> Heinrich
>>
>>> <<<
>>>
>>> So it is not silent today. The last line is the new one. Every other
>>> boot method writes this line.
>>>
>>> However, the video display is silent once grub has finished and I just
>>> noticed that this patch draws some pixels on the display, as if the
>>> EFI display is set to a different mode from what U-Boot expects. I
>>> suppose this is understandable, as grub has run by then and has
>>> probably changed the mode.
>>>
>>> So I wonder what would be best here. We don't support dynamic video
>>> sizing right now and I don't feel the urge to implement it just for
>>> this. Perhaps with EFI we could disable the vidconsole when
>>> exit-boot-services is called, on the basis that we cannot deal with
>>> whatever has happened to the display in the interim?
>>>
>>> Regards,
>>> Simon
>>>
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>>
>>>>> +      bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel=
");
>>>>> +
>>>>> +      if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
>>>>> +              bootstage_report();
>>>>> +
>>>>>        dm_remove_devices_active();
>>>>> }
>>>>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>>>>> index a56435d053f..80adc074070 100644
>>>>> --- a/test/boot/bootflow.c
>>>>> +++ b/test/boot/bootflow.c
>>>>> @@ -1381,7 +1381,7 @@ static int bootflow_efi(struct unit_test_state=
 *uts)
>>>>>
>>>>>        /* TODO: Why the \r ? */
>>>>>        ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
>>>>> -      ut_assert_nextline("Exiting test app");
>>>>> +      ut_assert_skip_to_line("Exiting test app");
>>>>>        ut_assert_nextline("Boot failed (err=3D-14)");
>>>>>
>>>>>        ut_assert_console_end();
>>>>
>>>
>>> Regards,
>>> Simon
>>

