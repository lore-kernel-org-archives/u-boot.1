Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A5216072A;
	Mon, 12 Oct 2026 05:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lg7jIn6s9RBe; Mon, 12 Oct 2026 05:37:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3119060725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783424;
	b=Mi3rY51HqR5oKCp+OqRjvuTkcjkwNz5R/nEEYQypuZTbJZotOnO7ENpfB9zoIx/7eJ3K
	 b8kfboMWf7K5fcB2E9P+lt4vDsiLM9ookOlDXXkVcjnJgzeCo7NBlv1ioOxYBHPpXELv4
	 yYXixSiGrgUdEJpawHAx9idxOCWkjmt3r65dSIWs684QTMPOJXB5dsiugv6nrHeG6jfrg
	 /+wO5XEp4qtzu0JDq+MVRiErQ3bW+U3Dz7S/wuXWsRiAyajr71vuhIpfBgA25JOI7gQte
	 aUTiAjVQU6QTOsyXi3K/vTaffcq3N0JZJACFaqW6dvpEhmAGD5rFkLiLAneO6+/3fBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IqW3mUt6LZ1xiZFe8gtBfTAkf0JnmmUIMSoIjw3MIjw=;
	b=hTqfAAb3eMHnMLzXMrZToOd16bdMwQ15Hg1URidcfRMGEWYalNvVvobzdyLQ6fLkR5yy
	 /zPlhaKWGj+xaSHkwKrqvrYfg15MmHUqASBL2jWYaFNPMqdmfsR8lGgStq+brurMsgjul
	 1PNag4wBUvBZmMZ1ptcJlH6Dl5r4IWcxa+U3nM6HdYesIs+7TyyTYV9hJhEYF/QD9lIZa
	 YP9ze8ebWlBN3LjLsVQgQ1ufgX7IEGkgEwpdg2NpBr66CFg/GYiHyhmTyk54O6hrbvfcL
	 u7q5obFDxjHaRC2iH10oe/qoka2rQL/M8j5s51XdhBNrVAEbDLEY+4iVRE22qmGowfg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783424;
	bh=IqW3mUt6LZ1xiZFe8gtBfTAkf0JnmmUIMSoIjw3MIjw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ssJaBj0+pqfjTJmtoc13FRMfYye/8tYyft31QnFLWnEnpfSTffjYgJqWuvI2EAu39
	 SpmBKGsNqfd2nYa49fhu+I4DWQIea6q/rxsmLBRzKvAgJGJA6sEr5q7IIypQyiw74Z
	 QrLa/yxmdIbWaW/noH8rhDPJ1idXRiukpaZ2CrfagInVVasDd8HQYUMDDhpz3Cqsf9
	 JURIJeQwh78L9Wuaed7UThBOAQ2GGdiJR1zBw+qVCEwSRgu8sZ/GqUvGIA/+e/LIs6
	 JQ4tDch6DFqN8XZmDnZxg4W3oHoL2zb9rH1DCLw7uFRo+PSossGehA/jnLSL5aQnUr
	 cSoNghFw9EY9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3119060725;
	Mon, 12 Oct 2026 05:37:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32D2F9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D9BA400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qreQL8AaQxiX for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 04:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CAC254002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791779256;
 b=rvBg967Gr+GzLhNVhtlS1dnr0KohDKC6by09oyEf6LhApQ948xtBL6YtBMgHM5pRIHwO
 IQMtPVyozzpOtM+y5yupy41jx3bZi7vV40J++CZS5wFPJD03x3hlyvfoXve9BNPKtTGo9
 t3caY3XRkC62uZq08mVoxe8C2a6VgZocqLAYHRh9Lr7cf+f7Agv74J4B6tOWvHocUyfsR
 n7ZFI/B/CwkuCSQgIdjCq78091JpQaBgbuzjMfN27HOR0mFznrsoH0fRD/GEaQ594EdT0
 OY4wax8W7keWD47zOgAG3BVq7SXKLH1uTGKfXg/BYEcos+Ym6S3NzjlgaHPBNCaq4RQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791779256;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=IqW3mUt6LZ1xiZFe8gtBfTAkf0JnmmUIMSoIjw3MIjw=;
 b=s13EuQ3w9ndTmKFvcqW7l7ldVbD0/Fn0WHeUq8Rpk5zUTe28rfWAVWURAnhq2NOm6/LP
 TEXftvsaz5YGn18bkoK+i0gWKV4K/HzWHVBK2b2rMkJ78TCfiK4NNbqPjm7GbLfkcmagV
 txgakJq2NEgkm+laKZ7GtyvlR2kTpBmdu9QvG6r21tHdxxTYyPfBVhnkLpNMAZPRgBKQO
 r5F4ej721pp1dYCvDXc4KUJZitKVNd9lA6fpg1lB7Es/MKm+B3MVDxpK621bzVch0i1P2
 tF6irbDdvy6nYRLyPBAUqd9d1X+ohYWSF/inyDfq5+VdY0p3UceAOTF6BP8Ikqw6ymg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=zohomail.com;
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b="Rx4/rJdH"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Rx4/rJdH
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CAC254002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791779216; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eNRXiRA08e2gpA+is9gjq0Zla7rPSAbLRxucDcnkr1mQ4uSf5vfiO4janwVlfE5TxzGaIH7llE6N6OiKhTBvDvRim2ddWmk2vRjfAlqdiuJbRAouUxrlQz0ZW5fhbl+OqwCWSodI+EymKR7L4ceHw7/9xFWvdxwKBNOafo3qUsc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791779216;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IqW3mUt6LZ1xiZFe8gtBfTAkf0JnmmUIMSoIjw3MIjw=; 
 b=JtPrp5sRqXEgr3RG5FxnhkBC6cVYKEyT3k5UjsFiYKcYljSam5eXzaMjYLuLpPFOtpazJmNMThU0G8ox9DCF1OVBJGWcJmJgW90lmz8uYm64B8R8xmyrpv4DygHm97BPSzFSIMTuutAANu4huAUZb6PnaeNrHfQFpIRvBjChpqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791779216; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=IqW3mUt6LZ1xiZFe8gtBfTAkf0JnmmUIMSoIjw3MIjw=;
 b=Rx4/rJdH9qwHwNtQPyJrwVBl63x6VhIkFSte4odrytbuyQRnFMxcolHx7KRDqjzY
 ox1IX4hkHXDJnDssecf5XAfW7WZeS+ODHHJzXSkOTzWK0w9qFJuPyt80RAZnV66tCG/
 gJC6bt+Lj1NtRC1VTBw1enxeWzvzQGMDSr/GdYZ8=
