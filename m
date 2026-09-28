Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BBECA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10CE180BD2;
	Mon, 28 Sep 2026 22:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Js5rUf9azbTi; Mon, 28 Sep 2026 22:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0EF9480BB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634956;
	b=hkKLU84tShaR4BKICFcQIgxK7/pZ3VG3SXV1zSq0E1od3a/mW8On0bAXqUlQhpXvCsKS
	 wWYlXjkNUI4FuKu6zOTdlV0z32NFLEOwg/cEN05o3/XQYxAjPQ+XyvmZjmZ+zGL/5k6fv
	 R4c9alZtC6B5iSo2J0R10NmvXeTc/6FfP1HzMzSmstow37Oms+yH05o7ZOQP3gPiEFH8z
	 eVvMiqb20dYr5MYtBgD5Q1SEICoWdT3T+GjR9RNhAxEKn2nnGWOXFmaoEb7Z6cstrcnmT
	 tVu5Hd37HM1+Gj7JUB7W3PQLQcZqjilR2EPf0XZtowvpcjxOgWHfRk6o+pZGmvMsBLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hmHn87Q6tAbdlQuEMm7s3MFWiVb4h9fxlVgPsXUY8n8=;
	b=FvR5widFYGgbRtIAXK4c/uNQU1j7WMhrYqYtwQhbGUJGAye8/1eVlLW4sr4mnDoGoJ2v
	 J/brA42H7Ks+JMwXstt/J8nvsM74ukShUhM/q86VkPQy7bKaMTW9rjUAOAac+SxUuPoox
	 RqpVTv4tOy2bxh46F7l3l8wfTq+KSfl4T9aCMLGc/U1VRRMAi10+h32v6aAMOErrIIMdM
	 IeCgKBEcz5XbBnzkZPbfBPrfIBj8YR6yTg2+m6MbfqhfqDjAKpI9A5+WcC6POTmh4CgIj
	 50gt4j15yyA3lYxUWQ4MtPsn6Ie+nHDg/F9E+TjCKBhScoVhhUe3xcvIkJAVubTjRsg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634956;
	bh=hmHn87Q6tAbdlQuEMm7s3MFWiVb4h9fxlVgPsXUY8n8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HrGXRWvoxC/F9H71xRbX7YutSrIDaopJ1OsaVcHxRTjvVDBpXPh+ePI8wRdK5uro9
	 7KOCVaP9x3aqnRakyx6ewiNXDXh9uiOtsiS6ICWkUemDy1mEy5X+vqhdy7HnADDCRj
	 3Ldy7M99MPJkdz22LWK1bJP2OXG63TWpUpB2MlWZIOrRVd3Cgk1fvNWQioLKkWqdJu
	 KFAPp0+QTZ3GDubej4m69fAfuPMeTeBPjMJO9vKxAYAM8g8Pi4WjC01/QtTnrHGxZW
	 OI+WTszQ0aB9BmyM4n7nx3MWjpSZg8jShECM8a7NnnRo5CPop8KX4fqSLIaXqzeFTU
	 0Pq+p0S+PibWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EF9480BB8;
	Mon, 28 Sep 2026 22:35:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC59D72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9233560614
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id je_k3vDKcGri for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:35:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 59995605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790634953;
 b=XrCQRg1CdALe5RAqQI3gvGSVn1wGLwo1a69nRo8+hlgchUgBCk3FLk7nWlwnR9ha8nsU
 D3NVkc/Z+tWaa7Z5jRi6upI1/+kdNypT76D7XF+rP1IMEfk7GxKYZ7CfALihDmOHn89EI
 LXJJBM7dNmVKB7/FoqbTHbIXSVwVYl1ig61gLx8Kp56ViBzDECMmbp1Nz2S7fIR4/7vzQ
 NcVc25YMY+TmqcDPX2UorynlTcXxpPKdP2f5BB6UBMAtQRVyPjBHi0xgL/g6XACD9lDPa
 HDLLsjWbRPrM0PZMvo1W51SHr3GsbrmhX0TaOXaOmPcKa9OyFTRgctO3OISWG5sExBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=hmHn87Q6tAbdlQuEMm7s3MFWiVb4h9fxlVgPsXUY8n8=;
 b=su1dwJRATWRXFrpwxt4A6Ju+/M22qlqQw4c+sliNay/XTaIHqmdQ7HqNOvyTZCnpa3p8
 dpDo4oYixpFAu0ylJpv2vpVCEn9CnvxGdRFF89Zqm0QGfgG7BC40+Z0te6RlBItsFlnJs
 frf275ZPZ2dSt4G94+l746HO7V1bTtpU2gWrHVIRb2zkoDle9Ogp2x/ZCgb7PGXQBktvJ
 0Q9eooCpqrwE2t995z3zmc8OsRw2QwCD03WjX+erKUbUWj6A0rXTbUomNPtiKSh1HGRAx
 37qtrhL2eS2yFdQJ0nuOrvLhK3XMefHSaPrK5/uY43dZC7izf2tO98MRdjJHbVXY2hQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SSZ2V8cN; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SSZ2V8cN
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59995605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:52 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b8f5ae6fa8so1686956e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790634950; x=1791239750;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hmHn87Q6tAbdlQuEMm7s3MFWiVb4h9fxlVgPsXUY8n8=;
 b=SSZ2V8cN+O4e9VSNSvXE/d/ngMKFT/OorjxzdYFeVuDR1sWnqW4S/pg9gr8nc/wqy+
 385h/oitm3bwLqVjuZuPjxnDMF65ruO8O9MEAL0S0aWv0NXfMoVrXkUP9p9uaRUCseDu
 CnTw3aJSOTrdRgihsxkyMxE1s8EWShig8DZQmGqYoMHwiHf1bRK9BmYqDUQOt3ZATpFx
 o82j0U0M75JVthe5SlAKbC8JtcQt5a9D/kkKdrskqDW+ed70yeLVz385YbQcAsoeA6lC
 9yLzL/WFFhCzqT/xuccJxHYCRZKF++zfsSHmNrkxMpWVy8jT8wqfTykjIhEDZ5F5n+ly
 D/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634950; x=1791239750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hmHn87Q6tAbdlQuEMm7s3MFWiVb4h9fxlVgPsXUY8n8=;
 b=1s71A2ROx/wIvtqNGShI60ClgY+ZkSKaLspos7Qg5a2MhxLhmg/IzpTgwkACgPdte3
 cKe628SVGVi4PuBCrcyf5pElnJp3lbX6HBMf0PPiunHaaCEfc77xprzTz1LJtnI3biGr
 x4lwHAFMuDUb15rctLALWU0O3HlJ0Ef+zJUVnClb/wsIrqGMTgAw5uShptEvgBWB11RB
 bUrcZVnS71kRN4sa8AA9xcWXr6Gi2WeH1q1cJsaekx7+RxKUjuMDY8W0ujd/oed92Oz0
 JDKmlWP9Mbc4n6xRji4dXsELYlZJ7vHDEhB1PDhyyB6Xg+ekNIL30SaKDsOr4s4aSC3F
 /2YA==
