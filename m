Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCC606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aqWUoq90;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVrRdsHg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C53E81192;
	Tue, 20 Oct 2026 09:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3OWIsMJKHtq1; Tue, 20 Oct 2026 09:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05FDE81187
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488395;
	b=fK9AbKKuqWyOe4SxsRtpDyk0EjPw2x0nASulpMQyaep15WOcoJjO1ALR6lI/+PzyPQ00
	 wPaT2LIzmM7rvzVu3SOwK9L//B+V4TpYeRxZ3wLZY5gJnKN2HH7dFgCu3aXdkByhXVOlg
	 24rEE0JsdDLaVwDw/r46isnyMaSmkPQHWEKXSof7MpUDOB5w9l2gvZodc4OShZ8zUEw2D
	 5i3Olidu+q3i9yggcYlaNbgT2Jk5+IpGkBJt9M4nNhnEEUbTnXHoYXgv7S1lMXBOc52DT
	 +1IdGaI5iGbBck6CV0swP7Ks+DzI0xkMD5WVUqfC/ErWatm1DIuxJ/uGbPvHanG5CYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EqoTsEpTgzzT3TqNxPDm3vP0dbi5RDOfClPa4ewLxhM=;
	b=EL1syYPEbqzFOBOc1yZUSbE05o6a4x1zOF+KrXbKXugTdbqTVV+my+z+0sPN7yldml73
	 CpXF/MSy+wG4FfQsoRzdcs/zkb1cj3278CFM8kMNo4VZ/71BS7OkqEG6Un12AL3ACv6V+
	 Zh4i7Zw1KBWCezuiQ4aziXOBznNji79k4aCyyWc1bVWFnc3EWgArzekPWYQDPoHWf0ECH
	 ty/2RVh8f0LCBmTJgSplCbJmALUvkVEAGvpLFNpuqXsXWlTtT3CWX1e0OkLsQG0ak7KN3
	 i8OV6BgQAkuejnKCL1OSX+zb5xrBsSpY5gzOigutuRjKDNeNfkLO1Ey0C8547f8msxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488395;
	bh=EqoTsEpTgzzT3TqNxPDm3vP0dbi5RDOfClPa4ewLxhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aqWUoq90m3jeKRzJaUPketpKgJs08C+KbzZnMG4KqMb0o0lbPhnL1B65/M+zACtJT
	 JuymDrvn2ZdeuEcOU3ou+gI/3UNmwZbWPfymEcUnVWH1V6aNFfsheu5Pgs0vh8Iitd
	 WSgobnjvB+16lhG2lFAyykcT9nNuK725kD3iyLCrJ/QIT/Uq+uWyHmTjJn1Z+fbAtr
	 zXPA5l+kovIo0M1HAd5ES7ZmqWVjs4EWMTVVfhT944iFixXtsKAPNa9KDhRCL4AGhD
	 t9KYiR220/C3NHky/lemZ5+bYuOEuz8F2iM5TjugODtDbwmLvUDxffY2CEgaQkigPr
	 +wjlhRdyIPL1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05FDE81187;
	Tue, 20 Oct 2026 09:26:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CBD52765
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B20F940328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eGZNF0WHshbe for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DBB674016F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488391;
 b=VJbG4aWWtSUr3Gb7e8dvYGsZa2Zsbxed/jeQTttuIVraTIMvMKZIVs/MMG5z3At7U4Zi
 nc1dh/05Jt+oHCJAAA8O8f56J7JfJ4GGZpUkgwHaLGwI2a8sVLszClnMvx94EzUNq3PoM
 7QBAE6dwFlzv0C2SbNEkw6diJxIDcrfIetHw3lt0GIg6sInJHhxD8HfymV0kaQcpdhBOT
 AaxV78E26tJSzYCGrfzD4g23Ls90JWxRDVE/XiEWPVR1YXYzIbbZtWm/0S1aVmy+dHQyb
 NYcCVpGwoKFt7MA1R663lZuXUjQrVh3vXaUDquuwNBKdFrMUh5VSK7ZUpc8jRAFBuXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488391;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=EqoTsEpTgzzT3TqNxPDm3vP0dbi5RDOfClPa4ewLxhM=;
 b=cP0EiCuuCP1Dnzr8N+SMEFNKvAQKyAfjUe5sLeMFY8sup1s6rWWQjSB0PUG5GoO0nSOd
 deqIMtoTBRfUnjF/5OXA2iDcHkilg5MmlnUf50ZYjQcgCMGpUcLybrV8ORUgJ+KbxsBNF
 2qTthMM/X3rRy+yb1sdUie2bbqnk6gsz1bc1sHPfvewo5cRmHeLoSVL+rC37tIr4PSG6E
 odWxp4S2CqT8vyQ/1xxF0ShTdeYVpmwpTfAUP75LgFkps2CJuIrEwUm6ILrGPDp65JY4p
 lLrmxX2Sw7ybEPOPv9gJ9eR/Q/C6EjcoUfkSzDgqqQL5zDwG99oSUfZbMUANEsgjvvA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OVrRdsHg; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OVrRdsHg
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBB674016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F330560098;
 Tue, 20 Oct 2026 09:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385D41F000C5;
 Tue, 20 Oct 2026 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488388;
 bh=EqoTsEpTgzzT3TqNxPDm3vP0dbi5RDOfClPa4ewLxhM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OVrRdsHgyiycpfSjWwzRhBRxH9UBrac+hvMsd0ywtH0KLNMKpao0mUy0//g+3rhAR
 Tciv/k3AwH0zKTlzpO/NKgYifA0//dYwpf5Y7k8PpkGyp9/riGyuMSZurLCgDFeFaf
 t2z5yVZxqtgZe5pCjWdrwFZHvSAKbRbYKBZ5qQSRfGX0TjhB+2oOALJlYjnq/MeR0g
 m7KsyFSDNmZXmBT54hFnT0d57uOrm+r518FR/Ygg3IYx+nltS1uUgzfGwzSwpiwpQh
 FzHUtX9vPfFRQvvAXVrjnKVRvmREBxfvoPLKcK2LRLAyeDUt1vxzs74PUfoiAdRtxO
 /iYeUH34SmRcw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:57 +0200
