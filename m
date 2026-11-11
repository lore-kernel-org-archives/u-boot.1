Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE65606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n5oPFGdF;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WlJPHs5v
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1D64408EA;
	Wed, 11 Nov 2026 21:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dP0notck3eyH; Wed, 11 Nov 2026 21:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3843040963
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432371;
	b=TR6ZAo1sQR8koouJ1i/SzhhritqSP7TBHm5c+sAZpJVrdCN1099ECnQEEe3D2grpKhYp
	 iCIqZ55ENUq5KMzcO6Gx3AJ4Dz6rBaRGWXWGnsOWa1A5YbxTzNn2qXa7mw4Yf3G8tP5EW
	 qFQbTPXa3lGhslT0+t/OwLyoCsCSCZp/fNSWVU1dkaV0Ykr8JNOQu5g3zIaCovZCLRkia
	 9t0C3VEjn236YT5n8cdaxxu8XB/RUiWRZE603SbimvhFsvAliIQISDQF2BVU7E3+x60s9
	 36mUVcxCl9aG0mE3v1hDuGqDbE2H3cQTEYSmQLsY/VZlHJyGmBkW7mjzUmqFiBp9lEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6Bx8SwtkPUPPMWLpkK3ewcrQ/BA/oPkl7d9J2rgCp1s=;
	b=nYnV3QCJ+QPitQvxdwFd1yiFCCOtBMdZhfHs2SJxsDi5FS70/rrX5r4zQAdocuONz1QR
	 PpVEvWnu1OFx/Jw4NkgrNPve9td7+WowCIiUd9WeRx5ZA8MQT40Gje8AAGZYufG+K+URZ
	 t+XrcrwnN9po5WFcnmNcaE4IDgMPwLV17koZQqYm8KvttdDAza+QsARVdObCGnmQJqX11
	 HuAmCoRwM1Vpj3uGSjVLNnHz8L8iE59G2glZ5WmVZGw5PuggZqmbffFSyug5/iws8WK/R
	 3/xRIMfsHVPCv6QJDVSyUFy1j/HRWYcdNCpDHhNRgQG0l4bsqNP7+vRtxS0HdFNI4ow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432371;
	bh=6Bx8SwtkPUPPMWLpkK3ewcrQ/BA/oPkl7d9J2rgCp1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5oPFGdFahVIMf0xfN0LdEaV/SgT9IqLbrM3JJe9pvgPaJuJvbnhqWzj8vgtDwnes
	 BMiXNHUJ4wJ5+/SEMQY0OSgkXZQDJuPXUlYXfCnRH6KtlE09d9qUr7F1IKmR1SOJJr
	 mkxl/oKMwilf5WRY77Jebmo+Us6MhhavLaREHH4CJhIbd3YmeEQqtY7SJTe4h0RmUJ
	 uQ4ZKwlrvpgvAavr8mi4OkScT+3Mu5YMPncQXvfPr5TDpz6wLUVpRtfIzurImTsLWf
	 LadfZ7VIABjhpEkT6Jg0EsoNMaREE2zi2a1fJpQdFb+LXI5hozC9lo0LNIgQ141Tri
	 V806N/t6RTvWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3843040963;
	Wed, 11 Nov 2026 21:26:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B381FE09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF4DA60D91
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0JpJ7_P2zUJ for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B75360B02
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WlJPHs5v
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B75360B02
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:07 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-854b6e2e41fso1867998a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432367; x=1795037167;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Bx8SwtkPUPPMWLpkK3ewcrQ/BA/oPkl7d9J2rgCp1s=;
 b=WlJPHs5vBdP3vWs1hLmAe/lBzR43Zu5FGJL1iXZ66z8inJhS0oBIf/dxHU23rZ5VRS
 LeB0dMczainULH3u95+hlzgmPZKDugextg3hMj6kPcRe6kn6L5z+KNH0qb+hX6s8G55S
 G+10spWpU8FvPMH3i08PY5jhQ2JhBh/+pR+Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432367; x=1795037167;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Bx8SwtkPUPPMWLpkK3ewcrQ/BA/oPkl7d9J2rgCp1s=;
 b=hfjZv3IRetbdjIUhWVmzpqYgH0XjsD3hT96RMYU5JwgTgVvKkAaY9pv0IqlZzfTrZy
 lsNm7S7Pd1vBGBghpeLa6fmgMVj4bLQNKpu4DTHMnetZ+OTuS6L6eaMLVy0GYrBCiFWp
 mtw1SN/fxzQmz0cSdzm4HqYGTBnN8a7LDKEnnzBQsRrOCnsmUe5qbI62RRVRCap3d3/j
 1is5HrogxJhAp2gcpNtKjHOP6c4kP3ZIO3bDR/I695QgDLV+6+idT69BSYKhUO4q8rzc
 0dLatc1JE2z9uEjsGmIWfhKFeN30vPMdtewxfmp6UiyDF/WWqmPZNWNKlJ0LrBDBWVw8
 ej4A==
