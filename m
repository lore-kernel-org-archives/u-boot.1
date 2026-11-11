Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608A606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c08UvBVx;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S2ExkUB0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AF1D813B8;
	Wed, 11 Nov 2026 13:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id clX4_tHVVR1o; Wed, 11 Nov 2026 13:14:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CE5081468
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402870;
	b=Pm0T1fUtkCiDIWj5vNWnlcjyXILNIPK0Jt6Q8GYHTbyc8BayiYn1UhKG1w1xtis7nIYn
	 l8ueNyj4ksjuvq63Ir9girnQDvsWZ6Nywxppp8+s7zt6tSs/3a8kL+kncc8pcXVMbI80r
	 cL4cC3p8tjZx37wIdQk0fyGpHIVYGgIVl6Wsvybtczk4DklMUhUus3ADIskS1VFMBhi37
	 efW3JhKGimXl2s3E27VwSWdMTiCkLgz2oQj+ko7yp/7vMJXFRPs8esqZBxRHNVUXsv+6P
	 AeB/mgDBpQQWLJPemrBD2zawDtZdxNJGPTT9MCgV3bZJX6KtcKR9+htTllksaAi+kdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZyCVcDKTYyC4IdORMY6G6WOISakdjGztljmnqCLp80I=;
	b=kriQr8pqGR5vxXBofuTQVlVu9OUPtsZw26HORRltTJpOFF0TiAWfeuKOshDfKVzVai3P
	 fSt4OE+KblbMM13zsIIj4hXP8ZGCum6uufXMaNtEG702DOVEOU+nLrBq34hi+SB2WQmi+
	 TKKuVMD8zCSzaHtsJJP3C4x0vtRKidSMc9L3793SQ653lSgpCs+Pr3qaiIS66pcmO7Ppx
	 YmTzqPZIpcSTRYluKlkkGoNxxWnnw4JbqNhqMemwEqjKwUPQtK6eP7jIvdngyPAbpC08a
	 AtrDerePlbMC5KYVUBMNddx5iXWmoNSjao6uBAGHA6MoyBrZBc7hfWgOYOxef/UmvVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402870;
	bh=ZyCVcDKTYyC4IdORMY6G6WOISakdjGztljmnqCLp80I=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c08UvBVx8wzGK/ICK3fBQX4ypP11/F8PqvjaRlCGbeNG/rAywDlTnV8h0QuvtP2A/
	 pym2Lb4XLfERB3U23e1hoxYGui7N5gnD9uewphMgcYrHz2llIieTOx/TIUKUgp1Ota
	 T3pxb++RQ3amWrM0DrZ8ZFguDEd8XSy03mjaucXW+y4It9SsiK/uaviwDU6j2zJi6o
	 GU3jwtU56bImOzrA7vv3pbiwDJuQByn37n3Kfo9XC5L8GxdNNyhe/diHxzAy7n0dR7
	 5ZI5hNiO2SihDD/zHaMavpCm2SxBMaNaDwTqd637Qo8MnAz9O2+G2gj0frwFLNPARA
	 28x+lLqy2JN6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CE5081468;
	Wed, 11 Nov 2026 13:14:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF2B2731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4A2A6071E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCZQy-q1oooL for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5E9860697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=S2ExkUB0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5E9860697
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:37 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b6e7a05225so3940094a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388415; x=1794993215;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZyCVcDKTYyC4IdORMY6G6WOISakdjGztljmnqCLp80I=;
 b=S2ExkUB0ETAK+tTDWBXIGCkl45iOs2SQWN0LSqsyLw0RVLRLMKiytSx5r3GnkgLY50
 JI9K6LqVhqw95BRAxx5hhjrD6Wcx8bKeoMrQzpmFoAsj4utR4rJxW1SU9oFcOlyMitIy
 iXurByOD7MPZ1qS7cx/9TC4NaFMmeh9gU2dRccxifBzNvQvOioQ9DMI/K3vfdfBvdk5w
 KyzLDTKQMq3j6w3zA8iRVkc/uqFF1kA4c3hfkmi3j6Xz6T/SvU/7YNJP1JUUBjKCz2w4
 fLWxUQiarBw3mdnzbMLK6CqNY7NcLF3L2tWFnY7LZgMeEOM9+PfwyIRcISK7nkTfKp5I
 jFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388415; x=1794993215;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZyCVcDKTYyC4IdORMY6G6WOISakdjGztljmnqCLp80I=;
 b=cJ/OrFOAxGj9i+vthJwLVxL4p65Vkd55wE312sqtMA4WV422ZXT3C/O6EadYA1grix
 doigW6o0R41pj0Cj6C+0ggQ/roYTEKcxYenEsiBssr0hiSQMTM4OY/sURtB8+ZoabQ7m
 sxgQib9bb1rAt7sp6Fq+Jd2peJzM4nUQ2fLHNeoGUxVnOuTUGiykSRlh5mP3YNH31gkq
 O16qnF1IpYvW82ltKkOGmtUylkhfH17BqXD2IlvqVDCv5wSnQ9cn4BANZmpV1aBRAi1W
 udK7c+nYlzNz2i5AYxrmHPm6n2h4RdAh/T3CrIDdKzSKR3Bp4HadEAuyORMSQ4UqEMTN
 ouqA==
