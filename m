Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7C1E784B8
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5819986DCC;
	Mon,  2 Oct 2023 16:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AaiziH2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C38886DC3; Mon,  2 Oct 2023 16:37:25 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC4C86DCC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d818d65f23cso17926161276.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696257441; x=1696862241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iSk68P+7MRTV4TFOLJLOK9zSRhUDiGHcyj7vBgTR1pQ=;
 b=AaiziH2TLsZqSTb03oap05psjc+fCqXf+Qbp1IQHUJzdYT8LEFa6mW0dNvDr3v7juq
 tQzpouskKctVaFoR0KEeleXyteFlkL1Dlg11/nfaykvrShnU0gYER9afiBmtZ3wNMT2I
 bXgckoFYPHSP8jkTazzdgzTOPc2egabyT46nZFY+YyK+vG/DDeHyq9gsJ1eqhei9oq9F
 eDzsgZxE6vq2hUTnqdDsTlIaMto2fODdZpLCcBLAi/YCpMCAP6aIZjXkv6TxYCeoCc53
 KT/jU455vFAA3f4EnDcuZgLzvNVvNbyD3zgiyYjUMI9LzbEWBj5bmirSTVtCD7/dz1MV
 HwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257441; x=1696862241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iSk68P+7MRTV4TFOLJLOK9zSRhUDiGHcyj7vBgTR1pQ=;
 b=CA4zBJ/LbeETkCw7WZFn3bq/OJ/sNz3pLuUF8mWbn3hfETRHZITSHbkL74QkYPRY2N
 +MJKSd9xNw+9814AOKvYqZ3bAVpDCbkngYBeIJ64mVdehNVlkySQpb6GKe6HbZR4jrwq
 rWYJghWvioPOtRTryC3Ept36o2eQ2p3dCyanKKyoUkcymcPg6vlwtC46Tj7u74326ujY
 xsI9h7oMGSc0atkNtmEzGWxJLBUT/BIObmYq3EUZP+k1CxnxXKS62lWdBaobDo4RwTTt
 SwSshQor/VR+lo/nAmXOmrSSb3ft+4HrM6/LUDfK/wSOXBctCJ4Sa2XZjJu34rowPWxe
 f/Pw==
X-Gm-Message-State: AOJu0YxlCtCshqvIXLWvlU5wWSUwK4FnXZ6y2pEEhY0Fa2pmhtDmz8js
 v2LPIZnuCELz1jphhTwqvFg31jxf1DNeYWJAx0I=
X-Google-Smtp-Source: AGHT+IG4iaSc2Y5Y1oCkhZynkBuenakGs4AWDa3Dur7B/I/XmMB5bUyae8wmDXltx1lhZwzB9H1mgrtzuJRDlWAl4Tg=
X-Received: by 2002:a25:dd1:0:b0:d62:6514:45b7 with SMTP id
 200-20020a250dd1000000b00d62651445b7mr10952190ybn.37.1696257441641; Mon, 02
 Oct 2023 07:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <20231002134621.94786-2-miquel.raynal@bootlin.com>
In-Reply-To: <20231002134621.94786-2-miquel.raynal@bootlin.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 2 Oct 2023 16:37:10 +0200
Message-ID: <CAC928Ha_dkjjjfdQdFMiU34UQgfoNbP9zavPDtboADWZrBYD8w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] usb: udc: Try to clarify an error message
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
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

Hi Miquel,

Il giorno lun 2 ott 2023 alle ore 15:46 Miquel Raynal
<miquel.raynal@bootlin.com> ha scritto:
>
> At some point when trying to use USB gadgets, two situations may arise

[...cut...]

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> While doing this I really wanted to add "much more" error comments but I
> faced another reality: often the messages are there but use
> pr_err/log_err which is actually silenced by default with LOGLEVEL=3, so
> I consider this unnecessary, as decreasing the loglevel will make these
> messages appear. I would have expected errors to be displayed, but I
> understand it makes the binaries even bigger.

This is how it works for pr_err but not for log_err: if you are not
using CONFIG_LOG, all log_xxx with level less than or equal to INFO
are in the binary. On the other hand, if you have CONFIG_LOG=y,
log_xxx are left out based on LOG_MAX_LEVEL value, while pr_xxx are
left out based on both LOGLEVEL and LOG_MAX_LEVEL too (due to the fact
that pr_xxx relies on log_xxx). This is quite confusing IMO. I'm
working on a proposal for a simpler and clearer unified way to log in
U-Boot.

Regards,
Massimo

> Resend: no change.
>

[...cut...]
