Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2A7C55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 12:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 949B680E4E;
	Sat,  1 Aug 2026 12:41:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1b-kASuq9fOC; Sat,  1 Aug 2026 12:41:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0653080E18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785588090;
	bh=6w+/6h2uw48brrMoSByPA+OBay0oBmoukSlEzpbPbMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H26T6mqsE8gBhK4moXtDr+pmo7YTVSer58oF2ydRye9BeMgTXHP1nDY0mXOlh1xiv
	 qit+kcdQn1bfW5uNS4UrGrY+Zm0YOVhhFEZh/zc5xIdhUUwuI9Lhf15mC+UVAoC0gB
	 1QOVMa8YD6MwSAvyGQhXh6BG6aqJr8yiqF5pZFFU4dZ7HlAhcs72szHYE/nZyLCcI5
	 ma13I8LNSbNJO0zqXzwgOvCi5zOUnYCtBKPlhLytTHINdQzJQ/rtAROZhqAO9QqAcW
	 8kIAMze4OkivsdZcq4jyV8F0+6OgAqKmfao913yui0VADY97g83nuilq3yDxn7qR5v
	 u92M/Vcrdugag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0653080E18;
	Sat,  1 Aug 2026 12:41:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0810926C
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 12:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2AB04086A
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 12:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1rR_ARC-18UP for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 12:04:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2FD104074E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FD104074E
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FD104074E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 12:04:48 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cacf197759so27260795ad.2
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 05:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785585888; cv=none;
 d=google.com; s=arc-20260327;
 b=FL7V5po1xjxGFloBak5XilEdJZyrmWH96TFL1PKz06IGPF3AhZFoPdKOCvclB1NnNm
 KEB/JieCmDExCwzNXqOFvCbqZA5lqijJ10xKYnZaT0CkFZppaLvqfsLHxqgojMz1utM9
 YC1KECno+GMSgRPXWvh2GsiE1ycfPXU9VtWaP8b/DOLHfU5Qxz66ClS5xUzcUhVSq2W3
 RckHSTp7PY4Dwe9d5tHJNYKNQs9sidymE5XsUkd42y+cPe+IUoeOMUnK0QnH+DYEv1Rs
 aJwuChjwYg0G94vYuHlTL0D3RBLyTNSwUgozH5vewOIKxuJj5I4ZqDRfNJ2BxkdTtXKg
 GDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6w+/6h2uw48brrMoSByPA+OBay0oBmoukSlEzpbPbMg=;
 fh=tExR1vGhnAarEO8s0sN+7Khz2l043KJvP7rGN7UdIws=;
 b=XJy/DqyXPunh6iWOQI67gMKZJWsc0BoIVThZSr5sAfNCnzWuLeRwihy/jYoC8iSgNx
 1ea2G8DhzaTgPhDGtL+/B6O6Yf0GIQa9Qnp8/VMxCAooFANbM3d25IUrwmfvzy5xYSX4
 wYQpItRGCzbK5Kv8ojiqERHPu264/R7L8Hc7u4b+eLWQ4RNUdiKj1f6TgoQ1Yn9YhAGc
 x/aIkBhpXMq4XkZ+iDEWqvWX20eDVtcXYtoAW1vGJ26QUAol/py4gcYGR4n2qKKWAdtC
 zXC7398CBmi2V4lcP+690SxGJhyfREO97Hwff6V4DKf3H2tuuppbk9sCwpy85wk6G7Wk
 PdnA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785585888; x=1786190688;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6w+/6h2uw48brrMoSByPA+OBay0oBmoukSlEzpbPbMg=;
 b=UE+TPvyxEUaj/8BoSTCl0JTgeFAKtUxy2UpWXWrgM7lkDF81UQUMHNj8BWBGLn5/8f
 E5TgJozPEcm4esuvlgCFRos9aJRXTQbE2ZWzlS8uTAtOyAYd1ItqIfTk1jm8ByzyVUYD
 nM5mYYhb/jdv0yKPtK8eX+JETn3c/qvrA+A/7njMrIARiPeaix8jgi4lKgxHwwdm+B6M
 dshJ8P1aC3Crd5TRrok2R7uVRK5asxjuAOU882WnYa0xcGFaMiaVWevWUIc4qHQeZInB
 J3UzdsOCrObIorHbTC31xOKfB+sMQgKbVm84RqiwV8Mr3T955kk0mgfxnencG7HZckHj
 fLaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyNQJ2y2EsQXDZui7xVhp6vS4zB5/ANhYXkYy8V92SBLe1OLk0mcA1SUSWcR1kIX4/HCsPtiE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzTHlJ3FECZMAPXpSz8VC0j4hcwshTZ28VWIwbboieYuCzlyxs7
 S+6cFhwElf8vjvOm80pYdXgMyRG6yxWM3f24vSPE4POVa1pvggyBavNMXslQU3GNHtX8onXhEDC
 qy6T2WbEvjVYQkfDI6q3/KycoWQ9UNlFLChQXNXWo1A==
