Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A498606E00C
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XZd8aPVE;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RlMJQw08
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCD4A6066D;
	Mon,  2 Nov 2026 14:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7aMBEy9jyhwi; Mon,  2 Nov 2026 14:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17C90605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793631263;
	b=fPddWCnuFngw2jsfAWy+iLpPH+GbFcO7xBl5CqWsKBCaYtrYOTzT51hK92Bb19rd9nHf
	 nqC3+QZ8afOkLi6Kwm+ehe4SmIoeuFvCJQqmT3l9yjFG6BLL4rTJ1xfv3tbfF67C+WcA1
	 q3pvYCVu3Zh0Gu6oFJBIs0m8B1J0DVQvZ2fM4ULF5iej59jdV68wUck5jY3PaHAkcIaBO
	 vgezzsnWkXcGGhOLcw1l51OsVznD19UrqqXFxRK9b2ng3JnjEuryGvtFPtlV8tFLQgBgh
	 BIt2a5KyaIknBrUEHjKS1QENMg30JF8eF8vD41vU+zJLx9dCyaGhoiJVG5q7G+8NpKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793631263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3HkvBsJwrql4c5SksF6p4RsdhJg/0sAnm/NfWJDym3U=;
	b=C8MY1P5cXItd0aqkehLGkXyUjHGvO66ljbYnzprE2zm6q0jEhWPvxi71s94Ku38DcVpt
	 jBq2YjRmdh5OODrCjtMHr+YKkxvQcC76SSlpAhT4MzsPMhsfvEhDl4srK0EoxcR1mf8IL
	 pzZNX0jfVfM99XsjL0HsUMxu1i22LnSyiZwzqTCUlQmkIiqBF1MccsKivSnep+MCZ63Yl
	 OdvFuQtSQWwCK0B2Pv94JCfohyZlsfNWlBjeMmPZsMwN6F/jQvJhjMmos80XUCdWDrUj9
	 YrD59BM7dccAYHT6F+i0Q7R42s4cU2Wj1+ky5tttuLDBctuATnSxXJtu5/EuCOW5Wgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793631263;
	bh=3HkvBsJwrql4c5SksF6p4RsdhJg/0sAnm/NfWJDym3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XZd8aPVEL1dX4/s3yejApxHCFM8ro5PhWnRHeQau3qYudHd1RCbnM2qMkcWHd5F6R
	 kwwcF6cMH5UlcqUR9+qlUZsTOeqbGVFhcxozu5MoYZNXTibcqpffm3LwwMgBN9TExK
	 +mPcG6kwVSL/0PjldK5mWHPZV3bH6FK3PMNvBgrYH3WdBOrhnxx9YxGxoWMbExhPQ7
	 Xvuz3Gbr/9Ovg03EwSn94zGUkrRhWOgNTxuVeMqlnYBYkP3PO6w4NE86YSnGZid+jV
	 el5JdpMQCEjolJzThYQ30n2LykgK/z892XwDhieLB/Wl6JVUJwFnvAU06vNiL8nd2a
	 8BpGri3aWS5pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17C90605EA;
	Mon,  2 Nov 2026 14:54:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 503A2435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 417BD80F56
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id obg35UgfyOSF for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EFA980DC8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793631260;
 b=aCJr1NIgKdXWvFAeAh0awoPNBds58J1e20cfQUxWgK2Sw6St0Oau+welypW9LFLfygYw
 u7Ox/9sddxYXMqK7QZQft+tBkoyCeWqgojVB79Wsk+EGURmgbSmklvqFVgzN1Ua9VWqW5
 v7WTgBFGeYBYlt0Q29tjab8JYdyj6q5D+DP8u6HQUqebNVU9Rm6eB6xg74VK54jsPpaVo
 fdsVg/QojfCzxMNYNtXKPkw2mOdYuHeaLW6NAR+6PVq2ivfKgl8w03CssCO2epsVL2lU3
 d2fX9u2LKr6zGYaWWown4XheLbOltmOBZNa89QZ09Rxzx5oCnClwQWLMVc8xfFMJG6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793631260;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3HkvBsJwrql4c5SksF6p4RsdhJg/0sAnm/NfWJDym3U=;
 b=WL0rEQodB5SmpFmeLieS8iNJ+LWxSgR7n2pUDAuaYnOBJrhSOcHoi0gXLlbZQuQpZOuw
 H0o8ejk48H1gnQMUI4WZy3OQwkyy37cm2gtK7S1KahfyOTXOrjppRlLr9k0Wq067x07sU
 lO2j6fqa4jeEM4AtP1q192+cssHW8Wj9PaFtRe5KZcdc0gSnOq6OFJoRQ3GD1IlA1oW7S
 RStHaohAa2Ybd2fJFHdhXI+3la1EfsoWAiqj5BMkT237aK7i9BOn36OONrK5n8sQ8vhKP
 rQQphIXZv1cNOD5znyOfWN3dXho6UOA91b+KzRv7Mu6ScE8Dm8JfE4u4EalfrdcX6aw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RlMJQw08; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RlMJQw08
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EFA980DC8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:54:20 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-84e513877a3so2812559a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793631259; x=1794236059;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3HkvBsJwrql4c5SksF6p4RsdhJg/0sAnm/NfWJDym3U=;
 b=RlMJQw08jhGoQKh7+parfmVPf7J9jMNs7G6iKWu5FAxnJS1dOHiUz0gbcSnacfbB2E
 Hkeh8e7qtLr5H2XncucnpI6JedO7B7/Dcu6UuqtjmhG89TMK8u+KQCwpzjktUQOWsMmh
 3Nc7zWIPJnh0cORhb9OHfnkAS6+gGO3sd0mlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793631259; x=1794236059;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3HkvBsJwrql4c5SksF6p4RsdhJg/0sAnm/NfWJDym3U=;
 b=JK7OIj9vKkFLzONI8rpBekfmJ1++uFKHtLXJsorFk4puZFkBNagTFG6jBPGgq+87Vl
 n0AG+9k8yAp5P0FWavBIgg3mIbnI/w8L+kxPi0n4/f4vW5wfwCXj/SfoOrFNCsoTZnKb
 lcaK5xbijsHu6O3bRPa1Fl10kyTBTnFTS7KKwdEDKVLEcqK5UCS5oUfnHduMR790r+y+
 ewrYxfPZRCRXCUipj737OrBXsiguESmYNplDimWl3vPdjBUmaDyVZX2YpTeW9fc3Tqlr
 l7NPE/9kvxAVo/ZGKb2Fj8ln/H54JotNPGJL/dfQZ4XTp9ULPrDNQPOLAERr723FN3tN
 97vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl2lA1UQzBoITOYG47c32WgK1YAAr+zmYs2rsKkgI+AGyYw5NvflB11ycrtTy8CQlA4ffWVqk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJy1FTNzTCC6icI48GIy482Nvj2yWLOscieVvImPWBcOBnrikbL
 z2V/xcUj5fHH8c5/Yl0ft6QpBrz3YTuFWovWbd8Av7i25chtWCWRWuyDPnQgsSasbig=
