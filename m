Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46734CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06D1C414B7;
	Sat,  3 Oct 2026 13:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ty7n9b2IaulN; Sat,  3 Oct 2026 13:40:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3DDD3414B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034820;
	b=T+0HqignUB1LESVSflPrgnjIvQb2tqaR905xPxFs58ESO7pDGO5dFeCFMMKOxfsf05z+
	 iTjTKZab/hJfboDphxIHXgcGuWskmQP3zrmeb7kV9kRNrE0tkNA9gzNZgMY4/AhvHeMiR
	 NURBkIQSspWpn8gxB+8m3m2YDypD3ISOMCwDOl8VA4K5mk9ODnYyzorepftDjn5YQf7LK
	 MFD99+TShuU3XtmyHMMkzeNFUAT4Cfa2oKwJSaGsy/rXwrBdH4Tvo+34GbRQKYLdLSUIk
	 RDmG5f4v9Z9iIvpnjegTR6ExOzTV4n8iFztaVY2liptAd3AJyul4fEzC1cOn9zTcNmA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9gq2b5botg4TnCyTyqAcjnpuhkgzcaMIPtZBstXenpo=;
	b=UVFDDDE6jxvzRUJ3sle0zpBSqDkdnIPa6x9Iw/YlxpX+zB3pf39YgD8MB8O+CBOBk553
	 QMtAy6BX9uaDsRqjlgD5deNEJ9B6QRLOxJ4RKRagBaqPeuIg5k9EH5fwNSeHbo1XTWrga
	 CAZgeVEgdbYmX1Wh753hgQ3TJkTR/E3FMiAgdSP16BNWvHD30nr8pwysoTHdD/iT7YcED
	 OtdRVdD1FEhwtWqQDpqGi834vJ9tZjuMgdI0llJkbTgmhiofUloHnJIjbtoYSvOJ9c0i1
	 gPvzwOor9W6e3ovafyed3vdrrSUk4EkrcccBrfOs2EXx9q8MZcS3klGAJXxGUoF66hg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034820;
	bh=9gq2b5botg4TnCyTyqAcjnpuhkgzcaMIPtZBstXenpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZRGL5MYu+drrzM7YLPWWqN5ztVZY99V3KXPWQY8fZn+IqjLTDzUT0hIs9/GFs+Kr0
	 RhK0lN4wlZR22ZYRg1Bi2zVRS14Rj7nfidEmHKITq9+1LKM/DrbgnsViPnX/HrrlIQ
	 gaBIB/WtQAzY5fjsMN79FlLf9PfOTtjKNnFamdpD2zFsTyqkgWqVIPmE1giV8/iX7X
	 R8zC+Axx6mscYBk8icAom6b/J1OEfvm/LnS+ZtgMI92/wMbIMexkimrwuKLnX+aA+g
	 CTaWLaDnrlY288iG7TudnXGFdWiSM5zw0wXUjfJ/Hfh4QWt9dcuFE29a9RtmyBNNWg
	 VCK/t2jcYLK+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DDD3414B3;
	Sat,  3 Oct 2026 13:40:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10B01179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0290660675
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iP5CKpl_KP_6 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F1D3160666
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034817;
 b=hVyVx8ySJjhMlQCfzljjx1/ujulGl/nMvy5FIMUskckqcESPIsSL6CWEtK+OajIheo6D
 /2l2etYFWgAnikRUZfcRSQjlncBYufQVON6dMxGWGMwKSp8Y80JKgQFRtHf7HfNLdA6XP
 pnLgnFTGUt/plTSBVI6hG3CPheB/Z5904qI6emAtwISVNE6R0+ZMDvnW/XUQZdyzkaE2o
 pF0evRFc0ZoC4icT9sozn9VE+ovKjfmZcFeSu9Ff064sEIcfPiyOM+bzA6p7pgKs3c6Wn
 njHm9Qbf42VvWo+TQVj8YmHyyJ2p/IjGEicoC9oahZ9YccFUory0AUHbuLP7EaRFYbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034817;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=9gq2b5botg4TnCyTyqAcjnpuhkgzcaMIPtZBstXenpo=;
 b=Fl8dAbK/zylLKzhqF7cv9hh45XHkBbRvZ4B+kCVSmhuMOx5lyHbtJ+viFk2hF1mc5ija
 cSIfokZlxdYYJLmBhAXZPdyjIZcmV0gdad46fRP5r+rXI8FfbzDPDUMGK+0Qx7O37MWe+
 Fndu0NjIk57G/twtdkPqjU31pu0jin6e9Wmn8jsbcGe4OO2C3OXyH9bzLcYrL9O9YWyfS
 Kdp5aqsz04zGKP2d2ardqc8IXRcO2fncAen9VLgzkvVoDJ6dKxFLj39qMsJ2zSvYQS1Jp
 9XpL2Sc1MJJGdQM/tiqVQZDmr9ubepv2+/5atkjPRDXlGKRbZiUsjzCNpDDMrHT3cpw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eVlf3g2t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eVlf3g2t
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1D3160666
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:16 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso183884a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034815; cv=none;
 d=google.com; s=arc-20260327;
 b=sYUt0Ot6KXAhV/4VwOfhhVUYEeExDPjKFQ68M5pLkks9n7C5GbkKxULpS8yPZKHweg
 UMINTjH0vL1keWfyKKuda+rksOJ4KI0zjqTvs7z7jknepls5drL58IoJwzjv9IFQbRFx
 XhRgDkoNHrpZElA7LobEIImUfZeSpdD5bAQfZSNgUB6SOAielmOmPgugjv1+skaoXaNX
 QbkPlzHSoQqf8mjOtoZHMe8Z7TE7/Qf8cvmKZrZm0gv3kBAfP6RaQnuUYHEDSRPRNSmi
 tpEseEGIOg3OszR33EP2DdHDzoov9CYrNiwbK65Xy1FjLIrAsDQF4d08oXTFZlgt592p
 HDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9gq2b5botg4TnCyTyqAcjnpuhkgzcaMIPtZBstXenpo=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=nHo2p5iSWGU7QYOgFi6xTWQxTBuTwP/NMqACcBXqr1wl3P93kpNNmf9t1GpooLByTL
 rnCgtqjhEnJYgTtEeb0VNlyTUYavhXzZ2CYVOsizyvYtiGOeLbLRB9NJPiOslFUf1fk7
 Elc7LjMnynw9t0KEad315RzlDQMOvEKbSGGuBHN0P65P/7O11A3uzLUBKkwn2kHf/Hgp
 eDUtqOt2Drgf3iLZWUnGJ+OnVy6h7guB3q7a3aVOKxvisDecs4Sh1rupAfvJZ5O6ltKe
 tPkDTpHMOPspIyL+9TOFozb+hDpYOsC2VpZ9KCBnxY460yCOFU7A6IgbHbPfQr5JJ7ff
 iEUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034815; x=1791639615;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9gq2b5botg4TnCyTyqAcjnpuhkgzcaMIPtZBstXenpo=;
 b=eVlf3g2tUJqOiwViwwu1z316BlO3ys/cEAt4n+icBiKbhwYWSwj9d8uFW5fwE0M2lG
 pwq9SZraBnFRJNGkFgGnigN/1crC8klwsUwOevcfSzAEcHc31rZPKA6MjCSGxItvQbbt
 J61/mV1fNe7i/J1o02Pv2mRoDC05zZoSHezf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034815; x=1791639615;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9gq2b5botg4TnCyTyqAcjnpuhkgzcaMIPtZBstXenpo=;
 b=aijwZoaOhV/MoeKxsDHXTfftx4TiSf+1MhyWWBz9XEGnun8Wqg2y4oL/3i3RehnCir
 x6a4O2xUom28T9g8q/iLj9//7VwXHNMbm/KTvjoXBAcuVRMggWUVkMoLvDiDZtrKoR6u
 9xr6YXfVUr9PmXE/kZjo5oB1TftsokmphHhQgpf+4EflK/LwQKQ6N01Zn3U+iScO1PYg
 MdHuMNApTwhgOKnhg09c2TBNcurbT2xyLbmlJtcnD4bgrRn8cuS8hbyA/V3khe6OfeIt
 uio+aaDaQV1i6bf1+HFbSMcBX/CizCwEAFn2Xmmsszwc80/jahgtwDLHar5fLdWwEkAs
 mswg==
