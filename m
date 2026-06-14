Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB88ECD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7673E83FEE;
	Sun, 14 Jun 2026 18:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WqSRfzY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34C683FEE; Sun, 14 Jun 2026 18:20:24 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6102F83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so4584640a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781454022; cv=none;
 d=google.com; s=arc-20240605;
 b=S3Mz5c1v2xposaZy1EnThxUjkNpHXyV6briKcwdZxWgpPQUJphT0qRKOQupMgfL3lp
 B3zwC/WtU/zkY5pbobM3v9zdkUsrOu315XmSzfdz3ejJ/tM+nY0Sd7cP85oU1EVfOIim
 xLs7D5y8Rsh0PBgrJQXcVr3gZl5BYE3ApR6T0og5fWjG3yVC2XD2+SOj3umthmhvuaHa
 HMoSyOFEKHNg7IUpwCEqfXmoDnS1R+yrJ4iYQ4ntYaXVbw7DZZTv6fOZrAdyaZNR60/B
 lLaAjQtkrXd2zez7LjlTqY+8+wenKfRAAXst/K4npuMm1SQD8XvN3al9ow+hwnYgWUkc
 vz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cx5dqn0DJH0nrBK6GXXbVl7rX/CuU1c96z6iNTofqZM=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=cDZhgCyU5A9F0tG9xf2aBuu0evxxWQ5bQiGjD6p0LMZt6Mwizp5Gype11O6uo7x2lA
 c5q54FJrbifgiE6eP9me1HhUz6rXOSp8stoOLXPNQo1SsdzNNyoJLJUrXwzWOd/qh3Zq
 +dgnXT9FdVKaSxJSucFSVhlfiXlMhaqI4Po0aMpcvFumxluA2n7+9OfYWSNNTmTFmhCU
 T7EzPu5hFeALDuWeO+oUjKr79fYAC0KAXeFvbIc6a0epa5rx/k8EjCwqr4/+HpESqgBf
 BOJ1TnAZrFLb3HjctcXmfnXGYH0VP+KFsUj4LgRZk3f92euo2EaAtu4gEfMYGJv1RhPe
 Cx3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781454022; x=1782058822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cx5dqn0DJH0nrBK6GXXbVl7rX/CuU1c96z6iNTofqZM=;
 b=WqSRfzY92sZxBzWcDXaNO3xUGtuts3N9FqL7PgLvv3YLXh8jxtWnxg7v2u/4oSnPB4
 ZrfbhBigcKtmQ5xi9NpOiebZbK2mbxQY6I4HWQZ4Wak/tbe0MpcJ3atRCf/zLZZTPfDq
 XOFD6vbxa4McwaCsEhyaiIP+qIJmtBcr1kPJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781454022; x=1782058822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cx5dqn0DJH0nrBK6GXXbVl7rX/CuU1c96z6iNTofqZM=;
 b=K9UcbCWSMOcVJA3Vn3dBwQ+veFy5k83zZQO24UrOvlAxlZOS2ByT0+1590c3K3ZmiS
 nJm8N/2KgRdsDQpOMPJurySxDWsX/C+EOtlOrzFqWE9Nqw7S4xgMJtjR9sqH+63arD8P
 GTqJQQNvJAIDl+LHFSiIm5eEU9jSxLCZ9q0j5UL3WsoywOc/STc63bKYNEv0Dqrl8AEj
 ng/YQ7zLPCtbvJpa1TjQideIZJYhahQOuiNfIsCtUU92yKjSY4ZUyQoNB50sFbBuVF8G
 SGKkTqUxObiwvopDprgtIj+IPSypfAshnR9p43zDB5K4bDq8tsGxAGnqBtw7vHhksdc2
 jhiw==
X-Gm-Message-State: AOJu0Yydc63L7ADevqPAAILBslLO2onB7TmOVuw0cmL+v7jfCHZqzEee
 2UASovAMdAa9d8G553fXm8z4htV+tZ+TBEAzP/AKOhw8b26lfh5YCo2iWktoCdOCoRdzaI+0JI7
 dqjZADAO9ZYYinLc3ixRrLa1LMYugXMWsptpKXXZ1
