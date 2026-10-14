Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B71BCC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E13A68109E;
	Wed, 14 Oct 2026 20:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JUwpD7i0382C; Wed, 14 Oct 2026 20:03:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A06D810C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008217;
	b=gFheTsncsMKmK6nTK7V8oTcPf2//riYHzMidWkda2s7pnBEd6Xna7MRWGI9TX3PIO+9f
	 cjYl8Zg4ulmyJTzbUbauMjXk3NpCip4tme0zhMN5NubPJjPHpPi3uTfXTbqfiDP1si+h0
	 6MdPQcNO7aUHTISlSJu/nUqrdJCPL/EArh325dMmMJnbXiAZvFq4NArmEBUj6qO2TMgaY
	 OeP+UiOr4uSjTkN0K2R+Ar5SwioxXHhnpjf/jE8pj5umCpVcZ2HxFGleR2IJ3XdYPGKhj
	 SAWMieUX3UBpt2SnCbkyhDRI1fvGi30FKSQLFya8B7p/ZR+jH6FAlQ4S4kVmQG7Ks4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Fc/PEl15kQ1MEMfTeAl4OqGSwtAqkftphUVyZSFedok=;
	b=EY2eQW3Db5OsYD38RRZL6tWP9XLMqclk1qTH2Oepm7Oif4RaDaO/PcOHs5BkovBwbwlP
	 mGW8euSPpIRYb3oWL2Vv79blSTmBLZI9eyMWdSdRo2oR9hu9nyaJfWVTSpva+uA/LF8oY
	 mfKd76gMj8qpJnZzWYxbqjUmsTGjX/+9boLmTNHKSIlHwpWoewHUnYjc5f3ZkWu/ywQmy
	 2oIlWA0hgOfC/WOnIqQHj4oyNA2Ycj3zxy8P8KwzQfl6H/mlQGLQwthS9y3AF3xfGWSfX
	 6eloJVdI2QfHHvc4wH2OK9zz+jfHMkGxnmNjGC2mNiWOz0aofTH8aGE1wvrPYm37GnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008217;
	bh=Fc/PEl15kQ1MEMfTeAl4OqGSwtAqkftphUVyZSFedok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w6km1Efdta/6OsOfIYvArhbJ2bcFB7DXN7zeoRoHEVCAnUSjdemVEj++TY2G04XSb
	 NmaoFQHJ3j4iUpX0DkmZaNmeVluMxJK/wAcb5isgl67Ccj6p3RK4XLI4kyOQ/2F+09
	 xRCQOkhgzvzxdNA34u/TqH+UmpVDdNc+XQl6lcrDIz6s6gcXOjr5/412fUsDP5URUK
	 zOfQ1yA23xnIeaTa5bhDzgZGHNFRL+AHogUX6ADynLWljfwmvdK0g6oYP2Jaf1CEdn
	 p6Ve6Y/BYcIpRSNp28PchSSFOLj43K2auCwOwRJ34hEj64hhawTZva3uzHk7LzzbzD
	 vg58csDFpB61w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A06D810C3;
	Wed, 14 Oct 2026 20:03:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B61A61DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CFB640191
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-KBoj-EZwQh for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7D67A4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002206;
 b=W9x8hfk3PJ4RtFuGf0EOOswAh6hoKuJfkWR8HrNhj4E9owduf/U9AdySVMflEVY5Ll6S
 H7ap6RXV0dC0aJ78iuMKtdiYucat++Ph+1HTUlRyf7Qzql/J2Z1iYwWxaypSUYXsmA8Jp
 iaCXtDHfNVYGj1BvAicf2pFFulV+XTKqPwO+Vhd+MX9Y5NZz5tpZid1ZwkRhjaq76nbMZ
 R+d6WpyLIa/Nl3zw9DW0st8mHMy7QjBg9nJCPm0CfuPSzIpHuHy3C6B3sdbZBWsZyOdsI
 f6kTidQHwCUDNQ12hECpoayArxfc4lACxwBruZ249QzFil9tzFJdYC2xGj34qCqJRFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002206;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Fc/PEl15kQ1MEMfTeAl4OqGSwtAqkftphUVyZSFedok=;
 b=L6aHa/kR7ar9L6k6ChmXfs0fd4k3w48W8b7D59QlvKGidrFWglzEj3IanTzo8cRPwFgJ
 0644ALqWOLg4NauJsCl55544gteZ1Rtx9293kao6nGiedZVwhN+VeUC4kzRKs3djOoC6n
 wHdlSeY0TdzWJf/kPoyMbKEBNWk+32HoOenDfao9XVpGxPLRGLj8+hjJiMBupVg9fc+r8
 XhGHbO2v0HHdwMkfXpYRxeUbP0JGmZKGMJ30+wsXQ0KeeNJQ/GXGwU87Fn3U0kZBWeHJd
 26Yda1QPCxfFCP0apH1GLcYF+SVYzlUg31bPOIovrZiDoPzQO+DoyoC0WXN31F4pOkA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=mp5ZeTAl; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=mp5ZeTAl
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D67A4009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AD1F152B;
 Wed, 14 Oct 2026 11:23:22 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935B43F871;
 Wed, 14 Oct 2026 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002205; bh=9OdRUQFRgsdorpFv2X0m6oS8cs3YCa4PDwTFoMVC2SI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mp5ZeTAlZFKu7lR68FnuXsG/SczBnkXIrqcRUNMX+4rXAPd/D6z7v+QqrlNHs+4FX
 6Eng/GxReJrTvEWl5sNM1YIUXKGqSZ9aifrkF2Jf5ZCwfrKC7SLWLE4ZhlOFP+wXes
 bc2QbNMOjt2NAVoMjgfhT/Wf2tfxnc2HXNilW1KU=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 09/22] efi_loader: make MM transport selection runtime-safe
