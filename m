Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF3606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ra3ON82+;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RJkvNnmv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19D6580CF1;
	Fri, 23 Oct 2026 07:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RnplZf8Zf5up; Fri, 23 Oct 2026 07:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 603BA80D2D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792740894;
	b=WPkyh1Hl6ApIWfiSI/7mvkohy9iMEV3BXKJExD87JRw6lGJWXe6nxEQhgWm1FWOt7cll
	 mfKA2v2zsyCJ7C4ScN+vXIpS4+mP2QqaguYBwoiGzpP+s2AxQlp9HG7/7gnGd6ogLuYQh
	 FA760NIWYu25wjDJuXqFFSQTgxdEauBtZ9c+Re95hbSZGxEGmCyR6wkNMsZwwzFG8UWpa
	 3w4o1ifLkSBbbjcW7SR+oL1vlkX6b5w2v10p97r7iSvV94ZPvsoJqC0VZEN7UlTjezJ3V
	 Nwk1/Cxm1epnWBXtoQJzDfXumaEao9nhyJtdhmoxp5ML2Bn5uKJIxSELmB7r01picdw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792740894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XyBAKPCtSWAIKnRjr+DL82eMkItNRPYk5dWtgrEdMMo=;
	b=JQ+YaBpg69EbWJL2/kKO8upw5xNZUw708AGd7yDoJj1QgPopTZnbV6Up/2KgnUfcIx5l
	 fTagbx8oXIjLnzsSCj+/aITudZftcbd3NTzy68F5a7S+Ny4UyND0AcMGS31CneqqT22cK
	 aKKcPC1MbnFfYruZYPzanj64ejKiv05uSNzwc5PpgYAthiWsfwu3YRcKIKPf8bcA7eiP8
	 xP0ixOC0VCsZzhdYAo6KKKyteMbylLMqDqjA10kYg9uvy1kXI77ZaHYNhn8eKYOPiMI9i
	 KoqoqgvIqPSuy15XxRFckf98k4nhVP50I+qzu72u+Wmr5r9gCoibk2jGtLkpN9hJbNQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792740894;
	bh=XyBAKPCtSWAIKnRjr+DL82eMkItNRPYk5dWtgrEdMMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ra3ON82+uHOr88hAK6pi2WrnADdQ6L5q4MKpLKF9soLaWizpE56bFtG4GQKCzOC69
	 w/Vej4orFfjV3WxkepnIqoqWKsEV1rtiLtBr3BVYxnTRtoXu9ZN/VAZhpK1UKWeJHU
	 +k501PApXZURSLRExEQsyh7AzN9CIYt5OeEroFSzQ259Fk9E0f/9zy5PNV2oFdPdYb
	 qRLgvP61guiQcMntT6bC9T3Dlb6xF+kwawFYMhbz1RqcUjoBPWRlV5v1X6oDotfBjQ
	 BIJ34Z2WuJ8XwFeUg+QbpN6+kYgjQF+ZDS+c5jo1Ufco9EoNML0dBR7ZkGJquPG3BK
	 V6EczLHzrKZmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 603BA80D2D;
	Fri, 23 Oct 2026 07:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6EBC3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CEB44008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ju5TxNWX7oua for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 07:34:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B01D24004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792740892;
 b=KkhoM7DnW0iBxxeNdmNdA6qnpEoYbIKbTz/l6xV5UuLvxIWKwEC4rCbDDU4dtXXTt9Xj
 Vx4s0W2dY7P922VRvWAKuHz58sN5/rzCJ5WZB9dsxMWpXG8+eGewFDeNTUOla1bJlU8Sg
 2mSTOqElqJYqXPxMPtcOsvGlF6jMI5pFuV4bcCEmmu4wAeNysm7JsLdYAyd2f7dO5EZ18
 AZTR+6ig9u7bPLKyn/uxGX1zpIP4JxL4wrVVJx2p13uj9biUvPAEcef/vlOCYbfZfB4FY
 PwxMcV4B2n7RnYtGIz80r8j4poQaQ5FE55JyV5LfXAjclvQ+JehOhi0zZY6uV4gxzeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792740892;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XyBAKPCtSWAIKnRjr+DL82eMkItNRPYk5dWtgrEdMMo=;
 b=act3EczLIhfgk77fxy0LtvW0UiW0LOs9zDOAvjI2Gp7/jmARg6aV9lFAX8vf/f+vJ00n
 YEF3nOtV3con/30oxFQ8rQpwJjKu/la7Gw3bb6WNqi3CfoaNE7pepMxpup+qT8B1sTiGM
 2tLICmzEwR0z2y3oMSAn9d1CKQqrOgh598lOSrgxMzyVAy+1wYuvgN0CuKjtTdrkPVZAB
 oiCDM4GlIJnErDyOhApSyKdHF4L0SXCE1MH6cIEvjqeoPkNAADXFYj9ddJRhjgEYjUoMA
 5y/iy+d/nlBcf/Z88/O7Gb3nkPbzn095Rpke90qLNsZSnF6dVHx6Fur/o8iguYI87VQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RJkvNnmv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RJkvNnmv
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B01D24004A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:34:51 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b10d24345dso5731407b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792740890; cv=none;
 d=google.com; s=arc-20260327;
 b=e9a1eA8Bw+iB6W5/Icwtz4hdrxSOgjJJMyC9PnmxSL+igEvsew29cmAInyqdZo6Zrm
 Ek7TfSDdj8GZtwpzkzwy+53JauuV60Mkpfqe2COZopLdkTmhFt01nj0HwRIgA1CpyeBb
 1Wt0BToeXFcd0azBC/PpLxJ1xcfZ049ITYCs0vgRfMTgrqavkdicAklr+BFHXhyT1x83
 onKJJSOhp/j6B55JvcDtptBkoZ58pQErNXjSKZRH6OaBYBr0PVcSHNGXJnAIs+OyKRVB
 S4a51AkRAoc9Ql2I3+jIKb7MhkIKDPnEz7acX3iXk08qEQGhSe/5dpGIIUrwKlEuP9VJ
 GQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XyBAKPCtSWAIKnRjr+DL82eMkItNRPYk5dWtgrEdMMo=;
 fh=pIs7cTe87uE4UyM+V8VLu4AA5cPEQNk+9H7WuMBSPos=;
 b=K496eA9UU3bq5VR+idf+M/IUvm+JWU4YID2/cDOsZjB0xsvf189rEHIYaMi49q/uef
 wu3eEEMM1RpWbGQ1ACOXIy90QCFGdlxmCfs5gCbeuy8mIO4gvbKgyOwBirMcsFri5tjH
 x4y1UqfbT3JnJ7pnEH4dHcF+xS4XbN4sJKnxYY5qz7FpVJBjwwLD7An94nWB0XsJN1mi
 fH4OZqWSoc5lJO0vK4cd+Dchzs5YBc6Ar4h4kyaGrNh7JQiI1t9tYmS05RaNygT8b38g
 ifJVA33/N6khd183IEYnvnGFMSrXSfWl66GCH60n+g2QDHw5pVy2keSApbXD7LCU+ZVV
 vuJQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792740890; x=1793345690;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XyBAKPCtSWAIKnRjr+DL82eMkItNRPYk5dWtgrEdMMo=;
 b=RJkvNnmvz3RnaCNxeLaeI+1ZkupjCi/PWGxlXf6wn8JvVTineBALbkvvssFsdcmjI6
 19inIwsdPRFxjgF5cA8QhrVG9sR61fhWSkuq6KSDWgHf8frG5iOCmjE5KwegJyf5JnAB
 IZCoXi79QuKikox4UZ/AxYk09dhydSDIfElrUszft6M3rVvXla/MImZpTI5vZrKt1UgV
 Dkzl1/wr2/pcziFZW8QYiVR0o9xTVTZXu+Tx5LMWHy7/SGE96CreeXp3ZNVfsnWnLnt5
 ZWR1jtyQr6QLds9HqSjLDIzbMlFrF6die/vuhdyYoW28HG2cb5y7jH9ngBnVHbAAg+oV
 R/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792740890; x=1793345690;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XyBAKPCtSWAIKnRjr+DL82eMkItNRPYk5dWtgrEdMMo=;
 b=pqkfJw3YU4/hzcPWr/ruwsuVE77ludhDsbPSbItwo8E7qk8PLZlRWLPF6yglwHV1xx
 Qt5ZkchG9Dx0FiQ7tSfw1tNdTuxmqneSXFtf7Pddcowqwr5nk9W17zkXgUw2FH+ren2g
 qNnkiZrjoTny8o6c6t1f3KsEXPunKf4N1Efk66+Tn9c2YgJPb5G3VcCjUd5iashqdt6I
 82jU/t/Fxh8AZqe7Z2E21RQ4mJTvXis+6JWBKvvNaglvXu5nYhrj1wYkK+KjaaemCFTG
 C9Z1jwY9CDda8+IauS5V8gNWH1hkFrkUgd5vDfnPkLI9MbHQJkIqCJcEFbFw3A86Lhgr
 R0bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSRYw4i3wGqCau3MweYJYYhqbiMrhL2d064UHCEbc5QEa0fjWZ3RYRaBvEjZY9VSYhc7AUyt4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIdQGi6bcc2ahATqUnNoCSLrou/G7FsbvbizQ4dcfCqY7QBSZxD
 ivwYK3LVWNYlG0FKdf/V2H3lRXssgxnJ0QWIIN0dtoPVaSQXOzNhrb4J3g8+3moy3AYt/RzluC6
 G+tvoDty+0hAunOJ/bbr/F/63WgxfQWSDaFnSpQZf7w==
