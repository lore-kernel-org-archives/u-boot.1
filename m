Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530AECA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C702406CD;
	Mon,  5 Oct 2026 11:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F829OsWFwVlG; Mon,  5 Oct 2026 11:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E8AA406BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791199243;
	b=BErwQT1k9LJ2yRb6khDB6V/CEyOSXc7OtS+RzJQOrehIT6z7nTyHOsGdAoEfApRmccyY
	 TG5uk6ccPzmU5f63VB16oWrIBJnK9n5HpbnPqX9alIhf15wuESCki1r5m/eu8wY3gVaKv
	 mfh0m59FL0PEth0glayPDdQl1pkCAntPcrQDtnEprYxepdPFfrUCZSIMeuyAcNSa/kjMr
	 KfxMSGUTcxHfXnXz8wSvYSYyMPTOnle/ZcUl1h/I6vODn6EVorBVxTBm0j9uKy4hNYKo2
	 K7Du7ZRP8V0wbjcS66vKBU6s/pKctJ1Q/JZBzeDHvlqIaWRsOzogKpJiOpuDhDBA4dA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791199243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kO8DiHweZiiBFyhmqmLhl8EyUnJzw5GPbYDn+wLp9YU=;
	b=InsR0MzdvKvser7Po3A+YNNR3AP1Arcm2tksLOWy+8w/fZta5//vMivJeVAl/MwpJQmD
	 tFNZi/v5ZeT2KSOAb/EW/yLi828xpmYwWWGoY9RT8U9bdSonQDW2JxY5fBMoqzwD67U7R
	 Rl0NzR7KgWLOF4pdNsFEa3iQdijI4yw8wR4kx27blCCjtXook+Iv2X99vmfMMmZ1JutIL
	 9pCZeLlQDwtxaLvrFK1PyXWh94EAILkpU7v9HJqAGqXMzrb1IZzYjZ98fkUUi3MItvN/l
	 4i0GbsWs+XwGXuuidERm2UIIt0pV0tWLPdlL+7mmvROb5LM1ynXs7M4FVtortaAq8DA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Z74cN1Eh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791199243;
	bh=kO8DiHweZiiBFyhmqmLhl8EyUnJzw5GPbYDn+wLp9YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3f27+Gb/+DBtutsn9wve3En7vMGo+9AQ90cT4KKFujQMJ5wgnKCOKUdE20tAd/6S
	 0DMSUNT1debmwUZKuBfIrAKSbYWqkBIYhmoi+x4JJCkG9Dru/02IIsNB+kgJ2tL1oM
	 tlHoP+WNYIu/71luOjuBDj99/mryKgVki58+fk4sOWk/LXH9VM2SCfJC2UBDGf55Op
	 vRV2XL/rgqmLk9ghbDAVeUq6enmhyQBMeX8wENySNIMNPcJe1kCxPuvBGqGKgKRQ5P
	 jhZ1mDeTtNRevc1otLauV10EJxlbBU91DVk+6GVETnXGykb50u92ZV5CGwD3h8Xaic
	 IvUbll0/AZNGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E8AA406BC;
	Mon,  5 Oct 2026 11:20:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ACEF82E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E825405AB
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pCHJqzuzdGS for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9318A40589
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791198810;
 b=Ueut8RkB67lbNaug6R1VMt1tJlSKdG3FWkTNDYsNZ/ppHv44Lrdxtswsf7aeSRQbrvCz
 gnKnl+p+MdSXGCYz+FEwV40lERlnR9KV7+ZYn938UNILL8IdeHtNFl7XAKOBXX8a11wcG
 P7uBijgCL/opSJOp99qF2WX0t8c7eLbBal7GtWcvQHw5EgjyFsoqUXicfuHcV89rXafVu
 Nt7JjNZJeC8PDVDELuDmyDxYT7ogRP+kS0iLdGTGMj1AAvYSACsREINO4lLA7tw2zIPVK
 H3YunhpvQWIE2cIkWk5HD2d4xiFMiC3RciKQ3rIwWwUclUzMwmtZltumZlFaAVMRbMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198810;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=kO8DiHweZiiBFyhmqmLhl8EyUnJzw5GPbYDn+wLp9YU=;
 b=PYqsEvo8qLKJgWkhhSxZGYgAuTH96y9o+Hud50UC3Hnsg2oCq75AvU5avQ+1TxIfNE13
 jfGQlphNMI+S49rHJiPMzBnWEjYW7auqwiC9a1cSowsQY3xdsMra+u5en7vaZ3bzT1eoz
 4dJExZpI4QIvQNnaKNGuLeYJ8kqDtp+jKes2GLspxapyXLnClul4ft4uw9l3N6ViM58kN
 ir3utHuutfRv1ASnhnylegxnoDqQfulJYLc5+9hDsLNzNnup73L/WsUDsqmFdeHZy97p+
 o542Bsh5giLcDPWyKnQj04kPFFidlacH/vUIrCcVQAnTv/EUykKxxXjt5MFqpBlmz3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Z74cN1Eh; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Z74cN1Eh
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9318A40589
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:29 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyxZt33xmzMlVR;
 Mon, 05 Oct 2026 13:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791198806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kO8DiHweZiiBFyhmqmLhl8EyUnJzw5GPbYDn+wLp9YU=;
 b=Z74cN1EhAQJr7aii3vbIwfwNKuVX1nTRdbFu8BGkRJEqMPYrWKf6cKgACqkV5dhHfZUkmC
 pjbh8Nbml8EE76b23ZVSf58E49cq7rbyVvjY/7C0iIE1XK/+EZnEfjW8TkGDAxkydn+Kbs
 zEU8jdovY2W045n4599wOXex8pWCa394TOz6ambC23ibb7Lnx/Z214yj4JRXxGjzSk9Jmi
 42+Bzg9ubdpCdOasPS3drxnSjwJlUDBLxvRNkPd0S8Wt47Xoko6DqWagZoU5wFc1dPZFya
 SOEO1he64DGrasoDu+jOHiysmfqHe0MZA++SsRUejKmn7vlzNDOwY+PU6hqghA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3 5/6] watchdog: sandbox_wdt: set max_timeout_ms in probe
Date: Mon,  5 Oct 2026 13:11:56 +0200
Message-ID: <20261005111314.719129-5-stefan.roese@mailbox.org>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-5-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <20260818-rinta-watchdog-gettime-v3-5-423f5caf526d@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qm6znpnicjmtg3k9uo84sji99rx95kzk
X-MBO-RS-ID: 9cea5f8339fa0ec543d
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

On 8/18/26 10:43, Juuso Rinta wrote:

> Add a SANDBOX_WDT_MAX_TIMEOUT_MS define to sandbox asm/state.h
> to emulate a hardware-limited maximum timeout.
>
> Report the maximum timeout value to the wdt uclass by setting
> max_timeout_ms in the per-device uclass-plat data during
> sandbox_wdt_probe().
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
