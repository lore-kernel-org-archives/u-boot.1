Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE95606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0Z1fu3y+;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=g2lUFmNM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4606405B3;
	Wed, 28 Oct 2026 08:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3C0_POB176N; Wed, 28 Oct 2026 08:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBC6740560
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177793;
	b=jQj4mNDkvClhiLUhqVrld5vkJa8cE1dotvuvfQ2WmGa0IvTxJ7SZATbaBm7/Wn3xRB4B
	 bUphAMvxTHqNVD4NUvsnaxlzLgkQfddXg3mUPiuXed8qtI+og3y5oWDEyITkOMEZ61fRU
	 xVzyPHf6RJNQYnJhexTCIRdTrOWm4RV0lpwFTJfVoRuGRwWbYobE8IZGl+ylVJ1NEqoQ2
	 4A9p4ZMEloga9xUHUJE7ZtJs5KvlL/k//BAupw9b63tzJJrN84L+1YJzbTknVElk+4t4Y
	 XT0lAtpztHwOR0Be7Kf1oj2fG/RcDt20hPPFWetie9sTXOu/s1jKJOQl1iwVyzrwlXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0PSpHOa2tqH9KQ4sv7QtFgWpdM5jFMb/WSqKNLRlO90=;
	b=N/p5wkt+/2ZwpyDs8p+jWW9C8DdorTSKFGHE1shwzV66FaxOYOZpYZs9QGTH96otioik
	 fCo7/JXHiXz1oWswAFCEuDuB0UONgumhv6T8QJaUH5VfirLHG8keRyY3lIa1Gh2z35Im/
	 M3TJDFV5/gzBzqMdieOV/OqqUCKVeXbsvEt+ATwrkf2Ga9WNWEee1w/EXR3NeaCcYAgxM
	 aultchiRg85iBivAgYDChYeRb+6xqIMx7k0L5lVOQ37KLDdW+GHF0+JZmC0qOgrXkX5lH
	 W2VUlmgSVYqMNyeL+CKk3X2ow2Ie5OgtxV+JJw4akR6gfN87aW50U8v9fxuA2KpuvQQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177793;
	bh=0PSpHOa2tqH9KQ4sv7QtFgWpdM5jFMb/WSqKNLRlO90=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Z1fu3y+YZrDyMam8qoY0odyfd/bdEcMUW+q+yBjBHeoNLoG1m1c4QbrMzAFnDLMw
	 Rhkm0/Q9YAbtSZ8sMWn9rbu+1ZCiUCWMnIJRj5tmUEoFGdRjM9r93U5EqitU4W5jAy
	 Gxfe5w7DBD4bkbWbq9OQ6prRaiPSBXTo1G4KAraKd0QTRivYWDMR7v0tsbaVJHCXqp
	 gwDwmhVFcxSFP/qBWeaxqiwok1keQ9AFCssKNlp5diQ3wh15POkwm9rmHLvG/MfcZ4
	 2RPRAYpglhdyXy9BRMyzCKPkUiRWWnEZsPmU4rSEADU81tijT6NO2vpD5vxLKen1xS
	 kkYF0gMJrt5tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBC6740560;
	Wed, 28 Oct 2026 08:56:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5936E4BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56BFB60665
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HiOFcM2crRDW for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54221605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177788;
 b=O/r1X85rK7ZHqotrfPbRApLo8rTDRzinm9Vfdyd8qcpGfImVJwaw3+ueH6S8w86LuyUt
 M+phVZcKmtF08ygYhb+fcHJ569WNXy53oKIQStrboYSpPMX1ZDadJT3kGNfcOdOl2opFm
 2AmDsN7kFyjL9/8MUKkGsdRH6R7IvrPOxDNz/Jp+PEjuqhhVBwqlUviznm+5Uhrfsz+sL
 w7m42CR/avM+3Z+wzlwAgaaGC0jE4R+3MpU/WtzRBsLTt7NGzRG/+v0ZL7/0R6hQvSxgx
 lT9zU2AKluTWDiNhveBwPQweoej8YRmWs4GAxKDyR47UJJBqkUMD1PVAU7Onmt/Nb1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0PSpHOa2tqH9KQ4sv7QtFgWpdM5jFMb/WSqKNLRlO90=;
 b=BMmemr9HqQ78a7BzPrUsmkvfWewJh6y9GULlKToC1b19URFFF9WTfEtd0q8SJKB8Gmut
 9wYC/1wCqdThK7KtXOxTuV9nZVDGxPdExrWOOc2WaKkhJpWjy/Z+GHrvkSQQnSIX6dTX/
 7RnwVFyte4UMVQ4izy/TvY4TBOpY17IrWlocjcB3LRgQDPpYlx9sbS4yLuW9+KGthKxfD
 EBL+IM16x5rGMssnMCaBY32cQWrmkx3rtxF/4gEmYf/TobjEcR+mfrO6O8Fhn6qprpIp2
 4xw+lNjPRcAzRQC4XMbfthCCECq5SFO+Fg5Vn5YLzorAU+iiGKqs1CPrBNT9eYealHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=g2lUFmNM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=g2lUFmNM
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54221605EC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:24 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b1ec41d8e9so881857a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177783; cv=none;
 d=google.com; s=arc-20260327;
 b=MSJDDIQwAcUrsXrlPTBMO1mzErtm9i8A7BhJ8DNBhxiV/vEUInHfwS83BpmnouK50X
 rm6KlK9suwVzoTMiEcwUcJAapRM3R2QQ8N7VdG9zU0+wpLofQQFK+E2NE5BxvKTT4Ads
 szD9YyQHsuylRRq9MdCHM3Es0CoB1ATO7NtYvrFvRoU7Eu/Mol9mfMDf57Wr3gA7AZnl
 I1sj3dRPX9Ogt5zyRz7U6L9mDm5Z4cyBRbjQKsrkRMlgEnz78O+jzRP/XmlCrqzUa80U
 eZsH1kzjuYshBzzHgFu2x+VVdV5/ki77vklKwcQ+NAcpH83M3nTkrrh4TQ/IbCzEqdft
 Tmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0PSpHOa2tqH9KQ4sv7QtFgWpdM5jFMb/WSqKNLRlO90=;
 fh=yhLA9gYl/z4mG+mLYhOIC29Y6MKSvdCklGQZ8farGQo=;
 b=MYVrONkEANdfm+2AjFLl12ianWn+B44czXUCz+LwO4nZR34tHT2Rgdv8Qn6kzO1Kji
 Q/p3JCSGz6ltIfOd76aQ176gALmk9OB9t/obZP3ObXxirDN//gi49PsqIiatqPkmMi+U
 sey44Qe1E4dvNpROZdnapAPsP4ekTG7YmpNGkS07uv5d3ZQQ+oxR5c3SexJBD8EMt/xZ
 YaIkh7YoEzys6bs6HcbTwd31+Wmj6njaqSFn5bwwvg7Q7HW7NhZh38vVl6jkMnc69986
 NcihhyrZomlIUq3XfDhBwbl+HTEypJMrn1NF2Hm5bevQmE7Y3NYLJxt67YVknGZiTJuu
 Z2Cw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177783; x=1793782583;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0PSpHOa2tqH9KQ4sv7QtFgWpdM5jFMb/WSqKNLRlO90=;
 b=g2lUFmNMwhNvBui2IyqC6+EzyFCdYAxsY9JfCkKVWqQtfyeQEAZVbU4Y1dZUmGK5wy
 eSVl4pWfdjNrxKMPYDvdMl4GQTUh4mK7u0gDejA4s4ouT7xKrIPu31O5RizQAOS8buDn
 kBKTFpNE+35rOCNz3MAM3bc6vvQj4Mzm4JtE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177783; x=1793782583;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0PSpHOa2tqH9KQ4sv7QtFgWpdM5jFMb/WSqKNLRlO90=;
 b=jaWnl7wM5TqaMYCJU3D6wyP4vFmBe0iAeYSo4zaKyBsDrSb/tXOGa7jiXPKlJHu1lX
 j0qDCNoS+l6Uco+UyUlXtqm04kINyMqxd/CqdwzJC+zpbRuYvAOrDiz6d004BfUhnGfl
 i8oUvXDbLm7LrD3+bpqVoRAD7Oi/C1sJ4dENzb18vc5DLJGUswBRLReGOrHsLWwnUX2W
 473LuUgFTDTjfJZXO65PJmTRG1fALG/k9NBE6+iyTJ1P107UdlAccxS9C7CCqskGS6HI
 zFT3cVtJ048o+1Z2lFPGBBnmfCydc2+b57HE/r4VlX0aI6L1seUowGCA+dfbWWq05Ugv
 tKpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9+WkerAgbgD/7god64KZ0+ek4sDRuuaEHqsXn/4XCXmzY/pFwoFTe9+HqJZ5lFkcjZHmnPhE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLRGJOGXuhs9W0OdfmOdIg6CDohZlQ2Uxclo7NdbTtk4yo3J39Q
 Hh8cuIqaT6r80P7Z+ZAcX+xYfx8o6frvc0aE60V70KqjlsAWZpJGS8neOhhWFZddPJAJqElsQCd
 YVl9EtYM8YsibgHRmqE34GHQKBV07vMIhJghf9AZv
