Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECB606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eHFefMO5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EXBLlX+s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D58E240E3D;
	Sun, 25 Oct 2026 14:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3d8sZ1uxo0eq; Sun, 25 Oct 2026 14:15:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E05240E46
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792937735;
	b=bxtcU6TutCGzWwL6SLLChAa71CuXMmo222+st3hh8UmU9iaEdqv2QxO6tPQOZ3x3i5l1
	 C+g2VuSwrjunttOhF2H73uh2rKldJg68cJFh2CHEM1PXze80hzLH+4FoI9sWpQxLdiMqs
	 mhm0KRDp6oCThwDSdZoccZIScC3KbHnEFr4b5vfZBNsu77dRVfWzI7sUnETEyZPibRNGi
	 cnyprGwoWbT83jtOweWIQzVEWMlVT0H/IDtS2R5HZ+jBR4yOb0CEvDsNO7dd9oDY9uz6J
	 Ohle65v4qY9VO17gpiUermuEZmVlBULyhqbr7CTOPXAffucLQUTHsy9F/OPCoV2uHqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792937735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qbWFkyIRsHecPNzITvzAbL+PveZmb/4b/ggRz7rDsI0=;
	b=ZHRcTPmhfBDJ12j2jprKbRyucV4w/s9I9vEjKIFRZDUzHoXHubw8rD/WeG5OoeQP9M7b
	 uwcSwSWfebcUfnSKkeXgCPXktytb55OC6mtlNAP3N5L8xTJzvOAfBXc9aI4Fc37KGz4mn
	 FFY8zzI9/vV6cb/R5iE7CVS3ReF6/rqJZ6MspAF4cFZ0xYbto5wD6DKz44LCCmcYlAv7A
	 wAumORqYoFE+oXxukumVOGIZ7lED/dFjC+bJaoRapdT9LqDW4qvfwx8Z9HiHs5zg6KmDE
	 VgA9ftksOyRW7ZAZFZu0fa7qYwct/vqEbBApcmxqCHYP8QULcMmDqjmbh91TW1kaD5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792937735;
	bh=qbWFkyIRsHecPNzITvzAbL+PveZmb/4b/ggRz7rDsI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eHFefMO5tGIRrRzzUKhCrlHm7HY5WMtLpqCqMAPdCOpUrNL3msJjzYtPj9rhRH22l
	 bBxFAkFnVHdKVJRWx102Pafin3P93hFVSvIlTY+xahlMhbC6i61/T0lzJJs5zPxrix
	 PD6Dc9d63d0fPmbgDnHzlCaU/+IWwwQBpt4JSekIgcX3B8r4vsVmkCF+NEZXF+NmKK
	 Pys2SClBtJ7fHOBrKh0qFdNB57e17Pjc5gN8SK6wT+WbI4fBho6IH5G3lKKD4ssitJ
	 mfWoLcI+w577sJ5ili9IV744t842JiS+jt5OlF7hcQUEv+xBUf+1k46gb8LTW+gtvj
	 T1jRgmj7VQ1ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E05240E46;
	Sun, 25 Oct 2026 14:15:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F31902F5
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D932581697
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZxIAThXYfoFO for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 10:26:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00E538156B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792924010;
 b=paOzZSLrLcQ6hgIclrlnHtxJwKKl85M8L8pVEvHdMhYouJ1X4rfSkGsWlfAgJOnQ63ws
 LdQlo3UtBhGC5x0ZqEgtyOeZ3MWBG/i5ekFswGh/dLu5C4WbaY2GmvzWvwlHDmfOoAmY9
 vwi8OOchObRosi/qJTyvPPpI3O7AlaoDxZHCYt14nB8z9CuHlRQ5ttpqTspMwzQzRKroX
 3lo5LlcHjYGJo1FTLOhD5RjvcJezDMAhnlFp+OxzzWvOO+vtcB/dz9oTQQh0vn31x9UkQ
 9Ns65q6UqJSAagi3tylASzknR1Jxw/GRaiX2+o+Z0ZJ0BDfUM09eMkoQyx1E/+Zy7iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792924010;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=qbWFkyIRsHecPNzITvzAbL+PveZmb/4b/ggRz7rDsI0=;
 b=csD0hrqsAYQ4nfQyhoRgDwQ+jYI4TvKyHLS3SWpBIQps1vZN1cwMvMj8ruhDM01TRrBp
 x+ZVOcTrZxEf7NokCatFGsn0pchN/fEElbkkLg4sn1ZM5o/ZZ1n0ufvcFjZERZroCpk54
 fV2mxHhweQzgrOowTF3wMlZLzQ/kSjrYBOht0AI8/gwQQoKS2yHMIM28xQherKAXMhyFR
 oQvNzJGtPVTXUnwIDVYohTVuERorg3HtuGyx7HyuqnUgaG3/wPj26ONn4iO85UpAgI1Ep
 bI0tjeGOcFBFa3WuPtSREladl/jPxX8RaTXCB+L3RDlG/06/xVzIyryo50gUBDJm87Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EXBLlX+s; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com;
 envelope-from=vikrantyadav4802@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EXBLlX+s
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00E538156B
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:49 +0000 (UTC)
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-15943c9c005so2816687c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792924009; x=1793528809;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qbWFkyIRsHecPNzITvzAbL+PveZmb/4b/ggRz7rDsI0=;
 b=EXBLlX+sU2sIsIB3iDVbWzvob0f8ZV0jUW4VDSOVspmhR3xM8IHiBWMY9j9y+j4fUf
 mA0rLs19bVtzGJX2YXVh+yOO5YH+carf/0G84b1UjsKdX6T4giYzT8Lz+ejwSmdkZ4lY
 YhrU8NdpaNSd+DhrfYvSVTU9t7NObLKS9WaGSd4L3Xh1SoaDG1Yl9McCEJgVQCUb8mvJ
 VSLxrtBHsAHlqe6WzQmaYDfof3SKQmhN5lThDhxMjZdkGsiCBsvQw4lLnsLwIB9ddiqY
 cLjTfTk1JL3EIO5AgYLya3zcSXumZQXAWZCTsVt3fg8xVCBetNZCMHS4Fat0OdALQZS0
 4tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792924009; x=1793528809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qbWFkyIRsHecPNzITvzAbL+PveZmb/4b/ggRz7rDsI0=;
 b=XSIfyGgzcwWJ1UKleLMczuufxYWFUCw1vRpZQHvcsB8hLhBQhbOwhATkLsvXLkEh9F
 cm7EAgzZnHplNRwPS+A2WvMTJmXZ8k/bAwglcybDvkGnvFCke+RrmgD6Vg/LHyxNiQqO
 9MwhJKmzLaCwMMUvGjcfCNdEXZ5BSloZ6BJBx7+zawpon0X+EFRZhvoSevX8gtaCDWjp
 1kmtz6opKx4oG+uNB9syQz+4x3ZDkpWnncNiMPGBSMziVOx30NGCYwhZhbMfy0l948ZL
 s3OW6AGHFMTzfeXb72MAEaF1xMB+Ju2aa0MkueYWf5pj9pSYahHr5uNLY8DekjC82WOr
 AohA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwN19/NB6xAphLfNI1wg+nmxmh8/gVJio11xLs38BAbdsc+3w1KZboorCeV00lvWjMAXEwoz/Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIm5tvXgzaaLLDxhXRNSc6As7rjabanJxSaku6+H+CBMbu4BnH1
 Aq700qViXgXydxlEx9fik1oewTA6feZK4EaBRJJ7QJZFQOTV7QJjv+xu
