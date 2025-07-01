Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EC6C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E0382CFA;
	Tue,  1 Jul 2025 20:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5xZvcx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E3DE82E08; Tue,  1 Jul 2025 20:51:11 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CE782B18
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-553b9eb2299so6315860e87.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751395868; x=1752000668; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5OXq6RH3T9EeTCnEMSgRKkiXmejq9vEkbfGdOIB2ro=;
 b=I5xZvcx2O4zg6EZsOMRvXXiWhtlQWvJEZU+hv6F+1HR9rCAFur0CBG2ZAWFH1fR3Pe
 MGBfdb9J4a9Ac0PQKhkE2E0zZLhkxJR8LnJdNkSC9SjzV5bjtqHI9hBk96ofWNP3frvg
 lOusjp/mQxxtO/Vcou5fi40+jGaGeBA51gZUzAidFnIgSrOm3BIp8wjYuIp3rPodI0F5
 LYGrZgiiMl9ACflONiR4aLGEWAfxCSTMlSGv70s4fELEPuKW0NLNuTLG32FoA1in921j
 jCloNRaynYBRMf3qCOimnoxt5uLXzqk1BQ4aIVn7QZev3H3TEtv7hAy5TNmKc/32dz2W
 RfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395868; x=1752000668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5OXq6RH3T9EeTCnEMSgRKkiXmejq9vEkbfGdOIB2ro=;
 b=kCwefOZHXDpFxWw9CVZIojwCxzLMhfKpzhRriC8+XA/GQ2tDRPvZJHLx+cEdFkfrad
 MeDbm9lhe8pqtBhrK4nUVDxVOuIg/a7DVwBejZq0T4kt3MX1xOQIEKmrr/Xbu64HpFGg
 KKW2VfMnDDYhplr9fxgZASiJrC+Zwt6nkFMdlJeAFdfUM5GEMf4DbnTr1I+T8AFwMns7
 LziA470Cl/p28A7o0rCzf2j14gcA+HSP0y6Obfvdm/AETh5Xe2WGkX/b10gOfu4RIFxX
 5dq8TaZGYNJECkQGxApoKhrzWr2LIfofpMgxD4UInWpsUs1SjQpEzNo3LiLc/rUb1+PW
 82vQ==
X-Gm-Message-State: AOJu0YwKPzwBC9HhurbjUGAQLJ1ccPYJEU/NxhGdW1biw3ZjzxW5bsLe
 ZON33mVo2OGyTnzU+jmKoqwJVRv47rLxaq1SePnTlCG3X40ayipwiOPbsRaQraVki11magPEx4C
 mMlx2XlAvup4jJ2DM7FHDra672n4U79KKmg==
X-Gm-Gg: ASbGncuArmzGjkDAHc/+HrzCIM9gp+o5qKI1GrmxF7KqiP8NnUBsDjaiv7B25Y8dZeS
 ut18sRGvwGL/XNa+wqZ6gXLaAlDXNTRrVkYEeFCNTauOVHKEQtMVrabKN6gV1Ur9c9iEl8R++Nk
 iVJoPvZm5Z+FasRU/CxxcjA4Zym1jgKNV2tJTgsJMS8AyLe8X1NYH0BYFl2X81r2IVlwxpWFlNv
 4s=
X-Google-Smtp-Source: AGHT+IHU60Fs4OaR1L9FbFOs1j/k7eQAII3/kZYrqTNFYuK8h5Id68qpKqhWXZ6SY4K4kHCI4PKttkx4osGySqaG/6s=
X-Received: by 2002:a05:6512:3f07:b0:553:2375:c6e8 with SMTP id
 2adb3069b0e04-556280b6554mr63595e87.1.1751395868085; Tue, 01 Jul 2025
 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250701184252.3191485-1-trini@konsulko.com>
 <20250701184252.3191485-2-trini@konsulko.com>
In-Reply-To: <20250701184252.3191485-2-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 1 Jul 2025 15:50:56 -0300
X-Gm-Features: Ac12FXzvsO6A49cZiLdB2uVSYHnbzl6MzuWiyjXizWf7FynVwnjdwgALzl6OSpg
Message-ID: <CAOMZO5A56QNX5KF1RC6_L1Ztb4uWYDkAQdkAxAi=mVrpCUQD8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: Correct dependencies on POWER_LEGACY
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, Jul 1, 2025 at 3:43=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> The POWER_LEGACY option depends on not having SPL_PMIC enabled, so add
> that here.

I think you meant DM_PMIC.

The commit log says SPL_PMIC, but the dependency is on !DM_PMIC.
