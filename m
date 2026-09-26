Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C578EC98318
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 11:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2A9440AD9;
	Sat, 26 Sep 2026 11:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGfCrQEVMqj3; Sat, 26 Sep 2026 11:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0DC1940A6D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790420738;
	b=BfwHkFyKkFTa/zLsYkTAHKxVlh+G5Ak5+PaVQDo45LBs9hlVcm25cqZDQ9Fjlsc8KoJV
	 aTyvY8u29KicT1USJ/XQpsyzfD48zoI4QFUaglTu9LwYbHe8io6+TW+Coo5b1HIbdauAg
	 0RekKGJexiY3ehOt5Ig3NSxrQFyvO/xYgbmEkGtT4HchtFIrK+f/dLi5gzgTlZ619fng+
	 xv3yKhIzPJZSsf24a7WEBk8EWNZGhKxkg5TVhbGoG9RFjl03sRSwEj5PLThuHYcimeJ6v
	 zZFdcUJqLYpB2B03PTeo50IQqYqCHadKMI5BdXU0iW3sG15anOgFG+h/++3YYLojXeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790420738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PtTX7004HZTiBy49k4peU2EmKwg/P3a6Ib/Hfak0Pxk=;
	b=TemLupDM28o7FleQKPhENhcgsWJ/2Pwxce8FBz62ofT9NgPInqTC8bB9zJIEdVhYG1yW
	 BewKl9brIncKdqk8sl7gIHQg5AF9SyPlZ9aZYPtcw9GpZds8Rl0CBXnmZpbE3TLynpLnW
	 tHkdt0WK4GDPwjS+wzLxthdlE/kSK9+F+Wa9D1MQ4u28Zmsk7Ep/nGnBV3aiEMIT7BXKk
	 O+tcrcOnK2Em6IudVituvW1w0CRF3QIL2pj4ApT8rUjfR0a61JiZAoBYBydTvFBo0FaT0
	 /8Hg4B7TcmqAKMGfGW9CPLm3yXBFumP/NlYlRRydBufscuZ3tDaRseT4PmwrivpEgXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790420738;
	bh=PtTX7004HZTiBy49k4peU2EmKwg/P3a6Ib/Hfak0Pxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k8xe+Dd3cOoCbIFFY6vaf8wRTckTUHPDe4bYopscxNddWDFXoe5UwisLP4VxIDBYx
	 CtQSaxn/yW83SkYCvvxoYBENtTEgYE27aes3s3Feaih4OQicLV2Vhehtq5O0Lfb2iC
	 0FpobjC6rjxcd94FrB2M7FeSq26Rk5xgxxOFCNa6UsSG3mgo+60+bh7/Wh+Ambzwy2
	 jOvEtLVqwDP72ZbwVLKEcMpoe7u/+eHeZ+yB3SYqt8wRme48V2K7fLIIDoMdm2jQJk
	 AVwjxVz1NeBh5Mw1KpwgE020v6n+70Ay8gTVdG6RgNSN8kFm+h0sAVvZxBVkXTkvlA
	 mzTyXk4xstPpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DC1940A6D;
	Sat, 26 Sep 2026 11:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C78C6194
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9499812AE
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yuZOj6UmUEGX for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 11:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD43E812A7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::14"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790420736;
 b=YmpWIqQDGn0R0L7Xt9VsSJ5JKRR91ZfSOGQqPcei6HlacK3hqeEM2nmsWt7sLx3wJFeP
 WpIlml15zA4rlMBky5qIV12WjZY+UaOWxGNkafN3WP8QDVdpCLPBgU8Gs2emq1+d1upoN
 nIv6IPwmP0NU0fs3F/EQvX3/fNsh9VLU9T7AwrwHJ355xCuQd5Dxqs/oS9eW1f7TyIFSt
 H/1x7uB0IGsN1GNmmWwziKnZeKph3NNrzX1EerUZ+NXDoThOtdkczqdzwIAU7jwZerZke
 athy+Js+V6igjfUz4rPOvXxcT9xH+UGLbm+64MXLqyd6IF10WEpB8R15F4NhmsXQBjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790420736;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=PtTX7004HZTiBy49k4peU2EmKwg/P3a6Ib/Hfak0Pxk=;
 b=Jf7jkU4P74Z1H30y//7liB6sOee4U2Zx927+jt1+Iry0zQCQHdSNvDOuylorwvI0tokB
 t0T1bwF24ViqIb9/iqYmKKVy0Tem/K5XIBQVL/VJg+Ja6WeFxNRLnA6Pu72iOv56bDnTn
 KgLOwKxkRAbhp15bhNcUVjEQzYvduOgnuA/SVwVWE12btC3H3nxgHnl1+wgIqbN6kJj8N
 bOyYAB2JMksIjVA2rUY2yvu0q0ZVT8Vp1iluX4ZDyQqBtmCoRmtrdR1zpCio7j7NWHYJm
 /L67Tz4W0CVAHSTQgMl8BVm140pA9YUdZVaJCg8xUWMAupCpU8OkRp5SseicHZLNWsA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=mkzHGxH5; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::14"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::14;
 helo=smtp5-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=mkzHGxH5
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD43E812A7
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:05:33 +0000 (UTC)
Received: from L30177.local (unknown [78.242.61.39])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 2923960129;
 Sat, 26 Sep 2026 13:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790420730;
 bh=MVTmH9UMOMOrbP/EzKFU+lBEMX15JP829v1VoWA5leY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mkzHGxH5PhBQlQeGvelvYBnTAAAkbbwbtscBBGJB3ooGwXUK3jVt3rYNv4Rmu+g3/
 y5XnKs+XYKbuEgUb8atck8/senl0eQAiBI/KbeDNcaDcfg44Mv8tFqpndarHY6eTo2
 NgjmlDFwC84Un31p7z2YfWU3yhEBENwyGx3DrCQZy0vM5jX+1v12xHNGt95uO4njH9
 R4G3xI3XPxNZWuzvtQqtnl3ZurtNoW8tVy3+bjzUxE10MEaMPZYrTRvrxz4MFWQYwr
 9R9WHpcxEty9fMbfwkmLbwD1KTnGJSKYyGVKEqi1TJ5Xk0yNL1q/wj1Tfhx/YZXgH8
 3KTXJFNTI2hgg==
