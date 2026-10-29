Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m3RSECbY;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=HoJ3qsdS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D26534078E;
	Thu, 29 Oct 2026 14:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-RhBiV0Z-qM; Thu, 29 Oct 2026 14:22:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC2A140754
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793283776;
	b=BVWUi4RExxWc4V1sUee/MgAPuZ6nUlXuPnntgOwEyTGW0lhiLirR9K+p17hDoQVPDO/Y
	 hTxGJMl0BsdmCxJKeaYk20gpyhWGYgQCWuuxuTb9hCN332hBIxUpTJur3uHn4Xaog/IG4
	 xG3LuTXzzR5dkxO1nxjtHmRjYEWTA39GW3a6vUmOKsBfI4ed1MTWzz7viNZ+mWqToQPwD
	 nwuyAZrCH3wMQtRCcilGHRszg0zrzgqAfNrI+Lbm8bpinpga7W6K2P6NdW914f/WfVRnA
	 sUtRvfoCLa42+2KO+2DpveJ+HQjYZFJba/x+yXSjfJ2F30Cn7Cyn9Nhxv3FAojW3CBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793283776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6OQOIkqaZk1mGGjBx1N1SMhT/7yOuzgf2OQjaCHDXK4=;
	b=RyCh9JCFHzsPC1CFpGc4UmIaZFSRq8x1cH/8Pbp39Uu/jGGXylECWmjyTsFTQfi1xSgM
	 v19GG2RgSRFY4bSR/DjWgdA2TW/S2WcVIq29LtQy9+h/L/AQWSS1VHQdvKq9sE3L6lr3e
	 jQYKBrb3SP78zJIbKHkv/8JGsMVIjwokhsuch3VAjzdpvFGROd/ZVq7YFELQ6mL8DVTu/
	 KZg87gm044V8ytoI9sGHyictDhJHMIkkyOVQxoyIRrwwsRB8tPTufnLahE6/ivZtP0KtS
	 9TKxUMBSKFLd4vczDI8BGn78m4d/EduZbbdDtY99w1jYdEQkJiRJ+6R7qz/wp8hSHPA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793283775;
	bh=6OQOIkqaZk1mGGjBx1N1SMhT/7yOuzgf2OQjaCHDXK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m3RSECbYcc10VTWiVGSfw7Ynt7nerA5tZH6s/rwX26nlHw6rlwavBkJiGBDwtOL9l
	 Zqg1bDbnAzplmobGjsC3zK86MktJCCFoRA6Qq7yB1tCGGCR9pqkN4X9vlJGvYjuk2f
	 7+HgRqbfHBeqVYOSuGUdWjBdUhvShtpWJwYfxACAsFGtmUnuLLH/q+9dF80bTa+jwC
	 r7YEhljz+IoEP6qtwjT410G6gntXWe/jN9LqjMpI0TacHh1KTj5gLp5DG7DwX5DCZ7
	 eF/DEdu0E57tPANdI7gXt1AoOO6gI7znXhSkPtglHK76IddVqQWRosTPSSNKsipB3I
	 9MjirfZOUURiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC2A140754;
	Thu, 29 Oct 2026 14:22:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB1C9D22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0A5F80F69
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYNt-W9Bent6 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 14:22:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FCF280F52
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793283773;
 b=dMxi0H5mQgQGcWqxyI+imcMZ25uit+qL8eyvv1mxWaglvsmHGf7qsWrtic2BVp5kpaUs
 OKFmj8NEl6IjK0onbgzAY6FLjKi7ZOvDMq1r+nAttt+O6KlE/lWWitDzsais6a0z1Tkjk
 cSM5GIFEHL2eEe+AaakD0D4N4+DU2okRY/RuhfdPfi3qoKh3440WTYNov0URSOWM2uDON
 FwDlbIZ/aXwV5Ymqpn+iNPvuDvH2mH0qNaPQkHi2FAv9RL2GVngxf5DvDAkzy+9hSaY+c
 6fuptnWlwRdFpdNbeqo8TpM05urNGn09ypYgW9jLMzSkmr4t1AAvQlkY5Ib0HZmqdXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793283773;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=6OQOIkqaZk1mGGjBx1N1SMhT/7yOuzgf2OQjaCHDXK4=;
 b=dhEspWDOV3ixYbFgNab9yMF+Ne3j+IgTsGt+VokdKUt+gkZOaDJJRl1IsHFXKRucZjQf
 4lxqwM8mjVbUYCF4UZK++SI9UCr/NW+nx2M6Yfna5TXcHThzml/4F3Sn5S4eYpSksCSNX
 h5YHoQEqyVWV228IOgHCa4/VC2D5qseSTtKg5drZnlmdgRI991q343Kaxov0qljiHxZW+
 vCd1hnMXl7ulsNlshDXh3XJAz+1hGYpc6oU6uCzyKkzPJ0pwN0gRPGmqRbji1j/59Jw02
 kjxCxD4fMjveqwf4sv8dBogajhyy8w0MCu+5hxLKKNlPnQShVAyj8CfZxXmypntZD6Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=HoJ3qsdS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=HoJ3qsdS
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FCF280F52
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:22:52 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b0e21048f8so19540507b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793283771; cv=none;
 d=google.com; s=arc-20260327;
 b=iHkfFjVB+xQGdQSEFG3fHIr1yPjpLpa7K/ri/VELY66aqqzr9TfWCDj33q7UJ7IO6U
 2H2PIPdZ31ugzRBTkZ04OAvxpX5rhXVsdVOcri5MtAcNe66YGQvZoib4MFAVDHsHI6sw
 xIjhqRqzxePxu3lrx61ASgkhJiVYB/TL//GkNIus/J/BwBAM6GkCmGHWES+do8XkKi+n
 pxp2U9NRERwt/51cvj6z2Ck0hV8OrsdM56IAal0qjQFm8rfMSWW0xOgcWzJjGicIW8np
 EmeAkZFPeD8oLmhwifNliMKfdm+IiTGVB4TcwpaK8HDw3rlfyPcU2h2nnMVMYQ8IMMJL
 qhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6OQOIkqaZk1mGGjBx1N1SMhT/7yOuzgf2OQjaCHDXK4=;
 fh=X/FmW+Cob96yOabgtr/T+3xCsqQK+xNZNVloyjjtu10=;
 b=C1F5Zw20seYCo2fXQK74M+t7DhsBWIodrUvkNLVedOnDuHwQOHHznaxtD3t62dFB3v
 bz/4sC/KfvI2DqqDH1JLFPmUYnTLZqUcErT+6hiWgT0wJmaQym9hFOfSmQTLVUCyy8P0
 KctkyqT0vWgBc8OLueIGqGHhsEtYz0YrOoeVT/drHjcKBbDrIDJHyZctCp/x+hVR23l8
 r9M28jGGKcy9TMVopMwrySQVlG1mVFsCn89iz4hhznYhTk+0Bjr9VgRQamS4stg7/1QZ
 0ONnDQWYacPPbd+hoQHxiMnReLSqufc4kCbj0nHRiECt2xACPkrxaF14v3vcF14N5WGp
 l+Fg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793283771; x=1793888571;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6OQOIkqaZk1mGGjBx1N1SMhT/7yOuzgf2OQjaCHDXK4=;
 b=HoJ3qsdScGbXDSw/XN/GK8gjTdrUNVqzZDB545sDi/fKUMXpnArtJFGj9oQKCo3CjS
 68DboGS2Ep33adZ8lcw76bQw+M4Oa+D5qjvnw1yqEQbwVplamWnUsTlZ41/zS0Rzaxd6
 O/+aWRCVb4nIkzB24yfhjjSZoro38VN6l/88yway6mZfjw+a9hmt4JsmpHmN9m9WC0eY
 oRuFiuiCnuNoilL/lGA5aCvZdDA71FvW/8HlqunYLEOb8WqVSzgywD8ElxZvfNUQfaTf
 rrfJklRmAP1ocingNv8uTOQCA8GegQyK7wWrFerQypMJ9kV/4POMDYjOSfOj5H2Bkdn0
 6Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793283771; x=1793888571;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6OQOIkqaZk1mGGjBx1N1SMhT/7yOuzgf2OQjaCHDXK4=;
 b=1Zb0tscyGd/+8p6usJqwJgkfH/gJCsrMiqYxRENlYxchj8iFJH8SV0ws1U+qoSa32l
 tSfH5fbvNNKxYCgmjUqC/9h53FOB84cq7JY/n3/X60WfZevsMX6+3ORyKFG/gXL0+0S+
 DGlVQVKuZPKceoN9cAFvPo7SiQNon8amdKyInsi5PN9SOVhypvlSbf9tz/eBTs37XP8U
 7WG9O8nZ89JR8QrN3SS404y+xBTWxV8/CvGJxpvCuutKQCY7Bi9Ecy6HlG/Fyx+Ie6WB
 knIiptuG6kPNhtyXuQ00v96MUXSpwiXj7D2BEk62Q4Vkukmc6FMKA6ZkrG7EDese8+ql
 3eQg==
