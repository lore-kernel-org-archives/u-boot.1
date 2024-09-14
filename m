Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0391EC02180
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 07:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14AE088C4D;
	Sat, 14 Sep 2024 09:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ipmq4MYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B1288C71; Sat, 14 Sep 2024 09:06:39 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A57888C4A
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 09:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.legoll@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7db238d07b3so2258603a12.2
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726297596; x=1726902396; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU5APxdpI6zOXQy/V1BoS2mH+Oj8loBd4Qiv3s/qcLg=;
 b=ipmq4MYYMLyl67Hz8iqNHC4ymp+GNQYNzOqGdTMr1hW20gnk2aqkPF52ghIAOBNKgk
 19FKjtVjcM4ovRhPgQpAccMdRPKHXocOC5IUqkGnFqN+aDlYvW2oW3WdbkB725mhmTJg
 7KX+XnmutHmMt52zfpRmi+h5kPjw5dtGXHvvUqlQzEV/j2+4LllusbK+zdEZTvrXb9xs
 Vdb6Qg0lyt1TEDXRgi+eWxFCmpvzgcFaXcQd/EIvt7GWyKA7N/ztL53D4oa/pNm+I/7Q
 427rKWvtWginW/T2sd4mR16aXSYIZalyEzmqxq4YW0AtE5e9W6t1QLvcJJ5zxaQDNThx
 cRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726297596; x=1726902396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cU5APxdpI6zOXQy/V1BoS2mH+Oj8loBd4Qiv3s/qcLg=;
 b=JZPtfzH1upJrM5ZLv+H234tAMrzVFCweWRmyucjxP66YXF74gfK4KcllGsRv3Onm2/
 na2JTKhQ1md8RRmxvxRvN/W7upDaUVxopP4vEbQfG9XbYCpT4NquIlDtjgWn7cv8rx+Y
 E8u6IFzLXRQDqHk/+t/6u0+NWzhcJYs0chocOLvtZ2O70KH+Ow13+UFKz1c8U49A6oZL
 p1/rdGj9YJFLMf0CBc4wK5xBxtWRVEWINU6GQH6Q5nNu4Jl66QlcuMlPdD6HJ8wKAnOA
 9iGz5krf8zZw8uzbZQFg6j/uq1amoO8MKjjgrxm8H9Hl6ypavUR+PLsdq3qeijfRjhcl
 qS3Q==
X-Gm-Message-State: AOJu0YyZWJQcPT8t72lweod9RA8AvW7wRzAwtkYonAY200MhMl7Fy1Nt
 K9UvL3WfhKoINds4m3mJr8IjjNgF9kO0ZirQpPz90IKwvOIF1FUhLouMQ2c54M9eWtJR7JxADnq
 AvAMOLhCe2TllppJ4IuYXFfa+/iU=
X-Google-Smtp-Source: AGHT+IFu2StOD0AJWowRKEFsZ4CtcFWsogdd/V1ovr9ZJ22ECAniWw7goFTpbpGziIuSQAIXAhB7AcYRI0zMT7N3HmI=
X-Received: by 2002:a05:6a21:4d8a:b0:1cf:2218:1be6 with SMTP id
 adf61e73a8af0-1cf764b02aemr12808720637.50.1726297595250; Sat, 14 Sep 2024
 00:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwRq=qZSs9va2ztMQ2t_kfqHFAiMydyUHY13U_-AfKdSuhL-w@mail.gmail.com>
 <CAFLszTjSoLW769CAefgu9wzm5VBVZnvyPp87f2zi9ecUtPB4mg@mail.gmail.com>
In-Reply-To: <CAFLszTjSoLW769CAefgu9wzm5VBVZnvyPp87f2zi9ecUtPB4mg@mail.gmail.com>
From: Vincent Legoll <vincent.legoll@gmail.com>
Date: Sat, 14 Sep 2024 07:06:23 +0000
Message-ID: <CAEwRq=q8WT9jPouwu8RMNjgQYkDeRoFzBDhiLOTMgyUXJPNTQA@mail.gmail.com>
Subject: Re: persistent environment
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
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

Hello Simon,

