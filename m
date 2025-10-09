Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A90CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE91683952;
	Thu,  9 Oct 2025 14:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7sf3WLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD6883986; Thu,  9 Oct 2025 14:16:59 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C348393E
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 14:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-59070c9111eso1052919e87.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760012216; x=1760617016; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+kStDrPWqn+DG2aL6QZckl0V+yR5awI5FpGOjmb3iA=;
 b=L7sf3WLp9Cq84kV/JJKPst2uBHwOlsyUy3c1jNYdKRDHu+KZuYsXpkkw53lEYMCFV2
 FjbKtM/m2R85WtuM13FfWrS0HveXorcWL/rft1SA6Bzaqoo3HOHihYnRYa/STqK1jcGT
 fbOqH698WwezNG/QIscBvC4aVcVUlj5b3ZwH3lZFosyBzqWyCSFg/UBMmAnixBNjX2Cr
 C0yQIxaqQqljyAB9UvWgfccYyRYm5EgkIJ71bA0hnYkf/UUXBAeJwfATtM2rlac786pY
 girWcownaJetF32sKqcTpEJiEyBj480Prepff54sZr5HBkO2Ogpqj4HZKNZ9IJytDFqq
 dS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760012216; x=1760617016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+kStDrPWqn+DG2aL6QZckl0V+yR5awI5FpGOjmb3iA=;
 b=KUC941pHU2UnL0e5CTEdzP7YzXVWt4RdiOUahrSmz7vuxJXzkd2IrgdQwmJdnP/KCV
 afBtevu5skzi4imHTpBKmIp2pAE0r0fJtLvD9wxmZtlyZTQJDM1OYyfsRivfpwADq65e
 DGKGgH7FHeDJDbgcOvNCnpkQV+3f6aVq1uvFksbLrqxrCyH/CYv77BNCHtokTuBJkRMa
 obtAHCvgjsnd8MeHXyjwG+5KEqIppHu3DrLXd89uM6pbsR4W7khGCBF4jp9Do0zsifq1
 SB63Jk6Dln6D5iUggsbr9kvyaQnaMBeQkDD78UakSfGnLJcKWPK9zTitPAYpBZICF54/
 DGfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfebQIUWzDjeZEQ1zLaxF7mQjaTtdeRV3/svsNCKrzkp6EhNeziA3vyufoxrEZ0pX6cT6nQfU=@lists.denx.de
X-Gm-Message-State: AOJu0YyQtTDC+u56NCqCQ/XwfVRik4aNjC4EEeXW3an26TEb+6MxrtxH
 9Cs9eBrQntojF4e5Y67sXrk2ukuDnOcyQ3c7TRwcADlBcB+vc9p1hWjag6+Boa8X+fVRPF8iUYc
 oehd3DXopnUiCac0zIHaYFt6EvwqYGdU=
X-Gm-Gg: ASbGncsDIjpZIU8jTbkc4mSLTvEZufVnrVVkqMpq5wyMjrLyUZmzCMS8JrHYszUiEdm
 Zi4/FbnJVjjtabS3mKeldD25gdYK+HirMsg7vIiZ09vvDCafeWMVhxjzl9jwQd7Gfjgt6bayB8g
 Dnbv/0YXP5ZRaI1mMv78V6Mtx9y/qyHVsbg8TpPM7lbwGx+bjMNYJCREtU5nicUkpwVA+QXlFWm
 5sNbnM7/Z9kIBy8OorlmuMY/nzr5XHKapIq+ggbcWyr7kiXmve/W4CRrV+Pacs=
X-Google-Smtp-Source: AGHT+IEe+dgRJdZylbfv+lrsOtVxg1GKGDpcXz3o8PvgdPpu3sncqWPVHeNySHYe54RrLkwhWTcOdmVGKR9hN2s8QWw=
X-Received: by 2002:a05:6512:3991:b0:586:9636:6e4d with SMTP id
 2adb3069b0e04-5906daea554mr2045839e87.50.1760012216035; Thu, 09 Oct 2025
 05:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251009091719.187715-1-philippe.reynes@softathome.com>
In-Reply-To: <20251009091719.187715-1-philippe.reynes@softathome.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 09:16:42 -0300
X-Gm-Features: AS18NWC49xs7Hqurk_m91kf778i4BNnDhbdxglvyr1DEuP7qEk5dGpoTNM4MxLc
Message-ID: <CAOMZO5CGTiGUzhefRfhb0FbiurtV3vf3DASsUkgPBxpNCVa9tA@mail.gmail.com>
Subject: Re: [PATCH] net: bootp: Prevent buffer overflow to avoid leaking the
 RAM content
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
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

Hi Philippe,

On Thu, Oct 9, 2025 at 6:27=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> From: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> CVE-2024-42040 describes a possible buffer overflow when calling
> bootp_process_vendor() in bootp_handler() since the total length
> of the packet is passed to bootp_process_vendor() without being
> reduced to len-(offsetof(struct bootp_hdr,bp_vend)+4).
>
> The packet length is also checked against its minimum size to avoid
> reading data from struct bootp_hdr outside of the packet length.
>
> From: Paul HENRYS <paul.henrys_ext@softathome.com>

You don't need to duplicate the From line here.

> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>

You missed your Signed-off-by tag.