Subject: [PATCH v2 08/10] test/py: avb: Move mmc device number to a pytest
 fixture
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-8-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4923;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=BDKV32CAiI3ZZZ23QoeMVNeD+ihXEbrATHyLKkdcmDY=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOvcwCJFFy8EHEVIDVxzGdudYuisgdVkpIJZ
 hgvsz/KRdqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrwAKCRAZDR20Zk4Z
 NQh4B/0Rt9kmbi4Gmp2A11cYGgI2uovC5MnOG42e6Pa8FMqTlhZtTAJTU/x8wHSFpAQyyuqX+HH
 SJlFqY//fL4Xxh9mFhql+VS7wVTgH0Uoym5jrofrgVmh0r5fB4/F63vPi5ZOc72beODPxBCjLdh
 qCIgSppL4E0k00hB0PCOfRwAvf09SKhz8JJ8PkSrnY9hhtS3dRUPc1Bi9anDRHyeHYmih+9Gxfw
 psnzz2e/JTK3jaAZh5i05Qs8I4k1AfXCCqBmUkcolcy8hePsKBxpJgCuuTqfkN0oEv3zeNcHg47
 ggz5Imk1U2w/nnrza6ErrBQFgTBdIcS5ds2mBfe5luC59gH3
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

The AVB tests hardcode mmc device 1, which is usually correct on real
hardware. On sandbox, this is not the case because mmc1.img contains a
fedora image.

Replace the module-level mmc_dev constant with an avb_device_id
fixture so that a subsequent commit can override the device number
for sandbox.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/test_avb.py | 38 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index c66ef0cc52d5..34cddc485ebc 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -16,20 +16,26 @@ For configuration verification:
 
 import pytest
 
-# defauld mmc id
-mmc_dev = 1
 temp_addr = 0x90000000
 temp_addr2 = 0x90002000
 
+@pytest.fixture(scope='function')
+def avb_device_id(ubman):
+    """Returns the device id number for AVB
+    """
+
+    # default mmc id
+    return 1
+
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_avb_verify(ubman):
+def test_avb_verify(ubman, avb_device_id):
     """Run AVB 2.0 boot verification chain with avb subset of commands
     """
 
     success_str = "Verification passed successfully"
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
     response = ubman.run_command('avb verify')
     assert response.find(success_str)
@@ -38,15 +44,15 @@ def test_avb_verify(ubman):
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.notbuildconfigspec('sandbox')
-def test_avb_mmc_uuid(ubman):
+def test_avb_mmc_uuid(ubman, avb_device_id):
     """Check if 'avb get_uuid' works, compare results with
     'part list mmc 1' output
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
-    response = ubman.run_command('mmc rescan; mmc dev %d' % mmc_dev)
+    response = ubman.run_command('mmc rescan; mmc dev %d' % avb_device_id)
     assert response.find('is current device')
 
     part_lines = ubman.run_command('mmc part').splitlines()
@@ -70,11 +76,11 @@ def test_avb_mmc_uuid(ubman):
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
-def test_avb_read_rb(ubman):
+def test_avb_read_rb(ubman, avb_device_id):
     """Test reading rollback indexes
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb read_rb 1')
@@ -82,11 +88,11 @@ def test_avb_read_rb(ubman):
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
-def test_avb_is_unlocked(ubman):
+def test_avb_is_unlocked(ubman, avb_device_id):
     """Test if device is in the unlocked state
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb is_unlocked')
@@ -96,17 +102,17 @@ def test_avb_is_unlocked(ubman):
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.notbuildconfigspec('sandbox')
-def test_avb_mmc_read(ubman):
+def test_avb_mmc_read(ubman, avb_device_id):
     """Test mmc read operation
     """
 
-    response = ubman.run_command('mmc rescan; mmc dev %d 0' % mmc_dev)
+    response = ubman.run_command('mmc rescan; mmc dev %d 0' % avb_device_id)
     assert response.find('is current device')
 
     response = ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
     assert response.find('read: OK')
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb read_part xloader 0 100 0x%x' %
@@ -121,11 +127,11 @@ def test_avb_mmc_read(ubman):
 
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('optee_ta_avb')
-def test_avb_persistent_values(ubman):
+def test_avb_persistent_values(ubman, avb_device_id):
     """Test reading/writing persistent storage to avb
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb write_pvalue test value_value')

-- 
2.56.0

