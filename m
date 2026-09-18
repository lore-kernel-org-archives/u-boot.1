Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FCBC982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 07:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A1F8811D2;
	Fri, 18 Sep 2026 07:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cx0ffBkGHLY5; Fri, 18 Sep 2026 07:20:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 83336811C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789716042;
	b=BG6VjPpy52peawCYykrj+uICNRuOBMcL478JUGgV5ZR4NSQ7eSa+O1Amn3vm+rKYsOOk
	 kh55V9EBiXtE0o+Am96Tsjjg5ncy9O2+UOCZSsKiCgp68ZVah811hCSXt1aqCH8h38fj3
	 gkVZTtl1o2X2lRFhtYnvtUZXV1S1TG8pWx4T4esIFPZF/lKXvb0JyQe2M2+xscea4RmtN
	 yWZyjloS4QLg8I5sbVDZUjVZkBlW67bNOQwrBjBQeGgALPW9Qk7gs2JSq4C1MJFCqkU0J
	 tIjRWe/iM94hCZvvu+egrz0t/WcNUce45yY4Mo/xxcsmXjSMS6xXc0SQnMrRQRwOjDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789716042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XRHWp1XslMzyOWXq7IBw2heFR5OgHTyqjISzc59iPm8=;
	b=NeL8tKE7Ge05ke7JWpxLnd4+AtFHYHI+RqL7MgUvs1A/kBGUwg3Kvw3EHpknG7vckuMl
	 ncQjMiPzhxIiAxUxpYCH9ZWyeXZhyPwRYrO0AtMvZcUkmJpLqwrtpyjHZ9aGUHsdWCBlu
	 l7TIElkWu9Eg+CBqQdRp19RH2umU9HaDGjS00PdqrJgCsucLBvyuiqskhXY9S8XTsWtvr
	 IQg1+6bHOG5VEf3LvHyK2Ah/MplnT43Yk2pVFugr2VjYEHYkxnceGrqlqQZh7I7bF8+6I
	 JHyUTcOWOPbnA/l3APANKSbyqU3BU+7+KSrk+DgW4+N5UwV5FIFQAqDEk8J7A1i1gFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789716042;
	bh=XRHWp1XslMzyOWXq7IBw2heFR5OgHTyqjISzc59iPm8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lyWWYr71w17KpxG5vHwPFxTBZuBVusQgxIKr6z1X9scR6k2BY8O0GSc1ZoPDIVODI
	 D0h6TRrj0ekrJN/bA3yArIvMOAx/9wjHqb4jXmZOK1QUfJZKFcOGld0mdZj1g/Ug+N
	 C0j1d2CNoHYRIdjWC/6nZTet2nXIgmsVlYFBoGyuw4wc2y33YkL3MQ1hgaMvF3H5a5
	 K+m2r+97NDNZog97OCqa4Pq0VoK2nxI8Nag2zryPGK9We3PwsNxJ/gMJgZN8dtlGGh
	 TvNR5JgaJMSx0nQmrojxWgbDn+KVtBZaJ7sQwWRaz+P5gd4srGLUEgd/CA2oqwYgvr
	 064+X0n85zojA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83336811C1;
	Fri, 18 Sep 2026 07:20:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D2C6362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2D63404CA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:20:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01Y8CR-iq0eG for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 07:20:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BF1B0400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789716040;
 b=Qkufrd/0nSR5DJ5CqxByYlzqIbfs6vFcIn5dsaIKdvoJz5s5nU87aYg5TwVX3Ia94gCK
 5EkFUt+bqj9P4Qdjzjfbf0cjG5F3puBaVgwcV6ANPhvctI+gM7K0uP/KUxYkckq66eHO+
 7Fx+hVxaKwP5HNvccyX+93jFKlDozSffZqVLz/QOhxZ/+jLPfgnhsFBN4c06UuKis/OSJ
 Uab3HZVPxlp6anNve9jiL4lpiVLzuHKT8Ang7dIbfEq68aWy1JatYq2UlkINNkysNff46
 6086B8G359V521xt/Dyh+ym3b9WS/u0DC+ROcrkGdDyrsjBGd9C1Mc3jw6snSG6CVGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789716040;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=XRHWp1XslMzyOWXq7IBw2heFR5OgHTyqjISzc59iPm8=;
 b=LKrYdqqZyWN6+YLLYQG3qKRXtQYHHjqygltqrXtKPAPj2HOiA2gv0+AejYTzef+hhYtP
 LMdy8TnpraZkJ/lAxfbQ6R+rcq8D5vLuFKK0PcDRhrY4GjvfzBd2xlMFF33h4V7bkAfmW
 XqJZWTG6LnU3ZGGhwLk8JxTMf0W0lzvhWuXmG4TnAGQmfHR82JP7JYVPaqobtbqJv4vg0
 k6NXJqOGtrZYQppJxkWZRm4qiqtHWd5I9u4OAgx/CccQTRgSRQfZCbw90Bg5EetoBLe2E
 EJqrPWf1xg7mcDgrrq7soU/i5y/1THHKbzpdpQ0nlRSKnhJcsyon3JDPAvyKDClfsiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=o6CuZEwE; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=o6CuZEwE
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF1B0400CC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:20:39 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso2792055e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716037; x=1790320837;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XRHWp1XslMzyOWXq7IBw2heFR5OgHTyqjISzc59iPm8=;
 b=o6CuZEwERdX3r7o+rghDN+q9TE6ebfPtlJp0WuiH05JvJ6XfkAfjNIevoHrGvCHdeN
 WdRpbFZMwMJmDx4toTN333/7vNffp7kAcaJKTVf+gA00D+xzYgIk2vNXD/Of0MCrn89Y
 vkDTJd91rm8EMrSv0Datl+UsAdxMGejjTe5ELXBcAKZFJauP7xwpWPa7Y6VBKfWYaP7x
 mjDxrR0vUiYnIFpY1gdavWEiRQzZSZD4wp+9RfX6dJwwxWlBv69DlWyrcXQziKtE0RTn
 WVvSG4aWW/r7ST/USQ6VJt4fJP0vdeiRYwqqiivGvfIYe4yCvVL74aMDIDQJ1Uc/WFzo
 AOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716037; x=1790320837;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XRHWp1XslMzyOWXq7IBw2heFR5OgHTyqjISzc59iPm8=;
 b=h89xA2MJ7iG8bJQFzp8yyMbRIjCSeD/JanuIW9Rduzp2webXTyh3cC0jRcdEJNIKUK
 Be9PUOv0dTVCh8rHR9CMMdhdV7OUAR2eri0godJxbl21W0KIkuRZXuQXpf4dAH3JeEo+
 /IBkCIsuLVHT4SjEdcTMfYRchD/cOBRL6OB6zG0OLYWwGwMnpb06DZQd0PKozy/IzzF4
 GcAf2rX5mA57YsyScKN8LaOuZRwb3rOwLkN8cqr6yQDG/WjZ/Q7dZDb7C2V8UKrN0PB4
 k0HHDHdTvhbFT1xcmlxFCPfJPNPYp0rdk9zCsMT2ykAA4RJ9s9NRc9wvk54YQvRe44fd
 Yt8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxem8IJCQ5OiSwjKtEiraP3u5K8N1g/h4nhSKATZebYYGsUYIDyZilD4sSFyyCLiJH/3bOcwiI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mHiL0pxM+SryaksHuMssSBdjtc2khOa/7FotDg+7hQm/ntKmj/
 A2RH+OSFZzbG28PooC+8iWPYQuJqyAdoCpRJSi7OLHv7EsbFZCFFH37c2SGbdVJuR3eN9jqXJGE
 aNs5c6wf2qQ==
