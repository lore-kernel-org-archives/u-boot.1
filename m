Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1BCCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D465F60665;
	Mon, 12 Oct 2026 13:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6qVcnevER2O; Mon, 12 Oct 2026 13:58:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1EDF6605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813509;
	b=kInMm4+u93V9UsLS3A73Bjq/ik8JWgtp6oktW2mSebDaFaSeeNeqOqlpChE3/EqPBvdT
	 6nfbIl/ZVrKd1irGvw7XoMiW9qhYg4N8dThgsu7xvY9TrJkl5E5uQ9mGo3brqh5mBhVO5
	 GO4/DizzA6Rkj37idj9BA8CGl44LxRa3Z/Kccw9V9psMEZ6vrwkp8t9ucfsSahH4/K8bN
	 qZ6YEQ5YV6Fdj0wkj5N+Kq7xYtr6YBXcEWVaoz29iTGB5VgWIJU3oWoeCnbcXHhki6czG
	 6FTxsKtBbr+KbSEbhloTJeLZcY7SqZ37BGj+S3uIE8yUNfjk5eaEs9kwTCh0F1vjMCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2pIrEdloQfCO6GB895dBukFqx+a5XQRdArhlaSjPfmU=;
	b=r+/gfwHc8r5YuFDZ6RhLmzhKhF5rNg4iS6zxpe1mkTTrbIk8j/Zd9WoDtSF+rkDIHX7W
	 B2X1QtyiAjRD9eeO75QDYlZWgjQj+5pVGcCfQebgLOtXRlldyBp0n14/Jz+iZcdjbGNyL
	 fX9ECr4LjRbaBy832BEgJmCkUmV0/mCEQ5nLA9A+MaKzCkjxboS0mjYuwmrsiR1GtWW3+
	 bxH5iH2n1Og41ZxQj3H7sGziqi99cbGnaj7mleyAGIBsFYm0++Y3cBHu6aGhsxHfBxtfZ
	 t1hzYILuwj0s2vCDSzrJJSURkXc2ECAiGHNuoQ/aOZUroF2/19BgNOh+Geh8/y8/Ltg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gqNH1PIG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813509;
	bh=2pIrEdloQfCO6GB895dBukFqx+a5XQRdArhlaSjPfmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MVXsiL1i1W5xdqIRz0lLM3glP/KQk61mrSWs6seXwNokh/79bn3Xr+J+DQ1R4Nodf
	 41+PXPyYo32a4mz02T8xzUbTUYj920UMuPPDbc5KtnILCX0s44pW44uL8hQ9dyWsJL
	 A7S3s940nEbWVnGe/pi4WKN77hqLUUeCPd3VD4sknEZMrxGKToCsyHmZj5eRACF/mG
	 VpgualFnQBFIRxDF4z/smQLpv+hk47e0rhaRIuGaVKCyy6BY4y7maFyz5y1+YONAtH
	 0/h3pI42HmUPtx3KGrmbk1JHK1CAtqJMepo0+ALvob/sEJfIBIp42I/Oc+cYi8vrq/
	 svpGnwlDvP97Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EDF6605ED;
	Mon, 12 Oct 2026 13:58:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D03D2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 438EE605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUgmsbj9vQyY for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:58:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F9E0605CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813507;
 b=q9Y5CBLVsDTQhCmCv1sr8ACDdLINkViJMzzZutJhcbCdMa/8ZDFBqFjH3UkcfUtwCPoG
 DaLDCD00dBGaSXsOPlM9SWeo2P1llzOjDho+uC+p5dCkjuTX1z8G4u3vXf/0+5gF7i7D3
 On5rss/roYtGNYpHLMGrBErezENP//MRQ9D+yrAKTP2co3naFUHZFx5o6Eu4qMPy4mBBo
 WCn9DfLs7u4S3D4FrtfgwOXOkBf4Rpu7mFl4AgMO037KijhegaIY3G/KlvlBkwtcNb+q7
 cKsIilXnIcJZxEQaQBD3u0lrRz2MMZJYUln4yFvQqH8G8gKUqnPHxsRpIaDgnndPLTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813507;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2pIrEdloQfCO6GB895dBukFqx+a5XQRdArhlaSjPfmU=;
 b=VaCOng3xLS9ojWCh9Hi45d/3j9M/1Nsev7MjjoMVD8FdeY9Er7sbAET4auWLGF/JSnY1
 5WvJyReI5k/i8apPUSW5n4q2hc1rscIzGDeK0+kI0AJfcI0SD9J31e1wakBI7xUugeTdL
 J1L4FSaLg8MHHWbR11aGQUrjFb+pCcWnY+l6KDSTxA/8rFaraiMhbhReDljGFq+P03gTJ
 9dBU8FwrjyEmjBveSLxKGEcy/G8U1xpzjv35gbe51zcEOlQw5r7fX1i+kH8d7/JHHzVia
 vAgQrhgJLDv0hNaAzrNKEuTpf1F+kOYXDt698OmUf5+UxLLXnHkA8Gmtev/H8i09d4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gqNH1PIG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gqNH1PIG
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F9E0605CE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:58:26 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so2563263a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813505; cv=none;
 d=google.com; s=arc-20260327;
 b=loQUSoD2jD+MhEknZbwQsdE5MIgSklCQ6zVCpwxilCpIHDaYczuS9XAwVsqZLNJ3bZ
 T/7Z4ibhCz/1aUS/ksOWDqvcrmXyUaDKYBonWF1WYq3vm6WAYQ6y6wgTQoMiDkKiFtlt
 CohWEfHIb2Iru9OhudEDklgx/t651ajNr9/l8lWoEt9uJbmdiCa9GIyGTHHhk5Dkdkdb
 mh80sS0lB93vevLYgV1xM8suh/lQnNZ/OORlcSNpqmsZOtfVAyPvUJs0J8TPcccThUVS
 w9w3l9Rtm6chFP31KFkwbTSr1NJextfEzZP+UGP1cvn+YN+5JbktO4nZC4pM9OAODrF7
 AG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2pIrEdloQfCO6GB895dBukFqx+a5XQRdArhlaSjPfmU=;
 fh=8kLy8Cchkv6HU01zDgapzB4SRbyqUfaRhLrjroAK5g4=;
 b=VrbRJdQs9O51JfYX6oK/pc/KWzhrWuNh5imjKvYv2doCuTwaUrdXgpeqUOz4iLrqq3
 4Wjjd1/t3DVBL+S9OGFBfpHwjlCAaYWZbNoySvRlLOZvlLo075Zs6tXQE70uAYwwD77r
 e3+/VWHOpjPhK4s0xvBzIVWsN38xWDuIXWeI14HGKbGEt56wVqnoDLroBm7PsbIXvhfM
 yfqQLH/894MXkKUGHe9haxyEVKO179tyacFOzgT6GCwhAz2NXyqxOYGyaOmXtGujti7r
 pJCwNe6WcY0k3seneCS+/Ae/I0VjLfzJic5StS3Djasv6s6ZietTdxuqayM7H2V9TsEj
 LnqQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813505; x=1792418305;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2pIrEdloQfCO6GB895dBukFqx+a5XQRdArhlaSjPfmU=;
 b=gqNH1PIGqLgOZb6dcECY1vI/7XBVXNsgkvKjbBvDwPj4pXXLURfD7snCcCF2y7mpBC
 PMFPAsTk89ypeYJZx4XT4WskhNZ6eN6zWqa38eThRD1Pj2U7178ya6SHY8fRae+hVH39
 ZjuxbjB3YnCBzEdmDQQhc3LJNahTBg1laIWwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813505; x=1792418305;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2pIrEdloQfCO6GB895dBukFqx+a5XQRdArhlaSjPfmU=;
 b=LKBEhNcJl3CFWNF3tgYxpmPoNHPhJwuijqmDbszAQM1QumxNhiRqchCtDuK2yrzIWz
 sAbJzPdLSt/IZGTApVe2exVvr55bzvVUSHjnVNL4IZoOoaBfCpY1plFDUXhKYgbcbEtI
 xTmYpI9OAy4qxbibkCW/awoAGtNEj1vN8wYFYbQ8WIWNtOqbCTJddyDECAMwnvvvui+q
 gG97oCS51WbN1xQ1yWv/AX0uJy5NcZ0zDSgL3IRlwbG6/66NurO3jMy9Bbxy6/sx9HVA
 dwgRoj1PvplhmH+/rW5zPGU/GhHe6pK4Ebt93Y5aV7TCp2KNyiiRkzHx34xciz9FDFry
 4ktw==
