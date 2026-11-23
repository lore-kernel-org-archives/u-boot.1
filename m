Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2C606A336
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BOsjDrJA;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Amc+jRla
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF49640368;
	Mon, 23 Nov 2026 17:44:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iv4ql2OJ2Sbt; Mon, 23 Nov 2026 17:44:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AEED403A7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455874;
	b=CtNvVnL1YOdjyCen7MECke4S2sCG/Hnzj4OzlJXs/rOoC9e7rfB3M8Ir2iRNDjCnFki8
	 ViiI1Er4PB9vX7Xue8VA4922mz07S1rdGByvhm5Jn6oFbusaHjdtdQNSzD0JpA1FrnKX3
	 Vt9tNL9hiT2Q07d/Otn8dtuNQwyOZajQ3L5rBuj+w8l4d8kPKOPKmopOWc3n7c9JcX4Dv
	 8W8PF1w8jl7kuD0vvh07h96yCG2GuCrFseeFKnD3ICriPUw5+pJvFGcRBzpBVSNTLT19y
	 58fiBxvU59+i1PQ0Ewh8wxzIJIgf+Ng10PHltvprxQjtiC7NMUdmkZmeKxlczVz/QQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455874;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PVfZcengufYVd6OGK6sGB4/Zdj7hUe93XcnGLPOsjmI=;
	b=qHWdK6PHHqD1aIUGq4ntAL+bjXdJw/lrUwmieqInwBfUhmr9oJWhYQpLdyr/3kf2QXE3
	 e7J/ngDS5EduBeoIDUJc5EXmVO4MdqRC5hgRDkOtkkW1ahQ7Dg9hBTTwfGLc7q5iudsO0
	 jua6toVaM0RP2Ey5v44KF0MRhu8WJLrvf2GR3s/wSDOeJibWoW3/75Rem0C1rbRbiTukx
	 SMIH6W8RVzeVH7Dh7zYrfHEs/0zO7p39wo+VZAp/Z6MoCM7nTpfXWA0SM0IsRXinIyOCL
	 Kthq3GxMcVC06J5rr+ga3H/MWd0DfCDiIZk/ql7eCTHXwv9eBvZ07DxtArVDcCZhhOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455874;
	bh=PVfZcengufYVd6OGK6sGB4/Zdj7hUe93XcnGLPOsjmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BOsjDrJAKobalskCV8Za7pnv+qJ95XSKPk/Ertu8eSmVttz8RaQ+riWjWTqs9Wsli
	 lfLb/EixYLWY4cQM+QvZugQoZ4OgoE4PN7jLYgS9+38gC2jegkPqNXjxYGhQm/Cj81
	 gmhfip1K4hv3FBAC2tPO1g0betrJ2O5Grwm09gWO0KI2kRSPZX2gpghZhpbTrZP4rl
	 nePC2lKVD2VeN2qOk4quh33RC8ISAcTYugNXEDcbGfYC01EAWHKKGqbW0FcStFPy5m
	 dzTTAA1KObW2O/iiLQYRDP1OLifyEkZVCHCCCCJ9S1rCBkjbjy/3rGMIqdc9u5w9cP
	 TOVL78APrTEkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AEED403A7;
	Mon, 23 Nov 2026 17:44:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F2DD371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1556680BD2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hZcUqi72DjxH for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:44:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6141480B86
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Amc+jRla
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6141480B86
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:44:29 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-862b76e3c8cso1632096a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795455869; x=1796060669;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PVfZcengufYVd6OGK6sGB4/Zdj7hUe93XcnGLPOsjmI=;
 b=Amc+jRlazCXG9umtakubAaf/BZNiIrB5zFhDak3R7fdxt3EN/xOlLAJGWilqm+18dG
 Od2j2jXxNtT5gO5eSwbcQDA9x1Uk3mmQ7vVyGusQEomt87xWxU2iQ0tmHnzMmseX0Odk
 zQ/4gkS35Ntjc36obtY9yizGIBad6gih46T9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455869; x=1796060669;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PVfZcengufYVd6OGK6sGB4/Zdj7hUe93XcnGLPOsjmI=;
 b=mrPw1JEEpYWaMlonUZ8ZICES4YLBe09LRe65U1D84+c44AGY29ZZ5Ciqg9k5qmS7HP
 aEm9C3A91al/mCEVHMuJy0smoJ1MnLKJKZNuhu5yNEX2DWwSSYdgZFNpy4AM7n1r8TkV
 wz3e9w8K1LD3HyRihL+V+9k0NlAjn4PUTqmaQXF1IcTAE24C5obq8nG6kGNKJ23Orlgl
 Zzy2xDLV/MkXeOtKiHJUbBItUKHsbK+Tkn4+DJxMlHg4Kj2lfCYXE+69gHJaULctiyIv
 FG5XiPSUtUhC3cTMP19x5BsQW/JNBoysPRjxu1cmAdjVZZe+lOrlbSPttgJz3m/H/hX0
 TPmg==
