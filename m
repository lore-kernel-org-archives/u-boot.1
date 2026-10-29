Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VwZShfya;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=NuxcH1x3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A55340775;
	Thu, 29 Oct 2026 05:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbkMI_bl5MOt; Thu, 29 Oct 2026 05:08:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F08B40756
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250514;
	b=SVXKkEb7y3rwA3nlHtcc6ntrE8niSt37mK0DjBNSixR/GsnsvrwCT4JYowBZpmRUVJ1z
	 vZXJouZaSpGQ5zeuSJENyW3xEtCv+UJgArMG80WhOHr4Pfx364OI+1Lho1AClC+TD7l67
	 Gz7b5voHFy+3uP/cGQB09oo+l8df9A3i/u09dYgvI9zkoo6u7GSu5n1cYdapNvARb0s4o
	 maXT0sci7JZiTgiplpbpNqdiivDV8DAOBeXdz9TWeWiSonU1Q+d5KpM3TrTEglcqcTKNS
	 tULcx2QwDY/d/Tz58MfXxKtsuqqMDvge4Jhj9o5bxbzZTFhbjHc+dB2JFRpJq4AlJxA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250514;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=;
	b=HpaCE+M3uJr4oQ6tjq2pyCPruEDJeqUSXxy5peH7o4jBG4yC+HzBTm+Ic2POa8lXSfNq
	 mdfEf+GtuFTHGv4NfKpsN9eiQMM/EE3+6qBLvPldwjMMuk1x3RBQVrUVzhdPPRC3/EJ+x
	 tuf9y7DnCEBwrrbibFoOpnbQ9Eaf9WEi7IEJ3xOmH7y7Qoe9nXagbM8ml7HP1jhxesTCQ
	 PdefneSPmUuOQWDOyDJfDWHfXpq5Zn0k587mTZgWCXOCIgW6PWhjgYCa3pGR8S535l4T+
	 eVhpMroCpjtsHmAVA6kdw9n50rehQRofElTJSOfMJZvbB7WFUaH73LFWXFgHH4POjfg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250514;
	bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VwZShfyaIrdJA06qe8jvv19OaB7iYCWNnetxS2TTsU0/FVPau37h0ZIeutiOHPMvk
	 /93UxPlULttn4TqdBd6ucI+RiiJeDJCN1wajGq06MNAf9jPLDaSlPF6eAA/mV9O/Kx
	 6o7QpFl4ddneGeds2TgMwgp+jB1GR7N/2apXb6Cv9A7STL+DyeGN93oOu3f4zsfj54
	 Ly6S2w6LXMzmxoJGcIcPMYcWOK6qTrqBTrASTiSTykmPGSOeZ2ef2JYp0Qj2GIJmfK
	 8FK1g1FJLWjuRQdO7N/4Rxs/72pmnbWwd4RtGrSTvlgyhisGAGCZBMzrr3ep7hrRuw
	 WStK8OE6OjF7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F08B40756;
	Thu, 29 Oct 2026 05:08:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B48B5380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A686980971
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIoka2lYU_Fg for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB5E280F75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250508;
 b=lFm6Xp1SMHl6fIbrhBDRskGs6LyZt4zHOVgo1qTkAhaSrzdeA2W6OQPb9pMgk8HvuiXm
 XwVvjm6qaVWzfcLctyFAsaXoMuwNW2e5iug2rX7jatv9o+4pfxz0LZxvgm6wTOG7w5TZy
 Y4MDn2GTIMWSMNVxmY+YHEz31Tc1wKKITGLsn9GRnyE89ghSYygC7J4Q7JqxYf+eFcEms
 N/04Fry+GIhfOmuhj8bzEx+CICqCXN4wOf5/dR5P3SvOPTQGtd8qljd1HiY4RaHp+2gTp
 BhgOCZQMANskYSVX8s/AM19r+GIrtV8+w0pH4Wrwlbq4u9ID7/H1bdD7C/C5GoKY6zA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250508;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=;
 b=U/8zgxvef8VPE3Zar+kdYg5gUwYCv4y6cALlNRI93vqrisO+nk258Scs/ib+GCAr2Ieu
 gylqkUeL/WI6Pf7baXzlS3eBQn7Q+OX6Sojb3YYUlTnYDgGZw2g3VEyxFNFBpbtn/7rmw
 HjTt0A1kODd4t8aIM8yxzSUq+Y0cnYTgSrk0gOB4L0PcLHuBlVNVqdATzdg/itMybqamq
 8MxlCg9EeHnRTt7P+hhT/gfsSMYFdRUe4XeCOZ0LFFF5aJscNq6LYJ7AoOCPN3/UQzn1v
 kgjjhte73paNXGwnsnOI8+Xnl3pLtYfsKM8+4tJcditgR01Jnn+StXNAmjWTnrZM5vQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=NuxcH1x3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=NuxcH1x3
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB5E280F75
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250499; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=es9tRNH8OeQdN0TIQFdwebeRVAEjpBQM4uOJ41i8pmwm3et1cUb5H5DMuZHkScXF3iqtJ2eXJMxt3VIYI9TORrao8kFuceJ3XO9fxkFM59iFTwV1A0vQfUvTbmVp7o+oK0lfNtbEVEWiwHdtAzUW2DB7kKJTMckBiEJ+E1hg0wQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250499;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=; 
 b=UlguwfpNvMbabrMzA3NR0ZwbGZqlm+EFQ00zSqfi9xrNu1JuZbELXOSx7MGCQ7wgm+JDW0v1ffK8nx+R9VisvCYG5Oheh0VBgg+kLjhL630rXP2Kzcesucy2knrrMm6UfHM4BTtrQ98kQDZ3VFM8kNgrc+Fqpj9wam16E+V5Vcs=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=NuxcH1x3+SldKZxWoerdp3S0GYLNKvyib5pD6Wn9LXIGLZ9/joGEsuXVscCorrgsGuoo5EYgOq4K0Fa10JCF1BaQV7/m7cCEayaHeuEo7+WpTfF0l8OvLwOT0Yvc4ifnMCC/D38J0tyUj08wB9p7nPm/d75iMKVcGdHL/sgf2HA=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250497779608.8881312852566;
 Wed, 28 Oct 2026 22:08:17 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 04/20] elf: Define LoongArch bits
Date: Thu, 29 Oct 2026 05:07:21 +0000
Message-ID: <20261029050738.1107663-5-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

They all come from glibc's elf.h

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v5

Changed since v4
- Add back the accidentally-removed EM_NUM

No changes since v3

Changed from v2
- Collect tags
- Drop a redundant blank line between /* Version */ comment and
  EM_LOONGARCH definition

Changed from v1
- Re-title to "elf: Define LoongArch bits" (with the semicolon)
- No function changes involved
---
 include/elf.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index b88e6cf4032b..23157f5d6b4c 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -225,7 +225,8 @@ typedef struct {
 #define EM_MN10300	89		/* Matsushita MN10200 */
 #define EM_MN10200	90		/* Matsushita MN10200 */
 #define EM_PJ		91		/* picoJava */
-#define EM_NUM		92		/* number of machine types */
+#define EM_LOONGARCH	258		/* LoongArch */
+#define EM_NUM		259
 
 /* Version */
 #define EV_NONE		0		/* Invalid */
@@ -705,6 +706,12 @@ unsigned long elf_hash(const unsigned char *name);
 #define R_RISCV_64		2
 #define R_RISCV_RELATIVE	3
 
+/* LoongArch Relocations */
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_RELATIVE			3
+
 #ifndef __ASSEMBLY__
 unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
 			   int argc, char *const argv[]);
-- 
2.56.0

