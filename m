Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97081CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 12:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2A894062A;
	Mon,  5 Oct 2026 12:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RphcNHTrbPk0; Mon,  5 Oct 2026 12:44:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7505140648
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791204267;
	b=gpO6R4h6XirQ8/z4t+CZ/queQIAvjFj+wZsFCKbgJ0OZjprbrsvJsXbBxBfBTixtNmU6
	 IbRV1faPrbFVKnsAPCMXeC4i44ed9eXCcwLVsmGeUivEHwTEEs88fHAichIXfvnnUZRkZ
	 MJwouTnTdYPPiRJVlCHH7UNfyP4+2Zsp3gpWOai2tfubEPp8sS4qvaVLXbUOir2P/WnJ/
	 eUL6D5tGFNd8Gi9ci6nDMES9Fgq0pBskwPMKV6LBBm413Q9HjQj76zOg/txjKf10Cj5f3
	 pUezv9f0Bl08k3nc9vU3+cnUXTQKjz90RdGoRcyy1WoR49MTmkDJ7VDOHq+ce22RIKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791204267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zhMdvVdcOG653U4ZFjQk4bg+R6EeleDfMFgvlBgNV4c=;
	b=c5lmNosnY04tYkuNb5dJ1lmZjPOkAdOHQ2aZ/+9/oaJmf3Q9GWZZfMQ5H9YcJua/FaCS
	 SXRwk5vz75mDB3SSntFOcY0gGMnfP51JsSmgHq6SUJ3K0c1JMTvpdBzAwmwbcUDwQwVSU
	 qozr5YDYTOn8455loMWYTBSzdkggTKxwxdduep7HtDOhVxKj0kGJ38K/DQj7OJE5DfR+O
	 oWb+GSYTfpFflseRCjF/n2QQGYWLIvU/4n+yi/+OSVp/PciKCBFGFimsJqFoFn94pGeKc
	 0wBlxMShDpKWE+l0OPBhrA9M62EPyRPzQ5PIMf/dVwUUrteZRG5De7MSKhazNteYP4A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791204267;
	bh=zhMdvVdcOG653U4ZFjQk4bg+R6EeleDfMFgvlBgNV4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lraa0SONgTu7XuhjdxqlGLWclHySo3g9eX/ZKyJDI3QJd6emRMul69PzS2LbBdEBg
	 Y5mZt4Vhi5tSnAhHhEKcEF6Y6ACXYyq49PU75fy1pUgJg8Vxsv+Q47idF7HRQXMVKi
	 vhbo1W+Z9MCIBxF4qgNBnW/9MPm9eQJ1EhVbuOLBHPojyriOYEjPbp9h3rq9yaYbl7
	 fYiyfD8FxGxsUVX5nPc6v17ZJxK8+DlkvhgNojgSOznxmGYkQWbeSsKInMEMmXoMHj
	 /FpBW6y2MXB2iyWZ0F/OLERSWhCIaj914oLOLp31QmAHPv+Ck9FSMfLb6LhhMlu37V
	 LWiGP5kzrQT8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7505140648;
	Mon,  5 Oct 2026 12:44:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A671E32F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 12:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B96E80C26
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 12:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8OIkbZ7OofCs for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 12:41:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 62A7980C1C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791204086;
 b=BZo9Wsr9+STEoMc/f4efAccOrsYT3pQr6kpFwUZzyLl3Iso6tWnZaLsBQ+26tTGcbU7p
 i+k3chpWI6kU3tKtZ4h8HMxvslpTUH/sAoCWdNGfwEl0FULlYoaxpCeF+joEzP10+NHb0
 n5WYRkv5EN0O27UnjC5FD4fTbFWxZJyvEQwlJUvmyGyn+Ex8tcsoXRZ038G0z3KJFbiK7
 VbR51NrzS6XZW4WTjWV2hX4kaoCs+bFACtK4fhn85MWXe0s2VxoDW/J4sztl1auw+1Vnn
 MnLy4CiMGKtEQLDr50P9TpWwMmolrdtdvY24qU9UaGxOFTV+4L9tM5ZzUqAWT7oiN7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791204086;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=zhMdvVdcOG653U4ZFjQk4bg+R6EeleDfMFgvlBgNV4c=;
 b=tf6XTE0blYno+vVq1V5iceYkk/3xQQmrxHtF7ZeVO+QkDJtre9WzxB1GqVQSILI+Gh+7
 ViEJwpBK1ThL9JshOYl4p5kNUJcZnw2Ai/afylK3++lGfYT0ws+Woe6FPFkJGLehz3Xzn
 bR7qvHI3uNbSa42F0SwPmLMXd0R0VgyeHtOr1w2oXbwDJoGrwVV/WhMUGDOqJiD4OzVfj
 irP+lDwddwITL9NM++EfDOvYNLnZLGyFBJlXDF8BtmptJawCRs1JgNQO2koh6c+un8Pgj
 k/0EQQKCxAdBKWQc0v9ZuTFM+amIPvVFP1uCH4uE4qa+MWDSnjsiguj018z/4J33Y4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=fkDqvL7S; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=fkDqvL7S
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62A7980C1C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 12:41:25 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hyzXL0yZFzMlQQ;
 Mon, 05 Oct 2026 14:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791204082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhMdvVdcOG653U4ZFjQk4bg+R6EeleDfMFgvlBgNV4c=;
 b=fkDqvL7SyZDd+cru3SVB6pTo6g264fTfrFPEVOvbFNW3AawHJNZYrOJihwyJEc4sL1Haue
 GHP3TbEDLf4xQ/3Z+TTcab/Iac2qjdiBcesShZnuRPQHwo0auh9I3SsKgqSmxAd6qqj+MX
 yzSSBBDvc5mnW3nVG8joWLbboznrOcuvEw+B4HxQCjA07Bt8duTUKU8JBuljiqb6S3SEuL
 n2Zf53ExqNM2Gry5xIy6f50x+PdCdJFAKHTvJo23PBST9MgrGhOqyXFMdMTHINxdAePfL3
 BfRsdFJbV8uQDggjsffzwzZxaDBEfwzXRaUE8zvSekBAyWIBAzKtRdnFFfq1Jw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Aaron Williams <awilliams@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 1/2] ata: ahci_generic: pass the AHCI device to
 board_ahci_enable()
Date: Mon,  5 Oct 2026 14:41:15 +0200
Message-ID: <20261005124118.840713-1-stefan.roese@mailbox.org>
In-Reply-To: <20261003-ahci-mvebu-windows-v1-1-e382f73fc299@iav.lv>
References: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
 <20261003-ahci-mvebu-windows-v1-1-e382f73fc299@iav.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wnitceg7gpo8stqy37dy1foi6rdweidr
X-MBO-RS-ID: a990d3613f088fff5e7
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

On 03.10.26 06:36, Igor Velkov wrote:
> The generic AHCI driver calls board_ahci_enable() before it probes each
> controller, but does not tell it which one. Board code that sets up a
> controller can only use a fixed address, as the Armada 38x code does
> with the address of its first controller.
>
> Pass the device being probed and declare the function in ahci.h. The
> existing implementations do not use the argument yet.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