X-Gm-Gg: AYBFou1HPmVoPsV7v8jycbg6DQkh3SqO4jRqlqD470G22hXKvxfbZiKmurgPlACIHmg
 qNG55kyrEzcm/126EeveWmQgALCIZblTWMYO+bIbxWJtCPHUdVH1NMmTp+xZBi7/qYBMXPz0oar
 e9pLLAJW8c/1Y7+wKDzGhDG10Eif7nw7H8pdFAdcopKR3SHtOvsNt7x9Gd4XZSnPTwEUFD++EFE
 asUdaAeR6xrVt5sBTaDFX/iV44NcBDtzOWrwgR3aYeM3TKBoAgI5gA9G13YwhC8xa8dnbKLTG0i
 Tq5QDtCm1mDBC0r96Cq4RakxuW7UiG68GGzM5uOoXv7ucWXL41F+T73KeVpEPIDxIcqVB5Qu8sw
 wW8zng3fXqBKBpuN4h4GNjQmnpBrZmDTxKLFNf/3wEut/WsXc3thgAbLubDw5qmajyZRTgUmcyh
 HabxVqoTc2w1z4tbL+4088PGxBeVPbubJ4PQafZw1yRfnKzR66dJ0MV5P7WGoEIK4b8nqUDCzOW
 1fPYCweK2V4Xu6rUhqeVEcnm2Zr+ug7wzh7mhylbmx8WN1s/0SWb1bSaAbg381gSG9MwLIhLvTb
 9CTWaHPm14JrbvAfPVesmR19P4w9+zUtxhdz4PWGTfT6B0kUTsj2Yuf7hXkey616GTa4owNPWPV
 s7xYHzAUm+hBL0FgFZjM3DdPrJPsoNeeYbbnZCmRCB2sqDUCVWQb8nkdZIcUWR0LiZPqtkvhBR6
 wrxPVtFWB/W0E8NGPFOEyLxCmlCdD95SXVcttBo5hdSmHD0gvHmcXPjPauFBZ7Fr8NK54g5PLP6
 NTx/9I5w/dadjWyFylGefuPaa14IqsTwu9w/G1w+4j1g4k/r7C7YrvhxWiWQbsdVArVxT0FxrAy
 s9DIlP0a7YysFg==
