Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664B8CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3097F6071B;
	Tue, 29 Sep 2026 00:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrbwD3woTvjH; Tue, 29 Sep 2026 00:22:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A73B96077C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641351;
	b=LosI5HqyfvT6e0IA3I9Z6dll4EZcuFaXD/bGjHqopLR6aYq0Ks+e2XT5WUJu5XK8TAsD
	 CBssL1R1tuatsLbA0lfotbfS0McyOUwwxdVL9CNiSxPN1Q6YGLtZmEBL/rKBMXkYjmpqb
	 rfHQYGwrgSPMv4joimPIxslMQ3EZO2X+EnRnqpwLc8qM85dFLKF7RdR9TvOlQcJTCRJh3
	 Tck4N9wd1Jk7izOcno93xEHzoYFcoP4PogyUe+0AshcWXn+YqetAmZeICzJCZOl8qnDSy
	 luCmBPV9OaJUIZNTM1r4ugrId8R9bA6JSnmkkfms62+L9JT7nG4r8yod2aO8EM7qpNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bA0axyMWBO918tpVe1aLhArqroTRVFLXBe96WPLevIM=;
	b=s3laiwFUBxyOvSAKOy6ieePbOfK36kG5I2vY/MXnpWm3OW/CreUzqLdq6mw/zegoT5xO
	 rmH+wGFd6dtuVEyrM5MSp5uz2gvWyPL8HcKI97YolHpP3GJ/mNRhGJEjAZO/r0mvLfe31
	 28Isan63SMk5d1oKPd6kPmujYt8OAyNyt5RVu1EdkNdaKQdcgu95Dv8V8C6zF1zSBK8X9
	 k0QcMaMCabpIydTi/yUAMBvPCtnSJ3TnJDNJhb9faTcwM+T0p5KpyShDs/i5pSDY0uTbK
	 8gc170+9wORdtyMJW+undWY2qiXj5sPbxRIpbH474rwX/it2j1GHyTMrgriQn/lQ8ew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641351;
	bh=bA0axyMWBO918tpVe1aLhArqroTRVFLXBe96WPLevIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lcsib6cmcsOhGN2P6nFQc1pqZl8E7Z6JhYqyCB/s2/OdJnBLJvAB1GF1TopbEpZk0
	 ckjGSMPUwAJ2xNrVoF/qolGziVD/+yJsW0AdEqwDuY9/Yp+L0QlwuoEb3/jCLAiGtB
	 UYoeJ005ck2BxerOj52E+7k7m//+BL07J5uo75Hb8QcYJUBQCk9EYRrnPixozLBh5f
	 0ecw30osvZynEPGhWjI0YUJPL9G5ajBtHspGWTGmiyllIp1E1PNhzk4JH6iblkHj21
	 2ZWysB3jem2ZBj1PhHECO+QYbK1dfz9L3+tvJwW9qN1SONmYP93KflpJu1WHFjXlmO
	 JplTnVrVGN0uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A73B96077C;
	Tue, 29 Sep 2026 00:22:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D1E4261
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6E7240252
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YdCbBfcFjfMn for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6331340247
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641344;
 b=P3eZrskJVp+cnr/ZldzjJwKuW9hOOmqQrl8AG2xBqs2Btwi+Ox8j23HCXlGhBijZ34Ok
 xrBOOgRx/UD9nMhdKycioJsF7h1wDj1A+k4koT/n9qllU4fljn1QEn+jjnFVAIkkL6ef+
 qQyJwTaW5c84NQstQd0yoCm5gxtNG7uc1EsDQArNjJABbpgEzsG8aOToOt7r9VZnwk7tc
 z8vgweyJ8Fo8nOXeEUK1XuyijPso1NgbORCP58awqLIkrQYaNR0zFdZqj5z+JkCAzxO+W
 TAz3I+Kb5IERgjziV2XsPbQUXeNqvAKeU+PZGnJjJTn7oQZpdILh0oYZxDO9Frquhqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641344;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=bA0axyMWBO918tpVe1aLhArqroTRVFLXBe96WPLevIM=;
 b=jglK2/uwPQb2UWTNShkwpsOLzFFxAqUL7MimlXVa6CuBGHp+Sw9vH17fwUo/phBT963y
 cH0nBD6CF3HAHRx/AUgjNgbIJinpDjyrHqwd5JhSPMPeYy9dv2rM2AMkRZdYG4WIAMV2B
 C4I8StmZH/IceUSE7T7BPCrksYQ6owBgEXw1d4sckhwoeu4GQFJ7GMjnbQ6m4MT+yZQG0
 Z6IjxvwenBnutbgFZotsGXYxrKeSwVSP8/czLDYubJNcTMqnyJNijqtqSJxu1huZ67Rue
 Tf/z5X4VRxzN/BhvVHFse5DCcDp9dAVflE7qw1re+/ZlSMWMRCgFuy/R30RnQLPC1Iw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YjmvLIIW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YjmvLIIW
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6331340247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:24 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccdd7695so1451676fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641343; x=1791246143;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bA0axyMWBO918tpVe1aLhArqroTRVFLXBe96WPLevIM=;
 b=YjmvLIIWZZTQElbSoeJ8MWny3C8cprhG+mxZKjtMUDmPhKKkp94Xk4H5N9q6tPM6HD
 W4in9/6v4ITxQf0pIIJGNqpRFXmxgtlEXmt0il6sFCHk+l4Kkdtd0PJz4zXGAr2/1Qk6
 KTWdgqevFDb1QgJgud88jCN2Oq9FSvCy/0u3IRlncpC8oqbnEFzy+EDvEMZhUIpNIZyZ
 0S2P7QLZOaLU3EMXwpLp5MX/wr9qAyGJPTx0BsZb4r2I71wWC6oVVyZ4WydjPTYkJodU
 TLrpDqhb9/ccO6qA/LXVfdOq2W4dHfszQpA8Pr9r1LPtfGTpMA4fnyeQBFgncQa65J8q
 l9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641343; x=1791246143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bA0axyMWBO918tpVe1aLhArqroTRVFLXBe96WPLevIM=;
 b=fSgIarri2mYm7pOtsniO+v4N1YvN3k1BKcljOi/6JFI9IJpqZJMd7gfv2VZHhO18jA
 k/eZumYySRDVNDNDs/Y1saUTOJfoLKh33DLbG+6hrYIUC+NEcuB5GlWry/IrGpuAUhc7
 ta/WLQDY/hQbtND0NG/NnSLMUHlvfngMI3pTNlWb5N/sf2ZYIEiIe94DmtI2bj6Wcd2z
 sptx2oZjv/AAK/d+TuTKgnEORvfOyJuM8hE7v6QT+adjC2G1qNfZ4jwfJDpLnWrkAN7+
 N3IoJ7m/ENnnHuOfhx+6BeUufs+QFFexcyvdWGNdWRixMQEdnAYgiNZ+Turi7lM30uhX
 SOIQ==
