Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFF606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XTQ2HEXV;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bQ5HSo1u
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78452606A0;
	Tue,  3 Nov 2026 21:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-pG4XbJUZHr; Tue,  3 Nov 2026 21:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A1AA606E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741716;
	b=JVExgR/yLI0MMwkCZqZXvbJ4QPdgmh9o4qLH3r28eRt7YeWu0ODG3NHjZ7DlebbAOV+B
	 7P6Ncvn33MsPy7LMMEUJ3HeRw8AlASHLQX/v2+JYUTDTZZwDY5y2z2O0st59eleJDPuaB
	 eHDTX7IdDUGf5vdOnADRFDRd+B2aEXj+8WbdiDmcqeIb8LNabiS2sJFNiXRUPDpNOajaj
	 qW/i4qPMqMt2cNbWkcbpyR/bXLU+IMek4VV/h/coWFSjHkgTgmWuIUKJS8tO6gED5oi8y
	 l11VA6vsf01mbGMtAzH2JCNrQsHTuVK9e/nCDpxtDpaCsZ3y5i/E8j3ksyroMwBRrJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fODuBIFVd1zpzIa1ArcFKrXEivEk+qTcXe+atpWlHd0=;
	b=bJUNI8Q4vgtR9Pwm5YrGylHPg8CGcZ6UsvbXlrBCSVhThCIEbkU1WCnMVaXTeXvJgADQ
	 a+GdHx/D/Cm/SNzq54EilQ204tNh1pbYuoDxnnBACvdNrKRGLkDsXwDcO6yg1ASeXowWL
	 +OiO/CNH7il7i/bAIUCS/PoHKFKRbCip2b97jW2VskkU2nuiPC512tFg+2/SX7IAP/dA0
	 uN5Qea5UraqUpvFIXoyz6/ImD3kX8PpxvqjtAlCxfXQZJeS52kF7LJsZfY8rzrw1+aT8s
	 sAxt3cZe4vZ+igA4iQ3xqJXe0NsGcwJLSLcTSat61YBdQ5J0RCTs+vQ9l1Ya6ySQXPQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741716;
	bh=fODuBIFVd1zpzIa1ArcFKrXEivEk+qTcXe+atpWlHd0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XTQ2HEXV8fw6EKGJGTpVmIqx+T6GuYiBg1ypGVzBpoG2KTdBGpHpsHyGIdwNEJ16e
	 PDflE9Fv+7tPj40XDpeTDoG3D3GffPEZkh18wlooPfRU8R79A58bwPk6m9jA42F9w0
	 tDF+mVRAYq7y4+MgwzMd7hndFh40xm2Ie2ib38ksEK1WnfnygbrM7u+MTulwKKyAxf
	 aqHEkgyDRIwiDWnJu57RnynUxh0GJtx5hp8y+DU8u9xNZJ+5YwISjgw7xJ7sm5gRXR
	 TaIiCLG67zUFVzZx9GFux/JpJKZjOOqM8aGes03shp5PDzpL0vajjWgjQ3F1BIioZs
	 DB2DCVBSHdyEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A1AA606E7;
	Tue,  3 Nov 2026 21:35:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25DA52B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1778780D30
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpM_pgArKKXs for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:35:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33D8D80D16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741712;
 b=UIn45+iG9ZWZmCQRsylPKGUoHmQTTQxNTxvA4En+08nLsir9JWLUU0hmuCD2zjvOJoqN
 6CH9j+Tnhsd/gV7RJw0lSWCdVSZi4WuzSO2nMnOGk23QzIh7yE/Ng71Fj0dEjuceXZvTT
 +migv6G69+4xEHAYM1s1b7f6XY1FcoAISbR2JsU2j2jHxWNohWxBO/lfPLf/2v1IbxDD9
 tN/FOmwv6P4FpEBV58XQj165tR4TpxZ8H61Yo/AnfBvQBatpm3+F3lc0TXYOyPBDAuIvX
 6UDAFtqkYLQ5WtcafVq1C9hBG5YyW1jf+1U5QmloX3xcVjSxKz8VA4qApiL94vNTG1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741712;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=fODuBIFVd1zpzIa1ArcFKrXEivEk+qTcXe+atpWlHd0=;
 b=ZdKUgTm5+qg7BmjcQmSHmJacSxPeIU2yKf+9sUY1S9yWsq865f/k4BlI3UXjMHtpBhhL
 dpa/1BMUYVRFzSrXDf4zdhmKXfYutDPLhP3/wde1XvO3H31gtOgKsd/C71Ujv5vC7+CQU
 uLKH9kVB4lib12rFaspvuitUYXqCoiQONsR65uZY2r8kWSjH9nB0G+nxywvsRG2n9r0mv
 Ytk/d7kcRg/av6yuXWztYeQKxKR0wYugXXxMgxuRhnb2cIkhgJwxHA6vJgqpOcJEqs6KT
 l3U/D4Ob7yhZffNn6cocQt6QMyjEHl10R87kPr3IZQpSwosRYepu70Flnc7ITcP9g6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bQ5HSo1u; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bQ5HSo1u
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33D8D80D16
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:35:11 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so28485e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741710; x=1794346510;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fODuBIFVd1zpzIa1ArcFKrXEivEk+qTcXe+atpWlHd0=;
 b=bQ5HSo1uYtjzi4opASL2zao8wkuoKzKJHyfJ+O2dgFUEXdh0/OtmLn108pNqks4fJg
 O3dXX3UHkuemRoq7YM5kBRpNnLZKFZLmElLOoeJiEC4afFN9X86DqUv1qebIJaoBPBrp
 docjTele2ucn9YPNtNqRa76e/upi3GIqsYQP6xrB9weahwSNIRsFZKNbTw1+Ph+mfuM0
 sdtTVbrhhhP6sNugFUJk12QcfJ6iD/KOv5GYRRc3TQrWafyFCchVPwOc3VilX7J4nkbX
 HR5TnDspNdZZo8iLdRfu89cUlg5/L08rSUEh17uI6CvEUb/s3vfAgB6sGsE/JBJHDpFF
 zs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741710; x=1794346510;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fODuBIFVd1zpzIa1ArcFKrXEivEk+qTcXe+atpWlHd0=;
 b=BJ4cfQQV8DD55ZpTNYeubgNHQUkrZSAEA4rIsgfUTXcoSRfnCLOJwe0wcTaqm8juKu
 MWd7BdOTZCOfW9vgLjuzTKZqewlsfW1GM8+H5sc9lJTrMkceWclZwk14fh9+2416WZus
 /H5EBM/JE5Nce14LG549LJ/BtEA2auOGvTHUGoDtoaIOs0/uLXvmz/vTnkML4I2cP3TZ
 FISkddxRtqKLfNiA3NkKqFQV0UHV4gsf/g16vPnQfbBblNGJ8FB5s0tJh5yKhRhRFTO4
 I3y7+iVzz0xY8xLMgQ+ApGhm+82WYOX4VYXk7FHbqsgwaVKF7ohpTac6l4qS0aR9CKGV
 WF7Q==