X-Gm-Gg: AYBFou2bh2B9rqz4EBKoFSEVgkcb844k32QJ6ba8bDJBIrYG5QAdSJ6KqHDUwCTr/IP
 nAUmXtFnUACC1aWFFCfJam3qGSFgZ7bs01g6oMW+Wp1Ia8y8GmWq7yQXbbSSZB1oarQC6C7kecO
 3qejui5E9bMCUQKev05rR5gi0E3Jdde3bSGwW2/ne04kGrwuuHcUGzcujMgrinjcYACa2i/Mm8I
 Lg83QCdUQn7ts5F96PrNj4vjnVupKUN2PWotO6OeIBcHmfLJtD0ruzsxg7lo7RQVL6AS7DKpS9W
 TdgOiqkr0nT4RvMVZxriLu9hy6Ei6xbdnAiv9NkxYbr08yHws648KqeRnDNcaVtA3haKrTADvFg
 tuHBBnsd1GTA6jUVoh3TKJtd7k/0zWm3wu3QI7SEMP0u4y17TykcL2CMzKVKPz2o8K6nRlyaEd3
 UwdOvUmAbPSe4hmT3+7QmpkNhk0ClrVEdwu+Bq2LXZs9C/N6jey5+I8Zm2DeCEQzBSlj9FHT71t
 RYq7uUAI4kvImD26NRdoYieWEGIyuWbqiWyyqwOgo4zD7l4DPRCReQz6K4Q795KL5uHo80UqOw8
 5aRJB9G1Ys4JnVzOw7egKAQUIOEWcAz0gqOq57MANlJfAget0I1MnTisEoOZ7GoVj15KYFNAbAw
 iNcL2eMyOKI2WCljzYdbeS6qQ0kx/UJ1rOfyPK0LpEE4iX6R4kddwE58mGNCvTn0tpLmZli2/XD
 GSVlantN+I2CDZMA64QeREnIL4SnNcyNBXEOUr
