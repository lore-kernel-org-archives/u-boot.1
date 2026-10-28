Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD0606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ojsAnmY7;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PyzWPOyg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D60DD405B3;
	Wed, 28 Oct 2026 11:23:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hA15EhUHotk3; Wed, 28 Oct 2026 11:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 273BE405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186603;
	b=AVLmceQ4mBZKKPNVaAKY4or6cXGcSRzLHFkXgJx/py7HFe0cYRogk+RIBg38/FcKcNW4
	 gxiJ5meh2+HO5Ta4lDtWM6CJQBPE7WxtUEzJokfE28DupgIRDJG1s8CIC/NTyr/k56mug
	 t1NG7Y16HrXL4UnnDxh1COqd/UeKKrzT9sI/TSJo6OwmV8DWnWWucRqo/ah5KO4qLw7eW
	 vn9Ee54oospGPf1RF4xrpnH4m4+3H6jHspjOncsEYYWe0eYHg2CHaehyoHENWRbtDHSBi
	 SPKNrVw19zIBzgiWg6xh95nex7R0Azx0jB+MwjU07xWmA0dzaY1n5gGaux/r2B2xAxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GR8ns/6VbMVIaSrSvsMx81poHDohj3xZBsmM9crmeog=;
	b=m0ODS7p6G4KBa3IRgpK5riJBNmdNM5MUDCoWfnmTcQKO435wNIu7RHArfZAehiTjWkAs
	 4GdAsN4Eyjb6pWV+g/Wnj+gZ/o9EOiQQkJCWHU1M+R40W2xyN25TZTwdT0uyC3lnW9Hzi
	 mB0Bpwk8vkGzPB/R8m+A5XRjiIEzmmxo0h9sCOXPe7naJg0Bsg10tKYBrC3daNG2YTCVm
	 bKFtM4h/8aE9mi9KnEflSUmAFaM8VDA3hL7mLph5MK9GnwR3S60Un02VX145XfuPKTNar
	 OY0E1kms6t2XxlMreh5GrAlnA5C/2kEqW2rLU4+r7610vU6qHeO3m7nyQdT0CklxfyQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PyzWPOyg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793186603;
	bh=GR8ns/6VbMVIaSrSvsMx81poHDohj3xZBsmM9crmeog=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ojsAnmY7i+Q6hRwTZEmTC93Zr1pQT0JfMgpL3irOc7cd+M/0UlrrHKL0ANPG8nT/9
	 +jt+sRk1/qPndA7Ilfo20AhyI5TN7hH0gFOEwIWHupiBPcGaGQDxgRKLsvGT0FHle0
	 RQrOuxzF5t+yb98ZO9nPJ9bqz+M2e9p6i/jki6GU4rnf/xd9g4v9TK9I7DwTKT6LZi
	 T1T8dgSjYL1Z3h6qZJPXYtelfeEAXPAlyKdjL4KFvAFsGvEs5vWK6DPyok4kVDP8+9
	 6vDnhAiTd4YZJNJtE+COPeL3DTIpaSBPwGxv/7Ho2kJmLZVdzfUYy938chCIjlr+I0
	 ISDxAeM8EsX0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 273BE405E6;
	Wed, 28 Oct 2026 11:23:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 085DA1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE0DA405E6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RGclhMkzzDEB for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:23:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17748405B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186600;
 b=KcfyIRlgniFFj3qb/PYpBtJaDDwMrS2rySS+OKDGRpgUX1edaC+5F2L6EyiNjoQjOLjJ
 bdUTNZ+N4V3VRxD1ir7HwHR1uyU1WU/suBxjpBkNjhLIKwtqonLC53Vpg3OXCCgCYBCjd
 EaVGgPVH8VPBQs3Inph0/dQn7KIhmreLCMo/NfPYY0excnFU9N6zUrhr8XLSLSWkYUhM1
 SPpCGphK0rk32Db5YeXC9l/qRoh15WYNCF8prLUQxnjYZ/ccwmkscpWv6BR9KPi+ZBguO
 M4R8XmmHVUXSzgVADC8s2hTMToISFpd2ZRN1Pt3mO9/5lWpfx66FfP2fL6YBKgY+Mww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793186600;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=GR8ns/6VbMVIaSrSvsMx81poHDohj3xZBsmM9crmeog=;
 b=ev+9lsGoyuc1PR4cfFnNkUTq2lVvcEePIWiD8iZud0iUA0eCJ9I4ByTGFnroKc7jS40T
 fgWNkQAlmefTtbwdwLTGXitPUhVL4A2asxU9jRMLpMciM075lZm8gUSJvKKqCkXaMoF+5
 vyO678Z0zzqZpPSgzKr4dfMkeMcbiG4TTo6mHp6uM58IaEbe6EyS9ZcI72YGkT1VQ3MB1
 YBSeIAM5HhuBhTR9zh0iBCsdbSPDC8bLGs2MJr7EWLGpAygNDUVkLM4RepAaphG8elHIs
 yCy+ITSvNTJOSAqyUYq36hENm901Rs3C1JzBhcCAAHI240QNgzxnZgHzrQdN/lV25ig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PyzWPOyg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PyzWPOyg
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17748405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:19 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso1331858a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793186598; cv=none;
 d=google.com; s=arc-20260327;
 b=PR6Zasa/DaH3sq6caBMcZ9tkfi04JfgvOlmqI+UuGZNFhtM1Et2kQbJddMHdxZbslM
 PO2RzH+VzRCU7vMT01lQwEuzbLYbhEsSJjVitQahQxtGODNDFTVee88Gg3IJwcOWfDip
 aVoqnq3oUP2LNBj/EKhH/Ax2hlszmoa8hL9ovqmlEgqLArH3U2h6e74/zrlfH0H/5Of7
 se0wTl6yTdMWaNzTweg6gHoHtEuOvL9fMznkTCy0uIxRcLgAl38w35s0+632bC3YQPb6
 /drSL0j84xX+86OpvfYzTPhhUbii8YNH6BJbSztMxYLwa80Ilh3HcQnHveqeW5RteoJq
 SWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=GR8ns/6VbMVIaSrSvsMx81poHDohj3xZBsmM9crmeog=;
 fh=rwel3pTwAXlreUdKYAiZ59SXbs5I7lpSHuMYwUosUMI=;
 b=njhefe9Tpt25UcDT7khBXduk0jPV+7WUakRqFTSxl32paZyXAuqbo2ZyPnnBnvggCl
 lwWdfMKuFUQDbazGpsvnOMYge/oTnLahIO1V1zzZDm1fEZE5m8oPHPn1pQwpVCO+rNLU
 IiYc5aAupHdIyIM5ysQHuMKka7466vlvntQqEqxUJ/CoW1iTLHSH33oClhR0IqwwHJa5
 j62op6nsGbeLfXiJc7egWlvhv7Ks1ydcwJV8umKhjVvVY2gNcpTAEifixQSbkYRzCQru
 +sZSfyBTMzzOuoeRkOJyysdVYEGhmev2cg2wTWyRsxHk8D7pkvu6CbVQEMm1rhV7mooF
 N46A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793186598; x=1793791398;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GR8ns/6VbMVIaSrSvsMx81poHDohj3xZBsmM9crmeog=;
 b=PyzWPOyggyFKP+MHU7WwNP3KJVCk/Z4zMWjKsQz8OduToqaP6jocUFfM6sdUIwLfkn
 qVe/Jah2bic58TL1hoHQ1FR2dgz1vNSNFRejmsMU5hHVudQf0Z//B5TqqP1d+yUfk26j
 TeWCY+v7UxDAGJHfNjdN5jx9yl8OglF+JJ9ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186598; x=1793791398;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GR8ns/6VbMVIaSrSvsMx81poHDohj3xZBsmM9crmeog=;
 b=wQ2JqGO7yFlv5ieNziLFSt3fkGC5KQOiwchkzBF/0xOp1/r1UoG3ytmufI/zInpmVV
 l4uQRywJ+l+//qcBT4M+UCHq7oZ37VwwpdGGJtpH7cbLDqETWtmQG9IHSzTL1gG4a6jQ
 HP7Qof6lGLXZCEaj0qb3rQCZcEQ90TMFDk7oVCC3Xyh4j4IMtAMXS0LKnlevp4F/E7ek
 4PO5Y/xd0HRi+psWkOC5t5MilpQFcA9DAgJYUKUp5hJTehjhcMFNkAw8ZQJj+D5YlD2B
 81o2Z8YrqD09ZD1DGTI4l2m6jt7wVKYRFywapGcKp/05jgKfGXV0Y+fqKUctgX3ehWMb
 6law==
