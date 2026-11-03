Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532E606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gXSXxYWe;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=F5av1uhw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE2CB4060C;
	Tue,  3 Nov 2026 18:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QzKa5VLaUnma; Tue,  3 Nov 2026 18:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DCF32405F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793731873;
	b=AJGkRoYcEe037bwAQuT5k94R2Dvz3dW4k7uIm95hgFqGV0Yad+LHLiJQZ4dr3AkxhZ6a
	 157Px6PMZibOh8TqsUjPxxsMcGOFE1DnSxoYCUvwIiP+hbhdAReSPtOqw7cZoYm0fgCV+
	 fl2HnN9+clioYHKyKb7RsmtWXwDyR7uHwpeJSIAQMxHehehJ95479DbZnvelSdCr0ZVgE
	 CyD8am26gAS6WkeYWFr/GPXRuthJIzoXUKrItK4DHodq1jenOVc8t/Wi7809k1YBThl3Z
	 mSkvS7CRYAVcFUfVEto0a1k/0vzfj2EuG8YD8R9BT9wnMJJsUx0g2YGOqBSe+0LuR9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6yR+dOWNI69My6FTksuM4+YoLFnx1o8j74niqzVnwSc=;
	b=Mjtsu6vWgaxDQdlB17s7EcOJVrHB8RzIWSADmsO+/sqgszXpl1S3YWeZc34iuWTYWapt
	 h8rFlXVG8CUHfwyLTxLEP45XI1sXstedJ7EeAiYzlGZ2Iv6gCe7yfmSqBoqDcPSC8KrcZ
	 i8q2okh3nLr96A/IlbYDWmfrvPUVmit/wj3Q6qBKBLCuUovBKdc5wHMgBgv/XdABFfF0/
	 cqfKq/JUTvK2ICcOzn8RgVBPAdzr4ZbqFXWwTuSqtv2ndm262WrVpfrsnf0py6BKjjqxO
	 kwjTuFKAgw0h/mEerHSmaDz2KicfXzj5n+/PLdD4fb4n5I/Ok2bFXQFscuWIdhNOLYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793731873;
	bh=6yR+dOWNI69My6FTksuM4+YoLFnx1o8j74niqzVnwSc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gXSXxYWePAY7l8r0pIi0Svq2hEJ3oCCfWiV4xfTpR0uhg06mOLmTh85OvLlfX2dGA
	 sXzYPjhpMwj9QGgScTgxv0mt+WBpCKR7OVpGqLU03WEru3baseNjcQqBMeTzJ3ZHjG
	 v0IGDeoZEOjoh+TbOx/s620SqlXFpa9zJT1JbzlJ92FOPvOL5eZUIhiTgKrbUvtI30
	 1DTYEOm+1PseEv0nnxda1Z4Wnh0l0l8QnZHYn9XyMqEmblHW43nQXsaA1321Si75z2
	 XjSbTKNRpJ+EDqnpC8+GH0kAViAA7corT5KJy+L3KbB+3v+q8Dayim/dVwJcP7f4Nj
	 ehJUN5lj5C7Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCF32405F9;
	Tue,  3 Nov 2026 18:51:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 75810A10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 666A1606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FrjPGCyILFsx for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:44:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C5E66067A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793731468;
 b=VhcD7y0VlRAu5x2Xsz7uQxSKHO+VChuKNUe4aA3kJ4FmopQZrVqRRlnopNFm3Nuh9OU8
 6HB5SwicvR1E0F1a5SaUe1aFjqO6M92xSLj7hVGZVzoySo2+gLmeJslFS0gTizJPbAcWp
 GyTZayhYoddRFYHyU7FhD/TbuePCN0swn3qKY8QBD/9rMDob54hankRcoerxbmXgOXySL
 tUem+NILM7eo1Dqfvk7GYJB/h6w5hMUBk/1X6oeEmlig0lE7r55XYuCVK59Vq1Vo6jb6A
 iUxWnL5cN9nMkx4R1GQ7KMdN3NI3e2bYDQKQrkXVTkdLBwtX6w6gvEu2yHfIxiwa/BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793731468;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6yR+dOWNI69My6FTksuM4+YoLFnx1o8j74niqzVnwSc=;
 b=YrntGB5JtKxlxHOIXfnXsvEdrvMCziMUj+U1GBOs0fpHGmdk6Tq8uvUtPCB/+Spn/gzb
 3lx35Ud4sJFcxxQndpI+rIJVsIVJRO/NJFqEXK/W4DPGS6e7exBrtFM/8P5108aHNoSwN
 yxg5q0LLvD1Q9E6EU6G9inkRRvQyOTHAmxuYDY0H4An+KwBIhaBshSyW2mdNJCc6bGkoM
 nIdVN1MtMusQJ2nWqp2rta7NioNqzq1OtaLTFJ6Ys+aFkRMCY/5w3ING+c3md3Nfb5km1
 QVNy6t3Vui80xiqCHNgYoJaCS1WNYT2YO2+6JdrSzOyJPnSru4b9tA6KbZPkOFnKe4Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=t0.technology;
 dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256
 header.s=google header.b=F5av1uhw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=F5av1uhw
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C5E66067A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:27 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cd6a7b62ce8so1598337a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793731467; x=1794336267;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6yR+dOWNI69My6FTksuM4+YoLFnx1o8j74niqzVnwSc=;
 b=F5av1uhwbEi065SwaSvJSz9G6YUrGrJauQ+chOL953cPWC5giizADWUDMUyBfq5Uut
 1SdWN0g1jvGUNoK/cG9GcxR8yGkmzlK30jtWw55kjquKjWD/l+IqVG1eX+BNS9AE5Nsd
 ke22FFfyRZalCBa8VbsQeAJo+U/Y2sQQrw3UDp9Q4a5CtPRa5F5lOLlZfTrRjUJsaam5
 kR6DQzJ+514gjeZDafqx3YUUmB37/qzeeyf0yrvp3/sRvEZvdoBWCijAPnFH/5KUKNCO
 AUYi3NLMqtvawqVIICpJ11TxDb+6Bq14BV1bk0yN0GksD8UjL47Dhc8RMeMspQ0nsgRM
 M2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731467; x=1794336267;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6yR+dOWNI69My6FTksuM4+YoLFnx1o8j74niqzVnwSc=;
 b=NKT5sgneGA2IthK7FjdomcWPEZqhOyeHVq8FjM0kBoCJ6KrsACkuEklOG+GY4x2uIA
 RusudC2hFsAbB4m6oSC2XU2vGltnPtBxv28wHJi5cGdbvLBeGICKyyuWpS2UrW7aD/cZ
 ulmACZXkeKTII7Ap9B5hHJUUsb6VV5RECdvOsLH7QUorfddcNS3DPSiIvKezMKC4rpGc
 CLDKozk7DeTGMM8COQz8qSmNdrt8MSUppUwK2zNGRE82CZ0kt499Y3cRGPvjlqDu8H9F
 iPQwQ9BbQfxX76tHIJ0Lt100mpPLI2cQuB2RCSnww97Ff9U4vvi/D6G9ZtKYVaBzYUre
 hJ1Q==
