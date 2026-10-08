Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB964CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 21:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E9A060872;
	Thu,  8 Oct 2026 21:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GO0wL3A34FJE; Thu,  8 Oct 2026 21:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B36960832
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791496527;
	b=lF77QGUbwj6T5KyT3Hh5jDxQ0478AOlUVi2Im6NzDie9mdZTAfq6PGcAEs5+ehs6a11+
	 MmGZIU7+tPtEhPlFLsC2r/NVxTXMUlhtjAYEwbV6s3Rl9Wl7wdwTKkezBe0G6JUjyHNz9
	 NojVhudxPNiW5vnCzvrupLQjtDhn+OVDUACgVkny8AS+ecChnE/IeGPuuZy4y0qydpsM6
	 v59IgceDkcuUHwKxFtK/kGI6UMtfsL5JO/9eZ4QePBjoT++5fV72s6gTShQ70EoaP47LU
	 j46kPqjLNMk3xHm/vgWw6qve0PWgKcFeg91kg6ydys4fcYHHKWl4bls5nqvYvJECK0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791496527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F1awKZw6FLHXE37sHhmh3zQmpa322cE3azw5ytlTJnA=;
	b=SVIeZO6t1aDmylas+6vN7vjP8HbC9Bs3HeNQfcgBJKVRlnIdLFyDo7p8cMlX+OR6zOh+
	 +TbRfpwrnlZY8kMWR0EOnyT/mLnlQey1YjJleu/V5sfk3Yku/4mYkWFPrv971SSWYGqTY
	 SAg0ReDf/v9fchXXrZXdp5Fqw9n3EsOJSoJg7M+fZN6AniT1wrUGhMQoKgVv/tFfkCLWD
	 r8mz+pPJHAlm3zRDJChCPOwbEWGsgIsH0FOwoAZYoSq6pxGX291NKZhdCftBSl0b2eRel
	 ROCyUmixD8Zbd7iYexDsIVGZDZE9ASBjsuRplKkdpd+HtQROmrP8TOji2bSpbIDXeMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=bt2jT05H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791496527;
	bh=F1awKZw6FLHXE37sHhmh3zQmpa322cE3azw5ytlTJnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dkx/fpU+cP6JRwCEPoCXwTf3FwJ3MAQZpfAGQgTQbrmbuyooJm0+4SNANb3ePflq8
	 GNBLc4osYdOI08DinlQmpuCa7+Vjq5j/oSBPqHE159mqgahr9/hyK+1/T/Zcx6aKx4
	 +TJqMriBYWlZH5rIbmsUySlPx8jUADd1ZQYtEhdeZNIWkWtZcURLB0l9ibDutDrWr7
	 LIQUdr7SQuugkhU9fNZWbM6o63RTHCVnS3Ie6Q5u5PFt0ZMCDKJ7BUdkZhCkZNvhh9
	 wJp6OfIkKDso3NL0B54XCqLfBkQV8uKwo43CPU/7nydYgrRGMrULxDcXPWQruOGtmX
	 ramMBqPPvvgsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B36960832;
	Thu,  8 Oct 2026 21:55:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7422D156
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59C3760872
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kEjzGtIMTV5 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 21:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 136CA60832
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791496523;
 b=N2xJg5UZbEV5KcLXuQ13J6NmWJjOWwsVjDHN51rLPvsUlt714Fo1LnVw2+l8YjmwwYDM
 caBV7npizNq96UsgWe8qhBh00CLrfPlSY9mb8kY+OOgJrvRcZ0ZUSRrgj7q8ihP9KRQja
 5g6be/bIhUi2wLOA8Kng1FbaDzwXdGQDdzRKTujrlwjFbJCDiAbp4EtBHFJxneep5tqkJ
 ACPJRiKoOac27rZiV0yhyPUwV6BglbBOQvtkh2FHw8wPI3NPiry/C/nF2dKeQhjZtNYxU
 Xk3JbepFhnDhyQNDDaJbTofrsoEoDpjX2yGTMMMk36BCwpO+uQz/a7pvK8ItxzRsBRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791496523;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=F1awKZw6FLHXE37sHhmh3zQmpa322cE3azw5ytlTJnA=;
 b=h41k9sxD8HDDQXzleUZbmyrGP+QDzk13eWZhZnbvYdGGbfZ1iXN5u5UjV5p5n8HoKgZW
 1Pd6gS6RXWFIoCU1eTe6nsVdCY4Oebvnoy2BSzACmAQRHbYcfFy5KziEAZabq+RxrNSek
 UWez1p5S7XDrf4uBhgOLxUeiym4VzVbEsLbvf8h6gzWaqujlXWo6NNGI7FIBmuY53DCgn
 nHZu6SQBArjeTjLXiaekKreGH26jP3g1+nf17eTn48XWLp93kPst6I+6H5qCqvNAMZsZ9
 lFzIKA4GteNPldEthN6e+O7PoFOVxfTAj31adWGY82LL+rwIqpssAfdVxgDCNwUlxIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=bt2jT05H; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-664519-202610082155196b99e4e52c000207a3-d20zzl@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=bt2jT05H
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 136CA60832
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 21:55:21 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202610082155196b99e4e52c000207a3
 for <u-boot@lists.u-boot-project.org>;
 Thu, 08 Oct 2026 23:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F1awKZw6FLHXE37sHhmh3zQmpa322cE3azw5ytlTJnA=;
 b=bt2jT05HtFrYQt/zP3Qjv2Kos1PdJYcTwzESaXv2XqCgcAzMZdGx120G2KiS5cJz6v6OJ7
 Kxz4nfWgkWDkHcS+ebg4FKHpE0ePcdyKrCpaWz6Zrj1jr7bgiJ6D37nYEFCggWEua09Av0wi
 RjuPDebX6bFk1UrEOlXEfwzSgOqP4OLDQfoJsn+15UdG4a4+nue1nU2CMXbp/EHiqg0jQSod
 NGXaZObrgqlZft6SL+GTsCGeA+P8UlEzUEL1h65fJ4j/mcUw46fSykoaNj4DB5jkXnlIF1Jv
 QZHKNot6DJdcm0kwUm+mTYO7XHRbXCdh27GUYkmlhaF3rb/9NPLm4/rA==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v4 0/3] tpm: Add an option to start the TPM during init
Date: Thu,  8 Oct 2026 23:55:15 +0200
Message-Id: <20261008215518.209510-1-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-1-michael.haener@siemens.com>
References: <20261006155217.187050-1-michael.haener@siemens.com>
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

Simon, I kept your Reviewed-by on patch 1, since the only code change
there is the tpm_autostart_init() split you suggested.

Changes in v4:
- Move the startup into tpm_autostart_init() and call it from the tests
- Rework the tests as suggested by Simon
- Add the new spy to test_event_dump.py

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
 doc/usage/measured_boot.rst          | 18 +++++++++++
 include/tpm_api.h                    | 10 ++++++
 lib/Kconfig                          | 19 +++++++++++
 lib/Makefile                         |  1 +
 lib/tpm_autostart.c                  | 48 ++++++++++++++++++++++++++++
 test/dm/tpm.c                        | 47 +++++++++++++++++++++++++++
 test/py/tests/test_event_dump.py     |  1 +
 10 files changed, 147 insertions(+), 3 deletions(-)
 create mode 100644 lib/tpm_autostart.c


base-commit: 8d7bc8add17bbc69a58dfe0002eea039dd2dc1bc
-- 
2.55.0

