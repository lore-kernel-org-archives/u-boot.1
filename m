Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7CCC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B57F840D01;
	Fri, 14 Aug 2026 18:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jv1oOmR2foNh; Fri, 14 Aug 2026 18:39:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7F9C40CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732749;
	bh=gmwGcihrUrsmM5ulDFq4O+lyvxHKv2XUkRP9Z3GENyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MeWT35ykeSobG1JZkPh7YX51vwBeC/zI3Yuw6+X6w0c69JCdQmddSSwHwZpUkrYi2
	 SgC0isOAg1LeE1lIE1RxG/wtU/mnP2MgLWjb6ObRjeLH82rVupZ8jkBRVNdVtw5lte
	 knXbXoKA2pll2Cm8aUT0ukGRhuY8lQWQzl3Xacc3wMQTBceWtjzBBO2V+22DFNvOvV
	 aFE45sFv+6rIWltwxQSCxX2eLlGkEgveIi1MP/h7NDHrQuOMqEPs64tb/smWBmx7HX
	 PhFJnGaYQgeYQphg9/csa8PEKK0uPQ7EM7PVyhHYe0OEjxfOdRe8ovXYep/iSjyUPo
	 34EtIUK4OpxIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7F9C40CDC;
	Fri, 14 Aug 2026 18:39:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F420C3DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA616812E8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id il-RZik9fN3a for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B945E81108
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B945E81108
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yDQcnJEw
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B945E81108
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:03 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-51c8e2e39easo13815131cf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732742; x=1787337542;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gmwGcihrUrsmM5ulDFq4O+lyvxHKv2XUkRP9Z3GENyw=;
 b=yDQcnJEwf44NQFuqmZ2ocNQ4Wa8DJ9ZcUzH6/WqnMFPJPKvoNvIkKAmdjs8CAEtXSX
 hh9dLoi4nfwMCNq0kaVM8Fv+BlnwdILFnkaZqKftsAFcQ4Bl4gahHaQ/OKigLqFPs3Ti
 /i86Q9s92o+pX7YTqRqUOym/UDPDnYePPIu4vFifdNhxjNPG1Jdx4AFTCqKNCU4F9jO9
 i19KJXsuS47gz1iCa337WMPbS0f5hjKMfEQMZ4Rvx1aezN2/BhBurMfNUZYPhO+Ns/6B
 WWkBrpyFF+YpBF3xGkG/3xKRljzgSRda939uhE+mFug6MSwWbJm2viwH4KXbvYb8677Y
 QKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732742; x=1787337542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gmwGcihrUrsmM5ulDFq4O+lyvxHKv2XUkRP9Z3GENyw=;
 b=oPeHuEKlYQhbZCSyJfvZ8+3Uc494Eo2gdgEc7OVD2NVbAR1iQjW/bylTlGzJ5aUl1E
 OLP/k+CeWUO8WWZfUxgUmZPFe9/tknaQb7kQ8sA8WLgNHCXRJP81JgeVuemTJa/xSru3
 knRor9orH/KOFqUvn5t737QH0vmUdVjIu0SwV/B+iqqr6TFU6JQk0WNVOWFHDd2rpLfL
 co5edoNnQR/1NfrwhtxyK+y2/hGyYvJTYgWovMaB6tj05+WaT0L8EzQe6DwB+cHEIMQx
 245JOD2cPbGBuReOWxKrXKFhiTh0un+Nd4/jHSiYZOVg+BKCF1P0soLn71PGKhlGKAP0
 mPSQ==
X-Gm-Message-State: AOJu0Ywnstv7IUhPOGVs8F8/i8Akc1IgJ9kKOL4xBq3XaOgaUc/KzljU
 CFILBxIKaAZ9HR8JwZihMNIbFEPVpKL5eV6fPTIxnyzvcHaLIgi2licJj6RY8bIVocLBLd00sXX
 yQMB8h2I=
X-Gm-Gg: AR+sD12hI/kA6MumXksvAlF7S5z15uYcvqy5S6pSfJoByrnJXzc7/OIgfNMYwnMSLAd
 XsE5/soKE2jqWA7kjqi4kdwvYkcG68b94Pjk7j709r8pRM3lB5DgLG0mYn8L/mw8RCvs1W1SeaG
 i90JT9v9mX2Lm6GijNavIcFvU8NGJdh9cCUNJLkymY1S1m7poxmGx3lEUlcaIJgg37w2kCKR+Dy
 PNJEuAZGx5VvBcJ8EsHr0AlHUkUsT/gUthKvufxlcIE0QKDTEWGnIeb0XHk8kTFJ9ou0x5J+R6S
 mk8iPOrFAr83gmASCIoCgYBNtsPEYO/Nh1eZCzqYK1Fvdl6sLDo7oUeTpmIc2fJgsUnL4mgWoWm
 Zt6q+CCqAu/sfYtbJvUFcG0sxAew9wAavfbnO+xittYmJNnZGmepXttuILyJfHChFoG38XnUa6Z
 d/2v6yHhK9yfej3PhEhshRfmVqUg7s4X0yqDH77Pp+UNDCVKIQDiBrueLgKntrZAAkmnkhLxRtl
 0+qSD68pa6h3uZKbkVwvLrgaBAB8E2HkIUirS3OOv+blnY0cNfwlOam
X-Received: by 2002:ac8:5701:0:b0:52d:7b1a:d7e0 with SMTP id
 d75a77b69052e-52d85517952mr89163601cf.32.1786732742569; 
 Fri, 14 Aug 2026 11:39:02 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:02 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:38:54 -0400
Subject: [PATCH v2 2/8] board: schneider: rzn1-snarc: add rzn1.env
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-2-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=1280;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=OAAPJDBhgIupuGvoZe84BXf7+a+9ltZ8vzRWKsI7M3o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB3lZdYx1ir7gfBikWtdMG4R1kIoEVJJRGzqRPYKZOcXWq5HM8HTQlAMsKrJ4x642TzpnkMm37w
 gTLFhprC/lgo=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add default u-boot environment for Schneider RZ/N1 board:
- Ethernet: default MAC addresses, use end1 interface
- dfu_alt_info partitions for DFU
- legacy bootargs

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 board/schneider/rzn1-snarc/rzn1.env | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/board/schneider/rzn1-snarc/rzn1.env b/board/schneider/rzn1-snarc/rzn1.env
new file mode 100644
index 00000000000..bc4f7e77b8f
--- /dev/null
+++ b/board/schneider/rzn1-snarc/rzn1.env
@@ -0,0 +1,21 @@
+ethaddr=00:00:0a:02:57:cd
+eth1addr=00:00:0a:02:57:ce
+ethact=end1
+dfu_alt_info=
+	sf 0:0=sf_fsbl raw 0 40000;
+	   sf_unused_mtd3 raw 40000 40000;
+	   sf_configcms raw 80000 40000;
+	   sf_unused_mtd5 raw c0000 40000;
+	   sf_env raw 100000 40000;
+	   sf_unused_mtd7 raw 140000 100000;
+	   sf_uboot0 raw 240000 100000;
+	   sf_uboot1 raw 340000 100000;
+	   sf_trustedfw0 raw 440000 100000;
+	   sf_trustedfw1 raw 540000 100000;
+	   sf_cm3_0 raw 640000 100000;
+	   sf_cm3_1 raw 740000 100000;
+	   sf_data raw 840000 0
+	&nand 0=ubi0 partubi 0 1
+	&ram r_kernel ram 80008000 d80000;
+	    r_vxworks ram 80008000 d80000
+bootargs=console=ttyS0,115200 rootfstype=ramfs coherent_pool=2M

-- 
2.55.0

