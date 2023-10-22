Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F218CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 22:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF3D877F4;
	Mon, 23 Oct 2023 00:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uKNwDKjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92377874DB; Mon, 23 Oct 2023 00:55:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BF5877EA
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698015330; x=1698620130; i=xypron.glpk@gmx.de;
 bh=vkjRYFP4cIw11K+7hZD2bwvnyDRka34kvCeMf0XD1IA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=uKNwDKjScXTvPZGbypdRcRJKs5ZH/aOFQ2/shBuA/fmLrTIhTpnXKLXsjzCERyYI
 3qY/nlGDFWk69EhLa61Vy2eajE9JsZ+npL+ovn4kzMLdofaUKtCfBoFhwpCcHZMlh
 g5vwFa1PHxdu44nYN/eUHDgLYmtDWI4iFD4rD3G6RT6YleZ9tC7TOBZ7+w2TlH0eb
 EHI4F9H4LNHYO3GBK13GGLDEh2eVwsw3mKAqHMWj4zKe+zAguZ7xqSaK1DLsDrVpN
 fpruvB0NfgdzZtWjRk45Ksgajyd/uMXzO44Y5+VxUiAUp0LNV4rpwusk80BVdJgIR
 BvBl6VoHqpgcwM7PeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1qrgp43RJn-008c7V; Mon, 23
 Oct 2023 00:55:29 +0200
Message-ID: <3b87bf3f-a909-4020-8d67-ace84c7ca90c@gmx.de>
Date: Mon, 23 Oct 2023 00:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat> <20231022145857.GB496310@bill-the-cat>
 <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cq2bpQBzAbhgwUVAfN9IaI2IXFM7/yn+nBlgsVi/Nj7a6jkvRpA
 WoYFtPqWSxq1YsHjML2FF3hNRYTlXaFAa4HwVS1TpFtJ1k6ZBP/bQghqaL0jV24uFJykKfo
 3cHLbrXnM+hd9k9zU0DdOmpWOcoKOSCg9hLv/6FfNRlNoTPgmvmQVGPxmsDi3j/8FF0ReLQ
 NBdjDToldhX7rhdwtx80w==
UI-OutboundReport: notjunk:1;M01:P0:9oZFNN+Z5Ts=;VEr0WfvMSlsVVzLNObCRrD83Y7E
 WuQaisChY3jNag6C5+Fxu2000RPek59lLIXKdsUl4ohagrMvEwHQPBQ+5uFnJ7ocsjZyX18ws
 RA4AFlHFvTV/QPlyoyaku0bbQr6ud+k6GwhRQMK6SGORzV9sXjfY7d/6iSz/Ww+/Mwa5kq34t
 f/FwKyr+1R76V0rV+D9SBDd+Z38h3Mitiv2wsWzQBYCdc7Z9FdnworiD0RyfwMkLT6xUKUTfT
 le84IHAgFw/aASBKMktgifZllk+jS1K7AvmrOKGPfialjQRU60UgJGbkstt4wy6zMG7pWmfJS
 8Kq7jlkX6Ea6Lh+BoS7Ky/w84HXgTtoh9ED2QkLN/EnQY2hoFwNVp6tPgfyE6AcaC0n0JMt9G
 76iIDjkPWB6CDrgbiLd/fVHdHnMuQOoT8xwi3N0kk++2oR4WFTVpeWM2rWD8QPIqFr2XiOxRi
 xRFkDX3lUKsEtBLhQ2PwMbIJx2qpy0uQvyBf8dGKeu/yyI6Whb7Mj6cEKWWHdYbKBuay4Z9cG
 i+WSCsvCnPgbqJQp0mLVmHRWdRy2f9tIWAqRt62KFn/zAkLLKOGG5B+sXNk1GDNCPLKuiojdc
 NnYjRzpD5cftI423MJZQ6qEoUbl1Nl9upWg3QAq6pzBZ8QdEckzQzB+Z/B0D5nc2sMs3bsQ/L
 rMULhogzpF1mC9ojrHNcqq6WPXlV68LBVs1T5zsdVfjhfxiHB12hd7yXofUFhT5znm7whBpbR
 Ahto/YGOgyuQZeSrulTv1CJP+ZGFSALAqPukL5ekpDrfwyAVuYnH0/6MmksfKymULCOXoVKu/
 ANw7+F4OgzeL8SYgtUtN6yQkWCykfhbkLl7lXQjjZ8diFifldH2nEAK4EXnhQ8hgyqabpf1No
 5C4BXt12WUClGnZvuHxVjWzHIpKG5eDsWdXtey56rth9dxLb3rcn6rXyHF60P+NMH9BAu+CSW
 HZiaIqgIoLYEeyLXZ+v8ZSDWejM=
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

