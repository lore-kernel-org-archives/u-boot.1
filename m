Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0645CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AF0840DD5;
	Fri,  2 Oct 2026 12:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kKpMS_FRJ87z; Fri,  2 Oct 2026 12:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4FBEA40DEB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790944002;
	b=Zete7TK7E+kW1RVUxU3gTDaJWW39x6UsuC9+8++XRW5sZK+8RSf2TtrlFpD/ESs5Khs9
	 Rpy7X3VIbiW2QmNYjzU+lqQDD7xz+26eIBzcaorrzfR3/NUR3MfYO4eY2SZE1hq6ZYTcO
	 6QKAZ4cWgdb6VAI3Uc21or1suNPScKvX2ShIXDPF8wdaigYPg17Ow7DzzU/TqI2TD/pEE
	 eF1zIYDEm2rTIVOdQQkzw+6cTdl4JFMadkySunv85x39PYI02vL7a802y3rGs29K6/Jt1
	 ktlUv8hWWaU2ngnlIgsKZfcQ/KvN/7mvJFypgTU6+Llj39lZtZu54z3ttZj7qMT8O6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790944002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tJSOJvJMXc8BT69MnPecr4FVWVaAkxN44onjjhlmjRg=;
	b=QAR4ORYF7ryNDqZx0fguga6GM6rTCnmcaXuAGGhRYyq7NbG14AOJtLxkLBy4ZwK0lMX+
	 aOoXTAt5MDA/4yUb1f0rHv1/i03VCbcXXuxTno78pN+zJZfOuzXWIuekhbVp7RVL3TmTG
	 ZdaMrbtW5Drrg87odeLwbWGwqZ+NDc35g7pyPLluN+b67BmnLp6kYxgQCNnnld5+oQYq4
	 4UUFV5bnnT5usN4jFRoXaFIFZlfRvdlFtwekauEZWUiA9MFei7lqSOosEBfsbSdPrZuUQ
	 EIDWJaVVFx3dI67tpujDLjlLLpqxua0qmty1tL8XXSGFxL4XnJQYO93Oyaatvq9g+wg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=mghI9GK1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790944002;
	bh=tJSOJvJMXc8BT69MnPecr4FVWVaAkxN44onjjhlmjRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FdGGyN9kkTh5RYqpVu7e6t6d4qx0KIn8uwI1MFkBK7hbF/o4KOufsV6YBGPIjn4fw
	 bT7HAzxfuMsFzcaIysEMudEUDUKtkakfZEs89W8YIuKkmXJz1v7UZcDta8gB+u8V6g
	 ssRsyDv9IrLojTxhPE5oR/gES5oQMVILV9xAReqzPLQY7nuHy0J6QiM+MwKuH0Tei+
	 3wKDEYVOhRuUvf+muQ14vGiYE8XNdqIGlCD6o2O9VEjDzKnnHYzHP2v//eJXJZycqX
	 6njeCGg6DcgYHQX/Gk3vS8GbqtSO5G0Nvyp+ran2lqc3SdOE4CM765t1oTMwEWAQXU
	 Mnmdwwui6Hl1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FBEA40DEB;
	Fri,  2 Oct 2026 12:26:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61E8132A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5434140A56
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tBxtDtNl03sC for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:34:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7BEF240A54
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790926478;
 b=c6A+3XH+Xm307z2zGZr1uRGoG0qoy0yvy+yYb8ezPfw2ACZr5Rz8TQ8S5EdhyCGFhGta
 A5gOPiNe0f9ozxN98LuIfKeKGTH0cpKteLtU29Ust0BaiSyjMleaPGv4HtYxckcnwflre
 3IhxmFy/7eREtkfqTOfR/Q3LQZyCjGxMxHPMsqx8fijEPgYNkMuz8mvR2G3XrBd4HmaCB
 HfJjiXbIalInxUvolPn27tmip8OgQvt8Z5S5MpJtuux2x5+NCbj5TpqFoZg7q5HNIpf8U
 3kuZveIuHpOgHaZEFVTAYhpbdp8iR6udxr17MoPobIMzjfrxSmLAB7DuJv5aTDpDZXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790926478;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=tJSOJvJMXc8BT69MnPecr4FVWVaAkxN44onjjhlmjRg=;
 b=X7GWeN1mw/tyFzfoVO5rnClUsVZp8JUHY58e9ZeXJ7Qu72/WAdC+l0xdbleVu4NC7/vE
 qAkuBHzertHskbSjlQlCG/mpbpcQ9w2NUQkoY2W3v0L0xdxDk2aqbwfXI6aXxA/Rrnqp2
 uHW2zazR5IyfqjNBYzI7SV17o5C+90AWDyt3xWwlZ397Y/64BkQGMF+ictDBcZYVoDPQo
 wBm3cHUaFog7OlJRlhG82UiBsiLofwJW7lfH95nVUWL3Da0LbHyUFZW9kZerkPJ9ikSQF
 bAEiwFAaPM5biwSfPySWwKEge+WW2veF/WEPyGP9R8LKZFOBrRkocUZwOkm08V4cq5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=mghI9GK1; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=mghI9GK1
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BEF240A54
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:38 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 400FF44DF2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790926476;
 bh=tJSOJvJMXc8BT69MnPecr4FVWVaAkxN44onjjhlmjRg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mghI9GK1D4HhtXuqY3d4Dq2ccoNeDJVbo7gYLTpC3exNRITNyWQfTllg57omyQ8z/
 Mb/O5mJDStqHvHYxO3tls2R5WGHqLxd9r8IGqPIzSdUPSHDBMz+mvfIcfDoWSjhDvf
 JZ5XGwAQrEWej/JUrMJNKbCdRvbNUg1gLXf7X4g++hsCcEn8Hxb6z4QA/+84vtVwhx
 un+cdHI4xFQtJvXQqmuw635r1Eud1DWIc92nPzT89KPv8rnd70yBmR6B9usXBHgG+F
 SjKmrviKZSCi9V2dYVl+wlizaQ0RFMk3an1vXqNRCfoJxl7mwPXBSACdaW3siCERZa
 YFDMhmB5kdfCGPpHTRKxgTJZ4xQWk3UsMTSBnYN2rsS1N3m7bEXvF+mriVM3laiWkO
 NKa0bzP3PiUxSkZnhxaKxenEEyBpfiCewAV3yf79obSkUB44OXFiiOunNoup1EIztm
 HzZ6FjiYEQGeaqgyPPJ5lmzilsRWRKWfVEr67/Ro0K7S2czeWueRVLDuybGCBjn1GK
 ctSKGOB7Jr78NEaZy4eMmZDhW6Uxt9SNAdRMme916KfrGEOeuWc2/hx0RXWWEegp1U
 CQHzWASY4lLNrINWa3ea+ax/pVPcl3eauA97g8Cl7Y41cn9Hvo3VjTI+TIeGikbYN2
 ILKkxvxnmTgjWiMGqAClbd3M=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so111350045ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 00:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926475; x=1791531275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tJSOJvJMXc8BT69MnPecr4FVWVaAkxN44onjjhlmjRg=;
 b=WggGZwTnTVsfGjIAZydSqODq2Zef+9R52edtLj/sWUOn3CJZznWTHWRnI5LegbZoVE
 7IUzk5Oy3G5OckAArFL+vHnAQiYoSJLNtTiaWiFGeHIVtqCwESPkokS/ZizJFhC8ZQxv
 0prwGnE1hf4qXqs42otsM/CCh987HADIwhGtvqKNcmOubGmVw5jGDvwiFz9c8V1e6fF4
 iVH7W7a861CsX5btQhh6Utoy2iEdUJyILx7vGJKMiGaLEGbhDk3WTrVVYE4uM5NkmVlE
 2tzVSJG35miveLekLXBG2gtAISYLPoX2QMmtbkepUHqieEJpKCmfcilOh89gfft1mTOX
 NKxQ==
