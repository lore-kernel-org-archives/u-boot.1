Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gllcLXHl;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qmv2sUjN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DCDB80E18;
	Wed, 28 Oct 2026 14:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MspIXF360sgw; Wed, 28 Oct 2026 14:48:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15DA081186
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198838;
	b=munNt3GQlbpOAE127ZGRkfPLyOKccs0BUhBwiaUyyn/oUmsjKLPlekffZmykPZFOQp2u
	 MZvqk4KImto4qUAGUUsgj/281twOI32R2BpdDabGv0cFIBDEKNsck5EpzijDc2yU4rTnu
	 tGav1wQfe/I7f9o2dWsSVc0IwaoA2UNfPaR0GIS8+8UVRw0Uq61UmB+e2mWu1uYUxHO+M
	 WZYBpdNxiwK3y7F8PW+Q7pMemVmaKQbfOFbUhWnXgukWGuIrV6+taOgvUxJDVtBQUgt+b
	 gaG1xN7D9sQS9RrqxOyYBdu5G1YkXewxX7DKf98Gjs8yBkIqcxr7FsrLGG1Sgci9u7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sKRWNmtfE0KVqGvi0wtXM4yGoie5RWO5W2jD5c0/mBs=;
	b=ovDbEgVr4+JcWAUTlTDbM/sKizajOfdjZjZRY6+9+T0BlxpzvhZ4DUYgBNyKYtAqsjHD
	 5rq31MKVh8JEc9tGR7w/Rf0i5A4PdIDWXP7OYLV6YQ/Ik1eyEf4oPwOehDm93hnpngroW
	 Ok2dcvRMsDEWQNYjK3LzH/bvJ8Yr5TFrxtmp8tb9v+IiPwtxyF145Wj59UK1Z8DZeDjgV
	 +VsmEXMhDXfXiaN2mk3g/PrzACn5CibmVS4eLBUVnMMSdk7TfDkDo5qnqLHI1NsAYBRaj
	 tAS31nutLkrYDz6iuxpC8Zq5UlbwLSxEuQpPuLtaEKBTiqu8S0r0bVKzsTj9BfOaF5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198838;
	bh=sKRWNmtfE0KVqGvi0wtXM4yGoie5RWO5W2jD5c0/mBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gllcLXHlYogn/RKAtmA6WZxm/jfD/ce7pnZcAJsGkIuuPzcP5LjcvM9u7z8fV7Wb9
	 yn5bI6xZ+nP5kajn9Eyjxy7xFUr07Wmzbt0SniMUoRgCO1rIFduUW1wOExImq2ferC
	 eRjo1X1so896qu3yWwoNFOvoaQNV7L/TmTGDMTAq8u2Hs+FXeLty2TJBo7TnisRRhb
	 by+d4J+uA4ZyGLk28O3Gp/kKgSKfW4PYrGRZh34ff2Vbn5nfklpRkxn0DJcC3usYH/
	 //L/ncam2jZ13yFAgY+pgjNADHxFrlGpg7+A495JQWelH3J/V4Tdap8MtauQ1ue2m2
	 E3+h1An6k0uLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15DA081186;
	Wed, 28 Oct 2026 14:47:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 034AD529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D36256060B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rU3vxKXihh0L for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A37A605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196798;
 b=LiYvg9nbUlmo75kISDcxPr4jx52SpWEtfsKLtoFKlfJQfWNoI2gic2+vvdeKq96O+XXX
 dS9DaVH+3aEJOro1jIuz2TCrN9KlRunszRvEah04+t2nCfPanMRAZM5UsWv7Poc8Riw0b
 MCihGEN0I9LF6OHZUlLtVjHR4kzpi2axvosZ+KbB7VTTCPPVJjHDCeaMj+aht7iLVKpM3
 jXkEy5OLBDOEaA7ksP8Jf8nA98Xw2MDQdlKBm5FEAFUT4/fmt4MQ1cNzYHEeX6GvpadB4
 MrjlGe/Tyge83ZdfQ8LObR1GfP3Axg3bByblAP8wiawvuLo4wyuGkq5JXbiNdfX8SBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196798;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sKRWNmtfE0KVqGvi0wtXM4yGoie5RWO5W2jD5c0/mBs=;
 b=DAZIH4AHqchjn4NwPitVYwJLccBtbqzPWOCKkNkhZOrZYCezFKtJSY/BaLNga05pU+97
 kJthp6Bly/hxDxGcVT0PN9wQwn4QMKDJwGlSrm/OGAAbNvash0ZZy+W0k3ZbYEGVwO+Ab
 2N+wUymEXFcVJz0QWZ8R3nXUe9++PPpI559hEFuv+lhE+pgImMjJAwcVOa4D/vEJ9oT4e
 wt17DcVB11JL0+YFWmPfrC/shXV5bgBRQ4TYSe+NsN8cfxgx9jBNNtXi0d/cTQyujE5Dc
 IpiSrEQYZKTsFyI28ZKh7acDBdJvE4+Oe1lkEBQ3slyPysRwpl3MwdDHycQeeHRJHCw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qmv2sUjN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=qmv2sUjN
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A37A605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:17 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c4021bc8ce6so11744366b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196795; x=1793801595;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKRWNmtfE0KVqGvi0wtXM4yGoie5RWO5W2jD5c0/mBs=;
 b=qmv2sUjNawmAbuT+t8bak83TaA1lQ3gQsOyA2V+NHEuMsH1kEbQ2TzrzzYdvjpkw/b
 sLOc5D84ISJ84OcxYcQrtPpGjopTxfR65m5tn89yXKgBIQTWzxDfCcsb7dcpsoj5eUNu
 Y+ojnmoq111QuCLcDof3h3gPHv7iWr1tLGzXT/RNrYVKwq9wFY0ofSPEMtKOxIvN4Ekc
 LQAzNYVeiF3Bp4yDWNi9VEJ8PwEOz4I653W+cJvSuudbmeS8u37eUMBRq00Q1J5sAS1d
 lssx4GT1pebwLebX9B9KjKRKvAn8Ne0PbxBKcJ8VZhh9o7yXydluQTdKBdsxiyjTRoNc
 w2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196795; x=1793801595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKRWNmtfE0KVqGvi0wtXM4yGoie5RWO5W2jD5c0/mBs=;
 b=j/ziA6dep03HNtesvRmYfX+LfqYHtlyM8TcmGgbo+zZFFHDs5C4W/2eeU/VjsF6XKU
 2La0CJgQ6Qn68Uc5B6AW5q7fTCQ7DpCThD6wcpaFTvpe93ymuo9KyuOkBiyARESGMtF9
 SQzg4Qmf3QxX0nDkuar4UZBkkA5UoxdtsdNp7mIlCNukGfrGKSgP38NusP1vWFaJ00iV
 pc0q+sA/FUaQRJNAFG9JJVExmHSUQSzu6HtVv9HrC1ACNotykHXbNjiPqDIS/kzXeHUO
 jx7Ni6xVTIseV5bn8LzdG3JFeZ9fJXJ8mAxv78bxdTW2qf28cVSYAvsumjZtQ0fPMXl+
 mhGQ==
