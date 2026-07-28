Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18260C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDE488144E;
	Tue, 28 Jul 2026 21:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s181jN2A6eHh; Tue, 28 Jul 2026 21:57:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18D908146A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275829;
	bh=MiOtgqOgqhj/Q/Lcm4ol8oEazG7rgQLQR0jgyfynUhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t6cEZcqz0fNDn0XhhZPldc3xqWnwrIls+1MqGqvJWd6cb0iT0bZCGUlrMB9xhq61T
	 wWuhi470u3tKntXlFY16+HOfzUcWBNlkYH53P65Fm5wICSI3KMXvk2y/p3bjpIs0Vi
	 OscX824WxjO54N5jFD0RXQlopklgXUSw+wT9hEkPn/m+M2AD56G65NLgTqRl/1pLVo
	 2orWReUpufiaPiW5zvzAbVaAU1A+jj6hXrdx+uGiTZyiTMr/gA4e4aoIXfd+CbeqGT
	 jI+4afZYwpX2A9/YPbJP5aumEUfRXPGpBouyReG1FSgWgPTqT2XDjQf3NZ+tv23zAF
	 90EC430WJQRbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18D908146A;
	Tue, 28 Jul 2026 21:57:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C213350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E301408BC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x_HXOL_Szzzg for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5EBAE408AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5EBAE408AF
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EBAE408AF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ee4399c3abso303613a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275809; x=1785880609;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MiOtgqOgqhj/Q/Lcm4ol8oEazG7rgQLQR0jgyfynUhs=;
 b=SHgRrjg2vBSxZidXUxIrffOeiQL0WmXsRIQ8Z2u3VOcrXU6xt00HXKzF8uVvytlbYY
 ijPa8ALPbO2/h2DE/oJgvmszq754B+IK1oD9wzUcIMbedDYAlIoXbwg5GrIN9pF15izf
 fCIJjd9hxM0SsGyCOLE5HO9A0IasD9CaDwKgDtObPS40j2gqTPXo91IwQQPoCLqw71Ax
 y9Nxiud69/7YfgJzlUk2OnR8V/CfcX2nhGvKXlx1lVoiIZzcNInDN02j8Z4daCIDreMP
 WLodLx1ryVRSHgTYjwRIwcnEf31/CIP1cnrvTd3Cw05CIrZ7zyJxaOw0tgvB9eBMVRyZ
 yWSQ==
X-Gm-Message-State: AOJu0Ywypgk4dtJBOQVufWmZMbN7Bv3Do0xE77ZEbpIq9VUdmzqYHfJZ
 fSPXcp/ppduwgnOsRNhCMqTypYU+B4/WVAwzmVIfxhMUKDExx0A5wW4BlWukjRHFpWI=
X-Gm-Gg: AR+sD1110NDFPkqpCCMfBW/ktZS9wCfOpPlKxgivH6Y5HMvR1P55uuf+k7BHF2qsMgI
 6438Hbqiq4OIQJBMOiI3XV4i8oEFomfw5FPTO2gvd32q7p/vmI1qYB6Sw9M5iuq6Z0jn5u5MYP1
 UFZTNKgj4cRLK3QwPGbTJ8eVdvttegwH53bYturrlBLOO9z4120YqMjEmwgGyB2esEDEhK1AENl
 OuIH8uGeQMJPShsJ0SM6osVnwFfy3ojpr7wsYDyy0kiG5d70lE0hwE4S0ytSFRkxWDdNkB9PT6W
 jZQq3WL7E4z5JfE60afjCYVvkupcMbmdI+sHaClpCdA+zVBy6B8ZokbeEq/kJwX84zCxKQch7N+
 z/8myAzTftZYjog8ACz+SIfMVXdChuu4o/6omHk3tRvgIIT52hH0d/PSKy+oJB9wnSvJrKCX7i+
 MJFsvj3LprL8muS0gjwIIm80Y6RntyW1AbfUnt1fLjHuTPiMS6a5ZKxcsA/7KSGgvJICfL2LR6u
 QSAnrZLQgkTfRBIwdhnJYwxga0wa7DuQCyXdwkibpDRfva/977xTY+9raLN00w4LLk4moxCJOH6
 d05BcsLY
X-Received: by 2002:a05:6830:2653:b0:7e9:f8e8:d905 with SMTP id
 46e09a7af769-7efff08c630mr2617300a34.16.1785275809243; 
 Tue, 28 Jul 2026 14:56:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260716080553.2664147-1-c-vankar@ti.com>
References: <20260716080553.2664147-1-c-vankar@ti.com>
Subject: Re: [PATCH v3 0/4] Enable Ethernet boot on SK-AM62A-LP
Message-Id: <178527580841.1742553.7944517445850799275.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275809; x=1785880609;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MiOtgqOgqhj/Q/Lcm4ol8oEazG7rgQLQR0jgyfynUhs=;
 b=ZxpuU+Up+NSLd8N0NJb4Tb3IGvFHwTFebu36kQZmELswu8UkQt2gDWmr7YS/TYxV1A
 e3cCVuWixhIJzpidgt3zD+4IjWFCYKswI8SgGdkwYoRps4E5sn3uurrGs4yfvxaoPzHD
 VSyLy11rvz4OXKdxVrSP+f/QuDD1EeQ5kAEp8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZxpuU+Up
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 16 Jul 2026 13:35:49 +0530, Chintan Vankar wrote:

> This series enables Ethernet boot on SK-AM62A-LP. The series is based on
> commit 'a18265f1ccb7' of origin/next branch of U-Boot repo.
> 
> Link to v2:
> https://lore.kernel.org/all/20260710102229.2980029-1-c-vankar@ti.com/
> 
> Logs:
> https://gist.github.com/chintan013/99c20c1c0773a48cc52a86d3eb86a98a
> 
> [...]

Applied to u-boot/main, thanks!

[1/4] configs: am62ax_evm_r5_ethboot: Enable config options required for Ethernet boot
      commit: 5aec4a2c9099888d5e9334a51bc60cce7eb52b94
[2/4] configs: am62ax_evm_a53_ethboot: Enable config options required to enable Ethernet boot
      commit: 707a9b537b2a0d30e6523be9c926796674773a65
[3/4] arm: dts: k3-am62a7-sk-u-boot: Enable DM services for main_pktdma
      commit: 3e3dfa33507a2e2ce64e679d6cbb09b59f0cbf53
[4/4] doc: board: ti: am62ax_sk: Add document for Ethernet boot on AM62x SoC.
      commit: 179a5619aaf48d127a8b706981ce381e50eea924
-- 
Tom


