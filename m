Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46790C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 18:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0220940651;
	Mon, 27 Jul 2026 18:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6gt7TRRUAvd; Mon, 27 Jul 2026 18:49:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 541D24058A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785178149;
	bh=s5mJwWYKXkX07lGkBpf0gugopbu1hADi7nEgJNap5AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pfv0xTNu75OMQlhfYQ5o4D8eVcg5Xt6W1d7wHEfJZu5O9HULWy9MdiVEtET1kZ5q2
	 z2oWNDD3XQeQZ9mhuK5q8E9o4Hl8iY+kdM47IMOrWc8TE6iI3qHYckLO/QGAGxq4T0
	 zPVRvElXHeogbwDtDfK55bld/L4la29SxAAVYYEJdDbFuPUIOGTw5/IbHhdtL+Omj+
	 TTzBlk8LAhbyrSYCvEU4nOBjxWnApJyRoUS6zZcv7ZTxpcvowmw0EylbKuHGwBuds4
	 xIOEvUiWw2DaNLdOjDom7cJRLBvm2/9ym1pNhUE2eG+Jo9VUwbOvgjA1GN7LivHzlU
	 i2xoZE5n0W0qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 541D24058A;
	Mon, 27 Jul 2026 18:49:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 208CB3B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 18:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 152D080E86
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 18:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QrtptreUe93F for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 18:49:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E5D5780E80
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5D5780E80
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5D5780E80
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 18:49:05 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1woQNZ-00000000254-2TX0; Mon, 27 Jul 2026 18:48:45 +0000
Date: Mon, 27 Jul 2026 19:48:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Ludwig Nussel <ludwig.nussel@siemens.com>,
 Anton Ivanov <anton@binarly.io>, Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/3] boot: fit: authenticate the dm-verity roothash
Message-ID: <20260727183033.verity-ci-reply@makrotopia.org>
References: <cover.1783995924.git.daniel@makrotopia.org>
 <20260727165132.GA4154891@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727165132.GA4154891@bill-the-cat>
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=makrotopia.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 27, 2026 at 10:51:32AM -0600, Tom Rini wrote:
> This fails in CI:
> https://git.u-boot-project.org/u-boot/u-boot/-/jobs/50414
>
> I've just made you a contributor area, so at least pushing this through
> CI until it works will be easier now.

Thanks for flagging this, and for the contributor area -- that'll help
a lot for iterating without round-tripping through the list.

Root cause: test_fit_verity_roothash_signed() (patch 3) builds a FIT
with a dm-verity subnode, which makes mkimage shell out to veritysetup
internally to compute the Merkle tree/roothash. The test only declared
dtc, fdtget, fdtput and openssl as required tools, not veritysetup.
The CI image doesn't have veritysetup installed, so mkimage's internal
exec of it fails silently, since the diagnostic goes to a private pipe
mkimage uses to parse veritysetup's own stdout, not to stderr.

Going to fix this by adding @pytest.mark.requiredtool('veritysetup')
to test_fit_verity_roothash_signed(), matching test_fit_verity.py.
Verified locally both ways: with veritysetup hidden from PATH the test
now skips instead of failing, and with it present it still passes.

I'll push this through the CI and send v4 once it's green.


Cheers


Daniel
