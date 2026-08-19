Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC4DC5DF8A
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB23D606A2;
	Thu, 20 Aug 2026 03:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KH9VhUhygb2g; Thu, 20 Aug 2026 03:55:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787198145;
	bh=c/axpfusuUqpRhU+ByCtZl3DhyIpCN2/ddqLKt9kCTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N8kWRYhoPOqqnjIdeaLdeKPSOPiGZTsqrqIIRIxDV+kRFiQqvbnl+lvtXACu+v4LR
	 2pfSRVQ5GTH2Udv071ZQcvimb4msQeAu7y/DLmlCfpyXCJm3ZlKrahZWj5MsD0rY4K
	 4nvWwQQ3p5dTcpQW50N6VzaJbDiIFppKBe2jh3WcLMLux+T5FdzRQ0LgLdgUiHCLak
	 Ngc9/4ki2OWPlBTw+j4BzZugx8aqWvUQN23NdpueDXit4kWglClN0Tuz/QhrS+kl2y
	 ofiOFWrSesxlhyofenUbO2ZQarWS+AXnW8GyVANkv6gmiFP5XWK6mY/n6MT5I90x5G
	 0eVRPJMBPXRMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57F0560623;
	Thu, 20 Aug 2026 03:55:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E90592FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAA9A8096A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CGJTKQqnSL46 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 03:55:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=IO5XykSN; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Dl/gv1QP
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34C7080934
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:42 +0000 (UTC)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hQV3075f8zMlFt;
 Thu, 20 Aug 2026 05:55:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787198141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/axpfusuUqpRhU+ByCtZl3DhyIpCN2/ddqLKt9kCTY=;
 b=IO5XykSNRcOz4Xbjg/TelMqiPXnjYi35LeQQBXL0ccSUbli9XeZjAVC0EKc5mVhHwt3pFU
 QYGjrBi94/Qhx3tbz08hNXtv5uL9m6qETDJwQ32LBhk78m28q5Wj2R0d1V7OfmoJuX+w65
 u6OxuVMJs+gE+OtQddicO6eZ2CZBNey0ndP8tBUGziyZ1Q2hg1fHnJixiyzBFRdnJt2l93
 Zr3tOi4ho1XHmyHZ/GRQ98CCpQnplGqYjG+ptew1yWD+SwkDkqLeVPB/t2JsjlAF3XNAif
 pfsb/TD1ujjK3RKZko4IJXS3XhTVeEeLkwmOGPs4SIbuPapbu5klMKzw29e+2w==
Message-ID: <332c309a-d418-4b18-a370-9ed83437d947@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787198139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/axpfusuUqpRhU+ByCtZl3DhyIpCN2/ddqLKt9kCTY=;
 b=Dl/gv1QPE7h+0foPzPbrj5blVREH69V6iyFP3u3pAD9pJJxKdg8vEtaaTtXIaEwIYN1mvT
 cTBDhkhACQeQXlibRG4sAjSLsvOOFGbh6aX8yZAIBlRsbvfOFaLGx4GpQ/NC3n2a/DQDBD
 WkBcajEZxgWDr6KNa2FVTnXCu3EkhFO9Ffd9VbmUecsT2mNBDHjRj5FARf/VzuZwVefJuw
 9wFCp/xyrmtw2QbebhzKCOYsSkkFbY44PdOK83ZyTD0utLzN/m/itxUcSYyO86pniPlFKG
 zVnLgmIQFFMGmGeRjJ6bTUlq+N/5Q2zL7qwybypUG6aKUjJsB/0JzNj4fGbpAw==
Date: Wed, 19 Aug 2026 21:50:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] usb: ehci-vf: take the register bases from the device
 tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20260819093705.4143509-1-mehmet.fide@gmail.com>
 <20260819093705.4143509-4-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260819093705.4143509-4-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: io578wgg1c6x3sd9djiq44drkfyd4e94
X-MBO-RS-ID: 38c568840a00a9569e9
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

[...]

> +	misc_off = fdtdec_lookup_phandle(blob, offset, "fsl,usbmisc");

Please avoid fdtdec_*() functions if at all possible.

Either use dev_read_addr() or a variant thereof, or , a variant of 
of_get_address() .

> +	if (misc_off < 0)
> +		return -EINVAL;
[...]
