Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415A606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s8VCkBH7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUG58fJu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 231E8606E7;
	Tue,  3 Nov 2026 20:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TTNw2peH9aUr; Tue,  3 Nov 2026 20:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5485B6069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793739232;
	b=s+e5ttwmkVFoKW9LiBm1GebP4jZ/bHEiYpXjB9go8aWlprCToiqeY8kUK7hipWXgdr0C
	 wcpl7HFnHsLrsLJ/jFNYCwSSUKI1RkomW9zp02RajT7xTgwmCOVUvby+PX2ZRAqhhSO5Z
	 HvejEwf6dBPpoAUStjKfDdmrl7Qb9H07lboCnvKaFUAjQKsSR41n1XVro1jPxyPKbHMvl
	 tBedmD/KOh7PsuQ3ctqaVhtKn0Aq/c23D/z0ouszErza5N4hDyphtlm2ftShmV2yO7H0k
	 9/akKAw50t12ZB8eEKe8O481WiupMnRDbPBdXdCpMNnUDSNYLiFEIECQYxaZau49MzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793739232;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bvxzxtNw06NeZPFmpi2HNGGF58H8YaLRGWfQfW2skcU=;
	b=XdhHfWmfRQyHf7UAxvS6rfM5bDOK46LWggRV9h06qFEU9p6JAjP1/1ZgkwS4TeCsUI/2
	 AvMdbhvVK9n95FoI2NXu3o+0N23Eu5Bzp5bC03wUeiyzo9LUfkt+/sxK59QJ1wrpPtkln
	 fnOkAO44PvsUS1TuiTmO530voQ8Fui7RDtCiwzrLNSRCg5RRNwbVxHivqlhQNYeqt4WDP
	 tJnPiPHxSxospZrogMfPTpHCbF5ik8iQhyV78bgsV6YMH/B+Lhh5rDpkl34Y1jJwGTa7d
	 sxNBsChG5JiktWrQiJPF/nj5QYoVxxuXJ+7kIxiatKWhfVgiiD3uQXo993d6ro0UcLA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793739232;
	bh=bvxzxtNw06NeZPFmpi2HNGGF58H8YaLRGWfQfW2skcU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s8VCkBH77vgPTFHCVAKsZZ/xTaC16G79ae2A4ntDmV64CT/++nCbm4frK42xYAoij
	 QvjF06Zl00paei10zvCv/n/Vk5k/QP9QKO8PmmMTap4C8ukGw0Kzq9bW3Q5GUo5jMT
	 UlCns/j48xDq4hwuwEnL+Uk/cbAUYmESi5H0Sq0LRDI1ad89M/eyu3sWzDM4+E9u2P
	 CyENeKNe4tNJPcwoJl+JnZY1aMfwvjlxrHu6/kutan7mUETicVjjUNeQTm2yvJwdGS
	 W5tsJBxFrRHHbg/Gx8jQGIADNtXXZhDrA62k3op0m1PR/s3QAQdqGEPL9CuyLhQh9z
	 xP5NUfWv8PkWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5485B6069F;
	Tue,  3 Nov 2026 20:53:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08E78A10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 20:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE56B4009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 20:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNUtOw8lRSaR for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 20:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 486E740062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::730"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793736996;
 b=ALqswxQylzOlgh40g+LQCe9s8XSx4EddZ2oVzW09zTjlg6aGSMOP7jYnWi5I8tuC1JW9
 ow6hSSX75S04TMGSa4bsG4YL33S+PtKZUp4Erza5yWPJ+6w2M78iJXKuXLUCoX/imPuo6
 wG5oTaE8Luq5aMS1Nmqw2pWXFImM9xcoj70ltQFYhz8p6VpMErgPY0fPmWvx3GmjTNq8R
 4IUtkQgOFQuGYT8YiCMNRgorPKx90d8nX4Ube56x+xEOsrZTQo23RFAD7vFQse8A/WhkL
 4dVdKMzOe3YbDP3Ss29YCpATV7pC1+NB93AWG+6Rh5owsr8GcMRFl0ONQRnnECrB54A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793736996;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=bvxzxtNw06NeZPFmpi2HNGGF58H8YaLRGWfQfW2skcU=;
 b=WS07DuKQynWRGB1/yeiOHlVcfvHTxGRDRDHdhqLskp5vdfVAJLOIsoBYb15CZgmHpoQf
 T20rcf/wfc+/u9088dvtBCVs44rTgewj9kjje2BAjZ6ZVkN6HGr/jgrCv4bR/a5i+Y4PT
 auKll0Rv+yaTcQNl8G8kt96W+a2yzE6jxYGmeeT2b+U3ulP7chdztNzLCrokF1IVKqdiV
 8OURnJJE4qAMUx5leGGj6jGXTF9f6F2aR10+tdgT8KKYxT9B478Cy4uOLPyqhXbETlp5w
 L9I6MJDB4w4uqt58xNFSkPj9E8JAxtLusmIl7Ht3bM6KLbUa91U44SmFRDOpySW4vvA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dUG58fJu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::730"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=dUG58fJu
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 486E740062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 20:16:35 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-93f3c89594cso1540285a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793736995; x=1794341795;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bvxzxtNw06NeZPFmpi2HNGGF58H8YaLRGWfQfW2skcU=;
 b=dUG58fJumD7itzwY35SOw585/DcuBsLnfvkajjplbYyxdmrf66LcaL9mkXaQzCWsel
 1/k5Hr1z/JgueVltH9DI3Kq2lzkf+JXy/30YwaNbJEI/W2VKZ7unrGj2720d4BaqIvCL
 ZI+U1OD8T+vs7roBhHdESQ89qVeHdKIHtVPsaBVvFfHMxvIGBxSVYr+hh/F2pUJKW4ZI
 UhEzHJ3LqMh5TL9MvEb/E8a44exswJ6NgAw93uzsMTK3X/d/Tt7cEVEh6t0wqfFmDcun
 5EIu9DynoTesh7NJENBO4QR62h9uYPMRRHCwLhesHuoTFUQtjqY8aRT5Z4WBZseQVmO4
 sgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793736995; x=1794341795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvxzxtNw06NeZPFmpi2HNGGF58H8YaLRGWfQfW2skcU=;
 b=PiSusWiAEk1kAfsJi2sWxB8S9VbmMX3z1ZQf3YHfrtJ3rSPg1UJYPNmdVWRL3cIkal
 3qHQwJSLZWUX54T1ux6XcslE3rxDksxlZCJnIM29XOAaJJUVvLTFuXIH1moBgpvuCQH+
 4SkHOFZr9tVj9F/3kiOr2z78Ae8eAvFOmK0npGHh3vaSpqXqVMlj36myH77P+Z0wFLRN
 rL6iWLUgAFJfoZFyT62r1hLzo5+UodLR+w0I9gN1Ms4MpoRSgO7BWRJQ4QQ5rGiZVaPl
 hi5C01i2iTPhyqrixF9gfeJVtZhoX9JwPsoaw4rBKy3ADk9Ymrlb8zYdAslVnCGERiFM
 vfew==
