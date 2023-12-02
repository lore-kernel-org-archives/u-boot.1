Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4302A875FC;
	Sat,  2 Dec 2023 19:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lH/QvDZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0E98774F; Sat,  2 Dec 2023 19:28:31 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBE6875FC
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d77a1163faso2643187b3.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541707; x=1702146507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5uH8ck+6AfcJO5md6J8gDvNbCce+wrw6rMwLmiWpaQQ=;
 b=lH/QvDZyIZRDBTOm4Un0woXpW2vgtdkGKQd2bdITicfDjDnQ1Qk/jSKqWVBKSe1yMh
 QsO3e3p26KYOf8AOcHzLGAO0Gd7vanaU7mfMUHEybpCwQy3YmwZERLsGmLqhga1edKF6
 mCbtMzYy4S4ZItFEA4ptFn0ZzN8pobXGVozXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541707; x=1702146507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5uH8ck+6AfcJO5md6J8gDvNbCce+wrw6rMwLmiWpaQQ=;
 b=BCthqkmud0moJfB6eFO2lgYK/ZDsmJn+Iuh86VD85I4zBIZ8i4uJI6+Ueza7oozewQ
 A6LlM2XIWxHnDWpLxtqMjcZcNSNQK81c7B4uOj91xuoGs96eBIbcqhEqvcD/8SCLVvOR
 DTpaoUxMZVqR6SRXao/RaId5i0FXVaEaYfZy25OyZbCsr07o0QSproLX94Ctg9D+m7Jv
 hJL/c0VAoDGJvvsKsaUpTkE52Iqlg0MEdoQWYzs6v9HW7aI38VdvFcCQ8WIpnwJwMM1l
 FoWO2TUih9mHICFBNjtsgowQwue8HowKx+ZuiEY0ApxaylH/xgEyxbCbfdcNRlm5S69A
 Mxrg==
X-Gm-Message-State: AOJu0YwSn1Ovpoz/5y2gyS+rtjKpn8j78rO0mxh2d+0B5so3A2rqyClE
 dJDS/rl1ugUljh6a2qg5+dbS9SCWmiyUXIZR7cdzlg==
X-Google-Smtp-Source: AGHT+IF9e3JBiGbvsDJsiNrAnbTczoClfjcpQxlzrwkuykYx5EB1mv5Kv71TNg4b82/eTCjfWo2HZE/et/PU4LiKd0k=
X-Received: by 2002:a05:690c:f86:b0:5d3:c59d:ccaa with SMTP id
 df6-20020a05690c0f8600b005d3c59dccaamr945925ywb.26.1701541707458; Sat, 02 Dec
 2023 10:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20231122235202.630114-1-moritzf@google.com>
 <20231122235202.630114-2-moritzf@google.com>
In-Reply-To: <20231122235202.630114-2-moritzf@google.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:27:24 -0700
Message-ID: <CAPnjgZ3GQ++-nn4GuUdEHFH2D15P2sPzoZH4O1oBYUAmt0bsSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: Update scan namespace to keep trying on busy
To: Moritz Fischer <moritzf@google.com>
Cc: bmeng.cn@gmail.com, zhikang.zhang@nxp.com, wenbin.song@nxp.com, 
 u-boot@lists.denx.de, patrick@blueri.se
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

On Wed, 22 Nov 2023 at 16:53, Moritz Fischer <moritzf@google.com> wrote:
>
> A busy controller shouldn't be game-over for all controllers,
> so keep trying on hitting -EBUSY.
>
> This change brings the actual behavior of the routine in line
> with what the descriptions says.
>
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
>  drivers/nvme/nvme.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
