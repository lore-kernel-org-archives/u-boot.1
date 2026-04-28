Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDECFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1DC184150;
	Tue, 28 Apr 2026 16:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h06WVX7+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 368B7843B6; Tue, 28 Apr 2026 16:10:18 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B70883FB5
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so1064129666b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385415; cv=none;
 d=google.com; s=arc-20240605;
 b=ikkXsxFWSA5+Z1MKpDKzFlz5UkAlcCVbfasmtBj+tqAU7LKXMZbLgygr0L/pABFnkd
 jPX9+H4OkWWceqdC43+w8vC9TIyxXI3yhDLUcMIc/tIpbwt2dlinepVXtZp9TtLHpbEy
 MsWLk63Uvqr46arXqFHciJr9EWKHUVnsojg3w6dSsrCJMMhHJSfLZzo9hS2ltq6u7as9
 aCCoEzQc7UdoXqJQhXCckPhVDWKoYU0W6fhZR1ESMuRbGePZAYok8p78RDqS00ew1zmM
 FGY+jMEhYYnNxIl+d+dvUaSaq+Ft/I4C98cAQO+iwqUPs8rhb+mEfwO/wlVWv8WsSJCN
 jGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6YMu3axVWkIX7+rV9F14G3P8TtHtqZcRDj0U6GbjgUA=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=UbdPE52/Qxg5KC+Nbg3JQV/Hn/eO2mV5x1mw1JQ+F5sJGYlgrFud0Fde3DCtCFfbjV
 9B7KQnkjpja2bBeI1RPvexYhpR5dUHx+BDGq6s2dIUpKFywVT/UL66CaLBGWeS9lGx/9
 LpdNNBv4kz/PBd9M6451kWEerwcQJviH1JFGNcOkjxGTl/6wD9Ozas6lHbOWBqq+n2qH
 o4BPc0o0q+SHYVayuUINBJwiXa8b794IlWDHUe1w709qHADQEDs4dJZU7I6/9Xx7s6Sa
 9Gmu8BhSsjVgMooL8Jdo0IbvD3rq0gA5oeGPMq0OjOxBRmFd/bd2JyiGDJYxbSgQ5iab
 awhQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777385415; x=1777990215; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6YMu3axVWkIX7+rV9F14G3P8TtHtqZcRDj0U6GbjgUA=;
 b=h06WVX7+V/JfwQY3K5Nngn5t0amddjMLgWlyR8ogE3EGJaO6TnOCpOhHV/m7FNn5yv
 j9nrM+A5SfGjWjzU5xKIQ3luJxN+9GeUjkcBFDKjKclcgtxKHs04NXyfqjfUkPXECiya
 PTsZYVXoKIlxb/OQ1m02dj9qKqU/dfPZEHEgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385415; x=1777990215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YMu3axVWkIX7+rV9F14G3P8TtHtqZcRDj0U6GbjgUA=;
 b=iGQk90rL9vu8fFM7HxmfEmhoSjl/QyGAJDxBQfbVFZhGrenOJmSz733Asb8me58Ke8
 fcfPG0BsTLJM1MHYU89K0c61HfylDNJJSX212SP7JmkfGGTZO5G+yoT+budNzS9fe1L7
 POSjgK2/h7xye1QYVOki7daekE3/e4JDzu41Rl4+2kOIYvxb9gFq6zMPJxmb21wQVl9t
 XBdujpOyjRUuCW9AN1af4bk25k6zIToAL5ZqKdy3sb0jz3yxDhjeLoypLkvm9o3l48a7
 qWsyTrE2yhd9Fmi1OgPh+M3TvGApwdK3v08F3Dy3m5zadrBazorwXeLbKTQNLjAztcjc
 3dtw==
X-Gm-Message-State: AOJu0YzQLrXqnxxgDfHraX7R2B2WZtS3oTYV1F8Ew2dxSFTdqQlytFdy
 4ZHGrY8PAa/iWv2PRyKB46RzxbB+a1h+oCGSwjNzcNLQSvuajdT8ON+W7WHOCcMeEr/5HGsN9Oe
 cTrNh+4OZb6USe72ObkCQbsywGRQoNTkcS4MBTj4g5zJedLKak3Y=
