Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2227FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8350784664;
	Mon,  4 May 2026 14:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eFiksFK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B53858466D; Mon,  4 May 2026 14:28:06 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA78684664
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso641314066b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897683; cv=none;
 d=google.com; s=arc-20240605;
 b=L56h/vXQSv+dkZGBh9hfSmPpR09KS33wXgwim+zCf1EjYYxK9LHtz7D9FVp+SbhiVv
 arGDMxGMvFHRPvS7ILfnK2iXeimS98zYKxwuFFf9Y9E8swiX9xXyibwlpjK1uM5V+MmE
 3PXgAkfVb7/D/sEwPiDBhv/RlAwf19s3k5Awdad86DQDFcC3RS5q5jr8iFdwREyyC5HN
 A0/lS19omHC6DyXX0HaQ+0LxNobvUBdWLDShqoxOYrL7U0xAHUw3yewb4jivKxkc80nX
 9BQKJXDCm3t+O3L6VRncJwkHpKB0biRqf4Xxs8YtG/NiXWzkOKGern+ENv/XR/ZvLdx+
 aMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7u0CdjLW4CwBvZkTeazF16mMtwbqZKBQ6Fqep+M7rLA=;
 fh=joWFw7uQNAewTc9d3BnbzDW7eparBJAilOzfYIz9J54=;
 b=NjGPaaK0dRwKqDory6rfLC1oxqACpOWWFjI/CVoBjLK2mVrQmxxXKBZn9beoanMcl0
 6VBQCwETYuWS76cS5/nYIBWGJr75SduoUtvYbY4YCT0L+DyhN8uqkBVxXiUP1+ioIMjw
 EMfhfoe2LkdnIvmjWzyaDkDzLEx+eUx/xv7SrXtq9Tt8/qmpxvKDhSyEiygyidzB6qF6
 Rkjh+6VCojh+5gfso6nlFLn8dUWI96DJvuIh9wbBzoI/XkRbgpHHmv8vXLF2q0epgpFn
 YMlllI+/CQ9e4mBvV50u8n6MQWyE/8mJzWX+YB+wMecQsiDHfR9AfwExO6oo2DMIl62N
 5/bQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897683; x=1778502483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7u0CdjLW4CwBvZkTeazF16mMtwbqZKBQ6Fqep+M7rLA=;
 b=eFiksFK1JEZ0LjtNB1VxFIVDGd7zxxyh2xeh4sohkzSSYVY3R52mOU6F+tI7IjG+Dw
 jgf1c9q17ssAhG7fg1fbaHAPWo3zQKkBCml+TkgP6AhhaZSV8ufDXsbrTPZmpeP/3LQV
 MB08R4mQQ0aWDx07m7rqT4aLBZxnhIBuqJzXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897683; x=1778502483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7u0CdjLW4CwBvZkTeazF16mMtwbqZKBQ6Fqep+M7rLA=;
 b=VKVGLEysrMqZNwWXKOirG/cH3ahgMft3MbRjhjze7YXpWyiuJ0mnskRv4jrK9+BKqM
 jvClEGfPFZVWqCFUZCebKcBACtX7MHSG/xIPrWdDNOxpZwvamy5AaE0Er679i1LFFUkJ
 aio5t3871wL0ONAmL6MCgt3uzZud81W2EeH6EbcngO+zWlpdYdXM5Fz976l7jOeqd5So
 RhBsFaZFh1W8DPWBdkEzsXC26lOTYCOtW8uucaivtPKkE7Lpk+jA5gM967N7XuKVmxdM
 ytwU9W646nVrewYig5MO1aVVBtDLVd74Zh7w/mObj2mGVezHRIsmVt5om4OzERkVHjcR
 a/QQ==
X-Gm-Message-State: AOJu0YwWJM+uolFgf5kQ3ADwMLgVDER00ww9EzQ++d1+mNX04V+HpGDW
 AZj8aE4qS4d20KKy0DrkczA+MI2wzPjpGYM1jqchyl1IAiBAsWudTHeR4aLG1ucmCurZ8H5YpG8
 gPNliNolFNrVHoLX7TrOIfuvus0JFjc2RAI9mEv9Y
