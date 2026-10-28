Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5D606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ylv4i/go;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s5IgcT1M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BE6281293;
	Wed, 28 Oct 2026 14:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GwgkuEMp5JNU; Wed, 28 Oct 2026 14:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C77B48111E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198826;
	b=FwzajkLtfzXr4cbfVswgu+REbpaeo2hMBsakFKgoTiC7E/NLSK0bH9xbxkjC4PhyH4AF
	 ay/byI5H4OFQ3D71DddUMGS6cQMrEHaBpgpUPRPIvmDBGFR5xLXpP5qOKwebK4v1nRHH0
	 Pkj+AZoXJuU9SPxXjAbZ7A8xvxr8K3jK3wWrtgYKJrCcyDZbLoepdBhLu+otqo2i896Gn
	 BzN0ZmX66NkLozmIc5uAxKIM/pgOleNVfKfLkpOJRxZZXzLHjvxZ9tv440m0QDBSF0Goy
	 ErrI9Pi0riJNyeTIdjRrR9MtgCR9g6AnznFm+mxCu2ywOIFGfE5Z0lpG37HYojh2tLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198826;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XjhGD3GMLo8TpRaTn2uO3Kuorgcp+tjNJG7jXfmXlgc=;
	b=nLjRtfmjqJvCOkfAUNYtLRtx8G0Sjr2865vNarxWFSe36Enezeh89VMXGLsNzh2FtO22
	 e4DmhEaNtvLTCxoMxeRqKas7zptc9pP0hHnLz9SPiPFDwVGo6PoE5gjMfIFZnXAfS5O8y
	 8zypdBtGSXziz4kwuUSfixGBqbyVn02IrsLMT0v3OEi6wWhMMIWBlPPWLd45jNzUHpV96
	 MaMzkSFGQFNY2isEbOAIPLsBIVpQ+6lrGFdbLndNWP6IyW1TFPKmucEEZoYarsSZRQbPb
	 zMkCTEY2+r33BCG2xFPsiv6HY8nb+aX4O046Goo1yYEMRdBIdeykLiyPVTux80TDUQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198826;
	bh=XjhGD3GMLo8TpRaTn2uO3Kuorgcp+tjNJG7jXfmXlgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ylv4i/gojCK83Of5eovK+BFkxShjjcB2qrLsDlnW8fbWUax9/N4WykkvWLPfW/BFY
	 EBkB6Hgv2Kygu6sl9KxvXzsVz67tZ71uZGmlQVgDcr+FgNBes+AZ/UAZjn4IfFdgX9
	 l4JLpsl+XBz3NG7wG5u7UWRKFLc4VANHFaW34Zaq72g8i/hSyypS17dhOvQaSoshu4
	 pqLYDNu8mHn3HXNIuwHUJ81gSCxZSU6EPSOQhqrIgas9RyOxgWFEdH8S93wRlq5D3n
	 xn5i8AMwnr4hzXK3IafwJW7mv5d5uhSYNGksVHSKrjQd2xHK08CZEmlqvcyY3KhMky
	 jpKKVbdrnFrXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C77B48111E;
	Wed, 28 Oct 2026 14:47:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91A959F8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 760936060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hd0usn3sQyxD for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CD6D605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196755;
 b=oNrMvBuS67bKtnzdRzHHc/9ubQGUeV6KlIej4VHhVnd4fYTw6LdRz6uEtIAwi8y9Xc43
 ryE1/Sbzo72gPq0rSU92WA/s5LSQ77fWZqFp4z0Ue8JdrucDHcUc8bsrfi7/qAyznjMMX
 eOvVsR45HtUek+Z3nWhIDLKj1GDBiKUJN2dS2MdAr5IPSjedw5lJ5k7u49+37oRZaFTgW
 VoPisg/zqZZqnadJ77rrKat0z3iZmXnbwH2wXnQjq51FAWtG12IAQV87EU00HqFhxI/OP
 TJ+FqkGNlv/UIBkSnS9z1XLR5hugkq5cmvpvnA/ln3BcqmWrZMBKAvNvWm8yfWdBqhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196755;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XjhGD3GMLo8TpRaTn2uO3Kuorgcp+tjNJG7jXfmXlgc=;
 b=Hy5xhh0A3NQK09HxMPfjB7u5g3RHfD/1HIs3yKnEdf5FOTMoiTZDJCKV/MOp6VfEJq0I
 UvNZXduSJp9VlWcpebRqA1FrBbKAChs0HZKwMe08isO6nidGk5ZiraS8bEViVXcL27ypG
 wlU2rMPIroYKqfjIug0q4qVrhDAgOcHTlfhe7iU/d/Ld1u7u4rUP/hkvUoQkXMKya/uZ4
 89RH3F5YOnrU9+jr8FRXpU5nmNaiZLKBNJc5ytU1P6LsIjK14ZLk4LH7o4QDILVn5uqNI
 ZDNKVMYgvpgSggnPLS4eCJKsIJMXDhgKX3NW5EU/wTVkq+v7T6Suw8v4cC3A494OF6Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=s5IgcT1M; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=s5IgcT1M
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CD6D605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:34 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c40f5077425so11730466b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196753; x=1793801553;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XjhGD3GMLo8TpRaTn2uO3Kuorgcp+tjNJG7jXfmXlgc=;
 b=s5IgcT1MlFbO3kwPEBibuaPcsmBPLFjAa8J3dkr72Wintsdil0I+TubYNU1OoR5Xdl
 WR+yphjqUkBeoBm2x63CFJCkjwyBzJhD+NnBWK91Q/q+5gyOg7lfb6SGI4HHfFjXjOhR
 j2C/PyRTJaD5I3Fx85VeDlcZG3KzJquFPT+2I9dXYgGLSp4ksGsrGpvQsqgN27imjBvg
 iWe1EH9u2KpDfk4O3kGqOo+PowSHt05bSyaUJzM/YAaDzsP8qJq/wRR7rKHwamq6En/N
 werSTt6sdDCcyhiwxSzT0LdQF2/Qu6uILC4x0dz4QbZ9REVFEk7WF46a3RWfQO49nY77
 Wg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196753; x=1793801553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XjhGD3GMLo8TpRaTn2uO3Kuorgcp+tjNJG7jXfmXlgc=;
 b=wJ0Wkr1viS8+UtLpO4ihTNjrsr73snPJ2uRut6m78It0BkXbn+X8s771RHHmhx/Q4b
 y+KOihK7cFzKgT5oZW+q9Rq0fbAttUwo9JlBra7c3P0VM5w7dvUkyaFV12aF6CMIKJ0R
 jvQa+3fJa5MM7/ioVW1fCJGqbp67rjc29AeS8Dm2DwLVB7Efyf39Pbk6L8/r1wO6sxoB
 +cn15BxKqVZenQnxCD71tCF0TtVyLkvmYICqmqyKB5vNQ11xGC5q6esHMY0N+xb4LdZV
 5GjhcSs79BKssbkpPAHDpFqj70dHTN6y0F9+cDoWczUsODBEyKNHnHcvDjwnUaAvUxck
 8opg==
