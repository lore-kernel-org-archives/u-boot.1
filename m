Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05241CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 14:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0E27406F2;
	Tue, 29 Sep 2026 14:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7wbW9tkaUwh; Tue, 29 Sep 2026 14:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D16940733
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790690457;
	b=PiM/mEc8m4ICpjueitQeYRIKhMRKBbce0qB17hkahybq4EVn2YjKLoNoVtIYbDWo6/uc
	 hZoQNiAiuWhFfscMni1ih3Ugno80qHaG8LnZ4tv9mlo5OA6LspYNIq+NAQdowWXNDb7C9
	 gJt6MSAa5wrxK58T9+F7OmDnsdiVSCvYde7cG63rnwsc69yjgfZn86DFmFb5iJji6/GRr
	 6h6BqjXeQR0BdBeqxg7DY6jevCF0qrD58sAIIgU8rkz1tSGpCPs4uX2j0atom/PjQFc+N
	 zuRrqvxRoaDw35NCEWqB24Ho4Cs4UbszOfdQ7AUeGLhaOyJFyjDvuG8XLWMCkDLqzPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790690457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5nSlcIa1vtaGdb5/YNwb/PW22rouAdtpYQhs6LKeAt0=;
	b=D77UT9IGsixPqpGHeEomt6v/LCopv0B8vqZVLN3WTKU4jOWuAM91uYxqFh+g3Yv0zGik
	 e1hS0gj4e/RmsTjR3b1iOCKZMjy8KD/wCeFcXSznZfjdkalgKCL7+PwNfbgUtaZpgYbcK
	 iEdZtVIARC2wovap7AbvZLba52JJdtMf7qyffNIvFDTSckhyuQM2anaWHM9Rf99lzEtyq
	 PfU3MVXunwj86Z3OQ14krv47pt79+n3lze+xkGVIW/LNp4UOZM9znCTGIGtBHmlWzZtW3
	 lH//YLIgBhebkMjaQsKoSDJP7RQXggrLJmhacbbDbP868xGnYCNYdkvFaKY7UaKVNtQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790690457;
	bh=5nSlcIa1vtaGdb5/YNwb/PW22rouAdtpYQhs6LKeAt0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mtilCmo3pGFdIP0fdWC0KhXIiTGHYF6Xl1BBL+pkPvymchO5/xF30eqFnY0zurCq/
	 DzMobzSfmCEdgLEDGO0Sj3W7hHtO0JWzCoAGLXYTGJBgIsGckcJg/LC+McAgAtNGI0
	 Q5RVyqW4CncRl1wZKYuvxn45+48ZvVbTycocJGYU6rV2Wl7VJtlGtrNdWbm/oT0Cem
	 XCQfIXn5u33GbUM2vGDNTiqytR9qPYV9LmJZVTsdEZIBravlq607njhsYPd7giCBHG
	 6dtuuM0KRoNNBKHWVnzKpNJuxgE3izpMtSBpzz+ulT4dY+BUj1KqDI8k2tfYxfgIGL
	 yYMA3uTDHKdMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D16940733;
	Tue, 29 Sep 2026 14:00:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B4A16D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 14:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A57CD60782
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 14:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9nbslvN1nGu for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 14:00:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E33146071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790690452;
 b=bhj1p5AJL8VrJFwJ+W6G6bSr5BflQ4EXVzGIAU8XJctruPW/+WlIuHQp9a89xyec/2bQ
 nXOM8txLNS4gHub73iYRO21NSs2xDqCBtgWG5IDypIgVX/T2cHAplVwxMcKEJMTrRwCmR
 sBsM2/DIlqSPYiEJFeuKsQNzD6TqS303WhCbzlrhqwM7X7UCOFhLj6LQXON9VtG4cxWFT
 pqBidjPHmFbLKDOlg/svCcuvoH823ObNsvnFXmGsSndlG7tO3yHkHaZv61kaainKl2vWK
 VGOPeBv2g0QFM6Vf5ZY3ZSNsmui7KIQBUcvoZYQMJwgrmElgtUeftaBrcljjFfil2+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790690452;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type;
 bh=5nSlcIa1vtaGdb5/YNwb/PW22rouAdtpYQhs6LKeAt0=;
 b=hz/0eKajcXKvEbBjmo1e5ZgRZuB2aB/rvMoHGN0ApH7mSbM8uUw3rELVKktKFIsJ+WY6
 4i3FXVgCZRKNGr3nfsrQF2Ps7VXUHiAOvuRIRp9ValH+Gpzt5iTICqSseaImlR1UOcr1L
 r2Ogg1Eq2QY1FsU6ez3fG1wF6hcyNywuYUrG3nrA/1hHNDYVrgBCHj1VZwVQDj3+Wp7HM
 7Tn4SBhDk4+esMwGYQzDTQseo5e447KTTEwBRjvSmvqJXiJEWDc85jA9X91ByvtZyrzfd
 5SDBRJZ2+31TFj79xLAHk1+8bMRnB8ayxC4vtrkKfGmidCeob1ayrwjPWKtir7o4KYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="XLxY/5yr"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XLxY/5yr
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E33146071D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 14:00:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99D37438E0;
 Tue, 29 Sep 2026 14:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED21F000FF;
 Tue, 29 Sep 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790690450;
 bh=5nSlcIa1vtaGdb5/YNwb/PW22rouAdtpYQhs6LKeAt0=;
 h=From:To:Cc:Subject:Date;
 b=XLxY/5yrZOzpIvLTMWCgcgm+9f/GnAENNCt8NCEqz/7mczJJdLZuMCuCDLeifeDgV
 M7mrfOTOXEQYkoGh8gUST/aDp9/v98zJfm8H29Oi/A+zlf3DBoFI4paiuMrW9bOpoQ
 Vy9hjhm9+HeYaQhqhPzmhHtD75LsLpB/o2XDEWhdZ+Nmiy9VcT/T+3T08UabJUaceE
 6fOiH666kon0VHwWUKB8uNt8MB1xgVIVxGK8j9r8cbmHeCgX3MXQeT+SWMGZpssmmJ
 l0TPGzjXKyfrpe/snAlAcgS/4yifZq47A/UqFu1bUaeFJ/9IuyKLbhs4sGq8rCcRIJ
 +i1KHS70gl2fg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>,
 Shuqiao Zhang <stevenjoezhang@gmail.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20260929 into main
