Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922A6C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 18:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146AC8761B;
	Fri,  8 Dec 2023 19:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lx6eePTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6ECD87630; Fri,  8 Dec 2023 19:53:02 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A48B08761B
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 19:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so443335a12.0
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702061579; x=1702666379; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OK/c4lrUrjhndRxUThfq9xoSL7E1Yuy3F50+IiEhZDw=;
 b=Lx6eePTlncz470WWo57SI4Kn0Ic/67GUWC2vRswxXxuZhPaxyNoF+8RVkCQYcCdY38
 tp9MjydGjdMfY0tFzR2At/Em2jFq2zdyWoyKsjZWEpu9/C1xP19mcJNPNlneIrVzV4pT
 SBbwFzhcixvrHTPWRRoUE1ZeAkT/cbnZmF6BrsalAH9jWkanD5lItlHMCSr0Q1hUBdVw
 KdoEnTY1ZhzxXfelJDFH3PbOxEKg89x1eRJStCD3Ob03FWSFPFqMULxiR8kzi4inlA5u
 CuzEGns4OhZD6DWhMPSo/bfYp0R0hRiWpi/5ggKtsYZ3q44Y214Zl87nN1lHST8PY9Uc
 GccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702061579; x=1702666379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OK/c4lrUrjhndRxUThfq9xoSL7E1Yuy3F50+IiEhZDw=;
 b=KlPQylGXW1d9exvX9oNjdDhDCEXOgzpmdIKn85/zvU2n5VnuKdpTCBeqERQEsWf0uk
 KrqqkrfdXGRyLNL3bJIiO89SRtsvl9QYwOgzsY5DUYoa9BiKU59m2CgbzNzRqw0dKq9r
 wRcQYiST/ccJHnUEKqO9BzaMeqlHUUciEaXlc+zX9Nl6cSwmS7Q+80ZKUetDgXW75JIr
 IAT4Mz74Y8E3cgrnSAeFdCB+WAhO7iQZP/zty5ryPvSYNocIsmdi8onM1LJU/TI6l8Lv
 l/wUnqS2bLtmVP3ali7h3RM+Sg/XrjEW2gOKB7uu0qtaLsOIOFIbBKaGyUvCZ5HNSMjq
 xAgw==
X-Gm-Message-State: AOJu0YxiEr8U/xKt2kizFH8G1/r1al+ewWfL/wPPGT/6OqzDgb1L9cSM
 6uq/cnMBoUsaVqe9w4T9P4YD/pxTkdkaJS3/qHh+81eqlS0=
X-Google-Smtp-Source: AGHT+IFxbVjTp7rI8M2iZMG5WwPp9fL1L/QpBTGiLXYVKz8T00WlM0H/Y1pS7qIaK3C+ykGPeV5uWQQLtXsnF383ITI=
X-Received: by 2002:a17:90a:6345:b0:286:4055:63e0 with SMTP id
 v5-20020a17090a634500b00286405563e0mr1081462pjs.0.1702061578841; Fri, 08 Dec
 2023 10:52:58 -0800 (PST)
MIME-Version: 1.0
References: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
In-Reply-To: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Dec 2023 15:52:46 -0300
Message-ID: <CAOMZO5BzCRhNnseNq5RMP94GLt=1H9s742ywtm_LWOqTxaJcrg@mail.gmail.com>
Subject: Re: iMX6, CONFIG_IMX_HAB and fuse_read()
To: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Cc: u-boot@lists.denx.de
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

Hi Lisandro,

On Fri, Dec 8, 2023 at 3:43=E2=80=AFPM Lisandro P=C3=A9rez Meyer <lpmeyer@i=
cs.com> wrote:
>
> Hi!
>
> I am currently not subscribed (already filled the form waiting for
> confirmation), so please CC me for the moment.
>
> I am trying to enable Secure Boot/HAB on u-boot 2022.07. In a previous

Please try the top of tree U-Boot instead.

On the mx7dsabresd_defconfig, for example, both CONFIG_IMX_HAB=3Dy and
CONFIG_CMD_FUSE=3Dy are selected
and this target builds fine.
