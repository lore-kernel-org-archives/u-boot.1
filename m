Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7BCC8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265D681D6A;
	Mon, 30 Jun 2025 14:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XllLFUVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C7881E13; Mon, 30 Jun 2025 14:38:44 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0575480B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 14:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e82314f9a51so2823025276.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751287119; x=1751891919; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KR+rMnbwx8OxDHhqjRcyoLMiDL2WCcWlHN+H+VQS5c=;
 b=XllLFUVYtgvGaw7qchXSKXbg0rZaNcbhBWvXyE7ziE6gfYV+OsQUauCPYPanscJFyt
 Wpx9PWzEVnB6bMLWoIewGFmtsHqWbo6YxW7GUi8pQloRyOAs2/0CVJJ32wBNPTpFsBsV
 YKM8kl+jh0TWGWCnzwG6alTMUIFhrliGWG65o5wnN7Ih6fqQg2lC+TJqNjSwC4OyYWVl
 UY2QBnNrClpZvWdrjDhl0atyjvjh24HXTQtt+IkkPpMAanxTEdRThfYZShrpjRsJoq0E
 k/hG5ryX/6eSuKQb4i5xnvrjZO82YnvX183nAghU0GoN5JQTZIoWhEwdYl0qY4jvD8YV
 pmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751287119; x=1751891919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KR+rMnbwx8OxDHhqjRcyoLMiDL2WCcWlHN+H+VQS5c=;
 b=tu8d0UPhnjX6sflqFmjhBJXQfl93IT6Ib9a8g+HmTt/SeOjVNdleNaED1DNb4jYjz8
 gCDjZnD1KyIfCTC2JeWW81GOVvggXEzSbeeTJVOG2xjxhhzg2yWC+O8Z+v+DHfjJXVoQ
 zDSGt5YQhJS1wE441E5otXsSw1TC7u9GUX2PKox7hZnZCU15WKPUKDwz4159OWc0874R
 O8U3fpynThc5znOVDpnEnzkAVRIfakEvlxRgkn7T/g1TVxffst5cTRIseeqq3fKAV43j
 OFnumUHEQ8OwQVf31+O5/IKGeJ2b48w3WjRH1pyB/BwcLUIGXA/j1LF8jwoOI7eCr5Ox
 iQLA==
X-Gm-Message-State: AOJu0Yyys/o1ACL82qXiyW4xEPvtFVXG1QMw621yo/4OxfwsoDGbla+H
 Vx4qfysyJnk85cv2N/iiHw2XYcjRPmKWUBdbEADQt+lSOS1hQt25+GdfQxIjsX2xCaOdOT9NL/r
 KyNhLeD1sCl2QyRQdzAaxOm9VC7H8muo=
X-Gm-Gg: ASbGncv9VAwDAtZy0oZxRkeQ79+MkDjnX+deF0SqhLlK05C4KfnCLOPdppXkNVItr17
 Ke+BkgGtdVK4amTAv4EHacvOaS5VbTCD8QwnC/17vyqkJy+q/ydlZs5gd7x8whMsGfjWeek7/G4
 MR1ybVfg4sMrr7CChg8DeipqgE3NNA0boUKGfsJ4AClQ==
X-Google-Smtp-Source: AGHT+IEKbr9nxj7AXR2CGGEcTQ08oAhjZknnjx2A5qczEoFtGnFHV5mZkYShGvU0e+pBGqfViNH15Y3xudUvUJ6uMPM=
X-Received: by 2002:a05:6902:2b02:b0:e81:7f36:5a37 with SMTP id
 3f1490d57ef6-e87a7aff870mr17770138276.8.1751287118432; Mon, 30 Jun 2025
 05:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
 <175109976650.52679.843396826887967830.sendpatchset@1.0.0.127.in-addr.arpa>
 <e64e154e-1f74-4235-a1db-38034a704716@mailbox.org>
In-Reply-To: <e64e154e-1f74-4235-a1db-38034a704716@mailbox.org>
From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 30 Jun 2025 14:38:25 +0200
X-Gm-Features: Ac12FXy1sdDAWndx6LOZfxNfoXo030MNNSuwfX1TaW-f21sewCoqjiE7ckWwN24
Message-ID: <CANqRtoSfcjBU=QJPoFVhZf368YHvKTXgjToRu2xEQ8hYreAD6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Put common r7s72100 code in board/renesas/common
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Chris.Brandt@renesas.com, geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 30 Jun 2025 14:44:34 +0200
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

On Sun, Jun 29, 2025 at 4:43=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 6/28/25 10:36 AM, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> >
> > Break out SoC specific code from the GR-Peach board and put it into the
> > board/renesas/common directory so it can be easily shared between the
> > GR-Peach and Genmai boards.
> I've pushed an SH Ethernet clean up patchset , defconfig split patch and
> fixups for these two Genmai patches to [1].
>
> The SH ethernet clean up patchset removes all SH ethernet related config
> options from include/configs/*h . The defconfig split patch deduplicates
> the RZ/A1 configs/*_defconfig files. The fixup! patches implement a
> couple of quick changes to this patchset, mainly duplicate newline
> removal, sort of various entries, and deduplication of genmai defconfig
> . No functional change is expected.
>
> Can you please test the [1] on Genmai and see if nothing got broken ? If
> this works as expected, I will submit the SH ethernet clean up patchset
> and the defconfig split patch.

Now I've tested the following commit and it seems to well on Genmai:

1e87c1bfe83714e3b813e3200bb880c2a77b0ef6 (HEAD,
origin/test-sheth-genmai) fixup! Add support for the r7s72100 Genmai
board

> If you agree with the fixup! patches,
> could you then please squash them into these two patches and submit V2 ?
>
> Also, please update the subject prefix on these two patches and add
> "ARM: renesas: ..." subject tags .
>
> [1]
> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/test-sheth-g=
enmai

Thanks for fixing up the code and yes I do agree. No problem about
squashing the patches and submitting the result as V2. I also need to
adjust CONFIG_TEXT_BASE to make the code execute from NOR Flash.

On top of which tree would you like me to prepare V2?
