Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E815606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QRJthT+K;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbqP3Jg3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E11B80DAB;
	Thu, 29 Oct 2026 20:25:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBGY1xu6mtwC; Thu, 29 Oct 2026 20:25:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57DD280CFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793305521;
	b=AJGwq9bQmekljUSEqaI+hQmHbKroY9ikv8oId+e2DCL4hMHOH38jNokgnkPp/Ef/d9fJ
	 k8s+8lduh6WOpRDiU5rIzuG11ZBU/FwuIFQuj8Smbm415DNyOWWe9jr0UoQ6QR58KtUas
	 L1XAtuzdp7EuZmBfz2B6UnY9f2GHa5hnpqhSp42sbSsCShDguh2fVS/RbZOD2vQ3fEwl9
	 I8L8tTuETJF1V5vLOMS/ElbBr7jxM+41otxhdJ1LQc0eU9Ou23WiDWuJZfzHpzOe4bTBY
	 iPQQcGTEx0ImCjZC9qhpHL/7ybAQnS9I3a4q0DH9Z9eJhb5vFUWzfIwewKHW2+XA5BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793305521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YDi2TQgSOFG3l9E9nN1yVF5a3e1U4h0X2bxGxi0BstU=;
	b=aTIo8f2qVMRN4GbGjyeGdQHKbysF4A2Uxr8bNhzuaOheHVu95PMaI0GslQHzpL2UJ2bM
	 wCHqXV3WGVUwpon2gyxmuGZ9Jl/ppVgNWIGYTZ/6KSiNXThUuAYGt3KBxr9XvHgqVQWV6
	 k6JiQwTSae84jS3ofbLYeiyQlVKxHqUxPXgMnUkFSrcJxzKxpreMIBqVr/WfivJjV6hgt
	 +wPYuKl2XRRasOH/cSz/jcsM++04y//pGdRpIVaNUG4EnWX+Nug/FhQHB6syLRzP1ZqIt
	 E2kzCO3UfRQUhrInAjx7pWGFTjW1BBcJXCybc4afOQYD8jspFq1UJHliE9rI9D+OP1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbqP3Jg3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793305521;
	bh=YDi2TQgSOFG3l9E9nN1yVF5a3e1U4h0X2bxGxi0BstU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QRJthT+KL8EDDtFhpZOjHNgU1xBcurVURDVuinN3tepZiY+nJ/UKdwYhdLa4vg8oV
	 q3OxvoMPBRkoc7S1kx2YhiMzDoDaryZvmkW3EVnv/p7aLhiQibuw8yjzULrDmxhaov
	 1lYhC0wn9NKvcTH5PsnWZzIrCb/1VhOsfCieEjJF42Kll1zb72L6sErstzFNOvK/id
	 4MVtflLqmN0M4xyV+wcujM0ya3hrAV/sFKbS7X/oUqPYMMTKt0zjRZNDeQkIP2Fe0j
	 0Ofm319d6BI1TjkGdrDvsGdl9Fp2DERu4/IinqNJkRG/GPPWVKjmGYvPlU3YC7W0C/
	 7KTo2vPVW80tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57DD280CFE;
	Thu, 29 Oct 2026 20:25:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 402583A7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 262E881021
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dIhP2A0i-pvu for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 20:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 329718100D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793304845;
 b=spJdJGG375sIzNBxUzEHHL8HxsGBBC/zw/ARjGq7fyMVLjX3ImYFls5cice5nqtNt8j0
 mLmnthaMaHoR6c+ZxanBWNjxoEV9QTtgljmHFWCvR74dZf2aKgojzyMpaK/HdCwsY6BXz
 tZYq1eP6+PNqzD4cqBvr9673ORUAp5QYvThjQ/KVd2Ks7SOeYs2McM9FXryEs7a13aRX2
 KkkI4Sm49aRWRSgdPtd10vkhSQVRhEmFwsJbqGjUXleeDjFPE5ySrBAAG9FHdObGcV/Y+
 bzeVAZrxXy89z8n46hc4BAsdYe210pb9WOUtmUtJ68NGqTSstLdqZ7MGciJG5zxixfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793304845;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=YDi2TQgSOFG3l9E9nN1yVF5a3e1U4h0X2bxGxi0BstU=;
 b=KUXFeV0W/4B4GVicG7G0WmiFdpC/DuwsD6LaPMh8XGbNmHq8ZEcZY4hKslwdxc/OsoPl
 hJeouXiynS8Cu06YtE8I7AzAm6JI+wLzXrdWAwyQC4YSwha7nnQZh/PIBmuW9pxgVo7k/
 3gQcTJNN+H+K5amB4b9gb82/fnp8cDLkTKjj3RacJuRHpedF+mH+iSLc3ouY415OcqyEQ
 hKd/0mD0BQj56NM24do5uHXFh0ne6FYxXUT5Tvlvr8Qro9SMoMjy/pg9zlvMIw+xcQwba
 nNUJ2wtLIA4+59sFS8mlsfz7ijZkOgw6zm2o7C8PeI8BNiWheextMRx8B27MXEtI0nQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CbqP3Jg3; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CbqP3Jg3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 329718100D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793304842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDi2TQgSOFG3l9E9nN1yVF5a3e1U4h0X2bxGxi0BstU=;
 b=CbqP3Jg3Tt1UpntIzZbDFUKOSqYPYkworexHh834y64jaVfzbQsg0vluJRlR70noKVkT1i
 y00yxnQoCN4DsF5Dd0v61s4feRjMKW5YxoWKCv9n/I7LUT87cXVsaKTzx1+FlqQJGicQNz
 hY1p6WNN9FNDPoS3ph2BRIBMXvOoq5E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-2Pm3u4_3PEa06SyaLY6X-Q-1; Thu, 29 Oct 2026 16:14:01 -0400
