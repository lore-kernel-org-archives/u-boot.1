Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6DCCCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90F5560673;
	Sat, 17 Oct 2026 13:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQn4zFe45ARV; Sat, 17 Oct 2026 13:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACE5260A59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242121;
	b=dCpTgEJtbFnGiNsukzzQDSGT4I0ZxfGm3AUkvg6hQRqrLzENn4fvTCFMSW29yBHQffhR
	 cA3ja2nvN8KcsfLKCgDxqUzrukzGIHcSLKCwOSXDtYyt7b+7f+JVrRUxnw/1aso5nhSvp
	 vULxWSE9s6CxTZAxqHYcecbCfnoE5ba+A02Mn+Lz/jKLofwt6RJ3ImfAmhwL98XgbIH1x
	 U35c+6hyIf5T3f2lQ1P1ALFq8LlnvnlYrn7fzsy2ttCnCJcvfzk/7LM6idujLSMBNewMh
	 ctFGDFkZemVgDZj1ISw6A/GIGAFKnX7WKaJUDUrjgb3Ynvhcc0Xc5cnwEy1P97puYfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Qw/nu2W1yr3uOyWkN55j0bET1ibMORzH0LNWygcDSKY=;
	b=iGVVnQyXHBxOrwFj3m0zBkIH/L12y+bPQmNvx1Rj4iuE/i1Z/SFRz1aD+j22zuN2xEQe
	 7dYUw1akbUGosVSuh2v1Vxe1qOPpbD9dly7QYoIG/ETSEu/Gsph/DPovgpa3xR0FqVV8k
	 iIBBchnlIMDyTY9joTTu4uXBugsjDLq8BOvBqtJtVwW87X7wdxEE+kwFduzSWzG74aSpc
	 lsT65qOed96X1BO+KDL1zFE6crdYwP2y2fMx3KymxyTFBJ7FnDnDKYu/LhT15rY1DbZT4
	 Lkw5FLGkEuQjea2aSIcq0rNDaVv/cLcSElY1cJpf1BebuFe+PNoX7936vIn3WJupzJw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242121;
	bh=Qw/nu2W1yr3uOyWkN55j0bET1ibMORzH0LNWygcDSKY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=D1hDdGDG9NJbeOAjhYsSBy3E4SdDQtbpE0lbvOlN3gPZyXniIklF/niXMjdUpBgwU
	 FwIYExwkAnluzy6xcp41VxVu9gnuT/tuzRs+tMZ5HWdcx4xOYW+BBfDXMEteXy0X6E
	 L0O+OJwJ8AJVNrpThPkEdkSs2qBFfpNAhrOdg4TMTvzGaP5ME5Oiox/XnU2wesmVgU
	 dufjLQbQaWlSgWmM9tMW/budxSZ8HlCiiIRU6wXpjSfyYh98zrW6MqLse9MsoOJKPb
	 hfi+Krd3Q/G29LW+1/zwZjqQle//2rais5C+AaHWYZStyazGDeB4Kbj/mAzr2uaePc
	 QvGaF654ucVyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACE5260A59;
	Sat, 17 Oct 2026 13:02:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFAF3362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1580409BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5-Vgr2UZUpE for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1E62409DA
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228230;
 b=qy9b+8C1gyygl2cn7/yzLCUCfSLKCteyc5hFQvlV318ohMWjRgoF0/LkW4KTWrO8ovZ2
 ZxNTd7Md7X5K/Y+C5rNt/M2IQI9l/wnt67ChS1KuW8kNqj0tllPJktiG0/ocDoQambbqb
 +mS2oAVAYlxmpetDOd8FkCPGNj7UIlOfCswZRprQh1ODfUn7ILcDImE9D63jVvAhRpymI
 ZGeBd5chjX58t+Ea6gJVNEFm2WBv8OIkEvVgtlXrPbW0Kig/J/DuV9FnHJXAFQ+Ro35nq
 eGAszOgHqfBhvbdrK7qPGY60vNRREG/x/8SH9EjyeRvUIQ5iDhml0BGt0hvrvZQxiOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228230;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=Qw/nu2W1yr3uOyWkN55j0bET1ibMORzH0LNWygcDSKY=;
 b=qD3L4Tygu8f38ZwgRoUAY47dszlMmJkMHe/nIcLQYPL1yrV+nuM0g/s06UDIR3KPgpDs
 y0gqyP0f56UzFziVRSc4wnxgaPIjNSQv5TGJH4dzk/421xMx28vD/7lzOKnuqNQcZ2hAp
 JSbPNY3uJIoqbIWNZ0T6BdCguz1UME+pjTuPnG2xemfkHNYwheZQmhK24jAUakuT1f8hc
 HNRlJ0cSZnQlUVjmCdWPdi4fr6paSFrZ3IXqk22eaZGf5P2l4KuUzM4ooiCeRhnE/lGjA
 IVkKR8MX6rDfZRQHTTBcu2+Pf8IIXsL+QeWzgWFkBfkez2LmXduyP6e9dYWkIk8z/sA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RWxYoTKu; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RWxYoTKu
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1E62409DA
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D8E34175B;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D9EDC2BCF5;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=KvnEcU++M0WzotxiHADNi7rccPpE6AA8Gp3jbsNAXL0=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=RWxYoTKuj9hQFrzt34h8b9zDC9iyPnewFpsBe6zlj4JYyByVa9Inm8o5+qxxIL6tx
 vmfFjhnqAPTyps/9YOmCMLfGDG44WsRQoQeM+VQcwkTPtXe3x1tW5EPz56iMJ0kPZ1
 Y3ZiE0KbWKEgVtY3en0bRBmzPT4/JuLtAhAhVyAjYpMqmX6h36SGQAnGnuafX9brdd
 8G8niHwCQoxvPCQVikmZcxH3HRyUom4MgRjzQG3dRq9+F/rOeUn9odc+XsvvSk+lQQ
 5l18zOgrpuA+l1qNTMj/2JI4QMPnTZjpM9A8ZFdks1TzUhhG/Jpkzs4MAy+Potdmq7
 +yi88ecxOBs9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DE376CCA462;
 Sat, 17 Oct 2026 09:10:26 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 00/14] expo: Add menu section headers, wrap-around and
 colour control
