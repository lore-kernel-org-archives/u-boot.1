Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA861C44507
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 19:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB61084D67;
	Tue, 14 Jul 2026 21:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dg7eUmBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BCE184D70; Tue, 14 Jul 2026 21:28:28 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E5684D65
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 21:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso9745684a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 12:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784057305; cv=none;
 d=google.com; s=arc-20260327;
 b=eRFWLy7kJT7RZsZshjrZ/GPAB5QPRUO+TwpvRbwVBl4tnrj/AhOEk87at9yBCQ4ozo
 xWGqPfkqzz+kadLz77JmJa94NHiGkvyuEv4Ibu59QQEe9osC0ARrZ+zhQVYzsln66wkX
 oKN428FjEjX1rH1xe6IEro6FFB9nXIrWogDTSWfZPwn39BYBDfdiIxl2OI7sBIQB1xIp
 8MhyyUgkWc4HcEjyAGtqR4DjJznkPObVuhaAkTfAaDqTLZ2FNZkLeRKL5iyIZgYc5bI/
 3Cz9nimUIHb8Ma1uubRmNoXzsRzJSt//P/y4ZWoh679ENJ+oDI0Fc5An5LGNwq0nhBHT
 /smg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1/TX/Dj2H7rEsWFGNWOSU8NW7YLs4FJMlry9vNZDxjE=;
 fh=1+j+hwwHmmFwuRa4oVWm/Pcer6Htho61Brd/nB1EAdE=;
 b=qCvjS4QM6LCAY7DQILK4Szn4uJwreI8dBQ8R90g0HLDjyPzMyrm7b1nvLjWsOUncgz
 WYZIEy7jtYliO5xaDaVpXntyS7Tb/LKRJM9k6J9DsgNXe/edMqBemfFl/vXGOCFzrbpw
 6YO32P6OTbvcQ/lyOa4fxgma6VtTeQZLqkrxDeVXMfmoJMOG2dPlnfiYmtSr0DPpj4UZ
 JC5RStO8BFC6NgxlAFqFEXtB2lfP0U9vijF80HWyinIquKFo9/hBaIOgNpr1DqyChhdH
 SJ5EIs//ta/WyhwdXYT1Xolr7Cw7ko+/u8dRsaOysxKi+UNxr4xAMBrqdn3+lmRNdFpH
 fiMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784057305; x=1784662105; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1/TX/Dj2H7rEsWFGNWOSU8NW7YLs4FJMlry9vNZDxjE=;
 b=Dg7eUmBnErqBtQq9v+Xh22aWj3Q7zxt816/HszczyYaDkKALQMYFbsNRTmZkkVB/tC
 jYcTaZ/mI7ibhrYWqVtwtOz8Nm27/+Y8UF5v+YaVbzd9ax7mOPzBdQRTorvv7ZWqJ9by
 1/XZQpdCzHg5HS7ueCQCAijc+gDofEDA/Nnls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057305; x=1784662105;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1/TX/Dj2H7rEsWFGNWOSU8NW7YLs4FJMlry9vNZDxjE=;
 b=fHJSgg0EYQnoI1i58i9cZGh4dpXSgDRNoZL60R6I6kkZPkiacIdVZCtZdly7aIGhgP
 FcNF4C+wCV59FqVQ/wXI7aqthQ0nlRnfIQvnkRIiTRRcefp9nIxtZrzqIeawxuOL6hgY
 vIvjHkvhW/sgPHY5vbvYao1SjNs+vs+o92xcb05rLN3cXoDPrfZT0WtV9dp00dOnvNHP
 Vb9DgDBjV0KVrg4SwFJZTkipqpJVqlKuiwR71SzTQwmFB/RIHi+Utw8sku8esau1u+Mt
 lV6ZILWq4m3TAjBwQE1J0k8XwoeWJlPymW4pg2/Z+z40+O36NovwBYly9jNEPCvxU+gB
 xwZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNR6rZ/vQyORavKC5tOJ7iBIrI4AN+cqRYwbDIYIyHP5zUFWHtuP7WRyHZcqtgtYhQxSz131o=@lists.denx.de
X-Gm-Message-State: AOJu0YwN7ZOTrrCWQCq9bXHfv9EqXn+IsqBizBaI/3620w+kQF6QaPsE
 qeUhnNDF0sq+i0ATF+Ytj0HeO4t2hfQ89pzxp1O8+nebVL/XEI044jtiGk1G/5MgcqrowwEKzd2
 d2zkBTBkjCD1uIWQkBgfDrGV3ulUIVnrmv0iFWJjE
X-Gm-Gg: AfdE7cnpvUmqHS7O02naNCWSYMp22uc0MaIw1Vj25TiICJMYED7ya7my3imCLV6Toqg
 OahvoxBiz7CZNr7PI4PcQ4Jbc06kgT4Hi/R3qn39Gma8FoTPZJ2Rzsn+QIdU41gX2a36A3OXkfF
 VflfcRUeIYqYa34Nah9DXlf8UrFqk7feahZbXnWz/Itvodrh4kRwEc3tpfz6Wc9EwehDnMLkvmT
 ywkWHrNeoUoyzZBNLBfWdszmm3YxPZpInRLcj9n04H5IiKb13gK2L8HyjMhsj7u5gYh8TE=
X-Received: by 2002:a05:6402:26c7:b0:69a:2ee6:4c95 with SMTP id
 4fb4d7f45d1cf-69cd6bd43ecmr1954217a12.0.1784057304843; Tue, 14 Jul 2026
 12:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
 <20260713-osuosl-ml-switch-v3-2-48b71dec1a23@linaro.org>
In-Reply-To: <20260713-osuosl-ml-switch-v3-2-48b71dec1a23@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jul 2026 13:28:12 -0600
X-Gm-Features: AUfX_mx7pnkmb2OLR7oFiQcURqSI4SF8r1rHmP0ThZC8_ahE8mNhr2-xhiyBat4
Message-ID: <CAFLszTivPESwmeNoK0WEm5h+y4JySX5SqamEVe+n=pweq4kSqA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/3] doc: Migrate mailing-list to
 lists.u-boot-project.org
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Heiko Stuebner <heiko@sntech.de>, David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
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

On Mon, 13 Jul 2026 at 09:57, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> domain, so update all references of list.denx.de to the new
> domain in the documentation.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  doc/CONTRIBUTE.rst              |  2 +-
>  doc/develop/security.rst        |  2 +-
>  doc/develop/sending_patches.rst | 12 ++++++------
>  doc/git-mailrc                  |  2 +-
>  doc/index.rst                   |  2 +-
>  5 files changed, 10 insertions(+), 10 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
