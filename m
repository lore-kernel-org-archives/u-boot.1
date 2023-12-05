Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F22C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 11:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7125B86DD1;
	Tue,  5 Dec 2023 12:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="1G4VuBHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E4B8772E; Tue,  5 Dec 2023 12:13:40 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF85F86D12
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 12:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-548f853fc9eso7060966a12.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701774817; x=1702379617;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPmcKMnN9cNPp+saV71SwCmnUuy9G7pzygPtAIGnYcw=;
 b=1G4VuBHoLjk4OHlyCcEslFlSJtPZ+T4jkFYDX+/3UTJWDMdCShVtjD8XHHlXQIKGUR
 x3PY+nHlBy33sYz5dFMF/wQC+pZj0EsRLIqMcljEz0wgWN/U1U3mgDJHu3k96A6CekkL
 qNYs/oLEzfeu1nV+bitpB2M5ZzPE05RXnUWJxcqDgUCqTm2aEByC+ygv+YYRT9m/6Cli
 yN4bhYKSmIp+FdtBm9NpEdBUwFYzwSfUOKcpgNor2fdygP20PTBq4GTBEd5uL7ZhY3mj
 143HooyQc6viaT9MzX/Us6v8QwrTSTficMtOWJptMgZ8rgeGKvgOtqPDwJqsfoFQ8fAk
 4xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701774817; x=1702379617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPmcKMnN9cNPp+saV71SwCmnUuy9G7pzygPtAIGnYcw=;
 b=sYtCl1OxJtNYRGfKOcMKLbsjrB6A4h75lyYjuycoEqrzf61NIQBm5aARyct3w2M8yQ
 uYb1FmyJ6/tZZpCMbc75gqguHT1xWRFaSZmkMeDE5rTwZEdJJPdPprInxTo1xqjgXapa
 CIYrL3tq0RgYspVDl4BTmj9y1U9PKPOyu7KvxmHcxZnuKyHDRQqXL+m5lKQ3fFEVpM3s
 XR8lbzY8+FjQaLAAtLgLxjaXuwSMYNvplVAQe/5eXmCa66tYKGATV6Qex7zgLs2+A/Ez
 WlHQ/Azm1ESd+MVOEr9tsyznRI4DERk7bEllSmBL0CwNND1OWeg3l/xTUKi8nRy31mFx
 r/8w==
X-Gm-Message-State: AOJu0YwwaGEWM+Zi48fZ6Yqny3x6IeBp8Fg76UDfbl2kLxmA3DLUQYBX
 Vwo5P4bc5oHslWtEIysn9V357swHtUd4+S63SwauAw==
X-Google-Smtp-Source: AGHT+IG8t6xWc5LLJP9Xera4a/nM/TmCggvWQzJEAi0fbSaNTLNapWnqT2Gd3WBwpGEVf3gjJLHYsQ==
X-Received: by 2002:a17:906:fcba:b0:a16:88e8:2de7 with SMTP id
 qw26-20020a170906fcba00b00a1688e82de7mr2045849ejb.23.1701774816707; 
 Tue, 05 Dec 2023 03:13:36 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com.
 [209.85.218.52]) by smtp.gmail.com with ESMTPSA id
 lo23-20020a170906fa1700b00a1cf0d8d514sm111889ejb.79.2023.12.05.03.13.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Dec 2023 03:13:36 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a1b75f59a12so250952366b.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 03:13:36 -0800 (PST)
X-Received: by 2002:a17:906:dd7:b0:a19:d40a:d257 with SMTP id
 p23-20020a1709060dd700b00a19d40ad257mr2154111eji.291.1701774815959; Tue, 05
 Dec 2023 03:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20231119165501.1305136-1-i@shantur.com>
 <CAHc5_t3MwUvFdQQaZGeONxS-JNuB4mYXyU9YSexN8bCbQUTRYQ@mail.gmail.com>
 <CAPnjgZ3umb6g3O7r+bNtCpGihFHoq9Yp3Fnq9Hd-VkQvewX0oQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3umb6g3O7r+bNtCpGihFHoq9Yp3Fnq9Hd-VkQvewX0oQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Tue, 5 Dec 2023 11:13:24 +0000
X-Gmail-Original-Message-ID: <CAHc5_t0+o5FvgpLUDAWLq6932fapzVDy=+47LQUcsAPT-3arWQ@mail.gmail.com>
Message-ID: <CAHc5_t0+o5FvgpLUDAWLq6932fapzVDy=+47LQUcsAPT-3arWQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] bootflow: bootmeth_efi: Fix network efi boot.
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Tue, Dec 5, 2023 at 12:52=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Shantur,
>
> On Mon, 4 Dec 2023 at 05:38, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Simon,
> >
> > On Sun, Nov 19, 2023 at 4:56=E2=80=AFPM Shantur Rathore <i@shantur.com>=
 wrote:
> > >
> > >
> > > Currently bootmeth_efi crashes while doing a network (dhcp) boot.
> > > This patch series fixes issues and both network and disk boot works.
> > >
> > How can I help to get this patch series merged in?
>
> You can check patchwork [1] to see who it is assigned to. I don't see
> it in my queue though.
>
It's with Tom Rini I believe but with status Needs Review / ACK.

https://patchwork.ozlabs.org/project/uboot/list/?series=3D382855

Kind Regards,
Shantur
