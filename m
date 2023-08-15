Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC19CC0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 07:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA5886987;
	Tue, 15 Aug 2023 09:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692086046;
	bh=D/SsCD82LLNJFMagM7wQGeI1fj0vyKnikOQzMguwgA0=;
	h=To:Cc:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Ba4GauSaFgJd80xjFMwcdh40HFVGlHQ0zUPorZKRAlZ3u9904Hx5RjpwwIFWrTvYY
	 LyTelDOSPKEI6CJEImfRrZtKuVkMG5M/dkrtgs1W5IYgC5vwhaZ83rwrvBMiKDETk8
	 Zys8T2Q1MU7hyFbvr+qcrowM9ZNBr20ss8BHYw6L+RQQ/Z+SXuSKW1/kVhwtk84B8M
	 una+vgMT8FqtAyYj9AX3wxq9YZIOb+cTryd6uE48VrtbbppbNQdwmlmhrcKj7FIYte
	 RLdzgNaPN7gcnd3kPzFnBBcKfj0KOddYQSo0ZJqH696Fekt36gA7My//7seRSQ2sMO
	 9D1IgwMY4rg1g==
Received: from [192.168.1.107] (89-186-114-123.pool.digikabel.hu
 [89.186.114.123])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3701C86986;
 Tue, 15 Aug 2023 09:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692086045;
 bh=D/SsCD82LLNJFMagM7wQGeI1fj0vyKnikOQzMguwgA0=;
 h=To:Cc:Reply-To:From:Subject:Date:From;
 b=gyioCNzRRMtMyaP+PKSKKbN4AI48RwOjIb6cLeVijjsYimODmFvPc9c32VXq4B1yT
 nDb8sax5xbUHikCcUoFdjneQi8R7pwdnh+HrQ5sMqwsftfXJGQvKMNrh7QheqjboH3
 O7QqFUyEa1DWhts1LQZ8HoagkYPBcXl+xeNK/N2rVmLlOXEUbcrmV83PJqjvH/CTK2
 rJ9voVL/KQ0Cm2C6Xhk8+w8C1qC5LeZgmtcUoageuB7v1j8EZxb2OWt/l232bkRNCT
 P/uxDdkv+Sq5l0n101H5/xBFn1Z3AtrNu1jYFw6USNz0w8Gg2BnYi2p2fcPndK6iKE
 wfUevU9ZNHDlw==
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Sam Edwards <cfsworks@gmail.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c
Message-ID: <e99b4be6-ceca-8275-5826-3fb27630f030@denx.de>
Date: Tue, 15 Aug 2023 09:53:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

please pull from u-boot-i2c:

The following changes since commit 832148f675e427060be074c276956962fa9b5cb6:

  Merge tag 'u-boot-rockchip-20230814' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
(2023-08-14 09:11:09 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-v2023.10-rc3

for you to fetch changes up to 250454c59b1b056d47cbb0c6d8d09a68416c9776:

  i2c: mvtwsi: reset controller if stuck in "bus error" state (2023-08-15 06:52:04 +0200)

----------------------------------------------------------------
i2c updates for v2023.10-rc3

Bugfixes:
- mvtwsi driver fix stuck "bus error" state
  from Sam

----------------------------------------------------------------
Sam Edwards (1):
      i2c: mvtwsi: reset controller if stuck in "bus error" state

 drivers/i2c/mvtwsi.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)


azure build is fine:

https://source.denx.de/u-boot/custodians/u-boot-i2c.git

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
