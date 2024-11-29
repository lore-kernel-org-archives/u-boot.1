Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A663ED6EC0B
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 13:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359AB8943E;
	Fri, 29 Nov 2024 14:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EO/0MbmZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D303789444; Fri, 29 Nov 2024 14:51:10 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C9AE89338
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 14:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71d54fc1944so845710a34.1
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 05:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732888267; x=1733493067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s/uS6j6VfuhWPgXmfbjC9sn7rE636HmbicGQHQTzfPo=;
 b=EO/0MbmZS5iAP0DfkooPj9QPLuXp8ElK3N6s6S0TpfiPRQb+zr8chrpVDmZxrOW6uF
 N0eTSRnj9dcr/xuoiTty7gnl2ILD6bKXRK5vmjH6XVgZVdxJZYDB0MSV040jzxBOpMPX
 ac5XgLzDMnJFSphzpnRoiKXuNKuCPexaJ67UgejgxD4dupXikURSTPs9iuElha7SYs67
 GfospGyA5GXr6jWH8n9hELsGMCVDIVQbMyaCSJk56X6P83RxXv0ouMBsCrStzhW6In3/
 GxDASL5v08WtAagy7dbzL04kX90YlB9Fanu7kAof5umUHFESoygptB7oN2iu9MOokQ0k
 3WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732888267; x=1733493067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s/uS6j6VfuhWPgXmfbjC9sn7rE636HmbicGQHQTzfPo=;
 b=DO+wT/TfQx6BSgz94wBfW2YF/ubbfgFBanYdQ7DOVMEMqTh7yM4LM/ru4DW7HuobcO
 ZOs8AOxHNBpQSKqtd9K39raFYxHrnlzXJuh4dZvnHvNJpOZSkKyG/UePLfab7AcrpXaO
 1Z6IXLuh6A8S7dMFFnGbWnM4cy8/yVilW6QcQAQgZn32DaAbfZY+Ng7Vw4tRRbAAImx3
 12O8WQ8vxAVPkY8J4xoUuEhJ0JMhJzIzQSnDtCa6RBxObHwaq/slye6jJUWXk6bJNrLh
 Kme0H5nve9LmJDP4dZTuq/irydmdQxmz3n9iQcqdB6I53AoMZ/kw0cq2XhuyyrsANaNe
 GiIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTH0JI4e02v0Pdx6hCtpBKlpruXvxodH/TsyXE08Y/3OSkCyghuX7gqovDWOtTYMyJJSnulBQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzScsKdRb474Qyz9cAPyDe6px1dh0a/zhJEsHReSimnH4wyOg2M
 dSCPdn57PrmPLGdG5G0K2p9zOZgL9/icBwzmUtj3+ukhCnarOfi/gbyotE/f+ANnHlmiK30ZLW4
 woRzPIIpOXvrILV46MnEwk0PCjmYMFiW+0akB/w==
X-Gm-Gg: ASbGnctCGpQnd7BV/E8wG/c6wnEW0tYhfwAJZYsMftdKXC0eyQrxpYCJ7oguW9nUI4j
 KH7cxh+r6LNEAqCOtY3C1c6UFiY8OID3w
X-Google-Smtp-Source: AGHT+IE7Qm78onm4rfsfHoZLUCODR1kVpGsnpwt9ZEOZs9xkSB3tSosOmY2aO0B66viIJKBRKN4xl57S83sBYuExMPE=
X-Received: by 2002:a05:6358:678c:b0:1ca:9a6c:d3a4 with SMTP id
 e5c5f4694b2df-1cab1692b87mr679062155d.18.1732888267190; Fri, 29 Nov 2024
 05:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20241119100720.1297067-1-u-kumar1@ti.com>
 <20241123024219.GU3600562@bill-the-cat>
 <CAFA6WYM9esX2VwGf91P9ics419OXq48zH_Taq_0xtHT19HmgUQ@mail.gmail.com>
 <20241129133618.GI3600562@bill-the-cat>
 <4711a378-b10c-4ff6-b2de-d9da7dfc03be@ti.com>
In-Reply-To: <4711a378-b10c-4ff6-b2de-d9da7dfc03be@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 29 Nov 2024 19:20:56 +0530
Message-ID: <CAFA6WYP0LzJzWB70Ssn_RsYi2GX8ComeASANWysMpN2Qbpsd0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix OSPI boot
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Tom Rini <trini@konsulko.com>, vigneshr@ti.com, n-francis@ti.com,
 afd@ti.com, u-boot@lists.denx.de, nm@ti.com
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

On Fri, 29 Nov 2024 at 19:18, Kumar, Udit <u-kumar1@ti.com> wrote:
>
>
> On 11/29/2024 7:06 PM, Tom Rini wrote:
> > On Fri, Nov 29, 2024 at 12:33:04PM +0530, Sumit Garg wrote:
> >> Hi Tom,
> >>
> >> On Sat, 23 Nov 2024 at 08:12, Tom Rini <trini@konsulko.com> wrote:
> >>> On Tue, Nov 19, 2024 at 03:37:20PM +0530, Udit Kumar wrote:
> >>>
> >>>> OSPI boot is broken due to missing bootph property
> >>>> in pin mux of OSPI.
> >>>> So add bootph to fix OSPI boot.
> >>>>
> >>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> >>> Applied to u-boot/master, thanks!
> >>>
> >> Please don't merge direct contributions to dts/upstream subtree. It
> >> should rather have been a change via *-u-boot.dtsi or a cherry pick
> >> from dts/upstream subtree. Otherwise, it is very likely it's going to
> >> cause conflicts.
> > I thought this was a cherry-pick, sorry.
>
>
> Sorry for confusion , it was not cherry-pick,
>
> Let me know, if i need to send patch to revert above commit.

I hope subtree automerge will take care of it for v6.12-dts uprev
otherwise Tom may need to revert it and do the sync afterwards.

-Sumit

>
> Thanks
>
> Udit
>
>
