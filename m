Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2E4CA9EDE
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82F75605DA;
	Tue, 13 Oct 2026 03:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYmvOGm_yU03; Tue, 13 Oct 2026 03:31:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C03F86066F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862268;
	b=RBw4sMgh0OBEfxqz7F9RBsfg6ZaR9rOeWtzVp9++Bj5QRIyJ0AyPZeMg/PkilHHbMJWI
	 t2Xa9E4p2yHwNWtkirWfbn7VnO3s1MK/A5VBSX9LfBBFjsV7xKeJdrzvJB1cJsqjvDqKT
	 eWnu8XOzQObL/mNkWKp7SKb5ORn0zS4gQPGvxmgq4RQRqaRxeZIXUzHW/uDgUPI6IRROz
	 k5AB1nsk8JmUS4N8Lz0hgK478jZNYNZf2uWCE0635vVkXyjnXkBwDuT8Z8Km8OqlbT6CZ
	 un+TEniUST8DtuEgCdxKUYBsHrotVxynyo5Mi+DV4quCgRwAKBtgwIpuV82nlW+kGfQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862268;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ixp0gwcDzT/gOTcIFY6ZgU5UUL8+seL2a4GqUvvZO4o=;
	b=p8Z083HoVFSecpWUe/dWVVoSNflBPNyATj4F6dqU3g86WAkbEvke3uNm84FdwSZ5/rDT
	 gW+5OdJyj5GX0w05H70QCSWnyF+oLJ6XTJsLneRsA/LbmhuG58+mblTJQwbSnES3ov+1D
	 3rkiRdIWrcFV8G6YJUdeO1pk/puNBnuVhfhu/Jl+HOT5xtjSeWJkOfJ51XouwQBwt3kW+
	 iKcBybpHHd/vtVnSGatN0yqL9eMbYrQsDMaDoLD67RZaWjUMWj+b0g5MYguUYGe/64eU1
	 ih83BdVn7R/sxdTbJZEJJ/AezgBrdYh1BEYXHKWe3aEr67U3XoWk0KOYhZG/8YnNKqQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JBWIMLmN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862268;
	bh=ixp0gwcDzT/gOTcIFY6ZgU5UUL8+seL2a4GqUvvZO4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGcFKyuPR1+B1gQ0/VL9+1cznq/TH2Flm6J2PQFymbnsX4AVjGfV9E/fCdzfJlpmA
	 3b00ov+tSWEBjDllls3L+jC/st57MDKn3o3DPXI8mPL6ifOcvFTuKeXLW9/Ce2PQpj
	 eEkdVqYzhs3cK/GyZDvk3CTVr0XIX+4PdQAKBMZkwsV9Hl3QxqLq7/myodRpnmjAxa
	 NFlRb7Wwjj3X9aja+KFSsSPBzd7T1c3YqJJPATTrpw3uDJAemFjgBeDbeKKoBPho0w
	 B3NDSfE+P5z+asfd5BA4FpouO7l4N6xTS1Ad39uEanj1nJR2G226c0EQMlZjeWcsvJ
	 s83dljhd1mAFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C03F86066F;
	Tue, 13 Oct 2026 03:31:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 19B291E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B0756066F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1cUfOfH7qiXl for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AE68605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862266;
 b=E80Tvtb3eJJHWrj3bBQrz3zYtigSt0SBzJEZQOaPD2UsxPufl741Y+VvbiGVw84Lm1oz
 fVyyX4irc2b6r6SDOW5jrJ0ydwyvCZDZ3Ct9PlhPGYL3bUzZX1IrshR856GuutKgzTN2x
 hAIQPj6J8Y7trp1Utyxc5Xft0UMXstwTGonFBcjmpQU8dHCMrVQ/ASiaf+cBqrx7QE6+a
 1xN5OYSVm0Sf5dZ8Wb9/M3blm4EwncDeQlu6nELiJqDbIckhgdW6geNJWZ11l5nZpNwVY
 o/1ktlSUrRd7hLbH0Uf0iVfxzKVrgdOes1L+AZUYbtqcOaONz3BoeM7oWF6NpAhGXhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862266;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=ixp0gwcDzT/gOTcIFY6ZgU5UUL8+seL2a4GqUvvZO4o=;
 b=J263ajv9qUoAEBXEYFGR5vhg6yc9J7uUjkxrZkrJAe48PEyhgTgIao7hrWER+zH9+xka
 5MtKsE7GXvqKxNg1xYq23vulVhLFePUGn9UEvyfCoAf1U4oV4+ES3cjw78AOsrP3IMnoC
 zHU/e7nZIOjVdZFOi3jeeQFzD5Fa+2BDoXhbS6/eVn+68rSMnZV5gbpiTWYZ0vXPRhka0
 JGLwFX8KzUWT/mFWUfwF6lrr5m1bCmq8HAgr/AB4tml6JOA0dadv48uN0iMUUSjg1XBvW
 2O57hABXCnark2YHWQ8yQptGL9OrQMRPOq1ulLLa+lNCGK/MlR64TQ4n6VYIeq3NLIg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JBWIMLmN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=JBWIMLmN
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AE68605DA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:31:06 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so1986076a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862265; cv=none;
 d=google.com; s=arc-20260327;
 b=rb9N8KEzRfIhdHNdO0BcGCPsg/5KlB1P+agNeG+sUX8TAq+M1WVCBBhzt0seP0q17/
 M+J9/PtvCizjF/tD/ompB4ezSr5irqtjfQJh0AG4YpF+95mA8C/qnK5kIurrKXC66miC
 om824MfBCsu56GIyVS2DGm/0JgSop7sDivRM5VDwqlQBuHcmG8zySG7uBus+MsfSaiDh
 /lL2v0gYmJYxrG5Iy+N0agpFo7mD5chJ8Oveplo90hebblj9zDLmhZhw6ssSkQ8B7kJf
 DdMlLcLfT7aJsQ2CT114yf2YZcCyXpkM/IXHEN5Ql19ENwDIKH4GC7IjHMJV4yiqRsvy
 656A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ixp0gwcDzT/gOTcIFY6ZgU5UUL8+seL2a4GqUvvZO4o=;
 fh=n+kXWT8FZtW+7hoJUYnZozArK8yo2Cr/UH60qgzQ5E0=;
 b=X5rlsmtxCYDqvSuJ21KLf97x/fS2duIYXjJRkFsGWx6SyzOyvydDIfPEiP0Afs2Q+s
 ytwT4g+kjS7eISjErqV95DjsXLQZrgrn7jnl5w/oqpkhQn31SO/gsuV95VzanUMOKix6
 m+wrfi23UqDZlp159pjIqL5sQKJtXHSutktoe4h9Gvq+y1d9I4BWyd1+ltHeB3SSA0OE
 F9LqMO7rtONxqo+oGrQlSah7hUtxRxQm6fakRcFc3kfviRagC2yz+cuDu61viqRu35YH
 oAeJpk3njbvJ8aDs+zcX2ycL2Jamg8cxAUhvo4vrf/bhTYul4Bbg7Q/hl1Nbp3NhQ/Yw
 NWCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862265; x=1792467065;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ixp0gwcDzT/gOTcIFY6ZgU5UUL8+seL2a4GqUvvZO4o=;
 b=JBWIMLmNiYVTTtpYkD/lCJ72OH9txypRlepdnXAkSqVT2KqKeZHxsdM0njYv+0Cueu
 y0MppwBKNCXTql0AqDAVW0uMnezfB6Tm/QbkKw/TBspA8hl/Ay5FPTI5YqwYK/6cgstm
 7pif2jkBFw1SYH1tmQBVBjmIjPARdmmqh12e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862265; x=1792467065;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ixp0gwcDzT/gOTcIFY6ZgU5UUL8+seL2a4GqUvvZO4o=;
 b=HQa1pMU1v/aYKZHVHLuSKcNXlF06nusroOIvRFAUvGG/rqVnXWln8c5s+MbBJ1w1sh
 ZLs5xww9KUxJAIsNKBQQfWOGFWuKvGLMQUPVfqQ3zhTu+0qDrCH4cXddBoLNEb22Ccey
 btjxoM/7h07tiyJZQspd9NDVxShb5AcKLjaNbDKKyY/npWtx+kXhDN6Kbgxs0i3j8Ada
 8jJO8dadmqn4lMCnhimWy8vdf2wsqEgul27qcufO9qdULYkCqudD9cXkUKRWoCr5CqT0
 oMTS+qvhCiqpasRCFnU0FppTN3o+K7EA3UAcDktQi48jgf+eJ2Pf8Di4gYqC1J/BHyNQ
 dbFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdwNxn6ap1hG+5BbdU5BwxfkNac6DF/BT0QACe8fKoYqUr5/RuA/UMn/AHam37lPBgoXh/grI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWQI2BiywjCFoto4dh7PKdI6Y/msol5kJ8SaIzsKe4ibZ5ZYko
 TgqLLMi0fxIc8242UTgeV4zFNVgjZSRzDOP2a7zxgv33jUEw8iE2uX1LhIhXnb0+qcXXA8flkSM
 TXdeM+yf2mgpWQrb8ZgToEGzGL+pyRizTaKmYFFOg
