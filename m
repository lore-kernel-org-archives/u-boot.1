Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D7606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ya4jRMq/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AZg6JVrY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A063A409C5;
	Fri,  6 Nov 2026 22:40:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LNZ8wJGW-2bP; Fri,  6 Nov 2026 22:40:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBA5D40907
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794004859;
	b=thgVuAtXH5IWRlY0TKgBCZ0uBK5YI727jUzB9KPBXOv0I2Le2comfzGU7Dz6C9ywLcuO
	 0RbPxpAwPzIC7PQFFdLljly4ua38O2Q4kiCqO5KaZ+gR9I+lm9UV7Ghj8z243BjXDZI7c
	 8HFfv4dQb7Tl29HFQshachEV6Ydo03AQkW6g704E3ClGL03edPZsu9vZJixHQkGlMzLcd
	 BdKE/0tpyMyuI59oWfKkN5GP7hGlflcXcQy4qcKur/Vwr01eL9RlDTWGYYgpYg5zBSFMC
	 14Fi+JrWSu7x+53D/KoRkeDFASy9/Fuik7IOa1i+RB94cM1i3w+qehF0e/V6fozn+OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794004859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T46C1Y0bMtuGifKha6PHuGvJ7jBVolMLHhJxRl2yHBc=;
	b=BJxzULDr6zIbZGF+s7M2fiVqiwHEw+5HSu8jATG0NjFtD3Ca9XWsKLE5r3/tvZVwd8/9
	 xtHWC6oxTGZJNQH9FamtW8cllIr7K9M0hevw01HYvkpD4u+DrR28SsnZnVN/2odmuvEek
	 D5Auc6PK/FITtrWqp8Epi8ysIxjlrmC8B3S43ijbmqM2noTt5ssKExglpvpXMVYsDZ+OC
	 NaLBRanWxtcoihwuwmUPOllYzF392O2OxW0KiY8o9MrnNyROfrLDBLbhyAGMSlExYvX8Z
	 0Gq1Ao9SHQqoerI0LiJp7Y2EHMuJIBfc7lqVjSLDO5KPcyV5HHoEK0XK8yEqZFDAwOA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794004859;
	bh=T46C1Y0bMtuGifKha6PHuGvJ7jBVolMLHhJxRl2yHBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ya4jRMq/5TnJwzLgQ0R/VusVF9OqLbqEXoXNhkdT+n31LXQJJudBre0yxY/K0HViX
	 XgMhDo5u5kDrhuYH7fiJD7RkEBMC39bGonWPurIYw9nhmBJJwEBaEf7cr7GoAq99Yb
	 aoBEP2YJAVkk8B/d6kzOpm2HZ2+gU8VKH1Jxgk/84Kl/o8zJ7Nk8oMiSz0OlQi7Esu
	 vhU3vkmTaPRSRwvfUYzgxgm5MkoYXPij3OTjO/kbE3M8lSJsREaWDpNtZ9t6tKhtHp
	 jz/P5yBH57Sm5ezkNDbQcVG9TrsNXMBYV8PbAKN+ARL+/wEaWHvsr1vK3twWyIpVJO
	 iSX2P89trhlBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBA5D40907;
	Fri,  6 Nov 2026 22:40:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D0202E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E9B381404
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0kXkKAA5ROZ for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 22:40:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A9AF81403
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=AZg6JVrY
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A9AF81403
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=AZg6JVrYThcJ8iD9Up4nZ/IizRKqFVp3Dg4rQFp+Z9RIzrgHlItr9FP3s1mNKxdR/btTrbIq4ylKI26xtPJ+sw74N/0C+138PclCgFhpAIlNXh93lRNnK/eA5+8b/92cpQquQQxJ2xzRvN1MSuAfHG8F+3mh//GksPdRJ/Z1Tio=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=T46C1Y0bMtuGifKha6PHuGvJ7jBVolMLHhJxRl2yHBc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794004842245456.4243862989348;
 Fri, 6 Nov 2026 23:40:42 +0100 (CET)
Date: Sat, 07 Nov 2026 00:40:40 +0200
From: Igor Velkov <iav@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, E Shattow <e@freeshell.de>
Cc: iav@iav.lv, Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
Message-ID: <20261107-re-jerome-shattow-wget-blk-0@iav.lv>
In-Reply-To: <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
 <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
 <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 20:10, Jerome Forissier wrote:
> ...I agree that compatibility is a must and that we should not
> introduce such a change lightly. Thanks for raising the point. Let's
> see what others think. I will drop this series if it is deemed unacceptable
> or if we simply need more time to discuss it.

We are new here and not yet familiar enough with U-Boot's style; we
don't want to make it worse. We'll rework the options the way the
maintainers advise. The writer is a separate sink (lib/stream_sink.c),
so a 'cc' command can use it too. That notation is new to me, though:
more usage examples would help - which inputs and outputs, with what
offsets and sizes.

I'd like the options to cover memory, a whole disk and a partition.
Ideally a file on a filesystem too; how to do that is not clear to me
yet, so I haven't tried. Still, the syntax should leave room for it
and stay easy to read.

Igor
