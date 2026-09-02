Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A8FC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4EF780F77;
	Wed,  2 Sep 2026 12:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxAxxET5uxdW; Wed,  2 Sep 2026 12:59:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788353975;
	bh=8t36whnZSBiu3nFO5QAItxoU/PgzUOvQ+4pbrOhaXdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sJ9lGZAu0b/8OkJwso9HqjgXEtbpvp490ifXO6lV3Lm4jaNcGq3p9SHZ0WXgjdLMw
	 WOWEJnOUVE/7F54VKlyF8WWICPCz8x4uPbtcoKpqcUE5MARv55xIPh21gSLKID7weE
	 azh1CUBhPl8C3Vbeh9cU3myUpyF3yLEZ666g3VCPsvX8frML0D5nTe/MLDCndJaBiS
	 WEI07h2fZwVq3DsKj1Ta85mF1I9cXjlJ+xlhO6APZ+CZqc6bKxx1QRqVjjEqSt4sbO
	 zW6kZCiKXvDGqGRKH7T9kLhtNmDBwBiEP80uIClL2p+o3sXQD58vllDlY7LzrWj5UH
	 ijq3dCsCABleA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8D5B80F71;
	Wed,  2 Sep 2026 12:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 11ADC2FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0333A6070B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V2xAPkhFMUF1 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:59:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=g4KjIpfv
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 892F0606F5
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:59:31 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so123249266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 05:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788353969; cv=none;
 d=google.com; s=arc-20260327;
 b=sbdsG4wG8KmpbKcqaWRoFyv5XPWoeB+ehSMP9ncE3nHtDSj0CFerU3IXXYhUIWxsRU
 aq4SiYyu6HrLS8RH43N/wXg85VRfSDog2xfUgT7xUdi9vd4Yd6gnP4Dd/A44VxBd1JIx
 Bodm5/T3KgfxM81rUOVDQrlhrmJLl41eCsTd9HdIVHdgg5pS750y0nwRGbzrD3lPXIyM
 Z/wD8cILkDpyl1MInXl73j4dpBX84XDz0RTOn6GhbUidTZT5aRvoZ6cmB9JNQWhJ1oy1
 Xzze/mxJMYSNxF9i9dVSNVGLVmiCbktCJViBv9yOhMSdQp5kAyo51Y8W3WYkgsa3dZJ9
 RWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8t36whnZSBiu3nFO5QAItxoU/PgzUOvQ+4pbrOhaXdU=;
 fh=viAgNlMjmVyVwSS2sa6lJHG0jCqjKTW84ONUun+kAMc=;
 b=Ske0M7UQUQ0Pt79AWXclxt2rfEavK3ROyk9cQFBfY3QNh+DOu2cYfiCPJOgab2pq98
 7GQojOcGrsmsexbWF4RfVA2vfhFEgl/aDXQYANp9tCGmFZgAZDf39kyKjhXnHtimHWG4
 FHOtq8BNaEVADRjLttv+b+lTMJ5HP6k1yh0igRuZhiJrSOl6SnHSNnsZAueaq+3axGQe
 rjf215AXqFV/E0XW6/t4hgsJ+RoFrtvZiEbk8x8fw/zaZsJ1K3nFD6B8BngIhX+xTbIJ
 kVFx2wN3tOmrhdube6pJnp/75OYO8pdd75aAKOtceB3FDm4wodz41M9AY+TPRZlUXpgU
 Q1LQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788353969; x=1788958769;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8t36whnZSBiu3nFO5QAItxoU/PgzUOvQ+4pbrOhaXdU=;
 b=g4KjIpfv++O31Fyib4BQXeRLWDFjkbkY0sse6acJbhPeX38xk40LX9nyhTIC/wflfo
 qbjGvo8wmfVvHTGgpE2DEDHIOOB1SVc1+7JD/TSh/rFcuNS4yzi+6BKluMHP8Cpmi6xG
 kQDknvCpH/ymipXtF4eYoKgC2llGvhESMpR0u9dCSHWQHUEPlsxLIxWbt8C9/GC4uXeK
 k+4cx22rVD1FCYsuW8MyGfr0IdzxYqINTm0LBNc0gAlVCbuLnBmHyaF6/LIdtnkO0C2l
 roA4vVS8Itixj28HyrldG1FqmJyu87qWGcFXoUjRVbnUkKRemupqE7k4pt+mgjTqr8qO
 TiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788353969; x=1788958769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8t36whnZSBiu3nFO5QAItxoU/PgzUOvQ+4pbrOhaXdU=;
 b=Im7idwJeF7ji5EQd94uf8X/q/POnV9xQeCezQKOc8WhxE45M9SOHf/510Dwy90gOPM
 8b/WrZZ87vo+h+7IoBWkwl6LGk2NtdUF+9HTpdDlhOPYbTDESdORmCf4fbrMsh+W4+zf
 vH9rMorFZ6udFAj+3UAx3dyuqm2mLWUunua3seSOjfQnW142JQk8/CZsV54ev4U1HRQe
 rB1JndqbINpBRp+FaYOPZ07k9+Di0JQUlaFl60aOfI3UF1h2LTwzzF0oQQXmSKkSHWpE
 zRpOhJDuAtB80uaR3frieUJRzKkM+jmPCzYa6HLfMrVrw44VIpJT5XHfGTXYmtMY+A6T
 QJZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4IZF/oUsum+owTI57x+vSDK/BcaqB9fjGgVs+oBUN045xesrDsDZ3E54z6WLR4ExAnLmEGYw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lBKbl+OgGfo7HpDAjEpo0Hd9z13/swv55rCp4t0p18D+jXWVa7
 MHPQ4SBNT52mTEIotB8FTfSwjnn7wI0IRIfzb9iEIKTd31dFaqPf0GqXfeIBFhC2cNn4zsCurtr
 lRGT9C4GRc0EAxN70lNw3RIosEIagG0bKaQlKnrLkhA==
