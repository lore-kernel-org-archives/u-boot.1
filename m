Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D7606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OS+GsGZR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWebdJSc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAF1F60AB2;
	Fri, 30 Oct 2026 15:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c4uGez9l4C6f; Fri, 30 Oct 2026 15:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B4CC60AB4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793373978;
	b=jF2qYErtjwm+z2cYk4qNsNfBWtSPKGp4HDYKxtCUN+iBoeFfkaUMYFoXFsiypItB1wFR
	 eU1kx0+kkzjFZanfTokYoYJA0vaRK6qKt5xtvuW/mvDM64dYJwyAWyzFjgxIAE5KtYzSx
	 ayO8OrdU6jHT5UPpOGWmM5PthrVB1xw42HIwz7kka068VAQsrN21IzDNGaF93eV+5X+Jg
	 H2kjDaMw6zTnDTRip5PPcV0446Z6CQpcaNe/1fz4JZGmoTvNKSki7o8/wsJ02S3tN8LBr
	 NlYUsRodpBo3IfUSIwV2P108BgTnCSy2t5j9VQuafNCAMn4gDpkuWJPRb/tZZ5mdvew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793373978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0AN8yhDLfDQAJi3N1Y4Vx59kAzF4Wsga2nHCeFtqzV0=;
	b=PdA1TQTGkAIYKnhkTiyquWBNr5zKACVTrQU6z2rOE4S9/SF8vZ++16jOoFhskKpUxw00
	 NhIFlnIEitDcFj7yyFEUN6juhszpLKS1zRU9+eUXzNvvYV+1XlHy/ma4JK5Fh1sY7G4lf
	 j5UHwfJHyGNHkrKvRKlqwaq8cD2Idh85VOnWtn6I+zOxl3o0JJuPNZFtteAFAOa3F2qGV
	 HNQUQ/magupJgvs4eyf33BXooWraKqTd/tPpXrlJoNAXI3VZQY4hUS7L7Pic+WvK8F7md
	 3UhIJwDr1AgI3c6FkJfNpOsy9cb+hSKRATnw3phmHa7wPRuu4ev+eb3lkdOfiGmMd3w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793373978;
	bh=0AN8yhDLfDQAJi3N1Y4Vx59kAzF4Wsga2nHCeFtqzV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OS+GsGZRRSeeqbigyrt+RHLSnpm7phvhHlXgqVp7Ngea+0GbB0ELcj3/9h9a1U2lZ
	 MlkhmTXSGSqKBZyQ20h1Dgd0DErT4rD7NJ/E0XI8DTWPhaUQeTHjeCuC/k5nS6k6tj
	 vKtj1qKsmmmJ9KjtOy4DpxgbgtvC/Sn2PFCcl2CfkR3uXczDqJXL6Ohw2ABNEgcpIV
	 vJo3fLu/ewQzZQh6XtQKywBj5NGGJH1Pig9NvGHOyJrAKTEpJTw8EcuL/h9Bi1ULmQ
	 Gc3Hl4ZA4Nyw5VS5UxxsRXKwbxPxBrJVPdNQn1WW4pC0tcnxe+LvwrDrDUHCDO3oJ8
	 WysMVXLwkHBmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B4CC60AB4;
	Fri, 30 Oct 2026 15:26:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 971E7235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C3F640BC8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBR56ubhF_M3 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 15:26:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E04B440B96
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793373966;
 b=Q8bl4Rbr+mOFotS5ktV69kiUAtpxAA06JxKGUyJKhqGYLIKqFi6LZc+taORvlEMElSD4
 ZiqkGgCi8QcoO/W02BVIEwiZ/MxPM0aCoOfhz4D96QkhyPqkSc/XBPVozkBd4aGWEmDdu
 ejMpcgx2IwZrdibMESLM9VaLYZZESvzvnQ9lUJCrBBbjUFTsoq+4a/2sOlr8XLhb6YodK
 GhJYkLAKN6ckOaGjJ8qycW0M4YEG9aqd2Oh0tqM7T4Iw/J8I6C46yhQA1A+NQ5EVQPX4g
 UKtgqlamCLCFM0nJ5NCYMAj6M9x7n1Aqch40lZAHegLZieSPlCrp0Dd1xbBzWp3hmuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793373966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=0AN8yhDLfDQAJi3N1Y4Vx59kAzF4Wsga2nHCeFtqzV0=;
 b=oFOVOLFSlYl6QbGCLSweYbDyUkW6Qk60viopoWdbA6T93yReUOWxkic9Y46vMBXKXh5u
 RP0IOf3aOLs6Gfp9s9ANdkHHQbJ4RgStI8pOh0Q/V60DkHLwCkCEzaCWl7s5s8ReEjOWX
 aeqPGbOSVBzQpY/UcDCEYIgmlDrJoUSPCzBw1x/1f+/UCvW+bFBww5oUWq0BmOkHaQGMT
 2HJz0HAsbtbbwWrfq04amxemiMM41VdlGrIJJvzWfJerd4LT2eTMnzYcwbQTGZZQR7xrH
 KxOsW6eFcIwjcfpIei9NnkDKtTaxr819/6t0llTo4SLBme850nYzxvcoznVvpmstIQg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=FWebdJSc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=nathbappai@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=FWebdJSc
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E04B440B96
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:26:05 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso5568315ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373965; x=1793978765;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0AN8yhDLfDQAJi3N1Y4Vx59kAzF4Wsga2nHCeFtqzV0=;
 b=FWebdJSct7UJUjYIzMVFur5nQks+DNMOsDiYWmt747JilhDX7tHrYnAO/JbZE/n3Sj
 dXL5NzKAJzxE82kp7v3m6PQ0Bg11dsJy1Yfeh7tfBRrc25qLuScRL5vtDys+hTMxbexo
 lQYcqJFfDGYRgHVk1MBLlSdEIr8coeuvD/nBtXBgSQ6jWhK0eF+HJjfyBXPxO7EKmq7O
 wXYHt5kQYz2McEW4+BfjqmxH2Z2/MA4LNqdm82RGA+z2Tmbjv5+OZNlYFO9yokmeZrzG
 8OtNvdJ/nfYd6LhrArZhIY+alVTSaHwn/dJSB9KGXx9/jJjk2lkej4XkamvzQkfxv4/M
 nFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373965; x=1793978765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0AN8yhDLfDQAJi3N1Y4Vx59kAzF4Wsga2nHCeFtqzV0=;
 b=qcskWmvDgGWNyOkSFkUjnyOrgGI0YCKBrKTrY5CZsJwV8wc8lhpCaq8OnrLaK/f8Pn
 15gtd70lfXzc4uaScn/6dBmqcgnTWsK8ttIXNM0H2DglB7e4overWeYjuIluIJdzfWG+
 gm+i8hf6I37OgtG+yzew2NvpNRHGWIHxhxzpf3ComD0szMPLhCqCLKNnz6639RemPuZl
 TeifToORiOF6Y1AS3lUA5xGJhy0qq0JgyZ6UMzFD97vv+0rXlc0Nz9e6zsErwU56xQit
 5TAba9VylDovCiYdkGdaxVloV9vpxCWLSMAPaNJWJpIghaDv4qrZaJLbNSi2iw1jRlwz
 KYjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9cULnGdH1BxwQPxuSU6pSLk+LI9Zi1GnvkmeuTOv7Ty/laoz8XlAhgjzNy5bX//PKlsz5GOA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIx4+OAaYEz2L1s0wuQolWUUrd2G8AYNgLlUx2DXddGiErxuFII
 +i/iTdFvh+itqrDmqkw1oQtUutFcV+pusE2OXkhQ2BI8rXOpwg4qaMkFIsOfUtqNBmY=