X-Gm-Gg: AYBFou2FRuRlho/5n5Gxn8JH4JB4MuaIhjviJybJJMT3GBso71p4ew+iV9OUmGfBuAn
 bfmEEWgHtsrVVGHGRqQiLD4fPGJ3JHRx537UoYLAzkqdKO3ObHonQ4SSVZN9PXsbVdx5uyeRvAK
 ezPkM14has37LTu7ws7914zWhEoPr5AJOqOe/SB7jLUhoKkTvgjyHMbuXLT4abqRfinzsj/ez7S
 oVat7syLwls9M7va1NnHeG69vapxnTqe+ulVOOz9FWhM+Dzy4AlUPrhye9qVe8H8+LSmKderoOT
 xCezNf/L0gMfv1nTHHuceGyOhqBLCkPWSY6eixFj34UhNavPH4YV3jgiv8VCJP0Xmo29DVuNdwt
 m8CY4CBsihZXQg2JkvOe+3T0gsmEReogXnCZhe6W5FbZHPs5ITFbk9FOymZM2iXW735mbq3BjLk
 8jEQsHADUvJNpZQgQAVRz8nFHrWpNYKPc581K8nUiLQHzjsmhlj3J0EDnfhyaP7VYxMsc0qHbMA
 e3A5q0zOcTIYzW29crHWdMjCMrLGxD7KC4f+SVRfGjmzyIo2Ck1tgDoWbSUROLaWWI6NpqASqDr
 CzXH
