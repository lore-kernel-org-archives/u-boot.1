Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E277C3ABDA
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 19:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CADFE82A8D;
	Wed, 14 May 2025 21:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAi4ESPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5C98205B; Wed, 14 May 2025 21:39:55 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764E582AB2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 21:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fc7edf00b2so275815a12.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747251593; x=1747856393; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RSXCaSzYGXqBGDyXt6Twn9YnhA+J7F0Gx6v1hJeGyE=;
 b=hAi4ESPYqfQob6H4AiCZTal2fJ1yS+3UX+Nh7iHeYqy9fMPit1KOtSSLrC0nOudZdq
 U+k3LXoApdIrWmFr4FjqwwqEpYwsBeW6MJVUtFindivq7Z0HdF3BhNkCGPY1XKRyVs6Z
 MNcMEEAe5Mp8HptRi5IdNkqLIFWgJvNDxij7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747251593; x=1747856393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RSXCaSzYGXqBGDyXt6Twn9YnhA+J7F0Gx6v1hJeGyE=;
 b=Dy6AIqIOaxZGzCTw7my9WAnO+RnEFaeDctP0AICXvDkCN5ml1uTyMQ7DmaS/PAjopY
 yBcyyETauxfq4aO8FHOdp0jzT1C+Jl3DuRryRvM5c6BCDrzVPxHDJnhGoWsvEGA62B1B
 +8lAimVvY8YF1SzGXmxRLr32yM1hXU9q7mfjRIcoiz3MAEoCotkBZBrlAXNXpoXmAcZa
 oPaFob3bZt2iL7HDU285uBGtNXflpuVRwv5p2XChrHp3s3jxB+q7HSfuFcAM6wYkRvZQ
 uLIMVzwbUXLRnAFbxzLG8sBSDi1/01fWYu3hqIvHKI2ntDanRl7J292xj/tOB/F0anA4
 fkiQ==
X-Gm-Message-State: AOJu0YwTMValwSjtz//JN9hk0QRXcxAtaVdBkIqo21RZYkkTPXJ8NDkg
 vuhmxFja2IZKw3yH5KWox5bIhtr0Lf9xNtOMpcDiMIHo4NdNRfsDqXACU8KSS0++1AUGXsktDZD
 /NaSH9bpeB1nHsSeRFqNRzKwYHRViSkDkeERspJIT/cT0U68WgwxjvD8yKw==
X-Gm-Gg: ASbGncuzfhkc5/Ra4W97hFNnQS7eCR84JqmH4GNnBYzeXFZz7dgBDNdMqVZQxBNLfjo
 qO/tllLtGi5O0YnG0k/PF9L1IcEiqCvhfEtN2QLQULHa9f2q3bbsWrY6/lTManNm7DK1Iz1zGx0
 uY7b+kXupZfsrZ+MuSjCBOaJb9udB04QHDQw==
X-Google-Smtp-Source: AGHT+IG8AcfTB2EBJgqqQaIwVdYhZL0FamBF/sA2j723zzylGYeNUw0hZVo7nA4bX8DZ1PtEf/6xdafbrEhF4EEz/WE=
X-Received: by 2002:a05:6402:280d:b0:5f4:c5eb:50c9 with SMTP id
 4fb4d7f45d1cf-5ff988d09c3mr3353132a12.21.1747251592672; Wed, 14 May 2025
 12:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHYLw-ReP8avjX8gKdpJJxus1u7FC0KVtzBRy594M1x6XfxPUQ@mail.gmail.com>
 <CAFLszTghZ+wXCHWMKodc7Nhp4RLkx954RfjxqR+xJBWuXF7xog@mail.gmail.com>
 <CAHYLw-SmBo+TBrpgg3qNe0as1KBEgN0bC_jE653ge7i2OdwvoQ@mail.gmail.com>
