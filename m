Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9F3E9A04B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 19:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABC483CE3;
	Wed, 18 Feb 2026 20:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fGHBCBv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1700F83CE3; Wed, 18 Feb 2026 20:26:46 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0181A83A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 20:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-413c2977db8so89327fac.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771442803; x=1772047603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fhGew0cHEti1NKEweYeZNnsumlromq98EaXJHxhCpQ=;
 b=fGHBCBv/REcvMbH5K79/y/nhRmeTYPm1JYZd9CifYTpRhQvXADwqSC18wXzf5B5+Ho
 SDE9s9R8PJj043vpYYvFbr2/QzG/O2kT5XkR3Wtb5jxXcyc2L7cb6GORvwtD/x3cIKbl
 e6FxuFqKOxcOIiI6xnI03h+qS0pr4umK+uG4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771442803; x=1772047603;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9fhGew0cHEti1NKEweYeZNnsumlromq98EaXJHxhCpQ=;
 b=St4lCVadAUvUK8E4vNF/xnkCjlTpsaIiKa1UACGl9xchdmvM5VqE4sc0NMzaNlPaPy
 XSH4E1eGxxZu/Bgb3h1ZELfZUsiE2Se2+7KTZ2zI4iOFSmW6JmQNLRK8TWo7AbefjOkQ
 2jgvTYlzShMUXskqEvIgiVW8HwaJF3FxV/aXMOVsn9SubanWtWKrl5EI+EhTHYEFMjM/
 c54cWx6shoqs7s/GYNcouQmwrbBnlvciWG9Atcr6hEjRgkOpvgEfMLUJ3xx6M59+XEia
 Lk4eHM5ot/jkC2Xzuih3eWP1InsHfWmIUnp7z59xTbGot1zM/2CRAUObykfxo9WV8ufG
 YcXg==
X-Gm-Message-State: AOJu0YytSQPTIMu0eK398HjXaHonBPM52u+igCSmoOyAZUgkc7f7WKe8
 0wpGx87f8Dhjcs4hfCXeLGZNdlbg3aRwD8j1J18CoqwadN7x1CJ8ARm0vwtNzEAI3mg=
X-Gm-Gg: AZuq6aKvMjQ68Be/EBq6LxaLaXoUuo6ZbruANPA5MEmlOGyhK4iinIBJPhy+7VfgCga
 Eh55QGDspF3DKZdV+DkNKTQad67vtqJH3q0go5C8igin+xVeJ0NwE6MDCZFuAKCCg3Ckz0jOI6F
 w2seKMBsSiJ0Z41cexMLxAJ3fiOueEkiK91mWUP/RG9csqm7fyDflcgyBFexQShIs7Ou6L2Yz+S
 osvuqwoDJmEcYEhj7VSTwXGSLQg3oj6EEdQvuyVnHyjVTbcdIdpyHjnGcsQ+OgxuHzsbBySTfx6
 LhIXoBQeYBqbvQEcK1Zqoh8hqQsgUFM6hRKiepiWOHeXQjUll7Z0xE6BP1tI+SPgcuHax00ONCs
 PeojMAlU9362YwMr/vJs0b4wWlr+Jni6cdD1iai8g/R++DZ7e0nAhLFwGzKhbhyc1hwkXX2k9AH
 jjMNNeR+dENE5m55BibQX7qL6X8RmZA7cd8IHXiF+Ucf5V/7tqE0xCsZCbWOWr7Mg8W5t0XAaG1
 2ykrahQV15hFuhoKZE3h0hQ0zGkYuSsfGXk9uai1mao4aRdaw==
X-Received: by 2002:a05:6870:fb87:b0:349:de3c:bfc5 with SMTP id
 586e51a60fabf-41539b89b98mr127611fac.7.1771442802648; 
 Wed, 18 Feb 2026 11:26:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm21568269fac.19.2026.02.18.11.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 11:26:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260210-add-mt8370-evk-board-v3-1-faf40de5f402@baylibre.com>
References: <20260210-add-mt8370-evk-board-v3-1-faf40de5f402@baylibre.com>
Subject: Re: [PATCH v3] board: mediatek: add MT8370 EVK board support
Message-Id: <177144280139.3629982.610050572413809396.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 13:26:41 -0600
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

On Tue, 10 Feb 2026 10:34:01 +0100, Julien Stephan wrote:

> This adds support for the MT8370 EVK board with the following
> features enabled/tested: Boot, UART, Watchdog and MMC.
> 
> MT8370 is based on MT8188.
> 
> 

Applied to u-boot/next, thanks!

[1/1] board: mediatek: add MT8370 EVK board support
      commit: b5db4f322a0cf9eb78a9dc23ac9b290f15ff10af
-- 
Tom


