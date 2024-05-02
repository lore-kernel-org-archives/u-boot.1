Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07811C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 07:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386FC88D03;
	Thu,  2 May 2024 09:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="IvFSdDX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D6A88C4E; Thu,  2 May 2024 09:18:41 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67FC88D2A
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 6A822855;
 Thu,  2 May 2024 09:18:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1714634319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azhwa7P3phB6Ur6I6L0vFPGSz9aWuIuRVKi0W9w/ahM=;
 b=IvFSdDX5Uh/f2YmA5Wpv1cjkDcVjQa7z4ATRF8oys1OxssOLV4eZGQMqojP160GLWdGeE4
 nMsA+yxrJ/FV1gbbIUizFt4zTYDD7pHL9CS05/Z+vVLCU206g3/cggQSx4Nxg2TjnX3eIe
 HPqWFLlY9J9mUZMs/Nf49VHu2gIpwxyzfr5Momf508QBFxSYUvwddUqz7thBUQ9fUTiIxX
 2GxlJ9JQPpszCgrxn7M4qKzwriFpxvX/OzIIYZEtcAFWb/OJS6axioKa5pibZBX9EI0VTV
 l9r0ngJ4oFb6FYTXbPu9JBq/sTsJn4yZyOwqkzGSkztBRMj/vJZpthIbf+IAYw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 May 2024 09:18:39 +0200
Message-Id: <D0YZ500W0YJT.956456SN11JQ@walle.cc>
From: "Michael Walle" <michael@walle.cc>
To: "Tom Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 032/149] board: buffalo: Remove <common.h> and add
 needed includes
X-Mailer: aerc 0.16.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-32-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-32-trini@konsulko.com>
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

On Wed May 1, 2024 at 4:41 AM CEST, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Michael Walle <michael@walle.cc>
