Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9672C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 00:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605E480F47;
	Fri, 31 Jan 2025 01:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NeJfi4Cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E6080F50; Fri, 31 Jan 2025 01:58:38 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F0480F44
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-543d8badc30so1506015e87.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738285115; x=1738889915; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1yJNq9Mq+F0ti0h/U9pnbjDe29eEOYPCJqh0TOu5jo=;
 b=NeJfi4CcCKcxGOZ5Ykv4L+zivQHI8K2DltH/fba0udn18sV2o17RdJ7mYB0Vr82P2D
 ohNiKnzNek65fgrV4BK90Ij3R4P3TjU7BO6CEa3ln/ONp7NNJf3PcCjlX2CoGLZ/SDOo
 OJoAN7TU2VJslUjIXt8zh0zgk86m5FH7HCCdSP9LY5hJDzOH6o9jY0pvEa0wkRCKIHEl
 ZXxylEW1kGqD+DscGYZEDfyUzrjtpBb48VrPgADsABjWGd674nzG2n1u8ZqZTN6h57jF
 Cng11ltOykC15/o0k/ezFm8EnoyhABJAW63yxPuf6yM1g6VF2kdyq1i/Ap3O+5iUBXuN
 Lx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738285115; x=1738889915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1yJNq9Mq+F0ti0h/U9pnbjDe29eEOYPCJqh0TOu5jo=;
 b=borca5XOdS+f9RWKouS5gLpsQTD3sd43ZlR8oMaESdRte+hvc4d9ycZBQ3Q3ejYxBC
 5TXyDN7GqEyifUCQnBiK/uVd5QV4RCPE+Ox7KR40mZR+MhJcyeL0Qs9wtnd/svRo/i+i
 g7zsKYSPUrl0lhFCjCUYBT+kR56DDF8oU8MPBgdgBBqCBSRnZI7NnSd6PKrlh1ynkDAH
 Gv29EKiRLYdO64qntaa4pXEd76uUxIImcUUyFtzg1hyxVsZ1y3aY5zphT51w/mAFxMaI
 wNP0AaRqv+Jw9QsqBlti0lmprvG2sJBJhyqQUEGApFU0v569UXCSKdgjhcRbbtg+mxgf
 m7/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPVbycR8vPzKVhAS0Ha9yS2McGNbz/u3HJjGyI/KwbYou7U3usvsyAfUra13v4cimcVimXX9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwELGoeqd1YYPD2HkmJc+KwE9yUhgOZC3iXdGw+q1N49TdhY6Of
 kWH71blRJGW3FfzgGOfL4EtgLujzm4vW8AJ6S1CtyMEImefRm/ojGX4ZfNWNTADCYJ1gKu1pW9u
 QsvPE42evRpj5YCdy/6pKktJliBs=
X-Gm-Gg: ASbGncui1SHUXy4OIOK7azGQHJEPvPT/+1lEhvE/LED+RLZ/R46MNogvzgFya+SIGZD
 ba2F/qPTyXwRNi6lbWyP1TryOYes0MZc18hiWstiyJmLHvWuoSR9VVpfIQDxtkLJRUKKid4Nfoc
 7ZBm3gWk5VhNo0BuONhB6ujYtzMrGS
X-Google-Smtp-Source: AGHT+IFZX4cI3eRQ30Zyf6I1JvCCvNaxhRh4tv8AjMdIhmV5/DjhnlQbP4BdySKi50FgEKmIi87vabiwwTJfFWUNupE=
X-Received: by 2002:a05:6512:138a:b0:540:75d3:95a4 with SMTP id
 2adb3069b0e04-543e4be9422mr3236386e87.17.1738285114950; Thu, 30 Jan 2025
 16:58:34 -0800 (PST)
MIME-Version: 1.0
References: <tencent_42B13D5D83646C05C108407F980293053E08@qq.com>
In-Reply-To: <tencent_42B13D5D83646C05C108407F980293053E08@qq.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Jan 2025 21:58:23 -0300
X-Gm-Features: AWEUYZnwOC48Ts0xEcl5PVEaTlfVejNnx4835Jp0C9llR9n6m_-F-A9dcgIwE4g
Message-ID: <CAOMZO5DQCyLa7bpxUkJy7Tk0tqp1dnXLApxD1X15jUG715yiiA@mail.gmail.com>
Subject: Re: [PATCH v2] siemens: common: Make DDR_SI_TEST depend on
 TARGET_CAPRICORN
To: 1425075683@qq.com
Cc: Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Thu, Jan 30, 2025 at 9:53=E2=80=AFPM <1425075683@qq.com> wrote:
>
> From: Liya Huang <1425075683@qq.com>
>
> The DDR_SI_TEST config option is only relevant to the i.MX8 Capricorn
> board.
> Make DDR_SI_TEST depend on DDR_SI_TEST so that it does not show up
> on other targets.
>
> Signed-off-by: Liya Huang <1425075683@qq.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
