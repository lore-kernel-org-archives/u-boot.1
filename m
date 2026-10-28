Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1911606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=izgcCci2;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=suFl82pW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E4F780DCE;
	Wed, 28 Oct 2026 14:49:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z6o-ego6SmQp; Wed, 28 Oct 2026 14:49:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F23C581204
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198885;
	b=rXz7STU9aLw5aa6HW3C5FYA4Ng25CdcRees5+ZCNgCu1+cx9RAYXFLOwJ9xTuw/wxW0x
	 p8inXtCLtKc8lROJDD+IzZ7DJq6X+TCzB6wboSZKdIOQhbAykuhcNwv6lAHghI/w4Ls3i
	 lAJ3Fbkk2gnwTLq845X4KV6hiAbuUlVDl+cwO+Pfn+5fhwJ5pKr0ixkgKPBN3KGQgCKkf
	 p1oj47jDyvS3y9SttoEhexkw2khIoQch5Ax7MMJaSmua+8/5Z4Xhzo2v/ZdyjxKigQQQO
	 aB+QKjWE17Pf7S5huvFyMDy2GUzOw1Es5tMEOCE2TOHql+7ouCxkEV+p+G2Rpq9kxhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Bwwk2xRlrCm3QbTvW5irvD6lyQDSs2OObBmb78kIloA=;
	b=J9pYvBMMXMswXfJ9GOO3IW1j2TeeTchxDev22KZoY9spnANX08/Jn+ejwH9EOYvCWZXH
	 HH4A5YGIqzRIsFlu1GMF5kVmoJBDnC9a6A6CWYcE098CeFIfv3OkpgIxFvRJIDN7zjAa2
	 CHX8+tvGIcliPNu/DFY6s3Eg9XUqspz+YNQvKTIt1rk+L6Yt8V5oyO8zt4fKsxQzE1aFY
	 uk7izdgOIrWj3VLC4zr45np50Smkgkqwq0gZ0D6iApDHTwCGmlhy/tSi6mQSEC9xl1zlh
	 lVjsi1hpZy26gHZHuJUXcEuwy4X+cvO68K1EPhiUWeOzENnve2OVmDnYs7pa8o2DePA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=suFl82pW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198885;
	bh=Bwwk2xRlrCm3QbTvW5irvD6lyQDSs2OObBmb78kIloA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izgcCci2JHA5tPnk3BZeBoREe6EmLA9KjdVGt+FH0doeatI2lDLhef7UMW340b8PE
	 GGhgobLh94AEcaLAKin0XiH5v9Fx4CdGOEJpYHLTuCDLlBzxg80/UXLXvnhZfO0I6O
	 qHqBprb8JPRG4CBJ5po1K2e9QempTW8s6l5UnpOYOSqYmjswPz9YY3vd5TicN5She3
	 2Ni1emi7GEmEsjfttlSEWlIfL5GwB8pNm1XKNP30LxBVl4AB6hDdSgsPpc/yaOkWu3
	 8dr4yxQTrlxQfvShTUsNTQKLlg8S7zv5W9BKuz1X/6Qqeht6pZzbNEpfZ7SJiV1Evj
	 H1qD+YNR8vXiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F23C581204;
	Wed, 28 Oct 2026 14:48:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C9E5D356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C786380CF1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4vEsDnDcA5i for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B8BD5808C0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196969;
 b=qM6kt3g5S7amdKcTt3l1+dtiq2MlErBZqZesoWdyhlLwye2eKsU3EidB2f20WhEvjgg8
 O9GLgS/pblcEz53374uFRJR2Oq6eAt0jLp/kObkw44oRiwSToYT9ikv9fbAbvJiVmuD/v
 KluUI7MUhp2r4dDpUdsFYIMUH8E1SWhND9nTDjTxY4tsEEnCU1we9Pk8ybD+cN4NSYMLz
 SXUV2UPPsK8EQYCbtimXIbU/X/mRN+oh3qa+pdm9Du+UpTan8kK1NkFXsvpQxQPEUuQF0
 6cVtLhUElGCHvW4Tgd6D2JwQTm6dGrAccOCITts8F6Ozsc2bJjLsjujmA+ZRn3+cylw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196969;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Bwwk2xRlrCm3QbTvW5irvD6lyQDSs2OObBmb78kIloA=;
 b=gbKbB/BTmektXYkpuJ6qX3WEajO1kxxBx9+gRLiHntAaOsmvhxbbYAHdeLAJhw/m1+6N
 hdfe8H16shr2xfIAIfaxNbL0Z8+m+Z0i7fbcTAbeTFY8MDhTvCCKhNmWB8Dj3E0dEEH5o
 jh0kswYzFCJt6sQE1JWnABrZ6Dax7Q1SOMEkZhgLIDekM5UZ7m4xvz45xzxvpzPfrU/uA
 SXIkznZ/MlZ2mPynnnSisroY8EI9TOu9lZg8ZOGvs2tfklmDgZUCTQ0Kd0N7hSKUFvT1m
 BLhtqYEA9VjZYf2rFfn9COWSMbH25dmS9TK0i5JQS/JR0n9k8yNpPAQNtpZA8yvjGsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=suFl82pW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=suFl82pW
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8BD5808C0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:08 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c40f5077425so11785366b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196966; x=1793801766;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bwwk2xRlrCm3QbTvW5irvD6lyQDSs2OObBmb78kIloA=;
 b=suFl82pWNMh7dIxSSPZhU99Z4g++wEWJkaE86SIrlFJsAgpx9bMmnRcavrEDy4sX7L
 YaO4XRLjf9NeOncmM3fXukinEHo25NnETF+LGVNmdmgIuEONei69pT8bd/H/BBVeJTxA
 aVRSHeIKRcFm5hg5JxAAhiPXgDhMRvz3RHIlM7QE6xK2X9LOVAOGiMJjjHpiJw6ESmtB
 Q8WaN4JIOpB2pgKtr4km25CJnlMlWvOGEl2sNWcqUgwW/ZZW9ZnrjSB8R8ZWhspYHiGI
 1/1xsgzi9vajQS9n8R+GPyyrTfiwKgB5372fDcTprBwFGrkxhvZNXHNKbESAjOlUaAYJ
 qHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196966; x=1793801766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bwwk2xRlrCm3QbTvW5irvD6lyQDSs2OObBmb78kIloA=;
 b=OrJ8XFUNyVNoTA1t+J7FswG1bLlk8mME02tqewDfCmvsWz6eF/I4dHfvtzSq8I/H4O
 NvqR8n1xq74og6O6O9rFEJohVVEmDee9x9hElWo37OsdjAlhSFZ4UmFSfmOQzXyx22+x
 mN/aK4VWoux1oJckIkQ8F7fXhVetq94t90sciA8SijLb5pKmxzb5FZbPoau9nhfwed7k
 nQxhsudaR1OMXN/OcjL9qko9hVE+i0g/Tr5kr5pHYreqeJbs1K4TcfDVffj8DXkicGYc
 fLZkAo+vzSlBM/b72zDj8qdJuArZL7iS324PRtvHZ3/+hnVEoGplQ43jU0vLjd0jR0Ht
 TwaQ==
