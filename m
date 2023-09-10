Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA039EE57CD
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 10:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1678694A;
	Sun, 10 Sep 2023 12:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GDwG2j3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1108693D; Sun, 10 Sep 2023 12:54:19 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E31018693D
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52a40cf952dso4668321a12.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694343256; x=1694948056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AYQFJLY8hTRb4HcchiY40sO6KRXCyc16Z56esGGXhSI=;
 b=GDwG2j3XGmBEnl2vvjukHjji6mFohLcPoIjqgxOyV+24tkTFI1DCi3zfDYijPEWXUy
 nBOYHW2+nkMor9fCvMKQbYDechAtZxCnUeuZuLTTfD5YT7Y7diLOuKltrsth2pk6POJj
 +IRvnyRYNp39aHUP4Ld6VjY/utINDd2usjLWP0yng6ouGUDf5s0qPx46sIzerv5RnlkO
 tXzWHiECV2FStUOQ4sDl9s47DioSTkrwT3JBrfs0uwZeVaZFur6G4iWR/toI+1BUDmvQ
 ExNzXmv2dADVgF6TGHc8j8whg3X4MnezGzUb1NaCGMWi/5iDMjbmfcrwbLm3olq4WZvf
 vXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694343256; x=1694948056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYQFJLY8hTRb4HcchiY40sO6KRXCyc16Z56esGGXhSI=;
 b=O7mZIZFatKlliDdfpWQ8pwdYmcFJxSy6uOSyAAzEnov/jLmjz+sd6YM9sg279VFyoO
 1SfwamYC7nAGLtH8coTeqeO5nxBS5xSniTrBN3AB7KQ4WIAJZPiJUBjqNFiGTZJL+U9e
 1nPePPZ8bta/797rbklx6WHBwmr7Y1QWHGWX7qy/959SDSc0lsn+3mEGbFrXnH52pY6+
 /sMUCjCA2iIyKQozfhu/eFgGOAWmeGMmugtqc70I9q9wzJciPdDcYIyV/UT49rxwYyh8
 0Z+s98E9RWEHjKtz2gjNTVkGK7WWcnE8ff9pwOZvThbm4lok1ic3awNYAMEw/Ox28GGX
 PepQ==
X-Gm-Message-State: AOJu0Yy1LyrBzWLZ8JGMUCDaT2fFDAfl7tQC+Wv4WOX6Gqgvp1zT/b3s
 T4U40qgTbqnKycQ0H0dPqbicEtC87OBQIflWeafiIw==
X-Google-Smtp-Source: AGHT+IFqgWGU1dZD7emB8aSnKO5Ye242Dq4fK0JvROOFef8B81+xwnbBVCO6Aw9BisGs2DOYINIs6y5Luwu+kJOl8hY=
X-Received: by 2002:aa7:c40e:0:b0:523:102f:3ce0 with SMTP id
 j14-20020aa7c40e000000b00523102f3ce0mr5409070edq.21.1694343256394; Sun, 10
 Sep 2023 03:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ11KEV4TAjihfijFNpXmROheGPKmVwVvpgfOpZP7GZ-HA@mail.gmail.com>
In-Reply-To: <CAPnjgZ11KEV4TAjihfijFNpXmROheGPKmVwVvpgfOpZP7GZ-HA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sun, 10 Sep 2023 16:24:05 +0530
Message-ID: <CADg8p97FOq4ropKF1xbMzBQb6O-QWpJCb5_zyq3Nyjhn4kBH6w@mail.gmail.com>
Subject: Re: UEFI update files missing on sandbox?
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

hi Simon,

On Sun, 10 Sept 2023 at 04:10, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> I thought that all your patches were merged but now when I build
> sandbox I don't see the capsule-update files generated. Is there
> something missing?

The building of the EFI capsules was moved to the corresponding test
setup. This was based on feedback from Tom Rini [1], where he had
suggested that instead of having the binman nodes for the capsules as
part of the sandbox dtb, it should rather be highlighted in the
document.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2023-August/526987.html
