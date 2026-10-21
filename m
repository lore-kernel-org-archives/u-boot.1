Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8700606A32F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RarekGsD;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=s4kP5Yh+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF1B540776;
	Wed, 21 Oct 2026 17:11:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXOudDb5DZxh; Wed, 21 Oct 2026 17:11:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A6DB4074E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792602673;
	b=C6+5sYgOKDLzg0m/SuDS1jRdWBYEiMNooBSOD/xnEkyUd6o1QohxUH2PATOefgpqyz/v
	 Y4PGUFvdHO0lIBbw0KkI5odSH1yNT+I+GV559YUBGLqnYunXv2Uo3kw+UDMX5xpxxGMFV
	 42h2Zy1r8FvqmSvp32pRlctCHjSNsLQcaImPjfyKYZ50tmtycSqggUaTBhVyZG0QsVocg
	 tcupVuJAZPd8bssjmeVYI7XgWAabxsNHk2GZzKSplGxnoeOvwearesaz7Xpic2LLCAdZ/
	 pe20pePRwL+Sj9PmizIxyuI3EWJca5AEonMh7SU2VbyFwcLLBgqwGQexuDllFqqT/hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792602673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bExHnbP1OMScXzYOiM6k5AeC3Qae9vrvtWAqYzetlk8=;
	b=RcfWA59o/5zEvGiw2GKl1qvVngPnWacZkBsYpUlSN6dZvq+XRaR6TgLzv9FckqYSpD5Z
	 /60LP5l7EOlkAGltYKOJK1Xyl6bk5Q+qcpLyut/ApqkqHJnwWFymM9ZSFxVhvUOnehGgh
	 o8s4NIO9nK8L/F5Xh1dIoY6GWJj8Z6dMuwd6nfzYONP0edgOMuUZYhpxBHdGDMMouPqOa
	 qCHhR5eMsiboqjIsa8/rP/ien3YhWRZuDZNyVCJRhfrp22tULC1EU+3ihm8Dv07NR4sPR
	 Ljvy4oaubtqe35ZbYG53hmgrd59T6phhZjsYtxwwD+tjtAa3z4bQ8gd+WHgKq6SA4GQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792602673;
	bh=bExHnbP1OMScXzYOiM6k5AeC3Qae9vrvtWAqYzetlk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RarekGsDHK4rN/tzy1rf9tsRP2bIcnKSkI0H3DbAmDtK2c2HQlsFL06mHYoauKZXG
	 cMFhqEdxo5/S2WYdZII/atBQOiOBm8p/+gDuhTNqjyp5D8QzxIX/S2gF3+yFpzqqJk
	 44wjQ36fyxaFzz5psGKqRC3Lf/7cRfa2+/TgwQ5F/oGaiPwued1L1UQ1Fhlm4dRZBv
	 saLxBSikx9qY+T8udQ1yvKkTCkXQnm4pwPstSyH0NMugYplJ1VVlGW+eh25xx6CS6F
	 /v9d8pcaGYaTZziTgkvKu7oj3x9mat7QyyfLrcVfFGoSOJu4OOxXVCgOxgSjH2rB+T
	 qvwYHDiybsSiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A6DB4074E;
	Wed, 21 Oct 2026 17:11:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACB96930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92AE3403C2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xdD6L1r2krcJ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:11:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CA4E84016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792602665;
 b=dmst4i8b6Z1Xc9RTm73ZL75G2DN0ItqGZx3yH54fOn5d60fmJd2NY0yPl7OcZ/uSJYzF
 gxJEjrZnBmwIYs4YQ9p7QEsjCXsPCzDUtsuCSMbK3ukaVPQwmYH2TaC1MezIchWUbKVMV
 pSwTnipq/Ia+x2EE4Iqrx1V2wfsU1VG+rSCEgudjJOMoPZVr7qniM4QACWJs9ZmNPLR21
 +oPPM8tmMoxDr3dxLUIyeDZKYHROpF0zDFyV2FKViR6Rj80BD5NZhafFl1lrm04gpU4IQ
 PqCE3Q+HDa0WcqVnhIwdhezYIMTjubLJ8G8gnbUfBuN+Ad6TD9R5/qQEGKKeo9VFyaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792602665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=bExHnbP1OMScXzYOiM6k5AeC3Qae9vrvtWAqYzetlk8=;
 b=OkCxfFV+rAPmfe80EkmYqlFONQUe9d8YA27tkyHCPCkGDHOzsJKNPHK4LisDnGJFlmza
 Rrt4aUSeJIhB2klTFDdTmKO9/sz8ttxS5Fqbr6/Wgl6VxAN/oqv7mpIPgKHv+Nfcq4Z/J
 qmBkSjhQ0eTtX1XN3NKmgSPzqkXaGYqojX4YnQTs1EMCbsl0V9FQDn6h+YcwPKKYzYFha
 ZgSegCi78wZ4hpFkr+VbpIdsmwTGcX8ni5fuuInSAVVoi5oUlK6H6EEZ96Ux7hGi+Ih/f
 2/1x3n1dNgMSk/VMVFl5084S5Abqh+NxgTydX1IwOfJFaMjqmSUP2Z9Vhu0K4ie2QNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=s4kP5Yh+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=s4kP5Yh+
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA4E84016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:11:04 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-703be215729so400846eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792602663; x=1793207463;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bExHnbP1OMScXzYOiM6k5AeC3Qae9vrvtWAqYzetlk8=;
 b=s4kP5Yh+n7PXuzIVW2N5yBrr2grKD5IShFMQNiAtBZA8ztKfOkPkrJWSpQN845xIPF
 7fbP4A2dQG7Dt8AA7EsyS7gBSfL+/saATlbx2v5Hew5RZ5hO+UilKxPRBQ2tSgND+YWp
 v5PDOAMPKHDFldBsjF8fEr5+jMSyjJmR5dcN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792602663; x=1793207463;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bExHnbP1OMScXzYOiM6k5AeC3Qae9vrvtWAqYzetlk8=;
 b=CBPAr8UtCaVfdzaMXka5sQ9I6lPWpBcgGmpavP1no79+tcS7dD1rqqC7lWiQ59p3SY
 RfSCYJGGosQ2YW7J8hZawK1bWB14osJ0mGf73jCLZOeg6zBPc25fb69nHtMfO9NMRyQ3
 vjsdf1UrPk+W/Q3D734zt5dfzpfEmea4Wly4Im9IkKVsfZ7UZMH5IL4giRYQzF+Pwabq
 EUqEgqhJtQ0Cw/Fvbap295Ckn70hk0f486rKtH66NllbtPuOWN9T0AP81a+A0pC/TdNU
 mVRnyThNQHsLhUGvx90EluwEGkve3HQeMKM76NFi74gYVI8elpenpjmwqetXJ8BBS3i0
 uByg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOKKpCVVTzdWE56xiVX9eZRvP6FFcf8dYn59c2lb/c7tECLIR6k3NslgRiijFenNzsHzXGelo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKpqUEcbiyFDHe1wzTseiIToLYHyKsaDiKB3+F4RjTNLBm44Ox/
 0rokKlDGlchSx+We36bO2Jo0n8WCd74wFX3VTjNGnSSBkfyw0nneSHWCaX0TATMTktc=
