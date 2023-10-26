Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9453BC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCC4875CC;
	Thu, 26 Oct 2023 16:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DeJCV+h8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED7387602; Thu, 26 Oct 2023 16:45:30 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6CE386F87
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ba8eb7e581so218530b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698331526; x=1698936326; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMzpLb7aSCNDXCiZPJf6vcpFQWGpXwPkJhzZgA8B8lc=;
 b=DeJCV+h84HVqov/jxmeHgpLhAK8Bn292vFso8kzY6z4THNQR9nI17ooNWslYpDYvMy
 2sirUHtExSHWihllcU1MOg3jN6WjEpskea2cXeb/rLKYUw1HLb1ADBsaJd8LfAT7NVKc
 o/dUzHTa6CbfpySKPdMZgV2awbX8vPFeM+wwXebU5NfP3cG+IaO3+t9cVl+3nm/Xi0kK
 QKT5yeCCwn8+Mdc8Lgg5hWruT2NxzNopWj5Fjona/LiQ/68sU4aSCrLl2kkqqPksCAHZ
 0MUhPmLitVhCnN5hrbt4+4kW9bFi+DClnhnpB/TF7OOxfBQgJ+jaFlA/gOHx9uMJytLN
 EXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698331526; x=1698936326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMzpLb7aSCNDXCiZPJf6vcpFQWGpXwPkJhzZgA8B8lc=;
 b=o8cu5GWj5C6W9TrjKqVwycX+p0SqCWzEVJ6Qx2qWxQhBqXNn63L/yTEL6usFGS1gGT
 8Q9kHM1jJ2d73sGhuuoASpK38afofb0reF5lDZLAj0htuxpKCC1pvAtbpqx8rJK1B93J
 jBrZukK0QRS/ilfuHx+8H6AXZcRLSQK2iqhk7jQlGAb1eqWOAwWlO1OHImrcx6dbWc5d
 4ouNqDFZLesQS/R8GQsgnrMPK/nOM0ohnljNJUvlDrmwxzgWKWLTI8yAO8LBc+10fNu3
 Ar3rfAVg2ovd/mj9uniLy+vNcDVpWVxsj4n8L3NiN17PgwzfXe420gHR8kjSc7p6Crlo
 kjRw==
X-Gm-Message-State: AOJu0Ywy3N82mbz/gQ1BAoNz0nqn7ubbH8tIR8aML68rUxp7DfZyiMEj
 70cwGXn112XMwX5j7xdEF6M9KDBrpIK7CGhp8tE=
X-Google-Smtp-Source: AGHT+IHrRJEz0ElRvXLLWdlwkjkFTsPM4LRl5yFK3o4boFQOG0q1TQxq5BoHSs9bnJFBVRaiGgRgk3PPhS6XEm6jco8=
X-Received: by 2002:a05:6a20:42a8:b0:163:d382:ba84 with SMTP id
 o40-20020a056a2042a800b00163d382ba84mr22322767pzj.5.1698331525952; Thu, 26
 Oct 2023 07:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231023152629.2727547-1-hugo@hugovil.com>
 <CAOMZO5DyK+PDgk=2cOsQogVb+vCP=WhyR3MK8isYtm_KoAbESQ@mail.gmail.com>
 <20231026103805.81d1236a9ce15eeb9cbd43d4@hugovil.com>
In-Reply-To: <20231026103805.81d1236a9ce15eeb9cbd43d4@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:45:14 -0300
Message-ID: <CAOMZO5DEEwTq4J3hkAjU83Kwb3qDWbUvEOk0yDz_KuHUV+q8gQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove non-working address from MAINTAINERS
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
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

Hi Hugo,

On Thu, Oct 26, 2023 at 11:38=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:

> Hi Fabio,
> since the change concerns two different boards, that is why I didn't
> indicate it. If required, I could send it as two separate patches.

Ok, got it. Let's keep it as is then.

Thanks
