Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038D606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u5gxOhr/;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NPwIqrQz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 870DB606E5;
	Sun,  1 Nov 2026 21:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIPDQ9ZTWVN5; Sun,  1 Nov 2026 21:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BEC106061B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568394;
	b=p0YK+DhoAVIYHuDXMCo6q24tY+dltfLhwsdgYX424t3vbUzP8aFAw7CJZmtFSFFbLpW4
	 MTs2wjN/EsEFodM02361Mg3fCBx1VFZCODnOXQi0o8ThVWZdO/gKESKETNjE3NrJZKLvo
	 at7ZbF+cT/XRBs4nnaCM3AdVQcssYeowFNWcjvlHLTlbRdc59HTABDnwfmIlbTkJPocJy
	 4WfRvk7pcqh/kz4arbKpBMg1AtJhly3VwEoIXE56FRr4OsweC/HqWgVWm1K0Jw7r8HIHU
	 yWRQGdFmVk7/kTp591ym3hmiiUpii+vSLU+sQ5EJgFjqk0tnh2cWXYdFFz8+uV166LA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yOR1Fu4UmlXi58nc0p8tdZY67KatiYt0QsdiOSPXf70=;
	b=RvpbMM4BUH+vuXs7enpE7uiMCBI7eCiXnbH3pdJTpGPmUhxLBqd0WBjUL2gsJQag/NcX
	 8VJecfAk8KdYqaFHju79+YjFkPDgKJGr8RDOVa/dU2pLlJQC1oJ2xzY4ykO0Y/PAmlk/9
	 WG2j+vnADuHDL83cgAMs2oFD8aNBCgHZk+hNcUcFcw+ZlD4JckqXKAr1dbK55Uq/tMgvD
	 OznKLXVRM5E2r7KVEZCHscmU7j+KtVw4EJvZdTbGAEOnSQ5kfMp0QSXSwg8+4MoZD7VtU
	 uCdoR9fv184qJBTrVdkYrvA0EhEXjSIQ2d5kA28seA7tFejGVUYHrtBYQi+BLTiUIfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568394;
	bh=yOR1Fu4UmlXi58nc0p8tdZY67KatiYt0QsdiOSPXf70=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u5gxOhr/cNdQOZK24c8Y3VYtoYPsCgG0OxN8xurXiAj4LIX+fiTF7pDstkNyb0aD/
	 /4SfKRjfHvidfxJ76DatU1sYdofyCM/oPm1TnL8dbDdCA++SBiSmUT+v+LX9Q+H8pz
	 UlxPfvaz6EkDeyhZLaddTyb97VnM93ShC394SNCivtIknu+n8ADTbmj72qfH4fMfw1
	 6njJfSpPd5v+GOtISWFAehd3KdAkDMC7ZmFY2fVXdrF2JvlprikxRkAR7j+FVckx5b
	 hE2OQmLZjPFbpA8Sf5VdDIE/c8bx85lWM4vDKriFNLZcoUc9fAtdE1pbtN1b7DyG2b
	 b+P7zFDMpK73Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEC106061B;
	Sun,  1 Nov 2026 21:26:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4A9F435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AACE580D97
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUt7Us_m1CnY for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B6AA80D96
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568390;
 b=IgmVibaoXrBr78Ad6ImU3Mxfow1rtasSQjBPyaHo62uf2J72Q+uzpLTrWOnnSkxUXaFO
 vzVxSMvmR5g9r7o8kHlZjcWZoS3gAgl95C5eFNgow86XBYJSMylokCBhcvrvqBhGBZaMj
 1q/0ppbRPnu2f73T4RUwvUQqTKxQPKbBzH6F7k8NIWD6ZC3F8i9cbBiamBNzYYOUg6fen
 9naUJN4h+2twHBDaoEpHzenldI+boTdgAASUjL3aE0K6n/2631DqGM2ZkXamdrHcb1d37
 4oXmB85N7IyTMP39xdulROoWX2DS4Ee91JqfXMItLvacf4ZBxrc5pkplZhKRDtiSFDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568390;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=yOR1Fu4UmlXi58nc0p8tdZY67KatiYt0QsdiOSPXf70=;
 b=NZVVR6vykB/5SIX1YuggPMGkqtYHQWnoiBUc40LmyXnq38/60tBxIbIYmaC2jIsfJ4q7
 j+enxcIYHuWlw3fOQcW07MI+SRlE8qOSdJW4ps9oVSdzxY/MANy82KWQsO+4lI9uthVKJ
 S/fu+wQRccEG6QPl95FpBEd+yKVijc9ncr3FY02GZV1ySCvhzsO/ZdqQnGNC+LUcjKiip
 MLH9Xkci2Y/AbgSEcx5ra2duMpk9WWy4ox0Gp/yu3ZbmFgw8bAHyGzHBaZKya5NMzBZ8U
 TeXiFOWRHxpmQzgMNFn+E3WI7Xd7G8WL4DMapBe0x/ewrPD1YlK+icwSA/4XwpoVJhg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NPwIqrQz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=NPwIqrQz
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B6AA80D96
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:26:29 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6dd059478dcso1827513eaf.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793568388; x=1794173188;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yOR1Fu4UmlXi58nc0p8tdZY67KatiYt0QsdiOSPXf70=;
 b=NPwIqrQzUUNCMnGNMv+pqyjTA/114K8yU+s8qtcUCNrp49fXbCWB0iWyoTzofD7j8U
 ATHRY6XU1qNRTkeKbC/tm+0USHxgh5FVHMQNpJSnxa671XHBEWfj7sqk9diPJIwmK4i7
 lXjvdvBD2/3xEpur2cdP0gvUsKFtsh8pBoSxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793568388; x=1794173188;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yOR1Fu4UmlXi58nc0p8tdZY67KatiYt0QsdiOSPXf70=;
 b=ugH/cm1ApY/zxHWl3gYoq/wGmOfz25OdV4L4WPTPk0hjmO7TbFoatUR3XEYJMAWJQ6
 Z7Snx0Bbm0pHMWB4stPmdWwO1T0pOFwyCQH9BD/uj8QYzfpUwPvaiQJsdMUODWXoBkOQ
 HyUncle7NMOs6qMsW1VTz5sseqX0KZPngZrERYqME1aSFTqUMWvlkwX6rAgU24Uy7MYM
 VgCb2KLxBBrlP6e1BJt6OZSayXa+YcFFMXCtVEe3ZuTOOsG0nmJu7P0JgxaKTd+QysyM
 /DC6MsEwspxICYnAr+yuqgkkseVzMehXlfKchgLT6ClWZL9nmo7D5DKCnJ0xuE+hFG04
 k97w==