X-Gm-Message-State: AFq9FYIQOqzdpXzHWFmeaTSZ0GOnFz4bum5OK5rMbqRe34bIw43NcuF8
 rix/a1iYkZcoyaZdVanVpV02C4Wp0wUx4XhDBO8aA7a1ghMhNHHq9KvmdToR+3E2lZaDB0y48fF
 +4whP
X-Gm-Gg: AYBFou0a5srJ3Hn+BT0paMYeiVnYCzaio4Jphd+CrkKERnpvxOBp3zGaDUXrSQCEV8n
 71Kt593H9K4F8lZYG2cmgzcuPBwfDP4mIXpt0q+Xcmauot2G/YVHcTtWBV8YMgGpAk8dxC31832
 gcYyE11UzlQs+RGOa8TLlM8K7UCKHrx9Dbrc6bkkD4OnWWTphK4tujxW5isxkb6nQPik2av3Z4W
 J9AD6DOl1UN4Sf2eJRMnQgcf2RHP3A7/avVfCHOSabZkh9T6h701XepjKXyULpu1KU8JAx16RFW
 eglkNTjDL3zRvBCd7tSoQqzsm49w3IcIXjqitja2GQqIlkU/BoLV4vc2kvg0psRotHgeh+f8+au
 52BFgOu5IHz59nKKbqrk23LG4v0syVmMr3oCUy705g/OkCXcRGRzwvebLf26nDCZM7Nk0qIDOuv
 RURc6WIkCUQAhbnfBOY6cDXJ1NkR8MNq+X9sApTjyHYr93XYAU9cmMeD8ubxZV4b6Z9t+PSyibq
 irLG7KjbhVhayNN7c6OYeTDPii0a/dnnkq4MysyT7juGLwE1TNhGfRuqAmA1iGRCLhXQRWGAqut
 gNvBsP6Nzs/q/gyRttUUXTPQdHH6kfJnMh9kcpJKwRWxqWtb6mnhfKmIZ5YDdwbqEKrtRy8Se2F
 2yyqH9fZGqw==
