Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3489BC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D5C87E47;
	Wed, 20 Mar 2024 14:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G34FEymN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B198800B; Wed, 20 Mar 2024 14:40:35 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A8987CFC
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d46c44dcc0so81836201fa.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710942033; x=1711546833; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fQ0hQmkocsiIGuVnZ8YQ4+l8XDq5iF6l270GD+g20gI=;
 b=G34FEymNe04HJ1TrwTJ4oa+nkBu0zJgXDp/fvY+OQjd8ppKiIsA8Bn+9126BGncnZs
 +floCGXLhnVGSNtBp/j+lUAaU67yaCfk/i80dEj2xVkZgCbTC0wbvh9M5U+4gwGpKazP
 i73S9gcfhX5KbBg+6oX+So7XtLHUFdpOsl48Yi1yLQ3HhT21ELpBveTPtXhtp8DbMYZo
 pOBOYRS5VgVI5JFT7TyX5T/kxSK7/xOYU329r6hfMfwn3db/mnup6qgvLPM5GL8gt8wk
 dmrPUcXEBPGVuIO1f5l4krkVCZHU8yttZLmOI/iUorJgbzW8D+34gYMT90Tb27qSZoD4
 IjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710942033; x=1711546833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQ0hQmkocsiIGuVnZ8YQ4+l8XDq5iF6l270GD+g20gI=;
 b=HLYGP5uTTD3RKa+X0aKfebhFUXgJHuPPCYaerDovDFH31b5GnaZcwqlfKTcbwDGabh
 Cxr61JdUY+bwWzPIshbBOdBJaKb7lhbJiXAvxiKZF/kjG54YxkQgw7IHVdz9PIpoZSv+
 YZizQ/WoDag6yfuP/6IWXzKCV/41ydAFcrkmU97vu3+m1FKW4bpTn2UQ6ozImZwcu5xr
 TcE2evmOg8nJCXgFQ8Lb1U2yXdGeYILY5Ew6SNCfnQvf8/T/g4owETDiN37ML+so66WU
 GNC1pnRMU9xewKYP1CktDOxgarDUZeaAlIFPm4QUMXY0VTQMoEd8Inif2MXd7TP7FK2l
 o3nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm8hvaNGeb+iR9ox9Z8lWLTC0LKpe3hIhxHJbPaBPRH44S4PFjat6Wdl3V0K2Um3vvLIVujlSpnIoOkz3JoblRY0JVZw==
X-Gm-Message-State: AOJu0YzoLiG+iUNWulHTpttIpubTFJDSSRUkjc4xwW1C9uZ3aivlSHo0
 3RQOHy9xH4ThQP7ucV5+8st6wXxhNNYXAE3xJYeHYd1pulNXZTnQvQQqRyMVMbcJKnyYH/njlwR
 1CHSUl3IcaUgZ279Rniqf8Q8Qp+ycivz3XuknpQ==
X-Google-Smtp-Source: AGHT+IFlZtOvCz7pGcLmOYZqQrATWUv2TalQNhXXCdAJVgrkVSL+QRiwXy8hpOLoceUXwVfmLT68CvTNTl1Sk2SRuPE=
X-Received: by 2002:a2e:9641:0:b0:2d4:a6aa:39b3 with SMTP id
 z1-20020a2e9641000000b002d4a6aa39b3mr3755592ljh.31.1710942032662; Wed, 20 Mar
 2024 06:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240320132525.46259-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240320132525.46259-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Mar 2024 15:39:56 +0200
Message-ID: <CAC_iWjJgQ_ACY5S8B+KF5YjObQA4+BOt-JdcQqshZ1S_yS-HOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: ext4: all file paths are absolute
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <seanga2@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, 20 Mar 2024 at 15:25, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> U-Boot only knows absolute file paths. It is inconsistent to require that
> saving to an ext4 file system should use a leading '/' wile reading does
> not. Remove the superfluous check.
>
> Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4_common.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index ea9b92298ba..9eac6beef3b 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -765,11 +765,6 @@ int ext4fs_get_parent_inode_num(const char *dirname, char *dname, int flags)
>         struct ext2_inode *first_inode = NULL;
>         struct ext2_inode temp_inode;
>
> -       if (*dirname != '/') {
> -               printf("Please supply Absolute path\n");
> -               return -1;
> -       }
> -
>         /* TODO: input validation make equivalent to linux */
>         depth_dirname = zalloc(strlen(dirname) + 1);
>         if (!depth_dirname)
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
