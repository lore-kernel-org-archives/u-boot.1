Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A3606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y+wmuP50;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=Ny7U6rL/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4ED0D6066C;
	Tue,  3 Nov 2026 18:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYhURxSg0whb; Tue,  3 Nov 2026 18:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82DB9606BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793731877;
	b=DvfAWecU+CPBp1XqU8pzj0WTUr4FPEsNw2xVWFYJ9OYnaOChSdAKmClq3K+K/dnotRuP
	 lYm8C6IPrRGrrjkIGiNlH7IfjyUARvmSEGVTqJkpV9OgrHN/kXvyjRYIKC4DSdgSdUCRg
	 kLBwTEAkr+HJ58Rxh/N5JnyN/g14/ljXxscbIfv+lAM7ZVBgFwwDUE9p+EqJpMyPHUEk3
	 1vpDslm8+i276Jt4kE7lDnu99l+AbfCh6ug64kYGRH2Cr04SUKSLWWflEvRCWP00j+ud1
	 Aduezv2Zb7zO34LyHD+BSAyPyanSpX8DglOcF1Dj4b1oOBRvoH0RXBs5tdyzwc8bvQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HHonhkK08GQRHa6oTLUtTnKhvN4W/LPKC4VRTitT/2Q=;
	b=bvFMUGMePRw/r1XHLBBke9zh8b+9iGMA7OrZKmopDTvsXSV0hjo5lDJO2cF7/TgLftf9
	 VAbm4LrNEV9n7yo3aLE3Gt6Ape42TGO69hBD0s+IESjj150bJ2BTyZbfYvzPIJtw04w78
	 zfx8g5N7n+68y52GyEHsHVjoiC9fzotGHErqBr3GYO7WqzU/oLaj4l+nSFaUq6BAg3aTc
	 hLKdFjNgSpsOKlonc7mcWcAeM09WI6WHwqiLbzK4jTBi6uajYWR7ujyh9lk8eLLkAU3v3
	 UJhCAvysVfiGtLlEKz9quiIYch5kEUAJswuO6nBMYwYBuhJC3TBcjwjsTVDes13PPyg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793731877;
	bh=HHonhkK08GQRHa6oTLUtTnKhvN4W/LPKC4VRTitT/2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+wmuP50GvDA0hxY2DkkKCfn0WCxNZiHX6Wza79A5x8yBWZXHCzD+oL5E7ovHSw4t
	 WhRLRk/jtzDF6oFehtPhpsQuyRmSnEpx59LkP+2xksK6vkpJOOK3HbVBN62ZH8TSnp
	 FeIe9CkbkXf+Y1JGeWUv5ISfLAxEJeA6u7te7vFc1F7IMAJxuj7UC0ASYpSrKSCAva
	 yXF8iacaOovprSeavknzXdjeCdHDa9syZvUdcjbU2z2cgZTfWUAMnujr3D6GG47EtP
	 H+AEvQ34MScqTSpLpar3qZePDouq9M5zpGNgIgx/flkVD2eJra2SnnzQPUPriMAQOI
	 6lGz5ad2Cohcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82DB9606BD;
	Tue,  3 Nov 2026 18:51:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 959BC784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 877C440062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ojAi0kyg71Ba for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:44:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D4B48400BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793731469;
 b=VIRqmDvIWSNsdeaGIy4elchPqz8aLOuAUqCQ0Rxklf6teKlUZpYaUjiJAR9133jlwXo0
 p8feDgaQNBoC7dREZVEVuHvn9x66cEUzZO1rHi3xLPK/XcOKNYqtFXBu/e8A5nkXd+CM1
 Sk5pHHTV4ciHuHBuBBb/Jf3RKo/adGvnQJDL2Fa1Ugf5TrHgHoOvVThJGPKdEGH8smShj
 YkeI1vT5hc/tzpr1o/iuzAtEhkfM1gCRgM5IJJ9U1wwIXh+eKQrr+04ogENp9Jr2sVpKp
 5EO1MlyjpRFQlDd9fGDabfRCTczpLH24hBsV8MaQO3m/u+ZqDYAi9dnfXDf3tcdjTeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793731469;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=HHonhkK08GQRHa6oTLUtTnKhvN4W/LPKC4VRTitT/2Q=;
 b=IlIg4YZ/v/d7IgcuWgkCZ8Ez2DfjUdvs3a8st8QrWHC/FsVF/zpSelpQXXoIIz5aDSjg
 PUYkw89reW25wI7fsW+IqRAj2YolVYR51woNW1Aj53wobPx7nH1W7fAdnQDb3aWx0mjVP
 H6af0qvKdixbMewdteI22UuDw406pKm8AnScpy+Gf1Hxb8RsLFUBq3dzPGlDaeIWtSkrq
 yMSW+tCGnGnCgvfJWSdnHvTU0yH1UqpMR2ck1XAfKjkITAoL0rYqIY3PQ9+A4aVLRlAzI
 s4/t2y3ktLGLPDbOET8/cWYyOboN55oKxAwka75rEHyrzQU2klthGt32bvNFYcionhg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=t0.technology;
 dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256
 header.s=google header.b="Ny7U6rL/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=Ny7U6rL/
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4B48400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:29 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3b08a162d4bso472716a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793731469; x=1794336269;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HHonhkK08GQRHa6oTLUtTnKhvN4W/LPKC4VRTitT/2Q=;
 b=Ny7U6rL/p3ACJMD8h3z6AEJGFpDYjkgkitmB37h8EV1cjWkmE5hebwdcwCwiHP7mRL
 jxAXZd3w7vLHnWRpbol0g2HdFZDwc/TiRTrZpHt5tuB9cWXUPWglRF0opNZpa9wfdfhv
 9gq7PtOIM1gp/RkFnMS7FKE7cD5wPE3JZqe6eZlpw08gNb4tjmMA9URTATxUWvgsIFnZ
 +fleLPHHl4yEL606+4Q2Nu5w8WsLq27QP5DWrzhteMINd5Ct3Yhx1X2eRBoDaQSrvxSr
 17vcwaEm7lI+10KcKRc+10c43Ze4Er3Mf+RqXPeNsklItHjTHeXiFNV7eISWhzKBR0WD
 L4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731469; x=1794336269;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HHonhkK08GQRHa6oTLUtTnKhvN4W/LPKC4VRTitT/2Q=;
 b=iatvGupKaFCsiAjXBaWgH+5YhXr3ghyBMUmboweGWMCvoUgyrq/rEMM1IovZStr5fe
 f8uq1cJ4xGs3CEN0zHy+r/4ztzVyCmgnA0iIK9JYGixCxKKD4/ASO7uxa3DHsFPU69Xz
 fX6D3BOpghc5KGGn+MJi8scSYf1jH6E2Byu557l6jvIZADX6Uchp0uJVScmO+aJ8WwMl
 153LAGLY+qs4qSLAXXQTxO4FqyY9o0F5WCtt91LsfgnMhWN1L6tGXSmyCOz0J/7aoJ6J
 QlSWQ173ef2XPf4fChxbl8VmErO0/nwqGVKB5oWQwLCF/e86cMJe448iLx0C6O+E7bXj
 j6+w==
