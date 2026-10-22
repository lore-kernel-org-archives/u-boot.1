Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EB606A320
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ola90DLk;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UbiaHpiY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58AF26070C;
	Thu, 22 Oct 2026 16:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dlegB9zuJm80; Thu, 22 Oct 2026 16:20:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 504E36069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686028;
	b=TXKT7WZraiG/9tKqilCfalR213fFOrIXSrIOGaFhmyZXzGoGFQFneQyP6EqQY0/lhb+g
	 BPKC5X6lK6n5x663kCEd9tekP9IK1uQAfLn5+SInXtOMyVdvnHtHFlunpSeBtQH5ZtBN9
	 GmZfl+vQiTTW3TBW+OZeqVeiHl/AMa2FRT9MXHRc6I7gOZaNodvlFeD9xKR1ACesdX5gB
	 eNDq+83ZGO33Wl08fNbDEtbbtDqPLWEME2KQ33CyztD8GTsHZuyAeZRuI8+girTljlzqm
	 ayIWZRh0SBhdMlEg4EyoR6p3P3veefqfLFbh6LFPa8Tj/3b5Cq0jkSXnpox6gdoUdJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=U1dB/2AOoc18GJhnsPWbI0FEzn5UmGEU8QEF6XJQIa0=;
	b=NThqgluqKlYdhxCwimYsm/jY7IY4FFxbE0EdCQDzSTHVIpuC2sv69YJKjYvZ3825IU5t
	 1pm4D7PfXa+Z7/sGhhRMQenampiOYT4YA3iHUsvtJpUpXcxzy3bhPBIdq32MNp1mwA1HV
	 lsaMRRcvyg0sXKNse4+AMhqVoetYSFTuB2xSjZ3III+yLUyPvZNQy4EekRb+V74beO9AD
	 ekgT7dYEAxTTJIkMdslt/JTSdiHrqQKp+AdHWYyO1LJWxkTetOTqui/e8qfSsHsZgrtl7
	 eJDJRo9wVUGqvf63y6vOomP4sZNxSJdvsghM7DG8Ofj6QeYUqHL7E4H3wIMCHMkn/yw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UbiaHpiY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686028;
	bh=U1dB/2AOoc18GJhnsPWbI0FEzn5UmGEU8QEF6XJQIa0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ola90DLkY54JE8CCTPc0pEjjtTqq/K5VkWl8bJ9Wx/7Ck/rFJuglXi3U2UPh1Yf0c
	 v+8Z/QdNEOHDGWgfG7WgSycX/vzKHs30IPJES6rswUDpxPNAyKUY6Bes/SqIedT3P4
	 RftmnBEfIKxl8cQ9kOFjry+v5DTdbJTA993wKH2ZpBGzRP0+3yPqP4LO4hCTfewpuS
	 ormJlg2b6fJA8DHZevr0YxFvqJvLM37ggMARb06K8nPe6Q9k7VkPqZBdGasrky16A+
	 n4T/f+6ja20gpGDZJWWMQyCHQo7xqlbVsWj2vGSvGfm5oQFE0MeJ/nk4KjC1n8YBul
	 bYyeXz4ioBcOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 504E36069A;
	Thu, 22 Oct 2026 16:20:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C7F5356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 415886068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJRCddq6u7Np for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:20:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86BF260686
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792686025;
 b=pcIRwYWDgYgoc55J9rWSNgIvLD5Xx/FdcNA1ft4bv31xX+xTuOjucT3TpyY3u5O0Digd
 6UQaaS7fWdFo7tYy8/wo2mbMxUO80spQXTESdTeT4b/qF8cni89x7exvW/tyosjAfvy4c
 HjqAYdMkVPNkr01NGQYWXAcbe/f8XfymGEjboOvT8JkDpww9KexG80RfSr+veE8N8/tK9
 yWfFBeMfr8UIQ6LjFhqQGJ18pmZXYB4b6yqmBALLY6juGnqFTuczG35MGyjP7cLMpfZQ9
 Ihjw+yOPd5nARUGgyGVUoC4xHbiR+1JQauyKUeKK73bODMsScOvaCPfmYecvFI/03RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792686025;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=U1dB/2AOoc18GJhnsPWbI0FEzn5UmGEU8QEF6XJQIa0=;
 b=TT9ywu8+pqjobuXOqUvW0ZOZIOFsqEoPtcjEP6KRZa6bKkVe0u4tHrEqibEilrRNr0QZ
 +pV4ykeKDc+Yy1bKyPj7Az/XwW0Nr4Ub5qvRBWYf5+eyLr3RtfndOdO0lHCoFl9aQG1E1
 j4azhUzSmzDce+hbQHzNPEEt3bmzpoFLVmE7UdVVEufc91lBTagpgtPbZXiHZYBjuHk31
 Ty9AWlYsh4IQ5d13jzGwkB3J7J1JNBSFYFWQaustykPhClVu7xPneXlPkdlosqsCTz7Ci
 QShU5J6w1/x6GdIfFI+tG8iI1TVEZMz3P6OmWFjGPhO/nIfIi5jKxeYojIfGePhLm8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UbiaHpiY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UbiaHpiY
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86BF260686
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:23 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so7633545e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792686022; x=1793290822;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U1dB/2AOoc18GJhnsPWbI0FEzn5UmGEU8QEF6XJQIa0=;
 b=UbiaHpiY14qMresU4HzvmbRsG9ilL/S5jP6NqniUSMIL65+AInVMMDmmyUzDaS2NuA
 dny/CieRAvj5bHgi3nJEZQT0trQjDWYLIPt24cgs0mqo4uSDsadm9d28T7ZsN4bKD6tY
 KuvopEea020WqywaG25yxMPgejzlT0Zw6eynLy1Q6sL8Jjsbl3zkoOi7ykSkepzGotzS
 5RalDR44bpprJ/hGGGLbrMdb8Sx8PM31DNONTYBB1sW3jijGL+JOq12ZhdSEag8+m6/c
 mbuatBAvharPzMuqiag0IyiGp/uIplyGzIKQ3QHLDXB1hsX0s73IhbOB8nFb8Nd4CU92
 JOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686022; x=1793290822;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U1dB/2AOoc18GJhnsPWbI0FEzn5UmGEU8QEF6XJQIa0=;
 b=MJdHPyMTUiwvE3ia4lsJhtbnoE5X+oQPLaZt6m2mqEvjQ+Gr+JiZUIHurKkJU8Jm7n
 YkEHTy1BAwYCm2d7yL0w5kprfx9EHDPcbtsd9ET/ZIxQcRY6CDZ2v+FVD0ZSsBay1dm2
 lbMthtmmx4mfMPry7q1MMz7ZF3csxylwlZmL1czIS1QEyYd2UqapnKjOGLzCfuHv0SFe
 BqYwf9XmgQpLPEzBF4KhJGeqZqHSoxwSiZVCMrsbQBAc8sJnmrF8lqCVUu91wcAXscXX
 j/hhFEZjqjjlxXRiMwFA+RK9fYnZ6iZrWjfaRiFSt1xX8RnsPPwq5I39gSVh3QkJ0bcT
 6rfQ==
