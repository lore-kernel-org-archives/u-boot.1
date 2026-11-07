Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CB606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wQZU+wAg;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=iKUb6Igw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8058B80F3E;
	Sat,  7 Nov 2026 10:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OG6fh9e76gYO; Sat,  7 Nov 2026 10:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1AE080F4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794045899;
	b=SJ7BkC0GcgWUZkhW4pWbbB858gRUXjpYNcnI7YuRWJPdHluGg7RWrSx1+OI25lBX3fvE
	 rhR2gSAEgQxzrjF7WtXNGJ0dGBRJKgIPXOqvx6XDpfrFSdEp1iHDlOLxm8oybuF35il/T
	 MaRBXcpjN6XG8Ky/axuYL5k3dcBT6syRnvfqEiHH2O43acGSVZlzfpmAJ5WnkZezbzcT/
	 ksk7VbTt3pA1Sxm/Kn/Q2I9DHgKpgZ90A9Hgn3ZqpWbNabbvV12rqpaVONXBUe9RUTWw9
	 9cJF2zVxKuvBUasESPkZoDvIcIiRDRYZ3FN0fPvscUI++b1WM6CttAFeYa+0gtmi94g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794045899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gjjr41M5N/1/5QSsFjh60dCfHhmO867dmK44UiGQePg=;
	b=iWatb6feswpMQWKNrZhBp0pguTv353QPbZukiwCpAJRokM5BVc0l/gW6bPkNYmCzUYi5
	 dXe/O0Ps8aEkd/Wt6yf7XNH30M4ismD2fDU3vBkTiFlxEscdbjdeB9fGo8R38yBFEjHB/
	 vxmiVWvDDWwD+AVhueUkD0lmColUEtB8lLxdiS3uSwCSx0+gF2e+DlUUUvIWU9MiWCLww
	 vL5Sh/xKMDDRmTXD8uxD73QuFRe1NPlBwqAE173e8VwlpZGABsOB2TLcfKOwDv0F5M/Hv
	 V3ir3O4Ndmyv+nv4U3xZ8GKKbj5h3FxRlbhehi12qtsF/+puffje2bcdCtB0MQb+4PA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794045899;
	bh=gjjr41M5N/1/5QSsFjh60dCfHhmO867dmK44UiGQePg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wQZU+wAgGnyZ+PH6hmY+VSk8nn7PIt9ymqy8MBwcF/S41S/MK4uozr3DcuBF+3dot
	 ySft97KV1AVJ5Os7AlvlvGf8JuRa1/3e7RszFnxqeXTBpcL3TF1etOExZBhe4eZwic
	 sC8NSTxWDCffC2pz5ZRGq13IWgSx8Rf6aST8tWt8NHSihsJxySFGTpAb8KoAKaxdZ8
	 +0isaxeuhAs5iYooAlO7pNJP4rassPnBvUeAWMmwkQR3wFXrggt6euukBP8tGYYCrX
	 4DG+JlQJOC5WGCvNDSd4Bg4CGw6SjuY4w0Li52Nq/NNxZymK6K+wQKCnDU3Nqk2KhM
	 pOS2nQzH66Ldw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1AE080F4D;
	Sat,  7 Nov 2026 10:04:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83F0D2FE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7566F606C0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKuxfzrX-BbW for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 10:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C6C5606AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=iKUb6Igw
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C6C5606AA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 10:04:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jMBVT1jlNzKm7S;
 Sat, 07 Nov 2026 11:04:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794045889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjjr41M5N/1/5QSsFjh60dCfHhmO867dmK44UiGQePg=;
 b=iKUb6IgwmmYDwrwHiPEly/B2Qm0PW8KA+BgUhvEBd3Th0kaAJvRXcI7AMxFCDJOBJi4pno
 ndZteM3sAAYwkHm7sa6JOOqzJ/H/Vh2GEW3Ez5o8yJK5mz6FiAQLwZb1a+0SrEsWk00HVk
 v7XkkDFnc9T2jGK6qt+N7pYEF30doK83zafWg9cpx02/2XyA3mDbi5rO66PdL6lVoTHwSA
 5frrsc4ILaPFzTwasUprj4orunoqgXgr0m3KhQQBK6GZE7p+0i21dZqUvdTm5HPZO6rbBv
 4sjeJoHhDwjh7z/+nAntbcW8RXWr9shzKajme6/eYfvHlLw5fx2veuzBzfGdwg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>, Tom Rini <trini@konsulko.com>,
 Aaron Williams <awilliams@marvell.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] ata: ahci_generic: pass the AHCI device to
 board_ahci_enable()
Date: Sat,  7 Nov 2026 11:04:45 +0100
Message-ID: <20261107100447.2091502-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003-ahci-mvebu-windows-v1-1-e382f73fc299@iav.lv>
References: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
 <20261003-ahci-mvebu-windows-v1-1-e382f73fc299@iav.lv>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: koqcu8ndfpnce58nd5wcag5u9a1zwr9h
X-MBO-RS-ID: fd05c3bcc8e69f8931b
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/3/26 07:36, Igor Velkov wrote:

> From: Igor Velkov <iav@iav.lv>
>
> The generic AHCI driver calls board_ahci_enable() before it probes each
> controller, but does not tell it which one. Board code that sets up a
> controller can only use a fixed address, as the Armada 38x code does
> with the address of its first controller.
>
> Pass the device being probed and declare the function in ahci.h. The
> existing implementations do not use the argument yet.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Applied to u-boot-marvell/main

Thanks,
Stefan
