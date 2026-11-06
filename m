Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF7606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RidiLC/u;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TrzRQXmu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 363B080CCE;
	Fri,  6 Nov 2026 16:27:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xsw9GqIlmpiw; Fri,  6 Nov 2026 16:27:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 860D5805AE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793982434;
	b=a5AjOqtzbWLBo+fDTunkxJXqRUEqITNQeC83u4N3DbObgY+HW2y0VPu0e/2hKHUofNgM
	 qiJiWSE0jwQNbBcamCMjsN2QEviqyMV/2IiZeFyeLg5F66aTJnYs7/fs2sf14LX56pHW6
	 sWj080p4L27hWkjGbvhRuxNQkb3w1i/Qst8A4v4oM9uQTiNXrM4nBj96SlXzHi19iROGp
	 zNY/mfuXEIK4nxkJr1L8G793W49Rulfu2SNGIvwaInm+8415pxdLmGGaT6+6E9qLnPFIk
	 eGq6SbBQdf0uNEBO4HDV5EHhtRds7ydNvkDLo+dpVMmIqlwB7L2PP/pXC1NocJHfvVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793982434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xVNYMNgn/r2A4KytiwivK1c9ChhbTCRlnlMYGiT2AxI=;
	b=dG0msB2KLdj+6r8D8bLHS3zmf6/BDyRSq9HKZZQ8lKGS/9DmrlqMZ4agvUc3kY207zMh
	 1mT16jiKhwd55MWDQCyw94TKG3HoMT2xLCX5Y2w6tJjH48nbI368hlDcGpQvP41Rz5vit
	 0FiBkY0Xou3HvXr+4s2/Sh7MR4vKBnKcwCTniDu/ilpe7ku0xlTbbeq65D144hvg/Ejt7
	 ZMfDHoDA6cfUQo2UhIyIwnvWY207NlQFf1c3BY/mfni/I2Uk5mI5FKsk39Z8hYCMWVkMv
	 5QCEvPLQsDKCNYOd1+x4oNf5Glb2T0aeE6GrLwD+MSp2MbCOrGYrIdcJxI5o3JdlMQA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TrzRQXmu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793982434;
	bh=xVNYMNgn/r2A4KytiwivK1c9ChhbTCRlnlMYGiT2AxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RidiLC/uezk29vkDPISdFulfc8HQEi5f6V2OD2WYZShgOxvE/9ewR6cBGwPKSHcNN
	 Z3zbmWTB1Ej7JaKJnFM9JDPI+S/48jUyEyl3LPPFjiavVHROidECr+GnTZflR6DuIe
	 VOpeYsX8eoJUAA/O+CopiypMGHkvNFiQJhwlYB+BuLJj2cTnvAxMUWW+GGKHriO5S4
	 RjuSqs269/e5lxDTTgHShdcdzcUmttoHwbw/fmO3cX4vjKPBkHN272eA9MgDboQHeg
	 wPvV/OXzgFRjltac8U5/hjEg4pBUyF3Wq5sVi25V/xpkmMBT7ykBKZTMIBlm3wr1MS
	 rZxrWWJpvvc4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 860D5805AE;
	Fri,  6 Nov 2026 16:27:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E90CB32A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFA4E81C56
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBLUuCYBoiTp for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:27:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2094381C44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=TrzRQXmu
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2094381C44
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:11 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jLl244clVz8txp;
 Fri, 06 Nov 2026 17:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793982428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVNYMNgn/r2A4KytiwivK1c9ChhbTCRlnlMYGiT2AxI=;
 b=TrzRQXmut0HpKwqn9wlxcjHWdShrGcjyZognDUNLkv8a19x+lsc46iZkFcZitYrnky8hOm
 4ZfJ5oKXfCuSwTXElxg+SZVVt5/CP7DZo09ytafJzE9bIEBfHJe7+rwVRKTZ7nberP3jwN
 E9mFGNo2Yz3gisGgoBQ2W+X2WcH2jAjSo9L3WVwN88M4wiy1ScWKqAuxOCTRQ0nYOUjdKL
 nX7uCanJj4+xi/wpUWfIJEQtn4wJyWulavSn+UEBxEOCij18XZt5+7Kgq4Mt9Aw8qgmizL
 JMQ3WAUX/C+/xNGu/gInAxp5vOda9Ky5YirzToHChxRZVHs16KJu+IL2xOarxA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v4 3/3] board: qemu: arm/riscv: Probe watchdogs late
Date: Fri,  6 Nov 2026 17:27:04 +0100
Message-ID: <20261106162705.901372-3-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <f2b9184f9b2977824a978ff5a5e86f66b7c5010c.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
 <f2b9184f9b2977824a978ff5a5e86f66b7c5010c.1792320756.git.jan.kiszka@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: neoaqpcyzrpm6cq33hs5wqcujpr6r3ey
X-MBO-RS-ID: f98d63c9cff5825be1f
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

On 18.10.26 12:52, Jan Kiszka wrote:
> The only watchdog QEMU offers us on non-x86 virt platforms is the
> i6300esb. This one is PCI-attached, but watchdog probing will happen
> before PCI, so will miss it. Redo this late so that we gain autostart
> support.
>
> Deliberately limited to contemporary ARM and RISC-V.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
