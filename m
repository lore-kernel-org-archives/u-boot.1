Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5225AF99C86
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 05:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C051E840D8;
	Mon, 20 Apr 2026 07:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RhgJOqVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16A584181; Mon, 20 Apr 2026 07:30:28 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E2083B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbcf927395so1443872a34.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 22:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776663025; cv=none;
 d=google.com; s=arc-20240605;
 b=KU/HcMmkmrk6bANG16cwVlJAFXVmBX2U4jCF93Hj1pKakRSIaZOwsf+V3r/SPSq3j3
 x0mxA6CKn662fMSJcrpwkTwipiOBmKjSuDsdtQkvHOtt28f/Mt7Ek9IZAXX0E+eW6ZjZ
 xqslzSaC1qgwBxsOJElFTjsLqka0OUfOc4vxKPU7ifWwjLScg3jXvuMIj+2QgDYUMMGi
 W49oYXj8K+bpMk9r5ZnCW3Of9M6gVrsxczPe4bIp7ccNG6xQ6QGDHOuwFAS82GBliPFn
 09KmUYsK1MhtdNi/o52lcMPB+7IOnu96qzEwdOIK4JU0X2a2WobqCKMje29pnG68pkXG
 BeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=li9jNQRQenyRxnDwx2I7RVpzOxRUGTV1E4+3/o27GP0=;
 fh=tlKsbSfCzGwg7C0sH/7ZbVW8KbpB4hOnmYCaWWBLn2w=;
 b=liTyAaVHLDyslI9rvbFWqgXyGdBXrOPl88/sQzvPbdwn9D/jFNZ5SyMynXYHpu+oB5
 BEsaRx1jbqfKsk3STfOXCNMgnoMhcNq8pcWaMOb4R5w4ZuAWVi/zJ/NvYR8HQ8YH78iK
 OztAM3qy7TCewIsrBDYglFsq3o+eeRgqnUlt7xFtzjTNK3f9vVJBsxyp6EU5YPWG4oD1
 R9ApT935siYAdjV0RibHzU7b+hVtq/a+O5EV6Hchn+P1+OaosjIcJqXrHzIRPY6e0wFu
 eeDOah+MPM6Ag/ZIqoIaiYh3L9kMCrg9D7VkpmvjDZv/Rr8xx2aL7OUM/tjX6LBkwvYv
 h56w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776663025; x=1777267825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=li9jNQRQenyRxnDwx2I7RVpzOxRUGTV1E4+3/o27GP0=;
 b=RhgJOqVgMWBxax+rAMnLIk3WFqJql2eYqmf+bDO3E73ke18bolA2VMj12HH4g29wKE
 lFy6ITWl0eRsY77A3VLiYZdQGaEm0mnyV5GoXkUpxIQuTOcrwPnl0k1IHCMCMGnfBip9
 sHo3zGM64H/nLWaljYUodWiRRNwU6FyUyQvVu+mSdxh4wFhJJhUZvNHbsYKHjM5qfoM0
 v6a1quCufnBG9R7zkl7XwFJTO81ms0F22ucNGJynVrSgGz0m8tsAI5E/aUItuGqFVXH0
 JkplxsJtFmDgyrdtbdXagteoVPp86lMeBaoDh8F2UYzpwMYU27v4lcy6RVmAQNHBevSr
 s9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776663025; x=1777267825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=li9jNQRQenyRxnDwx2I7RVpzOxRUGTV1E4+3/o27GP0=;
 b=b3FPLd1lmcL2rvJMcQNyw/0eiTzyb1J2L98ba5+yEvDNSSwGCo6DmLItdmNt0sB8Jv
 77WPw2xPdVt9r6Epd1N+eBxzUGYQA1odDMXuzZMil+EwCarPQq89Q8fUyPTdhmCN+idt
 regGIoofEFbBecv2Zdrtzi8Q3o7d7DpjbiyleHb+UbZHnf5Llssv1SIVW/Cgo+HD8bwS
 ZNjia7OaUP0JVymJLpNjcdhQ8M6wuf0DfP/sl55v9dxPhcI3mlNnG3/h6nwVt2PcWXBF
 92UkgcOxi8xhgyiu3/OlNwhc4c2i5wphzT/IF2LY0G57ECloRNNoCXIH0QEUf3EqQ3zd
 S+RQ==
