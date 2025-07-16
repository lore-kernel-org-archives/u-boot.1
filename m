Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B24C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 17:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6438328F;
	Wed, 16 Jul 2025 19:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dP8k8Ds9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342B983249; Wed, 16 Jul 2025 19:00:24 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB65831E1
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 19:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73e64e87d49so37323a34.2
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752685220; x=1753290020; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2A3HND7KMwVdsnco6CprA1JWBPTEZ6dL7aa1jgHYoOU=;
 b=dP8k8Ds9rnCLTBtPjBt5GlCtoKtOCqUoBxqLqitQ3D+ZPYexYFduze6wPBCLLGbfQR
 6uaXcmCRebQL01HKPTZWUAKjxU0takkbwalwLe1Le7Hcsccw49H+rua+6ZhIL36tJ5Gm
 XEngZULHU+dOW0stzJQsN/abIBMiPGZrTCHO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752685220; x=1753290020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A3HND7KMwVdsnco6CprA1JWBPTEZ6dL7aa1jgHYoOU=;
 b=I3orce6N9yDz3qx5VcdgDviJ/Iz7M/GGRdbPSZcpMIVqs8cL41LflBxAek1CsGI3zK
 KgAlNE7QI8B9KuHkR4oJ3nL+kx/Al5o04kf3jUnei33AtQb6hGXrux04yPzL4dOao//M
 XhJTIMYep/GSoMRKVExNyCLbBukv9N9HpH5j0O3LCAKcH75OtprX3F6bkHpItPQbhxW6
 Eju6OKI7uoB9hilj7aL3boxNND/zU2NyO34GGKB2/mxZHsaL3UR8XKJO+KDlvVLEzS7z
 GID2miLiZrgXu2aeSNYyYBj+UBkoogUWOB84BlwytCqFQEvgmMYSBqiCCh0OryiYwibJ
 P6UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcFiScqdDxx8zYCILvts3elFV0DDbaTj/yPn6gK4hMvylQ2eNFJabWQWRvess+S4RtXelfC40=@lists.denx.de
X-Gm-Message-State: AOJu0YzqroXopaIHmjxw2N/sG0gl6UqQHiSc3PrhTIk+0r81/B3njLRY
 bW5OFBZnI/z6bh6VcXgz1AxaXx1b8wAAZU90TZk9cxvP61cUFVxC+SdNhmXicIaBlmM=
X-Gm-Gg: ASbGncvD5ePyT69I+DnL1roDuPVNmdHLwaYkD4LVeTGeJqJZCtVyI/eq7XYFTDYvU8z
 UU2F631T+FFIMy3adzm6vKqEb4P/qi8go12APdSWXfxdV4ip3YbOAxWO+tiqmX6iZNl0/juOGU7
 VN3WKROFK5Mifhmhr5rRWYsnAaCYDWpUaVlXkJRul0AEVpe5+p2FI/bQoMxlFF9ICHVayJsX/NM
 uJV5SKiovnaK5Ldjz89+reEZz5vbSMsZf29pCCouq6lfhYhgwK+XrA93wV6PppodkG2iB9i8w9p
 Y9Yf93L3mCFEnJvtjzpYjDbmqaq2emiBtFl3ouDVtc+nngTv1GlY22+53ygQ4rtmNWuQTSplSDo
 170eoH+Lvq9Zr/w==
X-Google-Smtp-Source: AGHT+IFLr82dY6smgJOv/xbYcOYNorU85i1JXpdYj9/dg2yybfvL86AAs9KyeudUgs/R8IwVbg/1Og==
X-Received: by 2002:a05:6871:88f:b0:2ff:a25a:bf52 with SMTP id
 586e51a60fabf-2ffb2451e83mr2613514fac.19.1752685220392; 
 Wed, 16 Jul 2025 10:00:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff11686f20sm3599892fac.24.2025.07.16.10.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 10:00:18 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:00:15 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Martin Herren <sputnik@on-the-web.ch>, u-boot@lists.denx.de,
 Andreas Schwab <schwab@suse.de>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Green Wan <green.wan@sifive.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rick Chen <rick@andestech.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Wei Fu <wefu@redhat.com>, Yao Zi <ziyao@disroot.org>,
 Yixun Lan <dlan@gentoo.org>, Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: Re: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly
 used value.
Message-ID: <20250716170015.GI193579@bill-the-cat>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
 <9529db2f-ff07-448e-99b4-65dde605b0ec@amd.com>
 <b3f95ac9-a847-450b-9d5a-64af5e84a47e@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JnN+9NnHDCLoIgcX"
Content-Disposition: inline
In-Reply-To: <b3f95ac9-a847-450b-9d5a-64af5e84a47e@freeshell.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 16 Jul 2025 19:00:40 +0200
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


