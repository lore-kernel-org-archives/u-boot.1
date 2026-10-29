Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE7606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rq1q3UVC;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=YUxewHjt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74B3C40500;
	Thu, 29 Oct 2026 15:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVfMVvJV7M6b; Thu, 29 Oct 2026 15:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B4CD74043A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286591;
	b=IsPU0ScZEcBDWwgGuUo3LrJK1vUHdZKsuoBJin3JdxwdMU1gg/nMyyaE3rL+od5c/QDd
	 JAu2vz3qzzx8JtztE6Lc1g63h011OgyQyGmh/D19i5ZCwz2YCoIfUenDyIVCF2bI6eTTR
	 2BlZJuuDxmuxfgOyAfzEVUcrFYGSytLhRJskaTgvIEtGa1GsC7PzNgtw2xjMCY+03gMYC
	 B0hVFINSuSWD1tj9f2TlBwMycP64GTXan+bLIy1h91ugpSmi6JnQE5lfvZlQIgZKV1g1B
	 OkkHyRTHd+g9yN8G5/JhAYerl/qeAgZ6C10+bNtEtUVsU9wQ2GZaCOdEc2Quej+sP1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
	b=TB/6pOuHSotwWkLs96wBSv5mFM8Nk4zt73uulgH5GmdEXgvEPpoY0n5GMNuC6+0iNV4m
	 Rd7MdNZxYSdLKNuuhwTaF6y7xUwOUaNWa9vYKHnjuAfOvXCEVBCDRw9wRf7wTzZ550zBt
	 sXda2akS08fKUtQlhETBg+sOZEeUMnXzVxKJqUjabtu6Y6t/dU2CmhykRUfpIFpCj7nfx
	 TPsO+q1C7BTA3ck/DZNMbdor3ksViIXCo+nmLW3XVDrhFriB/FWVeUKMIWyNSMW/XofoF
	 EvptY/aRrU0+6BCCDej5zVrmhPxpKYxQ+7PgN/WzqpG1Tm1g8l+UsgMTT1ww3IF4NjQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286591;
	bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rq1q3UVCyx9O5EIpe80R4IpIaIC7c1vR6RiYb18WF4lAovF2yz+IIjQjrigNYNIqn
	 zwJKkrqpBigmdhYZhbfg1NiSohIVY5LzQJrZOO9a2wdu+cNv2coXpCX8jqW36SvwFO
	 obP9OefCSpwO006aOEBxV4wUHnX6Y/Cz0Fo3Vno5ga8y/kOkOBxb8bMrOyuhTcQt+c
	 txbPycZG2Gc4bBtWP1F76u+Y/ro0f9hH6JpbRWxy5CHjslwvNxGh/UlYqkbYxrfjQE
	 sBi4OjjoQd2drSkls+Rg2THQCpnHWu5ln0nXNovvqugYiwrEvwE3HwhR0yYUC0UFwK
	 ETwfMVeyAg5tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4CD74043A;
	Thu, 29 Oct 2026 15:09:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DC09362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7399B60697
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0MPGyfwHEe-V for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:09:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FFC7605C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793286589;
 b=q52TcJIK6TNV2orxyiMhPfwjGXE+h8V076Kg7TfYwhfsvulsCHs6Zgg6lOUWtknuRhc4
 RU+kFS54U3/Lbh/vjwqN0QBfxLXwJ+WpxVevhSLwTgoJuZlMLz03zNivwhQtSi+YvLr+E
 yRIzrT261cxQuhXBilHt1FmzQDOtqLDJbMVUjxmVUwzSpkq5lT8vk7DwdHbAA5vDILwtj
 Gf6rom9ELuROPMOy/ob5Lkq81OLjrQ5fufaLP8R2kVJX/Pq5ZhsEPlsow1mw4EghbERL0
 y5brJRqF4nOFJE4nFnMObp/0EsmuIr7pQhebJXWc5nuozJgfBAOHJp2rwZkQXuAOTTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286589;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
 b=OdHXLixPTzhYL1YuoS9ZdqkbEWHCEnw5EpFqdkdwa7micQJ0mFDhH1qYdbhS7pzi0ENP
 /xH/1YEvko0IYCQNlbi5qhNPCowtvo5iIMeI9lJB7ld6Dnd/1BZW4gbpveC8tY4XTSuSr
 49NSnjL7E5+HjfGb+u9ZoZeqRuMk2tB6AeAS4urDQUTN6U+jXXUUwgdZy/qOcoDnXUllO
 EdZnrwB4Yvh8hje1q7tfzSdWTgpoj/szb69JVTl7lkXI9TXCuVtta3ubUgR4Nh9PUN5sB
 Bxb7Mqx5s9XTR9cl7LYcc28WefWH3pcZh4x1qmbHQQy4xbyoTJTMlAbVtcjz6KjkFhg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=YUxewHjt; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=YUxewHjt
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FFC7605C9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793286576;
 bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YUxewHjtJnEdRanPTQ0MLhy1lSitHihRjZ/7683jPduSLfsg4tQ1dxy5UMz/7v3fY
 UOThk8AsrFFTXe4m4Q/KJsjCTcIeXUc28/GalIblX0IdB8gGyimXEPXNyZvQuooLXs
 bIbL8jOO+f7sjMI3APMJ3Gfuvtmpp4/CO0Djb6JG3GXvls+lCPdSJq3jSNDF/+0yus
 l0usKBJflg8pnWtNRsk5w94ZNQxurx5e9AeWVKC+Z3tqHB0hEgDetCrEEAUShGV+yS
 Oe5YCPlHTt8KqSEquUib1zqUTpvgWpu+wap7ELqArOMwnsnnF6RFrjW7uEWqJDQp0g
 a4Vd+5TotZRmQ==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id DE5DB5FAE0;
 Thu, 29 Oct 2026 16:09:36 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 2/5] tpm: allow TPMs with more banks than U-Boot knows
 algorithms for
