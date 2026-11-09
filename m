Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB1606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yzPGhtVe;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Ey2VKXfB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FB1040684;
	Mon,  9 Nov 2026 13:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdEGb0fi_Pj4; Mon,  9 Nov 2026 13:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C4A1406D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794230616;
	b=XzsgZZExh5BRz273ZpxnTF23rjoXRi6XVLFXrfxRP7hQMSyYHzIDVEO44DF8LFL9xie8
	 tWpnFk9UVvJoMdfDjtRsciKg5gjmzS2VgEQulaAlKFqaF4AaOk48ytd3PAlUOPjcyhwvk
	 Je+2edvIS6rNO+iDFFuvj4jPEVHfgYCy/cp+N7VyvRsGEk5fM7YAfKDtqfDCVJ6xJA3Kf
	 HqDoiPtdSfkFF6r80pCz/MDBeqrjy8RWqiDEnl7b+sHjiaoN8yIt/+tlzxVvKaTCcI1nm
	 LJ76i8gpUsYTkn4SeOv+h/Md1mZqbprleQZH/NtBeZxc5I/I1psr529A9rLo0EWCvDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AzkTcxZ1xL2i8Zq4Lk0IghN/yazprSS9WVmSYDB+zeY=;
	b=hl43Zt2ye1Ervr5hXkhviVzsc8P9ghUWvsrm6vPeSnwr1RNzMipages9p9byzAEmoxgm
	 iAnoYGa2UdOKqDi7T4WTHg/wvNRmaeEiuubDyKXRp8W96CMM30jkcKa9hM/n17/F5ioHD
	 AVelZX/socFVwJxV4gOd+ZmFUMl1lPvfGLw0Ow39gSBgGOFJKOj2bbSMgbS30DtIIi0TK
	 MpG12GsmllomAHFbRl1HKgLW8HE5NtHL8i2uXnOLfkOD47MZQY65LOD6E6EVz5iEUebXZ
	 LgdPU3/joCSn5ZZyMc8bzSxXT4F+x1/XpLkoR6qsiIsq2EmqAd6K3fwz3+sWOZuZqaQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794230616;
	bh=AzkTcxZ1xL2i8Zq4Lk0IghN/yazprSS9WVmSYDB+zeY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yzPGhtVeac5c8qua/FTxr+LYDDOuyEecafxw6iW37qLL1w6D1tAdUgV9KoL41XGms
	 wNjhuvJ5LzpLfPuvElZhj3yjLnQa4kq5jdmNNQI774JwJycaOquTfgNCpyXHq79Yww
	 HQMwa3X6ISxLPR6JfEzkzmaMh7XNjPhSAvz1ZuDhWZrzU+W/P2PuTb13bxrMNiveBi
	 vF4wi0EhEgazCGBugPeC8tNZ/04euICG93LAO0z873ZbnuAQhvp2xCDtklWIqF4KVA
	 K/RtnX9c4WUIEMW61zkYIHR4MG2XnQAzG/QHi3kW9ifu4riQzdti2pbhIAd6z6pDo0
	 aXaNzL4f7R4zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C4A1406D8;
	Mon,  9 Nov 2026 13:23:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 85135111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 763F160744
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:23:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nOVBEbz8G41X for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 13:23:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 900E460703
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Ey2VKXfB
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 900E460703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:23:33 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jNVpn1N33zKnSb;
 Mon, 09 Nov 2026 14:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794230609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AzkTcxZ1xL2i8Zq4Lk0IghN/yazprSS9WVmSYDB+zeY=;
 b=Ey2VKXfBV0WCJdxCQBzj4wnX/+LX7gVRoq2ZE9wPH61eeKhGLjv/f46tPZ/1hJjTejRcEY
 6af0tlHg25GSujCI79YmP234YywFqtX8NiH9KCPisRIaqBmULW5N41rAhEtXgK9Hsst/u3
 aH683/Y7avGt+TVsQ7WlqTl/kJWUfAw+UhUed1IS6+MiZof6u2HmR0JXYxbjdoEcVKviaK
 35zywOg1Btunb2OsrhPawpyimHIdo4MrO5U6HbD6DaKD28MPIHfVhR4LFO205GxNvfsHAS
 tCnqBFx5qeo3iMuRw7cUvY1gEJol9xtaQy1fFHH32Lh+qljCwV2Y+F2OBhXXiw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-watchdog/main
Date: Mon,  9 Nov 2026 14:23:27 +0100
Message-ID: <20261109132328.2040740-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yhiykogw47crh9g156xskxmhyw8j6dm4
X-MBO-RS-ID: 0918acca169b8c396b6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

please pull the following watchdog changes for the main branch:

- watchdog: adi_wdt: get SEC fault source ID from DT (UtsavAgarwalADI)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog/-/pipelines/1928

Thanks,
Stefan

The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba243:

  Merge tag 'u-boot-imx-main-20261107' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx (2026-11-07 12:04:01 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog.git tags/u-boot-watchdog-20261109

for you to fetch changes up to a55dcb5d8a820cce482f2a6bf01b160b33bdc8fb:

  watchdog: adi_wdt: get SEC fault source ID from DT (2026-11-09 08:03:22 +0100)

----------------------------------------------------------------
u-boot-watchdog changes 2026-11-09

----------------------------------------------------------------
UtsavAgarwalADI (1):
      watchdog: adi_wdt: get SEC fault source ID from DT

 arch/arm/dts/sc57x.dtsi     |  1 +
 arch/arm/dts/sc58x.dtsi     |  1 +
 arch/arm/dts/sc594-som.dtsi |  1 +
 arch/arm/dts/sc598-som.dtsi |  1 +
 drivers/watchdog/adi_wdt.c  | 10 +++++++++-
 5 files changed, 13 insertions(+), 1 deletion(-)
