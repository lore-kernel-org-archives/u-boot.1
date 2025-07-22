Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E867C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2285833E9;
	Tue, 22 Jul 2025 17:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EEuFvrG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36A683886; Tue, 22 Jul 2025 17:35:13 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEB4833E9
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so40699545e9.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198510; x=1753803310; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7/tCWZrTBlHO+NrolnSm3nFiUKhdB2GDsALg2zxL/j4=;
 b=EEuFvrG19GXkdm0/5B9PVp+NPn+V+H2Vq2Og70NRM+PZMgZD86TFACC3nkspn4WVa5
 0BaQgQC3goWP104MHo020ko+Orw9au71eh4uEZSbVFHDDBGWdlzDcOporkROPgGXoaZM
 DZ8q7FGgQxQjB4AFrasHbFt42noCvS13ugfj1KYFNdGWB6+b2jgdngqD5eqRrdjEfeoa
 Hqm5WxncM43mQoOa3MbdLcFcbExTS3wzMjmd1NevvtjpdFFV735x3CBo12K2b9/CK1lg
 JMzIUdYlqbV/WLPFqFe+1NjnSG/66jbyXsggNPx/48D4cuP73fML2HCTprgtaXOnH5bn
 IDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198510; x=1753803310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/tCWZrTBlHO+NrolnSm3nFiUKhdB2GDsALg2zxL/j4=;
 b=B6D/2CGfY9Nsc3jMmY6za9+XHcF4txSmH3HFxAefo0lInP5Vn/iEEqLLrRlBgQ4W0x
 mQqrH+HKRAyU9/xGrrcIgpZkSfAOY0L4Y7nHfrdP0i93NrOYTcIxy6a8CEZgJCNH7zXG
 qlvrPIrIugRaGbdGyw1/wtFUzKvor3G0088s3GA5c6Xl4CWjvODL3oR3D3yTXkorOiDZ
 PovrkZ2LrKsmsBIqr4k0+vX1qsyS7ytFyDrs95GDrXYsb1wYDMwye7OMfo8lJAiAyMSK
 ZXIhzggodyCKn+eIjS8R6piBYkaJcfWKeOPWVH4FjX5R+UDHNzyhZlyq2NYdBjovWLIT
 elJw==
X-Gm-Message-State: AOJu0YxcaJAigXp9yQApQ4/StWLAGgjXtdGJkrQZLPjKRTm3KYuYXE2O
 aoQLo3FOckaaN4brwWRuHoI3+Qtlvie2QBXDWeFyRdWIeXfqU2qB4RAms3d7MnvVgnM=
X-Gm-Gg: ASbGncux0HPrR5RzL9YOS3DcoawWv9QB9E6fecUhN+zka17cnQ9MSycipehQvZJLubG
 ouzSKaC3S1S0l/jLlWR/OvIfNQ38jmmTpCf5fyouFpM5WVIvT4LS8vqAgqx6Xan7ubbmqZlBn3S
 +356LNyHU9gBg9ux5yGXCiOLhy7RunIimZLgkHCJwc9hC0fhW+BNNhQk3PZlSpnv9RqKzlYD+qe
 3+1Ay7B3xfLOngeP8cFClMG0QRA1q3f8saHQsMnaiIDnUcLYsHXa+IDeDFC/EiK5ubXhZ6mnH6d
 JnSTRaRO4zVs2PIr1aDbrJxPkR9tpl1+QpomUzTL0keUpHdbNtX2c0b2GZCODcTgeTQy2txB9pI
 6tGXAxbDo6czcZobzLcGKrnNImq5pPCA/NphjUi1YWfe/HFS5wAm6Sm15UgDcX3praQ==
X-Google-Smtp-Source: AGHT+IGAVbn5NcUWkr+dsQNVJeMGZEqBgAC4GNhJncUt8LOk1mlAwdgaoRD/3ctzVb3/Tz6ilFvrRQ==
X-Received: by 2002:a05:600c:4e03:b0:456:8eb:a35c with SMTP id
 5b1f17b1804b1-4562e38b16emr272729935e9.31.1753198510140; 
 Tue, 22 Jul 2025 08:35:10 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:09 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:53 +0200
Subject: [PATCH v5 3/8] tools: qcom: introduce mkmbn library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-3-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=24807;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5NFak/NshbMP4N/dhTy6xrOrz+WyKl2UhzdHEjOgzG8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69Stits91mK2jxjDHlvX8wbfpDO4u+9e2WemuCF6sq
 jr5iZtURykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIdAAjwzL9H3LtE9+lpfvf
 sHC+M3Fx8ZnvN4QXna259XwFN++bd2sY/tnN+MV3T4PzCZ9Dpttcf+4JZZM5d0xLcuMsTH/K3Zs
 seBUA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

From: Casey Connolly <casey.connolly@linaro.org>

