Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD2606A327
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jondu1av;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Wi39PyUB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF0F3407FC;
	Tue, 20 Oct 2026 00:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRZCA8rrbgD7; Tue, 20 Oct 2026 00:11:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC68E407E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792455069;
	b=buXlNqSkuuo0WWpQKhToIl3CqAb727IkDTGztcU5VGcKCatU6cAC+oalbOCAeL4wY/CT
	 EEqbXggNa0K0jeGv+0oP+XNmg9XUurgJlOSn1uwxBfo4vmIYUYh7BUlafu+anA3PX9cbQ
	 3a1laO6ytzsp/tMOMJ/g9ieVUHC6AE2nsctyoWX4xf6s+MbEQvRcifLuvqDiMtXGqvrND
	 tn6bnm+0gBBTyp6H0lN00hcT17bJzliLtGv8daaqJcjT5afYXIE03A2gEaJl7mWPGcqPz
	 ovnsNV5Dtzoineyv8wtroqcdtjq8RQfUocGiFDY8y98aJtzg9skkcbQpB2vR2ksMjxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792455069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q3y11TzQ7p/nBcX5+dZtJFqYnnV3eNkU2t/BrCyx6aM=;
	b=lWcv6CbK70+QsxPIBTsVSrX2+tnyvlwGGxoQUBtxGfiZMO3cO2zaxht5G/zTlo6b2N0x
	 1ik+k3Ia5AAPVe94OlQk735fgx7HbxM8rkcX5KNq1Rj+9Z1Ca382vQv649dWIz2Hu6PtF
	 6Wo8Z06D0I4sSt2sUkq8hCKTkgTooqCITObA0HimxL/BGdS2ZZPbjhCSbuJlITsLGOv84
	 4Hq/wkTFAxam5N8Qw7savdnd8GrgDykweUI5hsGGC3ANBG1ibhZLyl0l5DQg0mhAydVkY
	 X9zQjujNrmXjExYzleKiJHrFCowOllEX0vX7y4RFgcoR99Aqh9wKqN1OGm8sfbf3ZkA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792455069;
	bh=Q3y11TzQ7p/nBcX5+dZtJFqYnnV3eNkU2t/BrCyx6aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jondu1avA01GFbSS4XK9o6V/Ki+7pcLeCyjMjnMnIOaXjNafKmbTldrtYw7IndxbU
	 Y/QM8DQVDA9PRjMZFQZgtgwpf+TCe6fpFEssziLjMxkColeN5Opp3/2/fbcuVj/WFV
	 KE2Q5QPAw6rKmA+SlUEcm62vw5OHczjQv33NX/2hiTCNHmlQfK+LJouaTWXif40DDQ
	 ddo5AslxJize2LGo0Ms4HlHYZrzoRoJZkRJrW3ue7JctR+Fkit1f7M367Pz4TkdjqK
	 vgVwpI5aK0NXtNu9cfBPXEVpEYGgR8RRyb9Oz9gkyVBWjiv/VPq6WM5RVhF9IA+Nq8
	 AOxRgJEvNiYkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC68E407E2;
	Tue, 20 Oct 2026 00:11:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD3AD1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9711A40312
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Blr3N2NnM4dS for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 00:11:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 751B840313
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792455067;
 b=NfAiepSLH83qpVcty/11jSfzCZUS+fqFFkM+dDyWc+6dz4uMASXzj6YRZ798lY7cPfWG
 Bkqdudy586IL0+01/ZoSvRh013vYNT8pJ3xQRybaYQWGL+WSIPpfcStOgEpAKhOzSeOXv
 ZHv9D0MXFzm6yrYE2o3F10MmewbOkTUnpWXWueGPH8h4zmZxs04q0EnVLmzyVVBEhtSwO
 iTeWgBnOf+TF97T6olxmUswYjxnNkZmoCrVLXQIt7/lg2xG6L/1jp3qKNml7kaeW4MqDB
 uL8MQ1Gr3tYgOjOYo3H4FlM8GZ/pHNaDsmkVPf8XczlwbQe/0fMnowWoWBtgtLClsGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792455067;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=Q3y11TzQ7p/nBcX5+dZtJFqYnnV3eNkU2t/BrCyx6aM=;
 b=G23fwxmuhLHkW2zdzdZUdZC/66R5widyqTzRLccBch4UsgcAmEspNxS85EyNd5EDz/dq
 1bZ6WYK85XizlgBprNKzaC70lxi4Z2LpW75f1rRaKh/QTbzUOip3ChxgTN67K+7TJUSHv
 fEKV0K8kJBF48SLNcrwnM/rvud+s2u3wSylU9qXMVP9vfp1uvZIbL9LNYoAAB1n20mdJp
 Dr6fQ2jc2Yt9/DJFqMz7SO8R9Z2Uo0FUy58wu4utOOBOCjMuBm/7/72YObubPZgOnmfiS
 82q2vSSxGOvPU1F82BkeeHNutW+8JW1lZ5VlRULyFKbTqdZiAYQNv3L035I2VXkKGwA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Wi39PyUB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Wi39PyUB
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 751B840313
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792455035; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V92s+BFKZyEBC4cRi21uR6+k5mr+PSHNI5qRbsDrBcjsHX2ojTOPlFYT1xxmCTJFNXwpO5Kuzwbw7dh6m+tUh9lS1DqmZxaYfI84M2EDukBjmx2n2yeq8A7CrBligez4qqBROZSW6DRCk20oGEHeT8YqeJAoHN2GlSpLrrn+I6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792455035;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Q3y11TzQ7p/nBcX5+dZtJFqYnnV3eNkU2t/BrCyx6aM=; 
 b=Iu9GOXq7Yki2vNPNLxFUzIklrlc4QyCnfjUrLsp7bbrsayt8QdIfj6ZEkUnK+SEGDLi8cn3hxxHr7ssYHZh3MPCBGvk007OlKGLWhkCPDpbapzhQ56GRhHOtC37gn46E1QmiBrjx/7F4q5KPggqdZMXgsXmvd1NkHbqjJGDXLec=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792455035; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Q3y11TzQ7p/nBcX5+dZtJFqYnnV3eNkU2t/BrCyx6aM=;
 b=Wi39PyUBQNnRrPL4IXFGgUbYEE6QgbRy6lAn8AXRCFR6GzSx3wb2DUmEC/BJwZPp
 Dj59ImCe89i6G3JQXr1nn5Au12QI/qg4Qywvp4DPdx3KBpRcuQEQEXe2b4Ejix9EP6Q
 bpxZ6u3oC1ym/v+YtTZV0uHqylqkCG1lG5G8Ze74=
