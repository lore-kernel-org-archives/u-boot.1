Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F798606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KLFTi3qH;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=CsPdi3nR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD9AD407C7;
	Thu, 29 Oct 2026 15:09:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 43VNrvYKRPvj; Thu, 29 Oct 2026 15:09:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2731540729
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286575;
	b=MVgVjygTUA2rX8m4Cly/C934CBX+6tiai/v7B5tudyx2VFBl0/1Q5sRtDSqaQBOQC2rA
	 NrkqUhgUQErhsn09yfTglEZakRStU+urhFijZ1DDG6n6SXkR2zj+8cW4OKaYGu01Y0QCN
	 R31mf/lTF3K7PtawNZUtDLdz89Tahyz7BligEWS6Wa1a0IsKQkLUGDqUrNz69dPJw27Wy
	 NEwC7jmBdCTUgqzmYW/oqZ0NPc3TmsVeHefUXtyZ3GLP32M5LVP0UE6SbL/qzagn3sEee
	 iQC7m7u7yB8R0x1fFx36O7zx4SHh9VgUMzg61ShIFk0I8hSYHiyqxb2fq1RVNXcgt2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0aOycgyqK1rfcH50f7iGjyDoRjVaVKKX1zWa/SAaRlM=;
	b=DUDuxACY9P3IpBKXFdt81eAq7NoOlNu6CKZjMu/Ce87ta0kVRIJ+y4hJnFGqaJUiL7l3
	 T5orfmWI9C46S/csG0kEWnV42Gbxgej6t9G45ivPLhv58goIcGfFcibtcuRhs2bwoe7o9
	 N9Hn1zCUpwN50WR6wUB+HCButs6zfz/6/0SHcnh9+7D23hqFHrq2h2mLPJsCNdADxL3Ih
	 M/8p2sHbb9ySXFk2jjNi3A1gJj9jl0TXhuie9y3wDq1IOHA8NU4ID/8ljuOltlDbPPoNG
	 C13//uPKA0DdurAirbY9OevMFgtS0ellIVISrvQ889GK4RWRmC9kK5B2y4ggkD8gHBA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286575;
	bh=0aOycgyqK1rfcH50f7iGjyDoRjVaVKKX1zWa/SAaRlM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KLFTi3qHJXj+eBeDVizlcdV0LcDOQeC/GDaxWImkCMuBNPH4cNRtzzE7LJ1nvNNz2
	 iiYuOkKNLhnOhE0sQEAVJVYysKgKOKzZZLVPP1ii6odzO2QnyD/eC2wZcDVOGb9RfF
	 Qfo5j4FEOuuq9EpQ9mgIWUf3Ikq04FhhsKh/COaW6Cob4a7nePhHazwsfPksCDllD1
	 ZkzHwzfRjLy6Sq7pNq8rhdHsK+wmU0Q9c7GKWtuWVjB4CedDYk/EGFAMnsjJxrT4Mm
	 f161AlVN8S2y2rsp/DQf8ry2HPb2GF1DKzaBP+fTiA1s6AI9sRUqVRhW8fvysvGVVc
	 4pGQ2TQCZpecQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2731540729;
	Thu, 29 Oct 2026 15:09:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E0E82FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03F4880E34
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I9F5IvCkwJwu for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:09:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B93580D7C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793286572;
 b=mVqPyj3XaLad+EyI2LTkxDkN0VSWOKM+KskTAnj0/wnyn2gpWaD2fO8E1qBP0CkMQAVw
 UinuvnERmZkuZOtlloZY9WgS0xhOz1nSeBJlWnF0uX9+7gzfXg/stHyC7J6eyBg8fFBZG
 sPT75C+eWkcSJd685KP3Tcp0ac05DqhhfRvE9i2eiaKbGadlkMgDCqBC6ahj2jru3X7jf
 dOW/LbbP8EJf2kmTitjcQbxKFRGgIVxM1EdyhL7Dd+zx1PnOZNuX/r6yQtZsizzyqQzuj
 y0smk0EqgHXz5AeatvmpvXcHfXzzRDYHQbEMfh2bgBjg8BZ1vhEz8oaa4DrlpVHzaOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286572;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=0aOycgyqK1rfcH50f7iGjyDoRjVaVKKX1zWa/SAaRlM=;
 b=W0uowOwazI9ZCh35gJ5Sdj5p4F+22gCeFrLjq/8lIRnkrtYlp80Cu/Tc9e0JMMosTUR8
 OhOg9L9R7yLO8RMbWvdi4Ex2xDOJ+PLo5E0/VFlc+1wfGVkkpOBrWQHmiW3SOQ1Ieiv7N
 j+va3GauyBz0DdTM4X7PQC6gNG3teeI7fYT0C4HsRIdESWu5C98/wmJiIekp1Te0tOx0q
 MnaAKhCv5tOlVbhoRiMuu7NLEReOW8//Lbp962XoM9jS1HCReiAcO8DGjohNinUiioCQ6
 893mtj4N7OJFCMY/b4G7UoGo2eTVCLgfFjpmStImhenME6Qvfu4t60/wldMvGrzLo6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=CsPdi3nR; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=CsPdi3nR
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B93580D7C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793286566;
 bh=0aOycgyqK1rfcH50f7iGjyDoRjVaVKKX1zWa/SAaRlM=;
 h=From:To:Cc:Subject:Date:From;
 b=CsPdi3nR73G8AovGWoHsJ1wfBniueWgOgcR4BNoyYthpWyRACD24FOd+GpGEZeMr/
 if47PpUoHvNBU63g8KJpb4sqZsMW4NVsB65Fyy35kBZpmZGaWLrfg/wygoppXelRqk
 88trU3QjjgjjzrfIq3VHqpBa+pvNKIkgxDovSvSgpY7CkgpVEa/vgH/uvk3sJcwksj
 pbNj+06a5F6m46qylhpC65K1os2vn8kCE4C2JeGKIyDtJOM5rW4QmfvGrxV/S8Qp5+
 L5T7psEfKCsfSD4sLCkWEKFG0mCrlzxut5DST771iQc7BOaOFk5NRvaQDBPxLE3OuN
 z1JZaGJGrbBTQ==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id DEF1D5F8FF;
 Thu, 29 Oct 2026 16:09:26 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 0/5] tpm: fix handling of PCR banks unsupported by U-Boot
