Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A2606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YjIlZphx;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mQAdtjjM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5272B605B1;
	Sun,  1 Nov 2026 21:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Na7Zh5y6Xtg3; Sun,  1 Nov 2026 21:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A66E16060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568388;
	b=aNyqgqfkVak75LLcwhR/Vi3IFzOmLbsP4YLb7X77Kg0bZMV+ww60SrOMneh0rW6/tDOd
	 WC/WA455LyQgkF3ZWFQsBsOtHY47WYpdv3GgraA7FvAvQRtYRsItLwkGReaB38ZllTQai
	 /CLFlsp+3+9BiWziFydRsWtlgzulyAjlZwWCKtsCCmzI4mTT/lvrBFEJe6sdVbC6DdSxf
	 1dp8CPm4diy+LsG5w1jTEbUZIo2guYDcTUP56E64CssEgm5ZNZ4tSvLigsKnnXo+KZQKn
	 qpeoBTtVVwUX0ryvDnKCjmvPID1TjEl68eGjy5tjHOvYaNf1SjlzybnOeBFSfMcgO8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uiBcszUJ7dUgbbbh8+nIk7FGO5hzcNFjA0VMwJ2a2JE=;
	b=qbe0hARrIIrzEcOK57FxZMj4EkRqaANgEKyB7Qy7qCE4/uxyV157a0WZSFkLZ9ZjvGP4
	 gEuexFJl5l09rbMeYCOyy72URVBqjPEtgR+/NntnOIsgV3Trd04HfQZ7oLAaSTXPSzGI3
	 KjZmjyQVd1s5dPe4QJOPWrGwbx6jjOMW69FCPVOngG4FCRjy9GOpGd34eNlgqUc24WWSb
	 VhiyDRFKJkEXuJ3wQmn4VAd6Bfl7l0bWGslrMBDjbkB5S013eQEcyK8y/xjinWwEy91WF
	 envze87J2jUGpFJp2L6At0dC2FBmpAn2GLxhxKjMbp5aMZfvymDAs/bI9NwNcOmwTMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568388;
	bh=uiBcszUJ7dUgbbbh8+nIk7FGO5hzcNFjA0VMwJ2a2JE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YjIlZphxrpd+WzhxnOz77FNgpASzygWPpKAVBzLo3SJfhuoTaL2rEVP7QCR7kMBJF
	 8hZMJLvEw2tNJWAxXpNYxmtWHmGrA+kRWTciq6qlNFDd6wnjG6dF9oxmZq2tKSHkRJ
	 LA7Il3J0ammrCfO7ZVzaZtq4+kk/1n68xaZaNISt+cpWqpXBj3xAMshzuvvlPaSgdP
	 oFdamUxX1/So7H56t+87/7foUKTu/3BNvF+oMagI9nJ3ybYY5jB7ZrZfTPvqVxzpDK
	 rePF9iSa1GZxyKfHkPv706ozJ/PM8sFPjOOmReUAp/s2a21ln90tsfqiTbh1kqRlNv
	 KLLXczGKeNVeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A66E16060C;
	Sun,  1 Nov 2026 21:26:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1F03435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2E8280D97
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyrlSkU4XX7I for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0667780D96
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568386;
 b=HEiBrdcMTM2jtS25ODb9WZOg9OlRiEnU1bMv1hXqT9uHXP1JwcF3OdZ8W/jA34THtXq9
 ALB2L8EQe6J7uBcNxNq7LE15opgiup3o0F7L/Op7vQnyUTn66XjRTWwdUKlQlkU00odex
 ueKt6TzfPLO9VX5ZTC8n6CQoez3ZOHr28IjQnMOxy1arzpz9Dga5CgnPq+AY8Sd8cBhLb
 J9O+YwKdWGOktXdDtovUEkNfIEO5NIYkPySEep5HvCT2ew0EjOIe1VXWdDG1AEvqnCtE+
 goV/vfyCROTJNcynGuoYC2ucSi6LowjC02yBqgCzrrSNtgAni8ELRH0O9HDwkgLJjSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568386;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=uiBcszUJ7dUgbbbh8+nIk7FGO5hzcNFjA0VMwJ2a2JE=;
 b=lRXMXdJwFlMJsoBG4i+N3+Y7ol9yebGcSiYVrFoO4OdTVCg6nTvOlG0en9tPOdPDgFeu
 L/dMNkTmQ7Ew56y15VfMHGQo6YOjf0UvihlBE5l1LOPRJoFkQrqlGXEylOZUehtvn7cIx
 Mk5A3ijcTLSaltVRvpHo4tYYqyNgANraNr8YmEuJHPF/Z/3r1GWEbQAdD46veWsrokgDv
 tyZMeBi67888iMvFnqM7ux9pIH5lAdw0ArSaOcHYmvMz7sL2Zcb++ZZQeaTSXfsmSiyMd
 GbFx6gWSEI+ITYF/AiYKcjQqL5FA6jjXnqHytyCc96vqVtSIxen2OFYauOOqyeG5n1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mQAdtjjM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mQAdtjjM
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0667780D96
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:25 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-84e513874f8so1700525a34.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793568384; x=1794173184;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uiBcszUJ7dUgbbbh8+nIk7FGO5hzcNFjA0VMwJ2a2JE=;
 b=mQAdtjjMCh97EO51f8d/OlSMfFc/b4+jMq4rvo68WLV7q18qrqDygiZLwR5H7Q2O9k
 MZ/yDFg71ODWnBXXyPRXz4wn5YSt4yZSKo9W7a1GbvhkkQhI7luqrquQVbzngHpmaXEE
 D8Bw5p9GU93sfuZPjP/O03z+YpRtS3+nomc+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793568384; x=1794173184;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uiBcszUJ7dUgbbbh8+nIk7FGO5hzcNFjA0VMwJ2a2JE=;
 b=cQGd05T7d3Ixaj/IAjVGncAPptZMLpT/9JitKpkc3ZcZ+jqY+k6TxSS/a/AP4DO2Ue
 iYT+x1zIhKQWkBrgRo8js7bdpimf+dYcBGt/nfZsH6VEKCmBQp8sSaJszPRijn737cAY
 zwkrXPhAn773yy2jWo+vDA60DGm+wQNr8Kr0MuNUFeLxnpoiHr2wbc3ETwQK2DtJ2pNF
 JOrV2imC4kGyVuo+hAZBfeDICdb+Lu0EEYoKpmip5DJlIaHStdaO/94xvrJQMBE+mIpo
 TWd97fGH85Ts2EQvX0SF+mmCltxA8opTy05SJ1qeZSyLEGz1gFpp+jsUaeoUBSTeQhJS
 Q/og==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVOJx6zUVV9wcPuuKFXI9URa1ruQMseOi8lKeRGsUSJQlw9NPV6PGhW9rQzWjCDqUGZuypN3o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK9P7uF5fKPDIe7QOi4pMSH0TFUz77ikVonePX2stbk0aoM6aK2
 EnpMLRyV6MH8zXpLJRQDHuSnGua1XFwpMRwjwVSr9nrA64KHCyroNuZxzevdff6+xd10zTIPXh3
 GoVPmVqYcTCae
