Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68F3C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 09:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DFD86EF1;
	Sat, 11 Nov 2023 10:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sfu0Ljxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D0A86EFD; Sat, 11 Nov 2023 10:39:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EC586EDF
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 10:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699695585; x=1700300385; i=xypron.glpk@gmx.de;
 bh=FMZKyLju8gefAuJ0g1/h8sMJDEfGLgTf+7lYRuT3tC0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=sfu0LjxfwaMsfplsRTok34jUI8ZKHmmZzWXylFlusDjC37ksCmv/eV/mvuq0qnge
 CHHFe2vPbENNOQU8z5ovpoQgrEU9DI22Qss2ZQgMyvWckSys/pNT0rf5AkesaXtms
 sLgIQ4kohrnlezGnoPLCBhhUvX8H9HFTfrirjGeBS5PWqU4ZFZRf+trovpAsoJg3T
 DbiGEpuQbwH2G+0Kcyi4IJZ4Y9jrsoAmwzWa7LYiRm6NrCBobS+pOSGNc/9rthMyw
 4c03FxvIN/ik4WEQ+RW6jvRDHPGcDjtZOM7bDK2BIL2C9r709Lti7uDGwpYejyMaX
 ofIVDDEhOSMOF07DDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1qzpBu2Q2p-001x2H; Sat, 11
 Nov 2023 10:39:45 +0100
Message-ID: <85309d7e-6792-48d2-b3a5-95ccafd89c0c@gmx.de>
Date: Sat, 11 Nov 2023 10:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: rng: gracefully handle 0 byte returns
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, Peter Hoyes <peter.hoyes@arm.com>,
 Simon Glass <sjg@chromium.org>
References: <20231107160900.2652813-1-andre.przywara@arm.com>
 <CAPnjgZ1_KVcGvh869p3jvBh6umkwGv_VwFs73Yo3k9BBM54p0w@mail.gmail.com>
 <20231110141614.72b6dffd@donnerap.manchester.arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231110141614.72b6dffd@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ySoBClDqC+iuQjLOGocP+vnSu/8gCY0stzduGDawO8N9qh3ujye
 JQ/uRN2ySMFert9jpoaqG9ljKhvJvJJSX35wgGu/pgO7hR/R+uKr/RI2KCvK+S7e9dZhDgL
 tyV9RlMJiHXvVPY+5FVoU5m4fFHCyi+5asFotzNXK5lFQSKXQ1uPGMWoeOXBrAvZ2T7ikVq
 c+3tZ5ERBze6B+lnvLByA==
UI-OutboundReport: notjunk:1;M01:P0:9ahhzgWTJNA=;7dYWsc40eWrbEhbg6ohuVqp5gjs
 JVcwekJBmLhIudFWHy+jWW7otkdwbqpKk7RtC0+PgU0WxBfrebqu48DKIxkxsMMuQBC2D2oTz
 kZ+As4RaPqmlRVToG3QMYngrI1eXeF+kQ0cVDhR7rMWhowBABm3pfd+xwERTZSN7L/q2sMnGS
 NIwKnx86cM1PzblB/FhNb+TO96+2VdNDWGNNRsh1gzwbXV3CZaXYw86K8UnOz48In5hs0rV5E
 Y6uUiNOHmUO1HVEHf/4ylCWldqx+ET6h3ef50bhX1KLyC1HwyDn45ThaD70ZmIs/W0+A8WhMJ
 1L7ebo14Bk77RU3cwqtGXhmOLaSKhQjnDIXwiU4Oui0PgaInJg4fiTms41B8fAtPgfjOO6nc0
 Pa9qcl1CcFsih+xF4/mHi7xbdgYZ1OL+231z/iM1AWO6lJUDm6Ph6bqbD5GgzEnEMuMOm+uco
 8vMMHAxwwwQOVMf2bV32XYBGiXJd5wQijgjE2R+1JEfbQN9wd0uWFJXCFMHIDVvzZc1p8qH0j
 tTF7sejC4J6fGp9Hrz+aO6+cWMnkh9pHYzUw1HWowpWk0S3EtlnxnfiPcZM1260kbS3kceF/6
 zI2D5W6lZ7IiyIg2d9Y0zBPsXrp2eddroMb2m6Z74uSZa2Sv9adirLVPRvfZqN5DZSiUH2saE
 9uy4rrsfGA60l2H0QiuGiO+dVp92K7hrZ+UzJdz/FVl8TsxLAA77drsO1o3hU7H1yxmPa5u1E
 mjn5zJPAcH4GXGpKnTAt8XasqrRvSVusWttp19DLgGhvpRsc/qvqDdx2rYAJbXV++9AMD3DsC
 cLGt/LmbQu0YHAOGQbn3cCsUXwnfl2QC4LMQtIOZM5aJJdKqkwcqoeTkTvAm5ci38wmPd+zkT
 HcXcxap2NWfF0dyCxMshzwtr1KvCUDjpsveo8jsbiKruwdxaYU/7J24rz2PeqF20Z34/jzffo
 bycJbg==
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

