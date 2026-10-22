Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483CA606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kLWgVsQ0;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mkR71Ocs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20B49811CB;
	Thu, 22 Oct 2026 14:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGp6ukkapNpo; Thu, 22 Oct 2026 14:19:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C5F380D9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678768;
	b=DYjBZVu5SAgI8vnfbpIYmpixOc5PZAVmZ3eu37NOz7IxvUTDCR2bwlVJkSAx7Fwwv8QG
	 ipnZm0A+sue44Q7oEBoeAWZPDHpzE38AzFkbSGe3UT4ZOJFWabjBQ26zJ6JyGaFvguZUe
	 VSV6D8CqqaGM1dlxpGJva/X7o2XD0JOaB83Mb+TDyXcMwshIsu65vInN9Ecf1HDIAoZdV
	 Bzipbh09ZKWV37ZtCXnKvANBJ5Jj/5SGEV9Fd9aPpKMW/2BMwsqV/6zgiLGp4f/qOBhxO
	 beWLXgeCvB6bF4QqXNN+/nlK24G/d5Ixw46GgJ9bIRIFNjezCQNO8WJtrILsh+8X0+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678768;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vDV9gNnm4iQw9XyTF8/TSgwExpELQXrRDsfmjXdCoJk=;
	b=HlomPa3dqn0ZyNqcRhLztSWeQckfl12+q6xO/EngagAxpH91izonmlVtc5OeWPjnDOyl
	 rDJ6DlixaGgXwxLgvYPgRjtqtTnQJy0qofekVzTJWrUbWljlxajeXvC47xKmDgd+2OhPB
	 7BVNCsWqddTl+VOo39j3ZbxzorqSUnuADbKx3GaxfIWXjhDwUA75jG3QMPlwCDZoX4QU2
	 ykBV63ne7xqhldb7Y3ip5WswWBHORZUIN2Dlyer3YcCIVsBnAAzZvjOga0GPDADjOjFCr
	 gO+f5ve0CXDvHB3z81fwxgFOw+wmipkqfTNaDKNRikqCqXbyJdxNP3LVqdLpl8uDUKw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mkR71Ocs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678768;
	bh=vDV9gNnm4iQw9XyTF8/TSgwExpELQXrRDsfmjXdCoJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLWgVsQ06NAiGi7BxQK9OdJP1+Immf/ZLh8/VBvkXJLFyS0PL34K39CG74nWvbs3d
	 HogQ4QTqBq2q5i4wg6kB8IUjWnWpU1erpN7YzXfnnZRJPjJrWPG4vu4b3NaTSvqfQI
	 mTnaFhHHNNj74JjSCXAhPlZCiSxNTzNbdLOC+A3kUdYzygjgdMbyJmpIBOsgVntwhm
	 WnX0oDJJqf51ZnBdAwEqRo3XDTRfgtH6S7v37xzC+Vr3IkBRPiNHebAEEYk/+9vxcC
	 buF6H4s0KKROzKPTzYc/fUpRv/+SRkTO0nAox4auMCrxBUSUY+bQHIv3xqaeeU6Tnt
	 75THArcn+mD/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C5F380D9F;
	Thu, 22 Oct 2026 14:19:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E33C95C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1458180D9F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id idGmKuYIY7mQ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C31C811A1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678761;
 b=GhpCLXHmL36pg1moyS87B3VgXPR9peA3ukIxMMaa4F7g/fdoYSkvheJ5XVTjE5PCU+0g
 /Ho0S3nL1dGIOl7lDe+NquGdyhDjqBeupUFGa5NDTBpTOAG2YI2elMGZ35f0icsEW2bjG
 +iUKmPB17X8FZQ4YQlEihYv6zSp3kHHIKONs0jowjHQJxOTm4Uv5zDbupD8a6LmTeUe5Z
 nVXi/IGZC19OVA4JHHRWusgvm/oxpuM8FdtnwEMZt/apc6+dpG9k/5MrDAyWsGULYJ5Ct
 7egVIuVAFETX96MHx90zekaZwkVZIBLS2u23B2+Q1LPnumHIwVZsyl0+12KwTkRVieQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=vDV9gNnm4iQw9XyTF8/TSgwExpELQXrRDsfmjXdCoJk=;
 b=PmJ3zCx9DcsGDfJ80KqLWnp21y4Oao4Lhlhn7J/Fs+6nCyqCo6Ojaw0f2Ha8WhkZ+rf3
 gLYoy3HL9TY7r1vTEpcw75Y81pEWr3POpEOOHQ94vLwML6whbUoYtEyzbguPCxUwTe62q
 NF+mfg9shc8u7trjRQmwy7NFXwK9FW99oE3aphrG3UBMC1PTwF0aQk46GuQfUA8TR+G4r
 rz80JLPWdkxL0jYugblDRJI/LwRB8gYsYXPKhLave08o3qPKljeque8J7amH+wCkmvJIh
 5TQt+TWa3cjq+6kMPQmEL2wG2x0ugXhSkLhKrTNhTXACI7V0K1G948LP4Q9HqH3vH8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mkR71Ocs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=mkR71Ocs
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C31C811A1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:20 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-81b54d0cb17so1913290a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678760; x=1793283560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vDV9gNnm4iQw9XyTF8/TSgwExpELQXrRDsfmjXdCoJk=;
 b=mkR71Ocs6yjzNjvf6w5Ly4sS4ivyUwC8QKqmnEWsgrx8W2ewp+5UxY7LgM15dsyg+S
 qmaOCwFhfWoTh28Ye4/osWRWpFX/ShMgwQvjurH5Qd0oplj5CiM3WANDrnkWMv9ROQj/
 KEN+NWQ4yps8ZzG2HnUEqZCzHUPHyRicDd4WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678760; x=1793283560;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vDV9gNnm4iQw9XyTF8/TSgwExpELQXrRDsfmjXdCoJk=;
 b=WXUv1eHDTYtR3Qgf6hN6fZEbBKsHl85iHUBZn8ajCmOHh/unwZK8Qc7HxSZ+tW1Jgs
 DTfUa1aw7zH2fIi50K3c2dvtt7uvlUDKy5541jdnSDkuOmR+36O0DGYaKzf6SBCcQCkU
 KOeb0QJQw29P+4hEpEosleXr2syGPKuR5cwBV7JIkgwwtmDAijdXUChpafisK8oz8OE5
 c5fHjMAZDHt4WPbytqvx2iTZnH93k4tREAHCbX2uANSX8ScP6q/xonxMbQsjLe6U1ID5
 yHJphaIG6AnztFTyJPjr8ast0TyRBkmGG9RytDRj0/TZKqwk1YHTY2TFCsfRQ3JPgUbS
 fU6g==