X-Gm-Message-State: AFq9FYLABQTcNwrgKTwJPLwv5TNnLBBngNvQiShyEBh0giAhWzsnIqLD
 dn7VQJzNyw5col4bWPv3zX1JyucMmoJOdL6LebY6UMSCUhyZyK96x5/XSzDjDxtZEYMjtC9OS/G
 xYR0t
X-Gm-Gg: AYBFou2wZhbn2EkvjIs0iIc5G0xCLQTQwXbR6PoCBLfYZ77wOft0Lp7w0PVsVjAcwUG
 1sfVFcCLL967IoIa05CQwK6lKHs/3Jprrchqr1ZV7/BQmFCzcCBvJ2z/dQFmWYlJcFVxgxAY39B
 kCOt9ZrKZyQ1xqrpyJ3Bibq4czWrzfbU2Qn84OnuyFpF06UrfhYEUiogCBlL2RfchhWFm+W5D03
 tPdHrdu9+To769sKkWE18bfzRmynpKX4pq1hC6cxhI6nb5cblzAjIe5F05v8A0A/rbYk5nNbNw7
 Sg5098RNASxM0Y95CzDKoL4JGZBoTUV4iw9X2HA1LKLlpa/ohsie4CfppPvhaB21HrgXzUfhuiG
 FtyZQ75Ek2vqD5dnX2/khmFRYdMEA14FaAKP7pX83XZLM7Cfmz1upbPZYelvW7qDQxpu7+VPg+w
 IQOanBcHJ6ip9MtkSMG2e/Vhe1igCtNicNkjfFAE7A5atABdavhIB/+MzACtokjo40MgD+PDRsk
 QSVCOqx/Lg2aPd6ZCOwAqW6kYPLKh48yP+fVhbQ0fKuqAIy+abTha02+0it+1Hgw0FVcosSrYsr
 5x8bvfgtVQVoHRGNsgKtoVsI2iLKou81U61UoMsukAEaVMRqV1/Djl9jIy/bY/2NU8F+26L4cNA
 w0ZhjsE/AvA==
X-Received: by 2002:a17:906:18e9:b0:c41:3963:6f1f with SMTP id
 a640c23a62f3a-c49bdeae450mr226282166b.4.1793196795039; 
 Wed, 28 Oct 2026 07:13:15 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:14 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 44/63] usb: dwc3: import from kernel v5.19
