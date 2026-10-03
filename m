Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC87CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E447960690;
	Sat,  3 Oct 2026 13:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1Ng11KGMD_F; Sat,  3 Oct 2026 13:41:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 202D160675
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034881;
	b=A5w0hrbfW8IaH85K4hg+tUP6h/sDksFjrO6D4zzUaU4OCUN8OlTa3+iEmQeIgmVjN4j3
	 N5VWFrIk0JsBfbMsgJlYVqPvGtuyjBpc42vTxyhxXzlniVs5n4hoo4UTzhFgQEL84Fnnw
	 qDLGLWFzTrKVM9hraNo68Qa8Z38qQV0wUoje07m8P3m33dtAMDVhYC7DJDIcFHte8zY0q
	 27QTMI/EinvOBJLT2+tE1tu09WyHkD6aX/FBO3/0+50pN1uua6Af9kxXNE38JFAwN+4fm
	 j3Tcqp70QNlKmcRmZfBPigXPdHIX/8ZdkD+GLRMpjr8DYYUBdCCWwMNlZq2al6e6B4g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TS/XiereLN0fVHMVR8OKje8SV+P6YIFV+qBtdxLRTAE=;
	b=aDOZk2glfZDR3reQZI2bkjvwWz6/Z7JYdtHe3fsWv3nPSPjaKQR+4SWJiXY3Hsre3zGT
	 xbeX7AlTM7jfmjawj57ZgEdRhzsYwHPcebLOFKJjo0g4JqHELqJP9uw5h4YO0Or+O8AgO
	 U4qHWpEklkGD/pk3RiXLNnVaEO4s+Ydv7CvBSijN3xp1pkl6C2yDijfj7abqPRg8zzea2
	 IvJHWyRJATZ0qCEipNa2YHOGHNS6hVNKv/1GuDX4JXdEWb0TphbAbWy47xorlvU7LG0gQ
	 tMbbnTdg+qxLBi1eMrAZjjyKKz2qAijHOO67aolqixGEkRr1/P+yMN2SUSArBfyIJ/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=l1MDbtP8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034881;
	bh=TS/XiereLN0fVHMVR8OKje8SV+P6YIFV+qBtdxLRTAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Md3mVqFV08zxZi80kViePzDau8LEhsxXxEdpC1Djr5XV2yCS6vUD6rUplhdvB/06b
	 k/A2wbCLdOJ2qB1ZdYrvucobAMqEqHYuPjckd2+sYYpoD0nakp2KtYRSTX33xwXvPK
	 aVIZMbPAVCFiwHAECcNZLvNS6HNxafAfk1/T5x8g4fHiu1kzPebKwBsP5t3zHBsqEY
	 dV4/yOhwQWn3nvomM0wCdpBG1Cs/0XHUgfEopArhk0bbela7uP16xQ7ns2ASjjzQ9F
	 OEiCvtLNiv+DoNcesWImAjLxpoBZhdN+5cEue1O16uPer6z0gXFKuHLvmq+YIUW4vE
	 wbEUOjV/ZyGKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 202D160675;
	Sat,  3 Oct 2026 13:41:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1BB4179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 973F460689
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hozymaoQbbRL for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:41:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A00B160666
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034879;
 b=PfSkbf09SNJo8MwhepQ1J3/8/Xtsse/eu4ZKa/XyXEL/5OZEbxwCnJnfcH4hhkcTXjL8
 YosPg6FBWipzMNdd0twFRIY0aYjsRLQCGrldyiSkFCJWOUKLLmhKc4/IlkxykouO+ZSno
 bOHrnLW+4qw8Nu5R1RZHe/fPKfg02pqCuHs2L7sXxcs6qtyyYK69ju9ZaLkCNbYbwXpHn
 JgjobDmfs/65+merKScOCI/phug23265VHdqs16brNcYqlGE7mCTF1L8olkgC7jvMrn32
 c9Rmw+L+bKA7HQBzbQ9cXjzxBuqhFXmYhKWsf52DWgqY05nA4+OARNSAOh0DZgePWHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034879;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=TS/XiereLN0fVHMVR8OKje8SV+P6YIFV+qBtdxLRTAE=;
 b=igsJmKySyM6ggObwaZgCQ82/Yh4+wJxpeansRzf+e5wrWnC3nwmvBS40bU+mBNgkltbi
 MRL8drqd7mR1Z1dXm7embcx06dZfovbT9vkxYISpQWAY7e2gj6UJHtOyEGXKTN8EIPwyf
 kmR6qaHvfH4xGpksyg4jLPPCQShk3UVGm4V/rWaZXm0E2CH8YHI0W2GleD8F/8e+wTBGV
 y8d0wXMrroG6HEStDXh/a0DBzElzbzK6JS2CIhXsoKbtYvcD+sIFVguRjYi2txm4FhZ7P
 k+ZN+EfQUhwW90daD78Ekkjt6LAX94Epsb6FgSUwmXYuLIYzxS6KYPIq6EfEJk/L0yA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=l1MDbtP8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=l1MDbtP8
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A00B160666
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:18 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae19319854so488534a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034876; cv=none;
 d=google.com; s=arc-20260327;
 b=VwtnowIkjrDRxdWxzHNvYiKzDUVtLQzrl9vtPwQWA9oZve9G3h5zX8nBF94n2be856
 ddcoPAO1PN23330lY+kKvCdqqVH9+bbXusaEFyXPuzyHSeYUvhXI5w7BzIC5grhmfWUO
 kU3XMd3wav8XTpEsiUIJuw+1DsffC/3tjEVQNm71QY/m+/hKns2BsMm5TaP5nNdvmOeh
 QgTkAB9KA2AHrn4jIeNHhx0RGOZecfIuD9XDdiDzi/VoczD4TPSJmMU/rPoPYaMhWB1d
 mA6VKDBTDjwZrp2LIiDecLyGW84wD0hwixWsEC4+EuzlWeNr+c6wK6jOaHtOWWWRNhhz
 kpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TS/XiereLN0fVHMVR8OKje8SV+P6YIFV+qBtdxLRTAE=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=hE0twd7i5feTdYshfdwOi7JAbceNDhAOg1Zz25iMdVy+VKJ1Vo7u0kCGNkNNa1y5/b
 5pxK6waMS/IY0yWfrHlJpu9gmOu9BoG5bi8Lf3HBIivH+EPUZvQdx4MbVcO8jAaLT10g
 hbgcHy95kiofuswBbqV9I39PVTXpt55USerCWEDmS13FabUwZJ//+GE6udc4VEZ6m1ht
 KqD3FgOhiS6205MTmBYeXm6O/jlbYqmrqMCtEXdi4+yh86mI+pBMsWxkvdTwPw7YWR6V
 sR3Qp86dBfbzj0VbWonU8EiYNYkonZAJVjy8PsTHNVPwBvq2rh9isebooBnCe0ZOccJg
 bAHw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034876; x=1791639676;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TS/XiereLN0fVHMVR8OKje8SV+P6YIFV+qBtdxLRTAE=;
 b=l1MDbtP8Oe5oFOi6PFdrlSGQC5vvWi5DOaezUB3+klhiOCo5pVZCDaFgLP8Qq7qjpq
 rYXTKWEIDP4nm0qdiuhbp+5EiIJQJeMhFK2zi83j+KyplczQIR+P2h//37ancvV04siK
 z4AErvL0xlMyEoq9aI0C5RMQRcHya8mZ7ae8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034876; x=1791639676;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TS/XiereLN0fVHMVR8OKje8SV+P6YIFV+qBtdxLRTAE=;
 b=OoRc9a5uUKC9aSms8Q3FUi5eCDmCekhdlBncnAYaWixF1qKO2Aw0Xo1mMDgFkZ9wPm
 WiArPKTQTdw82lC+VqBG1bJpqXuUqmEJ45XDKkmEitSrYA+c6L9kjEGuo9I+hTL7NwSX
 JY7Nb7bMJTX2aLG7fTB9UHrv1LH8SpZF3zx66gkEYRP35l4vBGc+DK07O5dnUNZHkgaG
 jbw8/kdveL1qPcE/kE97anHIIURy1EC2wg2c6sMgzuffx5BmT9BZ6t93l/334zkbEcQt
 4QIN8nDtPaAzpdGgeo1M0IuLN9DLWMbes3+pKl94eouGh//klLtsLZwCampzpnkE9+WU
 uVwA==
