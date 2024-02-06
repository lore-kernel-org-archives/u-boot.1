Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E659BC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F00587CB8;
	Tue,  6 Feb 2024 23:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7BD87CCE; Tue,  6 Feb 2024 23:32:11 +0100 (CET)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752F087CAA
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-51156cf5766so530827e87.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258728; x=1707863528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NV0f35Yhv7R/VKc5U1eFIJT6PehCHbCbpaltfL/SAk=;
 b=lsW7GmsZfpTMpz5kgkwBTCHL10fjJnVwHtps6A2nENr6jhO1Bowp7/WtglK3WZopa+
 m4cK8Q/kjLFVnUwzNaCZr7j6BHgTC8pRbsfuHk2cwZgh/a0pHXyVoNn5vhl2A2gpGP+P
 W4SvWnUpQfEwdHZfxhGvkquXc4FEhUP/+dyiCl+iVDvMlNOo3zxxEufFxCXiceEmSlGD
 uS06zHQRknXknMmyNfz0EjzRReRxUnzje1jluiBgv1L/6vCzoLbq9QAGfiPG1EtkXqGA
 +bCPMZoOLUboHLsqGMXhFCn0b4/X30Yvb1zTcErCXudcCOJ1VG6rjpSFHvX+hZ9fC3yL
 vRTg==
X-Gm-Message-State: AOJu0YyyZVoib/kUwLSa6FoTOKpQIGgtS/nBmyd7SWHhC1zhubc4T51B
 vd8TVqAIoZxi+qWnqGQKPKrBD54BmXdWn0K39c4cjAHsIlk2JgpDqbRrivy/eszE2w==
X-Google-Smtp-Source: AGHT+IHUb4jRrjfFYkhX5Pa9IZd2iixZC60uVKRmAXXcYoPoeroDO+3U0HPYh8O9xsQ0/PwW3mpvdA==
X-Received: by 2002:a05:6512:511:b0:511:5b35:d118 with SMTP id
 o17-20020a056512051100b005115b35d118mr2282102lfb.2.1707258727912; 
 Tue, 06 Feb 2024 14:32:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXbJBNY2WryZlP55iHmi9elRp9ICEtyW9D12XM0LH1qUdXqvuN4FaR54L/8boa1lF1NMVXqC/zLac+SjnJHAPsyrsuqjOtE646drW7p1onbyMOpkzRGvDPCxsG6r3y6PRWSA9zY+EgfeF0C9leZn/Qh7UmxvSHX60tFgPjEMNDOXxunNeKulDTCqQnTVacK9W0=
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 u5-20020ac243c5000000b005114ee99515sm354342lfl.220.2024.02.06.14.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:32:07 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 5/7] common: avb_verify: add
 str_avb_io_error/str_avb_slot_error
Date: Tue,  6 Feb 2024 23:31:51 +0100
Message-Id: <20240206223153.3060433-6-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Introduce str_avb_io_error() and str_avb_slot_error() functions,
that provide a pointer to AVB runtime error message.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 common/avb_verify.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++
 include/avb_verify.h |  3 ++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index ed58239cf8a..cff9117d92f 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -119,6 +119,55 @@ static const unsigned char avb_root_pub[1032] = {
 	0xd8, 0x7e,
 };
 
+const char *str_avb_io_error(AvbIOResult res)
+{
+	switch (res) {
+	case AVB_IO_RESULT_OK:
+		return "Requested operation was successful";
+	case AVB_IO_RESULT_ERROR_IO:
+		return "Underlying hardware encountered an I/O error";
+	case AVB_IO_RESULT_ERROR_OOM:
+		return "Unable to allocate memory";
+	case AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION:
+		return "Requested partition does not exist";
+	case AVB_IO_RESULT_ERROR_RANGE_OUTSIDE_PARTITION:
+		return "Bytes requested is outside the range of partition";
+	case AVB_IO_RESULT_ERROR_NO_SUCH_VALUE:
+		return "Named persistent value does not exist";
+	case AVB_IO_RESULT_ERROR_INVALID_VALUE_SIZE:
+		return "Named persistent value size is not supported";
+	case AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE:
+		return "Buffer is too small for the requested operation";
+	default:
+		return "Unknown AVB error";
+	}
+}
+
+const char *str_avb_slot_error(AvbSlotVerifyResult res)
+{
+	switch (res) {
+	case AVB_SLOT_VERIFY_RESULT_OK:
+		return "Verification passed successfully";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_OOM:
+		return "Allocation of memory failed";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_IO:
+		return "I/O error occurred while trying to load data";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION:
+		return "Digest didn't match or signature checks failed";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
+		return "Rollback index is less than its stored value";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
+		return "Public keys are not accepted";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA:
+		return "Metadata is invalid or inconsistent";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
+		return "Metadata requires a newer version of libavb";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT:
+		return "Invalid arguments are used";
+	default:
+		return "Unknown AVB slot verification error";
+	}
+}
 /**
  * ============================================================================
  * Boot states support (GREEN, YELLOW, ORANGE, RED) and dm_verity
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 2fb850044d9..5d998b5a302 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -52,7 +52,8 @@ char *avb_set_enforce_verity(const char *cmdline);
 char *avb_set_ignore_corruption(const char *cmdline);
 
 char *append_cmd_line(char *cmdline_orig, char *cmdline_new);
-
+const char *str_avb_io_error(AvbIOResult res);
+const char *str_avb_slot_error(AvbSlotVerifyResult res);
 /**
  * ============================================================================
  * I/O helper inline functions
-- 
2.34.1