X-Gm-Message-State: AFq9FYIs+U8UTBe1eIOxUXF/zbtWuvHj+kH5/2hc32rv7FDVySRb0dFb
 UusYTH7bxO8eNnmcJ3gAFHyOIGnI9YKG8cPY6yGwJZDNvpxnGGlkcQokv0aadiSeWlI=
X-Gm-Gg: AYBFou1w7xeF1TLHu4GVYqXZJ0srKf5xtC9rh2kiMnYIr/tC8PDk4m9/49JQi6F2NdY
 nHA1Hd02NeJ1wnloHupowWjoQ/Vn3MTGO16v1yiSE3IYn6DApitA98LYNuhI6hJjHMxcL6edpgz
 hH4uLUYS98xrL9cNmlgK4HlTFVk2PjryaWeAGGZo/lOOVkOYYmCwp4JzotI4Aj/aC/bgyObKC3B
 bE16mPUZog81FJ+cMgSJ80DBGntjx+rXX3r82bUiWpKtmZcmWTDsiXxn6/IPsfCXsxLp53w9O+N
 +UJy6ewTOmHzk6jHqS5kl/kpt2HA4ISkPvDPegs7sxurtTt3TVjkmmclntvhTe3l82TT4dOmVrJ
 hB+1qEywjBoawOrKIxiBBjsoI1ZeV/rhpkXlWNvFLKjj5YMC/Qbhm6I2kDvxN6RryUfIIBSuMe/
 6IxvNOpBBouSJUINd55B1+7rEYmm/v4EqPTidaErMRSWxXfbCZ6siaI4xkMqrrzv+PDuOkxtN/+
 HjAU5eH8ZvykX0GkTIChPbRGKRm90iXl3yLZYWs7nCp12jnvdNDoQBwB7UZk52k08kIpgRYCIdE
 aMDiYjSl94gIr2T8dR67SiMFEEebjDTymtTKqenLfjbe1YYD5HT63cE7hsXJfRmwOuw37I285MQ
 =
X-Received: by 2002:a05:6830:2684:b0:80c:d30f:975 with SMTP id
 46e09a7af769-84d0930f53cmr4481473a34.22.1792678759922; 
 Thu, 22 Oct 2026 07:19:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20260714221810.425463-1-james.hilliard1@gmail.com>
References: <20260714221810.425463-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: add Toshiba TC58NVG1S3H
Message-Id: <179267875928.3588521.12640096768048896661.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:19 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 14 Jul 2026 16:18:07 -0600, James Hilliard wrote:

> The TC58NVG1S3H is not ONFI-compliant and shares its first two ID
> bytes with the generic 256 MiB NAND entry. Add a full-ID entry with
> the geometry, ECC requirement and default SDR mode 4 specified by the
> datasheet.
> 
> 

Applied to u-boot/main, thanks!

[1/1] mtd: rawnand: add Toshiba TC58NVG1S3H
      commit: 1dee9a4539b77bfed66b37843ebf1e21999295e2
-- 
Tom