X-Gm-Message-State: AFq9FYK7FQJIDVxU59bZYUMV6WU+JSjIs6aLo1s9Hp5sMwdquHHZVbsK
 zcJaDDXyICXm2irgu7yWN6VdsiOI8JI4AdQYexHU7NmafvPq+7wrR57jEV0OZI56J68psMwVl44
 zJj9msqklkJtDzdvOyZXlg02A58mSu6K5ejbpQl4f
X-Gm-Gg: AYBFou2kju5kU3sU9bTQYlePXeyb+m3n2W/0DTnta2zY0ojon6MNi09oyeWpQraQz6t
 eSWF6w8brdJXGt9VBJUpJ0mfcZew1yZX70xZDYIzx0Zp98dY33wcWmcqESFDcG8+6XMutDY49N8
 oOw98g+VJhloN9jxGHUQ2s4P2soSH/YKQncipTX7RvcMgVWOUl3R5bHEXz/sutjEh4Nt5GEKFG+
 LZje57w/d5TkA4G8iKgdHynhKAjPwM0malD4NejeT6/fg47BGqxUUsivxtoeQmmYebB2qD8NkJM
 2C8fvSd9+/dbqTHiVFq8cbIZP1FevjJtgn4c1/uRqRVPP2AHPAQG/ZBGEW7Nca2oPg==
