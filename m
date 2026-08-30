Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51ECC61DE2
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 07:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F4DB60615;
	Sun, 30 Aug 2026 07:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gZ9QO7JW-jZ; Sun, 30 Aug 2026 07:41:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788075667;
	bh=pMF8pkxo0I4nHcEIYPFtXHRT96kuCN4Wnh8BPzqFPcA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z3a30RyAj/UXqXWARInseY9XEcxvvTBh6nHsBT2HY7MK4a6euQX/dMkq99qrdjtkx
	 0MjW3mOc2N70MLGoup5xX/ea2u/fAFFI7MKusMr8fo/LgHy8hl+idq52/Zn8DLffFX
	 nLQP5B/yO27PfndUEoIdtm0I48EXxgSjmHtCcFusJbzt5IysBiHnU9cHf24L86Ar62
	 RELQWx3K9EIe7wsp7PbL7EsFOxuih9nbC70J8wuvXO7OYxKBd2LuAabGayysOyfrwO
	 ly3bW5Fa+1Tj+ayawP7VbxtDgiDfxMx6LGNDqrG2GqduP6BsXgZXiBdvv7XnDwmJVa
	 P7lAWVWghji7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9B796060E;
	Sun, 30 Aug 2026 07:41:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 699A2230
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 07:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B80E400BB
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 07:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPQlYiDtcXBj for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 07:41:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=LWyXfXOg
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBE4940050
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 07:41:03 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AC7B341DF0; 
 Sun, 30 Aug 2026 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788075660;
 bh=pMF8pkxo0I4nHcEIYPFtXHRT96kuCN4Wnh8BPzqFPcA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LWyXfXOguEFpuf5IAaecXZ2aKy2sYIuRpWs8mCvdSboGiGi1KmlK3Dn8RjldxpK5H
 qHIO3awJPZy0MxPS6qOaVzQplNCVdxSnyGEzzvKzNl92LW5YXlJtBPfYNffHuglHFY
 ym8NpIDqcVQxl4a5kndOmEljrWzs5rocK8ZvaHyLluVN/JG1bAgMEWot+mE//7x6cr
 uEjo+DXQ7K/8FQSFPzpae+GEmj+LnXGgeQLPQsmJEyc++D53HsF7K/o1yLNoKll/g7
 RlR9cD/CAXPVbazJQGtIiegmKnRueLUJdner3BT/qNXDWmGRdeNmradh6jnQ9TY9zn
 NH1kMIJ67BLPvCLUCiyUzzPF2CHH/ynaJdaNUljPI3TF/JkfzzUarivKi/89J/+dLj
 SsjhomSSc6EIXIFBsEuJBL/cENpJTTt/weqhqU1mVeDIG/VX6K9gwUaBqD14zi1iER
 kwkNxX+feOIqQJoSdRpK1a3XA5zNx6mAlKwtOtxVj88PLUWPTpSIwde2Ztl9YzizYX
 HQpvbBjkkT9ef/TFiqCVvJ2rZJzZZDXry5VJyohrM/qdC30enjrtZtWjq0O3TNHcYh
 I/ojSgKIM5KydkgkApEQdv5j0VsXaBBD6ACVSmly/c7oWCuA99hLO3Wcm2ExBTbXgB
 5Q31r2tkV68SqdwkKXZ6A+EE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Omar A ." <gizardglazeman@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.u-boot-project.org,
 Omar Almahri <284399732+Cyberpsych0s1s@users.noreply.github.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: rsa: reject oversized public exponent in
 rsa_gen_key_prop()
Date: Sun, 30 Aug 2026 09:40:38 +0200
Message-ID: <20260830074038.187514-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

From: Omar Almahri <284399732+Cyberpsych0s1s@users.noreply.github.com>

rsa_gen_key_prop() copies the DER public exponent into a fixed 8 byte
buffer with memcpy(pub_exp + sizeof(uint64_t) - e_sz, e, e_sz). e_sz
comes from the key and is only bounded by e_sz <= n_sz in rsa_get_e(),
nothing limits it to 8 bytes. Since e_sz is a size_t, an exponent larger
than 8 bytes underflows the destination to pub_exp - (e_sz - 8) and
writes attacker-controlled bytes below the allocation. A 256 byte
exponent gives a 248 byte heap underflow of controlled content.

It's reachable while verifying a certificate embedded in an
attacker-supplied PKCS#7 (efi_signature.c -> pkcs7_verify_one ->
public_key_verify_signature -> rsa_verify_with_pkey -> rsa_gen_key_prop),
before the cert is checked against the trust anchors, so on a Secure Boot
board it's pre-trust.

The fix rejects an exponent that doesn't fit the 8 byte buffer before the
copy.

Reported-by: Omar A. <gizardglazeman@gmail.com>
Fixes: e0d310b098b1 ("lib: rsa: generate additional parameters for public key")
Signed-off-by: Omar Almahri <284399732+Cyberpsych0s1s@users.noreply.github.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/rsa/rsa-keyprop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
index 80d0594a430..2ac039ac3f4 100644
--- a/lib/rsa/rsa-keyprop.c
+++ b/lib/rsa/rsa-keyprop.c
@@ -665,6 +665,16 @@ int rsa_gen_key_prop(const void *key, uint32_t keylen, struct key_prop **prop)
 	if (ret)
 		goto out;
 
+	/*
+	 * The public exponent is copied right-justified into an 8-byte
+	 * buffer below; an exponent longer than that buffer underflows the
+	 * destination pointer and writes out of bounds. Reject it here.
+	 */
+	if (rsa_key.e_sz > sizeof(uint64_t)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* modulus */
 	/* removing leading 0's */
 	for (i = 0; i < rsa_key.n_sz && !rsa_key.n[i]; i++)
-- 
2.53.0

