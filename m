Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E271ACF6497
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 20:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54309886B1;
	Sun, 29 Sep 2024 22:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yu6g3wRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0421881A2; Sun, 29 Sep 2024 22:54:52 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6CD588A1C
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 22:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53988c54ec8so2331848e87.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727643290; x=1728248090; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U+7v1SGWlHLZwQvWRKLwssNzkC0ZT97EAw0ClK5HPU=;
 b=Yu6g3wRxgcRZaouwO2Skg/E2bwaJxfUQjgXAtv5nSF2jcDaqW6uctmlix4Ir30gy7R
 P9m7lXgIo+xyZXtBdWXruxfBAjZMIbXPVjBdW1x7QoB06ttOg/FjLsS41UzJZSOprdDn
 VXlfzr2y08wyQP5oPOFli8OTeYCrzhZp2mXZ+wxAlL+hhdjKNIhxtDu/Yq117HqbfQaT
 XEeNDbiwB/mH2lQiAJbMLBZM9e87iv6nU8lAfGAarV1R/7s1KYv6SHFRx+wP1sKer7SG
 Vdj6lCIY/lOlXOm5QsHTXxJVA8g/wOTCf9VzAvKaoc2koF/FQNSmP0i8awtByCuA37oz
 Y7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727643290; x=1728248090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U+7v1SGWlHLZwQvWRKLwssNzkC0ZT97EAw0ClK5HPU=;
 b=B+IZ46WO1viPClJSoZtqufikEBENtjHWtCe6Iux2BG9dbgFfLO64SCq7KQFIKuGWQu
 Wz0vcKpl0+GBWmHQ89cqEFhMpxmqqgTdOob1V5qdrAL4A6eFhHrbMlJXUCDPC+TCQCO+
 owMAwhsqgcbL+9dX90qYnjli/FVba8/qgdgUEeOSpwpSB2qhkzNEJ7ho+ShFYK8ZpFfW
 +b8OvOAtG5la4J75CNnZT/3KilgA3DhDr1WYmmlSHQREqtpSd7qCO38DOAi1TfJK8vtc
 ttWvzd9ddIC6pAwOsMZruw4WYUmSQMWZFrzAKA9PAHVLu87br8mtzbBdl3m+Y2kplbdJ
 mD0w==
X-Gm-Message-State: AOJu0Ywfx7hXgiUUSPzAu6894PRAOmJVi4lAboKN5GlgYbPYEV09J4JO
 TaAmaRVL1zXfzM9zmIwYfow2pP/1AD0TRQ1m0fv4BJK6CIgTrYZxmK5VV1a4e6E+HXJmrpcinoq
 rP0kBEyQbcgkGHmW0C8ED6K7TLkM=
X-Google-Smtp-Source: AGHT+IG08qeM/9vp5Tt9EJ2TCaKp44VKPkwgu1lATLqW6LCoxlggZicDe1mO3+Iv04gQmiCDsfQdEmTv7cOaJKivQ8c=
X-Received: by 2002:a05:6512:280e:b0:533:43e2:6ac4 with SMTP id
 2adb3069b0e04-5389fc81051mr4708266e87.49.1727643289731; Sun, 29 Sep 2024
 13:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240929013226.2750458-1-alice.guo@oss.nxp.com>
In-Reply-To: <20240929013226.2750458-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 29 Sep 2024 17:54:38 -0300
Message-ID: <CAOMZO5CLxuKynN6GefJjM8xxkdhRNyXs6xTAfDDnv7EVmAtwFQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: adp5585: Add SPL config for ADP5585 driver
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, marek.vasut+renesas@mailbox.org, 
 clamor95@gmail.com, paul.barker.ct@bp.renesas.com, michal.simek@amd.com, 
 andre.przywara@arm.com, ye.li@nxp.com, jim.t90615@gmail.com, 
 billy_tsai@aspeedtech.com, kabel@kernel.org, caleb.connolly@linaro.org, 
 biju.das.jz@bp.renesas.com, sr@denx.de, piotr.wojtaszczyk@timesys.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

On Sat, Sep 28, 2024 at 10:33=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> So we can disable to build ADP5585 in SPL to save size
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
