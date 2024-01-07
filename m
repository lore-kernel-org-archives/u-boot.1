Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA323C47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 16:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917518781C;
	Sun,  7 Jan 2024 17:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Guumq8lT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C23287640; Sun,  7 Jan 2024 17:08:16 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BD38781C
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 17:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d48a8ed85bso3102025ad.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704643691; x=1705248491; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6WjJ+fzl9S0MUGXMBQp0qxwLgj2+MexFsi8zQEn9u8=;
 b=Guumq8lTtmH1k2BZuXJEhfwtYMq6Ulj+QXi+wuKZxHjLmkHE4H0sDkdw7XxhFMWcHL
 3EbSbUfDuhVE+C8BTuHTaniwiZHeTpL2pVL4gdXcyOFSpEiYPt1rsSed8EHJFzQJ85s1
 3LYN3VF69ni2XrowFcRS2jicf2w9mfif7IY3hQ2cOFJiM71X3UCjq0VRc0fWWcJx2bnq
 e5GehsbDjLWCXASQurcpgB9zUdgHYpx6QQptWKT5IpqWpWjhMSKb1EK+S2gi3K1ceWsZ
 Lz3sK/EyNOAXrMEkVUTg4wWwVbE63P0ABChCVTkus+hFEek3LyJ0ulDDI3Vb4EHvnWf1
 Cr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704643691; x=1705248491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6WjJ+fzl9S0MUGXMBQp0qxwLgj2+MexFsi8zQEn9u8=;
 b=WFF7UBERkYKk/zxRtPB7keU6umqHeXM9A6njb3M/sNjWl0iYWLQDHvRchseEcgbubI
 plAwmOBZqILz98k8a98+IxAIFb+l5TVcX3HsuuiP6DslS+isjCxD36+O9AbRfoSPx0HM
 xQekw1eXOH1a2Bjmx3zsxAw38/Ovi3xi2/l4DtoZpKEIf2XB7UEue0KyGENre5kaR+yV
 LipQEw1B34FJHhEAPV/K6tgI542IUaXNsEK320xs3Otf2y95A8rT7EcXsSdfE4Tq/yVb
 5UBpMYyFRaAXREA5Kh6SMNinAWm/eOYrj1JgK06NhKFbOjzWou06MOpo8FK3HtSzvEiJ
 6/MA==
X-Gm-Message-State: AOJu0YyQ80896FsKO3NxUINbh+BkKyOjLZ7FRrvorVHU/ll7qFhHzTD7
 xijlkxbqYz3BJj0tm7ZOF+KVGCFwRLePcIJfiTo=
X-Google-Smtp-Source: AGHT+IH6MD7k5ACXjxc76zjrXbg2pBOTqx/8B5bL9knWvyi4XSqVR7jdJ+ZdEUWcNdqb/bBuKo++b8FRF7hnI/XxykA=
X-Received: by 2002:a17:90a:1f4a:b0:28c:2cda:abb with SMTP id
 y10-20020a17090a1f4a00b0028c2cda0abbmr3518707pjy.3.1704643691275; Sun, 07 Jan
 2024 08:08:11 -0800 (PST)
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
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 7 Jan 2024 13:07:59 -0300
Message-ID: <CAOMZO5Aa4ynpHqfqiAF6qAJmTJeAPQCmT4wyTz6H+UE3yX0jpg@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
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

Hi Michael,

On Sat, Jan 6, 2024 at 5:49=E2=80=AFAM Michael Nazzareno Trimarchi
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

If you submit a patch, I will be glad to test it.

Cheers
