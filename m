Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24C3CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F17480325;
	Tue, 16 Sep 2025 16:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZIZG0Hr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE7B83236; Tue, 16 Sep 2025 15:35:57 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60578004F
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=szemzo.andras@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so927106666b.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758029754; x=1758634554; darn=lists.denx.de;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/J04UapWI2FdvEY63Zx7m+nJIgGiy620hLj4nLyFtLI=;
 b=ZIZG0Hr+/3UaPBh0PBexv9nAS7MW9XmEtfQBSza/WBfZ7CotggvjL6Ln4eDz6jc3QC
 nwBuUftU760C4x0AuBwdrKkwgrJSOTW1bA0jEll8MtxtzscML6VWyGuNpV2d/QrKVqcF
 xmfCEPUvSTg2Wp1rkO8IfDoBJ6z/GdHaQP4Mwk8aIUu3ZTmlWXnu1J2PHsxY2R9pS+JV
 Ad7zWWEwZlTAshceUdGtDEjRrwGtLFJKPV+y0RcE1dl7LWTnYUu4mptXm1rxkNtyRRtf
 uA2+XmmwKa14v5XKw2J6x9pY3ZgX47srbaxBoEGNDXJRutbHZ2zapxhrAItWil2q1LA7
 hrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758029754; x=1758634554;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/J04UapWI2FdvEY63Zx7m+nJIgGiy620hLj4nLyFtLI=;
 b=Ihs4Xd+obYD4doBLIqqtULRAMsMOCCSwSDDOtpfcTndAu95ui/Wjx9M5DRY3Cknjif
 lrC92Y8wjrNS+rolBYNPGvBW8PoOxlgqkm9CD486bW0zuzxEO9zi1/v74PPI10GkFcxv
 mGOW+FF55U7ymhQhQEGwnRTH00QlKjo+XkCa8B+i61jvCdqLvNQkUtJC4N+tKRNVYd7u
 +FRY8j9Ds125euZL/p9f7UcYbg+r6FZjMZbGf6iopVoQwGXiU408HnwwMOBRMb7B/8rE
 MvzqMRXurz+NrpnBkaMtFEI1IJlNI8RMWWRvgJ+HgUguX4ZDO/1bffzvLojrEgIVc+sa
 Lurg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrAvkUnLa4yo7Gy4vFeyRRR7cnqgcS9TN4YrkHgn2Eftm6CjmwCVoujiJNZ06Z4b+2WmX2C2s=@lists.denx.de
X-Gm-Message-State: AOJu0Yyluqy1WiIGfA0jD5ifSbXjVp1UlqT634UxwYaUPEH/z3OT/q6V
 dOM2WODzyKzTdSfrmU79UwGpAIJUapjHniFofTXqrqhTDYEBzfkIS8bG
X-Gm-Gg: ASbGncuwohBn/VNUYIN59S3mEPpCJmTLAh3jQjGXxvPFJzx+j5vsDK3TAVU6EkVv36x
 KoXJrnjJSwLjy2H17q831iq+VP64SKrc+q3UtAst4osj55hmilOhPRkSxvbm4qJR6V6JcXBzXcX
 gFBhVKw2J47hxjw3GMYK6yTj/6oXmflHNpdoI3kFXrv3FmsH9NeOisJpnOXojo0Ck8siZxvFFQI
 o6Brx2OvHx7Q8q2VCgjOgYJC5iJT4nV9tei8GXDDCM/oENrBMxrzqrZKBug1xGlWdESixG/PwR5
 5CCDLz8wQV+aY2U2kqQtFjEUyw+jfpazoeYvxYd1J+Ht5IuJw/g6UbRWvATobnDZd/oowqRu/7B
 yGAysRGhzOBgPJsZ8jrH9TkTaX8iFTCT2HR0+ADhYTZshCOFsB0VBSIgs0voSRGRQsg==
X-Google-Smtp-Source: AGHT+IE2xcYp3KB8o6LZkSmtT/XRvgW8z+8vm9peFmryVjFu/LV+VCJJwaZ2rw2yq+66JUP/hPTLZA==
X-Received: by 2002:a17:907:3f99:b0:b10:1af1:dc2a with SMTP id
 a640c23a62f3a-b101af1dce3mr774107366b.38.1758029753763; 
 Tue, 16 Sep 2025 06:35:53 -0700 (PDT)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32dd601sm1151309266b.60.2025.09.16.06.35.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Sep 2025 06:35:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 1/1] sunxi: extend R528/T113-s3/D1(s) DRAM
 initialisation
