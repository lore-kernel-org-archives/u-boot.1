Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12D7FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E9E84662;
	Mon,  4 May 2026 14:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SFZDs0gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 675C184669; Mon,  4 May 2026 14:27:01 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D9F8394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso745123166b.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897619; cv=none;
 d=google.com; s=arc-20240605;
 b=fwHXLG0SlDA013XUuANRdTBK+sBhIbJ+mQrZ5Izs/oo2h3rzoiscKQUf8QeJYBD+mJ
 6OJT3in+7rMbtDoL2ZVIUBCfsi+MxiWlYKL29jhgpDkm+Kw0SWc+MuxkRjKsmNd7kUj4
 vEGQ9xYAo7TfyvG1NNEvZL3EKFgjdJKkBU0zcTEK/0+FkgSYeoWaN7S2JYVsj9Oah0ni
 t8vt40f6HrFdnqAGVUbp5jMoyLrUDM/M57usE0UKxfMyXYGkNLjeL7EkzEe/bgQHDZBZ
 cfLmGJewoLAVH+hQznTuxfT3pkYjPSGM0MJc3GmDae3/TL3cbReyOEe4GNtsMcrwGLbW
 ODvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3vqkStBE8/awwN/k/d86ctSQHAtRk8BVoN2fTljJWZo=;
 fh=B8UYjC/8Mz2zaBAJph0E5GCykBXonOlQg1FxrypigeM=;
 b=VYGtiREPgGaefxx0YVokDAoHoNtCHqDXO+c856hCNWMtvIZwgL78YcRxXwluY1tgDt
 dj/VRXDScYexQ8NdaY+qKdFreHtXJe7JY/UbcwKNH12/YbWBz0o3JX2cOzFVoK5Z9JP6
 2F8TjN9W6R/ikY1asG1tJr3KazhQUm56fkTvfr8DOVc17NdErOWb5jWcn69SmJvw/bBK
 HqoLOtUJQXH365D9B4NMeOp/R3RkDaYrrjbOc4lhZJthIaKe8hQRfuU9C7UNM9ugiHnM
 iouabtQu9jRWbcN1nKrAkYtNyOl1HRt6dIRqJ3Y/CwSKsHGmv6FVZPouBLClvCBYPi03
 llKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897619; x=1778502419; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vqkStBE8/awwN/k/d86ctSQHAtRk8BVoN2fTljJWZo=;
 b=SFZDs0gwRZ+DM+uySG90507evcB1utDdrJ3Sr16brwjeua3Knsy+W0Sb7okaoMsuKd
 LNXshsNsrzWewvTW+4L2EbnxxjxE/tiTDBlwcpfeUhghXTt+NJEWghc8ZbxovMjEIQA5
 h3XhHK7tM8kWM2cQcrqel66U6quBwCCv+8d+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897619; x=1778502419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vqkStBE8/awwN/k/d86ctSQHAtRk8BVoN2fTljJWZo=;
 b=Mrw86hZbUODk81eC9uN/PKeAK7Es7Bg+rqiZb17f/LFRQsrPGepyUS98QyPlyJ/NzA
 I4zGAeW6lpz8WlA4ViXMA7VJy9s2gQmLWoI3815rOOIaERIX1WqQ/ykmaKlboTY96VIN
 q9bODzkD2zrrFBm8ADuRrRvG8dMxQcnjH7o9Vrl5HnGdpxj6/kIBU6p7EPFJrYF+t3gz
 9bw/nKHhW32Yqt0jsrPP5N1UCqS56LBYVZNlkaGdMXOPQiRXxIVSNHwpWcMzocDDeDYg
 FR5dNWFEpbxvGvO/EoX4H/O3o8i9l1Bgzb4xAVsX8Y458PcLWFvjMeHm7GSqLJm6JcNO
 vkUw==
X-Gm-Message-State: AOJu0Yx26Ydmtrk+NpkevK7D1KjM0+UnRdq1Hn04KgcF2SVCBJh0jqSv
 NydhiDAoVt+5fQUb4rruvA6a/du/yqOzVacNeadr1X+rXHLcQMp6ZbW9TumRu8f4PpOmysL0tm+
 FXG9XWUs86YUwu0aQ//XfvsvsqPYCfKE802oKtQ4aP/p7G9ejh4s=
X-Gm-Gg: AeBDieuut68YDd+PGrMCin73af67GOTpLQGqDUPCzBYYHenxqTY14RiInPmR6JHqNU5
 EDxZksW21WwHxV2n/uvd9ilCqsPSXJfb8754t7wd1zVZthIVY280Mu3EDpIpnV5qhiwJcZhjYel
 WsDVleLtuXQ7jGQBtqkGMIT56SAbkdpmnDIKVG8H1hFYP4orsp6rdinjg6MIrjDZosgm6PDJ7uB
 GHFCi//vk/magI6TxKOxw5DojXNJCUYPo/UH3d/TVJ6Dfhn+hk0w2VzAUTADfVS4SGpJWNStdNT
 MAlFyVDbdhKphaU6