X-Gm-Message-State: AFq9FYIC6vJKajMK3D8mgEhxbsHBe3uNHrBTu15K2xcSjJO087ILTkS2
 Hj8D00YUy042u9+cHzpcb0q+udP7XNQmTOytbux4vduYpiPXaufr/gWaef3LVpQ=
X-Gm-Gg: AYBFou1G51yG7UG/cq9JFEcmsNvIph0R0+iGpdryV9eT4tPGFPb7yplMpmGCNfYA8P6
 4KzqInFMJqvTbs8sdUxs4IAFC7VHrze9DxLU3RPLy2ZQRGyvE7ylt+i/ZFbYXwJp/8Ze+Kl796m
 Y0rsHNYGk76pgBe03Xxn+ro7yYCPp4xSN+6We22aZeP4glDi6yJQ72FKySm90BLlrbljchsQDhG
 DeIf+Cfeg8EEqbhvptsSferhGYDBFSJGKrRcP/WhOF+8j0G+I5+0F9Mespci4OOqkSs+5laTLB+
 M9UloiGG2JoovXuzCMINxZdIHiCyWqA0S9JfX37TudfNJ+VyDhCaHlSWB/EFnZGsSfuZg941h1a
 CaPd4e91WunJDdDTF2E9/kemHSZpGPzyYknYl9J+scOMXVBb0wt5UChSAEkq35fbua7qe/uQT56
 oVUxvvo1cveZZ0xXH9rW2jQekp1DEzv2bsVugfi6cL8umI+ZzAuQrNGP30J/jb
