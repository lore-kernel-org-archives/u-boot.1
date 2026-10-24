Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01691606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uF1aWENZ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ln2tM6Bg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D06881657;
	Sat, 24 Oct 2026 06:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZJ0Ts7x4VMkq; Sat, 24 Oct 2026 06:22:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DA6A81636
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822972;
	b=OwMg0F6YhgAKBW3L10a+xIkZhV1z7aGuQ5Nwn+1Op8lLBF0mPj3UWHgyhDi9sd6r/d88
	 opy8qOGDbf9hzIrdJ321apr5GlePt3bOcKI0yQlDr4CBnIUdSzSBEaFFMNO7wPZhf1Yof
	 PrwtUJ/GPbnnPuFb3XHHsH/o2UJ4/aeFJxUpPyp343x3wN5kBmDds468/Blu7yBr472Ut
	 Us9W0IgCPBi/TgoQ6b9RHnwsgmxnT9Op9ZerwuPnjHWUqEEU/AH2FIMNmS+ikdWb73b65
	 iLdP4bLljcEWRUPpqDS3tgmFZgFFQrBKQq+4YPaPvKX18liojxfyt2CuybtyrnbpPjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792822972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bfAQeyAtX6ciXl77o0COGudHwlRRmsyD9fGdnCpn8Pg=;
	b=rhBvCRLC0lDJ6qj72k6ITR5dyB045smDgAaoA1OYs0ejq0vJqM653Q3CzAXlWNMC6Q14
	 2O+CM0KRp7LbyC0hk6u1X0Z7Ffr29W48OXJdOMNkNRQKa9HGK19ni2POPHsYSbDGkQulT
	 EDNGvk9//v7vb49t5EuTKNiup3334xp1Xn+xQVKpzXEosdpi7K5VnT/8Y+FPq641g57Mi
	 ouu9TwIszx9ULZLF6TMwbkGhqCWLY0x/M/N5YM3xewBxO1glTCWCf8zMHzRN7I+Ow7QpN
	 3S5G+0a8NOPiedeRofZDJR/rE6qoRGzU2CD04KwdQph7Hgbta1gzIEMaG7uFD0V9pLw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792822972;
	bh=bfAQeyAtX6ciXl77o0COGudHwlRRmsyD9fGdnCpn8Pg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uF1aWENZlwGbDs/50lLWOqSAWw1cgqOXP/xiMmzgMOuTAqFZd+rBR/BhQWUIOOBXj
	 HQOBMwjw1cHKHOstnK/156HwQapFPBVHIFG+zLgkJqLgwaeUrbVAiYRhBBDDfAmFns
	 V2DByepLumph9La+LSm1hkrpWWB4emjNCJBw6SE0pKmH1/kQERVnd0bIckKEiNGb5t
	 u5KPZmv7kSn53ChgTjBHvYr2aEELcD/O24v8zcQlPxD4wZrqZbdsyCm0IcMir9nwfR
	 DFa/DB7ieoR9/OHepgPrtNCH3BnOoQZPpXSavkRS7BWr20GTbdtZcxi3W/3o5mbwOq
	 VJvwNpMTY9n3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DA6A81636;
	Sat, 24 Oct 2026 06:22:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0222F3C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7E44608FE
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lcv1W41s3hcq for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 029A26069D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822970;
 b=REFS93JBJodmvZwGQyXtQw3dnNtEmd2EumIEIMc4NPQ7OeEJli72QayQ4xRTghFsMmUW
 lxj811AHhJ84D75hCO5egJxtoQ3nLRFI/L1XX+MnJ1oRvy+B6ixKH5jyQ/6Ie/8WnoVrM
 VYsCEwB2frgQ4T0qB1VxhvmpfoMHfuRbOqfdxJtbZvRyRXhSo2Btt91pykRIuZMqnzb9f
 Yg1rqAQdVLm28GKAMjPWy3WfZxKkqeLKWMXw48eUT4MMpMpaInIGRMRucARuL4/FVYAhW
 fWbI5TPrg5waQax3jXYbyReXWNi1YGA1rSbaTXt1PtYQZHZx/3pFr6xIKvtTVe72pFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792822970;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=bfAQeyAtX6ciXl77o0COGudHwlRRmsyD9fGdnCpn8Pg=;
 b=aa2Ytc1YdJT5YyUpmK5g5GBbS12ee5uuXipP03zZV/4AOWUPzEeqfRqtm2uSSFFH5yxJ
 JHTvhNjZUh7n7HcZw6ViZuJ398eq1UT4ITiXKtzJJUyKB4yJF0zSH/40PaHX3GmDBgyba
 w9mlyJ9k92dP/PC4dXBmL44FP2zVKvoawraSbx5zljRUBg2AQxG9g2Mq6k2D1hlepgD3R
 ynrNkRe4En/CCFiUF/9xPrlA0WjUrqNi2/pf67oVTieG80J033UdAX1s8KmA3/JblZMCS
 yMs3GtLaZlgDo4J7r4kHoEnY8mTpeeTlED127mDH9RRrR4E8BPON5ffzaVdD+2b8oZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ln2tM6Bg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ln2tM6Bg
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 029A26069D
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:49 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso8477115ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792822969; cv=none;
 d=google.com; s=arc-20260327;
 b=iAMKyeqjHNUcsE7eotZkmMGc2yZpg8i+gjwALhpMxFkywfITjECigVYsVzVk7baDQY
 Ky9ag9jjAgkcREzLA1epJI0JYl/SeqHBjC23f6fDa1vM3xVg3YC/F3+PoQMKvNFl088k
 juFdRcPSDz4zCmHpM0gHn9ARSk23sAaWCbsmwU21FcEePwNRJlNXAcixSBrkRnxQ5wyy
 hWOLDV5d3VtGfjzA3VdmAmJpIucVEKEU3oyfWmIjzn6/YWl1IumonY+5yJ9+pVDxsOwv
 sqJcCB7A02x1oDjAxGPL1zLI54N4Np2lwrwHE2/RdJoAMLVXqvEu6lif1Lpkam+Ndx8k
 hKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=bfAQeyAtX6ciXl77o0COGudHwlRRmsyD9fGdnCpn8Pg=;
 fh=4elKA/8R8nsp2QSEXfJoIvGF0mo+aUc0n1hMY1echd4=;
 b=NaqoAbYj6sugECfUeqeKG9yAXaKJNR/E6CeRRdtxUemxSystBuS9ntqJUfoP8mc9/b
 7e6EbMxBASDI6+JzRTKUwLiFgJOOsRkb1V/RjfwWfXbArRLiWtTtt5wwy5yH1t7sZoVx
 ocH9a1DzbR1V5TWkOO2zun5g9EPSANfXciwlwEyqWb0ylQJWW7gqZZRMwBEqZR0K3QN4
 rUN72whyUx9RMVOwYJy8/RqV4jlyVBXHkqAgPh3bCVjLwvyyftz+HzghVPqJkz34asNw
 +FbHrYJjn8ozQRPhZzrKETgaOVmdz4ruukR7CkvibXHCtmckRFzQeE53UlhHKlmH+Dv0
 PR0A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792822969; x=1793427769;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bfAQeyAtX6ciXl77o0COGudHwlRRmsyD9fGdnCpn8Pg=;
 b=ln2tM6BgUCNCDzzbbjp6R7pMl5GmxBI/zU7bfOjPORBts9FBXjeVjOdEzX7mOrXYFC
 Mkq/70w0qK/30FsSISlGlxC7jbfIQVhpJ+2/p44gYu1zCQdDIDv24L/hYAG3S4e4mSyA
 WCaqlzxrFTsevqrzkfVYtq0xf+3S8Lw6Jvxjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822969; x=1793427769;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bfAQeyAtX6ciXl77o0COGudHwlRRmsyD9fGdnCpn8Pg=;
 b=ZviSArnT20fCdrRs1ur90DoPoHUQzGHxo4upWc1Gamd8ohrYkzQ4iPtzEAsudXRkwd
 UszVZBEggw1VdRJFu4jGNeznbf+FnnDnqugT1bRWloPTCE3r/acOSA/YtOCwndovocPb
 Nmpoe5QjpsHgWZoFrrvhQEfPRaJxmmaGZskqonVOwHTUVbsgeRy8S3Ki3mJam9qpBOOw
 uInp70b/mxz7gvMN7HfQbeByxoDtrDee8RJoywyt+Jzj00PvyG0Ma4gLsjapy35KoAvG
 SnJfkHge3LebKZS9XgDKZBULDOVh+kt555NBEONX0ikrcGAgLIZb3tnQq70fztB19sMC
 hryw==