X-Gm-Message-State: AFq9FYI5/iSq83nwz21MFtFEXGd6Tc9mZ3QMz4mPMWMlV0eMMdfSj/O0
 axRq0LkWesYyYc77Qlsmmz+6dIkqmPI9H6lVHobS8OjV4BxdfuC5yz2A0DLdCA2cf9o=
X-Gm-Gg: AYBFou3t83JRaGLEEQKYA0F7pvGkPaxIWJldLgGQ5kCheSumqbdZh9AtU7UfKFSa2bm
 0KAJGGhT0S0iJBr0M9Uj0UHGuL/254g1l8vo6D9mJdEymcFx+RExb8Mq3STBjTDfS+LeAivr50T
 919tB5SqTyQx4AsvHr3HD00C4v7MB56ElTcJJbtrJG0Mu+KgbJ0d7Yxf+P08+cNZRu1zfVUCGie
 Qqvc0gYAd6H7FVGHiLcofVp5Fcr2jeLJ/fCDYxnueHTzeU0DDnU3vciqVW18GF4QCFPBpQor7pG
 h1VhmhP6igrqQ2WRxQuXbIOSiMf99jlym7IpbAFWgIX96sP1Ogka1QCdXZHQb1q6Zl2aZlTXNwQ
 T2YsxMAbu/vlwk/jNHgKxDuOim/pIU/XNj0CBQfWikKTCEbYLyjqPKAyCrF/DY+yqPEyFCPEtr1
 T1h+WQn8bGf1z9ZSMoCdNvZXQmBbqljHzqRNBgJVPDeP64ULSI19h3mS7RXhyksYmwXEV+xeXxS
 OSlaXkYywACf928NXLePICpFtzisv9Cokt0w4d9NK0XmDIMN0v0c67vu0+c6vkmUir3PK9Ra8sV
 NQ9Krn415EO7lwCytrxOq/JYzS5n6w==
