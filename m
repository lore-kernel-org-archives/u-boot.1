Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A13606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f6vqoDMa;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gHuxQ20W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2BC46083C;
	Tue, 20 Oct 2026 08:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1q7tIF-8olzP; Tue, 20 Oct 2026 08:11:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07D1B60822
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483865;
	b=FN/w+n/3K+B8vMq6Eu+7x4eyRBdUVdS+KuyZ6K4PvecV/PZgYrIJWNgW2muN9F3FypL4
	 P//6240ekAGVIcQ04ublBp4R9EvS3AvnnCLDuILsJUO4gTaWhmiLGIo/ernJ/ZH/bZ8Kx
	 cYHmcjdCadD6lSueJ9vzuXq4q4YbrXnVPM547P95oaCvmBBbmHcjGcmM1XrVgqVv0Snpc
	 j1qkcmS/u77ARfkzy+Dt/nvy23buJVCM7ibQ9t3953JaVW0ZNo9ws/24/VRSR+qbJHcF7
	 9mz1jXqcvoO65kKlRTJ2DOuQ+QeCX66jOAGmlQOmcLqnj0tRyPLzer8t69puZ/FEDug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iA8rfMzw79Nrz8UsQEpaojcSCUKaYv9LgN1awEnD1g0=;
	b=Z8Q6BHOAjNvMliv9kvOxKjR+QlZ7ByjkZAUtuyUqbZShhRh+Z7NOMoml7p/rKQn4ygPf
	 dAkwYso8aoc5QNXLGTJBwbliJ+/qr2VE3NZb6RgLWBVFavRb1ibi6FCYOT72+PEnXd41o
	 xMJfYoDH1t1D0liPmrh+i3TuehRz13tAvhtSZMbpq0FFf1yObQVkM/niZQ/6eQ2uZOYhy
	 DiiQRqr2H4QqYphHl3hrDvas/y71epBLXHPJoXvVm7pNmSHhfRNCbVGE73MkE0jMD8HhU
	 zoY8WjzKe5K3pvl5ZzQZxsOpprcb27VDLXGo7z/iGyGWM9Ei54SVDfmdFC/jYja1Xcg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792483865;
	bh=iA8rfMzw79Nrz8UsQEpaojcSCUKaYv9LgN1awEnD1g0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f6vqoDMadt0UizkND3z4tVjkACW7bJsqhaITbPJlx/xBCC6/J0/y8bXtAcTyydlAK
	 76I06Hxx51PzimB6fapCySHiBhteUSDA9EV8Dg6QOnWoU7PpYbTXjwVGepCi3OQyF5
	 wc25UaV1f3+8+Ha1KqC65QSo8EHoGDy4o6N+YQ0hdEfiAS3aoHEONYg2VYBeazn0g7
	 KFh3KAn9mU1/8AjCyw06x5EchV0llJgWwHy/jkgTjTtD3ImmQwB6A91t+rZDimRlFh
	 65qf4N9+8A6fvA8AxvV34ivrqdE0VRJlz7ZcmW2ZuTkDc5XPdSmdE96HvRJORPktGj
	 pbttXlserLXfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07D1B60822;
	Tue, 20 Oct 2026 08:11:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 485061E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27BCC407E4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVV5I3Sg0jRG for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7AF7B407E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483862;
 b=oTpbmvIv5UNbw75vVZY/lgSoXnJHegXxMsEfPdF/VV3KU43HsTvJCau73yHQjm+opGDU
 5dKWNu8ubesuJ+7jZHUeodO/duJBHnNfi3Q6omWPrpqp6Xaby+K5NeSMFxRnq9wbkZuGp
 FTHbsg649oZEkSZfg1xST/HoBbKjVTBMjxuDO39Xg3svjkqVA0v248MkPUzi5QK32dDW+
 kJSIuuYUlZd1B9gq7NxypRcUu9yiZCZuaMQH1RWWmO1xv5KwosUqqOhKQa56TwlZMB28Q
 TVZXdmGzrJEvkTjq2cK512ygVkJXS7QSzchOji+ohOe5KQPFiydPoTyhtM/x1Om2/kA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483862;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=iA8rfMzw79Nrz8UsQEpaojcSCUKaYv9LgN1awEnD1g0=;
 b=VYN2cAFVirmkJhQAXGyRB0M35HZggUoPiEZavMy4fsTUUX44ONKz2FSVfSFmzjBYXUyB
 azx01s/lg5BBWA1Az/Y/1PurBfJBtm2ZTG0u5oxfn7fAV3883wvrnstoM4hM8CZTBQe94
 fCwIOhsfbmST3afxmUbrfblK7zhIoIUStpJIaxHPosWFf5y+ET7ol4xmzKPnW7UK9WOhB
 EmAr1AB8HVSxBxFOTKkTqBlNLsrjwqKbwKZ1abTXlbnIBt7iSOH7HbLptqyRfDabZZGES
 iv6l24mbBcdKGKwAIN8LPZ0G+hsJCwC29HFWAN/NpzRGBb2JHMIWlUsdO0jMNw9yvzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gHuxQ20W; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gHuxQ20W
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AF7B407E3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:11:02 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so3353387a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792483860; cv=none;
 d=google.com; s=arc-20260327;
 b=LVUdORBps9qlTAwxtTVLNJ1F8j3P7y6DxHBTVY0fx6deTOs8M/c0gc4NRPuR7NKGXQ
 Gu9wiIm3WRcWDhJXYJ/TiZHuyXKKFXiB+wOoePtt+KttfDriRF79H0P3uzqPX1uPy9tY
 oE9bn9uNVLQruULNPV4KydOtJJluJA1mz8wHwiqsgyAyMjIsxidGxv19O0Vf/u+FSbaK
 2hdeXOkS9ruvra/XtTRd+LTRVIJzGlZPLpS2GLrGbpwaip1y3LuSHu3fuKW5Fa5bFn1t
 xV9StYIhjkbdTZ9a5Cl1Huj6mL0JEnacf8oI5MbW5gqoR7vyxHl6J8Wj6fMbCfTFRsIm
 +ClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=iA8rfMzw79Nrz8UsQEpaojcSCUKaYv9LgN1awEnD1g0=;
 fh=sqFYa5HhsXMHk6lK1uJ95N3qZeoUfXxEDP8vyXdmNZo=;
 b=OjLxlH99k2M3BTrxvAbQtt18eb+hf8FYwuXxeU3pCRgqLbfmGRNIW71S2k0e6mQi4w
 o3mznatwK1GRP5j0yZcvjmZOzATO/ERG8J51ExrpLmSKHBA3KUDpRLb7vT1znKFSD/q3
 Av+HNxS7/9UpOLytoxvoGxye5XhRCzRH5XS4OLVqgqCXOR4a2ThUSgnh4rUxNSZk4YSM
 gTbWX0w8zPgaglCs2iPC88UMR9vhBQhhH/DyLvkuwKAtF+Ts4RlSbrlkuG6w1FMPVX4A
 J7/s6ZRe2729PRsKA22ZCxt4RhLmLJsYoSvJQNa5NMjcYNnTTarYci7tHc4hjTxp1Ee4
 0aHg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792483860; x=1793088660;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iA8rfMzw79Nrz8UsQEpaojcSCUKaYv9LgN1awEnD1g0=;
 b=gHuxQ20Wl6/UvCKsZeTP+3kCR9fBme2fe+FG0LR8+Ruq2qtB0NZPHXL38o+WvtmcV9
 l5OcEA22ci86tUdNE0WbAVp+vifQYPZHy+Wqulotv67FOijGIzFJkga18mDqSgJz+sV4
 nvnPESq9OLI3M5qNcHa2j+EsG0ClP0v0PfZ5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483860; x=1793088660;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iA8rfMzw79Nrz8UsQEpaojcSCUKaYv9LgN1awEnD1g0=;
 b=u2ZDpTbpMmjJX36oGSgKa+E/we7rv1aKO4iU+eGknc7/Mq61QUm+AbO2JUTbG4b9NU
 1dU8JuzD8Aj809pjJyvFp0EAHYPmk+tNpxeytedPJlQr97T1ZuiN9xg6+tDrbPdE0Y5o
 gjPejfVQjH5G+zvq7n7TEQKqgfeANTNPszDENML1gdFO+18Og1u0KpVSTlp2HsmKr2cB
 hMmr2n4R1+w8TLiNOldXxa3eSZm9nFbclHyFs4Eqp31ad7gnwQNH+zFyD4ffsMZWw+wW
 niHNnBAnurLXS7qEZmPweC/VkdtWqGY0NGr2zDLmOaCGeeD64P5kkMwF6/4rj9V8RWGK
 EDEg==