--JnN+9NnHDCLoIgcX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 06:35:17PM -0700, E Shattow wrote:
>=20
>=20
> On 7/15/25 04:27, Michal Simek wrote:
> >=20
> >=20
> > On 7/14/25 15:33, Martin Herren wrote:
> >>
> >> The most commonly used SYS_BOOTM_LEN for riscv is 0x4000000 which is
> >> used in 25 of the current defconfigs.
> >>
> >> The previous default config value of 0x800000 was only used in 8
> >> defconfigs.
> >>
> >> This patch sets the default to this value.
> >>
> >> Command used to get the stats of the used values on RISCV defconfigs:
> >>
> >> ```
> >> grep -l "CONFIG_RISCV=3Dy" configs/* | \
> >> =A0 xargs -I {} sh -c "grep -H CONFIG_SYS_BOOTM_LEN {} || echo
> >> {}:DEFAULT" | \
> >> =A0 cut -d ':' -f 2 | sort | uniq -c
> >> ```
> >>
> >> Changes in v2:
> >> - Resubmit using another mail provider to prevent mangling and signatu=
re
> >> =A0=A0 attachement.
> >>
> >> Martin Herren (3):
> >> =A0=A0 riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
> >> =A0=A0 riscv: Set SYS_BOOTM_LEN default to 0x4000000
> >> =A0=A0 riscv: Remove default SYS_BOOTM_LEN from defconfig
> >>
> >> =A0 boot/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
> >> =A0 configs/ae350_rv32_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv32_falcon_defconfig=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv32_falcon_xip_defconfig | 1 -
> >> =A0 configs/ae350_rv32_spl_defconfig=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv32_spl_xip_defconfig=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv32_xip_defconfig=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv64_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv64_falcon_defconfig=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv64_falcon_xip_defconfig | 1 -
> >> =A0 configs/ae350_rv64_spl_defconfig=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv64_spl_xip_defconfig=A0=A0=A0 | 1 -
> >> =A0 configs/ae350_rv64_xip_defconfig=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/ibex-ast2700_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/k230_canmv_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
> >> =A0 configs/microchip_mpfs_icicle_defconfig | 1 +
> >> =A0 configs/milkv_duo_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | =
1 -
> >> =A0 configs/qemu-riscv32_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/qemu-riscv32_smode_defconfig=A0=A0=A0 | 1 -
> >> =A0 configs/qemu-riscv32_spl_defconfig=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/qemu-riscv64_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/qemu-riscv64_smode_defconfig=A0=A0=A0 | 1 -
> >> =A0 configs/qemu-riscv64_spl_defconfig=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/sifive_unleashed_defconfig=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/sifive_unmatched_defconfig=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/sipeed_licheerv_nano_defconfig=A0 | 1 -
> >> =A0 configs/sipeed_maix_bitm_defconfig=A0=A0=A0=A0=A0 | 1 +
> >> =A0 configs/sipeed_maix_smode_defconfig=A0=A0=A0=A0 | 1 +
> >> =A0 configs/starfive_visionfive2_defconfig=A0 | 1 -
> >> =A0 configs/th1520_lpi4a_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 -
> >> =A0 configs/xilinx_mbv32_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
> >> =A0 configs/xilinx_mbv32_smode_defconfig=A0=A0=A0 | 1 +
> >> =A0 configs/xilinx_mbv64_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
> >> =A0 configs/xilinx_mbv64_smode_defconfig=A0=A0=A0 | 1 +
> >> =A0 34 files changed, 9 insertions(+), 26 deletions(-)
> >>
> >=20
> > I don't mind with these changes. It is just value which can be changed.
> >=20
> > Acked-by; Michal Simek <michal.simek@amd.com> # xilinx_mbv
> >=20
> > Thanks
> > Michal
> >=20
> >=20
>=20
> Is there some reason for the value from documentation about the
> architecture? Or is it arbitrary?
>=20
> I don't really see the sense in a default value which is simply popular
> but not founded in an architectural reasoning.
>=20
> The values do not change often (ever?) so I miss why there is any
> default at all.

So, the default for SYS_BOOTM_LEN isn't so much arbitrary as just no
longer reflective of modern times. It's why there's larger defaults for
ARM64 for example. Likely RISCV should just also use that as the default
and platforms with very small amounts of RAM should stick with smaller.

--=20
Tom

--JnN+9NnHDCLoIgcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh32psACgkQFHw5/5Y0
tyw2KgwAuFeVRxxPTn9e+WvdqOWA6/jEfhkFznBml0uIJIAIUA7gaNWkgxeVy26a
kTixIgS9Ehq3mugsZLbuejjlNPn8/iZAx1+X2Hm2hoqi2HJcLKVBLfSDUuwznxad
J20IK5Yh70e9h3YSnSpPlOYG0EAE79inrPAPcJCeXaSf/mDr4YwcM5o1Ux/6upct
pVTa+5+O0Tp0pKBosgfP6Ib3AKEBIWb+S0ZFaN1egL2T+KBhabRpmreJ0prNW7xC
ChZfgpXErvnefM5UCyptVYwnbrBHiNFxgvcPO9fnfjxAQfeok2i3ldZAWVseHPCw
gS3+AGDrFp6W1be6Kzb06tPFh3gSOgyTx/SG1rDIloZckK3kLzmmFZ6cDIMmTsIc
U8g3xcFmM4+50wm4n8V71DFRdSOotDqstTfO9vL3gYzQsPAIlXbnXOfmZ38olqmM
APgYm92p7lQN89SW4zUOYziOJwPnNCOTN5IqmbrOdn7V6qu+gMLQI2qBLKNuLTvq
eJXO7VMw
=7XHu
-----END PGP SIGNATURE-----

--JnN+9NnHDCLoIgcX--