X-Forwarded-Encrypted: i=1;
 AL+hErEvBWapSU0v8qkqD+bcuK7sS/GvDrHDphHnqWXu09tDcw2DP7VH+UiNM+HHwEcqQSV4mVgQNAk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+v6cJvyNLVHTFqLIQ1vfz2QiQIuKhRTfEGm3fl+2KObRkcnLHS
 B98Vzv3KPUpusuxfMOE7AE8EWyH6odwzr3wKZ7fgZP7mvTNZG0xzV+HfiO8YzP+gW7qTD6d3NXn
 URXlmcdbWcmtj
X-Gm-Gg: AYBFou1qK+QWH3bcKLc6UCjUffScHLMT3GWGnToURvC+GHtbAmC8+Mgn3/C0HbGxaMX
 nbfa6HSwvldW2UGPo5BkPrIbsYMSW/s0oYLcpRT9mpRc1Rr5KWL4JofjNIxYpBNT5/M5fSYRuWG
 e1d8KaTeoXDbO/qnPKf4L/75b3Ieg8q9y6FPb8z6PtXg06qzz1ke+aPptvjZKtfMHFdQFLimbBP
 CeYw3TGZIbDlMwxtCsHQ/mqwszzLx8g6koP1h5QtxT4EU9zQfKFFJwP0ye33wNoY7xSbqa1s3zh
 GA0pgSIbbsi61sz/2/DV3yTHToyEVlwmicdt5ZvyB7WpDyjtOHboNZ8bFmCz9aXfnDUR8svlIT9
 5J6Pm4GxOSDgeAtCu86oDF+uaZjUHeUd/F9Mu+TQ7u5o0Z9Vdvr19nFtGQ7y/4ljO0JvXqnQSgu
 Oib4/gm2O2asZtY85hfuOYOpYYP2EpzEkKU6vILuCBal3N8YN2kfILY0U9R+Gm3B4mp+wmj/0ya
 m5ezEXRUeElUPXTKVHu4C+Mxz+FIw5BzQEh4663xbchJLNIAvki5gsVUdNxnQ3JZszFtLpX64zr
 XNB1vFqVHCUL8jpkd3AJvvl/QDi/GXKHaiK8yhiafgFonN8QWQ42GNn09m5Vs+eV61BtNn63/h+
 mrHpfVSTFHcnYHxBVty3oTekIGok0ek3nJY8vEf4do7yRuTT9LTj0bXzhO/Hjd9UccLDNHddUQq
 SAi1J+0TxAUDdyVlPD9STomkUya8QnKA==
X-Received: by 2002:a05:6830:4129:b0:81c:e3de:d18a with SMTP id
 46e09a7af769-860f290e7f4mr3338267a34.20.1794432366732; 
 Wed, 11 Nov 2026 13:26:06 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Cooper Huang <cooper_huang@aspeedtech.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Peng Fan <peng.fan@nxp.com>, 
 Tan Siewert <tan.siewert@9elements.com>, 
 Vince Chang <vince_chang@aspeedtech.com>
In-Reply-To: <20261027-spi-aspeed-calibration-v2-1-26359ab2d86d@aspeedtech.com>
References: <20261027-spi-aspeed-calibration-v2-1-26359ab2d86d@aspeedtech.com>
Subject: Re: [PATCH v2] spi: aspeed: Add read timing calibration
Message-Id: <179443236411.664252.9021822762176153577.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:04 -0600
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

On Tue, 27 Oct 2026 17:24:33 +0800, Cooper Huang wrote:

> At high SPI clock frequencies, the controller must delay the sampling
> of the read data, and the right delay depends on the board. Port the
> read timing calibration from the Linux driver: golden data is read at
> HCLK/16, then the timing settings of each HCLK divider, from the
> fastest one allowed down to HCLK/5, are scanned until the reads match.
> 
> Until the calibration is done, the flash is accessed at HCLK/16, as in
> Linux, since faster settings may not work without the timing
> compensation. If no setting passes, or the calibration cannot be done,
> the flash stays at HCLK/16 with a warning.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] spi: aspeed: Add read timing calibration
      commit: 59211dcefcd8cf68fba6fe0761f82839fbf36c68
-- 
Tom


