Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE63EEC2B8
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 01:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF40783981;
	Tue, 24 Feb 2026 02:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpEwqmx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA748063E; Tue, 24 Feb 2026 02:06:57 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064B183981
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 02:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-385d9fb297dso53605741fa.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 17:06:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771895213; cv=none;
 d=google.com; s=arc-20240605;
 b=FdQW0MEa2zjKm74NBtwLSdUGlFyj0KOuBnUbfgkeO3ZL9CU1zGNimADymCG03ISLSD
 V9WZKLLgp1HJOJ4cX40N52kuPZlVLAx5qbv9WOlklCCc2XkXQrSkMFy+EMBqIFiL4PEt
 gnw/aGLu0E+uDUdfVGTlapnhVrUD3bdj7JVgx9efCThuCxAqJmdjadeFn+raPJtq9YjW
 yK0AVt8raqbEtENp7XBEmjvTkRbPeWr8pXlwi+iwkAMmnADTOzjQ2/1TVFIcznN52o4W
 MKqys8ZJTd8PvP0A7m/z74UinX9tQf5EFvJc6Vwih+X4jPBzLOV6ZQ8RjD9idxqBRq7G
 cjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3c3uBeR0TYFrf9uQYzxpZNCvIXjrZiOFOwLtDZ4w1VY=;
 fh=7Uy8pHi96aZ9pVajzygr4tGhvRxHf5/2sAgtlx8KFsA=;
 b=fJdhDKfNJwV3TanVpzLZhF3rym5LRdC81wCxrjfgC2YjwNXxuO2YZOEiRaUeXK83eZ
 F4SDw7whfzZirYSjJtsvWy13u7sq3+3Bqw2yXqHsK7nj9S8OAzV5CCFnA6fTTsviM+Bh
 Ww6S91P2HO0yuhIWYpj8rwFtf0cvzut0ijkV7RK6Jg+9hmdkSE1Btx07gN98G1fsjcGW
 0N1ySz9wfCUuq+7YeIysOmipeFDcbhgk8LQ8S07OPMvdgVQUT3eXYZTEmJJpqwoEhDFl
 zIkoBK04r0FmX7ZCATcVKjGumJsRwTe4CI7oFiJqj9gINGOxuwJpX/wOAJN78YdCMn9T
 xTEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771895213; x=1772500013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3c3uBeR0TYFrf9uQYzxpZNCvIXjrZiOFOwLtDZ4w1VY=;
 b=kpEwqmx7LUxy4DVMo3Mkfcykh01DRmdXN4lc2RWmcfCv96Eeisb73Vu61k5/KonX69
 rQMNyEQTgS0wxo+01iJMkbwNdyESoCBPcXP8aLW8qXeVXRtaSNDrL2xhEYqWaxWD6Mct
 ftLdeoX+SdRuszvIJj1+O4UieEEeA1VhpbpO+tqOQ0aoIlS9lLtwS1GC2tCpUFllCkWv
 jQDp5hcGhVfMySUQlt15eDk4ENNkDLQ/6VaPYzMcDKnpaUDEOv/tB2cy84S3/DYg8eOZ
 PuavLZLRlN+w8rFswG6QMl4bQHkXXNG6ru+ev3Zs5ohUogC/cMUZ4UcEwdqUcLxgbJNf
 kquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771895213; x=1772500013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3c3uBeR0TYFrf9uQYzxpZNCvIXjrZiOFOwLtDZ4w1VY=;
 b=FlieteYCTeyx7/G8pwM/uakpM1nYndNAfa6rgL3tn9+hn1FjEc29jxv5bXmzqRn9sQ
 KpXpoDJAjBe6FZcP8l1BW1JeKP4yfsovZUpxj86DLS+LEBxvWWwTcdxN//XZ/uDnYQdv
 PTJtTvH5bUf7YRo5XV10EIfjgO7d1jwoA+eD5KDecktadeqNIyiSt37J1LQONT07dJkO
 T6V8oNwHgq9eg8mssNa++oj00L0a48H5vKdhS6Bnv8yl1lpjO7N56C572wPmEAlbkXTC
 tSH3TncHol2Jk7dFuHG12ic28hjjLVefTA3p119wnGUr5gDgBsGJEVPsh0C9U2MyyZOn
 hT3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvPeMbaSAiSiq52mz57F20rTE7CrRMYFAEPMg0BJahNdBrA1+f94NXWiLUbMNcLZijDdMCfiM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn9CFlyfvx3yF/Gap20mSTfCGcOQO/tEYKw0076Uie6ilEIm5Q
 ALZAnmczPdckexRenF4r1FDnqnor88tfy2+5XPjzL2xec3mOGWUfXHuvgsWXcIL7yCkmj132f/1
 GJvr/NV6z3pck7GR39CsIAhlv9FLBEhA=