X-Gm-Message-State: APuU4Z8lg4xd/GXvQJBwnhbTUCuFAl0K3FdvuskQZhyyJLf1eNGridT3
 4+gi4ASmSvJTeKhdONHa01aktVTHrfT/cWMUmmkygUdfKq0ZK2as+U76v9u1OndalO8=
X-Gm-Gg: AYBFou18rdEjHWdNUgXueAr8NDSVkTxMsCCFOZpBSmJHgSNGK6ULpjXmEzTxWcIBhV/
 EemE47UyvSFkcEcOgbNqfTQpA56ZriL7PZbdtf/4IQcl8hLrWP2Rp5arT7zVYY/QCqBE9yTC/XW
 3vV4CDZlNjmByCOFFUjdsKsQztGkcl0Y2BQZVpeOwNrqK6uPa2J+Ykuv4p/Q4aDPA0B7ONvg6CU
 zLyTZV22sg0Zz5WpZefHmZqUH+SKK0MsbbfhfuOAVZjOS8JLQbaYfa39Jvq3uptEMxa6i3qH5BT
 lIKVF2UPOmBt7zB5+DRIUo26Jm7WTApOpsfIIinx11jTKRlyiR+RdeK9Rx8GuKhVzyzdIJmOWxy
 SCLAprtZQWdsw8BPK74usrB66fYxhJRadkdmfUwA+unir7XbYMbSgMPZesTr6/6dyuiyH2x1bSR
 qWL151pWRZRkg3NiXFSWiUTTGVd984anYgdfyYT8tdi+YgDJapeI/7s8GLf8Fiq0WdMmB60fudx
 ld/yHuGyLakDgQwlPaWjcBO+wH16ouyPQ3be9NG2nHcgjgP4S5DWUnCsrnbJQ5/+u8/9Hzxmznu
 ESyojF8PQXaFL/ZpHzk6G35MiLcOqxfM99poMV23Dc5zA/hiuLRXiinLp2Rr+ioC6qIWZxc3LU9
 W
