Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF71C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82AF81D6A;
	Tue,  5 Aug 2025 08:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754374134;
	bh=cGA4R8GqWdVWlRGEHyo/4paEFwfGa74So1mLChao8nY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=AmctQf/v3zbtZ9VpCOeyC2pfCN53jwPVC6DvEZ0pzlKJsimJ4tUyALn9MhQLtWSIW
	 DbMK5W8p8q560+8o7ZIR3Ywz5I35p0Z1+FcxgwqNFFvGHVqnfcIeSmJ4JCLWL1g2Cy
	 OWQ6rtTaj06EpSH+he+vyFz6G+FsGufCWer1rn3b7hfz5YGyK6y5JOL9xt44Wdcxrd
	 6bwQgL+AByMBLEea33IhZAcYhCLKIxmcQy5qWvdbDXylCiPaj9pIwayq/GDBAa71ii
	 61ZLA5yNAEG2JJy1g/QmdPqQa+gey2IT67p6CNyGXq8Ig9rQB/iKzhSgGID/vIdqy9
	 TmsW1YQnZZvpA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 941CB832BC; Tue,  5 Aug 2025 08:08:53 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85B281D5A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bIqvVl/Y"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C2D381038C126; 
 Tue,  5 Aug 2025 08:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754374130;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=cGA4R8GqWdVWlRGEHyo/4paEFwfGa74So1mLChao8nY=;
 b=bIqvVl/YpwMyFigVem2ifAi98/Zdf/m75mcuTcEShZjnLJhiZflpXbpL7KFRhqINc/R3Sh
 wdBKjZ1csEUMJcnNFCXPIAnIXlV57KIG3g8PWQKjrFgEFb6hKVXuI8v+Jj2AoT2ddbofQQ
 EguNL6p/3foeo46GaXgKfwUyPmHneVj3Ap16nGUqxsgk4syCddWAQP7SH4hVeKqmpk4iCA
 0fzvTQPB1o/2mATiGPoik6mDEdWaTZaFH3R6Au9TV6OLzVxnjF13pca/zs6qziUV/f3WLs
 iMg8N9agYvTMHHy1BtXUf2SjHFgNp1jsxmuctDrxNtFW4B5kI2LQXk4zuBye3A==
Message-ID: <49dbfd58-00e3-cee7-1e21-c6d6eba5fd00@denx.de>
Date: Tue, 5 Aug 2025 08:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 01/12] drivers: i3c: Add new i3c uclass id
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
 <20250728065612.6039-2-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-2-dinesh.maniyam@altera.com>
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

Hello Dinesh

On 28.07.25 08:56, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Add i3c general uclass id.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   include/dm/uclass-id.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
