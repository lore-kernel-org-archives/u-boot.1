Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1827606C3EB
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K658MmDl;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=fs4wSURc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AB868107E;
	Mon,  2 Nov 2026 15:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bsZAhgCCBVnW; Mon,  2 Nov 2026 15:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D0FFA80E8D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793632756;
	b=MZKHmuhF4wJbd745hRweip8H6v2bqYk41Fbv+QXxeJDqG1Cl5tSW89WCcOkXYZpS9Msx
	 Eu9hkd5NBfS4vpk7ltr7eNE4/SyR1DtZDPZ8YXH/4h877WuExh0lFPyl1Tj38aeBDf2Kl
	 /NiBb2gsbgdakY8jHfL/6FGcvdQudx2ys7ARzSoRcgiAW2SVmW7M1SAp6QsN7Op+ulpBA
	 QECqbOSQNuKX6Dvcjr+nADaliiQnnreolHYmJXZVGYIhhRXMHZGhfHn2DcpN0VxxZtijp
	 2rdOCt16fi/rOoifdyr8GOuuS4nYbRofLJ9Tfjmt8tfHOijdXLbRxzb8Wd4Zzv49Qaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793632756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gVasfzgd0j3zAbgK8ve7Zg0STG4nH1cjHQ+uvKs8b5k=;
	b=X022cTFFbIY4qxc8Iuox0RXvP/lvtfV6OnjlSPLfoPXEMSACdtl9uPnuMTYbbGnrWO84
	 gl3MBtkkV4t/v7vHvIxZ/2LXogBtbnm2fjE9dh9TtqcirMeCYrJQA13XRtCc2y0KgzxuC
	 KFGjYscZ/uTfoG/wMTJbV6omE7Y4KEqlIgzhOrf3ov8txhdF7GG1mWelPLoYKZGy/Vtxm
	 0czv55JVC582FxmqYqIxTbG1e0xgoY/7wGt+PKg81KK2HQxc6cTQm8/uF1Yoiww/l2JTh
	 eCteu5N2zoqkNLwW5rCJIm5PXfRqc8xtZRG4nqIr/DsalhWC9vV09En5/8Os1CSgiIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793632756;
	bh=gVasfzgd0j3zAbgK8ve7Zg0STG4nH1cjHQ+uvKs8b5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K658MmDl/pE9oJHUrnPyAPFYqD1up9DSHKshsGHfJa2UET+G+JazrOR3ko9xlw1Lx
	 sWsHPnIeW7qxh7Q6iXnPndfPCnnX3YPAtXFs+eUGMrmP2yXrYNAP27Nd9Bpo7c52+9
	 t2agjQ7CiU19gJA/W57+fhNXP2KN3jOMJrWvh8ZSm5NoShZhgAkrGCETmz+OZ65MnR
	 bGRkyoBeN0L8ib1TiwKJKMGKgFybh30DOnG8OIsqszkvIelk1+yLE+FCa9ZiceNRux
	 DFu3BoJ/CWJn/AUaouw/hrLHwJhGAaDptHqemfHOMM0ofUMyGHiqaAZ7+2bDrLcdHR
	 zUHa/UOoRFGLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0FFA80E8D;
	Mon,  2 Nov 2026 15:19:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D9A8D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3B1340639
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKHudgess1Hu for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:19:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F1AA4062C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793632753;
 b=mHTjhoAFMf7T3c8Jz6xReSad8lR+W9zXsj8SfZSXOE7qlwiYpvaLD6kwXiHsdf0QNTl9
 q6evwKZMfN0NqrWnMKAsFeA6YpEDtrS+9aThvlWd9IhEWjzYkJr6C5uQ6VYz29LB6ec7E
 LBAKChGRyPH0lKU97Mpsk951sldlCKBAbVbdftGFMzVUqiUq/RtSraAuW1pCb1AW7upMJ
 hxWHBrit+plQDyngBvO1uXmE0UUg9/h9/dqcz5tj4V1qp+JkdxSanGZgANEH0atUmEawQ
 23QnOw5kk7LRRC2BTNfbNfBlkqAPdjF+zBvjugKWr7O8gRRJaOZnI1xUe/ZTh01empw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793632753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=gVasfzgd0j3zAbgK8ve7Zg0STG4nH1cjHQ+uvKs8b5k=;
 b=YkDq/RJewMe0Hei+RN/1txkn+oi52RrtI0wxIfHa3ZCmplrzOxbfzmSSzR7mRbixJyq2
 KWdlk15qY+5ZlSQxYbuDY0hyMpx8U/wHKGpOa/lyJ2SO1B0ALjYDWIAa2yABCFSVF/ppW
 PsNlf1iIvoh/Ke/nIszaMnnHHmQ73D4ZWN0OSffPFzeF5yyTKuS23vrIeXiBJqul8xs+r
 PHAfwFtS/AY+tTbUZQvRnJ2wVF7EJrI5teNfg/9kjSKkB7Yg6g9u8EauUkyXOnlM+JYW/
 lB3JDa+EjUPe8kLNuX4Tu1thMYSx035RLJEZJgnKn2UnNphXugcpJiX2OXcZFlJajWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=fs4wSURc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=fs4wSURc
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F1AA4062C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:19:12 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-35b2c599f43so5214637eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 07:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793632752; x=1794237552;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gVasfzgd0j3zAbgK8ve7Zg0STG4nH1cjHQ+uvKs8b5k=;
 b=fs4wSURcobRjozepn76QApqLwtJT3i2gHp8HoA3srDsRgfFdpQ6PEYOpLoe5aM9khE
 QtLJNd1arcHQwMBKz9ehn9cYDR1qF6NQhrQ+jaAkuscPsdQN7ShVhYLq4yDxTTUqbypG
 /essCIDkJqgjMP8FFpKfemeIcM6QM/jBELsJyXF+PjFmyHVlT+CwMvPTEscLx55Ih8+g
 DALmiq69Yr7vuoKuQXG9BJyELVwwoQHUoZyntItZ7Pj/AtGKjp3EhoigPOcvsNJ4gdUU
 DVF6P4K+kGvg8SqtMjBGcI3aHsyeQLXo0KOgpURV13B9e8nkf7FPY73gE50Xdeazjd1R
 s9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793632752; x=1794237552;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gVasfzgd0j3zAbgK8ve7Zg0STG4nH1cjHQ+uvKs8b5k=;
 b=FGjm3Ue/Fo1NPLWD08sm8n2fIMo7q4JXscY4+IGWbMl6TU5nXKMJzR66McIjzEhaTO
 uEi8A3f5PXfac04DZBKH743zX1nb2wDoS6SEfhpVs4l6SHxJOF82E1VrXs0EaFEA5Ki8
 W325Vd7qDs4t8ROJ8h5jG/JXjy5NMNKtxSgxmjaAAivxn61z1Xnl/6mTp8yInPL8+f0V
 Q6wMroy2Sf6abE/zGhaEXD1uTb/xcadbZa94b+4usjix14KTlgvnP67dlA/p8ebdw8Rk
 zqNgMqxG/V5bec5m9P3n5BjbuHoWhfaqKbxyUCMaiwE/vtGuqNChBzSIemizBuFr8z10
 DRxQ==
