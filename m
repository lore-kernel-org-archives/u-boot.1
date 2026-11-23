Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A182606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BlMBjllE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=UEnRGHOQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D14BA405CD;
	Mon, 23 Nov 2026 06:29:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WieiXf4QlxUW; Mon, 23 Nov 2026 06:29:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A979240585
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795415387;
	b=BzDXETXaxxd6bfQsPZyPdgKM4dH3K0d3bqLstFNw/aESSG6Oh/DT8vHgNZVQ9k5BGZSH
	 BqCrs7U0kpbEITcvU+LWHJwfSqwBJoF/rd+R5ZeRvOu6DZD16sXRluFv41W0DfUDFgytz
	 CRDG5f9rOaje/nRpmEt1KSVsMpeq1FjPhUilVMbwlabv9DZhJWmfOnkN3BBzLRMve44xV
	 7eirnFi3C0JZpic/NInQy/kCFB9HtMpyLTx0S5DxlQIsIGfGHpl366c9s3PaD+o42xwwj
	 9s8JUVMAgEcNfYN5GAgiAEkEvNfLjqiV+RgZ02senyWoaziXP6BqOL4OdgrwiCp549w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795415387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sJamhqzbgIg3wCdrdWOkHWJ6ggxKxESeuODyNxl81c4=;
	b=lohwpYkaMObBgG1NzVCqrafLJQbZnih6czbK3uh/yTNbwHJ1TO1RWKkK7kRtTbVCl8M7
	 UBdmjVWNKUfesFgXF0En/t1uAZ4fQia9sGGIMazPAhVZweWBZHRaoMmqbAwFF2K6rEUBT
	 6Cn4gbWk8bLV/iY86hIk/JverAiYLTtAj1I+RC0/zIXqMtFpxsrb+2OLrenwriN8s2PQn
	 j2qFomRicafwTKrZXmlxZ4UaqIDV4eSSGVOiTBP9BPTJZP3kx0iBRf+i36FTc1+9kBuIJ
	 YPPBOI26hd/FL/S4FIykniK/N6+tRZc96OpuB4AayDsQ1s4hxiyHHvWRmzvLZj0rlUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795415387;
	bh=sJamhqzbgIg3wCdrdWOkHWJ6ggxKxESeuODyNxl81c4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BlMBjllEsNxlewdFM3HaXznZp2q2IMsNAgSEm+ZrZK7SXlGgnODTlg0bd8nWtePEZ
	 rU4w7W10XNrywzToRNAItt4UJo9IGQDsSUWstCKHzUn2h7n3+9YP/32hdLB4dZ5nV8
	 4lkYrizdX4Cv65MEQi+bPBm1olVStMUvjC0dqgB2ENXhcaCUj7X/BIq9sdkPHQonoh
	 hEhiBUFMeMfLz6810SuEfPXRF0T0wEkCCWhln6RKfPmfrNTkQWgBb06UDUmjn016yR
	 L9+22lr7sq3dMSJ8onG0U81kKjjRVFVGn/vMkNtIUl9OVZS3JZr1FzEd5ONk2/jgw6
	 IBbaE9hnl942g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A979240585;
	Mon, 23 Nov 2026 06:29:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CD03B499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEE3F6068D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKsnypBRZNO9 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 06:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7B2260697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=UEnRGHOQ
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7B2260697
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:29:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=UEnRGHOQWQkVG7v68NuO9cjuUGihZhnwofgvj6/mM1yEYKrQtx5/6OSI7b/c1YgZiiyKpIXxTFbxX5LXbrzIjs0e9l7pXX5Q02yaXWbTJy9RYppYbRyl2uk6ul7aBd/jBGW8CQJcwt4cDNceLI3NxMWKFvb2v50/RkH5UNo/2pI=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=sJamhqzbgIg3wCdrdWOkHWJ6ggxKxESeuODyNxl81c4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795415357587276.9666602125495;
 Mon, 23 Nov 2026 07:29:17 +0100 (CET)
Date: Mon, 23 Nov 2026 08:29:16 +0200
From: Igor Velkov <iav@iav.lv>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Christopher Obbard <chris.obbard@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] rockchip: rk3399-rock-pi-4: Enable IO-domain driver in SPL
Message-ID: <20261123-ping-quentin-rockpi4-spl-iodomain@iav.lv>
In-Reply-To: <20261103-b4-rock-pi-4-spl-iodomain-v1-1-8dfc34a5e2e2@iav.lv>
References: <20261103-b4-rock-pi-4-spl-iodomain-v1-1-8dfc34a5e2e2@iav.lv>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Gentle ping: this fixes reading the SD card after a warm reset; is it fine for 2027.01?

Igor
