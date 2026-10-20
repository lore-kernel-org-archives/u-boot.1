Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0D606A328
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XR/S3Cvb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhfy0xtT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1407B81155;
	Tue, 20 Oct 2026 09:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YHqb6K5DmvHq; Tue, 20 Oct 2026 09:26:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F5AE810A2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488393;
	b=RVL07fmjHpcFLenMLm0wN4vzyEBBLulxkMKvjeuM230XEMFS3fLWGyxWUrwyyDQbhl+D
	 W1urttHgnNbAJmoYlRhSqhIB3BpuVExd5jPxcC18X4bLlNEWKESkbhCFEVkKYyiX/MIdQ
	 FrDpR/4RqV5S2ELJgBGn6MYNYM7oB5Ebmu0T3ESMgK189LkpTRlDK+ebDiCD6dozIQgFN
	 Wfye8nnCInhAjGUfVU1c+QvhaGBKTqj/2i0kzfqwKG3bZcOk9qbaSO3IVbyFATeTtUkgy
	 B6N4VrXiEceKucbiKmc/ieEB8DZ55yRYwkGj0cJ57D589EcjTnSTV5VgMq610oORsQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eBTOScpCyDxAT5USzXBTXAxKoVEW3b7zwkI6qRPIJzc=;
	b=mN0O4GQDBgAtSEKhc8bteD/hW7p2+R3T9+An6OyGRliwEdWQFRT/J87k72PEUlu12bbq
	 W/Q4QVaeNGfALIakhaLmUR97iSxEvM4Jg6p9dHzpgTu0BXJABmiqKWChpcdTON9aQBgNb
	 N+wUAc7cGf/WCfWiogFTgMqJV1XA/qkGvCfudAYU3bHQWaqaCKdk53zP2u6DHDfyh8SCw
	 OvzmR2bPAfofYTRxRc6ITm8ecqn6yKS3sYbDdOs07TXz1a6RPGr+0f9GvEbRKmchc7/8H
	 x3DD+uNOum3oc+vN7KaSZK2nRRhk5PpGpV0k+NKjWKU/U1tgurSLlgyjo0aC/GlQ7Yg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhfy0xtT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488393;
	bh=eBTOScpCyDxAT5USzXBTXAxKoVEW3b7zwkI6qRPIJzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XR/S3Cvb9555onVwp9jnIoI1JSE8ErGUNJNNXQsgX/CtUUF0yGlUEQTSd4meaD2/8
	 ygMjjNoVbzizTgIsw+/yP7ToDMEZ0tWuFcMP72hPYQMTkVLI0exMqvXEzp1yVjqCZI
	 g/AD7JsRkWISUAdLfVzxPezxPu7qcTDPlJ8ODDcv0/Qit/ir6w4oP7f4+CAQufLCRY
	 tPYFMgHJgDLuckV+7+mrhj1juLgUa2udQzAci/UNxyXXpq78Nioq1OODATH2/sqbBl
	 iChtXQQdSz/jxnCZri23AxRYMe88Ettdz/kKmm9GL0qLenc7fG0Lu9q4QVmbYcby0a
	 OGb8fVzXAcR0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F5AE810A2;
	Tue, 20 Oct 2026 09:26:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFAA8765
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CBE148114B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWN9ytXwvDDG for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD1EB810AA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488387;
 b=q2m7Gr786PFjtx0RYv3nz9I8ixXMcvJzHBqQEobbzrPUdF9a/0k1GU6UffNsnYcjbmuR
 5zZ9Pk30WyA08zvmWuWwJLSMabLMn0w7hVnO6GpIfw4Qk9AO13mMMlW6lhpz093PhzvF9
 0ppS52SKGaWGaiTq0prmJ0ZXwqK4Q3hyX2v9K0rRk9h8EpTNcy3TiT1YLCGDEG93/muNe
 CLglACSrn9xniGauZMGIW5fhjUPHMSQUXe9nAi+sCnMylMkjZ5fTu9c1O3AVpxI7dpx5H
 FOBihrazCc81nXsJPQE/GF/CtLlS/mxvxOHTASY00Sb0y9h4l6BCfWpoHaqzpi7+TIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488387;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=eBTOScpCyDxAT5USzXBTXAxKoVEW3b7zwkI6qRPIJzc=;
 b=arP+JO5mR/3c2SBFSYMNoQIfqWkOnqjjgLdPhTT5h6PfA3wFmReRSbAOjBVoRCvkanGY
 TEW4Sh9U7MnxucnbbGPk/ui0GtTW/JTi4hbTFuQ5auB0mCUWtDO8Qg5tXDg/gzHzHQRTM
 reGPWEOnnXy6EwNDWNHdd5kggB7ICVRQyZE7DuSxxJbKbseUiUpPmTVcWqbmiSCZqgwfs
 nFOeqb5aPwLB1ls44klWxTuhK5jMNefFh5LlQe4LpWcuM945fH/Wv+cUYV1CzU3w9SvVi
 87e7hwSkdlDQqiVMbjNEKBSzZpD2sAmALo36sVw4aLOiyzWmgnwr8/1/3vvpyVUt4ug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nhfy0xtT; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nhfy0xtT
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD1EB810AA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8371543D56;
 Tue, 20 Oct 2026 09:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96E41F000C5;
 Tue, 20 Oct 2026 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488386;
 bh=eBTOScpCyDxAT5USzXBTXAxKoVEW3b7zwkI6qRPIJzc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nhfy0xtThdSPBiG6raJL9F+ukSwDW+PhL2eReyYpyj/gJWBoeWpnteeFIXa5shy/w
 i0QirHV59pNZxbqLmBS9nFskPttlHmEN6iDZZnbt2QF2cYnwA29D/1gF7Z4fa8QTBf
 ZpPMULjj5AviQTGAFURFjie4lEYz9x51gUO4B92kOIGz5Fmu+wS0E3URdLlNwJ3cyV
 vNiu+/IuCbdBnH+N+MNqU2DMs1eJupVEx1kZsacQCSxUMAu2EuJ1rTV8qQZjiHKEeI
 Dp19nug6NM5MFAVCO/W6WBir6q8PxxhOrES0a8kQE+1CdBi6WWC8/eEq8xr/mLHs7O
 iDHpVz/bjSydQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:56 +0200