X-Gm-Gg: AR+sD13TZRp3lh6ZfGtvxKsgktYajZ75SyrL46XorRdk5XDHmjj9Ch60Q6FPp+BwsiU
 +lEvL6QZl9fRryQUUlgRavmV6RDUlPR4rts6pSIFyremvTJ4dE/UhFcN4LZ1O4zRmpqHTOcsty8
 lz47JgxmZoa1XWwqXSAc3M6KUigVWPf5/AVqa2XMaF4U/STpBK2ZU7HVO6s3SJjG0NXpGio5iJm
 ODgf0sUnrORr429r/6fKKDFq4JAcz/bPy/+jYrNiHrPo0pU+LtJFT51nUbTEMbNirvnpMccge9s
 T/lJlWiQGd8PgPoQNfYn6rm0xRRn0KPTc06EScZK5o8reZ72dnQpE626MsvzhR8DmErBmzPZddT
 h0Q3uhvPdKIfAURoco3BJHcGGUZ07kaVO2dqA
X-Received: by 2002:a05:6a21:2e14:b0:3c4:1916:9d40 with SMTP id
 adf61e73a8af0-3c92a51def8mr3552698637.12.1785585888321; Sat, 01 Aug 2026
 05:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-2-af2ce80db9d8@linaro.org>
 <cb7eccde-b811-4572-8c30-7be4ab3fb7df@ti.com>
In-Reply-To: <cb7eccde-b811-4572-8c30-7be4ab3fb7df@ti.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Sat, 1 Aug 2026 08:04:37 -0400
X-Gm-Features: AUfX_mygk2g3VtWt1QJpold2JlsR1PKkb7jDzO5CUZdDjQTij8B6QszzVLzEnr0
Message-ID: <CANp-EDaEsWN2spSbSsd66mLfy9hARpvZOafcsZXnjQOpoKODUA@mail.gmail.com>
Subject: Re: [PATCH 02/17] spi: cadence_qspi: enable clock
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, 
 Jim Liu <jim.t90615@gmail.com>, Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Anshul Dalal <anshuld@ti.com>, David Lechner <dlechner@baylibre.com>,
 Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Aug 2026 12:41:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785585888; x=1786190688;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6w+/6h2uw48brrMoSByPA+OBay0oBmoukSlEzpbPbMg=;
 b=Yg74Ln7bHKZOvpeYwAY/XE6exKY4X5/iX2RLBROQS+rhGC+3+YxK8htatBAjVDxPrH
 XMEWJby2HUZ0cpoL7ZbsSAO9thoffgpf6BEE8SLq8M2Zl5osAeBbU3QirrWSK5qS+9ut
 hcB3i0rydchl9HTw1RpdedOcAze3Cetu+S6NsutCQwOs1VFYKjPpSs7DgPWTyaPuyvv7
 PtzfPOnM1lD6SPj6U47FaVcgCzX+7o3KUaKsJs94EPG6GefpM9oICkzt362c2oeaY1Uo
 IUl0JfE8djVSbBD7KtM4tt5TgcMmwf/cfDhbAMjfYEz6cMKmCPLi6VAdnMKdHA+4ZXRP
 mOww==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Yg74Ln7b
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 31, 2026 at 11:07=E2=80=AFPM Kumar, Udit <u-kumar1@ti.com> wrot=
e:
>
> On 7/31/2026 10:03 PM, Ralph Siemsen wrote:
> > --- a/drivers/spi/cadence_qspi.c
> > +++ b/drivers/spi/cadence_qspi.c
> > @@ -253,6 +253,7 @@ static int cadence_spi_probe(struct udevice *bus)
> >                       priv->ref_clk_hz =3D clk_get_rate(&clk);
> >                       if (IS_ERR_VALUE(priv->ref_clk_hz))
> >                               return priv->ref_clk_hz;
> > +                     clk_enable(&clk);
>
> you should enable clock, before calling get_rate

Good point. I will move it up.

Ralph
