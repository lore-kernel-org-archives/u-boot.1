Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B0AFF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F25E848AE;
	Wed, 29 Apr 2026 16:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UhJ46AYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C6D848B4; Wed, 29 Apr 2026 16:09:59 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED2F848AE
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba922426c5cso1125071366b.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471796; cv=none;
 d=google.com; s=arc-20240605;
 b=kljPgIc0t6kIOJeTi2Cb6NHFCMrc6ibNcm8D7ZK/qzZ1P/pVRdXkR8S7q78d8GKsYj
 7d2so22nEAGEVTDAzjDKNSiMVm97H/kGVOnfpIOGjXnSSW0a29xypfABx8EXVWe0qyBO
 bDEaRnY4c+a5+huOPu5as6NrArVSPC7JqWjjof+0T44KlF8MuqeFlAOecf6mY537bEyE
 6xBvh+br781j1F85HTpeut2/EtxvldWgl5jFwjA+4NrXb5bc+fLzCfH0c4lfVubJPfuC
 KdIZWUkqDskYJMrh9W/SlMg4n5ddYO6IfUnSMJ5RGs0PKTC79hv0OefUueUBgVeEUE9p
 KPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BGfkbzUt8Cj2a8r6iG4nT9bvlD8W7bAg4HPtvFRsOZE=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=ZI0oxn4PM2iG9NHz9GNyFKcMGWsDBEma9T4mMZxw4+CjN4z2jkpf3Q2UXY+4bw/XFZ
 8QZWnuncKAuvy4FaVkW9qI0sQ08S+oZ+cmvGUCzxtUkefSa+wSxHR3+ohM9ivmIZtpde
 g4WgeH68oYXeKAaOfa75JmmNS7W/9ragLMKDJArGDcceDwDI6fzMYmdcIPQUb/iUvuHd
 y6qWFEMkO/3EXHrh0ZAjhfyRcUQ9Rfx4xUiEmnSfUZjgoRZjmRR5cW+TBM4RB9KO71Ks
 h5Sh73K8yc2CeLagR+/FzZinYfMRGEORtl+RTB7waenrdsGB6b/PrpH5qSLIrjfw01gU
 aq+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471796; x=1778076596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BGfkbzUt8Cj2a8r6iG4nT9bvlD8W7bAg4HPtvFRsOZE=;
 b=UhJ46AYoSNwkQczbXD2OSaJ5dGxWQS8SHlqfv3IhMG5JVNr6KlQmrM4WmLQtzxkoO9
 4wVGf/GeceavDSYQjnM8HccAwEk7RpdlKonarNbEVvPTML7mAgI88lkARAej+E9fe71L
 WUmcZ15T4E9BT44ArhrBmB6YU/+VZCCCT0VCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471796; x=1778076596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGfkbzUt8Cj2a8r6iG4nT9bvlD8W7bAg4HPtvFRsOZE=;
 b=QXwdQTuP6Y8gnVafEYknD9ONzkblVrkoQOHQy5gMqNmZ5myLr4RQnpOfpywDeBGOhg
 NOsAsrKNynMKEAV7C3YU7XVMpR4xfokfYn+v1johP256HHcz8ZwaH5P+11xYUzLXSTIv
 ZYZWLIvR74T4ns58h7vdeekgfRb7mtFFbdlasxBqVkin8Ax2EeDtOObu4aZ+i6hXkehk
 S5A84Ral1E2qGaUnKJ8MUSzvJ5cwKhND7KkggKcBYSwIqbYM94qX7uoMmjPPrWu7eFqs
 ADziqn0t7xCLhZL4+j3iiiK01R/9DOHIdpvSS3044w+EF/gXnYdwZkkRxIkD1qx4aHS4
 HNzQ==
X-Gm-Message-State: AOJu0Yyz29AOJZWiILZi2SHQfKFC0maDr1yEiBj0Pv2xoxOFyGx5zfXL
 YMDbR35unE8uY+VoELWfn3IdVyk8CAUTe2ekqNvQeCuR3GzrAgFTz3VyCFJcWGRMQZx0n52GYih
 ah2ZFsmKJcJDZv8FzNtF/0d/W+UAr7r0QcHqrKQnE
X-Gm-Gg: AeBDietg49BXQ/wjotJ82eCd8wq6ISjMqCE+kRmJoHGeswRSconjMqB0D5NGGk4n1cd
 LLhgkruibrH4CrfSyFwIRC04RUKe1Kr5D/19n8ArJTVi54rZGAwsKLcr7GIeAekwtCu3IMooii6
 ZasvQqCpvEe1APja06k3DNWFu8o50HDetFpXWRkGRaT9HtMynUGCXtHbaigbPKgMjlbIc38HJCz
 sWF+J2Eca54qTLY5BdKmKs3BWUflQkrKQnTISoFM3rYUG8AiovPS0OnFvSpjBgi90ezUFAPZv0d
 uF/1gxE3ifOwDhf0
X-Received: by 2002:a17:907:a49:b0:ba7:b198:7d25 with SMTP id
 a640c23a62f3a-bb8024b26d3mr492831966b.21.1777471795511; Wed, 29 Apr 2026
 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <4d5f42ec120979816ef2d26fa21c350efa8bf37b.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <4d5f42ec120979816ef2d26fa21c350efa8bf37b.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:09:37 -0600
X-Gm-Features: AVHnY4JnBAZn9gyt4yIdIE423n1-O5igUMgW19tfc-0ou1VXlxS98csyHhkzv8I
Message-ID: <CAFLszTh=9+P6sQ90MJsC+4v6MbUcd5sXkuNWLptrsuVNZB1CPQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] dts: sc594: Fix gige-reset line on EZKIT
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> dts: sc594: Fix gige-reset line on EZKIT
>
> The gige-reset line on the EZKIT was updated for the
> sc598 but not the sc594. This commit aligns the two .dts
> files since they are describing the same hardware, the
> EZKIT carrier board.
>
> Fixes: be79378 ("board: adi: Add support for SC594")
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/dts/sc594-som-ezkit.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
