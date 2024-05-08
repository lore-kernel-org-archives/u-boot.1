Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3781C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 23:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CEC88113;
	Thu,  9 May 2024 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQ8KB6R1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A40288285; Thu,  9 May 2024 01:11:36 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC3887EF5
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 01:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4df344eecd7so127324e0c.3
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715209892; x=1715814692; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+vNBLORhK32IGSJ40CTmVhaaZz20aMZK9ZkS5fQ05U=;
 b=gQ8KB6R1dx+TL+29721olCE5gZGajB3wW3nCtYPC8NfUIOeJPyRwnBI/xs+ulWBXF6
 klRbsxeMH/lkDyKYFHYudxuzF1RnfNpDyAAp5hVI+wDdRU8csaU9929SYFEJDjfPfmff
 MVnfwEM4+rW+ev0Txd8ZzUP7Q2Vu/qRSkVlEjvPAV7f4dEkLfWOEXPNmHz2p2k1hZ0o9
 ZUPNAx/nIqQFIEB4fV3gqKB/mcA91mMQEpOcO/fnORmiy1mw1JQJy1S4KRTTu6yAUxMd
 ZmqgJlG1q0IGpKDwMzDY7BB3un+KiRIspxvVG49cZcDyrhbIgXv7DAVF1nJMtP14hlvb
 Wq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715209892; x=1715814692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+vNBLORhK32IGSJ40CTmVhaaZz20aMZK9ZkS5fQ05U=;
 b=HU8XBDz5sGQA9CwWWevB7uDYpOmSr9XSW4SuMKev7rgFVoRdBDanQZRkCyMToDV6pJ
 urEqhGVUOUc/mCAsHBAuTx5/fYyA3RbluIfsxeXfNFQ7RZn6XJEBGGKgAt6fVp6aydHF
 IzAwoOGJlel7Fkp5qkKPtbVnJZyKhZzMXeddyLliWgDLPRJw02ZdzthHVW9UElhpRiPr
 DHWHiqPa/2g7wWnGm0Q7eYwTkJxTErjzpJusKnnCWfYA+40oswQ5gk3eg/2fcXBtVcx4
 5vJhlUMlWXmJI9zHnjFo3xUEjvD7+zMojzqOawPV0MynHq2KGSANXOmt8f8F98P1M0/E
 gwYg==
X-Gm-Message-State: AOJu0YzVpMqQBEXSbn4Z9nWLtWcBbD9yhVD49Nm0DhhZHLtEGN0d8z55
 0PCnCq2+euJzjQTsj3L2NBQw858EDeHjXyXZG3L0D/2hm4f3Gl8l2MBNOejanqNeEk5IZVy7BUR
 LB3UMJHLsnnxnEgXGtRxcdh2qWJI=
X-Google-Smtp-Source: AGHT+IHSg8TzhRA90BriOHo6iZtSRfgL2PBW/Tf0oj/MuL7GoA9b4BoMp4NXhAJWZkB2V/Me0I4+bRWsqwcBtz5ID14=
X-Received: by 2002:a05:6122:1346:b0:4da:a82e:95f5 with SMTP id
 71dfb90a1353d-4df69150c04mr4068932e0c.5.1715209892494; Wed, 08 May 2024
 16:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <9UKxZxvyW2p7WWu5KwPIVoiFveSPOTEAzCVemUccLIb70r8QO7ch2PAiwVf428TC-7K9HDSO26ShohI0gnI4C671Plwa0M1CuwclJt3xJEc=@protonmail.com>
In-Reply-To: <9UKxZxvyW2p7WWu5KwPIVoiFveSPOTEAzCVemUccLIb70r8QO7ch2PAiwVf428TC-7K9HDSO26ShohI0gnI4C671Plwa0M1CuwclJt3xJEc=@protonmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 8 May 2024 16:11:20 -0700
Message-ID: <CANV2PTNrCsngRxSbdMoaS9n4mLZxjB8O=iWNRHLZ2uXE_0WBhw@mail.gmail.com>
Subject: Re: [PATCH] board: starfive: support Pine64 Star64 board
To: H Bell <dmoo_dv@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Pine64 Star64 8GB (May 2023 order date: "Star64 v1.1" silkscreen)
by contributor Tenkawa (contact info withheld so posting on their
behalf and listing myself in the tag). Other than the inconclusive
networking result (for discussion via code review) it seems to have
basic functionality.

# mac
Vendor : PINE64
Product full SN: STAR64V1-2310-D008E000-00000005
data version: 0x2
PCB revision: 0xc1
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:75:61
Ethernet MAC1 address: 6c:cf:39:00:75:62

