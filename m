Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700E8CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30BC160A41;
	Thu,  1 Oct 2026 16:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdtu14SxBPQJ; Thu,  1 Oct 2026 16:00:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B746760D61
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870426;
	b=nIqnFAeXNC5OGPpjrkANx5OT4KNdy60GlcafIZIcUMri3XPPmIKqOI8wj7oi3nnwWmJn
	 D2ZkIlvVLJDzh1f7ylzNw9Z3mjTHMldGRJgNbk5JJ88+PUfvz+De4M2xFN3DMiphDyq+R
	 APHmMaou8+HeZzdZrIPf8vuxpxl3pHesQI73WrrCq6W194NUk/B985uoeBS3CYvQE1acd
	 xl2zC6sWKd9GBKoBpmWh1YLVBnrAiIfmyKHqDAGCpb7u3TVbKWaBbJIbTUlSNq556YT/p
	 2B0/2wAfu86dqzeFpREjfbtp6G0kIe4M+sqEAKS6iz3LkIYfHBdGmXuGxOTIsik9bhA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FCqUl/3HFPDd0E71UmG0fkIHyKaZa8W9dhWp13AszzU=;
	b=rqCadzuBADIfXtCL32FWKWGQdDhn4ESRaMpZqTzkk+1ZlCoXuehQZzglj9s9KGLMtGJh
	 cASpK+RCgUTiiFni1I49unOQeXPWDpD/nFX3PZ9T+VJyBdpfLkyPqc8OKZTiNEWXK6aCQ
	 cJXiNzUn1+GUG5+bjornn2A88IMUiMEpzuyX0gFUHg0XuLqnu2pGc1Uum5j4FV4c//CRZ
	 dpv2+BjT3QvFqzkqaCsZ5hbgg3kDbvuJd292ho22fZdqFQfjkJyUeO2hQK+91rJDqODY9
	 BZSSw3AUQ7QqsAZOzQ1AlnF8Yh2QJfglCUPoBql7cz6UJZZc45z0o30j0a8G5OHyIrA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870426;
	bh=FCqUl/3HFPDd0E71UmG0fkIHyKaZa8W9dhWp13AszzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NE/AYnTJzMuzAY5vISI9rOnBcK7DU8hJPKiRe4Lqtft+VH/hNjqn992thAsuOaQ4l
	 cIuQJUgy/8J/g+LGnXKuiDumOnBFrRg+0TmpNjqzM9Za7xJSLrmCuq/cJ+ZD7b5wFq
	 fdXbV1QvYDKapvg6E+70/laklPb1bSpcIKRjGNX2+nZvc92Kyu3KuJrAL4+yV1WcK9
	 7g03qJxfF/Qj7G/j0oU34CLSzHu8sbxK69fB6nCI4vNZ+ndtT94D0yc9Syd0S230xP
	 IlI2Fh/5xRG1OouRj37BQyjmln+H3PlJkPAbIvQQMsZmOq0PvPPI3lWqmXMvNK/lgO
	 Jgd29PgoyLrLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B746760D61;
	Thu,  1 Oct 2026 16:00:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C46D33B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CF3181219
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chvG1OnlfYMi for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 43BDE81139
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870423;
 b=oPacTm1hjLq/LHGUdrXudWGPEV6bq5bRgw40osM3cZhG8lN+3o9wRPbPQctqudizKjGA
 QEpwuw9E6pemIKtapwyBqQH+DCOTIOzAtU39dk3YLVoWpEtCRLucBOVzQ7TYQHkRcRGSL
 AYHZXOfrpxhDpzHMp8qgcMAM2YGBZIlSPmnR35sbaPL7nZ2POfD3teGpCWJgx/D6ufemd
 l0zMfy/r4NPlS/awWKF1ep9pNVrf4euCC2PhB0a+Oy95PVT8x9cv88KxV0Dudr7DqpW5h
 ochMr5iW8RKD9E+7jtZnDwUDDJzi/z+HH+m5XEAE/FbCXic5cIe3Iq4xOhXgQa19xrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870423;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=FCqUl/3HFPDd0E71UmG0fkIHyKaZa8W9dhWp13AszzU=;
 b=qTcX2JRZMP3KrnRmaRIUiCmciPbAXOMGgMwLpOZc0UMUarFrJkCDW6BiISOvVoNXPAoB
 zyFOBuWwbR5j9IqTBdHZ3urroDkNBxoVZyE8/C/AUmsiWcpECpmKDA0UoBDpVrZubwBnk
 a05v3iR3/tuc9ni4eyFRQ4lQucpU4nO5JzNpX7Jux3wgNtSLVujdKfU8vgWLrCAnaoS6k
 ACeHuXeUGVnWVMTC8UTKhZtTv4BHtWDSAajMhqzytzxfzTmYJKRdwhMAN01pcmoozDZ1O
 aKXXT40/yHG7XNKvlOyWigZ0G+7sD5HEAu6mjESNUb27k4jeRzudbn6b/1HtHAmefhg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NtOPqXaO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NtOPqXaO
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43BDE81139
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:22 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso32799395ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870422; cv=none;
 d=google.com; s=arc-20260327;
 b=deHxeJMtjma7fugxuySEc7dj5pfuuRcA+NfOnMoKUegyVLEkC9GmuwffaNtrVW68rL
 1sPzy+OtiKLwgG/fAW4sm2QpBeUar9AxgGzeeJ2ZZmjxL23UZsRtnGgIKd1NY/zdeiRz
 IZsGNR4u7GdBafwT4aIUbaZX+kjWRyNtfLiN2BlSIfyC4Wimc0oB4idO8rplrraU+Tl+
 +Hfqgkq5zQi1bN4LKgo0Ls+SrzSw5sOPHHzS63zqd0vsxmGQ4vGh2xCYumTH/FT+MBrL
 UTAG+38lCei2ONCmi5Dqei2vzSNneoKG4ZkIZYrLYKEMGdpn0RulFccWJD310/VeGAH+
 q0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FCqUl/3HFPDd0E71UmG0fkIHyKaZa8W9dhWp13AszzU=;
 fh=xUw8U6NCLY9FhsHEUwvbSq1tWW6yC3cX/vKds+UnBJU=;
 b=GKKk2zkcKr7J8BUOQjLhqxXksYYNG7PB4tmAPq3K1UH9cBTCZPCwcwHjfHxDySCqdv
 meAUrZa/iA+rYqkL943fYXdmPe7bHyQU66xIp2/RruBB3jzIRAalZdzN6uc1AFezVDdj
 +50zQ6B7WN1ddunGJME+YLXF86NdRRoy1SH6PmhLqea/eK0A4zDqNyxb7GOJWY3kTcHT
 SiDKi0oKbkwiHIFBDUWa5UuzxBUJHScddHbwqyy15LJnBl4Ua2gKi0m1VxVoRUOx9kmy
 H5GjGDDfQ9sP0IfoFyh9d+Uv7+VCmYzepePWs4C8850Pcd3eSRhQStTifUSfRzGdg5i6
 GzEw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870422; x=1791475222;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FCqUl/3HFPDd0E71UmG0fkIHyKaZa8W9dhWp13AszzU=;
 b=NtOPqXaOiTAlI8g50YIZOqzZU89QKoiIjHikL2c+3N/AeTbWUgVyQvBHYDSQ0jEjdI
 NZdJJJoqaSDE4CQX4cLv591ihuDeErTysUz8hWb0J4f3MNNDZRWLWRxgD6YiPs8AB8xX
 BpAsGYrXbWRERrBfE0Sm9LanqC0xirJALR7XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870422; x=1791475222;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FCqUl/3HFPDd0E71UmG0fkIHyKaZa8W9dhWp13AszzU=;
 b=rogoNmLi0i44xjBRZsW8WfxZDTxkjA3v1GFa//IgbjNmL0WiJfqQ4DKwe+b9K9rtP2
 Jb28hWSJfYe5f6WWrF014JadsMI/bFDEx28uENTikLCYh0Gw/TteiRMGI9dqKON8CcQN
 AS0WKriSKP/zx8tg5VG/F5vCf+7h7B57esXSHskDEy/ssZYh9Ydr6u5EOFtMaanGfpRo
 U1Uj6pqib9patAsvdK8cerAXtVrZq65Rrz6pg0C5NuTZWvEf14X4S452euQQgTNeSVCI
 cK1+bVJVrv4hCwwehpxb8IHLo0rkM59DS6uztK2Cqsn6Zc33ncXIUwDwRS7bLoVUk6Bh
 X6GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8SnQSclJ+YDyYoa0zpo022aQAhesbdhs32mOA7rzXBmBxOzUkALV/B6+lIVcc8Klw5zS09EM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK4Ilgy12TvMqFOuC91DWyritIICeuobpmSCe1rNNbZnFg4dLyc
 Yrv5HC4GJBRf8q/Dk24FZTb1bqvqiRqPV7vJvKEvITxpRGHoX6gmwNB8qdUtauEK2r9+Yl7rzhz
 mTbCNj6aBQX2PZXK4OSTJfmfgLzUnJct18DfSWy6RvWztF6TroyIelw==
