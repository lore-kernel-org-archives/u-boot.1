Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8E6EF48E6
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A471683015;
	Fri, 13 Feb 2026 09:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uu6+gOh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFA183B9D; Fri, 13 Feb 2026 09:44:02 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C9DB80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64adabaafd6so632397d50.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:43:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770972238; cv=none;
 d=google.com; s=arc-20240605;
 b=UppWqdbGD7Mgkdk4OPU4ZxZiApMhhmeosLcpd0AhffyKhZnUXF9iah0Rry2mMQSC6i
 wA9UAoAR537dOOOlPJaL6XqEUC65jmfaZc45irgbp3lS3Ok7iLSimKS/Ob90NY5Uc8mM
 +Zx6fYPmQatS4hclS1TSkLOeaMEgGlS1sMf2kU75fpVLo1NXxmYJu52Bf4cLZmaPc3Bm
 HYFj6K1pLGPKZi2aINcksEmPXR5qQaOtQpeCKtYI+Lj+QZL7P1pJn/4RLww+jncpHlF3
 03u/j4fBa4X6ecHmiUuOFaRCD5NueHMPjSP7sJZzbjIrbsX4hvu1d4wEDQffMEE7T1Q6
 ykuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s4Ac3E+5+ifU49HEdQAsVTzYP1Yta4CcrM0RswVlAu8=;
 fh=vyfbts51IeL9YqiXEXChvJnWUKQFbZdi8gERlNYTnqw=;
 b=IjsP+uHIF6+LpvJ1vzJBVYkSFnZ42KyvohlRGLj4xA4d9PZhzWtZ1StlqtUR2B9P6t
 8reEpHx/jFePuYDJ85MTbhWr2hOUnNhwo491VevC1z3pbkpANdLmnbM2/R2AQH8KZpX5
 TnDOiYqJ3dMpVWw6FMdytc5VMUt6qQMzh7IdtjgnFM9Axdj66zBM+k5zaVU2j62gYIHb
 UwZdOdN2IimWuQN//9rnESsx9z1eMoYdHsQ5UCKOXQFG2RxhBk8/X6AsDmJ5E+HlnAyP
 f2bztMnqWDBavPlJHSIzNHJFekPXvLKecUksJePVrGP8wW9toxtkVFMsMqaymcqJ8EWN
 0z1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770972238; x=1771577038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s4Ac3E+5+ifU49HEdQAsVTzYP1Yta4CcrM0RswVlAu8=;
 b=uu6+gOh5L1qszL1TRDjGMCFo1ajRivvTMITPkNdNLo8Be2IZVjkDLY4mwChPeDEPst
 sjFyr+z8+gCJIMLm+tfvVOcuFLy8rpYxk719ITIHQkugIPU0a/6csSbCVW1Z+DTdaFLq
 GXg05iMZScq0CQq3cf65FU7/AKCbWuLZzlr42cp1NSBg42+bYuPncS/9AWlDZNlZ9beI
 2dthb7P/kENsUMiyYZiwlEcGssmRoRuCWHfKKjFOdnhGukVH2zC5Ge6KakS2NdrwHhG7
 MKRN6/Fpsq8MCy8+G48Oe/mfWKEGnPer/uvNcHeW6Exyh6cgAUoveSw0tkCuDCH7Jw8D
 wRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972238; x=1771577038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4Ac3E+5+ifU49HEdQAsVTzYP1Yta4CcrM0RswVlAu8=;
 b=bn8pQCyc93JwBLGIR1m/D7vKrPmyHCT+BymE+JkgKC79aT8SyR/rVwRcPyc39O6tjW
 KCUmlCkUg8SNFCJ6b1GlyGgiZ5M+/F1FwdKJcZ7pbr5XyK4bJmXv70gjL9zJqTPB9qMO
 CO0kSVAXmInrXMbg3AagWm5Yx3knSyFeXVxQnjTVLhrfxMoB6n+HPNUBToJmAq33os9y
 8il9CiqPJ5VIKL04E0DBu0SlZGGIku8nFrE0ICoLot33Ec449Jz7UrpRRlIN7XNO2i3w
 E8s7zkgnp83L8YkMv2oJQXT5eIuhnCIGjpyvd0Gq96jjay8j/PK+oQDxClFiZuKdV6l6
 UEOA==
