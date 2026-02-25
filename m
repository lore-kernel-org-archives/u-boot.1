Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536D4FD374E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD29F83EEF;
	Wed, 25 Feb 2026 14:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQQjjtV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5094283D8A; Wed, 25 Feb 2026 09:54:18 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F200C82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nagabhushand34@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso1030290185a.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 00:54:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772009654; cv=none;
 d=google.com; s=arc-20240605;
 b=Wr5w5MSlNF2IAsfXvNpEz5EdCSJkOK4tQcFat5TbEItcDD4gA2H0pMBcytav1TJQ3x
 Jh2NFQSkAI2Nyl/85OpkN1dHgRpQnd0ZbE9EAZ/UAHYcsFpXEKiLO4PbIEjbsCwyN2HT
 uyyuNUqLRyB/fLBoT1NC3Z7N7QmcHL/FE0KnDkQn0HtNB5whA+RZf4pclFO3JGlr9AaS
 x1ziULgnFVJWUo7+kh5DWos7y6F1ypCif0kBpW4tg2JWmGfw+IDdB6r/+8xEAzfbgBC4
 s2Ft6ML4f8e7Ac3SLc6wcfqx1ZIJBvgT2P3xC47Cy+9FhEVnUl+m0+AGBAoMuOWRtTF/
 vljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=1D0NOR+NCF6CjeT9fZ0blqgRjHpV/AMo4uM8QbU2wNs=;
 fh=4c9kr84hwKJ6Rugz22HbHs+ZchWfPOonXrFJKRDpgc0=;
 b=QuW+pst8+rLXYRm+wbcz9KdLNJ1HtDvppyRLrkiIbW8wKsEkEl0Vpih6BMte9hqTxN
 QpI4cIMYU5/2eMbT1Tq9KBDNPa6o3Z6bm/SJOWmB18aBJKTZ70fOvC926RYZEoZiohM2
 CDDl0YaXiIcRzjGCX4SXz2QxkOLEU1HOh5EwT5v6VqMcfCcK4LBEMrzwrg5Oes/iDaUK
 0pVrh11xBJaa/LhHtn3JijyBWL8Y2RKuXhdDL2sTnFafDA9GMUxfJu+N66hnPUWZpKT2
 y/yUDiiGxOejPILugIvCnf+hoQZ3Akfo0WuKFY6Xy0cfPphLIo7jcb9Pz1W1BoxxwvuG
 Jv8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772009654; x=1772614454; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1D0NOR+NCF6CjeT9fZ0blqgRjHpV/AMo4uM8QbU2wNs=;
 b=GQQjjtV7681+Wkzx6rjdI48Y0zTKdBjfbL15TZbFNHbYYV9zViJVKnyxtMxn2umN17
 WB3acQ3xTfxGEztVDf+WNNA1jvAGeFJO5ldGf8TJ3K2BF8SJAppb3S+luVLT52yqzoLk
 2qvrFNF4k03qqGCZU/hO6oBWUTDiXqGtCKSxZLz326rA2JeVsH4K28x3MgqrekqZ/9lp
 C00E1WdGYvxcsL/kPVCNrZqT+sXV1D58/mr0r09dGcFVQZYsgAQqe+N9UTTHVh+uvSJx
 cqg84QvuzCdXftiPlbx6fEVpyTkL7vnNK9RSyxP1mrqIbGZGagFmQkqPkkBKgpHNsT7/
 hU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772009654; x=1772614454;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1D0NOR+NCF6CjeT9fZ0blqgRjHpV/AMo4uM8QbU2wNs=;
 b=nimKM7AsWKyx4LV2xSmcueCTAdJmoQ1fBwZUVfE2i3BjoxjsQke0w0a27pqya2Riq5
 YXXcb2PrsbeE2gTxL4/vU2nMRVjnHU5m7e+L4mcPDSVB76F6l6XtkwCE0yNIWrYlVP6i
 8gEmWrKbithOl0PzVapUFN7KbyNc8qtKV143K58X6FQboJHSfyMsr7t6hJtAqP11T0PS
 rYlB64KIjZ4qt87+xqyW/v/Kt6FsL6ysW9kWXN3rsQEiZHJn9p+flQPWmN3NEfybTlQ9
 xyTJ5fqZgw5GWjJJhjwP9IeOcd6MKocrqAqwhbZNTBTLuvduPxesh8wYvPKhFwrZTrlK
 uNvw==
X-Gm-Message-State: AOJu0Yxn4tdEWwfB992faIHjitgoromopuK2LS7cWRrBijGDL7jmPtLk
 4/1oNA0FnJiinGl4iezMmAIkCN64S4i+6SH+CJiRdZkk3lk/tgZ0QfoAuE3Bq6+6aArhoDfjq1s
 ryVjzb1C0yf8xktcMCZBiqfCmQFvBbRlr5g==
X-Gm-Gg: ATEYQzzsd4YwZhEK1vrcMXO6kIubWipVvyrG4E2uN4PotMo320EWgLv3HyDvmoo04da
 4JhEW+rvelONODk9URrIs+vaxq4P+gtru81lsadmZHIwS+dDhYF/IfEHGp5Hs84gnL7WVgkUnl6
 AOBzfgViH9B0C2yi/YLxrE5Iz/DA2LPWpjxxwgqgegtqp+gOeWXjKRXYbBFCfF31fmh6kGvwbBd
 TwqEnRvAYvCjg0FbSMBTgNXVbblv0EeGU9Rnjot+EV9gL2H4HacnovWIwV580t77kkQr+S7JN+b
 cRayqLK9TMw3elozZjc+2wy4R72sM/xgpJ6maeA+
X-Received: by 2002:a05:620a:4441:b0:8ca:55:ac72 with SMTP id
 af79cd13be357-8cbb58aeef1mr190799985a.61.1772009654338; Wed, 25 Feb 2026
 00:54:14 -0800 (PST)
MIME-Version: 1.0
From: Nagabhushan D <nagabhushand34@gmail.com>
Date: Wed, 25 Feb 2026 14:24:02 +0530
X-Gm-Features: AaiRm508hxMkwMGdBNXs6HPGxsa5dOGpzYzI79_guSHv8bvGgkntD8qptL7BmHw
Message-ID: <CAA-ybFQ=DbZzcGq_=HLFx_Gp_D1YKj=oKYXtD0HKPuVYcQyyoQ@mail.gmail.com>
Subject: FIT Verification
To: u-boot@lists.denx.de
Cc: "sjg@chromium.org" <sjg@chromium.org>
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:19:43 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Team,
I am a recent graduate working in Embedded stream. Currently exploring
secure booting on TI boards. I went through some of the writings on github
-
https://github.com/ARM-software/u-boot/blob/master/doc/uImage.FIT/signature.txt
and
other sources by TI. I would like to get few confusions cleared by this
mail and thanks for take some time for this.

1. Can I try out only fitImage verification with hs fs boards only?
2. Can I try it with ti dummy keys or any other way to know if the flow/fit
signing is correct?

Thanks and regards
Nagabhushan
