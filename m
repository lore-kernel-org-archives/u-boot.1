Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72050606A328
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GL7kWZuS;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FmVErM5F
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 450964077C;
	Mon, 26 Oct 2026 17:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pseIBMjcR0a; Mon, 26 Oct 2026 17:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7BC5740780
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793035602;
	b=a4wZHRCXfdmwtlr/gIvoqdreAi/7qFw038sF6XRXCslo07CHrsjo5Ap/jgSmr0HeBt1H
	 w5KPLqnUbNWCvVpyb6KXTTjuMD1B2gvmdAKmiNzMbOVz+4GT2Ymd1JrxH75dAJEYSVrpW
	 NXBd8ypjt7gTLeRTBhOY8yLi7BDUcA0mzK4LyFY1NQm0G+wW6TtuYcRuTjtfpXdxptiYW
	 5In3wGC0NeosTGd9mXQCPkWl24ZKAbuqBE6GF9LPYaYhknAD4uILFTCnUI7R+CClTnqo0
	 GdiFNpOoK9rOy7N/1dulDIu2+K3Mhw358FBKAbfZvZYWuviIYNIG9tLGHBoizs3iHKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793035602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x6K40/JmwwdoNuZfpQbRR1EoRXpdft/DRrQCq/1SXLE=;
	b=oSqaoilIN/XI/6Gm48tiXkrDKiNXWZVRqUdpC5wQhgcYLqCZDw9xcdv6wd0VXF0Xdarl
	 OreaJQ66EHlT5FjTE6Hd50iAIK8XXsYOwMdDdzVjrjLEOqilN7+dHd2of/JhBqNWHNedC
	 K+nI6JHI1Qn2R2N8gKCLedOljCyRWr7Jjn6UPzmHL/rjh/F+ns6SXBObgbIqqp8cPRK1H
	 Bw7uLVUaX7aHVx4T3dUASXZTVrsz50+qMXUMXmFTJa/wYW0VMuc1IhlWnYnD8w0WtiAoJ
	 STpcRf75E1SLCrdIcKCGZoqCIc9uivPQ3xNfV+kSihPxmne3+MB1RqE0cuGH2mHiehA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793035602;
	bh=x6K40/JmwwdoNuZfpQbRR1EoRXpdft/DRrQCq/1SXLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GL7kWZuSHkiMOZNHjCVF1emXC0gvvAicaGYTxiogjqdNMwTuy23MobWD3DrFZouOo
	 5o7F5acSvbcJyt3clhi3yhHcmFZW5Uc5V5wzSCC/0dnpt4v6UIy8eg21o21onAltYS
	 7FJZFqviHmruJIuXY4JkP/y1yJ+gIprHuWx84hfa3wUr6N95GB5KCtUDPuugjtfzJe
	 cJAvWe+JR36i+P8YxZDu+fm4kpZvlKyxVcQQbov9oYuPSV9dzrPC3vPw+5yRZtzLkZ
	 TCW7SK0HCZNT16fFjnW8O4TewTXQ60ZX3n13BfDYglE++A9DgT4QgyCq4GSA9Udbxo
	 NX9Zub3Xn7ysg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BC5740780;
	Mon, 26 Oct 2026 17:26:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18D08120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A6D640205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xz1N1OSYKJxc for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5180B40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793035600;
 b=Fqe5/9seu/HDyqDwEyDJiTY0x533lxamw7A8zxSvNCs7NlMSeXgL68GFXLqFhuNnOIE1
 gINsnz35XeeAgNB8JBpkAIinjLV21IdzQ7EEdNlgrhL6b0Ewg0TO2ydWr1JVJlwVNL23/
 Pm8/LqeUyq4QwMFKg+4Ui41we7eQQqus6Uaz2CLaL9lclagHwgNyL9bQSgqOaOv4w9e0S
 ROjp2VcnqyZdQOSP7vBIFZLd0oLMIxlkynpk2vGtHtP9DZaFX1h59AdSN8O3r+Ie+MEoD
 CcfaSQHcQbUd0M22YIgketuNNPSL6cmf01TWv6I+JpgPwTaDf6X6Q0uM5oT9pGaKqQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793035600;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=x6K40/JmwwdoNuZfpQbRR1EoRXpdft/DRrQCq/1SXLE=;
 b=THrp0in2jgyK+dv69mfRAkfggRCOiSlrdF8HrMle7akTylWWxjhzaYGyy3fFVh5oEHLM
 g34Gsic7t4flNu+8SgjP1apOkxfdvvQ6ZusFHB8mEHj5n8fSNyqgXQYzes/+NScTn/omG
 V7yKnD8GdlKkG8KH8er3eVbBIZ7DrKhE6UHhGjysGXgJUujhWM/FmzjhpLYkBFHxHTHLS
 q+AtGUzVemm+uNmuJdinxETNk3sKeiKMMVtiKUU87s2zsIuh9DMf4u9OOcgCSrctVYGi7
 OikwhmgXZTpHZ4o+7/vRbDRxRbBcicJES+nbOGnVHDeqTDl0F/+FtFzJWQksS9TC2OA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FmVErM5F; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FmVErM5F
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5180B40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:26:39 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-84e513877a3so120954a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793035599; x=1793640399;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x6K40/JmwwdoNuZfpQbRR1EoRXpdft/DRrQCq/1SXLE=;
 b=FmVErM5FzpitrAA364J2xxg89oyYO2P43BJpWn2pRz02AtMHA0d7E+GDAjUBER5LzT
 QnnE39faG6w7IhDtYaD+ksiCImw1g1Gb0woWcRjHLwHdsj/IKJubOEUObyzbO+BIE9aH
 IrUuqZKh5mbYjMY6lzGzBiW8yrukU8DFYziGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793035599; x=1793640399;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x6K40/JmwwdoNuZfpQbRR1EoRXpdft/DRrQCq/1SXLE=;
 b=gfvbeXk/kamMCjBHFv7paUfVgukJVqKPPclke21lSt5Zz6x5l3IWhZ+mhutbyUApeV
 EbJNjmHBTr46FkpNbPeLZ1p852zRPTbIUArm2ZmLQA0gcMPUN4dJBUA4WL9dF28JTbt+
 vDBNHhg4mxrwdjZQSc/KUuxcLJZqGOi55+98XPYmGCULn0YePxEQu7Ic5DCGv7NktYYW
 uKLZD5TXLeJyj3SNPhlIDm8z+nYRpg5qAxybsfU2EEB9KQs6fP/kBZeG6ERegvz9TCln
 U55TWL9POiE0+1lwJZJc8xwnc37MGVZRR1XKmrh1dIBia0fOafDLm+/BvuoqtvlDSGMO
 Vp0w==
