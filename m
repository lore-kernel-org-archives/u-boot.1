Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31035606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OhfYATZs;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ded7LXtT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01BA5810BB;
	Wed, 28 Oct 2026 14:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sw0onOEvcVyT; Wed, 28 Oct 2026 14:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4EF38100D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198776;
	b=BzbMexaiY7DKBzchcNi7nDI+kd/71PyNXfjvUl8B3bHB5z/zNoXFUZ+Jh1zcyAR2k/L5
	 ONcjwxqVRcVXlwPDJ2d7MQt4i2uGFJ0HMmu8QmQA9grSfsDDufsYCREV616C4X2RrGL5F
	 dyAKufmPqaQmPe7nDvK1dyw6vZwRHHKXTQCJxQi4JWWGFPEV2xUaq4kdK1Ucn4pjTQhIZ
	 +fspSnCLQ9mhqzua1MJ8ZGRhKmgUbe1kBAxjTvdu+UojfAdPuUsgSmCeMCfcBT4BV3K0p
	 8LFkKCpkLIQnizVupa7dJrcId5mx6HseDIuVOkMnkACfbn+CoeSBZDR0vLndWdWNqfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Px0YYpgfm/0dAxCxKpewhsH4sYEiH5fqX9sF216vj1g=;
	b=VvKQpdD1ksbp/0XwkJPmkcj+3dIpbdpI+yY90k68guo3/s7BZ1LKi6h7UDV2deLcVr7w
	 10UjswKqDP1257O97nZZDqYWGvfo8nOy9zgySBEUrJZ+gcuebz/kfDs3EvKQu2pVCcsvs
	 fdp2tudqFQm9o5YqRNTR710Csgn5Ry2BYQPzeb5ESSzw8xogPlCPXMDbFsA1SBnJjuXCl
	 WrJXbXZdTvQvfCxd7L8ShGeZW86eWNaJFbLfg6KGV/zEfmeKMDgbBGPqUvZSp2gBQDO/P
	 XhYWbq3mBr4nymUw839COzs8oKEjZdyXn16G11mD3GRWiYOFtwsGJKXnx24ZvM9Zxyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ded7LXtT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198776;
	bh=Px0YYpgfm/0dAxCxKpewhsH4sYEiH5fqX9sF216vj1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhfYATZsQZiWaAQPF/M5BQOgWx5wlbbNw5+H9/bBE52aXgGNB2ickepb9g28Cbbq4
	 goowjFBRUwVEti5z1+NPWlk4RuHh+FAgk1pimYZqbLhC9GMTXUQCPJ7Tf+xZGEDqa2
	 dB5dN5QaH8M+YdgX9eI1XQ6IDjXW+5xj9EewUcbTRc4lzVeCVdvokEDwiuUguZIcz6
	 ba7kJlA9wPN2REGBPCjDyWwnC9zrJ2p4/XIGiQv8KgGp3jVLBLDzRHcokjESnXO7Vo
	 IUC0oMEiSDOv6TJApHip7DCxq+0+KkHRAfMptpKjGkCggx0NHM7hMMyHfnD3Zt0C1Q
	 uQj7yH+rfBEmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4EF38100D;
	Wed, 28 Oct 2026 14:46:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B228235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C7DF80BE2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QH5jyzTY0kn for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:10:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 726EA80BDF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196659;
 b=Tp2sjl2f7LO+Pyk2KpwKIQg4U10EXpB2j5tCqn07OXdIadd8uzKdO+tfZO+3LEel6tYY
 9AaosXh88H5YuTwSU0fais0R3YVm317JJODcdx31T3/L2okApCSqLY2unv9BwKeH7xYnz
 uRiW0DdstB4OLMbfY0kVIRe5dQlYPfL7ntsmwafE5aBrfa8h5WUAyQlWsZQ3wPlKHKjYj
 EQmBWGBs7uzRRHdTUUgKukBB4RtSB9MXQ7nNye8vQKb94RU6pm9n+ZKdL4uqogBubKLI9
 +W11r0fp6eJt/537cs15fdyKtLeqGwFnb2SJiVPgjv6HK0XGqxpXYYnlrNUMhO88pjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196659;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Px0YYpgfm/0dAxCxKpewhsH4sYEiH5fqX9sF216vj1g=;
 b=QEpkkqAk8BEpNF3d7WAaHu6AlZQ01dizI9B00fUc1kq51yQLFkbTrjDUKWwt0t7LcR1y
 6x/CL5C1GOKuaOnphAyCB+PfOL8nwuA6luRMPWTwGl98xGWWQV905YPR1Wfqc9sH191CA
 hoCewrilOgXmOD7oGdhn+PnBJ0PyEWal/qALzz7Z6L5vSA/1x6gN+VSAOwpgVA1wAZPX2
 UYYqqvFHKeep59kopk2GAZpIy/LA1RGTFviLxhqTlDfJ0sZrDXdCbHzUJARY/b7qjIi9k
 qDzmiXs+0tThPKAvNEnVJp0hbG3iFQmJjpRP7eQhxy4B1exaBn0g/8nj//w9iEKvVSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ded7LXtT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ded7LXtT
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 726EA80BDF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:57 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6ae14ee2d0bso204148a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196656; x=1793801456;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Px0YYpgfm/0dAxCxKpewhsH4sYEiH5fqX9sF216vj1g=;
 b=ded7LXtTWRL2D0zgOIX8OmJqtWkpyVvsyEi25DcVo2/XlI7WBWU8JS5kJcVoxuJofA
 V5uRjnC1RK9T8HIKAe223NSrIpHoGLmJPR6DS1Q3vVniVVqZEuVC3axe+pQEUmpRuI/f
 6S9OtaN0b+T1/wNUqE4itBCwYHTOpkvkcAv/qiUbxduAZrmP2wgyPb263+UDgHoHXEYt
 U3uXYho2Q4wEUGOyXwUA1RRHVoyYgL3etMe8zMip+061JUp2n4pHQpw3kDzQM8HyVxKE
 85XZD+OEfUTSvKt/JKatBcelkUAtWMdhTxAntvnKHPa9hogaD9T2q7O5nqhUyukhTtMp
 PyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196656; x=1793801456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Px0YYpgfm/0dAxCxKpewhsH4sYEiH5fqX9sF216vj1g=;
 b=0lXHJyzwhGvjnYDF1QVlnIAtiQjH5GKtG4NlhRZe39/SXSoELOgS41M3T2uq7mLJJm
 76eWssrKMQNt3nOGXMbPfOlqOM8IByTrE2q3SYpDqE0IU7Hf2kjnkJkWOlq37OE7OHpQ
 NR9cj5V41NpJwa/QJ2ZZ3xA46r0GOFubWLiUeQBvrh4qFE36R9zCt4J50cdEQAvfzIUr
 RHPTbwQeFI5JnNrgtd2Tlt2Yg43TsGAO8MsRff7qZATRO17W1bHICCPF8jyUDPht127y
 WH903F2VNH9JhgY03fTsw7w2xeKMvWjekLkGvlxmNuIbaSTUvZMhNgh0eZEYNYN1X8uF
 DFng==
