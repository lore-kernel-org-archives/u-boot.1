Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB89BCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 15:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2061D846A3;
	Fri, 29 May 2026 17:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YdQqMlLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD032846E6; Fri, 29 May 2026 17:54:01 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730BC846A3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 17:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-6c3154fa47fso359731137.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 08:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780070038; cv=none;
 d=google.com; s=arc-20240605;
 b=MV5LlSC4q4tOuQ5eSAYzL5hKPgqyVQJc/6GrWoLC7xeWyqKztJMYFrExB6leInFdQT
 +4ev3FWTyQ6LRP/I03tRvrgVBUJWZjRHoRm07P9l+X8vmjzDZrkHzc8Rlg1myPYG0/yR
 kqBzX2VHBpfZzdvy/xFXY6rph0dnQfyh/US55Ksx48/eU/ATAMo1l6/naLI5KrbVqJpI
 DUrT/NMBdwQAyS+mejb4M8O5cBHMVHL5ebazJaW45j2MQdQAwSbv+bKKFLLCwTCt9PXl
 Iet1kSq3edVxly/7yL0eT4avCT6xYaw5WDp5hCqm3NeySa6e+Cqu2BktHvyBn6+8rPmH
 cMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gJ1Z0I9kUhRIaEKJa/af4aulXmgJH5DcxCfruz8q+jM=;
 fh=3CzCl3GXx9DzDRbRx750MfxlkMP+es2XYHI9i/+QiTA=;
 b=FlJFzwnRWe7mCteluydzI8KOdBVC8vdYw4rED2aYFGa/i1ZqKNveLakvJ+aa9/sD5z
 MgJiVGi/x0/D8WgHuwNixMeL44NhS6OEZI+A56I9uMvgFUdFIMmWaj132Iy/BVQpMTfI
 Gq58S1lKuLn/W7kAuXuiyG2jv63MOVR2HQewEjvbrw51Jtj9JEMCaaZ2gOcHqKffgcBs
 iLxu+l7E9c/3xxpuwKC+yspf2HtcTO2B/9UYFumV73p4+S/7sDiPKYPRS7+tqXQCvvMR
 rFvDmBXd+qspzIanK+8dNrHGoAmebSsLpvgr8PwVumlh4uGpviWYYQ5W8BYkHXBiM3jd
 aKSw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780070038; x=1780674838; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJ1Z0I9kUhRIaEKJa/af4aulXmgJH5DcxCfruz8q+jM=;
 b=YdQqMlLXYWElxxSZgCyJrmQ2+Jboh1qkvJla4NYRT16hXSiSDkltQTsIobuqmtn9Av
 uuCG0EBWCQ8jEcWlRyegItuBbi9yK0uMx2tOUw5LIQ47A8O2xf+kKMPLa0WAYSNmmTwY
 UJP08SnmPAhXa8CjSFzWV+4mb5GGOpj53nMStRxdxFYJ5Xs4Wv6F/SriaQI72/bjilXi
 UIldXdl0OxFtnOKvIHjxPXSruoPtauKVmzIsbticKp3nFreBlqmZHWenJT9kDyktdaMu
 bLqLcXJYy1F+1L3dtgdReAeQ22mHJCrA98oFwSwzOwSUQqiSn3mOAP3Sm06p3V8rGj5c
 hSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780070038; x=1780674838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gJ1Z0I9kUhRIaEKJa/af4aulXmgJH5DcxCfruz8q+jM=;
 b=O4GjBqcjBKhEHGul1oehGTMQCP0mjVg7s4wafUBjlhyJbbHrnlt/hHHVviNn41EEaM
 lukoiX97tijwBzILhPWv1KT5302oG/r0keCj8fvVBZ87DVEexBoNK8ir5oJ1jfxC9HkG
 GzYwUmw0fzInLpxfykVZHBtjVQTubpyJsk9GR5ADiW3LRQhl7Byzk2qFgXV3jXqvbKOs
 EDM32TK4BQKRfQsZ9V30LmSMuR3C1JDp5Qgc/R+UQd1UD26QKfoXg0WuuwEI9Wl81oII
 KEHG3bIabVY5w6kW+9mHWVzRbqflITA+M6/vvX3ueyoK6aBnRtfxVYprhJIqRpvlWcfZ
 RAfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+sucTDqbq2b6WIj7EO9En5D8did6I6VsaACHuQc/JXNyEvo1it8loNFvPjAXnQAjSWFE3sqc=@lists.denx.de
