Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDE7C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8BE440868;
	Thu, 10 Sep 2026 06:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BtZKZ4fJr4X; Thu, 10 Sep 2026 06:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5620240862
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789023453;
	b=FYdCWrgxsy/3UF2BW8PD2cMtic4CKQUpW+J6AbWnffdRHZm67fTUi1SoqyJDpGjrwB2y
	 H+1bjwPRHN2rneqKeSsW9mE2s2wbeDa3kHpaI1NCFMxkOa5UywxDgO3xokY0yCMXik/BE
	 5f+ic+pXcE1aspoxmMywZXlCfE/nlj0ztFZZeSb6naiNebySy+9/j3YbDatD940fyqhP9
	 ZKN/0W9TAlhBljRqwnYKkT+S745TwOnoiIsAaKqTwO6ujOGlQH7Qxwo8aJJ9Fno/WkR+b
	 lHzcPZzwlGNI6uYzKK7cGIueZ4H62BweQ6qGzrCUjfFKlbyReipLa9uaJ7cX3TGdNRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789023453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Flowmailer-Platform:
	 Feedback-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kQHujhCeP7mVSTnt8qtyQ59gYPscQH52gwboOPVI8DY=;
	b=qb0CH6sWT7axli6c50jKFDmLXCLRFHsDVhiDwXppyD+sxFAt/5JD5pHTMAsyltDYUiiS
	 RiWzIisl0JemTH1O1hAzilpWVqgS91vXqlTONEhLW7OMcmvpgH7LV0MGJrcmGXkqiu1U+
	 y0zqGZMxfj2fxZ60ZRYsxJbi/9ngiJ/3ApjYUZOYIdY+qpm9yDd2k3LlQ8mRzBXG4luZG
	 aHwriHA0vREHuAvQhrtxArA9SJu9xoZZ6cdKUNFmEDlgjwQyOI4yc5FoCbkERrcNbS1BA
	 oxwlfy1u9dScRFYhZjXlN+qGByEpfMpGaF4GV79tnrvDot9qFqqSpAwLb2Z8Rvlnn1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789023453;
	bh=kQHujhCeP7mVSTnt8qtyQ59gYPscQH52gwboOPVI8DY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mxe9tDpSlPsy6mewW3syNWtaV7pfz/qyQZg7FkQsCCNcmh5bP4tkzX6k4ocmwapzx
	 iBzq5mf1y/lbmUmt3JOPda1XK6xotGdMaBwNLfd99ms0GvoCaphTAPxaowc62UfnjN
	 7rZe2ypIkkTcB1DYUuwf74s852nq/PrKBa3GIpZNFMFmpYVf7/kAGVytbJJVrXi8I8
	 eNV2Otpfy5rzlCX/9MklZb5Nr0jWYmlO1O3rA4gXTbny2gBZIAjIkjs7vNhVKfXOs2
	 4FMRbVjvIGn/FmqLfy92xMHjPP7VPnQ9lFG47YEj9Wzjwut/b6LVmRbhTFvmnJRKQU
	 8QSM0II4tAy7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5620240862;
	Thu, 10 Sep 2026 06:57:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 068B0362
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC51080F15
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4sClpxKU4jmu for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:57:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3810080F03
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789023449;
 b=Mx0u6JfUSAgf1Z5fCAhSOF6vm+Xg9ZzvCOlRyD6a41pwdwZqHtBWNVHfxqPBY/Iw6YiC
 RrRvpLOQYOkTG43l9hoxsB/m8O+z+wzciEhwBtH8wTgFNe0qxC3F+o1ydv09w7kBGHOFb
 BtGwEVPjErGLytF+rGv7OfBinKG9V/5LLy7dl+uA5uAmweR8xE9NLOFFRBgLhxDbJvGG+
 2GUtavtWmBqDvAPlxhUbF17liTN3zCRhmEGJOp97E8ccYQ7bq+NPg51RAYqSQg8cWHm8p
 YKn7RB6W//VWPO2j8q95Ww+iSvs3HtlGlSvUVcIvj2fiyDKK6JNkwG2TkUkX3yBr9Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789023449;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID;
 bh=kQHujhCeP7mVSTnt8qtyQ59gYPscQH52gwboOPVI8DY=;
 b=nvD6KLY7mue1w887xW8tzwvTn6x5aKnZVxu1HXrgZJizEaE0ottMWogtMj1C+xuLRg/P
 8nCAVEV0Wgpn2BwGD2wchvEHagoyM7MarrkweWqOyCMa98rvzl7jsRBPcqNfgkVz5eJjl
 Xy4UyFPecLn0DXW7RawgrRLq3LdYFAU72xifJ8qqLDSndIe8T+Y17rq20ZvXiEfpPhgkh
 H3MfHdPCzoN6UntjsKMPF3UVC2M8VqcPVFqqUu50waDCvhlF6LUp2jLmJse9vlyUO235w
 TPSiBqfa83G7IPW5XZvkmpGmZJ36/GFbh7AHMXJtvui85+7nE3qsPZAw3M4spt+0vnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=KCHPqZiH; 
 arc=none smtp.remote-ip=185.136.65.226
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 06:57:29 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=KCHPqZiH
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-294854-2026091006562232b6d3d54e000207fd-rjoxcf@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3810080F03
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:28 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 2026091006562232b6d3d54e000207fd
 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:56:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=kQHujhCeP7mVSTnt8qtyQ59gYPscQH52gwboOPVI8DY=;
 b=KCHPqZiHbH+wZ5QOa+TEJ4ea5xXY2AqW5HBcnXGMEffwPHk6M8pscJ/Lzz0OikC8IWi5yi
 taWmWcIQxPzJuWBYTjGsiMq80D4cEfARfzX0ro3QHhozDVRVDZ8w/pzYxmlW/WgrHUJrcr+s
 QxJrNBTDvXgN4m2jFFxp99AlXKHjLSkNN1wzot+QA1ZL4TCYKDMzQU3/Fx1VXQ7GYldkNL0U
 qG5KPmBqfRVXkWmii2o1qiidbVmOSpwS8tDiJVd4/QPcEgpuHVJD+GHHMLNDhrN9DhfwsPA4
 oEveDa6U2mbLEdikrRUnkDcam10g2OpOobo5AYncdIBK6BQhOKDNAodA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v4 0/6] optee: Add support for enumerating RPMB-dependent
 services