From: =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
In-Reply-To: <20250915163637.38d05aab@donnerap>
Date: Tue, 16 Sep 2025 15:35:42 +0200
Cc: Lukas Schmid <lukas.schmid@netcube.li>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <974306F8-B297-4DCD-A827-129651271935@gmail.com>
References: <20250914144411.157826-1-lukas.schmid@netcube.li>
 <20250915163637.38d05aab@donnerap>
To: Andre Przywara <andre.przywara@arm.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Mailman-Approved-At: Tue, 16 Sep 2025 16:12:14 +0200
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



> On 2025. Sep 15., at 17:36, Andre Przywara <andre.przywara@arm.com> =
wrote:
>=20
> On Sun, 14 Sep 2025 16:44:11 +0200
> Lukas Schmid <lukas.schmid@netcube.li> wrote:
>=20
> Hi Lukas,
>=20
> thanks for the patch!
>=20
> CC:ing the sunxi list and Andr=C3=A1s, who I think has some T113-s4 =
device as
> well.
>=20

Thanks, but unfortunately I don=E2=80=99t have a board with T113-S4.=20
So awboot was not tested with this SoC, at least by me.

> It would be good to see some Tested-by: tags, but otherwise the patch
> looks good, I'd say.
>=20
> Also I hear that awboot uses 0x6800 as the chip ID for the -s4, can
> someone shed some light on this?
>=20
> Cheers,
> Andre
>=20
>> Extend the DRAM initialisation code to add support for the T113-S4 =
aka
>> T113M4020DC0 by checking the SoC's CHIPID.
>>=20
>> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
>> ---
>> drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
>> drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
>> 2 files changed, 19 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c =
b/drivers/ram/sunxi/dram_sun20i_d1.c
>> index a1794032f3b..01d19d5feaa 100644
>> --- a/drivers/ram/sunxi/dram_sun20i_d1.c
>> +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
>> @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t =
*para)
>> clrsetbits_le32(0x3000150, 0xff00, reg << 8);
>> }
>>=20
>> +static u32 sid_read_soc_chipid(void)
>> +{
>> + return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
>> +}
>> +
>> static void dram_voltage_set(const dram_para_t *para)
>> {
>> int vol;
>> @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const =
dram_para_t *para,
>>=20
>> fuse =3D (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
>> debug("DDR efuse: 0x%x\n", fuse);
>> + debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
>>=20
>> if (para->dram_type =3D=3D SUNXI_DRAM_TYPE_DDR2) {
>> if (fuse =3D=3D 15)
>> @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const =
dram_para_t *para,
>> switch (fuse) {
>> case 8: cfg =3D ac_remapping_tables[2]; break;
>> case 9: cfg =3D ac_remapping_tables[3]; break;
>> - case 10: cfg =3D ac_remapping_tables[5]; break;
>> + case 10:
>> + if (sid_read_soc_chipid() =3D=3D SUNXI_CHIPID_T113M4020DC0)
>> + cfg =3D ac_remapping_tables[0];
>> + else
>> + cfg =3D ac_remapping_tables[5];
>> + break;
>> case 11: cfg =3D ac_remapping_tables[4]; break;
>> default:
>> case 12: cfg =3D ac_remapping_tables[1]; break;
>> diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h =
b/drivers/ram/sunxi/dram_sun20i_d1.h
>> index 91383f6cf10..7bd8f67a77a 100644
>> --- a/drivers/ram/sunxi/dram_sun20i_d1.h
>> +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
>> @@ -19,6 +19,13 @@ enum sunxi_dram_type {
>> SUNXI_DRAM_TYPE_LPDDR3 =3D 7,
>> };
>>=20
>> +enum sunxi_soc_chipid {
>> + SUNXI_CHIPID_F133A =3D 0x5C00,
>> + SUNXI_CHIPID_D1S =3D 0x5E00,
>> + SUNXI_CHIPID_T113S3 =3D 0x6000,
>> + SUNXI_CHIPID_T113M4020DC0 =3D 0x7200,
>> +};
>> +
>> /*
>>  * This structure contains a mixture of fixed configuration settings,
>>  * variables that are used at runtime to communicate settings between
>=20

