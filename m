Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41DBC54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 08:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E943B87DC7;
	Mon, 25 Mar 2024 09:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ToDkgweq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99EDD87DC8; Mon, 25 Mar 2024 09:18:05 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4840F870D2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 09:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d6c9678cbdso22215841fa.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711354682; x=1711959482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VpU1TGchkARObssVrA2Ds2wyENdX8do6LTTdhbXNoIE=;
 b=ToDkgweqr809rEuYXv8VCxZQckHbb+cfe0VSWXggGtoy5wqNhItkkuHhYLU5EJjQNE
 CYt5SHsKb8mh2ur+lWGip/0dY+uw+sx3sUVDqy/wQIFxlWlNu0zsQfLemAv4LqO4awO0
 92OJQMTiTlzUkyk2x/QuGUbs3qICdQpuBl5lYUnHo9yiIkGFtP8NbKeneT5640G5/0DO
 y2oygNEPIra30mYwN26xhgeY/4oXhzwOXTXOmgGYNeDPoFnShBbuWmUpdpemrKmxqNKq
 UDEW9QEQ9tnpyFCt7ctIggcArZwG1nuJlD0CKG9M9qYIWCgmWaCFpbT1TJN4pLck6KJd
 E6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711354682; x=1711959482;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VpU1TGchkARObssVrA2Ds2wyENdX8do6LTTdhbXNoIE=;
 b=VEHz2cBOTMWfB1e+X2nJb+9GkQVxokrJ2NMtUFUPoDbNn/xhGI+OhhS7Mb5TNIvRzj
 yZtqmXhIY4KtMxwu6eHwej+BsnqaLEN2QmypoVTUhStuhoitg7jIz/0ChVh/2tfzMUUz
 eD+VL/xyJO209kSZaGmgInKr9AAhRm/Qo5gECo2610OWQN5of2n5Ux2YK2y0cfwLvwjV
 LXjZEkRJL2ch4/Hpg8g8KO0Geqv7D8+GQslV4d1wU+47qT4YrJysz4VhVKcfoZeb5zLu
 oOkl12kaM0jeZhPxnla9+S86LIv/Q0cfHnTjErAq2PZXESZ1s3+54FtzCv4kgmOZbIA1
 vXGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjtdH/kb6uRk5egR8HfRLLIBLtpuPyq8LdEs8gotrGLM9946wjKrAcmFk815AoEJySpb5tqluBLgu4WqTkbNSMzmTKEg==
X-Gm-Message-State: AOJu0Yykgfbsz4oYJrA6C3D2EX0XoplgFgTLAQmVP8PebkpvR3/M/1e8
 B89GY/I1XylpNOHSRdcv/anQCEe1ncQpIHtdOHDd7k4RPtAMGiKanfkJgsnWfXo=
X-Google-Smtp-Source: AGHT+IFE//evOrpPeVLu9STIIFbrNqOZ3JFuxhPxB0yZhy6bAjG2sDrFE59CJewkalSV9jtFCPNhkQ==
X-Received: by 2002:a2e:b0d2:0:b0:2d4:37ca:92d1 with SMTP id
 g18-20020a2eb0d2000000b002d437ca92d1mr3626178ljl.42.1711354682118; 
 Mon, 25 Mar 2024 01:18:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 c10-20020adffb4a000000b0034174566ec4sm8793731wrs.16.2024.03.25.01.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 01:18:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Viacheslav Bocharov <adeep@lexina.in>
In-Reply-To: <20240227065551.580199-1-adeep@lexina.in>
References: <20240227065551.580199-1-adeep@lexina.in>
Subject: Re: [PATCH v1 0/3] board: amlogic: jethubj100: small updates
Message-Id: <171135468114.4115976.5643461187922609574.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 09:18:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

Hi,

On Tue, 27 Feb 2024 09:54:03 +0300, Viacheslav Bocharov wrote:
> Update JetHub D1/D1+ board support files.
> 
> Viacheslav Bocharov (3):
>   board: amlogic: jethubj100: fix common config header
>   board: amlogic: jethubj100: update MAINTAINERS
>   board: amlogic: jethubj100: update docs
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] board: amlogic: jethubj100: fix common config header
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/803fc9955164e17e8c6d1896ac2770e17c251f11
[2/3] board: amlogic: jethubj100: update MAINTAINERS
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5e61fedf3424374a065eb23fb48963df2606bb73
[3/3] board: amlogic: jethubj100: update docs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2fc5e3c1668cffdb4b894986e98c1ee10f6e9955

-- 
Neil

