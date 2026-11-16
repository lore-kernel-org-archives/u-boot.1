Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A18606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dirkUKkk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vo6vC5yz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C6BA4074F;
	Mon, 16 Nov 2026 18:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IcZzFxx3rOOV; Mon, 16 Nov 2026 18:18:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83B3C4062A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794853090;
	b=emplU94xhJJKEwdIPhaNccXYIWOXnS2vWY3g0g3mz8xTvPN8/Q5+rZ6JSR3PbmMGNm01
	 6/57E40Q8+B93+s3fqgtaQYuKUIxtuxt2abGUjQ6eOTbUMsH/e9afIfX4XQrmd19g9e5x
	 gcwfjPFc0xNG8yHSdHIG18BCLP6yKujQGdIB9+iVIC5PoBzdSx/YIryY92kW2C0omkl2k
	 LGjlit/nIIZgBn6Fn83DPcIo48dUv8TWjSvVK6mvV34HZlgcwXCpgK1vxqWcwdO4OTEaq
	 I3La56uzn6tVQd+iFRXp7RHSeaYbqDSjEEB3CDhmsavOzkC3kCWkcyICBcYMMA7PTPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794853090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iJKP1+SP1bV/dCWTLOyPyQEaDhxR1ASN99zJpHw3RfU=;
	b=JSsM25BSGS+yavc4GyUBDKlrINghdzoPsws57iE31jZvrIvvXpxU3s6rcgnokTjT28UU
	 mNdH9sjaf/EU92/dQe32KcU10s/zgp1stUBdbOa41OQFTGyQuLyWIRfdAHD1sy/5JHbk+
	 9X6eFFV+Vhj5wLo3Vq6EWJqCAexbW43NYyqWQD7Kufrcde/uC7DJRyJE7od8lJVbfjNQD
	 MYB5ejHDzbObjBN0B7CK1N8HKFNRDO/fFX5r75Ozxm0e1IovDFDhqxRlxNxQn65h2XbVi
	 o8gLw4xbhazDyE5spYpl5OVFqqAEnG0nrgg5GCOPrwLhRTcf8hvSIlnkUXLvi72Fmgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794853090;
	bh=iJKP1+SP1bV/dCWTLOyPyQEaDhxR1ASN99zJpHw3RfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dirkUKkk8VphmukUMk24ivWurOJrv4z4yEcYYgZxjo7rONEcCnrbPAeYlE/prnj/a
	 /FiUn5MTV6LNqXTtpGkA/hHLW+SBQAjOgqRzbRBGZK3iyl/Uf6uUjSAyijGAOkBKY7
	 vtDadEGyhOh3ghYjtwSkNmBQvYQn6ThWSMEeVNMpm/vObIzbadditEXkpGgTCDmeTL
	 uuVzqQeOwyikpSyV7Kxy1nrPNnUl2lgOZGry4zvRyLyXk+IJTcxGJsBiGQnM2Qau4K
	 mJcQHAq5wu6yELDiTTZzTN+MugHOGGP+Mjz+oUEeXI8OQHQBUqyIsCHnBSkBMTLSlq
	 cbs12MDAutSmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83B3C4062A;
	Mon, 16 Nov 2026 18:18:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1129E260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 030EF4009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Bz-Z0GSx2BK for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:18:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4924D4007B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Vo6vC5yz
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4924D4007B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:18:07 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-380b40319bdso910271eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794853087; x=1795457887;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iJKP1+SP1bV/dCWTLOyPyQEaDhxR1ASN99zJpHw3RfU=;
 b=Vo6vC5yzy7IEgKh8VglcFDhTJBrlAI707AkSOUtEjMhAZ1pC3Zp6pUm1rZPapqKM6A
 OVLoqZTYT573fl+bmJ2kFIYvmg8pdSFLuca7L3ifuRLggM1CPCcUxZsoFwmtIyaSTzDA
 oF3ctdOzNJhJsZ+YAjfcQ3H5uANlW7XG5AWqoEbUJnTg84rz244f14F0srjjPA86+g3I
 6y3wiN5/X/8e9VUMBZjjp40jTXPzu7k8wA94w/NZZyHNvEJzlEI0ErnqM9JbntAN7PoR
 /94cGgqR0v9xsFsTXXjxN1H4s8mHfgM4wfBo4J+Py6TTl/aAPH4LlDDJjO62EUP7L+yc
 o9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853087; x=1795457887;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iJKP1+SP1bV/dCWTLOyPyQEaDhxR1ASN99zJpHw3RfU=;
 b=bO32Nd/oON/YSQWY/Fz4fiB2rXrlIXAeHwFpQwoFLHtl78jQU8yFJjVwtpyoMJSYGP
 l5c90hkU7IG+zX2v96h/pNU6tl6xaP/L/yabPyEyibyzanrLfyetxIqu4lvNAvcEm/TW
 J5LUNZBoP0aQvUiO9K+5vYngijt88iZkpmjAWfU+vTdwFWn8oalJEC1i8zzkmPoDQc5w
 jDOeGexOBQ4cPq7rvm9F6F8KHL8VyvjMIN3WfzCvMsQJcUJm22/RcmETnB2SwdYOcLbM
 ssTPxz+X0ZifPouee+cRHrQIZZVxJ7LXKunHUbJyiZKxXQwaC8u29EdTMUYOPNe4eG4d
 DXVg==
