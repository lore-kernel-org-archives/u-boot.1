Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308F7C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3E2882D5;
	Sat, 30 Mar 2024 20:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QHM2q/sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16CCC882D7; Sat, 30 Mar 2024 20:52:18 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4E4882D5
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6ca65edc9so915842b3a.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828334; x=1712433134; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Hvfa8EVvjwYWUx4JsfwZngEVibFrW3wtDsbWRPwGdM=;
 b=QHM2q/sw8VY6YqxroRw0si++3V4XIw/UG423f1wgnZ0b2GBMrodt0YXzSV9wQR3wx7
 qtPYqHwJgUkDVnNM+yDE280wn11T636+wZ08kttm3RCUQBEIaHSyRznhmuhz8+dWdUhl
 TiA3wkOYTb3t0opccepdumjSVxlb3OHNh0BXgZdXlz15T9kFhsZLyU7KR6GvYRyHp8cb
 Yt9N64mJGsYsindPzPTnWbMZE6ufGquOaH06BbHbpHJmhuZ3MEOlI+/aqqLwVSEz4riX
 EcZbsn2/FmA9+Cq29/qD9ElLyyufoyLPB81eiwTiDbd8oR8jlSWanLhI7jqM83Fj3vKT
 8T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828334; x=1712433134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Hvfa8EVvjwYWUx4JsfwZngEVibFrW3wtDsbWRPwGdM=;
 b=ljfYCqF4i6J+NH7rM3pKXQAsc+auyxS+5NQkkWbPySnVZqyRAjZrYSZp2R0kw8fPE6
 WPLFG7f3s9BMq1eh7yKWMfZVmGKY1KZv4vBx9aO4rtec0y+bjazWooT6Kmxa8VCvmavG
 lZy1qAUJblpOu+jJwqWXkLBK6y0lOyglW7mCh2ZH9wzQ86a0wcCXjzeakIGiSVx8tn6s
 od78YL/MkWPiWuqpk02bvNMnMYhwqk2a+jf++9ewJxZrK5bQZf7TZ+9OHRMhYkXC+gIY
 sKuhd7U69RcpOV4tPQVfz48CLzuVeu2bVnfk5NrQ5MNvDWNqWlg6VUOMUcTZgXNuJCJ1
 pFNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvrUK+2a/bwLOPl8rJliSiLqLdXN1OU3GQCaHkNJkSKIWdhs8FUs+c8YsqcScJ3fqy5bJkrVuxX+qSWEbDNMMxq+ta/w==
X-Gm-Message-State: AOJu0YyLf7lzkeX39eK0dUHm+NvHmADoNAxW3aM79fhsXo/AZchyviVU
 iKw6HrOpjzOU5f8edbp3RX6jnEWFWa5IBnqHho+hVNOf+AwOE5y8pKjPfqOtP6ePpzPyDBYCwxT
 OH5MSam8d1U62Uzf5D89VIfVSqXc=
X-Google-Smtp-Source: AGHT+IFUwCBGds9LizJpdyWMnVAK1KGli7mWAxAQhytU8flyYgwY9UFxfZYpOunk9UeXVffKheJqByd/ugxUF1/4xSI=
X-Received: by 2002:a17:90a:e584:b0:2a0:30b9:d57a with SMTP id
 g4-20020a17090ae58400b002a030b9d57amr5408247pjz.2.1711828334492; Sat, 30 Mar
 2024 12:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <1711623479-62657-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1711623479-62657-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:52:04 -0300
Message-ID: <CAOMZO5Bz_7m4Rd3UaTdVWJY+hYaOoBpazaw8YCJgKC9nRCb97w@mail.gmail.com>
Subject: Re: [PATCH] net: fec_mxc: Avoid enable regulator failure
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

On Thu, Mar 28, 2024 at 7:58=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> Change to regulator_set_enable_if_allowed to avoid enable failure,
> in case same phy supply shared by multiple FEC controllers.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied to u-boot-imx/next, thanks.
