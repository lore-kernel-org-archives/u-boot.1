Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5314ED5AE79
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FD088F4A;
	Thu,  7 Nov 2024 10:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qmI3SMOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72E38920C; Thu,  7 Nov 2024 10:27:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80C188B64
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730971656; x=1731576456; i=xypron.glpk@gmx.de;
 bh=KIDzi1PfFkJYwfm2xuhbOcLqykKmlMZdLYjdmlAj878=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qmI3SMODoZvsw1oSrH9QhaG6PwRIjlz/QhIm2/GNNjxvWkHbLn/i4pQyMqDHC5UL
 hbGGT3atbImspvYH6ULfMc0YwPv/EWdye6KEXd5plLF5f+v2ZZb7GomgBJt0KBNi5
 c5dJd4s4ducMmDLWUnDANfmOYLIPmkg1Je47eiVcjmDoq9R9NSiqDW5BiN1aigb5I
 C2iPNnFQRsta/ilpN//QMvZps82J+eCoihTjB/GK+gZJN9AaSy9ykilPxw2UyAT0P
 4i+B2hfrbIyavK4wEUKl9jccJEetJuWlyc2hW6kcvJrNSxF4g514EOk4BfeJ2AuKS
 fPv1r13OMn5odqkjOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1ti2ZM0rVg-00qR2N; Thu, 07
 Nov 2024 10:27:36 +0100
Message-ID: <e79be8c7-2461-425f-8f7b-e24ad3884d65@gmx.de>
Date: Thu, 7 Nov 2024 10:27:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
 <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uobN/ArCwE+3ncMUhlZkMUuLIQX1aF6XK+Y58mmzmMmUF3xs5W2
 ZVuMt+GAZJLzvp0+VeNcXxc8ovwyoRaPm79jwFSFkq6570rJVBuO8waUULgTnf/btxF6yEU
 fdnOnrWonqXxSxexTrwWVFuVljhB+F2Kjh1pOJWFTKKfKY9Euv3aDbYwGgWerJ/bUlOQNZv
 3Ew4AJvGroISZ6MXsS9Yg==
UI-OutboundReport: notjunk:1;M01:P0:84vb4ayCqA0=;BkKyRR/XshO7k0qNjDSvpW67fAs
 6giLWP61Adg/S3/Re7Fjkq+hDzPnDh6AqZmsXc69/6KJZG9Ix/9/JO1J9ma+I+iuf1kQYxy5l
 7PgBOGg85i92wZlPoVwbz2xoZqL0UzXf2kCx8sA2sIBY3vKMDqKTefkWXAIeATBrIu+ehvX9S
 WDhu9zFlQWLFEa4kC6upoth9rDuU+NYEBuGnzO+ov/EFMCHlcJ/y/k28FogP4drXo21bcxyR7
 sa9N4y0FfkR4HE23HfgMotBxJO6g2lp8HSVsIXdAZQ5jteTHAIFDVbFLZoc1CKLLS7PxJcSd6
 6C5g4mE0C4ssmMoZ0SukO7sScvADllBUC5bD8KtLVUOrNXz5db8oxTXb2XyZUzTYtkMej8W1K
 zgKKu1vtnur8Sd2G4ZIEOPeEHv4VdIjuRWNrcrRG3MwW1x7mugpyeajekAXnq8MYwOjIwkIRd
 hdXjvnuNuNWCOQshv+tgLwUPPp6j57cWVXAC7bhoUYfTy79SpRjtlrV9XYJycfHMl5zBS1gON
 cVIfw5nOz7MsMo2Bp62MNOkMaRTYE9+UkEFnNkKady9R/p8jPV4LNNexOni0Xbw7Qku7OqfQ9
 FFyKDUrLZjkEDZ6+9Jc/ZUg7/QWAkfWcqTa/UC/oethyC7VEvlbiYB+To+Uf4lXfxYvcGawtQ
 9T+BckZ8BwLUnBoi/+mukIU1cP9NJtjnYEsffnjc6u1uf7b8KKc1/+wxGy06+yBPh9RKrfmAJ
 Z8o3+6kBAvcSYNK97HOvsUsNGdbwSmzuoOTZz8gCuXr3KAsRmH8Ci685fqK14PhSXx83BR+qA
 qhJDX3c7nVpzDNzaHu3PiadX0PhHoQIIN7KgQQiOigAcpKuIcSHb1/pQDmyuPkC3p8A9nf49A
 XuGk8MGAWiyE10AC6z7lmizE5Rvr//mQGA00w77qtKOjg87c7zagEuQ+p
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

On 11/3/24 00:36, Michael Nazzareno Trimarchi wrote:
> Hi Tom
>
> On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>>
>> On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
>>
>>> With this series opendir, readdir, closedir are implemented for ext4.
>>> These functions are needed for the UEFI sub-system to interact with
>>> the ext4 file system.
>>>
>>> To reduce code growth the functions are reused to implement the ls
>>> command for ext4.
>>>
>>> [...]
>>
>> Applied to local tree/v2-tidy-test-dir, thanks!
>>
> Am I sleeping?
>
> int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp) {
>      struct ext4_dir_stream *dirs =3D NULL;

Thank you for your review.

We should not set a value that we do not use.

>      struct ext2fs_node *dir =3D NULL;
>      int ret;
>
>      *dirsp =3D NULL;
>
>      dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
>      if (!dirs)
>          return -ENOMEM;
>
>      dirs->dirname =3D strdup(dirname);
>      if (!dirs->dirname) {

Yes this line in my code is incorrect.

>          free(dirs);
>          return -ENOMEM;
>      }
>
>      ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
> FILETYPE_DIRECTORY);
>
>      if (ret =3D=3D 1) {
>          ret =3D 0;
>          *dirsp =3D (struct fs_dir_stream *)dirs;
>      } else {
>          ret =3D -ENOENT;
>          free(dirs->dirname);
>          free(dirs);

Yes, we should avoid a memory leak here.

I will send a patch.

Best regards

Heinrich

>      }
>
>      if (dir)
>          ext4fs_free_node(dir, &ext4fs_root->diropen);
>
>      return ret;
> }
>
> Should not be like this?
>
>> --
>> Tom
>>
>>
>
>