X-Gm-Message-State: APuU4Z+w5UtaBWmm5JhvyT/0wFMAy1BX0ZA8wslizsDEUKD1cJlFJrRv
 YUvUzStpiv4UFjz6Ob9liXzFOkCEOukMuO1sanC6sdEiRvRhTdXtRX4qXs1IGgMFhvWEVfo9myl
 hayjyByMuepa/QhDygk44fKCSngW+0pg=
X-Gm-Gg: AYBFou0NjK1HeVUxNqwbhyFAuuCj0hdZ25fhM4WS4JtYrMvLoX8FsAZs4KR7I+Awx+S
 omkJzaGZXFtqOzj3DkEVtMW553PHWkwd/iTvPn0B3LgIAShsJqHYyMj09Ad9z8sSKkyWa1reVym
 fa+E0s7B4mWanh8i8e7UAVFiMU4Sj+y00oRLPu14FER6z5Duyqfo6xOsaOhjnncvMieUrQ6MJq9
 SiWhZNqKz3zkNCHYSD4mxLyOy5zmpdzYXEN37HWhU3i2BY10LA1xxM6ooa5KY67bym7Tlrs9/Bf
 yMgPLolPh1ZGj/6uhHWYNl4eEayDIWvZqb2oK+YUC4PlcuzYmhPMmobqjV1kYMwdqVrHT7giyah
 UxE/6HWHM/KdS+65VM5W5jiS6TGEYdeBZrrDYw6o7M6Dm9AHI9GFg6M0k4fau1FCWrk7UoVCVeN
 xBORwA/Ls8DUcuBnF7OoZN36TvRMxUTw==
X-Received: by 2002:a05:7301:182a:b0:377:d6e5:e64a with SMTP id
 5a478bee46e88-37965f9bfdamr11248791eec.7.1794853086985; Mon, 16 Nov 2026
 10:18:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116173918.3488067-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116173918.3488067-1-marek.vasut+renesas@mailbox.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 16 Nov 2026 20:17:55 +0200
X-Gm-Features: AclHuK8JSmQ-Vw_Kz_7IkWd5jwRa3ttRiGZiryX7u4qhzuKstUOl06NJnbjtqas
Message-ID: <CAPVz0n0BySG9CAcx8vF8-JqGZCe-DbWp7Gko9jW-B133oPZwvQ@mail.gmail.com>
Subject: Re: [PATCH] misc: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 16 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:3=
9 Marek Vasut <marek.vasut+renesas@mailbox.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/misc/cros_ec_i2c.c     | 2 +-
>  drivers/misc/cros_ec_lpc.c     | 2 +-
>  drivers/misc/cros_ec_spi.c     | 2 +-
>  drivers/misc/imx8/scu.c        | 2 +-
>  drivers/misc/imx_ele/ele_mu.c  | 2 +-
>  drivers/misc/p2sb_emul.c       | 2 +-
>  drivers/misc/qfw_mmio.c        | 2 +-
>  drivers/misc/qfw_pio.c         | 2 +-
>  drivers/misc/qfw_sandbox.c     | 2 +-
>  drivers/misc/sandbox_adder.c   | 2 +-
>  drivers/misc/swap_case.c       | 2 +-
>  drivers/misc/tegra186_bpmp.c   | 2 +-
>  drivers/misc/vexpress_config.c | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
>
...
>
> -static struct misc_ops tegra186_bpmp_ops =3D {
> +static const struct misc_ops tegra186_bpmp_ops =3D {
>         .call =3D tegra186_bpmp_call,
>  };
>

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>
