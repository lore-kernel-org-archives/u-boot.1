Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF5606A335
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fXaMxxzK;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pNB6pUen
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BE9E40519;
	Thu,  5 Nov 2026 20:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CbbKgSGcKi2v; Thu,  5 Nov 2026 20:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 84FF340528
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793910370;
	b=OPsuLIjNK18ne32YieuVislokqig9joS71GhO1GmOwTHFdsYh6dY2uX9h1bDmxAfuyGW
	 wdSTzMmnI9nL0CTT+U84AtgCaLOFRsdOh9OQH32OHxPZ2z6N67LYo+XKm0GNXmZmTlQq0
	 Y1pARRNJ86hw//FNLKVUYSrzkjHF5KBpPklL6RiWVrKbsZs6Hs0lgt44n+5hqq4ycxUEf
	 V4p5ue2/ZrSqk8dOWEW1RlKksUvP+M9sLWRQV6C8IN/DNRKzxSvmboXaM79wZ6Y29eu0Z
	 GGcloEG9Y5NX89B/GaiPVHiQup0giZRRpgL6O//3LP+kXoDxOPGn47rJBXW4qfPuxog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793910370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tSs6rTHBo8NtWlB+C9zFSAtoU24n7fwQuSREy7mYbVE=;
	b=ijkfSjYgPaOFCxVwkxnpAwqAPinaRaaJZyY0Ijw/poZPcdZOXTTVrCiBPV90cGJ0+Mif
	 vJ/F23A8ER0vFodWeqqFODPLgKrVjrBi76RhYmOeSG2sXh6W65Cc0k61kd6jJBakV9Q6j
	 7noyIN4IWNO3YVlPxkj+WdXy9EMwjLaQ/gqrMfTKRyPl2YIsljas01UpW0EgsVfNhAt4X
	 dEUAFqmcAOW8ri8Bz3ybqtvfibE+NGo4FgKIDWLWY7TTqWH17CWhvNip69hDPPF/4ASMM
	 cUl1v6R27Xft5O1NLUjwecUNdUotn4PedcsuhfKdbOhqfn/YFMdhJaUi+fkBB5Y0Ocg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793910370;
	bh=tSs6rTHBo8NtWlB+C9zFSAtoU24n7fwQuSREy7mYbVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fXaMxxzKzU/+m/FmmUTDgkMPpM0pQy3NTkZaJPJg9ZNDGFLrN8OvL8SbhKdJ1kjVy
	 XPh/QZ5xxewuD+dUGLByM0Xo4SudPvo2qY6s31XkVO1n6na5QQ7OzOHwRMius0eIQV
	 iql0iA05E5B9YTejtRQOWO2EMXVXZkv1FJhgdDt0dA5YAzMNwSFGDThBbABZOLhOH+
	 pL3D7OY7Mjf9q1tln3x+JdCFT1REbiST8WysYkmx4+DobDEo3UhlkdzkDe5CMcqhZJ
	 24nvSRchOmx8UotbWcIvEXI32ZmqDAtZ64VhXHpukRKyhve84EOalr4YPR6bRLLL5h
	 alGhVWHVq0Xzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84FF340528;
	Thu,  5 Nov 2026 20:26:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 907F3F07
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 20:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 761388119C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 20:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDxZ8QmhC2j6 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 20:26:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 94AA18119B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::343"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pNB6pUen
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94AA18119B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 20:26:07 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-84e513877a3so1067292a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 12:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793910366; x=1794515166;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tSs6rTHBo8NtWlB+C9zFSAtoU24n7fwQuSREy7mYbVE=;
 b=pNB6pUenylTpCsT1ImltO4dHmamIskm88ZJlJ6yKKoUcj4YQUQGZTX9nJxeFyPEkn3
 isfoO4G2FcOBKktJFhVdtcwyi5HrrAYz2l89O/zPPC0FZo9XcjOH1yOqe6E+HqZEQEeA
 mLvEZt4YwZSnQkwhl4ENNGDlyLfgmUAmBzk3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793910366; x=1794515166;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tSs6rTHBo8NtWlB+C9zFSAtoU24n7fwQuSREy7mYbVE=;
 b=nqft4ngBSRGih9O6d8GAvBVewflod+eUtaKUGAxmH8KNXz6uiuW6Ys9RyuG4h5P/P2
 bA6tmG3Ry7WX8BapDUcSI9KdoNIzl3gljek65g4xrolW+cAhGzXmAqepTpVeJb9Nuw1P
 gOItP89Wk/50qWALFvxN1Qv0rLjU+XEcamZYbADUJ0yPiwIjMjVEwDsRp5wPUhuK48no
 mYXYni5Ubo69Gcg3T3WRLh7N98DufT55olR0D5EfS+iNmSF9iTtaKTjs8eY1aa8yMIaC
 B/9pA2Dseo0oc6ZcWZGuCch+IVr0kUNXk1UClWfWUik0uRQ4ZHi16T6XQXtpj3mS88/M
 c1Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyYYJlp7Pxv+ctnr7U7rB1hO/L7P3r9J/OsPP3tly/oSQqo77x46H2v+o7w1mpGpcGThpIa20=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z80Kj0De3BRVGJITczJeb5byGesJn9tEqXaTdTHk7XnEB+4DNG+
 6O7D35VfnKD/QfQRL1UrL/QSiLY1QxnrKICJn471m9bSN//+oJ6K5sNViTurNQPh+ww=
