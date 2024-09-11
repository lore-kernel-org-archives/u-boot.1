Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E781BEE0214
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE50289205;
	Wed, 11 Sep 2024 09:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1748915B; Wed, 11 Sep 2024 09:30:04 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECEE88CED
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-6d49cec2a5dso59034277b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726039799; x=1726644599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOk1FOCcSSBwtC4d1EyvDirnO1scOxPxa13ggfz8vRg=;
 b=wrSe+uzJ2eEEnVZ19mHFNHhxpV7LIkxgc+WtxHgTs0DyAJ0dGXrgtGaiF+Z2GXH7O/
 XwDaSrJnIG4YEUsKDbG0hYy7BakZ3WAMNYAPRFqwj5ILSZdrGqUrscJbhvpKqxs/HTrj
 V8nWWLdhaIY5z0Ee19HeNNli+1a9UTlDuOXIsNzR7TxlKbjrQlHUUqm6GPFrKt3/E633
 eECnUDjRV4xYdJvMgfHyMoX38+zJdEQ1RMyec8on7f3GO8U+Vg2rBJ4YkOcvsY0Adevu
 7RigZ7T2aUMSTfjQHYhVMWg03DCwd3eRgUcLTO+l7PeNt7Jb+eID8mPQqKIxH0I7qa68
 VoLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWANeJfOvSqaBBm4KILFFHkqyDkDd7H3v8ZcDKF1gXfMr0SqVue8nTHkCzv+99BhW8jOtr8dLw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+hq0ZsIC0WL2TsKjFCngwNHFxQ7CInJ6T7W7ngpecGAMLMRzf
 OOJoe1NqiX5OtuQOx5V16FdxCNqqJAcgMbleHYRo3x4LuwUdvTPCVIbvzbCr
X-Google-Smtp-Source: AGHT+IG1xIbYAlnbUvXKdpvIZO+tn98mkomOOB3YQOQj1cQ8Rraf8KcfisTlBU21Du9nOYrXFSE1pw==
X-Received: by 2002:a05:690c:87:b0:6b7:a7b3:8db2 with SMTP id
 00721157ae682-6db4516ca91mr192566007b3.30.1726039798987; 
 Wed, 11 Sep 2024 00:29:58 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com.
 [209.85.128.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6db96429127sm6051517b3.19.2024.09.11.00.29.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 00:29:58 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-6d74ff7216eso59337647b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:29:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVlvTAkDK/v6cPsJohCNcTTXu7QgNuykg37JQ8TafhuFpx9KA1LRuJaoPrE7169M9dGIFOxuXc=@lists.denx.de
X-Received: by 2002:a05:690c:39b:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6db44f2c1damr187680177b3.23.1726039797973; Wed, 11 Sep 2024
 00:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
 <20240910172151.GG4252@bill-the-cat>
 <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
 <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com>
 <2c133f811fca225a0f796b8b94b16e63b33e56a6.camel@physik.fu-berlin.de>
In-Reply-To: <2c133f811fca225a0f796b8b94b16e63b33e56a6.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Sep 2024 09:29:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXv3yAwPpw2-qoKB8ijb+sA+U73t5-HQgtAoU04NRJs2A@mail.gmail.com>
Message-ID: <CAMuHMdXv3yAwPpw2-qoKB8ijb+sA+U73t5-HQgtAoU04NRJs2A@mail.gmail.com>
Subject: Re: [PATCH] sh: cache: Fill in invalidate_icache_all()
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Linux-sh list <linux-sh@vger.kernel.org>
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

Hi Adrian,

On Wed, Sep 11, 2024 at 9:23=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Odd, I haven't received the original mail.
>
> @Marek: Could you resent your patch CC'ing the current maintainers of arc=
h/sh?

It is a patch for U-Boot, not for the kernel.
Full thread at https://lore.kernel.org/2c133f811fca225a0f796b8b94b16e63b33e=
56a6.camel@physik.fu-berlin.de/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
