Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD81AC54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 06:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDF19407A8;
	Thu, 30 Jul 2026 06:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1M6topIZqWA; Thu, 30 Jul 2026 06:25:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E1A1407C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785392750;
	bh=pZxRhIqFcx0flLTKdoVmfsAbbiL3Cz1hyeM5LPGjZCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d3+VpiiNzJqcA9bs2Wmkek+aIgFyeKsjgoFfINEL5V9dwII7SESgqRTDV+EOaQVed
	 xNdwvoSVDWld5DVj7Uq1dFR5FqOTkXgx0xsBNvDKNFanBs6yp15FAkVwnu0IcKqMQD
	 qLD6KoeooSruyFH5IxmR5bnY+DM9dkH26D1HG9NpAoGX8PR4U+LW7vakCFxN5xc5eJ
	 lWHMkftYvydBSm2gRJj5wj7OY4z0KSYU549injiDMPHVk1dZK6RDzvf0FRgLFoEH28
	 7jGj9PiEkEtGld4/kg3UmsbJdmLgPmUsLENnIgzVUtETxJTj57forVxgxupWIqmxB1
	 yLNGniJ0frY4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E1A1407C9;
	Thu, 30 Jul 2026 06:25:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEB83350
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A04B260744
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_09NzZCiMJc for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 06:25:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9E2836071B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E2836071B
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E2836071B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:25:47 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5b2aa3be376so1292521e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 23:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785392745; cv=none;
 d=google.com; s=arc-20260327;
 b=rkSOpXOi7K73iuX7vcpjDuifF79LRLKrN32D7QiZi5xbs3qHNxCE+eDY5aTtIspvT3
 A35W5Vox47IskiGPM2/eSe0cwF5r+rDbAKEBBQ7cONNvyqtv1dCuAeLXSpU6q4S4Axwi
 5yE1BjF3khRQKI2HRb0zb9rEay2UChpP3NDbkSfXBROpEg1w41hkwErbQNJeJ5+M8PxI
 b/G94aFaUq8JqUnyMukxJfrBvSl0ysZ1Ed+4aMdbbXbd2+kVOeTe0N7RVVMEwMRUadfi
 TC8UT1wsWEKaf/pitcFOa6b9fs4/veg6SbusjeYottPlWGsFs6ClkAwlwFikwhMBuvDE
 WA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pZxRhIqFcx0flLTKdoVmfsAbbiL3Cz1hyeM5LPGjZCQ=;
 fh=RVAAfhPpXxI+YhVWFlTBaPEEioMYk13422eDVu7CAYg=;
 b=QKAJSqnaMJcYYI8zfg9LGUOdruzIEhCELUtPi5uKP/Z8x5s1LhW1eXVFXeD01IhpC4
 Uy32jN4oVQiWkQCrNRkNOnBX+Hcl8sod0Ia1C7kTaJW66pG/A5BdKa3hwKYyC3qGGkfq
 K8+sxW3loejCMpGV6COYsKGEzgREL4BVHl3Rn+r2U+TPGhybJHXq67v8MNTQb1xRuIr+
 tw3hAuj5QbVISFHingimijWXTThafnFIxzvIf9Sabo2PHgDrxv36cAILNnC4puGkd4M6
 Xu5lLZ++Auv0PvMkttZRcEOGiDAp8XXdNY+5O6+ZYP6EYUwymAaG/jQbarzmXqh/BkzP
 HwZQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392745; x=1785997545;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pZxRhIqFcx0flLTKdoVmfsAbbiL3Cz1hyeM5LPGjZCQ=;
 b=UIu5T8+lBjP39CAffcxbVZASmmBcgjs1khfkWO+shdk0aT63rFjLkEs0IipdzFY0fi
 TRQUnd4qH6M3mhgraeMIE3rPhjgmS2vEp1GXpJKi7qJ9hZQR84AqsCIMaoA1RWD+710h
 Hla1qvJN2QAR/R67teT+05L0Jm98jZX4SRvFRdpIoxTBQHTekCeEVfNVYydzSDyHyHBQ
 LdUqbsQPKx05Nol/pEwlvZedDaNLFu33LKNo3xLO9dFqPBsBX68zHgF5L13PukevwlT/
 1MpA2YvIRgrs2WxwZ6VPvwpc/m/zgOuH09xFUsUf/vCTByhXHn0ScM6VZ6yROD/kFBBs
 fmMw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8TnMfvovK5l8GGujQVyPRrYWPpn/G5ikJg/oEBb93SPTKwAPz7JpKMGFDF+B3zAUymeMVR68=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxgcmyHEKNf9izhuBoxb+2Z1adQfez14/vxTlLT21Abg6+f+6gF
 TDJbIOBT30u9ObE9D+e2osJm8lXXmk14Zy3vWTK9wKT3RGs9HLMSvHwNEKbllxJPnqWSrvwsRi6
 Si8bwOnLvZv6JxDR/J08e6F/aD03hTtORD5p+CQphnPbIE8sueF5RIpmRSg==
