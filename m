Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VsQdSEJi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f4aU2KgN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D37A9406AE;
	Sat, 24 Oct 2026 22:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxzbDQsllHZj; Sat, 24 Oct 2026 22:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E73CC40698
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881342;
	b=gLOL4AdJaqFQA7aw6kQ8p4bErsuCkowcN19v0mhzsbJAIKHXl0HH3kVWvuN4rc+gZpHw
	 4VFOPkHpmzU9hRkpmgBc3qxJC29EkFClxayv9Icf8IBnHO4Diaqiqoyg//sBujPi3vBce
	 RVOcTWbwusUdoki67AifKyiQFrNqFEErlQ6ydtcFu8eI4gLWevoSerFRkvJxWulGEdFRh
	 43ow10KN2q8yXrGXTr3gdxSgCJZD3Jpo4cLtdAazwVU67WiN4lz/uU3cc3ZhnRtzpiOoD
	 4K9B5841wl4KF39C8wLM7ztTaY1KEfK6CnfPTzHQ/qYnm9sbQt4AruRx4BYSJRiI2vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4pawsgXL4bjb40BD4RlGZInU6H/ucZ4Plr9jMTeg9GA=;
	b=WQsjCvTy49Tc0kqjoafWcaWhqDgoMN2ygRioAOkJY2+r6MOM01IUi6MEByvVRBZURGw4
	 Xu8dhgwFPKq9sUlr9hs9qVcy+T3WkCl/n3Nm09rWBdvBupcL5USGNsS0ORu8wmaX6qsJJ
	 VxVGvpLY3d/xuoKhHh3+29oOtdB05fvinOkwpQtBuO27Objtb+EA1weUBeX/laje2Nvbk
	 dx7zPTDFDetdveKAFcp2CNIDdYop8aJp5REBn/3IIhWKP4L/v/Q/UH1MFqfpyEmmaJHLL
	 2poGBtseUNnMP03vfvN4fj8cW6EXa0p39QLgWrMyg0DEV6/C8tc9HLth/hmvvNzWumA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881342;
	bh=4pawsgXL4bjb40BD4RlGZInU6H/ucZ4Plr9jMTeg9GA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VsQdSEJi5qLAuNi/ZHs9d1B2bCVaThnncd04xNXifqIoDHs993fsS21tAs29yNbJe
	 XPrWU2OHF7wOB++6im/ZXWcMxtWnUo7XRI9j5CIRaZkjh73iE3FWfNrxndojv56Dhc
	 iQwlOnF8QyoZisoPd+3hmv9bc2MeVPoGQZGWqfW4FNMqUlrpG8Ha2LohmS3xowHjJL
	 b4f6bFv7cqryUpCY0LsKMrIWzsZUN1/5VPj20ZSSQJPZTLlME2Lbed1RrBz0a62TKA
	 7btIEI6JcHbtzYsu2RfkxOoqxftG9kuqNI0B77WX2NGcznfZ+gLEUdPrppGoe83YdY
	 ZKzj5ZFSInjIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E73CC40698;
	Sat, 24 Oct 2026 22:35:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB05D356
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD20C40079
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HmUa2wNLe3Up for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 044284006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881334;
 b=LDxiZEL6RU2p5bjjbaE4fDWzsoMSCL0LBOPq+ldB5qTJIib6EXkrqYldWmYCtDtrfRhZ
 Ziryf+cjXzGo6n4FXwf8M9hpwWTjfVAicu6pdjrmLcZR6yL4yqYGe1Uz69CQLDv2KU0kC
 HSxriC3mY7o3kQwzjCgakSdn7+S3sv+25jUKOKz9+tOHUvIbhqPeE7bEehD8omlZJGk2B
 BVmQ6jVshKmqelmbZCfcka2pYnEg+BLkC4kbG2hS0B063O0Pd0gexLl5JZS0zRqdbo7xU
 VyQpUF/BRTFO5dkxoWWGV15kWvr2c/Ft4x9LS9EPeOtDv0vdc3h8z39kq/XGqrqfJ9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=4pawsgXL4bjb40BD4RlGZInU6H/ucZ4Plr9jMTeg9GA=;
 b=TPD+zpvwOUx+Wjyo8r+1MrmobWhMJHSSwE5P914c9S7YSZ/je3xsRT6dMaMtGdBQFbIg
 BoBTNV3U3BBqsKak5b+DcznmuJyZkusPwseq36DtDM9hL6bsTqk2SI6iLsmOFKjSBKalt
 Bci7GAhsPNjdA7Nr/mMHZsYeD3/5easkSR+JlVmG/lJy9iYUEv6MuC3tjBx0OX+Bfk4e5
 IrazdWDBfPA12kKZaj6YwAp8BE6AiO1+0tZBPCqjiifkwzgYRYDgK1320oof9w+kjhHS6
 SBAlhoBF2mLWCCtm50IcTY/UjtvvidLZzeTVAtVZs99optJlrWW/2Y0ooh+PfXkUeZw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=f4aU2KgN; 
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=f4aU2KgN
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 044284006B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:33 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a755bbe158so1077866fac.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881332; x=1793486132;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4pawsgXL4bjb40BD4RlGZInU6H/ucZ4Plr9jMTeg9GA=;
 b=f4aU2KgN2ZpVy86t2FewvVzB7huaQyNeXljSl3o97OcuyZgjB4bmJndy1s7vdTGufr
 g8eX1W0SnJl0VDGXVXV41KJhOhiB7hGemFez8ZTj3mUOfkMGtpO32wGL/bMCnE9fbKfr
 8e8S/x7TSE20FgphbIe/Wcpgt4KupFFYWU2XEil2GLcbBMVG7u3QBKR9x32ebprlz+1P
 2nvW1rMZ2aIZgWTDSS1GvPi2s8Ae6CJOBz1zHQSK+UIQbJmZsHeZN7yC/Tn5EoqDMz9V
 x19fztsBeIPNWO+IFdA+4hDyaCc3nzWezMoRLIyJLXBM3zPS3k6e/caaI6fXmBdfHjmz
 Z9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881332; x=1793486132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4pawsgXL4bjb40BD4RlGZInU6H/ucZ4Plr9jMTeg9GA=;
 b=urHlWxcxx8a6GEDIzFXHhHDlVRdb4WlSQsF11Y/Mzrpz0MSAfidoiNJ4TARlybwFqM
 DONIWoAlB8kDf8+2hLVWEwzcDQQ4aVMBAh1M6NWpzYEnPIOshaxax94dbJqQaVruTDLt
 rrOmirnvj9oMgXWiNyYHC3TCpJFF/wNmP9AhFljmwWPa1QwKJMpyCd3fOZQcf/XIpJKi
 VDkgAe6F9J2/C4U9SEwGEe2hseTaQDilsCTyuxKLJeA0p2C+wNri0XhTzu7qCah+/DLX
 sYVGK9vB0nU8YlMSvJH+c06SY7V++oa+CKIJfGxSEVE2mdd15RuOtKAVC0DjUSxlG6Vx
 SpaQ==