X-Received: by 2002:a05:600c:6206:b0:49c:fff9:f684 with SMTP id
 5b1f17b1804b1-49fc5735339mr16828525e9.21.1789716037340; 
 Fri, 18 Sep 2026 00:20:37 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc79bdc35sm31504395e9.0.2026.09.18.00.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 00:20:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 10:20:35 +0300
Message-Id: <DLI9DWD1JHZX.3OY4T6LX0EY99@linaro.org>
Cc: "Igor Opaniuk" <igor.opaniuk@gmail.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH v2 0/4] cmd: optee_rpmb: make it usable by scripts
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Rasmus Villemoes" <ravi@prevas.dk>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <20260903212215.2331118-1-ravi@prevas.dk>
In-Reply-To: <20260903212215.2331118-1-ravi@prevas.dk>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Rasmus,

I just noticed the optee patches have been applied.

For the series

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On Fri Sep 4, 2026 at 12:22 AM EEST, Rasmus Villemoeses wrote:
> This all started by wanting to be able to fetch a "persistent value"
> from RPMB and use that in boot logic. I noticed that the "optee_rpmb
> read_pvalue" subcommand had two flaws in that regard: No way to
> actually store the result in e.g. an environment variable, and having
> to know and provide a "large enough" size of the value.
>
> For the former, it's just a matter of letting the caller provide the
> name of an environment variable to store the result to in lieu of
> printing it.
>
> For the latter, the tee side should have provided a way to know if a
> too small buffer was passed, but that was never actually implemented,
> and instead a silently truncated value would be returned. That has
> been fixed by adding a new variant of the
> TA_AVB_CMD_READ_PERSIST_VALUE method which does yield an error along
> with the proper size to allocate:
> https://github.com/OP-TEE/optee_os/pull/7959 . That is not yet merged,
> but I assume it will be soonish; these patches should not be applied
> until it is.
>
> v2:
>
> - Drop the part touching common/avb_verify.c, now that the old
>   TA_AVB_CMD_READ_PERSIST_VALUE method is not changed. That doesn't
>   mean it shouldn't be updated at some point (the header file promises
>   behaviour which is not actually implemented), but it is out of scope
>   for what I intend to do currently.
>
> - Do make use of the new method in optee_rpmb read_pvalue, and
>   implement the "store result to env var".
>
> v1: https://lore.kernel.org/u-boot/20260828105005.200338-1-ravi@prevas.dk=
/
>
> Rasmus Villemoes (4):
>   cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
>   optee_ta_avb.h: add TA_AVB_CMD_READ_PERSIST_VALUE2 define
>   cmd: optee_rpmb: allocate large enough buffer when reading persistent
>     value
>   cmd: optee_rpmb: make it usable by scripts
>
>  cmd/optee_rpmb.c           | 70 ++++++++++++++++++++++++++------------
>  include/tee/optee_ta_avb.h | 12 +++++++
>  2 files changed, 61 insertions(+), 21 deletions(-)

