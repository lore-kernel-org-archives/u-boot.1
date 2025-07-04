Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB29C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6438206E;
	Fri,  4 Jul 2025 15:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f57Dtzjr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBECB82F00; Fri,  4 Jul 2025 15:43:02 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62720806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4a44b3526e6so14444441cf.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751636579; x=1752241379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teDzAMXbHXH2Tp1mk9ikXiHBqf22zP1HZHbtdWwPB1g=;
 b=f57Dtzjr0PHMWtfQe28wpRz2PgmxesVxUqIBg+qt5GbaTbvwaO06BROU4Vawj4o9ZP
 DvJzZOmiHN+hjwukgpJ5Ep3Ml5BMHwdoQd+EBN2VrdPMegX8d3SziZxwxBvwselbb8j4
 yoiNCjDFSPFWw1Qc1QjFoHwm+KUm6jPtrTM84hZjZixAVfKN2+ihVpeO+DmI+K+5UBBu
 ZHjpDsciUVcoah5jXO6qDa9rvhiRnx+yCxQ6lbm2mRSXrYhZLhkv7fQsTtTqwSipHDoU
 bT6pgc+CbBxTYvO+8S0cuXgGR8v6yxnyf25G0QlPrJe4QhGxhdBa83jZ/0uLpnV9W0wA
 c6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636579; x=1752241379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teDzAMXbHXH2Tp1mk9ikXiHBqf22zP1HZHbtdWwPB1g=;
 b=vnBvAlJL7T64zpnrTVlvVPT95+KhwYCpbKF9uK1J03ovJVRpFVdxBQP0msUQ70LS+G
 bfRSZpoKTlbEpvKgqKDnBITu7Ek/X7Xir1TJ/L4sygZbWzkbIWF9U9cy2cDXpmTl2z9f
 U1hNrMf+bnjEbE3bRfml7Bl8nso4o4Wcxpcc9akGU4NKAB50/KJ3F0K0u42qdnfXJyko
 IBK4hdk2LgbZ8vnqs20sw0UEncZ6snVEnnL7sXXD/L0+MGuchM/RNDepcG0QHTc68nQ9
 ZYOwfQgum+m0zCvd7pknOlRSnnXVZIxBpSuqbUH9VSMNHk5WNsB+VPJ0VsPChA+JEoMY
 A4gw==
X-Gm-Message-State: AOJu0Yxml1F0pdV72n8RO/gN9RKLREyOKoF+aYrNUzJmVrOS1EKuaRoL
 laUdHvl0+yIXR4VbiVXASu2RrR5qjd69kCUqxMb+H2433HaXSC5baPBJ4JtjxmGjLBMnagnOVbf
 1smh8
X-Gm-Gg: ASbGncs2XY522TxmxabdaVXOK08xsH19srkY8zruPq8K7YHJCLuFV8641ZzsAqRB/Bx
 2yVPGASLi5rCoqjl4oknAOzTf+kDf9rrtu4XcbjLraUFuGqpX6T1TQBYKuDqxkCgVWv0OjNQ0md
 rmxMdRgy7hzm6SsXhlTNYm30HGyAF3caP23P4VCCyVs9bXQNONte3rp1NUsbwhJvpLUkOFmjWIa
 WItgTD4etrfF+otet6zFN4Yp6HhjUHe0zS5JKVG8skExaStEm8Bu+QIVtrkt6hq1PCSZ4hWz4+B
 W0eVaaxszTIsnhXDpif31KVVtXSRQEx4MTbuv1ue+W37xwE5ccB2kiwjaCTN2eFi7HUPVquc2bE
 DhR53fmnkxaJyC39VZaxlmcdetgzk3JIf18gzPGD0i9V1qH8=
X-Google-Smtp-Source: AGHT+IHJ6poYyBZJ663Zo45R8tt1O5KCb6Mqtb7VbSGKDsr5ttLVpQbfolOcX82rskGtnOfd73FsQw==
X-Received: by 2002:a05:622a:199d:b0:4a7:5c21:d4d with SMTP id
 d75a77b69052e-4a996408245mr45975141cf.3.1751636578704; 
 Fri, 04 Jul 2025 06:42:58 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79606sm14071051cf.37.2025.07.04.06.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:42:58 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 6/6] fdtdec: apply DT overlays from bloblist
Date: Fri,  4 Jul 2025 06:42:05 -0700
Message-Id: <20250704134208.2895595-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250704134208.2895595-1-raymond.mao@linaro.org>
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
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
According to the spec update for DT overlay handoff[1], an overlay
must have the same top-level compatible string as its target base
DT has.
Before applying the DTO, it checks whether sufficient space is
reserved in the base FDT region. A margin (0x400) is used during
estimating the space size required by the merged DT.
A resizing happens if the reserved space is insufficient.
After all overlays are applied, it resizes to the actual size of the
merged DT.
Note that the margin (0x400) is arbitrary from experience, it might
not cover all possible scenarios as complex overlays with many
properties might require extra spaces and lead to FDT_ERR_NOSPACE
error.

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

 lib/fdtdec.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..bd5e3c0aaea 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1687,6 +1687,84 @@ void fdtdec_setup_embed(void)
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
+static int fdtdec_apply_dto_from_blob(void **blob, __maybe_unused int size)
+{
+	int ret;
+	struct fdt_header *live_fdt;
+	size_t new_fdt_size, actual_size;
+	int expand_by, blob_size;
+
+	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
+	    !CONFIG_IS_ENABLED(BLOBLIST))
+		return -EPERM;
+
+	ret = fdt_check_header(*blob);
+	if (ret)
+		return ret;
+
+	/* Get the total space reserved for FDT */
+	live_fdt = bloblist_get_blob(BLOBLISTT_CONTROL_FDT, &blob_size);
+	if (live_fdt != gd->fdt_blob)
+		return -ENOENT;
+
+	/* Make sure DTO has same top-level compatible string */
+	ret = fdtdec_match_dto_compatible(live_fdt, *blob);
+	if (ret)
+		return ret;
+
+	actual_size = fdt_totalsize(*blob);
+	/* Add margin for extra size growth after merging */
+	new_fdt_size = fdt_totalsize(live_fdt) + actual_size + 0x400;
+
+	/* Expand the FDT if the reserved size is not sufficient */
+	if (new_fdt_size > blob_size) {
+		ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size,
+				      &expand_by);
+		if (ret)
+			return ret;
+
+		/* The blob is shifted if it was following the FDT */
+		if (*blob > (void *)live_fdt)
+			*blob += expand_by;
+
+		ret = fdt_open_into(live_fdt, live_fdt, new_fdt_size);
+		if (ret)
+			return ret;
+	}
+
+	return fdt_overlay_apply_verbose(live_fdt, *blob);
+}
+
+static int fdtdec_apply_dto_done(void)
+{
+	int expand_by;
+	struct fdt_header *live_fdt = (struct fdt_header *)gd->fdt_blob;
+
+	fdt_pack(live_fdt);
+	return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_fdt),
+			       &expand_by);
+}
+
 int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
@@ -1708,6 +1786,9 @@ int fdtdec_setup(void)
 				gd->fdt_src = FDTSRC_BLOBLIST;
 				log_debug("Devicetree is in bloblist at %p\n",
 					  gd->fdt_blob);
+				bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
+						     fdtdec_apply_dto_from_blob);
+				fdtdec_apply_dto_done();
 				goto setup_fdt;
 			} else {
 				log_debug("No FDT found in bloblist\n");
-- 
2.25.1

