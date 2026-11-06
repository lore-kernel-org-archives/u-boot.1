Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA666606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iD6ib+L/;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=To9VOcWN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EE9F406CA;
	Fri,  6 Nov 2026 08:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IioD69o7G6e6; Fri,  6 Nov 2026 08:54:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF613406E7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793955256;
	b=sTlI0bCED7YCZ9S0k6ciM+gkyF4JfYWlvAMspdXmmbTYOqCT9U5Q24WFq9B0PaB7LYyU
	 Uvh2a+CU84PJZs4fjjwuj6soD78oa3T/p3i5alCPKqzn7h1cJ0sCnp+dCBlE2yiG/zJ/6
	 /MAhAGTszjHNr6j8I2lp72Syb6mFegnStWM6GyPChnUGO5shnAWiFmPoGNsAgGGj/dF36
	 LW4IxdrGLulWz4tMGwHUkIpCsS+JnxcFmGh03RX1+S5nuTNBtJ1BZLhA1Cuq3YqGk34gM
	 SHdTLl96+ByaroPcDPRK9Ngr2UchgN+rmzjQwOtv+gT0ivJ4Ko3sed6lFLKcj2s94fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793955256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nGnFfO38kR9ORB2iUW1dJ75G8zvJf4WwJqwjaHoioe0=;
	b=WXz3/sdLfaLrbkviUb3OilEVrfmWMGQVURJZf9XkXCZJ5F3DlY4204nSag/LbwGIL0QX
	 L2N95n6xdFMDgSaalXm6t7NBRN2kn2rqWcFXBrrRWtBSdTXjGS/izu4d5pbnKSV1oAGnI
	 DGs/OgDmzxQZCDmYyS0NP0I2mFryC0v4FM6cUuyMG/vOIBqb+zdNb94NBXNQ2BuFuCgHW
	 E/qQMaMyQfW0GCsZk2pxwN13993uSmIm57Fb+Rn/XqYPeemoe758XSgMt8tjuHHFkUUzB
	 4q2Q7YMiXxmiOK3HDjtx0s61oSfD9baJJTAEx78+Y7n3SMXqnqIX+LDkyVZc4kXtOYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793955256;
	bh=nGnFfO38kR9ORB2iUW1dJ75G8zvJf4WwJqwjaHoioe0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iD6ib+L/wq2ufpyp18E6XhSry1bVQSG97ORfctkSvsKYQRZqVfe5uz4HgVCVsfd55
	 ze0+OAymJiV0MT48jM1aHw0CZrwvMqwcY0rXEX7b7eIvI3K6aqoXRMR+gNMo6pE1aX
	 4DPOzFk40fxuT1o6vwBy0PnCNEO2fCcv1aGTItPlCmfizACjPT2gpPjIa58tdbI33+
	 NEtzqNKbz6wyBPTQC3LhqWr7EaEm2DPefJfnX8bJRgrUUont83C3dZQavvDdD8JcIh
	 /So6IltPjjgL+Jbmbejem/dm1TUU1oyEjHsV9P55Npu4wisrIV5/fD7FJSJklLinww
	 Qa5SyKnokGieg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF613406E7;
	Fri,  6 Nov 2026 08:54:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60B0932A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 08:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5246F403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 08:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zZrqootf1s0Y for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 08:54:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 550D5400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=To9VOcWN
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 550D5400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 08:54:12 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0d91601bdso12884627b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 00:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793955251; x=1794560051;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nGnFfO38kR9ORB2iUW1dJ75G8zvJf4WwJqwjaHoioe0=;
 b=To9VOcWN51vKt2UNOacHO7fm537rv5a0xJG3RhKsXNoqo4o69/ikcIijkl+lBiOqH6
 Noqq/ClY4mHGGjAN5KeMhACYKsg9mdDyn0gE88uqKsQ3w522uXLRIRnYsUy53yBHMNH8
 tyB8d8qTQnJHCJroMdbdEHrfwCZ80uufnq24/85aIaGLjRU/3+m9bwoidBCwLEM+lHcd
 BsaIJUecm5rsl1RBDOpDBzVVixE8reu4rKzfeyKTSOUAkxp/gP7lqr4AQzCiEpPUzuyY
 M6POAvjw9WRmMGOXxhu0A7/raR0XuEhTFq5xIW6Rt35kclmKKKHgvOMlkmB8zvJIa36Y
 t65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793955251; x=1794560051;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nGnFfO38kR9ORB2iUW1dJ75G8zvJf4WwJqwjaHoioe0=;
 b=P6HRIvbm71LUMd4qoVaiozbaHskoKpcEiJEI3eheLaTZ72wYiFe1t3iKqY0QJqjerG
 s0eq1N+YJbDhKOLeUsuMzonS8gomBHMuH5kBGqtm256A3ytgtTdohCD29ZPDYAVhf/pV
 VseaMHKkSDheVI7d4jGqPoeZ7rM0eOyYDxdMoD1ronDyfmB3gJtIUThEoBJuAN5tKThS
 4+0+vMUmE8rRtkCLhn8m/p6GrQ+cGMMbj7D+C4SQE/QFC6LasDDPd3J72dzHwQ6vq6Og
 YDQnsTyNg1yIsa6dgLJ8byd+3YGwRu6CJazr/aSP75Ex+ljactCGO+EyliWq26wQxpl8
 Q1yA==
