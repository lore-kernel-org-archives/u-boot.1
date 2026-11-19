Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35679606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fdd6/XGU;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DsxVYtCs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05832407B9;
	Thu, 19 Nov 2026 17:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNQuumGxbSzc; Thu, 19 Nov 2026 17:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A7AC40B81
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107761;
	b=LZqqwxbguuOe2gMHXXTjaN0fbMZlZu2L1mY1vcOUdbw46nSVT4FVmtDKyyUoB+uqdjho
	 0qk7goc6UQ8cTBsZMs1WwSDI0wTpZNP2YeqIfLeUh5tei2fqC2R0bz1FcoO35pFkKJP0q
	 lVQJGUGfcQyPymTic1e8vYeHNS5fAsQIwORrnBWSPYFyMpNvlzVfTViI1ijFY8AGB7T2d
	 dxLOcVrZ5yqtF0r5w+HrlWqVAopKbW3/g3shfFMixIYHhcbafQoCqBYW7MqKRaW9nHqTX
	 ebk+mbw89FytRpOUGzZCabDI577bZUsijYgkJ9rPR3tSBKXBzaFanMyjS955gvj2s2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107761;
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
	bh=I/yI3F45EriPGcNxrnDnKzeZq+tVlzSfuE7QaOBB/k8=;
	b=grN9FKuooCzaNstHqf77d5650vxBAP49jqfuhLXmy0fTGhbYQfIE0pwbk9AFIfOX+XGD
	 4SlJ3EVPKbyUt4If4n6PkkhmpIpDKUGWHqFkBZY1jG1YArpAEs+gpzxyxt6lBz1/idL3q
	 Kp3FnQQvSznv9T1AxX8FqnBytk8W7RoYDaDcYdjUpsIlzAlCSHoVb1k9k0jrNPd0DHbdB
	 MAezDHa4iTil8J5dGOYto18r0IfGZoqZ4ckXdX2PxSPYqhB8SDvx2SPFtZSgK+ZwLkzJe
	 dSeDIHpKb1GQMzgSoAAtkprQ5ntIKDVvrUEMeX0/k+AFM/M0ejTbA2BcFFgZx9ChTxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795107761;
	bh=I/yI3F45EriPGcNxrnDnKzeZq+tVlzSfuE7QaOBB/k8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fdd6/XGUsGtKZsss9NMVlJWtM5pDiYEQR8fga8uCNO104IL9y0j8aWwnRnfvAHmge
	 AaGKYGAnslfUQja+vmXDLU9QVWQ6LerEbeBFJpQarD7UXr8v3zn1SoP208pQ0D7qkC
	 1cQ4wvgFLykwDdSDjgGN7+W2RiLuQDNHMYW1TjjZH0X1Oytrk/xJm+NTUmWFc6iHHf
	 /ODLUKlZWHqGctSvMWfdsA6D2YdhTqNpVhRv4vaaa77guLx3F3lY35evFdIa/JhvM+
	 agFIMLML50AsARTckiIcpvvfoOLK2Me//kC5xc9xDNW01kgriXnXkD426B4YnCMIbp
	 Gb17nhOn6d6oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A7AC40B81;
	Thu, 19 Nov 2026 17:02:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 080522FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05AF3401C8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eyOHtqXW29bS for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1064440180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DsxVYtCs
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1064440180
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:02:36 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-71b30ed75a1so477638eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795107755; x=1795712555;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I/yI3F45EriPGcNxrnDnKzeZq+tVlzSfuE7QaOBB/k8=;
 b=DsxVYtCsJvao68RiovJY2aZmHYADs7rbmGOeLHLbg2Wa4p95+QkJqn+rMINgRW7PlW
 Z6xNCUYxPPGpQuL+aH4jmFnaofNS8za16huzjUcWaZAZOJ2T3PiYpwE4kJIw+VMQajjS
 20bbKTiCuuh1t7vCdWpaSGykWEna05PCt+V9vCj4WG1FRKql74ajrYRn7A4G0vFR4deS
 Shq5KMnDdenwzo3Q3azgGVFm1s1semtQ9p7/c89anRbUSm+rnxH4NmSHdIkn2TwOGRIS
 j46k5eJxGAHIkR6MHRYNIPv1zbbOkayN5ddVqJD9A6CXXkBoGFiLxWZN9YLUUtDD4wST
 MaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107755; x=1795712555;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I/yI3F45EriPGcNxrnDnKzeZq+tVlzSfuE7QaOBB/k8=;
 b=llwVttZOoqTGA94MutRoU6r0vneT9FGNBrc2i3oQ0bWiwM5TpWzVolCAT7jz+kUH7E
 qkuZXeLtRs/n7mRhjQRTG03J4ZzDIQ8LAMGvS2nVQrU4hcvjawa59J8nPrnTPp/fOINw
 Fol//2AEpTuY5tS3q9Z6hza/DrjY9FdzPwzdb9CQkhFHVIvAbmm3hSt9ywD6sUdkZyRt
 OjrJg2jBfLVCNiRipqDPG2LG1APChFfYl1h3PoHsKi6io9oH+ujaDrI2p5nHgcmqdYMJ
 Ofk860E0SL1F8gIVNYLDq1UC2zVveUaM4iiCxXwcNNHATN0aPalXxhy/88rgzXVr5sul
 CjAg==
X-Forwarded-Encrypted: i=1;
 AL+hErFKYfWMd2tGY3Isz5DtVqGZJ9+F+HyU/ytV5BP12vWvR5fJ0tazpL1s5+VWDbKY0eiH30WZYQ0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8oRrk8qoDbtUAwvU9KP9J01uxTkcV42D02R3MtuplBoQ/fnp2X
 iaDOLhQa2w5fkkDAGLbxy/fGAwFx1WuRqt66J46It+EDIrg6xo3bjND0nqJQGPyKiXEEH5UObwZ
 My2xK
