Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CB606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L8/XZSwg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YggMNe7d
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A87D80D6A;
	Wed, 28 Oct 2026 05:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qF_hfSIB-hB; Wed, 28 Oct 2026 05:50:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A716580D0B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166630;
	b=pqkLbT84jzhPj4jNC8l/D6NuDr0U9kFIlSXUlLcSh/h1fapmWrCEKFTDTfNo5dLLx3jc
	 UkzAzMlF/xs3aYfbbYAWOvra9AcJKfXTZLHHFPpOrdCvV7+tEamFJfESgav3ZJ1s/Zdfy
	 9tKA8s1VWgxFcG0Nv4f2ysJcf1xwqPMe0FSqjOtys+/C5Co9/j1z49YZl+lkJetxeXMJi
	 QJZwlT+E7WRzG6uAY+jV7yYnIY2Kv/V0Hvl8tZ8qu8ZrDTp1/KVmA14xr2r73LFIcKPCW
	 QjCEsQi0GbWGqD70vWvlXawgCNC20Kb5NLvfITA0PjTD5wqiyQbaTRikhaLMFJjnW2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SQI87JWKp9aSSOK19jIjp3QrdN7UJLktzHD/HvPOOFw=;
	b=TLpF1LPrg1/pn6q2o4zbcSdloVFof+2q/OIETQe8oC82vp9Muhk4zyMCid3xH/t2NTyx
	 n/7lCL0OCca/KUQscvIpzwWZhklk+m/XEymgB2jBpizxQ+PAAhzUPf60gH51ZYzw7L9BR
	 d3dPesCod6ic5aj43iGBG7mdPU+4JtU5eQPwTakHADg/IhWpyrzN3/pxOvLje5drB8dDr
	 XT/vDEmHOn7CUaPOYpN+rr3JT7nMf1ShMJoLw6BZlN4/Se0WXeWnNkhu6FiNkO06E/H3U
	 mAn3u51JlpPYKoVzf6BSiOWIe6dGjfFQWlweaIdDaG6YqLs2u3bu/+gItw4GCKEIVLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166630;
	bh=SQI87JWKp9aSSOK19jIjp3QrdN7UJLktzHD/HvPOOFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8/XZSwg9NoYq4/YbsBu48bkB0aeBxp9Fzh4WhJN1Pjv+81pO0XOKkHpWjIkDxIL3
	 ipuY+6JOpiXKnUukFFIgAAugcsiefUQQcu3Vtsxevgy02Ub+CK5KpDixgQ+C7c5X2G
	 HqGfnBTgF0gu/uXmXF6EUeqNbCxvxQCdib0Jc5uPZimuBL4bhjjcxv7o29wHXZVKSb
	 7r6K7ahkFyQBCXmYMwip80k6wAhw7EgYGtwEybhhk0WUISIrPc+PB8RpuxY/3/7E80
	 zWd/HIRvywOgmCqHw13zfroKCHdIQJ6gqr3gjbFGIkhXW4MC569bjCfahkH2o+vVSx
	 ycsQ8H5rVXWfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A716580D0B;
	Wed, 28 Oct 2026 05:50:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DD042E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F383D40576
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85S606QKpJTh for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9E8D40574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166628;
 b=sx0EFr2KBrg7Lx/pfX/f94zwUqWDhZqsoem7LoUJNsRFgMjfoQYajqV9P/F88uAQs8kg
 6CFujZ/zRlWfPJ6z4jtuLm9jGHmo6Z2U1pA488Ns8ePdVGAYRWggDi7pfrgZDCfgDVORe
 OQbP0Ekj8UlaTAGvBf4tgjUQkw6k7dvxJlwE/0BrhO0iEQHTZg8qB8GL9UYUNeWJUqKaY
 Tl37cUSwV4oPrkfFieVvg+ZqP9z4YxGmTzu/bzXvwxNaAzCcJDzIJ3o8xzHGPbwuXrKd+
 qnRoMeCfBLFT0srlj9TvzNB4suavI2Zlf/vcxk3iR36haADNANEEMTA7QzwZRozu6wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166628;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=SQI87JWKp9aSSOK19jIjp3QrdN7UJLktzHD/HvPOOFw=;
 b=JzniEf5AJPR059kKi033Y6ZHgNnzc4um/P5k34988tK8a0J5z+7ucyNy2JhnWYw8zuK1
 QZoZm1N3ytCyqEniLT8Mdx4Y0cm9fapk1c9yw7PBBd4K9RPa3kwVQiaqR70sBPFcJPURs
 NOILO6l62pOlIne9MpCEHvy8xDLEWdPORO70OFayDmToAd/D6ZSTujfhG15KcHDisL470
 x+EOFEiL11iEipf8uotu7nVQNVv2NMB7r6mhjQQKVk2GON7behw305xPLFaWcnSv51vhQ
 RBIgsgp4BA8nAn1FYJhS9QyVyJuTsUOabzA/1Bnc0/JFiKaY4SvwWoQ0Q9SPSPwrBmg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YggMNe7d; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YggMNe7d
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9E8D40574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:27 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso244599f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166626; x=1793771426;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SQI87JWKp9aSSOK19jIjp3QrdN7UJLktzHD/HvPOOFw=;
 b=YggMNe7dzANPUKsxhtg/OyePv43Rxtc/jR4hDw2r2GVdp7oMYpu/NryVu3U2C6LipI
 Z+xqxvYC6TZNRVQ8ScyjaOtKDoECb3q7fULe/mihodYswh5u63Obn5sKDLLbaRv1iFSN
 RNyi8LRHRio+O54xSLDy7t/AKToPKljD/V3b+9pzvvaTo+bs6lPfvGAnfykqtpNLtKC6
 mCkBYI/1OO5yVTsZod5dAgm2+6B3YAEkItV56LhsWrlFJwypBqx3I3u/necsLXLE/9+S
 WQUI8q4D9ttMtPmncu3Z4TOj1ESpXSRFRZ/9BQ5gGUZk7gSBvLsnAiWjQg2iXOSqhXaR
 OU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166626; x=1793771426;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SQI87JWKp9aSSOK19jIjp3QrdN7UJLktzHD/HvPOOFw=;
 b=U3Yut27WGHiQbcyIrZzEQqEpEZFJW+yyrIFccz/fJsCth5GGkNircH6uq8UtC1V3P/
 PMkTqW5Wtl4yWISH9+c9YylB8IR2rq86CXsWyfMrYwYMxXJ3SArT521QAmFmHWPS7/R7
 wVC8mqKL9qORLsW/amzsZkZf3agWOXHhZ5GNwB72eZKrb0YgkuqjWUb8BYwoV0TPEA6e
 iklP639QEg8NYE9+R3iYH/ffgK90CHoI9KmRYAuFBM1yWVZspKGjHwlRecQJc7g8ii9P
 D6shW/OvyWRyVffIUfH/eEhoLEZ+iY4quwhldmJEbCMyE4yJUzdhqpdnEtq7tt8WGOq1
 APTQ==
