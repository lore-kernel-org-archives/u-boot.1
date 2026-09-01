Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F91C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD6660749;
	Tue,  1 Sep 2026 09:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwPUH5u6wuRv; Tue,  1 Sep 2026 09:00:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788253225;
	bh=BZ6BwN8IWp6c9Pixz3e4kJObWQpxMqMnMXYxk9uzAek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nxl8R45qwIZ26H4J+61O2KLQnew1qGLqq+Yi58kvipVsW9CfwLddgLxC4CK/0p8cC
	 bbDtBaWuymrmp2D1YJJm9KawK49mu68g1wyaTE55tRqk0ATxennGtp6uWe5HU1Xa2z
	 0wMNn9tv5x1QcL52p6Nvto3ukq69ez8v86NAqGfDtZYwHO+K9oqzycQpwyfEK4STOq
	 27bkOdBKKpr7oO/PBd7MBnU0irm1nCRtF/5zDHJOpkSzVekHS2c0TaSDdoh/BJ9N3X
	 IMItGZBFv00V3nlywJXrPoHtbUTmJSLSIfyr4ifdBQC2xJHNYzi2RPbth+z9tKaIsv
	 thU+g4N4OAPnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 671E86073D;
	Tue,  1 Sep 2026 09:00:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 739F8363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63AFC80B2E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0zp78Af3xap for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:00:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zhvK13t6
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96A6D80B07
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:00:22 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8615bb9d857so5382247b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 02:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788253221; cv=none;
 d=google.com; s=arc-20260327;
 b=YRYFV0ubV0d6tIBy9lUKjcEOwuyf22ra6HYomHRvQWP4MNPPspNNs2a2/EypEJdlFf
 pkm8JKvAA2ZXP518MJCfy54EKjgHa01dcMiGpF/XOSUerHjV9fPa7DKz3jT5VBXyxzkQ
 DFu8LaR9YACoAmDpVkTv2QiSQM0R+O6vj5//9onqy38m6tGdZaDrY0njBKsl4XS8pNzV
 24dMuT1NIpc7qD9Lqu1IqdvIm3Yd5GeFi9gvF+1HLHb2SwkxKkTMRTJ7a4YUBPFDaPJa
 zJ6hC73fCP+uaL74eLQjJ62P7ENERAshKv1fGccNJrUy8qh5h1Phis1U/Rl1VB+iwU2z
 aeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BZ6BwN8IWp6c9Pixz3e4kJObWQpxMqMnMXYxk9uzAek=;
 fh=HTA1PY7guaH4TjSkpoY9aUBef0p+3e6pJD5Dzr61EXM=;
 b=G5+wo+Bm5xs20tuiSKQQUG9QtrUNZXOTNlA6jnWb+i6Vk7K7bVvY1RZWVa/2PrYzxY
 lup22H4ex8WwyfCtQM9RgitS51T08oIWAL6Zaa8dnkZRnjKXJgrLFOgSYqx3kKsBvpxF
 tSLwB4UEQ39yeRMqQYt6FMJdbjmoHS57g094FldSStHcCJePw6Z8yBo/r5JNagzkfXqg
 AqfsBPgGd9ZQC6Z0GXS4yO/my3rbuQjob4HEEhuOsi8IbuYpytdZg+IAjs7i4U/8Lxv9
 fP5/nlCfKoicwtaOElEq47elMgMi/AkWOp6AS/8Cl10SnMAH0A2NLucTJXWT17GY5pt4
 d1hQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788253221; x=1788858021;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BZ6BwN8IWp6c9Pixz3e4kJObWQpxMqMnMXYxk9uzAek=;
 b=zhvK13t65QhRbD/2RenCesstb56GBU8SjDPtvl6ayJuDO8jD5cs3LAebUnWSjhC9Tk
 ZEhd0ROrPFehRvVH0M2qHEC+AhLXp1lQEhQgP9FBGTfqno+UfyLll6ar0wEDpaFGb2vp
 ykHAtL3k658fc/VRsxXIYJB4FRlIQ4T8Wy7KnIhl7d5TOefKH8Y8XVYfeVdlhs7gvc7t
 X33YXDzRQm3m3/wvj3PDfUJl2dSWFWPHhxEmvvm41WjtyC8kEDTa0yVrJ5yQsnh10Z/e
 QrR/CeMk5PPjfzDL0dMZKO4SThLVvBOCOSGCoHSgaq+Btq6Xr/5uNT5DGxRdAzZT6Tim
 WSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788253221; x=1788858021;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BZ6BwN8IWp6c9Pixz3e4kJObWQpxMqMnMXYxk9uzAek=;
 b=pcWQhuzFYPPhpyEaFgoc/OWn8UFlY6FILIrxvMKVI74jrxzfHxduKdgg+sKaINVuy3
 FN6FESNVUMb+QjaiB07Y4Cwz+TpmD5RAQBoOngw06ri+PkGtrJIJxdmQmPo2qHefkLSb
 fWo6wgskkRWQJ1wSQK3T6JMlK+pjuvd7in08w47cS61cIE2yBQN7WEdPNDoFpdlTP0SI
 wfuW4qzW5IAnOKMY47utUiXdMxKa4TUiwyEiE1n1365eI3RSPV8ie88jgxEzmbAkZNKA
 9SYtzeH22KMR8j39VACJY0g9YVW8IYmZDwgRZyhK9hSokjYSkGg1y9bJHdR/CJIjPVt1
 GfRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzE89Qv7uMvuVE0CrajMyV21yE3W86F9tbfzO/+EvBChCVp2nlgqnSNFxackXs0LCgKTSBdKC0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mi6dWo8+M73O7Y3pS8ZbO/Nz4rkRZvDaxzV0HMBuLhrJWByD4M
 PlQqZl2a8CpUMnW+NOhl6P1AgbCmqOsw7GCFjMmFX22yKJrdcFEpRzLbQ6Rx3NZHQsepRDgvp09
 k/BfCdrXMjDQMX2JM0rMffXy9cdcKJve1aYVT1iMYhQh7cYLmDbbqqC5KLg==
