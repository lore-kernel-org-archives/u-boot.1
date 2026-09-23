Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2417C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 17:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6813F608A3;
	Wed, 23 Sep 2026 17:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJdPHu2xt6hl; Wed, 23 Sep 2026 17:03:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C4BE9605E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790183023;
	b=skclalVUL8ng1ZbGHn6tnx+TL9Ay46w3jJNUhsH9iMmf0b9FxxwybGHHDBpscpvuE7Mt
	 fFlKWm2IbP3r9ME8WrzzGfZePzydxhg2yBwNyD+ThUUUsieDXHbHYtb3sa2ywKa0V+UeY
	 EkF7ny/3Nze4zTJSKNHgLx+iEQamHulSuix26MPgmPb18nsXngyTG8xNDVlItL9dU+Clx
	 PsQDF38jJRRe74wvAK8EMrKBpGjS6ebreYiA57qCrCmZdHyk9o5OOkJAPQlyeeb1ygQ9A
	 k2Hq4B9BZHdMleP01uXUdoFZtfYVVvgEblKY1lV3v28EeHrdgJDP8mztx6R/sBfZb2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790183023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DRjLr1R3PPp/oUCdnzHkH+9/rUWGsle/KkXyc5BRBSc=;
	b=fpUUnhGnP5P7YM22U5bb9f0gTVyeVoDt0W/uzLARkNplVw2GWO3981GqiP+FeHJS/hUZ
	 kmOJMreOQWWHSFryU0nM51mO+heCSYi7YGBCEHpBszxlQGIKCZt4nwQvrHGbESac0YRxy
	 rufBoGKfRtGybmscOqwUHiySrNqQZBomqU+tWqH0T1OdVYMAuvP0VINPXWAAW0RTF/YHT
	 Y1Re9w4LCzZhVKT7Z+wbzEs18LR9KALm65iETNg1wZRdaSm1ysdma9z9Dn0zpAtXX+zvj
	 EcxD4hGFUUUnIhP+oqg9vvfvWRweq/AySc7MVE1t/k8xGKlq+1+1h1C17J7KmrckomQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790183023;
	bh=DRjLr1R3PPp/oUCdnzHkH+9/rUWGsle/KkXyc5BRBSc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ieL8tkJsOt03hk9mIncYPBjwSZfGT5byAuDqqU3WhyE83+g4gamm673Chr8Biojxy
	 MzpYYvMyqATiwqLWkueNpOQV6oOQ9lBYNSghIfTOGrwpRmM35UFeKjYXoNELRSoXn2
	 hCUenx8oo7uEZNH9prFG+svLhRi1HjjiIVJIreJv5GSIhUhIUCNNqOu1SJV+Rdu/kR
	 Tx4o9hqSrQkiGGUe9ch1xLbFBteMNZ7AhBfccfAor1zCrCHLwmxr9N+FXWZ2wrXemS
	 mevrLT8pa7zcctlKTR/94/CnOr3kAI/MXpTqhKPe3UKptyT3iDOqU47Uv2xAtI6TuM
	 gOLavE0IJc1LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4BE9605E3;
	Wed, 23 Sep 2026 17:03:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5135A32F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4323840348
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cd9JueyTdk-i for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 15:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DFF8E40282
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790178413;
 b=hw+WKgpnLm3GfoxsCdbFOdy7y9BfLGNcJFEJBA7HsunKsJK0xyM2mK7nJ2DQCRqTTTAD
 zJH9hwHx5G2tQSQKxfE/qnQYqIQHJy8bfBQ3i9UxWflG5uFML/X1JGPmkf4IoT7QxLBw2
 RbWQUfMMNM8P41ZeYj9NS1e44hXFxrafwotCUSxCMDa4Al4zPqYrKQtw3MTq3iet7mCqI
 0j/L1vF22IF3rBC8+5YtjwcMpaM90y8CS2Vu5o4wN+JlvvfYYJd/DCyhqDKxQtPonhGHg
 Qfqo0ZNYFdFaAFltYBxsDteBAc1KAr7Otqy4zz1QUJTRKYJb4764pURLhX5+y8rJ0aA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790178413;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=DRjLr1R3PPp/oUCdnzHkH+9/rUWGsle/KkXyc5BRBSc=;
 b=sex2igT0iaoow9c+dGsKodj6fHHd4yA/fS/heIo0MdYi6XwwSOdu2fIuOeTWqk6yhLqX
 cq49uSQayXLmyObxzlUJcvNim8g7TXBdcmPYJiE5V9yoXtr9ZwVfLIeytjB/uhRewco8G
 AoGnRxk6QyVL3zf4DzzL2U1/ABkJ5Qht9Pbxdco94xOtCbGk9fK7XOFlDdHKB7ZWtofrS
 QVwL7Oe72oAVfes/dwEvZCEyZDnLbJTW6AOX2dJxcx4L2HB5r7h+NQe26/wuSjcgQyzAA
 /9VEQo6cZSGIOKYRkknG1eY08SxWljz5R+t+CyxzUyU6knwim9v/bnkT3A1hgsu0nIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Zyn3zzou; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Zyn3zzou
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFF8E40282
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:52 +0000 (UTC)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E8AA3F57F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790178410;
 bh=DRjLr1R3PPp/oUCdnzHkH+9/rUWGsle/KkXyc5BRBSc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Zyn3zzouc5OHe3LsMtWbPCBfObmS4179sn1Tm+WLzap+WuNEp0zEBN3l76kgSXoRW
 wAETmzEXmDV1AicMW4Gp/ziXd3XPO5Gx3jEhGzsuEmgrnOvmTYbCqeYwcKZ5iu/kPG
 NXIVYDD5aZop163cKMU8v5TH2d2AWXjbg2lsqw77VJdvAxdUxtKWE+fq9+i4KCwobq
 fLOnmYDg9zo39uKNTGI3WyRCuHSzqpzML6nmTe283RruPdg5ZegQudGlSy3xg1EfyX
 ntNSDFcbSVdeDh9Gxcrdlv6ipiGbdLK7y1Q6AqwFWbv4Wm7nhGim3Lh9+E29KFZMkw
 LDiIBcLwo8KtCfJhozQE4Xetbxv0A3LudGZpDM1+z5nu13iNVksDHKdtwrCGttjjim
 JdVRIP868dsByxC03Ck7huzQVgRH36gXOd3aru7TqJCFYGFCbWuwRW0Q4XeifEYIIB
 AFEvpH+y0MbqHxi0mtJpN1319omigasYR3eHg18mvW9X/X+OrS4bjrzMfZOkjh67Bk
 R1gts0C/zoMgSCC5yG0Nj41VVjGMw76/AfuA9fDe8JSTJVk4wqcXpcuFsSbvj0jq9E
 yrDqEpRdIum4JLbDTHL6Yb8giSo+/RgCaZjVU7rfqZJLQMDVgmf/Pqbe1bpdM77oOF
 F6OeW4hgKcSBjgliJ4cfDYdQ=
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6c2c5c1f843so1302282eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178409; x=1790783209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DRjLr1R3PPp/oUCdnzHkH+9/rUWGsle/KkXyc5BRBSc=;
 b=iMxhRGkDzAZOB/OpVAuCbvYHt/v/RVAfpsmdXV4PUqHUKJxD5+fmGBs8tYcQDdnrqD
 J8AtgRLdJ7rxiElSaSfTZ1zuTTzJJGp/oNZWg49Z26qT2yY0BbcBN5qyWf4r7ValV9n4
 bzw/m9zgKWqdxUSRpMAzeIqC9Tbv45dVQC0+uL7O3VIrfCuZE0//BHEHpz6mfI+U8NR6
 R8isyZGn2xn9LXe5tNXZGCGZZ4vkK/f2XuXSJdxz52+enGjiV8dQhStpTxo8c8iFhfNN
 Fbly9AcPmGvOjlMSrXNYS3vZht7xYVjVyCRj/FcBHANQWbFGPgbyZ2KI7YkS9pKbyj6f
 7PzA==
