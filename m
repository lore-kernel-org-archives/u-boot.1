Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1057BC88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37951605DF;
	Mon, 14 Sep 2026 21:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_sWHmkTvbio; Mon, 14 Sep 2026 21:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 72E26605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789419890;
	b=VYMuGQJa+HnpiZSvR3yr44ZA6Um6GT8DXvOAi3gl5oo8kB+2QQAlJn9iRMS/ZgfzQZl9
	 0hVWcrNd4HLMoF8lIn36fQzTZKlpNeIwVi81XeSLhFXOawUoCQlgBjPYMCj8qf80hkXqv
	 afUd6j1x43LvmpDtEreDamjzetbrqabwR50m/t08MSoGYDKtp6D1t9jwAv21Tk8ToW0hO
	 KEZo/9Wwb67Ib0+cWBJAwjs7Q1HwbCQ7DeYijBR9WfGZjzIVraVQqoFm5WcmEYwupgTGn
	 vBlD0lLzbckd7rHPUpJ2KfCr2QATFQnCiY832PBtbHKn8ctiYtGWamw9q1AkaMveBRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789419890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YqHkWN8/0E27E0DvT5t8MmIw0h/t+PeWZ4Ci8rfyABo=;
	b=SFXFW2v6KIDbRInl6Qty5hNKYKz6QOjQz2wtE3gJQ80jmUPBxOo7QbNH7mWiU5O4fVCB
	 fBJSxY4MNHBiCgBhwzoLrXU6slWNkqzUeoJz5K9tPWrai/QzpU+V76HRGiLSO3Ilkw2N8
	 FQzcg0XbHU5KyKLkn8GIM4JyMi/mtpG2qv9QRnEPnfA17wMGMG/+O7iRmlmE+021DQXu6
	 cuNO9q/QM8P/DgXEZDjww6zMl9leP+FJboZs/EOs8xRuA6REkSSlISqzDZaLe8ksYzd8m
	 GpI1MCuPT2z2h/Nkn7MJbyRj4lGvYbeVO8Dzby4g8bDYBcjCCofgxSBzKyNgb3kzIXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ACr5UN8O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789419890;
	bh=YqHkWN8/0E27E0DvT5t8MmIw0h/t+PeWZ4Ci8rfyABo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ILtp73cApcbM8ZhDBnbw/dFrN2SE+OeYHuJVpHC3s/HMRiOEY/tUOw/D9qbbK9F3c
	 LYMu/xoRgpIY39LJH46RTmv/UEkL/ACei9CQ0+wSRC7ZSH56BYTM5j++k46PPBd2CT
	 ifF9FIKnLrlKDh+VS1ASuPhzZKT3yMrwxSPkh+gekfP9nROzXH8LV1TYfghwOjdEEM
	 opxztFEOhGoNrDwVF3IcwQKMbq2z6osIycQnX3/z7d1sKphf3qJ+6W9rxUl6FwU6qF
	 2Tp01eekj7yo9/cO+yIos8L9h0Cjkmo8oNaO7vELnsGCVeqTiYXWHh86PkOlRYsSeC
	 TedLlMvFtmkRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72E26605FC;
	Mon, 14 Sep 2026 21:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6686A259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 576A3605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuWDfAwgGP8d for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 21:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 984AA605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::14"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789419887;
 b=qiNhKk7LvCmRxYNxvWOgCZqcOb7tFF/aauenwWKtsUvMS7wwbuNEGHkzm/mT/MVPaFMC
 zBkCC7ArCWVfccBTgMZa3mqgNKLkBdqeIpnISzkxqkL7Wo1cujsQ3342edGFjgaxPw0zq
 6ZKGByzD4eFf4stDTu1YFRvtcKIvLtpKJ4260kes2UTwEFCLzOPO3S1lCzY8+45C9FHBa
 6D0CU92XjvsOFB5Exald26E5twB+Sgpi6ghXEmN1il80Npt4kBVMXxjIoTkmYYCVHJ7Qj
 4Q6MoISLNumVHOUqW2LnuWJGYUfWNxfDDRuHcT27/bP+9qpDvG/IUuAsNAq5SbhQsoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789419887;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=YqHkWN8/0E27E0DvT5t8MmIw0h/t+PeWZ4Ci8rfyABo=;
 b=AXUuwyw+ruS/bIJmClG/LmtVuGVxr9UiA2m5WJyQPhJ4rRTFnxKBIdrWI7VUvh5YUh4L
 JpSSqVUV0DrfvKt3bc/r3OEYDS7N82OLfk3gL/5jCIGoJfGCgRC9WhmCXPit8QlIUubEh
 NppAQNEkb55rkhZucw6ewcpg2CE40dSjDMqs9oofwEAzbeL1NkTswa2iQABtXCPeHR9zH
 yruUrn6mnxuucWtyugPb8ix5wpnqAdJzQiR3S5R9lKX4dWro22tbfmWplDTKAwpwjhIBr
 +CvU8KQN9EoxSu98nY3Rx/HxdF0mrklAMSgJTVM+uaoY7rZdKo4rqNSiFbzBQN4V9nQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ACr5UN8O; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::14"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::14; helo=mail-oo2-x14.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ACr5UN8O
