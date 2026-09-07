Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E37BC79F99
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 18:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F4AC6060D;
	Mon,  7 Sep 2026 18:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dn4MyVKKz8AU; Mon,  7 Sep 2026 18:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 72D63605D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804405;
	b=d3LVqwQoKTFbVtCLK2QUTfkxuykxUwJTNsal8MgVucVald8vN4ekDhWvOIfpRWOKJZPs
	 QKM22/DcSG5cX0GCqMIlGYGhGbgXzTA0divck9mONzted4/McDzXtkl6jyqx91FPSvEXV
	 XNSfmems0+ylbQJD9QX+uuUJfjyKfPDUDW8TOrHLPc+nqdWssM81kqC3lbDkmb7sUpJkF
	 7zuj0+VHZ7Ad1xrA1mGDVaOyZw9EEHwMGoY6P28e5e2z+1tv3oXjWfwVcLdxIkDl9U4cg
	 GJ1RmLSTsKqrCvKTlQdtTwN8tWobJmXvHJK4Tv4L07AK7JQqynFGB2s42YjzRY7BQ5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788804405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IkSVNLGh8wDaK+xLbSNquZoPV1bKMaOt6dhO88U5KmI=;
	b=VvXxXScb7Ac2ikmjc9SL0F7ln9U7wIem0D5WamAPeAtAy808Rx1s/M7ns1RGPwxbxSmx
	 PPZYU4+UGGQByP76O/bBvT5J96/gM+JBTxjDAfIYfKfYFrp24Asr6PR+ek99ME0ZK5Phl
	 Wf+hHP/ieD+wMaIJHQhp8kzuUNMrp4bo1j9qmaT3LA2dh1DPVLCA/cmPePXr8Y8zGCZYO
	 kYT2BAd4YFGSfmngs8xjp+MsdiVOnr5VhnOPv3O+EvrNgHC5EeaXadlcG/EKl6mWfjLSP
	 8w2LKDEKnyXzdO/MCSfmXz8FNgoVl/pROADXhV9B5ciri7MP5nkD0rxwj0gdJoq8M4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=c2L5J1Xa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788804405;
	bh=IkSVNLGh8wDaK+xLbSNquZoPV1bKMaOt6dhO88U5KmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UHupopDz0bPuNpMFKKuBhMUP06qFQjBuTH0tTMObSVdZPPSejIG9TK5TiJFQbwT10
	 fM6BWkViCIQJnAabcBT/3X2w7TWfzYMq/q8h7plBl/naoY5+JoawxYMkrks6OgZRph
	 cj+jzz37KcdyUDB8F98+YM2HaP1woFVy6NTAn+pqyqQcLokHZcXe8YDaJAxBrQU3UV
	 odc55l89et7N7kvODoHwClBqkI98g4BXkng7ZC0PS+0xLQ4J3MSuTM7hNJkUKyqm1n
	 XS5+IIApi/8TahV8jvKJBNsKtcAwFuJ8vewoOhUSaKjSFirb8hn0WqnILDda9lSkh8
	 gURLAdSyNLimw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72D63605D0;
	Mon,  7 Sep 2026 18:06:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D2FC388
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02C116060D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLFH1SdZsJFn for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 18:06:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EB434605D0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788804403;
 b=nSt6sHSiAGI8aG3cpHvBdj0sNyhhbLCnYSw1GYXoG7Tz9mQOSoaM5Hg4Ca1W2ym7Cc9a
 A3dre9PuL8gyEzS6EFca8i07o5jcE71Ns8WP+NqtPbyBMEgEywTIRuaeDYBPaII7M4bVT
 DvmBdjxW79HuSzFbxIPXX7yvJKmnPYFjuGSmooZs//DynpkG3aenwYCVYKvZy8CFBA2eq
 CzFd7rMZbUczdK9c4CPTUquFgflfiu1jxE85RGxw2lmEy6j5tnOFFTe8+6F9wzsdRkOVc
 +ZZQZBIfjD7HNtoETBHaOVkvy/P1cS2CvrnPFiDEBm8deJPcunUd5X7JTcnV53aE9yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788804403;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=IkSVNLGh8wDaK+xLbSNquZoPV1bKMaOt6dhO88U5KmI=;
 b=P4sPA2/O3PUHOv9UuN7kkANqrfMMXUyDS44N+W8tnpPYwo4+/JS/ZYTZo0sKn7Vqed/8
 wIdd3TLqK+NMwc9L3OkwqtoHICbYJGjqkXeN0zsfA6mlu8WT4wKkB9g9oTowaR4SYz28C
 rq5GGL440b4LOZiHETyFEmHWv3PAaUS4jrFyZsuyDU54UYfVK3Adsusq+t/fQtaNAeqmq
 KgjH3Hxx3QalDFBLY/U/Oge9xwu/wCF6uwFOkzMTxp3a+weF4gGPpRsGSyOr1DA044VRc
 FUAK+poineVWRa7UfYeUt1AOSzYX1GOWlYmD39nfys2FmAw3Y841Cq9FGnPsjpkE67w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c2L5J1Xa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c2L5J1Xa
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB434605D0
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:06:42 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6b35c65f4cdso1333674eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788804401; x=1789409201;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IkSVNLGh8wDaK+xLbSNquZoPV1bKMaOt6dhO88U5KmI=;
 b=c2L5J1XaC9v7jOIYrN0Pxo2Gty1eYppdAjdJ2u2r2zlKsVbFyCO2ojbNQ2ZUYlpG7P
 ygH3FrvhaGvLj7HKwZIxjEzT/+2n+XIHU1iao2Me02MKnoqGYA7EKmUtSkXIlZVn8mKx
 wCu/hPtuPIU1y2pjAHGg7wgrMVdFPuWWTE7ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788804401; x=1789409201;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IkSVNLGh8wDaK+xLbSNquZoPV1bKMaOt6dhO88U5KmI=;
 b=on5eeRlXL5NVfyqP0snVM7q1wVmHcB80wyxHvSWmmNMIRw1IXhb5zy3VO+WkxoHDUp
 h9zDnBUo3y0DkeujWseC2syruCJ9JwqGRhc7t2pfV0umCVroyz87CBEM4odxPehS097v
 uvoOXVGKPKpmNwhwznYLb4gcWX6Iu2MZEk04N5LyMi00K/uFp1RvUKFEzZPrOv/jgkBN
 xRMrP55c5R80Mg2P7clAffCWkP++KR6o+hC/QyM9t7ntp+p4KL57RIm/ZyI8v+koZEoP
 RQf/55FYO2RlqQfXnxyYuJ4IFIAcayIyYUcrYEfg7yAnCRsM/QNkIUUcehoBYk2Zzj3t
 2X2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwiYHozo+fI5mJ/FegH/CB/ccTgOXbSZ8AT9t8jO2waj8Gh8nydZF2G399S41TEW59OvkEKXw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nsysd/Vi0Tj3uAU61pLVaQLzAgfb80ugLLFl4Fy6vY6/gK55Lc
 1fsA4juH0JqEQD7YdsjTQmcNySXp+RaG9432T8UpgEfpd40cjZCVDsb8tFA5JZrGKkARny2I7hx
 2Kb+xxgPeTY2deS0=
