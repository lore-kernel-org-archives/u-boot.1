Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920CC606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BzSKTZT1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WhRQjDlr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6932C81469;
	Fri, 23 Oct 2026 17:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I70Wb1Ji3Iwe; Fri, 23 Oct 2026 17:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DA288146B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792775519;
	b=q6RpLk34w2D6wyU0Ftr7DGCOGcPlYMoWUPXlq0bbjYSn6K490yCckighhbzJ2A/gdc9E
	 Wv7s8QJ4esZTjOwjvzpqeTSsIE3Yved6y7BsfLHHQd1QcBCctiOhNfaw/19Wd6ohZO5CU
	 wOLcn+gRrEQKgnf9J2wAvhB5p/iNqc6bcnacVJj8LinyGBFJXY7euoRtzgGPljcZZHkWD
	 +Eo3y5gWdIcyOCD59NTlXpQNjjFhRfkfbKIkUf8RWAgEonPkNtlFLVdgBXMo01bIgZm5t
	 CBgqqVkiS+0+3idv589bFDc/FA1OPLmZ6Yk54ncmKC7E/hUzKhI6i5isHZuMpvVUwAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792775519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XYTlGu56aNCv4uUE63EhtY8SkegOmm7HsuvGHz4nqlc=;
	b=VjlgWOvAH6hY7FjxglhkctkEEHuVg1a7KOjgVTwb20l/IuHXCJuUXvoubx4pd6zz0tgV
	 aMfXMV23TSGuIpiNDe4GwoJDhoPsJ6bFtcUOKRNFl9LEBAW2TxOLNbU1PJtuIsD3TeURL
	 vaVfwRcrh2d/GbjC40W2NWm3TXigPzdFxR2TSXBGUpvbgvlK5SI6JoGUKHkLMcASMtwUX
	 cPU44F4P0eNze/OFbEBTu2R++/6t/tpU8UFeiscQggqh1fv96VJfoZAezbuDNESys7SMc
	 3FnawE8yVaQoyHJNJC4UOStcVKABBZVwsUY8FzJud3pVdzltYGGdiuZHyEnO2Rvp0UA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792775519;
	bh=XYTlGu56aNCv4uUE63EhtY8SkegOmm7HsuvGHz4nqlc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BzSKTZT1mA3g99Cs3/WaIp2UarCcGlT+/Fy6uvlZp8VTz3OZ1GI6S9zzfbjQuuJN5
	 grkP35AabRYbAXvbxqgwhg4dgkb7QcqNk0LQK68+fwwM3Lav8kytEG9e9ld+3jaR92
	 9dFszOAr79QD/ftIKfiF3IojmA46PqQgisIzY6FoCFgiZaDIyTHJGyjjLrpk4eWCQc
	 L+St4cBRgVlKiEIyWy+Ugh/cangwpfyMfeV0V26lzggTlTQFpQusSKA9G2ib/Og4Mi
	 ScqW8Wuw0iNC5oOcctu6Pi3S/GtQtFKg0mT25TcgZorKtJNvlOfpVkcHZ4by0BSlU5
	 AqRIwhEqW+v4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DA288146B;
	Fri, 23 Oct 2026 17:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CEF89356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC3476068D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehYQjYwFrhb3 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:11:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4A4560686
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792775516;
 b=q4vQeruwG2Z5UH1NtdNP53xNfOvTtJQ7lwC7jZer8G0Ptg2hYvgps4c73naUG5yQyV68
 ckp227mwhH8U/e+tuuFIxDpyTgWjokt236ibGKJ1aTDpb6IXS5X7CBQvlNbDIGiEgmKNZ
 xUVdxibitfw+4bFz8duKWKWoc+orsR86uRW9ymEq9l5wCjGokuf885iZeedatmpywM6ZJ
 h8bb7P8PwvSiltc7Wbjv/zFxoEcoOnfeluZRXd6nKrHi4Muqw5JqS4I69b9k48ihC3hR7
 aRSFtrsFJIHorkv2obmbBTCs37m5aiw9bJT/bo5hEy3pC6JOzGvNGNKg/Ya90/BJEYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792775516;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=XYTlGu56aNCv4uUE63EhtY8SkegOmm7HsuvGHz4nqlc=;
 b=CX7cxjOoPMfrWOZLVnybI3CAbbHMsWoz1Z7WyKd36FBMcxS7EKsPAS/TUi2LNp2rMdW5
 JMyvbtP6GsotzZXRVGLLuJUDY3ynwoe9MNIiFESDqswVxe3V9kV6jLNTpH0C2zkKJThnA
 ukFiG6w06Ur6DoHNurS6BxcnfvJN0b0rP3UyvwD4GaI8yXYA4Y5YIeoN9kP5OMJ4qu1JH
 YfR0J9vZvmsLxvYZPLdJWgUltwLnUvKP29epuKp8mcTq5oWVX/TxOV26eL9u+TmKmBcfR
 HqD4QFiYZTXPOx4SPCc7Vdup6+4psFhR6OrMz92HtrlC6qcU6UqrGnzhceAcUDnVg2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WhRQjDlr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WhRQjDlr
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4A4560686
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:53 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-545a4fb8d5dso559028b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792775512; x=1793380312;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XYTlGu56aNCv4uUE63EhtY8SkegOmm7HsuvGHz4nqlc=;
 b=WhRQjDlrBxsiqWam8BGd/XBiLodRYM2e5adZ5PSXqqiYqaQu7omwtIpQXpYJbUNfIw
 20PPUvzxoNQNClhwzl3y6eQ5etldSVuorASFyLxj8NOJBTicEhe9oycCqj0OxJgVjQA3
 aQU62qsnqE8gyBCgnGvvFpLBzVbpzkfYdqg2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775512; x=1793380312;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XYTlGu56aNCv4uUE63EhtY8SkegOmm7HsuvGHz4nqlc=;
 b=GAbBn2nYa5MgXWIpmoQkmWNw59m8apNTrQE6P1fNc5gbXJfUx+iSVXEyeV+IBXndeJ
 F/XLJhr8lAKOvqnreFS8WvqlL+sM57RePTgV7h9O/aTzvKWXryirHDi/fVJABJb+Twxd
 SCKd7HGxiQnYor4hd7k1Gntg4+CW1+RE29wijya+yQg9HgWIWccZEIqjATxTq7e1XnVx
 vcLkTqM4vGapuqSurwSnUstQ6cBwhdWL/QtUnrnUoCdrOKMbwUfgSZpqX690mgjssSJh
 tyfmaG1G9AUobFUWWRJ4wH0YCAe8IcBN5/nt/m6qCsu/xysj+D9ETia7TUKbaIWMR/00
 b3Dw==
