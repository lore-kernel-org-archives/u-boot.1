Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF90CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 12:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7348080C12;
	Mon,  5 Oct 2026 12:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofSOfAYQ-gZL; Mon,  5 Oct 2026 12:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0C1F280C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791204269;
	b=HOBVrmtWl8/6WbZUVbEAOy+6T9tZ7ZWDbOWnAttQMfZhaN+eKDHBvZJ9Fb3hBxyDlVH1
	 uRYXtXnzTTju0y8qyrG67vNc+5eZY7IJkmQd8VZAVzEjh6LAMcA1C/r4av6SvbrqiQhyk
	 qps8ZOVuI8JTHI/of5EyoSeC7Pc61NGaT6jqGiiZWegw00rNZdJ0HY4UtHD3Fv3uT8qi4
	 LSKnKtLmB5eXghRGNg2yUFXERNI0byHTntZg/dpa/+biP0KaOCNSP9worzoYYf0wyjSZR
	 ikVWWp+WBwxgsHOQNmQIQUhn9wzzD7AqgMVeiru96pXj4qgdlCXRooPmG/gIpEV5HEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791204269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0C2TVVwxEyqNqvlFRPheVlff6twEA3XCDVShOyI3hnM=;
	b=GfWIC3yOBMiBnPRqE8NBRAFvV0G12B5Ap66ENeZwqJKbn4OXgkREJvoqdbohlLQoYsIE
	 gVkPDzY1Duu3s+/7iydRCf4Wg/zmzzpHvd8nCCVFTQQhna/olIrh96bT4beFv+aK1nFle
	 F7wCz6BsUTB0Xha9d05saIiRQ1kiu/W7FhJcwTUPI0jBnK88nH1qdpR+lSlR7kciQe9WO
	 SXlDDTBOTEYzoC6oQmAAAoOyDWuD5v9hFDZ94GQYi7CtwbGbcSIXP2k7wqVuHMrc2+uof
	 /IuR/OI/k61UUxRgBDL/dq/4eLkLb1ZeYqmm5jkPemF2Ks9amD8QJFhHqEiHTL0dORQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bLU0ziRP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791204269;
	bh=0C2TVVwxEyqNqvlFRPheVlff6twEA3XCDVShOyI3hnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fYKbcDYA+dg5Yger05OT6/Wy09ZDMk6pMOl3DKTgU1+VdJgnzCkWcSirMcYubY1nJ
	 If8O2XYDAgEt90XE/yDxasRzyyGYlhHqiGMOBBJPGqcBynPAbRptZ4vo2PqnqhSLO7
	 59Qe0eLV4z3IhiJ5Ox3kk/AOP3/Ex62rKVukugfFLr5Ws+FHmhS/Lhvwb1/dZd0GTF
	 QsUYDbKiVLcNPQE8lG9Nx5ZnvVAjT3/Qe6EPA/uXIZ+GbMmu0UV/uChzAuoCK+GDyQ
	 HfjZ4mCZxvyf5x2zGGBuOEWDMd0OFYSMB1jVGWaWxTCWNdgqTZtot3YAmoyp+otLKa
	 cVGWB0LuTX51A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C1F280C1A;
	Mon,  5 Oct 2026 12:44:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99B261D2
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 12:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B30680C26
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 12:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-NNAXrBXvm2 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 12:41:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8E21680C1E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791204088;
 b=HtP3NhVdxw5oL2L9qBeF/AyOnIrlsq53s4q+Z0Zv8+8MZ/ORMKAC35x4T8+NV4qzbrGf
 ZkaD5YixhBPeeAaOjs/dm9e2g82VsYB9MlDoeCnObuGXMKKQ2c7vaKbnmqKi33GFuZMol
 g45wfvzPMIYnI0iMyyOd3jZR9tLLzHBZnJPK/iLDYwu8TacDepQAefYq/oWo6jkufhoEH
 YjhqxaEWsgdlPe8ytTdsvNS/7p4RO9uUdgu0WC9DJfrR3DCQwc2+7kDtH5d+IDymusnC9
 P26VjMpypgK9VaGCmoRj9E2xCNM39+Gl4pHSDnHVd/V/esgZfYuYVCUR2iT+xD7dHCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791204088;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=0C2TVVwxEyqNqvlFRPheVlff6twEA3XCDVShOyI3hnM=;
 b=iXAeWjOcNbW/KJtgHNqYIM5An4tyIvJMx7R92/EYHIQ+bqkm3cOT96+Id1TJJbLQ5YeS
 1hZppIEkUdknyIdnJGby1UFqClODpYxp9rP3NzaVnJ1rRnYJsEAb216bEG0e40DOIZEJX
 af9fwdaB+dD4lzXuS9waPHQKBk1RRkJOQtEEGGu8cj11VM365yI7u+A2qat25lKwN6FTx
 RrKYIIoHfx3E3GT27WiOInEYRmLxRNFBmZJFsP9YjFV31TZU29xdLdcyu8tbOgnZdGEGo
 TrINhVpuiOp0yLFbfln3qizQzRrfQHnbwpISm7xmwhlWxYq3iRXS7k1OI3tbAlpzGlA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=bLU0ziRP; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=bLU0ziRP
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E21680C1E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 12:41:28 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyzXN4tBWzMlM4;
 Mon, 05 Oct 2026 14:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791204084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0C2TVVwxEyqNqvlFRPheVlff6twEA3XCDVShOyI3hnM=;
 b=bLU0ziRPNq9rt60pfj/FcBEZmH6cABGWOpujEJAM2NHs4veyXpy3EtojW/+huBGVUbXoDV
 M0bKTUcHyz6cPx+hpyYjncx6nmVqLlt2OqDOul17jNLmZXDVQTeOwtJcO4aA3twSxRTTjK
 ySGrboSNQNOU42t4zCbSjEgy6/JNREJg5+PMdSaHmksvjy5eDN50g+w6QqdMZoquRynzWl
 9XcBOc3ExwroQ43bRGbiDl5l6DjRdyEHSOQBavEOgFkCSBQ61A6thTq+YxKoa605HCo2iG
 ZihrD5V7/ece97KwBzjxMYo30aRPr907f4mT5rH16Nn6H0KFyg+m9XaP6joi+Q==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Aaron Williams <awilliams@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/2] arm: mvebu: set up the AHCI controller that is being
 probed
Date: Mon,  5 Oct 2026 14:41:16 +0200
Message-ID: <20261005124118.840713-2-stefan.roese@mailbox.org>
In-Reply-To: <20261003-ahci-mvebu-windows-v1-2-e382f73fc299@iav.lv>
References: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
 <20261003-ahci-mvebu-windows-v1-2-e382f73fc299@iav.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: de831ab276d0e0d1454
X-MBO-RS-META: yymuhtuzfktor9xif6u9kbzezr3z79r9
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

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
