Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7FFC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 22:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D245284AC8;
	Tue, 30 Jun 2026 00:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lX0OBn4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FF184AB3; Tue, 30 Jun 2026 00:52:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8929849FB
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 00:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A1C103F2D4
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 22:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782773548;
 bh=SCt7G2hq2F9HLRZOpyVj5IVV31fNWlHztkgJIXkmwaM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lX0OBn4mwY294E7WbeSIycyoLgz+whYjktStQ5R2xxjf7Q2eGFPt//o6k8pjGETrf
 j4HfwN6NQG8O8Q3AKsfp8pbMXcjpWr/9dJUCLEv17yAogkv/xOpi454WgoFOxQqOZ1
 C9H9HFYRvhYMEbjmzB3LXjPRarBWUDlEZnACTL9KfkHvin+bk3PTaqEbk8U3U0fPPp
 Ydnsfqglb8H9h90n6RqqUArZXl99k/9MBQboLsGSnIpxMqnVOQj8WqG54w672q7NSX
 +PhRacqivNVSMLO4xjiFZk1oyV896tonlhitWWsKIl0Zn7B5jO6ubyaBga84KgHjRV
 xeYcqk0FxjLoFYlhNIzNdu0oMNjnuAomJyVjd6YGApguT6htovuLUrFB9kWAsgWSK6
 K11G+HKz/7sKeDuQN6lbLLuUnxJRVomHarYizUv1xMiEk95ZNa49+a3kKnMz5XN49q
 RopM4NeJsY4Va8ZTJS7QXPGx+ZqP7BDQSXOKrv75w+Pn+cX//iIFi1qwfjtvLq0cDT
 C8cgVLbFzrgOxotDer3CUTS5CUPwIoGvnHo0o1gjIbA7lYd3/TC85+UOOxtgwQFRF9
 6eb6spt9kA7L9Jc3rlUokm82G1pHu6zLhOPjOMPiDpQgU8VXkg0CBBwCUQdDkcKXAx
 Hzv9wIW+ecNSfdiIdpJhR+lI=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493b8ed8e9cso2118745e9.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 15:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782773548; x=1783378348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCt7G2hq2F9HLRZOpyVj5IVV31fNWlHztkgJIXkmwaM=;
 b=AYF/xf0i447TAfth+ogUFfdxUae+y+LoTwL7rRmvb8vIybdz1LRNG0w4rDkic1Y0z6
 sJ6q5L/2Uwnma0Jl1LHbunpXKhXjzBkBOSwOKDgYXwSCPXYi9EjcpwmYW9IzN/DOKnhR
 WJ58ukpO/8t52RHhHghSh+oVjTg7cotG13LziI4+231u3BKl3Wzrn1GrjDdDCvlXuAiS
 iVIiWLQz5H6yscH7PdfzmfRFGoP0e86j+Vsud7xvNQPu0mE49q6dwo42zb12Tn+K4Arg
 SGLxBVlwQblWIysrD28/+TERXEnbXo+co+2+oL8DYI7vsATrgbX5J3lKHrYlMT/m4cRD
 lSVw==
X-Gm-Message-State: AOJu0YzT4ehlNQnwjXxGJPJ9w+nCL9FDnP8TUrMOu8fcRPyLIOmrmdcn
 54SM+MhBZMz6Tu+o0eg5podqr6/WL6N4Oib8PjePGcpwR/36/eGK0/pOkLC8xjsduyVJ0j4wemf
 Nr/WTL0gODjVL0LiMirLuwhIteMiAGV4RoRaFtdobF3bgiBmyAaewc6ha+vvuycudi6UawkwHwl
 l6tvo=
X-Gm-Gg: AfdE7ckXv9WVfHEh2oapKOnaz0Itne6v2+cPB7mdxlFf7xqVsdGb40RtHp+3I5QAiJm
 CYAo+5gPDexSmt6lNNh0UTYx1qDh6YCemZoOGEJ96LPnVm55GXBPOHIuRYRQjhvSH3+DzzmsbBL
 8Iz1G747xNYdjmH9V7tYdYbxYPrsiAZMM1Cm6yQnp53XD7WA0l/uXe6hYtGoJjUV7Y6H4OYQ+Aq
 k1Y+LeE3LTU2LAbbjWBD123txfA2wptJ4U9aIukAbjoUKJZum+RAe610ZQH7kqdPmMAcUD3biNP
 bfnbh14kxo2x/XcnlN87vuXWYeKzchYtvJ23fBYEpt/e8OBlELmhPWUEuuxz44lMb3Gv0D3koo8
 +rnZaEUF7J7w4IcVtwN2T8TxnSstAjGcvtdsA5TDYOGa2mvDTGVW3lSdOUakuwL6Epg==
X-Received: by 2002:a05:6000:27cb:20b0:475:2171:add with SMTP id
 ffacd0b85a97d-475523b35ccmr996945f8f.22.1782773548164; 
 Mon, 29 Jun 2026 15:52:28 -0700 (PDT)
X-Received: by 2002:a05:6000:27cb:20b0:475:2171:add with SMTP id
 ffacd0b85a97d-475523b35ccmr996925f8f.22.1782773547846; 
 Mon, 29 Jun 2026 15:52:27 -0700 (PDT)
Received: from workstation5 ([2a02:3035:626:ba8f:5998:4d02:a4c4:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194b0sm1965194f8f.1.2026.06.29.15.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 15:52:27 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] efi_loader: fix memory lead in efi_sigstore_parse_siglist
Date: Tue, 30 Jun 2026 00:52:18 +0200
Message-ID: <20260629225218.209368-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629225218.209368-1-heinrich.schuchardt@canonical.com>
References: <20260629225218.209368-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When malloc() fails for sig_data->data, sig_data is leaked.

Free sig_data before jumping to the error path.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_signature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 6aff5c14a89..1da656161bb 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -717,6 +717,7 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 		sig_data->data = malloc(sig_data->size);
 		if (!sig_data->data) {
 			EFI_PRINT("Out of memory\n");
+			free(sig_data);
 			goto err;
 		}
 		memcpy(sig_data->data, esd->signature_data, sig_data->size);
-- 
2.53.0