On 10/22/23 23:55, Simon Glass wrote:
> Hi,
>
> On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
>>> On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
>>>> On 10/21/23 20:26, Tom Rini wrote:
>>>>> On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
>>>>>> <takahiro.akashi@linaro.org> wrote:
>>>>>>>
>>>>>>> On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
>>>>>>>> Hi Heinrich,
>>>>>>>>
>>>>>>>> On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>>>>>>>>>
>>>>>>>>> On 10/17/23 16:09, Tom Rini wrote:
>>>>>>>>>> On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
>>>>>>>>>>
>>>>>>>>>>> Since efi_device_path.c calls eth_get_dev() and assumes that E=
thernet is
>>>>>>>>>>> available, add it as an explicit dependency.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>> (no changes since v2)
>>>>>>>>>>>
>>>>>>>>>>> Changes in v2:
>>>>>>>>>>> - Add new patch to update EFI_LOADER to depend on DM_ETH
>>>>>>>>>>>
>>>>>>>>>>>     lib/efi_loader/Kconfig | 1 +
>>>>>>>>>>>     1 file changed, 1 insertion(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>>>>>>>>> index 13cad6342c36..fca4b3eef270 100644
>>>>>>>>>>> --- a/lib/efi_loader/Kconfig
>>>>>>>>>>> +++ b/lib/efi_loader/Kconfig
>>>>>>>>>>> @@ -11,6 +11,7 @@ config EFI_LOADER
>>>>>>>>>>>        # We need EFI_STUB_32BIT to be set on x86_32 with EFI_S=
TUB
>>>>>>>>>>>        depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BI=
T
>>>>>>>>>>>        depends on BLK
>>>>>>>>>>> +    depends on DM_ETH
>>>>>>>>>>>        depends on !EFI_APP
>>>>>>>>>>>        default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D a=
rmv8
>>>>>>>>>>>        select CHARSET
>>>>>>>>>>
>>>>>>>>>> Does this work for you Heinrich, or do you want to clarify the
>>>>>>>>>> dependencies (and re-organize the code as needed) around networ=
king?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> We should be able to boot via EFI on devices without U-Boot netw=
ork support.
>>>>>>>>>
>>>>>>>>> We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
>>>>>>>>> eth_get_dev() if there is no network. CONFIG_NETDEVICES=3Dy sele=
cts
>>>>>>>>> CONFIG_DM_ETH.
>>>>>>>>>
>>>>>>>>> Why is this not sufficient?
>>>>>>>>> Is there a configuration that does not build?
>>>>>>>>
>>>>>>>> The point of this series is to disable CMDLINE and fix up what br=
eaks.
>>>>>>>>
>>>>>>>> In this case we have some sort of breakage...perhaps Tom has alre=
ady
>>>>>>>> found it, but otherwise could you take a look?
>>>>>>>>
>>>>>>>> We should be able to disable NET and LTO in sandbox and still bui=
ld.
>>>>>>>> But this fails at present[1]. You can try it on -master
>>>>>>>
>>>>>>> Obviously, it would be necessary to enclose efi_dp_from_eth()
>>>>>>> with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
>>>>>>> Then, we could drop "depends on DM_ETH".
>>>>>>
>>>>>> Strange that it only happens on the non-LTO board, though?
>>>>>
>>>>> There's two issues. The first of which is that I think you need to
>>>>> re-check your error exactly? With my series, and LTO also disabled t=
he
>>>>> problem is a call to efi_get_image_parameters() as that's defined in
>>>>> cmd/bootefi.c, but also only used with cmdline invocations. So we ca=
n
>>>>> fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG_CMDLIN=
E)
>>>>> around that, and then discard efi_dp_from_name() entirely.
>>>>>
>>>>> The second issue is that with LTO we more completely find the cases
>>>>> where if x() calls y() and y() is undefined but nothing calls x() we=
 can
>>>>> just discard x() and not care that y() is undefined.
>>>>>
>>>>
>>>> I will send a patch for function efi_dp_from_eth().
>>>
>>> There's no problem with efi_dp_from_eth as far as I can tell.
>>>
>>>> @Simon
>>>>
>>>> One thing that I don't understand is why we don't let the linker
>>>> eliminate the unused functions on the sandbox.
>>>>
>>>> On other architectures we put each function into a separate text sect=
ion
>>>> and let the linker eliminate the unused text sections:
>>>>
>>>> arch/riscv/config.mk:29:
>>>> PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-sections -fdata-s=
ections
>>>> LDFLAGS_u-boot          +=3D --gc-sections -static -pie
>>>>
>>>> Shouldn't we keep the sandbox close to what other architectures do?
>>>
>>> Oh my, I didn't realize that sandbox was missing the garbage collectio=
n
>>> stuff.  Yes, that needs to be fixed first, then we can see what's next
>>> to change, as there are some issues (my series first fixed CMDLINE=3Dn=
 on
>>> qemu_arm64).
>>
>> My super quick pass at enabling
>> function-sections/data-sections/gc-sections shows there's nothing
>> further needed for CMDLINE=3Dn and LTO=3Dn on sandbox, not even the par=
t I
>> was looking at before.
>
> I am not sure about the original reason, but sandbox probably
> pre-dates wholesale enabling of gc-sections (I haven't looked). There
> is also the issue of whether the host toolchain supports it. Sandbox
> is supposed to run on a variety of OS types.
>
> I am also not sure of the point ot it...since it is normally pretty
> easy to use Kconfig to control features.
>
> At least for me 'u-boot -D' doesn't work with Heinrich's patch. Do we
> really need to make this change? It will rapidly devolve to the point
> that coming back would be extremely painful.

It just shows where the code is not clean.

Linker generated lists referenced by the corresponding macros are
compiled in (as shows up in u-boot.map). But you have decided not to use
those macros to access the sandbox command line options. Now they are
removed as unreferenced garbage.

Can't we use the linker generated list macros instead of duplicating code?

* define SANDBOX_CMDLINE_OPT via ll_entry_declare().
* replace ll_entry_count() instead of __u_boot_sandbox_option_count()
* use ll_start(), ll_end() for iterating

Best regards

Heinrich
