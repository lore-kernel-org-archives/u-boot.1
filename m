Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E76CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80FD580D84;
	Mon, 19 Oct 2026 09:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y85iPRdT5n2G; Mon, 19 Oct 2026 09:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C758B80AAB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401835;
	b=UxA8cMgmdV8Su7KersTW07XJQCFHWpXfhu5OmCKP5rdQYY6p+U4oMOQKcCDfg7q97SED
	 L/5F5KBzkFn0OUEXeevipELVcS284v9g/d61esQStlHtK9zIph7qwGeNWVCV8nLsCI+iy
	 QQhWgO+eCq4ugnjOumeymQEDQ0X0wbvMTT4/PZgtU/7T/8HRUEvjTPGiVdjGDsJEbMbTF
	 Emu8tpWjL6T5PiIsmMavzLLJLVzc1ZJTksJ3Qhop3LXQxI6geQfo/dShcxCgNa63GoO82
	 hnrrH8D9gNpVQm+Ti/PbKJsNwe3eESxKyDZwZIr7Iw/n7mVElInG0CQaeSZ8q65ahrA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DDwUxzG8DBCBiTyl0kMXduyF3L0hnvzA+O8veYLZadc=;
	b=b6lSILvVGCejOlVd9JoC9kGpdA3bF22rgpZJB/j3uitcuCge8UGBXhPHZiKG5GS+D0oi
	 2xH2HxCdVj3VMqIS6TznzqjLePe3afUSf1PdfzyGXMWr08ZmyB5Itf4vSdNUrHopI3dsJ
	 8GC9BWR6qjO27vJxxum8+S/idpcVErgGz1LjnNNM6RTMCjXIQQdnLVGjrD2qkn/W/+66G
	 iaZKw7F9ZyI4dA2h/tOIus4fSEB6ZS4GwFhsKGZbcpbZwUU28TSY4x6yKSGW7rxMuPZ13
	 PCsX9vuawFwraNDTSubtAcpEwM5nTZKQuZPF7GPoi+QAp8thNV8Tfa1ArMiGXFrplzA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401834;
	bh=DDwUxzG8DBCBiTyl0kMXduyF3L0hnvzA+O8veYLZadc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uh7ZZwJJ53Ijfpeum6vxLtKNQv9CtfxIYZhaZVnMmDztdHjQZrofwdLh4U+B0X5os
	 gOqdxPjH3ZOhrYn6BwPSIBh76j78zAxcVi37nKDeTtoBkqJVZlLt0tZ5A/kA37DRpM
	 Twu01pyPs9VWfLtHGYoMvRnBMPksJPkf7WXBs30zPwhx+KZ49/sSR/WmnShyi3rLbK
	 ktTa54XPn8x0MRT/MHdOWAyT1W21pNPDi1q+a1wBHTetaBd/bKvpIUvF3IdMNt8UnK
	 4v/yvugAjNVGu1kJn85WOFKLNqrryK8ouzRNifWVl2+NXm5ZALFSWyPPDK54vXdiej
	 lwmCDB1shRbSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C758B80AAB;
	Mon, 19 Oct 2026 09:23:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F2792A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 452DD4065C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ywvo6qsKgllI for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:23:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A365640651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401832;
 b=ZlC0rXBUmnmYvHpAsHH1UOfvn7hqh6R/l3zv5K9wmjSNBdOUo3/P12BbrFAEg09qXO2M
 E27bw5dDXVZmMyj2ZjSW6C20o14DcE/XeSQZGWjwG6q/Q8fQNw4FDQyADIryYOkaSHpRF
 xizdpBuEPpT6zOJiDVBRns20WBnueNRq4TwwQBfTh61UUzP5/ssBctP224azZqjuk+Reu
 2UFOJ9x855mAnUdI6o6M99imI1IcafKB1aBOcwx1BJUkklaqWzt7zvFREUmBKYnSH2pIS
 7eaiUa+mlGTZX0x7EfQKIGLMqBP5vxJEFNgIkkVNizdHin00aMRJSe2qTIhSymgNw0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401832;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=DDwUxzG8DBCBiTyl0kMXduyF3L0hnvzA+O8veYLZadc=;
 b=lcAm3sclYiIevlUPcmOKca9vR4r4IkCc2jcJtuh5EUNTphS2u8cd/7EnC35s5YsP9b6k
 7xWSB5qufP0BjnvM7T0F9giUDwBjZki5ES0d0JSbpZRzhyLAGn6+zC+ZTqwpMxlxD5TEN
 dLPqgJIlvtfH/UaH3MQeOZ5MgU5bDjG5v+Mrbi8gvbeNJNYZsQUPADYxEh4DDR5ewEDJz
 n5aXy6dF6BGyVoMvTeeJcgmhOu7Vqzq69GSZ+hONC638FWPWIeW4ueoZGIInosLbcmJ8q
 p9mUZVw1EmtUkLQoiEn/ebmfVSGqepWRsJdiX6W2pSuEx0X0lrRCd9GuRcJUbkw43nA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dv4gCWBp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dv4gCWBp
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A365640651
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:51 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so1404732a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401831; cv=none;
 d=google.com; s=arc-20260327;
 b=cf1w4YceV1dL1+GCmKMIQsO9dSK8JI1uDfgd+/J/OEmwz48U+U2evTyvw8exa5Lasu
 AHqjgBFjxbuM5bYJL+OgwGJYv93t5x88BIXzH8qoAHZQGE+tODzJ7vDh+Lr305ET27BQ
 OXU0hRaAAWZ0uOhibhJYyll52qombodCEhx4Cr2xfQ4KqXGxzkBEzay5CqPaIxJ9JvdD
 4BDPu5tpLtxQTu0t4c8rJxUaw3r/noaHbIb9F5jy9Wk9KTpZW41HEeTe6h9voavGWAAr
 +t94RtHN10bgFCGzSfyl0hY3mF+yFZRXbepv0W9q80QUFENq/5kDPDiTYpqQZx+iTz+7
 5VNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=DDwUxzG8DBCBiTyl0kMXduyF3L0hnvzA+O8veYLZadc=;
 fh=kcTwKzLIqR/+Se2R+6jxC+vUBOe/RTTnwqJw2bt0OAk=;
 b=Ya6pUYZdsqfx/SbmB+daA2cGuWpK7IgPMSiUuy0bONA3dw709HSqUJVehn4gdQTvRF
 AWPMUTSHLBFeUWX6kHCfUyMe+FYwuNN0C6Z4OAPOwQBcrKLlAiQvohhfEZ3mZhqAIKps
 GxYcJdNNCVXY8DZmg/A8lEBnE5Yg/bWaW8Zv04wthbOoRXNek7n9UI17Hphc4tpszIHk
 r4PWFbPN5c0+vSE6JeW9oGDzVUnsYTo2Sc2un+DRX37npKQSCSUzPSx12lHJE97kf2yT
 HkBHOVJ1bHdlUPeReEuEDzBxAVvH4kmavw+1vlv2JHDzvLTMF+8QQsAEOM/6h/JG07yY
 TMzw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401831; x=1793006631;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DDwUxzG8DBCBiTyl0kMXduyF3L0hnvzA+O8veYLZadc=;
 b=dv4gCWBphoGu+281JoRfCmB3Dm2ICouCZoyAP+rI55WJ/vKxX16g3C+f9FgexrI2f9
 H0Z8SHscY/vGJzb3BRaki/O6nWz22q0wSZF53krOh/9jsBlU/eHRxwPv7sesbKFYg5pR
 w/sNvghprhpe8RUoguc+UQs/Nd1ehzY0HZd5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401831; x=1793006631;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DDwUxzG8DBCBiTyl0kMXduyF3L0hnvzA+O8veYLZadc=;
 b=JcUDLNOfwo/UirnzWDyC82lpjpIjNH+ivlQ1ZGmfWaAC/HSGPWYe3SCfOOwQ8uoAU3
 A8J2ofBP4vjg0uW6wPTApFvQQAXfybm4zS4vYVO5ifEe791UJTmD9xttC63Wdhr4kiMU
 Bk7pzjAgkgQpDUw/Kpw7ym+f24H5bDV/yJz5185WWaj/CuPlxleGIoLeT0AqHNbWeAyW
 TeLQvE/+Qz+g8HMtN14f+RDqZcyoXxyCLQtzvMWn77UW01SXhxPVlSyTuI+328xO3m1l
 lIAMYaTwVJFI70x82taQoDrN0c2q3xN6OE8DDnkjOkcU60P2SK1NcdgQRHiZBs4mXYaQ
 YhDA==
