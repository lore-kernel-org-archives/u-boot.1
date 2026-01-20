Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F4CD2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 12:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC44D839E2;
	Tue, 20 Jan 2026 13:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HZRgjg8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A978083A91; Tue, 20 Jan 2026 13:27:32 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4C480B98
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 13:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-790992528f6so46333107b3.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:27:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768912049; cv=none;
 d=google.com; s=arc-20240605;
 b=GxFRhboB1fVKxSLAQ6Q+6IAUt097KJg08fl0QSzzE7L7jP0AstoFS2+zD9cCMpi0Sm
 L7iF14D8KWGxc3Jmc79fBdAA64gAE3YCRzhk0TqBSIIiRDjk38DqVXzKf4hbDNJqQ40s
 qA5EyFaCMVkQ+5/TJAmqV9i4JDCWzMQUeOJoNr4x9bp2MNhsEX4jZiKAi6Ue0tH92Dga
 K7k5F87eaHBjD7lPFhCxtJfLvADpbPOsgyri9LxkFmhA1bdJu55wKWayuWhiNH7DtkZS
 YiRMwXeBkPaP8+BTPStbHi1n9X0i7VZQDMSY33QG/hQSMKonPge6m/6CznYRK+jdXbTP
 lyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o8txhJP3A8ah4nyfffYa36z4LDllnylBYmw6/3QW0F0=;
 fh=s/hXJ48J50Vd6K1Y+3j7h4q6znQ5kpu6I1dzeFfBczI=;
 b=eNolpjZN716dIDBkfMYCzxAPrv7abCEh2N3KCDr82lHyfh/Jarop0Ley+yGqI1tdw4
 rBWhUvjypCtdO5yly3CwMJS/hUQs6WEMuVhRmc6YA93br6Ae03iN5PRI0AQNtRx6qfSF
 IOhMtyBGUSC7nrf3Eww4NxvXeM4QqeLisRxEs6ePHCYrYehPQLmtA5bqm6R/W3AWLDHr
 vmhGMsqUpVZlxKvp6c89zHhJEfwdqRrgaI3U7IaLQEbDuOq8niWpwg7sTnCCZA5nCdTQ
 b5CTT02IQljHM/3BCi9gFKw8hgPPh4tu3B7LCy5x/lxR4zSu1aNDAVJk3QXQXvWpgYOd
 agcw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768912049; x=1769516849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o8txhJP3A8ah4nyfffYa36z4LDllnylBYmw6/3QW0F0=;
 b=HZRgjg8vgV9upq0R7Q0jTLlFtB0hAxxgxWjknP41w0dlT+q7DVGf+QN0KQvGEHorP9
 LWk6S0hzdDUzgOzMz5RMn+Tib31nL0H9XMldtcUjTD314kGXVxSLHKhDNDI+eTyJyauD
 mwNP1dqftgAtYnE1i/JWFR5PDCPQGcgLZf7PsZjexm6lJRyRtcjg9e3LX75J/Bm7X4Wn
 fh/eRy/+oSKfzQSaMeaqC9YOOHRtaNcIolXAJ3fELt3/2Y12gQRvcRQo951oJPIhN7XG
 9iPbTmAOn/Dnf624DLTFckAZU+xYq+jnJ31+Ze2hol4srnxQZL49talhzawJDYR9jR4n
 wtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768912049; x=1769516849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8txhJP3A8ah4nyfffYa36z4LDllnylBYmw6/3QW0F0=;
 b=JHGfbTHjmVGla0wjo4pUOSauC85CWIa2EA7zsi5UbAXx3yVrb/z3uJ/0BM1ZHpheYp
 NAFsTUJTUfjz2r1Vb6AriZaKWka0yuM3T2YdDU+lap9u6FEjl4PWigaf9CG1B4qCUA1L
 8qznwqZHl4h4+nsuYccowxDG5vfMpandc2G/16sSfKhpkyhH7R5BYg8XgaE90+BK2CNH
 QwMRKgC7IUK9djqPPIVU4CxETH9QfjM/zq9yHUx6sRo7gAFL/Aq5ZJzdBr5ETI8Y3tUO
 e+rD+SmxpFvkPdj0FnOQeFBfaOLYHD3aE0Fdm2EQrL68MLebraqnPyht76YAjsPs2RA0
 QlIQ==
