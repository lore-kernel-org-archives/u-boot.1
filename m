Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3498CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64C4E60806;
	Tue, 29 Sep 2026 22:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpdSUt9K2ZHw; Tue, 29 Sep 2026 22:33:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 70179607E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790721189;
	b=FZ9bs7AKy3+qzm8ST4YFPygrX24gT9rDjeq1uACtndfBlHTsqPswcogFVk31NX/pa1gg
	 i5Xqc3sTLUXt5OwA+ZrIw87FdzmcQhAFp9iB0W9olr32OyEhOM91ScV7/jjAUhc2r5F22
	 NQtlTcAHxxx+wYlmAlBZjMugp5cEL7qfoF16cftFG0h/rer4j84qYT/9niLz5vHHzBtCm
	 dO/UuYu0Na7pK0KfqVzcPXPI2LJAJi9zwbz1UpHxdelndx+bdbO+4w4Po7GzvnEsENNfY
	 U6S06kxj7L8d2pb8sZyhdMLZwE8WMCd8wo5x1v2vFSBlw6fN23W6Nz9cwuU9dUbvgNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790721189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mc6iTakSfavw8x1WK0qtJ9nQTZq6XPTuNRtjo/FZs2M=;
	b=RjoVDQHJ/1/0lg6wFPD4A1omiq2aRz3yvwD7qL77NvHT9E1OgBZ96C1lg38VCPTxD35x
	 x7blg5pbItB5AQVBI0046ZFjmzhUuULNxKkwob2Fg7EyLr1JxwGeuJKMXuOUP6f9K/6fA
	 zALdxknF2fCT+hSjCFCPVfDHBhPrgT1hPYownnxjKyr3EFXMszrBSTjl+tsMo2Y6VN4lq
	 m93qBYRCVrarTqjDpgR1FhjAemTAahmaM+2i0DTFZYqnMmHF1pxkZyludfSq+tthsKV4f
	 O2V6jlecqm5KhWAG16PFLjQBXFXLHXXlCGFb9NAJpj9JMPC5692rBUVXptWUDr6Ve/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=kOoPXGKl;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Du6Ie8Zy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790721189;
	bh=mc6iTakSfavw8x1WK0qtJ9nQTZq6XPTuNRtjo/FZs2M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Tt/yDwTT/sX81Kf27mmlKCFcAA1KosEQh4joWTak+7gitEYgwF2uuaOpMX5Htl/GV
	 rJVqt12NS9B667pWqR12hpGQB/XNy+6lp8HwkDSWzE5k/7E+Y43mYY7pveKInNTiOY
	 lXwjWqbd5hmrGVh3Hhy1tSHjOdUsfI6rCd3AoJ794fVTC/beFm35NgaFSrFmMS6BbH
	 euPFWhYCJWqZoTi9wkZw+gPv7HM6PazqCykebmneW6HQla4gxpmPmq8oFFzLdF91vR
	 /nK8wBs7hzYQ5MAVBf91/Vy/EHy9wCPO1OyT+IUdoL3fm3Z7l/CO6KzALFhx7FV6Zp
	 dkMJi4LVylByg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70179607E3;
	Tue, 29 Sep 2026 22:33:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5A7A24E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C73D2607E0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id raDqKesaNgnF for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5FC25607E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790721186;
 b=T/U3bmanxinaj1/VtG70iYIFK01lFTvqoApmWeEJRJQ41CUV2uW5GoWdHWPjxlsGm9Ge
 qrxoGt+p92a265PU7bKIVnRMIukW8lKLi66f20ba0KA3G+wMHvRUxmrzVfiHjO+iTqh4b
 y306UykfKcgTPxQZcYBDmbLlP3/8iqkuboEvTGlFBzbucSd1kDG1/tiNSs0NjaSf97IEo
 6APt9iMWE9nuCOILs5bhuojU4FeZb1I4rqpXGNqlG9YoaiXZ8tYLtZbd7jmk6tlQcwi2Z
 wUiQxGl1H0Onu9Hx/jJpdlW5qBjYb/HTGptr48RCeUCMOli9oB+lZqG8/UplPU7v0aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790721186;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=mc6iTakSfavw8x1WK0qtJ9nQTZq6XPTuNRtjo/FZs2M=;
 b=HXGeYzK09F3BcWLcvQvc7ji51VI7iDyBTzRJ/Tw8PJlYpxsfOxaZpJMME1gscdcsCaU1
 /u5TAxowZ2GlpK29UP0eUMtBr0m8i8Sumvkg9YoHYW02jgY97KuX2gXzQ/CqRNBOy3+un
 rvfCuXAHgN0I8OQsZz22pALPHUyQ4SFDl3yH3LPgJzRei9t9OmAcRIoeyvvb8Zpf7jYBy
 ujJTd/PEDcQTSlpKti+XaF4qMDFZvG/etFqc1N18oD74pR3Ag77sZbfgoBN6WXYwgbiK6
 ocIWFC8pIB2XsD6K7xSFcjD6UNu5XhFEkz9Ol1whA3xwM+USy7Sx83xAybX9ACcoaPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=kOoPXGKl; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Du6Ie8Zy; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=kOoPXGKl; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Du6Ie8Zy
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FC25607E3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:33:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hvXxq5zCpzMlps;
 Wed, 30 Sep 2026 00:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790721183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mc6iTakSfavw8x1WK0qtJ9nQTZq6XPTuNRtjo/FZs2M=;
 b=kOoPXGKliM3zxobWNNWkSi1ZbquTHhy8b8VKQon2ajDfG+7vB9gZUjAtZuHMVRx0KPK5kR
 h2J6/MBJQyN8pfemRKJ5UdOuwTKljDCMw/RqtDour+l232bVpDO1OEuNxDlhN/TROtsaDG
 nJpqNA0fCUvYw4RalcgcEh/YGL7M9oqgOqbHxzAUfD730jo9QXJQw55fWUztCDzxJ5MOzI
 Mndap9U71wAzknj2kmfzszXdF+G+B+zUyHdNJdrgzYzR4d/n9KS4IWK1kvfRNppvSI7WEx
 mo15O+6b2zPQWeSlNkT/9K+1ZsR7TAAm72VfaT7U2MQTe+8NKYV4nbRT1v+6oA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790721182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mc6iTakSfavw8x1WK0qtJ9nQTZq6XPTuNRtjo/FZs2M=;
 b=Du6Ie8ZybunQ6K4f0IbYo53zvALERBhSS19mALE3f/tRUxR0LY3Zi3iSNCV7SYhXyRnWEA
 K/wufD65XgDCdVz4Gm/dIV/zJFnm2pCWZyVlgKL9Pjxv+U7XgWWjirOSbwqmL5qI8tUy7f
 a8WFj4ft1phwMZItHs4ea4bvPHR8ZGglNsxkjhdusFmr//X0nTV/Rw/odfT3npzO0rgZ1U
 RcJMgCEodbI3Ke/SxXx0QAmCgd4ve3NIgV+AVKa+fuNnvZLyUkEmMnNjX3gaDwrhXrngnO
 wb3EiwIt5A0mKFaPaWXVxqm+mnuzytZCE8LqoE3BVHr9vsx+UZrz+ih13lCUtw==
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Wed, 30 Sep 2026 00:31:52 +0200
Message-ID: <20260929223254.500384-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pcfbcei69dxbnakj4oogug963nibzz5j
X-MBO-RS-ID: a83a91eb6ba31ed0f86
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

Enablement of new SDK SCP version compatibility on R-Car X5H.

The following changes since commit f61f50a79dab97c8a4109ee9c15b90bf6157d4e8:

  Merge branch 'main' of https://git.u-boot-project.org/u-boot/custodians/u-boot-usb (2026-09-27 14:31:14 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to babc995e8fa8eea3b34c4190e0568ba74dbb8f12:

  power: domain: renesas-r8a78000: Add SDK SCP 4.39 map (2026-09-28 20:02:37 +0200)

----------------------------------------------------------------
Marek Vasut (4):
      clk: renesas: Add SDK SCP 4.37 map to Renesas R-Car R8A78000 X5H CPG clock driver
      clk: renesas: Add SDK SCP 4.39 map to Renesas R-Car R8A78000 X5H CPG clock driver
      power: domain: renesas-r8a78000: Add SDK SCP 4.37 map
      power: domain: renesas-r8a78000: Add SDK SCP 4.39 map

 drivers/clk/renesas/r8a78000-cpg.c                   | 6 +++++-
 drivers/power/domain/renesas-r8a78000-power-domain.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)
