Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A6ECDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 04:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBC386C3E;
	Mon, 16 Oct 2023 06:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uf5G7QMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FDD86ED1; Mon, 16 Oct 2023 06:25:41 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8EB85423
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 06:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so1628342a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697430300; x=1698035100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krCW1EDHArtGI48lreyiAHizzZlT4boUPNv3WI7tL2A=;
 b=uf5G7QMPN5FTMJyQbgl74zM7kvN6A1s/P+MjhZjJFfm8UQn3NrahkrBlqZ770oxVaZ
 6jDam3VCflNPO82WdcAZ5ABRRwtyxvIVyt3oFirYv10clA92VCz9i3xQxtJ6CUDrdiQI
 aSkJAnT7syKKVHgjjw824W/aFcOI/mxxk21XQtLId+3R01VWVTTA6h33DUe9EhnInu5A
 3p5VZNZG6BBWsl2nXTG6aOZq6qBOw1AIcj4sFLrmMvyVqyM/QFJ+ycYKDXG4qAHXB31C
 PnKgukCFTfr7k1lMh2TbMn3Ee6BxkOygfkpvQsWCZCkPxT4j67kAUWDNHBuN1arEQboY
 Ur0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697430300; x=1698035100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krCW1EDHArtGI48lreyiAHizzZlT4boUPNv3WI7tL2A=;
 b=b57QxFC5xhkLeUjqAoSIP9TiTnoMT498bKV02Rgyqto7n4wL2edPV42dRDQ/FBhlhR
 MfkDPY11/rwx7eSIoTV2qYGvhR0rPsKLXKV6m6Kn14dnkkdeWesbukNEMmlt3SbxJkvy
 0jGmVs1Ypn8nREXfwxKX5+xOEtHaUlURSImCedgiZ96ee1cjtkzlKI1bkeWcWlQVgi2m
 zCXApO5Kcuiw4XVBm3EAGNDro3+1XyqmA76LENc9CxmJoB3sZ0EeQqgNMa2TaLCfPteN
 nJNA6lsBnPmhAuZU6v6vLk/eT1tdO/sKTkGPxU0lPf/JIUrJJYdPS+912AbRQvbC7tVG
 WbyA==
X-Gm-Message-State: AOJu0YzSB/qo4LMPrxyYN2Tbkp9BoloT8c+OdLJXERgB1GIeQym8BUNA
 OKgbss0Q3hs9bd87wniQh3RFwY3S0oJ5wU8JxMQ=
X-Google-Smtp-Source: AGHT+IF8w7qrEFke+MtiOA7SQjcCxNRpm/NjQaWVEu3GNaNqcBqq9r/8Du3njm4Ns8YAQ8KUSEofbA==
X-Received: by 2002:a17:90a:6887:b0:27c:fdc6:c52 with SMTP id
 a7-20020a17090a688700b0027cfdc60c52mr11495439pjd.30.1697430300367; 
 Sun, 15 Oct 2023 21:25:00 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 pq5-20020a17090b3d8500b0027d0ebf7466sm3747020pjb.21.2023.10.15.21.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 21:24:59 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v6 9/9] doc: uefi: add HTTP Boot support
Date: Mon, 16 Oct 2023 13:23:08 +0900
Message-Id: <20231016042309.2386387-10-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
References: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
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

This adds the description about HTTP Boot.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index f8510d31d7..d7332c300d 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -625,6 +625,36 @@ UEFI variables. Booting according to these variables is possible via::
 As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
 command 'efidebug' can be used to set the variables.
 
+UEFI HTTP Boot
+~~~~~~~~~~~~~~
+
+HTTP Boot provides the capability for system deployment and configuration
+over the network. HTTP Boot can be activated by specifying::
+
+    CONFIG_CMD_DNS
+    CONFIG_CMD_WGET
+    CONFIG_BLKMAP
+
+Set up the load option specifying the target URI::
+
+    efidebug boot add -u 1 netinst http://foo/bar
+
+When this load option is selected as boot selection, resolve the
+host ip address by dns, then download the file with wget.
+If the downloaded file extension is .iso or .img file, efibootmgr tries to
+mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
+If the downloaded file is PE-COFF image, load the downloaded file and
+start it.
+
+The current implementation tries to resolve the IP address as a host name.
+If the uri is like "http://192.168.1.1/foobar",
+the dns process tries to resolve the host "192.168.1.1" and it will
+end up with "host not found".
+
+We need to preset the "httpserverip" environment variable to proceed the wget::
+
+    setenv httpserverip 192.168.1.1
+
 Executing the built in hello world application
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