X-Forwarded-Encrypted: i=1;
 AKwUvByZqtn7TMQ3aTaeejVsEPSVAp9lB20wY1esn7CYYWA5al5X/ih65aFFU4Qkko8ERc0CuIkvObc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Un9QQBvLgIFfrIq4aJHKC47bPq+feplsu5CqQlx/N5Xh4Cqe6
 zaVVP+JQv9Okx/aR5c/qS8KFLHJ1pq+99MLJkmAu0f7d241EEzOSnq3P
X-Gm-Gg: AYBFou3leOGRFQZrsabmi0hING/yqraZvNrm9vYC333e/dCzL///5oYqsavvuIwbJic
 eXQv3PQW7D1T4hNlZWIUkZMF53OzsmX4/59EaYtgYh1zSmrvi8KiuUWBK+xkbE1DYo8ileih1GR
 sgLBvuhPSLxKEktW1S9OkmtRnuzgqD6lqLlMtLV6Ym+lXOsAEYb3xkn5QdOewSBlbmlxn0Fgt2w
 xmTl3PTDiirKMXGiokZsd9+QsIXgXWgTlct6rAFgR0o10/2e46tStKKqF+1tvRT4+yd4QssstXf
 1btJhjqQogK30M9hMVO0VloGYCiDw/yA6VZMJBsD2/RUvhxl4ikVcMwnD3q6oxN9Cnkw06PGKtU
 jb6R+gs/gXyTP/C/3Aeq9PMjxW/YTkiVmZPMyuprTy3+ha5jScHZiWK7vB9WeV1WhimLZr1Tnju
 ecfp0tqpVW2/R3O9PX+al41vE9aTNIMJlvCD9QHLOFYNUDcg9fo8Jo9rYTCrpMygpucOceOWnFx
 3SySPKdoBFGbx2gEP/5cUGzfXd9i/+NVyqaZtZsKCARPxxEhCQ+qBZahBTa9KUTwMEvKAj4n3TC
 PrDLqpstFPVXsbxtJfAtt18urkbpbfcLOfq/0eVyFQoSMkhoagNi
X-Received: by 2002:a05:620a:400c:b0:944:16e7:15c1 with SMTP id
 af79cd13be357-94421659b79mr2385930185a.19.1793736994662; 
 Tue, 03 Nov 2026 12:16:34 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d4844be4sm18338085a.29.2026.11.03.12.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:16:34 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] efi_loader: fix image and load_options leak on FDT load
 failure
Date: Tue,  3 Nov 2026 15:16:26 -0500
Message-ID: <20261103201629.1259174-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 20:53:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When efi_bootmgr_run() attempts to load an FDT specified in the active
Boot#### option on non-ACPI platforms, load_fdt_from_load_option() may
fail (e.g. if the file is missing or unreadable).

In this failure path, efi_bootmgr_run() returns the error code immediately,
skipping the cleanup code at the end of the function. This leaks the loaded
image handle, allocated memory pages, loaded image protocol, and the
malloc'd load_options buffer.

Fix this by jumping to the cleanup label 'out' so that efi_unload_image()
and free(load_options) are called before returning.

Fixes: 39bac24a48bb ("efi_loader: load device-tree specified in boot option")
Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- Correct the abbreviated SHA in the Fixes tag (Carlo, Ilias)
- Collect Reviewed-by tags
- No code change; rebased on current master

 lib/efi_loader/efi_bootmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 6b5dad21b06..536b58f95e8 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1323,7 +1323,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		if (!fdt) {
 			ret = load_fdt_from_load_option(&fdt_lo);
 			if (ret != EFI_SUCCESS)
-				return ret;
+				goto out;
 			if (fdt_lo)
 				fdt = fdt_lo;
 		}
@@ -1339,6 +1339,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	 */
 	ret = efi_install_fdt(fdt);
 
+out:
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
 		free(fdt_lo);
 		if (fdt_distro)
-- 
2.43.0

