Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E8606A31E
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=at4iKVhw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0554D81181;
	Sat, 31 Oct 2026 11:10:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdgVtxodvDRY; Sat, 31 Oct 2026 11:10:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A49081166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445050;
	b=TyxVR0Ti2rlBfZt0D5W1eq73vMvWgus1YBmyLvO/P8MIaNOQSC0qeulZXxqD4mtG+NtH
	 ES0xtVWtW6vNEvbnaPgnhcOHxh2KX7CmMulxg1ZFi+7JxoVdgVhXl1FxcK77BRBvh/X5c
	 aIL43SMKZWdbSYU6zttEM3So0s/fsj1FMTIkXCblGrc9HweSunJ/CyIUWlSWxdwZnWIOc
	 bKXoeePf192EAxH979oYr9VWXhmB2pWHZmGhIbK8id3cSTEjKR6U0gf58MTcyACPZnzXI
	 e5/43bn7f5GPZWcl2FJWB0Mns3BN1BjiqnfO1uzrEfstsKzy365a7IXNEx34gflWS+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aZxKEy1QJiSQg2zDYNrG09UjghMfdkMhWTQtntYGIWI=;
	b=ERCChBoyPrPFNkN+8V+tUd0UtLdyUeIqzj5/pwdjImtgg4MqPYrWNHa8SuP5wFlbMlQg
	 Y5R9hp11e8JX6yLUkV8CmNzfJJRFp0839fDu9fE1cUSJWy5vxckSqjvLrrcN0O+XddE5A
	 vYR3srggy5PyV31/9oIFkhTvYc9HPWnoZLwq3w5qhvlg0H+xt/1y+ei9JVg5GGyFWfvz6
	 nRKb+7+vlfdufpSm/s5gRqD0BhVqJr2yocYaZu4nlVUbYLG67relfcM1fPQCYj+Kt2sf+
	 iHwEYRfmZxMa0oH1aNQAtSBifZiNioT55uJKJmYdTpimlncmQEO7t8pSgGWTrpP4/nQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445050;
	bh=aZxKEy1QJiSQg2zDYNrG09UjghMfdkMhWTQtntYGIWI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=at4iKVhwpFQB5D5CkojtM/zTZtC5lOaNRIKL6twuznliNB5eGx/HVJN1jmfBZoGBN
	 rGN7UAja7IRdLNEFbLttE3dbIi++O+ka4uulMnncKf8UUf+TdFaCJrN+H4tXR/PBCB
	 jX2HH6+JlUxRznkZzxCpjoiWfwUbx4l4higa9LoZ7IHqI0hR0uU83NcflANuKjM59Z
	 hOj6B9jYznplzdKY1nydJJLGarv3qSQFO3+Km2qKWEg25uNFD/VxEWSww31AopBU8U
	 DCQXnqe9XgwwDbqs4h0KR4whxmTUGnWhCnwCikuC1ATJqZCrcWTV6yjlmANsEdNJK+
	 20MuHgUxxlgzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A49081166;
	Sat, 31 Oct 2026 11:10:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9066473
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB6AD60648
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFuyvBuPBOJe for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:10:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FAF560633
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445048;
 b=BkH9NoIuYFNn21Vr8Splun+dhUN7DBM59iYnEysGFOxTnbay+zY3HtNsjRl59JhpWMa/
 ABsJCrhbz+UoKdeByoqIW+V9iMlliKuf08QKDc5nvGgt+HB5b3O7caoWxY+0Qm3rkQI/c
 +B/5ueawHn74jGIS4+RhygUnPBWHSAcjTHGhgyy2CEYYb3goT2iX+orH/4ufooQJNmJUM
 vXxv7u0Lhjpw9nd1gsXLAgWwhjQcuak/9c6yhKQxWEaDufOiqkV9lLMuJZcDGpRD0GvvH
 Voz2SvQprHc129s8p70GNNc/qheByCWX4w4R1yFo9OR/B3FGiTeHpyl/3uk4cOQwF1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445048;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=aZxKEy1QJiSQg2zDYNrG09UjghMfdkMhWTQtntYGIWI=;
 b=nAEz7zadctPcdUqUF8V/oe3qK2tzMOTBCEF0U68LcSTxZ6ReuT7ZSZVVs//CrdsDyTRY
 VZ6FYJENPs/0QfI7SiRcMC7xw7NlZ4ymPGa+pj8/qgpLIg9ekyGLAhJvon+VbVOLvzPDM
 N/808HqdPBXlWb0Io1MUMMLQmrslCKCrra7HWAN4KwvdqQFYsiIXq91fiDGnUK5pRDENR
 BVaZkUdLyD0hwyHf0tLS9Oa3nckieeiPlyi7tAvQuNH7N53T7Uhj8ZOa5R5N8RqAV/xuX
 YcHCKGw35V8BiDyuyud38LPdau4v1BLc+iHi8jlB8QQISpD7F3Hj34ie08mrULDWPGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FAF560633
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:46 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6vp-000000003Nc-407M;
 Sat, 31 Oct 2026 11:10:43 +0000