X-Gm-Message-State: AFq9FYL417jKsOo/gUcq2xKinoH3kOMSIUT+3PxUQlKS5NG+FqIRtVTb
 YMw69bKtNXxk3uFgsi2K+Fm4B9Kw+hlXIDqalPk4gDQEicRJo6gEhJcfXbaSwQCITQ2cu07dAAh
 FuMMb
X-Gm-Gg: AYBFou2Mfc6fiqPHvb507wSU1XpyILpdeYT+oOw8LfGPqTLthOVjxeo5eNcm8TsYm+A
 AZhfHyIn++Y10CkFKw3ftw4NMQFP9g65QH5EOPKrLzrE2BrpyxPlnP23B5NbJlW/vjVxKIOwBih
 I6Pxek97jTzRy55j4Xwi0dpOR7HcodXAcl3XVWHrthEQkewKon7Z309UKdhZRJDnP936ZoCeyqc
 lK0Lsbzno3mWqJvKYeuMGFwHidW+7tD7X6W8xIEKRa5RaHww45h4HcK7x815LIS3erchQmKc8W+
 7vi30fgHsW1QgekTFudQOutqUjQbZ0k9wcc3zcnxN+31AmZyvONYZ8gDpvkXcZaBjJhzSRAbVgE
 sJ3acCGOlHohizkseK3kZ3869Vl3VQo8gDLUKHVFNEYdNRHXEQ2An2GhTcoTV+yzzOKF4dYZZGl
 baW8Q1Ab+w8aX4LQYMYmH8IoSJYjv2R6ivvkGXikprSRo65lfW4RXrRWvhc8bh2FIf9CK7t26vv
 odCEKQjC4S1Mzznm0gyLu0Ux1Jyx2uBPJvMw39sgqaZpq+fYJ6yfarE7h4hCgaeWrMl/PNMNh+B
 8TvnV8Y3CSLK80DMS0Im5YVl+Z3gNknWoXK/RUgh784m84GJwiMikiCKa+u1rIhJ/4SGVjPLgSJ
 JDr5c71u2Zg==