Date: Wed, 28 Oct 2026 15:09:10 +0100
Message-ID: <20261028140930.3025368-45-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.18 to v5.19.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.18..v5.19
Commits imported:
5812175389e2 usb: dwc3-am62: remove unnecesary clk_put()
7441b273388b usb: dwc3: gadget: Fix event pending check
8bd6b8c4b100 USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
9c1e916960c1 usb: dwc3: gadget: Fix IN endpoint max packet size allocation
859bdc359567 usb: dwc3: core: Add error log when core soft reset failed
3c5880745b44 usb: dwc3: gadget: Move null pinter check to proper place
9d778f0c5f95 usb: dwc3: Fix ep0 handling when getting reset while doing control transfer
d090c7a2ab84 USB / dwc3: Fix a checkpatch warning in core.c
f66eef8fb898 usb: dwc3: gadget: Delay issuing End Transfer
ace17b6ee4f9 usb: dwc3: gadget: Only End Transfer for ep0 data phase
c96683798e27 usb: dwc3: ep0: Don't prepare beyond Setup stage
8f8034f493b5 usb: dwc3: gadget: Don't modify GEVNTCOUNT in pullup()
861c010a2ee1 usb: dwc3: gadget: Refactor pullup()
69e131d1ac4e usb: dwc3: gadget: Prevent repeat pullup()
4ea150889ad7 usb: dwc3: remove a possible unnecessary 'out of memory' message
bf594d1d0c1d usb: dwc3: gadget: Replace list_for_each_entry_safe() if using giveback
2840d6dfcf43 usb: dwc3: EP clear halt leading to clearing of delayed_status
0f0101719138 usb: dwc3: Don't switch OTG -> peripheral if extcon is present
6a7c7df993bd usb: dwc3: gadget: increase tx fifo size for ss isoc endpoints
0fee30ab6351 USB / dwc3: Fix three doc-build warnings
e8784c0aec03 drivers: usb: dwc3: Add AM62 USB wrapper driver

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c      |  76 ++++++--
 drivers/usb/dwc3/core.h      |   2 +
 drivers/usb/dwc3/dwc3-am62.c | 328 +++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/ep0.c       |  14 +-
 drivers/usb/dwc3/gadget.c    | 220 ++++++++++++++---------
 drivers/usb/dwc3/gadget.h    |   2 +
 6 files changed, 538 insertions(+), 104 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d28cd1a6709b..573421984948 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
@@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 		 * mode. If the controller supports DRD but the dr_mode is not
 		 * specified or set to OTG, then set the mode to peripheral.
 		 */
-		if (mode == USB_DR_MODE_OTG &&
+		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
 		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
 		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
 		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
@@ -297,6 +298,7 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 			udelay(1);
 	} while (--retries);
 
+	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
 	return -ETIMEDOUT;
 
 done:
@@ -342,7 +344,6 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
  *		from the default, this will set clock period in DWC3_GUCTL
  *		register.
  * @dwc: Pointer to our controller context structure
- * @ref_clk_per: reference clock period in ns
  */
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
@@ -964,10 +965,8 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 		return;
 
 	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
-	if (!vals) {
-		dev_err(dev, "Error to get memory\n");
+	if (!vals)
 		return;
-	}
 
 	/* Get INCR burst type, and parse it */
 	ret = device_property_read_u32_array(dev,
@@ -1268,40 +1267,36 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 
 	if (IS_ERR(dwc->usb2_phy)) {
 		ret = PTR_ERR(dwc->usb2_phy);
-		if (ret == -ENXIO || ret == -ENODEV) {
+		if (ret == -ENXIO || ret == -ENODEV)
 			dwc->usb2_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-		}
 	}
 
 	if (IS_ERR(dwc->usb3_phy)) {
 		ret = PTR_ERR(dwc->usb3_phy);
-		if (ret == -ENXIO || ret == -ENODEV) {
+		if (ret == -ENXIO || ret == -ENODEV)
 			dwc->usb3_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-		}
 	}
 
 	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
 	if (IS_ERR(dwc->usb2_generic_phy)) {
 		ret = PTR_ERR(dwc->usb2_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV) {
+		if (ret == -ENOSYS || ret == -ENODEV)
 			dwc->usb2_generic_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-		}
 	}
 
 	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
 	if (IS_ERR(dwc->usb3_generic_phy)) {
 		ret = PTR_ERR(dwc->usb3_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV) {
+		if (ret == -ENOSYS || ret == -ENODEV)
 			dwc->usb3_generic_phy = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-		}
 	}
 
 	return 0;
@@ -1633,6 +1628,46 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	}
 }
 
