Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B529DC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 17:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAAE888D9;
	Fri, 24 May 2024 19:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jvHDwuOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EBE8866B; Fri, 24 May 2024 18:02:58 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9F188552
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-df481bf6680so3081407276.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716566571; x=1717171371;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKPSuvod5hQ2DcJg6vDo/+WRLmltvVCij0+Ozii7+lA=;
 b=jvHDwuOHpBpxD9eQEn5DYrKTUOSTo+e5WO3vbLc4T4Xc/SZfK2EJzSqdXPMrc+6g7x
 ZYGLqqX7Xfztcu9q4pcv13AJVU6ceU/Y90eEX8rcdV8bG75fa90LMqtWdBS2CQ7Jn5rB
 DYz2nirTVKrb9aRFZ08rTEMqVUT8tNhR41TfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716566571; x=1717171371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKPSuvod5hQ2DcJg6vDo/+WRLmltvVCij0+Ozii7+lA=;
 b=xGg0Oh4J0Dmjum98gVJgHBbpL7Ovq3hJux2pyN8yxcfQTsrUzn1SNT24SZ90WI9NKP
 UI4Ab8CmCVQiEk+a04V9t+c6Ucs4AdYYFAt+x+UMe+mbQXs8nrxZtzBw60039DyiXWbR
 3HHtJccu29+fXJRQKd/dFJMypGv4lTyVJqZBCcYMXoPM/1wBe++5J/6L8fBXnaYvnwXv
 OU7cE1xW6XZ+sKIFRCi+SKnN4rpfLFsYF/6WrITtiGKQ+EwC+1oRtLteuYuNGZYidNUm
 U5E7VfJslZaEHfI1h7R4DXPBJznxjIOGWI/6UNR1X2d32tAHG9bds8XLBkRFLITO0y9K
 8a2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7cF58vPg20UhkEUDcHr/wLrZLWWA5peGdtwoakQplUB+R0sJpeisOOEalf4KKLZ1qVLBM86eV9KvzYQjnERINuEoC1w==
X-Gm-Message-State: AOJu0YzQhKvpIrOLrDP2zKimi69Ax5/V/6oXC441vHj3Fp8v7liJSKeF
 B03rqaViAzzuPARnH/IshhPmPZ3/zWUIwnrduv9SS6JkjXdRIbBkf1W4VrBpo0W9GBxQVj4+1QJ
 kQ3YnJCSbmjyQHhBZUL/EVPeHGqDHslzQdQavlg==
X-Google-Smtp-Source: AGHT+IEOEAUpJQ1sXajzh8q1R1etV9SleVfi7GLJxQb3E02plrYA0HPYH0FuHC188HgzApYf6JDrAXBte0eQHi/eZPU=
X-Received: by 2002:a25:db4b:0:b0:dee:609c:b7bb with SMTP id
 3f1490d57ef6-df7721a7293mr2697025276.23.1716566570236; Fri, 24 May 2024
 09:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240226102520.1844450-1-dunaev@tecon.ru>
In-Reply-To: <20240226102520.1844450-1-dunaev@tecon.ru>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 24 May 2024 21:32:38 +0530
Message-ID: <CAMty3ZDyQV9jyNmzjr7tHYu_8q3MpBec64cRK0myei03pVmPjA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Add Puya Semiconductor chips description
To: Dmitry Dunaev <dunaev@tecon.ru>
Cc: dunaich@mail.ru, Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bruce Suen <bruce_suen@163.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 Nishanth Menon <nm@ti.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ssunk <ssunkkan@gmail.com>, 
 Jim Liu <jim.t90615@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 May 2024 19:00:29 +0200
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

On Mon, Feb 26, 2024 at 3:56=E2=80=AFPM Dmitry Dunaev <dunaev@tecon.ru> wro=
te:
>
> Added support for the Puya Semiconductor chips.
>
> The datasheet can be found here:
> https://www.puyasemi.com/h_xilie715.html
>
> Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