X-Gm-Message-State: AFq9FYICgHZ0DOwznGX/KO1Na25kz7fGJwsD725Ro24UguNq+mVDeQHX
 VBqcm/uxUDCbuhIK0/Vsj8iMDQUdU/eRF5ai3WQ/I9RJLHZAU2QIOEjkI/K8/zGm/zY1hJD3i6r
 6of2PZU3O+lRU
X-Gm-Gg: AYBFou3GC0xNJzD2sh+Aw/asVpx1K+Sd1ikkvq3Vsr9XVO/k3H5lIpLqy63xH0eTuCh
 rQ40+QJ/fmncXD9kZNRnXaQeqCU21NxGYlKHvOFkQ2ipxs0Qoi7dbuGyBkzDC4u1CfE0QjXkRSP
 NvI51DqUq/HeG6OSQXzQ+NpcQ1NKtO0Cm8R0ezxOv44KjgBQxamKGW7jWXYWc7aAouARzyk0Mo8
 GKZlcD+MfQf2z8XgahjjosxUbITZ/AIEbpSX3a4kbpe6FU8GIond9IAUgJdSlouf+zhxsh8xLRM
 U80jeLNJYnsHtG9VTaUkNBMkMd6RjVtF0iDbdcNY1dAgqFJuy4ap+7J9DzmfobELb7S+utwnyu/
 +viiZ3oAkNkoeCK6GPjDXpGMb+fT3XqZe+GIBsPAxXhqs7BW/CUfKwm4cmsvgTAmSzsBGLkCbgi
 8tTBsr1P7z0WQzdSt4oFfQsowvzQsfn2LZf1sfmMOsq/yrzghZTpe6MualcUxrED25KahLUSCqd
 BUpGGiccld4O9G66UONmWegGUsn+NMe+Vo4SnsjxfY1EoQ9t7BqbEwTrbtlA60+jujCr4toUE8+
 HclfpPjUTmhgLCRkqCwlY4IGI+0b6djdWVlPymg5f3d5afciq/FINZs1wOOUK05Hdogb1lmzYZ9
 JBPi/xngIdyuqnnt19RebcNMAdXvw8fEoC0wJAT99F972qvjTCzRU86ZF0JOGHKQloCRyrxOXRv
 hsN2K1w2VAzv8cd/IWWHOMYgri8jQJ5A==
X-Received: by 2002:a05:6820:8906:20b0:6f4:d9d4:393b with SMTP id
 006d021491bc7-714f24f9ad1mr3676433eaf.2.1793568388263; 
 Sun, 01 Nov 2026 13:26:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm7405744a34.4.2026.11.01.13.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:26:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261021170354.3260916-1-trini@konsulko.com>
References: <20261021170354.3260916-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: ti: k3: Add select TOOLS_MKEFICAPSULE to some
 platforms
Message-Id: <179356838721.224230.16076391655393632888.b4-ty@konsulko.com>
Date: Sun, 01 Nov 2026 15:26:27 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 11:03:54 -0600, Tom Rini wrote:

> Starting with commit 2f736e8e3f4b ("tools: build mkeficapsule for
> CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y") we no longer build mkeficapsule so
> often. The TI K3 platforms, on their Cortex-R cores, need to have
> mkeficapsule built as they generate capsule updates, but these updates
> are managed by the Cortex-A builds. Add select TOOLS_MKEFICAPSULE so
> they build again when the host doesn't already have the mkeficapsule
> tool installed.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: ti: k3: Add select TOOLS_MKEFICAPSULE to some platforms
      commit: d0dbe57fcdcd2fd2de36152712e3e6cf520c1543
-- 
Tom


