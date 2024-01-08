Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6C2C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259FC87A5D;
	Mon,  8 Jan 2024 01:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cRsf3MnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C81FE87A4F; Mon,  8 Jan 2024 01:16:23 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A37C087A53
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbbc6e51d0so1203045b6e.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672978; x=1705277778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33kVHPdWxYO5puL5JqhgVbS+EjeDspOEHR0Ri4pN1Ic=;
 b=cRsf3MnP5sO6Sy9iM1sE0NLPL4AflfhkkOVXBx/VtzMhU/J7swwtclOX7kw+RK9AV7
 jzHMRBQPDyDMLK7ZFqv+8j9DpA0JvtQ6EfXrLqVKf7JZBSrQraKCvpw7a8imYBZ8FQFQ
 Uj5lDYLpA4yBGpUvLu4LF1ulcTk7s8WriYq0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672978; x=1705277778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33kVHPdWxYO5puL5JqhgVbS+EjeDspOEHR0Ri4pN1Ic=;
 b=asZ4yOLWBXBLaMh4Mu4cMBKf47Kvdx5mMpLHg7uf8kE/ciQHap2EJpC9oVB70m+aIf
 LPTQA0wNW2inteuPB7+BP+lbC7H4ycj7Qq8qZx2mtiq0rCEerFAY2AL92nn4JErNQU9A
 mSB/hhLFmwZMsjHhUpPfthEJl7k+nP3K6yMEMNIZ15TmDDKkx4L3PEY29MqlpeAOrWrV
 rFoQCThTt7pLRcETrZpCBHnreCLa7f+mDFB+z1sWbgtLdjHbYWKYEpIMPpa6E+oMihjr
 EozmlJqgoyJRLBQoJSUz0b27oPuAvX+FlExYDpHgCmQqXLiIa7vEeChOzuxXa7ntBT1r
 zXcg==
X-Gm-Message-State: AOJu0YyutFKm7+LVQVNSExUYKT154lr69oAJ8cPStspK1wjVkO9ym1Sv
 7ykbUEWpCF7gGTBqSVT3ghKOzcj90s/HjPyxwFaF6MGIBGxA
X-Google-Smtp-Source: AGHT+IFeO5/cJw7a3YJtuMIpTLQMqbh8ZEufd6Z1C6FSIO8p1YxMuShYnnkqcJzL1In/QBzujeFylAuMhieeIBvvniI=
X-Received: by 2002:a05:6808:128e:b0:3bb:bc6c:23d2 with SMTP id
 a14-20020a056808128e00b003bbbc6c23d2mr2632606oiw.111.1704672978078; Sun, 07
 Jan 2024 16:16:18 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:17 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTgJzD0w3GTtkVVYoXkX+r-2_GC+aoxYOK0QTNAiPrkWCQ@mail.gmail.com>
References: <CAFLszTgJzD0w3GTtkVVYoXkX+r-2_GC+aoxYOK0QTNAiPrkWCQ@mail.gmail.com>
 <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-5-sjg@chromium.org>
 <3ea1e2b4-8a52-4e20-beb8-6520f7df0139@gmx.de>
Date: Sun, 7 Jan 2024 18:16:17 -0600
X-Google-Sender-Auth: 4DbuLb1kkwHtsESa0Xfljuc90j4
Message-ID: <CAFLszTgXASzGcwKujHDbUynD5fdUqfpV1Yv--WtCtLCj-JtQQg@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] smbios: Use SMBIOS 3.0 to support an address
 above 4GB
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Heinrich,

On Mon, Jan 1, 2024 at 10:34=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 12/31/23 16:25, Simon Glass wrote:
> > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > address is not large enough.
> >
> > Use an SMBIOS3 table in that case.
> >
> > Note that we cannot use efi_allocate_pages() since this function has
> > nothing to do with EFI. There is no equivalent function to allocate
> > memory below 4GB in U-Boot. One solution would be to create a separate
> > malloc() pool, or just always put the malloc() pool below 4GB.
> >
> > - Use log_debug() for warning
> > - Rebase on Heinrich's smbios.h patch
> > - Set the checksum for SMBIOS3
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v4)
> >
> > Changes in v4:
> > - Check the start of the table rather than the end
> >
> > Changes in v2:
> > - Check the end of the table rather than the start.
> >
> >   include/smbios.h |  6 +++++-
> >   lib/smbios.c     | 30 +++++++++++++++++++++++++-----
> >   2 files changed, 30 insertions(+), 6 deletions(-)
> >
Applied to u-boot-dm/next, thanks!
