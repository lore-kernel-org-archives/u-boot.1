Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13B606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VWYuqfim;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqzZQoK5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71C3F40820;
	Tue, 20 Oct 2026 09:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3zDTlN8fLPbl; Tue, 20 Oct 2026 09:26:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98E63407E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488373;
	b=n/ztNK8R5S6VXF9yFALk66sO97kMB/cWdZa+8BqbNFcQPE8iI/1IM3Kgzt+ZjGsjnLN+
	 X4O++J0l+2rfLTizXfZeO+OxTDT5zLzxmFtVTawAVtuwnSDDwiOVTHMWfFREpiKFXpxWI
	 kZjds/5H9Bm4OZD+lgmlUO2p6lM0znxSx09ccZR/lwDpAOxAgiBgn0K0KJkGQoS0dmNi1
	 GlUz3A3S5FtHkSQu8ewxoxX0nZUzv+ybbPHh0RbkDl3FgKRn0HZRys//A2PqefEDHMTT3
	 XJDYQHXHUOUpJrbVWfC5Zz3cCft7qrnw7AvExaZ3qR0Cl5SSW51fzWaEJ67ieIqiILw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IRzqcG5g5Piy8A09ONZEJuZ6mji6FKgcc5hhd/7bpxM=;
	b=csx56s9kvgN82AO8jnyzf/xEh9tAvewy6u0vXyEfh0zJmUnrcpDjUgQOr6NkpThmtM1S
	 rzaHX4/hcZh6Dn1KkYQMLXKB2BeT+qn62gn4AT8nq01MF6uXe8K4CslVf9qbZjK01fqrJ
	 hK8ndwpBfeb8H9ElISJteHpyu6Q/G3LwvIPS/0B8dMDYwVIaxxUgAvmKHSPaFXr7ChyEz
	 zV2xDc2QoxSW5u9+0BVzmT6KpLs97iaPCSWdENWFJ7qhUPsAeB5K7PgKOgTRqQCVVTyWO
	 ODwnI5wrQr1hnWZmLqaFn/pvFHCiJOJYKqrNRafpIPK81cf+Xs4mc74zVRqX7xBOy/w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488373;
	bh=IRzqcG5g5Piy8A09ONZEJuZ6mji6FKgcc5hhd/7bpxM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VWYuqfimHhgAEHyY3eEEkoP91UdOCkLIN641FP+iNoxlx4nVR9hfton5mxfZda+Op
	 9kKoJs3w/OYUAWRvkSUxaQ9pQ6K7mjDqriC7b1VI57nFH6HOLAFQ/ZXam6AQNBawAU
	 WMACRExuw6uOf92up07vYDvO65MNhUeGe1ELB1gmv1DW2yXoZm3Y75x2GRLl+1kLFU
	 lH2ORn6S7l/jXFpiem1EVtY24xTc5YFD43X8c+x2hXkPkTq3XnhPVpqvSTejsRSpIu
	 vuHJaWKs/EOQ9FY97x4ImQHeuutEGpfE8YtYRQbokqaHYFqflCtlLqcH13tKwRuHLj
	 P5KNoBUr+OHlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98E63407E3;
	Tue, 20 Oct 2026 09:26:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F37391DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D99876083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OE3Vm2xbViMb for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1BB560830
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488371;
 b=Yc82QotovMUCB1Y9o3E+N81Uy+qB4Wcx3D1v02zk1SLmjEUIhFu74+7AFqPkQ0o0yITu
 HbO67l5TiA+kNoSJEpWUJ0Xr/pDjpeZkdCOZTcZ9j6b3rjqW5AtU2oIIFtMaFi5Zd9uSm
 88CAQWb9z9lAETGHQafInVWOuXyuDl+mtkFWkHDD+lgq7jXJ3yuB4DMguSJs9ww24Ho1f
 EbtDiVHtZAHncOqH470LR5wFxCpBImrlLKlJSvmxbp3H9/mE1rcWBsuNSdOm8VN0+u924
 S3fbm76+OqZHp4dAFpMci+gdXx/RUXDEBq61MOuZbZuZ1/ofIeTwB5lm9BEc70Pv3Iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488371;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=IRzqcG5g5Piy8A09ONZEJuZ6mji6FKgcc5hhd/7bpxM=;
 b=PHWMQmrcPlRDhhjXLcPXvUAR/onT+f5c5miW9HlilsxX/uOyStjSR/V5jPVSsfgr2qNX
 XzLL2TwN1QM2NVCdvP2h910yG1EeqfeX5TO2m+diGjgBRPEfokWltJq+fQVHFPhYwUH0m
 Qqznf+osFw9kVQbCSxIkAERFbW7pusc3RTKGJWlZAkluHJkFMcsI6RbpWnb5eT8Z5Z8bl
 7MtfrWUQ8xYaeDAx/SLVS3HjIBjqvZPNcyEMK40D/yB3On736oKruig6N3SrFQ+04UvEr
 A0jK39byGf9sLVBSaXAZV7npqiOo8j9RaOAYSHjCxmCzIh5ytfQ6riiBK3l3kDffQcw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DqzZQoK5; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DqzZQoK5
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1BB560830
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A6B7439C2;
 Tue, 20 Oct 2026 09:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA151F000C4;
 Tue, 20 Oct 2026 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488370;
 bh=IRzqcG5g5Piy8A09ONZEJuZ6mji6FKgcc5hhd/7bpxM=;
 h=From:Subject:Date:To:Cc;
 b=DqzZQoK5OIRMuH9/D+fHH747XCsHKZ2iST1PJb3whN0Ag/WKwYLtrvQf0LYvpV2hF
 R4ZWDyCzHfjLt4zCjDW+b9vJC6LLQ1xqv8MNsEJNeOApCZjYPhpjRRop33L/NIRLJG
 DCgN84tPB6D7Y0WY60tQt/MkUK7LxmqlSVoBr2PrTZGq64anD1bJPI+bJeUna6U6sp
 C423OVVHvxiva4S87cbkfBzLFaAOjaXvXedS0sue+3Ji7tDj0Rt7MYxkwBDmkhFQO9
 65bsju6+86SUNQTODTiDX1GcEM6dJiDBUc+luYcQONch2qE3pmN8GyB4MT9P7N+NJ+
 x2+G0LS/MtpDg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v2 00/10] Fix AVB pytest suite for sandbox