Date: Tue, 29 Sep 2026 16:00:48 +0200
Message-ID: <xhkdbqzicqhrj.fsf@mkorpers-koolstof.csb>
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

Here is a PR for main with 2 very small fixes:

Usb Gadget:
* usb: gadget: f_mass_storage: Synchronously tear interface down
* usb: gadget: rockusb: terminate full-speed descriptors

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1398

Thanks,
Mattijs

The following changes since commit a06e89ab05eaa2b8344d521319399333cd760ae5:

  Prepare v2026.10-rc5 (2026-09-21 16:12:01 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260929

for you to fetch changes up to b49d784c2346c0cd84330fe11e0a1a5edb674a67:

  usb: gadget: f_mass_storage: Synchronously tear interface down (2026-09-25 15:57:54 +0200)

----------------------------------------------------------------
u-boot-dfu-20260929

Usb Gadget:
* usb: gadget: f_mass_storage: Synchronously tear interface down
* usb: gadget: rockusb: terminate full-speed descriptors

----------------------------------------------------------------
Marek Vasut (1):
      usb: gadget: f_mass_storage: Synchronously tear interface down

Shuqiao Zhang (1):
      usb: gadget: rockusb: terminate full-speed descriptors

 drivers/usb/gadget/f_mass_storage.c | 8 ++++----
 drivers/usb/gadget/f_rockusb.c      | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)
