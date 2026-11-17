Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B25606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z2wOY84x;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=SBEZZLIu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69921605EF;
	Tue, 17 Nov 2026 09:02:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zb4TMfFq8Z-Y; Tue, 17 Nov 2026 09:02:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EF3760828
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794906139;
	b=HbF4yuBhKk2B++nf/AM3JBOceoyFxHh7Yit0az8mMlpbovrJo0+jFIwYZucYmxrX4T4p
	 BpIiO6nGqssMeRGniQ2q/iqZa9Mu097RESnF8EUpFbA6uX+5bocwLOil/HJsczqyC0ihj
	 MknqfL86XJZWz1EqsrZEt52Hfuw9lbw23JbzkSKGBKHLk2pdsxo6204R8FiPhcIGOh46a
	 vQq97NbGmG35qgjAFY5q3sAnpsqNxYHSwUfYhh2U+qCl9CoM/gdcQok3oRuaVOF2+UHrC
	 NgbHSdPo/awr90XMmOhjdYHvdlxYgluYNwX5POOOupAqWEkhNZmmXGPgmCzOkhQk0OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794906139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jE6g5w03ebUtjN413hKSTLyyrlXuTHE8GUe2kknBuho=;
	b=cbK+90Aj06lvK0MgBssI8uZ6TyCny7z7U+Rntp9zuiJsQOtnT/SRNnqIKXicm1NPEfa7
	 xOJ3HQaMXTCU6mMB9e+ovTbob34zn3DAc+Pbj32+6xd4FsEmZD3Wc+QZ8tKUQjxj30fJm
	 VUYkmp9tgXj6/Ext2Y/ke39hPvul/1RrycQyf0PgnCpdHBnmqQbddTgrEVDjOsA2/SkxU
	 fRNBlwizv7q8nHx7X7Hl7JEYA0dAGLsxrD8DLfuwfAhi69Dbtu4dJB8voJ/DdRhxeQShv
	 OQ8J8P2pY8kGYRldEZk6kT3XsKEplyQM/mDWmDawlTlzPGlKUhLCd1VDYlZtXRT9gNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794906139;
	bh=jE6g5w03ebUtjN413hKSTLyyrlXuTHE8GUe2kknBuho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z2wOY84xvnoc6bpzPXSBgtqvNHxEkTnDZCpKUbC99Gnqa9mZQ7jCv3LUYN+P1J1e4
	 ZoDImsKIXMAIC9PC/eSzJextuw7s0acg6nwQ425rYW2vF3nztxPA2CSmG6ShGM3X8g
	 L28PoNtJ8kv4uAhM37rVuJExj+pbrpXZBHCNk/EGsgK6UNoyY3FAE3WizocGc5ru9p
	 PK21BRZ2/Z9dk7ludTwRoGt+kNey3ryeZs+FvQBYF+667PEZ52BJ0MmV5Eg8HDteYe
	 FrFafCRqjlXULm0uGpndRajkNIWj/qSKMBBoXPJB2zqDWq8RJPvC+MSmxwSjnc0jKv
	 AqC/12XW74+uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EF3760828;
	Tue, 17 Nov 2026 09:02:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37011A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C75F80F87
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:02:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_Bz_biby8sG for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:02:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84EE280DCA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=SBEZZLIu
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84EE280DCA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:02:13 +0000 (UTC)
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id BA5121F91B;
 Tue, 17 Nov 2026 10:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794906130;
 bh=jE6g5w03ebUtjN413hKSTLyyrlXuTHE8GUe2kknBuho=; h=From:To:Subject;
 b=SBEZZLIuGXoHDkdGoozJZQlB0kWFzQ1AzD29S8FXRHQwrPaImS2uqQFYyVOrwQW9A
 TDaSLIAFac337fmZ6mxT+tDHIbdytF8RMBAQWvypUx99N5S+e8qwY8CR+g91Um4qVj
 JwmhZ7sGNJLbiEHp44jamxCGDvfq3kM25emFn9uX8D5Bo/68/GW1M5WiDKNXGm6b4+
 cOv70emljP7J8r3/LQAPRqxuqGBOF5RofL311D6o6rmzlKrsDvUE5KlJ4kXbzFgGeE
 W3/aWJbyIXGDfsMgbAVkaHr4XqedfOb87cuqMhEAJOFAS0sIYfJGrTVCibrE1xe8Bv
 7pm2JFd0mhhmg==
Date: Tue, 17 Nov 2026 10:02:05 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 1/3] board: toradex: verdin-imx8mm: remove
 CFG_SYS_UBOOT_BASE
Message-ID: <20261117090205.GA266497@francesco-nb>
References: <20261116125622.174214-1-francesco@dolcini.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116125622.174214-1-francesco@dolcini.it>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Fabio,

On Mon, Nov 16, 2026 at 01:56:18PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> CFG_SYS_UBOOT_BASE is only used by the SPL NOR/XIP boot code, which is
> not enabled on Verdin iMX8M Mini, and the module has no NOR flash.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

I did a small mess sending this series (it's not threaded as it should),
if this is confusing your tooling, or patchwork, just let me know so I
can resend it.

Francesco

