Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C20C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 19:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA9D56075D;
	Mon, 27 Jul 2026 19:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83U3Xq-nl-Zg; Mon, 27 Jul 2026 19:55:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 577AF60744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785182137;
	bh=6DwYwnvPrHI1exKQXfIRW2UjoqM9JPFJaQchUTUSJdQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ipFe8JV0LVIQaKTtJQRrcTP1HNm07dk/GMfsk0yewDVynViVLtbm2rl6yJEnmdTFL
	 z60ppOb2oG2F9Vq2IMuvokhQREyJYzGlh4vrArR3k5pLFcVeo24u2Q9jlGslucOatg
	 TaEK1hXIPkNNM8t/xIHx087Fcr2v755aiFGAYcc0z4h1+uJkXIl8DQkUllQbx7C1xz
	 qDdFlCYJCIzoylUfESg/2KjuDfPuylVPPLqAJqhe9IxK39sF9n68Xf+RSF9jbtslNz
	 kn+rGazDbrEUJoCC3SyCGDxDQqsAilOQpJ9fra3EJpVutCBpgig5gGMuMF92p1b3E9
	 Mf4bP/BkCA3sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 577AF60744;
	Mon, 27 Jul 2026 19:55:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C58912E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB9E14007B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIdiY7iRHUjZ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 19:55:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D03224005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D03224005F
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D03224005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 19:55:31 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4955cd5da3dso1338747b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785182130; x=1785786930;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DwYwnvPrHI1exKQXfIRW2UjoqM9JPFJaQchUTUSJdQ=;
 b=cluAlp6O9bPp9jzbIEEoeGP4ttNlbmhOfzGRKi/SXS629ALfCsbvLmt+EldLxd05im
 uSVmSLe2wQLGy+h+o7sauhGkPCzps/rIrqztX3leJiGTcy/W006ZozdzwrpNuv3a3J6e
 dPZyWZnjiVNyYbuYMCro54cBeSP5reUbOAQQIwUq/fxiXoSzzTZcWf5NNrc4z118YKll
 BLAS8NKik35n6cuAK6M/CfI8xPm3ZOdnMMyIIfwlJhsVf0TRnRTLglKukSEs0Ag9ZISL
 dByhYHkYdPEYDMP6bk9utpDtaciLWOfzT4p23TQynKL18oQEFw7vKsUYLpb36GrkLTNb
 7bSA==
X-Gm-Message-State: AOJu0YxtOpDm7evm3dguxK91H8M5PdDMZoA9cB9AIzEQRPqbBqpVuKB1
 vqEYhVET+ZAZaXPKOLBYLoAsvkEk3qaRA32rKifgD+8qltR+pSdRW5g1xN8t8etXMYlvNQO1sqq
 8PHhHpJo=
X-Gm-Gg: AR+sD11W5uCcwIE7+a6QOtD/jRJ92j6JZfWdx3zwl62a3it0bk0DcU45OeNydBqQO6j
 l2x+hL5r90q8BsFILNGW5MZwzXPRneZs6uX1jwg9HFKSneE0M8C0LzV8nnwTznaHg7QAzUyYLtc
 ZsakafP137e3vLtrbzv0FoPZP3JemILecP15SY/l6wkcT9qgX10Ria8jIbNq8OWWcsWHhdCoAEb
 OtQyMorBChaPVm+vE1Wr3J30xRKUvnUI2PnhouW69SdvGPS+tYMSSq7dO0ANAqjP3mCHHbbBi1I
 x14K87hX7ZhaLsda+7Va/Tkpww5C9YuRR6MLoJwR8d8GpdB/la0eCyrYy36COvOTVX+5y69bCkU
 TcUWpQZxzz+VcqdQres3AIlRDxoHv7Sn//NNi4tYtw7403je3qBqXl1GTeEP5hGO0NgndyHEDNz
 ez2GlpQlVegX0pQYdBlnrDO71inqbGd9+QtA1kMZPyH9BrGe8jIPWbhq7Enq+xitQ/EWCJgR2yq
 2ZuP+23zNR0IyU9eyu2qFuJhQ==
X-Received: by 2002:a05:6808:244e:b0:479:f7e7:4a81 with SMTP id
 5614622812f47-4ab69c50a57mr8139361b6e.0.1785182130589; 
 Mon, 27 Jul 2026 12:55:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab3b21331esm9633640b6e.14.2026.07.27.12.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:55:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <0c594f8b-e143-43bb-a2ec-760b79577ea1@0leil.net>
References: <0c594f8b-e143-43bb-a2ec-760b79577ea1@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260724 into main
Message-Id: <178518212947.4187572.15143642850807054317.b4-ty@konsulko.com>
Date: Mon, 27 Jul 2026 13:55:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785182130; x=1785786930;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DwYwnvPrHI1exKQXfIRW2UjoqM9JPFJaQchUTUSJdQ=;
 b=QPrWICtcnrwkb475ySw8xd1ZJ6apg/jpiLLzeEOgt5PcRWYF3+e7YgjQtzsmfbFcNK
 1O9rxm+quMSs+MQxViyC90Qk4JOudgbhj6cHOnBsMYrDLN+wuX8f+60nWdm7Bi65qXVu
 Szqy5YT05HfmA9UNar22q9Oa4vpCcLGNlPO5s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QPrWICtc
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 24 Jul 2026 14:39:59 +0200, Quentin Schulz wrote:

> The following changes since commit fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1:
> 
>    clk: airoha: fix off-by-one in clock ID boundary check (2026-07-17
> 14:50:35 -0600)
> 
> are available in the Git repository at:
> 
>    https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git
> tags/u-boot-rockchip-2026.10-20260724
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