Date: Sat, 17 Oct 2026 11:10:16 +0200
Message-Id: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM2wpAQBCA4VfRXJuyciivIhd7GIxktYOUvLvF5
 Xfx/xcIBSaBJrkg0MHCfolQaQJ21MtAyC4a8iyvVKZqNAXSuXq0fvZ7ECRrtCt7Z5zWEKs1UM/
 nd2y737Kbiez2buC+H3s+rThzAAAA
X-Change-ID: 20261017-b4-expo-colours-ecbad5fdbdaa
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228224; l=2171;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=KvnEcU++M0WzotxiHADNi7rccPpE6AA8Gp3jbsNAXL0=;
 b=UhvnoVOeR96qVBGLchiLukAJyYgel1HvFmyClcXQOfjCn18ea3nXacPQAfB2U5kbAfWUpXt4M
 zAgf+L/iWjyDrih0oV0iKPB6J24dTlwoVCkqUTLe5xAFTPj8w6mb++k
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series extends expo with a few things a menu-driven UI needs:
- section headers in menus
- optional wrap-around when moving past the first or last item
- control over colours

Colours can be set for the background, the highlight, boxes and text objects
including RGB values via a new video_rgb_to_colour() helper.

Each change is opt-in and leaves existing behaviour unchanged and each
comes with a unit test in test/boot/expo.c.

These are prerequisites for the phone boot menu which I sent earlier and 
currently refactoring using the expo. So it's split out here to ease review:

https://lore.kernel.org/all/NlOWu7YfEood1y_dXWzpWRLsMbAPbeVaGxRJ2tfzoYVnA_cNMxZgfBlUX3nZMgiuOPjZanYAWFkYQjn14S487oMfoRpmTcAaiNKg7jcWf08=@protonmail.com/

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (14):
      expo: Add section headers to menus
      test: expo: Add a test for menu section headers
      expo: Allow a text object to have its own colour
      expo: Allow menus to wrap around
      test: expo: Test menu wrap-around
      video: Add video_rgb_to_colour()
      expo: Allow the background colour to be set
      test: expo: Test setting the background colour
      expo: Allow a box to have its own colour
      test: expo: Test a box with its own colour
      expo: Allow the highlight colours to be set
      test: expo: Test setting the highlight colours
      expo: Allow a text object to have an RGB colour
      test: expo: Test a text object with an RGB colour

 boot/expo.c                  |  49 +++++++--
 boot/scene.c                 |  73 ++++++++++++-
 boot/scene_menu.c            |  56 ++++++++--
 doc/develop/expo.rst         |   7 ++
 drivers/video/video-uclass.c |  27 +++--
 include/expo.h               | 102 ++++++++++++++++++
 include/video.h              |  13 +++
 test/boot/expo.c             | 241 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 534 insertions(+), 34 deletions(-)
---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261017-b4-expo-colours-ecbad5fdbdaa

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


