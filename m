Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E162AC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 19:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA9480C69;
	Wed, 12 Feb 2025 20:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UjC0TNm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B37180BAD; Wed, 12 Feb 2025 15:17:53 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B9E8043C
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 15:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4b68cb2abacso1762080137.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739369869; x=1739974669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sMTOEpIGPzDjriMcfE3z1fAYuZCnOU9pT8OdLZbYB2s=;
 b=UjC0TNm6kd1YtrOevWp4ZD278R2hzXjDDBNNABJ8UTEDV9vylWJKkjn+m0pmJxI1qa
 zG+rw5h9Mr8pfeH8F+u1dJY7yK4yICRMPvmUxeM1qL7PfhYT1EnjwraNv7stZVRLhMej
 S7REPur3C1HF2uhyWtqZx0Qc+qaMGIVoRxDSOLHDoLCPPrwsC4aVuMgRMX3+vjLvbqrH
 Thxi7t8Ko5WqaXztGJ0NV6nM0KFqQhfdg8J6L7wfOheW6cq6sQ5X4XQB3N0v6KFKMzEK
 MCeD48gUQXuQNCZ627P2Vh2q8FLLT+uYZPVNxd006Z2/LtHH7rob4++i7NEfFMSJRxui
 BgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739369869; x=1739974669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sMTOEpIGPzDjriMcfE3z1fAYuZCnOU9pT8OdLZbYB2s=;
 b=tH9yii86mfn92FOIiXOF0rB/NZ4BIaHJbqKloEvApB6cNUjUUSW6DRt7EuOJDKBL4e
 DQe1Fxh3yy+y0vKuCqXJcv3l3ZDlrytX5aXEnWDUoB2sNMr/GKDcn2XKWBe0l7YyBq/W
 m0avVe0busUwnNzwEIMvL0MTkYlVXwccUGS9808np1KPiITgTxNhQpOgXr8dBBgzkK+E
 rjl3/isIVKhDp7BQ7enVNe/FQlgmdnWr2B+y3DzojfM0Me66E+QRIT6+DKmMdTTzw+8V
 QTGtES/TsGNua3O4hD78LOrIs+rumoUe2ZcgjlBYs9mHjc8m61VOexGB7XCpmsqD1MF/
 V/jQ==
X-Gm-Message-State: AOJu0Ywx83ahquuZnkJRzGPzR9uVRnpBjeoCS4mDwaLye8cLh0kaNJdC
 DmkmsGUJKwFXTg0vZvwvbkvSrkUF+GFddcYwHXdVl1XfWPbokRTGc0IxKJSvHIH0/NozyUOOCir
 YYBkUG0riM458myBB6rqROLWjbNw=
X-Gm-Gg: ASbGncuNRN3IHRdzK2Hk4qqET8QC6PvYIgtTPUU6TILzwF/KULDM4kcxvCC/u0f/yV9
 FSRdDfQ0kQ95HGr+PDCtAMGmLC25b0LiXnURzGba7nmCvnohgBfeWbrCewSK5CuM6oSJcx54Wgx
 Wvh5rOOD2adAWbUPmG74rCTOStMzwZ
X-Google-Smtp-Source: AGHT+IF4p5XbCQk3FJC0EJmp3js78LUq1/V2TdVqNhXrMKYwDkdg4YRxVP+t0hMiXAq0xk+EYRHlg0P1QsMMDYmjNVs=
X-Received: by 2002:a05:6102:510b:b0:4ba:9a20:dd05 with SMTP id
 ada2fe7eead31-4bbf21e5e76mr2484187137.10.1739369869481; Wed, 12 Feb 2025
 06:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Wed, 12 Feb 2025 06:17:38 -0800
X-Gm-Features: AWEUYZmcsZ6sfMf4c1fdlvjM2nz5ygGVNhDxhNwJ60-ie_Pa9NhvYLrzqEgoL6Y
Message-ID: <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com>
Subject: Re: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 linux-erofs@lists.ozlabs.org
X-Mailman-Approved-At: Wed, 12 Feb 2025 20:08:29 +0100
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

This is good, but may I suggest using __builtin_add_overflow instead?

Jonathan

On Wed, Feb 12, 2025, 1:31=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.co=
m> wrote:

> See the original report [1], otherwise len + 1 will be overflowed.
>
> Note that EROFS archive can record arbitary symlink sizes in principle,
> so we don't assume a short number like 4096.
>
> [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/fs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
> index 7bd2e8fcfc..64a6c8cad8 100644
> --- a/fs/erofs/fs.c
> +++ b/fs/erofs/fs.c
> @@ -63,6 +63,9 @@ static int erofs_readlink(struct erofs_inode *vi)
>         char *target;
>         int err;
>
> +       if (len >=3D SIZE_MAX)
> +               return -EFSCORRUPTED;
> +
>         target =3D malloc(len + 1);
>         if (!target)
>                 return -ENOMEM;
> --
> 2.43.5
>
>
