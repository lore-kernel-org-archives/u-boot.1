Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887FD606A31E
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IRN8Co+u;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=aPWw7wpc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E691780E75;
	Mon, 19 Oct 2026 17:01:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sXEHv38_yYTc; Mon, 19 Oct 2026 17:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EBC380E47
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792429267;
	b=huaRwULHF+WLLX5YrjeKFF0eari0uAAJampg2XT0ECPw2iu0J+AMar0Iild7Vh7YD6lN
	 PJPntg+RLJUJEt7bxmV9l5+/woZey6Uc1WnmP9+GNPrZR1Q/RWVxrpCGb45M/AJdVCW1C
	 LJvBAy6hMZszNs7KCROdXrqEr0uBm/YcFwaunt0cUyaFI7tc/atQnc+srfCNLjmgTvd6g
	 38wSbwNM7yzLLm70PxorC/VNiqWknSDaADhMXVZATi8iIeyD4eX161+484XVAS5Dtwg4o
	 4avFVjkaolxEbAz2xzV/29Y6c7iYZWXhJCPrZsQK6lRlAZ2i8VM3ZVtYFTgBEDVBjTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OkbP4lJ7LL0MyhHJeR9hgTU/Z/Cchw4dz/xS3QBEqQk=;
	b=YH34pK+Iqy0KWLGWqiSROq/hRfvv7jf6QOAXrt9cjW0U0aOMPTLLWL0nYNStoYTDQGXA
	 HlsU8QwvqnzXKzgA09tXmqEhBj1JGqB5fnc9ehf4WbKIL0KFts/KbB7MXTEWp4W05jvEc
	 ss88cYzzW6+dk5+CZuAflJXqfVL2/h2bYUKd1587UI6tFtr4HNnptfWLP5kZg9xmcEJ0i
	 +Rbv5G8tDrW3AUOJ9a6q8KPHF5MwTjvO+mevMm9e5UfBginz4fnJEGN8isuM8I0bLzdKW
	 eHm/ukCAhGWa2d3lkf2PXYJa4etery8P0fCeCADZjqGwzk3jZIphq/AWioyvY6eePbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429267;
	bh=OkbP4lJ7LL0MyhHJeR9hgTU/Z/Cchw4dz/xS3QBEqQk=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IRN8Co+uqJYRj2ZAVkPwZ9Sf/Ixpc18IYyfvSbn62aRFdZusYz+PzYdOMoaGBDQFK
	 Ja9OeAz59cJrlwS3Eqwe65u5C8tvG6znDERXYqe+pEMe7vPeQwQS84SmJiGBcYhZQC
	 SW3b706qtgggTvK94zRhdRJsTSrNIwQoqAVPbKge9cfOqES8LNWh/r1sDYNMyuiuQJ
	 xchE0ztuAbHSH6nfg7CtKaO4t7ZSgnpKhAEos8Ki7X58kMi7V0t7JsIkUukqlxcnmw
	 XGhleVvad2fjEtLETI8aHaxEHZNStR1m4k8MI0jjWMs+qukXmhIK3EdwAB3Iw2lw1J
	 7Q94KrE9EF7Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EBC380E47;
	Mon, 19 Oct 2026 17:01:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48E22279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A79740179
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:01:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BOrkjbjepzgF for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 98B5D400B4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792429264;
 b=jzd6+tqcZdSRgco+P7GcRCIUXj8R34rUjd93wVkIBdyIcu+GoiiGiskXqKId8JV29ymT
 RD2uOsx5OWnt6P8BuzZv+7GISO7o+Q5rV+Sbxt0TYHjUtFhpfy/5Eg2+K8zGLCzDTBvSY
 8Duj/ps17j2vh+ek3u2dMasdnJhddf8p/nT61dmlk2Ji1SP/wtDbKus8ffbnYgO7rdCrG
 GuBz3tBjsuOiZ+8ISJDuOB8OT6LFgpNQ3LHjdLJb5XNZqZhCcTWemTGgCi+CU1FyyI4Fb
 ICzom8rj7jWHBET5uMWGsPYkeH7HrGGAqOgh6fy7ZUVW3cUS9CM/n0jmUdsDQnIUxNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429264;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
 X-Virus-Scanned:X-Virus-Status;
 bh=OkbP4lJ7LL0MyhHJeR9hgTU/Z/Cchw4dz/xS3QBEqQk=;
 b=cltL6njFimPHfluxRVTIlebKxc7Bje9B0jJlkqA3vhPBnGyoxzkzAaqah4LitX/UbbH3
 lKnnwxjGoQXwIG4QjjYVqbj3Qn37d6zKNmsmgysCLfsfFlOlp+tMhkR/e0Tx02jf4mrc6
 kz2mqi1NZU8175IZeqruvkn/qifDH9B7zCpEDPQv2cwYDkC5gwqXoL/3LR1n1ytEGFCA2
 QbekstGg46l96ZcHa9iLpeAwMgSJ99uPw1Oz8YlWuw+gKT+aMKFPA4zEZUSefmVcrVsMB
 WjC6MgF2/T8STI89BKTe+zoyiLZxJXdt8jI7xiZ8qPxJAgxcYsIWEZK5vQWbrW3dT6A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 spf=fail smtp.mailfrom=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=aPWw7wpc; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=aPWw7wpc
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98B5D400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:01:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03138432A; Mon, 19 Oct 2026 19:00:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD94801E5
 for <u-boot@lists.denx.de>; Mon, 19 Oct 2026 19:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792429244; x=1793034044; i=xypron.glpk@gmx.de;
 bh=OkbP4lJ7LL0MyhHJeR9hgTU/Z/Cchw4dz/xS3QBEqQk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aPWw7wpcbSZftLzKLnrnJ1t+ZCWcZkS+ulBLw6MV1uX+sZft7X9GbMKlPkwYdsm8
 xaziqEhMp6ao06pExyLVEBvXRBkJXZ7EveXPiuLuCOWGP2syFzUdkMeG0nljRnWas
 TFZ/++IcpvJ0GbYF3OLGLO6eEo7OeYqF5iwQBQy4N7oDTfNcfSqdhnau2PT9HTczS
 MaCQ+Hz8Rf1ikLf96SQ/UatM7X9ajHlpAiG86h5CQvqSbCDNMh+EAn78AT+VFCmhz
 JhuqM8zDv/qz4COUZlkZ+dlISMDWNzCwTAYs6fzIPMdGENUiwwZLuyJlG1clzCrj+
 fFC5F+twMFLmXZTpAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1xCoZx1PNe-00F36B; Mon, 19
 Oct 2026 19:00:44 +0200
