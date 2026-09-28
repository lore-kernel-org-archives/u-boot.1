Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6860FCA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7615B80C38;
	Mon, 28 Sep 2026 22:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FXWr1Fqs78P; Mon, 28 Sep 2026 22:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0A76F80BE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634966;
	b=mtBZ45maNYA5p7g5ABC2+VDbEd5A4l5v3yhsF35NKmWo3UtvGOnORcCPGDmLFlIZaMV7
	 J/ML3InRJ0DtLx8O+XnvH2t10kf5qpZdZPSerC8PaRjqXWf61KRAvC2P6DJDvYgyLokCj
	 BIbpxOdaW8CkGWFvkFbOGkqWvt1HFdeyERtEW71KIzQCsC5qeisVk6bKFjfvJW2yJROR9
	 7feIDUiuVW9cpPOB0NqLrZRU/6w5cFNNa8okevGcme3NvhIuj99QYVbevbLKv51hPfWq7
	 sYctbw/67OfMlugRUNmdYxVvyKMoj+eKxosB2nZq78NzMvVveC7NROPRwkmdTb+faWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ExtBpGPHMInccGsK4p7yNgiuh4nAWqXt7VOfa9zuh1U=;
	b=ppNjujwXL1RM5MArPa8dFasVXkrA9gzjiqEENP/htnXqFuVvhy/of6SiFZDsYLWqxVW1
	 HOIQRKib+LWq0TsV4N5WTbpoSqRQPcHulckwKx6dSZsyo/0/FOCYSJ3dWkpIy3ic5+G0H
	 Iu626ImHTF479okLNrBmOkBiCP9Hu3eZjuhL1oXMvx3pW19THZDZ5sv4luwbiG02AxJWX
	 rEPU9eZjRiBfC4iFT41R1dCZDtjE1vxbjqkmi2WrSB7YkU4OrP8VKOxQ6L9UujY54PVsP
	 FX98Z6zsFQXBdwvh7FxVjKm9j0O9a0fxZsVfduKIp5wVWCVWJ20DvE4plt0iKOjWw1A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634966;
	bh=ExtBpGPHMInccGsK4p7yNgiuh4nAWqXt7VOfa9zuh1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VWaxcSr5YVIeuvUGUYOGTDKMZs5SLdablppFs00SCaem7FB7r3SFPsMIf4JSToXT3
	 7aWP3GdoxeoK2uqh9/y83TjiRLuGEcQWsKLUw/4O4nQB0LLm3xehcICdz593TO2USo
	 8PFEHsUGTP7vtr5R5BVrSPwu+V10qFG9ZXpu/mryVmJw4mvge3yuhrXlXkqJDMXweJ
	 qRDg2ZtV+mbrj6c+yJ0jakHx9ttisJ1WOul7JOY+6mW8ZOCnEs6rskLEVvjylfd0rZ
	 O7/J2vfiZv4uHoWJumgH+35OST1lPQJJFaJ3c+LYPdE0FuiSBtXn75tQ8wreZdq19/
	 VkWdDc2jl0+eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A76F80BE8;
	Mon, 28 Sep 2026 22:36:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0311B335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCF5860614
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-y6VoRE72Cw for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:35:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CFABB605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790634959;
 b=YajCeC6l8pfPoX6naekSeHQYncfFmo/WNdaHA5qqdUjNnyvTLllfzKvCTKwZXqnhRhFz
 yLy6Py7USwmzoIRhz44J/cPSB+f/KCE4BA1Z8xlqIMHa5KNgtf/0/oTZGkiCM2NX47Fod
 PtAZ8KSYxFlR5Mqd2mSeo1plnz7bh3mJbtK3CUKMZwSI7pVp8AFa0IxzFyTu0pAIdfls/
 bNl2GwmKS5POhXIDmqzPf14Fgg2mTs1vUIITihc5G9kWnpqT4HX3y0iW1UV6pqqKoit25
 ImRQ589En+XJFCiQFvv1SQY5KERjSIs+3QEXDZoqOb9VXo4XQp8bNZD5Lm7aRGqzuSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634959;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ExtBpGPHMInccGsK4p7yNgiuh4nAWqXt7VOfa9zuh1U=;
 b=UtD+ufbwQ1xATMdPoeYj0nLga+ntih4l7IBL9T5ijm0up4cDngr0u+E9l4IVMUX1I8jV
 J1aksdImWhzlxhH1620MeMLWu+OtKI5g8t6yyUmgOdF7IA/S6q/EMeENrgE12u9TIKbs6
 d/k/ARzBNAQ0BwaqKg9SrckfnutE3o63XLfVvL2Yz1nHsXToWHezxMsSmu8OBij+vXbun
 x4fvHnNxKyEAS3YvCx7/0xggeRIKLGH3onxs2PDpoTCGjfT24IoxrH3DQCyK5yfyhEr0/
 /VmUE+uQ5x3WKivv1Q7i+b60PygBSppCPNvtusI7oHaruPM5Uel0ZI4JJyuMdzMzpAg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YklbL4D1; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YklbL4D1
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFABB605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:58 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b8e911e665so2829269e87.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790634956; x=1791239756;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ExtBpGPHMInccGsK4p7yNgiuh4nAWqXt7VOfa9zuh1U=;
 b=YklbL4D1ZOFXUe5ZChq7+YvCuz7loQlNtslMTfVoGyZpB7bozWd7u4ydR+HsweE8E3
 BHjiaoBdma0hMKRhWElBdfQ59zlEXrjS8G4FXtY0VQKa87yOq4p7yeyxTlgER5KQGZaE
 5qCTePDTPIV2270aFces6mdPuTW4+hSTsyILcmeZS8990DBURA83GPoiqwxHkWCJSPLa
 8KuAhhFYtsRFNlWiThmmvc0bpw9JFXG1o69sYSefb7ykAvUfs0USKd+sahHLHklJ/FvQ
 QPdLuqsMTT0a4g/hKUDQi4uy/b6/X1932FiSU+Ix+q9WSUVQu0LwH8+vfoXQLIvVodYa
 8mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634956; x=1791239756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ExtBpGPHMInccGsK4p7yNgiuh4nAWqXt7VOfa9zuh1U=;
 b=M2Cn5GDuOMyi554BkHCde1bHNnAFisHp8k8b4yDoKPeojWgMstbClSObHND1qd0hBk
 w2hiU44xRjTwmW7p4jt2I4Cbi+yK1RGbAaq2qso4sWhRc0/5PlAp5AvBwEJjBztm5C+e
 8Q9T/QlkHIZIQxDNmprlzVL9kCB8PaV7vnNWOGpEVOMdpBaZKx+OwmPSJfOjmTxwWEZs
 0DAAuMwm9+10iXJ3LMylUMJPdBX4kIAe8AUv1TEBNE8+okfPj6YiVbuMHaD/BquVptj5
 i9GZyHodUDf2eN6efEAfqKvdJnF5iXusTRLywnHfXME9rUx+psJ9UpXOILrj0n+NoRyP
 OTsA==
