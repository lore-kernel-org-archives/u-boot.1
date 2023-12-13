Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE866C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E4D877E2;
	Wed, 13 Dec 2023 17:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YbftWl4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B9987827; Wed, 13 Dec 2023 17:25:28 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD4D186564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ce6d089482so760121b3a.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484725; x=1703089525; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEvpvnGftqsvIaZ3e9aRPxy6zYWFpLCQOhzzOOZ5zEY=;
 b=YbftWl4lTRG8ctDGLO+PpQYWHj8dI5bSR3pIAZulc+HZxDunVcEB3lwNaDHiFBvE1x
 BvjTPKe9z743cIJR75xt/R+GexYWqjeb3bADwqsL7B6Cn4Y6YqdG9R+iXECbovYov9zr
 8Y0prYuPJtENNOvOg2CRDVeY4rKavPFKP2XZyDS2/IcUedszoTIVu28xEOqkRNQxgyrr
 Gk+/lYtjqicHC2EszvaukCiq3GwY917z3E9CkZQfq//Wu9nGXRCql3el9LzTwV3DAmI8
 E+7BVyD9nTHA/bKjhNogBR3Lrn/wcSPhecUlCXZBAYo1uEw0V/ftnzc4jhyOl7hHjAHk
 IZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484725; x=1703089525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEvpvnGftqsvIaZ3e9aRPxy6zYWFpLCQOhzzOOZ5zEY=;
 b=qReaV+8cxs/aY3XolrbVuAq+ewzsOF9N/SvZMoiwaFm9yMyzo+8XjilZvRii/mNQnv
 Qi2Wz4okYgGKCllhEkWR/vi8sFISdmEWCD+uxYSyjUT5n9CZC0Z1xi2EUeoU5CdC5pR7
 wKg6TRXn9iWBkZOpIXMUafhc3hRAiqUTOBnML6Engjanvl4JwMYHWNG5xw0Kzo7qyQi5
 wag4idz672Y3UceEXbSCZX4Fx2gvgX4NyKVggDdMohd6pCqD9ObMp/7S+TOgoJ3NYBNi
 oLcED85kvtQfaspHuC/thXEpSl+iuavooQuqXB++eHKIX5t/RzarFMV3utwfULcK50VD
 hftw==
X-Gm-Message-State: AOJu0Ywc0F9EkD6qZKYKFU+YuIR8OSumeSZze0tPn/WaoTRaZIOc9rbC
 eiZfTS/bBhqoMO8eyCRzbvI5Mb0aFrjtiVsc8OM=
X-Google-Smtp-Source: AGHT+IF2uvUQ1c4SgOQg0rzWiLSSqIJYqAsaHIxzqUncX0NwmFgGY3hpmEGQD1CyiAl4XqU1jq/HsWWnevcogdNZxNw=
X-Received: by 2002:a05:6a00:2401:b0:6ce:4f4c:d475 with SMTP id
 z1-20020a056a00240100b006ce4f4cd475mr17882533pfh.3.1702484724866; Wed, 13 Dec
 2023 08:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20231017142500.4074185-1-hugo@hugovil.com>
In-Reply-To: <20231017142500.4074185-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:25:12 -0300
Message-ID: <CAOMZO5A7rmVzwmsewahpRpwup_TSceZC00856xdZ0EOXjhJ1EQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mn-var-som: add manufacturer to target description
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Tue, Oct 17, 2023 at 11:25=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Add Variscite manufacturer to the IMX8MN_VAR_SOM target menu label as
> the majority of targets include the manufacturer as part of their menu
> description/label and it helps when looking for a particular
> manufacturer/board.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to u-boot-imx next, thanks.