X-Gm-Gg: AYBFou0z6WqfjqDexiySl8UnYhQ+AKalgYT5roE/5SWzp4aa/w1WxUZbPtIEbWXPhCM
 87DyR6MN7bQskoVroYJm4bbbjsCzYyQ6Jr6sxyv6MkHCP0oiijsv6yTI6II/XdiCOhluMaqvySs
 G3wNHI8JzD8jcjWTMgY7ueGkT9IpwStt6a4f/dPFVo9sVWiwZk6LEffOvFyZ6Lyj4uuLIb6UNSl
 vZxmYkhbIQ0CBGk3wbveW3zTRo5QPVAdI1Fz2fAEDr/yAhoOfcjL/0k6pwMkDXQ758QSb2MQrRN
 kK6/kI1QNi2OA5eBRgcsozPJgZgPLwtNTLnwQAFoBJEAYeBw2Syp08mkWf+pMBetmug=
X-Received: by 2002:a17:90b:3c0f:b0:3ab:b764:8256 with SMTP id
 98e67ed59e1d1-3abb7649df1mr4024600a91.17.1791862265444; Mon, 12 Oct 2026
 20:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:30:48 +0100
X-Gm-Features: AclHuK8WwdCSGkCMdXjk0bM2LSgGqGD0emanwMKwWErheekLFkiCYylny6MMJE0
Message-ID: <CAFLszTj=uzZkXLhO0Ox1UqnAfF9DOoLc6F13+MjLg5CKNreErA@mail.gmail.com>
Subject: Re: [PATCH 4/9] fs: ext4: don't read time fields in XPL
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: ext4: don't read time fields in XPL
>
> The ext4 readdir implementation populates dent time fields in XML
> builds though that information is never used.

