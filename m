Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB016CA5FCC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 20:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62B1040B27;
	Wed, 30 Sep 2026 20:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOrdBxz7WKxJ; Wed, 30 Sep 2026 20:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AFF4F40B2C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790799314;
	b=jY5FoX384+pR1Hx2hXizrgHU0Ix6xvftGvnahkFM3XQdJjHy9Bg1Y2+Q84yLcu4iK+eT
	 sPUqlZnXjMCCZUhI6zMCNveRy+ditbI6KrGzWg5EGIvAORd/HTgYEv8ELHVNPb982qp6d
	 Txgii1goJ6ntx47CfI/s+l5qkw/QgqHp51Ivh4qB9KhFrOZq0rvQc4TbkOOWRHUsldjXz
	 OtKdn8MwK29riL1NzRTPz4dP8yPujuIP/IFIJRAWbK/nvUtvzU51dV6Sx+SYps+ycwuPI
	 a19Q8zW6272tqG80F6fm69Cj0VliPFKqiOW+0IWrHzRGzxcd43K+WuGnMfxms801lRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790799314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QsDfyWegfGC2pdN1+VhnfvRtGqrJKN7hQnQ14fRYRmY=;
	b=GHw+WSsHmio3qfgZJaK63rCXkdWbEeJ27znfzClEfhmaTyTDGZCXhTtA3blcl489fH3Q
	 yD5O3gtA61ZSM96YiwkHOndSvxMZTQ/l4pOFkFEOmFyzmyu5A+eZzTztZX5qpT6cT0AgV
	 GQqsjpQF44IjTN3Uk3rUdRaJaNeBbfA2j+MjP37N/G2FabgWBBVCu8/O8Lud19CI0v9J5
	 +pTd5Zq32ZLoq1X6T+L+tqXe7NPlDNZpBRkWj5mrrRaIiA90WlK1jKonYd7GV/xOPDocN
	 mIXcHOR9GmKqT6ioU6vmCgoEk7xSeCsQiLJt4LBdAL8Zshk1jNteWz4B2zJyBehorhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790799314;
	bh=QsDfyWegfGC2pdN1+VhnfvRtGqrJKN7hQnQ14fRYRmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V3NIcCoALovtiwJFaHTjBIjN3yBoPGec3Mba8YmCQB2ClLNm7dEnhkqD1nHUBdyn9
	 A6pXLYO5QN/dgmuyF3SXyIMRbUNm3WrHBU7icSMXjLqM8/U4iQvmE+7JeLoR6kLuRf
	 XtWBoaPeeO0HN/xZZmhvviJ270xPFeiGTJghQDt9IfFzOncZwjQ1HltnJRP+/fIKub
	 CeOQ4vMsDw+NtbEai81yGLbGmGNuu1FY/UqnmP7w1UWAD+OPGVdvub1KsR3kRPO9ih
	 xZfbt+uAcucmaDjFR6ME7N5Y3vQRqS7OMcAyqInrcq0sVSJGoA1lZRlyx+ILA593Ok
	 NA1G58mEjXEQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFF4F40B2C;
	Wed, 30 Sep 2026 20:15:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91D1E3AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77AA260BAC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VaP4K9_NmS_i for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 20:15:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C0753607B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790799312;
 b=iuBGm07AeFPhMk1RG9JGaxA284nIEcgJx4nFMpQKqxNZqhQ7qs0qzML7Thaxire/9yjZ
 RSDMghXkHTyyB7DNHIqEfYNnC4Nu0TQAgIfaYG/FhkI3khn8Qd/8rGcyFNrPK3RmsDGDi
 yCmyhHBLGg8qBvEI4Qg+3bx5G3ciebxk5FsG1Qp/LtSpkHEyhRSHZtCtbfn99XHuFVtN9
 p3ym6x1a25y3FWzHKN4D53iVPhTExrMo/qlZNCNGjpvvaVpsxHecHKERF8W1ZaZvLTQ84
 V66/P/TDf/WfSPVxmHtnHOVgglZujRDvkDE2xxjTso9TTXq6P2pQwd3xgK5aZAN5myA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790799312;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=QsDfyWegfGC2pdN1+VhnfvRtGqrJKN7hQnQ14fRYRmY=;
 b=UJKpsWWyG5SZjA2BTzQNbqYJ8wX4mfCnlrgJ0zSQUYh2eu+vXyJyMeIhyd52q6WBd7g2
 ZASsi7UqR89HzAYG3lsL8IXJ0q2ODR3U7Ejh5w2CvYXbgXyFE5yektCj4wK64hAxq3swH
 oZvcwsbKoGP7BrQ3RuU6poCAUqhA0v4A3eeIJTb1Vw1C5KBwrfJ1bdIs5PyoZmCNdUAtX
 y5ZuFC3SPW0kpbiKdXZZ3fEgSTUPQLYRIYt7mpMFdLOIrjmdB7v+I/iXUrqUIx4m9rYXP
 7g4UBjzxALce3DE2l66tUY5dPMMBWR7FZ0hF+ViSiq+BjOPMAKyO5QxVadc066H5wIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lOfupxrT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lOfupxrT
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0753607B6
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:11 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81bea216172so2631560a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790799310; x=1791404110;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QsDfyWegfGC2pdN1+VhnfvRtGqrJKN7hQnQ14fRYRmY=;
 b=lOfupxrTDMqQ7HAVc9ncPrRzIIaPGI6IcO0FGe1zN6OCoIIZu3ef4g7tIh7+wvTKvE
 64rVm+d9Hr1Z/1/IIvFsW0s/ZqJI3yX+0VEbQ/XKo/27jNpvC1Il9B/uxSo9F5i4b7pj
 Dr43kcH+iVwPR5TcbWo6F+2+ylxzvwpSYZbWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799310; x=1791404110;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QsDfyWegfGC2pdN1+VhnfvRtGqrJKN7hQnQ14fRYRmY=;
 b=WUjbOMh4GmJ6AVcYaZcmHZaBzH59+XmLPc6bQZ8rzkRqYVUDIUKKUL+uL1IjMnHcX8
 2/VY7E1S8ziRx956ZXKMzE5sPL8rH7lBMPyHk8JmQLs9VTfWzGIxepNFhfcWKgGe6cT4
 zRzBgXrOjfV+T0bsagACS40IchqggWEzyZOp5c8hhRqASSwohl1T0gMJ0EyUY5X7++Z+
 g414Jw04DdHUVvODwH7yz+nBuibLheMsJP2io+tYlfJhGa265C9rh6csyG6+P+qCJhmx
 uazdlpP9fyn4CjQwHUXRM1WoF6O+YlVeEs6ERGTF5lZsIuje8hjdpdxs/HKjzYZijgXq
 4r/g==
