Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCFDC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F7981E06;
	Thu,  6 Mar 2025 17:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HLOnE3tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811BE8164D; Thu,  6 Mar 2025 17:06:22 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662B7817C4
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3cfe17f75dfso6604475ab.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277178; x=1741881978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVc0+gHk0Mrzf8/82i8eEjwipEH5rcGBnucmf3Js+90=;
 b=HLOnE3tzGnHUv/Qoi0U95w5xWOz/ojZ4+Zgc+BWs0X2jFZJe9SCBye6lJXDFxabduX
 MSrDSSfCsuAo6EILdgaeowqKxYCR3O7n73Y0tv56ureWmBb8A05txknaYPlOzy/W9wRF
 Zkr7xnSKLiEkR3DxbFWy647DGGFkF87gkdoJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277178; x=1741881978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVc0+gHk0Mrzf8/82i8eEjwipEH5rcGBnucmf3Js+90=;
 b=CVVDZoobiRxaTv6LXqvvsS1VaSFx63u+0eDiLE5dRe9spKHXaqRIz70ei5BIAknhPl
 /izB2Zg+t3Zk/RBRDqd1mcoIdd+BV2vZlTqj036LVKgMMvJZ/MsEXgQvq8X4CCnpSnf6
 rjsDDtlrwf8q54ZztVV6D2k7LQTLfyjD6tm6EWsIxXPbeyDwiEXYpd0Xf/ymLxXqI2Uo
 4Bc+ezbTVhtB8xTzz+xNPp/+a0qyH/P0s47WHlyaldsjXB4sSkWrpkbbF01o/E6KzF5F
 FDMOTHeMH49A9CcJOtIK7F1yFBkL0iJ4iZz6KNy4+FdikpvnEBBnjeMA6IfKxmxXr5fQ
 se7Q==
X-Gm-Message-State: AOJu0YwTfLZ7jIxHJ8OgHXYiIB6O2MaNDCuH9lEits9IK90VyFaje4tB
 6AZ6UMuT/YBKyJWSPJ0RWmBgkyYxdTRLkJbaij4+HD2DjalIyu7aUlARqLwWLh1s3zmsk5cSfSY
 =
X-Gm-Gg: ASbGncsZKk0wETLbzLhBChRxLcuM6pJ7dZ7KmTyC7RtPxKn6JnBY1Z35GWf9nrm1w1+
 Vzf1O/yjCfmhQQHThpVtjqWRw1ia3KOpSUmKDEzjb2sfGnGXm9ETOykJS2dOc4VUeDhSUUCHPd5
 7ZhHoMFPVZ/UlWhrkKW7Aus/GlGoBQp1fpLFmM5O/Jir6KaY8Jkg811cBLzthkVzabg20pp7qBC
 59yFDJgJ0UjrRGkd8v/PxWhSW4VvsZCh+BoKCqnK1a/iPFMjcLc1MeKgieZNKwnlvXavyxVleNh
 kJVoOATMUfoYyrNnSyDINwSqlVWSFtPh60knyUgYzHcFotFHCx36PXUycP9Qp2Osa3+kEX7EYxh
 AD5m7sA==
X-Google-Smtp-Source: AGHT+IFn7+aGTbtSWlRhq3vprmDto8/DvJvYSeAWhl4+OeaEmQhWmJTHxynfJPNNhE5TzQEr+z6N+w==
X-Received: by 2002:a05:6e02:16ce:b0:3d4:3fed:81f7 with SMTP id
 e9e14a558f8ab-3d43fed82e1mr11260135ab.19.1741277178404; 
 Thu, 06 Mar 2025 08:06:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 42/47] sandbox: acpi: Correct mapping in FADT
Date: Thu,  6 Mar 2025 09:04:09 -0700
Message-ID: <20250306160428.3041057-43-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

The values in the FADT are pointers so should not go through sandbox's
normal addr<->pointer mapping. Fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Split out the command change into a separate patch

Changes in v3:
- Add new patch to correct mapping in FADT

 lib/acpi/acpi_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 150f75027a5..3805b61159e 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -255,8 +255,8 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	header->creator_revision = 1;
 	fadt->minor_revision = 2;
 
-	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
-	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
+	fadt->x_firmware_ctrl = nomap_to_sysmem(ctx->facs);
+	fadt->x_dsdt = nomap_to_sysmem(ctx->dsdt);
 
 	if (fadt->x_firmware_ctrl < 0x100000000ULL)
 		fadt->firmware_ctrl = fadt->x_firmware_ctrl;
-- 
2.43.0

