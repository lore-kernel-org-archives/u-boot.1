Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E3DCD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDCD84884;
	Fri, 12 Jun 2026 20:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H4SJ8LHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D8EE84895; Fri, 12 Jun 2026 20:23:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD448056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6919f40a0c8so2334129a12.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288577; cv=none;
 d=google.com; s=arc-20240605;
 b=PmwAVjBvWHV01gbJnoZhXjVqdxw+nlKq8nEspSQyUDFEYQpP6Dsm5nZ3o/jERD15xz
 h7/XBCg5+2cWtILtP6PR0sOyh/HBsHzi4MIyySgMXkWSP2Akwmr7gj0QKH4/b8wCiZrq
 CrhpYQZrln2z3ovjMSReGWVFvO8qaHvU1QT/JnqDXuWTSpYIqxkVohKz06mz9akcYvac
 Jn33C1LjSEmD3P270klx64Ikc9yNor/fkwS1NtkrFTz8H/KdhczDL5zkAndLF/8+Qh+i
 louTxHmVuLRUWqS4nwsacPUztuN8A7wiiv30YzidXZ7ifcPLt+8wNDmdC/tAhz/DuRaE
 Jz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5P0YIxI8+lYPPcWzGlszm15MP1SlRekqgWOnqcFxqrc=;
 fh=gNOd5VoWOThJSezvTZCfMINjufFCHR/n3KUZhadKTwM=;
 b=IsBJct7Tne/QA8B3I3RYKgAVgY80EPt5vptbzUHjbDptEJXn1/mD7x0o/JVB0cpmtj
 aemBfuP9/Hzyl5elcWUTmQX1DQJpf+ftJIZV/Erx65ywNCCDeQPQGb8XD9vBWPN7RV38
 eBUsVcSiqklOUSDpHsV2S8nRMIvVUlLswB8xxtDvYNkUrWvkGdjkBSefgwfXMBJMBxTe
 TTxtF+U9+jHJ3v8Ze8SHQc/OYH0p7I7F6AKNhzSIifF/3o8L5zhD/XPu5lCQOuovk4MJ
 wIy1fFfWRWIWgTj9DubVB4yy1OBYayB3XJkY8oNISL6z8lWqwktX46cBwEh38IQZijAp
 CsXQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288577; x=1781893377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5P0YIxI8+lYPPcWzGlszm15MP1SlRekqgWOnqcFxqrc=;
 b=H4SJ8LHk4cLUsWATlAAtF7a87iyq9k4QF86VyERUqyqwfqnYVZjW5iavvoWHqlwQVR
 6uy0uYjWWmT5OjmKNaNEjKxZsBhFvzjHEWvBRjUwVsefSgj8F5HyIYS/t7V8toDdnE+2
 KwnccyAhSYdAo4/B8s1teNEoKzKRsIKrylTDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288577; x=1781893377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5P0YIxI8+lYPPcWzGlszm15MP1SlRekqgWOnqcFxqrc=;
 b=p3cs0zwOCGT6AfIMVkTHLaQqdPVdzooB8i0XH0zVWB4ww9l3SDT9+ytIesmXlA686n
 +M4vNJk2/ImxF6OgQhMCtQHyM/hwkdtGN20bHzbvLvtDXxFB6ub1GmtouWR5MPQNSHGK
 gAmndGLU5kv2yZn/gGgPclLiE3HbQdz0qfvGRZza6vhQtjkb1sSyIeobPNwnLmt0Z3Fv
 QmvCoZ5/j5MynsN1kt6Bil0vFGJ4quqn70CA3hKKdGJeS3izAsZshAR1j1fKgWktYZd+
 wq6yPxkwZlo/mUOl6NyicLPJq00yEHrloMWucRkMwUEIVXhaY3KNa8sxeS/eR8Drnw8Z
 xunw==
