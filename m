Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF75CA5FEB
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 01:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB37683956;
	Sun, 18 Jan 2026 02:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc1KJ2FB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B48839AC; Sun, 18 Jan 2026 02:46:54 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7667780FA1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 02:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6442e2dd8bbso2414277d50.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768700811; x=1769305611; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOSPRrNr1ux4slNFw6WTYOhcdQLE+jgWTkKKKsWmP98=;
 b=fc1KJ2FBAN6eU9C+nvMH5N82yYddWGWsBH1udg5H66nGHtRN3sz+WncpMGgQR31YfE
 L5mfbptCGP2jWTNaK6fxMDLJJASkyXzqBfFlSNAyjHkalKRUXz/b5V4LXtfUojpZoStN
 Gpf/UiIZ7fFaqxM/oAN5hSVEEqIku1hUQSUSW+oCRA/5fxRlcyGyon5hocrZm6fhMtbQ
 BTGN9lPnKeV1fBaCTixc4rZXfnjgy768Z+w7gccMSjP5NxGWh4okSZX0OdRTTvGLl4pb
 CPcWz9zmxEjIVOItV97HUnhIidEM+Wrez+hT3LOd2eU8f/tmfNGmoKSwRJDrgETuPP+R
 DBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768700811; x=1769305611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YOSPRrNr1ux4slNFw6WTYOhcdQLE+jgWTkKKKsWmP98=;
 b=Nigka20vqTP2Ovirzp8MRrPdC//GZ+1ny9oSYixNnsqJ/9hAEPdiYIsa3olRpKDcXD
 7jduusd06xWZpAH0LUHflkjG3z4FtHHiMec0O2ETP5RW/+XS1VWoYC1VKYui5387So4U
 8PiA3Rp13ZaiYj5ELd7Q3JlyJZerjTWQk8sZ8+IjdasLxOF34nIfAYZf8/2CQH7QLsw6
 Eusd17pyCumoVZQ9dJZ1ESpjG9jCPJJEw3TJ2bfWhXT8VtDNxznXnCNAgyoMpaiRk7VK
 VIRDzbNXB69Az2x7IkiI2Y0dElmGHPe+EyYyjvdC/jKjSIyCJNVO12IIaGGe5x17Gplw
 XWdQ==
X-Gm-Message-State: AOJu0YyK89+pU13znaK3m0WffmcnZLkOw2EX75RpeaYzsP+8KwyEt4VF
 11zS7vDUoV6l3aonUMN5UjXxEI9J5Aa4/asFXHOeUrhO5Ok/akCeg5Fv0kKsAvPrcyx7CYU15M1
 4NkU8BNp4IJHWH3KnOd0gyCyKoNgCdUA=
X-Gm-Gg: AY/fxX7KKpNrbTwZtfI4+uAsDSMsXlViknoAQCLR8ja1OdBc0xWyPWUJssm/KGnfNPZ
 ru9IEWtbv1glQb+bBLcj6TKMorJzxGHTxH2X+BIvR+tH9hK/nx/anmoaRJA/GPgaW6hGR+kWVKw
 xYf4GCSnVmQyAfZNQ1UQ0DGzHAZEQH8vSFkX580Nezb0akNxXEYS6jh6mBbFqdYwdIHR5jK8jMm
 fXy3yZq06oRKuz/yw85Nozl19RAegX7XtnIgL4oQSABx8yk7sT51kwFf+awPCiQjDSeWTN4kGlK
 Uspku84W2TuCnouexyc=
X-Received: by 2002:a05:690e:418b:b0:644:b4b7:35d9 with SMTP id
 956f58d0204a3-649165082e6mr5991142d50.92.1768700811253; Sat, 17 Jan 2026
 17:46:51 -0800 (PST)
MIME-Version: 1.0
References: <20260112181304.2112-1-mps@arvanta.net>
In-Reply-To: <20260112181304.2112-1-mps@arvanta.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Jan 2026 22:46:37 -0300
X-Gm-Features: AZwV_Qg_d_JuVRHocVkuVaxzfFa5HgxwygW3-VLPZaRdhT-gGFopafODWJ_DWMg
Message-ID: <CAOMZO5DCdAMj3eLHus3FHOy5k_fFUH9OUfDhmehKMvh-i3Ah5g@mail.gmail.com>
Subject: Re: [PATCH v1] tools: fix format string in tools/imx8image.c
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Maks Mishin <maks.mishinfz@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, Jan 12, 2026 at 3:13=E2=80=AFPM Milan P. Stani=C4=87 <mps@arvanta.n=
et> wrote:
>
> on 32bit systems with musl libc compiler emits
> warning: format '%lx' expects argument of type 'long unsigned int', but a=
rgument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=3D]
>
> to fix this use format length modifier 'z' (size_t) instead of 'l'
>
> Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>

Applied, thanks.