X-Gm-Message-State: AFq9FYLMqOBwDabiVP2viShO69Rn+Z0d2TKjcidPWPxaaIezXkBbf4AF
 v/atgeGD2S2AoeQmBnL+xQfQqvemelYc+oVU5lsH6s1hJ5ogQNnuRDyb
X-Gm-Gg: AYBFou3V7Ixqu6oVA2bPMb49WL6bEamT7CbEKB1fpicaCiOJI6xvkfIGnLorObrhxvb
 4aYJWnCYTgAolD/JE5ZvtjVdq16y4Sb4tvYw7lduyyP4SdqOj17sw/2tFBwQc1mPejjqlfGY3jW
 +sZYN+7WyVCEz25I7Y43f+2F3ZF14xLZ6ipLTp6p1UoTKRvmk2wiOKiqah2i/Wsrn7vz2730/v2
 IaFkA2iu62HtI8w5XkVzssAziubFwzPwIOkxyfeae2Wcj1g+LlTFNpCxf/4wIUEY5G9hlbmysCb
 HjojitaRyyiGEkm1KjixujkEzKP8Ehv6Mhna5cuwOdA1Oy/LcAbjm1YXX4O4oZIQxHlj7r6iZ95
 sZN1bzGrQL9C/kfku8M2phTplDMD2jgEIo4DeZZWRkBmbJDz5VTpKTtdNVcpCULfVzCuvOzrPi1
 4uDrhZZnEm8TTwf7u/5iLo/yHYtcjatTPJs6gW3q+ZRHWK/cvDZXDFwW2OqiHAmT6BJscBKqvvm
 xIQJwuiOGCNhz0uK0VT0MS2PAVejV1UATPl82VJYrIZfbaOInMSz/Y6y1X//Q6QXp0mnpugihKB
 sPXdVOOGSN+RrGeNEXRTwvRbHergXQmjjw3zRhoy+ESjUo72NoisUmC2d6h8hkOT8KgZEzQsvgz
 oOlTNAy1Ae1LHdgym6AsFM41MTUiyNPOUfIyW9E1D/hbZ6/joCO8xZHOh5kQPFQ+rWl4xlsv2X1
 TjxMY=
X-Received: by 2002:a05:6870:7a1a:b0:4a2:4e0c:5964 with SMTP id
 586e51a60fabf-4a83f526627mr1569953fac.18.1792881332196; 
 Sat, 24 Oct 2026 15:35:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:57 -0600
Subject: [PATCH v2 10/16] net: lwip: honor autostart after TFTP download
 commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-10-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Match the legacy tftpboot and tftpsrv commands by checking autostart after
a successful nonempty download. Run the boot hook only after the TFTP
callbacks and shared runtime attachment are removed, and propagate its
result. Internal callers use the download-only helpers; tftpput never
boots its source buffer.

Exercise receive-server autostart, empty files and metadata failures in
sandbox without handing off to a bootable image.

Also deliver a second WRQ and DATA in the final receive batch. A completed,
empty or failed command must retain its original result and leave the
image and published metadata untouched by the later transfer.

Exercise command and helper downloads with autostart enabled. Check that
internal TFTP and DHCP callers return downloaded data without booting
it, restore the exact environment value, and preserve errors. A direct
TFTP command must attempt to boot the same non-bootable bytes after
releasing the network runtime and propagate the boot failure.

