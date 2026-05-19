Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA7CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F338848BB;
	Tue, 19 May 2026 18:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cr4CqGW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23246846CC; Tue, 19 May 2026 18:08:42 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB57F84870
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so2376839f8f.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779206919; x=1779811719; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9cCYipKfCdf1mZheKN9n8fBxFiSBu46LHaX4t6z+ye8=;
 b=cr4CqGW0c5Px6GHedtWhtOnzcmiJ7pXTrTTlVQbNXoUYyzcQZvtkMjh1XU1DcRa2jB
 NsCkA/AIyCmmazDoZ67KnZNN7/O5VbNJKQRGbErnypYb5eu8r3f0ftmJDUGMGoCc9wzO
 5dbDA/8KdBcJLhLYNeGbXhOWaEPJO0IYzZqGzkHyxHWsDrH1BmPjDXRg+5z2zbFwa3SA
 IvBRYA/iQ8lLWsqeIMNF+cf69c1eiRVbnYYguC2LoFSkh+6k7X6NtWTCs3G2FtUprdLO
 GRLlHUdU4ZDrpACg8dksSlZY1iLuTWny+YitfTV1GYDyQhnsVx+PuUcdq0S/lzJNhy0L
 o0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206919; x=1779811719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9cCYipKfCdf1mZheKN9n8fBxFiSBu46LHaX4t6z+ye8=;
 b=LWHIFXjQyHgtZ/K+Ahr0n5vcC9wcxl7bMbmXVuzUJmZHJVM8tgsvHSU5yROFvzK3rP
 D2/bL6AXPaYNm83U/orc5HjC6qQcv7FfU2ra5kcgSiB8B285Y36d8NUF3quAcHLsx4I2
 DnNNxHTTMFZoS1XWzMkYE99b13/AAhG77i2fGVx5t3BXBku8fJIEqzbl5flzuigO/NAR
 bX+J2JJ+Db4VrQ/JkXNXzd2+Jd67+JLMHQxbrE5fZaaPhNVq/cDHbX6f206pUW0wGILM
 yRp6ozeO5QR9TnoIpimV5aGGDuc1I8fkJQ8SbWdpD7fLwBnUAV8Q8Fs6choIZvAfTvjl
 2s9w==
X-Gm-Message-State: AOJu0YwaWAkKCvTV/anm4lBrXvACYS1jEpEFk9Es0+DyND8WD/YITpos
 IThsZmBTm/CmFJ90U3/pHdkETyptOnbhReEZ+uRN8tyUJ9poOJRpyoZx6GIQUP9t68Y=
X-Gm-Gg: Acq92OGMxDi2LkQtucd55Vd2eSAVPASGZ8a3DlT8W8BWm+MQYaoWCTqrcJFB+po79Rt
 0CShYtcKRI39QPz/HnXGGtSt5OjyeUbrsJMIMc5yAYxKNL+omMV8AUW2lSLh69E6z4VucdiCLkK
 fEUqfo8t+ctNeSV3ftDubQ1yvtNQioH7F/fN60XvbJWxcELpnQ1sISiwAmLMozlZk04He36/h+x
 pa+W5bOkhTVkpc4FCJeWbjcr91HgZv3X5DaHonhTO1u5yr+kEY3nYwtqtAM4KgE65FFa/WHyXxn
 rokRPk3tykFqqRYBxxrlxPrA3/qkgCLDPp4tDHAdO4eCf+/U4+lVyhOXzMotR429WbPY0dwxzPy
 aOcJOziG5GyF33TWOkBapgGTxJWsd+LEoAxm3erOjMW/XqCqajmpOa+ea4p1HZPJOmVJJECBQwp
 oZGDjJOsT9a9atkTZG6/7o7KFi77ABezhC9B/g9I38unPzZQeEKkqiO7E=
X-Received: by 2002:a05:600c:4692:b0:48e:51f8:eb39 with SMTP id
 5b1f17b1804b1-48fe6325746mr330024515e9.28.1779206919226; 
 Tue, 19 May 2026 09:08:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3ac86sm46328282f8f.14.2026.05.19.09.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 May 2026 18:08:34 +0200
Subject: [PATCH 1/2] MAINTAINERS: Add myself to the list of NVMe
 maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-u-boot-pci-nvme-maintainer-v1-1-363593cbbfdc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=569;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VrrMYK6D9ZkkX7uCRpzhpRTXDLReHKFziHtSGgpDqt8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDIsEulU5FlZvzZ+6Yw2+xBMUrcdBIs5kMwbrAQea
 gsCB6/SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagyLBAAKCRB33NvayMhJ0aTlD/
 484/h8vp1g3LlC1XUWsqcCHUv+vfCAYipisanmdK0EefXR/lR23MEReZ+kml5i8CyjJy//fEpqyK4u
 pCo3U5vKPdqLZ60zDp87xj/7jWjFaWxjvPo8J4fuPhP1UGSS0ipVbWLgTBLQhdV1hdT9aK9qhmp4sm
 eXe+qvTLIEmnhcIdlT9j1DrGP28y8WqerV3bqMIrmAczk+JaYZaI0boxlmyQuauKq3g37aIMPtL1ez
 1vJbXZquoxeBLy0qbybAbZ/QDgRk8atBrD2t00GEHo6ekoQLYgExLIprPzBVse9vTaDPseQWinZj22
 SOFIirwDVWIsYELS4SDQdPotYxXQ0TavxSlTYw+N1zNLjWWRLlIUesgoPq+3Xe9fTxlksFqq6Vo1F8
 vzdMTBMoKqLUo7lA4k5+oUaWe3JD++29nf2Y6TWEmvKz065OF+MvP0N5ID5BNtTw82Gx4tglDudRkP
 oVkEdbXlQ/EFsR1Cf2yY6IehvikVYcFqn44yJSyyQsISXz3k4ifXWV+Nt7RXaF/Yko+L2RDuMgXvB+
 hC8MiP5s6/Nuyx8wgcK65+H8sEfNGjHCAql0i8poqbqeYiJQQ1pkGC7vmqU/YXRxLo3FrVl2mpiE0o
 ic7A0rX4rMNZUQGNrOHyp6ZCpbK7fELB18ZVL8J6JkFa/0mVRuGu/o5VUxZQ==
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

Adding myself to continue Bin's work to help maintain the
NVMe support in U-boot.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea646f618a5..2613929cdf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1506,6 +1506,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-nios.git
 F:	arch/nios2/
 
 NVMe
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	drivers/nvme/

-- 
2.34.1

