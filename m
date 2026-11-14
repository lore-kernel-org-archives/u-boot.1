Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E839606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aoG2Q+2y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7588B81180;
	Sat, 14 Nov 2026 00:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzI-ubY4JbDU; Sat, 14 Nov 2026 00:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B27CF812BB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615099;
	b=jyR50nr700dTTiPF3NZXK8uApdH8LzEtEh3sJKhjcfUJBFjW7OJggLUPzAOZuB0fQBH/
	 nk3SgxupwDBECIyXfkGATsp0m5+MFniYb80O9aD9H3MOojjBwgi8yS5SRBfueziOYeJzN
	 QhMbgm/3uaPJczymeVJWfSXuaTbRlzW89PR49/22YomNVQWppNIMm1q3d1BSQ91of04aj
	 nQKhMKr0A72gX0S2ehLW0vWBDbD83qAb8DKb0nKjr8MtVXzn+ZySa4RwlSZlZ+wSuEp9G
	 pc1JnDxp9s3aXbkkUQohtSOV9sEDmckzFHfxBKAAEsl977zu33fqJOz1LlcuMBW5Z9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615099;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iuRXfSeWCvBau7CbkBVVxurJS/Mx6EPDMDk7NNfesZg=;
	b=HGvS/FA9jQKUDFIs89lOAjfeodFDpsGp1vqFEVvA2liKkqAvfCkNzRfFvM8QKqF1D8s6
	 TpV49vg2SYUBNm2bAz7+387pV+MOf/i22nqHivD9UT0H+hf4nOzTjyy+b8jJ0ktLixY7c
	 SGOe37IVtlcBukhM5gNTjfvBBZ5lU4eLBoFETYTonyI96ZKNTFJq2BDYhqXPD42kAGso6
	 Xdp9TgP0IJJHMCrzu50CyX0jHucENvwS+7QxTl9YiQBHrgeM8ZM9mZULc3s7jiyNwMI60
	 lh689LnMnOyMlAiFQoGNxmTe+clbbfydVYYD9YTU8bUJzSt/2C3LfXzAjqPTi48cDkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615099;
	bh=iuRXfSeWCvBau7CbkBVVxurJS/Mx6EPDMDk7NNfesZg=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoG2Q+2yYERbOAJjUk/KNz/lCVyXVwbKHeJQsQF0kFGNEjwew57lAA2rDneYyutM7
	 v+/hUtnYN+29CLLDX/pSx/aNd+b2XmHSK0jgCzo5bL1vXPW/YMLoUt40iohnHtB3hI
	 WvSHvfAQRBXK59fGOZn1m/yBVxUis1ZI/wBbGJHP9Jg0kYC9hExBqwN80cIlikZZJ3
	 07M3v03bKLn+788GiSmXYlr5JcIuMh48cXv45MNbTGoJbpMqtBD6dj5TA7EbIGT+LC
	 fAXSXH0CbDLdRUdNQxvQcUo9T9pO42gXslFaBf496gTdjIzksOKvgdr/ZGtDe56hQ6
	 +AtMNlOhSRCpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B27CF812BB;
	Sat, 14 Nov 2026 00:11:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 711D628C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E23C60896
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7RsjE_-at18d for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A825E6071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A825E6071D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:37 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1Me-0000000005P-3afD;
 Sat, 14 Nov 2026 00:11:28 +0000
Date: Sat, 14 Nov 2026 00:11:25 +0000
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
Subject: [PATCH 5/9] test: boot: imagemap: Check a failed extend
Message-ID: <e089ccaf9aed3ca431b90f297cf2b651e9a6bd81.1794614777.git.daniel@makrotopia.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test which extends a mapping past the end of the image. Check
that the failed read preserves the mapping, data and reservation, and
that cleanup preserves a subsequent allocation.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 test/boot/imagemap.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
index 2c6f23fb4f0..05bba8776d7 100644
--- a/test/boot/imagemap.c
+++ b/test/boot/imagemap.c
@@ -282,6 +282,51 @@ static int imagemap_test_map_extend(struct unit_test_state *uts)
 
 IMAGEMAP_TEST(imagemap_test_map_extend, UTF_DM);
 
+/* Test: a failed extend leaves the original mapping intact */
+static int imagemap_test_map_extend_fail(struct unit_test_state *uts)
+{
+	const struct imagemap_region *r;
+	struct imagemap_priv *priv;
+	u8 image[IMAGE_SIZE];
+	struct udevice *dev;
+	phys_addr_t other;
+	void *p1, *p2;
+	int i;
+
+	for (i = 0; i < IMAGE_SIZE; i++)
+		image[i] = (u8)(i & 0xff);
+
+	ut_assertok(create_mock_loader(image, IMAGE_SIZE, &dev));
+	priv = dev_get_uclass_priv(dev);
+
+	p1 = imagemap_map(dev, 0, 64);
+	ut_assert(!IS_ERR(p1));
+
+	/* The mock refuses a read past the end of the image */
+	p2 = imagemap_map(dev, 0, IMAGE_SIZE + 64);
+	ut_assert(IS_ERR(p2));
+
+	ut_asserteq(1, priv->regions.count);
+	r = alist_get(&priv->regions, 0, struct imagemap_region);
+	ut_assert(r->lmb_reserved);
+	ut_asserteq_ptr(p1, r->ram);
+	ut_asserteq(64, (int)r->size);
+	ut_assert(lmb_is_reserved_flags(map_to_sysmem(p1), LMB_NONE));
+	ut_asserteq_ptr(p1, imagemap_lookup(dev, 0, 64));
+	ut_asserteq_mem(image, p1, 64);
+
+	/* Memory handed out afterwards belongs to its new owner */
+	ut_assertok(lmb_alloc_mem(LMB_MEM_ALLOC_ANY, ARCH_DMA_MINALIGN, &other,
+				  ARCH_DMA_MINALIGN, LMB_NONE));
+	imagemap_cleanup(dev);
+	ut_assert(lmb_is_reserved_flags(other, LMB_NONE));
+	ut_assertok(lmb_free(other, ARCH_DMA_MINALIGN, LMB_NONE));
+
+	return 0;
+}
+
+IMAGEMAP_TEST(imagemap_test_map_extend_fail, UTF_DM);
+
 /* Test: map_to() reads to a specified address and records it */
 static int imagemap_test_map_to(struct unit_test_state *uts)
 {
-- 
2.56.0
