Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368FCFED9F6
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 17:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F8C84222;
	Tue, 17 Mar 2026 18:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lWbtCslc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F57684312; Tue, 17 Mar 2026 18:25:29 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5097F842A4
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fZzPL0j5Lz9thx;
 Tue, 17 Mar 2026 18:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773768326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGGteJ+j1xNfN0cjUQjS7jd0/cmjJSD2/wGJd/5mcE0=;
 b=lWbtCslcxoKw3mozxz/Ae1asztGW2HSSGyZgLvBmzDTGU2wjZRiBmbzaq0AE7i/q4EcwVG
 NiL5DFOGd95XHvRZfEYxlJkxTYBO8eR/W8Uz5aEi4CNwtlfrPe/v9a6qAJwynWNY+HvIgx
 0DntjO9AdW0Fk3thnX6rn0VlrY4qes1I+TCEAQkf9eu6Xz6sD4o1a+Vib6/2F1WBHTplsY
 z+PpEFbKPvZTZ4lxWhfoCNlg793lWS1mFHeJGGx1FoEygmEbKz7mmYZ3GYahEK8vIUWXmG
 pSAt+gon/fDXyYp/caMZ9hunlweBC65Cq8B9G4Sv107jSHjrBqWBx2gguwX6TQ==
Message-ID: <eb757648-a2cd-4cb0-a266-c622830a58f2@mailbox.org>
Date: Tue, 17 Mar 2026 14:57:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] doc: overlay-fdt-boot: .dtbos do not need load addresses
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260317131336.673240-1-ravi@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260317131336.673240-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 57aca9419286e7f25b9
X-MBO-RS-META: o16futyunywt59e33goo1izy1pshkjpg
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

On 3/17/26 2:13 PM, Rasmus Villemoes wrote:
> The requirement that .dtbos have load addresses in the FIT image
> vanished five years ago with
> 
>    4c531d9f58b ("fit: Load DTO into temporary buffer and ignore load address")
> 
> Fix the documentation accordingly.
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thank you !