X-Gm-Gg: AYBFou2qdjxaoVBzcsTeKwtilXH9S4liCIvEJmN/Apfex/lSPPQZuWdQ+etoCKDX5Qc
 KJ8r1gngASYTxJfDRofDKPGmjsIGhtzeP7XTAIOzh3WR76f+addJlmd6lTKlIpimRo5miIZEGCV
 dDhM9jN8GBaJTBLBDcvMD0hOkoIELDJxL3o/JiRMRxdXf99AIb107BcebLbB4XdnhjKAsBOMSNI
 a5MpBGaaoteIgEgUqYwuU3HIjDbRJBRwOXIQHmFLKW48JFuOuimdeLCzXYwbAl0H8KyZlvaaDtK
 1+S8DAadA9zH/M2YVm3g4k6htbKy0n970Za+2Hc3H/VW/y6/5u5fGUaI3dMYPfrkNydGF7ui99R
 N6bzAW1Cw0DDlH7YZdPlesQwDd2Bu8IjkqJfhgvT3TN50q8p/GZ46mzwhTPAzVxMTFHkoplyYp8
 4czdTvjnvlZJSpyNpJnz54murYmZnmZsUalYLBCXQ8si7Hn0U/BAuU8WXoR4XXy/XLExyFMIpcT
 +cp5jtZQTDFc1b+9t2qqjL7u7weMjRSFvPhmo2fo2N4/mMYOSuJ8p07/LMC0lK8DlJrTEZC/gzz
 fEHmitoWtHnvpRQFdh73J+/jNalc3Ubd3rC/7+MsAsmprLVntXqsr33T+oSt6rEReuFWkgSfiLT
 iHGWlt1sTc6q9KL27VL1Z/+oB65mHZXfyzZzCEUjnnDSHoUe6go3DijkoHLwvs3x5HSc9rposbM
 8naQD0u2bO9RKJ1053th1bR+g83wSwLA==
X-Received: by 2002:a05:6830:43a0:b0:806:dbd8:9929 with SMTP id
 46e09a7af769-85d3652ea54mr6192006a34.15.1793568384381; 
 Sun, 01 Nov 2026 13:26:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm7405744a34.4.2026.11.01.13.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:26:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.u-boot-project.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
In-Reply-To: <20261021-v2027-01-next-topic-am45-ofupstream-ti-pipe3-phy-args-v1-1-0570d8b7861c@baylibre.com>
References: <20261021-v2027-01-next-topic-am45-ofupstream-ti-pipe3-phy-args-v1-1-0570d8b7861c@baylibre.com>
Subject: Re: [PATCH] phy: ti-pipe3: Fix reading syscon register offset
Message-Id: <179356838265.224230.4231981059266612875.b4-ty@konsulko.com>
Date: Sun, 01 Nov 2026 15:26:22 -0600
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

On Wed, 21 Oct 2026 11:37:38 +0200, Markus Schneider-Pargmann (TI) wrote:

> get_reg() parses properties syscon-phy-power and syscon-pllreset.
> In the binding these are defined with having one argument but the code
> currently doesn't accept an argument and fails with an error.
> 
> Change cell_count to 1 to accept the offset.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] phy: ti-pipe3: Fix reading syscon register offset
      commit: f09f80c9a40d5381f6c8440c86d5579fad50aff7
-- 
Tom