X-Gm-Gg: AYBFou1kBjuWAbF26M/ddYkbL6ADMHp4VJP4pjr22vBqfMutBEccwGlWhucupwU8BaQ
 nPV1xS+UEbWdbaHuXpznXQc04Nae0zfz4iQa9jN84vO6CKe+GTdGJAscfIpN+VEJDsNxvNQaH2z
 yBCtHoEQDM3rVTCpKDIbv/F8jM4tSfF33HR2b0yWEg+JkPok2LHsDRaJXSicy8BU9k5sXOctE3A
 vzfKs+Qwn+tUWDmvEVEtxrfXB6JctyrU1dWoTGcyY2CVaPMd/hFG2rR6pkRJNm2kHzTq6JraAz7
 9ZHs8klBW8npoMPWSHBdA9qIMVOPYNoo/nqvrugFSNYZYosW4ce5EGohprTD/G2DLT3Hs+y5HYz
 FU03t0YMCWhJwG+Isu5QZPArGURnTfWZZdeHYmPo+UuUWZIEBqQlUPzg2QyxqAa/EFnujlvS769
 AxsokzpMzZCo95QMw8vSj5o3lNXyvbG6pkYq/I9sXh7gIkzBQrsFhhds26c4f9eCfKRwWSj3hbt
 wg3phWju4/QdIqawyXX7u7zmxm65QT/i5tsj3+MpEUu2j83x7vz9vQX82ghR8kmwgofp3muCny2
 gkSUlnK8iu8Y6DFq+s7AUlIj+OnhCr/+Nk2wiCvv5y+tUbpxPtq79MLUEyRWVCvH8wK1ophzfVM
 =
X-Received: by 2002:a05:6820:1986:b0:6f8:a519:d930 with SMTP id
 006d021491bc7-70941830645mr1650218eaf.34.1792602663308; 
 Wed, 21 Oct 2026 10:11:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbc7d9b1asm2683971a34.8.2026.10.21.10.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:11:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, kabel@kernel.org, 
 lucas.liu@siengine.com, u-boot@lists.u-boot-project.org
In-Reply-To: <atiMW0B30H2AmHtS@nxa18884-linux-1.ap.freescale.net>
References: <atiMW0B30H2AmHtS@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-for-2027-01-rc1
Message-Id: <179260266243.3262409.7498512334520337100.b4-ty@konsulko.com>
Date: Wed, 21 Oct 2026 11:11:02 -0600
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

On Wed, 21 Oct 2026 17:56:43 +0800, Peng Fan wrote:

> Please pull mmc-for-2027-01-rc1
> 
> ------------------------------------------------------
> Print eMMC health in cmd/mmc
> Not time out a command that has completed in sdhci
> Apply power-off-delay-us outside regulator support
> Add missing MMC_HS400_ES_SUPPORT to mmc_set_card_speed
> ------------------------------------------------------
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