X-Gm-Message-State: APuU4Z9AZU3phW2Bfjd8drcE81CLU6EeN2WcDzh7c7NN48b9jHhX7R7L
 sbqvVv15sudBeAqbVZF9+u5d3c6VE+kgR6UdygN1h23PJ019Zj8uoHDSg6hhP2S8wto=
X-Gm-Gg: AYBFou2mDLCju5RvzQe3MM/09q+pH2xdzTU5Vz4bI91dkGQJXSedRiURWOpxjh+O2I5
 jCsig+uWAkn6XIlK+t3hmeGYn04dg06B5YT8AAURZ/mWdKrlG1BjB1TMJ0Y5m7g1v3qV2zj7K3U
 Q9jMp6YmRRwMYEV8ERlOUshfUqHvINx5/ji2/N347Gj1ij5MMuZH6K+tCh3ou2jT9O+iydnfkwF
 xOhvGFr8NY6U7gqIpnIw6b1s7miw3yo0C7sVgCm7wDcbphGRCaNPgjCq9aVZhPx4f2DNSexNbLO
 NL6dNN5/17K0nTY4SbTJdmoTklP0S9ZH4RLkfw6PDGrzByft/0Jo2nlO2m7I40ELYO1QgMYoryC
 rnuUcLIydWBWFLTLpLjn9qfwTn0Clmblkwe0QEoBqYx9bFTUhlY/eywoc4B3fz49B4R5sb3bxwP
 wQExeTyvuURgTCQ0lDWC1nznALgxx03iiZJrH9G/NUJQXefp5WxPpuyCJLXZkihpDOWBj+KAmCu
 5EiT1KitRXDtIXCI7DhZpP1XuIBSJt9GDvkG62UCZwv1d5ZbNIc9/wGCUCmF1UTifqe+ORRugDo
 EdjI7Uup3HCLF8MnCL4IUy0Y5ah+EiK5y04J4brcPt4VjLEBBAY=
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id
 5b1f17b1804b1-4ac177539f6mr318394535e9.17.1793741710094; 
 Tue, 03 Nov 2026 13:35:10 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm179941f8f.14.2026.11.03.13.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:35:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/6] spl: fastboot: support raw U-Boot images
From: Guillaume La Roque <glaroque@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-6-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-6-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 22:35:02 +0100
Message-Id: <179374170202.3704535.13166378983409328364.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793741707; l=598;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=t7wx39BCUFqM0mvNS5cnlK2sUD1OJSvN9CiYqFnX9m4=;
 b=o65V5a3OlF3MhN6l2INuJWX+0rEgpg/kIb9jYLdl5VsF0vLVlRJQDLHfRE3rotRljqKqVATjj
 OYTe+BN02keC9GUycDFH37fuscSRdfX7Gu+/XV3vjrYYTUlFvziPpjO
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

On Wed, 14 Oct 2026 14:24:34 +0200, Carlo Caione <ccaione@baylibre.com> wrote:
> Boards with fixed U-Boot load and entry addresses do not need an image
> container for RAM boot. Allow raw downloads when SPL_RAW_IMAGE_SUPPORT
> is enabled, using the board's existing address configuration and the
> completed download length.
> 
> Keep recognized FIT and legacy images on their respective validation
> paths, so an invalid container cannot fall back to raw execution.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
