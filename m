Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E7606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bnAlMZqp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dozqoFhx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3471B80DBC;
	Mon, 26 Oct 2026 09:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8XiwTQ6Jii0J; Mon, 26 Oct 2026 09:24:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A76180DA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006680;
	b=LCETtrGLMcDbmecMxmJnbvQaypVSmob+zN1QMyxkTdDqz3RmXYw67GpMbtoNDrafVUx/
	 eJ8Q3cZ3XB5j2mUCGSV+UANLnC9O/R0sI/URRwSLjta3vBK3dS6FZHrCNQL+FpcUYS7Zz
	 4u3Vu4sRDlHN1JInIS1z6OEbHIb6AFHksd5mnprHMyKMFiJhkpGbXMtn7NB3Z5cBQfRZj
	 xRXzn86bIc9+6SManbHqQDE7tv+5iXoCne0ZMiOSk3xF7TXMIH9cvs7NKx3E+ZqmATpDK
	 Ion83aA+0VyvGhTJ9KrMNmCH4fAjapVYilsAczUD3crXyffScLpFstWcyGdiY4G/JOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hNwEh0Cn3V88NRfoK6UgXoiGrd07jIEyiqfXmkhj5Rg=;
	b=Yyg9yACjJWkL+13Lh1dWM1t1fiZQ5i4Ud7G/MAVLAVKmBT2aJGcakhs0DfdwdmsgV7lg
	 hQ7tmQ2DSuFyGE9pi2o5GMYHI0Vq5XthXtwjjaJyW19x0s0T9nc5WBVHadbDvGxhlgJDC
	 KSiX2Raw7actWelf2bI98z/6DiGQuggHSe0IW6ZLrAYJ5LJwmMwjsI4jtQam1FKmoCv7L
	 ORoDY4fKBarUF7ITq3Yy447p6wLVLN3Q1V8MqVFsSrKGYIsq/eavWeZ1WJk1pTYG6dzbK
	 xt10RM4TqRJfP/PZXMZM37rGrh+Bzyo91Cmex4QALqD+K8yLXVFiSYExm3jf878sXFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dozqoFhx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793006680;
	bh=hNwEh0Cn3V88NRfoK6UgXoiGrd07jIEyiqfXmkhj5Rg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bnAlMZqpydmnBMTeI5RdYeHNRlq3DHMneCssBYUSpC7QikEct0K7iH0gy3tu83QtR
	 LCXRb/0cBGbLJJIGOTNOCPBRIcCoijlgdO7tysUvhcYXJixAp5QEQa1q01Vep6XSSv
	 12Vhqhn3xOTDeeAo/NAicu6wXDg75nKAPxtoNRCjW3U0ZJha0GpA7upYdWQZV5DLy3
	 pAyhk8FMW+YHD7K7QTJZiDhQVEC2uReJzRxKLA0nNJ4imFNx7v0pK/1VQc7wqwDRG9
	 zaUuSx8EWaHuXXcZbBi5b5l0FeQCKvO6ZJphnD8kVi9P4oOD5fttXiiHoHaYIvFP3i
	 0iGdtOBpmmXXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A76180DA2;
	Mon, 26 Oct 2026 09:24:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C032356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 120F380DA2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QwumDQBadRYa for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:24:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 705D780D91
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006678;
 b=LwVJn3Txth+fAueULSssG3T/wbBZybk9dXj44YdiwofQ6jvoGwUHpTWSNhnWNzrbAAgI
 3ggHXyDKPlg/FyXKLKhlwiglbd9gwXorIz8/mdYrg8cuxzaVlKpbg5wAX6ahGRQDY/sPY
 0UcG3efO4lzVAr3bomdiPtq8SxfRAXYBH1gghgUkwp9AfNFbfrkiCC7rTRxfXoiuItDp+
 nCKOeSeUTjZcVLI8FHhb0jYTOytmsDuUPm8ugPXKout6DIvY6Idst5Qtbfo21NPzso3bH
 OymtzPPCqx2tYg1K4aA6dmpsApJDa4d+gmunsRHhXQDmQ7huNQ/L792yOQjYREDCnkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006678;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=hNwEh0Cn3V88NRfoK6UgXoiGrd07jIEyiqfXmkhj5Rg=;
 b=lnSMcxwJExf7r5WW4pop/MXd28C7fl8GUJJQQc9sYZDkxmPwTNgycpjyr533okTfk0PN
 6DvxjUVoRACqzAVRyRSNfpTB9GkHZea2WyQp4deKiEDxeS9G4aotM8hufombzBfFsrGjH
 tLrlLhcYHcLlpl8kjJEPqe1ibRwVCnJ8dMY6fwd1yIfHdRUoDSam+oVD1BjWGo9xyFoFz
 42Ir59ThhXJGWuPhxnSipZdZFwao5BnfEVDqo7oIMnJV/Ta35Y5H4WrixQXNB+VkLOGVw
 EuO4i6rjlI5j5i6IX2VnkVY3kTf6KYEm0UBnGtJ6zeDLM5Lpj4BKcwjw+Tv+wdegl8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dozqoFhx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dozqoFhx
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 705D780D91
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:38 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3adac5b29ebso1613167a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793006677; x=1793611477;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hNwEh0Cn3V88NRfoK6UgXoiGrd07jIEyiqfXmkhj5Rg=;
 b=dozqoFhxK9wRj949UpjPeik2wm0DjTagL9vCbgPtTmFE5+KSogDtG+6MgiyHIeflKj
 8yIxYUt06tT+LPMDwelrUihDSLaqZ1vy+e4ntg7r53v6okXMTcZeAF3xHdH2ROhoV4zG
 UHnBPOCwXcix52oA6li27Xp8jBqE+NzNbk9i0SsJaZK7EC2A7uUzWzj/77zQkR76l/cr
 jlrHgCEJcJN0ygwmVEtfvCmnXq/ObD2ehFOdF26RQDuhgqqnzuqBzK+RNRhXWoi+Ezry
 SNqrqfKcjsSM/+ncmbDFeoLd2qKN4deqA18mef1tUXk9iEi/lEg8OndAFHyV0kM8Bt9L
 gEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006677; x=1793611477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hNwEh0Cn3V88NRfoK6UgXoiGrd07jIEyiqfXmkhj5Rg=;
 b=hM5fZBFnDVIUImyhU0x3lxrANIFsa1nR7SfXzDjhc3Llo91kQ+OSULmnI39OZ5c8Yi
 pkuWlgDIrbgJLGqkfHbqjnqHsCry+l28fsOhcBMVeBefzrAsT+Me44tTjFueJQLM7af4
 8Qlc/oGvsPazJ0yCxFWNqx1zCuLLNYA0s6PK6TKSdylTVLCmssOpkxs55PDkwYo+s8FZ
 wxOG75xCWiUcXmEaAh2PD4jNrWeGTFu0Z2VVxMtfumiQX7EAze4BMOHYQV10679fOWB4
 XqRgBsMQV58hRjKB+9ks5jZlnp4NZtOem/18f8JkpUCcJpFcdwLpX2/k5ERVVZZdXkgM
 KB3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF41JoeG08lwMbiQwvRIIoe3s2RIA/wnRo3WgJttPid5IF2GjELvbF4R647t1fJK5IC7nk/VM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKe0uJGU4T7P8dXJa1DE7FMRdj5zWkkT8jJUmZQLv5SlTqQu2gf
 Z+B1jFpLPsPD1IRosBVcZHBmYW4+wOZB+nHb08Sd6hwRWNorbC1pc1Ct