X-Gm-Gg: AYBFou2jhg1Yy+rSJcssj3p4t1JD+mYxVPpWvBTpIVpR6YCfS9Rv1/J1P6YkDNI8Lfr
 ep2lwQxcZ24ivDvfxZEqEBU7nW7tIF8VP2ohFCPtCFvUVpGxacB47lhPR8oikto4HRlXrfy3aH1
 ut4PDGEp8QMyN7XtStaXJJd6ExCHUBuk5a3ndDN0RO60PeP1t98/l9n8uPkE/0XxlQYSZ5CRVB+
 xhuUHVClvBRStOZaQXYudso3ZPuNOh7rXsXBEl9MgERjchwAa4RxHV5zTLffZT4l5wnNdc5UOkX
 4MS2LUvttEVa6y9c8IFvfRlwoNp6hp2IZL3XgvDmpTbRJSL6qGDvya423K8iP5RANbM=
X-Received: by 2002:a17:902:e88d:b0:2df:5a29:ea5f with SMTP id
 d9443c01a7336-2e2e4a20448mr39229315ad.57.1790870421703; Thu, 01 Oct 2026
 09:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <7bbbd8ae1f506f1d50cae0cf224675811d324ff0.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <7bbbd8ae1f506f1d50cae0cf224675811d324ff0.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 16:59:57 +0100
