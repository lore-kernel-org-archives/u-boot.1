Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BA606A32C
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fx5uJI7x;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gEdTT+n1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 192A060E22;
	Thu, 19 Nov 2026 22:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GcVCV6NxAth; Thu, 19 Nov 2026 22:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72A1560E2C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795127212;
	b=oFfK1WlIpeQZD/vuNM1n0f0V+i4x5hKqSZlOwzMN5t720zGqgL8ejkrDl5FlfoNQh8NQ
	 +Khv6gPLcysBXO/aIsdqsn68vk9I+1bGj12YX4bDJS9RLLIvt4jD6Pmy3xomQBa5jHOTC
	 CMfgVSyF0UK8SNXBXkaXGsrMOXtXLUmhWexlMdHd+Mj62bwHSElb4PDURRxVSH4T7j3/o
	 7VAYa3DGz314u9SEFXTRXRYxWJjzkFuzFCHqv5k1zbqaLhpnBD6KHUu+MjGRcuJoL7b/s
	 q8hZW+4KfDg4z/pwzcx3hsm92qeIlr43D0Ng2wVFGvfsDfKAgfAW6vSYS8JLX289tcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795127212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZXt2H4x/5dAshyn+5pi43B4G2JCvLO4rz6FKQlNKSyE=;
	b=aGtJZh3SU6hLfksE+X4LvdzBdKzCOVcP2VnUBEcaX72nxh92toh6TyhGGw+DdNYOqVLj
	 i7G7rMdJkrgtDwjaoNAbsmuFS5Tarz6yMDoMZA4dXl3F78NvgyxOoKE5yUKsjXOvoV9GH
	 Nl/cKiHnwqPT/yF5spzkAwjxubcCwTKq54bi/SDsecUTYvlKPHiogpR97Z9c7BC8Y5sqy
	 2Y4NYhCG4zevGcfUX/afkOSDUGk06Rz9p7HKaX8EyXkBnwSCbBhS4Q6HRSpRW53XBlzDy
	 2Clp4kYx8fnJQecH156BaryftIfUGxWh48jJ3nvLOfu+OFxlfb6cxn+Yjlb5NuVy+Og==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795127212;
	bh=ZXt2H4x/5dAshyn+5pi43B4G2JCvLO4rz6FKQlNKSyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fx5uJI7xXJZXRPTGWYus6155rxwZacKxEupcrTCG8Y69/PPmiu5jRNrt2Q/Jj4/mC
	 tXo0OP8TYmkMvwUZ9z9/qUAZ5fgl8znBY+rpB1d3oNJzOEegaizx45V/g3Ln/wQjhO
	 FOlTtRcIXmkjEuJJ4ZZwbXgt63yH1fHcuBDcPTtVFFraJ3tLBaenLsdB9hqPf43SfE
	 0uU24Dgs8uIwAbROA9c5fSEL7LyY2pTAl80afS1LxyFu5uh+br9mO+nyCE0HQSM4aM
	 +htGsjK9tMPiPig5qrNjdY37MdGSRhGsXXnArEq8UA/W1D3Vvl/zrH0ckNGQJTkm2v
	 GJtV6BDRXLEog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72A1560E2C;
	Thu, 19 Nov 2026 22:26:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B11122F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9705440185
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McJq6h2YzgjB for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 22:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 004D340079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gEdTT+n1
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 004D340079
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so230319a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795127202; x=1795732002;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZXt2H4x/5dAshyn+5pi43B4G2JCvLO4rz6FKQlNKSyE=;
 b=gEdTT+n1yR1TNZd2/kpmqgNvMg+zkqD/TFcYhhyum2UVVQBV3OgwET1POuJmF8ZZUu
 5K8mqqcjR4w7M3zMCUqZnTsF2BsO8UJcAfuRwwxnE26Ov8IoA6Ll1Dw9onsprlkFlCzK
 p/5NzJB5Ov7cp/YsglL/j4kD3g0QOlnQY+olU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795127202; x=1795732002;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZXt2H4x/5dAshyn+5pi43B4G2JCvLO4rz6FKQlNKSyE=;
 b=WzNiY8FH8MeXZn0kYgvgYn673mQUs+hRpDxa25PRi5+nKGRx0MpcNbeFL86OMfxJNy
 N6EI023hHHOKaabMJMLFkYvdsHt6ZJD9kH/4poCHgAj9VSi8k9ww9t7Hg31iAcPx1G71
 J6pG7jW3+ooejJpIx9tQH1jzuyhvJG8Zykiq3BVFLIuLHmUeypRL7Isr/L9U2VHK57ox
 Z7MqNbRpQhZU5ZfGRuQJfOdxo0IoFqOVKbgTD8LWBHv3IlG5OcL0yecpzm/NVe1UopG2
 sWXbQKM7+vVKuPghk3ExLqltansoNkCPPnX/Lc36tgSU1wEOgul/bMrOKnBKHiqVC4nx
 7lSQ==
