Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B9FC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8298680C64;
	Tue, 25 Aug 2026 16:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Mo6gW33CeQ0; Tue, 25 Aug 2026 16:36:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787675816;
	bh=26Dhzf54PFqe/p3OduVp8ihvMc5Z6gVgBU9kcIIhvhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lsqcGz9MMYeZU6HYeEaOJoCp54SO0iM66fwerh3XgSHD67tTaRPNWC/BPtZ4GgzvG
	 O2EGqqXz/DmsEg+OW/QhgNBfQVaZcg6nuCJ7evGXCR5AEuyuRwbD5NSLXgfW8PaOzw
	 RGDVovPtuytIsO4O+Ly++qlxnirdbGmHyWLn1WD6mjnPp1ILlv7eLcpHZw0LZArft2
	 be22zDeqsR7DXLo9NEfUhRGQLmbV4uqD6u3zvIhSCf/JnSWaNM7h27m34ZPH8iKf7B
	 vARjFbIk/jD+eGRwTaq2LA9Sm5icYfXrK5Tn23KM53Zqes2VlKXB+4DL+HMWRW13RJ
	 9yFjAuquFU2BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C93180C67;
	Tue, 25 Aug 2026 16:36:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBFC91AF
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDAE080C67
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PCEqrFGufiIg for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:36:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=irkorWMW
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D5E980C64
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787675806; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lKDac3HPusrxiScPLDwrQipJ3L0tzGNu+TGY5MoVsVqRUjDR0ZPDcLQkswxxoFtOh9Y7Xgpm1H/xut8z5YQ79QJch/Q/xaylLSpzkZvJVX286+wRqJjHRV/bz9kYADwso0q516V16jbWUUpXI6vky92avMojABGAaA6LHdE4hyU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787675806;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=26Dhzf54PFqe/p3OduVp8ihvMc5Z6gVgBU9kcIIhvhE=; 
 b=QhtqkEcEVnrhSdb2GqjtdRES3nMxQS5ZRcUuryrp4hoHklnPuXfvkVIR1IJuNEV1MJjpL37B+CkXWT6Z2871T4Q6zlUPwng2KR2xj/kNm+EM+Y5XRAEuDd4xGDANC5mQTVQKPpRpqXDRMWtWXt2jSXJ8o7tNkaYktn5lrvxwxU4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787675806; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=26Dhzf54PFqe/p3OduVp8ihvMc5Z6gVgBU9kcIIhvhE=;
 b=irkorWMWQxx51I553VGXYE2XIcU6DzSep5PRAfIv7UvQXucy5fMZ+1sxtNWkcqpu
 UsfMywLyhkqul7SUaqnyQG+PU4aTgzoxlphIUtx8K9WuWqiTWMwR2BIpl4KACojlX1y
 CJ4znRGzBh4UEKRxtf5hMcJi/AwV74T1kGWCiMK0=
Received: by mx.zohomail.com with SMTPS id 178767580171218.98571817477807;
 Tue, 25 Aug 2026 09:36:41 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:36:18 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 0/5] Fix logic of OF_OMIT_DTB and remove useless dts
 files
Message-ID: <ao3EghrSgV4uLRYW@pie>
References: <20260824195224.556419-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824195224.556419-2-trini@konsulko.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.669.98
X-ZohoMailClient: External
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

On Mon, Aug 24, 2026 at 01:48:44PM -0600, Tom Rini wrote:
> Hey all,
> 
> This series depends on the series to correct the logic around
> BLOBLIST_PASSAGE_MANDATORY and found at
> https://lore.kernel.org/r/20260824194814.555634-1-trini@konsulko.com/
> 
> In this series we correct how we handle OF_OMIT_DTB so that we can in
> turn not have an empty or fake dts file in the tree, when we are
> building for the case where we would be omitting building the final part
> of the dtb for use anyhow. With the changes in the previous series, we
> can then correct the Kconfig logic around OF_OMIT_DTB and
> DEFAULT_DEVICE_TREE so that when we're omitting the device tree binary
> we don't try and build one anyhow. Finally, we can remove all of the
> empty / fake device tree sources we have, or in some cases have but
> never used.
> 
> Changes in v2:
> - Split the previous series in two. No actual changes made.

For Makefile and Kconfig changes,

Reviewed-by: Yao Zi <me@ziyao.cc>

> -- 
> Tom
> 

Best regards,
Yao Zi
