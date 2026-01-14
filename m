Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF8CD37E3A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 13:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A88808AF;
	Wed, 14 Jan 2026 14:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="txpLB2eF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B0E80C93; Wed, 14 Jan 2026 14:54:49 +0100 (CET)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33808063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 14:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6420c08f886so12364459d50.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768398884; x=1769003684; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q28tM+PNha4RmGIfhHvfNU9KBPcP03BQD6ryg7PfBVw=;
 b=txpLB2eFd6b7MvpgN1mZZizGayy976FWTKpXLZixZn5Mm/npAm40PNOZ50WGvAskTu
 t1RRoxjovPZSIrkDrySSkf0TuV8Cr0HIFmXjrk4TVlnmO86UmmznfJT19pDl8zBg/mL8
 O30RcasEKjjXJET2pUBRGpMxhji49GM7mPzGYQOS6ej8DkFri4Y5y5vdra54nCGCcgTu
 pcbvV6ehZkznn+/AVJM00N+595p7HONw+MtKydjx8UC5AbPZojVQL3E6GcxuQwmDEzA/
 1KlueUNHTr3rItlzy8SJyKbqTHqQatHEpGriMn56++nr+oEaI0nF2Yd+YC035oIpfG4I
 L51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768398884; x=1769003684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q28tM+PNha4RmGIfhHvfNU9KBPcP03BQD6ryg7PfBVw=;
 b=neMOufI523eLzJNC4ZDQJIvlK+T0I15KahpCMwmTiOcN31ZJeDvIph9sLMTag9xjkT
 4VbF2lvGvbWOjojM77iMknfubHNAUMlqs5thHfDj9ZaW+7eDKSsEbPFaAf4W7e2dMgk8
 5SRa7DykSWAKOoKU/qOH+pagPTkHojY9aELJauOskVxd73CUeLaOV96GeXb0ALBUJPul
 Bwph0tG/dDTdCXPNPei8ZKyIT4eMtzffEEKlFkkJjJh45aQ4lLtidZRICXLcTwkhk41q
 lWxyHXmvzNPDaYWpT/VMTuRVxJV9xafVYf5r2j7DtWQFs+7U8haYfyf9IkEji1QzQy5K
 vcaQ==
X-Gm-Message-State: AOJu0Yy46uDwKNgRCY1GLvCASbgvvKFljYGvSnzUyI/aiEc1HMrXPaj0
 F+wPkLf2fpq5iajH0A0rdIPS++TcVwOvvAdGJOuvKBfvGpqv+uCpW+f4boZnuAoRKSqL37e29uE
 2KBr1G2Zt0DtOdol81/274veU+UDvKuvN+KH0N0w2Ag==
X-Gm-Gg: AY/fxX45/N1Al/Bfi7g2hGPjIqr3c6e3LCcRdCmyQ9VKYKA7NGc0U0EuNNkEWho4cp8
 n+PZtkFaMTNhWlVfWgsLRpH/oPfA8YltxCnqnX+4pj8dpkLCoSzuhaggEnkJ4zbwMdy+Ohg6Z/X
 jvrJmGqIf0As2Q9XDJeywGCFW0P6hPJ+Lq1dmOV8rVCGXwbyjVR/IXQ3fK4TYJd8ijzR76zXgEy
 x9Pa6+8tSo2hzEk0x2c4Jzs7Iv8dR87x5UDBQmeteOEj6gPlhjlBIRVLiB9k2KEmZLbzKG0I5OW
 421JagxtfikNMUKazqRNDjMox4keKlBXVfuLB4uKgYSy+/9skTQNAkoqaq5YSSuURh1QIsJDsrI
 +9Z4UeFYb29DrAqozrnjgbJh5J7QEoGYKOKZjgfAOqgKb2/pB67GeMd7jY9zOenLoYqwXuXRVKn
 u9Txyi7yby9CEy1/kTRQz5tZBEJbgPKE7Mv91xWhZSI4GvoWWct1z4MDRP6m/AO99pB4oqsWUJG
 hWkTQbI80AlYUu1kaOAj7CBV1T4V/Ek/2cp6rqg5zcWNm8aXnW0Qi7fHw2L0UiXdoePnQx7LEhZ
 vrAwDPjfrX9YbvpgrFZcjPxQC6JzjbvL
X-Received: by 2002:a05:690e:d57:b0:644:41e5:dea1 with SMTP id
 956f58d0204a3-64901aa51dfmr2152466d50.4.1768398884321; Wed, 14 Jan 2026
 05:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20260114095917.737634-1-kory.maincent@bootlin.com>
