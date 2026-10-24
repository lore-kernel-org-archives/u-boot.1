Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFC606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xwdLlfs2;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AALLFgLj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A8FF817A0;
	Sat, 24 Oct 2026 13:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K81ZRszJAHf5; Sat, 24 Oct 2026 13:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 304C98177E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847016;
	b=RROYRtNIehvoYGyISv9v6EhvkFA+WEO1yeQJZe28dMWUXJ15/OQMO9lWi3cGTfyOOj12
	 yb3zSm3NvZpxkk6+pf/0/n4xZ4PKgRr3h2SgI1Q6h/ECkCnC/7bovQpHfbjjrZ7ImUusW
	 NtCF7+BF0pUmTP0RrYPRme1KfiZrCnSAxZY6GhXCgC2CqxItO3osIowbJhfpt+V4A7wLx
	 cF9Wb2KrXGLdgd27SamM/94LEaEbMbCtxNfZi3YlHGDcxNxl5LTAw82vivjmaAocFP+N1
	 GBuhKe8S0WalTRShl+Rtt92UGzqUWgp/BIwbLlP2tz+0KQBZQa1mt0lln4PAihqL6ug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bz4Mz4qN9lxsf2eK2lKhgcl/p4IddQfnHfFOxNb0zCo=;
	b=a+H3O3FhTt/ktmGHvd7K2nLDOha0ZRInLp+Qxjwvrac5eUEdfKSdbUf+6dHaT4V5ajLV
	 IkxnU5g8haj2+4o1YM9fKpr8H5dhPDZErIbNMdi5P+ahgMnLGBJ1diAMa9qcORayNnop/
	 fXur/wZ6YZZbpBCJ9wJ4IwK6hdYb3ZbX1q410VAsrm6AEglz3/KyVpZ9e9GXoBF819fdy
	 rw5+/WrWsRkdFO4q9ExcPAXkfK6nTYOyjmhSZea8nxtj2259bw/x/Lnf53od/3asX+wOx
	 cvxhal2vEm9bJbbM44LCQ4Y83nznNWivxy1ppuByTekueFGQxWSBkCVvfSFw5N05vQw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847016;
	bh=bz4Mz4qN9lxsf2eK2lKhgcl/p4IddQfnHfFOxNb0zCo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xwdLlfs2bmIPJEcl4KxBzHiVOPCGfDc850pE9LKHZi8Jfnmq8br5NJlhpte5Cdajw
	 5Ols+3OQ90IbvMySo6RfZhdgjkMW6rxHNg9EwV4TtghUCkbFpTh6wnXU2Nk7KxGbLv
	 Bf/hBkuGkF7C8Nm5R/pWWuv2pbZi5/OWvM2WWRCBbWNPyHe4JWn9cpAIRLZNd0RJcq
	 gsUSCxnYewBA0ETcqqualOhZrSNVIG3OYORjmF9gM0QIKm34Lh3YVk90XNdsVnhW6K
	 rdNj0A523HGGvvFDiPr49rVkDRNAk58GFmrSdzs7a6BVCrrywseMwY4EhYxgF8EAG1
	 HIMH58U9V7lIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 304C98177E;
	Sat, 24 Oct 2026 13:03:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57537356
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CA45400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKRNICucAqZt for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3635840068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825213;
 b=jzoOgByYnbtHcKWBukAx/jPzeErP07LePCsCHA4hzVgf0O7gMdrz9mpaNABwIqmd4fcA
 nSLuPC8YsEFPd1CukLBj5IVNtW8T13laBq5nCdslXqTQMZFImDmafAIbRlc+MHbvPRi0s
 bcrRHX54SnyDJY3k+AoiwJe8G78jVe/OJrMJ+SOLxkdKqA+850X3z7k0fGBbTn90QRDYW
 6ojR9nvWllhiEZn8nE9WK1PptQxf32z8TDOAKFzn9aVGoDSVHj2/f9YVohCDWSVfXMq3z
 DqJHO4xje07lHts2HIbxiAfqmvbf+uPNIJJhT6fdixyEStVtyYzxO7ryVtLJzH2ovzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825213;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=bz4Mz4qN9lxsf2eK2lKhgcl/p4IddQfnHfFOxNb0zCo=;
 b=GKpSY6m6Ve/sYonrSlnYqo9vW84tOMotrF1tYukNJP27NSg5DHPx5Ogzg4C7y1noHtuU
 pJyhHkydWdnCXUFti2yt1Unjyn7cW59hIswmIU+IVUKNImF5SvLI5ypT2SIlJSuaFZx5v
 ffbNQfiXhec1pJ+WD+4zeLmFc2CtRSw2wW9++Z4DBLYYHQFAGKcIeTqw4uTuBxPaecaVb
 o+OTIo0h9Qjy7hKKP869Tyf343W/v3cS5fgVOP5+vb3YhzLeu8va5slshgL9C21gJ7qNo
 mAZUxvAyDDO5rMajMSzAkz46VHBabUtVNFa7LRo2nbxsBYqXofuNZp3f3ZvtarcMyIQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AALLFgLj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AALLFgLj
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3635840068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:12 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so2491577a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825211; cv=none;
 d=google.com; s=arc-20260327;
 b=P+rw8L0yZwKgJHOgxBsxwFKLJ44mX3l97ZoAdOmbmlJQt2vx1KHj1yFqCxizA/EPMx
 Km0B8tNhJz2SxxGBcKiTzmXXgsbgH3czI6hzbDKjB8cctfUZa3vY3kyCZ+fneyQ8otAN
 LZHogJemvzmJgq8zcfJVaUpxN/NzvTJL9oDl/ReILoZtK/dcQn1ttdOOcco8pCX0RYxr
 Hb/2enPAoplrCnjygewGyHXFXt9PW3ade4Yaub7Q145ZLA2gzgsa09eiE8jAqHU44Pcb
 PPLXdmcR2ho2eCiUlWZAA4tZXbyYsZwrhHiSy1PSM/Lcxi3O337qB/mReKr6kVlaBjGG
 KJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=bz4Mz4qN9lxsf2eK2lKhgcl/p4IddQfnHfFOxNb0zCo=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=PKrBGldAVs80eWXV9Y5X5t9vEN2k3UFra0kT1h4qCQ2axd3tKxAhEMqkz83UqmqTUD
 68mLw6stV/ON2+W0W/brZ/Id5DQQe/yuhHBVBBCGdtNdkBdIwYS3MsScJEQJ/G5+8e1K
 Jn+LTKzOIDxWWA6IVUHNWQKE0s3FA7m6J/8GLI+yY/pYLYtS0xTRYgGMAwAooQ4VgMEZ
 Gru8eh7ptWgeQQlfxDOoQTxUePFFueYgmb2L/xgTePukFAbgqySuKG4aGq4HWke8ivXb
 Mx69fc4ErgRuCclvCJDhdPNMhCf7JOxorb1JEmrRUqXgC3H1dFVMt+AlEOXWMx1wE7I2
 02Rg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825211; x=1793430011;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bz4Mz4qN9lxsf2eK2lKhgcl/p4IddQfnHfFOxNb0zCo=;
 b=AALLFgLjAaxOgLglK0OPYphDJre7aexiDIZwBl08RMmEVDH0asnMp3j85Ubgudv1Fv
 OrWtdXs2//U1twISAHzjqGfThAiUDrCThlb73zZSGCq/cnBkus1J/FkczKrDV4hFk00R
 K+K47GRCFvWpOTTsfsQxS1FqQo5Tw2PNGNBxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825211; x=1793430011;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bz4Mz4qN9lxsf2eK2lKhgcl/p4IddQfnHfFOxNb0zCo=;
 b=Tzem6CugHnaEtbta0pZYesieC7/cr04FCVeVtZtwVFlrc0GpeEMjSpwEULrglbb8Yd
 rDtCq6jukQALMelm8mhSevj3FlWUQ6VmdWHICuRs1klsFxIC9vBPmdDbRn9cyisgeUT7
 p/MOZWc5+w+VdxJGZzRHfNETWzr2iS3WcYbQEzSUMRC675Ao79x9DJgkpPLR4ehpS0ac
 fWK4WAVotyy3rtTddyoT5brezbUWYQfAwcuBVNsNphkiFel6ipU9tE+rku0wIHaoAwq5
 MuzEHX08n8j3EIuGrcBbGcmlRdgigB8PXyKWo8VjzbNhlJ2uM4ZhHFjqd06OIS0Hxxkn
 IS1A==