On Thu, Sep 12, 2024 at 1:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
> Looking at env_erase()
> It calls drv->erase() which for mmc is:
> .erase =3D ENV_ERASE_PTR(env_mmc_erase)
>
> I see this:
>
> if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
>    copy =3D 1;
>
>    if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
>       ret =3D mmc_set_env_part(mmc, copy + 1);
>       if (ret)
>          goto fini;
>    }
>
> which suggests that perhaps it is failing there as mmc_set_env_part()
> has that error message "MMC partition switch failed". Do you want a
> redundant environment?

Your answer made me look at the code, and now I think I'm confused.

No, I don't need/want a redundant env, I'm just trying to setup a persisten=
t
env. on the SD card from which I boot.

The error that happen at "env save" also happen at boot (see previously
attached bootlog), and at "mmc dev  1 3" command, see below.

mmc 0 is the on-board soldered eMMC
mmc 1 is the SD card I'm booting from

I'm using a GPT partition table on both devices as I would on any other
block device, is that OK to save an environment ?

The test on following line is failing:
https://github.com/u-boot/u-boot/blob/master/drivers/mmc/mmc-uclass.c#L478

I've put a debug print after this test, and you can see it in the
following (at the end):

=3D> mmc info
Device: mmc@fe2e0000
Manufacturer ID: d6
OEM: 3
Name: 58A441
Bus Speed: 150000000
Mode: HS200 (200MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 57.6 GiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 8 MiB
User Capacity: 57.6 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

=3D> mmc part

Partition Map for mmc device 0  --   Partition Type: EFI

Part    Start LBA       End LBA         Name
        Attributes
        Type GUID
        Partition GUID
  1     0x00008000      0x00ffffff      "EFI"
        attrs:  0x0000000000000000
        type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
                (system)
        guid:   ef98a377-91ef-4ba5-8279-c06cea50cd37
  2     0x01000000      0x01ffffff      "root_void"
        attrs:  0x0000000000000000
        type:   0fc63daf-8483-4772-8e79-3d69d8477de4
                (linux)
        guid:   c560bc7e-1096-4f10-8244-ff84c5059405
  3     0x02000000      0x0733bfde      "obsd"
        attrs:  0x0000000000000000
        type:   824cc7a0-36a8-11e3-890a-952519ad3f61
                (824cc7a0-36a8-11e3-890a-952519ad3f61)
        guid:   fb5f3a56-7e69-497d-854f-1a4ef4362785

=3D> mmc dev 1
switch to partitions #0, OK
mmc1 is current device

=3D> mmc info
Device: mmc@fe2c0000
Manufacturer ID: 1b
OEM: 534d
Name: 00000
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 29.8 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes

=3D> mmc part

Partition Map for mmc device 1  --   Partition Type: EFI

Part    Start LBA       End LBA         Name
        Attributes
        Type GUID
        Partition GUID
  1     0x00000040      0x00003fff      "loader"
        attrs:  0x0000000000000000
        type:   0fc63daf-8483-4772-8e79-3d69d8477de4
                (linux)
        guid:   2fa7d6f9-1c60-4cee-9b64-a068ba2b493a
  2     0x00004000      0x00007fff      "uboot"
        attrs:  0x0000000000000000
        type:   0fc63daf-8483-4772-8e79-3d69d8477de4
                (linux)
        guid:   b849290b-0840-4ab5-849c-ccba99439131
  3     0x00008000      0x0000ffff      "env"
        attrs:  0x0000000000000000
        type:   3de21764-95bd-54bd-a5c3-4abe786f38a8
                (u-boot-env)
        guid:   6d006d1c-794e-4408-b0a4-f52b6b3fac4a
  4     0x00010000      0x0010ffff      "efi"
        attrs:  0x0000000000000000
        type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
                (system)
        guid:   3587cde4-bf68-4e24-b74f-164015d47b9c
  5     0x00110000      0x007fffff      "root"
        attrs:  0x0000000000000000
        type:   0fc63daf-8483-4772-8e79-3d69d8477de4
                (linux)
        guid:   d74fd9eb-00df-4bc8-94db-ddd4fade2040

=3D> mmc dev 0
switch to partitions #0, OK
mmc0(part 0) is current device

=3D> mmc dev 1 3
mmc_select_hwpart() - 2 - ERROR EMEDIUMTYPE because MMCPART_NOAVAILABLE
switch to partitions #3, ERROR

--
Vincent Legoll