Typo: 'XML' should be 'xPL'. Please can you also give the motivation?
Presumably it is the code-size saving in SPL. Do you have a figure?

> Guard the three rtc_to_tm() calls with !IS_ENABLED(CONFIG_XPL_BUILD),
> consistent with the FAT driver.

The patch also adds le32_to_cpu() to each of the three fields. That
fixes a real bug on big-endian hosts, since the struct ext2_inode
members are __le32. Please can you mention it here, or put it in its
own patch? It is currently hidden behind the subject.

>
> Guard the three rtc_to_tm() calls with !IS_ENABLED(CONFIG_XPL_BUILD),
> consistent with the FAT driver.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/ext4/ext4fs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> @@ -319,9 +319,11 @@ int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
> +             rtc_to_tm(le32_to_cpu(fdiro.inode.ctime), &dent->create_time);

Your next patch points out that i_ctime is the inode change time, not
the creation time, yet here it is copied into create_time. Since you
are touching this line, should create_time be left zeroed, or filled
from i_crtime when the inode is large enough? What do you think?

> dirs->fpos += le16_to_cpu(dirent.direntlen);
>       dent->size = fdiro.inode.size;

BTW, the line below has the same endianness problem: 'size' is __le32
and is used without le32_to_cpu(). It also ignores size_high, so files
of 4GB or more show the wrong size in ls. Not for this patch, but it
may be worth a follow-up.

Regards,
Simon