X-Received: by 2002:a17:906:5192:10b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c49bdee7e16mr260786566b.4.1793196655660; 
 Wed, 28 Oct 2026 07:10:55 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:10:55 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 13/63] usb: dwc3: import from kernel v4.9
Date: Wed, 28 Oct 2026 15:08:39 +0100
Message-ID: <20261028140930.3025368-14-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.8 to v4.9.

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

List of commits: git log --oneline v4.8..v4.9
Commits imported:
9b9d7cdd0a20 usb: dwc3: Fix error handling for core init
51fbc7c06c89 usb: dwc3: Fix size used in dma_free_coherent()
d889c23ce4e3 usb: dwc3: gadget: never pre-start Isochronous endpoints
a9c3ca5fae6b usb: dwc3: gadget: properly account queued requests
5e6c88d28ccb usb: dwc3: fix Clear Stall EP command failure
d6e10bf2ba47 usb: dwc3: avoid -Wmaybe-uninitialized warning
9d6173e125d9 usb: dwc3: Fix dr_mode validation
594e121f2568 usb: dwc3: gadget: stop kicking if we run out of space
7ae7df4982af usb: dwc3: gadget: abolish trbs_left
06281d460fc5 usb: dwc3: Add ENDXFER command polling
512e47572f7d usb: dwc3: Add revision numbers for the USB 3.0 IP
00af62330c39 usb: dwc3: core: Move the mode setting to the right place
00fe081dc3a3 usb: dwc3: add dis_del_phy_power_chg_quirk
32f2ed864dd5 usb: dwc3: make usb2 phy utmi interface configurable
16199f338939 usb: dwc3: add dis_u2_freeclk_exists_quirk
dc55c67e9c95 usb: dwc3: gadget: improve increment request->actual
f99f53f24d87 usb: dwc3: gadget: remove condition that never happens
1f512119a08c usb: dwc3: gadget: add remaining sg entries to ring
2c78c0295fd8 usb: dwc3: gadget: interrupt on ring full too
0b3e4af3c740 usb: dwc3: gadget: add sg and num_pending_sgs to dwc3_request
31162af447d7 usb: dwc3: gadget: avoid while (1) loop on completion
08a36b543803 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
45438a0cd9c2 usb: dwc3: gadget: simplify dwc3_ep_prev_trb()
737f1ae2556a usb: dwc3: gadget: increment dequeue pointer on completion
4bc48c974708 usb: dwc3: gadget: retire LST bit completely

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 127 ++++++++++++++---
 drivers/usb/dwc3/core.h   |  35 ++++-
 drivers/usb/dwc3/gadget.c | 292 +++++++++++++++-----------------------
 3 files changed, 258 insertions(+), 196 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 35d092456bec..fea446900cad 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -49,6 +49,57 @@
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
+/**
+ * dwc3_get_dr_mode - Validates and sets dr_mode
+ * @dwc: pointer to our context structure
+ */
+static int dwc3_get_dr_mode(struct dwc3 *dwc)
+{
+	enum usb_dr_mode mode;
+	struct device *dev = dwc->dev;
+	unsigned int hw_mode;
+
+	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
+		dwc->dr_mode = USB_DR_MODE_OTG;
+
+	mode = dwc->dr_mode;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
+	switch (hw_mode) {
+	case DWC3_GHWPARAMS0_MODE_GADGET:
+		if (IS_ENABLED(CONFIG_USB_DWC3_HOST)) {
+			dev_err(dev,
+				"Controller does not support host mode.\n");
+			return -EINVAL;
+		}
+		mode = USB_DR_MODE_PERIPHERAL;
+		break;
+	case DWC3_GHWPARAMS0_MODE_HOST:
+		if (IS_ENABLED(CONFIG_USB_DWC3_GADGET)) {
+			dev_err(dev,
+				"Controller does not support device mode.\n");
+			return -EINVAL;
+		}
+		mode = USB_DR_MODE_HOST;
+		break;
+	default:
+		if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
+			mode = USB_DR_MODE_HOST;
+		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+			mode = USB_DR_MODE_PERIPHERAL;
+	}
+
+	if (mode != dwc->dr_mode) {
+		dev_warn(dev,
+			 "Configuration mismatch. dr_mode forced to %s\n",
+			 mode == USB_DR_MODE_HOST ? "host" : "gadget");
+
+		dwc->dr_mode = mode;
+	}
+
+	return 0;
+}
+
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -448,6 +499,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u3_susphy_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
+	if (dwc->dis_del_phy_power_chg_quirk)
+		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
@@ -485,6 +539,23 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		break;
 	}
 