X-Received: by 2002:a17:906:18e9:b0:c41:3963:6f1f with SMTP id
 a640c23a62f3a-c49bdeae450mr227321766b.4.1793196966187; 
 Wed, 28 Oct 2026 07:16:06 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:05 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 05/30] usb: gadget: adapt the gadget API after the resync
Date: Wed, 28 Oct 2026 15:15:29 +0100
Message-ID: <20261028141554.3073545-6-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

Make the gadget API match the resynced DWC3 driver. This is not only a
trim. It drops the parts U-Boot does not use and adds the new members
the driver needs, for example in struct usb_request. It also fixes up
ch9.h.

struct usb_request and struct usb_ep come from Linux v6.16, like the
driver. Two things are left out. usb_request drops the scatter-gather
members, U-Boot has no scatterlist. usb_ep drops mult, nothing reads it.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/linux/usb/ch9.h    |  25 +-
 include/linux/usb/gadget.h | 526 +++++++------------------------------
 2 files changed, 110 insertions(+), 441 deletions(-)

diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index c8c553b930ac..fc853b376a32 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This file holds USB constants and structures that are needed for
  * USB device APIs.  These are used by the USB device model, which is
@@ -5,7 +6,7 @@
  * Wireless USB 1.0 (spread around).  Linux has several APIs in C that
  * need these:
  *
- * - the master/host side Linux-USB kernel driver API;
+ * - the host side Linux-USB kernel driver API;
  * - the "usbfs" user space API; and
  * - the Linux "gadget" slave/device/peripheral side driver API.
  *
@@ -131,11 +132,11 @@
  * Test Mode Selectors
  * See USB 2.0 spec Table 9-7
  */
-#define	TEST_J		1
-#define	TEST_K		2
-#define	TEST_SE0_NAK	3
-#define	TEST_PACKET	4
-#define	TEST_FORCE_EN	5
+#define	USB_TEST_J		1
+#define	USB_TEST_K		2
+#define	USB_TEST_SE0_NAK	3
+#define	USB_TEST_PACKET		4
+#define	USB_TEST_FORCE_ENABLE	5
 
 /*
  * New Feature Selectors as added by USB 3.0
@@ -873,9 +874,6 @@ struct usb_ss_cap_descriptor {		/* Link Power Management */
 	__le16 bU2DevExitLat;
 } __attribute__((packed));
 
-#define USB_DEFAULT_U1_DEV_EXIT_LAT     0x01	/* Less then 1 microsec */
-#define USB_DEFAULT_U2_DEV_EXIT_LAT     0x01F4	/* Less then 500 microsec */
-
 #define USB_DT_USB_SS_CAP_SIZE	10
 
 /*
@@ -1055,4 +1053,13 @@ struct usb_string {
 	const char *s;
 };
 
+/* USB 3.2 SuperSpeed Plus phy signaling rate generation and lane count */
+
+enum usb_ssp_rate {
+	USB_SSP_GEN_UNKNOWN = 0,
+	USB_SSP_GEN_2x1,
+	USB_SSP_GEN_1x2,
+	USB_SSP_GEN_2x2,
+};
+
 #endif /* __LINUX_USB_CH9_H */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index fe79bf64a0e1..7137f0faf3c6 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -88,6 +88,7 @@ struct usb_request {
 	dma_addr_t		dma;
 
 	unsigned		stream_id:16;
+	unsigned		is_last:1;
 	unsigned		no_interrupt:1;
 	unsigned		zero:1;
 	unsigned		short_not_ok:1;
@@ -97,6 +98,7 @@ struct usb_request {
 	void			*context;
 	struct list_head	list;
 
+	unsigned		frame_number;		/* ISO ONLY */
 	int			status;
 	unsigned		actual;
 };
