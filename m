Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6556C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 09:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4BD88418;
	Fri, 26 Jul 2024 11:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZUydB9GK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1223088365; Fri, 26 Jul 2024 11:34:36 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEBF884BE
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 11:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef23d04541so12673091fa.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721986473; x=1722591273;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JaGOyiLHgJtAHFK3kovevdtKv4Gg+B3kKsfR9JDCsj0=;
 b=ZUydB9GKzbqo0wKP6EN1FUh6xhRpR6N8UiR5LrMBPp1SOabQSZ/ABLs0yemtqQQ72z
 82SMwbrF42wjDkdIU9wRDoEh5h7BL+g/mje3BLbOJV6olhuNQaW+AYeLMYdQe3Ek24AB
 axGVaUFDSUVko6tGI1OiSYHd+Axk9iE1+dbugkraId7neQO2dP0aVTB67YT4TWAsd1Ff
 ijR0eAElar3bRD6RsPssWyLV56joQDg9Uk1MURyHBNpgT6rBsifUpEwvQlmYQrmRKRb5
 f4xymBt4e9cvYCCPZAYJ/4NlWsuVc+cTg2sAKQOx5pHN1Ry2Q0I6KVPLIZ1o5GE6wTyU
 FZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721986473; x=1722591273;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaGOyiLHgJtAHFK3kovevdtKv4Gg+B3kKsfR9JDCsj0=;
 b=HZCk1HP/XMeCQ74M4VHKwXXIhELDocYD7Bf4jCI+Cf0zBSvW6antPfTcUCvNpwB8Tq
 1rP+vkkBqklzSd3LroxtM1xtN5tKoNm03903wGSLn3Ihb8AZ0vi8OfBVJPY+4S4dP8ic
 s2PP/mZdPLsjzqsBXHZxq/3QgNN65xwaYtYD5GXZW2ResPVyLrHI/I33CkSi8eyf0XmK
 C8qHWGexMfdEBFlsQS100mBTwcCIMsCthnYizDPBK/rlTYV0uBweaOpw+N86ZJD8aYwK
 J3nSDoesYZbR7DO/ZN4CGhxMBOKV9dz51dzvsK3vUeSHYpXKRNeCADitiJDu2q8oK+MS
 9AjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPmmxTtgX8KY5m4Xc80uspyJHuHPRWlAx8J98Zp4MUQTkihBs9KuDGKWxirPkhKuSoVseUtOgLmJcP4xyqX/hLck+ekg==
X-Gm-Message-State: AOJu0Ywh8Xk3eVYX7bx7PFOqRV+TArlOBM56yEP5+gwOMF22aDoFR7S+
 rzXFkfZVHw9d7rYfnJmUDgeBig59BQt/lhJ9kor9r6riG/9Y3OP0AbK84UHhLa+iUeoCuj7OB33
 L
X-Google-Smtp-Source: AGHT+IGFk33iBwN6KF+qhS81b/28Ymi+cE9pU7tRrHAU8nrM56I6BfeeLbnPhUb842xuJ2wbfYi+0Q==
X-Received: by 2002:a2e:3a0f:0:b0:2ef:22a5:9472 with SMTP id
 38308e7fff4ca-2f045dfad31mr7642341fa.38.1721986472449; 
 Fri, 26 Jul 2024 02:34:32 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b05sm4516333f8f.94.2024.07.26.02.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 02:34:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/7] usb: gadget: atmel: Code refactor and
 DM_USB_GADGET support
In-Reply-To: <24112707-c09b-4600-9e7a-a3d071e87952@denx.de>
References: <20240725153204.358925-1-admin@hifiphile.com>
 <0e0a053a-56b8-470e-98bd-80e61417e5df@denx.de>
 <CA+GyqeZURHRsM3MZcUzY3+tyu0SeBM7aPbYd48JmSxqVuuZw=w@mail.gmail.com>
 <24112707-c09b-4600-9e7a-a3d071e87952@denx.de>
Date: Fri, 26 Jul 2024 11:34:31 +0200
Message-ID: <87frrw4hug.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi,

On jeu., juil. 25, 2024 at 20:57, Marek Vasut <marex@denx.de> wrote:

> On 7/25/24 8:48 PM, Zixun LI wrote:
>> On Thu, Jul 25, 2024 at 8:24=E2=80=AFPM Marek Vasut <marex@denx.de> wrot=
e:
>>>
>>> On 7/25/24 5:31 PM, Zixun LI wrote:
>>>> Changes in v4:
>>>> - Release clocks if probe failed
>>>> - Add missing endpoint data free
>>>> - Addressed comments
>>>
>>> Please collect any AB/RB/TB tags that were provided in v3 too.
>>
>> Sorry didn't know that, should I spin a v5 ?
>
> No worries, wait a few days for more feedback (if any), and then collect
> them for V5 and send V5.

Indeed, it's important to collect the tags to make sure that the
reviewers get credit for their time reviewing.

Zixun, make sure to collect them for all future contributions.

Fortunately, b4 (https://b4.docs.kernel.org/en/latest/index.html) can
collect the tags:

$ b4 shazam -s -l --check 20240725153204.358925-1-admin@hifiphile.com

[...]

  =E2=9C=93 [PATCH v4 1/7] usb: gadget: atmel: Sort includes
    + Reviewed-by: Marek Vasut <marex@denx.de> (=E2=9C=93 DKIM/denx.de)
    + Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> (=E2=9C=
=93 DKIM/baylibre-com.20230601.gappssmtp.com)
    + Link: https://lore.kernel.org/r/20240725153204.358925-2-admin@hifiphi=
le.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
    =E2=97=8F checkpatch.pl: passed all checks

So, for this series, 2 cases can happen:

1. No other review comments are found. A v5 won't be required.
   I will collect the tags with b4 when applying to the u-boot-dfu tree

2. New review comments require the series to be modified. A v5 is
   required. In that case, make sure to collect all tags yourself.

Please wait a few days for others to get time to chime in this patch
series.

Thank you for your contribution !

Mattijs
