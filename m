Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB678C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F64836A3;
	Fri, 18 Jul 2025 16:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NV/ZM+uP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35EA3836B4; Fri, 18 Jul 2025 16:17:03 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97EF835B0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4ab7082b3f7so27492051cf.3
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752848218; x=1753453018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWdGtDByt/SJHSwQq5K8baz5B2xR7NDfkgL1LkvkTIc=;
 b=NV/ZM+uP1dR4kAd3MDhbJ1TBzVl3erSIx85V7gc8xTHuCUDg3i2HNWC2z+Qp/4lmVH
 o/z+bINFcM4Sf8Aeun5ZLzx6RLjELxJ47ey+8ZTyXAG6HfZYp5/2sX+zjZOa7oAJq61k
 MkocljX9lAnZmZkTvpg//BKlGB1XClgbco1EP85pKgcd4GTdkeH66E09DuDJCKPobF9x
 HMPEWG2GBBc2iw1syOqFgyPLogncNFsj2ruy38bh4l4UXAx+MKAUHvVbo6Bys4P9NW7r
 kIdU1PqOqJG3X9Xux5I0rKXRhkA0bJQ7oWRnv3hna7fXd8jQCqEqnazpqp/KzDIZwXQE
 Mb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752848218; x=1753453018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWdGtDByt/SJHSwQq5K8baz5B2xR7NDfkgL1LkvkTIc=;
 b=Xz16RGXWm1tFk8POdqwZHunOsqUvPNjVk6r4/KRpqrmiBuixzT0tAobAWr87fLwSs3
 drjUo7cls2ainLK1mYuttcqUWmVYdH1P9mpQauXjZuo2jtJ76rDNsSowH0sT9ozyrrY1
 dmnfoN8AfwOg7WoKC0VsMn7cCe8M0cUXZN2YLvHR/7EBkyePgX9Vz7901/mZxlVRScVP
 GtubnQdR0O/vGo7gJ/LUn7ChWzmTnb/jvStg9RTgAXHjGJngggHbPD5G0OaQJ7SUzLDE
 GlmkDGpMG9NZXIJSVThoXHxJZM8YdHvN2EfSP6gXiB78oITBjzK6yphfR4Fz2mm5NrSU
 ny7A==
X-Gm-Message-State: AOJu0YzWBjNFfmWaoqJIPWML20KeDUGP+B3nEoc0LDqCPrxxjWTXujoO
 6R5wqdSTKdgMVhqcepwy8iiG630CyxOjgXfxQibY+1IDNqbx5lvgindFbS1pR+QX22kBRQJ0kKT
 kMQEK
X-Gm-Gg: ASbGnctQPORbJK6WydYwZUJeDoFRty66gxf9DRC5QVYn9CvnPWUrvqOlGbAQ/2r6j4G
 FyFKTevVgTRgTDA2Se6rJaEk2/T4yR2RFBDMOhEIe5o+GaxTHXZeMUkffb0hgPp3EXzHnW/aSSq
 cQwmkqk8x6ObGyQt4oHoUuAMS7v2eVarxc8b8wAPPWzLSME5qS1ti718uWITt4KJLsfJYgVgdJb
 iH7zCx/CIdFqK44NdAYXIZtorw2DagkHf0jNq7mAvDVOSCd1ziLjvwrWAKl2Jb4x4dLJ1K4g9xh
 k1tyM5luM5sfHjoxKxYRzF5DYimPvNWU2ih0pRtIZI8AE6PK6do06UcIx2UtU178YyBOljuRQoA
 AaxEez9aJEAIbfIep0DKMw/yP0KPk8LxjJENsRCTP4K4/fD2zLtzSxhYvbGxux3RdtNm8V/284z
 rUdHnGzAM=
X-Google-Smtp-Source: AGHT+IGKdVx5Xlsp825ksAVqkonNs3EtAGbRSZ0gmm23ztQd4sNtd08Ndk4gPG2IRA/lIxWWyb/cSA==
X-Received: by 2002:a05:622a:610:b0:4ab:66d1:dcdd with SMTP id
 d75a77b69052e-4ab93d814demr226871561cf.39.1752848217747; 
 Fri, 18 Jul 2025 07:16:57 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb499e91csm7558341cf.19.2025.07.18.07.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:16:57 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 5/6] fdtdec: apply DT overlays from bloblist
