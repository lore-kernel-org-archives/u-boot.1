Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853EF606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bPTP53YT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7K1i5sF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5474480AEA;
	Mon, 26 Oct 2026 01:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSS32mHAvRQc; Mon, 26 Oct 2026 01:21:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C75480D32
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792977664;
	b=mvUgkjmBSR73yHu7T2AEIxgIre/Rcf3tkl4ZA0GevCR+8SdANhRqCrJCtuFce0S7xLfq
	 p+4dn8+V+9s7vmw6Js45kxdc3+OIhtBVE6ZmzavGFW6zE0YqbiMsJk6SaqQZ4YW4/p9Fw
	 8Z6UiMX4llO0cOsJ9v6Vx6jJztNrBiy+4NxshEqECdaBNUS/0iwEA2X2Fh7a9ge5pyUvf
	 lUYWOWY2hZfXLVshaHRHbO34gVUzdlw0I9tcBhObbNFQIZ84+uj1oGPRh3b6Kz+e8XBRd
	 9I2mAN5LcTDZ8mE1/n2HJmR3M/AQyYK5ioHFO+AC/u4Uan1wqHgL2/4IwiyqQiusGAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792977664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6uunJP27AS7Uj7Gyx/M9sp8gecVcS0Z3Jlh5IaPg3ic=;
	b=bzkFnzi4w9EfJiDfenFB/LKuiKNZ5zaEy9aQk2IWuxAQYRu9D5eNlkksOm+BVh7RvET9
	 Q4z9SFH1lBn52E2Clk5zlyd19E/sdY5UEWxdHPOAdUwuCdQsSybMyYz2mj0xHk8bRkO2b
	 j7TgYG2erpHupINd9cJITVEnWb4bwyZ4Lz9D0lb8I1DRCMYJn8lhQScxXQry7HdZVupdw
	 K/us4MyuXeH/REWx0aDr3+H3U18uxNOltQ3QQ8P882/tlF7HcUFRaqV4sAMKDNKz14D6h
	 iDmhhuR8WZyTSj2jrw35A//qY0lwt/kRb5veEIDk3YXASowCa8AhM1XtA57Q0fzeYPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7K1i5sF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792977664;
	bh=6uunJP27AS7Uj7Gyx/M9sp8gecVcS0Z3Jlh5IaPg3ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bPTP53YT5BZKMjaMQdIbBXxnliMt/61o3BmpCGMUAHQfhZ4yvzJQsjK0uWzVxeWkL
	 /18Tzzks0sU9tu0dVd0F05aAyOiLA4Og8dx1QMBym1ctaJaHl/ps7cD/K6SvsHqPvy
	 TJfB6j0D/YSywmRew/d33frj60RY04ZpdXasCZ/thOrObGNhtlLI1hXocbRf64qf3j
	 ctEwBg3HdnkrSjK1c8mUU1NBKc8d68IjaS+NEZcSiAkzCY+DN3+SATDN7ai04fnyVs
	 UXVOd8yP6rCP1QrwDjkiIKK0AZY4E1dH9K8hBBs88KlSVxD76rK8kdfxaOmVeQgHcV
	 By0u0XZvKcDEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C75480D32;
	Mon, 26 Oct 2026 01:21:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45D77380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 01:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37A7B80D32
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 01:21:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B19thdc8Sfcd for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 01:21:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E1FE80AEA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792977661;
 b=SXraSlV+ZFWzg3LbKyM+scNRWlSiCWX3XQH26xRcg8MKeVvYA5tRExyInNbNCP5BoPvN
 U3NgC+7yuNfoZAyKR+ib9tthUpVvBn+bUYMrYbZSK3WMKeuX5FPQPSSLSxGt2r70bw6Rs
 xDSDpNVG+XfK2CGVAyoZWNQ97SiAnXNUkwVfVZ/8Enzb2eNFeX9O03NT6tZ/fIqu69SVu
 Mg5+NGCQ9un2T5KFJA+9xSwdIFt8XXIGZgHEZAlK1wEusoc0azq+vOeBr/QzYKcWJ/B1k
 qz5GiVtSHa2xbLsP7y8PtAVmkRgXc2cYqUl7Fpp37m6rBjJ7VY2yaTzaxOCHfo5h3tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792977661;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=6uunJP27AS7Uj7Gyx/M9sp8gecVcS0Z3Jlh5IaPg3ic=;
 b=iKAndfIy2Folf2mac57U4DVtRa4OwhSTvZ2LuqEW31olMQZuI3bvMbr1PlJ0sFGrt3gM
 ZkuhDZMNSx4rgZXrgnn4aLqR4WY47ZUlLpBmOLOoXOHfjinK1TYMVGSsdPedgwUGSX0BO
 Dj7WdtFotEjiJJAPYIlvm3hY9J5dNN3mSvUeRX9xMnVcKMQZcEGSN/Gxu27IBjaLFCN4o
 U3vc2VML9Lh7AByRhzbkToABZdIaM1PuNsTaE/+FQoh67rN3AvEXRG7CYZflo6yHVEkEA
 meRw301Du43dATu7fyCzgA0B1xDysIaleFOjTCP4Yr0Ix/Z2MQ0Je6zAFdUEzXOCjjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=b7K1i5sF; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=b7K1i5sF
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E1FE80AEA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 01:20:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DAB15600CB;
 Mon, 26 Oct 2026 01:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF1C1F01825;
 Mon, 26 Oct 2026 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792977657;
 bh=6uunJP27AS7Uj7Gyx/M9sp8gecVcS0Z3Jlh5IaPg3ic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=b7K1i5sFYeZJcx7z/NHUAi0/UrOJ2JoO8F9vJLUtuXKA6K8JiSJDSgBu1GNn5/NCN
 y4/ycqUnEb5tRcd6Eb2mvHDMRMSRlPz5SrWIQ3FoYEpzXJu+cNiw0IFp3/+LL1li+0
 lnVsQ9KDZbd2h4pcoPTKhNSempRU74eAZlIwiSaYngvAE1hYmlzD3u+jkU7EmHGmoO
 vbvZKqab9c4SpfTqyxa07EuXX3uBLuFmS33ezfvVNA4bwvtawfwJ3uKshpNQneTQRZ
 QQU59lpJ+SgHIzCqlEWcOby4/YN48RjmJr+fGdW3g1dyEInrb50NRN0HzTWMloe1Ki
 BAQEg3FGg9gpQ==
