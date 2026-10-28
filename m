Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FE606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rOi4qcBa;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=mNf/iDgJ;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=qnNEB0OP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32D05606DA;
	Wed, 28 Oct 2026 10:31:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-LkXhi_1bP9; Wed, 28 Oct 2026 10:31:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D32760600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183505;
	b=P28Z66w5GT2FFs49MpIGY6RCY72VYQ1+N58+2VtfBmVN7fEiU9CqIXOVtswnBIIjgYpa
	 7Yz6vuFTpwtDSe8ky8XC2AamQPSTAxsCqd8DlC4e8TP0JEEsCMKEo6Q6/gmAyi0PDisOA
	 jJvzUgcCXeUkXmGMPiGdTjip9YEvTht31+V1qaLsLvycxfBv6dChOgJZgSkJOqcEY90v7
	 GZG0FjSle4G0QCp28ovg5RT+WUeFo8NFWKTUGrSVeHrVlhUQIgfzTKutSiLADDBfICsCb
	 Fcvg73VfaiIrV6jFtt/l7PN1feZpcD7950BmvUksdje5MH4a0Rhk0O3MpZw9P4r1BGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fvONq6P3H/p/6ah50Oz1hGd4/pHO/iU4SMlIOshSTxU=;
	b=F16MseZwGPkumbhINUAW088gkzCZN9UGH+VI6zg0W55VHGeSBLw+0O0UXjZEDzQ8h29X
	 dX41ery5g0qjYCsSmOKD7sg6eqFeQ606MyZ6qIGlrWF1GM0AUdFDceUp9dQkXeYWaeT5b
	 fYZ1zHjAzanUvoHrJxcUI2NRmvuNeR2byMvA6erJghNBF9LQJdJcUe7mU0KDedVFuxz0S
	 AclJMlSigTdsstndyBUWbcrQDIjiIvaXTPtgAt3aJ4JxeFgcISXjui1chQkxJ9Dx6Yqpb
	 Ig3fGTRRNeXmESwv2qprfjL8BBVtP/Nkn8zS7VZGb3O1dUFBjXAqRsseUtda70V2s8w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183505;
	bh=fvONq6P3H/p/6ah50Oz1hGd4/pHO/iU4SMlIOshSTxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rOi4qcBa8es557gGAmU1jrtl9PIaedYjKokiNCAshwv+SceVp82xRbb1GaDiB5MWi
	 aKNQUDqDUvwpFp4ESxCLqzXgJ/Dn3+2I2HL2NPCAmqF671moDteN5hr9DeYNSpbH80
	 clfp4oC4h8iB/bI8W4ZriKDp70q/QEeBysXQignS3QiD/yCr3yCulbBbBfFo+ox42V
	 ebSVXtDlw8zYtB2kVWK2FTOTfhZSittbh8LWVS3YPcJ6/L5STG0sR/LnE5yZdbJK3b
	 /0pFfrUvpt3Pl/sd7GwzazyKj9wzfx0SByuFBlmgse1rPdRme45VBaZncQhXpCnwdp
	 B1qfiBx6xit3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D32760600;
	Wed, 28 Oct 2026 10:31:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5801356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C05C4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B45NMlITkzsG for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BACAD40087
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183494;
 b=Z9kE9BhGOMsYqjlbYirep3I7ZJ77Ts1TUdsn+uSZHS6FzAPUiZschz75E/LpReK3k6VP
 aovIUrEKx8euzPlEu8fT8qoAfDlrHkM2/vBhMbJfI/0IcwvaWp8ky3vVZeQDf+YRv+Zsu
 q90mtQzvPwDCtAiIMpwVpDzcwWaf0bfGc/gdrtMT1qTmxtX0j6hUXHEw9wL4qhwXbKUIg
 JnHUO10a/Tx91euTkmxbP931FZi50Xgh/6TLSdXM9ejOIG07j0bP4GC9GsM/PYzIB+Jhm
 JCtCcECEs9TZaL0zAvJ+Px5PZSH5QCHhPJLoFrOCGoifDxulQNMxRb4Z8emunT4zQWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183494;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=fvONq6P3H/p/6ah50Oz1hGd4/pHO/iU4SMlIOshSTxU=;
 b=g9fQD3VLQLMpRgvWTaoPTnwm0YF9QiwS/+VwGB315capdU7QU/dwuziUHI8rfIUju365
 lkFHgRwgIuKCQNXl0VhcvyqbTRDHmP0XqSp7qGq53fIuHpz/PiIaTVAReQ58mE3lHfXfZ
 MqLx78wHG8dfewfFFVmzTOVkYLcVKeDCx8ZtG+D8GnCNIRINjxoA67UlX5CwfLBsC/kT4
 Kml+wGqt8015WD8Z7027G4DXHM4CG2fbPuWyhuQ0bWcxP7G+s9gqCvPX8I5SlGdkhM1+S
 hjQtkiRbxyJMTfHzEou8oxcVJ8BmYdA9aeBzWqAANEXJMmgZ/B7LMN/SafTe7RDmDBA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b="mNf/iDgJ"; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=qnNEB0OP; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=mNf/iDgJ; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=qnNEB0OP
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BACAD40087
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793183487;
 x=1793788287; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=fvONq6P3H/p/6ah50Oz1hGd4/pHO/iU4SMlIOshSTxU=;
 b=mNf/iDgJuPgSFgcjAhUm1D3Qaz0YYXnvaV4yJTXmv/OOMe+hJ+1txdGP0snPFZwzsJBkub/tjuidD
 v5Kv2CFTmRoZSdzA4rIZZhNNR8st98xaJAVmNoU3N+XSErhLe2j0ZVrLsg9zKBUnFMBiSQwXmnotk0
 msLVxTTX4Mb/kPdIEL0Xw961iFeShnHrt/wwHyjboEDQQ7mTI1xguQuWod2OeWUDlJ3kxk0rnXAT7+
 d+xF8IAgn7tcGnIlduUCzEacF1HtVxFLJvbt9M8y/+qdt9DQnJjxHOF02yiHIR9dCE7Z0zn/xrfWtL
 bQP2iNygjc2naRJ7en6YNMU4Is62U+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793183487;
 x=1793788287; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=fvONq6P3H/p/6ah50Oz1hGd4/pHO/iU4SMlIOshSTxU=;
 b=qnNEB0OPCjF9H/A/+fiqzk9WaRGKVPnVcxabRaq/lk6Y/zs1w9UpBfQ+/BhsDh03A2rvRkgp//W91
 AIIhWL1BA==
