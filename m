Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E05C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 06:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46DC28847C;
	Fri, 17 May 2024 08:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715926510;
	bh=FkcYVxnxWy/U+kGNK5wUoi9XlkMuKu7LwXDkggo9v+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Pl5AWQU++nokfnzYy+4cKbn8PNVgZbcQ1UNazCRI3VPD85WGWrw/tVbEQj654LT6u
	 cD3TqoboS8rIMyc/QWR6cKYtdVnDIvf+L8M68AZFVXBvKsHveWwCS7Mgz0WLOUKjPv
	 eS2BhNNDhzq40ssaKsOIf6h2o6iMYwjjKSVb8w+ZXP3WajnXwyBMJuOnJgWIcN7mxZ
	 WWv6zq44E9s41ASfiBawMJJEoqTDyJRZJe/8EL8AZshhRg6im7GUZ5Dda60decm2CK
	 g0EKa9XfPi1fxITCsPiMrf5S7r7OJouImwi27IFDg2Vx5iBxO5S+1Rz79UPO6QSR6S
	 gc1EyQS4Tszag==
Received: from [192.168.1.107] (82-131-204-184.pool.digikabel.hu
 [82.131.204.184])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E16F188476;
 Fri, 17 May 2024 08:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715926509;
 bh=FkcYVxnxWy/U+kGNK5wUoi9XlkMuKu7LwXDkggo9v+M=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=O0av/0UA4wu7CTNPlu76ma0RZ/QEHf/XiCu07LuaYc3Dnfp2A6BERr1s5BGekdufX
 tSYjKoK8LRqRX56Q8sqF8DKgGNTBTgChyZOH/Tgi5uP+8MAQUEG6iN3BC4kiixgJ+c
 lk4zRlI2D7SwTdjJpvst+5vS7LgbhObejFXshNCvfQ/uWTkcVvxAYms0Sr84eZNqFb
 EDe4I3kclNJ+5p8jRtaoOg5qkU1l0p8CGLcmXiEYeXtN88mYLMx5Y2aBcKp5Ok26Rs
 KvEJY0bhiFvcSw25VuKWsCYAw7U+ieywHVGZArTCHzzvSaw3fXCDVCEnWCwuzvQtzq
 0q7M25klGyrnw==
Message-ID: <511b486b-4250-2be2-ac81-9ef25c397f25@denx.de>
Date: Fri, 17 May 2024 08:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/6] video: Move generated bmp headers to include/generated
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Anatolij Gustschin <agust@denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
 <20240516-rework-video-format-v1-1-f69822b742a3@flygoat.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240516-rework-video-format-v1-1-f69822b742a3@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Yang,

On 17.05.24 00:16, Jiaxun Yang wrote:
> Emphasis that those headers are generated.
> Also naturally gitignore them.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   Makefile                          | 2 +-
>   board/aristainetos/aristainetos.c | 2 +-
>   board/toradex/common/tdx-common.c | 2 +-
>   common/splash.c                   | 4 ++--
>   tools/Makefile                    | 4 ++--
>   5 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

for the aristainetos2 board part.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
