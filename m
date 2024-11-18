Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAFED591A5
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 16:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B578948B;
	Mon, 18 Nov 2024 17:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UA9n443t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB01B89493; Mon, 18 Nov 2024 17:40:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B70489482
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 17:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731948028; x=1732552828; i=xypron.glpk@gmx.de;
 bh=84qlQzdVhSHMHc7WFet+2XkMXNpvZddm5bOYVkpE9oE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UA9n443tJ/YZEDaTqsmPOdZgVaWXx2Sh1LArnxebpGjjCYpi41LisgGupg+eX7Fl
 woUzYAHVamY99YBy4BdcXS/czLzU3X8WIFstCPcfxSmu41dUqyYhWgUd+MmAcJoM2
 Eegrk3n491+Y00f1drd7BxncV63MXzpKPCFli5dYxbpItmrAUsc0x+It3iHG77Pkt
 2COZhGWoGPLeSH+DwYLeuFtTtdA7uxauQ2+RL9tY6h7OYCeBCdnKTtDdwEXLJKzU2
 TnpuhGsVc6YdnG/+mRgdGKZrnR+P67HuhuexZh2oPzHrEBZeeDYKx2LHyYHiCwAKJ
 nELzpfRY5s00gRguXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1tl1RB35y9-00baZv; Mon, 18
 Nov 2024 17:40:28 +0100
Message-ID: <a3f0803a-4717-437d-8e17-bdd79b126c74@gmx.de>
Date: Mon, 18 Nov 2024 17:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request efi-next-2024-11-1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8u57kgl3AXyeZM6HyCNwNuEy3Gy8ugQ79BIfq0XehYVybHbOebx
 3EZQBwgmySF2rvMv9jQ+YLn1d3HyMirqQoE1LZB8NASBFdY9Q6tUN3J9wwuVmH22df0RUiM
 WhjMRBqyDkzNGhyzg6Gyfut3AK189qvxkvLJOfx0ODnrjin6/rRghHaSV+TG8wNvU1fjiHE
 JvxEJwSdBrq9eQBLE2Nyg==
UI-OutboundReport: notjunk:1;M01:P0:BB3XKXp+Em4=;a8kgzWVuUEiONM60f68bjvJQkVk
 QQ1cjxPwnoa3LxQyANSt2cXWZwkNsGuRweScjuxnnY0J5PVTEAkegWrouVcd/3CGNAx2i3dsE
 08nycGpXbgFcUc46B+FWFA1fHMJCyuHfwSoCeOUB1+dlcpApRwY8vpLB7/eK/U/cJXB0Z2+bc
 oKVRMak+3mvYSyIew9G7yDSAvizp7QksGr4HpYiNgXy+DZv0qXiT9hFzrYCbIbR1nQ2P2iOp1
 DsAK7djCYNZfy71dkRdUzJwgdSza5hqgSmsNj+PrO9BPJUoFIjdaL4Roia2LykumxPRuM+PWa
 zb4//6L1TEfIXXMYH1nuIXoLXyCkg6Ol/8NtldbP1/FhYFx5opRJA6b803bFq1PCn5ZdeXKwE
 GZ5vRM0Bzt84TSNCI88Fy0zZU+GKSBCVo0siffR+R/59Si/gxBSjqjDzRVlasfkt41+De18LU
 0JxGOX4zE1J6PS97YR+Q+ElM++wgREZiANgykr3SsOHciKPk2MT1yU64wWdcYjoOa4NlWT3aw
 n6lnSW9Z4fLgNuUkvuCEEyVsmlrBxc0+iMtkChYf2NHzx8w59eXO9sli753frOGAYWcbrx9by
 CiciKuKkS9J3t65We4ndbjdRATcn3ixTRDghM2Mul3QglKqzPdiOGH4Rkg78APBLUP2kloPvs
 pKA0sr0dq70v4FH4qAntcgf0jKOEXZmbCMZkJRhuJkl+Zv9unTDoU4LjN89Pk/9/PmzccZHRF
 op4wlVxqf1/7mRL+YCIfJMbWBvihXh5FudLlaqbIbD8FSL3ri3J197UCNOCFKOq/9TMKBjmQA
 qRxE67VGEo8b8E4LdSbKMNRyGE/p69KN06xH1n8rtFUGrajvEslV8xNlBNkSREiEgp7wUWUpK
 jLVnAsK2OW9E4WJHZdBgZkiVIfm4ENYJD/CTyumkBPBYFMQ83EoZvF6ZE
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

Adriano has split the patches needed to implement the EFI_HTTP_PROTOCOL
into two series. The first series received no comments requesting
changes. Let's get it merged into the next branch so that Adriano can
base on this when resubmitting his second series.

The following changes since commit c71d451033db9ed1ea3ac46fa81a09ec9c58918=
c:

   Merge patch series "teach 'env default' to optionally keep runtime
variables" (2024-11-15 16:36:24 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-2024-11-18

for you to fetch changes up to ec054b23c6ac56a0125839ae9cf800c20f886e92:

   net: net_utils: Move ip_to_string to lib/net_utils.c (2024-11-16
21:58:17 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23430

=2D---------------------------------------------------------------
Pull request efi-next-2024-11-18

Prepare for implementing the EFI_HTTP_PROTOCOL.

* Make wget functionality callable even if the wget command is not built.
   (add CONFIG_WGET symbol)
* Ensure that wget_with_dns() works the same with the old network stack
   and with lwIP.
* Put server_name and port into wget_ctx.
* Integrate struct wget_info into wget code.
* Move ip_to_string to lib/net_utils.c

=2D---------------------------------------------------------------
Adriano Cordova (8):
       net: Kconfig: add CONFIG_WGET symbol
       net: wget: add definition of struct wget_http_info
       net: wget: Add interface to issue wget_requests using wget_http_inf=
o
       net: wget: integrate struct wget_info into legacy wget code
       net: wget: make wget_with_dns return value compatible with its
lwip version
       net/lwip: wget: put server_name and port into wget_ctx
       net/lwip: wget: integrate struct wget_info into wget code
       net: net_utils: Move ip_to_string to lib/net_utils.c

  cmd/Kconfig          |  5 +--
  cmd/net.c            |  2 ++
  include/net-common.h | 64 +++++++++++++++++++++++++++++++++++-
  include/net-lwip.h   |  9 -----
  lib/net_utils.c      | 11 +++++++
  net/Kconfig          |  9 +++++
  net/Makefile         |  2 +-
  net/lwip/Makefile    |  2 +-
  net/lwip/wget.c      | 50 ++++++++++++++++++++++++----
  net/net-common.c     | 14 ++++++++
  net/net.c            | 11 -------
  net/wget.c           | 93
+++++++++++++++++++++++++++++++++++++++-------------
  12 files changed, 217 insertions(+), 55 deletions(-)
