Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9BFD59F52
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 16:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FBB8900E;
	Wed,  6 Nov 2024 17:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9Qh9xTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 739BC88F92; Wed,  6 Nov 2024 17:10:36 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6385589020
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 17:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9eb68e0bd1so259190566b.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730909433; x=1731514233; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Hj2DlYDz3/TnNaGZcvHVG/u4NpWJ1Cs2HeE9Re98qw=;
 b=b9Qh9xTz/OlBY9pDAZsLQWEhINsI5pXx2Eg2e6/ZiW30NFsM9HcO6Ta/60LFJbAhPk
 FppKGYV2wmAOAEeNRQ/0WVox0MoCa5jf9kEKaKBvseueGSd9f3+WUmJl8N85KAq1guoB
 f7VbT1DGlFx1yXk+wQn4wE7A4es8WXmAKC2UrBak6XPt0rCERXBrCMtQOJMeKZji6Up4
 mTDN2zEGsj/ghpq5KwqxMqLqJl4XRLro2scUiRWYWpCvKjZFAGfHhNhGt/9HA18Y5+Qf
 kwhAAJmez4toOJHbsTceZYgBbBbiodsQO5nwOg/gpQW6ra2+Gp4TCKdzC/x/t8nw2fmO
 oXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730909433; x=1731514233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Hj2DlYDz3/TnNaGZcvHVG/u4NpWJ1Cs2HeE9Re98qw=;
 b=RNmBE2qYw6a13qOuwSZsNc7LAVfaj5jfHROH+qndVOIRxiec3cTIvwwRZGuoI1GyQD
 7g1VmzYlMyHvnc+XZzHcwKnHxhsqzM1/4ncZrR3a/xHO6cLAqX+kvH/UaGR6I0U296y8
 vls8m8XowQZTtX+Km/C/n4ZXMWV/wg9WFu/pR3DYXxbN/Ba7qONN7eazeY7iX8MjrWSP
 1YGfvk+/S9zphZch8ithrIQhAkbYe6EIXq2aeh5YcklQsHa0llBNOdB6ZhN63QTIYoQx
 Hg+8EnCFMIFmSMTLM9Bl60BzRBxDXf7fUXN1NQKTW5NnvAqbQQS+5W4HjpRZxPGQsWWh
 jGSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcaaK/mkwmOpov6gUrF7F4hEv3yNxKdH6pIRUuXttYQP1ucY9RA4MMed6umUou+6SG/0MYeKU=@lists.denx.de
X-Gm-Message-State: AOJu0YxlnDzIIdh8Et2gGb6Mo65WVUapCzDNlfubhqlq5wgYazn0n6VC
 hn1yNuVG19XqRi9zqyUXqFM6CrrHQ3y75wz+xSTO3+SpE8pvU/1pEUN6co359yMeuRjYTaDlyBH
 +HCHPlhKJ8ODsiykZuJXZDx/p5rN2FjQI
X-Google-Smtp-Source: AGHT+IF/YPe5BlrxYMou6E/k5LXKmvd6S9Lh2NbTYJvgOgAH/KnhIu7ffwfSwU7x1dYJuWn8gZGqm3Wq6qDBJOVDDC8=
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id
 a640c23a62f3a-a9e654fb423mr2020706866b.31.1730909432567; Wed, 06 Nov 2024
 08:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20241101103501.21432-1-bigunclemax@gmail.com>
 <20241101103501.21432-3-bigunclemax@gmail.com>
 <mlcweqrj56o53wluowoz7n6fdn4xofx5gtmh6d2ufkpqq7xq34@7qfgnsw6j4ev>
 <790533ea-92c5-4793-ab32-08b07f40b9d5@kwiboo.se>
In-Reply-To: <790533ea-92c5-4793-ab32-08b07f40b9d5@kwiboo.se>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Wed, 6 Nov 2024 19:10:21 +0300
Message-ID: <CALHCpMhdYFDhUe-rn64_fSu_B++WTUC+tGWGu3c0QWMbJkFsvw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] usb: tcpm: fusb302: add support for set_vbus()
 callback.
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Wang Jie <dave.wang@rock-chips.com>,
 u-boot@lists.denx.de
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

Hi, Sebastian, Jonas

Thanks for your suggestions.
I'll fix it in v2.

=D0=B2=D1=81, 3 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 02:22=
, Jonas Karlman <jonas@kwiboo.se>:
> >> +            chip->vbus_on =3D on;
>
> vbus_on could probably be dropped, fixed and gpio regulators is
> currently already reference counted. Or is the set_vbus ops not called
> evenly and current state needs to be known?

Yep, vbus_on could be dropped. It is only necessary to display dev_dbg mess=
ages,
which are similar to Linux fusb302_log.

So, do you suggest removing this?

Best wishes,
Maksim