X-Gm-Gg: AYBFou1uxv5y5+7dD+GHuKIl838q8V/OhZGipM0G8Ztc0MSHsdH+3uCvwUatqcYfDDj
 ucfuITzWzynl05oo06PAvL6TkR3b70p7mNdRxg6nobHYjfumEQjOVD9NMUyNzqwsdOkd5YZEv5K
 Xlqxv7Vqrp9zHLIMn6G+vCi+NcFEk1LmDJ3NZs+7qYb88nIvECa+Z0d6xiGIw8Uw0zoCcIltX7t
 eSufnFPVDq4kw1G9jgtjaLnF/8YwCg/gz67fp3Sz+jpBYGdBp/Zn+gZ6yNzb25cpQgzolddHewd
 Hus4xB7BE6Uk2UFzQhtvnuwRfDobYIZDdHofIHlfaCZh1VSwG4BNUEoahHn1nsIDnw2Ogwqb9lZ
 QuNxblknnyrkNew0+vdiVGYbfZcLcayomyNcp2DRiE6ZJjVVBJUBGnRqNpKf5piJr24I0+yvCTV
 E5IQC08zlPLv3RjI8jS6vGaryMsLCPxs/6RAxS6PAR2CvtKgXscn8wN6WtBdomWBxh9j1F9/V0B
 rp+W2u7v5JAOF3Q13e9Pl2u3opEssh5HQ8XQXVB3dBynRL54RCkw8hDqOj8Viqmv+w+zAUq4DZV
 ELQDiHwt+kBiyjKScqw=
X-Received: by 2002:a05:6820:1501:b0:6b1:5c8b:c0b9 with SMTP id
 006d021491bc7-6b6fabe21b9mr14862936eaf.3.1788804401440; 
 Mon, 07 Sep 2026 11:06:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6bab80ba74esm4282672eaf.10.2026.09.07.11.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:06:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bryan Brattlof <bb@ti.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <b9abf066-fc53-4cbe-840c-50ded34257f8@gmx.de>
References: <b9abf066-fc53-4cbe-840c-50ded34257f8@gmx.de>
Subject: Re: Pull request efi-2026-10-rc4-2
Message-Id: <178880440056.3942941.2633647816421180226.b4-ty@konsulko.com>
Date: Mon, 07 Sep 2026 12:06:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 7 Sep 2026 16:47:17 +0200, Heinrich Schuchardt wrote:

> The following changes since commit fadc33895ef545db84aad169ab83a3899f52239f:
> 
>    binman: gbb: update link (2026-08-29 06:41:36 +0200)
> 
> are available in the Git repository at:
> 
>    https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-10-rc4-2
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


