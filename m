Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549ECC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D701B60603;
	Thu, 20 Aug 2026 03:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1TQbjMe8okZ; Thu, 20 Aug 2026 03:55:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787198124;
	bh=o98TEGI4770mziuJLLjrETAbPRJMLyLJbtYXZ2pFqjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chhT0S770MxsxIkxqbeUydsCiAfTMeTo9Plpi0CX1il8rbZUi5ytZZj+jQYuut2dv
	 YqFx8OnDX5K0SjuM9gnLV1tMI4hlgNfhWJ/3deE2SrcSuBcw7izbxkA+qrKyKlyEbu
	 QItnM5cdfqsISDKgmSP74QF+8xuaWn9QE2kZWOdqM1O1ddDKPWMQHZwqLwlFv06cji
	 tH5bDcUh849+aljMPkjRTBfB7qH1oJRFg9rGllUyllJBUOtex5yH21hTkqArsxGOL4
	 RMSKSLPsmG8C7n4QDRe6cp201hUKxaGkykiuNxM+qP8ZZpwZnJscWUwn/KU4rxffT3
	 7DT3nJmb0LRsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DA466060E;
	Thu, 20 Aug 2026 03:55:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DAFF323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63BCD403C4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbKxNXwJVVhH for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 03:55:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=ooKTyqAe; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vSPQR1x4
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71748403A9
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:20 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hQV2Z1wS6zKvtn;
 Thu, 20 Aug 2026 05:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787198118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o98TEGI4770mziuJLLjrETAbPRJMLyLJbtYXZ2pFqjc=;
 b=ooKTyqAexlKGaLda4LlBN4gbACwzm4odr2tpEgLvlTVUYXtLXIs4FG6IqAkKutg7QrDtnP
 6ogSO2XLBK8hDu+ArEcF2sO3LBlYYdhQWeGtZ7jNm5qKIgxomcoWXs40bO1r114DoYGnkJ
 xA6QN1zQvgGL0DiMP98y9lBTqCwxwTz13B5r9XW8QPK5AnaDrOkcUsj6IruLGYoLzJMGAB
 Nbd2Na7Vt/6D3ffrPtxXOqELdMPqzF17/QtYE4Sd2PmRys9KUzj/wZ6cStv64t2cbk9Vbn
 yU2qGu0bP2VRRVEZdYwGLASMt6Vm70P+1DZ5fYpeJCjZabRayBRnF7J6IHxaaA==
Message-ID: <71b7897e-b11d-4f9c-b3c0-e7eb23e26bae@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787198116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o98TEGI4770mziuJLLjrETAbPRJMLyLJbtYXZ2pFqjc=;
 b=vSPQR1x44DQ8pjbCkCjH+e81EdKbwdMOaHpit6emZ+UruMSszA4JW9NXzEJYvEIICTj/9W
 18R1oAU8xiMJhYPxzquLlkd3ofJ6Cneky6ypoD2p+YyUQjc7/hsk0WO1mE7lWj51IrliMx
 ynnFIr+Xnl8NaC93oHjxRETVbmabMsXXDd4iIRipeoAFJbivT7AFbo1r8lZPMAxRbcVAqD
 2vjTHf+CPS+ZShLurWIfXgyyCRUzyMq33UAGvg0eKJOoNTC06ravjGJjYfL5KB8vwmWm1t
 8zhpvU9DrxHa8FQmOSqDk1qs98bBm1PJCG5gY6oqlwkaxo328kLVCUUw/Fbc9Q==
Date: Wed, 19 Aug 2026 12:08:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] usb: ehci-vf: remove the code path for a build
 without DM_USB
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20260819093705.4143509-1-mehmet.fide@gmail.com>
 <20260819093705.4143509-2-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260819093705.4143509-2-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: dktn8xmttgyhnrnkhax6dkmgfssk1uua
X-MBO-RS-ID: d1c20e734b439156c11
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

On 8/19/26 11:37 AM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> USB_EHCI_HCD selects DM_USB, so the !CONFIG_IS_ENABLED(DM_USB) branch of
> this driver can never be selected. It also cannot compile: ehci_hcd_init()
> calls ehci_vf_common_init() with one argument while the function takes
> two, so the branch has been dead since the controller was added as a
> second parameter.
> 
> Remove it, together with the board_usb_phy_mode() hook that no board
> implements and nothing else calls.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Could you please double-check that this is not used in SPL without DM_USB ?