Date: Thu, 29 Oct 2026 16:09:01 +0100
Message-ID: <20261029150906.1558380-1-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at mx1.emlix.com
X-Virus-Status: Clean
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

A TPM implementing more PCR banks than U-Boot knows algorithms for is
currently rejected by tpm2_get_pcr_info(), even if the unknown banks
are inactive. Ours implements six banks, including SHA3-384:

  tpm2_get_pcr_info: too many pcrs: 6

Once this limit is lifted (patch 2), the existing code for deactivating
unsupported banks with CONFIG_TPM_PCR_ALLOCATE turns out not to work:

- the result of TPM2_PCR_Allocate (allocationSuccess) is ignored, so a
  refused allocation goes unnoticed (patch 1)
- active banks with algorithms not listed in hash_algo_list at all are
  never detected (patch 3)
- the fallback in tpm2_pcr_extend() deactivates *all* banks and does not
  reset the board (patch 4)

Patch 5 deactivates the unsupported banks in tpm2_auto_start() already,
so that this happens before anything gets measured, also for users which
do not go through tcg2_measurement_init().

Note that with CONFIG_TPM_PCR_ALLOCATE enabled, patch 5 makes
tpm2_auto_start() fail if the unsupported banks cannot be deactivated.
The rationale is that enabling the option asks U-Boot to manage the
banks, so failing early seems preferable to failing at the first PCR
extend.
Tested on a downstream U-Boot based on v2025.04 with a TPM implementing
six PCR banks, with the unsupported banks both inactive and active.
Build- and unit-tested (ut dm tpm, ut lib) on sandbox against main.

Tycho Kirchner (5):
  tpm: check allocationSuccess of TPM2_PCR_Allocate
  tpm: allow TPMs with more banks than U-Boot knows algorithms for
  tpm: detect active banks with algorithms unknown to U-Boot
  tpm: deactivate only unsupported banks before PCR extend
  tpm: deactivate unsupported banks in tpm2_auto_start()

 lib/tpm-v2.c | 75 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 11 deletions(-)

-- 
2.47.3

