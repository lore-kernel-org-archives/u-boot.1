Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD51C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D8287832;
	Tue,  5 Dec 2023 01:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B42CFe9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E2E878AA; Tue,  5 Dec 2023 01:52:59 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080B087635
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d2d0661a8dso58032527b3.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737576; x=1702342376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E/t1Uz5M2bkFIpWyQQ1dqnlbmNNKAaf0saEtg8SRlUI=;
 b=B42CFe9cahOiD3GNxChodVMoaHhjl96FpqE8jx79wH/Ngw6rePM+Q1cD4ls87QeF7D
 O68k4ePqIcXWjyjg0RsOlJJKFCiovaHuEB4Vy6Ejye5UdtQvzCiLVHt/WnvbUBuGHPkC
 ixCy5BQHHm5x1Sqn3S26WCV6LBNR8A46UdwgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737576; x=1702342376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E/t1Uz5M2bkFIpWyQQ1dqnlbmNNKAaf0saEtg8SRlUI=;
 b=iJ5CA2/aO3F2E7gFr7f1JqpBRih+CZT2vg02ByQpWBDtB1XXNBRZeerkrClS0tsT/0
 hts7TgMkPc1TwweRG4uCN23sXcEeiegNQYMC6ij3TK7TWqUgAk7wuX6fLrzuIelIB3j4
 hulSbYW2G7qRsPbIqu0uF2Z9tu8OoRvN3M2j+zAR0UQs+CVy4dtjsaUHOUFrNEIwG0Hv
 TrgGwQ4s61trygQamG3bQCoF14fHmcl3FLZLhPB+Oen8SJ6Xh2ZEYWW+ArmbYhwPWGjh
 yiEK7lsqHZv4J/C6+HslFebtc5OfeYrMYislWa9yA8S2tttjAAVqd5P2reR6zG7gHMIL
 qb0A==
X-Gm-Message-State: AOJu0Yw/4LdM5jOCt4ijQRevYS80JgggXOzM9H0qMsiaTzvzdlDzPfXE
 8BtXwRSr0L/yC0WaHZPdvwPYvTPxpHb9YsDc4+yZjA==
X-Google-Smtp-Source: AGHT+IE0UUECVZBxhPoBGsBwmXsCwFZujAMBSD32sluT27V4V53vItSkXJPX/UwbY4Qe3hFgOPrqG+D+fuN/fEgtuvw=
X-Received: by 2002:a05:690c:c82:b0:5d7:9b1c:a779 with SMTP id
 cm2-20020a05690c0c8200b005d79b1ca779mr3765847ywb.9.1701737575582; Mon, 04 Dec
 2023 16:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-16-raymond.mao@linaro.org>
 <CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com>
 <CAEfUkUKaBotDRyReCLc_R628VzZ1CmaNdq_nCp=kd8iCn5R6-Q@mail.gmail.com>
In-Reply-To: <CAEfUkUKaBotDRyReCLc_R628VzZ1CmaNdq_nCp=kd8iCn5R6-Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:52:07 -0700
Message-ID: <CAPnjgZ0Hxsbv7EHbcnvLtmRSrPgMDfOFS+KmvYBcZgVC1Je4Ng@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] fdt: Allow the devicetree to come from a bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
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

Hi Raymond,

On Mon, 4 Dec 2023 at 12:25, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> When `OF_BOARD` is defined, the FDT should be from one of  the board-specific mechanisms:
> 1. FDT from a bloblist via boot args
> 2. FDT in memory
> I don't think we need a new build option to distinguish these two, since it can be done in runtime by checking whether the boot args follow the FW Handoff spec conventions and the FDT exists in the bloblist.

No, I would really like this to be deterministic, so we can fail if
something goes wrong. The bloblist should be 'declared' as the way to
boot, for a board.

If in the future all boards a reusing bloblist for this feature, then
sure, we can drop it. But we have things like rpi which do their own
thing.

> If it fulfills the above conditions, we can take the FDT from bloblist, otherwise from the predefined memory address.
> This is fully backward compatible without adding a new build option.

Again, we need to obtain the FDT from the bloblist if and only if the
board requires it. It creates a lot of confusion to have it as an
optional feature, when we know which way it should be.

Ultimately OF_BOARD should go away. We just need to push bloblist to
other projects and closed-source firmware as the correct way to pass a
DT.

Regards,
Simon
[.]
