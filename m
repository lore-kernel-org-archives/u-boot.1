Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBC9C83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 13:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DE686416;
	Sat,  2 Sep 2023 15:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sj5XTlti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 925A58643B; Sat,  2 Sep 2023 15:38:30 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A39847C3
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 15:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-500913779f5so29442e87.2
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693661905; x=1694266705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qfQ3Y7YiI8nibagMHulBMM4IBwQQHpttNnGi6Yeqg+4=;
 b=sj5XTlti4XkeiYzXGIWKda5QbacO0fGFwQscBdZH8+HoBMjq0UtS/UqW1DJsrn/8cJ
 eHr8jPoROXRL7v173tAUl36AN2w7ctYmTbmmvjoFVnBKH+E8BLA4lJZ5RYic9UjG0MmC
 xxXm6aEpbat5ecwbW5/6kVo4yQyA2VzU0OHNroQdNzfqMYY8FtGaTByDAVcoI98eQ37Z
 Sj7jSC4iXt01tHeaV2g0mlEoZ1yfO23cPpO2egrYyI3TpOfHLFGQd7GWh59vZNW3E0j4
 +iplF+AoQTsMu232MTcCiMAUdZLa+X/5Y7rbE6bx5j01nLbCIQ+tUymPd+nlxvkA7ymg
 BXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693661905; x=1694266705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfQ3Y7YiI8nibagMHulBMM4IBwQQHpttNnGi6Yeqg+4=;
 b=lk46E9XFpAYM3AtLXvH3CJM73RbcRA7BBTgk5zOa/Q88IevHahg+JqiavVX0tgSCSt
 b+7P85l96O3rKCz043RjQ0cum2hs9VQHrmvHbeUdPs2i3xL9oTPyqg6JyNnz+chk/m+m
 t42t/XjWZt5HwsKCJmtI4w5MJQuTSbsGI/2f0xAsdW10nXSSBuqEOxAhW9Dbj8AOCT1n
 ggRX1W6fiTu8rvt6R7VDA7ZECw8+AoNEUFhpfqR1cNwyxiGWC1cKIUL4ZP4wd4TK+u74
 33FLXgUq9fmwXyTnRvHyOSuJ14N2OyZBIncHclEZNXFZldi0bDwISuw33iOmU5cJiKr1
 CnrQ==
X-Gm-Message-State: AOJu0YzAVgZ3KpxGtKRD2SLQdgoyfLIPwZo0Jn9A0NgCHvWc/qmHUd55
 5CUABQSujA7LULq4vP4g7eC0VY3fl1Z58LWEvAEN5ebrsrkcaWNx
X-Google-Smtp-Source: AGHT+IGiCfIPiJiQBAnkiGuAHczIwSvj++bPN97Z8pATXE2ESFSGKnESnrivJMx8u1FX9T1Bp/yTG0NdvpXopi9UNx4=
X-Received: by 2002:a05:6512:1316:b0:4fd:f889:b9d2 with SMTP id
 x22-20020a056512131600b004fdf889b9d2mr4315168lfu.38.1693661904650; Sat, 02
 Sep 2023 06:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230901200353.90290-1-jmcosta944@gmail.com>
 <20230901200353.90290-7-jmcosta944@gmail.com>
 <20230902131109.GW3101304@bill-the-cat>
In-Reply-To: <20230902131109.GW3101304@bill-the-cat>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Sat, 2 Sep 2023 15:38:13 +0200
Message-ID: <CABfBAmDEwtTAHL8hxGXrsRNN1V9USPYNwi9nojb-HN-CQwDF1Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc: add documentation for gen_compile_commands.py
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, antoningodard@pm.me, 
 Y.Moog@phytec.de
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

Hello,

Em s=C3=A1b., 2 de set. de 2023 =C3=A0s 15:11, Tom Rini <trini@konsulko.com=
> escreveu:

>
> This isn't included in one of the index files, which will be the first
> error 'make htmldocs' throws, and I think I saw other syntax errors as
> well in the file.  The docs themselves look fine, thanks.
>
> --
> Tom
>

I'm not sure what's the most pertinent category in 'develop/index.rst'.

Would 'general' be a good idea? I thought about putting it in the same
category as checkpatch, but this isn't refactoring per se.

Thanks.

--=20
Atenciosamente,
Jo=C3=A3o Marcos Costa

www.linkedin.com/in/jmarcoscosta/
https://github.com/jmarcoscosta
