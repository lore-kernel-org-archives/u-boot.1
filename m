Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61913606A326
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cXD2Wbb8;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Tv2fQh3X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3938E60ABF;
	Sat, 31 Oct 2026 09:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYW9LjSk5DVJ; Sat, 31 Oct 2026 09:44:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61512606A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439850;
	b=ceTy2KKHrxrp8uOifzzmhPkauLLS+c6vO8LJFmRCoPWWlK052YdCZ8m3MlVRPxCiYRhD
	 ayo2sOL3dB8rKxu+ReFbzgVXBPI4gbh60Zi/pL3UAJc0BDrO7ykbPIjQ+zBt9auPGsmXP
	 mF0ibFnfviarQdpGAi7rnqtDs1A/L05FoOtbv5Xznkl6LyxD2yD9tCI47Z60Kma7/maxH
	 aPKGHzA+uZi2Kkt8WmMjm36j7OCInN6rgOliWoi8ChVLlxSAunhXtGMKT09V/42gvAyRG
	 uwrcXSQgB1UcMbeRZwvAjY3VH7jGrtbAP8YlDkvmxlsObPZyGS4F4xh7ggTBnnMbboA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uliuk+4dg0lNXVP+Wgnsw+vlyzYsMmYWWLm9dFU4lmM=;
	b=UNflXnenTwtj4mBCKER8PQb37qRlWZrcq3cnWWNVB3jvQggQ0jEvqbIl2Ah93wui3j2l
	 +z/M0+7oEKDAoY1zphBEZJWfbfs3YqLP43e12udbMJ69Dbr6C3bPu6x/tHBEeKvaliCe3
	 Xv0TXCU5p9bNyIZVF/DZ2VhhWPRhz7dr/ttN7amHB9O7NbXaPpZvzS3eGH9DzlGPVfSlt
	 NmjXqvLnNZUBu/94ftQsy02wAaQsdKMh2tuqAtrhYP1b54yTtZboGjCBRVsf+milD7SSO
	 J98z/pSI4mhgAxqkRBQ/WzMluN5rHzxJ8oHQz5JBis7T+X3ZVdLMxtUEybHI8GDTK8w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439850;
	bh=Uliuk+4dg0lNXVP+Wgnsw+vlyzYsMmYWWLm9dFU4lmM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cXD2Wbb8mW5hNY+BcTjC6bxZXpaGp4+79VCjpUMdPKgNzW9USOnTs8S7qfAeH3inV
	 uobr59W+838Z51xlTq8qEevNCgWMMY3u5dAyqq30oU0BjeAqGx/vkHcOFE2s3T8O2M
	 Ri81ELrenjQfPHiIhD0o+P75XpTzD8BjLlCEvkrWVYTHDPyc4oTGJqGzyIcARPzGgT
	 PU3rfyhaI3RcLncsoUj3Vz8bx/6f4mE0n/E1NKEl+iVSs/AH1+sBzeFvGdJcvUPu7K
	 33ht+Q5/DhM7Xb6Syrma0pvM5m0ny/1lyBJxC0BzSe952IjhQCH5csuckYVBDkseI5
	 HFmjDZO+gmAWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61512606A9;
	Sat, 31 Oct 2026 09:44:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9FF94BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A001B40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m6EkRAbzcT8J for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:44:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A9F61400FC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439848;
 b=UirdQNQv3dNiUKdYlaMMmDH2YTvHwOKh7e7aMJC8DDUBsojCSfoo2t5ZHZBitvfmd4LS
 uWExlMB7Ovj5glDDdehrNywmDgJUua7qagZ+nEjPPrfS52HVYG9cvSaJ3vPhoqmNAbiP7
 5WU3giJOGGKUubpb2GoQkrfscrDLd7a5BxL+IUjPfErMXOetmOi2m9xLHV38+W6lQn4R3
 EgfWsrUT4RMwO3L4YmkFeO0yeJaRhHeTZjtBfJpbae5DrswhY+o5ov8Sgk0PZHtlRFMrq
 rZlpW5BPFySHniShBT4QJPD87IfL3GHLtj7rIqbgm8rJxbe9T18WLUslLZ1e14kHhPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439848;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Uliuk+4dg0lNXVP+Wgnsw+vlyzYsMmYWWLm9dFU4lmM=;
 b=QU9RID+2s9Bod/240mIWL5N5Aa5WXLtxDiP1qy0dg12l+gpYtLz6GnbZ6b4KWutTJzU5
 3y7352ynz2o88gHEIqUhS81QWCrd637lOcJNJ6Eq62rP3tQkaQANCvsWDc5OgSZsUuvha
 gCrucU5d3Uab+Gn6V/GgWQ4XCIE/4sLFwc1DcXoYcMXqpMwu1+4uUpywJgi8cySvI25o1
 lrdFcO2zQLh3loCCQ7qv9XNx+5jZ5Sg06b7OKfjmW6aqb7L+R+ismcFbmg2IGpIxJGxqA
 GY5fhuf6s25KMWyf2O4DV8jElG7kopEXFgI/kFLcuZTX2yU7DGFGrPrjZSzVMl17ejA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Tv2fQh3X; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Tv2fQh3X
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9F61400FC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:07 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b413b0a974so2214389a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439845; cv=none;
 d=google.com; s=arc-20260327;
 b=SdjTZibVUvyJxZUoSj/qSdlJEl/Sp/ZeBpjXtRBPd8zHUrTXT7oYImGwYb8y7COHmF
 89Mn7PDsqR0aFs1wSC9zmuLJ/b6IpbuWJ2d27wpSsh6TcxW0V1LrMlXZJfhraN4gyi0s
 4gDnI1u+5Wj9Gr3W7kfLvao1uB/lljVl86XuZO8lLoG1wVoT2PqOhJNkd/xD9gfcpNjJ
 iNwRM/lpwliuW3+N2i0t8a69ZPm5I8wE985zF8nhQQy+fAS5enIwP0AfWL69BxWAOimd
 D9xHLzDVn9gcwH1+/1+uOXNu1VWkcECl0ZjOwEKC9lLLtFEJbGj8pWdDXzUWEy7GbWGG
 9DuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Uliuk+4dg0lNXVP+Wgnsw+vlyzYsMmYWWLm9dFU4lmM=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=ZlTWF9n+I1uKVE3E0vBtg/+lgTAf6Z7RPidB0d04MJJi1xJH+u+6j4YIXjEJBNJaNg
 QWyccnPK/3UqRQSCatDsY2X8g2G7Y8+Sjm7xYvXs7q47JDFtI7NHciT3T7Lyny1US+Wh
 Cmg/mXBoRC8Kr6odWsY4RBKKhfzKZYE0RfAWiijZza60oAVq5SAoEl4O2197fk0uEA9Y
 +BZC/tVvdU6Ye3MwV5rkNjDRTiRUmRZneMpIimaC67q0uTyGzXykfKmmgEwnpt1XFaPH
 HHEZi0Fzq+QFv+m1rKRa64JcPl0WV4xxwq5kDLapVN6qExt4V4i+NnUAalkeVtO07H2D
 jvuA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439845; x=1794044645;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Uliuk+4dg0lNXVP+Wgnsw+vlyzYsMmYWWLm9dFU4lmM=;
 b=Tv2fQh3XzM2j9izd9esAmLY3oXUoDXjqGelbBC1FmukatCFkncdy/sBJAQ2KB9Z03j
 REKsAGEqZzRVzMft1zC8uREpZol4p4m4Tqbsf1OzRmT7ME+b1AtTxAyXfndCNQWsc3CN
 gC3eJXqXFt0L6dBLLnGFY1gixeyr84a97Ewjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439845; x=1794044645;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Uliuk+4dg0lNXVP+Wgnsw+vlyzYsMmYWWLm9dFU4lmM=;
 b=BivnHrn9gJOE326+Q0b/qc9hn5qEipRlEwo0Rt2p8yhQ8cnACILbcgfUPrtrmaiw/c
 3a3CN+nPa10R+4ZWNWZGM4hBcZQh7jL4TurHktydMo/weJtbhNhFqaCE+FzPSHIXYvmr
 bgJwtnISansQg6ZUE4YVceLF0n3qlAdCkRysxmDCmsfalUCfIannnauZSmzD3GYkfPcU
 QX+diKUyfK0MJte+4Ttm6RMEESKrsxXj81pReG4oQ64R1Y8naGd7LsuzxNptGPjv/2We
 YaZtOWiPcf3n4decz7xiw7vpakEs8l3nTJPsEsGM9cWn1me1n0l55L5eeD7enpvqc4go
 Ylkw==
