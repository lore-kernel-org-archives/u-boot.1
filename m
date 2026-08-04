Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89205C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 02:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 445CC6065E;
	Tue,  4 Aug 2026 02:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id szKXtNh31160; Tue,  4 Aug 2026 02:15:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66608606DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785809704;
	bh=Uc8RCx5JjLParGj7VZE5DLrEcWa7XvoWCiz8+zIau1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KcpScHyZgzvLOcKPHRd8OUbANar7dtCPfpa1pvbro0pc4tvxoidkLY/PopeX6gi9Z
	 MAbR+5202FQpkmR7uL9Ivb1HlmfWkyfe3Z8xIjNZGpSDGc6cidlOogYBMP0wbSNpJA
	 H6Vpzj1pNKyzd3wYIw5qWJSbL/wI5wsNLOKbtk1Qqr2NRFcFrz7c4t6z+PHeHRYsOS
	 J8nP7Z6kDBcTk53WZu0f9E5A7I6hcaiWfifbG6AtfA1yox74kMQJ/bkvH3O9ij4gQy
	 40J4QKyv+cFjITPYA/U3q7BxgAP12kqQ4lTlleGSnwTV1NK7PlmIjfTR4Lr4zAmV0S
	 9kDq0SD9rHnhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66608606DB;
	Tue,  4 Aug 2026 02:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D137B282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF4F0400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:23:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZt_Qai0Mw6T for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:23:48 +0000 (UTC)
X-Greylist: delayed 479 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 04 Aug 2026 00:23:48 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BBDE9400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBDE9400A5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.54.127.62;
 helo=mta-10-3.privateemail.com; envelope-from=elliotjb+anduril@elliotjb.com;
 receiver=<UNKNOWN> 
Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com
 [198.54.127.62])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBDE9400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:23:48 +0000 (UTC)
Received: from mail.privateemail.com (K8S-PROD-WORKER-07 [104.30.160.130])
 by mta-10.privateemail.com (Postfix) with ESMTPA id 4hDZ5q1XWPz3hhTK;
 Mon,  3 Aug 2026 20:23:43 -0400 (EDT)
Date: Mon, 3 Aug 2026 17:23:42 -0700
From: Elliot Berman <elliotjb+anduril@elliotjb.com>
To: Simon Glass <sjg@chromium.org>
Cc: elliotjb@elliotjb.com, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/3] qemu-x86: Wire support for applying capsule updates
 to pflash
Message-ID: <anEvOBzdib3UrhUj@eberman-5690-nixos.corp.anduril.com>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
 <CAFLszTjo5j7w+qzrruYZMXELu_3AP_Gt3wbneDiFP5-imPgNCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTjo5j7w+qzrruYZMXELu_3AP_Gt3wbneDiFP5-imPgNCw@mail.gmail.com>
X-Mailman-Approved-At: Tue, 04 Aug 2026 02:14:59 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785803027;
 bh=BwECjt5ExkHnt8MlNQraMBdbN/G+H3m/kCfd8bf9kdo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bv7V8gG0POjVaZg9C/d1mJZtaXnAQUXEORklHvBYsOlFFlkyRwTbFSVHu8aXVqNZP
 SQtVZumDpdR0jrF4SrVs8aTZ9ZBurK+YeisbXudqpPvzZ6Z8RkHS3n9ZLxohZG3eSv
 gFsRX4MvEWEpSAtZm44PWy9/SAUiV4RIeWWX8t6f32mhYSX7BCMfux08dgeTvzE+cO
 qJEvTyFI5zNdnMLFTFYH3yvqF/pOa0BUdUMS/biQB+7vhLojU9l/tnk+EzFh3uDw82
 WNJPEgana9rDtKjqkg+wcvZcW9Lc6MU0q1dYd6iGqF3g9V0J8tzBdnmFzLxgb3PGiw
 l4M1G8k8uiwcA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=elliotjb.com header.i=@elliotjb.com
 header.a=rsa-sha256 header.s=default header.b=Bv7V8gG0
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Aug 03, 2026 at 01:25:32PM -0600, Simon Glass wrote:
> Hi Elliot,
> 
> On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:
> > qemu-x86: Wire support for applying capsule updates to pflash
> 
> The other two patches use the 'x86: qemu:' / 'x86: emulation:' prefix
> — please make this one consistent (e.g., 'x86: qemu: Wire support for
> capsule updates to pflash').
> 
> >
> > Following the flow used for qemu-arm64, probe the pflash MTD device
> > and set dfu_alt_info/mtdparts for qemu-x86 and qemu-x86_64 so EFI
> > capsule updates can target the u-boot pflash partition.
> >
> > Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
> >
> > board/emulation/common/Kconfig         |  2 ++
> >  board/emulation/common/qemu_dfu.c      |  6 ++++--
> >  board/emulation/common/qemu_mtdparts.c |  6 ++++--
> >  board/emulation/qemu-x86/Kconfig       |  3 +++
> >  board/emulation/qemu-x86/Makefile      |  3 +++
> >  board/emulation/qemu-x86/qemu-x86.c    | 38 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 54 insertions(+), 4 deletions(-)
> 
> > diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
> > @@ -24,5 +24,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
> >       imply VIRTIO_NET
> >       imply VIRTIO_BLK
> >       imply CMD_SMBIOS
> > +     imply SET_DFU_ALT_INFO
> > +     imply SYS_MTDPARTS_RUNTIME
> 
> These are only useful when EFI capsule updates are wanted. qemu-arm
> gates them by putting them in a separate 'if TARGET_QEMU_ARM_64BIT &&
> !TFABOOT' block that also sources common/Kconfig - please follow the
> same pattern here.
> 

I can't guard against EFI_HAVE_CAPSULE_SUPPORT or DFU since it causes
dependency loop. I believe the config guard is set up because it isn't
(wasn't?) clear how to set up capsule updates with TF-A? Is there a
Kconfig symbol you had in mind for x86?

Thanks,
Elliot

