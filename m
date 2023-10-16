Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207D4CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9163986BEC;
	Mon, 16 Oct 2023 14:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x1G6CVGH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O7/sKRZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897E686BEC; Mon, 16 Oct 2023 14:57:27 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87FE486BB3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S8HFc2JGpz9slg;
 Mon, 16 Oct 2023 14:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697461044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsNm+CfoXXmwJQ7wwoPBY7Dfijoz/lVYQUIPTKbgfyY=;
 b=x1G6CVGHGeohWH6jFOOH0hvBYaszKkJdZmQZkz1U94pIaALsOTx/0ty79wiV6/kERLxMPy
 naS4ZPenu94wfWEWISTp0xxj/43YnW1zx89X83Y3plSyoZ0Ki5HBOsFx++vrhygOzcc2eN
 0dTbqtNuXZ8pzqR8ft7Z19eKarI6d05soZEILMvtQqyWA8qXxZ/ZHC6YVXzXjbhkHVxoqf
 ob4QNCJB7xYY23ytF+NoLiMPN0jFgH4niVAPq6tpg9KkJdaQUvm0SgMocfDIKZR0wSqk7k
 17/AP9hXQLZbPjPL5ydtvCeSm/c5BfTNdadgniVfeHjF98rC5vIsHvAjDHG1Aw==
Message-ID: <430732a6-8805-423d-a624-a540317b528b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697461042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsNm+CfoXXmwJQ7wwoPBY7Dfijoz/lVYQUIPTKbgfyY=;
 b=O7/sKRZlZhiHhElvG+AEOrFfsN9xMYVs6fZkt28B8p7bMOXam/p/ekJzMzJFKrsrBpv4oX
 7iJrDiMRqV9l8+OAaPEwPpjU1Ss04WRgobFbRnHGus8kvfBsr0hKbwZx2U5gEUvunUBS1S
 wq+nW/LxwuC1QLqa7bLPG10Y4kvNIMt6v2aWTiTvr/V+hKr/27gshoEjg+3X1jXNdbq3/O
 DR7GScpgnjTDXUveGUZ9u/lOLsz2om+07nbiWE8JqeFTSqOCCp1cHo/Xo+GgqPgLstsBTJ
 Boy312CFwM0MvOLQRpSGo2bJ/7arH/JIb3JBllw/45a+ziHT4w0rpdvI6TNx3w==
Date: Mon, 16 Oct 2023 14:57:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 13/21] serial: sh: Sort includes
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
 <20231016092543.3833-14-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231016092543.3833-14-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1cc89f34f065af1d7c1
X-MBO-RS-META: p1hjfmpnbd3d4tw7hc6pfbueh3o5b5jo
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

On 10/16/23 11:25, Paul Barker wrote:
> Tidy up the existing include list before we add more includes in the
> following patch.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks!
