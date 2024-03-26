Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FE7C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D2E8802E;
	Tue, 26 Mar 2024 23:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fxkRhvso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A9D88027; Tue, 26 Mar 2024 23:12:11 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D76787ABC
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso1015392a91.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711491127; x=1712095927; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVti379CxKkmfOu6xhBUWtrgLmsCnpIA6E7UU4KLGdo=;
 b=fxkRhvsoBxUl4CExLfhrmp3iu62FRKB9NmZKLm16j+aK9L8AzYYs487s69ZBpYjC42
 VcCpVQyk2TL+BUbq82NZePVRH0zfNRUb3URqDD5mz971gO3B7uSzWtsgikPa6w07d+s/
 jTdczIBEEpqW5MJpW+yf1o2EAXU5E5gpVCAO35isaIn1iwOjKJwPkr/zugprwQfMB+r2
 riiK1o5jwozTHUZHvcVQyr1o0c3YaIwbzG6yC4NLfYcPEF7YdHdkq1FE8mmcW3cjiMhU
 +Ch/DXIWKLwu8HGYv2swlfZqYLN2+JshpH2NvSrUDsd7e3GRK1vTzTEEQn/NnCV3O8XX
 n9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711491127; x=1712095927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVti379CxKkmfOu6xhBUWtrgLmsCnpIA6E7UU4KLGdo=;
 b=OJFtXQAVdw/KxJPQvHEI5QzjxQavrgmP9V5/12TFrq1x6Gry/93ADSjH0bLFTA3k77
 69t/N5nAZn4CEo1MkqbpWzxyX8FSN1UZzCkUmC0HFb23BF/SCpKlVyQ/NLrE2XCvF1hs
 6Q+igPyPXA0vxQgmlVm/n2uv57DRJ3Vy6flbWyYS+06JWBwwJAQlLOIKNmzNjFWE425d
 gWFl4Bmy+EksDQofp/Ryb+v+hLnz/QnqSdMAiJGvAMztaWRR/NB1MEN3VXoGHVYd5e1Z
 ed+FUVIbwXrsHYJtu7NLsXSXJlV3hD9D5arES+akcYaPN4G7u6AN3fs+41zuKC49mXWS
 xqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9CoIN+ua0OHKa7aUw+w0RRgJ9bh1Hxoa5E4LxVSubEmMDOk7mitqsBYn5bMC1ydnydOpU8bRB8D2xdQjHtvbXkV2sMA==
X-Gm-Message-State: AOJu0Yz3ucn7XqVG0MPXgqwBJBvh0BtuYynXNDFJel2MiZ5q0XOGEcj1
 asPH0MO4VzzaEEBhza+ZgDTpjYYnuuM8hB8UdHYPEfYqaZ9MN6wl97Jt/phuvrTfTTtwV9e2zsH
 iK4CMGn92Mb6uS+p9JWtdI3oRbdw=
X-Google-Smtp-Source: AGHT+IE/ubAr8PO3tvwzOPCmj4PrjDXcqZZ9ieXWwGEOsZt2rLdUn7bLGB6sI3bwHLl6iEkSlkLCeDhAs0etTd4KCFE=
X-Received: by 2002:a17:90a:bb94:b0:2a0:2605:69be with SMTP id
 v20-20020a17090abb9400b002a0260569bemr9898513pjr.2.1711491127343; Tue, 26 Mar
 2024 15:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240326033801.228419-1-joy.zou@nxp.com>
 <20240326033801.228419-4-joy.zou@nxp.com>
In-Reply-To: <20240326033801.228419-4-joy.zou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 19:11:56 -0300
Message-ID: <CAOMZO5CQrHf0Qwx2A1wR5yFqC2GiHJ3yza7LqL1kib0LvyKrYQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] configs: Enable RTC pcf2131 support
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de, 
 sjg@chromium.org, saproj@gmail.com, judge.packham@gmail.com, 
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

On Tue, Mar 26, 2024 at 12:30=E2=80=AFAM Joy Zou <joy.zou@nxp.com> wrote:
>
> Enable CONFIG_RTC_PCF2127 configs to support pcf2131.

Subject should  be imx93_11x11_evk specific:

imx93_11x11_evk: Add PCF2131 RTC support
