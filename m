Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B29C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 12:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BEB88153;
	Thu,  2 May 2024 14:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QuqgTuBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9FC881EA; Thu,  2 May 2024 14:45:56 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C19F8812F
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 14:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5f77640a4dcso36110a12.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714653952; x=1715258752; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1WJlBUuLlWIfN8udr1JoNQQcA6NfFjPcO5Jux4wu7o=;
 b=QuqgTuBqbhGeRrvz9sxB9PJG+8pKbppF9imnnak7UlmQ9oZKIGWHKR1vwuKQk+kYDc
 B0SVRAjO4vG8TGkKyJqM+PQnt24jwjYXmfxrAOIAhXH6EqJ4xezhwgoPNMAxgGtq4ENU
 RAjZgiDI9N2kPt/HMynaJx34Uro3PqFCLaGALzY5a8FpXrKN8o5tR0Q8Jz/3edq+A9qp
 nF4kT9GDrAYZQHkhI+4TVQC2EfMcc8b7bPcBGDWMMBfFgN//RfSyfNYvH5uPurnwJWba
 5eUBX7q45kmiNkJWMZXpq6o/z3S40YHRKuIL8I4i60rRDBGxGtTAxY9NGTtB50hxM7tg
 PoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714653952; x=1715258752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1WJlBUuLlWIfN8udr1JoNQQcA6NfFjPcO5Jux4wu7o=;
 b=lES8iNmvz9GsoN61fax3fKKcfGw84DOPMu23khp0v8JfMvmjoitELNTQCqKiw6UpBL
 gPcuNIHU869q3UEHgsKr9F2giEGfBdNijbP3LG2t+P2c9acxZQCR4hOv8VZaAEjH4ghc
 ckIRHmCUpkL0yqQzE0vRcDu2mQ7AWUFd1lkAix5ijfMMro9A0Vy/Ypft7Zek/3WrKbVu
 maAv7agn9tr5mvw2ENXbkfEr2YAcOskqTLWeqY11cdDsWmvMUR1zwSCjAbrpeCY2h0kC
 +RaaU+BTn7sQZu89jO5W8hh5jFnWJ+wwTLFkSMdQzdLZjg8q0mxWZ3Yzhx9+pIPM3v4R
 45ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFitzvqyCu0JDkoUcU2JNfkxwvCAwCFeuuEuzQbRlkxHI2w3TQgEmjsdRJkMiBV6viwwvezdo3U5UX7SrPV7DFOfmrcw==
X-Gm-Message-State: AOJu0YxZMojXIubzrgiiGtmU4iq4sgQSonP+AQMf7seDWs7+TSEN3rKh
 QP101fA58rJOmabXMw39pXSkBRkYDgkEmTfY+vOYtA9vH7P6UarfFuBg9ZQq4QxA9w22IjEluvQ
 TIfWm8eE4CYR+YlvXjgmTVHZSzZo=
X-Google-Smtp-Source: AGHT+IEGFAYfaock4HPO6SQiSCBFKUwTq2WfN99NcUPypx3wgjHt/QRaeSuu3zZsP4pBWHQgmOMxExnQm6Scu5Q/BIc=
X-Received: by 2002:a05:6a21:621:b0:1af:6230:e693 with SMTP id
 ll33-20020a056a21062100b001af6230e693mr6130029pzb.0.1714653952524; Thu, 02
 May 2024 05:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5BeK7QyqEZisSVX=fs9jmq98gjnf_n0FrRJrR92pThrGQ@mail.gmail.com>
 <b1733528-3c33-a52c-f239-dbe39c69d586@denx.de>
In-Reply-To: <b1733528-3c33-a52c-f239-dbe39c69d586@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 2 May 2024 09:45:39 -0300
Message-ID: <CAOMZO5De9dRiScGEv+TOHZexXQZjNs9JmgX+qCLNZeEaox5yYg@mail.gmail.com>
Subject: Re: imx8mn: bootcount does not increment
To: hs@denx.de
Cc: Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Adam Ford <aford173@gmail.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
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

Hi Heiko,

On Fri, Apr 26, 2024 at 12:40=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:

> No chance for a bootcounter in a register?

Yes, this is a better approach. I changed it to:

CONFIG_BOOTCOUNT_LIMIT=3Dy
CONFIG_SYS_BOOTCOUNT_MAGIC=3D0xB0C40000
CONFIG_SYS_BOOTCOUNT_ADDR=3D0x30370090
CONFIG_SYS_BOOTCOUNT_SINGLEWORD=3Dy

and now bootcount increments.

Thanks,

Fabio Estevam
