Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8146606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yAxj/Twh;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=T1gixK1A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 762C860679;
	Fri, 30 Oct 2026 12:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byr1vQANRXC9; Fri, 30 Oct 2026 12:28:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B39AB607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363324;
	b=YT0T/577keYCB835N/rtyPXcNpCw81ESE19rKNc/2JsOpJPaTbRV4v38nx/O2ektPbHj
	 eFjXm6AkPs22FLbasR4HwQXs+O0tYYn7n9eyEUO7mgEcb4e7mmAsZq/39nevFvWSxBMSJ
	 RI5pDLT41J23wNRseGgs2Ic1xjQJyJkgnvELZ+sEnEFh9p8hRy7kq/Tvg4vaFlZP3dTkL
	 FBQKBpig8IxxtAM+urYZ8cTfnjyJihd9qrtoojJT/kwI7q9Jf0W2cQt1jEXyxTTtT9lXT
	 4ne5d0h09z4C9EbJ1zmMwBaZbq9V38oTt1HLZ3NHehyCidCAjDWPFKiK18GURz6Cpgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vyOhVqv87+xDdmgiUOE5phTtJIC38WKyP+A/AQwWjI4=;
	b=s8yPFqIJgB/T+Fcdf9fXjE9uDNbRMRCr+L74/fbBKq3DJKMx6EZZup9kz4nN+o5wB86Y
	 NCdPNQdYsYg16001OWleQrzObYAwNDrLN1B5p+SAviHuYAmpOA6qD/xgMYl3oDwWp9gd1
	 ioH+HqxuVkrwthDOiJJ3fQejXSOgrkgKZo5pSRvm/fovH8bhhLJIEQGPJppwOoJyG9V/o
	 edbsGAy49cfHi0pchqDoqSTgwfefkEVLcFBOOEpIRiCge4ZS3/QZOt4Yg5ttHDkkA1NB5
	 dw5Ma3547EpFZqM+Lfs1crKlKUNtz2b3lYCYiXURVKRe8txiePFXR8o53CPW1Ns35iw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=T1gixK1A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363324;
	bh=vyOhVqv87+xDdmgiUOE5phTtJIC38WKyP+A/AQwWjI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yAxj/TwhiCEOq9BeHnSnHqQYUo7w6yZCnfj/3i7j+FHqyNV+pIgYaCiGPAYQtb+RA
	 ZFjr8Vwh+co7fitm+4yvvsPgtYRxu6lbJwScdm5aa/u79byIvKMfnhZyBj9dsxPt4o
	 KDEbqC8VsFSL++lelR9FgZh5Ikz/SbxRH0776KNosFtM3dDnA2h1qi0KZNKrc3xRJq
	 /f33NVMu+83XkiOhaHfJZdZQDrqYyzSBvicSUbwjKEd21T9CZzaAUIk+3uKy9vkN2C
	 us5yDB92Z5HP1YML5w60oEkMRe8x2sgLjJFl25tgdNEUg9OawlW7YtTmnMpE5qvkcy
	 adNF8C5fBSVAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B39AB607A0;
	Fri, 30 Oct 2026 12:28:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A87B362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87FCE607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XYkFN0tCuqiV for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:28:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7731960679
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363318;
 b=qV+cWrOxlsl1R13L+LzttXcpk5knw3PWmzIzuFxm4sODBcDuvaMdKohWfiXU07DmoXms
 JSKLRj09KdCwHlLEFCiA8ceVZS3fft5x1poznZhHNOMpWGCOUxIRhSX2JyK6Zgduh3XDe
 JwuxT7T222J55FDdm2fKMEjt37RMYq8Nnau6iAXlS13fplokZxPMxFQuWkDjUu3Dpd7z5
 KG01xrwfn0etttOXOyP6G1KzL40aPFYExUPoeXiulMLGOxRCjKJegxVhCD+C9fPiYPvMn
 59Slw29Ges43xTycnuh7lMwbE8gAuFgqIZvm5m1B2qigvdOS21us/iGFOqnnpSRBLjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363318;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=vyOhVqv87+xDdmgiUOE5phTtJIC38WKyP+A/AQwWjI4=;
 b=lwpfWc4awJk0QWbN2553Qxv4KMR71zFNJvLFpj/npvcDjy8ZEE994IO6exLSBYQhOxwy
 ZOSivQMR5aWDnGEBkW1kqg5g6ZLw16Adm+58rC/x0d+d+cDhKO/cI33cHCgIxye3hucW3
 YyV/noPzq+0DH22aT0emSle/P8Um9X19+QQvcPueNuiQMbZUzKcFDBJxbC2iTWN/NrDcx
 PGbTSb+DPChw2c1GEx4UXA7dIGSxPosnBSDLXC7wmqqf457ZeIj2SZn+kxLZF2+UNwoqR
 HhTG5EzFIvxY6+R7dwKDbyvTiMvTKZdUEDlW/oUWhtSsPrMRneUFKJUISzc+aQmKDLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=T1gixK1A; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=T1gixK1A
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7731960679
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:36 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so5696005e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793363315; x=1793968115;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vyOhVqv87+xDdmgiUOE5phTtJIC38WKyP+A/AQwWjI4=;
 b=T1gixK1AdirGmh4Chi/5ptRmuDZKV6BkSgSNoC9NPmjD2Ht8w1IKgSJt2b8XTGptoV
 0rSuVmxfvHKPtTQM6PP3Ia8SLZlB/Bf/TWfrVHrUKqE6qP6uuGHl7u8KHQkxoCzQmdSz
 WGkknmSsxaxZnFwW75BXTCXZoHpgVQHtoEI8sfePc02tHU8KoEyXX3jXEumMwakZafr0
 mMM6z0sOE+zYvscHFvb+/uk1lfi5svncY2VhLizPdRIQ6Qe4OsmkbLeCWMH7MKu8rsaU
 FZlVyjOeFHQItdCLNgpDIORDSJdLif5U+XbsPdkPkPXRXkRaZ1lDk3i2zug1N1AhmbBa
 EFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363315; x=1793968115;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyOhVqv87+xDdmgiUOE5phTtJIC38WKyP+A/AQwWjI4=;
 b=hhJZydl4oO15HcsBPVFBXzkEm3an1cdF028ReVHrvopICBOWqOSELnLuVzM5IyRY3N
 dwz0bWSL9lNtjGXckV8wPD3sDu8cdgp19cm5tn4sI6TsZOlcfyT9g5OqJJNXiBQiV4Hn
 hhyGXxDInqqUNfhm2GErNj9ajiTvaZbf9KM6S2VTZJkhaOPlr3Eq5gYeMBmrk77Pwbly
 rpgYCYKJPpfYa+MSv7+/vspRxVUxv4QPQZP+KPkh/mc47F1S3rEIQo5C4sLSdodpv3h5
 L0BqPShcsZpGudSsfh7bbhZZW4RBJELNqvfM5NBtKiytkExQoC0Aceyz5ScW4Gc++Pn2
 fkNA==
