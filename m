Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D867C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D791C80FBC;
	Tue, 25 Feb 2025 22:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmjJ+pr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79CF980FEC; Tue, 25 Feb 2025 22:27:20 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C390801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abb79af88afso49268366b.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740518837; x=1741123637; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gYzkhbvYpDY9aR6ykOKg/NPpAZirsvQriW83Fuvueyo=;
 b=ZmjJ+pr+iZPiM/mRqukwvEEBKVMzV8pLU47u3oVIxJ8RqEq1AxUIhNpfY7b0GWeKoj
 sVOl9KOeicYJMi6CnF8OHllSr+qEu+mmA1UXQHqObM6oHWCtWchfAvAun+dMbBo1wU+p
 9LxVwma9Su5CUyh8hK04lptaiZAYSeEVu9nOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740518837; x=1741123637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYzkhbvYpDY9aR6ykOKg/NPpAZirsvQriW83Fuvueyo=;
 b=Ifm7/d3gQjjBtq1fUnbkcJtZa3+7s7rJYLzENjgFZXRWIkaQYORr1eNr0R3arxbEQw
 Nn4aA6rLmuXWpj+AKgPrg1jOETfxWYocsAPjoyL0EvT8/6TGnqbJX380Dwp/jMkGzoG3
 H0tzCB3sWUa+2geVRUiKil1ryvcl/FQOWGFB/ATC02VM1I1G1XBxiyqYYsIcN5zmzHA/
 lhDkvu1+3ZeWHhi3vGGg8JOPxGdeoW0yZSc4WCqZ0XRNg+Zdf76r+QbqHSU6c6yDRKy1
 ssFg8cFTGCLwm7ZFNmdHjMoqjUagXw1oLzMiqSNY8GY2qHy9+Yl55dVZF8JwbU9kF4fe
 /1YA==
X-Gm-Message-State: AOJu0Yzc5PUb6/uT9cI8rQEa7ThpWfrbgVfkjDF0xbh7MtQmAn23LGTm
 0tkVyW6Uof7aT15dijzKZcth6KQTBf5tmDwuVTvb/sB8h5uwRKdyHYBrUpOKr4YtVx1iYH7rmLb
 Zznb4/2IKfb4rTd5WSJP4ZUnrzL1fPImC93Uq
X-Gm-Gg: ASbGncvctQum7lRrX6+vFfmIUPp7EXrTjJh5dD/cYbnvcGU5grmNZ2xBd5z87D10Ick
 6GP+3tmXP+GFZHsQfnEd65a6ji8L2XmufO5J2zwXVZtGSKj+D6TISausZdy7Cd/I6GDWxtdxq8O
 2qcU82aUna
X-Google-Smtp-Source: AGHT+IHGJtgwEgq43LHddz5r7h7qt89jSRuyk11FRDIAChDhadBShaVeg+aJt7f3rCHd+WKpJkrqYW4pwbJDT5NSlyY=
X-Received: by 2002:a17:907:7715:b0:ab7:c4db:a044 with SMTP id
 a640c23a62f3a-abc099b7f4dmr1771490966b.8.1740518837417; Tue, 25 Feb 2025
 13:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20250225121143.14862-1-l.anderweit@phytec.de>
 <20250225121143.14862-2-l.anderweit@phytec.de>
In-Reply-To: <20250225121143.14862-2-l.anderweit@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 14:27:05 -0700
X-Gm-Features: AQ5f1JrWWkNDaWXe3Of9pHZjYpdaUtJxllNJCxAzo7DVz_St6SQbOYJOoDsKZPw
Message-ID: <CAFLszTiK=Y_rhLBD0XUwWSD-PUnFKsZ27qQGwt=3r+EbQKAKzA@mail.gmail.com>
Subject: Re: [PATCH 2/3] binman: build_from_git: Add optional make path inside
 git repo
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, upstream@lists.phytec.de
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

Hi Leonard,

On Tue, 25 Feb 2025 at 05:11, Leonard Anderweit <l.anderweit@phytec.de> wrote:
>
> Add optional argument make_path to build_from git. The new argument
> allows specifying the path to a Makefile in case it is not in the root
> of the git repo.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
>  tools/binman/bintool.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> index 7280ee4f8cd9..81872db377f9 100644
> --- a/tools/binman/bintool.py
> +++ b/tools/binman/bintool.py
> @@ -329,7 +329,7 @@ class Bintool:
>
>      @classmethod
>      def build_from_git(cls, git_repo, make_targets, bintool_path,
> -            flags=None, git_branch=None):
> +            flags=None, git_branch=None, make_path=None):
>          """Build a bintool from a git repo
>
>          This clones the repo in a temporary directory, builds it with 'make',
> @@ -343,6 +343,8 @@ class Bintool:
>                  build is complete
>              flags (list of str): Flags or variables to pass to make, or None
>              git_branch (str): Branch of git repo, or None to use the default
> +            make_path (str): Relative path inside git repo containing the
> +                Makefile, or None
>
>          Returns:
>              tuple:
> @@ -359,7 +361,10 @@ class Bintool:
>              tools.run('git', 'clone', '--depth', '1', git_repo, tmpdir)
>          for target in make_targets:
>              print(f"- build target '{target}'")
> -            cmd = ['make', '-C', tmpdir, '-j', f'{multiprocessing.cpu_count()}',
> +            makedir = tmpdir
> +            if make_path:
> +                makedir = os.path.join(tmpdir, make_path)
> +            cmd = ['make', '-C', makedir, '-j', f'{multiprocessing.cpu_count()}',
>                     target]
>              if flags:
>                  cmd += flags
> --
> 2.34.1
>

This is fine, but you need to update the fake_run() function in
test_all_bintools() so that the tests will pass:

            if cmd[0] == 'make':
                ...
                os.makedirs(os.path.dirname(tmpdir), exist_ok=True)

Regards,
Simon