X-Gm-Message-State: AFuF++kUKn5+FzNaumA2uAz0W4wW6mDpMYKCnWoYrfZnHrP58UX6QmXN
 /cxoqVW0TA9AmSFCmq2jRuDxu9XOIaWXK38o8J8rb7/uFQpVQxSUjTzr
X-Gm-Gg: AYBFou0wigkUiCINSwhu8ZQxWw8eZRSiEWGVZ7/hT/uK2NZx9GjE9O6+F+xknMoQpLB
 tf6oGupwGqFA3e85rv+6FMhcaZsJ7XwQD5BeM8SVuKqY+Vp7iDLb2RhKq2WMDwBEMgug8NBQRHd
 /oiHSlahX8u6AaekeeNxgPE7j48pS06WyqSnRB2mqT4HhkHtdm0qL/rg6Xm7h+vaFlsB1kjX5Wj
 /hIS5k3GSHsIieRiGrJHUwJQhmpkUo/nIbkvpuPrMgP65VsPyaVpRl3CQr+eqPaJXYFwDwXc6/F
 ksSGA8kufoR+80wFsKyO3CUBA9i7D6i63B4cSEm46HmbTeCV4s8UL/zQ7ag9CqHSaHsdSg5pUS6
 A++rpcbLobbWsiERwB/CM8o6xuCY27WzGxvVe9rGiMnjGFz0C4YDogks9gRpf2yBh2XjqxJffDu
 iK8ZOVbkyeHnQB/VjW35b0yVhLdf4bvEzzb735wRZIEbdx57iossQaD+mY32UpI8e7OcgRcufAk
 ik/768URkOcNMqa6pTpZe3gHd6a+Q/fjqoYzxUYE0KaXkbhYAQVUc8NXSsJDPQmNlIE6WiSvSKK
 mKshhC1D3mvfMHX11L2So0a4YC25RjQ3kTygvL+/MHGwH4GgziJRAFs5wTmcuGIibkZs1DwdlvU
 FxW4N5EqYEKI/RPxHsxM0