X-Gm-Message-State: AFq9FYIPRpuitDjD/gzbQRwMWxfK+l7qaEexpN82Fsgo64aQxjmbdyn3
 Lcp/vOIJP7npeOrEy4IKFC/QieF2cLdfq2apO0Yco1pQEodh/TLgl01EF0PfKmZXc9s0bRN3iq8
 N/2jTiBK5NpYPFTUSKOo6FCUurBpChrzNWqV1E1PSBQdtNPtguwv0Bg==
X-Gm-Gg: AYBFou20G2SlwG5c65SEP18kOhdodyGprME5ccWI81vZsBreAjCZ5nfs2269JeiShYZ
 +HGNOnO4dyC2ZjrcGZVqZICIgjXXjj0GhKtNN8RyO8HPm7urRXzfjDiNh3Dt1koijPAdu7BJhH7
 mcB/f7qh9PxzV9gvOGo2Cc7JvaVlHxmrdGs85oSqy2qtDeXsrk8vEfyNy9eluCfN50gV7Ca0D/F
 xdYJKEzG95Yhr1UPZARngS3WTOD8jrYNw+nFxQ4ay9iXR28yeePLmjzfeD+J9Eqs/ame1WHIXvh
 TFJP1o9eqOurLSpoORPVGkdQQYJyzPsjVBhcJG40jFPYIILDScMn1g==
