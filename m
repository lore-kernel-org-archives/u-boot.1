Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8138ACD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 030F8846D7;
	Sun, 10 May 2026 19:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BADU82xS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D372E846DF; Sun, 10 May 2026 19:41:57 +0200 (CEST)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C553846D1
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2f7020a928eso4753955eec.1
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 10:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778434914; cv=none;
 d=google.com; s=arc-20240605;
 b=KGvsDFOwyZ01ZJfFHEI6P0JOI8wCJURgWcbkRPVJ9peB+hact1hSpthQtTuZC3vC6v
 +f4e5EPTKGO3CjNMeFUU8X3WrZNGbuywiA85t/Eq5WIfNtD2U0oPT+s1U7pFk6uZVqZ2
 KmNnQqVahli6GxFrZX1IUi2cjpmbpb2BF5oo8Jyurf5vMAg2Hwdqh/QmB6DrU3WWs7Ag
 vc3Ab9KBIUa9RftundDEeuZzzhZWvT+diqVtqeuQAy0QtnIq3Ofi9oX/kC+MVDltk4lt
 BxmDmisVkzNyF/Yc5s/E0Fcym8VolC8/MZBBwg1TXUof9q48EZiNLmbpfV3kqMIcN3Bl
 elTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9UJZ5+Zc1695UYxJUExPKihw/dg8w4Mx0PwTTjboMGg=;
 fh=sORswngItSTTjaoiFSPwkWb/jWzb7bXn9OLerw6EoiE=;
 b=DVr73l1RB+t+ixVP+pln6obqqeNcrsovr4yMxUUQuCEuwGr3IaMQ4qs7oo7ZJr2tqU
 KlaLIGN6SQats+T7moqQzXAv+RJqsyQ2YTpFiXie/he6d5F/MUfQnzgBgnx9dwjxNArx
 nH91MElPeOBPns24pYwmNgcL/0WI7D1f+lhRXPQgX67lxCork2WMi37At53JZBc0rTAa
 cI7fh3aqbiFvy8So9xcZlgKXVpkN9qaM8d5P4MLiGh0RFEroK0t2LZd2Ju7Gy/vDSh8E
 uGBCRYOBlT6kklCnfiFGS2k8SF14gWdFYmYmHO62S7P63BUD3KpX3zV1dPVDhAyNAPEv
 jDkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778434914; x=1779039714; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UJZ5+Zc1695UYxJUExPKihw/dg8w4Mx0PwTTjboMGg=;
 b=BADU82xSz7w++PdPzC2K6GeLuf9rSDk6juS8j7+iPmAtQWYR5QuLZNrlYCIaGPw/TQ
 gXoMCApjay2x+KuZQ9w4i6YAX+HUikvPaVjWmp1NEe8Cpnb7n2BLkkWIClx3EohGKROE
 UkQhcifYZ2tvyDnGPj5iI+mdT3/8nF+1LmOHzcj7TaGrL8J/UNIis+UB4RapVQEtf5tR
 ee5auwCygSZGdbKv8Jj38M6ZD66d0LslLHkHctv+7yH4sWQOO4ZhJi1Db0qCF6zVCDnm
 WvH1ezuBYfAroIlW/6KQW1JlsiLWYYDf7nyEg8spvqVA7Sr5zbWE5j34tKhAfPHEc4B1
 AO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778434914; x=1779039714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9UJZ5+Zc1695UYxJUExPKihw/dg8w4Mx0PwTTjboMGg=;
 b=lh9c51kSaRgEzrQJynQuRp4/gqEhuHul53mZU7q0wx19ocwP/EX3pd0e8s1dRrwgvB
 9ZtPuuxxOho65OSFrhUHV+qIfSSbQfJhLehYS8uvCLL3thjijl2dHSZs3EkHuYR64AwC
 H0HNXbJ4jEA4CPlYXTfbHk6YCp6FshS4yt3N98rIjCmlbiaYX8/HIYeeYPlO14wFd5PN
 V1QWAAnEPj5oOHRx3h48vvS/dLAv9Pf7nN4VEfU1ZFkgqqR/JWR+49TeDjdq0sCCndcd
 IjazJRdNjFLP5x8JKc5/ZGYc6LgFXRBxMwWm8aElth6FtW389S5vwwcqptos7sqtIe3L
 5xGA==
X-Gm-Message-State: AOJu0YwEGaEonQivt9C0yFY8vHCeNihqXAvLA+LjVMgK4GgmsS2brioB
 YgVOUfKlYBm3Okm718jw4hkZefDXoMhCozQrBiIEefFyrZ+JSelvKJ2ACTutlTzjNdFTpRP0+Eg
 8th+LBf6drSHm5H+MqawROWFYlo1epRg=
X-Gm-Gg: Acq92OGaoJZNZkpRVB3Iuuku93WcAp/aSGTSshbb5/4goeX+KgmkJRRMaa0bNKFtpzq
 Kut+FUwEMhn42xo4/N+AhH+uEGb4AtdNQGIl0lTF40pxUZwkSgG+OeYfat+OolFM3TgvzzpS9h4
 FsXkBMAoIg0SyxK81vBEjUpsziZdtnDksarxNBA8QpZxGwDVpPJHjpV+r0UAcAEKwbLf4GT5aee
 HR9Nw2Q2+zf7h1bleUZQtukL1fFalylohfOZ5UPIiiYXvTtqZUg6iJRBr4K0n3Ky0GGuM719Cr7
 OeBVRhYO5K3+hDT3ce0=
X-Received: by 2002:a05:7300:a887:b0:2da:1a81:588 with SMTP id
 5a478bee46e88-2f5493930a7mr10966757eec.14.1778434913752; Sun, 10 May 2026
 10:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-11-marek.vasut+renesas@mailbox.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 10 May 2026 20:41:42 +0300
X-Gm-Features: AVHnY4JYXCmPxbL8Ji36o460_o-PdHRTBCne1aGmxIZyzpnNqJTaoiAcCxNZfgc
Message-ID: <CAPVz0n1ZMBF-YyQAJ4xO4T=BvhgfzVXcFQkMg=+iCc3mB8ub+A@mail.gmail.com>
Subject: Re: [PATCH 11/11] video: tegra: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>
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

=D0=BD=D0=B4, 10 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 20:1=
7 Marek Vasut <marek.vasut+renesas@mailbox.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/video/tegra/dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>

Thank you!