X-Received: by 2002:a05:701b:4517:20b0:14d:cb67:afc4 with SMTP id
 a92af1059eb24-1993fe816e3mr5300783c88.41.1792924008504; 
 Sun, 25 Oct 2026 03:26:48 -0700 (PDT)
Received: from localhost.localdomain ([110.235.239.152])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm18923825c88.13.2026.10.25.03.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 03:26:48 -0700 (PDT)
From: Vikrant Yadav <vikrantyadav4802@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 u-boot@lists.u-boot-project.org, Vikrant Yadav <vikrantyadav4802@gmail.com>
Subject: [PATCH 1/2] pinctrl: airoha: fix bias readback in airoha_pinconf_get()
Date: Sun, 25 Oct 2026 15:56:33 +0530
Message-Id: <20261025102634.53851-2-vikrantyadav4802@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025102634.53851-1-vikrantyadav4802@gmail.com>
References: <20261025102634.53851-1-vikrantyadav4802@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 14:15:31 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In airoha_pinconf_get(), the last branch of bias check
"else if (pull_up || pull_down)", has no check on the requested
parameter. It was meant to reject PIN_CONFIG_BIAS_DISABLE when a pull
is enabled, but it also runs for PIN_CONFIG_BIAS_PULL_UP and
PIN_CONFIG_BIAS_PULL_DOWN. When the pin really has that pull set, the
earlier PULL_UP/PULL_DOWN checks do not reject it, so the execution
reaches this branch, which returns -EINVAL. Reading back a pull-up or
pull-down therefore always fails.

The same bug exists in the Linux driver; a fix has been posted:
https://lore.kernel.org/all/20261023175710.19181-1-vikrantyadav4802@gmail.com/

Found by code inspection. Compile-tested only, with an7581_evb_defconfig.

Signed-off-by: Vikrant Yadav <vikrantyadav4802@gmail.com>
---
 drivers/pinctrl/airoha/pinctrl-airoha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
index 6245f116bd2..093a6c05f65 100644
--- a/drivers/pinctrl/airoha/pinctrl-airoha.c
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -350,7 +350,7 @@ static int airoha_pinconf_get(struct airoha_pinctrl *pinctrl,
 		else if (param == PIN_CONFIG_BIAS_PULL_DOWN &&
 			 !(pull_down && !pull_up))
 			return -EINVAL;
-		else if (pull_up || pull_down)
+		else if (param == PIN_CONFIG_BIAS_DISABLE && (pull_up || pull_down))
 			return -EINVAL;
 
 		arg = 1;
-- 
2.34.1

