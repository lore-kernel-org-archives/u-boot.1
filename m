Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C39C7EE2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3DF88B27;
	Thu, 29 Aug 2024 09:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yd5gxV3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6631788360; Thu, 29 Aug 2024 09:35:18 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B0A88B40
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2021537a8e6so2411735ad.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916915; x=1725521715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GSrGlocPfRoNWG4khYv0nzEXTXIbwZNjkY+YfTtbw6I=;
 b=yd5gxV3XKPKIMppVjUBRgLDWX7Td4Dj5VlOeUXLfOWAZQQmhQ+7Loh0wGAMVN7/W/q
 /zUL6p8BIZ8gi5RMdBOIZLVioTp1HnNv6pjaQk5r8PeaglFLmiV3HwbhcrTmmOnfh3A2
 hvs9zIiETWTVAXLFk4JH8VMReq04rvqVWwLgBh4BXmSf9yD4wpqxmX+zOfQZIERrmwy1
 wJi5CaGVBTDgE0mCjIRSpOCoDLVWPscgfR0nfvJwbCtievIypS6RxdozB0979y1U4GO0
 CEzI8kMBLuZTf9o1lwKuNRtDWuv74NLlglTk+yVIw47il/lUrS8XaU198GpauFImqkGQ
 mRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916915; x=1725521715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GSrGlocPfRoNWG4khYv0nzEXTXIbwZNjkY+YfTtbw6I=;
 b=vKRYvnqxxKJHdq8muUCIA9MwmLs4+NV/GhWE5N/xmWLiClWlNBw5DwebRSIQwPPusS
 DMEWYWK1BK/SFdF8xRSFscpO39Za6PIk4yDOvPfVygZ+HuscTPqrdrZ/hHnXeBp/t/JP
 HQYqJUz8G5w2WTNTJi/6F7oEwkL2uu1CHbe3jNrVqGIQRt0IJb/u3mLWeot+nkdOzj/D
 XxBn9w6NyYRgAqQs+Q3HRpg5/16+5Wmljv/KfJvNFPqxE8Zf3OYygQ/4FYMTYzdIVUZQ
 7uTHIX3ufEbicFKDLzSsozRhGUYFm2watqWw4DIlgx7cHvXe4ARbcpotZghPFbNSgsuz
 5jZg==
X-Gm-Message-State: AOJu0Yyfj52ScuvvSMEca1p2PcSm/+eaplVP1YnIrW4DnIs8C7pJJbYH
 +soLpIumSpL7FFSc1z2STXcWCzH3GWvAtQxTv/VRbBQ/Z9vlgSD2yNYPDzIVGyMKkypYDZpzPQi
 Khi+rsQ8v9CxpZw8CmWC7UoRUEx4p+7S+Ep/KMw==
X-Google-Smtp-Source: AGHT+IHSps2oz2qD3Gvd9i+T9+yMY4hKkao520aCkdGnuvRDZ75RFHWzscHMpJ/PojDXQlf6mfnNwBHiG5nS5ylkvns=
X-Received: by 2002:a17:902:ced1:b0:202:100f:7b9b with SMTP id
 d9443c01a7336-2050c3d0c7fmr20345185ad.35.1724916914527; Thu, 29 Aug 2024
 00:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <f58fb904ed74d2f458d58fa3dc42a6c0914627fe.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <f58fb904ed74d2f458d58fa3dc42a6c0914627fe.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:34:38 +0300
Message-ID: <CAC_iWj+POgrCCPiLA41QCo5WSvhGaMA7USA7ameD_kU7mycaxA@mail.gmail.com>
Subject: Re: [PATCH 12/13] test/py: test_efi_loader: add missing dependency on
 cmd_tftpboot
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> test_efi_helloworld_net() and test_efi_grub_net() depend on
> cmd_tftpboot so add the missing annotations.
>
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/py/tests/test_efi_loader.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
> index 85473a9049..7c1e0ffa59 100644
> --- a/test/py/tests/test_efi_loader.py
> +++ b/test/py/tests/test_efi_loader.py
> @@ -149,6 +149,7 @@ def fetch_tftp_file(u_boot_console, env_conf):
>
>  @pytest.mark.buildconfigspec('of_control')
>  @pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
> +@pytest.mark.buildconfigspec('cmd_tftpboot')
>  def test_efi_helloworld_net(u_boot_console):
>      """Run the helloworld.efi binary via TFTP.
>
> @@ -178,6 +179,7 @@ def test_efi_helloworld_builtin(u_boot_console):
>
>  @pytest.mark.buildconfigspec('of_control')
>  @pytest.mark.buildconfigspec('cmd_bootefi')
> +@pytest.mark.buildconfigspec('cmd_tftpboot')
>  def test_efi_grub_net(u_boot_console):
>      """Run the grub.efi binary via TFTP.
>
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
