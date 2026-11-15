Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31B606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hf2uRIJm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=c7IO2Jjp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F0926062C;
	Sun, 15 Nov 2026 22:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i36R_jEU-4Ua; Sun, 15 Nov 2026 22:18:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C83A6060E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794781132;
	b=jooP9qHX6SGqsCd2TuCPxBcriGBRywJlG3zdHZq56cn/HLVLY+17ygnKLq6sesltJaGZ
	 niAnPasSaApiD5hXTqEO+JgwpM585s57Zy4OqWfId/k6aPkqammvdsH5Y0cTTj0IZbPVN
	 jqFxJympTPyDQkWzL6IR/TWEYMIOfgMDZ2AphKyrizCaOukuZkKcJIGEeW42LGN2riIqq
	 oqgQw9uJOHtyHIv7PUBHEd2LUYKNj3bHCEgpbBzEBnJt30Cl4hRu/U6+m8T+PC83HQ/zA
	 iUSsge01zkjlYumF5aSLtuHyl4PpY9dkekevtTXWYqWG5dXNOF1b2GD9a6vusSmks0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794781132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8w9CNusd2X1h956As9pLP5bF81ax8ZnlSmlKy9OAW0c=;
	b=mzesM5Dw9bkfyTNJdpUTbjR6KQO8/QguAj3ikqueqbHUpHD+POFuFY25gT5Idl5k5j07
	 1fPJy1sSCt0mk/PFcMp1+RlGmqr59lZuVhOufPTar3ccGN/lFAL6hGsrfLn9bAFI4CQ7n
	 mBBvj7jFS8BiOidtnmSviwiCHJ8OsEfwYe1CyE1S7efECYpV3nr6yH+LDVXQFCBCeKBqa
	 PXDHx44WqDVZh35XtD3/LnTTG8/kLSNXOK02Z2HiIeOTNF9wE1EvVDifFlOcIxwRh8/ok
	 uK9VJEZrokOIR3SM31BsSctgFe1q4LCrwoCZWHVgJBw6XunOWAdIZTGiR7xOV7P+gkw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794781132;
	bh=8w9CNusd2X1h956As9pLP5bF81ax8ZnlSmlKy9OAW0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hf2uRIJm87dkR5SaiJ20gkeZ4S13RM7xLUoVO7jNMD9hGdll6JZg0QYvcnFDMu+vk
	 CKXk5hrERCEetvYqfw6A3l8bGc2/7ax9gU3bqpCql1p0U7Rkbj+/eT6lyrPGPL2Y9X
	 NeGrTcA2z6Kc4IJNeGNCfDtW7lujQJ8hk50WSJ6qZ17LVwYkntZdeMPDFZW28eiRlH
	 x5RLj9TU6cHK4LD8LJegpde1fdzVSdddseN72j2Hb5sxEZ0OVTK4+KbcCLFpuM4QQ2
	 xrdENrJOwe/LWYOiiCfxxe2u+kwqbD4fY5lqXlwJAJW+hHaPJYsG01KiRqYdGtxKlX
	 /ZcO5yl1Mpyog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C83A6060E;
	Sun, 15 Nov 2026 22:18:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D10BA1E7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 22:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF47E80C3F
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 22:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbNP6ewBNww3 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 22:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 713DF80C0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=c7IO2Jjp
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 713DF80C0C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 22:18:47 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=c7IO2JjpuYQF9HgT+4gQpen0Q4DWui7y9RbTCioL3ajWsFYlukOWdMJma+Fr1CURIsGZtS6/UflZan3I7jSdCFACypwZ03h8BiKvAB42eiyFSXlMjChc67aepMDA+lrtlzLZojTX0HErmGobqPo9oS4GhWesX+jIFTLnhsHGCe8=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=8w9CNusd2X1h956As9pLP5bF81ax8ZnlSmlKy9OAW0c=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794781099277219.74852312754103;
 Sun, 15 Nov 2026 23:18:19 +0100 (CET)
Date: Mon, 16 Nov 2026 00:18:18 +0200
From: Igor Velkov <iav@iav.lv>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH 21/30] sysreset: rockchip: Implement get_status() ops
Message-ID: <20261116-re-jonas-sysreset-rst-st@iav.lv>
In-Reply-To: <20260805174509.2968252-22-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
 <20260805174509.2968252-22-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On RK3399 (Kobol Helios64) CRU_GLB_RST_ST keeps its bits until a
power-on reset; nothing clears them. Watchdog resets followed by a
reboot left 0x11. As the bits only accumulate, a reboot followed by a
watchdog reset should read the same, which this order reports as
"RST". Writing ones clears it (0x1 became 0 after writing 0xffff).
Should the first stage read and clear it, and pass the value on?

Igor
