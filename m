Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC86606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=irvjZTlT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K06v3736
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DA3C80CEE;
	Tue, 17 Nov 2026 08:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2v_y4ZY9IVS4; Tue, 17 Nov 2026 08:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF09E80FB5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794902441;
	b=MJA7sqoHNA7XyHb84WneFljKDQFsjzR/RRI1wTxrXPzGoRZQDv4gDMmhczZfXlO7/iXp
	 lbJRHd+SSkGR8cnN7vNGcn9HfNbMC2esidPzy+hMjnvGSL9ms9q8tKu2PAZc46aSZ1c8R
	 l4HgmgfQ9fK/LKZpKe51kALDsbxHnZbRPz2t/Vi/UbmYNW/2sc2aqVq/e2D/Hk6eUIZAH
	 F9VohQEiU8vUQsSppvEMjHzlI0NB9JMosBJJUrOZIDLqeRT72wwab5R05KHsraLFdoinb
	 uQp8wF/gneS4HJOr9gcfxbiyR/BEl5ITB23cbt21nUFTFuFICeA+52oK34nzk3CPuTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794902441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZifUI8Fxid8lmtuQHyCR/XcAXnR6bcynYlVtwKss7Wc=;
	b=cSmnXntI7FwY3VGBQQd2XiPQvixxhRL1M37Adx3Rd7uG3lkSVNZWcw27VsJOdOlsjFdF
	 hCdaZwpyblG2lHBWyOuY1E3pUcWqo6L1cAwZiLo0PhKjTy0iucR5wihdrlLEwRUghRfGS
	 CD5kYwHM/B7AnXuatv4SNDejomvjGIcwvpedHeJgLxuwyeyv3pqeuJe/nU2wpTY+8iovv
	 zm38y3UV8xMU4U/JuY62iIxd7Cual4EFrZqFpUffTJrl41lziURKNwyjLl9ijZb5TGOSG
	 ApEeqVweav54i/7fhUKvCHTLs9KU/KHcjgYscN4gMj023l/WXZbjoNaxb0isAxQZ1Gw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794902441;
	bh=ZifUI8Fxid8lmtuQHyCR/XcAXnR6bcynYlVtwKss7Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irvjZTlT924lmQKydg6Ioie+0vE5XZW8dSfqriP6/ogkA6NmJ4Kgn8dckR68tFA0D
	 wa+7mZJKGKSKs2izU/vLVP5J1byjP/7bp1l0i3MJnQc+0dbuYpL+AwluwTek1G9X4F
	 xXnRvmEvX0XwlcoTKi8z5mstDdDqdbFpmCkQTiHGuQQ23iXFGEDkZo3kGZw1oedvkw
	 x+XwdG4v8KoE4psYCu/mgZFFp7i2JkaE5XctiPStVkUub4SxvsxaE0WFk8wCzfmBOR
	 tkQ3jMgAhB3v1/zUXs6gyjW+KOgUzYXb1ThmP0DbW9RyHRaLUr6w17Z2mTp1Zkh0Ha
	 92krBs7KopZ6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF09E80FB5;
	Tue, 17 Nov 2026 08:00:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60B5D28C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EA376083E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5dbuSO9LQwr9 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 08:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D77360841
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K06v3736
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D77360841
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:00:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D065612AF;
 Tue, 17 Nov 2026 08:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3071F000C4;
 Tue, 17 Nov 2026 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794902419;
 bh=ZifUI8Fxid8lmtuQHyCR/XcAXnR6bcynYlVtwKss7Wc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K06v3736inKbi1r7EtCGliKRUOzxmrvFuptskKHYcdX+GErKcoE94Xvn/uCU8O5Xe
 kE0E4etWhdlAqM6DSgY5QO6/9ANerCyKY1M/3zvT0KYjWpU2ZXcuYAryViHdr2I8MB
 Uyij5SmfunHXX7SLzdrfjEJwdTvy5DEAaif6Bu5fDy8L7s1WCROu1NO7LELtqqt6LZ
 7hfP78rc/zopodM4HU5hqexpJaXSmXzG9SEO25RiJJILEz5aZRZXSL+D5HJbG9hpTF
 yT154mWKCrJ//fsOqUDT1ohHC92YZYdv3IlTjoED9FUtRlV2wjZNkmsE1Qx4Tn7HBv
 1N5CyA5ua/rzw==
Date: Tue, 17 Nov 2026 08:00:16 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Bruno Banelli <bbanelli@gmail.com>, Tom Rini <trini@konsulko.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v3] board: spacemit: k1: Add the M1 Jupiter's product name
Message-ID: <20261117080016-GKI100523@kernel.org>
References: <20261117-04-k1-milkv-m1-prefix-v3-1-18e3bcdda11f@kernel.org>
 <20261117025737.3153817-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117025737.3153817-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

CC to the list

On 10:57 Tue 17 Nov     , Hung-Chun Tseng wrote:
> Hi Yixun,
> 
> On Tue, 17 Nov 2026 02:53:39 +0000, Yixun Lan wrote:
> > With K1 board map, it will derive the device tree name from the TLV
> > product name held in the board EEPROM, and problem here is that it
> > only recognises boards whose product name starts with "k1-x_".
> 
> Nit: k1_board_map matches the full names it lists, so it is the
> "m1-x_milkv-jupiter" name that is missing rather than the prefix.
> 
I generally find it matching current situation which recognise boards
with "k1-x" prefix only, although we update algorithm now for full
product name, it's ok and I will leave as it is for this version

> > Add an entry to map the M1 Milv-V jupiter board to correct device tree.
> 
> s/Milv-V jupiter/Milk-V Jupiter/
> 
> Either can be fixed when applying.
> 
I'd rather not sending another new version, will fix when applying

> Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> 
Thanks for review

-- 
Yixun Lan (dlan)