X-Gm-Message-State: AFq9FYLCvoEbP44ssmCvPATkGbej/o8yiXzI40ML4pfWCcRU433yhlRr
 jG63LGo63DhurqcVwvZr4/SbYDSq2Xx+S3oCFgvKP+Z8MYrWNrVaKi7dWmfEJkp0gZ6JLPzGc+N
 NdQSE7G6dm/jCwS4BsDuShrHC7j6ucCRYXEw0Wdza
X-Gm-Gg: AYBFou3ez7hkyLAJ0FD6MuqLquBExW8P983ZqexaAIGQs5bIyrIx6wmhNFTQDths0xJ
 siFLou+omVTUFk9vY0y5QdrWG8tJKq3rKkBsJybmfA5+8LQsmXATQsdnY/hznSUKASe3qqH3ZiR
 Dd3q4BhK0FECHWgNn/knkLeWJXCW5ZluavcMAyVXAW5m9CCI45BSapeAKeaDqtc+7FG0AvVUqV8
 ZOmqULxdSW/ahZf8c7DnEqO28sJaoee6TS8mNXuiu4o6zysDFd8vNR86t3OqFQUkNgQ22Z63+fV
 Z4CU3PNCMgfpbzLUUcJkEdapdQsw9v9PhbFMfR2ec234qZ4HshA6BSS6Brkds5cx/THCj8sXotb
 Q5GE5tm9BRwupe77sXXI7ooF1t6JhY6pJfIg=
X-Received: by 2002:a05:6402:c513:10b0:6b4:20bc:fab with SMTP id
 4fb4d7f45d1cf-6b442fd88damr963767a12.18.1792825210730; Sat, 24 Oct 2026
 00:00:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:25 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-6-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-6-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:08 -0700
X-Gm-Features: AclHuK8kh3PCTSbbsRHvaqPJ6dDTGMXf4RapCMFXyfGSiuVVmA_ApjUTJxTjmtM
Message-ID: <CAFLszTihR9TvUrQY+H0gsa1JftUoSEeR0nDt6wHtMvT50Woycw@mail.gmail.com>
Subject: Re: [PATCH v3 06/23] lib: Track whether a phase has a decompressor
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> lib: Track whether a phase has a decompressor
>
> spl_decompression_enabled() names the two algorithms SPL happened to
> support, so every algorithm added to image_decomp() requires editing the
> header. It also asks about CONFIG_SPL_* from a header included in every
> phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
> wrong phase.
>
> Add a hidden per-phase symbol selected by any of the compression
> algorithms and ask about that instead, which also matches how
> image_decomp() gates its own cases.
>
> SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  common/spl/spl_fit.c |  4 ++--
>  include/spl.h        | 10 ----------
>  lib/Kconfig          | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
