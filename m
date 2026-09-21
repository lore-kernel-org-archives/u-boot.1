Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105CC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB2E4606BA;
	Mon, 21 Sep 2026 13:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xw7TnB7i_51A; Mon, 21 Sep 2026 13:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AFD276064C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789997959;
	b=PeiCAwwPLRDWfZfF1bE+kWLqW7UllCxLh8hxSJndvLE+0T3RvDo2LnwCO4ik7w/H9NTB
	 aeW0ZANq5k29FQEwXaBzEV/RgM1hw6jaKWkDGuhhkoSz8yeHKGmvKQP2Won9vfF76Uaod
	 vVpyai/hNci9JO3fhOXoKbvm86NVGdieriT3oukPDcxq+mLdFRz27qhwYr2B4GAKnZwjw
	 hY1wZbGWnH4YTelBBDK5Z7qub1UYyxxhUBnxBTRXQ7tZQ/WBb/Waj3/BbZPF9IOh5avO1
	 01r5WKkalAqVFaqevTnKIabZEoFBaoRFZRWNC0NYW5Tj8D5Binp5deg5zvf1FyYV6rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789997959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S21ttEJyjbGFv5A9SoZAMEqNdqWcoaZuIfJbUPtP8ds=;
	b=Gk9Y9o1D4mxGqC4UiwPdqkgKKU2kkY29b8PrX3E/2rMWVAuxgD8FAZd35OIX4NY+IQQJ
	 6zblMnBU+4v7G+P7qdwTIkYUcxgi6mR/3kJ8WngNOsW4YWeOkBT06beBAFQSduqXXljqw
	 TGwIFAdJdGJJm+xz4cZTKe4URjPel3FXbLC9bjQwC9+9ceXMGeg2ajrdtwmUQds8rN9Iz
	 tfCmA6xbKT+NNmipn7V3OQS3ac0T2pgfsewRGsdYlXG65s/1Mwx3HfjKzjiCyjG/iMs/T
	 pnBGYGNrW3rfzjUmpO0spaPMzNNS4cxA9/xs2DdLVD9dVZAKm57yMduf6eqj6jSKi+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789997959;
	bh=S21ttEJyjbGFv5A9SoZAMEqNdqWcoaZuIfJbUPtP8ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVPCkpxQ+76pFKDN3kbDM8sD2iGIftJHVJiOAU5aDHlc8FlE+E8xKXuqdNQVuKCTG
	 vs+DO94fQyC0bHYhzI74cvGHRuAUboh848mZILeng7p7E5pF5wQVCv1Z49zD/h5oOg
	 J+Y26LRABxpZ1p2u3y6UZr8M7tTfdcI7m5Eg73Qdnng5rztLF8mVUkyQ8fAMJ521pB
	 5zDLfrWVZh07oeDKkpPartHQ0YpslmmVJLkPDuvI5LSVrGMyj5qV11n6+qfVES+Qwm
	 JHRoz3Ynt23w2MDcHs0nnxkav8X1kflwSENVIgqImFH7i/ZjL7xDpTCqrfWb9QGI2W
	 izPvk9IYNV7LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFD276064C;
	Mon, 21 Sep 2026 13:39:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EFEA522
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5591340143
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFMkoFi-yauM for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:39:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org ABD5440129
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789997956;
 b=fSE6P0iuGonpF1qSfof/SSerrvgii2tCBPkEPOpoDxO6F6UWEfaSGanJh2qio/IEJ00s
 Jv7bC6l3EvthkGVGmkPy3M4/5v0TeOBiYRL4euure+I4ZfcBBtWDlb55gk5/PNpp+jsyn
 1EvMg7fdHxUCCwhqqfgJ4Cs8JOmqRAeXQ6nIGfhip2q/91VwINYjLkHvzabq17QkYNiHg
 iSc5xWLfdhX0xByGxWWh5EztktoFyjYGlcQq6F1Paart/PYtGERymAMt4EEVDHtSvm7rV
 Rdf0kw40B2I5QSjPYxbDks3pf085d+g+llgX4OmA7r59K9skp27dizbfS2INxsWMu0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789997956;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=S21ttEJyjbGFv5A9SoZAMEqNdqWcoaZuIfJbUPtP8ds=;
 b=k6SRS/vgRvekwqoqDc4nxYXsm1isyPkgwsw2EZvZloRG12RSywnxpQf/ao4rqI7l8Njh
 SDoVNJMxG5wY6RtLjLBFQ9kRiPee56BGN+TIKecNXPYCnHGErTXO0unpNSNVhxAy4aiAY
 WAXPPsa+cwf6OzwJeNuf5efS1fAqOOBa0p9PgQXokK+bOENhYoL5yY6OfQk2+fAN0MuzW
 0T6HhZ8B91RlMZRkieWQcyfQUwXCJa7XroAdu4CZbJVxRIxfgV5zJF3K6H6hwK+9BeNnz
 zER2DtBbp7feLDCnbxMDbskBCjbiRrRr7BcGU4KpdYJaQ22Y4YCBIufNoWbq5OpG0KA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=dolcini.it; 
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=nwfg7nrv; 
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
X-Greylist: delayed 505 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 21 Sep 2026 13:39:14 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=nwfg7nrv
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABD5440129
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:39:14 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4A5AA1FB8A;
 Mon, 21 Sep 2026 15:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1789997444;
 bh=S21ttEJyjbGFv5A9SoZAMEqNdqWcoaZuIfJbUPtP8ds=; h=From:To:Subject;
 b=nwfg7nrvGFohzVgl36O1UB9I53lrbcF6/ZLiH17KcvaboH+RHhehVugxmi3I+wDPr
 q0mI4u8GOd/O3a7FwH857IgtvkcCgYC0sHZG6UCSfckuWCQ06+vx8CJbtm0GphTkbC
 NimbhLVh9YjqhXPe4gieGiFhrel+5c/hEI99/gxPK02bI6wECnbrNL+Pod3gbCD6vN
 NmTFVSnljTxPsE22mXd+1RWrD1lwr8VjehAlyh7T95J6ZVutIGwpZilPZ9N2agAMfe
 M2AMbvYq4OUFnJhNYuX+OE1vxS9WIeKBsPpuCC++lOw70cI/br/6t209JSbKkswhpk
 kFmAHapve1oXQ==
