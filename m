Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C409FC5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E1C680E53;
	Tue, 18 Aug 2026 13:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89smDmzpwlWs; Tue, 18 Aug 2026 13:30:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27E5D80E5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787059840;
	bh=v+AKZoWPFa1Q6ySDSal9ECLNBWa5u5qdh/oTU/3iB34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nm+IBbI3EmxeeBqFJLZ8jUXvZ73moxBQKSLuPDwM++CKFOKxqU60QDm780Cql2Jb1
	 seQ9H7mxcpKKxOKEwFgtgASgUoFluUzjbSFTrhX/fc9CcBvUC88unmVVrUmvuZozmK
	 H25nJvLbx5OqxjXkVfhvBCBuvXFffF7W4jLx/KWajz5F/uzhKOYiqS/ChTMjAPqPy0
	 cOOYCJbm9CAWVet+Okd4GFvX+QMte7XXz7VFM13NAtg4to1aG8DVHTjmKxDbolumbN
	 pmcxAQOvni3VoqEXJaqvBjx9gt2ZimPw37QSGAV7PM16WhQT2J9vadwkRMol7uLZYQ
	 y6zlXc2DVRbJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27E5D80E5D;
	Tue, 18 Aug 2026 13:30:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1E01322
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7FD240760
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBXXmsBhkpJJ for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:30:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=kory.maincent@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BB1DC406EB
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB1DC406EB
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=Ljdx1/z3
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB1DC406EB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:30:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5C96F4E41263;
 Tue, 18 Aug 2026 13:30:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2977960355;
 Tue, 18 Aug 2026 13:30:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D97211C70581; 
 Tue, 18 Aug 2026 15:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787059834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=v+AKZoWPFa1Q6ySDSal9ECLNBWa5u5qdh/oTU/3iB34=;
 b=Ljdx1/z33iZ91iPTnzFfKz7raB8utdgC5ksyYJtc3jF3Wf8iwOs6VCj8/M4bSu4aOvsD2g
 S6HmjRRxdHxotz5rtzgbwO2LwC/wMAKw2VGZWjqPbD+BpR3JSiMzceyXxco+f0f9Zxnl8o
 9eb3gacI/4KGkgtXfM7a288WeHGpKZVMS5kVdSVUnhTQoy96QsPvF3NxX5M/vXEIlBdcab
 4SaElZPYmsDUZQ1FOdFz+ndWV/08lyHXdVBMVk78S06xKefVl+dZwrm1VZu0MWgjGHQfF3
 5q55IrgK+IXeJbnvlJ5KlCazKYBgieeq7jxgYy4PQicMeH98x25npkEQIyskjg==
Message-ID: <052c5303-be7d-424f-bdd9-ec4198250a4b@bootlin.com>
Date: Tue, 18 Aug 2026 15:30:32 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] tools: fwumdata: fix redundant metadata buffer overlap
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260818-fix_tools_fwumdata-v1-1-816acb404c13@foss.st.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260818-fix_tools_fwumdata-v1-1-816acb404c13@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 8/18/26 15:07, Patrice Chotard wrote:
> read_metadata() allocates a single buffer holding both metadata copies
> (calloc(2, mdata_size)) but accesses each copy through &mdata[id], where
> mdata is a "struct fwu_mdata *". That stride is sizeof(struct fwu_mdata),
> i.e. the 16-byte common header only, not mdata_size, so reading the
> second copy overwrites the body of the first and the two copies overlap.
> 
> When both copies are identical the overlap is harmless, but as soon as
> they differ (e.g. after an interrupted update, the exact case the tool is
> meant to recover) the primary is corrupted: for V2 the metadata_size
> check then reads garbage and the tool aborts with a bogus size mismatch,
> for V1 it silently operates on a mixed view and can write it back to both
> copies.
> 
> Index the copies by byte offset (mdata_size) through a small mdata_copy()
> helper instead of struct-typed pointer arithmetic. Both copies are
> guaranteed to share the same size (checked in parse_config()).

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

