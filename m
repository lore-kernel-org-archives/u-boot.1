Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27C9E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C6283DEB;
	Thu, 19 Feb 2026 14:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XobF1rwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0690083DF3; Thu, 19 Feb 2026 14:10:46 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D1383DCB
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c6e5998f90dso328479a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:10:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506642; cv=none;
 d=google.com; s=arc-20240605;
 b=XI1gviK3KdSqMdAouiq8S5Ywn64Zi9RoAz36MuwSGHMoYkhzIBlFbcx8pDTYrnZ7f2
 eE7i3Jj978WMUHZop64JmB7TvoRaGqCE598D1MVHTRfO4PQd9h63oRhVYiCTfOoIHsTr
 uzGfExpQ7ZAiZV30i5xQqS3CqkyR4hutByXhfgZTOXBF2yMUxEm4qRHisHg4vdoBln3h
 x3uFQQlba0Nmoq8s+ZF81Olz6HXLfayV88MtnmIr+2jTCcX5HJPxpYe0nc/OK40J4YDg
 +OB+BzqRDopfreHBFxQUsABi11JouI0F6DtUh8RBYtSacLZ5BKrkRbombXUw73YXIoUO
 g82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hhIVDdF/XSa8RoIPRO1UrrUV9664/EJ79FuInOtFuuQ=;
 fh=JsZ56WXa+JFR2ZUIvgbzq0j14tuEgHfobuEFj5EL03I=;
 b=FBjy3VqFAm6lF4OD56txQycemq71H/i0P2uXPCCaYaVq+85969BtLWDlv8bYqEr/3N
 E/Mm1f4QPq+flk95hDXWZWWhh1Rq2IZox/bd1yX3cbToSFTGdAxnKAsny/gkOPpG6oXr
 y8Z0enFQHfRAi7xvD8+sK5UkhyzrBPzTj0bnN78bRAXV9kaMv4+Lu6ndNhdL9eKmgBPI
 y5q4Puw4OOxCzQvm8Q9RCtmcaphW1pxVjBNUJk36HYyCmmjr9OrQMvF2ik8vclN5PvIw
 WjDbKQ4B4KbeOygSOdu569dnjWnRl9DMwuoCfgg5FLA7XtmBukPkASz4je7eaWsp8EsU
 8pkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506642; x=1772111442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hhIVDdF/XSa8RoIPRO1UrrUV9664/EJ79FuInOtFuuQ=;
 b=XobF1rwiAEgpV4F3s675cqbD0hQ1dA7RrnKtdeY571RAjxLW4uGBpciY48gqLyA837
 NCK7zijoi8AWwtnPOvELkwodqPMBLMpCSD/fvAkUk7/pCGdYoZOpvFLqpJg6cBF6lD8s
 OSQSqn7MdNLCSZmYcNXueyvL4iaBn3A5n+5GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506642; x=1772111442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhIVDdF/XSa8RoIPRO1UrrUV9664/EJ79FuInOtFuuQ=;
 b=HkQN1am7ZAkDLK8VIjCWg6alcmAhwoZ7GVNSYoo1dzKZyVOBpcmktA6d94FjFdxKKN
 R4vdEI9BbrUkrhyQT2qsCyWmI6UR0fnqAg6/kT0uMPp63F/dRFP0Pzo9cpa1DZ9NTrFX
 FvYv/RM3gqd9lUPHgmeKSeSmQgMCginUz3RvJCGbF1Iyc/WMYeuvP1IFfdRBBZJBaYcK
 sLJMuEpdQvf7KcByEgX8VTSvnpKrmmmikMJZKIogt0MVEsIlXj0A/jgNVgltmbnVnqGo
 oHXPMStD6OW8FyF2R2Omh/5qIZpyNBfemzzfWCgx6jmdwrR5267qSPLaWkULA10Hfp64
 QUYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9K7rxpF3Wm7ngDTZ36imzcjNkbhqSKuh9fRuJkZaLNOh/O6bG8KyAtY3bZWithkP2y1QSr9w=@lists.denx.de