X-Forwarded-Encrypted: i=1;
 AKwUvByqQ5cgDsXRwgRZ27+69/GRhPLtDYHRZRv1wLJkm1+YFZGlzQtB4sOF1lr19870i7bBkw9EvgY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJDY0xs0DIcqo4WH+Fw54RSvZPuvHjlpSLd7KvKMseKAY+Y7vVM
 mGmQPcn5srt7tqBdS+/6R+YUfxLTQwns5RW4ddLtSKWawsUXYBFKP1SYX9Wlip3wYQzhzVldJrG
 8Fnk5DuZV5iYE+ndrWeaJHEE6sq4A3ackZU7HsRvt725mCDayNt4BFf4=
X-Gm-Gg: AYBFou37+PXUkQW4xBiI5CSLlsNvKV6QreI8jqK4TDskF32C7paqhodqdENR6mtvU08
 +YhJSSmpHj1R93W71fj5ShTnuYpaexfB9Fbr+dHEc+SPpfFLg3N1+u23di/lSEQnY9yXiRo6eEN
 5K/hdi14dQOuvH96D2rGAvVnCJJIKJSf3D4L3FriuAkqD+O8MD0uLC5a3xDcqHqt42bjS2ys9TO
 KQ1Lp2UT4XYYKCXRtgeUzKsmoe1id46SH4I3iYISOSDUfhavBT4v0JK+zWdnJAskcZuMDiwHZbz
 hMz9Z4irUJAL51IfDg1nvHMD0YaPMqAoxM/VOAjYuohAsXcJp2VD8SHglcpMiP+8Ru2oX7rhSgv
 3iSvEBdjw4rdAUP9xnuys0y9hcnwNNtORSsF3agSpENQuH7A9pojrPmy7CApHbJv26GvRhFzal8
 BsnEEs4kihnQy6
