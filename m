Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEE2CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D05AF813FC;
	Sat, 17 Oct 2026 13:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lY63kdizpypd; Sat, 17 Oct 2026 13:01:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F23D2813F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242083;
	b=jP4Fz3QrHlHO+wcV9ZVzNPdMtU/afabJRVujiofwsnEo4zQmL+fv6uZQ7rVOhPuhUFhZ
	 FAyft4kKcO/OebhcSsAWA1Mxr7eEPl9zRs2LRcFlC2106gKQlq3Y1FZg0/FUsoG0IQ+Ba
	 RczJMRpQAIYJ10c1VoMGig7HwhiekmJlT5aDOYYqJSA8IxC7CVpNpjHxG0ixVHhntV56y
	 bpKWFTnX1g+IlhLNE+x+uGa/doLroAB8/b2mZoopERWXSHRQi3qLPPSf7M/f2Gfbt8gcx
	 8vL1QFL9aEOIxow0sAhZ7zkZ3D3ciF0E89T4FtqeCJ4PwNOHYd7k7w5uiM2q6I4k46A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242083;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ffTQl9x/cTI7G+ZrDGk4LaQeO1I2wHhjJtn4BT3YsjI=;
	b=R+dmuxy2dA3FCCUpZ6I99vEd6gs7XBdhTkLHMvq59g7teVIU/RysrJtVbzLy/cZM7G5p
	 1LJ+Rl6aVdwEFNHSsN2ZcUMaykCkEn8c5m5u89hi/+pWKLpiy47gXS888s+/ES7sy8JBc
	 BpRgBqltvAxWtnWaazJ0DDKV4BnulkoM0f3TlHtB2U/rTwGefBVzKXEAxnH1PBrGL4FcX
	 vdok6cjb+9ZtIggQuQto876aKdX42dEWOiPyaXtm1358Q75VdcSeu+SjoQHLMOjArdsB+
	 LmNGnMZ1G+G8ZVu5C77JLIalnOZKswBPXDutMVKyKqO9zRsPUQaOx41hYVA6kdNoh2w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rCSapGNa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242083;
	bh=ffTQl9x/cTI7G+ZrDGk4LaQeO1I2wHhjJtn4BT3YsjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WQDbS6N+lkdtrbosOzDTPCPIS76qxrMMe1om6VAO1RA3k5/u5rbva+joZZiCwEArl
	 ctb+qvvq36ZiW3pJGdGWxM/3MtFXxAQZa02cqP+sgTBoITRjw/yKV/rhVJYqoRGxX+
	 G+iYInfzrDe0FUiyc7YJ/3Ptqm6vIcSOXibgh0Msq89HUc/g7YwWQC1UAsRFt1HLPr
	 uIjdtNbglTW1KS4hABagbAft9wpDfcZUi0qKTKE/glNdOVRCSgGER8PGs0tuXbbYh9
	 LuIaC4i1C1aAOZD2S9GxUHe4sPdxyMQc0hJUTLpcQUnAJjHDgn3nNQ23zKUq8CnuhX
	 5E/mLW4Ie1jPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F23D2813F5;
	Sat, 17 Oct 2026 13:01:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C52AA1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B745A812D4
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iNLQYs5oJEn for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 12:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 072FB812D6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792240597;
 b=Vv0ZlSF9tXjus5m4Ij9WFXa1iD4wVcyUGHGb/Zs7Jhl9DCjB19I/PmMk4cUJIf+1Y+n+
 Txua0/VB7A9vO9/3g4TrjormuI4yaDZBCSmpAO1lAOgM89vrzeZDkb/a7Zegca/YpHdoE
 QzK7oBkEAsaJlOBoJe5i1xU5HIme/R9Zx7LwA3rki/+eufPm3WfpNVyif3lZVmwyqZOVM
 XpuzxmdOR01FIVSG+tlTpticB53MScHfFR2cWAmVGrsKDIUe5r6hA2Q4EQ5sFregdeCXY
 cpIlSk9WQyVQcu3aWZJ9sZuTzyIwiDixXJbIs0ocV/9vn4TwuibAi4ozerSm6wEYDPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792240597;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=ffTQl9x/cTI7G+ZrDGk4LaQeO1I2wHhjJtn4BT3YsjI=;
 b=Xo6+p07VJfGqHQaJ7jQrJD8pP0cssoXgOmKBp1+6eu3ibY5NbTpeDGNYkj3TdaBvBFj3
 mZ4ay08I3rF6oQRBBEbFetQiUvP/IDuqY81fU6X8HzlbgpR2rOOeswWcLeQLw5Mma7kxO
 JeFApXrikVgWjpzKf8xHBKAAV0dAM7BI10kqHb+WWl3dcLbTlq9atPyjMa7g016tvikRL
 +KCX6pqf4vUUG+6tkvoloe0rdH5UTLAIz5URgAWNkMzi1jdxjJVh9LSrywU99NBIeVkvR
 drnWeoGrFv99tF16B7oqKdLfbDJJgjcXRdhft0PetdrR5vl/GtiqNG4X5b1K4j1UvUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=rCSapGNa; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=rCSapGNa
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 072FB812D6
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:36 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 197013F162
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792240595;
 bh=ffTQl9x/cTI7G+ZrDGk4LaQeO1I2wHhjJtn4BT3YsjI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rCSapGNa3I9gkeMWTP3+HexZsMbS9RBlNoDFLbWAY7qhbWs2gyqzpx1yL89bIgB8Y
 Cioab4znVa9BnDAm/0nMOnao1f1lgzyGVcnpoLMjEvisYWe0pUjw1pq80hz7HN9sMz
 TU/Gt1FUjzyO4pJvUCVtyLHe40yUWa+L1talaPK4pH0NYPws7lXj5Ik+YvL9qo3jBg
 YoZYOvoQffcWjoOpHN33w5pQ5r+caksfrUsszgywmU9T+ebWQGUlalzcWe6hEH4LjX
 PDUNXWvAH1yBNkKeeCPO1dmWzMWPiTtsKheJvU9Cm/kZvJcDdUxFODkK8iKNaIAgIa
 ycJ0z2eHvAJeX/YDJePP77BzPohW9icEEgfxx2apRrA3ycCKUpR1aai/pq0RdMOLAe
 LbJ8VkIvP9nVHfCfzJ6D3BE+5sRETLLHj5T3SlbEsvAxZMCyqkOx2EK6llF70RWAdt
 FA3ewVbIKBcMxMujbuYV+B7PvsiTABIIlBvRkbRRnqO0oiMhD1aCTW+7t+6uTjcCkc
 Rlhh/X9MY5O3jW1Ey/KFJmoJ3omAErQ0lXqi384byFnAy2jujvghPCofmPeFmx0JV1
 c828NlSALtDcj1uYz0bDPK99vALjhoUt/CWa0kKNQHwIvfBERiroy9u8cy8lxuhFzR
 LG4ceC7N/aBiVV9CHjoIRwmI=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e941532594so7383465ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240593; x=1792845393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ffTQl9x/cTI7G+ZrDGk4LaQeO1I2wHhjJtn4BT3YsjI=;
 b=Z9t6EIlYlafxldH9DRnfl+LtSM8ygeB18+lmAEvun/Q7R76fNmLMxnEHVFx4bq+FXr
 3RZzfeqnflskMtsL9ADA2M31BiNoGRDg5vREzPMhiXQ2htXjIA68c78qA6cE2WLrJ9jb
 JvzHho2mc6ThNuOx1yc9jLarCaqJjnzpc0GXDrfERm04dObx9A+3uQ5A0a1eRHdrCEnd
 Syu2rW7PRwSVv+8LOxCSRtK+8TNncIqzMe6AgmNCnez/tio/X3GByzOp0/EoC+j4pxfv
 BWeKCmyKBtQIouNXePD2fyQISKT5e/aqBliiKbyk/kA+zPluaPgHF/NaKHvkpkR/YvLZ
 Wgeg==
