Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA36CC5AC80
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 15:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7231680D48;
	Sun,  9 Aug 2026 15:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abpNOOSGNhY4; Sun,  9 Aug 2026 15:27:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AAE780D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786289232;
	bh=ZuHCUd708z/4qEh/yZAnTeDTVMCARvJ94hpoUILheSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntbv9X2dnhqsM4gSaD7Bh81V5QUDio6wjI7ASpEoK9wefKfvvFMcR5C7CGeXQLj2w
	 outdVX9Bheg5NH1DiVp4HDyAfYegyv5cYTnwWm2KOT9PwCMHSOzNiCLrg1pSCALp7w
	 QHwc0s/KHoKORDadhBus7RL02H+cgH/b72d2Bbt7ZYn+TeZq2BvC04PkztFKEt1+U4
	 X5IQ8NwH/YufGDhCIAXlsMZcw8BvgmrDUM59Ps1fSzNVt/9XWt32FUdpvIj95+jk9Z
	 i5OiSF8po491p5Q4O5dgtG0GioEQBESL/RFy1+HuMFY06kyV4XOJpL+6p8yorqe0hm
	 rNZnVeg1aLN+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AAE780D21;
	Sun,  9 Aug 2026 15:27:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 738E7296
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 15:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59A4A40079
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 15:27:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xRSV0Gcu8bfY for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 15:27:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9CF644004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CF644004B
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CF644004B
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 15:27:09 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso1008130a34.0
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 08:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786289228; x=1786894028;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZuHCUd708z/4qEh/yZAnTeDTVMCARvJ94hpoUILheSw=;
 b=eVR15nvEcxFRHy/FGlZFoqhumtdxTzTZb6ellENAhx+aN65cImoarV4Nwc5LbwwBNG
 6R9yWitPkUOAvX9vGDVKF4/pE6mHd6D+rPyMzdGMYDTUpx0apK98cLwi3K9adLg1zV1A
 IlmQkN7LgW+m+QyxjX1/q3GsnipJUqOEX6H8XUb0hvv1xFmwFTyx4Viz8keAw3t8leOS
 IUSxmn+U56MNGY5Qq107sT8hL+XhcNMLS7S5RRk4afBB7lqsUeQa/FJA6EUk6jL30VVR
 OAWbVmWdMqNQ4SMSZDd23VCtc/HLsM0hRgcA7qubYa851W+5hWCAa4jGFbPtb9W4LnFA
 Tcvw==
X-Gm-Message-State: AOJu0YzqHlea13W6bnYvyFyAROg5EISnMgBjR/40iNq3+lV8k9YXVuJ6
 XNudnYw6YQ8ct6nhtm2NFXMYRAvhr0GSygUuZpj60+/lUUi0bGsEsfx8eZC9XK5CacA=
X-Gm-Gg: AR+sD107AT5jadfCU7gdxTAbeAQNipSLjlD1QYv2ogp8n2P+DNtd4Jr4OYgmV7LE7ck
 6/MVUiJ4/jaGa82akiZ8ulQSeBoJOEj6ZH7cvfqw7YY+loJ4151nr94JODI8Q5TVF/tDwSPAF3R
 23FzAl2Ew1cO7v35Qf529H9XE3NnQOmKMQRiMxqH25Ah6XpPlmn7JH97nS0Z8RIWXfYk0UB/xGA
 X8e+Z0tXKfqrnP4HpV5MSEfdmNuMpfgGXUfnzhQ4KPmcoicR8IoZQATyVz1x6YnJKmhEzlHNX8F
 B4Xy1LJsP7htoAGmY1TK19wbWM1P9UymtvMldrERZXG8Kn5dU7uQdi/6qrsI76TTrP5hX5LLkvj
 chTTsNP9e+KmulL6i7buPgV7cDUm6JfWYvMdY/eV5wk+/k38y+Pp3IVL9vDlSDdqCZ3CnIIgTHL
 renR4WfFnCuimbo6c8IS+En0pTLdsT5uUaypcLXCzWVJRMJaLTM4deqcxqj+PBDJEPa3mXqOPts
 f1PnyIEkg1xrgJQSVbEOzlqGn+WmFuW0269/0jgHyZMCf2b3B6mFcg8glNDGOKpCWBsjAhNmMyx
 nsTag587aQ==
X-Received: by 2002:a05:6830:6f47:b0:7e9:da5e:93f5 with SMTP id
 46e09a7af769-7f36c217e92mr3004442a34.12.1786289228476; 
 Sun, 09 Aug 2026 08:27:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b807227sm5441578a34.27.2026.08.09.08.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 08:27:06 -0700 (PDT)
Date: Sun, 9 Aug 2026 09:27:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>
Subject: Re: [PATCH 1/3] bootm: size the noload decompression buffer from the
 compressor header
Message-ID: <20260809152703.GF394392@bill-the-cat>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260809042338.63397-2-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mGDHfAjpMSgXBdkJ"
Content-Disposition: inline
In-Reply-To: <20260809042338.63397-2-aristo.chen@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786289228; x=1786894028;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZuHCUd708z/4qEh/yZAnTeDTVMCARvJ94hpoUILheSw=;
 b=g2DOubQIDZD3+LjC92Y9nSieKInZgdyZYu1yMy1SkukWyGFFN7UWX223mSJsEIVXjM
 hOj/bjQLLn5o5Aue/4SNOhLINIMhWZ/X6lwkABiB1CxHfZtSis1o+U8EJf6MWyGnLkiQ
 ZrLNdkkU+qqPnRX5kpEF8sMzPef3KjjsyjkmI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=g2DOubQI
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--mGDHfAjpMSgXBdkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2026 at 04:23:27AM +0000, Aristo Chen wrote:

> For a compressed kernel_noload image, bootm_load_os() allocates a
> per-image decompression buffer of ALIGN(image_len * 8, SZ_1M). The 8x
> multiplier is a heuristic: it comfortably covers what zstd and xz
> achieve on real kernels, but any well-compressed payload (say, a big
> run of zeros) can exceed it and fail decompression, and no fixed
> multiplier is safe against arbitrarily compressible input.
>=20
> Read the real uncompressed size from the compressor header instead.
> Add a small helper image_decomp_get_uncompressed_size() that returns
> the uncompressed size when the format carries one: gzip ISIZE, lzma
> header uncompressed size, lz4 frame Content_Size when the FLG bit is
> set, and zstd Frame_Content_Size. Other formats return -EOPNOTSUPP.
> Bootm uses it to size the buffer to ALIGN(hdr_size, SZ_1M), capped at
> CONFIG_SYS_BOOTM_LEN because the value is attacker-controlled, and
> falls back to the 8x heuristic for formats without a size field
> (bzip2, lzo, xz) or when the header lacks the size (some lzma or lz4
> streams).

Have we gotten actual problem reports? This is a good bit of growth for
a problem I'm not sure we're seeing. Thanks.

--=20
Tom

--mGDHfAjpMSgXBdkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanicRAAKCRAr4qD1Cr/k
CnmsAP9g/qfbwVtN+xmtBcCpJoNuCryHiFEO//sUFNzM18cA2QD/bDAP9ZGiZC7J
Czh6NzGSc4yp/2b9ok0G9bceLEWE5Q0=
=CMAX
-----END PGP SIGNATURE-----

--mGDHfAjpMSgXBdkJ--
