Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBC0C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 03:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE4AC875C8;
	Tue, 28 Nov 2023 04:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IDKtg1SJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5E3875DF; Tue, 28 Nov 2023 04:00:50 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1AD38757B
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 04:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-58d439e3e15so1529193eaf.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701140446; x=1701745246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrK3Qp/68+9j6zeb0NH2994Bafbtk2H9nNFKb3gIStY=;
 b=IDKtg1SJiSXqWA+PqQ3b7gju/DEvXbxVkj9vAo08hlexqqjumPLuWyEv5TvbCVZOFP
 CR3xV6Is0yovUcektP4kaZ//SJzOUTZhf0SlxSjY6xKG8bbZsthQx4SBO1EHcEnorLLc
 Z8ArV904D3VIg2r3VrmY4d+I4OWQNs1rU3YtWMNYiZCDlZC3naeBpn25emw/RWYH+oXN
 PVTmQLwDsw/DVmabuFDB/fB/1k38MsRN126BuFq+7WmqeMFMzMSRWzh7AitUsUEx2EJh
 zqK07FCBT3U4Ky7vHkMBAP+nzt3+MmVvu10ChwnbEmwum1riUlG4jkozmjxs3t3kspPO
 Aafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701140446; x=1701745246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrK3Qp/68+9j6zeb0NH2994Bafbtk2H9nNFKb3gIStY=;
 b=t+L1ieZyUTHUK//rMul1+UGpqqmKwSoW8ZSDQtlyTmOWz9Lg5r/DLlf5ol5hdfxpfW
 sfzE0AUVoELvvkLd3YU1hhM/hcXHU6LVzSuCaM5HWHKQI9n7BOtDUQu30/ON2aA6TYcO
 8Ux0N3ofkmX6x2TB+2xL4x7gIUGFhzqFkP16B3qqN6hjmqYzgF3pVC+c7/mjXzdqc5ZO
 +6fwTAVdRie1/Duciv3Pi1h5u/wq7Yw/kQVsHJLXoeleMJV5gluA5YyRz0puh+8dh2pR
 yl6dnc2Ecazuz7B7b/JBVB3ss1+Mu/Y+Lf0Yho8r6cWuCeLjBVXkz9HWxWQCO9VcE9+y
 XpQg==
X-Gm-Message-State: AOJu0Yywq+gv1R3qX7UZPqL8YAW6q7H2g9zX1enSqdgsa6D6XPO197DS
 hYTv62qTi7U5bN2ALbnRchSBmF9cZME7Tp3eMzc=
X-Google-Smtp-Source: AGHT+IGAqPmp1+H+vTvi6FfJSCs67SWhrdRqVEYaL5Zf8+sYHVQTeTB9ng9xCSJTaZwnzTvmSg3z7MC9Omu1eRyDESo=
X-Received: by 2002:a05:6820:16a5:b0:58d:8f17:6606 with SMTP id
 bc37-20020a05682016a500b0058d8f176606mr2291154oob.4.1701140446378; Mon, 27
 Nov 2023 19:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20231107201349.5775-1-semen.protsenko@linaro.org>
 <CAPnjgZ0HD41x+c4je61AkXr6c_QUu2-QJCdHrxLgDLrQL7B9Pw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0HD41x+c4je61AkXr6c_QUu2-QJCdHrxLgDLrQL7B9Pw@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 28 Nov 2023 12:00:34 +0900
Message-ID: <CALrBrZ2y1zuZLwQrMDP3dnZnkcaZxy1Lx03C91Dv4-q1HZOyKw@mail.gmail.com>
Subject: Re: [PATCH] serial: s5p: Use dev_read_addr_ptr() to get base address
To: Simon Glass <sjg@chromium.org>
Cc: Johan Jonker <jbx6244@gmail.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi!


2023=EB=85=84 11=EC=9B=94 8=EC=9D=BC (=EC=88=98) 14:04, Simon Glass <sjg@ch=
romium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Tue, 7 Nov 2023 at 13:13, Sam Protsenko <semen.protsenko@linaro.org>
> wrote:
> >
> > As the address read from device tree is being cast to a pointer, it's
> > better to use dev_read_addr_ptr() API for getting that address. The mor=
e
> > detailed explanation can be found in commit a12a73b66476 ("drivers: use
> > dev_read_addr_ptr when cast to pointer").
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/serial/serial_s5p.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
