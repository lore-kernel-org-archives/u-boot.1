Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE209607826A
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AaBzRPKD;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=YWt9OSPs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D47660642;
	Mon,  2 Nov 2026 14:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GhjodEPM7X3O; Mon,  2 Nov 2026 14:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E923C6066D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793631187;
	b=ikyaZ7gxVGGQgB8nYdOV17VTNAfOcD0M2qh8ZfOi2GfDUR2jdLE6/qOQqzxI5SD0NSA7
	 iivLLeKi8+KJhZXT9slvcTPsiIRp7ViXKXuSqFDhHF9OwTi1IuPfuzlTRGiyOLkl+ItGU
	 DgSM09MVD49P/yXpgt9YxMleEQTMRzVU7mLqMzVpb2Avhn5X/TuswjARkOWSr02V+19z+
	 yJt0Sj5WTO4gI1sQEZZ/vHF1hmbpDMiyahchqhputkFpNoIBC3OYfmPZF9q0AtWXjLiQ+
	 7P8RM+36kiiqvvQlbI0zYHaaoBiHkvvPjn9F102oEldQPo+Ucz4rZ5TeLWeJ48H9z+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793631187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WN68twDrXLZ9KSG5jp1fruXHCeac6BVT+cyTgFz3C1I=;
	b=HsxiX0hkH3x0BdaOtUQe3vUhbZKTsKl23mV4VgkU9JU9VDzdSoHUH7xgy7PTDL5X9cHV
	 LnfzlHNZLBel7BWp6sca4rqmZYFYepcVdrUsg1WHg/AgXOeM56sIkZ5DTQFE1RxQXBe8l
	 CHE3o0CMnlgSpYP/aCq2R3gqyM1pTdImZQk+UVdSbIhh7t/gAg3bsjRbyI6gh8T0OHHAk
	 hmYGcGV9aYjEXLi8JUc/dLM0vynqdX2Tjj7B64JOTmsvI/kRImaGGmlyS6PFPUmKczwhA
	 gWlpJhUL7VS87bn0cQyAEEauQ6UQnNdT6zPl7Smo9TrUQ1LQZ58nhFehMJK3o/tHxJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793631187;
	bh=WN68twDrXLZ9KSG5jp1fruXHCeac6BVT+cyTgFz3C1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AaBzRPKDEm23v0Zffar308boBl6cbrLuBDHBXF3zkc8DXvW5RVdqG+XmP71Db1moD
	 BHbxqm1WyJ0jA2Nwu+LNdhhXKoHnzGN1KSEtRfl9gPi5ddOeVnrq71xM0P6b4n4lX5
	 oGnl5kBp2tWxB7yUbS4/A5LPFbAxmgVAgOkRBN83pdnrXIDAUMJhDnCPts5R+1nUUW
	 uhRHbA2cIQvi6IvISfWW7nH6X67EpRNMNapTgqtXKnuAJB0cf8VH6ddpoDlP/DDcwb
	 KD8a0gwsq6IpnPoPxJ7Rs4f6LUXoAfxZknZTRAQCgw/SG+fPXsQIgC1yhkFl9TB1XV
	 5zCGy6ieWKfVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E923C6066D;
	Mon,  2 Nov 2026 14:53:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F3AB4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6135B80F76
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GTwySY_nDWQr for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:53:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DC6F80F56
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793631184;
 b=LkPasm3kg8kADRsznMRG+FgLFwvHG6ClDcPUYK6VBYMEXo80FzcWkjQk1UlizkSg90fN
 J2J9Cj+O/aFh6CeDFwndu4sJBgCmhGZa+FSkciBfkctcxormqT/TyxDa9pLza5NMOfo5h
 JAkFSXGH6m6oAZSJa3TEzBfdUqBjOnvf1kfGT5FZLqROfg0vNMK+9/OHNqeDCNHxGXQZ9
 Amjd+2CRA2uK5TvV+PEWNbB6/Iv3dDq4WqJlEdr4v06sYP02m5R5OibZrSzG6+oi6rH01
 Bavjj4GuyznvpJK3Ok9Dmm56tsdbAruuUpZ65IyjxxStcH6nAIHmDx7HCRsZjOt7Mcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793631184;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=WN68twDrXLZ9KSG5jp1fruXHCeac6BVT+cyTgFz3C1I=;
 b=VQVVDiAOhOhuLhpuYkusxPuVbwYdkBAdp35dlY0fn6LBAEc+hnRb8Jan3kkwSr7Rie4y
 7udYVbJQ6iJVX9sKmI1frgr/gxErwbXfNiHzbOZT1GpwRFKfimUm1sN8f7YDI74BZne0L
 SfkbFV7dOj/rE6dNFQvw5/fha1xD9hrYeGfvF9gsr3kpk17YwjF8UoQ3LslOCjXNuWUGu
 gKx+cxeDMVdT4ZuHSrolFZS/+QQYhlCRAH7wemK0XJ++X+n95W7Z4N9SaSHHAm8reHzJ2
 3J99KwNgjcEjYgBGpI6YSNsNOykLV1YHMUOlFBdql7lQLScNm/65oIwwyEgWXJITJJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=YWt9OSPs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=YWt9OSPs
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DC6F80F56
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:53:02 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso989717a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793631182; x=1794235982;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WN68twDrXLZ9KSG5jp1fruXHCeac6BVT+cyTgFz3C1I=;
 b=YWt9OSPs9LwoGJUd3SU8I1LjFtDn1uxyaOQ61xhaxKegIhZfIRDzOIcGQ4leZect21
 rIApyddZkfVQauGxgTtN0+st45r098GJV5J7UBYFBOKwW8LC7nCvubxor20TytfhZ9JX
 BK/dFfSBAVdGMYWEQBNXG7qpqK+nKdZjh7dGS+n9ul8ZoAimfrKuBiX17/Fc1rKs2pUh
 0p1HU5mZicQo5GwEL/jZh0pkGhPJmyX4xhgFNJlEGVSkQllFbuPf/Ko78yxw/UsZ2aPz
 PBiiaNyPIZuOCp7yvnCLl+AL1IO2dDMq/PAtq2bkoo5y1g08EmGWbGBn3KtBli9sPIay
 3JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793631182; x=1794235982;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WN68twDrXLZ9KSG5jp1fruXHCeac6BVT+cyTgFz3C1I=;
 b=GVWl/iNuqL7Let0Tu3l/8xD91HU4GtfJBO+uz7ByEeTjMzVsjllPm/t68KpZ+wBeuY
 1RAll+HjdlHMXH2LDYIK5TnEd3XBoiyu/hniupJ3Unv91LMavMEnmW+NcucNnbvyLAMc
 zgkPvMSC+Vr+Yf85Q01HnS32Qub7kXq4P1I/6UBumgH4nb7Mfvlo0FUe29J3RqNTpi5c
 DQ1SXEKhWl6mR1rN0P/kmW1ykyPF2b1ZdZ4AKHLLFglIPnHFwocCr2uF5L+Skp41Jqlp
 uLai7Gb/WQbaks1V6bQ0crg0m2Nrp/4EtmfxW5XjzcDI3ItWDM25mzC4MCBD+xvYFZaQ
 K8Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBweqlmHc9BhN149+oKjR1YtGGb6EpBXobhrzvWf60lX+EsSBEw8VNZxThq63l0+Qtf6VBNMrbM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLtGlE8vEYmlTidFbCn5u25MYf+BiNzGkKgwgykRtg7TyGwJCN8
 dhLtUdCArJycO8rRP5rWopR3lKl56EE7RKu923lDcin5WqDWNB3PzYVnQedgR/Sk8CCW/fLBPXi
 THT9CEXx6nw==
