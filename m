Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63145C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60668129B;
	Tue, 25 Feb 2025 00:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jGKaFWdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B348680F91; Tue, 25 Feb 2025 00:08:26 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F5981424
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d19e40a891so16503995ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438502; x=1741043302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmHGLg7qv0i/INRWbbEyV+eVtxLKpzPasFed3WxKX1U=;
 b=jGKaFWdDT8BJ6O+LO4KXrrOHEajLgZe1OZ7QF6M97lJi3mjUh448vyKylyNna9/DjT
 iv8/FWrOpA9QJT2QI/6uL1bCBaxT0eQp8SwoRVo/CT4ArsGW9nRhVoDDwc1kLRlOoXzW
 /Ezko6ctwCUTgAzxfYPivBQ/3oF9zFNwv+UBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438502; x=1741043302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmHGLg7qv0i/INRWbbEyV+eVtxLKpzPasFed3WxKX1U=;
 b=oIIxdGfW0CyJI8ebZjQ8Fo1b3WE8QjFdsMZ4nBcALlCQK76fUvH3iqm1t+RRXMUUtj
 eYH+YF0G36/F49w/N0A2KLENPXrorPxLuk+SKMp0XUiXtccgEE8upt5fuppx02zT5BWV
 vUbWmwsXwbqzDjgrugCbT+W8FZa20EuDZuofrYCkE7tTbeaEYh8HOZqJ/ZqYa4mNtSHr
 32J3hvv+GcKk95SkIcD1WkTm6hwFCducl+1qmiM/+bT+D7n7BehK+AtmmRR63tcf1HZX
 NfZy5Sdos1142xiEnC2rBpyJYgmES2rHIVL8eu7M+dMwS3oGZVk3PLZun3ktFkbsWOPN
 Ym6A==
X-Gm-Message-State: AOJu0YyW3jn/MJzxdgRvXlFZA7aJAFOZ+6nOvtcn7rw2DvE7nZnRaaOp
 WMJxIZUtusSZjBO5tOGLvYb4hhF4S/+CbL5ntrNuhERlVRRazyikjxi6WREqrgioHdMwDn/1obg
 =
X-Gm-Gg: ASbGnctNA96SZOEsJSWjvLjvS03UMAhVGz7KxtZTyMS+T940isjI+3zZNeysJIqC8zb
 bbCWs/YnkHhQEdQujgkzkPEjS1ie7NevKpV0ORvqCaKBtBBhjSsDZo2ioirYcAEdJg9JIRIAYV3
 HNEO29w+zxMc0abv7XQl2aYmABzKWb721KD6YSYGjKURNrF7RrIisrMt9aHuLeYgr2BPKGeU+ZU
 q4AwvuoNm//YBlcERw5RD6XpYboouPSTVsgz+/XmilnmD7kWNfJXykZh0PkN8+FeJaSbX9iQhZB
 xo+jVYV13SdtWEZnqrWcZ7TsxgXqYNmzlffp6Jxg8i0wWHmdA+7rOJn3+Uu+hrc=
X-Google-Smtp-Source: AGHT+IG6H3x90kwggNsOy/WqjY0aZb/1LX9PuOB3j8r6VTplO7aKu92MdcYjWd93TRNp/ucp405+Rg==
X-Received: by 2002:a05:6e02:13a4:b0:3d1:883c:6e84 with SMTP id
 e9e14a558f8ab-3d2fc0d3899mr13666265ab.8.1740438502652; 
 Mon, 24 Feb 2025 15:08:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 40/44] acpi: Add a checksum to the DMAR table
Date: Mon, 24 Feb 2025 16:06:29 -0700
Message-ID: <20250224230640.2665206-41-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

This table lacks a correct checksum at present, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to add a checksum to the DMAR table

 lib/acpi/acpi_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 3805b61159e..4044a64d688 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -66,6 +66,7 @@ int acpi_create_dmar(struct acpi_dmar *dmar, enum dmar_flags flags)
 
 	dmar->host_address_width = info.address_width - 1;
 	dmar->flags = flags;
+	header->checksum = table_compute_checksum(dmar, header->length);
 
 	return 0;
 }
-- 
2.43.0

