Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC685606A32D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SFeLTnba;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=dPR5E1vk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F50660797;
	Thu, 12 Nov 2026 10:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3AC4DrGhqOZP; Thu, 12 Nov 2026 10:17:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60439606EB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794478638;
	b=a4ihvASURdtlmRtukyt7FphSpoO7YPSzN8SjIuF2u5/oUhkBDQdlvs7UHplPwm470Hqv
	 hadFbiCilhpMPg1cO6C7LIfV5JoFFMwCChZbJdaIO13M4oUqGzmP1zQqphnsu71CJngbV
	 5JRsqUPbTW5zHDHpchpCKAhTUMfJNHwNUf4k/o9g+EN15bD4Yju/Ip9A3uqYuuB5UD7CW
	 8OmLK7JOzcU/8F7D2wOTwK9a6N9fjijxjhmeGUxqaluhSUC3abDB1B7K4QCu8WBb8tBmW
	 FzhvsnJpZ6Cn2UXupKYCwF/EhJAiOnsCAj+d7xICvH7keSa3rNTJlNt43lCF7PjutZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794478638;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hXBlUYgGaCFDYD0Falv5i9Hny9ySa4V+5Xr89NgXxUE=;
	b=ftGyQbiWBcYotIv4wtKgqrAS4dL9JXFRudpVcQXGVh/Ly6JhRv7wra4MVcuZLqFhYCTE
	 JlzFBpVdTjA0ELSR2o2uw6d3HUjTF2OEenv+spGSSCSoX91Oy6Y0qPEI0etISxJcq2OxG
	 Z40+ikCP3jR0qqCG9eRQiDBnb3thUL7EvTPXPvEbi4MuB+DHCwqse0cGsM2eR0RFBB0wB
	 HWyFJmUrn+fjejd/mAKy6L97fQvWD2saI1GzZ4VHWcGfQf2m2jup8yTZTy7cjeInJq8Zg
	 l4Q7Rfo+fwkuHvYy5gRdZkY+2DYDXZQt/Qkp1UosWmq3/p71WisdWVdko22i2+ziNQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794478638;
	bh=hXBlUYgGaCFDYD0Falv5i9Hny9ySa4V+5Xr89NgXxUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFeLTnbac6Zp+yrNfs/HZU135wOosxnQbI4X2QG6CLI+uefUyfY7kJusjNwfu9EGq
	 8Rt53DSSB0xj+ItLIhYsRY8AgfQRBQRxUy/D3NXiAHtzvpaCa+uy1UwKTJjnRnYuTb
	 g8OSBXUAUCooKdWPNZNZdTQI43dcnGleIce1jGJqeU6f0lt3/iBSQy/KIMhcuMJohg
	 VDRmGqope2n1P2xHraHNRBDnuNAdh4y/IIHF8+XvKFLT+QQ93b3oyeCmFmvTFlq9tn
	 Hl0o5AXnEZyuLVcieAnGMZLxn81WhHSLLmZjsZIj5KBzxaS7FSi8GZS7WJcdGAzKb1
	 GZ60A4DfBibLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60439606EB;
	Thu, 12 Nov 2026 10:17:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 468E2335
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FF79400D2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rSBiAJVj-Pi for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 10:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A0D740086
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=robert.marko@sartura.hr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256
 header.s=sartura header.b=dPR5E1vk
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A0D740086
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:17:14 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c50604721c8so361812966b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1794478633; x=1795083433;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hXBlUYgGaCFDYD0Falv5i9Hny9ySa4V+5Xr89NgXxUE=;
 b=dPR5E1vkOhFWidSIuaYXZlWVdZwGQ3PsVZ8n5fDSyMYtcExsZQTay0AXXDVg0w486v
 WiCld6HNUP32Rn0gKk3ebUAEknojxauZ5APb3HJfr1wQRX73aOYhPrxL/NIt+mxbtsra
 UbFgKksq6yNbuuOSLAv2p0s8LyhVxs6IuNLsed+H633kNBktCzEMGaqm69huPGDybTpN
 zcI9g9W0FE6/7r1nLhubtznhGZpuI1QcvvTjKDEzacQxOlXNgLX+6/lcsjIpTBb7tSyP
 AZGR6Fn+XgHkQTw0J7e51wO8CKPW9l937f8xngTPlgBgQqhlaYI6LWVNKjdjIIe68ZRr
 fo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478633; x=1795083433;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hXBlUYgGaCFDYD0Falv5i9Hny9ySa4V+5Xr89NgXxUE=;
 b=pP13E0K4mo7/mUQ/nNrzprljhwbs1rmVZhTqzCuE4yYE9gHK5DnMGeXK90Kso5o//7
 bhm1nrMqW9AGzYNwd8SROhHI/d5QwjImMq8OEh51lu+vZy1PI9WEj1P1dguWJY1qOiI1
 wcbiTZGuM5pbcT68e+k9+DfdPilRrwGDwQz0P+gIMG3msxRL14H4WW66iFuhuHd3is85
 TiY9oUpTeCHd3GdJ5miq/0zx94pQ5KKA1vio4BzPG92dAgaaxGPTp2ShgdazXhoh8CrF
 Mc8HOd04N/bRpkvHfpsVk2Y/pMh5WJ2RqjEhNeHkplhwKRaSvyU6enU4tYvZR4gfRu9x
 ahLw==
