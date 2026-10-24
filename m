Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=alVQXXXm;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dciYjvnF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DB9F815B6;
	Sat, 24 Oct 2026 06:29:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnFgK6blWoAa; Sat, 24 Oct 2026 06:29:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50ACF81567
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823355;
	b=LC+X7tG8OmAKYQyGleIZpPmV3JA7z5Xt1SA0t3h10CqLac4UgKyHnNkpTuHiskgvqfa+
	 iA4I4yVFx2fI4NuYGqnUI8YCxo01Qc7vbR44IWYmPoePWOGPzS8g89WOAuvkko4Cgqfg1
	 IH6IVNmYj65+WaNR7UkEHQbdQOCRRq2lBlAg11TnERKYoiBaP2VnxfWLXpN556s+9yOsh
	 Cz9oenHP/lIqmQSOPrTz+pvYk1yJOjZj2j5YGgQf4pVjs144v5SvTafrMoj71WH4fhn6r
	 3JQt5ob02Ljgbc8xgQzLfHZTPUBCE74BlRfgrShwN+jPA39CPa8Q66mjBJ1icIlNKbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823355;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wlhfIvHF52xhCTJEUMNJCGavaLSlBdBBWGJiyAyvxOY=;
	b=R02YQ5BuN1QB+/O97lVjTR+ipJfTEepnZn0UQ21kNzVUyx2nXO/yu9rifCGu5n22I9Am
	 43P7yG3SAW2UQyZ0iqvWBS6LRrdDPgu3w443e1xj2Njj8otP8d1l+f/GToilddX+ROURp
	 FN7uy9v6wW1n4LfhysFaovXPztOpojYhN6/AnlFYsN0bZWPPYPSyqxdJMJmr/FVv5LQkm
	 ku2fMxUz6VAaowINIOW4Ee1LokGa95W4CQEkn6KpnhrmWQmeSawsFiNfHkJDOU/ADBJVb
	 ufsd4hSFS6Dnoq5RMH720nIZtjlcGqb5PjaTQ+4NNlqfwUd2etTYaTWhCHCQwBs7vBg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823355;
	bh=wlhfIvHF52xhCTJEUMNJCGavaLSlBdBBWGJiyAyvxOY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=alVQXXXmBgVsHQxQj3n5zc5sLUqn28Lb1w6cl3zM+Oz6QtMMo6XYoWEXT+pLlOMaW
	 XSvAYntE7JRnEB6p0G4U9hJwBBAq6ujSAj1N6VqN3bLFB1px1X6fTvjvYhzw7A3Kdv
	 5vkBkWDGc26bmR7k/cQTrvhK6HeEJJtu+gbBQaCiW/ExLO0VUz6CAi1xhPI2KrUNgS
	 YNL5G4D0ln20d+jLmfpNWP2Gj7dzag/jwSu7Pyow8rv3MOqZoG6slNxBZ0qFe4Bhi7
	 ppXj+eF5HPf0XEfKe58p2TqOCODAUEk9iNbYylBw4c6zaLwIenoWfbNMAGk8LVTr0e
	 7yKWWIo/4NAvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50ACF81567;
	Sat, 24 Oct 2026 06:29:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03E4A235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 017E2400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p88N64VqOWet for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:29:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1FC1B400AF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823353;
 b=G4bYM6pqbbWRPOEqSkwr5Spz7IyIKd/NI+x8vEu2Nqquxv+7uxNjmc1c0xkjAn9RlaP0
 1UDKyLGxT9XOFcjsyNuXaCGZ1lyVJ+pFutTVFtk8Jr05orOTWVlVwXclFL3SdeSEwxAg3
 Sul5pUiOWDXeW/YZYLf4PXEneHk/ARaPQFJU2bOFUWMQRYGVF7rGnNM4uaETR6EfJ6rn4
 gIOXDOD509ywc8OtFXEOeg/XAJtd6W6JYI+NK9egr1w+hoUzpFBAcQ7soPi6pe2ExmPRJ
 /cc5JCZyuUCTUyCakH5ONeAU1OvcXJSLW6TxlIAkEvIXyDsF5/4xv+3ppRHHywzbLbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823353;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=wlhfIvHF52xhCTJEUMNJCGavaLSlBdBBWGJiyAyvxOY=;
 b=BSOWaFYOIMhh2YSGV9P1DTkOohXjRLBV7IKICrOnSUE3pMUm3Y8i+HuUm/J+dxjEfIh+
 +Q1Q7fbyRjh3Hl83qp93maqRsjeJADzTnX69OM+NL27UzuKzfKHDUY+MEPAvlMNoVuK1Q
 ZKpF5Ya2znTdZgS7xnfF2qdihHGk4yW5qBdtJrFaL9Z7GwVD4CstygdWFSTKgAgvIugls
 ygwyoC63+vqva/zQpYBoiiDliRzW6U/cdkcn8DX4DkJp/mzPUWwq6iv7ZPFuZASZZZyxN
 0htdmjJ+Om4PKuzSUsjAARIU6tHHRbugXVl3e/mYKVpbX5pERn2GjgZLQIPShPYa4eA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dciYjvnF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dciYjvnF
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FC1B400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:12 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so7555275ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823352; cv=none;
 d=google.com; s=arc-20260327;
 b=E2ag9Izrm2pv2+aOdRow1fGspdX8L2AodsVXIHEZteCMDF03pMoSJTxiyqkKKPllaD
 Fpx5MiersKFut2CAnVYZ+HOjY5Ei/3ZLWVjr46SrbWO0nYQsrbYcvzaDqEL0Sy53CgJM
 4z8OsIn3z/lvn6xqaKaU5biztwNGZiTdCWpYOxkX7cOgv9MA/ym2jWk0+XEG9S+sfy1M
 NjbIGzVARHHEsFMeVCeZlP5MvIpfoQeRN7RWs/u4h0FmX1UjYWW2DyZQlcfjmk/dLbO6
 nR4C/VBQpLpFi1KWUpGVhkq26Av0yBxLcbWClA2IASPA/pOEGN/lq0cu0oO/gcmndNby
 aLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=wlhfIvHF52xhCTJEUMNJCGavaLSlBdBBWGJiyAyvxOY=;
 fh=sqFYa5HhsXMHk6lK1uJ95N3qZeoUfXxEDP8vyXdmNZo=;
 b=JP5duPT51cD0Ewfs8eX0w+Y3JHMPiUinGltgzqPjemt+bc1A/L8z2V0tNFK22GX+Ig
 Clx49RwAbZEKGGfzEuMocLVKo+2a/aARdfx8v2yAYqXobadC8GiFTzNqzqBhyTuZWW/T
 gFuivpGAGibP5SSvRGPNDlCOe422jGWzfsEMigvuRopjHfIe0Jojdwi0owt5yN1TvmDQ
 bs9YB/UKRX41SLMVZS2409IRLKqK3si2W7w18TLQzxdHUtLf+KCWjJD2M9108oACvCcQ
 cgbSoWlX0xQ3qi41NQzbJJsVMk2RIxqekmGsk6Gk8DZLWo/1jW/egvqSY3ELELgFmnkO
 3tZg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823352; x=1793428152;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wlhfIvHF52xhCTJEUMNJCGavaLSlBdBBWGJiyAyvxOY=;
 b=dciYjvnFme3RZrzanoB1P4Z0K0pQ23AsLTgD768OmoCWvfnh6NYfyqmvHOtKjE4Mrb
 DeveSW2m7LiVkIsnVWKSKJxU9as6zETHvk1kDAQ4cQNO5l/nspsoCiNweErFU95qo0N2
 sxMacqtmNGSCpM9nNBPwusZToOnqWNSnqqZFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823352; x=1793428152;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wlhfIvHF52xhCTJEUMNJCGavaLSlBdBBWGJiyAyvxOY=;
 b=JCUge9f3XKYtYvys6wZcl6eO7m4HrmqU3PmUPBfTZgmqBwBIub+wBTt1nsPh3HENck
 bzGNUNtAcIdiIsGWZQ+Nmz/KsZhWq/P63n/n3GIZl1i813WI2MvnpwnBWmDyfVGqWPjH
 bOvHvH5rsl0mJHjEWZ4o+a6JpCBp1Psq7/h0M+IzT+sy0y0Z0KQ1LUjYj7AsycegJLjq
 5y30qFe9Zxpyhqc8dYYyj5l1pxB584gnwE2766xl9c1A56oekSpoxxkN9KzPB0vzSuBb
 f4b++COvClUV4ctI9KN9DLaoajKaT8lS8rLSlP5HRXqrvxFBjo8FDT3R2hwQ34KaUjUE
 Ya1Q==
