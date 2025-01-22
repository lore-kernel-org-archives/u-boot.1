Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DE8C0218C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7022E807D6;
	Wed, 22 Jan 2025 14:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qZcYhXPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EEFF80805; Wed, 22 Jan 2025 14:19:59 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0099803B5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 14:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-540218726d5so6713089e87.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 05:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737551996; x=1738156796; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMGleCqh4gHjYkh6KvZgd4E/7K1OyFDOlqjKirbrsLY=;
 b=qZcYhXPVdhDVsAU9Uy6QY6JJ53vg1eW5VILMMa13N66K2qBQUOf8xJtevomYCKRHxQ
 o/53ikKAYNLQuPhEJyo3WDzR+vhS3fKOWzigCVCiy1xhmChAeo1Y3gTghpWENFQEz6Gq
 A/QxNUTjt87PLrFfDAEdyr6HKnNPGqaLkk46mPU0zX/VehIpWm0bEn6+D4gHvPf0+5ng
 ruCwZNy2u6SMkDI8oS7NvQ4RoSVjrRz0S4zHY1gDLxTfNjlYMV+Ujo/tif1MDIM7nD7c
 8yaWUYIB4URTM42Y6Ja+ip7I5Gu6EAMIaK4fCeOY0yb/NHK5ml8PfLfwIoMTIYIv6Y1F
 3QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737551996; x=1738156796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMGleCqh4gHjYkh6KvZgd4E/7K1OyFDOlqjKirbrsLY=;
 b=Pqb/oiCTHrYEbazMdI3mnXf08Sp4053zr27vtYsVsYuLQk/sSwwu7D7gWV28Ap1/Ef
 0yuMNpzMigLQL/eu3kGN1w/D5OQf94fUHPVi1LMJte/2lAC2CX37i8Q+9rN3zJlSNq4m
 DbCTdOzc/5fCDLejOVcEU89CvDx2Tiy+8zlBrKIOUNypYCxbU2SF0cx+7DIp2jIM9HB6
 ZD/XS/CgQL8ixOSTztH6mMz/F2YPByxgo0CHvvDJcXwsINSHltmCboYT0m562XI2X4ck
 TH+YX+u7D4bUnj0wtBhy1rgpX49+1CnybPG5T7Y7VxFEjVEHty0dnG8LkxedbAeyqqs7
 u9CQ==
X-Gm-Message-State: AOJu0YzwuX595kts2jgmIkNe+JUgEaa7HfjkNmyYfz6YFNDij3fPhCE/
 QnT0naqyObBSrO+9n4r22Hj2CDxAemn5k548UiB1z3zmrTSJZUFHWsdcY4Vj32J6VuXkhv/yNeQ
 PRMAcZ7n05EmRs/x83KlcAMIe05++KncnU+3XPw==
X-Gm-Gg: ASbGncuMyFbBk1iBKU+yLwW/ALz+LQZOVKiCv2pw5f5Mx2dXDs8gM4wKiXcIUt6n00D
 4gZHIZ+lKm2ZN3VWm2fucxFy3f/ewl3bV3pDneiXg/o+GQkjhoQ==
X-Google-Smtp-Source: AGHT+IENFaDXGf6B9BJBB8McSR4fmbNDueJGOu9WTcmZXLmrgldHRKz8LCDEybqGX7vO80lsRAIuifvjAG+myIgAft8=
X-Received: by 2002:ac2:4896:0:b0:542:2991:9407 with SMTP id
 2adb3069b0e04-5439c246316mr6900977e87.15.1737551995772; Wed, 22 Jan 2025
 05:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20250120212613.516664-1-sjg@chromium.org>
 <20250120212613.516664-33-sjg@chromium.org>
In-Reply-To: <20250120212613.516664-33-sjg@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Jan 2025 14:19:44 +0100
X-Gm-Features: AbW1kvbJ7_99vIUOlATzKx3lk4DcmvWyucEvCJnxYgHVp7AgYSgatatfuxnZj-w
Message-ID: <CACRpkdZfELUuupNRCPpW42pPG3sZgcvezvScFn=t-qMvdHMjHg@mail.gmail.com>
Subject: Re: [PATCH v2 32/44] test: Drop the function for running seama tests
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>
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

On Mon, Jan 20, 2025 at 10:27=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:

> Use the new suite-runner to run these tests instead.
>
> It is not clear that these actually work, since they are not enabled on
> sandbox for some reason.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