X-Gm-Message-State: APuU4Z8v6vWibzuLD0pjh75cZiXQVheVm1VfBShNYuKK6RKNUqmb0Mjs
 7PUndWGo+h77iQsC7ZkC9KbDckruSKXSYkJXra9hIa2I8WOgg4RxfO+wZBXuvamj4po=
X-Gm-Gg: AYBFou0HoiDCTq7AkjJq4rTkak9ZJ+n+4gzCFnkisW+G+slLcGrJReANs14UTfy9l9z
 omE8Ar5ZJFfNm4d0VHAoz5SSh1hYajiuvY8Pls9xmPahtnOyF4OubviRMGeqD0ZuG4/FenudJah
 uqXJgJ+D5n4h91tisRF0IHrCr0e2EF+BoNwAGHSMTTGTiL8xLQ0J7f3+2CT0x2/5iWZ1JbEsYyj
 6VvNFKUbU31NHy8rd3d2sMdB6hW2tnL13ChrLKk+seLxzC+C7dN/ZxQnAe604NsApsCoLJPLKdh
 YKe+Lcy9tNncEG8btF7FREmeqV5LO1h0DAuuq4183fEAHc6EHRAs9t2U0Vyc3TTK0icCosBsQhv
 Ei0lbI4UKmqrvk1R2dZt/Yx8yE2T7Lr2UKjB0bq4E5BG0FYpDQVm/tS49i1U507m0DqEECAYFqO
 EP1mx8mD2z4pmVMu33M8dxVjNsjzRU1KTJPm8gphCIb+xhoKTcXpTLqIs9QCi5HasijDoLN7s0j
 5s7Vt2oFjOhau3OARcp1PJgj39cn+H6Tr5gauwJak5bcf7EVBewwZASy30HnFEDIN0xkMrmKZm5
 ll5jcCkkx4tSzKMwlHZk2C1eDRZ/AxIG7UPgbIMy5ZtrVfvpci7SElJ+zqjwO1Of5SGJCDRjtVP
 t
