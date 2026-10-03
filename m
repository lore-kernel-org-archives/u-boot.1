Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974CACA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62319414E3;
	Sat,  3 Oct 2026 13:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aj5RloXacrt5; Sat,  3 Oct 2026 13:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7568A414D6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034915;
	b=mJYBmIy8oXu6PlRbBfU+5L/tJ7fay0xMDjUxaANpfwrA6VuHiVtFATOtkfEn/auGHzec
	 v1MsCZEFi29UDVc3h9gBlPGOeu2to9c08muj62o26wxAkZsHgQby87kS5iK0GiNTXnw7k
	 5PBrH09/aIfG7sBpoNzm/57uZSifjBY5L3cWaD3NeddUDf1JXMZccbJxENhEfMTv3HkKX
	 AqwyMKPn2J6J+xkQ0gTyeBwLPGWlf6GoOgqyfCXHmn60dFLlrNeNhE+HHfpkzMwYoaR/a
	 qL+QcE6toCBExOL5Dj0lt7yJR1nYpXfGXvmZWBKBjqS/DCBlr/CIMqVPJ+A9BcqsWTQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uKCnpA6IvWtu8E29KAB7d3pPw3TXOta4SPeenDkGm/E=;
	b=MEm3Eh4J7sW+zVr8RsVsIjj3M+HkVe1sBSoacMTluB53x8LeNStMt1wKD4trWiy0hE0B
	 PkPxc3n9lI+KW2eLUR6g/0MdHcNIgwT7pWpRmMbUksI2u41OSMkR0/cYb6Dm9zFQ68PCp
	 hm4d0R9YCgjRI5biahzjFtJdaJfk1+/5yXb2tnMD0H0Z+oIE14uqBoXaLTxVB6y54tEaL
	 S03ZM84/B0k9LfQFfYT2hapnjpuinD79ub+a02VywGJ/zfTSqzZkHenJrRuAuyPpCm+da
	 GYNK1/eYmNKDKUcRtuGu5kfsERqfUXY5O7yiB1K2/eiLJT0GDM4Kv6vKT4PB5rQI1tQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZD7IU9hi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034915;
	bh=uKCnpA6IvWtu8E29KAB7d3pPw3TXOta4SPeenDkGm/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sA8L72GukW+zmC89dO1To3xRytrXCByVU+C2sT5g5y2u6FaTGbBSm0uIdQDlBbZW0
	 fHhK5uAPIF63qvPQTW53+VCBBRir/5XYdpLnMexptnnkuZHLYAcRFn2mPx9OnXrxHr
	 MwmmJscHFazMWlsm338HfRpmTjI/W5CVlY6MhEQNxmxG5yIXQ9sUp6AkPhRw/yRmzX
	 VQGsiBnPUWkG5BZ+I+MHEbvYb/6XO086+9YiOVEXY3xpGvdWkl9NPMIrIb2KXF3YNa
	 LXjmRSRwpMDxQna0EVQKxduxjunSVUyDOELwgjFLQFAnbsIkvOKna/EuBgdaWEIT+T
	 kQntLcw1jcyIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7568A414D6;
	Sat,  3 Oct 2026 13:41:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0979032F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3D69414B6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-HDlREyMWU1 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E1918414E1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034912;
 b=n8sljXSNUs5TU44UAeyFurjsW19u1mUln+r1CBqOXHmyZO/51NgWZO+IhAA0vBjvswRh
 PAUvmtyEV4bxr+q+ce483IhN/aNc6HEQx6Nhxg1wc666Os84miwJwLVSh8TiOKgU5KqTz
 bzC6MOi3Xadh1ZOxuoy52OnohBlDUezkbtiXo+ST0JJN+Od3KMJa/EurUNtf3JEMWQPGg
 FCub0e6xxs2gQ6TrkcZsmQa8a4agZh0ST1lW/NwzGhOcIM70xGe9Rt5quzF3Vw06ds9yA
 50p9/ctJ/DRXiJFBhZmEtT8aLTK8hFZGfgkvmeCI6XAO7lavUFOONgYesB+l15vrbvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034912;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=uKCnpA6IvWtu8E29KAB7d3pPw3TXOta4SPeenDkGm/E=;
 b=jWG9SlSbc4YYPQUv3JevCs0czly2IEiPGFFora41pSN3L2JuB+ompE8tTT95sJtMEWix
 2qkSbUJa3EmadTkxk7j4nzg4nppjv/iisxx+UnevStoX0vmGj/0XqXBtacbGU4AapyaMj
 pehclCgNn5VwLavRybd2avFgyoS7jU5E7HxqGsror6qeORTk8HmLO5HlrirQsy8DMrFOn
 gutl5qAGd/jyGT7Li29bMsEKz+hbqWozBAkGp6u6EqhJis5K3y1qRnDzBrf9gOJJTS3wI
 7tO6JiZOgTOTeAz+oxbZGycCBMwhVWGlyva2Qf7qZxNzvO3Xs9T5UkuCnJoPyeaam3g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZD7IU9hi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZD7IU9hi
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1918414E1
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:51 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb8b78d6cso523200a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034910; cv=none;
 d=google.com; s=arc-20260327;
 b=pZyGoW112ooTHArpUuF2nfVyAwf0m703W4xKehkN6YJXy4BYYfQOuDxOaDoVFKtutZ
 A0m1fKNAfZ68lUyWzxtAuU2df58zNqERLWP/Z1YEk6/38zW+G3xrnpHKHBVPQqErwFnI
 RS2F807mS7c30Nl14LBQihJlwrOeXlmu9C99+XoXh0Wtcpezq4e8eukuJNAeEFpLonPN
 7qdBXqn+WT7UrpijIYZemXlZpP0yP//46JLwDbL93Oxe4hKLnYY0KsBKVyto4Ohu4eto
 Vjm3o0DzgbotlzKJtMZDgZYi76QAOa1ErpCVBNk0ME3+WFZZISAv/vUZoD1mu1K/3rNf
 h3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uKCnpA6IvWtu8E29KAB7d3pPw3TXOta4SPeenDkGm/E=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=j0J5Z4sa9plFw9G1HFv1SBvcNMMKTdE37isGHyKOWZzGH1FxgWssJ9VtL7Q+9KiJUS
 THZrbPy1q2t40bD2ii9+/MXO8OS4xgAIDCE6suuUrRoIrK9KIZ3QcbQGAsw45Ax3HfI0
 ksES6IoPQOL2SEeApgn+6/QUM/RXCSNBpf09+yxNwPhatVqSQpClvsNoLA8oBc8upEfD
 /pp2MADlesylm629nsWXib7PWNsH1+0bh6QrO+KGHZO7YlGVKwCk5LeCFY6YZ95GvH/X
 nYG3lk1UkGLsVn6oMVyvoWE0gJ84nEX3itEcvP9m9Auld8TeMqAN7ohsm78At9BXT3/g
 70lg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034910; x=1791639710;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uKCnpA6IvWtu8E29KAB7d3pPw3TXOta4SPeenDkGm/E=;
 b=ZD7IU9him+XlSRDUw/71LoBmVR4PTHamQuH+6IOW02m9au47A4nt9WUO0YnSSgU9SA
 UNPcHw6uCoNpBf7QjXY8se3MoTch/OMUYKr3UrTnLTaRbCZq/iKnHj4KQXs6YLfYfcEt
 XeTTqT3l3kLb//wECYVV4ho7/fNa9eDgcDHxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034910; x=1791639710;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uKCnpA6IvWtu8E29KAB7d3pPw3TXOta4SPeenDkGm/E=;
 b=24uSplaxTGUYbpwqQHwlMnc0SFmT+6A/33aqZNlScGWZBquf3l5xlUXA3lqiEGHWLx
 cHQ9lTZvDHYQFJLfKu0kJosenQTW030YvGWJwWG3qDVsDrMYS4331LxIyEBjc1zR72uQ
 mray9TxQAE4zr2WMHEvi2jS50m4Rm5Ob53PJ1OSuRGvBrBBVBl6HgPJh92O8vV4T+ShG
 cwagludHsvQuJiQRI82jZ238OtuIaE81yZNhQ7v/htSOGROYF1xSGzk4BruYKk3yu1my
 GPmpVlSe8Kyo/NsJBu+MGX7mQylKtenZwIVlldPJu0YVlzBXD0m0W46ZuUNaBTgFuOOL
 DKag==
