Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DF606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rHtopNnM;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=QYeO1suy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD926607FA;
	Wed,  4 Nov 2026 09:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ve-E0Beq52sy; Wed,  4 Nov 2026 09:42:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4BF560816
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785377;
	b=l8P1uX10yiaMNpf3LNFhDPa9omHUpN4BWKKMJoyoOki4CsfXSpPHMxOvjmRBIvgVTCIu
	 DhHIPD7zesB7edoEHQYA461PKJ4eRDzwI5/YuK6QhB9G8XuCdC2CRINWvmlGu+wznAFlz
	 QiH3yP9Aoqfm/YTwBN6DlwbRgOOYHSdHRM8lccewdP/7dxkoa24p6jXaQio57N3sMEXKE
	 uMzK1FSvLYhTzKAqiTFOZ94RnQaMvFrvZUNWcgIT/xhDGzXCNvZoOW8+ahjnOZsHDtAwi
	 4g0ihvyOB8oFNf5N1Y3R0svcCIZ/NZoyhhfDgBzegJgDyWLczNIaY/fDHFb1XZ1QHrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d+qto2SqK3yx74sWfGtqf1stYXYIvHvjYSeqkP3bJ3c=;
	b=rUt1X8pwsPA4D7U3WwqBX8V987+H6UIWNJG5/kvxg+vPgJk4fBtMmfmYBZo7Y4eMcQvH
	 +ucCijVOSJqiNJr0VLV5dSLKmZdzKKKtaEMWMSi5nN3wfthIBELMGVivUPidx+ZhN7c3w
	 SPGkVpzQMCz0YvfceiUsWg1YYsxWRKIULf0MYDqLNk15NOHOsxyiFiba0+yOV8HAKOnCj
	 0Tq4YBvwSIC5OF4N02SCvDH966LGvBlQdO7ku1qHXdnQTvQMsLn7fW84SJ9jS2i46HLzE
	 MTj6XGNffC1d7wN8Vun9oOi7ZxjUXME9cj3EQoFHjtLOYVTD8C4tCyyR6uYVmmjdwqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=QYeO1suy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785377;
	bh=d+qto2SqK3yx74sWfGtqf1stYXYIvHvjYSeqkP3bJ3c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rHtopNnMlaXNMabwT56FT8A4EmwWcLYzcdVbhHxPky9JjflpjWdprWOD5mSmCthu3
	 uwWClDdp0wTsI9y4tEAqgqyYeikoLn9eeIJsQy/dQPArtZtONmDUTlIKhTi/1CMbRK
	 Q66q9qFVDkctvVr7S9hdawAaEu/iw1loNjZe66OG7hgofgYEvmFGrIdv8+BZpjqaQm
	 nt1jnO9HbY1Izd8CPAxh9bXKLkAeAQzf0SYj7Grx23JIY419ZNt7BdVpyx3jQRYhdY
	 dWTsnKvY6x7YB5xPejWtYd5XPomFQ7jYYaTimwKsLrLA8CSlROHFJO7rBAxogGLypd
	 HIXB+G9wGIIQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4BF560816;
	Wed,  4 Nov 2026 09:42:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6631F37B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BD9C607FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VPQFpUqQx1p5 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:42:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8158B60697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785374;
 b=InQpHXDzEqYvaBGb5PXViY1MkaQinDZDgpGv82NG3oMSBXOVWp/Wst4w3yWAnisDWUfQ
 QpYKiUMGpd851/ZYcndf+1FAWZRuwOcAER9wDa0mzyzFre9o5EccLWqktDLWyVDv2oyf6
 2Bzo8buuusosDwrl+bRCUaAbSP1ipyq/jq5PHrE2xUiBaXbxlZ9OM18ks0hiZn6QY3HjK
 nzr09cxwCF3tLJ8QuMWQ2wLbF5wQh6CG1HObFxThurr0S8szaz8B3oCLm03CPRt3fil5h
 i2kKAbWYUeYfVsdWXH02QJOjmfSTAaGQITYOnv3njPm9VnWsxdCO0GWCK6PHNvfwEdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785374;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=d+qto2SqK3yx74sWfGtqf1stYXYIvHvjYSeqkP3bJ3c=;
 b=TtO8rK2yWms//Mha3kglLJB2n1oI0fvwUD1rOHCVwoKXUEBJUAjX84vF8QWBWgjfFbdK
 KsNJzf+Q9C/kB4MTObJmxdIEbMKhe1SocpmF/k7Ah3uiOdYVVMqB8UaIAAoMfFFqXiih4
 CbaiCuoT9aK8GUyelt1Rnyd0fDP1GIEdgToRStpOx4cqwnz0k93N5l7+Ioco2iJWAhgM2
 meio2QOAYd7FT0AQU8aKApT3Htie9JbP7Xjeu1LJbTPa+TeIRwm5BYszwWxjxXByeVck+
 w4AuL/K/8QmTof4iOeGvnhZ5aJyeb5uT9eXk1xLLsAj6PhdEzZGM7ocf44Qrtm6XQsA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=QYeO1suy; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=QYeO1suy
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8158B60697
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793785370;
 bh=d+qto2SqK3yx74sWfGtqf1stYXYIvHvjYSeqkP3bJ3c=;
 h=From:To:Cc:Subject:Date:From;
 b=QYeO1suyXlKx3mQwoFRq3Dx3f+WDHwSwTdsilfa1f9vQgqRSvsm8fZXs3K2M34Ccw
 p7kppDOLZAgsbvQgXIolI9RRh++CZ2ymPkpLmMoBG4fX+BSBmPGxUnae0obZMHtk/e
 XJAuvrBs73a9ZjolN7GF58PWYz4jFXab/+uUt9A+YzTsdCrMkEx2lpf8WvR0zIWTUX
 47JwvF9El/PjB7FuLtpbaCpEtt49YfhG1/ojdSUFwk68Vi+Eo2kcY9/2kVBrpEDYcp
 BYj9fQbjkidj9rpWIy1e4iq1Pw/YTcizn9pb6xW9WrfW3Jjk/UZwJim8qeDgBpDXCz
 kqbkWext9EOPg==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 25FC75F7D7;
 Wed, 04 Nov 2026 10:42:50 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v2 0/5] tpm: fix handling of PCR banks unsupported by U-Boot
Date: Wed,  4 Nov 2026 10:42:33 +0100
Message-ID: <20261104094238.519111-1-tkirchner@emlix.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

v1: https://lore.kernel.org/u-boot/20261029150906.1558380-1-tkirchner@emlix.com/

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

