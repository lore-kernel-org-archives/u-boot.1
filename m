Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F4C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 12:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4399F88445;
	Tue, 28 May 2024 14:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bz0mV4yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519D88844E; Tue, 28 May 2024 14:32:02 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325808842A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2bf5baa6034so160409a91.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716899519; x=1717504319; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhYTW68E9ux/zlR38qwz39lX55X3pVKgoM4ZMMfaO0o=;
 b=Bz0mV4yFjgqtZfOIPfSX06uU5ZXRPLdEN7ow2g4/PeZPXL9nvrTMfbY57c7bJAcljx
 X7+NbUs7jfhoZ0kBCOEdSN5VnilKQ0SapGLuismXL+2e5Bq7quojfWMH6zrMWcw7sIOn
 IHQe8UnzyxBegcPU5Dc1YhMH35g3ZkHn+TUzKwfYI5crxkIbcHIxHvbTd6SZZTma+aWw
 KvZicYNYfpnSiLJvAG1uKNZNG6Y/ytleO1JGVVbbVgjsTq1fQLvHHkGrKCWhrb9QzuZe
 xR3kmGZyk+tmqVyXlh15LdHgvU8IFYX6i+3Gz5UR/O9u98Dv8AmjJNOk2Xrnwv1sMSpM
 xW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716899519; x=1717504319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhYTW68E9ux/zlR38qwz39lX55X3pVKgoM4ZMMfaO0o=;
 b=TaIGykMVX9IGB6N0WKcTC+4FoNChBHvVg6RRidgkf1zLUGKbuytgGVTo00qsJWovST
 53RfJD3qLf83R2qCvT+hUvL0IXCFgsTp0QW0w8cTCSJVipIQUmOFq3YxTNlOARRL2xtH
 MWns0swTjsB4hKC8hv/kzUcRSQ2bd7YrCnK7MhGGbs4UJTtaRZv3/QtVx7sxwZ3fviHP
 CteP0pHsD3sDyBQoFXQdRJPJgiI40BOdfjHDIehNGzdoGbJFqzHrWni24voZMTvNjnKZ
 M89HassiUY19aXn8FoRIm/lISY4JOOb0QI47jIaRbs9W91WJtHSfQIYHncbJcwUyTVFD
 rvjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbVB1Zf5NVRx5w85ptc21+4QdtNUCEmNlRndtofi/3eD7NJvdvL/fhZiOl8zSH7WyIyZl1rKCtWR2/OeemTCOBPlWX+g==
X-Gm-Message-State: AOJu0YwZaONZxEYlT6TYdLODn88yHk72z+6TT4Tasbsot5fNHz/hJODP
 VWNLr9IiU7yYQFV1yj9dPD7G7BtsJraNJFPV3v65O99lpvijMLA74olitQRNZk1BMEAQlOaYcoS
 cqJm6BGvxlCEegjgaPaIQEmLGUbQdpvpO
X-Google-Smtp-Source: AGHT+IFAAq/3+pKHd26FY2sWM5Jkzam9twgluXsIHqtorG6ES8BiFASzhpYCKLfqCVp3c03NqrtVA3xNU4/8PAOtKgI=
X-Received: by 2002:a17:90b:8b:b0:2bf:7c50:1f6c with SMTP id
 98e67ed59e1d1-2bf7c502036mr9465351a91.2.1716899518536; Tue, 28 May 2024
 05:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 May 2024 09:31:47 -0300
Message-ID: <CAOMZO5DhnEz_7Ldg58PnsQaFoDMnPY1_gmxZEeLUf2JyyQ8GEA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] board: toradex: Add new Verdin and Aquila SKUs
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
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

Hi Emanuele,

On Tue, May 28, 2024 at 7:00=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Hi,
> This series adds support for 0090 PID4 Verdin iMX8M Mini Quad 4GB WB ET S=
KU.
> It also adds two new SKUs config block support: 0088 Aquila AM69 Octa 32G=
B WB IT and 0089 Verdin iMX95 Hexa 16GB WB IT.
>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Emanuele Ghidoli (5):
>   board: toradex: verdin-imx8mm: add 4 GB lpddr4 memory support
>   board: toradex: verdin-imx8mm: increase maximum addressable ram to 4GB
>   toradex: tdx-cfg-block: add aquila am69 sku 0088 pid4
>   toradex: tdx-cfg-block: add verdin imx95 sku 0089 pid4
>   toradex: tdx-cfg-block: add verdin i.mx8m mini 0090 pid4

It would be better to split the series in two: one for the TI-SoC
boards and another one for the NXP-SoC boards.