X-Gm-Gg: AYBFou1k7dQGZ8pp/We/1ptaIAvc0zsgeLZDJP1iQ30VEdefnA3mIywasj56oqHLWek
 5MBIdMEy69wcwH8ex9JWzUXxuAcoKz7nuVOAM7BPeL857pVGu5G/1E8rkdiW4L2dv0c1rz41+UV
 5lzXe1+vb0g2XiZFZz1MwW8tyNPVlrhALEgIR6PDz+HF8Q1ndkfL5uAfb1CsqW2n+Rppf7AlUTP
 I8FYZAtbt4PUNVe4vhmuwysAVq2Ntyx1Of3GQeqZfwuVGLjFvne+S+sEOpMFNeWNtQejWZaks+C
 EGgc6bHcahzYO+53KeiYIUpV2ci7IchQNstyHKbYBzzlDN92ZX4X/N+KuV2MPn1IBRkesIne7Ob
 6+2meCEqFpxv3en2XsKFo5eLM3kegYd3s/BwtzgdSkl/zonaRC07Zc8fKa7NdcUYqsj4p/5GLhM
 /2xaGYmtDZ3NhiZaqGRzGUeO0+8Ojtr1Jc9KnRrBOBR5aKBchoKVgaR8pLEE6poYzwWJjJvEnsY
 zTZ6DL6HECivGm73VAJmBAaymGe3AsQtVoocRFYB6nr13lEd5ivhHRqtj6Jrdabrpi/17SraFUs
 8WambZfxfyrjsY45r7nLRSAF2/fL0EN95QYYAChb7p+Hr4pt7ayR00U8Jshl56bY0+N/+TZATzd
 a/14fvCNqftBjkBXjYebWRexO1WP7Lozv1IHRyoZnoByVLygZGcpbGWGP8yF1g0WfAQ3Anxm6Bk
 exlEzwedrdLGlkY+dzBQ6WrbA3Q7aCmA1TuNCqWP6rSa0bo02qiMk=
