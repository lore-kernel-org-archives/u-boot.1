Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C1DFD45F9
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 23:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E4383AA9;
	Thu, 26 Feb 2026 00:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZeOnT3xq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F71C83D8A; Thu, 26 Feb 2026 00:34:52 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7C383642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 00:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65f73225f45so508402a12.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772062490; cv=none;
 d=google.com; s=arc-20240605;
 b=MGIM/nb+frtThMY+qvPNz3Wm80pUBt+cqelgzTxlX7yPnt72tt7BEiS+JmsR4U8Kxz
 UWLxBXgl9JTfcvm05dBhocTew4MWMiXlc4sYJAiIqUlOQCgVb4L77BuPrrjawhBXc7dW
 ElmK7vUWWBS2+u9PIwtB5WVWnp3qWBrpmlr+Mt0ZqA/m23vBcXDGgnjePzsGqUotBIwQ
 VBgCy+1MLQVjzRq1JvTbATl5eqrxBMTmIzdTTkh1d8kgbpPT+GNj0LI72ZlW/gq35mAW
 hfrnjoxp6gf2VIdniIK1/kmQhZurchSQ3fBpeqJfzDDQn9EvuRkcqj1C5ZfEWUVohuIB
 ZF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=omsa0OPHbgy206a8oWkEJczcrnsnn7HMZ22HUH5U6j8=;
 fh=HB2HrDgSfZYRQEw85TEie0bnLKnCVl+8/W0cJwUF4ts=;
 b=MIrEZ2VD1lWUpfmT1SlI5yGa1KuyYqciTTGmTpUHaz+6b52027fNuQCeapueRWsUy6
 Wm/3KZLxRUav78o+PCYz1FbrYj2Pa6jRJc4ywMUfSCwGWNUNv7w+WhHA9W8M7yKtkN36
 mr0PUtY3zVBFaZOVNxxceOq0BNnoAf+0ssZwxi62gUEbcOiv/Tpyl+k1sbIfeuVVbyjS
 gJv20Y12E9DzFR9urffK+7n7+p4ugYvVBvGjXkMq/UMXEOs+5Fjx4oa9HQChkEpH8P1z
 efrTpmyLDqmaDA0yUV4qgdrfXkRpf/gNP3k8JBhE4srsr0AB7cin6oZDj+x5OZAOAgkk
 bs2w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772062490; x=1772667290; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=omsa0OPHbgy206a8oWkEJczcrnsnn7HMZ22HUH5U6j8=;
 b=ZeOnT3xqWy8L1sE7czSQnh+F9VUz3g9pbZkGOk8NmWsQ/uU6Kn3fHm/b6i1dVnyFbv
 weMDGLRQWWqOijLMqP/2gtnqL97HzB0FyhYVgcbNGrUB/29A+v4wKMnZgQF3KnOyb83C
 EHkNgcp8rwUEYed5OXAbHvk011sB4PlQvOD1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772062490; x=1772667290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omsa0OPHbgy206a8oWkEJczcrnsnn7HMZ22HUH5U6j8=;
 b=TbFLQlplBv3bbxt1ECrS9y4IEfnE4TeBlaCNTKY8jJeZ8p15YuZqfQuwyq5zc+PRN2
 8D3hhgQEMvsJJ4mDqDDLkoqaib9Brx3Q8Re9eUXZnvZAovb1M65l0I9rqHALjgTgR53k
 KY2ekh31kjAQ6jKresaLa+PncjuP/xpnDAA4KmniMQlr/HTcq8DqACnCJiFLeM0de8uE
 Aaf4aFLXzF3fy2XgFDjjcmHRBRLuFjdkQn3qGxC2AEPz9XCLi2dqIfm4FGEj40kB3Arm
 MAMxXVm4UmI/RCKfy3ZNnLrliPza2LBxoDuwx8x2n2mxWJxDatj6MMgwVzRS3lWEvusu
 nAnw==
X-Gm-Message-State: AOJu0YyMz397nB+WTBLx8GkAo6+NBhBdPtWdt4cVKxpaqI+bmhzMBgCQ
 fjOKCqjreJ1fFhlA9vpnXmYCQDWBbsly7IfgXGXlIu031vRl7owz0DQKNvXqJ6ueegLJB96IEa4
 BFUzihJd3KnDEtPIM/3E2r6g909Fa4UmMkNf9Y4Qf
X-Gm-Gg: ATEYQzw53XIjXyNPibsE27wqJOhzflI5U8nGBvaPuECUNpUw+x/j8c+5haeiPqJ4fK4
 oQNBO5yroyurOaWo8spFYXLoXv/6Hu5Sg4+smK/yBB8FDXUKJ8KkrBU75BbKQoXA/g5lulY/3WY
 VvQTb2xxcFA1Z27jeyMchUdE9DvuCsXx+USzX8qlxoBzB98tkd8HKhxYrlJKgrkqR/BeeGB7/4V
 gAA1/t+vfGTaa69C3xPsJVJuAVjS5H07y+dPKyf9QcjgWrWjG6Ks0nVSh94rdIJfvo8frM5zDUo
 thZ4yA==
X-Received: by 2002:a05:6402:520e:b0:65f:a428:e008 with SMTP id
 4fb4d7f45d1cf-65fb66200bbmr62824a12.5.1772062489839; Wed, 25 Feb 2026
 15:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-2-sjg@chromium.org>
 <20260225225453.GZ1593142@bill-the-cat>
In-Reply-To: <20260225225453.GZ1593142@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Feb 2026 16:34:37 -0700
X-Gm-Features: AaiRm512ywyJbSL_25U-eDfbrjtENLTQ00keGf0X4MLZjuzq87i5dUQC4GSppGY
Message-ID: <CAFLszTjp33ygXW0NYXwan1VP_5RwXytiFXLfStKGF4gv6vA7OA@mail.gmail.com>
Subject: Re: [PATCH 1/6] binman: test: Renumber duplicate test-file prefixes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 25 Feb 2026 at 15:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 25, 2026 at 03:50:30PM -0700, Simon Glass wrote:
>
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Quite a few test files reuse number prefixes that already exist in the
> > test numbering. Test .dts files are supposed to start with unique
> > numbers.
> >
> > Renumber conflicting files and update the references in ftest.py
> >
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
>
> Since the numbering does not seem to matter, can we move forward with
> some other scheme perhaps?

With so many files, the numbers are the only way I can easily tell them apart.

Regards,
Simon
