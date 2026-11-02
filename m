Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED5606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FtauQOa6;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=XwZc8HQI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BA5B405B1;
	Mon,  2 Nov 2026 10:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpULT1BIjdBk; Mon,  2 Nov 2026 10:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E20E9405BA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613938;
	b=O981kF1bTNY22Jms4IuhUn7n71LdedQodPTGrs6GsiNdZYIE7OqnkkpRjYXs17b5VCgr
	 mxoVC/PvHagc+Edi3kms2qrZfWFjitsbSQSCfcEaaVRiUzKtaPenix3HxAwAwWCcdUFIK
	 kZgd2EZCdUScuFnGKNubJOzrwykkWpdbn6B0QkWlEm3FT81+zribpwbOc4/4YQXI57Pxe
	 h7hkJVYdNVRTiIOhhzN2MbjHccOTVLgYvM4qpsbUxa7KELP4606l+EuX2XhQph2euIFd1
	 QS+waIOzuyEJlALb3u+JMNYlrdniUL1Ks7xpCNIt35bc094u4fQ6tJxpeux471KOkxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K0zU49DLrG5DzEoWDu93ChkhDi17H0h49zwuL/gSH2M=;
	b=V+KdcQ6uFB8nktaWpwsTohcogR52q+S4K16ZC2sIYdTvj+bOnclxl+Y+peNMt7bh2AT0
	 1cexLlif4hZqow9ORjSlFh98LHMkPiWjnLYtIkCSK84nPeZE2/foE0Jtg+C1AcJhxuRat
	 ruM2gBatTG2nMTFmh+SlJaB7WGnKjHyIWDrgKCBJYxW2TgVQIw4q0r2IzEBxxWjYMG95f
	 R3TzhZtzMybMhUpkNIfgcPbB5YzhCtJZWQOwxVxkAOt4a50TV1sk8eUNJmrPbyyOBXPSA
	 pU1BMV4APrbwRCfsXvE3f6XtFIz7Ep7vfnsCHMGE0v9EbCpBIFFhAh+45ZpiHDgF7eQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613938;
	bh=K0zU49DLrG5DzEoWDu93ChkhDi17H0h49zwuL/gSH2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FtauQOa6vbqatLTaI2zE6DzDnNn9pDxY9b3swgVzoDlrRjCXrOi8cGhCqK7iQjQmo
	 ydf6bMPEGAlFMxjCVJCzG60j5ZkJ/rnukh7QmXbIPe1I4yP5qCpPWXiXxU+YmQNbqQ
	 4725+HWaSQRRnHITXm+cwL3TsMBAri99rAj2jwVmhNlBZYZeH9IzaZ7ajK/Xtx1bd3
	 IgXKjuYnKSjdwXonf5QxM7rNTySmhVLuPtHw9pTFSk28yhoaLAhdzRVZLcTxnn+d/z
	 +l6KOmPMI5EG2BboI9eT9X/RnyzqaXjQ5s3ISdPaT+6mk4OdXGyyc1g+laB3j+HaX4
	 JTxjkuFbdnWGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E20E9405BA;
	Mon,  2 Nov 2026 10:05:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 875DDD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DC62401B9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fj7nbjf0cbTv for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 10:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7DB1B400C8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613935;
 b=FB9c0D7aInbxVcGpXjLMLc3EGs0ol2MPWUqHvCLp+mDaOVv5S4dCKgsfK+M6g6+Gp3+t
 X0iHtO1QNCRjU0csJXKptJAOeGNKSght/8FDlcpDxk8L/vnLotDGNgGv+7z5PFFEnpOml
 xBul8d2llAAWeN9pbm/ADf7KISN4flYxTQgjyMws6d8DnYZjO4kGdShKlD8nmBe12pmsD
 ao//JvZH2ZafmaabT0k3P80WpbguOmVS4wy/d3TfNwFnfr15ezj+CvYkoaAaEdURif0rg
 bghp+FqR+ljFR6tmc30VOBr03syRuv63+4RgYwhCMvmv51JMlGE4vTX+rVj61wEA31A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613935;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=K0zU49DLrG5DzEoWDu93ChkhDi17H0h49zwuL/gSH2M=;
 b=fu28TeeJZbXnoO11ialc/GFGuzRwH6qTrRTMUSL4OzYK8RLlfBXYHHxI3joBFDqT6EXo
 gRoLKzYuxk1AxQBG+dXU+yqzSQfT6iARO2ZS1hZU4YqeNbtSl3Uyqiv4HUH3pw04ij7/V
 g4PBciVkjgbtthBxvC24bkhLpXy8+z921sobnU9fW4418/GO5D3HJ67VGAzmoQsC/W9Qb
 JuJ3fWDoHV5rq9h3IK1uw2QG/IDtmeopKfGQc0lCmaHD9+hMTl8JOfr/IaiURpIZFvHbs
 1NS45AsKu0LYY3imW+/Cyl9zHudIYLKOEzxxEBMyE/mcN8APY7PEbP9KblfWRRJDV3A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=XwZc8HQI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=XwZc8HQI
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DB1B400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:05:33 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-89f28c3ac7bso902114b3a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793613933; x=1794218733;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K0zU49DLrG5DzEoWDu93ChkhDi17H0h49zwuL/gSH2M=;
 b=XwZc8HQImcXcvHPRSI6YzqdwwKU4O8xops0EOE1siMwepHcj9efZ2ipX9/nGa2JpqT
 Z/MbeqXeWs13yVdLve3/GApsDeaKv2AvkhWjf8X/RD+l1nTHEv6OAi7yAFoy/K1sBCJO
 FanCTCykmuYozrADAKe5b4dJm1UNSM9axO9CitCBaVxF0nvaGFwDKfl5BaZDsGyY+g75
 V4iC99Y/nPtIC8J9/Nw7KKngNq0EzWoEe/KlLmpgVOVGLAZFLiORS/eFmRSenWV6sX3g
 RY5qv4f8o9eF/KLhixZySwrJpzpPME9KyaFsv5GAM+k/hsFQaDbsgOlCOxP/BkHy5tmN
 w0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613933; x=1794218733;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K0zU49DLrG5DzEoWDu93ChkhDi17H0h49zwuL/gSH2M=;
 b=YIcXRuVZiyhLRtQ8ZofeIPmDBP3GNGnh5t1Uv4TcdFYISDAHV3lE6IFUXmb1Bf0kBm
 jWpmk3sX+Vjp/HMR5PjI25uh4m0fJnjaAKsxHfSaCREdSNr0SY3ageDo0KYjseKtKenJ
 DntsKZeJ/2M5b4ljX8LrlZx81zPelaAzOWSAbmzv44S77gJ3915HJ9jXHE+uPfXtwgPS
 6ulCu0eChkqkiX+jx2pKktv4zCJonw87jSMJkMaTchqTLnJ3GCt2UpmHCPOel9yN9fB9
 noEKQ5j6aCgBibjAdul1HgC44qccFDFX+mM4jr+Wjndw40qHWseLrBlrjkFnVW+0YyUz
 tYBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByIe9cbeLbWjJMK+kTg4OoukWvvzh4hmaCh8YFh2EbJMiQCaqIo4x969L8uoZ4Acfrl/w2swxE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ3rxRsz9y3jW+VKx/ti0O6utgccLZfjUqFtFvHd1oKjUaNTljS
 F0J34Bs/F91V5ZPXZ24p+4mhbMuZsyHjXIIHb9mwkbzoMwpYmw25cvb/fnnV6VeGmmQ=
