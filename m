Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD738C624D6
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 11:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78D6660615;
	Sat,  5 Sep 2026 11:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XeabOrtsTXFf; Sat,  5 Sep 2026 11:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 84CD460609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788607590;
	b=C+KlfFfdosvikXhwZQ0J2aM0Nyq+50WI7IfDhbL7y4QKPjqQ7RCdZVOYgufAIL2OOXvI
	 2lMJigttgbN0OAeDVOM/numpk+mQauhK4I7CYvaoIONS0mYegBHrwG8MREH0X9PFVroRv
	 BIu3cQxwu/5sZxYC+bvqxdyI2ENyY6M/zikdCWLHEOXMfe3jHbU49gwi4mBRY+L4c8+Zz
	 c0mvbT9dyEtnrACfY63u5k/39elpAI05OAMLG3wPhzJtL0XNEVqHSxXINvPuxBB6FDKIw
	 YgdFXDHHMaINZB6tZQTv4BttdmObGMpWYtbzLNrds89DQq4luU+oGoZf29Ek3zoKCmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788607590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2pftRWq1hXV/359Gqf2Khf1tnNioc31UF2s+eA4Flfw=;
	b=W9cYNDTd3o4+kjaugbbzq30aP0SmVMo6arBc/h7TcYc/mFEgXwxIx4i8nG50PAqXpuuM
	 ijcLC9TXyOKYzslEuDbIMURwQ+0//IOFsg7J2LlmkpiORVWcW/hkUhrJEnF5w5IwT2YDU
	 OgTR6LzE+/5NRvec0XuRZKIRtlF19v7gNAi6AZqfHiP8oyPqGzyWjNVe3p/ZGHXqtNeka
	 VPmKYU2hVfxGgo8oOss7QNQpnliJaZ9vTloIWNyI7/cb+v5kRkhPsLhnR+gfXbfiFBK5a
	 QqBqZxfU9NHQ+J705UAoftdmWePCQHl5ZfkwWdPKUhBd9SyU949SgnaEoEBmguKYR7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEZ+igff;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788607590;
	bh=2pftRWq1hXV/359Gqf2Khf1tnNioc31UF2s+eA4Flfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CKCSxmbvWyDhTpkBl6R5FBEyBmmPcCarBscqIMFdUNgXW5LYr6BzttCTOBXjivUUA
	 Kc8w4gerBApGbwJDBbORBFxTR621VT8mDg/ynP8TTS/HYAIaYSe/NwRVl4KvGcpHqP
	 Tcf/KVNxvjBP2U0YNKwm4ez8mSeROxRO/qhUp7Y99PC/Jsr5Z5TkkCN8mgBef8Nn42
	 iUny4fsv8xZuVEvLn9he1C3VYeR3fry/zP5pdpHGp0YaOem/VyWB7iAePObVlywW8Z
	 tP7zI1DuPbm4Msul5GXppQ9I5PB0nAFSc/apDg+M38gg3M2ZpnwTAHqLTL3sXY9Ui0
	 LV7SFtvWOec6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84CD460609;
	Sat,  5 Sep 2026 11:26:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CA07B88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 11:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A34C60609
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 11:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8nBdjQgFHjHm for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 11:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2A56605F8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788607587;
 b=ScKRAu9oxILGVBVX/w99TysbPefuCfitbdHRO3sD2q7aoQKPDsKh34opcvIVnIGxQ+ux
 Oob6BhdI9iuBmVXcKQIknzYt1TGFqK2lkO22PndaNSqcobA1mqPmm1SgTSJzVO5SpfVxX
 S6iORmPw4wPcgExzaJFJqvY+y6C1qohmfcACSmAaeTIXg19zm/Bye+RRfrciesoL9/gLg
 rv200/wvybEFIwix3yfz596kGefp7cX1zjQ543rkQsFYJa4dBN0G6TtW7WtgO4Gm9N36D
 2iPUGaxdYKO9bOQauBkDX+nl+VaupwO2Nkq59CiJBM1C4BHU+pZlcE4VhEeaAkkCiWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788607587;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=2pftRWq1hXV/359Gqf2Khf1tnNioc31UF2s+eA4Flfw=;
 b=s/kSk3UBlSt6Aikal5n94fgNIRK2a+/6/NARR3V+DFlMFzrpzgwNoof9YfzzXntf3DFe
 guzVg3OUfQFYgJcochmCTPxclUKwmYElhDz3DX2RC/jZ3Ga9+Mn/4RYIfjofqyIWjmVYG
 a1w/m2usurXBCCfTms4Uf6K7ax5yFnLOl5tZ/UcnrTxkihcsISRs8uOvypU/52ZxnMUdn
 YnOy9RPqe25oEMP3v/iX94cy83yrVYlZV8JnFZfK+0u2TgABkOv9upzeBqsHA9ZlkXhwd
 uoZLt1h9wpikYBMbD1mxIFPZwxs5nqrJ7XqJ1JjFPzk4fJFaxyOfi5DZ/0RbknB72nQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mEZ+igff; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mEZ+igff
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2A56605F8
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 11:26:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82096600E2;
 Sat,  5 Sep 2026 11:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59641F00A3D;
 Sat,  5 Sep 2026 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788607585;
 bh=2pftRWq1hXV/359Gqf2Khf1tnNioc31UF2s+eA4Flfw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mEZ+igffnH5JhnXsf8a0UpuWspm0Tgy9YQoWFx95AgdzspSyU1RfVsMRlo7FdIdat
 oIrp7JbAgFvdbRqq9E3BWdN3ShJiaQsDOS3BlhBc007nS6+GYxYtuu2aTQ7zzO3VrA
 Qh3pEAIy5r8Hnl5FrFUKU+QF3NGn+cNNzLhDL6l/nPwo5FKfzsZAJWk8jiPo0aNLAd
 jbcsNjxPvIKgdwhkR8wc4obs0nlPy0tJle7QwPgbw7KspFSKMiNYJQ25IxM1ohJ6L3
 L1CrDLjxJtrPhwU4Gu4d8Bz4qWLG+ycqDnb49w9RwcKlb+ymZ+HYaIYOgNVbRzONQZ
 yLeAYQ68QYDuw==