X-Gm-Message-State: AOJu0YxHRka7syI1eyZVc9lZPU+2xc+D7D0SBEgDkJ/e4M/ON8yHwld3
 yL9aoc8UbCVNEPOwL9dauveTk19p8QSJaIKGMnlO55cbWSP8pNPjpCuJuDEBmYyPPitIdz3rIJC
 QRZ1z6ZIMMIqa/N6MIiOITkymvj6OpP4=
X-Gm-Gg: AeBDiesd9YotFigkrMBOw/skweo2FJTy+Wd3TtcZ/khmmGRqfGvo2q1GsJf6YIjiZ+f
 /yH8KxrxZwW+BBJ1d5NRfBOubCmt2aAYhVWS2QebSGon57aHJcsjS0KAFkarVlMzlAwrO9pxQlL
 Dvyqwlbn8qPg64cnX8hGgS8oc2mhKNkbwDvu9kWh4xVbIM/6iHQUvzC7wGeqHz/JaTNRLu86x+f
 ol4zP5Zr0fY0KSYIF2ZZgrWu7gkEBj0nJoE5hGJS9LPllnko9StvxVpsE+IGwW5tQ8cIrXivFk1
 OupjV1FvqTYeWY3KOQ==
X-Received: by 2002:a05:6830:2b22:b0:7d7:e245:d5ad with SMTP id
 46e09a7af769-7dc951a8f88mr7302961a34.16.1776663025069; Sun, 19 Apr 2026
 22:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260411172730.218700-1-briansune@gmail.com>
 <542d6395-44a8-4221-aa7e-97141ec249e5@altera.com>
In-Reply-To: <542d6395-44a8-4221-aa7e-97141ec249e5@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 20 Apr 2026 13:30:12 +0800
X-Gm-Features: AQROBzDwOKcW6aP3BQFuiCFj25PvLwW-Zw1dPDGkWwuGLzCO_0U98-LVisHzx5M
Message-ID: <CAN7C2SDvCgVpMY_8WpyT1VXCdVdc3mXmPCxPGT38z7UbqEYv3g@mail.gmail.com>
Subject: Re: [PATCH v1] Improve handosff prepare on SoCFPGA
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Mon, Apr 20, 2026 at 1:02=E2=80=AFPM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Hi Brian,
>
>
> On 12/4/2026 1:27 am, Brian Sune wrote:
>
> There are some cases that the Python scripts
> are run and the qts files are not replaced.
> Make sure qts folder h files are removed before
> handoff script runs.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  arch/arm/mach-socfpga/config.mk | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/conf=
ig.mk
> index 1ca1d33cb16..d9d9d4f2373 100644
> --- a/arch/arm/mach-socfpga/config.mk
> +++ b/arch/arm/mach-socfpga/config.mk
> @@ -43,6 +43,11 @@ socfpga_g5_handoff_prepare:
>   exit 0; \
>   fi; \
>   echo "[INFO] Found hiof file: $$HIOF_FILE"; \
> + echo "[INFO] Clean old BSP files..."; \
> + if ls "$$BOARD_DIR/qts"/*.h >/dev/null 2>&1; then \
> + rm -r "$$BOARD_DIR/qts"/*.h; \
> + echo "[INFO] Removed old BSP files..."; \
> + fi; \
>
>
> Thanks for tackling stale qts/*.h when the BSP generator does not refresh=
 outputs.
>
Hi T.F.,

The idea was intended for the preparation phase, not the build phase.
aka > make prepare
So if the preparation phase is having issues, users should
take care before cont'd.
As handoff script originally is a preparation not build operation.
However, I think it is better to do a file check after py script.

> Concern: the series deletes existing board/.../qts/*.h before running cv_=
bsp_generator.py, while the recipe still continues on generator failure (||=
 =E2=80=A6 continuing). If Python fails or produces no headers, the tree ca=
n be left without the previous QTS headers but the build still proceeds, th=
at is a regression risk.
>

You are right I included an extra repeat flag on file rm.
Bad habit on -r on very things.

> Nits: rm -r =E2=80=A6/*.h on plain files is unusual; rm -f is clearer.
>
> Suggestion: generate into a temporary directory (e.g. mktemp -d under qts=
/), and only replace existing *.h after a successful run (optionally copy t=
he old set to qts/.handoff_backup.<timestamp>/ first for diff). That keeps =
the =E2=80=9Cstale vs new=E2=80=9D comparison you want without breaking bui=
lds when generation fails.

Release a 2nd patch on both modifications.

Thanks,
Brian

> Best regards,
>
> Tien Fong