X-HalOne-ID: ba0ae1b2-d2ba-11f1-9e44-5b5978544972
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id ba0ae1b2-d2ba-11f1-9e44-5b5978544972;
 Wed, 28 Oct 2026 10:31:27 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 4/6] lib: rsa: Accept .pem private key files as a fallback
Date: Wed, 28 Oct 2026 11:31:00 +0100
Message-ID: <20261028103102.414657-5-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Allow mkimage -k to use a .pem file when the RSA .key file is absent.
Keep .key precedence so existing key selection is preserved.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
Changes in v2:
- Report both attempted filenames when fallback fails.

 lib/rsa/rsa-sign.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 3040b345fdd..777e8920e31 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -176,10 +176,11 @@ static int rsa_get_pub_key(const char *keydir, const char *name,
 }
 
 /**
- * rsa_pem_get_priv_key() - read a private key from a .key file
+ * rsa_pem_get_priv_key() - read a PEM-encoded private key
  *
  * @keydir:	Directory containing the key
- * @name	Name of key file (will have a .key extension)
+ * @name	Name of key file (.key, falling back to .pem if absent)
+ * @keyfile:	Explicit key filename, used if keydir or name is absent
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
@@ -202,6 +203,17 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 		return -EINVAL;
 
 	f = fopen(path, "r");
+	if (!f && errno == ENOENT && keydir && name) {
+		snprintf(path, sizeof(path), "%s/%s.pem", keydir, name);
+		f = fopen(path, "r");
+		if (!f) {
+			ret = -errno;
+			fprintf(stderr,
+				"Couldn't open RSA private key: '%s/%s.key' or '%s': %s\n",
+				keydir, name, path, strerror(-ret));
+			return ret;
+		}
+	}
 	if (!f) {
 		ret = -errno;
 		fprintf(stderr, "Couldn't open RSA private key: '%s': %s\n",
-- 
2.53.0

