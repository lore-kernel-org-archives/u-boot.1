Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0EDC88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 16:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A281480C47;
	Mon, 14 Sep 2026 16:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnBTQ8XOtmkV; Mon, 14 Sep 2026 16:19:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 953D080DE1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789402758;
	b=hOt1/fEMmjaMWVfUzsfydks8pxaEJYjr2Yt7DbdSW43lbOJttwG+1C/RZPpmwf5q1o81
	 D7qL0Xio+7boeLRW94hp9UDpKzQBCFau4mbaTvsoxit7ka2LvgFzld8MvfhqRnHg0zycq
	 aA3a1C68dn/nn332Nt1YDRG10d1SYk50dUBUu8rfcOUpV42CitahYWrJFKSoad9gQDJO0
	 WWPwhZ4g06goCHQTsF/TZoMrO+s8fETSUgJ247UpI3NK34AsF3hPDILQ+/6L8nWRlfe9o
	 Qn6FX1IHraXJaLubrCjLPlNWFwBGr0kqRn9a6ueYc51ho/L2gM465j8keBKLozUqAKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789402758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PAJgYfb4/REk/TguOxq7aq7bWzoqfcId/5iE/VW+a84=;
	b=Cj65vwuzhJcSRdXoD64kC/1YU4lI0mzXuuGx5ze28n7i5sv1u7knEWMlraO1HGM1dOt8
	 P/QdgF4+kY06OtHw9npkesP5VEp8K80Lv+qVcSMnYXXkDCsBO6q8Tm6LgwPuEFZAlVNRb
	 qMAWyRcTF7m6agKC5YfBrhNPd/3FksQkH9hC70Kz3c0qSF5ybhYsGed+yisqn6tOmyi9E
	 ftWzdFvKnB5+T25M8hZxT+aO3kdI7mBlgkxQqIWNGlD2Vgj5oMqiyt8qVt6bmv288UYBW
	 vcsNlBpKk4yHFXcmxENbzpixPETiokh//A7MaJSK2izCJBbrKRhVtYFJNi+4+fJwfCg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789402758;
	bh=PAJgYfb4/REk/TguOxq7aq7bWzoqfcId/5iE/VW+a84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMVsmE8qCHyUBqPCGs7A3YlblbIE3gJuHO3nuTpOYFG8IpTo0TRXiTW67LhoeXeWb
	 d+Ww+dwx0GsN9GyARKdeb2qXvxrYqHZtpc7BclRd9s42TnCdW5/VHiTObZMSXzmh1y
	 q6aI7I089Fjiduh658V+oHN0GBZVmkXK1lhEd8FVcmcyr13rAf3AuQkBVJQ8N8dQ3p
	 okiD6QeK33ReplH0wguW7lwSKYWbRxOiIIAUd3MxXmvxAX7DMHVAmXE0X72+ssZkCR
	 An9J+lEUi0zTAIvy3Mw+q5fO/8l4HWvhngz+pt9308ad1DjsgWu26mx5y1VjwiZePL
	 5+O5TVS70nu1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 953D080DE1;
	Mon, 14 Sep 2026 16:19:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BE52493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D39360708
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vB2pcgYRCxgn for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 16:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AF63E60689
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789402753;
 b=Tm2wUMLj4ZrGvH/17kslWXy44Vt6btzHTdzoSASl9qjopfU8H1oCEJc89/bUpU02Ga6V
 DhKwHYeLdctNI8DRqCsuK0pDuz47KgTSVSw9GvQ1UkGNI9Jnt7NyEc/xOoviQN5GV3ajp
 gX1W87YlP9U8on7i7nZYHOwMspG/lqR7I4cwUkLEK+xFL0kgNZpMeEQxuZJElh57Vg3hD
 ibHuLrZaTXxAaO7arymfZjkfhfOhCPboZJFQ/GbKS11i5BSLYq0Iqexiyhy/yLyxvGB4O
 99ppKm1zwMGse4u+Bmp20z0LORxKaPYiVH/kLGoii9cb5sfbDHJIyPDS2BzirENESng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789402753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=PAJgYfb4/REk/TguOxq7aq7bWzoqfcId/5iE/VW+a84=;
 b=WLkI8uDZgrC2O04m7ylDKzJ5d05vUJ3SJEHoBHfb7AH50h4GdDKZMO3VzYOGI1JFu+KY
 WcBOxQ6bUs1Rh9+OyWDW/PSOGs+iARkZkYe7JZGxfrjnvq7fA0v3Ww8kulpsNOyQ9fycM
 2k749Ri96eYm433RFl7okx/ZJ6Dv5WwoFeyrsghs6AjuiWKd9eklKNp9BOc2RQRmlnUHD
 uqayD9wSUXM3MtbOy+0C97TRCuXgJCH669GK6Cmc9GPiD4sqCnWv1PAuEtl0lOUfUAvlD
 T3lcgiAhyUjNgu6xYiSu+dbD0Ur+9mjKwlGtuZsA1tZ28QpWIeSrdOcqbTjKJVThUjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y31fURHA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y31fURHA
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF63E60689
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:19:12 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6bc475ffcf6so1040159eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789402751; x=1790007551;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PAJgYfb4/REk/TguOxq7aq7bWzoqfcId/5iE/VW+a84=;
 b=Y31fURHAyfPl4E+90jf8s6ZWan6GrU6h8QlJPXoQlkGucVSWdlxYKbaYVymruleO8X
 RswySbnq6JdebC8fqDL7k4HtOUfKY2MpHtiy5g2tfwSEU/gfEVc0y1l5+onIEN+flwdY
 sbSxfneNB0EkahcmiZZP2e+kHdoBzpO8O68WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789402751; x=1790007551;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PAJgYfb4/REk/TguOxq7aq7bWzoqfcId/5iE/VW+a84=;
 b=Di/su3mLk53XPf2k+uWBXW9k9+dwpd9XrLFU5DZ9gKHj+s29UDnVSkSZNvkCmFCf0j
 ULugOHR+hIFZv5Zbi26ppPVVBkBsdDk3wR5f0IYqNcTudl8JRMlNimUI3FbxzCtDsOSX
 W0CE07JULv2YgIvNDPYYOjxRKZrdrMsjaSYol0dgB1Tt2MvU3r9bK2BJ7wTc9Vn3B3wl
 XU+Rg3gqwW1Vb7E2xxh8PuuqH7zOqDNROZw0AzXTE1d0cAn4/tHo8f/s+RvaeOGxuvZE
 c4EVtisQx5KrSWCg2uG1o2mlNr8NaYKB9pFamQ8CDTHxEBLeFI4hzw18aKULDo/N1R5/
 V1Aw==
