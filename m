Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4157CA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F46840D8D;
	Thu,  1 Oct 2026 09:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpT3SvTC9gii; Thu,  1 Oct 2026 09:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2E4F640D93
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790848588;
	b=ZPFQRG+iaMSEBhH8nURGAjCJ8uDldfM6aF3XlX31APc80ZlJdn/6u23pt9HqmSU3Vwn5
	 +vytJiTuNNiyLbuvNO3oEHZaDLI9u1He2oFZCYsAf6EZ+FvoqFcy+Ar45vbwBtAlkBpRM
	 adDeVe/lELj4seu4AQTK8xzNqw9WWLSMxU4On+kmpXuvoNhGUButL7/JlWdbWxEsea17w
	 9ILAfiG6B4N4RKadqdccL05ItmG5GCsyaHCJZVe8K8K3xyEOgwqSgdHENrLu+1QPiumCE
	 lL0css6o7CO8WEw48TXpB5/eijFw6W/su3uaQtY+V7hLYqlhASqwc4qnBaYJEhlsdLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790848588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YlxjOqXwb/jshQEWqgs9LnVeTquxnBOMp1TbH0xNvXU=;
	b=bE/oKSkgn11C67hbwvNt9VBKFd/mG/ss+ZyI5IqqwYwZWPOnytEG7ccKX0OACWIl+4MI
	 Lr+SAED9C9D4OSj7RpeYcKX5lzeiwzjMepAYoEHFuCXO1BygZHaq4RiLfa1y/t0vQaDfe
	 2ableS2wij4ND4FPk96VdPRYRe4Jbl/FpQ/54jKdobqNxAFpxXuhx7AVWBGw87J1eNsRD
	 xKpiETuy6wBEZFSUOKWSZAu5U9tWm7aL4VH6E0Ef7xw/SSUonx0JmjvBDw9HBMF4u0PZn
	 y79jr1yfgo0lQNrj4MWf2Fa9HZrumXRw/8wTyExjGlY/msYKq9Qvy+oFuRa60ElhUKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790848588;
	bh=YlxjOqXwb/jshQEWqgs9LnVeTquxnBOMp1TbH0xNvXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3JXhbNQF70seZMhH2IwkeBqVZnRR+wKJrrwYtU8YepavYv+UBmTHxOxr4Tz2SbPA
	 d62D61o9LZh4r9n0nns35SwkFsQvApIPzNTORCuJKqvKW42HEujpomSceXnFoDVjji
	 19cWGHZRlvSHds+S9lm5dZqtXXh0/fpeEL0SUGZivrsDI/vpDHC2Gg4YeXO9mwCf6l
	 DQP9varqWgm5h2P5C8oeLiODfbiwiy0qR+Wxw24AOwoMEF4UDtoOt9gFYGyM/FV210
	 17Xw+B9CdlNVBhcWJCvN3H6AcrL4mvfBRNqcOCVvlsKWNEYkfuxp9xkHfd8PMjiVH6
	 HUJZrRSZw4JSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E4F640D93;
	Thu,  1 Oct 2026 09:56:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A19A234D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7125C60C00
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5EfDnFUa9kpd for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:56:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 52F7A605AF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790848582;
 b=DDVjA1LujB1m/xhj/NcDU8PzneCdtc26zc67HoZDlE1+5UbKiCnTBj7Psmkuq4CAdHb3
 rrU7NM9shxcllzhnm40GeOYP7Wt58PjFv+MG8AmlgCxjffdBuuXggdyZ/xMK/IDDoq4bn
 Bo/wzP1wRslOTEp64mn13wV8oLKpvgUW9rKxvaBfHjc/X5fnAZsH41E8Csk/mSd1L1Ale
 ac1hL1WA6A6Oe0xH+axid1AqzkU6pi4Sanj/uR5D5wFy8YqIpGhTznIrM3A3+kPCRrPZP
 NT7XOdeYbPJJl65jSGez8FgvUoyGL1ebfkIyv66zTyjN7txgGR+hhNUPdgmYMMdM5TQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790848582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=YlxjOqXwb/jshQEWqgs9LnVeTquxnBOMp1TbH0xNvXU=;
 b=sM4o/aHzaXpkhhkTTGGKSGM4W2zAzE6Ti4mMmbbdrmIvF2cpzE4VmQSpSxstGEBzRiw2
 4ZGoywouD0RYSmqRAgkRHl0cI61bFqErB3cd8SP30ljdL85sPDtyjOr5ekakbsn5A5FQp
 UPcTlrz6fmad3hEaXTYmND8/dgxwjccflsrWXaIeMWffTsokNADPBJ1KDMrOvDQ/G3QLM
 DB12GUpb5Rf2LcugutCltDgT3JG7/Y7btfO2anPsEAwi09VheEf62B1wwFIQuVLQR6yJ/
 YMiHIRuHFcd+iANYw8P/IFLoYfDkbWVEC5tQFH1EWHlo0/eTT2qUYj0wMT8lPIiT0DQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hl4kXm1M; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=hl4kXm1M
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52F7A605AF
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:22 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so28731005e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848580; x=1791453380;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YlxjOqXwb/jshQEWqgs9LnVeTquxnBOMp1TbH0xNvXU=;
 b=hl4kXm1Mk0PSMA9N2MbJ3HPRx133RncftP+tnRhufRhr+Zc+Na2xkNYjwGMzJqRWlv
 Di9+BEqDALSvVnB1pA7uSWJhqJbM1hJDAB4caEIGN7fF7g7f2YFIBd2pputNDMD92ha5
 lxLwS2ZvDtRNQuX0EzIY8DDU7N6ZnV3bTbUhzXnPT2f2tlBcYfUYOUm/Bim+PmcyQRDK
 ynThpfZrMlylpKKxJEgjWU1Qh9lIJs/xS9GorZ9x497U1h/x7xVXOyTbnKDhyR6F3o7v
 +7dCFf1fTU4qB+my5MjbfPXXdIkH52Obz2O86UtjnJJhnOq0L/4LZE3U1NrkgPh2goen
 9ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848580; x=1791453380;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YlxjOqXwb/jshQEWqgs9LnVeTquxnBOMp1TbH0xNvXU=;
 b=eojUTekJgP0vLsQdvI0xjXJNlkrdrZKRhvBDJIVznSOpeDijHHJfBUUjcsDOtV/PJu
 hJxSBvFJ7ZmWFGkuQyLDUhnPb5w0LdMg3JGFjfGimuNqxJb6BRY8rAf/RIetr9ZOQ5zQ
 O+UKgyTKHexWhF1Q+/lG5hCH9g4vEQfBC6mHZLbqnOeq0t7W4UQqSpByal1oaY4KGNo1
 5ISAp9lDIIDkR97tZLTMHQQmAkD8NC9PPHNIxqmLYQaevUksWI/JxRziCLYRAIUfDvpB
 GH81Tr6SlEGPxazvvuT5LOfrExfma4xaCvagA7LsUV2cSW904/bZSPPnREalIwnAhD5I
 CDgQ==