@@ -153,6 +155,8 @@ struct usb_ep_caps {
  * @ops: Function pointers used to access hardware-specific operations.
  * @ep_list:the gadget's ep_list holds all of its endpoints
  * @caps:The structure describing types and directions supported by endoint.
+ * @enabled: The current endpoint enabled/disabled state.
+ * @claimed: True if this endpoint is claimed by a function.
  * @maxpacket:The maximum packet size used on this endpoint.  The initial
  *	value can sometimes be reduced (hardware allowing), according to
  *      the endpoint descriptor used to configure the endpoint.
@@ -162,6 +166,8 @@ struct usb_ep_caps {
  * @max_streams: The maximum number of streams supported
  *	by this EP (0 - 16, actual number is 2^n)
  * @maxburst: the maximum number of bursts supported by this EP (for usb3)
+ * @address: used to identify the endpoint when finding descriptor that
+ *      matches connection speed
  * @driver_data:for use by the gadget driver.  all other fields are
  *	read-only to gadget drivers.
  * @desc: endpoint descriptor.  This pointer is set before the endpoint is
@@ -179,301 +185,73 @@ struct usb_ep {
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
 	struct usb_ep_caps	caps;
+	bool			claimed;
 	bool			enabled;
-	unsigned		maxpacket:16;
-	unsigned		maxpacket_limit:16;
-	unsigned		max_streams:16;
 	unsigned		maxburst:5;
+	u8			address;
+	u16			maxpacket;
+	u16			maxpacket_limit;
+	u16			max_streams;
 	const struct usb_endpoint_descriptor	*desc;
 	const struct usb_ss_ep_comp_descriptor	*comp_desc;
 };
 
 /*-------------------------------------------------------------------------*/
 
-/**
- * usb_ep_set_maxpacket_limit - set maximum packet size limit for endpoint
- * @ep:the endpoint being configured
- * @maxpacket_limit:value of maximum packet size limit
- *
- * This function shoud be used only in UDC drivers to initialize endpoint
- * (usually in probe function).
- */
+#if IS_ENABLED(CONFIG_USB_GADGET)
+void usb_ep_set_maxpacket_limit(struct usb_ep *ep, unsigned maxpacket_limit);
+int usb_ep_enable(struct usb_ep *ep);
+int usb_ep_disable(struct usb_ep *ep);
+struct usb_request *usb_ep_alloc_request(struct usb_ep *ep, gfp_t gfp_flags);
+void usb_ep_free_request(struct usb_ep *ep, struct usb_request *req);
+int usb_ep_queue(struct usb_ep *ep, struct usb_request *req, gfp_t gfp_flags);
+int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
+int usb_ep_set_halt(struct usb_ep *ep);
+int usb_ep_clear_halt(struct usb_ep *ep);
+int usb_ep_set_wedge(struct usb_ep *ep);
+int usb_ep_fifo_status(struct usb_ep *ep);
+void usb_ep_fifo_flush(struct usb_ep *ep);
+#else
 static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
-					      unsigned maxpacket_limit)
-{
-	ep->maxpacket_limit = maxpacket_limit;
-	ep->maxpacket = maxpacket_limit;
-}
-
-/**
- * usb_ep_enable - configure endpoint, making it usable
- * @ep:the endpoint being configured.  may not be the endpoint named "ep0".
- *	drivers discover endpoints through the ep_list of a usb_gadget.
- * @desc:descriptor for desired behavior.  caller guarantees this pointer
- *	remains valid until the endpoint is disabled; the data byte order
- *	is little-endian (usb-standard).
- *
- * when configurations are set, or when interface settings change, the driver
- * will enable or disable the relevant endpoints.  while it is enabled, an
- * endpoint may be used for i/o until the driver receives a disconnect() from
- * the host or until the endpoint is disabled.
- *
- * the ep0 implementation (which calls this routine) must ensure that the
- * hardware capabilities of each endpoint match the descriptor provided
- * for it.  for example, an endpoint named "ep2in-bulk" would be usable
- * for interrupt transfers as well as bulk, but it likely couldn't be used
- * for iso transfers or for endpoint 14.  some endpoints are fully
- * configurable, with more generic names like "ep-a".  (remember that for
- * USB, "in" means "towards the USB master".)
- *
- * returns zero, or a negative error code.
- */
-static inline int usb_ep_enable(struct usb_ep *ep,
-				const struct usb_endpoint_descriptor *desc)
-{
-	int ret;
-
-	if (ep->enabled)
-		return 0;
-
-	ret = ep->ops->enable(ep, desc);
-	if (ret)
-		return ret;
-
-	ep->enabled = true;
-
-	return 0;
-}
-
-/**
- * usb_ep_disable - endpoint is no longer usable
- * @ep:the endpoint being unconfigured.  may not be the endpoint named "ep0".
- *
- * no other task may be using this endpoint when this is called.
- * any pending and uncompleted requests will complete with status
- * indicating disconnect (-ESHUTDOWN) before this call returns.
- * gadget drivers must call usb_ep_enable() again before queueing
- * requests to the endpoint.
- *
- * returns zero, or a negative error code.
- */
+		unsigned maxpacket_limit)
+{ }
+static inline int usb_ep_enable(struct usb_ep *ep)
+{ return 0; }
 static inline int usb_ep_disable(struct usb_ep *ep)