X-Gm-Message-State: APuU4Z+LdiJmFE01GZ1oIhVBN18r5GXI4NRfpFpRhT/BAUMkCczWdT7f
 GZZ6Xs8YrPSirg6p9UkAu5Hp1YtOWjfpKexskmCCTm8Uly3dWVW5RIjMXlLNI9lX9E8EKSPzPVn
 BCaNITFg8uA==
X-Gm-Gg: AYBFou2cKcRPtys1fxAnV6SRRLNgSJnQSqayVI0WIA5yOMnTdNpcITAFdrXpPZ4WFuH
 UiPhC638W26gbwU6cYsdPCs0ug5QQaP2T0uI+NOE9MrgdP8++KiyPG07K4YD/M0d435lDeCNrht
 u25VL1JyCVGmmA3ZoWMP5Lxa18uFiXAr8Zl01UvKpFQvtusHlR877IMdpzVOYnTMMlxNf2xOMpJ
 OTY0zzDHKB8txJ+xXXjrpcwHU/NH3bX51zUUU20bWUG2L37iIzVoGBIYYyTcdJUpWrZxyTwfamC
 LQxvDoOcCXwq5a2SB0ycZQAExegQpLdESrqMpakhDI5QG3ZyULvr6eENOOhrMhMxwnHkcR/vddw
 Zp9pKVQwNsncpUqa9LmKnQA2REHYcGuImpdPHBjb4lETCGZE/XFVaCXJYNIbQnktrdVDaE+AwFo
 /xkAMVvz0dT3XMEie2f76UyJ9mDFdtvr2WTyArQe2PIJy9TcieB4G259+WsLzV8LLvzGf6RGFSE
 pxeII6VZ7PI46S7TD3GeFhLHC//+q3C6TLuo6X3oYDS+WqcFQQIV8A9Fm6l/zTMl2UFFnjH2NOr
 xTVEH7leHzMb6hNYue6WMROnWulP8fjTedYdVGfCIo/v
