Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAA4C98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F20040B5A;
	Thu, 24 Sep 2026 08:59:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6F9IcPCCGIF; Thu, 24 Sep 2026 08:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6053440B85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240344;
	b=YNbsTtTR+trKzzyBrs6+BrsbSxY4pNs7g1JC1/VYieCFZZBN5J7PQvj9xkiGQLgBQqMM
	 KbH7cNdDkrmFUr4Ip9xrKGOJ41wt8av8L6cAGH8E8cIBBUlB5CbCr0wE641veaTgRddUH
	 dsrkVDEW/KWv8gofKiVsN1WJBdaz742eK/NM2XWZ1nIxqzNHqdS+rhDjcotwD9UH8uEuR
	 JacovFbujOoNBE0Nc5Mcoqke7lwaUudhJDEAsHxE3yC9E6SxpKyTCCkDQ8c862xy+utgT
	 tMH85OY3b4cvE9Tw+i/m1Aa4xlk3ZumK1jWaXbzxWotVsNXEQ75yn4tSNoahx4X8Jxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240344;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WKSCr0YBBti1ZJGH14TiILGe01xYHaaifQKcz3gtZag=;
	b=m93G20pkFArsW3A0P0XKejTFNbZ6IOKaNpD/qRyAbXVIBVFb7AGyTJ1kTb0/de4Favjz
	 6BAgbm/9RGt9aW0RZlVgJiCpx7ZmTyT0/DEXXY2ahUnhTGLH9abdo2JLhrbbNDVlYTOxb
	 9HNW3KvCly+MBbWi5B4pSQMj3irmV4xIP+xhPwg1cZ1pzSMtJvS4e/+09eCpO6eh4jZEd
	 agS5shpNJNDeC5P+v+SEbGB81nP+5bO37sQiqCx/I2yybTtg7eUC6H2aAukWiQg5c6odW
	 7HH1z8VEFCFMwsEOXggr3qaIAufU08uKvmLTGbpozm/zOYP2DrU4fDsdCABAsX51fhA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240344;
	bh=WKSCr0YBBti1ZJGH14TiILGe01xYHaaifQKcz3gtZag=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pfeEbDyc7/MxpgJ4k+wpHbkMy1ipgA9zJPe2yPOgBSBFfDBKAokq7PDZ80JoQot/A
	 1HgPhtZO10vfpMo/O2baD0b1EErSHOPEIgsAVyggtYIiFwOQ68lkZH2r5Hi804Q0Hh
	 le3Iro34LLokiZ0VxM0HdM/s6USgu6sPCu5ik8HvrGFt9TsXWK4L4dH9XFAxIC8MuQ
	 HjcUYQBbRBtJ4zt3SKpD17Wyia4gDPl3ZRuASOoEa/tkOOfEy1zNrAPa5ohDlX6UwL
	 zAlSIXSBOwzcBez8haFzsh4/F/pwO+3rwBgJwVFubMeemvROiKeKfxLfipNEjhHVGh
	 S7tLASoMjFboQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6053440B85;
	Thu, 24 Sep 2026 08:59:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C613D3B7
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDDA0810A1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHRJRJXwJJSY for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 03:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D2D2481086
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790221664;
 b=Jzpdi1lf/P0QqXgSJdKWfkQZTFOWxf/xi4SjA/fPlDdjJKxN4pTaZ8TIrhDwV6hlmdyw
 Sa87whqMNDI4IHSxyDLjOWTK1F/wglK0Ht1h4dK8Xcs0veCygpOUGI/cr8X7PcesuDZCk
 R9xDS9Cp8kqWRmgg34vn3VcogPUqaZgVkn9G3drIF41Vb0oDpvbU9ADD0RE4UHZS0SX7b
 +QPTTxLz0KFIWLUWP5FkrVIeq6JBHxfIC8HRplsnoVkOJfexs7nnAl83rky8ZAn+yqmuo
 EdtCIXLKp/YrFsCKxBDqbUEn5zkyuXP1uP6pO4287d7RekcZgUJps6d/oQYu3BVcL2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790221664;
 h=Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
 From:To:X-Mailer:References:In-Reply-To:Feedback-ID:
 X-Zoho-CM-AccountID:X-ZohoMailClient;
 bh=WKSCr0YBBti1ZJGH14TiILGe01xYHaaifQKcz3gtZag=;
 b=dpoPKisqu4AwsSBMin22Ml4tbihxlpWYEsPd+LOoPj4/vigH0+iwRLLX2xerBQkB+sVJ
 l8DzmE/xGLkGbgjYF67Vvs67kKNS8BSrB32tbuyyjiaJ+m/8OQ2/x/kmwgd2Kexzy0rb8
 oGNjCeucUBTVihqNju8YtGT5mEnfqI1Y7WlTM7Z6zW594oX0mgzTwfWX/5doeAxKkhTLR
 WT28ylc4Q0OAsUOiSQuOxjOagydOjhZfVFO6hKKIilsq2Fe2JpB6XUx8C/Qj+7E5pvIAc
 f3n0BwG4OdCN7Fx9JeQM0mCuj5if60gYJ3duvTDg6D/Pzr2wLuT9VriGKoojJaU5XhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=dyePPtK7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=dyePPtK7
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2D2481086
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790221629; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dqdwuajH9dRi41acEgj12qoqrpXTrGUOEEcTaZZgg7d8CnQWuzaE6yPOYMZVouIKgHcSJuctZuebP9+lemBYGNFqE+GV5GXA6cmaS+BfavmhJ68mnK5RUsQ0hKW+o8RpOsIYz4WSoXkl6SnNrRWUPAICSTZgPdXunItIaZMeW+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790221629;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WKSCr0YBBti1ZJGH14TiILGe01xYHaaifQKcz3gtZag=; 
 b=nsMNib1JAb/mx9JN5ycYkOAcsMEJCKEDE/b0N7mWkEbihx2hKh0Fz61PcoKJp4ZNWwN3x16g6h7u415avz/764/SkrzjT3uaVkikdzdmEmtrYp445JPsopWeDTgkf085P9bnaW3j0MOD+mqcpkKlNCfD0ddDGtakrHaczkWey+w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790221629; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Feedback-ID:Reply-To;
 bh=WKSCr0YBBti1ZJGH14TiILGe01xYHaaifQKcz3gtZag=;
 b=dyePPtK7KtB1ZYbnGGI5GreQgsL+txCWWH63dsDCemArEA1xx5qwPEEvN06sKrhV
 LRhqWqZQyaEYzqgZFnXqIMzjCm9b1bewMMcK64LgiwhSXCnnJaHfD1cOFETTMV6jbSK
 nE28UaFf2cNo3DaqxZ3+FQBG8Dh7FhGh+AUl2OfY=
