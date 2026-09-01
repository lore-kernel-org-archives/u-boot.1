Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40A9C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8CD280AC5;
	Tue,  1 Sep 2026 09:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmY6fiPOJ0mZ; Tue,  1 Sep 2026 09:16:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254198;
	bh=nE01rZAAxAp/yiXlGW7d389R2Gy5vTfD1iSOi9w6zz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ayANrP++J1k6mOt5xNQm/cje8Fbm4RqghGdnzvW7IqU+7ZHAVaslvg8P3uehLSkyk
	 upSgwYcJVZ9FhSPxqAB5OtQyYzhIDK56gTZzESxZHUqUPi3EfOWziUd6PoXHbY/Qlx
	 BFp3Vt5x3YrJasXkOV+hgqgUXWWgpBWYCdvK37SEoF+mwVatC0Vg1tLlTiMPLH7l0B
	 EbTYupM1bOKBG9LlzPlBXjSbZOfWw8nmd211wa6Hz0jsmdsfz5CnrEtVVrFy1psGC1
	 ei2VXBAWIlXGkvrMU0bHPx61ELlPZLRzmp/ZtrTAjke17oMoNF+/0L0swJD/bVxygO
	 OuovGh28pqOoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2DA580C04;
	Tue,  1 Sep 2026 09:16:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 87AAD105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77CA340189
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YBfZUd21YP2S for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:16:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=T87LnwMX
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87F43400A8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:16:35 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so69391866b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 02:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788254194; cv=none;
 d=google.com; s=arc-20260327;
 b=fGYrBMG5VHrjivah+AeJ15E1bnTg5BHf5ss53zSo2hWEx3EL7orpthWdzsd8R7Ujm1
 v9LTr7Gm6OgPmeKiqj6k1lbXX4Xix0cGmRz0A0A3ASuhg7Lyoty4d/DLs1mkuIYi/v+u
 bUkUYYaON6fMCJrNe1gSBIvRFhhPx/w8Twd6irOetD0EjK15d2yS5jBd2JqAqdJ7ZQkq
 6rE3UbYirBj5X7QIxkPJztjYCEvjgMbIQjkNEl6kDUYQp+fN9KEOuwz/Vk2SlmeS9Mwk
 Nn1GYrjFRkvBnHkgNd6yW9kxx1y+4/EqybOkU+r29ck7tAO4YqB2xrKknDNaB10QJkTk
 qmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nE01rZAAxAp/yiXlGW7d389R2Gy5vTfD1iSOi9w6zz4=;
 fh=Zr3KsyG92Pk5vw4SDpbswntIHeJfrYQKH8zdvtecD7g=;
 b=kML0lNzSU67PFSEvrg79gzUhrjITMTom8vrg9oKMui6+HVvMh/enHsFT43/HKpF8ZT
 1G2wwYYN7ZLPOge8bOGhMEqnzrfy9S2HjUUqQ6VVkLbSlMi9EEBR9O19R464DF/czUzA
 uDAfryhV4IFL62Ygx5k4DiVshloleeYvA3WsK7RWVeGDCTE7K0Ys+QSRIV/o8mnbFpfP
 nTA/tEQqWZnka52wGBE2Jlp9GKJ6bAOsYc39a+hpFbne6/XGjFOJRwXZGKW8vpsZEhic
 At2BIaGE23mBORe98wDzScMA4lSXX7dQP5jGTC21Kt0OWAavlhNRpJ5evlVeE3r91bqv
 EZUQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788254194; x=1788858994;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nE01rZAAxAp/yiXlGW7d389R2Gy5vTfD1iSOi9w6zz4=;
 b=T87LnwMXKNvfAWwk4HU1Z+gWvXRcNgLQSb8W2cOLC1EeuKRlaDmy2Ez7jpvEdGJTEu
 48XVFvFUKz6YQx0ho4YL0rQfdwMNXdtiGLN2BFBh6xcVv4oi9rwWsWULLIJp78jXb0BY
 iZne2h0yKyOAD98pIw8NEbvZ84BL3Hfz1aYxfDRZyp+cysSrjH4XwZDF396cV8MuCDV8
 f8syLqZFLoqDhYyrxAsikBpQhlhcofdbGxJ7FiKEqGCpgfw0cE4TZnGPjvMaI4NJVzHZ
 147YEQN0FajTVjgndFl6sVEpkq/1fktXJzXpgmxu/GmRQphJzgs96QKakNqD42o0M094
 03dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788254194; x=1788858994;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nE01rZAAxAp/yiXlGW7d389R2Gy5vTfD1iSOi9w6zz4=;
 b=K59lc2GbShIPs9AV+22QZAni1kaPxHX8KeI02BoAykjNl8ezmsvQqeGGifd7Z775/g
 wZpyAZ7g8ayVCSsOqcbqwkNboTu/ygYaRhIZGoJkLD01E7taGRKMZXxHjKSDWp1Agc67
 LJKNLMRvITr8HSLFOWCJWtRQ4imEhvDLZwMh5u8/Ys7NNJ9gPz1U4rc9qJAzr4ypBPkv
 8AsssEgq9yGsm214zBJ39kso3NLTWyf0zguLP+SYJcTCQV881wuskYt08rZMQuVo8K1/
 NiSKQNYfknYWCovX9vbtBelFzAE4dAMUlX2qr+5fyHt6Z8sfwC2tGK8Dg5kyJ0vOQFtH
 b8pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNd9EeN5PpJvAv6rTJoOYgyopbx352HLQMHU1JR43Wj2VQ3NGBUDhN2cfrhjRh7povWQbf8CY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nxqLQxlmcy18/sfp43jsqRTqq8ISNoUgxUhYDMxRVJQlYS0MZw
 Yw+ZR7KYjPKfGa00+Csj47ClE6tjUYwemIxf2XrmYPzMa73Lvk2oOeP21g4jSR0aglr5pWqEhfO
 2bhXeYqVI7QO/baiNpVrSMGwlg1iTshtKtGTvBJ017w==
