Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14853606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XSTjU+hB;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=VwnKEGb0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB2D581036;
	Fri,  6 Nov 2026 07:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aIpOXj6-Qtcu; Fri,  6 Nov 2026 07:27:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDC0480FB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793950064;
	b=HYppH8Ui8p0cOCq/sVlp/NCtmWR/+qmcpcGLfbOkfKK3FaRl0yKuCTRiU+oGbQY+QK2p
	 vL5wv9o4fQDt4aW1LnR6fyC9yOqNyxuF3LKouR+uRj6JUJ9atW26eOuWRQXrH3LWza241
	 97atgfGe8kTCjKRJW+gE5hWWvtUu5iHvNDFVxfSO7dNCb8CWno9JMKtLYF9SRAL+j8R3n
	 xfaFR/NoW+wJUtREF3aoi5mgyGizV0+RW1xDrD2My16tWsu4tOxka1UHkhSvNEc7oQ65Z
	 bH56/FM6xjn1RAw1KQcY5Lnn0+kA87nVHHXs7WI1tcKYWNoVcQWPGKYogNzuZzqazvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793950064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qWpgvK8Qz4OVCf8OWMMRkJ9reBS7YgD5wwTbw+V5l7M=;
	b=Gi82ZGpbzERQAWW7+F8VOoVUq9uu7giZ87PL4gvVQyvwF93wRltW4iPKqePSMZPQL6Ng
	 fhnWG1HNCeuBYXe9MdCgKrJ4nhPquAOAmZNnTvw7o2BHQ2l8SLS8lftSjMrOdYQn5ikjC
	 H4PBoJuc/Z06lVp96yl/jUus53J/+FtyNKovsLIfJBJbcNsG1P7KFnyi6tqoZMYfn8j1+
	 izStksY98u4REzau6/36+rRi6Rrf30PlZK9zq7frj+BY6hibJWyQv+8hb9iaEULPMk1hw
	 /Swf+1NWJBTHeaSZDBA3UthTOMqyiz6Lmx+m2tIVZnfKOmYKvgRaDyNDexGnNsdeB0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793950063;
	bh=qWpgvK8Qz4OVCf8OWMMRkJ9reBS7YgD5wwTbw+V5l7M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XSTjU+hBSZg7AGmuPJk/SMLbqkEb6WxmXm0dmW77hmftxTV1vvMuHmiE+ogsR41dz
	 KSFLbItn1dwECmk4Tb4dWv2Ks/in4PxXejiTLFNwypKN0dMMAkdAexy7r316l78iZ0
	 bl8LfvxZeela+mYVLjXGYb63p6cNz+KMzZgbaTWcT6KJPLPbAjHJIDIvaW9bJldajQ
	 ZminP7NVt4RwvOSMAIO8/YsBO6uNl9USrEu6VzEm7rJhxg0p8IJJ6QndYCmMrgfIzP
	 cpd3G+Xbq4XXPyR+aWFv+C6PDjQiEGV/Fq5sXLpJZ85sUw0JHhSP20uJniAjOfU8K6
	 VDerwg2TBt1QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDC0480FB2;
	Fri,  6 Nov 2026 07:27:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 868DD1E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 780AA401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crr9LPEgyLw3 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:27:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9CC1340070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=VwnKEGb0
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CC1340070
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793950057;
 bh=qWpgvK8Qz4OVCf8OWMMRkJ9reBS7YgD5wwTbw+V5l7M=;
 h=From:To:Cc:Subject:Date:From;
 b=VwnKEGb0+X1DSyITCknpnRTGMnKIsylS02nNRgqvxfmYmaF0Gu71vH+p+IGGvZHcM
 JhTaAeI99mQIKyuBybEsTCpq1ePX43XsRIRc+BP8niJbKtJ5zjmElMv0sPjgs4U5fH
 MEfWjHl2r/YluCwps/GJgmWW3+s7xaolCzN0ofS2iNvppvfC8J69PEuQGAFPdrnIqu
 gquGORWQ2HX+KfgCyXage7xua0HfFMfxFya9DaY5W6rst3EqWvqfoX9DWUXXn1c7hL
 v8+TmYY48wgx3q0IeztKOlXvrbWYnc0eq7ftW+qDohBudXZ5d2HJPxWh9tGdp5lLPr
 NUTm3y8T292mw==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 1B0585F87C;
 Fri, 06 Nov 2026 08:27:37 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v3 0/5] tpm: fix handling of PCR banks unsupported by U-Boot
Date: Fri,  6 Nov 2026 08:27:24 +0100
Message-ID: <20261106072729.1714418-1-tkirchner@emlix.com>
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

Patch 5 deactivates the unsupported banks in tpm2_startup() already, if
the TPM is actually started there, so that this happens before anything
gets measured, also for users which do not go through
tcg2_measurement_init() or the EFI TCG2 protocol. Note that with
CONFIG_TPM_PCR_ALLOCATE enabled, this lets tpm2_startup() fail if the
unsupported banks cannot be deactivated. The rationale is that enabling
the option asks U-Boot to manage the banks, so failing early seems
preferable to failing at the first PCR extend.

Tested on a downstream U-Boot based on v2025.04 with a TPM implementing
six PCR banks, with the unsupported banks both inactive and active.
Build- and unit-tested (ut dm tpm, ut lib) on sandbox against main.

Changes in v2:
- 5/5: deactivate the unsupported banks in tpm2_startup() instead of
  tpm2_auto_start(), and only if TPM2_Startup(TPM2_SU_CLEAR) succeeded,
  i.e. not if an earlier boot stage already started the TPM, and not
  for TPM2_SU_STATE (Ilias)
- rebased onto current main

Changes in v3:
- Add Reviewed-by tags from Ilias to patches 1-4

v1: https://lore.kernel.org/u-boot/20261029150906.1558380-1-tkirchner@emlix.com/
v2: https://lore.kernel.org/u-boot/20261104094238.519111-1-tkirchner@emlix.com/

Tycho Kirchner (5):
  tpm: check allocationSuccess of TPM2_PCR_Allocate
  tpm: allow TPMs with more banks than U-Boot knows algorithms for
  tpm: detect active banks with algorithms unknown to U-Boot
  tpm: deactivate only unsupported banks before PCR extend
  tpm: deactivate unsupported banks in tpm2_startup()

 lib/tpm-v2.c | 76 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 11 deletions(-)

-- 
2.47.3

