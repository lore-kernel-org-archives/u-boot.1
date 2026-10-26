Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B7606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ANoTet0+;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aamIA5NF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A43C960612;
	Mon, 26 Oct 2026 19:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yYUf35pI2GbR; Mon, 26 Oct 2026 19:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2377605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793042406;
	b=rnuQygko5KXQ6cLpBAL6GyaogAaXz4cVYVs16693FND9H3QWeS4jk4cRxqEvEeHxYVxh
	 b4CnwPVUzYjI6Y9MrejkKxeSXGCowOfPDGVhYc+F/3oC7i8jUIVdRQz/gYe3yJXG9XWnA
	 IQtTdZ1xZH2sL4+7yM3unnfr1MdouyCFUVyHhWs3i+190ESbzCQJw8dyFbC5fJJpkcAlV
	 cV4ovs75Ig4mMfohlOkatCs73C9oZfGKmL/40qc0byz6qJfSoI9aXL8CwJTtu35f0yNpt
	 5TGK70DSFfvoO9yQCu8W0bMEp4JKyhe0ShZ7nfeFchIDpu/1XP7P9rYOIo+ujYATJhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793042406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TikofvtTBI7NajS14iE9Qu6iJhFPxsnneRTi4IE2lRY=;
	b=mBYwoiIiAPCV4E9xsPSF6G0NxQd11hWGiKoVTieroVuFNC48YAkjcAT2Ga7ur6sq/gRO
	 CSMnf8/JeU9qKTNptWMO+ze0jryrSxoTDd0O+trwoeVct8RYuIk1D1Q64CDuKK5x9OAYC
	 31aw60xpcr5tgTH3RIODGq4spgv2NADZUxVnfBl+AEcSRVeJykuJp0c0MfPsoMTx1hZkI
	 /Xux0vJgTfNJTmFBtcd1n/QOe7w/OhG2XvNzVHyucP43KvjOmsO9qjhKySHj8UepHP2sV
	 aee/KIxACS+buzbAMvJrGwbYhsGpgtqA3w7+xKCbCe3bIAIBmD9KdX9EBpJuM5xUQyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793042406;
	bh=TikofvtTBI7NajS14iE9Qu6iJhFPxsnneRTi4IE2lRY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ANoTet0++/so2W540VvNb0D7Sm9H73qIgkY87F+yCxNiA8oNsRA7PMQV5jcJ2FpVF
	 JWISzdejVi5++4g8HURF383nV7OemsadOdopXXW/a3pOCCqh/aDFYn4K+l07NKxNE4
	 IWLHo0p5aDtTxg1ChSrAMxLdepaul7Mf+FVHVIWqCqOyD3cvjbbJAuNTRuQRkr+swP
	 UyiDI7UXIFcVkVnl0G+MOc8v3IKOJhg5KMViGho7c82r2NISa54Rhd9ue/HfIYiRiC
	 79umuzEsV3rPU3wDA0JkMb0MxKONRNUdeGEPCj1Qx3TJaoYz45PjZM5XlXSWGQDng+
	 vtEZ3b5DLUtgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2377605EB;
	Mon, 26 Oct 2026 19:20:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56CD5235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4865F40514
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KpAwZ719vv8K for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 19:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E33740513
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793042403;
 b=R4VnwgOPPiif8IcF4RJzCFSXt3XZbcPyld5qOIVPY/c2P7UsSwpJhd0Dglm3zWs7puOb
 J+FlJWUFRega9JmXBDkAESKs1C/IjcduwOSTwNFZDbYU0EKxGDeo4u9zIOFzaWGXY1oiS
 L+Yc6RcZTthkHW0xAm/1kqr8A1gM8EEuRZjXOhwncrQKE55/kt6nFQvuKTSSkvG206rtv
 tHr2uowzkiACpBTmdweTQCVNUwTCJYoIQF2roXgPxbenD7JC1VQD4Y9WOs6u3OQc2MHYk
 8tKS6dOfp5s1tWWRgn116NWXP8zE7UreWgy/FPHAseOZprvym+AOQDomRBNj4sKp4Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042403;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=TikofvtTBI7NajS14iE9Qu6iJhFPxsnneRTi4IE2lRY=;
 b=rtQSMfH18KkwXY87dNGzlImc0BfEHbHpxrqw99iwKUoY7KVe4OokhW78f9BqWywUTtDF
 MNjAhyQAIRcx1Lboktg3o2V5K4F3u5DaFLqzBZP3L5doLhafH4xdyy6ov0KdQcyRYX0uw
 OOJvns3kXSaATGVsqMszfkpoY5i8UgUcMMT1KZ3eLgsg2zHf7BGhV5BIm92Ezwcs8hF4g
 Vu6zyupQss+KhEtaI1pS+bkGSRQrEPACnNmkbr/MCe8uMWZvsmFmnfk5uREB/xdBWI6tw
 +lXZOXABsHjOEtu8kutWw2KDeHOfJs6DsHDu+kJztolYWvXG/J0fMTjGSAtgMcyJZ7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aamIA5NF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=aamIA5NF
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E33740513
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:20:01 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-8490a7d6696so2009989a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793042400; x=1793647200;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TikofvtTBI7NajS14iE9Qu6iJhFPxsnneRTi4IE2lRY=;
 b=aamIA5NF/BfSea3yEIjvOW8dKqDge+UwNsqkkZoskc8gYL9DqT0V0ZZVk0wB4kVdjF
 XcnlVwHXjJmtN38BJulkbQZ1A0L09PU09NwMYTyuiXkQWgpehLQBw1leJ11W7lOLfWpI
 JT0cFWqrT1xUQH3p72Tp2djUC67zes88cYnvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042400; x=1793647200;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TikofvtTBI7NajS14iE9Qu6iJhFPxsnneRTi4IE2lRY=;
 b=NKsevqt3SDsDRNnESd5rZIR7Rvi7W3Et2kmMvP2Y2wYuqRnDW1Z/jqAFdmUSi6R0n2
 iHbUekPJsJPf8Pi4/QD9XnO5HGJ7hSAZEJ6ipqCKsdpYTvq2s3ffGQheq6XCvCOwruKL
 CyrMHupHi4ITVjrvZf/tFfZLp2VsCgLod4SJXEd2uRUECrjFP7h/uSak+ZfQ57dTHHzs
 wphuqEG94h5iVD+kKKLj9T2i2WxWwPWAkBq/XjzO8N9hVHGN1plP2mtyCZ5uOT6BqH6w
 WZZyzqR5BnOrAWQGl9tzLiAtYcjHSRknjt1sI7fM/dQv30uoTr7LU3yiIC33S0y0vGgH
 3HXw==
