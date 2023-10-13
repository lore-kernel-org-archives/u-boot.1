Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3FCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C5C86EEC;
	Fri, 13 Oct 2023 17:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GmL5itph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE8AA86E77; Fri, 13 Oct 2023 17:15:50 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C6786E47
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so3893758a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697210116; x=1697814916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jtK+8j8lPRpv3dOWBt5Zf22413PchOAX2dYefYiC9C8=;
 b=GmL5itphiq8dVnGNpzGOPnhrlA0rMILR+Y2oxDfTNtS/CDiQPWv6B019DHOwFOc34H
 r6SQF7s0zzBbWy5V0WrV7FNBYXW5/Xo+w3CSiFO1CvUi4Fi8uUZmGzTcfLGwxHPx00sj
 9/S1EKOOSCyggXpfv/mK9bg4IC8kz89XKgA+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210116; x=1697814916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtK+8j8lPRpv3dOWBt5Zf22413PchOAX2dYefYiC9C8=;
 b=o4W+MKHk8ZvZ87sNNozr52UEaFglb+yjzmXe6WyhCrOeKn90jEHBCFRSv1AW9xbpmk
 JpDqSiGkkxcLCmiHnoTxoCLVsF7joRnpXao/Ak2MD2veazMC6EYb9wDMm9Aru0EGwVaJ
 eHcq3sYByaGqSXqfFw5CufJIU5EQKPl5eW+YNf7GXUumvAMuY5rGaclDucJ0DBuyX1Xw
 d/QrsuRvrb4PYmoxIaGOTdIzH4uhthj894KseZLN6Yz+B4zZygSb4SLXYJoB5LH55Tno
 9xlfLr1iPoB0pobX/Jj0PA22GB1HXldxa6ODfLY0yhjDoZS+oZsWnDhOHLJhNbNqlbnR
 gyuA==
X-Gm-Message-State: AOJu0YxpOAXgRcpu1TbdRqQxWS2+LJ/ELaMu5zrcTawNzxhaPie2tzJl
 2yCoJgm/XpyqK84K7WPj78oVg5PfnDugskpesw6VJA==
X-Google-Smtp-Source: AGHT+IHyD8PbqlhZiSQwjoHlz7VLdVH2N7hGm9Jg9oiIe5aTziZ1g2zqiQ2xV3+jmZ4SG8WI0Og3znLM4hwAnG9ohq4=
X-Received: by 2002:a17:906:3089:b0:9ad:c132:b93e with SMTP id
 9-20020a170906308900b009adc132b93emr23596307ejv.28.1697210116547; Fri, 13 Oct
 2023 08:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <95fbbaee-2c74-a788-e016-52b269730b2e@gmail.com>
In-Reply-To: <95fbbaee-2c74-a788-e016-52b269730b2e@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 08:15:01 -0700
Message-ID: <CAPnjgZ10vekHZLmp15qXk4yN4-rb+c0AhjqO4gVS+CzoKKmWrQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] rockchip: doc: add rkmtd.rst
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 u-boot@lists.denx.de
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

On Thu, 12 Oct 2023 at 13:52, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Add documention for Rockchip rkmtd virtual block device.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> Changed V3:
>   New patch
> ---
>  doc/board/rockchip/index.rst |   1 +
>  doc/board/rockchip/rkmtd.rst | 105 +++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 doc/board/rockchip/rkmtd.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>