X-Gm-Message-State: AFq9FYK+VzLA3++U8Yn+MLHhspd3FxydYFY90JDeqcb4KthoKhyvntVP
 0eTAOQkfF5ljfaptyd67dtkjQKOM2fyGAPoG2D4D4dzc87pdWCEOmM2KG3f7prcmV0VV8futBGX
 gp1Zy
X-Gm-Gg: AYBFou2iAvC6rFmCkcBy3Lv3M69878OdzGcSIRfPoZEphg3K5vaCKYSYpjrmlyLyrAW
 Ncc5nUXWNWOssXM/vBg7l+o2UZjxzSFxaly36G6xjWlJVDokniQnLZfJ/SWzAWnRcTkj0sDBWHw
 uPqQLJT1fscpwoo/QTmS1j/QVA4nwsYryJGINPySTLfJ9kjGyH0msXEIFS6QKwn5l3zwfXodoAg
 vEiRTCX4y7eAsdxhqnOgnLIakgU1DbBBGQwIgPWz3vWXvkmiVcs8UhDcK0AuWrdxJuM7h6H2XJ+
 qIpTlNDzGZGlZlPOL03ZRX7XecDUw73WnGn2PjBg1c+iyPfYjbt0rkyFhhGqzMMkqGjEsTqKEXj
 OeAdrcUAZdkj4o0t3VdYcMLERFIJxsbINhxRy11gkA24wfwwEnA35ltEyviMSDQjM5U2aCrQP6W
 TZx/PCL7lz4KNtB37E93nl5rJdySwG9ohcGniCCg1X+/E9koFqrO7bStZHVFn57F/1YV911Qimp
 43+KwXXlz8jUOFA+dCWuUhsHjMPeRTcLdXMHGOxHgPQEI8HY7ceUlT/D5Us7l3PjV3pgrLmOGRD
 GYqSjew/G0jR+tywdw95mQyUjWDKZ4Ox6TmiRKYh8P47+FndwEMqXR98CrjGWx5I28nu9VA3t4T
 Q6FirFLqIEg==
X-Received: by 2002:a17:907:7754:b0:c2d:bbae:703b with SMTP id
 a640c23a62f3a-c49bde4d5bcmr216630366b.2.1793196752479; 
 Wed, 28 Oct 2026 07:12:32 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:32 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 38/63] usb: dwc3: import from kernel v5.13
Date: Wed, 28 Oct 2026 15:09:04 +0100
Message-ID: <20261028140930.3025368-39-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.12 to v5.13.

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