X-Gm-Message-State: AFq9FYLlgoVPg43xKc5hJFmcR/5jWl+Cx+5J8YB4vu/yPnu6F+Twkx2K
 ya58iK94Wkln3qvS6EdzhAsFJq5GPe6ou2v/IPcwZDsXgtMziX7BHgMfcCdjX7WsPhA=
X-Gm-Gg: AYBFou2uFl2cv4SGGaZ9zueph3ikylvCPe8fFPtGYRkkLWRqrkyzUxrfzCjzZmN5CR/
 ni6m7mnF2sWbSU1o0rSsYWsIT0YHGRdZCL/AtWUBsRqsPWDsy1eEjQJfFLppaD3yMcwPmkkqVvd
 VWBtK1yo1kiCfpJaYPWuKEhv3cDdZSjY0d2jUGyztBnRAERuaKTXe07ho7B+jq4sqAeTU8QTJOe
 MHbdew+qO1MvzuY9wg1hFf8bo6yHeqRrWgXe6z1MrAwrWASeCMJtbzqQVjvJbUpLFu+KRK1KfL3
 bN+/Zwjma1oGRMVFj6eFplgQ6Ne4aQKg2H/2bym/RuLV668fnZHVll7XwsXxX/pm4KT2TAEhfSB
 2ueiONbuL2PBkdrT+9jOyBCzXiCVV5RgcxJS0ZnO1ezfXUjtf6vu3txPx1a0M340jjHTQ3C8hpc
 BIbQYo1QB/gja9zT6Gf4x0yd7dCRrvLTlJs/E2SJB2NhJ6LrkaLd7qvm5RhaktpH2V1hDXeLm9G
 mmgEDCJ+o8Mt3vTke9gmzzIMulVGRaP3g8bDmw7ECqlYJGIOU+zbxalV4vRYdSePwXSJEeo7gpH
 5ijmKsyr67fJI5SScR0Dkc4jT4eRwMJaufuAbtPq6LyPtYzr9tVcX1Mk9DBnqJ+OdzuBtG8CGvP
 E/fIJ7G1QM/1EPdbWft6eTK5FpeCBsB0ynQwoyzm/BUxTRwWtb3bMOYorgg==
X-Received: by 2002:a05:6830:2e10:b0:818:a1fb:8fbf with SMTP id
 46e09a7af769-85942f6ee34mr228044a34.29.1793035598265; 
 Mon, 26 Oct 2026 10:26:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fa99bd40sm8199338a34.4.2026.10.26.10.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:26:37 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:26:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, anabobillo3@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>
Subject: Re: [PATCH RESEND 0/6] fs: ext4: check on-disk indices before using
 them
Message-ID: <20261026172635.GF646438@bill-the-cat>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
 <CAFLszTifyAjp1ce-Gb=Kp=qciM+1__3QsLbj4WhXBm1EQyE=OQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rmb/gevldutfWeGb"
Content-Disposition: inline
In-Reply-To: <CAFLszTifyAjp1ce-Gb=Kp=qciM+1__3QsLbj4WhXBm1EQyE=OQ@mail.gmail.com>
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


--rmb/gevldutfWeGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 09:51:37AM -0700, Simon Glass wrote:
> Hi Ana,
>=20
> On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:
>=20
> > 6. tests in test/py for the cases above
>=20
> Not quite. The tests cover patches 1, 3 and 4 and the range check in
> patch 5, but nothing covers the triple-indirect fix in patch 2 or the
> (n - 1) / inodes_per_group change itself (the last inode of a group).
> A sparse file reaching the second entry of the triple-indirect block
> would cover patch 2, and replacing a file whose inode is the last in
> group 0 would cover patch 5. Please can you add those or adjust the
> cover letter? A follow-up would be fine too.
>=20
> > Simon Glass's "ext4: Add a few overflow checks in the writing code"
> > series from last year checks the block size and the table sizes in
> > ext4fs_get_bgdtable() and ext4fs_init(). This series checks other
> > fields; patch 3 adds its check next to his at the start of
> > ext4fs_init(), so whichever lands second needs a small rebase.
>=20
> Thanks for mentioning this. I'm happy for this one to go first and
> I'll rebase mine on top at some point. Or feel free to resend mine.

Please don't re-send Simon's patch series, there were some as I recall
fundamental problems with it and someone else should attempt to solve
any functional problems on their own.

--=20
Tom

--rmb/gevldutfWeGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat+NSwAKCRAr4qD1Cr/k
CtbTAQDvovaeSgu+jz7NuOR78KuGUHS+jlRt6XYUfk2fw+O1KgEA7uxuV+uUJXPY
B3sUbq0sb+/NiWGtKYEXiYRUjWvkNQk=
=I37U
-----END PGP SIGNATURE-----

--rmb/gevldutfWeGb--
