Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E56606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yX7aN6EX;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GlwNd09n
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D29E60AA1;
	Wed, 18 Nov 2026 16:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfLpuSaxKN2O; Wed, 18 Nov 2026 16:20:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9782E60AC3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795018859;
	b=f7J2EH72+HHjewPu0CDplWiqpDBkpmGduRpfY+OmGLe80dQ4g/lgscR8cEzOVui6YVki
	 oENtKMCTDF9DL2zbGtoIvVMN90wcFGnuuuToFu2S9Fl23F7MpyMeL97oQgmESOXChKr8n
	 QAc511LA/xeOQmm4iJmdlv2B1hh3+WuaKy2Vf6et34V/TMJSyCijD2IXsX4JFAbVfplCP
	 P/G/W8WP1dnynYLWZmABWgtO+qQdkddzn4ayFaamohQwf6BDbVKDvzORWabH23OBj/llm
	 lOv6sXT8pG5YsWZN5jgkHbRjIRDJPCDUpqwRKbFxOS4/KoFXk9JsaZLaxHPKxiSoPUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795018859;
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
	bh=957dsRvg5Aval0bQezjYxzLwNvjp589DgkkkpSHt7ig=;
	b=NVxxOI2S+E6sgMY0RVqKUQvKpyOXEW2Jq9WbQJ1BAN9nTk3Z6v4oekQtCPJORE3XWyNa
	 pFczseH1KPehh4on7K1wgHDprWWH2+uNMqW9nQXX/8IrB6Xd9WxhZzgurHMtYc78LLQe4
	 ZN5Cu5aLTxDkiQ43A9+1qWCnxq3nzsGsV3zqdekzAB5NZYzN/prZM5bDu/q8vn8CL4uNZ
	 dOH8g0HtnrRI38atZ3cRLbYCgeHUCkOCXa2Q03u7EzlfeIH83/Pj6+4YcVQzLMETEIwnw
	 /kWHnSj+x1207cRSuNQVunn8ztUaxbg1h14IzvFVwRXtIfxkfDg0MD9f4e3GYnY2rgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795018859;
	bh=957dsRvg5Aval0bQezjYxzLwNvjp589DgkkkpSHt7ig=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yX7aN6EXq9j2RnaoXFtoyXlBGEj+Psfr4mAd/INlE6IslzVF+GwvOCTOm5kpCeLBG
	 tpsiyxWfTtyWJaWZIDtpJZIy4uJFMytqmFWEtdRCN77ibZcU5xuGVGNJxcETT7P6h/
	 FUFLovmo4oUd5rsvbqFdAY0iR2Iwi+fG4DW6QIjtkI/EhADe40mcKcqkDaQWXHWN5a
	 EYD9IhjhdE3fwElwWVzc21hzgkwOUASqNLclI2CeDsekUqQN6M67fBtESzWpS2eev1
	 SOkGJLxZoseamG/aJUlYmS3t0WVtv4bBsWVPeV2ik80cIG06Ul13/VjZvkDcaN2dt6
	 dZK8dw3/ENS2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9782E60AC3;
	Wed, 18 Nov 2026 16:20:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD23828C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAA7D4079D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uf5J8uLFkanx for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:20:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBA0C40215
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=GlwNd09n
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBA0C40215
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:20:50 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so718701f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795018849; x=1795623649;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=957dsRvg5Aval0bQezjYxzLwNvjp589DgkkkpSHt7ig=;
 b=GlwNd09nh2e53LU6wICcau3pWOMlvOsTZnjBDjfZi9Xm3UnsBRWEnWQuYNSWTC6P5L
 PocSFKIV9aKhNWvKxFFRu0DdJKvrCwaJBqKOHAcw/cTc0HK2wIdEr+eV9yry1mzG8Spj
 dFmj7BlxUdOC4bDOjQNbxhKCkP8jsEzyiV0H01HWuVbCATVGZzjdQwlRS26fKag09owK
 R8UrGpq16OcuN6z0DNADIieChHAYNF8EK2eRqAIaGA3O+uE6kdI2y/e+U0YHtXR/Gk8F
 TV4MAd9hIczMQUsvmvOQGGSg7dbtdW17awa84jHSV6bn04G10FzqUAkDBfZGuwNUWs5c
 aK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018849; x=1795623649;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=957dsRvg5Aval0bQezjYxzLwNvjp589DgkkkpSHt7ig=;
 b=YSA+XFtvQGeJ9pUVwX4QRxicHMLaC959tm+rgKKEbfOP32uvQ6GcDmf/p6B+7ofG3I
 RDlMmYdLdnKjyMbUImt9HzI4OWOYvffyNwPQ1itmNXbzxAi4+amaMTzHD5FEgcG4nSCO
 yy0vkRWsDerQCGgnkrBkAsL/Dwk3v+YH67fxA1BsAB2e2pI8AWy5claek5asNOT0/VYN
 d3SUvVjQKp2LKMLltgmu7x+OVkSSNpe7ZxXrZQB06mjEx8jAyFLjRgq+Y6W/YzHkFdMu
 BBRAEk0FP7HQ1+Tqueh7pTy8mdF7YofFglVNdRlwWAeSdt0St6+sqmdFrGWLMNHn1QJa
 IJdA==