X-Gm-Gg: AR+sD13amel+m2kWTfL+fe1R1Wd/NjT19lFxRrZBFmZevbhOSpDKe0PW9C9rxoAd0eC
 830/qEYihlAsMfJ3q45geQlDIqYgidsSBdLyTdnTJU98VJ2duuzC+J89Ms0llbdqkCbJzio1mKh
 D4hwzL0vi6jDgabiKQi/HOXBFei7oG63bvASSWdTcehegmv+NcRhkwDCaq00k40FqWdcGfkSCwp
 4DtBK1rrFhadGSSAVmUHTt9ABdsyiGH9SxG7zml6v0hxNoaFzQsPzIWv3iw5GYQ504/L5Xn28/g
 bAGGrPlQkZcBJ2cM92ubz9j2G+/Rmvh77HnsIeJCMJm/BHwUuzKOa0zdpnZbGMBBhWie6DH+6Wq
 5OZrDUQzScpyw88yQQ5qym57hG/i11byDkurdawLqSgcEQ05Q7mH9JfCI3kEWb4BH
X-Received: by 2002:a17:907:e1c5:20b0:c24:c250:a6b5 with SMTP id
 a640c23a62f3a-c25d54764d7mr208272766b.12.1788353969066; Wed, 02 Sep 2026
 05:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-mtk-power-domain-remove-dcm-v1-1-13de7925ceec@baylibre.com>
In-Reply-To: <20260818-mtk-power-domain-remove-dcm-v1-1-13de7925ceec@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 2 Sep 2026 14:59:20 +0200
X-Gm-Features: AcwNN1VOwZYHQTg0CyVVajpza2mUGkSIMe0yPrsvjoukldPG2wBXAWcynEaw6MA
Message-ID: <CAEHHSvayBEsqa6G5caShT94mR+axbxKhwQxbisM=+cg5uHrw7A@mail.gmail.com>
Subject: Re: [PATCH] power: domain: mtk: remove setting DCM_TOP_EN
To: David Lechner <dlechner@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
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

Le mar. 18 ao=C3=BBt 2026 =C3=A0 15:34, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Remove setting DCM_TOP_EN (Dynamic Clock Management). This is not
> present in the Linux driver and MT8xxx SoCs don't have this register.
> Writing this register causes a hard fault on MT8366.
>
> Fixes: a81e1f8a7cf2 ("power: domain: mediatek: add support for the power-=
controller model")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/power/domain/mtk-power-domain.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/doma=
in/mtk-power-domain.c
> index 9eef58d2d57..b0cb8bad6e6 100644
> --- a/drivers/power/domain/mtk-power-domain.c
> +++ b/drivers/power/domain/mtk-power-domain.c
> @@ -368,11 +368,6 @@ static int mtk_scpsys_add_one_domain(struct udevice =
*dev, ofnode node, int paren
>                         return PTR_ERR(regmap);
>
>                 domain->infracfg =3D regmap_get_range(regmap, 0);
> -
> -               /* enable Infra DCM */
> -               if (domain->infracfg)
> -                       setbits_le32(domain->infracfg + INFRA_TOPDCM_CTRL=
,
> -                                    DCM_TOP_EN);
>         }
>
>         num_clks =3D ofnode_read_string_count(node, "clock-names");
>
> ---
> base-commit: 7581a12eb96c8b8825b65a9c597696cb28cb6155
> change-id: 20260818-mtk-power-domain-remove-dcm-7f9ab83bf8e5
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Tested on genio-700-evk

Tested-by: Julien Stephan <jstephan@baylibre.com>
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
