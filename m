Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C7ui32ao;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=idN78xDs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F90680AB5;
	Sat, 24 Oct 2026 06:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIRuft1hQoDU; Sat, 24 Oct 2026 06:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91CA180970
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823620;
	b=Gd7faQ5zkagMpRYR9WyrXamC6wfYaXuXs3hfQyAjDiZyugwCGdtA5lnWilkW3BRk4CvX
	 qV7oqgyfKkFJZXLzlkY0m4gX8INnFg60vCe2DzGj/sO1ByfOGI3TToqDG2GNP/0DTcBB4
	 onWzHlMllM3x3vdkrkJ/pTXefI8qU+0Mw1hm8KrWia94rXmYA7lzvRHMmXbch8NpXR1gN
	 Rn4CTTeCzlQTMZSeaNR0zsnCk+9mIxEySI5EvSX/oIC3tFx6asDuM9HKY58wmBb/fol5m
	 62sI2UqU21uAcZwRgNn7eWL3kGJrt4VsLncXzwnnNZtTyI36eVju3iliKZhHcMERLQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tJO93/VClrf9nrpLI30SqV2Xgc+BGQREkVOna1qPxSc=;
	b=SWR7vjtkcmd7RA+6K4hsuToTy6VeBfRInKCb/iV0ZQnnCEnWDWcnuMzdcVy/hLg5XvsB
	 2QU7nOPJewTHCngeUSq64V9Bbj+Ta79WWcwcJi9PjrCvnE1bdkkBLHBZo3TrmhhA6NIM0
	 iJ49R7DDoO1U6QpPxhWCfwqUSbV6mHjj4SPCckM2oza8ai3GGuVmIIqa6AM3o3FpnNrwr
	 mF9SuQfGlNo7Gdfz+6HZM6IdduqLPw9SyN7SEnVkrjEXQFsSVlB5+XfIiA6bGa8F1WYWT
	 rmnOojF5bGL29RGnas/QJmO/XCqluxiKqRFXuDrfWyqp6CroiBQctsQs+Izzy0H2qbw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823620;
	bh=tJO93/VClrf9nrpLI30SqV2Xgc+BGQREkVOna1qPxSc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C7ui32aoGMIE9yCcSatAoKWLkrzGES2qNvL4Jmv4ui2rsj3Z9hztc8KHplnyRtqkp
	 6H13/5OvqkGKI35YVbpJGA+1FwKsQCc0Oi1mYuMr1Fcj6AUwyAZWGf0e1BSuRipnl/
	 BznU7IbngmgGD0T6cq9/J/lHckUjno5vobFbK1dMLcFLgBAQ08fm4/uTAJ+EJrVpZ7
	 c6Zm6QLF2R09L//xnQFIGxA5IbaZwzuruxZQ66MlmOGZTf/SnxYHfgWfaLunNLphL3
	 OHK7GIh0NK6HMAz23vErRjDcAa0uSjdqjriQfTqo/upIWb01S2/DDUEfr6QZt5CIFJ
	 Ch95WobfgaPww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91CA180970;
	Sat, 24 Oct 2026 06:33:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DDC803C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C256440AF1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svfFciuVmUsu for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:33:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2F3640AE3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823617;
 b=VoSR3Z7MizdFBXifHF42GYaAtZenSE1n3RSbkPoLPMrQWaCHsLA7u7EuhxMv6W1KmsgJ
 0LYg9eGfSgHi8x/GhAdG8fXggxsxEWfRxAW7RpVK4lJceLbt1rlUFqnSVqx8+4wjta/Ij
 71yOsx7W1+cIpi5phjz36bfzqtnGvExeHxEne9GO4v2zrGI5A1RSc8l4x5BObo/HlUa/n
 ZJaQBcsexH/zEhVBacUyzLbt5EKkGTm2b679YNFAOf9IjNNI1f/xq9SxAg1NI8KhEUUyZ
 yUpZ0urNkd5eVnUy4gu7gmv3r8tkNycLykm5kqmMT2Lv7zYka5qhKMe0U6eF8ynrM3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823617;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=tJO93/VClrf9nrpLI30SqV2Xgc+BGQREkVOna1qPxSc=;
 b=Xj59u11HEP1i+h6bAGQJqIZtNXQpkYfxIbh2/zL0d0o9g2que6f4cF01cUhQX7fYWmlZ
 om1ZUPiw2EMf+LtDcbpMDY6Bydgk2T7+j6lq0GBfwh7uPOkzIFxwmokB9UbPwKsJqTuaW
 H/iU+5HckrFeICidKO2LR8SvL+m0Cu36FCYZ10ekWO/zpp/lpS65X9Um4ufQImTPZabOf
 pcepDUgzNvapLQ29WCZgdT91FO0ptfrjaHsD+zAzMRxJTo52xt+B3++nw39+TjiqJjb5Z
 AilKg0rm+XydiOAECyAin7MhogpB1VBrvf31SNzpkRx9F0gvX46LBVc3DV08XQrePVg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=idN78xDs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=idN78xDs
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2F3640AE3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:35 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so909257a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823615; cv=none;
 d=google.com; s=arc-20260327;
 b=CkTpOP7B4TZY8HY1/rEQY6ns3lggcnQPLkhVw2GAhV+vDrKRMMShSSUIW0gMo0Pk7Z
 mXI5c6SxSjNpPQL2Nx9DwHBauSDcZAgIkqNyef7IsZ4/DtrtcqgW0/J9vI82lJYYutfg
 V7w6d56kyaK0EUnQdSu1G6lD6Vlsew7XtFTxd6I69ZkSyUKHwcJvzw+lzFHAKQK16d7W
 ncJSYjdNkB+s1igbVsBidOqXqoBrqK7kUwU1ZhUxKRZV4wwwg1br5LZ9Sb9UZWZ11Frh
 po1aVvMqAtPHDKZIi3C32OsJu5C9YSI8PnT+nEmRUqsbBmaqAUVAonN4+9p0NQbI7oT5
 7eOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=tJO93/VClrf9nrpLI30SqV2Xgc+BGQREkVOna1qPxSc=;
 fh=d7sF5D4DcoSZVTdzDIHnkjnZsvRUo1firRnkGpEILME=;
 b=Y1wD8GXMuooaY1C2tv2BHGP1bKJ7VLsl5lh2ecoWtWlMeDFFaoy3aIlzfesrmHW22T
 E4G0SBxu4OUJhihH19TSDMvjHEeKrInwY/KJfRiq4zsmbDQSqEO52Vs8G1uOP3b9f6Nv
 jF6EURB6tC+zgU4s4bLdyAiqTP2EH+fvD/aTFSYidJResB7IiOjoiEsFdXOn6ZCbH52M
 hInAf4vxfRZovkSHNq2Xq25/eY3uHUOss5DCAEm2v1TXepuKFX+Lix2xRYDL7o2YUYOG
 0lir9voy4JYz9CC4T/8h9YvZZO1Jf+uHQ22GkHGWJ8M18ijPz6VtclJZWIC2Bv65Z0R4
 4CbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823615; x=1793428415;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tJO93/VClrf9nrpLI30SqV2Xgc+BGQREkVOna1qPxSc=;
 b=idN78xDsNol0eZQ4hmbPH7EUmK1JFFz8ZFSX6JneLzlIQnje0b27qjbULYWDveF6TB
 7KceVtiYYFgXM7InoZ+yK3Mzsu7JjM1RqY4+xtHYdBcPLdnaPHmGX7bSYObuPKkbwoLz
 zsdNgwJ/xJOq9K/wOn0U4RbKf06Ea+k20aaU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823615; x=1793428415;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tJO93/VClrf9nrpLI30SqV2Xgc+BGQREkVOna1qPxSc=;
 b=ghUwfBAsRxciVLNPvRtjf59+divHpkgTO6phIMnWXoHf1t4WPHtL688pO+TUkW99KN
 k61/8sn8Gad4FThpVAwR5jqhVA/H4yi3jdYT8PphvpMJohNmK0k87r3Zfc+CG0T1yxr1
 ObW9yi2cepd4O1r9arX6pUSbQ4/kfRJ4Xq5Ge3men2zU7Ho+oxU+k86WJ2NFphlULq0Y
 d4cv9U62tivohrbZspV+qgXgESdYm4E8klJf8LNMqb/FV58CZZ3xSnRg5bzL0pFNdEl1
 ELUSEOhrCzG5T4zrF9jv4Ezqc14sIP05WV7/2XMvqfm5L603eyr/GHAsUjVERWJCoUI/
 XYzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVoOhfgIN8iRZiFNchq8tyU75IwPhyipqbKxDUEv7Zt4/SObRgNnf7pncgtuakNTvbNMJc6iY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI9JdkrriKAsqkbmHsQ8ieHdwfKKJMyd5RKixiZxpplK2rCyE8K
 tMVO+YAvyewCPMvCTpFVlXHSPoDuj7lP69X1tTQz1G5+FN50LQB/oLTxtH9wfxK+6GRGT3kHnel
 zngCzN7KIf3vGum1sDeXs4E8b3iToo6i081lxgcM2
