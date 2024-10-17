Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83A3D21269
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 09:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD56C88EE3;
	Thu, 17 Oct 2024 11:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VFNOLHpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB4B88EBA; Thu, 17 Oct 2024 11:38:51 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FA888BB2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 11:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so916965a12.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729157927; x=1729762727; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9qbCATRbydLfAdtBXzai8vKR2MSTRx38neieCunPUzo=;
 b=VFNOLHpx0Vo8ElXpip3T3hnrW4K4QQ51h0qKqFbGApgmoCaQw4u8f40VzMeBXs+V+9
 ZeCqz/+Xgz1+pWsbrU60v908z7XYmvTtHeY6Kiv/Eb0VBLzbd3RqU39ksjDr0O9EiGtX
 rvQjzH0I1lPDIpwIyAoHSx5dimyMdHLAlghZw7Z0aW9QaajhxQ8Jci/E/ImUivpw/I5p
 1toa4WLbIkQlX6/wu872Cg3dvr3wbxb9WXSI1VpYpDXHIMvdp43QlaLBgGIxZ3yXAuhE
 ozM0TmvuZbIRLuCANNuf6TS4GqFNHaCsS0UIWGPPc+xvORZncsBT4E+/pGAXGOglKDJ6
 D9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729157927; x=1729762727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qbCATRbydLfAdtBXzai8vKR2MSTRx38neieCunPUzo=;
 b=kYRDId1bpfeeidBprS6toPOlIth4xpgdpPgsp2Fzcm2NxJQnAaFGCb1hi4JeSA8xjI
 APq/Oyx/6H+wAQyMmM7qe1+H4EeDApVx6MGHjtEqNmzbYMp3KfLdcdpa2U6X2aIIwCTx
 Sy+7WFFh7sSds4+oycy++DPDj7dauIS+yyuNmvtHbC6FJBYTjSB/m+wvx4GIOMPZoyJn
 +fNfBD0twuIzGWk9NpKJ53y0FDJsFxexKN219Gc+XqnJHvpmwTPXVprbU9qq9F8X2BFc
 C/FOPOZb06Ewg1BUTR4WeqlfVbqAcYX13BnhX8+ogZaWg3DK9hPt/nVJ1VYokQnOQx1x
 4NbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhOPvYZuq5bn4pxiWi3I79lNMKvouEKC4BGHHhEsnWRSGqF0WO+tJlcpRPrdAeh7STFyRCnNA=@lists.denx.de
X-Gm-Message-State: AOJu0YxB8/smdx486r449oQNiXiHydyAC/GT10v4QjcRf2/ncHZge6H2
 H8tN/A3HdVoLUZydlF8YaP1GvXD20xKu+8Qna5YxsMZ0ZbZn+Hq+r3w5eOaCSHflfdbEW4iA8KB
 x8YgUoBHyPKcJjjzZ92DVVtP9VJw=
X-Google-Smtp-Source: AGHT+IGFvWrlsQonxItJrjmfhmgPm8/JiXGf/o+RwnOB2EPGxBlhBFQ3778xya/MaQ710e7z0bgLpX/IOixwvETIb+g=
X-Received: by 2002:a05:6402:51c7:b0:5c5:cd34:48d6 with SMTP id
 4fb4d7f45d1cf-5c995094b79mr4699242a12.1.1729157927056; Thu, 17 Oct 2024
 02:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241016201523.903560-1-jonas@kwiboo.se>
In-Reply-To: <20241016201523.903560-1-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 17 Oct 2024 10:38:35 +0100
Message-ID: <CALeDE9MrUC2AsD_AudWHy+x3J_Ea9hMkRB_8NnqYczLLJZp=oA@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3399-pinephone-pro: Drop upstream props from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Wed, 16 Oct 2024 at 21:15, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The SPI flash node has been added in upstream DT, drop all props beside
> bootph-* props from the SPI flash related nodes in u-boot.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>  arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index 037cec10ce36..7438bec4ee63 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -15,13 +15,8 @@
>  };
>
>  &spi1 {
> -       status = "okay";
> -
>         flash@0 {
> -               compatible = "jedec,spi-nor";
> -               reg = <0>;
>                 bootph-pre-ram;
>                 bootph-some-ram;
> -               spi-max-frequency = <10000000>;
>         };
>  };
> --
> 2.46.2
>
