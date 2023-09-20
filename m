Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAEDC04FE8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 18:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E3F86BE1;
	Wed, 20 Sep 2023 20:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ScC2XRjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7265A86BF7; Wed, 20 Sep 2023 20:41:04 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9E886BDE
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 20:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-273d9b1908eso11290a91.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695235260; x=1695840060; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUvzNKqZTkJNVT5/uzbRrSbko1gPiXraYFGJ3CzOMlM=;
 b=ScC2XRjCw2m5KWpwGaYVzaHnQYyq3IA26Z45A9y9q5NEMEsW2XPr7WntxGcD9PAYiS
 f1xXdJmAoMoWVcoboexdhG7qDsj6+qoMdzeHxUw+4s0mvAvBteI254VjbAZzQzl4xpRB
 uWm1Vt0C4zGmgwHbCz5MofbvbOer+ftefZjdHT3ouIeGWAr4EcjqWhO6Qg63Kxx4SDP1
 b+QOhaYk5idWxKadTEB4N8XdpIrLhgA6KsOhO+b86QdgUAtdCkBJl5igiBZRtfcA/K1z
 tX+tAiWZFM9q9c2lodQWhGWPttIiPANiDMcLnohX2bjmF8AFySB/6/u3rKWdmmy70sgk
 6I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235260; x=1695840060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUvzNKqZTkJNVT5/uzbRrSbko1gPiXraYFGJ3CzOMlM=;
 b=B8/GCksDZC2aE1qv+EWPao3BqvXhLA3zcxyKUAN3eiFlm6TuycYhwY1S0lZeCzhwRD
 8Y3ESbbmxXbQrFUxolHBTq1JqlJzZEMyc8g9aXLgqXon+SdAiOcVcIFG1pye77nc79DG
 CKbZeWlzJQ1Z9md8SFTGXlJ1sEdxXPFGLwcpkJddyGmC5j6Pty+q0u/gW5oP/xtu98Kx
 3mK4z/hXTMSU0Sm4n59x83acYPgO+Vl7HK7cXqHDD3jYxZ5cTjCnC3izlUcDAY7RQ8Pp
 dMKdHxbUno1N/l6xDM8fQ9ibqmxgRVFVjt3zst0TU1yEw+R9hPdNyUwi3i9vkFH8iksP
 76nQ==
X-Gm-Message-State: AOJu0Yz7xjUBHP+huOIl1MfymFozqj9jrBKUKBjU2rZS6uefrfBCQlLc
 JHBp0XfufcaliXoGhAD8yE5/zYo1dWUq2MdOCdE=
X-Google-Smtp-Source: AGHT+IG39rRj7ZYAIDWH59KXf/E6FMh3vAtdORqtGAl32cUm+drnciVmVxHEjcuqy5nNc2voVkP4qgxLRW4TB8hV5yI=
X-Received: by 2002:a17:90a:414b:b0:274:60c7:e15a with SMTP id
 m11-20020a17090a414b00b0027460c7e15amr3236842pjg.4.1695235260637; Wed, 20 Sep
 2023 11:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230919092847.42391-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230919092847.42391-1-rasmus.villemoes@prevas.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Sep 2023 15:40:48 -0300
Message-ID: <CAOMZO5BYB7e-+-KBynxQt6LmdoFXSnFxE+_uL3HgEnU50BTvjw@mail.gmail.com>
Subject: Re: [PATCH] imx8mp: binman: rename spl and u-boot nodes
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com, 
 Marek Vasut <marex@denx.de>
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

On Tue, Sep 19, 2023 at 6:29=E2=80=AFAM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> The hab signing script doc/imx/habv4/csf_examples/mx8m/csf.sh does
>
>   fdtget -t x u-boot.dtb /binman/imx-boot/uboot offset
>
> to figure out the offset of u-boot.itb inside flash.bin. That works
> fine for imx8mm, imx8mn, imx8mq, but fails for imx8mp because in that
> case 'uboot' is merely a label and not actually the node name.
>
> Homogenize these cases and make imx8mp the same as the other imx8m*
> variants. The binman type is explicitly given and no longer derived
> from the node name, and the csf.sh script will work for all four SOCs.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Fabio Estevam <festevam@denx.de>