+static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	struct device_node *np_phy;
+	struct extcon_dev *edev = NULL;
+	const char *name;
+
+	if (device_property_read_bool(dev, "extcon"))
+		return extcon_get_edev_by_phandle(dev, 0);
+
+	/*
+	 * Device tree platforms should get extcon via phandle.
+	 * On ACPI platforms, we get the name from a device property.
+	 * This device property is for kernel internal use only and
+	 * is expected to be set by the glue code.
+	 */
+	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
+		return extcon_get_extcon_dev(name);
+
+	/*
+	 * Try to get an extcon device from the USB PHY controller's "port"
+	 * node. Check if it has the "port" node first, to avoid printing the
+	 * error message from underlying code, as it's a valid case: extcon
+	 * device (and "port" node) may be missing in case of "usb-role-switch"
+	 * or OTG mode.
+	 */
+	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
+	if (of_graph_is_present(np_phy)) {
+		struct device_node *np_conn;
+
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+		if (np_conn)
+			edev = extcon_find_edev_by_node(np_conn);
+		of_node_put(np_conn);
+	}
+	of_node_put(np_phy);
+
+	return edev;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -1768,6 +1803,13 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	dwc->edev = dwc3_get_extcon(dwc);
+	if (IS_ERR(dwc->edev)) {
+		ret = PTR_ERR(dwc->edev);
+		dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
+		goto err3;
+	}
+
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
 		goto err3;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5c9d467195a6..81c486b3941c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1046,6 +1046,7 @@ struct dwc3_scratchpad_array {
  * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
  * @tx_max_burst_prd: max periodic ESS transmit burst size
  * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
+ * @clear_stall_protocol: endpoint number that requires a delayed status phase
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
  * @softconnect: true when gadget connect is called, false when disconnect runs
@@ -1266,6 +1267,7 @@ struct dwc3 {
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
 	u8			tx_fifo_resize_max_num;
+	u8			clear_stall_protocol;
 
 	const char		*hsphy_interface;
 
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
new file mode 100644
index 000000000000..173cf3579c55
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dwc3-am62.c - TI specific Glue layer for AM62 DWC3 USB Controller
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/pinctrl/consumer.h>
+
+/* USB WRAPPER register offsets */
+#define USBSS_PID			0x0
+#define USBSS_OVERCURRENT_CTRL		0x4
+#define USBSS_PHY_CONFIG		0x8
+#define USBSS_PHY_TEST			0xc
+#define USBSS_CORE_STAT			0x14
+#define USBSS_HOST_VBUS_CTRL		0x18
+#define USBSS_MODE_CONTROL		0x1c
+#define USBSS_WAKEUP_CONFIG		0x30
+#define USBSS_WAKEUP_STAT		0x34
+#define USBSS_OVERRIDE_CONFIG		0x38
+#define USBSS_IRQ_MISC_STATUS_RAW	0x430
+#define USBSS_IRQ_MISC_STATUS		0x434
+#define USBSS_IRQ_MISC_ENABLE_SET	0x438
+#define USBSS_IRQ_MISC_ENABLE_CLR	0x43c
+#define USBSS_IRQ_MISC_EOI		0x440
+#define USBSS_INTR_TEST			0x490
+#define USBSS_VBUS_FILTER		0x614
+#define USBSS_VBUS_STAT			0x618
+#define USBSS_DEBUG_CFG			0x708
+#define USBSS_DEBUG_DATA		0x70c
+#define USBSS_HOST_HUB_CTRL		0x714
+
+/* PHY CONFIG register bits */
+#define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
+#define USBSS_PHY_VBUS_SEL_SHIFT	1
+#define USBSS_PHY_LANE_REVERSE		BIT(0)
+
+/* MODE CONTROL register bits */
+#define USBSS_MODE_VALID	BIT(0)
+
+/* WAKEUP CONFIG register bits */
+#define USBSS_WAKEUP_CFG_OVERCURRENT_EN	BIT(3)
+#define USBSS_WAKEUP_CFG_LINESTATE_EN	BIT(2)
+#define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
+#define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
+
+/* WAKEUP STAT register bits */
+#define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
+#define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
+#define USBSS_WAKEUP_STAT_SESSVALID	BIT(2)
+#define USBSS_WAKEUP_STAT_VBUSVALID	BIT(1)
+#define USBSS_WAKEUP_STAT_CLR		BIT(0)
+
+/* IRQ_MISC_STATUS_RAW register bits */
+#define USBSS_IRQ_MISC_RAW_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_RAW_SESSVALID	BIT(20)
+
+/* IRQ_MISC_STATUS register bits */
+#define USBSS_IRQ_MISC_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_SESSVALID	BIT(20)
+
+/* IRQ_MISC_ENABLE_SET register bits */
+#define USBSS_IRQ_MISC_ENABLE_SET_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_ENABLE_SET_SESSVALID	BIT(20)
+
+/* IRQ_MISC_ENABLE_CLR register bits */
+#define USBSS_IRQ_MISC_ENABLE_CLR_VBUSVALID	BIT(22)
+#define USBSS_IRQ_MISC_ENABLE_CLR_SESSVALID	BIT(20)
+
+/* IRQ_MISC_EOI register bits */
+#define USBSS_IRQ_MISC_EOI_VECTOR	BIT(0)
+
+/* VBUS_STAT register bits */
+#define USBSS_VBUS_STAT_SESSVALID	BIT(2)
+#define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
+
+/* Mask for PHY PLL REFCLK */
+#define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
+
+#define DWC3_AM62_AUTOSUSPEND_DELAY	100
+
+struct dwc3_data {
+	struct device *dev;
+	void __iomem *usbss;
+	struct clk *usb2_refclk;
+	int rate_code;
+	struct regmap *syscon;
+	unsigned int offset;
+	unsigned int vbus_divider;
+};
+
+static const int dwc3_ti_rate_table[] = {	/* in KHZ */
+	9600,
+	10000,
+	12000,
+	19200,
+	20000,
+	24000,
+	25000,
+	26000,
+	38400,
+	40000,
+	58000,
+	50000,
+	52000,
+};
+
+static inline u32 dwc3_ti_readl(struct dwc3_data *data, u32 offset)
+{
+	return readl((data->usbss) + offset);
+}
+
+static inline void dwc3_ti_writel(struct dwc3_data *data, u32 offset, u32 value)
+{
+	writel(value, (data->usbss) + offset);
+}
+
+static int phy_syscon_pll_refclk(struct dwc3_data *data)
+{
+	struct device *dev = data->dev;
+	struct device_node *node = dev->of_node;
+	struct of_phandle_args args;
+	struct regmap *syscon;
+	int ret;
+
+	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-phy-pll-refclk");
+	if (IS_ERR(syscon)) {
+		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
+		return PTR_ERR(syscon);
+	}
+
+	data->syscon = syscon;
+
+	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-phy-pll-refclk", 1,
+					       0, &args);
+	if (ret)
+		return ret;
+
+	data->offset = args.args[0];
+
+	ret = regmap_update_bits(data->syscon, data->offset, PHY_PLL_REFCLK_MASK, data->rate_code);
+	if (ret) {
+		dev_err(dev, "failed to set phy pll reference clock rate\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dwc3_ti_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct dwc3_data *data;
+	int i, ret;
+	unsigned long rate;
+	u32 reg;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	platform_set_drvdata(pdev, data);
+
+	data->usbss = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->usbss)) {
+		dev_err(dev, "can't map IOMEM resource\n");
+		return PTR_ERR(data->usbss);
+	}
+
+	data->usb2_refclk = devm_clk_get(dev, "ref");
+	if (IS_ERR(data->usb2_refclk)) {
+		dev_err(dev, "can't get usb2_refclk\n");
+		return PTR_ERR(data->usb2_refclk);
+	}
+
+	/* Calculate the rate code */
+	rate = clk_get_rate(data->usb2_refclk);
+	rate /= 1000;	// To KHz
+	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
+		if (dwc3_ti_rate_table[i] == rate)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(dwc3_ti_rate_table)) {
+		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
+		return -EINVAL;
+	}
+
+	data->rate_code = i;
+
+	/* Read the syscon property and set the rate code */
+	ret = phy_syscon_pll_refclk(data);
+	if (ret)
+		return ret;
+
+	/* VBUS divider select */
+	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
+	reg = dwc3_ti_readl(data, USBSS_PHY_CONFIG);
+	if (data->vbus_divider)
+		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
+
+	dwc3_ti_writel(data, USBSS_PHY_CONFIG, reg);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	/*
+	 * Don't ignore its dependencies with its children
+	 */
+	pm_suspend_ignore_children(dev, false);
+	clk_prepare_enable(data->usb2_refclk);
+	pm_runtime_get_noresume(dev);
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to create dwc3 core: %d\n", ret);
+		goto err_pm_disable;
+	}
+
+	/* Set mode valid bit to indicate role is valid */
+	reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
+	reg |= USBSS_MODE_VALID;
+	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
+
+	/* Setting up autosuspend */
+	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return 0;
+
+err_pm_disable:
+	clk_disable_unprepare(data->usb2_refclk);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	return ret;
+}
+
+static int dwc3_ti_remove_core(struct device *dev, void *c)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+	return 0;
+}
+
+static int dwc3_ti_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc3_data *data = platform_get_drvdata(pdev);
+	u32 reg;
+
+	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
+
+	/* Clear mode valid bit */
+	reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
+	reg &= ~USBSS_MODE_VALID;
+	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
+
+	pm_runtime_put_sync(dev);
+	clk_disable_unprepare(data->usb2_refclk);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int dwc3_ti_suspend_common(struct device *dev)
+{
+	struct dwc3_data *data = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(data->usb2_refclk);
+
+	return 0;
+}
+
+static int dwc3_ti_resume_common(struct device *dev)
+{
+	struct dwc3_data *data = dev_get_drvdata(dev);
+
+	clk_prepare_enable(data->usb2_refclk);
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(dwc3_ti_pm_ops, dwc3_ti_suspend_common,
+			    dwc3_ti_resume_common, NULL);
+
+#define DEV_PM_OPS	(&dwc3_ti_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM */
+
+static const struct of_device_id dwc3_ti_of_match[] = {
+	{ .compatible = "ti,am62-usb"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
+
+static struct platform_driver dwc3_ti_driver = {
+	.probe		= dwc3_ti_probe,
+	.remove		= dwc3_ti_remove,
+	.driver		= {
+		.name	= "dwc3-am62",
+		.pm	= DEV_PM_OPS,
+		.of_match_table = dwc3_ti_of_match,
+	},
+};
+
+module_platform_driver(dwc3_ti_driver);
+
+MODULE_ALIAS("platform:dwc3-am62");
+MODULE_AUTHOR("Aswath Govindraju <a-govindraju@ti.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DesignWare USB3 TI Glue Layer");
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 1064be5518f6..5d642660fd15 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -218,7 +218,7 @@ out:
 	return ret;
 }
 
-static void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
 
@@ -813,7 +813,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->connected)
 		goto out;
 
 	trace_dwc3_ctrl_req(ctrl);
@@ -1080,6 +1080,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
 	unsigned int direction = !dwc->ep0_expect_in;
 
 	dwc->delayed_status = false;
+	dwc->clear_stall_protocol = 0;
 
 	if (dwc->ep0state != EP0_STATUS_PHASE)
 		return;
@@ -1087,13 +1088,18 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
 	__dwc3_ep0_do_control_status(dwc, dwc->eps[direction]);
 }
 