X-Gm-Message-State: AOJu0YyLcvDQDeqljUwsBO2fQDf+blk/bmchrGoMITHvd5QociMZbK/J
 rRwvFrt1L4+svq9FHryEpsKefbTswLvXgGrwuJz3O+LdP84rZ8DT8GOvSTtF1p6FVJl8sc+dPp8
 3XUyFdMNG0SP+cr+d4y/YAOqfyW+9wxSJUabUHczj/g==
X-Gm-Gg: AZuq6aJRlSeRquludO6bqKbZ2CzqX/eRQcJ2j3xkoSPQinnXSJmVrFWb1fRAcF8oxNw
 cN8Gwb+sDEPDmTMcMey5uOFUTS2KLjdcPqihmaWybLmXf+JINAHlO6KCGjAcE0xdryIuRknB64I
 3EeUywJZfKnfe2zYCXeuD6CPDY5SMvMY0aHubQTZMWhyZiZTfxNLNe4gZvLTIgEZv714qgjwL5M
 /PC2Hm/2fZo7mGw6yFln2i49xvQlLY49YByrdldRRD4tGwRFNrNEJUPrZBWhq9uODcCWfFf6tkw
 CoJHC2nvODtHI988nK5MkUpvOR4nM/qsnerFqsiBMDmvbATP5ldOD7sv5oZjuQeXug7lIUX1A2W
 H/cxxriayIFfD7BkBTs/iNbrbO/YCd2f8yu8K3RbClKUUOCdm48Oakhli3Abn6wxkzimlSs3p0V
 sH2uOYQ2dO37DNlT74Nyk+PouxVPCBxco+rOeiA6jST0YtsvjSUJesreqUL03CZmByZac+oBYe9
 /NhFCQXOAPFUvVctJGp+mao9QluyVHbvqCrE2+Zpg0SaeRCUB4uU/6qpVpA3cvwo1OQ0M/wgV/I
 uxX0zRwUUiYqxM+7IZI0jzS5tp9rTA7tHfSAAUJfFh0=
X-Received: by 2002:a05:690c:6b0e:b0:78f:8b7b:7910 with SMTP id
 00721157ae682-7940a21c18cmr10888437b3.36.1768912049049; Tue, 20 Jan 2026
 04:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20260119160746.1330877-1-kory.maincent@bootlin.com>
 <20260119160746.1330877-2-kory.maincent@bootlin.com>
In-Reply-To: <20260119160746.1330877-2-kory.maincent@bootlin.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Jan 2026 14:26:53 +0200
X-Gm-Features: AZwV_QgkhqH7Q3DiJH3uOCvKeB1-uHYfFq4znGQalU_akd-dM-HIHlILRVa8CV0
Message-ID: <CAC_iWjKYhv=vjSe9yVpr_AFE=RdLqromTELkJTFFQEa1js1LtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fwu: Pass bank state enum to
 fwu_state_machine_updates()
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Simon Glass <sjg@chromium.org>
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

Thanks Kory,

This looks cleaner.
I got ont nit, I don't think you need to cast the states to a unit8.

