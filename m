Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A83F94CB7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0DC8352B;
	Wed, 22 Apr 2026 03:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A/qoiX7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F570805D7; Wed, 22 Apr 2026 03:16:11 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A43184198
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82f0884bcfaso3466578b3a.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820568; cv=none;
 d=google.com; s=arc-20240605;
 b=SlcXgwTt8LzBKHzniznbYQcFbGtNXmbQU8wM6Qb7Xo6DA8nglcYyFc738h4kkKM27d
 gklD4tuPO9K7iBterrYUGG99hDpOU7/FwBc6QyLm86rohKLKBnszr5x9FmC7FwqlJv2O
 VZq+0lMW5sLi3WnwK6JJTBOxBidY2MC+YRlPz33j1EJsnfwRV/6gTwmzovKeNb16sgsW
 0BB+5JmqeWJ1BbmcmKdKeQ9GV39RXrKY7uqXdOf9Ta/Hy+C0tVJflt3sGFBFqCgG/cuX
 9yddV83RgpXbt8KLtjwyoWLzdWX8zhaSFPqtCdodS7CQQmW64CKdQrXAC5KtdWwUW7j8
 08ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=waPxNdbZii8GSinrg6Xd0GapDCdKT8M9gtanvPnLBig=;
 fh=phVN0hR9p+tXKrDBspdyL2SbWphOksAevCzGYC6/ufo=;
 b=VwIG9NzP2fVDiSDyFwsbHAFmOScGp4BlSBDfz47OfXkWfu+nINkt8D9xk5C+6YzHpR
 qxNVZdYK1xvo0FB+/D8nnKPe4rNsh+WPuURYOA+CbqhuQlRughMrocPDObCRSphso4UQ
 s35+eAdc67mFxSmEnXSGUcAKKtdkwSIv/UV42/hO0MGv64BPWblj5t+nx3GvTOHuSrTU
 0y7ZQyqddjhJml9dWJnHV7rXlqyjgIDykR1kC7ij7XehtbxERrUBeHwasEhuHp1+hOop
 qHeFsFGZ1yTx9lNzXyd5zgKIPiFxpVbq8KOrQMlhb81y3Djj0W6CM/cNvrk+pT6AjXE/
 vqYA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820568; x=1777425368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=waPxNdbZii8GSinrg6Xd0GapDCdKT8M9gtanvPnLBig=;
 b=A/qoiX7f/mNt6qjsTj/va7/xwKW4tjz6PkN+EtgtkcOPkMVU26Jwjxu5Qdi/2FcDDj
 Y2mXeBt5P16yU3z5xwdJ3rqbiOD549F0Jnu/pnZJStj/2INjYuwkyP+wc/KS6sDcwqO2
 r9zUr4Y6URWcBJE7sXbzYwBJxlBRhHtTTiO7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820568; x=1777425368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waPxNdbZii8GSinrg6Xd0GapDCdKT8M9gtanvPnLBig=;
 b=YrjZzxohhiTplNoxo6qsluX9NvXspMR7F1EO7fzyVaQLtWWU5O5JCF1jTIb0mOuR6C
 s+5wIASpJE/AJshOTKch4ENMjGCeYiDUjmJEHO1ZM2S7A+XU/Xsk089U6xEHrj2pEOeB
 3FAzcg92r35NZsO+Kyic77Pad7UIFZ+IqfStkryqkN0nmls8gXXy0xvEhMaKTGKvGsvl
 IFIPK0xvKUuuF+W78SklEjKWHIpMVDZrHPT/TfYQGBpehPOyeAstu7OrER0ErtUQOHqX
 tWVj2F4avJsU1J0+jhKBYL4kROFCT8ccDC2zKcMxB83Uwx64Rsfi9fJfJny9E3YD2nel
 JHxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xHgmC3BguM0fxz+d6bKTqHwMQ1HLDGPoYqUr8yElU//di+heTqSLbJQnfTrZrrqvPX27SdK0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+DtejJt5q+Xs6gsUXM2EiMIQJiKTAXwQGLbHkdCMzHPk+eoiI
 fQEHL1LL9F3JhoL5eP6CfpObtCAyM7SCLvZxuyx8LWU7rk1DFvWXPTS8GAT/Y5HuhN0Tf7Cf5Oy
 fmiAhug2jZPZL640hfcsBwYzQRavDZhEnQIA4CE0i
X-Gm-Gg: AeBDiespNMCRJ6omanJil87tw4p3TCgQZKtKI7GzLsgl9U+0+G2J+xXvIuprOldtlg7
 o+cYLa/qv10BTdwX8EGRCFCzfPFSZui7i/OQHtKsxHRB6gB74GT9ZoFrd434QO6AzkHWjDoTqcr
 Nsu/JMULR4OY3uBs+OX+y9cQPgcz6u5Riog0JD/vSbLDIdujKtksJUm8h7oIN6eyAv2+9RWCyUD
 YT3qIY+UsUggnPJ19qzwqPKGf4YlmNkakRDM2vAymgsto9hAcB0ZfLTRNEHdyBv7X2kpRMz07SV
 4iAq/cMOOji7RdSXFeapE8J9JhdbRrY=
X-Received: by 2002:a05:6a00:1742:b0:82c:21a9:872c with SMTP id
 d2e1a72fcca58-82f8c7daee3mr21754267b3a.7.1776820567453; Tue, 21 Apr 2026
 18:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg+nfKGCaHGz6-GHoQ+KntLYYdUTZqfYGpBdsvLSW9FZQ@mail.gmail.com>
 <0c112980-e5db-4acc-97df-c1097c41112b@mailbox.org>
In-Reply-To: <0c112980-e5db-4acc-97df-c1097c41112b@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:15:37 +1200
X-Gm-Features: AQROBzDUsXO46LaaHXKN0NeRiMOYsqlXGHFrnypW_6893cKLVWK-7mel51je7s0
Message-ID: <CAFLszTgV6L=G2-MpBgYh3h=4QM0r0V-aLueS3zUgTCTx3YmcpA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, 
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Marek,

On Tue, 21 Apr 2026 at 12:48, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/20/26 6:14 AM, Simon Glass wrote:
> > On 2026-04-20T01:23:26, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> >> kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
> >>
> >> The fdtgrep command will reduce the DT to minimum size, thus eliminating
> >> the extra padding configured via CONFIG_SYS_DTC_PAD_BYTES. Reinstate the
> >> extra padding by running the output DTB from fdtgrep through DTC with the
> >> -p CONFIG_SYS_DTC_PAD_BYTES flag again in case CONFIG_SYS_DTC_PAD_BYTES
> >> is not zero.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>
> >> scripts/Makefile.lib | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Is this something which can be added into fdtgrep itself btw ?

Yes I'm sure that would be possible: perhaps a flag to maintain the
same padding as it finds in the input file.

Regards,
Simon