X-Gm-Message-State: AFq9FYJQ+85eTfzJjd94eg751Kgdln8/vvOkgtanqP0kCW8dL9vLCpgu
 H79iEo+Yg1AGMz2fXCCt2HZwLNv3u4FpTHGkqtbiqkkR6cJpQebY9irsCC/u/zFfjtox2B1okXr
 38pzr3hkggUl8XaU=
X-Gm-Gg: AYBFou2oB5BDyHUpjTz+ngoZUDJWHdawk/YLpye/5AWdWOEQb6fmDwnwAEGHOj5cw5e
 CamOBhSe9uhXZnobF7+tfrrunqz3jVksxnaZV9OTbwHyL9SOt6gfKNYKUGxhPF6pRSpYAy34GBL
 455peiwCbn0C98pNNK2MaRf3dPRBHdUrGmHix8meqK/RjaxEtPYsN3806kAA66Uly6Oo/MKPVbQ
 XgTQwfWxqwy7NfmVKizGzP/lKuyqkU5OJjTzd9zKvpXx2yAVpBfb5yxU6oPfOp40Wgy9NJ5+QDV
 vhQg4eFLhLqHqzzvBsMpasXzCaM+sltK8sbTw3B/apxBInXKZQSU1GGbzk+3nBjKLiQrZBhGT6n
 jNYqoP+l4SFXmsW2WChZBQ2PNi+BF9c0Cm1QomMPek8tf2gb0R3bUBAYOil7oQcMChqrGQLelr9
 nY7V92tzHEQqflEzEYPt0oVz05wCJzGYT0MpnAqHp/JeJ9SYRHDK3pyoAfvbYcqWUKhKXzJqQZS
 +HUUzZ95MxxblCLDLN+aaG6CXDaZRDiT61T/kif/Snxwc4CwbuVXF6EX1ii+C7ftrF0Yf0g5CmG
 1mAZk90PVufXGGuzKuwiL5OTSx+eo+YvFkal3fgp7GVaJTuyUm0MQblia2pypQ3y/3MExYFq3xX
 qVIpN3Zm/JdQSBBTY4uN3hLj2AQ+y1y9kL/jbjxXy9a9Dw12UvKsFyyw4
X-Received: by 2002:a05:6808:f8c:b0:4e9:a959:7a4c with SMTP id
 5614622812f47-55be8136760mr2176577b6e.24.1792775512092; 
 Fri, 23 Oct 2026 10:11:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55bfe1537c3sm161329b6e.8.2026.10.23.10.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:11:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, E Shattow <e@freeshell.de>, 
 Dave Klotz <DaveWK225@protonmail.com>
In-Reply-To: <20261023063727-GKA184714@kernel.org>
References: <20261023063727-GKA184714@kernel.org>
Subject: Re: [GIT PULL] Please pull U-Boot spacemit-main-20261023
Message-Id: <179277550890.3931275.6543609758753002135.b4-ty@konsulko.com>
Date: Fri, 23 Oct 2026 11:11:48 -0600
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 06:37:27 +0000, Yixun Lan wrote:

> Please pull from u-boot-spacemit into main, thanks.
> 
> CI for this pull request is available here:
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1695
> 
> 
> The following changes since commit acc808479730e13e74199119eb9b2b9113999244:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