X-Received: by 2002:a53:c1cb:0:b0:679:a438:f0b2 with SMTP id
 956f58d0204a3-67a7bc54c22mr3291747d50.16.1793283770697; Thu, 29 Oct 2026
 07:22:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028184526.1887640-1-e@freeshell.de>
 <20261028184526.1887640-2-e@freeshell.de>
 <alg7jxkvt36hyizau2ory5w3u4vxpxxrdakxbijc5vayxfuu5w@gn4rhdoofozp>
 <d4fb0fd4-1452-448a-9889-30495e8f5b77@freeshell.de>
 <DMH42XA23X2U.VK02RL7ED7O2@linux.spacemit.com>
In-Reply-To: <DMH42XA23X2U.VK02RL7ED7O2@linux.spacemit.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 29 Oct 2026 09:22:38 -0500
X-Gm-Features: AclHuK96hchUocS1HtSH42WkWwsoCGSTc-S5aWdGdbf8sQTIwN0tYwZM5eLeyTE
Message-ID: <CAEev2e_TMX_eg4jGPf9hQSKNU6BpU-Ke4RHEDMqZNVRBWyn0vA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] riscv: dts: spacemit: k3: override reserved status
 of mimsic and maplic
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: E Shattow <e@freeshell.de>, u-boot@lists.u-boot-project.org, 
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Troy,

On Thu, Oct 29, 2026 at 1:37=E2=80=AFAM Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> On Thu Oct 29, 2026 at 6:35 AM +08, E Shattow wrote:
> > Hi Anirudh, CC: Troy Mitchell, Guodong Xu
> >
> > On 10/28/26 15:01, Anirudh Srinivasan wrote:
> >> On Wed, Oct 28, 2026 at 11:45:05AM -0700, E Shattow wrote:
> >>> Linux boot stalls when probing peripherals unless OpenSBI has the
> >>> enabled mimsic and maplic nodes. Override these nodes so Linux can bo=
ot.
> >>>
> >>> Reported-by: Yixun Lan <dlan@kernel.org>
> >>> Signed-off-by: E Shattow <e@freeshell.de>
> >>> ---
> >>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/=
spacemit-k3-u-boot.dtsi
> >>> index 352e85e7de87..278b36acc79f 100644
> >>> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> >>> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> >>> @@ -3,4 +3,8 @@
> >>>   * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> >>>   */
> >>>
> >>> +/* Override reserved status of mimsic and maplic for OpenSBI */
> >>> +&mimsic { status =3D "okay"; };
> >>> +&maplic { status =3D "okay"; };
> >>
> >> This should be fixed in the DT in linux. I guess you could carry this
> >> patch till it is fixed in linux.
> I think status =3D "reserved" in k3.dtsi is correct and should stay.
> The DT spec defines "reserved" as a device that is operational
> but should not be used, typically because it is controlled by
> another software component such as platform firmware.
>
> That is exactly the case for the M-level IMSIC and APLIC.

The DT should be a description of the hw, not just the bits that linux
cares about. This is why I'm asking for this to be in the linux DT.
The changes that E is proposing here will have effect in the DT that
u-boot passes to linux anyway.

> >>
> >>> +
> >>>  #include "spacemit-k3-binman.dtsi"
> >>> --
> >>> 2.53.0
> >>>
> >
> > The upstream commit that adds these nodes as reserved status is:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D56f37e391a626
> >
> > Quote, "...Also add M-mode APLIC (maplic) and IMSIC (mimsic) nodes to
> > represent the hardware topology and ready for potential firmware usage.=
"
> >
> > When the mainline OpenSBI series lands adding SpacemiT K3 support:
> >
> > https://lore.kernel.org/opensbi/20261028-spacemit-k3-v6-0-01d984f60941@=
linux.spacemit.com/
> >
> > ...then I think we could send this upstream?
> Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
> >
> > Thanks for the review, -E
>
>
> --
> Troy Mitchell
>