X-Received: by 2002:a17:90b:1a85:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-3ae898194acmr11884360a91.36.1793731468809; 
 Tue, 03 Nov 2026 10:44:28 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae880b1f71sm11496613a91.4.2026.11.03.10.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:44:28 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Tue, 03 Nov 2026 11:43:23 -0700
Subject: [PATCH v3 2/4] net: zynq_gem: plug resource leaks in .probe error path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-zynq-gem-remove-leak-v3-2-2f02ec0023f9@t0.technology>
References: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
In-Reply-To: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731408; l=4596;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=ZzRO/AH1twHnuEjmmhGANvoP+z7iow06xRbYVSPZ7bI=;
 b=9q672mY/cLFUbNcQC1ClRdJ9DCMXQuHOZrp8KCNEl0frDXYhRRsrr+PSIFGxCnxiP7ECJEguK
 lO17DFaXj9CB9vzC96Wc7ms8VwxzwlAsS6TEJw6Cy+tU/tB4pBNL2rw
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Tue, 03 Nov 2026 18:51:12 +0000
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

zynq_gem_probe() acquires a generic PHY (for SGMII), receive buffers,
buffer descriptor space, (usually) an MDIO bus and a phy_device, but
leaks some or all of these on its error paths:

- the generic PHY is initialised but never exited on failure;
- a failed mdio_register_seq() leaks the bus from mdio_alloc(), whose
  return value is also not checked;
- the phy_device from zynq_phy_init() is leaked if a later step fails;
- the SGMII dynamic-config and generic_phy_power_on() failures return
  directly, leaking everything allocated before them.

Rework the error path into a single label ladder covering all of
these. As in remove(), the phy_device is only freed when the MDIO bus
is our own. Zero-initialise the local struct phy so generic_phy_exit()
is a safe no-op when no generic PHY was obtained.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
 drivers/net/zynq_gem.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index d28b97d01d08da50049280fe2f75277506a4b740..c15d2fc1318b42951648efe7ea67c6559589725a 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -930,7 +930,7 @@ static int zynq_gem_probe(struct udevice *dev)
 	void *bd_space;
 	struct zynq_gem_priv *priv = dev_get_priv(dev);
 	int ret;
