Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2C2C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B5218328F;
	Mon, 11 Aug 2025 15:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="imrxypwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8849683290; Mon, 11 Aug 2025 15:59:15 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 624BC83287
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3e535242273so16925475ab.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754920752; x=1755525552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tb2kkGutcxqXitSbdP1NQiX6jaZQKa7IUzhkKjjrl7w=;
 b=imrxypwDKb4LGI7d3RvOR4EGeQjwQPC4ZOzGEfwXQt5+mAaSeFP2TCCicjMCi8A97z
 SzzAUaQ918E/+zJ8boEBq4/3MuVyn9+eKSn1teagYvAzrujdKiJkaK70Jp+pdavBLPOu
 eBVRVdgXyWfATK2EYkOoGQnNqUosPbJcmhbTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754920752; x=1755525552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tb2kkGutcxqXitSbdP1NQiX6jaZQKa7IUzhkKjjrl7w=;
 b=GDntJgyVj2TNdu6UQ0JYBnVRvwUFOKjgNrQKBmKtt7QPjDQKaqSipZvWHBld1pF2zZ
 k0CE615Dkh1WIFoouwIGF8l2YKLdPlV0sBZERLcmiFVLMmdJfzPsoVyA+x9V4yuzpLQx
 /IKGrFfN+30B9pGHcr5GRVEmuBsBjcF7+qVNEAH9o2ZrhimwvlMj1YHC36ob7y8cDCKi
 8G3LRDMwM1ALEwrKbIOF6pPjqALnDm5b06v5Iuo8+Y4OvmPQT/bIUPTLpVJe69P5MYDG
 0LJc6e3BPaL7py6rUr5Yva2VFeYGmC0oUUtWdUeC75Nqd6U/js7Ga87+024XSEW+7ejz
 n1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/QWDGQl1GbgD6j5KJughoEDyxfBk2mMZ8ukfMVPbKvxLe+IGP7P183+tg3mdZAcNTdnKGf5o=@lists.denx.de
X-Gm-Message-State: AOJu0YwHpizlLOybEX/vrrWzoSDM5lSYziyjD7wsneO4fmatYvAVn/IR
 /pZaveUhRViaKiNzBEwc1BRb3EBChMUGuV4q2hBKRoZhmvJCWM66I9Zt9AtnN95az6c=
X-Gm-Gg: ASbGncu+P59AyZIif7tML7JvPzaZXkjPfyg8ij34zrxQkeu+tJrWRgd3+hWiEZ/4RLQ
 cqyaynHMF6dg0XF3HkDCU44rxVf/u95azDgxN02wYT7r1d61G8HiNXfu+g8py6ebyTriElBmTk4
 LXLdEtr5PmH94OSRYqeQcO0KrYp+RSLK+F9kaFYsf/Xk9ysCLeV+Ri/SVdzlDW8r4mwWjxaQRMe
 7n7fRQ+OHNpGL1coKFP9I0IXYx+ITs0zY+ClDZIsNrGxbw69iAHWRYrj21BoV+3rfsjvvsr1pFs
 esWSZL+vyXMEjsCSR2MpjJaIsPjn3egUJ/1fGWiUv0Xi0K5ES/XxE7i7dC6GL6HVUUUi+6hYZSf
 BvNwa3XJK1m5jlaZCfxjC9XdgAYFy/aBSvmMkj6slq8opmQArf+qCtnRU
X-Google-Smtp-Source: AGHT+IHf1cMJlefjxnQeeZ4gEFD3AcyXZ6qLkA3ugmHR8xL15P8woPcF+Repk+Q/ixMovDilRW/tBQ==
X-Received: by 2002:a05:6e02:16c7:b0:3e2:a40e:d29f with SMTP id
 e9e14a558f8ab-3e5330ab6f6mr211763105ab.9.1754920751936; 
 Mon, 11 Aug 2025 06:59:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e5467b1d9csm18068235ab.39.2025.08.11.06.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 06:59:11 -0700 (PDT)
Date: Mon, 11 Aug 2025 07:59:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Day <me@samcday.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH] mach-snapdragon: fix erroneous lmb allocations
Message-ID: <20250811135908.GI124814@bill-the-cat>
References: <20250811104710.1896382-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xJoECE0UZun8mI8z"
Content-Disposition: inline
In-Reply-To: <20250811104710.1896382-1-casey.connolly@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--xJoECE0UZun8mI8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 12:45:13PM +0200, Casey Connolly wrote:

> In 6e4675b8e5d8 ("lmb: replace the lmb_alloc() and lmb_alloc_base()
> API's") an additional allocation was mistakenly introduced resulting
> in ${kernel_comp_size} containing the address of a second 64mb region
> rather than the actual value of KERNEL_COMP_SIZE.
>=20
> Additionally, in b40d7b8f72f1 ("Merge patch series "lmb: use a single
> API for all allocations"") merge conflict resulted in an additional
> 128mb allocation for ${loadaddr} when CONFIG_FASTBOOT is enabled, where
> it should actually be set to the same value as ${fastboot_addr_r} to
> respect size constraints (and since it doesn't seem to interfer with
> any bootflows).
>=20
> Fixup both of these, freeing up 192mb of memory.
>=20
> Fixes: 6e4675b8e5d8 ("lmb: replace the lmb_alloc() and lmb_alloc_base() A=
PI's")
> Fixes: b40d7b8f72f1 ("Merge patch series "lmb: use a single API for all a=
llocations"")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

Whoops, thanks. In hind sight I should have cc'd you as well when
merging all of that.

--=20
Tom

--xJoECE0UZun8mI8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJn3LAAKCRAr4qD1Cr/k
CkAiAQDg7JCk2gkmG6nO3oCVkyUUrjCn1GNHhTmKrA+k1PA45AD/Rj34dtN5S0J6
BW+b90Ky+iSOJqzpBuAR5W36DtEG/Q4=
=cvXD
-----END PGP SIGNATURE-----

--xJoECE0UZun8mI8z--
