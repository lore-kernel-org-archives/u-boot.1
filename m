Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65CEC021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 00:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359CC80540;
	Sun, 23 Feb 2025 01:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V9uuj+nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EFB808B6; Sun, 23 Feb 2025 01:33:19 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974D380017
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 01:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so656763666b.3
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 16:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740270796; x=1740875596; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cNdEyuFHUP3y64ux1I5nc8h7S6Yf3Be726yC4Moi4JY=;
 b=V9uuj+nQyv0ixX8fBwK+qs8VQadIyuPxiNbC2No3r93lzvjzxuzL40oRdKGcs5Q8Z7
 oBZlpKE93HFuji8fs/PYNk5m+zS86drCqMX4xa7daQyTDAVBtsFdePrM4cL0q0kYwZo4
 7VYtzHgz9zUSQgX6m44VdwaswMyOhZq+WfNRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740270796; x=1740875596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNdEyuFHUP3y64ux1I5nc8h7S6Yf3Be726yC4Moi4JY=;
 b=jL1cn7JoDj62+e81Ul40rUFWGUF5ydpfaSGB04/b0Nen5GCiLuEDMgMv0OcfHW6rKt
 A4D9VM8h2fZPsmgScgtW/rBiIW7qF3hVw4FBSevzIdsq44alGH+SFaVCSYnO30im0ChD
 HKz08j4WQFf44Z5IR0X04p3j59L8JLpu+Co669mrdmfaZuL8zxGm1nwKRbalyfIZ4MYL
 3HCxiRZTdOSWa3Ghyco7ZYn1OqEzuQ8B7NVwxTYX+Cxq7F0CoGpYZ9WO7jI5p18p491p
 m7lP+gZcHMeNugr2a929YEr2NIUYY3O02wYovl8Gtbwyrkkt3YG7V03l5MP+JGJSl4uL
 3D3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjjMjRieXcWjVt0Yx1s1FRnNaSN7eEZSoa4bgqkR16HBSNiGK+C70V3ck1Vq13DRZKWvfG7HY=@lists.denx.de
X-Gm-Message-State: AOJu0YwurQl4bX1rGvsjn2YENIfCTl54gS/IzmR/Js4DII45JuEOD4dF
 2tmkg9S10s5ntcInqOx/jkMuAdLNHq9hqhf9ksdd51fSmsPfSNulvTSXiqeZZAmcNpnRjUptTgl
 cZPoFBmryBD2oL+M5G5os9MgHGYJdGC9tpG7KIcileSC9IYk=
X-Gm-Gg: ASbGncsmEB7RIllIG+tTxZC3J7E9UlXrFVo+IawSwtLQa0iZNjQtuelqZNTM3YhZSj9
 VK1GIWCyKbZDQ+DFSItrEUVU0BcH06qPGzwcyv+ReDaVQ6bVdGZyFq/Pd0J3FRzp9oJP74EK58s
 DO1YOKelcj
X-Google-Smtp-Source: AGHT+IFy+V4++6Q9lqCfUEH28dLJotMSi/e/WBY2X2PO2HDBOQO/d7LoVoutjlu1EeeWjY7g+KNFlHBFTH6lfqXa6gU=
X-Received: by 2002:a17:907:2d92:b0:ab8:c215:fd27 with SMTP id
 a640c23a62f3a-abc09a42e5cmr900553966b.14.1740270795951; Sat, 22 Feb 2025
 16:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
 <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
 <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
 <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
 <5E98D444-A005-42CD-8A6A-381791237A6E@makrotopia.org>
 <07eb10ff-2791-420d-a302-a2e8c308b468@cherry.de>
 <Z7dItf07omjuTm0U@makrotopia.org>
 <6b6925ee-ba1a-46ed-88dd-87b3bc4b77a5@cherry.de>