X-Received: by 2002:a17:90b:b14:b0:3b0:92be:ea4a with SMTP id
 98e67ed59e1d1-3b092beee8dmr213550a91.45.1793731467039; 
 Tue, 03 Nov 2026 10:44:27 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae880b1f71sm11496613a91.4.2026.11.03.10.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:44:26 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Subject: [PATCH v3 0/4] net: zynq_gem/eth-phy: fix resource leaks and
 shared MDIO bus teardown
Date: Tue, 03 Nov 2026 11:43:21 -0700
Message-Id: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkr6moC/x3MSw5AMBRG4a3IHbsJFQa2IgZt/bhB0SbiEXvXG
 H6Dcx4K8IJAdfKQxyFBVhdRpAnZUbsBLF00qUxVeZ4VfF9u5wELeyzrAZ6hJzbKlLq3FsYaiun
 m0cv5b5v2fT8vcIwyZgAAAA==
X-Change-ID: 20261103-zynq-gem-remove-leak-b2b5afccebcb
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731408; l=3039;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=rmasVbEiymXeaOLfQMYEeNmcHvsTB+xOG1ETx+ciHjw=;
 b=OMHgJgCptEF/454stuaVtiboVq4kX5SQ4t9eIYlA2LLRfRFIOB9erzEzpzQdtPpUiAflx41kO
 PBBu3NbHPpOAGJBPDQ3rhOcUW6kRJ3TGAk3+IrtUQ3zg+Cq/QbbGFqe
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

This series fixes resource leaks in the zynq_gem probe error path and
remove(), and makes the eth-phy uclass release the reset GPIO and reset
control it claims.

Patch 1 stops zynq_gem from unregistering/freeing an MDIO bus (and the
phy_device on it) borrowed from another controller via
eth_phy_get_mdio_bus(). Patches 2 and 3 plug the probe error path and
remove() leaks. Patch 4 releases the eth-phy reset GPIO and reset
control on removal, so that the PHY can be probed again after unbind.

Tested on QEMU (xilinx-zynq-a9, xilinx_zynq_virt) with a DT in which
gem1 shares gem0's MDIO bus and PHY, and the PHY has reset-gpios and a
(syscon-reset) resets property:

- repeated unbind/bind of gem0: heap usage is stable, and the eth-phy
  device re-probes. Without the series the remove() leak eventually
  exhausts the heap, and the eth-phy device fails to re-probe because
  its reset GPIO is still claimed;
- unbind of gem1 (shared bus): gem0 keeps working. Without the series,
  gem0's MDIO bus is freed and its next use data-aborts;
- injected failures at each probe step (except the SGMII-only ones)
  for both gem0 and gem1, followed by a successful re-probe, without
  leaks.

The SGMII/generic PHY error paths are build-tested only.

Changes in v3:
- Rebased onto current main
- Split v2 1/2 into three patches: shared-bus handling (1/4), probe
  error path (2/4) and .remove buffers (3/4) (Michal Simek)
- 1/4: also only free priv->phydev when the bus is our own
- 2/4: free priv->phydev on failures after zynq_phy_init(), again only
  when the MDIO bus is ours
- 2/4: call generic_phy_exit() on every error path after
  generic_phy_init(), including the early returns after
  zynq_gem_reset_init() and the rxbuffers allocation, and
  zero-initialise struct phy
- 2/4: use descriptive error labels
- 4/4: rebased onto the eth-phy reset control support; also release
  the reset control with reset_free(). Use per-feature DM_GPIO/DM_RESET
  guards, and reword the subject accordingly

Changes in v2:
- Move mdio_free() out of the mdio_register_seq() failure branch and
  into the error label ladder
- With CONFIG_DM_ETH_PHY, priv->bus may be a shared bus obtained from
  eth_phy_get_mdio_bus(). Track whether we allocated it and only
  unregister/free it in that case, in both probe and remove

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
Graeme Smecher (4):
      net: zynq_gem: don't tear down a shared MDIO bus
      net: zynq_gem: plug resource leaks in .probe error path
      net: zynq_gem: free buffers in .remove
      net: eth-phy: release reset GPIO and reset control on device removal

 drivers/net/eth-phy-uclass.c | 14 +++++++++++
 drivers/net/zynq_gem.c       | 59 ++++++++++++++++++++++++++++++--------------
 2 files changed, 54 insertions(+), 19 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261103-zynq-gem-remove-leak-b2b5afccebcb

Best regards,
-- 
Graeme Smecher <gsmecher@t0.technology>

