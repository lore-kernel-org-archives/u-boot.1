Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D353606A32D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qLiYI86E;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=foeaL36e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0739B608DB;
	Fri,  6 Nov 2026 16:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfdOAaG2kXDZ; Fri,  6 Nov 2026 16:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 527CE608E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980975;
	b=XMIBw6+6r1RhQAUvC8MiK1IJfRtmQF1uBccN3FZUUKiujtRuXUaGzswTW28cMFCTtD/b
	 SjSTfJ14OYIfklYfB4ITM1FKzsUs0cLqTQ4d/MPLaw3A5OBKunMuGCkz5+so6Hi8EwTt9
	 wXDm0zz8EuW1O0sz2jQkYdqQP/PhNgc3HZCccBZpx0ztsRjKsKRsGuRgp1/HvryzSIlP3
	 LGT/mLr5KJKW5cO3P0Mzd4E07cvsOjNYPZWymSSMOw+BPqI5WHIUX76FngF1tEBIZP332
	 w1i+U3MP0dvTRR65p10QlLEK7ilZpIg0nj4uttnM2mZvnk+YPTucDQo23vtEypu8vnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FcfKPwFiq4i/qDDiPgEQqmAsrP9VOdonS6bD39zhxDc=;
	b=qhh8vNCdn72Ce+x1IdNa0cDRGwB9IrtKjMT5Zdc0y68rnTj7zM4fBg8GzPenIbEmbBZK
	 T6lEBA6pOwd3mhwV1wiM3DqLBOqvum884GGpgMEEyzUINb07Q3Ux81RV8fWRS7XXUoa6D
	 fzQzKty4cu9xswew1Fk4J4B/Sy5z76EsCLqkcW5NoZkbLcEu88jlFqBGuMr5OvyP/kgZ+
	 vAFjU2APiMgnwFMJCsugEUM1RNqydKM41l6xtYWkcBgr8Q1GmE7t802zih+GsQZHnJK9s
	 z3rh3M2CHd7O3+aRWZTRubhW4KYErVZetN/K5fIGhWGCxV3BB0rXp4H756k8lDNmqtg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980975;
	bh=FcfKPwFiq4i/qDDiPgEQqmAsrP9VOdonS6bD39zhxDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qLiYI86EL91Y4ziOxMg/NgOxrGkJbhx21hEQCGz1sN4nYHimRtIwaoRe+HFxRP6p+
	 3QCAWLjYlMVhi2BRBv1hWpC86RRO9b6JWbt7mFEibtb7IyEJzRgWj5cvrN3mAppFgh
	 WCchDH+/jjCmUBWcsubFDiYAAz8QRrsrG2QJw36DMDftzwdgrBZ9p8VW9IuX8Xpysm
	 /1ciaiJXLP0n+lfbO9KSfEcEvWW9k32eO4LxOphanHV/uxQOWUD+DQYtq1jb7dykrm
	 gutINxZqIhcg0IBs0ryzwpxs+AKmMkzsRaE6vlNrQnATwX/zZEUtY/EEe0x/yDMbk6
	 PkQTqSxvEapoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 527CE608E7;
	Fri,  6 Nov 2026 16:02:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79642362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6008C403CB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1z5NfrIpsJcM for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A7F7C403D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=foeaL36e
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7F7C403D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:47 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jLkTw1LpczMlcP;
 Fri, 06 Nov 2026 17:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcfKPwFiq4i/qDDiPgEQqmAsrP9VOdonS6bD39zhxDc=;
 b=foeaL36e/jK1bMv2EtQF6zT2b7WZDU2NA/XfmtG0ktj8Lcw31N0mh/Og1G4Q5qusoc3ymX
 YM1uCXfIOJeLjBxTQ4glDmmhXOqRMndqH6RcIG3O+5/dTpqMX0M/S8JUxY/g3X+Fxo6Twr
 qa6fkGlSsEGqp8UPYhkI4SacGjQi17LwuNzNVb0uEv8d8txI2SxvhAlm5nunm62pPO214q
 QkvolTe/QJqHFiyXgZSf8Sb8L3LgoH3MlMh2So+THEp3IWpMagXp0eQI3As/GW3te8ZFz/
 GmrX/5NZ+uZjDLFZpfhQo3/qHtOrUd3Z/0GCyjNF95QIC6IIsJYjauNpK8G3rA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 6/9] watchdog: max6370_wdt: use a lookup table for
 timeout selection
Date: Fri,  6 Nov 2026 17:02:32 +0100
Message-ID: <20261106160236.749429-6-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-6-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-6-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3767cd6738ce296c0c1
X-MBO-RS-META: 9jsdmdoi3ono6gq7518tp9e7q6tj5gqr
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06.11.26 10:34, Juuso Rinta wrote:
> Add a lookup table for the possible timeout values. Replace the
> if-else chain with this table in max6370_wdt_start().
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