X-Gm-Message-State: AFq9FYLGsJLYGCIRdKOhunu1yr0+c2tVP9MfU0t+/UA5MlYwDVTP1z4N
 HtHkoTsVvrJa6oxUNZPo1J57mrJVlWTP6fDz6Q93iVoGrZ6ANqhCgdEofGw7gJHToQ6wZABgmrk
 nzaWtSr6BtcC4v4eK/aOjcBF3OKiuWDKGM2/vORjr
X-Gm-Gg: AYBFou1YXTJbfpwE5mj8w5uE3/b8Ih2eYV58ftCmTCwdH7Z7ws2Cw3EO6i8cpNXUHLm
 Et6QKUEmmUbT+uw2IhgFRFmZQ9c/UP+f1s7cfG0VDuGRg+LqRLzzFAniyUoEZ7NIptWIwPJCTje
 39GMJpV3ZgfSWqviWFPIWUnadHoyliypAwcGHjH1dy+JyXmqRHIh+jNjXBXT7oH4sE2ckh/CQBN
 nFVr5mypoUGDYabzlnHDcJB83UI3YpGR5MYF0dPZFYpMNUIiFDfZ/bLa3uRkfZ/11PveTXffDel
 ECnUn42sfw0FGdPSvlFCPzOQ1/lqAR4cIIQ88/cN3nIKA/NhHHJC/DpN
