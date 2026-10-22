Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE5606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ousqGG/z;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=S8G8sX3n
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8346D8123E;
	Thu, 22 Oct 2026 08:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vepgvQB-DmmR; Thu, 22 Oct 2026 08:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6B4581253
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657569;
	b=hVNZ1kYtM+FM6mwtQoSmtT555D6w1x9NmNDS0Y15pXowsZViulMgZEnepezL+2bgqww0
	 BVrxTuKlLkyQwpF4IB4nKcwgOWOeadBUn9P1I/e+8rSUvSRhkxHnZpykOj8DX2Umep2l0
	 +5T40XxDkaRRwWqpqGjp6b2Jm24GUxXKdbeCcxdibxHPAqUuaySuFFuKOnrTSjcwJW67e
	 dElhR2ziNGIp8oJi/5NlAko6Gm/IHho0c0mEsLdXAwle5+Vi3G87HnUpYL9Jeu3xO8Jnk
	 Oy9g6J8mlHC6IRJiOOPbeFYsYWge47PoBlY5aAlKZjlzLO5tghgKxJTy0t9R9z1nKDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sUd8JRF8UkjFKViUrw3zecZMRMuDbx7ZpSEpeRhDhUo=;
	b=khvtIDgAGeQwsYnRBIrvpxp3WFtt7NNmRy5+fk/xWyOtxgkfcuqRYiG2jXM8we4rNWM5
	 ezF0cSfjUGCtYqPQEceCCcPYIIAYwKVPoFr1Ku1bfBUm3En5oKFV8+u/J2ESgeac3oiOM
	 ptPQIX7nCvdDYQuwQJdR2qcMRSOFiIjTWunl71OtTrItStnzSkw1K6Q8srT+w5tkJaCOP
	 v2ZK01oj8bq3PGKSF3KHMmXqvZtDfXwQu89r/Nxu0O7SThLXnjTL+y2qHH1i5tORR7g29
	 SdCqirFo4Qt9yvKainO62kL9QnfM/Ut8R9E6E6uTy5F/fDB/8lJuvTKOnRN6YoGJAwg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=S8G8sX3n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657569;
	bh=sUd8JRF8UkjFKViUrw3zecZMRMuDbx7ZpSEpeRhDhUo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ousqGG/z/GlyCvjA2Mrf1MUudDewg0WPxNenavmXCcP1aQhuFdd4cEqMXDRKYXD7i
	 ZgRD0lZO113FYspnx8NTUMsMRtUwSJ7LYOZDBEVaMvRwFLuEtwwK+pDBXBpWBhU4VP
	 t9QWyORW/HgCLHYtn07b1r17TG/APgNF+r4yL4gJnAZO5zSMqjO9Y6e1zqf25DDNHV
	 GoomEPKfsThGz7b7a00JUFBIPtPh+repmLlnyi/pYPgcAwBQRa9K6NntLKDraEkuVd
	 rOEqqEVBCpSogka97xAKY18ldGjFVJPZkllX/EMsJWbEVxPh2FsgWwrQ8qb/75NuCY
	 gVP2ApG17gxxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6B4581253;
	Thu, 22 Oct 2026 08:26:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 251A3371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16BA481271
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miy6bR8IWVxo for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 672718123E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657567;
 b=UBt7geVrzqVzDjbg58x1ZD/u9rsF7tYhN0rD9ZSD7Bo0XF29NBmUAGD+AXam5ZxrDa06
 T6ypbQiriuIj/wV58XVUplm9trCIodyit590Fjsb3SHaOZg1f3YM434QuPY4wsJGW+bFG
 VWM87+f/MM74cbe6hGtiUuV3Xrh3x2fo70SC9pIt4VG5tJThtddR1OaAzeTE6bls9QVF9
 3tsA1C1bSV0346rJDeIqyj6BaQSxZLOKvluY0jkKXg9FyXiiIFeOAfDGwfYapNalw3mdm
 lWgAbpQCvqWYZH/LQGMxbuvGjups+AvJRWynePx8eV2GYc66eA/gs/HI2nTp9leb2Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657567;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=sUd8JRF8UkjFKViUrw3zecZMRMuDbx7ZpSEpeRhDhUo=;
 b=osSrH+MvOjnWJ0jzOT268sxYcWlqXByWrgWduOLhvQ1qgD0UDZA1QgtmcdsSFRmPPI7F
 aJ+jaDHsLJmvgnI4mVhpQbKlVlee0/mob08lHEBkyfHi50lAmLU8IlKnH9YLp3GzkBboh
 /iU1CRr94wOo3pT2RYgDEeIe3p86y/cVkkzZIUnbr2LxbZyedZMeLxl55P/JamGQLb3Kr
 Hc/KDfrZoKkuanxX1NEjTPyKr0FlAirErIvGEBaeah8KqJSzaNinQ3sLxsYD7X+/ZprwE
 U2mywo3mgHelj7M+VYZBAyALDwUc2BgjVW2x/Bqh2+gQIXmt5OysC41HYEyV+zBkN8w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=S8G8sX3n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=S8G8sX3n
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 672718123E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:07 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so757729a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657566; cv=none;
 d=google.com; s=arc-20260327;
 b=q3ttRrmKe3Ph/v0baIgfss9/11sxe342Pi9quqvs4lNXLoVp5VnY9rhgvpSkRwqyHT
 O5BJRn31k/mtu/hLg5G/C7OoVPE11J3J6HEGYWLjQr4KkoYdHJEMFHAb9kp/Wt2UkTgM
 akMgO9/K7caigtJUVmP8IP2UW+xmknPulaSxWJ6oZg9KWcA9NMmgFD7fFeEXTNptKrvn
 Yxj3RdW6+nUMNbLGnrmhwxEV15akFruURha2Noao9RgwhSM4hlLC/xp0GbFZvIDqbTHx
 jqSfLy4uU0WHiUmNn2rDEg1fjvip0eI56FyZIic2Ue0MDvs1cKEXIaWo+u0PVsAqSogq
 6X5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=sUd8JRF8UkjFKViUrw3zecZMRMuDbx7ZpSEpeRhDhUo=;
 fh=2Sh9Rti/fbHk34s6A77qILnRnqWTfBL0g/VJbEqq3Yc=;
 b=X0WyLzBgVWsDHL81kNU+iQ/YNAvGYLwpQrk1yXwlVn0YxwEIIgDXIgshog5QUqB0NH
 Prvt6IQH9eH2O3qtDCPBbb3ZTF6tAqAhbCK5mNkXl+YgdwxXRT1YnmaRPoh5xe1wdPXs
 kFALZmSKUQrvgvh2qV0NfDFx5x0TkOZIg+cY+yQjI5vNhQ2jV6RcdRRXH3S2hUIZTU6/
 Iw/JV8DGWlSVaQPIgAqEEoISrjAe0chXMMDHmC5TjQn/leQEgBUe7///zGR0JZ7WShnV
 slVFilVFi//7/vQ+ZlkeVJzpTDa0Nbk0w31tFZ+toxcgxh6iTINoGi0LWYxV+WYtW0ek
 Artg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657566; x=1793262366;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sUd8JRF8UkjFKViUrw3zecZMRMuDbx7ZpSEpeRhDhUo=;
 b=S8G8sX3neJhcDmDjE66W6IE5HMpxbvK4J09jyMNoeQP8ajU/brkTWoYboBj065dXIc
 XutBNHP7Ppq5n1Hm2G64I9S26LWnBCoIcao5VIkJs7JTElBUlnBrAAHPDrVNaERKBx+x
 KWwDijMvdf8sACoKQ+qnPak4QFr50icqpY6ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657566; x=1793262366;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sUd8JRF8UkjFKViUrw3zecZMRMuDbx7ZpSEpeRhDhUo=;
 b=Y2I8GhqbK3cti5K13yxcqCCtG5bqajG6AUvN4qgeHFeFlEAUXOOQMfk1jA/y1SYFUJ
 u5gsVWiaRcIbAKfqMX5wbBIbAVIjxILRSUQ6lDQNmwqmWBsP0OVA6WfCijL/oRwzCm5r
 AQ+0y00aAq3CPze0kUoBSzrrVTmoU0qeon3PRJbmnxX4OIZvASyJCkhaF2G5nTBqJNsY
 Leh3zI4cD38A31hWxDIjNa6CYvk8M7rfcAWNS6zWfwe87vT3NXnTOPmJ3Jb+ZWC+NX+y
 xyfltomQ7Xb9bcRxpQULt4S7+G08Vbb/vYdL81WP9/iT8pT8z9mM5xwr396UAd3GaXel
 1NZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXTJyyxgzlSXAnvSmK6uHhcxtWzqWP0/SvD4WsbdaiXSfcLLyT2b8NCCKcnyzmooBGqplsZMI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQ0mmQvoZi39QQdsEEI1tH3kRVdmUY6eokGSLX9gYmqWDeLw6J
 VpgZXGwbwV2uXOUv0+AYbt/oRP3/1MnE3Ef5llEmMPPBKOWSIuuXwnrx3QBkPlQnaGSuttB6P+g
 Imk5ZC4etqRkngZkmpE1exDKM42i3ZVaws5+nw5Ca