On Tue, 20 Jan 2026 at 03:35, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> Change fwu_state_machine_updates() to accept an enum fwu_bank_states
> parameter instead of a boolean. This makes the function interface more
> explicit and prepares for adding FWU_BANK_INVALID support to handle
> boot failures on the active bank.
>
> Convert the FWU_BANK_* defines to an enum and update all call sites
> accordingly.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v2:
> - Refactors fwu_state_machine_updates() to use enum as parameter instead
>   of adding a new fwu_invalid_bank() helper.
> ---
>  include/fwu.h                | 22 ++++++++--------
>  lib/efi_loader/efi_capsule.c |  5 ++--
>  lib/fwu_updates/fwu_v1.c     | 16 ++++++------
>  lib/fwu_updates/fwu_v2.c     | 50 +++++++++++++++---------------------
>  4 files changed, 44 insertions(+), 49 deletions(-)
>
> diff --git a/include/fwu.h b/include/fwu.h
> index e7bd1d492af..9cee8fb085c 100644
> --- a/include/fwu.h
> +++ b/include/fwu.h
> @@ -80,9 +80,11 @@ struct fwu_mdata_ops {
>
>  #define FWU_IMAGE_ACCEPTED     0x1
>
> -#define FWU_BANK_INVALID       (uint8_t)0xFF
> -#define FWU_BANK_VALID         (uint8_t)0xFE
> -#define FWU_BANK_ACCEPTED      (uint8_t)0xFC
> +enum fwu_bank_states {
> +       FWU_BANK_INVALID = 0xFF,
> +       FWU_BANK_VALID = 0xFE,
> +       FWU_BANK_ACCEPTED = 0xFC,
> +};
>
>  enum {
>         PRIMARY_PART = 1,
> @@ -396,24 +398,24 @@ int fwu_get_mdata_size(uint32_t *mdata_size);
>
>  /**
>   * fwu_state_machine_updates() - Update FWU state of the platform
> - * @trial_state: Is platform transitioning into Trial State
> + * @state: FWU bank state
>   * @update_index: Bank number to which images have been updated
>   *
> - * On successful completion of updates, transition the platform to
> - * either Trial State or Regular State.
> + * FWU_BANK_VALID transition the platform to Trial state
> + * FWU_BANK_ACCEPTED accept the FWU bank state
> + * FWU_BANK_INVALID invalid the FWU bank state
>   *
>   * To transition the platform to Trial State, start the
>   * TrialStateCtr counter, followed by setting the value of bank_state
>   * field of the metadata to Valid state(applicable only in version 2
>   * of metadata).
>   *
> - * In case, the platform is to transition directly to Regular State,
> - * update the bank_state field of the metadata to Accepted
> - * state(applicable only in version 2 of metadata).
> + * Saving the bank_state field of the metadata is only applicable in
> + * version 2 of metadata.
>   *
>   * Return: 0 if OK, -ve on error
>   */
> -int fwu_state_machine_updates(bool trial_state, uint32_t update_index);
> +int fwu_state_machine_updates(enum fwu_bank_states state, uint32_t update_index);
>
>  /**
>   * fwu_init() - FWU specific initialisations
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 89e63ed8dd5..e0f9a6efa25 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -465,7 +465,7 @@ static __maybe_unused efi_status_t fwu_empty_capsule_process(
>                         log_err("Unable to set the Accept bit for the image %pUs\n",
>                                 image_guid);
>
> -               status = fwu_state_machine_updates(0, active_idx);
> +               status = fwu_state_machine_updates(FWU_BANK_ACCEPTED, active_idx);
>                 if (status < 0)
>                         ret = EFI_DEVICE_ERROR;
>
> @@ -510,7 +510,8 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
>                 log_err("Failed to update FWU metadata index values\n");
>         } else {
>                 log_debug("Successfully updated the active_index\n");
> -               status = fwu_state_machine_updates(fw_accept_os ? 1 : 0,
> +               status = fwu_state_machine_updates(fw_accept_os ?
> +                                                  FWU_BANK_VALID : FWU_BANK_ACCEPTED,
>                                                    update_index);
>                 if (status < 0)
>                         ret = EFI_DEVICE_ERROR;
> diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
> index 974abf216f6..5824cca98cf 100644
> --- a/lib/fwu_updates/fwu_v1.c
> +++ b/lib/fwu_updates/fwu_v1.c
> @@ -98,27 +98,27 @@ void fwu_populate_mdata_image_info(struct fwu_data *data)
>
>  /**
>   * fwu_state_machine_updates() - Update FWU state of the platform
> - * @trial_state: Is platform transitioning into Trial State
> + * @state: FWU bank state
>   * @update_index: Bank number to which images have been updated
>   *
> - * On successful completion of updates, transition the platform to
> - * either Trial State or Regular State.
> + * FWU_BANK_VALID transition the platform to Trial state
> + * FWU_BANK_ACCEPTED accept the FWU bank state
> + * FWU_BANK_INVALID invalid the FWU bank state
>   *
>   * To transition the platform to Trial State, start the
>   * TrialStateCtr counter, followed by setting the value of bank_state
>   * field of the metadata to Valid state(applicable only in version 2
>   * of metadata).
>   *
> - * In case, the platform is to transition directly to Regular State,
> - * update the bank_state field of the metadata to Accepted
> - * state(applicable only in version 2 of metadata).
> + * Saving the bank_state field of the metadata is only applicable in
> + * version 2 of metadata.
>   *
>   * Return: 0 if OK, -ve on error
>   */
> -int fwu_state_machine_updates(bool trial_state,
> +int fwu_state_machine_updates(enum fwu_bank_states state,
>                               uint32_t update_index)
>  {
> -       return fwu_trial_state_update(trial_state, update_index);
> +       return fwu_trial_state_update(state == FWU_BANK_VALID, update_index);
>  }
>
>  /**
> diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
> index 159315b45b9..f48b6d1264b 100644
> --- a/lib/fwu_updates/fwu_v2.c
> +++ b/lib/fwu_updates/fwu_v2.c
> @@ -80,42 +80,27 @@ static int fwu_mdata_sanity_checks(void)
>         return 0;
>  }
>
> -static int fwu_bank_state_update(bool trial_state, uint32_t bank)
> +static int fwu_bank_state_update(enum fwu_bank_states state, uint32_t bank)
>  {
>         int ret;
>         struct fwu_data *data = fwu_get_data();
>         struct fwu_mdata *mdata = data->fwu_mdata;
>
> -       if (!trial_state && !fwu_bank_accepted(data, bank))
> +       if (state == FWU_BANK_ACCEPTED && !fwu_bank_accepted(data, bank))
>                 return 0;
>
> -       mdata->bank_state[bank] = data->bank_state[bank] = trial_state ?
> -               FWU_BANK_VALID : FWU_BANK_ACCEPTED;
> +       mdata->bank_state[bank] = (uint8_t)state;
> +       data->bank_state[bank] = (uint8_t)state;
>
>         ret = fwu_sync_mdata(mdata, BOTH_PARTS);
>         if (ret)
>                 log_err("Unable to set bank_state for bank %u\n", bank);
>         else
> -               data->trial_state = trial_state;
> +               data->trial_state = state == FWU_BANK_VALID ? 1 : 0;
>
>         return ret;
>  }
>
> -static int fwu_trial_state_start(uint update_index)
> -{
> -       int ret;
> -
> -       ret = fwu_trial_state_ctr_start();
> -       if (ret)
> -               return ret;
> -
> -       ret = fwu_bank_state_update(1, update_index);
> -       if (ret)
> -               return ret;
> -
> -       return 0;
> -}
> -
>  static bool fwu_get_mdata_mandatory(uint part)
>  {
>         int ret = 0;
> @@ -171,27 +156,34 @@ void fwu_populate_mdata_image_info(struct fwu_data *data)
>
>  /**
>   * fwu_state_machine_updates() - Update FWU state of the platform
> - * @trial_state: Is platform transitioning into Trial State
> + * @state: FWU bank state
>   * @update_index: Bank number to which images have been updated
>   *
> - * On successful completion of updates, transition the platform to
> - * either Trial State or Regular State.
> + * FWU_BANK_VALID transition the platform to Trial state
> + * FWU_BANK_ACCEPTED accept the FWU bank state
> + * FWU_BANK_INVALID invalid the FWU bank state
>   *
>   * To transition the platform to Trial State, start the
>   * TrialStateCtr counter, followed by setting the value of bank_state
>   * field of the metadata to Valid state(applicable only in version 2
>   * of metadata).
>   *
> - * In case, the platform is to transition directly to Regular State,
> - * update the bank_state field of the metadata to Accepted
> - * state(applicable only in version 2 of metadata).
> + * Saving the bank_state field of the metadata is only applicable in
> + * version 2 of metadata.
>   *
>   * Return: 0 if OK, -ve on error
>   */
> -int fwu_state_machine_updates(bool trial_state, uint32_t update_index)
> +int fwu_state_machine_updates(enum fwu_bank_states state, uint32_t update_index)
>  {
> -       return trial_state ? fwu_trial_state_start(update_index) :
> -               fwu_bank_state_update(0, update_index);
> +       int ret;
> +
> +       if (state == FWU_BANK_VALID) {
> +               ret = fwu_trial_state_ctr_start();
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return fwu_bank_state_update(state, update_index);
>  }
>
>  /**
> --
> 2.43.0
>