X-Received: by 2002:a05:6820:1c99:b0:6f6:55c5:358c with SMTP id
 006d021491bc7-714ddce2e0cmr5769061eaf.7.1793631259070; 
 Mon, 02 Nov 2026 06:54:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b89asm10202267a34.6.2026.11.02.06.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:54:18 -0800 (PST)
Date: Mon, 2 Nov 2026 08:54:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Lukasz Majewski <lukma@denx.de>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 02/15] mach-snapdragon: Kconfig: Auto select
 options based on configs
Message-ID: <20261102145415.GT3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-2-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G/M+4pJJ8weZNm14"
Content-Disposition: inline
In-Reply-To: <20261102-spl-v10-2-224d421c6201@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--G/M+4pJJ8weZNm14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:18:34AM +0530, Varadarajan Narayanan wrote:

> The commit d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions =
to
> support SPL") auto selects options that may not be applicable to all
> platforms. This results in warning messages during make xxx_defconfig
> and/or waiting for user input for on/off or values for certain configs.
> So auto select options based on the enabled configs in xxx_defconfig.
>=20
> Fixes: d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions to s=
upport SPL")
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  arch/arm/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f307340e3aa..51d60ef65fe 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1147,8 +1147,8 @@ config ARCH_SNAPDRAGON
>  	select SPMI
>  	select BOARD_LATE_INIT
>  	select OF_BOARD
> -	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> -	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> +	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
> +	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL

What's the error these two trip up?

>  	select SYSRESET
>  	select SYSRESET_PSCI if !SPL
>  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> @@ -1161,12 +1161,12 @@ config ARCH_SNAPDRAGON
>  	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
>  	select SPL_DM if SPL
>  	select SPL_DM_GPIO if SPL
> -	select SPL_DM_PMIC if SPL
> -	select SPL_DM_USB_GADGET if SPL
> +	select SPL_DM_PMIC if SPL && DM_PMIC
> +	select SPL_DM_USB_GADGET if SPL && USB

You're allowed to have SPL_X && !X. Presumably some drivers are missing
SPL_X options, I know I've seen other series go by adding them.

>  	select SPL_ENV_SUPPORT if SPL
>  	select SPL_EVENT if SPL
>  	select SPL_GPIO if SPL
> -	select SPL_HAS_BSS_LINKER_SECTION if SPL
> +	select SPL_HAS_BSS_LINKER_SECTION if SPL && SPL_SEPARATE_BSS

How are you tripping this one?

This is the kind of change which (a) should be its own series and (b)
either N commits, or 1 commit that spells out each of the incorrect
conditions.

--=20
Tom

--G/M+4pJJ8weZNm14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauikEwAKCRAr4qD1Cr/k
Cj1CAP92UA5oP+N4v/pWYvDa5JFPANmSPDs6ImGts5pcGXtWmAEAvG+sGSVeQgyv
omwt63a37T3xTEOPs6lqEN6tfL+TXAc=
=8YCj
-----END PGP SIGNATURE-----

--G/M+4pJJ8weZNm14--
