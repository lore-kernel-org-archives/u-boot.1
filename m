Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA283D711BC
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615798932B;
	Wed, 20 Nov 2024 17:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g3dOINDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D7488EEA; Wed, 20 Nov 2024 17:03:55 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE048826E
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724a96f188cso2533423b3a.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732118631; x=1732723431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eNzAyrPfr8UAdbSVEVWwi2HHcJYLZNYXrJLqPK0InnU=;
 b=g3dOINDQ4gwU8YfXKC+M4V3XygSUBwNGkC/g8/veRm/7hweVLZGdt2LSXPgCeyOcMY
 4X1M/8o09qQRNSU2/sPllsWoAJysUcstEgnGSLvNzy6XTpV12Bo0CFz+6gzst/Mumv6F
 9uBb9b17DRt18IPGqNSUaxg+9a9Pk5yyFggak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732118631; x=1732723431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eNzAyrPfr8UAdbSVEVWwi2HHcJYLZNYXrJLqPK0InnU=;
 b=QLXJuFlHP38cUp54xPCXDxF4BY924cGCku9PcWanQ5FvH7tn/m5P975HB5fQFYLj1y
 e33rwD4sjWmd33ll13pZA8ktvca1nkgkLqIDzX4UFPbNsQKFjb194QIPlXgR4J7guidM
 zluXBcqfzztTbRvP2oUq76ZBrN01wPVH/k+NiWCoK9Ik6R6ur2lJwLknM94UR48yYY1R
 ktV4EP2mL8uxUTAjtYDjNh/0wefs1yhl9aCheD5MNxGJOSjC9y1p9J7ELHtkwuB2Gcn+
 b1RuY/RQ6IhM/02dzQ8KIUBAbVBD2alaokEO5I1c9kBFqTZVgEyB19AQMrzCirE37Z6+
 JVcQ==
X-Gm-Message-State: AOJu0YyHQbd6h4VdXET3Fu24ZXRPmw6V9GqSCZ3XzYWX5OiD/zMIj9X/
 7CLdnW5kuRoKXAE1q38w5e+3ZtJ4z+5OMKjBn6sFMQb9TKWj/UP49U6MAh9xWM/5jDDdBf3Hzfw
 kX4cFCZOQJUouADlSw1P2CSWqO+sIlAvBcHfV
X-Google-Smtp-Source: AGHT+IHiwB4tO/KWLO+ZsPWi/vCvkZCq4mOW1i0JZh3uD3uXQ4POb4BAmmoJ3Gv8fGwuve8VdAPMZdgj/I+7IaG1Bg4=
X-Received: by 2002:a05:6a00:4f8b:b0:71e:4a51:2007 with SMTP id
 d2e1a72fcca58-724becd5917mr3859843b3a.4.1732118629384; Wed, 20 Nov 2024
 08:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20241120153554.860710-1-sjg@chromium.org>
 <3ff334f3-b8e3-4359-9c02-a35e9a66c432@linaro.org>
In-Reply-To: <3ff334f3-b8e3-4359-9c02-a35e9a66c432@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 09:03:33 -0700
Message-ID: <CAFLszTgi5uoAYgMNO_72XjU1zrTf=eAJF21a7rZpwQ=Ht+K9mw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] serial: Support a disabled serial port
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rasmus Villemoes <ravi@prevas.dk>, Robert Marko <robert.marko@sartura.hr>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Caleb,

On Wed, 20 Nov 2024 at 08:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 20/11/2024 16:35, Simon Glass wrote:
> > This series provides a way to tell a serial UART that it can't actually
> > work, at runtime. The main motivation is to deal with a coreboot feature
> > where it does not provide UART details in the sysinfo structure unless
> > the UART is also enabled in coreboot.
>
> Why is the UART driver probed if coreboot doesn't provide the necessary
> info for it?

U-Boot doesn't do well without some sort of serial device. That could
perhaps be improved. But the point here is that we need a single
U-Boot build which can start from coreboot, regardless of what
coreboot decides to do.

>
> Couldn't you disable CONFIG_REQUIRE_SERIAL_CONSOLE and skip probing it?

No, because I want it to work if the serial info is available.

[..]

Regards,
SImon