X-Gm-Message-State: AFq9FYLQn1Z29z+bnc+9sVBYjhtC7rI5xoi9a+yfOcJloUqdFdtsJre8
 3wpiziLlypKT4kc7G08FtpPUaAET7Uj63EY+Fys3S+aKorep1eY8H6Fw25PpDpU=
X-Gm-Gg: AYBFou14+rtxu/vq0Ws/gN+Nsx1kKG5m7diassKk5k0ujJ+rsxrHwAzPd6a5KbCTwCj
 Yz8zZhRm9+syfp0waJA7/3fpbEfyhLYyewqeDw5DbuKJi1KE4rwG/InOOP//EgDkUypxqNF4YUG
 DT8+ye5EKkZzM7NH2ElojUCzmdk/V3utXg9KCrdPgenJfu7iEHMx1H5HLGIGriRyCD55U/zXqmN
 mE5z2aO5YLcga34CqE+0KtY4uUCrKVPYkj5M9fAJoeVjT+uWumpliVQt719wEvRb7dJkX5iFKlA
 7edjQF0qxR/uFASbi1TtfwMUAmHmhJPganB9VgCJiJ6GMXXIYUnHrqcy9ZJWo3iSJNpx32hSF9z
 CGODJDz2gLYf7eWnK9oBJMMynmxasvj/l1c5YlJ12sfmE7lMaw0yV46zJ0dUcuP+b8TN9CoLhF8
 rgEXzSBQZ3XLT1GuRGuHic+KGuW4bdFrB7l3nbDaVKe0JeTtP4qb0S766teW4e
