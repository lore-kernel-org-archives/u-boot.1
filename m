Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E1FC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A726C88193;
	Thu,  6 Jun 2024 09:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GsgI+lVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F98988199; Thu,  6 Jun 2024 09:42:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECBDB88103
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717659728; x=1718264528; i=xypron.glpk@gmx.de;
 bh=ZGrtmtoDFv57FwO0nu1dtgkck3MmWM0x68cvWsQRDuQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GsgI+lVPpEkPJJfsrvovO2pX4StRaQhLesHHsMw/q0UCqIuAnb8wdsg5IwIjZLI6
 ZvG/UvEkMMs8gv8nIWCYF2EfVlvzwVq4yPUiYHUDI5wpwp9miHqHWXiD+Mmi0z8DN
 fshQ+0C84MNHFMGGyQa5kZwWL4PoS7pNWFPlA98k0AHfCPQ2JL4xKnvQcNUJriV29
 FkFu5CJWlng7fTGoULVceCGUcg3sJkNYJZaWyHpXhXxQBGJIp+1+d7WkmHMx1MwmA
 VWUfQN4aJoSSsrSV2JFi0dL9d4FsDzc18twvAzip4K5tWA3OHi6nfOUXmcsN/EZ7K
 Ff+pJnm8RjajQ2yqdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1s9JPh0Oib-005Ojx; Thu, 06
 Jun 2024 09:42:08 +0200
Message-ID: <8ec6229a-0f90-43fc-9c78-dea655ef5ccb@gmx.de>
Date: Thu, 6 Jun 2024 09:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fiona Klute <fiona.klute@gmx.de>, Sam Povilus <sam.povilus@amd.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2024-07-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gFEUVliCj5E1P66m9v5CNGhUyxS1kOewGFGkEVaOuYhHn34QQJJ
 s/iIxpWsQb+JJJ/IwlGSPWm8jtqaPq1ALpr23CsQ3mosGIFbDdik23MONYR/k0rOTZjMG10
 SIKtMmjVVX0Dy2FX9ophf2BNr/6z0OEda+P6MEZS7fdLxH56+TlnuqVNJuZz91bpA5pbhBB
 NvNKA6YdwqzzzkN6hSVEw==
UI-OutboundReport: notjunk:1;M01:P0:7lraQ9x99QA=;zOeXeFH1N3ogmu27m2fS644icru
 jiIQOTZxaqN91p4gwiv5MzUj5Mzp8lpfj+fOX5aY7ZVXjwQXpx9nbavNrBB0Pv0S3PGMO4btE
 55cfPjsH65sSfKpRGmnxhB4YZcXOGh7Zcm1QGU5/33C8aKnzAb5yyqZ71PGVWEvVOUS0lwq1n
 GF/VjMLkBTUCmccMN53m1IlaVfmEgckd0SOi5P1KPf3Rr8DqFsrz4fzc7lr6dIs6sHxljLMep
 BtYreAf24mBn/XfpSz8ljePlVCNvZ+GlbhvJO218ZFFUb+RlE7WFEYAg2Vu7bza/VhQdO+iM0
 M1LU9oxOIOU3UuCSsksJxrLAajOLKFztsGOlgPOd3Mp7+msr7rKkr+j9AV6xklP0OVXnGmtl5
 LMyqptiAHKi9m/nzDs4XX+sj6A8T1RftkrnyJ/Z2FZ1XG+luLPHmTnB/pRTa6/skvBNzr37Jt
 T2I2bPr0wrimTKim+BqKey815aHWzhUCTgV6WYdWj9n7TIH4U+Xv6o5HlPe0XEKupZqGpOiXp
 ly90E4xeyr3Jaw0n2ahZNDfOEzThqkdu/VDJexudxWdDwFWlTAdAhx9MUwemJS0d5Po55inqQ
 pjer88DZ57LkZoCB3k3CPQKWFd29ioY2pl+gxsAHBa0JJY+et26YkBi7ehhV3CSsj3W3NuHQ7
 ToOWPHeo8+375vEc6ptAUkvWk3qVuolQahX5F2KhgjzOHmGUJECY5bV9BxyAuxGv+IrywsjYs
 wXxkM0XfobZTSJkq3GxJMHFHYK7/g/R/Txgvz1YZ5mEX5xJCF3UxgOegoOQnD1Byg9qTGOQRi
 QCh7bZSQktiNOTSKgCJIM/9sv8LRQ3CY8Xa4mZC9Xrdf4=
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

The following changes since commit 4b992573b34b1586e323e27b177680a6efec1c7=
6:

   Merge https://gitlab.denx.de/u-boot/custodians/u-boot-usb (2024-06-05
10:59:10 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2024-07-rc5

for you to fetch changes up to 0efc5a9f670144cad7f287711f25c69cba0fde39:

   doc: process.rst: Document device tree resync rules (2024-06-06
09:28:20 +0200)

Gitlab CI showed no issues building the documentation:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20988

=2D---------------------------------------------------------------
Documentation:

* Update netconsole examples mentioning stderr.
* Describe what an "fpga" image is in FIT files.
* process.rst: Document device tree resync rules.

=2D---------------------------------------------------------------
Fiona Klute (2):
       doc: Detailed example for netconsole setup
       doc: Update netconsole examples, mention stderr

Sam Povilus (2):
       doc: Remove extraneous curly braces
       doc: add clarity to what a "fpga" image is

Tom Rini (2):
       doc: process.rst: Use subsubheading for "Phases of the
Development Process"
       doc: process.rst: Document device tree resync rules

  doc/develop/devicetree/control.rst   |  9 ++++--
  doc/develop/process.rst              | 21 +++++++++++---
  doc/usage/fit/source_file_format.rst | 28 +++++++++---------
  doc/usage/netconsole.rst             | 55
+++++++++++++++++++++++++++++-------
  4 files changed, 82 insertions(+), 31 deletions(-)
