Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B66CD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B8F848B0;
	Thu, 11 Jun 2026 04:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="j5UgmSXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35FD84908; Wed, 10 Jun 2026 15:36:49 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EC7848D1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 673BC3F215
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781098606;
 bh=nVhPN4Jk/vTG7Vn0Gn1uWLIrJkeT+qWrJ9vntPuIGKQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=j5UgmSXEGf3wqlCAjhz6qXHH54YKABWkNf6gKoAM3NuzXOtHdKqVqlnG6jKQh82K6
 +Du9tCdz4FCxaLvf67dMi0rdrB3UmxqeNzzCbekpgcdbtgOkqHRsz4L18hG++E2Yhb
 vBbXT1RJFTBoDIFo8fVGNo+BUQ7VL7G+mai1BxaUx1eJkYipWI90PTuWY0FX45hZnm
 9+6Om+B/etHcdxDYsR5lzYmZOjE/fzn3CLIVjVABM903k6W13LQYrNTV0und2tlBvz
 aMDzf8TYqZBXudL74SuSJANfRvF+b3yiXh+vwBmwdZ01Of9cKFvt6kBvvuypM0Uzk8
 ssr01md/gxKAAVdvpFFLIuercCOxgzZn3+brkAYg9260GrdcqFVh46wc6wrE9RChkB
 CEn6D+WlqDQt1Snb9er9e4UJrE9GPeu9WvnXrWt3G9CnEE6qYBjFR/LUQnNC90zAqa
 HqmsD3hVkUf7w8E0wOxZezK5MJ7wnhTkbeb3WJ7y17LshlhE4GoyXwKojVfrOYrVH+
 5dqzu1jGvyLxEqAbwiIJ1yW8bGoopvD597D/0WzqikPaBDBcxc0kS3Bye3prMnpYS2
 nn1/uqtr0bskr0TD8ujdgN7kYSnFOXS3AXJRvJRBM4mOYTuCrpk2V5wxCfUde2+mke
 1+GXRN2NZiA6YnsoM1i67ylE=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0d0516ad7so68567585ad.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098604; x=1781703404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVhPN4Jk/vTG7Vn0Gn1uWLIrJkeT+qWrJ9vntPuIGKQ=;
 b=eI6Ka3r6aFaZy1HWynRHtkVs/aV2764Rcz+TeCDqIpq3Y36SQTj5d6yp24mymSlbjo
 NmmOrP4gNcLdJaizZxl4NmcB5/7+OmNgoT3mpqFw30WzB3aAPMfhDNT9EfjiBZABSlZo
 fnb7/2MLR/t1tKvtbU0t3++bJMRDRtiMy9KQ8vqavMgvi1aL02kb6lwVkWe2OT0CINKd
 qs7z1bZArCQyN/suEze/Sxf9hO3r5V/PxxuadoiVQLKBosRbf0VNeFhOzhnq/DtVCpNw
 Cv/5iUm2jB4td0VCR+04PJegWHFOdnHWLkFf3jqWEskvaLfB8FLuyr49ajpPLE3R4OV/
 I5vw==
X-Gm-Message-State: AOJu0Yw5+huc26r3kKml6gdU8CU8HbYpIKPZLk7ONMMV4V40yXsNoj5v
 TMYi12oJwvKudAlI/PeEw6MUbeox8WyYPTYBg/OPd0MPhoNvL2aG2Si3Ffe+QVcBF7v0Fjk41QH
 P8DsxAidvtZuOY3pZtDVcIgZUfXSYe2dbLTepJO3DAJ4GWIf5O4mFOeQPcf+hBkuNKy0K7VA6Wu
 3vroA=
