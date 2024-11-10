Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3605D5E380
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 09:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D32588B9E;
	Sun, 10 Nov 2024 10:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IH5m/7Ld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7660A88C0F; Sun, 10 Nov 2024 10:13:55 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39396889EF
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 10:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso2773955a91.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 01:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731230032; x=1731834832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ah1Mgndxk7/dC0sF4aZ1KLKRFAuUXpN7p2f5m7LuW7o=;
 b=IH5m/7LdwsjBjFEkvEtIedJHPZ1DKh/VQVRmm474LdkP5aN3P8OMa3wF2fedlgpORh
 FeTHYnFk6OsEnohWymQGXMnXkUsGq0EwhA+1KIk6EpX53QCsAdY/BDEBF3Blyj6SejX6
 QrWn0oF3Z96EMzvHA6ngJbB38k5/wX4mQfgye/cJwqKJc/cSngU9jG1aTJ9QkNU7fwrE
 4oIxANi+p4CvU2doC/hbvP7uCHccGtx8nOXcez923Vswx8d0rFycXiPwP0Y90/jpCCw1
 CLyORxi8ItdgewZLtJikP7StFU9bxyOOTdqJGS0jMRR5/RAyqK9f/WpsGK3X8vw21rZW
 7KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731230032; x=1731834832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ah1Mgndxk7/dC0sF4aZ1KLKRFAuUXpN7p2f5m7LuW7o=;
 b=IIxPWV+lQWWQJ73QhojQBUYKBIMx+w8oItW1C78DxmoFjJUSWHiqrjFIG8EBUGbeTb
 52AyCsNQ+tltZqpvnAWOXogqULPUeG8UfxfSb/5YLcXMvG0KgcPkVsIkV347RsKtt6Vf
 cJRk6hNo5vBFlDMfcfkBXL6CTnbPFvXwq+WFaqSuCJlZsQCaa3Y75K86F7ZpcMEtusYi
 rEX450xwLYIZRxAWO4fzVBKc9RQ6/dKrOnCIUoZGNxXRwkheoYCpVk/lJDwGcu5a+2+G
 X0GAACzaaDNlwGIo1fS7NUIa0p2t2JourBqZgCt+WaP2hFtwqHClOV3ftfog0qJ7EZDW
 WuxQ==
X-Gm-Message-State: AOJu0YxQtCJpibyIFBNGn/kbHFLHREPKPkpqb0c1RIepPmFRBmQaN7tz
 SGhaKWR/n7wiiYUk1jHO3JzY4BoKgzEpSkILZtqc5L+R9AyqjWHNwINZ1iMd2DQQrP9T97QHH5Z
 z74QjHfNuPJUMIAkLhuI+3O4q8aV78VhuvDaRaw==
X-Google-Smtp-Source: AGHT+IEnRDcPmt3TVCpeN5HYGYd2g8XSCmEThalx2PqF9uxFJze6Raj6o9PZS5f4YhisCXYeWVLtNvCl+1nU6+zrtlg=
X-Received: by 2002:a17:90a:d2cc:b0:2e9:c902:d53 with SMTP id
 98e67ed59e1d1-2e9c9020e26mr3393076a91.14.1731230031702; Sun, 10 Nov 2024
 01:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20241108133850.431075-1-adrianox@gmail.com>
 <20241108133850.431075-5-adrianox@gmail.com>
In-Reply-To: <20241108133850.431075-5-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 10 Nov 2024 11:13:15 +0200
Message-ID: <CAC_iWj+7tW3qT3cQWTD2YtEtq8iQa9omKd14O3TVgi7_ZfM8hg@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] efi_loader: device_path: add efi_dp_from_ipv4
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
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

On Fri, 8 Nov 2024 at 15:39, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index d7444588aa..3e02341224 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
>         return start;
>  }
>
> +struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
> +                                        struct efi_ipv4_address *mask,
> +                                        struct efi_ipv4_address *srv)
> +{
> +       struct efi_device_path *dp1, *dp2;
> +       efi_uintn_t ipv4dp_len;
> +       struct efi_device_path_ipv4 *ipv4dp;
> +       char *pos;
> +
> +       ipv4dp_len = sizeof(struct efi_device_path_ipv4);

sizeof(*ipv4dp) is usually preferred here

> +       ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));
> +       if (!ipv4dp) {
> +               log_err("Out of memory\n");
> +               return NULL;
> +       }
> +
> +       ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +       ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> +       ipv4dp->dp.length = ipv4dp_len;
> +       ipv4dp->protocol = 6;

is this 4 or 6?

> +       if (ip)
> +               memcpy((void *)&ipv4dp->local_ip_address, (void *)&ip, 4);
> +       if (mask)
> +               memcpy((void *)&ipv4dp->subnet_mask, (void *)&mask, 4);
> +       if (srv)
> +               memcpy((void *)&ipv4dp->subnet_mask, (void *)&srv, 4);

You can skip the void casts

> +       pos = (char *)ipv4dp + ipv4dp_len;

That's ok, but we tend to do (void *)((uintptr_t) casts nowadays

> +       memcpy(pos, &END, sizeof(END));
> +
> +       dp1 = efi_dp_from_eth();
> +       dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp, 0);
> +
> +       efi_free_pool(ipv4dp);
> +       efi_free_pool(dp1);
> +
> +       return dp2;
> +}
> +
>  /* Construct a device-path for memory-mapped image */
>  struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>                                         uint64_t start_address,
> --
> 2.43.0
>

Thanks
/Ilias
