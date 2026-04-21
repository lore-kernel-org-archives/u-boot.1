Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A67F94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 23:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDA683FED;
	Wed, 22 Apr 2026 01:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S8tK1wt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF7B83E76; Wed, 22 Apr 2026 01:11:36 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D5383AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-506aa68065eso36697151cf.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776813093; x=1777417893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XaHM5hYcQexH2mtTPE60/prTDCciNZbxd32IXaHU0UQ=;
 b=S8tK1wt2XYgEPvg87IIYusSOxnp5r+FJfHp1hk+OJWiiY8BNqC19DgTXBapZqBS+Iq
 dJa2qTZoXPYabNhN4xb7LGGnZDQW83qPA4hIoG0vQmY0vznIP7BQJMcJoKk4V7ueoMHg
 o5/eh15EMKmDU3zVPvQysaH8iY/XTKXujaRF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776813093; x=1777417893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaHM5hYcQexH2mtTPE60/prTDCciNZbxd32IXaHU0UQ=;
 b=kJYLKA9bHvmPa2S+1D8ulHuVzna4lG8Wgy0cXsw1jD/Wc2IBhd5HlM53Vt22Ud5kBc
 Hc3PfXz2YH39XmQCE3YKJOmnHt/t/RZaKiRfNGVgormvD+3e7ikKnioPoZligX48cgeT
 tW82QUt8qFQByyi+Weyh5Bsu3Cch22oyU42B1zSciOBtFMrHY2hxYyX2IBLIYoLds9DH
 gpkThxUt2Hm2XLFze5KCCArozVvt5wduA0IbT4Fpl7OxzUphaHuAs01Cu7/LUO9mSJ4X
 kRn9qItZNcFMbla9cLzais80obJckaGPuI1KeCI58z/XbCY21LPASiRdSqfUgED3AzbG
 laew==
X-Gm-Message-State: AOJu0YzqIL+RU249nDYsR63YGPsgXhkueOEWHHSpRlmai8cQl55GfJe5
 LUXuKjLTWFqucsJnaT2ZfwAm1bQi/Zz61ZaPBVJylJMosWfvkgYxoRpn/f8fcMiHEdZY0RJRcMD
 srGYmAg==
X-Gm-Gg: AeBDievh0zW8XJKIlHdXDY9Ysbuz4YWV3/34vXQ71Fhbc/nmVIhoj52jCI/n2HZ6zlv
 xY6opFe7AP8skNdgcfOpZHHQ7av5j2LM0NIUgvWE2j0hoX1Dx+vMQavjBXXKdb3z10ALw9ZgN3P
 sCOAp0dCD+l3Ls1chkC+3PgkjCJ4IPuxYrHJvk8erHHC1MLdkRoptahn7Nwijeh/vis0Elg87A9
 0wj1d2zIpJE6oKW2wPuPUGb94jXNUm1wjue9QN1fu5iRMBXLEHlyJjfKDzLzcL688Dvc4/9X6t/
 UYbd/9LSBwWlL8+jNd/zoe8Jdzk1Q9Nb7oaYpPHeMCdvW3ZvxHdKy9obFwtHA3tiyKWaUOCSSvL
 RsWgqQiN60KhnHwzSBQunrDRcriSBZ/eiL6v5NGB0twddisPDWK8po2MUN76u7Crh47Mr+POOpZ
 fubK95+NlfEV/sgPe9kBpCoxtHMs92
X-Received: by 2002:a05:622a:58c:b0:50b:4778:ac60 with SMTP id
 d75a77b69052e-50e36820d1dmr313332391cf.10.1776813092803; 
 Tue, 21 Apr 2026 16:11:32 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e6123c3d7sm56551551cf.12.2026.04.21.16.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 16:11:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH 0/3] binman: Tidy up some missing bintool docs
Date: Tue, 21 Apr 2026 17:11:15 -0600
Message-ID: <20260421231126.597390-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some of the bintools are missing documentation. This series adds the
missing pieces to bring things up to scratch.


Simon Glass (3):
  binman: Flesh out the p11-kit bintool docstring
  binman: Flesh out the pkcs11-tool bintool docstring
  binman: Flesh out the softhsm2-util bintool docstring

 tools/binman/btool/p11_kit.py       | 10 +++++++++-
 tools/binman/btool/pkcs11_tool.py   | 10 +++++++++-
 tools/binman/btool/softhsm2_util.py | 11 ++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

---
base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
branch: binj-us

-- 
2.43.0

