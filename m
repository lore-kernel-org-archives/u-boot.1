Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606E4C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A8C8319C;
	Mon,  7 Jul 2025 17:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IcCdYWgy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PZS+mU0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE5A83145; Mon,  7 Jul 2025 17:52:21 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 574B283046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bbTJg0mWzz9sNZ;
 Mon,  7 Jul 2025 17:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+lUEGkoWlH5Pqg8uCd/MrGbp46ySiJefYqd/FQnnb2M=;
 b=IcCdYWgyA0CU66aYFEHM2fZ7MqchNSDMbxTAOdGd9WqnIbmXqDyiKHrEa1koY62/oJRPA3
 ahuaVZNay81ab+3alxWcFWsmFWmXQtoA9DvPvY+gGgcYOUP+nxmIScqvAgxSGLKaZvwjvw
 2yx3hwYJyG3Ph3eZoZ4K96O9gFPN6or+Vg53dA2rhsRHlRlUd72y+QiBlWfiYgrIjDNifV
 F/70bedrFIisBQO5EhlROiV4y+ff2eCNnotDWIG0dvGELNjBazPONasUzqUAMuLocUveHP
 hjtPvTsiuqwSCkGQ/9JACGHeiO8VDrfMgwOYVqztk2arkG0aHeWUzcrPRhEyww==
Message-ID: <cd082367-9cdf-4430-a694-db3b0a75ead3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+lUEGkoWlH5Pqg8uCd/MrGbp46ySiJefYqd/FQnnb2M=;
 b=PZS+mU0hH74Qf6cRPECQG+RFbyihP0huEbmqtLjQcpa9n+DBpJz3issvINt0PgpP4gylHs
 Ye41h4jKIHKsEX0RvZMiH5qOhTqEXX5V44js6CjAHIOdzqVBaJVgaK6LBab78mR6Ybvhy2
 FlmBKjube/X15lnIKDNvF1sJ/vsTYhH/HIlEEyXi8T+Me0PUq83VqzON7zJLSNQlFrOSNo
 C3zFmMaogVziga2KNKQbqqCr4hPEG0aRgeUx3vKrfqRpguyN3agOWkg0M9uvLTiFR7fjv6
 C1heyUZ9ltHedbGfJo1q/rsrixrYNlOzYBv4IRIybr137s1Yqmcu2fkBbu+mwA==
Date: Mon, 7 Jul 2025 17:34:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] Initial r7s72100 Genmai board support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 geert+renesas@glider.be
References: <175147641895.69121.4718662283609078812.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175147641895.69121.4718662283609078812.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e6a675b21cd4cf4e303
X-MBO-RS-META: ob4awdnkagwnfxza1qx5xk5g49rzoc83
X-Rspamd-Queue-Id: 4bbTJg0mWzz9sNZ
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

On 7/2/25 7:13 PM, Magnus Damm wrote:
> Initial r7s72100 Genmai board support (V2)
> 
> [PATCH v2 1/2] ARM: renesas: Put common r7s72100 code in board/renesas/common
> [PATCH v2 2/2] ARM: renesas: Add support for the r7s72100 Genmai board
> 
> These two patches for U-Boot aim at adding initial support for the
> Genmai board which is based on the r7s72100 (RZ/A1H) SoC from Renesas.

Applied both to u-boot-sh/next , thanks .
