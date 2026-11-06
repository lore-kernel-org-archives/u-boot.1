Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F3606A335
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LU5BFZf0;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sNhz8O7q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8444D812D6;
	Fri,  6 Nov 2026 16:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id be7o_uP36Srb; Fri,  6 Nov 2026 16:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B38C58127E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793980971;
	b=Exe24Zjs3paIV5JAQUbwwLSqUJ/954rHhZiq2MACEcNxFqwzhIKVnNpbc0YhDZ2TRi90
	 jAGxMpK7caPat+z0ikJqVdJpOjhPWjhFkF5TXM+39qlvqwRpIZ6Ah2MQkipukynqMouXP
	 lxK3RnmXyZMBfl14F62lwuXGK2wB0xxepMrURuQ2un1ey6uj3FWZZi2XrxIhrEiwgFrvy
	 hLsLYDw/LazDxNq1TXqYenKev9O5JvlpyS5DBIAAeJN2qHHrnbM/85m0hJe0PcjP1wYiA
	 7eD6Yq7SE4yCMc9DyR0224NU0aHq5xlv86+f1+wPKUQTtO8cwj+LtBi0bMWpRjvtThA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793980971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CBHNXXZAfeYz3Q7QoZ4y5AKBP/2Xz1wNAnTHUUf6npk=;
	b=ktdod5lBqIaF37hYC75X//gHBfQTdRem3tgfAKN8KdhjcDSh22YCes2DgqAGeZxusRIG
	 dCFE4D3wbumVkfwpf/c77U4WQ8iv4bvfn7uo0FHXKQaQejZPw49q8Socp0WqHgVwOo9/R
	 Kjk6/W90Nojp9rPQJfTOwiBwdsFrGG7+mC4n+Mo9LROl6y5zKi2zRNhp0PJw3t8dB61TO
	 eNYOf8mpKv3iaRr/TdNvH5X/jIdG05ZIh1Yvy/w+ZX4qNQbPA2mjt/UOySl4AfW8N0yIP
	 /QI3taZaFqg+BI1vK8Srdy7zqotPxEC8wdCWpDmBMsmZija7AIyrtM/wV36u7aQeyQw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sNhz8O7q;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793980970;
	bh=CBHNXXZAfeYz3Q7QoZ4y5AKBP/2Xz1wNAnTHUUf6npk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LU5BFZf0dGynolhKas5U6aLFn9AkJhQGPrRD25V9VSHA/vOtwByMy4VvS6bVaUlTr
	 tYkgm91JgFAuTN52zldR8jpuwExJDJPOEQ4pg7wbY7O9hrrLxNsIruT0QTLxggQql/
	 qCJTE2QO14eLI7gGl51Z5u+DPPrp9OSvalC9c5lxxrIMS2VYvjWhfxA+rEeb69saEI
	 O4GfOUnFzyHtYKTNJOCHbOC3C0uSLfrIHvdrkx0Qz2VktQSZwu7jo+vUNSa/ql768L
	 8EAQ326115coGTyeReODFU5yGCw5I1J1fboe/LYgVQQymKcdIZiZskbP3nj2JplDBp
	 xggmPN9vSjSXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B38C58127E;
	Fri,  6 Nov 2026 16:02:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D00A0362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C098A810E8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEzCfpUViw5h for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 608ED81190
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=sNhz8O7q
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 608ED81190
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:02:45 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jLkTt1cxYzKnRc;
 Fri, 06 Nov 2026 17:02:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793980962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBHNXXZAfeYz3Q7QoZ4y5AKBP/2Xz1wNAnTHUUf6npk=;
 b=sNhz8O7q6mF6rSoi9i183rE9048INqbXqyhLBpbWZUm49GlcDJ+fiJnXVbWVNlea93zASh
 sxBRJZjpxrtJcGDaZeERrmrV8o7pqAG++wIJWaVc4e6L6cY/Ym0nNiMSjaQkLsC4yJpFv3
 4LyRTwtq3cEKI+J0/SGTpzVuoBvxPqVgeIHY22gqxPlh1GfMPFIEZOGlK+lpLM2KIFFMhN
 8NNBiuoCowi54qHJhvnDwm3svEA+dSQoJuWx+1vI0K+i5nPQpGV4aK5dfh3CuyCMwLs36p
 P0SBx9PA4J5otnUyHdWg6vaIjKOAH8SFywDe4t5fZwv2tgmcfqc0ylkdMlHnVQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 4/9] cmd: wdt: add gettimeout command
Date: Fri,  6 Nov 2026 17:02:30 +0100
Message-ID: <20261106160236.749429-4-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-4-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-4-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4c57b008f3ea8290eaf
X-MBO-RS-META: bemmm8xhtxw9b1eikutach1i3bjytero
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
> Add support for the subcommand wdt gettimeout in the U-Boot shell.
> The command exposes the wdt_get_timeout() helper to the shell interface.
>
> Command reports 'not supported' (-ENOSYS) and 'not running' (-ENODATA)
> distinctly from other errors.
>
> Add the command to the documentation.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