Date: Thu, 29 Oct 2026 16:09:03 +0100
Message-ID: <20261029150906.1558380-3-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029150906.1558380-1-tkirchner@emlix.com>
References: <20261029150906.1558380-1-tkirchner@emlix.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tpm2_get_pcr_info() rejects a TPM that implements more PCR banks than
U-Boot has entries in hash_algo_list. A TPM with six banks, for
instance, fails with

  tpm2_get_pcr_info: too many pcrs: 6
  Error: -90

even if all banks with an algorithm unknown to U-Boot are inactive.

Each bank corresponds to one hash algorithm, but only the *active*
banks need to be supported for measured boot. This is already checked
elsewhere: tpm2_check_active_banks() and tpm2_scan_masks() detect active
unsupported banks and, with CONFIG_TPM_PCR_ALLOCATE, deactivate them.
These checks are never reached, however, because tpm2_get_pcr_info()
fails beforehand.

Only limit the number of banks to the size of the selection array
(TPM2_NUM_PCR_BANKS), which is what the parsing code requires.

Fixes: 97707f12fdab ("tpm: Support boot measurements")
Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 lib/tpm-v2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 137bbbd9593..43ca54621d8 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -702,10 +702,12 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
 
 	pcrs->count = get_unaligned_be32(response);
 	/*
-	 * check against the supported algorithms in hash_algo_list,
-	 * instead of TPM2_NUM_PCR_BANKS
+	 * The TPM may implement banks with algorithms unknown to U-Boot.
+	 * Only the active ones must be supported, which is checked by
+	 * tpm2_check_active_banks() and tpm2_scan_masks(), so accept up to
+	 * TPM2_NUM_PCR_BANKS here.
 	 */
-	if (pcrs->count > ARRAY_SIZE(hash_algo_list) || pcrs->count < 1) {
+	if (pcrs->count > ARRAY_SIZE(pcrs->selection) || pcrs->count < 1) {
 		printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
 		return -EMSGSIZE;
 	}
-- 
2.47.3

