Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0234DCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2499640665;
	Mon,  5 Oct 2026 11:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98cqRBf-d-he; Mon,  5 Oct 2026 11:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E3494060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200120;
	b=maF5ttW+Nj1BxO6X83VriFM2mYdCG4pABdGBjKJTqzYv1sF9Q+lw7WWvMLr2WnaF6p7r
	 U1dvu3luYxRTpIHZFmP4RTNXFG1KsX7+fya2u1Xdu9e1Nv00XJgKN+PzZW/G2Whsm/8ZM
	 Vl7gDv+bnq0NuIGXXEuTa+BfFsLcBqtkr2pFCRErLiglZn7GL++NMLmpkrNnlEp4ICy+N
	 /Lb58F1R7bwQkrjxVK64ksTE8isON+HqTk8JDv28H8iv7Sss6+E33AsEI6oYeYEatD2OJ
	 MhaWgtYe9PkN3ZTXLBxLeNg83TQBdgIirHgq0RVwK5Qycq9f7+fy9M8svYiH9TkBo1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YlCJOgN1DctnELU+VTYtyHllF6sM+U6t3qGyHWvEuWM=;
	b=l/Ftu+aI+6XHEzI23sS0loewU1j7Q3klSUoi+hwRfEG22bX33Yk4JL0LEvrKKk8oZNxV
	 n9hlGZtnFcTLO+ipJqcaPCF4RiqAXPbKdylRC3aV+ihozRj608+rknNBuXLfmNRLAGzTA
	 i6xvM71APWCdA2z9q9sYZ+kBrbRQeDJmHawzCQsVqcw/clTqREWN5plRelYQMMKuST4bc
	 QXy2gIFi6gyLChxlF9VPyL/hSEm/CmP/GEzikI/J8tDFy+SlNSOO3j3SCl+7UgkbSJ3CM
	 NyDIDC6vOIV9lYLoyKKTdtpvWhe++EP1Hu3sVhScVhJqRxQkboyH/ODEBD5Ilh/ld9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200120;
	bh=YlCJOgN1DctnELU+VTYtyHllF6sM+U6t3qGyHWvEuWM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wl4nztV8khg0YBRVxX+ZbT7HwKFTffERr6nOLDJqyD0s7xQ6n1Y/bLDmbmaz9Y8z8
	 RMpW4CWHQL0D5g9KHyk7abnqKHMMbNMeKgy/O0x7oP4P/bqQ6t4kl3TcfiHkywIzqU
	 fNRSlHRVO4diP8o6CwIEe+cZwglNNuofV1E4FM/wy3lqK506O3Qrjj2H9DKQgKyNhy
	 I/ogmMKRotzvV/8WrsE0V8Deuf+O9udwCSW1uFiJ4H7v111gk6MGPW8dfdRSXeucJp
	 UP2DhuwacNX99FbD/THJ1lPoHCOwnow42TFCOKAt7HaMdkVSBYCL2Vde5KyOWbyhkq
	 O/+1YVmGdbtWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E3494060F;
	Mon,  5 Oct 2026 11:35:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51A2A32F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3786560613
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z57zntCWHm0V for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:24:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8B2C8605E8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791199479;
 b=JZ7Ofd13T9pyohRFmIpFRgHoL8a6cWUUxyRpxSSD/7OBl/THpYoR/xDWCT44b+xMy+K1
 QmnpxNh5WXiV+IwTeIKhtDXCR856cConLmx6T8xucxuFB7DigHyz1rQB+HRiTHc+dTKzL
 xVfS9Ref4oKmnMy0OqAt67u9UyI7dXAp/IqHafqc+JNJLSGfCG3feQ+HsbU7HxiQG6H3m
 sQOsAxz6pR4Tjwl9vpI3njD8jNfO8MexO7jIRFzdOAac7J3HvpsnPZiejXRk9k4cFgD6U
 /1uyD63FXodH1BxB42G5OEcdWLmvwF0OpA3iFU8k2bCQAytPtsFZNFK6YP3aYqv/T0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791199479;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=YlCJOgN1DctnELU+VTYtyHllF6sM+U6t3qGyHWvEuWM=;
 b=SZM1tYP94PbkfScBJnCuccgqVCuBKiqIPDWi7OrV9DYvcl1IxZCYou/tZkF/vEVcf3N5
 wJr0KnBC4HXxtf6EZxi2weQP7kzwZiJLammBBgRB+YYQW62C5cUO52dRIRgzmaTgPTs9l
 wdoHtlHNQFbiDcBEsgs+C/YR52UVfo4Na7A+FbTFiB2TLbCHKlga672KLiTf0xgwdno4x
 gSwM6BoyK+HMTjBiJiEGGZoaA9fnz4Lexp4b1awmMnmb8GUh+H+B/ioI5RRXlMnGk49tp
 JpxTRJTlEg3OlTKVCP+VXNVTP/bF6ZV2V4PdbruQVI0+7caW316fNI9m4u2VeUaC/lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=bAlAK8eU; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=bAlAK8eU
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B2C8605E8
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:24:39 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hyxql4L6gzKp6n;
 Mon, 05 Oct 2026 13:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791199475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YlCJOgN1DctnELU+VTYtyHllF6sM+U6t3qGyHWvEuWM=;
 b=bAlAK8eUBEnQmRvrsHQfx+/g0Bqx9Ut91jRo00BHQZDdaCWp0yqdRN511CMSiJoezdzaiA
 G32g6Cp3IqiYuNB8hAVMWbb1ucStW+fGtdQxT/DeX2r9XYevPEK/RZWTE0XfGBpTcaY803
 1e09mZ47qWmYIxn7A53Rhg+jiCFfh+/HTlTj/CyuB1UmJ5q57pg9IziyhtNIQDIIVobEIW
 +twBtUnjykf/9AndQraCvwn21Jrt73l9EUWxgHZjlMgMgvvTzQczkHDBaulAEpOVUeRYPy
 8TKmHCRzORAxn3UhXmCmnH3fH6ilkB0Qw9xKAcn+Lp0snbHDeUm+jVUr9+9OgQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-watchdog/next
