Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A754C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 08:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B072877C2;
	Wed, 13 Dec 2023 09:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6AD877CD; Wed, 13 Dec 2023 09:22:23 +0100 (CET)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com
 [209.85.219.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863D887734;
 Wed, 13 Dec 2023 09:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-yb1-f173.google.com with SMTP id
 3f1490d57ef6-d9caf5cc948so6345080276.0; 
 Wed, 13 Dec 2023 00:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702455740; x=1703060540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wyo3wp77elB10N8bmvU+a2gMSD/SCgZGjs6MLVCESck=;
 b=AK5Uihpba5Qeks3l1N1w1tmZi9Zu+t+nGjvovMhD8ILfPnDh5OGmvCMilRyX/CvgvO
 E2Q5JrNE2FXjhbZkS90tnmnHL7jL09xVTzqGZc/Nn67A/fyn72aENF2Uryu3i83gq+1A
 XpMQayrMCV+yuTRjc/sJCO0uRVi7oMP1BRjRhQ2b5K9z5PS6LzRHyeHBD7doupuFbdQ+
 niZCSZU7C0dhYlsTzBQZXrmeqhsgMP/Zs5sJy1W8+1dosqNf/xerW38ufUgVCAGWFAZt
 MXlYm3wXfNsFmOehvp5N3f8drh7PTOK5pADL3XnvqytwIRuEOw7ion/d+f0FKqXFIh2A
 nbPQ==
X-Gm-Message-State: AOJu0YybmOS43k/HOnWS+fNHfUVGvaFFOsspvQRrcRmhRfQgbCvBziaa
 isekgORGxjqX+foILU4/DnLf8S71QDIJHg==
X-Google-Smtp-Source: AGHT+IEnRgK+UDpDwaZ2QSHOCwVwglGYbAvYVGliMFRrbO3S7/lEHVCVKAqJ3pIz1aPPJ9Eb1NDqxQ==
X-Received: by 2002:a05:6902:e0d:b0:db5:4082:b8f0 with SMTP id
 df13-20020a0569020e0d00b00db54082b8f0mr5221069ybb.4.1702455740041; 
 Wed, 13 Dec 2023 00:22:20 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com.
 [209.85.128.174]) by smtp.gmail.com with ESMTPSA id
 u4-20020a258f84000000b00dafa5f86dc2sm3779814ybl.16.2023.12.13.00.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 00:22:19 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-5de93b677f4so47157857b3.2; 
 Wed, 13 Dec 2023 00:22:19 -0800 (PST)
X-Received: by 2002:a05:690c:4088:b0:5e2:7074:91a3 with SMTP id
 gb8-20020a05690c408800b005e2707491a3mr1097794ywb.73.1702455739213; Wed, 13
 Dec 2023 00:22:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
 <ae0675e2-940a-439e-9557-e5a4f745f1b0@ti.com>
In-Reply-To: <ae0675e2-940a-439e-9557-e5a4f745f1b0@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Dec 2023 09:22:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQdMeXUOAAw5nDO4+q5_HFvUc86Wi8ykMwjUwPex6wvQ@mail.gmail.com>
Message-ID: <CAMuHMdXQdMeXUOAAw5nDO4+q5_HFvUc86Wi8ykMwjUwPex6wvQ@mail.gmail.com>
Subject: Re: Proposal: FIT support for extension boards / overlays
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi,

On Tue, Dec 12, 2023 at 4:52=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> On 12/12/23 8:05 AM, Simon Glass wrote:
> > The devicetree files for a board can be quite large, perhaps around
> > 60KB. To boot on any supported board, many of them need to be
> > provided, typically hundreds.
> >
> > All boards for a particular SoC share common parts.  It would be
> > helpful to use overlays for common pieces, to reduce the overall size.
> >
>
> For this to save much size we would need to have the SoC split
> from each board that uses it. We don't have that in DT today.
> There are some efforts in progress to help on this but until
> then we will not get much here.

Indeed.

E.g. The Kingfisher board[1] is an extension for (various) ULCB
boards[2], but we cannot use an overlay for the former, as the
combinations need to have different top-level compatible (and model)
values.  Hence currently we use a .dtsi file and lots of extra .dts
files[3].

The other issue is the need for parameterization, due to slight
differences in pins/signals on various base boards, or because the
same connector is present multiple times (e.g. for multi-camera
setups[4][5]).

[1] arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
[2] arch/arm64/boot/dts/renesas/*-ulcb.dts
[3] arch/arm64/boot/dts/renesas/*-ulcb-kf.dts
[4] arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi
[5] arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi

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
