Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD0CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 19:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E3588125;
	Thu, 28 Mar 2024 20:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NWNp2X27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D46881BF; Thu, 28 Mar 2024 20:56:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52932880E0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 20:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711655805; x=1712260605; i=xypron.glpk@gmx.de;
 bh=5arjoeyZzaZFE5VEU7DaMTHpGyx9lNRohHutDNyN26M=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=NWNp2X27d+sxvb3TnxAywqWWlwmd8KSoA+t4/Ey+0hFL8LzT/g9pQZ4jCnrtOFK1
 5eaN+E1yCQOa4+qc9LXOT2b3g+LstMkNWgdEwjWq74vp2dzAS1VavPn8VYAvmgtqb
 dTvaqN3WNWrIajMbNlJb9MoRnXTDJBdVOLnnAOEnXhiLFNRnX5mxgYFZhvBKOq+7g
 RnFmsegaMR4W8AtRsTrNqwnUwjPBoGJuvL7kgakrA7AvSxuC9HErgcWu+jDy/q5qw
 PtPjhf5yRnZdQCjOdOJX+UoHfK5OYMFL5dHMyY0r0tYm6caAX4by2Hue7roP9wxkK
 jW2jc5sOX44M3sH2MQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1rwoPm1c2F-007WXu; Thu, 28
 Mar 2024 20:56:45 +0100
Message-ID: <b1e39c62-816f-41b6-964e-12cb7e8b446d@gmx.de>
Date: Thu, 28 Mar 2024 20:56:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2024-04-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xspwzOrUdN/78YNhZiTXQytbTWhhFvqe2Iev+AhCxoC8OVr1o3S
 VVvKtO3t2KOLAT4k9hPUK2kHnRkObvmu7yYXq05y3WN2AiXdbHl+KoucJWs1lqDdDTqpicr
 rupZ357afhiLsPW1HywwvNvt0ijI4FAYkPNgSqfjFHl/pZkre2EvVPwun1o5bn3uUBOLdtT
 tKbKTwO0HIM0zskqC30JQ==
UI-OutboundReport: notjunk:1;M01:P0:v0zLkV6DwFw=;UTyhOAYAjeklAf29WiJNXO3UhPG
 vMvjHDSIGQD/lF3CkeegcopHKUNK0KcpNNbzLC+asKhvn1hPxdeisr1vhl+UmCYGeYmATAdyP
 KVkkfozIEh1Alp1VBkhzZ48X95WTWurWbhnqoQHbIC8IYpxW0n69HWWfKNBet6ZEAyYEQiOue
 3v/m6MiZfbfAoLdMgVvkGrDUvOquTCBMJKHZxZR6krgX3F2Na8qhFCVZPpIg7rgT8ioHcY6XO
 2Av/ac+YaJ5Ry247qvIut9nowkLzB3FICAy+RDEtCMZPhWxdvntQMPjOO6BfqVVlLseCCO1cx
 jRt1pp11dhuGKGJfoWCKff7hU8Iv2w7EvW8dk9gr25KOC57md9NBpeb/tY4c+XGKEpiYJo2tv
 YMqRvCDUxUS0rEUnPqZyfUocT2v9RKbIX5SMsRwQ0aDmeje3eQ4bOg5u2oywzNLN1AZ4H7yYu
 0sLgJvusNK1+QQo95Qcqhesgd/Pwt1pveokDw4eUiEKO9utjMXclpN8jmgdLzh6qT/yKfMaUu
 9SbYYaUvh6aXH5wQW7UgbpivwvuxloSJ9jwLHBLnG+WT0XPdUA4SKeVgOTKQa7P84BpubVtB2
 UJ17vtUtykzJY1wkQxBzvv1oS2YNSpmmCT+uWwJdV0DvWw5nuPQxqE6PbHSacUxGTcP7gVvcl
 VYcR3SZhVUOcL1HP6AMx0E2vSH2rO4N/hDFbHFie/5FKHMfaO0T4x5h4kUTc9Qd6JLaAQNgch
 SgB8ofj4TZwIEin6Ea0d/xsVJgHJi2NZTvJZRq1f20zUcsZBX5i9pUMqnvn2UIC82HAC1TEHC
 bpO2UFJ0VtqXIY2gaHCqV9P0h0spXKTlrNjQrD6vJa8jE=
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

The following changes since commit dde373bde392c38649c8c4420e0c98ef8d38d9d=
c:

   Prepare v2024.04-rc5 (2024-03-25 21:56:50 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2024-04-rc6

for you to fetch changes up to d2fbe1fa29190fc1209364b3d5e33294009da9bd:

   doc: add reference to itest in if man-page (2024-03-27 09:30:07 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20082

=2D---------------------------------------------------------------
Pull request doc-2024-04-rc6

Documentation:

* man page of 'itest'
* tee: sandbox: fix spelling errors in function documentation

=2D---------------------------------------------------------------
Heinrich Schuchardt (2):
       doc: man-page for itest
       doc: add reference to itest in if man-page

Igor Opaniuk (1):
       tee: sandbox: fix spelling errors

  doc/usage/cmd/if.rst    |   6 +--
  doc/usage/cmd/itest.rst | 113
++++++++++++++++++++++++++++++++++++++++++++++++
  doc/usage/index.rst     |   1 +
  drivers/tee/sandbox.c   |   8 ++--
  4 files changed, 121 insertions(+), 7 deletions(-)
  create mode 100644 doc/usage/cmd/itest.rst