X-Gm-Message-State: AFq9FYLub+wAWarSkc1j+a8DZPPhbwWx69zuKQVr+LC9iRyznJbiNhfS
 3b5F782BdVEQHEviPdqYAygmPZoXTG1olasTG4U+LyyoskQGQdl3z6SfdsOEpEdmZAEMHqMILfB
 hq+wqE9xvVp5A1RZBXLD95L9u/qn1C9Bmozl3VG32t5uvFZfeZe8ISw==
X-Gm-Gg: AYBFou3Ee2xB06JwXMsxCrD5zG76JMKkeD/9UnpHpHQUj2JwmNfuVZY454SZzSfJNG0
 vUi14YeM8Ljp9BtgZF9nW6LSo4u2arYt5vRnyhs0wIFrh49Ce+Inh8B9q0AaMs43GHDnnhaUbGm
 Jkun9DS0x6zKXPEFBATyU+otm0KmkAT6+Vkf5Wx4XwEBVSjyi+FnkMERMTvIcKS23lLORT3Qrrq
 VRElWloSaZoZjlZeXMJ3sGvMRpF9l20TsZfAozZyW8z6ybBhGqE55VzaLUDluqPPh/FsdEF2PMt
 achxQihhGvHcoszUzJ22xLtn95ajOD8PFKnQ9FtBL/bJWcewh7pA0fo/cwwdBh6NJA3qA5wP/+x
 It+4KijA1Ta6ZH+0cM3Pc//ORKvrVwmDEv4c=
