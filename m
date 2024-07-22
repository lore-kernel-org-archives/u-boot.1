Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF95C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25092885EE;
	Mon, 22 Jul 2024 23:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jT+EXXkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D27A87D43; Mon, 22 Jul 2024 23:05:44 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5767888579
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f008b40d7so325424e87.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682331; x=1722287131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqzADg7SNYzuOdVntxYGfWjsWqaWfVFai44+fY2HvQU=;
 b=jT+EXXkrhFwO8A+8DPtKHSnyOGVEhPpgkq0ITzp2NN7BVgdljZdHObzjFXJqSiaW5f
 dxPLE/QISfJsZfKTYBm1k4vZQdH1KKip+1CqKPep2V5g17mTjSIFH9dl/HzBNZ0xIqm8
 dyu2GesRkse9eY85IPAXeR0Dxa80wQBuS5U19wsmBilzGLhSgOscjjZdcm+B5Q6VlpGE
 mRrBmm6JZOIDL25gozmH5RRg/Wy/qOgU+6O9Y+VR3zcyj4TFqC2VEtVnDSvy68CtZHpH
 32i1+3GB0jMj4URM/UO2lc8og739bZpl2eH7U2ZnKQ6CvRa3rebvvzo0K2wqV3hH3JWZ
 NjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682331; x=1722287131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqzADg7SNYzuOdVntxYGfWjsWqaWfVFai44+fY2HvQU=;
 b=LlCDQaykglTr272Hr4zZzVhX17pt51x8+xlUkaq12992gk9iC2cZfD0uxOgrvOE9jm
 lnpp1LiJcEZHkXzOrHsWD3GRC/fXvLlRzzlKQGl0kbmEzer95YJ9lXdQXMedYtK7scwq
 Yz5iAuGQwOxS28YI6/pSvX5+/rEp4kRJth9hTElGSvqt6C3V+xPRqJiIHulaOT1xc/Nv
 3Bf5XUoywbWohylqCIzjcek2/V5vpTMv6+YbMuvZkxa6bW8w+Z0ZtcR28XNIW05mV90M
 OQTRWVaMTqNsMpQ2nYGB07xj8ykCPJZhzSkOevRgQ6Y1jCrpNopqZTLlL9Ev9B4dtfky
 Jnvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV61WPTcXypEIdxgkuF2dvKaIoyzvVubacGqNYt07czRtBq0jK8LKD7iKhPKHh+kn79/Bw6vxlID+7qoozhjZh4unV4zQ==
X-Gm-Message-State: AOJu0YxMUaBwR61SmY158+ELJU11HZuGBbpYKA4JXXaCjEiCqCG8GfdT
 0Zv6omTxPp6wP62YdDUBse53hVpcJmWHDWoneYM4Npt4K/FSsee4T8C6s2XV7LXB+9sZpxcn9cJ
 l4CSvWtr7qPAkhqTTQz4S8Wej2dY=
X-Google-Smtp-Source: AGHT+IEWGJ0oCj2jMwKzzH3ElojocZwaDrmWOFoEBBLJAKRZkIRXA4KtM7/TzW2rqW2Ax/tKEkzbb5DBu6mkX4KX4aM=
X-Received: by 2002:a2e:b16b:0:b0:2f0:1ea8:63a6 with SMTP id
 38308e7fff4ca-2f01ea8665bmr3570421fa.8.1721682331001; Mon, 22 Jul 2024
 14:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240712141922.27739-1-emil.kronborg@protonmail.com>
In-Reply-To: <20240712141922.27739-1-emil.kronborg@protonmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:05:19 -0300
Message-ID: <CAOMZO5DfjPCdj5sNKHbXESO9=Zg9-KqsmJcbQzkFZNB6SQeb6A@mail.gmail.com>
Subject: Re: [PATCH] clk: imx6q: Add definition for IMX6QDL_CLK_PWM1
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: lukma@denx.de, seanga2@gmail.com, trini@konsulko.com, 
 rasmus.villemoes@prevas.dk, u-boot@lists.denx.de
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

On Fri, Jul 12, 2024 at 8:10=E2=80=AFPM Emil Kronborg
<emil.kronborg@protonmail.com> wrote:
>
> Enabling CONFIG_CMD_PWM, and consequently CONFIG_DM_PWM, causes the pwm
> command to fail due to a missing clock.
>
>     =3D> pwm enable 0 0
>     Enable clock-controller@20c4000 failed
>     Failed to enable per_clk
>     pwm: '0' not found
>     Command 'pwm' failed: Error -2
>
> Note that it is trivial to also add the clocks for PWM2, PWM3, and PWM4.
> However, I only tested PWM1 and thus only added the clock for that
> signal.
>
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>

Applied, thanks.
