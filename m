Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2290606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kBY9Dm2G;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uvfU+jpY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4F9D40805;
	Sat,  7 Nov 2026 09:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QAQtK8QNn8pf; Sat,  7 Nov 2026 09:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EB0740879
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042159;
	b=l3ocvykgJxD11EpMpAJW1e7+zCkBlCNX8ODprTOoG+sU4VXEMPO2lsfc/vBf67EJTFoj
	 KFtYAm00JhFbLnwl1ayuVPK/vVGXckfArNkR9ABIam8P7gaiovJgl7bxgF0CBbEVslYFk
	 NJP6tY0nz9ju0LSZDroNaz+O16Mw9m1lkpn3SSrb5/ErcDjRZYzu/DtD2okZoaxdbB/R5
	 fclbh0uW+It4a/cnu6Dn69Aqv/aMM1Qn4UyekSbprF8R6mIAPbmVb3ywr0VLraw2nJVFh
	 4WqaNcKtSalOqDazlhyxeYY7OwlYg7Qzo0lgWnhk88O2PnMIB9jfE6LnvuctZ4JpDRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7iWY1v5clrg5hArIA2d/bqkJJ2fNSRJBFeZt6iYPe2Y=;
	b=UGfhiwGATQsSwg4mrNlNj5zL/Vx2XwjZWgLSWvoo9t3I+ofKw7wLA96G1yUG1nfg60+Y
	 tgwcwTjBhztbuWA9Vrm1S0b3S17lZ9Ll6xtb4x9zr5iq41Qf2cquqi53ZYUkKUwzPGPkQ
	 lW6HPkqVCBkkdlgaBwSQ2W6+YmdzUw7JS18UhyCO61wPwEhS6bpQHc+Ry9i3lrwJ4aa7/
	 iQ24upxfolzZ+dEJcF4DH0b6CWquYtjTqqefV2N5ZWYr/oifQJO/KtlPWZGmcU5pjatv3
	 btIA/qcDJC+r+Wa9F6jC7XMfojwehHFpWADdbiucWSm6UlcFo5eRwzcHrjpwuvcw7wg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=uvfU+jpY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042159;
	bh=7iWY1v5clrg5hArIA2d/bqkJJ2fNSRJBFeZt6iYPe2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kBY9Dm2GnZdYQ3evjc59PxB8/IO7w9vwOVmjFzuBNSQZ/cf5C7M84tWiAn3yOGieA
	 /wilPiiqUP0AsxrHVIoI980p+J60SoABA+vVGgHcDEabVbiJYB9+Geir9NY2ypYs0u
	 ay9GiHKyijV7h10QwSO1O3VzKdBK1YcpMGT0wsBx7xTCU2WQFj7gz76R3ser3p+HQJ
	 kPNBVMzX+D4AavmbogvUVNmHqyw6+teaEjSWAmIY4PGJrXHsdFBSVGf83cflaU7vgc
	 xoCX7fRfQTdM7Z+WpWaRA+q4XiJOQOrr4ntAz8rhwi07yOmfOMg1EEphT7EGpff30S
	 /Oqr0/qN0Fpmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EB0740879;
	Sat,  7 Nov 2026 09:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD7F834D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF559407EE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySBqMOM-SIXM for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED68C407ED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=uvfU+jpY
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED68C407ED
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:25 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jM96N4k1MzKp1J;
 Sat, 07 Nov 2026 10:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7iWY1v5clrg5hArIA2d/bqkJJ2fNSRJBFeZt6iYPe2Y=;
 b=uvfU+jpYvNxDhvZXci/6nN0RrbGG6mAH2/ZSP8XV/16h+QuQXjAvTHzNToa3lQHdG0cDko
 k4lb4QkchA6e6W6OuZD9uDOpc5dajXqx+NWSrKEdo5WV1hBDZYL8G2mNGsdMLmiJU54Y8L
 zFHut/6qlAYzExYwSlOs8fAncp8oeSoP9pH8ciNhhmsSuoOLXPcuI5HJ39m5/Hc4ezjSwV
 DnWM0Y0iljtZSz5kaPYX36d7T4phnRvvHfLlVgiGc7m8Rfjuh8jYRhHFZEBIn4oFRFUa5D
 DxbTYkTRIOkLflhkWnGwh/P4Ds083BRkYmy+MyPN0+OJGhAhwHeldddqTl7oYg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v4 3/3] board: qemu: arm/riscv: Probe watchdogs late
Date: Sat,  7 Nov 2026 10:02:06 +0100
Message-ID: <20261107090206.2015512-12-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <f2b9184f9b2977824a978ff5a5e86f66b7c5010c.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
 <f2b9184f9b2977824a978ff5a5e86f66b7c5010c.1792320756.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: x8g9syhkgray347bhywch45rbwpgpmoi
X-MBO-RS-ID: a09033d97c85f6db7ae
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/26 12:52, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The only watchdog QEMU offers us on non-x86 virt platforms is the
> i6300esb. This one is PCI-attached, but watchdog probing will happen
> before PCI, so will miss it. Redo this late so that we gain autostart
> support.
>
> Deliberately limited to contemporary ARM and RISC-V.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

Applied to u-boot-watchdog/main

Thanks,
Stefan
