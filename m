Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60BEC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 692E080EC2;
	Wed,  2 Sep 2026 14:12:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjkkEPi_W561; Wed,  2 Sep 2026 14:12:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358340;
	bh=qG0F2S33heLxFZpLDVmBSKhMc6whncWEbYq1J5uqRXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VH1/57FBuBuFZtpsyY2zzg9wTtAFnktYZg91dugtgdyGXQUQcwcQuqvxutCM+Pdkq
	 m0GNBgAo04POt5aa9dacXH0JPHujGuctlV7PO6aHmKtdF0lKj+ZjGrYWcaLL3MYM6x
	 QrtBNanGGi5hwdMdw9QJ7utZRWznQ+VJQIWidQxM6U19MjsV8gRuNqKqoQJDtY5fAj
	 P7FTJvCiDXiqxi9xR+HSDNnTBgBZR/PXlTzyu5upZcT15WL3LAxF0N1FlkIYUx/3v0
	 ddljV1iDnXJYLPJp0OfRgUpy+HCnaVj5EVuXddXrUUH4Iq3bSmfpe3CzfIS2z761Ce
	 iDWwNk8FGd3EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F47F80EDB;
	Wed,  2 Sep 2026 14:12:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 650EA2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 571FE4083E
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qdd1EQ-HxN-m for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:12:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::;
 helo=mail-oi2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nRql0Qe5
Received: from mail-oi2-x00.google.com (mail-oi2-x00.google.com
 [IPv6:2607:f8b0:4864:32::])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59F2D40839
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:12:16 +0000 (UTC)
Received: by mail-oi2-x00.google.com with SMTP id
 5614622812f47-495d5d27acfso309032b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788358336; x=1788963136;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qG0F2S33heLxFZpLDVmBSKhMc6whncWEbYq1J5uqRXE=;
 b=nRql0Qe5ND61eu0HjIPTewp6j74V7joeynG/dQKejyZH7Uujj/odpSkcOX7beVvUY8
 fvKMgcXx2jYIwFgtdfwlmJn2E5dlA+0pnjtfxmTInAB7UPRBMQGR1I2XND7VV7uPraW+
 nsusVyLCiDj+erks8YEFwk4nKaNRTSwH5j8E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358336; x=1788963136;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qG0F2S33heLxFZpLDVmBSKhMc6whncWEbYq1J5uqRXE=;
 b=LOe/QDFFfc1ngGjHaRdrcTKvEK8ZznH9hFOMI86gehNqn9wfI9LqJvBMFwFnxWb35h
 JVgwrO7JLiuwyoRNexPg4iOH31MeGN0b6ODu+ppl6h73ArbtO0L7s0mnemttFOiq5Zoo
 5G5CisUZM4rEnpomTG3rhYYiQ3xBCgdB20svNF2xkC8uxVBlJWXyoMCzZAhNxAWMH6Sz
 zE+X2bjrVXZeCPjI72EkFqsqdH/tMjFSoPV3EqsPD//UwlvG5rAVE/wzE2OZdl3Lj6q6
 shmmDkKm+lrVXju5bzfyJIeXo3wCbiNY7HOR83xbHWkhemEaZkKCySWw1iiUD1haWwJZ
 qJDw==
X-Gm-Message-State: AFuF++kzX+cf1Jaz3lMlL28mlg6fSknFbRESByxz8kx6Oi4xvIkFjrFU
 czPbgTVJB/BylJxN35Ec4hX9FbX5EgO/RjHw8HuK5hzV6Eaikp5ZDs1ZGcJlgN3dkco=
X-Gm-Gg: AR+sD11tu+731RanHb0Z/cqcMxpzaCmls9N4SmZvwqzlzJjHR+qliyFrvdpMFArlysO
 SsUcA4VnPhttg/WnXb7eZKEbfdEnslT+HzawKLRtIVavLp+QAFUlZVzK8p/p4MFjWG/VZ0M2OsZ
 qX+T8LkUbrfz329/yuKQwyatJgYN3RnGRI72SMFVH6rzTt972OytM12idr8bjGM4/1MckhICsAj
 f019GkMzvbn92UoCSyubkDHZghB+VCKRG8Urq/DOrQOslxES05SKOdhWmLMX0xILOtPxDqFrCA0
 cVxaxlkpp0dlP3i8Yr/NCCYAIO6SHdSMllUY2oj6VS+OiV1tIZwqIW5nE1h6T8QxK0JdHUq/5Ea
 yyIMzIhUxINgjSZA2zFPo+kxPzBxGhbcGQp5/kKUCXkxZEe5vf8cF3TzZ429gJsyWbQGixD00np
 gOD9k74zLd/XRLxKukzHYWBUPsTTL3l0bER9NrgQGsBeFk6JKOotWBMND8IuPnwPu9djKqw+SDH
 1/sPKfjkslQkYhAvdbW4M1Ha5WeMpczaK79J3MCBOIzcKft1UnzpDrxFBluaSk/DTWB/sI1DQTC
 ieKQED01
X-Received: by 2002:a05:6808:1527:b0:496:b7c:9445 with SMTP id
 5614622812f47-4b6be202f30mr4435849b6e.12.1788358335820; 
 Wed, 02 Sep 2026 07:12:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b69851ea2asm2100494b6e.2.2026.09.02.07.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:12:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com
In-Reply-To: <20260818132332.324173-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260818132332.324173-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/8] bootm: size the noload buffer from the
 compressor header
Message-Id: <178835833505.1743075.7585508478991824461.b4-ty@konsulko.com>
Date: Wed, 02 Sep 2026 08:12:15 -0600
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

On Tue, 18 Aug 2026 13:23:14 +0000, Aristo Chen wrote:

> This is v2 of "bootm: size the noload decompression buffer from the
> compressor header". Tom pushed back on v1
> (https://patchwork.ozlabs.org/project/uboot/patch/20260809042338.63397-2-aristo.chen@canonical.com/)
> on two grounds:
> 
>   1. No concrete problem report driving the change.
>   2. ~1297 platforms grew by ~170-400 bytes; the change is not
>      opt-in, so the size cost falls on everyone.
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] bootm: size the noload gzip decompression buffer from ISIZE
      commit: cf63a0c411b959b88902f9f90d809c4adac70385
[2/8] test: fit: cover the kernel_noload gzip header-size and lying-header paths
      commit: 1d0998998c2d61e41fa91b606934e0efbdf662d0
[3/8] bootm: size the noload zstd decompression buffer from Frame_Content_Size
      commit: 894eff92ecf060ec7363b9be41958e49ea120cab
[4/8] test: fit: cover the kernel_noload zstd header-size path
      commit: 6b88aee1dd076e2e2091b47ac2fb9fc5f31a3353
[5/8] bootm: size the noload lz4 decompression buffer from Content_Size
      commit: a85d598be2a3f36f4dd5f0884e4b41fa40d75710
[6/8] test: fit: cover the kernel_noload lz4 header-size path
      commit: 7d7770dbfce002969327071eab2dd30315d0cec6
[7/8] bootm: size the noload lzma decompression buffer from the header
      commit: a730ba7f8996468e04250ce182a8bceaf30cb78c
[8/8] test: fit: cover the kernel_noload lzma header-size and unknown-size paths
      commit: 6bd934a1f5e9f37579af123d49114aee35607449
-- 
Tom


