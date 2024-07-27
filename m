Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AE4C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 04:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12ECE88732;
	Sun, 28 Jul 2024 06:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="ANiA9VE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80F2886FD; Sat, 27 Jul 2024 17:09:46 +0200 (CEST)
Received: from smtp6.goneo.de (smtp6.goneo.de [IPv6:2001:1640:5::8:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5E1886DF
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 17:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=julius@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 7226B240EC1;
 Sat, 27 Jul 2024 17:09:44 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id D38612402D6;
 Sat, 27 Jul 2024 17:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1722092982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/KJyJu6c81pnOCzSPkJ3kbNcGwG45G4Hw7mZhovd0o=;
 b=ANiA9VE0EKvDoD4Wc3KWtSwdchGxdCdrdH4cfcbXbVvS1TEJpKy85bvUNZwa/NascToRQr
 FC45Uq3Ne1kY78xlgGuiLfDulegknyX1VBOaN2FKCtg6A63FxGPS5mwZ9U5/ywqpfFRSii
 Wn+oVaEKc7YM3eUWr388OXgP0RJwNJd5o5zCbkOx5ZKqI18Whd1FpiXx6y73pxPSyHURj4
 iwZ3h1B+OSvZ3MNmamlPWZfVzqg9zF1u3GQdhoWC8VqHH2qAePYRATsCqFSxf9inf4LyZG
 f2mn33og8aIS78bZJixg/4T9SGvq/g9M1ZhifnnBXMfsGOcusXaAFmadvTiDBw==
Received: from [IPV6:2003:cb:ef1e:b610::76d]
 (p200300cbef1eb610000000000000076d.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef1e:b610::76d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 78F6824025B;
 Sat, 27 Jul 2024 17:09:42 +0200 (CEST)
Message-ID: <a1784401-9ee7-4820-acf6-e476bfa487dc@devpi.de>
Date: Sat, 27 Jul 2024 17:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] clk: qcom: add driver for SM8150 SoC
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-6-volodymyr_babchuk@epam.com>
Content-Language: en-US
From: Julius Lehmann <julius@devpi.de>
In-Reply-To: <20240306005230.2638972-6-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: cde7aa
X-Rspamd-UID: 6c1ee3
X-Mailman-Approved-At: Sun, 28 Jul 2024 06:54:29 +0200
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

Sorry to bump this thread, but any chance on getting this patch (5/8 
clk) and (7/8 pinctrl) merged? I do have an SM8150 device myself (Xiaomi 
Mi Pad 5) and would benefit from clk and pinctrl drivers. From the 
reviews it seems not much work would be required.

Kind regards
Julius

