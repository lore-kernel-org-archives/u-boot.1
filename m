Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0AAF45A12
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 23:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4EE2840D8;
	Sat, 11 Apr 2026 01:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kB1RjDrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8643384118; Sat, 11 Apr 2026 01:00:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3417E83DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 01:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-66ba9898ae8so3798445a12.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775862038; cv=none;
 d=google.com; s=arc-20240605;
 b=Fm1I3UB694q3pzeA2v0oju7iweIrBqSBFeC7hZdQ8meSpkCsmfulzUPYoozsBuhcd/
 JihiNQ1p9GlxJ62I046okjBKKvJUTP4Sa6E96Z+7oRuBjtpOoTxf/YepIp9kepVyqOlf
 mwuNKbT/s5pLIXvK3uSoIeBe0mqdRGRxVioj+J3AKv2r2iExEFoc4flpnPZy7Dv9E7jL
 MKfc8R1TvBOqYR9m34SHYQNzkTvWAnkL9tuAgFvnOSmMsmBn5mDO2ur+IDU8lK+xKzM7
 Xw0/PvuI6wD8yc4qH1LqaAVQacKaDf+yLfg+U0YkaL+VmxWxueRbsJiD6MC+oUSaH8vS
 024A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0AKN/JW6XdclWeBQp7Izz03Nb9TyYlxWskHrEYFWFqs=;
 fh=iRu6TQ64EWVphOOoC0j+mGsr/Izh/4smMKN8cIHoJZY=;
 b=dmm/Dea6Qu8AVHwI/vR5MFuxyIuqDMQgYXZHn7hcupTufrBTYaAoDGkS8kHvAewK6K
 ug7NfIrLLTHmrYTwsD/ZlQDPrlbiEHoPiBewfoxL4/WD95nbXsIqh5PEgfOYJwztjtsl
 WXquzmY+4fprllSMqQ1AAdhLDd31Dk9pY0L10ervX9j4Dmhw2j1meDdGdgxKo38EL0s0
 I/a3FOfdN85sOyy+34p8jWYLP4i6jOPrydTEDdJcx4WHZMx+uUAlUWaMNKx5Bx0796Cw
 EjS/hr/Ni4hHH5ehqkhpztfTXlMNqAm+q02SSOdatc3CAIOPNtaBnJPW8mdVw4oKdTuG
 xPyw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775862038; x=1776466838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0AKN/JW6XdclWeBQp7Izz03Nb9TyYlxWskHrEYFWFqs=;
 b=kB1RjDrVOyo/tYBhwcp5FelQyO9KTtTch9RR8mUwykM4qJKAM7J6/Gi8PXYzLDHLHU
 czekW8HU5bKOHFciRw0W5fsnPqgcwzZgjSAVYmflDDsC6CaKH6NPMXSJ6o8Juk3Si955
 3QYc++Ux6YMoaYRfWxjiFTGmuqFHZlI3P0u/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775862038; x=1776466838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AKN/JW6XdclWeBQp7Izz03Nb9TyYlxWskHrEYFWFqs=;
 b=AXUGOVhM2ILYXW8Gm1eXiGe2npWXMtuWhLk77e2P+J4N54oLqa+85Y4AxhtPxQkGcR
 TrzHJC+rbUJuV8A4rGw4XNYEQwptERTQk2fws4cRL2VpIWb/HEReqOW2iMRwABsC9gEk
 1tBXYIQLAdcRCvh5ZJRmNJI9Dt7Cu3TUMKA3OnsbZ9T8J2E/ApC3C5Z1DirhzolQsmxb
 faMM0Ovd83IKz2Xcq879kgwdlcetsD59IPIimrSYdABspVaw47ch3kFtWt27ukS0z9p+
 HDI6xgqqX/S7HGOv2QB3AwL3zshoQ194+KdeMolCpWWx9w22OGaS//2QesuLaIKXjc1z
 AC0A==
X-Gm-Message-State: AOJu0YzByFccqjUZrZ8k6VULqy3ruzRuQa0s4VcpF02+5IcFoxbodheJ
 YzTXykm+zPGoQeGzCSXvfByFIVEDUABccvW2Hpr/E1xr0vw8oEJr3tSpKXrEwT+tGLz8owAv0jT
 Q7FeCzObbnJ+P1g99uVU3dikgxvWY6IATHNjH5m3B
X-Gm-Gg: AeBDieuL6crZd00JU/7YD77TdGIKvuIumGXqVCBsquzYbA3Pp6HQ+WsIopL92IbPwR/
 W6GWwIvZqhhS61c3v1whFLm/gpisWY7ekR+ofXKZW5B6SD9FOtRidBoxT5zcQVWBZlkk+ae+/OI
 +8tEEq9e83txFSYZcQghQD44V3iRBoWNy+VvyRb7g8hS0Y3S6kZkUewFPtzdI3u6ezczeK9TiCK
 XKqtnMxw0VrFTT3N0Hay3HyLcWuzHKu/b/+KP2HitW3rInV38J/A08ISxUTTVHRS1s5TN0X3X/w
 kxvJJA==
X-Received: by 2002:a17:906:3655:b0:b9d:7b9d:df02 with SMTP id
 a640c23a62f3a-b9d7b9e0c43mr178471566b.17.1775862037822; Fri, 10 Apr 2026
 16:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
 <20260404152640.3297713-3-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260404152640.3297713-3-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 17:00:25 -0600
X-Gm-Features: AQROBzCRbLvnv-FpPBQ7K4IpsSmAialCf8JN1EwOVEsDHN2VD94FaaASE1jSj94
Message-ID: <CAFLszTj_ivAedsWht0Ebj=uwT7GNPNgvh5gnLkaWjBUS5-EmsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] test: dm: part: add test for part_get_info_by_uuid
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-04T15:23:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> test: dm: part: add test for part_get_info_by_uuid
>
> Add a new unit test for the part_get_info_by_uuid() function.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> test/dm/part.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
