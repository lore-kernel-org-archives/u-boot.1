Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3700CC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 15:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402538798C;
	Mon, 29 Jan 2024 16:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="Ajzsfe0/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jwdBUqfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7CAA87B77; Mon, 29 Jan 2024 16:27:04 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6898796E
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 16:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Mon, 29 Jan 2024 16:27:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1706542022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MatagKLoO6qgnLRagJPEzSfB46ttB5qGrkhT/5Nhegc=;
 b=Ajzsfe0/GJgXto/9VguzR8GLF2/m0J1FyYVuOvsAZ4kjuzSpA/Ip7xNbl9vfTbLqVy3QcG
 iDoM7cZwdxsqkDjUfDb9ckEPbDX52Kfjs3C/Qt0NMCL1ELk1SEm8FFEpQfm0omoIteXjvr
 UTlm9u1wyuW/3ZEW4jVnwENGrDvWmcfyu6paMSpyjXLMIvWYSNiD8gGtEdF6bx61jXIQt3
 yX7omOPiQ/7OfzO74OCT2zvh4zOpmV/3akGxq5yY68h+jvis0aUxeYoE6kK382yDaWR6EJ
 s5EjDM5p1fOdMCiFjK/7rlW/Ajp0LPkBC52lKllYcX6uQLmtpCD4DlZcVsJ+6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1706542022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MatagKLoO6qgnLRagJPEzSfB46ttB5qGrkhT/5Nhegc=;
 b=jwdBUqfo5UDV9jh6Xx0WJ5zXa7fEqJRREiwvNvk+KxNxaeDO0WAqkK2mo4LMbIeEIcFJvN
 QFgz5EFA84oz+PAA==
From: Nam Cao <namcao@linutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: agendin@matrox.com, u-boot@lists.denx.de
Subject: Re: [bug report] cmd: mbr: Allow 4 MBR partitions without need for
 extended
Message-ID: <20240129162701.781ed3d9@namcao>
In-Reply-To: <5d4ac31b-37c4-47dc-9a3b-0ca4fe29baaa@moroto.mountain>
References: <5d4ac31b-37c4-47dc-9a3b-0ca4fe29baaa@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 29 Jan 2024 18:18:03 +0300 Dan Carpenter wrote:
> Hello Alexander Gendin,
> 
> The patch 04291ee0aba6: "cmd: mbr: Allow 4 MBR partitions without
> need for extended" from Oct 9, 2023, leads to the following Smatch
> static checker warning:
> 
> 	test/cmd/mbr.c:243 mbr_test_run()
> 	warn: sizeof(NUMBER)?
> 
> test/cmd/mbr.c
>     233         ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
>     234         struct udevice *dev;
>     235         ofnode root, node;
>     236 
>     237         /* Enable the mmc6 node for this test */
>     238         root = oftree_root(oftree_default());
>     239         node = ofnode_find_subnode(root, "mmc6");
>     240         ut_assert(ofnode_valid(node));
>     241         ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
>     242 
> --> 243         mbr_parts_max = sizeof('\0') + 2 +  
>                                        ^^^
> You probably wanted this to a readable way to explain that we are
> leaving space for the NUL char, however this size is 4 not 1.  (I guess
> this is from type promotion?)

Quick google search told me:
"Perhaps surprisingly, character constants in C are of type int, so
sizeof('a') is sizeof(int) (though this is another area where C++
differs)" [1].

Quite interesting, TIL.

Best regards,
Nam

[1] https://c-faq.com/charstring/sizeofchar.html