Date: Sat, 31 Oct 2026 11:10:41 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 04/11] test: boot: imagemap: declare locals at the top
Message-ID: <b948cad1bc4986254913bbd87204f1d0fc90773d.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two tests declare variables away from the top of the function body: the
extend test wraps its last assertions in an anonymous block to scope p3
and p2_end, and the out-of-bounds test declares dst after a statement.
Neither shape is used elsewhere in U-Boot.

Hoist all four to the declaration block.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v1.
v2: No changes since v1.

 test/boot/imagemap.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index de00a174470..c7289db3995 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -231,7 +231,8 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 	struct imagemap_priv *priv;
 	struct mock_priv *mock;
 	u8 image[IMAGE_SIZE];
-	void *p1, *p2;
+	void *p1, *p2, *p3;
+	ulong p2_end;
 
 	for (int i = 0; i < IMAGE_SIZE; i++)
 		image[i] = (u8)(i & 0xff);
@@ -264,17 +265,15 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 	 * With LMB allocation this cannot happen because each allocation
 	 * reserves distinct memory.
 	 */
-	{
-		void *p3 = imagemap_map(dev, 256, 128);
-		ulong p2_end = map_to_sysmem(p2) + 256;
-
-		ut_assert(!IS_ERR(p3));
-		ut_asserteq(2, priv->regions.count);
-		/* New region must not overlap the extended first region */
-		ut_assert(map_to_sysmem(p3) >= p2_end ||
-			  map_to_sysmem(p3) + 128 <= map_to_sysmem(p2));
-		ut_asserteq_mem(image + 256, p3, 128);
-	}
+	p3 = imagemap_map(dev, 256, 128);
+	p2_end = map_to_sysmem(p2) + 256;
+
+	ut_assert(!IS_ERR(p3));
+	ut_asserteq(2, priv->regions.count);
+	/* New region must not overlap the extended first region */
+	ut_assert(map_to_sysmem(p3) >= p2_end ||
+		  map_to_sysmem(p3) + 128 <= map_to_sysmem(p2));
+	ut_asserteq_mem(image + 256, p3, 128);
 
 	imagemap_cleanup(dev);
 
@@ -455,6 +454,7 @@ static int imagemap_test_read_oob(struct unit_test_state *uts)
 {
 	struct udevice *dev;
 	u8 image[IMAGE_SIZE];
+	u8 dst[64];
 	void *p;
 
 	ut_assertok(create_mock_loader(image, IMAGE_SIZE, &dev));
@@ -464,8 +464,6 @@ static int imagemap_test_read_oob(struct unit_test_state *uts)
 	ut_assert(IS_ERR(p));
 
 	/* map_to should also fail */
-	u8 dst[64];
-
 	p = imagemap_map_to(dev, IMAGE_SIZE - 32, 64, dst);
 	ut_assert(IS_ERR(p));
 
-- 
2.56.0