X-Gm-Message-State: AFuF++nQ23XTyw3UgoKNjX49BEihlbT76QNuhdPpbWJ9hINzy4y3Ay4b
 0GFLaFkPJysLBIU9Fjng9GUZVLsFuxiwDBgba6S2N4D+1WzQuIgREdjvT0Z9D7DC9eUPHTtFqQh
 FJPwvo/0axf/lnx0JZ/04aLgWuu6yo5tuLyB9yoK9zzeSU2PuQ4RdV351ebfXEH9J7u+zer9yOc
 D8RC0aeLyd4//JzEzV/g==
X-Gm-Gg: AYBFou0lATVv+qchviN2zi6qMPCfDRD7dDXBdwhacE/TJGFb/Hgmddhei6kBvfJbGr6
 lGkzY0VPak9TaYv8Te2o9x758oe6Sl0momTcXb/VvTKvv+zz/gqzMriqPKF0PVa0mEPcNvJa/dZ
 SHcxhYHs8AAVhnGQW6wL+bKlX9ysnX5UbUZau2LoxOakKnLB0FZe52noGPllCDXvbGni5izy+GJ
 23Qmk/GrCQ3eMWiyW5cKu1Q8DFH5aLv1mEcl9oClJok9JKNDWTDdNuP9UncBzisHR7R+ywV69GX
 W9X6Fej9w9QeCJhAx24dXczOkayx+a4nE44jFN5Btb3JCuxuoSq0MphBo7CPAFIMjGEKrJGXfsY
 IUDipmHu+A8x7G5wiWDTi0R88I/flArHr1zFGWZq6MEDS2+16gcCR8hYz5lyf+ovVhNpy8IcL65
 DNVw==
