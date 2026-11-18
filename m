Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD204606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UuRp/wSZ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LV9xa+h7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C36560A9D;
	Wed, 18 Nov 2026 16:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLYJKWjn8kCc; Wed, 18 Nov 2026 16:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C15460AA0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018857;
	b=BkY50tj+7cXYnsYLX4K7oNVHZrQM+ioke/UCNrIDbKHP87YFPAChCWUTCAkUrVp6/+GM
	 h/tgESexu5+UO143tabIARQpXvYzdhuuHbxuoieuknsh/2l4gR9gmTx8m0a9vk9uudG/Q
	 RcUUt1EjgmB1qmdidFjb0dG8NHFY76VjOWsUdVrRYj921a5m6KkzvfmSm/llBrzFGLgaX
	 AAkVl7s0bQHraynMKc/GKc9U4XsAjuQr3H4aQ8HRWajQkLIokn2ronMTFTvxxIEAm9AoG
	 Y5f9Dvp+JxDLWxJFZMZx5/bdNzBCP0aaYw/xnEvhQ4HkrvyaKPh3DU/u5Jo6QYRyDfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018857;
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
	bh=aIOw8h6Ta4TMr6j+ZFoFS7VvOZRK2EwYKXt7uQKtmT4=;
	b=isWa2TP+qEhauLnBpZ/AnJF0F5T71Lhr6rhnI/TtoZ5IgJtk3w3KXqfyivDT7ZqWpxLK
	 qySsvrJCAWT8xf8EOkDQKsPV+enPFzreEbLs8fjEsS/eLW8gMkY8T/ZpchW7sTmderRdH
	 1MTqcsko3Qk5ik30O7dro0Y+HDTAX3JhNykjfvOQI2Go/E7OrswG0ArXYKGy7jjC14SDW
	 4QxZQMHDCvgEWdQdzKpbXystMu5ey5DG4HlbnTAuqTPxdgzWzE69Sk/eBSwt0X+WKDMHl
	 0zZ0vIVn0fijzX/a6OQwI7k1dqdmA7IDUjvN7MM/nP+Nr29sxttZaw/LePQbW0aV7GQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795018857;
	bh=aIOw8h6Ta4TMr6j+ZFoFS7VvOZRK2EwYKXt7uQKtmT4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UuRp/wSZoLKkScu6/U8X6PUNoa9PrDjr6mm0ev/4OQYdIB04aWBYvxQqBrS75j/SH
	 14pFyqgsOXIfxDcW0NxkggiVbETFGW44ySDrRNWcclWOZPBOSwV7uJfTQmtFSuq+k7
	 FFbpsxkdEQPqSXfkD8kbTFQJY+FqWR4tr3lq5p9ulvKH46ix4KIpC23P1WcgNZogs1
	 XT2zAyuOl73dOt3Z/wg1tN8Nt1OyWIHy/6g5My30LwaUSAGAfiu/d8NAi5uWyuwZzI
	 AGSDqVS+q5eSH2dj+35nTn8bzYjGi2HA9LV2dyCyFrWYlHRqbfY7S3gNwUYMQU0y1t
	 VnQRMRYeLUJgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C15460AA0;
	Wed, 18 Nov 2026 16:20:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AE959F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BEA281138
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvVIIpR5ag77 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BC6F80F7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LV9xa+h7
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BC6F80F7D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:49 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-491971ac844so1192705f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795018848; x=1795623648;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aIOw8h6Ta4TMr6j+ZFoFS7VvOZRK2EwYKXt7uQKtmT4=;
 b=LV9xa+h7Bkzy5RAgkAMspC6aZjygh7CqZyMD4NxL32jKWmc7oqEm1Ucfi8BYSGFmyD
 B3DbCYvALgtsIyJ130pe0NIpIPA7PPJ8DDCHRPikG9bb4tMcyID/y6hkY5wCmFnaTa7s
 dcSDzNSElpF1XpVkhCa9FenDwScGNZ9jthUZm9+q2GGn/Ws0ABasE1Ub9XUSBMhgKBoE
 xGVYxXIg4A9P8hAWqY3GaI0I9+yWrY3SXbrgi7e9I4WIX8Ba+UU5Wz10U5BTaOnjktqo
 8Kg3dtLsdi2LG//ivPC8mbx+7g6rWW1ZmUBWab4LJ4qxQcYmYDIdzyC34dqOsxHntOxx
 AOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018848; x=1795623648;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aIOw8h6Ta4TMr6j+ZFoFS7VvOZRK2EwYKXt7uQKtmT4=;
 b=PjS738Fk6vmWvein92WJHJOB1pXiPL24YNIM/MTmXGE14NQz0aaLcMon+qql0RweaA
 rWYL3BqeqV6EUCc5k1S8gvSul7vuVlkY2vGrZGzceOQ64/0uwWR62FKI1AR6maD5GNgr
 SS+2KmDkuvugCwgavMC5tp18sfL/32taxvbyc1blhG2c31FePOKonkGioXBfL4xqwNxb
 Sn5XV7aPGp105AEvOTHU2vEBPgPLvGLY+CECIa47Al/diJv77PU3SHkpbvwgn18rh4TI
 3VvrUlATDjXQLEPlgUjesFoNQawxm+J5PBBtNPMfukaQXrKoywUsqGHD4h1bsch2sYKw
 rm1g==
