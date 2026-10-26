Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04465606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q8caoSo6;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iwynJxus
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AA6940758;
	Mon, 26 Oct 2026 16:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Cq8ZipZkL0v; Mon, 26 Oct 2026 16:51:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B36FE40756
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033507;
	b=fUw6ryZRxH6pmIdbnJPOj/Rq5ZwuGTcxXVTpSOMKOsSxG7RUQeTNX+TLvDDBEYtFHEe3
	 DJcGKzbNYXv1Ddjrw5fiGgVv741GW7xb3NplAyyaB0gVryXfvE7NZvGkKWf6nFTL8uV5I
	 AmNEhPBPs/EJJrRFT3iF/OycR5Mbt53l+IeXyoHxa8fdl2YS/g8e9bFDOQLpuEqv2jrRe
	 PdhEB1TNFLXxWsI7+y4ZdU4VwKCMQ9M2RZr5lslNxcGeCajI50KhEl4tBi2K1rYx80mN8
	 hg9f68ZznpohKucGET40FWOq3q0NY9dNmIZYXO8C6XXNGmO8FQPMl9eMrD+2OMfyv5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XyEkPfBZX4VR/Poaxwx+yGmbbw7PeiYK2xk89A0UaoA=;
	b=Smznv4GUv3nNWwPwPWh4+7JqEaTJH6twwQkoTeepirM6of+mkd2S8qmFevkF9QF7w4Fh
	 jx2ZCg8OcRfXo4gIpcUHGpRXnS+W0ttxx395l0FFKYHiVyTcOwwm0F1mY1x0bcet1Q1iD
	 OezGo+lFpN14OyDm+aGSe8FvMtw3QuOsEylWYfIsPiXtB5D/sjkGIbFxqGePqi6HUOiNK
	 0F0T2Z1/K1ClBZ5jopR/bO6702WQGvXAjpheeDHIEFsDYGfEbzCpaSmyvCHnIpvTzOmmo
	 tnb5993prPr9iIU4fMlfgbLY5B9qVzCbakajhCmq/l4/1JAQ6AkICtNmRAJ5CegeA/A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iwynJxus;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033507;
	bh=XyEkPfBZX4VR/Poaxwx+yGmbbw7PeiYK2xk89A0UaoA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q8caoSo6MTMTYQNXMxDB519ut5ITtzxl2weNaKhBkk+ZMuKDzSmgx0bwGt+WoRJa+
	 tFKWEotRgBhWEQcIUewU7wXP85YgJ+rXLx5xtL5nZAbR1oS2I/zVLtTsX4D8T+pWKE
	 meIw/90aaEwMEGXmpsk3Rph8CHrzgr1WT2A1GmYw+9gR/lSI+XNaybd4vPPHK1cyui
	 I4Thc5tROmcPrC/DDCreZ3bysIn57oWamQ1Zt4jbYN4JIJoAipRw7QVQRLBGbTkXvA
	 u32azEihR2aaPXNJbYRiHSVNkaX7GmSVBndfjoC0SgV+w536yGFd6RgcKq97zwZ/4w
	 znygFwlOB8G7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B36FE40756;
	Mon, 26 Oct 2026 16:51:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48E17356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A82F40722
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Elqi8PG3WmQ for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:51:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3868940718
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033503;
 b=gtoLtiC7nDOqAJ7xAW6Zs8D5Mh1pLajcCsFI3EqPQTC4cJUJk2KEReGSZvBPgQwEUmDM
 c97SJ9FVfz2U9yvEEIG9rJf6wY3Ker7Z1ibyeQZAp33wjML7E3dFfHjpZrwCr1uJC2BRj
 TX+JiOoKKnQGVmV1+vaezAL8+5LoTBNGNiVxkGcnzI8Ekhhbhmzgb+1+ySy4/7EbIPz6j
 4Q7JFLN2wTEto4XCG+J8/cUsX4uQ2cqg6ACNl9NMy2wt0C0a+mx9aVZUhC5gCUvnNFtdS
 /7aQkjoOKBlAHDxCzcP3cKFuIkh41pMdJ+mQ6mgs6+4bYOnMK+DnkTfJ/D+xLIWF1CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033503;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XyEkPfBZX4VR/Poaxwx+yGmbbw7PeiYK2xk89A0UaoA=;
 b=fEzOjxbW/NZMJqPSsOl0SN2gBRe8bbYXHVEWoWfL8Y6ZbqH735BTScBz8kJ/eiIaDZwS
 q9FNS7UJooBCiBYO8iNeqYduot9j/zbv1jLB+JnSBp0MgnroXyqH6m86nyk2AeIqdpEQ8
 xwv7koVRUAMrqSqkAqiTvw/LBCGxfCq15Q1JePKLr8erhlVAQNUqm4UrTey2BLCP6WMMX
 1oTWtjsS50DVAHkixEzCgOsq7SyEeObXQmunTzAh7b59QMTF+QTAMY+kQA4X+Yasea3rD
 fyHIHDowspZ/Cl3SPqmlhnLdrU8XCL3YTi1VI9kP3AThT6XR92QxxTFSMviVW0tL5oQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iwynJxus; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iwynJxus
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3868940718
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:42 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so14319266b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033500; cv=none;
 d=google.com; s=arc-20260327;
 b=MuAXouCV0lDwaOqYddHZl2HR0KM638qJe4PW1eaAvCD3klG21hgrjoFpQpIAWhqvE6
 NQJSUC5nlBmazk0mwqx7bkLUprEkhRcBzl55MrSVA42Pz0jlnolPv/AP4X3xClg51G9C
 p7W8PFWXTuvklr0klyhwbPlCVFeTB3wW3Ifl1JVcB+/GS5GgY6Wg8SqX4TtdwFU3mVlt
 h4GdQ9kPZor2Aa7EfZcaa5onZQOFU6ZBqsi0PyLK3YEbPCe82dLAJGgvWukYnea3MvSF
 x/FrcdC19ZuuvjJffiLoX0Yphb3ls1DcNE7OjCdWXa0Rl/btBZvZrwvf2Z77cew1ohmJ
 mmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XyEkPfBZX4VR/Poaxwx+yGmbbw7PeiYK2xk89A0UaoA=;
 fh=mnZWDmtfdzMrcEszqBWr1jO2ogjXGlKOfsX54J72Zoo=;
 b=gwMJdr3ebV16ZUJIusZLbomGJbLvcyD1T33lsk2gBIcqzX44lzRztMNf9xklnOLGX7
 bB3LdzNrrvfzfdoyZB4jaGWJofghokgY+W7i9ylCKrHQ0VTH7V2pIPLlmP7OEljYWXZe
 8bbf3MlPkRO8AcbAowCDQMwDJYkHQFgQCwQJq4x87AEFpbXB1v5/xOFHnNG7Wgyg97MY
 bIJbFSDExrAKBW3WcB1exfOxYeeRJ9Z3PWuMRXL7LUy2irZjKuBALqYN+94AuUP0pomQ
 +jTzxL8mtHVzJRSaUzEvCNJxEldOWYvkxWI8JnS/DM/bOBl0CoPGoahEh3C6+4SAKqv5
 WfYg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793033500; x=1793638300;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XyEkPfBZX4VR/Poaxwx+yGmbbw7PeiYK2xk89A0UaoA=;
 b=iwynJxusj2g84dq4qhowqFrjbe3bZxbHDWSTApG2ScafX7qf8Qem7MkrXJvJKE7m8R
 XuqOsp3xmyDDyDdYvdzsiIgTVWPAN7PXy5NZ+8PI/gnQd76p6ItaSj3rzdhPkIFpT6vB
 VixI1/5192ViVV5Vzk9no3j/vAjUfrv1Dnf2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033500; x=1793638300;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XyEkPfBZX4VR/Poaxwx+yGmbbw7PeiYK2xk89A0UaoA=;
 b=yaEmlAjeoB8ofr7PD+Y7dnGhRB0M8GDCqsdovJUuHq9J2UsIEBdM0TZ6c69Ql1y+jb
 R72uxwmXa71HGV/Yy6twbyNc4MJaNQmPoX7xEEu0FlGeYqKCZeMeTPasB30SCci7AiXD
 bKYnJ87aTj+k/O2aCMuSTAJE/Y8bVUGeHPoQia7IaopDePVdAurGRsNDPryGIDuXofO6
 dI/Bs/hAslX3NVZ7P7nincrU4FcG4LBOE+Pj+Gi+UruaWSry4br9v0tMPnnDueflTjZA
 qC0k4aA6pNmApiShueSQvHG2zoC/bfOHspf14uqTFdv8p1sYsxRHsFeXqoiB2VTif+Ip
 sD2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0LIgfqafZWmMP7txLdM6vgdMgxVGkFExvSBiYToDbhcy35TTD5MlW1VkrxKhDkX1kjbgjAoI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIhV5FrGkF1sEJRLnn6GYDBK01mtBf+8d/NiKx1gM9ZNarnNp3j
 gqCwzJE2Yw4iHxrRQPzFe0/H9xzYzbeMSh4DeO9p5K0D/jgIAdm7r3hjPVKxDuCPb2IpaRYDpDt
 0rB8ZbD7L2Kb8k3a8PGkxUQc2SLpXdqj1Fp5hMuuu
