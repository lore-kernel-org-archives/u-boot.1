Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E500C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C6E84021;
	Fri, 11 Apr 2025 15:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UV6SVUJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72AEC84022; Fri, 11 Apr 2025 15:02:37 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BEEE84006
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 15:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-54b10594812so2270502e87.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744376554; x=1744981354; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ov0O2dE0cwvJOKjvft/O05/aFfPZiCp/Qtbe6J4uL8=;
 b=UV6SVUJa2Nz83arfc2DyDeuHDnZj0q//AWf56kB6bX92bv9nNSKRUEqILYJElPTTQE
 aqM9VXynvjWlE+KWLY9PERgq9IkAle+qkhk0hFijVba45LGeRf6TKDq5AAnn6HzBxfyz
 jHWps0tHoFD7/GniOzpqWm3Kf2Ti6FmbQrmk3sKSB16dtUgWz3dn9ctS9eB4qUmuIjF0
 P0Ij7E6JMhJ1HhSSyG/934m5QPFW4tyGvZyX7P2aMnj1bYgFd2NLmZgOIuqiHZ6xYSuA
 s9FBaX/t7z5FJJdRd6CR1+o4D/A3NVe86w1FMS4Xk5RT9FdZOvuiZElykP6p1PpHeKE3
 NUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744376554; x=1744981354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ov0O2dE0cwvJOKjvft/O05/aFfPZiCp/Qtbe6J4uL8=;
 b=bfao+b5UCuzOKU2nh+RfZ3hfhIIjbAhaefrn9YN1fpr03uC+xLfhXMLg6anxJbI44h
 CWSupLYsDrSdbrmmUM5iNmS73Kx2hbawLnbDVZLRbz376lmc0fQm1/xHAhKe5npH03Cn
 nBPuiVUmCdQw9gev2K3Jncbfs025hm9hxM4c+win4yRVvEkkbhvrWY6LTghj8rbf67G8
 Kg7PtoTsMfpICW2FzweobBnpZ/AMxJAgRbC+gUKz3xsXPSgCBA4Ud8kCcWavpDKvPeXY
 1/Q9Kb8OSrdsBiuNUd1iXfvLNsQeUabxGH0R6MTDWxrbrRFzedENBYL4IS8lN7XXUazl
 ttzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFhK2uviUhMbOesQWtwMA4KlrBkOZtJM8zEXDMHpfW4MwsVKLCxTJsY75AD6jJBc+2zgr0dp4=@lists.denx.de
X-Gm-Message-State: AOJu0YyeULSLxWIuC9WhKxKDrouNspXlwUnvNSUm0e/7tjrUjehNEO32
 r6vlqg3feea0GgAQQKnEbQLWy7tznnFpfzr30gDVWGNNKbqHSOLG3fwxH97hY0MTNGzt0JzUvWF
 EOaTRFvmlSSc9OcQdl4ISYVCPC2c=
X-Gm-Gg: ASbGncviMY/T1P+9LN7AvIoO0zuV5AcuzDUsfDrWQJRTjvWG5gYd1bBjtq3uPevM/2X
 ppA+mST6A7mdnou0i8f8aq+pS2X8N7/noVm8HZgUxAaxYDhAMGkEMYUU5Vig7tYMqiiDEut/I3I
 vbPAPdtoIlwnlnpgVsVzR1My/Pmb0e1I3+zcbrv+sgqOfsTpd97vBizA==
X-Google-Smtp-Source: AGHT+IHQSmi4prF8bVQa3paMpQau0WcfyBG0StN5udZx1z52x1pmJ7Z7ZYTI+UkD/C3igon5R6fElMCuHciSZutJRV8=
X-Received: by 2002:a05:6512:2353:b0:54b:e9b:db19 with SMTP id
 2adb3069b0e04-54d452c9cbfmr756850e87.35.1744376553571; Fri, 11 Apr 2025
 06:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250409075352.535194-1-alice.guo@oss.nxp.com>
 <CAOMZO5BodWZDVcrZnzy+Qjb9nYks64v6_CFPvxotv1=dWR5MGQ@mail.gmail.com>
 <DU0PR04MB963656129C2D75D1AD90FFA8E2B62@DU0PR04MB9636.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB963656129C2D75D1AD90FFA8E2B62@DU0PR04MB9636.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 10:02:22 -0300
X-Gm-Features: ATxdqUEmfuqA8swyRWzOZnfTBSUNFMJWPZbkGbv25eeMmV5EVKm79yJbCtcaP3k
Message-ID: <CAOMZO5AxnJ8fmKWvA5-Ku-Bdh=CpP6imEqrR7p-QuZnwqsTwEA@mail.gmail.com>
Subject: Re: [PATCH RESEND] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: "marex@denx.de" <marex@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Fri, Apr 11, 2025 at 9:59=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:

> Hi Fabio,
>
> Actual usage is in this patch.
> https://patchwork.ozlabs.org/project/uboot/patch/20250411080707.602371-2-=
alice.guo@oss.nxp.com/

Please make it part of the series, then.
