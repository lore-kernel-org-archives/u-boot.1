Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4989C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B91688216;
	Thu,  1 Aug 2024 16:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="KNDMGUlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA998870E; Thu,  1 Aug 2024 16:48:41 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 895CC807EC
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so634227266b.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1722523719; x=1723128519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OJs2E5qHrIUpXyATauI0Kit7Fz6EBeuVBOZ9iu7Y0M=;
 b=KNDMGUlvymjE+onujj77zpRXE5snqkSdirKdkNqTg5nPoMtY0pwQgI+ywZX7rdmD+L
 cr86b3UwXYR0VTNTHEacFDkLfg8yQagU6hiXm3nZu90pYNcqLMSKIB0KUWUklbN9HkVn
 UR2nOrn/G6i/oJqo9CX2xGioWU2cpSyptUcg48sCjSKlY8hC3y131bGskG/z1POxaFJZ
 3wanPT3+JkefZSWTGyGYI7rz+IIlUS/s1x7dtrGtUgmauxZRO6BlAyG0E1AbTXTGvoXd
 5rZEXdYlB1nvF03HTNo7CHDRsw/15EryJUII8lKkHU38MM9K7ZGVojILjd516R0IOUpt
 sX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523719; x=1723128519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OJs2E5qHrIUpXyATauI0Kit7Fz6EBeuVBOZ9iu7Y0M=;
 b=sfCD9nSLV2C7ESQONxNBoP0le6Y638BWK+/kndyUr6CqIraLRFSEv3udunsWgsOeEG
 FH6hmmipCUwc7ULQoa3mks1WkRUURLqU26q66JQ33gdvFAFP1PJLa4gu2GmN4eMhqtN1
 x06gn9/35Tk9gW3fsvbk/ZjfSpRYPkpHBJJhs6TfNa3gnGLTOlojKEVxX0uQizQf74/P
 Ctid9kPVA43FKOM3f1fdxRWaBRSgytBMbLBaP1bnShZnI/OsgwTp8P1PYiww/UFEPV1u
 fFjeMP+0YTvfN6ysmioKMYt9x5jU26gNXmcRg5r2ySu5CdPFuj79ACFjlQiy8EjXIKnc
 kIzw==
X-Gm-Message-State: AOJu0YwMJFIMczLsdHYJezntehScCou0UhZnLI/Qn9zlVbEKRyT+ju3T
 sY7t/N0jZ/+DwlAS775518ZeYdNj2TiE6+/Zlt85jeJCjJmjpNOtLXm1L6wtnek=
X-Google-Smtp-Source: AGHT+IH/VNtLaYrpTEmwiRLrZ6KV6xpj6r8WHlyheSZcOttyl6Fo/tGeuzKGLvT8SeEyKBimrwagyA==
X-Received: by 2002:a17:907:3e1a:b0:a75:2781:a5c4 with SMTP id
 a640c23a62f3a-a7dc4ea9ebdmr33054366b.29.1722523718627; 
 Thu, 01 Aug 2024 07:48:38 -0700 (PDT)
Received: from blindfold.localnet ([2001:4bb8:142:a8e5:a087:2ca3:8388:c4ce])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad4acbfsm901192066b.100.2024.08.01.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:48:38 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at,
 patrick.delaunay@foss.st.com, marek.vasut+renesas@mailbox.org,
 yangshiji66@outlook.com, xypron.glpk@gmx.de, eugeneuriev@gmail.com,
 raymond.mao@linaro.org, devarsht@ti.com, bmeng.cn@gmail.com,
 trini@konsulko.com, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] bootstage: Fix out-of-bounds read in reloc_bootstage()
Date: Thu, 01 Aug 2024 16:48:36 +0200
Message-ID: <5054868.82XvGhxQ46@somecomputer>
In-Reply-To: <CAFLszThXjgSBHjUmbD1whpVnRvQO0rBXdYv60RS7DgXwrbzvKA@mail.gmail.com>
References: <20240731160754.16263-1-richard@nod.at>
 <CAFLszThXjgSBHjUmbD1whpVnRvQO0rBXdYv60RS7DgXwrbzvKA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

Simon,

Am Donnerstag, 1. August 2024, 16:42:14 CEST schrieb Simon Glass:
> > +       debug("Copying bootstage from %p to %p\n", gd->bootstage, to);
> > +       memcpy(to, gd->bootstage, sizeof(struct bootstage_data));
> > +       data =3D gd->bootstage =3D to;
>=20
> should be a separate line (patman/checkpatch complains)

I saw the suggestion of checkpatch.pl but ditched it as matter of taste.
Do you want a v3?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


