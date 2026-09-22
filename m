Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A57C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B578880DE6;
	Tue, 22 Sep 2026 08:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svxjRwJm_Oeg; Tue, 22 Sep 2026 08:05:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0784680D89
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790064319;
	b=VvuaqjyI7W33exBU8sc8FKHzcxkcl/qfeHpYRQD1SgvK5SrSoQtlBmFVQfu0n/KDM9n7
	 6zrymte+E+Myoi/l7L78HbgKwGj5bnN+TkbOfgR2tReGmCffESGKidjbneaLpwqidG7jv
	 0OxTkk/ZDqY+uVid33ocVmflmLSAXnMDQy0k0ube8Cr4aGhvRyDxco2IS4WGzPLieEP5m
	 HZEivcCQwLRM8InFFsI7cJyrdaVGufT4kzb1E1Y3hOUco51AKZr5vjSUQqzPddszcQaFS
	 yS7/tduSxH6jRAfQpb9Ek5LtLazPXfZCc+lBMvDlmyN8doHATAnNgyMLzzHNxc12uAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790064319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RPZYp1BT//9Qdld1LgCY3zGo09t8H6xCbDgFYIyDOcU=;
	b=kbiodbTfvzZiVjc4+vF47SqFBvjOtQmiyXPP6gbNplhQsESbWRq9Te5TFWk3QF2wQH+G
	 /Vgm2DXBqIrS3oSgXdjgAZENHQoXTyQ/F6iz1wDImbSdfuqx9Aw60iJJEJWJapJaOqc04
	 3v/IRZjVylR8CLcUcsdwGE3vCNa+HBbLAh/UtPrVN641hCaG1Vh9+Bcqazu7ue4wArodj
	 ggt88D4xPd/cGsVVrVyZPJoWdE16cI6rWPBDv6NICKxJm2vFkceTh2RO3V1aeH3i5kxyQ
	 Hj5gdRorPbmLBOkRgtjbNqBrhV/Csu81+vBB4pvRpHtdZV1SZDj0aIbi8Ctp7+fQSSA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790064319;
	bh=RPZYp1BT//9Qdld1LgCY3zGo09t8H6xCbDgFYIyDOcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=myuJL3tbxv6AVKku2cCMOLiRmTMhIxwe5pZNtsyQdl6ADIQEeleIHYspiacJ1c7dq
	 7V+6Q9kl6lgnhOe4+podFz40bZRpdmjsinkQtXtOtihi1/SaUCFlbrxaqSWB8PF3iP
	 kA36pWShFbeUO+TCzFY+L0zOJdqTA+If5suEO0qmHbVso+pr0ZMyJD9p8Pu2IBiL7N
	 vsT4IcuZSAiB+6FGS8EC+QES+4tnLoyb//yuF8HzEWvt6O5OKT4mKbIuRkQFbEhVYs
	 DJ2q35ozMFiGDPZEoBFm2RKcJRkKI0uwNR37l2RwD+AUwjKnOG5JXR+VWKHfh6ewsE
	 74+dUFZxn3QzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0784680D89;
	Tue, 22 Sep 2026 08:05:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E920194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 240414076E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r2HdbQDpbZQ2 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 97A2D40765
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790064314;
 b=QfK+wqkN3IN8Nlk6/6qeE4rgKOk3eCQmKFjHUqGpIrZAM5gd9wf9Pey3sDX2L4oShxZQ
 z9/Clii902cFPncs3Aryv9MphG/qaqA5ug+GclvrmVru1kYbQmMqedeVG6eOfBYYmPOIf
 zNG6QPePhECWAt/fnUWNEhakXVNAbnDBz3YpDegMbr6q600wO7JqrPcUHLHQAtVjEPqfs
 DH+9Kbfgj6G7wnHUSFCUfuHudygDbMaZMlXcRwu/hdt+uN564yrnlmpXlDV4s0095zkpm
 ioGk9AVATjbJN/k3TpOYCuLppXMM2YyOE1sVFX8Mv6QmvvQfnYDu2Zq1KdEdX8ZeqiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790064314;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=RPZYp1BT//9Qdld1LgCY3zGo09t8H6xCbDgFYIyDOcU=;
 b=duw3GdycVBx/eD7jbzI3D9QTjbzoEeLoEV3RvEitbUYoKam5I5dpPPordLqoPYnlZcBK
 FSp/RsisIUKAfeIfkbdVWmmL03WyuDsMsA6CCNCHkRAnntLTeeS/PD4WYtY+abzO4vquq
 bE22YWwTiGhGSxV8sNN3S8fh9ugBYaX/0praX1YNbBSY/XKnQyPwBNDmxS/Q/FqEkUUcl
 TyqI93zgXtcPGBTmS3+O3560EDBVj1kSD9ZHdaA+wy2X251G5OYXShaL/nzjG3KwMr4ch
 Xkye3ur+okLVyG4llYA5YTkEU3QGLpZIS0zpvffDG40s5PhXlC1qqvfHM+/kluP8MJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=govqlfxm; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=govqlfxm
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97A2D40765
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:05:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29E60434BF;
 Tue, 22 Sep 2026 08:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6071F000FF;
 Tue, 22 Sep 2026 08:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790064313;
 bh=RPZYp1BT//9Qdld1LgCY3zGo09t8H6xCbDgFYIyDOcU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=govqlfxm7UdT4Jha1nzRhfG8us5sJdB3aS+iDzHPSFAAFCNOD6auHUn6mrpvpsMQH
 G2oOyUNXIC3HZ21FMBGygQGjE0Nylcwmm/r0vjQBIVed6sNxKU4nhTYaKBA13CZhip
 x1sc2QleYL3HsTXsmurVzfskPYEZcW9kaGsUKrVx8giYxVGhI1Ko3fYCIn4CGZdC+U
 LXSlVTzkzYcW1BzS3pY3HxVZIVmy/AWalzi8IvQVGM6+Z34Qa6YI1XyhPTdOJ+Ymnp
 UBbrsMOUzkXkr6/+b7NsDYXDmZnN/TFb0RRSlSk0WFG2tcJafaqeXM7KTG5oyYdvZH
 oO0ciJmd8LqaA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Shuqiao Zhang via B4 Relay
 <devnull+stevenjoezhang.gmail.com@kernel.org>, Simon Glass
 <sjg@chromium.org>, Eddie Cai <eddie.cai.linux@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, Shuqiao
 Zhang <stevenjoezhang@gmail.com>