X-Gm-Gg: AYBFou0yoTU+SSB7IYfuOrgo3nftia9KLcDfuKHeHHqlS3QtYByhYTwukMqJaVFNZmF
 FwDkfEpzsnE/nPZnhgF6hGtbE079z1hBHYMjXTxAf293i+MmX4SdjQTHmRYfxuOVWXgnhZxFQ9l
 ZeZ/dV2JCrwk9QZ9Hi0G6rvHHmOk+V9TOZK22ybd169fsV23sT2lXfd2HAVr93PzVUA1+gF4LcT
 UV2KXi00HlAAWMhweN0IpgeXNs3Ibk6yERFRClsjFHlR7OIfDo8xjJTkmKHMbN5LP9FtOc+kjzm
 W5weCCteRRD7bOpwX6PBED/e7PMzrhVtbKFVu8anEhZ7uVWG6kjULvHlb4xLEosuz8zfuIBnfzZ
 0V1VAdrH3fTnV6Y1r/7fK4Lyn6rHwl+u3jdw=
X-Received: by 2002:a17:90a:d888:b0:3ac:80dc:f419 with SMTP id
 98e67ed59e1d1-3adeae7309cmr1236864a91.25.1792823614660; Fri, 23 Oct 2026
 23:33:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:33:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:59:18 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023090611.778581-5-yan.wang@softathome.com>
