Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E620FC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D6284189;
	Fri, 11 Apr 2025 17:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zFoaTodv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D9F84189; Fri, 11 Apr 2025 17:30:58 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B782182B66
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1127045f8f.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385455; x=1744990255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hWehS5BtWDwZMIJ9+SND/YtDq3CGWkGLxZZMpOcVAi0=;
 b=zFoaTodvAD+OFZPRsCVnB1GccC61MORsJfjW34f7L+2aNSvcrOuWO4pQT+5dwU8pmq
 L9YhbPkydSju3rqCHWIG/ARxAXi9dBiCcRlXF996HWo3eLBMKuhxmpfH+L6MCCjCKLzJ
 CPLVHjsKtW/6i5l/n0j5TNub2bO/s6F+EvcVYfHgPL80g3So99WAUih3xY+Qy+KfSfX8
 qaO6Q7/qnWnUstchGkviLpY4wqDuKVJI20FSvMMq+3sJNHYDV4h9NfaIiMiPalYOonE9
 ew0HFKhv3jB14bA7yqmZ1Q68NPUJMKAH3uhHdq5nHFA5azIv3b1aYq/mlPMZ89jyT2yn
 XcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385455; x=1744990255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hWehS5BtWDwZMIJ9+SND/YtDq3CGWkGLxZZMpOcVAi0=;
 b=rAQXm/gM+NuLzREmBeFPRctj6NYDct+jkgmYmwr7c9UAnWmC3FHRMTRzmVgIX+153D
 NZJ6HnfDCoWSmWGI6jhDPHGzRjTYUVqmHd781PmeMd3ly3eSCiHWmh7tCXMTMaaxHL3G
 k2ldcQyFiBAu153LDucHUD4Hl4i/ztW6QoFYHD7O2uRMjdZp3yweTsb/aTc9TOmW7zdm
 ecTsPCh0t3E6IbhEUwB55+D5eOF2dAFYGr/XjJFmDUjbNYt0pkdcJIj4nX0tOSHR2X7n
 d7DTSESdNnO68i+NapjrgBf3/4WfamVkC8xwNgOwJZSJYU0GOmzGoCN8Dhe8asRE1pjE
 PhtA==
X-Gm-Message-State: AOJu0Yz7uOmk7Dl6NdInxeHhMDnaTxZRR98njsB/JYX0mSXRgYFhTrVh
 dAussmf2fDZUYtktuZPodA5h0z2QdTiNFp2jN6jbVvUR4rQNz6AW4aw4wCCs3bJwPhGkRaEo+Wo
 vO9w=
X-Gm-Gg: ASbGncvfl0A75rArm8+lVumKqBm7lscIkZC64kzuZEe8FDTEur1eU8bTY2y4xzePGUJ
 1422NJMmzkWFgoaY4O+sD0fatgibOThqLmEYFRSy/Nhn3rptEXLSbhBYArlQW/SQXm2rPUkpFGa
 ayTLMW+7oZlgNpsVXfj/OvPhAm6yYwh72ciIC4CYweVMHFZUvVIroeJpr8qvieVJraFdNLcZT18
 M0SupFpxsUeh7cs5ZNxan18aRY+FJaE0jVa7cQqBywPXUCQqZY3vFY0X+ogQ3lkJ7EaSa+aRvAo
 AZkdEIvQE0tuYgff9TxQg0Al22U0lq/KCxc1WZOlmNExY1q1jw==
X-Google-Smtp-Source: AGHT+IH8cqsOOyUlo7cLrz/mQuAAIPi+Ox62pXY2h+TazRU/o7naxDXq8xrCYc7vYsJwC52GHx8v2Q==
X-Received: by 2002:a5d:584f:0:b0:39c:1257:c7a1 with SMTP id
 ffacd0b85a97d-39eaaecaeb2mr2365767f8f.57.1744385454946; 
 Fri, 11 Apr 2025 08:30:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:30:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Jonas Karlman <jonas@kwiboo.se>,
 Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH v1 0/7] Bootstage reports for CI
Date: Fri, 11 Apr 2025 17:29:26 +0200
Message-ID: <20250411153040.1772000-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

The BOOTSTAGE Kconfig symbol allows to record boot time information
which can be consumed in several ways:

1) Printed to the console just before the OS is booted (when
   BOOTSTAGE_REPORT=y)
2) Printed to the console by the "bootstage report" command (when
   CMD_BOOTSTAGE=y)
3) Passed to the OS in the Device Tree (when BOOTSTAGE_FDT=y)
4) Written to some memory location in binary format before the OS is
   booted (when BOOTSTAGE_STASH=y)

None of these options are convenient for use in CI. Suppose we want to
monitor a set of boards for boot time regressions -- in other words,
make sure the boot time does not degrade unexpectedly as the code
evolves. For that, we'd like to be able to record the bootstage data in
some kind of database or persistent storage and possibly draw graphs
showing trends over time.

This RFC is a step in that direction. It introduces two new output
formats for the bootstage data. The two are independant, they are simply
two options I considered:

1) JSON
2) InfluxDB v2 line protocol [1]

Both depend on BOOTSTAGE_REPORT and are enabled by BOOTSTAGE_REPORT_JSON
and BOOTSTAGE_REPORT_INFLUXDB respectively. Each format comes with its
own test in test/py/tests. The InfluxDB test is special in that it is
able to upload the data to a cloud database, provided the environment
variables BOOTSTAGE_INFLUXDB_URI and BOOTSTAGE_INFLUXDB_TOKEN are set
properly.

I have been able to run a boot test on rpi4 in the sjg-lab with
BOOTSTGE_REPORT_INFLUXDB enabled. The CI log [2] shows that the data
were indeed uploaded to my InfluxDB Cloud test account.

This is published as an RFC since it is just an investigation. If
someone finds this useful I may folloow-up with a non-RFC series.

Comments are welcome.

[1] https://docs.influxdata.com/influxdb/v2/reference/syntax/line-protocol/
[2] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1097039#L116


Jerome Forissier (7):
  efi_loader: make efi_exit_boot_services() call bootstage_report()
  bootstage: add support for reporting in JSON format
  test/py/tests/test_bootstage.py: add test for JSON report
  bootstage: add support for reporting in InfluxDB v2 line format
  test/py/tests/test_bootstage.py: add test for InfluxDB report
  sandbox64_defconfig: enable bootstage report in JSON and InfluxDB
    formats
  test/py/tests/test_bootstage.py: upload bootstage data to InfluxDB
    cloud

 boot/Kconfig                    |  17 ++
 common/bootstage.c              | 289 +++++++++++++++++++++++++++++++-
 configs/sandbox64_defconfig     |   2 +
 lib/efi_loader/efi_boottime.c   |   7 +
 test/py/requirements.txt        |   1 +
 test/py/tests/test_bootstage.py |  57 +++++++
 6 files changed, 372 insertions(+), 1 deletion(-)

-- 
2.43.0