X-Gm-Message-State: APuU4Z8dvus33eN+3VFlk3lKAXYOuHWSqLAgJwQnrvzmGV3Pqk54yDRe
 ttzPeL1+J33bd65dBl+NkYhLdlQzt0KectIZoyQAWIeLLDFWoX63sK+qz1gbivVJg/P7QTLXD2h
 IbxcB65VDACsThaKVWp8GLNOw0Y6KDUjO9dEbQEYxsuoBbsz0m9hMriqoEA==
X-Gm-Gg: AYBFou372qUX6hgwoAXPuXUearSdZUuTo6X6KiG4U49YL1a1qav117casNoWZ4xCkji
 EfaQ8Kvn7LQlimLMmsDrh5EXmAF7qGvov2oODW8gTP2YJbnVMgWDBZtj1j4NfMS016mfT0T4FqI
 DdR3CJLG+fNJcBrC2ryVOJoKiU3BDbr0kxwOL9iiBTI3ELg+rEvvLqiI65CRWldkSzIjxBngejz
 Jy0XqIJ30XphE/VfRmqTMxuQDPfOpHL973mshmtSu3NO9h+e9wTprEe+W2rnR/CM0GuG68vlJEk
 Y2fB1CFuye1aHp9o8RVDwqMNHFOMd+imO0wZrNXbIn/NDgAwNm85B+pAqncORXxeYa7novj5Kcz
 O8PHDE/qnk+/wPSplTlyuRfAHK9Qdq0VCSvaev3NnhaPFYOEklfmZJ95tjS4TRS7G0SEKEVi/5J
 mFFs5JtSK26Iwg9PpYr9YAs3248Phc3Rxj7MfyRbRR6yltyg0MT0UnsXxdWIes/+Wzh+IjSYrjF
 lAL0N5MaeJzgvVT292tYOSCPpKah1QBXHD0Qx6xo/MIJ1PHIfegk4YL0cTJamAElqNcR0I1wkDT
 l5sqYETndM0Pvamdlb7IUmy97PaPC95OsF5ndQGfupIH98Tp0lJhGoEU8l35t06Ts1DU0JIaWIu
 BSgj6oG3b/lBb+FBieVfb26QhXys5x8QwGwVMEWixAEkqLtFVOEmPyJ9L9UvcuCNzUZZC3UNvv8
 4/1wu3CYHC2tmVysrjqEkgPOC1hNHgB+rIsqM=
X-Received: by 2002:a05:690c:c114:b0:8b0:d206:16c1 with SMTP id
 00721157ae682-8b3419ba036mr7952627b3.24.1793955251242; Fri, 06 Nov 2026
 00:54:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106072729.1714418-1-tkirchner@emlix.com>
 <20261106072729.1714418-6-tkirchner@emlix.com>
In-Reply-To: <20261106072729.1714418-6-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 10:53:34 +0200
X-Gm-Features: AclHuK-2dpo6E2_VGdmNxT2va2umNRCL5IeqPWl_LrYn3aLIVQj9bqlnESdrxVU
Message-ID: <CAC_iWjLSSGbQ=s_r7YFD=ZXaPP9X9Wj-cuJrhxThma-DkeLGJA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tpm: deactivate unsupported banks in tpm2_startup()
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 09:28, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> With CONFIG_TPM_PCR_ALLOCATE, active banks with unsupported algorithms
> are only deactivated by tcg2_log_prepare_buffer() or, as a fallback,
> when a PCR is extended. Users of the TPM which do not go through
> tcg2_measurement_init() or the EFI TCG2 protocol therefore only notice
> the unsupported banks when measuring, e.g.
>
>   tcg2_create_digest: unsupported algorithm 28
>   Cannot extend PCRs if all the TPM enabled algorithms are not supported
>
> Deactivate them in tpm2_startup() already, before anything gets
> measured, but only if the TPM was actually started there, i.e.
> TPM2_Startup(TPM2_SU_CLEAR) succeeded. This also covers
> tpm2_auto_start(), which calls tpm2_startup() if the TPM was not
> started yet.
>
> If TPM2_Startup returns TPM2_RC_INITIALIZE, an earlier boot stage (e.g.
> SPL or TF-A) has already started the TPM and is expected to take care
> of the banks. With an event log, tcg2_log_prepare_buffer() still aligns
> them afterwards. The fallback in tpm2_pcr_extend() remains for the case
> that the earlier stage supports more algorithms than U-Boot.

I don't mind keeping it, but if the previous boot stage supports more
algorithms than U-Boot, this is actively blocked in the TCG code,
IIRC.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> TPM2_SU_STATE, used by tpm_resume(), is left alone.
>
> If the deactivation fails, e.g. because the TPM refuses the allocation
> or no supported bank would remain active, return an error. With
> CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to manage the banks,
> so fail early instead of at the first PCR extend.
>
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> ---
>  lib/tpm-v2.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 18ec9eb960d..6370b97a7d4 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -201,6 +201,19 @@ u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types mode)
>         if ((ret && ret != TPM2_RC_INITIALIZE) || !bon)
>                 return ret;
>
> +       /*
> +        * Only the boot stage which actually starts the TPM deactivates active
> +        * banks with unsupported algorithms. On success, this resets the board.
> +        */
> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE) && !ret &&
> +           mode == TPM2_SU_CLEAR) {
> +               ret = tpm2_activate_banks(dev, 0);
> +               if (ret) {
> +                       log_err("TPM: failed to deactivate unsupported banks\n");
> +                       return ret;
> +               }
> +       }
> +
>         return tpm2_update_active_banks(dev);
>  }
>
> --
> 2.47.3
>
