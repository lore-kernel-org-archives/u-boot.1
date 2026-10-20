Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40585606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a5KPMNvq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwuxCpkc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15196407FB;
	Tue, 20 Oct 2026 08:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wKW_qydhA9Cu; Tue, 20 Oct 2026 08:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 77118407FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792485123;
	b=ApT63wQDblgu/DGC1i+dd8pbcxQDMoc0sIS0NncjNqN0S+go2hnjKgvODRWQSlHTYxCU
	 XBZ/xVv/h5HYzpLJrOZxFU41FqbUv40ZMWyKWelWZcqy3gTjrtPIfhSpsEnYF8QiFJ6jI
	 TZgdbz5Wb47kbqaYzhcZkrNM+cTzATMrMTBXEnXtxW878CdafUCKZfuFLXZ7uxBGs/mQr
	 813w1cViZ6hLZLoV3V/nY16nl5YjNfv+uP7jFHdxdXzaACkiZazEoJbJnzxKY6vYTu5xt
	 06Nlc6dxhKq4bXFOlxfmwDwiWUqi38Y6JpAA387zjcqiJ2pkdtXqaBDi9S9+bNRkqrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792485123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pWrb130jyJxKJ0bf3BxKb/qlzNvCj/Z6EqDiys3xHLs=;
	b=JhWX0Ru7DBfR4fH7V55dsaW6Bo3t/qAPndA6eopAFou4mnsFajHy7KiOM4FUdaIL780i
	 QYyeZKMxztpU8mOsvZcQ81yMWCcWj1NKUoWAkTMYCWPUtiLwpHBo6UdqSULV2DSpfNpbv
	 dD3zx/jfpu6NEF9HmmgD+2Eg+GYtfYOvK7S1trYu0LYrs8zXgRvnuL1W27Xwif2SFl8gC
	 bYYbFqiVqtd+aBqyC2DNbATwvHxyYBKFokgPHSNGuz2Q4RnOIHVhXq5QoTwMsPhCUk0As
	 fGKzmRo07xwROrhvkqewj2TVWilmxa2teoYtA5Z3jqJbQ1QuJOHVLw4yfHE1vuR8W4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792485123;
	bh=pWrb130jyJxKJ0bf3BxKb/qlzNvCj/Z6EqDiys3xHLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a5KPMNvqABtHlssDWil9fyX84xJwUu8qc7IUeW/chvKlNHSgSxUz/nYIaE1tBda50
	 zhLT3qBm7lM0CxuaOT2IiyR44TR2v9upJnn9lKN6b+iduk5pFxu64+o1ILQWpjmFAY
	 2YkqUs72FvgsRp8OIrtTRfL0vrnzpAMuNTNoW+Gsd327wnYqRKcDTexrE1BxI8hYjL
	 ynqc2boXBJ72MRwWXStVZe3S1BiFILR0Hul2yjxqjerDw7VqNKx5R7MFcnJrvLhE2B
	 KwmnT7Jc0PBVb9GBCtMzYJuRQOjIqFs+6RfPNT86lyMr2CSG3StzFdUYbIWmZOTsmj
	 OVNNLfWEr2cMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77118407FC;
	Tue, 20 Oct 2026 08:32:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CBC591E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A46E48107F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1I2z71zhrz9k for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F30FD80F34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792485121;
 b=gNBASwDFejjqcS5sdgnSGWzgR2N3XPpZ8DCuFzjpKlg2BbX+ibCv3rZ+T7S5sWaywgLS
 +BBoiiNcDQtGq8pndZ25ktqiXfZ28f9JZIIXBGUZaYr4/eHYwsF8ZeyfPUWSzJqqizimH
 cdNt3Jyc7w5Gatg3RhB0vKGwyTyECuLpSp/pRfDEYxT+jvZwXPu8AGMF+pClflMRDkdjL
 2lYhPZVgDmWP9vzcgFoV7m+yhC+5O4YEYnH2BJd6IgSxpnk5OTNVVagiDqJmtIpNJ4iUA
 HxUdm37XdB3OU9bkWW6Tzj5XrQL9fjId0C+g7PuN7cBB+OnBxI0hk7en7rDS1D5ONYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792485121;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=pWrb130jyJxKJ0bf3BxKb/qlzNvCj/Z6EqDiys3xHLs=;
 b=mtdH9pho07q7yFqmocDRYAnq8M6dwpc41BJeWrZEFnnEcFvcyKo0CeyGP2TwVgGCV66T
 6jnz+R5zaMIVB8D/JwciyyL2C7Q5peuKkDfoIxX1nPiMEGYOGJbI3gKggA6u67o1mQpfA
 Lxa8PS8BrscCrQFsf2zoUgXvqHufOrPPwqVR9YNw0Jk8PhIfTSAECJGWtqpbrFPbNadm2
 dGtlYodVILIsW9mAQneiYLD/xO+KxxTRB7JWo6BToqCuO9yHAe9i/rSpsdLmoelzAZqni
 CU9qsPej9d8VZE4ODQmH6K38ZL0vyc58Ql8uQSIGAAi73mBgAjFyTHI4kmrhojYaZPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VwuxCpkc; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VwuxCpkc
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F30FD80F34
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:32:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2C2360229;
 Tue, 20 Oct 2026 08:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6411F000C4;
 Tue, 20 Oct 2026 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792485119;
 bh=pWrb130jyJxKJ0bf3BxKb/qlzNvCj/Z6EqDiys3xHLs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=VwuxCpkcuJXfS3z+xbKgNgw0LGjtsJOWpP0QfBC4FKFRTB+OVjYbvgDsPakBRfApN
 bmDFO4FpAi0UKnCnKHbJFknes2NiAAbG0wWD8dXENr3MFX5R1qifltns3Xkh5gXhci
 lRDJrcAHxb54Z7Y0U1nRjKtA1hVbvlbXcx+s+goIE2/7joigXLV9sqrsGs7qf8QEDu
 +GSUds94OpLCFMwntT99JB8R9aiTq2j+g3w2F/OutTIWDyCznJaAlo0FwhICi0nhkE
 B1Q/7hLmXeBDRlxDm+fcVI/hWi2ynLjwZfmh0JG5G3uQiSf1VTcn0dS6sLAbapH0R2
 D96rLvy4wgeew==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH 10/10] test/py: avb: Fix find() logic when matching
 response strings
In-Reply-To: <179240024785.806974.9947901337556973403.b4-review@b4>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-10-9e5b82644359@kernel.org>
 <179240024785.806974.9947901337556973403.b4-review@b4>
Date: Tue, 20 Oct 2026 10:31:57 +0200
Message-ID: <xhkdbpkx44vsy.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Guillaume,

On Mon, Oct 19, 2026 at 10:57, Guillaume La Roque <glaroque@baylibre.com> wrote:

> On Thu, 15 Oct 2026 15:55:00 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
> Hi,
>
> ok for fix but i see last one assert response.find in code where you
> don't do same fix , any reason ?

No, this is a mistake on my end. Thank you for catching this. I will fix
in v2.

>
>
> Regards
> Guillaume
>
> -- 
> Guillaume La Roque <glaroque@baylibre.com>