In-Reply-To: <CAHYLw-SmBo+TBrpgg3qNe0as1KBEgN0bC_jE653ge7i2OdwvoQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 May 2025 21:39:38 +0200
X-Gm-Features: AX0GCFun-8TTtv11VvXoBo2cnpjlyvcnqbPLHU9IEoV_GRSTcAAYw-s7OuLp4Gc
Message-ID: <CAFLszThw-73cVjoFnFc3RZh6rqx_yL_6QQSSP-0p8s201sP52A@mail.gmail.com>
Subject: Re: u-boot on x86
To: Michael <mep.sw.dev@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michael,

On Mon, 12 May 2025 at 15:59, Michael <mep.sw.dev@gmail.com> wrote:
>
> Hi Simon,
>
> when i execute the 'acpi' command i can see the tables.
> I've also tried to enable the CONFIG_SMP Option - without any changes.
> When using grub i can dump the tables - With u-boot i'm getting "Could no=
t get acpi tables AE_NOT_FOUND" (/sys/firmware/acpi is missing)
>
> acpi list
> Name              Base   Size  Detail
> ----  ----------------  -----  ----------------------------
> RSDP          9b693014     24  v02 ALASKA
> RSDT          9b692394     78  v01 ALASKA A M I  1072009 AMI  1000013
> XSDT          9b692728     cc  v01 ALASKA A M I  1072009 AMI  1000013
> FACP          9b616000    114  v06 ALASKA A M I  1072009 AMI  10013
> DSDT          9b5d1000  44832  v02 ALASKA A M I  1072009 INTL 20160527
> FACS          9b71c000     40
> MCFG          9b61a000     3c  v01 ALASKA A M I  1072009 MSFT 97
> SSDT          9b617000   20ad  v02 CpuRef CpuSsdt 3000 INTL 20160527
> FIDT          9b5d0000     9c  v01 ALASKA A M I 1072009 AMI  10013
> SSDT          9b5cc000   31da  v02 SaSsdt SaSsdt  3000 INTL 20160527
> HPET          9b61c000     38  v01 ALASKA A M I  1072009 AMI  1000013
> SSDT          9b5ca000   147b  v02 ALASKA Ther_Rvp 1000 INTL 20160527
> SSDT          9b5c6000   3240  v02 INTEL xh_cmsd4 0 INTL 20160527
> NHLT          9b5c4000   1821  v00 ALASKA A M I  1072009 AMI  1000013
> LPIT          9b61b000     94  v01 ALASKA A M I  1072009 AMI  1000013
> SSDT          9b5c0000   2720  v02 ALASKA PtidDevc 1000 INTL 20160527
> SSDT          9b5bd000   25b2  v02 ALASKA TbtTypeC 0 INTL 20160527
> DBGP          9b5bc000     34  v01 ALASKA A M I  1072009 AMI  1000013
> DBG2          9b5bb000     54  v00 ALASKA A M I  1072009 AMI  1000013
> SSDT          9b5b9000   1b67  v02 ALASKA UsbCTabl 1000 INTL 20160527
> DMAR          9b5b8000     c8  v01 INTEL  EDK2     2      1000013
> BGRT          9b5b7000     38  v01 ALASKA A M I  1072009 AMI  10013
> ASF!          9b5b6000     74  v32 ALASKA A M I  1072009 AMI  1000013
> WSMT          9b5c3000     28  v01 ALASKA A M I  1072009 AMI  10013
> APIC          9b5b5000    12c  v04 ALASKA A M I  1072009 AMI  10013
> FPDT          9b5b4000     44  v01 ALASKA CML 1072009 AMI  1000013

(please try to avoid top-posting on the mailing list as it gets
confusing when there are replies)

