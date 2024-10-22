Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E047D2CDFA
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E653D88FA7;
	Tue, 22 Oct 2024 18:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="GBtYGPcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F0988F2A; Tue, 22 Oct 2024 18:18:55 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC1AE88D91
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e290222fdd0so4955302276.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729613932; x=1730218732; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r81rhV0o+emtYbyrljevH5DCZbwXNnbaI/GO5rjGZ2Q=;
 b=GBtYGPcU74AXag9o2L/ilgTDYwcr8KiuJ43BkGxsMvPd+/Il/dq1wdn703ZqymyT1N
 J8wsfF8AkJFyauhvfh3lyf59a5WlF9V8Rl/D3zMcF9vF/HZOeXKeCMlRxo+YbGr+oYAD
 bRmbbr9wV0S46IycbydjCsd1QtSfv1otP+7lFMtkaoVuURpVn165UGssZksSjy415T5H
 M2PBz6yydKEKw25Hwtaoqz2xDsjxRAZj8KUbE/6ibkJhnsrcVAI4gJ/yjbv5kw6mVMgM
 vQIVEDvI0J0CMq/K8e43/rnL2Oh1mqj1S6qdmaeM9dPUFk3p2GsnFAPvo6EKlSR566x3
 e2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729613932; x=1730218732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r81rhV0o+emtYbyrljevH5DCZbwXNnbaI/GO5rjGZ2Q=;
 b=AafauBb7AVNOYhYGw074t8x8nTlep+8z+a9mSuWL0WSugCinBasmKFUrkszWAsUUj/
 f18/GiTsPAoWR71bqaeqQBnh1zl0OpeYIR/sc3m1rNkQUGjug2MW7gLCLJxb61O47ok1
 81lzi4ISS43GNl93guXX0ShgWHrBk3BYsPou6Zz8bFu7ic3Ml7YjaD3zHSarYa1AkzfA
 wsz0/S1wFIE/f0GqZz4pQLNk8jAmLcST3yRKRzfo97iOoNlQd8FbRJbGKVCF3p7BeqKy
 2znuhDRMaFzpjpFFfsbgxPCTKRK2y3ZteAdIwz4ipT/gnJ5FXG7f5rXQ23Auh+LfdkrM
 bRzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaiXMLoBvKfZe4qcWVrZOKJjlqwhwEMw1g8Cg3y2wYl1vu0ee6azxXtRYaYw2EDl2n+9jMXyk=@lists.denx.de
X-Gm-Message-State: AOJu0YxwRXbr8rhtW/CS2HJVxInTt5LA0wGLhHeRRcetIj9tHU767/Om
 cJtLOYS6gaPUEvO9G0mLsaX9aDiQVlsryYgCUV4yvpZ32iqYSIosm3L32aVQdoqg0VNYYri3b8D
 WrZTSGpfzGtqkGd//s0aYP5DkW7pCfmHZlFS4ZA==
X-Google-Smtp-Source: AGHT+IH0UpfHIQhpnW5gYZvm6J/H5tiIErVcZHLNG/AaqKaTsThrGzBI/QVNP98Z178HLwL6pTc9ogjN74jcT5gby3I=
X-Received: by 2002:a05:6902:20c3:b0:e2b:a26c:b800 with SMTP id
 3f1490d57ef6-e2bb130aa1dmr13596162276.20.1729613932534; Tue, 22 Oct 2024
 09:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com>
 <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
 <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
 <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
 <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com>
In-Reply-To: <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 22 Oct 2024 18:18:41 +0200
Message-ID: <CALNFmy1P-K6j1q9dm92iJ87h9WnjnvnzwhC1a3jaugahFhv6ZQ@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
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

Hi Simon,
On Tue, Oct 22, 2024 at 2:16=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Peter,
>
> On Mon, 21 Oct 2024 at 19:57, Peter Robinson <pbrobinson@gmail.com> wrote=
:
> >
> > > > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tabl=
es.
> > > > > >
> > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Changelog v9:
> > > > > > - default to BLOBLIST_ALLOC on arm
> > > > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > > > ---
> > > > > >  common/Kconfig |  2 ++
> > > > > >  lib/Kconfig    | 15 +++++++++------
> > > > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > > > >
> > > > >
> > > > > This is fine, but please disable it for snow since it needs the F=
IXED
> > > > > option for now.
> > > >
> > > > I cannot follow. What needs the FIXED option and what to disable?
> > > > I run this patch on the CI and test_py_sandbox tests are still work=
ing.
> > >
> > > I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED s=
o
> > > if you make ALLOC the default you need to change the default for snow=
.
> >
> > Simon by snow do you mean the device (configs/snow_defconfig) snow, I
> > think Patrick doesn't know you're referring to what I believe to be a
> > device config.
>
> Oh OK, yes that is what I mean. If it is too confusing I can send a
> fix-up patch after this series is applied.
>
Oh OK, got it.
I wasn't aware that BLOBLIST is already used on some ARM devices.
I'll send an updated version.
Is it possible to migrate those to BLOBLIST_ALLOC? Any reason they
would use a fixed address?

> Regards,
> SImon