Received: by smtp.zohomail.com with SMTPS id 1790221629038378.15848760659264; 
 Wed, 23 Sep 2026 20:47:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:46:57 +0800
Message-Id: <DLN8LLB3CDHM.3OGZWFAAO14M6@zohomail.com>
Cc: <guodong@riscstar.com>, <hfranco@baylibre.com>,
 <jh80.chung@samsung.com>, <junhui.liu@pigmoral.tech>,
 <leo.liang@sifive.com>, <lukma@denx.de>, <me@ziyao.cc>, <peng.fan@nxp.com>,
 <schwab@suse.de>, <seashell11234455@gmail.com>, <stefan.roese@mailbox.org>,
 <thomas.bonnefille@bootlin.com>, <tim609@andestech.com>,
 <trini@konsulko.com>, <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH v3 4/7] riscv: milkv_duo: Use upstream devicetree
From: "Zhuxu Ran" <zhuxu_ran@zohomail.com>
To: "Andrei Lalaev" <andrey.lalaev@gmail.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
 <20260827173540.621755-1-andrey.lalaev@gmail.com>
In-Reply-To: <20260827173540.621755-1-andrey.lalaev@gmail.com>
Feedback-ID: zu08011227814a41797ad2723bf8f83c800000637e20c4a05c287a213b92306d0993bf9665c486ef4900168b:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 24 Sep 2026 08:59:03 +0000
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

> However, this doesn't work for U-Boot because it places its stack
> and heap near the top of RAM, therefore region in the top of RAM
> is not reserved.

Hi Andrei,

Thanks for reporting this, and sorry I missed your reply before
sending v4.

You are right. U-Boot selects its relocation area before LMB
processes the reserved-memory regions. As a result, the top of RAM
may already be occupied by U-Boot when the coprocessor region is
reserved.

In the next revision, I will exclude the reserved region from the=20
memory available to U-Boot. The Milk-V Duo 256M has a similar reserved=20
region at the top of RAM, so I will address and test both boards.

--=20
Best regards,
Zhuxu Ran

