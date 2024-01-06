Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94231C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 08:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A7F1874CC;
	Sat,  6 Jan 2024 09:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LWDRReqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B4887751; Sat,  6 Jan 2024 09:49:22 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7375487227
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 09:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-556c60c3f9aso345149a12.3
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704530960; x=1705135760;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4j7sXK4FAg4+Hu1u2O572fSQsuhPW9oMsSdDl1G6Mc=;
 b=LWDRReqYht7yGmQF/FWGb+vjk4erz+IoJXfv/fp3TWNfs5E5qt2eWZ9WI0SiJ9tKS9
 S/9libbhi5kY1/BQMERbs5IgpjugHkuG+MuNTlqA199z0Mp2jgmBHlqrD2NjfaJ4I7i9
 IWuVWSL6giEEh5P31RXr2ILjpW+Wa6hY7tUvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704530960; x=1705135760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4j7sXK4FAg4+Hu1u2O572fSQsuhPW9oMsSdDl1G6Mc=;
 b=CId3TyTG/zjJxjSj6uMPZjEQ7scOn7IHvKVnCddgZ4XB/okyV+0DSOf47la/Zakwwl
 S8ktrwgCE2h8/kKnYOiLSLpZZ+e/X8lvzuhQFVfx005yMuZQ5Fhst7sQaH8MvnWM8A2O
 dEDvl9fsKlji3nwq932rZQndqBKZi7MQhkf8fUTroG1HxLummWMLUjVhg5WT6FLwbreU
 1aRHMYxFPnxcQiGIw9IT+E7loZWHT2IENLv5SQuYgcnYeNHNesMVYTLwXsXdGE/6mtby
 OHYScPvkvwtPSUqMPbeVh5w6wiZI/kuiEmV/n2bPE2fBzrWRZ5/FZoQtBI+xdcobs6NC
 TVOQ==
X-Gm-Message-State: AOJu0YyS07cT5gOP1QLqpJgZlcwRm5GonwL2YZFGDryB4MVS1BEuzTiP
 JgS8DbHVFhUouRjAoU4x0jSBMNwr0t7vOqiq8uPjkc30cFXYtA==
X-Google-Smtp-Source: AGHT+IGm9KGmKp79Rbqwt2vvzFbWsx5Vtq3cvp43ny8i40OLZyP9VjfCuDEsN/DWXqZ3JiVUq3Q5WNWzCegSPlOv+ko=
X-Received: by 2002:a17:906:8a58:b0:a26:9ff0:8b6d with SMTP id
 gx24-20020a1709068a5800b00a269ff08b6dmr231049ejc.121.1704530959609; Sat, 06
 Jan 2024 00:49:19 -0800 (PST)
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
In-Reply-To: <CAOMZO5AqatVOGsJGwxXJCoF+tBemrfM8+pgrRCvDwHNHv1caFw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 6 Jan 2024 09:49:08 +0100
Message-ID: <CAOf5uwmb0vJOwSj81KvfWpK6yobyz0Ozm5vDGCa9K0rZejbZLA@mail.gmail.com>
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

Is this code correct?

    if (tcp_seq_num >=3D initial_data_seq_num &&
                    store_block(pkt, tcp_seq_num - initial_data_seq_num,
                                len) !=3D 0) {
                        wget_fail("wget: store error\n",
                                  tcp_seq_num, tcp_ack_num, action);
                        return;
                }

Can not be seq_num wrap around? Another point seems that is not
guarantee packet reassembly

Michael

On Fri, Jan 5, 2024 at 8:53=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Fri, Jan 5, 2024 at 4:49=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > I was thinking that was lwip integration
>
> That's a different issue.
>
> If you want to test lwip integration, you can try it from:
> https://github.com/muvarov/u-boot/tree/master_lwip_test_v10



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