-static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	u32			cmd;
 	int			ret;
 
-	if (!dep->resource_index)
+	/*
+	 * For status/DATA OUT stage, TRB will be queued on ep0 out
+	 * endpoint for which resource index is zero. Hence allow
+	 * queuing ENDXFER command for ep0 out endpoint.
+	 */
+	if (!dep->resource_index && dep->number)
 		return;
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0b9c2493844a..0d89dfa6eef5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -657,7 +657,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
- * @nfifos: number of fifos to calculate for
  *
  * Calculates the size value based on the equation below:
  *
@@ -690,7 +689,7 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
 }
 
 /**
- * dwc3_gadget_clear_tx_fifo_size - Clears txfifo allocation
+ * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
  * @dwc: pointer to the DWC3 context
  *
  * Iterates through all the endpoint registers and clears the previous txfifo
@@ -783,7 +782,8 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 		num_fifos = 3;
 
 	if (dep->endpoint.maxburst > 6 &&
-	    usb_endpoint_xfer_bulk(dep->endpoint.desc) && DWC3_IP_IS(DWC31))
+	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
 		num_fifos = dwc->tx_fifo_resize_max_num;
 
 	/* FIFO size for a single buffer */
@@ -882,12 +882,13 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+		dep->trb_dequeue = 0;
+		dep->trb_enqueue = 0;
+
 		if (usb_endpoint_xfer_control(desc))
 			goto out;
 
 		/* Initialize the TRB ring */
