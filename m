Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C907C982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 14:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A76B5605DB;
	Mon, 21 Sep 2026 14:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAbkzr_yR-xV; Mon, 21 Sep 2026 14:26:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E85B460604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790000813;
	b=ZvgSkifPapd08AHcu86//TgTrrm/iYl69xwl4zidgl9I9fQrzymbnUrdTBf6KbvS5j8C
	 3n4K9F1M01gGE52fTs9JRce6G7eoKJd3i5OAJxI6w27Ma+4Ln6p7YyKRwgxYTM85/HSIt
	 lpCm40C3bVsI1HlOuPQgmcqItuQ1heG9x6Anmnni0DM5PxdgvkYZSiddixI8q6xUmUf7K
	 41PGgArvgSR7+3LR5xcpQHC6kvguIldKpt07htYOnvm3WF56kkNDwzzGSyVeg3CZY+y1p
	 g0WUpjrYRRDdXHTWg4P5XJWz6CbY4QwWV5tA4YVIuuiuKkTZo89IZGv9hdiw9uCh1XQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790000813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jHs9vs/d95y5mje/KLmH80L8PAxE7KPXAKAiJAm/Uck=;
	b=QHlvyQH7Fs+d+ZcxMij5gjr6ZjnmHIcD2kDy4ONgulL8hpjPAzB19xkdjLwrxO7DohUe
	 vtaBGdWdv5LneFfxdfXsQBK3BO2najVTCqsYAVEW23A/6GoCAWrc6hrZEiKrXv4Q/coqM
	 w+sLHLHF3HTfpRR5hMaVJ0rc+BiBAnFOOaK1y2XM3B5WNMevxIF69wt7dq7pm90tqq8vy
	 4ucLsXFK3YKAHB5bx4fn0CBBFzloMWbHbmXzfmqVnaoO+dC0WfV4Z0Vo7J/lIsVRi8jjQ
	 OtbMQ91DMY0jnf9c7DsOcDiLz1aTJoRFkkt+nPmsHl++PegohEgkUxHU8OzzdQ5pasQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790000813;
	bh=jHs9vs/d95y5mje/KLmH80L8PAxE7KPXAKAiJAm/Uck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z9J0FhhXCMsz4DyhTgkRgIdgOYJ7XB9zPUW8VZd/vGcmprgIKF+fWvGD9cC27xR7i
	 ygfjcbZcFRIjghlloQdgZYQrF7NhhCbaaQE73wNW4UuWVxBcKwBwkA0xl6gjVGX4XA
	 25s8tYvZUXNLqwud6bjK+rA6sXy2i8ujfIYZBoMiUTYmqeZqzIb+x88ivAAgWnwZ3G
	 4w7D7mSyWI4aWAEYJLpj2DZP+lxOjkCfKDKfvTVuQCko84i1vRbvAqubGZpDCL+YFV
	 OR8vDmjR4haH+4s5p5j1skGN6A6vx86ttD3AyzcmlyxdQE1CDFGATkAq/527Pk7LrJ
	 P0J2d4tCMuOLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E85B460604;
	Mon, 21 Sep 2026 14:26:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C81F32EB
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5CB940187
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g1UXghT4Y6Hw for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 14:26:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B71FC40129
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790000810;
 b=VK5cMzMnej48UfQx7WbEYiqLDD2wK/WXiHslzSfi+Eode6q1NRXHbpiBBaXAombJIuby
 39YJGmlAVJzp0UELIgzYdP+sjvrqXpNZnRI7CXdptZtMW2MUtlT1jqU2ErUFudmSGCPbu
 M+3alSPePIQi58WDLeO7m/ac432HMjb2Zew122QgMaIu5Nih8AK1t4lUL0qlfWGuNxs+m
 IytraoBFdE9alNXbtpIX+jzgzjGcVmSkO+m/0PqyXGmoWyBctpizRRfAf2Ra/YOizH00H
 PCJqxOD/N/jPMPSq/Nkt1Iv8ob1A/5LxznptaZZvc2PnogkhpZ7zO5mUpHQPkaZqA8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790000810;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=jHs9vs/d95y5mje/KLmH80L8PAxE7KPXAKAiJAm/Uck=;
 b=b8AI9zuRZS8vsf+j7iqDJ2+nw0/S2ae1VyKjJYhFzLJPwauE2U/62TQyFv15SoGMjRIW
 WORZJMVnAyhBVP8SSrGx7zoteorci3mbD3sfMGqhu8Sf3CYXWuHz5hVte5Aq5V22DGBJk
 1LWTeglfpyXAuG6m187wDBklarylCMzK6e7iysp9nb+FcOpHJQ72zRz30dIEDJEs5YXjb
 66CkmzJbagQ9OAemO16OnhXET3vkAMwVkKviqJhfCMxobP/Z0ME/aTy9s1EmTDcZuMVSA
 fuahlEWTx5t5CELb/IZ3LnT6lXvQYPPutsFUpNoRecsaztClIz8Lwxk8D5EGcYkeRxw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=dolcini.it; 
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b="ct6O/RX1"; 
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=ct6O/RX1
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B71FC40129
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:26:48 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 2858122B9C;
 Mon, 21 Sep 2026 16:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1790000806;
 bh=jHs9vs/d95y5mje/KLmH80L8PAxE7KPXAKAiJAm/Uck=; h=From:To:Subject;
 b=ct6O/RX15fHFTUAtUi4gGWHhHW2rn6h6o/oKPV/d9zI/CFY0QrbVD+b8N6gbKzlfE
 kXJuNJeP1OrZOiP5gboJAuACCRTfBmcdOuwxeLnSXdVv5Hn+6mGCr4tXRJ1+o+HJN4
 BDSZaIAcK7VrhRCNMeN++skLZidSdprik47F0RgbJl2J2eY2j9+kjpN23aYTgneqWk
 mB4gYbsWieg3jeLuwscE+JbuCr6ACHqyiNaW4GPlpeYifXX4w2UQ8Wa3dKeSkVHjbD
 X19xp/1bL6j2YmCs7Ql44qIBOXaG5HOK+aeEf3dbUX7m0sBNlPzxS9lFks6SbYmKnN
 tkzBxnVbNNxSg==