List of commits: git log --oneline v5.12..v5.13
Commits imported:
4bf584a03eec usb: dwc3: core: fix kernel panic when do reboot
d00889080ab6 usb: dwc3: ep0: fix NULL pointer exception
8f11fe7e4068 Revert "usb: dwc3: core: Add shutdown callback for dwc3"
8d396bb0a5b6 usb: dwc3: debugfs: Add and remove endpoint dirs dynamically
03715ea2e3db usb: dwc3: gadget: Bail from dwc3_gadget_exit() if dwc->gadget is NULL
8212937305f8 usb: dwc3: gadget: Disable gadget IRQ during pullup disable
25dda9fc56bd usb: dwc3: gadget: Properly track pending and queued SG
18ffa988dbae usb: dwc3: gadget: Return success always for kick transfer in ep queue
bb9c74a5bd14 usb: dwc3: gadget: Free gadget structure only after freeing endpoints
6f26ebb79a84 usb: dwc3: gadget: Rename EOPF event macros to Suspend
d1d90dd27254 usb: dwc3: gadget: Enable suspend events
9cbc7eb17cdf usb: dwc3: core: Add missing GHWPARAMS9 doc
ddae7979cdd5 usb: dwc3: gadget: Handle DEV_TXF_FLUSH_BYPASS capability
16710380d3aa usb: dwc3: Capture new capability register GHWPARAMS9
f88359e1588b usb: dwc3: core: Do core softreset when switch mode
3232a3ce55ed usb: dwc3: gadget: Remove FS bInterval_m1 limitation
c560e76319a9 usb: dwc3: gadget: Fix START_TRANSFER link state check
475e8be53d04 usb: dwc3: gadget: Check for disabled LPM quirk
568262bf5492 usb: dwc3: core: Add shutdown callback for dwc3
e66bbfb0fbbe usb: dwc3: gadget: Ignore Packet Pending bit
04dd6e76b228 usb: dwc3: add cancelled reasons for dwc3 requests
27088e00b623 usb: dwc3: fix incorrect kernel-doc comment syntax in files
d00be779cc50 usb: dwc3: Create helper function getting MDWIDTH
8a5b5c3c1634 usb: dwc3: gadget: modify the scale in vbus_draw callback
71ca43f30df9 usb: dwc3: gadget: Ignore EP queue requests during bus reset
02fa4b980245 usb: dwc3: gadget: Avoid continuing preparing TRBs during teardown
0c59f678fcfc usb: dwc3: gadget: Remove invalid low-speed setting
0f3edf99c239 usb: dwc3: document usb_psy in struct dwc3
b0bf77cd389d usb: dwc3: Fix dereferencing of null dwc->usb_psy
99288de36020 usb: dwc3: add an alternate path in vbus_draw callback
6f0764b5adea usb: dwc3: add a power supply for current control

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  50 ++++++++++-
 drivers/usb/dwc3/core.h   |  60 +++++++++++---
 drivers/usb/dwc3/debug.h  |  13 +--
 drivers/usb/dwc3/ep0.c    |   3 +
 drivers/usb/dwc3/gadget.c | 169 ++++++++++++++++++++++++++------------
 drivers/usb/dwc3/gadget.h |   6 +-
 drivers/usb/dwc3/io.h     |   2 +-
 7 files changed, 229 insertions(+), 74 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f2448d0a9d39..4ac397e43e19 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -114,6 +114,8 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
+static int dwc3_core_soft_reset(struct dwc3 *dwc);
+
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -121,6 +123,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 	int ret;
 	u32 reg;
 
+	mutex_lock(&dwc->mutex);
+
 	pm_runtime_get_sync(dwc->dev);
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
@@ -154,6 +158,25 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+	/* For DRD host or device mode only */
+	if (dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg |= DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+		/*
+		 * Wait for internal clocks to synchronized. DWC_usb31 and
+		 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
+		 * keep it consistent across different IPs, let's wait up to
+		 * 100ms before clearing GCTL.CORESOFTRESET.
+		 */
+		msleep(100);
+
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg &= ~DWC3_GCTL_CORESOFTRESET;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+	}
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
@@ -178,6 +201,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		dwc3_core_soft_reset(dwc);
+
 		dwc3_event_buffers_setup(dwc);
 
 		if (dwc->usb2_phy)
@@ -200,6 +225,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 out:
 	pm_runtime_mark_last_busy(dwc->dev);
 	pm_runtime_put_autosuspend(dwc->dev);
+	mutex_unlock(&dwc->mutex);
 }
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
@@ -544,6 +570,9 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 	parms->hwparams6 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS6);
 	parms->hwparams7 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS7);
 	parms->hwparams8 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS8);
+
+	if (DWC3_IP_IS(DWC32))
+		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
@@ -1238,6 +1267,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
+	const char		*usb_psy_name;
+	int			ret;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1263,6 +1294,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	else
 		dwc->sysdev = dwc->dev;
 
+	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
+	if (ret >= 0) {
+		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
+		if (!dwc->usb_psy)
+			dev_err(dev, "couldn't get usb power supply\n");
+	}
+
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
 	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
@@ -1277,6 +1315,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,usb3_lpm_capable");
 	dwc->usb2_lpm_disable = device_property_read_bool(dev,
 				"snps,usb2-lpm-disable");
