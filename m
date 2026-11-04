Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7C606D831
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EszDmvhf;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CJqQMDLm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B12180CB0;
	Wed,  4 Nov 2026 16:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juraeyY-iNwD; Wed,  4 Nov 2026 16:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 082BA80A84
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793810243;
	b=n1HF35Nl7SYI0AOClIkDuE123JpJ8CClfboI8eo5usWQOpISHAEFoT8VtnYZNqC1RGnL
	 L3sTpamRQ8oOqzfXvXCIM1Mf041CQfa6cxqOVrf4v45vQVGlA8nGMUReFGw296vCMV4ER
	 Zc3p7tiW9CZMuWE7jjZtPEaAin0YT4/uS8VT/OQo9/F+lgQbI27HqB2afakllgrygdLVA
	 bfr+vvWxikRcO+BdGn42msFZExXUWrAKDJhtNmdI5xS7YeZd4FI4jG3FAJpaEn/QLryJO
	 oQcKD74FG7sOjzGCz13gCwxuxumWI/dJ2rpPiJdNT0mJ/cUDGxAgPxxAO9Nk0NPUA+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DqJrcYfjPbfEsHlUIY5rz3wsKIuevKRd8v0aKsITELM=;
	b=MllTzNUqDBt1ftIua2ak6xrz4XFJ+OUDbkpXuE1x/qyAnhzr9M45OfAfa0fbi42Nd+xM
	 3othTtXxB+4tgTcgahS9nChSmshqtxd8+KDFvHOJsToDeu4DPcP56eKPgcexXBnqqHvYc
	 iBSXHV+2slzw5oqBxFtuO/5A3J1k2lybpi3HeGUY58VWowupNljsJOR46J6cwBwceTJh9
	 d5M/tl7ltGmz6b/HcJF60zDgneUT5gNywHVX8plFsfdhqVv4s1IZXiOkkbggWTVD4x7qq
	 X1oiqDB1wJRdeSugz2lMxZE96wvqLJTGyfKcJ773fuKAXiKyR8bLxzdx+FQY8GpLEfQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810243;
	bh=DqJrcYfjPbfEsHlUIY5rz3wsKIuevKRd8v0aKsITELM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EszDmvhf6Xy/qdrgqh5n9ariUiFj8hra7EA0Fu8gOouCN9zsQqdA/xUZavDoDsju1
	 6CuzpFI1yJttb/LqjMWiDMz7WjoTJrhFyY3kYYzzfBd1uyM8y3K1qsQpYTeLO1IqeO
	 AzHPIvFgqX4VQ4/TbIWsiXx7GJBdObbGCOx0TjAgKRu2njPCynMxSjDFmjgrHsrjWY
	 im2+ySWYvzUq02O2dGLWNTneCMSJycWk/C7OMe48cPY4jSpAyW+s89ZtY4NFCGVrqf
	 BugnhSVuvQTxeDCEoeBjvx4B0EvTnQC5vwxtcR/SPqMKiBGMFWjcaMPrAyvfJSWBF8
	 feGaj3+4El8qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 082BA80A84;
	Wed,  4 Nov 2026 16:37:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4812362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA98140062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AeWcDDeIAXFa for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 14:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 757DD40068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793801501;
 b=CdZMx4g82s2O1FX4CF2d92XMOSgy/Th5P+LzVwIM5Ee6o5ZARlIfeCkVM90rS2O3Q6e5
 V//A/Y71eexyrcpSnb6fPM+JInNk/0WgRteiZNuZv7K7Q6R970XyU1ZoOD1ieG132yPnD
 +19sNfQEgzY9G56GcZdgHv/MhcBoq0SpV3tmsJjibcw/1gAbEZKkh3MIKgg2XjJ005pMb
 65sWJn1oFLT65eu2bCW/6RdrL2Cl0Rdx465l73lNHzsJFO5Z8WaAjiO++kUf8pxYxlWxK
 zwc6Bcw165l8VskuHH2RXhCcvVAtuFov7ml+OIVvf5XTI5tTBaMmnjEddwOns5YRpYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793801501;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=DqJrcYfjPbfEsHlUIY5rz3wsKIuevKRd8v0aKsITELM=;
 b=gograp8xfHXmZsAoIxNl8Y6x08hEVS/eVZEafV6+2zScOKe+gpyKOe0qHV9f3VN26U2z
 2VXxuowJr655lcMeJ+vgHQwMiDplabf6cZo18FZm/j47cFBrPiJbXIwBxYmoW3RBXMrcH
 aROVZLd/owzXFBeqiffW9gUDXNZ4ZkjE7buoxq0g0QOcn4NPsqtEmWBgrdvhDbFSEqO+e
 1dPLpIxWcfpok0SbTKWILzLk7Eg5lYCx6d5hQr7OpEVtLSuRR7BULKQD/Gp/l2a5iBQsD
 Tyq0r+ZpahBtyOEhFtjZ/Bv6eUQMKPIfb6oZ7BOXPMQ3OBq1V/aU13KrlwADfnGnvMA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=qq.com;
 spf=fail smtp.mailfrom=qq.com;
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=CJqQMDLm; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=xjmps7114@qq.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=qq.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=CJqQMDLm
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 757DD40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA718480F; Wed,  4 Nov 2026 15:11:33 +0100 (CET)
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com
 [203.205.221.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 129BF84823
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 15:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=xjmps7114@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793801478; bh=DqJrcYfjPbfEsHlUIY5rz3wsKIuevKRd8v0aKsITELM=;
 h=From:To:Cc:Subject:Date;
 b=CJqQMDLmdCQgfXBLUrOXtP0E+36vZKTjz+tNMrRZYiTW73dMEa+XLqzjh7kCgLlC2
 urlFPmgiMHRbInQgYEoZcNhofYn7+ABlbSnDaN6Y+sU2AEOGzQNhyB7OibkfMtoCld
 NxNUtmfEhhOmgZSVwdoDRC7RuR4bkje0BID19n2Q=
Received: from localhost.localdomain ([27.38.1.195])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 2D030261; Wed, 04 Nov 2026 22:11:16 +0800
X-QQ-mid: xmsmtpt1793801476teebio2o8
Message-ID: <tencent_4D4A63A00ACB3E875F30AD14C1B8961F5D06@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznZwa6WMUCD7+j2YVq7T+xPDhdV6zYw+04ExzrTjgFOu5fFp4xFt
 C+Clu//niEaw5+XnnL1BtNnZdpi+BiIf04GCb+Fk/NLxSZ5Y+9Vb1oAC8qvgatAdMmmE4sqY0Xt5
 ckHOR+MrXeLUWnrBgEqSCHVoPU97hETBd3PEr4bRvg8/WPSsWj39Ecxrqnzvfh+62uWiwh+H83QC
 Fqj8w75cDf21n60CgwdCx3amU2dZ5ScitrVSb6aqbUGUAXzVIBADDE1aS2O8o1ZgL/c+iMjNTOOT
 4DFg78D6H6TGTfhC2kX9DFa90528rdjfPKRx8FlGrzBOvF5SEsEd3jQSjJPSnzSmKnfZDDTX5uXc
 nb6BVMm8yNJWL2HeZikD/Nf1oPdongcCIUPhRKwfXbYLaC+PrgmRn2XbSD26tmywSmqSNcnEjNnN
 NCuYWt5GSjnvrnUcGwnPpRnixyuBgd9pjaxSeG7YrUyenAhTPyXcb0cV/TRp3ju29VZeiRnwzXqS
 l58prr5hlmVxe+L8R+G5efxX0QwN3pDHFxHLOXLKrPuFYhSsb7eoYJx18EbR3wP0j0zxHl8paWDK
 KJdkaXzsfoj7xt0jBSFwMrhIho4SgahIZMbRGc5Ek+gwByiSKtdWm3oylwL98rXk7wiIF+ZiXiE0
 ey+uo+NqrxX+Y/4L+YDM+MhVTMpRD8S9qcL7/Cpl0btCLZkBQfoHb4JiHfATk4A/jjzukrHMjvYI
 0iWMqD9MXlWhs++wfR/OtaiivjIGmYFkNhW/muMWSSS3BiAK2bg07e3UOXEOF3ZOnAnov3TY3dm6
 utcjieZncK97lXcPL3W1fPbWvVeXOdhf8Ywbv2QWGJes442OKfq3FSJb0D5wEahDLAx5HCGE0jes
 xp/mfPejJwKM771DMNG6xQbX94n95urNEG0WpgSXFYLrBgutJ4BeJbQGfWb6yT/5W9IUFO1Gs0rh
 eBs4BUTdp4qv1xwV/8ifn15l6xJPkkrOQBtdjdf5Jabt0YfxDfvIEmJsvwWVrpcjagxitvvQ640z
 06w1ymBvkEEP2XtMFp4FcpuGI5ALe12llgRFVVlSSKVq16z9ZRRJcWF+sABXl48dqstEG1MUBJEI
 tK3qjg4JH1XJLdjc8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: eli <xjmps7114@qq.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	xjmps7114@qq.com
Subject: [PATCH 0/2] SPL FIT software rollback protection
Date: Wed,  4 Nov 2026 22:11:15 +0800
X-OQ-MSGID: <20261104141117.12284-1-xjmps7114@qq.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A verified FIT is authentic but not necessarily current: replacing the
next-stage image with an older, still correctly signed image reintroduces
vulnerabilities fixed in newer firmware. This series adds opt-in software
rollback protection to the SPL verified FIT flow.

Patch 1 adds CONFIG_SPL_MINIMUM_FIT_VERSION: after signature verification
succeeds, SPL compares the configuration's "version" property (covered by
the signature; missing counts as 0) against the minimum and refuses to
boot a lower version. The default of 0 disables the check, so existing
boards are unaffected unless they opt in.

