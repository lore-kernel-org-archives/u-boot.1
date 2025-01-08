Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3315E77198
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 01:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DA18036B;
	Wed,  8 Jan 2025 02:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XpvcYQhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94A1803DC; Wed,  8 Jan 2025 02:19:21 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B868007D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 02:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so16445434e87.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 17:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736299159; x=1736903959; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpaK7o7eCl6uk82og3xUOcW5AHhrgAPDb15+MSmrbI8=;
 b=XpvcYQhyXPsBXDpEkWbjhkWjM3yKocFA4IL6l4A59zud11Gzoi+Cw8o6EHyb2s/JgR
 uQUOVyod0vTooNaFvIbT7N6tTGHoQ15Q9VLBDQpDgLNmsl1CHn1Zxr6NEIhLQHFZMP86
 mqCEwl0KC/+E9pF4+avNJ1G/owtbJi6+OOlmbejIAQHOOlzX64Skm8EwRoMbWQSFB1bC
 WrF8ezmt7A/DhVOfmsFuqENHSeq0+ymjm/V0kGGtogX7RFavKLCboW7OgK9xvaaDDZhN
 tc9MZ3L+XUld66romzbdU/YLlIthR+cmLVbr6A2dYGKtilUXV+cIZDuTKkKQAIQlOu7d
 JwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736299159; x=1736903959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpaK7o7eCl6uk82og3xUOcW5AHhrgAPDb15+MSmrbI8=;
 b=douDDKW1L+VKgkkrFik3Hn6C3Jv+aORGp9cSzrrHPOBgXp3mDOmhLmjn8vRiQYvktB
 L50Y9pK9N9IQrUqqg7DRCRudzFxtD2E3xovQ45yv0o8/4dzEINM1cd1KNUYY4XuhrRVt
 v6CrU0UC0ZF4AX0KxFcyQbck2IK+Wnkls7RVahY7XE0mX4RX93Rpzm0MbRBWSPoVLf9d
 D8C9WU/uHIwm0eL6+cKrC64zJ77IljHYd5oAsAAJesMMirHI8hylvP+1Ei+7RTG1JHpH
 tKBm3PqClD27O2lJ3PgICFOH/sdutvc3ffE0khyJmj8zXZzOUiVK/4V54l8AjhBOAdoE
 PYQA==
X-Gm-Message-State: AOJu0YywpvFz/AQ9i7ClqC1p1jbvnr9I7W2g2ijFkdlSbvKPwO3CaceS
 N/LtAQ27x0AagB0W9Qgt9kvOIW1EeAX8/bsWaPG8/9WDBv4ZFVvV93aCArgMNGyIsmaBoAEix6o
 5fwUyZooA00h5TvQx/wlWjMSKX9c=
X-Gm-Gg: ASbGncv5zoUGXOFFtlxh8y9Tcd7xdWUTP6hnH2aQQetE308Djhpr4fyT8Yl3eoRZWFb
 UKUtkuhcbSp2HWmqqNPUcBiRJsJdKuPk98XaXDno/XoLMtjP9UUjgvjFEf4CslCPleFnpYA==
X-Google-Smtp-Source: AGHT+IEmO0u2q/CXqbo54qmR7HtGbDZ+0gQJ3L2XTOyx95DC9PkUEUIp7CQryEgnE2SA7ca50WiPIC3XW06/6zgo/F8=
X-Received: by 2002:a05:6512:1114:b0:53e:39e6:a1c2 with SMTP id
 2adb3069b0e04-54284816e26mr173754e87.44.1736299158862; Tue, 07 Jan 2025
 17:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20250107225919.196131-1-marex@denx.de>
In-Reply-To: <20250107225919.196131-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Jan 2025 22:19:06 -0300
X-Gm-Features: AbW1kvaDW2G4pQR2_bvu-sjCUyuIvWnyx7YCPz4TWkExy3JS5BJa3arGx2dAdB8
Message-ID: <CAOMZO5CzsOpKHpuron5JwbHqHMJLT5LRPutJfWk5amzXdYpMqA@mail.gmail.com>
Subject: Re: [PATCH] usb: ehci-mx6: Add i.MX95 support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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

On Tue, Jan 7, 2025 at 7:59=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> i.MX95 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6

s/ehci-mx6/ehci-mx7

Reviewed-by: Fabio Estevam <festevam@gmail.com>