+	switch (dwc->hsphy_mode) {
+	case USBPHY_INTERFACE_MODE_UTMI:
+		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
+		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_8_BIT) |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_8_BIT);
+		break;
+	case USBPHY_INTERFACE_MODE_UTMIW:
+		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
+		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_16_BIT) |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_16_BIT);
+		break;
+	default:
+		break;
+	}
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
 	 * '0' during coreConsultant configuration. So default value will
@@ -500,6 +571,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_enblslpm_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 
+	if (dwc->dis_u2_freeclk_exists_quirk)
+		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	return 0;
@@ -666,18 +740,43 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		break;
+	case USB_DR_MODE_HOST:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		break;
+	case USB_DR_MODE_OTG:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		break;
+	default:
+		dev_warn(dwc->dev, "Unsupported mode %d\n", dwc->dr_mode);
+		break;
+	}
+
+	/*
+	 * ENDXFER polling is available on version 3.10a and later of
+	 * the DWC_usb3 controller. It is NOT available in the
+	 * DWC_usb31 controller.
+	 */
+	if (!dwc3_is_usb31(dwc) && dwc->revision >= DWC3_REVISION_310A) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg |= DWC3_GUCTL2_RST_ACTBITLATER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	return 0;
 
 err4:
-	phy_power_off(dwc->usb2_generic_phy);
+	phy_power_off(dwc->usb3_generic_phy);
 
 err3:
-	phy_power_off(dwc->usb3_generic_phy);
+	phy_power_off(dwc->usb2_generic_phy);
 
 err2:
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	dwc3_core_exit(dwc);
 
 err1:
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -763,7 +862,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -772,7 +870,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -781,7 +878,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -888,6 +984,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->maximum_speed = usb_get_maximum_speed(dev);
 	dwc->dr_mode = usb_get_dr_mode(dev);
+	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
 
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
@@ -924,6 +1021,10 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,dis_enblslpm_quirk");
 	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
 				"snps,dis_rxdet_inp3_quirk");
+	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
+				"snps,dis-u2-freeclk-exists-quirk");
+	dwc->dis_del_phy_power_chg_quirk = device_property_read_bool(dev,
+				"snps,dis-del-phy-power-chg-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -972,17 +1073,9 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	if (IS_ENABLED(CONFIG_USB_DWC3_HOST) &&
-			(dwc->dr_mode == USB_DR_MODE_OTG ||
-					dwc->dr_mode == USB_DR_MODE_UNKNOWN))
-		dwc->dr_mode = USB_DR_MODE_HOST;
-	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET) &&
-			(dwc->dr_mode == USB_DR_MODE_OTG ||
-					dwc->dr_mode == USB_DR_MODE_UNKNOWN))
-		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
-
-	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
-		dwc->dr_mode = USB_DR_MODE_OTG;
+	ret = dwc3_get_dr_mode(dwc);
+	if (ret)
+		goto err3;
 
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 45d6de5107c7..6b60e42626a2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -109,6 +109,7 @@
 #define DWC3_GPRTBIMAP_HS1	0xc184
 #define DWC3_GPRTBIMAP_FS0	0xc188
 #define DWC3_GPRTBIMAP_FS1	0xc18c
+#define DWC3_GUCTL2		0xc19c
 
 #define DWC3_VER_NUMBER		0xc1a0
 #define DWC3_VER_TYPE		0xc1a4
@@ -199,9 +200,18 @@
 
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
+#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
 #define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
 #define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
+#define DWC3_GUSB2PHYCFG_PHYIF(n)	(n << 3)
+#define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
+#define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	(n << 10)
+#define DWC3_GUSB2PHYCFG_USBTRDTIM_MASK	DWC3_GUSB2PHYCFG_USBTRDTIM(0xf)
+#define USBTRDTIM_UTMI_8_BIT		9
+#define USBTRDTIM_UTMI_16_BIT		5
+#define UTMI_PHYIF_16_BIT		1
+#define UTMI_PHYIF_8_BIT		0
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
@@ -235,7 +245,10 @@
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
 
 /* Global HWPARAMS0 Register */