Date: Thu, 10 Sep 2026 08:56:15 +0200
Message-ID: <cover.1789023381.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This allows to find firmware TPM again with recent OP-TEE versions,
possibly also other services. The StMM service was not affected because
it is directly invoked by efi_variable_tee when needed, and that is late
enough so that all dependencies are available by then.

See patches for further details.

Changes in v4:
 - avoid multiple binds on same optee service

Changes in v3:
 - don't use dev_dev if there is no valid dev
 - add device_active check to optee_rpmb_available

Changes in v2:
 - fix build breakages with disabled CONFIGs
 - structure code differently between optee core and rpmb
 - debug() -> dev_dbg()

Jan

Jan Kiszka (6):
  tee: optee: Factor out service enumeration and binding functions
  tee: optee: Avoid binding a service twice
  tee: optee: Add support for enumerating services that only need RPMB
  tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
  mmc: Call back to optee after a successful mmc_init
  mmc: Make "MMC Device not found" a debug output

 drivers/mmc/mmc-uclass.c          |  2 +-
 drivers/mmc/mmc.c                 |  4 ++
 drivers/mmc/mmc_legacy.c          |  2 +-
 drivers/tee/optee/core.c          | 64 ++++++++++++++++---------------
 drivers/tee/optee/optee_private.h | 24 ++++++++++++
 drivers/tee/optee/rpmb.c          | 20 ++++++++++
 include/tee/optee.h               |  6 +++
 7 files changed, 90 insertions(+), 32 deletions(-)

-- 
2.47.3

