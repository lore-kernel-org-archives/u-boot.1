Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E52CC6B19
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 00:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 079A2406AE;
	Wed, 14 Oct 2026 00:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Oh5fhE-9Bcg; Wed, 14 Oct 2026 00:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 699EE406DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791938213;
	b=NfOBr1tk73/Lo8i0FqZLOOFm/IdcTy5ACeFRUDEenvFLXNRm+qfbCF16fq0JHe4DmVTS
	 9V+K+3xS287aCPL8VjexP4nPZIqsVWmg4dX9ld8dvgXfUAC7fN2mI4m7KgAPoGSnbIcWI
	 DAegqGvG4OVOcaQHXlq7SJ9X1sgJEWyY9aEI9ynaohs2uP70AaHmajJZ9VVVFnYaGwzRS
	 WIH6vD8Z+B6IHLRJHLvtNlMWhRNGOIUkcrgSa5c5EP1vZK5JdhFxZhC5iqql8OTnaAwS6
	 Oq5G61hH4XxOLP7fcBGDH3c3YSFeAt8DxKuOUNdmq0/QD7SETjKUwrhah6BUj1+02Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791938213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xuivOQ1pl+S93CR2sM9Dh5gHIIHz+j51lH5cP9nyS8Y=;
	b=OGAOuSaUxuQm8VLhFPMw2ix+lfElS6M6LIQtqPYBUNzPQLgoBd4pwBJ6iEKr8XEkzTEP
	 VZje5fxViIDRUdxgMF19MEo7v+s7Usrv81J7XZbI06GGNuyE4P5ox/39GpJZ3hIl9oU+t
	 bvJaa1/RlW7SBHrUOOMuENrSMeaJgUQiJOU8FfrUmBxqg/ToUjIZxgYCqXo/fQzd0e7yR
	 z37R+kv6t0u4rm30Hlnl/Jljlx+BablL2nTLfJfnR8G3bY5OM5SR8TWEt8UVP8GiB1uUt
	 jMlVM2RK9wYBipmd2exGIAS2ijtIVHZzJmcTx9gwu7JEpx+5q6V2noiyeYRn8bx9Bxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BKA1Byvm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791938213;
	bh=xuivOQ1pl+S93CR2sM9Dh5gHIIHz+j51lH5cP9nyS8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zMbgNIqkJ3r0HNvc8KW3QfBXF+u6DvXGIG4C4Nh0QQg67nrw1r+MACvMIAnEC0WFp
	 94/2HpGLD2F1cYqX1Bac5bvtEAXKRbLEhaPdv5omB8LZsoQ4+Q9wnp/KKtfvo5yExM
	 cp3n1/JxPBVkwprm5LEWUj4lb3rx5N7BJ4+iuSVVGPIKSwupOl/hjqQkgMXYNlExK/
	 A2cD74uIwX+GxtOhhZyX7iH7MlubRZXo0ZGvVj8H15NsbPJ18otO2LWkPMy6v6pXnt
	 AxyaBgqLth1LZwz9KqToU4U9JwkypXB3DOkJ2Z+5okbYz9dlQGnfISaeHBiP6psgQz
	 1SSZmEP/F51mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 699EE406DA;
	Wed, 14 Oct 2026 00:36:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA6942AE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 00:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC3E4406DA
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 00:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26GiBoyiO4v1 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 00:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4284406AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791938211;
 b=aSk4CoYX71znZRsE++Pou+oT8qFkKpio9hX1t843O39r2+BIm/PcVk8t1urxWa8Pg6Vp
 OmeQBjcp7W2I7brFQ/SDtjm98WGN3Hp1+wbSI+Rlaf1zvE5A+kPEdKaAscLXy+Yw/G0tW
 c+woRGkbl3iFqVMLg5iWDhmYw+Ro8e4L6gQ539xtUtRgFwvTxDF7BabVDNbl1ktANYUe5
 dGRrR6KCQdj/2w4jB688aBVrhOndqfIo2D1i9/QDkSQ7d6Abzj6676J69tHwifp44F9XS
 lfUm+CykXgRaZN+XPlzgyqK5Sb9WWsJRRdcuIDFQoX6l1/lMlKIOb6wbGaikb4lUP4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791938211;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=xuivOQ1pl+S93CR2sM9Dh5gHIIHz+j51lH5cP9nyS8Y=;
 b=OQMJXSJlD9fCwvmYBwq+vlNJo0wJ2MIGakjPfUJDwM0aIT2CM/HNyiBSnua6t3NSm+Fm
 oTmx0f7IgKBtvFdYTbhrrgiPUIitX6RAFncMG5GoDc2vyuYSj7vYsttsdSEM6/mGWELMw
 pFJvriMrrIaSVuwNz4uL9toO3bJMHPqqm32Fieuzur/BxKv3kVKt7QLWF/u9Z+26X+jvU
 G0PdL/vUL4q/gwgqyOgWbGBHS59uMGMLXl/xY7cepaZwRJA8JAItS2PqYWinI7r9QeVZ3
 nV+BN3p+ih8TyXPcorh1G/t3gI5p5IPHZFlmPSrJDyujAx1GFON+Ni3mvbJVBcrsPSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BKA1Byvm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a31; helo=mail-vk1-xa31.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BKA1Byvm
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4284406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 00:36:47 +0000 (UTC)
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-5e67a6b3633so1221040e0c.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791938207; x=1792543007;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xuivOQ1pl+S93CR2sM9Dh5gHIIHz+j51lH5cP9nyS8Y=;
 b=BKA1ByvmSmYpziM2uFut3BOao5zbAUoTlLM4ue4QulTezPff/W5Ak6lXA11uEkFvyi
 bIOt7yn4hFkVAaqV4jSaq9aqup9siisxifJ/6B4SaOWzAJ4pByM/upG7PvjXaTC+M9Z1
 HCDD5aLKOSoGFsqgX0SlfltOv/1shq/yFEsgVRKiE/R4yRWZwoLj6Xtxbn3jtD8JWr6q
 g7DZStnwSTnSuGXtMzJkAkPVU4kPLuvRxS9U2eqIt3dG+2eUGteYPX8cNxM5YqNYxpm7
 YWzMOQ2/6Krm01SSZ6x6536KBkfKGaAkBuhDu+qHAmIzfACAflxcl67ad8SVD1ZmcGMo
 KXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791938207; x=1792543007;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xuivOQ1pl+S93CR2sM9Dh5gHIIHz+j51lH5cP9nyS8Y=;
 b=09dxmrdg64Z9NRbzOFlw3QNK0zhiGO0kq3hnPaPggo8G7cLwNNRBGi6qqMAGI2mgPc
 phJ2cJMwQal2dq0a1Ehpx/IXylGJTgUpMkZbt+eefKiJXVwOj4/o9cYvUBGbAMs6jGU4
 UPkLNZ0s0phEUewqlUtz1QufisFlr3j3uptOZeF/ua0luIYTLuZzMkqEA2OG6Ka9HuS2
 1tFWNGrJQ9Aodwg4Wi0VgxX4DYkUQU1Q/A+BVw5IRtSCrCzK6ylFeS7Sw0l1zOYroFhD
 PIijqIFThysvsjx07JfrOntuBRQkBfTRJAiXO90W+b2DJRPcA6bg3uDIR7MS1VdJSeN8
 +5PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOgVqBy2nTKQTkgrrjIZncRIR9DSySOKkXk0j4WmBPrjszrUHSuKOUalGh7YYwzt1MOfCON2Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJtAj2lzCqXECmw53NpkzymmGuHkFob1B/ldaRtR2NrJ/EC+e30
 Isi78mbFQdqTm/Q6/QM97wrkrgFraz8EUqEIzyWwikfYPPAGJnd4IVM33QSTC5saG30=