X-Gm-Message-State: AOJu0YycK61KUJaMwIGbVqA7y4LYR2o57t55iPGmiBX/dpS21vTEveEH
 vtswlvmTghEO+Q+inqf4RXQNHI2AW0kucpFXRmyV2CSsjYFU29NO8JzVvpv44fiLFuer3V9grYF
 HDf0YhcxqGhsFD1twSxVTGdBt/y9SeQQSEUWWjBJoQQ==
X-Gm-Gg: AZuq6aJTpQONR+bSoo53mi6T2drUMiFHpb5mkv6xP343apkj9Y7P12UKpF3VbH2VqJe
 bYHrN03QXzSqYjz8+XFu8oYvCfn4O/VyjZo3nIoyXv7DVsKVc32FQyftC2GGJlC+s0x0Zi+d2jr
 PJtH4CJd0awGg+JJ4luDqoG7bM61YA4a/vtWp/iNXgZBsy0GTQnrLujU4ENRzwEBY7OAMeXPjpb
 q+lalcpm2S/Mcz/PL7Yf7zh7RsZClOP0FAiLR8gHa0U0Amzu6uml/rd6LnaYGXe4BH8PHeS5Bwy
 KTCpUiAniHa2qGIxAHoRT36drLc5p4ZvIdrJGqnnFmJgpcfq1ahd8ouQaXf/Pn9uqqTjliWcINr
 uULdNqANj+cDRw2aYGWdL6ICSjR4ot6lLuR0CE50+VwdUM02zX6M5Z7+900oGXhv1eaFaGNNX/1
 dxCddJaaBJsQg6I1VTC7WROP025g3Mv70TU1pxdKXQX+m78NbaUsIETbsoa4fKpcC1d/M8foCwE
 fDtMwm+dAT/P4ltEgFvJrQZZ8wz7YnmThRg9AUvpRNwU/GT6/fNdy8PqXnnT4hL69id5vlZffmJ
 9LNXC9g7SxrUm7y55444zlCVucMweZUH5gC8eGDW0C+Q
X-Received: by 2002:a53:dfcb:0:b0:63f:9c70:84ed with SMTP id
 956f58d0204a3-64c19b2de9amr570024d50.58.1770972237977; Fri, 13 Feb 2026
 00:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-5-javierm@redhat.com>
In-Reply-To: <20260212204511.619392-5-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 10:43:22 +0200
X-Gm-Features: AZwV_QhlTR265iDnD7bhBuauwt3FB-OOPlNNV5WHUM2ND9iANlco_6JqavEm04M
Message-ID: <CAC_iWjK0ZCjM14zjPOW5KAnNNoC8AUQO=KqcZWEFd5k+tbaOJw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] disk: part_dos: Document part_get_info_extended()
 helper function
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, Tom Rini <trini@konsulko.com>
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

On Thu, 12 Feb 2026 at 22:45, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The function receives many parameters but these are not documented.
> Add a description for these to make it easier to follow what it does.
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  disk/part_dos.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 60c3d6773696..a69ad8962106 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -196,7 +196,18 @@ static void print_partition_extended(struct blk_desc *desc,
>         return;
>  }
>
> -/*  Print a partition that is relative to its Extended partition table
> +/**
> + * part_get_info_extended() - get partition info for a DOS partition
> + *
> + * @desc:              Block device descriptor
> + * @ext_part_sector:   Partition table sector
> + * @relative:          Relative offset for the partition
> + * @part_num:          Current partition number
> + * @which_part:                Target partition number
> + * @info:              Returns a pointer to the partition info
> + * @disksig:           Disk signature
> + *
> + * Return:             0 on success, negative on error
>   */
>  static int part_get_info_extended(struct blk_desc *desc,
>                                   lbaint_t ext_part_sector, lbaint_t relative,
> --
> 2.53.0
>
