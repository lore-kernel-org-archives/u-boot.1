Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBA2CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C83F84B42;
	Thu,  7 May 2026 21:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="s1Ykm6ED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB9984B9D; Thu,  7 May 2026 21:03:50 +0200 (CEST)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com
 [IPv6:2607:f8b0:4864:20::122a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A262D84A75
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-12e332315a8so26124c88.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 12:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778180627; cv=none;
 d=google.com; s=arc-20240605;
 b=Fladyg/FmfOp0fJ0LoJ3OtTPHUHcmgBbMzpQYHUsnpCZEhS0PuXD5lxArsCrToM6S4
 zaVbhwqU3NWT4ytAS1E1xKVOK51DgadAI/yqHV6rdlw5yTbSFos4//EB+khflReKQw5F
 EAK/zDxe7FUZLjmmlaIIfHaglki2vsGayjXY2vnMUsnq+O2/3VqB5lWGdQZPv0+87EpJ
 PuW7ix8qiHVymsmpWnNHGF4fEQwws3KWDIw6DDp0YGvif1HjHa+t7JCNlOmYFZYfV4d1
 lmemBVmByph8cAGgZEtFxlb1MyzWYN9245huX5X1TQGfkMUmtG3nh9hnBHOQcvEey+xO
 q5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GvWUtecuUvVpHX42Q8e7/ByQi/ccv7bDF4lo2CHH0S4=;
 fh=rQdNVvvc8zqJicVVg1FKg9muS4zc+bsub2dGVVYbfLU=;
 b=QKtku66/hMVQxp/wcLTWNehU+jWccdLRaimaMHnS/wY9tb9CKyv/0eU9kNpXLRDUu4
 r4BsZzRr544x55ueaPWOYG795PPHtp2VNCCWCzoqLm/DZsAWFnuIDGTpMr30S0SGGBQZ
 naZbUW8tDmZAia9UFIac1EX+BeCiqJFtSCzifYy92npNo/ihmOT6YbJELAOFHsSpOUt6
 EUrH2sWCFUfPJloAGLTN86PkXBA8zOoxhtrhuPrRXwplw1fPMqnN5USqdVHMARJ9cBoG
 yxYiQYU2agKR13/dJ0k+1XoB7cRWz6OsL4cQ0cdJiNCqjKF/JwdDnpSO3nSCrdoZSv15
 sW3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1778180627; x=1778785427;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GvWUtecuUvVpHX42Q8e7/ByQi/ccv7bDF4lo2CHH0S4=;
 b=s1Ykm6ED/FOXjt4ZgcQXzhcrp6p1nrtL8wbjqrT2A3m1b+uEUGXQyzIQNzymf1f4rF
 2vOPSO2o2gRn3pe+Sdf2GX5IX5Ic5IaN2WVEbqW42nt4dOLQIv8WfTQvqFp74BeAq8H0
 kLehrTFOkmSLiRsafHp26V84hpq3qhI2JC4xgswDorx9QQYrMS+FURNxjuNIwENMyS9k
 YB/GTPdUP/aATT5N2ZYuohNxdu+FEBRiD9YSTuHnKT2yv1hpL8LDC5g//1wkLGjBIEV9
 j2vdovr7MAEshtPPq3xmUQmrMEyCNICjaiRCvlXXjyUFEL5b2nFJjJeoZAtzI/vwcxo6
 xrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778180627; x=1778785427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvWUtecuUvVpHX42Q8e7/ByQi/ccv7bDF4lo2CHH0S4=;
 b=EqmBBRPqOkgXwlPX1EcEGO3KKwhimrhSDf2KCt5vOXmUpp5Af/HHpvWx0g0ihd3UBS
 P5rKpPZl4JwTlIlzuziidwQ2+3rB/Wztmrzr60RwFRwBE+iu8HwuWLi+M3akOY6Xaizu
 PJj5myLKsUvRFIDjaqO742EClXt14lDW8qtRVYagnB99MdUOWTlvRUq7xh4G5jmm8iPy
 dZ23RJooy0yrSLVE4+geHjLchhWgZwoZXJp0XqE9xxFynjFlAp8re3S2azGT/1cCMOy1
 4PeffPPj9E//45nGX7PJx6HUF6UlUA6Nuc9zU73eie/FyiAh+N9X1wzgKPQNfkFxWIaM
 LQfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lT3lm8Nbj1LN80rZtn8KtyWm3tddkl2GbRg1Hg2jPblmfepISMK21Wg37ofQZi0143cTrAmc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0TKXKsY28TGrg8LqoaZL69mtjuJtdrUJDEFco2vlXQy0N9olw
 iyWU3Wiph3BDNouTb/z3UHXroyT8W9NoUV0+5yaDs839J5pY2YC/hsVA7jmPQ+YfjyocEgJnGw+
 rl/I9E2GfDw3QP6b++BnqCLq+ZVhKyqFg2OCHMn8jgQ==
X-Gm-Gg: Acq92OG9uoh1Wso9IjwVN/ycYbASwA+7YxIMEJd/oGXjraWEJ7nDOWNPPIQROBk2B0a
 jH11wcMDzHovyBqRvJzsb61B/zX4N7idPr2xn4MTzFpjbDCVwTMpvNu+p2TwOxktbxwyQ6+EHFU
 rE1uwgxlkngzECxootMSJYv7QTapdt5FCsoo7+RhR6GB/gbJgrPkHVc1tGFfwko03C2uhj7KYme
 Qh1fHz2SNtjMugKNGIFOyfdng4ENL+hgQ2MfKTtTycXVz+yvuXc2MJLevRXf7cRAlpSUl6/2w2I
 A10N90MhqzvQ+wwASDEbkCwPOwdf2t0Oj5ucJNcasgeS6AbFO3tV7rVfeRe8
X-Received: by 2002:a05:7300:a508:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-2f549e6b382mr4803495eec.21.1778180626718; Thu, 07 May 2026
 12:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
 <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
 <CAFLszThW0u0SrntCfXFi083petNmszVmSjNgXFc87a38tHyx1Q@mail.gmail.com>
 <610b19bb-3282-4062-a3f5-3071c69dbedb@cherry.de>
 <CAFLszTgjvZnwsLBQicn4=g_wia3JP8EWs1H8o=pUe6L9kcC9JQ@mail.gmail.com>
In-Reply-To: <CAFLszTgjvZnwsLBQicn4=g_wia3JP8EWs1H8o=pUe6L9kcC9JQ@mail.gmail.com>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 7 May 2026 16:03:30 -0300
X-Gm-Features: AVHnY4JjzGzWCZn6JHrXPKH3WPpdYBODRWZG3AqfnteuRExnUc-o9ncvwnRGJw4
Message-ID: <CANu7NGspwLDTC=iVYse_TbEmJ8yLuGtVBnVB5_479d238qFaeg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 trini@konsulko.com, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

> My understanding of the justification for NOT passing the env argument
> is that it is annoying to do that plumbing. But I would rather do that
> plumbing. Perhaps not stated, but one of Binman's design goals is to
> try to have callers pass in their requirements rather than relying on
> state or sideways data (although there is plenty of that even so :-)

I came up with a solution similar to FIT image signing. It is much simpler
and does not require passing additional environment variables to binman
(though it still requires defining a few environment variables when
invoking make, such as OPENSSL_CONF and SOFTHSM2_CONF, which I assume is
what you referred to as =E2=80=9Csideways data=E2=80=9D).

Please let me know if I should submit this new version as v4, or is the
approach of passing environment variables to binman still under discussion.

Thanks for reviewing.

Regards,

Sergio Prado
