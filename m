Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B896ACDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 06:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D3C876BA;
	Sun, 22 Oct 2023 08:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UTwHmDXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1E1876BD; Sun, 22 Oct 2023 08:08:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A11C8769C
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 08:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697954890; x=1698559690; i=xypron.glpk@gmx.de;
 bh=+H7UKFhB3GDGXnvmEXPQWDYXajEN/22PRC1SoYXqQWA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=UTwHmDXOrkhcOtAKx1Fo6HoioLj2Mf9rZTe/x1rpmpXP0mVNio8lAFwVytSXF1aS
 AufFwv5z8K66HmRwtex3mrBzF9D8hRpIIsPPiLl1BrqYvZ447Rm46WhEu3NXtjIQJ
 wa4ynbGVuql+LdvE1ooua3U1i+9EmnFyXk6ihI91zeSJsnM1ty/o+YCheQwhaXZW2
 vvJkDTHAj8r7XWmYDRwAi8T5p2jduxc83zcFYiEh0LxHnMh6SOy5/sBddwY3q0gVP
 BxmOP9+5DWB8vXZ5y+j8Ckl4CWyKDUFPtmsbX0mD/T69m18wVbE3/8VqrUNGj6nmX
 KRiGk6I8BnoKI+9JxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1ra76I0sCu-016O80; Sun, 22
 Oct 2023 08:08:10 +0200
Message-ID: <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
Date: Sun, 22 Oct 2023 08:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231021182612.GA53397@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/X3SD4/Tb7JNwfjYiscFsHrv3DNVRBr3iPKaLNCHCGW40k+S9mN
 PC5vPG2IagbKzjYbnRakId2okQGaTVxXF5qHxnhuk5re1OuQ90TSjlzSEHTOjSsX9OVQ2QI
 8ZVPPlgUXjY2dXQHcob4d5CUp+2+/FQnRDGEIK36z+SV5bV7uP8X/eGg93QiG3g8iaSkR41
 7nlENKVX+B2a9xBCySZzQ==
UI-OutboundReport: notjunk:1;M01:P0:8anfPfcP4gk=;ggv+spCtezUjuSGxUYKtj4DIE6q
 dAH8KufVTO0B9H23XOT4Vj/we9T7bBzA6fHmfinQR+onF59fBj+evDrabTtq9jnhaRdMbU51j
 Q/Xz4S5np/XO7jdTPqKV/g/17LLXFDfS6vfk+0hOAosjRhAipy60qd48wG0UyWpfDJHvE7+BX
 7NcaDeRy+WKK6nzo3Gf2BrUpZRugHVlg2IlthGpqKPeheWDd65aCqrGdawh6Megwvw/2ccyLs
 w+5CAhF+6O2JhiQKQrKa5xzZGHB+o66xNNRKc/Wu4jxn9UEPA/C8dk0Vb6ns3p+xSibn58MvH
 HUYUMtxNYO1xdBuU6upQ9pJgqB7KRBEHV0wG2SVw8m6Pqs0EDjfw8HkX9ZIkYndnoWeykvILV
 XNzXb6FylDLPj7I//gBT/VyNGqgAMJoL5qJj+8+2M/MaWEPbenhpRdIHHtFqDK0AOTjCYhUP/
 80mGivK4yiJY6/5ozhGRl7mN2FfsUckg2AJxNiBNQoMPasrkWyX/QILivaQG5AlczvPCJIIUV
 9sI1WwWj1pCzKCcMBUuxajO2eOCPVJ+o4xiaFOeWkGUmQA00nSUpbmFSG4opJDIGCXMVZFIe6
 AkBmCh+PgVTroSk11mCwsi29YNHZHRglQsjChujdGL3QezqfBI2yUDYWnHVFlcfMluPv9yeyZ
 IhyElLW9FMGoSDBpJjBiMPtZM7GbyFtVUcrwJUNZjSGcpUJhKnC915Wu8s1MMQK65gDrjd8l/
 xgb3iE1PcJenRQ5bw2SBHlz9vxOd3q+dpJUp6LhmGqpNo4rV04MTgZo8/6tw5bZpxH+VZVJtj
 LVw8tB0jCGtfCgHyem1OUoplZE/ZjGRQr91HcZQDaGU39Ku5X5wvuCMlNhYufTCafAWGnw0X5
 Yn9RGZr0z5LqevE51kjeUl6SJkViIxfLOUFnF/ncJf/C90IDOxZhvbNf4w56hpcQuI8Fe15e+
 UgxZAZgkRMTnfcjn7Sc5imTZMQw=
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