Date: Sat, 5 Sep 2026 11:26:21 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v11 03/17] riscv: dts: spacemit: define a SPI controller
 node
Message-ID: <20260905112621-GKB84986@kernel.org>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
 <20260905-m4-v11-3-235eacd94fe0@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905-m4-v11-3-235eacd94fe0@riscstar.com>
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

Hi Eric,

On 17:13 Sat 05 Sep     , Eric Chung wrote:
> From: Alex Elder <elder@riscstar.com>
> 
> Define a node for the fourth SoC SPI controller (number 3) on the
> SpacemiT K1 SoC.
> 
> Enable it on the Banana Pi BPI-F3 board, which exposes this feature
> via its GPIO block:
>   GPIO PIN 19:  MOSI
>   GPIO PIN 21:  MISO
>   GPIO PIN 23:  SCLK
>   GPIO PIN 24:  SS (inverted)
> 
> Define pincontrol configurations for the pins as used on that board.
> 
> (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
> 
> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Link: https://lore.kernel.org/r/20260502-spi-spacemit-k1-v10-3-f412e1ae8a34@riscstar.com
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> 
> [ upstream commit: c580774185426ea316396b1dc3f1737a3ad3800a ]
> 
> (cherry picked from commit 2eec5923556990fcd34c88c549dd11a5843d7fce)

As current state, the merge window (v2026.10) is closed, while next branch is open,
and Tom already synced lastest v7.2 upstream dts, see [1], so I think it would
make sense to drop patch 3 - 12, which will significantly simplify this series..

Subtree merge tag 'v7.2-dts' of dts repo [1] into dts/upstream
Link: https://github.com/u-boot/u-boot/commit/c671bcceafc08138b88d9c49018aca75fed20ba4 [1]

-- 
Yixun Lan (dlan)
