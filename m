Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F33E107637F
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC14284127;
	Wed,  1 Apr 2026 16:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nxw0TQvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173E084137; Wed,  1 Apr 2026 16:15:41 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B527840AA
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so13022545e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052938; x=1775657738; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zn1QgF+UBH7ig2aMz9R4BmUloIuxItZzikjPINQdHMU=;
 b=Nxw0TQvQKE0tblS5pM4qntwmvQVPfv3DIJeVCTmmlbQlfNCLOW+aIGNIdBgLRA6sOH
 XPyKpXstF1RigrVffAu3CVbFw5U1lrcRyB5h5LgxeTNAjVvzCqWhrl1CO2JdOUuLuVy6
 GRPktcehlv0jritX73yY7o4+3KrzDK94TCyYUe0wPTt4oqgiP226EImYnuLS0e9MDuJE
 rEhV6NXXEBdqTfcRLrhFjXSXmMm56TWwD5fJmY0Dq9J7SEqBwTOsI3aDH0CdBbPfLixW
 Dl9dk5RofH6jfupCSMA4vVhWGci05hlZ7n+tYHBeg4xgtVxvBiRb370LXXMI/jLrF93y
 s34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052938; x=1775657738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zn1QgF+UBH7ig2aMz9R4BmUloIuxItZzikjPINQdHMU=;
 b=R0KBQ+YFCduywMrm3oloz8A0xImRKNMu+rWk/KgwtjfJJVoXvAC7pCE6tyz3iMINFv
 vsPSSne0J/GS6xp9/jOf5aHkuexpVlc3uFLIR/oNV6RSjd+e1r2jBKaCL0A+nMjF+JgM
 Dv8b2yc89xuPwd345SbJtC3OFlzgXGaOMA9xX6fx3A5S8+0lYLCPpb8FAM1U62CUanDX
 IHW7Atb5WF7P0SPREjJmtkPCkQBkSUQ1tKE+YDbzQkI0XhFg0z8BZXrI0T8uUviBH6M+
 fL9jq1VPyxhI899NwyntNts/g2Fm5zLrgMVh7GlZmiUKUiRajfnLAG6ma7XdpHzvXeSB
 QDmw==
X-Gm-Message-State: AOJu0YzrozGn394yOFB0bWPSkruTbzB+p5n1IIEYkKpKPHQ6rXH/adgt
 1tzghHvfjbY0fjH5EXcZv+uxz7BJCElji/krEk2UCcOsT/FrHT03kBGN1vjiLe0N/Qk=
X-Gm-Gg: ATEYQzx8XifwBy/X7/jbn3SNMVOz5OTxEZ2XF11B06XbfbkRzHPpPRpCjMXfl3Q9Hoq
 MLjHWX2ssGJUH1LSrRPkehiaQaVyJOZN2hR4vAjQx9NncmQhDUzEPnBY0wvCkZLHGZfKjHFnudK
 nWI5FYIloD9QoziQvDldKv6F9E87tpne+M7FWsA29B9KjDsXo+1Q7GH971v74g0/53lFZ00Csp6
 +hHNKQy+zwUh2kgxhhOwrDwtntbNvdXdMB7BvYpZQjy6FdO+zRD7MTeD3VGkjw0q4cnYDDQUwGf
 AtEx4dxrRSWzXSrupUxF5NZXFon9/FK0QA7NYl72o6AYkrWLfvK9QNyhRdV2oNpkWV6y3xy2Hsp
 tfTHDtFih5bTJmbp4NLcZQfya9e9DkVTT9G5tse06Jb5OgscDLjttGRPSAsIyr9vk6zVD7B6+jQ
 nn1RYC2nZ0bzjLnwcVgGAGeFnzk0TmyYn4FlHb2PI3Zqm554mpVGJPCQ0038zHlU8gBrkZ
X-Received: by 2002:a05:600c:8b77:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488835bc362mr61388775e9.13.1775052938528; 
 Wed, 01 Apr 2026 07:15:38 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:27 +0200
Subject: [PATCH v2 11/11] compat: math64: add abs_diff()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-11-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=yarHnrRLw4B3Nkf5OgSsh1JbtkF80PzViaDD1jJC89M=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGlVrv5vNbL8Xe/i/0NSzKQyWb2Kef5q3mclsep6hz
 PGNily6HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAifWmMDBNrOJZzdD5UTru4
 JLDYIzvEW7fpfk7e972dW021L6oEezL8s77H61625yxDWHXr8+xb7y9Y3tpfXmPQ/0d16dnSNfv
 e3gUA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add the abs_diff() macro, copied directly from Linux 6.18.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/math64.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index eaa9fd5b9685..70a7ee3ff1d3 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -256,5 +256,24 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 	return rl.ll;
 }
 #endif /* mul_u64_u32_div */
 
+/**
+ * abs_diff - return absolute value of the difference between the arguments
+ * @a: the first argument
+ * @b: the second argument
+ *
+ * @a and @b have to be of the same type. With this restriction we compare
+ * signed to signed and unsigned to unsigned. The result is the subtraction
+ * the smaller of the two from the bigger, hence result is always a positive
+ * value.
+ *
+ * Return: an absolute value of the difference between the @a and @b.
+ */
+#define abs_diff(a, b) ({			\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	(void)(&__a == &__b);			\
+	__a > __b ? (__a - __b) : (__b - __a);	\
+})
+
 #endif /* _LINUX_MATH64_H */

-- 
2.51.0