X-Gm-Gg: AYBFou0rHFnPOnX+r8mV3fh9BCZsHh8L1JpMB8b8f+CqNEjXx/x3ojzmVCfy9pXpr69
 J7prgc5fnzGLyVePXWhbtDkU3eQa5nFLjWaQTGr00fkbM95K4QTodL8VaeCGE+hszLo9Epo8LwI
 BwCEXcqs5El1y+7duOZdCixPf/zvF3Jb2W/DC1IVOl+cXep5dtdBk6Eni9yaNg9BwOaFy1Xwhgr
 YRBUC7skyIXk3gQHco/nVit9xuaq3uUZjV5iicb7Ex01MfeVGhQc5rXw2qIU7IfMXOkR4/Cq/j7
 DTo7n1AmEriUhdbP+syWIxFd5m1Y3b9dgw0gmr4T4WfV11SoWe/+WBv35zgkYRnuuxVfm6DmJlm
 7PnghDavESZPTSqXC1okBKdaaPO9b78heOLtsH37gtvd/kiw76kaDT0WDkgS2az2D7K+GTYbxvk
 C0TRxAKWtkw7IFj5SRDcnbk1NbWmxRLxrNKpqke/J0Fhl9BA/4v21slDgTDolxEnrL1/yOxfDy0
 /3iQkn7OhZjxtg8JHc8xf4jf99iYCtwvRnlvyLAZf7v8bKg8n6NUkaZ3b05KBse2p0MdVF4KL9n
 rhFagqTxMXaiXXGPmp1ChSuJRXI4QBY91YL/vrLm/Hf0CR9Rp3wwCqih3W4omSGAHqJRlryf1L+
 ssbVdMwyTGQ8j25lQOTOz7WzeeEaK1wN4nu/3sfwQdEA=
X-Received: by 2002:a05:690c:6e84:b0:860:607a:93d2 with SMTP id
 00721157ae682-86060a881b6mr93917987b3.0.1788253221131; Tue, 01 Sep 2026
 02:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260830084400.250238-1-heinrich.schuchardt@canonical.com>
 <20260830084400.250238-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260830084400.250238-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Sep 2026 11:59:45 +0300
X-Gm-Features: AcwNN1VzORBhSuu9aDzV98w7iopqd7U9_agXHsz-_AgKE-EJ49FVPZg85rA_wy8
Message-ID: <CAC_iWj+-_tA2WdLJ+ZKJkVC5BV=KKju8GCq6AGWKip-Vq8ypbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: consider type of
 platform_get_rng_device() return value
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, 30 Aug 2026 at 11:44, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The return value of platform_get_rng_device() is efi_status_t.
> It does not fit into an integer variable ret. Use variable status.
>
> The RNG device was available when registering the protocol. When it is no
> longer available in GetRng(), this is a device error and not an unsupported
> algorithm. Use EFI_DEVICE_ERROR returned by platform_get_rng_device() as
> return value of GetRng().
>
> Addresses-Coverity-ID: 532068 Overflowed constant
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         keep the EFI_PRINT() debug message
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/efi_loader/efi_rng.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index e920eec9d7b..3a831e2232b 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -103,7 +103,7 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
>                                   uint8_t *rng_value)
>  {
>         int ret;
> -       efi_status_t status = EFI_SUCCESS;
> +       efi_status_t status;
>         struct udevice *dev;
>         const efi_guid_t rng_raw_guid = EFI_RNG_ALGORITHM_RAW;
>
> @@ -123,10 +123,9 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
>                 }
>         }
>
> -       ret = platform_get_rng_device(&dev);
> -       if (ret != EFI_SUCCESS) {
> +       status = platform_get_rng_device(&dev);
> +       if (status != EFI_SUCCESS) {
>                 EFI_PRINT("Rng device not found\n");
> -               status = EFI_UNSUPPORTED;
>                 goto back;
>         }
>
> --
> 2.53.0
>
