Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41EAC87FCB
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 15:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CB2830EA;
	Mon, 28 Jul 2025 17:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Eo3t251t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0AD83102; Mon, 28 Jul 2025 17:42:20 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2AE830EA
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-615917848ccso1693158eaf.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753717337; x=1754322137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vX/lI9pqSD7OMOGMdbGwp+jEU1y4NzP9NpsYt5Nl9iw=;
 b=Eo3t251tA2V2Eh5TrFjvAWsCKQD1np/rNAzkwchxnZBFgNpdLTYl7OORE4ynv8OYYv
 43DmeM4PRo8JE2JCd5VZum8N52Jlg1b2B2lYVODeuhii1bG/6uHe+/B5zFO4rzeqNju7
 8/btkV88GSjO8NsCZ8g78Q/OJlZBsnGOHrsTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717337; x=1754322137;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vX/lI9pqSD7OMOGMdbGwp+jEU1y4NzP9NpsYt5Nl9iw=;
 b=s4LKgWN7HA3cKGt25oLiHiFrcbfrrxykYhRN7RxiMnR+Q9UUBLV5tuXJxhN3ybslfJ
 Rdh2mKetq9so4qdxwQWEfWLL1VkxtorCrT1l7QpkpDDigbGDsUPRPeImzPRQ6ge9Wac9
 G96rWz5bNEtj2WHfI2e/AtO1gUm44HhYxEWTd4nX9Ezys1zNQX/J4nLldyoRKTcjHidO
 hcqJgT2qRQhLbNu9EKjE/oxHJf75Qq43LN//2Nmi82EaJIzq5tYjaGfDDT1hniAcdR8l
 iRl6AqDNwW6EG4VZ/EBWwfq/Ueq37NY0/gUl0ouaefAtUtLAD2nJ+9YC2njhBw5WiCto
 EPrg==
X-Gm-Message-State: AOJu0Yz2Eb1o+J2JnSc2cp/iGG1o1YiqOAl0jcAHYvWh+YRn1ukPDdd0
 J8FlwM5n7+lh8Sdag/wnpDcxtfj6Cc0LbLNZFicbHYFwHpH2BzMVz6j9S3kobnGiD6w=
X-Gm-Gg: ASbGncs1BtFYD6GAzhVdeA04gw+fNiHbN9Y+Baqk5ft200RII+DMqDBzfWbeNudUUeh
 DSO+rgq7OYcvAdytR8EHbiQhBrjxr2LtS+j96zhdgAkNt5aKWJ3AgDF758rOZuHUX7zvzlpEQp4
 hQJNJQt+c+JHgWAowIq1Z2qpqOA/xzpkaPlcxhN3EFVDlIgp6or13T2tMJgbbj7k+orbOAKvmCm
 SxrNVCicsE4X9htyFieVXHJR5wiEwK+J+Ri7T/AWoJa1lqhrnelo/Vn/rWYqltAXZSnDr8rYS/3
 LN/UUyDfNFPIo56cc20HYY/g6KLit714VG8vQWbfYNdbwIwUgfkirCLj5IS0TldGv1RdNipoDzL
 G5PhvYte4XlwncMcy4ZRmvhoNOIrRzdTpf8O4uXMCqq6H15+nEwq0FOU=
X-Google-Smtp-Source: AGHT+IGHJQOcOsDQmh7rRPmgZY015ghz8Rq1LE0D0AZigf/EaL36Xb5bvML0LgAbI9ExpxgS0GoqDw==
X-Received: by 2002:a05:6820:2014:b0:615:b4c8:ee80 with SMTP id
 006d021491bc7-6190c6c8ec1mr6573439eaf.0.1753717337578; 
 Mon, 28 Jul 2025 08:42:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61913f4f177sm1015128eaf.7.2025.07.28.08.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 08:42:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20250728130808.15710-1-casey.connolly@linaro.org>
References: <20250728130808.15710-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] treewide: fix Casey's name
Message-Id: <175371733633.368338.8372185868110948107.b4-ty@konsulko.com>
Date: Mon, 28 Jul 2025 09:42:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 28 Jul 2025 15:07:55 +0200, Casey Connolly wrote:

> I updated the mailmap a while back but it's nice to have authorship
> comments adjusted too.
> 
> 

Applied to u-boot/master, thanks!

[1/1] treewide: fix Casey's name
      commit: 174128ad6ebe2cddc2338121fb98dc34212370be
-- 
Tom


