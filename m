Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E02606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=taDleKLq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpsbyhX3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D5D860A7B;
	Wed, 18 Nov 2026 15:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2iA_kb2NndSY; Wed, 18 Nov 2026 15:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 566F760A8C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016804;
	b=SSfwLZRz7F1xv+UMZPmFcWlyT/2CtGByF04vuYkMwDiPHl8VKd/F662R3xSvZrNcZcll
	 p9nSvxmAqRfFFbBkrWtn/4jlzojASGHrFWxe4K/4fvynSnx6l9x7ISruSmLsM8izHN3gu
	 EYnHgzNjgtlTbpnjCF1oweE/MIn4cS8jnpnDn4WgOb6DQJ6kfYzcmaEgGF5ZxhYjyvV04
	 vgNX+hOQoc8kMkDg8+kgP6LQ73IapHevPf/RkR6AYQmS0j1NSWdLLjAXSfPiiBAvGsOkv
	 Dcjq1Di51WBTWaxaThKNZJ5K4gqr/8TWMq/+mXX5LKVMgM1woBzBg4nqAGnW5b+eUIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=2yCoin9IL2BYmB4KDxd9bou8Z+6BmRw8iS+MMdgDQ6U=;
	b=DR9Pf809tuwbqRX6plHKO/8LuXtbJfZ5dS+Kg4RohpFuLAXb9nt4UT4ImZPHfihqiqSW
	 tg4hEWRPah72XM7lcPEI1BNyVeZQRQXDQV3b6h4AaKxUmn4CJ+BjoeeIym6epoaV/MdvK
	 KTtWCgmJ/QWPtW53h3OAVpluURz1OlW/BXwN68TLMFHZn+lLQLh4mGU7OSsKPOmr7XL0H
	 iPVIlJCoAwrUMClZBHlVCPE6ey+ym7bY/wpoiOGJKWeDNIzdRAGeKmBa9GzgXQtUUZWlf
	 cOLaRb1dSEwxVreCtqeoiFSYvY/ArNjxRnFt7b9vYKl/WU8Y01uDK8zFT+th5UOMpWA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpsbyhX3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016804;
	bh=2yCoin9IL2BYmB4KDxd9bou8Z+6BmRw8iS+MMdgDQ6U=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=taDleKLqFm6taCgq8tBEqxJJCTnOcBJ0GWNdrufGIvCvgplV/DbWSxHgXgNik9QgX
	 6xJdDNbjfRAMbS9mrwfuqkEgXFSTmfBZbaM+DQI+Ray3hLPTJHyb36f47PdOtzJxFh
	 sDLVGLA6+x4gxDUcOcGzB1KUFrR6xQKsUBxfMNe89ktO9YzsTkEeY0+GUzYrhSgNGD
	 0JeYYkkrGEdWmnWvj3kcLtipT9mfy/KWLBYnq3vVLtfSw/+uOAo9yaSrQpWrC2CU39
	 sw3YEJzhb8XKre0nbo7F8OHAc6ijdmqUYEv3E3iJtLi/sBW16RFnmNk9Du40n5svU+
	 vdoplvyuO7TyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 566F760A8C;
	Wed, 18 Nov 2026 15:46:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C2B0977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A09960A8C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:46:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iGC9VcNTwri for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:46:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D80260A67
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+user890104.freemyipod.org@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CpsbyhX3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D80260A67
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:46:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE07245B72;
 Wed, 18 Nov 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 047181F000C5;
 Wed, 18 Nov 2026 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016800;
 bh=2yCoin9IL2BYmB4KDxd9bou8Z+6BmRw8iS+MMdgDQ6U=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=CpsbyhX37kb/z9WuBLVnfXDVI8zZwZAgk69cDPYs5UPurOrbmCrkUmW2sfzg0rHOV
 sdrboDcK1C4HnG2KtK5zavT7drVQBqx3NYKlunRpIvjnuRP0ZCacr7G90KmTlQEHzw
 Jeox/Rw+S0CBUVZ2V/QCiRGHiFCpJ9WskAAZ/QsbUGQ0itWYZPq71/nAm6y9Xl2Zwz
 eUFJcVtBwsShOlVRqjElZ37E5Clc3sLuCgUTiO7cUznd2dzOM9W1Ay1fo94k9fyeqy
 bU54T4i67znYhy6JbZJB+/karVtj0kZ3VcAsX5mEWnpMQeDwsLJtCS3sEtTW1RJ6MD
 DnjKFq9huUFDQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5B2544AE17;
 Wed, 18 Nov 2026 15:46:39 +0000 (UTC)
From: Vencislav Atanasov via B4 Relay
 <devnull+user890104.freemyipod.org@kernel.org>
Date: Wed, 18 Nov 2026 17:46:20 +0200
Subject: [PATCH] doc: Add section about mail providers which modify Message-ID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-doc-msgid-v1-1-1088bf601fb7@freemyipod.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM2wpAQBCA4VfRXNsyznkVuVi7g1EO7SAl725x+
 dXff4GQYxKoggscHSy8zB4YBmAGPfek2HpDHMU5IpbKLkZN0rNVNqFMpxlGBWrw/eqo4/N71c1
 v2duRzPYO4L4fLFu1aW0AAAA=
X-Change-ID: 20261118-doc-msgid-d3e5a451071a
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795016798; l=1716;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=twFzVjuC/wrq/GFDc43jLfsEY6afcqFJXJ+Jjg8YETc=;
 b=0qXI3Mv1XCkPtsIXJGfDGslrjtxpJjqIc19EtmM0jT1AfHfT1rAkoupZr+Y3530gP97m7pvid
 oVeSvUCjdGgCVO7a3oTivotp1bNfdWa83f4tdpBmBD5idoy5EYh8ql7
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vencislav Atanasov <user890104@freemyipod.org>

A short debugging session revealed that AWS SES completely replaces
the Message-ID header, even though the API is called SendRawEmail.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 doc/develop/sending_patches.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 99581dc0ba0..e2d5e4b15c2 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -184,6 +184,19 @@ General Patch Submission Rules
   cases, you did something wrong if your patch exceeds this limit. Think again
   if you should not split it into separate logical parts.
 
+* If you use a mail service which modifies the Message-ID header, your
+  individual patches won't point back to the cover letter and vice versa. A
+  notable example is `Amazon Web Services' Simple E-mail Service (AWS SES)
+  <aws-ses-sendrawemail-message-id-link_>`_.
+  In this case, you can use the Web endpoint of kernel.org's B4 Relay. See the
+  `b4 documentation <b4-web-endpoint-link_>`_ for setup and usage instructions.
+
+.. _aws-ses-sendrawemail-message-id-link:
+   https://docs.aws.amazon.com/ses/latest/APIReference/API_SendRawEmail.html#:~:text=Amazon%20SES%20automatically%20applies%20its%20own%20Message%2DID
+
+.. _b4-web-endpoint-link:
+   https://b4.docs.kernel.org/en/latest/contributor/send.html#configuring-the-web-endpoint
+
 Attributing Code, Copyrights, Signing
 -------------------------------------
 

---
base-commit: 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c
change-id: 20261118-doc-msgid-d3e5a451071a

Best regards,
--  
Vencislav Atanasov <user890104@freemyipod.org>


