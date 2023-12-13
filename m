Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A31C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07C286A81;
	Wed, 13 Dec 2023 17:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ikeVyC3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F0D87843; Wed, 13 Dec 2023 17:30:32 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9259386564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-286f3e0d010so1861488a91.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485029; x=1703089829; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkKIYn+tstPS5N1DOgcdRYAbuadxkYw1u9MURpihTTs=;
 b=ikeVyC3sHJc/s0HYODyWo+FHYE0owEJ4Z0gDkPuObAlp76Cf9KXaeZpX0uORkDXaZ1
 URo3lmhamLpihVre1Bwx9we61Hbgssu9R2Lm4NzFFqK+s0HIMunJUKU+UEQLXOVOKwvo
 JFrInuYRi1R6Nuq78o/+lmMY2ABK+mf2zuo+dIrVMpHWb2W4dOE5Ntt/pEqJe7QAawdb
 dpXNFKv0rPFhletLPTK7jBD10VRgzJLvWzVpBjgv4e/ycPO5EeV15VKm/IvQ1nHu7nDi
 rWcjKzwsVhC1HwwMS/eOiw4qe5SXnYXGZnY4mDPkeDHpSZgI4qsKuM1/Xqvvih6toGYp
 T07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485029; x=1703089829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkKIYn+tstPS5N1DOgcdRYAbuadxkYw1u9MURpihTTs=;
 b=LrKeSTH3xeHNPwtalF4L/WGEJSku9jtIGS5FuBw3zkdtqi0xaQR4DY3V9zaHm2Dmmr
 eg7bv0CpBitybrnp3vweIFFqIqYhbtin3uW9j7UrxCbLnyfklw76k+6/JzBoFFxP0M8C
 OekSi7NgP6Hd/H8Sl4P5IQUswGJn2feRxrV8OXVnXrI2KGcA2b1WrGH6qIMKMWj8gMaj
 yHpH+7cVEunGj1R+2+nNMg/RvtD/A7L7GmIJn2ZqtzyJuv5ojaFuQpy4IUfO0vVKBN2q
 BuA9qUR0amWAuU37nzB4T4MLz8vntyrSvAbhM1RcRJ5xGP+jieduksp4YrTDRfldAxfP
 rhyg==
X-Gm-Message-State: AOJu0YxY/+JA1Ah2J3avIueQRcp5UW5cAl0fLFptITjQ/YJS3vfCatui
 sTDVdoLGIY57NJ99aLzQX03Nvc5zwkgA4AmYLcQ=
X-Google-Smtp-Source: AGHT+IEmFz/2AVkeThX5RR5Pzbsf3NllkOXFhm0PnPMJP/yZrg1qoaavOCLCfqejt92DKEKw1I1216CHjxSc1sxYFjY=
X-Received: by 2002:a05:6a20:3942:b0:18c:198a:469b with SMTP id
 r2-20020a056a20394200b0018c198a469bmr19114973pzg.6.1702485028935; Wed, 13 Dec
 2023 08:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20231019194241.2207814-1-hugo@hugovil.com>
In-Reply-To: <20231019194241.2207814-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:30:16 -0300
Message-ID: <CAOMZO5C0LN2FhsyKnO+CKtcjVpkjK066pKm3ZMU+vTkGMJT6jQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mn_var_som: Add myself to MAINTAINERS
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Thu, Oct 19, 2023 at 4:42=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> I would like to help maintaining the imx8mn_var_som symphony board.
>
> Add myself to MAINTAINERS.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to u-boot-imx next, thanks.
