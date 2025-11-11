Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697BCCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76CF83F24;
	Tue, 11 Nov 2025 09:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iflrvDlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5462C83F4D; Tue, 11 Nov 2025 09:52:11 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217F083EC9
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-88f8f346c2cso370879085a.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762851128; x=1763455928; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e8/GUVaE4xprjtEXlG5ZLXPCix1KXNX5MxKdqmQR068=;
 b=iflrvDlIi/qcpmTJmaJ7ckICf4RNmf+ywdxXUTTynA5BQT162i6fD+DNgZT5LHR6ex
 wo1Vp6dViJQpOJJERn3GwLKtVPqBzS0x3Fpm2BP7kc4kCoYUHeI5ACLwTtShFBTa0r1K
 GBfCqejvJSxLt8gCnIVoxN7vOu3JQIoCgVbQIwOKnnQvlOZChr/v95bndmwo1nWTE+hY
 VTvPWx8tDyEPNrqSbrZE8g43LwIn9+2omlmy/BObP7G0clCtB1R0L0fAv4MhE6FcA2VH
 /h0UrQkFUTd87WUswZZIR/qZhsrLMFq6/Oj07l7j/dJXYwai3kZtTe7KEy4TFxWrOo1s
 gz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762851128; x=1763455928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8/GUVaE4xprjtEXlG5ZLXPCix1KXNX5MxKdqmQR068=;
 b=BPYc0+CINqvnkpFaSDDlvP2QjD+JFjWxpzOJNXhTrkrerQVVzV10JlcT+3BxtgP/Cw
 AO+/GflpiPLSrSNF0EeppdLQVGhI5XlAeI+OuGYp29j0MJItFV86ODn1/shH4P2mcJIK
 jufwn01Hx0kCZij8s2HGO+Urppr4BQnEuCD23stL1DTwIdTxiiU+UVjSqXstijzCxy1x
 jeLxHcRVMG1ZygJZ3Cr0CnskcUydm+3jhwpV9gkSglNNcoe/c/aR/YO8OsycfoLMm90r
 AxgROqaQbWlx1NID67kRvqcd/Tk05h6F6dlQQK1Ht0H3arIVVq3BjUqjHxCP0QcVXzR9
 8Fkw==
X-Gm-Message-State: AOJu0Yy1Q2b/0wlD2+8eTVsGxCxTJghseAtOQQzNTEMwbD883E9QFMKE
 l9ThMUWgMoiMwpyg5avjwjxkH1RjOuN20AJqww6khvZXmVxRtYMutQh4CcQaERr78YLUxRbsGpu
 4kuc/1vVTqv3gDLYhUvKuFEJSjhltXCvyrkGXa7xA6A==
X-Gm-Gg: ASbGncvW8xBk5vR7Z5EvKxIUPNVWm6dl83emU3lC4fohbtGCisZXmU8YIw02NhFtdoj
 qXehIIiQcr5g5N5i/4KCtkwSF+IiGIEdevxP/97wgOJwkcw6qYRhBRIOkgA9rauLEsr+KfKBZI8
 j62K4FPPYv//QwQcPGDUL0JGMkScRPm9sO/IlAURMv62dfIyT3tCV7hv/hSntCoo5uzffPJdwQx
 mTxESBowuTruUD2phzLyjBWLucJra+jJAE5M5jfnvhHavzlR614zTF6TmPfSg==
X-Google-Smtp-Source: AGHT+IGxg1axQK+qo+HF6On3AWhJmGuRNFiNv77twB0HFKgV+VP9LmvnMkox0xio+AyFQD4tNgexN0SNrdR+PvM6sYM=
X-Received: by 2002:a05:620a:4496:b0:892:eeb9:4def with SMTP id
 af79cd13be357-8b257f4d1e7mr1420543985a.49.1762851127906; Tue, 11 Nov 2025
 00:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
 <20250926141351.1755829-16-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20250926141351.1755829-16-abdellatif.elkhlifi@arm.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Nov 2025 14:21:56 +0530
X-Gm-Features: AWmQ_bnabuf1SqnGNqPB-q-QCDw5m_8Olpir9nEbjr61a6E8CuvMsJ0X0K-msTQ
Message-ID: <CADg8p96J3oE+L7cwN+5f89q0K3YgYZhUv=dMBs2jLuES14qo6w@mail.gmail.com>
Subject: Re: [PATCH v5 15/24] efi_loader: fwu: fwu_arm_psa: Disable trial
 state handling
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
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

On Fri, 26 Sept 2025 at 19:44, <abdellatif.elkhlifi@arm.com> wrote:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> No need for trial state handling in U-Boot for FWU Arm PSA
>
> In FWU Arm PSA mode, trial state is handled by Secure world.
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> ---
>  lib/efi_loader/efi_capsule.c | 7 +++++--
>  lib/fwu_updates/fwu.c        | 8 +++++++-

Why are changes being required in the lib/fwu_updates/fwu.c file? This
file is dealing with the normal-world FWU implementation. For your
implementation, things like bookkeeping for the trial-state etc will
be done by the update agent.

-sughosh

>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 06b502e2c25..42effd42628 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -562,7 +562,9 @@ static efi_status_t efi_capsule_update_firmware(
>         if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
>                 if (fwu_empty_capsule(capsule_data)) {
>                         if (fwu_empty_capsule_checks_pass()) {
> -                               return fwu_empty_capsule_process(capsule_data);
> +                               return !IS_ENABLED(CONFIG_FWU_ARM_PSA) ?
> +                                       fwu_empty_capsule_process(capsule_data) :
> +                                       0;
>                         } else {
>                                 log_err("FWU empty capsule checks failed. Cannot start update\n");
>                                 return EFI_INVALID_PARAMETER;
> @@ -1375,7 +1377,8 @@ efi_status_t efi_launch_capsules(void)
>
>         efi_capsule_scan_done();
>
> -       if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +       if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE) &&
> +           !IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
>                 if (capsule_update == true && update_status == true) {
>                         ret = fwu_post_update_process(fw_accept_os);
>                 } else if (capsule_update == true && update_status == false) {
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index bfbb98c16d7..45d43d424ba 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -340,6 +340,11 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
>                 if (parts_ok[i])
>                         continue;
>
> +               if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
> +                       log_err("FWU metadata copy %d invalid\n", i);
> +                       return -ENOTSYNC;
> +               }
> +
>                 memcpy(parts_mdata[i], parts_mdata[1 - i], mdata_size);
>                 err = fwu_sync_mdata(parts_mdata[i], i ? SECONDARY_PART : PRIMARY_PART);
>                 if (err) {
> @@ -781,7 +786,8 @@ static int fwu_boottime_checks(void)
>
>         in_trial = in_trial_state();
>
> -       ret = in_trial ? fwu_trial_count_update() : trial_counter_update(NULL);
> +       ret = (in_trial && !IS_ENABLED(CONFIG_FWU_ARM_PSA)) ?
> +              fwu_trial_count_update() : trial_counter_update(NULL);
>
>         if (!ret)
>                 boottime_check = 1;
> --
> 2.43.0
>