X-Gm-Features: AclHuK8b3khvZ8obqGG0Y0m7iJVvHuuwrHGuUjIpr_KTzNbtlK6SqTfnHBRxM7o
Message-ID: <CAFLszTivcrh4SqCBBw32Ck7x0A-=tsg6uvuVTVq5ktgQ=a2gcA@mail.gmail.com>
Subject: Re: [PATCH 05/11] boot: imagemap: do not resize a region the caller
 owns
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: imagemap: do not resize a region the caller owns
>
> The extend path reserves memory at the recorded address and re-reads the
> region into it. For a region recorded by imagemap_map_to() that address
> belongs to the caller, which asked for the payload to be placed there:
> imagemap reserves memory it was never given and overwrites whatever the
> caller had put at the destination.
>
> Restrict the extend path to regions allocated from LMB by imagemap
> itself. A larger request against a caller-owned region now falls through
> to a fresh allocation, leaving the caller's memory untouched.
>
> Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/imagemap.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -233,13 +233,18 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
> +                     /*
> +                      * Only a region this device allocated may be resized;
> +                      * one recorded by imagemap_map_to() lives at an address
> +                      * the caller chose and owns.
> +                      */
> +                     if (!r->lmb_reserved)
> +                             break;

The logic looks right to me. imagemap_record() dedups on img_offset,
so there is at most one match and the break is fine.

Please can you add a test? For example, call imagemap_map_to(dev, 0,
64, dst) with a guard pattern in dst beyond 64 bytes, then
imagemap_map(dev, 0, 256), and check that the guard bytes are
unchanged, the returned pointer is not dst, and the new region is
LMB-reserved. Without a test this is easy to break again.

It may also be worth saying in the commit message that the
fall-through replaces the caller's record in the table, via
imagemap_record(). A later imagemap_map_to() to the same dst then
misses the 'already mapped' shortcut and reads the data again. That is
harmless, but not obvious from the description.

> +                     lmb_free(addr, ALIGN(r->size, ARCH_DMA_MINALIGN),
> +                              LMB_NONE);

BTW, this is not from your patch, but it is the same class of bug the
series is fixing. The old reservation is freed here, but r is only
updated on success. Both the -ENOMEM and read-failure exits leave
r->lmb_reserved true and r->ram pointing at memory that is no longer
reserved. imagemap_cleanup() then frees it a second time, which could
drop someone else's reservation, and a later imagemap_lookup() can
return a pointer into unreserved memory. On the in-place read-failure
path, r also still claims r->size valid bytes, although the partial
read may have overwritten them. Perhaps those exits should drop the
entry or re-reserve the old range? After patch 6, the in-place case
could instead shrink the reservation back to old_size, since those
bytes are still valid. It could go in this series or the follow-up,
whichever you prefer.

Regards,
Simon