-{
-	int ret;
-
-	if (!ep->enabled)
-		return 0;
-
-	ret = ep->ops->disable(ep);
-	if (ret)
-		return ret;
-
-	ep->enabled = false;
-
-	return 0;
-}
-
-/**
- * usb_ep_alloc_request - allocate a request object to use with this endpoint
- * @ep:the endpoint to be used with with the request
- * @gfp_flags:GFP_* flags to use
- *
- * Request objects must be allocated with this call, since they normally
- * need controller-specific setup and may even need endpoint-specific
- * resources such as allocation of DMA descriptors.
- * Requests may be submitted with usb_ep_queue(), and receive a single
- * completion callback.  Free requests with usb_ep_free_request(), when
- * they are no longer needed.
- *
- * Returns the request, or null if one could not be allocated.
- */
+{ return 0; }
 static inline struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
-						       gfp_t gfp_flags)
-{
-	return ep->ops->alloc_request(ep, gfp_flags);
-}
-
-/**
- * usb_ep_free_request - frees a request object
- * @ep:the endpoint associated with the request
- * @req:the request being freed
- *
- * Reverses the effect of usb_ep_alloc_request().
- * Caller guarantees the request is not queued, and that it will
- * no longer be requeued (or otherwise used).
- */
+		gfp_t gfp_flags)
+{ return NULL; }
 static inline void usb_ep_free_request(struct usb_ep *ep,
-				       struct usb_request *req)
-{
-	ep->ops->free_request(ep, req);
-}
-
-/**
- * usb_ep_queue - queues (submits) an I/O request to an endpoint.
- * @ep:the endpoint associated with the request
- * @req:the request being submitted
- * @gfp_flags: GFP_* flags to use in case the lower level driver couldn't
- *	pre-allocate all necessary memory with the request.
- *
- * This tells the device controller to perform the specified request through
- * that endpoint (reading or writing a buffer).  When the request completes,
- * including being canceled by usb_ep_dequeue(), the request's completion
- * routine is called to return the request to the driver.  Any endpoint
- * (except control endpoints like ep0) may have more than one transfer
- * request queued; they complete in FIFO order.  Once a gadget driver
- * submits a request, that request may not be examined or modified until it
- * is given back to that driver through the completion callback.
- *
- * Each request is turned into one or more packets.  The controller driver
- * never merges adjacent requests into the same packet.  OUT transfers
- * will sometimes use data that's already buffered in the hardware.
- * Drivers can rely on the fact that the first byte of the request's buffer
- * always corresponds to the first byte of some USB packet, for both
- * IN and OUT transfers.
- *
- * Bulk endpoints can queue any amount of data; the transfer is packetized
- * automatically.  The last packet will be short if the request doesn't fill it
- * out completely.  Zero length packets (ZLPs) should be avoided in portable
- * protocols since not all usb hardware can successfully handle zero length
- * packets.  (ZLPs may be explicitly written, and may be implicitly written if
- * the request 'zero' flag is set.)  Bulk endpoints may also be used
- * for interrupt transfers; but the reverse is not true, and some endpoints
- * won't support every interrupt transfer.  (Such as 768 byte packets.)
- *
- * Interrupt-only endpoints are less functional than bulk endpoints, for
- * example by not supporting queueing or not handling buffers that are
- * larger than the endpoint's maxpacket size.  They may also treat data
- * toggle differently.
- *
- * Control endpoints ... after getting a setup() callback, the driver queues
- * one response (even if it would be zero length).  That enables the
- * status ack, after transfering data as specified in the response.  Setup
- * functions may return negative error codes to generate protocol stalls.
- * (Note that some USB device controllers disallow protocol stall responses
- * in some cases.)  When control responses are deferred (the response is
- * written after the setup callback returns), then usb_ep_set_halt() may be
- * used on ep0 to trigger protocol stalls.
- *
- * For periodic endpoints, like interrupt or isochronous ones, the usb host
- * arranges to poll once per interval, and the gadget driver usually will
- * have queued some data to transfer at that time.
- *
- * Returns zero, or a negative error code.  Endpoints that are not enabled
- * report errors; errors will also be
- * reported when the usb peripheral is disconnected.
- */
-static inline int usb_ep_queue(struct usb_ep *ep,
-			       struct usb_request *req, gfp_t gfp_flags)
-{
-	return ep->ops->queue(ep, req, gfp_flags);
-}
-
-/**
- * usb_ep_dequeue - dequeues (cancels, unlinks) an I/O request from an endpoint
- * @ep:the endpoint associated with the request
- * @req:the request being canceled
- *
- * if the request is still active on the endpoint, it is dequeued and its
- * completion routine is called (with status -ECONNRESET); else a negative
- * error code is returned.
- *
- * note that some hardware can't clear out write fifos (to unlink the request
- * at the head of the queue) except as part of disconnecting from usb.  such
- * restrictions prevent drivers from supporting configuration changes,
- * even to configuration zero (a "chapter 9" requirement).
- */
+		struct usb_request *req)
+{ }
+static inline int usb_ep_queue(struct usb_ep *ep, struct usb_request *req,
+		gfp_t gfp_flags)
+{ return 0; }
 static inline int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