Message-ID: <0d55ba77-176c-4e19-ba12-1b5730275f5c@gmx.de>
Date: Mon, 19 Oct 2026 19:00:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2027-01-rc1-2
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Carlo Caione <ccaione@baylibre.com>, Aristo Chen
 <aristo.chen@canonical.com>, Pengpeng Hou <hppiscas@163.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zgYu1Qxf/mdymWOpyxcWjl8OwtC/3ioodZbC0QZMePa6/DReaKf
 GF/0ZrghGWxw3WrH5vx1WNWrZtPfiro7a8O5jTGmO+JPaR6R9iPycbXn9QkLc5AqPpQ2yCB
 sKlMUo/LphyJkpRSnFvtD1dDjPosE6izNf0W+WUe6eZyCAB0+UBFQ61Y1fTMiNKtk6VVrPr
 q36emE1cFUYIchij1wkqw==
UI-OutboundReport: notjunk:1;M01:P0:MglMgykq1+k=;NGtYO2LKRqnPwnu1i1e7pSMzRT+
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Tom,

The following changes since commit 8d534cec0cc0109a37c0ded8854da03f1526dc0=
e:

   Merge tag 'xilinx-for-v2027.01-rc1-v2' of=20
https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-10-16=20
08:42:42 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git=20
tags/efi-2027-01-rc1-2

for you to fetch changes up to e910e747575f7432fa02f7879c1757f4576e66e3:

   efi_loader: bootmgr: preserve a passed devicetree (2026-10-19=20
14:29:56 +0200)

Gitlab CI reported no issue:
https://git.u-boot-project.org/u-boot/custodians/u-boot-efi/-/pipelines/16=
18

=2D---------------------------------------------------------------
Pull request efi-2027-01-rc1-2

UEFI:

* bootmeth: efi_mgr: Do not discard the EFI boot manager error
* test: boot: Check that efi_mgr boot failures are reported
* efi_loader: bootmgr: preserve a passed devicetree
* efi: imply FS_FAT for the loader and selftests
* efi_loader: fix use after free in http
* tools: build mkeficapsule for CONFIG_EFI_HAVE_CAPSULE_SUPPORT=3Dy

=2D---------------------------------------------------------------
Aristo Chen (2):
       bootmeth: efi_mgr: Do not discard the EFI boot manager error
       test: boot: Check that efi_mgr boot failures are reported

Carlo Caione (1):
       efi_loader: bootmgr: preserve a passed devicetree

Heinrich Schuchardt (1):
       tools: build mkeficapsule for CONFIG_EFI_HAVE_CAPSULE_SUPPORT=3Dy

Pengpeng Hou (1):
       efi: imply FS_FAT for the loader and selftests

Vincent Stehl=C3=A9 (1):
       efi_loader: fix use after free in http

  boot/bootmeth_efi_mgr.c      |  5 ++++-
  doc/usage/cmd/bootefi.rst    | 29 +++++++++++++++++++++++------
  lib/efi_loader/Kconfig       |  2 +-
  lib/efi_loader/efi_bootmgr.c | 20 +++++++++++---------
  lib/efi_loader/efi_http.c    |  6 ++++--
  lib/efi_selftest/Kconfig     |  2 +-
  test/boot/bootflow.c         | 40 ++++++++++++++++++++++++++++++++++++++=
++
  test/py/tests/test_ut.py     |  3 ++-
  tools/Kconfig                |  2 +-
  9 files changed, 87 insertions(+), 22 deletions(-)
