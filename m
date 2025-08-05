Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C724BC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5918D82BCD;
	Tue,  5 Aug 2025 13:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754394915;
	bh=6/C4JcZvu85bg4BDjo5vVgP7VbhT1DOL2E8hZF1Li1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RnBbipGZrNRc6eA7gxR4jILmvzug1/4Ov3d6e9EWxkGMkSezGnoPjdKE5yfOd8Qm7
	 LRb7XB64Rm+6+zlwFX8IzKxMqI7yL7m8ReSUkO+zXGxCZKYI9hcT0lqPCKPO90rdOL
	 EjKuuq66dwYx5/aYm5vFVp/lis5ECb1lUVNS/+iI7Vtzj+SwEN7efB8ItXrx/rPTjS
	 4FX6lb6iVBkG47ocs0MD3g1Qv93W4U8EKIg/9rUNgdWDifihXjLjXmjzKxfRB+lRTC
	 /NXwj+U7BE0HcKomDjOjJRr4z3k24hlMTO0vwWBNK2DARR1nDvFCulWcQvZBCy145U
	 IKwQJJ1Xa5MnQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E451482BCD; Tue,  5 Aug 2025 13:55:14 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14937801DD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HzKU2hcU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 03AEF1038C126; 
 Tue,  5 Aug 2025 13:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754394903;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=6/C4JcZvu85bg4BDjo5vVgP7VbhT1DOL2E8hZF1Li1I=;
 b=HzKU2hcUm8Bf/YKve5zSetMDXA3QbI/Ny8Tn7IsBhMKeSLUVL4y6u84m0r4r1LTx+1kjiY
 uRp/tBHbsWT5mVtqEMSJwh2Sz6NlHmtSIGS4p4ja/tUNSTNtRqMizGUW+kq5/m7Iyca7Dx
 bQJVkHT/SVFtzhB1lH4pXjIIP71A3uYM9ID+oja0NpZj/fXz2RUul9yHTOhLxLSxr1ZHlv
 dHF3T88mqN0MSKbvoJIuHruNZcz7Ds2Jg3QCMufqBNyI//mhbhXjjvW+IypadbzAS0eD9g
 zqbiGOFzmKFKHv2sviyjHtiVIW3svMJqBUpykaSyYUvQN7BAXAE/qKMaMYfiBw==
Message-ID: <88bb38a4-9d39-f619-ee42-e014a6f4e76a@denx.de>
Date: Tue, 5 Aug 2025 13:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 11/12] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <20250728065612.6039-12-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-12-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Dinesh,

On 28.07.25 08:56, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Enable configs for sandbox i3c.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   configs/sandbox_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
