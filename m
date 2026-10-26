Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA9D606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0NUAw1vT;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=Ts+hO6qA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ACD7809EC;
	Mon, 26 Oct 2026 00:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OK-LZDs1t8lN; Mon, 26 Oct 2026 00:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5CE780D02
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792974717;
	b=K3bWSLDKzNHqYzZDG2+bG0rx6d1dR9+e2AhxZYPEs3rkLTXOlfgIAV+I01TUfDCXm3+p
	 Y3XmaQLx5cQrKpXfDUoxkekHAF0tbGWHp0O3me2nGzzsAOxJoMchcBXpHxFFEDee3jkGd
	 VM8HnMUjROxE2cek0t2PN1kL4YsADkDAV4tpCl+9dNkbKfB37v84qVNFThRf/nYziFp7y
	 VW6kQxK/sVU7xqbOMjmCCdptJ3ev+GW88EvMlvagDjT1RbUWJjPImqb50/p2J6/dGQVgb
	 FiTSZZxkf7+b5yMnva3S4bhu/RYC9NTnxzHmzNVTsDePHk4515ejzWnjdLEgzxbeLrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792974717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X8J/h+zBZPpeEAjPGTeN+WyUGOoxqcUAGrdxwHgv9Us=;
	b=YJPiXHH+r5K3wPgLrI+3PBK6d2RInMJ4WoU8jjGlbLDt/2KaUNv2U7rt+bmRlXI/dImx
	 E6i1hqxdPTf3EalIQkZ+B99V/67vDjp6deMBpEUjXOd7XdTL3RLq7S8/eInyIqgyHekhW
	 UhvAIcNzpwfB4Sd1fTLa4V5X9oefqrrFEf0QXOikJh3y2OqG5IsW2jhpFdSI/DgEQ+5pj
	 aSw/BB62zYIkgvZnjMWf3UqJGzsDgJbTqOpBYNaP0ME2rgEmWfq+6SFaZKGt0xcOmI+by
	 u+BX09rl7pwy7t5nVhgnRjiQleyIkmE2W+88j/vG08ZTys6ERqPGEZlDwQM8lXIL16g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792974716;
	bh=X8J/h+zBZPpeEAjPGTeN+WyUGOoxqcUAGrdxwHgv9Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0NUAw1vTgZkm2i5V43aEQneEHnhtazNJlLmuRhpXVDW5OF9ffpNve6F/Aw7J/PEYL
	 8FDyOd+fnpYClrm2Y6vUyuqZtsHTvaqWXtSZF+7SodgZoHPE8h0kA+ocrLbgPHeUUR
	 DnumkqIggmqtMUwd2isbaMLw7aWrSqrn0xmINy1hIPwfgQXlHb2aeIJjfSjpfD4Gpm
	 3YevKMESJMOk1Ro4/P9DmSDg434r5ckCKnmTiKrcP7eWQpryoGjd+qfZQhK+VfN4o5
	 ttuS6dkX+tvN30fx39UAtrkriK1iOKIktrHYeYC7iYiRrzBNCH3TaOYtonMxBGQLYk
	 QyjUZ0eP1pApQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5CE780D02;
	Mon, 26 Oct 2026 00:31:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00459235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA28F60619
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7M4ept4NsYvJ for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 00:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9CA38605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792974715;
 b=jgC48em/DLvOO9voUvbkKNrEfjuneAAWhhimMp+c2n6Mgg4hr3UtjBOb1wtvJkNwo76L
 fON/FokwjJTMNBbcXT2+CigCok/p39HqVYEhKrGj/8NpSrPeT0RLE7bbl88ItthS0/tyw
 51xEORIw+mOHpr2yO2QTLnPq1EtVOYNrrVDEq5acJs4Qin/0/P5d1ttSYaV6Na/yiG8iv
 IPjyseUiWKChAhZb6I2ZOnZZXhXT59ROfdD+JB+eAh8b97NmI/wNTN4QTTlA99AKTDzso
 gTfGkgZHoodJD3N1EaOyLT2NrsTDbQrwGABoCbzdrJrZMVV7h9nGv7TTLoKsriBvgjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792974715;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=X8J/h+zBZPpeEAjPGTeN+WyUGOoxqcUAGrdxwHgv9Us=;
 b=ntS+f6pdbyQOSpayDAMtLh0DiIT7wTl9vrhe1HcgTujRy4vm6khN1tmyAM0AwrmkS99b
 A6DsmMr9KOPwcnaXHjDKf+rL9U5hfX0F2BJmW+TY5USkBbnNts4vDluAkbYFpHHKsKhDu
 I0lfdb3aBrc8sz928uFIq2G12KNybN0hKjGjZ1aGAmfIcfM0yvv9/nmCOcClMet0QTWsT
 cGZpB1f5fKSWzTO8NpRriJ/c9PXhjKxghsCG8aAuAcYLwQTXPQfAcrMF/8A5wpeDJYNVn
 gbo1QIXJRdW8smxzfNF/ZRR3mVzEXsOLGgfUg8q9biG+4TTYW0VRjyhDQf9WDGp6vOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=Ts+hO6qA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=Ts+hO6qA
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CA38605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:31:53 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd5d2dafeccso750865a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792974712; x=1793579512;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X8J/h+zBZPpeEAjPGTeN+WyUGOoxqcUAGrdxwHgv9Us=;
 b=Ts+hO6qArX5HIpd4YgH6F1MFARDlyNbI9fgUbk/o2RNF1OrTt3WJUs13kId3DtsANa
 J4O5WdKahZ2Efi5/KPLN1VO4g3/HZ17obJXt1I748DQyvo2G1jw7B1Ia6Cag207/3Bly
 5mf00mhGoio27hxLPvU1AuY1tyfuGvM/7x8J73rz7ZyMuldxDEBEcpCUn9vj0uZDgn5D
 oZQlGx42zBhkBjKe062DQVkOLi+WCkgd80urdUBKoFYBVdOHRH3cJm1k3c2u1Pv7MNX6
 R5inNF0KP4QPMIYVOkEP3rKx/PSbzGaYwRSYjLm9eYEzmaTthRNoZbwZwuMexU3j48KT
 1zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792974712; x=1793579512;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X8J/h+zBZPpeEAjPGTeN+WyUGOoxqcUAGrdxwHgv9Us=;
 b=l1XrXF7yS0A9GLVAp6oXDEqlneI1TpNwsyivDEfuWobdJiaBuIrWGPmoHsHtEavJCV
 JQCi3zoBn9nRwaDhzJg7skPKef0tVpUro+XF4W9a1vL6hGAFCCb7yE995/kyzJF8eSX5
 eU6aI/tuyptma1z+gxGWxl9MDnj/pbjtiSFYyfcW1WZLqaZoE4szR+gYdxKA9orwkSRJ
 TLAcAlls72D1QWT+VXzmPPaUNb0sthJc5d/wa8ibJSUAJMv/CbZYkbt2sISurNUFQyEF
 fEKu5EZbg1II9ICBKJBqFDyqaLp4JF2/WuGm90i6D9GBAQtEIT6D0npuTT8Rwsw8Xrp5
 LxCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8im21bVwkayxKqGej/i5GM4Y4LMIL9mPfKptpk6R0KFz+bCZ7WPWt92GM838xrd+mjVRRmFw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ/HFbGeNiU55UN2kAD4cGuGwR2OiZD+VX95TZqhXztmvC3x5RD
 W/4AvkLm5g4uMMD8x8kkq/l3ERCpYI0xQ8CotgouVO+qIR1IGovYwmvTRjV2JDqVrqPnrLM0+g3
 7B01QcSE=
