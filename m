Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1B6CFC281
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 21:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414BB839D7;
	Fri, 21 Nov 2025 22:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ldf+uDAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F6383A5A; Fri, 21 Nov 2025 22:08:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16BD839A8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 22:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763759333; x=1764364133; i=xypron.glpk@gmx.de;
 bh=VoM3BfnH7DkMRwAfuDp4l41s7B+20khj6+QaULfFJqY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ldf+uDAomAAoX6FQeTc93r3df8tPHrLMHMnDArlbGKPpYJZU1eoRgs3OK8sja5/L
 OPQdjgJBDFlgMYZeOqUDROcAL+NdRyfy195AXMQYmquEmMiBSjpD6jyLTEsCrUbmU
 wx88bVHK+3bcyJMYxqWnD3V9uX+uF1SUAgy5aMgshkoMIBp4m87GN8vumePLk+o5m
 WAxjBAXNLL+gStdsr9PWiyonKqfebozKEG42WfLi4bI1gThwIJS0ItKXPZ6LLrbPG
 0Ao9A+Y+FYcGeIO8JGQUMOxdxQzTaHJAP2waXxenh9ZjZiOKqRr/BefNLZt3m6FCs
 p55rBRlimikBBg6nOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1vwz7Q1SGz-00fIUV; Fri, 21
 Nov 2025 22:08:53 +0100
Message-ID: <cc6e6c06-2327-42d6-8def-251541c76cd8@gmx.de>
Date: Fri, 21 Nov 2025 22:08:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-next-2025-11-25 for next branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u+i+thmlrK4fvP4YjgPtm0iWEJhblyp+fAOlBaibhoeQYN2J88K
 EPe/CKh8/7fTeCWRtUBoxh3Ix4hHLtUuNB6JYE5NPIajIaBqqolDYBymMvFjgqiEx93wMqm
 9tAH1JpGsyOSyNk5QP90Bd5UC+Dt3Xuxhd7XfjqNcCeJyZOy631CiXx015dD1ACncUD+00E
 2P6YHEw74hDRpYD8fVWOg==
UI-OutboundReport: notjunk:1;M01:P0:Y9HqzfPcJic=;SZGpfv8gLfCvgb1kwpX2GdV+ezs
 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
 ShyVZANXKCZT39aawU5cTDyVNHyWvjrN2WRhEX
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

Dear Tom,

The following changes since commit 8ff90aa64b730c3f511921d4ff79e9f64e62586=
7:

   Merge tag 'interconnect-next-20251120' of=20
https://source.denx.de/u-boot/custodians/u-boot-snapdragon into next=20
(2025-11-20 08:00:11 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-next-2025-11-25

for you to fetch changes up to e81750779ac031a0d9f69487f0295fb0732ba496:

   efi_selftest: simplify efi_selftest_variables_runtime (2025-11-21=20
19:30:32 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28455

=2D---------------------------------------------------------------
Pull request efi-next-2025-11-25

UEFI:

* In UEFI selftests expose the runtime address as a global variable and
   use it to simplify some of the tests

=2D---------------------------------------------------------------
Heinrich Schuchardt (7):
       efi_selftest: expose runtime table address
       efi_selftest: simplify efi_selftest_reset
       efi_selftest: simplify efi_selftest_rtc
       efi_selftest: simplify efi_selftest_set_virtual_address_map
       efi_selftest: simplify efi_st_query_variable_common
       efi_selftest: simplify efi_selftest_variables
       efi_selftest: simplify efi_selftest_variables_runtime

  include/efi_selftest.h                             |   5 +-
  lib/efi_selftest/efi_selftest.c                    |   8 +-
  lib/efi_selftest/efi_selftest_reset.c              |  20 +--
  lib/efi_selftest/efi_selftest_rtc.c                |  25 +--
  .../efi_selftest_set_virtual_address_map.c         |  38 ++---
  lib/efi_selftest/efi_selftest_variables.c          | 121 ++++++--------
  lib/efi_selftest/efi_selftest_variables_common.c   |  55 +++----
  lib/efi_selftest/efi_selftest_variables_runtime.c  | 183=20
++++++++++-----------
  8 files changed, 190 insertions(+), 265 deletions(-)