Check that a stale DHCP filename does not override a later command's
bootfile setting or its IP-derived default, with either network stack.

Preserve colon-containing filenames and lwIP's numeric destination-port
extension. Inspect requested block and window sizes, including overrides
above the default, upload MTU limits, and builds with NET_TFTP_VARS
disabled. Keep client-specific override tests conditional on that option.

Cover read-only autostart settings and the protocol-default 512-byte
block size, which does not require a blksize wire option.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig               |   5 +-
 doc/usage/cmd/tftpsrv.rst |   9 +-
 net/lwip/tftp.c           |  12 +-
 test/dm/lwip_dhcp.c       |   8 ++
 test/dm/lwip_net_loop.c   |   3 +-
 test/dm/lwip_tftp.c       | 109 ++++++++++++++---
 test/dm/tftp.c            | 303 +++++++++++++++++++++++++++++++++++++++++++---
 7 files changed, 404 insertions(+), 45 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3e79920e7d1..c72b00325d9 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2321,8 +2321,9 @@ config CMD_TFTPSRV
 	depends on CMD_TFTPBOOT
 	help
 	  Act as a TFTP server and receive the first incoming file into
-	  memory. The command returns successfully after the transfer so
-	  boot scripts can boot the received image from the load address.
+	  memory. If autostart is enabled, boot the received image after a
+	  successful nonempty transfer. Otherwise return to the caller so
+	  boot scripts can use the image at the load address.
 
 config CMD_WGET
 	bool "wget"
diff --git a/doc/usage/cmd/tftpsrv.rst b/doc/usage/cmd/tftpsrv.rst
index d067afdba57..2c6d08cdc80 100644
--- a/doc/usage/cmd/tftpsrv.rst
+++ b/doc/usage/cmd/tftpsrv.rst
@@ -25,10 +25,10 @@ loadAddress
     image load address.
 
 After a successful transfer, the *fileaddr* and *filesize* environment
-variables describe the received file. The command returns successfully after
-the transfer has completed. It does not boot the file automatically; boot
-scripts can use commands such as bootm, booti or bootefi to boot from the
-load address.
+variables describe the received file. If *autostart* is enabled, a nonempty
+file is passed to bootm after the transfer completes. Otherwise, the command
+returns without booting the file; boot scripts can use commands such as
+bootm, booti or bootefi to boot from the load address.
 
 The transfer is aborted if no transfer has started after about 50 seconds or
 if Ctrl-C is pressed.
@@ -45,6 +45,7 @@ In the example the following steps are executed:
 ::
 
     => setenv autoload no
+    => setenv autostart no
     => dhcp
     BOOTP broadcast 1
     DHCP client bound to address 192.168.1.40 (7 ms)
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 4cf451e1184..f29a20f518e 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -581,7 +581,9 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 out:
 	net_lwip_stop(&net);
-	return ret;
+	if (ret || !net_boot_file_size)
+		return ret;
+	return bootm_maybe_autostart(cmdtp, argv[0]);
 }
 
 static int tftp_default_filename(char *fname, size_t size)
@@ -807,7 +809,13 @@ out:
 
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	return do_tftp(cmdtp, flag, argc, argv, TFTP_DOWNLOAD);
+	int ret;
+
+	ret = do_tftp(cmdtp, flag, argc, argv, TFTP_DOWNLOAD);
+	if (ret || !net_boot_file_size)
+		return ret;
+	/* The transfer's callbacks and runtime attachment are already gone. */
+	return bootm_maybe_autostart(cmdtp, argv[0]);
 }
 
 int do_tftpput(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
diff --git a/test/dm/lwip_dhcp.c b/test/dm/lwip_dhcp.c
index c93579aea49..60b4d2a311e 100644
--- a/test/dm/lwip_dhcp.c
+++ b/test/dm/lwip_dhcp.c
@@ -251,10 +251,18 @@ static int dhcp_handoff_check(struct unit_test_state *uts,
 	}
 	*test = (struct dhcp_handoff_test){ .offer = "offered.bin", .fail = true };
 	ut_assertok(env_set("autoload", "NFS"));
+	ut_assertok(env_set("autostart", "yes-please"));
 	ut_asserteq(-ENOENT, dhcp_run(0x2000000, "explicit.bin", true));
 	ut_asserteq_str("NFS", env_get("autoload"));
 	ut_assert(!test->dhcp_alive);
 	ut_assertnull(netif_default);
+	*test = (struct dhcp_handoff_test){ .offer = "offered.bin" };
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		ut_assertok(dhcp_run(0x2000000, "explicit.bin", true));
+		ut_asserteq_str("yes-please", env_get("autostart"));
+		ut_asserteq_str("NFS", env_get("autoload"));
+		ut_assertnull(netif_default);
+	}
 	*test = (struct dhcp_handoff_test){ .offer = "", .timeout = true };
 	ut_asserteq(-ENOENT, dhcp_run(0x2000000, NULL, true));
 	ut_asserteq(0, test->tftp);
diff --git a/test/dm/lwip_net_loop.c b/test/dm/lwip_net_loop.c
index 2e646e40020..4fedc9ba9e4 100644
--- a/test/dm/lwip_net_loop.c
+++ b/test/dm/lwip_net_loop.c
@@ -71,13 +71,14 @@ static int net_loop_check(struct unit_test_state *uts, int *mode)
 	ut_assertok(env_set("tftpdstp", NULL));
 	ut_assertok(env_set("loadaddr", "2000000"));
 	ut_assertok(env_set("bootfile", "other.bin"));