-{
-	return ep->ops->dequeue(ep, req);
-}
-
-/**
- * usb_ep_set_halt - sets the endpoint halt feature.
- * @ep: the non-isochronous endpoint being stalled
- *
- * Use this to stall an endpoint, perhaps as an error report.
- * Except for control endpoints,
- * the endpoint stays halted (will not stream any data) until the host
- * clears this feature; drivers may need to empty the endpoint's request
- * queue first, to make sure no inappropriate transfers happen.
- *
- * Note that while an endpoint CLEAR_FEATURE will be invisible to the
- * gadget driver, a SET_INTERFACE will not be.  To reset endpoints for the
- * current altsetting, see usb_ep_clear_halt().  When switching altsettings,
- * it's simplest to use usb_ep_enable() or usb_ep_disable() for the endpoints.
- *
- * Returns zero, or a negative error code.  On success, this call sets
- * underlying hardware state that blocks data transfers.
- * Attempts to halt IN endpoints will fail (returning -EAGAIN) if any
- * transfer requests are still queued, or if the controller hardware
- * (usually a FIFO) still holds bytes that the host hasn't collected.
- */
+{ return 0; }
 static inline int usb_ep_set_halt(struct usb_ep *ep)
-{
-	return ep->ops->set_halt(ep, 1);
-}
-
-/**
- * usb_ep_clear_halt - clears endpoint halt, and resets toggle
- * @ep:the bulk or interrupt endpoint being reset
- *
- * Use this when responding to the standard usb "set interface" request,
- * for endpoints that aren't reconfigured, after clearing any other state
- * in the endpoint's i/o queue.
- *
- * Returns zero, or a negative error code.  On success, this call clears
- * the underlying hardware state reflecting endpoint halt and data toggle.
- * Note that some hardware can't support this request (like pxa2xx_udc),
- * and accordingly can't correctly implement interface altsettings.
- */
+{ return 0; }
 static inline int usb_ep_clear_halt(struct usb_ep *ep)
-{
-	return ep->ops->set_halt(ep, 0);
-}
-
-/**
- * usb_ep_fifo_status - returns number of bytes in fifo, or error
- * @ep: the endpoint whose fifo status is being checked.
- *
- * FIFO endpoints may have "unclaimed data" in them in certain cases,
- * such as after aborted transfers.  Hosts may not have collected all
- * the IN data written by the gadget driver (and reported by a request
- * completion).  The gadget driver may not have collected all the data
- * written OUT to it by the host.  Drivers that need precise handling for
- * fault reporting or recovery may need to use this call.
- *
- * This returns the number of such bytes in the fifo, or a negative
- * errno if the endpoint doesn't use a FIFO or doesn't support such
- * precise handling.
- */
+{ return 0; }
+static inline int usb_ep_set_wedge(struct usb_ep *ep)
+{ return 0; }
 static inline int usb_ep_fifo_status(struct usb_ep *ep)
-{
-	if (ep->ops->fifo_status)
-		return ep->ops->fifo_status(ep);
-	else
-		return -EOPNOTSUPP;
-}
-
-/**
- * usb_ep_fifo_flush - flushes contents of a fifo
- * @ep: the endpoint whose fifo is being flushed.
- *
- * This call may be used to flush the "unclaimed data" that may exist in
- * an endpoint fifo after abnormal transaction terminations.  The call
- * must never be used except when endpoint is not being used for any
- * protocol translation.
- */
+{ return 0; }
 static inline void usb_ep_fifo_flush(struct usb_ep *ep)
-{
-	if (ep->ops->fifo_flush)
-		ep->ops->fifo_flush(ep);
-}
+{ }
+#endif /* USB_GADGET */
 
 /*-------------------------------------------------------------------------*/
 
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
+#define USB_DEFAULT_U1_DEV_EXIT_LAT     0x01    /* Less then 1 microsec */
 	__le16 bU2DevExitLat;	/* U2 Device exit Latency */
+#define USB_DEFAULT_U2_DEV_EXIT_LAT     0x1F4   /* Less then 500 microsec */
+	__u8 besl_baseline;	/* Recommended baseline BESL (0-15) */
+	__u8 besl_deep;         /* Recommended deep BESL (0-15) */
+#define USB_DEFAULT_BESL_UNSPECIFIED    0xFF    /* No recommended value */
 };
 
 struct usb_gadget;
