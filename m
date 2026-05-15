Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23336CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B71B1846A5;
	Fri, 15 May 2026 15:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SmtOYQeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D09846A5; Fri, 15 May 2026 15:06:39 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63FAE84099
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd11a3729e8so804472366b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850396; cv=none;
 d=google.com; s=arc-20240605;
 b=atYAOPlhMvUSrBt0EijKJWbxoERGI5QZwzdsiYZrAtmNYPlX00uEkTLvFHQc/U5A37
 efGOCbfSLi1BhN8ImDA62gMRl7KIrnvxsZsSDTm4wozbVgR56tCAbjqTBbHkOrqSwDGf
 xHJSDSRb9TCXjCu8LvtQDc/+pvOtRKin4be0bKEPlAY+l56mhUO6hAxHVr5neLPaKD9U
 RzB04KLOQgikckURZTMiGK/uzfk5/KRhgIzB1u50Nmn82hsgfnoG59lwK3QZnNfRrY6O
 e23DZwBopjbSnflSGujb9N55xB8j3ztjj9vLkAPXa7pp5HES1dmTY8pqNMhipLhRS+96
 CucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3ZxST0aKLx1bYWuu1debsSKeNzvWesEr/KsSUC7OSkI=;
 fh=p+5qEY7KshK5nNBu/OO78N81bwUQ6GeR8eoG5BHzLcY=;
 b=F2rBk09QKNFWbT3+MNKAKk/1b2gAJpR2GpSNUyZ0qQo9VmI3UKb5aq0gw5nb1lBEUV
 xA22Zq8QjaOqNkI+VA2edHsfzCQL5lfQCSsApC/sWhW3dcw9yTMpHhdqDZELPBJ/7Ung
 HpPFWGvTpwvj4DCwn15s+SuJYHVyDAo/RUbNU2Y2913Xrz/Ovu2aB2YkMDlFfjcwydC9
 mwFnly4cgUsiCY1xbOLmSp6hH6fTlRGysMBT/61/wnPL6JtEJE41k1Wv+T4EF3euz6Ys
 MWfyyOgZqrYo7yhDhfDtsKkmu80bsvFr9rD/kiYvbacCdeyFuooNI/maIUDWe9Gt2K20
 Qfxw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778850396; x=1779455196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZxST0aKLx1bYWuu1debsSKeNzvWesEr/KsSUC7OSkI=;
 b=SmtOYQeYZkrfL/nwix4b6PZZoLF8mWFWg1q12kjzs/msz0me1FswG93xqU7E1xGtRw
 t+POaHt4ysv1oFgpQD0aS0cy6jdss6hVvjR3rvEKT2XbGqevYm5DFajXQF+ENekYfjM6
 kdTyB/Zf8Rbkg8k7pDFCyxe2YCHtqyk7ImaVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850396; x=1779455196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZxST0aKLx1bYWuu1debsSKeNzvWesEr/KsSUC7OSkI=;
 b=PnSewmIw6Puv67sPrhh90jVnk5SSQ9yEw/o+B2+iFAfx3Pc51VE2hbUYyqSarvae/k
 DeTuxA+ObKlnWD6y9VWTjOnLVO/6ac/0b2V2eDw1+e/Fxx/tplYTVIelQim+aC6SzCQe
 d7gnoHdwbnU/M9y/GzpQe/lLZyh4NVhwovCA4IxLEU0dCyNqOdDUki3bB4afhRTc/zEh
 41cnBaWVK5CKS+v/j46qdcQf2fI7WpzhMn2ErqI+v40a4ttVcNsavV2DqORYZursJNzh
 LQIlpwGxYVmr4K8StPQGSdj5zAf3kOaXxeGWHLNEC8x08JWRbf1bigenGpKMpE/lY3Ii
 Sj9A==
X-Gm-Message-State: AOJu0YzBPnwJ1r0EmxLFS47t7Q9ftAnCnS4G1C/SvYkxnVg2CrsT+WR3
 7KEveic1JTVxo4fwR+lT86aff4zpSILCK4AB1A+1FDzUAtDJG81LYOssf70Xlt3HgTh53fRSsAU
 ZLCp7TKDC2p5aazqZN1KzIbgZ+GWxLrtzX5QWLtPz
