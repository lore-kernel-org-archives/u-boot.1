Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC7606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p8kdoare;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bBqDG2uq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 007E460725;
	Mon,  9 Nov 2026 07:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRVpIcLD_N3A; Mon,  9 Nov 2026 07:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 494DA60716
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794210654;
	b=hwPEE8Mwks31LUgYsqp5PZVYe05R6PvClw7NKqujy9X6sZ7tJO5pqANUGERsn3AB3Pjd
	 1KHFZPL14ty1Qo/0o+p8I/ujpfIaA9UGNwTqKTVOwOdwyiWkYKExwBFQXY7vzZBNcYpes
	 9oaACPrYC5Q3TWuTu8xPcqKrayVTHpEcLXDxX8bQjdWTu3bJFzzWa0Jr4jh6K2WLycTtA
	 k45BFI9pga8OYe+L678zLGG8VyyEhqUlvBS/syPCC4TesBsp/gsIJ991LguTicsrDSccw
	 JRI49MCAfYiixJv+baBYrgIJqYypxSb4wgyLJuI4p24RmnKwTqEYg0P3pli0MkiXpVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794210654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DUqYEOUrkrVt/uzqL3SsUVmalp/DpfBbrSSrr/ACOO0=;
	b=MS095wp/DwgfwFxclCBz0RuPqohSp/wddv9+WG3l5gVtg7IL2BAz2XebP4PvEfK1Gd/A
	 Nd8ui+YCiopIDt7/otlYq+t5X8X4NQ4iM2SmAT4QCIGGfSdzMnpskQKfuyNCNK3jF0gjg
	 hNEoNTYk7goTTWaIZuqip00HOPTQlDuFv7VOrouQbe1wRXAvEyWlRJfLX19GoDVJBk+Wd
	 HlS+4/M5pIlp8TP835aY55h47O+/206XlMd+ViA+T2afLCbUs0Hf54G7JsqBUtNGDyH6w
	 GCVizDmoQlCL6nQsD/YJAS6Co1gsyB4OId47rZ8oYq8egTDYeaVbc6Mv3TQljcGKaJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bBqDG2uq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794210654;
	bh=DUqYEOUrkrVt/uzqL3SsUVmalp/DpfBbrSSrr/ACOO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8kdoareUupcXIe5B5dEFKEDJUSUVUWObidBjEIaX8ZXPRtyyCvEh32Sn9TMwB2JI
	 4kiReO2PHDmBlikpyxCxqWdZSi1oybga0XzDTVI2nIRcFKM9q3atv00muPLUZlsF5H
	 V4++T6oVw+73OR3dpmB7UhGRYBcUfzCBcj9VyfgJIsnLjrFagNHqx9sgGhKQggyMgq
	 ugb7BK7rz4ZGZMXEdnQ6HJqqmn5Ca9p4uNVH4HcsbUPxwyyO2Wyfmr0SWuv8Zz/glr
	 LWbboUYfeHfZ6w/hWnHaWLJxRjYSVVZqs8Zbz9yXS4NCqtjayUuyjCX4ss0zDZ5b6O
	 zNVJ4OauGwZcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 494DA60716;
	Mon,  9 Nov 2026 07:50:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE1102AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9402D60716
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1vyttJWhlht for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 07:50:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 462216061D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=bBqDG2uq
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 462216061D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:50:50 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jNMQv2lDlzMl1M;
 Mon, 09 Nov 2026 08:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794210647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUqYEOUrkrVt/uzqL3SsUVmalp/DpfBbrSSrr/ACOO0=;
 b=bBqDG2uqLIZ9XlTfqatbTkb0RfML2PZdlrCJX1cotcnixexHzFcrbv8VVru2FMmpLDcrue
 7NiGMg9XqoPooqz3NmZXUMF34GHrOLxJTteqLeWJshE9bBkhLIpqbYAAbmD0A9EgdY83la
 AeW1oTwibBiwfUkfR1eMK6YWj2cI6HFU6d/SPk7+UNNFqchTl6GcaBp6UagJGt7wpZUTpl
 EARHlQyHdT9CN8x8blNb/noDf4Kj4/1JMraS0k6Z1vckSRJm0FijE7RUqxPXtlWv8cKJRQ
 mJuWxEM8oXWKcKe4KaYY1vKuC7h7IY36BV4p5WVvUDMb3nbdom6HMnDmtxhLOA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov <iav@iav.lv>
Cc: Dennis Gilmore <dgilmore@redhat.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] arm: mvebu: helios4: derive MAC address from SPI NOR
 unique ID
Date: Mon,  9 Nov 2026 08:50:44 +0100
Message-ID: <20261109075046.1627828-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011-helios4-flash-uid-mac-v1-1-203cd429f46c@iav.lv>
References: <20261011-helios4-flash-uid-mac-v1-1-203cd429f46c@iav.lv>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jbt4w7te96ynxyfy6sd5g6p33dxikduh
X-MBO-RS-ID: af634e2de3c6545ac9c
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

Hi Igor,

On 11.10.26 07:17, Igor Velkov wrote:
> Helios4 has no factory MAC address, so without a saved eth1addr it
> gets a random one on every boot. Derive a stable, locally administered
> address from the SHA-256 of the 64-bit unique ID of the SPI NOR on the
> SoM, the way rockchip_setup_macaddr() does with the CPU ID. A saved
> eth1addr still takes precedence.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
