Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012A2C28B30
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A751808B6;
	Wed, 26 Mar 2025 06:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="yG3+VQ5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F6028192A; Tue, 25 Mar 2025 16:37:32 +0100 (CET)
Received: from out162-62-58-69.mail.qq.com (out162-62-58-69.mail.qq.com
 [162.62.58.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C75810E8
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 16:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=423756212@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1742917046; bh=l23Eh6DiYzu9HoDvZbmwH/45ZKAZC1QxzIgnTM0gHrE=;
 h=From:To:Cc:Subject:Date:References:In-Reply-To;
 b=yG3+VQ5dL2gXlxWJlnfhwT49tgnsRVnnkbry1IveRN8vztcUwLASAMeTjvOqrsSxr
 DOEZe7sdNFQDGkAJT4Ds9gOC6QCdK+UKrDr7swtO5bViS9/QRRzF8nRJgFfZbBMCbG
 1e2cpmIUkTNoZ/kY7dT0Rm8NWegsPMiyAhBR7JV4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-XMAILINFO: NnA3IMNPwBd+P8GWekO8oHlQMsAbXCMDz2/TdcmYqxna8ZSzFmDVh8KIoT0hJV
 F4KLzqS5g0hQXt6iEEvY4sxzz0qFg1BYa2cKf3KNnT+4RKFfL2TB1tmIaQ2km0xB2vgLt6lbp3CnS
 oizJuBZLY+ZN9GbCmiju/d47tzHrI0RfqrdKGp7ifpCkqY32oRTPKKS7cNkV2qsSBH9JJgp4iY7dI
 D3Z3aQV66zzyJe1Yj67HSP3aKpaZM2KOVbKMCWHeK9+1exrO9Jl/W8wJbDJGTQJXl52kroNV5inAU
 fR7XvKec8F5zDpMjhGlXzWXI1R1AITH2+ZLQiv+5W9be08ihUmXsUpDgYJIwB3wXfh5IUEGrzPahF
 WonmB/5DNnZh+V3DTyPeNuEINXVxqjLhN7rdkNofHYnDd7tBU5wN86HtLCsudT5MtPLXf4Na2GnUN
 FciU9Wv9vifWnS6UkOyMgpMe/kpnUd7Rvj1dYmKrzMnc66MEnjP/1i9ZQFQX5F1V81FCQsTDBuN+Q
 Eo7q3psEiIUHVhPNI5Zl+EpQii8hPa3qMKB865omjZZ0ODL1XkulPaq1SfKMRUvN7Lk8QoR6VBGS2
 pz0HtAFoCfDgPi3ax0kUfEe4NCRXXEKBKekTdz7k1mlc5MclIM7XO7blsNJG18j1FgBaNxX/ryE2B
 fWBakVhM/8SaJaEf6C8ZFIxqyZDySuf7S/VQe4aZdSinmw1ECrpQb8yt47KqBuJgvmGqzk/uQhIWd
 IAl4GVGACRHAzk/+5oph0qC1u7UpUrGOTUSpgvglFW+/UOLCxK+BdYBARjOMiQZeLMOQx4aBA22Lm
 u6sXS3KK5C8bysp25M/YJlfuzhVJVpj0hqpTaZeHAQzedVSIs2rd3kydacl1VOwTp3h89zutSvkmo
 RXs/mj4+hkhCtfN2qM8b/klIkGpYLdKdmJiYToMPG4UP0JopYnop5PpCAU1J/kHe7hAFAJJwMFdEd
 TB5YvKGaL1W0A/cRLftdsNjqL3DJ0o8U+j5BpP/AsLwxWPcMeoBEkumMK+tLE=
From: "=?utf-8?B?MC4w?=" <423756212@qq.com>
To: "=?utf-8?B?dS1ib290?=" <u-boot@lists.denx.de>
Cc: "=?utf-8?B?UGF0cmljayBSdWRvbHBo?=" <patrick.rudolph@9elements.com>,
 "=?utf-8?B?U2ltb24gR2xhc3M=?=" <sjg@chromium.org>,
 "=?utf-8?B?VG9tIFJpbmk=?=" <trini@konsulko.com>
Subject: [PATCH] armv8: start.S: Subordinate CPUs psci setup vector
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 25 Mar 2025 23:37:25 +0800
X-Priority: 3
Message-ID: <tencent_AF9EB8E8B7E27ECFACE1C930F11E1424CA09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_2E204F13F4367132679AF08898030F6E1208@qq.com>
In-Reply-To: <tencent_2E204F13F4367132679AF08898030F6E1208@qq.com>
X-QQ-mid: xmsezb20-1t1742917045tzjdk561q
X-Mailman-Approved-At: Wed, 26 Mar 2025 06:01:30 +0100
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

QXMmbmJzcDtjdXJyZW50Jm5ic3A7ZGVzaWduLCZuYnNwO29ubHkmbmJzcDtNYW5hZ2VyJm5i
c3A7Q1BVJm5ic3A7Y2FsbGVkJm5ic3A7YXJtdjhfc2V0dXBfcHNjaSgpJm5ic3A7YmVmb3Jl
PGJyLz5qdW1wJm5ic3A7dG8mbmJzcDtuZXh0Jm5ic3A7c3RhZ2Uoc3VjaCZuYnNwO2FzJm5i
c3A7TGludXgmbmJzcDtLZXJuZWwpLCZuYnNwO1N1Ym9yZGluYXRlJm5ic3A7Q1BVcyZuYnNw
O2Fsc28mbmJzcDtuZWVkPGJyLz5zZXR1cCZuYnNwO3BzY2kmbmJzcDt2ZWN0b3ImbmJzcDt0
byZuYnNwO2hhbmRsZSZuYnNwO3RyYXAmbmJzcDtyZXF1ZXN0Jm5ic3A7d2hpY2gmbmJzcDtj
b21lcyZuYnNwO2Zyb20mbmJzcDtoaWdoZXImbmJzcDtFTDxici8+bGV2ZWwuPGJyLz48YnIv
PlNpZ25lZC1vZmYtYnk6Jm5ic3A7eHhmb3JlJm5ic3A7Jmx0OzQyMzc1NjIxMkBxcS5jb20m
Z3Q7PGJyLz4tLS08YnIvPjxici8+YXJjaC9hcm0vY3B1L2FybXY4L3N0YXJ0LlMmbmJzcDt8
Jm5ic3A7MyZuYnNwOysrKzxici8+MSZuYnNwO2ZpbGUmbmJzcDtjaGFuZ2VkLCZuYnNwOzMm
bmJzcDtpbnNlcnRpb25zKCspPGJyLz48YnIvPmRpZmYmbmJzcDstLWdpdCZuYnNwO2EvYXJj
aC9hcm0vY3B1L2FybXY4L3N0YXJ0LlMmbmJzcDtiL2FyY2gvYXJtL2NwdS9hcm12OC9zdGFy
dC5TPGJyLz5pbmRleCZuYnNwO2QzYThhN2M0Nzg3Li5jNzg3MmU5MzVlOSZuYnNwOzEwMDY0
NDxici8+LS0tJm5ic3A7YS9hcmNoL2FybS9jcHUvYXJtdjgvc3RhcnQuUzxici8+KysrJm5i
c3A7Yi9hcmNoL2FybS9jcHUvYXJtdjgvc3RhcnQuUzxici8+QEAmbmJzcDstMzM0LDYmbmJz
cDsrMzM0LDkmbmJzcDtAQCZuYnNwO1dFQUsobG93bGV2ZWxfaW5pdCk8YnIvPgkvKjxici8+
CSZuYnNwOyombmJzcDtBbGwmbmJzcDtzbGF2ZXMmbmJzcDt3aWxsJm5ic3A7ZW50ZXImbmJz
cDtFTDImbmJzcDthbmQmbmJzcDtvcHRpb25hbGx5Jm5ic3A7RUwxLjxici8+CSZuYnNwOyov
PGJyLz4rI2lmJm5ic3A7ZGVmaW5lZChDT05GSUdfQVJNVjhfUFNDSSk8YnIvPismbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtibCZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3BzY2lfc2V0dXBfdmVjdG9yczxici8+KyNlbmRp
Zjxici8+CWFkcgl4NCwmbmJzcDtsb3dsZXZlbF9pbl9lbDI8YnIvPglsZHIJeDUsJm5ic3A7
PUVTX1RPX0FBUkNINjQ8YnIvPglibAlhcm12OF9zd2l0Y2hfdG9fZWwyPGJyLz4tLTxici8+
Mi4yMC4xPGJyLz48YnIvPjxici8+

