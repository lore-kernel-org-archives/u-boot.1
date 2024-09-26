Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A34CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D411C88C53;
	Thu, 26 Sep 2024 10:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="HDdlHFp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAFB88D1C; Thu, 26 Sep 2024 10:23:39 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61ABB88C4A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6dde476d3dfso6163977b3.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727339014; x=1727943814; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDR9kDoTlFwGmuNg53JBO+YkTr/nuKrmP0iRISA+mnE=;
 b=HDdlHFp/llXjdCldGrr98Mgqjr9N1LpdEv36Ovvr1srSLu41f8MKbJ21IBpyaVn+EL
 JSGLPTY2hGxj88RooCPqBPLk9eqAfBxdQrA67JRCE+qXZARnPICab4sDe4DEhpf07YhX
 tdROTaXBCTP/k9GP9s1P3AU7RpYR43Aq427PgaLclQysfEl963NXNNvn9hSubusX1u6h
 oUrdZ3nWNJ0yTqtA1ojiAUugHa9QU/bC/PydUFqHsG2DuuEFOcCw+1DqFFjiLpbIJ/vF
 pebDfAN+Z4a6W4x2v0tm0bAPi5oHqjJ+wWePRysnUy7ZnGa/xQxwMMUue/Q7BrU4iH0D
 KQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727339014; x=1727943814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDR9kDoTlFwGmuNg53JBO+YkTr/nuKrmP0iRISA+mnE=;
 b=fh9Je6bADOzM83DWESMIDhxmqGcS0VGTcpS9JLPc6X1bo+acHBnBk8Hjm6pFVt9SKk
 7BsY4V/OO4bKL0dZDl/qUwRW1mqk1HT5PpsvQL4oh+2l27BxzAMza/nXg8jNxz2bb74e
 aINSbEPGhf5d2R8xWxm9dIr4rWBNKjRKXX3oFH6p6tPZjQ/+WP9IONsINDXQt6Dks9fT
 zh1NNzjpCYO3aRuiMiYBeT+shocb+QqCy1anUtw+tONcY6qDjsMBJew8hm4MjX/zMigJ
 8Voi9RWAeqsICLfnQaheCFEdwlKyG6OUUCpjaWlU7fgvvy00TKZlaI+r95PkKjvtWEI9
 B6Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjXt/pxxvf2dKl29s1X1urFY7Qr1MzW3oKp5pOrtG5Cy2g8YxVcyXEziFo1x7ljTaRPJxHjwQ=@lists.denx.de
X-Gm-Message-State: AOJu0YygrTqkfeFUVyWta8bKz3PBk2RDdALwqkkXttiF0v0FM29BowF7
 9vWy2zx0/iNvtciIKk1R7mAAKDofy7O2fCRTmDGp0gUPSFSaXfs+W6BtfC4AZjwRyfuLBK78qvk
 QoRD91xo/AS7Hq6NDL5001aBZk2+mz1f/ammhJA==
X-Google-Smtp-Source: AGHT+IGInYaYqvDTUQ/Ws6+y6DNbSFagY1RdEb31J7yIZqqW1RdUBJm0kfE+tk7j+y+B5LpumPeZFM2ffMlqxHdhjJ0=
X-Received: by 2002:a05:690c:14:b0:6e2:313a:a024 with SMTP id
 00721157ae682-6e2313aa6b1mr12819937b3.33.1727339014236; Thu, 26 Sep 2024
 01:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <ce2fa4a5-bb75-4dae-b035-405af0870991@gmx.de>
 <CALNFmy2B_iObakJ83eXYvPEOJ4Ecf20-8S=s30fpBQwnwPNhMQ@mail.gmail.com>
 <20240919225208.GY4252@bill-the-cat>
In-Reply-To: <20240919225208.GY4252@bill-the-cat>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 26 Sep 2024 10:23:21 +0200
Message-ID: <CALNFmy3YyhvC5_6dSjptQ2ybLG5+zJbZLTVU=UVJ8fSFZiCLvQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
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

Hi Tom,
On Fri, Sep 20, 2024 at 12:52=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Sep 19, 2024 at 02:45:30PM +0200, Patrick Rudolph wrote:
> > On Thu, Sep 19, 2024 at 2:39=E2=80=AFPM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > >
> > > On 11.09.24 08:24, Patrick Rudolph wrote:
> > > > Allocate memory for ACPI tables inside the efi_loader and write out
> > > > the tables similar to SMBIOS tables. When ACPI is enabled and wasn'=
t
> > > > installed in other places, install the ACPI table in EFI. Since EFI
> > > > is necessary to pass the ACPI table location when FDT isn't used,
> > > > there's no need to install it separately.
> > > >
> > > > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> > > > bloblist. The tables are still passed to the OS using EFI.
> > > >
> > > > This allows non x86 platforms to boot using ACPI only in case the
> > > > EFI loader is being used.
> > > >
> > > > TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
> > > >
> > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > >
> > > Could you, please, describe how QEMU SBSA is passing the ACPI table t=
o
> > > U-Boot and where you convert this to a bloblist. I could not find thi=
s
> > > in patches 1-13.
> >
> > I doesn't. All ACPI tables are generated within U-Boot.
> >
> > >
> > > Please, provide a test that we can run on our CI.
> > How would such a test look like?
>
> Similar to the existing QEMU ones found in .gitlab-ci.yml and
> .azure-pipelines.yml
Patch v5 enables QEMU SBSA ref on azure CI.

>
> --
> Tom
