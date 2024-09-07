Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3867EB64CC
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 16:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2001F88846;
	Sat,  7 Sep 2024 18:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PV0DPBqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3AA885F4; Sat,  7 Sep 2024 18:02:04 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6433788846
 for <u-boot@lists.denx.de>; Sat,  7 Sep 2024 18:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53655b9bbcdso2671291e87.2
 for <u-boot@lists.denx.de>; Sat, 07 Sep 2024 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725724922; x=1726329722; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDWSkOuUqGLn5Mr+SyHXTu4/dxdTizUqpbAqFMheuRg=;
 b=PV0DPBqbX9W6Njc3VM1XM/kHIPN3J3t26pLO4YS2cSjSv19a8V665wj5sUzY/zQy0o
 UmxsatMm+UxZkcbnuYFdoYIQIF+Hr86fEKAnbwb4cOFKYHYEdfLb+HRTZOBfZj3SSpd7
 tOE2h2hF/k03g3mOTBXPAfjS2p+3D+fx0lFfFtdvTJbH3bBMe82S1kTSiwtFHEIg6Xjx
 W4TbyIe6SmobpNDn73JYgcrGWq2FTeChNL7cYRo3hZIfRima8gG7R38QM5tFw1E9uiq1
 CmR44tC1DpD0tvEMTbXjf3l7vWz6XuSOywh/dHLrce4RiWEoceWX7bufsJfUtM+ufeki
 pkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725724922; x=1726329722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDWSkOuUqGLn5Mr+SyHXTu4/dxdTizUqpbAqFMheuRg=;
 b=Bvu2ufGlqiQyeVT1eNH2pPd2ipuJU5ZDjmmcpx6bTcVLuXMGlX3DHfnvm8Kc+SBxLy
 gnZ8YBEBKv4So4mivjCu7yUyhvDuOs7uDz5BkEgdIzrVl/RvA2mfCs7Ue3Eo076MFE0s
 55Yf6PtG3XLuHHinuME7g0appYdViJwLkuPO8fvSjFNFvdDKEKFRC2DOqhjeBEe6s0lH
 vGdjv/XH6gkNWHF2+sqWlfaL7u/VDuzwFw0j/2GgJuFZc3XLp2UCkhlgy6BYrPjJCKlv
 jhD9lXfjIr66ereZFhdf1l8bPL/2SKep1IP9i4xSef+ZQIQDYt7hrZWlyYP8b7FqvUHt
 NtLw==
X-Gm-Message-State: AOJu0YyfxYYCgi3Cphi374GTk8s85KaFepL7He2HgLllKpx/snRLn44R
 PEJda5s2qRzHSZmNF/tUCEgOmPhR49Yv76WGUosI62Urqapu8KPlz28HDCd002on+n5+g1AgQ5y
 FZJKocAed2g5Mei/IU94qAUvz0ULTiA==
X-Google-Smtp-Source: AGHT+IE0H7VVDZVnday3M/0n6snUHakeBnyWBH/vvP292ZQEJO9IbBI44MQeWIEVXEYOuuT+Mm+kCzpvslY4oJVUSfA=
X-Received: by 2002:a05:6512:3b0a:b0:536:14a1:d660 with SMTP id
 2adb3069b0e04-536587a54b0mr3446486e87.6.1725724921145; Sat, 07 Sep 2024
 09:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240905190826.538309-1-tharvey@gateworks.com>
In-Reply-To: <20240905190826.538309-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Sep 2024 13:01:49 -0300
Message-ID: <CAOMZO5AVWRZxGqz-Ymm+O8yxduUsMeB4nrubsNLUoZ-1N==qww@mail.gmail.com>
Subject: Re: [PATCH] configs: venice: enable DM_RNG
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>
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

On Thu, Sep 5, 2024 at 4:08=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> Enable DM_RNG so that the kaslr-seed property is set in the dt allowing
> Linux KASLR.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
