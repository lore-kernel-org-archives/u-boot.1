Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C1606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PRMCQcNw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AknzWmNG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1842B80D48;
	Sun, 22 Nov 2026 21:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O0UpH39L18P3; Sun, 22 Nov 2026 21:00:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B8B680CA3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795381233;
	b=jHYWaMs/duXk8bUTZD1Ju/96jL6jSRvCAbt3wy/5DacDKeh9Z0ZYCykFaNIJyiApq6y9
	 J5jpg1Azjuad42g1vvk8b2cvUXl2QcpVtKZ3lzfmUAOL8qryvGSoEydjrvu1RbVizEUyZ
	 lhg/M+bbMiGDU1UghAXgeApk7mc/5sk78Yz0aOP0HrLW/7Mld78WMeFDke/zzQHKmXCyY
	 R+/lNFF4evn705OXOaQiqKCfVFbrZHgsFP46CDLzcT3/djkfJXHsfPfZtNhXm97mbFN33
	 DDwMV5xI+wkHjAag33EFMDiRTNnXPC53uYhHHzZAdTeQ2x9r4EcOZni+hlNufJIo8ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795381233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=t/wRZDs/GDNfC17wFWWRqtDp2PJZJLftEgPvlO7Ddk0=;
	b=NB0lkJIOrLvPOoV6fFnfobyHRUfsJfxebek6Z7R/FvDJcG3N2DXBgHKmZhEt8xSpVJSS
	 IUYcv/Tu6ycmb+t3Q3xvmvFYglz1Vv10ig5+OrIZCmO7xBO4FjglKNhaaS51I4AfKBHgc
	 OYPthflsnajcNaR9dBCowdExmgafQWDo6zI5ap/wZ4E84jQ74mJRTdJrZVTVqccVnCGgE
	 7SeqPRlWKcnrkANI4S/j1rhN9ZhCFYtKinv9Ptx/BWLJSqs0krzmOqregVDLqCHbaCeAq
	 xhcQ94bmOMf8Wq3Hz5ojLB4u56Ito6WqTAP0oPun/gfGVw2z+51fQeGRpFbq9Pu9bVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795381233;
	bh=t/wRZDs/GDNfC17wFWWRqtDp2PJZJLftEgPvlO7Ddk0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=PRMCQcNwduYL8B6eCN7cyIPNqUFrhU7j7TNE+4uu3tebH5qoVwm+G50TD5QTk3UAN
	 yrEvwKAlzrl3R1mLeUGOOxweMacpvNemXG7xVNCSWmo94OC78AWNdxAStrWLQRJtPm
	 LyL4eXbEKk6p57lJzIdlV5qNtOA1LMa+8pO4fE9GQb600DB6gVhRvJwBTFOm49fANx
	 /wC6lW+/osA1Z6BAASIbtfqJLQ8iIeQU/dOp3RTSz1S8DXpdY2vzqi0tzzUP+TOUdM
	 WBj7U/5iHGd+NePSz1HOaNo3Pm8n4yDur2OVpPyV1JP722XlSjCzVkD7yHE06OwvqH
	 l9/+eTDRbnOEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B8B680CA3;
	Sun, 22 Nov 2026 21:00:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A1212465
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 21:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 873DF4058A
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 21:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8f_NvgPURyGR for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 21:00:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E5F740577
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+user890104.freemyipod.org@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AknzWmNG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E5F740577
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 21:00:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96F22601CF;
 Sun, 22 Nov 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 414CC1F000C4;
 Sun, 22 Nov 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795381226;
 bh=t/wRZDs/GDNfC17wFWWRqtDp2PJZJLftEgPvlO7Ddk0=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=AknzWmNGTxzfNgzdsbMTHfEGV1CP+/8ghk4+gzIe8j51vwS136QeqiY/bTpvKnXIy
 2mr2zCCsHI/K68uGliYxygDvwSqAIA18BiSGeXSHRswJZ6DsWi7XyKDFT33ggsIhPf
 aNj297n+3bqN/+7yrtZh1VHMEAP59WO2ieQ2uNsHPtlTz3iEwyXZMGgdxI+QMy5t8Y
 d9Oxpg1RZ1PhxtVZAytNePu8rZXVkqvmQ1ngGhO4mIlbMxNVoK8PH6M0bZtwBYELeA
 lWwT6IBesINCocaCe3jx+fBbDUd5hIMtPt+xEdHk7InjYyaqVgJvbFI79xPOzHzFTL
 CTmOqEcrkKPLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CB9DE4C201;
 Sun, 22 Nov 2026 21:00:22 +0000 (UTC)
