Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5AFC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 16:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC6E16061F;
	Mon,  3 Aug 2026 16:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCM4H2DdqG_t; Mon,  3 Aug 2026 16:26:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE3326060B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785774368;
	bh=gitOSxo6huvMVzGXJGKiAmVADcX9qwQnorQUdFp9qME=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EnzTKXopiG9neOaO2uQZ9B4tHV1gReGEjQ32VK8TKS0g5JUI/jazzsppdNvaGHhuI
	 mNYfDuFonjJafTG4z5tB05OFWEZjyjUgL/TXaoKOoZQslc0qbgP/9QMU4xvxWv42If
	 lMU3cNqRw2oBTnCMI5opk4LDpo7r3snTrmom2qyh9UpGPAc/Wq5sq4CaEcTtGeleqJ
	 9OrybUCTEYhMOR0ddNyAo+Fx9YAR/jrunUmENsCAQ6uYDB2FF43x7l9Vo6iOfNczx1
	 Scusp7OQ7vOhtxQa7PtLFxsk9n+tsXj7hHFwhpUtJG+hvu4LBk7HKdB+OPEUiPXf9Z
	 rAIxUdtSYcvXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE3326060B;
	Mon,  3 Aug 2026 16:26:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F33E8218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4E25605D6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6oZq9r6kf9ST for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 16:26:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C3782605D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3782605D4
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3782605D4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hDMVg1P2XzKnDK;
 Mon, 03 Aug 2026 18:26:03 +0200 (CEST)
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, u-boot@lists.u-boot-project.org
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] cyclic: get rid of cyclic_get_list() helper
Date: Mon,  3 Aug 2026 18:25:56 +0200
Message-ID: <20260803162559.3212020-1-stefan.roese@mailbox.org>
In-Reply-To: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
References: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a1ebd08c34c95d2fa38
X-MBO-RS-META: 4dkipn1i48t9pcuz6xmmspuydmz3ecc5
X-Rspamd-Queue-Id: 4hDMVg1P2XzKnDK
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785774363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gitOSxo6huvMVzGXJGKiAmVADcX9qwQnorQUdFp9qME=;
 b=E3Pa2AzhdDWgH8WbzrKXh+MPYqs3W7wEFiAS9gY9SoBKivxZd2+TFt5uShWE6jFoir506s
 f9M1+pHrgT/FPzgRELaWesj7bOhQCNyQ+rmDPf7/L1DMEK9bnuSNPgym3ZTziEkEw9nse7
 8Zwxpvkna8Br1AyA/KOJzBsRO4qt+iIULWwderIq0yENxu9/SwO1KCehQ+Q1lXotAzs08l
 X2TbpoWERNZq+go2GHoqp9UhMpZBgRzugkaohRtNGxEhK9xJoNZ5IhDVW698p0z7awwLfK
 n5RryKlFMNvO3oyx5sg/wEVZJeKyX18MksaFG7pDj7bkdeTQdNIF4z0cGQ1xOA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785774361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gitOSxo6huvMVzGXJGKiAmVADcX9qwQnorQUdFp9qME=;
 b=mbUzswbO48y4HJL4s38IcZiuSsIV7m/OPFwzH54RpmYIlvLWDEx4M7TLFKo6O5Xg/Kb+g6
 sNGX2LkY9mwZZhoJKwEjV+GXc89tRLvAxoKOUJjkFT6tRA2sQzo75Z3PRX/TDZcnvEhqjC
 hiXSMhJtx9Ml/HuxGMhpvRwzl1i33CsKvWQb1jaDymJ0XPJ8Vtt+QW56rSzjzbK9LpXLK0
 NX581A0Ntj7fn/DqiQaVlKWbUHF3wu4qeMWcfGmXMQrlU9WgflS2d4g3lYEvRbAqHT/6S1
 vDY17oFlSFUxWbXQUkqOyIu4N6pXzLaMTsPYmFjfZpF9QhZzBTG+zN8FRLB4mA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=E3Pa2Azh; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=mbUzswbO
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mbUzswbO;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 12:55, Rasmus Villemoes wrote:

> As the comment indicates, this was used to silence a warning without
> having to add casts everywhere gd->cyclic_list was referenced. But
> nowadays gd is not volatile qualified, so this helper is not needed
> and only obfuscates the code somewhat, because the head of the list
> being operated on with the hlist_ or list_ macros is usually not
> obtained via a function call.
>
> Remove the helper and refer to the list head using the idiomatic
> &gd->cyclic_list.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

Applied to u-boot-watchdog/main

Thanks,
Stefan
