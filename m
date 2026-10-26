Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B44606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MjaIheDQ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dNV7pI2e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8773580E21;
	Mon, 26 Oct 2026 16:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mio8DlhHpX4E; Mon, 26 Oct 2026 16:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAEE580E36
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031274;
	b=iRghaCYFArnxF+2GvlLZ1+93EhjoEcNTJ1niDtArF45AxlYSBdrUXfambTVhL2x2IpJa
	 TCsjSHbaBEsof3pQjdmb+uj1npE+lTe90I7O2FQWCrTo9JmG7gvSPcopSE3+XfTrarFgw
	 jJc9c4V0zBKEePulEIZ60scWboIwQjdPFQTBD6ksGDD24D4529/xo2gdZ+NIilmg4M72j
	 UAGOeZE2VvU4qG/wdSlOCugZO8z717mqVBm7M1/3G0YKUbtAOtwgLs89IRrZZpdnethk0
	 Gr73mY0c4U3PxUW6dQTFbxr40R1mULlM/RlDoh3TRuwbaxuJtKMgklhHwYqOq6W92IA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wSpHeoFvzlTU36UQ0tSBdM5o9X1QuDKAnkGfTvNrw5E=;
	b=ayuX0MyxmMog9As7AVZMoOK51b0S4on5OEbQOvkMjaRVBlbMTpBUOpDlhWvQkroHGfR4
	 acoOzGp7E31VxLL59yM3UK2aen8N8M8UXFcaBGAu1vqLAwxvFEJFWaRamTxwzFbzWWKJH
	 Kero9crTo/yRgIfUN2euzUj7TWzTEkHC1H1CweNiluYsaX2/kQVp8atEUOXlt67CPbxmR
	 B8q4hfGmudsSitOhNttoJ9G0RcWWwJgYTP8WRFrwZhwAEDkDvWqVfUKhasjce40EmMdIZ
	 ymOcdSLasOf8bPBQYffj1/Sm3xq4tRnH4y+Fk6o+hmvXoyLCIcM1rsfs+zLu6pwQJGg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dNV7pI2e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031274;
	bh=wSpHeoFvzlTU36UQ0tSBdM5o9X1QuDKAnkGfTvNrw5E=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MjaIheDQNRZG25Y3SgRCn7lG8OYmmza6s4hs9Yyd2kPLiLXw18oFocE3d4JVIlzUf
	 KUKiTkNV0KSCoh+HKEskqmkmOD2MxkQYRPJ/gsHoF+16G2b3M1DwJHcD13ngNmzPcy
	 Ax7t3QsEbv613XOCpFmBbkc0Iia09L3d4fyDZzfZxKQxBRvs20bSJ188JOXENamtcP
	 ARNrlpcKQUf6v/Q3XaKcfoSgHDar5Wgz2/jJEKPp1FYzZF9WIaNStymSBvrq3Kj7Rb
	 G7nHjsy2xaHG9FcvABPHOHPrQm2SrD7uXcm3fKy08aYchwL+Fproe1lZTq4Tvp78F4
	 5K+dpZ8cdRFVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAEE580E36;
	Mon, 26 Oct 2026 16:14:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AEC94BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CB6A80E21
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8eA9DF1GQiP8 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:14:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A919480E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031272;
 b=pnZKmg51wphynDjCTt3m6CGsmtGCnMuz3SD0GGyxHpRvCz53tnq7/KAmUB40DHEcxQSS
 VGFRYNP2f5/duRZdpSdZ/GC/O4qFq117Up1XJZx5ti613uWQ5zymDTBIAaO+/SHDZgEdI
 GfwTUKym1/UOH1weO89NFoiedjW+gpq4fFArTi5cigSL4hZfPpMLmEcCpqLOUbGv0UUQE
 4SSQ7FCS6jQPfr3wlYaZYtyMXf3+pPnnY96nNqOtcnFnI1Fc9FEI03RaCkPD+8C0JT1Ey
 sudOqUqDFoZqPFctX8sqz4T5GC6Zu6QcRPg4iKp62OWy2xue++BEKEsQmBEDL/2bIDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031272;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=wSpHeoFvzlTU36UQ0tSBdM5o9X1QuDKAnkGfTvNrw5E=;
 b=P+8INDze8Xa/dihutqWzG9p/OZn43dXqtazqfSmeVcfvAMRO24dlib7ae7x7Yanza9+9
 aW3z+BUVb83uFKu3wiDi0RKS9fTJ60mxLpeHT+bqIdiHdQ26pHoOGa4XcTAyyTswPd3SL
 G8xKID/8+l5bpPHbZ6aWu9evhxMua94J0K7/CAG1ZkCTuoHuCgD24/Luc7NqdqxHq103H
 5u/5fPrRdGhJ3csptP/1fqHPY4tdYk3E1mZ61Tt1bwRNtEx6Z3Jw9S6PFPXkmCPP6SIPj
 WmHZkDuVCRfj7ou57d+ySmjLWUyEt+IFwFaSBHwdcC6rPe+tVngELSIvo2Y3fpn+zlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dNV7pI2e; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dNV7pI2e
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A919480E09
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:32 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cd5c9e52398so1109383a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031272; cv=none;
 d=google.com; s=arc-20260327;
 b=OFwOPzyAwRAYwMdi3EismfDvSyzjwKwipN0UEkyotgiNPailhOvPdPZWtF38Nr4A54
 Get78YsE8HInz0/78VEJgig92a0NJzLPiFhkyrR+hNY/KGTFHX2cBKA4v2tcg66HXZSS
 Jmxe0lXXIBKZ5aWmSAX2jLD/Bu4kvDYTttdFd1qPHt/RkDTO37XUhoGmIcg0KtVOrD8j
 aGLRP7F2Dj6q323NMxfXZ8U6FLewXnlmJBs6NEK/9zyDHKImPE0urFxbbl21lQGyRXbW
 VbdHkikgAeCaKK10NBqU7nQlY6yrlNzohBzXZAJuS6KbE6+SZF5YSUOetv3XllOl/bgT
 0ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=wSpHeoFvzlTU36UQ0tSBdM5o9X1QuDKAnkGfTvNrw5E=;
 fh=roxpdKPeJSqPijdsITN+QXVvPaO6+8qqlqZARCOszQw=;
 b=YuNv3tLZYZsuLzACRpI32Ipz8rugKd9APqWR3sopP5+0hzMUdJbBkOeW96x6Qwnpv4
 xN6a8B/2hL3OkAWsWZ8vpuruUrZbLXMcZiio6762EQGetnhGzIfiCRKd3cBgvSsT9laA
 2SMjWhQWUm7f4mU5jnbnnWKUNUDZqg9ck7i8lDR2/oY2/bv1KhfdmyweXGo80gG7l2DO
 tcPnbJV70IKz4Ay7L7RO1gdLuPKaP5AvovcBAqeYNF5Blqw6WszLZsUVpGXPPvWFCm4V
 /TNHKNoZz9dYexaEf64xInPMv1u1ERCaDgZu2vmth5x+vcbDBR3xU8Km2lAN+VWR/muF
 bmlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031272; x=1793636072;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wSpHeoFvzlTU36UQ0tSBdM5o9X1QuDKAnkGfTvNrw5E=;
 b=dNV7pI2e/eXLZ3kYjl57aXrhUGBYEqOWnJLUYzXY/ZQ1JjIUIYJXMTbb3GxttOGIBd
 dwm9G3C91k4asGmHWE7wJLDyBELeumjAIWaEckFgyBTHqf21umlUYBQzBKJ5gC7IbTlW
 /7zo2NjDf5kyy+w6XqcwWagfICpck/k4ODots=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031272; x=1793636072;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wSpHeoFvzlTU36UQ0tSBdM5o9X1QuDKAnkGfTvNrw5E=;
 b=BxKvLM1yairzMnS0RplGjGFHi25UTrmKp7fFTb8Bq+zhQZvk7j0h+f002lfRKQHuAf
 G0fYzeuzXWfMc8J/SHdR4R0UDzc9K93fY6mTtUA+z/hM1v129wrMLoJD3U9jgyfg8KuB
 9xQtrh7G40MftmzwYkjscNDEDgPJLKpvLiWoMD3nD1uzr8GhdEGtNl3eWwEZqbtnsaCS
 SS4x/8PYVd0wpfdcXNL/h7/BURGptQjFN+bT48EUzWmdCA5plyD+DmOJRMxFH0XfUwRA
 RudXzlRlmpd80zEFiYqq8vSeeYih3hDIMNe32bmyQVlJiRZNLbBVUBDMshJEZT75tLAL
 IXHw==