X-Gm-Message-State: AOJu0Yzdep8IKZld0dSXVW7OQUrcJw1yJ2mVXTMTKsuU/m0YEjxLYVn5
 iMpCJngk9AghrCmGWCgZjsy5Uyp0gBVAnygETWZT9jEY0e9jpqpmmvHLRub3I3nOM9bbNJqOPZp
 S/h1zmhFTt3AT89YXgYFjukTBSjnNTnTOxaxDiDR0
X-Gm-Gg: AZuq6aIqB6SE/iakEorPb5zFBI/6TMe5Q1ODqOAQxrFUHIbO4HvhJCMdfSNo/skfp/F
 Q6QIVoSMuGLLCd8acTd4UtCG1YgGOck8dXnWF1Nl7FHkBw3KiyzjC+35u7yLHZnBh0y81AS73ky
 C7uUsJrtLjmGjBsKttwRIwIocjVNwvMkF/PB3ZKExuOPHWa+GMHvkUMyhh0l0EfHAdFdwXe5sdP
 eh01VOqSEDj7XAR+w2wDD4wElj+e5BzzgKU2kXkPcwt19CXXKcF+VdX2MlDet8Ez9t7Afpg5KL4
 +NtC3A==
X-Received: by 2002:a17:903:2a8f:b0:2aa:e285:f249 with SMTP id
 d9443c01a7336-2ad50e757a5mr48200595ad.1.1771506642179; Thu, 19 Feb 2026
 05:10:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <5511a9a0d434c3b69f1625f9f4bfd8e99151bc1a.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <5511a9a0d434c3b69f1625f9f4bfd8e99151bc1a.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:24 -0700
X-Gm-Features: AaiRm53V3o5jZo_yawAuFb1LRJZi7NFT4sDUjHctbaJ-K8Iy4266axr4k_oIkQo
Message-ID: <CAFLszTibAjG6GrgCgyAgYRfEeEPxE3znseyfpXj4PCH8tRCgMA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/20] cmd: ubi: export ubi_find_volume()
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Remove the static qualifier from ubi_find_volume() and add a
> declaration to include/ubi_uboot.h so that other translation units
> can look up a UBI volume by name.
>
> The function now refers to ubi_devices[0] directly instead of the
> file-local 'ubi' pointer, and takes a const char * for the volume
> name.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  cmd/ubi.c           | 10 +++++++---
>  include/ubi_uboot.h |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/cmd/ubi.c b/cmd/ubi.c
> index 93de6f3aea2..ca7d657aa07 100644
> --- a/cmd/ubi.c
> +++ b/cmd/ubi.c
> @@ -247,13 +247,17 @@ static int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
>         return ubi_create_volume(ubi, &req);
>  }
>
> -static struct ubi_volume *ubi_find_volume(char *volume)
> +struct ubi_volume *ubi_find_volume(const char *volume)
>  {
> +       struct ubi_device *dev = ubi_devices[0];
>         struct ubi_volume *vol;
>         int i;
>
> -       for (i = 0; i < ubi->vtbl_slots; i++) {
> -               vol = ubi->volumes[i];
> +       if (!dev)
> +               return NULL;
> +
> +       for (i = 0; i < dev->vtbl_slots; i++) {
> +               vol = dev->volumes[i];
>                 if (vol && !strcmp(vol->name, volume))
>                         return vol;
>         }
> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> index ea0db69c72a..92892704d0a 100644
> --- a/include/ubi_uboot.h
> +++ b/include/ubi_uboot.h
> @@ -50,6 +50,7 @@ extern void ubi_exit(void);
>  extern int ubi_part(char *part_name, const char *vid_header_offset);
>  extern int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
>  extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
> +struct ubi_volume *ubi_find_volume(const char *volume);

Needs a full comment.

>
>  extern struct ubi_device *ubi_devices[];
>  int cmd_ubifs_mount(char *vol_name);
> --
> 2.53.0

Regards,
Simon
