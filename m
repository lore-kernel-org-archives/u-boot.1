Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF400C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 599EF4058E;
	Thu, 20 Aug 2026 09:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFZiQ1gah_CR; Thu, 20 Aug 2026 09:11:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787217116;
	bh=y+xXLZXNGFng8VsCXVebZKOUVwdpiEV0ITEcSdCH7ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJgtQ3NvsDszB+6taMKhB2v4oguWNdasvb6jVRRFpgYzCKDik8xYK0vWAuA5j4ZnV
	 pfanvc4WuTwZjUtiSn+Vhmwhjan2kidYsqQq73wNQvpufvWK1vTYDC4qtGPU2TkX6l
	 RdArELcH9PYqayvcfpwgogz/RjGTS49OS+BTpRZjSn86XS6HvzjfN0Mvqv7YK/zoxp
	 vMZa/pkGQ0iD2C9MX8lhwVmJaQmkIr+splGTqjjgOHSk6NyxsIqbZ5mCoQM1JagwSU
	 3Fz6GRFPn5KPSwXnvk5Z87WEWlWEv+JEd+hiYMPMoNwAFjUaS88kFDhg9i1MDhDkQz
	 i8mcw2lDAM7iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C00EE4058A;
	Thu, 20 Aug 2026 09:11:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58E671460
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F465605EA
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w7ZE5nAiAGrL for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:11:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=un8Lycgl; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=JRZmqLS0
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 771D9605C7
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:11:53 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hQd3q1RyGzMlFV;
 Thu, 20 Aug 2026 11:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787217111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+xXLZXNGFng8VsCXVebZKOUVwdpiEV0ITEcSdCH7ec=;
 b=un8Lycgl6mqehj789SQhixct4kPFQ0NS0+mK3glDHBi3/VGpbk9tIsbky3dAgxEWdUaiKG
 V2DjCObWHwLORWZcrUQJo3kIloT0DuXkiD34MsvUuQhi/ByxGG6myEoXGgt14ic9rS12Vu
 AXU13nYfHEp7FQOzhTCeVAKnOOcmaw/3pQ29pf9QQ3fky5vATAT2yIFBwzc7zBeAPP8wx5
 Mqt8jzKBnuqx3uJwK0v4vavBmAb6xN27MFcyZ/PVqPqgH419fTzSQJDjzr1IbpHQTfMQhN
 ioknKUaiiOiZg6ZBk3uKnlMXgC40kASciCsjxxmV8Tm0+CCaVDX0ib9YXGsdgw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JRZmqLS0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <f1018cf1-fc5f-40e1-9951-73f3ca07a5ec@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787217109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+xXLZXNGFng8VsCXVebZKOUVwdpiEV0ITEcSdCH7ec=;
 b=JRZmqLS0PzjF2XGuzy1SyXRyISxRfqDJoToc9BhS9iUuS1P0zOPWPGKWWK4p3/u9Y2e+Zy
 tGkiB0CLkYjptImfPtvo2tiFEVbd6f98LZJlUt1hU9hMJRNFbJGAX6eN/TqtHvEUVUjqFP
 B8OdkG8vzGV79wpXvomSAughTyyBFeXkdYKoJclu64fn40mhsRXBL4uabMpTYey3P/O0/5
 xId199iB6beIeKaEi6PqFf4lLi+8wzpcb6jefNjugcPDSrSTzGrUBblcUHyMCecfDDU7ts
 LFpN4yt/LM8XZ4vH/qhtdjV6CMPNTc0cb3AeMHYY+zjL0Isj7Rshotupky8pzQ==
Date: Thu, 20 Aug 2026 10:22:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] usb: ehci-vf: enable the vbus supply of the port
To: Mehmet Fide <mehmet.fide@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20260820071536.1036898-1-mehmet.fide@gmail.com>
 <20260820071536.1036898-3-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260820071536.1036898-3-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: edc9c68b3d2db36ed5a
X-MBO-RS-META: 9osuokfw837n3ddz4uxec8k3jxdct3bp
X-Rspamd-Queue-Id: 4hQd3q1RyGzMlFV
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

On 8/20/26 9:15 AM, Mehmet Fide wrote:

[...]

> @@ -284,6 +293,11 @@ static int ehci_usb_probe(struct udevice *dev)
>   	struct ehci_hcor *hcor;
>   	int ret;
>   
> +	ret = device_get_supply_regulator(dev, "vbus-supply",
> +					  &priv->vbus_supply);
> +	if (ret)
> +		debug("%s: no vbus supply\n", dev->name);
What happens if this returns -ENOMEM , is such an error safe to ignore too ?
