Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97962EB363C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 22:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7670783F4D;
	Mon,  2 Mar 2026 23:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YFgQnPep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF9483F5B; Mon,  2 Mar 2026 23:10:34 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0AA783F4D
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 23:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-464ba2bb3aeso3933000b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772489430; x=1773094230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzbUxau7C0NlNp1xki7A2bmJ+7raJZDu40jCfJ3vPe4=;
 b=YFgQnPepn+9xca1QDE4aBR9TXXd2LebtS2Om3+LRv6s1F9kgzYWs2TcTodLzXIgT4o
 Lq0diGMT9zkBUGgdC62aQd7CcuIFEzuDL32Hvy32RKnrEyFA0YjrozTSIbdlrEluBMDZ
 ExxF8reO7JRk9uk59sX552Im16PKHgmHrAK4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772489430; x=1773094230;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzbUxau7C0NlNp1xki7A2bmJ+7raJZDu40jCfJ3vPe4=;
 b=CeS4bpUsH8FA9qCXq3JYwUWOKKHpdL7xp0B+6yEP0jlzGP60j43toSqF3VFlbdKq7k
 VjO5uOVkiZ4FQBJaEBdRzj2n5EJYg9sLC96Zwnz6e0TvTZfxp9JPpHq5EzvjNm5gBSsY
 O8BMGnZY/N7ZowoySRlu86RgNflLSfTZwf1yYdo4H6HeogrSZ+SpCpW3dSMNAOAO9Zdg
 ct/hGmC8kKdzt7I3jYg0xrEpqPJseeWDeTwBJieumo8DQ7dOnRQNr2hz/xKCb4bF4lBL
 2oyTcGiU/KOXlAJVxfOnDO1o5/B333BeCnCtqYWQgfJO2KCEhyLyvHVTqaGTw/KlteFf
 ZJgg==
X-Gm-Message-State: AOJu0YxMQfON0EBTFLP73AMbR5J2nQD97ReJ+ZG9VUIhifsS103B+N9G
 ehHxtkGFaGmCVnPT9yt5G3PZWMmjpmJXkpQmttk4yAoEa0aE2cnOWPUdStiHnTeXU9o=
X-Gm-Gg: ATEYQzzPN9Mww7ErsKfwRLndnIAlt3d1sA96dmCjt5QdBIhGYlLMzYUE2f/2BpjzCQ9
 NC5b8rYH0wbcKVz9mWNHnoOIIobxfqL0NWJSX2kS92dzwolWZuCRF5qgKtYhUMrEUzfJmFuR2qk
 gXwNTzYHvUhCq342t1QO3JRqQLSeDdk2w8wAT60VjOaXihd9Npgqabs8ELlNNJ83J60Hvcg/9y3
 keWz3RGK91WAfMmFDyTUNdOn8YgMbhledLSBXNRwoZEAkqvYvcSutEeHv52q6Ccbr5D77AJyTFF
 ItLa/B8hkpG70StDtjIzkwMRKUbsaKT8dCSibF4bh+lbKG1eyTHz+lbI0J6InRZ1sNOsSNzUAGK
 /37Qvd3HzWATJxvzIbHfvLCOWMlpVuYdUG7EdegfQBxaeq2hMVCA/bAVosJrqywNaQWVbtlDuez
 o5BX0zVwch3oobP5xLcS7lzS75mJPXa73w99olvVZuiV0xrwh2Jq4DRJ13NNBGxsbSeT9GWy3tK
 Pd+6xOIfu9mpy/YwCkBdD3NKl9nIp5Bcn/oktxRBTo5iRFULg==
X-Received: by 2002:a05:6808:350b:b0:44f:f5de:5519 with SMTP id
 5614622812f47-464bef07e72mr7028533b6e.18.1772489430525; 
 Mon, 02 Mar 2026 14:10:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb35290fsm8447013b6e.4.2026.03.02.14.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:10:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <Vincent.Stehle@arm.com>
In-Reply-To: <7e073f33-16ad-475e-9d28-54e8006f3a31@gmx.de>
References: <7e073f33-16ad-475e-9d28-54e8006f3a31@gmx.de>
Subject: Re: Pull request efi-2026-04-rc4
Message-Id: <177248942968.3682557.9032108492010348585.b4-ty@konsulko.com>
Date: Mon, 02 Mar 2026 16:10:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 27 Feb 2026 14:19:23 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 437ea9f8be5afaebe2d8cbab6242f1182857f21e:
> 
>    Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab (2026-02-26
> 09:06:33 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-04-rc4
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


