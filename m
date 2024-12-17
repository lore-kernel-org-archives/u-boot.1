Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF52E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9EDC801CE;
	Tue, 17 Dec 2024 17:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XY5jEnav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB51801FB; Tue, 17 Dec 2024 17:55:34 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1229780107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso951401466b.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734454531; x=1735059331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XBUMzexz/l4kOnv0qPb5NuAKa/Fwjbndqlw8iqKWhrc=;
 b=XY5jEnavrMch1oCkI2hAa9LlDS5N78Cnt/49UG/Wpuo+uCC+V3LDFqlFRIzUkzQf6N
 Ye154oZFsI4HRE4XYPSGjDAzMxw8wDfDu51bSJU6djZ97AHDMkK6J8dCAoyS7IyRKqBH
 TdIhCRR0RDhJM/w+92+ZxOPU1oMPwxa7Fkje0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734454531; x=1735059331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBUMzexz/l4kOnv0qPb5NuAKa/Fwjbndqlw8iqKWhrc=;
 b=Ev500OvJAQGRZiwcFWlU9u8508fxHFCahbyhZNfAhJJbi//NkfLzi0hzXzDlYuWeAI
 3eY8XDxAc09esO+O5oNQ8ZAMucj/Ofu9QIVVo4X1naIrvIHIPVCTHPhSvfanBeZG/CNE
 fJAsXZM+s8aRysSdVrVIPxJ9S9MDrM2s39axPv2h9gAIZ25hPbKae6lvcLq7+Uk37bHR
 xEqQYINrTs0wt8u8+s3J+Mf25rl+7l8RJ2j3QMvnzm6yz7Qb1mHWYhtAu3aonwKxxKGa
 GU9jA4AM6kGGUoGdSD36h9OWB9tvRsUSoYh1J921xZaBzamKja9QwMPylkFeEHcu4nB2
 AbAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMsxV1DIUa7wlaI6hJREmjuqrcT+swz4z9/NHxbXgBQiay+aXhinCg6AZ0usbZMzJXkDT1WTE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2BFJqvRHaTf22oBl5dkpzgXgY4T5MXlV0NezcGrB2RZH7pzNA
 QWhRMS8aIwtbz1dZypPB5YMk6OyDmlzUYF87qfEAEGd2O52SaxE0BVWS2iq+w2bxRgBOyX89pql
 OpqWzNfAVv5SjwAM4uqD6vx/PTcu8VUMLh3/y
X-Gm-Gg: ASbGnctIf0koF93wvt3EY27DOU2FBPSh3AY9UBmpsPZtrLvCnXPdD4fb5HrneHVS3/E
 qP61m2pDGTHAJIaTCT8PXMbtWsNRmM4xdZjtmQTo=
X-Google-Smtp-Source: AGHT+IFnDg04vta3hmPvtd4CnJn7A+iDYiiu/Sb7Cw0ajhgeUmKQdsyWmYWglHrKigPvHXKauFDXzXeEot/sLzpawJw=
X-Received: by 2002:a17:907:6096:b0:aa6:94c0:f755 with SMTP id
 a640c23a62f3a-aabf1847a66mr7212566b.1.1734454531440; Tue, 17 Dec 2024
 08:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-1-13a6a127b344@ti.com>
In-Reply-To: <20241217-b4-upstream-j742s2-v1-1-13a6a127b344@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 09:55:19 -0700
Message-ID: <CAFLszTgK-TV-YaGo3g1w7w_jDYD5aaXbabtfqq-7Fr7AZBC+hQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] tools: binman: control.py: Delete template nodes
 after parsing
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, 
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
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

On Tue, 17 Dec 2024 at 04:07, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> From: Neha Malcom Francis <n-francis@ti.com>
>
> Dynamically going through the subnode array and deleting leads to
> templates being skipped from deletion when templates are consecutive in
> the subnode list. Prevent this from happening by first parsing the DT
> and then deleting the nodes.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  tools/binman/control.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