X-Gm-Message-State: AFq9FYJZlKPUE65KBRXqNhtj6hUq+d+/WFReNK3QSViMpR9y7C9rae3E
 wVyxCmCgc/39B0FijfReAqFl1d3oNt++79TKRYHPdBbp6wCwn7TuOWiH4uLb31sZMpKpeAWCJPr
 tlPWgDhS6vzfKNwSoPE7RKqoshUysYj+6Tihw3iwf
X-Gm-Gg: AYBFou0P+dBfXt91slMaM9wn6rV4o8YEm3m1hgf8GKG+FZOgbovaODmQvIXg1c0eZ+O
 tfZC4nQp3vvQYnfORUZKQv8rRLG7vPCJ0iuAqFEEEt1KeAq4JV/rWK8T5/VHMJa/Gg/9+GVt5uD
 doZs+LCcvIRFuAdOMEnbD2UOI1ocJDOp7o1QQ31dYXb1FXkG0MGg/VdrZtbcYnX19raqhgH++kw
 TvhaI4n026cIZU8AQhpjpuOb6UYX0YbS+jD9WoQ98muynHUUJFt+l34eGNr70Vehgy7MschLVLV
 vUZxV9WoqHBZ8ORYO30ZMKpK7G3sm+deqHVXXkAHrh1LNhLJ2RJ1MpiYL0wcpp9X
X-Received: by 2002:a17:90b:45:b0:3a4:b061:2765 with SMTP id
 98e67ed59e1d1-3aceeb9272dmr6723443a91.15.1792401830949; Mon, 19 Oct 2026
 02:23:50 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:23:44 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 08:36:30 -0500
MIME-Version: 1.0
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-3-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-3-d7e290847543@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:23:44 +0200
X-Gm-Features: AclHuK_rWbw_o8YI3MSwZdgkzjtDoOLZS9738XMPM34kGuYMQ4Bx-r-dXfrmCtk
Message-ID: <CAFLszTimWeWc1togo4ow5U-ShZ3eCAmH6Jj3dFoVWv83vo8dLw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] binman: test: Add fit,compress device trees
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>
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

On 2026-10-17T07:38:59, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> binman: test: Add fit,compress device trees
>
> Add two minimal device trees with a FIT containing an @fdt-SEQ template
> which uses 'fit,compress': one with "lzma", another on with "xz" which
> is currently not supported in SPL and one with an unknown algorithm.
>
> They are used by the tests in the next patch.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> tools/binman/test/fit/fdt_compress.dts     | 24 ++++++++++++++++++++++++
>  tools/binman/test/fit/fdt_compress_bad.dts | 24 ++++++++++++++++++++++++
>  tools/binman/test/fit/fdt_compress_xz.dts  | 24 ++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