X-Gm-Gg: AYBFou1rjAczIVpQO+jakrxgodq6Aqp9M4t0XXJqu4ZUcArfsFrz84Au2oUhdj1r9wl
 qCCFVubVFVY5Dh0irRw2e//6IK8JqBBhicEB8ejC5jRWMctStJh8/sk/hluCIIh7ikkc39YkDzX
 9VO0I81H+Rt8qGuS8Rl8rsCIyvSJOMiDrmTsmBDXsLC/Gj0UsJCjmimS+hz15spzgHNb2FsbROJ
 zylqWT2VZkkNa21ttF+/O6oj2zhKWFL2009CADHm/sOUgTeMU/vfWOQ5CwNmrKCez+yl4c8prQN
 7PeNX2l/06Du6RLaRl1fOA0skzN0wNPSPztBbdOzzmYru9gAUTZyBddQafiH+oOYslWW+HycYS+
 Rv75yzXw+FG/JfUncxSncKG16jyB2iQtsPo00AbltfmGFpPxwILDl2S9DAEJnCsqVg0HRaU1cOG
 ZACTcaa4+llPBnRKbqDJ4mtHmSXNAG6T69o0t0ItTRLlTufVAxKXcouo/6aIIi5FF747L4kiZBh
 vCVDTGs78XfknrRreA93IalVDvio7qE34G9td3HfRngfNW+/WKrq1KHKUWVvZOVztAannJiLAGI
 dTKnDcg3ZOfBgv//g1/t5eNQR6l3TZj3vBFzZU6FJK+AYGPxYvWT9gQTH9tvA5/Rvg==
X-Received: by 2002:a05:6a21:e44b:b0:3e0:c955:cd5a with SMTP id
 adf61e73a8af0-3e9290e4caamr6847068637.68.1793613932985; 
 Mon, 02 Nov 2026 02:05:32 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad9d03be0sm1775656b3a.27.2026.11.02.02.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:05:32 -0800 (PST)
Date: Mon, 2 Nov 2026 18:05:23 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH] riscv: spacemit: handle overlapping DDR firmware
 relocation
Message-ID: <auhgY5vDxCRWpQeT@lliang-1876.localdomain>
References: <20261005T132330-0400.ddr-overlap.DaveWK225@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005T132330-0400.ddr-overlap.DaveWK225@protonmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 05:30:07PM +0000, Dave Klotz wrote:
> The binman-appended DDR firmware grows towards its fixed execution address
> at 0xc082d000 as SPL gains code and device-tree data. On the current R2S
> image the source starts at 0xc0825c80 and its 36248 bytes overlap the
> execution region by 6680 bytes. The RV2 image overlaps by 7704 bytes.
> 
> memcpy() copies forwards on RISC-V and corrupts the end of the firmware
> when the destination overlaps a later part of the source. Use memmove()
> so both overlapping and disjoint image layouts preserve the firmware.
> Keep the DDR configuration, execution address and instruction fence intact.
> 
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
> 
>  board/spacemit/k1/spl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