X-Gm-Gg: AYBFou1hMSsahwGzmHEipKv+Ws3IuvYb9dcY6DZqGI3xeB9QULu6xnyuTDP/B+3lKiB
 9757K++EU80IVnSIZd6YAKXXbQ/iWtQ0cIQHDpjQ89GYcBlXkleIu6FUBiqzzHE86wRBoVncNF5
 qggdOuUXhlEgjiJHIoAr+IuMPM4zySNC3xfYXaiznmZ8eqoEi34VYHQCNTeUPwUVDK2q9I5Z/E7
 zAjv1Ef8KJsWzwE13PFycfmp1Si/OjkEX0fsBTZMT5Ud2DuduT4NS593l0bTgd3Xov3oRuERXBN
 drwSa/qAtVicxor9K1fQP4KPoSM/PCEi4XBy2FYfMt+D8/NrHrctEGw4vzTy5n4zgyR6V9JR3Vm
 gJsr9nPFNzH9dlD529e9EM3G4GrHaAsV9GOqWVtCneJwCSuV3bsiGLajYouJOVYx8
X-Received: by 2002:a17:906:8e0e:b0:c12:74af:51f3 with SMTP id
 a640c23a62f3a-c2556fe3283mr2043860066b.6.1788254193780; Tue, 01 Sep 2026
 02:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-1-9dc80d307790@baylibre.com>
In-Reply-To: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-1-9dc80d307790@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 1 Sep 2026 11:16:25 +0200
X-Gm-Features: AcwNN1Vec6ZMCyxFxJEY0RoaWwxBHjfgjYCy73JHZ3H1M5KMMMHsk2yg6iVSLu0
Message-ID: <CAEHHSva3pxVdqAYa6Qs-zwW=JE0y7fJ-zL8MLGE_7Mc7s1Cc5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: propagate show_splash() return value
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

I messed up the u-boot list, removing the old one, adding the new one.
Sorry for the noise

Le mar. 1 sept. 2026 =C3=A0 10:52, Julien Stephan <jstephan@baylibre.com> a=
 =C3=A9crit :
>
> show_splash() computed the result of video_bmp_display() but discarded
> it and always returned 0, so a failing splash display was silently
> ignored by video_post_probe(). Return the value directly instead.
>
> This has the side effect of actually making the whole video device fail
> to probe (no display), where before the console came up fine minus the
> logo.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/video-uclass.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index 228d6bacc58..de161054d52 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -595,11 +595,8 @@ void *video_get_u_boot_logo(void)
>  static int show_splash(struct udevice *dev)
>  {
>         u8 *data =3D SPLASH_START(u_boot_logo);
> -       int ret;
> -
> -       ret =3D video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
>
> -       return 0;
> +       return video_bmp_display(dev, map_to_sysmem(data), -4, 4, true);
>  }
>
>  int video_default_font_height(struct udevice *dev)
>
> --
> 2.55.0
>
