Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04761C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 21:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CFE680E64;
	Mon, 17 Aug 2026 21:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37obLC1JD_Kh; Mon, 17 Aug 2026 21:14:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E92880D83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787001250;
	bh=+SU8ohAMaQE5q/sup8AUNZYQ/RpLQzsn9Z5VVsqU5SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g9Aq/n7NM6p7l7jMvSJrc5QhipMwzA56UujERA4vwfyc/0tIPhUpsPKuPQ9GUpJ9v
	 B585OZkxnJiHznb8CtNk/wgg1mmFtgNP3EGVuGmwDQW+QnZtUjhnpgw4LaAKLF2TqG
	 OC3QYGkW6JB0/GmX/X5virnSVyPsIFi4PdBc2tnk6IZ+en5k769DtVrh7YuCwaPC6u
	 iN9ImELdsjEB9kvUXUr5fY2KqO3ulkBzjjJdntLv5onOZHVu4vzncW68qEb9SYAPQg
	 wEoM1aqm8+JQjpwBLNsI/Ihw5TBLBWQOWFSGrPv0oVW8lOxxT7fd2me5TIWdBusmDn
	 fNLQJVTLV5R2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E92880D83;
	Mon, 17 Aug 2026 21:14:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FAAA337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 21:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 304AC80898
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 21:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKhDkzSyusFV for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 21:14:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 42D48810BC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42D48810BC
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FPZITugR
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42D48810BC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 21:14:08 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6acbbcd3798so3250240eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787001247; x=1787606047;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+SU8ohAMaQE5q/sup8AUNZYQ/RpLQzsn9Z5VVsqU5SQ=;
 b=FPZITugRFqY1YVki/ZG0DU2fBT99UTW1AhmHhkVrPY6PgcU9b+gZdr+44MS2gWTm1o
 I+779TujAwGNn+a12H8gdXAABxHZcHOVXdlfuGsP/Qr9MAFI64D3Ufi4psV0q8kGQmHo
 QdkxRogZetvD8Gbn9iBJFyXc7x6lhLgUtoO10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787001247; x=1787606047;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+SU8ohAMaQE5q/sup8AUNZYQ/RpLQzsn9Z5VVsqU5SQ=;
 b=Ad/BKKWYhydsuGOnJ8aUZ20sUlSq81sVQUtpfU7t+YTnUSmI16JzIkmJNIWn3YfaCL
 fb+6fpYpcIZFJrYLzQ9lYS+e7Tb+AtRQRsSEHuHB0HeYikj3Uw++ZIdXoVAgo8tGTnJg
 iE4a6Xkg9yzJDnyVQurPUHSkQZaLIgHJsXyGNYeXx/LK0orAEAPhvyKqV0xZGGb/WXES
 oFtB2hvDEZ08iSngBtLysGbBtjGLXhTeulGOHWOPDlrzrEGWL2OWhnpfinaUNP607Q0a
 aBB4lR32Y02x1u1S+QI/6ELGr35KIg0IBfBflRJXAgMMHthACArvXu2xNkF3zXu/08k8
 XmVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZHu5r4WoebhuCh/7l8y9UB9IwocpHkaxf/WAKbvYE6F9ahRVa+5RFodJNRC0ry1nccCPNWHc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzuyssphOzELJCd7a24MBovAnmbpJ5sHYnAQ2PL0tEBdjEdiRwl
 v12/0aZT4s0LcviFPjUJmYkVYTaZqhDEl2uY41SArK/NPhaHfPBaecQb0Nj8nUqsuZ8=
X-Gm-Gg: AR+sD12bUAOQ1PKwWZdomrMOwGfEW1faXG9zzJnOe+IjL4V9QAoVEju8r6txKNGL5A8
 6jUO6guWYj9Om64Ccz00IRkg+kGS2o11xJggtgkQug/RHtIg/VdgyTDiravwV6ooq0Q8Y+/fQjS
 vAbAj0Do1cljK9jZ6gKSfExSbdSLFbcBRgilVdBUGcgIC9ZbsJylhRQGs9zp48dFcpBCYrEQCw9
 8a1hsKVm9v4Q0yvOSjVCy2NPbadTvwod61hK5LaSzwVCBFojmveZzz9fOQixitciVLIWAx6HOge
 WRYTc+GuZOi+ZapExbZha84nTPS03fCM9e+Ml6BhPxumxYeCfSneVmi/DEIq0RQ+gsrFABwup1l
 BLp/PoTZYAoOO9aAfP/UB5Wjzlco8EZD+e2CrUjqvaf3KpRt9rA8q3hkYWWgohc9Tgcj1lYEehG
 VxmArZskUfx9sF8MrysjmGp8TEr2j7PFqWCznnp7GqpYugLVQ4RXZPoC6d35JOLdtfe/Vsek+p/
 l4swOsfHygYYDhvpwLxNXm6G0RJWw9cB5obu2CMzWQscBDPQjhtjLVtQLu7FpZNk8Rsozyz4sy5
 yqVySdDqOKgpVRuTXx1EXw==
X-Received: by 2002:a05:6820:8187:b0:6b0:566b:b8ba with SMTP id
 006d021491bc7-6b0d68c175fmr24144837eaf.27.1787001247053; 
 Mon, 17 Aug 2026 14:14:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1166fd581sm2676882eaf.15.2026.08.17.14.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 14:14:06 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:14:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
 u-boot@lists.u-boot-project.org, Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 8/8] arm: u8500: Give Golden panel regulators unique
 names
Message-ID: <20260817211404.GV3297518@bill-the-cat>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org>
 <aoM7BEBLYau0Y_ux@linaro.org>
 <CAD++jLm-9_Dm9es2kn2zfKtByXc_fY=sxWM+_c3Xu3So-cA5iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ol6uuKywwoHQW8j3"
Content-Disposition: inline
In-Reply-To: <CAD++jLm-9_Dm9es2kn2zfKtByXc_fY=sxWM+_c3Xu3So-cA5iw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Ol6uuKywwoHQW8j3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 10:36:36PM +0200, Linus Walleij wrote:
> On Mon, Aug 17, 2026 at 6:47=E2=80=AFPM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
>=20
> > I think it's a bit awkward to have multiple regulators with the same
> > name, even on Linux when looking at debugfs for example.
> >
> > Can you make this change on the Linux side and backport it here?
>=20
> You're right of course:
> https://lore.kernel.org/linux-arm-kernel/20260817-ux500-dts-fixes-v1-1-24=
379c6c2495@kernel.org/T/#u
>=20
> I don't know if U-Boot backport device tree changes? Isn't it like
> a scripted upstream sync?

Yes, we pull the vX.Y-dts tags to the main or next branch, depending on
how those line up with our own needs, and then allow cherry-picks from
the devicetree-rebasing tree as well in the interim to keep things
unblocked.

--=20
Tom

--Ol6uuKywwoHQW8j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoN5mAAKCRAr4qD1Cr/k
Cj2CAP9u+H4A96Xq9FDzNb/0dXLNd2XSKU2rKfXOLSwYTOKGPAEAkbRAEjJeDxue
tU3853omxQc7XK4U5eAsH2fD7LsWZgI=
=eI1E
-----END PGP SIGNATURE-----

--Ol6uuKywwoHQW8j3--