X-Forwarded-Encrypted: i=1;
 AKwUvBweTTFquGGRlbPXByovXyv2Y0esip8qMmJSA4AT6WVb5rKeZvDPO/oF64Ro+/3LQqS3nfu/u2Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIGixpbQ/vf8mJHCNidzfiCTJQxlOl/I1JKVUFHJQYi6anAnWmZ
 usu2uOSK7NwcVnmqqxwBKziEjpaH1Ri58/OHR9Po99Ovo3CpaP2AHb0aiywEXSUXXlm/JP1NUkR
 2QRnocXh+1AxJm2k9ql7QLsJx07vTyhWBd/c4kH81
X-Gm-Gg: AYBFou02g6OXa4IWBjXUShyY+AJG9260iSpzo5bwZjbTPcxQqK7sfzTuZ4MxCNrUg+J
 cMuQQWmYt0UTuRvs/pfrqERDC4NJq2Ox4CXnkLFBNMfFfreUxNRcw6n89rBDLTUsVDpSOQWESbJ
 gpHQNi07pIATCL6M4eiiMBSi0oDGvrfjfUSb1KUvwsMTg3im2Y7FQlGLmJNPQ9fgO4e+1ovFuIh
 60Ci7q1gcHARpZCyN2nS/tFbzbdHKvRZVgb6B6Gvtr4bqYoN2fu2IW3jstVzPycys0nkGS88OeU
 FIUbHgZMacruSf8bZJCiu6eIClghK5j6i0Kszu6Z7as7NSdBNP/k/NJ/U8isStVsiBMylkWAOQd
 E+oTGjwhbPrPQV0ZQnRTO3gljY35n8LGSObsG