-	struct phy phy;
+	struct phy phy = {};
 
 	if (priv->interface == PHY_INTERFACE_MODE_SGMII) {
 		ret = generic_phy_get_by_index(dev, 0, &phy);
@@ -946,12 +946,14 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	ret = zynq_gem_reset_init(dev);
 	if (ret)
-		return ret;
+		goto err_phy_exit;
 
 	/* Align rxbuffers to ARCH_DMA_MINALIGN */
 	priv->rxbuffers = memalign(ARCH_DMA_MINALIGN, RX_BUF * PKTSIZE_ALIGN);
-	if (!priv->rxbuffers)
-		return -ENOMEM;
+	if (!priv->rxbuffers) {
+		ret = -ENOMEM;
+		goto err_phy_exit;
+	}
 
 	memset(priv->rxbuffers, 0, RX_BUF * PKTSIZE_ALIGN);
 	ulong addr = (ulong)priv->rxbuffers;
@@ -963,7 +965,7 @@ static int zynq_gem_probe(struct udevice *dev)
 	bd_space = memalign(1 << MMU_SECTION_SHIFT, BD_SPACE);
 	if (!bd_space) {
 		ret = -ENOMEM;
-		goto err1;
+		goto err_free_rx;
 	}
 
 	if (priv->cache_on)
@@ -977,21 +979,21 @@ static int zynq_gem_probe(struct udevice *dev)
 	ret = clk_get_by_name(dev, "tx_clk", &priv->tx_clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get tx_clock\n");
-		goto err2;
+		goto err_free_bd;
 	}
 
 	if (priv->clk_en_info & RXCLK_EN) {
 		ret = clk_get_by_name(dev, "rx_clk", &priv->rx_clk);
 		if (ret < 0) {
 			dev_err(dev, "failed to get rx_clock\n");
-			goto err2;
+			goto err_free_bd;
 		}
 	}
 
 	ret = clk_get_by_name(dev, "pclk", &priv->pclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get pclk clock\n");
-		goto err2;
+		goto err_free_bd;
 	}
 
 	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
@@ -999,6 +1001,10 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	if (!priv->bus) {
 		priv->bus = mdio_alloc();
+		if (!priv->bus) {
+			ret = -ENOMEM;
+			goto err_free_bd;
+		}
 		priv->own_bus = true;
 		priv->bus->read = zynq_gem_miiphy_read;
 		priv->bus->write = zynq_gem_miiphy_write;
@@ -1006,7 +1012,7 @@ static int zynq_gem_probe(struct udevice *dev)
 
 		ret = mdio_register_seq(priv->bus, dev_seq(dev));
 		if (ret)
-			goto err2;
+			goto err_free_bus;
 	}
 
 	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
@@ -1014,7 +1020,7 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	ret = zynq_phy_init(dev);
 	if (ret)
-		goto err3;
+		goto err_free_phydev;
 
 	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
 	    generic_phy_valid(&phy)) {
@@ -1026,13 +1032,13 @@ static int zynq_gem_probe(struct udevice *dev)
 					dev_err
 					(dev,
 					 "Failed to set gem dynamic config\n");
-					return ret;
+					goto err_free_phydev;
 				}
 			}
 		}
 		ret = generic_phy_power_on(&phy);
 		if (ret)
-			return ret;
+			goto err_free_phydev;
 	}
 
 	printf("\nZYNQ GEM: %lx, mdio bus %lx, phyaddr %d, interface %s\n",
@@ -1041,13 +1047,21 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	return ret;
 
-err3:
-	if (priv->own_bus)
+err_free_phydev:
+	if (priv->own_bus) {
+		if (!IS_ERR_OR_NULL(priv->phydev))
+			free(priv->phydev);
 		mdio_unregister(priv->bus);
-err2:
+	}
+err_free_bus:
+	if (priv->own_bus)
+		mdio_free(priv->bus);
+err_free_bd:
 	free(priv->tx_bd);
-err1:
+err_free_rx:
 	free(priv->rxbuffers);
+err_phy_exit:
+	generic_phy_exit(&phy);
 	return ret;
 }
 

-- 
2.47.3