This is a fork of qtestsign[1] with modifications to integrate with the
U-Boot build system. It is pulled from

ce6ba20f4ead ("Add experimental patchxbl script")

New Qualcomm dev boards flash U-Boot to the "uefi" partition, the format
is a standard ELF file with custom program headers containing Qualcomm
signatures, hashes and other metadata.

Since different boards require different load addresses, the traditional
CONFIG_REMAKE_ELF with CONFIG_TEXT_BASE requires introducing a new
defconfig for each platform, even though the binary is otherwise
identical.

This library will be used by a new mkmbn.py tool to create MBN files
which can be directly flashed to the board.

[1]: https://github.com/msm8916-mainline/qtestsign

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 tools/qcom/mkmbn/cert.py    | 127 ++++++++++++++++++++
 tools/qcom/mkmbn/elf.py     | 202 +++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/hashseg.py | 281 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 610 insertions(+)

diff --git a/tools/qcom/mkmbn/cert.py b/tools/qcom/mkmbn/cert.py
new file mode 100644
index 000000000000..e14f88746d53
--- /dev/null
+++ b/tools/qcom/mkmbn/cert.py
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2021-2022 Stephan Gerhold
+# See https://www.qualcomm.com/media/documents/files/secure-boot-and-image-authentication-technical-overview-v1-0.pdf
+# Somewhat based on code snippets from https://cryptography.io/en/latest/x509/tutorial.html
+from __future__ import annotations
+
+from datetime import datetime
+from typing import List
+
+from cryptography import x509
+from cryptography.hazmat.primitives import hashes, serialization
+from cryptography.x509.oid import NameOID
+
+# NOTE: The certificate chain generated by qtestsign is NOT meant
+# to be secure. The private keys are listed here to make the
+# resulting files reproducible. THESE KEYS SHOULD ONLY BE USED
+# FOR TESTING AND NOT FOR A PROPER SECURE BOOT SETUP.
+
+ROOT_KEY = serialization.load_pem_private_key(b"""
+-----BEGIN PRIVATE KEY-----
+MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCjZqF/BwggY4Rs
+Q1/wSNPLEKQEROZ9i/d+7CXZCukWph+SKHlv652oiAp+TgzIGQQXDlaA+qUoXUjp
+g2KTmoulfQjrgc5CSCk6yA01VxNBqR81JorJx8aD9ApOFVoERlmWhZcR3B/LsVyd
+vYgwFNNkqUh7fyywyy1Z1ijk4SyJVak1VxfdkTTeb1wr5Awjvh82PrdRQfOvctFH
+mVITqdMckdRD3Sx7y8EvypAYpAUiWklNgditetXFjMoV6XyXTPCRkH9zzskrXP6i
+neCyS7xUfEYPYNpabzhpdvkx9Is2PlCJA1fZ1ERZsWcag5vDZa3SHslH5Kh9+ssH
+ps0Ul1j5AgMBAAECggEAHUEzOdBy+oWGwHFhnF4VmT4t91u0npawJYe3EQBckgMF
+FQBtGYYoMHPG2S01KaAc9NnK0AXQCwWEl9Y/kGizhtn3fl67pG9R/mWxw7KGzpMu
+dLAlWhIL7zUCoU8+UhScVpAtZ3OvN6NWDyHPX7hizptmUEIJKM//mx12LeBIvn+P
+8tSiBXxoDGl0JZ+QMzmshOUXLLnxKITgBGL+G9A1qTZHIs6VV7HWH1ptfObulBZf
+yEBK1YBzI6GnBGzLOWnZqGsSbQ717SObQo5rCoRDZB7z4bXNWDEvuH+rqzcs5liu
+af4gmBHNOLGh+Ta5HJ0XeoqU5ANOWlUi95/n2dJufwKBgQDNaMlT1937SHPv/eBq
+Be3MobllTx4vMYh6CtfP8QozTE+sTcmCyvaWVfXwLnQTl//+siefoWsvzW43LaNU
+3A18nCxVFSSbWosBN+0Zo4K9bSpEFGgUrJM5O98zv4+/SzCKFe2562usDzaRiEUW
+iSJkzIUnSlcNc+XCY1rhG9HLXwKBgQDLpS6ATtMDSP9p+XYVMEN2CF8M3xvL	roOT
+6wPYfp9fuagMgzNv9GB9SRyM/dM6mN+fkBqLp3EbDZT0UorHsg+YChoyBmctNqpW
+j5/SrVyYe2xoRRgOzUbDstN44/LAhJLQnOXB7S2amo35zZ4FY6sw2w3QfkCildkB
+mY3VhvESpwKBgErLtUPKfxJZN55UG7t/nS++U/wH6z3UE5YdDKizZLt5NinPyWjO
+7yue8Ycb4zifSKA9zx/Zb2Zgr5l4DNmBp4eQdrQklsfbGHLBIp0LZTgE4DcaFyww
+Cwv0OTpmrrlBb9NYWNAyYWqtv3kO3dlu5g8+Sd4cu8YyRZ+a/iSqNKKRAoGBAIPf
+QICYCq8a60Lt5xiLe3QIsbx9EdvQ86Wqz3+3Z28uo3MO1xVNc9pNqO5oRAuzCUSj
+pXz//g9duTKJ7RKp7M0w5Yu1d8TgnGeXdBCScN7RNf9DlvOm3IdH2wdy3TTr5MKw
+h1wQQbLXGM9F5mlpBGeLwqNbznE6hh8yF5XJX30LAoGBAJqaa+yeZskti5ickNTF
+vBBIXyYYBymdxfkf9vDSW1XcZEIVqo3+AGV+qHyTjURaty3QuEhSJEXem/obH5uE
+y37+bnx8Se1IyJ/phYBLwOmtgZoBJALFhvjkFiGTF6naI8E/i4sbi5j/OEyShfWr
+YFZuEKQJhiiMQznfNgthHU6H
+-----END PRIVATE KEY-----
+""", password=None)
+
+ATT_KEY = serialization.load_pem_private_key(b"""
+-----BEGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDT449phHltY2aV
+QIvaT4PUgNS7wDybnnjVO88NGB5PjfUaWY99oDQgOLJlejyVVqRO2wHxLaUMsbuc
+oe0XbgSFJgrnGvG6yPbjSXeIfV5k2dJG60S4Fg2mZ1ieSabuPVKLA03frhbATmIf
+Q+VTMlWLgLVxcT04iqph6VpjehnYke0VPMuN7OM6RsIOEhLcje0bvL4YjTYXH5j4
+mPquc/ZEj/n6WJ6VsS27QygOBbaiGqHs54QnQi4gcgIgUmkR/bl2wL5s+729RBzS
+v1FZfA5gdM9uEG3ogLHOC2uk+1Nuqcdk/tQxd30/2ulXubqDku/nNY2RSJrwD	att
+qcyCliANAgMBAAECggEAK3Z7HVbKHZENIsJZrY8v6HAAsv5ssDMicALTpsjytrjU
+tPH4B/nLl2xp03zuXmemTnKIBHOrbl4qsKdaXbr4fGNgSyVwvjKoydhxB3NH4IH5
+qwhpUSVc6Ww7dkR/VFEJ1G/6Ek7AZfPuFqGzsYwalgHxtfJXb3iqGGloXA1Yrd5p
+W2cTEhtSFZP/PQIEK773wYd3aYMw8OCqG2V5bw9N3xwY6KTC0Px8zyBlmAcUBPAj
+QZL/DTGlMdD9+PJ3Ft3Zl2uS7ORn7xfXftvxv5IQdD+JBxV5zUIympKK/7KIVUfH
+dfi93R7rqjL9EOP6bVQkg/WzYRLeVf/8km8HRGqtIQKBgQDxFxQ77t4EQqLPFofN
+oRV7P3lvFqlJDTzAGBnjIT/ujT3SgoFUjRtfG27nWd1lycxv3tE0GTIw0LjJwvmg
+VSFbQbPsmdp+f0jnNIiJayiG591j9Afmw06mnDodaQuSTp7K9idgpnFRGDQzwJHK
+0DwSQzlzEXsPhGnXxpv+2Q+ANQKBgQDg/itVFBw3e5wC8boffi1AgnM97Qa/Y+5B
+I2J9+cZD9iBkvE7kTwVUOI2Rr+XkQmSf+pT6L0yFXhQjIed004rpKVqzTvGL9VXJ
+nBeADS4bxl1jsfkfvq9e6eNUK8vzyLoYQpS5/LK1oG5MPq3+30yzGIHM8JxxaOQ9
+VdKQrUdLeQKBgAh35RAN3eKMbKeVhQOmCtkfa6aJRzz3qBCfSBmAS3yXnXpNdzl/
+E10N26FouKwgoHu1eee4ktjAHB2KKbaGBvvrnORMqy4STn9AiyM4jl3euxoNslFa
+vuJ/TlNGI0/qTw2WA+ATOJu+m+bNdtGG6vVBQz1VedsbrZQUt9oFydOZAoGAMlCk
+4CHfLYk3GnF0bhaJiCOkIfUfzS1L2sVPAV0aOZiRJfX2rpf9WRhMkIgFoUY3uo8P
+QePR+QFQ/4pVeIrWRc45ul+tJN94j92YY8qOxSdXOzRRwgeisFcdv3UL5zi8ZTB+
+khkw3e1CvUpHHvhQ7rxMSsiEM9iBMjY/IJuflgECgYEAqiN3eg8cZjVrYEMcPLGx
+wXknCG0KPc8EpDi1moNwS3z/TcUbfP8vnmT2lFHTAbvVBn+4fcLffkQBoGG3AaSH
+3kc0HXLdy+rFcsXpX7hk9BM/Uey9dqBOAusLS6XxYhcAJ1xOI0kYWoeOhO8fcjNa
+tf26cJGzfbbwf8kfisbv4Uk=
+-----END PRIVATE KEY-----
+""", password=None)
+
+
+def _begin_cert() -> x509.CertificateBuilder:
+	return x509.CertificateBuilder() \
+		.serial_number(1) \
+		.not_valid_before(datetime(2023, 1, 1)) \
+		.not_valid_after(datetime(9999, 12, 31, 23, 59, 59))  # no well-defined expiration date, see RFC5280 4.1.2.5.
+
+
+def generate_chain(ou_fields: List[str]) -> bytes:
+	# First, create the root CA
+	root_name = x509.Name([
+		x509.NameAttribute(NameOID.COMMON_NAME, "qtestsign Root CA - NOT SECURE"),
+	])
+	# only key_cert_sign=True
+	root_usage = x509.KeyUsage(False, False, False, False, False, True, False, False, False)
+	root_ski = x509.SubjectKeyIdentifier.from_public_key(ROOT_KEY.public_key())
+	root_cert_der = _begin_cert() \
+		.subject_name(root_name) \
+		.issuer_name(root_name) \
+		.public_key(ROOT_KEY.public_key()) \
+		.add_extension(x509.BasicConstraints(ca=True, path_length=0), critical=True) \
+		.add_extension(root_usage, critical=True) \
+		.add_extension(root_ski, critical=False) \
+		.sign(ROOT_KEY, hashes.SHA256()) \
+		.public_bytes(serialization.Encoding.DER)
+
+	# Now, create the attestation certificate
+	att_name = x509.Name([
+		x509.NameAttribute(NameOID.COMMON_NAME, "qtestsign Attestation CA - NOT SECURE"),
+		*[x509.NameAttribute(NameOID.ORGANIZATIONAL_UNIT_NAME, ou) for ou in ou_fields],
+	])
+	# only digital_signature=True
+	att_usage = x509.KeyUsage(True, False, False, False, False, False, False, False, False)
+	att_cert_der = _begin_cert() \
+		.subject_name(att_name) \
+		.issuer_name(root_name) \
+		.public_key(ATT_KEY.public_key()) \
+		.add_extension(x509.BasicConstraints(ca=False, path_length=None), critical=True) \
+		.add_extension(att_usage, critical=True) \
+		.add_extension(x509.SubjectKeyIdentifier.from_public_key(ATT_KEY.public_key()), critical=False) \
+		.add_extension(x509.AuthorityKeyIdentifier.from_issuer_subject_key_identifier(root_ski), critical=False) \
+		.sign(ROOT_KEY, hashes.SHA256()) \
+		.public_bytes(serialization.Encoding.DER)
+
+	# The certificate chain is the attestation and root certificate concatenated
+	# in DER format. Note: The order (first attestation, then root) is important!
+	return att_cert_der + root_cert_der
diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
new file mode 100644
index 000000000000..9fac35cfd5d2
--- /dev/null
+++ b/tools/qcom/mkmbn/elf.py
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2021 Stephan Gerhold
+# Data classes are based on the header definitions in the ELF(5) man page.
+# Also see: https://en.wikipedia.org/wiki/Executable_and_Linkable_Format
+from __future__ import annotations
+
+import dataclasses
+from dataclasses import dataclass
+from struct import Struct
+from typing import List, BinaryIO
+
+
+@dataclass
+class Ehdr:
+	ei_magic: bytes
+	ei_class: int
+	ei_data: int
+	ei_version: int
+	ei_os_abi: int
+	ei_abi_version: int
+	e_type: int
+	e_machine: int
+	e_version: int
+	# Address size specific part
+	e_entry: int = 0
+	e_phoff: int = 0
+	e_shoff: int = 0
+	# End part
+	e_flags: int = 0
+	e_ehsize: int = 0
+	e_phentsize: int = 0
+	e_phnum: int = 0
+	e_shentsize: int = 0
+	e_shnum: int = 0
+	e_shstrndx: int = 0
+
+	START_FORMAT = Struct('<4s5B7xHHL')
+	START_COUNT = 9
+	MEM_FORMAT32 = Struct('<LLL')
+	MEM_FORMAT64 = Struct('<QQQ')
+	MEM_COUNT = 3
+	END_FORMAT = Struct('<L6H')
+	END_COUNT = 7
+
+	CLASS32 = 1
+	CLASS64 = 2
+
+	@staticmethod
+	def parse(b: bytes) -> Ehdr:
+		hdr_unpack = Ehdr.START_FORMAT.unpack_from(b)
+		hdr = Ehdr(*hdr_unpack)
+		assert hdr.ei_magic == b'\x7fELF', f"Invalid ELF header magic: {hdr.ei_magic}"
+		assert hdr.ei_data == 1, "Only little endian supported at the moment"
+		assert hdr.ei_version == 1, f"Unexpected ei_version: {hdr.ei_version}"
+		assert hdr.e_version == 1, f"Unexpected e_version: {hdr.e_version}"
+
+		if hdr.ei_class == Ehdr.CLASS32:
+			mem_format = Ehdr.MEM_FORMAT32
+		else:
+			assert hdr.ei_class == Ehdr.CLASS64, f"Unexpected ei_class: {hdr.ei_class}"
+			mem_format = Ehdr.MEM_FORMAT64
+
+		mem_unpack = mem_format.unpack_from(b, Ehdr.START_FORMAT.size)
+		end_unpack = Ehdr.END_FORMAT.unpack_from(b, Ehdr.START_FORMAT.size + mem_format.size)
+		return Ehdr(*hdr_unpack, *mem_unpack, *end_unpack)
+
+	def save(self, f: BinaryIO) -> int:
+		unpack = dataclasses.astuple(self)
+		written = f.write(Ehdr.START_FORMAT.pack(*unpack[:Ehdr.START_COUNT]))
+
+		if self.ei_class == Ehdr.CLASS32:
+			mem_format = Ehdr.MEM_FORMAT32
+		else:
+			mem_format = Ehdr.MEM_FORMAT64
+		written += f.write(
+			mem_format.pack(*unpack[Ehdr.START_COUNT:Ehdr.START_COUNT + Ehdr.MEM_COUNT]))
+		written += f.write(Ehdr.END_FORMAT.pack(*unpack[-Ehdr.END_COUNT:]))
+		return written
+
+
+@dataclass
+class Phdr:
+	p_type: int
+	p_offset: int
+	p_vaddr: int
+	p_paddr: int
+	p_filesz: int
+	p_memsz: int
+	p_flags: int
+	p_align: int
+
+	data = None
+
+	FORMAT32 = Struct('<8L')
+	FORMAT64 = Struct('<LL6Q')
+
+	@staticmethod
+	def parse(b: bytes, offset: int, ei_class: int) -> Phdr:
+		if ei_class == Ehdr.CLASS32:
+			unpack = Phdr.FORMAT32.unpack_from(b, offset)
+		else:
+			unpack = list(Phdr.FORMAT64.unpack_from(b, offset))
+
+			# ELFCLASS64 has flags directly before offset for alignment
+			flags = unpack.pop(1)
+			unpack.insert(-1, flags)
+
+		return Phdr(*unpack)
+
+	def save(self, f: BinaryIO, ei_class: int) -> int:
+		unpack = dataclasses.astuple(self)
+
+		if ei_class == Ehdr.CLASS32:
+			return f.write(Phdr.FORMAT32.pack(*unpack))
+		else:
+			unpack = list(unpack)
+
+			# ELFCLASS64 has flags directly before offset for alignment
+			flags = unpack.pop(-2)
+			unpack.insert(1, flags)
+
+			return f.write(Phdr.FORMAT64.pack(*unpack))
+
+
+def _pad(f: BinaryIO, offset: int, pos: int) -> int:
+	assert offset >= pos, f"{offset} >= {pos}"
+	pad = offset - pos
+	if pad:
+		assert f.write(b'\0' * pad) == pad
+	return offset
+
+
+def _align(i: int, alignment: int) -> int:
+	mask = max(alignment - 1, 0)
+	return (i + mask) & ~mask
+
+
+@dataclass
+class Elf:
+	ehdr: Ehdr
+	phdrs: List[Phdr]
+
+	def total_header_size(self):
+		return self.ehdr.e_phoff + len(self.phdrs) * self.ehdr.e_phentsize
+
+	@staticmethod
+	def parse(b: bytes) -> Elf:
+		ehdr = Ehdr.parse(b)
+		view = memoryview(b)
+
+		# Parse program headers
+		phdrs = []
+		offset = ehdr.e_phoff
+		for i in range(ehdr.e_phnum):
+			phdr = Phdr.parse(b, offset, ehdr.ei_class)
+			phdrs.append(phdr)
+
+			# Store data if necessary
+			if phdr.p_filesz and phdr.p_offset:
+				phdr.data = view[phdr.p_offset:phdr.p_offset + phdr.p_filesz]
+
+			offset += ehdr.e_phentsize
+
+		return Elf(ehdr, phdrs)
+
+	def update(self):
+		# Rearrange all segments according to their alignment
+		pos = self.total_header_size()
+		for phdr in sorted(self.phdrs, key=lambda phdr: phdr.p_offset):
+			if phdr.p_offset and phdr.p_filesz:
+				phdr.p_offset = _align(pos, phdr.p_align)
+				pos = phdr.p_offset + phdr.p_filesz
+
+		# Ensure program header count is correct
+		self.ehdr.e_phnum = len(self.phdrs)
+
+		# TODO: Clear out sections for now. Those are not read at the moment.
+		# Also, I don't think the Qualcomm firmware loader has any use for these.
+		self.ehdr.e_shoff = 0
+		self.ehdr.e_shnum = 0
+		self.ehdr.e_shstrndx = 0
+
+	def save_header(self, f: BinaryIO) -> int:
+		pos = self.ehdr.save(f)
+		pos = _pad(f, self.ehdr.e_phoff, pos)
+
+		# Write program headers
+		for phdr in self.phdrs:
+			pos += phdr.save(f, self.ehdr.ei_class)
+
+		return pos
+
+	def save(self, f: BinaryIO) -> int:
+		pos = self.save_header(f)
+
+		# Write segment data
+		for phdr in sorted(self.phdrs, key=lambda phdr: phdr.p_offset):
+			if phdr.data:
+				pos = _pad(f, phdr.p_offset, pos)
+				pos += f.write(phdr.data)
+
+		return pos
diff --git a/tools/qcom/mkmbn/hashseg.py b/tools/qcom/mkmbn/hashseg.py
new file mode 100644
index 000000000000..e73f6e94e163
--- /dev/null
+++ b/tools/qcom/mkmbn/hashseg.py
@@ -0,0 +1,281 @@
+# SPDX-License-Identifier: GPL-2.0-only AND BSD-3-Clause
+# Copyright (C) 2021-2023 Stephan Gerhold (GPL-2.0-only)
+# MBN header format adapted from:
+#   - signlk: https://git.linaro.org/landing-teams/working/qualcomm/signlk.git
+#   - coreboot (util/qualcomm/mbn_tools.py)
+# Copyright (c) 2016, 2018, The Linux Foundation. All rights reserved. (BSD-3-Clause)
+# See also:
+#   - https://www.qualcomm.com/media/documents/files/secure-boot-and-image-authentication-technical-overview-v1-0.pdf
+#   - https://www.qualcomm.com/media/documents/files/secure-boot-and-image-authentication-technical-overview-v2-0.pdf
+from __future__ import annotations
+
+import dataclasses
+import hashlib
+from dataclasses import dataclass
+from io import BytesIO
+from struct import Struct
+
+from . import cert
+from . import elf
+
+# A typical Qualcomm firmware might have the following program headers:
+#     LOAD off    0x00000800 vaddr 0x86400000 paddr 0x86400000 align 2**11
+#          filesz 0x00001000 memsz 0x00001000 flags rwx
+#
+# The signed version will then look like:
+#     NULL off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**0
+#          filesz 0x000000e8 memsz 0x00000000 flags --- 7000000
+#     NULL off    0x00001000 vaddr 0x86401000 paddr 0x86401000 align 2**12
+#          filesz 0x00000988 memsz 0x00001000 flags --- 2200000
+#     LOAD off    0x00002000 vaddr 0x86400000 paddr 0x86400000 align 2**11
+#          filesz 0x00001000 memsz 0x00001000 flags rwx
+#
+# The second NULL program header with off 0x1000 and filesz 0x988 is the actual
+# "hash table segment" or shortly "hash segment" (see Figure 2 on page 6 in the PDF).
+# It contains the MBN header specified below, then a couple of hashes (e.g. SHA256):
+#   1. Hash of ELF header and program headers
+#   2. Empty hash for hash segment
+#   3. Hashes for data of each memory segment (described by program header)
+# Finally, it contains an RSA signature and the concatenated certificate chain.
+#
+# The first NULL program header is never loaded anywhere, because
+# vaddr = paddr = memsz = 0. However, the "off" and "filesz" cover exactly
+# the ELF header (including all program headers). It is a placeholder so that
+# each hash covers the data of exactly one program header.
+
+PHDR_FLAGS_HDR_PLACEHOLDER = 0x7000000  # placeholder for hash over ELF header
+PHDR_FLAGS_HASH_SEGMENT = 0x2200000  # hash table segment
+
+EXTRA_PHDRS = 2  # header placeholder + hash segment
+
+# Note: None of the alignments seem to be truly required,
+# this could probably be reduced to get smaller file sizes.
+HASH_SEG_ALIGN = 0x1000
+CERT_CHAIN_ALIGN = 16
+
+# According to the v2.0 PDF the metadata is 128 bytes long, but this does not
+# seem to work. All official firmware seems to use 120 bytes instead.
+METADATA_SIZE = 120
+
+
+def _align(i: int, alignment: int) -> int:
+	mask = max(alignment - 1, 0)
+	return (i + mask) & ~mask
+
+
+@dataclass
+class _HashSegment:
+	image_id: int = 0  # Type of image (unused?)
+	version: int = 0  # Header version number
+
+	hash_size = 0
+	signature_size = 0
+	cert_chain_size = 0
+	total_size = 0
+
+	hashes = []
+	signature = b''
+	cert_chain = b''
+
+	FORMAT = Struct('<10L')
+	Hash = hashlib.sha256
+
+	@property
+	def size_with_header(self):
+		return self.FORMAT.size + self.total_size
+
+	def update(self, dest_addr: int):
+		self.hash_size = len(self.hashes) * self.Hash().digest_size
+		self.signature_size = len(self.signature)
+		self.cert_chain_size = len(self.cert_chain)
+		self.total_size = self.hash_size + self.signature_size + self.cert_chain_size
+
+	def check(self):
+		assert len(self.hashes) * self.Hash().digest_size == self.hash_size
+		assert len(self.signature) == self.signature_size
+		assert len(self.cert_chain) == self.cert_chain_size
+
+	def pack_header(self):
+		self.check()
+		return self.FORMAT.pack(*dataclasses.astuple(self))
+
+	def pack(self):
+		return self.pack_header() \
+			+ b''.join(self.hashes) \
+			+ self.signature + self.cert_chain
+
+
+@dataclass
+class HashSegmentV3(_HashSegment):
+	version: int = 3  # Header version number
+
+	flash_addr: int = 0  # Location of image in flash (historical)
+	dest_addr: int = 0  # Physical address of loaded hash segment data
+	total_size: int = 0  # = hash_size + signature_size + cert_chain_size
+	hash_size: int = 0  # Size of hashes for all program segments
+	signature_addr: int = 0  # Physical address of loaded attestation signature
+	signature_size: int = 0  # Size of attestation signature
+	cert_chain_addr: int = 0  # Physical address of loaded certificate chain
+	cert_chain_size: int = 0  # Size of certificate chain
+
+	def update(self, dest_addr: int):
+		super().update(dest_addr)
+		self.dest_addr = dest_addr + self.FORMAT.size
+		self.signature_addr = self.dest_addr + self.hash_size
+		self.cert_chain_addr = self.signature_addr + self.signature_size
+
+
+@dataclass
+class HashSegmentV5(_HashSegment):
+	version: int = 5  # Header version number
+
+	signature_size_qcom: int = 0  # Size of signature from Qualcomm
+	cert_chain_size_qcom: int = 0  # Size of certificate chain from Qualcomm
+	total_size: int = 0  # = hash_size + signature_size + cert_chain_size
+	hash_size: int = 0  # Size of hashes for all program segments
+	signature_addr: int = 0xffffffff  # unused?
+	signature_size: int = 0  # Size of attestation signature
+	cert_chain_addr: int = 0xffffffff  # unused?
+	cert_chain_size: int = 0  # Size of certificate chain
+
+	signature_qcom = b''
+	cert_chain_qcom = b''
+
+	def update(self, dest_addr: int):
+		super().update(dest_addr)
+		self.signature_size_qcom = len(self.signature_qcom)
+		self.cert_chain_size_qcom = len(self.cert_chain_qcom)
+		self.total_size += self.signature_size_qcom + self.cert_chain_size_qcom
+
+	def check(self):
+		super().check()
+		assert len(self.signature_qcom) == self.signature_size_qcom
+		assert len(self.cert_chain_qcom) == self.cert_chain_size_qcom
+
+	def pack(self):
+		return self.pack_header() \
+			+ b''.join(self.hashes) \
+			+ self.signature_qcom + self.cert_chain_qcom \
+			+ self.signature + self.cert_chain
+
+
+@dataclass
+class HashSegmentV6(HashSegmentV5):
+	version: int = 6  # Header version number
+
+	metadata_size_qcom: int = 0  # Size of metadata from Qualcomm
+	metadata_size: int = 0  # Size of metadata
+
+	metadata_qcom = b''
+	metadata = b''
+
+	FORMAT = Struct('<12L')
+	Hash = hashlib.sha384
+
+	def update(self, dest_addr: int):
+		super().update(dest_addr)
+		self.metadata_size_qcom = len(self.metadata_qcom)
+		self.metadata_size = len(self.metadata)
+		self.total_size += self.metadata_size_qcom + self.metadata_size
+
+	def check(self):
+		super().check()
+		assert len(self.metadata_qcom) == self.metadata_size_qcom
+		assert len(self.metadata) == self.metadata_size
+
+	def pack(self):
+		return self.pack_header() \
+			+ self.metadata_qcom + self.metadata \
+			+ b''.join(self.hashes) \
+			+ self.signature_qcom + self.cert_chain_qcom \
+			+ self.signature + self.cert_chain
+
+
+HashSegment = {
+	3: HashSegmentV3,
+	5: HashSegmentV5,
+	6: HashSegmentV6,
+}
+
+
+def drop(elff: elf.Elf):
+	# Drop existing hash segments
+	elff.phdrs = [phdr for phdr in elff.phdrs if phdr.p_type != 0 or phdr.p_flags not in
+				  [PHDR_FLAGS_HASH_SEGMENT, PHDR_FLAGS_HDR_PLACEHOLDER]]
+
+
+def generate(elff: elf.Elf, version: int, sw_id: int):
+	drop(elff)
+	assert elff.phdrs, "Need at least one program header"
+
+	hash_seg = HashSegment[version]()
+
+	if version >= 6:
+		# TODO: Figure out metadata format and fill this with useful data
+		hash_seg.metadata = b'\0' * METADATA_SIZE
+
+	# Generate hash for all existing segments with data
+	digest_size = hash_seg.Hash().digest_size
+	hash_seg.hashes = [b'\0' * digest_size] * (len(elff.phdrs) + EXTRA_PHDRS)
+	for i, phdr in enumerate(elff.phdrs, start=EXTRA_PHDRS):
+		if phdr.data:
+			hash_seg.hashes[i] = hash_seg.Hash(phdr.data).digest()
+	total_hashes_size = len(hash_seg.hashes) * digest_size
+
+	# Generate certificate chain with specified OU fields (for < v6)
+	# on >= v6 this is part of the metadata instead
+	ou_fields = []
+	if version < 6:
+		ou_fields = [
+			# Note: The SW_ID is checked by the firmware on some platforms (even if secure boot
+			# is disabled), so it must match the firmware type being signed. Everything else seems
+			# to be mostly ignored when secure boot is off and is just added here to match the
+			# documentation and better mimic the official firmware.
+			"01 %016X SW_ID" % sw_id,
+			"02 %016X HW_ID" % 0,
+			"03 %016X DEBUG" % 2,  # DISABLED
+			"04 %04X OEM_ID" % 0,
+			"05 %08X SW_SIZE" % (hash_seg.FORMAT.size + total_hashes_size),
+			"06 %04X MODEL_ID" % 0,
+			"07 %04X SHA256" % 1,
+		]
+	hash_seg.cert_chain = cert.generate_chain(ou_fields)
+	hash_seg.cert_chain = hash_seg.cert_chain.ljust(_align(len(hash_seg.cert_chain), CERT_CHAIN_ALIGN), b'\xff')
+	# hash_seg.cert_chain = b''  # uncomment this to omit the certificate chain in the signed image
+
+	# TODO: Generate actual signature with our generated attestation certificate!
+	# There are different signature schemes that could be implemented (RSASSA-PKCS#1 v1.5
+	# RSASSA-PSS, ECDSA over P-384) but it's not entirely clear yet which chipsets supports/
+	# uses which. The signature does not seem to be checked on devices without secure boot,
+	# so just use a dummy value for now.
+	hash_seg.signature = b'\xff' * (cert.ATT_KEY.key_size // 8)
+	# hash_seg.signature = b''  # uncomment this to omit the signature in the signed image
+
+	# Align maximum end address to get address for hash table header, then update header
+	hash_addr = _align(max(phdr.p_paddr + phdr.p_memsz for phdr in elff.phdrs), HASH_SEG_ALIGN)
+	hash_seg.update(hash_addr)
+	print(hash_seg)
+
+	# Insert new hash NULL segment
+	hash_phdr = elf.Phdr(0, HASH_SEG_ALIGN, hash_addr, hash_addr, hash_seg.size_with_header,
+						 _align(hash_seg.size_with_header, HASH_SEG_ALIGN),
+						 PHDR_FLAGS_HASH_SEGMENT, HASH_SEG_ALIGN)
+	elff.phdrs.insert(0, hash_phdr)
+
+	# Insert new ELF header placeholder program header
+	hdr_hash_phdr = elf.Phdr(0, 0, 0, 0, 0, 0, PHDR_FLAGS_HDR_PLACEHOLDER, 0)
+	elff.phdrs.insert(0, hdr_hash_phdr)
+
+	# Now determine size of ELF header (including program headers)
+	hdr_hash_phdr.p_filesz = elff.total_header_size()
+
+	# Recompute attributes to match final output (e.g. adjust e_phnum)
+	elff.update()
+
+	# Compute the hash for the ELF header
+	with BytesIO() as hdr_io:
+		elff.save_header(hdr_io)
+		hash_seg.hashes[0] = hash_seg.Hash(hdr_io.getbuffer()).digest()
+
+	# And finally, assemble the hash segment
+	hash_phdr.data = hash_seg.pack()

-- 
2.50.1