X-Gm-Message-State: AFq9FYK7N/HbvohfHWk8ybPZs5OJTxbmtHBSe72/bWAqZ7sFsJwvOQXx
 Q2ymnbNytsyPdBgr8M01tL4QqrL5fs8o6JEzmUPpXhk3Co0e20G/gMgNZRi1xdOZfY50oNAYlSx
 NuqKJQTKcy/rqJ4h1QuCKVurrERt5SwWdGsdmMblL
X-Gm-Gg: AYBFou3LSeMcVbubQgCeGMK5HQjgMYFQ7+taUmMAoDbo2V8VW0rm8GpPQq6NiBoVuG5
 Myf2KDlws0J9wUi1ILRWx+66Z5aMpfJ24gnECgFp+9JqDvElGTjJvNCidG74SwVJBWC6k6yfZqV
 dXPKlM/kEHeP4SuQqJxtzB6KhP1/4da5bI1RJIEzimNP8wig1BoAvrGdGGeQ2neX0z+bFxv8dUZ
 hyYSY5LrMu7DQFnpVZTBQHGDGLazc5X9LGtF27l7Gv7SkKPUnm0X59owFOY90TiVT5ecxXMnZNG
 o5OWBzoMAw2PRtT69NZB0gUwLbSdl7Vso37Y7qTayBb62NGmiWx90jVW+3/u7HKF2uMMfaAWhZ8
 vUb0gtZxHAwfumtGossYR0Wlbfqeefm4wZyo=