I suspect you are not getting the ACPI tables at all in this case,
since there is no 'pointer' at f0000 and x86 expects that when using
zboot. We need the code at the bottom of write_tables() to be invoked
somehow:

    if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
        void *ptr =3D (void *)CONFIG_ROM_TABLE_ADDR;

        /* Write an RSDP pointing to the tables */
        if (IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
            struct acpi_ctx *ctx =3D gd_acpi_ctx();

            acpi_write_rsdp(ptr, ctx->rsdt, ctx->xsdt);
            ptr +=3D ALIGN(sizeof(struct acpi_rsdp), 16);
        }
        if (IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE)) {
            void *smbios;

            smbios =3D bloblist_find(BLOBLISTT_SMBIOS_TABLES, 0);
            if (!smbios)
                return log_msg_ret("smbios", -ENOENT);
            memcpy(ptr, smbios, sizeof(struct smbios_entry));
        }
    }

Regards,
Simon


>
>
> Regards,
> Michael
>
>
> Am Mo., 12. Mai 2025 um 15:08 Uhr schrieb Simon Glass <sjg@chromium.org>:
>>
>> Hi Michael,
>>
>> On Thu, 8 May 2025 at 14:51, Michael <mep.sw.dev@gmail.com> wrote:
>> >
>> > Hello!,
>> >
>> > i'm currently working on a project that could use several architecture=
s
>> > (arm / x86).
>> > To have a common base for all systems, i want to use u-boot as unified
>> > bootloader for both platforms.
>> > At the moment i try to get u-boot working on x86. These systems are mo=
re
>> > general pcs than classic embedded systems and can have intel atom / i3=
...
>> > etc. processors (for example advantech mio series) - All of them have =
a
>> > uefi bios.
>> > To build the whole system i am using yocto. I have made some minor cha=
nges
>> > to u-boot (v2025.01 / build as efi app / binary) to fit my use case (f=
ind
>> > env partition via gpt part uuid / A/B update mechanism etc.)
>> > The kernel and initramfs are packed as fit image (
>> > https://docs.u-boot.org/en/latest/usage/fit/x86-fit-boot.html). I can =
boot
>> > the system and the a/b update mechanism is also working.
>> >
>> > The fit image contains kernel / setup / initramfs - (
>> > https://docs.u-boot.org/en/latest/usage/fit/kernel.html)
>> > The current boot procedure is: "boot uboot.efi" =E2=86=92 "load fit im=
age over the
>> > efi interface" =E2=86=92 "bootm"
>> >
>> > My current problem is, that i can only use one cpu core. I think there=
 is a
>> > problem with the acpi tables ("smpboot: Boot CPU (id 0) not listed by =
BIOS"
>> > / "smpboot: Allowing 1 CPUs, 0 hotplug CPUs" / "smpboot: SMP disabled"=
)
>> > I already got some hints on the irc chat (thanks for that!), but i cou=
ld
>> > not fix the issue yet. I also tried an "EFI handover" patch for uboot,=
 but
>> > with this, i cannot boot the kernel anymore (exception).
>>
>> Can you use the 'acpi' command to examine the tables and see what is
>> there? These tables are not created by U-Boot in this case. Also, I'm
>> assuming that U-Boot does not have CONFIG_SMP set, so it should be
>> ignoring the other CPUs.
>>
>> I did think of one issue, though. The ACPI tables are expected to be
>> at f0000, but when booting as an EFI app, that is not the case. There
>> is code at the bottom of write_tables() to add a pointer from f0000 to
>> where the tables actually are. So you may need to put that code
>> somewhere so it is done in the zboot case.
>>
>> You could also try dumping the ACPI tables within Linux for the two
>> different scenarios (booting via U-Boot and not). That might provide a
>> clue as to the difference.
>>
>> >
>> > At a later point i want to lock down the device with enabling the "sec=
ure
>> > boot" bios function. I have not worked with secure boot yet. I think i=
 can
>> > only get it working with the fit images (fit signature verification)?
>>
>> Yes you can use FIT, which is good if you are trying to be like ARM.
>> You may have seen this talk[1]
>>
>> >
>> > Is this thre right implementation approch?
>> > I am grateful for any advice!
>>
>> Yes it seems right to me. I'm hoping to get this into CI early next
>> month so it is properly tested.
>>
>> Regards,
>> SImon
>>
>> [1] https://www.youtube.com/watch?v=3Dhte60f7I9j4
