Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC2F8FA8F
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BEBD839D5;
	Tue, 21 Apr 2026 17:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RNh3r0b7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7068383E76; Tue, 21 Apr 2026 17:03:50 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C5E80433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso696882a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776783827; x=1777388627; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zNBzr1nHdMj9FF2CdIYAHvvtvVKOScfzUnkjXysysVk=;
 b=RNh3r0b7l0UZ1BFxdWW81E60ZzIBAhLiFIINZ9oaglUoGS40/mGIqfKbrewooFZ/mn
 UAfPVzzLzZSw7ejsCrKSk8F66Gmdr1wrF1ciiva9RBJw4FmLNFhW+RvTXM+DlF4FjUaW
 bpDAScAo2H25AIz8nXsXzKWlEvBlWslOCEhSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776783827; x=1777388627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNBzr1nHdMj9FF2CdIYAHvvtvVKOScfzUnkjXysysVk=;
 b=aXUn+6r4HCHqiDfHmO+pV9aUVGHGUS2AFlW4hsnoiNyEh1tpELQZRSPZ9wAzHWIsO6
 VkgFDux8AH0m7ALvPBEuAm3uOEafgvVV4EanEHycZMeRlzNYPabfZUfIjwjiJ30jWaWL
 zKNcMkeEvtgRr4epPczgIfqVLemBBQnLplN0wc1VfAGewL3DTptDzQpX9sUZMi8ogIJW
 NKS+G9eL2kaatqzxlpXwHaCDSARlHh3ocvlWnpt+PkInzZkYLMism6/MSg/VpMO6NlN2
 ybrlXZLxZNNb+DJGyitAyX9uswYZPxu0jRSeNZpw+PI2+XY8qdp+9UjcfRJnEnbUr0uy
 JX9Q==
X-Gm-Message-State: AOJu0Yxx1VVwGnDPF2w6zEg8hv2klLolJhWlxKbxpVqkE8nrtP3FmH9R
 Edk9sgRuoebgLwO9IDEEeo2RB3XgXlhO0yGJbDHykwSD5ufzHawt4ozoqeOzVXY5t84=
X-Gm-Gg: AeBDieuHoIy4+eIJ6RjQjig/5HCJrUL1PbTo8LKqhuR+080xBZ6iGa1fFzMIwOaK1W8
 0fRjhKlxiZuYdlMu0FZFYzPWOlU5HTtewfYuD0Z+DPQatc3jrWvqCBEEeso3j2lTqMitA8/z+r+
 HkBb2NSx+cu+u8YLAg12h+J3KPAkR1Q1BwtVGTQjrs7DLaVZNdu+gXQnRkWX+MiXoihwxNnAgMw
 /mbQJB8r3jBUhkaje3Gh/VcK1GF9rd+Q+iETtwyHbBl5i89rctP9OMhI59olSy5IOyjeU5SfPhq
 u4p6JAFCxgrv03UH+Xwh0fDgk1QSHKYQxdhrN6C/jcM0f+0acD16b+Q5blwOG166NjjEs3fVOrb
 +fyuGSPKsfWu9jOaJgS9G3M7BY3UvNy4dbPW9/O0fO0inMlnyNoj6/BhVsmmoT/Rot09IXaQGrf
 h0iqmSgZnwpAFp2NZt3tAQWmOTzd9eS4IG3BOOwNxFuNtMdKElQxFKPIPFdOze8aOIwinre6D7X
 zbYFdnmFjp/3It0DUlbkSd2siDYVnGQJ1F8falUmo+XepiBRflNYcUPBlloOA==
X-Received: by 2002:a05:6830:3155:b0:7dc:da40:77d1 with SMTP id
 46e09a7af769-7dcda407a47mr1861345a34.26.1776783824307; 
 Tue, 21 Apr 2026 08:03:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcc892c515sm4496563a34.21.2026.04.21.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:03:43 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:03:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 3/6] bloblist: fix a potential negative size for memmove
Message-ID: <20260421150340.GD3036003@bill-the-cat>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <20250718141621.3147633-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ow5/coQfzD11lPIP"
Content-Disposition: inline
In-Reply-To: <20250718141621.3147633-4-raymond.mao@linaro.org>
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


--ow5/coQfzD11lPIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 07:16:16AM -0700, Raymond Mao wrote:

> It causes a panic when blob is shrunk and 'new_alloced' is less than
> 'next_ofs'. The data area that needs to be moved should end up at
> 'hdr->used_size'.
>=20
> Fixes: 1fe59375498f ("bloblist: Support resizing a blob")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ow5/coQfzD11lPIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeRzAAKCRAr4qD1Cr/k
Cl+SAP0UpRqMbYrYijM3vSdYxU6U9udr8IoMwb1qB1YITf88iwD+KS0rUJKsNbZb
2RHj7nCfpqI8yeD0qjibtZc9h1aRLAU=
=G3ox
-----END PGP SIGNATURE-----

--ow5/coQfzD11lPIP--
