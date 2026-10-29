Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CF606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IBy+MFbo;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbqfG26R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 856BA60A77;
	Thu, 29 Oct 2026 20:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2KC_jHbT7YWV; Thu, 29 Oct 2026 20:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5AFD605D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793305519;
	b=lJ6NmTNGgqYn9xcxmNbznwZWOsmP5EEixoTI1rfYxdBy/I60VSajYBHRqqeEdzC6+2XZ
	 x8/a8cEHiY79+K00cgP4Tc+VyZgnyam1G7zLOYvY18LAJshrquNX3eVGWVAEcNcPtAVR+
	 X8Q1Yx5IIjoKssacGiPe3Gd9qtzEuvQjLaHsV+OSWM30CvDC1HeSV6/S+jae4nJRGeH+I
	 m4j8MNrbB1yqTQ2EEGxpPigS62e0pjYO0hvBg3nV+558jvVkle16SRYZlRCxhKPpFv3AT
	 fM9wDaJOvIMbd7y4POOX5NgGn9YFc9gKvrHZbQ4bBKlWyJuuAPXzhtrCN4RHz5hX2Vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793305519;
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
	bh=R7OKxfSjvl0ZOSjRrnSgnHD1yPVqcWYSzUzCugXAc20=;
	b=sl4F4sxlwYCtL/mHysR0SuPPrQgXBA75+T4WsiT2rPqWr7CoNk2do1nrdQZREVXKX+2X
	 2+WQ86byXNOYHLNNuv+Ug5Ws0NrW5c9Bzr8y03nObd42arMHOBuLdjpj6VeRTSfaBS3hZ
	 priZxmsh1YKN8lsk4KVzSbVqPpnBtte7I7pd9UvSHY2kMzIwTqhTo10eRFOtgU2e2ddij
	 0ew8nE4p7rCHobYkuYNUSHHk4LEbFbTAUjNvdnlb9mwfS5cpQNR+fpHoyWPRZJni58Bbp
	 szrKWesevzUhBdk0F29VYE5Wh+VaHSvCmY/F6RivB7TTtEoJJ64Otfh2ZFNJW+4GR9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793305519;
	bh=R7OKxfSjvl0ZOSjRrnSgnHD1yPVqcWYSzUzCugXAc20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBy+MFboArSEPGENNz1BJzL74+yN40zYyHVxQEhF6xxmf5VGFr1AqSKsDyIU5k4xW
	 U+q9g2Qn9Zapn5VldFICZ+J2vvvCt8nHshp3SRQLePYCT1uY9EMSTDB9/aNsTmO+9X
	 EcKLvvKOTuFCjQ3V+RUARpzoxsiblgf3l4HnM0Jxub7EVpvsdVtnHBe2ptXgqrOoMP
	 5aUkA5lmVrL8Uvn9XDk7Tknl+vFrwHV40qUcmQ+F2bTyMfbV2N39nkzxYIcljaiyci
	 S+sE8XfjtTJv/vlfyYweh1K8qM08rklBLIfBW4Eh7yWCQ/ITn9bJFPc1dR5LHNCj3z
	 jktGRgJcbHemQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5AFD605D7;
	Thu, 29 Oct 2026 20:25:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21A5D3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08364404F3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKrV7OC0uUuJ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 20:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 51406404F1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793304845;
 b=pbwlDcT7dvcZpgv487/BkDp7Q7shxdd4BYzZ1j2FowzyEhzsdb9NF3Wr7QlFAMBaeKNf
 Vy7kuQgrr2+GlHDkbbfC7t+kWiZ1zgJXPSbMYw0fMhTqEwJwfhqJvpLjnR6Gc4K6Bb5FX
 c8BGyhI2IsyEDV6QDY1hrOcaxGHNJX2ZA0LFGYobI7zJPUB9ajsM81uDGd0Jj9xjJnwP1
 bXqLJQL/O8lsU+TvxTO5DtOATR7KRrhJk+ftDlngiGsDxDlCUrSy4iXmuPiT1v27Ztqbc
 OD4dz8vMqszdDr+O/CU+Obub1GfR1RMnwE6g83KXK1k3m7355NOmdaByHkkCuctHyIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793304845;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=R7OKxfSjvl0ZOSjRrnSgnHD1yPVqcWYSzUzCugXAc20=;
 b=Nllht6esGb4QbEQ7qsNAHwRLRkY28VFDjSAUGsXSo70FLvFXNteZGl/WVzjnA2SpVYaV
 DhNKeiObI/A6CSFzK5WiDh8sVy7pAeUgXOowpEocsG8BfQXnL+lhMpOuurd1UJ1/uZaEi
 vohmprc2Enl0zve1vjlWtEz495K03C+Lcm4NVWHUiDxXfkQjgy/r2AyPrhKkYjproXdUB
 ckeEPYzaQk5q38I5gX5mxfp8gaoF0ISiIH2t403hbQh0uVOKwgvihsBxitTf8/nVoxvd8
 R2D+wZbggRHI2omHqcncCg9+ONlrgTHSf6X7tzKRfCTpYhsd5joaMo+vlgDq0EIAXnw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YbqfG26R; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbqfG26R
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51406404F1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793304842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7OKxfSjvl0ZOSjRrnSgnHD1yPVqcWYSzUzCugXAc20=;
 b=YbqfG26ReiNAtGLxF41aFXp4SJXwGQpFxyneIN73dO3NrP8dPj1NelzQucRO1rAi9eZmWY
 o7TFcC9dR0NkUtK5ZrYUT9InenBhGtu7EacEdIjgZ+N+o7xfMDUe1J9utftMz484i2diy1
 rIvD+Do2U7KqQa/FFZELyto1ITMV3Es=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-j9ystVR4PjO2S2qkI2mLhw-1; Thu, 29 Oct 2026 16:13:59 -0400