X-Gm-Message-State: APuU4Z8lCexpzGeVcPc/DFSu1ReyyfCCnNvDLNZ6N9H4U1YPmaryAv76
 wFntY7P/kF6JyC8yr+iiFF9LgahYQ8o7TwA3idS4xcWmCcm4cyLLAZMpF/kxD+8d+Cc=
X-Gm-Gg: AYBFou3Xcy5WepoUhV5MN+iEaGOPhnQ8TQ/MuUHY1Z+EdrmOyMMiOHdYaBnNas4xhSx
 w4xaidqMc21Jqm1SIQkFAoF7CxW488Fan9jba4/CuM1ALCl8tIXXJ3MtJZcf8ku4vnvhzBdm8Kp
 O/Cqim1dpgNTG4GvqOku732nsE3DQ+v4LAUTSxaCXQ4fAmsGosCnAVHj0/shNOt8/y7TviHjmtY
 2AvbUGnGvvjoqBG0C9401VZaw9ytxlpsdy4XLg+FNHtyOJqK0ShTk8syAlHkBJ1t7Oqrj/GNOkU
 xXCmIdje0IDCkffXlogd6Mb6SiqlA7QI5HI6PdVSPaHpoJEzUgGpJ4lInp4bzgJt7dtynU4ZFj0
 VIMLVFZ+ipczwscC8aU+3XIh+chnXtOoX9+bXXyI0Ea/VtWdiztIq5vZcBsShVzmALrfYbYPjZm
 LTPbthdd2aa1pgm0SuQqHhS9gYhuRoKVnWVK9U52BIqGJewJ9Zf7A4O4dtL1CPj1QfxPYtlXfDf
 2w5DnNwcTtJccUvqIlp8Xgenm879GGqQjop5u7UWDVqH2HU9Fm1h9Fs5dmEgcCuAZrG+1olvJx+
 d3p9YIApHYKUZtJiNcJttfytTlJyce8VP3aFl3we1yG5nvp1BLnl1YANTYB5ai3BvqF5gqJ7yfV
 LmU0UkSr+Vc3D9iGgdCys4VbdJ8ZryIcwiSg6+4Wqe0+fAp1fJpuRZ2h14BArfawu7CAIWR3PuG
 4bk86O9Mvr0cgXlgSPXJNin20wkugfsg==
X-Received: by 2002:a05:6830:913:b0:862:9ff6:53b6 with SMTP id
 46e09a7af769-86315a6d2aemr2012997a34.23.1795127202529; 
 Thu, 19 Nov 2026 14:26:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168c1bc5sm649069a34.6.2026.11.19.14.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 14:26:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 ilias.apalodimas@linaro.org, BMC-SW@aspeedtech.com, joel@jms.id.au
In-Reply-To: <20261110005930.6659-1-prasanth.padarthi10@gmail.com>
References: <20261110005930.6659-1-prasanth.padarthi10@gmail.com>
Subject: Re: [PATCH] arm: aspeed: ast2600: Add B650D4U THRU handover
Message-Id: <179512720182.764313.17131947857361330139.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:26:41 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 06:29:30 +0530, Prasanth Kumar Padarthi wrote:

> The ASRock Rack B650D4U uses AST2600 GPIOP signals for
> host power and reset control.
> 
> Add a board-specific initialization sequence to prepare
> the THRU pin selections and release the relevant strap
> overrides before handing control to the operating system.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: aspeed: ast2600: Add B650D4U THRU handover
      commit: ff6834c4ab49b837a3710f8afae03325e6a60839
-- 
Tom


