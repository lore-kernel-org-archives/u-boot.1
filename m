Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35515606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SiYMn7js;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=aObjDsMe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0655A40704;
	Sat,  7 Nov 2026 10:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j--_HeWTk6gr; Sat,  7 Nov 2026 10:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D237406EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794045897;
	b=TH5U+GnEIcos0pzcgjU2A4H13CHqePU+cfFHZVJge220LBmzGUzX0bjOE852n2RgSj7t
	 7J8KjxTSJ87yplOvjJzuxxZ2FhbuvWs7AsIG9/9ISFI4DuTXjyF9U8WgQMTeCJJEJuVjU
	 W8yzc9ZsMpckmzRhd4xB0kKwXbvtN5rs+T8KJNSYVznBjxiJ8GkEk6YtJ2741qzfUgpAK
	 N9NBd1ckrED3rJzjOJ1lcg7JCC2n7C2rerRDNbI5Pa8deBNxSHKo4lc5XcP3YrGC5rWRg
	 dMBGFGqVeiNlo53ZOppmK0QAztpoPKjAPDZcG5ApfuoxhmPKe15eeR5JNx+zVKugdfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794045897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XUPg10dpr+93518rRvQF07yDi5ZlX/se5D5TjdqHFOo=;
	b=UtZbBRy15wO+zhNWWTycCAm5nmTcrD/0Owh2HkNzqy5vHz8uNbkEBHIOpenjnG5rsZH4
	 36FCoRbPzEq2CWi0lOYg3LrbzqXUMlV7F9WBssxd9pktDN4TclsER9QzlIfHmtV1hAqMW
	 Zih/x77Xb8kvTKlsXw5iYFCw37hOp2F0J0wvK3AQJXXw+MdN9kQqqlgJBKLPeC7D856aQ
	 WBNYIMqzu9ubT/gGlt2G1veVGQihVtPuSR7pMG2vpCbbAiq9CcC9htHcl4VWqmWXRPWJV
	 ga4nRpQWVDf77Cg/0lteVfOKaULBqRbUcSbIu+kM0Y0FhiXI6PISi0QJ3jk3LRnCHTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794045897;
	bh=XUPg10dpr+93518rRvQF07yDi5ZlX/se5D5TjdqHFOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SiYMn7jsIhz4n4ctx7nAIOjl6ZU5THXK1n8eUL4SJAxJ5uhntrsQpAJiXhDfAEqLC
	 wQm7gsngeMQERe8wKb2YG+oytCIYcOTB8DbzAAdCrSaFvqSGAVJyTKQMsOi1gEK4a7
	 la3VAYr2DdEcc11Elow1gvkGvD9ZP3M+TI9S8T+5Fs2fsUh4gliTYgKXRCBxBV6RCN
	 3TSAZE4Y9SAIGqiCShmLV3jj8Sdw1uNwp9q5B3CtQGv7VBqtFeolECjg5diW7ljzBQ
	 bxAS851ImnrR/NMa5D3C3WSlvLZibmG3crcVcqnMfZYc/GdJl+JdB5RNRWKZwmdSRz
	 Uc0ZlhwbnZygA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D237406EF;
	Sat,  7 Nov 2026 10:04:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 406251C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25EC580F4D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dee4sirIvLY5 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 10:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0294D80F3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=aObjDsMe
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0294D80F3E
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:04:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jMBVV3yG4zMlT6;
 Sat, 07 Nov 2026 11:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794045890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUPg10dpr+93518rRvQF07yDi5ZlX/se5D5TjdqHFOo=;
 b=aObjDsMec3HszQUfQbU72+vhTS+noZuseNWAGl3n+32KkPaSQqxrrQFN91ObQipuxr3rKl
 3207GTyLaWKz389fcUi5gHgO1QGeUd4YZgu6PMoIeg15e4xi8JYXDy+3/X8O+fpWG2aveH
 SjJNIt52Fah5TkpFm8BZlkG7NQ4qPW1fTWLHus1rRuHZ26rwqyAi+TGPpa1c3ppt9f9yAK
 BgVFJgh2eqQ2GUsTPiprIzUR12jSjVz7VFZzV/n61dMe2QHHmjOLPJOz+0aRoeqyn+dOfP
 KmgA+uZ51x3IR7cV1kjkSNC9XVIzBdfvs3Tz8eX+fAbZnm+n+wS+JJZyzbZhLw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>, Tom Rini <trini@konsulko.com>,
 Aaron Williams <awilliams@marvell.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] arm: mvebu: set up the AHCI controller that is being
 probed
Date: Sat,  7 Nov 2026 11:04:46 +0100
Message-ID: <20261107100447.2091502-2-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003-ahci-mvebu-windows-v1-2-e382f73fc299@iav.lv>
References: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
 <20261003-ahci-mvebu-windows-v1-2-e382f73fc299@iav.lv>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b48a8j8odsxryqwehe6hrqnpco7f5jmr
X-MBO-RS-ID: 7435464a00a9cf86653
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

On 10/3/26 07:36, Igor Velkov wrote:

> From: Igor Velkov <iav@iav.lv>
>
> board_ahci_enable() sets the DRAM windows and the regret bit only at
> MVEBU_SATA0_BASE, the first controller (sata@a8000), but the generic AHCI
> driver calls it before probing each controller. On Armada 388 the second
> controller, sata@e0000, is left without these windows, so its DMA does not
> reach DRAM: the link comes up, the first command never completes and
> scsi scan hangs.
>
> Use the address of the controller being probed. MVEBU_SATA0_BASE has no
> other user, drop it.
>
> Tested on Helios4, whose disk is on the second controller: without this
> change scsi scan hangs; with it the disk is found, and blocks read in
> U-Boot have the same CRC32 as when read from Linux.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Applied to u-boot-marvell/main

Thanks,
Stefan