X-Gm-Gg: AeBDiesdiToq9ErguuHPQ0Bx11m9hVqQsnT2AM8nq/c8yh5+3NhdmYx1A9Y4b05Qjjr
 n5dUGmWH380NC7jXutu0xCLiYlh+A9zH4xvBkSwlQe8RnPTr0BPKOsyFzFHYa+a7UGn7lj4UR5s
 mxSUodd28RsISFIMRcnO19FC8o6ExxhR3qzugyTiEPREhadrWm32YgN6sBN1KA40MTjSLDPk2z9
 jQ0j523LN3cLJ+WxCkneXSzl3Vd8H7eXNMUFrC6lywg2tTha+1peErIV8x74zHnH3eUlMDaf4d2
 8Eik3c43CkNzcpdd
X-Received: by 2002:a17:907:7b9f:b0:bc2:e438:dc06 with SMTP id
 a640c23a62f3a-bc2e4392fabmr133895266b.10.1777897683270; Mon, 04 May 2026
 05:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114250.791663-1-ludwig.nussel@siemens.com>
 <20260429134142.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
In-Reply-To: <20260429134142.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:27:51 -0600
X-Gm-Features: AVHnY4ICaG4CONFrattkZtq8V1pkYy3iDbU_OnoHWp206dptHYSWYoxnNyo4zhc
Message-ID: <CAFLszTjp0dbE6ivZ7CgBF8pEfJacGcV0oRq7Fd7aQzBAN5ggQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] tpm: make pcr_read command more useful
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On 2026-04-29T11:41:40, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> tpm: make pcr_read command more useful
>
> Output now more similar to Linux userspace tool 'tpm2_pcrread'.
>
> Without arguments the command now prints contents of all PCR registers
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> cmd/tpm-v2.c | 54 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 18 deletions(-)

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -150,10 +151,11 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
>       u32 index, rc;
>       int algo_len;
>       unsigned int updates;
> -     void *data;
> +     u8 *data;
>       int ret;
> +     u32 pcr_start, pcr_end;
>
> -     if (argc < 3 || argc > 4)
> +     if (argc > 4)
>               return CMD_RET_USAGE;

Please mention the new behaviour explicitly in the commit message -
something like "with no arguments all PCRs are read; with only the PCR
index a buffer is allocated internally."

The subject is also a bit vague - how about 'tpm: print all PCRs from pcr_read'

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -164,28 +166,44 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
>
>       ret = get_tpm(&dev);
>       if (ret)
> -             return ret;
> +             goto out;
>
>       priv = dev_get_uclass_priv(dev);
>       if (!priv)
> -             return -EINVAL;

...
> +out:
>       return report_return_code(rc);

rc is never assigned on either of these paths, so report_return_code()
reads an uninitialised value. Either drop the goto and return
ret/-EINVAL as before, or assign rc before the jump.

This return -EINVAL bypasses the out: label you just added...

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -164,28 +166,44 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
> +     if (argc >= 3)
> +             data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
> +     else
> +             data = malloc(algo_len);

malloc() can fail and the result is dereferenced via tpm2_pcr_read()
without a check. Please bail out cleanly if data is NULL.

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -164,28 +166,44 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
> +     printf('%8s:\n', tpm2_algorithm_name(algo));
> +     for (index = pcr_start; index < pcr_end; ++index) {
> +             rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
> +                                data, algo_len, &updates);
> +             if (!rc) {
> +                     printf("%6u: 0x", index);
> +                     for (int i = 0; i < algo_len; ++i)
> +                             printf('%02X', data[i]);
> +                     printf(" (%u known updates)\n", updates);
> +             }
> +     }

A failing read in the middle of the loop is silently swallowed - the
user sees a gap and then a bogus banner with no error. At minimum
log_err() the failure, and consider whether to keep going or abort.
Also rc from the last iteration is what gets reported, which is
misleading if an earlier PCR failed.

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -548,7 +566,7 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  "    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo.\n"
>  "    <pcr>: index of the PCR\n"
>  "    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
> -"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> +"pcr_read [<pcr> [<digest_addr> [<digest_algo>]]]\n"
>  "    Read PCR #<pcr> to memory address <digest_addr> with <digest_algo>.\n"
>  "    <pcr>: index of the PCR\n"
>  "    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"

The description still says "Read PCR #<pcr> to memory address
<digest_addr>" - please update it to mention that with no <pcr> all
PCRs are printed, and that <digest_addr> is now optional.

Regards,
Simon
