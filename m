Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9BCCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A1584565;
	Fri, 28 Nov 2025 15:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQFji8/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1698457A; Fri, 28 Nov 2025 15:34:17 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E11A84564
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5957e017378so2224694e87.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764340454; x=1764945254; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0bMkG9X8SZpZzoyqdXtQUomPXZ2hOrt7ssU+L92bgY=;
 b=LQFji8/xwgqj0nChofG5bwRrMKwEKv21wNKKY+mHmm2qo9l4m6Q+n0gsLqS1c0Nfjw
 mUrI7c6TANLE9u56EqChzVBxzHJxipiC0wwyXhwDkwBrs0r3BuGxqyJpi47Vx0970NUd
 Z7KYBIm2CbOfLuCbIx5C/DRp310u4pbu/ybKCzFbnwzdvmuowSP46tDG1FQTr1r8PBOD
 tQo6ijjhg0ZmERtkq3sFzLxKWhIM7HMxofWVzrCndza78ySDN96IY1DCV2Iix0TfIwxq
 UXX430SAMQ/INSiJ4wUSIRV2EknnreTgFW0JXcR0uXnPTgb0+WR6JU7n2KFcmW9tWJsa
 RlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764340454; x=1764945254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U0bMkG9X8SZpZzoyqdXtQUomPXZ2hOrt7ssU+L92bgY=;
 b=so4aWtvU2w1qyMRowtBuRZl+cdZ3Y123hstQ4sj9qzNHyWrtnJSDbzVHEYEozpMdXE
 b98EdSijXuGmWHFxz6lI+j48hI2Gm/gRW/Zq5XR/2oQ4/gDJfKH/wi/EW6VBLODetDFN
 1VinLEdntMaTK6FiDqyquGlTGG0P5BCcY8h2RiDIucsv6CPsY+eaO2+wbaGiA7QzJ0Ih
 w/Ofy+++nfTi9aTTJ5M/l2B8XlcvGzMpCM6sq8MS09A3StOx8JV7JyLvzMhIzp08Haif
 tU8ysNl6/URcL5erfXEr4mr2JVbCxv+/dR+PtPmtuoX8hwhNOx0I/MBGQhv7WlfHfGTZ
 7log==
X-Gm-Message-State: AOJu0YxwQY0CxXW6Wkby4awM6xWUBqYqTWWlkxezlk3sQ6AUKJSQOWIU
 kbpj+pK/tqaY2VJYSRP8Aw64kBNHHjmylfvgrFDFmfb3dYz0Z6pSgR1+YTu0vU6GZXxnteiGauZ
 FZwL+IXFVeMAzedlUK6b8EEgGkv/pgnU=
X-Gm-Gg: ASbGncuIhLVhBtj/321GIkTfyrs1xfqA2H+nqsMsrHOG2fTgvyabQPyDvbOefEQJfqv
 dc86GRQIQOHvDMOTH/ozNHmEEIJAH3VA+fRrR+BKbdHNzdZIs5ljwErC9ufR41XoKNe0rPrkIQ2
 B3x+mhpkuF9IO3wu6no1EDbnUc81wVyrTW1nIRw+e/GtXxhYNoNvdQFfQgjXlrE+hqEMwOh230C
 f/CaUtmKyAKpFXeWznoHr8lOsA2Lg3kTIwFi/K3KWdHKBGc1CuwtesMemWrdxKkk6SFoDMYlOVC
 thYhvNBeX5Komken9vkPSLw+5g==
X-Google-Smtp-Source: AGHT+IElOt33ZSpOMI4fpHXFAuGoYku6MEVInjHx81dvhVyLt3mN2bTUrWHEq96iJYBe1+LgPY965PpwTXvx2Nv2EYE=
X-Received: by 2002:a05:6512:1383:b0:591:c346:1106 with SMTP id
 2adb3069b0e04-596a3eb5c4dmr10474128e87.9.1764340454014; Fri, 28 Nov 2025
 06:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com>
 <20251128-topic-am33-evm-lcd-v2026-01-v1-1-ef75d4330d3d@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-lcd-v2026-01-v1-1-ef75d4330d3d@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Nov 2025 11:34:02 -0300
X-Gm-Features: AWmQ_bk9EwTPxZlhtLWx9oPrrDwLZC3QY9ntMYrkd-Iwx6s-lwS3v-fYfXZcYbM
Message-ID: <CAOMZO5A=o-VM=rGzkt6YdDWX9Te-+__NGQyn8yH4P3=D=ZQSdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: simple_panel: Add tfc_s9700rtwv43tr_01b
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sukrut Bellary <sbellary@baylibre.com>
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

On Fri, Nov 28, 2025 at 11:24=E2=80=AFAM Markus Schneider-Pargmann (TI.com)
<msp@baylibre.com> wrote:

> +static const struct display_timing tfc_s9700rtwv43tr_01b_timing =3D {
> +       .pixelclock =3D { 30000000, 30000000, 30000000 },

Adding the three entries makes sense when the datasheet specifies min,
typical, and max values.

Repeating all three values is not helpful.

Linux supports tfc_s9700rtwv43tr_01b:

static const struct drm_display_mode tfc_s9700rtwv43tr_01b_mode =3D {
.clock =3D 30000,
.hdisplay =3D 800,
.hsync_start =3D 800 + 39,
.hsync_end =3D 800 + 39 + 47,
.htotal =3D 800 + 39 + 47 + 39,
.vdisplay =3D 480,
.vsync_start =3D 480 + 13,
.vsync_end =3D 480 + 13 + 2,
.vtotal =3D 480 + 13 + 2 + 29,
};

Can this format be supported in U-Boot?
