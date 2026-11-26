Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D6606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bQv2VysW;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Ks5FU4sb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4889480DE5;
	Thu, 26 Nov 2026 05:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQZikvBTBQrR; Thu, 26 Nov 2026 05:01:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FEF680DA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795669307;
	b=mR4Fzscmrrru0tGHIDjuolZalpJ4zxXD3LJwCpBm5zWg+7WLy/veDDolp7hRJm3hLlTT
	 Ymr4Llb5xl/2iQfAm+2/W7L6IM4uLFC0UhtRPEs0Re1107lJKe1Lk0+ekTvEBhLoelWiW
	 jCPrA67D3lxagABWqXmrCRBXFyj7O/OD/ozcF+voafA6cTO8GaPkrifnrLSFXyz7UwBBw
	 JNiZ/yf+1vYApDEp3tofzgJvrTjmX99ls0omFICuaneYcW6KV0eXrKKgyZ+6JjDCl8JhO
	 O4ASrX6HbvixH7BMi4AtZkcA3X/GoJVLdfpBSPoAiHz19a6j4IHPY8UdLHjoX3IJ2lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795669307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=47SGSR6ZUVrtGx0g8gnswzV2LPBUE2QF9Cyhi0n7410=;
	b=VQ6AHnMFDKZkdVwtz0FTgSQ1HeMIZnSkwNKuySSqZs05kTepjQjXyHLrd+iTijryHrHT
	 OyAeTSkDQcWV+U/29uUwH2/FheU5zCyP4btnMBfW0+KJ/qjVIWbtdMPoYW9fTCIX+Ao6z
	 aLzaQcUsJ6GLAXAgjxYwZXfo3BHmcBvRJZ7sEI/LMlLTOiRsL0uTc1XvgOTbVfZnVz60Y
	 qcLZdafduZa6lj2fld6SB7m/fQyDVfUrPs5nTgq/70Vk4MRFglRC4Nhespa1BjpxFb8ND
	 uF4IcEf5ULjaSF9lEreVd+KLBjv+tWt8RAiT/VmRn2Tqm2t7p4sfPd4qc0D+syQx4ZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795669307;
	bh=47SGSR6ZUVrtGx0g8gnswzV2LPBUE2QF9Cyhi0n7410=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bQv2VysWaN2vPxZaBHsXBeO+/Tab1+4A2YA8KnCV+Xm+nhyZjZjkLS7i8zlsXmvwD
	 gtAvdl/fRzP1tNWWDi6LNHn2PG1JUQB0Us5IDH+m15ct4pPSx6f3XobeqnTbLb2zJA
	 9WXa2newxehu+UOURMFE446n10Cduib5L0n3St9kfnbgvIXON0irqfc3WtxcLwXLiw
	 4/KXAjmXqrsbpQbmiwLHLD3EhEjMf7pgaUFv4DvIyyaseKWA4dyptEuKFClXK6xQqY
	 yjnw+dxrP+EvqaNrSOvdPWAsHVX8dmTj/QdRgK8P3OkD/JDI9+uDUsyWgti7EWA6nO
	 KwfRdrxQRuK8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FEF680DA4;
	Thu, 26 Nov 2026 05:01:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F12C0371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D70DC4004D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WxSs7UQx0Nto for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 00:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F01C540024
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=97907298e0=cyan@meta.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=meta.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256
 header.s=pps82601-s2048-2026-q3 header.b=Ks5FU4sb
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F01C540024
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 00:19:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4EE847DF; Thu, 26 Nov 2026 01:19:53 +0100 (CET)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C59883108
 for <u-boot@lists.denx.de>; Thu, 26 Nov 2026 01:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=meta.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prvs=97907298e0=cyan@meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APM1kCF3576277; Wed, 25 Nov 2026 16:19:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=47SGSR6ZUVrtGx0g8gnswzV2LPBUE2QF9Cyhi
 0n7410=; b=Ks5FU4sbySDCKunlTvbAdvA/t9TuQLQx7xnp7YpZZkvjiYahjznbz
 4Rlgy1WUjWHkUo13eBjUVbJBu0Jakan9yS7hS1rqVk6M6zUNwuThICsRwbWcyBMq
 akticnfM/L10XIb8YSNgG2U6VG+afeEV6ctQ0TOdE8Ub2XcWTazhvwzJMSQC2yfh
 zgniKQTut1Urz3y09A9QDcMapMhgnB5JmOCBJv7Q8pQbrlt/kVbJcIDKjUD1xTCI
 GoZdA4gR3+2tv+v/NQ+UNrmSrmy7OJWGxrfpi/Egzsh2CEfI7DbIOmyaNCwDDKhZ
 Gu9uDc7vjpWLWdmjPKS3z+P8fDeFe6H+Q==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j5fap21f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 Nov 2026 16:19:33 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 26 Nov
 2026 00:19:32 +0000
