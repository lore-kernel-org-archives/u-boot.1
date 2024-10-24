Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E823CE8E93
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 16:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ADC388E63;
	Thu, 24 Oct 2024 18:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MzvdcneC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D13C88DA0; Thu, 24 Oct 2024 18:37:04 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EAC388F47
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 18:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso147412866b.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729787814; x=1730392614; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t6TIUzInM+WGxzp0qhyA/nltgSSe/VJh/dF6cDFNjvo=;
 b=MzvdcneCZGp8OIAPzQIsiDIZw0bohRvz4wCGLIvWLd1EBPCNMetuaUGXrVye9mBCgb
 PPbhS3frfaScO5e6s3TxnxQRWvVQAxwD0e/Wvph2ZWxkJV8CZz6LXn4aYlEvrfFC3ybB
 p8wRFdemV7mZXjERp40ZYQrDPcsqrP7RUpLj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729787814; x=1730392614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6TIUzInM+WGxzp0qhyA/nltgSSe/VJh/dF6cDFNjvo=;
 b=rOVoksEh8FXeLnS4pQKVR8ooW+l947A0HRJd1ebiDcNxnI2YQ6Qj1Q9klnsFvYAT38
 /lutAjx4xpyylOLuWgPX7GCgRMaD6wHkyIqfNrtiX6Cz+lpS1CyvF9ABG0MY8TYPFGMm
 zsosfwOk9pcSkEguzDD9oHtEQVha/tcMxMHjX2+8RIbzwxWN9b2yNVfGO+EOXzKkzwYR
 BENshYVDNlivyDKdaV/ot/XWNEBQeXmOb1bUBnLHWT3IIIZ8s0dQ6nh8+Hy79R8ScocN
 qygnSTORe/XtDS8LfvavZq/yMzn0lkUddFrszMymw8mfqDCICU7WA7tL2T+Xs7/ZqNtE
 y/hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDJXIUHlPTSbMKCU1GbA0AJYZPmKCK2yg8sCzW7etmjOSC/gvAF+4O+iYODoeAwLVftqUfe28=@lists.denx.de
X-Gm-Message-State: AOJu0YwYu5KEel1Tpv0uBCzfPHtdWdZQxDulmqwhiFW792eWwt5Fo+Ch
 U/7NiZDC40C9/LSVonJyc+u+J4AU/AjJ3HKofGynO9n1kPwSlC7cIPgCdqmWTjyF8tsH1+3wnss
 3ZBZIa4pW5dPQ6xrOocrkJueZgpjH+mGsvrJkk4oXg1ON7NJagl5J
X-Google-Smtp-Source: AGHT+IEHMNz6x8TPB4UVka+8oBcoF+g4fUrKAEbIwDIEmtfnQLZJEQd1NLgHMahRUHvEwnvyABvcBwQubIr+sHXK8Bo=
X-Received: by 2002:a17:907:2da1:b0:a9a:1796:30d0 with SMTP id
 a640c23a62f3a-a9ad285fc4emr241277366b.62.1729787814386; Thu, 24 Oct 2024
 09:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241024131627.77018-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241024131627.77018-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Oct 2024 18:36:42 +0200
Message-ID: <CAFLszTh7CCvLQbePJFB7u_QHnKrsCk5A8Mx05vXEUJwdmyJU-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: ext4: document struct ext2_inode
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michael Walle <michael@walle.cc>,
 u-boot@lists.denx.de
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

On Thu, 24 Oct 2024 at 15:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide Sphinx style documentation for struct ext2_inode.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/ext_common.h | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/include/ext_common.h b/include/ext_common.h
> index b09bbde116a..a85ac04f79a 100644
> --- a/include/ext_common.h
> +++ b/include/ext_common.h
> @@ -173,20 +173,35 @@ struct ext2_block_group {
>         __le32 bg_reserved;
>  };
>
> -/* The ext2 inode. */
> +/**
> + * struct ext2_inode - ext2 inode
> + */
>  struct ext2_inode {
> +       /** @mode: file mode */
>         __le16 mode;
> +       /** @uid: lower 16 bits of owner UID */
>         __le16 uid;
> +       /** @size: lower 32 bits of file size */
>         __le32 size;
> +       /** @atime: last access time */

Is this seconds since 1970?

>         __le32 atime;
> +       /** @ctime: last change time */
>         __le32 ctime;
> +       /** @mtime: last modification time */
>         __le32 mtime;
> +       /** @dtime: deletion time */
>         __le32 dtime;
> +       /** @gid: lower 16 bits of group ID */
>         __le16 gid;
> +       /** @nlinks: number of hard links */
>         __le16 nlinks;
> -       __le32 blockcnt;        /* Blocks of either 512 or block_size bytes */
> +       /** @blockcnt: lower 32 bit of block count */
> +       __le32 blockcnt;
> +       /** @flags: inode flags */
>         __le32 flags;

Where are the values for these flags?

> +       /** @osd1: operating system specific data */

hyphen before specific

>         __le32 osd1;
> +       /** @b: block map or extent tree */
>         union {
>                 struct datablocks {
>                         __le32 dir_blocks[INDIRECT_BLOCKS];
> @@ -197,10 +212,19 @@ struct ext2_inode {
>                 char symlink[60];
>                 char inline_data[60];
>         } b;
> +       /** @version: file version (for NFS) */
>         __le32 version;
> +       /** @acl: lower 32 bit of extended attribute block */
>         __le32 acl;

Can you link to where the attributes are defined, or add the enum name?

> -       __le32 size_high;       /* previously dir_acl, but never used */
> +       /** @size_high - dir_acl on ext2/3, upper 32 size bits on ext4
> +        *
> +        * In ext2/3 this field was named i_dir_acl, though it was usually set
> +        * to zero and never used.
> +        */
> +       __le32 size_high;
> +       /** @fragment_addr - (obsolete) fragment address */
>         __le32 fragment_addr;
> +       /** @osd2: operating system specific data */
>         __le32 osd2[3];
>  };
>
> --
> 2.45.2
>

Regards,
Simon
