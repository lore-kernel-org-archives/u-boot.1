Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BD606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J89quAz1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AkywdcHZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B1B280FEF;
	Mon, 16 Nov 2026 17:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkIaF59QlooH; Mon, 16 Nov 2026 17:11:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B744380F40
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794849075;
	b=LpFIwuoVKAQ/GzRSyIEbb8mDHvStjuweWAnu6SmHvp5JGQxQVJIdB4c1HGWGKF3zTqRL
	 oBziUqjMJ4iy4XFP/mXkfANVw1OpdkY3h+Ts3jjXnVtseOui4Qdkhh4NEhac/90ce7/wm
	 qE9J691D2ei65bFS+LY1JbzpfdrM7HrSpLGs/+nZYOycaz0ezm4c/PW99mOOE5nXB1enZ
	 kSKXsYwol0xU63iBBhnwedB7scY77rHJibACmEpfPcFpU4tmXR6ZmKhRJmvXaHaSgDkbN
	 PhMaDT+It72hfoCU2JedElmRs/0161t+tllKcXmlSZAyF8wcOE78gHXW6G969cM1Vlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794849075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sk68hwXuRLA09/jT8+7HiDVF2bfKmntY0Efor0qNFF0=;
	b=qE+HRm4KYgVSverzmTfouuoczvF6hTQZ2lmhzGggStQ6Jy8hB8AzpsGV97cdv7PUmuzA
	 bvnj8bUpYi86+LXAEvu2hopCyt8IpPMDh6SMrMhuJjCqBntptyE4WHr9kmAKfUaYxv7WD
	 zCY+3+X6UmLglyMp/EnuzbKfMbn0eRoIGA+Nd3uDr+iq06op9d7Sevt5YeJcrf+rk/g55
	 AstXt7tX047mhdolMPlb83pbyzupjjNGHEOhgm5cvMTxBakDoyONEXXMpi56qiFpvZY7A
	 qZKT+iE50hrI3tK3gHO6ZJC22Cb5NeNak4b6WTXX1vg806sRRFaApUMsmHN1QL8mr7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794849075;
	bh=sk68hwXuRLA09/jT8+7HiDVF2bfKmntY0Efor0qNFF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J89quAz1kTXokavk16CKH8oxJo6fCzWdNpVtUktIhrvwreC3Ry9jGPWHaRcPp1PoC
	 DKE0F8IUT+sL04RHeSDSPaN598YP796uh8tjVEScXA8L7oxLOXv7tc4SwVv5ZG8FUj
	 MK09WyYGTemAE2XO247exikXvzXbsUKmoEhZM3HSTDBf/ejtzJkKVsVK81w7i4IV4T
	 xxkhzg/N/dyTllk0zLox6iih3rtF3p3a6CyC36iMMt4Q8MFJlOS71VTPYANvgopuTa
	 bbK1W3OvDbh05w4cJTdzueI9exre0HXnd6D6B4ZX6WXhNjIsVfW0pSyUhH3DTq9RAq
	 wy1/Y4z6f7eEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B744380F40;
	Mon, 16 Nov 2026 17:11:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C93C4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AAFC40282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VdiW20VdYQR9 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:11:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1DD204009E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.16;
 helo=sender-op-o16.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=AkywdcHZ
Received: from sender-op-o16.zoho.eu (sender-op-o16.zoho.eu [136.143.169.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DD204009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:11:09 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=AkywdcHZHan9idKsL0mFotZ++ruMJPtlO0NQvbogFrTiNeAwE3nC5EY/hmqpNt7uhVcgDSGl9kUeL1hDFdsA2DHTa7jbyLwq4I2NgzIZ7Yys2E9TRZKDkpaTD7edA80bbNFKNOl84RnYw8l7lNy2BTR+ji56UNRVk5+Vp21YCOk=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=sk68hwXuRLA09/jT8+7HiDVF2bfKmntY0Efor0qNFF0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794849054288817.8221193722947;
 Mon, 16 Nov 2026 18:10:54 +0100 (CET)
Date: Mon, 16 Nov 2026 19:10:53 +0200
From: Igor Velkov <iav@iav.lv>
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH v2] board: rockchip: Add Kobol Helios64
Message-ID: <20261116-re-quentin-helios64-v2-wait-sync@iav.lv>
In-Reply-To: <49c209b8-edb9-40a1-b6af-0c1f7d243306@0leil.net>
References: <20261116-b4-helios64-v2-1-3631141e429e@iav.lv>
 <49c209b8-edb9-40a1-b6af-0c1f7d243306@0leil.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 11/16/26 15:49, Quentin Schulz wrote:
> So, we could also just wait for end of January and not have to need
> additional follow-up patches? Even a few days after our -rc1 is released
> is fine.

Makes sense. I'll wait for the devicetree-rebasing sync and send v3
with the vdd_log/vdd_center nodes reduced to the 950 mV settings.

Igor