X-MC-Unique: j9ystVR4PjO2S2qkI2mLhw-1
X-Mimecast-MFC-AGG-ID: j9ystVR4PjO2S2qkI2mLhw_1793304839
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179a2035a4so23280176d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793304839; x=1793909639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R7OKxfSjvl0ZOSjRrnSgnHD1yPVqcWYSzUzCugXAc20=;
 b=0qNcLhif7RG3XspNcpr6784yPnFVipPll6IXw+SaBpy7lChhDDFO2qMLspYJXBnqVV
 DR3ND9QXGO7esPHIgwK8wR2ZDyAKqbsQFAc/KVmocGaNhz7Dadm6oqAbYwt2m8nqh4eI
 e2YWW6kxB4fHj3nKMYFLbTm1RvABJW1TnCgPE3hmZLWT8RwtfeIinZDnyZ9360BOq5dx
 gK62PzyB/aaoVobFAjUexpW9D672m+NvVCunFLssnriGtaP0pGx4zwsdFxfnF0Ggyv//
 gDDp6diQ/NnpH9ojgAVRIrhUts8uIt4dEz/3VSZstsTi6gtL/gmSjH7syj614FRetEpm
 9k+A==
X-Gm-Message-State: AFq9FYKcbeI9LP2KZeDRthJXk0OGri1CTWBLwdFixM2aLGxA8qxz4WJv
 paGh9n3fTN+A3T5DSPpzLFPFi0hdgWoWkuUj/+DlZuNOh7xmU8ob0l5y9N6/X1+qBSjxhvxCs88
 7sYjUHaUyqjH54+zj8mhiskog2GOqdL72coUbDkKPeIKa7ALwi7dIhtzdpLTioMR7A85ALA==
X-Gm-Gg: AYBFou24kDi9bcOTtVQCavehUYYfcB1sn9oMjdB+oL15DrGL1W2ib+aX4FJ3q+rMCBg
 yesu2lUk0a3MrHZJ4+OVxqz8oQXk8NBFuo8njhZSslhasgtnbAggHjcJ1pdbEP0iP20gxZGi5AF
 GB/puZqoeaaLmniD1uH8bp9hbIMN40ilY0ltuU1NHQ1/58jTBVKLOk05zqGZeXa9oRD+kY2Sj3H
 T9aM9PgpS5k4kX9OZn+I8WP9F/Rc1EOANeugnZ2Q75CHJHXT0oGEc6rmzhM0/Ktn4HWz+n80boT
 pnHfv8LE507s8LlcDzizKr86qn8/1N3BRglxlCImrT5p5seLkLSvn1heFAO1IPIk7+2lhbwu/dz
 2wxPD6J5AvascW7Ew2rI6jgK398BFfMRK9vjDyAzLaZ0=
X-Received: by 2002:a05:620a:410f:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9441338b4cfmr536193985a.23.1793304838751; 
 Thu, 29 Oct 2026 13:13:58 -0700 (PDT)
X-Received: by 2002:a05:620a:410f:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9441338b4cfmr536189785a.23.1793304838223; 
 Thu, 29 Oct 2026 13:13:58 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-944211e1711sm30828585a.15.2026.10.29.13.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:13:57 -0700 (PDT)
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
Subject: [PATCH v5 2/3] Add pkcs11-provider package to build dependencies
Date: Thu, 29 Oct 2026 14:13:42 -0600
Message-ID: <20261029201348.730274-3-ekovsky@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201348.730274-1-ekovsky@redhat.com>
References: <20261029201348.730274-1-ekovsky@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YgAgp2K9fciabN9kEl4K3nKLbRDfrh7fK80BNam0iCs_1793304839
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

This package is needed to use PKCS11 with OpenSSL >= 3.0.

Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---
 doc/build/gcc.rst       | 4 ++--
 tools/docker/Dockerfile | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 1fef718ceecb..29a6a632e7e3 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -25,8 +25,8 @@ Depending on the build targets further packages maybe needed
 
     sudo apt-get install bc bison build-essential coccinelle \
       device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
-      libgnutls28-dev libguestfs-tools libncurses-dev \
-      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
+      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev \
+      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-provider \
       pkg-config python3 python3-asteval python3-coverage python3-filelock \
       python3-pkg-resources python3-pycryptodome python3-pyelftools \
       python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 187320c26d59..109d6503d8cd 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -122,6 +122,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	openssl \
 	picocom \
 	parted \
+	pkcs11-provider \
 	pkg-config \
 	python-is-python3 \
 	python3 \
-- 
2.56.0