-#define DWC3_GHWPARAMS0_USB3_MODE(n)	((n) & 0x3)
+#define DWC3_GHWPARAMS0_MODE(n)		((n) & 0x3)
+#define DWC3_GHWPARAMS0_MODE_GADGET	0
+#define DWC3_GHWPARAMS0_MODE_HOST	1
+#define DWC3_GHWPARAMS0_MODE_DRD	2
 #define DWC3_GHWPARAMS0_MBUS_TYPE(n)	(((n) >> 3) & 0x7)
 #define DWC3_GHWPARAMS0_SBUS_TYPE(n)	(((n) >> 6) & 0x3)
 #define DWC3_GHWPARAMS0_MDWIDTH(n)	(((n) >> 8) & 0xff)
@@ -279,6 +292,9 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
+/* Global User Control Register 2 */
+#define DWC3_GUCTL2_RST_ACTBITLATER		(1 << 14)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -685,6 +701,8 @@ struct dwc3_hwparams {
  * @request: struct usb_request to be transferred
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
+ * @sg: pointer to first incomplete sg
+ * @num_pending_sgs: counter to pending sgs
  * @first_trb_index: index to first trb used by this request
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
@@ -697,7 +715,9 @@ struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
+	struct scatterlist	*sg;
 
+	unsigned		num_pending_sgs;
 	u8			first_trb_index;
 	u8			epnum;
 	struct dwc3_trb		*trb;
@@ -743,6 +763,9 @@ struct dwc3_scratchpad_array {
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
  * @dr_mode: requested mode of operation
+ * @hsphy_mode: UTMI phy mode, one of following:
+ *		- USBPHY_INTERFACE_MODE_UTMI
+ *		- USBPHY_INTERFACE_MODE_UTMIW
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -799,6 +822,11 @@ struct dwc3_scratchpad_array {
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
  * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
  *                      disabling the suspend signal to the PHY.
+ * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
+ *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
+ *			provide a free-running PHY clock.
+ * @dis_del_phy_power_chg_quirk: set if we disable delay phy power
+ *			change quirk.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -845,6 +873,7 @@ struct dwc3 {
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
+	enum usb_phy_interface	hsphy_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
@@ -880,6 +909,8 @@ struct dwc3 {
 #define DWC3_REVISION_260A	0x5533260a
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
+#define DWC3_REVISION_300A	0x5533300a
+#define DWC3_REVISION_310A	0x5533310a
 
 /*
  * NOTICE: we're using bit 31 as a "is usb 3.1" flag. This is really
@@ -942,6 +973,8 @@ struct dwc3 {
 	unsigned		dis_u2_susphy_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
 	unsigned		dis_rxdet_inp3_quirk:1;
+	unsigned		dis_u2_freeclk_exists_quirk:1;
+	unsigned		dis_del_phy_power_chg_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 122e64df2f4d..1dfa56a5f1c5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -174,15 +174,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
 	struct dwc3			*dwc = dep->dwc;
-	int				i;
 
-	if (req->started) {
-		i = 0;
-		do {
-			dwc3_ep_inc_deq(dep);
-		} while(++i < req->request.num_mapped_sgs);
-		req->started = false;
-	}
+	req->started = false;
 	list_del(&req->list);
 	req->trb = NULL;
 
@@ -348,7 +341,8 @@ static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
 	 * IN transfers due to a mishandled error condition. Synopsys
 	 * STAR 9000614252.
 	 */
-	if (dep->direction && (dwc->revision >= DWC3_REVISION_260A))
+	if (dep->direction && (dwc->revision >= DWC3_REVISION_260A) &&
+	    (dwc->gadget.speed >= USB_SPEED_SUPER))
 		cmd |= DWC3_DEPCMD_CLEARPENDIN;
 
 	memset(&params, 0, sizeof(params));
@@ -490,7 +484,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		params.param0 |= DWC3_DEPCFG_ACTION_INIT;
 	}
 
-	params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN;
+	if (usb_endpoint_xfer_control(desc))
+		params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN;
 
 	if (dep->number <= 1 || usb_endpoint_xfer_isoc(desc))
 		params.param1 |= DWC3_DEPCFG_XFER_NOT_READY_EN;
@@ -764,6 +759,8 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 	kfree(req);
 }
 
+static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep);
+
 /**
  * dwc3_prepare_one_trb - setup one TRB from one request
  * @dep: endpoint for which this request is prepared
@@ -771,15 +768,13 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
  */
 static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, dma_addr_t dma,
-		unsigned length, unsigned last, unsigned chain, unsigned node)
+		unsigned length, unsigned chain, unsigned node)
 {
 	struct dwc3_trb		*trb;
 
-	dwc3_trace(trace_dwc3_gadget, "%s: req %p dma %08llx length %d%s%s",
+	dwc3_trace(trace_dwc3_gadget, "%s: req %p dma %08llx length %d%s",
 			dep->name, req, (unsigned long long) dma,
-			length, last ? " last" : "",
-			chain ? " chain" : "");
-
+			length, chain ? " chain" : "");
 
 	trb = &dep->trb_pool[dep->trb_enqueue];
 
@@ -788,6 +783,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		req->trb = trb;
 		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
 		req->first_trb_index = dep->trb_enqueue;
+		dep->queued_requests++;
 	}
 
 	dwc3_ep_inc_enq(dep);
