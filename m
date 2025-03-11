Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73AFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8AB8192A;
	Tue, 11 Mar 2025 17:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fr6xWn0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD3781760; Tue, 11 Mar 2025 17:48:15 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C499C81A02
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso160255ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711691; x=1742316491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICt3UKKzwSl83MMU+WnUiOM8RK4JyFbyqqDoNq3/iBI=;
 b=fr6xWn0HlD1jEJ5Fn0zJdQ/QgMBi+1yvHN1SPX2jC/GBhgV/VbaSfq8MvQRftmEDi1
 S4uF/eqDmHWyPUYIR0dpJ5T2IlvMiT6BtU0RA7m/cS3ZO9oKo+35/y+WtlIqRolI0SAb
 LyWfG3U7N6a2USsYOMshNYyZXPdaFDMi/J3924JyOqTUQqyXJ5jVKo1UijZ1TOu42R8S
 eBztAv8XbX+3bWRnGL5TgnlM4CUwxTX1okoW2s4WCpBZW2TXtwRFhxcDLPuxumlLTbgr
 c2kn44q8QtpKxh3GH7oZjoSUOU6uSYjU1bCO6YEegHIEpl1BjFgSNeQ3YJRJm2d5Zrz2
 SDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711691; x=1742316491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICt3UKKzwSl83MMU+WnUiOM8RK4JyFbyqqDoNq3/iBI=;
 b=DakO5eGET3Wj9A3F/vL3KUNj2IqxzPyl6KkcxdS3ayyiJENF8ibdKQRJd/BaCNOWx6
 s2R7NBba1HeNUdaUdGzuMw+ap4ltw0TW4UGSd0joCMfNwIcJvnytf9tXifod0IXvUrBH
 tkVZUDMVv0aLO/EofMO7+Dy195W/NoALGAmUS8JckS6/AAJbo66gUnSBywvdrZfhmF0h
 0d2nk66C7e+MmfBATa77FrkYSxhusPsNhFYly61ZTffy29Im5kuvUdZj3zWmAGREo4HN
 v+ekX3EeIoKTIt8xYXaR2WPMnbEfP3bQozVhVLa6sHTDUl+b/71rCWtD1ovcrD70dbPL
 /1zg==
X-Gm-Message-State: AOJu0YwEwQfrcdzr8hOrkZpdhwjddOXVuwPX1tR1HSSQEWBeISu4YZ8t
 LJuByGu1yGxcF5Zy0Wr8JxsZI0ruryzJ1koIDNQ/EUAV+koXqy4ryVad1qYl3BY=
X-Gm-Gg: ASbGnctM0i7OUeoCrjXDbi0u1SsV6tR34EiNOBjcAMNQol9RLEJ15/rUyS+M25cEjB5
 J0HSx47eR9bnuedjCsWGWN7n0UIl9FuOi0b9KT2M16Pu2V+LjL/BlMjRsXUyzT8VX2yHJ6msCPV
 oVaHLGVLP/Enc9a+8VbwnOmSILlmFpVkcVHnTTb5lNYgeV3NpFo5iSwZt96v/v62TeWw2rCYep2
 H5dIge+3UECnr+HsJAlAxqE+AYqVH19z2b1tIOIAqA/dcR/X6YqwKb1c0Gk2WCO7kllIaueGBjz
 Ich7RuVBPbciKQ++S3nR9h4bGaBFJvpRewZ0a6G/K3Ni5bKnlVuvDA4=
X-Google-Smtp-Source: AGHT+IHxVi2rpvSrB4pURk7uk8QpuZfoBJN3IrutiMwc1L5eL8AC4H32ypy62w+4/LwH2KQWrqXePA==
X-Received: by 2002:a17:903:2308:b0:224:3d:2ffd with SMTP id
 d9443c01a7336-22593dc61f8mr57343815ad.17.1741711691198; 
 Tue, 11 Mar 2025 09:48:11 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:10 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 09/16] efi_driver: efi_uclass: Add unbind method to
 efi_driver_ops
Date: Tue, 11 Mar 2025 13:47:51 -0300
Message-ID: <20250311164758.421900-10-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_driver.h        | 4 ++++
 lib/efi_driver/efi_uclass.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/efi_driver.h b/include/efi_driver.h
index 63a95e4cf80..8f785f79459 100644
--- a/include/efi_driver.h
+++ b/include/efi_driver.h
@@ -36,6 +36,8 @@ struct efi_driver_binding_extended_protocol {
  *			driver binding protocol.
  * @bind:		Function called by the EFI uclass to attach the
  *			driver to EFI driver to a handle.
+ * @unbind:		Function called by the EFI uclass to detach the
+ *			driver to EFI driver to a handle.
  */
 struct efi_driver_ops {
 	const efi_guid_t *protocol;
@@ -43,6 +45,8 @@ struct efi_driver_ops {
 	efi_status_t (*init)(struct efi_driver_binding_extended_protocol *this);
 	efi_status_t (*bind)(struct efi_driver_binding_extended_protocol *this,
 			     efi_handle_t handle, void *interface);
+	efi_status_t (*unbind)(struct efi_driver_binding_extended_protocol *this,
+			       efi_handle_t handle);
 };
 
 #endif /* _EFI_DRIVER_H */
diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
index fc8808374a1..36a86817eb7 100644
--- a/lib/efi_driver/efi_uclass.c
+++ b/lib/efi_driver/efi_uclass.c
@@ -249,6 +249,10 @@ static efi_status_t EFIAPI efi_uc_stop(
 	if (ret != EFI_SUCCESS)
 		log_err("Cannot free EFI memory pool\n");
 
+	ret = bp->ops->unbind(bp, controller_handle);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
 	/* Detach driver from controller */
 	ret = efi_close_protocol(controller_handle, bp->ops->protocol,
 				 this->driver_binding_handle,
-- 
2.48.1

