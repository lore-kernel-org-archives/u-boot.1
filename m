Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55364FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81253846FA;
	Mon,  4 May 2026 22:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TIOexAXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7FBA846FA; Mon,  4 May 2026 22:30:51 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FB6846A0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bad54961385so767304666b.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926649; cv=none;
 d=google.com; s=arc-20240605;
 b=loNIvLPrUOVKyjSJXTrjzgyKcUURN8Zb0kBUb4fpoHjheJDl8Bfdotzy/NwbQREpc4
 m13QI4CUpNxCuRFVObj6Fr4eZC8QxRN071abBShZiuxhT+xzwLOkHiO7eadXbs/w1o9/
 3Gn6QCkLFRc7cqbNlx8PVlMbpLuFL6w/eEO69duzKYhoK2YAmsIKeWvj5coab83RlJw1
 LvMZnxlhicTaNL16QUomjju/JrdKN7qUi0pYulez/W0uYAPIHRFx2TpnmZFoIImZ4yz0
 BEIExPcuoVHoFXBU+EWofl51CfgjmhhIlDZqwL7gII+DEsoc62ftYjACIrCAfTLksCgM
 wixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ffa/C3Sopb7KYbOqEjPcq6gjd+yfmw/0HkHWI8nxdIk=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=Dagdhsu69nm5vKQTDvqkY++KtZfP5i2hmL0aQ0tRNeJUXnm0b0OwNd1YXLEPFtXHrE
 JPrhrnS6/fAjoziam1P6C1hjGCX16QB/igniuvijlZm6r5flAzR7OcyaLD0TJPXYb5RE
 8VTgaOxXQnSETw8gOKQPMfTrwaSq7Ga91/1M146m6GQotRupsIvxfc/XjDOze974DZy5
 4yL2Fl7Ajg+jj0WdWoP5xTy8bRCPsxcJK03eMERUFlwWs4Mxk6NnTEO1QlBnfoxDBN/i
 33XUQPhIh74ErBEVUOQmXKYqBv6bvvz1ESiRNbpkZMsQ3KFO79DHQx8rARjqUxXJcKHU
 Izgg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926649; x=1778531449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ffa/C3Sopb7KYbOqEjPcq6gjd+yfmw/0HkHWI8nxdIk=;
 b=TIOexAXx0nNBy6Ug+jvwDxHH76uq30hWNqa7AJmUPV/zcnxljzSyCaIX/XK5Wuifnc
 JdWqMS6OtHB30aK9TdeHuvdmt57TsejopzN8aerpta5pLBvMRPToQfSITwBNvFTgUCfG
 JER7N5u6ZI3kRsjsMO1dNLNvXwndjoqebzSIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926649; x=1778531449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ffa/C3Sopb7KYbOqEjPcq6gjd+yfmw/0HkHWI8nxdIk=;
 b=MZlCFaRuaMb/sj1+nwGDi/lox0OyB1khoZ99fTnJKXSYczyosYZgYq+Ooz6rTvmIP6
 0fzEcJErwu7U21ekLnhaGU7l2pVV4D41JeWpr7iU6E66ygU7ED/cvqcZQj6qKEnZ8o3w
 ICJ9j2N4oRrIIsfOQJMlOzOg7Xze2qVJZsgl+Gpac8OZVOdNpEpM/lwv0qg5TOZKJEit
 8t1KJvAWVcT1+BlsgJizQELXluvd9C+DTKaJXK1ghFFBIktW/yxF/wfQGEb2tx/f0IAV
 IN0l2qvxGqHQWtjOvAURHxFCGlb8eeax0xofzaH9zYZR2db1/R4QiNgau/KsztM04Aeq
 am/w==
X-Gm-Message-State: AOJu0Yz+yAIK9d7WY/XoNQ7Y/WMclKnpAMKHQZAmSjfSoVMnMefyK6h0
 FBU7xvvDEubt/49BUvvA3p6NE7mh4Q3+h9yImzXsveC8yuxYkxATIWw59BNq3rxflEL0E3LdWq8
 OK51Pv3kz0I08v2R+WyeSbzVlUA5JKgox2gbIhBw8
X-Gm-Gg: AeBDiet9hwKiKJqGlOJ8hoFmtHymcWlrQFRDFboVEqd9fA1F2e3BXvBCJPeoXHupWR0
 uqRMqIkZezPq4j5YJON0I+ND0BEM9fzO5xxDPTkd7f7vCGOxFRBU36FCL/MniEvoKQF1/h8tHqW
 rXD/EhMvi2BOWfuf9crddyMqI4Ngkh770a9VYU6qP9IzjqJTSHl1ByQ8lyvYZHsiX0F6N9D8yav
 p/sDtIeBr4D9XsBezYyfYNruA13KDrdf27ihnMbmuHh0XhLA/s+3rT7h6AugD4VVNs5jE1yWZUM
 8aJVTJRM8nKyJfvt
X-Received: by 2002:a17:907:2da0:b0:b98:286a:e2c2 with SMTP id
 a640c23a62f3a-bc411d282b7mr4895666b.38.1777926649370; Mon, 04 May 2026
 13:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-4-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-4-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:33 -0600
X-Gm-Features: AVHnY4Kj8GoX_SaVpYd1ixE5ySbAeHOXN1_fzJqLkzt_97NbeFXlYkrxviJi1z0
Message-ID: <CAFLszTjO=C8=HFS6tg1uq-xgqjUKEzSUoS3Pqza+1MszZ7K0Qg@mail.gmail.com>
Subject: Re: [PATCH RFC next 04/18] kbuild: re-enable int-in-bool-context
 warning
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> kbuild: re-enable int-in-bool-context warning
>
> [ Upstream commit a3bc88645e9293f5aaac9c05a185d9f1c0594c6c ]
>
> Original commit log:
>
>   This warning was disabled by commit bd664f6b3e37 ("disable new
>   gcc-7.1.1 warnings for now") just because it was too noisy.
>
>   Thanks to Arnd Bergmann, all warnings have been fixed. Now, we are
>   ready to re-enable it.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Makefile | 1 -
>  1 file changed, 1 deletion(-)

> diff --git a/Makefile b/Makefile
> @@ -897,7 +897,6 @@ KBUILD_CFLAGS     += $(call cc-option,-fno-delete-null-pointer-checks,)
>  KBUILD_CFLAGS        += $(call cc-disable-warning,frame-address,)
>  KBUILD_CFLAGS        += $(call cc-disable-warning, format-truncation)
>  KBUILD_CFLAGS        += $(call cc-disable-warning, format-overflow)
> -KBUILD_CFLAGS        += $(call cc-disable-warning, int-in-bool-context)
>  KBUILD_CFLAGS        += $(call cc-disable-warning, address-of-packed-member)

Reviewed-by: Simon Glass <sjg@chromium.org>