@@ -826,12 +822,10 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	/* always enable Continue on Short Packet */
 	trb->ctrl |= DWC3_TRB_CTRL_CSP;
 
-	if (!req->request.no_interrupt && !chain)
+	if ((!req->request.no_interrupt && !chain) ||
+			(dwc3_calc_trbs_left(dep) == 0))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC | DWC3_TRB_CTRL_ISP_IMI;
 
-	if (last && !usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		trb->ctrl |= DWC3_TRB_CTRL_LST;
-
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
@@ -840,8 +834,6 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
-	dep->queued_requests++;
-
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
@@ -856,12 +848,12 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
  */
 static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 {
-	if (!index)
-		index = DWC3_TRB_NUM - 2;
-	else
-		index = dep->trb_enqueue - 1;
+	u8 tmp = index;
+
+	if (!tmp)
+		tmp = DWC3_TRB_NUM - 1;
 
-	return &dep->trb_pool[index];
+	return &dep->trb_pool[tmp - 1];
 }
 
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
@@ -894,65 +886,42 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 }
 
 static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
-		struct dwc3_request *req, unsigned int trbs_left,
-		unsigned int more_coming)
+		struct dwc3_request *req)
 {
-	struct usb_request *request = &req->request;
-	struct scatterlist *sg = request->sg;
+	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
-	unsigned int	last = false;
 	unsigned int	length;
 	dma_addr_t	dma;
 	int		i;
 
-	for_each_sg(sg, s, request->num_mapped_sgs, i) {
+	for_each_sg(sg, s, req->num_pending_sgs, i) {
 		unsigned chain = true;
 
 		length = sg_dma_len(s);
 		dma = sg_dma_address(s);
 
-		if (sg_is_last(s)) {
-			if (usb_endpoint_xfer_int(dep->endpoint.desc) ||
-				!more_coming)
-				last = true;
-
-			chain = false;
-		}
-
-		if (!trbs_left--)
-			last = true;
-
-		if (last)
+		if (sg_is_last(s))
 			chain = false;
 
 		dwc3_prepare_one_trb(dep, req, dma, length,
-				last, chain, i);
+				chain, i);
 
-		if (last)
+		if (!dwc3_calc_trbs_left(dep))
 			break;
 	}
 }
 
 static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
-		struct dwc3_request *req, unsigned int trbs_left,
-		unsigned int more_coming)
+		struct dwc3_request *req)
 {
-	unsigned int	last = false;
 	unsigned int	length;
 	dma_addr_t	dma;
 
 	dma = req->request.dma;
 	length = req->request.length;
 
-	if (!trbs_left)
-		last = true;
-
-	/* Is this the last request? */
-	if (usb_endpoint_xfer_int(dep->endpoint.desc) || !more_coming)
-		last = true;
-
 	dwc3_prepare_one_trb(dep, req, dma, length,
-			last, false, 0);
+			false, 0);
 }
 
 /*
@@ -966,26 +935,19 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 {
 	struct dwc3_request	*req, *n;
-	unsigned int		more_coming;
-	u32			trbs_left;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
-	trbs_left = dwc3_calc_trbs_left(dep);
-	if (!trbs_left)
+	if (!dwc3_calc_trbs_left(dep))
 		return;
 
-	more_coming = dep->allocated_requests - dep->queued_requests;
-
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
-		if (req->request.num_mapped_sgs > 0)
-			dwc3_prepare_one_trb_sg(dep, req, trbs_left--,
-					more_coming);
+		if (req->num_pending_sgs > 0)
+			dwc3_prepare_one_trb_sg(dep, req);
 		else
-			dwc3_prepare_one_trb_linear(dep, req, trbs_left--,
-					more_coming);
+			dwc3_prepare_one_trb_linear(dep, req);
 
-		if (!trbs_left)
+		if (!dwc3_calc_trbs_left(dep))
 			return;
 	}
 }
@@ -1101,93 +1063,37 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 	trace_dwc3_ep_queue(req);
 
-	/*
-	 * We only add to our list of requests now and
-	 * start consuming the list once we get XferNotReady
-	 * IRQ.
-	 *
-	 * That way, we avoid doing anything that we don't need
-	 * to do now and defer it until the point we receive a
-	 * particular token from the Host side.
-	 *
-	 * This will also avoid Host cancelling URBs due to too
-	 * many NAKs.
-	 */
 	ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 			dep->direction);
 	if (ret)
 		return ret;
 