@@ -491,7 +269,8 @@ struct usb_gadget_ops {
 	int	(*pullup) (struct usb_gadget *, int is_on);
 	int	(*ioctl)(struct usb_gadget *,
 				unsigned code, unsigned long param);
-	void	(*get_config_params)(struct usb_dcd_config_params *);
+	void	(*get_config_params)(struct usb_gadget *,
+				     struct usb_dcd_config_params *);
 	int	(*udc_start)(struct usb_gadget *,
 			     struct usb_gadget_driver *);
 	int	(*udc_stop)(struct usb_gadget *);
@@ -503,6 +282,10 @@ struct usb_gadget_ops {
 			struct usb_endpoint_descriptor *);
 	void	(*udc_set_speed)(struct usb_gadget *gadget,
 				 enum usb_device_speed);
+	void    (*udc_set_ssp_rate)(struct usb_gadget *gadget,
+			enum usb_ssp_rate rate);
+	void    (*udc_async_callbacks)(struct usb_gadget *gadget, bool enable);
+	int	(*check_config)(struct usb_gadget *gadget);
 };
 
 /**
@@ -552,13 +335,23 @@ struct usb_gadget_ops {
  * device is acting as a B-Peripheral (so is_a_peripheral is false).
  */
 struct usb_gadget {
+	struct usb_udc			*udc;
 	/* readonly to gadget driver */
 	const struct usb_gadget_ops	*ops;
 	struct usb_ep			*ep0;
 	struct list_head		ep_list;	/* of usb_ep */
 	enum usb_device_speed		speed;
 	enum usb_device_speed		max_speed;
+
+	/* USB SuperSpeed Plus only */
+	enum usb_ssp_rate		ssp_rate;
+	enum usb_ssp_rate               max_ssp_rate;
+
 	enum usb_device_state		state;
+	unsigned			isoch_delay;
+
+	unsigned			out_epnum;
+	unsigned			in_epnum;
 	unsigned			is_dualspeed:1;
 	unsigned			is_otg:1;
 	unsigned			is_a_peripheral:1;
@@ -568,6 +361,10 @@ struct usb_gadget {
 	const char			*name;
 	struct device			dev;
 	unsigned			quirk_ep_out_aligned_size:1;
+	unsigned			is_selfpowered:1;
+	unsigned			deactivated:1;
+	unsigned			wakeup_armed:1;
+	unsigned			connected:1;
 };
 
 static inline void set_gadget_data(struct usb_gadget *gadget, void *data)
@@ -585,6 +382,15 @@ static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
 	return container_of(dev, struct usb_gadget, dev);
 }
 
+static inline void usb_put_gadget(struct usb_gadget *gadget)
+{
+}
+
+void usb_initialize_gadget(struct device *parent,
+			   struct usb_gadget *gadget,
+			   void (*release)(struct device *dev));
+int usb_add_gadget(struct usb_gadget *gadget);
+
 /* iterates the non-control endpoints; 'tmp' is a struct usb_ep pointer */
 #define gadget_for_each_ep(tmp, gadget) \
 	list_for_each_entry(tmp, &(gadget)->ep_list, ep_list)
@@ -630,168 +436,18 @@ static inline int gadget_is_superspeed(struct usb_gadget *g)
 	return g->max_speed >= USB_SPEED_SUPER;
 }
 