# mmc info
Device: mmc@16010000
Manufacturer ID: 15
OEM: 0
Name: BJTD4R
Bus Speed: 52000000
Mode: MMC High Speed (52MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 29.1 GiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 8 MiB
User Capacity: 29.1 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

# mmc dev 1 ; mmc info
switch to partitions #0, OK
mmc1 is current device
Device: mmc@16020000
Manufacturer ID: 1b
OEM: 534d
Name: GD2S5
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 119.4 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes

# # Silkscreen: Upper=3DA Port
# env erase;env load;env set bootcmd 'dhcp;net list'; env save; reset
ethernet@16030000 Waiting for PHY auto negotiation to
complete......... TIMEOUT !
phy_startup() failed: -110
FAILED: -110
ethernet@16040000 Waiting for PHY auto negotiation to complete....... done
BOOTP broadcast 1
BOOTP broadcast 2
DHCP client bound to address...
...
eth0 : ethernet@16030000 6c:cf:39:00:75:61 active
eth1 : ethernet@16040000 6c:cf:39:00:75:62

# # Silkscreen: Lower=3DB Port
# env erase;env load;env set bootcmd 'dhcp;net list'; env save; reset
ethernet@16030000 Waiting for PHY auto negotiation to
complete......... TIMEOUT !
phy_startup() failed: -110
FAILED: -110
ethernet@16040000 Waiting for PHY auto negotiation to complete....... done
BOOTP broadcast 1
BOOTP broadcast 2
DHCP client bound to address...
...
eth0 : ethernet@16030000 6c:cf:39:00:75:61
eth1 : ethernet@16040000 6c:cf:39:00:75:62 active

Some dropped network packets were observed with the test setup:
Approx  6% packet loss on Upper=3DA Port
Approx 71% packet loss on Lower=3DB Port.
The test network was not known to be reliable and might have
introduced other sources of error. No comparison was available to any
other firmware releases.

Tested-by: E Shattow <lucent@gmail.com>

On Mon, May 6, 2024 at 8:30=E2=80=AFAM H Bell <dmoo_dv@protonmail.com> wrot=
e:
>
> Similar to the Milk-V Mars, The Star64 board contains few differences to =
the
> VisionFive 2 boards, so can be part of the same U-boot build.
>
> Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
> Cc: ycliang@andestech.com
> Cc: heinrich.schuchardt@canonical.com
> ---
>  board/starfive/visionfive2/spl.c              | 52 +++++++++++++++++++
>  .../visionfive2/starfive_visionfive2.c        |  4 ++
>  2 files changed, 56 insertions(+)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index ca61b5be22..b8d29a02af 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -226,6 +226,56 @@ void spl_fdt_fixup_version_b(void *fdt)
>         }
>  }
>
> +void spl_fdt_fixup_star64(void *fdt)
> +{
> +       static const char compat[] =3D "starfive,star64\0starfive,jh7110"=
;
> +       u32 phandle;
> +       u8 i;
> +       int offset;
> +       int ret;
> +
> +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat,=
 sizeof(compat));
> +       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
> +                          "Pine64 Star64");
> +
> +       /* gmac0 */
> +       offset =3D fdt_path_offset(fdt, "/soc/clock-controller@17000000")=
;
> +       phandle =3D fdt_get_phandle(fdt, offset);
> +       offset =3D fdt_path_offset(fdt, "/soc/ethernet@16030000");
> +
> +       fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
> +       fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_=
GMAC0_TX);
> +       fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
> +       fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
> +                          JH7110_AONCLK_GMAC0_RMII_RTX);
> +
> +       /* gmac1 */
> +       offset =3D fdt_path_offset(fdt, "/soc/clock-controller@13020000")=
;
> +       phandle =3D fdt_get_phandle(fdt, offset);
> +       offset =3D fdt_path_offset(fdt, "/soc/ethernet@16040000");
> +
> +       fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
> +       fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_=
GMAC1_TX);
> +       fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
> +       fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
> +                          JH7110_SYSCLK_GMAC1_RMII_RTX);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(starfive_verb); i++) {
> +               offset =3D fdt_path_offset(fdt, starfive_verb[i].path);
> +
> +               if (starfive_verb[i].value)
> +                       ret =3D fdt_setprop_u32(fdt, offset,  starfive_ve=
rb[i].name,
> +                                             dectoul(starfive_verb[i].va=
lue, NULL));
> +               else
> +                       ret =3D fdt_setprop_empty(fdt, offset, starfive_v=
erb[i].name);
> +
> +               if (ret) {
> +                       pr_err("%s set prop %s fail.\n", __func__, starfi=
ve_verb[i].name);
> +                               break;
> +               }
> +       }
> +}
> +
>  void spl_perform_fixups(struct spl_image_info *spl_image)
>  {
>         u8 version;
> @@ -252,6 +302,8 @@ void spl_perform_fixups(struct spl_image_info *spl_im=
age)
>                         spl_fdt_fixup_version_b(spl_image->fdt_addr);
>                 break;
>                 };
> +       } else if (!strncmp(product_id, "STAR64", 6)) {
> +               spl_fdt_fixup_star64(spl_image->fdt_addr);
>         } else {
>                 pr_err("Unknown product %s\n", product_id);
>         };
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/st=
arfive/visionfive2/starfive_visionfive2.c
> index a86bca533b..93bc8b5c55 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -23,6 +23,8 @@ DECLARE_GLOBAL_DATA_PTR;
>         "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>  #define FDTFILE_VISIONFIVE2_1_3B \
>         "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
> +#define FDTFILE_PINE64_STAR64 \
> +       "starfive/pine64-star64.dtb"
>
>  /* enable U74-mc hart1~hart4 prefetcher */
>  static void enable_prefetcher(void)
> @@ -78,6 +80,8 @@ static void set_fdtfile(void)
>                         fdtfile =3D FDTFILE_VISIONFIVE2_1_3B;
>                         break;
>                 }
> +       } else if (!strncmp(product_id, "STAR64", 6)) {
> +               fdtfile =3D FDTFILE_PINE64_STAR64;
>         } else {
>                 log_err("Unknown product\n");
>                 return;
> --
> 2.44.0
>
