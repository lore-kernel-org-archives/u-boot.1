Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D8CA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16BA381214;
	Thu,  1 Oct 2026 01:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcMkYb04gDEy; Thu,  1 Oct 2026 01:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 572048121D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817617;
	b=PjaQUTDFQ4XMvOg2GdOiJoKu+YUO+sFS4OYzGsgEyVDMj7S/KHHTvNGbSSuO3WsPJwT6
	 nilOjR3dTiFKIWlwD2i2r8H3QkBiqKOi45jOlWXyTnzjyMKsKh98mlX0etBPicjbOhkI5
	 yx5Uc+M60PKx8qiMZzAAJ2Kbov03xZVxx7Jj1TNTT0HQLvBH5QugKl2N1raMermyUiTvG
	 TtIeM2nnwg1A68dAfnLqwgnctszkG8F4eUOs9kPoD/+41qLgHio6oGKcRc/789ZTAf3TS
	 2G9ZpM6ZvjJKRAXWGrV6ilnZ9gmYkKPeMecBTQ4ig15E2FJ7y4lPC/ch+aupEF36ojA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FT9xBhmSqZJeO6o4/P1ecDneLCCrplFEqmwfdZ0SEOE=;
	b=aWf47BwEzr2F2uz2lq/04f5nEuzUAI+6I1JMJAuBZRJUawgSiRjyJkF7RWJHYritx01a
	 KkPopLl74SQNim/qZT9aiP6OITGDJyVO5osnTrD7SU16EfC+9LgKzZ8xWn47OIO7Rsf4+
	 x7mpI4QWox+24F+Dg9fQjHWxfbjMUeimdVawVqMxDCTDzpeXXxBw7HoC1CHXvMsfitz0y
	 II4YTvCDVoSKmimHqb9sN87AH02e49FlHRE1Xm+aC/HFnXHeL7pKcku7RtHNFpH94pwlZ
	 psFgYqeB6Q2iFQ+kGa/sCos4UCnulpoXuugcfGXZHVv2/4PyuH6jc+Igc3/43qVoYyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pIN9SnoH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817617;
	bh=FT9xBhmSqZJeO6o4/P1ecDneLCCrplFEqmwfdZ0SEOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMyKK91TGbjtgeZ6Ms5lSk+MKXIYtL76rX/uHz7SGmbYzdv3hz4yJyRr7LAJ7MnqD
	 haEf+Fl8Ksf6OzuFwKsL0UouKb1lMPduH5jd3lfdHyrq9qwzepkTDFTVqQri0ttIvR
	 yrDPYP3apx+LcdYQCOFSgY7sm6ZNJzGgMisw1rfRB4xeelipuLpd2o/YuY/zFb4eOU
	 cYL9Of7cZnjWKrfpjW3HuFQ/25sfwEpb1A7Y3VLkw6OWEBVpSewLEaYbJpFkT4xzTz
	 qG4TnwJxkN7f4c5umYAzdzXEZS0kQjzElknsOgQq1y1GXbKuEhBsiKWVFRn3k4fOAm
	 Mc+gRqQl3fUHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 572048121D;
	Thu,  1 Oct 2026 01:20:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EA931FE4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6082E81214
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8Yu9q_QVxSd for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B1328811F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790817613;
 b=P1mpHzo8lD6xUZm4f6iG9WOc8FNX0vAXMMjZjwsclaVPxopRw1a0OawXIfwlf4tvM4Gu
 cInvVzdUHMfhDAybH/lFhfLbiI9//HqPcwcGgZeIIpmsg0Mco8KJFBpwH7Hrb06KxWPG5
 +zxdPivbip/UUm00PzfAXrKg/K8moYBXH2nYhV8XYmkUBrkSvTQG9ZDpyxebYqJRpaf33
 27YL0X5MPMNeza+1azRbfOXOzqvQAGKeX1xfjQnQm+AXK1WLAAgjS6glK15CNWvK+Dgo6
 8H42i2O3qUvt6AvughdX8r3fYr/xL33MHyt//XJl2syR9ssxzb9nIY7BZ5ZBnv9/d4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817613;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=FT9xBhmSqZJeO6o4/P1ecDneLCCrplFEqmwfdZ0SEOE=;
 b=bvujy7jSaa1mPPQeWyAxd/mZhFJq6LCbasfVb5jEvvmNORNgIRJ624iGK7bqNGcQ8oyn
 CL+g1EhF/GNXQAWHCKjam/ikUnRWeGeJxA06NBUAOTBKtuFRNcS/IRYE2lsrdgyT0UY9i
 12ZIzowh/JoyB9hkjiySumfN4kOQ5PiJWYWFpflc2lYym1/f3+uhQZp9p7b0Oy12ML+si
 SREJNzouTWgrN8CszVws5jy7PqySbNPg47HUTTw4HL6TMqiluLfSmnGMI+3420j3YUGfK
 ASyDmbxYifNRUdkeWU+cL/39PMxpzZj3zZZjMjgt3I6PoAlkCPIuCisAueRnM97UCBw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pIN9SnoH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pIN9SnoH
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1328811F8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:13 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-8137b129131so3963014a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790817612; x=1791422412;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FT9xBhmSqZJeO6o4/P1ecDneLCCrplFEqmwfdZ0SEOE=;
 b=pIN9SnoHCjcNB2eFsQ0Q2uW9yRTe6Z0NA2w1P6QNBfdek+ITCkktsvQztr3X35dQci
 pOd/Mw14wDIdKWyZglpfzP6EGiTHqHXY9NoJszlVHyJgWuP16pZOhFbdkb+30Fy1T6sg
 bbtFbuHuQkK39/sQJBgPTAh6Txs2JgDSM0IUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817612; x=1791422412;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FT9xBhmSqZJeO6o4/P1ecDneLCCrplFEqmwfdZ0SEOE=;
 b=Nu/9uOTqzYb9/vPdeDI7ACSFdiiNf+7+9K/TOvuVJNaUopd7Ggr0dYqJ+XSByFJ9iV
 /f8Fxqqp7bOOH4vXGwSLuZGpI7hCTW9wPloOgsacqUBDnquP+IFBeRrGvQvVugAXUJBL
 p/JUQbRjI/gcuxScipZvK/8SxDj5jBBTBeS1g67pDiXjDz3sptnIIYmKdS+v8q09k8p3
 8owB8oEGHjSXdWKiqSsYAeKJjK2obS5SlnIAt/VsJbgforomPKKu+D0tgZ7ija70qBXH
 7U8SNrMBieCykfltAlO2h2XyLz+mnOPd3y4dPA5zkZPVdG0MJmPCTQ9oAeF7KvZdBdX1
 4ayA==
