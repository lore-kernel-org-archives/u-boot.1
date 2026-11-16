Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C8606A336
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qguhF9ih;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAF4sFXM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C172C606F7;
	Mon, 16 Nov 2026 10:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id enlbBDsZMBwN; Mon, 16 Nov 2026 10:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07E34605EC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826329;
	b=D6ahWlIeCA4+0JTkRMNSCMqJb2felPHbWuyKxngBCjxbBO/RL1TZT0G8vgEmOk4HQE1o
	 H08oH0ThQ3+WGLgZq+cdS/OP4jyxwmavA4ybUFuVPZ0j0n6yWo8Eltu7YZNNC8EOUR4R8
	 wmT/NZj2AkxXIGOIV/LuBWLTwDWUGccOerESKDYzsUyDk7Cbix2avTGFuprNjScstTbgx
	 ULXfrJvH4wAAgvp+2iIsr+cCiyVIkoXZwQ0F2TGi2QfslmbxA2wRmhhszgTXasEGkj2Qs
	 ZHZG+mJGxirQAs2ydcKjYfB3mATkNfe/Xf9AiPBUX/RFf8bMkZ0Dkr28dJtt+56GdDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8uJuWGjOKLnPM46PROx2LP2qeyDqFKLX/GoOuDz3dgU=;
	b=VQb6cJ6l0OsUcXOPUVaefXfPJWSzAtApXgOTjl094LxXeIFw1Lz1cI4jhnAYOTFB2LOM
	 ersVmZPF4CN9EWjtejVhMYWKUBt1VOFevqCfuNlhgaeAA1Q93HVMSe3cUDzxY8jGKn+gl
	 5YLJB309DuZj3fpZjJbDNZu+rObv0LJ4tFCouFYZqpv4ySSllR66QPJiRW3qvDhXrT1ct
	 2a5v7FfUWzdf+sN2zCjbmpfUbDlPEY04BzXds72ZSUoxEmWmJbwFyyYS1DT9YxmzbqGcT
	 QE1uP+In6UrnpuGCwpcWASvnueL7JPfLUZzqvtozBdnVoMUVu+8drcPsar1JQyhR54g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826329;
	bh=8uJuWGjOKLnPM46PROx2LP2qeyDqFKLX/GoOuDz3dgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qguhF9ihkHBsph2o3yPWbDqFVF4WUn0/Je+PUBOdqOhcyFzXgfIBeUxVuEZ5E+WoZ
	 KRxT9DWkvnwRWOnXPEJgo1iOEh2N1A/85sh/nIITBPp2tuRTQxcYgPTjfWZnn8SE9o
	 rZ6hqRD7hpswxhRnlfCXfjJpTTJIxBCpqFpWgU5gtZd9dNL96JEfYbj9RAEnjAY6JP
	 iiQ8YPGPUKJhi/A5CSxTYibA5ecf/gF+t9qJrJM9SD5Ykb2abmBfC57Q51yG35lnvo
	 Btiie27PsJlmTzKHLJRf2wTEfMgXvaJY5idKvWMsl/LbHKFa8EBNruRmAcoKav86zq
	 FOdZ0JUX1BNUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07E34605EC;
	Mon, 16 Nov 2026 10:52:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDCD928C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFB1780DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:52:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXyIFI_mCt0F for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E14180DC1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kAF4sFXM
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E14180DC1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:52:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D4C860626;
 Mon, 16 Nov 2026 10:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C8E1F000C4;
 Mon, 16 Nov 2026 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794826323;
 bh=8uJuWGjOKLnPM46PROx2LP2qeyDqFKLX/GoOuDz3dgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kAF4sFXM4u3MW7LJ63gV/Swwdc4EgNJwcSlkm0yqnrhR7g3FZxu29dy9gGDMw192u
 EMXbbm8n2yhHQdjLkGIhyKIeVOV0tQlVPpertOdErTYwWP6hD3YWh21qrWOdwWRe+E
 W/MUASmonjkRamwZewos4m5pJ+bb7oK7o3BD/nPOPwgkyDd4E7h7J/Bedj/rN3px05
 1fEl/PVcOCTkOV9wexLRhhAUz7Coi8Nt+M9H59lv77dfTv8N2x1l9xE282uK/8z46W
 Fr72+1CRTyOoVy4ybNE5dq+CSk7g5TIP/f+5yCTgRM1Mdk/BQ0GwffZ0B5uQ2sF+OA
 /xtjmDEtPVFdw==
Date: Mon, 16 Nov 2026 10:52:00 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Bruno Banelli <bbanelli@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Dave Klotz <DaveWK225@protonmail.com>,
 u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2] board: spacemit: k1: accept the "m1-x_" TLV product
 name prefix
Message-ID: <20261116105200-GKF100523@kernel.org>
References: <20261111-04-k1-milkv-m1-prefix-v2-1-3dae0c911965@kernel.org>
 <20261116071332.2637068-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116071332.2637068-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

On 15:13 Mon 16 Nov     , Hung-Chun Tseng wrote:
> Hi Yixun,
> 
> On Wed, 11 Nov 2026 21:36:41 +0000, Yixun Lan wrote:
> > board_fit_config_name_match() derives the device tree name from the TLV
> > product name held in the board EEPROM, and only recognises boards whose
> > product name starts with "k1-x_".
> 
> After the rework this no longer matches the code: the mapping is now
> done in fixup_product_name() through k1_board_map, which matches full
> product names, not a "k1-x_" prefix.
> 
> > The device trees are named for the K1 in both cases, so accept either
> > prefix and keep deriving a "k1-" name.
> 
Right..

> The diff adds one entry for the Jupiter only, so an M1 MUSE Pi Pro or
> BPI-F3 would still fall back to the default. Maybe something like "Add
> the M1 Jupiter's product name to k1_board_map" for the subject and last
> paragraph?
> 
I can adjust it

> Also, spacemit/k1-milkv-jupiter is not in CONFIG_OF_LIST on main, so
> neither Jupiter entry can find its device tree in the FIT yet. My
> Jupiter board patch adds it there.
> 
Yes, we still need patches for supporting this board, give me some time,
I will review your patches

> The change itself looks fine to me.
> 
Thanks

-- 
Yixun Lan (dlan)