Received: from mail-oo2-x14.google.com (mail-oo2-x14.google.com
 [IPv6:2607:f8b0:4864:31::14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 984AA605DF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:04:47 +0000 (UTC)
Received: by mail-oo2-x14.google.com with SMTP id
 46e09a7af769-805bf8c2661so1708788a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789419886; x=1790024686;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YqHkWN8/0E27E0DvT5t8MmIw0h/t+PeWZ4Ci8rfyABo=;
 b=ACr5UN8O7PgX+8W3zVOWUKePQI1NaxZc6S2BYNyfk1AcUbPkGTMcV8xT66VYxq2EEw
 crplyDhEagG5XB24b5+FwtJMKcu4PL5M+XOFWyPrKvYdxYl0w8g2oBE673YUJI1ruQBV
 +VSI+8GyKPda7V8CRP/y1Ru4gLVYCJlt3OTho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789419886; x=1790024686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YqHkWN8/0E27E0DvT5t8MmIw0h/t+PeWZ4Ci8rfyABo=;
 b=dhFxxLcr/zx/aYT7PrhNXQcuq/OKmNjW+6ljQVE4ZZa90oMMlk0lIx1yJ7QiE5gESm
 Gc8a57KM0HQFVBQ3d4vr1fjlA7cYNQC2PR8muSHcHvr3qw1IZJ18ji1DHigveQVp3e6g
 5tmnvJ90Ijeu6+HVORRiTWwZBzR0mJvAKCZQXLVt1U2ya8/KHnSCeNz+JG5ETr13BSNR
 Q63W+IPRLK2JgqPwQ4ciHfZF56eBlgqA9CxuY7QVKC12kHlncK+ljNKA4X+wddm5C5fs
 SkS1DvNnmUhM8YYJ+u3e+4QNEmp3Vh1uTMVNKMt01gqVT3tMqtKINGXRdtIxf/Bh4qTA
 s7ag==
X-Gm-Message-State: AFuF++ltA77ui5yre+IPKGnK9LjeRthcBaVRPz8s9V4+k9vp6K8k7c81
 IBdomQf4+TN+h2fauSqAsMbts6yIomE7yqYof9QUPYkcPnCRcxHJPiGoMvPAngzJoeZB7JwrFnd
 eZDYygBRieF2/
X-Gm-Gg: AYBFou1rILYHWGVT8G3mqbm+tJe6kw1dxg9C4Q4Jcix4im9scFUMRlMy7GvLn8NEmRo
 mQzsXbgUKpgDcmVozT5pja2NLjQ5Mhd8WiuBRzLUxmfB3GSkSjy9/nfoV6SowqDsSvyI7q7q6wI
 /q5SPG4VlNMWK7H1JFuZgWlefck+X8LFn+vayOKUS1RzIMoqPGRHPRa24XHYElTwzqItpJRyG8g
 6ZGh5KvJsZQxOL+wRRWOwxp/CXlmpsfQ04+YjqOZZoTdGtDls2GDIcAprDUSTV4ZKcdW3t8d/NI
 xS+vMKmCxTbm5clc6rS574qys1WRI1W8/EVCVCYQfDlmKfv0OIlcjmElUGZxprHy5ciaCwP4hSY
 4hdsxFtwTQqgDqGl8y7Ng1lkeyaSe1U9W0fM5HM8RaJFSgfItr7ctIFzyivnaPK9RgR4RJaC1Ch
 hZp5ANRK4JAQqkGMm55RqwL21gVctNEPEwuySUcB3nnR8WHktB0mxMo8CU9hHUHDE67njfKu+nD
 R3LCF20nFkxys38T9t0kJ/EuC9SBpHf+DCnp+jShZCT9v0Oa6x1P2VtWIqLCu6OWOJE3tLVYMLm
 NFE/grixdFlHHLsoWBToHt9EqXSvryjWjrGWfK/G3mlO
X-Received: by 2002:a05:6830:3892:b0:803:3878:bf59 with SMTP id
 46e09a7af769-80897f7cef9mr2939981a34.13.1789419886243; 
 Mon, 14 Sep 2026 14:04:46 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f670ec82sm12521160a34.20.2026.09.14.14.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:04:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] MAINTAINERS: Update some SoCFPGA related addresses
Date: Mon, 14 Sep 2026 15:04:44 -0600
Message-ID: <20260914210444.638315-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With Altera no longer being part of Intel, some of the email addresses
for the maintainers for these platforms had not been updated. Update
these to match more recent patches.

Reported-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Tien Fong,

Can you please audit the MAINTAINERS files? There's still a number of
other Intel addresses and it's unclear to me if those people still work
on these platforms or not and what their address is. Thanks!
---
 board/altera/stratix10-socdk/MAINTAINERS | 2 +-
 board/intel/agilex5-socdk/MAINTAINERS    | 4 ++--
 board/intel/n5x-socdk/MAINTAINERS        | 2 +-
 doc/git-mailrc                           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/altera/stratix10-socdk/MAINTAINERS b/board/altera/stratix10-socdk/MAINTAINERS
index 6efd0cfc0560..d1a040977c15 100644
--- a/board/altera/stratix10-socdk/MAINTAINERS
+++ b/board/altera/stratix10-socdk/MAINTAINERS
@@ -1,6 +1,6 @@
 SOCFPGA BOARD
 M:	Chin-Liang See <chin.liang.see@intel.com>
-M:	Dinh Nguyen <dinh.nguyen@intel.com>
+M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	board/altera/stratix10-socdk/
 F:	include/configs/socfpga_stratix10_socdk.h
diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
index 30d8815d2020..4a52891e015d 100644
--- a/board/intel/agilex5-socdk/MAINTAINERS
+++ b/board/intel/agilex5-socdk/MAINTAINERS
@@ -1,8 +1,8 @@
 SOCFPGA BOARD
-M:	Tien Fong Chee <tien.fong.chee@intel.com>
+M:	Tien Fong Chee <tien.fong.chee@altera.com>
 M:	Teik Heng Chong <teik.heng.chong@intel.com>
 M:	Jit Loon Lim <jit.loon.lim@intel.com>
-M:	Dinesh Maniyam <dinesh.maniyam@intel.com>
+M:	Dinesh Maniyam <dinesh.maniyam@altera.com>
 S:	Maintained
 F:	board/intel/agilex5-socdk/
 F:	include/configs/socfpga_agilex5_socdk.h
diff --git a/board/intel/n5x-socdk/MAINTAINERS b/board/intel/n5x-socdk/MAINTAINERS
index ca063a9f3f1d..15ba9de17e05 100644
--- a/board/intel/n5x-socdk/MAINTAINERS
+++ b/board/intel/n5x-socdk/MAINTAINERS
@@ -1,5 +1,5 @@
 SOCFPGA BOARD
-M:	Chee Tien Fong <tien.fong.chee@intel.com>
+M:	Tien Fong Chee <tien.fong.chee@altera.com>
 M:	Lim Siew Chin <elly.siew.chin.lim@intel.com>
 S:	Maintained
 F:	board/intel/n5x-socdk/
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 5a78376aa776..9ca01f59cf30 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -47,7 +47,7 @@ alias simongoldschmidt Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 alias sjg            Simon Glass <sjg@chromium.org>
 alias smcnutt        Scott McNutt <smcnutt@psyent.com>
 alias stroese        Stefan Roese <stefan.roese@mailbox.org>
-alias tienfong       Tien Fong Chee <tien.fong.chee@intel.com>
+alias tienfong       Tien Fong Chee <tien.fong.chee@altera.com>
 alias trini          Tom Rini <trini@konsulko.com>
 alias wd             Wolfgang Denk <wd@denx.de>
 alias priyankajain   Priyanka Jain <priyanka.jain@nxp.com>
-- 
2.43.0

