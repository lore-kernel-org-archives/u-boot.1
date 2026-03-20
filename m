Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89EA1099B4C
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 23:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7CE83D71;
	Sat, 21 Mar 2026 00:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EKKZIanH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3BB83FE1; Fri, 20 Mar 2026 16:45:52 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE1283D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 16:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+casey.connolly.linaro.org@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6681360126;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11DC5C4CEF7;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774021549;
 bh=FRk0ouKnTihbQvqV+MBTZ5o9/3BCFR9eGQSLL+tJRUs=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=EKKZIanHBCLi01OOWCtoKZAQbDCTmhNSIWEuyHKKuACFqZap7hhOLcQNR1ATlxRet
 X2kGarbjqfqoNxcyh4f6gL7ZW1dU2YnEzZSKPm2R6AEBCVIr1TKdcvv3SgRHnGrJsC
 pchZuRRkUyYeOkWK4rw66Sf/09DnTn4ZJ1yYV6JDSFoLL3I4v+ISpvoPZCz5rc7ZQv
 VnO+q24NiUPuCgWEXZQKoPxuRZTUB9bykm0q/DI4SzIWncWowCFnx7cXuWTQMoE02t
 LoVV6LqWLNDfsS8uq2gJ6slyLsrCIX5Eyl4X9a+GwGaey7VjQVParkrt6BKroFzFV6
 yiybzTs3UIW2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9A109879F;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
From: Casey Connolly via B4 Relay
 <devnull+casey.connolly.linaro.org@kernel.org>
Subject: [PATCH 0/2] qcom: gracefully handle some errors better
Date: Fri, 20 Mar 2026 16:45:39 +0100
Message-Id: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNrvWkC/yXMywqDQAyF4VeRrA3MBSz1VaSLmRg1pd4mtrSI7
 96xXf4czreDchJWqIsdEr9EZZ5y2LIAGsLUM0qbG5xxlfHOIAXlD640j5iWccDzHx7YyZsV21h
 ZF+hytT5CJpbEvyELze3f+ox3pu004Ti+B3wreIAAAAA=
X-Change-ID: 20260320-casey-qcom-rpmh-serial-fixes-db612ac7913b
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=FRk0ouKnTihbQvqV+MBTZ5o9/3BCFR9eGQSLL+tJRUs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy92avjLbJ7H3519l1w+M2xWOt1XPMuOEj3vK2r0jxSs
 vzQJ6tPHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAidyYz/He+ITm9JXTnjq2p
 05f3h+39svts3SWTzRf6//n6rhUL0t7KyLAnL6D6zUG5KOPKaWoCbDPW/9rT3JNSEJS6mvPa9J7
 zK98CAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Endpoint-Received: by B4 Relay for casey.connolly@linaro.org/default with
 auth_id=688
X-Original-From: Casey Connolly <casey.connolly@linaro.org>
X-Mailman-Approved-At: Sat, 21 Mar 2026 00:54:11 +0100
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
Reply-To: casey.connolly@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Adjust the serial driver to not bail out if we can't find the clock,
this could happen pre-relocation if the clock driver isn't bound or if
there is no clock driver yet. In most cases this isn't an issue since
the clocks are left enabled by the previous bootloader stage.

Additionally adjust the rpmh driver to gracefully bail out for
non-active write requests, sleep/wake votes are meaningless in U-Boot
since we will always be in the active state. It's possible that the
caller may send an active rpmh write after the sleep request but might
not if we return an error, so let's play it safe.

---
Casey Connolly (2):
      serial: msm-geni: allow invalid clock
      qcom: rpmh: don't error for SLEEP requests

 drivers/serial/serial_msm_geni.c | 15 +++++----------
 drivers/soc/qcom/rpmh-rsc.c      |  8 ++++----
 drivers/soc/qcom/rpmh.c          |  4 ++--
 3 files changed, 11 insertions(+), 16 deletions(-)
---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da

// Casey (she/they)