X-Gm-Message-State: AFuF++mtH8eDySVBPOZXcH0UdotUnmFXGWMChtn6OD9ZrN9DA35WBDH+
 c568iwXTIAWjs3EA81QZaSossmnT0TEpdZiVnBuoiXM0Giy10d7f2ehtmy9rPO6+2fYq2HYp9Uy
 MfrgLkMB0QvH7
X-Gm-Gg: AYBFou3qwgtDeIdGBzw5vJMGW03TS0GNlxLTG/oemVjeuiyTDdYjYuntAN5ObJb2vKQ
 7ynxN/nVfAqbHGqhugZFTIbDyZe3uZs1lbcsFyFPtJiEjqXl0jMMN/QpcfAGSGFUZ26eXwZtfKA
 RJr7EqGou3Zf1p4WImQhsTL8AZVL3xFwNX9OwgjbOtr3cVHva+wQZQV+1KJ8Wdq7SbuOl/wIYCb
 +jreB3Lgm0BvsKinqyiMAEAC9ZbZc5Zb65qj56zmugiO33UhaZXs21/zdDvyuzTZthzPRd8CIA5
 /8lEcYjZhAUbV+dZSUIqZpU098oD5I2ZpeHTS4wYE5cFOwpOQOvAY+KgaYibmYd+s1pGWZNn37l
 pjqqe+pnWN+50fiXzm7cnPtw8E0LLaqufQ6n458ncsdAYVxfesXvmxaYTa25XFRApLwYAEdG/sn
 Gj9oOjOoHxiX6nQBfXVTZOl4JZFiRF5mGsRwwyWBc9aHJctdGQcl3VPhQdePiD6dNNcWPpwhYaD
 0v+gugBaQzHP97YkMnzw/JJOqISjKY25QQmoNhv9/DTDpRltZKGOONjbedkgS8uV1XMOZae/LF9
 hZGm9afkq84YY62oQEs=
X-Received: by 2002:a05:6820:16a8:b0:6b1:404f:6eb4 with SMTP id
 006d021491bc7-6c54028393dmr2747131eaf.9.1789402751644; 
 Mon, 14 Sep 2026 09:19:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c0990cc05fsm11047214eaf.3.2026.09.14.09.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:19:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.u-boot-project.org, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 Torsten Rupp <torsten.rupp@8tronix.de>
In-Reply-To: <aqfbJA4BEdYc9B7R@nxa18884-linux-1.ap.freescale.net>
References: <aqfbJA4BEdYc9B7R@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-next-2026-09-14
Message-Id: <178940275095.445362.13182889020282224123.b4-ty@konsulko.com>
Date: Mon, 14 Sep 2026 10:19:10 -0600
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

On Mon, 14 Sep 2026 19:31:48 +0800, Peng Fan wrote:

> Judith Mendez <jm@ti.com>, Minwoo Park <mw.park@telechips.com>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Bcc:
> Subject: [GIT PULL] Please pull mmc-next-2026-09-14
> Reply-To:
> 
> Hi Tom,
> 
> Please pull mmc-next-2026-09-14 for next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