-		dep->trb_dequeue = 0;
-		dep->trb_enqueue = 0;
 		memset(dep->trb_pool, 0,
 		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
 
@@ -2001,10 +2002,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
 static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
-	struct dwc3_request		*tmp;
 	struct dwc3			*dwc = dep->dwc;
 
-	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
+	while (!list_empty(&dep->cancelled_list)) {
+		req = next_request(&dep->cancelled_list);
 		dwc3_gadget_ep_skip_trbs(dep, req);
 		switch (req->status) {
 		case DWC3_REQUEST_STATUS_DISCONNECTED:
@@ -2021,6 +2022,12 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 			dwc3_gadget_giveback(dep, req, -ECONNRESET);
 			break;
 		}
+		/*
+		 * The endpoint is disabled, let the dwc3_remove_requests()
+		 * handle the cleanup.
+		 */
+		if (!dep->endpoint.desc)
+			break;
 	}
 }
 
@@ -2056,16 +2063,6 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		if (r == req) {
 			struct dwc3_request *t;
 
-			/*
-			 * If a Setup packet is received but yet to DMA out, the controller will
-			 * not process the End Transfer command of any endpoint. Polling of its
-			 * DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
-			 * timeout. Delay issuing the End Transfer command until the Setup TRB is
-			 * prepared.
-			 */
-			if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status)
-				dep->flags |= DWC3_EP_DELAY_STOP;
-
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dep, true, true);
 
