Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF12C55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A817680E1E;
	Sat,  1 Aug 2026 16:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id izy7wLCXz5AH; Sat,  1 Aug 2026 16:58:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 908F080E19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785603501;
	bh=GG3NhXu51OCo3jRk0qmkRHsbrrFGj2ZjzLqCV4A7zfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keRs84yF+vNP7Q0vmk7e3hr7/Wn9Y9/D+sCeXJ53WkGJogoO4gCBoxxnzMulGPxiy
	 OjthKvnjpD/usOaVeuwX9aMqEpT7gUvaQHMbsGmGQxk5OnQhZuHp6epbPa0TJZj202
	 FfGPT/Ccjhw4gtg10XogGd/Q1oOR21lz3FsZE271cMfFYmzAsjyIinhKINbNmV0JN5
	 4caoSrZ4FQHxulZWm8OIlpl8kVZK/FsPdtovhz69uLBRLs9YQ9B+QxAcW7Obmm+QVc
	 rdfO3TMaG7WhTmJDTwh9tiAwWNH+VM0Qx6Lc28du8yG7V0mC+Zn9FNdGgPtCFmnWIg
	 91dknEyrnaFrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 908F080E19;
	Sat,  1 Aug 2026 16:58:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 220CD2CE
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13FD880E19
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kjUL_ohzJCJp for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:58:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1284080E18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1284080E18
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1284080E18
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785603483; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RIKBT8v68gePJG5cxJvGtQLk7I7+9vr29VM6XBkscjevCFGzHCnF/k/cGYQt10Bj4Fwlgja7HTEPRCn0RwHh/vhv9pH0rZJCyK5x0pEfPDe7NPS5ACq6i81Pe9Tw/yvJDuhNxFyKjJyXbGz2H0u3qGbn6huYlulAAZVINm3iIK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785603483;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GG3NhXu51OCo3jRk0qmkRHsbrrFGj2ZjzLqCV4A7zfo=; 
 b=LIfuw8y0BC+hblTqiaXCyM8mjAg2aQZpVQg7ulmKjP/ZT0h6hoeSyQ3TlK2laa5gH2rU1FQlhRsYFAlDIGQlAOJoZjnV3mMmm8AsCY+3LBBccMGjduB1TBmUQI5HRRobttfjk8fka2GMyCo9b2A+l647AB7X+nZQv2e1VM8zL5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785603481030775.3949186759733;
 Sat, 1 Aug 2026 09:58:01 -0700 (PDT)
Date: Sat, 1 Aug 2026 16:57:49 +0000
From: Yao Zi <me@ziyao.cc>
To: Junhui Liu <junhui.liu@pigmoral.tech>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 Coverity Scan <scan-admin@coverity.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] clk: spacemit: Fix empty PLL rate table handling
Message-ID: <am4ljYUAf_Abbjj-@pie>
References: <20260801-k1-pll-fix-v1-1-5ad65231a361@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-k1-pll-fix-v1-1-5ad65231a361@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.597.97
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785603483; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=GG3NhXu51OCo3jRk0qmkRHsbrrFGj2ZjzLqCV4A7zfo=;
 b=dsNsNudtl7Fua9R5JSuHnB4G6H7z+RtW6CzJvUtlJ00vEVvpHlZRgDzf+eAPjbwp
 YdL2E3tUHSwe+KYAceqM1qWE/0x1RM6h50Ur/DaFIzZvHfVq4+5f87m+YpZKe6mtheY
 ighbuHHDAZrk6ydhops/ZFUzXDhakqkeb3qrEzL4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=dsNsNudt
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 01, 2026 at 04:54:24PM +0800, Junhui Liu wrote:
> ccu_pll_lookup_best_rate() leaves best_entry uninitialized when the rate
> table is empty. Initialize it to NULL and have ccu_pll_set_rate() return
> -EINVAL when no matching entry is available.

Does a PLL with no rate entries make any sense? No operation in ccu_pll.c
seems valid with an empty rate table, not only ccu_pll_lookup_best_rate().
And all PLLs defined so far come with at least one entry in their tables.

> Fixes: 3aa2882a3e1a ("clk: spacemit: Add support for K1 SoC")
> Reported-by: Coverity Scan <scan-admin@coverity.com>

So this looks like a false positive.

> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Regards,
Yao Zi