-/**
- * usb_gadget_frame_number - returns the current frame number
- * @gadget: controller that reports the frame number
- *
- * Returns the usb frame number, normally eleven bits from a SOF packet,
- * or negative errno if this device doesn't support this capability.
- */
-static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
-{
-	return gadget->ops->get_frame(gadget);
-}
-
-/**
- * usb_gadget_wakeup - tries to wake up the host connected to this gadget
- * @gadget: controller used to wake up the host
- *
- * Returns zero on success, else negative error code if the hardware
- * doesn't support such attempts, or its support has not been enabled
- * by the usb host.  Drivers must return device descriptors that report
- * their ability to support this, or hosts won't enable it.
- *
- * This may also try to use SRP to wake the host and start enumeration,
- * even if OTG isn't otherwise in use.  OTG devices may also start
- * remote wakeup even when hosts don't explicitly enable it.
- */
-static inline int usb_gadget_wakeup(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->wakeup)
-		return -EOPNOTSUPP;
-	return gadget->ops->wakeup(gadget);
-}
-
-/**
- * usb_gadget_set_selfpowered - sets the device selfpowered feature.
- * @gadget:the device being declared as self-powered
- *
- * this affects the device status reported by the hardware driver
- * to reflect that it now has a local power supply.
- *
- * returns zero on success, else negative errno.
- */
-static inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->set_selfpowered)
-		return -EOPNOTSUPP;
-	return gadget->ops->set_selfpowered(gadget, 1);
-}
-
-/**
- * usb_gadget_clear_selfpowered - clear the device selfpowered feature.
- * @gadget:the device being declared as bus-powered
- *
- * this affects the device status reported by the hardware driver.
- * some hardware may not support bus-powered operation, in which
- * case this feature's value can never change.
- *
- * returns zero on success, else negative errno.
- */
-static inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->set_selfpowered)
-		return -EOPNOTSUPP;
-	return gadget->ops->set_selfpowered(gadget, 0);
-}
-
-/**
- * usb_gadget_vbus_connect - Notify controller that VBUS is powered
- * @gadget:The device which now has VBUS power.
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session starting.  Common responses include
- * resuming the controller, activating the D+ (or D-) pullup to let the
- * host detect that a USB device is attached, and starting to draw power
- * (8mA or possibly more, especially after SET_CONFIGURATION).
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->vbus_session)
-		return -EOPNOTSUPP;
-	return gadget->ops->vbus_session(gadget, 1);
-}
-
-/**
- * usb_gadget_vbus_draw - constrain controller's VBUS power usage
- * @gadget:The device whose VBUS usage is being described
- * @mA:How much current to draw, in milliAmperes.  This should be twice
- *	the value listed in the configuration descriptor bMaxPower field.
- *
- * This call is used by gadget drivers during SET_CONFIGURATION calls,
- * reporting how much power the device may consume.  For example, this
- * could affect how quickly batteries are recharged.
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
-{
-	if (!gadget->ops->vbus_draw)
-		return -EOPNOTSUPP;
-	return gadget->ops->vbus_draw(gadget, mA);
-}
-
-/**
- * usb_gadget_vbus_disconnect - notify controller about VBUS session end
- * @gadget:the device whose VBUS supply is being described
- *
- * This call is used by a driver for an external transceiver (or GPIO)
- * that detects a VBUS power session ending.  Common responses include
- * reversing everything done in usb_gadget_vbus_connect().
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->vbus_session)
-		return -EOPNOTSUPP;
-	return gadget->ops->vbus_session(gadget, 0);
-}
-
-/**
- * usb_gadget_connect - software-controlled connect to USB host
- * @gadget:the peripheral being connected
- *
- * Enables the D+ (or potentially D-) pullup.  The host will start
- * enumerating this gadget when the pullup is active and a VBUS session
- * is active (the link is powered).  This pullup is always enabled unless
- * usb_gadget_disconnect() has been used to disable it.
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_connect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->pullup)
-		return -EOPNOTSUPP;
-	return gadget->ops->pullup(gadget, 1);
-}
-
-/**
- * usb_gadget_disconnect - software-controlled disconnect from USB host
- * @gadget:the peripheral being disconnected
- *
- * Disables the D+ (or potentially D-) pullup, which the host may see
- * as a disconnect (when a VBUS session is active).  Not all systems
- * support software pullup controls.
- *
- * This routine may be used during the gadget driver bind() call to prevent
- * the peripheral from ever being visible to the USB host, unless later
- * usb_gadget_connect() is called.  For example, user mode components may
- * need to be activated before the system can talk to hosts.
- *
- * Returns zero on success, else negative errno.
- */
-static inline int usb_gadget_disconnect(struct usb_gadget *gadget)
-{
-	if (!gadget->ops->pullup)
-		return -EOPNOTSUPP;
-	return gadget->ops->pullup(gadget, 0);
-}
+int usb_gadget_frame_number(struct usb_gadget *gadget);
+int usb_gadget_wakeup(struct usb_gadget *gadget);
+int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
+int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
+int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA);
+int usb_gadget_vbus_disconnect(struct usb_gadget *gadget);
+int usb_gadget_connect(struct usb_gadget *gadget);
+int usb_gadget_disconnect(struct usb_gadget *gadget);
 
 /*-------------------------------------------------------------------------*/
 
+
 /**
  * struct usb_gadget_driver - driver for usb 'slave' devices
  * @function: String describing the gadget's function
@@ -980,6 +636,12 @@ extern void usb_gadget_giveback_request(struct usb_ep *ep,
 
 /*-------------------------------------------------------------------------*/
 
+/* utility to check if endpoint caps match descriptor needs */
+
+extern int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
+		struct usb_ep *ep, struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp);
+
 /* utility wrapping a simple endpoint selection policy */
 
 extern struct usb_ep *usb_ep_autoconfig(struct usb_gadget *,
-- 
2.53.0

