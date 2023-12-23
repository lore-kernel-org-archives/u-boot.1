Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CA4C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 00:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB072874AC;
	Sat, 23 Dec 2023 01:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GibCFBlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757FA8766D; Sat, 23 Dec 2023 01:44:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9889C869F7
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 01:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703292286; x=1703897086; i=xypron.glpk@gmx.de;
 bh=2Q81nI6XdEvhliW/CPDPeR+AGa9js67uKwDj9HT35LM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=GibCFBlWfFzYdGhH8Jen/UZsAWal3jMxC5cw1xlAnS/Il2W7T7TGvBxaDNiwf3b/
 Ju4FEG01DetlYx9EcekwdVLHYP42ucAej5hWwY7ikihV2Xoh/ESy/KlTUeUM0lPs4
 IABYuC+WJonr32jw1pkwPDEPdzcxpWDJMM6UyzxPIQwV4td6ymoFwVgKZ+H2TeaE7
 nM5L0I5oWAe7TDZW7WBQfEF0kO4evED6v1Phx+Ak93m6ez+Ipz1N6aN+yJ3OZGMpJ
 I7C1kSx3m5gNCd7AZpx1lXL8qPTDdlDasBzyAj+dNxR1dvYGyXfoBJnisUe7U9bm1
 RZ0rc2qMXDpVhEvW7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1rPsXX10sL-00993r; Sat, 23
 Dec 2023 01:44:46 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 0/5] cmd: provide command to display SMBIOS information
Date: Sat, 23 Dec 2023 01:44:24 +0100
Message-ID: <20231223004429.247301-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+fTyXVExjk9bWb/vRpk7J7rophKG/qiWLq/yOolqxTMbxKj5AUR
 HBqeIJxOnqRm8xsgLLFLFXlimgZCM/b7jROncw54MJuFRGWU2XOlS+Dv43R+2YxOe+nDgOP
 793rot68kuKtrb2jwNUjcirCzRetMYCfoA66NFerE7iYDL6pG5Lpda8t6Wdn4xnWfbNsVZu
 eD1uMpLuYSVl/73SV7F/g==
UI-OutboundReport: notjunk:1;M01:P0:Dt38Q5C+9Sc=;EIhDAtR7uHnxZ3lezso/Sfz21Cj
 x3O1udFMHeOZhjfmrKBXIrzK7VaGHy8j7pTrTz3gFQMMxZWMUVqdZpgiHVHgzDwF0Kt7NX2tK
 93E/P9u/92Ub94R8zy88qBmZUf6uy5/2EET/7HRXfDt9Buw+r0HmQi3V1QUQtBOL0J5tqhmJr
 uPkBmhhCCSQtekcspaHqofZnELz0cCEve8xJDSJu9HVicatcd4KAKLaFjCYgSukDmZZ0NXh/m
 0oc/00LLrgGFVcugWwdbov4deJgcnh7bolCeBo1F9BERozZ96B64YNZVBg+NwyZKuhlNREvJi
 7E8MzyUTGidW5z1WPHiQThybEmhLW2MZKJn35ykf9rrzWDSA7AvH1ADUaU8KeZmeWwPqnbLFh
 he8IPCbykuKj0IKF11QE7ql6ikZQAoAcVrx0grzkOUvQhgR5ITJeazy+9ovhvyqSdnuqV6sCJ
 D/peLvCeIUQD344RIYgEWg1Inn6pLT/8Sq8fpUwH+6ch0/r6I8wJkV9DSBburbPp+8cgXzKXz
 HekhmGPLPa14VP8IW2FgfgVtKXAvrny7pnI8L3yNUiRpYAp8hv7Fz2A/owzenf6cAd8BaqjTE
 hxklKeNuX/uUxxlr9viJptNgV4CbtfXDbc5xHvEFzUQtR+5xcADTGRHerZSqMoTBGFJcGsHQm
 tnbNs2AutrH79hsHzYKXsSN39AiKhUfjIaO6xbmR024R+hPy1iXJ1XmhHZOqcKxDnnuwg+gau
 CMnaSgls0VI8WhmfZWR4AdMjbtFfOgsrtBkRP+7wVq1UFPexGLNpsWrdyz7W5e+qN+BgG+ss2
 T9JiRoLRBySVjTIMKa9I7FbRTFFmFwKc3ry9/NyJZECBqDkRrYTjJoxRpPMqN+k+bdEsf27LB
 PgC/yKv7YSG08XHJg6KkbSNEOi1MWZazph6J86uKYe7ydU865uXVAPrVFqttcdqXQjZFG3Md5
 RMBytuZ7QxhdDWuzP+AYvCGudyQ=
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

U-Boot may supply an SMBIOS table or they may be copied from QEMU.

Provide a command to display the SMBIOS information.

Currently only type 1 and 2 are translated to human readable text.
Other types may be added later. Currently only a hexdump and the list of
strings is provided for these.

The following prerequisites had to be fixed:

* The definition of SMBIOS type 2 lacked a field.

Heinrich Schuchardt (5):
  smbios: correct definition of gd_smbios_start() macro
  smbios: type2: contained object handles
  cmd: provide command to display SMBIOS information
  doc: man-page for smbios command
  test: unit test for smbios command

 cmd/Kconfig                       |   7 ++
 cmd/Makefile                      |   1 +
 cmd/smbios.c                      | 191 ++++++++++++++++++++++++++++++
 doc/usage/cmd/smbios.rst          |  93 +++++++++++++++
 doc/usage/index.rst               |   1 +
 include/asm-generic/global_data.h |   2 +-
 include/smbios.h                  |   1 +
 test/py/tests/test_smbios.py      |  47 ++++++++
 8 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 cmd/smbios.c
 create mode 100644 doc/usage/cmd/smbios.rst
 create mode 100644 test/py/tests/test_smbios.py

=2D-
2.43.0