X-Gm-Message-State: AOJu0YztVY+5YR1o8Xo6rk+j33ZzFuPkTZ25Z06YvLMf6+qpoUtV6W6Y
 gikjaxdpIMMB8mUGRuCgfdphpjkzmfLs/xZvhEnq+NlnEPENGx5DiCiCl9d/vQryl9vMsIAVPk1
 joLi4bYyrxIh7X07S8YHNt5i3po9+zEg=
X-Gm-Gg: Acq92OGPzv7I97scoBdbO4XIRqObb3zX9YaxCCOnKY/x26p8reVhI7dV8Ao5vcMuW1Y
 PGR/jAkxGDJD0W50LGsksW9fSBMI9wu+j3Sr4wy7Qc/7ceCDQL+/K0brl1iUlgoV15MntP+CQKd
 1NELcqtiP3+wHJ61AFXWLp/+eVWH72npRIqWnQeo98+/HutvZKETDT1dnNsbAOnGyXnOk2puMJe
 mgcJDgGdDmXaR3y2n33a5ZCxw/DhRzE4bWzTiUkrgohN0SOrC1t9bwJw5swilNkAYmj7jV2yqxl
 +ckX529hbTeaWACjRQ==
X-Received: by 2002:a05:6102:e11:b0:607:a151:d63 with SMTP id
 ada2fe7eead31-6bf351e2a3cmr1745643137.7.1780070038217; Fri, 29 May 2026
 08:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-10-philippe.reynes@softathome.com>
In-Reply-To: <20260528081916.11355-10-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 29 May 2026 11:53:46 -0400
X-Gm-Features: AVHnY4KHgY5CHLjvkJ1KuB_of44h4rNhC4h1jW8xECM90bWUvXjI-YiFwrcMgt8
Message-ID: <CAMDkj5wzeTpQyx8JbXWjRV9RxDugn5wDZ1mWZD6FR=mcB62ZLg@mail.gmail.com>
Subject: Re: [PATCH v7 09/15] tools: fit_image_setup_sig: set required_keynode
 to -1
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Thu, May 28, 2026 at 4:19=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> When initializing info about a signature, set required_keynode
> to -1 instead of 0, as 0 is a valid keynode offset.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v5:
> - initial version
> v6:
> - no change
> v7:
> - change info->required_keynode > 0 to info->required_keynode >=3D 0
>   in ecdsa_verify_hash
>
>  lib/ecdsa/ecdsa-verify.c | 2 +-
>  tools/image-host.c       | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks and regards,
Raymond


> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index e58b8892b98..22279a7cc84 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -111,7 +111,7 @@ static int ecdsa_verify_hash(struct udevice *dev,
>         if (!ops || !ops->verify)
>                 return -ENODEV;
>
> -       if (info->required_keynode > 0) {
> +       if (info->required_keynode >=3D 0) {
>                 ret =3D fdt_get_key(&key, info->fdt_blob, info->required_=
keynode);
>                 if (ret < 0)
>                         return ret;
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 8b550af0dc1..f5681d6c1f9 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -198,6 +198,7 @@ static int fit_image_setup_sig(struct image_sign_info=
 *info,
>         info->checksum =3D image_get_checksum_algo(algo_name);
>         info->crypto =3D image_get_crypto_algo(algo_name);
>         info->padding =3D image_get_padding_algo(padding_name);
> +       info->required_keynode =3D -1;
>         info->require_keys =3D require_keys;
>         info->engine_id =3D engine_id;
>         if (!info->checksum || !info->crypto) {
> --
> 2.43.0
>
