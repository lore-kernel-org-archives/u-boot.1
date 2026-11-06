Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84E606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WdqDP2QU;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hW8yUWTP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EA5B81201;
	Fri,  6 Nov 2026 14:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShRaGZOHqe41; Fri,  6 Nov 2026 14:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9173E81244
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793974549;
	b=LP4Y5pBQ2m5vVvgerIGPM43A3CSttaXqfDMGrfxjYBqXcSCv3eaX+S/uAdDUtQCuanpm
	 0PQhJWCnEGlE1D0Kf8HQ3l5MwSllbqEQipAVO3OygMmJaGOWGRoYead6TNFxlLzDKWfBO
	 gss8QsNcZXlBKocLNOkrcKaR1ZO4NNMNDWmr/3A2thmTOVJjDBX751xjvPiTZO9quNhEu
	 iza3UY1/iB4sNb0gV4BIsVPOMCBqVImN0kL/yFn6a1tdPUzW40nGR90DOvjY9UgRKJYrt
	 +AbKHSSspdhA1gdQ3XEPFginU5j32YzfBL5t13JNTD0A2N6Cd3i9a68ouvsnwaBmwAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793974549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N2JYqCecRDqkGy7IcQP78EsvbGtXg40S9HZlbQbKgzE=;
	b=M+v23EBzYU6iSqLJAyclRN96VCYGb8PJ2j1flp5qQ5ehhWYsZKI5QO/X4jRtXwjfIK63
	 KIyewSB7kvXF6pBt53sN7GS02VTXAJqR9rIuLv7ucOhvU8p/2SUTv4CDFp6LRuwkwwTEJ
	 oaiRbZ6mJhrRbQJN0ZB4R8MlFXAdnndV2M1jLsFwM2tsrrkwZSKnKTbXtsHWBpVe63ryl
	 mhlT1tminO+CGjA9my1SVqAxakSGtqYuY3nAFp1xsI2nu8RVgTU6eiK+oeKuRISMOPaun
	 iK/pODOYsds6tU1Kx3VKr5koJ4vwO1KKznrOIoOouZ5UqEmaDMGxjmKWKph2bz+MWXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793974549;
	bh=N2JYqCecRDqkGy7IcQP78EsvbGtXg40S9HZlbQbKgzE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WdqDP2QUMeg/JKsTH7lAvxOr147G2O+YgkXXoiRo2aPe596CDC9xLlRuyr7U5J3u/
	 0jj4A8PRKCvYcJGKRzdGmy60zrozVJBBADLByuBmEYuuHUBo4Tmha1aWETeViERKad
	 advL9lkmPQ22IMRt+y7bFyDF5W/1FsaRPtHm22Tsje8AcurpJvwBGeoFRof8bjywqd
	 zjM9CzCI7Cs1rPa+RQdDbv02nEo91T8U9/7lSmlK6mIbaYmEgIpL+rmVKjyhtetwI2
	 r+dVkYjDc00QvT/zMrIZe+sSN/wqKo55RfFGbqlT8a3r1YsMuAAiQ9NA1Qx1E5mkXn
	 5OjonwTPlYB4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9173E81244;
	Fri,  6 Nov 2026 14:15:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC802362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D24F7403BE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5f0lUIyu2w7 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 14:15:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D08B9400CD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hW8yUWTP
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D08B9400CD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C9FF605D7;
 Fri,  6 Nov 2026 14:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDF91F0089F;
 Fri,  6 Nov 2026 14:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974544;
 bh=N2JYqCecRDqkGy7IcQP78EsvbGtXg40S9HZlbQbKgzE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=hW8yUWTPqra8e1aLe/n2iwiYNEb9RwVtKPLb+IPPLJPFiE7ZWeWrqVuvqkqFvzI9Q
 TQuJiSMsys0GzQt7cR/2KPCBGqUg6R7FlWSxJoGUryGniqcURgXWX+tuGfs91c9ecV
 0rUdlfORSWyJ2amj0JWm5Qf4uHJbxBtwCnD3iHjjWAGY5Rpsyw10hp3nNXcHGUngJI
 qQnx1yexh3K4zjnhcZEYHQWfjUrSmv/LF0SVfabg5t4vw50tQm4O2apfhUlTSD3QOe
 53UqqsWqSp+oBV9P7hjE9hpy8tteAQt1co4+kZROooaPEs0MV8Lx+Y4u68+cmCa4co
 4vy4x8yDTvPTw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/7] spl: ram: allow loading FIT images from a
 supplied buffer
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-4-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
 <20261104-ccaione-upstream-spl-fastboot-boot-v2-4-cf9781441ed5@baylibre.com>
Date: Fri, 06 Nov 2026 15:15:31 +0100
Message-Id: <179397453139.1035345.17024076351804320858.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=627;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=jYKX8dFJ5wSYuBGolhKRRbBs4OrwMd5eBLrrBgUvofU=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7eEIkYjjmU1ZGPW3XXh10G0+OIi0EDLCYXE4K
 Dsf4fKK7AuJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3hCAAKCRAZDR20Zk4Z
 NRXrCAC/QJtp8TS8c2IItlEEbkf5nD0qjkCb4a8uxgIFLcNUbaFaR1OJX7KYkhWbhWe9SuGnB3w
 woKKg+O1Y3xglim2EdH5NOkUl+CYhmnLx8abxx9O0PZ4pHXsuIORLczbFLBepCmXKFFtYmda8Yt
 2r5LisamdzdBzhzufsaUukNcAdzDgJcESoofdlx1uuP/e7tLuCnogi0joFlk3p+ZoWpGddAGJXw
 0e3mryrnkFT6w5dreQCdpekutJGdJZaZm/wfwCLi9r7WirqrP2j8kNjnfVqIriGTA8HaZeWlZOh
 zRkk/RhE2HHYRPvjOTmW97W4/MHF4VKyrq2JVbVqay6R9aXa
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 10:40:24 +0100, Carlo Caione <ccaione@baylibre.com> wrote:
> RAM FIT loading currently assumes a configured image address. Downloaded
> images need the same loader with a caller-provided buffer and length so
> reads cannot run beyond the received data.
> 
> Expose a reusable RAM FIT loader with header validation, bounded reads
> and overlap-safe copying. Keep preloaded images working when their buffer
> size is unknown. Add tests for embedded and external FIT data.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