@@ -2152,6 +2149,9 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
 		    (dep->flags & DWC3_EP_DELAY_STOP)) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
+			if (protocol)
+				dwc->clear_stall_protocol = dep->number;
+
 			return 0;
 		}
 
@@ -2498,27 +2498,63 @@ static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
 static void __dwc3_gadget_stop(struct dwc3 *dwc);
 static int __dwc3_gadget_start(struct dwc3 *dwc);
 
-static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
+static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 {
-	struct dwc3		*dwc = gadget_to_dwc(g);
-	unsigned long		flags;
-	int			ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->connected = false;
 
-	is_on = !!is_on;
-	dwc->softconnect = is_on;
 	/*
 	 * Per databook, when we want to stop the gadget, if a control transfer
 	 * is still in process, complete it and get the core into setup phase.
 	 */
-	if (!is_on && dwc->ep0state != EP0_SETUP_PHASE) {
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		int ret;
+
 		reinit_completion(&dwc->ep0_in_setup);
 
+		spin_unlock_irqrestore(&dwc->lock, flags);
 		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
 				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
+		spin_lock_irqsave(&dwc->lock, flags);
 		if (ret == 0)
 			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
 	}
 
+	/*
+	 * In the Synopsys DesignWare Cores USB3 Databook Rev. 3.30a
+	 * Section 4.1.8 Table 4-7, it states that for a device-initiated
+	 * disconnect, the SW needs to ensure that it sends "a DEPENDXFER
+	 * command for any active transfers" before clearing the RunStop
+	 * bit.
+	 */
+	dwc3_stop_active_transfers(dwc);
+	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	/*
+	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
+	 * driver needs to acknowledge them before the controller can halt.
+	 * Simply let the interrupt handler acknowledges and handle the
+	 * remaining event generated by the controller while polling for
+	 * DSTS.DEVCTLHLT.
+	 */
+	return dwc3_gadget_run_stop(dwc, false, false);
+}
+
+static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	int			ret;
+
+	is_on = !!is_on;
+
+	if (dwc->pullups_connected == is_on)
+		return 0;
+
+	dwc->softconnect = is_on;
+
 	/*
 	 * Avoid issuing a runtime resume if the device is already in the
 	 * suspended state during gadget disconnect.  DWC3 gadget was already
@@ -2541,42 +2577,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
-	/*
-	 * Synchronize and disable any further event handling while controller
-	 * is being enabled/disabled.
-	 */
-	disable_irq(dwc->irq_gadget);
-
-	spin_lock_irqsave(&dwc->lock, flags);
-
 	if (!is_on) {
-		u32 count;
-
-		dwc->connected = false;
-		/*
-		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
-		 * Section 4.1.8 Table 4-7, it states that for a device-initiated
-		 * disconnect, the SW needs to ensure that it sends "a DEPENDXFER
-		 * command for any active transfers" before clearing the RunStop
-		 * bit.
-		 */
-		dwc3_stop_active_transfers(dwc);
-		__dwc3_gadget_stop(dwc);
-
-		/*
-		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
-		 * Section 1.3.4, it mentions that for the DEVCTRLHLT bit, the
-		 * "software needs to acknowledge the events that are generated
-		 * (by writing to GEVNTCOUNTn) while it is waiting for this bit
-		 * to be set to '1'."
-		 */
-		count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
-		count &= DWC3_GEVNTCOUNT_MASK;
-		if (count > 0) {
-			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
-			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
-						dwc->ev_buf->length;
-		}
+		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
 		/*
 		 * In the Synopsys DWC_usb31 1.90a programming guide section
@@ -2584,18 +2586,13 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		 * device-initiated disconnect requires a core soft reset
 		 * (DCTL.CSftRst) before enabling the run/stop bit.
 		 */
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		dwc3_core_soft_reset(dwc);
-		spin_lock_irqsave(&dwc->lock, flags);
 
 		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
+		ret = dwc3_gadget_run_stop(dwc, true, false);
 	}
 
-	ret = dwc3_gadget_run_stop(dwc, is_on, false);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-	enable_irq(dwc->irq_gadget);
-
 	pm_runtime_put(dwc->dev);
 
 	return ret;
@@ -2745,6 +2742,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->ep0_bounced = false;
 	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc->delayed_status = false;
 	dwc3_ep0_out_start(dwc);
@@ -2978,6 +2976,7 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	struct dwc3 *dwc = dep->dwc;
 	u32 mdwidth;
 	int size;
+	int maxpacket;
 
 	mdwidth = dwc3_mdwidth(dwc);
 
@@ -2990,21 +2989,24 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	else
 		size = DWC31_GTXFIFOSIZ_TXFDEP(size);
 