X-Received: by 2002:a05:693c:6316:b0:369:fbc1:89c2 with SMTP id
 5a478bee46e88-36a4235f4cemr14777909eec.8.1793632751434; 
 Mon, 02 Nov 2026 07:19:11 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6eabbsm38894007eec.24.2026.11.02.07.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:19:10 -0800 (PST)
Date: Mon, 2 Nov 2026 23:19:09 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Randolph Lin <randolph@andestech.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Randolph Lin <randolph.sklin@gmail.com>, Tim Ouyang <tim609@andestech.com>
Subject: Re: [PATCH 0/4] riscv: andes: add L2 cache flush support
Message-ID: <auip7WU3pQ3g0KJi@lliang-1876.localdomain>
References: <20261028064329.1986824-1-randolph@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028064329.1986824-1-randolph@andestech.com>
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

On Wed, Oct 28, 2026 at 02:43:25PM +0800, Randolph Lin wrote:
> On Andes, flush_dcache_all() only flushes L1, and flush_dcache_range()
> and invalidate_dcache_range() call it. Without the I/O coherence port
> (IOCP), DMA masters do not snoop the CPU caches, so dirty lines left
> in L2 make them read stale data.
> 
> This series adds a flush_all operation to the cache uclass, implements
> it in the Andes L2 cache driver and calls it from flush_dcache_all().
> In U-Boot proper, enable_caches() runs before driver model is set up
> after relocation and cannot find the L2 cache device, so patch 4 runs
> it again once driver model is ready. U-Boot proper in S-mode then
> drives L2 itself, as the Linux ax45mp_cache driver does.
> 
> Side effects: each range operation flushes the whole L2 cache, "dcache
> off" and "dcache on" turn L2 off and on in S-mode, and L2 is now
> enabled in M-mode U-Boot proper.
> 
> checkpatch warns about the #ifdef in patch 3, which matches the rest
> of the file, and does not know the Assisted-by tag from Linux's
> Documentation/process/coding-assistants.rst.
> 
> Randolph Lin (4):
>   dm: cache: Add flush_all operation
>   cache: andes-l2: implement flush_all
>   riscv: andes: flush the L2 cache in flush_dcache_all()
>   riscv: andes: probe the L2 cache device in U-Boot proper
> 
>  arch/riscv/cpu/andes/cache.c   | 19 +++++++++++++++++++
>  drivers/cache/cache-andes-l2.c | 16 ++++++++++++++--
>  drivers/cache/cache-uclass.c   | 10 ++++++++++
>  include/cache.h                | 16 ++++++++++++++++
>  4 files changed, 59 insertions(+), 2 deletions(-)

For the whole series,
Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