X-Gm-Message-State: AFq9FYJkpj42Dfm12Pj2izeyieP6VPITHKfTM22O/hzfpwK30TytUv7K
 Kv0w/RxPESelF9l5PJxpeFkzRuoxTEDRf44UQIrGviHd7ypPChnyT6Ot0Bdu/TOaHHc=
X-Gm-Gg: AYBFou1S/hJohhDiV0uEHGr9YcHTUaf5NKmdNAvIdhTTNkqAJp1Af6IaDWI9FobBPUF
 Njk3oLyT0Fp2yYO9u5c8vJCJflji+tN80aKfzfji4DmlswZY24LLCGEZPGT4iYZf3tmQDFEWrx3
 oUlP4TI542w6ugg/sVVNIQYIoOiDMFVUYG8Kd+rIvnGPUO7QeymqpdlZuUxEOoUKE0bxqbMO8cL
 DBAPlAgaXeE7VnTfETnAydUT1mDG3gX6XnMdw/S8ZlXQYktnXe7EA6YAbCiWvWXSf1oYKMSQGsP
 njibNQrj0LlQ6K5MueAAYG3CBw6J2kuOvj3H8tiwNrzrgWEr3o5zZPEURlS6/E1FxBCRzuXJrs/
 KW+GW/yku6JFYTQAZp8s9dakmBu40FzYRP7sGZqkQWouYjnL4Co4JXDYGFRvpsm+eWIOSII0QoR
 bXDPgfnT3WepFuh7vVAOyfqiyC56uh7dEu/HJj2AQLGtm/yM+N3imsvsLLYl9pM/G+cJ9wgNLjI
 P3OZ3C1PcKP4L7WEFsIadZt2Q+5mwmqkALbhYVCa8FsxiFINy7veVkwtNLOg3+nstsnowdowV/c
 9/9fGQj6amm4f9oVpnkq9GqZ6EZtYjV8Saso76y9C2+r8Q==
X-Received: by 2002:a05:600c:698d:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4ac185bd1e2mr46027505e9.16.1793363315079; 
 Fri, 30 Oct 2026 05:28:35 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm40777045e9.3.2026.10.30.05.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:28:34 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 30 Oct 2026 13:27:41 +0100
Subject: [PATCH v3 2/6] dm: core: Add SPL_DM_EVENT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-2-2a67384ed0ef@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=msp@baylibre.com;
 h=from:subject:message-id; bh=gTi52M9CPLoeY4nOZxa3jW72vFJQ9Ms3bX+ef7Q1Md8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwnvREG2aeEg1cEvBD7ldp8Uezv5SM1G2WCM9c/ZPXp2
 78xZda+joksDGJcDJZiiiydiaFp/+V3HktetGwzzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVK88yMgw48aSOUe6v2zdk8K5iLd4ke7dyTf12H/l3/Ny7pz7PsJ+KSPD+/jQ2FU
 vfzT6WK3TF5LhEX3kFbpAcxlrwuuwtoj7qpx8AA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Add an option to allow DM_EVENT in SPL.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/core/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index ae0c34667723..22b72d6b766c 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -117,6 +117,16 @@ config DM_EVENT
 	  register a 'spy' function that is called when the event occurs. Such
 	  subsystems must select this option.
 
+config SPL_DM_EVENT
+	bool
+	depends on SPL_DM
+	select SPL_EVENT
+	help
+	  This enables support for generating events related to driver model
+	  operations in SPL, such as probing or removing a device. Subsystems
+	  can register a 'spy' function that is called when the event occurs.
+	  Such subsystems must select this option.
+
 config SPL_DM_DEVICE_REMOVE
 	bool "Support device removal in SPL"
 	depends on SPL_DM

-- 
2.56.0