In-Reply-To: <20260114095917.737634-1-kory.maincent@bootlin.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 14 Jan 2026 15:54:07 +0200
X-Gm-Features: AZwV_QirZ2dRlnluBu2uTnJIzuidSk9J2dTjc59nt5rQ_jLf5s-ANipdxFCrvVg
Message-ID: <CAC_iWjKRVFF8aDLyyJi5Mbnbku=NJMX7SG4ZRfoJ2YzrAwyGQw@mail.gmail.com>
Subject: Re: [PATCH] fwu: Mark failed bank as invalid during rollback
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>
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

Hi Kory,

On Wed, 14 Jan 2026 at 11:59, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> When boot_idx differs from active_idx at boot time, it indicates a
> rollback scenario where the firmware update failed and the system
> reverted to the previous working bank. In this case, mark the failed
> bank (active_idx) as invalid to prevent future boot attempts from that
> bank.
>
> This change adds a new fwu_invalid_bank() function that sets the bank
> state to FWU_BANK_INVALID and syncs the metadata. This is only
> supported in FWU metadata version 2; version 1 provides a no-op stub.
>
> Without this change, a failed bank would remain in a valid state and
> could potentially be selected for boot again, leading to repeated
> boot failures.

How? Doesn't the code already switch the metadata to point to the
'boot_idx' bank as active?
What could happen here I guess, is the selected active bank to go bad
somehow and the firmware would try the secondary bank, which contains
an invalid firmware. But in that case the board will fail to boot
regardless. Is there a corner case I am missing?

Thanks
/Ilias
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  include/fwu.h            |  8 ++++++++
>  lib/fwu_updates/fwu.c    |  1 +
>  lib/fwu_updates/fwu_v1.c | 10 ++++++++++
>  lib/fwu_updates/fwu_v2.c | 19 +++++++++++++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/include/fwu.h b/include/fwu.h
> index e7bd1d492af..e4f3a062e36 100644
> --- a/include/fwu.h
> +++ b/include/fwu.h
> @@ -415,6 +415,14 @@ int fwu_get_mdata_size(uint32_t *mdata_size);
>   */
>  int fwu_state_machine_updates(bool trial_state, uint32_t update_index);
>
> +/**
> + * fwu_invalid_bank() - Invalid bank state of a specific bank
> + * @index: Index of the bank
> + *
> + * Only supported in version 2 of FWU metadata.
> + */
> +void fwu_invalid_bank(uint32_t index);
> +
>  /**
>   * fwu_init() - FWU specific initialisations
>   *
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 0f5ef2ba515..e54c19b0c64 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -766,6 +766,7 @@ static int fwu_boottime_checks(void)
>         if (boot_idx != active_idx) {
>                 log_info("Boot idx %u is not matching active idx %u, changing active_idx\n",
>                          boot_idx, active_idx);
> +               fwu_invalid_bank(active_idx);
>                 ret = fwu_set_active_index(boot_idx);
>                 if (!ret)
>                         boottime_check = 1;
> diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
> index 974abf216f6..c9ac1ec244d 100644
> --- a/lib/fwu_updates/fwu_v1.c
> +++ b/lib/fwu_updates/fwu_v1.c
> @@ -136,6 +136,16 @@ int fwu_get_mdata_size(uint32_t *mdata_size)
>         return 0;
>  }
>
> +/**
> + * fwu_invalid_bank() - Invalid bank state of a specific bank
> + * @index: Index of the bank
> + *
> + * Not supported.
> + */
> +void fwu_invalid_bank(uint32_t index)
> +{
> +}
> +
>  /**
>   * fwu_init() - FWU specific initialisations
>   *
> diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> index 159315b45b9..3c07adfd4e0 100644
> --- a/lib/fwu_updates/fwu_v2.c
> +++ b/lib/fwu_updates/fwu_v2.c
> @@ -194,6 +194,25 @@ int fwu_state_machine_updates(bool trial_state, uint32_t update_index)
>                 fwu_bank_state_update(0, update_index);
>  }
>
> +/**
> + * fwu_invalid_bank() - Invalid bank state of a specific bank
> + * @index: Index of the bank
> + */
> +void fwu_invalid_bank(uint32_t index)
> +{
> +       struct fwu_data *data = fwu_get_data();
> +       struct fwu_mdata *mdata;
> +       int ret;
> +
> +       mdata = data->fwu_mdata;
> +       data->bank_state[index] = FWU_BANK_INVALID;
> +       mdata->bank_state[index] = FWU_BANK_INVALID;
> +
> +       ret = fwu_sync_mdata(mdata, BOTH_PARTS);
> +       if (ret)
> +               log_err("Unable to invalid bank %u\n", index);
> +}
> +
>  /**
>   * fwu_get_mdata_size() - Get the FWU metadata size
>   * @mdata_size: Size of the metadata structure
> --
> 2.43.0
>