Date: Mon, 21 Sep 2026 16:26:44 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Tom Hsieh <hungen3108@gmail.com>, sbabic@nabladev.com,
 festevam@gmail.com, festevam@nabladev.com, uboot-imx@nxp.com,
 marek.vasut+usb@mailbox.org, trini@konsulko.com,
 tharvey@gateworks.com, stefan.eichenberger@toradex.com,
 u-boot@lists.u-boot-project.org, Tom Hsieh <Tom.Hsieh@advantech.com>
Subject: Re: [PATCH] phy: phy-imx8mq-usb: add USB PHY tuning support
Message-ID: <20260921142644.GB276016@francesco-nb>
References: <20260921054505.2978948-1-hungen3108@gmail.com>
 <20260921133040.GA265796@francesco-nb>
 <bcb231e1-3ec2-49a9-b1fb-b9a499d13fcb@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb231e1-3ec2-49a9-b1fb-b9a499d13fcb@mailbox.org>
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

On Mon, Sep 21, 2026 at 03:54:54PM +0200, Marek Vasut wrote:
> On 9/21/26 3:30 PM, Francesco Dolcini wrote:
> > Hello,
> > 
> > On Mon, Sep 21, 2026 at 01:45:05PM +0800, Tom Hsieh wrote:
> > > From: Tom Hsieh <Tom.Hsieh@advantech.com>
> > > 
> > > The driver defines PHY_CTRL3_TXVREF_TUNE_MASK,
> > > PHY_CTRL3_TXRISE_TUNE_MASK, PHY_CTRL3_TXPREEMP_TUNE_MASK,
> > > PHY_CTRL3_COMPDISTUNE_MASK, PHY_CTRL3_TX_VBOOST_LEVEL_MASK,
> > > PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK and
> > 
> > [...]
> > 
> > > Assisted-by: Claude:claude-opus-5
> > 
> > What is the policy on this in U-Boot? If we re-use the Linux kernel one
> > it should be just LLM.
> The author of the patch has to understand the code, and more importantly, be
> legally responsible for the code they added. Therefore the author cannot be
> purely the AI.
> 
> For example if the AI generated the code based on some problematic or
> closed-source content (do we surely know it did not?), the author has to be
> legally responsible for any damages.

Yes, clear and I agree, to me this was granted.

My comment was more if it was supposed to be just

  Assisted-by: LLM

as the Linux kernel requires.

Francesco

