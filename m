Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60646CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3381C86EC4;
	Sun, 15 Oct 2023 08:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fvT+irA2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ckQUZFKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9242A8657B; Sun, 15 Oct 2023 08:19:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8740F86529
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S7DMh3zGYz9ssw;
 Sat, 14 Oct 2023 21:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697312640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPY4bIv3Sfcft8c0nkHUlBwn6U7Wn3zE1KJs0NrJaQ4=;
 b=fvT+irA2Z7v5p+E9oq20kj9VLWipSAocdnh68jKmeKxCzIgD949XYq7+QXCTNswHhYdET9
 FVZsCkK6V2LLqEpY3OOIm/gtkZcSItiZHF0NCxZi1QxytuoPUgnAqUiSn/2Llk6SkZmeCi
 0W1P90Owj78B0d/hsFfau2mKveQ9MBJmha0hvHe+3hnfT/MS8xMK95UhDdguHq/1Z8Ffsh
 PhbCsWx9MzMZyYAv1MEJwdfFsDlI6k3g5/+4qw/eJCALDPWzM5plWAl4uuyLQqhPCAy00Z
 zYdU3MCiykvgzrls45BW7QhyTsOTFngzAzKSFj9JBt7jPQxD9GndYCONl8YfBQ==
Message-ID: <45c559dc-5800-4ce4-9cd4-b4b8f37355a4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697312638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPY4bIv3Sfcft8c0nkHUlBwn6U7Wn3zE1KJs0NrJaQ4=;
 b=ckQUZFKvFhNPdxESPBeB8XjA2BAMPP5VvuZD+hogTCZlED2+IdQt83mZ0mfxnFYq/r4f+F
 Zx5CiXQanpRMDcpWAF9N+kDG2x2izI0NBY37sf1Dox6RWNuPRB3cU7fzcvTMx+C36F+9LQ
 0lnTDSkLUn7aH6C3V9aQHVQn1zA3hTgyp58avTCgIYPfUaKHGHi3tcxNq1SBVQshwQO+o0
 YJjn2w6kFjkm/vHkXrCMEBKAA0E5Zv7KGvMpZXsdqqh1LbpaN2Csc6Iz2ErbiTOKrnH+3o
 UDGu9q7Sx/O10PXLJIhL0Q/xpzeYZthuuVhC0vIDg2JjtkAu4mFilOK1rM/QIw==
Date: Sat, 14 Oct 2023 21:43:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/19] arm: rmobile: Add basic R9A07G044L SoC support
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-7-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-7-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a25310a293e3308eb77
X-MBO-RS-META: kg8me5oepowwqdm7p667pothoxqpx9nk
X-Rspamd-Queue-Id: 4S7DMh3zGYz9ssw
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

On 10/9/23 18:46, Paul Barker wrote:
> Add a config option for the R9A07G044L SoC used in the RZ/G2L so that we
> can make use of this in the subsequent driver patches.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
