Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505ACC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5470E87F40;
	Mon, 19 Feb 2024 14:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zll0aFig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D72887E0B; Mon, 19 Feb 2024 14:11:50 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3656387F4B
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 14:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d862e8b163so1391625a12.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 05:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708348272; x=1708953072; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPTk1cf+2gY5cx/hJ/vPNemeK/8pUozmlOt0iaBJDPM=;
 b=Zll0aFigxcKeNxLg1sCt+mScooHrLATeDvG6xEDzjfV+jelwj6evi9mrqfOhBnGEzU
 190ToKYE0uSyLEqreNzlDq26rX4WtSR4ymalW63Yndzfk5jHOhjKZcUT+peIBOyta4bO
 BG7v+lNAIxtWP9ojuu/hOGgmv+tLSYTVZYIwln/Fx4lG/ZfIB5QtpNNksbzRTT3GbOb0
 3mHF2AaIlh0U7Js50umEXeOEvj92b9py/EjR9xs5pit6w/BOa34DV/0z80yn5zR7ls0K
 avzIr9+R2VjxpBBPAQTaHOViOf9Qdp6uXvSVIIzmCHKqJKfCiTqXPvhpQEzaLSQl+UUi
 j6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708348272; x=1708953072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPTk1cf+2gY5cx/hJ/vPNemeK/8pUozmlOt0iaBJDPM=;
 b=ri12PbNBXxLWPhoj025tHgMLmVjC1ORwIfax8KLfx3ERsIiGsNKwrYTMIieWhpkQeK
 cIzr7FJ1kKQ1ngzBMSSF3z36slw8R9wHe9o03TDRgrwjZVT8K6Wys0xPHs/aox91YtFY
 6EMMNRac87EG2NwMG93A3Z28/5cFt0Pl7by0HQgkjvkjNLErVQLvlxD5FCgV3IQNq1Tk
 crPMDuIh8q2ivIDMOji94xPKCuJ5aeEtLNPpYE4cPWUV/TE3pvyUgvi8fTFR2uspQYMK
 60JP5R6PzBboB643HleWG1qF4VcY5+10M98lAqygYZudltPsUQYoc3MNKAtJIh3PQCxJ
 mk2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ij85Qw7e92YjSN4ovr4h8AN3mwc6UWslJK7fApF4UXiTHthgPMrSf36UHqShASZq/AlWpKSmVjnux8fNlNrVGt1Fkg==
X-Gm-Message-State: AOJu0Yy6GlMQwlUPdbfUD98mzpzt5HwGwWc3ZxMQxrIaunhPyKCFgqux
 ohYQEQu2UWHyvIZyTK6I/MfXNQaYCqJCOl+EzBqvMolHIE7HrVe4N04cirZB/m4C1KeFpZSp4zx
 gTA4SVguX8sEgzuuOlwXsH8m6kLs=
X-Google-Smtp-Source: AGHT+IG2zqFxgtwn2iNfCwYPkgoKF85Ei+AwgOUhPv5C9lyWaaYaVx9WHK+IAwalhSA0qGXxXNj8pzul/8A1YBFiZhE=
X-Received: by 2002:a05:6a20:1441:b0:1a0:b0d7:f909 with SMTP id
 a1-20020a056a20144100b001a0b0d7f909mr427789pzi.1.1708348271653; Mon, 19 Feb
 2024 05:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20240213131706.64-1-ian.ray@gehealthcare.com>
In-Reply-To: <20240213131706.64-1-ian.ray@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 10:11:01 -0300
Message-ID: <CAOMZO5DC2g=16o0eFPuzsdDTDEObjETE7X0EjmxpO-hwaO=OCQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update after GEHC spin-off
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, ian.ray@ge.com, HuanWang@ge.com
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

On Tue, Feb 13, 2024 at 11:08=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com>=
 wrote:
>
> Update our email addresses, from @ge.com to @gehealthcare.com, after GE
> HealthCare was spun-off from GE.
>
> Remove Antti, who no longer works on the project.
>
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

Applied, thanks.