X-Gm-Message-State: AFq9FYI1pNdEWjUtJrYtoozCELHd4ZXhLWELy90Gdo5USiN/zJC63iVw
 KLZkkI47CjezoXleltD9Fk2mSO1mHfdkh7XbwqiJ/O5PRSwxd/DI6WByBg9XssBk9DvMPNTc8NF
 xk+AT6llNEvN2uGZHzAPKW1s8i2e7avQgxDGrwCrh
X-Gm-Gg: AYBFou1KnBhUu47RNx5FGDadc1vBvOWZJ5AlZbIx9MXcbKOh7Ubg3i7Qld5z1J7+nB9
 uTf7Jtk+SPNCOodzTCSX75ded2pzdeTAowieuLaPUeXNV/va5oOXCw4ipMsGA03xktPJHahldEx
 JvxJHiCStnbcV+HBBxrejATO9bvC7CcMuZZYx63ow4+0CyV2ADWa5+c/VYk8cVHFOuP2vv0qzov
 JRKDm35AAOzz9U2vee9iabtqqMCHWxT+ZyJ9d0G8HwyUZd58QHvcFxed5C8Abeg5JiCG+ub7U/1
 UqxhSoGxkRT3E2+N49GgdqL4sAfArWGlexwVJXmQe3shd8lXx9tS/Aa+4UI38xRIOacHhvbvJqC
 YxRICqbWXo7Jd7ckox9UarhG41a8lbWGkysnSfVKeAqSMwlZfdnlj1u+b
X-Received: by 2002:a17:90b:2891:b0:3ad:4a8b:c6e1 with SMTP id
 98e67ed59e1d1-3adea9dca56mr6114471a91.19.1793031271739; Mon, 26 Oct 2026
 09:14:31 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:14:26 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 10:43:22 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023220133.1396280-1-maxin.john@gmail.com>
References: <20261023220133.1396280-1-maxin.john@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:14:26 -0700
X-Gm-Features: AclHuK-3b1fd8Q8RPEWuMd9EYNyBhSgxlHkU2_IbLNCFhiobIb2wcfT0MQvgtzw
Message-ID: <CAFLszTi=2mqDXv2ntE_Sgd1E2_JkjLg9yJtt8Z4HSiT9AZJfhA@mail.gmail.com>
Subject: Re: [PATCH] cmd: mdio: check argc for extended mode
To: maxin.john@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-23T22:01:33, Maxin B. John <maxin.john@gmail.com> wrote:
> cmd: mdio: check argc for extended mode
>
> Check argc before accessing argv[2] in extended MDIO operations
> (rx/wx).
>
> Return CMD_RET_USAGE if the PHY device name is missing.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>
>  cmd/mdio.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