X-Gm-Message-State: AOJu0Yw4xg1beXuhYJtoQ6YP2uKWmNQ2m2F81ujBabedXu8Xl/jfUWJX
 FUjApmD2J0JSs/qFimib8EqmjWPv6VggX+iXrCf9TZqSLU9Qp0ULUOH0PelGHbzuU94ING8EO5J
 bpOeyB38tpQH1qNKTDrlN+Kuj/vswNFdxOXdEKe1N
X-Gm-Gg: Acq92OE6bQI12gTm8x9nSsii32kPjDdg6YAalC+ZxY+iTAX3leoMQioFmSW/dMh5PZI
 NQVcZFYaWEPUwOjxJdjEEdGoZGBCOkxKXm9XLCN1+7AdDxmuIV7JOVGSWmG+nIJgMGcGaOyolko
 yfFVm8zSIhn6cq7Qx5zJr8BeQhTAH5WbZvkYkPql0F+p+Hec9tZzboBttOdCyMMq9vIRFPzFkoE
 GYqtyVJnBVhhnDjyOCRhyYGpchPkCd8s5gdIlbmGSl8k8BVcJUwflQkjLxO2nb6DQ/7bo40mftS
 zSuI3O7AH9gC8IZj
X-Received: by 2002:a05:6402:5d6:b0:687:261a:3391 with SMTP id
 4fb4d7f45d1cf-693c6a0fc25mr167282a12.6.1781288577535; Fri, 12 Jun 2026
 11:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260524151431.72296-1-aristo.chen@canonical.com>
In-Reply-To: <20260524151431.72296-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:22:44 -0600
X-Gm-Features: AVVi8CcxEVYErnxIQSiK3tE_vPMTcQH5hx-7y3NKTGhY-flnru5t-AqJ-N_oCZo
Message-ID: <CAFLszTitaXsCZn1e45m+Wn0v0=mD5LVdpb3vtZJZgcvGr8yqGw@mail.gmail.com>
Subject: Re: [PATCH v1] bootm: bound-check OS index in bootm_os_get_boot_func()
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Aristo,

On Sun, 24 May 2026 at 17:11, Aristo Chen <aristo.chen@canonical.com> wrote:
>
> The boot_os[] table in bootm_os.c is a sparse array whose compile-time
> size is set by its largest designated initializer (IH_OS_ELF), giving
> it IH_OS_ELF + 1 entries. The accessor bootm_os_get_boot_func() returns
> boot_os[os] without any bound check, even though the caller in
> bootm_run_states() passes images->os.os straight through. That field is
> populated by image_get_os() from the raw 8-bit ih_os byte of a legacy
> uImage, and by fit_image_get_os() for a FIT, neither of which clamps
> the value against the table size.
>
> An attacker-supplied image whose OS field falls outside the populated
> range therefore drives an out-of-bounds read of boot_os[]. The caller
> only rejects a NULL return, so a non-NULL adjacent global is accepted
> as a valid handler and invoked through the indirect call in
> boot_selected_os(), turning an unsigned image with a malformed header
> into a jump through an attacker-influenced function pointer. FIT
> signature verification covers the os property and mitigates this path
> for signed images, but legacy bootm and unsigned FIT do not.
>
> Reject out-of-range indices in bootm_os_get_boot_func() so the existing
> NULL handling in bootm_run_states() reports an unsupported OS and
> declines to boot the image.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  boot/bootm_os.c | 2 ++
>  1 file changed, 2 insertions(+)

I would rather put this check earlier and only for legacy images, to
reduce code size. For FIT I believe this cannot happen, right?

>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index ae20b555f5c..69aa577a2fc 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -599,5 +599,7 @@ int boot_selected_os(int state, struct bootm_info *bmi, boot_os_fn *boot_fn)
>
>  boot_os_fn *bootm_os_get_boot_func(int os)
>  {
> +       if (os < 0 || os >= ARRAY_SIZE(boot_os))
> +               return NULL;
>         return boot_os[os];
>  }
> --
> 2.43.0
>

Regards,
SImon