X-Received: by 2002:a05:6820:1907:b0:6b9:1d72:e29d with SMTP id
 006d021491bc7-6d15a4577c3mr4544085eaf.21.1790178409082; 
 Wed, 23 Sep 2026 08:46:49 -0700 (PDT)
X-Received: by 2002:a05:6820:1907:b0:6b9:1d72:e29d with SMTP id
 006d021491bc7-6d15a4577c3mr4544068eaf.21.1790178408613; 
 Wed, 23 Sep 2026 08:46:48 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4908e665df5sm2103963fac.10.2026.09.23.08.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:46:48 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/3] fit: use constants for property names in mkimage,
 boot and SPL
Date: Wed, 23 Sep 2026 15:45:10 +0000
Message-ID: <20260923154610.339153-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 17:03:42 +0000
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

include/image.h defines constants for the FIT property and node names,
and most of the FIT code uses them, but mkimage, boot/ and the SPL FIT
loader still spell a few of the names out as string literals. This
series converts the remaining ones in those three areas, one patch
each.

Most of the changes swap a literal for the matching constant. Two need
a word of explanation. fdt_property_file() in mkimage already takes the
property name as an argument but ignores it and hardcodes "data", so
patch 1 uses the argument; every caller passes FIT_DATA_PROP.
FIT_COMPAT_PROP was added for the compatible property of configuration
nodes by commit 3059eb0c27dd ("boot/fit: declare (and use) new constant
for conf's compatible prop"), which noted that the same property can
appear in FPGA image nodes but did not convert those. Patches 2 and 3
use FIT_COMPAT_PROP for the FPGA image node as well, in U-Boot proper
and in SPL.

No functional change is intended. Built for sandbox, sandbox_spl and
dra7xx_evm (U-Boot proper, SPL and host tools), the objects of all
touched files are identical before and after the series once debug
info is stripped and the embedded version string is held fixed. The
only exception is four __LINE__ values in boot/image-fit.c log calls,
which move down by one where patch 2 wraps a line. Each patch builds
for those three boards, and the sandbox FIT, vboot, mkimage and
dm-verity pytests pass.

The series is based on next, where the dm-verity code touched by patch
2 lives.

Aristo Chen (3):
  tools: mkimage: use constants for FIT property names
  boot: fit: use constants for FIT property names
  spl: fit: use constants for FIT property names

 boot/boot_fit.c      |  4 ++--
 boot/image-board.c   |  3 ++-
 boot/image-fit.c     |  3 ++-
 common/spl/spl_fit.c | 12 ++++++------
 tools/fit_image.c    |  2 +-
 tools/image-host.c   |  3 ++-
 6 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.43.0

