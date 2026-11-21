Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3C606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NR5KLN3/;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=D589uDYA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6274D406BE;
	Sat, 21 Nov 2026 22:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5TTWx_iZaKh; Sat, 21 Nov 2026 22:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DE60406B0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795298930;
	b=bTRQaHtcdj0mkKZmkwzZuHD0+Y5VsqEnU8hgXGdhdku4muG/oQBeosR+5aHiFUFBCq5a
	 LtNeR0aH9Jtvn/EX7ZDfaF0Ea7URwSCJ5ga7eXjg6mpSpW7IzcxUFwJt4bbqkVOxffgVu
	 DPj6VtTPzeZ/OoxyMIRSmeFV7KNdfKV9ypTBXEpUTAXBhOA/C4IGtNk+FxWIb6g0HrQz8
	 Q4GR52G/FU5qYKSr/VdzHTjGNfNCR98DqSbndiD0fckz5t3o68tDbt0KqCsoVDCrJ6lp2
	 uipDGBIfd1z+4SLT+DEUFfvBlFQXjB2n9KHltSaIrwWRZN6XeARqMO7JCg9y0HSP61w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795298930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ajx3S0Lia3iJNdPbOKYyvkP5PER2Lfl4TlI1TBwMrGg=;
	b=Tpd0ppgjp1tyxPUXt6k0t1xxXwPEwowSYQ0bKE3ECkH1PEKX5jxhV8cWbyjp9yVz0HPB
	 GnRkjQ+W1TvDJV0zchkb6dNzybmy973CIhvkiWqVApWAwnPXj65OfMSXIenpmtg3XilHZ
	 yWpbxsSQtKLO6t5e6oQgOkNnnZwCR6Z92eVOQ7A//0q4i+2Whwl3nDVcOW894/crnUv9K
	 i2PUhP29BLTCYhICK/etqosDUZYcriuoPOkJFhEfl+wwLwHzrgAiN3A62iKsAyLsO0Uh8
	 KDPvrmRjfvOYoEP0vwjC1jliOEamfTj581mbJR4vvQ/OGnFvwXBdBPrF03MpPiUuWUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795298930;
	bh=Ajx3S0Lia3iJNdPbOKYyvkP5PER2Lfl4TlI1TBwMrGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NR5KLN3/FGZVPTIExkfiy2TXxOuEcIzP3+UZgtx48l/vY318cOs6Z/3H4sCFgI3yl
	 54mmPMFTx+wPhJyhaMGyjNMCHnlLWAOgAVpB0o/A9VZUMdNNgZN+N7KkSwCkHKwv4O
	 uvoWlvEshKyVA7ooZNM5T02pIzj45gb9je50g59x5iNwNr12h6jVc3PGqy1BezKlrX
	 tbqcTDJ6mgfcsFZWekT7Si1h5/FyAJHTy469gD+6KgQU9khnanidI+2T+LITrEdwOC
	 KrJvP5C7OqD/sX8WV+GQDvYgwH+pO/IZEqlYZAlJ1JaZuSOpIV2OnHLXqo023aj/Rh
	 WRPcLVUQIzqLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DE60406B0;
	Sat, 21 Nov 2026 22:08:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 979E5310
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 892F080CB0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpTeeWKCUfkw for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 22:08:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE71F80C94
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=D589uDYA
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE71F80C94
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:08:48 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-572a102ae27so611684b6e.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795298927; x=1795903727;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ajx3S0Lia3iJNdPbOKYyvkP5PER2Lfl4TlI1TBwMrGg=;
 b=D589uDYAfnwfBqSRK6tnijH3Fd1rLx2RRHi93nH+qmFeFiVNRnMBmCGr2oFhZqkM3+
 6fHJFTOIvEoJG6B1E3u3CpvpQFwwBUh6IRxh/X1kLlssgbNBuJlSQu4F7Rv4qYI1nuCc
 iLMWgRUCHrJDvv9ofJB+GO+vV65bkA50Kcadg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795298927; x=1795903727;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ajx3S0Lia3iJNdPbOKYyvkP5PER2Lfl4TlI1TBwMrGg=;
 b=2Tn7j7+nTi2GbbNjo0Y3CUV0FsypAD9/rsk5b/031r2fQGGqSx4ISR1FdU+IPRgaPD
 8bGkEp/0yMt17i6TXBwuw1TBX7VY1MFPGTvEkDbgUIH8loW4OS6R7T6HM1k2KgpBDhpI
 QcuCHx8Ejv+XeHt+yfoXF+1EZAz1ISQ7ddzXRg9Y+82RKR2EPBz4CVU5aOFqVjETstAK
 WSTg5U2TNAmS/O6TWBVUXttPwR5BwGBTybM4L2j+bm1VD0n9AzPRmHuZUodgrujDIGx+
 tbIJNfExsws56jf/zRio7WoXtEp2hzUT6Hix94T0Eu1Ee1+nAU/0EvuL2cfDgeod54dc
 e2EQ==