X-Received: by 2002:a17:90b:3c05:b0:3ac:a7ee:6780 with SMTP id
 98e67ed59e1d1-3adeafcf072mr1115888a91.66.1792822968874; Fri, 23 Oct 2026
 23:22:48 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:22:35 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:48:51 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021102626.264091-2-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
 <20261021102626.264091-2-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:22:35 -0700
X-Gm-Features: AclHuK8ZsYmKb_jc4ibu-f0_Npx_9wmpsM1dEu1jNK-OmHiVaPrqE7X1X-_sMCU
Message-ID: <CAFLszThfsfbzx6-RLPLb8W7yaHG5cyAgS7DDDm7QS3uxvk14JA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools: Preserve FIT signing key file-open errors
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-21T10:26:22, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> tools: Preserve FIT signing key file-open errors
>
> RSA and ECDSA report every key file-open failure as -ENOENT. Return the
> actual errno so mkimage fails on permission errors instead of treating
> the key as missing.

It would be worth saying why -ENOENT matters. fit_image_process_sig()
and fit_config_process_sig() in tools/image-host.c treat -ENOENT as
'key missing' and return 0, so an unreadable key leaves the image
unsigned and mkimage still succeeds. That makes it clear this is a bug
fix, not just a tidy-up.

The change is in lib/ not tools/, so 'lib: rsa/ecdsa:' or similar
would be a better subject prefix.

>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  lib/ecdsa/ecdsa-libcrypto.c | 4 +++-
>  lib/rsa/rsa-sign.c          | 6 ++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -299,10 +299,12 @@ static int read_key(struct signer *ctx, const char *key_name)
>  	if (!f) {
> +		ret = -errno;
>  		fprintf(stderr, "Can not get key file '%s'\n", key_name);
> -		return -ENOENT;
> +		return ret;

Since a permission error is now fatal, please can you print
strerror(-ret) here as the RSA code does? Otherwise the user only sees
'Can not get key file' followed by a bare -13 from image-host.c

Regards,
Simon