+	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
+				"snps,usb2-gadget-lpm-disable");
 	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
 				&rx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,rx-max-burst-prd",
@@ -1385,7 +1425,6 @@ static void dwc3_check_params(struct dwc3 *dwc)
 
 	/* Check the maximum_speed parameter */
 	switch (dwc->maximum_speed) {
-	case USB_SPEED_LOW:
 	case USB_SPEED_FULL:
 	case USB_SPEED_HIGH:
 		break;
@@ -1543,6 +1582,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_cache_hwparams(dwc);
 
 	spin_lock_init(&dwc->lock);
+	mutex_init(&dwc->mutex);
 
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
@@ -1619,6 +1659,9 @@ disable_clks:
 assert_reset:
 	reset_control_assert(dwc->reset);
 
+	if (dwc->usb_psy)
+		power_supply_put(dwc->usb_psy);
+
 	return ret;
 }
 
@@ -1628,8 +1671,8 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
+	dwc3_debugfs_exit(dwc);
 
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
@@ -1641,6 +1684,9 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
 
+	if (dwc->usb_psy)
+		power_supply_put(dwc->usb_psy);
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 052b20d52651..c5d5760cdf53 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/bitops.h>
@@ -30,6 +31,8 @@
 
 #include <linux/phy/phy.h>
 
+#include <linux/power_supply.h>
+
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
@@ -54,7 +57,7 @@
 #define DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE	3
 #define DWC3_DEVICE_EVENT_WAKEUP		4
 #define DWC3_DEVICE_EVENT_HIBER_REQ		5
-#define DWC3_DEVICE_EVENT_EOPF			6
+#define DWC3_DEVICE_EVENT_SUSPEND		6
 #define DWC3_DEVICE_EVENT_SOF			7
 #define DWC3_DEVICE_EVENT_ERRATIC_ERROR		9
 #define DWC3_DEVICE_EVENT_CMD_CMPL		10
@@ -140,6 +143,7 @@
 #define DWC3_GHWPARAMS8		0xc600
 #define DWC3_GUCTL3		0xc60c
 #define DWC3_GFLADJ		0xc630
+#define DWC3_GHWPARAMS9		0xc680
 
 /* Device Registers */
 #define DWC3_DCFG		0xc700
@@ -375,6 +379,9 @@
 #define DWC3_GHWPARAMS7_RAM1_DEPTH(n)	((n) & 0xffff)
 #define DWC3_GHWPARAMS7_RAM2_DEPTH(n)	(((n) >> 16) & 0xffff)
 
+/* Global HWPARAMS9 Register */
+#define DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS	BIT(0)
+
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
@@ -396,12 +403,12 @@
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
 #define DWC3_DCFG_FULLSPEED	BIT(0)
-#define DWC3_DCFG_LOWSPEED	(2 << 0)
 
 #define DWC3_DCFG_NUMP_SHIFT	17
 #define DWC3_DCFG_NUMP(n)	(((n) >> DWC3_DCFG_NUMP_SHIFT) & 0x1f)
 #define DWC3_DCFG_NUMP_MASK	(0x1f << DWC3_DCFG_NUMP_SHIFT)
 #define DWC3_DCFG_LPM_CAP	BIT(22)
+#define DWC3_DCFG_IGNSTRMPP	BIT(23)
 
 /* Device Control Register */
 #define DWC3_DCTL_RUN_STOP	BIT(31)
@@ -453,7 +460,7 @@
 #define DWC3_DEVTEN_CMDCMPLTEN		BIT(10)
 #define DWC3_DEVTEN_ERRTICERREN		BIT(9)
 #define DWC3_DEVTEN_SOFEN		BIT(7)
-#define DWC3_DEVTEN_EOPFEN		BIT(6)
+#define DWC3_DEVTEN_U3L2L1SUSPEN	BIT(6)
 #define DWC3_DEVTEN_HIBERNATIONREQEVTEN	BIT(5)
 #define DWC3_DEVTEN_WKUPEVTEN		BIT(4)
 #define DWC3_DEVTEN_ULSTCNGEN		BIT(3)
@@ -490,7 +497,6 @@
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
 #define DWC3_DSTS_FULLSPEED		BIT(0)
-#define DWC3_DSTS_LOWSPEED		(2 << 0)
 
 /* Device Generic Command Register */
 #define DWC3_DGCMD_SET_LMP		0x01