X-Gm-Message-State: AFq9FYLF9bO9XPhNOakm880a7vh9SD/cpKC/D+bvK6dvvM6BEgBGZEbQ
 TWHoM7DBXiq7uvEkppQ+nIhhihkp3RvsyJN3wARFUHaKtCBlQI6CS2HuZDY1QuXmdGXJRpviO4E
 FEry4mFgyqiOu03P/8nmDXTkwMddS7Z8ozClXPDMMxmXvKhpOlyAbew7CbdGNfuG4nJvNMdUCV6
 P7QoWUwXaMVenY0WeUyw==
X-Gm-Gg: AYBFou23okjAztEd7n9xKYijMfEXKIB6Ttnli2zCLGNO2RAhxS667XbRaRUWuo0lfdD
 oY9EZjGgWwab9m8FvW2t4FcuxEx+wMg4/q63ghhiuEQJRK0mOpm3xnI2COn5uDgp3r+FsKkpCbb
 vrR4TmIwfExDKe5SkZ4Uow4i7XKF2FMt2ghR1QQDJA+yPHe5ZGZc4fFyNCYtaT8ApdPGcA72Em9
 dlUebAgtsxZOjD2kaM8jETeTz7g830aIyPpKKXZhMT2JfTXczdNBwUN5d5JdWo6WxpRw+cPkbvW
 CJQUNtpGftZV4141cc7uD3JLIxjTHIebUMrTD+ALyw0x6dvdk4CcsgOu3APuM99DS368oxIxKuF
 7LTHKIHwTH9NEvgt6d8Ti92hbVyzOqR3XnRjuWehykGZiBNk=
