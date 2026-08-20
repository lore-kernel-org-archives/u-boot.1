Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAD6C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B482480C13;
	Thu, 20 Aug 2026 07:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAYCXelqtNKg; Thu, 20 Aug 2026 07:38:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787211525;
	bh=g3/+dI5R1LuUcEdJtLO1rxW3idVicyKFtfeOY9fEnNc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yhf0o8Duxcq5NtzWI1ySfDB6ngZVQnAohtCOM3QKXaDocPxJNaQRkAjfVxFtPJhfv
	 vqZFuTFZF+IQc25MQCbvfqYrvXJ7IjnMaFtEEinfc/NowXuGB2v69gYiuX0QwVwji7
	 Umloud3fKoWuBilqasECkBGdmZUxi0v2vIfVrWgLAyLueIVy4l+GW9uXK7L+q8ci64
	 Xw6l897Y3dMirmZeYJoLaSN8/nenaNFGtVoYDO55ft+ziFhxAg6ayVL677tViYi9xB
	 /hPLgaKVyr9vzAitinkJAxqayh3a6WDnzzxXpGdfj3Vv/C0/adKiUvTyl3SF7JQM1X
	 DMqIH4OgLEIAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEAD480BFE;
	Thu, 20 Aug 2026 07:38:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73B511B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D12140253
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Irx7eRFOkEqU for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:38:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HtU+PCw1
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8898D40074
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:38:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 569AD43B4D;
 Thu, 20 Aug 2026 07:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CC81F000E9;
 Thu, 20 Aug 2026 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787211521;
 bh=g3/+dI5R1LuUcEdJtLO1rxW3idVicyKFtfeOY9fEnNc=;
 h=From:To:Cc:Subject:Date;
 b=HtU+PCw11F3YIGma1YnBxzEYlBcwyWzq8giXU57jr05dVH+uyeXUBW60YUltf3kQB
 m5m8almie1oCwfgrZDgVRUxlsLOxESrEJdQTjUbNTWtUKu6h8dttFZRx134a1yIX6w
 XXglQZ4jw6s687Gzvc5+Xy2LQwZZs5O1Vq/YaW97EbpG7tClRw+lNy7vLU6CkXxn48
 bmXcTifQV+xEn5kq5S5TaTWw3lRe0wsrEc4P6gUykfFORbquxU7D6dPEBcYgQ+Zcur
 AJMcYMhqXz3c5N4ap8Ufvnt0zhBrdcTnSBLp1A3m2upvcre+VrXclly1XvBziUr/0L
 POxnk7rsMzCiA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Shahriyar Jalayeri
 <shahriyar@byteray.co.uk>
Subject: [GIT PULL] Please pull u-boot-dfu-20260819 into main
Date: Thu, 20 Aug 2026 09:38:38 +0200
Message-ID: <87mruhgs1t.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Here is a PR for main with the following:

Android:
* Ensure boot image read is bound by partition size

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1015

Thanks,
Mattijs

The following changes since commit 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5:

  Prepare v2026.10-rc2 (2026-08-10 16:43:34 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260819

for you to fetch changes up to 35432ef6fe2c79ab72709966e64815a45eb55c76:

  bootstd: android: bound the boot image read by its partition size (2026-08-12 09:46:11 +0200)

----------------------------------------------------------------
u-boot-dfu-20260819

Android:
* Ensure boot image read is bound by partition size

----------------------------------------------------------------
Shahriyar Jalayeri (1):
      bootstd: android: bound the boot image read by its partition size

 boot/bootmeth_android.c | 8 ++++++++
 1 file changed, 8 insertions(+)

