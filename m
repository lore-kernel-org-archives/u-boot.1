Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E96CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3518405DA;
	Tue,  6 Oct 2026 15:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qxq7xOMCQsVM; Tue,  6 Oct 2026 15:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BEA2C405B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302357;
	b=L19y4leSNj2ot60U1rUeVszIE1WCy6rGbfVA8EYRdYNiWP+CY/VS3A/1TDFcXCTBTgDK
	 1+RbXV5vL9miwgPUGXJScIQDAMykM2zavjRljqq/1koqDqyF1yXpAFFkaY5RSIzkTflZB
	 riJ6bREuz6pqfjajl5rJHFJYd+puzXmoUW2cvmg9kiHSYy1xrJVKMi9TY+oQFb9qUxYI+
	 qlvrMbcb/RSnP2DSmGk0HvqQOO2Dl+X2eva/lqaF2WYXan2htkKP+CczcVf32bpWxsZzq
	 5ovDUDOViq+RDRxwPURRB5Ni0T56s34EnO4Rp4Gb2keLxChjeNPt49W2yKgcAQQoT7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302357;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fcsBblGp/W5OxEQtVp3cbjfcuPkSf55ZJOUIxYhHh7M=;
	b=JrGcY3ucU+g1+mjzkw3B6fIL/ybJyuoxZ+DE5kv0w4r8zcfb5V2Zxh+59KNNHNRWkLea
	 /NCJgMkhEfQv46vlwVfrgVTfJb4rycL+WWXBP4SQ2fZtdbFZgiS8MBe7ueRxrhbVYFDgE
	 hvIVTQl8iYe/w6mHuYOtP2sW9yoGunn18oc1O/1DwWnDv8HqSqSMhRtMvPToiyOAa2FZF
	 K/1ueC+4AGZHuhAHQsH/tF2GTi9KQego/tV9ZHBaPnF6V3NM+C7iQT4KtKONaoEugCMK6
	 kewt/3yNe/odWzXNUOnMjOCydcEHGfw+xNuDepd2Z+86ZsD6hTAqQKL3B8iyssPNtLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302357;
	bh=fcsBblGp/W5OxEQtVp3cbjfcuPkSf55ZJOUIxYhHh7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOdHVz1Fcf+J7Mnn2hHs5eS+tmypGQingeS8WUC+V3QhFa66lWYi5hjDIzORWPO22
	 qn972lUpd8j4bZecGyplB3th3AL7H81KRr1D5ZgD3SD77iPmeRmgcbCnOMNH66ujgL
	 x7NwJh4RsN7Ypp1vkVdVJF8DvfWpBDkIRkI/7vzICa2aEephokLf4S0sbGWfdgM1vE
	 otKdk1t8k/vU9T7MbFPCpK/rtNhjHvbqFdQKVND55T7CRnir/BbFyskY81XyE6HSvY
	 mmFOd/wjLdlQrKXXCzeRP5YTel0IBVoEPXcxuoKVKFkljbEnL//CYIbOtk2e6V7bVb
	 LVv+RZSiflq0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEA2C405B3;
	Tue,  6 Oct 2026 15:59:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F24E875
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3CA1402AF
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MS28zgvyPhqI for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 68F4540296
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791301943;
 b=HApyNVYKL9NU+i3mtMuOAxc+WGFw8Okrfin/Y6YakXDXJIcwJqoSouvZmoaaK8ecy955
 XMHoFSkRjLfkvjQmIuv6nH8gkT/68Q5RIIQRX87jiGf+QR+pqiToF7tCDGvSj85+wGKbN
 mfYaSIiXkioSdmFSzEsldCh2JdsNn7+zreFurIjcgO/KEiRa1c+qWHc8x3mPGrPN8TlVj
 G44g0eNY5o3CCOoF0c7uZZGzfC+DAxB+k1Uy1orA3mvw7n0m5E5uIGIucnR/1hVsz7jtV
 /Lef1veX/aeoTO6QKTR7LFM4kgyaBwFdKNITYef/I9v7shJXwkP0607MlY4RiBZViVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301943;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=fcsBblGp/W5OxEQtVp3cbjfcuPkSf55ZJOUIxYhHh7M=;
 b=GXcfzcFendZ98c0p3ccOu6nZ/6eW8MITlRZ/iH+ybDpt/C3YwxX8ROKwnH9FFMcMR69U
 +KkcCpXZ4aioq80+hZVvaPg3gChICNhop/DdxX25dCzGs0hxcsrvyvcMN4GwA8tTJOcEa
 Dn2Dgn+MNKMLnlN+spOvTRiL3qX7Gib0cuw7hbaa0D4c6SgIqExsOvo+sVWevirjsXzVq
 i4tOrnErPxyzjobm32/wkjKUyOjNdwxDIrfqgfILq71z7OaWI1DXOm8w1LL+hlFIYQPF1
 niwLJvIPQDpylqXfNZCMK0X4AlvNiLVx23d89YhuutKPxiH6FIS7WdboNvhnBGVPihQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=n8C+IqQx; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-664519-20261006155218029979b2d000020761-nuiffm@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=n8C+IqQx
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68F4540296
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:21 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20261006155218029979b2d000020761
 for <u-boot@lists.u-boot-project.org>;
 Tue, 06 Oct 2026 17:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fcsBblGp/W5OxEQtVp3cbjfcuPkSf55ZJOUIxYhHh7M=;
 b=n8C+IqQx6M/tiQAfpnMDEn8nfVnqJFvrKj1KAT9DOE0MzmmGpPTCUMZ2ZpK6ElCJuDakDC
 btIE7y5Um6ouVqhx2E9Mnu4RiEgi2z72zck6Yurl8WmVpV4Q0vM06EZZhIrOyOJv1aXT6woX
 WN59Y3cJSgSDEMbw7tdYBXeqh8ddAe2tFUPDiIPkXiLZikwnnUvsAjhQu2fvrup7TI+Edr6N
 Q4x957iSh+snQPLbKFvnn5onRkBMZkGN2mN8+gjOWUaPhpD7BBXPcP0aOoJhCfbvyTIWa6Va
 X5QGBJZjxc15WlPRCUxQOPdg8Lnx55lEgUWO6cV+azDvsZB4tfAy3fSw==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 0/3] tpm: Add an option to start the TPM during init