Date: Fri, 18 Jul 2025 07:16:18 -0700
Message-Id: <20250718141621.3147633-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718141621.3147633-1-raymond.mao@linaro.org>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
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

During FDT setup, apply all existing DT overlays from the bloblist
to the base FDT if bloblist is being used for handoff from previous
boot stage.
According to the Firmware Handoff spec update to support DT overlay [1],
an overlay must have the same top-level compatible string as its target
base DT has.
Before applying the overlays, check whether sufficient space is
reserved in the base DT blob, if not, resize the blob to the allowed
padded size, which is limited by CONFIG_SYS_FDT_PAD and the bloblist
spare space size.
After all overlays are applied, resize the merged DT to its actual size.

[1] Add Transfer Entry for Devicetree Overlay
https://github.com/FirmwareHandoff/firmware_handoff/pull/74

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Add more details into the commit message.
- Check and compare the top-level compatible string of DT/DTO.
- Check the reserved space in the base DT region, and skip resizing if
  the space is sufficient.
- Move the DT space shrinking to the end after all DT overlays are
  applied.
Changes in v3:
- Move resizing to the beginning and only do one time.
- The max size to resize depends on SYS_FDT_PAD and the spare space left
  in the bloblist.
- Renaming and misc refactoring.

 lib/fdtdec.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..630b7d2bd69 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1687,6 +1687,83 @@ void fdtdec_setup_embed(void)
 	gd->fdt_src = FDTSRC_EMBED;
 }
 
+static int fdtdec_match_dto_compatible(const void *base, const void *dto)
+{
+	const char *compat_base;
+	const char *compat_dto;
+	int len;
+
+	compat_base = (const char *)fdt_getprop(base, 0, "compatible", &len);
+	if (!compat_base || len <= 0)
+		return -ENOENT;
+
+	compat_dto = (const char *)fdt_getprop(dto, 0, "compatible", &len);
+	if (!compat_dto || len <= 0)
+		return -ENOENT;
+
+	if (strcmp(compat_base, compat_dto))
+		return -EPERM;
+
+	return 0;
+}
+
+static int fdtdec_apply_dto_blob(void **blob, __maybe_unused int size)
+{
+	int ret;
+
+	ret = fdt_check_header(*blob);
+	if (ret)
+		return ret;
+
+	ret = fdtdec_match_dto_compatible(gd->fdt_blob, *blob);
+	if (ret)
+		return ret;
+
+	return fdt_overlay_apply_verbose((void *)gd->fdt_blob, *blob);
+}
+
+static int fdtdec_apply_bloblist_dtos(void)
+{
+	int ret;
+	struct fdt_header *live_fdt;
+	int blob_size;
+	size_t padded_size, max_size;
+
+	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
+	    !CONFIG_IS_ENABLED(BLOBLIST))
+		return 0;
+
+	/* Get the total space reserved for FDT in blob */
+	live_fdt = bloblist_get_blob(BLOBLISTT_CONTROL_FDT, &blob_size);
+	if (live_fdt != gd->fdt_blob)
+		return -ENOENT;
+
+	/* Calculate the allowed padded size */
+	padded_size = fdt_totalsize(live_fdt) + CONFIG_SYS_FDT_PAD;
+	max_size = bloblist_get_total_size() - bloblist_get_size() + blob_size;
+	if (padded_size > max_size)
+		padded_size = max_size;
+
+	/* Resize if the current space is not sufficient */
+	if (blob_size < padded_size) {
+		ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, padded_size);
+		if (ret)
+			return ret;
+
+		ret = fdt_open_into(live_fdt, live_fdt, padded_size);
+		if (ret)
+			return ret;
+	}
+
+	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY, fdtdec_apply_dto_blob);
+	if (ret)
+		return ret;
+
+	/* Shink the blob to the actual FDT size */
+	fdt_pack(live_fdt);
+	return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_fdt));
+}
+
 int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
@@ -1708,6 +1785,9 @@ int fdtdec_setup(void)
 				gd->fdt_src = FDTSRC_BLOBLIST;
 				log_debug("Devicetree is in bloblist at %p\n",
 					  gd->fdt_blob);
+				ret = fdtdec_apply_bloblist_dtos();
+				if (ret)
+					return ret;
 				goto setup_fdt;
 			} else {
 				log_debug("No FDT found in bloblist\n");
-- 
2.25.1

