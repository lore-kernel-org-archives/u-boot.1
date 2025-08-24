Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123A3CA0EEB
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 13:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCF682DA1;
	Sun, 24 Aug 2025 15:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EGYEYZ2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EFDC82E37; Sun, 24 Aug 2025 15:33:21 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CE982AE1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 15:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so548086366b.2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756042399; x=1756647199; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qKJWiH+iIgew6liod6ln/mbvv2vi3iC1pLP7Xj7+t64=;
 b=EGYEYZ2yynaVlFy7ahaq4Iil+s5rW2/5fQAeDb5noLqp3/1l+TDoKVk0XzBqsU8aUB
 7py5R7TgJE8LgECBhCmOF7yM/xD6v2sdeYOYYhWhRy+8hhYUxSIh61PVyyX0Ufp1s0eq
 iXvyYmmRWSmPX2zP9qY7xfF/IR40Z8B721aGJfcPpyl2NssdD0eM/+y5jO5C5kWw5qD9
 F82LL4YnYe2gQyE0QZQ1wICE42xetp8ivwLSlHcMZ0jJWAv9ONIHNYGdHhMMKiydIt2x
 NULvfan4lH78HF+G1cDugo+3ln5XJ+3iSxtDK0W0aqe4RUOauNvRtg6KR1jQ3nJ+5uAD
 u4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756042399; x=1756647199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKJWiH+iIgew6liod6ln/mbvv2vi3iC1pLP7Xj7+t64=;
 b=GiF1rg4orpn+LrKQ0cj9oFQYu//+UgjUl9b+OF0J8rdEgw/BUpRpc2/PhC2D7oAeQg
 IgOUE/fVbNXmBhjcNJB9tFNxKXtymB4pUlkIKY/gIzspXimwP85iMLc3Uqo94mtRxRmM
 OuyHLqTjZDC/n86G+zQkWba33y/o7K/iCrbY5lNg9+uP49Lwp2ukn6WZDXsoQUt/kjO4
 rQa9S++FYZShflGdJg/Cabf4kQ8wVn9T1Rnjkg0frS6ZoSF+WEmB21qqTWWuoysRKmo+
 jclbzLWXPLzDnzpNsDnaZQtzOtspmWisIKOIJLY2lAZIyEiwDoUcCe1zbFkuvGr783BW
 SjtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1FmQJImr4tAqRwtKlffelWt02lMsqy9IbNhxJVZ8G+alb7DN8f3CFxKDG/MZKleSn4QvcwXA=@lists.denx.de
X-Gm-Message-State: AOJu0YzO7y8qBXbzML+bHVdP6xU87+kKoIYYZyD0C177yo7QZIe5tTPZ
 p7zQ7+aFniAPw7Gqqxekg9UXcn0KRP209At6j9m9+sy4iUqryVLXJubAZlvOdGPRRAdwcHifQbg
 pf+IJfwsC+iF2vN3VFvZipiSJmOL9NG3sPw==
X-Gm-Gg: ASbGncvpWElMRVVi9KJmmnUFs1nkq2cOUlfzDW/Teu8v97GTwXx9cdEJatNAt45ibCt
 6nFSes2/DB9ks4Loiu7GAovWMUdroL2R4MQYeMIumd2bwdvj//kJZXhTlbWH3lwZhnsDXuMkL3d
 ZiV+VQFRFrCuWwdd4YrG/iqwUIYSFU+QHNf13OeL6sGeW7h+l2T4x+iqdk0V4mkPbytwstjdGvJ
 +NkVgdY02hod3ve
X-Google-Smtp-Source: AGHT+IFSPjdZgBYjLX7EkBcGOBweI751oHTQzTTe+j3y8Z8vzX9zC05Mg8u5MACs+LoE3WZjVR2xmCBjfMOJl7Jewl0=
X-Received: by 2002:a05:6402:4381:b0:609:9115:60f1 with SMTP id
 4fb4d7f45d1cf-61c1b4a27c7mr8003219a12.16.1756042398661; Sun, 24 Aug 2025
 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
 <20250822-b4-exynos-power-v1-2-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-2-9e2f2f740029@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 24 Aug 2025 19:03:01 +0530
X-Gm-Features: Ac12FXxCH73CEaXXrSYLR9wRlmD_uI9XJqot3gaBTNaB9xLb2sbem1vhP1tnSRw
Message-ID: <CANAwSgQMJU4C72SmANxsioTU3xyDeEorR3257CQX4BpqJwqZzQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] ARM: dts: exynos5422-odroidxu3: rename s2mps11
 regulators node
To: Henrik Grimler <henrik@grimler.se>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de
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

Hi Henrik,

On Sat, 23 Aug 2025 at 00:04, Henrik Grimler <henrik@grimler.se> wrote:
>
> With this both linux and u-boot uses the same node name, which
> simplifies devicetree parsing in s2mps11 driver.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
