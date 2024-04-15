Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63610C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE5A881EF;
	Mon, 15 Apr 2024 15:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gihGXDLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05ECE88229; Mon, 15 Apr 2024 15:03:38 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C4388137
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a51addddbd4so369885066b.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713186212; x=1713791012;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAHgXV51xzX2caN9nlIowz4Lg1pL2u4rKxgoGnol9Tg=;
 b=gihGXDLn7GvAfsLfpKU3NBlKgM5p5dHrN68LZIjr1oiQVzBKvZJ9q3EBCSMfgzNsOs
 vdCa/Fk1pvVS4NRlziGtBQWTJxne28XpArOg7o8CExXFuQwNYSxPphkpKiV1fyU83533
 PqaIcNUmnb6DWgiU7n3zllElC28qWp+nw64ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713186212; x=1713791012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAHgXV51xzX2caN9nlIowz4Lg1pL2u4rKxgoGnol9Tg=;
 b=YUnxKkSvifnXhpcXNMTmAv4LCcLvHK3m4W4qA9f3RC0ovbBZMjEZORuuTQJM1RxAz3
 yZRownQHI1enjFqFv4aN/i0WXmjQHvV49ptx5Wgd9DozbRmFZxCGaobOvcd6/rSTZfuv
 Yd9+f/qfoXCxMOwYhKN8xm0YYZCkZRceJVeFRGQNg/gqjNZJmuJ3Efh7LynSN2cOf7ZR
 RD4Pivxw2Gcrmn1GS1q87y+1rUViVJzWg5p/f40pSNkfLKw9YfgOl4PD+jHRRM6SGONp
 VOKdWSJ+Fwg6elH5TVvCJlmCEB5YcegSeS9R7u24DxQ1YQvAqC5nh0fOH50szN+ryVWb
 6VUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiu2vCxIy7GM4l/iUTpG6vCV9icJ+rCYsBrxkdbljlCLKc5DETiJdfrsqkljLLZ0PsHT9mmc0zsbN0tSvrPUB+YSnnMw==
X-Gm-Message-State: AOJu0Ywu7Gp0DFn6vmtfS7idzZz2kz1/Gz572qh4oV9Jy9beltHMYaXs
 ycw/qcWbkwBzuCZE6UjBMgO78XmzaPDW8f9D1ud4PoxVxxBx1CGe6Niv4ARuXpYeggyBhkYOsO9
 hd6oEEymoJ1/bZ3/bdPsY3J7bLKA8F3OI3qLNHQ==
X-Google-Smtp-Source: AGHT+IFeaHKwmFrYIL4T3zVNt/6S74DZKPAz8/MnPqCz1fxjB6jIC4SN7kWKP/0P/FWJiXrnN51MxR0xlI5PFUYVdL4=
X-Received: by 2002:a17:906:7f15:b0:a51:b752:7ed8 with SMTP id
 d21-20020a1709067f1500b00a51b7527ed8mr6117003ejr.25.1713186212113; Mon, 15
 Apr 2024 06:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <20240415130013.26721-1-yasuharu.shibata@gmail.com>
 <20240415130013.26721-2-yasuharu.shibata@gmail.com>
In-Reply-To: <20240415130013.26721-2-yasuharu.shibata@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 15 Apr 2024 15:03:20 +0200
Message-ID: <CAOf5uwm23ck7uwr-tAZp=8L9HVb_A0r6BYNZ3C0KCaTNkHG8Og@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: wget: fix TCP sequence number wrap around issue
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Mon, Apr 15, 2024 at 3:01=E2=80=AFPM Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> If tcp_seq_num is wrap around, tcp_seq_num >=3D initial_data_seq_num
> isn't satisfied and store_block() isn't called.
> The condition has a wrap around issue, so it is fixed in this patch.
>
> Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
> ---
>  net/wget.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 71bac92d84..abab371e58 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -404,9 +404,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>                 }
>                 next_data_seq_num =3D tcp_seq_num + len;
>
> -               if (tcp_seq_num >=3D initial_data_seq_num &&
> -                   store_block(pkt, tcp_seq_num - initial_data_seq_num,
> -                               len) !=3D 0) {
> +               if (store_block(pkt, tcp_seq_num - initial_data_seq_num, =
len) !=3D 0) {
>                         wget_fail("wget: store error\n",
>                                   tcp_seq_num, tcp_ack_num, action);
>                         net_set_state(NETLOOP_FAIL);

I think I have sent some time ago ;)

Anyway look sane. I was having the same feeling on code inspection

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> --
> 2.25.1
>


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
