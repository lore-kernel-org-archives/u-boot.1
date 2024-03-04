Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199F8C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9160387FCB;
	Mon,  4 Mar 2024 16:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="MmOUl4N8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3342887FCB; Mon,  4 Mar 2024 16:40:34 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59C7875FA
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sheng.tan@9elements.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a458850dbddso47916666b.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1709566831; x=1710171631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gIOfb2neKoh8PHnqzajWm8x0jCWw2kUDmvsk797pbEc=;
 b=MmOUl4N8JX/lJ6YZnOmcUf2tWn3Z7dzvLo3F3r/CTXk/IqFcK7vqG4MKenCAMw1RAR
 s3IyJ7K31xJyJzjwGbe+xpXaM0PIs18Ck17e4q6UOMQmo/vqIP6BhoG25wFfY4xZQKpj
 YF/4R2uPaW8jFZMSHk2YlskxNoutXub+ZnX9yKTtvzTjxLDTVQjri1pK6Je8y7GWbdQq
 2x+iaUirzgjH3dG8fsQ0wPAIeYb+Prz/TgXwXBktjDEfgcnHxaJQSC9OjeAcpjt+0K8b
 IxQzlUpYHNP+az0xyejdn7Z8Pj061q9LdlSJXiwNiJgkigE9UFzl7KeB9hJXdBW6QjkL
 E07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566831; x=1710171631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIOfb2neKoh8PHnqzajWm8x0jCWw2kUDmvsk797pbEc=;
 b=lJ+jbCxsAi7QWmD+wcFeul2ihn+TC07AVmJT59QE2JvbYi9to9uuzVtoI8qH09vjhp
 GZhLrivyqxZH8WPUrQvsF43Ytkuk/V8GBKcYuttUaUbj6bi0a7MCIPePEQNXwLQknpcY
 fwLIhzOAH4jwpcO29Rf+T6gidA/PLB6uIUv6L1/ePvWH00yR1GLwUoPJKax3MZh8t5s3
 uwxVqpLJ5Vk9cr/AYIqDwOUKgMRLkBB+FG6zgcbqRJsOp/U2F+XKBUzgu8NdH+YoRELV
 GjEeSd69hnMU/PMoFeVISroL0dY6cqK8c/ZZlbJ4pwwt4KDYQSrO97B/XdS2r7VseCHx
 Tj/g==
X-Gm-Message-State: AOJu0YyyttLVrYDNZuhZRwYbDDGex7uscJp20JOdj0tdv33U1ySzRT6H
 XJV12TEGlEERk8nk+LdVJB+PwIJ9alodLIj9W4n6KCCSKNWkO1nswL1CknP+cDWkQphAz2q2woj
 W2Rhi5OFZZ+cLm4fmi2JutQgHw9T6o7a4RBOm0A==
X-Google-Smtp-Source: AGHT+IFtPpaw7AnHVH98MQyGnHmzERlK8Q3GeKu5k1BHGNOijLAoUZ/iRqACHay4rDglZ6ShzjrAc3GvpDLy2qpdy9A=
X-Received: by 2002:a17:906:fb84:b0:a44:2634:abfe with SMTP id
 lr4-20020a170906fb8400b00a442634abfemr6563856ejb.18.1709566830846; Mon, 04
 Mar 2024 07:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20240227201857.25814-1-cmax@mailbox.org>
In-Reply-To: <20240227201857.25814-1-cmax@mailbox.org>
From: Lean Sheng Tan <sheng.tan@9elements.com>
Date: Mon, 4 Mar 2024 16:39:55 +0100
Message-ID: <CAMWxwJ03vRW3Cqis7i5Lyd3n0WGHPe1tNNHOpWJt7bKPh0pAVw@mail.gmail.com>
Subject: Re: [PATCH] mmc: arm_pl180: Limit data transfer to U16_MAX
To: cmax@mailbox.org
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

Quick reminder:
Can anyone help to review this?
Thanks!

Best Regards,
*Lean Sheng Tan*



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email: sheng.tan@9elements.com
Phone: *+49 234 68 94 188 <+492346894188>*
Mobile: *+49 176 76 113842 <+4917676113842>*

Registered office: Bochum
Commercial register: Amtsgericht Bochum, HRB 17519
Management: Sebastian German, Eray Bazaar

Data protection information according to Art. 13 GDPR
<https://9elements.com/privacy>


On Tue, 27 Feb 2024 at 22:02, <cmax@mailbox.org> wrote:

> From: max <cmax@mailbox.org>
>
> Currently fetching files bigger that cause a data transfer greater than
> U16_MAX fails.
>
> The reason is that the specification defines the datalength register
> as a 16 bit wide register, but in u-boot it is used as if it is an
> 32 bit register. Therefore values greater than U16_MAX cause an
> infinite loop inside u-boot. U-boot expects to get more data from
> interface/hardware then it will ever get and therefore inifintely waits
> for more data that will never come.
>
> Signed-off-by: max <cmax@mailbox.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/arm_pl180_mmci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index 5cf5502ed5..af2f9a5a84 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -231,6 +231,7 @@ static int do_data_transfer(struct mmc *dev,
>         u32 blksz =3D 0;
>         u32 data_ctrl =3D 0;
>         u32 data_len =3D (u32) (data->blocks * data->blocksize);
> +       assert(data_len < U16_MAX); // should be ensured by
> arm_pl180_get_b_max
>
>         if (!host->version2) {
>                 blksz =3D (ffs(data->blocksize) - 1);
> @@ -358,6 +359,14 @@ static int  host_set_ios(struct mmc *dev)
>         return 0;
>  }
>
> +static int arm_pl180_get_b_max(struct udevice *dev, void *dst, lbaint_t
> blkcnt)
> +{
> +       struct mmc_uclass_priv *upriv =3D dev_get_uclass_priv(dev);
> +       struct mmc *mmc =3D upriv->mmc;
> +
> +       return U16_MAX / mmc->read_bl_len;
> +}
> +
>  #ifndef CONFIG_DM_MMC
>  /* MMC uses open drain drivers in the enumeration phase */
>  static int mmc_host_reset(struct mmc *dev)
> @@ -373,6 +382,7 @@ static const struct mmc_ops arm_pl180_mmci_ops =3D {
>         .send_cmd =3D host_request,
>         .set_ios =3D host_set_ios,
>         .init =3D mmc_host_reset,
> +       .get_b_max =3D arm_pl180_get_b_max,
>  };
>
>  /*
> @@ -531,6 +541,7 @@ static const struct dm_mmc_ops arm_pl180_dm_mmc_ops =
=3D {
>         .send_cmd =3D dm_host_request,
>         .set_ios =3D dm_host_set_ios,
>         .get_cd =3D dm_mmc_getcd,
> +       .get_b_max =3D arm_pl180_get_b_max,
>  };
>
>  static int arm_pl180_mmc_of_to_plat(struct udevice *dev)
> --
> 2.43.0
>
>