X-Received: by 2002:a05:6808:190b:b0:4c3:b4b6:94a7 with SMTP id
 5614622812f47-4d72af50e6emr14677886b6e.27.1790641343045; 
 Mon, 28 Sep 2026 17:22:23 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:54 -0600
Subject: [PATCH 17/20] test: net: exercise lwIP ProxyDHCP ordering and
 validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-17-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

Drive real DHCP packets through the sandbox Ethernet device. Exercise
replies before the offer, during REQUEST, after the ACK and through a
delayed timer during the proxy wait. Cover first-proxy selection, fixed
boot filenames, server-ID fallback, missing replies, cancellation, NAK
restart and a proxy without any address lease.

Reject mismatched transaction IDs and hardware addresses, wrong source
ports, malformed options, bad cookies, invalid server addresses and
non-PXE replies. Verify that a different server cannot acknowledge the
lease, and that proxy data cannot replace the lease gateway or root
path. Check explicit filenames, configured server preferences and
separate EFI ACK/proxy caches. Run the same cases with proxy support
disabled.

Renew during the post-bind wait and reject both malformed boot metadata
and an ACK without a server identifier. Check that the original root
path, boot filename and EFI ACK remain intact.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/Makefile          |   1 +
 test/dm/lwip_dhcp_proxy.c | 461 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 462 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 564980c122c..c4f87c1d6da 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -55,6 +55,7 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_DHCP),yy)
 obj-y += lwip_dhcp.o
 obj-y += lwip_dhcp_options.o
+obj-y += lwip_dhcp_proxy.o
 obj-y += lwip_dhcp_policy.o
 endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
