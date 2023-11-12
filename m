Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D987CC4167B
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 16:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4C686DE2;
	Sun, 12 Nov 2023 17:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZAphodO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B92B886D3F; Sun, 12 Nov 2023 17:38:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFB586E88
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699807089; x=1700411889; i=xypron.glpk@gmx.de;
 bh=UrlFHqD466olER/a3D3aZUYNrmDWVQbLBeQ2ywg/i+I=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ZAphodO+5GJj83GsHUdULyNA93MJkzi0SZNAl2BFhQT7h22t2pR7XMIwwUhpQGAa
 4/k3AetqfmpC2pIoY3nWi6tc3udMXVBXt2DIrNbfxYNPYpZ+0SHZ9ULbUkXw1NyXL
 koERYduYp7i4epASF9dX3bnNZIkxYVS1+MTt8qkb4qkDFJ9lSQ+LxMYjb86Xgah7W
 QJ2rQUNb6r4kYUHb4sD+aKhzUNNUGTUA3lkm2HUpzYhNlQDG3vpBqBvGKJO9F2Xdu
 Gm4vGySn6Q2AdKE3pPBe47H9hTZVBJvMEN6XJM4pDRPv5ktCRtZczkSw4Y65ap8rG
 X4ZZlDPcAMy367yMPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1r9qpx194e-00GbyZ; Sun, 12
 Nov 2023 17:38:09 +0100
Message-ID: <14a441aa-5134-4852-aac9-dcda23056ded@gmx.de>
Date: Sun, 12 Nov 2023 17:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARMv8.5 RNG driver (was :Re: [PATCH] virtio: rng: gracefully
 handle 0 byte returns)
Content-Language: en-US, de-DE
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, Peter Hoyes <peter.hoyes@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20231107160900.2652813-1-andre.przywara@arm.com>
 <CAPnjgZ1_KVcGvh869p3jvBh6umkwGv_VwFs73Yo3k9BBM54p0w@mail.gmail.com>
 <20231110141614.72b6dffd@donnerap.manchester.arm.com>
 <CAPnjgZ3PKoi2z6iBCr1f0DJMbS_usp1fedwaCzwCjqd02O_87Q@mail.gmail.com>
 <20231112115337.2bbe5ce7@slackpad.lan>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231112115337.2bbe5ce7@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hH9yE5/2LymuhhbILVQEW5ynsLj7cyfkap7sMHRqgvl8Km1HPxM
 T+UsmGtJz8BRWaGJ1b2BAZpfZbd/5Qt9LEny71g5gZY5PI5mCmkBE4on5CDbHfnFQSno8Fe
 HFtx8TTrExQUsz/icjBYkarfgJhLy2DMP5Q3mfpT42BnzE8vxBDybUQvNEbCuMqAzCvvy9f
 jP6FOXTuMrkQrfr4yvRzg==
UI-OutboundReport: notjunk:1;M01:P0:lw2tOOQGMS0=;1XgnSqKFbwJXxS+gHPkrERyCaVn
 4j/QEDzIxW+xG52wLib/NVYj9hgL9cgUr9kYcWbipkxY72GjLAjwlNdCW831XfdGNbtTyNBr/
 ftUKp4ThQHUE3KBarEqJ2QvNgkrPx4/odLB0+uBn0uN8BRhEyAGL+88L5yVDbshWmmgmL6ec8
 5nb1EMDIiI2dS1W4weiH2q96dpUJ1rUjTphlgnoMVqoUmht9MBnra6xauVmeOb3ov8rgTvAah
 flK6vuAfZbUQYHhDXi6tJ/zixX+PbflVccV0JzWVyqS4h//wBR+VWuf++vQiIs8mOoLJMjwef
 3dITbtPCsO/lGzPOgrFUcVXNvuaPQIF8Lfn5NR1EB4ihiLc95O1ylJqDYMAjGApG5Tok7mufP
 15nN8ZtxWNfFUXXfL081Ob8kRwNljLRQy9gAVi5oQQ1buF0IZkznPt7K30MHV6/h9ZIbAAIzR
 xsQGP0Ayu+QWme6R0S+vGXyrWJpwKCu5dkt49cWmEacpHtmIKGTPC1Bz09MGMUcTt8GVJIXmH
 oaprLwR+ZuETAAvbQH9n0kNUygPmiNZfOEN45KAlmLDviTIfHIuW4bJLEmbGG2NMQWvwEcBgm
 KjEpuWCdouEsgKmAMIxPyJvFtjBd0RUVrR5K2W6ObtlwcQ0xhfdDNKn1638pu2TKoVF4tHWrj
 X6svJNdtO7oaqCeW6JlTC+Lw1UFL3OmTjr2d6ClosGKxili4ciCnXncmc7Vsnn5xFNfqMQY03
 6g/AbBLt0pDByn9FqRHLnWyhHmPOB/6b05h6/RI9fuYgp7K+gX6DlKxiYtr9IbF6Pk5WitltJ
 /kOFo/wProRL0EoWaEPhuEl4nmtqvbYCUmtoLRsodewjph5bP5DakRiBoBZmi04/QJvxQvp8a
 33+jcWwow63q8laaIKa6xe5B3kHT945GOhfeFWESnG9r9dcGLUQEIc2e5VFj9hYApWRh5MD0G
 DOED/BL21xULuQWrrhASDwv05wk=
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

