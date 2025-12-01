Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961B7D116F3
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 01:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5DD83D90;
	Tue,  2 Dec 2025 02:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fFJwXSWu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a6cWJUwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A1783D8A; Tue,  2 Dec 2025 02:44:19 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693BE83CF3
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 02:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dL3Tr6T8Mz9tDy;
 Tue,  2 Dec 2025 02:44:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764639856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pm8Tm8e99Z3KQAesOPw+gxvXuUzJl5WqCpdOUGjYEWw=;
 b=fFJwXSWusUb6zAlM6CxNo49zvyEOc8vZ0Ptc7VlyPBzwf5Nsp1ftVu+asIl8PBhvVgJZ5i
 G6XbSndkQxy3PFw9VrkaMwUdOM2q/GEA/eKFGvq0T82P+M/QGMeL7a5qS5UPSqp0t8bc3t
 bJL/VuFzXG74/9cM2/pCqwDB6gJJ47p7F/oBw0ZkKVtfj6+M0xc5+aIYl+YK6ANfGJULxm
 kcMqOb71lqxNOCLqVu8G/ZSU6F/hTbkwJ4/GGJpN9njPxRlz/NLgowoq5VDneHPfIDGILa
 p9fIlTJYovSG8c3oZPqzV5TJD8lnoqEYA0+qDo6T3uW3/h3pwPiQ27+9Gv0/jA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=a6cWJUwM;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <849be528-a4f7-4878-9a24-8c5b46f1ecd9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764639855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pm8Tm8e99Z3KQAesOPw+gxvXuUzJl5WqCpdOUGjYEWw=;
 b=a6cWJUwMducawhcplOe5bPkh2qA/ydnJ9O/pXLOZIyb4tBaLcoDx2Ms1mJQ9KJIzvGgXwP
 9RYVSvG16BV+ewZTr82vOLH8VYluic1eCJRxc+EZTUC8csenp0BjmvJOAEnHl7gEuNa2xU
 ILMG4LGezikjZO+ty7Dzai/lrVjYjw2fbQuOu/lDfH5T0WawsnwdhsVex/yR8eq/ffQUQ/
 TK7GqRkaLfSCpXmrGJVFzeENpDrE6w47Md9MuejKFTT77+Gx42kuzwCUgFQxcCMpEcAVuU
 tUGsxj4DNJnq0eaE4DYM8qtDfdqjOWJb9LYKbbjRJy9ufygDscpmdvPQsvv3kA==
Date: Mon, 1 Dec 2025 18:43:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot/image-fit.c: Restore building tools on macOS
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20251201174038.2246180-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251201174038.2246180-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a18bb2a94851884fe25
X-MBO-RS-META: a5ptr9i9i8hjj5p3n4agqo85jxeodo6z
X-Rspamd-Queue-Id: 4dL3Tr6T8Mz9tDy
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

On 12/1/25 6:40 PM, Tom Rini wrote:
> The ordering of headers in this file doesn't follow our rules exactly
> because this file ends up being included when building host tools and so
> has to be correct for host include paths and ordering as well. We need
> to have <malloc.h> higher in the file or macOS will fail to build due to
> declaration problems.
> 
> Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>

I ran across this missing malloc() once before, but never triggered it 
in CI after changing the fixed patch slightly. It seems it does trigger 
sometimes, so:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