X-Gm-Message-State: AFq9FYJkiiJSdMTd//LORWzRcHDVXo2XF5YgmL+ec4AHM8fmAaW5FrrQ
 VHtsWaGquVQ+QsNzrA3yUoh9jCGiwB8DaEe2kMrSSyjqxgHktr/klKJNktWUwTVzJNeCw7r3rr6
 E0jpaEMtswQDwdz9+Fo+izzcm08CYaaesJhjyJmXT
X-Gm-Gg: AYBFou3Gy5XifBM21UUClyPJVCff0JhJfxPxNYsyz+NcCHZQfYJ/MWnYMRfPFBWnBEp
 uRCPaIuPguvJKv8AWMMhSAiFYoluOp1mqJUQ/UCUM/iw+Oub/OJJJ5+DfwH1MopL1l6IgqjlRtA
 ApZdL1/HxG0hgCIpA6myVAifsqFYHDlgwle9YeLQPr7x3qBWM5Z4LFGNVztMFOQMu9st1Pg963B
 XyVLQmGetKQBJbpld2OZE6UOUG5dAc7RqFowNNrEytOib19LvkqofmONSimMWTIIhHkYJC3bQsQ
 o8z3Vi06rwR3W4DnVkV6s6pE0NIo8d3MPmLjLsT+Q4fS2ZzgCop18lZYLTXqLDnXmPGzpNPNjXA
 gdeTeJcH/1FOv/GDn26sCqzZlAped2ZTShM2Dkwf7Y2DagunPP14CSJ95aBAfDEbjZvyhaV31Oj
 gVts6DNbFGJYDYMmIc
