Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030B0C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A8584979;
	Mon,  6 Jul 2026 14:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tm8iQdA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB74A8497A; Mon,  6 Jul 2026 14:37:18 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E96846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3995e22ef81so32738981fa.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783341435; x=1783946235; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MpCxnG9/Cc2VoqXXZNogHuiXYhX/FCit55ucXTNkPw=;
 b=tm8iQdA9lN4aw+0wQRnNcCGdqaP0uvBw0UxW5UADlmRLDOPYxMchOcCM03Hi6GMgoK
 VXUpdBUP/PciL6c9LdbTEPxu0RDiv/iQ/keb3I7UQnTrgYGojdWHSElEIME69GcDs4IR
 DSLMv+8ulz1WRmLyl1MA/R/Chl8BEexH/fbOfIb1DHfeP0bf6btf47mPQTqrg59AKW62
 5HxwqsVPgzWNKGtEhL0zP3hLE6sUCYilO+Zphts2bn8+jpc3fY7lnNahhnHPJt0zmxYA
 TXXdc8bsmBOmkmhRjktbtSOqyKVOl7LtuyJR9vTFHrxh4kRZ1wCpW524HMLtZ91iC7me
 MZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341435; x=1783946235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7MpCxnG9/Cc2VoqXXZNogHuiXYhX/FCit55ucXTNkPw=;
 b=VVFw58JjRhqGP+YEIbdiFjs1M424XDZ6VgM3LxfHBfljsDGN0nDc1VTqEdp0beiwHY
 EOYugFuAcr6SDd0dHeaCWBDLiQJVwIBdvt38iBRKaxVaV6HzTjMzK88ExqlhLO21aDy5
 XEFYFpV2Pvt51uJ/C6mmGJ1449WYVOu5nypKsmqmZU8v4SoVTpGvCZuRj6sXleiaMPo5
 GFF0q61vd9rGiWuIWBoNWL8CCsMVqwEKvdWXuglKxGq6uXcWYvW36skTfMjdgFbrXEpT
 EcuqOkN9/cRTmecVIOgEH9HcoS7G+wvW+ASjH8WUnXwkjlj4vG1fqulXma/7drpu+33z
 TmaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrW7ZrOByrDu8nv9Aqdt8CqZW64LcCZmBAagCJFclUaM0Tunj2bbNNoqjnHpa/Jb4F3KGX2j7k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3vf4zDotMECc1D9/UBJTuMSVb7EcBtz1xkkcOvFuJrwlXNaxI
 8fTi8WrXarPX8sNBQZpjZy1A5tIWwUqwT52vKXQChglTcSVMopQe7gXwxuMFnLe2zxs=
X-Gm-Gg: AfdE7ckZplVJmrT7oppJLZu5+bTzOrGfVG5hwlgeSWZujuG4esSnnc5wH98UkPscIgF
 +FmzXK8gAwM220zsYJ7byz0g7tt7hNPZ7xSfqLBybwzRpA+zSO8n8f+hpySva+YVjxwylmTXVmy
 1UCC/U5wn6GMI7meizt5lpmaEywjFlg29z3apT2y9RAg+eKuq363vvzxcD3aAV8fUh+s6rfrz2Z
 XUoq5VxU7TpAizZaVzlkDiJdUBLGQKEvp7coK52LpWrXrc4ZGyVAXavugOQKDl7e4EAGyLjLoqI
 yPexQRq9J5IgTLJRkNk28/JikzPc8f+fnvWmu3d19x6iP9Ox1O0SHV806qSrLQ/9AqoOW4b+Zum
 IXsOyl5I19Y7TDya+dNno5JPep7YmVxgTFUVyupJU/Szdw/0sN52s8m6whwC9IrhYtpIxxc//w3
 tw4z/GXsmPFeNuz51JuQHHyCjJ7kkd2TeEd4D1zmEJYn34uyMd7nmRXCWrmBENCDU=
X-Received: by 2002:ac2:4bc1:0:b0:5ae:bb1d:ce35 with SMTP id
 2adb3069b0e04-5aecf4a5352mr3470224e87.3.1783341434689; 
 Mon, 06 Jul 2026 05:37:14 -0700 (PDT)
Received: from [172.18.183.38] (ip-185-104-138-126.ptr.icomera.net.
 [185.104.138.126]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c3a15sm2817394e87.68.2026.07.06.05.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 05:37:14 -0700 (PDT)
Message-ID: <ac9f896e-1264-4052-a300-b0b95f7e79ae@linaro.org>
Date: Mon, 6 Jul 2026 14:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Michael Srba <Michael.Srba@seznam.cz>,
 Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
 <20260619-snagboot-v4-5-385497442db2@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260619-snagboot-v4-5-385497442db2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


> Changes in v4:
> - Removed QCOM_COMMAND_DB_OPTIONAL as now we use

...


diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index cdd9e30f43e..987719bb925 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig

> +config QCOM_COMMAND_DB_OPTIONAL
> +	bool "Allow operation without Command DB data"