X-Gm-Message-State: AFq9FYI4dZc5MoJCLqjWa/NNIKX5vwD1zN2Jr95PN31L80hoFP395wmk
 /zii9FbnZusVHc/hw4gxw1odLII3gIoz0LqvlZ14Knv/4eAM/+nM+L1aO8DhbjK8Nbeg+PtATlS
 D3z57pEcPXvsbXtt/zVurN/7mSEZ3ce5IXqNxZpQS
X-Gm-Gg: AYBFou13sh/3QgMJNj5KSdfIH/O5AptNSetMlHMNc1+KxcN/Gp6KH7jWQyLAXgTLLDX
 J3WS81A/wK9oWQFWmL55gVnNtC6GSpAH9yFkjJJIhuV8cYNxYPtL03QNDcEGQz4dZJqGXGfYvjm
 A7ZtU7LQhSiUy6VCs7Fd0XmdYJqLO0sUTW+br5BtATtU3pbsBdZH6wX6tfYw++mclvTY7TLcrdi
 e8Ph2hBD/rYp3tGCe2sqegbi+NhX6cCCz/LptOlHmskiMU60bqip+gyIXg6J62Pivd+ktV5fkA5
 OXCJ6oUWcc/htwSxl1WmFylMCY21TD8hJ1xYC/sojDSf4+rPniW+Obc=
