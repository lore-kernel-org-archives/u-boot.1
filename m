Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2B5F94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330B184370;
	Wed, 22 Apr 2026 00:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eOCzklTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11278437E; Wed, 22 Apr 2026 00:51:57 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E389083AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba3b9601b97so682422066b.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811915; cv=none;
 d=google.com; s=arc-20240605;
 b=hPOVrG/AhF9VUR1SysdQCUvbqvdStFXoKsj2dsC25RXGGPRn8zv9KVUNIrh0Ka258a
 bTkvQyUXtnykiTToT6FhZaEIEwVZiM5vCXDPbOQAuzayajVOhiI/d+EcmVdvoGshIzi4
 l2jLFAMnZ8SprUp7VstcMFbiy2gu+/OvJ96Vt5idih3LhePOBSBmUVVhDDFjQW0G5xe9
 +TmE71gq/4XPNzvJ2nVzi9lBgGNKUDvgFuHhtoBbYrl7b2REEJREH82fWNn/KbLZynPK
 ViHbCnZfmZA5lOJQLwvbXqQmnbvvsSCPHloeKnjUW4rhTJpGwZ+okz2SCbN/tEaR/0Kq
 ykkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=642IkVE2wQ8EzOzQ8JLH1Fez3QREvc98BKPt5Pytcio=;
 fh=T79q7iQaKgdBLSTuhvl3jRYD2v6g+8MB8Joags6q2NI=;
 b=KPQallSmQm849WjuNVfyjmorBAjTh/DFCWOdmh33J6Kj/iEIHAqDnirt41PJkz28g8
 3l4Riha7fnA0Mx3ChQAPD/QsC83/BcjhrA57tdT7RN9ZUy7g3O0XR0mJCcbnTbofYxY9
 4TRPmtXVmX6f0OM9P7to2N3VYTnT3wC/PeAzl4bemMHnpl/koRr71/32iWLqGKwsIgYj
 DMoxsXT4zubeR40Y004z16fwnuaxgVXYs3NZ2iOPpH5PPawABNxGOMf/gJK5OdTqXC7x
 uxpz66eEX8Jue/8KBLmAnKfiB2LBVe+xgHCe3KirKoEQivuHu0lDWsG+aCXgAkVW4i+O
 wnrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811915; x=1777416715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=642IkVE2wQ8EzOzQ8JLH1Fez3QREvc98BKPt5Pytcio=;
 b=eOCzklTssF1WzL0t+/ZSU+XMGgJ/3PwSktFNIBc7wNklc+gu7cbFP1pvz8rI2X1hms
 WlzZ7zjQrSYVJaNGXXQcefutzSxN9FYfSppIuMTIeUP58NKN080f5SOG+kXaEx3IC3Qf
 WWTJmVLHLqW3VnUHLJ9O+VQjFmOeJuNY4TQnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811915; x=1777416715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=642IkVE2wQ8EzOzQ8JLH1Fez3QREvc98BKPt5Pytcio=;
 b=Pp7WPmVq2oCXfHWiF0UUc+wyb+eKoBydKaDBkTaXu2Te90xVUhvnExIhDbdgbcZAKC
 wbQ1/nfYImFXQ5TZ0jzNPgc0+PeEsvI6q9d3CMzqthU5Asra7n3PesGd5O6DaoVOMrhN
 NYsCOWhlwzwm4fP7EKI0HiIHhHP/huxUPOt32dmtm2vdJ/RxII2HQr/Kh6B4VKDHXNgw
 oguoZUe1YRzoFupJKrP+uTjRPY3rz30jjTc6MLDQkY4dz/jj+RguYRGg7sBIc47p62qa
 shlxX99XYSEIuBH7Ddq5rP7LWNAkJMyfXKN1xkqSGliKwRcuNdO1TEb7ObfiCpOfCAvN
 SG5g==
X-Gm-Message-State: AOJu0Yx3/vHePz3isuhMUjoEJYB89TTkF9nbujINVkxgY+l1uSCWdv0p
 x4VohwrnWcRlfSGhbG4cL3M5LYQKyZSdfx6p1KHHLM27PBnGavfT09U3uUtJeV5zTIFftsVwtNi
 vqg2eDg+TRiS/AKaA1WLY7lvTdDlq1MnN4rEi7EEbsSAfLOWZ3FTtaw==
X-Gm-Gg: AeBDietaOC0Eu2bMp/ki/vqUE6O2yFjxGdsLxXRr3+J705FYGuGQMvEENuaw26g5W6W
 zP22Mf/6hY6mVStDezMtJh2YReE/qDcVW2eU4AtEujI3CDS3XHlmwyO2r0kn1gL46fxpZlcTft6
 UVjOpfpnhMoQJ6yLQeLozC8U2g1x7Kwp3tH5CxHqlOG9fagNWT78GU+xp7NwDVobAW8yCSdhMgd
 O4CRCiMvy/vmVAV9C5fo1pEryRU7b88aTukWaEfv28F5XUk1/8uAwrkFoxnDb1w63C7ni5zK/rV
 WJglF+FyII07EVBpAeDy
X-Received: by 2002:a17:907:94d2:b0:b96:dec7:5209 with SMTP id
 a640c23a62f3a-ba4197530b7mr1005834766b.17.1776811915288; Tue, 21 Apr 2026
 15:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-6-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-6-eaa81288e393@traverse.com.au>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:51:36 +1200
X-Gm-Features: AQROBzCTm_mZtWPQbmZbLF7YT-ynvHxqFzJ675fn5R5yCMtCEpa2XPl9sgG6Bf0
Message-ID: <CAFLszTjDe+2StrD7QJ6-kV0yitRrNtsw=CFYH-f8pAgOuo9P+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] configs: ten64: switch to OF_UPSTREAM
To: matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> configs: ten64: switch to OF_UPSTREAM
>
> Two recent additions to the mainline device tree allow us
> to switch away from the local U-Boot copy:
>
> * Board/embedded controller (traverse,ten64-controller)
>   is now in the mainline device tree.
> * USB Hub (USB5744) connections were also added to
>   the mainline device tree but not in U-Boot.
>
> The LS1088A and Ten64 device trees in U-Boot were actually
> 'synced' to mainline some time ago, so the content
> (except for the changes mentioned above) is identical.
>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>
> configs/ten64_tfa_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
