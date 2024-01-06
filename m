Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE810C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 09:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0027A876E4;
	Sat,  6 Jan 2024 10:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PLdAxxhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8193F877DA; Sat,  6 Jan 2024 10:01:20 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41875874CC
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 10:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e67e37661so416425e87.0
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704531675; x=1705136475;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/QpDqPQMO2Lt0MXZkj+G3NerJmNV+cdsoCW+vDqmo0=;
 b=PLdAxxhKFJhhZcKHrbFhpBF02dya0e0BpKPt3ZTJlqooUKsGPqeIxmL7Xc0+MaJ0HJ
 cTYV+Q9aOpOkvgbcefsQ8QS8GYqazBarcmrJ3uJ18edEF6lzJeGhLY9evOyFclpk9uP/
 tGsBZStjiCKTzeoiATI9lUt7bG8ynVamvjd8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704531675; x=1705136475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/QpDqPQMO2Lt0MXZkj+G3NerJmNV+cdsoCW+vDqmo0=;
 b=TeLbDgX2oH+QpQ9+ByjVyk+AhCoJkst4IxkQNo0Jt/IvYaZiAJLmBMqxZqVFDAuDvo
 +OrKUPUH5z4Sc+xPwtfFNu9oh9ei46YfVittipl20nTBoB+G4smnLbYmrb0tLbDq0IuE
 reB3VkVOcddFejiEnp8rg7zkdQhrWUlRik1K6beCK4raZkVDxs0+d+gfdwIH4VWXuz8f
 nQUUPlpjhVwurhc2QTY0ic/FURUPNBq2YN8ZKnse+yvAOBRyD4uKaDHN9Q0kTAqmB2v3
 Rx5WBmOWMMTU7rjaN1qfUzkUUEYCMmlUqPvpzdTCdpVP/Tc00lB0e3w9fsmGo4AsEvD/
 SjNw==
X-Gm-Message-State: AOJu0Yxbj5veTzOZUMMQcAECX0dPtkTjjcUOddwTmDODUa8/6i0Rqzek
 5EYkrPLA8Pme9RXDyqGrNJGBGMk5dDNcAITjsGztMraSnUwxaw==
X-Google-Smtp-Source: AGHT+IFfPoS+NNnLgr83Ym8rMKVGXcelwoesLvNz08n90x55xqWAV8Kd5ctTo2h8KEwnJpyDkbSciB05Y2Pzh2S3p+A=
X-Received: by 2002:a19:ca53:0:b0:50e:8137:9a10 with SMTP id
 h19-20020a19ca53000000b0050e81379a10mr245712lfj.129.1704531675149; Sat, 06
 Jan 2024 01:01:15 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOf5uwmDZ5DtAhe-GauhuyYwSSXQnavVNfzaJkdSG3TWE1N2FA@mail.gmail.com>
 <CAOMZO5DtCDe-VzY1yx2f+LTz0tCqmtiLemrH=xTnPQs7=07aSw@mail.gmail.com>
 <CAOf5uwn1LuN6uFQe9d7zXWDFnvOAqwb-etQow96fzAR0qim5Hg@mail.gmail.com>
 <CAOMZO5AqatVOGsJGwxXJCoF+tBemrfM8+pgrRCvDwHNHv1caFw@mail.gmail.com>
 <CAOf5uwmb0vJOwSj81KvfWpK6yobyz0Ozm5vDGCa9K0rZejbZLA@mail.gmail.com>
In-Reply-To: <CAOf5uwmb0vJOwSj81KvfWpK6yobyz0Ozm5vDGCa9K0rZejbZLA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 6 Jan 2024 10:01:04 +0100
Message-ID: <CAOf5uw=uzWy=M4jLwEd6w3G8CosUPzy=ouXxW5eWC-AzUrNXyQ@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Fabio Estevam <festevam@gmail.com>
Cc: Paul Liu <paul.liu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi

On Sat, Jan 6, 2024 at 9:49=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> Is this code correct?
>
>     if (tcp_seq_num >=3D initial_data_seq_num &&
>                     store_block(pkt, tcp_seq_num - initial_data_seq_num,
>                                 len) !=3D 0) {
>                         wget_fail("wget: store error\n",
>                                   tcp_seq_num, tcp_ack_num, action);
>                         return;
>                 }
>
> Can not be seq_num wrap around? Another point seems that is not
> guarantee packet reassembly
>

And what happen if you are going to generate out of sequence packet
and with large seq_number on purpose?

I think that lwip has much more sense

Michael

> Michael
>
> On Fri, Jan 5, 2024 at 8:53=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
> >
> > On Fri, Jan 5, 2024 at 4:49=E2=80=AFPM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> >
> > > I was thinking that was lwip integration
> >
> > That's a different issue.
> >
> > If you want to test lwip integration, you can try it from:
> > https://github.com/muvarov/u-boot/tree/master_lwip_test_v10
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