Date: Tue,  6 Oct 2026 17:52:14 +0200
Message-Id: <20261006155217.187050-1-michael.haener@siemens.com>
In-Reply-To: <20261006090504.110845-1-michael.haener@siemens.com>
References: <20261006090504.110845-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

A TPM is only started by U-Boot when measured boot or the EFI TCG2
protocol is used. A plain booti/bootm leaves it uninitialised, so boards
work around this with 'tpm autostart' in their environment.

This series adds CONFIG_TPM_AUTOSTART, which starts the TPM from an
EVT_LAST_STAGE_INIT handler, adds sandbox tests for it and converts the
Xilinx Kria boards, which are the only in-tree user of the environment
workaround.

The Kria change is build-tested only, I do not have the hardware.

Changes in v3:
- Split into three patches: option + code, tests, Kria conversion
- Convert the Xilinx Kria boards as the first user

Michael Haener (3):
  tpm: Add an option to start the TPM during init
  tpm: Add tests for CONFIG_TPM_AUTOSTART
  xilinx: Use CONFIG_TPM_AUTOSTART on Kria

 board/xilinx/zynqmp/zynqmp_kria.env  |  4 +--
 configs/sandbox_defconfig            |  1 +
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 doc/usage/measured_boot.rst          | 18 ++++++++++++
 lib/Kconfig                          | 19 ++++++++++++
 lib/Makefile                         |  1 +
 lib/tpm_autostart.c                  | 37 +++++++++++++++++++++++
 test/dm/tpm.c                        | 44 ++++++++++++++++++++++++++++
 8 files changed, 122 insertions(+), 3 deletions(-)
 create mode 100644 lib/tpm_autostart.c


base-commit: 8d7bc8add17bbc69a58dfe0002eea039dd2dc1bc
-- 
2.55.0