X-Gm-Message-State: AFq9FYJIUQe8hFje7RDgIsAUyenZX3U1lHOVPpcUt81GfyRQ+bGREB/f
 d2TfrQCIJxob9jyVk+82rTVn5Cq0cSxZT0lsFbsbScfZ2UzU4tpCoQKinFMuUOWL3ew8jNrX3zt
 JDhg9vGCEvUVrpBjd9Z4t/mwvyYk/sm1ZfmD/BozRekomEkKgaqKTkIknLAgYUYt8PkC9OwLrDN
 Ixnzjn5w4BNgBdoVUOlA==
X-Gm-Gg: AYBFou2xL/2CKFezsf0u4wKgN0PycguXjuOn/i0NbfBd25iZCXY6RMkDRCecopq6eqy
 xmDhSvmUWESw40wtM265njn2Gk0r+ct/D1IUN2duSnr6vqOqp5yQCNuQLztDiuBVoyiUSkcv4rm
 bdtkQ73lRS8rhE6uDk/LIpzBwZ6OJBlhHvotW70pLJZoWXkUEx28ZDgrT5pUEZUIoNKeN+SfDKI
 m3JbO76XVgpDyG9itBDLpZWTu7BRdy+otenBubGoIsJUqiIzEpOrkgCBWy+MBEF/2fdVkCiTPfs
 qd1kJW4/I8c5zUqY1skwC1OyUSVyu3fXGs2O63JEtYD7yOzVIBd4i8WR+kfFPMbVDssSG2x6kP+
 UMMvW8rHWFrnyqPLfbj9Hm0IeHro/ZaQs+Jz8n7PQUY+WWbgvGyU=
X-Received: by 2002:a17:90b:5347:b0:3a4:b061:2765 with SMTP id
 98e67ed59e1d1-3a6cec13adbmr1807676a91.15.1790926474581; 
 Fri, 02 Oct 2026 00:34:34 -0700 (PDT)
X-Received: by 2002:a17:90b:5347:b0:3a4:b061:2765 with SMTP id
 98e67ed59e1d1-3a6cec13adbmr1807665a91.15.1790926474187; 
 Fri, 02 Oct 2026 00:34:34 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd44c2c9sm3172004a91.6.2026.10.02.00.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:33 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Subject: [PATCH v1 3/6] acpi: drop the duplicate ACPI_PPTT_CACHE_TYPE_DATA
 definition
Date: Fri,  2 Oct 2026 07:31:53 +0000
Message-ID: <20261002073357.382228-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002073357.382228-1-aristo.chen@canonical.com>
References: <20261002073357.382228-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

ACPI_PPTT_CACHE_TYPE_DATA is defined twice with the same value, at the
start of the cache type values and again after
ACPI_PPTT_CACHE_TYPE_UNIFIED. Drop the second copy.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 include/acpi/acpi_table.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index ac50ea10312..d1710d80eee 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -830,7 +830,6 @@ struct acpi_pptt_proc {
 #define ACPI_PPTT_CACHE_TYPE_DATA	0
 #define ACPI_PPTT_CACHE_TYPE_INSTR	1
 #define ACPI_PPTT_CACHE_TYPE_UNIFIED	2
-#define ACPI_PPTT_CACHE_TYPE_DATA	0
 #define ACPI_PPTT_WRITE_THROUGH		BIT(4)
 
 /**
-- 
2.43.0