X-Received: by 2002:a05:6402:c4e2:10b0:6b3:d0a0:3a0e with SMTP id
 4fb4d7f45d1cf-6b3d0ce1fdcmr2802164a12.12.1792483860128; Tue, 20 Oct 2026
 01:11:00 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 01:10:58 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 01:10:01 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16544f53-fd01-4dfa-b617-2dde9b010629@gmail.com>
References: <16544f53-fd01-4dfa-b617-2dde9b010629@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 01:10:58 -0700
X-Gm-Features: AclHuK-wg6riu_DDF4ygRJHnWkvQVZINY_rGMKlkCjidnq7NfAeVml36enpivSM
Message-ID: <CAFLszTj_QSiB1RCVGhMk8FK3GEu1rME2=wOZ4XKTSjMf-fjTMw@mail.gmail.com>
Subject: Re: [PATCH v2] image-fit-sig: bind a required image key to its own
 verification
To: anon87111@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 0xiviel@gmail.com, me@ziyao.cc
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-10-15T03:56:30, anon87111 <anon87111@gmail.com> wrote:
> image-fit-sig: bind a required image key to its own verification
>
> fit_image_verify_required_sigs() passes each required key's node offset to
> fit_image_verify_sig() as key_offset. That function never uses it: it calls
> fit_image_check_sig() with required_keynode hardcoded to -1, which both
> boot/image-fit-sig.c and include/image.h document as "any signature will
> do". rsa_verify() then tries the key named by the FIT's own key-name-hint
> and falls through to "try each of the keys in turn", so every required-key
> iteration is satisfied by any signature that verifies under any key in the
> control FDT.
>
> With two or more keys marked required = "image", one signature from any one
> of them satisfies the whole policy and the others contribute nothing.
> doc/usage/fit/signature.rst says of "required": "this indicates that the
> key must be verified for the image / configuration to be considered valid."
>
> The configuration path is correct: fit_config_verify_key() passes
> key_offset through to fit_config_check_sig().
>
> On sandbox, with key-dev and key-prod both required = "image" and a FIT
> carrying only a dev signature:
>
>   Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev+ OK
>   sandbox: continuing, as we cannot run Linux
>
> The doubled "dev+" is one signature satisfying both iterations, including
> the one for key-prod. The same case against the configuration gate refuses:
>
>   Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev-  error!
>   Failed to verify required signature 'key-prod'
>
> Nothing exercises this path: there is no required = "image" anywhere in the
> tree, and test_required_key() builds only sign-configs-* fixtures.
>
> Fixes: 56518e71041f ("image: Support signing of images")
> Signed-off-by: anon87111 <anon87111@gmail.com>

Are you wanting to be anonymous?

>
>  boot/image-fit-sig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -159,7 +159,8 @@ static int fit_image_verify_sig(const void *fit, int image_noffset,
>  		if (!strncmp(name, FIT_SIG_NODENAME,
>  			     strlen(FIT_SIG_NODENAME))) {
>  			ret = fit_image_check_sig(fit, noffset, data, size,
> -						  key_blob, -1, &err_msg);
> +						  key_blob, key_offset,
> +						  &err_msg);

Nice catch. Two things worth doing as part of this series:

1. fit_image_verify_required_sigs() has no 'required-mode' handling,
unlike fit_config_verify_required_keys(). After this fix the image
path is strictly 'all', with no way to express 'any'. It would be
worth mirroring the config path so the two gates behave consistently.

2. A regression test using the existing sign-images-*.its fixtures,
parallel to test_required_key() in test/py/tests/test_vboot.py, would
stop this rotting again. Given the fault was invisible for years
precisely because nothing exercised the path, I'd lean towards
including it here.

What do you think?

Regards,
Simon