X-Gm-Gg: AYBFou1KvOBnXYcT1sNqN1MdjczwgIDWlNW/PhUgDIWBuG9AqGV0KbLW2B7dOYga0Rz
 DL0lPFUAMc2dsv6aEZeYuw8X8/9YYn16zhZ8Pt0n7FdBUmX69pQrJyxuXStV+zA/jSI4FfiWxrJ
 5W8UGUhahH8+iVLzgAVFc1758Ixwto1eRTEnZU3i9N9s0uI0bHk21zL5/U1AV00djgU6GPuELZU
 GtunODaiHIML3ts8Wsxp2P/ZD1DTjFi4ba28K5IFbHGZniQ32ReDfSpYsimauEwtGUOop7Rgh1M
 w8CIa36Uf0zSgd8s5LRfMYrdMLaPTVXZZkhLGXFtYMkYb39j8LrdICtMshi/esfSxjzSXXkRNhH
 MkgOiu7qVoGbnf55DsRoE9anKg4qGWd1ewjxhZimC6zn6mkUPyBfFvxZ6sgBAlITwu2kGgrYAF4
 Zb4PDXKS43k22iodfcmAW+/wZjDKnXekUkNNoW4KjjaL6ogdOH0I089xzuHpriveSlJenjhopEp
 BpJuzOZ0UbN+0NhQ1gzbpoOlHU01X8z80xFJ0M9TQj7q0eG6qIElAeO3MfTVr2QEKOv5tArKPJt
 xhqLEQm+0e2HBodzYp6dL8X32enth+nR2D29NaMsLqlM
X-Received: by 2002:a05:6a21:8cc3:b0:3e1:bfb9:55f1 with SMTP id
 adf61e73a8af0-3e928dd8d5fmr8646912637.53.1793631182279; 
 Mon, 02 Nov 2026 06:53:02 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb096da58fsm3275942a12.13.2026.11.02.06.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:53:01 -0800 (PST)
Date: Mon, 2 Nov 2026 22:52:58 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/4] riscv: qemu: Boot a kernel passed with -kernel
Message-ID: <auijytCQrkUwNdFC@lliang-1876.localdomain>
References: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 10:47:20PM +0800, Hung-Chun Tseng wrote:
> When U-Boot runs from pflash on the QEMU RISC-V virt machine, QEMU
> passes -kernel, -initrd and -append through fw_cfg and leaves booting
> them to the firmware. U-Boot ignores them today: QFW is only enabled
> with ACPI, and distro boot has no qfw target.
> 
> This series brings the RISC-V QEMU targets in line with the Arm ones:
> 
> 1. Enable CMD_QFW (and so QFW_MMIO) by default, and keep SPL_BLOBLIST
>    off in the SPL defconfigs, which would otherwise fail to link.
> 2. Stop disabling initrd relocation, which checkpatch would reject in
>    the .env file of the next patch.
> 3. Switch from distro boot to standard boot, with the environment in
>    qemu-riscv.env and qfw first in boot_targets.
> 4. Document booting through fw_cfg.
> 
> Tested with QEMU v11.1.2 and the Debian trixie riscv64 netboot kernel
> and initrd (Linux 6.12):
> 
> - qemu-riscv64_smode built for pflash, run with -kernel, -initrd and
>   -append and no input: U-Boot boots the kernel through qfw, the
>   kernel gets the command line and unpacks the initrd.
> - qemu-riscv64_smode with a GPT disk holding an extlinux.conf on
>   virtio-blk: standard boot boots it with the extlinux method, as
>   distro boot did before the series.
> - qemu-riscv64, qemu-riscv64_smode_acpi and qemu-riscv64_spl boot to
>   the prompt with the new boot_targets and bootcmd.
> - qemu-riscv64_smode and qemu-riscv64_spl build at every patch.

For the whole series,
Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
