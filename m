Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE784606A331
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZvRGmT6P;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXRqknr8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7EBE81192;
	Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_6EVU8CXAs9; Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CC3581195
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794927856;
	b=MxIblpYi92qBbzqHXgx9BtSqV2oLl4crcAWHytrjKsKcsxK/b5Bj8SKCYbYJFGm4x39t
	 SrSfYuhPT/G4uoiLXzAmCv3eec4voRfpJ4Kj8A2iVgz/TV9uPJFm8bdUYeikvwnsRYvA1
	 a1yXXRF3BQDwImjF2zfHFdijQXfTSmtmEghpSsWOuKT1TdrLrGmvkJ2cTdxmJ405xyn2a
	 n/z6fvaiTlc7UlNZq0pl5w5VOWzY1Cd7Kiv28e1nXyZP8xTWz9zac94r75XFGLojuS5h3
	 +LGpwVsn7udYcmptFazFtQi/kS7bTZt9qIafUED9kqHJThl2J3HT1BZBukrGPdYlp7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hA0ReReI5zdh5NkkyoGHdU00/F/jvo6SVR8206de7g0=;
	b=mPoAPU90/CN14PxrQu/H7L5AlrshUn6PozpsZ36ZJILZxK7VccM4GuPLnOTTBzPcrYlt
	 FFGYZUXfHBJk0qvrjE69jOw7g5zDdSI/49HfuzcBbMwPhVyxPgmuP1LsjcDbLjm80perH
	 mfwQGPJPtqCqUnoFeC1iH1bWBzSfOtYWvco4A07wJgI+qLAtIVz/qofd4r0rDTMQySRb2
	 ou7D9tis7234E4TtnvC9WEUfFxFY9hFruzb1iaMpoKNHLK86Z+TdzOzSiCS5hMX/KKA1x
	 SQUO85OvGgXSjol9KoWeAnjgH9BOiP8B0QDnqOS0A89VWI9vUQr1veYCsR6WM/ePywg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794927856;
	bh=hA0ReReI5zdh5NkkyoGHdU00/F/jvo6SVR8206de7g0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZvRGmT6PnEQbqtnYNVFhjElbYqhd8/5pjuoAAjMyW1qgzlNRmzX/G5f/JG2T/sZWb
	 n0a+Y8rpsGGC4a66Oj0uqFYiPBdniDbfcjC++aXjbaJq5EUrhTaRJt7WNGt+0ehePZ
	 o1uN7sJSAidhy40/GIBili2YLJ2mrnrMnYu/kgMqFu583dlOR9Tf9uciGIWmWJg8xk
	 PRttAksC+SJbvve+Ky1lb14+4cz8YxTsd2mDoNCMlLJhlwH3WJGfSK2ogfKhBW3ueM
	 T7n4e4ND9Nxlwoy6Z8WkSqzfrW/LRuE/74ZbrPlGxjnVwSOy65h9455OjX2QVudgss
	 2lzN+FIvhtwKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CC3581195;
	Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D24849B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39E6A408C3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FSz7nepi59tU for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7DD8D40896
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gXRqknr8
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DD8D40896
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98D4D408C3;
 Tue, 17 Nov 2026 15:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA31F000C5;
 Tue, 17 Nov 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927853;
 bh=hA0ReReI5zdh5NkkyoGHdU00/F/jvo6SVR8206de7g0=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=gXRqknr8QMash9L8cPN1usNnK8+pdF9nlITXhJ1RBUUmIjalqFTbc0OoMyNbDKnZQ
 RUAnhhpocvi/8d/mJr8B9qQzqmJj6HlyhHNHWJSJ3QEDEHptrPZxBPCtDxSiNjsjnc
 dXOY73uRZ0iuNnm8RbZnLCxnFrTprRtSzrvi2VWAdc7E9T3bedLuWS/yBynxEmGHCH
 IhGUhdbh4tgOGeMoRZ4AxLzeg6P9MlBBouf8wjOIyrAyCDHnjQofOrLhPurVbUtnJO
 sQRb6DOCPu1PrvgM25Xekkin9Xo1H9b+BgeQIqVvdvqHzMCV8gcNL3jNofLGvehJpc
 /Fk/oBepsc4kw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] usb: gadget: f_sdp: drop an empty data packet
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <c8ea2d0b-88cf-4499-9e80-8433e1acab6a@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <c8ea2d0b-88cf-4499-9e80-8433e1acab6a@gmail.com>
Date: Tue, 17 Nov 2026 16:04:03 +0100
Message-Id: <179492784365.252888.14543908917482879599.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=672;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=jgVv9eZKeXheobz4BDaidxSY49NXVCvCA3xsPGVywmc=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/GzohoQS2wuCUWO3MMEXokE6mM04p1MQOmnH5
 oO8a8UFG3OJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavxs6AAKCRAZDR20Zk4Z
 NSXxCADg3wz4cd8yn4YetltVhylaPO2jjhSoMgRmbmftEaOcIaHo8k/K+ZO21kU62sPfA1iwnCj
 CbtX3rMEolAlvy4DK6dx41MkDsFp9HmaO/TJnd1vJ1/ADfQujde/PzqkzXDf77YYFuQ+XLWX8ga
 +YksfdNoa30xe9woxvJ7b+FnXhMYR9N405WfozH/ElgjXniIm9NfIWUhlCXSZF/xwfcAgW40ciD
 tO5QJP+nft0CTp89olu9zhEgWOBlFPOHObDgi8P3CiEFZh8CZoa9Cd50XmUXRHmBrJMTrpr/jCl
 wC4rXK2/6h7zEIE7XFk+ZJWjCg69hiy6+hhiu3wn1RXDYts4
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 07:18:05 +0000, Ana Bobillo <anabobillo3@gmail.com> wrote:
> sdp_rx_data_complete() takes the payload length of a report 2 packet as
> req->actual - 1, one byte for the report ID. A completed transfer of
> zero bytes makes that -1, which passes the dnl_bytes_remaining check as
> a huge unsigned value and is then given to memcpy() as the copy length,
> reading and writing far past both buffers. Whether it gets there
> depends only on the stale report ID byte left in the request buffer by
> the previous packet.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