X-Received: by 2002:a05:690c:f09:b0:8ae:c724:4297 with SMTP id
 00721157ae682-8b157c61d0cmr13834277b3.3.1792740889934; Fri, 23 Oct 2026
 00:34:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022214433.93112-1-oss.patchbox@gmail.com>
In-Reply-To: <20261022214433.93112-1-oss.patchbox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Oct 2026 10:34:13 +0300
X-Gm-Features: AclHuK8JR-aaaTi5Mv4Cj9v-H5yuUSEAAQ8j0du5y4WX9jaliaU-fIbP4jiJIMs
Message-ID: <CAC_iWjKJZE4OhSoaxnVvomOtetEaeBs5TUSgBNa4xeduQ9oOyA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix image and load_options leak on FDT load
 failure
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org
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

On Fri, 23 Oct 2026 at 00:44, Yuho Choi <oss.patchbox@gmail.com> wrote:
>
> When efi_bootmgr_run() attempts to load an FDT specified in the active
> Boot#### option on non-ACPI platforms, load_fdt_from_load_option() may
> fail (e.g. if the file is missing or unreadable).
>
> In this failure path, efi_bootmgr_run() returns the error code immediately,
> skipping the cleanup code at the end of the function. This leaks the loaded
> image handle, allocated memory pages, loaded image protocol, and the
> malloc'd load_options buffer.
>
> Fix this by jumping to the cleanup label 'out' so that efi_unload_image()
> and free(load_options) are called before returning.
>
> Fixes: 39bac24a48b0 ("efi_loader: load device-tree specified in boot option")

As Carlo pointed out, the SHA1 is probably from an internal tree;
39bac24a48bb is the right one

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  lib/efi_loader/efi_bootmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 51ecb6ec1f..934f0c4060 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1323,7 +1323,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                 if (!fdt) {
>                         ret = load_fdt_from_load_option(&fdt_lo);
>                         if (ret != EFI_SUCCESS)
> -                               return ret;
> +                               goto out;
>                         if (fdt_lo)
>                                 fdt = fdt_lo;
>                 }
> @@ -1339,6 +1339,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>          */
>         ret = efi_install_fdt(fdt);
>
> +out:
>         if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
>                 free(fdt_lo);
>                 if (fdt_distro)
> --
> 2.43.0
>
