Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD873EF48ED
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5737083015;
	Fri, 13 Feb 2026 09:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VS7wNCHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD68A83AAB; Fri, 13 Feb 2026 09:41:47 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF84E80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-649e97f1e99so622258d50.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770972104; cv=none;
 d=google.com; s=arc-20240605;
 b=lyrelRCqzGIiQHJilDKxqEROcNjBgkfzLjmhZacEUNd5FsUhWujYcka0MceeC64PLV
 s22mmGIPhSbbYYy8IDlujsdspDuUmTo13kGqiWCl0doJQ13ClKRc36WQ8l8h03yCEm0C
 uUu/Gp3ClVo2Ti0xDSkrTz3UY5AIQc+MBPQQi7UiMMB6g9ll6/Trz+vq6QaxR3KDnPWd
 evtf3Ggs4DHva3aHdf/xrUCuZBHpM4xg1UnhOmauXzQPx2sOuuIKoCITD3xd+hfE5rJh
 Ea96SX61WCxWwvgGTMc0WHC+UVlSGMqoYPZR/QE8eMy3KwW0+PxvGzJ2OD8RBmi1tr5M
 o6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+SlfUOWxQLAbIk1rVobJ8ip1UT54yaMbIJTvrhARV2M=;
 fh=vyfbts51IeL9YqiXEXChvJnWUKQFbZdi8gERlNYTnqw=;
 b=E6l9zdMjne86VGtiIbpmeqbP+1EyXpwJf4ptGRm18MmXzoDKcZcjVIKxhkXlrPQJI9
 3lo+0MZ4/TlSgpurcJHjModge3CCfRLy4acXaFdjkaNQNnKiybTCBX/PG5g8zqBP+fR3
 uTzNp9xiM6uY1jAIVUllwmUtg5c3Sc5rSTe9SLPRF9qkVWxITZ0O+UJbu1lGsa1xV7jv
 pllA24MnrRvDQutzMZiF/Y/CTkPvohPwEmz3amCjRuk+2Or+RDhSOgVSuNnxaCQteAVD
 2Fd/iDgcl1OFMCxf/VH+J7nGOlYu4XUivWvtBGLTg0KWRZ8xmjX3euNf2em25HQy79RB
 16dw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770972104; x=1771576904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+SlfUOWxQLAbIk1rVobJ8ip1UT54yaMbIJTvrhARV2M=;
 b=VS7wNCHXS/oO8faXdOfVSqLFh8ur7HuFUUFdXVL+TPeYYb0eHvaITAfq2w/ICNpUtB
 j4uSA1gakx1xan2+UgbX1KHqPv6m3U3m1lZCQWryU/1ra6qohH23Y3vxgT3z5xCRdtDQ
 8nkWUy9qwRn0AwSZcIRv4LIbUqw5ElUU3c+BtsmsrH+Klwl9NDRHiJR4kZRzy/lHYRKr
 EJE6av/K9nGXYRTg1woHz9p9Nex/fzLjOuk1f8QuvS2CGsg5r0N7/GNHMAtmmdGE9L+k
 yqvBndOPrO6UF/Vjl42+IGYS70Ad48Tbw1bk7AEtJpMgCmJR5R6JDt0cjDgv0a69cM7E
 nHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972104; x=1771576904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SlfUOWxQLAbIk1rVobJ8ip1UT54yaMbIJTvrhARV2M=;
 b=BO+8gla0QTV1CRUSeex95NwJQ3Cu1la+OyOyCU5O1nDP5a0vmjnGuERdjYkIruoC3+
 4dgVrtCz5pn2D4TiEP9NmTXy7GXR2xbrEBFkiSh6DsQEta5ssQ+Zkrg+4gfQOyzVz+GF
 V2/oFTomYmIkek4HIav5jSdv7A7BhPQ9nem+BgwLEHQ0FYxOR84EvvzH6YvBkVba2aJG
 Al4P26CA0gO8aM0SGQ8f9CdwdoYH7EGxZEmiDblL7AbWSCXsBpiXWUpY+C3JWj0PyA6C
 RvGUTH4a4RZ9y/XJ7xkt5/Q7wEYiZ0n3YPOstLXdKGLDpMrz0a+dXSogaUya3dNmCztG
 RAeA==
