Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792A9F327BD
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102E184390;
	Tue, 21 Apr 2026 09:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SZk3ml1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C6738439F; Tue, 21 Apr 2026 09:59:56 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E82984378
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so694436466b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776758394; cv=none;
 d=google.com; s=arc-20240605;
 b=Zu4fbGiKqEcw4vx9CVDP6aUkcDJdZi35Op6HUlHuLR3ED8bmw0cXCucUhrnA5wvjJ2
 09z2qlBZTRVRNvg63seAmLB4jG9hVnSQx3Hp5POu9JRllOkENZnKI1XOlRZscNNPrtpC
 Wef2RSHEc44Wve4NBc8XY8wTef//AdBcR3nl1/5r0Sx7JA0exQY8ar9ZxbaGs2pqMKwS
 qYRg5Gezvpr6hOrTwvkfgHXqf4Ju34AyoS8Z7+h9luZV2QfBGKIPiyxkyT7KQEpn9Epq
 mIn+8oNefGgLj6IWqsM6iSw2FBaMgRt13bxpO+DWf57t2HLqxYIZXJ2Jjrk3sAWyUTGI
 5FNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6/gz0kvBY/N2bbyG1adnGxhsYPtusN4lKNzrGzI6Oi0=;
 fh=Oe9lwRzKCD/l6hCUJFguze7oQy/y4G6mlumC1KMfZJ4=;
 b=adhgwOiVobWBbXW1c0ViGb886N9sl3PLoXMpJKPyf6UFafujdxlqxd3CdN+1KTRWVG
 zqXm53xstdFdnNRV3HOnauCMqf/itowdmnNPsZlq47PhI8m4PtgNPflu0DZbkMYd8yFm
 SuLDS7xQHvzRruwMbMLTYYSiX7LidyU71mxL8X6dg44WaT1jvQFINQyiTrJXuTjFFfQU
 tXDG3mV/wP2Q+S69fGI94SjHuHGfyt5zJqlB3FIoNsEfduMPHL2SCN3ZY+SeK9vXG32K
 fR1KCFlNZg3pCjCQJUrrzrtOG6o+FpGpTdh3p7WaBDPFnGTFHxGOEkkj2ZoPkVEqSdr2
 fHOQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776758394; x=1777363194; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6/gz0kvBY/N2bbyG1adnGxhsYPtusN4lKNzrGzI6Oi0=;
 b=SZk3ml1LE6PA0VO9guvUah8go6+Vf8dvINNWRIFXn1FLFC6SWVbZe37uT1c+Tot6l1
 zMhOanT8fzychuGRakBYic3PyYgxV9eyVB1ujVhfzc7sqxlrA07leYufNvz4+r/UYCys
 VjrImBr6aRFXiaSKYb8UbCt9Qj1l9Fhy+q+zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758394; x=1777363194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/gz0kvBY/N2bbyG1adnGxhsYPtusN4lKNzrGzI6Oi0=;
 b=iceT4ue38mHjhYWO9lfDScgteP6+pn/fFPliQdBcOVZCugxU/4LKgFLo359hS53Lwy
 4WlvHRuW0DLb0M0HOzQ3c0bDrpr+kHIH4/B/gY1NHUQjrEqrUEXVm1V8rYryqPGafUPx
 owxJ4ukpwDsEXwxjf63w3bV4HVogBbWaMLO86Y5RM2SClj+e2fAQEZ25a4D+bDwMK01e
 6LtzzsISFnUwNRLQo5A8MksFumuycu7ipKRm7H0RmBlI2hUPqdCXk9IV6SbiL4GqZsQ3
 5cvsj9pWuAISw/D5HobnXHLHXXrkcwD5f1FdfjcJyL+w2kNDXu7fRvZyyXNHx6BWd/kL
 l03g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Oc6CLYfoN/3DPIDUZS/+Z7ZaYd9O3V5aGG7etLv6iNZmyYbAdTmrFECyt4HYB0z/WlXR4258=@lists.denx.de
X-Gm-Message-State: AOJu0YzmxiL/kSmwpJUJzWSgZgizqExjww3LlKjPzJ+Po09aPadrwf3T
 3RHK6Tmjd8UQiS+1blX8Qr9F7bN4H9rklgFb3XmW5TH0qcz8+6kpumtyaceWtPV5MjJbeLmZucz
 m6kxmf+PfluK+cK6ckigWrFxx0wAnf0UCvB0gPt/H
X-Gm-Gg: AeBDievuL21YQC/s3j9eFP7wxTJmo2JZnwkPDOLgJHOzOuy0QFCNo/kFfoufejPC8Fo
 y8DWFO1IG6wjQIKAQ7j5wMEtTayr1zcXobQIlwN32icyVO7hPpa095iY+3zMZT8IgjI2/xtVi2L
 pFL/y/HPY14nGI6jKyWLSHN4szljywkwps85L0QPvJ3TqLcNkJAj15MMn2ik5ydmuF1xgc+7i61
 Qf5r9V5OYYTScHqPi/GRo4A5bzLoMc8IxLyK2EPhNGoY1SK1BIwltRKiW9qzjQAMuRKZZxfJbxr
 OTetYcxlrtVqXgbfbdBv
X-Received: by 2002:a17:907:96a1:b0:ba9:2137:7165 with SMTP id
 a640c23a62f3a-ba92146ccc2mr191453766b.1.1776758393549; Tue, 21 Apr 2026
 00:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
 <20260420220321.71147-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220321.71147-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 19:59:40 +1200
X-Gm-Features: AQROBzAkgD8DIWwEVbGqlI1iD6IfajMsfGMjDSWEXjIojGs2_S2lrVot2e0gq5U
Message-ID: <CAFLszTjhcEtmCa3HN8SXniP_H6QFbhOHA0stVqVLuLe5jQ_RiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] efi_loader: correct return value of
 efi_bootmgr_run()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>, 
 Ying-Chun Liu <paul.liu@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 2026-04-20T22:03:17, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
> efi_loader: correct return value of efi_bootmgr_run()
>
> efi_bootmgr_run() is expected to return an efi_status_t value.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Fixes: 0bef4b0123f2 ("cmd: bootefi: move library interfaces under
lib/efi_loader")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/efi_bootmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