X-Gm-Gg: Acq92OEpoz4j3SJhg/ANxNVfmflSD6xgsc5sAxC5uVOTbQMWR/f6EAqxwJMdhJAdMM6
 KmCAtxtMtp38w0xH/hCDbyrBugT4zVWnCiSyaM/dhhLhR0r9E9+lCYGZs+T/UtSKgIl3TiwUwbx
 4blHpohffb6+InxSGWo36gSIOf5gSb3Dg7upHSMhnVdGmvQjjFBeshDw8gEyihg9h0jFaHSjOC0
 jUZGk2B+9HJ/cZgx6mEScdtfDz0qLkwrb/2xl/AjKHtk9WUo5RHdkODIkJFJoAlu6pTqOyp4c87
 2pfaMeN+Pgla7lAO
X-Received: by 2002:a17:907:c50e:b0:bd5:2e4c:40d8 with SMTP id
 a640c23a62f3a-bd52e4c67e5mr39013466b.49.1778850395783; Fri, 15 May 2026
 06:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-1-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-1-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:06:22 -0600
X-Gm-Features: AVHnY4JrrIlAAEmMiWGqtIG9QpBv3SEctBbyQUU4hUoNrJBMHX7MYk2joVRhjQs
Message-ID: <CAFLszTjkC-nZw9VYhs1E95HYV80B8KT9Ms87LCx4KJgz7J6LdQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] tpm: export tpm_show_device, tpm_set_device,
 and get_tpm
To: aidan@wolfssl.com
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>
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

Hi Aidan,

On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> tpm: export tpm_show_device, tpm_set_device, and get_tpm
>
> Remove static scope from tpm_show_device(), tpm_set_device(), and
> get_tpm() in cmd/tpm-common.c so they can be called from other
> translation units. Add corresponding declarations to
> include/tpm-common.h.
>
> wolfTPM's command backend needs these functions for device enumeration
> and selection when operating through U-Boot's driver model.
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
>
> cmd/tpm-common.c     |  4 ++--
>  include/tpm-common.h | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)

> diff --git a/cmd/tpm-common.c b/cmd/tpm-common.c
> @@ -234,7 +234,7 @@ int type_string_write_vars(const char *type_str, u8 *data,
>       return 0;
>  }
>
> -static int tpm_show_device(void)
> +int tpm_show_device(void)

These three helpers live in cmd/ and operate on a static tpm_dev
private to the command layer. Promoting them so a backend in lib/ or
drivers/ can call into cmd/ is the wrong direction. If the wolfTPM
backend genuinely needs shared 'currently selected TPM' state, please
move that state and these helpers into the TPM uclass and have
cmd/tpm-common.c call into them, not the other way round.

> diff --git a/include/tpm-common.h b/include/tpm-common.h
> @@ -337,4 +337,26 @@ enum tpm_version tpm_get_version(struct udevice *dev);
> +/**
> + * tpm_show_device() - Show all TPM devices
> + *
> + * Return: 0 on success, -ve on failure
> + */
> +int tpm_show_device(void);
> +
> +/**
> + * tpm_set_device() - Set the TPM device to use
> + *
> + * @num: The number of the TPM device to use
> + * Return: 0 on success, -ve on failure
> + */
> +int tpm_set_device(unsigned long num);
> +
> +/**
> + * get_tpm() - Get the TPM device
> + *
> + * Return: 0 on success, -ve on failure
> + */
> +int get_tpm(struct udevice **devp);

The kerneldoc is wrong. tpm_set_device() and get_tpm() return
CMD_RET_FAILURE (1, positive), not -ve. tpm_show_device() ignores
per-device errors and unconditionally returns 0. Either document
accurately, or make tpm_show_device() propagate the failure from
tpm_get_desc().

If these become public API, please also fix the return convention to
use proper negative errnos (CMD_RET_* is a command-layer thing) and
rename get_tpm() - tpm_get_device() or similar. get_tpm() is too
generic for a global symbol.

Also, @devp is undocumented. Please add an entry for it, and note that
the function selects device 0 the first time it is called.

Regards,
Simon
