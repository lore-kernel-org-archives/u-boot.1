Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F683C54E68
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A6587E0A;
	Mon, 18 Mar 2024 00:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HWYEySpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F4A687EE3; Mon, 18 Mar 2024 00:51:28 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 188F987B35
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso457968a91.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710719483; x=1711324283; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7JVMPXTE5qNH26K+JgGhLUSmEBtOyutKBTrHSZfdF8=;
 b=HWYEySpd+kmYcQWKwLDlZFDhMrl61oEghhOe5AX5QxVeW8bkdDKo4rm9a+1ZIF5iRe
 M7xdHNipUvB28qUMsELWRtLEfiZj1SqcMbPChviMbeg+5O55766OhuRi2uMy2ow3Sz1/
 Y6JTeWvbmjPEdGUppQtYGlEmgJ4VS2OCOzZ0x+XCAsuGj4zXIwpuc7HaHJbi+fcqh4/s
 LeKbCghKxLPaXHaHzzsCjygs8VkQIUJINs3+zt2hjo9WmwWrdEC/afaKEtVYoFiJ8d5Z
 RZx+W0veVofM16wGDiITW0lqgqtVlC/0sCuINiXZ++8jWazjOrGNSV2qAE9ZUvC8kktm
 oL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710719483; x=1711324283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7JVMPXTE5qNH26K+JgGhLUSmEBtOyutKBTrHSZfdF8=;
 b=FSkZ5pxV11AB6LAipc1trTa1IUs5WMtHfgYfm8WFBDYV4nUyQ84f33Z0uwRTU92fQc
 DnjlJhmYG0d6rWLtFH1nH/mviFAl81KdhUFeMBEwhhYog7gebLYzxHT5wN6sDi1VaHPH
 b0A3lPTfxf/hbxD8jLMdFE1TGUnIL4jAvuLSjP1vcWnP5bdYOk0n6t94bW0267pb5oDy
 YMMyKF+2owKf5c1rX+jywleB68xq2t4+vJwIdA29aYZcMhJv64t8CE4DkOjxpQeNZaHP
 DeqKcZW2kgP8I+imrUO0bEggbfbu2QEDMMO0M/2bSVV/vfcjfnd7EAZ+HdfSY7U1mxp8
 ce1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGPwPgTpMrzYVdVMv1dS+tI3ywUkdG8i7qgB2VSJHQwpV4A8DCV/6gDsz/R0xddlWc7FAq+ueMgGz3yfPecvjkePQycA==
X-Gm-Message-State: AOJu0YxzSZ/XXda72nnJkQk6ksH+fgm0Tl4bztwAvo7biySKCVCGoGhh
 xMFkA9Xh0i7cObhJCxI66jXWDjhFh3LMz9AEj7AG2RAuoSdQ38sUHqWSs0N5HF4qnyEYWcml2qW
 7A/XSiwLBr/v+cCwwI3eWzuf/Tpw=
X-Google-Smtp-Source: AGHT+IHguOhdd5XDEFynn6o1bj4qSL106DWngWEJJBQIqpBJNl4AsPMoD8xQq69UuktjGWj1XC6ujHr52+S1DSc7Sdg=
X-Received: by 2002:a17:90a:ad93:b0:29b:f75d:bf5d with SMTP id
 s19-20020a17090aad9300b0029bf75dbf5dmr9183696pjq.4.1710719483533; Sun, 17 Mar
 2024 16:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240304-fix-thermal-driver-issue-v1-1-f30daeaf1055@phytec.de>
In-Reply-To: <20240304-fix-thermal-driver-issue-v1-1-f30daeaf1055@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 17 Mar 2024 20:51:11 -0300
Message-ID: <CAOMZO5AsNA-e7Egy_=6ZP9b39omRtUoypOtu030ji9VsXUHSuA@mail.gmail.com>
Subject: Re: [PATCH] drivers: imx_tmu: Select polling-rate from cpu-thermal
 devicetree node
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Mon, Mar 4, 2024 at 8:49=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:
>
> The polling rate is already specified in some devicetrees, like
> imx8mp.dtsi for example, but was not selected so far. For the
> trippoints, the cpu-thermal node is used. Also get the polling rate from
> this node. Use the default of 5000ms if the polling rate should not be
> specified in the devicetree.
>
> NOTE: The polling rate from the devicetree will be used after this
> patch. In imx8*.dtsi devicetrees the polling delay is set to 2000ms for
> example.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Applied for u-boot-imx/next, thanks.