X-Gm-Gg: Acq92OHCcY8ibIsL1VJ3nCd0G4dG8zMtOx3NcZ3EmEVhwI6quO8+23Qo9lCXglzvWa/
 SWDjKmC/YwcmhadkO9BYYcWr78lqC/pXtfY2losm/7VuxT/FiQ96IkrL3Jv8WdrlIh5bo2FJNa6
 EW83q+FXToKwtb+srcZfj+AFy2j/SKZyFXNe6+hI3AdqZWsoQj6ORU4/ASd6hyE7skNnawQYFpb
 halIlShO0f7+9iR+N9UuhiEkaEgMvm9qLFeS49F3fyPyQ/q8T/oQn801nim8T+1nffL54qOG4RN
 819xwrfPblAVaVz88VGtLJYrizquBww6dkRSNzssvd/dyOtHSeJEmmFRQ/GlzJav/ee1+ByiVk1
 l2YDsJaM+xIcq/uUPqz6TePZhXC/Omjz7NqtsbhEayOov3ICRtlAp+ajooMYjzMjVWCI4c4QHIw
 O1XwAJWHQRVdVijbLT6mOLj3Z+5Q==
X-Received: by 2002:a17:902:e892:b0:2bd:ba44:6c07 with SMTP id
 d9443c01a7336-2c1e7b3273cmr284806865ad.16.1781098604297; 
 Wed, 10 Jun 2026 06:36:44 -0700 (PDT)
X-Received: by 2002:a17:902:e892:b0:2bd:ba44:6c07 with SMTP id
 d9443c01a7336-2c1e7b3273cmr284806395ad.16.1781098603778; 
 Wed, 10 Jun 2026 06:36:43 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629d042sm257367375ad.60.2026.06.10.06.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:36:43 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/3] Move NXP i.MX board environments to .env files
Date: Wed, 10 Jun 2026 13:24:21 +0000
Message-ID: <20260610133336.15999-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

This series converts several NXP i.MX boards from the ad-hoc
CFG_EXTRA_ENV_SETTINGS macro in their config headers to the text based
environment file mechanism described in doc/usage/environment.rst. Each
board now keeps its default environment in a readable .env file instead
of a backslash continued C string in include/configs.

The conversions are meant to be functionally transparent. For every
board the generated default environment is byte for byte identical
before and after the change. This was verified by comparing the output
of scripts/get_default_envs.sh on each affected defconfig.

mx7ulp_evk and mx6ullevk are single board conversions. mx6sabresd and
mx6sabreauto share mx6sabre_common.h, so their common environment is
placed in a shared fragment at include/env/nxp/mx6sabre_common.env that
both board .env files include, with only the console setting kept per
board. The eMMC firmware update variables stay guarded by
CONFIG_SUPPORT_EMMC_BOOT inside the fragment.

The series has been boot tested on i.MX7ULP EVK, i.MX6ULL 14x14 EVK and
i.MX6Q SABRE-SD. mx6sabreauto has no hardware available here and was
verified only through the default environment comparison described
above.

Note: checkpatch reports "fdt or initrd relocation disabled" for
initrd_high=0xffffffff. This is pre-existing in each board's current
environment and is kept unchanged to keep the conversion behaviour
neutral; it is not introduced by this series.

Aristo Chen (3):
  mx7ulp_evk: Move environment variables to .env file
  mx6ullevk: Move environment variables to .env file
  mx6sabre: Move environment variables to .env files

 board/nxp/mx6sabreauto/mx6sabreauto.env |   5 +
 board/nxp/mx6sabresd/mx6sabresd.env     |   5 +
 board/nxp/mx6ullevk/mx6ullevk.env       |  69 ++++++++++++++
 board/nxp/mx7ulp_evk/mx7ulp_evk.env     |  59 ++++++++++++
 include/configs/mx6sabre_common.h       | 122 ------------------------
 include/configs/mx6sabreauto.h          |   1 -
 include/configs/mx6sabresd.h            |   1 -
 include/configs/mx6ullevk.h             |  73 --------------
 include/configs/mx7ulp_evk.h            |  63 ------------
 include/env/nxp/mx6sabre_common.env     | 114 ++++++++++++++++++++++
 10 files changed, 252 insertions(+), 260 deletions(-)
 create mode 100644 board/nxp/mx6sabreauto/mx6sabreauto.env
 create mode 100644 board/nxp/mx6sabresd/mx6sabresd.env
 create mode 100644 board/nxp/mx6ullevk/mx6ullevk.env
 create mode 100644 board/nxp/mx7ulp_evk/mx7ulp_evk.env
 create mode 100644 include/env/nxp/mx6sabre_common.env

-- 
2.43.0