X-Gm-Message-State: AFq9FYLPP895rMHVk367UO9M9xqpA1COUSRb0OvrQFfTeL4jF9c9BQpB
 hUCiAIIeQ2x9Y/KCdJllww1oZ1+jn4F3gF7r8bSC8ip4/C9qxKrTOUB2IXPVFlN+e2xh1HYDMYO
 +KjtP9UpyUK+K
X-Gm-Gg: AYBFou0GP39H+rePBUnlhROnzk7NP3DwHvytDNiV40M+ffLK3X10TtV0W7fLgoWmZ2n
 Hf0VCQriDBmzx4K3KwwZFZIKML3OeapMT9tYoF/sp5uhUe4xRRWI75IRO7CEwj6sOoPcGQIa7V3
 OyOe47gc3qrghSlBLCI4/A9bIS8MsWtQiLscrXNTwbSdINifUqg2jdhmhBmtcNencss1nP9VJtY
 ENJtJSpDCZMZ+M+N+vMf0eEIwDmHTpRUo40PYMKYoUEK+84i7637pZct4psU9bFIamBBlZ+9B3s
 OsQWN9aemG6xpycBn+DLDl22gBqz4SagptUVP9F1hh/U6qmjLgdO4gRFjo5Lf+K4Ptjx/dPpYXI
 2wRyepoj3R5QhYfwAVt4MdlEWZAcmJwYzn89va2WPYlBF8q2GxzfVqA/wToHgIkDXHWydXBd17x
 L05GubC5R9aMsVrDsq5j4gQxCGpBtKi2FNOS41paYM/5naWsbj8adkHlJuENNuiXXJBha2BBMZI
 hWO8TbYH1ce9LXG+NRJ7BSzAVb84mETX5lDOA5lOlf0VoO4EFRKETCELIuwk4qS7dExkGWEbNmN
 x4lHJUymzyyz9Te6sweRdL2/j5KqF81kol9a6AAyzJtPlLj9E0Dr1odsfCDEpNhTvKemuzUkx1Y
 Q79Bulusi5Qw+ubLIrG2g1Q6OPXQBt7A033JIH6F32OLjB6WLgBrswUelqg==
X-Received: by 2002:a05:6830:3482:b0:801:21a3:f31b with SMTP id
 46e09a7af769-850fe7e3a61mr5849585a34.23.1793042400359; 
 Mon, 26 Oct 2026 12:20:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb64a8c4sm9539404a34.15.2026.10.26.12.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:19:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
References: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] board_f: Add verbose DRAM layout print option
Message-Id: <179304239936.694041.17379296461483127651.b4-ty@konsulko.com>
Date: Mon, 26 Oct 2026 13:19:59 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 02 Aug 2026 23:33:37 +0200, Marek Vasut via U-Boot wrote:

> Make verbose DRAM layout print on boot configurable via newly introduced
> CONFIG_DISPLAY_DRAM_CONFIG_VERBOSE Kconfig option. This reuses existing
> DRAM layout debug print, but with additional rework to place the output
> at the end of DRAM size listing, print both bank start and end addresses,
> and skip empty banks. In case DEBUG is defined, the DRAM layout print is
> triggered unconditionally.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] board_f: Add verbose DRAM layout print option
      commit: 5807fc7f3b780f586d34cc672f8388dfa381065f
[2/2] arm64: renesas: Enable verbose DRAM layout print on Renesas R-Car X5H R8A78000
      commit: 71c5d25641b0c889db21be361528d7905e74b042
-- 
Tom


