Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA395FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B21484099;
	Sat, 25 Apr 2026 18:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CwyRPLqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23B384150; Sat, 25 Apr 2026 18:12:34 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D65840D8
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so27013345ad.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777133551; x=1777738351; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hH+q1AatAPAVGPpj9G0H9obqACTILNY9YwK8JSU6XMU=;
 b=CwyRPLqS+YSYwjhH3QF5XBQVLVCY8Jd7uQ55kZ3SQpHmr9O94hqOwUhZEEyrAHv0Cr
 mLr5xzOwSrBmWtxgY+D+uBa6kq0f8hWZ4O2Y61ruziWwv06YVTSdMy9f86DEnkkE1ueu
 xiKlUq7vWlv4OT6VrAZTPCQLP9d2s4MusKaPWjPXoWBBSFd+VzrI/2oNpCZX0t1VUtId
 25cUrBHWi7fNt8PAO9dxFrN/xXLh90794GLIwD0GeiIw6pt+DysXwMRNpHBX8JMzdJEB
 mRs6phypx9IVZOjqJPhj33JumTQJwlapsEi6d/4oDBn20XYXvWs6VXajz9F9hJiXQSyf
 j74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777133551; x=1777738351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hH+q1AatAPAVGPpj9G0H9obqACTILNY9YwK8JSU6XMU=;
 b=EaWQ+Mrh9WgNQtMn5QT+OPuDG5H0dJ0vQZndF8ZFgle8FL2ywsEhtCWiShSzPVUESN
 pA+2JoJzuRZKQtnwCWNMbJAZTM8VHulk+HJpbPCTvRox3KAQUACexN8I3LJSZB38Hbt3
 KhTdZHJYeGe+QwRlSt/EhiVKOCAQPrStRXByK/UsqJWBOoiKp9qjwus4OokzHdiZ9Txq
 ZEVGkIPVQW6wokETbMrZ21llnK3xB2LDuWbD2crPeSgQXmafAz7/sUk4qC4lfnbBI2+P
 SElk71ojpWlCKeMzlY1/0Q6zazWc5kkI67z9OmF44nnLCJTVz0lw08J6ACGuV+KQOaZ5
 Eu9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pegcen7rwZHptn0VAYHxoEFxLXKvsCfnRCAhLyDEvV0MJ3Ld8e3MZaIlExj5CWdM5MmlqyM8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfxy4e7LQqtmChbaBFvYI2LL3zZawz9tu7NAbFI6TUP1URyMyh
 ++AFGsFO/dnB8vumwIS06lIiiMf37WnO/fkOgl3poj8kTjrbvH2t46JTr1labQ==
X-Gm-Gg: AeBDiesBLZSTWjwpvuzCN6pcp75+6kwu9B3Ti3eM20YV7gCntyj8VNuT6KyS0ANxaEa
 qq6/evguIH/neMnwdWW09cXyhpVsz9WIARhKwbZ6Kem9fdJPZmB3AzC95qPTdda5FBV8+BX/TnH
 cZsC3hxquTniTc2i3F3ROmJLrs1CCqPjEyg3BMCpkItAG1zqukXVudrJIifII5Ecot5bX6Xlffa
 QS8oJ2NWDgf3oUBxPxKkTTrKNYw1OggUPv5TtP2fL+7ORU2CEEsqGkDzl63N4Tz8d4MK5hsrKbv
 itPjcbUEyoDRoTIjMI8gKKM6WVX24WnagWg+LQhYGOCWq3zJSTV7aZ8d6OFaaOx2Ot2lh01sQt6
 btEqsXMVBe765mhNTXsQJH5u71wAUvf6ALT40UIFipX2s3ojRgpmZNuP57in67i0OKASaOaQLbZ
 4L4kgiD/bEkoEwhmNMJNAbsXxUkCd82Kikqz+U1IkePTypgtBHPkBorPOqJKA9tsJMDHd1zpriw
 us=
X-Received: by 2002:a17:903:fa3:b0:2b2:53f5:4627 with SMTP id
 d9443c01a7336-2b5f9e64dd5mr398545935ad.4.1777133550789; 
 Sat, 25 Apr 2026 09:12:30 -0700 (PDT)
Received: from google.com (61-230-36-6.dynamic-ip.hinet.net. [61.230.36.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab32cfasm331394895ad.69.2026.04.25.09.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 09:12:30 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:12:27 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: jnhuang95@gmail.com, angelo@kernel-space.org, u-boot@lists.denx.de
Subject: Re: [PATCH] fs/erofs: Fix build for m68k
Message-ID: <aezn6_Jpj1RG-RxF@google.com>
References: <20260419100123.2427364-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419100123.2427364-1-daniel@thingy.jp>
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

Hi Daniel,

On Sun, Apr 19, 2026 at 07:01:23PM +0900, Daniel Palmer wrote:
> Currently the use of roundup() causes GCC to emit a reference
> to __udivdi3() on m68k and we don't have that:
> 
> /usr/bin/m68k-linux-gnu-ld.bfd: fs/erofs/data.o: in function `erofs_map_blocks':
> u-boot/fs/erofs/data.c:81:(.text.erofs_map_blocks+0x126): undefined reference to `__udivdi3'
> /usr/bin/m68k-linux-gnu-ld.bfd: u-boot/fs/erofs/data.c:81:(.text.erofs_map_blocks+0x458): undefined reference to `__udivdi3'
> 
> We could add it but since unit is 4 or 8 we can actually just
> switch the code to use round_up() instead and not output
> __udivdi3() in the first place.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  fs/erofs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index b58ec6fcc666..95873846f62d 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -78,7 +78,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
>  		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;	/* block map */
>  
>  	chunknr = map->m_la >> vi->u.chunkbits;
> -	pos = roundup(iloc(vi->nid) + vi->inode_isize +
> +	pos = round_up(iloc(vi->nid) + vi->inode_isize +
>  		      vi->xattr_isize, unit) + unit * chunknr;

Since round_up(x, y) requires y to be a power of two, I was wondering
if it might be worth adding an assertion here to ensure this?

Additionally, a bit further down in erofs_map_blocks(), there is
another instance where roundup() is used. I haven't checked the
generated assembly, but I'm guessing it didn't fail because gcc was
smart enough to optimize it into a right shift? Since erofs_blksiz() is
defined as (1u << sbi.blkszbits), it is also guaranteed to be a power
of two. Perhaps we should replace that one with round_up() as well, for
safety and consistency?

Regards,
Kuan-Wei

>  
>  	err = erofs_blk_read(buf, erofs_blknr(pos), 1);
> -- 
> 2.53.0
> 