X-Gm-Gg: AYBFou2BP92w+gmxYRWTJce6l9+VDy9pj6i+xs4zVvo9Hrf2+3C8/NMAKG43C1CEqHg
 ohGfx8j5YjVWVN7CO5AXkjC/Q5gAKD2Ds+/tZ0jrKtN66jd/kGrnmBlHrud1DxiQ1e+QY7o8mGM
 LORkI8nnIDd6POmS7foEJ5Z0s9XQjrZ7r9Oxp/F1D3E8TqFs7kE5Qr2kpPuYW4tWtueqD+Mdrfk
 uxdUAObSuz/fHBUBRH2LJVWqQd7Zexpt3DWrO3s+M7ymYXbcJRVd8Nipz6SAL/2QXwvea/uzuCV
 i1BrDII4NdjX5ANpDjKEzDuStGuLd7uDUzjiA6KfhVn1ee9Zl6VkKn4dTVdGBXaN8CWBKXxmGuz
 UDnfyq2Na0BJiTtfCwQd4jHhNji2KKizdblU3J3kctjkU/hhc+Lg7OpCtXf+qNg8fM5x/VaMode
 ZvjMbsxgX4Lg7hUsaEP6HfZstSCWDLf6SlOrnYH+OXj8+OYBcB3NQd/hZLrcA3zOCAMOOf59evZ
 pJTEZpJpKox6wpu1MVYftQMVQWybE5VwDSPZLg/oDaidKzw09bO6ac2rza8ZueTMeM5GSWdNtml
 IUbayiDGQr2XjY2KYuKJl14lVbd482AWDd4YzI62RbX8LGAENz3W1Le9eXNQLnDyBumI/+xtpNa
 B5322ZjGzBVdEqkpKr/oRMNX9xTeavXHZh/1rwcEfjNeYVYVwplJO22yQlC08px3t1BpmQ/m3Ap
 983Cactevc57jckCVZ5KDZxfV8unyDrw==
X-Received: by 2002:a05:6830:3499:b0:845:614b:eab9 with SMTP id
 46e09a7af769-85f0586344fmr2495038a34.6.1793910366050; 
 Thu, 05 Nov 2026 12:26:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1d951a8csm265946a34.3.2026.11.05.12.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:26:05 -0800 (PST)
Date: Thu, 5 Nov 2026 14:26:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Oscar Deschamps <odeschamps.mail@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] fs: ext4: bound extent-tree depth in
 ext4fs_get_extent_block()
Message-ID: <20261105202603.GR1164024@bill-the-cat>
References: <20261105131601.1854572-1-odeschamps.mail@gmail.com>
 <CAJnxHsjmgEOscHkzGO_tgh4_Qu4Pc-wQQ_==PZ0hLD8OPD_fzw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="waRtc1n8sEXb2o60"
Content-Disposition: inline
In-Reply-To: <CAJnxHsjmgEOscHkzGO_tgh4_Qu4Pc-wQQ_==PZ0hLD8OPD_fzw@mail.gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--waRtc1n8sEXb2o60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 11:59:06AM -0800, Ana Bobillo wrote:
> Hi Oscar,
>=20
> On Thu, 5 Nov 2026 at 14:16, Oscar Deschamps wrote:
> > A valid extent tree has strictly decreasing depth down to the leaves, so
> > require eh_depth to decrease at every step and reject the image otherwi=
se.
>=20
> This loop is already handled by patch 1/6 of my series "fs: ext4: check
> on-disk indices before using them" (v2, 28 October, all six patches
> Reviewed-by Simon Glass):
>=20
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D530226
>=20
> Its ext4fs_check_extent_header() requires the depth to drop by exactly
> one at each level and to be at most 5, as Linux __ext4_ext_check() and
> ext4_find_extent() do, so an index node pointing back at itself, or at
> any node that is not one level below it, is rejected. It also checks
> eh_entries against eh_max and against what fits in the node, since the
> index scan in the same loop otherwise reads past the end of the node.
> Patch 6/6 has a test for your case, test_fs_ext_oob_extent_loop: an
> index node that points at itself.
>=20
> The two patches change the same lines, so whichever is applied second
> does not apply. With git am -3 they merge without a conflict, but the
> result has two depth variables in the loop and the header check reads
> the inner one before it is set, so they should not both go in.

Thanks for explaining Ana. As normal practice, we'll just take the prior
series that addresses this issue instead of this patch.

--=20
Tom

--waRtc1n8sEXb2o60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauzmUgAKCRAr4qD1Cr/k
CnhDAQCW3WMYpfE0U4qeIeHNHHKBnZYf7U/QGkzGe2sVn1zSsgEAhwQil8UIjZE4
6zbnBnqv0ssgHryHJF+AVF5azoA4WQg=
=Apnq
-----END PGP SIGNATURE-----

--waRtc1n8sEXb2o60--