X-Received: by 2002:a05:600c:1c17:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4a1fd8a49e2mr118478655e9.4.1792686021580; 
 Thu, 22 Oct 2026 09:20:21 -0700 (PDT)
Received: from [127.0.0.1] (mob-83-225-32-96.net.vodafone.it. [83.225.32.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21029928fsm6905905e9.3.2026.10.22.09.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:20:21 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/5] Prepare devicetrees from FIT configurations with
 fdt fit
Date: Thu, 22 Oct 2026 18:20:10 +0200
Message-Id: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6drQU06Ar72FYtGUKY7SQthAI4
 e62eAGXb+b/l7+xgJ4wsHuxMY8zBRpcAnEqmOmV6xCoTcwEF7LkpQRjVIogTGOIHtUHbBvBUgR
 xs3XVcqukMizVR4+WlkP9bH4cJv1CE7MvJ7QKCNorZ/p8Gjx15C4Ol5i/PYU4+PVYNpfZ8seIu
 QQOVopaoq1FJa8PrdY3aY9nM3xYs+/7F1H9jWzzAAAA
X-Change-ID: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Some boards keep a base devicetree and its overlays in a FIT, while the
kernel or EFI application comes from another source. Boot scripts need
a way to verify and assemble that tree without booting an OS from the FIT.

This series adds:

    fdt fit <addr>[#<conf>] <dest> [<len>]

The script loads the FIT into memory with an existing command. fdt fit
then prepares the devicetree described by one configuration, verifies it,
applies its overlays and copies the completed result to the chosen
destination. The script can pass that address to bootefi, booti or
another boot command, and must stop the boot if preparation fails.

The command reuses the FIT loader, always checks image hashes and
enforces any required configuration signatures, even with verify=no.
It rejects chained configurations: signing each configuration separately
does not authenticate their combination. FIT image load addresses are
ignored, so preparation does not write to them before checks complete.

The first three patches provide the loader support, including rejecting
missing or invalid overlays. The last two add the command, documentation
and sandbox tests.

This is a new, simpler approach to the firmware-owned devicetree work
previously submitted in the EBBR series [1]. Storage, configuration
selection and boot policy stay in the script. There is no new DT binding,
storage driver or automatic hook into the EFI boot paths.

[1] https://lore.kernel.org/all/20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com/

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Clarify that load_op controls only the base devicetree and document the
  overlay policy and enum values.
- Collect Simon Glass's Reviewed-by tags for patches 1, 2, 4 and 5.
- Link to v1: https://patch.msgid.link/20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com

---
Carlo Caione (5):
      boot: fit: tell callers when a devicetree buffer must be freed
      boot: fit: reject configurations with missing or invalid overlays
      boot: fit: let callers choose where to place the devicetree
      cmd: fdt: add 'fdt fit' to prepare a devicetree for other boot commands
      test: py: cover fdt fit preparation and failure handling

 boot/image-fdt.c              |   4 +-
 boot/image-fit.c              |  84 +++++++---
 cmd/Kconfig                   |   9 +
 cmd/fdt.c                     |  83 ++++++++++
 configs/sandbox_defconfig     |   1 +
 doc/usage/cmd/fdt.rst         |  75 +++++++++
 include/image.h               |  11 +-
 test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 616 insertions(+), 22 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

