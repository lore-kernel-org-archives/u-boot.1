Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8710DC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A8E830C0;
	Thu, 22 May 2025 15:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2LFNaTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4DF830C8; Thu, 22 May 2025 15:07:07 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDB98006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54b09cb06b0so9433871e87.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919224; x=1748524024; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmSuFVlapvbLF5DQEWdLPlyWuT+SUtlwL0XF62mDjaM=;
 b=Q2LFNaTf007vdTnw1QJMITNM2mz0qI9WQu5iQpzy9LRqijALdJqSLTEgzqySLv5Koa
 eRd5nO9lCqJ8Aagn0ExWi6metHXszZhsLVbPmtSiqE3AzkYYfiM1S57yw8+WjwEhjjKn
 hNU/u3eBUpOoU0ELRPBJX66imdsSobvNJXrc0BwRJ2ZMTXJJW2cGXqvCYR8kzcushEhc
 /PfcQeL89iffDrB54mN60TpEbTZyrvMUhmIiZ0DXilHe1arRDw96mx4gyWKVY3zfzF8B
 t9SHgZKebKL4FjPYeM9hA0k7cmxYZU/8l3acm5EROpsnYQreeU3OaTGHhk1JsBi7tzwL
 MDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919224; x=1748524024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmSuFVlapvbLF5DQEWdLPlyWuT+SUtlwL0XF62mDjaM=;
 b=F+5vAGqw7RG7zilQhYwycD4n6ys/Oe03FyL2H+S/5JupwE0yQJIkO01hFW3Tq6xpqE
 qJC5vQaxRRdeTbRtBFeKz7i2uJ9TCtsvGoLcvYvIE7/3QOOee3wLyGhlYU0jX8EZC3Hg
 Kl9QK6UsjZBxW4vLnsohw+ZubHwajDPXHm9ziPPx21ZVdP5vVfaTvGYAEEj8ra6cUxEj
 f1bVoMg0N0p/xTYB6ZG3kYAjRKMFFrB9LdH9zZ2hdjADtaC9d0Mt1myHVo0gydgn+UkB
 JRQpsZ2CRQRsYuvJxq7pAdQfmvbEaZW3YwUFcTPvyE+MRAkj+eb1+y9SiMA3ZiEWlsBo
 DO6Q==
X-Gm-Message-State: AOJu0YznjVWW7NuQ0ydwV3BfL4zkHpafemUyHnUCTbK22lQJIBB0xaIE
 Kxvh+KckSjjynWKerNIhhUQ+VmVIDskbIREPlN7ImM/9f4hsyaZA+er4twv+vtC1qZqqjfP20/i
 EPl9Hpky3wf6N/FnrNJuLAQwf4d/HHxs=
X-Gm-Gg: ASbGncvBal2gLJ336ggSmC8N2bRTDIZrRnp7RjmjIqvFT8C7qLUt+awBb9zy1eePcam
 WbBiN9uMvoMgnP58ELFYiqj0qSFlrdcmJnOXJtbZ1KY52j0T77uVaDwi4yDz9d7cVRVpLJn7Fre
 n4kztUrt46wM78wU24Q+5N47+nbDPmjl+f/a4ISsc6Jx2eUtqACCtg23rCSAekHFw=
X-Google-Smtp-Source: AGHT+IFEByzIkx/qD9cVsC2oxvjlNDnYOC+0SQHm04+d0K3DuYjIjKqpEszsZCcYSqwn7fjRBlIzl3WeExAdHHK9kXg=
X-Received: by 2002:a05:6512:2616:b0:549:6bad:3977 with SMTP id
 2adb3069b0e04-550e71d2b19mr7856869e87.31.1747919224006; Thu, 22 May 2025
 06:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250520090241.926812-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250520090241.926812-1-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 May 2025 10:06:52 -0300
X-Gm-Features: AX0GCFtOA-q2zFMSIEGUwvMnIE2pkWw4WzuaLVNKGZ2VbrlBqb1GU3swcqakU9s
Message-ID: <CAOMZO5AgM=jdw2zCDY1s-E1ABxTjazjrzG=PO=8yncJ1oOZ9UA@mail.gmail.com>
Subject: Re: [PATCH] board: freescale: imx8mn_evk: let clock system enable
 UART clock
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
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

On Tue, May 20, 2025 at 6:02=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> Now that the UART driver can enable the required clocks, remove
> the hard-coded clock enable.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied, thanks.
