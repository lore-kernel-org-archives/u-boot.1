Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ADFC54E41
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD0787CAC;
	Sat, 24 Feb 2024 23:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dGIZSu4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F2287CCC; Sat, 24 Feb 2024 23:11:00 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF0787C9E
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-299d76d3a26so26909a91.1
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 14:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708812655; x=1709417455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JslgbPVbRM6VIHowBh9VYpsdjCINBzjn4UGh+t/wzPA=;
 b=dGIZSu4xiZNc1H28DtenDKv133AyxsthVpH1iH1xk0WFpqi0GogqDCS3GN/dhgBMFF
 F8CXQQ4dboxPfu25ggPZs3jmE3bAsv4NAMRwz2JD0UGZ8z15HlfH9JgNZDLYQBwmGxgR
 v4QF3fvgAP/0wWgmV6G/hu0CnPzNI/xXR/vzh8N+k4fMSpZB4cR68zxQFq9O32WSE0C7
 fCUEXpAxw1roKKhVjM0IMTDHdTeZXQJh5A9wZye5JUg3rBORhlNV7mepwC2MqQVxQh5Q
 P7gvhE/fHJX0ULxN2uoNdUk37cpqb1IA4wIY8WXCQGyuforTvYdtkDePeHnbUhQlo3je
 ssbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708812655; x=1709417455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JslgbPVbRM6VIHowBh9VYpsdjCINBzjn4UGh+t/wzPA=;
 b=lCnlQ0ZWJnDlxH7cNpc0SXBsDaXinI3Ep+5WWjFvSbjmkHALrtm5QKkyrQfxo/Ofwx
 FMeSreJ74QzVTQqbcOcG9vXqIhk7kBcY4oyBanW5a5ggjVc7WdKE+7pBlXC/gGMLPuxH
 Eg8lNNMMoL//Bkjngxfhz/6ODLhyl+v9Q0w6ImSJ6YWfHnSLOUN4tEcx57/xfCNRQTCN
 Zv1y2lFsczeaW152qpaOzha5HR0tOPfKKy36rIKG9OgiVuZU7H0Ysa8/wby9AatVsiLk
 +/LRJqPAWYWOJhwtCoV36bWhyMy6UN+XbNqFLLdIQIJhNoNwUnk5kxZCdgrbeU4tn3RW
 Umqg==
X-Gm-Message-State: AOJu0YzpDWSuNPp2lPCdeOIWLY/c41CJ3QAAAOfKpIva5uGsHs5LCSue
 NkQWwWCm6EyrJkzOWb9b0nWBMPRli+plaswxXzzsc9AjZxHc/hBO3EcD65txCgApgSlmRZ1Sq2k
 fpRG2enticIo3tUU1/zY1JmWKaH8=
X-Google-Smtp-Source: AGHT+IHFXo0Zk+1FCESnQ+w9K3WNJllUEVuFwxXLr4mlWSvLlAkVEi2jzjqmMSHyrftO5ywWo6UwkKWNgVcYixwBMro=
X-Received: by 2002:a17:90a:7c44:b0:299:1ae1:51b2 with SMTP id
 e4-20020a17090a7c4400b002991ae151b2mr2417617pjl.4.1708812655232; Sat, 24 Feb
 2024 14:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
 <CAOMZO5B+eZhJOifRiux0n8VXLkQgwc8Q8215ybJgJ-LHE8RAAQ@mail.gmail.com>
 <CAJFTR8Tjk8b-DZGxu2f4-LBoZdSqE5oDvyTY-DDOJYUU=DSvcA@mail.gmail.com>
 <CAOMZO5CAev9T_627gV88Rzcc7AE1jYpm0EyBJ-eSPcEJ=X4V-w@mail.gmail.com>
In-Reply-To: <CAOMZO5CAev9T_627gV88Rzcc7AE1jYpm0EyBJ-eSPcEJ=X4V-w@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 19:10:43 -0300
Message-ID: <CAOMZO5D5TnxkcHEjEwPF3vBmWHwmrF_9C1oawP7vkOFCzXWTVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse T <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Tue, Feb 20, 2024 at 2:20=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> Please fix both issues and submit a v5.

I have fixed these issues myself and applied it, thanks.