X-Gm-Gg: AR+sD136aTdg98MGIQAJI7v7LfM2163KDD6TTC1SmZ36dSXoyyT+byMGHgNF+x5oytF
 bhr9KH51pcXW8RoPBaopnAmFOzkquzaxHfIGhxREKFCjprh6O3JvpPlCwsi++UyAExZkLcUSGhy
 pCSvaNoJlPgu/7txe2P/H2kKh3nP2O+wP9kyPNWQ43RNtBTKqaOla4xyOVsAE/QoZgMytbUe7P+
 zYI2CkeMKGVrPep2vqXSkNQJu6TUw0KxgI/4UObST5n++VEKh3GujkvWyamP8zQituJQZAqmVvB
 dSAMW9zQhvLw4RoblF74bsNnFzRk6gdUhDA31iUpUTZCiymUPmieOwP57jRVk29QkVCM5KYxiqG
 0k6NIKoA3QRZ4DnxxSQbjKFjl/AYV7SdRo0TGeDS5UBKDt2wxPY1oEFu6qZt5vC0VnbMjns20SK
 /WWA==
X-Received: by 2002:ac2:4bc8:0:b0:5ae:b792:7f1e with SMTP id
 2adb3069b0e04-5b2db36e8e2mr262047e87.30.1785392745057; Wed, 29 Jul 2026
 23:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-9-2f58566d48ca@riscstar.com> <ameUvEoCHjeygBEd@pie>
 <CAH22mJy8_gd2V_DFUT0DQYiBSO6B3u5aX-V=uD20v0G+m1cArw@mail.gmail.com>
 <amh6JjTtUhi57H-b@pie>
 <CAH22mJwL+Op+99iBTePTkdGfArRy_inFRXm=DJjG-jJ=sYEi2g@mail.gmail.com>
 <amoc8umyQwc6UmXl@pie>