X-Received: by 2002:a17:902:d483:b0:2e8:7bee:f290 with SMTP id
 d9443c01a7336-2ea9c881cf2mr9363445ad.71.1792823352164; Fri, 23 Oct 2026
 23:29:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:29:06 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:56:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c752b277-c4af-4ab5-b882-092c89df3f09@gmail.com>
References: <2646c589-e23d-460b-92d6-cab299fc4f56@gmail.com>
 <c752b277-c4af-4ab5-b882-092c89df3f09@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:29:06 -0700
X-Gm-Features: AclHuK_Cm49XikVaAIGyabHPH82m2o0xTZM4M9GYLkcMsKXxYFueC7HCS77a97w
Message-ID: <CAFLszTgp-+H0tQf5D-uexwRvUX-1aUUyzxBxuzTU_ArY7n9Skg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] image-fit-sig: honour required-mode on the image
 gate
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-10-22T18:38:39, anon87111 <anon87111@gmail.com> wrote:
> image-fit-sig: honour required-mode on the image gate
>
> fit_config_verify_required_keys() reads the required-mode property from
> the /signature node and accepts either all or any of the required keys.
> fit_image_verify_required_sigs() has no such policy: every key marked
> required = "image" must verify.
>
> Mirror the configuration gate so both behave the same way. The default
> stays "all", so this changes nothing unless required-mode is set to
> "any".

Just to check, take a board that already sets required-mode = 'any'
for its configuration keys and has more than one key marked required =
'image'. With this patch it will accept an image signed by just one of
those image keys, where before every image key had to verify. That is
the intent, but it loosens the policy on existing control FDTs without
any change to them. Please can you mention it in the commit message
(and perhaps in the docs)?

>
> no_sigsp keeps its meaning. It reports that the image carried no verified
> signature at all, which is a separate question from the policy outcome,
> so it is still driven by the success count and not by the number of keys
> marked required.
>
> Update the documentation, which scoped required-mode to signed
> configurations.
>
> Signed-off-by: anon87111 <anon87111@gmail.com>
>
>  boot/image-fit-sig.c        | 32 ++++++++++++++++++++++++++++----
>  doc/usage/fit/signature.rst | 13 +++++++------
>  2 files changed, 35 insertions(+), 10 deletions(-)

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -207,6 +210,14 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
> +	/* Get required-mode policy property from DTB */
> +	reqd_mode = fdt_getprop(key_blob, key_node, "required-mode", NULL);
> +	if (reqd_mode && !strcmp(reqd_mode, "any"))
> +		reqd_policy_all = false;
> +
> +	debug("%s: required-mode policy set to '%s'\n", __func__,
> +	      reqd_policy_all ? "all" : "any");

This copies code from fit_config_verify_required_keys(), so it should
be in a helper. The loop that follows is also nearly the same as the
one there, apart from the 'required' string and the verify function it
calls. It would be worth sharing that too, e.g. with a helper that
takes the 'required' value and a function pointer. Then the two gates
cannot drift apart again, which is how this bug came about. What do
you think?

Regards,
Simon