From: Vencislav Atanasov via B4 Relay
 <devnull+user890104.freemyipod.org@kernel.org>
Date: Sun, 22 Nov 2026 23:00:11 +0200
Subject: [PATCH v2] doc: Add section about mail providers which modify
 Message-ID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-doc-msgid-v2-1-10c717d50d1f@freemyipod.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywqDMBBFf0Vm3ZSMrQ+68j+Ki2gmOgWNJFYqk
 n9vYrflrg4czj3Ak2Py8MgOcLSxZztHyC8Z9KOaBxKsI0Mu8xIRa6FtLyY/sBb6RoW6FygrVBD
 9xZHhz9l6tj/27+5F/ZoCyRjZr9bt59mGyfvX3VDEybruTCnRdFVjHNG082L11boB2hDCF1SuU
 Oi5AAAA
X-Change-ID: 20261118-doc-msgid-d3e5a451071a
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795381222; l=2176;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=fmz+T9rLiN6nMaBX6pIg1i9TxswslFkT3LQYtgKgKWg=;
 b=01j2RROdROSZSOB7OlwOAvBgkobSvX/JUr1eYqxITXfqDgXWzXisXYEULN2jwEvClf4l7uLuV
 tt3rscQB/JqDp7HkKKw1455sjM5f13wkX8CQMq1m9VjcFUS0zRSCrae
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
X-Endpoint-Received: by B4 Relay for user890104@freemyipod.org/20261004
 with auth_id=1558
X-Original-From: Vencislav Atanasov <user890104@freemyipod.org>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: user890104@freemyipod.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vencislav Atanasov <user890104@freemyipod.org>

A short debugging session revealed that AWS SES completely replaces
the Message-ID header, even though the API is called SendRawEmail.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
Changes in v2:
- Reworded the paragraph
- Used a different link to b4 docs
- Link to v1: https://patch.msgid.link/20261118-doc-msgid-v1-1-1088bf601fb7@freemyipod.org

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/develop/sending_patches.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 99581dc0ba0..027e7be028a 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -184,6 +184,20 @@ General Patch Submission Rules
   cases, you did something wrong if your patch exceeds this limit. Think again
   if you should not split it into separate logical parts.
 
+* If sending patches through your mail server is broken, doesn't work at all or
+  is not possible, consider using `b4's web endpoint <b4-web-endpoint-link_>`_.
+  It will allow you to send patches without using your mail server. A notable
+  example is `Amazon Web Services' Simple E-mail Service (AWS SES)
+  <aws-ses-sendrawemail-message-id-link_>`_. It modifies the Message-ID header
+  and your individual patches don't point back to the cover letter and vice
+  versa.
+
+.. _aws-ses-sendrawemail-message-id-link:
+   https://docs.aws.amazon.com/ses/latest/APIReference/API_SendRawEmail.html#:~:text=Amazon%20SES%20automatically%20applies%20its%20own%20Message%2DID
+
+.. _b4-web-endpoint-link:
+   https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-with-the-web-submission-endpoint
+
 Attributing Code, Copyrights, Signing
 -------------------------------------
 

---
base-commit: 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c
change-id: 20261118-doc-msgid-d3e5a451071a

Best regards,
--  
Vencislav Atanasov <user890104@freemyipod.org>