X-Gm-Gg: ATEYQzy2gvyf7uLkglQlvXeDtGLBq7q+1HZ1FXVMlovpblPM3YOWbRHqb0lCNQotSDW
 0IxsjiCFPFNvE4ovIHIhZ5KqRRp7XkSm25KcJtiVyHbaG47za/heQqK7ivwRdJOhpvRoFWPRl+i
 DiC8kUFd4EEKWZdYcP2mA/6t6rLCJ+NskKF4WePeG6Y4NkRDTfvEkwsx7ebklmvrpmlOw4tDZyq
 066g7T7Ik+HqneO3h4BvCzZwXszz/heSDeuysaA3QbxT4JCJygmCmbY7/2sVKNNV+l8QZ/XDA03
 qCIWioZe35jEgs7+QE7OZ3XoNZsj9R0fUVfRQQ==
X-Received: by 2002:a2e:a813:0:b0:385:f0ce:e222 with SMTP id
 38308e7fff4ca-389a5e9ad2cmr28486131fa.41.1771895212800; Mon, 23 Feb 2026
 17:06:52 -0800 (PST)
MIME-Version: 1.0
References: <CGME20260223103749epcas1p2d9af2576eb9704b70a8572f7ccb8080f@epcas1p2.samsung.com>
 <2d9001dca4b0$74a82c10$5df88430$@samsung.com>
 <20260223184541.GD3233182@bill-the-cat>
In-Reply-To: <20260223184541.GD3233182@bill-the-cat>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 24 Feb 2026 10:06:40 +0900
X-Gm-Features: AaiRm52LT70rhUJU9cEHf_Z3d7nPST1xapR8Ofi8K5qiZ3SrmEi7GsTT7nHtp8Y
Message-ID: <CALrBrZ0qZMRG=vfw07POB3WgsMJSdXGvp=4sLy7dYAprJ=nitQ@mail.gmail.com>
Subject: Re: please pull u-boot-samsung master
To: Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Dear Charkraborty,

2026=EB=85=84 2=EC=9B=94 24=EC=9D=BC (=ED=99=94) 03:55, Tom Rini <trini@kon=
sulko.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Mon, Feb 23, 2026 at 07:37:49PM +0900, Minkyu Kang wrote:
>
> > Dear Tom,
> >
> > The following changes since commit
> eed514b11d04a2f8a949521ad3bffba3ec98bd2f:
> >
> >   video: correct label for cyclic video_idle (2026-01-29 10:00:59 -0600=
)
> >
> > are available in the Git repository at:
> >
> >   https://source.denx.de/u-boot/custodians/u-boot-samsung.git master
> >
> > for you to fetch changes up to 11198fa347390eb449c2a0939f5f00cf510fe285=
:
> >
> >   doc: board: samsung: exynos-mobile: remove requirement of stub device
> tree
> > (2026-02-23 15:35:33 +0900)
> >
>
> Unfortunately the exynos-mobile does not build in CI with this PR:
> https://source.denx.de/u-boot/u-boot/-/jobs/1383183/viewer
>
> --
> Tom
>

Could you please fix this?
I think, it should define CONFIG_DEFAULT_DEVICE_TREE for exynos-mobile.

Thanks,
Minkyu Kang.

>
