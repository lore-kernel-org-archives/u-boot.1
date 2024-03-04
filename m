Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7983C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A9487F88;
	Mon,  4 Mar 2024 14:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHHZwkiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B8787F8B; Mon,  4 Mar 2024 14:04:43 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BDD87E4D
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1731976a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 05:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709557480; x=1710162280; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Zq+b2ljVAQAG97jQ+wZz1Hg1sM+cqhGhpb0PWWTA6Q=;
 b=PHHZwkiXrjlF62I99wWjsy3AVfuKI1Sv/3DfBK0YTQBzroNIU25Q/PQdM1IrtcHIsq
 JKf5DLav6aAS1Y7CXqMVoU9mCpP567n8toB+cJzxGRRO1FMt9IK3wIJnIPGxtyGdc4Pe
 ibyK+W5TxDKeVMYuJPCZlFJ52h3B8yzw3QwRGSKp5z8Cuu/T/iG4rpQdRf5r/rre08U2
 YwWMc0Plj1sTczTsMfIzr/6KKqKzhGDza5ozu5x/RMp5zqZYX2pb/0QYC8WrJHBPGhqB
 CLMtoTvI5q6V1C++cLQ/7R5ZQjzRyeYEcOT/x9qZVbsQxvn0PQUlP3X+0UXzb/KEUb/i
 3o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557480; x=1710162280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Zq+b2ljVAQAG97jQ+wZz1Hg1sM+cqhGhpb0PWWTA6Q=;
 b=qsOcKK0TQLL51kq95+bcc3uXQIQLm40DWBOdldtXekD18gPCVeFj1dZVtkNuwdI/56
 74VLCqXfnYP+BLJ+nr9LL+Dmv7E67RPajhX8NpdQ6BOwW3y0hVC47oc/E5+rjMViLGj/
 UJJSTNFPiA7WA3s+73kLHBF8OUIhLfbx3/FXSCg0z+6gdKtsASAEt8WTUkkkqLxMVXT6
 M1aEFkNlkiX2meRFuRjN6QpqFdr52QzAoUpPj9IPQ4FG6crYsJcZzpVSGO/YchpEg8hq
 l1G1YAVIfHD+hssmD8fdSOxGOhESj1uJ8ydGmKY66rxmAjDUYNZvd2PRKrecY1bTR2KU
 qBmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ih5qgyVVfLA+1HJKG9Py4KulDfHxMkTRwbAcnP59Istv3HgwjziGlaoQGtEMHBI1GoVMujAFUB/xuKP5Z5WnS+AfCg==
X-Gm-Message-State: AOJu0Yyy5f9tl4BvLWRDH+7Qk9fSunLs8yogA/UmKpaPPYf9rd5bPWmQ
 9DrgQTPQ1kftZmp8grJ75Y2SyGfS/zJdt0Q8UOyG+illXDd44RFd3aAhADm5OWR2mdJLiDgMrCl
 MSDb8o4sIOANS6179V9tVtWGvmVc=
X-Google-Smtp-Source: AGHT+IEFRy6lFco1hPGAwBQWZa+6VEZR+U/l/5xWKG+X6AuntCiLqmpORpxPA6GJpdIsmRayn/WWMscz7kUABmpcUdc=
X-Received: by 2002:a05:6a20:1594:b0:1a1:4aa7:b8d0 with SMTP id
 h20-20020a056a20159400b001a14aa7b8d0mr6617356pzj.5.1709557480147; Mon, 04 Mar
 2024 05:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <20240227154234.GK3040305@bill-the-cat>
In-Reply-To: <20240227154234.GK3040305@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 10:04:28 -0300
Message-ID: <CAOMZO5CBY4+CogKi767RVvT0F89Kpp6Hb9p1o7cw8jRE9PwUuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
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

Hi Tom,

On Tue, Feb 27, 2024 at 12:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:

> What's the long term fix here? Why aren't these needed in Linux anymore,
> and perhaps why was it OK to remove them? This is perhaps another case
> where we as the U-Boot community need to go and talk with some Linux
> Kernel community people. Thanks.

To fix the issue for 2024.04 I suggest that this series gets applied.

In the long term, I suggest S=C3=A9bastien send a patch to the Linux DT to
add back the panel timings.

Do you agree? If so, I can apply it to u-boot-imx master.

Thanks