@@ -844,6 +850,7 @@ struct dwc3_trb {
  * @hwparams6: GHWPARAMS6
  * @hwparams7: GHWPARAMS7
  * @hwparams8: GHWPARAMS8
+ * @hwparams9: GHWPARAMS9
  */
 struct dwc3_hwparams {
 	u32	hwparams0;
@@ -855,13 +862,12 @@ struct dwc3_hwparams {
 	u32	hwparams6;
 	u32	hwparams7;
 	u32	hwparams8;
+	u32	hwparams9;
 };
 
 /* HWPARAMS0 */
 #define DWC3_MODE(n)		((n) & 0x7)
 
-#define DWC3_MDWIDTH(n)		(((n) & 0xff00) >> 8)
-
 /* HWPARAMS1 */
 #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
 
@@ -908,11 +914,13 @@ struct dwc3_request {
 	unsigned int		remaining;
 
 	unsigned int		status;
-#define DWC3_REQUEST_STATUS_QUEUED	0
-#define DWC3_REQUEST_STATUS_STARTED	1
-#define DWC3_REQUEST_STATUS_CANCELLED	2
-#define DWC3_REQUEST_STATUS_COMPLETED	3
-#define DWC3_REQUEST_STATUS_UNKNOWN	-1
+#define DWC3_REQUEST_STATUS_QUEUED		0
+#define DWC3_REQUEST_STATUS_STARTED		1
+#define DWC3_REQUEST_STATUS_DISCONNECTED	2
+#define DWC3_REQUEST_STATUS_DEQUEUED		3
+#define DWC3_REQUEST_STATUS_STALLED		4
+#define DWC3_REQUEST_STATUS_COMPLETED		5
+#define DWC3_REQUEST_STATUS_UNKNOWN		-1
 
 	u8			epnum;
 	struct dwc3_trb		*trb;
@@ -946,6 +954,7 @@ struct dwc3_scratchpad_array {
  * @scratch_addr: dma address of scratchbuf
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
+ * @mutex: for mode switching
  * @dev: pointer to our struct device
  * @sysdev: pointer to the DMA-capable device
  * @xhci: pointer to our xHCI child
@@ -986,6 +995,7 @@ struct dwc3_scratchpad_array {
  * @role_sw: usb_role_switch handle
  * @role_switch_default_mode: default operation mode of controller while
  *			usb role is USB_ROLE_NONE.
+ * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1034,7 +1044,8 @@ struct dwc3_scratchpad_array {
  * @dis_start_transfer_quirk: set if start_transfer failure SW workaround is
  *			not needed for DWC_usb31 version 1.70a-ea06 and below
  * @usb3_lpm_capable: set if hadrware supports Link Power Management
- * @usb2_lpm_disable: set to disable usb2 lpm
+ * @usb2_lpm_disable: set to disable usb2 lpm for host
+ * @usb2_gadget_lpm_disable: set to disable usb2 lpm for gadget
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
@@ -1085,6 +1096,9 @@ struct dwc3 {
 	/* device lock */
 	spinlock_t		lock;
 
+	/* mode switching lock */
+	struct mutex		mutex;
+
 	struct device		*dev;
 	struct device		*sysdev;
 
@@ -1125,6 +1139,8 @@ struct dwc3 {
 	struct usb_role_switch	*role_sw;
 	enum usb_dr_mode	role_switch_default_mode;
 
+	struct power_supply	*usb_psy;
+
 	u32			fladj;
 	u32			irq_gadget;
 	u32			otg_irq;
@@ -1238,6 +1254,7 @@ struct dwc3 {
 	unsigned		dis_start_transfer_quirk:1;
 	unsigned		usb3_lpm_capable:1;
 	unsigned		usb2_lpm_disable:1;
+	unsigned		usb2_gadget_lpm_disable:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
@@ -1358,7 +1375,7 @@ struct dwc3_event_depevt {
  *	3	- ULStChng
  *	4	- WkUpEvt
  *	5	- Reserved
- *	6	- EOPF
+ *	6	- Suspend (EOPF on revisions 2.10a and prior)
  *	7	- SOF
  *	8	- Reserved
  *	9	- ErrticErr
@@ -1455,6 +1472,23 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 	 (!(_ip##_VERSIONTYPE_##_to) ||					\
 	  dwc->version_type <= _ip##_VERSIONTYPE_##_to))
 
+/**
+ * dwc3_mdwidth - get MDWIDTH value in bits
+ * @dwc: pointer to our context structure
+ *
+ * Return MDWIDTH configuration value in bits.
+ */
+static inline u32 dwc3_mdwidth(struct dwc3 *dwc)
+{
+	u32 mdwidth;
+
+	mdwidth = DWC3_GHWPARAMS0_MDWIDTH(dwc->hwparams.hwparams0);
+	if (DWC3_IP_IS(DWC32))
+		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+
+	return mdwidth;
+}
+
 bool dwc3_has_imod(struct dwc3 *dwc);
 
 int dwc3_event_buffers_setup(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 8ab394942360..d223c54115f4 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
@@ -221,8 +221,8 @@ static inline const char *dwc3_gadget_event_string(char *str, size_t size,
 		snprintf(str, size, "WakeUp [%s]",
 				dwc3_gadget_link_string(state));
 		break;
-	case DWC3_DEVICE_EVENT_EOPF:
-		snprintf(str, size, "End-Of-Frame [%s]",
+	case DWC3_DEVICE_EVENT_SUSPEND:
+		snprintf(str, size, "Suspend [%s]",
 				dwc3_gadget_link_string(state));
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
@@ -353,8 +353,8 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 		return "Wake-Up";
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
 		return "Hibernation";
-	case DWC3_DEVICE_EVENT_EOPF:
-		return "End of Periodic Frame";
+	case DWC3_DEVICE_EVENT_SUSPEND:
+		return "Suspend";
 	case DWC3_DEVICE_EVENT_SOF:
 		return "Start of Frame";
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
@@ -413,9 +413,12 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 
 
 #ifdef CONFIG_DEBUG_FS
+extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
 extern void dwc3_debugfs_init(struct dwc3 *d);
 extern void dwc3_debugfs_exit(struct dwc3 *d);
 #else
+static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
+{  }
 static inline void dwc3_debugfs_init(struct dwc3 *d)
 {  }
 static inline void dwc3_debugfs_exit(struct dwc3 *d)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8b668ef46f7f..3cd294264372 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -292,6 +292,9 @@ static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
 		epnum |= 1;
 
 	dep = dwc->eps[epnum];
+	if (dep == NULL)
+		return NULL;
+
 	if (dep->flags & DWC3_EP_ENABLED)
 		return dep;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c7ef218e7a8c..f14c2aa83759 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -308,13 +308,12 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	}
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int		needs_wakeup;
+		int link_state;
 
-		needs_wakeup = (dwc->link_state == DWC3_LINK_STATE_U1 ||
-				dwc->link_state == DWC3_LINK_STATE_U2 ||
-				dwc->link_state == DWC3_LINK_STATE_U3);
-
-		if (unlikely(needs_wakeup)) {
+		link_state = dwc3_gadget_get_link_state(dwc);
+		if (link_state == DWC3_LINK_STATE_U1 ||
+		    link_state == DWC3_LINK_STATE_U2 ||
+		    link_state == DWC3_LINK_STATE_U3) {
 			ret = __dwc3_gadget_wakeup(dwc);
 			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
 					ret);
@@ -608,12 +607,14 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		u8 bInterval_m1;
 
 		/*
-		 * Valid range for DEPCFG.bInterval_m1 is from 0 to 13, and it
-		 * must be set to 0 when the controller operates in full-speed.
+		 * Valid range for DEPCFG.bInterval_m1 is from 0 to 13.
+		 *
+		 * NOTE: The programming guide incorrectly stated bInterval_m1
+		 * must be set to 0 when operating in fullspeed. Internally the
+		 * controller does not have this limitation. See DWC_usb3x
+		 * programming guide section 3.2.2.1.
 		 */
 		bInterval_m1 = min_t(u8, desc->bInterval - 1, 13);
-		if (dwc->gadget->speed == USB_SPEED_FULL)
-			bInterval_m1 = 0;
 
 		if (usb_endpoint_type(desc) == USB_ENDPOINT_XFER_INT &&
 		    dwc->gadget->speed == USB_SPEED_FULL)
@@ -729,8 +730,16 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 			 * All stream eps will reinitiate stream on NoStream
 			 * rejection until we can determine that the host can
 			 * prime after the first transfer.
+			 *
+			 * However, if the controller is capable of
+			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
+			 * automatically restart the stream without the driver
+			 * initiation.
 			 */
-			dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+			if (!dep->direction ||
+			    !(dwc->hwparams.hwparams9 &
+			      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
+				dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
 		}
 	}
 
@@ -1235,6 +1244,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 			req->start_sg = sg_next(s);
 
 		req->num_queued_sgs++;
+		req->num_pending_sgs--;
 
 		/*
 		 * The number of pending SG entries may not correspond to the
@@ -1242,7 +1252,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 		 * don't include unused SG entries.
 		 */
 		if (length == 0) {
-			req->num_pending_sgs -= req->request.num_mapped_sgs - req->num_queued_sgs;
+			req->num_pending_sgs = 0;
 			break;
 		}
 
@@ -1402,7 +1412,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
 
 		/* If ep isn't started, then there's no end transfer pending */
 		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
@@ -1675,7 +1685,9 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 	}
 
-	return __dwc3_gadget_kick_transfer(dep);
+	__dwc3_gadget_kick_transfer(dep);
+
+	return 0;
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
@@ -1729,10 +1741,25 @@ static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
 {
 	struct dwc3_request		*req;
 	struct dwc3_request		*tmp;
+	struct dwc3			*dwc = dep->dwc;
 
 	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
 		dwc3_gadget_ep_skip_trbs(dep, req);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		switch (req->status) {
+		case DWC3_REQUEST_STATUS_DISCONNECTED:
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+			break;
+		case DWC3_REQUEST_STATUS_DEQUEUED:
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		case DWC3_REQUEST_STATUS_STALLED:
+			dwc3_gadget_giveback(dep, req, -EPIPE);
+			break;
+		default:
+			dev_err(dwc->dev, "request cancelled with wrong reason:%d\n", req->status);
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			break;
+		}
 	}
 }
 
@@ -1776,7 +1803,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			 * cancelled.
 			 */
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
-				dwc3_gadget_move_cancelled_request(r);
+				dwc3_gadget_move_cancelled_request(r,
+						DWC3_REQUEST_STATUS_DEQUEUED);
 
 			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
@@ -1848,7 +1876,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		dwc3_stop_active_transfer(dep, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
-			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
 
 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
@@ -1973,6 +2001,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	case DWC3_LINK_STATE_RESET:
 	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
+	case DWC3_LINK_STATE_U2:	/* in HS, means Sleep (L1) */
+	case DWC3_LINK_STATE_U1:
 	case DWC3_LINK_STATE_RESUME:
 		break;
 	default:
@@ -2113,9 +2143,6 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 		reg |= DWC3_DCFG_SUPERSPEED;
 	} else {
 		switch (speed) {
-		case USB_SPEED_LOW:
-			reg |= DWC3_DCFG_LOWSPEED;
-			break;
 		case USB_SPEED_FULL:
 			reg |= DWC3_DCFG_FULLSPEED;
 			break;
@@ -2234,13 +2261,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	}
 
 	/*
-	 * Synchronize any pending event handling before executing the controller
-	 * halt routine.
+	 * Synchronize and disable any further event handling while controller
+	 * is being enabled/disabled.
 	 */
-	if (!is_on) {
-		dwc3_gadget_disable_irq(dwc);
-		synchronize_irq(dwc->irq_gadget);
-	}
+	disable_irq(dwc->irq_gadget);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
@@ -2278,6 +2302,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	enable_irq(dwc->irq_gadget);
+
 	pm_runtime_put(dwc->dev);
 
 	return ret;
@@ -2299,6 +2325,10 @@ static void dwc3_gadget_enable_irq(struct dwc3 *dwc)
 	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
 		reg |= DWC3_DEVTEN_ULSTCNGEN;
 
+	/* On 2.30a and above this bit enables U3/L2-L1 Suspend Events */
+	if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+		reg |= DWC3_DEVTEN_U3L2L1SUSPEN;
+
 	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
 }
 
@@ -2340,9 +2370,7 @@ static void dwc3_gadget_setup_nump(struct dwc3 *dwc)
 	u32 reg;
 
 	ram2_depth = DWC3_GHWPARAMS7_RAM2_DEPTH(dwc->hwparams.hwparams7);
-	mdwidth = DWC3_GHWPARAMS0_MDWIDTH(dwc->hwparams.hwparams0);
-	if (DWC3_IP_IS(DWC32))
-		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+	mdwidth = dwc3_mdwidth(dwc);
 
 	nump = ((ram2_depth * mdwidth / 8) - 24 - 16) / 1024;
 	nump = min_t(u32, nump, 16);
@@ -2388,6 +2416,17 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	dwc3_gadget_setup_nump(dwc);
 
+	/*
+	 * Currently the controller handles single stream only. So, Ignore
+	 * Packet Pending bit for stream selection and don't search for another
+	 * stream if the host sends Data Packet with PP=0 (for OUT direction) or
+	 * ACK with NumP=0 and PP=0 (for IN direction). This slightly improves
+	 * the stream performance.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg |= DWC3_DCFG_IGNSTRMPP;
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -2531,11 +2570,19 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
 static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
+	union power_supply_propval	val = {0};
+	int				ret;
 
 	if (dwc->usb2_phy)
 		return usb_phy_set_power(dwc->usb2_phy, mA);
 
-	return 0;
+	if (!dwc->usb_psy)
+		return -EOPNOTSUPP;
+
+	val.intval = 1000 * mA;
+	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+
+	return ret;
 }
 
 static const struct usb_gadget_ops dwc3_gadget_ops = {
@@ -2571,12 +2618,10 @@ static int dwc3_gadget_init_control_endpoint(struct dwc3_ep *dep)
 static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
-	int mdwidth;
+	u32 mdwidth;
 	int size;
 
-	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
-	if (DWC3_IP_IS(DWC32))
-		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+	mdwidth = dwc3_mdwidth(dwc);
 
 	/* MDWIDTH is represented in bits, we need it in bytes */
 	mdwidth /= 8;
@@ -2618,12 +2663,10 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
-	int mdwidth;
+	u32 mdwidth;
 	int size;
 
-	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
-	if (DWC3_IP_IS(DWC32))
-		mdwidth += DWC3_GHWPARAMS6_MDWIDTH(dwc->hwparams.hwparams6);
+	mdwidth = dwc3_mdwidth(dwc);
 
 	/* MDWIDTH is represented in bits, convert to bytes */
 	mdwidth /= 8;
@@ -2710,6 +2753,8 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
 
+	dwc3_debugfs_create_endpoint_dir(dep);
+
 	return 0;
 }
 
@@ -2753,6 +2798,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
+		debugfs_remove_recursive(debugfs_lookup(dep->name, dwc->root));
 		kfree(dep);
 	}
 }
@@ -2830,15 +2876,15 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
 	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
-	unsigned int pending = req->num_pending_sgs;
+	unsigned int num_queued = req->num_queued_sgs;
 	unsigned int i;
 	int ret = 0;
 
-	for_each_sg(sg, s, pending, i) {
+	for_each_sg(sg, s, num_queued, i) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
 		req->sg = sg_next(s);
-		req->num_pending_sgs--;
+		req->num_queued_sgs--;
 
 		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
 				trb, event, status, true);
@@ -2861,7 +2907,7 @@ static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	return req->num_pending_sgs == 0;
+	return req->num_pending_sgs == 0 && req->num_queued_sgs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -2870,7 +2916,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 {
 	int ret;
 
-	if (req->num_pending_sgs)
+	if (req->request.num_mapped_sgs)
 		ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event,
 				status);
 	else
@@ -2913,6 +2959,11 @@ static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
 static bool dwc3_gadget_ep_should_continue(struct dwc3_ep *dep)
 {
 	struct dwc3_request	*req;
+	struct dwc3		*dwc = dep->dwc;
+
+	if (!dep->endpoint.desc || !dwc->pullups_connected ||
+	    !dwc->connected)
+		return false;
 
 	if (!list_empty(&dep->pending_list))
 		return true;
@@ -3322,6 +3373,15 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 {
 	u32			reg;
 
+	/*
+	 * Ideally, dwc3_reset_gadget() would trigger the function
+	 * drivers to stop any active transfers through ep disable.
+	 * However, for functions which defer ep disable, such as mass
+	 * storage, we will need to rely on the call to stop active
+	 * transfers here, and avoid allowing of request queuing.
+	 */
+	dwc->connected = false;
+
 	/*
 	 * WORKAROUND: DWC3 revisions <1.88a have an issue which
 	 * would cause a missing Disconnect Event if there's a
@@ -3448,11 +3508,6 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		dwc->gadget->ep0->maxpacket = 64;
 		dwc->gadget->speed = USB_SPEED_FULL;
 		break;
-	case DWC3_DSTS_LOWSPEED:
-		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
-		dwc->gadget->ep0->maxpacket = 8;
-		dwc->gadget->speed = USB_SPEED_LOW;
-		break;
 	}
 
 	dwc->eps[1]->endpoint.maxpacket = dwc->gadget->ep0->maxpacket;
@@ -3460,6 +3515,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	/* Enable USB2 LPM Capability */
 
 	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A) &&
+	    !dwc->usb2_gadget_lpm_disable &&
 	    (speed != DWC3_DSTS_SUPERSPEED) &&
 	    (speed != DWC3_DSTS_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
@@ -3486,6 +3542,12 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
+		if (dwc->usb2_gadget_lpm_disable) {
+			reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+			reg &= ~DWC3_DCFG_LPM_CAP;
+			dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+		}
+
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_HIRD_THRES_MASK;
 		dwc3_gadget_dctl_write_safe(dwc, reg);
@@ -3687,7 +3749,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
 		break;
-	case DWC3_DEVICE_EVENT_EOPF:
+	case DWC3_DEVICE_EVENT_SUSPEND:
 		/* It changed to be suspend event for version 2.30a and above */
 		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
 			/*
@@ -3934,7 +3996,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget->ssp_rate		= USB_SSP_GEN_UNKNOWN;
 	dwc->gadget->sg_supported	= true;
 	dwc->gadget->name		= "dwc3-gadget";
-	dwc->gadget->lpm_capable	= true;
+	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -3986,6 +4048,7 @@ err5:
 	dwc3_gadget_free_endpoints(dwc);
 err4:
 	usb_put_gadget(dwc->gadget);
+	dwc->gadget = NULL;
 err3:
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
 			dwc->bounce_addr);
@@ -4005,8 +4068,12 @@ err0:
 
 void dwc3_gadget_exit(struct dwc3 *dwc)
 {
-	usb_del_gadget_udc(dwc->gadget);
+	if (!dwc->gadget)
+		return;
+
+	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
+	usb_put_gadget(dwc->gadget);
 	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
 			  dwc->bounce_addr);
 	kfree(dwc->setup_buf);
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 0cd281949970..77df4b6d6c13 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -90,15 +90,17 @@ static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 /**
  * dwc3_gadget_move_cancelled_request - move @req to the cancelled_list
  * @req: the request to be moved
+ * @reason: cancelled reason for the dwc3 request
  *
  * Caller should take care of locking. This function will move @req from its
  * current list to the endpoint's cancelled_list.
  */
-static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req)
+static inline void dwc3_gadget_move_cancelled_request(struct dwc3_request *req,
+		unsigned int reason)
 {
 	struct dwc3_ep		*dep = req->dep;
 
-	req->status = DWC3_REQUEST_STATUS_CANCELLED;
+	req->status = reason;
 	list_move_tail(&req->list, &dep->cancelled_list);
 }
 
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 76b73b116862..1e96ea339d48 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * io.h - DesignWare USB3 DRD IO Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
-- 
2.53.0