-	/* FIFO Depth is in MDWDITH bytes. Multiply */
-	size *= mdwidth;
-
 	/*
-	 * To meet performance requirement, a minimum TxFIFO size of 3x
-	 * MaxPacketSize is recommended for endpoints that support burst and a
-	 * minimum TxFIFO size of 2x MaxPacketSize for endpoints that don't
-	 * support burst. Use those numbers and we can calculate the max packet
-	 * limit as below.
+	 * maxpacket size is determined as part of the following, after assuming
+	 * a mult value of one maxpacket:
+	 * DWC3 revision 280A and prior:
+	 * fifo_size = mult * (max_packet / mdwidth) + 1;
+	 * maxpacket = mdwidth * (fifo_size - 1);
+	 *
+	 * DWC3 revision 290A and onwards:
+	 * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+	 * maxpacket = mdwidth * ((fifo_size - 1) - 1) - mdwidth;
 	 */
-	if (dwc->maximum_speed >= USB_SPEED_SUPER)
-		size /= 3;
+	if (DWC3_VER_IS_PRIOR(DWC3, 290A))
+		maxpacket = mdwidth * (size - 1);
 	else
-		size /= 2;
+		maxpacket = mdwidth * ((size - 1) - 1) - mdwidth;
 
+	/* Functionally, space for one max packet is sufficient */
+	size = min_t(int, maxpacket, 1024);
 	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
 	dep->endpoint.max_streams = 16;
@@ -3333,15 +3335,21 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event, int status)
 {
 	struct dwc3_request	*req;
-	struct dwc3_request	*tmp;
 
-	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
+	while (!list_empty(&dep->started_list)) {
 		int ret;
 
+		req = next_request(&dep->started_list);
 		ret = dwc3_gadget_ep_cleanup_completed_request(dep, event,
 				req, status);
 		if (ret)
 			break;
+		/*
+		 * The endpoint is disabled, let the dwc3_remove_requests()
+		 * handle the cleanup.
+		 */
+		if (!dep->endpoint.desc)
+			break;
 	}
 }
 
@@ -3380,14 +3388,14 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
 
-	if (!dep->endpoint.desc)
-		return no_started_trb;
-
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
 		goto out;
 
+	if (!dep->endpoint.desc)
+		return no_started_trb;
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		list_empty(&dep->started_list) &&
 		(list_empty(&dep->pending_list) || status == -EXDEV))
@@ -3512,7 +3520,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
 		}
 
 		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
-		if (dwc->delayed_status)
+		if (dwc->clear_stall_protocol == dep->number)
 			dwc3_ep0_send_delayed_status(dwc);
 	}
 
@@ -3673,11 +3681,34 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
+	struct dwc3 *dwc = dep->dwc;
+
+	/*
+	 * Only issue End Transfer command to the control endpoint of a started
+	 * Data Phase. Typically we should only do so in error cases such as
+	 * invalid/unexpected direction as described in the control transfer
+	 * flow of the programming guide.
+	 */
+	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
+		return;
+
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
 	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
+	/*
+	 * If a Setup packet is received but yet to DMA out, the controller will
+	 * not process the End Transfer command of any endpoint. Polling of its
+	 * DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
+	 * timeout. Delay issuing the End Transfer command until the Setup TRB is
+	 * prepared.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status) {
+		dep->flags |= DWC3_EP_DELAY_STOP;
+		return;
+	}
+
 	/*
 	 * NOTICE: We are violating what the Databook says about the
 	 * EndTransfer command. Ideally we would _always_ wait for the
@@ -3795,6 +3826,27 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	}
 
 	dwc3_reset_gadget(dwc);
+
+	/*
+	 * From SNPS databook section 8.1.2, the EP0 should be in setup
+	 * phase. So ensure that EP0 is in setup phase by issuing a stall
+	 * and restart if EP0 is not in setup phase.
+	 */
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		unsigned int	dir;
+
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+
+		dwc->eps[0]->trb_enqueue = 0;
+		dwc->eps[1]->trb_enqueue = 0;
+
+		dwc3_ep0_stall_and_restart(dwc);
+	}
+
 	/*
 	 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
 	 * Section 4.1.2 Table 4-2, it states that during a USB reset, the SW
@@ -4197,7 +4249,6 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	}
 
 	evt->count = 0;
-	evt->flags &= ~DWC3_EVENT_PENDING;
 	ret = IRQ_HANDLED;
 
 	/* Unmask interrupt */
@@ -4209,6 +4260,9 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
 	}
 
+	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
+	evt->flags &= ~DWC3_EVENT_PENDING;
+
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index f763380e672e..55a56cf67d73 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -110,6 +110,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event);
 void dwc3_ep0_out_start(struct dwc3 *dwc);
+void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep);
+void dwc3_ep0_stall_and_restart(struct dwc3 *dwc);
 int __dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_set_halt(struct usb_ep *ep, int value);
 int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
-- 
2.53.0