X-Gm-Message-State: APuU4Z+CTopsyR0hJCsAH2md+bXTLI3MgMPZ5aYxWAWw7e4tQBq9djBG
 Y3Y7iAY7GQ2Q8YzUElWNo4UjKGw+PdasSwaaL+Zo+Sv67GVyaUht8YcT4niLR+0aiuerzb1HZFk
 o/CLoUy0WkLKH
X-Gm-Gg: AZFdTZfIYLzN3QvG41a7gazo7VGBuUevTyOWtDGE1JATL2pjYuwPFil8HqSuXxydhQP
 YHTx7EdIq1WL4lF35mO4rW6huerhnmh5CeXKmAQVTJYcDQVcw7MVoskRsI1TJfQ39gNCaxC2lok
 HxIvc+eP4YzSp2LM0+OyC0KsJeT/CjZ0EaMXFKvZ25Oia7I3j19WY+ixef9O5ny/HGP9/aAzo1k
 Arsa4dgYDObm+aM3imakjl+4id8MddXpp2uJSxSD5bxYhN8UQEd0lopZLnrfN2AnY7Rs7Nmiyda
 E45AH5E5FviT8DDPXue9sqtU3HVopVGDL5bNIVD+zrs5d7ZL5OVOOQreqhoztIawo16YFTpu7mR
 67XanlJUlN8EMFy9CKuOceHyEvXli6zepnRa3TKqiwsnPWiF7G366VJS/6el4AMo8DseWuAw5pM
 QZUhXSiL/hZkdq0byC5riGUYyWv/R4VxVevm7qWjJVoRHaeEFtykcGVxpupAhyBdl4QHANI98cs
 OcV8qYanAcBLh0n0Rj2w1jWQ6ogX5yTl+2ymiN8FzQROC03Q/nSm43ZQLNv5Qn4GHXzfN9jEDQE
 yHXnePoDbE8rPhfkqMwt27HEqQM+VHnl8jgvSmYTR8YlW2SfcXGsoKZ69a2qA7UTfssaTwZrFxi
 64R6aVhQZ+bSrWb8i8MtTRq/q5LSGmziOKEB6VMPnbJRV0NngD5uVD6UMFUCw+yvesQF+o0DUks
 pFCY/pih/OjQTayjw84zBU4Fbx94V1mKiZLympBsHEWgJj/w7CjwY=
X-Received: by 2002:a05:6830:2305:b0:862:c3f1:6353 with SMTP id
 46e09a7af769-863155fbdedmr14678470a34.11.1795455868943; 
 Mon, 23 Nov 2026 09:44:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f3964sm8952425a34.14.2026.11.23.09.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:44:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <57567e59-f741-498c-aa9f-58499bbfec3b@monstr.eu>
References: <57567e59-f741-498c-aa9f-58499bbfec3b@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx/fpga patches for v2027.01-rc3
Message-Id: <179545586846.3435953.14148318254545983860.b4-ty@konsulko.com>
Date: Mon, 23 Nov 2026 11:44:28 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

On Mon, 23 Nov 2026 09:07:20 +0100, Michal Simek wrote:

> please pull these fixes to your tree.
> 
> Thanks,
> Michal
> 
> The following changes since commit 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c:
> 
>    disable VBE by default (2026-11-17 11:57:23 -0600)
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