X-Received: by 2002:a05:6402:51ce:b0:6a7:ee54:f894 with SMTP id
 4fb4d7f45d1cf-6afad90b757mr2025977a12.24.1791034814855; Sat, 03 Oct 2026
 06:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:40:02 +0100
X-Gm-Features: AclHuK-QtSuyuL1NoQQwbpwbN6CbrDuVXO1CfJjM3KthDsIzvJxAa0db1UdT9Yw
Message-ID: <CAFLszTgkO7cD5NwhtdmyLpDhiScOPsZQ-gRV11tdeCJQ2Uvn+w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] boot: image: Keep the image-type table out of xPL
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
> boot: image: Keep the image-type table out of xPL
>
> print_decomp_msg() names the image it is about to unpack, which drags
> uimage_type[] and its strings into any phase that links image_decomp().
> That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one line
> of progress output in a phase built for size.

Not quite. This only holds where nothing else in the phase needs the
table. load_simple_fit() calls fit_image_get_type() when SPL_FPGA is
enabled, or SPL_OS_BOOT plus a decompressor, and that uses
genimg_get_type_id() which needs uimage_type[] too.

I tried xilinx_zynqmp_virt (SPL_FPGA and SPL_GZIP) with the whole
series applied, with and without this patch:

       text    data     bss     dec     hex filename
     131556    6968     440  138964   21ed4 spl/u-boot-spl   (with)
     131650    6968     440  139058   21f32 spl/u-boot-spl   (without)

So that is 94 bytes saved and uimage_type[] (0x480 bytes plus its
strings) is still in the map. Please can you update the commit message
to say when the saving applies?

>
> Name it "image" there instead. U-Boot proper is unchanged.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> boot/image.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/boot/image.c b/boot/image.c
> @@ -416,7 +416,12 @@ void image_print_contents(const void *ptr)
> +     /*
> +      * The image-type table and its strings cost about 2.5KB, which is a
> +      * lot to spend on a progress message in a phase built for size.
> +      */
> +     const char *name = IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
> +                        genimg_get_type_name(type);

The boards which keep the table are those where load_simple_fit()
reads the type from the FIT, so the name would be correct there. On
the others the type is never read, so the lookup can only produce
'Unknown Image' anyway. So this drops the name in the one case where
it is useful and nearly free.

I suspect it would be better to key this off the same condition which
load_simple_fit() uses to read the type, rather than CONFIG_XPL_BUILD,
perhaps with a small helper in image.h shared by both. I am not sure
how neat that would be, though, since any xPL build with LOAD_FIT_FULL
also has the table, via fit_image_load(). What do you think?

Regards,
Simon
