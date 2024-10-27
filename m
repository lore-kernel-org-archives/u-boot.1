Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA8ED13577
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B41FE8839A;
	Sun, 27 Oct 2024 18:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AE4sV1kg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6178841E; Sun, 27 Oct 2024 18:41:18 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4BA881FD
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7203c431f93so2824078b3a.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730050873; x=1730655673; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3TEJLOe5rVCdMmgQW9eX+yxV8MLwXieUzWwx3xYIT9g=;
 b=AE4sV1kg6MnFs1SDFwy6+IoA9FVL6SFCAt7BKTMfbWP6TCroaNMxQReO1+mJ62rNKk
 nsuSQr/h2/7GQUnuUUOPls3VIXEIEqnOgcqid46hf03DNW5xiZoCw2UPmyNvI9U7p0Pm
 kgz7l7RfqzJZgv9+bCJ1oG9DFS3fQ+IYpTyqTEDxfc1QU5FkUhNgUeR+K7GHMmpfEBio
 PQk4H6ua2tQCGncEYdQoY96QKaPYJTJPVMuBpuLQb1XMVdNnk4o0rExTQyzUCGoT4FF3
 Pg1ZgT7m6RoEncYOVHlHzJ/osqwaw8kGQwXFHt2UNj8boprEPr7/r/uVzsMi5xAOHFtz
 XiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730050873; x=1730655673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TEJLOe5rVCdMmgQW9eX+yxV8MLwXieUzWwx3xYIT9g=;
 b=TjKiiIr09uYHmkpyIyGpU8STXuAwNrwnSmWc15rr+Lxeli1R3PlSzKAeJNMEUJ7dV4
 KdvpjfDQ8Lo3v3FlqCjK30b+pw21b38yKl0PJ/rajK4kZumq0XmYRJoAtdHft0tC/e9Y
 txuCmYaz4tcXC9yEgjYsvzZrGUB5NT3YEeoJZtI8kNsepk5esei0/9hOx/zJCJdSTBV6
 NfBE9AGbOyk9c/2b6dQQpq50NL3h1vaA4LY65aZyi/mLkbVgkk5xnh2TyEjbVEsMe8si
 TFCC/v7Ee/PdpsIHXGVbvyDn7az8xh8wt6DF32H/HBVXKOy6Jrefo3tJ4mvivxt1raC7
 QNxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmqJwtst9dSwgaLBGmItQ7q6g8uZ27JcSfvPEguwHKol845xya1qdSEFjoRh1ogf67ND2uvW8=@lists.denx.de
X-Gm-Message-State: AOJu0YyZyHirKZqo8r1qKti+kqxbUZhB2NkO/lrauGQMeNJR4TZEx0zL
 Rd5p7SvFvOxwlr1G91TsShd7Gkhp69JFgKzOTrn3culbXWgaiOCPY19MoQIqLuhYqITl3BSTx1+
 RU+c0PHoNRI56cCPyL+es6f5IaK9mieL9lGirhg==
X-Google-Smtp-Source: AGHT+IF+duSLEgq4htR8oUWLsc3Xia+mvyigN44g8XfPrBTWkHxPxDZgiXtcCR+RZMTnuqrMAgD18NkxP4/ium2Dd0I=
X-Received: by 2002:a05:6a00:3be4:b0:720:6c6c:52a9 with SMTP id
 d2e1a72fcca58-7206c6c52c9mr5007692b3a.18.1730050872951; Sun, 27 Oct 2024
 10:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 27 Oct 2024 19:40:37 +0200
Message-ID: <CAC_iWjJZNxJ=5b_cSbUMMu6WV6BUNJFOqj26EZ_0AEJMV4YJ+Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] fs: ext4: simplify ext4fs_iterate_dir()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Sat, 26 Oct 2024 at 09:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Remove copying a pointer with a cast to the very same type.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4_common.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index 76f7102456e..c1e38978bb9 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -2046,24 +2046,23 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
>         unsigned int fpos = 0;
>         int status;
>         loff_t actread;
> -       struct ext2fs_node *diro = (struct ext2fs_node *) dir;
>
>  #ifdef DEBUG
>         if (name != NULL)
>                 printf("Iterate dir %s\n", name);
>  #endif /* of DEBUG */
> -       if (!diro->inode_read) {
> -               status = ext4fs_read_inode(diro->data, diro->ino, &diro->inode);
> +       if (!dir->inode_read) {
> +               status = ext4fs_read_inode(dir->data, dir->ino, &dir->inode);
>                 if (status == 0)
>                         return 0;
>         }
>         /* Search the file.  */
> -       while (fpos < le32_to_cpu(diro->inode.size)) {
> +       while (fpos < le32_to_cpu(dir->inode.size)) {
>                 struct ext2_dirent dirent;
>
> -               status = ext4fs_read_file(diro, fpos,
> -                                          sizeof(struct ext2_dirent),
> -                                          (char *)&dirent, &actread);
> +               status = ext4fs_read_file(dir, fpos,
> +                                         sizeof(struct ext2_dirent),
> +                                         (char *)&dirent, &actread);
>                 if (status < 0)
>                         return 0;
>
> @@ -2077,7 +2076,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
>                         struct ext2fs_node *fdiro;
>                         int type = FILETYPE_UNKNOWN;
>
> -                       status = ext4fs_read_file(diro,
> +                       status = ext4fs_read_file(dir,
>                                                   fpos +
>                                                   sizeof(struct ext2_dirent),
>                                                   dirent.namelen, filename,
> @@ -2089,7 +2088,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
>                         if (!fdiro)
>                                 return 0;
>
> -                       fdiro->data = diro->data;
> +                       fdiro->data = dir->data;
>                         fdiro->ino = le32_to_cpu(dirent.inode);
>
>                         filename[dirent.namelen] = '\0';
> @@ -2104,7 +2103,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
>                                 else if (dirent.filetype == FILETYPE_REG)
>                                         type = FILETYPE_REG;
>                         } else {
> -                               status = ext4fs_read_inode(diro->data,
> +                               status = ext4fs_read_inode(dir->data,
>                                                            le32_to_cpu
>                                                            (dirent.inode),
>                                                            &fdiro->inode);
> @@ -2140,10 +2139,10 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
>                                 }
>                         } else {
>                                 if (fdiro->inode_read == 0) {
> -                                       status = ext4fs_read_inode(diro->data,
> -                                                                le32_to_cpu(
> -                                                                dirent.inode),
> -                                                                &fdiro->inode);
> +                                       status = ext4fs_read_inode(dir->data,
> +                                                                  le32_to_cpu(
> +                                                                  dirent.inode),
> +                                                                  &fdiro->inode);
>                                         if (status == 0) {
>                                                 free(fdiro);
>                                                 return 0;
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
