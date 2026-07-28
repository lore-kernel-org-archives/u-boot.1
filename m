Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091DEC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 14:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 080A2608A9;
	Tue, 28 Jul 2026 14:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWXJ6DZrvyqS; Tue, 28 Jul 2026 14:07:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3BDF608A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785247630;
	bh=5hy6tWerBzMhzrDUvaoDxzvZbg9dKYSzx2qJi9wJs30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pcq6j6/8zysEknIJoeUYgKoTe9/oHTaErQEvLsvg40/qaSWGGtoy57MB5O2yGooQo
	 MA6KlBmFOst5Z9MwUiEFdiGj5Z2dS1DhgraQkbGerY/RMqXCJ9fSq5jv5IZvzAf9ey
	 WsZmQxMewfPY/HpnXbc4Yitthv227/glYGwyN/FXBLI7rZAmG9m6iQ45yxCpnVMrLj
	 iPu+5LS13czI1+dgOimiBAIlL9f2jv/vU6h8v+uUmeKqTsRO2cV/t9J7UYCUIQaD9O
	 vSXmEHpEuK50tiHMUl7GZTBPyUC8AM5Pryy9iZk8NT/PZmusTw/dk7Qmy5x8fAm97q
	 0S9L+FHNPjBaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3BDF608A7;
	Tue, 28 Jul 2026 14:07:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B7C5323F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A118F4031D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:07:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id biFwKSK5A6Ey for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 14:07:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 926064011D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 926064011D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 926064011D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:07:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4AD08494B; Tue, 28 Jul 2026 16:07:06 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E16848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 16:07:04 +0200 (CEST)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39f1ac13687so30591821fa.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 07:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785247623; cv=none;
 d=google.com; s=arc-20260327;
 b=ap9j6sLzrIYJiMu8UK5D3O7K59EEehh7Owr2gRIx1UOQ0zrjtm982wvBEqGu8Ss70w
 u3e+12mXTMcvP4h3ZoxGKY9UBMzTE7QAoSAF4p0b/oHP3rrWHjEQ/dd15WtC2F7wu7Hb
 YV6HbTH80XdfEZn89YtBTjXFgtGwLh+D11m834pQeZRz7Sq3LTlzoTv/4UDUbugSWuVU
 arlvM8TQ9G5RaR3sH90oRs2YurwD+oDjrnNCEoxBbMIqQCmFXDav1nhohBLCbpjMx6R3
 nR+R098th3H9uMWqyY6/bWNRALWHnNXb72xYmXdjqWKo8aG8uiIwD/WxDqB475oo/qAX
 v5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5hy6tWerBzMhzrDUvaoDxzvZbg9dKYSzx2qJi9wJs30=;
 fh=0mAHWkvHdDPij1D65Y0z7mMnqauPFwxg+pd2JSjzwEc=;
 b=sh3t1sTxXDnWmifbD7J16SJoL5w1gZWotj5aLTYnL9H7bgtjSzonBy/GhmNES5U2ga
 j4VM268toGLy9S37B4dgW72EB8z1eFCk7b+irxx/ll2zR2liZhaqCELjWtqQi6KYN8D0
 rPdyKT4nVbZdJ6CAa0CFzxR0cj/iGVQwBg4yn2V6CxJZrsH6IyHPdUyjuB+RP2QUHeZI
 qZYK+9AsROqqfBiKOMamMZN/GJu+4s+YvAKKJPuVk4HOJyP5gsrCGvJYKHCeeXew8xRy
 YY16Ida8jyXBCn/rYOj3UK72yzVK8P67LUmXkLNPPa4H5c77i4UICXzoPuWc71xiQV5S
 09Fw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247623; x=1785852423;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5hy6tWerBzMhzrDUvaoDxzvZbg9dKYSzx2qJi9wJs30=;
 b=Ke6ZiYMTUqX7PRAeg4nAT0NHBnqtIrrxS2+m9R5fZx30b0moqbANxKJckqmpzkBDdO
 x0wlekLvLElaFgswaB8COJdixSKi+Lq5S6q62NKZSMBoz5W9eFSGUSqweTfQDldHmaof
 9HnA7JqqqgssR4p8b8aqqJy7uBPcYCnWEsjlMux6CftbXAMXC226uYEkdeCyaERuj+Bi
 gU1ljkvRSYmhjhO0mSLsczkNsy97lqOkq4ccqa3mKuMaVAOWTPegThYBIQXdac5Bce4y
 MozLRjGxcr2XKmntbNlwuDzS91alhizPFD4saaxgeX/6lydp9EmQCzbBe7U5v8JGfMUi
 9+HQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9QD1LWJ/+e+yso5rWljJ7X6HT5Q6YIk0eZ6rmEIenj5mH97yxWdu0MdQDeDl5sG8JzQ3MxCQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7zw8GD5hvTmJVNW2yK0T3FwO4JbKA8a94HRqzpHRaigpdpVIJ
 GKJ72XMvk972bgu4A+jWMTsD1ee/ZxXiEAWxDWG+L/lT3mTfeOhmFNEHeSRSe1xtz3wYPWUaJGp
 l5thvxeDJDztHkGGPoO+067VT91BO4OE=