X-Received: by 2002:a05:6402:1908:b0:6a9:9522:f87f with SMTP id
 4fb4d7f45d1cf-6af9e320e56mr4703977a12.41.1791034876294; Sat, 03 Oct 2026
 06:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-7-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-7-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:41:01 +0100
X-Gm-Features: AclHuK8SFo16CJ1mWT14zCS7BxTGoOg63hnREb3eCEiDEjbukgNEuRV38Cdcm-4
Message-ID: <CAFLszThgrJraydMKo4FHjYXZ7GSsxVrj+wZzo0TPoEfqWS2pUQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] test: spl: Size the FIT properties for the image
 name
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Size the FIT properties for the image name
>
> create_fit() budgets a flat 596 bytes for the properties it writes, but
> one of them is the image name (named after the test itself), which is used
> twice and can cause libfdt run out of room and create_fit() return 0 if a
> new test with a longer name is added.

'can cause libfdt to run out of room'

Please can you make the motivation concrete? By my measurement on
64-bit sandbox, 596 bytes fits a name of up to 27 characters, which is
exactly spl_test_image_FIT_INTERNAL, and the next patch adds
30-character names such as spl_test_nor_FIT_INTERNAL_LZMA. So this is
needed by the series, rather than being a hypothetical problem.

>
> Size the buffer accounting for the name explicitly.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> test/image/spl_load.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -163,7 +163,14 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
> +      * The name goes in twice, as the description of both the image and the
> +      * configuration, and for external data this budget is exact: it is the
> +      * whole buffer start_fit() gets, and where the data then starts, which
> +      * the loader expects 4-byte aligned.
> +      */
> +     size_t prop_size = ALIGN(596 + 2 * strlen(spl_image->name), 4);

This works, but 596 already includes room for two copies of a
27-character name. With an empty name the FIT needs 548 bytes on
64-bit (540 on 32-bit), so the name is now counted twice and there are
always at least 48 bytes spare. That is harmless, but 'exact' reads as
though the figure is tight, when I think you mean that prop_size is
also the data offset.

Also, each copy of the name takes ALIGN(strlen() + 1, 4) bytes in the
FIT, so 2 * strlen() can be up to 8 bytes short; only the slack in 596
covers this. Please can you either reduce the base to what the fixed
properties need and add 2 * ALIGN(strlen() + 1, 4), or reword the
comment to say that 596 is the fixed part plus some margin? The first
option is already a multiple of 4, so the outer ALIGN() could go.

Regards,
Simon
