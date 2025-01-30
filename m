Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBAFC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 20:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 113A980EBA;
	Thu, 30 Jan 2025 21:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LcXCAwwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4972B820FE; Thu, 30 Jan 2025 21:04:52 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 329C780EB6
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 21:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30615661f98so13802061fa.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 12:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738267489; x=1738872289; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yVsrqbGBpibU6C7LZVlr37Irj2dWqEkxoB4ovwQMGQ=;
 b=LcXCAwwDnkWF2XkRpUKM+gzMfhN5jlu3IIaXoGuEFWSrCKJcQo7QBsmgXcJRhM0KlU
 4OvM7DEifzZp2u/DM+84RWuttt+M2qN/6lsj4ffbFxnk/8R0Inaic50zalJQc0EgUg/T
 3KllssT4N8vcbZWdGFNwDgozvpzenXLVecoeUHu8XQrMmPp5aEQUwMHpyKf0usUGvSDD
 qyxOcfmpNInVuSnU6kmZommHpt+UNQ6DKuzZJswV7OfUdIMEt2T5fDvvEvOGdt05wdxW
 09Uj1QWDKbyp05SwfkHCIpoklt+585kHUDslXQqfZgclMYkl4GxsBT/d5S9GA1rD9Lii
 d6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738267489; x=1738872289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yVsrqbGBpibU6C7LZVlr37Irj2dWqEkxoB4ovwQMGQ=;
 b=E4J54AIvWEwfThkDih9Lji+AgxBWSN4/eyty7bPNLNFmt7eNWAl28gFGKp8lHuo+bD
 DdKFZWtBNrmR/GD3t+BScKF/qOU+ajautrRHRCxG4A0/xBfzl5rzgB5H1c92vGrNavx/
 1GpIaNSmxw1PNaT015rOTxFe8wUntqQwoaL5y/VVfNF6CYltqmfWIo4hWl0bpjEYj9RB
 78En11A9e7xcYOSKKmS6Nfs+1FitD7pf6CRqZ1fPpd/Av94iAPnhVtDJvTWwdEPhqCeK
 a9dw0PsUpUNFyBFu6LDVITUmNFTal7MBqvjXmlMOUYeqbucDOigYfnPQqQbnAPJC97E2
 5qQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFhgP/NCeRWckNepEd7Uduv8vaE5KrcFzxHmtMh9yP7cUzYev4JlfTTH+eHPFF/NffCFfUkCc=@lists.denx.de
X-Gm-Message-State: AOJu0YxzbVbvW2aR11ubVPgDPfW8KLTWaYNPQcNhzmNrxpM+AxHcoUN6
 umngemWQz3n9pcy+PIPuflQvcB3HiDrYYsNkf1teiv9+9Y/ksgHB5iF11Cc3F3WXFS4w1XBTzVj
 RLRNDtfgSnB7AZc/3+aj4l5ZSxQs=
X-Gm-Gg: ASbGncsV3OHYF4fYQLAXkOAjr4c7LvpQRBTCrPZIu/o72AFo6BUUO1B6oJguJg+OPcA
 ua6TreXkcgncdtUQt8SivLshuI+vcrcDO6+t8mHPRZ0ihPPYxzipW00uLV7QyrWZ010NheX7dO9
 v9VylizgbZUHXHdAxUcV4AKdtMZcJq
X-Google-Smtp-Source: AGHT+IGA9Dco6opVv7fwO43vt91PTT/+2h2URGDSWM9AVo6jijIyRcz07RBu+Ui+eKAf9JMifEtWBhnliimTJWoc45w=
X-Received: by 2002:a2e:9fc2:0:b0:300:324e:3504 with SMTP id
 38308e7fff4ca-3079695145bmr39877871fa.27.1738267489002; Thu, 30 Jan 2025
 12:04:49 -0800 (PST)
MIME-Version: 1.0
References: <tencent_E08F4B0FE7E0151B543039103D26CCA4B306@qq.com>
In-Reply-To: <tencent_E08F4B0FE7E0151B543039103D26CCA4B306@qq.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Jan 2025 17:04:37 -0300
X-Gm-Features: AWEUYZlzEsnk-mFiPn3K91eE-RraeAwYSnEi33hKHs1HhmIE6btfTxo_uM_EkoM
Message-ID: <CAOMZO5CCuGx4gwq-WqYxgcU-kCz7t9Bi9OPhjG0nWhwWrD=UbQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm: Other boards should not show this option in
 menuconfig
To: 1425075683@qq.com
Cc: Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Liya,

On Wed, Jan 29, 2025 at 10:30=E2=80=AFPM <1425075683@qq.com> wrote:
>
> From: Liya Huang <1425075683@qq.com>
>
> When I was using STM32 board,
> this option appeared in menuconfig and caused me trouble.
> I observed that the root cause was that
> the option was not included in the endif,
> but when I tried to fix it,
> an error occurred.
> I didn't find a solution.
> Only deponds can be used for hiding

The change looks good, but the Subject and commit log could be improved.

In the Subject line, you can put:

siemens: common: Make DDR_SI_TEST depend on TARGET_CAPRICORN

In the commit log:

The DDR_SI_TEST config option is only relevant to the i.MX8 Capricorn
board.

Make DDR_SI_TEST depend on DDR_SI_TEST so that it does not show up
on other targets.

Could you send a v2 with these changes?
