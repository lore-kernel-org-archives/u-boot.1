Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1F8D2A538
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B4488C4A;
	Wed, 16 Oct 2024 20:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCSNwhaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB7A889C5; Wed, 16 Oct 2024 20:32:19 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4D4D88D5A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb6110c8faso1821561fa.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729103536; x=1729708336; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH6kNiZ4gUqntj2LlznSjNq8yXBnvtDXFZJr2wY/6D4=;
 b=TCSNwhaGp03JyTgrWoKW5J77ahjk9cFB/HUQIzJsuajSu2W5Vxs2B092vsUD6UsWS+
 CQfaajdm7PtzLYWIJe4ofv5Vra1ZhgZJGgbb5fvvIgZVn1VwV5HQNZkg/Bw++o7JvMV6
 vDcKoSyxoOm7ijYQejWa4F55C7eAkoak5wOzjYuT9VN9GPj78g6OgEnOqWGO9b0F4kme
 Eoyn4RSd3cjfug8/jca+GUxDOVyD7VNA50qMOdKfwjXx+BQJjarpGw54tBs+5/f2ory/
 g8xLkbnbV6VCBd+0MiDFWM7mZMiR97qEYwLSRnhr1GVN0LJ6HN2xDTIr2ZRl/27K2eg4
 udzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729103536; x=1729708336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EH6kNiZ4gUqntj2LlznSjNq8yXBnvtDXFZJr2wY/6D4=;
 b=A0yMT59V6Z0CuXgjimrBzmgr/KAZt94jRbI4jrqm9+gFTKo8/k7r1oiB1eOVzabTnX
 LborbsZ8hW7GZpFV3F3vvhC+SDo8VRLMgLOjLSu2ukJCTpYNRXn6nUwYfFzkt6CzWn2v
 BqsCmuWLXE6kZ8r5Oa+Q9T/Sr4yoC15l3zumEYHzO1SnOdGWDnKPNwnS+oL2oFj7jAwQ
 mhqfVJezN6nW35cuIXMe1NcEP4tjo61iupCguVNcgp9+FslNjZwM+qxJmQgdDb1XbNQ+
 d7LmzN4jJxg6GvMb6bMfPSEhmq62xZM/1FG2jvG+QEFvMKTonDTTQQZ6wj5n9cEiEH5P
 Ygyg==
X-Gm-Message-State: AOJu0YzG9MXWcLaYJoVHSZut1NGqNh+t5TxrWA1XCBW+IL0SlKBq1m56
 GE5a6aIIU2MwzQE25Dsc14xqacjQhuVOyKAgDDa1U2fqbK+0Y/7z/CkuXwEqP0jnrqQBT72J4vC
 j4Bw628XPIG8NEQLmBh3RQQ4s+dw=
X-Google-Smtp-Source: AGHT+IHGEDHUyXskT3OG01o2SfrC9hOoLLC2OzS3VYGalQWrj2Hbp4Q4d1NoZ89/7af/wVDen+sX8hkv8DVAyG5cwys=
X-Received: by 2002:a05:651c:502:b0:2fb:5bb8:7c24 with SMTP id
 38308e7fff4ca-2fb61b3ea36mr30399181fa.8.1729103535720; Wed, 16 Oct 2024
 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241015002505.1243-1-egyszeregy@freemail.hu>
In-Reply-To: <20241015002505.1243-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 15:32:04 -0300
Message-ID: <CAOMZO5B+EpaaP1YXNxWsk+6m4qU347cYBC-cMFYjiZTaB1s-kw@mail.gmail.com>
Subject: Re: [PATCH] pico-imx7d: increase ODT resistor value from 60 to 120
 ohm to improve DRAM stability
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, sbabic@denx.de, otavio@ossystems.com.br, 
 Ray Chang <ray.chang@technexion.com>
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

The subject is too long. Make it succinct:

pico-imx7d: Increase ODT resistor value

On Mon, Oct 14, 2024 at 9:26=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Ray Chang <ray.chang@technexion.com>

Place here the explanation for this change:

Increase ODT resistor value from 60 to 120 ohm to improve DRAM stability.

> Signed-off-by: Ray Chang <ray.chang@technexion.com>

You missed your Signed-off-by tag.