X-MC-Unique: 2Pm3u4_3PEa06SyaLY6X-Q-1
X-Mimecast-MFC-AGG-ID: 2Pm3u4_3PEa06SyaLY6X-Q_1793304840
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5376f1853bfso51527611cf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793304840; x=1793909640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YDi2TQgSOFG3l9E9nN1yVF5a3e1U4h0X2bxGxi0BstU=;
 b=Kg1u6K8/i6tWDicAFC0jV2lbyvRkY6MRb9Lemv2IopSuAMtLTxdz/XWFV6ZsPCQFfB
 b1yohdWmwbZAGBDDotTw5xyGoA4Bk4by3+qE9yMR9GIe5kOSVeXL5ThU/S9lxOYRbn9O
 iv7JYnjEPDhU8XxVz4WTQlLfQpfKiggA4UGrKQ9cYD9vn2Q/MKOJ8tFjVX+qufLQt3v9
 2cJaHgfFyEcrVxjItAbZIO23KisMHAy0UuhL1VV+/oZWe6IhOTLxygtlec0iT+7t9WY3
 NsLgL3UUeHvDwuBb58Qi4J7Elfs/OBElCi+tXSp5CXVRspEiJ66SbcsJTxv1aIzOzRYK
 D7Sw==
X-Gm-Message-State: AFq9FYKN8OqzpsWyqu8Q29lFAdghndMYEfMYtHrXB4/NJyCtIQwydKt5
 9ewaZQwXerMYZtIVsaIH8+6eLoZSBJZ5giiyvBXj9I5eUlTcclGTHrmtYHX19RHoda+fJPTofYm
 jWRtOCkcBj1gJTQusmWhgbB38+EcC/eQztEh6f09qmGclmugQO86ElBp2a7J7qgbmeJpliw==
X-Gm-Gg: AYBFou3FLzITOoGwgRyyQqXh3FJ0m9F6OYei7SdRH+5idQw5oUsmvvDasgKqnuGHwZP
 0VW3vTr32qoHRuWgxVFZ0gHQnXHdim2a/PjJ2R9afl9VFTATslRXeYzP8QrECGOmgH5SRrqqXqO
 fwslNzQpG/+8EBT/rhqyjXbdSjzmMFOvXRmeRpP+iguK2iDbIOoRef6gDefar5Yo93t+kLl2ZLf
 XF5+ATezjhAMH8UgA6TYiWp1HXgWNZoe8kTSTX1BFNI2NCEnkbUFcVuM625T/88SgmWroq8XJY9
 9DVFCooFQeilNEhhfJJgcGoJFim1B4rH1wZuncPNL6noCxUdwrJw/NPXpPRvftolyLihzmgqlVr
 qujOzCcCxllfS2iIXbvq6DkOmPGqiiJ+H/uicFgNDLW4=
X-Received: by 2002:a05:622a:1214:b0:533:8cc0:2e17 with SMTP id
 d75a77b69052e-542b7916d5bmr2403011cf.50.1793304840096; 
 Thu, 29 Oct 2026 13:14:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1214:b0:533:8cc0:2e17 with SMTP id
 d75a77b69052e-542b7916d5bmr2402491cf.50.1793304839576; 
 Thu, 29 Oct 2026 13:13:59 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-542a58b9bf6sm2800121cf.29.2026.10.29.13.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:13:59 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Bastian <bst@pengutronix.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v5 3/3] rsa: load a pkcs11 token key through OSSL_STORE in the
 provider path
Date: Thu, 29 Oct 2026 14:13:43 -0600
Message-ID: <20261029201348.730274-4-ekovsky@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201348.730274-1-ekovsky@redhat.com>
References: <20261029201348.730274-1-ekovsky@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xTtsnvfyFpPqtVbuqQC7uDTUKnhaX_Q11SqROR2obEc_1793304840
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 29 Oct 2026 20:25:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

