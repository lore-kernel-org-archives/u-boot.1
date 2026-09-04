Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCDAC79F87
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 15:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23E5440CB3;
	Fri,  4 Sep 2026 15:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lkZrburH5giu; Fri,  4 Sep 2026 15:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3430D40CC1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788534124;
	b=mIkfU3M3NJBkR/8pS0iSxvhtTsPixUJE+g8GS4BwPAMWNU30ID39+2NCaIaTa1i4ZNR2
	 E0eaB9Ld6c54c+I9E4doU6RMWfalXogEMQ/9FE+dTqhlRs3KMhUBm4w8n7KMLBlX8unCi
	 9b/7f3Vzv5A07WmJQA8H+/uYPBBjOtb0EfQNqqjxMk6idkb5VbvSZstjuw1Lk67ez+tVH
	 gnysh9OJbTj4O7w2O3VZeXuhYf7sBKpF9+nHoPHz0MMzKgBJNFnQq+sgQHfrYIaVj111Z
	 xi/QoMOWVUAzEA+9qLkBxrtjJt2ytH3+yPnUf+2l8XfrKMFv0S0vHOXZXE65kwmWM6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788534124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UFn52UYUi2DliwB5AnqWN2e7X31jUZ2EPtl+qxIsMrc=;
	b=N6uFh67Jlu/I0udsF94aJGcT42ix9ezExHrXk2huPzyKdTYiFwNloC0E3QGeB2Y88yFr
	 cj1tMlaLbSC+I/BVAt4h3qIL9s8rlMc45fDyPMZKc7w0wdA8j1DrpUUoVd0S/qUDrXXtF
	 9ErRt3CFTUZ0ruHDu9W8yxvhq5GZaw8r1rG+gucsKMbdWHtOESvYSj/WfOYT8ANLvKj08
	 g3cKrp2VZeVc5/cSkKML0yBCEkdrtvZOBydNM2WBr3CXfRlp44NC97CsfLYLXu06jZD0Q
	 TpdKYAV6qL6ZgKmRyC1upPBXrYhGNPMmDOhyZcQSn25OvmAC1emIRyHMoPzZsTK8ZdA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788534124;
	bh=UFn52UYUi2DliwB5AnqWN2e7X31jUZ2EPtl+qxIsMrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTkVXWaMuxnSARbpSevIES4/S7ty4THoBZfNws5z/uFV5SKBOt3eJxzpOST0WOaJ/
	 3u+CiL6akYDv4gb+CnbJvPF+PU6GL1Rwz8pVhZqMpRAJ48YTjg4mK2k5bXEowvhJvr
	 +JOUENrZKpt6koLAbnnM0L+zFPXYD/OCIuPgFFN+DT3luysRG73U3ltXYzZS0c3EQa
	 Cp+JVFCglZWmiIiVB+GDuqaxg3VBdejTIyyFd6jg66LmthrNWiWvYzpAk6Nftp55s0
	 68d8gzEHpVtAoisxh7ZLsNGce/F4ix0ZuR5NT7mzPSq6GDzwWVsTDyKlDj4mdQEtU6
	 6Jaf4M0Rb0WQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3430D40CC1;
	Fri,  4 Sep 2026 15:02:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12AF877F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED08E811B4
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Le5_0zw5pm8d for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 15:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0CA0D81155
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788534121;
 b=f5c5a+fwzAzgzQXPil58ycq4mnHXp3kq0ftN0jT9cXYXLFHICfoeYmSHzwF9ArnEola6
 wS2mGqh5uC0OhRD8Qg7onMKOGMYI7nzxXNwYBMa/AV3MuMgvz9utifhmBfbv4oy3r/P/d
 6AlQweHKLa1L4p55acJhXReVTl6j3OJGHDfzOg4S4zN1B+YfA0/bWzkkjAPZRgWVyoK3y
 QPn0ux+MCPsUrWkjzqnCZfRWl9LiefmT+LhVtCmvj3crUBRp5ct9DJ1yiSvZVQpTPtCnV
 qnpwHZF2N9Bejzhw8NMCyUaeQ2MWa//s6rJ1fS2bRg0SHpwZlZ/WLHJIne/UGcKZ4ZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788534121;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=UFn52UYUi2DliwB5AnqWN2e7X31jUZ2EPtl+qxIsMrc=;
 b=bTdI+V6QNe+0kdJsIuNSLoH1VuBDt/mmAHxgd1DoGR8JWyD9bp+VdsPHUwyjeL7nh/uU
 fTSOyFvmCIkY0RKaBH51lhBz46wxu8QMeRRdLhhbK2x59oobG7eCRF9/UYFCU/mHo0aov
 9sI8/wSXI8h5LFZx8hcCvq4aksM6vvgGuRnaXZojcjhT4f6ZkNq7fJBUJBCz6IjmomEGF
 5Q5UvUdkoqc5V3AAhJRofSEpZCO+PAWtZbHBRSfH47DVP5W4qYbEJV35x6SOHaq5TcNSb
 NYXyVZM4evxRBW+SrdTX5CqYPPvPGwR5cdJjgGiR08f8u5OjMqh+2rVFdGEgirkAshA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=WrdPqroh; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=WrdPqroh
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CA0D81155
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559011688;
 Fri,  4 Sep 2026 08:01:54 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.49.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E459D3F673;
 Fri,  4 Sep 2026 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788534118; bh=8MHCZXScGQJ+n8pyAk1rX87FrQzSUKXnKkcX4g10qWs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WrdPqroh6frQTBASNOFo9wpCRMAKhHRfV8a4lY18UpPl+tgG0xjxYu0HVi9FIVdFq
 T3rgRTsaIRbLBuo0WaAetiVi/3ho/+7MnFasQJBeyNpDpjRz1Ae9ZPpD3kYjmL5j9b
 LOg+RmDtnJ4uN5WyTKzXQyzYWCibIPsUP/L5nRYI=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 04 Sep 2026 17:01:40 +0200
