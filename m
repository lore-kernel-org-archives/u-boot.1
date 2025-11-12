Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A33CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 12:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAB583C54;
	Wed, 12 Nov 2025 13:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b98O1+G9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD0683C5A; Wed, 12 Nov 2025 13:47:01 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5897883BDD
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78802ac2296so8543667b3.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 04:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762951618; x=1763556418; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQqlvEoUxZ2HtvuMjtg9KQ/23f0QnS5L/eFk4Hpo0QU=;
 b=b98O1+G9wlpVVYGRqrMp+2mTSN515ABasJsZKpvjmrYuhe7ZSKD3oHHDVTbJQLbVw4
 QhyT0YHTCOaNePqCfqu5sKjb2tf30nVxdz0Jek43CILTY8nHlZPUTjthRoJePEY41nay
 6FPWBBQVNFQ5Bgu0+V4LvN22oVvpA/BV5JB/rPt+fzQhG9XapbaZpdGlvUTZqT0L/7ZB
 PVTNQo0zWVMNUZUf1vKGghq84NVZgg+K1SStGSJwvZdExM1gXwNLKYC807MwK/1Hem4j
 kt4Vv389HYoegqF0WjdZaZn13RMF70x+uv0yuHQ9MppKe+rrFG0Ux/D95SpdgS6h3uxV
 TybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762951618; x=1763556418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LQqlvEoUxZ2HtvuMjtg9KQ/23f0QnS5L/eFk4Hpo0QU=;
 b=O6fgV7O1NKwflqvco72HpJCLH2BWWx+pW0XP4g0QbYzTEPfmaB02D4EzvKwuINzjse
 i92aCkbCII5VR3ByUClIOIfJdUdJcfN979wsaa0Y7Z9TuBF5GiMphbYzdR6p3d6XVhSH
 4jLl5V9JPkq09GSMRWsaH/HjqBb8SVr/G0IzHE8hor2KF303Y4jZRYvEvM897phLN3zG
 JvT+WzPJV1p2D7t3mD9uK93uD+OmJiNuFstMDW3CTyB3a0XEDan+fXJR38lIbXCc2tPV
 4ulGG0dGp67VUYqGVFXqxIgl+n8Hf2R5VSvnd+NrxqGSVkjoOWq9Ty/bMMxIvy0tysGK
 6lxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEiz1gIqE44Ns/2FBHjPTM1LFNJBuR1YtHL1wPNSkuC4Y84zmIMt+UaEyUmCGNn79ChaivLec=@lists.denx.de
X-Gm-Message-State: AOJu0YwvujyZjGNmxnUxGe64nujYtw3JQ2lJxKkE4iqF8nC7Slcq8JsA
 Tu25gAPTOJqvlxpgtQOC9LGuOVhoDwktq7V9dn6eO19/BEKLe+sZXFisLJ4bsEtamA2eSehgxuH
 gQm2tkoZaTqzGmswQ//jE4KdQZ00/ujJRBL61
X-Gm-Gg: ASbGncs9siCSHf73V2/zCMf7TWD8DaaKx3UcdHA2CnKFc6dBF5OEFIfd8THyOsAjr1d
 a7CvB0vfWFx1KuG9TpX0KVPPhozrXLNDW80Wu7Gomh/JD1FJBJsqBS4dWRGXo0mINcaEZE4MzHI
 eZP/418epTsCIWEDWbmqjmtMsKokbvHZsrXjczOslRj3D33pmOV6AiVmw4/jUrxLxdVGhrqNO26
 A6gcayuZTFipeYnljGiJVRJySJnlBuhnONi75Mj0DQsm5UJHMvcD7rtSVv6
X-Google-Smtp-Source: AGHT+IFbbpiDi8doVBBCrEmzBaTa2ETumRf+avKKsXcVOfNBn0OyfDBHWo+ZbXxAM3KOLZA399j4tFRJ4+dAtVsWCjk=
X-Received: by 2002:a05:690c:a6da:b0:787:f545:c520 with SMTP id
 00721157ae682-7881363a694mr18845397b3.30.1762951618130; Wed, 12 Nov 2025
 04:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20250911-fix_fit_zimage-v1-1-bd779ef56b22@gmail.com>
In-Reply-To: <20250911-fix_fit_zimage-v1-1-bd779ef56b22@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 12 Nov 2025 20:46:47 +0800
X-Gm-Features: AWmQ_bmBPzwYgHjJKp_R1P8iTEOxwbWa41vYhAxjeO83e5b4PBVeHKWeK0TeygQ
Message-ID: <CAEUhbmVJDegKW+aaewNS6UYrXYvB=u-Aj+2GyG6uMedNCjGKrg@mail.gmail.com>
Subject: Re: [PATCH] x86: boot: fix unreachable else branch in boot_prep_linux
To: Guillaume Ranquet <ranquet.guillaume@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Thu, Sep 11, 2025 at 9:35=E2=80=AFPM Guillaume Ranquet
<ranquet.guillaume@gmail.com> wrote:
>
> The else if branch uses the is_zimage boolean which is initialized to 0
> and never set before being tested here.
>
> remove the test on is_zimage to make this code reachable.
>
> Signed-off-by: Guillaume Ranquet <ranquet.guillaume@gmail.com>
> ---
>  arch/x86/lib/bootm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
