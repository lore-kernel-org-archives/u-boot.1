Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D28C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 18:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A001E81A0C;
	Fri, 28 Mar 2025 19:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="VS70hwWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07AA810F4; Fri, 28 Mar 2025 18:38:35 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AFB80F0E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 18:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30761be8fcfso23621321fa.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743183513; x=1743788313;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnQql1KtPDR4GH0YTg8iK0k82gVtGsW+ld1QhZXiWDQ=;
 b=VS70hwWvnITUBtI8N/bhv0aG00ftqSuXsfaKeMdQLv3jhhzwfSDR8pvwyel6jPE6yy
 QPcfalyhXIoqXHPs2s+nJB4lv5XzZstZmTGXTdfkfavy59fja2t2pNIEMowTpjZ1ZqDA
 6Vu6atqTNNfvpEvSWtypUjigreSDySVNTfzwwnQ8taIgiZ0TrY5kwVnRZsw9R8viC6bZ
 XUaxqmaMfBblmsbkNDADGihXSXYQSt/bKNsNT1JkDjwhPtZN+yKtsXR2cBytcxD8hFEO
 Y3WzoM4UFEk/77JFo17cqnC15FOc6EPgs7vydhXNFEXO9eK1D4zvgjx5Mcp1WWOJs4nX
 n4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743183513; x=1743788313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnQql1KtPDR4GH0YTg8iK0k82gVtGsW+ld1QhZXiWDQ=;
 b=CQbHOdFv78La1wnX7sxboiI00Ex7AvT2ZyHqKB+hJjeGNpfE5fIJKyJ9y5KLjCXmWR
 vQTp5cFClVEtl9UU6i6Sf4qrcS7xsKFLUpEglMRg6kNDIsP2QcOuUaw4ef6n8imR4DTj
 /cmmAJauHQpXcQgUB9RcxahCagMEB9w+o6/+fv9CoqVYvR374aaXUYwd2u44FDd9YjZq
 sSpht3Eevho68IMS2Ni7yQTYDYbTynMW+nWW4rqJTDGUptw7B07XRWE4OvltnUpJx+/K
 lyvelzJC8A3ah6vYYjTWPKd0VJEUPfnbf3jINi+MbVB65FvX6y2XUkClkFuNE2/qVj1B
 AUXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlTB0GKL+KINBMV+btDqJFxV9nAz8qqm5uSVGFzJd+n62HffZDnrPxNdW2Fzo93WAtivmboJs=@lists.denx.de
X-Gm-Message-State: AOJu0YwY9jtO8vOSMPHNNJpOKyAOVmsRHPF2ALglUqAud/OeBgAe/Uf6
 Z6G5R8YhDKkarfHnXuCOCUET/TyrgGdgWEsN8VZyiQv3kxc0GNRHi2QmuFVZCQdw5U6EDMeFO7T
 Fy9aBUS75A1/4wRz/W7o0rW6EStVECMtEMzrmew==
X-Gm-Gg: ASbGnctdz95+jsIUJ5J6wgRNh46YToW8XwDuC72kaYaUhbDWrZTG4ZC8XVzB4HPNwt2
 itoENY0IQHpca1vi/24yk3yPhdebmEnKuHEJxb+ZQcLwBCJI57S9RcUzxg3Cd/+fN5jdW9LAd8K
 bU6ZbOxwmriVcUjoLicPB/5oiQ6g==
X-Google-Smtp-Source: AGHT+IGSG72TnswLiYFC6Rq6Io5Un4zplBMa/GlcbnPG3v3F7vkP1TasER1q7lLskjFTkSd63eE3KByzMVAcefIitII=
X-Received: by 2002:a2e:bcc4:0:b0:307:e0c3:5293 with SMTP id
 38308e7fff4ca-30de0302347mr883611fa.36.1743183512665; Fri, 28 Mar 2025
 10:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
In-Reply-To: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 28 Mar 2025 18:38:32 +0100
X-Gm-Features: AQ5f1JqGtg_eFAuzsQdQnCRWdnOuD153B37B-PWQvNZEiEatKwZ8H4_o4TlHxpY
Message-ID: <CA+GyqeZwrAaQ_7DcvY6VgnVo0WTsMBiZsKZBmWVzQu2CAL6_xQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] usb: gadget: f_mass_storage: Fix crashes on low
 memory devices
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 28 Mar 2025 19:13:21 +0100
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

On Fri, Mar 28, 2025 at 9:15=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
> This series fixes the above mentioned crash by introducing proper error
> handling and freeing the buffers in the unbind callback.

Hi Mattijs,

Thank you for the quick fix, I've tested on SAM9X60 with multiple ums
commands and it works.

Zixun