X-Gm-Gg: AYBFou3wffSeCXdswdpojllmfLWaGjrGmFdStE5gxnCd+ndns/G0Ylj4Aa/zEBqbNBK
 oy5Gisbhn/FsEDzQmMjcFSaUEAksa4ppahaCC7UYpIyBKBYJPMbnYpGyfQbZ1bWQzvaBFlNdOVQ
 zQnxN6JjE++m+pw82s/EzSX0VY2Qs/ebRLn0qoqVPwVeSkAk95TXgTz5IoJLVJeXK8l9cFJ5jcW
 hFWdhjebSWmemE3FDjHbGM+JbjFLgh/2CdLajK9q1v/romSAq8ElrdFKNuzkGbgMmde0b0TzC2W
 X8kupo9xinzqwah7Q491ypBV+QjXsDpi230FPZN0S3TGU79aDSPDqMkSQL83tn5wgovwg6IfJ3X
 8YqyzDorGxZUqmFAeBHLtMR7AXRQgIk76vJWyFKQBma88K9CEAl/RwIGD7rylGpr7QXHTQ7qQ4Q
 zKAb+Yz0HUTGAbu70LvC93hsI8pQ+VVWxUtjHCUbf2wIZt1gOWMrV2puZ1UK90SCAXTjwkIMz46
 LD9bgJCeGXJrcDE2ygAJ7S9PJrHeJdK
X-Received: by 2002:a05:6122:3282:b0:5d2:4a4c:ad83 with SMTP id
 71dfb90a1353d-5e91f57b796mr4931675e0c.23.1791938206735; 
 Tue, 13 Oct 2026 17:36:46 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e91cbf7fccsm9778540e0c.15.2026.10.13.17.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 17:36:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 21:36:40 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH 0/2] riscv: cv1800b: Milk-V Duo boot fixes
Message-ID: <as7OZxMHezYeqnmK@hiagonb>
References: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
 <asa-S7LCji4uX4af@pie> <asj6OaDxcTTEUvm6@hiagonb>
 <DM1TUTXQ9GD2.6SMWWXF2TI4A@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM1TUTXQ9GD2.6SMWWXF2TI4A@zohomail.com>
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

On Sun, Oct 11, 2026 at 03:23:43PM +0800, Zhuxu Ran wrote:
> Hi Hiago,
> 
> Thanks for testing this and for identifying the dependency. I also
> reproduced the reserved-memory error on Milk-V Duo 64M with my v5 series.
> 
> I would prefer to wait for the next dts/upstream sync that includes
> Andrei's two changes before the migration series is merged. Once the
> sync lands, I will rebase the series as needed and retest the boards.

Perfect, thanks Zhuxu Ran!

> 
> -- 
> Best regards,
> Zhuxu Ran
> 

Best regards,
-- 
Hiago
