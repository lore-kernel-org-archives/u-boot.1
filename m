Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF949606A8A7
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EtgS5C9s;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juwOCagG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A31C640AE4;
	Fri, 13 Nov 2026 16:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EVRKfxIkPhW; Fri, 13 Nov 2026 16:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C632C409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794587151;
	b=gZkSFQv12FDHYWy2ckczlLT6rcdcG6eUK72Q3VVbbru5rh2p/OwPTMEEd1e3IiB4+Fp9
	 2FG67sp1SOl+qZjzjZRg8UhrV/zngiwHnpBV7NBT1yD+lWiDzNxnpxTpRQ3pCkEo+siDG
	 sdDdGsHr1KevEMmFgw940j//psZEpPtwlcSz2Nhp+QcP1LOA2YgmvDTY1YZ0EEKRXpVvO
	 /jVGSqQz4is76x4vN8jhFKgXq3wqlMsP8z+tC01S1GQUjdTW4Q5R2HrXLGSWoxl0Nzqjb
	 +C3opufTF1QRYov3SXb/xUUy07gBlI+xLNgSI4+o1VLKX8f7esNBzpV4rBfqAiqdK+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kZjJvSkGJPO0aIcAef/91OBs4m63Ah9kK0GygDfEEQI=;
	b=alfTzauKDCLRuCK33v250BfVQsj0ETO/drF93gBnm15AnJZIf04ZqTaWZlD3busZX5nE
	 rfh/keZtqM3+LGXXMeenpeSc/RJLEZrqqyHyn/0IgGAO2ALMtGkBted1dEjDsR5EGXqMb
	 GL5vzZuCQPTmlom/frq7t1XCGcksrjOhGvuGBzaQFC97qsiPNHeZ07J4GmuxDI2phYKf4
	 tIj0kyqHT6FNXKqVilK74jPWg+0166EqwGYbgx8u7Gw4UPNNRQktT9W3g8uUHAB6lN0Vb
	 ElZJnFmvWms97Qq3ecI96uxJcXf7Rma7jD44Xz873EoS5Wj5fq2loJoWzxOndkFE1Fg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794587150;
	bh=kZjJvSkGJPO0aIcAef/91OBs4m63Ah9kK0GygDfEEQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EtgS5C9sSfT2LYk8hp7i9BFntAnEFDX6U2jCd31+g1AMJkUnMyoW8FxdbIBxWD81H
	 9N8X522KPs8IdaD4kQS7skIXcInqBUzeQYqX0khfwA2BX1WLU9qV09UPFJTtXbN4bf
	 txM1DLsZzNqvom20uSJrSYEVxLlU7hUU91WasI6xuS4ogi7I5yzk+VUxmGezVqlU8d
	 axtw9Vqj9ncjCNXhdkAfb4FmJls9ORjXUnh2q3hLz5+pHhbTPlPlgQOS1Dyc/yx1Ne
	 ypl7bFabkNuYUGaXFgGOEAdynPQp2fbK9bkycjFTrc3bersSwn0wZC9cFwK8C+Qy/v
	 q59Oru33ypahQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C632C409EB;
	Fri, 13 Nov 2026 16:25:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABC83F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DBB48153E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coc1-j-PvFcm for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 16:25:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F661810C3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=juwOCagG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F661810C3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:25:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 337B762441;
 Fri, 13 Nov 2026 16:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E221F000C4;
 Fri, 13 Nov 2026 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587146;
 bh=kZjJvSkGJPO0aIcAef/91OBs4m63Ah9kK0GygDfEEQI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=juwOCagGiogbdk8NMnqQOVui6G6IcRgQPrvdjncU02QoYzZ7pMdzefcnv5UxFu6PR
 VKYvPeOghPSOXn/IdM3teaQ4aFfM5jkdnVHEjpRHlOyVHmy8E67O53lVzW2y06X/Ti
 EdDzG7zl+cZ9Bq3juMQ519zGopB3JPr6SzBevahiXwloTNhJF3+1a2CIXCG9V942Hb
 fjP5o8I6LYQFvXpc6n7kun7B/ngwfQeRGSEQ8Q5aSuoaGu9yz5+2SbspJyEWwBhNHF
 O6CVXi8/PAiiTpiLj+r4+C36Gcro42jnjxRG9Id5qCTvktRlYckw5Qjww7Q5WXpwgl
 2wVZJk2rD+D7w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>, Carlo Caione <ccaione@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
Subject: Re: [PATCH v2 0/7] Support fastboot boot in SPL
Message-Id: <179458689495.70612.1391691837782870153.b4-ty@b4>
Date: Fri, 13 Nov 2026 17:21:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=GLEC+2C3DKONESIQ0L8JTssnLhbbpsZPEp78B4qlUio=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq9zoIx+Lx8MzigxNChbomzQ/3WyYdTuJJfA/CW
 ovEhHb84IKJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavc6CAAKCRAZDR20Zk4Z
 NeKlCACFWMWuSntArCwyZMyjU5q7yofsuH98x2Hhl/+DclLHObAlP2tawdCJm2i8fzblGCbjN7h
 L7De82MhlDMWQB522WZKd/Fog/oPpEjLtek9zm1+AQ8HQiAYsgJPUSPBd27TP2NWlK8l6Qx+/Gr
 UDUfaeqEfKW/3Qd51FLUMTo3mq2H4fYmsuWIfsVYth3W2UKGYOljOrOiDU1DzJNKL+IZ3mOufVm
 zaJABZ65gW6S4crbTFuD61lu6O84sxrKaWziWDKKMqxepinhTeyR4i61GUP5YI0hnfpnlR7xA3j
 a1Klcx4m7JoJdcm0hbMhjte+kqGdxjYx44xxPwyHk5vN2p3t
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, 04 Nov 2026 10:40:20 +0100, Carlo Caione wrote:
> Support fastboot boot in SPL
> 
> Test farms need to run successive U-Boot builds without rewriting boot
> storage. Add optional fastboot boot support to SPL so an already-running
> SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper can
> then load the operating system using its usual boot methods.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/7] spl: fit: reject failures loading an explicitly requested FDT
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/1a3297db459c3baebdd7d51a7b6e740d3e29816e
[2/7] fastboot: invalidate stale and incomplete downloads
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6abd0cfcf58db69fad1130a8b4b1c3584b2f7de4
[3/7] usb: gadget: fastboot: do not boot after a failed acknowledgment
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/72e4069217d76b4d358f561dd2c8160acf0fe485
[4/7] spl: ram: allow loading FIT images from a supplied buffer
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/154c4246d60a2012d5fb23920fd1e77e7159ea55
[5/7] spl: support booting FIT images downloaded with fastboot
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/fddc8df36f5219e3742e3b8eb3a9b0f21c30b315
[6/7] spl: fastboot: support legacy U-Boot images
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/02172ea8e838e9a3a00b30bf7f868d5b273af173
[7/7] spl: fastboot: support raw U-Boot images
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/4dce3b1e0e17625ed73f37784433c54da4cd719c

--
Mattijs