X-Forwarded-Encrypted: i=1;
 AL+hErEBT/UZEO45kqdVdXZRTYZnjWK9SHIBtwyjE+4L5JyYK5xbDz25yq/Ia7nzjWhQrhg10bOWV6Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Ww/xYo2KeV540X8+xhiHn8Mk6g8Wjnc/Y+1sfpyJMJz/IDNBK
 RpufzCw4EYT/TFO3Aps5oBVE2ogrS4ebnmG7UZVYnwxbfp0M+Gx21ZMg92zblZ+su+Q=
X-Gm-Gg: AZFdTZdmGVIhKe7p5PaO3Vql+ldkz3Jc1XPLd8oTxzBvxsLk0DfzMDWo8B2ZRz4tNsj
 KlEcwt941jcBFWi2ZgfYR1cOqjIuqTOQRkdQSXrs7CCTrvLIDSydf3eu/AZGrIgTTicwGM+UmpD
 +H5Qhey8qdUycHLKrBfcwb9ar16NXqlojm48z1Dq75j4K6FbZGFgts6eKQydtEJLSsWIt9DIHgJ
 GVoyPvxyYeWfofUOd5ndL2/QiRTzmFc5MHGu88oZ8BI5nPuLfzT5+X9VdLAeE4lJatS/WAwag77
 Bxjw49hrT+GgASmnJIhkg9HhzFgPq7dd8I4ozu0iudV4aW4vxbvbPpPhxLgmR5OpjXzwoTwYw9h
 FiF9cAMgvx9VsD4TrWUR5NRd9W21f6iDE0wxdSuGNiny1k0WE3FbiXREroKLwOA/xTRLZoYEWFm
 Ne3nFZmiNrk16ZU0OM/0RehED1n8wHnOOXGN33p3qhZeyoeWzCzDlc1li8rIsyUe9++4UQGEYRm
 jpGHWzCfJRI00z6Dny31sR/IflqFIHIIiXXR24xQBe9wv65VtsShjsg8FToSkLACAwZm1ZC9otN
 6r7CcAdjLDXaMOKj685W8LP2K6c/ew3i69MGM9vhu7VVoyANUJK/0p9wkpTdLJLmdalomosh
X-Received: by 2002:a05:6000:29cb:b0:498:a72d:c097 with SMTP id
 ffacd0b85a97d-4a63a1e06e1mr4602720f8f.19.1795018847787; 
 Wed, 18 Nov 2026 08:20:47 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efcdsm5537874f8f.5.2026.11.18.08.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:20:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/6] fastboot: block: Add GPT/MBR partition table
 flashing support
From: Guillaume La Roque <glaroque@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>
In-Reply-To: <20261115-fb_gpt-v3-4-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-4-7ddd7ef832f6@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 17:20:40 +0100
Message-Id: <179501884041.2226612.339562204627410573.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795018844; l=661;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=L7NE4vbbPF+NUIYlVuSgCSx/lFyO8dwNAthdtZdtF7U=;
 b=oKAlndPJQHTI3MAQPVMRAQrErhEcXXyuWLiPFBcDeCLbG5L0R35x8Oto+mwbTXtYShbvwOOu0
 7DMxjxTjrKEAyPo6QBJB9DtnHz+E9A+l59M2566VRvY0SwZ2uJq6i/C
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

On Sun, 15 Nov 2026 16:35:11 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> Add support for flashing GPT and MBR partition tables to the
> fastboot block backend. This enables operations like "fastboot flash
> gpt gpt.img" and "fastboot flash mbr mbr.img" for block devices.
> 
> A device can be selected with "<dev>#gpt" or "<dev>#mbr", matching the
> "<dev>#<partname>" form used for partitions. The device is parsed by
> blk_get_device_by_str(). A missing device number, as in "#gpt",
> is rejected.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