X-Received: by 2002:a05:6512:694:b0:5b6:1a7c:fd80 with SMTP id
 2adb3069b0e04-5b8df0d7b6cmr4942702e87.38.1790634956092; 
 Mon, 28 Sep 2026 15:35:56 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9deba80c6sm863466e87.28.2026.09.28.15.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:35:55 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [RFC PATCH 4/4] test: py: net: add httpd test
Date: Tue, 29 Sep 2026 01:35:32 +0300
Message-ID: <20260928223532.482192-5-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223532.482192-1-sochnev.v.74@gmail.com>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Upload a generated file with curl after checking that an unknown target
is refused, then check its size and CRC32 in U-Boot. The test is skipped
unless the board environment provides env__net_httpd_file.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 test/py/tests/test_net.py | 95 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index a2007c2fd..8c4c67f2d 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -72,6 +72,17 @@ For example:
         'timeout': 50000,
     }
 
+    # Details regarding a file that may be written to U-Boot using the httpd
+    # command. This variable may be omitted or set to None if httpd testing is
+    # not possible or desired. The test uses host-side curl to upload a
+    # generated file to U-Boot. The optional httpd_url entry may be used when
+    # the host must use a forwarded address instead of U-Boot's ipaddr value.
+    env__net_httpd_file = {
+        'addr': 0x10000000,
+        'size': 4096,
+        'timeout': 50000,
+    }
+
     # Details regarding a file that may be read from a NFS server. This variable
     # may be omitted or set to None if NFS testing is not possible or desired.
     env__net_nfs_readable_file = {
@@ -554,3 +565,87 @@ def test_net_tftpsrv(ubman):
 
     output = ubman.run_command("crc32 $fileaddr $filesize")
     assert crc in output
+
+@pytest.mark.buildconfigspec("cmd_crc32")
+@pytest.mark.buildconfigspec("cmd_httpd")
+@pytest.mark.requiredtool("curl")
+def test_net_httpd(ubman):
+    """Test the httpd command.
+
+    A file is generated on the host and uploaded to U-Boot using HTTP after
+    an upload to an unknown target has been refused. The file is then
+    validated in U-Boot using its size and CRC32.
+
+    The details of the file to upload are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+
+    if not net_set_up:
+        pytest.skip("Network not initialized")
+
+    f = ubman.config.env.get("env__net_httpd_file", None)
+    if not f:
+        pytest.skip("No httpd file to write")
+
+    addr = f.get("addr", None)
+    if not addr:
+        addr = utils.find_ram_base(ubman)
+
+    timeout = f.get("timeout", ubman.p.timeout)
+    timeout_secs = max(1, (timeout + 999) // 1000)
+    size = f.get("size", 4096)
+    url = f.get("httpd_url", None)
+    data = bytes([i % 251 for i in range(size)])
+    crc = "%08x" % (zlib.crc32(data) & 0xffffffff)
+
+    ip = ubman.run_command("echo $ipaddr").strip()
+    if not ip:
+        pytest.skip("No U-Boot IP address")
+    if not url:
+        url = "http://%s" % ip
+
+    def upload(target):
+        return utils.run_and_log(
+            ubman,
+            [
+                "curl",
+                "--silent",
+                "--max-time",
+                str(timeout_secs),
+                "--output",
+                "/dev/null",
+                "--write-out",
+                "%{http_code}",
+                "--header",
+                "Content-Type: application/octet-stream",
+                "--data-binary",
+                "@" + tmp.name,
+                "%s/upload/%s" % (url, target),
+            ],
+        ).strip()
+
+    ubman.run_command("setenv httpd_targets test")
+    with tempfile.NamedTemporaryFile() as tmp:
+        tmp.write(data)
+        tmp.flush()
+
+        done = False
+        with ubman.temporary_timeout(timeout):
+            try:
+                ubman.run_command("httpd %x" % addr, wait_for_prompt=False)
+                ubman.wait_for("Listening for HTTP uploads")
+                assert upload("unknown") == "400"
+                assert upload("test") == "200"
+                ubman.wait_for("Bytes transferred = %d" % size)
+                ubman.wait_for(ubman.prompt)
+                done = True
+            finally:
+                if not done:
+                    ubman.ctrlc()
+                    ubman.drain_console()
+
+    output = ubman.run_command("echo $httpd_target $filesize")
+    assert "test %x" % size in output
+
+    output = ubman.run_command("crc32 $fileaddr $filesize")
+    assert crc in output
-- 
2.55.0

