Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88254C54FB9
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 00:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B1B8753D;
	Mon, 20 Nov 2023 01:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Un/iCSzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C038753F; Mon, 20 Nov 2023 01:18:26 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0447C8751E
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 01:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27fe16e8e02so622848a91.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700439502; x=1701044302; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6YrD268+S507Otjrl0qb01gq1BgMZnP4JcwXdUWELU=;
 b=Un/iCSzZLvB2OJlmwdkvE0sVxZxtvb24l+AvpEa5dwN8s4t+v312KgigOaFRCFcgmp
 ijsN+vPh3IgrlEXBO3+1hVxmvuRuVtZYfXbW44jvPLmT7hnrNLrMtcJTAWnJj6o63XFH
 90XKhi0D5RJ2WSaaSwJVy64BuXobbDbQnAJLG5I3MCdMCz6TfkSDlrfGi4VYcEIjjHke
 vX1/JeSNBrpPp66rUPfGHdC0aqfWNExGco5tPVMY92kK+96GCbQSWs2S7XUByiVseEKN
 KcQ8mXPu9byLpS4idPiUNOz5u/ZznSMeBmP6/Ll7QcddiZmBxyJc4f/i96QvcyiYAnZS
 /vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700439502; x=1701044302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6YrD268+S507Otjrl0qb01gq1BgMZnP4JcwXdUWELU=;
 b=hvgoXdy4JDvXBVgYLSTDAa4p0Qpt8TJJQ/Ryi0XVkuMYCzL4mZva/ptcWJEsOyNNTE
 q6e3TKj3oiZv/mN/aZ2VxwO7Q78HJ+f1vEvlQ2rBbeqiYMhjvvC0f8OlGAjSPVN1xWHD
 3bKtBVSm+Gni/kSOWNSmwsdaysaqWXSSybEBd/CLSK8qC8Pm5jmgkr1X3IzW46ZNQWIo
 Mzwn/6xYNetg791KoCGJogXMja3ji48DClSH4TQBxZRxLA+OqG3fHIsjqF1pGCfuu54x
 EHjHWWJQNv9llGl1sM+ykxeFOGgQXct5eBCHADLPg5b7jYC3Yd43GEQQsCca+JU518C8
 4JcA==
X-Gm-Message-State: AOJu0Yz0PAuMRqnVYKbg2BY4GQTjv2Gf474m5TLOSbT/d5gh1quS+y9k
 mFuueUNnMcUhJcPUkjHPA4pl7dFw1mk2pelG0aM=
X-Google-Smtp-Source: AGHT+IHCvxtrUa/ULKOEcObYkqslsqkBNy5wXKsQoKlDKVlIN7HJKd2CVHFyA1FflulhmzkVlX0781mv93IX7i6/qcQ=
X-Received: by 2002:a17:90b:115:b0:280:259:435d with SMTP id
 p21-20020a17090b011500b002800259435dmr6190185pjz.4.1700439502282; Sun, 19 Nov
 2023 16:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
In-Reply-To: <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 19 Nov 2023 21:18:09 -0300
Message-ID: <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
To: =?UTF-8?B?U3rFkWtlIEvDoWxtw6FuIEJlbmphbWlu?= <egyszeregy@freemail.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
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

On Sun, Nov 19, 2023 at 8:47=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjami=
n
<egyszeregy@freemail.hu> wrote:
>
> It will warn, if warning levels is set correctly. I will do not remove it=
.

How can it happen if U-Boot uses
warning-1 :=3D -Wextra -Wunused -Wno-unused-parameter ?