X-Gm-Gg: AYBFou2KCltW+T89oc50yMFbNhk1IVJ++DTS1sXQoYXOn5a5Oau69mQ9UcLWqzPtogC
 xeD2Veesf7EDmCNUYwosuJiOVTu+bPj2YvxN/XqwQThmUITFhXnTcSZshv3dYQEBwiDVJfjr9Kz
 s1FaPsURUIC9Za8npgUK/JNGlDCC0IgJIbHXgWh68ZDrZiGQZ06vHcCKDWVxjmqv3UeYXxfrxip
 ZTxB0zRTsBuoomd5/upkUvv9pVOSwLfP7aOlJu0rpCFvqNUcozfuh4HkwF3pnzaxAFFf3YiG5aN
 +omI2n58jDpbJjbzVP+/YK7hxgzAE/GltPosK75EVPCQwcsikzQnDPLzUBc1UibrCfDalVlLO42
 mYOKGbL+z4ppGYcwnvKslSFTYgBvSN9hTlPo=
X-Received: by 2002:a17:90b:57e8:b0:3a4:6f38:f2a2 with SMTP id
 98e67ed59e1d1-3ad86d50c92mr4048433a91.25.1792657566382; Thu, 22 Oct 2026
 01:26:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:26:02 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 14:09:07 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-5-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-5-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:26:02 -0700
