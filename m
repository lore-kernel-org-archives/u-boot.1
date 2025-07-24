Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5254C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 16:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59F0838EF;
	Thu, 24 Jul 2025 18:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca header.b="bjN6dUS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F3D838DF; Thu, 24 Jul 2025 18:26:22 +0200 (CEST)
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca
 [132.204.25.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35631838C7
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monnier@iro.umontreal.ca
Received: from pmg2.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 6229C8001E;
 Thu, 24 Jul 2025 12:26:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
 s=mail; t=1753374376;
 bh=l5aTgZEO6divQRqopEfYTFJyM+wzolWqSA+sDuhjOS8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bjN6dUS6lVdxZzZVqk/27Qn/gMsnCiYxYUObJW70TsJ3YMpjiqaSJfoJSDjC8+v1n
 G6Mi3Ym23EQZ9IWaqJX3Iu3klJHnuraX7Zi90HVHLpqevVtOR48PeubnVh2XC2n9OE
 CW7QedzmVcxhMmSqSllwBHNme85Pq8A53JIz4Qc55u+iwTT4lBU2kBjF62kpfZbvmF
 gRw8Zwr0GLnrArTTgbHWlm73GxBUfnYwE8L4U/A6v9V5kpRmOxW4BWoKxFGMkwiKgP
 DNgcvGukX4eTzADONwEBJI9YWtvONSxNXBTpmPNxYkgaBzj8rd/Y+UGom1xPc0KE4l
 e+EQJNmb9LzpQ==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 8633580387;
 Thu, 24 Jul 2025 12:26:16 -0400 (EDT)
Received: from pastel (unknown [104.247.225.139])
 by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 6077B1204BC;
 Thu, 24 Jul 2025 12:26:16 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: HDMI support for rockchip SBC
In-Reply-To: <CALeDE9NDru0WLy14gFRAnk=O+hVUS7D-b1Qg3Su+96FQQ8EVBA@mail.gmail.com>
Message-ID: <jwvpldpsgva.fsf-monnier+Inbox@gnu.org>
References: <jwv8qkea94d.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <CALeDE9NDru0WLy14gFRAnk=O+hVUS7D-b1Qg3Su+96FQQ8EVBA@mail.gmail.com>
Date: Thu, 24 Jul 2025 12:26:15 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 24 Jul 2025 18:33:57 +0200
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

> Support for the rk35xx isn't upstream yet,

Ah... I didn't notice any weird failure or warnings during the build so
I naively assumed it was working.

> this patch series is likely a good start:
> https://lists.denx.de/pipermail/u-boot/2025-June/591737.html

Thanks.

Is there a place that tracks the state of feature-support, like

    https://linux-sunxi.org/Mainline_U-Boot

?


        Stefan

