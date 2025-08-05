Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739D9C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA5083526;
	Tue,  5 Aug 2025 13:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754394942;
	bh=ksHH7uGNiP/bk3cBwlTYbhXUpvmbzgavbdVPLEMY28M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=y1vnWYtSKMS+m/Wv5ZzaNLU1LNDcHX9nINE8WkqmgT9sIXc+ebdz8NO5zWnan70+z
	 GZhto3HZvxywcu/quvXlK0ssn/c+ZANrwep45scD8Yr3CkoH3OrRyHzHcmgYm9m1PL
	 6rUjwe6cSq4rd29YeA6gPpOXRG14O9rThrsfw364Rgu+Cn4qO5oltfC+kcWgc++w7A
	 OmqTo7NKPLV2U3tSP4VTc0hDUiib+woQS3U57WfCYoVZHznGDH1VfbSEG1tf6H9AsI
	 W0ROkBPT7LttHrQKWNAwkvO61Dxq/qmzEo5R+/2wdSUA3yc6ogzdxNYjMjWJVjq422
	 7H55FY+Lk3DVQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F77801DD; Tue,  5 Aug 2025 13:55:37 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E50836D3
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="V/Y5UNMl"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 81C571038C126; 
 Tue,  5 Aug 2025 13:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754394928;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ksHH7uGNiP/bk3cBwlTYbhXUpvmbzgavbdVPLEMY28M=;
 b=V/Y5UNMlbVdNz97ivEwi6SbiY/MISa0udOVzAmYAHJ1cd6qPcWr5JthQe99owpPcMqWYeS
 vJOkZjtR6iAm8j7cFxcxtVf5/2+c1YpviMdGGo63gd6ZA5+RxD2RhBzw+z0kQ8uewFZYje
 nMozNLHOLLDyHvior34bCglk6pzludfWo2rjnOZaEcoHlWnwbgqUjExrZk22CyETnA+iET
 qQ2uLuaCBBEXy3X6cvIqOhPbpTPxwLpPJZmgMrN62uTKjYBRA9x6VQZEM+f75Sa8ltiSTr
 MiXQA2dWuDLGpbpp8gH7eKecifVDJ9EwAbTtTlilF4rxxy2n7+2JT4c1MNSB8A==
Message-ID: <0eade5a5-7329-c502-9469-159b9ea70e8f@denx.de>
Date: Tue, 5 Aug 2025 13:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 12/12] configs: agilex5_defconfig: Enable i3c configs
 for agilex5
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
 <20250728065612.6039-13-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-13-dinesh.maniyam@altera.com>
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
> Enable configs for i3c in agilex5.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   configs/socfpga_agilex5_defconfig | 3 +++
>   1 file changed, 3 insertions(+)


Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
