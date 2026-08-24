Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B807C5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD562406EA;
	Mon, 24 Aug 2026 13:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cAWK_r0Sw9O4; Mon, 24 Aug 2026 13:13:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577213;
	bh=FUNmfJ/F4Nx/Z0Bv93Um4LLd2Vq1axZ1cCNbP5Wn1fQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIg4eOV6VAoqmlPQvlB1nnk9CRBXms+gm0AMeqA8/hgZiFE/Qp2/NIbh8GEFFlPEJ
	 N702J+fYYG/68oTuHET3HYEmhIFx3cblRIf2Zj6k77seNSDfgkJ/nhLJc76QhJ2zGk
	 1bfTVrkVZWOdaPGvzm0HSeA8Dpr6zZUj9ld+ZYjsFFIVToQZQ/zeIc04E4byMaZ3v3
	 1d40wn211zTDTgjb/Zj8PPParLutE4tpsDZInP4ZuWQseUMnF8BWtfGwkQbbELunAp
	 OUqlcn7DdnSHi+zrHSTxQYaW4vKTvDwtvvNm031+N1Mki+SAgAEodI4/BqCD/LSDkZ
	 gckpk8Xono22Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A21D4406CE;
	Mon, 24 Aug 2026 13:13:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F1C19396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F04A140029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_O7FdKPiHVy for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=4ldABB2L
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E4E740050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:29 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so27100095e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577207; x=1788182007;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FUNmfJ/F4Nx/Z0Bv93Um4LLd2Vq1axZ1cCNbP5Wn1fQ=;
 b=4ldABB2LrAfYQ7o5vWtU68dN9sqQR7xPf/2vNVyxHSz5dehb3Rqs9cnMs5cPIuGeqn
 fYTx8wocG1OgTr9s0TwrlhuO29QtSQpZikpXt85Aac6cbokF2tz6TUUIGJlq7vxfRHBn
 5V4DsG/S3JhVVEdR4QSO7GotQBjUh52u2Yy2M9agEDfh9R/ESq0fOYM9NI6If07JolNx
 1icpytDhmUX6DDE6zQMbbJ9roPfg42E9ssWyKgk7SWYasnlsoSsQwutpSYWDajm138P2
 T4nxUw3TKX6hQumt/QHWagvJEkLtn+tz5iaGLi82+txPKO1It5IP2Hitl9hnGYHHXf4i
 I+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577207; x=1788182007;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FUNmfJ/F4Nx/Z0Bv93Um4LLd2Vq1axZ1cCNbP5Wn1fQ=;
 b=GKn4LSHD28bwid6gX/Q83DzaNjVzBP6D0n+Y6c5TwKzzzndYLnx0xVHF+vVzWVsfwg
 YSBtDz2+yHKCgpvkOZ0Nv0RZNosy0Va3v3Hn10Nnv5J2LeObM7hLroTRP6H3QB6L8Ftd
 uBSC2iXVHibU+maGKkUVak6yKgcSVQ9N8RFUgkRk2XTnicXgGw61LIGT6u95xQojimGT
 /TEQX5bRkHav2Q43dYgDXY0i9M5zJln9DrZZ95gtlQ0k+1Jzqd9o2Pwlz/yXFg0j6qhn
 Xunun9qpSzfepN2mSmoYNRS+NlsrBIZYXcIznLwbvr39iKn8FknXHp2EPZu9mW/JMZL+
 HCYA==
X-Gm-Message-State: AFuF++lnI4Hlk+GHJtovi1ozglPb5JcvhVtGC+2w5m3kONEYvI6hYBAc
 AqumabyPo7OwIR6sjn9mGQZlgr3BSVoNPZFOsprM9zdGd3Vd5Cw2VnpumenKO/7XUMM=
X-Gm-Gg: AR+sD10kvOjPNT86DtN//S2ylT1ClQwx76oFB6zbqXBFfxFqcizR/8ldsbO0X4MHpB+
 Ui+ZnKzi3N9ViubqN3j8LrMHwfKBNrK+3yo6ZtSLxmc7n7TmD0Krt7/TiuCstwPcS6WC+Q1KkZu
 18ExiPvN3Zq6BqvE/7TBtndEf03MQaqrZq6jsAbQymZPzEI42rHn9KJfx/2VvHYhCQm97yAW+Dc
 xiSgsXvbsLBDW+kMVgCSVtj39rg+Lp5Nbijz5axEyLQLuuuGsLmJmDvJ54YCdyzqsooTdiqFvj0
 eDjInU4FQNi/eYFqepnMOLevXwF4Z18BDBTU5S7rgR75IOy9xQF4VClIAccrw3iQn0N2UF+7Ae6
 gdP7xe82AufaVY6A5QAX8uaPdIxiR8xTdPVEUkFDbnxFe9pjMxyPzK07MkAC7Hlb3jFMogtz2ea
 Qg4sAE47HLhKjsuYkb6v2pNzPErZEFtUA63iGHUIW4CoDv7XPWzItasJ+mSgDw4wTHby3a9+Rqi
 7H6y6xXX0gmfsd73Y74+PMY7p0olRhn40dn8jTTiQ==
X-Received: by 2002:a05:600c:c172:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499b8464e46mr352062435e9.12.1787577207554; 
 Mon, 24 Aug 2026 06:13:27 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:27 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:02 +0400
Subject: [PATCH 05/17] pylibfdt: Add Property.as_*int*_array()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-5-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=alchark@flipper.net;
 h=from:subject:message-id; bh=nAWzlxc34e2TMvp5nKAvKmbPAUm82aV1TaZX7RUYZRw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGftdNQNX3Au4IxfsdUF3VPblpm+sZ73L2H6brN9n
 GolfcdedkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVEYsY/kq++J+wtuSPIhPvq7JA9lA/Xs07pZP/Wud84jJZ6JvxT5SR4fsHUYl
 tzOf40yUmrTDkyN46L7PN5YqAsPBnoeS7XXwPGQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Luca Weiss <luca@z3ntu.xyz>

Add new methods to handle decoding of int32, uint32, int64 and uint64
arrays.

This is a backport of dtc commit a04f69025003 ("pylibfdt: add
Property.as_*int*_array()"), without the dtc-side tests, which have no
counterpart in U-Boot's test suite.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapted to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index c8ac578b367b..735a3bab6d9f 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -720,6 +720,21 @@ class Property(bytearray):
     def as_int64(self):
         return self.as_cell('q')
 
+    def as_list(self, fmt):
+        return list(map(lambda x: x[0], struct.iter_unpack('>' + fmt, self)))
+
+    def as_uint32_list(self):
+        return self.as_list('L')
+
+    def as_int32_list(self):
+        return self.as_list('l')
+
+    def as_uint64_list(self):
+        return self.as_list('Q')
+
+    def as_int64_list(self):
+        return self.as_list('q')
+
     def as_str(self):
         """Unicode is supported by decoding from UTF-8"""
         if self[-1] != 0:

-- 
2.54.0

