Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7672CC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 06:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A75A6071E;
	Fri, 31 Jul 2026 06:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id diIm4dw6axhE; Fri, 31 Jul 2026 06:35:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8357F60789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785479731;
	bh=8mTcIWd0WjmWjP0xYDObSeuqoha3eeYAiSjEKXkMxNw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ramLcA2SXfMc522Iy9UNGW+V1XlDXFxhA0xK9l/Sr5kclRFYN4CaPF60D9MLCxdaa
	 nTtPjLPkjpdAIqUAyKbgjuwOBXZtrkPyqbY4J0XdMdUKtVwbR3F/ozgNj/76yF75Wk
	 SI6OlrtfnZKo/irTgvXTAXsQ2PpnD+BgEzI7R2QTsecA8ZYiGY386Aogz5OdfCxDPk
	 HlS5EevIQFZlOOGzU4IklI0mveRjWKbTfvY8lYO9TaloJgYsa3vz/EAHHUaAthbWNn
	 t5IeqssBG3gbSYd9nqQlBgl+5zaelV5C8uiBYEFdK+bpZXRTc8XzclqqtKq4xBhPzH
	 uBiTd2SFk4hZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8357F60789;
	Fri, 31 Jul 2026 06:35:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A49C69
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C0EE4015E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QeRBpeQxzhaF for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 06:35:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 63A9240063
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63A9240063
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63A9240063
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:26 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hBGXV6g4gz8v2G;
 Fri, 31 Jul 2026 08:35:22 +0200 (CEST)
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] arm: mvebu: Update docs for Allied Telesis x220
Date: Fri, 31 Jul 2026 08:35:15 +0200
Message-ID: <20260731063518.1915237-3-stefan.roese@mailbox.org>
In-Reply-To: <20260705015054.2534191-1-judge.packham@gmail.com>
References: <20260705015054.2534191-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 78378a5ee628bc18a39
X-MBO-RS-META: pfcqptupo37rmj4hpiw1uhocxe1wo6wa
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785479722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mTcIWd0WjmWjP0xYDObSeuqoha3eeYAiSjEKXkMxNw=;
 b=ysgTJltChmQIlcwmjC7YI51ClgtxtKTRvY/Xc6GgUehX1H0xFN4qcOM3KsaKkUwd9/rdxd
 z2AQ+5Vqw3xJMqFhTOw+8+QzbrpkR9I7UE2p8h6wLIHjIRmwWt/UYv9xCghZEE0vfukyr1
 HpgwvyY1UPeIkqElgxrI8fQcgAPwkQiTzLungrFXkUNcXZPD8NKyQUSZq17pu1gLoaW+hu
 DsXBJeebchRfzRP/Kz4ASzQjtdI9Iu7H51YE1Gsa5cKXBNzCmctjFJ9IItb3HKUAYO5DhF
 9uYnDf/M7askjNpIq3Di3wT+GH+zZ8eIULTW/El39kapnyUXOFjiHopj4E4LrQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ysgTJltC
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/5/26 13:50, Chris Packham wrote:

> The current documentation doesn't work as-is for extracting the DDR
> training binary from the vendor bootloader. There are some seemingly
> undocumented alignment requirements that we need to meet by padding the
> binary file. Add some instructions on how to do this with objcopy. Also
> fix a minor spelling mistake while we're here.
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot-marvell/main

Thanks,
Stefan
