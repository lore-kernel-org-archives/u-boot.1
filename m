Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356AC54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 04:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0345E87D06;
	Sat, 23 Mar 2024 05:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711169920;
	bh=9w8FAwaQ50O7FxlAwfLLUWJbREZpZX0Zkcs9yePvRoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=T5Mi/vEJ7ARGQifeI9K8Oz/lnRyhGrqHBbOe/dYbHUBfqC5noYS2dIwEXxWUt8fgR
	 V+YDOT4Wp0z0tPB8KCRoP8iA8eI/2jofc3p5p5BR0h5U2UrFNvSfscCGzXosPRwMHK
	 zjvUC9J7a+shjBj2xnnasCriiMNeSGHOiVYqv7M52zHvzbyUyIwgl5Df7J53zoT8MY
	 9bKrDjIelkNBu92wbHfLkgxwJGiOqMyQ/7o2DeoaLWFzvM316icKTWKd2wZRul6OM4
	 BaCq9gUzKUJb9p9j6HtkciXg20Aw6/gMguH+xPoNNk0Zuz5pJseBxVHQKy7t4chKmD
	 scAqqgZdNBOLQ==
Received: from [192.168.1.107] (82-131-203-241.pool.digikabel.hu
 [82.131.203.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7425087B35;
 Sat, 23 Mar 2024 05:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711169917;
 bh=9w8FAwaQ50O7FxlAwfLLUWJbREZpZX0Zkcs9yePvRoE=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=Bc8syWxCOw1GUj7BCGUqDWoG68T0fLSg4zUH7aJVfY6WORJEMt7CuUZkiJV5KPOMo
 v+TYGCocLrmyWr5+07GfeE0dQeXBjrJWg4WDHJ38f9UB5cpuQPL1FzmIYARcyXLykK
 P/kaLcUGYlNnaXHDVq0OwO3nxPrQLBzg6VeptJ13YQoxI9GUz+yluG6yKs4KRFTqVp
 8sR/pYQCuA5oY0e3+P0NQmBbYoUnjsxrWgkU1/Rv5i2sPEnqIaApxEQ6/gFBD/IcIV
 M0bM+4H2L6X7BJCe6FsExYTcDPLBit+tbG+4uiw9egth9yzIq011OrfWR8xA7W73AL
 WVuvbmxcndkjw==
Message-ID: <f32f2c10-df0b-a0c6-9a95-33963ef2152e@denx.de>
Date: Sat, 23 Mar 2024 05:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/6] ubi: allow to write to volume with offset
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, kmpark@infradead.org, joe.hershberger@ni.com,
 dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
 <20240306134906.1179285-3-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240306134906.1179285-3-avromanov@salutedevices.com>
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

Hello Alexey,

On 06.03.24 14:49, Alexey Romanov wrote:
> Introduce ubi_volume_offset_write() helper, which
> allow to write to ubi volume with specified offset.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   cmd/ubi.c           | 71 +++++++++++++++++++++++++++++++++++++++++++--
>   env/ubi.c           | 10 +++----
>   include/ubi_uboot.h |  2 +-
>   3 files changed, 74 insertions(+), 9 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>
Acked-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