X-Gm-Gg: AeBDies0HXDr1hcPwJOwpYqdmPIhu5eqhLg/FnNBoCfhJZu5Kw8PajXQJ3NfINhsAMa
 VqnHz+k5HVsTBIOWoxMznZqZhv/zk7EgwSAwUeUS60f7K1y4peOSd/1p7twaEBL1GbIfr4Ft7Ws
 PmqKETGnqculamj6KjLO/SUrIO11u0Jhs13AzvLT2ZbSVkbvrn5mVO1vkT7lEfTt/aGTAv/pCQn
 F2iW3IV6G2MM+Dj1w5ekr4rcmQDQ23xZei8J7r7LGLxHrpeVp4RcnyYWBQHWNx94bIHXKpwSjQG
 HTqu3YMkuPusA4H5
X-Received: by 2002:a17:907:e112:b0:ba9:1431:8b7f with SMTP id
 a640c23a62f3a-bb8029bf618mr144487266b.18.1777385414630; Tue, 28 Apr 2026
 07:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <e9ca310e07d0e591339e0dbf3c1b893a1c43a03b.1777272283.git.weijie.gao@mediatek.com>
In-Reply-To: <e9ca310e07d0e591339e0dbf3c1b893a1c43a03b.1777272283.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:10:01 -0600
X-Gm-Features: AVHnY4KRI1oC_orG9qhBHXkV6XFdmEmphZBj2qkTC3yLHxy7YQikkcC9-ESMDB8
Message-ID: <CAFLszTjjde593ZKoZcSTTkKndC2XBKXCFLJzcYTafdD+1tZT-g@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] cmd: ubi: reorganize command messages
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: reorganize command messages
>
> This patch moves normal subcommand messages into the main command function.
> This will allow current and potential api functions being called with clean
> output.
>
> A new function ubi_require_volume() is added for finding and printing error
> message if volume not found. The original ubi_find_volume() will be silent
> for being an api function.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 109 +++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 79 insertions(+), 30 deletions(-)

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>       if (strncmp(argv[1], 'remove', 6) == 0) {
>               /* E.g., remove volume */
> -             if (argc == 3)
> -                     return ubi_remove_vol(argv[2]);
> +             if (argc == 3) {
> +                     int vol_id;
> +
> +                     vol = ubi_find_volume(argv[2]);
> +                     if (!vol)
> +                             return 0;
> +
> +                     vol_id = vol->vol_id;
> +
> +                     ret = ubi_remove_vol(argv[2]);

This seems wrong - previously 'ubi remove nonexistent' printed an
error via ubi_find_volume() and returned ENODEV; now it silently
returns 0. I think you should use ubi_require_volume() here.

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>               if (argc == 3) {
> +                     if (!size) {
> +                             vol = ubi_require_volume(argv[3]);
> +                             if (!vol)
> +                                     return 1;
> +
> +                             printf("No size specified -> Using max size (%lld)\n",
> +                                    vol->used_bytes);
> +                             size = vol->used_bytes;
> +                     }
> +
> +                     ret = ubi_volume_read(argv[3], (void *)addr, 0, size);

When size is 0 the volume is now looked up twice,. i.e. here and again
inside ubi_volume_read() - can you drop the fallback in
ubi_volume_read() or move the 'No size specified' print back there
guarded by a verbose flag.

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> -     if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1], 'rename', 6))
> -             return ubi_rename_vol(argv[2], argv[3]);
> +     if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1], 'rename', 6)) {
> +             ret = ubi_rename_vol(argv[2], argv[3]);
> +             if (!ret) {
> +                     printf("UBI volume %s renamed to %s\n", argv[2],
> +                            argv[3]);
> +             }
> +
> +             return ret;
> +     }

While you are here, please add an 'argc == 4' check to fix a
pre-existing bug - i.e. argv[2]/argv[3] are dereferenced
unconditionally.

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +                     else if (ret == -EEXIST)
> +                             printf("Volume %s already exists!\n", argv[2]);
> +
> +                     return ret;

Just to check: ubi_create_volume() returns -EEXIST, but
verify_mkvol_req() returns positive errnos, so name-too-long or
bad-alignment failures get no friendly message here. What do you think
about handling the verify_mkvol_req() errors here too, or making that
helper silent like ubi_find_volume()?

Regards,
Simon
