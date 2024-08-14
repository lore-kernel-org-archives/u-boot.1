Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B008C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3171B88763;
	Wed, 14 Aug 2024 13:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sn4KpeAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC25B889CA; Wed, 14 Aug 2024 13:52:47 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CCA885FA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52fd0904243so688195e87.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723636365; x=1724241165; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UrWF9pM6v8fS389RA1O94zO5MyVQmeVjqarSGmmVm0=;
 b=Sn4KpeAslER3KH8wXV/xbYroJdtJhGWdhOkcUAGjpVZ5F+8/wCVrjtUAHm3m+KPxXl
 6jqf31yzfPRCXiF4hn6K5Y/6MapSKPM1i5f7p9ilNXYIxSmgGdS06q4u9eGGJTuKYklo
 1HqUUxV3iPI5btQCjo5iAPgQ8x9nJx3z3ZW5nvgFDilAhtC4/upTK/K0n8cax9oazY78
 Ur+JczGg07OMACSP75zUjZlJpozRlwp42NhD5oxtJS7rlwCbFcmBJxeJp7hHvxfeBbgy
 ZebKw9rr8ZR6RU7mMzjRzM2BaiTxmSn8n0lPi0rM2lcuzznOLqplRi/jN0X8pD7UTxs+
 aSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636365; x=1724241165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UrWF9pM6v8fS389RA1O94zO5MyVQmeVjqarSGmmVm0=;
 b=kZ1pEvUs5l2DHJ6BPdRyQ/Zz7Iyboq0Ntaz1atAB6EedZZrMsbyA5cEN/P3TMaI/LR
 pGqAJIscR7Aun96w5exxEBxe6AnFBJNaLmSlAofCbF5AEBDs+VK0Xi3V0lWNAr+29Duk
 6nHyO3XNjcdAh6u1wrILSuA0Cb3MRzrjDJA0B97WCj1tIZXD1bYgOAixIBJzN5FWsEuS
 iuphjVbWWv+tpNVESaHVcc2xF7GQaDanMZkGhdTiRLJ+ozXT5NUa6A1jTfz8mDa/yZwT
 Ob5teh7zuMA5eoPkyLrl+lh++MJRk8ZPWk44Xvt2dkLqjrniXizHLPB8qJQDLccZoRYJ
 vH9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKgR1kzTZEQKX3DlnKQJSdz4d0WA0NQxl1eTj3I+vGTO+rrcC20/65pRtptthsNTs3TTQ0QLknyOvp2b13FNsNgDDwrA==
X-Gm-Message-State: AOJu0YyJQZrG1SZTA9hyUjYz4/on9sxsn+feeE5MpZWto7ESNX2qAPJN
 BeDueCUIdowInC/Almh4VEziR9LBUPidvqiPz9IIyMk9nntfe/f82AG6g7Vaa+qUxX3cAkiKOuq
 IOwD8XvIsp9siJP7kOAVrSEZryFE=
X-Google-Smtp-Source: AGHT+IE0M+TW6684ifLD13HRBQxNNwEDiZLaq6jOIXXumQk5Jazz1G0UBH9DMIcTBEM3UCg5ZV2KcH/Xdj/dTCULW6Q=
X-Received: by 2002:a05:6512:3b99:b0:52f:cf27:69f3 with SMTP id
 2adb3069b0e04-532eda5f09amr973499e87.2.1723636364611; Wed, 14 Aug 2024
 04:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240807155343.122377-1-hs@denx.de>
 <CAOMZO5A23hR6CbLbvUR-ck111iowq=BKrMz_4PHwL4hQsmyxDQ@mail.gmail.com>
 <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
 <CAOMZO5AHFdKxNspP1fAzpGmGPABCQeAohepg55Q+YRR-PttbCw@mail.gmail.com>
 <1ce4c23b-b006-afbb-89ed-dfd844926e22@denx.de>
In-Reply-To: <1ce4c23b-b006-afbb-89ed-dfd844926e22@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Aug 2024 08:52:33 -0300
Message-ID: <CAOMZO5Cy+kykk8hgUA6vOXUFc0n=0NveEYzMJuay3=4F_cpU7A@mail.gmail.com>
Subject: Re: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
To: hs@denx.de
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
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

Hi Heiko,

On Wed, Aug 14, 2024 at 1:11=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:

> Hmm.. yes, setting a default value is a good option, so I would add
> a check, if define is not set yet?
>
> And we should simply let the name "CFG_IMX6_PWM_PER_CLK" ?

Yes, that is OK.

> If okay, I can make a v3 if you want?

Yes, please send a v3.

Thanks,

Fabio Estevam
