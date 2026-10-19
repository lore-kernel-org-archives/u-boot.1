Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8773ACCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AE5E80F67;
	Mon, 19 Oct 2026 13:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUKpR9zgpBFB; Mon, 19 Oct 2026 13:27:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7BACB80D77
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416459;
	b=YhYpYpU9FxIj2TOGJXPt7CVr/GYrFtW4Mf0kKgaeIhLVGxrgwJy/IQLGjAfF3LU1VIRV
	 /Ljqsco4DyYSrWjERJzDH0fuCZcorExAWlGTiiuZfryUSx36vNAlIdiaWqzFOGtoux3UR
	 RppAaWCwLqjYLc5Osm2bEm/aLfLQPmUmuwBk4PgI/F+9QvHFpsOe3EECrueKQq0BB1//1
	 1K24DdyjHsJMIlJbdTtHBwznfJY9tLzATJWmzZo+m5vU82Yym4L285eHEiXmGR5ZVao56
	 UUaols7vursG/8OuZh+xXjBgDW2xSSF1pfoX6kilTrLRphexYTtHT+JSPie4UL8YqOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jnj0eRN25e58ITgPLdIQD9wNJK6bYtrMZO8mWKuA2Vk=;
	b=IhMqTGHz8o+ms4idc0po31ZXCdXWFkZRshNrOkj3moKyT8E9aiet8lBxqaYDooCr9K4x
	 WMh+32xlw5XH8Z44Zgta2OBYlcVFIL7bRaZmis70i2hE2nqPAfSlNwOODcKx3WJPF/8T1
	 uWxkvDqsPGEIMBY8rCZoN3PyrJpC5QFYEZVldWn4X0kY1nRO1HPcwD5roTUZ4qR4t7ohk
	 1EZ/MDBcJ4WBXaTbMJ1y1+nrMmXJ5A8LtAZ/H+AcofL1u/LDPjD0nnfxJnut+hx/qLf+z
	 g15rBJgOXR+iTKX3Ju/b07xx99d1yFU5Ty13jElY98KcdBMkXKH5WOTDVCbd0FO0zOA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416459;
	bh=jnj0eRN25e58ITgPLdIQD9wNJK6bYtrMZO8mWKuA2Vk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=idI0Zt+OfXmf+GT8KmuFLPpsxnUc4/+aa76YOOY8H/Z6C4KvdmTbStP7iHg0P452v
	 HYF/y0REPgBlPgSyqfU7e85L/uw82m/24P6+552v/GELj2a1wp/cmZ2l54oKZ5SPph
	 5vgGCM6xCZVEA4eLLYHevyyVlCGeN36JBLj9Z4PyEbrP96kp7+dXU1UPpZNHN2zZF1
	 1aUfgPc2ZYDrRbVB6Vlsqf8vZaAZ2gKZFRhoAnPMBuCknADJ0twnViWPf31Ypuclr9
	 Poq4xcMEqhLz6W47B6bzZNIIK1IS8QHjxbzsCvFsPOve52lNfvmyhYIrzZAiti2/1z
	 ZSwV01L5BD/WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BACB80D77;
	Mon, 19 Oct 2026 13:27:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 754411E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 671884014E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p2nsONzES481 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:27:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 68CE840049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416457;
 b=A7vbXZRh2SAaI5YrdftglihokeF7UUhhUeOEf0CAG3PbznJbC1vE5cDxFHyVfaDYY4Gm
 MJAjd+adgd33w9sovFv3txshk+HrhW9enHX3uNz7PqIRxhgBIjOiwj/i24BWAWWsAADtV
 nNRg6CgZJqGuCC/tBR+IpIgHxOod2wnZKmkX7I6mwu6upLp1RgiVgXx2EUHpEMs+4tkt3
 ktpOXxpvwD/aADauOjB6TYD+r954n9/6OACoW0cx43ferHmjXB4shv21I5J3z0Z7/MzuJ
 BR/XmPY4PJx/b/Z4g+cfdZnDjUAhrl6a3eI5nXixLV9L9n41MStny0s91R75bnniXAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416457;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jnj0eRN25e58ITgPLdIQD9wNJK6bYtrMZO8mWKuA2Vk=;
 b=dCrOAzUanySTB7oHKAyRUSit37PZqzkkxE36fuIUAqU5KhJrTQ9+6aUAcdyR3kQ31mKe
 mno1eR8efTQf0eytpVWuZXgXan7F16vj5PBd0Y1/sXM18k+A/KrIdQ/YsdNzfChM7L4eB
 3uCOHPxr0iYcrJ01GdwfzMr/o8d8uuJyOuA+zY0GxTUi3NU3fQ+Rj1ffxH4r+/qmVX5vM
 MNS+qCYn7tsfxdxZQk+4A/FchUucUFR6aZwSaaURMbo8/upmQTE6aUNRPBpOO0PZb/x9N
 S8h/x+n9J+4ErOqjd1d9gXb5wH3g2Kf4E+H21jUrPFttve50sWVhdJNB5X7u0g7yplA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mxH8XiuT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=mxH8XiuT
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68CE840049
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:36 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c40447e25e6so237390266b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416455; cv=none;
 d=google.com; s=arc-20260327;
 b=l59wYTenA2jeGkZJvDdQrLjdQKqypI3L7IPaPebCSnYxL5QxgRd0/ED3HEs0QqK7pU
 rXaf3p67bpm157pP0EJMGizuJk7QdJXWqJqBzwi9vuF+I9ZRxRwTxwC6ps7i6IcdZj3u
 AOIHs5Ff2dR8A2RHvIZtV9LZczEIQPL4w5lTgzwZGZySpoMzrRiKB/vELcAb7QpNXgOe
 9wawa657E2Ibi280z5p6tbTLuJNL/1xu24fTYTAUcpagEYG2SD/myBUixrG6IFZrHdXG
 F+7R+iBb9CgIAjDgms02QtWXBvXQ2E/scDcJIS3Aq68MeXbVawLAr8Jt/khZbKD5bXjb
 8wSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jnj0eRN25e58ITgPLdIQD9wNJK6bYtrMZO8mWKuA2Vk=;
 fh=sj7VqyU7w1rnvAaH9iJklc/MSitvENB9t3jP9/E+0RE=;
 b=afU53h5N51SFcPshUU7GQ+37YGFvXev5tDz7iqrbrv+OgcupLrQoJZRmLpw04aCOpL
 xqwMIq9J49FcP2VxE6vdsxwgVbXlb5s1dTWXQTK3H9avyN/YI/fUUSknJ1EesQUJQbPV
 tJYlrTHa5ppDvCvdroX1gthrHTIO4iy35hHSlNAp8+wgaXb2Rld6+FJKd1qxC80BOAVJ
 1e0f6w5u3a9Ov7jCBpP2hhutC48tZ+Y3AToHmY1AbUuJsgXOe95ptHJrFLYkZkwoBG9D
 okitN2n50s+5Z/6cYIztMZOZMmel3GbTWq49mHjOGKPGQZg2RewngomZRmJ2GBpoNA6w
 t6iA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416455; x=1793021255;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jnj0eRN25e58ITgPLdIQD9wNJK6bYtrMZO8mWKuA2Vk=;
 b=mxH8XiuTtxGmiHoW0DB3GO1CgZwVoQxsmNysve3wuHaBr6I3XQNi9+WYG5/PURrReo
 Z9mImrEM2JUPf165CT18cIwpRqRGIBZJiy5dIMI1qJ2CcAyLbIRTPCP0pnf9t40amsvR
 M5H1rbVKFMEgprdCjpk0dG1CPF06iGcsBzYHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416455; x=1793021255;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jnj0eRN25e58ITgPLdIQD9wNJK6bYtrMZO8mWKuA2Vk=;
 b=U/e7lHsm5TE6i0jd7VglocmiMK9S2jk5jAJBTzTP4V7AnrmdajyGVvVODaE4ygz6FC
 BYDLeiMYXhuBO6PFGLeH4horf23vNQE/raujnhg7ls0ivpXdDEmj7w3h4m/0rA3ZhnL+
 PXDAK+v8ISX+fmHvLfygrVIUJyPmmutnsnY3Cpt+ZrYcXNtYS70mBGGWSOwU4d5stf0o
 /7rfGFsuY50TIOVk8JiwFK+Cq3B0p1474aNuVxTntjt6d5jYk0w1I2UIiVUfTEkgKoFt
 g0gS/8Hv4INJLMn0zR7YmgTgOujVvkF6LkvMvzpzeJHtpNiVp9MfIVcNI0i7N9sdIrJQ
 VTPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0IDx8pBYvSstRwEZ7nukGRaAgxBjO2BXk1vd88U/AVBTClCdo16ifWJf5XQZQtPV2BQelyI4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLU4kJm+L8E/t8D3ZdRJcLmjMBQ0EfS/qBeNtAYwVgT93sXQscZ
 k/HEzMFE8GUX8UoZFV2YnJzEQBaQVqtifgJicTn9ilvVJ8fZZLqtz9nyYJhUlYXYxt7LNnq4fjg
 BY5pFEOrf3tk2pBpGI7kPhYtaKfFqts5YqLHeXhpx
