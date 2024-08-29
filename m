Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BEDC7EE31
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155B7889FF;
	Thu, 29 Aug 2024 09:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KRsbG0F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D52A889FF; Thu, 29 Aug 2024 09:35:02 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D909288360
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-201e52ca0caso2310055ad.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916898; x=1725521698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c91GxbrLHzhwdNSwRl57LYi1SW/oRJqZ1vg6TKb+HZg=;
 b=KRsbG0F3gmrv5+YQoppeaz4kIIJ2h/efr/l3UE8J8kIqhkdvnwdCRoYZIa6nlMyEyI
 D6HOILXYDYHmgYYKiaCDcJ9RFOeTZrJBb+FEIzBNj6THM/j3lMPE0DlIylUU/uBlJ59Y
 6lAZEfO5QAlXBrJ5ThUCzydWgVLsVi1V42I65A3ph6y0j/7DuUu0Gjstc3RObD2bir/u
 7EE1mN+qEGBhHd0neUuJZh3x2jCRbQvK2/MT2pWU2vuLB+ojyeBww/+BcKGZJ8qwDMN2
 b3wbaf1MaLkiO+siL3/tINd1xQl/Xw8lgLLkSC2g1S7YN1xBhpESF+2H+kKHXlSIQS+W
 Ydnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916898; x=1725521698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c91GxbrLHzhwdNSwRl57LYi1SW/oRJqZ1vg6TKb+HZg=;
 b=PORtp34eTTxdBsgHJdczjshBTmOPWX5M26EOHDL/8Jee7VHZUuRbcoyQlORl1hCiVD
 Oz9HJwSAp9loTuZWLSaQcS3Y5hUEYNCrxR+YdCIBBSbFA3IvuKK3vKl9sC5XGXQcLG80
 /DSsnjZ1G3P4V0EPlXz47tzL/A7uIx9zQxPqtl9bM4q15Cv6/BbJLm+uvSoRxm3Z3V81
 zy/yi1VfvJT7fer208FNcoXNavLb8DWj6u74sUIxafnILjsMlgRtajCdZrrQvCGoCmt8
 WIc98tDxq79hrFtzUyGFLs02j8Su0IK/jPdZ+nMbyjX0Y0oGbneIJti/hZs4vv8f5J7o
 Y5cQ==
X-Gm-Message-State: AOJu0Yy/HspZygVPOIE7OE+PgdzQkpTD9T44hqUR7+U91t47EawmppQ2
 pS/3w2vHVDTFxnHJusHNZdb0ZMl15qeXACodwB+55kKHb0JOlFxJLtTc/De8mFjmaR2lcNA7mF7
 GTe2y6LEeLyIpxehjMntaOLgMafEGzuSjihtVlrORQnNOahDK6Yw=
X-Google-Smtp-Source: AGHT+IGSh5qjWjyB1zDylm0W+iRA/GtkB9J1TgrSaINLnoy3XDuyZnmwS8GVwmYesBfS4X1FtLwrIN1S/MzpyuglNnM=
X-Received: by 2002:a17:903:228c:b0:202:3617:d546 with SMTP id
 d9443c01a7336-2050c4b6829mr18070755ad.62.1724916898145; Thu, 29 Aug 2024
 00:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <418bd1a5d16cf1e0061fd499ac82bef5bae82f68.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <418bd1a5d16cf1e0061fd499ac82bef5bae82f68.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:34:22 +0300
Message-ID: <CAC_iWj+hRTeTdnzzJ6QYwrz1Pte3aNK-omcO_e_15R=f=D8zbA@mail.gmail.com>
Subject: Re: [PATCH 11/13] test/py: net_boot: fix comment
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
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
> If env__pxe_boot_test_skip is not present, it defaults to True not
> False. Therefore fix the comment.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/py/tests/test_net_boot.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
> index 63309fe82e..d7d7435692 100644
> --- a/test/py/tests/test_net_boot.py
> +++ b/test/py/tests/test_net_boot.py
> @@ -75,7 +75,7 @@ env__net_pxe_bootable_file = {
>      'check_pattern': 'ERROR',
>  }
>
> -# False or omitted if a PXE boot test should be tested.
> +# False if a PXE boot test should be tested.
>  # If PXE boot testing is not possible or desired, set this variable to True.
>  # For example: If pxe configuration file is not proper to boot
>  env__pxe_boot_test_skip = False
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