diff --git a/test/dm/lwip_dhcp_proxy.c b/test/dm/lwip_dhcp_proxy.c
new file mode 100644
index 00000000000..7f80b2c2db0
--- /dev/null
+++ b/test/dm/lwip_dhcp_proxy.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <efi_loader.h>
+#include <env.h>
+#include <malloc.h>
+#include <net.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <lwip/dhcp.h>
+#include <lwip/prot/dhcp.h>
+#include <lwip/timeouts.h>
+#include <test/ut.h>
+
+enum proxy_case {
+	PROXY_BEFORE,
+	PROXY_DURING,
+	PROXY_AFTER,
+	PROXY_LATE,
+	PROXY_HEADER_FILE,
+	PROXY_NO_SIADDR,
+	PROXY_SECOND,
+	PROXY_NONE,
+	PROXY_BAD_XID,
+	PROXY_BAD_MAC,
+	PROXY_BAD_PORT,
+	PROXY_BAD_COOKIE,
+	PROXY_BAD_LENGTH,
+	PROXY_BAD_VENDOR,
+	PROXY_BAD_SERVER,
+	PROXY_BAD_HTYPE,
+	PROXY_BAD_HLEN,
+	PROXY_MENU_ONLY,
+	PROXY_NAK_RESTART,
+	PROXY_WRONG_ACK_SERVER,
+	PROXY_IGNORED_ACK,
+	PROXY_RENEW_BAD_OPTION,
+	PROXY_RENEW_NO_SERVER,
+	PROXY_NO_LEASE,
+	PROXY_CANCEL,
+	PROXY_CASES,
+};
+
+struct proxy_test {
+	enum proxy_case kind;
+	struct udevice *dev;
+	struct dhcp_msg request;
+	struct efi_pxe_packet ack;
+	struct efi_pxe_packet proxy;
+	u32 xid;
+	unsigned int discovers;
+	unsigned int requests;
+	bool wrong_requested_ip;
+	bool delayed_bound;
+	int delayed_error;
+};
+
+static u8 *proxy_option(u8 *p, u8 code, const void *data, u8 len)
+{
+	*p++ = code;
+	*p++ = len;
+	memcpy(p, data, len);
+
+	return p + len;
+}
+
+static int proxy_reply(struct proxy_test *test, struct dhcp_msg *request, u8 type, bool proxy)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(test->dev);
+	static const u8 mask[] = { 255, 255, 255, 0 };
+	static const u8 server[] = { 1, 1, 2, 2 };
+	static const u8 proxy_server[] = { 1, 1, 2, 5 };
+	static const u8 lease[] = { 0, 0, 0x0e, 0x10 };
+	bool renewal = !proxy && type == DHCP_ACK && test->requests > 1 &&
+		(test->kind == PROXY_RENEW_BAD_OPTION || test->kind == PROXY_RENEW_NO_SERVER);
+	struct ethernet_hdr *eth;
+	struct ip_udp_hdr *ip;
+	struct dhcp_msg *reply;
+	u8 *p;
+	size_t len;
+
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memset(eth->et_dest, 0xff, ARP_HLEN);
+	memcpy(eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->et_protlen = htons(PROT_IP);
+	ip = (void *)(eth + 1);
+	memset(ip, 0, IP_UDP_HDR_SIZE);
+	reply = (void *)(ip + 1);
+	memset(reply, 0, sizeof(*reply));
+	reply->op = DHCP_BOOTREPLY;
+	reply->htype = 1;
+	reply->hlen = ARP_HLEN;
+	reply->xid = request->xid;
+	memcpy(reply->chaddr, request->chaddr, sizeof(reply->chaddr));
+	reply->cookie = htonl(DHCP_MAGIC_COOKIE);
+	if (!proxy && type != DHCP_NAK)
+		put_unaligned_be32(0x01010203, &reply->yiaddr);
+	put_unaligned_be32(proxy ? 0x01010205 : 0x01010204, &reply->siaddr);
+	p = proxy_option(reply->options, 53, &type, 1);
+	if (!renewal || test->kind != PROXY_RENEW_NO_SERVER)
+		p = proxy_option(p, 54, proxy ? proxy_server : server, sizeof(server));
+	p = proxy_option(p, 1, mask, sizeof(mask));
+	p = proxy_option(p, 51, lease, sizeof(lease));
+	p = proxy_option(p, 3, server, sizeof(server));
+	p = proxy_option(p, 6, server, sizeof(server));
+	p = proxy_option(p, 17, proxy || renewal ? "/wrong" : "/lease", 6);
+	if (renewal && test->kind == PROXY_RENEW_BAD_OPTION)
+		p = proxy_option(p, 67, "bad\0file", 8);
+	if (proxy) {
+		p = proxy_option(p, 60, test->kind == PROXY_BAD_VENDOR ? "NotPXE123" :
+				 "PXEClient", 9);
+		if (test->kind == PROXY_HEADER_FILE) {
+			strcpy((char *)reply->file, "proxy.bin");
+		} else if (test->kind != PROXY_MENU_ONLY) {
+			p = proxy_option(p, 67, "proxy.bin", 9);
+			p = proxy_option(p, 209, "pxelinux.cfg/proxy", 18);
+		}
+		if (test->kind == PROXY_BAD_XID)
+			reply->xid ^= htonl(1);
+		if (test->kind == PROXY_BAD_MAC)
+			reply->chaddr[0] ^= 1;
+		if (test->kind == PROXY_BAD_COOKIE)
+			reply->cookie ^= htonl(1);
+		if (test->kind == PROXY_BAD_HTYPE)
+			reply->htype = 2;
+		if (test->kind == PROXY_BAD_HLEN)
+			reply->hlen = 5;
+		if (test->kind == PROXY_BAD_SERVER)
+			put_unaligned_be32(0xe0000001, &reply->siaddr);
+		if (test->kind == PROXY_NO_SIADDR || test->kind == PROXY_MENU_ONLY)
+			put_unaligned_be32(0, &reply->siaddr);
+		if (test->kind == PROXY_BAD_LENGTH) {
+			*p++ = 67;
+			*p++ = 30;
+		}
+	} else if (test->kind != PROXY_IGNORED_ACK) {
+		/* Also exercise the fixed field: a later proxy must not clear it. */
+		strcpy((char *)reply->file, renewal ? "rejected.bin" : "lease.bin");
+	}
+	*p++ = DHCP_OPTION_END;
+	len = p - (u8 *)reply;
+	if (proxy) {
+		memset(&test->proxy, 0, sizeof(test->proxy));
+		memcpy(&test->proxy, reply, len);
+	} else if (type == DHCP_ACK && !renewal) {
+		memset(&test->ack, 0, sizeof(test->ack));
+		memcpy(&test->ack, reply, len);
+	}
+	ip->ip_hl_v = 0x45;
+	ip->ip_len = htons(IP_UDP_HDR_SIZE + len);
+	ip->ip_ttl = 64;
+	ip->ip_p = IPPROTO_UDP;
+	memcpy(&ip->ip_src, proxy ? proxy_server : server, sizeof(server));
+	ip->ip_dst.s_addr = htonl(0xffffffff);
+	ip->udp_src = htons(proxy && test->kind == PROXY_BAD_PORT ? 4011 : 67);
+	ip->udp_dst = htons(68);
+	ip->udp_len = htons(UDP_HDR_SIZE + len);
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+	priv->recv_packet_length[priv->recv_packets++] = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + len;
+
+	return 0;
+}
+
+static void proxy_delayed(void *arg)
+{
+	struct proxy_test *test = arg;
+
+	test->delayed_bound = dhcp_supplied_address(netif_default);
+	if (test->kind == PROXY_CANCEL)
+		console_in_puts("\x03");
+	else if (test->kind == PROXY_RENEW_BAD_OPTION || test->kind == PROXY_RENEW_NO_SERVER)
+		/* Exercise renewal during the proxy wait without changing timers. */
+		test->delayed_error = test->delayed_bound ? dhcp_renew(netif_default) : ERR_VAL;
+	else
+		test->delayed_error = proxy_reply(test, &test->request, DHCP_OFFER, true);
+}
+
+static int proxy_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct proxy_test *test = priv->priv;
+	struct ethernet_hdr *eth = packet;
+	struct ip_udp_hdr *ip = (void *)(eth + 1);
+	struct dhcp_msg *msg = (void *)(ip + 1);
+	u8 *p = msg->options, *end = (u8 *)packet + len, type = 0;
+	int ret;
+
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + DHCP_OPTIONS_OFS ||
+	    eth->et_protlen != htons(PROT_IP) || ip->ip_p != IPPROTO_UDP ||
+	    ip->udp_dst != htons(67))
+		return 0;
+	test->dev = dev;
+	while (p < end && *p != 255) {
+		u8 code = *p++, size;
+
+		if (!code)
+			continue;
+		if (p == end)
+			return -EINVAL;
+		size = *p++;
+		if (size > end - p)
+			return -EINVAL;
+		if (code == 53 && size == 1)
+			type = *p;
+		if (code == 50 && (size != 4 || get_unaligned_be32(p) != 0x01010203))
+			test->wrong_requested_ip = true;
+		p += size;
+	}
+	if (type == DHCP_DISCOVER) {
+		test->discovers++;
+		test->xid = msg->xid;
+		if (test->kind == PROXY_BEFORE || test->kind == PROXY_NO_LEASE ||
+		    (test->kind == PROXY_NAK_RESTART && test->discovers == 1)) {
+			ret = proxy_reply(test, msg, DHCP_OFFER, true);
+			if (ret)
+				return ret;
+		}
+		if (test->kind == PROXY_NO_LEASE) {
+			timer_test_add_offset(10001);
+			return 0;
+		}
+		return proxy_reply(test, msg, DHCP_OFFER, false);
+	}
+	if (type != DHCP_REQUEST)
+		return 0;
+	test->requests++;
+	if (test->kind == PROXY_NAK_RESTART && test->requests == 1)
+		return proxy_reply(test, msg, DHCP_NAK, false);
+	if (test->kind == PROXY_DURING) {
+		ret = proxy_reply(test, msg, DHCP_OFFER, true);
+		if (ret)
+			return ret;
+	}
+	if (test->kind == PROXY_WRONG_ACK_SERVER) {
+		struct dhcp_msg *bad;
+
+		ret = proxy_reply(test, msg, DHCP_ACK, true);
+		if (ret)
+			return ret;
+		bad = (void *)(priv->recv_packet_buffer[priv->recv_packets - 1] +
+			       ETHER_HDR_SIZE + IP_UDP_HDR_SIZE);
+		put_unaligned_be32(0x01010209, &bad->yiaddr);
+	}
+	ret = proxy_reply(test, msg, DHCP_ACK, false);
+	if (ret)
+		return ret;
+	if (test->kind == PROXY_IGNORED_ACK) {
+		struct dhcp_msg *bad;
+
+		/*
+		 * A matching MAC/XID alone does not make this a selected ACK.
+		 * Deliver it after binding, while the proxy wait still polls.
+		 */
+		ret = proxy_reply(test, msg, DHCP_ACK, true);
+		if (ret)
+			return ret;
+		bad = (void *)(priv->recv_packet_buffer[priv->recv_packets - 1] +
+			       ETHER_HDR_SIZE + IP_UDP_HDR_SIZE);
+		put_unaligned_be32(0x01010209, &bad->yiaddr);
+		strcpy((char *)bad->file, "ignored.bin");
+		return 0;
+	}
+	if (test->kind == PROXY_SECOND) {
+		struct efi_pxe_packet first;
+		struct dhcp_msg *second;
+
+		ret = proxy_reply(test, msg, DHCP_OFFER, true);
+		if (ret)
+			return ret;
+		first = test->proxy;
+		ret = proxy_reply(test, msg, DHCP_OFFER, true);
+		if (ret)
+			return ret;
+		second = (void *)(priv->recv_packet_buffer[priv->recv_packets - 1] +
+				  ETHER_HDR_SIZE + IP_UDP_HDR_SIZE);
+		put_unaligned_be32(0x01010206, &second->siaddr);
+		test->proxy = first;
+		return 0;
+	}
+	if (test->kind == PROXY_LATE || test->kind == PROXY_CANCEL) {
+		memcpy(&test->request, msg, DHCP_OPTIONS_OFS);
+		sys_timeout(5, proxy_delayed, test);
+	} else if ((test->kind == PROXY_RENEW_BAD_OPTION ||
+		    test->kind == PROXY_RENEW_NO_SERVER) && test->requests == 1) {
+		sys_timeout(5, proxy_delayed, test);
+	} else if (test->kind == PROXY_AFTER || test->kind == PROXY_HEADER_FILE ||
+		   test->kind == PROXY_NO_SIADDR ||
+		   (test->kind >= PROXY_BAD_XID && test->kind <= PROXY_MENU_ONLY)) {
+		return proxy_reply(test, msg, DHCP_OFFER, true);
+	}
+
+	return 0;
+}
+
+static int proxy_check(struct unit_test_state *uts, struct proxy_test *test)
+{
+	struct efi_pxe_mode *mode = NULL;
+	char * const argv[] = { "dhcp", "2000000", "explicit.bin" };
+	bool enabled = IS_ENABLED(CONFIG_SERVERIP_FROM_PROXYDHCP);
+	unsigned int delay = 0;
+	int kind;
+
+	if (enabled)
+		delay = IF_ENABLED_INT(CONFIG_SERVERIP_FROM_PROXYDHCP,
+				       CONFIG_SERVERIP_FROM_PROXYDHCP_DELAY_MS);
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("bootpretransmitperiodinit", "5000"));
+	ut_assertok(env_set("bootpretransmitperiodmax", "60000"));
+	ut_assertok(env_set("bootpretryperiod", "10000"));
+	ut_assertok(env_set("bootp_arch", NULL));
+	ut_assertok(env_set("pxeuuid", NULL));
+	ut_assertok(env_set("bootp_vci", "PXEClient:Arch:00022:UNDI:000000"));
+	for (kind = 0; kind < PROXY_CASES; kind++) {
+		bool selected = enabled && kind <= PROXY_SECOND &&
+			(kind != PROXY_LATE || delay >= 10);
+		bool cancel = kind == PROXY_CANCEL && enabled && delay >= 10;
+		bool renewal = kind == PROXY_RENEW_BAD_OPTION || kind == PROXY_RENEW_NO_SERVER;
+		unsigned long start, elapsed;
+		int ret;
+
+		if ((kind == PROXY_LATE || kind == PROXY_CANCEL) && delay && delay < 10)
+			continue;
+		if (renewal && (!enabled || delay < 10))
+			continue;
+		*test = (struct proxy_test){ .kind = kind };
+		ut_assertok(env_set("serverip", "9.8.7.6"));
+		ut_assertok(env_set("tftpserverip", "9.9.9.9"));
+		ut_assertok(env_set("bootfile", "default.bin"));
+		ut_assertok(env_set("rootpath", "/original"));
+		clear_ctrlc();
+		start = get_timer(0);
+		ret = do_dhcp(NULL, 0, 1, argv);
+		elapsed = get_timer(start);
+		sys_untimeout(proxy_delayed, test);
+		clear_ctrlc();
+		ut_assertf(ret == (kind == PROXY_NO_LEASE || cancel ? CMD_RET_FAILURE : 0),
+			   "case %d: return %d, delayed %d", kind, ret, test->delayed_bound);
+		ut_assertnull(netif_default);
+		ut_assert(!test->wrong_requested_ip);
+		if (kind == PROXY_NO_LEASE || cancel) {
+			ut_asserteq_str("default.bin", env_get("bootfile"));
+			continue;
+		}
+		ut_asserteq(kind == PROXY_NAK_RESTART ? 2 : 1, test->discovers);
+		ut_asserteq(kind == PROXY_NAK_RESTART || renewal ? 2 : 1, test->requests);
+		ut_asserteq_str("1.1.2.3", env_get("ipaddr"));
+		ut_asserteq_str("255.255.255.0", env_get("netmask"));
+		ut_asserteq_str("1.1.2.2", env_get("gatewayip"));
+		ut_asserteq_str(IS_ENABLED(CONFIG_BOOTP_BOOTPATH) ? "/lease" : "/original",
+				env_get("rootpath"));
+		ut_asserteq_str(selected ? "proxy.bin" :
+				kind == PROXY_IGNORED_ACK ? "default.bin" : "lease.bin",
+				env_get("bootfile"));
+		if (IS_ENABLED(CONFIG_BOOTP_SERVERIP) ||
+		    IS_ENABLED(CONFIG_BOOTP_PREFER_SERVERIP)) {
+			ut_asserteq_str("9.8.7.6", env_get("serverip"));
+			ut_assertnull(env_get("tftpserverip"));
+		} else {
+			ut_asserteq_str(selected ? "1.1.2.5" : "1.1.2.2", env_get("serverip"));
+			ut_asserteq_str(selected ? "1.1.2.5" : "1.1.2.4", env_get("tftpserverip"));
+		}
+		if (selected && kind != PROXY_HEADER_FILE &&
+		    IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION))
+			ut_asserteq_str("pxelinux.cfg/proxy", pxelinux_configfile);
+		else
+			ut_assertnull(pxelinux_configfile);
+		if (kind == PROXY_NONE && enabled)
+			ut_assert(elapsed >= delay && elapsed < delay + 1000);
+		if ((kind == PROXY_LATE && selected) || renewal) {
+			ut_assert(test->delayed_bound);
+			ut_assertok(test->delayed_error);
+		}
+		if (CONFIG_IS_ENABLED(EFI_LOADER)) {
+			bool valid, ack_equal, proxy_valid, proxy_equal;
+
+			mode = calloc(1, sizeof(*mode));
+			ut_assertnonnull(mode);
+			efi_net_get_dhcp_ack(eth_get_dev(), mode);
+			valid = mode->dhcp_ack_received;
+			ack_equal = !memcmp(&mode->dhcp_ack, &test->ack, sizeof(test->ack));
+			proxy_valid = mode->proxy_offer_received;
+			proxy_equal = !memcmp(&mode->proxy_offer, &test->proxy,
+					      sizeof(test->proxy));
+			free(mode);
+			ut_assert(valid && ack_equal);
+			ut_asserteq(selected, proxy_valid);
+			if (selected)
+				ut_assert(proxy_equal);
+		}
+	}
+	*test = (struct proxy_test){ .kind = PROXY_BEFORE };
+	ut_assertok(do_dhcp(NULL, 0, 3, argv));
+	ut_asserteq_str("explicit.bin", env_get("bootfile"));
+
+	return 0;
+}
+
+static int dm_test_lwip_dhcp_proxy(struct unit_test_state *uts)
+{
+	static const char * const vars[] = {
+		"ethact", "autoload", "bootfile", "bootp_arch", "bootp_vci", "pxeuuid",
+		"serverip", "tftpserverip", "ipaddr", "netmask", "gatewayip", "dnsip", "dnsip2",
+		"rootpath",
+		"bootpretransmitperiodinit", "bootpretransmitperiodmax", "bootpretryperiod",
+	};
+	char *saved[ARRAY_SIZE(vars)] = {};
+	char file[sizeof(net_boot_file_name)];
+	char *config = pxelinux_configfile;
+	u32 size = net_boot_file_expected_size_in_blocks;
+	struct proxy_test *test;
+	int ctrlc_state;
+	int i, ret = -ENOMEM;
+
+	test = calloc(1, sizeof(*test));
+	ut_assertnonnull(test);
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	memcpy(file, net_boot_file_name, sizeof(file));
+	pxelinux_configfile = NULL;
+	sandbox_eth_set_tx_handler(0, proxy_tx);
+	sandbox_eth_set_priv(0, test);
+	ctrlc_state = disable_ctrlc(0);
+	ret = proxy_check(uts, test);
+	sys_untimeout(proxy_delayed, test);
+	clear_ctrlc();
+	disable_ctrlc(ctrlc_state);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	memcpy(net_boot_file_name, file, sizeof(file));
+	net_boot_file_expected_size_in_blocks = size;
+	free(pxelinux_configfile);
+	pxelinux_configfile = config;
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+out:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+	free(test);
+
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_dhcp_proxy, UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.53.0