X-Received: by 2002:a05:6402:5191:b0:6ab:6f77:c4eb with SMTP id
 4fb4d7f45d1cf-6b17c27ae9fmr8285702a12.37.1791813504743; Mon, 12 Oct 2026
 06:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 14:58:10 +0100
X-Gm-Features: AclHuK_MSmwYzredZgReWDD2pfqF8ljTSRzYVEY7dPX601bPXx6xprYfU8jJC6I
Message-ID: <CAFLszTiS-jLYzOHsbgYC2HMiH_WN=oAjmgZ1=1TYbZULm8EwHw@mail.gmail.com>
Subject: Re: [PATCH 0/4] binman: fit: compress generated fdt images and use it
 on Rockchip
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>
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

Hi Petr,

On 2026-10-10T14:24:46, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:

> Entry_fit's @fdt-SEQ generator copies the node's "compression" property
> into the FIT. However, it embeds the raw .dtb. A FIT can therefore claim
> "compression = lzma" while holding uncompressed data and SPL will fail
> to decompress it during boot.

Thanks for looking at this. It's a real gap, but I'm not keen on the
approach. Binman normally keeps two separate properties: 'compression'
is FIT metadata copied into the image node, while 'compress' tells
binman to compress the data. The Rockchip U-Boot image already works
this way: the image node has 'compression' and the u-boot-nodtb
subnode has 'compress'. This series makes the metadata property also
act as a binman instruction, but only for generated fdt nodes, which
is inconsistent with the rest of the fit etype. It also turns any
value other than lzma into a hard error for existing users of
@fdt-SEQ.

Please can you add a binman-level property instead, either 'compress'
or 'fit,compress' to match the other fit,* properties, and set
'compression' in the output from it? What do you think?

BTW there is a typo in the cover letter: 'onl' should be 'only'.

Regards,
Simon
