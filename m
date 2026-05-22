Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2313CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9938A846F1;
	Fri, 22 May 2026 15:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="T8uAlwc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3BBD846A4; Fri, 22 May 2026 11:44:06 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70431841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 112121A366E;
 Fri, 22 May 2026 09:43:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D97CC6003C;
 Fri, 22 May 2026 09:43:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0BABE107E8CBF; 
 Fri, 22 May 2026 11:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779443038; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FwxvcR+agrm+I0iWugf9utgYsapfzm6mNNsS5LvoQOw=;
 b=T8uAlwc+a0mBXqqHapxmpIEusFhu5BUD0qhUo9Qk8iI2T5AKoyD7RFp3Kb4Oo3UPnOrvG3
 bZKCpdkM+XXxmxY7eixfs8ubkGzXH8sQ591Q21YABYawyJ6VlWFStmpSUwgeJl4a5WCuQY
 PJiEUwPGFbgETpWfoj6nRwbOpLlhTsgK2lIo6AZeeqI9GUqEW3EjL53jMFLOmpTCrS8GMO
 QFp1yAwOEh9ChFzQP8ThFgeP1E1QPp6dWJpIT1YZpQ/nbVhwV0IqYrkxR7A4m8iRwNv4W9
 YzGJ02FHbmWx0JnzFuvP/j9c7S31SggwhNwFZxngXfhYdbQlD1FVyOkC6rlujw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Allan ELKAIM <allan.elkaim@gmail.com>
Cc: u-boot@lists.denx.de,  Joao Marcos Costa <jmcosta944@gmail.com>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Tom Rini <trini@konsulko.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH v1 0/2] fs/squashfs: fix symlink load failure on large
 images
In-Reply-To: <20260514181854.399679-3-allan.elkaim@gmail.com> (Allan ELKAIM's
 message of "Thu, 14 May 2026 20:18:50 +0200")
References: <"CACgNL-F2=KJtZ+gThpx_BuWsn6puqFxK0uLOmnABSS9=rRQmeQ@mail.gmail.com">
 <20260514181854.399679-3-allan.elkaim@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 22 May 2026 11:43:56 +0200
Message-ID: <87jysvpyn7.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
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

Hello Allan,

On 14/05/2026 at 20:18:50 +02, Allan ELKAIM <allan.elkaim@gmail.com> wrote:

> sqfsload fails to load a file through a symlink when the squashfs
> image contains a large number of inodes (e.g. a rootfs that includes
> the tzdata timezone database).
>
> Root cause: sqfs_read_nest() resolves the symlink by calling itself
> recursively without first freeing the parent directory's inode and
> directory table buffers. This causes a temporary double allocation
> that can exhaust the U-Boot heap. When malloc() subsequently fails
> inside sqfs_read_directory_table(), the error goes undetected and
> sqfs_search_dir() is called with a NULL pos_list pointer, leading to:
>
>   Error: invalid inode reference to directory table.
>   Failed to load '/boot/Image'
>
> Patch 1 fixes the structural problem (temporary double allocation)
> and plugs the silent NULL pointer path in sqfs_read_directory_table().
> Patch 2 adds the missing return-value checks on sqfs_dir_offset() that
> turn any residual lookup failure into a clean error propagation.
>
> Both patches are independent and can be reviewed separately.
>
> The bug was first observed on U-Boot v2024.01 and is still present
> on v2026.04. The patches have been tested on a Raspberry Pi CM4
> running U-Boot v2026.04 (Yocto Scarthgap 5.0.17) with a 325 MB
> squashfs rootfs containing 22 517 inodes. The symlink
> /boot/Image -> Image-6.6.63-v8 now resolves successfully.
>
> This series addresses the bug reported at:
> https://lists.denx.de/pipermail/u-boot/2026-May/618533.html

I haven't looked very deeply but changes look good.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

I am adding Richard in case he wants to have a look.

Thanks,
Miqu=C3=A8l
