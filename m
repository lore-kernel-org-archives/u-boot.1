Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A8606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PU3ik7hT;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BCMatQS9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1956406AF;
	Mon, 16 Nov 2026 11:00:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZJzc-WknOt2; Mon, 16 Nov 2026 11:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EF1F406C6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826803;
	b=lWsUyhDDyGScYq+b3p8TNF+ILl8f6aHx0PL8g7330Xp/hFXk62q3ZRd60EOhntbezylF
	 naW88/hUiXtvx2xQ12JaAMh2MUv1o1QvCz4FLZ+LkUVZp6H8qNpzXSE/wbXDvPZ1tytej
	 DYnS6rOhttZmI0yspRlMPHtqwc3MWcflDJLHkIOlOyjvntiOv3CMJbz0kGFBZSJnjIhQJ
	 qkgH/cAhonCHqZ+oGnjVGr8siBTaiOiUXyyyxCAL0+dVxdELnFCEiGUA5/tlHnenaCS8T
	 KARgKjyQT59s4soyVMidS/t/YHiGTeRJaBGeXVyOFJpwIOcwFnFP8mFEEjiMUhcR0ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yLaR/0wDL+ywDSf0MnEeyEdWeNEvbb4exaupGGc7320=;
	b=G73YI87QuulqNxQGD2HDfnPPD/ysXVX8jxFpG48E4wHnQP2iHBQndfpCvmsiqm/06BCZ
	 bg8stpEGEhsO/67O4QUayDkl5J0kG86joRdd14TKhdxEjUaMfKS3CKv6j3aYkSIICNl51
	 fddqp9z7ORUEMdp7tKi7yeYM5++XrSttBMZeGSTq9E8UmTpojYEZmsSIh+wiyNeeff1Le
	 f9FKanis9tG2l1ucNWdo1BZx4z/0VajvOqKmbPwMuhaUAC/AP+xJcjc0Rtez+mUDv/oYW
	 nPYb7nK8Rmdte+PpkF+AqqjH4nTW/lRJ3NwrmcKZ4ngq39tziFWV7vMKD6sDMYzi6hg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BCMatQS9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826803;
	bh=yLaR/0wDL+ywDSf0MnEeyEdWeNEvbb4exaupGGc7320=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PU3ik7hTJltRjCQREehtVqpS/8VhrCOkO7Sdq2bX48rGcgvLm9EhEaV/pBFNUnXxI
	 lMp7Q20QVlETFVzT3VtKHOOU+AGpLloEP2kFrLb/ph8+scU0llWM5FpWMPtItvDHJG
	 oBhPahKEr7/fFe9zVDv+kuwi4cwP/O/+vTfKK0AUUM1zyFAtfJQWRLx3S9sCy3qUrp
	 cQ6xOsATYV4hJ5PaJMZMGtw1TElqCjVFPRDj6qiCF6mxPaWTS3It48emUfEfJ1wm6T
	 j4b07HyQ5fEk5ujIdte7tZlDB1XSQUT8kAgLY0jPdEqhBDHo1v3526DtvgRru8pjLT
	 /JJ7krUkqlP2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EF1F406C6;
	Mon, 16 Nov 2026 11:00:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9AF728C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 900AC40684
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zfIOsE76QHR for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A810405DC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BCMatQS9
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A810405DC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so8917755e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826779; x=1795431579;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yLaR/0wDL+ywDSf0MnEeyEdWeNEvbb4exaupGGc7320=;
 b=BCMatQS9oJU32uqZQ2ryexo4AiilW/PN47c5zmCahRZykOXIIEOVkpLx8whj1S8go1
 aRy1wfl52/u4BHT9cgRIVytEZ2Cu6VsoAc09te9MRsIlxz1M1okL4cyxfDz5f4XcS2JL
 7KjjoC1IckrUXIPUQldpC+CHXIC1tkbTd/cy+gx9VX5W9kdbX0/CihYCnfmRqv6EHMlF
 GJ9se6t+uHcYNbdKoPpEIV/E1ZlN775wtTMAaUPBC1fSU0hBtPrp9eTg73lrZWhYqYc0
 Ur3s/zJUHksJiu3lJ5WbgtWY7wBvTI+1gZTEsbtgmqyedRiunEg3Ru/y8cuvUvaN1PSr
 ZswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826779; x=1795431579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yLaR/0wDL+ywDSf0MnEeyEdWeNEvbb4exaupGGc7320=;
 b=k2ho5a0+9/gTIo0vmxrxJi4PkeYz3a5HRfFTNq9C76Hme259YvEpLLnAmg58VrfM4k
 81cW+y/QVtB4rnL4BHVtkvZ/rrC8I6oJunjPCoAzxeFtAJR0K9zgHAP/fn5/Alj2I2if
 DqoXW5LI4A3SzXQB8mweQey7d8VOPKlF6v9V8zTT5aBbtxKu0hFjx6ax2QSc5pTIrHnW
 dex/SMYUfn0aoRjM/y6oUymc1dSI9zkPtgUq+p4IcnCZD9Jg5OmDrtknH/zgT5hTaO/x
 etmQMUtLw1i3zU0d7kW4PZn08xHJ8uNjHa5B1FV3hzflSyGyaW3MohL/3gDK9rzFbhQq
 2B8g==