Date: Sat, 26 Sep 2026 13:05:18 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2 1/5] lx2160: add lx2160_sd1 100g4x25g and
 lx2160_serdes status
Message-ID: <arem7uLl5jR5QydT@L30177.local>
References: <20260914170417.3052423-1-vjardin@free.fr>
 <20260914170417.3052423-2-vjardin@free.fr>
 <20260925134846.4tazuavdyax5zdze@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925134846.4tazuavdyax5zdze@skbuf>
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

Hi Vladimir,

First, thanks for your reviews despite some structure issues of those
series.

> Why specifically for QDS? QDS has the board_fit_config_name_match()
> implementation which picks a device tree with mezzanine cards based on
> RCWSR28. If the SerDes protocol has been modified by splitting/unsplitting,
> all assumptions in that device tree selection process are wrong.
> At least, I'm not sure how both mechanisms could coexist in a sane way.
>
> Why not for the nbxv3 board only?

The QDS was the board I looked initially for such support before the
nbxv3 board and I was trying to highlight that it is a generic capability
of the lx2160 CPU's serdes that I was able to field confirm, it is not just
specific to the nbxv3 board.
I no longer have access to a QDS, so I can focus on nbxv3
but I believe it is worth keepting it on QDS too.

I did miss that point: you are right board_fit_config_name_match() selects
the QDS' DTS from the SerDes protocol number that had been set into the RCW.
The case 13 is missing (2x100G for SD1).

So for the next updates I will focus on nbxv3, and I'll check to reconsider
lx2160a_serdes_apply_hwconfig() that I did use to make it "hw independent"
following some other "freescale/nxp" cases.

I would still like to keep a way to use it on QDS along with nbxv3,
so the generic code remains in board/nxp/lx2160a/

Would that be acceptable to you, or would you rather drop it from
QDS entirely, but then how to highlight it can work for lx2160a ?

I will answer your other comments on the v3 thread.

Best regards,
  Vincent
