Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D07FC71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 23:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9D582977;
	Thu, 12 Jun 2025 01:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bogQA7r2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CVQEzEnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 588C782A4B; Thu, 12 Jun 2025 01:55:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1718981FEE
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 01:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bHjFs3YFRz9t6m;
 Thu, 12 Jun 2025 01:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749686113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVYkLcyoZctQiidWCLhOKhF3h3GTdZnoMDV+e1t0H2k=;
 b=bogQA7r2WhbPR7CGxFZ1EBc4pYPQZF0WQo8OFhI7SR6Yim9SJcD06/vV19h9tmeRq1Fc0E
 /WZo6XkwSK7hgfa10kIZufbPl6Bg/Wt0MwLWoqKVZhaLE0X/mWnnGmfixydw7tYTEUC+X/
 FPbggqovs4+aZqNg9gfxsr91eHihk/2svqKwxEflSPGJOf7oZ8Bd426IPEr9w8Z/TwhhrO
 Dum8l6XVZzIo2RQmtcOMngc/WMP2LrD1YLfymuMLLAXxwwogYooPE5Dpcc3AtYRs+xOmgK
 QsH/BQDuDBI64YVEiiCUVeJG7kc/oxIEifCIsl1asfP5BV9ejVYonRw5LFtppw==
Message-ID: <a8150309-c804-45b4-b80b-81a89dcd41cf@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749686111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVYkLcyoZctQiidWCLhOKhF3h3GTdZnoMDV+e1t0H2k=;
 b=CVQEzEnI3w0QwVKcUN7sX9L0146d6Vl5LL3kD++uMmNP3FbSybDHoVztW9mU+TpDqgSzN7
 lWD6SZ2HPiq0ObxoRWkAsDptkI3AAzW+1oNdN34W9gt5+MrsZUK6yZ578JUqY09DctblYn
 /4DlapAZUaCxQUj6kbyUeBfNWPz/F75qwE8gKLNgIH+zYSxcJ+VZRJxOsgcdLWSVdi5i7v
 /iRldww563jqa3drxGuCh65Pt9y34a2krfZNb0feM2qPJZXCdtKzjvEavDWhzaHnzQaH0J
 6rlX+mD0ocfNSx74F2H3YS3x88fNZYAfuvGXZYO2iIm3T+VoLgGRh4rnt7g/MA==
Date: Thu, 12 Jun 2025 01:55:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] renesas: Renesas R-Car Gen4 watchdog driver
To: smelamud@redhat.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250611-us-renesas-watchdog-v4-0-24f1da3e0dc9@redhat.com>
 <20250611-us-renesas-watchdog-v4-2-24f1da3e0dc9@redhat.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250611-us-renesas-watchdog-v4-2-24f1da3e0dc9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0383561620c251c125e
X-MBO-RS-META: 87pmw3yicqbgnujcbs1hieb8zc5ke3ar
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

On 6/11/25 2:25 AM, Shmuel Leib Melamud via B4 Relay wrote:
> From: Shmuel Leib Melamud <smelamud@redhat.com>
> 
> Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
> 8184.0s are supported (CKS1 register is not involved). The watchdog
> uses the clock of type CLK_TYPE_GEN4_MDSEL.
> 
> The timeout is set in
> dts/upstream/src/arm64/renesas/r8a779f0-spider-cpu.dtsi section &rwdt.
> 
> This driver is based on upstream linux commit:
> e70140ba0d2b("Get rid of 'remove_new' relic from platform driver struct")
> 
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