X-Gm-Message-State: AFq9FYLRm01CpAxaHiSjELt0n74pyT1VXslgbAqWuAaQmBu/Jc2IF5Iw
 N/G6STxSqNDu/FSBGdw6WWdGaSw9Bv7eolpiEzCdOGnmw3IhWzFFL77dyQdJ3hv9cb3qkDLp3si
 80xkuW+trO9wdmtXuJk+gnvu/IvVHWGfd/ZC7T3LC
X-Gm-Gg: AYBFou2faCU3rKou5K3unea/NA2CY9WfL3A7Qsxzib/ZGCMCvx9ychYKWgXnHRekH3e
 /eJV8kobVwIiNeVWoEjon3eDg3WBfFF9QjtlZYGGs53XEtf/6mRf6j1fcLcHhFrPEBw8pV4kpiH
 M+FmkP5xRQslCBn51sygnbV+Gn5Ly1tw0ObetT/r0/MIcNAiJsbzx7xFVbhjETue1VP67xGU8IU
 WUOfuSgXeR5Ku25SaB69BsACtb8AcpfPJ6Svf+K0IHQNQFdD5pNb3RQmrijtkpfCclB+ChA5Ud0
 H+ccVO/8/npehbgn5hzjF+b2Aq6CgBfXNvxCngW3ZEgP9+xDHAH2K3M=