Date: Wed, 14 Oct 2026 19:22:49 +0100
Message-ID: <7e7d1de2c67cbe9bb5d6b06c5f0316552c2e1bfc.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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

Track when ExitBootServices() has been called and make the MM transport
selection helper callable from EFI runtime code.

At runtime, select the FF-A transport only when FF-A runtime mode is
enabled. Otherwise keep using the OP-TEE MM communication path so builds
without CONFIG_ARM_FFA_RT_MODE do not lose their existing runtime
backend.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v4:

Ilias:

- Keep OP-TEE as the runtime fallback without FF-A RT mode

v2:

Ilias, Simon:

- Rename runtime-phase tracking to efi_at_runtime()
---
 lib/efi_loader/efi_variable_tee.c | 44 +++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index bc15795e94f..50a98a1dd0a 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -58,12 +58,28 @@ extern struct efi_var_file __efi_runtime_data *efi_var_buf;
 static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
 static efi_uintn_t max_payload_size;	/* func + data */
 static const u16 __efi_runtime_rodata pk[] = u"PK";
+static bool __efi_runtime_data ebs_called;
 
 struct mm_connection {
 	struct udevice *tee;
 	u32 session;
 };
 
+/**
+ * efi_at_runtime() - Indicate whether the system is in the UEFI runtime phase
+ *
+ * This helper returns whether the firmware has transitioned into the
+ * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
+ *
+ * Return:
+ *   true  - The system is operating in UEFI runtime mode.
+ *   false - The system is still in the boot services phase.
+ */
+static bool __efi_runtime efi_at_runtime(void)
+{
+	return ebs_called;
+}
+
 /**
  * get_connection() - Retrieve OP-TEE session for a specific UUID.
  *
@@ -399,27 +415,30 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 /**
  * get_mm_comms() - detect the available MM transport
  *
- * Make sure the FF-A bus is probed successfully
- * which means FF-A communication with secure world works and ready
- * for use.
+ * Make sure the FF-A bus is probed successfully during the boot phase,
+ * which means FF-A communication with secure world works and is ready for
+ * use. During the runtime phase, use FF-A only when FF-A runtime mode is
+ * enabled; otherwise keep using OP-TEE comms.
  *
- * If FF-A bus is not ready, use OPTEE comms.
+ * If FF-A bus is not ready at boot, use OP-TEE comms.
  *
- * Return:
- *
- * MM_COMMS_FFA or MM_COMMS_OPTEE
+ * Return: MM_COMMS_FFA or MM_COMMS_OPTEE
  */
-static enum mm_comms_select get_mm_comms(void)
+static enum mm_comms_select __efi_runtime get_mm_comms(void)
 {
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_FFA, &dev);
-	if (ret) {
-		log_debug("EFI: Cannot find FF-A bus device, trying Optee comms\n");
+	if (efi_at_runtime()) {
+		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE))
+			return MM_COMMS_FFA;
 		return MM_COMMS_OPTEE;
 	}
 
+	ret = uclass_first_device_err(UCLASS_FFA, &dev);
+	if (ret)
+		return MM_COMMS_OPTEE;
+
 	return MM_COMMS_FFA;
 }
 #endif
@@ -1018,6 +1037,9 @@ void efi_variables_boot_exit_notify(void)
 			efi_get_next_variable_name_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
+
+	/* Record that ExitBootServices() has been called */
+	ebs_called = true;
 }
 
 /**
-- 
2.43.0