X-Gm-Gg: AYBFou2xbOzsuP1oaOFuYcAHV0GQWZIg8s+qVQh8FvO2dr4V4S4r3fnzuqsLNodQhfz
 fg/2ab+68CBo+esE8tyaRMyT+t4QiBTMUzF2l0zhv8N5RMWB7n9ya/hC1BwRK1YfyQuR0GO5uss
 OviTTw3TiZ2QdER1WXnplDQrFWgATVaj2JGstgFDsiYI+7QKF0SzCXH5O5TOFIQoWh8TvkbG06U
 Z7xnHXqJqYGPuMlDWQDw2kmCegFbTYdZLizrZJfkgO5K33+kMTAa5mCxVivHNjczIecfs+Fsoi0
 tMduVDXyniHTE2kAIgLMH2H8as4scr9C08Z6Oax9I3TrKNcf9Vi8p0w3PDqnw2Z5w6ASKZB2IZ2
 dy0sbSPpWm69W6aapltic6LPL3xad93hr9w8fPwyNy34iEBrqq38S9CNW4L/CieMhbGWSfExjXm
 8M9opJ+ClG0hfnsHsm1u61e7nDLrcpmalXOpGZn3jIU9Rkekeg0ZwyEbTZfka86VZpdl5+mLQ/E
 vFq8cqaVy1pgp9Al7H3yBTW8xgQNFfFlM4/6WowyiK7zXPLdEzyskMNRPfIGnA5xw3j0E05
X-Received: by 2002:a17:90b:4acf:b0:3ac:9e76:aa93 with SMTP id
 98e67ed59e1d1-3adea0b1206mr3898889a91.7.1792974712620; 
 Sun, 25 Oct 2026 17:31:52 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebac408asm6109152a91.0.2026.10.25.17.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 17:31:50 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:31:44 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Bruno Banelli <bbanelli@gmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@riscstar.com>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board: spacemit: k1: accept the "m1-x_" TLV product name
 prefix
Message-ID: <at6fcP366xFg3oeU@lliang-1876.localdomain>
References: <20260825065257.69536-1-bbanelli@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825065257.69536-1-bbanelli@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bruno,

So sorry for the late reply!
Could you rebase your patch against current master and send again.
I will merge the patch once you send out the patch.

Best regards,
Leo

On Tue, Aug 25, 2026 at 08:52:57AM +0200, Bruno Banelli wrote:
> board_fit_config_name_match() derives the device tree name from the TLV
> product name held in the board EEPROM, and only recognises boards whose
> product name starts with "k1-x_".
> 
> Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> instead.  On those, fdt_name is left empty and the function silently
> falls back to "k1-musepi-pro", so an M1 board selects the wrong device
> tree with no error or warning.
> 
> A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:
> 
>   00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
>   10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.
> 
> i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".
> 
> The device trees are named for the K1 in both cases, so accept either
> prefix and keep deriving a "k1-" name.
> 
> Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> ---
>  board/spacemit/k1/spl.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