X-Received: by 2002:aa7:d953:0:b0:6b4:19d1:b2a7 with SMTP id
 4fb4d7f45d1cf-6b49cbd8034mr882093a12.11.1793186597778; Wed, 28 Oct 2026
 04:23:17 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 04:23:14 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:25:18 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cc9d77b8-f1b3-414b-aa4f-8350a649566f@gmail.com>
References: <78892543-03de-412e-831f-de840765be59@gmail.com>
 <cc9d77b8-f1b3-414b-aa4f-8350a649566f@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 04:23:14 -0700
X-Gm-Features: AclHuK_8jjFNpWlrXvP0YUJg7GpiHiWCbmGStWhKciAew8pdC2wga11g6rnc1OI
Message-ID: <CAFLszTgu3tjjs2e2vp7jXi_F+z=WZu6qh=BHaHPGyUspCD94ZA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] fs: ext4: fix the block group of an inode in the
 write path
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:47, Ana Bobillo <anabobillo3@gmail.com> wrote:
> fs: ext4: fix the block group of an inode in the write path
>
> Inode numbers start at 1, so the block group of inode n is
> (n - 1) / s_inodes_per_group, as ext4fs_read_inode() computes it. The
> write path computes n / s_inodes_per_group instead, in
> ext4fs_delete_file(), for the new and the parent inode in
> ext4fs_write(), and in ext4fs_get_new_inode_no(). For the last inode
> of a group this gives the next group: ext4fs_delete_file() then clears
> a bit in the byte before that group's inode bitmap and zeroes an inode
> in the wrong inode table, and for the last group of the filesystem
> the index is past the end of fs->inode_bmaps[] and the group
> descriptor table.
>
> Add ext4fs_inode_to_group(), next to ext4fs_blk_to_group(), which
> computes the group that way, and use it in all four places. The inode
> numbers given to ext4fs_delete_file() and taken as the parent inode
> come from directory entries on disk, so it also checks the inode as
> Linux ext4_valid_inum() does: one past the inode count or the last
> block group, or a reserved inode other than the root, such as the
> journal's, is reported and refused rather than having its blocks
> released and its inode zeroed.
>
> When ext4fs_get_new_inode_no() finds no free inode after the last one
> it allocated, it goes on past the last group's inode bitmap. Make it
> stop at the inode count instead.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  fs/ext4/ext4_common.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
>  fs/ext4/ext4_common.h |  1 +
>  fs/ext4/ext4_write.c  | 17 ++++++++++++-----
>  3 files changed, 58 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
