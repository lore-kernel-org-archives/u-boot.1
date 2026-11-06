Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12A606A32D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pwysjtFH;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=BQF3aA4a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBA6981479;
	Fri,  6 Nov 2026 16:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PT6l11c07rfd; Fri,  6 Nov 2026 16:02:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0D4F81464
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980979;
	b=r9PRXTfE2nHZ7ov3QaPw6gjMlj9yeMDsiT69WLtFkmkRCXv6Ni8pFyMtOtHc5FnxHrwX
	 1DYheDHDTlxBwqR+VvmdAFxkXUrYzxpJ7SAtBu0sgZ/vs82AMJmmhQ84/fsE/KrgqS/q1
	 9DrcILLbiPmotTPibabL7j/CdCwb3tvaJz2xT15sNeLQHFd/fCECsUYnK4/Z7kbBEg51a
	 X+6FoNXwjM4vGqOCGcCKvLE++n5ZJLigAm7LKjxMNoDkx3c4Mrw4WqBAsOAtICDnrtGfm
	 iTlS2dGljmdi2cmYOz8yk2jwecFtO8esQXwSNKkpGTUwTH4cyFQqrNp4YlMavHhf/dQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GGl7Xow6S6RIFhwrBYDBb6cmGN2dFMWBeufympQX878=;
	b=R+NdAm4KJ1sfTBPe0ug2/gYHuF8D+IOQiYDXo1mqcpwyl985xECIud6BXwQ1E130XQO8
	 JTrloOMv23cM/+GoNetG8nqBZR4RYoLQM18d5FvIZZd6U3w2eBxjIsmO090Uxe9upLO2h
	 gsLbDXfJvmu50k7s32KxIsS4X+utF4Krt8sgufHjEQ6uqZv5bZ357Shyooj90lYuNuMAI
	 O4IJeFBwI+MDtwQOa/yVZh3SIDDWqt0c6pWu804toO2XyUppwzEeUx1XX+JUaFFBV0iYo
	 TCnRxWppjZHVgYL0/tZZvqb0qAZmXdE6LPX+zI5Pqtf0jHra3HOIZOkzjvldqo1U37w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980979;
	bh=GGl7Xow6S6RIFhwrBYDBb6cmGN2dFMWBeufympQX878=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pwysjtFHFJG/CIpzqYdqoGwjsWs7x15zvf8JpA4QObdIvPiN/0TV06EBKPVZ56D/q
	 TyuedU/BxQNaytTc9+smRmwkq32GuzP6xXUkC0bR9Q4gXvUmguuobTWX8zaZK/sMcL
	 2+vDIRpEwjTy0aLI/zJcQ9AkfODvVanhz1UvfB6wcZkLKI5AXhzkj2s4as4+yG0Uav
	 xXuNWwJJqiYZCNbykDvsynEK8ohuUd8sa/lcWSDjPZTEnVr6DVOng/m0gQAYrwjAuD
	 rpgI6JhzyqnNMf1fViEVCK4Atl6VkV94QImr1wckunpQRKDEQ+kuIpHe03INQAibav
	 ucPjHEVTzdHjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0D4F81464;
	Fri,  6 Nov 2026 16:02:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 487F232A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E14F608DB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SbvN8KJxQ8r for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 354E8608B9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=BQF3aA4a
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 354E8608B9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:49 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jLkTy5pfsz8txp;
 Fri, 06 Nov 2026 17:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGl7Xow6S6RIFhwrBYDBb6cmGN2dFMWBeufympQX878=;
 b=BQF3aA4ao4qPN/DmsEDzLz0WAD3rfsZNNqDysv3VIunZeiLLzcH28vf+8tqRU2+W0UBlYP
 /5mmVtNtGuSBVtcQpdlG3ztLmtjjvPJxiZNXBKko1SsM1UABlIWo3yoTGW1wIFktvyRkpW
 f7VdgU0fy8WXFW46WxU26vy07Of7XibOQ/a1SOJa2GIYB7W6kBVL+Oc2PFbAXUQPtbbzPJ
 nYOvhCvTXBh+fT0WGaexBE845JUAf8r+j3uk9cjza4DeMAZmpmAEfjDkRcXfnJK2BaeNNm
 w5GiPeoZ7jA6LVUwgpiURKXDW/SRudDlu7ryV23QFkAO7NYt6w58e1DSnNu0pw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 8/9] watchdog: sandbox_wdt: add get_timeout operation
Date: Fri,  6 Nov 2026 17:02:34 +0100
Message-ID: <20261106160236.749429-8-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-8-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-8-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cga3kq7x4skah5m8bf63x1tmsegicum3
X-MBO-RS-ID: 61346ef40a6d8b50128
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06.11.26 10:34, Juuso Rinta wrote:
> Implement the get_timeout operation for the sandbox watchdog driver.
>
> Round the timeout in sandbox_wdt_start() up to a whole second to
> emulate hardware with 1s granularity, so that the effective timeout
> can differ from the requested one and the tests can check that.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
