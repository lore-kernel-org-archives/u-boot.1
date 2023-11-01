Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBD6C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 21:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE9B87692;
	Wed,  1 Nov 2023 22:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KA7arW0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84BD87712; Wed,  1 Nov 2023 22:03:24 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0826876D4
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 22:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66d0760cd20so2555006d6.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698872600; x=1699477400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvOo+4CM7292F52lH54iGZRSc1xjahtTMtwWt1xOnmc=;
 b=KA7arW0SWdc7xPcF3WYap5sEzNleH5ZcNv8Zc1IKtlC0Rbzb67V04s4dOffCj2AsQ8
 VqtSKCuVfOcark05p5vHUUKXotPdn/3a41zl93nvY/jFEO0MLpAQNZBG0d4Tgf2N1gqT
 hAfPEPQAxVo1KWd3Xhn/f1+rxPsn4VU4VV9k7jhdm2bXXPqfpqfAtugGqWxZo8MJL0HH
 lc8/3gTRy4uIViPdbzKCf8rUPH5T5wwVujmL+sv8zCMuFjTVm+fXCsbEzgUMocGiNMSQ
 P24bYKnYumUsja9C0crcjc+233/yJwS030aSxBmDAmTnnPDqO8THYt4vkjGNan4DpmJo
 XGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698872600; x=1699477400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvOo+4CM7292F52lH54iGZRSc1xjahtTMtwWt1xOnmc=;
 b=J5Y14ZvBgFhOGqXbkBb11SxLd8GzAgsXzo3QNOWRe3ZbDjcKvZRXPunbVdoumI7VmT
 5LeA3luIh7wrZZR7X1T9vBe9WR764WS74cNGfMjACKZu+RETbB7SjTGEln6a6qZrdPsH
 5sv4BnhQ5fPbLvXVpTX0WDAk+AwALOZRLkF9m/XLb/hAFhyMZXNWsk0weR8oslovY9NK
 Xp8Lzz31vZwoF6Gsu3CeCVsnXvoXozEXDqwHjgsoFLw/vLRZUfjYE+Sl05aO9hwxMU5U
 Pu48GySxSTe7je3o+KBATtyywQDVFsGTju2GM4VOhj0Fa2sZejLwagHM2S7D7T3EY9mC
 pffw==
X-Gm-Message-State: AOJu0YwrQPCPAs9Ru68Cf0wAXhaXby3fdYMHMTIti7LsASPCC1cjz2WZ
 2Xoy63PRFkB9dD4Eg7a9bRc=
X-Google-Smtp-Source: AGHT+IHqwofBkRZwGc7iinrnKTVFdggCWaiQmIbWVZuS5lGcANj7eQk+OM7ou4HKOX8zThUO6XnDcg==
X-Received: by 2002:a05:6214:5592:b0:66c:fa89:a894 with SMTP id
 mi18-20020a056214559200b0066cfa89a894mr5718644qvb.10.1698872600345; 
 Wed, 01 Nov 2023 14:03:20 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 r14-20020a0cf60e000000b0066d32666a27sm1785183qvm.66.2023.11.01.14.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 14:03:19 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Lukasz Majewski <lukma@denx.de>,
	forbidden405@outlook.com
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: (subset) [PATCH RESEND 0/5] clk: A few bugfixes/enhancements for
 CCF
Date: Wed,  1 Nov 2023 17:03:09 -0400
Message-Id: <169887250361.1352526.3142070703195089231.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 18 Aug 2023 01:03:59 +0800, Yang Xiwen wrote:
> They are found during my development for HiSilicon clock driver. Details
> are in commit logs.
> 
> 

Applied, thanks!

[3/5] clk: also handle ENOENT in *_optional functions
      commit: c4b52fda6924e92c6745351f32c4cafc36034170

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