Received: by smtp.zohomail.com with SMTPS id 1792455031358294.23540044467427; 
 Mon, 19 Oct 2026 17:10:31 -0700 (PDT)
Date: Tue, 20 Oct 2026 00:10:06 +0000
From: Yao Zi <me@ziyao.cc>
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH] bootm: Relocate RISC-V Linux Images before booting
Message-ID: <ataxXt_iYw4fzR9Y@pie>
References: <20261020-bootm-riscv-image-relocation-v1-1-e583a2dd1d14@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-bootm-riscv-image-relocation-v1-1-e583a2dd1d14@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.448.41
X-ZohoMailClient: External
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

On Tue, Oct 20, 2026 at 12:13:03AM +0800, Junhui Liu wrote:
> RISC-V Linux requires the kernel Image to be loaded at a 2 MiB aligned
> address for RV64, or a 4 MiB aligned address for RV32 [1]. When booting
> a FIT image with a kernel_noload payload, or an Android boot image via
> fastboot boot, the kernel may be placed at an address that does not
> meet these alignment requirements and fail to boot.
> 
> As already done for ARM64, call booti_setup() for RISC-V Linux Images
> to obtain a suitable load address and relocate the kernel before
> booting. This reuses the existing RISC-V booti placement policy.
> 
> Link: https://docs.kernel.org/arch/riscv/boot.html#kernel-location [1]
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks,
Yao Zi