Date: Mon,  5 Oct 2026 13:24:33 +0200
Message-ID: <20261005112434.728573-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jupf9qzcd8o38pc5ca4igori33gxiutn
X-MBO-RS-ID: a9da0ee1b13e72f15c8
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

Hi Tom,

please pull the following watchdog changes for the next branch:

- watchdog: wdt-uclass: rename str to svc_str in wdt_start() (Juuso)
- watchdog: wdt-uclass: report effective timeout in start print (Juuso)
- watchdog: sbsa_gwdt: set max_timeout_ms in probe (Juuso)
- watchdog: octeontx_wdt: set max_timeout_ms in probe (Juuso)
- watchdog: sandbox_wdt: set max_timeout_ms in probe (Juuso)
- test: wdt: add a test for max_timeout_ms (Juuso)
- wdt: unregister the cyclic when the device is removed (Yuri)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog/-/pipelines/1453

Thanks,
Stefan

The following changes since commit bd2f5794b7e24c62042abb1921f9c2039b920e02:

  Merge patch series "Add support to auto-probe Torrent PHY driver for J7200" (2026-10-02 16:27:16 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog.git tags/u-boot-watchdog-next-20261005

for you to fetch changes up to d2a43912ece3faab11eef69b607ea01966c3ea4b:

  wdt: unregister the cyclic when the device is removed (2026-10-05 09:08:03 +0200)

----------------------------------------------------------------
u-boot-watchdog changes 2026-10-05

----------------------------------------------------------------
Juuso Rinta (6):
      watchdog: wdt-uclass: rename str to svc_str in wdt_start()
      watchdog: wdt-uclass: report effective timeout in start print
      watchdog: sbsa_gwdt: set max_timeout_ms in probe
      watchdog: octeontx_wdt: set max_timeout_ms in probe
      watchdog: sandbox_wdt: set max_timeout_ms in probe
      test: wdt: add a test for max_timeout_ms

Yuri Zaporozhets (1):
      wdt: unregister the cyclic when the device is removed

 arch/sandbox/include/asm/state.h |  2 ++
 drivers/watchdog/octeontx_wdt.c  | 16 +++++++++++++
 drivers/watchdog/sandbox_wdt.c   | 11 +++++++++
 drivers/watchdog/sbsa_gwdt.c     | 12 ++++++++++
 drivers/watchdog/wdt-uclass.c    | 50 ++++++++++++++++++++++++++++++++++++----
 include/wdt.h                    | 11 +++++++++
 test/dm/wdt.c                    | 47 +++++++++++++++++++++++++++++++++----
 7 files changed, 140 insertions(+), 9 deletions(-)