X-Gm-Gg: AYBFou2HXBQRTJsufzl7aDuPILPIxG0nl0iXXrQuYz6/TROVz3JDdsP57T9bunGVtpF
 GmptkYr3LRm4vkhW4E2dJCrGVhslMd89UC8FI30LfwDogKr7pLKDTjGv8XF2i8mG9RfANILy5Z4
 Hjm9sW9CtMryhIGtng7yQJiEMkVMUpNxENKQDyRsLeFlT3XFkET8JofY87Dksdfgk3sKjuZmelY
 Q+paxw5MV0hQ+ujTV8fYOLyHBO6ZTj+TQIcoLBWombsvAE5wvfJX3sJboJQYY3A8/zZ5JKjOrVK
 oYLLnnd2n4iDWyHeAGmg0NgZZHD29ONfBVSJAx5xn4NQinTRb9jv8REoIWQlODIkM677vdX21oE
 Na7YqexZMxM8AJQ4kQcnpFPreG5SfNzkQG0I=
X-Received: by 2002:a05:6402:234f:b0:6b1:c774:58c0 with SMTP id
 4fb4d7f45d1cf-6b49cc0be68mr1028595a12.31.1793177783024; Wed, 28 Oct 2026
 01:56:23 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:56:21 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:37 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5a883249-dcd6-4cc0-a1e5-868e2384bf8e@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <5a883249-dcd6-4cc0-a1e5-868e2384bf8e@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 01:56:21 -0700
X-Gm-Features: AclHuK9bAHRRT4pyxTTMPKiI6wwuGNYb47FizNEDGecNwRCKjvowutoR2iL4mVU
Message-ID: <CAFLszTixqB66nz9abQ+KfJkGO41ALkGbtCd9Bp5UB86ZamcQAA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] treewide: Use is_power_of_2() from linux/log2.h
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> treewide: Use is_power_of_2() from linux/log2.h
>
> The btrfs code and the bcm2835_sdhost driver each define their own
> is_power_of_2(), which clashes with the one in linux/log2.h once a
> header they include brings that in, as include/blk.h does after the next
> patch. Drop both and use the common one.
>
> The btrfs copy is the same as the common one. The bcm2835_sdhost copy
> takes a u64 and also takes 0 as a power of two; its only caller checks
> the block size of a data transfer, which the MMC core never sets to 0,
> and the Linux driver it comes from makes the same check with the common
> is_power_of_2().
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  drivers/mmc/bcm2835_sdhost.c | 6 +-----
>  fs/btrfs/compat.h            | 6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