X-Gm-Gg: AYBFou2xKNlgpxcr2biGAJBrGyBnrmUqLtg971F8Eku8uZePSiAFPrTL9gRktmqbZXI
 4jYguTfz7f0C0W5gNQWglqOAapUfk1SqXZHFrJsEh+XGow3kYrWAq95ttZmxeggg8NVrvqsreAE
 /vw7AbcBHi7foIae9aZ7NwxMoOmO8O32k2D7cy7yNQztjIaDpurwP8RWLaCGCkp6FRCNPOlh3qc
 j0AC9zVSsWIpwtzEjUr3HsHk8OImgp4XoPvuGPa4bArvPFxx5LzEOG2+QyT8f8IW9k5JElO5N8D
 MymE226uC7d4d0eWo3MCaTSUBrciaOYNeVlfuNJh2T/l879x0cfh3IWkpzQDryHNguH0DYHpih/
 sa4OLWa2e3yJ/QFMpAxs1cZ/UMIrgu21/ZKn+wsVoXBOtHnN3JBqr/M1ghjRK6dQUeW+Y1Q0Fqy
 3nhGFACvWBYen0ZpM1WgK79FZlMVM40OtMnLfxHQ7qkSzzfi9ZgITSuN6EepdOeQxQpFcWliyRS
 2Hzpb4ZZ/94yQJyoR4ynJtMXHtSSObsOY6D4RoBl7zP9NGz9ssF+/YyeUSqA37U8XxT+GGCDHCa
 xL+V85ZcrOhag8h2pnJAP+z2afNoYtO0we1X83Fnp39m
X-Received: by 2002:a17:902:c40c:b0:2e9:8b88:f1ee with SMTP id
 d9443c01a7336-2eb364bbca5mr28901255ad.35.1793373964950; 
 Fri, 30 Oct 2026 08:26:04 -0700 (PDT)
Received: from localhost.localdomain ([223.223.143.131])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2eb3928d821sm9015835ad.56.2026.10.30.08.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:26:04 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] pinctrl: qcom: qcm2290: add the QUP pin functions
Date: Fri, 30 Oct 2026 15:25:41 +0000
Message-ID: <20261030152545.58608-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030-qcm2290-qup-pinctrl-v1-1-f7940c974a30@oss.qualcomm.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 13:34:05 +0100 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> The QCM2290 function table only lists "qup4" (the debug UART) and
> "gpio". The default pin state of every other QUP serial engine refers
> to its own "qupN" function, so the function name lookup fails with
> -ENOENT when such a device probes. On the Arduino UNO Q
> (qrb2210-arduino-imola) this prints a warning for each enabled engine
> on every boot:
> 
>   i2c_geni i2c@4a80000: pinctrl_select_state_full: pinctrl_config_one: err=-2
>   i2c_geni i2c@4a84000: pinctrl_select_state_full: pinctrl_config_one: err=-2
>   serial_msm_geni serial@4a88000: pinctrl_select_state_full: pinctrl_config_one: err=-2
>   serial_msm_geni serial@4a8c000: pinctrl_select_state_full: pinctrl_config_one: err=-2

Hi, I can not reproduce that warning with the same device. I built
u-boot from latest master branch with max log level option and early
debug uart enabled. Does it need any extra hardware?

Also, I am wondering if this driver can be written with pingroup
support like sc7280 instead of choosing individual pin functions.

Thanks <3

