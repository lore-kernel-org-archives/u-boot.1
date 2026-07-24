Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7929C531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDFE060B15;
	Fri, 24 Jul 2026 01:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8FRb5kb_Vvk; Fri, 24 Jul 2026 01:02:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FA8C60AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854928;
	bh=CXS/NxQqlHucy7MGb6IAP3RMLH4Ec0XB1pjJWsD1Om0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WzK1i9vm828zRHBEzVxq17tMk1/nYUywlo/g1W1h0yyDKq9IDRUp2o/ZwJWvI3g7m
	 OzyaXu76CLkzXj2JB36lOtEIqyLB/0NsgerQLCEl5H3o4AXkHZ7lkh9VxVOmT1fNYv
	 XY2grWCsyrMNJ4z+0mIhsTCaGzoNtU0H9kydHqIWGyopZcGSciwvPpERM0CfeIeF6J
	 Ju+Ohgsp1QcF6ksgMSk5xSTpGNJcYg582iuJasgT5O/+OZ9x6QxUlF84pqck0DXoqA
	 /hdUAVAwlsX3W/p+uzqfZn/vx49uVC/F0u510r22CwEhTIiVwzHwZi2KDAbV/a1aJz
	 vEu92vwboVCBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FA8C60AF5;
	Fri, 24 Jul 2026 01:02:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E4C2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7977181166
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0g2N5TS1Ib1A for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7EB4680F89
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EB4680F89
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EB4680F89
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00521848BA; Fri, 24 Jul 2026 03:02:02 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8004803F6
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:00 +0200 (CEST)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-448b89f700fso1095275fac.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854919; x=1785459719;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CXS/NxQqlHucy7MGb6IAP3RMLH4Ec0XB1pjJWsD1Om0=;
 b=ExNIeLz3C0fYLJhUkEtZitA+HrZV9+uxH3qM5OWtRRlSKx/FbTvJkP7FVansdnbdN6
 UkuFKP+ujmxY3M11hqOWl9crVx/NtHHsLN8J5TBUlQeN8Q6ak3ykNs/Zt56Qhu4EUeQO
 Dyrsw4nfnGl2n4pCgyjesObYJBOKe6KKvto7LMbS/ClnOWOkcxiD/RCQlGJMnS7bePde
 t9kwrDoG1ugXjVfs96c5yVyPMgfNdszgtZUtL/jgi5OkhQzQtY+QZTTqvYI9IHbqzOTa
 DFSoaiGhTmNnSycMyBWO878A/DLQpPGgG4YYtWEvaeMYGM9XZPT6u/3I7jxQq36mxnne
 GYhg==
X-Gm-Message-State: AOJu0Yznj9TERBs7BBBt2vdeMFmx3J73wLXFrVtxei3ypVwwICyXyi1I
 1iVIWd8YmY+yPcl/a8c9QoB44Q8kaj3Y+oXliE23x6G6wBOVXGvFwa8S/xCjnHLvjgM=
X-Gm-Gg: AR+sD10S2I9YEEKx78CL3lujW38EOxfvlKkc6J0pQCYbYDjzAjR+SUxoR1SMoDvp5Et
 tAiZXTcqLGkpzwgShdwKUlosEXIiULv/yJvsvJPHQAfFukTnn/xQyHsTSv1xldRcG8vDsUuCfJM
 EOlNXgyud8b68LiFd8GBbmWKsT1qIlwibQmuFzD9cxsb3d/1gazhjRphle/KMsav6LhTaHbK6a3
 eIU6l60km4XUxFnvbl193XnFwb/G2uekHuJjw10Qs9fbL676z/O+X9BsriAddNenefPdBb77j7v
 Kv4Yi0xFw6mouIpFzvh9cnfH/5L0a+gYIdYhNFQmr+EsBa/BYjtxPhTl4SidKumoe96BsubUsEM
 INuc1s2v7CmdtoZjXZDhyNjETZGzXJVnu6Rq7Qb6ZiSBABOdFVaZx+5wvN/yhTccRl6a7KdEW1J
 gacY65O8MEjr+/GmW2CISWBj1m6s3Uoz/VyS9O/dHVhyYoZdO0UBkYd+1ZM+U2LGV+Lt4y0x9kQ
 3GZcfE+Qbsz2GB+DB37eWDT/3crUXd/xxjx
X-Received: by 2002:a05:6808:f0f:b0:495:f85b:38c0 with SMTP id
 5614622812f47-4ab35327fdamr2858288b6e.12.1784854919307; 
 Thu, 23 Jul 2026 18:01:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:01:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20260711133903.106411-1-marex@nabladev.com>
References: <20260711133903.106411-1-marex@nabladev.com>
Subject: Re: [PATCH] cmd: date: Handle -ENOSYS return from dm_rtc_reset()
Message-Id: <178485491812.3246206.7547071294394490557.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:01:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854919; x=1785459719; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CXS/NxQqlHucy7MGb6IAP3RMLH4Ec0XB1pjJWsD1Om0=;
 b=kfKz+JnQgtaDZFmz0fm5Xiz5LjvFhyyukHNPJbBu+39cDNB5ko/Pa1zrEJljiBig5e
 JdLRUgPCU7YVbL0zR2IG5ZDJEL096crQLukifv7ksGLvnwH4zqtXhMrvwk16JuRrF2HX
 hjG8D1ldErDXb9VILGYnroGQt6JhTcy9BaGDE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kfKz+JnQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kfKz+JnQ";
 dkim-atps=neutral
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

On Sat, 11 Jul 2026 15:38:37 +0200, Marek Vasut wrote:

> In case dm_rtc_reset() returns -ENOSYS, it means the .reset callback
> in RTC driver is not implemented, likely because the callback is not
> needed. Handle the -ENOSYS return code as success and proceed, else
> the 'date reset' invocation incorrectly prints a bogus warning:
> "## Failed to set date after RTC reset".
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: date: Handle -ENOSYS return from dm_rtc_reset()
      commit: bc61758cbce38921310f668854bb8047f06c8c01
-- 
Tom