X-Gm-Gg: AYBFou3K77VdOrCqw4A1je7eihtdvWp6eu2Y7TePHleS6vZmEsIXBsiziqC5aMW517F
 iLh0aQzYAQ9hjahsLedkKPNMODeixnRZ4Gm9tbEkLBTXVwdMSRqoe2JQJztd3Ikf01NoBbQhzAR
 /ZrPal9vE0q2FrAzQTj0NtSuMU7ZFDsolv05rjMsfl8xeFNYZ+bomorC4rF2EwPE2OBfkb3BB6r
 zEsGB0dKHtaUWKvGVR5AB+g75tumdMIRUguEfX7P0LajYNGbjEXAaycVkugItF4roAbizEUKpGW
 1NavOTP2jWYy9cOfYOYV8RCCnGZ5Lmd7H7KJcexV58Vaq12/7moheKc8fKSyFJFMjguM8lqHpk9
 /LfEo+OPyFzEQjV7bdmcQ1x/4JfufOdNiAl94/l38sgvM1tlcLdAPHmdyDiNUnerV+ziWY+tlcz
 GSjG1riyz98OOcQ0aSFDTYIJ7l0Hw8Wnn5dsQYNLXd1kJZracpvnd1V1iF9ErkUU7pWZjuI21tE
 z0rMYTFpF01hgip4KB0oeZWDRbhZaUyCPVeV0vsI4PIezQEq9ognt6gnlTR+k0uPLmKRG8RxMJc
 x13MMRSzsO7cfLTypjdjRL04mQCb6/YeGQ==
X-Received: by 2002:a4a:ec49:0:b0:717:da:ba31 with SMTP id
 006d021491bc7-71b3957f531mr153820eaf.78.1795107755592; 
 Thu, 19 Nov 2026 09:02:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380e4a6dsm381290eaf.13.2026.11.19.09.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:02:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/6] fastboot: block: Add GPT/MBR partition table
 flashing support
From: David Lechner <dlechner@baylibre.com>
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
Date: Thu, 19 Nov 2026 11:01:50 -0600
Message-Id: <179510771079.2216103.16224552807473939977.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aJrY61HtzKwjH/zRASNpOGBCijEGV9a8J6l633lPr+M=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/yuZK8e9Dfcfi2LtE+K9iV/2nhvLTvF7oeurg
 9+L/1ym9sKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav8rmRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4fIIAJY3PXDE/BzU0oUcBrgTHpfv+Gjj4w+QIGc1T58
 rv/c7DbeT4p2PpkgYKME6OxukV6tnZJwX1Py4ZXSbb8UUzXOzBmXsmH0XqtwzpY1VQEX/40u2NT
 4E9F41X+sjMYZNmvQMrMrjPH2sjI0NXz8+KDLzuB+vqTB8CF0PpLA+UcmvCAb2JAEIlDx/7VPQl
 iJzniHjIqE1giY7M9XRWekAkgrJo5O5kaECSnjaIMFvKKEZ3DqJft1as0vn0oUoUPwLwUvSW5O6
 NdnpH0+bwynepbdq4DimrxlAtcS0PAOEXNUkYoUmyiEo4Q7rM6gQXK00yjVPXMUsC9HV4+rwpJg
 +TAI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

> Add support for flashing GPT and MBR partition tables to the
> fastboot block backend. This enables operations like "fastboot flash
> gpt gpt.img" and "fastboot flash mbr mbr.img" for block devices.
> 

...

> +int fastboot_block_get_table_dev(const char *interface, int default_dev,
> +				 const char *part_name, const char *table_name,
> +				 struct blk_desc **dev_desc, char *response)
> +{
> +	char dev_str[16];
> +	const char *sep;
> +	size_t len;
> +
> +	if (!strcmp(part_name, table_name)) {
> +		len = 0;
> +	} else {
> +		sep = strchr(part_name, '#');
> +		if (!sep || strcmp(sep + 1, table_name))
> +			return 0;
> +		len = sep - part_name;
> +		if (!len || len >= sizeof(dev_str)) {
> +			fastboot_fail("invalid device", response);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!interface || !strcmp(interface, "")) {
> +		fastboot_fail("block interface isn't provided", response);
> +		return -EINVAL;
> +	}
> +
> +	if (!len) {
> +		*dev_desc = blk_get_dev(interface, default_dev);
> +		if (!*dev_desc || (*dev_desc)->type == DEV_TYPE_UNKNOWN) {
> +			fastboot_fail("no such device", response);
> +			return -ENODEV;
> +		}
> +		return 1;
> +	}
> +
> +	strlcpy(dev_str, part_name, len + 1);
> +	if (blk_get_device_by_str(interface, dev_str, dev_desc) < 0) {
> +		fastboot_fail("no such device", response);
> +		return -ENODEV;
> +	}

The default device goes through blk_get_dev() while "<dev>#gpt" goes
through blk_get_device_by_str(), which also selects hwpart 0. So a
previous "<dev>.<hwpart>#..." command can leave the default device on a
boot hwpart, and a plain "gpt" would then write there. Calling
blk_dselect_hwpart(*dev_desc, 0) after blk_get_dev() would avoid that.

The same applies to the default device lookup in
fastboot_block_get_part_info() now that patch 2 allows selecting a
hwpart.

-- 
David Lechner <dlechner@baylibre.com>