X-Forwarded-Encrypted: i=1;
 AL+hErEkgZxB/NFYZZbf7WZpItIq+he/qLcT1fJ5JKTF+I3h1HTglHLstm3Esw999CaK+tiEwV/zRNE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/QqJGX0wNzTYXy/JAdCR3U/4TL7o5YLfd8DJapCJAiIhlfFY5U
 4/0Tr6BuRAhfdJucsx8YsxbgbHjtTYXC1mzclUeaBPZMkJD4PmXl79HDGvUUB5wV
X-Gm-Gg: AYBFou3KKUFWZucI7zWiULhq0GyvGfb8x71FafV2ab0r5068vf07EsxZy0HUpXQ2oke
 GN3/X5fD4TtK/0cgwJ5s0xVC8pUhbdaN3Ah5fgMTHFfZfuPSaEGL0iJ39sWuttHzgKqiY68ELCy
 AptSx/+D0a/xSkNr8KHtRDaf8CqyL0YVemIDgKPA/Aa00Lnpw7H9vGf/DGf7t0ayqH8OXaprMAQ
 76Jgo+FIJypqs8wdpzEuiv/Y+DYrrR6X+WCznVWKQef4Ty6evDeTrPF36EfyYSS5Ld23ARA0SCV
 jBMeP0aJNvMdgcvxuuLa3OVoXv2bjg6BehzZwZUnhzxghw9UrQy643seA1uqc2cTTuLE+yT1N2Y
 pyNiW9wsrJW8yXrGsSSQubhoA30qtFiOOTsTPQ8LAxwvZSDmCN9UwVXh9QPS7eCh8ewc/zSTS9I
 H6tNRHQgYiH/rWfHNtcAk7dfG0NYu9zdbchc5tpHfv0QZjamPzmML93VArEODdbBSH5tePMTnbr
 XtGSOEn9etarjWfZgdtwBVY7k0g17KcYtubq7+f1q+mlcVKybz2PBZrvJ5zRXMKpMeEYuhSkYFY
 250OgHqBzE6ysRBogwke3ZwILXQP/NszGY9MNfFitEbYygQv8+D/pi7qovki5JePrs1UppIKG9H
 D9Tbat+9RCnMsrAEZKGm+HzBSEmN8gPZzzE/a
X-Received: by 2002:a05:6402:e8b:b0:6ac:934e:a9ca with SMTP id
 4fb4d7f45d1cf-6b77708288dmr1270056a12.0.1794388415379; 
 Wed, 11 Nov 2026 01:13:35 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm2155257a12.33.2026.11.11.01.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:13:35 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH 0/3] bootstd: android: rollback indexes and misc system
 space messages
Date: Wed, 11 Nov 2026 10:13:31 +0100
Message-Id: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQqDMBBA0avIrBswsUTbq5QSYjKxQzWRmSoF8
 e4NXb7N/wcIMqHAvTmAcSehkiv0pYHw8nlCRbEaTGusbs2gtlU+jH5RPkcuFB2XeR59eLuFJLj
 xqvqkbRqSvXWdhdpZGRN9/4/H8zx/fL+a0HMAAAA=
X-Change-ID: 20261028-upstream-android_rollback_misc_b4-7f16f8f69336
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two things the Android bootmeth does not do yet.

Patch 1 stores the rollback indexes of a known-good slot. Without it the
stored indexes never advance and rollback protection has no effect.

Patches 2 and 3 handle the messages Android leaves for the bootloader in
the misc system space. Patch 2 syncs bootloader_message.h with
android-17.0.0_r1, and patch 3 applies the MTE and kcmdline messages to
the kernel command line.

---
Igor Opaniuk (3):
      bootstd: android: update the rollback indexes of a known-good slot
      android: sync bootloader_message.h with AOSP (misc system space)
      bootstd: android: act on the misc memtag and kcmdline messages

 MAINTAINERS                          |   2 +
 boot/Kconfig                         |  11 +++
 boot/Makefile                        |   2 +-
 boot/android_ab.c                    |  34 ++++++++
 boot/android_misc.c                  | 145 +++++++++++++++++++++++++++++++++++
 boot/bootmeth_android.c              | 132 +++++++++++++++++++++++++++++++
 common/avb_verify.c                  |  35 +++++++++
 include/android_ab.h                 |  19 +++++
 include/android_bootloader_message.h |  92 +++++++++++++++++++++-
 include/android_misc.h               |  56 ++++++++++++++
 include/avb_verify.h                 |  16 ++++
 11 files changed, 542 insertions(+), 2 deletions(-)
---
base-commit: 0e3fb22a5b2e330bd73014f0ced13f5df259d087
change-id: 20261028-upstream-android_rollback_misc_b4-7f16f8f69336

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@gmail.com>