X-Gm-Gg: AYBFou3sKP8z8b9thbb6+yEzjiw5X1N1tsDax+P7rVZFVMudiJ0gyk6C0wLqFu0N8W9
 tzSXuut9xBs4ZIyHCND2xjklhc2fdfutT0iJB/3DVcs/iQiK9q56TU8b8FX/RDVu/GMYnorBd3E
 xoDZMDvYdks4eMnhjk0Opf/kLbrsZbR1SWt5mpUh2Gh0nJ8piiD6suE4QOy/7KvUXiGAQDhQ27s
 NhN7pnIC2VFH4bPlzPrMnaHkFeVV88zsOuIKQ5SO/btindtTbYLXyE1j9rcUYe4VEI3L86ucXFc
 UPYvpgBog+UMoKlqi3E+DEvMO30qvxa6+IUxXbndpWNX5WsRMWBkHQ8Ej7uRClxUHNKrGRVV8KT
 5OWDaCAgHdxTRn/dWhFVxQEGE708fAmn1XGY=
X-Received: by 2002:a17:907:a890:b0:c49:9247:9688 with SMTP id
 a640c23a62f3a-c49a735d017mr18499066b.7.1793033500557; Mon, 26 Oct 2026
 09:51:40 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:51:38 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:55:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <78a948b6-c07e-444b-b8b7-fc1f77af514b@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
 <78a948b6-c07e-444b-b8b7-fc1f77af514b@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:51:38 -0700
