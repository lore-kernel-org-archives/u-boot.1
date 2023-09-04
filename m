Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F84C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 788308691E;
	Mon,  4 Sep 2023 18:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vj2AXiDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4C9869B1; Mon,  4 Sep 2023 18:49:50 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A2BA8691E
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-500b0f06136so2934533e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846185; x=1694450985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mVm2ZZgCLUHZpuzDpRjUq2S9d/fkSl4f+vvRTyiQyTw=;
 b=Vj2AXiDKjWlGKF1Co0t5XzJ5tImMRHC0ZEyx3uUMXfscnRFMdHIN9KKSLUR0XdqnD3
 kAZ4oXYKvn6ifGqqc5M96VUYcn/L8QBfhvKjh1AZLtTosw7t5YkETn0nYShgoqxTCvp+
 CoLbvp/NtxhXuz5N8KYdKmsI3eH+sSwkakmVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846185; x=1694450985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mVm2ZZgCLUHZpuzDpRjUq2S9d/fkSl4f+vvRTyiQyTw=;
 b=ZFrSMSzYSdGTGcrIOeVHHboRIMOI5PCOxgfRCOmnXS7oSqNnMU2gnqNltmBYTFzgxQ
 kEI8HyU51zLrQ69zdfKWPeMl5aEFwloVGHsafbzAlja5Wa/nRMeEg1zxH0+Y/aIaTfxe
 WHJNtuRf8heTBFpgWQasu8zXDpqdKKCGocn9BAwhP4oY+kEIY1ZZEfrAhY1GysF8Xq7L
 IvCkgltvNLPdb41aNkAQzUbNWF01ldkbyLMiRvhWvzGDxVMfEF1D/aDOQT1KZVX7cKnA
 fwox2NogxsxJXXfQWfE/hlU9EMnL9iuOvcOTfDTc2QBmn/MotDMCeub9cJ1HvA4vPo+6
 c2cQ==
X-Gm-Message-State: AOJu0YwyxKMD1TMoAolZ4tiYX5QfT7o9/LMS7g3IRH6OaI9kh6U7yrd4
 7qdV2ncSj7RoapWhHYAhtMserELhY75i0Jew/1nJ0Q==
X-Google-Smtp-Source: AGHT+IFnZShVwNzesoxuLPql6UX/+mihr2UmKf3YZuyo5hy6BExBk1MF78kWEMo83wt6SVeHw8KinyizdDGi7tW+AMQ=
X-Received: by 2002:ac2:58d1:0:b0:500:d960:8b6d with SMTP id
 u17-20020ac258d1000000b00500d9608b6dmr6369706lfo.33.1693846184523; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
 <20230902073524.87451-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230902073524.87451-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:54 -0600
Message-ID: <CAPnjgZ3AqhF=yvQeS+dT6L6hFMAahuLNYKOf7-hMtCiadYfeuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cmd: gpt: fix calc_parts_list_len()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Joshua Watt <jpewhacker@gmail.com>,
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

Hi Heinrich,
On Sat, 2 Sept 2023 at 01:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Avoid incrementing by moving comma into strlen("uuid_disk=,") and
>   considering NUL byte.
> * Appending a UUID only adds UUID_STR_LEN bytes.
>   Don't count the terminating NUL.
> * The length of the hexadecimal representation of lba_int is
>   2 * sizeof(lba_int).
> * We don't use a 'MiB' postfix but a '0x' prefix.

Why do we want the 0x prefix?

> * The uuid field is only needed if configured.
>
> Fixes: 2fcaa413b3f6 ("gpt: harden set_gpt_info() against non NULL-terminated strings")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  cmd/gpt.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 092f7defff..e7a53747fc 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -162,22 +162,29 @@ static bool found_key(const char *str, const char *key)
>         return result;
>  }
>
> +/**
> + * calc_parts_list_len() - get size of partition table description
> + *
> + * @numparts:  number of partitions
> + * Return:     string size including terminating NUL
> + */
>  static int calc_parts_list_len(int numparts)
>  {
> -       int partlistlen = UUID_STR_LEN + 1 + strlen("uuid_disk=");
> -       /* for the comma */
> -       partlistlen++;
> -
> -       /* per-partition additions; numparts starts at 1, so this should be correct */
> -       partlistlen += numparts * (strlen("name=,") + PART_NAME_LEN + 1);
> +       /* number of hexadecimal digits of the lbaint_t representation */
> +       const int lbaint_size = 2 * sizeof(lbaint_t);
> +       int partlistlen;
> +
> +       /* media description including terminating NUL */
> +       partlistlen = strlen("uuid_disk=;") + UUID_STR_LEN + 1;
> +       /* per-partition descriptions; numparts */
> +       partlistlen += numparts * (strlen("name=,") + PART_NAME_LEN);
>         /* see part.h for definition of struct disk_partition */
> -       partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
> -       partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
> -       partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
> -       /* for the terminating null */
> -       partlistlen++;
> -       debug("Length of partitions_list is %d for %d partitions\n", partlistlen,
> -             numparts);
> +       partlistlen += numparts * (strlen("start=0x,") + lbaint_size);
> +       partlistlen += numparts * (strlen("size=0x,") + lbaint_size);
> +       if (IS_ENABLED(CONFIG_PARTITION_UUIDS))
> +               partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN);
> +       debug("Length of partitions_list is %d for %d partitions\n",
> +             partlistlen, numparts);
>         return partlistlen;
>  }
>
> --
> 2.40.1
>

Regards,
Simon