Received: by smtp.zohomail.com with SMTPS id 1791779213747739.4745869432754;
 Sun, 11 Oct 2026 21:26:53 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: [PATCH v5 0/3] rtc: cv1800b: Use the RTC node for time and system
 reset
Date: Mon, 12 Oct 2026 11:47:32 +0800
Message-Id: <20261012-cv18xx-rtc-sysreset-v5-0-413de1605cb4@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12RwU4cQQxEf2U154zUdttum1+JOLS73WEiAWFnQ
 Rsh/j29kMtwc0l+ZavqfdnjvMW+3J3el3O8bfv2/DQF/zgt7aE+/Yp161MvmFCSoa3tDfR6Xc+
 Xtu5/93PscVldQUJykky6TPLPOcZ2/XT9ef+l91f/He1ys/q/cY6X13nu8rW2eN1jbc+Pj9vl7
 lSThFr1xFErumaizggZLJvlnFsvkmrwp1W9tIf55d3JNUSBM5AXVagJe6QkghlVbgbYqKK0I5X
 6gFG5Ozj6GJTQCU2TFROv3awyFNJ8pMgCQlFyG6myV+1zVGdTl6zYejAqOR4pld5ziqI0EuIki
 7sMH4DcTMxIChTp9P1WKqnNLNpgzRmiMcyvSgdXHOq3gLiqHSlxmSEEcWvSQ5io1kqcrDuCAAD
 roFHhSBUwBSydJGGEAyFg0tLC5qdGXSkKVPqWYa6s3nXWBiWVMbC4ctZOaqXHyDMX7i3LkbLEs
 18j8JIjc78FykVLL9Eq0BgtZqXqR4qZGpCW0M4ms2AzKaVV1YipEBzG8BrL/cfHP9WUy6nfAgA
 A
X-Change-ID: 20260929-cv18xx-rtc-sysreset-b816e6306348
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112274d71660af2f42dedb12edd110000eb6915a8411b85b93e38cb7357e51c6569d49ac3b267fac55e:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 12 Oct 2026 05:36:56 +0000
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

The CV1800B RTC subsystem contains a seconds counter and system reset
controls in a shared register range. U-Boot currently binds the system
reset driver from Milk-V Duo board code and accesses fixed MMIO addresses.
The upstream devicetrees describe this subsystem with an RTC node, but
U-Boot has no driver matching that node.

Add an RTC driver for the seconds counter, bind the existing system reset
driver as its child, and obtain the reset register range from the shared
devicetree node. Keep the existing reset requests unchanged, including
the warm-reset sequence currently used for SYSRESET_COLD.

This series depends on the CV18xx upstream-devicetree conversion sent
as v5.

Tested on Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
Changes in v5:
- Keep the existing sysreset register macro names to minimize the diff.
- Link to v4: https://patch.msgid.link/20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com

Changes in v4:
- Add Jingbao Qiu's copyright attribution to the RTC driver.
- Keep the RTC clock handle local to probe().
- Simplify MMIO regmap accesses in the RTC and sysreset paths.
- Link to v3: https://patch.msgid.link/20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com

Changes in v3:
- Rename the RTC driver file to cv1800b.c to match the RTC directory
  convention.
- Align the CV1800B sysreset register and request-bit definitions.
- Use uppercase hexadecimal digits in the sysreset driver.
- Link to v2: https://patch.msgid.link/20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com

Changes in v2:
- Use CV1800B consistently in the RTC driver filename and identifiers.
- Link to v1: https://patch.msgid.link/20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com

---
Zhuxu Ran (3):
      rtc: cv1800b: Add seconds counter support
      riscv: sophgo: Enable RTC-backed system reset
      sysreset: cv1800b: Use the RTC device node for register access

 board/sophgo/milkv_duo/board.c         |   5 --
 configs/milkv_duo_256m_defconfig       |   2 +
 configs/milkv_duo_defconfig            |   2 +
 configs/sipeed_licheerv_nano_defconfig |   2 +
 drivers/rtc/Kconfig                    |   9 +++
 drivers/rtc/Makefile                   |   1 +
 drivers/rtc/cv1800b.c                  | 110 +++++++++++++++++++++++++++++++++
 drivers/sysreset/Kconfig               |   6 +-
 drivers/sysreset/sysreset_cv1800b.c    |  72 ++++++++++++---------
 9 files changed, 172 insertions(+), 37 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260929-cv18xx-rtc-sysreset-b816e6306348
prerequisite-message-id: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae

Best regards,
--  
Zhuxu Ran <zhuxu_ran@zohomail.com>
