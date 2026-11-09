Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818B606A322
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t0zW/3x+;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=We6YvKp/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 530986076D;
	Mon,  9 Nov 2026 13:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8reD8NtcaCS; Mon,  9 Nov 2026 13:18:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80AE860703
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794230332;
	b=op6VLCL4HdDB02jCnE1nIbGjSmbrAU/tu/xgfjugH80r/65rm9CVNcITMq4RLbqHKMVl
	 +YYcIXyKbIZar3P+F++XFVVKxH5DJWjm+F6B8eVhLYgj7q9FIr9azbh6f74sPEjyG3jr4
	 ZbDHOyt8g0YVncdUTMKj7yLUPrUcJeyg7fnlsYdDNgangaTYRN44H0p5vDbiAka4YM0a/
	 2w9R236MrlbwbOmn7tCtHPW8fYYcDwG4duSPFhJAEIkuVlalO50mF1MtHnOSLaxftjHoe
	 EHiaw4uXUz2UrLKvGlY8gubEoZLmUrNunpHtuSM+lmRTpzkzEn2Yjk33zrNCCx0ukqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o1DNgLvQmFAq/Fks6uTGeL+6Z3B1zhsR/IkpliwHv0M=;
	b=hARF+28F8YCfBUY7UlbMaA9ZKOpVNjqHQ5nxuMLuAzytdMlIPf1DGdzOsY1h1ZfX3RlP
	 72cf3losxG3HUbRwWPb2SwLPSnPKD5bB3qxxqljJIkIw3xeBhSSkcZQTvKmVukwrtZeIA
	 xodwVsiAmFudMD4pcedWG1cvYEjrglyL3EWVv65gN30QRTBGvnpRVoGQUvXbNYcJ0lq7M
	 oKaHvjauBhrQWAOanrDEzHE7194wzDmNorDPuGJsyy9gOKoBrkOZKfxsZsbtIgPGrqkYl
	 L9TjVyct0QiVcdyI9CeJ7D/7XwM8Pv7hdAHx2/+hR2p6ysHRhY5+Sfj7OtuF+TRZ6CA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794230332;
	bh=o1DNgLvQmFAq/Fks6uTGeL+6Z3B1zhsR/IkpliwHv0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t0zW/3x+CO/0rCn183ZjJ0GXf+32/4f/+2wOb5CcixjTCO3nyto6L+p1t5Hj+/79S
	 XffeFIU5fuLICpwPZVuzuAQ3SdG8Jton4VrxVGq9QB+Es7Ly9mSpx+VCdk4+y2EWYS
	 sAafjiinzTqu6CHxR06F16WQwsvyL6Omha0XAgfp6VXsweH/3WMi8+GvUu5MFwYPFP
	 7UyRzHCMniSJyhisGD/wFvovq67zx3hyWmEKY7BmTZ9j6j/nxiD3VyEJ46ws4/bB73
	 ivIWJ1CvC/JXMh4FRvv9ifurDRYwQejs/M4NUnRpeECRepjGwu9AWkLrh6ZR+oYCRb
	 iAibiMgSWpSRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80AE860703;
	Mon,  9 Nov 2026 13:18:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 685F8111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59F71400CB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3FIWNE0YmlR for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 13:18:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5E974400BE
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=We6YvKp/
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E974400BE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:18:49 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jNVjJ1PVGzKn9r;
 Mon, 09 Nov 2026 14:18:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794230324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1DNgLvQmFAq/Fks6uTGeL+6Z3B1zhsR/IkpliwHv0M=;
 b=We6YvKp/Uh8VvSOcooJtpjfI4vLaCZzFMTaK2dU8n61jjjQxvOSA/Wo0CDlbmkaBi9k4TY
 aA7OoYy8KmNOKSGp7pbK55Mw0OgvOwr6iyx/3Ht0ruVJxIPz55Bhs4aqIA2tfNvOUZRXVf
 FgkHu7VCGiSgD+7l5GCDJ0zSDqUg8Sn0vMJ6/hPk0RxSYvUH52rdv1VItsiHvoeB4Bk/tk
 +yQFmHlFe5OuN6/hrF9ktsr1mBZXscYIlxvqMW97TYA1jJmivm055+a8UEM1oerLp9PuOC
 Vdz9gGZTdbkaGajKovYWMNZz0RXdL0staY0rgz9sTkYJqsls2FZ7WowaTAAR2g==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>,
	Dennis Gilmore <dgilmore@redhat.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] arm: mvebu: helios4: derive MAC address from SPI NOR
 unique ID
Date: Mon,  9 Nov 2026 14:18:42 +0100
Message-ID: <20261109131843.2032271-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011-helios4-flash-uid-mac-v1-1-203cd429f46c@iav.lv>
References: <20261011-helios4-flash-uid-mac-v1-1-203cd429f46c@iav.lv>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6itphrckab36s94emw8wpq37cmgpinse
X-MBO-RS-ID: a1ab5b9365defe06982
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

On 10/11/26 05:17, Igor Velkov wrote:

> From: Igor Velkov <iav@iav.lv>
>
> Helios4 has no factory MAC address, so without a saved eth1addr it
> gets a random one on every boot. Derive a stable, locally administered
> address from the SHA-256 of the 64-bit unique ID of the SPI NOR on the
> SoM, the way rockchip_setup_macaddr() does with the CPU ID. A saved
> eth1addr still takes precedence.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Applied to u-boot-marvell/main

Thanks,
Stefan
