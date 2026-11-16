Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F3606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nIjXuIEX;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LzzULyRY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3688D80DE9;
	Mon, 16 Nov 2026 05:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBoJ0VIhneGy; Mon, 16 Nov 2026 05:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F33AD80DE3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794805635;
	b=nAsmlLqGT6fqyyYxMi2Hn+0qjD4Amg+YFtAUjFFPOqLvAsLoccjRevs6JCUOyIRCC3yL
	 qCy4JbxiJOpG48HpDtfqE6/eV6vOcFT634yX0xyrRehUrVF+u4Nldz5Xb14b0bg4Am/BF
	 KneHq1AALXF5RYgivpHLvjHGoRJmklP6vn8xm2WEc5L3UGdBW0e9PmqLWJ5ifsQ9WCQF3
	 B2b9rj/YrtvrM6ubQ71bMgCCaYVnU8Lh+MkAoBIqez6un9FfVdkqvH3wAhIsv/HFv9Kwd
	 0wXVuKEmkLhJxave1U4RkdLCvns45ZyBJ2HZ9C8AG0m+MCCNEmaKWattt9zas+LDpPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794805635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DkWsftvbORcI8jJwWqafRwCazUkIqOJ/z7xcdgKGIP4=;
	b=Srpco5J8Z2OxMgqCGKZqEtnErDS6WcEaj00d4lZ9x1FZ3y1WFqJgUIgXtu+UxzBsFG/w
	 y+vRPI3usWKuWzZaq1/WQfROfeWFvQBAhWHBw/9vF4ftaipaSZUBgkNyF7Z4GCr7udX4/
	 Mtb7v6OdoljfMaYA5e2OFaeSJoxKFG3VWumpMOSbv0MRivdukbyU02EUlprelcIrpZauU
	 gSt1DOpTvzbzvdE6vXJ8eX7CqY3ndTiGlPxsBcmDCa6Gx6mGwGMwNjvcnHa0wrOm542lL
	 8a2XGs3n4q47VkIbiQKvA2fRPn2mC604pxfAilawPbZULPztx/x3UzYJIHoefCqkWnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794805635;
	bh=DkWsftvbORcI8jJwWqafRwCazUkIqOJ/z7xcdgKGIP4=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nIjXuIEXU5Midk/i6PLRvBNXWgJqKhnrRtluSbnhP8SjkvhTzLG8VP1RjXksek1Da
	 vO8j7nOuwR3JwptPtRZyFazfgdD4cqf+7WYXH4DF4WpNhgJPCmoFumHXAzzlsGAUmn
	 mxFSOAIqYkhXtdU4yW3CKY6SDONetEMQobXSFpxTZcGTR2mwetAvWpIcQ6Sh7cuz4U
	 Xw0hP4/AxUGxzWSpTG6lVKDclwM+y9a6zWLkd7J+AaSmGfsiIjChcEa3IUlR4Oq8+g
	 kn7tQzMkrXURbxEgnelqeb0B8fGtGbc5M6eemx5jXmLZo7f/djqbaXRGVoVsET1CSJ
	 UZHhTejmF3ptQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F33AD80DE3;
	Mon, 16 Nov 2026 05:07:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 742851A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69D8B4008C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPn_lxk-zFXs for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CC41E40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=LzzULyRY
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC41E40012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E31A10EF33; Mon, 16 Nov 2026 06:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794805626;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=DkWsftvbORcI8jJwWqafRwCazUkIqOJ/z7xcdgKGIP4=;
 b=LzzULyRY/e021g3YGY+tsD3+jMIJyp6Zs5SmfrSgQIHfzaAQZArqhvUdBwJwMuoQ9jzvVB
 v9oAzGM1/det+yo/GExIpTasZjitf37dzEai/XIbc5CeemHf1Rgo9AgzAe6al2DedF56GZ
 BZg7eD3EoudF+B6gyXjZSW+iJQJaQYnIIRLHjmT6DoBzC+tdCfHIm/RpcT/VFio7+xiA1Y
 8ThoEK8ljCDzTahts/koNkKIBNieiYh8FUdl720L3k1yAyd6QOAXF8/oJ9Akx8xIQWZdRn
 JHN2//WRqyI+RsKv1K/YxzT3sylkSxVWFpsfgBuiy7QsE8RdURbV/lB4fNmIKQ==
Message-ID: <1314c58c-fcf4-d829-1f2c-32dcc2bacadc@nabladev.com>
Date: Mon, 16 Nov 2026 06:07:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Robert Marko <robert.marko@sartura.hr>,
 "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Please pull u-boot-i2c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Tom,

please pull from:

The following changes since commit 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7:

   Merge patch series "imagemap: structural and cosmetic review follow-ups" (2026-11-11 12:48:04 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/hs/u-boot-i2c.git tags/i2c-updates-for-2027.01-rc3

for you to fetch changes up to 82ba0e353477e61035afd7025dc0ec0c5982b2ff:

   i2c: at91: Probe with an SMBus quick command (2026-11-12 07:18:01 +0100)

----------------------------------------------------------------
i2c updates for 2027.01-rc3

- i2c: designware: pipeline multi-byte read commands from Terry
   fixes a multi-byte read ordering bug on controllers that issue
   STOP when the TX FIFO runs empty

- i2c: at91: Probe with an SMBus quick command from Robert
   fixes i2c probe reporting every address as present on a
   zero-length transfer

----------------------------------------------------------------
Robert Marko (1):
       i2c: at91: Probe with an SMBus quick command

Terry Zhou (Synaptics) (1):
       i2c: designware: pipeline multi-byte read commands

  drivers/i2c/at91_i2c.c       |  9 ++++++---
  drivers/i2c/at91_i2c.h       |  1 +
  drivers/i2c/designware_i2c.c | 31 +++++++++++++++++++------------
  drivers/i2c/designware_i2c.h |  1 +
  4 files changed, 27 insertions(+), 15 deletions(-)

To merge into your 'master' branch.

Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=226&view=results

Thanks!

bye.
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