X-Forwarded-Encrypted: i=1;
 AL+hErEootoZBXmSyAzrl7W7sfkfrG/Z+v1ygU2HUvnjPMCzNjxrJ0+w1kT4ot85K8gacmXALiZiiKc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9X4VRhU/ZFSztc7zC8lapiYIU91BzlBT2VzzNjVkPaCYBzf5Gx
 ZMxW2cBVizb+hs7JSiUDMAI07iZsF2eYuZ+pO7QggeG70Kc5pFKXbI1wAjY5w7tLC0pd3enE8pP
 TZRAZeZaCtwBDtOpAXm/acFPV4liq9F55MQyJ4txhrX5e11GUCUpHAGM=
X-Gm-Gg: AYBFou1vT7hqsXdxVnMUcMMgGB9ZKRwUrh+XMb1RElZvI2U7ayef3c5ImPtu9cXIx7M
 7553ReIVpsEeBT4+UT+Ye18MIITarkChcukzGRz/H0CC3gJzTAS9HHagT9JAK5gi/+DAki8cb/m
 9cxOI+ybSUp1r93iRM0HNP4i3tr+nGcwOaRowuYCqupKfx0P9S5AYczRefIlfwVNLtBmAS2JGO2
 Yz4fkdm5bhcAq6ySHJDkFeLmdApK2x8WOAnIC1NyT3Jn5me1KR3qDR+jPsys3M1uNj7K0yR7Mbo
 19fUeecIkuQ62DpDbAPEt4qELdARd49nuzGdqcXrDtrvmp2lkUu/8tolTTASbjC3mcYi2lo9qee
 VaiO2SWNu26j5FXaaRElWssiUPUXNqqF7r5MBlO7Y2UAknWbyXkVSwDrB/A+a4s7mWcBGZfhGy5
 SfsVl5oBLxr1nSXV1nVY9q0CZ/fwWsH4UilUkO2lrVnPpcSX+QN2rmqQ==
X-Received: by 2002:a17:907:2d8e:b0:c2d:c800:d797 with SMTP id
 a640c23a62f3a-c50668545d3mr397166966b.6.1794478632965; Thu, 12 Nov 2026
 02:17:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106132031.966174-1-robert.marko@sartura.hr>
 <8f8c6cb3-4069-2165-d799-afbdb3228fa4@nabladev.com>
In-Reply-To: <8f8c6cb3-4069-2165-d799-afbdb3228fa4@nabladev.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 12 Nov 2026 11:17:01 +0100
X-Gm-Features: AclHuK_LSuvjSLPJZvSYkZe-K2ZPqTxHt8wYjvQhoO_sVpbbbG4svXW1uA9cByA
Message-ID: <CA+HBbNE3YT6bmm_ceYssDodETfPYz0LHjqmWxZKDSCKA2VMt8w@mail.gmail.com>
Subject: Re: [PATCH] i2c: at91: Probe with an SMBus quick command
To: Heiko Schocher <hs@nabladev.com>
Cc: ehristev@kernel.org, trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 7:16=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wr=
ote:
>
> Hello Robert,
>
> On 06.11.26 14:20, Robert Marko wrote:
> > Zero-length transfers currently return success without accessing the
> > bus. This makes every address appear present to i2c probe.
> >
> > Issue the controller's SMBus quick command and wait for completion so
> > NACKs are reported to callers.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >   drivers/i2c/at91_i2c.c | 9 ++++++---
> >   drivers/i2c/at91_i2c.h | 1 +
> >   2 files changed, 7 insertions(+), 3 deletions(-)
>
> Do you have some hardware on which you have tested it?

Hi Haiko,
It's been tested on the LAN9696-based EV23X71A reference board, and
our custom one as well.

Regards.
Robert
>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>
> bye,
> Heiko
>
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