-	list_add_tail(&req->list, &dep->pending_list);
+	req->sg			= req->request.sg;
+	req->num_pending_sgs	= req->request.num_mapped_sgs;
 
-	/*
-	 * If there are no pending requests and the endpoint isn't already
-	 * busy, we will just start the request straight away.
-	 *
-	 * This will save one IRQ (XFER_NOT_READY) and possibly make it a
-	 * little bit faster.
-	 */
-	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			!usb_endpoint_xfer_int(dep->endpoint.desc)) {
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
-		goto out;
-	}
+	list_add_tail(&req->list, &dep->pending_list);
 
 	/*
-	 * There are a few special cases:
-	 *
-	 * 1. XferNotReady with empty list of requests. We need to kick the
-	 *    transfer here in that situation, otherwise we will be NAKing
-	 *    forever. If we get XferNotReady before gadget driver has a
-	 *    chance to queue a request, we will ACK the IRQ but won't be
-	 *    able to receive the data until the next request is queued.
-	 *    The following code is handling exactly that.
+	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
+	 * wait for a XferNotReady event so we will know what's the current
+	 * (micro-)frame number.
 	 *
+	 * Without this trick, we are very, very likely gonna get Bus Expiry
+	 * errors which will force us issue EndTransfer command.
 	 */
-	if (dep->flags & DWC3_EP_PENDING_REQUEST) {
-		/*
-		 * If xfernotready is already elapsed and it is a case
-		 * of isoc transfer, then issue END TRANSFER, so that
-		 * you can receive xfernotready again and can have
-		 * notion of current microframe.
-		 */
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			if (list_empty(&dep->started_list)) {
-				dwc3_stop_active_transfer(dwc, dep->number, true);
-				dep->flags = DWC3_EP_ENABLED;
-			}
-			return 0;
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		if ((dep->flags & DWC3_EP_PENDING_REQUEST) &&
+				list_empty(&dep->started_list)) {
+			dwc3_stop_active_transfer(dwc, dep->number, true);
+			dep->flags = DWC3_EP_ENABLED;
 		}
-
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
-		if (!ret)
-			dep->flags &= ~DWC3_EP_PENDING_REQUEST;
-
-		goto out;
-	}
-
-	/*
-	 * 2. XferInProgress on Isoc EP with an active transfer. We need to
-	 *    kick the transfer here after queuing a request, otherwise the
-	 *    core may not see the modified TRB(s).
-	 */
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			(dep->flags & DWC3_EP_BUSY) &&
-			!(dep->flags & DWC3_EP_MISSED_ISOC)) {
-		WARN_ON_ONCE(!dep->resource_index);
-		ret = __dwc3_gadget_kick_transfer(dep, dep->resource_index);
-		goto out;
+		return 0;
 	}
 
-	/*
-	 * 4. Stream Capable Bulk Endpoints. We need to start the transfer
-	 * right away, otherwise host will not know we have streams to be
-	 * handled.
-	 */
-	if (dep->stream_capable)
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
+	if (!dwc3_calc_trbs_left(dep))
+		return 0;
 
