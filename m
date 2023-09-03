Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3313DC71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 18:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B17E86703;
	Sun,  3 Sep 2023 20:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="agwO+uJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A35866DC; Sun,  3 Sep 2023 20:09:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6960E867C3
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 20:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so1273299e87.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693764591; x=1694369391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9C9X452M7CkV3LDeiCujAB6LzVnqtvTP6c2LBgDJsmY=;
 b=agwO+uJnZ3DqlbMtdF35a1hxhIRaodjbdBvVrICz4moAXeASmmXBxLYN9muj+Yc/vA
 Oypo4iH4cGLT2oGN7breKPqyJqabAn5EVajQZ3uM1hpQ6PQHNWSB9PniDM6vZxVk4Sh6
 1labfhgEGCrBst0lOrS+c8FsHKD0f8w87dYnvD5xhgpjIK7QjlsmjXpV1VLHOPcOX5Js
 4swodPl+WiLhyxt13tPn9MqbsBW6AGfRJWIfmhSZRQd4jkzNnMqD981AZt5wgfjFlyF3
 PQy1ANd0yy6FHH1oVAXd2iXNnbSrlGp0dqcY61u39yDkHSq8KgXZc1quELqM/gBJ9VjS
 lzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693764591; x=1694369391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9C9X452M7CkV3LDeiCujAB6LzVnqtvTP6c2LBgDJsmY=;
 b=K+NQ8CXaQOHHH8kBu6jP6b+9+6F1C+By2ImIpW6FncP+HBY8qa0bRq/fkRknKZ5qHU
 uFnTA/m22oJi3Ggnftg4ibum0LfdkFaEV7qQJzH52dBVEl0m9SL0Z+d4+IhyqSEJSSXP
 JDh41wuH1urAKpQE4gICkC1oTjcShfny06/8f4+w2yI/REnAqw9C/ZyInK34QdrEhXqy
 DFrgYP4o5lmCzofOmG/t/SMOmACKnRLKRDJjdRogbgbbS80cyTHEuts3wEwmwACm0emd
 skDwKNRS5r4kZS8lqGc6ke/d/sRCafXRnFBGQjPUlOGHEVQ61u7fse0Ov8XVSEclndGm
 bHvg==
X-Gm-Message-State: AOJu0Yxo1QMgRatqUJK7tu/XYzjNBtqQCAwjofWX62hIhRPLUFp8T0d6
 yVR5rSDBu5zTP1WAFlycATakqjT0P6QxB5ZjfgJfFg==
X-Google-Smtp-Source: AGHT+IG1fCodTBxZh93BGy4Bo0Wu38Wdjxri2EaW/du1SNXMhnADY+kNVkWJgQxTTS4IXlT+jDo0CVmftjvxjE1w7KA=
X-Received: by 2002:a05:6512:3994:b0:4f9:570c:7b28 with SMTP id
 j20-20020a056512399400b004f9570c7b28mr6679436lfu.32.1693764591377; Sun, 03
 Sep 2023 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230901204143.3617876-1-trini@konsulko.com>
 <20230901204143.3617876-2-trini@konsulko.com>
In-Reply-To: <20230901204143.3617876-2-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Sun, 3 Sep 2023 12:09:39 -0600
Message-ID: <CAPnjgZ2JL5QW6470rKgyijcJvRGG7GFgTbwH2erfhwPtdg-+Kw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Azure: Split sandbox and qemu test.py runs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Fri, 1 Sept 2023 at 14:41, Tom Rini <trini@konsulko.com> wrote:
>
> Currently, most sandbox runs take a long time (due to running so many
> tests) while QEMu based test.py runs are fairly short.  Split the
> pipeline here so that we get more consistent average run times.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 61 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

...so far as I understand it...there seems to be a need to pass the
argos to docker again.