Subject: [PATCH 4/5] test/py: add 2.2-2.4 ECPT tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-conform-v1-4-475b2947631a@arm.com>
References: <20260904-conform-v1-0-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-0-475b2947631a@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=8MHCZXScGQJ+n8pyAk1rX87FrQzSUKXnKkcX4g10qWs=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqmt1aSsNuLAJW5dQ1llcnaNfb+zRqhzGKmTLjW
 r00Has0eICJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaprdWgAKCRDLSfhWdqMG
 lNLwCACFx6IwYQhHJ3jCPnsrf739LdiqTmMfbS/35EaUMA5HK+OWeyQTtMrCLbJOnbMfd0m36PP
 EyOudqySJKA9NJeLw4phnCWIhMkEIXfsgXYWS021XWT+cnfH3KSukew2D2L6igouMISBTajWJ5+
 rqMkvzlohmw2dKq0Y/ROBYX9UG9psFDVJUSRewivAAzDUTB2oKCrEZ78u/7zxtYgfmtkaBWWbPr
 Ja8uU7LJ7olNVB1msK4hhAvvIMzOu9kORNvl3yoCngOB0TCIfmC1QYjkFgPcgAD7IeS2X/FEceH
 yAXCV2iP/vTx9n1I/Q1W4HQwprv8VaVN3w+SYuxNsAL387wT
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Add three more ECPT tests to verify the EBBR 2.[234] conformance
profiles entries with the "efidebug ecpt" command.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 test/py/tests/test_efi_ecpt.py | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/test/py/tests/test_efi_ecpt.py b/test/py/tests/test_efi_ecpt.py
index 632a6b90bad..5f6dc2b74dc 100644
--- a/test/py/tests/test_efi_ecpt.py
+++ b/test/py/tests/test_efi_ecpt.py
@@ -40,3 +40,51 @@ def test_efi_ecpt_ebbr_2_1(ubman) -> None:
     response = ubman.run_command('efidebug ecpt')
     assert ('cce33c35-74ac-4087-bce7-8b29b02eeb27  '
             'EFI EBBR 2.1 Conformance Profile') in response
+
+
+@pytest.mark.buildconfigspec('cmd_efidebug')
+@pytest.mark.buildconfigspec('efi_ecpt')
+@pytest.mark.buildconfigspec('efi_ebbr_2_2_conformance')
+def test_efi_ecpt_ebbr_2_2(ubman) -> None:
+    """ Unit test for the ECPT, with EBBR 2.2 profile
+    This test uses the efidebug ecpt command to dump the ECPT and check that
+    the EBBR 2.2 conformance profile is there.
+
+    Args:
+        ubman -- U-Boot console
+    """
+    response = ubman.run_command('efidebug ecpt')
+    assert ('9073eed4-e50d-11ee-b8b0-8b68da62fc80  '
+            'EFI EBBR 2.2 Conformance Profile') in response
+
+
+@pytest.mark.buildconfigspec('cmd_efidebug')
+@pytest.mark.buildconfigspec('efi_ecpt')
+@pytest.mark.buildconfigspec('efi_ebbr_2_3_conformance')
+def test_efi_ecpt_ebbr_2_3(ubman) -> None:
+    """ Unit test for the ECPT, with EBBR 2.3 profile
+    This test uses the efidebug ecpt command to dump the ECPT and check that
+    the EBBR 2.3 conformance profile is there.
+
+    Args:
+        ubman -- U-Boot console
+    """
+    response = ubman.run_command('efidebug ecpt')
+    assert ('7721fc77-a724-11ef-8eaa-f7c9b194ba75  '
+            'EFI EBBR 2.3 Conformance Profile') in response
+
+
+@pytest.mark.buildconfigspec('cmd_efidebug')
+@pytest.mark.buildconfigspec('efi_ecpt')
+@pytest.mark.buildconfigspec('efi_ebbr_2_4_conformance')
+def test_efi_ecpt_ebbr_2_4(ubman) -> None:
+    """ Unit test for the ECPT, with EBBR 2.4 profile
+    This test uses the efidebug ecpt command to dump the ECPT and check that
+    the EBBR 2.4 conformance profile is there.
+
+    Args:
+        ubman -- U-Boot console
+    """
+    response = ubman.run_command('efidebug ecpt')
+    assert ('f2bb0422-da8e-11f0-a67b-1be220854098  '
+            'EFI EBBR 2.4 Conformance Profile') in response

-- 
2.53.0