X-Gm-Message-State: AFuF++mDQ/xtblD0fpRfF/314bUOBrpFtvT8A6P/L6R7anTgu3XZFgpP
 RH+LBpg5jbKkvvPx0kxFX2+exBvgd7uEKTgWAe2dPXfjU51BEloBkTyWLbcPouR7O2LPHVl6FXb
 92ZhP
X-Gm-Gg: AYBFou3jGc9/dIuTZEQqnt14yid15nyimUzZ2CulGsQ3ymY07hSEwOWs1J1fiQrop1n
 u0iYoUJiP8teUl37SJYxnUvjFHFQEPQLu7BU9rD4NFWphRlzsNqGQfs7sFgnjeSTXZ81pmhRK5y
 FtfvWbeyuIiOIdkUuJ4Gk7XDZktdTO4Se2LEkKDiNbCPLB25JwGnWf+45hG9QBnijI+HtnsXEDT
 FykuFtONvv87lx0tMNMT+Tr7BJb839EmomWyUeTgGPjQSuB/iRlKc0AZ6CA8m6logXJEfuj2X5+
 svzP4UH3If4jqy4+AyzL7/IAi39Am/CmkO7iCS1lXcpkEzfDs5o18fJ4QVVCtDxtFkSoDHV/bfl
 gZZghRNppSHteRqI+VGVDZmsYeN1QqyecUuur+NlXBuI5itFRJM1ieZq6Va8l7Lr7PtnPHz9XlV
 apdYYeFG9SOCd6NUt695LMZsRJz3VRLYrWhCS65Y7Nk+A+PkBQnp6N/deCYiJNmTCC7UJeWOOnC
 sySRTiDCepjTAftMGu/PsoK6NQCGjXPgtT4jjWX0Kx3YOQJV6o=
X-Received: by 2002:a05:600c:840d:b0:4a0:108:3b54 with SMTP id
 5b1f17b1804b1-4a01b128472mr75379535e9.32.1790848579966; 
 Thu, 01 Oct 2026 02:56:19 -0700 (PDT)
Received: from toyger.tail248178.ts.net (p5b29ec5a.dip0.t-ipconnect.de.
 [91.41.236.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f922ac4sm54012045e9.6.2026.10.01.02.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:56:18 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.u-boot-project.org, Vivek Ray <vk092kumar@gmail.com>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, u-boot-qcom@groups.io
In-Reply-To: <20260610135440.1589268-1-vk092kumar@gmail.com>
References: <20260610135440.1589268-1-vk092kumar@gmail.com>
Subject: Re: [PATCH v2] arm: mach-snapdragon: increase compat buffer size
 and warn on root compatible string truncation
Message-Id: <179084857801.7191.14848127207446024029.b4-ty@b4>
Date: Thu, 01 Oct 2026 11:56:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Wed, 10 Jun 2026 19:24:40 +0530, Vivek Ray wrote:
> The configure_env() function copies root compatible strings into a
> 32-byte buffer prior to parsing. If a compatible string exceeds this
> limit, strlcpy() silently truncates it, producing a malformed fdtfile
> path and a silent boot failure with no indication of the root cause.
> 
> Bump buf[] to 128 bytes and dt_path[] to 256 bytes to accommodate longer
> compatible strings. Also, add explicit truncation checks after both
> strlcpy() calls and emit a log_warning() with the offending compatible
> string to make such failures easier to diagnose.
> 
> [...]

Applied, thanks!

[1/1] arm: mach-snapdragon: increase compat buffer size and warn on root compatible string truncation
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/17943d4d08e0

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