The OpenSSL Provider API support routes FIT signing-key loading through
OSSL_STORE on OpenSSL >= 3 (USE_PKCS11_PROVIDER), but only for key files:
rsa_pem_get_priv_key() fopen()s the path before OSSL_STORE_open(), so a pkcs11:
token URI fails with -ENOENT. The legacy engine path that handled tokens is
compiled out on OpenSSL >= 3, so FIT signing with a token key silently produces
an unsigned FIT (a configuration signature node with no value or
hashed-strings).

Load a pkcs11: key URI in the provider path directly through OSSL_STORE and the
pkcs11 provider: skip the fopen, append ";type=private" if absent. The PIN
travels in the URI (pin-value=); MKIMAGE_SIGN_PIN is unaffected.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Co-developed-by: Eddie Kovsky <ekovsky@redhat.com>
Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---
 lib/rsa/rsa-sign.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 361ed0647bc6..c39a2a11652f 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -92,6 +92,52 @@ static int rsa_pem_get_pub_key(const char *keydir, const char *name, EVP_PKEY **
 		return -EINVAL;
 
 	*evpp = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	/*
+	 * A pkcs11: token URI is not a file: load it via OSSL_STORE + the pkcs11
+	 * provider instead of fopen (PIN in the URI, pin-value=).
+	 */
+	if (keydir && !strncmp(keydir, "pkcs11:", 7)) {
+		char uri[1200];
+		OSSL_STORE_CTX *p11_store;
+		EVP_PKEY *p11_key = NULL;
+
+		if (strstr(keydir, "type="))
+			snprintf(uri, sizeof(uri), "%s", keydir);
+		else
+			snprintf(uri, sizeof(uri), "%s;type=public", keydir);
+
+		if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+			ERR(1, "OSSL_PROVIDER_try_load(default)");
+		if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+			ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+
+		p11_store = OSSL_STORE_open(uri, NULL, NULL, NULL, NULL);
+		ERR(!p11_store, "OSSL_STORE_open(%s)", uri);
+		while (!OSSL_STORE_eof(p11_store)) {
+			OSSL_STORE_INFO *info = OSSL_STORE_load(p11_store);
+
+			if (!info) {
+				if (OSSL_STORE_error(p11_store))
+					break;
+				continue;
+			}
+			if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PUBKEY)
+				p11_key = OSSL_STORE_INFO_get1_PUBKEY(info);
+			OSSL_STORE_INFO_free(info);
+			if (p11_key)
+				break;
+		}
+		OSSL_STORE_close(p11_store);
+		if (!p11_key) {
+			fprintf(stderr, "No public key found at '%s'\n", uri);
+			return -EPROTO;
+		}
+		*evpp = p11_key;
+		return 0;
+	}
+
+#endif
 	snprintf(path, sizeof(path), "%s/%s.crt", keydir, name);
 	f = fopen(path, "r");
 	if (!f) {
@@ -237,6 +283,52 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 		return -EINVAL;
 
 	*evpp = NULL;
+
+#ifdef USE_PKCS11_PROVIDER
+	/*
+	 * A pkcs11: token URI is not a file: load it via OSSL_STORE + the pkcs11
+	 * provider instead of fopen (PIN in the URI, pin-value=).
+	 */
+	if (keydir && !strncmp(keydir, "pkcs11:", 7)) {
+		char uri[1200];
+		OSSL_STORE_CTX *p11_store;
+		EVP_PKEY *p11_key = NULL;
+
+		if (strstr(keydir, "type="))
+			snprintf(uri, sizeof(uri), "%s", keydir);
+		else
+			snprintf(uri, sizeof(uri), "%s;type=private", keydir);
+
+		if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+			ERR(1, "OSSL_PROVIDER_try_load(default)");
+		if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+			ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+
+		p11_store = OSSL_STORE_open(uri, NULL, NULL, NULL, NULL);
+		ERR(!p11_store, "OSSL_STORE_open(%s)", uri);
+		while (!OSSL_STORE_eof(p11_store)) {
+			OSSL_STORE_INFO *info = OSSL_STORE_load(p11_store);
+
+			if (!info) {
+				if (OSSL_STORE_error(p11_store))
+					break;
+				continue;
+			}
+			if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY)
+				p11_key = OSSL_STORE_INFO_get1_PKEY(info);
+			OSSL_STORE_INFO_free(info);
+			if (p11_key)
+				break;
+		}
+		OSSL_STORE_close(p11_store);
+		if (!p11_key) {
+			fprintf(stderr, "No private key found at '%s'\n", uri);
+			return -EPROTO;
+		}
+		*evpp = p11_key;
+		return 0;
+	}
+#endif
 	if (keydir && name)
 		snprintf(path, sizeof(path), "%s/%s.key", keydir, name);
 	else if (keyfile)
-- 
2.56.0