On 11/12/23 12:53, Andre Przywara wrote:
> On Sat, 11 Nov 2023 20:08:36 -0700
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
>> On Fri, 10 Nov 2023 at 07:16, Andre Przywara <andre.przywara@arm.com> w=
rote:
>>>
>>> On Fri, 10 Nov 2023 05:53:59 -0700
>>> Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Hi Simon,
>>>
>>>> On Tue, 7 Nov 2023 at 09:09, Andre Przywara <andre.przywara@arm.com> =
wrote:
>>>>>
>>>>> According to the virtio v1.x "entropy device" specification, a virti=
o-rng
>>>>> device is supposed to always return at least one byte of entropy.
>>>>> However the virtio v0.9 spec does not mention such a requirement.
>>>>>
>>>>> The Arm Fixed Virtual Platform (FVP) implementation of virtio-rng al=
ways
>>>>> returns 8 bytes less of entropy than requested. If 8 bytes or less a=
re
>>>>> requested, it will return 0 bytes.
>>>>> This behaviour makes U-Boot's virtio_rng_read() implementation go in=
to an
>>>>> endless loop, hanging the system.
>>>>>
>>>>> Work around this problem by always requesting 8 bytes more than need=
ed,
>>>>> but only if a previous call to virtqueue_get_buf() returned 0 bytes.
>>>>>
>>>>> This should never trigger on a v1.x spec compliant implementation, b=
ut
>>>>> fixes the hang on the Arm FVP.
>>>>>
>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>>> Reported-by: Peter Hoyes <peter.hoyes@arm.com>
>>>>> ---
>>>>>   drivers/virtio/virtio_rng.c | 9 +++++++--
>>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> Unrelated to this patch, but do you know the hardware architecture of
>>>> the ARM RNG? Is there one RNG unit per CPU or one for the whole SoC?
>>>
>>> Architecturally and from a software perspective the ARMv8.5 FEAT_RNG
>>> feature is a system register, so per-core. Theoretically the availabil=
ity
>>> could differ between cores, but the CPU ID feature registers are also
>>> per-core, so as long as we run on a single core, or always at least
>>> read from the same core, it's all good.
>>>
>>> Now the architecture only describes the CPU instruction aspect of the
>>> feature, and establishes rules for the quality and spec conformance, b=
ut
>>> leaves the actual source of the entropy open to the integrator.
>>>
>>> The manual in the Neoverse V1 core[1] (still not a SoC!) states that t=
he
>>> actual entropy source is a memory mapped peripheral, its address being
>>> held in an internal, per-core register. So you can have one shared ent=
ropy
>>> source per SoC, or a private instance for each core, that's up to the
>>> actual integrator to design.
>>>
>>>  From the software perspective this shouldn't matter, though: the feat=
ure
>>> is "per-core", how this is backed is an implementation detail.
>>
>> Would it make sense to model this as a memory-mapped peripheral under
>> /soc (perhaps one without an address?)
>
> No, absolutely not. What I mentioned above is a somewhat hidden
> implementation detail of that *particular core*. One big reason for
> having those architected *system registers* is to do away with all
> those implementation specific ways to access an entropy source, and
> make this dead easy for software (including userland!) to use it:
> Check the CPU ID register, read the sysreg. No prior knowledge required.
>
> I now deeply regret sending this Armv8.5 RNG driver. I have an
> alternative solution, just got distracted later this week to finish
> this up.
> Let's have a discussion there, or we find a way to probe UCLASS_RNG
> drivers other than through devicetree nodes. If U-Boot really insists on
> matching drivers to DT nodes 1:1, that's a really limiting design
> decision, and we should not proliferate this by shoehorning everyone
> and their dog into devicetree.

For the RISC-V Zkr driver Tom said we cannot expect QEMU and Linux to
change how the device-tree is set up to model CPU registers and the
usage of U_BOOT_DRVINFO() for these architecturally defined registers is
fine.

I would assume the same in the ARM case.

Best regards

Heinrich

>
> Cheers,
> Andre
>
>>> [1]
>>> https://developer.arm.com/documentation/101427/0102/Functional-descrip=
tion/Random-number-support/About-the-random-number-support
>>>
>>>
>>>>> diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng=
.c
>>>>> index b85545c2ee5..786359a6e36 100644
>>>>> --- a/drivers/virtio/virtio_rng.c
>>>>> +++ b/drivers/virtio/virtio_rng.c
>>>>> @@ -20,7 +20,7 @@ struct virtio_rng_priv {
>>>>>   static int virtio_rng_read(struct udevice *dev, void *data, size_t=
 len)
>>>>>   {
>>>>>          int ret;
>>>>> -       unsigned int rsize;
>>>>> +       unsigned int rsize =3D 1;
>>>>>          unsigned char buf[BUFFER_SIZE] __aligned(4);
>>>>>          unsigned char *ptr =3D data;
>>>>>          struct virtio_sg sg;
>>>>> @@ -29,7 +29,12 @@ static int virtio_rng_read(struct udevice *dev, v=
oid *data, size_t len)
>>>>>
>>>>>          while (len) {
>>>>>                  sg.addr =3D buf;
>>>>> -               sg.length =3D min(len, sizeof(buf));
>>>>> +               /*
>>>>> +                * Work around implementations which always return 8=
 bytes
>>>>> +                * less than requested, down to 0 bytes, which would
>>>>> +                * cause an endless loop otherwise.
>>>>> +                */
>>>>> +               sg.length =3D min(rsize ? len : len + 8, sizeof(buf)=
);
>>>>>                  sgs[0] =3D &sg;
>>>>>
>>>>>                  ret =3D virtqueue_add(priv->rng_vq, sgs, 0, 1);
>>>>> --
>>>>> 2.25.1
>>
>> Regards,
>> Simon
>

