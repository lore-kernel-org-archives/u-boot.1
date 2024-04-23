Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7845CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 23:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC8888CAB;
	Wed, 24 Apr 2024 01:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RKb9mpXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D2688CA9; Wed, 24 Apr 2024 01:17:55 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED87188359
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 01:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VPJ1r03ZTz9sb2;
 Wed, 24 Apr 2024 01:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713914272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9JUyBhdLPahj/T5EH/6HkEkwJxBNjBt1i+HCyPtFog=;
 b=RKb9mpXzlM+AwNTMwNuC/7uOiyg/q1VcnN7JCQzqoKCNcrf3ELnp+EA32ljKvNtHNK3htE
 iW9UErkwLQ1lE5K8ES8JHZe/kxnGbDU+IgUDEbslkXg29+irn8OD1F0WgchtOL91qmE+fJ
 /XnRqGo2hlOOLl6fKIAamoYx0EZukp5nGfdThyw35PonfrzSZyumqjzt734y4SvBfYfo9K
 R4Kuo/YUEIype2qELbLqYdsdc1no8zFhbbNxras6/2ZSNah8XgCZIaM3HPs/dmc9WlxatL
 d6IuQvXuN8ir8un1nJ2GFuofwdoz9ZaqnWexeKRiGjLe92PX/alG5WHi4K7XOA==
Message-ID: <fab40e09-1ac4-45c3-8dda-f0a1544d2d39@mailbox.org>
Date: Wed, 24 Apr 2024 01:17:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ze5khdqd8uxez8ouiy3o3csihr7sg8tj
X-MBO-RS-ID: ca160d6e5227a8dd559
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/16/24 9:13 PM, Marek Vasut wrote:
> In case the cyclic framework is enabled, poll the card detect of already
> initialized cards and deinitialize them in case they are removed. Since
> the card initialization is a longer process and card initialization is
> done on first access to an uninitialized card anyway, avoid initializing
> newly detected uninitialized cards in the cyclic callback.

Any input on this ?
