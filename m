Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455CFC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C7182E17;
	Wed, 18 Jun 2025 16:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TTRxLlTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC0D82E20; Wed, 18 Jun 2025 16:59:46 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 553B482D4A
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6f0ad74483fso73101446d6.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750258783; x=1750863583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+YZ6USJM9xBixF0xpee0MyPdYgsd6OUEB1+o6+yplg=;
 b=TTRxLlTJvPDgQqlmXtcOvCWXSl7y6WFBVmn4a02Ivn5h5sjDRnEJx4eY02OCLxjYgy
 oc6jPPQGF+exL1Yn519KSYM8ZYZN1ksBq9KQRoDmSauu3TY3ocRhhCqwP9c8T9eXvZ1J
 W35jCoYZvUeRtVxN7Gg2iw+evpPJQhVd7iAIZMsh2/Ojt5d+KMxuGmrSNrrXDtm0jwQB
 wrZpISg9Zkqey/O4LoQhjzEBV+zw3Rs4g92nqakzVoY/QZhnZD5nb7SfcxkwPkPgokoB
 5jh8f13hRp0Ha+k9MHL/8gbLSIs+etIXIzYDYRLSIhJh5AD8AL2zWoAMVjuF62ys2fGp
 j55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258783; x=1750863583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+YZ6USJM9xBixF0xpee0MyPdYgsd6OUEB1+o6+yplg=;
 b=Pu+A4Ho7IsEEqVf1veG9Vm25YK9CmZXgmYq3crpi8iwthPYtu894vkSFS03VV7tTqg
 vIXWZ1zHNWVRj79uGhF08mEAEFx7HSEeZe4rpD0ZMPaxvPBQLvatxpk/+fYGxR5vTkPK
 Z7vyQ9RqPkM3vZQCN1jpEa7dCQfx25/11WNa7enXcPHEZcLA0ZNiqP7X4qKcYiu8i1Vz
 7/3tbdQ9OGkmLriaw3s53pewCWvYWuMKQYZ30FQ9AEBNpTfSME/ziI5sOVRQ83Ik9w56
 8tFQHIs9mRbyt5ijf1xjlwwWWJBS1Dq7NADfApl+9UtHXjwVAHhQHoke/nmIuktQ4wMi
 GHyA==
X-Gm-Message-State: AOJu0YyZZj9++6QlLTBW8PJTnmeXaD2RSOSNam8vhu/DOuNDSOk8Sf5J
 LC/hH7xNSGI+pWpAYbXl2Fm4WKuk6N7cFS7Nf98DHBFpsQt9dxdBclJw82in26YAhJo8IpGWVuk
 RRfVK
X-Gm-Gg: ASbGncvaQIc65x+ylXifd3CwShnHFVIiP6WzCUT4OmepBO/NST6z+pNZfz711A0r4aA
 UI+PVD98HoKlkBYqw2P0RJ6awEeyFzHGvg4+PnVbnRSc97zcnJTt/TTN5oLJOD9Ejd3FSL0f692
 NyMjh1PUhpKPfTBQM93MDIreuM9Y66ps8zl+wVQH9/F6xKBWK7N9i44afXDeYK1KHycWAHY+ZIH
 PsCTsqLm9XUKfjOVqk8i1I7M7MhVriXNBKdDTKnhRmVCtsE+VCWSqB/3E7sNTLEbjdgoC4aK9pD
 VWglYkIEG1BPzHJABtXet4t8lk8Nh2jxFXzmsb06CmGW3GPE5khiMw6gXh5G2HDCk5I9l1hdeOC
 EXNIfQOiCmDilgoBXPn/8vkSTSyLi4q9DZWJ3xpqslk6ikjI=
X-Google-Smtp-Source: AGHT+IECtmWeNDdIR2ys9We/v4wbhkJRXLEvLIO18h3NF75ReBt4t5chISldHgwuLObGUpw51B3Ydg==
X-Received: by 2002:ad4:5e8c:0:b0:6fa:c697:97b5 with SMTP id
 6a1803df08f44-6fb47774552mr265868106d6.20.1750258782610; 
 Wed, 18 Jun 2025 07:59:42 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4d627a14sm44736416d6.68.2025.06.18.07.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:59:41 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/6] bloblist: add blob type for DT overlay
Date: Wed, 18 Jun 2025 07:59:23 -0700
Message-Id: <20250618145930.2652304-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618145930.2652304-1-raymond.mao@linaro.org>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
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

Add blob type for DT overlay according to the update of Firmware
Handoff spec[1].

[1] https://github.com/FirmwareHandoff/firmware_handoff/pull/74

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 1 +
 include/bloblist.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..1c690f58b56 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -43,6 +43,7 @@ static struct tag_name {
 	{ BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
 	{ BLOBLISTT_TPM_EVLOG, "TPM event log defined by TCG EFI" },
 	{ BLOBLISTT_TPM_CRB_BASE, "TPM Command Response Buffer address" },
+	{ BLOBLISTT_FDT_OVERLAY, "DT overlay" },
 
 	/* BLOBLISTT_AREA_FIRMWARE */
 	{ BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..b40e04fe2d3 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -110,7 +110,8 @@ enum bloblist_tag_t {
 	BLOBLISTT_ACPI_TABLES = 4,
 	BLOBLISTT_TPM_EVLOG = 5,
 	BLOBLISTT_TPM_CRB_BASE = 6,
-	BLOBLISTT_ACPI_PP = 7,
+	BLOBLISTT_FDT_OVERLAY = 7,
+	BLOBLISTT_ACPI_PP = 8,
 
 	/* Standard area to allocate blobs used across firmware components */
 	BLOBLISTT_AREA_FIRMWARE = 0x10,
-- 
2.25.1