In-Reply-To: <6b6925ee-ba1a-46ed-88dd-87b3bc4b77a5@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 22 Feb 2025 17:33:04 -0700
X-Gm-Features: AWEUYZkkJZ4zJg8XiyMqJ7ASjCPovrI_68BsEgOd7sgyWmsj1dhXJkzCPzUpe2k
Message-ID: <CAFLszTh9UcS=3JSO5ZUTr7d6g9+dhorxJBP1--YkpsOcny7Y7g@mail.gmail.com>
Subject: Re: [PATCH] Add 'bootsource' /chosen property
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de, 
 Quentin Schulz <foss+dt@0leil.net>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Heiko Stuebner <heiko@sntech.de>, devicetree-spec@vger.kernel.org
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

Hi Quentin,

On Thu, 20 Feb 2025 at 08:55, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> On 2/20/25 4:22 PM, Daniel Golle wrote:
> > On Thu, Feb 20, 2025 at 04:04:27PM +0100, Quentin Schulz wrote:
> >> Hi Daniel,
> >>
> >> On 2/15/25 4:13 PM, Daniel Golle wrote:
> >>> Hi Quentin,
> >>>
> >>> On 10 February 2025 16:25:23 UTC, Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
> >>>> [...]
> >>>> What I can say from glancing at the code is that for Rockchip they d=
o the following:
> >>>>
> >>>> Register a bootsource type (e.g. MMC, SPI, I2C, USB, etc...), a boot=
source instance of that type (e.g. MMC0, SPI3, I2C7, ...). The mapping betw=
een what the ROM says the device is vs what it is in the DT is done in thei=
r Barebox-specific DT via this custom prop in /chosen:
> >>>>
> >>>> barebox,bootsource-<bootsourcetype><bootsourceinstance> =3D &label; =
 # =C3=A0-la /aliases