X-Gm-Message-State: AOJu0Yx/jxYisREQOwchgAyO1TkUTMWmaxliMBv7jaI52relD1sVCWpJ
 IRB15DyMSG0xcuDe2r75cMGlfSUXoLFKABlKv0z5tAJmnelGfZ+0w+1IPBnNWX8tz3SSyfQeVjp
 WclijN9MTp8MkGdlFtt7/AdlHYbv5tHYsMqCSyNW1zQ==
X-Gm-Gg: AZuq6aKNgXs6ObDMjM9yWilKz8vWO83LAb3rC3VlPOiMXQaZQEu3hUinLoogjuQ7hkm
 Wak8t9HIgz0AoIi8IeB8ilJBoYC10k9SB6ZYKSnDpiY+aVEx2ddlwzy9t0VckVpMSlO/jHWsXKG
 ArpKe9/0F66Q2l2JBhwvbTqNDafJ7r2H9nrUX8EOAsqbP68QpYWIk9tzjjxjv46kIGAI3klzVYn
 PDYUGEci19fix6toQHt2fwOcyJoo6izyghyMYXJeo11jVHjBR/KxUoGlIp/95qGgyUQwKScp7cW
 V1NTJWSqhWVIo07O4QpqEs/gmaQqt4Sk+csIugai1r7VTbwV1qy9CDLqysk1dU9xngodQOrtPOK
 F4WO+YwE3svMg80rlZinbVpIDRx+ZqESdS3NJt3sysc0hY9IScxjlR7L46Eo67x1/kYVjgZoLA9
 FkhnicccjMvFUYkKQ86VPsxoDH2oFk89w6ozKoAr9YwwP+nu+wjhjW0/0hfYsIf6x1r1drTodMC
 fTmQlXkGbYr9r8XGVNkx9xcR62OybaAif55ouL3TW5amu6gk73MueiyGSCMr4jYLvfXGV/5LXyQ
 r8tIEMfyMk9B57NXQlbDvw1ybKZ9okfvE4T1qMAqKkpZBFYyFnE+rmM=
X-Received: by 2002:a05:690e:4146:b0:64a:dafe:fb5 with SMTP id
 956f58d0204a3-64c197ae418mr768060d50.23.1770972104412; Fri, 13 Feb 2026
 00:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-3-javierm@redhat.com>
In-Reply-To: <20260212204511.619392-3-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 10:41:08 +0200
X-Gm-Features: AZwV_QjZuhWZ_9A_hlobdawQdN4IlrwmHvCn9-g9u4Eiox8CM9nBfBdZlKQJErc
Message-ID: <CAC_iWjJysPTkCTJ10qR8FmNxSBYT6mK7YWoqvxxwez+6H8Yf1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] disk: part_dos: Align dos_partition_t with struct
 partition
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, Tom Rini <trini@konsulko.com>
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

Hi Javier

[...]

>         unsigned char end_head;         /* end head                             */
>         unsigned char end_sector;       /* end sector                           */
>         unsigned char end_cyl;          /* end cylinder                         */
> -       unsigned char start4[4];        /* starting sector counting from 0      */
> -       unsigned char size4[4];         /* nr of sectors in partition           */
> -} dos_partition_t;
> +       __le32 start_sect;              /* starting sector counting from 0      */
> +       __le32 nr_sects;                /* nr of sectors in partition           */
> +} __packed dos_partition_t;

This always has to be packed and the part_dos.h definition had this
wrong all along?

>
>  #endif /* _DISK_PART_DOS_H */
> --
> 2.53.0
>
