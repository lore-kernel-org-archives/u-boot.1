Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BE4C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329A380B98;
	Sun,  9 Feb 2025 16:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BkfEpbMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512AC80AE3; Sun,  9 Feb 2025 16:37:16 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A79080885
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso9026816a12.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739115434; x=1739720234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K4KT4k4zq8qI5O3Mcps4GUSp5DUkRbmu7PIkPfQN/OE=;
 b=BkfEpbMZyv77Ke4MSCxkUKMAf/BVIS8zC9dnUy54xBaVerHVc/6dcJjaS6Yq2ewhF6
 R5BZLOpyCQ8axoPCgyhu1UekM8Rj4i1eTfQdZzlPTlMiYVjhWSds4eIYS9prtGJVLge+
 8y1iioNtErSm+ho0GvAnfX9LCkoyacpn/t6MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739115434; x=1739720234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4KT4k4zq8qI5O3Mcps4GUSp5DUkRbmu7PIkPfQN/OE=;
 b=S1kvHYnrorYGrxC7LmjgZxE0+1J+4oL9maviqntVMF1lY4IIqG+0UhsIArt2AbZPlz
 LVjUa/rrFfuJlCqiPZSX/MMyOhnqzInd5b3LHTdZtUMdVSC5HVG1zM1yPWN2YSGOiw2Z
 Zi7EmjbddrrScAcIFERKiyU52J4zMw2jAfFxMsCvjis17YaHM6vc5B2NVHdnHBYtnTCT
 vFJITFWYuD6GyPDvykRZxr93xY1fI8/SeB76f7ticfKSTNX4pkjfUZ7llfyjAslHPUco
 fEWtWuHOYo8b0g21Xwc/dHv3H4QhDtth2XUBqqmYlmylMjrTJcaBt2Wf9XlT1eVwcvoP
 lvQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCg+727sB+rJFomWIWtOXQnHXJwRlwb84m6eV4E5lhNbfX2PIaTs4c6369gnPgxNXilnODWck=@lists.denx.de
X-Gm-Message-State: AOJu0YyHOH/1PO5lWncE1NRl1yT80NhMi4InAjIwxnePBuRozuQ49CEk
 9YlhyP0SmVQZR5GuTfF7Hm/SuyFCRVxa/fc3iUGQW9H9Mkr6ws/aq14hKXdmEY3fyqQV5FO46/r
 DRUINC/9QscgTcIgfkrt93PxR5poDO7n83Z9W
X-Gm-Gg: ASbGncvpRqsLaezH/05kHvWs71BApoo9WBIvSruxEjgJ0ApUkOMOkBvQC6OI1vCYs7J
 oMlPslxK4QMvMFnyw7rmLZFEDIlGEn4XyeN/kpazrQQ2X3pTGICZJJ9pu5Zq1QKzIFVA7au835Q
 ==
X-Google-Smtp-Source: AGHT+IHQ5y7HJwuf7uy2nkP1gbkfOes6SL9yFls6xnn0QhBXzefxPsVsuKRpCYIg90yNWVEwSrxJC4MHq5/IRsMGITg=
X-Received: by 2002:a05:6402:518b:b0:5d9:f3fb:fa45 with SMTP id
 4fb4d7f45d1cf-5de46a56271mr11501098a12.16.1739115433866; Sun, 09 Feb 2025
 07:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
 <20250209152329.187194-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250209152329.187194-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 08:37:01 -0700
X-Gm-Features: AWEUYZlJTT1-zJSFDDkoIKzCaZv8DOLi9O_RfTruOJuwvBPsOkEaSLqNe23L-6I
Message-ID: <CAFLszTgLmau_KmxJfDLt1G7j6MtW8ua467aJ0udhL4hLg6srrA@mail.gmail.com>
Subject: Re: [PATCH 1/4] riscv: dts: add OF_LIST handling to binman.dtsi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>, 
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
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

On Sun, 9 Feb 2025 at 08:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Binman can automatically generate device-tree and configuration entries in
> the FIT image based on CONFIG_OF_LIST if the binman node includes the right
> sub-nodes.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/dts/binman.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
