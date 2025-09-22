Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83160CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 16:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D42832F9;
	Mon, 22 Sep 2025 18:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vrlSz+Ej";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qiKRuPOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A5983423; Mon, 22 Sep 2025 18:38:51 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8DEC8004F
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 18:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cVphm2YD7z9vB3;
 Mon, 22 Sep 2025 18:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758559128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S42KgxnLkRRVGKasNBkomdgbk7oJH7TscEpSYgcQcI4=;
 b=vrlSz+Ej7UriQ/poTkYvvIPA2LiQFhGKXwO3XYZ/KQpxWDYxYV0D1m55g+4OBr5WtaKjWi
 3jCn0/6Zx2BJsoNKW9KXdh6nxJxOZNjC98o3sQZuIzWXQfM5fATJnQeg2SCdS0vjHh4XpE
 4M5W1xIpSX4/KD20+pQEjVEDnf2BcTJpsWl1P7WIM5Le+ZvqPKYzQ/H59jTBde7jyt2ISy
 4St2C3SY2vkGWf3G3VaFX63xlPBmBVDRAPdwNc5DMZol4/mxoe/orp8lRdXYrxO2+ejbPF
 pAt4MtFzhwlFKcanadbKXpyb1PTO4mSA2lkjk9mQVbW2/600SelAzHuVj93IQA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qiKRuPOz;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <fbe74a6f-37bb-4f5f-aeea-e0d58ff7b805@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758559126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S42KgxnLkRRVGKasNBkomdgbk7oJH7TscEpSYgcQcI4=;
 b=qiKRuPOzgOFZTXZ1VkkeJnSs117+YfeQRc4kV4wwkz1bH0r6J+tSGDtOTKpGhj1stxMrv2
 jYMhK05GSaUJ6/bGGGWrvePUdNbXz+4pXqyZjqgTObrWnYF+lNpJiUXKNilFdcR1b8H45q
 hmATOHxgWFjYec4t9ZltthSyKxds5F2YHee5/spy5kbQxCy4yXsDQNK5+ffq+9ht/4jLFb
 oNQRXJRfiXtTRToTZUXpdQLOUqte8bnZ8d992hYE98uzbkxxYyJeLyBNSm9wwWhfXN3sxD
 rGtoOMpqQF5LvnUPR/kSLQgmgbk/avgrYtJYq6R+1P1dgENJW/HEYRRovtvlGw==
Date: Mon, 22 Sep 2025 18:38:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] board: rzg2l: Check the DTB pointer passed by the TF-A.
To: Mathieu Othacehe <othacehe@gnu.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Paul Barker <paul@pbarker.dev>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Cc: anton.reding@landisgyr.com
References: <20250922162901.22908-1-othacehe@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250922162901.22908-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ahwsr7egxum63d5cwojahqkeqa355qbf
X-MBO-RS-ID: 5314650555b53208c5c
X-Rspamd-Queue-Id: 4cVphm2YD7z9vB3
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

On 9/22/25 6:29 PM, Mathieu Othacehe wrote:
> On the RZG2L platform, the advised
> TF-A (https://github.com/renesas-rz/rzg_trusted-firmware-a/tree/v2.5/rzg2l)
> does not pass any DTB blob to U-Boot.
> 
> On the other hand, the RZG2L part of U-Boot expects a DTB to be passed.  It
> means that if one flashes the latest TF-A as well as the mainline U-Boot,
> it will crash trying to dereference the NULL DTB pointer before outputing
> anything.
> 
> Check if the DTB pointer is NULL before trying to use it.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