X-Received: by 2002:a17:90b:180b:b0:3ac:9669:845f with SMTP id
 98e67ed59e1d1-3acef152d1dmr2502655a91.41.1792240593476; 
 Sat, 17 Oct 2026 05:36:33 -0700 (PDT)
X-Received: by 2002:a17:90b:180b:b0:3ac:9669:845f with SMTP id
 98e67ed59e1d1-3acef152d1dmr2502632a91.41.1792240593007; 
 Sat, 17 Oct 2026 05:36:33 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm7909410a91.12.2026.10.17.05.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 05:36:32 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 4/6] test: pstore: check pstore save after a record is made
 larger
Date: Sat, 17 Oct 2026 12:34:19 +0000
Message-ID: <20261017123554.211799-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017123554.211799-1-aristo.chen@canonical.com>
References: <20261017123554.211799-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:14 +0000
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

Run pstore display with the default record sizes, then make the console
record twice as large with pstore set and save a full console record.
Check that the whole record is saved. Without sizing the buffer again,
the copy overflows it and the sandbox malloc checks stop U-Boot.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 28a60291a85..6c1d5eef2d1 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -112,3 +112,34 @@ def test_pstore_invalid_records(ubman):
     assert(not os.listdir(outdir))
 
     shutil.rmtree(outdir)
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_set_larger_record(ubman):
+    """Test that pstore save works after pstore set makes a record larger."""
+
+    size = 0x2000
+    console = PSTORE_ADDR + PSTORE_LENGTH - 2 * 4096 - size
+    outdir = tempfile.mkdtemp()
+
+    ubman.run_command('')
+    try:
+        # Size the buffer for the default record sizes
+        ubman.run_command_list([
+            'mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH),
+            'pstore set 0x%x 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH),
+            'pstore display'])
+        # Make the console record larger and save a full one. With 0xaa
+        # data, an overflow of the buffer fails the sandbox malloc checks.
+        ubman.run_command_list([
+            'pstore set 0x%x 0x%x 0x1000 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH,
+                                                  size),
+            'mw.b 0x%x 0xaa 0x%x' % (console + 12, size - 12)])
+        write_header(ubman, console, PSTORE_SIG, size - 12, size - 12)
+        ubman.run_command('pstore save hostfs - %s' % (outdir))
+        with open('%s/console-ramoops-0' % (outdir), 'rb') as f:
+            assert(f.read() == b'\xaa' * (size - 12))
+    finally:
+        # Restore the default record sizes
+        ubman.restart_uboot()
+
+    shutil.rmtree(outdir)
-- 
2.43.0