Date: Mon, 26 Oct 2026 01:20:54 +0000
From: Yixun Lan <dlan@kernel.org>
To: Leo Liang <leo.liang@sifive.com>
Cc: Bruno Banelli <bbanelli@gmail.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <docular.xu@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board: spacemit: k1: accept the "m1-x_" TLV product name
 prefix
Message-ID: <20261026012054-GKB184714@kernel.org>
References: <20260825065257.69536-1-bbanelli@gmail.com>
 <at6fcP366xFg3oeU@lliang-1876.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <at6fcP366xFg3oeU@lliang-1876.localdomain>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Leo, Bruno

On 08:31 Mon 26 Oct     , Leo Liang wrote:
> Hi Bruno,
> 
> So sorry for the late reply!
> Could you rebase your patch against current master and send again.
> I will merge the patch once you send out the patch.
> 
Sorry, I've also missed this patch.

But since currently there is a dedicated custodian tree[1] for
SpacemiT SoC, let's merge it via there..

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit

> Best regards,
> Leo
> 
> On Tue, Aug 25, 2026 at 08:52:57AM +0200, Bruno Banelli wrote:
> > board_fit_config_name_match() derives the device tree name from the TLV
> > product name held in the board EEPROM, and only recognises boards whose
> > product name starts with "k1-x_".
> > 
> > Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> > instead.  On those, fdt_name is left empty and the function silently
> > falls back to "k1-musepi-pro", so an M1 board selects the wrong device
> > tree with no error or warning.
> > 
> > A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:
> > 
> >   00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
> >   10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.
> > 
> > i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".
> > 
> > The device trees are named for the K1 in both cases, so accept either
> > prefix and keep deriving a "k1-" name.
> > 
> > Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
> > Reviewed-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  board/spacemit/k1/spl.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > 
> > base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc

-- 
Yixun Lan (dlan)