X-Gm-Message-State: APuU4Z8pCik+jExdNHE4MCEtcTZTEZwE+g/lxuDCeruqWqH1ucXT9ggO
 QZj+oI6vOeCeZCX1kbOpbA48O3MCpqutx3FbWFeZ3iGNsmS0BJU1+oMZBPNzMizjH7kN08W96AR
 LYQd6pLBWvA==
X-Gm-Gg: AZFdTZfIRF+WoI9zTgmMcEMWErLV9MyHNkRlkEULBhYsmr8ScLr+9xpNNqskDp8ZswD
 dZDfcOBGqU3/5K1ke055POSjq+gZqpJe5Ny7ayPyIQ4mowm9MKLVIrYdJ14gBzrV8HqYqO8ogRJ
 OIKYFJSPCKJKjVPkcot9k+12F+DGuXoWfjjiTHm+zr1lQEn39rfq33CMhaEpQXiEM6cUjGgHkW3
 iNncgcRirUDSurzBlD2LGfBWPGDx5203emNN2Z42Go4KIR/AkoHsgqNml/qVhGyW1XopQxPosVS
 8PDtOY+l23QapZ55XvScC2e3JrmvcljnBA0VBL/JyxVnJLLMbXDxOhkdCJAxFrxFGvC5ZlGTSJl
 ji1j7bZHrlHHGspZBQgZzPU/P/8vm1lPbPgZAOYrVPsZmitZJfCplCtzuupYMmfC9SkSlIwtFOB
 xlS6m7EijNxwlzY5CwjY6xmLv4L/v0UM1Fw6xh1Kb5RrsVT4V4UlnTqE0adq28fCriAhMfYotKa
 R1HI7VAuvLdOknIXXl5LyY8U+UAlDSP+icO6xRH7MEzKgExNJWfr4uJ12kcQ2E/iuh6v917jPdS
 TrPozuz0s+ppQUI40LPjl0ELYLXG7i+ibDfCVQecLa1ojUaK1TnhMHv/1MtCxzAOyOnvR0JdQpW
 mDjla7tu4DBPeI4pE6Q9EPTsQ8f6IU2I/OpYny9S5JhCog2TIBe0cB4w0Rj3yVrx7x4EKzo6po8
 qUSiE3sFTHWZh9ecZjxLFs98neKuT2eQ==
X-Received: by 2002:a05:6808:6410:b0:552:2c0b:905f with SMTP id
 5614622812f47-57a0a30acb8mr7998472b6e.10.1795298927390; 
 Sat, 21 Nov 2026 14:08:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34252251sm5666593b6e.6.2026.11.21.14.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 14:08:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <foss+uboot@0leil.net>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <20261113-take-over-rk-boards-sjg-v1-0-4278c885ecdf@cherry.de>
References: <20261113-take-over-rk-boards-sjg-v1-0-4278c885ecdf@cherry.de>
Subject: Re: [PATCH 0/2] rockchip: take over maintainership of Simon's
 Rockchip boars
Message-Id: <179529892633.1359575.5731288930003873482.b4-ty@b4>
Date: Sat, 21 Nov 2026 16:08:46 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 16:46:42 +0100, Quentin Schulz wrote:

> As suggested by Tom in private, take maintainership of Simon's Rockchip
> boards to make CI pass.
> 
> I don't own any of those devices (yet?), so if you own any of those
> please consider officially becoming a maintainer for it, otherwise their
> support may get dropped in a few releases.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] rockchip: fix MAINTAINERS entry name for Rock2 Square
      commit: cc65877a70c9414f2e198a76a9b1fb52d5c28e8d
[2/2] rockchip: take over maintainership of Simon's Rockchip boards
      commit: 38b5b253cba3c6ad43d67e1692815474d4936999
-- 
Tom


