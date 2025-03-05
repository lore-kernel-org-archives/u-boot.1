Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276BDC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88BB80F56;
	Wed,  5 Mar 2025 14:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cnY/zWM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D5A80FB9; Wed,  5 Mar 2025 14:52:50 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E80807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390eebcc371so3153017f8f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741182768; x=1741787568; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=of7+G/Rpa+rpjFzx8SKFYEz+OuKzhzg6PgzAQqSLfl0=;
 b=cnY/zWM6pSbtU1OBU1AanHyvo6His5jyYxjeaUQ1wI8zSSFaUDCEzyhMBEqgoHT4Z8
 ZX16wGhKBqp8xvYY2RoChgnNAr3wbM/zxsx6LD2kpAFW591ykmnCyh8dXP0MC0TJCawD
 iUudOZNk8h7t9RZPWohyT5GDGqbQ0zmbv/HgCbaBptQDgYDHkqBdmZaiUMsNrcGRVHbt
 nG2PZn8x8FaEzzuh/8tbyiu8t0BoFvErr9pdXVZtWquo3A+OsrfDfiZ5gWOcBzv0JOHG
 NmBsitjJTzLTXiO5PImX4KuCn9D4c16+AcE/8uMvBTbzBYC1rregkpfv4AJiliJXIJVG
 OxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741182768; x=1741787568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=of7+G/Rpa+rpjFzx8SKFYEz+OuKzhzg6PgzAQqSLfl0=;
 b=IlSxClB94mM5GiJR5VKnDwjfej2XCHc7H34SimkmwB518BPU1ikLqsUWEtmddL/3hq
 sL0br6/039ShmfeZVcRANK5MmUy8KEmmsBqsXsbr7dfxQV8yr8+/UX1QWyfz3P4iSKEt
 qkx8us5PiglkblexBN44Hq+ZzkWpAUJ/+/ytwTelmHCYtXRyAiO2B3jRH6nOEAOq59WO
 6vVZ50EVbHEtN4FTax3yHXKG8HuUoCuTj5MZKSsYGcG9+XbAeggffDqAtyVeO3Of8QJO
 /x7rZZ+NrSg3FcwxgfEdbSIKPlNkNxPTw0s++c5oxuJZa+HCqnThfTGGRYYdsGDYC8Re
 VSkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk9EC8u9yuTWIp1DyYp0s+48GByodU1hmDOpxSnAkFbuCZeQPjQUk0nstCkcnrcilEQ9xvzfo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxm6rfa9IhA4m7PUIz4LL0GD2v8ZXv8ZZPrO0MdooWfePD070HI
 7UwwtL9JeLK0kt598Pwfg+7/HnVW4+Wad50ST6Zm+BMg1MMhxzXn+kP+GJ4smuKaH0QS+LzgrRs
 ZhbBKu/z7bjAzgo+m0etTyDw8258=
X-Gm-Gg: ASbGnctFLfA3lg44pGvPMqgPxUauQkAlzbwcOIHqrXmrGgj1nrnn3VnX6VmiNoe4AL0
 XEZtAqMiuSLmGpTTb+GlJ9jSprloysGM3AW03gBnUKvcX/Cnn0F06RFgNqnKWtEmlIVkLW4ygGS
 MUqkOLk05Q8FIywWkNKbK8L6Gefhw=
X-Google-Smtp-Source: AGHT+IFA2g1AH/DqzvcwnyF9nFiK7LdUNV5qbH6v6VBzGUdRzXNEkd4r2hETsovWB1uyRu6e6s7NuoBeMTE0nSTN1wE=
X-Received: by 2002:a05:6000:1786:b0:390:f88c:a6a2 with SMTP id
 ffacd0b85a97d-3911f7adef9mr2837741f8f.39.1741182767542; Wed, 05 Mar 2025
 05:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20250305111213.163428-1-clamor95@gmail.com>
 <20250305111213.163428-2-clamor95@gmail.com>
 <kfyuo4l2w4menkfrb2sbvvp2ptumyed7bvz64vrnpm7lx6dpqe@hxo2633n2poq>
In-Reply-To: <kfyuo4l2w4menkfrb2sbvvp2ptumyed7bvz64vrnpm7lx6dpqe@hxo2633n2poq>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 5 Mar 2025 15:52:36 +0200
X-Gm-Features: AQ5f1JotfGs-F9ejs6pzxjDL4Tz2xzocJ8kq50gKEQ86I3qfKmb6_atoMGTkAFY
Message-ID: <CAPVz0n1H5rktuYJ=HGMiXtOqyOFLSEJeyUJvcEdGcr1T_PfCrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ARM: tegra: clock: fix PLLD/PLLD2 related clock
 calculations
To: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:47 Thier=
ry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Mar 05, 2025 at 01:12:12PM +0200, Svyatoslav Ryhel wrote:
> > From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> >
> > While PLLD/D2 is the nominal parent clock, all derived clocks are gener=
ated
> > from its single output, plld_out0, which is PLLD/D2 divided by two. Dir=
ect
> > use of PLLD/D2 is absent in peripheral clock configurations. Therefore,
> > clock derivation formulas must take in account this division.
> >
> > Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  arch/arm/mach-tegra/clock.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
>
> In Linux we ended up exposing the _out0 branches of the display clocks.
> Wouldn't that be a better way to describe this?
>
> Thierry

You are not satisfied with the description or with solution?
