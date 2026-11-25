Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D6606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SiCH+fEF;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Uutldg0M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E88526078C;
	Wed, 25 Nov 2026 22:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iktt1ug5Npw; Wed, 25 Nov 2026 22:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 423AA60740
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795645416;
	b=Ia9RXnsiZUIN15qn83TJBmFioR9+JVOae/4+LuldhlNAMRaKWBgV8VzsMBJRrmaKVTAJ
	 gII9iFaB7wIeOIA/wugdKd7Bd9E1PnYmjuaMbsnz8a71PlergNjLBw4GtQWuaVj3RKl0o
	 Xws9JFF7++PV5jn4yz15knssKONbc3Sr6MoYGTuduOU5sAExaQZGnbQZeEcLBpWvLq/cN
	 UQNvNjY8CIkIEJDruAyv/DOqcARQ+CsWwo+IgjrZIOgMNRA9WAtg6ZSbdNcdvvk3g0hn3
	 zW67ECNsXwHEAiVeFS7IZRjcD4qKKWlyqUu9gaPnUiJT5pohTqLNUGLgLTrHZC6bNGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795645416;
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
	bh=6w71g8dzNozuprbS4yUjDZQYlLCEcD7QEVs5DrSbDNk=;
	b=Z37b6VjmQcAOqL96vPXnB9iSqgzcriTfEDA+t1qJ1AYeX59FWitfAliFdIrJ7hMMHL6e
	 zBuWigy9/sDwlzB4JhjJNqIXkWB4m99X5TAjM8qLMhXT8m8hJD4F5ZlGNqmpLdWpcJ3+N
	 76yKXsovWeVJAsdmPh5Bvi6YbcC6k+I2qjzKctrSZuj3ae6E3M+8JzfWli85PucHZ0rYr
	 rB0hTyHL0pEKW2vPRQUtFzQa81slL2s7O1tfVOERGvp14vmBqDwDa4LzOwT+sN8Ls4o4X
	 9H/JeLBHkDmb+kqlcuCfEn96bfhttXRz+ngDPfy0usqV+xBKN/MtigoeY/IRdKJBNzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795645416;
	bh=6w71g8dzNozuprbS4yUjDZQYlLCEcD7QEVs5DrSbDNk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SiCH+fEFIvZCZKUxUYI9VKqf4UdVT2iehXFd2YJaGutIR7ktNdLVDXRNaXYXf8lGb
	 Ax+Wrz7dKOqMcZkBo5Tn1Egu8fDMikpNJh7PGkMPsqCySD7BRgXHPhASOHrp5DHCad
	 kZP30UD1W+QmVunpIggTXaN1pF82jziL2vB2H5e9TkUGehmIbMiOt+rz8jXgsmD6Fr
	 aW06Qi2jzi/8Secb+OGoZWvHe52YU3CS7Sl88FR8WBaE7kGs78xNLbzpK1kmj3FLAZ
	 EvjWzW/DhK/8q9dx4ZVEchfOraJN6tJLrFqVsic7ubw1Jzldp0lqQ8z1qv8YRI6KMy
	 EBjSbHhncEXoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 423AA60740;
	Wed, 25 Nov 2026 22:23:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04F3426D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAC22405A7
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:23:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ju2W1ynNgrwa for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 22:23:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0630E405A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Uutldg0M
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0630E405A5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:23:33 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so4428658f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795645411; x=1796250211;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6w71g8dzNozuprbS4yUjDZQYlLCEcD7QEVs5DrSbDNk=;
 b=Uutldg0MY4Pfzyy47hIdFu/rJz2aLGIoUcy8QGghuRW/hQjKanLLrRIf1/4CBOT9r0
 znXfoSWLCg2gjrlPTXoaU4mW1vspFUHuflKfNPJh9jLcbQ2EkgfpnlKu21lPz+U7OaS3
 1UEWOfIdxC8zesPDYsnNbM9zVL44i7UI4Xk/DoOGS52gRJ51TTugclOSwcdV7Un53k20
 jYCDpQA/hRutAob/eNbJfZURbgwyMR972a128/jUSpwKNnfZMTFiqA634/5S/lvMV3ki
 p4VjEV3zS01xECpt7KWVE363ff9POFbp9JFiyjby2oiDt6upDhwQP4FtB4saiMiXVpJ2
 2Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795645411; x=1796250211;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6w71g8dzNozuprbS4yUjDZQYlLCEcD7QEVs5DrSbDNk=;
 b=XHukDSiSZshReTDOsRwiqbXIBzPQ65GFB4leyuD+Jguj/Mz9xan+H6Bfuc/1Lq73G3
 M/kwAtzensPu5YTligvqM1bPR4NGC5Q1GOSVf3jgysiRY+vYM4BgT5aWqOjCatEJHRW0
 NT9IxBA8BdBML6mXJAc6C3uKVFBfiSZqmZf/nMGQp3uaY+aZLoGptYzc6STl4fs9oDu1
 rs44ksqUfY3eDpvbns6/GbuYJgUbJpf+GAsmBaZckefpVgNBzfzOvdDk9sf4Ucq1WzMC
 E0dMSjL15MVrVpX9/cY3JcSVkCqlqreZWqp3SOsdU6SrcmJzqwQ9Xi9p3Vodviv1rN4c
 wv6A==