Patch 2 documents the mechanism, including its trust-root boundary: the
minimum version lives in the SPL binary itself, so this is a software
trust root only.

Related work: "Add anti-rollback validation feature" by Sean Edmond
(2023, Patchwork series 372657, currently changes-requested) addresses
anti-rollback at the OS/boot-flow level; this series instead targets the
SPL FIT configuration-verification step and is complementary to
monotonic-counter approaches (RPMB/TEE-based).

Validation: the same mechanism was validated on real StarFive
VisionFive2 (JH7110) hardware against a vendor 2026.07-based tree:
signed version=2 FITs pass (cold boot x3), a correctly signed version=1
image is rejected with a dedicated message independently of hash
verification, and recovery was re-verified. This series was replayed on
v2026.07 and builds for starfive_visionfive2_defconfig with
CONFIG_SPL_FIT_SIGNATURE=y / CONFIG_SPL_MINIMUM_FIT_VERSION=2; the SPL
binary contains both the hash-verification and rollback-check strings.

eli (2):
  spl: fit: add software rollback protection for verified FIT
    configurations
  doc: spl: describe SPL FIT anti-rollback usage

 boot/Kconfig         | 11 +++++++++++
 common/spl/spl_fit.c | 24 ++++++++++++++++++++++++
 doc/develop/spl.rst  | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

-- 
2.53.0

