Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC45BC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DEF487FEC;
	Tue, 27 Feb 2024 16:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Acsw9Qqt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Yn2StD4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D9F87FE3; Tue, 27 Feb 2024 16:56:24 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F3188002
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkhtG4yCCz9sl6;
 Tue, 27 Feb 2024 16:56:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKgCic4unqljfitx1yXHPvIskjkuiUHusieWDX80V1M=;
 b=Acsw9QqtWNdd2Xf6r3LGC7rxTTeLbJSNksTfYMHEpzRQh0fSN7awqunK6E23H4wmpSGCu6
 NiGor3sbOrJwr4I9RH1om3SJkKo97wbAfKShF7I3KS4iyOGhP+gBkM/KZpY4CQ9YRK3Vec
 +plFP5kyyenKta/7bZIUFK+em9EUQo/0mo9SSpLnpdTDvLYH3kAFG8rEj0RCxwt9OuqvBa
 /zwzFHLDUIzvG1AJjr68mMsG98EP58sFiFp1+IejewqQqf7W7saNMFDOdv4ij7kYFsuLEG
 8vrj3HyLCtzomC13gur1pMHhRRjIrOJhDmZvXf+q2+1DUWMcfkgf3wNUDpw7Pw==
Message-ID: <59bf07de-46d5-49df-b07e-b650ffb79e62@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKgCic4unqljfitx1yXHPvIskjkuiUHusieWDX80V1M=;
 b=Yn2StD4h2ZtYCaq2gsFRiwwQpoM8N3XTAv/IQnqg6m4iZ+gug+isovtl0SkUZHG35dtU4a
 PordBKRribRlIdZ+L3O1JJazwirCR6CJnSP1fRlLNKnlDillAjX2OYYxfW6hN8Wgr63OOW
 +uKE3uITb/3Xy4Fnsatsy48XKb/pD0vva7gF70MX6TLJ6Y6lvtxfWdRWdBC+IhwgwGJaBS
 szNdIsftXizMtiIyxyjf5OF2Qy0zRWukmJLT6PoCOE7n802lPMW6QHKCMi3rWeUaP/jJLp
 McoY68+4rUh32HeSXuUyT+DMaGNsTIZr/LXJ6cofHLBRiJm6qSyk/rrB3WFP/A==
Date: Tue, 27 Feb 2024 16:56:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] board: rzg2l: Support reset via Renesas RAA215300
 PMIC
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
 <20240226150536.1690-8-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240226150536.1690-8-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: diafmaeino465tkospdhaqiwirpn33qi
X-MBO-RS-ID: 49b54ee47758e0b357f
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

On 2/26/24 4:05 PM, Paul Barker wrote:
> With the SYSRESET subsystem enabled we do not need to implement
> reset_cpu() in the board directory.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
