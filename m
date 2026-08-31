Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C6C624A5
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 08:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B701B60608;
	Mon, 31 Aug 2026 08:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfAIE4qepy5l; Mon, 31 Aug 2026 08:08:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788163685;
	bh=VYHDyIi0WWCCDTMgI/Ecd5mpkcGVFJSwtkEFogPDHzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQIwywbqSPOC51g9HrEq2v91NcZCOclQRbNDRyoToTieHwD+5/xrTULCfiLSG29oc
	 enakMm/lvAI/8eFDZtZyRbpueoeauzmNs/lcsrCHOmj9bnc8L/QEwuF5rN/aQnBK4J
	 ba9rLmItMrynJ+EojoPugotM/gxExuDUeTd7wGxa7efwpSTNMNZghmgWVn3UXx/ofY
	 m+tyq6rJSkDv8S7WilerWgMwSEf7ELnu2wbTC3kO6V3p9X8dPnt17UH4VIgC1zvgvX
	 QQbSF3MwqP3gKrs7NdRksFAhdLrBwPwtG9RJ8s6bRb12pESxKJGJbgGedsNhB5dXa8
	 LiXk2hFGz20Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E615605D3;
	Mon, 31 Aug 2026 08:08:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FF44127
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31BF840056
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SunlooLXfqMl for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 08:08:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=f39Ex6Jx
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3AA440051
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VYHDyIi0WWCCDTMgI/Ecd5mpkcGVFJSwtkEFogPDHzE=; b=f39Ex6Jxt4WHOQtpm5Jh9rbUr1
 uZVqBsSMh9AysSHUhCW+oxRJlXaLSzik0VwzmuaB1B/M65lG0X0BHXhpUbRFypxMC02UOQrLNsfLc
 DIP7dcRXU+Rlcx/fHxAG2jMTJFkWKSGxh092UoMkTyCbNbkuDLAUctMcYjE00qK9w10DO9W8lqhK4
 iMySqeABj2V9EurWTfqi1QRPvRaZN15SLqWrpOGedKG4weV7uzxWG00VoZ6sd5sZIkYUBA0f/tUwa
 0wM1Zj/a/s2abbEoqSXJkXFYZH0ABs6U5dAUu7EHnaX5Bkmm0OK0Elq4r8MRBWZmWNDOrROQC0H3f
 WFhZQ8QA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1x0x3e-000M5U-0I; Mon, 31 Aug 2026 10:07:58 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1x0x3d-00052L-2V; Mon, 31 Aug 2026 10:07:57 +0200
Message-ID: <9a2cc614-73eb-45c1-9186-11f9b0566605@ew.tq-group.com>
Date: Mon, 31 Aug 2026 10:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/env.h: use plain old #ifdef
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.u-boot-project.org
Cc: Jacky Cao <Jacky.Cao@sony.com>, Tom Rini <trini@konsulko.com>,
 "nora.schiffer@ew.tq-group.com" <nora.schiffer@ew.tq-group.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
References: <20260828150600.918158-1-ravi@prevas.dk>
Content-Language: en-US, de-DE
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20260828150600.918158-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28109/Mon Aug 31 08:24:07 2026)
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

On 8/28/26 17:06, Rasmus Villemoes wrote:
> Commit 9f1807e57cb ("env: add env_set_runtime() helper") broke the use
> of "make envtools" to create the target fw_setenv/fw_printenv
> binaries. The problem is that the #include <config.h>, in addition to
> pulling in linux/kconfig.h to get the IS_ENABLED() helper, also ends
> up pulling in lots of architecture/board specific headers.
>
> Fix it by simply using an #ifdef.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---

Reviewed-by: Max Merchel <Max.Merchel@ew.tq-group.com>

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