-	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("autostart", "yes"));
 	strcpy(net_boot_file_name, "test.bin");
 	image_load_addr = 0x2100000;
 	for (*mode = -1; *mode <= 1; (*mode)++) {
 		net_boot_file_size = 1234;
 		ut_asserteq(*mode < 0 ? -EINVAL : *mode, net_loop(TFTPGET));
 		ut_asserteq(*mode > 0 ? 1 : 0, net_boot_file_size);
+		ut_asserteq_str("yes", env_get("autostart"));
 		if (*mode >= 0)
 			ut_asserteq_str("2100000", env_get("fileaddr"));
 	}
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
index 3c2562f99a1..7d84120ab4c 100644
--- a/test/dm/lwip_tftp.c
+++ b/test/dm/lwip_tftp.c
@@ -33,6 +33,9 @@ struct tftp_protocol_test {
 	bool initialized;
 	bool fail_data_alloc;
 	bool window_requested;
+	bool server_empty;
+	bool server_followup;
+	bool server_failure;
 	char timeout[4];
 };
 
@@ -724,7 +727,10 @@ static int tftp_test_windows(struct unit_test_state *uts,
 static void tftp_test_server_input(void *arg)
 {
 	static const char wrq[] = "\000\002file\000octet";
+	static const char other[] = "\000\002other\000octet";
 	static const u8 data[] = { 0, 3, 0, 1, 'a', 'b', 'c' };
+	static const u8 extra[] = { 0, 3, 0, 1, 'X', 'Y', 'Z' };
+	static const char error[] = "\000\005\000\001missing";
 	struct tftp_protocol_test *test = arg;
 
 	if (!test->server_phase++) {
@@ -733,35 +739,95 @@ static void tftp_test_server_input(void *arg)
 		/* Lose DATA 1 long enough for the server to retransmit ACK 0. */
 		timer_test_add_offset(5001);
 		sys_timeout(1, tftp_test_server_input, test);
+	} else if (test->server_failure) {
+		test->error = tftp_test_input(test, error, sizeof(error), 0);
 	} else {
-		test->error = tftp_test_input(test, data, sizeof(data), 0);
+		test->error = tftp_test_input(test, data,
+					      test->server_empty ? 4 : sizeof(data), 0);
+	}
+	if (test->server_phase == 2 && test->server_followup && !test->error) {
+		/* More packets can arrive before the command leaves its RX loop. */
+		test->error = tftp_test_input(test, other, sizeof(other), 0);
+		if (!test->error)
+			test->error = tftp_test_input(test, extra, sizeof(extra), 0);
 	}
 }
 
 static int tftp_test_server_command(struct unit_test_state *uts,
 				    struct tftp_protocol_test *test)
 {
-	int ret;
+	int i, ret;
 
 	if (test->initialized)
 		tftp_cleanup();
-	memset(test, 0, sizeof(*test));
-	ipaddr_aton("1.1.2.2", &test->server);
-	ut_assertok(env_set("autostart", "yes"));
-	sys_timeout(1, tftp_test_server_input, test);
-	ret = run_command("tftpsrv 2000000", 0);
-	sys_untimeout(tftp_test_server_input, test);
-	ut_assertok(ret);
-	ut_assertok(test->error);
-	ut_asserteq(2, test->server_phase);
-	ut_asserteq(3, test->sent);
-	ut_asserteq(4, test->opcode);
-	ut_asserteq(1, test->block);
-	ut_asserteq(0x2000000, image_load_addr);
-	ut_asserteq_str("3", env_get("filesize"));
-	ut_asserteq_str("2000000", env_get("fileaddr"));
-	ut_asserteq_str("yes", env_get("autostart"));
-	ut_asserteq_mem("abc", map_sysmem(0x2000000, 3), 3);
+	for (i = 0; i < 4; i++) {
+		memset(test, 0, sizeof(*test));
+		test->server_empty = i == 2;
+		ipaddr_aton("1.1.2.2", &test->server);
+		ut_assertok(env_set("autostart", i ? "yes" : "no"));
+		if (i == 3)
+			ut_assertok(env_set(".flags", "filesize:xr"));
+		sys_timeout(1, tftp_test_server_input, test);
+		ret = run_command("tftpsrv 2000000", 0);
+		sys_untimeout(tftp_test_server_input, test);
+		ut_assertok(env_set(".flags", NULL));
+		/*
+		 * Non-bootable data must fail autostart, but an empty file must
+		 * not boot stale RAM. Metadata errors are transfer failures.
+		 */
+		if (i == 3 || (i == 1 && IS_ENABLED(CONFIG_CMD_BOOTM)))
+			ut_assert(ret != CMD_RET_SUCCESS);
+		else
+			ut_assertok(ret);
+		ut_assertok(test->error);
+		ut_asserteq(2, test->server_phase);
+		ut_asserteq(3, test->sent);
+		ut_asserteq(4, test->opcode);
+		ut_asserteq(1, test->block);
+		ut_asserteq(i >= 2 ? 0 : 3, net_boot_file_size);
+		ut_asserteq(0x2000000, image_load_addr);
+		ut_asserteq_str("2000000", env_get("fileaddr"));
+		ut_asserteq_str(i ? "yes" : "no", env_get("autostart"));
+		ut_asserteq_mem("abc", map_sysmem(0x2000000, 3), 3);
+	}
+	return 0;
+}
+
+static int tftp_test_server_completion(struct unit_test_state *uts,
+				       struct tftp_protocol_test *test)
+{
+	u8 expected[6];
+	void *buf = map_sysmem(0x2000000, sizeof(expected));
+	int i, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	for (i = 0; i < 3; i++) {
+		memset(test, 0, sizeof(*test));
+		test->server_followup = true;
+		test->server_empty = i == 1;
+		test->server_failure = i == 2;
+		ipaddr_aton("1.1.2.2", &test->server);
+		memset(buf, 0xa5, sizeof(expected));
+		memset(expected, 0xa5, sizeof(expected));
+		if (!i)
+			memcpy(expected, "abc", 3);
+		ut_assertok(env_set("fileaddr", "1234"));
+		ut_assertok(env_set("filesize", "5678"));
+		sys_timeout(1, tftp_test_server_input, test);
+		ret = run_command("tftpsrv 2000000", 0);
+		sys_untimeout(tftp_test_server_input, test);
+		ut_asserteq(i == 2 ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+		ut_assertok(test->error);
+		ut_asserteq(2, test->server_phase);
+		ut_asserteq(i == 2 ? 4 : 5, test->sent);
+		ut_asserteq(5, test->opcode);
+		ut_asserteq(2, test->block);
+		ut_asserteq(i ? 0 : 3, net_boot_file_size);
+		ut_asserteq_str(i == 2 ? "1234" : "2000000", env_get("fileaddr"));
+		ut_asserteq_str(i == 2 ? "5678" : i ? "0" : "3", env_get("filesize"));
+		ut_asserteq_mem(expected, buf, sizeof(expected));
+	}
+	unmap_sysmem(buf);
 	return 0;
 }
 #endif
@@ -769,7 +835,7 @@ static int tftp_test_server_command(struct unit_test_state *uts,
 static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 {
 	static const char * const vars[] = {
-		"ethact", "ipaddr", "netmask", "fileaddr", "filesize", "autostart",
+		"ethact", "ipaddr", "netmask", "fileaddr", "filesize", "autostart", ".flags",
 	};
 	struct tftp_protocol_test test = {};
 	struct net_lwip_ctx net = {};
@@ -817,6 +883,8 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 #if IS_ENABLED(CONFIG_CMD_TFTPSRV)
 	if (!ret)
 		ret = tftp_test_server_command(uts, &test);
+	if (!ret)
+		ret = tftp_test_server_completion(uts, &test);
 #endif
 	if (test.initialized)
 		tftp_cleanup();
@@ -824,6 +892,7 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 	tftp_test_active = NULL;
 	net_lwip_stop(&net);
 restore_env:
+	env_set(".flags", NULL);
 	image_load_addr = load_addr;
 	net_boot_file_size = size;
 	for (i = 0; i < ARRAY_SIZE(vars); i++)
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index eb178573312..b70aa6f4722 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -15,6 +15,10 @@
 #include <asm/unaligned.h>
 #include <dm/test.h>
 #include <test/ut.h>
+#if IS_ENABLED(CONFIG_NET_LWIP)
+#include <lwip/timeouts.h>
+#include <lwip/udp.h>
+#endif
 
 static const char tftp_test_data[] = "update data, not a bootable image";
 
@@ -29,6 +33,7 @@ enum tftp_test_probe {
 
 struct tftp_test_context {
 	bool fail;
+	bool empty;
 	bool autostart;
 	unsigned int requests;
 	unsigned int arp_requests;
@@ -41,8 +46,47 @@ struct tftp_test_context {
 	ulong ack_start;
 	ulong ack_delay;
 	unsigned int advertised_timeout;
+	char filename[64];
+	u16 blocksize;
+	u16 windowsize;
+	u16 port;
 };
 
+static ulong tftp_test_option(const char *packet, size_t len, const char *option)
+{
+	const char *end = packet + len;
+	const char *name = packet + 2;
+	size_t size;
+	int i;
+
+	/* Skip the request's filename and mode before walking option pairs. */
+	for (i = 0; i < 2; i++) {
+		if (name >= end)
+			return 0;
+		size = strnlen(name, end - name);
+		if (size == end - name)
+			return 0;
+		name += size + 1;
+	}
+	while (name < end) {
+		const char *value;
+
+		size = strnlen(name, end - name);
+		if (size == end - name)
+			break;
+		value = name + size + 1;
+		if (value >= end)
+			break;
+		size = strnlen(value, end - value);
+		if (size == end - value)
+			break;
+		if (!strcmp(name, option))
+			return simple_strtoul(value, NULL, 10);
+		name = value + size + 1;
+	}
+	return 0;
+}
+
 /* Answer an RRQ with one short DATA block or a file-not-found error. */
 static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 				unsigned int len)
@@ -52,9 +96,9 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	struct ethernet_hdr *eth = packet, *reply_eth;
 	struct ip_udp_hdr *ip, *reply_ip;
 	const char *data = ctx->fail ? "not found" : tftp_test_data;
-	unsigned int data_len = strlen(data) + 1;
+	unsigned int data_len = ctx->empty ? 0 : strlen(data) + 1;
 	unsigned int reply_len, header_len = 4;
-	u16 opcode, reply_opcode = ctx->fail ? 5 : 3, block = 1;
+	u16 opcode, reply_opcode = 3, block = 1;
 	bool partial = false;
 	u8 *payload;
 
@@ -98,16 +142,16 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 			return 0;
 		ctx->ack_delay = get_timer(ctx->ack_start);
 		block = ctx->probe == TFTP_PROBE_DATA ? 2 : 1;
-	} else if (opcode == 1 && ntohs(ip->udp_dst) == 69) {
-		unsigned int i, request_len = len - ETHER_HDR_SIZE - IP_UDP_HDR_SIZE;
+	} else if (opcode == 1 || opcode == 2) {
+		size_t request_len = len - ETHER_HDR_SIZE - IP_UDP_HDR_SIZE;
 
 		if (!ctx->requests++)
 			ctx->request_start = get_timer(0);
-		payload = (void *)(ip + 1);
-		for (i = 2; i + 10 <= request_len; i++) {
-			if (!memcmp(payload + i, "timeout\0", 8))
-				ctx->advertised_timeout = dectoul((char *)payload + i + 8, NULL);
-		}
+		strlcpy(ctx->filename, (char *)(ip + 1) + 2, sizeof(ctx->filename));
+		ctx->blocksize = tftp_test_option((char *)(ip + 1), request_len, "blksize");
+		ctx->windowsize = tftp_test_option((char *)(ip + 1), request_len, "windowsize");
+		ctx->port = ntohs(ip->udp_dst);
+		ctx->advertised_timeout = tftp_test_option((char *)(ip + 1), request_len, "timeout");
 		if (ctx->probe == TFTP_PROBE_SILENT)
 			return 0;
 		if (ctx->probe == TFTP_PROBE_DATA) {
@@ -123,13 +167,23 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 				"timeout\0" "1" : "timeout\0" "5";
 			data_len = 10;
 		}
+		if (opcode == 2) {
+			reply_opcode = 4;
+			block = 0;
+			data_len = 0;
+		}
+	} else if (ntohs(ip->udp_dst) == 1234 && opcode == 3 &&
+		   len >= ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 4) {
+		reply_opcode = 4;
+		block = get_unaligned_be16((u8 *)(ip + 1) + 2);
+		data_len = 0;
 	} else {
 		return 0;
 	}
+	reply_len = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + header_len + data_len;
 	if (priv->recv_packets >= PKTBUFSRX)
 		return -ENOSPC;
 
-	reply_len = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + header_len + data_len;
 	ctx->autostart |= env_get_autostart();
 	reply_eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
 	memcpy(reply_eth->et_dest, eth->et_src, ARP_HLEN);
@@ -149,7 +203,7 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 	reply_ip->udp_len = htons(UDP_HDR_SIZE + header_len + data_len);
 	reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
 	payload = (void *)(reply_ip + 1);
-	put_unaligned_be16(reply_opcode, payload);
+	put_unaligned_be16(ctx->fail ? 5 : reply_opcode, payload);
 	if (header_len == 4)
 		put_unaligned_be16(block, payload + 2);
 	if (partial)
@@ -257,11 +311,140 @@ static int tftp_test_probe_timeout(struct unit_test_state *uts,
 	return 0;
 }
 
+static int tftp_test_filenames(struct unit_test_state *uts,
+			       struct tftp_test_context *ctx)
+{
+	static const char * const files[] = {
+		"dir:file", "dir:one:two:file", "1.1.2.2:path:file",
+	};
+	static const char * const expected[] = {
+		"dir:file", "dir:one:two:file", "path:file",
+	};
+	char command[100];
+	int i;
+
+	ut_assertok(env_set("autostart", "no"));
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		memset(ctx, 0, sizeof(*ctx));
+		snprintf(command, sizeof(command), "tftpboot 2000000 %s", files[i]);
+		ut_assertok(run_command(command, 0));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq_str(expected[i], ctx->filename);
+		ut_assertok(env_set("bootfile", files[i]));
+		ut_assertok(run_command("tftpboot 2000000", 0));
+		ut_asserteq_str(expected[i], ctx->filename);
+	}
+	if (IS_ENABLED(CONFIG_NET_LWIP)) {
+		/* Keep the lwIP numeric-port extension, including filename colons. */
+		ut_assertok(run_command("tftpboot 2000000 1.1.2.2:1069:path:to:file", 0));
+		ut_asserteq(1069, ctx->port);
+		ut_asserteq_str("path:to:file", ctx->filename);
+		ut_assertok(run_command("tftpboot 2000000 :1069:path:to:file", 0));
+		ut_asserteq_str("path:to:file", ctx->filename);
+		ut_assertok(run_command("tftpboot 2000000 1.1.2.2::path:file", 0));
+		ut_asserteq(69, ctx->port);
+		ut_asserteq_str("path:file", ctx->filename);
+		memset(ctx, 0, sizeof(*ctx));
+		ut_asserteq(CMD_RET_FAILURE,
+			    run_command("tftpboot 2000000 1.1.2.2:65536:file", 0));
+		ut_asserteq(0, ctx->requests);
+	}
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_NET_LWIP)
+static int tftp_test_options(struct unit_test_state *uts,
+			     struct tftp_test_context *ctx)
+{
+	static const struct {
+		const char *value;
+		bool valid;
+	} sizes[] = {
+		{ NULL, true },
+		{ "512", true },
+		{ "4096", true },
+		{ "65464", true },
+		{ "1", false },
+		{ "bad", false },
+	};
+	ulong rx_max = IP_REASSEMBLY ?
+		min_t(ulong, 65464, IP_REASS_MAX_PBUFS * IP_FRAG_MTU_USABLE - 12) : 1468;
+	bool vars = IS_ENABLED(CONFIG_NET_TFTP_VARS);
+	ulong requested, expected;
+	int i, put, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("tftpwindowsize", "4"));
+	for (put = 0; put <= IS_ENABLED(CONFIG_CMD_TFTPPUT); put++) {
+		for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+			memset(ctx, 0, sizeof(*ctx));
+			ut_assertok(env_set("tftpblocksize", sizes[i].value));
+			ret = run_command(put ? "tftpput 2000000 20 file" :
+					  "tftpboot 2000000 file", 0);
+			if (vars && !sizes[i].valid) {
+				ut_asserteq(CMD_RET_FAILURE, ret);
+				ut_asserteq(0, ctx->requests);
+				continue;
+			}
+			ut_assertok(ret);
+			requested = vars && sizes[i].value ?
+				simple_strtoul(sizes[i].value, NULL, 10) : CONFIG_TFTP_BLOCKSIZE;
+			expected = min(requested, put ? 1468UL : rx_max);
+			/* The default block size does not need an on-wire option. */
+			ut_asserteq(expected == 512 ? 0 : expected, ctx->blocksize);
+			expected = vars ? 4 : CONFIG_TFTP_WINDOWSIZE;
+			ut_asserteq(put || expected == 1 ? 0 : expected, ctx->windowsize);
+		}
+	}
+	ut_assertok(env_set("tftpblocksize", NULL));
+	ut_assertok(env_set("tftpwindowsize", "bad"));
+	memset(ctx, 0, sizeof(*ctx));
+	ret = run_command("tftpboot 2000000 file", 0);
+	ut_asserteq(vars ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+	ut_asserteq(vars ? 0 : 1, ctx->requests);
+	ut_assertok(env_set("tftpwindowsize", NULL));
+	return 0;
+}
+#endif
+
+static int tftp_test_protected_autostart(struct unit_test_state *uts,
+					 struct tftp_test_context *ctx)
+{
+	char * const argv[] = { "tftpboot", "2000000", "update.bin" };
+	int enabled, helper, ret;
+
+	for (enabled = 0; enabled < 2; enabled++) {
+		ut_assertok(env_set("autostart", enabled ? "yes" : "no"));
+		ut_assertok(env_set(".flags", "autostart:br"));
+		for (helper = 0; helper < 3; helper++) {
+			memset(ctx, 0, sizeof(*ctx));
+			switch (helper) {
+			case 0:
+				ret = tftpb_run(TFTP_TEST_ADDR, "update.bin");
+				break;
+			case 1:
+				ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+				break;
+			default:
+				ret = tftpb_run_argv(3, argv);
+			}
+			/* Do not override protection when suppression is required. */
+			ut_asserteq(enabled, !!ret);
+			ut_asserteq(!enabled, ctx->requests);
+			ut_assert(!ctx->autostart);
+			ut_asserteq_str(enabled ? "yes" : "no", env_get("autostart"));
+		}
+		ut_assertok(env_set(".flags", NULL));
+	}
+	return 0;
+}
+
 static int tftp_test_download(struct unit_test_state *uts,
 			      struct tftp_test_context *ctx)
 {
 	static const char * const autostart[] = { "yes", NULL, "no", "yes-please" };
 	const char *timeout, *retries;
+	char * const argv[] = { "tftpboot", "2000000", "update.bin" };
 	void *buffer = map_sysmem(TFTP_TEST_ADDR, sizeof(tftp_test_data));
 	int i, fail, ret;
 
@@ -277,22 +460,74 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(tftp_test_probe_arp(uts, ctx));
 	ut_assertok(tftp_test_probe_timeout(uts, ctx));
 
+	ut_assertok(tftp_test_protected_autostart(uts, ctx));
+
+#if IS_ENABLED(CONFIG_NET_LWIP)
+	ut_assertok(tftp_test_options(uts, ctx));
+#endif
+	ut_assertok(tftp_test_filenames(uts, ctx));
+
+	/* A previous DHCP/download must not override the next command's env. */
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("loadaddr", "2000000"));
+	for (i = 0; i < 3; i++) {
+		strcpy(net_boot_file_name, "stale.bin");
+		ut_assertok(env_set("bootfile", i == 2 ? NULL : "fresh.bin"));
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(run_command(i == 1 ? "tftpboot 2000000" : "tftpboot", 0));
+		ut_asserteq_str(i == 2 ? "01010203.img" : "fresh.bin", ctx->filename);
+		ut_asserteq(1, ctx->requests);
+	}
+	strcpy(net_boot_file_name, "stale.bin");
+	ut_assertok(env_set("bootfile", "helper.bin"));
+	ut_assertok(tftpb_run(TFTP_TEST_ADDR, NULL));
+	ut_asserteq_str("helper.bin", ctx->filename);
+
+#if IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_NET_TFTP_VARS)
+	/* Reject delays outside lwIP's wrap-safe timer range before an RRQ. */
+	ut_assertok(env_set("autostart", "no"));
+	for (i = 0; i < 3; i++) {
+		static const char * const delays[] = {
+			"1073741823", "1073741824", "4294967295",
+		};
+
+		memset(ctx, 0, sizeof(*ctx));
+		net_boot_file_size = 1234;
+		ut_assertok(env_set("tftptimeout", delays[i]));
+		ret = do_tftpb(NULL, 0, 3, argv);
+		ut_asserteq(i ? CMD_RET_FAILURE : CMD_RET_SUCCESS, ret);
+		ut_asserteq(i ? 0 : 1, ctx->requests);
+		ut_asserteq(i ? 0 : sizeof(tftp_test_data), net_boot_file_size);
+		ut_asserteq(-ENODEV, net_lwip_poll());
+	}
+	ut_assertok(env_set("tftptimeout", NULL));
+#endif
+
 	for (i = 0; i < ARRAY_SIZE(autostart); i++) {
 		timeout = i & 1 ? NULL : "7000";
 		retries = i & 1 ? NULL : "09";
-		for (fail = 0; fail < 2; fail++) {
+		for (fail = 0; fail < 6; fail++) {
 			ut_assertok(env_set("autostart", autostart[i]));
 			ut_assertok(env_set("tftptimeout", timeout));
 			ut_assertok(env_set("tftptimeoutcountmax", retries));
 			memset(buffer, 0, sizeof(tftp_test_data));
 			memset(ctx, 0, sizeof(*ctx));
-			ctx->fail = fail;
+			ctx->fail = fail & 1;
 
-			ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
-			ut_asserteq(fail ? -ENOENT : 0, ret);
+			switch (fail / 2) {
+			case 0:
+				ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+				break;
+			case 1:
+				ret = tftpb_run(TFTP_TEST_ADDR, "update.bin");
+				break;
+			default:
+				ret = tftpb_run_argv(3, argv) ? -ENOENT : 0;
+			}
+			ut_asserteq(ctx->fail ? -ENOENT : 0, ret);
 			ut_asserteq(1, ctx->requests);
 			ut_assert(!ctx->autostart);
-			if (!fail) {
+			if (!ctx->fail) {
 				ut_asserteq(sizeof(tftp_test_data), net_boot_file_size);
 				ut_asserteq_mem(tftp_test_data, buffer,
 						sizeof(tftp_test_data));
@@ -310,6 +545,40 @@ static int tftp_test_download(struct unit_test_state *uts,
 			}
 		}
 	}
+	if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
+		/* An empty successful download must not boot stale RAM contents. */
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->empty = true;
+		ut_assertok(env_set("autostart", "yes"));
+		ut_assertok(do_tftpb(NULL, 0, 3, argv));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq(0, net_boot_file_size);
+
+		/*
+		 * The same bytes are not bootable. A command must attempt boot
+		 * and return its failure, unlike the download-only helpers above.
+		 */
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(env_set("autostart", "yes"));
+		ut_assert(do_tftpb(NULL, 0, 3, argv) != CMD_RET_SUCCESS);
+		ut_asserteq(1, ctx->requests);
+		ut_assert(ctx->autostart);
+		ut_asserteq(sizeof(tftp_test_data), net_boot_file_size);
+		ut_asserteq_str("yes", env_get("autostart"));
+#if IS_ENABLED(CONFIG_NET_LWIP)
+		ut_asserteq(-ENODEV, net_lwip_poll());
+#endif
+	}
+#if IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_CMD_TFTPPUT)
+	/* Uploading non-bootable bytes is not a request to boot their source. */
+	memset(ctx, 0, sizeof(*ctx));
+	ut_assertok(env_set("autostart", "yes"));
+	ut_assertok(run_command("tftpput 2000000 20 update.bin", 0));
+	ut_asserteq(1, ctx->requests);
+	ut_assert(ctx->autostart);
+	ut_asserteq_str("yes", env_get("autostart"));
+	ut_asserteq(-ENODEV, net_lwip_poll());
+#endif
 	unmap_sysmem(buffer);
 
 	return 0;
@@ -321,6 +590,8 @@ static int dm_test_tftp_download_only(struct unit_test_state *uts)
 		"autostart", "tftptimeout", "tftptimeoutcountmax", "ethact",
 		"ipaddr", "serverip", "netmask", "gatewayip", "netretry", "tftpsrcp",
 		"tftpdstp", "tftpserverip", "fileaddr", "filesize",
+		"bootaddr", "loadaddr", "bootfile", "ethrotate", ".flags",
+		"tftpblocksize", "tftpwindowsize",
 	};
 	char saved_bootfile[sizeof(net_boot_file_name)];
 	ulong saved_load_addr = image_load_addr;

-- 
2.53.0

