Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B02ACA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4B104136F;
	Sat,  3 Oct 2026 12:48:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlAd-uTioEBJ; Sat,  3 Oct 2026 12:48:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C763A41372
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031684;
	b=dBNUEAsRadQZlrvT/GJHRwzeujQrEEolnKZYaV8LEgAH2RqCUElZjr5BYJoon/RB029V
	 KRgxsqBIdDgoKa2QzXk0G9jOnMWXgg5l1yQwCufS8++/Vm3JsphK50yaOb23D6miST7+f
	 xvRS+9duAtISiCZQmRUg7izFTb2fCy6DIfgsziDL4P/+fga5kBLIDOxAvnifhpykOTM69
	 bItmhFW+nrs5ySvS4unYtcsu6nKK8d5btlVMyqQNQQKi7QRokNbU2WG6c6xWIrR0FuOvB
	 SQvznZF5C13lG+kDLJUrN2I9V5lPJnIOM9Oy++ARLrOPiI36/CM4Tcz9it4ZL0pJguA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031684;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ou98w8pMlDr++zoqRiKlIw2Ah88cryMe22Reft0Bk5U=;
	b=LuUti5hiq25+PdlF/pNBzuQ9uEt+LsVITee1VK2mBc0oxYYKPuSHCB0SOQC9Lw7GWqo8
	 8y7Nr+JksQIPwq55V5vc9qLdJAJJs2b9OVsbd1Vlr+rhy6CPlGDJ5NO3MvOeFWaNaQIx6
	 hr4Q7rGYRPsOrIR/GrXuxDzkycI2Fl8hF3VdHNBEkEaLT5u0z/ilRJC4cEKGQ5YRAOaqu
	 JUHiJ8RyWSnrCzBEfKAQmkGsfo8PDkySdIRKV+WkuGa10u1rtYFiw+342iTG4DEotqDv4
	 V9qTs9npkuZ3XkUMx2Yzp1MgqgdzOdx5rpNOc8QvYCw7A1NFFqdySt1qAlzKMectx1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031684;
	bh=ou98w8pMlDr++zoqRiKlIw2Ah88cryMe22Reft0Bk5U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JXX8Qg6/1qUAa80UPmdPFqnnG1lJbks67mrnEW/y4aOGYNG2v2L2kvg5htukLSM9i
	 qOxava3JZnhHlYtRCm8gzjkEqDcSrDVnf85yf61Qw4kmVG319l0OHQji0TjzFsMCjY
	 UuCdz4Jh+4ZK2ErOGq7REko5l1U6mknm58R7AIFTdqK/lOqvoCcuwq8OMMxVNHG0ee
	 oCmKXsdP3BNQoWxp6je/MzF5WJTH5MX54dVzAgNcKZoeb1YZs/oTdg5o5ZFfa9UFZf
	 551YNmJwJBEI7z3rP650HVdxMbHnB1nqBp1KEgBNcbPdl4Y9KDJkbiTa+cFRKB0YoL
	 XBdtBLBJK0n5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C763A41372;
	Sat,  3 Oct 2026 12:48:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 17772263
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F126481160
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CqETG9S3lki5 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 05:44:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2554D8115D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791006294;
 b=LPb+PBbr7bx1fMly3llTOKuvQzo3cQQ3ABzuYZsIi0I0cb8iLmw08eeEaLvVpaTIN42k
 broz6PDAIX2LwPsVcAvkr7XY24Uulo0D3SrX16qIIWpi4wrAx5nxBZZSIYqb5YJrINk4R
 gsn3Vjs6/ecDcKQFHUWZhq+WFawPkHz1Pc88/HqBqFiHE4pQdHXX07ZSM6BeVWrb7AbkI
 K3d2krlDvbM+TXNz+yuJeBH6fYCJsyO5T+MKdIdo3clg+YCMoJHEgUDudjLqN5RQ6W/82
 bYHTrboYx8aHEMUVuib3AFbtP+kkFB3ysuWo86Lw1l9I8ckSvuRVy+/YHhZRDOYkUsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791006294;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ou98w8pMlDr++zoqRiKlIw2Ah88cryMe22Reft0Bk5U=;
 b=j/QJriTfx9RaHA9m9XBCW/1uIofXrBKvrI3mreoJY3Wr1l5XTc+uijZ0AS01y/CvDhqX
 y5tACUQXpfm141RYPvE9Er+dPuPTIJGN2FRjk8v8dmJc6gtUi2NJTLALvGdCbkOTSBdyp
 8EydSB2w8Jtm7cPiAd2V92BmsNFgcRa/IAJcFV9dPTXjqvVbywTHJUlaMcsuGogLjhVER
 8jSFZ4eQIucTwLzhqfHzM7VY+4zCtDcqgKNl7iBQEl4O07l2eDjlulLFqBesZCwAF6fcc
 MnOaFpVmpVEfHW+a1QZVjQx0hpgp7ljNfI2BiJcg2yeMcKRNM8iVghFElmXvglzfLxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bbkxWQHW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com;
 envelope-from=bslettela@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bbkxWQHW
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com
 [IPv6:2607:f8b0:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2554D8115D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:44:52 +0000 (UTC)
Received: by mail-qv2-x10.google.com with SMTP id
 6a1803df08f44-91058dd77a2so6149086d6.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791006291; x=1791611091;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ou98w8pMlDr++zoqRiKlIw2Ah88cryMe22Reft0Bk5U=;
 b=bbkxWQHWOgz53IGmCpyw0YBRknfSd/YhLRv3Y65eQbDLuJvJZLz2781cTkrbyhayDJ
 Eqf0dFynaLtifHQeC0tklOOepXy7lUNc+DBhP5/pNy6en/AWGiU4lwatkPiNAeOHK6S/
 QKeGxwuVEl9ur9EpuDX7tgw+JKvGW/MGz0r0Bx8fUatTynVKYiywMS+ETEcPtQCOydvQ
 XQUItpw3xGPYWmR4JIYQ6C9MRvPbon7mMTqraFOpfSLkA2Lo7qX9qrSHOVVdGIHz+Cob
 CanT/UUCCQsOjPwaP13aW3VrrkInXMAFGnY9DX75Tl3ovfbwGwj3P5dbcCSMRstb3Xte
 YTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791006291; x=1791611091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ou98w8pMlDr++zoqRiKlIw2Ah88cryMe22Reft0Bk5U=;
 b=Dat++KdZzVE/9/JgcVlPum6Z5UiylinIytihozZJ6wJCa/AhSRcGK31J521TsUleiY
 6qepKXPtE3ujb+d6rIcW18oZYMiI90EHTj3E+4Z0NOvIzESVNS7Hxy3dORQ49w+x8wkQ
 bJLBzxK8s6DuRJoLpz9tbMra3mDUxdFaeNdEOq6mUs0W8Dkv75VQM7fNz1DdwR/X/dlH
 gAttYOx3joYhwdgc4UjHVbPNeOMKum+V/N+389DdfoiDmDBE4wedkhnpO9wwyXm+wqkp
 2ngzUxShFgWivvtxH5H9krIXjJUdKiDFbUpQldU5vbwJ2fqnlXQIGWprk5tKdXWz9ZeZ
 XUxg==
X-Gm-Message-State: AFq9FYI+gDT0Z9FcYYbwHl6/4rMPmzzPKwcGarZ1PE8PiImov6WBbyr/
 qkueKmj8ZAlhB/Y4EC1YwYTqZqhe9AErspZMMmsoo6Kp1YYpIhALxrixdvk1Krmj
X-Gm-Gg: AYBFou1/0OMpnWXirR+4NracBsyziNjliXTMLbBy8SVDSfINqbwDQZHfxkVJYnavKW/
 Ss0rDjrDAPJe2I6fVlL85Fdj9vMRmxXPrUHHYGMdbwPdlmsr4re2tcUHt7etwt58nEc1K8GmBX3
 dR7lC31E3nJHYP3W3Lgus/zjv5yu8yTzhem52JLGY7MZlvylEby+YaWhRbaN+nbxYz/1DGm0Uym
 z93A3STD328y2+guR3Us49jGjQsJxGbS2q5uUId9DqQXOxdu/v3pBCVIwUicLd/4qmX0SKwAgg5
 kI+eLGlz3zke0wiv19ekd/f9PhNwFqufDBXxwlBtjV3w3udzscvxikkk4ANbVNB0yq1Wy47+r9v
 ZCi0tHjowx29w5ugm1Bfca1XdkFyGm58ad5BQw0eJXkgKhdjEcKsK0hk9Ss6q1+Y/XfyOofnCDS
 mZ/xfYg+9nT6Ewp/IBZtCYPRfbQ62lbtrdAz0EurT9ljOYWEI81NYS0/7vLQxjvDEj5ivoBIL7h
 lOR0MkPWoY=
X-Received: by 2002:a05:6214:f25:b0:914:40ae:b6b0 with SMTP id
 6a1803df08f44-917c00fcfbcmr102797206d6.24.1791006290850; 
 Fri, 02 Oct 2026 22:44:50 -0700 (PDT)
Received: from localhost.localdomain ([64.112.20.205])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917d593b457sm37799146d6.4.2026.10.02.22.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 22:44:50 -0700 (PDT)
From: bslette <bslettela@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bslette <bslettela@gmail.com>, nm@ti.com, robertcnelson@gmail.com,
 trini@konsulko.com
Subject: [PATCH] configs: j721e_beagleboneai64_r5: enable K3_QOS
Date: Sat,  3 Oct 2026 00:44:18 -0500
Message-ID: <20261003054432.1027871-1-bslettela@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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

The J721E QoS table (arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c)
gives the DSS read channels order-ID 15, but CONFIG_K3_QOS defaults
to y only for AM62A, and unlike j721e_evm_r5_defconfig the BeagleBone
AI-64 R5 defconfig does not enable it. The DSS QoS registers are left
at 0, so the display competes with VPAC/C7x traffic at the same
priority and underflows under vision load.

Measured on a BeagleBone AI-64 (J721E SR2.0), Linux 6.18, live IMX219
-> VPAC ISP -> TIDL on C7x for 25 s with 1080p DP output active:
without this change tidss reports 40-41 "SYNC LOST / underflow"
events per run (3 runs); with it all 24 DSS QoS registers are
programmed by R5 SPL and there are none (2 runs).

Signed-off-by: bslette <bslettela@gmail.com>
---
 configs/j721e_beagleboneai64_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index d45f610d1..ef08fb374 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x70000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SOC_K3_J721E=y
+CONFIG_K3_QOS=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J721E_R5_BEAGLEBONEAI64=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-- 
2.47.3