X-Forwarded-Encrypted: i=1;
 AL+hErHTgzSPgtP1dSsGIAsGka8HMVs+78WgBvLIXkZQQANkOmggQeF1XoMycIcZlzgIlglQU2GRaHM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+GMNdrQspnE19h4p6e4lxzcKoIt7PFyt/ZyDT4LGBfzSPNE7Z9
 EgiCdzzJVs8CGdK6B+tJ9Qft2jpWIf6p7p2Myj+vUpYLjlWlEZAgojRedqfOjIHJjnJmarXDHHS
 45M1w
X-Gm-Gg: AZFdTZfB6Ff/7pxh2SECi5QKs76i0dScm7TAqabKm/zVN/Tua3FpQP8lH5lsOQlNCX+
 4cDMn1shtWcUIFFZHb3dCx6m3ebzd6Mf4OoWI+yKaw6qpqxAr+O4Agwn4XTE4sEXRUuZsoGJ5ro
 90x6Wz0zByR8ssUYeWkGzgTDspNTMKFp5uMkVk8jZwaB9byIl6fPztvvyIfLTEYLsR1qDxPnF1U
 8hiGUnZFNHIJ51tgXJmodNwKgKY9XWNzl1syEAaooWTllLOb1syNOBLgzIKEan9mF4GE90TnCgo
 vMFY8HJZYFdRd8dx0+wT1saG98zxJ/REhP72WLnPROrgFzh6HqoygfFolFdL1K+N+Flj1lGVHaT
 UiW9MEhGOQfnPkKdAPQidsez1TTnXlW8JI0Mbtws1Ges/+/kIqOZIJ0w7fWlKMSXF4L9Af6fXAj
 ikPgjVymKjpQ6GJubt211GMuTnxbTKgbChyXy9Gk+kBbahygiEU9EWRqq5sRlqpBHVx7m7NgAFv
 oqde/6aiJGtTdqCOuE/gqG5fStg/6HeXwbGXX9WmgjARw1X2SIvXMNl8oTT13C/b4wMoxSWLF1+
 b/9nnCst8qVEXW6VW8wzntSYU3If5yNh/I8vjc1uBTYEVTjQt65DFXoX5PVuwAAVZuwjH0DY
X-Received: by 2002:a5d:5f86:0:b0:4a5:ba8b:e00e with SMTP id
 ffacd0b85a97d-4abb4f5a324mr36634203f8f.45.1795645411305; 
 Wed, 25 Nov 2026 14:23:31 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm34798349f8f.18.2026.11.25.14.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 14:23:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/7] test: cover the AVB lock state and preloaded
 verification
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 23:23:28 +0100
Message-Id: <179564540813.358187.9019414525511256926.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795645410; l=587;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=XkOwQXoXQG623DYxlyu/urZRBE0ppW9TDNoRNITzBqo=;
 b=9DJ3GLRKF3MY06t2K0Ohi9QylNFCMUCQJWFL1NltQH7pY3C6SztYtxtf0hz20oKRw49hIrLAQ
 Pb+3iZs4orgBBUFAHy1E7tqU5BOnI5rcr9BUR+oVPyUqncyCO9okEAp
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

On Tue, 24 Nov 2026 17:24:57 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> test: cover the AVB lock state and preloaded verification
> 
> The AVB lock/unlock series [1] came without tests. Add them for the hex
> persistent value commands, avb lock/unlock, the verification of
> preloaded partitions used by the Android bootmeth, and fastboot's
> flashing lock/unlock/get_unlock_ability.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