X-Gm-Message-State: AFuF++nq7lYsjbxkfWCTQvzQLJfy57g0swupYrS6FLVkqZq18pj/VnLi
 ZAC1t2t8h6bXjeTFXx2Nwm0oFsz6h1UMoMacgEQnVRi56Kkxa4+mLnWbR3ZEUUropJ8=
X-Gm-Gg: AYBFou2oWAtKmDouQ30W75KYnvG0W/v+o373brp4c+5eKuzhFpjn0UCWg29evd+jFXz
 yaRWtp77atN2iUBor+vmS2w+hbEmwrP1GmEDowe4uaYTkNxcwLzyEbGyRRXrZhrDdBB6olqtnbn
 8frX/RXvD3GEKhYLQgmF5ezlIeTWYsnvmeN2kjIKBF0Cf6SX0Ygsv+cIg+zY5LtODCCYrz5XyeG
 rKGO42r7xze8pWlMM3w2GrBMBuBcpcxfVMMNsXZhIqePm4vjhkhK+EH88bUZxycKT+8ZwqBaMSN
 VDe/t06287I3NCJIcEat+3whJJj9nS9SISXoTK3gsx++5WM7ajCnQNhWFpfBoTEKFFlDA0myZuk
 8zxFo2SDKbsZfencWrwz2Z5rKTHzM7H0BUe06Hv09szKmc1coYnAYuFzO2Px9haZtGdCcScDQPm
 E0a2ktWepmxg1atyS3Q6PenPhkNcW/4W9a8LMTe1NhAgrO3L/8UIh8Z1okadB/60SDtRKNvW58y
 B6xprzS5pyOUkBMAbU8nqrzQno4371TsPEEled8kbJw4jhVxwyvxJtEm5UdPXA5QLyvvylfEyUl
 dPqnN2pR75hWH2oFjw==
X-Received: by 2002:a05:6820:4df3:b0:6dc:9666:5dff with SMTP id
 006d021491bc7-6dcf4c6ad3amr2639047eaf.21.1790799310245; 
 Wed, 30 Sep 2026 13:15:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm821896a34.3.2026.09.30.13.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:15:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260904132046.45008-1-pengpeng@iscas.ac.cn>
References: <20260904132046.45008-1-pengpeng@iscas.ac.cn>
Subject: Re: [RFC PATCH] vpl: make I2C and PCH options effective
Message-Id: <179079930875.506059.9032435283355307700.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 14:15:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 04 Sep 2026 21:20:38 +0800, Pengpeng Hou wrote:

> The VPL options are named VPL_I2C_SUPPORT and VPL_PCH_SUPPORT, but neither
> symbol has a consumer. The driver build uses CONFIG_$(PHASE_)I2C and
> CONFIG_$(PHASE_)PCH, which expand to VPL_I2C and VPL_PCH for this phase.
> 
> Rename the options to the names consumed by the build and update their
> defaults to the current SPL_I2C and TPL_PCH symbols. No in-tree defconfig
> sets the orphaned option names.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] vpl: make I2C and PCH options effective
      commit: feda4dd9ee1c21f58d947a82b52b8628d7faee28
-- 
Tom