X-Gm-Gg: AYBFou0O+cakw4jrwMVGhTNIpkxHL7IjWZlN6s64h5i/XB5WKoG05dAe4MxAtP6kG3x
 14Y+yrSVgDoAZOZ+kK43KqAYNrJoXsbQ0dkdtCKOG1Ib04UV0nVxR+JTYWLQIJSURf4L4edheoX
 BdYOiwnni37W2YkZfQvwT9XfHkr5WPPyCD1tvZV0k5/7j3whYK7uy1W/6m9HL8mmq+tDU4mlIOB
 2g6NPOMwQZvZp40ValAV/yQ8zLhYj5gbgIfTRsk32j8tyHMVZSehopQr6ZNPiPCAN+eFNY4PsY7
 9NcnhaaE33TOxu5N8s4Wv5EQDSKlSCVFlZMSBDHxSwjih4zYEDkWP+PJ86Dappz1FmoKDEoetjM
 lVwozbS7DW0yf7dK/B5rvSGa5smJqUR5VfaabZEdraMixKQ0RPsuPDNGzg+kTuqH1Sko3YYmc1+
 iukxvmR2c+i6OL604K+Qi0FWPYUmAjJQa/ng+bihhNY0Q2gOc0PnIH1nN8y9hHax07b8dHLAlhB
 kytwqeNmOE8UUsSS6i2siyLfkIhE0UlulzsJXXWZIft9H0NEqInHH8S+PuGR5kYb/SDv5oOkFh/
 b51zcuQcyLj2Zx7ACeoIe11YekP3EhxUXJ6hs6qDHECpkbVh0c9VERI5HfiP6N+g6nNwSRvIaGC
 Kk6xL6Zy9OrPGVg8w41D5P/fZi7OTbitGFVY=
X-Received: by 2002:a17:90b:5683:b0:3ab:e789:ce84 with SMTP id
 98e67ed59e1d1-3adeb163656mr6665708a91.65.1793006677548; 
 Mon, 26 Oct 2026 02:24:37 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc2268fsm1437353a12.7.2026.10.26.02.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:24:37 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 0/2] usb: onboard-hub: VL817 support for SpacemiT K1 boards
Date: Mon, 26 Oct 2026 17:24:30 +0800
Message-ID: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Milk-V Jupiter and the Banana Pi BPI-F3 put a VIA Labs VL817 hub in
front of all their USB ports. Its supply and reset are GPIOs, so with
the K1 USB support now in main, `usb start` only finds the root hub
until someone powers the hub by hand.

This adds the VL817 to the onboard hub driver and enables it for K1.

Tested on a Milk-V Jupiter, cold boot from SD: `usb start` finds both
VL817 hubs and a USB 3 stick at 5 Gb/s, with no manual GPIO setup.
For that test, U-Boot was limited to 4 GiB of DRAM: on this 4 GB
board it reports 8 GiB, and with the extra memory `usb start` hung
after "efi_free_pool: illegal free 0x000000027fffa040". That is a
separate K1 DRAM sizing bug; I will send a fix for it on its own.

Hung-Chun Tseng (2):
  usb: onboard-hub: Add support for VIA Labs VL817
  configs: spacemit_k1: Enable onboard USB hub support

 common/usb_onboard_hub.c      | 14 +++++++++++++-
 configs/spacemit_k1_defconfig |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.43.0

