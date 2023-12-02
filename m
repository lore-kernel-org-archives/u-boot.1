Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375B9C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 16:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDD18751A;
	Sat,  2 Dec 2023 17:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dr6kKXjA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TpNHu6ql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042088765B; Sat,  2 Dec 2023 17:33:41 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6E8874CA
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 17:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SjFqQ2C2qz9shV;
 Sat,  2 Dec 2023 17:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701534818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cg9hAbLKwAaqkJD8nb604KY1n6T4IMjh03BgVhyZdns=;
 b=dr6kKXjA8Zy7k/4ZJKTOHXjwWP6hO2Z286/YFOYNevVf6j/pKDcc+xAiWeSUMHzVlZZZmC
 fphSb4PehULDula60kCst8of6q9XMapCsPoQxQO/vzORJIVBLwoLOastSCE3aqD0A/kgmQ
 dL8vM5SoZwWtu04cQeoMGZjpiWbL2SAIGQO6vsz7ikK/AWGzxSHomOdMXy9nBENXLt4Zkw
 s2K/bl2PpSYcfYVAlF9k+NQPaEa+4Sv6Dd4Qb1YzkzV6D6EsDkBt7ITOxLiOm2ybf6sbpD
 c9MHdslBkhIih6bwewwDG+w38IDy+jwwirtLx5t1VO1svy08OchAiIz6JPQf2Q==
Message-ID: <fd74b3b4-4229-4048-bef4-e095ffed59b8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701534816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cg9hAbLKwAaqkJD8nb604KY1n6T4IMjh03BgVhyZdns=;
 b=TpNHu6qlNHbFgRqQXWcIDtHWDxK82GF7vRds4UYqGaz+Is03FYZ0AzWpJVRYkoX/rr4sf8
 YfFvL7mBGVnl1deKn2ZfnR9aiBSdZpdYkbEoXpDn10FHljUk+VUVP4nzg5BOZYnOYGZ0aP
 14JzJMO13AN8ZLK01BZzQ6tLTNa3rSHqzKBzPzx3/LAu+Ad3Xw4JpxGXLTgAD9S8eoK3Nj
 ffYyMOhSMITkXLalBOxT0Dv6GczRskEvOL/LYApk8WgDGae5qUxDAsk11GtMaLeEPCTYEM
 rQ3y36ruZY9vvqlXevkSM+Qbq8sF9NZlhedYFmL57/5JsXEGsbyMbyzfl1nHMA==
Date: Sat, 2 Dec 2023 17:33:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/9] cmd: bdinfo: Optionally use getopt and implement
 bdinfo -a
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 033f382a0dbff61c22f
X-MBO-RS-META: pnk9fembc6hxkbr44n6hzi5e3rkwmodg
X-Rspamd-Queue-Id: 4SjFqQ2C2qz9shV
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

On 10/7/23 23:40, Marek Vasut wrote:
> Add optional support for getopt() and in case this is enabled via
> GETOPT configuration option, implement support for 'bdinfo -a'.
> The 'bdinfo -a' behaves exactly like bdinfo and prints 'all' the
> bdinfo information. This is implemented in preparation for other
> more fine-grained options.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: Add RB from Simon

I see this series marked as Superseded in patchwork , why is that so ?

Is there anything preventing this series from being applied , Tom ?