Date: Mon, 21 Sep 2026 15:30:40 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Hsieh <hungen3108@gmail.com>
Cc: sbabic@nabladev.com, festevam@gmail.com, festevam@nabladev.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, trini@konsulko.com,
 tharvey@gateworks.com, stefan.eichenberger@toradex.com,
 u-boot@lists.u-boot-project.org, Tom Hsieh <Tom.Hsieh@advantech.com>
Subject: Re: [PATCH] phy: phy-imx8mq-usb: add USB PHY tuning support
Message-ID: <20260921133040.GA265796@francesco-nb>
References: <20260921054505.2978948-1-hungen3108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921054505.2978948-1-hungen3108@gmail.com>
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

Hello,

On Mon, Sep 21, 2026 at 01:45:05PM +0800, Tom Hsieh wrote:
> From: Tom Hsieh <Tom.Hsieh@advantech.com>
> 
> The driver defines PHY_CTRL3_TXVREF_TUNE_MASK,
> PHY_CTRL3_TXRISE_TUNE_MASK, PHY_CTRL3_TXPREEMP_TUNE_MASK,
> PHY_CTRL3_COMPDISTUNE_MASK, PHY_CTRL3_TX_VBOOST_LEVEL_MASK,
> PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK and

[...]

> Assisted-by: Claude:claude-opus-5

What is the policy on this in U-Boot? If we re-use the Linux kernel one
it should be just LLM.

Francesco


