Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C2EC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 003A8876C4;
	Wed,  8 Nov 2023 05:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LeRC4CJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2BE8770F; Wed,  8 Nov 2023 05:26:46 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E73F87703
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a8628e54d4so3928827b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417603; x=1700022403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FaGuYqgFZeAnKkBw2IDQPUD57mMjpPiFXJ/AJWQkD4I=;
 b=LeRC4CJDOO6fPrGExZDyG6GjWu8Hq0SFMdwgUs8qPRFAjlsNtv6KYglVBpxY8q/y3i
 MSagRhyoKVRQu5NEF9dFWVt75qMuqCgElU45lMJU9hDLbv0+gpP2rDfmbhu4u7SV6EHJ
 JrTR7H6e38PK1GmdOu/l3CP83+ySGoXXuFAGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417603; x=1700022403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FaGuYqgFZeAnKkBw2IDQPUD57mMjpPiFXJ/AJWQkD4I=;
 b=almmVs7Wla4LTTQFFe91tSCioG4WvAePQ/j9RSxy54lCCSZAW68SJZgMzEHinaLsgf
 W1q8llFgnB6uIFskEq1i5XAjKQMk6PkN6qM07DvOjN7AFT6z9AEr6YFXvPzC3I7ZU4ai
 ie5ON/shqITQbCprYYdEE9Y1DSdkWRzFtWwfuS8dbQ14ZHDz6yeDNtZA1I/7B0RgUpYb
 FSEMB3MlSGgvmz/4t19uQE8OIlD80j36PU3apsaWksS35SVTKnIYHJUCnzrG6OlztGeW
 C33NkOYVWjmVgq+U/4fzAx+2dM/oMDqBjf/FkRRlvUJuQDp/sMjH+BEij2Ml4EwfC3me
 AZqg==
X-Gm-Message-State: AOJu0YwWlBO8VGVJnBsStDfe8DpguNtA8wCIB4w8FMNRhy8xcRdKQP1v
 6JLG3uVygz5Cwe/lqn6ciK4wqd9FglId6oEaBPD5hg==
X-Google-Smtp-Source: AGHT+IE+6Vd9rLm5TAFQfTJ7/zFeOvOUuTw1mO8bzs1coDT2WlEKyJrNsyRUZ93u6yGT15nar0tU5QKAXdOYad0zr80=
X-Received: by 2002:a81:84d4:0:b0:5a7:fbac:4ffe with SMTP id
 u203-20020a8184d4000000b005a7fbac4ffemr3505192ywf.22.1699417603217; Tue, 07
 Nov 2023 20:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-12-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-12-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:55 -0700
Message-ID: <CAPnjgZ1noU01Up-JPnbFnz=vpkX0QBa64YLOYpr3L=1WCdgbLg@mail.gmail.com>
Subject: Re: [PATCH v6 11/25] spl: nand: Remove spl_nand_legacy_read
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> Now that spl_nand_fit_read works in units of bytes, it can be combined with
> spl_nand_legacy_read. Rename the resulting function spl_nand_read, since it
> is no longer FIT-specific.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/spl_nand.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
