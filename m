Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496E7CDB483
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CAA867EF;
	Sun, 15 Oct 2023 09:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RsnHSd88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6527286F3A; Sun, 15 Oct 2023 09:54:20 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DC686F32
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53db3811d8fso7094431a12.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697356455; x=1697961255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YG9x5llxPVbRbwADArm/RDfVsWmzbNQePp4Zh3ab6Jc=;
 b=RsnHSd88PbCEb1XWKRq7sgI/9Q7+GFlbY2KxInH661cMumR2WrQXZicBLXau26Dz2U
 8Wu7QVfhy3fG0bKxL0NSAciNy8C25BTpXDcoUCWKtoKb4nj+z+P6vqmfNmyjInYNc5Zh
 1tpfzkAV+cTKkX4qYcRGiqJC0ZiTOuO482zto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697356455; x=1697961255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YG9x5llxPVbRbwADArm/RDfVsWmzbNQePp4Zh3ab6Jc=;
 b=aScBD4J13lPuw/zz2sbL+AdYO+drLlAOvlUPniuJ9FpQBUnhO7bEd2bn1ipRCbl8gf
 OLT22w8rIkRqetd1ZnN3J0WDKp66bQyoXbmmqmFSotMzsi9KCQ3f9eYcm6tm3bVXdhkP
 1oedboDxUxiEEz4YmgcP9dph7ePNAax5M9FGJL9OjooXvEcs+fi+J/FwxVa065bfSrnn
 z22sRpjLPwFIi8rlachz5pqKz0aJZHpt6LUfdC39yhPN4d1Q4NVodwji58mCOsNNUvI9
 tWZrVHbShKVRavkBo3AwRANJp+y0H0Uk+92Pl+tyuzf3tbOMSnFx1wTnRJi4XQu2HtKN
 Hjcw==
X-Gm-Message-State: AOJu0Yx3+xvy1NAhifLWv93sSHdivid1QAzZcRST+l+/z/Yb7vbcLUrF
 ouowMeeVp8W7lAM8cwo3KtAQPa1WGc86JIHfxybHhii/n6WiP+yTN6YhNg==
X-Google-Smtp-Source: AGHT+IH6UuzvFY0e8fdqff1AaEfngYJSRgFkooXrDv9DF+yxDTGeSvBXRQQ6GwLs0UmmAJrNKjc/jyj0bvVkqwAyO74=
X-Received: by 2002:a17:906:ee84:b0:9bb:a243:e6fb with SMTP id
 wt4-20020a170906ee8400b009bba243e6fbmr2667381ejb.3.1697307649651; Sat, 14 Oct
 2023 11:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <6736fbdd-4ac6-fdc2-10aa-193b574ecb99@gmail.com>
In-Reply-To: <6736fbdd-4ac6-fdc2-10aa-193b574ecb99@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 14 Oct 2023 12:20:38 -0600
Message-ID: <CAPnjgZ0=TREY6qmaytEKHWje3CcvQn5eJG_qNWZu9KRGEYDZ7w@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: configs: sandbox: enable rkmtd command
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

On Fri, 13 Oct 2023 at 22:21, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Enable rkmtd command for testing with sandbox_defconfig
> and sandbox64_defconfig.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  configs/sandbox64_defconfig | 1 +
>  configs/sandbox_defconfig   | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