-out:
+	ret = __dwc3_gadget_kick_transfer(dep, 0);
 	if (ret && ret != -EBUSY)
 		dwc3_trace(trace_dwc3_gadget,
 				"%s: failed to kick transfers",
@@ -1962,7 +1868,11 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	unsigned int		s_pkt = 0;
 	unsigned int		trb_status;
 
-	dep->queued_requests--;
+	dwc3_ep_inc_deq(dep);
+
+	if (req->trb == trb)
+		dep->queued_requests--;
+
 	trace_dwc3_complete_trb(dep, trb);
 
 	/*
@@ -1982,6 +1892,7 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		return 1;
 
 	count = trb->size & DWC3_TRB_SIZE_MASK;
+	req->request.actual += count;
 
 	if (dep->direction) {
 		if (count) {
@@ -2021,48 +1932,51 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 
 	if (s_pkt && !chain)
 		return 1;
-	if ((event->status & DEPEVT_STATUS_LST) &&
-			(trb->ctrl & (DWC3_TRB_CTRL_LST |
-				DWC3_TRB_CTRL_HWO)))
-		return 1;
+
 	if ((event->status & DEPEVT_STATUS_IOC) &&
 			(trb->ctrl & DWC3_TRB_CTRL_IOC))
 		return 1;
+
 	return 0;
 }
 
 static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event, int status)
 {
-	struct dwc3_request	*req;
+	struct dwc3_request	*req, *n;
 	struct dwc3_trb		*trb;
-	unsigned int		slot;
-	unsigned int		i;
-	int			count = 0;
+	bool			ioc = false;
 	int			ret;
 
-	do {
+	list_for_each_entry_safe(req, n, &dep->started_list, list) {
+		unsigned length;
+		unsigned actual;
 		int chain;
 
-		req = next_request(&dep->started_list);
-		if (WARN_ON_ONCE(!req))
-			return 1;
-
-		chain = req->request.num_mapped_sgs > 0;
-		i = 0;
-		do {
-			slot = req->first_trb_index + i;
-			if (slot == DWC3_TRB_NUM - 1)
-				slot++;
-			slot %= DWC3_TRB_NUM;
-			trb = &dep->trb_pool[slot];
-			count += trb->size & DWC3_TRB_SIZE_MASK;
+		length = req->request.length;
+		chain = req->num_pending_sgs > 0;
+		if (chain) {
+			struct scatterlist *sg = req->sg;
+			struct scatterlist *s;
+			unsigned int pending = req->num_pending_sgs;
+			unsigned int i;
 
+			for_each_sg(sg, s, pending, i) {
+				trb = &dep->trb_pool[dep->trb_dequeue];
+
+				req->sg = sg_next(s);
+				req->num_pending_sgs--;
+
+				ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+						event, status, chain);
+				if (ret)
+					break;
+			}
+		} else {
+			trb = &dep->trb_pool[dep->trb_dequeue];
 			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
 					event, status, chain);
-			if (ret)
-				break;
-		} while (++i < req->request.num_mapped_sgs);
+		}
 
 		/*
 		 * We assume here we will always receive the entire data block
@@ -2071,12 +1985,21 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		 * should receive and we simply bounce the request back to the
 		 * gadget driver for further processing.
 		 */
-		req->request.actual += req->request.length - count;
+		actual = length - req->request.actual;
+		req->request.actual = actual;
+
+		if (ret && chain && (actual < length) && req->num_pending_sgs)
+			return __dwc3_gadget_kick_transfer(dep, 0);
+
 		dwc3_gadget_giveback(dep, req, status);
 
-		if (ret)
+		if (ret) {
+			if ((event->status & DEPEVT_STATUS_IOC) &&
+			    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+				ioc = true;
 			break;
-	} while (1);
+		}
+	}
 
 	/*
 	 * Our endpoint might get disabled by another thread during
@@ -2103,10 +2026,9 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		return 1;
 	}
 
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		if ((event->status & DEPEVT_STATUS_IOC) &&
-				(trb->ctrl & DWC3_TRB_CTRL_IOC))
-			return 0;
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) && ioc)
+		return 0;
+
 	return 1;
 }
 
@@ -2322,6 +2244,18 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	 *
 	 * - Issue EndTransfer WITH CMDIOC bit set
 	 * - Wait 100us
+	 *
+	 * As of IP version 3.10a of the DWC_usb3 IP, the controller
+	 * supports a mode to work around the above limitation. The
+	 * software can poll the CMDACT bit in the DEPCMD register
+	 * after issuing a EndTransfer command. This mode is enabled
+	 * by writing GUCTL2[14]. This polling is already done in the
+	 * dwc3_send_gadget_ep_cmd() function so if the mode is
+	 * enabled, the EndTransfer command will have completed upon
+	 * returning from this function and we don't need to delay for
+	 * 100us.
+	 *
+	 * This mode is NOT available on the DWC_usb31 IP.
 	 */
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
@@ -2333,7 +2267,9 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 	dep->flags &= ~DWC3_EP_BUSY;
-	udelay(100);
+
+	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
+		udelay(100);
 }
 
 static void dwc3_stop_active_transfers(struct dwc3 *dwc)
@@ -3054,7 +2990,7 @@ err3:
 	kfree(dwc->setup_buf);
 
 err2:
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err1:
@@ -3079,7 +3015,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	kfree(dwc->setup_buf);
 	kfree(dwc->zlp_buf);
 
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
-- 
2.53.0

