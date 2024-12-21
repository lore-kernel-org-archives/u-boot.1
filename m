Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F71E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 20:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5318480562;
	Sat, 21 Dec 2024 21:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DESTR4uk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uUJoYEjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48DB8056A; Sat, 21 Dec 2024 21:08:01 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF6480516
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 21:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YFwM32c54z9sr1;
 Sat, 21 Dec 2024 21:07:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734811679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MSDskxqaqlQJ8ssajDr37d7EvgzomOF5YsjKx3CpFk=;
 b=DESTR4ukQ5mFuUm/kp9WRLXqm8tZhOAGk4Zp3mn9T+Ihv1US3NET2v7XfUTofiLNpY+0lb
 mc6E1XY6FD2pMdsF3mbl3JP3wKR9cBJ50Mjv3zyQZHYYeueGHznAsmUt+8TXExevNP3HI2
 /65F660h89fL6F+ZVkpS1iCxIX2ftvo731qEcxvNj/4X8n/IXhM9Ibs68uBTSs//3V89fi
 1ugiRd1u+7sTVKgZACwrJfjmlquKR/MwpsNjasclawK+sEIhp3LwjbfDcWxBj1FQLBAUHS
 iMKZXyczZX0F95KeNpKnqb/7V+h5OgGQNlJuLXeMDURv6Ghqh5XKQrLxCJ5xYQ==
Message-ID: <2d52a656-2188-4a0e-bd9f-e4154631ae71@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734811677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MSDskxqaqlQJ8ssajDr37d7EvgzomOF5YsjKx3CpFk=;
 b=uUJoYEjW4CpmDTS9ksOiNItA3yZnhWNjIY92uSSxE+HM+5gjFgASKKgZy1H+6F3sZNJ3m2
 B8ri7kerDF3YGgfmYxfEaNlY+alre0dDOWsV02SqIGq1tnk3EYNmYPf48fkK5iuL9DzHXh
 DUdg9tRtxEXVXJjsUrrlBwAx9hAm04wkQptAqAodyl1JOxjVZSmE/PgDfIL5EkLsiEnYSx
 pFice80lb1igQqtZ1hvFNKn8SGOEPP9ZUbtojNnTbowA8JaqoRlZdzKyWrF1EKZPmtcRRn
 7G5l4L7sZqVlSpWq5xyrosLKoPwxPcQtxKxXskvyaHH13xqY5apAai2udQYu7Q==
Date: Sat, 21 Dec 2024 21:07:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] cmd/setexpr: support concatenation of direct strings
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20241221151435.43825-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241221151435.43825-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 09c1c5f05c00a1a486d
X-MBO-RS-META: dn9iz5aeqyportm96i41k9kqzds5beqw
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

On 12/21/24 4:14 PM, Heinrich Schuchardt wrote:
> Up to now the setexpr command only supported concatenating string provided
> by reference. Allow directly passing stings.
> 
> With this patch
> 
>      setexpr.s foo '1' + '3'
> 
> sets variable $foo to the value '13'.
How is this any different from

setenv foo 13

or

setenv foo ${var1}${var2}

?
