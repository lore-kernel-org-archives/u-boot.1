Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DC606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fWIukmNe;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RF6eTKqd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC45960AB3;
	Wed, 18 Nov 2026 21:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id znhiKYkoRujG; Wed, 18 Nov 2026 21:44:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E826460A95
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795038260;
	b=BhgKa02ojsr6gsHWfk8mBj44goZQ9P0gN8OaULKorEyfSKNQYdWAVUd7CqQbBjtC8YkV
	 SlIOsP0LSNXyfGZjNTxwjF59tGSIiQyY2c6TB49rPwiERqZ3Ge0FF0klylfRb8YpS05Fd
	 FkEsn52ukiu7DGwjRDIiiJyScVlytdMuBsHrIK2mQBn244QO4dRY75lMEpg0o3+QEeBxN
	 Jm07EUOXhrWeI3VSTztKcO/i6kgrTgP2FAkHQblJnwG3zW9GUepwkPylTncLmmmOd7cvO
	 V5r6Oe2lXhdlojd0bLZqena7nHJqFE4pXAYm8qCpDk8JLSVxeLSNwZYRS88UFuCjZDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795038260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EaccJiTDXLcN7RpVZU+6eWQapx7XoaM/j9fdxXtCvFo=;
	b=c4D7MlUPsSdtwbD6bulObMeQ48E0mboWiOOfmbtH1Xmf4w3KESy1AGfPqEQ5s0f/Sb+R
	 DNXZH9ei5lA4y2n3ifLrIMjS+tGo88AF+NgidlN7joHMErFar92FZBdvj8+R39F7zPG6r
	 3G5ABchlvReqwQUb8tvMr/SzUlPUusPM7ZF7XkoM6S8AaVGgf5iS4ZRAxooT5tdDog4HD
	 KVXC/AR64diXmEL5McERj+hZXoERhedsHv5lmf8ZcJXaRJhYOZKdPATzjoiuB8WVWPTTP
	 fD1iCywaXNCKbNfoIM4xMkb+SfRtYWFQFELI0gMZ7DOLGV0hllbagNXxIB3Bm0/QHKQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795038260;
	bh=EaccJiTDXLcN7RpVZU+6eWQapx7XoaM/j9fdxXtCvFo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fWIukmNeCBvyzPlHhK6VB3AwUuMbYA9oimtuCc4ThnZoK6uKOIhP4yk/UKWyshwa9
	 1hIxCsqg36O+oYCLrX7PQxaWqlAsqsNdunUmxaHmhD1mUwWKuuKssxCwLfHJqTvL1w
	 mEJr02trcY52RjeuAQJwxeymmThom4NFZ1kfkW+XKg7+fnN7+m3nRDg2SLt1nJR+2P
	 9odyglfmMS5gPJVrHSQHT4QaNbRSyRHqCjc/ZfcL5EdKqYVm6T94Wyq4BQCnv4BquH
	 VFt3fCyn1/qTj1f97R2f24FhzXT2mfWXD4rB7iv6vqyQSxZwwPAuJH9f5RBD/gBSSn
	 kTRQSSBN0Fymw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E826460A95;
	Wed, 18 Nov 2026 21:44:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B2D8798
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 692E280E2E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HAi8H6PjJLXU for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A3FA80E25
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RF6eTKqd
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A3FA80E25
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1070463f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795038251; x=1795643051;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EaccJiTDXLcN7RpVZU+6eWQapx7XoaM/j9fdxXtCvFo=;
 b=RF6eTKqdtFNG+OZKhMgwHcSuFcRJPobxKUxxVOh61EOeIg0tLSLrh0zUBX1aSQV4E5
 w23kxmN4aCHJYY9xc6e444vu8SLmxhmTK47TRJDdoDyskwEbwly9VfdfCOAeuSFKq7c0
 iFW6k33rNotH0PW1ra7yiHhT922/6WicCvvXP2miT6hSeTgeURa9v0/HKubaE9QhE8Cb
 I0HNN6N1ebgqiDkczyliO+Sf1FErOG6VZpuBjxGYrM0GPZ+V+htaOK6IdAhZBLuFXWaz
 C6c6ZLmbvLFkexhoupeJfDEV+NNw/zw63jLroYRHtGhUg5HCLULEATCLKIBTztHmViVh
 aWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795038251; x=1795643051;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EaccJiTDXLcN7RpVZU+6eWQapx7XoaM/j9fdxXtCvFo=;
 b=pXBBr4RhZuL8UhvlXlAX2L5ZrWAwSNo7PonhAKZj68hpamU75EvAvfTnwrdNbmDhlg
 O81t9HqUhl8f8ZJmYe43gqTHX0TeDIygcFBfOVpvwa42JHWG0CknhxSV6BKtFj2h65Nd
 GXF0KBGwCZYs9sdTF+AmAE1O870SCdNlaNEToxj3SLAYCFAJ+sVlRn0bCAGN2FE27Jd0
 16a/z31/lVrLDP2djaj5gdF69UosdCar1gAk+2nAbz5i+S/Z0Qxayo18UUhjh2O+3ozh
 vvLLXEg1xmy5AGHCzSFD/wUtuJ1rmNMJsjglbRlSDzg6SU6Z4AHUln3BcKHmJvSL3/xU
 cFIg==
