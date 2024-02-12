Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC1C48BC1
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 20:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664AD875FA;
	Mon, 12 Feb 2024 21:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CxJNSUx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3F4875FA; Mon, 12 Feb 2024 21:18:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 376DF871C0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 21:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707769082; x=1708373882; i=xypron.glpk@gmx.de;
 bh=ZWuVhgkx0F+zb98ZvTHAcgyJ6/5GzrBL3l1QwYzZ1Co=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=CxJNSUx82dvJs54sKNNJxbkkBuvIhz53sV9Ka+kKIfh9DXD9FQ1+sFeez5L95Dge
 cFuc4HCVP/m6z7KIkVSwJzEcG1DdvWwdlsG5K08RKnN2oUrlr+Ly+bdz0lgmb0PmX
 vp0ExF4b+Ksj1SlgDRRG2hqHLjVgGymhKhONpPhf9tYp4d784SRq5il7e94BGr+/j
 nSOwGGCYMFdPR47h3+sByBzC7czaj3AEkEEfaFZrfcXdB2VuSBNC+31H+QmG3+VGD
 rc0sI1F3ygHUVB2gi9tySqNuGD95UbpuA5hvsAMO3mw4Ty568NbKxkCFHIPEM7+tS
 6CR/nd8lbgBUHUwPtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1rDA9g35yk-00nB9B; Mon, 12
 Feb 2024 21:18:02 +0100
Message-ID: <feceb682-cb14-42de-b833-4198e1a71c0c@gmx.de>
Date: Mon, 12 Feb 2024 21:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Janne Grunau <j@jannau.net>,
 Jesse Taube <Mr.Bossman075@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2024-04-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wd5MJkwB/hr9O1qAiUTpvQUvlfUINkFpVl/aaxduDBu2JsWBh1T
 xdwHd/VCD4n/bisg7yQ9kgoB6ow+IDIJQQbnohks1t4LRldfP2m5nslwhnctg3pn/W6CoqM
 J2daJ3H0FdEFtxxjs0UV0AgBX3NvCfWMxfe56EzHDYRvvHkp5TttcXqpSlho2wqPOL52vN3
 YnayIRhlz3P2EpQzy+Smg==
UI-OutboundReport: notjunk:1;M01:P0:VgMOYYq7hu8=;+7GbWoGVUAOCQDu/gWS7F3qGIKj
 0xTK8lzBOo3qAeEhz6dsNGxFNO8CsJuw5E5FzGyN8TuRGNSz7utEJsFv4scL/a0PmTG7IyNGm
 L7cusa53iTwOUBfZquvrMYqCYME2xjHsBj74cSpzvHOrTNRiI1WgRR5z+k/M8sQL/1SGO3YV4
 RLo1VjhztvdmqnQSY/x0h52uSnGdo3bkBkB8K/nN2ys7c7b/H7l7Nr8+gS2WDN3cmsaLGe62f
 iGZNt/71JVKMmdqKnq8kf4GMMyi4EDPGV2iyKV88mpymVm97Bk79jBTGFqf3QkKRo9uW1XG7H
 yaNhWxI8ZND/NA6SygPEJ7OSbvG/JBtiTgUHzph5/2TwCKO47EWAkqP+FBFkgizSWXmH56UvW
 MLC2WsjznIElfSBCOL6gUfI08UKrnWBwNFv81GKfsbTJg3GBtT6VFOc+SrVeWx5Q/lywbWoPB
 8LuJy+Vf9dH/U0BeYUPn3p6zLUMYjuj0hK2MT0axpUCP4r+nXeIWXM1J0WEa4TTp2MfPDBmc+
 G7B2+vrqOcBD36X5GVm3RFs5NQbwRFpCJmeKTUQj9BiJroqGFgyKs7itVcYNH20E/USc4JSnN
 vNfWQVy1+2/FqFpb/s75MDLrIim0TP4nLslxcwvNM9oYH51+NArBYN51mFUQ6s+9I2Ajl4+yS
 o7QZOc3GafiAe2PoT+D/WXdr7YMKs45lwZ4mSeI/7/3v1nlqaUD+159EyTdbULKS6wgpySoom
 M+i1JbY/o6Gij5EID9iVhGKNFdsrfi8bEzHBg7q2xEmphmu82iWzlSUmZOXABB8tGzIckBGDW
 mvmhhQBhEZcZckNNM/vxCMXdNqPxXoEkrxPOYL6/Ptx14=
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

The following changes since commit 91c37c4a20db24a4fc1d565c70035072d355cce=
0:

   Merge tag 'u-boot-imx-master-20240212' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-02-12 09:26:20
-0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/doc-2024-04-rc2

for you to fetch changes up to 2eb39c9adafb4210c6bcf0aed75a34493c098c8e:

   doc/develop/codingstyle.rst: Clarify include section (2024-02-12
17:35:34 +0100)

=2D---------------------------------------------------------------
Pull request doc-2024-04-rc2

Documenation:

* Fix and extend utf8_to_utf32_stream() documentation
* Fix rendering of OpenSBI logo in VisionFive 2 description
* Document imxrt1170-evk board
* codingstyle.rst: Clarify include section

UEFI:

* simplify error message in efi_disk_create_raw()

=2D---------------------------------------------------------------
Heinrich Schuchardt (2):
       doc: board: starfive: fix rendering of OpenSBI logo
       efi_loader: simplify error message in efi_disk_create_raw()

Janne Grunau (1):
       lib: charset: Fix and extend utf8_to_utf32_stream() documentation

Jesse Taube (1):
       doc: imx: imxrt1170: Document imxrt1170-evk board

Tom Rini (1):
       doc/develop/codingstyle.rst: Clarify include section

  doc/board/nxp/imxrt1170-evk.rst    | 50
++++++++++++++++++++++++++++++++++++++
  doc/board/nxp/index.rst            |  1 +
  doc/board/starfive/visionfive2.rst | 10 ++++----
  doc/develop/codingstyle.rst        | 23 +++++++++---------
  include/charset.h                  | 14 +++++++++--
  lib/efi_loader/efi_disk.c          |  3 ++-
  6 files changed, 81 insertions(+), 20 deletions(-)
  create mode 100644 doc/board/nxp/imxrt1170-evk.rst