Subject: [PATCH v2 07/10] test/py: avb: Use format specifiers instead of
 str() for mmc_dev
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-7-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3675;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=dlcn4S/PP3jZefuBToE/ka2Sl/4pzt5CwiU3QrM4oZE=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOvA5boJMUdctlboiF4QpAleYHjx9T5QzSRd
 jb2em10xZOJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrwAKCRAZDR20Zk4Z
 Ndp0B/9DUgZS4lgVru6HLBa76njWhM3dLjgjSeMMo9Y16wMC60jw6XJGhC+Q/i0L/gWVe2du3qW
 dmu/Uw62cZI6BsirC3qScDKKLt0yh7PQgd9d23hDc6DjGmgnugmwtbB+yreMxadvLVZ8aCg213x
 oJFD/JDV4+uLNPbdKreB1DiyUPsPaHl/tn6uBZU6DBLPnjHO9jQARofefL08nQfozdv0Yc2HhWV
 s+7FQj8kfssMG5e5MzsEBs42fPK4A7HQy9tSiWx/4ZDkJiVb3Y7wbbhVsAp6UNFX+Gwu8sGpK46
 5Zm1ZxHyDDJVQ0YfkAY0BNy/HovNf6dW7SuNc7BgzA7uXjnt
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

The tests format mmc_dev using str() conversion, which produces a
decimal string. This works when mmc_dev is 1, since "1" is valid in
both decimal and hex, but breaks for other device numbers like 12
(0xc): str(12) produces "12", which avb init would interpret as 0x12.

Use %x for commands that parse hex (avb init) and %d for commands that
parse decimal (mmc dev) to format device numbers correctly regardless
of their value.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/test_avb.py | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 137d83e1deab..c66ef0cc52d5 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -29,7 +29,7 @@ def test_avb_verify(ubman):
 
     success_str = "Verification passed successfully"
 
-    response = ubman.run_command('avb init %s' %str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
     response = ubman.run_command('avb verify')
     assert response.find(success_str)
@@ -43,11 +43,10 @@ def test_avb_mmc_uuid(ubman):
     'part list mmc 1' output
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
-    response = ubman.run_command('mmc rescan; mmc dev %s' %
-                                          str(mmc_dev))
+    response = ubman.run_command('mmc rescan; mmc dev %d' % mmc_dev)
     assert response.find('is current device')
 
     part_lines = ubman.run_command('mmc part').splitlines()
@@ -75,7 +74,7 @@ def test_avb_read_rb(ubman):
     """Test reading rollback indexes
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb read_rb 1')
@@ -87,7 +86,7 @@ def test_avb_is_unlocked(ubman):
     """Test if device is in the unlocked state
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb is_unlocked')
@@ -101,14 +100,13 @@ def test_avb_mmc_read(ubman):
     """Test mmc read operation
     """
 
-    response = ubman.run_command('mmc rescan; mmc dev %s 0' %
-                                          str(mmc_dev))
+    response = ubman.run_command('mmc rescan; mmc dev %d 0' % mmc_dev)
     assert response.find('is current device')
 
     response = ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
     assert response.find('read: OK')
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb read_part xloader 0 100 0x%x' %
@@ -127,7 +125,7 @@ def test_avb_persistent_values(ubman):
     """Test reading/writing persistent storage to avb
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb write_pvalue test value_value')

-- 
2.56.0