References: <20261023090611.778581-1-yan.wang@softathome.com>
 <20261023090611.778581-5-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:33:30 -0700
X-Gm-Features: AclHuK-iRwichYcxZyQDnCIjsYp6SlELZfQJWqUUdIJYFntGUOXDr3N8eWpNW-s
Message-ID: <CAFLszThEJ7PY3PHadsqH3kRJxrz-jr4GH8bF6VCgo0j5QVFZrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] binman: Add functional test for pre-load HSM
 signing
To: yan.wang@softathome.com
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
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

Hi Yan,

On 2026-10-23T09:06:06, yan wang <yan.wang@softathome.com> wrote:
> binman: Add functional test for pre-load HSM signing
>
> Add end-to-end functional test for HSM-based signing of pre-load
> headers. The test verifies that binman can use PKCS#11 libraries
> to sign data via hardware security modules and can generate pre-load
> headers with HSM signatures.

Please can you add the short paragraph I asked for last time, saying
what the test sets up: a SoftHSM token, RSA and ECDSA keys generated
on the token, and a check with preload_check_sign (or Cryptodome, for
ECDSA)? Please mention the new error-path tests too.

>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
>  tools/binman/ftest.py                              | 230 +++++++++++++++++++++
>  tools/binman/test/security/pre_load_hsm.dts        |  21 ++
>  tools/binman/test/security/pre_load_hsm_ecdsa.dts  |  21 ++
>  .../test/security/pre_load_hsm_invalid_algo.dts    |  21 ++
>  .../test/security/pre_load_hsm_invalid_padding.dts |  22 ++
>  .../test/security/pre_load_hsm_invalid_sha.dts     |  21 ++
>  .../test/security/pre_load_hsm_invalid_uri.dts     |  21 ++
>  .../test/security/pre_load_hsm_module_path.dts     |  21 ++
>  tools/binman/test/security/pre_load_hsm_sign.dts   |  21 ++
>  .../binman/test/security/pre_load_hsm_sign_pss.dts |  22 ++
>  10 files changed, 421 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5992,6 +5997,231 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        prefix = 'testPreLoadHsmEcdsaSign.'
> +        conf = self._MakeInputFile(
> +            f'{prefix}softhsm2.conf',
> +            tools.read_file(self.TestFile('fit/softhsm2.conf')))
> +        token_dir = self._MakeInputDir(f'{prefix}tokens')
> +        with open(conf, 'a') as fd:
> +            fd.write(f'directories.tokendir = {token_dir}\n')

This repeats the SoftHSM setup from testPreLoadHsmSign() (bintool
checks, conf file, p11-kit lookup, token init and key generation).
Only the key type and label differ, so this should be in a helper.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5992,6 +5997,231 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadHsmSignDataChecks(self):
> +        """Test _SignHsmData() re-validates algorithm and padding"""

This test only covers the duplicate checks in _SignHsmData(). Once
those are dropped in patch 3, please drop this test too, rather than
reaching into the entry to change algo_name after the fact.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5992,6 +5997,231 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadHsmHeaderSignMissing(self):
> +        """Test dummy header when the tool vanishes before the header sign"""
> +        from binman.etype import pre_load as pre_load_etype

Same here. The tool cannot go missing between the two _SignHsmData()
calls, so the second None check in _CreateHeader() is dead code.
Please can you remove that check in patch 3, along with this test? If
you do keep the test, the import should go at the top of the file.

> diff --git a/tools/binman/test/security/pre_load_hsm_sign.dts b/tools/binman/test/security/pre_load_hsm_sign.dts
> @@ -0,0 +1,21 @@
> +			hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";

This file is identical to pre_load_hsm.dts, so please drop one and use
the other in both places.

Regards,
Simon
