Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C11606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xI7epbAu;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=rmAvzFel
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97AC4608D7;
	Sat,  7 Nov 2026 05:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6QWE836gjGg; Sat,  7 Nov 2026 05:46:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84717608CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794030409;
	b=JxUBCTa/zT5vZmh7Nu5TOaiP+ARGZR9cojdry9se0k0T+g6LTUCdQXioQf4D5ZqaTPwf
	 OvCLQ/N5fEXjPGF79pmiyDvxXQCfr5Ka+ZP6L9SaHKg1oSSyYL1xqhfPzrAHwEDtG1RQ7
	 o4sGanEtCDqR6SlQt/XQzCVoqn6nw7YZD3IfRd74gEKcUyqmj2/nc6dscMu6a56Fn1nsh
	 BlAQhud/VR6JlCaHkOqkEibWwrirO+ig4A5nw+QqK91FT2hOu2jgwTsONnnwiX/JodU0F
	 hLU7ajH0yDiYMH7X9tn1JqQJ7PujA6Nhse6/F1Rap7Hvn4hAXmWr6DBdufzCCtf4brQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794030409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+XLfOqr6Zfg4tl/ZVeCKwG0u76Gh7btm8/T5oQQwLFU=;
	b=KnFbozO8ygy6efl7xtSB/R84A+yIdgMvetlr5AbsIH1Cv3mLzJ9uyw2ShtZG2TkFDL2X
	 dV/U2ZoqhxSvn4YFIjiobQNRvPMAZ1cm/SBISP0gJitEjIMdNNr/n7pO3dgbhuBLxfcQB
	 IVP1Pt50kNxBQ1uXXOpJvVo4tVb0TaJ58GH6Jvcde7yUac/cgYyq+e8lB2o3qJ6UEqMcW
	 TcDMV2/bj0FbFtuOdBCcZ/sLAMYCKdLlDRYB8RzKP1yvET464R3TspeBqvLU/2LnZbS68
	 B20Dan9eC6YjMqQruF4AaBDkMrd0OXebuekuecxuvrdvP8uPy/EOflp+4vCyFWYapiQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794030409;
	bh=+XLfOqr6Zfg4tl/ZVeCKwG0u76Gh7btm8/T5oQQwLFU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xI7epbAuqvJK91Q71Be6kGx9zqT7I+UwJpWJBGlIakzBVIwA9RRcnFRTn+68Y8rB/
	 2RttdpguZY0nTyad1a6seoCoYlfcrHuQIBYSGqfj7r/eesPQobkFmVZizOD1AfS+jQ
	 XEK6OUjBZhpMrwJTD+UA5Z1JtXDGesdaP/FubBBRbLW0zTR+sCpSQaf3w4SBxeLxuZ
	 Pas740vHfg3gzTuic7YBCGSJNo8ajKvgEK//dOpCZe/wZTMTTjsURx7yk4hmSCQkPN
	 ggmwmUm+k8LMrHqYYgUZ2qp3CS9KPVUKNwOrsY12lcBVRS/i0627WUSFrb1zXYtRBl
	 Y6q4CauR2CMNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84717608CE;
	Sat,  7 Nov 2026 05:46:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 610131C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46B9E40870
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4y05xggoULYb for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 05:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A71540824
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:64:8a00::1000:9ad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:64:8a00::1000:9ad; helo=mxc-2-9ad.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=rmAvzFel
Received: from mxc-2-9ad.seznam.cz (mxc-2-9ad.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:9ad])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A71540824
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:46:45 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxc-59f7fd7d85-mvz87
 (smtpc-mxc-59f7fd7d85-mvz87 [2a02:598:64:8a00::1000:9ad])
 id 572c22a5a9d8900f57a2acbd; Sat, 07 Nov 2026 06:46:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1794030401; bh=+XLfOqr6Zfg4tl/ZVeCKwG0u76Gh7btm8/T5oQQwLFU=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=rmAvzFel4h1BiEAaq13RW0UOGFm/ZtzJoNnFlMV9jaJBcGk7xekkCsIqTdk9WsbPE
 95TfpLTOb9TwcvRnmABOwL8bLQyos10UdiQaBAkJ0kThQh1UWjQ7h4DlBXyT73j2Fb
 LxfG2/v4ryRMUuLuAmawTqZhQX30LhyAsRfVR4Jpzue8OSASxorbDV0oPloQK6G8yb
 Jesmeu50N/uz3cxRZM/eGFTYzhsuUBo+XGJGlnElxFEiIoss+mKHYD/0BkOVsq+EnR
 UlSmNtPgqIdQ2pWXw5YdFIEewRPGQDDC6rsGXpUiqNcv48Uy90l2726V+emCJ7r7E8
 zJCDdxT3oLtVQ==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Sat, 07 Nov 2026 06:46:35 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: "Abdellatif El Khlifi" <abdellatif.elkhlifi@arm.com>,
 "Tom Rini" <trini@konsulko.com>, "Alexey Charkov" <alchark@flipper.net>
Subject: [PATCH] test: lib: uuid: Skip v5 UUID tests if SHA1 is disabled 
Date: Sat, 07 Nov 2026 06:46:35 +0100 (CET)
Message-Id: <x5.ZqLK.4Vgk35A04mS.1gxhix@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

The v5 UUIDs are based on SHA1, so gen_v5_guid() cannot be used if
SHA1 is disabled. Skip the v5 part of lib_test_uuid_bits and the
whole lib_test_dynamic_uuid test in that case, so that the tests do
not prevent building without SHA1.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 test/lib/uuid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index f958897dd7b..5ae8a30b8a7 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -65,6 +65,10 @@ static int lib_test_uuid_bits(struct unit_test_state *u=
ts)
 		/* variant 1 */
 		ut_assert((uuid[8] & UUID_VARIANT_MASK) =3D=3D (UUID_VARIANT << UUID_VA=
RIANT_SHIFT));
 
+		/* v5 UUIDs are based on SHA1 */
+		if (!CONFIG_IS_ENABLED(SHA1))
+			continue;
+
 		/* Test v5, use the v4 UUID as the namespace */
 		gen_v5_guid((struct uuid *)uuid,
 			    &guid, "test", 4, NULL);
@@ -170,6 +174,10 @@ static int lib_test_dynamic_uuid(struct unit_test_sta=
te *uts)
 		},
 	};
 
+	/* dynamic UUIDs are v5 UUIDs based on SHA1 */
+	if (!CONFIG_IS_ENABLED(SHA1))
+		return -EAGAIN;
+
 	for (i =3D 0; i < ARRAY_SIZE(test_data); i++) {
 		ret =3D lib_test_dynamic_uuid_case(uts, &test_data[i]);
 		if (ret)
-- 
2.43.0
