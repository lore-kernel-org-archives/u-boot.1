Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D10BC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F27682E67;
	Fri, 13 Jun 2025 19:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jVnOYx6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C8E082F28; Fri, 13 Jun 2025 19:23:18 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC8D82EA3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45300c82c1cso8717965e9.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835395; x=1750440195; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+7EVgiRFhn+tMm/E/1lnJn/oBZZ2nMcnZsTV4Ce7AAA=;
 b=jVnOYx6HeS4BeOiZb7PmNU5bNWtp5aLqyrQiZLwJMVG3pSxi3zabj0wzrhs8CTQJLx
 xsCfbS72Kd2E8qpYtpH5uMrOeh7QxbKTjCQnP013P8QebIS7tdcho6xgZ5Fc0++Etc55
 r6QT52sQfcTNUdwnz/a8/ZbYab+2+m44sMTImKnZQRm/QCBlJCGXlDCpo+bPXtShJzIc
 j8G0ThNasrdJiEZrp5qzopsi4ynMQEhyQ072pbgAiCDT/GGHHwDLIZUeOMnuTjm9Iq4W
 KX4qRn/N7e8dNeoLZR7S8ktqIBfLuDlEFkkfkGxobARODd+ThBfAihxVr7GTOGE11ZLO
 HV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835395; x=1750440195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7EVgiRFhn+tMm/E/1lnJn/oBZZ2nMcnZsTV4Ce7AAA=;
 b=u1rsLz0P16X2mVTbwIanOoTCuvLGexFB09xN7HMzd6XEfAA/QBpgHfA0E8sDIqz1B0
 6twwp2Yz22EFgp7x+2h24rc++/Q3sOJh6tn7G7ctdocEkL19HGpEKrXD82EGjboa0m9U
 l2mpAnuTLuJ0BD3zbfm19GxpnxrbgAMopBEMY4ldhT1Mu2pox6QQogon2EKD6yTCTn8S
 ZOA+weWark7iHdRXiJ+6vsiz6n1ogLaRGYAAHHx+ywTvfg47PrGHtxw06FFI+aeSL2d9
 712sG5yOU2UvjIEgsgdSulHkMXX/f9YM29GiIho31fHoEELBvNHOOdAYyqtHDPZvjoEF
 UTSQ==
X-Gm-Message-State: AOJu0Yz/F4iJo7D8q3RoxV6gla1Sv/HRdBZyQs1LHi742kFhocoBfDFt
 HS/SHZ48FdKdI3mutgKtZ0E2PT2A0kTJpk72msWtUQW1iOHWFtzrQnsC0nA+FWUsAMA=
X-Gm-Gg: ASbGnctR9EjpjNSee1Q4AaITBwNw7aw83hUBy0wwCvZdssAPCWytrFKRpFsm2bF+Gla
 ILM9b/1ydcLykB/JJyaM0aY1DAMODz+zbQEISSMaEL4RUDZ6BQHlFNd0M5dLAXdBzzOimgPAhLh
 M+JNxj2q2GaeNaOYzIkh1vp2fDJ8Z69qyNlPAOL2yWcqfVAKuVRII4fqpD09UEZZ5Jsjsk3vwSh
 NUqGd4JUstyModEPFcgmDPMlpWmMBYbFkpnD1Nohd5m12/qq1A2LFCT08DsRg6GZ9hEr79fivBq
 +LCB6rmY1XHx8jHdLutr8USRPJKdVGkVrhdEpXOKbcEdmaVV/UDssVgZsMN9XFmY6qvI
X-Google-Smtp-Source: AGHT+IGVZX4pfnO3T3Ln/mPT5dZlFlhTYjaILabj40G6VD4WxKjOkJheH9d5km7uNxGsFr3DzSZoRQ==
X-Received: by 2002:a05:600d:11a:b0:450:d5a5:e6c5 with SMTP id
 5b1f17b1804b1-4533ccbd60fmr1308605e9.26.1749835394662; 
 Fri, 13 Jun 2025 10:23:14 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:13 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:07 +0200
Subject: [PATCH v4 3/8] tools: qcom: introduce mkmbn library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-3-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24975;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=SuG9FN83tqj3j4aHmJoNqPnU+wNwe7XKVn/9KfxQ4HY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF56m3VMF3jo/NiY6Gbsak88+TCdbOIrDyObc
 Ep69HgGwY6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeegAKCRAFgzErGV9k
 tp8ID/0bYxa3VW7DEKFch8J8a3+vj0sZ6fVnvCWWeW4y1XsgIiVaFVwuGCHWQRGal4OP+XP88EM
 aOyTTATwOGlaLHTtw4KUx44gk/OctIoPWqHKWdHR2z1qtnq6stNkGrCxYMjdIaCsnLDf4jr2gif
 saNFf0MU6386kO4G3JgmqjSIlNIPdPF4MWXTB9jssePPKElG5ITQ5lZfq806Wxfv5rL3YQk9HHh
 ntLhhsXnxOrFMDxyFaQEHvWeFZBlZ40Whmk0oiihgvPCQcOhv9zowQQAeTzsLJ+L5H8lC2tZEko
 p6dXSBwwfkK9cwzI5Ifiy3XEraDSzTGB5NEHBlKsv85fmbBfuItSqDnt6MSIAWdTJLo90LG/hjK
 Y0FysftpHUGoAGhE8bq7lWBLZldnv2Vt474EtNnJlI3T5nBKHrYfkeBxb/jFXIH8qgIRZQrPIVe
 lSBO3/ahNtRevsJ7A8WO+5jkaqoUfSO7FemDwkrjSdAMzYofKbcR0Q9HNyf5t3XjV1s+/FIwkwQ
 2CKFcyHLUXb92WVz4iPv+2Jabopdod+KjbVRtI0pug8nkLmeKuQ9uEgg+PHnNP1d60Q6FwwJOHn
 PgEWdtkxetDtRav5ILYQNb7+J3y/7atdzvf+o+RsDIVwf1Jr7FZf1WhjJvQ7EoAst5DuyiBYWmK
 jyO9AUckfJkh4cg==
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
index 0000000000000000000000000000000000000000..e14f88746d53760d4e46367b78968b844afbe4cd
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
index 0000000000000000000000000000000000000000..9fac35cfd5d272a07ee56c3a2cebe36e6f9fbe4a
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
index 0000000000000000000000000000000000000000..e73f6e94e163dd1e45cc341f76cfebf55685ded8
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
2.49.0