On 11/10/23 15:16, Andre Przywara wrote:
> On Fri, 10 Nov 2023 05:53:59 -0700
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi Simon,
>
>> On Tue, 7 Nov 2023 at 09:09, Andre Przywara <andre.przywara@arm.com> wr=
ote:
>>>
>>> According to the virtio v1.x "entropy device" specification, a virtio-=
rng
>>> device is supposed to always return at least one byte of entropy.
>>> However the virtio v0.9 spec does not mention such a requirement.

v0.9 was a draft. So nothing we have to care about.

>>>
>>> The Arm Fixed Virtual Platform (FVP) implementation of virtio-rng alwa=
ys
>>> returns 8 bytes less of entropy than requested. If 8 bytes or less are
>>> requested, it will return 0 bytes.
>>> This behaviour makes U-Boot's virtio_rng_read() implementation go into=
 an
>>> endless loop, hanging the system.
>>>
>>> Work around this problem by always requesting 8 bytes more than needed=
,
>>> but only if a previous call to virtqueue_get_buf() returned 0 bytes.
>>>
>>> This should never trigger on a v1.x spec compliant implementation, but
>>> fixes the hang on the Arm FVP.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> Reported-by: Peter Hoyes <peter.hoyes@arm.com>

The bug should be fixed in the Arm Fixed Virtual Platform instead of
working around it in U-Boot.

Our driver should return -EIO if the virtio host is not compliant.

Best regards

Heinrich

>>> ---
>>>   drivers/virtio/virtio_rng.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Unrelated to this patch, but do you know the hardware architecture of
>> the ARM RNG? Is there one RNG unit per CPU or one for the whole SoC?
>
> Architecturally and from a software perspective the ARMv8.5 FEAT_RNG
> feature is a system register, so per-core. Theoretically the availabilit=
y
> could differ between cores, but the CPU ID feature registers are also
> per-core, so as long as we run on a single core, or always at least
> read from the same core, it's all good.
>
> Now the architecture only describes the CPU instruction aspect of the
> feature, and establishes rules for the quality and spec conformance, but
> leaves the actual source of the entropy open to the integrator.
>
> The manual in the Neoverse V1 core[1] (still not a SoC!) states that the
> actual entropy source is a memory mapped peripheral, its address being
> held in an internal, per-core register. So you can have one shared entro=
py
> source per SoC, or a private instance for each core, that's up to the
> actual integrator to design.
>
>  From the software perspective this shouldn't matter, though: the featur=
e
> is "per-core", how this is backed is an implementation detail.
>
> Cheers,
> Andre
>
> [1]
> https://developer.arm.com/documentation/101427/0102/Functional-descripti=
on/Random-number-support/About-the-random-number-support
>
>
>>> diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
>>> index b85545c2ee5..786359a6e36 100644
>>> --- a/drivers/virtio/virtio_rng.c
>>> +++ b/drivers/virtio/virtio_rng.c
>>> @@ -20,7 +20,7 @@ struct virtio_rng_priv {
>>>   static int virtio_rng_read(struct udevice *dev, void *data, size_t l=
en)
>>>   {
>>>          int ret;
>>> -       unsigned int rsize;
>>> +       unsigned int rsize =3D 1;
>>>          unsigned char buf[BUFFER_SIZE] __aligned(4);
>>>          unsigned char *ptr =3D data;
>>>          struct virtio_sg sg;
>>> @@ -29,7 +29,12 @@ static int virtio_rng_read(struct udevice *dev, voi=
d *data, size_t len)
>>>
>>>          while (len) {
>>>                  sg.addr =3D buf;
>>> -               sg.length =3D min(len, sizeof(buf));
>>> +               /*
>>> +                * Work around implementations which always return 8 b=
ytes
>>> +                * less than requested, down to 0 bytes, which would
>>> +                * cause an endless loop otherwise.
>>> +                */
>>> +               sg.length =3D min(rsize ? len : len + 8, sizeof(buf));
>>>                  sgs[0] =3D &sg;
>>>
>>>                  ret =3D virtqueue_add(priv->rng_vq, sgs, 0, 1);
>>> --
>>> 2.25.1
>>>
>>
>> Regards,
>> Simon
>