X-Gm-Features: AclHuK8ObEUIkVri-g_qVkDabYW7YqI6WgGlUH3XMbWadcoA3dVDD00HHDR2gl4
Message-ID: <CAFLszThe3ZSjCSr9M-7ZhK74=S4U=4jOMGzB6kGtUUchFPS+yA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/6] fs: ext4: check extent tree nodes before
 walking them
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:
> fs: ext4: check extent tree nodes before walking them
>
> ext4fs_get_extent_block() walks the extent tree of an inode using the
> eh_entries, eh_max and eh_depth fields of each node as found on disk,
> checking nothing but the magic number. read_allocated_block() then
> scans eh_entries extents of the leaf it returns.
>
> A node can claim more entries than it can hold: up to 4 in the
> 60-byte i_block area of the inode, (blocksize - 12) / 12 in a tree
> block. Both loops then read past the end of the node, into the rest
> of the inode or past the cache buffer. An index node can also point
> back at itself or at any node of the same or a greater depth, so the
> walk never ends.
>
> Check each node as Linux __ext4_ext_check() does: eh_max is non-zero
> and fits in the node, eh_entries does not exceed eh_max, the depth
> drops by exactly one at each level and an index node has at least one
> entry; and, as ext4_find_extent() requires, the depth is at most 5.
> A node that fails is reported as an invalid extent block, the error
> read_allocated_block() already returns for a bad magic number.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  fs/ext4/ext4_common.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  include/ext4fs.h      |  1 +
>  2 files changed, 42 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