X-Received: by 2002:a05:6402:23d6:b0:6aa:ab2a:2548 with SMTP id
 4fb4d7f45d1cf-6af9df909cemr3860184a12.0.1791034909826; Sat, 03 Oct 2026
 06:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:41:24 +0100
X-Gm-Features: AclHuK8jJYoisbX_QYLA6mIE6L5bqvwbDFmlBZGZo91pRx156g3s-m6sviODA3w
Message-ID: <CAFLszTgTrHzG6BJSBPRQLt8KWtExKhNRkmOEwOh525J6c_eAug@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] rockchip: Choose FIT payload compression via
 Kconfig
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: Choose FIT payload compression via Kconfig
>
> The dtsi infers how to compress from whichever SPL decompressor happens
> to be enabled, so there is no way to ask for one in particular, turning
> a decompressor on for something else silently changes the image, and the
> conditional has to be updated with every new algorithm.
>
> Move the selection to Kconfig instead, with proper help texts and support
> for all available compression algorithms. Each choice enables the
> decompressor that provides it, and carries the compression level.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> arch/arm/dts/rockchip-u-boot.dtsi | 16 +++-----
>  arch/arm/mach-rockchip/Kconfig    | 78 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 10 deletions(-)

> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -61,11 +53,15 @@
> +#if CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL != 0
> +                                     compress-level =
> +                                             <CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL>;
> +#endif

No defconfig in the tree selects anything other than 'none', so CI
never builds an image with 'compress' or 'compress-level' set here.
Patch 9 enables SPL_ZSTD on sandbox for the same reason. Please can
you enable one of the choices on a board you can test (your RK3576
one?), so the binman side gets some build coverage?

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> @@ -758,6 +758,84 @@ config ROCKCHIP_MASKROM_IMAGE
> +config ROCKCHIP_UBOOT_COMP_GZIP
> +     bool "gzip"
> +     select SPL_GZIP

With this patch the choice is offered on every Rockchip board with
SPL_FIT, but many of them cannot boot the result, as discussed on the
cover letter. For example evb-rk3399 has CONFIG_TEXT_BASE=0x00800000
and CONFIG_SYS_LOAD_ADDR=0x800800, and 0x800800 is the most common
value after 0xc00800 in the Rockchip defconfigs.

Since this is the patch which makes the option visible, please can you
deal with that here, so that selecting gzip does not quietly produce
an image which fails in SPL? I am not sure what the best approach is:
perhaps a separate staging address for SPL, or a build-time check that
the two regions cannot overlap.

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> @@ -758,6 +758,84 @@ config ROCKCHIP_MASKROM_IMAGE
> +config ROCKCHIP_UBOOT_COMP_LEVEL
> +     int "Compression level for U-Boot proper"
> +     depends on !ROCKCHIP_UBOOT_COMP_NONE && !ROCKCHIP_UBOOT_COMP_LZMA

When SPL_FIT is disabled the choice is hidden, so none of its symbols
is set and this condition is true. The prompt then appears, with no
range, on boards which have no FIT at all. For example,
evb-rk3036_defconfig ends up with:

    CONFIG_ROCKCHIP_UBOOT_COMP='none'
    CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL=0

Please can you list the algorithms which do take a level instead:

    depends on ROCKCHIP_UBOOT_COMP_GZIP || ROCKCHIP_UBOOT_COMP_LZO || \
        ROCKCHIP_UBOOT_COMP_LZ4 || ROCKCHIP_UBOOT_COMP_ZSTD

That also means a new algorithm has to opt in, rather than getting a
level prompt with no range.

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> @@ -758,6 +758,84 @@ config ROCKCHIP_MASKROM_IMAGE
> +       How hard to compress, numbered the way the algorithm's own tool
> +       numbers it. Leave it at 0 to take the tool's default.

Not quite. For lz4, binman passes -5 when no level is given (see patch
10), so this should say that 0 uses binman's default.

Regards,
Simon
