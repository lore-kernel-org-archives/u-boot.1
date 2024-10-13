Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5FACF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 20:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BEB388EAE;
	Sun, 13 Oct 2024 22:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OiUqHBP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BC38899C; Sun, 13 Oct 2024 22:22:11 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708D788EAE
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 22:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f72c8fc1so230974e87.1
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728850928; x=1729455728; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKVKuNs5U0g22n3JVM1B9vyvfnZhVlCXOesXevL9zu0=;
 b=OiUqHBP9WXzQVb4vrJrIudfBYYYYJoDcNeChKWVu6JJrcoGXn7GiEL2TBb96lr8YNt
 W6LMkMCzWM78x5doveoAs5nma3OOP8DWLZzWLNmEPZwKsjGqNfr/F3av/fzSUbVSX2HY
 ncvy6GkRpG1b+YU5y6SVi8tPFlhvI4+CgQz1uUDTaLN+nKvPHVMu5Fdb6XB9k5yx6BTC
 pfy5wbXolhtnvgB3w9DNwyvtSvHRUxaF86oEVYOLZ6vr9NG+V+Hl5RU0avtl4ZDS0Tgg
 3yRyjXfKfsmQcGBgJpYy7YbpilNqC83Aj5BAXOuZPco1KVs+x5c9ZaH2Ywr1XBiPUJ2D
 4MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728850928; x=1729455728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKVKuNs5U0g22n3JVM1B9vyvfnZhVlCXOesXevL9zu0=;
 b=Lmovv/M6L+GdcwvzWfPbC/eRdtzKlkBb7BQvn7yTpJIygCLnbgbhIRG4NbQmP9J6fw
 oZ6arYe/TW4qWLsSWsOspjRPv8i6f3A4iKRouBfG5PlKr7JFsVCAEAvOHlqTaWb97VT5
 XLNDOJGX1B3O6gfRwL0PofU1zWzqZD7hYuoslnwKY3cuCABhPuhf7xJ7uwCnPOS9SULm
 A2np1BoD1KQSYebRM1AOAwxoXYiYF+vZVcXXlC7peBhMIEqXNMvOfQHszxO1XuFXwCaE
 Z8SQhF5/ETo1a2VXsw43nk7+kF1xJ3cl8Inc0kn4KbuG4KEekTiLCcmv1+CvSew9yy3E
 Zb2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxeepw9cEcjZUWsyOlxpexb5h8OWn6FxgI99j7diheFNLs2pio3Ct4HdG+DzN/VqmuK1XcMlI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywyl0I/wopudHJ+KqE+VfNOk1tqf/HB0vflDd3Oe8yxnimzU7bz
 DhDKYV2eBHXAArWpwFEqpPBUqZtqFtxw5Ikvsl1jjmJkcEXjdQhY0t1b8I0e+cDg8NZl3GCfg4Q
 LAEG0DcJf8vx7/Mkpn92uFOLPp6g=
X-Google-Smtp-Source: AGHT+IGcKdHd1hQzvcXRa/NZTiCFjemch2+/UATKXoQgfromdlyvs+EDyju2ufxuEBPhniMRBpGBZf90MfaI9blDcKQ=
X-Received: by 2002:a05:6512:3e24:b0:539:f5b3:f87c with SMTP id
 2adb3069b0e04-539f5b3fa51mr538172e87.46.1728850927543; Sun, 13 Oct 2024
 13:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240930161006.41052-1-brian.ruley@gehealthcare.com>
 <20241001135810.96-1-brian.ruley@gehealthcare.com>
 <20241001135810.96-2-brian.ruley@gehealthcare.com>
 <CAFLszTgppFmNC2NL+fcE9Zg530oA1Hs3VDpfUK3yOd0swp3UDg@mail.gmail.com>
In-Reply-To: <CAFLszTgppFmNC2NL+fcE9Zg530oA1Hs3VDpfUK3yOd0swp3UDg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 13 Oct 2024 17:21:56 -0300
Message-ID: <CAOMZO5DS2hFGORNGqROoou=Bouy57waZkAHRu0W4=32NACL1gw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] binman: add fast authentication method for i.MX8M
 signing
To: Simon Glass <sjg@chromium.org>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 ian.ray@gehealthcare.com, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

On Tue, Oct 8, 2024 at 11:17=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Tue, 1 Oct 2024 at 07:58, Brian Ruley <brian.ruley@gehealthcare.com> w=
rote:
> >
> > Using the PKI tree with SRKs as intermediate CA isn't necessary or even
> > desirable in some situations (boot time, for example). Add the possibil=
ity
> > to use the "fast authentication" method where the image and CSF are bot=
h
> > signed using the SRK [1, p.63].
> >
> > [1] https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-pro=
cessors/202591/1/CST_UG.pdf
> >
> > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > Cc: Marek Vasut <marex@denx.de>

> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> (since I am seeing progress on testing, thank you)

Applied both, thanks.