From: Yann Collet <cyan@meta.com>
To: Ping Li <leeonion.muyu@gmail.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <palmer@dabbelt.com>,
 <pjw@kernel.org>, <mark.rutland@arm.com>, <alex@ghiti.fr>,
 <emil.renner.berthing@canonical.com>, <masahiroy@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/2] arm64,
 riscv: boot: emit standard LZ4 frame for Image.lz4
Date: Wed, 25 Nov 2026 16:19:20 -0800
Message-ID: <20261126001920.3185323-1-cyan@meta.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
References: <20261124065650.1968930-1-leeonion.muyu@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwMCBTYWx0ZWRfXxbv/lVsq1VIk
 U0jO68Ek/ZgfsEsUosNAmLzdC0VirBIXx78XSk+Fq5RBm4+k+1rivqMjUwr/JkjKwBGgwoKINcO
 a4kq3jm6yvQ2sBdXF+SU4cakzZ6pnOepGKRJDu1NeVNYuwKJmgbtH7Mrx8EAxxJnO1cGA0sXjX/
 nj4MHBy+g4FoIEjN+4fGSAeqd/V/Kel7rj/LdJecWNWCSNww9ik9cUFbad76xX0ls2vQbJd1BLx
 5dW+FdHymNwf9Sl0rs8NbC4V/61pQazg0IU4+0DXbwpegELioNusqRinOqQKUOWxp7SLDI7Nlft
 3fy/YX2LE9cUOMAmzPoE07vqhXYJfsMRthxXPffT6gQgf8M5Svch6btsT+/8xdfit9hjyJng4l7
 wI6g6IVUFIwzhT66lqD8HdZjLZ4nIDw1EL2obwB/PLSLIOI4R3tQ+VVT9Mf7jNGU73f9dBsO27e
 MSMKyS9OcP5ruNhA4ug==
X-Proofpoint-ORIG-GUID: HS-aMb4GaL-DcgH4Ivl2FAW5exzSSANa
X-Proofpoint-GUID: HS-aMb4GaL-DcgH4Ivl2FAW5exzSSANa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwMCBTYWx0ZWRfX18KQ9ZGKAbE+
 EVc4wzDNAFesY8zM3PWxWiU6yVP0JKrGdiVtGhN38mn44y0pozgkQN+/oLGAxKto4lOyJKFdCaC
 vfgZhIH/NKuJvP6fN1xWWLSDEmEJZVo=
X-Authority-Analysis: v=2.4 cv=Eexd0/mC c=1 sm=1 tr=0 ts=6b077b15 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=I0HTz2J1b6gKnfYguBMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 26 Nov 2026 05:01:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 02:56:48PM +0800, Ping Li wrote:
> arm64 and riscv also build Image.lz4 with the plain cmd_lz4, but a
> compressed boot image on these two architectures is not decompressed
> by the kernel itself - it is handed to the bootloader.  U-Boot, which
> implements this via the 'booti' compressed-kernel path (boot/image.c
> image_decomp -> lib/lz4_wrapper.c ulz4fn), only accepts the standard
> LZ4 frame (magic 0x184D2204) and returns -EPROTONOSUPPORT for
> anything else.

U-Boot's decoder has a second requirement: independent blocks. It
rejects frames with linked blocks, and the new rules rely on
independent blocks being the default of the lz4 CLI. lz4 is considering
linked blocks by default in a future version. U-Boot can learn to
accept them, but bootloaders already deployed won't.

Passing -BI makes the output independent of that default:

	cmd_lz4_std = cat $(real-prereqs) | $(LZ4) -9 -BI - - > $@

With current lz4 versions, the output is unchanged. One caveat: -BI
exists since lz4 v1.9.0 (2019). Older versions, still found on some
build hosts (lz4 1.8.3 on RHEL 8), reject it, but they produce
independent blocks by default anyway. So the rule can pass -BI only
when lz4 accepts it: 'lz4 -BI -V' fails on these older versions.

Yann