Date: Tue, 20 Oct 2026 11:25:49 +0200
Message-Id: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMwQ7CIBAFf6XZs2sAAcGT/2F6oHZtiaY0QIim4
 d/F3j3Oe5nZIFH0lODSbRCp+OTD0kAcOrjPbpkI/dgYBBOaM64wU8royoAP/6aE1kltBBmmziM
 0aY20H8259Y1nn3KIn71f+G/9myocGVpSgxFaypOy1yfFhV7HECfoa61fJHOCBq0AAAA=
X-Change-ID: 20261015-test-avb-fixes-9a4682e8057d
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=QFC3R/e93B6hdOwiBlvsozA3DVmpskQucQBS3m1uPFE=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOuyiVPc9RM0qnBr48U+LyYo/WvavCDwLVqQ
 RaSYfVyzQWJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrgAKCRAZDR20Zk4Z
 NaMjB/9VDiTr6l6I8+ma7dIW51b/zaAT2m4yfcdkWLmzryF1LGX4HSNbXaR5Ml+25pgqFu8wwBC
 3984SZMV79w8OJGjYxoW2n97bjRNW6OmPaCl1NDFCPs5qrT2IRJ3tIvt2D4RJtcPSXxgOw8ztgj
 zuL+3OrOvNNdAvH7T2c8YWBcKskt58AQkuwORYA7YtB7oXlzWsYCNpgMvzOT65IctIFnEf/20Nd
 RvOt+XC4B5kODg61ut0NYmtoAzhNtwsimSTAlpOXg6wFZA6tvHsKzO5RZhnLbq608Cf7CqeqwQC
 Pwk2QPmh5BQMaqKCB5Nw+CmQyfw6zt8mje0tsQUSzpe7i2Le
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AVB tests have the following limitations on sandbox:

* The mmc1.img required by sandbox is not created when the avb test runs
* mmc1.img contains a Fedora image, so avb verification cannot be done
* The tests silently pass due to bad usage of string.find()

This series improve the test suite to have more useful results on
sandbox.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
Changes in v2:
- Add missing find() return code check in test_avb_mmc_uuid (Guillaume)
- Skip avb tests when qemu-img or cgpt is not installed (Igor)
- Link to v1: https://lore.kernel.org/r/20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org

---
Mattijs Korpershoek (10):
      avb: Use map_to_sysmem() for flush_cache() address
      test/py: android: Move android image creation to a dedicated file
      test/py: android: Drop verbose printing and unused return
      test/py: android: Use for loop to create the images / update disks
      test/py: android: Add create_gpt_image() for image creation
      test/py: android: Add setup_android_v{4,2}_image subfunctions
      test/py: avb: Use format specifiers instead of str() for mmc_dev
      test/py: avb: Move mmc device number to a pytest fixture
      test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
      test/py: avb: Fix find() logic when matching response strings

 arch/sandbox/dts/test.dts                   |   8 ++
 common/avb_verify.c                         |   3 +-
 test/py/tests/test_android/android_image.py | 104 ++++++++++++++++++++++
 test/py/tests/test_android/test_abootimg.py |  77 +++++++++++++++++
 test/py/tests/test_android/test_avb.py      |  78 +++++++++++------
 test/py/tests/test_ut.py                    | 129 +---------------------------
 6 files changed, 246 insertions(+), 153 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261015-test-avb-fixes-9a4682e8057d

Best regards,
--  
Mattijs Korpershoek <mkorpershoek@kernel.org>

