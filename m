Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E9606A88C
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IAMnhty7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2856540EB0;
	Sat, 14 Nov 2026 00:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPOdMVH0uo3G; Sat, 14 Nov 2026 00:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57D2A40EB2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615354;
	b=kQrVwMMJ9XKxOiGLJp2jC0yrzxOtpt+EHxtqv6JTgQryV8fbgA4kPrhpoqN41qp0HOFD
	 bhKwYwkecHYGzE08fISYeRadQmzaK0zDXKthDJOKUSUESQmQUrhsjJAe4e0Z/GBVijP1t
	 dtYAFt1GwAxY2onxTlfJHIvuf1ct/6AexRb3V261m6fJyT5onQnHxbSzt1K7IIFFD2VlM
	 sKxwtlxv2Gu/zf60VsaQoTq9YXzplxz8DxBmO10lQFMIMYl7lUklwp75mhuWcwItk55yt
	 02wkN+3RvoEg5H4leatWO/hu8aK5r8KXQa/3qiSfWv+x9Cmxm4xk3HavDkWn3eahvoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BlrAg0Ymh4laPoDIg+Pr2/5AQQ3hIoRIn7aeQqJqrLo=;
	b=czpdCweBdC0E1IIbrnDPBTUOb7iVjPcWBfdOXwPd6gkTTj4+vWOdc/TBBdaBYZEiJ/kf
	 6uqDT8SltdXLy5cVBJwTIBSSo7EbM2Y74rKGiwG6LN0z+WCgg54HzDdlH6e4Q04jt1yYX
	 1gb0w8dtuiWb7L3DKAb/Nt/+uFF4OCMv3jMqZ/bOhhn/361toMVpV8KLgkeJ7ERfzdYqb
	 VTV8KvaU9GoAsFs5WIBTWCX0W8py5vFqNvmZPTN5ESRLEe7hivd00BYHmRFhLdmsP1En8
	 fiAs66CESj6oAW0Ph3wrYOPr340kg3vr+RVGIY9DFRAbcpmN/iV85jE5oFtDZxhTgYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615354;
	bh=BlrAg0Ymh4laPoDIg+Pr2/5AQQ3hIoRIn7aeQqJqrLo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IAMnhty7dpCCUs2JFJoJ9sZ2fENJvzDw9fTcQzadQKnNm/18acEuAuG+NG2NrQtRk
	 TNi4EMw/BNjMb7q9sCfQ3pDFtZ7ZmvMh+OgYKt/PUa/6cFwB4W4nhbchUWYTgNbJ/i
	 es/b0qwcOWhmAuvVCAi6QIDY5G2GUNKHYaIWj6xMWYlNLSn4qwgfIegwcwJ+Fnra5v
	 f/DzdCSKDrx/0JmG05PQsa99/Jmr1z8lLnFqCCTXD8saxt1x3pStM542gLAkuT/MmB
	 VvJayYjeP4xLDdVaJF9JzRw8L9xHFnAtL0FdKqSt3bRpc5xmS19PdZoEd0n4+iXpXN
	 TToMGrXta30Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57D2A40EB2;
	Sat, 14 Nov 2026 00:15:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DBD6F260
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C24B140269
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQBRJk-LzSaC for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 128BB4025F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 128BB4025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:15:51 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1Ql-0000000009O-0apK;
 Sat, 14 Nov 2026 00:15:43 +0000
Date: Sat, 14 Nov 2026 00:15:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 9/9] boot: imagemap: Copy cached data when moving a region
Message-ID: <d359e598a8be0fd0900b347e0dd65a34d7f1a801.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Moving a region while extending it reads the cached data from storage
again. Copy the existing data into the new allocation and read only the
added range, and include a sandbox unit test covering all of that.

Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c      |  4 +++-
 test/boot/imagemap.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index 8455763815e..32ea2682895 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -265,7 +265,9 @@ static void *imagemap_extend(struct imagemap_priv *priv,
 	}
 	base = map_sysmem(addr, alloc_size);
 
-	ret = spl_load_region(&priv->info, img_offset, size, base);
+	memcpy(base, r->ram, r->size);
+	ret = spl_load_region(&priv->info, r->img_offset + r->size,
+			      read_size - r->size, (char *)base + r->size);
 	if (ret < 0) {
 		lmb_free(addr, alloc_size, LMB_NONE);
 		goto err_read;
diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index 05bba8776d7..682f6d5542b 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -250,6 +250,8 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 	p2 = imagemap_map(dev, 0, 256);
 	ut_assert(!IS_ERR(p2));
 	ut_asserteq(2, mock->read_count);
+	ut_asserteq(64, mock->last_off);
+	ut_asserteq(192, mock->last_size);
 	ut_asserteq_mem(image, p2, 256);
 
 	/* Region count should still be 1 (updated, not added) */
@@ -282,6 +284,44 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 
 IMAGEMAP_TEST(imagemap_test_map_extend, UTF_DM);
 
+static int imagemap_test_map_extend_move(struct unit_test_state *uts)
+{
+	struct imagemap_priv *priv;
+	struct mock_priv *mock;
+	u8 image[IMAGE_SIZE];
+	struct udevice *dev;
+	void *p1, *p2;
+	int i;
+
+	for (i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	ut_assertok(create_mock_loader_bl(image, IMAGE_SIZE, 512, &dev));
+	mock = get_mock_priv(dev);
+	priv = dev_get_uclass_priv(dev);
+
+	p1 = imagemap_map(dev, 612, 200);
+	ut_assert(!IS_ERR(p1));
+	ut_asserteq_mem(image + 612, p1, 200);
+	ut_asserteq(512, mock->last_off);
+	ut_asserteq(512, mock->last_size);
+
+	p2 = imagemap_map(dev, 612, 900);
+	ut_assert(!IS_ERR(p2));
+	ut_assert(p1 != p2);
+	ut_asserteq(2, mock->read_count);
+	ut_asserteq(1024, mock->last_off);
+	ut_asserteq(512, mock->last_size);
+	ut_asserteq_mem(image + 612, p2, 900);
+	ut_asserteq(1, priv->regions.count);
+
+	imagemap_cleanup(dev);
+
+	return 0;
+}
+
+IMAGEMAP_TEST(imagemap_test_map_extend_move, UTF_DM);
+
 /* Test: a failed extend leaves the original mapping intact */
 static int imagemap_test_map_extend_fail(struct unit_test_state *uts)
 {
-- 
2.56.0
