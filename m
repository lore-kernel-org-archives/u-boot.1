Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867F3CEDDA1
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172B483E19;
	Tue, 18 Nov 2025 15:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dDmHCvo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDD5A83E42; Tue, 18 Nov 2025 15:43:32 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B9183D07
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso4936414b3a.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1763477008; x=1764081808;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d01b1gg11HImXk7iRYfWxiPDnqyAn1IJpcf6bv7Om94=;
 b=dDmHCvo6NTDZ2DmKc5hEQtibjJrRa94xNKNb2y9UUgzl9WcVgFbKbKpw+HrLKucerr
 GoguR5sKVpoYm38LZx4Hn2tEtAAr2kgP9z65yERxEW18LUQwt5gHdQKgjhYrxp0rjPdI
 0mqv6yEUDonfLLKggAkKk7Gja9No0BZje3Rxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477008; x=1764081808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d01b1gg11HImXk7iRYfWxiPDnqyAn1IJpcf6bv7Om94=;
 b=m+BloBS2uaQNDatm7HHat9uJg/EnQC5UnDxe7X8QvkPAE0heKLa4V0nFjjEiGVOIDr
 SpCcCWfPidcj+Igzvfbn9BogtV9ya7vHMOgcfAXgYOkTGLOuChVogu7Gz7q1mo0c1JxN
 wrrUaIrgBiM0xjlLTOXjIC4eXK1fuVIlHPhOWsiuOLXzJbIb5nouAXSsBiicgWLTPfEm
 XUwlZtmoc2KjErHBApzK1CXr5RDsDDuK2rEZYDhV8fQWu1wM9pPHHCXlcfuJYYGmCEgf
 HBHeigzIi9P6StT8rfgccnaTSPJmzTkBcf/iqCCj5GG9S2qeIwsoFVtmr+rO/S11qTfQ
 BDoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJtkdxzKQg2ZA+hgxke7vKeZvB6+zJcuj3VOb4jjZzC2zbXC64djX6y2U6BOxn/XITDX+mFPk=@lists.denx.de
X-Gm-Message-State: AOJu0YxFhMm8GzgwpkVGWDiwEhLD33hFjYRmhkyvud3QebNsoJrv8qqM
 XrmkPmdEaTMKJbBs0YDgLBfrBbb0A6qOi+PeOMuxAB0vUXN7XeGbWM3VE84K7zS+/GZh6U1jj46
 8jbRbb/f/gjbXpTqs1ll5jj+NLzU5n5I+65sunSPM7g/7PfHr1J3tr/Y=
X-Gm-Gg: ASbGnct7a45Rw7sEHX6BhmUKc5MBSZ4O/Ni/zSZIkqM/raCk12Q3e4PwskUI5CVyj0z
 yqIymbXG0jsWr5dkf8nRlN+/1ANFB/qeCo6bp5tw/nEqwIYT/dgvKTUBO72bE3A044ZecwMjH7/
 kl6MkkwFLHVuRboqZ0VZItFX4D+8SutTOPK6lFFeBh3ZjwbZdDtdqlMLIxIzzgRNsLVC5mGcjOR
 VlFAoIp6Q1ECNeFmVAV5K76Dbgr8rWHNCrBZxcCK1weVtRqW9pYDiCTZrxN2dB8tdBdr4R9Cpb5
 PJIzVecdDzyrKP2Q
X-Google-Smtp-Source: AGHT+IGZiwcRZF5Kq5nH16uWBLC6l35gl/2/efTz+0jbY0429Q9gw+bnj/E9LeVVmCZWoeYV86OfcLvZOYYPpDoY/b4=
X-Received: by 2002:a05:7022:68a3:b0:11a:2ec8:de1c with SMTP id
 a92af1059eb24-11b4130b653mr8903210c88.36.1763477008274; Tue, 18 Nov 2025
 06:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
 <20251113142745.GI6688@bill-the-cat>
 <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
 <20251118143405.GA527619@bill-the-cat>
In-Reply-To: <20251118143405.GA527619@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 18 Nov 2025 15:43:16 +0100
X-Gm-Features: AWmQ_bkE56jOFCMcy-jLMDO26qiXn2Xj4GlGz1X4ixImY-BM17qjiwZM8U_7spA
Message-ID: <CAOf5uw=jx7jTgkeZytjU0t7VFHSVrXfntxrpapUSWrYh5z8exg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Steam Lin <stlin2@winbond.com>
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

Hi Tom

On Tue, Nov 18, 2025 at 3:34=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Nov 13, 2025 at 03:36:00PM +0100, Michael Nazzareno Trimarchi wro=
te:
>
> > Hi
> >
> > Conference. I will pick him up this weekend together with others. Sorry=
 for
> > it
>
> Hey, so it's Tuesday now and I haven't seen a PR and it doesn't look
> like you made it to pushing anything to the custodian trees either.
> Again I ask, do you need help here? I can go and pick up things that are
> either clear or reviewed and start pushing it through. Thanks.
>
> --
> Tom

Let me sync with Dario.

Sorry for the delay

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