X-Received: by 2002:a05:6402:529b:b0:6b4:7b28:8583 with SMTP id
 4fb4d7f45d1cf-6b4d5fdd89emr3342726a12.1.1793439845409; Sat, 31 Oct 2026
 02:44:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:44:04 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:59:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902-riscv-full-fit-support-v2-2-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
 <20260902-riscv-full-fit-support-v2-2-493e904a129e@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:44:04 -0700
X-Gm-Features: AclHuK_64drrj_41bPbmplYjr2eEMo1CIb8cxYICw32w9qYMwr822Zj9u2W90ZA
Message-ID: <CAFLszTiRNW9Xt+hUHZidiCzEv47GaPs_1YUPynNyyGDfYSZWPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] common: spl: ram: Add LOAD_FIT_FULL support
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nikita,

On 2026-09-02T06:31:15, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> common: spl: ram: Add LOAD_FIT_FULL support
>
> The simple FIT loader lacks support for full image verification
> (CONFIG_SPL_FIT_FULL_CHECK). The full parser (spl_load_fit_image)
> provides this feature.
>
> Enable it when CONFIG_SPL_LOAD_FIT_FULL is selected. If the full load
> fails, fall back to the simple loader to preserve compatibility.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
>  common/spl/spl_ram.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> @@ -81,11 +81,22 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>  		debug("Found FIT\n");
> -		spl_load_init(&load, spl_ram_load_read, NULL, 1);
> -		ret = spl_load_simple_fit(spl_image, &load, 0, header);
> +		/* by default, assume failure and fall back to simple FIT */
> +		int ret = -1;

This 'ret' shadows the one declared at the top of
spl_ram_load_image(). Its value is lost when the block ends, so the
final 'return ret' returns the outer variable instead. That one is
uninitialised, or 0 if IMAGE_PRE_LOAD is enabled, so a FIT which fails
with both loaders may still be reported as a success. It also puts a
declaration after a statement. Please can you drop the local and use
the outer 'ret', e.g.:

    if (CONFIG_IS_ENABLED(LOAD_FIT_FULL)) {
        ret = spl_load_fit_image(spl_image, header);
        if (!ret)
            return 0;
        debug("Loading FULL FIT failed, trying SIMPLE FIT\n");
    }
    spl_load_init(&load, spl_ram_load_read, NULL, 1);
    ret = spl_load_simple_fit(spl_image, &load, 0, header);

Regards,
Simon