X-Gm-Gg: Acq92OGXcEWE4mV5CDNEZjHci1cvuxi+LdhvV+bIcx0vGdzstbaEh9vYY2F03SyZsdn
 Z1gIYdnaZwQQZGfFO2ZJifqcjVWNNqFgbQoxdaXg6sMpcIeI25EQxhaVtQ4FMAbpKu/lZomyraD
 N94q9pJfcY8gg0NCMAMhXvUqS7gxG1C4ecV2aJrBup1FdxJJ3AeE3M0SaF0mSVKWfqdj/nQy8UI
 hS69GHgC5FubK6Rq3jgIXt8ZpP2NYCiS1g8cpj5Gk9afH6FuKg7m9ooifkuxUPG38kpbyHUTzGk
 /iZMSA==
X-Received: by 2002:a05:6402:3607:b0:691:9600:e8ba with SMTP id
 4fb4d7f45d1cf-693778c3f06mr4517231a12.1.1781454021900; Sun, 14 Jun 2026
 09:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-8-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-8-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:20:10 -0600
X-Gm-Features: AVVi8Cdu0_Et6a80n5YTCg0QS8TbU3hJkXFWHqMJ-DEI342J5ZJLaKEDBNrFt-Y
Message-ID: <CAFLszTiPnfy_=t3p6vAnteLdsC3U8xiSONU2gP6Rtb+fQPntUw@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] binman: Add DTBH support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, 
 yan wang <yan.wang@softathome.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Sam,

On 2026-06-10T01:27:41, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: Add DTBH support
>
> DTBH, used by Samsung S-BOOT bootloaders, is similar to QCDT. That is,
> it's a multi-record container that carries vendor-specific magic values
> to assist the previous bootloader in picking the appropriate FDT for the
> booting device.
>
> dtbTool-exynos was used as a reference for this implementation.
>
> Link: https://github.com/dsankouski/dtbtool-exynos
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py                 |  23 +++++
>  tools/binman/etype/dtbh.py                         | 108 +++++++++++++++++++++
>  tools/binman/ftest.py                              | 106 ++++++++++++++++++++
>  tools/binman/test/dtbh.dts                         |  22 +++++
>  tools/binman/test/dtbh_bad_model_info.dts          |  20 ++++
>  tools/binman/test/dtbh_invalid_pagesize.dts        |  12 +++
>  tools/binman/test/dtbh_missing_model_info.dts      |  16 +++
>  tools/binman/test/dtbh_missing_payload.dts         |  15 +++
>  tools/binman/test/dtbh_missing_subnodes.dts        |  10 ++
>  tools/binman/test/dtbh_multi.dts                   |  29 ++++++
>  tools/binman/test/dtbh_multiple_dtbs.dts           |  22 +++++
>  tools/binman/test/dtbh_page_size_from_abootimg.dts |  30 ++++++
>  tools/binman/test/dtbh_special_subnodes.dts        |  11 +++
>  13 files changed, 424 insertions(+)

> diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> @@ -0,0 +1,108 @@
> +# Fixed per-record "space delimiter" used by dtbTool-exynos.
> +# It's unclear what the 0x20 magic actually means, if anything.
> +DTBH_RECORD_SPACE = 0x20

Did you try probing a real S-BOOT to see if it cares? If it really is
ignored, please say so explicitly ('S-BOOT appears to ignore this
field; dtbTool-exynos emits 0x20 so we do too').

> diff --git a/tools/binman/etype/dtbh.py b/tools/binman/etype/dtbh.py
> @@ -0,0 +1,108 @@
> +DTBH_MAGIC = b'DTBH'
> +DTBH_VERSION = 2

Just to check, are there older DTBH versions in the wild we might need
to support, or is v2 the only thing S-BOOT will accept? A one-line
comment would help future readers.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