Subject: Re: [PATCH] usb: gadget: rockusb: terminate full-speed descriptors
In-Reply-To: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
References: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
Date: Tue, 22 Sep 2026 10:05:10 +0200
Message-ID: <xhkdbecelsocp.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Shuqiao,

Thank you for the patch.

On Fri, Sep 18, 2026 at 18:11, Shuqiao Zhang via B4 Relay <devnull+stevenjoezhang.gmail.com@kernel.org> wrote:

> From: Shuqiao Zhang <stevenjoezhang@gmail.com>
>
> usb_descriptor_fillbuf() expects descriptor arrays to end with NULL.
> The high-speed RockUSB array does, but the full-speed array does not.
> Full-speed enumeration therefore reads beyond the array and treats
> adjacent data as another descriptor pointer.
>
> On a Luckfox Lyra Ultra (RK3506B), the adjacent interface descriptor
> started with bytes 09 04 00 00. They were interpreted as pointer
> 0x00000409, causing a data abort in usb_descriptor_fillbuf().
>
> Add the missing NULL terminator, matching the high-speed descriptor
> array. After this change, RockUSB enumerates at full speed and
> upgrade_tool can successfully read the eMMC.
>
> Fixes: bf2b72bef14b ("usb: rockchip: add the rockusb gadget")
> Signed-off-by: Shuqiao Zhang <stevenjoezhang@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

