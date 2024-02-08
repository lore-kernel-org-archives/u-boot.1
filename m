Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FBC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 21:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738CD87CCF;
	Thu,  8 Feb 2024 22:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBE0v3xK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2506287B85; Thu,  8 Feb 2024 22:18:00 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1283187CCF
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 22:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e06ba6d01fso56021b3a.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 13:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707427076; x=1708031876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/J/WI4uSaz5CObmOn/91rG2BgGhpnMqtZUdLG+ZiHY=;
 b=QBE0v3xKC4SzwxnU+2NL3b3lJ3ZzY/1jwmmS+cJG8ipuymUmNo60M7+LS7RPxUYpqy
 +L6bX5QKrnEf5THiyT+mFowhtIbI3hE/RE/cdMCE3+RCubwf75OqVXe5QVpBQ5CcRNgi
 YCAO0CA+qmAHQ/2MMYJ9ITu89mWO6UwNjzFDobUdgHazP8IvMR+xg8+0kwR1XA1SHnmI
 44p8hVLQNe1krZmIQAdNPaL3m2raYHGGMnqqgVTc7Xfk8kA2oOaZWHzF83DlHWwZYAh2
 gSfL5hmFG9mWTkmTZaWeMgKCtYp/JnbUcAzK07VrjJom3MypKVT5HQUjcjARnO1TdXa1
 lDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427076; x=1708031876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/J/WI4uSaz5CObmOn/91rG2BgGhpnMqtZUdLG+ZiHY=;
 b=ZhnASV/hdehXOCtdVgmPxZ1JCk+jhLmypTWDAqZJYA+Eu/IoWFeOejmmDoiO4kilXS
 6cgn10i0H568B28FraqTeJQD/yvTAXAvZnxPfDzIdkOZyqabZpBCBARJRevVDgaJ6IkY
 OmhzH+4bVkgWG+v6Gq4Cx8BUg0c9oXUhKM3IckdOgOZkY7GEKLB+hjvXmhP76SE8Kooa
 jkhKUE2bozwGfAOVBGBewmVf2LZMa+SYuoSFtbab5wko9mQOjkOEx32FaoptUe0IEGyo
 2zjBamiGE0pPaegEeXSq2lXgh+M7KYubhQrmeL29+fj0D/Uz1slyZ7f/pR2MOtW9QQKl
 py/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9EOmqqvEGg+urRYxmagErnf8motAOqMb4ESPogTPB9H7Kb01ovAN9nwTx3uwkCv/mmttQjBwFo5hwDfMDAZk2NrYjZA==
X-Gm-Message-State: AOJu0YyNdUTw5EQDMGdUcTfA3BDtBDGYzRtZgPP/ua+0SKSzKr8Ri6mc
 dDwWgPdQl0uySk+rbXhuk2VgzugWxYcaAi95ezvaXo22rOl39ij59gl6yiPSzNois1/mx21IQC4
 XEmmYKuIc0SuCzuLozNRft5y1k+Y=
X-Google-Smtp-Source: AGHT+IF2twAVbhVNcfLeHnqj5VIcy+0udhtUi6i46uPLMResiy1v7ylGWzo7bGhpoyXuRXyq8QCR/sWBMHzljPvRAfk=
X-Received: by 2002:a05:6a00:9291:b0:6e0:7e60:6b84 with SMTP id
 jw17-20020a056a00929100b006e07e606b84mr475235pfb.3.1707427076231; Thu, 08 Feb
 2024 13:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
 <CAOMZO5BJRDdD5a7JZ+ws7aqz0p0nmK_vXiq33=V3s5X_4m8+-Q@mail.gmail.com>
 <CAJFTR8Rn=y-vHfCktUjNjk8GqRgRaU2GJY0Qnfg6GmfEKd7pOg@mail.gmail.com>
 <b670f1a1-b3b7-46cb-8abb-3270e4457bf0@benettiengineering.com>
In-Reply-To: <b670f1a1-b3b7-46cb-8abb-3270e4457bf0@benettiengineering.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 18:17:44 -0300
Message-ID: <CAOMZO5D-YggbA5A=JhT2VBTNsdBN=EaZEK2EdLjtLq+SqfzT+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: Jesse T <mr.bossman075@gmail.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Giulio,

On Wed, Jan 31, 2024 at 10:06=E2=80=AFAM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:

> The problem is that mmu_set_region_dcache_behaviour() is not implemented
> for armv7m and mxsfb.c requires it when DCache is enabled, that's why
> I've disabled.
>
> So we can keep it as is or implement armv7m complete
> mmu_set_region_dcache_behaviour()

Ok, thanks for the clarification.
