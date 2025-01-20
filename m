Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EFAC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 12:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFF8800B6;
	Mon, 20 Jan 2025 13:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="M/1IRVHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398D7805C5; Mon, 20 Jan 2025 13:25:45 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1171D80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30219437e63so54946921fa.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 04:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1737375942; x=1737980742;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U2mzsV8uA0hzFb6W52KLFXBdU3IupAaSCBZyRRdsVdo=;
 b=M/1IRVHJ8c2Nr+vqK95r8Ih7j/e7i9Yk2gQ3hbKiKnq4nmrSoiyDB5fw/+t9Jo4wFe
 yyZjYZu2j+ryFQoAYIKlEIZeR4O4d1LcoL4UJZHhc6UUSzk8zCdYiM5z6q49XS1bmAne
 OqPvAmt1yPvogv5KcSqF6CjPzb5OEFtt5zk/nLQkgm1mi7doGefmzha1iIhNunUBTyic
 hBUv57Mp7D8pyA0bpAI8rI4gUoNP1Jw8DoEAcqB7A4gx/0q60/IwBHsH2Nb9oHb8Y0HO
 pXLgBZ96gx7YHVdsCzbrz9zTTHC35OydekubTYhRFCY9TO6VYUfCVmCEqNVo+4qif46q
 oqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737375942; x=1737980742;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2mzsV8uA0hzFb6W52KLFXBdU3IupAaSCBZyRRdsVdo=;
 b=SmplbQStnGNlA8n/l0oEdJpDQa8BuV1QkX0lhljOD8QXkt0LFtZSS3T25pLCvituR6
 rrmF788F0iRDMdzHA6acGN1DX4+/8PMaR/V+VQIliv+KPLV1WtB/KL4uy7202hvK+cUh
 mdZPM0Rxa2XIl5kf7eZL+nIZpBzY5XE9qiV9H41fjrjULEsJMDlDVNTiGB2XW8mX7gF/
 fcvocbXlvYY9cAYwum68jqIn655kJyx3QoUcsYayiNwjZ1MLy8rD60n0slhoN7IOcA18
 uifEYvE4O4bym47yCNdO7cZvRBVmuYSjWFy6lQ3q/ffFS9ayla3CnReqROQsZud19nc8
 cEKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDEaIQ5ZVP5w2Y6ZbL7i4RZi2E9hf0M7OIUSTYkQKhoMGtfN08iZSU6YE8REwfzGWSKljn0rc=@lists.denx.de
X-Gm-Message-State: AOJu0YzH02AsNpNdZ2ncnZP7GYsFQT/hAzg0mLee31PIrHf+1DoNE2vo
 plxKZzbt87Hdz2PS3DcQcEZGi3JK/1pO8hq8M1mbTeGALyTaaeuuVJOqVQRdyWc=
X-Gm-Gg: ASbGncuHnwpR6lplO+5sDi3IZq6LZJbqpBTd3MY2TklzFWWr2dnWSjKT/AAVGOX+H63
 AB36Vml2IieKnW6NDi/Xc+d/+YwVeGAgY1nkLOkTw9RgvAzlUZSfDr7hnpTCJYlI21mUi45fJWh
 BKX842iswIQ40Whj9qTcWZ+fRkqln/wjxVYdzawmaRVXs4ZsYy9V3odS1hAGjJWfyycSsgqKpBC
 ny4xxbBgLGlfciQ04P19e09rld1gBR7g9/ikcr5zpPmBms435ri4k3tNbHfvgz6NiN5kt42H5C6
 WhcQxT0pashKm/GP24cM8A4f
X-Google-Smtp-Source: AGHT+IGylWKGoCWhDaKCEX07lDG939dBs1OKWu7AX4roN5pHkdw+voHrILk6dQHqHz5MQdE6rD4kOQ==
X-Received: by 2002:a05:6512:1250:b0:542:215f:e615 with SMTP id
 2adb3069b0e04-5439bfad838mr4492350e87.16.1737375942070; 
 Mon, 20 Jan 2025 04:25:42 -0800 (PST)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5439af60504sm1328477e87.115.2025.01.20.04.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 04:25:40 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, Bin Meng
 <bmeng@tinylab.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
In-Reply-To: <20250120105045.1281262-5-sughosh.ganu@linaro.org>
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
Date: Mon, 20 Jan 2025 13:25:39 +0100
Message-ID: <877c6p7juk.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> Add information about the type of blkmap device in the blkmap
> structure. Currently, the blkmap device is used for mapping to either
> a memory based block device, or another block device (linear
> mapping). Put information in the blkmap structure to identify if it is
> associated with a memory or linear mapped device. Which can then be
> used to take specific action based on the type of blkmap device.

Is this restriction really necessary? Why should it not be possible to
setup a block map like this:

 myblkmap:
.--------.      .-----.
| slice0 +------> RAM |
:--------:      '-----'     .-------.
| slice1 +------------------> eMMC0 |
:--------:      .-------.   '-------'
| slice2 +------> eMMC1 |
'........'      '-------'

Linux's "device mapper", after which blkmaps are modeled, works in this
way.  I.e. a blkmap is just a collection of slices, and it is up to each
slice how its data is provided, meaning that the user is free to compose
their virtual block device in whatever way they need.

Looking at the pmem patch that follows this one, I am not able to find
anything that would motivate restricting the functionality either.
