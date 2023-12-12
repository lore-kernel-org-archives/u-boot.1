Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6E3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F84D87833;
	Tue, 12 Dec 2023 17:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XwCIZS82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BEBF87821; Tue, 12 Dec 2023 17:15:24 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE2787833
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c68b988f3eso357501a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397720; x=1703002520; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9N1wtE3mukP1Z79Fxjb39Qf8jATmWNB67btYG82QWt4=;
 b=XwCIZS824+uPcSc3aEYQ8Jx0CeOtgQgTvsxE25mTGy3x8amOj/LqGg/ZS3mMG8H7Bq
 D5UqlVlggKJE9Tt6zZEwiLHAcqdIrFUkW3RPjvJNQ3J3PrnsMtc4dpDR3ZNgI2+PMyLO
 v6KQeelY+PXc7xhKzKYqZ1ZKy02sH7oE1yMueGEBKpSDWiYlvNjcto8oTABmKU/YygFr
 7/Od1UpQ1SlouINySNxpLgHlOH/S+pVM1cspW6Z2LYbnRSie/3Zqtafwi12Oh6aZWD2C
 gTZi2rUpEYz4cynB/VvlGVw4nICr5cK0fH5i+xJm+axHw2B+1Silw1YleLnzarv6vIzC
 rMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397720; x=1703002520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9N1wtE3mukP1Z79Fxjb39Qf8jATmWNB67btYG82QWt4=;
 b=TcoGjQYW/A0NANVQXwOLGPWmUTH2Ox6H2fbLsmZnh5OLyDz2hRk3gpZ9A9aLBKVtmg
 WUsVbR1JQWvbFaudLYN1Z+p1VC6sbrxrBvAzAgVKsU+N2LbUZ2E3CWDqIYXdvDfCD+2K
 52n2bALc5Tc1I1toBRD0On4SBa/FB1/wHNO7PvriX77ZFxM3l/E5nYlc6xLONuyLT652
 DUDaRmjcxYkKJj7GSRCcpPXxYKbUOFgNuiqYcbVRM3W3O0HEh/W4M01awpHXpOOByMQC
 sjsLBpdlmaZhFJIyd6UuK3kiok3tx7gJfh3UP99+8BdNWgQREJOAeO6kkOjtei4hv2O4
 09iA==
X-Gm-Message-State: AOJu0Yz5xz4vrYrFhFkwkucQUlRIT+YycfgM/3Rso10XZck8j/9xa3Dh
 K1NkVp028dGlsmKbZOoYH0oexJLGwo6FxOjzg0g=
X-Google-Smtp-Source: AGHT+IFW4GnseFeDcTubbNiSqSn0vecHwbGl/RmdLMmzTgciwV+NAQt1x4RsNOOfBSEbcHDoXrUhkT+6hBVba4C55KA=
X-Received: by 2002:a05:6a20:244d:b0:18f:d0e9:89c4 with SMTP id
 t13-20020a056a20244d00b0018fd0e989c4mr15140831pzc.0.1702397720157; Tue, 12
 Dec 2023 08:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20231026210153.26886-1-festevam@gmail.com>
In-Reply-To: <20231026210153.26886-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:15:06 -0300
Message-ID: <CAOMZO5CZ-jBmEz5Oo428EJHCbfqG=7AMjro6XbWdt+ThJaU4sQ@mail.gmail.com>
Subject: Re: [PATCH] pico-pi-imx7d: Convert to watchdog driver model
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Thu, Oct 26, 2023 at 6:02=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