On 10/21/23 20:26, Tom Rini wrote:
> On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
>> Hi,
>>
>> On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
>> <takahiro.akashi@linaro.org> wrote:
>>>
>>> On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
>>>> Hi Heinrich,
>>>>
>>>> On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
>>>>>
>>>>> On 10/17/23 16:09, Tom Rini wrote:
>>>>>> On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
>>>>>>
>>>>>>> Since efi_device_path.c calls eth_get_dev() and assumes that Ether=
net is
>>>>>>> available, add it as an explicit dependency.
>>>>>>>
>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>> ---
>>>>>>>
>>>>>>> (no changes since v2)
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - Add new patch to update EFI_LOADER to depend on DM_ETH
>>>>>>>
>>>>>>>    lib/efi_loader/Kconfig | 1 +
>>>>>>>    1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>>>>> index 13cad6342c36..fca4b3eef270 100644
>>>>>>> --- a/lib/efi_loader/Kconfig
>>>>>>> +++ b/lib/efi_loader/Kconfig
>>>>>>> @@ -11,6 +11,7 @@ config EFI_LOADER
>>>>>>>       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>>>>>>>       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>>>>>>>       depends on BLK
>>>>>>> +    depends on DM_ETH
>>>>>>>       depends on !EFI_APP
>>>>>>>       default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
>>>>>>>       select CHARSET
>>>>>>
>>>>>> Does this work for you Heinrich, or do you want to clarify the
>>>>>> dependencies (and re-organize the code as needed) around networking=
?
>>>>>>
>>>>>
>>>>> We should be able to boot via EFI on devices without U-Boot network =
support.
>>>>>
>>>>> We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
>>>>> eth_get_dev() if there is no network. CONFIG_NETDEVICES=3Dy selects
>>>>> CONFIG_DM_ETH.
>>>>>
>>>>> Why is this not sufficient?
>>>>> Is there a configuration that does not build?
>>>>
>>>> The point of this series is to disable CMDLINE and fix up what breaks=
.
>>>>
>>>> In this case we have some sort of breakage...perhaps Tom has already
>>>> found it, but otherwise could you take a look?
>>>>
>>>> We should be able to disable NET and LTO in sandbox and still build.
>>>> But this fails at present[1]. You can try it on -master
>>>
>>> Obviously, it would be necessary to enclose efi_dp_from_eth()
>>> with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
>>> Then, we could drop "depends on DM_ETH".
>>
>> Strange that it only happens on the non-LTO board, though?
>
> There's two issues. The first of which is that I think you need to
> re-check your error exactly? With my series, and LTO also disabled the
> problem is a call to efi_get_image_parameters() as that's defined in
> cmd/bootefi.c, but also only used with cmdline invocations. So we can
> fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG_CMDLINE)
> around that, and then discard efi_dp_from_name() entirely.
>
> The second issue is that with LTO we more completely find the cases
> where if x() calls y() and y() is undefined but nothing calls x() we can
> just discard x() and not care that y() is undefined.
>

I will send a patch for function efi_dp_from_eth().

@Simon

One thing that I don't understand is why we don't let the linker
eliminate the unused functions on the sandbox.

On other architectures we put each function into a separate text section
and let the linker eliminate the unused text sections:

arch/riscv/config.mk:29:
PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-sections -fdata-sectio=
ns
LDFLAGS_u-boot          +=3D --gc-sections -static -pie

Shouldn't we keep the sandbox close to what other architectures do?

Best regards

Heinrich
