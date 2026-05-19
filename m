Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0B6CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE534848C5;
	Tue, 19 May 2026 18:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EvS0akxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9395B848BD; Tue, 19 May 2026 18:08:43 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C748B848B9
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso32521485e9.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779206920; x=1779811720; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=doHqjqcR40FiaavIeeMMihwS3Z6fBkigGIs7hMGPDeY=;
 b=EvS0akxHwy3rUMEM4Yo5BEucryQyBf1JLfz5/7PxECGzO6KB/XoXe8JKm2iDdvJBgV
 5OEXJb9ZPNWyF30V3Ir5Pn3Khm6BKOPxuHvSEIGpkA1siuOkpFXM9TNxmT6E0PSCpCsA
 lND72MphdiWjsRlnZP0AfX7gIddgK3BnhhoKbE/FRv0ukJ9RbvvsUmn5GfSNaaJEZtnM
 ycLO/6wb6i8o+I0dcZ0u6CFjP/LK26+yA97kKBv2Eexsx1+ocryAzA/XpQkFSj23gm5e
 kYXfS55Zl1E1T2fTBjqIEoHqf4JUP6OPHSuSgBcLFD5M1chQ3e70Znw1D92umItPiVOE
 OY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206920; x=1779811720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=doHqjqcR40FiaavIeeMMihwS3Z6fBkigGIs7hMGPDeY=;
 b=CyLQQVzUIQWkVkE2r5zlI9zDvnVifR6ICfE8uFqsiwquNV5ZUtkChiZpJ3DLKIwQpP
 TGWfFzqRfeG6+f6HAs5e9Fl2B+x3JmgzUqw4GbsxsNuPFfTYPTj8+K/twXji1yJ6Dvkt
 CXlpMaZaNKDGxebUUXg31DLxbOpWRmcT13TDstK1gv77cfZRIwxTNeIe0rfDroK6Mm/K
 5lPtFQvU9+FQFojlme9GHPs6RgmtC4pIh21rIIjV2jgqBoLON8VIa1dv+iCGmv7K8kbF
 SaexAPINl2Fa1EzxXhy5HAzRAGYHEBJVhDr+Ulx6oSGv6m4Fu0Rug0h9h9k4kRZlXi4M
 L54Q==
X-Gm-Message-State: AOJu0YzEnFo3/VqNHZvHUQUM9X2ytzCmbzzG7ALeQph39AGEQS0XTNId
 sElL9zq3Kcuxa0rc0pwUB/59COrlWByn3NItCORTqnI7Hym2UZ9FsZWVDFHWxDKMUtQ=
X-Gm-Gg: Acq92OGD3yGJEAdpOrmokAvdN3y1PH7sYHqwHDZZTK4tsdfPQWm0mq0eeqRaAsaJQ3+
 vSdtRyKlo+hI4dyZenGiKQRr5sDhviTafIA2PnNxHzssxt6IKXewopW7VtHBmM75CZu7KYMgzHm
 kEIZcfCtJQ7nVidamfJfY/dQEkN7K15lhdugxh2mRVy2R+jdW7txp3mFfTNMvo9OCq9ZUE/xSEf
 yWDcrX+PANW4zjRaiqWdtTdvEIfx88nyDy3XxKnP3b5IR629KOO1T52ymOjAh6gWjhbc1nyTjM5
 Kb5KQcp/mXHUAcnZjvdXUlR89jcUEI8n4Wv32Er1HqU9LCX2IQDbTuy1nlxFhc1sBecZ54k9Z51
 ulMtn6U+EcwS7JvkT52je51eMN3X+Meop7oDTCUummIu7qHS64Wan+wq2sfdIax9/EpbPs03D1x
 ROLH1WIzNULudbfLAg+PRsTgAdsWo2Hl+Cz8F/zuA24go/
X-Received: by 2002:a05:600c:314f:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-49006db5bc0mr178979785e9.17.1779206920027; 
 Tue, 19 May 2026 09:08:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3ac86sm46328282f8f.14.2026.05.19.09.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 May 2026 18:08:35 +0200
Subject: [PATCH 2/2] MAINTAINERS: Add myself as core PCI maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-u-boot-pci-nvme-maintainer-v1-2-363593cbbfdc@linaro.org>
References: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
In-Reply-To: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=800;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RxRpx9Z2bQn3/J+vsmg/Juu7njBYa7UqAGJOBffaSXA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDIsF/vWVNAmHz8v7WuyC613/HpJSONrTyOFWTplT
 DFtnyHyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagyLBQAKCRB33NvayMhJ0RE8D/
 9M3F5q/21FXrSCoEceOOLWwarqbobMGy4GK2kGR22HHsjie+lLoCsWVD591uJWTl1BYMwqyGHp/Wv3
 AYZytJgQ8AJIwI5Bc9ld3NbXbAugV64EXgmFAVKO4ooFoFlEcAisJKIHJYG+ZfgJ5CTeVNaFlf/6Z5
 IeXip3wQX+YZvMgKgo81e/KCnO6V9yYy1lsvrA2RX5iajoHQtS27VrR+LR71BHlrC7+sN0hvOK7DTp
 A8j5hxQUHm/d/Tq6imHHGbpxXqCGvIUj79eqit59UunWxv+8az4+UfJil/QBJOCg337/m0+4ZW8wtT
 duYKISrwYaN9AXQvCXCd9QTG/7PQVcol8gFxnUAxbdCzB50dD5sc8Ywhb7yt5Z/o7panSry0aEJXdy
 oNrBeztIvmwrmdFiw2odwLG3WoNmJPLz6qY6YBqnVVYS+qWmu0yZb0GR9eaBKxRKMnBF1YbsgOYUcY
 UTePvNDa9qPDvMKZMrxzeRyGo0kbO7MaAQ6UxsQsbhcPwQRXnXjkRkNow3/eYhIXZPJ0qldiQlpqTc
 yhOlI+b3bZNtl/jb2C/FSa91pVkw+N8hKXbEK3rz1Gn9VaJR9sBjspeGC1bbKPMqFIzOmGLy94gdJU
 QNlGTYCCPfYbhjG+AEOmq4D6QoCykkx25J/Ezcy12pvBfAMjPCM1jSvUQmWw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Adding an entry for the PCI subsystem and add myself to the list
of maintainers to review patches and maintain the PCI subsystem core
along the ongoing work of the PCI platform maintainers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2613929cdf5..de7c16db131 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1558,6 +1558,16 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	tools/patman/
 
+PCI
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+F:	cmd/pci.c
+F:	drivers/pci
+F:	include/pci.h
+F:	include/pci_ids.h
+F:	test/dm/pci.c
+N:	pci
+
 PCIe DWC IMX
 M:	Sumit Garg <sumit.garg@kernel.org>
 S:	Maintained

-- 
2.34.1

