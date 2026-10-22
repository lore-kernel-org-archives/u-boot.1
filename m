Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F964606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y03BZJfN;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=lXDIST4/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 530A6811A8;
	Thu, 22 Oct 2026 10:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xaJw9Qo4U0iw; Thu, 22 Oct 2026 10:39:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FD6D81199
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792665582;
	b=KGUuFWe17w93MDnFr5k5XaLCMZlJGZxWVdvUMQicR9ug+x2Cx8TnCP+d8EmSDFucq9lg
	 6C2SY54Qs8J5MYCPJAGoIRXTpWLEMPUhXY2tPd9qa2JF7d1f6ACdnfbnMc/bfijAZrozC
	 W8GGdgOCyAWE/faEnv8Ba/tBlybkOHaCOBwz4j7L4isbF6gig1QmGxe8ObKFGLdQmDCmI
	 Y5hjTVhAwruIHRGo4m+dPFEwrNlFIhA5Sqc5F+nGGlYGD+T1VmsFe1p0Ye6JriJLkN/sJ
	 xjxlPFiQ0Mi6MjbKzL5YeBdCx9w+n5HBxeb3t+erUG9u7T/hnZZz/8RudmckyuO+jBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792665582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5yAp9DLBfOIS82ra82jQzCNlPuunh8G0rOmyCA3QwH0=;
	b=UN6azvPhvamUN7oKFIMrAwG0MrQ4bclqx0w2uPjaiJs1VG8gTmDjfjyomh5sgxfPsr2V
	 naTLgO8UVEuTfp09B4P2ggBzMtAm3GGE5vxxpiEwg4k11mQxbMM88JDoZt0vCScX7MWg0
	 YmJmXJN+TsUlaaOrqvsejE/HZKvy26WT9phMdQWC6RMAEDVvdi9/743Nz/wkAKSAZ+tMo
	 OTAiSzKpCEoEzrEVALMD6seyjW2Rj71r0hBO15uotnJ7Pk4gmPfe5tO2wppgdZlzvHtgG
	 Qn9bvhk6uEtkJKTvaSuvlsNVuZRJtTlCM7CioSvUR5wmpSL0JMnh7/8f9/cBg+jc8gQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792665582;
	bh=5yAp9DLBfOIS82ra82jQzCNlPuunh8G0rOmyCA3QwH0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y03BZJfNQlNDXTpXWVE+MrYeRu1wEBZKDrboeNPNoEvnyQ2Tk6d7qPzb3oVaUJAeV
	 SS7reckI6CsWbLXV4182zH3cPEKJhBqg5UIgE1QwYhD60Ve5n08i36addVUoUWFjsZ
	 GEmb/bmxLpT4WjJkIST+eeBd93rjSGvx3DUxx6073qKXKCXia7R635CcJlvjgfSKKc
	 v5/62DwG+9h+iV3YLk/JCsdM+P/RQD/RA27lg/nL8AlmWJtW1NHi5HmLKsxhmMLCgN
	 6enCu9aLWTc2PPZBN9+H7PunmsZamBYv3KpJUPz83gNGRKXzqomw3xDFFtWjJziVxV
	 YKiOPe/za9i5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FD6D81199;
	Thu, 22 Oct 2026 10:39:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AD3A0356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EE016068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYsLaLO1MabT for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:39:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2517560606
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792665579;
 b=smFlA57VSljX5INNJfG56nlg+NtVu3OoLTYJnV+/qwPDu+i1Cd5CBau3Y8c4/Ve8VGk+
 LK8vHuvRvSOt/bmeI2P1tPCCpyIkaIbS5PnvC1zafuQuYoKd1dRvjE4vRTwukyKnn6GHu
 1pe1TyXJhcot5nw2k0wo1kz5dYGSDFIheVWkD+Q6Qd3P4aZXomlGrudDM/zTuhGpSlWEt
 wWZ0Te096vuULJCYtBNDXRSLrDcqDY0eFtaVezQBjLivrfmbtzAFfHloNKYe38iMloC61
 2K0W7+jp/v+WR3Xqngru7N++iiX32v200wJygRNC6XGHPsQNdahvTmo0gLN+Ghz8gYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792665579;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=5yAp9DLBfOIS82ra82jQzCNlPuunh8G0rOmyCA3QwH0=;
 b=i5ttPskGOHo0RduktXrJRDTetY/BwLV/BY3Pd87ZXbAmwqAHf50OypoAOGVDffNSgHOa
 GEXUdnZd2jKzVWu6DwJgzOmH9ICpry1yVuNSbxg1XWC9csdmAVX3RpwOmfADke7xbNhuy
 ymP9ZpDaRr2f3nmkADQNPAKWEBhn9Ii1Vmhjl2CVt2dWfIyRLs5ytdpUbaAztYM+/YQam
 q/HHQ6bShEHEcaOu2ui1Dyevgc/oMY4FH8OQIueEl69rmEmh++HQ/k6ayOsl9b1Zy3+td
 wAFE43EPb9xy/FpAD0ZUMPtgSuV86a+M14uB92Rq1GkgCiZiaMT+vmxRoVtG8RpPIjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="lXDIST4/"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lXDIST4/
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2517560606
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792665568;
 bh=5yAp9DLBfOIS82ra82jQzCNlPuunh8G0rOmyCA3QwH0=;
 h=From:To:Cc:Subject:Date:From;
 b=lXDIST4/lzFsUf6uhBB4Q0Dn+ZVcFHal//E9zRGobZC2CvZjSWzJsMWft2si0c7SR
 lcUzt0xmIu/T1bE1GRDRFqMtIXJCKEWM5dQcXWrk7s2I/AGdn0WHyavRq8ZmQ408H1
 BOsLOD2BQr3FMG7nwXEWvnVuFGFBtmQA2V1WvXZ0cTIEAQreJHoJG4RBq3vbLhKHxG
 fVLuNQVtZcR//d3MKrci8veTo/I4GArefF3uRxjNB5Zo85UwTfK9cex4AgeGKsS8f3
 X6CjGgglsGLu/Ecz/R86iz6D0keX7iXnVSSyNPuFpN8uL6J4Jsm/65FE0k2elogmuW
 9lF7pdGHQ41jA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2D4E4B220241;
 Thu, 22 Oct 2026 12:39:27 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v3 0/2] Enable SPI NOR flash for SpacemiT K3 in main app
Date: Thu, 22 Oct 2026 03:38:51 -0700
Message-ID: <20261022103907.1415045-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable SPI Flash command, mtd part names and locations, and store U-Boot
environment in SPI NOR flash. Selected for Winbond and GigaDevice parts.

Changes since v2:
- use Linux v7.3 fsl_qspi_get_name() typical result for mtdparts layout
  name; this is done for compatibility in the non-default configuration
  of matching cmdline mtdparts mtd-id when Linux MTD_OF_PARTS is disabled

E Shattow (2):
  configs: spacemit: k3: enable spi nor flash in main app
  configs: spacemit: k3: enable mtdparts in main app

 configs/spacemit_k3_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)


base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
-- 
2.53.0