X-Forwarded-Encrypted: i=1;
 AL+hErF9c78BDB/V/gBAmdQWNLoGibju0CSpQPMMQSvI38nOZDkAv94+mtc9peq+8D778dxjna8pnNc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/7E4F60kMFgu5lQa102caPUNLIuOvPCGPHfznPEw7qKIDOPaNG
 gKIAYCAw1PQwBu51t1uA8o1QRkqAgsgru/n1Lti0qk6tnP4oAMCKu20Cu6+6gdPbZYE=
X-Gm-Gg: AYBFou30s4TjQDBLEesUv5LYf2SA+c0AH0JXfS97CY4qDTvn/UsRNmyTKwkes0/R1Q/
 /g8i64/fftBN9Mrcp1R71UxuvzNgXFejIu+PsT20zNHU6Gojer5KpSNp3d3G6L6LKoF+ALwtba4
 rGj0ogufta7875gkbt7Bik2VMXpQaG8IAGHSExny1f2T7ipqjiIf2hLCWP+UzYCfNIjAVd96Enz
 Ghk760lo9C4Guq9KAJCqe4p9JdHSpYQxbawXkqfs6dmazTaazNPmTdGkdUaiZDrodyz6j0qzwSC
 s6QdA3hhRbCMLYqsEYiVbFXAcER6Fs2R/ZmTaGFyEX3f+L0IuPMSilRKGkjMXkVIrtP8P4Qw6z7
 I/nX389Gjukm3uhxqeZR5hg8JVefEZHNeiQPgp0eC4rAXmjQ1UHWfkNT6IoN2Td56/ws5IS//Ry
 fyMF7EXcOqIZd8K4tS8aQcQnApJgHYaGFV/7IbRHtHbehVhIKamKA/NBjySjpbBg5E/ZhRnTcl7
 lfi1f2dLcJOMTyrL1nYYyey7lGoHKTeevTZKZH6x4WJKpg9W9FJhEC8lJTsCDh5plnMg2P5Ztxd
 2DdgotDWAHibwx2yI6XbcCKdF3JgIuf9PttjJUneZiQoOzMSdCFriOuG7bxwcU4teo7R6eEG
X-Received: by 2002:a05:600c:5491:b0:4bb:5e6b:49e with SMTP id
 5b1f17b1804b1-4bb7d9fb0e0mr77282385e9.6.1795038251377; 
 Wed, 18 Nov 2026 13:44:11 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8450fce4sm700095e9.8.2026.11.18.13.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:44:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/5] test: avb: test the lock and unlock commands
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-3-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-3-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 22:44:05 +0100
Message-Id: <179503824597.2286122.3610850112499138008.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038249; l=591;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=2ZIsqGgk+pRJRN86kqj7tWZy/eRuLdn5vApPk0yL0Yw=;
 b=HhiJDlvfEJvqEFK2NIdFxyVpuZNnMOjcHkkq/NB3mnmgZdhQ+TmbZtS5xurvPk42A/xLSQQOa
 sR+y6ZUOYffDS5EVoglAAWdFeRl7nyVUAS8omqscDJDZgD2afHnKUkP
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 13:52:51 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The lock state decides whether the Android bootmeth boots images that
> fail verification, and AVB requires the stored rollback indexes to be
> cleared whenever it changes [1]. Test both, and that locking a locked
> device keeps the indexes.
> 
> [1] https://android.googlesource.com/platform/external/avb/+/refs/tags/android-17.0.0_r1/README.md#locked-and-unlocked-mode
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