X-Forwarded-Encrypted: i=1;
 AL+hErG+8+crLcCkSwzF+5e/k5S4jtYBkodpOhdKYuASJRlcib2YEEbuDdjCmYEe5Ngjxdyj8pw09FQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z//wPK69DOL6wmnlYCh2TfWh5+4MSmZSnMmDsmdc6CB7QSGyhH4
 OkmdEoVY3m1OQBeuKvPNTYGJlzM8/+e6Wsav6QaVEMQjt7a2BlOyHnkNqw+dYIquD8g=
X-Gm-Gg: AZFdTZetCjUfG7Ugz6pS5eRwvpAxXHZW3WryYrHRq+wjc9kO5DK9xnPkdZN0fNwenOb
 oUwXFBCKdYS0pHGiRu6Ix/HJwuVNF4V5xAC5Iikom+qS+oNKWq9gzd7q+d7p7b/pII3AkRUwkq5
 M8xPeLyGeOkLZgGaiuMcejQIoaCXSy/c7CB1Vv1uQR3Zg/rQ8aejT50CT93uzngQFvzGB9VUdK9
 B49PHaE54QE4jyurRC6222sl+d7ufFmY5zsyl6EzNrAVPXGfARH6eZ3CAkCy9l1D6bJ+ozS9owx
 lc+YdEM1pkNM177kakJTEygoxtAwbaVkwRaSuB7dGFdihVGsFu1P2ip1p7Kwx+9DcMGZRnQrA+e
 YfO3FeHpw5CzstBKKO6IGzQVq4F6WjK0tKp1/v7ymK9yy/hizhVzYC/htG4ZuevRe1eZxeDsT9w
 RbE8/WRHRKLsmMlHlxWxFjujrKKbREMdYc1nILWrj1TFLELjOPStG8dmt28D5nd1If3ZboMlYrk
 heXGhBSpD1ze23drKktgBurEQDPf4vY0cK9jwY+nqexadEANPDcyrZXIAqp1JllzpUsT8Ov7EWz
 /LnvmcmXsGwonmDz6qWfMNsfE5wj/H0LOxQpUbnIxFDQ4Q2Uw/E=
X-Received: by 2002:a05:6000:288d:b0:4a6:7781:b064 with SMTP id
 ffacd0b85a97d-4a67781b0b7mr7283846f8f.31.1795018848700; 
 Wed, 18 Nov 2026 08:20:48 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2efcdsm5537874f8f.5.2026.11.18.08.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:20:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/6] test: fastboot: Add test for block partition
 table targets
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
In-Reply-To: <20261115-fb_gpt-v3-5-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
 <20261115-fb_gpt-v3-5-7ddd7ef832f6@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 17:20:40 +0100
Message-Id: <179501884043.2226612.13667335390914530195.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795018844; l=442;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=n8jHhYncbTqKRO2mkbPXZ08IpZUfVWP5qVzT1aUMvrA=;
 b=/SlQnjaxoongOhYGTV9lLTnXc66K/glXktXXhbroyn+bpaCFZRRnFuJeHgquugjBZqrg2Z/TJ
 6YCKIMkerHcA5bukYFK91IjhxQMEvt+gv5cfrlL36PA4jrU/0UgmR6p
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 16:35:12 +0530, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

Hi,

your tests no really cover all new feature you add, in sandbox
FASTBOOT_FLASH_BLOCK is not set so you test part of your change not all.

i don't see some equal to fastboot flash or erase command , i don't know
if it's possible to do it in sandbox test.

Regards,
Guillaume

-- 
Guillaume La Roque <glaroque@baylibre.com>