X-Received: by 2002:a17:907:a317:b0:ba3:3091:e56c with SMTP id
 a640c23a62f3a-bbffb247ec0mr459029366b.14.1777897618505; Mon, 04 May 2026
 05:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260430142602.v2.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:26:46 -0600
X-Gm-Features: AVHnY4JbWkYt_U6yJM5ssaGJclPi2wdwnljH7lH5YeCKmpsDc7NvMFsZx5jChQo
Message-ID: <CAFLszTiptqaM5PHyMR=rR+KEzMSbi0RLEsW41anQ+m229teE+w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iminfo: also verify signatures
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
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

Hi Ludwig,

On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> iminfo: also verify signatures
>
> The iminfo command already verifies hashes of images. This change also
> verifies signatures of configurations if enabled.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/image-fit.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bootm.c      |  7 +++++++
>  include/image.h  |  1 +
>  3 files changed, 56 insertions(+)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,54 @@ int fit_all_image_verify(const void *fit)
> +     /* Find images parent node offset */
> +     confs_noffset =3D fdt_path_offset(fit, FIT_CONFS_PATH);
> +     if (confs_noffset < 0) {
> +             printf("Can't find configurations parent node '%s' (%s)\n",
> +                    FIT_IMAGES_PATH, fdt_strerror(confs_noffset));
> +             return confs_noffset;
> +     }

The error message passes FIT_IMAGES_PATH but the lookup is
FIT_CONFS_PATH, so a missing /configurations node will report
'/images'. Also the preceding comment is a stale copy from
fit_all_image_verify() and should refer to configurations.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,54 @@ int fit_all_image_verify(const void *fit)
> +     /* Process all config subnodes, check hashes for each */
> +     printf("## Checking configuration signatures ...\n");

Another stale comment - it's signatures here, not hashes.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,54 @@ int fit_all_image_verify(const void *fit)
> + * fit_all_configurations_verify() iterates over all configurations
> + * in the FIT and checks the signatures. Returns success if all
> + * configurations have valid signatures. See documentation at
> + * fit_config_verify_required_keys() resp fit_config_verify_key().

s/resp/or/

While here, the kernel-doc would be clearer if it stated that -ENOENT
is returned when no configurations are present, given the r =3D -ENOENT
seed.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,54 @@ int fit_all_image_verify(const void *fit)
> +     fdt_for_each_subnode(noffset, fit, confs_noffset) {
> +             int ret;
> +
> +             printf("   %s ... ", fit_get_name(fit, noffset, NULL));
> +             ret =3D fit_config_verify(fit, noffset);
> +             if (ret) {
> +                     r =3D ret;
> +                     continue;
> +             }
> +             /* valid config found */
> +             if (r =3D=3D -ENOENT)
> +                     r =3D 0;
> +             puts('OK\n');
> +     }

Patch 2 just added log_err()/log_info() centrally =E2=80=94 please use thos=
e
(and log_debug() where appropriate) rather than raw printf()/puts(),
since that is the direction of the rest of the series. Also, on a
failing config the "%s ... " line is left dangling without a newline;
please emit a clear FAIL marker in the ret !=3D 0 branch.

> diff --git a/cmd/bootm.c b/cmd/bootm.c
> @@ -335,6 +335,13 @@ static int image_info(ulong addr)
> +             if (CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED) &&
> +                 fit_all_configurations_verify(hdr) !=3D 0) {
> +                     puts("Signature verification failed!\n");
> +                     unmap_sysmem(hdr);
> +                     return 1;
> +             }
> +

The subject says iminfo "also verifies signatures", but verification
only runs when FIT_SIGNATURE_REQUIRED is set. I'd expect iminfo to
attempt verification whenever FIT_SIGNATURE is enabled so the user
sees the result, and only treat failure as fatal when REQUIRED is set
- otherwise users on the legacy path lose the diagnostic value. What
do you think?

> diff --git a/include/image.h b/include/image.h
> @@ -1355,6 +1355,7 @@ static inline int fit_config_verify(const void *fit=
, int conf_noffset)
>  }
>  #endif
>  int fit_all_image_verify(const void *fit);
> +int fit_all_configurations_verify(const void *fit);

Please add a function comment.

fit_all_configurations_verify() only does meaningful work when
FIT_SIGNATURE is enabled, otherwise fit_config_verify() is a stub
returning 0 and every config falsely reports OK. Please mirror the
fit_config_verify() pattern with a stub for the !FIT_SIGNATURE case,
or at least guard the body so a CONFIG_FIT-only build doesn't print
misleading OK lines.

Regards,
Simon