X-Gm-Gg: AR+sD13ui+TLePdIa1xpJw0PKFBei42SRgw40zCGm0qMTMx/p1+zR/UjMLIXF4C5Vwg
 HzkPPCAC0eiNxEnLU6f0VzGVFlUUjKOj8ZdPmJdsr6FfFXtoG71u2iOugvsgmGI517tBX1RBaYi
 KoY6DOtFKZrUgTNlBcbkPMM7nX7kEYSJehGr4u1GnnpcKVTiVmy0402xz3ZEGC+uJdIJrIfwCoW
 0sro6tzKR13OWGXvKLsEpAf9Pugh4vUTiomrl2rnTbGoIdMFQkaFIILCWowzXI3/2G2PDW4xr0k
 3n7ozBt3XU+SALBvg9xSYoY5PeDVRIo95jA5si4kewQ20AaEMag=
X-Received: by 2002:a05:6512:3986:b0:5b0:82d:e90e with SMTP id
 2adb3069b0e04-5b2d021d4camr590217e87.19.1785247622588; Tue, 28 Jul 2026
 07:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260728060314.3560643-1-qijian.guo@nxp.com>
In-Reply-To: <20260728060314.3560643-1-qijian.guo@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Jul 2026 11:06:49 -0300
X-Gm-Features: AUfX_myZzXYfzdqdv5RtkRYgooCG9U6rYxQ3jGQLgWvOXiMVO5V3RKMd1KAx9lI
Message-ID: <CAOMZO5ATbaYCmgh_tCSV53dtZux+yqPJ_eOzgdk8KbzxSMb0Ow@mail.gmail.com>
Subject: Re: [PATCH] imx: scmi: suppress invalid origin/errid in reset reason
 print
To: Joseph Guo <qijian.guo@nxp.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@nabladev.com>, 
 Fedor Ross <fedor.ross@ifm.com>, open list <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785247623; x=1785852423; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5hy6tWerBzMhzrDUvaoDxzvZbg9dKYSzx2qJi9wJs30=;
 b=MqolMGCel05Wfv/jVfvhb64QeZSLjOMCdpBDZaFgkYGYOgB5KdSVw/xknqGHnmViR+
 LQRFK+LbNRlrwvl4QTVAHxMSCZWMAsDmyeLXCDw0y/HGXzRHsk5qx+n+MC1AfVKfZUZY
 jECYBjvEqyXHE6hzCwk7jLeuMPCT9BQf+FQptSHommSG1huR5/PxOSDoNjBUVNESutGa
 lce5LdRcosGc8Onjf+M+F3SskxUp9aMpHs7iDAHx4ReqVFA55bGOHG/2VTAEFkO3EM0m
 kcOnchpJ0ca9a8QjfvOFxn3VTzuutXywTGBEnUlyp1nc/p07ToSSsmGdlVqVtn5s6Yr5
 BM4Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MqolMGCe
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqolMGCe"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Joseph,

On Tue, Jul 28, 2026 at 3:03=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wro=
te:
>
> Only print origin and errid fields when the corresponding valid bits
> (MISC_BOOT_FLAG_ORG_VLD and MISC_BOOT_FLAG_ERR_VLD) are set. For a
> normal power-on reset, these fields are not valid, and printing -1
> is just noise.
>
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>

I don't see this patch in patchwork.

Please resend it to the new U-Boot mailing address:
u-boot@lists.u-boot-project.org