X-Received: by 2002:a05:6512:2206:b0:5b8:f626:66c2 with SMTP id
 2adb3069b0e04-5b8f62667e6mr1903503e87.17.1790634950393; 
 Mon, 28 Sep 2026 15:35:50 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9deba80c6sm863466e87.28.2026.09.28.15.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:35:50 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [RFC PATCH 0/4] net: lwip: add httpd command for browser based uploads
Date: Tue, 29 Sep 2026 01:35:28 +0300
Message-ID: <20260928223532.482192-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series adds an httpd command which receives a file uploaded from a
web browser into memory. It is meant for recovering a device, typically
a router, without a serial console or a TFTP server on the host.
Downstream forks, such as the MediaTek SDK "failsafe" web UI and its
derivatives, implement this with their own TCP stack and HTTP server.

An httpd on top of the legacy stack was proposed in 2024 [1]. Its TCP
fixes were merged, the server was not; one reviewer suggested the httpd
bundled with lwIP if a server is needed at all [2]. This series builds
lib/lwip httpd.c; the command parses no HTTP itself and implements the
lwIP POST and custom file callbacks.

Patch 1 adds httpd_deinit() to the bundled lwIP, as was done with
httpc_abort() for wget: with the shared lwIP runtime a listener left
behind would accept connections while another client polls. The series
is based on next.

The command only stores the upload and sets $fileaddr, $filesize and
$httpd_target. What to do with a target is left to the environment:

  => setenv httpd_targets "initramfs bl2"
  => setenv httpd_do_initramfs 'bootm $fileaddr'
  => httpd && run httpd_do_$httpd_target

It follows the structure and test of tftpsrv. The size cost is about
11 KiB on qemu_arm64_lwip_defconfig.

Tested on qemu_arm64_lwip with curl and headless Chrome: uploads of 3
and 20 MiB with CRC check, unknown targets, multipart bodies, concurrent
uploads, uploads overlapping reserved memory, interrupted uploads,
repeated runs and Ctrl-C. After the command returns, port 80 refuses
connections while tftpsrv polls. test_net_httpd passes with a 5 MiB
file.

A revision before the move to the shared runtime was also tested on an
Airoha AN7583 board (Nokia XG-040G-MF), on v2026.07 with the OpenWrt
patches for that board and the lwIP chained pbuf transmit fix: 20 MiB
were uploaded in 1.4 s with a matching CRC, and an OpenWrt initramfs
uploaded from a browser was booted by httpd_do_initramfs. The command
adds 11 KiB to u-boot.bin there.

On QEMU's e1000, lwIP wget runs at about 3 KB/s and a 5 MiB httpd
upload does not finish within 60 s. The cause is in the e1000 driver; a
fix is posted separately [3].

[1] https://lore.kernel.org/u-boot/20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu/
[2] https://lore.kernel.org/u-boot/CALeDE9Ps9hua1+AhZDkA+WtxG0phB_0E7j8RJJa8kY5eqn24NA@mail.gmail.com/
[3] https://lore.kernel.org/u-boot/20260928213011.290839-1-sochnev.v.74@gmail.com/

Vitaliy Sochnev (4):
  net: lwip: add an httpd stop operation
  net: lwip: add httpd command
  doc: usage: cmd: add httpd
  test: py: net: add httpd test

 cmd/Kconfig                                 |  11 +
 cmd/lwip/Makefile                           |   1 +
 cmd/lwip/httpd.c                            |  12 +
 configs/qemu_arm64_lwip_defconfig           |   1 +
 configs/sandbox64_lwip_defconfig            |   1 +
 doc/usage/cmd/httpd.rst                     |  92 +++++
 include/net-lwip.h                          |   1 +
 lib/lwip/Makefile                           |   9 +
 lib/lwip/lwip/src/apps/http/httpd.c         |  51 ++-
 lib/lwip/lwip/src/include/lwip/apps/httpd.h |   1 +
 lib/lwip/u-boot/fsdata_uboot.h              |   8 +
 lib/lwip/u-boot/lwipopts.h                  |  14 +
 net/lwip/Makefile                           |   1 +
 net/lwip/httpd.c                            | 373 ++++++++++++++++++++
 test/py/tests/test_net.py                   |  95 +++++
 15 files changed, 669 insertions(+), 2 deletions(-)
 create mode 100644 cmd/lwip/httpd.c
 create mode 100644 doc/usage/cmd/httpd.rst
 create mode 100644 lib/lwip/u-boot/fsdata_uboot.h
 create mode 100644 net/lwip/httpd.c


base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
-- 
2.55.0

