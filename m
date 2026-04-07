Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B963105D986
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 21:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A0384118;
	Tue,  7 Apr 2026 23:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7+r/Czd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9454384105; Tue,  7 Apr 2026 18:15:18 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B091783F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 18:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so25787005e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775578516; x=1776183316; darn=lists.denx.de;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+tc3JMD6SlPUG2e9Gpv05GHF8bR5d98yKHmmwddmA0=;
 b=i7+r/CzdFanRhgGuaVhyHNcf929yJuryGiKOnBufMopsEb8bhoU8buz3yNP9y9/L8/
 R7YG3X3PL3Qj8YVcEhfOr+Bc6UMUUju6gfeyIr03OEmdTsEl5Gx0W2ThCi0llj/0zUk4
 BvSvpGlDC5jrf+2BwREplNXkYz9UqYz8Dqju25yZKGRR2pD4iru4diEjhHhuhvgKpBI5
 NNV5BlCBDbS826b3bbr9pDhemaCksrg8HmJFr1bzWL8JzrYi+eCr+Jz3LTxSY53cLE8r
 UZRVv9i2tndEJehD4RuMyuNprDpJerH1Hb6tYBUfwrbNKcxvBeRtd9W5zN+ddsh0Mf1U
 BTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775578516; x=1776183316;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+tc3JMD6SlPUG2e9Gpv05GHF8bR5d98yKHmmwddmA0=;
 b=cJF5Ahl5SHc2v8Y/A8W+oKc6XrxyfM1NznZxFVDKiioJ3YIcsqbThPBTjAReZT7fm/
 sZJZO/pgB5VdRsButAQkjh1nWinfY1rpr86wpKJ12tdv9cxhw43fsEdql2VzlRODepYB
 YBCp4jxvy0SRapnYt5nRvQBkEef/OXQQvwz4IoSPEESM/EG3IFHqe4BGis+yZPvCtW6k
 CbDgg8/8+ucIslM2CfNwgc7E/BO65p4kEnDM042NbAYFXfwgy3L98mefz4185Q5JYNH8
 6wmxRdjHczOVE+zba+FKzJT/ku+geHupd09CDSud2fQUHnVhhFfOOBK5iHbzQi7q4TxJ
 iqvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6kFqdrHjn4HdBk+t2NLpuj0ZVuv4FqjKkTw+v52vHrVbaXnlWpuqpb8CiyuXe46N1GIRr9/Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb7tSZ4WCIysufUcyYNIKR8BBhRJziZMV3YaZ7ilb0vuywVwpE
 QtJorSfQtph+tay4gbFouDlFkT5h7gqtEmuR/fIbJESMT9bdExKriV1x
X-Gm-Gg: AeBDietMadgDN/pI9cFssvrJ2LCszSWCJksg/uCr3szpKYEeRd6zMDAFp/UImxWa46d
 /pcQdnkP1IsNfMP6HV4r6t9UIC+yCsfsB8CEFLmpcuwNQyO0xcUaW5FA5KcWE3z6KuQieOUUl4i
 RAsMexVs1ymekFefE6MgndvY8y5c5tzd8+CZGSKmYvBn+g7MnTVgLwaptCjhCJiMC9DrBXgOv/9
 o9M2zrU3sJ2JAowwvoZ4BzbyxVPRxi1DOfcvvMxVnSBwXo8tMYwCdGznq++Def0IRMJ+NXT/Y6R
 oDyxfnUCcd2ble58kWXTfTxuKIHznh6bELYfOp30bvgnKserSLSQuDWq2EK94qUmn72mhEEp/dU
 i/dQEjb5eLfgaV1MNDbXYixNRnA2ShwqB0bCUPItIJWteLFYFZPAYoH1nd3cHzbfJIRAyXArwHJ
 alw8/PPA8RdiDnhI+9TRUg9jmWFmzbkX/anZOPxi1suSpA1Pmr0nKRJFjFamUiVARbmcN4WfVQ0
 hNnqnX1bQyBf1SA7RTt6fAQn/34a67rrhyQrivzF0HcdU3qMa4/6ubXWPZV9BMhuVjg4k4H1g==
X-Received: by 2002:a05:600c:4c28:b0:488:a82f:bbb0 with SMTP id
 5b1f17b1804b1-488a82fbd7bmr85006525e9.27.1775578515803; 
 Tue, 07 Apr 2026 09:15:15 -0700 (PDT)
Received: from franzs-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488b6ff70bcsm244300495e9.14.2026.04.07.09.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 09:15:14 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:15:13 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: openembedded-core@lists.openembedded.org, u-boot@lists.denx.de, 
 simon.glass@canonical.com, Francesco Dolcini <francesco@dolcini.it>
Subject: Host GnuTLS now needs pkcs11 support
Message-ID: <f5ov7deig7xaovxmtx3nhewki6mudgebahghknhxodlfa3lrdh@ary63d3fodkz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Apr 2026 23:23:52 +0200
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

Hello Wojciech,

with commit 0c716a157be ("tools: mkeficapsule: Add support for pkcs11"),
mkeficapsule now references to pkcs11 related symbols.

This breaks our OE builds because it causes link failures for 
configurations that build mkeficapsule when the host gnutls is 
built without pkcs11 support:
```
undefined reference to `gnutls_pkcs11_obj_list_import_url4'
undefined reference to `gnutls_x509_crt_import_pkcs11'
undefined reference to `gnutls_pkcs11_init'
undefined reference to `gnutls_pkcs11_add_provider'
undefined reference to `gnutls_pkcs11_deinit'
```
On the OE side, enabling support in gnutls via p11-kit fixes the failures.
However, I wonder what the cleanest solution would be. Should this new 
host requirement for pkcs11 be handled in the U-Boot OE recipe,  or is
there a better way to approach this correctly?

Any ideas?

Kind regards

Franz
