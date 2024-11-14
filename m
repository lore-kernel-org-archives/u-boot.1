Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AB1D65C7E
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFBF48954C;
	Thu, 14 Nov 2024 18:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uz4IMHGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C8189574; Thu, 14 Nov 2024 18:15:40 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217AC8926D
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B31AD3F2BB
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731604537;
 bh=1y84mrfxaLv5zlCO7FWeCzULgLtmQmzYreYNqbyWoug=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=uz4IMHGv5kAj5a1uqjiipturrIwbJWailFMidLOgg5lG7CJUCYrT78gUO0QTZtMOD
 cPS6KdhaPyhsRLpfgm8UrMFwM7mTFXvHWVr1TULsoeL6LzHIBTM34TlZmtnEm17Ip7
 Kvx4Io+QljZXqugw389j7biGeZZsE1Mq3+G/I56ZRSdrTuvceIMtK0/RkmRw+HicG+
 +gRAfkpoe+c2FiZMrs+XVgGjBogcL8I+JkOQf0nVlA8mjvOwEiUXju3TUByttzmrJb
 sQ8Jz7yKWlGpqjSvNmRMD7y6O+ljoA2EHAU50gdj+O67LxjbqNfS2Hgma/bAYgSYq0
 aSfoKEocmTjHQ==
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-72065695191so818772b3a.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731604536; x=1732209336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1y84mrfxaLv5zlCO7FWeCzULgLtmQmzYreYNqbyWoug=;
 b=Ft3ROvr/haaR+sB30IeByF1VDS5+UGSDKdELF9Hg1XuperZmv7URXpVnRNi9at/khc
 UHmHZDuBi3r9LfQPwTS4wgk8iFO3atn+Gvin5VveMLMKwUyE7QCOUE7pV8Ek7m9a0Npc
 we47tD2W9ApNzJ6EWsAWBWfcmsJXWl/VIa7ADSEY+NrUO4YjKLBKgBMhhdezYlUiZw3i
 Px3b8OqyILBYhNl5a/kzfJsguWdwB+WHQoDujrC7aBIYN6r3FrKz2YtGq/1B8+zvh1O+
 +1AMomcTcwBJ0JR55dSD2EvuhMD+BPn1wUFXWRfbVnwZbruCCz2DwlzT3cYj+6k5bvAM
 uNww==
X-Gm-Message-State: AOJu0Yxllm21V/UZ0Oan2GIgHXQ3q9vEtFbi/StzgN31nblor0VQd9bO
 WOKV7HFsVg188qyStHi3j52o2VDPQEW+EMdPP+MG2ChtrqNiwtC1q1PjqpHOQ/yWOwMtFm4Q2i4
 qOrslLgt1WGPgOADd8fdRynZPqNOJnIk6/PX2x4kE00Q6ZFmt06ZMjdRFmX+mi1R+WOXov8GHQw
 Wys6xz69ykl6bhtxGOZUO6Zwf6fDVnuwR2ClgncloZJg==
X-Received: by 2002:a17:90b:314a:b0:2e2:c406:ec8d with SMTP id
 98e67ed59e1d1-2e9b17962a1mr32511602a91.31.1731604536298; 
 Thu, 14 Nov 2024 09:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTdNJCLoYyT4Kp+W+um4MX4AftZPChch3QjnD15ZF+kOjzZxdWn8lV7xDa5NtKn2YZYu6/+0cRLSQKbAO5bA4=
X-Received: by 2002:a17:90b:314a:b0:2e2:c406:ec8d with SMTP id
 98e67ed59e1d1-2e9b17962a1mr32511556a91.31.1731604535865; Thu, 14 Nov 2024
 09:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20241114171002.2073594-1-jerome.forissier@linaro.org>
In-Reply-To: <20241114171002.2073594-1-jerome.forissier@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Thu, 14 Nov 2024 18:15:24 +0100
Message-ID: <CAM=mAOmfQWhQ+eLwQ4qXbsiB26Zc9FimJhsp93Xi9MTerMw=GA@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: dhcp: support arguments for TFTP file download
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <lucent@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Jerome Forissier <jerome.forissier@linaro.org> schrieb am Do., 14. Nov.
2024, 18:10:

> The dhcp command is supposed to have the following syntax as per
> "help dhcp":
>
>   dhcp [loadAddress] [[hostIPaddr:]bootfilename]
>
> In other words, any arguments should be passed to an implicit
> tftpboot command after the DHCP exchange has occurred.
>
> Add the missing code to the lwIP version of do_dhcp().
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/lwip/dhcp.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 23b56226921..6f987e469d6 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -111,9 +111,34 @@ static int dhcp_loop(struct udevice *udev)
>
>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
> +       int ret;
> +
>         eth_set_current();
>
> -       return dhcp_loop(eth_get_dev());
> +       ret = dhcp_loop(eth_get_dev());
> +       if (ret)
> +               return ret;
> +
> +       if (argc > 1) {
> +               int i;
> +               char **tftp_argv;
> +               struct cmd_tbl cmdtp = {};
> +
> +               /* Invoke tftpboot with the arguments passed to dhcp */
> +               if (argc > 3)
> +                       return CMD_RET_FAILURE;
> +               tftp_argv = malloc(argc * sizeof(char *));
> +               if (!tftp_argv)
> +                       return CMD_RET_FAILURE;
> +               tftp_argv[0] = "tftpboot";
> +               for (i = 1; i < argc; i++)
> +                       tftp_argv[i] = argv[i];
>

Couldn't you just pass the original argv and argc if argc > 1.

Best regards

Heinrich


+               ret = do_tftpb(&cmdtp, 0, argc, tftp_argv);
> +               free(tftp_argv);
> +               return ret;
> +       }
> +
> +       return CMD_RET_SUCCESS;
>  }
>
>  int dhcp_run(ulong addr, const char *fname, bool autoload)
> --
> 2.40.1
>
>