X-Gm-Message-State: APuU4Z8XTPeeGcHk8qPb4Zzk2OrrQvTYsjnezWTfe1a6EHDqjNFY5iBy
 7ErPpIF5dXIouniNgELcVlIv9FDd9T/+Fsi7jbiL/Uax6FZv2iHPvo4JPKtAjWATKZ8=
X-Gm-Gg: AYBFou2O5URoHHqNaw1OOHiDBSkccqDeHdrmiIGJoPzIPW6ZCxCgp93lZB3+lth80jK
 RmZLlc5bEcvS0itwctkCPoO2D74Mck0tnZAhBHlFUZQOYTpjgVw/KN58mIFYeboGd9+Y0U526zx
 fnfBblsNkAphV7+qxBrthw9OozsCvxUQZY7Bvvs8UgoDS10uBFoqMgnZ0oew4DxYBqoTDVb6dCA
 UItqJ9u/IEmRtUJfCVU7rxF8gc9Qia8nhp9RJ3x9/jXErkaCTkCt4JdseD8LFnus2agIHWaRksD
 fbDYiENoD0P0+SjFmM+cBIw8vkWapsMvropejGEs/y26m1Mpq+ejT1BLGvOcxdLM+SbkYCZYx30
 s1yLwDMQfPaguUU9KQziqyS6tLFeKLFb50oHegKo+TEeiGbz99fg3P+lQMmVtaQ9vX/6cUuNy0O
 YZnl/uKYIEnldufv3Vw8uW/Z/iOdrYVJaXv8e4GpzhVZELA6DYZ7N9Ka3P1QMC3y5Bzd3jyTN20
 8HEEYR3Cc1Opzw/qcbY3Q/RKW3QASeGcediCQcCedO5NKW2qbQtT/BgNW5l+Z6Lei+0jSBtVw6q
 /ZZB4ERIt3XGc6Go5TMr6eb6HRZRPUIc3rFq64xSkzeuh0ZzcH3yBxTvEmiUMZxeniy/mQ==
X-Received: by 2002:a05:600c:8b8c:b0:4a1:fbd2:f689 with SMTP id
 5b1f17b1804b1-4bb609ae053mr168625045e9.7.1794826779242; 
 Mon, 16 Nov 2026 02:59:39 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:38 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:35 +0000
Subject: [PATCH v3 15/15] test: Ensure ext4 file system is truly clean on
 creation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-15-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Force a run of fsck on the newly created ext4 file system to remove the
orphaned file that is present despite being marked clean. If this is not
done the integrity tests will fail as they will detect the presence of
this orphaned file.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/py/tests/fs_helper.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index e3824b2c1fd..48b047aeefd 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -250,6 +250,10 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
                                       shell=True).decode()
             if 'metadata_csum' in sb_content:
                 check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
+            # Cannot use check_call here as it will return an exit code of 1
+            # as it modifies the file system. The -f is needed as although the
+            # fs is marked clean, it is not really.
+            call(f'fsck.ext4 -f -y {fs_img}', shell=True)
         elif fs_lnxtype == 'vfat' and src_dir:
             flags = f"-smpQ{'' if quiet else 'v'}"
             check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',

-- 
2.47.3