X-Gm-Gg: AYBFou3naWls54cQq/3anSnvk/5PmkCI5xO1AxSiXJgoxrtPQFugnIEhEdOFS7yqhWa
 JWc6fFN97g7x7jFPDSgth+7skRglIDb8fK1tJ5/bl/JHDHrSvXNR1AUUMsjs9NCsha4tKspmYuQ
 OvtLeLK+yKVk6imZGXlB7mUt7fI+R1AUjWjpjV6Nfc1wHBHVitsl2guaY5L9TfbAznuPGPEqxjG
 DU3TeeJR41v6zwYNLu8I0Z9tJFEEIW4NSNt6tgVcbQohjhVfYG3RNPl0NO4+Khl7kq5ln0Wcbam
 OjTu9I/3tWv7GZYqZkCCtLSKkHEQfQ6lZY0PID65A45us9NmJzbg9A==
X-Received: by 2002:a17:907:5c1:b0:c3f:8c92:3b4a with SMTP id
 a640c23a62f3a-c419df3e37emr517692866b.8.1792416454928; Mon, 19 Oct 2026
 06:27:34 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:27:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:01:11 -0700
MIME-Version: 1.0
In-Reply-To: <20261016040216.3636305-1-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:27:31 -0700
X-Gm-Features: AclHuK-DmUDg4zRTOlwUUqhg4m9M228a6sHlWtzhXkp_bg-XBOeYrgI-k6-zhsU
Message-ID: <CAFLszTgb+w2mbsw-h0fHmqoVztS5ZNx2ZCM+R-V3gaJONBAOKQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm: google: Add initial support for Google Tensor G5
To: visitorckw@gmail.com
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com, 
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Kuan-Wei,

On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> This series adds initial architecture and board support for the Google
> Tensor G5 SoC, referred to in code as LGA, and the Pixel 10 series
> boards based on it.

Thanks for sending this.

Please can you add a doc/board/google/lga.rst (linked from
doc/board/google/index.rst) covering how to build this, the BL33 load
address, the DT prerequisite below, and what currently works.

> The device trees for LGA are queued in the Samsung and Google SoC tree
> for Linux v7.4 [1] and have not yet been synced into dts/upstream, so
> cherry-picking those commits locally is required to build this series
> until the next dts/upstream subtree update.

One thing I'd like to check before this series goes in.. as it stands
google_lga_defconfig cannot be built from a clean tree, which breaks
bisection and CI. It would be worth holding the defconfig patch (and
perhaps the -u-boot.dtsi) until the dts/upstream subtree has picked up
lga, so the series lands atomically. What do you think?

Regards,
Simon