In-Reply-To: <amoc8umyQwc6UmXl@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Thu, 30 Jul 2026 14:25:31 +0800
X-Gm-Features: AUfX_my0_YZgU_mcdh1dTybOOu6l5Kq3rZyc02wllrIep-VfNo-JkZb6GFimblQ
Message-ID: <CAH22mJzjH2d6bd+HQhhkCiOYSr9cqYFZDCpB7zECaFPMZHBdVQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] doc: spacemit: flash on K1 SoC based boards
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785392745; x=1785997545;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pZxRhIqFcx0flLTKdoVmfsAbbiL3Cz1hyeM5LPGjZCQ=;
 b=x54K8HWXY4nLQFpb9fvOGuTOt07fVH83ugY9RR+7LwPc3IERSJV/IVAa7FkpADxa13
 9jeZ+yUu+bANtO1pyXPJSPIQ7Ly+PPakEHFs/l9ca0nj+ByDYd3Ql9qMRsCPafVagCNL
 hheJJ+dfIhiVxWH3OQeObBCc29tQjxs7mj0675jAVW0w/kGA1Dp83+K0uHwZviU+kIeY
 jurklNYRIVD32s5zpfmjidzo2jwg/zMiSxdV7JsJXhi+jXDFKhd8lUQuQB5MtbSyCmva
 cqMq6/5BqdVRgdPXExpeKNZWnTTqcjh64dNdPMHLkKe+VwkmFnNo5/k99lEmONBoimI3
 9SkQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=x54K8HWX
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jul 29, 2026 at 11:33=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Wed, Jul 29, 2026 at 09:49:26PM +0800, Eric Chung wrote:
> > On Tue, Jul 28, 2026 at 5:45=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Tue, Jul 28, 2026 at 08:53:02AM +0800, Eric Chung wrote:
> > > > On Tue, Jul 28, 2026 at 1:26=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> > > > >
> > > > > On Mon, Jul 27, 2026 at 02:59:11PM +0800, Eric Chung wrote:
> > > > > > Add document on how to flash images into eMMC of K1 SoC based b=
oards.
> > > > > >
> > > > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > > > >
> > > > > > ---
> > > > > > v3:
> > > > > > - Add document on how to flash images into SD card.
> > > > > > ---
> > > > > >  board/spacemit/k1/MAINTAINERS |   2 +-
> > > > > >  doc/board/spacemit/index.rst  |   1 +
> > > > > >  doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++++++=
++++++++++++++++
> > > > > >  3 files changed, 322 insertions(+), 1 deletion(-)
> > > > >
> > > > > ...
> > > > >
> > > > > > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit=
/k1-mmc.rst
> > > > > > new file mode 100644
> > > > > > index 00000000000..b0fe78c75ce
> > > > > > --- /dev/null
> > > > > > +++ b/doc/board/spacemit/k1-mmc.rst
> > > > > > @@ -0,0 +1,320 @@
> > > > >
> > > > > ...
> > > > >
> > > > > > +Chapter 2: SD Card Boot
> > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > +
> > > > > > +
> > > > > > +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Gu=
ide
> > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > +
> > > > > > +This guide explains how to prepare a bootable SD card with Bia=
nbu OS for
> > > > > > +SpacemiT K1 based boards and how to replace the U-Boot binary =
on the SD
> > > > > > +card with a custom build.
> > > > > > +
> > > > > > +Prerequisites
> > > > > > +~~~~~~~~~~~~~
> > > > > > +
> > > > > > +- A SpacemiT K1 based development board
> > > > > > +- A microSD card (at least 8 GB capacity recommended)
> > > > > > +- A card reader for your host computer
> > > > > > +- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` comman=
ds)
> > > > > > +- The Bianbu SD card image from
> > > > > > +   <https://spacemit.com/community/resources-download/Images%2=
0Collects/K1/Bianbu>
> > > > > > +- A custom ``u-boot.itb`` file (device tree blob or U-Boot FIT=
 image) to be
> > > > > > +  written to the U-Boot partition
> > > > > > +
> > > > > > +Prepare the SD Card & the image
> > > > > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > +
> > > > > > +**1. Download the image**
> > > > > > +
> > > > > > +Download the released package from the official SpacemiT websi=
te:
> > > > > > +
> > > > > > +<https://archive.spacemit.com/image/k1/version/bianbu/v2.3.5/B=
ianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
> > > > > > +
> > > > > > +**2. Extract the image**
> > > > > > +
> > > > > > +.. code-block:: console
> > > > > > +
> > > > > > +   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.=
zip
> > > > > > +
> > > > > > +**3. Identify the SD card device**
> > > > > > +
> > > > > > +Insert the microSD card into your card reader, then run:
> > > > > > +
> > > > > > +.. code-block:: console
> > > > > > +
> > > > > > +   $ lsblk
> > > > > > +
> > > > > > +Compare the output before and after inserting the card to iden=
tify
> > > > > > +the new device. It will typically appear as ``/dev/sdb``, ``/d=
ev/sdc``,
> > > > > > +or ``/dev/mmcblk0``.
> > > > > > +
> > > > > > +**4. Write the image to the SD card**
> > > > > > +
> > > > > > +.. code-block:: console
> > > > > > +
> > > > > > +   $ sudo dd if=3D./Bianbu-Minimal-K1-sdcard-V2.3.5-2026060118=
0942.img of=3D/dev/sdb bs=3D1M status=3Dprogress
> > > > > > +
> > > > > > +The SD card is now ready as a bootable Bianbu system disk.
> > > > >
> > > > > This looks out of scope of describing how to create a bootable SD=
 card
> > > > > with U-Boot. In my opinion, you'd better describe the requirement=
s of
> > > > > parition layout and image position for SD-card booting, to allow =
readers
> > > > > to create their own images/bootable medium from scratch more easi=
ly,
> > > > > instead of sticking to the vendored image.
> > > > >
> > > >
> > > > Creating a bootable SD card from scratch would be valuable, but I'l=
l address
> > > > it later due to time constraints.
> > >
> > > In case I didn't make myself clear enough, the documentation *SHOULD*
> > > describe how to create bootable devices from scratch, instead of
> > > alternating an existing OS image to use mainline U-Boot. I don't thin=
k
> > > the current documentation helps much for downstream users/distributio=
ns
> > > to adapt U-Boot for their own use cases, or at least it could be writ=
ten
> > > in a much more clear, vendor-neutral way.
> > >
> > > So here's my NAK for this patch. I'm not sure what you mean by "time
> > > constraints", but please keep submitted patches in a good shape.
> > >
>
> In case that I still didn't make myself clear enough, by "bootable SD
> card", I mean a minimal medium with only a bootable U-Boot, you could
> refer to Rockchip or StarFive's documentation.
>

I checked Rockchip or StarFive's documentation. And I can't find any mentio=
n of
creating a bootable SD card.

> > I=E2=80=99m not sure why the documentation insists on walking users thr=
ough creating a
> > bootable SD card from scratch, especially when, at this stage, it
> > still depends on
> > the vendor=E2=80=99s tools.
>
> Please explain which tools it depends on. Now U-Boot for your platform
> already has its SPL ported, and according to your instructions of
> replacing the vendor U-Boot, it seems no extra post-processing is
> required for the SoC to identify it.

The flashing process must begin with a USB transfer. The vendor's
proprietary tool is required to download the images to the target
device. To maintain compatibility with this tool, I need to use the
same partition table that it expects.

Currently, the SPL (Secondary Program Loader) only boots U-Boot; it
has no other function in the boot flow.

>
> And after re-reading the documentation, it seems you don't make use of
> the upstream SPL when creating the SD-card image, is this intended, and
> why?
>

Oh, I missed it. I need to append SPL part.

> > In practice, we=E2=80=99re required to use the vendor=E2=80=99s
> > flashing tool for
> > both eMMC and SD devices,
>
> Please explain the constraints, it's okay to depend on vendor's tools,
> but for creating a SD-card image, I couldn't come up with a reason to
> do so, at least by inferring from the current documentation.
>

I=E2=80=99m required to use the vendor=E2=80=99s flashing tool, flashserver=
, for
programming SD card images =E2=80=94 mainly because it=E2=80=99s the only w=
ay I can
properly program the RPMB partition.

The tool supports both eMMC and SD boot modes, and environment
variables (ENV) can be stored on either medium. However, it would be
unusual to boot from an SD card while loading the ENV from eMMC.
Therefore, the simplest and most consistent approach is to keep the
same partition layout across all critical components =E2=80=94 including FS=
BL,
ENV, and OpenSBI partitions =E2=80=94 regardless of the boot medium.

> > and we must adhere to the provided partition table.
>
> Thus please clearly describe which part of the partition table must be
> preserved for the SoC to boot.
>

Mentioned above.

> > If users prefer to define their own partition layout, nothing prevents
> > them from doing
> > so on their own. That=E2=80=99s entirely up to them.
> >
> > The default SD image already includes the vendor=E2=80=99s U-Boot. My
> > instructions simply
> > explain how to replace it with the upstream version=E2=80=94nothing mor=
e.
>
> Best regards,
> Yao Zi