> >>>>
> >>>> This gets read and resolved and then inserted as
> >>>>
> >>>> /chosen/bootsource =3D "/some/path"
> >>>>
> >>>> into the kernel DT.
> >>>
> >>> We are doing something quite similar downsream at openwrt.org for Med=
iaTek router SoCs, see for example:
> >>>
> >>> https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-media=
tek/patches/310-mt7988-select-rootdisk.patch
> >>>
> >>> https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/fi=
les-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi#L32
> >>>
> >>> https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/fi=
les-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso#L60
> >>>
> >>>
> >>> Of course we could use the standard "bootsource" property instead, bu=
t having a way to reference the volume or partition used as rootfs instead =
of just passing a referencd to a physical device is advantagous...
> >>>
> >>
> >> If I understood correctly, your prebuilt DT would have
> >>
> >> / {
> >>      chosen {
> >>          rootdisk-emmc =3D <&rootfs_in_emmc>;
> >>          rootdisk-nor =3D <&rootfs_in_nor>;
> >>          rootdisk-sd =3D <&rootfs_in_sd>;
> >>          rootdisk-spim-nand =3D <&rootfs_in_ubi>;
> >>      };
> >> };
> >>
> >> and then at runtime you would populate /chosen/rootdisk property with =
the
> >> "rootdisk-<medium>" string with <medium> matching whatever the BootROM
> >> reports. I assume the goal is to somehow make sure that the rootfs is =
loaded
> >> from the same storage medium as the one used by the BootROM to load th=
e
> >> first stage bootloader?
> >>
> >> Can you confirm I did get that right?
> >
> > Yes, that's more or less correct. It's to point Linux to the device or
> > partition of the uImage from which U-Boot has loaded the Linux kernel.
> >
> > Note that for OpenWrt we prefer to store the uImage.FIT inside a raw
> > block or flash partition, or UBI volume, rather than as a file inside a
> > filesystem.
> >
> > This information is then used for two things:
> >
> >   - Mount the root filesystem
> >     We use a read-only squashfs which is part of the uImage.FIT, it ess=
entially
> >     has the same purpose of an initramfs on other distributions, but mo=
unting
> >     squashfs is much faster then decompressing the whole initramfs at o=
nce, and
> >     it doesn't need to remain in RAM permanently.
> >
> >   - Know where an updated uImage.FIT should be written to.
> >
>
> OK, so everything in a FIT image and you store the location and storage
> medium where it was loaded from so that you can update it. Makes sense.
>
> I guess we could have bootstd/bootmeths populate another property that
> specifies which medium and partition was used to load the kernel/FDT and
> initramfs. I don't have much experience with that aside from
> extlinux.conf and that wouldn't be appropriate I believe especially if
> you used root=3DPARTLABEL=3D or a UUID in your kernel command line as the=
re
> could be multiple ones with the same there (e.g. we have the exact same
> image you can flash on SD card and eMMC and the probe order isn't
> deterministic in the kernel I believe).
>
> Don't want to get sidetracked too far though, I don't think it is
> incompatible with or related to /chosen/bootsource usage?
>
> >>
> >> I was specifically NOT aiming /chosen/bootsource to represent the stor=
age
> >> medium used to load the kernel or rootfs, but rather the medium that w=
as
> >> used by the BootROM to load the first stage of the bootloader that is
> >> user-flashable/uploadable.
> >>
> >> You could very well decide to load/mount your rootfs from SD even if t=
he
> >> BootROM loaded the first stage bootloader from SPI-NOR. This property =
is
> >> about representing the latter, not the former and not merging the mean=
ing of
> >> both into one.
> >
> > Of course, especially for general purpose Linux which would not fit int=
o
> > NOR flash that's the only option.
> >
> > In case of OpenWrt we usually do want to load kernel (and rootfs) from
> > the same device also used by the BootROM for booting. OpenWrt can easil=
y
> > fit onto 16 MiB of NOR flash, including bootloader, EEPROM for MAC
> > addresses and WiFi calibration as well as some megabytes for user data.
> >
>
> We (Cherry/Theobroma) have some modified behavior for bootstd to favor
> booting from the same storage medium as U-Boot proper (so NOT
> necessarily what is reported by /chosen/bootsource) instead of
> defaulting to boot from SD card first and then eMMC. See
> https://elixir.bootlin.com/u-boot/v2025.01/source/board/theobroma-systems=
/common/common.c#L11.
> So I very much understand your usecase :)
>
> FYI, U-Boot SPL favors for loading U-Boot proper the same storage medium
> as was used by the BootROM (so that would be the same as reported by
> /chosen/bootsource here!) and this is modeled with the "same-as-spl"
> string in /chosen/u-boot,spl-boot-order property. I was thinking of
> adding a "same-as-proper" boot target for bootstd so I can remove my
> custom setup_boottargets. This was also somehow asked by at least one
> person over IRC some months ago, so maybe I'm not the only one with this
> usecase :) Haven't spent time looking into it and I may never have time
> to do so, take this as a brain dump here :)
>
>
> > To satisfy both needs, I reckon we would need to formally introduce an
> > OpenWrt boot-method to U-Boot, and then U-Boot could leave a mark in
> > /chosen where the uImage.FIT was loaded from, independently of the
> > BootROM which may differ?
> >
>
> Yes, I don't think both could or should be represented by the same proper=
ty.
>
> To sum up, specifically for U-Boot:
>
> BootROM loading VPL/TPL/SPL -> /chosen/bootsource (what this patch is
> suggesting)
> VPL loading SPL -> don't know, haven't checked the VBE series yet :(
> maybe Simon has something in mind?
> SPL loading U-Boot proper -> /chosen/u-boot,spl-boot-device
> U-Boot proper loading kernel/fit/... -> nothing at the moment
>
> Forgot to thank you for sharing what OpenWRT does :)

Thanks for all the details. It seems fine to me. Perhaps you could
copy some of the text above into your binding so there is more detail?

Regards,
Simon