X-Gm-Message-State: AFq9FYIoU0lQmA5N7DK6D7xW0mI6QxginykFA4T9JXwReArESNXoN9FY
 6ikW5UJ9xnTxnkNirSL4jOZNmEPDhS+Xs1XO+teGozWo9nvAKbUqCx+kZc57G1qq5MM=
X-Gm-Gg: AYBFou0EAcdowrY/DGWthPAZUIOk1ZJD6bIDGpbOC/ZyaBKFKsv4cLN29cRwGH7lbiQ
 ffsXnb3JPPw+JyAJb78g5mMKYQf4xUwyvdZ8ulm1u18sHM1LSuDQTZMPo83MSDBRiXPNIgJjwDf
 AxBfYE/Z78A1TGeclDbptoT9dkDLN2z+g8mRZSikza43Pn580Qs6H9R1hMbXFnagNs4QiaemlP0
 Xhkv2HhMryKXQtvSTeFsSkpztrlnB1qSpYkfDXi8ztWnRspBr+jOr7bfFxU4DLliXT638eqI1MO
 uorA8a6ERzMhRKtl9UNuIdrbtO/cplEHiDMUCUAFpgLfjEt2NHu8og0oX90rALzEDlVY+3ZjAXp
 9ZxTu2e9YCbZduNUs1QlYIG2dq1hJVAzf/0h2bCJMKZA14xj/EJ3Dkq+PyZZBHBsaVKlYSScmoP
 157gBPcUunU9uKOsw2cqexmqJWiwcBr5J9UODkQF3w/frULVxAu5OS8v9cYZlt8OFpZMPqhD96K
 6GHXiorQiQPApn4X5GGpfk0SFLTm+0kwjvVqT6X7A7MqFMTQr9sgiV1kJ8VuZp2YpXvS9ug4G7e
 Lv+HcF3e9efWIQgTuEK2/cygTj97/5I=
X-Received: by 2002:a05:6000:26ce:b0:48e:412:3829 with SMTP id
 ffacd0b85a97d-48e5d2e6cddmr3182687f8f.15.1793166625520; 
 Tue, 27 Oct 2026 22:50:25 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb40733sm20664147f8f.0.2026.10.27.22.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:25 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/7] test: py: efi_capsule: test truncated capsules and FMP
 payload headers
Date: Wed, 28 Oct 2026 05:50:24 +0000
Message-ID: <a1a13d0b-d94a-4c4f-bec3-effe46e7e3ed@gmail.com>
In-Reply-To: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Add capsule on disk tests for the checks that need a capsule file or a
signed capsule:

- a capsule file shorter than the capsule header;
- signed capsules whose FMP payload header has a header_size smaller
  than the header or larger than the image.

None of them may update the firmware, and each file is removed.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- New patch: capsule on disk tests for patches 1 and 5 (Heinrich)

 arch/sandbox/dts/sandbox_capsule.dtsi         | 52 +++++++++++++++++
 .../test_capsule_firmware_raw.py              | 34 +++++++++++
 .../test_capsule_firmware_signed_raw.py       | 56 +++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/arch/sandbox/dts/sandbox_capsule.dtsi b/arch/sandbox/dts/sandbox_capsule.dtsi
index 34d29916b30..f7418f9794a 100644
--- a/arch/sandbox/dts/sandbox_capsule.dtsi
+++ b/arch/sandbox/dts/sandbox_capsule.dtsi
@@ -166,4 +166,56 @@
 			};
 		};
 	};
+
+	capsule12 {
+		filename = "Test116";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			/* FMP payload header, header_size 0: smaller than the header */
+			payload-header {
+				type = "text";
+				text = "MSS1";
+			};
+
+			payload-header-rest {
+				type = "fill";
+				size = <12>;
+			};
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
+
+	capsule13 {
+		filename = "Test117";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+			private-key = CAPSULE_PRIV_KEY;
+			public-key-cert = CAPSULE_PUB_KEY;
+			monotonic-count = <0x1>;
+
+			/* FMP payload header, header_size 64: larger than the image */
+			payload-header {
+				type = "text";
+				text = "MSS1\x40";
+			};
+
+			payload-header-rest {
+				type = "fill";
+				size = <11>;
+			};
+
+			text {
+				text = "u-boot:New";
+			};
+		};
+	};
 };
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index b8cb483b380..a79a975c67e 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -7,6 +7,7 @@ This test verifies capsule-on-disk firmware update for raw images
 """
 
 import pytest
+from capsule_defs import CAPSULE_DATA_DIR, CAPSULE_INSTALL_DIR
 from capsule_common import (
     capsule_setup,
     init_content,
@@ -238,3 +239,36 @@ class TestEfiCapsuleFirmwareRaw:
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_fw6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """ Test Case 6
+        Update U-Boot on SPI Flash with a capsule file shorter than
+        the capsule header
+        No update should happen
+        0x100000-0x150000: U-Boot binary (but dummy)
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test01']
+        with ubman.log.section('Test Case 6-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            # place only the first 16 bytes of the capsule file
+            ubman.run_command_list([
+                f'fatload host 0:1 4000000 {CAPSULE_DATA_DIR}/Test01',
+                f'fatwrite host 0:1 4000000 {CAPSULE_INSTALL_DIR}/Test01 10'])
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+
+        # reboot
+        ubman.restart_uboot(expect_reset = capsule_early)
+
+        with ubman.log.section('Test Case 6-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            # deleted anyway
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            verify_content(ubman, '100000', 'u-boot:Old')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
index a500c499bb9..6e4cca9bfe6 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
@@ -190,3 +190,59 @@ class TestEfiCapsuleFirmwareSignedRaw():
             check_file_removed(ubman, disk_img, capsule_files)
 
             verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_auth6(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """Test Case 6 - Update U-Boot on SPI Flash, raw image format
+        0x100000-0x150000: U-Boot binary (but dummy)
+
+        If the capsule is properly signed but the header_size of the
+        FMP payload header in its image is smaller than the header,
+        the firmware should not be updated.
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test116']
+        with ubman.log.section('Test Case 6-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
+
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+        with ubman.log.section('Test Case 6-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            verify_content(ubman, '100000', 'u-boot:Old')
+
+    def test_efi_capsule_auth7(
+            self, u_boot_config, ubman, efi_capsule_data):
+        """Test Case 7 - Update U-Boot on SPI Flash, raw image format
+        0x100000-0x150000: U-Boot binary (but dummy)
+
+        If the capsule is properly signed but the header_size of the
+        FMP payload header in its image is larger than the image,
+        the firmware should not be updated.
+        """
+        disk_img = efi_capsule_data
+        capsule_files = ['Test117']
+        with ubman.log.section('Test Case 7-a, before reboot'):
+            capsule_setup(ubman, disk_img, '0x0000000000000004')
+            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
+            place_capsule_file(ubman, capsule_files)
+
+        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
+
+        capsule_early = u_boot_config.buildconfig.get(
+            'config_efi_capsule_on_disk_early')
+        with ubman.log.section('Test Case 7-b, after reboot'):
+            if not capsule_early:
+                exec_manual_update(ubman, disk_img, capsule_files)
+
+            check_file_removed(ubman, disk_img, capsule_files)
+
+            verify_content(ubman, '100000', 'u-boot:Old')