X-Gm-Message-State: AFuF++mXdXO3ImT+gkrPepbbIF7eMTq2GzSgP2Tt1bxc92uFRvQ9c/h/
 W3uYlbXpLxerGT9SeiAkMx2ynVoNF0eA7/6WnzxrVHi3GskO20NX6NC6KqfhppFEi3ZkiwTNMV5
 5ZYysnPJIPNsT
X-Gm-Gg: AYBFou23XyfkXkv7u9+QMn9TpsMRPCaLi1z75QCEsECBAs+agYdFjWVJf2Gt3Haa5JB
 B2KIZUlJcZbt2u10BS/fw9+lt1Q7f5xMTjyD1b9C7xJqV0259YfIBmLuwat10Z2V+6EyIuwNQmg
 RCGPVBA6VI7KGVa6QfOH9fZ2NP8e8XUNmOgehmMsmHKEyI5c7axfhYdSYpcjYti3Lxd0NfRn6Dg
 PIBLSWKGoNydLKl5YePM/FUYVvZ2Ex0Pm2sp/kyxK5FwwIIpxMyyr+NnV+QqW8gC3+f7+izJM0q
 9xToKLix5cAPvRaDsjb7oFYxGM+7S+29aLH/gLA/tp7i0FP4dCugj92bPQccU4h8Y4RUXNK7Sk/
 6DMY8dUK0hLpLagPiTSakcULcrnjfWLLiEX2OQrjLmdHoPoLazWRxaY/JM/VVzpA+ZkwVbrZwM1
 512LhKjAQG7kCFhQ1m9hgrrfEunlBTC2VNTbI9ULxvpVCFWXOG/ns9PWpRbmJR7Nd54guxHwA25
 eDSLq45j0k2FicYoCWfikvU3JJpdNBkbbrgDX3jnHvtoEiP0NFjBO8FC/RI4Kt0Z7tKzg5VpbWE
 rW/pFEvvHo2X5ig8ww==
X-Received: by 2002:a05:6830:438b:b0:81e:b1d2:95f with SMTP id
 46e09a7af769-8204b9e4481mr3648097a34.28.1790817612559; 
 Wed, 30 Sep 2026 18:20:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm1681082a34.3.2026.09.30.18.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:20:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Daniel Munic <v-dmunic@microsoft.com>
In-Reply-To: <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
Message-Id: <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 19:20:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:

> Three independent hardening fixes found by internal static analysis and
> code review. They do not depend on each other.
> 
> Changes in v2:
>  - Dropped "boot: image-fit: add overflow guard for FIT decompression
>    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
>    as the allocation size and as the unc_len bound handed to
>    image_decomp(), so a wrapped multiply cannot leave the bound larger
>    than the buffer, and image_decomp() already fails cleanly on a bound
>    that is too small. The claim in that commit message was wrong, so the
>    patch is withdrawn rather than reworded.
>  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
>    single check that the packet ends in a NUL, per Tom's review. It is
>    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
>    and it also covers the dectoul() calls, which v1 left unbounded.
>    Retitled to match.
>  - Rebased onto current master (a44f46af0aa).
>  - No change to the NFS and ext4 patches.
> 
> [...]

Applied to u-boot/next, thanks!

[3/3] fs: ext4: widen ext4fs_update() block-group loop counter
      commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
-- 
Tom