X-Gm-Features: AclHuK-iCr-7c3tGd5uaRzN5Rdu6Bd8KzYyNj0sGNTtEYbU3l6TYCHohuzuIzNk
Message-ID: <CAFLszTjD+8B0Mq6ktOrKx94m51n-=R3L0icxuL6qV2SUkvMorA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] test/py: android: Add create_gpt_image() for
 image creation
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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

Hi Mattijs,

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: android: Add create_gpt_image() for image creation
>
> There is quite some code duplication between the image creation for
> mmc7.img and mmc8.img. If we want to add more images, this will be even
> more duplication.
>
> Add a common function, create_gpt_image() which removes all the code
> duplication.
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
>
>  test/py/tests/test_android/android_image.py | 78 +++++++----------------------
>  1 file changed, 19 insertions(+), 59 deletions(-)

> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
> @@ -7,13 +7,12 @@ import os
> -def setup_android_image(ubman):
> +Partition = collections.namedtuple('part', 'start,size,name')
> +
> +def create_gpt_image(ubman, mmc_dev, required_parts, images):
>      """Create a 20MB disk image with Android partitions"""
> -    Partition = collections.namedtuple('part', 'start,size,name')
>      parts = {}
>      disk_data = None

This is now a general helper that callers have to fill in, but the
format of 'required_parts' (a list of dicts with 'num', 'label' and
'size', where size is either a sector count or 'NM') and 'images'
(tuples of partition number, file name and hex data) is only visible
from reading the body. Please can you add an Args: section to the
docstring describing each parameter, as set_part_data() has earlier in
the series? Since the name now says GPT, the docstring could also say
which mmc image it writes rather than 'Android partitions'.

Also, 'disk_data = None' is now redundant since the variable is only
assigned once, further down. Moving Partition to module level seems
unnecessary too, since only this function uses it.

> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
> @@ -69,55 +56,28 @@ def setup_android_image(ubman):
> +def setup_android_image(ubman):
> +    mmc_dev = 7

This drops the docstring from setup_android_image(), so pylint
complains at this patch. The next patch adds it back, but it would be
better to keep it here so that each patch is clean on its own.

Regards,
Simon
