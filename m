Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D98C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF7C860740;
	Mon, 21 Sep 2026 13:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YI2bTTWi9qO4; Mon, 21 Sep 2026 13:12:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5483760755
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789996368;
	b=XoGzzoOXK9296vCpJPXx/VFBrLhCK4rX9nve7HKW6ps/5WSjhwl4+9J+ZgOXcWiqAq3g
	 4pppRtWuNWxFDXdAuP6oT132rJUELBKsBF5047SsKI1G8lj2uWXzjC2UjP86hmx9B7M+j
	 IprUiwjiszlAHuedRPminKbHcAO2m7fJeTDRS2jTbGdbq24GHheLxAFdhp3kJMHiRVAj1
	 psu5r04nGwQwe7D3xevYFoqMgtAiUkJR+3FcHlwZin/tSwsTk146tY55aEWA38Ei0qbw0
	 C0HD/WTF4mHXQfo0J6x/qzrDF4cdjI2lT4SH01m2YBayG7y13So1Nt7a1NMUFjuDFjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789996368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UFn52UYUi2DliwB5AnqWN2e7X31jUZ2EPtl+qxIsMrc=;
	b=epB/f3JjLNyeDQrMo0qRi23DwbUeu5OuA2Tn78MI6Pg2lte7uvjvof9e4vJOnHvOZ8st
	 nCLgxBagr4PJPlNMfl88z3WdJIlfeZV9gchP8AQM81Xj2JMBsg+D4ZhFHz+Yva1kh8hhv
	 nXrIKHpBGPzn0OKda0TrdngGnR/8A7cP0+Mtv86GLn0NrrFRBo9jh9QODJ4A1HWnF4VUU
	 2EOUFsU79uHNjwcZAqfzebhPEOAQ2lGZBy6xIXtRj/ydrCXSSu6JOu6F4I87iK1ypQxAm
	 PXI+1jpuJ4ADGOLA37ZM71v/6ufEeLH71Xa+rs0HQx2jk6qIX9nG/QIjUv++SUgmJFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789996368;
	bh=UFn52UYUi2DliwB5AnqWN2e7X31jUZ2EPtl+qxIsMrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjUUd67DysL1q/Hk/CvYlfQ3HntZjkQcMjzblGhMtroS8eJ9TQClIxrF+X3YBC0XV
	 qo3zBP3N7dZRojNDgGqxUNkdbuL9qR+YQ/d6gTyMVeBy/1Dsju5XDM3+LGZPD5mZTX
	 4QM11vysvG0Gw9HS8KY8YL7rnQAnO4Ju7K2rKsGUEv1iebWhlD72uW3BDX2FBNCDQC
	 u9Vkcb5MXtZzim5rnKCYK6Kbk7ZRECjvLNCFdaD0AJR9dxd4TmDUZZ+8V/P+eoaiCy
	 AQAOgY7Lfo9Ej17ycCBtSTzZ/u6L7IqI3UCNswCEJM2peFCrHKwKIP2vSzZm4QYE9J
	 o3rJ8uci08gMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5483760755;
	Mon, 21 Sep 2026 13:12:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E855F237
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D226B405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KvunReuME5C3 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:12:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 218BD404A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789996358;
 b=d1iqhwRbmnDYOMIEhYM535XPNULvfjPzgaYOyl1VO26iphzNP1genzl4Dgi9f06FPX1E
 AKUWjxZeyId+AEQ64M5hudtyCOnBWlNbxd5jijMfAaLEJIJ2xrEhSZXjYyj7/yeLu/rUI
 671SAPs3dAqBpKIc+JSjCxwihQOkuRVguhRTdctsRkokPwsfyjoO9HI4mlzYhYTdMIwKf
 AQx9rFK3Y5GhIEdiXtUpWPAzIk+KyQjN0C8qoVmtYP7Z9+Cl1RSzA+1Prvg2O7pM7QuAf
 kKZQ1kmuWZcPCCORuXORDcsKKv2DDe0fay75bAlXu7NTj9yTqTdR/lJD/xcvQuxQNIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789996358;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=UFn52UYUi2DliwB5AnqWN2e7X31jUZ2EPtl+qxIsMrc=;
 b=mVaf2OnOduii7+D70Xvvg78BvbHUDpyHgmtvexQB+6CvrY+6wxbe8bqX4oqTI6hNjxZE
 wPA6BLENjQ5hrjP87c1iXVAKCL8myoQhwd6JsU3hy0zQuS4pbeKH7lnddK79Bem3t6V18
 /uN4v4o28jKGcJJ76mdSeoEv8m/D1MUiutYAQmGvanOAD5UcBqgGzyq8i7pKlVzgQ2kZM
 NijoWm6OJK7LRpqlZaxXSvI7GcvaW3nkn+mKWmcilso29eUNhRlm6xBYj78eEimVZ8aEt
 772V7lB9ZkxSr31iC2wJ8bDsaumfb+76P83pabimf/7csOzOwx7/1ydTA03Lja1tUag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="SYyD/67M"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=SYyD/67M
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 218BD404A1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2CD21DB5;
 Mon, 21 Sep 2026 06:12:33 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E833F86F;
 Mon, 21 Sep 2026 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789996357; bh=8MHCZXScGQJ+n8pyAk1rX87FrQzSUKXnKkcX4g10qWs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SYyD/67MgVxuxVQsIp/2su5j8VTXSY+/+R0yVHEG01u4QDHFLm1ie35hHw8OPb4kb
 Ro0ee8TbiSSQAPQlpEwMtiYdI7KHXYZi4EZOU4aBLDjSsIsfu7i3Nt1u3JXg9qxhai
 Uw2/negnRsC+65Kr3+rZ0NeFcoDEXaH6wzRdhO9E=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Mon, 21 Sep 2026 15:12:20 +0200
Subject: [PATCH v2 4/5] test/py: add 2.2-2.4 ECPT tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-conform-v2-4-daeb00359af9@arm.com>
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-0-daeb00359af9@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=8MHCZXScGQJ+n8pyAk1rX87FrQzSUKXnKkcX4g10qWs=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqsS08EFz+YeOfiu3kBdJWs0266pTG1QfRxfZ6h
 PUQ1peP+66JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarEtPAAKCRDLSfhWdqMG
 lKvnB/9lm1gSwy6gTAGDxMwjIQUxFbpOMjhIJeOZmmuvuzOaqUCrkGF/UVOKa33SnSgonEtPB9m
 wAJT1r5k6CoUaZ0fh4r/nzsz8xK639zvObQHMyA6UwTOBSZ7ZkKTXkweQKbmE486Bb6XHCwtUUB
 igcoAe3BlYxaE8v5hLihD92/pGNs07oocU/9/+ahbFjL+W9coGBZ2GHVI4x6rMpgDboMVBIkPqi
 92xznRy4F59nsn9BVYfIp1HyqPOkHm5TK3sGAyoKzcRj8uiKom/5+XJOW+47aZi8vpwObDLad+d
 tSosRRsPPyWMe6NpYx6ICUqSe51eQn/HKNZTMQjOcWjULhDu
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

